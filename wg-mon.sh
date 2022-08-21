#!/bin/bash
#/home/user/wg-mon.sh
#Create a crontab entry under root. Your /etc/wiregaurd directory shoud be protected.
# */5 * * * * /home/user/mon-wg.sh
#This entry will run the script every 5 mins. 
#You will need to have sendmail Installed
T=$(date +%s)
H='wg show [replace_with_interface_name] latest-handshakes'
A=$($H | sed 's/[Add_Peer_Pub_Key]=[[:space:]]//')
# subtract last handshake time from current time
COUNT=$(echo "$T - $A"|bc)
# compare seconds since last handshake. The WG handshake is every 2 min.
if [[ $COUNT -ge 120 ]];

then
# send an email. Use value from alert.txt for message body
sendmail me@example.com < /home/[user]/alert.txt;
fi
# log that you ran. This is for trouble shooting and can be commented out once working.
DATE=$(date)
echo "$DATE :: Handshake was $COUNT seconds ago" >> /home/[user]/mon.log
