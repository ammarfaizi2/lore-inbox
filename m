Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262725AbVCDBnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbVCDBnk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 20:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbVCDAAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:00:32 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:56054 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262724AbVCCXWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:22:09 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][6/26] IB: remove unsignaled receives
In-Reply-To: <2005331520.bkPiyqSCQe0LOju5@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 3 Mar 2005 15:20:27 -0800
Message-Id: <2005331520.psAuTRchMaqO6dem@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 23:20:27.0300 (UTC) FILETIME=[9581B640:01C52047]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael S. Tsirkin <mst@mellanox.co.il>

Remove support for unsignaled receive requests.  This is a
non-standard extension to the IB spec that is not used by any known
applications or protocols, and is not supported by newer hardware.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/core/mad.c	2005-03-02 20:53:21.000000000 -0800
+++ linux-export/drivers/infiniband/core/mad.c	2005-03-03 14:12:54.671054304 -0800
@@ -2191,7 +2191,6 @@
 	recv_wr.next = NULL;
 	recv_wr.sg_list = &sg_list;
 	recv_wr.num_sge = 1;
-	recv_wr.recv_flags = IB_RECV_SIGNALED;
 
 	do {
 		/* Allocate and map receive buffer */
@@ -2386,7 +2385,6 @@
 	qp_init_attr.send_cq = qp_info->port_priv->cq;
 	qp_init_attr.recv_cq = qp_info->port_priv->cq;
 	qp_init_attr.sq_sig_type = IB_SIGNAL_ALL_WR;
-	qp_init_attr.rq_sig_type = IB_SIGNAL_ALL_WR;
 	qp_init_attr.cap.max_send_wr = IB_MAD_QP_SEND_SIZE;
 	qp_init_attr.cap.max_recv_wr = IB_MAD_QP_RECV_SIZE;
 	qp_init_attr.cap.max_send_sge = IB_MAD_SEND_REQ_MAX_SG;
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_dev.h	2005-01-25 20:48:48.000000000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_dev.h	2005-03-03 14:12:54.672054087 -0800
@@ -369,14 +369,12 @@
 		   struct mthca_cq *recv_cq,
 		   enum ib_qp_type type,
 		   enum ib_sig_type send_policy,
-		   enum ib_sig_type recv_policy,
 		   struct mthca_qp *qp);
 int mthca_alloc_sqp(struct mthca_dev *dev,
 		    struct mthca_pd *pd,
 		    struct mthca_cq *send_cq,
 		    struct mthca_cq *recv_cq,
 		    enum ib_sig_type send_policy,
-		    enum ib_sig_type recv_policy,
 		    int qpn,
 		    int port,
 		    struct mthca_sqp *sqp);
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_provider.c	2005-01-25 20:49:23.000000000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_provider.c	2005-03-03 14:12:54.673053870 -0800
@@ -343,7 +343,7 @@
 				     to_mcq(init_attr->send_cq),
 				     to_mcq(init_attr->recv_cq),
 				     init_attr->qp_type, init_attr->sq_sig_type,
-				     init_attr->rq_sig_type, qp);
+				     qp);
 		qp->ibqp.qp_num = qp->qpn;
 		break;
 	}
@@ -364,7 +364,7 @@
 		err = mthca_alloc_sqp(to_mdev(pd->device), to_mpd(pd),
 				      to_mcq(init_attr->send_cq),
 				      to_mcq(init_attr->recv_cq),
-				      init_attr->sq_sig_type, init_attr->rq_sig_type,
+				      init_attr->sq_sig_type,
 				      qp->ibqp.qp_num, init_attr->port_num,
 				      to_msqp(qp));
 		break;
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_provider.h	2005-01-25 20:47:46.000000000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_provider.h	2005-03-03 14:12:54.674053653 -0800
@@ -154,7 +154,6 @@
 	void *last;
 	int   max_gs;
 	int   wqe_shift;
-	enum ib_sig_type policy;
 };
 
 struct mthca_qp {
@@ -172,6 +171,7 @@
 
 	struct mthca_wq        rq;
 	struct mthca_wq        sq;
+	enum ib_sig_type       sq_policy;
 	int                    send_wqe_offset;
 
 	u64                   *wrid;
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_qp.c	2005-03-03 14:12:52.924433436 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_qp.c	2005-03-03 14:12:54.675053436 -0800
@@ -690,7 +690,7 @@
 					     MTHCA_QP_BIT_SRE           |
 					     MTHCA_QP_BIT_SWE           |
 					     MTHCA_QP_BIT_SAE);
-	if (qp->sq.policy == IB_SIGNAL_ALL_WR)
+	if (qp->sq_policy == IB_SIGNAL_ALL_WR)
 		qp_context->params1 |= cpu_to_be32(MTHCA_QP_BIT_SSC);
 	if (attr_mask & IB_QP_RETRY_CNT) {
 		qp_context->params1 |= cpu_to_be32(attr->retry_cnt << 16);
@@ -778,8 +778,8 @@
 		qp->resp_depth = attr->max_rd_atomic;
 	}
 
-	if (qp->rq.policy == IB_SIGNAL_ALL_WR)
-		qp_context->params2 |= cpu_to_be32(MTHCA_QP_BIT_RSC);
+	qp_context->params2 |= cpu_to_be32(MTHCA_QP_BIT_RSC);
+
 	if (attr_mask & IB_QP_MIN_RNR_TIMER) {
 		qp_context->rnr_nextrecvpsn |= cpu_to_be32(attr->min_rnr_timer << 24);
 		qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_RNR_TIMEOUT);
