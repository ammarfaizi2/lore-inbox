Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbTJTIqY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 04:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbTJTIqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 04:46:24 -0400
Received: from SteeleMR-loadb-NAT-49.caltech.edu ([131.215.49.69]:6523 "EHLO
	water-ox.its.caltech.edu") by vger.kernel.org with ESMTP
	id S262450AbTJTIqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 04:46:20 -0400
Date: Mon, 20 Oct 2003 01:46:15 -0700 (PDT)
From: "Noah J. Misch" <noah@caltech.edu>
X-X-Sender: noah@clyde
To: jschlst@samba.org
Cc: linux-atalk@lists.netspace.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Make appletalk link with SYSCTL=n
Message-ID: <Pine.GSO.4.58.0310171452240.13905@blinky>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jay,

This patch allows the appletalk network layer support to link properly when
CONFIG_SYSCTL=n.  The Makefile only built sysctl_net_appletalk.o when
SYSCTL=y/m, but ddp.c called the register function therein regardless of
CONFIG_SYSCTL.  The log details my implementation of the fix.

An alternate, less intrusive fix would be to make sysctl_net_appletalk.o build
always and add an #ifdef around the call to atalk_register_sysctl.

This applies to linux-2.5 BK as of 0700 UTC 10/20/2003 and builds under an
allyesconfig on i386.  I haven't tested it in operation because I think the
change is straightforward, but I can do so if you would like.

Thanks,
Noah

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1340.1.33 -> 1.1340.1.34
#	net/appletalk/sysctl_net_atalk.c	1.4     -> 1.5
#	 net/appletalk/ddp.c	1.37    -> 1.38
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/10/16	torvalds@home.osdl.org	1.1340.19.2
# Merge http://lia64.bkbits.net/to-linus-2.5
# into home.osdl.org:/home/torvalds/v2.5/linux
# --------------------------------------------
# 03/10/16	torvalds@home.osdl.org	1.1342
# Merge http://mdomsch.bkbits.net/linux-2.5-edd
# into home.osdl.org:/home/torvalds/v2.5/linux
# --------------------------------------------
# 03/10/17	noah@caltech.edu	1.1340.1.34
# Add static inline stubs of atalk_(un)?register_sysctl to net/appletalk/ddp.c
# and remove the #ifdef CONFIG_SYSCTL and the extern stub functions from
# net/appletalk/sysctl_net_atalk.c.  This fixes a link error in the absence of
# CONFIG_SYSCTL and saves space.
# --------------------------------------------
#
diff -Nru a/net/appletalk/ddp.c b/net/appletalk/ddp.c
--- a/net/appletalk/ddp.c	Fri Oct 17 16:23:47 2003
+++ b/net/appletalk/ddp.c	Fri Oct 17 16:23:47 2003
@@ -68,8 +68,13 @@
 				     struct atalk_addr *sa);
 extern void aarp_proxy_remove(struct net_device *dev, struct atalk_addr *sa);

+#ifdef CONFIG_SYSCTL
 extern void atalk_register_sysctl(void);
 extern void atalk_unregister_sysctl(void);
+#else /* CONFIG_SYSCTL */
+static inline void atalk_register_sysctl(void)   { }
+static inline void atalk_unregister_sysctl(void) { }
+#endif /* CONFIG_SYSCTL */

 struct datalink_proto *ddp_dl, *aarp_dl;
 static struct proto_ops atalk_dgram_ops;
@@ -1919,9 +1924,7 @@
  */
 static void __exit atalk_exit(void)
 {
-#ifdef CONFIG_SYSCTL
 	atalk_unregister_sysctl();
-#endif /* CONFIG_SYSCTL */
 	atalk_proc_exit();
 	aarp_cleanup_module();	/* General aarp clean-up. */
 	unregister_netdevice_notifier(&ddp_notifier);
diff -Nru a/net/appletalk/sysctl_net_atalk.c b/net/appletalk/sysctl_net_atalk.c
--- a/net/appletalk/sysctl_net_atalk.c	Fri Oct 17 16:23:47 2003
+++ b/net/appletalk/sysctl_net_atalk.c	Fri Oct 17 16:23:47 2003
@@ -7,8 +7,6 @@
  */

 #include <linux/config.h>
-
-#ifdef CONFIG_SYSCTL
 #include <linux/sysctl.h>
 extern int sysctl_aarp_expiry_time;
 extern int sysctl_aarp_tick_time;
@@ -82,13 +80,3 @@
 {
 	unregister_sysctl_table(atalk_table_header);
 }
-
-#else /* CONFIG_PROC_FS */
-void atalk_register_sysctl(void)
-{
-}
-
-void atalk_unregister_sysctl(void)
-{
-}
-#endif /* CONFIG_PROC_FS */

