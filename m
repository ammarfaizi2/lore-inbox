Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262801AbVCDBog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262801AbVCDBog (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 20:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262811AbVCDAFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:05:52 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:53494 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262725AbVCCXWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:22:02 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][2/26] IB/mthca: CQ minor tweaks
In-Reply-To: <2005331520.OFd0tTycEIjc5XlW@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 3 Mar 2005 15:20:26 -0800
Message-Id: <2005331520.GI2ijwUAkM9zyNyy@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 23:20:27.0050 (UTC) FILETIME=[955B90A0:01C52047]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@mellanox.co.il>

Clean up CQ code so that we only calculate the address of a CQ entry
once when using it.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_cq.c	2005-02-03 16:59:43.000000000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_cq.c	2005-03-03 14:12:51.832670421 -0800
@@ -147,20 +147,21 @@
 			+ (entry * MTHCA_CQ_ENTRY_SIZE) % PAGE_SIZE;
 }
 
-static inline int cqe_sw(struct mthca_cq *cq, int i)
+static inline struct mthca_cqe *cqe_sw(struct mthca_cq *cq, int i)
 {
-	return !(MTHCA_CQ_ENTRY_OWNER_HW &
-		 get_cqe(cq, i)->owner);
+	struct mthca_cqe *cqe;
+	cqe = get_cqe(cq, i);
+	return (MTHCA_CQ_ENTRY_OWNER_HW & cqe->owner) ? NULL : cqe;
 }
 
-static inline int next_cqe_sw(struct mthca_cq *cq)
+static inline struct mthca_cqe *next_cqe_sw(struct mthca_cq *cq)
 {
 	return cqe_sw(cq, cq->cons_index);
 }
 
-static inline void set_cqe_hw(struct mthca_cq *cq, int entry)
+static inline void set_cqe_hw(struct mthca_cqe *cqe)
 {
-	get_cqe(cq, entry)->owner = MTHCA_CQ_ENTRY_OWNER_HW;
+	cqe->owner = MTHCA_CQ_ENTRY_OWNER_HW;
 }
 
 static inline void inc_cons_index(struct mthca_dev *dev, struct mthca_cq *cq,
@@ -388,7 +389,8 @@
 	int free_cqe = 1;
 	int err = 0;
 
-	if (!next_cqe_sw(cq))
+	cqe = next_cqe_sw(cq);
+	if (!cqe)
 		return -EAGAIN;
 
 	/*
@@ -397,8 +399,6 @@
 	 */
 	rmb();
 
-	cqe = get_cqe(cq, cq->cons_index);
-
 	if (0) {
 		mthca_dbg(dev, "%x/%d: CQE -> QPN %06x, WQE @ %08x\n",
 			  cq->cqn, cq->cons_index, be32_to_cpu(cqe->my_qpn),
@@ -509,8 +509,8 @@
 	entry->status = IB_WC_SUCCESS;
 
  out:
-	if (free_cqe) {
-		set_cqe_hw(cq, cq->cons_index);
+	if (likely(free_cqe)) {
+		set_cqe_hw(cqe);
 		++(*freed);
 		cq->cons_index = (cq->cons_index + 1) & cq->ibcq.cqe;
 	}
@@ -655,7 +655,7 @@
 	}
 
 	for (i = 0; i < nent; ++i)
-		set_cqe_hw(cq, i);
+		set_cqe_hw(get_cqe(cq, i));
 
 	cq->cqn = mthca_alloc(&dev->cq_table.alloc);
 	if (cq->cqn == -1)
@@ -773,7 +773,7 @@
 		int j;
 
 		printk(KERN_ERR "context for CQN %x (cons index %x, next sw %d)\n",
-		       cq->cqn, cq->cons_index, next_cqe_sw(cq));
+		       cq->cqn, cq->cons_index, !!next_cqe_sw(cq));
 		for (j = 0; j < 16; ++j)
 			printk(KERN_ERR "[%2x] %08x\n", j * 4, be32_to_cpu(ctx[j]));
 	}

