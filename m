Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265312AbSJXEo6>; Thu, 24 Oct 2002 00:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265313AbSJXEo6>; Thu, 24 Oct 2002 00:44:58 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:7180 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S265312AbSJXEoz>; Thu, 24 Oct 2002 00:44:55 -0400
Date: Thu, 24 Oct 2002 13:50:55 +0900 (JST)
Message-Id: <20021024.135055.10632889.yoshfuji@linux-ipv6.org>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
CC: usagi@linux-ipv6.org
Subject: [PATCH] IPv6: Sysctl for ICMPv6 Rate Limitation
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Thu_Oct_24_13:50:55_2002_573)--"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----Next_Part(Thu_Oct_24_13:50:55_2002_573)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi!

This patch add sysctl for icmp6 rate limit.
This patch is against 2.4.20-pre11 (see below).

Thanks in advance.

Note: This inlined patch conflicts with IPV6_V6ONLY patch.
      So, I attach another patch depend on the IPV6_V6ONLY patch.

-------------------------------------------------------------------
Patch-Name: Sysctl for ICMPv6 Rate Limitation
Patch-Id: FIX_2_4_20_pre11_ICMP_SYSCTL-20021024
Patch-Author: YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
Credit: YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
-------------------------------------------------------------------
Index: Documentation/networking/ip-sysctl.txt
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/Documentation/networking/ip-sysctl.txt,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.44.1
diff -u -r1.1.1.1 -r1.1.1.1.44.1
--- Documentation/networking/ip-sysctl.txt	20 Aug 2002 09:48:10 -0000	1.1.1.1
+++ Documentation/networking/ip-sysctl.txt	23 Oct 2002 17:50:19 -0000	1.1.1.1.44.1
@@ -560,8 +560,14 @@
 	routers are present.
 	Default: 3
 
+icmp/*:
+ratelimit - INTEGER
+	Limit the maximal rates for sending ICMPv6 packets.
+	0 to disable any limiting, otherwise the maximal rate in jiffies(1)
+	Default: 100
+
 IPv6 Update by:
-Pekka Savola
-pekkas@netcore.fi
+Pekka Savola <pekkas@netcore.fi>
+YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
 
 $Id: ip-sysctl.txt,v 1.19.2.1 2001/12/13 08:59:27 davem Exp $
Index: include/linux/sysctl.h
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/include/linux/sysctl.h,v
retrieving revision 1.1.1.2
retrieving revision 1.1.1.2.18.1
diff -u -r1.1.1.2 -r1.1.1.2.18.1
--- include/linux/sysctl.h	9 Oct 2002 01:35:37 -0000	1.1.1.2
+++ include/linux/sysctl.h	23 Oct 2002 17:50:19 -0000	1.1.1.2.18.1
@@ -345,7 +345,8 @@
 enum {
 	NET_IPV6_CONF=16,
 	NET_IPV6_NEIGH=17,
-	NET_IPV6_ROUTE=18
+	NET_IPV6_ROUTE=18,
+	NET_IPV6_ICMP=19
 };
 
 enum {
@@ -371,6 +372,11 @@
 	NET_IPV6_RTR_SOLICITS=8,
 	NET_IPV6_RTR_SOLICIT_INTERVAL=9,
 	NET_IPV6_RTR_SOLICIT_DELAY=10
+};
+
+/* /proc/sys/net/ipv6/icmp */
+enum {
+	NET_IPV6_ICMP_RATELIMIT=1
 };
 
 /* /proc/sys/net/<protocol>/neigh/<dev> */
Index: net/ipv6/icmp.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv6/icmp.c,v
retrieving revision 1.1.1.2
retrieving revision 1.1.1.2.14.1
diff -u -r1.1.1.2 -r1.1.1.2.14.1
--- net/ipv6/icmp.c	9 Oct 2002 01:35:53 -0000	1.1.1.2
+++ net/ipv6/icmp.c	23 Oct 2002 17:50:19 -0000	1.1.1.2.14.1
@@ -25,6 +25,7 @@
  *					add more length checks and other fixes.
  *	yoshfuji		:	ensure to sent parameter problem for
  *					fragments.
