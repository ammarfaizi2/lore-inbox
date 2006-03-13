Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751605AbWCMRQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbWCMRQU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 12:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWCMRQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 12:16:19 -0500
Received: from mail.infrasupportetc.com ([66.173.97.5]:12344 "EHLO
	mail733.InfraSupportEtc.com") by vger.kernel.org with ESMTP
	id S1751487AbWCMRQS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 12:16:18 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Router stops routing after changing MAC Address
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 13 Mar 2006 11:17:27 -0600
Message-ID: <925A849792280C4E80C5461017A4B8A20321F2@mail733.InfraSupportEtc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Router stops routing after changing MAC Address
Thread-Index: AcZGZbuIgE5RK3NCRkqsrozI2U8N0QAL8JHwAAlcttA=
From: "Greg Scott" <GregScott@InfraSupportEtc.com>
To: "Chuck Ebbert" <76306.1226@compuserve.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
       "Bart Samwel" <bart@samwel.tk>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Simon Mackinlay" <smackinlay@mail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HOT DOGGIES!!!!!!!!!!

I think Chuck found the problem.  It turns out that the OUI portion of
the MAC Address - those leftmost 6 hex digits that identify the vendor -
do also have some other special meaning built in.  Chuck, I am indebted
to you and the list.  If the second hex digit is odd, this means the
high-order bit of the OUI is set and that means it's a multicast
address.  I think I have my bits right.  Here is an excerpt from
http://www.iana.org/assignments/ethernet-numbers.  

> These addresses are physical station addresses, not multicast nor
> broadcast, so the second hex digit (reading from the left) will be
> even, not odd.

There are also other sources describing how the bits are arranged and
how we display MAC Addresses.  Google is our friend.  

Anyway, one of my fudged MAC Addresses had an odd number in that second
hex digit - and that's why the router did not route.  The solution -
just make sure my fudged MAC Addresses are real unicast MAC Addresses
and not multicast addresses.  

Here is my modified ip-fudge-mac.sh script - note that I also turned
rp_filter back on:


[root@test-fw2 gregs]# more ip-fudge-mac.sh
/sbin/ip link set eth0 down
/sbin/ip link set eth0 address 12:34:56:00:30:50
/sbin/ip link set eth0 up

/sbin/ip link set eth1 down
/sbin/ip link set eth1 address 12:34:56:01:60:03
/sbin/ip link set eth1 up

echo "1" > /proc/sys/net/ipv4/ip_forward
echo "1" > /proc/sys/net/ipv4/conf/eth0/rp_filter
echo "1" > /proc/sys/net/ipv4/conf/eth1/rp_filter


##6: eth0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 1000
##    link/ether 00:10:4b:71:20:60 brd ff:ff:ff:ff:ff:ff
##7: eth1: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 1000
##    link/ether 00:60:97:b6:f9:4a brd ff:ff:ff:ff:ff:ff
[root@test-fw2 gregs]# 


I also learned the IEEE has an easy way for anyone to register their own
OUI.  You fill out a web form and pay $1650 and 7 days later, you're the
proud owner of your own OUI block - with 24 bits to use as you see fit.
If $1650 is too steep, you can pay $550 and buy 12 bits of MAC
Addresses.

For now, I decided to use a fudged OUI of 12-34-56 and then use the
rightmost 2 octets of the IP Address with leading zeros to fill out the
rest of the MAC Address.  I will buy some official numbers from the IEEE
later.  

It is proper to give back when given a gift from the community.  So here
is my failover-monitor.sh script in its state right now.  I will
probably do a few more tweaks before going into production.  The .conf
file referenced defines a bunch of IP Addresses and interface names
specific to this site.  

This little script starts up as a daemon at boot time and sends its
output to a log file.  It polls the heartbeat NIC every 10 seconds.  If
the other end does not respond to a ping, it checks all the other NIC
interfaces.  If no response from the other NICs either, it checks the
gateway - the router to the Internet.  If the gateway DOES respond, then
it assumes the primary role.  After assuming the primary role, it polls
the gateway every 10 seconds.  If the gatway goes offline, it takes
itself offline and assumes a backup role - polling every 10 seconds to
determine if it should take control again.  This hopefully minimizes the
probability that both members of the failover pair will try to take
control and that both will assume a backup role with nobody taking
control.    But I may have to tweak the algorithm a bit more after more
testing.  

- Greg Scott



#!/bin/bash
# failover-monitor.sh
# First find out if this node or its partner should be primary by 
# checking the flag file.  If the file exists then this node thinks
# it is supposed to be primary, so take control if its partner is 
# unreachable on all interfaces.
# If the flag file does not exist then assume a backup role. 
# Poll its partner.  If its parter is offline then take control.
# If its partner is online then sleep for a few seconds and repeat.  
#
# Greg Scott, March 8, 2006

.  /firewall-scripts/rcfirewall.conf

#
# Figure out who we are
#

if [ $(hostname) = $FW1_HOST ]
then
    ME_HOST=$FW1_HOST
    ME_HBEAT=$FW1_HBEAT
    ME_INET=$FW1_INET
    ME_INETMAC=$FW1_INETMAC
    ME_TRUSTED=$FW1_TRUSTED
    ME_TRUSTEDMAC=$FW1_TRUSTEDMAC
    YOU_HOST=$FW2_HOST
    YOU_HBEAT=$FW2_HBEAT
    YOU_INET=$FW2_INET
    YOU_TRUSTED=$FW2_TRUSTED
else
    ME_HOST=$FW2_HOST
    ME_HBEAT=$FW2_HBEAT
    ME_INET=$FW2_INET
    ME_INETMAC=$FW2_INETMAC
    ME_TRUSTED=$FW2_TRUSTED
    ME_TRUSTEDMAC=$FW2_TRUSTEDMAC
    YOU_HOST=$FW1_HOST
    YOU_HBEAT=$FW1_HBEAT
    YOU_INET=$FW1_INET
    YOU_TRUSTED=$FW1_TRUSTED
fi

function take_control {
# This function is called when the failover partner does not reply
# on the YOU_HBEAT IP Address.  
# 
# Take over the firewall IP address and special MAC address iff:
# This node, "ME", can see the Internet gateway and YOU_TRUSTED
# and INET_IP do not answer.  Remember that INET_IP is the
# IP Address of the primary firewall.  That is why we test 
# for INET_IP and not YOU_INET.  

    echo "Investigating taking control"

    #
    # Ping our partner's other interfaces and the gateway and check
    # the status codes. Status of 0 is success.  1 is no reply, 2 is
    # any other error.  See ping man pages.
    #

    echo "Checking to see if $YOU_HOST answers on its other interfaces"

    ST=0

    ping -c 1 -q -w 3 $INET_IP &> /dev/nl
    ST=$?
    # Ping INET_IP instead of YOU_INET INET_IP because INET_IP is the
    # primary IP Address.
    if [ $ST = 0 ] 
    then 
	echo "$YOU_HOST is alive on $INET_IP.  Not assuming primary
role."
	ST=$YOU_PARTONLINE
    else
	echo "$YOU_HOST does not answer on $INET_IP"
	ping -c 1 -q -w 3 $YOU_TRUSTED &> /dev/nl
	ST=$?
	if [ $ST = 0 ]
	then
	    echo "$YOU_HOST is alive on $YOU_TRUSTED.  Not assuming
primary role."
	    ST=$YOU_PARTONLINE
	else
	    echo "$YOU_HOST does not answer on $YOU_TRUSTED"
	    ping -c 1 -q -w 3 $GATEWAY_IP &> /dev/nl
	    ST=$?
	    if [ $ST != 0 ]
	    then
		echo "Gateway at $GATEWAY_IP does not answer.  Not
assuming primary role."
	    else
		echo "I see gateway $GATEWAY_IP."
		echo "$(date) $ME_HOST Assuming primary firewall role"
		assume_primary
		echo "$(date) $ME_HOST relinquished primary firewall
role."
	    fi
	fi
    fi

    return $ST
}

function assume_primary {
# Create FLAGFILE noting that this node is primary.
# Set up the IP Addresses on the INET and TRUSTED1 interfaces.
# run rc.firewall.
# Poll GATEWAY_IP periodically.  
# If it does not answer
# then reset all interfaces and firewall rules back to their 
# initial state and return.

echo "$(date) $ME_HOST assuming primary firewall role." >> $FLAGFILE

/sbin/ifdown $INET_IFACE
/sbin/ifconfig $INET_IFACE hw ether $INET_MAC
/sbin/ifconfig $INET_IFACE $INET_IP netmask $INET_NETMASK broadcast
$INET_BCAST_ADDRESS
/sbin/ifup $INET_IFACE

/sbin/ifdown $TRUSTED1_IFACE
/sbin/ifconfig $TRUSTED1_IFACE hw ether $TRUSTED1_MAC
/sbin/ifconfig $TRUSTED1_IFACE $TRUSTED1_IP netmask $TRUSTED1_NETMASK
broadcast $TRUSTED1_BCAST_ADDRESS
/sbin/ifup $TRUSTED1_IFACE

echo "Running rc.firewall"

/firewall-scripts/rc.firewall

#
# So now this node is primary and handling all firewall duties.  Poll
the 
# gateway every 10 seconds and resume a backup role if this node and the
# gateway lose touch with each other.  This is a safety mechanism to
reduce
# the odds that both nodes will try to become primary at the same time.

#

while true ; do

    # echo "$(date) sleeping 10 seconds"
    sleep 10

    # Ping the gateway and check the status code
    ping -c 1 -q -w 3 $GATEWAY_IP &> /dev/nl

    if [ $? != 0 ]
    then
	# We lost contact with the gateway so reset everything
	echo ""
	echo "$(date) The gateway at $GATEWAY_IP appears to be offline."
	# DO NOT remove_flagfile
	# because if the gateway comes back somebody has to take
control.
	reset_interfaces
	break
    fi

done

return 0
}


function reset_interfaces {

echo "Resetting $INET_IFACE to $ME_INET with MAC $ME_INETMAC"
/sbin/ifdown $INET_IFACE
/sbin/ifconfig $INET_IFACE hw ether $ME_INETMAC
/sbin/ifconfig $INET_IFACE $ME_INET netmask $INET_NETMASK broadcast
$INET_BCAST_ADDRESS
/sbin/ifup $INET_IFACE
    
echo "Resetting $TRUSTED1_IFACE to $ME_TRUSTED with MAC $ME_TRUSTEDMAC"
/sbin/ifdown $TRUSTED1_IFACE
/sbin/ifconfig $TRUSTED1_IFACE hw ether $ME_TRUSTEDMAC
/sbin/ifconfig $TRUSTED1_IFACE $ME_TRUSTED netmask $TRUSTED1_NETMASK
broadcast $TRUSTED1_BCAST_ADDRESS
/sbin/ifup $TRUSTED1_IFACE

echo "Resetting to initial firewall rules."
/firewall-scripts/initial_rc.firewall

return 0
}


function remove_flagfile {
echo "$(date) Removing ${FLAGFILE}"
rm -f $FLAGFILE
return 0
}


echo "$(date) starting up failover.sh on $ME_HOST"

echo "Me"
echo "ME_HOST is $ME_HOST"
echo "ME_HBEAT is $ME_HBEAT"
echo "ME_INET is $ME_INET"
echo "ME_TRUSTED is $ME_TRUSTED"

echo
echo "You"
echo "YOU_HOST is $YOU_HOST"
echo "YOU_HBEAT is $YOU_HBEAT"
echo "YOU_INET is $YOU_INET"
echo "YOU_TRUSTED is $YOU_TRUSTED"

echo

reset_interfaces

echo "Initialization complete.  Starting loop"

#
# Initialization is now complete
#

HBEAT_FLG=0

while true ; do

    # echo "$(date) sleeping 10 seconds"
    sleep 10

    if [ -f $FLAGFILE ]
    then
	echo "$FLAGFILE found; attempting to seize control regardless of
heartbeat"
	take_control
	if [ $? != 0 ]
	then
	    echo "Unable to take control; removing $FLAGFILE"
	    remove_flagfile
	fi
    fi

    #
    # Check for heartbeat
    #
    ping -c 1 -q -w 3 $YOU_HBEAT &> /dev/nl
    if [ $? != 0 ]
    then
	HBEAT_FLG=1
	echo "$(date) No heartbeat detected from $YOU_HOST"
	take_control
	continue
    else
	if [ $HBEAT_FLG != 0 ]
	then
	    HBEAT_FLG=0
	    echo "$(date) Heartbeat with $YOU_HOST restored"
	fi
    fi

done

exit 0



-----Original Message-----
From: Chuck Ebbert [mailto:76306.1226@compuserve.com]
Sent: Monday, March 13, 2006 12:11 AM
To: Greg Scott
Cc: linux-kernel; David S. Miller
Subject: Re: Router stops routing after changing MAC Address

In-Reply-To:
<925A849792280C4E80C5461017A4B8A20321CC@mail733.InfraSupportEtc.com>

On Fri, 10 Mar 2006 18:33:15 -0600, Greg Scott wrote:

> How to change MAC addresses is documented well enough - and it works -

> but when I change MAC addresses, my router stops routing.  From the 
> router, I can see the systems on both sides - but the router just 
> refuses to forward packets.  Here are my little test scripts to change

> MAC Addresses.
> 
> First - ip-fudge-mac.sh
> [root@test-fw2 gregs]# more ip-fudge-mac.sh ip link set eth0 down ip 
> link set eth0 address 01:02:03:04:05:06
                            ^
 Bit zero is set, so this is a multicast address.  Is that intentional?

> ip link set eth0 up
> 
> ip link set eth1 down
> ip link set eth1 address 17:20:16:01:60:03
                            ^
 Ditto.

> ip link set eth1 up
> 
> echo "1" > /proc/sys/net/ipv4/ip_forward


--
Chuck
"Penguins don't come from next door, they come from the Antarctic!"

