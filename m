Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVGAXPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVGAXPL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 19:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVGAXMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 19:12:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1518 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263190AbVGAXJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 19:09:05 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17093.52491.529880.643465@segfault.boston.redhat.com>
Date: Fri, 1 Jul 2005 19:08:59 -0400
To: mpm@selenic.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [rfc | patch 4/6] netpoll: add netpoll hooks to support the bonding driver
In-Reply-To: <17093.52306.136742.190912@segfault.boston.redhat.com>
References: <17093.52306.136742.190912@segfault.boston.redhat.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement hooks in the netpoll code to support the bonding driver (and
hopefully other virtual device drivers, as well).  The key additions here
are netpoll_poll_dev(new) and netpoll_send_skb(newly exported).

netpoll_send_skb
  This is exported so that the bonding driver can queue a packet to be sent
  via the real ethernet device it has chosen.

netpoll_poll_dev
  This is a new routine that was created and exported so that the
  poll_controller implementation in the bonding driver could poll each of
  the underlying real devices without duplicating all of the logic that
  exists internally to netpoll already.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
---

--- linux-2.6.12/net/core/netpoll.c.orig	2005-07-01 15:02:05.503951082 -0400
+++ linux-2.6.12/net/core/netpoll.c	2005-07-01 15:02:36.718705979 -0400
@@ -147,19 +147,27 @@ static void poll_napi(struct net_device 
 	}
 }
 
-void netpoll_poll(struct netpoll *np)
+void netpoll_poll_dev(struct net_device *dev)
 {
-	if(!np->dev || !netif_running(np->dev) || !np->dev->poll_controller)
+	if(!netif_running(dev) || !dev->poll_controller)
 		return;
 
 	/* Process pending work on NIC */
-	np->dev->poll_controller(np->dev);
-	if (np->dev->poll)
-		poll_napi(np->dev);
+	dev->poll_controller(dev);
+	if (dev->poll)
+		poll_napi(dev);
 
 	zap_completion_queue();
 }
 
+void netpoll_poll(struct netpoll *np)
+{
+	if(!np->dev)
+		return;
+
+	netpoll_poll_dev(np->dev);
+}
+
 static void refill_skbs(void)
 {
 	struct sk_buff *skb;
@@ -243,48 +251,59 @@ repeat:
 	return skb;
 }
 
