Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262952AbVF3K2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262952AbVF3K2Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 06:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262935AbVF3K0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 06:26:51 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:57244 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S262938AbVF3KUz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 06:20:55 -0400
Date: Thu, 30 Jun 2005 20:20:39 +1000
To: linuxppc64-dev@ozlabs.org, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 8/12] iseries_veth: Replace lock-protected atomic with an ordinary variable
In-Reply-To: <200506302016.55125.michael@ellerman.id.au>
Message-Id: <1120126839.641415.625704757570.qpatch@concordia>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The iseries_veth driver uses atomic ops to manipulate the in_use field of
one of its per-connection structures. However all references to the
flag occur while the connection's lock is held, so the atomic ops aren't
necessary.


---

 drivers/net/iseries_veth.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

Index: veth-dev/drivers/net/iseries_veth.c
===================================================================
--- veth-dev.orig/drivers/net/iseries_veth.c
+++ veth-dev/drivers/net/iseries_veth.c
@@ -117,7 +117,7 @@ struct veth_msg {
 	struct veth_msg *next;
 	struct VethFramesData data;
 	int token;
-	unsigned long in_use;
+	int in_use;
 	struct sk_buff *skb;
 	struct device *dev;
 };
@@ -959,6 +959,8 @@ static int veth_transmit_to_one(struct s
 		goto drop;
 	}
 
+	msg->in_use = 1;
+
 	dma_length = skb->len;
 	dma_address = dma_map_single(port->dev, skb->data,
 				     dma_length, DMA_TO_DEVICE);
@@ -973,7 +975,6 @@ static int veth_transmit_to_one(struct s
 	msg->data.addr[0] = dma_address;
 	msg->data.len[0] = dma_length;
 	msg->data.eofmask = 1 << VETH_EOF_SHIFT;
-	set_bit(0, &(msg->in_use));
 	rc = veth_signaldata(cnx, VethEventTypeFrames, msg->token, &msg->data);
 
 	if (rc != HvLpEvent_Rc_Good)
@@ -983,10 +984,8 @@ static int veth_transmit_to_one(struct s
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
@@ -1068,12 +1067,14 @@ static int veth_start_xmit(struct sk_buf
 	return 0;
 }
 
+/* You musT hold the connection's lock when you call this function. */
 static void veth_recycle_msg(struct veth_lpar_connection *cnx,
 			     struct veth_msg *msg)
 {
 	u32 dma_address, dma_length;
 
-	if (test_and_clear_bit(0, &msg->in_use)) {
+	if (msg->in_use) {
+		msg->in_use = 0;
 		dma_address = msg->data.addr[0];
 		dma_length = msg->data.len[0];
 
