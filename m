Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVCQUo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVCQUo4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 15:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVCQUov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 15:44:51 -0500
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:13747 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S261168AbVCQUoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 15:44:34 -0500
Message-Id: <200503172036.j2HKadfm000732@ginger.cmf.nrl.navy.mil>
To: Adrian Bunk <bunk@stusta.de>
cc: shemminger@osdl.org, bridge@osdl.org,
       linux-atm-general@lists.sourceforge.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Reply-To: chas3@users.sourceforge.net
Reply-To: chas3@users.sourceforge.net
Reply-To: chas3@users.sourceforge.net
Subject: Re: [2.6 patch] fix bridge <-> ATM compile error 
In-reply-to: <20050316181532.GA3251@stusta.de> 
Date: Thu, 17 Mar 2005 15:36:40 -0500
From: "chas williams - CONTRACTOR" <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-2.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20050316181532.GA3251@stusta.de>,Adrian Bunk writes:
>Letting CONFIG_BRIDGE depend on CONFIG_ATM doesn't sound like a good 
>idea, since I doubt all people using the Bridge code require ATM 
>support.

how about the following?

===== net/atm/common.c 1.58 vs edited =====
--- 1.58/net/atm/common.c	2005-01-20 21:17:39 -05:00
+++ edited/net/atm/common.c	2005-03-16 12:44:37 -05:00
@@ -755,21 +755,6 @@
 	return vcc->dev->ops->getsockopt(vcc, level, optname, optval, len);
 }
 
-
-#if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
-#if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
-struct net_bridge;
-struct net_bridge_fdb_entry *(*br_fdb_get_hook)(struct net_bridge *br,
-						unsigned char *addr) = NULL;
-void (*br_fdb_put_hook)(struct net_bridge_fdb_entry *ent) = NULL;
-#if defined(CONFIG_ATM_LANE_MODULE) || defined(CONFIG_BRIDGE_MODULE)
-EXPORT_SYMBOL(br_fdb_get_hook);
-EXPORT_SYMBOL(br_fdb_put_hook);
-#endif /* defined(CONFIG_ATM_LANE_MODULE) || defined(CONFIG_BRIDGE_MODULE) */
-#endif /* defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE) */
-#endif /* defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE) */
-
-
 static int __init atm_init(void)
 {
 	int error;
===== net/atm/lec.c 1.47 vs edited =====
--- 1.47/net/atm/lec.c	2005-02-08 23:09:15 -05:00
+++ edited/net/atm/lec.c	2005-03-16 13:18:28 -05:00
@@ -37,11 +37,8 @@
 #if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
 #include <linux/if_bridge.h>
 #include "../bridge/br_private.h"
-static unsigned char bridge_ula_lec[] = {0x01, 0x80, 0xc2, 0x00, 0x00};
 
-extern struct net_bridge_fdb_entry *(*br_fdb_get_hook)(struct net_bridge *br,
-       unsigned char *addr);
-extern void (*br_fdb_put_hook)(struct net_bridge_fdb_entry *ent);
+static unsigned char bridge_ula_lec[] = {0x01, 0x80, 0xc2, 0x00, 0x00};
 #endif
 
 /* Modular too */
===== net/atm/lec.h 1.13 vs edited =====
--- 1.13/net/atm/lec.h	2005-01-18 15:59:15 -05:00
+++ edited/net/atm/lec.h	2005-03-16 13:22:13 -05:00
@@ -14,14 +14,6 @@
 #include <linux/netdevice.h>
 #include <linux/atmlec.h>
 
-#if defined (CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
-#include <linux/if_bridge.h>
-struct net_bridge;
-extern struct net_bridge_fdb_entry *(*br_fdb_get_hook)(struct net_bridge *br,
-                                                unsigned char *addr);
-extern void (*br_fdb_put_hook)(struct net_bridge_fdb_entry *ent);
-#endif /* defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE) */
-
 #define LEC_HEADER_LEN 16
 
 struct lecdatahdr_8023 {
===== net/bridge/br.c 1.20 vs edited =====
--- 1.20/net/bridge/br.c	2005-03-10 21:50:08 -05:00
+++ edited/net/bridge/br.c	2005-03-16 13:21:27 -05:00
@@ -22,10 +22,6 @@
 
 #include "br_private.h"
 
-#if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
-#include "../atm/lec.h"
-#endif
-
 int (*br_should_route_hook) (struct sk_buff **pskb) = NULL;
 
 static int __init br_init(void)
@@ -39,10 +35,9 @@
 	brioctl_set(br_ioctl_deviceless_stub);
 	br_handle_frame_hook = br_handle_frame;
 
-#if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
 	br_fdb_get_hook = br_fdb_get;
 	br_fdb_put_hook = br_fdb_put;
-#endif
+
 	register_netdevice_notifier(&br_device_notifier);
 
 	return 0;
@@ -60,10 +55,8 @@
 
 	synchronize_net();
 
-#if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
 	br_fdb_get_hook = NULL;
 	br_fdb_put_hook = NULL;
-#endif
 
 	br_handle_frame_hook = NULL;
 	br_fdb_fini();
===== net/bridge/br_private.h 1.37 vs edited =====
--- 1.37/net/bridge/br_private.h	2005-03-10 21:51:37 -05:00
+++ edited/net/bridge/br_private.h	2005-03-16 13:19:34 -05:00
@@ -216,6 +216,12 @@
 extern void br_stp_port_timer_init(struct net_bridge_port *p);
 extern unsigned long br_timer_value(const struct timer_list *timer);
 
+/* br.c */
+extern struct net_bridge_fdb_entry *(*br_fdb_get_hook)(struct net_bridge *br,
+						       unsigned char *addr);
+extern void (*br_fdb_put_hook)(struct net_bridge_fdb_entry *ent);
+
+
 #ifdef CONFIG_SYSFS
 /* br_sysfs_if.c */
 extern int br_sysfs_addif(struct net_bridge_port *p);
===== net/core/dev.c 1.185 vs edited =====
--- 1.185/net/core/dev.c	2005-02-11 00:54:32 -05:00
+++ edited/net/core/dev.c	2005-03-16 13:29:23 -05:00
@@ -1561,6 +1561,10 @@
 
 #if defined(CONFIG_BRIDGE) || defined (CONFIG_BRIDGE_MODULE)
 int (*br_handle_frame_hook)(struct net_bridge_port *p, struct sk_buff **pskb);
+struct net_bridge;
+struct net_bridge_fdb_entry *(*br_fdb_get_hook)(struct net_bridge *br,
+						unsigned char *addr);
+void (*br_fdb_put_hook)(struct net_bridge_fdb_entry *ent);
 
 static __inline__ int handle_bridge(struct sk_buff **pskb,
 				    struct packet_type **pt_prev, int *ret)
@@ -3346,6 +3350,8 @@
 
 #if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
 EXPORT_SYMBOL(br_handle_frame_hook);
+EXPORT_SYMBOL(br_fdb_get_hook);
+EXPORT_SYMBOL(br_fdb_put_hook);
 #endif
 
 #ifdef CONFIG_KMOD
