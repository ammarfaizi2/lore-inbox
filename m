Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965172AbVITWKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbVITWKF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 18:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965126AbVITWJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 18:09:08 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:52121 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S965116AbVITWI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 18:08:27 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 03/10] IB/mthca: fix posting of first work request
In-Reply-To: <2005920158.rJMu8Og0ayj9lKb3@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 20 Sep 2005 15:08:11 -0700
Message-Id: <2005920158.ofLOVgpQOqw9UR3J@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
X-OriginalArrivalTime: 20 Sep 2005 22:08:12.0089 (UTC) FILETIME=[CA8CC290:01C5BE2F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix posting first WQE for mem-free HCAs: we need to link to previous
WQE even in that case.  While we're at it, simplify code for
Tavor-mode HCAs.  We don't really need the conditional test there
either; we can similarly always link to the previous WQE.

Based on Michael S. Tsirkin's analogous fix for userspace libmthca.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_qp.c  |   48 ++++++++++++++-----------------
 drivers/infiniband/hw/mthca/mthca_srq.c |   14 ++++-----
 2 files changed, 28 insertions(+), 34 deletions(-)

bfb454be124d30e9bd140d9c6ef6aec549f4d293
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -227,7 +227,6 @@ static void mthca_wq_init(struct mthca_w
 	wq->last_comp = wq->max - 1;
 	wq->head      = 0;
 	wq->tail      = 0;
-	wq->last      = NULL;
 }
 
 void mthca_qp_event(struct mthca_dev *dev, u32 qpn,
@@ -1103,6 +1102,9 @@ static int mthca_alloc_qp_common(struct 
 		}
 	}
 
+	qp->sq.last = get_send_wqe(qp, qp->sq.max - 1);
+	qp->rq.last = get_recv_wqe(qp, qp->rq.max - 1);
+
 	return 0;
 }
 
@@ -1583,15 +1585,13 @@ int mthca_tavor_post_send(struct ib_qp *
 			goto out;
 		}
 
-		if (prev_wqe) {
-			((struct mthca_next_seg *) prev_wqe)->nda_op =
-				cpu_to_be32(((ind << qp->sq.wqe_shift) +
-					     qp->send_wqe_offset) |
-					    mthca_opcode[wr->opcode]);
-			wmb();
-			((struct mthca_next_seg *) prev_wqe)->ee_nds =
-				cpu_to_be32((size0 ? 0 : MTHCA_NEXT_DBD) | size);
-		}
+		((struct mthca_next_seg *) prev_wqe)->nda_op =
+			cpu_to_be32(((ind << qp->sq.wqe_shift) +
+				     qp->send_wqe_offset) |
+				    mthca_opcode[wr->opcode]);
+		wmb();
+		((struct mthca_next_seg *) prev_wqe)->ee_nds =
+			cpu_to_be32((size0 ? 0 : MTHCA_NEXT_DBD) | size);
 
 		if (!size0) {
 			size0 = size;
@@ -1688,13 +1688,11 @@ int mthca_tavor_post_receive(struct ib_q
 
 		qp->wrid[ind] = wr->wr_id;
 
-		if (likely(prev_wqe)) {
-			((struct mthca_next_seg *) prev_wqe)->nda_op =
-				cpu_to_be32((ind << qp->rq.wqe_shift) | 1);
-			wmb();
-			((struct mthca_next_seg *) prev_wqe)->ee_nds =
-				cpu_to_be32(MTHCA_NEXT_DBD | size);
-		}
+		((struct mthca_next_seg *) prev_wqe)->nda_op =
+			cpu_to_be32((ind << qp->rq.wqe_shift) | 1);
+		wmb();
+		((struct mthca_next_seg *) prev_wqe)->ee_nds =
+			cpu_to_be32(MTHCA_NEXT_DBD | size);
 
 		if (!size0)
 			size0 = size;
@@ -1905,15 +1903,13 @@ int mthca_arbel_post_send(struct ib_qp *
 			goto out;
 		}
 
-		if (likely(prev_wqe)) {
-			((struct mthca_next_seg *) prev_wqe)->nda_op =
-				cpu_to_be32(((ind << qp->sq.wqe_shift) +
-					     qp->send_wqe_offset) |
-					    mthca_opcode[wr->opcode]);
-			wmb();
-			((struct mthca_next_seg *) prev_wqe)->ee_nds =
-				cpu_to_be32(MTHCA_NEXT_DBD | size);
-		}
+		((struct mthca_next_seg *) prev_wqe)->nda_op =
+			cpu_to_be32(((ind << qp->sq.wqe_shift) +
+				     qp->send_wqe_offset) |
+				    mthca_opcode[wr->opcode]);
+		wmb();
+		((struct mthca_next_seg *) prev_wqe)->ee_nds =
+			cpu_to_be32(MTHCA_NEXT_DBD | size);
 
 		if (!size0) {
 			size0 = size;
diff --git a/drivers/infiniband/hw/mthca/mthca_srq.c b/drivers/infiniband/hw/mthca/mthca_srq.c
--- a/drivers/infiniband/hw/mthca/mthca_srq.c
+++ b/drivers/infiniband/hw/mthca/mthca_srq.c
@@ -189,7 +189,6 @@ int mthca_alloc_srq(struct mthca_dev *de
 
 	srq->max      = attr->max_wr;
 	srq->max_gs   = attr->max_sge;
-	srq->last     = NULL;
 	srq->counter  = 0;
 
 	if (mthca_is_memfree(dev))
@@ -264,6 +263,7 @@ int mthca_alloc_srq(struct mthca_dev *de
 
 	srq->first_free = 0;
 	srq->last_free  = srq->max - 1;
+	srq->last	= get_wqe(srq, srq->max - 1);
 
 	return 0;
 
@@ -446,13 +446,11 @@ int mthca_tavor_post_srq_recv(struct ib_
 			((struct mthca_data_seg *) wqe)->addr = 0;
 		}
 
-		if (likely(prev_wqe)) {
-			((struct mthca_next_seg *) prev_wqe)->nda_op =
-				cpu_to_be32((ind << srq->wqe_shift) | 1);
-			wmb();
-			((struct mthca_next_seg *) prev_wqe)->ee_nds =
-				cpu_to_be32(MTHCA_NEXT_DBD);
-		}
+		((struct mthca_next_seg *) prev_wqe)->nda_op =
+			cpu_to_be32((ind << srq->wqe_shift) | 1);
+		wmb();
+		((struct mthca_next_seg *) prev_wqe)->ee_nds =
+			cpu_to_be32(MTHCA_NEXT_DBD);
 
 		srq->wrid[ind]  = wr->wr_id;
 		srq->first_free = next_ind;
