Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbVALWJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVALWJT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 17:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVALWIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:08:12 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:39078 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261484AbVALVsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:48:08 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20051121347.SllTsxtwWAwPk3Gh@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Wed, 12 Jan 2005 13:47:46 -0800
Message-Id: <20051121347.gzXWVDbfUCDwWmdf@topspin.com>
Mime-Version: 1.0
To: akpm@osdl.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][3/18] InfiniBand/mthca: support RDMA/atomic attributes in QP modify
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 12 Jan 2005 21:47:47.0188 (UTC) FILETIME=[5AC47340:01C4F8F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement setting of RDMA/atomic enable bits, initiator resources and
responder resources for modify QP in low-level Mellanox HCA driver
(should complete RDMA/atomic implementation).

Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux/drivers/infiniband/hw/mthca/mthca_dev.h	(revision 1421)
+++ linux/drivers/infiniband/hw/mthca/mthca_dev.h	(revision 1422)
@@ -75,6 +75,7 @@
 	MTHCA_EQ_CONTEXT_SIZE =  0x40,
 	MTHCA_CQ_CONTEXT_SIZE =  0x40,
 	MTHCA_QP_CONTEXT_SIZE = 0x200,
+	MTHCA_RDB_ENTRY_SIZE  =  0x20,
 	MTHCA_AV_SIZE         =  0x20,
 	MTHCA_MGM_ENTRY_SIZE  =  0x40
 };
@@ -121,7 +122,6 @@
 	int      mtt_seg_size;
 	int      reserved_mtts;
 	int      reserved_mrws;
-	int      num_rdbs;
 	int      reserved_uars;
 	int      num_mgms;
 	int      num_amgms;
@@ -174,6 +174,8 @@
 
 struct mthca_qp_table {
 	struct mthca_alloc alloc;
+	u32                rdb_base;
+	int                rdb_shift;
 	int                sqp_start;
 	spinlock_t         lock;
 	struct mthca_array qp;
--- linux/drivers/infiniband/hw/mthca/mthca_provider.h	(revision 1421)
+++ linux/drivers/infiniband/hw/mthca/mthca_provider.h	(revision 1422)
@@ -162,9 +162,12 @@
 	spinlock_t             lock;
 	atomic_t               refcount;
 	u32                    qpn;
-	int                    transport;
-	enum ib_qp_state       state;
 	int                    is_direct;
+	u8                     transport;
+	u8                     state;
+	u8                     atomic_rd_en;
+	u8                     resp_depth;
+
 	struct mthca_mr        mr;
 
 	struct mthca_wq        rq;
--- linux/drivers/infiniband/hw/mthca/mthca_profile.c	(revision 1421)
+++ linux/drivers/infiniband/hw/mthca/mthca_profile.c	(revision 1422)
@@ -50,7 +50,6 @@
 };
 
 enum {
-	MTHCA_RDB_ENTRY_SIZE = 32,
 	MTHCA_MTT_SEG_SIZE   = 64
 };
 
@@ -181,8 +180,13 @@
 			init_hca->log_num_eqs = profile[i].log_num;
 			break;
 		case MTHCA_RES_RDB:
-			dev->limits.num_rdbs = profile[i].num;
-			init_hca->rdb_base   = profile[i].start;
+			for (dev->qp_table.rdb_shift = 0;
+			     profile[MTHCA_RES_QP].num << dev->qp_table.rdb_shift <
+				     profile[i].num;
+			     ++dev->qp_table.rdb_shift)
+				; /* nothing */
+			dev->qp_table.rdb_base    = (u32) profile[i].start;
+			init_hca->rdb_base        = profile[i].start;
 			break;
 		case MTHCA_RES_MCG:
 			dev->limits.num_mgms      = profile[i].num >> 1;
--- linux/drivers/infiniband/hw/mthca/mthca_qp.c	(revision 1421)
+++ linux/drivers/infiniband/hw/mthca/mthca_qp.c	(revision 1422)
@@ -146,7 +146,7 @@
 	MTHCA_QP_OPTPAR_ALT_ADDR_PATH     = 1 << 0,
 	MTHCA_QP_OPTPAR_RRE               = 1 << 1,
 	MTHCA_QP_OPTPAR_RAE               = 1 << 2,
-	MTHCA_QP_OPTPAR_REW               = 1 << 3,
+	MTHCA_QP_OPTPAR_RWE               = 1 << 3,
 	MTHCA_QP_OPTPAR_PKEY_INDEX        = 1 << 4,
 	MTHCA_QP_OPTPAR_Q_KEY             = 1 << 5,
 	MTHCA_QP_OPTPAR_RNR_TIMEOUT       = 1 << 6,
@@ -697,14 +697,87 @@
 		qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_RETRY_COUNT);
 	}
 
