Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261729AbTCLASH>; Tue, 11 Mar 2003 19:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262986AbTCLASC>; Tue, 11 Mar 2003 19:18:02 -0500
Received: from air-2.osdl.org ([65.172.181.6]:60049 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261729AbTCLAPH>;
	Tue, 11 Mar 2003 19:15:07 -0500
Subject: Re: [PATCH] (2/8) Eliminate brlock for packet_type
From: Stephen Hemminger <shemminger@osdl.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-net@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030311.162053.107169287.davem@redhat.com>
References: <Pine.LNX.4.44.0303091831560.2129-100000@home.transmeta.com>
	 <1047428080.15872.99.camel@dell_ss3.pdx.osdl.net>
	 <20030311.162053.107169287.davem@redhat.com>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1047428747.15869.116.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Mar 2003 16:25:48 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-11 at 16:20, David S. Miller wrote:
>    From: Stephen Hemminger <shemminger@osdl.org>
>    Date: 11 Mar 2003 16:14:40 -0800
> 
>    Replace linked list for packet_type with brlock with list macros and RCU.
>    
> Then why is a VLAN patch attached?

Little pieces breed confusion...this is the right piece.

diff -urN -X dontdiff linux-2.5.64/include/linux/netdevice.h linux-2.5-nobrlock/include/linux/netdevice.h
--- linux-2.5.64/include/linux/netdevice.h	2003-03-11 09:08:00.000000000 -0800
+++ linux-2.5-nobrlock/include/linux/netdevice.h	2003-03-11 14:15:17.000000000 -0800
@@ -452,7 +452,7 @@
 	int			(*func) (struct sk_buff *, struct net_device *,
 					 struct packet_type *);
 	void			*data;	/* Private to the packet type		*/
-	struct packet_type	*next;
+	struct list_head	packet_list;
 };
 
 
diff -urN -X dontdiff linux-2.5.64/net/core/dev.c linux-2.5-nobrlock/net/core/dev.c
--- linux-2.5.64/net/core/dev.c	2003-03-11 09:08:01.000000000 -0800
+++ linux-2.5-nobrlock/net/core/dev.c	2003-03-11 14:37:36.000000000 -0800
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
-
-	br_write_lock_bh(BR_NETPROTO_LOCK);
+	struct list_head *head, *pelem;
 
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
@@ -1476,7 +1480,9 @@
 	}
 #endif
 
-	for (ptype = ptype_base[ntohs(type) & 15]; ptype; ptype = ptype->next) {
+	list_for_each_rcu(pcur, &ptype_base[ntohs(type) & 15]) {
+		ptype = list_entry(pcur, struct packet_type, packet_list);
+
 		if (ptype->type == type &&
 		    (!ptype->dev || ptype->dev == skb->dev)) {
 			if (pt_prev) {
@@ -1506,6 +1512,7 @@
 		 */
 		ret = NET_RX_DROP;
 	}
+	rcu_read_unlock();
 
 	return ret;
 }
@@ -1580,7 +1587,7 @@
 	unsigned long start_time = jiffies;
 	int budget = netdev_max_backlog;
 
-	br_read_lock(BR_NETPROTO_LOCK);
+	preempt_disable();
 	local_irq_disable();
 
 	while (!list_empty(&queue->poll_list)) {
@@ -1609,7 +1616,7 @@
 	}
 out:
 	local_irq_enable();
-	br_read_unlock(BR_NETPROTO_LOCK);
+	preempt_enable();
 	return;
 
 softnet_break:
@@ -1925,6 +1932,10 @@
 #define dev_proc_init() 0
 #endif	/* CONFIG_PROC_FS */
 
+static RCU_HEAD(netdev_master_rcu);
+static void unset_old_master(void *arg) {
+	dev_put((struct net_device *) arg);
+}
 
 /**
  *	netdev_set_master	-	set up master/slave pair
@@ -1943,18 +1954,20 @@
 
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
-		dev_put(old);
+	if (old) 
+		call_rcu(&netdev_master_rcu, unset_old_master, old);
 
 	if (master)
 		slave->flags |= IFF_SLAVE;
@@ -1962,6 +1975,7 @@
 		slave->flags &= ~IFF_SLAVE;
 
 	rtmsg_ifinfo(RTM_NEWLINK, slave, IFF_SLAVE);
+
 	return 0;
 }
 
@@ -2646,10 +2660,7 @@
 		return -ENODEV;
 	}
 
-	/* Synchronize to net_rx_action. */
-	br_write_lock_bh(BR_NETPROTO_LOCK);
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
-
+	synchronize_kernel();
 
 #ifdef CONFIG_NET_FASTROUTE
 	dev_clear_fastroute(dev);
@@ -2755,7 +2766,6 @@
 	return 0;
 }
 
-
 /*
  *	Initialize the DEV module. At boot time this walks the device list and
  *	unhooks any devices that fail to initialise (normally hardware not
@@ -2786,6 +2796,11 @@
 	if (dev_proc_init())
 		goto out;
 
+	/* Initialize packet type chains */
+	INIT_LIST_HEAD(&ptype_all);
+	for (i = 0; i < ARRAY_SIZE(ptype_base); i++) 
+	        INIT_LIST_HEAD(&ptype_base[i]);
+
 	subsystem_register(&net_subsys);
 
 #ifdef CONFIG_NET_DIVERT



