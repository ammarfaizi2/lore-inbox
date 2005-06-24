Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263092AbVFXEIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263092AbVFXEIO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 00:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263113AbVFXEGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 00:06:13 -0400
Received: from webmail.topspin.com ([12.162.17.3]:33605 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S263094AbVFXEEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 00:04:23 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 06/14] IB/mthca: Set RDMA/atomic capabilities correctly
In-Reply-To: <2005623214.ZulWzVKl5lpV91f5@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 23 Jun 2005 21:04:20 -0700
Message-Id: <2005623214.rtUVEh14lfm8dUC3@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 24 Jun 2005 04:04:20.0792 (UTC) FILETIME=[CC865380:01C57871]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mthca apparently had the meanings of the max_rd_atomic and
max_dest_rd_atomic QP attributes backwards.  max_rd_atomic limits the
maximum number of outstanding RDMA/atomic requests as an initiator (on
a send queue), and max_dest_rd_atomic specifies the resources
allocated to handle RMDA/atomic requests from the remote end of the
connection.  We were programming our QP context with these values
swapped.

Signed-off-by: Roland Dreier <roland@topspin.com>

---

 linux.git/drivers/infiniband/hw/mthca/mthca_qp.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)



--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_qp.c	2005-06-23 13:03:05.234984039 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_qp.c	2005-06-23 13:03:05.636897055 -0700
@@ -724,9 +724,9 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 		qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_RETRY_COUNT);
 	}
 
-	if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC) {
-		qp_context->params1 |= cpu_to_be32(min(attr->max_dest_rd_atomic ?
-						       ffs(attr->max_dest_rd_atomic) - 1 : 0,
+	if (attr_mask & IB_QP_MAX_QP_RD_ATOMIC) {
+		qp_context->params1 |= cpu_to_be32(min(attr->max_rd_atomic ?
+						       ffs(attr->max_rd_atomic) - 1 : 0,
 						       7) << 21);
 		qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_SRA_MAX);
 	}
@@ -764,10 +764,10 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 		qp->atomic_rd_en = attr->qp_access_flags;
 	}
 
-	if (attr_mask & IB_QP_MAX_QP_RD_ATOMIC) {
+	if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC) {
 		u8 rra_max;
 
-		if (qp->resp_depth && !attr->max_rd_atomic) {
+		if (qp->resp_depth && !attr->max_dest_rd_atomic) {
 			/*
 			 * Lowering our responder resources to zero.
 			 * Turn off RDMA/atomics as responder.
@@ -778,7 +778,7 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 								MTHCA_QP_OPTPAR_RAE);
 		}
 
-		if (!qp->resp_depth && attr->max_rd_atomic) {
+		if (!qp->resp_depth && attr->max_dest_rd_atomic) {
 			/*
 			 * Increasing our responder resources from
 			 * zero.  Turn on RDMA/atomics as appropriate.
@@ -799,7 +799,7 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 		}
 
 		for (rra_max = 0;
-		     1 << rra_max < attr->max_rd_atomic &&
+		     1 << rra_max < attr->max_dest_rd_atomic &&
 			     rra_max < dev->qp_table.rdb_shift;
 		     ++rra_max)
 			; /* nothing */
@@ -807,7 +807,7 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 		qp_context->params2      |= cpu_to_be32(rra_max << 21);
 		qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_RRA_MAX);
 
-		qp->resp_depth = attr->max_rd_atomic;
+		qp->resp_depth = attr->max_dest_rd_atomic;
 	}
 
 	qp_context->params2 |= cpu_to_be32(MTHCA_QP_BIT_RSC);