@@ -977,7 +977,6 @@
 				 struct mthca_cq *send_cq,
 				 struct mthca_cq *recv_cq,
 				 enum ib_sig_type send_policy,
-				 enum ib_sig_type recv_policy,
 				 struct mthca_qp *qp)
 {
 	int err;
@@ -987,8 +986,7 @@
 	qp->state    	 = IB_QPS_RESET;
 	qp->atomic_rd_en = 0;
 	qp->resp_depth   = 0;
-	qp->sq.policy    = send_policy;
-	qp->rq.policy    = recv_policy;
+	qp->sq_policy    = send_policy;
 	qp->rq.cur       = 0;
 	qp->sq.cur       = 0;
 	qp->rq.next      = 0;
@@ -1008,7 +1006,6 @@
 		   struct mthca_cq *recv_cq,
 		   enum ib_qp_type type,
 		   enum ib_sig_type send_policy,
-		   enum ib_sig_type recv_policy,
 		   struct mthca_qp *qp)
 {
 	int err;
@@ -1025,7 +1022,7 @@
 		return -ENOMEM;
 
 	err = mthca_alloc_qp_common(dev, pd, send_cq, recv_cq,
-				    send_policy, recv_policy, qp);
+				    send_policy, qp);
 	if (err) {
 		mthca_free(&dev->qp_table.alloc, qp->qpn);
 		return err;
@@ -1044,7 +1041,6 @@
 		    struct mthca_cq *send_cq,
 		    struct mthca_cq *recv_cq,
 		    enum ib_sig_type send_policy,
-		    enum ib_sig_type recv_policy,
 		    int qpn,
 		    int port,
 		    struct mthca_sqp *sqp)
@@ -1073,8 +1069,7 @@
 	sqp->qp.transport = MLX;
 
 	err = mthca_alloc_qp_common(dev, pd, send_cq, recv_cq,
-				    send_policy, recv_policy,
-				    &sqp->qp);
+				    send_policy, &sqp->qp);
 	if (err)
 		goto err_out_free;
 
@@ -1495,9 +1490,7 @@
 		((struct mthca_next_seg *) wqe)->nda_op = 0;
 		((struct mthca_next_seg *) wqe)->ee_nds =
 			cpu_to_be32(MTHCA_NEXT_DBD);
-		((struct mthca_next_seg *) wqe)->flags =
-			(wr->recv_flags & IB_RECV_SIGNALED) ?
-			cpu_to_be32(MTHCA_NEXT_CQ_UPDATE) : 0;
+		((struct mthca_next_seg *) wqe)->flags = 0;
 
 		wqe += sizeof (struct mthca_next_seg);
 		size = sizeof (struct mthca_next_seg) / 16;
--- linux-export.orig/drivers/infiniband/include/ib_verbs.h	2005-01-25 20:47:00.000000000 -0800
+++ linux-export/drivers/infiniband/include/ib_verbs.h	2005-03-03 14:12:54.669054738 -0800
@@ -73,7 +73,6 @@
 	IB_DEVICE_RC_RNR_NAK_GEN	= (1<<12),
 	IB_DEVICE_SRQ_RESIZE		= (1<<13),
 	IB_DEVICE_N_NOTIFY_CQ		= (1<<14),
-	IB_DEVICE_RQ_SIG_TYPE		= (1<<15)
 };
 
 enum ib_atomic_cap {
@@ -408,7 +407,6 @@
 	struct ib_srq	       *srq;
 	struct ib_qp_cap	cap;
 	enum ib_sig_type	sq_sig_type;
-	enum ib_sig_type	rq_sig_type;
 	enum ib_qp_type		qp_type;
 	u8			port_num; /* special QP types only */
 };
@@ -533,10 +531,6 @@
 	IB_SEND_INLINE		= (1<<3)
 };
 
-enum ib_recv_flags {
-	IB_RECV_SIGNALED	= 1
-};
-
 struct ib_sge {
 	u64	addr;
 	u32	length;
@@ -579,7 +573,6 @@
 	u64			wr_id;
 	struct ib_sge	       *sg_list;
 	int			num_sge;
-	int			recv_flags;
 };
 
 enum ib_access_flags {
--- linux-export.orig/drivers/infiniband/ulp/ipoib/ipoib_ib.c	2005-03-02 20:53:21.000000000 -0800
+++ linux-export/drivers/infiniband/ulp/ipoib/ipoib_ib.c	2005-03-03 14:12:54.668054955 -0800
@@ -105,7 +105,6 @@
 		.wr_id 	    = wr_id | IPOIB_OP_RECV,
 		.sg_list    = &list,
 		.num_sge    = 1,
-		.recv_flags = IB_RECV_SIGNALED
 	};
 	struct ib_recv_wr *bad_wr;
 
--- linux-export.orig/drivers/infiniband/ulp/ipoib/ipoib_verbs.c	2005-01-15 15:19:59.000000000 -0800
+++ linux-export/drivers/infiniband/ulp/ipoib/ipoib_verbs.c	2005-03-03 14:12:54.667055172 -0800
@@ -165,7 +165,6 @@
 			.max_recv_sge = 1
 		},
 		.sq_sig_type = IB_SIGNAL_ALL_WR,
-		.rq_sig_type = IB_SIGNAL_ALL_WR,
 		.qp_type     = IB_QPT_UD
 	};
 

