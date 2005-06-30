Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262929AbVF3KX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262929AbVF3KX4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 06:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbVF3KWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 06:22:47 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:49052 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S262929AbVF3KUx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 06:20:53 -0400
Date: Thu, 30 Jun 2005 20:20:39 +1000
To: linuxppc64-dev@ozlabs.org, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 10/12] iseries_veth: Remove TX timeout code
In-Reply-To: <200506302016.55125.michael@ellerman.id.au>
Message-Id: <1120126839.908017.660889424014.qpatch@concordia>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The iseries_veth driver uses the generic TX timeout watchdog, however a better
solution is in the works, so remove this code.


---

 drivers/net/iseries_veth.c |   48 ---------------------------------------------
 1 files changed, 48 deletions(-)

Index: veth-dev/drivers/net/iseries_veth.c
===================================================================
--- veth-dev.orig/drivers/net/iseries_veth.c
+++ veth-dev/drivers/net/iseries_veth.c
@@ -813,49 +813,6 @@ static struct ethtool_ops ops = {
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
@@ -904,9 +861,6 @@ static struct net_device * __init veth_p
 	dev->set_multicast_list = veth_set_multicast_list;
 	SET_ETHTOOL_OPS(dev, &ops);
 
-	dev->watchdog_timeo = 2 * (VETH_ACKTIMEOUT * HZ / 1000000);
-	dev->tx_timeout = veth_tx_timeout;
-
 	SET_NETDEV_DEV(dev, vdev);
 
 	rc = register_netdev(dev);
@@ -1047,8 +1001,6 @@ static int veth_start_xmit(struct sk_buf
 
 	lpmask = veth_transmit_to_many(skb, lpmask, dev);
 
-	dev->trans_start = jiffies;
-
 	if (! lpmask) {
 		dev_kfree_skb(skb);
 	} else {
