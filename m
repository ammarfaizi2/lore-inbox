Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262749AbVCCXko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262749AbVCCXko (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 18:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVCCXh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 18:37:57 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:53494 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262745AbVCCXWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:22:33 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][24/26] IB/mthca: QP locking optimization
In-Reply-To: <2005331520.kVkmRDQ3e4IStEy9@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 3 Mar 2005 15:20:28 -0800
Message-Id: <2005331520.i9PPmMDNBr0DxH5I@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 23:20:28.0550 (UTC) FILETIME=[96407260:01C52047]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael S. Tsirkin <mst@mellanox.co.il>

1. Split the QP spinlock into separate send and receive locks.

   The only place where we have to lock both is upon modify_qp, and
   that is not on data path.

2. Avoid taking any QP locks when polling CQ.

   This last part is achieved by getting rid of the cur field in
   mthca_wq, and calculating the number of outstanding WQEs by
   comparing the head and tail fields.  head is only updated by
   post, tail is only updated by poll.

   In a rare case where an overrun is detected, a CQ is locked and the
   overrun condition is re-tested, to avoid any potential for stale
   tail values.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_cq.c	2005-03-03 14:13:01.214633912 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_cq.c	2005-03-03 14:13:03.417155819 -0800
@@ -423,15 +423,6 @@
 	is_send  = is_error ? cqe->opcode & 0x01 : cqe->is_send & 0x80;
 
 	if (!*cur_qp || be32_to_cpu(cqe->my_qpn) != (*cur_qp)->qpn) {
-		if (*cur_qp) {
-			if (*freed) {
-				wmb();
-				update_cons_index(dev, cq, *freed);
-				*freed = 0;
-			}
-			spin_unlock(&(*cur_qp)->lock);
-		}
-
 		/*
 		 * We do not have to take the QP table lock here,
 		 * because CQs will be locked while QPs are removed
@@ -446,8 +437,6 @@
 			err = -EINVAL;
 			goto out;
 		}
-
-		spin_lock(&(*cur_qp)->lock);
 	}
 
 	entry->qp_num = (*cur_qp)->qpn;
@@ -465,9 +454,9 @@
 	}
 
 	if (wq->last_comp < wqe_index)
-		wq->cur -= wqe_index - wq->last_comp;
+		wq->tail += wqe_index - wq->last_comp;
 	else
-		wq->cur -= wq->max - wq->last_comp + wqe_index;
+		wq->tail += wqe_index + wq->max - wq->last_comp;
 
 	wq->last_comp = wqe_index;
 
@@ -551,9 +540,6 @@
 		update_cons_index(dev, cq, freed);
 	}
 
-	if (qp)
-		spin_unlock(&qp->lock);
-
 	spin_unlock_irqrestore(&cq->lock, flags);
 
 	return err == 0 || err == -EAGAIN ? npolled : err;
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_provider.h	2005-03-03 14:13:02.120437293 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_provider.h	2005-03-03 14:13:03.416156036 -0800
@@ -166,21 +166,22 @@
 };
 
 struct mthca_wq {
-	int   max;
-	int   cur;
-	int   next;
-	int   last_comp;
-	void *last;
-	int   max_gs;
-	int   wqe_shift;
+	spinlock_t lock;
+	int        max;
+	unsigned   next_ind;
+	unsigned   last_comp;
+	unsigned   head;
+	unsigned   tail;
+	void      *last;
+	int        max_gs;
+	int        wqe_shift;
 
-	int   db_index;		/* Arbel only */
-	u32  *db;
+	int        db_index;	/* Arbel only */
+	u32       *db;
 };
 
 struct mthca_qp {
 	struct ib_qp           ibqp;
-	spinlock_t             lock;
 	atomic_t               refcount;
 	u32                    qpn;
 	int                    is_direct;
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_qp.c	2005-03-03 14:13:02.567340285 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_qp.c	2005-03-03 14:13:03.418155602 -0800
@@ -577,9 +577,11 @@
 		else
 			cur_state = attr->cur_qp_state;
 	} else {
-		spin_lock_irq(&qp->lock);
+		spin_lock_irq(&qp->sq.lock);
+		spin_lock(&qp->rq.lock);
 		cur_state = qp->state;
-		spin_unlock_irq(&qp->lock);
+		spin_unlock(&qp->rq.lock);
+		spin_unlock_irq(&qp->sq.lock);
 	}
 
 	if (attr_mask & IB_QP_STATE) {
@@ -1076,6 +1078,16 @@
 	}
 }
 
