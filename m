Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262588AbTCMWdy>; Thu, 13 Mar 2003 17:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262571AbTCMW37>; Thu, 13 Mar 2003 17:29:59 -0500
Received: from air-2.osdl.org ([65.172.181.6]:57002 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262572AbTCMW3Z>;
	Thu, 13 Mar 2003 17:29:25 -0500
Subject: [PATCH] (2/5) Remvoe brlock from snap and vlan
From: Stephen Hemminger <shemminger@osdl.org>
To: Andrew Morton <akpm@digeo.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1047595207.3134.104.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 13 Mar 2003 14:40:07 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove brlock from snap and vlan.

Change in snap unregister path from earlier version to use synchronize_kernel.

This code needs further testing before final 2.5 inclusion.
(Kind of wonder if anyone actually ever uses this?)

diff -urN -X dontdiff linux-2.5.64/net/802/psnap.c linux-2.5-nobrlock/net/802/psnap.c
--- linux-2.5.64/net/802/psnap.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/802/psnap.c	2003-03-12 15:34:53.000000000 -0800
@@ -21,10 +21,10 @@
 #include <linux/mm.h>
 #include <linux/in.h>
 #include <linux/init.h>
-#include <linux/brlock.h>
 
 LIST_HEAD(snap_list);
 static struct llc_sap *snap_sap;
+static spinlock_t snap_lock = SPIN_LOCK_UNLOCKED;
 
 /*
  *	Find a snap client by matching the 5 bytes.
@@ -34,17 +34,15 @@
 	struct list_head *entry;
 	struct datalink_proto *proto = NULL, *p;
 
-	if (list_empty(&snap_list))
-		goto out;
-
-	list_for_each(entry, &snap_list) {
+	rcu_read_lock();
+	list_for_each_rcu(entry, &snap_list) {
 		p = list_entry(entry, struct datalink_proto, node);
 		if (!memcmp(p->type, desc, 5)) {
 			proto = p;
 			break;
 		}
 	}
-out:
+	rcu_read_unlock();
 	return proto;
 }
 
@@ -124,8 +122,7 @@
 {
 	struct datalink_proto *proto = NULL;
 
-	br_write_lock_bh(BR_NETPROTO_LOCK);
-
+	spin_lock_bh(&snap_lock);
 	if (find_snap_client(desc))
 		goto out;
 
@@ -135,10 +132,10 @@
 		proto->rcvfunc		= rcvfunc;
 		proto->header_length	= 5 + 3; /* snap + 802.2 */
 		proto->request		= snap_request;
-		list_add(&proto->node, &snap_list);
+		list_add_rcu(&proto->node, &snap_list);
 	}
 out:
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	spin_unlock_bh(&snap_lock);
 	return proto;
 }
 
@@ -147,12 +144,13 @@
  */
 void unregister_snap_client(struct datalink_proto *proto)
 {
-	br_write_lock_bh(BR_NETPROTO_LOCK);
+	spin_lock_bh(&snap_lock);
+	list_del_rcu(&proto->node);
+	spin_unlock_bh(&snap_lock);
 
-	list_del(&proto->node);
+	synchronize_kernel();	/* wait for RCU */
 	kfree(proto);
 
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
 }
 
 MODULE_LICENSE("GPL");
diff -urN -X dontdiff linux-2.5.64/net/8021q/vlan.c linux-2.5-nobrlock/net/8021q/vlan.c
--- linux-2.5.64/net/8021q/vlan.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/8021q/vlan.c	2003-03-12 14:52:40.000000000 -0800
@@ -29,7 +29,6 @@
 #include <net/p8022.h>
 #include <net/arp.h>
 #include <linux/rtnetlink.h>
-#include <linux/brlock.h>
 #include <linux/notifier.h>
 
 #include <linux/if_vlan.h>
@@ -68,7 +67,6 @@
 	.dev =NULL,
 	.func = vlan_skb_recv, /* VLAN receive method */
 	.data = (void *)(-1),  /* Set here '(void *)1' when this code can SHARE SKBs */
-	.next = NULL
 };
 
 /* End of global variables definitions. */
@@ -231,9 +229,11 @@
 				real_dev->vlan_rx_kill_vid(real_dev, vlan_id);
 			}
 
-			br_write_lock(BR_NETPROTO_LOCK);
 			grp->vlan_devices[vlan_id] = NULL;
-			br_write_unlock(BR_NETPROTO_LOCK);
+
+			/* wait for RCU in network receive */
+			smp_wmb();
+			synchronize_kernel();
 
 
 			/* Caller unregisters (and if necessary, puts)
diff -urN -X dontdiff linux-2.5.64/net/8021q/vlan_dev.c linux-2.5-nobrlock/net/8021q/vlan_dev.c
--- linux-2.5.64/net/8021q/vlan_dev.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/8021q/vlan_dev.c	2003-03-12 14:52:40.000000000 -0800
@@ -31,7 +31,6 @@
 #include <net/datalink.h>
 #include <net/p8022.h>
 #include <net/arp.h>
-#include <linux/brlock.h>
 
 #include "vlan.h"
 #include "vlanproc.h"