+ *	YOSHIFUJI Hideaki @USAGI:	added sysctl for icmp rate limit.
  */
 
 #define __NO_VERSION__
@@ -40,6 +41,10 @@
 #include <linux/skbuff.h>
 #include <linux/init.h>
 
+#ifdef CONFIG_SYSCTL
+#include <linux/sysctl.h>
+#endif
+
 #include <linux/inet.h>
 #include <linux/netdevice.h>
 #include <linux/icmpv6.h>
@@ -715,3 +720,12 @@
 
 	return fatal;
 }
+
+#ifdef CONFIG_SYSCTL
+ctl_table ipv6_icmp_table[] = {
+	{NET_IPV6_ICMP_RATELIMIT, "ratelimit",
+	&sysctl_icmpv6_time, sizeof(int), 0644, NULL, &proc_dointvec},
+	{0},
+};
+#endif
+
Index: net/ipv6/sysctl_net_ipv6.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv6/sysctl_net_ipv6.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.42.1
diff -u -r1.1.1.1 -r1.1.1.1.42.1
--- net/ipv6/sysctl_net_ipv6.c	20 Aug 2002 09:47:02 -0000	1.1.1.1
+++ net/ipv6/sysctl_net_ipv6.c	23 Oct 2002 17:50:19 -0000	1.1.1.1.42.1
@@ -1,5 +1,8 @@
 /*
  * sysctl_net_ipv6.c: sysctl interface to net IPV6 subsystem.
+ *
+ * Changes:
+ * YOSHIFUJI Hideaki @USAGI:	added icmp sysctl table.
  */
 
 #include <linux/mm.h>
@@ -12,11 +15,13 @@
 #include <net/addrconf.h>
 
 extern ctl_table ipv6_route_table[];
+extern ctl_table ipv6_icmp_table[];
 
 #ifdef CONFIG_SYSCTL
 
 ctl_table ipv6_table[] = {
 	{NET_IPV6_ROUTE, "route", NULL, 0, 0555, ipv6_route_table},
+	{NET_IPV6_ICMP, "icmp", NULL, 0, 0500, ipv6_icmp_table},
 	{0}
 };
 


----Next_Part(Thu_Oct_24_13:50:55_2002_573)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux24-FIX_2_4_20_pre11_DOUBLEBIND+ICMP_SYSCTL-20021024.patch"

Index: Documentation/networking/ip-sysctl.txt
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/Documentation/networking/ip-sysctl.txt,v
retrieving revision 1.1.1.1.42.1
retrieving revision 1.1.1.1.42.1.2.1
diff -u -r1.1.1.1.42.1 -r1.1.1.1.42.1.2.1
--- Documentation/networking/ip-sysctl.txt	22 Oct 2002 19:19:48 -0000	1.1.1.1.42.1
+++ Documentation/networking/ip-sysctl.txt	23 Oct 2002 18:39:55 -0000	1.1.1.1.42.1.2.1
@@ -569,8 +569,14 @@
 	routers are present.
 	Default: 3
 
+icmp/*:
+ratelimit - INTEGER
+	Limit the maximal rates for sending ICMPv6 packets.
+	0 to disable any limiting, otherwise the maximal rate in jiffies(1)
+	Default: 100
+
 IPv6 Update by:
-Pekka Savola
-pekkas@netcore.fi
+Pekka Savola <pekkas@netcore.fi>
+YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
 
 $Id: ip-sysctl.txt,v 1.19.2.1 2001/12/13 08:59:27 davem Exp $
Index: include/linux/sysctl.h
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/include/linux/sysctl.h,v
retrieving revision 1.1.1.2.16.1
retrieving revision 1.1.1.2.16.1.2.2
diff -u -r1.1.1.2.16.1 -r1.1.1.2.16.1.2.2
--- include/linux/sysctl.h	22 Oct 2002 19:19:48 -0000	1.1.1.2.16.1
+++ include/linux/sysctl.h	24 Oct 2002 04:38:38 -0000	1.1.1.2.16.1.2.2
@@ -346,7 +346,8 @@
 	NET_IPV6_CONF=16,
 	NET_IPV6_NEIGH=17,
 	NET_IPV6_ROUTE=18,
-	NET_IPV6_BINDV6ONLY=20,
+	NET_IPV6_ICMP=19,
+	NET_IPV6_BINDV6ONLY=20
 };
 
 enum {
@@ -372,6 +373,11 @@
 	NET_IPV6_RTR_SOLICITS=8,
 	NET_IPV6_RTR_SOLICIT_INTERVAL=9,
 	NET_IPV6_RTR_SOLICIT_DELAY=10
+};
+
+/* /proc/sys/net/ipv6/icmp */
+enum {
+	NET_IPV6_ICMP_RATELIMIT=1
 };
 
 /* /proc/sys/net/<protocol>/neigh/<dev> */
