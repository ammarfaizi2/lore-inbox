Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVAXGW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVAXGW4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 01:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVAXGWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 01:22:33 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:19986 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261456AbVAXGO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 01:14:29 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][7/12] InfiniBand/mthca: optimize event queue handling
In-Reply-To: <20051232214.2ZjgnbDloKBl5KUG@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Sun, 23 Jan 2005 22:14:24 -0800
Message-Id: <20051232214.JlqWjfrLoi3PpTCk@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 24 Jan 2005 06:14:25.0309 (UTC) FILETIME=[F400DCD0:01C501DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@mellanox.co.il>

Event queue handling performance improvements:
 - Only calculate EQ entry address once, and don't truncate the
   consumer index until we really need to.
 - Only read ECR once.  If a new event occurs while we're in the
   interrupt handler, we'll get another interrupt anyway, since we
   only clear events once.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_provider.h	2005-01-23 08:30:27.000000000 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_provider.h	2005-01-23 20:51:23.739805744 -0800
@@ -66,11 +66,11 @@
 	struct mthca_dev      *dev;
 	int                    eqn;
 	u32                    ecr_mask;
+	u32                    cons_index;
 	u16                    msi_x_vector;
 	u16                    msi_x_entry;
 	int                    have_irq;
 	int                    nent;
-	int                    cons_index;
 	struct mthca_buf_list *page_list;
 	struct mthca_mr        mr;
 };
--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_eq.c	2005-01-23 20:47:40.946675448 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_eq.c	2005-01-23 20:51:23.740805592 -0800
@@ -164,12 +164,12 @@
 		MTHCA_ASYNC_EVENT_MASK;
 }
 
-static inline void set_eq_ci(struct mthca_dev *dev, int eqn, int ci)
+static inline void set_eq_ci(struct mthca_dev *dev, struct mthca_eq *eq, u32 ci)
 {
 	u32 doorbell[2];
 
-	doorbell[0] = cpu_to_be32(MTHCA_EQ_DB_SET_CI | eqn);
-	doorbell[1] = cpu_to_be32(ci);
+	doorbell[0] = cpu_to_be32(MTHCA_EQ_DB_SET_CI | eq->eqn);
+	doorbell[1] = cpu_to_be32(ci & (eq->nent - 1));
 
 	mthca_write64(doorbell,
 		      dev->kar + MTHCA_EQ_DOORBELL,
@@ -200,21 +200,22 @@
 		      MTHCA_GET_DOORBELL_LOCK(&dev->doorbell_lock));
 }
 
-static inline struct mthca_eqe *get_eqe(struct mthca_eq *eq, int entry)
+static inline struct mthca_eqe *get_eqe(struct mthca_eq *eq, u32 entry)
 {
-	return eq->page_list[entry * MTHCA_EQ_ENTRY_SIZE / PAGE_SIZE].buf
-		+ (entry * MTHCA_EQ_ENTRY_SIZE) % PAGE_SIZE;
+	unsigned long off = (entry & (eq->nent - 1)) * MTHCA_EQ_ENTRY_SIZE;
+	return eq->page_list[off / PAGE_SIZE].buf + off % PAGE_SIZE;
 }
 
-static inline int next_eqe_sw(struct mthca_eq *eq)
+static inline struct mthca_eqe* next_eqe_sw(struct mthca_eq *eq)
 {
-	return !(MTHCA_EQ_ENTRY_OWNER_HW &
-		 get_eqe(eq, eq->cons_index)->owner);
+	struct mthca_eqe* eqe;
+	eqe = get_eqe(eq, eq->cons_index);
+	return (MTHCA_EQ_ENTRY_OWNER_HW & eqe->owner) ? NULL : eqe;
 }
 
-static inline void set_eqe_hw(struct mthca_eq *eq, int entry)
+static inline void set_eqe_hw(struct mthca_eqe *eqe)
 {
-	get_eqe(eq, entry)->owner =  MTHCA_EQ_ENTRY_OWNER_HW;
+	eqe->owner =  MTHCA_EQ_ENTRY_OWNER_HW;
 }
 
 static void port_change(struct mthca_dev *dev, int port, int active)
@@ -235,10 +236,10 @@
 {
 	struct mthca_eqe *eqe;
 	int disarm_cqn;
+	int  eqes_found = 0;
 
-	while (next_eqe_sw(eq)) {
+	while ((eqe = next_eqe_sw(eq))) {
 		int set_ci = 0;
-		eqe = get_eqe(eq, eq->cons_index);
 
 		/*
 		 * Make sure we read EQ entry contents after we've
@@ -328,12 +329,13 @@
 			break;
 		};
 
-		set_eqe_hw(eq, eq->cons_index);
-		eq->cons_index = (eq->cons_index + 1) & (eq->nent - 1);
+		set_eqe_hw(eqe);
+		++eq->cons_index;
+		eqes_found = 1;
 
 		if (set_ci) {
 			wmb(); /* see comment below */
-			set_eq_ci(dev, eq->eqn, eq->cons_index);
+			set_eq_ci(dev, eq, eq->cons_index);
 			set_ci = 0;
 		}
 	}
@@ -347,8 +349,10 @@
 	 * possibility of the HCA writing an entry and then
 	 * having set_eqe_hw() overwrite the owner field.
 	 */
-	wmb();
-	set_eq_ci(dev, eq->eqn, eq->cons_index);
+	if (likely(eqes_found)) {
+		wmb();
+		set_eq_ci(dev, eq, eq->cons_index);
+	}
 	eq_req_not(dev, eq->eqn);
 }
 
@@ -362,7 +366,7 @@
 	if (dev->eq_table.clr_mask)
 		writel(dev->eq_table.clr_mask, dev->eq_table.clr_int);
 
-	while ((ecr = readl(dev->hcr + MTHCA_ECR_OFFSET + 4)) != 0) {
+	if ((ecr = readl(dev->hcr + MTHCA_ECR_OFFSET + 4)) != 0) {
 		work = 1;
 
 		writel(ecr, dev->hcr + MTHCA_ECR_CLR_OFFSET + 4);
@@ -440,7 +444,7 @@
 	}
 
 	for (i = 0; i < nent; ++i)
-		set_eqe_hw(eq, i);
+		set_eqe_hw(get_eqe(eq, i));
 
 	eq->eqn = mthca_alloc(&dev->eq_table.alloc);
 	if (eq->eqn == -1)

