Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262727AbVCDAEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbVCDAEz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbVCDAEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:04:08 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:53494 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262727AbVCCXWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:22:05 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][4/26] IB/mthca: improve CQ locking part 2
In-Reply-To: <2005331520.cHJfJcRbBu1fFgB6@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 3 Mar 2005 15:20:27 -0800
Message-Id: <2005331520.lXKA9W9JoVIrmqB8@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 23:20:27.0175 (UTC) FILETIME=[956EA370:01C52047]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael S. Tsirkin <mst@mellanox.co.il>

Locking during the poll cq operation can be reduced by locking the cq
while qp is being removed from the qp array.  This also avoids an
extra atomic operation for reference counting.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_cq.c	2005-03-03 14:12:52.368554099 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_cq.c	2005-03-03 14:12:52.923433653 -0800
@@ -418,14 +418,14 @@
 			spin_unlock(&(*cur_qp)->lock);
 		}
 
-		spin_lock(&dev->qp_table.lock);
+		/*
+		 * We do not have to take the QP table lock here,
+		 * because CQs will be locked while QPs are removed
+		 * from the table.
+		 */
 		*cur_qp = mthca_array_get(&dev->qp_table.qp,
 					  be32_to_cpu(cqe->my_qpn) &
 					  (dev->limits.num_qps - 1));
-		if (*cur_qp)
-			atomic_inc(&(*cur_qp)->refcount);
-		spin_unlock(&dev->qp_table.lock);
-
 		if (!*cur_qp) {
 			mthca_warn(dev, "CQ entry for unknown QP %06x\n",
 				   be32_to_cpu(cqe->my_qpn) & 0xffffff);
@@ -537,12 +537,8 @@
 		inc_cons_index(dev, cq, freed);
 	}
 
-	if (qp) {
+	if (qp)
 		spin_unlock(&qp->lock);
-		if (atomic_dec_and_test(&qp->refcount))
-			wake_up(&qp->wait);
-	}
-
 
 	spin_unlock_irqrestore(&cq->lock, flags);
 
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_qp.c	2005-02-03 16:59:28.000000000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_qp.c	2005-03-03 14:12:52.924433436 -0800
@@ -1083,9 +1083,21 @@
 	return 0;
 
  err_out_free:
-	spin_lock_irq(&dev->qp_table.lock);
+	/*
+	 * Lock CQs here, so that CQ polling code can do QP lookup
+	 * without taking a lock.
+	 */
+	spin_lock_irq(&send_cq->lock);
+	if (send_cq != recv_cq)
+		spin_lock(&recv_cq->lock);
+
+	spin_lock(&dev->qp_table.lock);
 	mthca_array_clear(&dev->qp_table.qp, mqpn);
-	spin_unlock_irq(&dev->qp_table.lock);
+	spin_unlock(&dev->qp_table.lock);
+
+	if (send_cq != recv_cq)
+		spin_unlock(&recv_cq->lock);
+	spin_unlock_irq(&send_cq->lock);
 
  err_out:
 	dma_free_coherent(&dev->pdev->dev, sqp->header_buf_size,
@@ -1100,11 +1112,28 @@
 	u8 status;
 	int size;
 	int i;
+	struct mthca_cq *send_cq;
+	struct mthca_cq *recv_cq;
+
+	send_cq = to_mcq(qp->ibqp.send_cq);
+	recv_cq = to_mcq(qp->ibqp.recv_cq);
 
-	spin_lock_irq(&dev->qp_table.lock);
+	/*
+	 * Lock CQs here, so that CQ polling code can do QP lookup
+	 * without taking a lock.
+	 */
+	spin_lock_irq(&send_cq->lock);
+	if (send_cq != recv_cq)
+		spin_lock(&recv_cq->lock);
+
+	spin_lock(&dev->qp_table.lock);
 	mthca_array_clear(&dev->qp_table.qp,
 			  qp->qpn & (dev->limits.num_qps - 1));
-	spin_unlock_irq(&dev->qp_table.lock);
+	spin_unlock(&dev->qp_table.lock);
+
+	if (send_cq != recv_cq)
+		spin_unlock(&recv_cq->lock);
+	spin_unlock_irq(&send_cq->lock);
 
 	atomic_dec(&qp->refcount);
 	wait_event(qp->wait, !atomic_read(&qp->refcount));

