Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262944AbVDAVPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262944AbVDAVPo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 16:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262929AbVDAVO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 16:14:26 -0500
Received: from webmail.topspin.com ([12.162.17.3]:35887 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262916AbVDAUv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:51:27 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][26/27] IB/mthca: update receive queue initialization for new HCAs
In-Reply-To: <2005411249.Yyk7PJUeNHG0154S@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 1 Apr 2005 12:49:54 -0800
Message-Id: <2005411249.gE8d9QQAmCCNZRp6@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 20:49:54.0638 (UTC) FILETIME=[5B999EE0:01C536FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update initialization of receive queue to match new documentation.
This change is required to support new MT25204 HCA.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_qp.c	2005-04-01 12:38:31.673085325 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_qp.c	2005-04-01 12:38:32.124987229 -0800
@@ -181,6 +181,10 @@
 	MTHCA_MLX_SLR        = 1 << 16
 };
 
+enum {
+	MTHCA_INVAL_LKEY = 0x100
+};
+
 struct mthca_next_seg {
 	u32 nda_op;		/* [31:6] next WQE [4:0] next opcode */
 	u32 ee_nds;		/* [31:8] next EE  [7] DBD [6] F [5:0] next WQE size */
@@ -1093,7 +1097,6 @@
 				 enum ib_sig_type send_policy,
 				 struct mthca_qp *qp)
 {
-	struct mthca_next_seg *wqe;
 	int ret;
 	int i;
 
@@ -1116,18 +1119,28 @@
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
 
@@ -1986,7 +1999,7 @@
 
 		if (i < qp->rq.max_gs) {
 			((struct mthca_data_seg *) wqe)->byte_count = 0;
-			((struct mthca_data_seg *) wqe)->lkey = cpu_to_be32(0x100);
+			((struct mthca_data_seg *) wqe)->lkey = cpu_to_be32(MTHCA_INVAL_LKEY);
 			((struct mthca_data_seg *) wqe)->addr = 0;
 		}
 

