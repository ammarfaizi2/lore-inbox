Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318532AbSGZWBt>; Fri, 26 Jul 2002 18:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318536AbSGZWBt>; Fri, 26 Jul 2002 18:01:49 -0400
Received: from ierw.net.avaya.com ([198.152.13.101]:2036 "EHLO
	ierw.net.avaya.com") by vger.kernel.org with ESMTP
	id <S318532AbSGZWBs>; Fri, 26 Jul 2002 18:01:48 -0400
Date: Fri, 26 Jul 2002 16:05:04 -0600 (MDT)
From: Bhavesh_P_Davda <bhaveshd@earth.dr.avaya.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.18 IPv4/devinet enhancements for down'ing interfaces
Message-ID: <Pine.LNX.4.21.0207261559380.2616-100000@earth.dr.avaya.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sometimes, one would like to play with an IP address/netmask/etc. on a
network interface temporarily, and then be able to down the interface, and
reuse that IP address/netmask/etc. on another host on the same subnet.

However, a simple "ifconfig eth0 192.11.13.15 netmask 255.255.255.192 up",
followed by an "ifconfig eth0 down" still leaves FIB rules in place for
the 192.11.13.15 address, so that an ARP request that arrives on, say eth1
for 192.11.13.15 would result in a response being generated from eth1 for
the old 192.11.13.15 address that was on eth0, even though eth0 is down.

There are a couple of ways that  one can get around this problem:

1. From user space, by modifying the "ifdown" scripts to "ifconfig eth0 0
down", i.e. remove the IP address information associated with the network
interface entirely.

or

2. From the kernel, with the following enhancement that I have
developed. If a user specifies "ifconfig eth0 down -arp" with my kernel
changes, this gets rid of the FIB rules in the kernel for the IP address
associated with the interface, but leaves the IP address information still
associated with the down network interface. So a subsequent "ifconfig eth0
up" will restore the FIB rules and re-enable the interface with its old IP
address information.


I believe that this could be a differentiating feature of Linux
versus other Un*x OSes, that some system/network admins would like to
use. The reason I went down this path is because we got bitten by this
problem on a number of subnets, because we have many
multi-network-interface servers on our networks that we play around with.

Here is the patch against the 2.4.18 kernel...

diff -aur linux-2.4.18/net/ipv4/devinet.c linux-2.4.18-arp/net/ipv4/devinet.c
--- linux-2.4.18/net/ipv4/devinet.c	Fri Dec 21 10:42:05 2001
+++ linux-2.4.18-arp/net/ipv4/devinet.c	Fri Jul 26 14:32:18 2002
@@ -586,6 +586,14 @@
 					inet_del_ifa(in_dev, ifap, 1);
 				break;
 			}
+			if (!(ifr.ifr_flags&IFF_UP) && 
+				(ifr.ifr_flags&IFF_NOARP)) {
+					ifr.ifr_flags &= ~IFF_NOARP;
+					in_dev->flags |= IFF_NOARP;
+					notifier_call_chain(&inetaddr_chain,
+						NETDEV_DOWN, ifa);
+					in_dev->flags &= ~IFF_NOARP;
+			}
 			ret = dev_change_flags(dev, ifr.ifr_flags);
 			break;
 	
diff -aur linux-2.4.18/net/ipv4/fib_frontend.c linux-2.4.18-arp/net/ipv4/fib_frontend.c
--- linux-2.4.18/net/ipv4/fib_frontend.c	Fri Dec 21 10:42:05 2001
+++ linux-2.4.18-arp/net/ipv4/fib_frontend.c	Fri Jul 26 14:33:10 2002
@@ -583,7 +583,9 @@
 		break;
 	case NETDEV_DOWN:
 		fib_del_ifaddr(ifa);
-		if (ifa->ifa_dev && ifa->ifa_dev->ifa_list == NULL) {
+		if (ifa->ifa_dev && 
+			((ifa->ifa_dev->ifa_list == NULL) ||
+			(ifa->ifa_dev->flags&IFF_NOARP))) {
 			/* Last address was deleted from this interface.
 			   Disable IP.
 			 */

-- 
Bhavesh P. Davda
Avaya Inc.
bhavesh@avaya.com