Index: net/ipv6/icmp.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv6/icmp.c,v
retrieving revision 1.1.1.2
retrieving revision 1.1.1.2.16.1
diff -u -r1.1.1.2 -r1.1.1.2.16.1
--- net/ipv6/icmp.c	9 Oct 2002 01:35:53 -0000	1.1.1.2
+++ net/ipv6/icmp.c	23 Oct 2002 18:39:20 -0000	1.1.1.2.16.1
@@ -25,6 +25,7 @@
  *					add more length checks and other fixes.
  *	yoshfuji		:	ensure to sent parameter problem for
  *					fragments.
+ *	YOSHIFUJI Hideaki @USAGI:	added sysctl for icmp rate limit.
  */
 
 #define __NO_VERSION__
@@ -40,6 +41,10 @@
 #include <linux/skbuff.h>
 #include <linux/init.h>
 
+#ifdef CONFIG_SYSCTL
+#include <linux/sysctl.h>
+#endif
+
 #include <linux/inet.h>
 #include <linux/netdevice.h>
 #include <linux/icmpv6.h>
@@ -715,3 +720,12 @@
 
 	return fatal;
 }
+
+#ifdef CONFIG_SYSCTL
+ctl_table ipv6_icmp_table[] = {
+	{NET_IPV6_ICMP_RATELIMIT, "ratelimit",
+	&sysctl_icmpv6_time, sizeof(int), 0644, NULL, &proc_dointvec},
+	{0},
+};
+#endif
+
Index: net/ipv6/sysctl_net_ipv6.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv6/sysctl_net_ipv6.c,v
retrieving revision 1.1.1.1.40.1
retrieving revision 1.1.1.1.40.1.2.1
diff -u -r1.1.1.1.40.1 -r1.1.1.1.40.1.2.1
--- net/ipv6/sysctl_net_ipv6.c	22 Oct 2002 19:19:48 -0000	1.1.1.1.40.1
+++ net/ipv6/sysctl_net_ipv6.c	23 Oct 2002 18:39:20 -0000	1.1.1.1.40.1.2.1
@@ -1,5 +1,8 @@
 /*
  * sysctl_net_ipv6.c: sysctl interface to net IPV6 subsystem.
+ *
+ * Changes:
+ * YOSHIFUJI Hideaki @USAGI:	added icmp sysctl table.
  */
 
 #include <linux/mm.h>
@@ -12,11 +15,13 @@
 #include <net/addrconf.h>
 
 extern ctl_table ipv6_route_table[];
+extern ctl_table ipv6_icmp_table[];
 
 #ifdef CONFIG_SYSCTL
 
 ctl_table ipv6_table[] = {
 	{NET_IPV6_ROUTE, "route", NULL, 0, 0555, ipv6_route_table},
+	{NET_IPV6_ICMP, "icmp", NULL, 0, 0500, ipv6_icmp_table},
 	{NET_IPV6_BINDV6ONLY, "bindv6only",
 	 &sysctl_ipv6_bindv6only, sizeof(int), 0644, NULL, &proc_dointvec},
 	{0}

----Next_Part(Thu_Oct_24_13:50:55_2002_573)----