-	/* XXX initiator resources */
+	if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC) {
+		qp_context->params1 |= cpu_to_be32(min(attr->max_dest_rd_atomic ?
+						       ffs(attr->max_dest_rd_atomic) - 1 : 0,
+						       7) << 21);
+		qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_SRA_MAX);
+	}
 
 	if (attr_mask & IB_QP_SQ_PSN)
 		qp_context->next_send_psn = cpu_to_be32(attr->sq_psn);
 	qp_context->cqn_snd = cpu_to_be32(to_mcq(ibqp->send_cq)->cqn);
 
-	/* XXX RDMA/atomic enable, responder resources */
+	if (attr_mask & IB_QP_ACCESS_FLAGS) {
+		/*
+		 * Only enable RDMA/atomics if we have responder
+		 * resources set to a non-zero value.
+		 */
+		if (qp->resp_depth) {
+			qp_context->params2 |=
+				cpu_to_be32(attr->qp_access_flags & IB_ACCESS_REMOTE_WRITE ?
+					    MTHCA_QP_BIT_RWE : 0);
+			qp_context->params2 |=
+				cpu_to_be32(attr->qp_access_flags & IB_ACCESS_REMOTE_READ ?
+					    MTHCA_QP_BIT_RRE : 0);
+			qp_context->params2 |=
+				cpu_to_be32(attr->qp_access_flags & IB_ACCESS_REMOTE_ATOMIC ?
+					    MTHCA_QP_BIT_RAE : 0);
+		}
 
+		qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_RWE |
+							MTHCA_QP_OPTPAR_RRE |
+							MTHCA_QP_OPTPAR_RAE);
+
+		qp->atomic_rd_en = attr->qp_access_flags;
+	}
+
+	if (attr_mask & IB_QP_MAX_QP_RD_ATOMIC) {
+		u8 rra_max;
+
+		if (qp->resp_depth && !attr->max_rd_atomic) {
+			/*
+			 * Lowering our responder resources to zero.
+			 * Turn off RDMA/atomics as responder.
+			 * (RWE/RRE/RAE in params2 already zero)
+			 */
+			qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_RWE |
+								MTHCA_QP_OPTPAR_RRE |
+								MTHCA_QP_OPTPAR_RAE);
+		}
+
+		if (!qp->resp_depth && attr->max_rd_atomic) {
+			/*
+			 * Increasing our responder resources from
+			 * zero.  Turn on RDMA/atomics as appropriate.
+			 */
+			qp_context->params2 |=
+				cpu_to_be32(qp->atomic_rd_en & IB_ACCESS_REMOTE_WRITE ?
+					    MTHCA_QP_BIT_RWE : 0);
+			qp_context->params2 |=
+				cpu_to_be32(qp->atomic_rd_en & IB_ACCESS_REMOTE_READ ?
+					    MTHCA_QP_BIT_RRE : 0);
+			qp_context->params2 |=
+				cpu_to_be32(qp->atomic_rd_en & IB_ACCESS_REMOTE_ATOMIC ?
+					    MTHCA_QP_BIT_RAE : 0);
+
+			qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_RWE |
+								MTHCA_QP_OPTPAR_RRE |
+								MTHCA_QP_OPTPAR_RAE);
+		}
+
+		for (rra_max = 0;
+		     1 << rra_max < attr->max_rd_atomic &&
+			     rra_max < dev->qp_table.rdb_shift;
+		     ++rra_max)
+			; /* nothing */
+
+		qp_context->params2      |= cpu_to_be32(rra_max << 21);
+		qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_RRA_MAX);
+
+		qp->resp_depth = attr->max_rd_atomic;
+	}
+
 	if (qp->rq.policy == IB_SIGNAL_ALL_WR)
 		qp_context->params2 |= cpu_to_be32(MTHCA_QP_BIT_RSC);
 	if (attr_mask & IB_QP_MIN_RNR_TIMER) {
@@ -714,7 +787,9 @@
 	if (attr_mask & IB_QP_RQ_PSN)
 		qp_context->rnr_nextrecvpsn |= cpu_to_be32(attr->rq_psn);
 
-	/* XXX ra_buff_indx */
+	qp_context->ra_buff_indx = dev->qp_table.rdb_base +
+		((qp->qpn & (dev->limits.num_qps - 1)) * MTHCA_RDB_ENTRY_SIZE <<
+		 dev->qp_table.rdb_shift);
 
 	qp_context->cqn_rcv = cpu_to_be32(to_mcq(ibqp->recv_cq)->cqn);
 
@@ -910,6 +985,8 @@
 	spin_lock_init(&qp->lock);
 	atomic_set(&qp->refcount, 1);
 	qp->state    	 = IB_QPS_RESET;
+	qp->atomic_rd_en = 0;
+	qp->resp_depth   = 0;
 	qp->sq.policy    = send_policy;
 	qp->rq.policy    = recv_policy;
 	qp->rq.cur       = 0;

