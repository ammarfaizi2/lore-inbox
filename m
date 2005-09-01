Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965053AbVIABbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbVIABbw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 21:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbVIAB32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 21:29:28 -0400
Received: from ozlabs.org ([203.10.76.45]:63374 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965025AbVIAB3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 21:29:09 -0400
To: <jgarzik@pobox.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <linuxppc64-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 7/18] iseries_veth: Only call dma_unmap_single() if dma_map_single() succeeded
In-Reply-To: <1125538127.859382.875909607846.qpush@concordia>
Message-Id: <20050901012907.A531B681F5@ozlabs.org>
Date: Thu,  1 Sep 2005 11:29:07 +1000 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The iseries_veth driver unconditionally calls dma_unmap_single() even
when the corresponding dma_map_single() may have failed.

Rework the code a bit to keep the return value from dma_unmap_single()
around, and then check if it's a dma_mapping_error() before we do
the dma_unmap_single().

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 drivers/net/iseries_veth.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

Index: veth-dev2/drivers/net/iseries_veth.c
===================================================================
--- veth-dev2.orig/drivers/net/iseries_veth.c
+++ veth-dev2/drivers/net/iseries_veth.c
@@ -931,7 +931,6 @@ static int veth_transmit_to_one(struct s
 	struct veth_lpar_connection *cnx = veth_cnx[rlp];
 	struct veth_port *port = (struct veth_port *) dev->priv;
 	HvLpEvent_Rc rc;
-	u32 dma_address, dma_length;
 	struct veth_msg *msg = NULL;
 	int err = 0;
 	unsigned long flags;
@@ -959,20 +958,19 @@ static int veth_transmit_to_one(struct s
 
 	msg->in_use = 1;
 
-	dma_length = skb->len;
-	dma_address = dma_map_single(port->dev, skb->data,
-				     dma_length, DMA_TO_DEVICE);
+	msg->data.addr[0] = dma_map_single(port->dev, skb->data,
+				skb->len, DMA_TO_DEVICE);
 
-	if (dma_mapping_error(dma_address))
+	if (dma_mapping_error(msg->data.addr[0]))
 		goto recycle_and_drop;
 
 	/* Is it really necessary to check the length and address
 	 * fields of the first entry here? */
 	msg->skb = skb;
 	msg->dev = port->dev;
-	msg->data.addr[0] = dma_address;
-	msg->data.len[0] = dma_length;
+	msg->data.len[0] = skb->len;
 	msg->data.eofmask = 1 << VETH_EOF_SHIFT;
+
 	rc = veth_signaldata(cnx, VethEventTypeFrames, msg->token, &msg->data);
 
 	if (rc != HvLpEvent_Rc_Good)
@@ -1076,8 +1074,9 @@ static void veth_recycle_msg(struct veth
 		dma_address = msg->data.addr[0];
 		dma_length = msg->data.len[0];
 
-		dma_unmap_single(msg->dev, dma_address, dma_length,
-				 DMA_TO_DEVICE);
+		if (!dma_mapping_error(dma_address))
+			dma_unmap_single(msg->dev, dma_address, dma_length,
+					DMA_TO_DEVICE);
 
 		if (msg->skb) {
 			dev_kfree_skb_any(msg->skb);
