Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965034AbVIAB3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbVIAB3Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 21:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965033AbVIAB3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 21:29:22 -0400
Received: from ozlabs.org ([203.10.76.45]:29583 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965028AbVIAB3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 21:29:15 -0400
To: <jgarzik@pobox.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <linuxppc64-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 10/18] iseries_veth: Remove TX timeout code
In-Reply-To: <1125538127.859382.875909607846.qpush@concordia>
Message-Id: <20050901012912.2A0B768212@ozlabs.org>
Date: Thu,  1 Sep 2005 11:29:12 +1000 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The iseries_veth driver uses the generic TX timeout watchdog, however a better
solution is in the works, so remove this code.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 drivers/net/iseries_veth.c |   48 ---------------------------------------------
 1 files changed, 48 deletions(-)

Index: veth-dev2/drivers/net/iseries_veth.c
===================================================================
--- veth-dev2.orig/drivers/net/iseries_veth.c
+++ veth-dev2/drivers/net/iseries_veth.c
@@ -830,49 +830,6 @@ static struct ethtool_ops ops = {
 	.get_link = veth_get_link,
 };
 
-static void veth_tx_timeout(struct net_device *dev)
-{
-	struct veth_port *port = (struct veth_port *)dev->priv;
-	struct net_device_stats *stats = &port->stats;
-	unsigned long flags;
-	int i;
-
-	stats->tx_errors++;
-
-	spin_lock_irqsave(&port->pending_gate, flags);
-
-	if (!port->pending_lpmask) {
-		spin_unlock_irqrestore(&port->pending_gate, flags);
-		return;
-	}
-
-	printk(KERN_WARNING "%s: Tx timeout!  Resetting lp connections: %08x\n",
-	       dev->name, port->pending_lpmask);
-
-	for (i = 0; i < HVMAXARCHITECTEDLPS; i++) {
-		struct veth_lpar_connection *cnx = veth_cnx[i];
-
-		if (! (port->pending_lpmask & (1<<i)))
-			continue;
-
-		/* If we're pending on it, we must be connected to it,
-		 * so we should certainly have a structure for it. */
-		BUG_ON(! cnx);
-
-		/* Theoretically we could be kicking a connection
-		 * which doesn't deserve it, but in practice if we've
-		 * had a Tx timeout, the pending_lpmask will have
-		 * exactly one bit set - the connection causing the
-		 * problem. */
-		spin_lock(&cnx->lock);
-		cnx->state |= VETH_STATE_RESET;
-		veth_kick_statemachine(cnx);
-		spin_unlock(&cnx->lock);
-	}
-
-	spin_unlock_irqrestore(&port->pending_gate, flags);
-}
-
 static struct net_device * __init veth_probe_one(int vlan, struct device *vdev)
 {
 	struct net_device *dev;
@@ -921,9 +878,6 @@ static struct net_device * __init veth_p
 	dev->set_multicast_list = veth_set_multicast_list;
 	SET_ETHTOOL_OPS(dev, &ops);
 
-	dev->watchdog_timeo = 2 * (VETH_ACKTIMEOUT * HZ / 1000000);
-	dev->tx_timeout = veth_tx_timeout;
-
 	SET_NETDEV_DEV(dev, vdev);
 
 	rc = register_netdev(dev);
@@ -1058,8 +1012,6 @@ static int veth_start_xmit(struct sk_buf
 
 	lpmask = veth_transmit_to_many(skb, lpmask, dev);
 
-	dev->trans_start = jiffies;
-
 	if (! lpmask) {
 		dev_kfree_skb(skb);
 	} else {
