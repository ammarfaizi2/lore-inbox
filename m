Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbVCCXkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbVCCXkk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 18:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262755AbVCCXkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 18:40:02 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:56054 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262744AbVCCXWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:22:30 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][20/26] IB/mthca: mem-free QP initialization
In-Reply-To: <2005331520.VEavoMG964z0bUT1@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 3 Mar 2005 15:20:28 -0800
Message-Id: <2005331520.7k4CdyDk307HOUr6@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 23:20:28.0285 (UTC) FILETIME=[961802D0:01C52047]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update QP initialization and cleanup to handle mem-free mode.  In
mem-free mode, work queue sizes have to be rounded up to a power of 2,
we need to allocate doorbells, there must be memory mapped for the
entries in the QP and extended QP context table that we use, and the
entries of the receive queue must be initialized.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_provider.h	2005-03-03 14:13:01.213634129 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_provider.h	2005-03-03 14:13:01.712525837 -0800
@@ -167,6 +167,9 @@
 	void *last;
 	int   max_gs;
 	int   wqe_shift;
+
+	int   db_index;		/* Arbel only */
+	u32  *db;
 };
 
 struct mthca_qp {
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_qp.c	2005-03-03 14:13:01.215633695 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_qp.c	2005-03-03 14:13:01.713525620 -0800
@@ -40,6 +40,7 @@
 
 #include "mthca_dev.h"
 #include "mthca_cmd.h"
+#include "mthca_memfree.h"
 
 enum {
 	MTHCA_MAX_DIRECT_QP_SIZE = 4 * PAGE_SIZE,
@@ -105,8 +106,11 @@
 
 struct mthca_qp_context {
 	u32 flags;
-	u32 sched_queue;
-	u32 mtu_msgmax;
+	u32 tavor_sched_queue;	/* Reserved on Arbel */
+	u8  mtu_msgmax;
+	u8  rq_size_stride;	/* Reserved on Tavor */
+	u8  sq_size_stride;	/* Reserved on Tavor */
+	u8  rlkey_arbel_sched_queue;	/* Reserved on Tavor */
 	u32 usr_page;
 	u32 local_qpn;
 	u32 remote_qpn;
@@ -121,18 +125,22 @@
 	u32 reserved2;
 	u32 next_send_psn;
 	u32 cqn_snd;
-	u32 next_snd_wqe[2];
+	u32 snd_wqe_base_l;	/* Next send WQE on Tavor */
+	u32 snd_db_index;	/* (debugging only entries) */
 	u32 last_acked_psn;
 	u32 ssn;
 	u32 params2;
 	u32 rnr_nextrecvpsn;
 	u32 ra_buff_indx;
 	u32 cqn_rcv;
-	u32 next_rcv_wqe[2];
+	u32 rcv_wqe_base_l;	/* Next recv WQE on Tavor */
+	u32 rcv_db_index;	/* (debugging only entries) */
 	u32 qkey;
 	u32 srqn;
 	u32 rmsn;
-	u32 reserved3[19];
+	u16 rq_wqe_counter;	/* reserved on Tavor */
+	u16 sq_wqe_counter;	/* reserved on Tavor */
+	u32 reserved3[18];
 } __attribute__((packed));
 
 struct mthca_qp_param {
@@ -193,7 +201,7 @@
 	u32 imm;		/* immediate data */
 };
 
-struct mthca_ud_seg {
+struct mthca_tavor_ud_seg {
 	u32 reserved1;
 	u32 lkey;
 	u64 av_addr;
@@ -203,6 +211,13 @@
 	u32 reserved3[2];
 };
 
+struct mthca_arbel_ud_seg {
+	u32 av[8];
+	u32 dqpn;
+	u32 qkey;
+	u32 reserved[2];
+};
+
 struct mthca_bind_seg {
 	u32 flags;		/* [31] Atomic [30] rem write [29] rem read */
 	u32 reserved;
@@ -617,14 +632,24 @@
 			break;
 		}
 	}
-	/* leave sched_queue as 0 */
+
+	/* leave tavor_sched_queue as 0 */
+
 	if (qp->transport == MLX || qp->transport == UD)
-		qp_context->mtu_msgmax = cpu_to_be32((IB_MTU_2048 << 29) |
-						     (11 << 24));
+		qp_context->mtu_msgmax = (IB_MTU_2048 << 5) | 11;
 	else if (attr_mask & IB_QP_PATH_MTU) {
-		qp_context->mtu_msgmax = cpu_to_be32((attr->path_mtu << 29) |
-						     (31 << 24));
+		qp_context->mtu_msgmax = (attr->path_mtu << 5) | 31;
+	}
+
+	if (dev->hca_type == ARBEL_NATIVE) {
+		qp_context->rq_size_stride =
+			((ffs(qp->rq.max) - 1) << 3) | (qp->rq.wqe_shift - 4);
+		qp_context->sq_size_stride =
+			((ffs(qp->sq.max) - 1) << 3) | (qp->sq.wqe_shift - 4);
 	}
+
+	/* leave arbel_sched_queue as 0 */
+
 	qp_context->usr_page   = cpu_to_be32(dev->driver_uar.index);
 	qp_context->local_qpn  = cpu_to_be32(qp->qpn);
 	if (attr_mask & IB_QP_DEST_QPN) {
@@ -708,6 +733,11 @@
 		qp_context->next_send_psn = cpu_to_be32(attr->sq_psn);
 	qp_context->cqn_snd = cpu_to_be32(to_mcq(ibqp->send_cq)->cqn);
 
+	if (dev->hca_type == ARBEL_NATIVE) {
+		qp_context->snd_wqe_base_l = cpu_to_be32(qp->send_wqe_offset);
+		qp_context->snd_db_index   = cpu_to_be32(qp->sq.db_index);
+	}
+
 	if (attr_mask & IB_QP_ACCESS_FLAGS) {
 		/*
 		 * Only enable RDMA/atomics if we have responder
@@ -787,12 +817,16 @@
 	if (attr_mask & IB_QP_RQ_PSN)
 		qp_context->rnr_nextrecvpsn |= cpu_to_be32(attr->rq_psn);
 
-	qp_context->ra_buff_indx = dev->qp_table.rdb_base +
-		((qp->qpn & (dev->limits.num_qps - 1)) * MTHCA_RDB_ENTRY_SIZE <<
-		 dev->qp_table.rdb_shift);
+	qp_context->ra_buff_indx =
+		cpu_to_be32(dev->qp_table.rdb_base +
+			    ((qp->qpn & (dev->limits.num_qps - 1)) * MTHCA_RDB_ENTRY_SIZE <<
+			     dev->qp_table.rdb_shift));
 
 	qp_context->cqn_rcv = cpu_to_be32(to_mcq(ibqp->recv_cq)->cqn);
 
+	if (dev->hca_type == ARBEL_NATIVE)
+		qp_context->rcv_db_index   = cpu_to_be32(qp->rq.db_index);
+
 	if (attr_mask & IB_QP_QKEY) {
 		qp_context->qkey = cpu_to_be32(attr->qkey);
 		qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_Q_KEY);
@@ -860,12 +894,20 @@
 
 	size = sizeof (struct mthca_next_seg) +
 		qp->sq.max_gs * sizeof (struct mthca_data_seg);
-	if (qp->transport == MLX)
+	switch (qp->transport) {
+	case MLX:
 		size += 2 * sizeof (struct mthca_data_seg);
-	else if (qp->transport == UD)
-		size += sizeof (struct mthca_ud_seg);
-	else /* bind seg is as big as atomic + raddr segs */
+		break;
+	case UD:
+		if (dev->hca_type == ARBEL_NATIVE)
+			size += sizeof (struct mthca_arbel_ud_seg);
+		else
+			size += sizeof (struct mthca_tavor_ud_seg);
+		break;
+	default:
+		/* bind seg is as big as atomic + raddr segs */
 		size += sizeof (struct mthca_bind_seg);
+	}
 
 	for (qp->sq.wqe_shift = 6; 1 << qp->sq.wqe_shift < size;
 	     qp->sq.wqe_shift++)
@@ -942,7 +984,6 @@
 
 	err = mthca_mr_alloc_phys(dev, pd->pd_num, dma_list, shift,
 				  npages, 0, size,
-				  MTHCA_MPT_FLAG_LOCAL_WRITE |
 				  MTHCA_MPT_FLAG_LOCAL_READ,
 				  &qp->mr);
 	if (err)
@@ -972,6 +1013,60 @@
 	return err;
 }
 
+static int mthca_alloc_memfree(struct mthca_dev *dev,
+			       struct mthca_qp *qp)
+{
+	int ret = 0;
+
+	if (dev->hca_type == ARBEL_NATIVE) {
+		ret = mthca_table_get(dev, dev->qp_table.qp_table, qp->qpn);
+		if (ret)
+			return ret;
+
+		ret = mthca_table_get(dev, dev->qp_table.eqp_table, qp->qpn);
+		if (ret)
+			goto err_qpc;
+
+		qp->rq.db_index = mthca_alloc_db(dev, MTHCA_DB_TYPE_RQ,
+						 qp->qpn, &qp->rq.db);
+		if (qp->rq.db_index < 0) {
+			ret = -ENOMEM;
+			goto err_eqpc;
+		}
+
+		qp->sq.db_index = mthca_alloc_db(dev, MTHCA_DB_TYPE_SQ,
+						 qp->qpn, &qp->sq.db);
+		if (qp->sq.db_index < 0) {
+			ret = -ENOMEM;
+			goto err_rq_db;
+		}
+	}
+
+	return 0;
+
+err_rq_db:
+	mthca_free_db(dev, MTHCA_DB_TYPE_RQ, qp->rq.db_index);
+
+err_eqpc:
+	mthca_table_put(dev, dev->qp_table.eqp_table, qp->qpn);
+
+err_qpc:
+	mthca_table_put(dev, dev->qp_table.qp_table, qp->qpn);
+
+	return ret;
+}
+
+static void mthca_free_memfree(struct mthca_dev *dev,
+			       struct mthca_qp *qp)
+{
+	if (dev->hca_type == ARBEL_NATIVE) {
+		mthca_free_db(dev, MTHCA_DB_TYPE_SQ, qp->sq.db_index);
+		mthca_free_db(dev, MTHCA_DB_TYPE_RQ, qp->rq.db_index);
+		mthca_table_put(dev, dev->qp_table.eqp_table, qp->qpn);
+		mthca_table_put(dev, dev->qp_table.qp_table, qp->qpn);
+	}
+}
+
 static int mthca_alloc_qp_common(struct mthca_dev *dev,
 				 struct mthca_pd *pd,
 				 struct mthca_cq *send_cq,
@@ -979,7 +1074,9 @@
 				 enum ib_sig_type send_policy,
 				 struct mthca_qp *qp)
 {
-	int err;
+	struct mthca_next_seg *wqe;
+	int ret;
+	int i;
 
 	spin_lock_init(&qp->lock);
 	atomic_set(&qp->refcount, 1);
@@ -996,8 +1093,51 @@
 	qp->rq.last      = NULL;
 	qp->sq.last      = NULL;
 
-	err = mthca_alloc_wqe_buf(dev, pd, qp);
-	return err;
+	ret = mthca_alloc_memfree(dev, qp);
+	if (ret)
+		return ret;
+
+	ret = mthca_alloc_wqe_buf(dev, pd, qp);
+	if (ret) {
+		mthca_free_memfree(dev, qp);
+		return ret;
+	}
+
+	if (dev->hca_type == ARBEL_NATIVE) {
+		for (i = 0; i < qp->rq.max; ++i) {
+			wqe = get_recv_wqe(qp, i);
+			wqe->nda_op = cpu_to_be32(((i + 1) & (qp->rq.max - 1)) <<
+						  qp->rq.wqe_shift);
+			wqe->ee_nds = cpu_to_be32(1 << (qp->rq.wqe_shift - 4));
+		}
+
+		for (i = 0; i < qp->sq.max; ++i) {
+			wqe = get_send_wqe(qp, i);
+			wqe->nda_op = cpu_to_be32((((i + 1) & (qp->sq.max - 1)) <<
+						   qp->sq.wqe_shift) +
+						  qp->send_wqe_offset);
+		}
+	}
+
+	return 0;
+}
+
+static void mthca_align_qp_size(struct mthca_dev *dev, struct mthca_qp *qp)
+{
+	int i;
+
+	if (dev->hca_type != ARBEL_NATIVE)
+		return;
+
+	for (i = 0; 1 << i < qp->rq.max; ++i)
+		; /* nothing */
+
+	qp->rq.max = 1 << i;
+
+	for (i = 0; 1 << i < qp->sq.max; ++i)
+		; /* nothing */
+
+	qp->sq.max = 1 << i;
 }
 
 int mthca_alloc_qp(struct mthca_dev *dev,
@@ -1010,6 +1150,8 @@
 {
 	int err;
 
+	mthca_align_qp_size(dev, qp);
+
 	switch (type) {
 	case IB_QPT_RC: qp->transport = RC; break;
 	case IB_QPT_UC: qp->transport = UC; break;
@@ -1048,6 +1190,8 @@
 	int err = 0;
 	u32 mqpn = qpn * 2 + dev->qp_table.sqp_start + port - 1;
 
+	mthca_align_qp_size(dev, &sqp->qp);
+
 	sqp->header_buf_size = sqp->qp.sq.max * MTHCA_UD_HEADER_SIZE;
 	sqp->header_buf = dma_alloc_coherent(&dev->pdev->dev, sqp->header_buf_size,
 					     &sqp->header_dma, GFP_KERNEL);
@@ -1160,14 +1304,15 @@
 
 	kfree(qp->wrid);
 
+	mthca_free_memfree(dev, qp);
+
 	if (is_sqp(dev, qp)) {
 		atomic_dec(&(to_mpd(qp->ibqp.pd)->sqp_count));
 		dma_free_coherent(&dev->pdev->dev,
 				  to_msqp(qp)->header_buf_size,
 				  to_msqp(qp)->header_buf,
 				  to_msqp(qp)->header_dma);
-	}
-	else
+	} else
 		mthca_free(&dev->qp_table.alloc, qp->qpn);
 }
 
@@ -1350,17 +1495,17 @@
 			break;
 
 		case UD:
-			((struct mthca_ud_seg *) wqe)->lkey =
+			((struct mthca_tavor_ud_seg *) wqe)->lkey =
 				cpu_to_be32(to_mah(wr->wr.ud.ah)->key);
-			((struct mthca_ud_seg *) wqe)->av_addr =
+			((struct mthca_tavor_ud_seg *) wqe)->av_addr =
 				cpu_to_be64(to_mah(wr->wr.ud.ah)->avdma);
-			((struct mthca_ud_seg *) wqe)->dqpn =
+			((struct mthca_tavor_ud_seg *) wqe)->dqpn =
 				cpu_to_be32(wr->wr.ud.remote_qpn);
-			((struct mthca_ud_seg *) wqe)->qkey =
+			((struct mthca_tavor_ud_seg *) wqe)->qkey =
 				cpu_to_be32(wr->wr.ud.remote_qkey);
 
-			wqe += sizeof (struct mthca_ud_seg);
-			size += sizeof (struct mthca_ud_seg) / 16;
+			wqe += sizeof (struct mthca_tavor_ud_seg);
+			size += sizeof (struct mthca_tavor_ud_seg) / 16;
 			break;
 
 		case MLX:

