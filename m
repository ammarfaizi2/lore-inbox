Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262570AbTCMW32>; Thu, 13 Mar 2003 17:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262573AbTCMW32>; Thu, 13 Mar 2003 17:29:28 -0500
Received: from air-2.osdl.org ([65.172.181.6]:39080 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262570AbTCMW3H>;
	Thu, 13 Mar 2003 17:29:07 -0500
Subject: [PATCH] (1/5) Brlock removal - core
From: Stephen Hemminger <shemminger@osdl.org>
To: Andrew Morton <akpm@digeo.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1047595191.3141.100.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 13 Mar 2003 14:39:51 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes brlock from network receive core.  Packet type is
changed to an RCU list.  

The netfilter code also uses RCU list. Had to recode/remove the
nf_iterate procedure to use list_for_each macro which was preferable to
propagating the RCU special stuff into this code.

Also added barrier() to avoid possible compiler optimization when a
reference to a hook could change between when it is tested and used.

diff -urN -X dontdiff linux-2.5.64/include/linux/netdevice.h linux-2.5-nobrlock/include/linux/netdevice.h
--- linux-2.5.64/include/linux/netdevice.h	2003-03-11 09:08:00.000000000 -0800
+++ linux-2.5-nobrlock/include/linux/netdevice.h	2003-03-12 14:52:22.000000000 -0800
@@ -452,7 +452,7 @@
 	int			(*func) (struct sk_buff *, struct net_device *,
 					 struct packet_type *);
 	void			*data;	/* Private to the packet type		*/
-	struct packet_type	*next;
+	struct list_head	packet_list;
 };
 
 
diff -urN -X dontdiff linux-2.5.64/net/core/dev.c linux-2.5-nobrlock/net/core/dev.c
--- linux-2.5.64/net/core/dev.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/core/dev.c	2003-03-13 12:05:01.000000000 -0800
@@ -90,7 +90,6 @@
 #include <linux/etherdevice.h>
 #include <linux/notifier.h>
 #include <linux/skbuff.h>
-#include <linux/brlock.h>
 #include <net/sock.h>
 #include <linux/rtnetlink.h>
 #include <linux/proc_fs.h>
@@ -170,8 +169,11 @@
  *		86DD	IPv6
  */
 
-static struct packet_type *ptype_base[16];	/* 16 way hashed list */
-static struct packet_type *ptype_all;		/* Taps */
+static spinlock_t ptype_lock = SPIN_LOCK_UNLOCKED;
+static struct list_head ptype_base[16];	/* 16 way hashed list */
+static struct list_head ptype_all;	/* Taps */
+
+static spinlock_t master_lock = SPIN_LOCK_UNLOCKED;
 
 #ifdef OFFLINE_SAMPLE
 static void sample_queue(unsigned long dummy);
@@ -203,7 +205,6 @@
 
 static struct subsystem net_subsys;
 
-
 /*******************************************************************************
 
 		Protocol management and registration routines
@@ -245,8 +246,7 @@
 {
 	int hash;
 
-	br_write_lock_bh(BR_NETPROTO_LOCK);
-
+	spin_lock_bh(&ptype_lock);
 #ifdef CONFIG_NET_FASTROUTE
 	/* Hack to detect packet socket */
 	if (pt->data && (long)(pt->data) != 1) {
@@ -256,14 +256,12 @@
 #endif
 	if (pt->type == htons(ETH_P_ALL)) {
 		netdev_nit++;
-		pt->next  = ptype_all;
-		ptype_all = pt;
+		list_add_rcu(&pt->packet_list, &ptype_all);
 	} else {
 		hash = ntohs(pt->type) & 15;
-		pt->next = ptype_base[hash];
-		ptype_base[hash] = pt;
+		list_add_rcu(&pt->packet_list, &ptype_base[hash]);
 	}
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	spin_unlock_bh(&ptype_lock);
 }
 
 extern void linkwatch_run_queue(void);
