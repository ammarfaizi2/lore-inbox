Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752316AbWCKCc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316AbWCKCc0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 21:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752317AbWCKCc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 21:32:26 -0500
Received: from mail.infrasupportetc.com ([66.173.97.5]:51372 "EHLO
	mail733.InfraSupportEtc.com") by vger.kernel.org with ESMTP
	id S1752315AbWCKCcZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 21:32:25 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Router stops routing after changing MAC Address
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Fri, 10 Mar 2006 20:33:32 -0600
Message-ID: <925A849792280C4E80C5461017A4B8A20321CD@mail733.InfraSupportEtc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Router stops routing after changing MAC Address
Thread-Index: AcZEqcYAYNJcXG1zRBiu5CXKz040uwABOBiQ
From: "Greg Scott" <GregScott@InfraSupportEtc.com>
To: <linux-kernel@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, <shemminger@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ARP caches on both the left and right side systems make sense and
show what I would expect.  

When I do arp -a on both the left and right side systems, both systems
show the original MAC Addresses for the router when the router uses the
originals, and both show the fudged MAC Addresses when the router is set
with the fudged MAC Addresses.  Besides, both the left and right systems
can ping the router regardless of the MAC Address of the router NICs.
To my mind, this rules out ARP cache issues.  

Flushing the route cache on the router has no effect.  I flushed and
reset everything after putting in the fudged MAC Address like this:

[root@test-fw2 gregs]# more fix-routes.sh
#!/bin/sh

echo "Routes before updating"
/sbin/ip route show

echo "Default route"
/sbin/ip route flush 0.0.0.0/0
/sbin/ip route add 0.0.0.0/0 via 1.2.3.49 dev eth0

echo "Route to the right"
/sbin/ip route flush 1.2.3.48/29
/sbin/ip route add 1.2.3.48/29 dev eth0

echo "Route to the left"
/sbin/ip route flush 172.16.0.0/16
/sbin/ip route add 172.16.0.0/16 dev eth1

echo "Routes after updating"
/sbin/ip route show

exit


Here are the results - with my pings still running from the system on
the left.  And then, going back to the original MAC Address - even
without flusing any routes - the router forwards packets again when the
MAC Addresses match the hardware.  I don't think the problem has
anything to do with ARP caches or routes or anything I know how to set
external to the kernel.  I think the issue is deeper than routing
caches, unless there are routes someplace it won't show me.  


[root@test-fw2 gregs]# ./fix-routes.sh
Routes before updating
1.2.3.48/29 dev eth0  scope link 
1.2.3.48/28 dev eth0  proto kernel  scope link  src 1.2.3.50 
10.10.10.0/24 dev eth2  proto kernel  scope link  src 10.10.10.76 
172.16.0.0/16 dev eth1  scope link 
default via 1.2.3.49 dev eth0 
Default route
Route to the right
Route to the left
Routes after updating
1.2.3.48/29 dev eth0  scope link 
1.2.3.48/28 dev eth0  proto kernel  scope link  src 1.2.3.50 
10.10.10.0/24 dev eth2  proto kernel  scope link  src 10.10.10.76 
172.16.0.0/16 dev eth1  scope link 
default via 1.2.3.49 dev eth0 
[root@test-fw2 gregs]# 
[root@test-fw2 gregs]# 
[root@test-fw2 gregs]# /usr/sbin/tcpdump -i eth1 -n
tcpdump: verbose output suppressed, use -v or -vv for full protocol
decode
listening on eth1, link-type EN10MB (Ethernet), capture size 96 bytes
19:19:37.714471 IP 172.16.16.1 > 1.2.3.49: icmp 64: echo request seq
7962
19:19:38.714497 IP 172.16.16.1 > 1.2.3.49: icmp 64: echo request seq
7963
19:19:39.714575 IP 172.16.16.1 > 1.2.3.49: icmp 64: echo request seq
7964
19:19:40.714668 IP 172.16.16.1 > 1.2.3.49: icmp 64: echo request seq
7965

4 packets captured
4 packets received by filter
0 packets dropped by kernel
[root@test-fw2 gregs]# ./original-mac.sh
[root@test-fw2 gregs]# /usr/sbin/tcpdump -i eth1 -n
tcpdump: verbose output suppressed, use -v or -vv for full protocol
decode
listening on eth1, link-type EN10MB (Ethernet), capture size 96 bytes
19:20:00.726334 IP 172.16.16.1 > 1.2.3.49: icmp 64: echo request seq
7985
19:20:00.726437 IP 1.2.3.49 > 172.16.16.1: icmp 64: echo reply seq 7985
19:20:01.176923 fe80::250:daff:fe90:e4aa > ff02::2: icmp6: router
solicitation 
19:20:01.726354 IP 172.16.16.1 > 1.2.3.49: icmp 64: echo request seq
7986
19:20:01.726528 IP 1.2.3.49 > 172.16.16.1: icmp 64: echo reply seq 7986
19:20:02.726445 IP 172.16.16.1 > 1.2.3.49: icmp 64: echo request seq
7987
19:20:02.726614 IP 1.2.3.49 > 172.16.16.1: icmp 64: echo reply seq 7987
19:20:03.726504 IP 172.16.16.1 > 1.2.3.49: icmp 64: echo request seq
7988
19:20:03.726678 IP 1.2.3.49 > 172.16.16.1: icmp 64: echo reply seq 7988

9 packets captured
9 packets received by filter
0 packets dropped by kernel
[root@test-fw2 gregs]# 

 

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of David S. Miller
Sent: Friday, March 10, 2006 7:17 PM
To: shemminger@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Router stops routing after changing MAC Address

From: Stephen Hemminger <shemminger@osdl.org>
Date: Fri, 10 Mar 2006 16:39:58 -0800

> You probably just need to flush the route cache after the address
change?

It's probably a good idea for the routing cache to catch this event, if
that's all that needs to be done.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in the body of a message to majordomo@vger.kernel.org More majordomo
info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
