Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262758AbVCCXpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbVCCXpk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 18:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbVCCXou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 18:44:50 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:53494 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262741AbVCCXW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:22:26 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][18/26] IB/mthca: mem-free CQ initialization
In-Reply-To: <2005331520.tIEkOrHOmFDGvQZK@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 3 Mar 2005 15:20:28 -0800
Message-Id: <2005331520.xvxJqi7Nfv5UdZpQ@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 23:20:28.0144 (UTC) FILETIME=[96027F00:01C52047]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update CQ initialization and cleanup to handle mem-free mode: we need
to make sure the HCA has memory mapped for the entry in the CQ context
table we will use and also allocate doorbell records.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_cq.c	2005-03-03 14:12:59.925913650 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_cq.c	2005-03-03 14:13:00.312829664 -0800
@@ -39,6 +39,7 @@
 
 #include "mthca_dev.h"
 #include "mthca_cmd.h"
+#include "mthca_memfree.h"
 
 enum {
 	MTHCA_MAX_DIRECT_CQ_SIZE = 4 * PAGE_SIZE
@@ -55,7 +56,7 @@
 	u32 flags;
 	u64 start;
 	u32 logsize_usrpage;
-	u32 error_eqn;
+	u32 error_eqn;		/* Tavor only */
 	u32 comp_eqn;
 	u32 pd;
 	u32 lkey;
@@ -64,7 +65,9 @@
 	u32 consumer_index;
 	u32 producer_index;
 	u32 cqn;
-	u32 reserved[3];
+	u32 ci_db;		/* Arbel only */
+	u32 state_db;		/* Arbel only */
+	u32 reserved;
 } __attribute__((packed));
 
 #define MTHCA_CQ_STATUS_OK          ( 0 << 28)
@@ -685,10 +688,30 @@
 	if (cq->cqn == -1)
 		return -ENOMEM;
 
+	if (dev->hca_type == ARBEL_NATIVE) {
+		cq->arm_sn = 1;
+
+		err = mthca_table_get(dev, dev->cq_table.table, cq->cqn);
+		if (err)
+			goto err_out;
+
+		err = -ENOMEM;
+
+		cq->set_ci_db_index = mthca_alloc_db(dev, MTHCA_DB_TYPE_CQ_SET_CI,
+						     cq->cqn, &cq->set_ci_db);
+		if (cq->set_ci_db_index < 0)
+			goto err_out_icm;
+
+		cq->arm_db_index = mthca_alloc_db(dev, MTHCA_DB_TYPE_CQ_ARM,
+						  cq->cqn, &cq->arm_db);
+		if (cq->arm_db_index < 0)
+			goto err_out_ci;
+	}
+
 	mailbox = kmalloc(sizeof (struct mthca_cq_context) + MTHCA_CMD_MAILBOX_EXTRA,
 			  GFP_KERNEL);
 	if (!mailbox)
-		goto err_out;
+		goto err_out_mailbox;
 
 	cq_context = MAILBOX_ALIGN(mailbox);
 
@@ -716,6 +739,11 @@
 	cq_context->lkey            = cpu_to_be32(cq->mr.ibmr.lkey);
 	cq_context->cqn             = cpu_to_be32(cq->cqn);
 
+	if (dev->hca_type == ARBEL_NATIVE) {
+		cq_context->ci_db    = cpu_to_be32(cq->set_ci_db_index);
+		cq_context->state_db = cpu_to_be32(cq->arm_db_index);
+	}
+
 	err = mthca_SW2HW_CQ(dev, cq_context, cq->cqn, &status);
 	if (err) {
 		mthca_warn(dev, "SW2HW_CQ failed (%d)\n", err);
@@ -751,6 +779,14 @@
 err_out_mailbox:
 	kfree(mailbox);
 
+	mthca_free_db(dev, MTHCA_DB_TYPE_CQ_ARM, cq->arm_db_index);
+
+err_out_ci:
+	mthca_free_db(dev, MTHCA_DB_TYPE_CQ_SET_CI, cq->set_ci_db_index);
+
+err_out_icm:
+	mthca_table_put(dev, dev->cq_table.table, cq->cqn);
+
 err_out:
 	mthca_free(&dev->cq_table.alloc, cq->cqn);
 
@@ -806,6 +842,12 @@
 	mthca_free_mr(dev, &cq->mr);
 	mthca_free_cq_buf(dev, cq);
 
+	if (dev->hca_type == ARBEL_NATIVE) {
+		mthca_free_db(dev, MTHCA_DB_TYPE_CQ_ARM,    cq->arm_db_index);
+		mthca_free_db(dev, MTHCA_DB_TYPE_CQ_SET_CI, cq->set_ci_db_index);
+		mthca_table_put(dev, dev->cq_table.table, cq->cqn);
+	}
+
 	mthca_free(&dev->cq_table.alloc, cq->cqn);
 	kfree(mailbox);
 }
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_provider.h	2005-03-03 14:12:57.858362446 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_provider.h	2005-03-03 14:13:00.312829664 -0800
@@ -143,6 +143,14 @@
 	int                    cqn;
 	int                    cons_index;
 	int                    is_direct;
+
+	/* Next fields are Arbel only */
+	int                    set_ci_db_index;
+	u32                   *set_ci_db;
+	int                    arm_db_index;
+	u32                   *arm_db;
+	int                    arm_sn;
+
 	union {
 		struct mthca_buf_list direct;
 		struct mthca_buf_list *page_list;