@@ -279,29 +277,30 @@
  */
 void dev_remove_pack(struct packet_type *pt)
 {
-	struct packet_type **pt1;
+	struct list_head *head, *pelem;
 
-	br_write_lock_bh(BR_NETPROTO_LOCK);
-
-	if (pt->type == htons(ETH_P_ALL)) {
-		netdev_nit--;
-		pt1 = &ptype_all;
-	} else
-		pt1 = &ptype_base[ntohs(pt->type) & 15];
-
-	for (; *pt1; pt1 = &((*pt1)->next)) {
-		if (pt == *pt1) {
-			*pt1 = pt->next;
+	if (pt->type == htons(ETH_P_ALL))
+		head = &ptype_all;
+	else 
+		head =  &ptype_base[ntohs(pt->type) & 15];
+	
+	spin_lock_bh(&ptype_lock);
+	list_for_each(pelem, head) {
+		if (list_entry(pelem, struct packet_type, packet_list) == pt) {
+			list_del(pelem);
 #ifdef CONFIG_NET_FASTROUTE
 			if (pt->data)
 				netdev_fastroute_obstacles--;
 #endif
+			if (pt->type == htons(ETH_P_ALL)) 
+				netdev_nit--;
 			goto out;
 		}
 	}
 	printk(KERN_WARNING "dev_remove_pack: %p not found.\n", pt);
-out:
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+
+ out:
+	spin_unlock_bh(&ptype_lock);
 }
 
 /******************************************************************************
@@ -896,11 +895,13 @@
 
 void dev_queue_xmit_nit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct packet_type *ptype;
+	struct list_head *plist;
 	do_gettimeofday(&skb->stamp);
 
-	br_read_lock(BR_NETPROTO_LOCK);
-	for (ptype = ptype_all; ptype; ptype = ptype->next) {
+	rcu_read_lock();
+	list_for_each_rcu(plist, &ptype_all) {
+		struct packet_type *ptype
+			= list_entry(plist, struct packet_type, packet_list);
 		/* Never send packets back to the socket
 		 * they originated from - MvS (miquels@drinkel.ow.org)
 		 */
@@ -930,7 +931,7 @@
 			ptype->func(skb2, skb->dev, ptype);
 		}
 	}
-	br_read_unlock(BR_NETPROTO_LOCK);
+	rcu_read_unlock();
 }
 
 /* Calculate csum in the case, when packet is misrouted.
@@ -1423,6 +1424,7 @@
 
 int netif_receive_skb(struct sk_buff *skb)
 {
+	struct list_head *pcur;
 	struct packet_type *ptype, *pt_prev;
 	int ret = NET_RX_DROP;
 	unsigned short type = skb->protocol;
@@ -1443,8 +1445,10 @@
 
 	skb->h.raw = skb->nh.raw = skb->data;
 
+	rcu_read_lock();
 	pt_prev = NULL;
-	for (ptype = ptype_all; ptype; ptype = ptype->next) {
+	list_for_each_rcu(pcur, &ptype_all) {
+		ptype = list_entry(pcur, struct packet_type, packet_list);
 		if (!ptype->dev || ptype->dev == skb->dev) {
 			if (pt_prev) {
 				if (!pt_prev->data) {
@@ -1466,17 +1470,23 @@
 #endif /* CONFIG_NET_DIVERT */
 
 #if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
-	if (skb->dev->br_port && br_handle_frame_hook) {
-		int ret;
+	if (skb->dev->br_port) {
+		int (*curhook)(struct sk_buff *) = br_handle_frame_hook;
 
-		ret = handle_bridge(skb, pt_prev);
-		if (br_handle_frame_hook(skb) == 0)
-			return ret;
-		pt_prev = NULL;
+		barrier();	/* prevent compiler RCU problems */
+		if (curhook) {
+			int ret;
+			ret = handle_bridge(skb, pt_prev);
+			if (curhook(skb) == 0)
+				return ret;
+			pt_prev = NULL;
+		}
 	}
 #endif
 
-	for (ptype = ptype_base[ntohs(type) & 15]; ptype; ptype = ptype->next) {
+	list_for_each_rcu(pcur, &ptype_base[ntohs(type) & 15]) {
+		ptype = list_entry(pcur, struct packet_type, packet_list);
+
 		if (ptype->type == type &&
 		    (!ptype->dev || ptype->dev == skb->dev)) {
 			if (pt_prev) {
@@ -1506,6 +1516,7 @@
 		 */
 		ret = NET_RX_DROP;
 	}
+	rcu_read_unlock();
 
 	return ret;
 }
@@ -1580,7 +1591,7 @@
 	unsigned long start_time = jiffies;
 	int budget = netdev_max_backlog;
 
-	br_read_lock(BR_NETPROTO_LOCK);
+	preempt_disable();
 	local_irq_disable();
 
 	while (!list_empty(&queue->poll_list)) {
@@ -1609,7 +1620,7 @@
 	}
 out:
 	local_irq_enable();
-	br_read_unlock(BR_NETPROTO_LOCK);
+	preempt_enable();
 	return;
 
 softnet_break:
@@ -1925,7 +1936,6 @@
 #define dev_proc_init() 0
 #endif	/* CONFIG_PROC_FS */
 
-
 /**
  *	netdev_set_master	-	set up master/slave pair
  *	@slave: slave device
@@ -1943,18 +1953,23 @@
 
 	ASSERT_RTNL();
 
+	spin_lock_bh(&master_lock);
 	if (master) {
-		if (old)
+		if (old) {
+			spin_unlock_bh(&master_lock);
 			return -EBUSY;
+		}
 		dev_hold(master);
 	}
 
-	br_write_lock_bh(BR_NETPROTO_LOCK);
 	slave->master = master;
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	spin_unlock_bh(&master_lock);
 
-	if (old)
+	if (old) {
+		/* wait for all BH */
+		synchronize_kernel();
 		dev_put(old);
+	}
 
 	if (master)
 		slave->flags |= IFF_SLAVE;
@@ -1962,6 +1977,7 @@
 		slave->flags &= ~IFF_SLAVE;
 
 	rtmsg_ifinfo(RTM_NEWLINK, slave, IFF_SLAVE);
+
 	return 0;
 }
 
@@ -2646,10 +2662,9 @@
 		return -ENODEV;
 	}
 
-	/* Synchronize to net_rx_action. */
-	br_write_lock_bh(BR_NETPROTO_LOCK);
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
-
+	/* wait for RCU */
+	smp_wmb();
+	synchronize_kernel();
 
 #ifdef CONFIG_NET_FASTROUTE
 	dev_clear_fastroute(dev);
@@ -2755,7 +2770,6 @@
 	return 0;
 }
 
-
 /*
  *	Initialize the DEV module. At boot time this walks the device list and
  *	unhooks any devices that fail to initialise (normally hardware not
@@ -2786,6 +2800,11 @@
 	if (dev_proc_init())
 		goto out;
 
+	/* Initialize packet type chains */
+	INIT_LIST_HEAD(&ptype_all);
+	for (i = 0; i < ARRAY_SIZE(ptype_base); i++) 
+	        INIT_LIST_HEAD(&ptype_base[i]);
+
 	subsystem_register(&net_subsys);
 
 #ifdef CONFIG_NET_DIVERT
diff -urN -X dontdiff linux-2.5.64/net/core/netfilter.c linux-2.5-nobrlock/net/core/netfilter.c
--- linux-2.5.64/net/core/netfilter.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/core/netfilter.c	2003-03-13 09:53:03.000000000 -0800
@@ -19,7 +19,6 @@
 #include <linux/interrupt.h>
 #include <linux/if.h>
 #include <linux/netdevice.h>
-#include <linux/brlock.h>
 #include <linux/inetdevice.h>
 #include <net/sock.h>
 #include <net/route.h>
@@ -44,8 +43,12 @@
    sleep. */
 static DECLARE_MUTEX(nf_sockopt_mutex);
 
+/*
+ * nf_hooks are protected by using read-copy-update
+ */
 struct list_head nf_hooks[NPROTO][NF_MAX_HOOKS];
 static LIST_HEAD(nf_sockopts);
+static spinlock_t nf_hook_lock = SPIN_LOCK_UNLOCKED;
 
 /* 
  * A queue handler may be registered for each protocol.  Each is protected by
@@ -56,28 +59,34 @@
 	nf_queue_outfn_t outfn;
 	void *data;
 } queue_handler[NPROTO];
+static rwlock_t queue_handler_lock = RW_LOCK_UNLOCKED;
 
 int nf_register_hook(struct nf_hook_ops *reg)
 {
 	struct list_head *i;
 
-	br_write_lock_bh(BR_NETPROTO_LOCK);
+	spin_lock_bh(&nf_hook_lock);
 	for (i = nf_hooks[reg->pf][reg->hooknum].next; 
 	     i != &nf_hooks[reg->pf][reg->hooknum]; 
 	     i = i->next) {
 		if (reg->priority < ((struct nf_hook_ops *)i)->priority)
 			break;
 	}
-	list_add(&reg->list, i->prev);
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	list_add_rcu(&reg->list, i->prev);
+	spin_unlock_bh(&nf_hook_lock);
+
+	synchronize_kernel();
 	return 0;
 }
 
 void nf_unregister_hook(struct nf_hook_ops *reg)
 {
-	br_write_lock_bh(BR_NETPROTO_LOCK);
-	list_del(&reg->list);
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	spin_lock_bh(&nf_hook_lock);
+	list_del_rcu(&reg->list);
+	spin_unlock_bh(&nf_hook_lock);
+
+	/* wait for all receivers that may still be using hook */
+	synchronize_kernel();
 }
 
 /* Do exclusive ranges overlap? */
