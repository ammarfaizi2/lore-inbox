Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965062AbVIABeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062AbVIABeL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 21:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965061AbVIABeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 21:34:09 -0400
Received: from ozlabs.org ([203.10.76.45]:5776 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965028AbVIAB3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 21:29:24 -0400
To: <jgarzik@pobox.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <linuxppc64-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 13/18] iseries_veth: Fix bogus counting of TX errors
In-Reply-To: <1125538127.859382.875909607846.qpush@concordia>
Message-Id: <20050901012919.7A19868232@ozlabs.org>
Date: Thu,  1 Sep 2005 11:29:19 +1000 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's a number of problems with the way iseries_veth counts TX errors.

Firstly it counts conditions which aren't really errors as TX errors. This
includes if we don't have a connection struct for the other LPAR, or if the
other LPAR is currently down (or just doesn't want to talk to us). Neither
of these should count as TX errors.

Secondly, it counts one TX error for each LPAR that fails to accept the packet.
This can lead to TX error counts higher than the total number of packets sent
through the interface. This is confusing for users.

This patch fixes that behaviour. The non-error conditions are no longer
counted, and we introduce a new and I think saner meaning to the TX counts.

If a packet is successfully transmitted to any LPAR then it is transmitted
and tx_packets is incremented by 1.

If there is an error transmitting a packet to any LPAR then that is counted
as one error, ie. tx_errors is incremented by 1.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 drivers/net/iseries_veth.c |   47 ++++++++++++++++++---------------------------
 1 files changed, 19 insertions(+), 28 deletions(-)

Index: veth-dev2/drivers/net/iseries_veth.c
===================================================================
--- veth-dev2.orig/drivers/net/iseries_veth.c
+++ veth-dev2/drivers/net/iseries_veth.c
@@ -938,31 +938,25 @@ static int veth_transmit_to_one(struct s
 	struct veth_port *port = (struct veth_port *) dev->priv;
 	HvLpEvent_Rc rc;
 	struct veth_msg *msg = NULL;
-	int err = 0;
 	unsigned long flags;
 
-	if (! cnx) {
-		port->stats.tx_errors++;
-		dev_kfree_skb(skb);
+	if (! cnx)
 		return 0;
-	}
 
 	spin_lock_irqsave(&cnx->lock, flags);
 
 	if (! (cnx->state & VETH_STATE_READY))
-		goto drop;
+		goto no_error;
 
-	if ((skb->len - 14) > VETH_MAX_MTU)
+	if ((skb->len - ETH_HLEN) > VETH_MAX_MTU)
 		goto drop;
 
 	msg = veth_stack_pop(cnx);
-
-	if (! msg) {
-		err = 1;
+	if (! msg)
 		goto drop;
-	}
 
 	msg->in_use = 1;
+	msg->skb = skb_get(skb);
 
 	msg->data.addr[0] = dma_map_single(port->dev, skb->data,
 				skb->len, DMA_TO_DEVICE);
@@ -970,9 +964,6 @@ static int veth_transmit_to_one(struct s
 	if (dma_mapping_error(msg->data.addr[0]))
 		goto recycle_and_drop;
 
-	/* Is it really necessary to check the length and address
-	 * fields of the first entry here? */
-	msg->skb = skb;
 	msg->dev = port->dev;
 	msg->data.len[0] = skb->len;
 	msg->data.eofmask = 1 << VETH_EOF_SHIFT;
@@ -992,43 +983,43 @@ static int veth_transmit_to_one(struct s
 	if (veth_stack_is_empty(cnx))
 		veth_stop_queues(cnx);
 
+ no_error:
 	spin_unlock_irqrestore(&cnx->lock, flags);
 	return 0;
 
  recycle_and_drop:
-	/* we free the skb below, so tell veth_recycle_msg() not to. */
-	msg->skb = NULL;
 	veth_recycle_msg(cnx, msg);
  drop:
-	port->stats.tx_errors++;
-	dev_kfree_skb(skb);
 	spin_unlock_irqrestore(&cnx->lock, flags);
-	return err;
+	return 1;
 }
 
-static HvLpIndexMap veth_transmit_to_many(struct sk_buff *skb,
+static void veth_transmit_to_many(struct sk_buff *skb,
 					  HvLpIndexMap lpmask,
 					  struct net_device *dev)
 {
 	struct veth_port *port = (struct veth_port *) dev->priv;
-	int i;
-	int rc;
+	int i, success, error;
+
+	success = error = 0;
 
 	for (i = 0; i < HVMAXARCHITECTEDLPS; i++) {
 		if ((lpmask & (1 << i)) == 0)
 			continue;
 
-		rc = veth_transmit_to_one(skb_get(skb), i, dev);
-		if (! rc)
-			lpmask &= ~(1<<i);
+		if (veth_transmit_to_one(skb, i, dev))
+			error = 1;
+		else
+			success = 1;
 	}
 
-	if (! lpmask) {
+	if (error)
+		port->stats.tx_errors++;
+
+	if (success) {
 		port->stats.tx_packets++;
 		port->stats.tx_bytes += skb->len;
 	}
-
-	return lpmask;
 }
 
 static int veth_start_xmit(struct sk_buff *skb, struct net_device *dev)
