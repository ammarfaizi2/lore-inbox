Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262742AbVCCXpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbVCCXpl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 18:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262755AbVCCXoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 18:44:03 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:56054 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262742AbVCCXW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:22:26 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][19/26] IB/mthca: mem-free CQ operations
In-Reply-To: <2005331520.xvxJqi7Nfv5UdZpQ@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 3 Mar 2005 15:20:28 -0800
Message-Id: <2005331520.VEavoMG964z0bUT1@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 23:20:28.0207 (UTC) FILETIME=[960C1BF0:01C52047]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for CQ data path operations (request notification, update
consumer index) in mem-free mode.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_cq.c	2005-03-03 14:13:00.312829664 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_cq.c	2005-03-03 14:13:01.214633912 -0800
@@ -136,11 +136,15 @@
 #define MTHCA_CQ_ENTRY_OWNER_SW      (0 << 7)
 #define MTHCA_CQ_ENTRY_OWNER_HW      (1 << 7)
 
-#define MTHCA_CQ_DB_INC_CI       (1 << 24)
-#define MTHCA_CQ_DB_REQ_NOT      (2 << 24)
-#define MTHCA_CQ_DB_REQ_NOT_SOL  (3 << 24)
-#define MTHCA_CQ_DB_SET_CI       (4 << 24)
-#define MTHCA_CQ_DB_REQ_NOT_MULT (5 << 24)
+#define MTHCA_TAVOR_CQ_DB_INC_CI       (1 << 24)
+#define MTHCA_TAVOR_CQ_DB_REQ_NOT      (2 << 24)
+#define MTHCA_TAVOR_CQ_DB_REQ_NOT_SOL  (3 << 24)
+#define MTHCA_TAVOR_CQ_DB_SET_CI       (4 << 24)
+#define MTHCA_TAVOR_CQ_DB_REQ_NOT_MULT (5 << 24)
+
+#define MTHCA_ARBEL_CQ_DB_REQ_NOT_SOL  (1 << 24)
+#define MTHCA_ARBEL_CQ_DB_REQ_NOT      (2 << 24)
+#define MTHCA_ARBEL_CQ_DB_REQ_NOT_MULT (3 << 24)
 
 static inline struct mthca_cqe *get_cqe(struct mthca_cq *cq, int entry)
 {
@@ -159,7 +163,7 @@
 
 static inline struct mthca_cqe *next_cqe_sw(struct mthca_cq *cq)
 {
-	return cqe_sw(cq, cq->cons_index);
+	return cqe_sw(cq, cq->cons_index & cq->ibcq.cqe);
 }
 
 static inline void set_cqe_hw(struct mthca_cqe *cqe)
@@ -167,17 +171,26 @@
 	cqe->owner = MTHCA_CQ_ENTRY_OWNER_HW;
 }
 
-static inline void inc_cons_index(struct mthca_dev *dev, struct mthca_cq *cq,
-				  int nent)
+/*
+ * incr is ignored in native Arbel (mem-free) mode, so cq->cons_index
+ * should be correct before calling update_cons_index().
+ */
+static inline void update_cons_index(struct mthca_dev *dev, struct mthca_cq *cq,
+				     int incr)
 {
 	u32 doorbell[2];
 
-	doorbell[0] = cpu_to_be32(MTHCA_CQ_DB_INC_CI | cq->cqn);
-	doorbell[1] = cpu_to_be32(nent - 1);
+	if (dev->hca_type == ARBEL_NATIVE) {
+		*cq->set_ci_db = cpu_to_be32(cq->cons_index);
+		wmb();
+	} else {
+		doorbell[0] = cpu_to_be32(MTHCA_TAVOR_CQ_DB_INC_CI | cq->cqn);
+		doorbell[1] = cpu_to_be32(incr - 1);
 
-	mthca_write64(doorbell,
-		      dev->kar + MTHCA_CQ_DOORBELL,
-		      MTHCA_GET_DOORBELL_LOCK(&dev->doorbell_lock));
+		mthca_write64(doorbell,
+			      dev->kar + MTHCA_CQ_DOORBELL,
+			      MTHCA_GET_DOORBELL_LOCK(&dev->doorbell_lock));
+	}
 }
 
 void mthca_cq_event(struct mthca_dev *dev, u32 cqn)
@@ -191,6 +204,8 @@
 		return;
 	}
 
+	++cq->arm_sn;
+
 	cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
 }
 