+static void mthca_wq_init(struct mthca_wq* wq)
+{
+	spin_lock_init(&wq->lock);
+	wq->next_ind  = 0;
+	wq->last_comp = wq->max - 1;
+	wq->head      = 0;
+	wq->tail      = 0;
+	wq->last      = NULL;
+}
+
 static int mthca_alloc_qp_common(struct mthca_dev *dev,
 				 struct mthca_pd *pd,
 				 struct mthca_cq *send_cq,
@@ -1087,20 +1099,13 @@
 	int ret;
 	int i;
 
-	spin_lock_init(&qp->lock);
 	atomic_set(&qp->refcount, 1);
 	qp->state    	 = IB_QPS_RESET;
 	qp->atomic_rd_en = 0;
 	qp->resp_depth   = 0;
 	qp->sq_policy    = send_policy;
-	qp->rq.cur       = 0;
-	qp->sq.cur       = 0;
-	qp->rq.next      = 0;
-	qp->sq.next      = 0;
-	qp->rq.last_comp = qp->rq.max - 1;
-	qp->sq.last_comp = qp->sq.max - 1;
-	qp->rq.last      = NULL;
-	qp->sq.last      = NULL;
+	mthca_wq_init(&qp->sq);
+	mthca_wq_init(&qp->rq);
 
 	ret = mthca_alloc_memfree(dev, qp);
 	if (ret)
@@ -1394,6 +1399,24 @@
 	return 0;
 }
 
