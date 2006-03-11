Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWCKAuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWCKAuM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 19:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWCKAuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 19:50:12 -0500
Received: from bsamwel.xs4all.nl ([82.92.179.183]:49354 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S932346AbWCKAuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 19:50:10 -0500
Message-ID: <44121EBF.6010106@samwel.tk>
Date: Sat, 11 Mar 2006 01:50:07 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Greg Scott <GregScott@InfraSupportEtc.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Router stops routing after changing MAC Address
References: <925A849792280C4E80C5461017A4B8A20321CC@mail733.InfraSupportEtc.com>
In-Reply-To: <925A849792280C4E80C5461017A4B8A20321CC@mail733.InfraSupportEtc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No (on samwel.tk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Scott wrote:
> Hello - This feels like a kernel issue.  I spent hours and hours and
> hours looking for documentation and archives around this but did not
> find anything.  
> 
> I have a Linux router and I need the ability to swap hardware without
> causing downtime.  The problem, of course, is ARPs.  The NICs in the
> replacement system need the same MAC Addresses as the NICs in the
> original system.  I'd like this all to be in the kernel and not depend
> on a daemon process that can die.
> 
> How to change MAC addresses is documented well enough - and it works -
> but when I change MAC addresses, my router stops routing.  From the
> router, I can see the systems on both sides - but the router just
> refuses to forward packets.  Here are my little test scripts to change
> MAC Addresses.
> 
> First - ip-fudge-mac.sh
> [root@test-fw2 gregs]# more ip-fudge-mac.sh
> ip link set eth0 down
> ip link set eth0 address 01:02:03:04:05:06
> ip link set eth0 up
> 
> ip link set eth1 down
> ip link set eth1 address 17:20:16:01:60:03
> ip link set eth1 up
> 
> echo "1" > /proc/sys/net/ipv4/ip_forward
> 
> 
> 
> Now original-mac.sh
> 
> [root@test-fw2 gregs]# more original-mac.sh
> ifdown eth0
> ifconfig eth0 hw ether 00:c1:28:01:d8:07
> ifup eth0
> 
> ifdown eth1
> ifconfig eth1 hw ether 00:50:da:90:e4:aa
> ifup eth1
> 
> echo "1" > /proc/sys/net/ipv4/ip_forward
> 
> I have systems both on the left and right side of my test router.  Here
> is some output from the router with tcpdump showing what happens.  I
> replaced the first 3 real public IP Address octects with "1.2.3".  The
> first set of tcpdump records shows it forarding with the original
> hardware MAC Addreses are set.  We see round trips from the left side to
> the right side and back with echo request and reply packets.
> 
> The second set shows what happens after changing MAC Addresses.  We only
> see packets come in on the left side - but nothing happening on the
> right side.  
> 
> Packet forwarding must somehow depend on MAC Addresses but I cannot find
> anything anywhere that tells me how this works.  
> 
> I reproduced this problem on at least two different Linux routers - one
> running 2.4.27, the other running 2.6.11-1.  Am I asking the kernel to
> do something bad?  What would it take to put together a patch to change
> this behavior?
> 
> 
> [root@test-fw2 gregs]# ./original-mac.sh
> [root@test-fw2 gregs]# /usr/sbin/tcpdump -i eth1 -n
> tcpdump: verbose output suppressed, use -v or -vv for full protocol
> decode
> listening on eth1, link-type EN10MB (Ethernet), capture size 96 bytes
> 17:14:51.010439 IP 172.16.16.1 > 1.2.3.49: icmp 64: echo request seq 479
> 17:14:51.010537 IP 1.2.3.49 > 172.16.16.1: icmp 64: echo reply seq 479
> 17:14:52.010448 IP 172.16.16.1 > 1.2.3.49: icmp 64: echo request seq 480
> 17:14:52.010621 IP 1.2.3.49 > 172.16.16.1: icmp 64: echo reply seq 480
> 17:14:53.010531 IP 172.16.16.1 > 1.2.3.49: icmp 64: echo request seq 481
> 17:14:53.010696 IP 1.2.3.49 > 172.16.16.1: icmp 64: echo reply seq 481
> 17:14:54.010716 IP 172.16.16.1 > 1.2.3.49: icmp 64: echo request seq 482
> 17:14:54.010882 IP 1.2.3.49 > 172.16.16.1: icmp 64: echo reply seq 482
> 
> 8 packets captured
> 8 packets received by filter
> 0 packets dropped by kernel
> [root@test-fw2 gregs]# ./ip-fudge-mac.sh
> [root@test-fw2 gregs]# /usr/sbin/tcpdump -i eth1 -n
> tcpdump: verbose output suppressed, use -v or -vv for full protocol
> decode
> listening on eth1, link-type EN10MB (Ethernet), capture size 96 bytes
> 17:15:10.031945 IP 172.16.16.1 > 1.2.3.49: icmp 64: echo request seq 498
> 17:15:11.031980 IP 172.16.16.1 > 1.2.3.49: icmp 64: echo request seq 499
> 17:15:11.806487 fe80::1520:16ff:fe01:6003 > ff02::2: icmp6: router
> solicitation 
> 17:15:12.032062 IP 172.16.16.1 > 1.2.3.49: icmp 64: echo request seq 500
> 17:15:13.032154 IP 172.16.16.1 > 1.2.3.49: icmp 64: echo request seq 501
> 17:15:14.032222 IP 172.16.16.1 > 1.2.3.49: icmp 64: echo request seq 502
> 17:15:15.032305 IP 172.16.16.1 > 1.2.3.49: icmp 64: echo request seq 503
> 17:15:15.805873 fe80::1520:16ff:fe01:6003 > ff02::2: icmp6: router
> solicitation 
> 17:15:16.032394 IP 172.16.16.1 > 1.2.3.49: icmp 64: echo request seq 504
> 17:15:17.032465 IP 172.16.16.1 > 1.2.3.49: icmp 64: echo request seq 505
> 
> 10 packets captured
> 10 packets received by filter
> 0 packets dropped by kernel
> [root@test-fw2 gregs]# 
> [root@test-fw2 gregs]# /usr/sbin/tcpdump -i eth0 -n
> tcpdump: verbose output suppressed, use -v or -vv for full protocol
> decode
> listening on eth0, link-type EN10MB (Ethernet), capture size 96 bytes
> 
> 0 packets captured
> 0 packets received by filter
> 0 packets dropped by kernel
> [root@test-fw2 gregs]# 

I think you're not testing hotswapping machines with equal MAC addresses 
here, you're testing hot-changing the MAC address for a gateway IP. The 
machine on the "right side" that the machine on the left side is pinging 
probably still has the old MAC address for its gateway in it's ARP 
cache, so the echo reply will be sent to the wrong MAC address. (Or am I 
talking nonsense here?)

--Bart
