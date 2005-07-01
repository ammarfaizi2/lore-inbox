Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbVGAXJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVGAXJo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 19:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVGAXJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 19:09:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13293 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261637AbVGAXGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 19:06:46 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17093.52356.183683.823424@segfault.boston.redhat.com>
Date: Fri, 1 Jul 2005 19:06:44 -0400
To: mpm@selenic.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [rfc | patch 0/6] netpoll: add support for the bonding driver
In-Reply-To: <17093.52306.136742.190912@segfault.boston.redhat.com>
References: <17093.52306.136742.190912@segfault.boston.redhat.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the poll_lock and poll_owner to the struct net_device.  This change is
important for the bonding driver support, as multiple real devices will
point at the same netpoll_info.  In such cases, we would be artificially
limiting ourselves to calling the polling routine of only one member of a
bond at a time.

To understand how this benefits the bonding driver, let's consider a
netpoll client that sends packets in response to receiving packets.  Let's
assume a packet comes in on eth0, and the response is to be delivered over
eth1.  If the poll_lock lived in the npinfo (and hence, there was only one
per bond), then we would have to queue the packet.  With this patch in
place, we can send the outbound packet immediately.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
---


--- linux-2.6.12/net/core/netpoll.c.orig	2005-07-01 14:52:11.932101811 -0400
+++ linux-2.6.12/net/core/netpoll.c	2005-07-01 14:53:59.322183590 -0400
@@ -131,19 +131,20 @@ static int checksum_udp(struct sk_buff *
 static void poll_napi(struct netpoll *np)
 {
 	struct netpoll_info *npinfo = np->dev->npinfo;
+	struct net_device *dev = np->dev;
 	int budget = 16;
 
-	if (test_bit(__LINK_STATE_RX_SCHED, &np->dev->state) &&
-	    npinfo->poll_owner != smp_processor_id() &&
-	    spin_trylock(&npinfo->poll_lock)) {
+	if (test_bit(__LINK_STATE_RX_SCHED, &dev->state) &&
+	    dev->poll_owner != smp_processor_id() &&
+	    spin_trylock(&dev->poll_lock)) {
 		npinfo->rx_flags |= NETPOLL_RX_DROP;
 		atomic_inc(&trapped);
 
-		np->dev->poll(np->dev, &budget);
+		dev->poll(dev, &budget);
 
 		atomic_dec(&trapped);
 		npinfo->rx_flags &= ~NETPOLL_RX_DROP;
-		spin_unlock(&npinfo->poll_lock);
+		spin_unlock(&dev->poll_lock);
 	}
 }
 
@@ -246,7 +247,6 @@ repeat:
 static void netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 {
 	int status;
-	struct netpoll_info *npinfo;
 
 repeat:
 	if(!np || !np->dev || !netif_running(np->dev)) {
@@ -255,8 +255,7 @@ repeat:
 	}
 
 	/* avoid recursion */
-	npinfo = np->dev->npinfo;
-	if (npinfo->poll_owner == smp_processor_id() ||
+	if (dev->poll_owner == smp_processor_id() ||
 	    np->dev->xmit_lock_owner == smp_processor_id()) {
 		if (np->drop)
 			np->drop(skb);
@@ -641,8 +640,6 @@ int netpoll_setup(struct netpoll *np)
 
 		npinfo->rx_flags = 0;
 		npinfo->rx_np = NULL;
-		npinfo->poll_lock = SPIN_LOCK_UNLOCKED;
-		npinfo->poll_owner = -1;
 		npinfo->rx_lock = SPIN_LOCK_UNLOCKED;
 	} else
 		npinfo = ndev->npinfo;
--- linux-2.6.12/net/core/dev.c.orig	2005-07-01 14:52:08.613655521 -0400
+++ linux-2.6.12/net/core/dev.c	2005-07-01 14:52:38.495669512 -0400
@@ -3069,6 +3069,10 @@ struct net_device *alloc_netdev(int size
 
 	setup(dev);
 	strcpy(dev->name, name);
+#ifdef CONFIG_NETPOLL
+	dev->poll_owner = -1;
+	dev->poll_lock = SPIN_LOCK_UNLOCKED;
+#endif
 	return dev;
 }
 EXPORT_SYMBOL(alloc_netdev);
--- linux-2.6.12/include/linux/netpoll.h.orig	2005-07-01 14:52:16.016420312 -0400
+++ linux-2.6.12/include/linux/netpoll.h	2005-07-01 14:52:38.495669512 -0400
@@ -24,8 +24,6 @@ struct netpoll {
 };
 
 struct netpoll_info {
-	spinlock_t poll_lock;
-	int poll_owner;
 	int rx_flags;
 	spinlock_t rx_lock;
 	struct netpoll *rx_np; /* netpoll that registered an rx_hook */
@@ -63,16 +61,16 @@ static inline int netpoll_rx(struct sk_b
 static inline void netpoll_poll_lock(struct net_device *dev)
 {
 	if (dev->npinfo) {
-		spin_lock(&dev->npinfo->poll_lock);
-		dev->npinfo->poll_owner = smp_processor_id();
+		spin_lock(&dev->poll_lock);
+		dev->poll_owner = smp_processor_id();
 	}
 }
 
 static inline void netpoll_poll_unlock(struct net_device *dev)
 {
 	if (dev->npinfo) {
-		dev->npinfo->poll_owner = -1;
-		spin_unlock(&dev->npinfo->poll_lock);
+		dev->poll_owner = -1;
+		spin_unlock(&dev->poll_lock);
 	}
 }
 
--- linux-2.6.12/include/linux/netdevice.h.orig	2005-07-01 14:52:22.666310731 -0400
+++ linux-2.6.12/include/linux/netdevice.h	2005-07-01 14:52:38.496669345 -0400
@@ -469,6 +469,8 @@ struct net_device
 	int			(*neigh_setup)(struct net_device *dev, struct neigh_parms *);
 #ifdef CONFIG_NETPOLL
 	struct netpoll_info	*npinfo;
+	spinlock_t		poll_lock;
+	int			poll_owner;
 #endif
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	void                    (*poll_controller)(struct net_device *dev);
