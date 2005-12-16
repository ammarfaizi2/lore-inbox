Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbVLPEBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbVLPEBM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 23:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbVLPEAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 23:00:46 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:50545 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S932121AbVLPEAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 23:00:42 -0500
Subject: [git patch review 6/7] IB/mthca: Fix IB_QP_ACCESS_FLAGS handling.
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 16 Dec 2005 04:00:17 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1134705617068-7e5f92b5a82fa6a2@cisco.com>
In-Reply-To: <1134705617068-ccaf1fa200ee1176@cisco.com>
X-OriginalArrivalTime: 16 Dec 2005 04:00:18.0032 (UTC) FILETIME=[3A1E5700:01C601F5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects some corner cases in managing the RAE/RRE bits in
the mthca qp context.  These bits need to be zero if the user requests
max_dest_rd_atomic of zero.  The bits need to be restored to the value
implied by the qp access flags attribute in a previous (or the
current) modify-qp command if the dest_rd_atomic variable is changed
to non-zero.

In the current implementation, the following scenario will not work:
RESET-to-INIT 	set QP access flags to all disabled (zeroes)
INIT-to-RTR     set max_dest_rd_atomic=10, AND
		set qp_access_flags = IB_ACCESS_REMOTE_READ | IB_ACCESS_REMOTE_ATOMIC

The current code will incorrectly take the access-flags value set in
the RESET-to-INIT transition.

We can simplify, and correct, this IB_QP_ACCESS_FLAGS handling: it is
always safe to set qp access flags in the firmware command if either
of IB_QP_MAX_DEST_RD_ATOMIC or IB_QP_ACCESS_FLAGS is set, so let's
just set it to the correct value, always.

Signed-off-by: Jack Morgenstein <jackm@mellanox.co.il>
Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_qp.c |   87 ++++++++++++++------------------
 1 files changed, 37 insertions(+), 50 deletions(-)

d1646f86a2a05a956adbb163c81a81bd621f055e
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index 3543299..e826c9f 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -522,6 +522,36 @@ static void init_port(struct mthca_dev *
 		mthca_warn(dev, "INIT_IB returned status %02x.\n", status);
 }
 
+static __be32 get_hw_access_flags(struct mthca_qp *qp, struct ib_qp_attr *attr,
+				  int attr_mask)
+{
+	u8 dest_rd_atomic;
+	u32 access_flags;
+	u32 hw_access_flags = 0;
+
+	if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC)
+		dest_rd_atomic = attr->max_dest_rd_atomic;
+	else
+		dest_rd_atomic = qp->resp_depth;
+
+	if (attr_mask & IB_QP_ACCESS_FLAGS)
+		access_flags = attr->qp_access_flags;
+	else
+		access_flags = qp->atomic_rd_en;
+
+	if (!dest_rd_atomic)
+		access_flags &= IB_ACCESS_REMOTE_WRITE;
+
+	if (access_flags & IB_ACCESS_REMOTE_READ)
+		hw_access_flags |= MTHCA_QP_BIT_RRE;
+	if (access_flags & IB_ACCESS_REMOTE_ATOMIC)
+		hw_access_flags |= MTHCA_QP_BIT_RAE;
+	if (access_flags & IB_ACCESS_REMOTE_WRITE)
+		hw_access_flags |= MTHCA_QP_BIT_RWE;
+
+	return cpu_to_be32(hw_access_flags);
+}
+
 int mthca_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask)
 {
 	struct mthca_dev *dev = to_mdev(ibqp->device);
@@ -743,57 +773,7 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 		qp_context->snd_db_index   = cpu_to_be32(qp->sq.db_index);
 	}
 
-	if (attr_mask & IB_QP_ACCESS_FLAGS) {
-		qp_context->params2 |=
-			cpu_to_be32(attr->qp_access_flags & IB_ACCESS_REMOTE_WRITE ?
-				    MTHCA_QP_BIT_RWE : 0);
-
-		/*
-		 * Only enable RDMA reads and atomics if we have
-		 * responder resources set to a non-zero value.
-		 */
-		if (qp->resp_depth) {
-			qp_context->params2 |=
-				cpu_to_be32(attr->qp_access_flags & IB_ACCESS_REMOTE_READ ?
-					    MTHCA_QP_BIT_RRE : 0);
-			qp_context->params2 |=
-				cpu_to_be32(attr->qp_access_flags & IB_ACCESS_REMOTE_ATOMIC ?
-					    MTHCA_QP_BIT_RAE : 0);
-		}
-
-		qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_RWE |
-							MTHCA_QP_OPTPAR_RRE |
-							MTHCA_QP_OPTPAR_RAE);
-	}
-
 	if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC) {
-		if (qp->resp_depth && !attr->max_dest_rd_atomic) {
-			/*
-			 * Lowering our responder resources to zero.
-			 * Turn off reads RDMA and atomics as responder.
-			 * (RRE/RAE in params2 already zero)
-			 */
-			qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_RRE |
-								MTHCA_QP_OPTPAR_RAE);
-		}
-
-		if (!qp->resp_depth && attr->max_dest_rd_atomic) {
-			/*
-			 * Increasing our responder resources from
-			 * zero.  Turn on RDMA reads and atomics as
-			 * appropriate.
-			 */
-			qp_context->params2 |=
-				cpu_to_be32(qp->atomic_rd_en & IB_ACCESS_REMOTE_READ ?
-					    MTHCA_QP_BIT_RRE : 0);
-			qp_context->params2 |=
-				cpu_to_be32(qp->atomic_rd_en & IB_ACCESS_REMOTE_ATOMIC ?
-					    MTHCA_QP_BIT_RAE : 0);
-
-			qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_RRE |
-								MTHCA_QP_OPTPAR_RAE);
-		}
-
 		if (attr->max_dest_rd_atomic)
 			qp_context->params2 |=
 				cpu_to_be32(fls(attr->max_dest_rd_atomic - 1) << 21);
@@ -801,6 +781,13 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 		qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_RRA_MAX);
 	}
 
+	if (attr_mask & (IB_QP_ACCESS_FLAGS | IB_QP_MAX_DEST_RD_ATOMIC)) {
+		qp_context->params2      |= get_hw_access_flags(qp, attr, attr_mask);
+		qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_RWE |
+							MTHCA_QP_OPTPAR_RRE |
+							MTHCA_QP_OPTPAR_RAE);
+	}
+
 	qp_context->params2 |= cpu_to_be32(MTHCA_QP_BIT_RSC);
 
 	if (ibqp->srq)
-- 
0.99.9n