-static void netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
+/*
+ *  This function can be called from virtual device drivers, such as the
+ *  bonding driver.  In this case, skb->dev is filled in with the real
+ *  device over which the packet needs to be sent.  For this reason, we use
+ *  the skb->dev instead of np->dev.  Essentially, np->dev can be, for
+ *  example, bond0, while we actually need to send the packet out over eth0.
+ */
+void netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 {
 	int status;
+	struct net_device *dev = skb->dev;
 
 repeat:
-	if(!np || !np->dev || !netif_running(np->dev)) {
+	if(!np || !dev || !netif_running(dev)) {
 		__kfree_skb(skb);
 		return;
 	}
 
 	/* avoid recursion */
 	if (dev->poll_owner == smp_processor_id() ||
-	    np->dev->xmit_lock_owner == smp_processor_id()) {
-		if (np->drop)
+	    dev->xmit_lock_owner == smp_processor_id()) {
+		if (np && np->drop)
 			np->drop(skb);
 		else
 			__kfree_skb(skb);
 		return;
 	}
 
-	spin_lock(&np->dev->xmit_lock);
-	np->dev->xmit_lock_owner = smp_processor_id();
+	spin_lock(&dev->xmit_lock);
+	dev->xmit_lock_owner = smp_processor_id();
 
 	/*
 	 * network drivers do not expect to be called if the queue is
 	 * stopped.
 	 */
-	if (netif_queue_stopped(np->dev)) {
-		np->dev->xmit_lock_owner = -1;
-		spin_unlock(&np->dev->xmit_lock);
+	if (netif_queue_stopped(dev)) {
+		dev->xmit_lock_owner = -1;
+		spin_unlock(&dev->xmit_lock);
 
-		netpoll_poll(np);
+		netpoll_poll_dev(dev);
 		goto repeat;
 	}
 
-	status = np->dev->hard_start_xmit(skb, np->dev);
-	np->dev->xmit_lock_owner = -1;
-	spin_unlock(&np->dev->xmit_lock);
+	if (dev->netpoll_start_xmit)
+		status = dev->netpoll_start_xmit(np, skb, dev);
+	else
+		status = dev->hard_start_xmit(skb, dev);
+	dev->xmit_lock_owner = -1;
+	spin_unlock(&dev->xmit_lock);
 
 	/* transmit busy */
 	if(status) {
-		netpoll_poll(np);
+		netpoll_poll_dev(dev);
 		goto repeat;
 	}
 }
@@ -715,6 +734,11 @@ int netpoll_setup(struct netpoll *np)
 		npinfo->rx_np = np;
 		spin_unlock_irqrestore(&npinfo->rx_lock, flags);
 	}
+
+	/* Call the device specific netpoll initialization routine. */
+	if (ndev->netpoll_setup)
+		ndev->netpoll_setup(ndev, npinfo);
+
 	/* last thing to do is link it to the net device structure */
 	ndev->npinfo = npinfo;
 
@@ -766,5 +790,7 @@ EXPORT_SYMBOL(netpoll_parse_options);
 EXPORT_SYMBOL(netpoll_setup);
 EXPORT_SYMBOL(netpoll_cleanup);
 EXPORT_SYMBOL(netpoll_send_udp);
+EXPORT_SYMBOL(netpoll_send_skb);
 EXPORT_SYMBOL(netpoll_poll);
+EXPORT_SYMBOL(netpoll_poll_dev);
 EXPORT_SYMBOL(netpoll_queue);
--- linux-2.6.12/net/core/dev.c.orig	2005-07-01 14:59:50.161654219 -0400
+++ linux-2.6.12/net/core/dev.c	2005-07-01 15:00:23.437103656 -0400
@@ -1655,15 +1655,15 @@ int netif_receive_skb(struct sk_buff *sk
 	int ret = NET_RX_DROP;
 	unsigned short type;
 
-	/* if we've gotten here through NAPI, check netpoll */
-	if (skb->dev->poll && netpoll_rx(skb))
+	skb_bond(skb);
+
+	/* if there is a netpoll client registered, check netpoll */
+	if (skb->dev->npinfo && netpoll_rx(skb))
 		return NET_RX_DROP;
 
 	if (!skb->stamp.tv_sec)
 		net_timestamp(&skb->stamp);
 
-	skb_bond(skb);
-
 	__get_cpu_var(netdev_rx_stat).total++;
 
 	skb->h.raw = skb->nh.raw = skb->data;
--- linux-2.6.12/include/linux/netpoll.h.orig	2005-07-01 14:59:56.135657708 -0400
+++ linux-2.6.12/include/linux/netpoll.h	2005-07-01 15:00:23.437103656 -0400
@@ -30,7 +30,9 @@ struct netpoll_info {
 };
 
 void netpoll_poll(struct netpoll *np);
+void netpoll_poll_dev(struct net_device *dev);
 void netpoll_send_udp(struct netpoll *np, const char *msg, int len);
+void netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
 int netpoll_parse_options(struct netpoll *np, char *opt);
 int netpoll_setup(struct netpoll *np);
 int netpoll_trap(void);
--- linux-2.6.12/include/linux/netdevice.h.orig	2005-07-01 14:59:59.835040624 -0400
+++ linux-2.6.12/include/linux/netdevice.h	2005-07-01 15:00:23.438103489 -0400
@@ -41,6 +41,7 @@
 struct divert_blk;
 struct vlan_group;
 struct ethtool_ops;
+struct netpoll;
 struct netpoll_info;
 					/* source back-compat hooks */
 #define SET_ETHTOOL_OPS(netdev,ops) \
@@ -473,7 +474,12 @@ struct net_device
 	int			poll_owner;
 #endif
 #ifdef CONFIG_NET_POLL_CONTROLLER
+	void			(*netpoll_setup)(struct net_device *dev,
+						 struct netpoll_info *npinfo);
 	void                    (*poll_controller)(struct net_device *dev);
+	int			(*netpoll_start_xmit)(struct netpoll *np,
+						      struct sk_buff *skb,
+						      struct net_device *dev);
 #endif
 
 	/* bridge stuff */
