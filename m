Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262592AbUKLROI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbUKLROI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 12:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262582AbUKLRMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 12:12:19 -0500
Received: from dobermann.cosy.sbg.ac.at ([141.201.2.56]:3975 "EHLO
	dobermann.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id S262593AbUKLRG5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@VGER.KERNEL.ORG>);
	Fri, 12 Nov 2004 12:06:57 -0500
Date: Fri, 12 Nov 2004 17:06:53 +0000
From: Andreas Maier <andi@cosy.sbg.ac.at>
Subject: [RFC] IPv6 without IPv4
To: linux-kernel@VGER.KERNEL.ORG
X-Mailer: Balsa 2.2.5
Message-Id: <1100279213l.5304l.1l@leu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This small patch makes AF_INET (IPv4) invisible to user space.

I need it to test applications in a strictly IPv6-only environment
and it may be helpful to others that have similar constraints.
It seems to work for TCP6 (ssh), UDP6 (DNS) and ICMP6 (ping6).

Don't forget to enable binding to IPv6 only. Otherwise an Oops happens
in the uninitialized IPv4 routing code (__ip_route_output_key):
	echo 1 > /proc/sys/net/ipv6/bindv6only

Yes, the hack is ugly. Would it be possible - with reasonable effort -
to remove dependency of IPv6 on IPv4 so that an IPv6-only configuration
can be created easily?

Thanks for your comments,
-andi


This is a diff against Debian version of kernel-2.6.8:

--- net/ipv4/af_inet.c.orig	2004-10-29 15:01:42.000000000 +0200
+++ net/ipv4/af_inet.c	2004-11-04 11:57:11.000000000 +0100
@@ -1032,7 +1032,10 @@
 	 *	Tell SOCKET that we are alive...
 	 */

+#define HIDE_V4
+#ifndef HIDE_V4
   	(void)sock_register(&inet_family_ops);
+#endif

 	/*
 	 *	Add all the base protocols.
@@ -1066,9 +1069,11 @@
   	 *	Set the IP module up
   	 */

+#ifndef HIDE_V4
 	ip_init();

 	tcp_v4_init(&inet_family_ops);
+#endif

 	/* Setup TCP slab cache for open requests. */
 	tcp_init();
@@ -1078,7 +1083,9 @@
 	 *	Set the ICMP layer up
 	 */

+#ifndef HIDE_V4
 	icmp_init(&inet_family_ops);
+#endif

 	/*
 	 *	Initialise the multicast router
@@ -1093,7 +1100,9 @@
 	if(init_ipv4_mibs())
 		printk(KERN_CRIT "inet_init: Cannot init ipv4 mibs\n"); ;
 	
+#ifndef HIDE_V4
 	ipv4_proc_init();
+#endif

 	ipfrag_init();

-- 
| Andreas Maier               Paris-Lodron University of Salzburg   |
| (andi [at] cosy.sbg.ac.at)  Department of Scientific Computing    |
| Tel. +43/662/8044-6339      Jakob Haringerstr. 2                  |
| Fax. +43/662/8044-172       5020 Salzburg / Austria, Europe       |

