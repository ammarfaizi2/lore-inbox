Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262283AbVDLKrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbVDLKrw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 06:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbVDLKpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:45:50 -0400
Received: from fire.osdl.org ([65.172.181.4]:54986 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262283AbVDLKdq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:46 -0400
Message-Id: <200504121033.j3CAXYSD005914@shell0.pdx.osdl.net>
Subject: [patch 188/198] IB/mthca: update receive queue initialization for new HCAs
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:27 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roland Dreier <roland@topspin.com>

Update initialization of receive queue to match new documentation.  This
change is required to support new MT25204 HCA.

Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/hw/mthca/mthca_qp.c |   33 +++++++++++++++++--------
 1 files changed, 23 insertions(+), 10 deletions(-)

diff -puN drivers/infiniband/hw/mthca/mthca_qp.c~ib-mthca-update-receive-queue-initialization-for-new-hcas drivers/infiniband/hw/mthca/mthca_qp.c
--- 25/drivers/infiniband/hw/mthca/mthca_qp.c~ib-mthca-update-receive-queue-initialization-for-new-hcas	2005-04-12 03:21:48.220806224 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_qp.c	2005-04-12 03:21:48.225805464 -0700
@@ -181,6 +181,10 @@ enum {
 	MTHCA_MLX_SLR        = 1 << 16
 };
 
+enum {
+	MTHCA_INVAL_LKEY = 0x100
+};
+
 struct mthca_next_seg {
 	u32 nda_op;		/* [31:6] next WQE [4:0] next opcode */
 	u32 ee_nds;		/* [31:8] next EE  [7] DBD [6] F [5:0] next WQE size */
@@ -1093,7 +1097,6 @@ static int mthca_alloc_qp_common(struct 
 				 enum ib_sig_type send_policy,
 				 struct mthca_qp *qp)
 {
-	struct mthca_next_seg *wqe;
 	int ret;
 	int i;
 
@@ -1116,18 +1119,28 @@ static int mthca_alloc_qp_common(struct 
 	}
 
 	if (mthca_is_memfree(dev)) {
+		struct mthca_next_seg *next;
+		struct mthca_data_seg *scatter;
+		int size = (sizeof (struct mthca_next_seg) +
+			    qp->rq.max_gs * sizeof (struct mthca_data_seg)) / 16;
+
 		for (i = 0; i < qp->rq.max; ++i) {
-			wqe = get_recv_wqe(qp, i);
-			wqe->nda_op = cpu_to_be32(((i + 1) & (qp->rq.max - 1)) <<
-						  qp->rq.wqe_shift);
-			wqe->ee_nds = cpu_to_be32(1 << (qp->rq.wqe_shift - 4));
+			next = get_recv_wqe(qp, i);
+			next->nda_op = cpu_to_be32(((i + 1) & (qp->rq.max - 1)) <<
+						   qp->rq.wqe_shift);
+			next->ee_nds = cpu_to_be32(size);
+
+			for (scatter = (void *) (next + 1);
+			     (void *) scatter < (void *) next + (1 << qp->rq.wqe_shift);
+			     ++scatter)
+				scatter->lkey = cpu_to_be32(MTHCA_INVAL_LKEY);
 		}
 
 		for (i = 0; i < qp->sq.max; ++i) {
-			wqe = get_send_wqe(qp, i);
-			wqe->nda_op = cpu_to_be32((((i + 1) & (qp->sq.max - 1)) <<
-						   qp->sq.wqe_shift) +
-						  qp->send_wqe_offset);
+			next = get_send_wqe(qp, i);
+			next->nda_op = cpu_to_be32((((i + 1) & (qp->sq.max - 1)) <<
+						    qp->sq.wqe_shift) +
+						   qp->send_wqe_offset);
 		}
 	}
 
@@ -1986,7 +1999,7 @@ int mthca_arbel_post_receive(struct ib_q
 
 		if (i < qp->rq.max_gs) {
 			((struct mthca_data_seg *) wqe)->byte_count = 0;
-			((struct mthca_data_seg *) wqe)->lkey = cpu_to_be32(0x100);
+			((struct mthca_data_seg *) wqe)->lkey = cpu_to_be32(MTHCA_INVAL_LKEY);
 			((struct mthca_data_seg *) wqe)->addr = 0;
 		}
 
_