+static inline int mthca_wq_overflow(struct mthca_wq *wq, int nreq,
+				    struct ib_cq *ib_cq)
+{
+	unsigned cur;
+	struct mthca_cq *cq;
+
+	cur = wq->head - wq->tail;
+	if (likely(cur + nreq < wq->max))
+		return 0;
+
+	cq = to_mcq(ib_cq);
+	spin_lock(&cq->lock);
+	cur = wq->head - wq->tail;
+	spin_unlock(&cq->lock);
+
+	return cur + nreq >= wq->max;
+}
+
 int mthca_tavor_post_send(struct ib_qp *ibqp, struct ib_send_wr *wr,
 			  struct ib_send_wr **bad_wr)
 {
@@ -1411,16 +1434,18 @@
 	int ind;
 	u8 op0 = 0;
 
-	spin_lock_irqsave(&qp->lock, flags);
+	spin_lock_irqsave(&qp->sq.lock, flags);
 
 	/* XXX check that state is OK to post send */
 
-	ind = qp->sq.next;
+	ind = qp->sq.next_ind;
 
 	for (nreq = 0; wr; ++nreq, wr = wr->next) {
-		if (qp->sq.cur + nreq >= qp->sq.max) {
-			mthca_err(dev, "SQ full (%d posted, %d max, %d nreq)\n",
-				  qp->sq.cur, qp->sq.max, nreq);
+		if (mthca_wq_overflow(&qp->sq, nreq, qp->ibqp.send_cq)) {
+			mthca_err(dev, "SQ %06x full (%u head, %u tail,"
+					" %d max, %d nreq)\n", qp->qpn,
+					qp->sq.head, qp->sq.tail,
+					qp->sq.max, nreq);
 			err = -ENOMEM;
 			*bad_wr = wr;
 			goto out;
@@ -1580,7 +1605,7 @@
 	if (likely(nreq)) {
 		u32 doorbell[2];
 
-		doorbell[0] = cpu_to_be32(((qp->sq.next << qp->sq.wqe_shift) +
+		doorbell[0] = cpu_to_be32(((qp->sq.next_ind << qp->sq.wqe_shift) +
 					   qp->send_wqe_offset) | f0 | op0);
 		doorbell[1] = cpu_to_be32((qp->qpn << 8) | size0);
 
@@ -1591,10 +1616,10 @@
 			      MTHCA_GET_DOORBELL_LOCK(&dev->doorbell_lock));
 	}
 
-	qp->sq.cur += nreq;
-	qp->sq.next = ind;
+	qp->sq.next_ind = ind;
+	qp->sq.head    += nreq;
 
-	spin_unlock_irqrestore(&qp->lock, flags);
+	spin_unlock_irqrestore(&qp->sq.lock, flags);
 	return err;
 }
 
@@ -1613,15 +1638,18 @@
 	void *wqe;
 	void *prev_wqe;
 
-	spin_lock_irqsave(&qp->lock, flags);
+	spin_lock_irqsave(&qp->rq.lock, flags);
 
 	/* XXX check that state is OK to post receive */
 
-	ind = qp->rq.next;
+	ind = qp->rq.next_ind;
 
 	for (nreq = 0; wr; ++nreq, wr = wr->next) {
-		if (unlikely(qp->rq.cur + nreq >= qp->rq.max)) {
-			mthca_err(dev, "RQ %06x full\n", qp->qpn);
+		if (mthca_wq_overflow(&qp->rq, nreq, qp->ibqp.recv_cq)) {
+			mthca_err(dev, "RQ %06x full (%u head, %u tail,"
+					" %d max, %d nreq)\n", qp->qpn,
+					qp->rq.head, qp->rq.tail,
+					qp->rq.max, nreq);
 			err = -ENOMEM;
 			*bad_wr = wr;
 			goto out;
@@ -1678,7 +1706,7 @@
 	if (likely(nreq)) {
 		u32 doorbell[2];
 
-		doorbell[0] = cpu_to_be32((qp->rq.next << qp->rq.wqe_shift) | size0);
+		doorbell[0] = cpu_to_be32((qp->rq.next_ind << qp->rq.wqe_shift) | size0);
 		doorbell[1] = cpu_to_be32((qp->qpn << 8) | nreq);
 
 		wmb();
@@ -1688,10 +1716,10 @@
 			      MTHCA_GET_DOORBELL_LOCK(&dev->doorbell_lock));
 	}
 
-	qp->rq.cur += nreq;
-	qp->rq.next = ind;
+	qp->rq.next_ind = ind;
+	qp->rq.head    += nreq;
 
-	spin_unlock_irqrestore(&qp->lock, flags);
+	spin_unlock_irqrestore(&qp->rq.lock, flags);
 	return err;
 }
 
@@ -1712,16 +1740,18 @@
 	int ind;
 	u8 op0 = 0;
 
-	spin_lock_irqsave(&qp->lock, flags);
+	spin_lock_irqsave(&qp->sq.lock, flags);
 
 	/* XXX check that state is OK to post send */
 
-	ind = qp->sq.next & (qp->sq.max - 1);
+	ind = qp->sq.head & (qp->sq.max - 1);
 
 	for (nreq = 0; wr; ++nreq, wr = wr->next) {
-		if (qp->sq.cur + nreq >= qp->sq.max) {
-			mthca_err(dev, "SQ full (%d posted, %d max, %d nreq)\n",
-				  qp->sq.cur, qp->sq.max, nreq);
+		if (mthca_wq_overflow(&qp->sq, nreq, qp->ibqp.send_cq)) {
+			mthca_err(dev, "SQ %06x full (%u head, %u tail,"
+					" %d max, %d nreq)\n", qp->qpn,
+					qp->sq.head, qp->sq.tail,
+					qp->sq.max, nreq);
 			err = -ENOMEM;
 			*bad_wr = wr;
 			goto out;
@@ -1831,19 +1861,18 @@
 		u32 doorbell[2];
 
 		doorbell[0] = cpu_to_be32((nreq << 24)                  |
-					  ((qp->sq.next & 0xffff) << 8) |
+					  ((qp->sq.head & 0xffff) << 8) |
 					  f0 | op0);
 		doorbell[1] = cpu_to_be32((qp->qpn << 8) | size0);
 
-		qp->sq.cur  += nreq;
-		qp->sq.next += nreq;
+		qp->sq.head += nreq;
 
 		/*
 		 * Make sure that descriptors are written before
 		 * doorbell record.
 		 */
 		wmb();
-		*qp->sq.db = cpu_to_be32(qp->sq.next & 0xffff);
+		*qp->sq.db = cpu_to_be32(qp->sq.head & 0xffff);
 
 		/*
 		 * Make sure doorbell record is written before we
@@ -1855,7 +1884,7 @@
 			      MTHCA_GET_DOORBELL_LOCK(&dev->doorbell_lock));
 	}
 
-	spin_unlock_irqrestore(&qp->lock, flags);
+	spin_unlock_irqrestore(&qp->sq.lock, flags);
 	return err;
 }
 
@@ -1871,15 +1900,18 @@
 	int i;
 	void *wqe;
 
-	spin_lock_irqsave(&qp->lock, flags);
+ 	spin_lock_irqsave(&qp->rq.lock, flags);
 
 	/* XXX check that state is OK to post receive */
 
-	ind = qp->rq.next & (qp->rq.max - 1);
+	ind = qp->rq.head & (qp->rq.max - 1);
 
 	for (nreq = 0; wr; ++nreq, wr = wr->next) {
-		if (unlikely(qp->rq.cur + nreq >= qp->rq.max)) {
-			mthca_err(dev, "RQ %06x full\n", qp->qpn);
+		if (mthca_wq_overflow(&qp->rq, nreq, qp->ibqp.recv_cq)) {
+			mthca_err(dev, "RQ %06x full (%u head, %u tail,"
+					" %d max, %d nreq)\n", qp->qpn,
+					qp->rq.head, qp->rq.tail,
+					qp->rq.max, nreq);
 			err = -ENOMEM;
 			*bad_wr = wr;
 			goto out;
@@ -1921,18 +1953,17 @@
 	}
 out:
 	if (likely(nreq)) {
-		qp->rq.cur  += nreq;
-		qp->rq.next += nreq;
+		qp->rq.head += nreq;
 
 		/*
 		 * Make sure that descriptors are written before
 		 * doorbell record.
 		 */
 		wmb();
-		*qp->rq.db = cpu_to_be32(qp->rq.next & 0xffff);
+		*qp->rq.db = cpu_to_be32(qp->rq.head & 0xffff);
 	}
 
-	spin_unlock_irqrestore(&qp->lock, flags);
+	spin_unlock_irqrestore(&qp->rq.lock, flags);
 	return err;
 }
 

