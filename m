Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261710AbTCLAHO>; Tue, 11 Mar 2003 19:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261708AbTCLAHF>; Tue, 11 Mar 2003 19:07:05 -0500
Received: from air-2.osdl.org ([65.172.181.6]:19082 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261695AbTCLAEN>;
	Tue, 11 Mar 2003 19:04:13 -0500
Subject: [PATCH] (5/8) Eliminate brlock from netfilter
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>, David Miller <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0303091831560.2129-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0303091831560.2129-100000@home.transmeta.com>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1047428094.15872.105.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Mar 2003 16:14:54 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace brlock in netfilter code with RCU.

diff -urN -X dontdiff linux-2.5.64/net/core/netfilter.c linux-2.5-nobrlock/net/core/netfilter.c
--- linux-2.5.64/net/core/netfilter.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/core/netfilter.c	2003-03-11 14:39:38.000000000 -0800
@@ -19,7 +19,6 @@
 #include <linux/interrupt.h>
 #include <linux/if.h>
 #include <linux/netdevice.h>
-#include <linux/brlock.h>
 #include <linux/inetdevice.h>
 #include <net/sock.h>
 #include <net/route.h>
@@ -46,6 +45,7 @@
 
 struct list_head nf_hooks[NPROTO][NF_MAX_HOOKS];
 static LIST_HEAD(nf_sockopts);
+static spinlock_t nf_lock = SPIN_LOCK_UNLOCKED;
 
 /* 
  * A queue handler may be registered for each protocol.  Each is protected by
@@ -56,28 +56,31 @@
 	nf_queue_outfn_t outfn;
 	void *data;
 } queue_handler[NPROTO];
+static spinlock_t queue_lock = SPIN_LOCK_UNLOCKED;
 
 int nf_register_hook(struct nf_hook_ops *reg)
 {
 	struct list_head *i;
 
-	br_write_lock_bh(BR_NETPROTO_LOCK);
+	spin_lock_bh(&nf_lock);
 	for (i = nf_hooks[reg->pf][reg->hooknum].next; 
 	     i != &nf_hooks[reg->pf][reg->hooknum]; 
 	     i = i->next) {
 		if (reg->priority < ((struct nf_hook_ops *)i)->priority)
 			break;
 	}
-	list_add(&reg->list, i->prev);
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	list_add_rcu(&reg->list, i->prev);
+	spin_unlock_bh(&nf_lock);
 	return 0;
 }
 
 void nf_unregister_hook(struct nf_hook_ops *reg)
 {
-	br_write_lock_bh(BR_NETPROTO_LOCK);
+	spin_lock_bh(&nf_lock);
 	list_del(&reg->list);
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	spin_unlock_bh(&nf_lock);
+
+	synchronize_kernel();
 }
 
 /* Do exclusive ranges overlap? */
@@ -344,7 +347,9 @@
 			       int (*okfn)(struct sk_buff *),
 			       int hook_thresh)
 {
-	for (*i = (*i)->next; *i != head; *i = (*i)->next) {
+
+	for (*i = (*i)->next; *i != head; *i = (*i)->next,
+		     ({ read_barrier_depends(); 0;})) {
 		struct nf_hook_ops *elem = (struct nf_hook_ops *)*i;
 
 		if (hook_thresh > elem->priority)
@@ -381,15 +386,16 @@
 {      
 	int ret;
 
-	br_write_lock_bh(BR_NETPROTO_LOCK);
+	spin_lock_bh(&queue_lock);
 	if (queue_handler[pf].outfn)
 		ret = -EBUSY;
 	else {
-		queue_handler[pf].outfn = outfn;
 		queue_handler[pf].data = data;
+		wmb();
+		queue_handler[pf].outfn = outfn;
 		ret = 0;
 	}
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	spin_unlock_bh(&queue_lock);
 
 	return ret;
 }
@@ -397,10 +403,14 @@
 /* The caller must flush their queue before this */
 int nf_unregister_queue_handler(int pf)
 {
-	br_write_lock_bh(BR_NETPROTO_LOCK);
+	spin_lock_bh(&queue_lock);
 	queue_handler[pf].outfn = NULL;
+	wmb();
 	queue_handler[pf].data = NULL;
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	spin_unlock_bh(&queue_lock);
+
+	synchronize_kernel();
+
 	return 0;
 }
 
@@ -422,9 +432,10 @@
 	struct net_device *physoutdev = NULL;
 #endif
 
+	rcu_read_lock();
 	if (!queue_handler[pf].outfn) {
 		kfree_skb(skb);
-		return;
+		goto out;
 	}
 
 	info = kmalloc(sizeof(*info), GFP_ATOMIC);
@@ -433,7 +444,7 @@
 			printk(KERN_ERR "OOM queueing packet %p\n",
 			       skb);
 		kfree_skb(skb);
-		return;
+		goto out;
 	}
 
 	*info = (struct nf_info) { 
@@ -463,8 +474,9 @@
 #endif
 		kfree(info);
 		kfree_skb(skb);
-		return;
 	}
+ out:
+	rcu_read_unlock();
 }
 
 int nf_hook_slow(int pf, unsigned int hook, struct sk_buff *skb,
@@ -491,7 +503,7 @@
 	}
 
 	/* We may already have this, but read-locks nest anyway */
-	br_read_lock_bh(BR_NETPROTO_LOCK);
+	rcu_read_lock();
 
 #ifdef CONFIG_NETFILTER_DEBUG
 	if (skb->nf_debug & (1 << hook)) {
@@ -520,7 +532,7 @@
 		break;
 	}
 
-	br_read_unlock_bh(BR_NETPROTO_LOCK);
+	rcu_read_unlock();
 	return ret;
 }
 
@@ -530,8 +542,7 @@
 	struct list_head *elem = &info->elem->list;
 	struct list_head *i;
 
-	/* We don't have BR_NETPROTO_LOCK here */
-	br_read_lock_bh(BR_NETPROTO_LOCK);
+	rcu_read_lock();
 	for (i = nf_hooks[info->pf][info->hook].next; i != elem; i = i->next) {
 		if (i == &nf_hooks[info->pf][info->hook]) {
 			/* The module which sent it to userspace is gone. */
@@ -569,7 +580,7 @@
 		kfree_skb(skb);
 		break;
 	}
-	br_read_unlock_bh(BR_NETPROTO_LOCK);
+	rcu_read_unlock();
 
 	/* Release those devices we held, or Alexey will kill me. */
 	if (info->indev) dev_put(info->indev);