@@ -335,61 +344,19 @@
 	return nf_sockopt(sk, pf, val, opt, len, 1);
 }
 
-static unsigned int nf_iterate(struct list_head *head,
-			       struct sk_buff **skb,
-			       int hook,
-			       const struct net_device *indev,
-			       const struct net_device *outdev,
-			       struct list_head **i,
-			       int (*okfn)(struct sk_buff *),
-			       int hook_thresh)
-{
-	for (*i = (*i)->next; *i != head; *i = (*i)->next) {
-		struct nf_hook_ops *elem = (struct nf_hook_ops *)*i;
-
-		if (hook_thresh > elem->priority)
-			continue;
-
-		switch (elem->hook(hook, skb, indev, outdev, okfn)) {
-		case NF_QUEUE:
-			return NF_QUEUE;
-
-		case NF_STOLEN:
-			return NF_STOLEN;
-
-		case NF_DROP:
-			return NF_DROP;
-
-		case NF_REPEAT:
-			*i = (*i)->prev;
-			break;
-
-#ifdef CONFIG_NETFILTER_DEBUG
-		case NF_ACCEPT:
-			break;
-
-		default:
-			NFDEBUG("Evil return from %p(%u).\n", 
-				elem->hook, hook);
-#endif
-		}
-	}
-	return NF_ACCEPT;
-}
-
 int nf_register_queue_handler(int pf, nf_queue_outfn_t outfn, void *data)
 {      
 	int ret;
 
-	br_write_lock_bh(BR_NETPROTO_LOCK);
+	write_lock_bh(&queue_handler_lock);
 	if (queue_handler[pf].outfn)
 		ret = -EBUSY;
 	else {
-		queue_handler[pf].outfn = outfn;
 		queue_handler[pf].data = data;
+		queue_handler[pf].outfn = outfn;
 		ret = 0;
 	}
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	write_unlock_bh(&queue_handler_lock);
 
 	return ret;
 }
@@ -397,10 +364,11 @@
 /* The caller must flush their queue before this */
 int nf_unregister_queue_handler(int pf)
 {
-	br_write_lock_bh(BR_NETPROTO_LOCK);
+	write_lock_bh(&queue_handler_lock);
 	queue_handler[pf].outfn = NULL;
 	queue_handler[pf].data = NULL;
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	write_unlock_bh(&queue_handler_lock);
+
 	return 0;
 }
 
@@ -422,9 +390,10 @@
 	struct net_device *physoutdev = NULL;
 #endif
 
+	read_lock(&queue_handler_lock);
 	if (!queue_handler[pf].outfn) {
 		kfree_skb(skb);
-		return;
+		goto out;
 	}
 
 	info = kmalloc(sizeof(*info), GFP_ATOMIC);
@@ -433,7 +402,7 @@
 			printk(KERN_ERR "OOM queueing packet %p\n",
 			       skb);
 		kfree_skb(skb);
-		return;
+		goto out;
 	}
 
 	*info = (struct nf_info) { 
@@ -463,8 +432,9 @@
 #endif
 		kfree(info);
 		kfree_skb(skb);
-		return;
 	}
+ out:
+	read_unlock(&queue_handler_lock);
 }
 
 int nf_hook_slow(int pf, unsigned int hook, struct sk_buff *skb,
@@ -474,7 +444,7 @@
 		 int hook_thresh)
 {
 	struct list_head *elem;
-	unsigned int verdict;
+	unsigned int verdict = NF_ACCEPT;
 	int ret = 0;
 
 	/* This stopgap cannot be removed until all the hooks are audited. */
@@ -490,9 +460,7 @@
 		}
 	}
 
