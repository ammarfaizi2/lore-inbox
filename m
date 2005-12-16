Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbVLPEAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbVLPEAU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 23:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbVLPEAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 23:00:19 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:14458 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932108AbVLPEAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 23:00:18 -0500
X-IronPort-AV: i="3.99,259,1131350400"; 
   d="scan'208"; a="685293684:sNHT31744076"
Subject: [git patch review 3/7] IB/mthca: don't change driver's copy of
	attributes if modify QP fails
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 16 Dec 2005 04:00:17 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1134705617068-301e9a8555929947@cisco.com>
In-Reply-To: <1134705617067-bb88e1b23a3e36b6@cisco.com>
X-OriginalArrivalTime: 16 Dec 2005 04:00:17.0813 (UTC) FILETIME=[39FCEC50:01C601F5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only change the driver's copy of the QP attributes in modify QP after
checking the modify QP command completed successfully.

Signed-off-by: Jack Morgenstein <jackm@mellanox.co.il>
Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_qp.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

44b5b0303327cfb23f135b95b2fe5436c81ed27c
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index 84056a8..3543299 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -764,8 +764,6 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 		qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_RWE |
 							MTHCA_QP_OPTPAR_RRE |
 							MTHCA_QP_OPTPAR_RAE);
-
-		qp->atomic_rd_en = attr->qp_access_flags;
 	}
 
 	if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC) {
@@ -801,8 +799,6 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 				cpu_to_be32(fls(attr->max_dest_rd_atomic - 1) << 21);
 
 		qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_RRA_MAX);
-
-		qp->resp_depth = attr->max_dest_rd_atomic;
 	}
 
 	qp_context->params2 |= cpu_to_be32(MTHCA_QP_BIT_RSC);
@@ -844,8 +840,13 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 		err = -EINVAL;
 	}
 
-	if (!err)
+	if (!err) {
 		qp->state = new_state;
+		if (attr_mask & IB_QP_ACCESS_FLAGS)
+			qp->atomic_rd_en = attr->qp_access_flags;
+		if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC)
+			qp->resp_depth = attr->max_dest_rd_atomic;
+	}
 
 	mthca_free_mailbox(dev, mailbox);
 
-- 
0.99.9n
