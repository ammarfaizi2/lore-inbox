Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVAMA6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVAMA6H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 19:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVALVxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 16:53:24 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:39078 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261501AbVALVsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:48:45 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20051121348.60O3cyevOZe3iYxf@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Wed, 12 Jan 2005 13:48:26 -0800
Message-Id: <20051121348.B8o2ZVVtV8zXmvPq@topspin.com>
Mime-Version: 1.0
To: akpm@osdl.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][17/18] InfiniBand/ipoib: move structs from stack to device private struct
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 12 Jan 2005 21:48:27.0110 (UTC) FILETIME=[72901060:01C4F8F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the gather list and work request used for posting sends from the
stack in ipoib_send() to the private structure.  This reduces the
stack usage for the data path function ipoib_send() and may speed
things up slightly because we don't need to initialize constant
members of the structures.

Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux/drivers/infiniband/ulp/ipoib/ipoib_verbs.c	(revision 1520)
+++ linux/drivers/infiniband/ulp/ipoib/ipoib_verbs.c	(revision 1521)
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2004, 2005 Topspin Communications.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -187,7 +187,7 @@
 
 	priv->mr = ib_get_dma_mr(priv->pd, IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(priv->mr)) {
-		printk(KERN_WARNING "%s: ib_reg_phys_mr failed\n", ca->name);
+		printk(KERN_WARNING "%s: ib_get_dma_mr failed\n", ca->name);
 		goto out_free_cq;
 	}
 
@@ -204,6 +204,13 @@
 	priv->dev->dev_addr[2] = (priv->qp->qp_num >>  8) & 0xff;
 	priv->dev->dev_addr[3] = (priv->qp->qp_num      ) & 0xff;
 
+	priv->tx_sge.lkey 	= priv->mr->lkey;
+
+	priv->tx_wr.opcode 	= IB_WR_SEND;
+	priv->tx_wr.sg_list 	= &priv->tx_sge;
+	priv->tx_wr.num_sge 	= 1;
+	priv->tx_wr.send_flags 	= IB_SEND_SIGNALED;
+
 	return 0;
 
 out_free_mr:
--- linux/drivers/infiniband/ulp/ipoib/ipoib.h	(revision 1520)
+++ linux/drivers/infiniband/ulp/ipoib/ipoib.h	(revision 1521)
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2004, 2005 Topspin Communications.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -150,10 +150,12 @@
 
 	struct ipoib_buf *rx_ring;
 
-	spinlock_t tx_lock;
+	spinlock_t        tx_lock;
 	struct ipoib_buf *tx_ring;
-	unsigned tx_head;
-	unsigned tx_tail;
+	unsigned          tx_head;
+	unsigned          tx_tail;
+	struct ib_sge     tx_sge;
+	struct ib_send_wr tx_wr;
 
 	struct ib_wc ibwc[IPOIB_NUM_WC];
 
--- linux/drivers/infiniband/ulp/ipoib/ipoib_multicast.c	(revision 1520)
+++ linux/drivers/infiniband/ulp/ipoib/ipoib_multicast.c	(revision 1521)
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2004, 2005 Topspin Communications.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -213,8 +213,10 @@
 
 	/* Set the cached Q_Key before we attach if it's the broadcast group */
 	if (!memcmp(mcast->mcmember.mgid.raw, priv->dev->broadcast + 4,
-		    sizeof (union ib_gid)))
+		    sizeof (union ib_gid))) {
 		priv->qkey = be32_to_cpu(priv->broadcast->mcmember.qkey);
+		priv->tx_wr.wr.ud.remote_qkey = priv->qkey;
+	}
 
 	if (!test_bit(IPOIB_MCAST_FLAG_SENDONLY, &mcast->flags)) {
 		if (test_and_set_bit(IPOIB_MCAST_FLAG_ATTACHED, &mcast->flags)) {
--- linux/drivers/infiniband/ulp/ipoib/ipoib_ib.c	(revision 1520)
+++ linux/drivers/infiniband/ulp/ipoib/ipoib_ib.c	(revision 1521)
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2004, 2005 Topspin Communications.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -281,28 +281,16 @@
 			    struct ib_ah *address, u32 qpn,
 			    dma_addr_t addr, int len)
 {
-	struct ib_sge list = {
-		.addr    = addr,
-		.length  = len,
-		.lkey    = priv->mr->lkey,
-	};
-	struct ib_send_wr param = {
-		.wr_id = wr_id,
-		.opcode = IB_WR_SEND,
-		.sg_list = &list,
-		.num_sge = 1,
-		.wr = {
-			.ud = {
-				 .remote_qpn = qpn,
-				 .remote_qkey = priv->qkey,
-				 .ah = address
-			 },
-		},
-		.send_flags = IB_SEND_SIGNALED,
-	};
 	struct ib_send_wr *bad_wr;
 
-	return ib_post_send(priv->qp, &param, &bad_wr);
+	priv->tx_sge.addr             = addr;
+	priv->tx_sge.length           = len;
+
+	priv->tx_wr.wr_id 	      = wr_id;
+	priv->tx_wr.wr.ud.remote_qpn  = qpn;
+	priv->tx_wr.wr.ud.ah 	      = address;
+
+	return ib_post_send(priv->qp, &priv->tx_wr, &bad_wr);
 }
 
 void ipoib_send(struct net_device *dev, struct sk_buff *skb,

