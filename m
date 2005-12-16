Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbVLPEAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbVLPEAV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 23:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbVLPEAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 23:00:20 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:14458 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932114AbVLPEAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 23:00:19 -0500
X-IronPort-AV: i="3.99,259,1131350400"; 
   d="scan'208"; a="685293687:sNHT31735884"
Subject: [git patch review 2/7] IB/mthca: correct log2 calculation
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 16 Dec 2005 04:00:17 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1134705617067-bb88e1b23a3e36b6@cisco.com>
In-Reply-To: <1134705617067-b51dec64cec55f52@cisco.com>
X-OriginalArrivalTime: 16 Dec 2005 04:00:17.0697 (UTC) FILETIME=[39EB3910:01C601F5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix thinko in rd_atomic calculation: ffs(x) - 1 does not find the next
power of 2 -- it should be fls(x - 1).

Signed-off-by: Jack Morgenstein <jackm@mellanox.co.il>
Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_qp.c |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

6aa2e4e8063114bd7cea8616dd5848d3c64b4c36
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index c5c3d0e..84056a8 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -728,9 +728,9 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 	}
 
 	if (attr_mask & IB_QP_MAX_QP_RD_ATOMIC) {
-		qp_context->params1 |= cpu_to_be32(min(attr->max_rd_atomic ?
-						       ffs(attr->max_rd_atomic) - 1 : 0,
-						       7) << 21);
+		if (attr->max_rd_atomic)
+			qp_context->params1 |=
+				cpu_to_be32(fls(attr->max_rd_atomic - 1) << 21);
 		qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_SRA_MAX);
 	}
 
@@ -769,8 +769,6 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 	}
 
 	if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC) {
-		u8 rra_max;
-
 		if (qp->resp_depth && !attr->max_dest_rd_atomic) {
 			/*
 			 * Lowering our responder resources to zero.
@@ -798,13 +796,10 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 								MTHCA_QP_OPTPAR_RAE);
 		}
 
-		for (rra_max = 0;
-		     1 << rra_max < attr->max_dest_rd_atomic &&
-			     rra_max < dev->qp_table.rdb_shift;
-		     ++rra_max)
-			; /* nothing */
+		if (attr->max_dest_rd_atomic)
+			qp_context->params2 |=
+				cpu_to_be32(fls(attr->max_dest_rd_atomic - 1) << 21);
 
-		qp_context->params2      |= cpu_to_be32(rra_max << 21);
 		qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_RRA_MAX);
 
 		qp->resp_depth = attr->max_dest_rd_atomic;
-- 
0.99.9n
