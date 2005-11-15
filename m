Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbVKOIjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbVKOIjE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 03:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbVKOIim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 03:38:42 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:53425 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751382AbVKOIik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 03:38:40 -0500
Subject: [git patch review 3/3] [IB] mthca: don't disable RDMA writes if no
	responder resources
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 15 Nov 2005 08:38:30 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1132043910918-bea399454f2ff33e@cisco.com>
In-Reply-To: <1132043910918-5d38e36f350b7b00@cisco.com>
X-OriginalArrivalTime: 15 Nov 2005 08:38:32.0065 (UTC) FILETIME=[F5BB5F10:01C5E9BF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Responder resources are only required to handle RDMA reads and atomic
operations, not RDMA writes.  So the driver should allow RDMA writes
even if responder resources are set to 0.  This is especially
important for the UC transport -- with the old code, it was impossible
to enable RDMA writes for UC QPs.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_qp.c |   27 ++++++++++++---------------
 1 files changed, 12 insertions(+), 15 deletions(-)

applies-to: 2d17f2cdc77646d07cb2a598e3d2bcbdf94675ad
cbc5b2bb9e226c2b2b981836d2289912e2ef3c1c
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index 760c418..5899f0c 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -730,15 +730,16 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 	}
 
 	if (attr_mask & IB_QP_ACCESS_FLAGS) {
+		qp_context->params2 |=
+			cpu_to_be32(attr->qp_access_flags & IB_ACCESS_REMOTE_WRITE ?
+				    MTHCA_QP_BIT_RWE : 0);
+
 		/*
-		 * Only enable RDMA/atomics if we have responder
-		 * resources set to a non-zero value.
+		 * Only enable RDMA reads and atomics if we have
+		 * responder resources set to a non-zero value.
 		 */
 		if (qp->resp_depth) {
 			qp_context->params2 |=
-				cpu_to_be32(attr->qp_access_flags & IB_ACCESS_REMOTE_WRITE ?
-					    MTHCA_QP_BIT_RWE : 0);
-			qp_context->params2 |=
 				cpu_to_be32(attr->qp_access_flags & IB_ACCESS_REMOTE_READ ?
 					    MTHCA_QP_BIT_RRE : 0);
 			qp_context->params2 |=
@@ -759,31 +760,27 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 		if (qp->resp_depth && !attr->max_dest_rd_atomic) {
 			/*
 			 * Lowering our responder resources to zero.
-			 * Turn off RDMA/atomics as responder.
-			 * (RWE/RRE/RAE in params2 already zero)
+			 * Turn off reads RDMA and atomics as responder.
+			 * (RRE/RAE in params2 already zero)
 			 */
-			qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_RWE |
-								MTHCA_QP_OPTPAR_RRE |
+			qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_RRE |
 								MTHCA_QP_OPTPAR_RAE);
 		}
 
 		if (!qp->resp_depth && attr->max_dest_rd_atomic) {
 			/*
 			 * Increasing our responder resources from
-			 * zero.  Turn on RDMA/atomics as appropriate.
+			 * zero.  Turn on RDMA reads and atomics as
+			 * appropriate.
 			 */
 			qp_context->params2 |=
-				cpu_to_be32(qp->atomic_rd_en & IB_ACCESS_REMOTE_WRITE ?
-					    MTHCA_QP_BIT_RWE : 0);
-			qp_context->params2 |=
 				cpu_to_be32(qp->atomic_rd_en & IB_ACCESS_REMOTE_READ ?
 					    MTHCA_QP_BIT_RRE : 0);
 			qp_context->params2 |=
 				cpu_to_be32(qp->atomic_rd_en & IB_ACCESS_REMOTE_ATOMIC ?
 					    MTHCA_QP_BIT_RAE : 0);
 
-			qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_RWE |
-								MTHCA_QP_OPTPAR_RRE |
+			qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_RRE |
 								MTHCA_QP_OPTPAR_RAE);
 		}
 
---
0.99.9g
