Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263084AbVFXEIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbVFXEIL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 00:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbVFXEFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 00:05:00 -0400
Received: from webmail.topspin.com ([12.162.17.3]:33605 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S263087AbVFXEEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 00:04:21 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 03/14] IB/mthca: Clean up CQ debug
In-Reply-To: <2005623214.mXu9RTJT2MIk7KOo@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 23 Jun 2005 21:04:20 -0700
Message-Id: <2005623214.Zy3c64TeILEv3G5E@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 24 Jun 2005 04:04:20.0667 (UTC) FILETIME=[CC7340B0:01C57871]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up CQ debugging code: make dump_cqe print on one line, and only
dump error CQ entries for local operation errors.

Signed-off-by: Roland Dreier <roland@topspin.com>

---

 linux.git/drivers/infiniband/hw/mthca/mthca_cq.c |   39 +++++++++++++++------------------
 1 files changed, 18 insertions(+), 21 deletions(-)



--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_cq.c	2005-06-23 13:03:02.629547920 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_cq.c	2005-06-23 13:03:04.326180727 -0700
@@ -172,6 +172,17 @@ static inline void set_cqe_hw(struct mth
 	cqe->owner = MTHCA_CQ_ENTRY_OWNER_HW;
 }
 
+static void dump_cqe(struct mthca_dev *dev, void *cqe_ptr)
+{
+	__be32 *cqe = cqe_ptr;
+
+	(void) cqe;	/* avoid warning if mthca_dbg compiled away... */
+	mthca_dbg(dev, "CQE contents %08x %08x %08x %08x %08x %08x %08x %08x\n",
+		  be32_to_cpu(cqe[0]), be32_to_cpu(cqe[1]), be32_to_cpu(cqe[2]), 
+		  be32_to_cpu(cqe[3]), be32_to_cpu(cqe[4]), be32_to_cpu(cqe[5]), 
+		  be32_to_cpu(cqe[6]), be32_to_cpu(cqe[7]));
+}
+
 /*
  * incr is ignored in native Arbel (mem-free) mode, so cq->cons_index
  * should be correct before calling update_cons_index().
@@ -281,16 +292,12 @@ static int handle_error_cqe(struct mthca
 	int dbd;
 	u32 new_wqe;
 
-	if (1 && cqe->syndrome != SYNDROME_WR_FLUSH_ERR) {
-		int j;
-
-		mthca_dbg(dev, "%x/%d: error CQE -> QPN %06x, WQE @ %08x\n",
-			  cq->cqn, cq->cons_index, be32_to_cpu(cqe->my_qpn),
-			  be32_to_cpu(cqe->wqe));
-
-		for (j = 0; j < 8; ++j)
-			printk(KERN_DEBUG "  [%2x] %08x\n",
-			       j * 4, be32_to_cpu(((u32 *) cqe)[j]));
+	if (cqe->syndrome == SYNDROME_LOCAL_QP_OP_ERR) {
+		mthca_dbg(dev, "local QP operation err "
+			  "(QPN %06x, WQE @ %08x, CQN %06x, index %d)\n",
+			  be32_to_cpu(cqe->my_qpn), be32_to_cpu(cqe->wqe),
+			  cq->cqn, cq->cons_index);
+		dump_cqe(dev, cqe);
 	}
 
 	/*
@@ -378,15 +385,6 @@ static int handle_error_cqe(struct mthca
 	return 0;
 }
 
-static void dump_cqe(struct mthca_cqe *cqe)
-{
-	int j;
-
-	for (j = 0; j < 8; ++j)
-		printk(KERN_DEBUG "  [%2x] %08x\n",
-		       j * 4, be32_to_cpu(((u32 *) cqe)[j]));
-}
-
 static inline int mthca_poll_one(struct mthca_dev *dev,
 				 struct mthca_cq *cq,
 				 struct mthca_qp **cur_qp,
@@ -415,8 +413,7 @@ static inline int mthca_poll_one(struct 
 		mthca_dbg(dev, "%x/%d: CQE -> QPN %06x, WQE @ %08x\n",
 			  cq->cqn, cq->cons_index, be32_to_cpu(cqe->my_qpn),
 			  be32_to_cpu(cqe->wqe));
-
-		dump_cqe(cqe);
+		dump_cqe(dev, cqe);
 	}
 
 	is_error = (cqe->opcode & MTHCA_ERROR_CQE_OPCODE_MASK) ==

