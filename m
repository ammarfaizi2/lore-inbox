Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272874AbTG0XG7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 19:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272918AbTG0XFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 19:05:44 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272874AbTG0XB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:01:28 -0400
Date: Sun, 27 Jul 2003 23:12:30 +0200 (CEST)
From: Bas Bloemsaat <bloemsaa@xs4all.nl>
X-X-Sender: bloemsaa@vialle.bloemsaat.com
To: netdev@oss.sgi.com, linux-net@vger.kernel.org, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, layes@loran.com
Subject: [2.6 PATCH] bugfix: ARP respond on all devices
Message-ID: <Pine.LNX.4.53.0307272306310.6754@vialle.bloemsaat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the samefix as the 2.4 patch. I do not have a machine on which I
can test 2.6, but visual examination of the files suggested the same
mechanism. In fact, I was surprised that the 2.4 patch wouldn't patch 2.6
so I made this one.

It was made with 2.6.0-test1, and compiles.

Can someone confirm that 2.6 has the same bug, and that this patch fixes
it? I suspect it has, and suspect this fixes it, but can't test for lack
of an available machine.

Regards,
Bas Bloemsaat

diff -urN linux-2.6.0-test1.orig/include/linux/inetdevice.h linux-2.6.0-test1/include/linux/inetdevice.h
--- linux-2.6.0-test1.orig/include/linux/inetdevice.h	2003-07-14 05:35:56.000000000 +0200
+++ linux-2.6.0-test1/include/linux/inetdevice.h	2003-07-27 21:33:02.000000000 +0200
@@ -98,6 +98,7 @@
 extern u32		inet_select_addr(const struct net_device *dev, u32 dst, int scope);
 extern struct in_ifaddr *inet_ifa_byprefix(struct in_device *in_dev, u32 prefix, u32 mask);
 extern void		inet_forward_change(void);
+extern int             inet_addr_local_dev(struct in_device *in_dev, u32 addr);

 static __inline__ int inet_ifa_match(u32 addr, struct in_ifaddr *ifa)
 {
diff -urN linux-2.6.0-test1.orig/net/ipv4/arp.c linux-2.6.0-test1/net/ipv4/arp.c
--- linux-2.6.0-test1.orig/net/ipv4/arp.c	2003-07-14 05:37:28.000000000 +0200
+++ linux-2.6.0-test1/net/ipv4/arp.c	2003-07-27 21:37:31.000000000 +0200
@@ -67,6 +67,7 @@
  *					now it is in net/core/neighbour.c.
  *		Krzysztof Halasa:	Added Frame Relay ARP support.
  *		Arnaldo C. Melo :	convert /proc/net/arp to seq_file
+ *		Bas Bloemsaat   :       (20030727) Fixed respond on all devices bug
  */

 #include <linux/types.h>
@@ -750,7 +751,8 @@
 		rt = (struct rtable*)skb->dst;
 		addr_type = rt->rt_type;

-		if (addr_type == RTN_LOCAL) {
+               /* check if arp is for this device */
+               if (inet_addr_local_dev(in_dev,tip)) {
 			n = neigh_event_ns(&arp_tbl, sha, &sip, dev);
 			if (n) {
 				int dont_send = 0;
@@ -762,6 +764,7 @@
 				neigh_release(n);
 			}
 			goto out;
+                /* check if we can and have to proxy it */
 		} else if (IN_DEV_FORWARD(in_dev)) {
 			if ((rt->rt_flags&RTCF_DNAT) ||
 			    (addr_type == RTN_UNICAST  && rt->u.dst.dev != dev &&
diff -urN linux-2.6.0-test1.orig/net/ipv4/devinet.c linux-2.6.0-test1/net/ipv4/devinet.c
--- linux-2.6.0-test1.orig/net/ipv4/devinet.c	2003-07-14 05:31:57.000000000 +0200
+++ linux-2.6.0-test1/net/ipv4/devinet.c	2003-07-27 21:34:46.000000000 +0200
@@ -219,6 +219,15 @@
 	return 0;
 }

+int inet_addr_local_dev(struct in_device *in_dev, u32 addr)
+{
+       for_ifa(in_dev) {
+               if (!(addr^ifa->ifa_address))
+                       return -1;
+       } endfor_ifa(in_dev);
+       return 0;
+}
+
 static void inet_del_ifa(struct in_device *in_dev, struct in_ifaddr **ifap,
 			 int destroy)
 {
