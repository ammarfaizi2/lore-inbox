Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965051AbVIAB3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbVIAB3c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 21:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbVIAB3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 21:29:31 -0400
Received: from ozlabs.org ([203.10.76.45]:59534 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965023AbVIAB3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 21:29:09 -0400
To: <jgarzik@pobox.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <linuxppc64-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 6/18] iseries_veth: Replace lock-protected atomic with an ordinary variable
In-Reply-To: <1125538127.859382.875909607846.qpush@concordia>
Message-Id: <20050901012906.9EF9568206@ozlabs.org>
Date: Thu,  1 Sep 2005 11:29:06 +1000 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The iseries_veth driver uses atomic ops to manipulate the in_use field of
one of its per-connection structures. However all references to the
flag occur while the connection's lock is held, so the atomic ops aren't
necessary.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 drivers/net/iseries_veth.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

Index: veth-dev2/drivers/net/iseries_veth.c
===================================================================
--- veth-dev2.orig/drivers/net/iseries_veth.c
+++ veth-dev2/drivers/net/iseries_veth.c
@@ -117,7 +117,7 @@ struct veth_msg {
 	struct veth_msg *next;
 	struct VethFramesData data;
 	int token;
-	unsigned long in_use;
+	int in_use;
 	struct sk_buff *skb;
 	struct device *dev;
 };
@@ -957,6 +957,8 @@ static int veth_transmit_to_one(struct s
 		goto drop;
 	}
 
+	msg->in_use = 1;
+
 	dma_length = skb->len;
 	dma_address = dma_map_single(port->dev, skb->data,
 				     dma_length, DMA_TO_DEVICE);
@@ -971,7 +973,6 @@ static int veth_transmit_to_one(struct s
 	msg->data.addr[0] = dma_address;
 	msg->data.len[0] = dma_length;
 	msg->data.eofmask = 1 << VETH_EOF_SHIFT;
-	set_bit(0, &(msg->in_use));
 	rc = veth_signaldata(cnx, VethEventTypeFrames, msg->token, &msg->data);
 
 	if (rc != HvLpEvent_Rc_Good)
@@ -981,10 +982,8 @@ static int veth_transmit_to_one(struct s
 	return 0;
 
  recycle_and_drop:
+	/* we free the skb below, so tell veth_recycle_msg() not to. */
 	msg->skb = NULL;
-	/* need to set in use to make veth_recycle_msg in case this
-	 * was a mapping failure */
-	set_bit(0, &msg->in_use);
 	veth_recycle_msg(cnx, msg);
  drop:
 	port->stats.tx_errors++;
@@ -1066,12 +1065,14 @@ static int veth_start_xmit(struct sk_buf
 	return 0;
 }
 
+/* You must hold the connection's lock when you call this function. */
 static void veth_recycle_msg(struct veth_lpar_connection *cnx,
 			     struct veth_msg *msg)
 {
 	u32 dma_address, dma_length;
 
-	if (test_and_clear_bit(0, &msg->in_use)) {
+	if (msg->in_use) {
+		msg->in_use = 0;
 		dma_address = msg->data.addr[0];
 		dma_length = msg->data.len[0];
 