-	/* We may already have this, but read-locks nest anyway */
-	br_read_lock_bh(BR_NETPROTO_LOCK);
-
+	rcu_read_lock();
 #ifdef CONFIG_NETFILTER_DEBUG
 	if (skb->nf_debug & (1 << hook)) {
 		printk("nf_hook: hook %i already set.\n", hook);
@@ -501,15 +469,23 @@
 	skb->nf_debug |= (1 << hook);
 #endif
 
-	elem = &nf_hooks[pf][hook];
-	verdict = nf_iterate(&nf_hooks[pf][hook], &skb, hook, indev,
-			     outdev, &elem, okfn, hook_thresh);
-	if (verdict == NF_QUEUE) {
-		NFDEBUG("nf_hook: Verdict = QUEUE.\n");
-		nf_queue(skb, elem, pf, hook, indev, outdev, okfn);
+	list_for_each_rcu(elem, &nf_hooks[pf][hook]) {
+		const struct nf_hook_ops *ops
+			= list_entry(elem, const struct nf_hook_ops, list);
+
+		if (hook_thresh > ops->priority)
+			continue;
+
+		verdict = ops->hook(hook, &skb, indev, outdev, okfn);
+		break;
 	}
 
 	switch (verdict) {
+	case NF_QUEUE:
+		NFDEBUG("nf_hook: Verdict = QUEUE.\n");
+		nf_queue(skb, elem, pf, hook, indev, outdev, okfn);
+		break;
+
 	case NF_ACCEPT:
 		ret = okfn(skb);
 		break;
@@ -520,7 +496,7 @@
 		break;
 	}
 
-	br_read_unlock_bh(BR_NETPROTO_LOCK);
+	rcu_read_unlock();
 	return ret;
 }
 
@@ -528,48 +504,62 @@
 		 unsigned int verdict)
 {
 	struct list_head *elem = &info->elem->list;
-	struct list_head *i;
+	const struct list_head *head = &nf_hooks[info->pf][info->hook];
+	int skipping = 1;
+	const struct list_head *i;
 
-	/* We don't have BR_NETPROTO_LOCK here */
-	br_read_lock_bh(BR_NETPROTO_LOCK);
-	for (i = nf_hooks[info->pf][info->hook].next; i != elem; i = i->next) {
-		if (i == &nf_hooks[info->pf][info->hook]) {
-			/* The module which sent it to userspace is gone. */
-			NFDEBUG("%s: module disappeared, dropping packet.\n",
-			         __FUNCTION__);
-			verdict = NF_DROP;
-			break;
+	rcu_read_lock();
+	list_for_each_rcu(i, head) {
+		/* traverse loop until we find elem */
+		if (skipping) {
+			if (i != elem) 
+				continue;
+
+			skipping = 0;
+			/* Continue and process next element */
+			if (verdict == NF_ACCEPT) 
+				continue;
+
+			/* Process this element again */
+			if (verdict == NF_REPEAT) 
+				verdict = NF_ACCEPT;
 		}
-	}
 
-	/* Continue traversal iff userspace said ok... */
-	if (verdict == NF_REPEAT) {
-		elem = elem->prev;
-		verdict = NF_ACCEPT;
-	}
+		if (verdict == NF_ACCEPT) {
+			const struct nf_hook_ops *ops
+				= list_entry(elem, typeof(*ops), list);
 
-	if (verdict == NF_ACCEPT) {
-		verdict = nf_iterate(&nf_hooks[info->pf][info->hook],
-				     &skb, info->hook, 
-				     info->indev, info->outdev, &elem,
-				     info->okfn, INT_MIN);
-	}
+			verdict = ops->hook(info->hook, &skb, 
+					    info->indev, info->outdev, 
+					    info->okfn);
+		}
 
-	switch (verdict) {
-	case NF_ACCEPT:
-		info->okfn(skb);
-		break;
+		switch (verdict) {
+		case NF_ACCEPT:
+			info->okfn(skb);
+			break;
 
-	case NF_QUEUE:
-		nf_queue(skb, elem, info->pf, info->hook, 
-			 info->indev, info->outdev, info->okfn);
+		case NF_QUEUE:
+			nf_queue(skb, elem, info->pf, info->hook, 
+				 info->indev, info->outdev, info->okfn);
+			break;
+
+		case NF_DROP:
+			kfree_skb(skb);
+			break;
+		}
 		break;
+	}
 
-	case NF_DROP:
+	if (skipping) {
+		/* The module which sent it to userspace is gone. */
+		NFDEBUG("%s: module disappeared, dropping packet.\n",
+			__FUNCTION__);
 		kfree_skb(skb);
-		break;
 	}
-	br_read_unlock_bh(BR_NETPROTO_LOCK);
+
+
+	rcu_read_unlock();
 
 	/* Release those devices we held, or Alexey will kill me. */
 	if (info->indev) dev_put(info->indev);



