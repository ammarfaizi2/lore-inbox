Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135548AbREBOtA>; Wed, 2 May 2001 10:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135549AbREBOsv>; Wed, 2 May 2001 10:48:51 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:13575 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S135548AbREBOsj>; Wed, 2 May 2001 10:48:39 -0400
Date: Wed, 2 May 2001 10:49:52 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@fonzie.nine.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.4-ac3 +IPX -SYSCTL compile fix
Message-ID: <Pine.LNX.4.33.0105021040120.921-100000@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

File net/ipx/sysctl_net_ipx.c provides dummy functions for
ipx_register_sysctl and ipx_unregister_sysctl if CONFIG_SYSCTL is not
defined. The problem is, sysctl_net_ipx.c is not even compiled in this
case.

I'm moving the dummy functions to af_ipx.c where they are used. Not sure
about conformance with the coding standards, but I think that "static
inline" is preferred over defines. Feel free to correct me.

The patch is also here:
http://www.red-bean.com/~proski/linux/ipxsysctl.diff

The patch has been tested. IPX works fine without SYSCTL.

Regards,
Pavel Roskin

----------------------------------------------
--- linux.orig/net/ipx/af_ipx.c
+++ linux/net/ipx/af_ipx.c
@@ -116,8 +116,18 @@
 #include <linux/init.h>
 #include <linux/if_arp.h>

+#ifdef CONFIG_SYSCTL
 extern void ipx_register_sysctl(void);
 extern void ipx_unregister_sysctl(void);
+#else
+static inline void ipx_register_sysctl(void)
+{
+}
+
+static inline void ipx_unregister_sysctl(void)
+{
+}
+#endif

 /* Configuration Variables */
 static unsigned char ipxcfg_max_hops = 16;
--- linux.orig/net/ipx/sysctl_net_ipx.c
+++ linux/net/ipx/sysctl_net_ipx.c
@@ -44,11 +44,5 @@ void ipx_unregister_sysctl(void)
 }

 #else
-void ipx_register_sysctl(void)
-{
-}
-
-void ipx_unregister_sysctl(void)
-{
-}
+#error This file shouldn't be compiled without CONFIG_SYSCTL defined
 #endif

