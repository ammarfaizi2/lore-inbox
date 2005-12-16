Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbVLPEBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbVLPEBN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 23:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbVLPEAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 23:00:44 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:35388 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S932117AbVLPEAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 23:00:24 -0500
X-IronPort-AV: i="3.99,259,1131350400"; 
   d="scan'208"; a="379132358:sNHT31010216"
Subject: [git patch review 7/7] IB/mthca: Fix corner cases in max_rd_atomic
	value handling in modify QP
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 16 Dec 2005 04:00:17 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1134705617068-3687c807077d2ef3@cisco.com>
In-Reply-To: <1134705617068-7e5f92b5a82fa6a2@cisco.com>
X-OriginalArrivalTime: 16 Dec 2005 04:00:17.0931 (UTC) FILETIME=[3A0EEDB0:01C601F5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sae and sre bits should only be set when setting sra_max.  Further, in
the old code, if the caller specifies max_rd_atomic = 0, the sre and
sae bits are still set, with the result that the QP ends up with
max_rd_atomic = 1 in effect.

Signed-off-by: Jack Morgenstein <jackm@mellanox.co.il>
Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_qp.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

c4342d8a4d95e18b957b898dbf5bfce28fca2780
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index e826c9f..d786ef4 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -747,9 +747,7 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 	qp_context->wqe_lkey   = cpu_to_be32(qp->mr.ibmr.lkey);
 	qp_context->params1    = cpu_to_be32((MTHCA_ACK_REQ_FREQ << 28) |
 					     (MTHCA_FLIGHT_LIMIT << 24) |
-					     MTHCA_QP_BIT_SRE           |
-					     MTHCA_QP_BIT_SWE           |
-					     MTHCA_QP_BIT_SAE);
+					     MTHCA_QP_BIT_SWE);
 	if (qp->sq_policy == IB_SIGNAL_ALL_WR)
 		qp_context->params1 |= cpu_to_be32(MTHCA_QP_BIT_SSC);
 	if (attr_mask & IB_QP_RETRY_CNT) {
@@ -758,9 +756,13 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 	}
 
 	if (attr_mask & IB_QP_MAX_QP_RD_ATOMIC) {
-		if (attr->max_rd_atomic)
+		if (attr->max_rd_atomic) {
+			qp_context->params1 |=
+				cpu_to_be32(MTHCA_QP_BIT_SRE |
+					    MTHCA_QP_BIT_SAE);
 			qp_context->params1 |=
 				cpu_to_be32(fls(attr->max_rd_atomic - 1) << 21);
+		}
 		qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_SRA_MAX);
 	}
 
-- 
0.99.9n
