Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262739AbVCDBoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbVCDBoh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 20:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262803AbVCDADi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:03:38 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:56054 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262729AbVCCXWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:22:05 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][5/26] IB/mthca: CQ cleanups
In-Reply-To: <2005331520.lXKA9W9JoVIrmqB8@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 3 Mar 2005 15:20:27 -0800
Message-Id: <2005331520.bkPiyqSCQe0LOju5@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 23:20:27.0238 (UTC) FILETIME=[95784060:01C52047]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify some of the code for CQ handling slightly.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_cq.c	2005-03-03 14:12:52.923433653 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_cq.c	2005-03-03 14:12:53.538300187 -0800
@@ -150,9 +150,8 @@
 
 static inline struct mthca_cqe *cqe_sw(struct mthca_cq *cq, int i)
 {
-	struct mthca_cqe *cqe;
-	cqe = get_cqe(cq, i);
-	return (MTHCA_CQ_ENTRY_OWNER_HW & cqe->owner) ? NULL : cqe;
+	struct mthca_cqe *cqe = get_cqe(cq, i);
+	return MTHCA_CQ_ENTRY_OWNER_HW & cqe->owner ? NULL : cqe;
 }
 
 static inline struct mthca_cqe *next_cqe_sw(struct mthca_cq *cq)
@@ -378,7 +377,7 @@
 	struct mthca_wq *wq;
 	struct mthca_cqe *cqe;
 	int wqe_index;
-	int is_error = 0;
+	int is_error;
 	int is_send;
 	int free_cqe = 1;
 	int err = 0;
@@ -401,12 +400,9 @@
 		dump_cqe(cqe);
 	}
 
-	if ((cqe->opcode & MTHCA_ERROR_CQE_OPCODE_MASK) ==
-	    MTHCA_ERROR_CQE_OPCODE_MASK) {
-		is_error = 1;
-		is_send = cqe->opcode & 1;
-	} else
-		is_send = cqe->is_send & 0x80;
+	is_error = (cqe->opcode & MTHCA_ERROR_CQE_OPCODE_MASK) ==
+		MTHCA_ERROR_CQE_OPCODE_MASK;
+	is_send  = is_error ? cqe->opcode & 0x01 : cqe->is_send & 0x80;
 
 	if (!*cur_qp || be32_to_cpu(cqe->my_qpn) != (*cur_qp)->qpn) {
 		if (*cur_qp) {