@@ -247,8 +262,8 @@
 
 	if (nfreed) {
 		wmb();
-		inc_cons_index(dev, cq, nfreed);
-		cq->cons_index = (cq->cons_index + nfreed) & cq->ibcq.cqe;
+		cq->cons_index += nfreed;
+		update_cons_index(dev, cq, nfreed);
 	}
 
 	spin_unlock_irq(&cq->lock);
@@ -341,7 +356,7 @@
 		break;
 	}
 
-	err = mthca_free_err_wqe(qp, is_send, wqe_index, &dbd, &new_wqe);
+	err = mthca_free_err_wqe(dev, qp, is_send, wqe_index, &dbd, &new_wqe);
 	if (err)
 		return err;
 
@@ -411,7 +426,7 @@
 		if (*cur_qp) {
 			if (*freed) {
 				wmb();
-				inc_cons_index(dev, cq, *freed);
+				update_cons_index(dev, cq, *freed);
 				*freed = 0;
 			}
 			spin_unlock(&(*cur_qp)->lock);
@@ -505,7 +520,7 @@
 	if (likely(free_cqe)) {
 		set_cqe_hw(cqe);
 		++(*freed);
-		cq->cons_index = (cq->cons_index + 1) & cq->ibcq.cqe;
+		++cq->cons_index;
 	}
 
 	return err;
@@ -533,7 +548,7 @@
 
 	if (freed) {
 		wmb();
-		inc_cons_index(dev, cq, freed);
+		update_cons_index(dev, cq, freed);
 	}
 
 	if (qp)
@@ -544,20 +559,57 @@
 	return err == 0 || err == -EAGAIN ? npolled : err;
 }
 
-void mthca_arm_cq(struct mthca_dev *dev, struct mthca_cq *cq,
-		  int solicited)
+int mthca_tavor_arm_cq(struct ib_cq *cq, enum ib_cq_notify notify)
 {
 	u32 doorbell[2];
 
-	doorbell[0] =  cpu_to_be32((solicited ?
-				    MTHCA_CQ_DB_REQ_NOT_SOL :
-				    MTHCA_CQ_DB_REQ_NOT)      |
-				   cq->cqn);
+	doorbell[0] = cpu_to_be32((notify == IB_CQ_SOLICITED ?
+				   MTHCA_TAVOR_CQ_DB_REQ_NOT_SOL :
+				   MTHCA_TAVOR_CQ_DB_REQ_NOT)      |
+				  to_mcq(cq)->cqn);
 	doorbell[1] = 0xffffffff;
 
 	mthca_write64(doorbell,
-		      dev->kar + MTHCA_CQ_DOORBELL,
-		      MTHCA_GET_DOORBELL_LOCK(&dev->doorbell_lock));
+		      to_mdev(cq->device)->kar + MTHCA_CQ_DOORBELL,
+		      MTHCA_GET_DOORBELL_LOCK(&to_mdev(cq->device)->doorbell_lock));
+
+	return 0;
+}
+
+int mthca_arbel_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify notify)
+{
+	struct mthca_cq *cq = to_mcq(ibcq);
+	u32 doorbell[2];
+	u32 sn;
+	u32 ci;
+
+	sn = cq->arm_sn & 3;
+	ci = cpu_to_be32(cq->cons_index);
+
+	doorbell[0] = ci;
+	doorbell[1] = cpu_to_be32((cq->cqn << 8) | (2 << 5) | (sn << 3) |
+				  (notify == IB_CQ_SOLICITED ? 1 : 2));
+
+	mthca_write_db_rec(doorbell, cq->arm_db);
+
+	/*
+	 * Make sure that the doorbell record in host memory is
+	 * written before ringing the doorbell via PCI MMIO.
+	 */
+	wmb();
+
+	doorbell[0] = cpu_to_be32((sn << 28)                       |
+				  (notify == IB_CQ_SOLICITED ?
+				   MTHCA_ARBEL_CQ_DB_REQ_NOT_SOL :
+				   MTHCA_ARBEL_CQ_DB_REQ_NOT)      |
+				  cq->cqn);
+	doorbell[1] = ci;
+
+	mthca_write64(doorbell,
+		      to_mdev(ibcq->device)->kar + MTHCA_CQ_DOORBELL,
+		      MTHCA_GET_DOORBELL_LOCK(&to_mdev(ibcq->device)->doorbell_lock));
+
+	return 0;
 }
 
 static void mthca_free_cq_buf(struct mthca_dev *dev, struct mthca_cq *cq)
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_dev.h	2005-03-03 14:12:59.077097900 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_dev.h	2005-03-03 14:13:01.213634129 -0800
@@ -368,8 +368,8 @@
 
 int mthca_poll_cq(struct ib_cq *ibcq, int num_entries,
 		  struct ib_wc *entry);
