Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261711AbTCLAJn>; Tue, 11 Mar 2003 19:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261708AbTCLAHS>; Tue, 11 Mar 2003 19:07:18 -0500
Received: from air-2.osdl.org ([65.172.181.6]:18570 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261681AbTCLAEM>;
	Tue, 11 Mar 2003 19:04:12 -0500
Subject: [PATCH] (4/8) Eliminate brlock in net/bridge
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>, David Miller <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0303091831560.2129-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0303091831560.2129-100000@home.transmeta.com>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1047428091.15874.103.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Mar 2003 16:14:51 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate brlock in bridge code.

diff -urN -X dontdiff linux-2.5.64/net/bridge/br.c linux-2.5-nobrlock/net/bridge/br.c
--- linux-2.5.64/net/bridge/br.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/bridge/br.c	2003-03-10 15:49:15.000000000 -0800
@@ -21,7 +21,6 @@
 #include <linux/etherdevice.h>
 #include <linux/init.h>
 #include <linux/if_bridge.h>
-#include <linux/brlock.h>
 #include <asm/uaccess.h>
 #include "br_private.h"
 
@@ -73,14 +72,15 @@
 	unregister_netdevice_notifier(&br_device_notifier);
 	br_call_ioctl_atomic(__br_clear_ioctl_hook);
 
-	br_write_lock_bh(BR_NETPROTO_LOCK);
 	br_handle_frame_hook = NULL;
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
 
 #if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
 	br_fdb_get_hook = NULL;
 	br_fdb_put_hook = NULL;
 #endif
+
+	/* netif_receive_skb uses RCU */
+	synchronize_kernel();
 }
 
 EXPORT_SYMBOL(br_should_route_hook);
diff -urN -X dontdiff linux-2.5.64/net/bridge/br_if.c linux-2.5-nobrlock/net/bridge/br_if.c
--- linux-2.5.64/net/bridge/br_if.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/bridge/br_if.c	2003-03-10 15:50:54.000000000 -0800
@@ -18,7 +18,6 @@
 #include <linux/if_bridge.h>
 #include <linux/inetdevice.h>
 #include <linux/rtnetlink.h>
-#include <linux/brlock.h>
 #include <asm/uaccess.h>
 #include "br_private.h"
 
@@ -87,12 +86,11 @@
 
 static void del_ifs(struct net_bridge *br)
 {
-	br_write_lock_bh(BR_NETPROTO_LOCK);
 	write_lock(&br->lock);
 	while (br->port_list != NULL)
 		__br_del_if(br, br->port_list->dev);
 	write_unlock(&br->lock);
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	synchronize_kernel();
 }
 
 static struct net_bridge *new_nb(char *name)
@@ -257,13 +255,12 @@
 {
 	int retval;
 
-	br_write_lock_bh(BR_NETPROTO_LOCK);
 	write_lock(&br->lock);
 	retval = __br_del_if(br, dev);
 	br_stp_recalculate_bridge_id(br);
 	write_unlock(&br->lock);
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
 
+	synchronize_kernel();
 	return retval;
 }
 
diff -urN -X dontdiff linux-2.5.64/net/bridge/netfilter/ebtable_broute.c linux-2.5-nobrlock/net/bridge/netfilter/ebtable_broute.c
--- linux-2.5.64/net/bridge/netfilter/ebtable_broute.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/bridge/netfilter/ebtable_broute.c	2003-03-11 15:04:04.000000000 -0800
@@ -14,7 +14,6 @@
 #include <linux/netfilter_bridge/ebtables.h>
 #include <linux/module.h>
 #include <linux/if_bridge.h>
-#include <linux/brlock.h>
 
 // EBT_ACCEPT means the frame will be bridged
 // EBT_DROP means the frame will be routed
@@ -68,18 +67,17 @@
 	ret = ebt_register_table(&broute_table);
 	if (ret < 0)
 		return ret;
-	br_write_lock_bh(BR_NETPROTO_LOCK);
 	// see br_input.c
 	br_should_route_hook = ebt_broute;
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	synchronize_kernel();
+
 	return ret;
 }
 
 static void __exit fini(void)
 {
-	br_write_lock_bh(BR_NETPROTO_LOCK);
 	br_should_route_hook = NULL;
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	synchronize_kernel();
 	ebt_unregister_table(&broute_table);
 }
 



