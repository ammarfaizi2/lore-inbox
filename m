Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbTHaNrX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 09:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbTHaNrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 09:47:22 -0400
Received: from mail2-216.ewetel.de ([212.6.122.116]:16062 "EHLO
	mail2.ewetel.de") by vger.kernel.org with ESMTP id S261963AbTHaNrT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 09:47:19 -0400
Date: Sun, 31 Aug 2003 15:47:17 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: bandwidth for bkbits.net (good news)
In-Reply-To: <20030831013928.GN24409@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0308311543050.993-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Aug 2003, Andrea Arcangeli wrote:

> This is what I use normally to limit my brother downloads, and it works
> fine for me (though I don't often place calls through adsl myself, it's
> basically useless since people only uses cellphones here, and last time
> I chekced voip wasn't free for cellphones with my isp).
> 
> this is the script:

Mine is similar, though I use tc filters instead of firewalling
rules (my machine is on 192.168.2.0/24, rest of the house is
on 192.168.3.0/24) I'm using the imq device on a 2.2 kernel to
have all traffic go through that device for shaping:

#!/bin/bash
# traffic shaping startup script
#
# (c) 2003 Pascal Schmidt <der.eremit@email.de>

. /etc/rc.d/rc.functions

PATH=/bin:/sbin:/usr/bin:/usr/sbin

case "$1" in
start)
        echo -n "Setting up traffic shaper: "

        # remove other qdisc if any
	tc qdisc del dev imq root &> /dev/null

	# use HTB as root
	tc qdisc add dev imq root handle 1:0 htb default 3

	# complete LAN
	tc class add dev imq parent 1:0 classid 1:1  htb \
	   rate 10mbit burst 15k

	# ISDN connection, split up into two "halves"
	tc class add dev imq parent 1:1 classid 1:2  htb \
	   rate 64kbit burst 15k
	tc class add dev imq parent 1:2 classid 1:21 htb \
	   rate 40kbit ceil 64kbit burst 15k
	tc class add dev imq parent 1:2 classid 1:22 htb \
	   rate 24kbit ceil 59kbit burst 15k

	# rest of LAN bandwidth for internal traffic
	tc class add dev imq parent 1:1 classid 1:3  htb \
	   rate  9mbit ceil 10mbit burst 15k

	# use SFQ on leaf classes
	tc qdisc add dev imq parent 1:21 handle 21:0 sfq perturb 10
	tc qdisc add dev imq parent 1:22 handle 22:0 sfq perturb 10
	tc qdisc add dev imq parent 1:3  handle  3:0 sfq perturb 10

	# LAN to LAN traffic goes to fast class
	tc filter add dev imq protocol ip parent 1:0 prio 1 u32 \
	   match ip src 192.168.0.0/16 \
	   match ip dst 192.168.0.0/16 flowid 1:3

	# rest of traffic to LAN #1 (must be from Internet)
	# goes to first ISDN class (half ISDN channel)
	tc filter add dev imq protocol ip parent 1:0 prio 1 u32 \
	   match ip dst 192.168.2.0/24 flowid 1:21

	# rest of traffic to LAN #2 (must be from Internet)
	# goes to second ISDN class (half ISDN channel)
	tc filter add dev imq protocol ip parent 1:0 prio 1 u32 \
	   match ip dst 192.168.3.0/24 flowid 1:22

        check_status

	# bring up intermediate queue interface
	echo -n "Bringing up intermediate queue: "
	ifconfig imq up
	check_status
	;;
stop)
	# bring down intermediate queue interface
	echo -n "Taking down intermediate queue: "
	ifconfig imq down
	check_status
	
	# remove root qdisc
	echo -n "Disabling traffic shaper: "
	tc qdisc del dev imq root
	check_status
	;;
status)
	tc -d -s class show dev imq
	;;
restart)
	$0 stop
	$0 start
	;;
*)
	echo "Usage: $0 {start|stop|status|restart}"
	exit 1
esac

-- 
Ciao,
Pascal

