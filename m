Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261703AbTCLAE5>; Tue, 11 Mar 2003 19:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261694AbTCLAEE>; Tue, 11 Mar 2003 19:04:04 -0500
Received: from air-2.osdl.org ([65.172.181.6]:13194 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261681AbTCLADy>;
	Tue, 11 Mar 2003 19:03:54 -0500
Subject: [PATCH] (1/8) Eliminate brlock in psnap
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>, David Miller <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0303091831560.2129-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0303091831560.2129-100000@home.transmeta.com>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1047428075.15875.97.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Mar 2003 16:14:36 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following replaces brlock with RCU in the SNAP module.

diff -urN -X dontdiff linux-2.5.64/net/802/psnap.c linux-2.5-nobrlock/net/802/psnap.c
--- linux-2.5.64/net/802/psnap.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/802/psnap.c	2003-03-10 15:48:53.000000000 -0800
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
+	static RCU_HEAD(snap_rcu);
 
-	list_del(&proto->node);
-	kfree(proto);
+	spin_lock_bh(&snap_lock);
+	list_del_rcu(&proto->node);
+	spin_unlock_bh(&snap_lock);
 
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	call_rcu(&snap_rcu, (void (*)(void *)) kfree, proto);
 }
 
 MODULE_LICENSE("GPL");