-void mthca_arm_cq(struct mthca_dev *dev, struct mthca_cq *cq,
-		  int solicited);
+int mthca_tavor_arm_cq(struct ib_cq *cq, enum ib_cq_notify notify);
+int mthca_arbel_arm_cq(struct ib_cq *cq, enum ib_cq_notify notify);
 int mthca_init_cq(struct mthca_dev *dev, int nent,
 		  struct mthca_cq *cq);
 void mthca_free_cq(struct mthca_dev *dev,
@@ -384,7 +384,7 @@
 		    struct ib_send_wr **bad_wr);
 int mthca_post_receive(struct ib_qp *ibqp, struct ib_recv_wr *wr,
 		       struct ib_recv_wr **bad_wr);
-int mthca_free_err_wqe(struct mthca_qp *qp, int is_send,
+int mthca_free_err_wqe(struct mthca_dev *dev, struct mthca_qp *qp, int is_send,
 		       int index, int *dbd, u32 *new_wqe);
 int mthca_alloc_qp(struct mthca_dev *dev,
 		   struct mthca_pd *pd,
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_provider.c	2005-03-03 14:12:59.925913650 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_provider.c	2005-03-03 14:13:01.213634129 -0800
@@ -421,13 +421,6 @@
 	return 0;
 }
 
-static int mthca_req_notify_cq(struct ib_cq *cq, enum ib_cq_notify notify)
-{
-	mthca_arm_cq(to_mdev(cq->device), to_mcq(cq),
-		     notify == IB_CQ_SOLICITED);
-	return 0;
-}
-
 static inline u32 convert_access(int acc)
 {
 	return (acc & IB_ACCESS_REMOTE_ATOMIC ? MTHCA_MPT_FLAG_ATOMIC       : 0) |
@@ -625,7 +618,6 @@
 	dev->ib_dev.create_cq            = mthca_create_cq;
 	dev->ib_dev.destroy_cq           = mthca_destroy_cq;
 	dev->ib_dev.poll_cq              = mthca_poll_cq;
-	dev->ib_dev.req_notify_cq        = mthca_req_notify_cq;
 	dev->ib_dev.get_dma_mr           = mthca_get_dma_mr;
 	dev->ib_dev.reg_phys_mr          = mthca_reg_phys_mr;
 	dev->ib_dev.dereg_mr             = mthca_dereg_mr;
@@ -633,6 +625,11 @@
 	dev->ib_dev.detach_mcast         = mthca_multicast_detach;
 	dev->ib_dev.process_mad          = mthca_process_mad;
 
+	if (dev->hca_type == ARBEL_NATIVE)
+		dev->ib_dev.req_notify_cq = mthca_arbel_arm_cq;
+	else
+		dev->ib_dev.req_notify_cq = mthca_tavor_arm_cq;
+
 	init_MUTEX(&dev->cap_mask_mutex);
 
 	ret = ib_register_device(&dev->ib_dev);
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_provider.h	2005-03-03 14:13:00.312829664 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_provider.h	2005-03-03 14:13:01.213634129 -0800
@@ -141,7 +141,7 @@
 	spinlock_t             lock;
 	atomic_t               refcount;
 	int                    cqn;
-	int                    cons_index;
+	u32                    cons_index;
 	int                    is_direct;
 
 	/* Next fields are Arbel only */
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_qp.c	2005-03-03 14:12:56.155732030 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_qp.c	2005-03-03 14:13:01.215633695 -0800
@@ -1551,7 +1551,7 @@
 	return err;
 }
 
-int mthca_free_err_wqe(struct mthca_qp *qp, int is_send,
+int mthca_free_err_wqe(struct mthca_dev *dev, struct mthca_qp *qp, int is_send,
 		       int index, int *dbd, u32 *new_wqe)
 {
 	struct mthca_next_seg *next;
@@ -1561,7 +1561,10 @@
 	else
 		next = get_recv_wqe(qp, index);
 
-	*dbd = !!(next->ee_nds & cpu_to_be32(MTHCA_NEXT_DBD));
+	if (dev->hca_type == ARBEL_NATIVE)
+		*dbd = 1;
+	else
+		*dbd = !!(next->ee_nds & cpu_to_be32(MTHCA_NEXT_DBD));
 	if (next->ee_nds & cpu_to_be32(0x3f))
 		*new_wqe = (next->nda_op & cpu_to_be32(~0x3f)) |
 			(next->ee_nds & cpu_to_be32(0x3f));

