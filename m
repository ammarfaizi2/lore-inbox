Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262792AbVCDAAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbVCDAAU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbVCCX5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 18:57:35 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:56054 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262732AbVCCXWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:22:13 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][8/26] IB/mthca: add UAR allocation
In-Reply-To: <2005331520.q2c4004P8DuwgJEx@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 3 Mar 2005 15:20:27 -0800
Message-Id: <2005331520.qwFp6OBqldRd6oo8@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 23:20:27.0441 (UTC) FILETIME=[95973A10:01C52047]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for allocating user access regions (UARs).  Use this to
allocate a region for kernel at driver init instead using hard-coded
MTHCA_KAR_PAGE index.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/Makefile	2005-01-15 15:16:40.000000000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/Makefile	2005-03-03 14:12:56.155732030 -0800
@@ -9,4 +9,4 @@
 ib_mthca-y :=	mthca_main.o mthca_cmd.o mthca_profile.o mthca_reset.o \
 		mthca_allocator.o mthca_eq.o mthca_pd.o mthca_cq.o \
 		mthca_mr.o mthca_qp.o mthca_av.o mthca_mcg.o mthca_mad.o \
-		mthca_provider.o mthca_memfree.o
+		mthca_provider.o mthca_memfree.o mthca_uar.o
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_cq.c	2005-03-03 14:12:53.538300187 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_cq.c	2005-03-03 14:12:56.153732464 -0800
@@ -666,7 +666,7 @@
 						  MTHCA_CQ_FLAG_TR);
 	cq_context->start           = cpu_to_be64(0);
 	cq_context->logsize_usrpage = cpu_to_be32((ffs(nent) - 1) << 24 |
-						  MTHCA_KAR_PAGE);
+						  dev->driver_uar.index);
 	cq_context->error_eqn       = cpu_to_be32(dev->eq_table.eq[MTHCA_EQ_ASYNC].eqn);
 	cq_context->comp_eqn        = cpu_to_be32(dev->eq_table.eq[MTHCA_EQ_COMP].eqn);
 	cq_context->pd              = cpu_to_be32(dev->driver_pd.pd_num);
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_dev.h	2005-03-03 14:12:55.515870922 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_dev.h	2005-03-03 14:12:56.152732681 -0800
@@ -65,7 +65,6 @@
 };
 
 enum {
-	MTHCA_KAR_PAGE  = 1,
 	MTHCA_MAX_PORTS = 2
 };
 
@@ -108,6 +107,7 @@
 	int      gid_table_len;
 	int      pkey_table_len;
 	int      local_ca_ack_delay;
+	int      num_uars;
 	int      max_sg;
 	int      num_qps;
 	int      reserved_qps;
@@ -148,6 +148,12 @@
 	} *page_list;
 };
 
+struct mthca_uar_table {
+	struct mthca_alloc alloc;
+	u64                uarc_base;
+	int                uarc_size;
+};
+
 struct mthca_pd_table {
 	struct mthca_alloc alloc;
 };
@@ -252,6 +258,7 @@
 	struct mthca_cmd    cmd;
 	struct mthca_limits limits;
 
+	struct mthca_uar_table uar_table;
 	struct mthca_pd_table  pd_table;
 	struct mthca_mr_table  mr_table;
 	struct mthca_eq_table  eq_table;
@@ -260,6 +267,7 @@
 	struct mthca_av_table  av_table;
 	struct mthca_mcg_table mcg_table;
 
+	struct mthca_uar      driver_uar;
 	struct mthca_pd       driver_pd;
 	struct mthca_mr       driver_mr;
 
@@ -318,6 +326,7 @@
 int mthca_array_init(struct mthca_array *array, int nent);
 void mthca_array_cleanup(struct mthca_array *array, int nent);
 
+int mthca_init_uar_table(struct mthca_dev *dev);
 int mthca_init_pd_table(struct mthca_dev *dev);
 int mthca_init_mr_table(struct mthca_dev *dev);
 int mthca_init_eq_table(struct mthca_dev *dev);
@@ -326,6 +335,7 @@
 int mthca_init_av_table(struct mthca_dev *dev);
 int mthca_init_mcg_table(struct mthca_dev *dev);
 
+void mthca_cleanup_uar_table(struct mthca_dev *dev);
 void mthca_cleanup_pd_table(struct mthca_dev *dev);
 void mthca_cleanup_mr_table(struct mthca_dev *dev);
 void mthca_cleanup_eq_table(struct mthca_dev *dev);
@@ -337,6 +347,9 @@
 int mthca_register_device(struct mthca_dev *dev);
 void mthca_unregister_device(struct mthca_dev *dev);
 
+int mthca_uar_alloc(struct mthca_dev *dev, struct mthca_uar *uar);
+void mthca_uar_free(struct mthca_dev *dev, struct mthca_uar *uar);
+
 int mthca_pd_alloc(struct mthca_dev *dev, struct mthca_pd *pd);
 void mthca_pd_free(struct mthca_dev *dev, struct mthca_pd *pd);
 
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_eq.c	2005-03-03 14:12:55.516870705 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_eq.c	2005-03-03 14:12:56.154732247 -0800
@@ -469,7 +469,7 @@
 						  MTHCA_EQ_FLAG_TR);
 	eq_context->start           = cpu_to_be64(0);
 	eq_context->logsize_usrpage = cpu_to_be32((ffs(nent) - 1) << 24 |
-						  MTHCA_KAR_PAGE);
+						  dev->driver_uar.index);
 	eq_context->pd              = cpu_to_be32(dev->driver_pd.pd_num);
 	eq_context->intr            = intr;
 	eq_context->lkey            = cpu_to_be32(eq->mr.ibmr.lkey);
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_main.c	2005-03-03 14:12:55.516870705 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_main.c	2005-03-03 14:12:56.152732681 -0800
@@ -570,13 +570,35 @@
 
 	MTHCA_INIT_DOORBELL_LOCK(&dev->doorbell_lock);
 
-	err = mthca_init_pd_table(dev);
+	err = mthca_init_uar_table(dev);
 	if (err) {
 		mthca_err(dev, "Failed to initialize "
-			  "protection domain table, aborting.\n");
+			  "user access region table, aborting.\n");
 		return err;
 	}
 
+	err = mthca_uar_alloc(dev, &dev->driver_uar);
+	if (err) {
+		mthca_err(dev, "Failed to allocate driver access region, "
+			  "aborting.\n");
+		goto err_uar_table_free;
+	}
+
+	dev->kar = ioremap(dev->driver_uar.pfn << PAGE_SHIFT, PAGE_SIZE);
+	if (!dev->kar) {
+		mthca_err(dev, "Couldn't map kernel access region, "
+			  "aborting.\n");
+		err = -ENOMEM;
+		goto err_uar_free;
+	}
+
+       err = mthca_init_pd_table(dev);
+	if (err) {
+		mthca_err(dev, "Failed to initialize "
+			  "protection domain table, aborting.\n");
+		goto err_kar_unmap;
+	}
+
 	err = mthca_init_mr_table(dev);
 	if (err) {
 		mthca_err(dev, "Failed to initialize "
@@ -677,7 +699,16 @@
 
 err_pd_table_free:
 	mthca_cleanup_pd_table(dev);
-	return err;
+
+err_kar_unmap:
+	iounmap(dev->kar);
+
+err_uar_free:
+	mthca_uar_free(dev, &dev->driver_uar);
+
+err_uar_table_free:
+	mthca_cleanup_uar_table(dev);
+       return err;
 }
 
 static int __devinit mthca_request_regions(struct pci_dev *pdev,
@@ -789,7 +820,6 @@
 	static int mthca_version_printed = 0;
 	int ddr_hidden = 0;
 	int err;
-	unsigned long mthca_base;
 	struct mthca_dev *mdev;
 
 	if (!mthca_version_printed) {
@@ -891,8 +921,7 @@
 	sema_init(&mdev->cmd.poll_sem, 1);
 	mdev->cmd.use_events = 0;
 
-	mthca_base = pci_resource_start(pdev, 0);
-	mdev->hcr = ioremap(mthca_base + MTHCA_HCR_BASE, MTHCA_HCR_SIZE);
+	mdev->hcr = ioremap(pci_resource_start(pdev, 0) + MTHCA_HCR_BASE, MTHCA_HCR_SIZE);
 	if (!mdev->hcr) {
 		mthca_err(mdev, "Couldn't map command register, "
 			  "aborting.\n");
@@ -900,22 +929,13 @@
 		goto err_free_dev;
 	}
 
-	mthca_base = pci_resource_start(pdev, 2);
-	mdev->kar = ioremap(mthca_base + PAGE_SIZE * MTHCA_KAR_PAGE, PAGE_SIZE);
-	if (!mdev->kar) {
-		mthca_err(mdev, "Couldn't map kernel access region, "
-			  "aborting.\n");
-		err = -ENOMEM;
-		goto err_iounmap;
-	}
-
 	err = mthca_tune_pci(mdev);
 	if (err)
-		goto err_iounmap_kar;
+		goto err_iounmap;
 
 	err = mthca_init_hca(mdev);
 	if (err)
-		goto err_iounmap_kar;
+		goto err_iounmap;
 
 	err = mthca_setup_hca(mdev);
 	if (err)
@@ -948,13 +968,11 @@
 
 	mthca_cleanup_mr_table(mdev);
 	mthca_cleanup_pd_table(mdev);
+	mthca_cleanup_uar_table(mdev);
 
 err_close:
 	mthca_close_hca(mdev);
 
-err_iounmap_kar:
-	iounmap(mdev->kar);
-
 err_iounmap:
 	iounmap(mdev->hcr);
 
@@ -1000,9 +1018,12 @@
 		mthca_cleanup_mr_table(mdev);
 		mthca_cleanup_pd_table(mdev);
 
+		iounmap(mdev->kar);
+		mthca_uar_free(mdev, &mdev->driver_uar);
+		mthca_cleanup_uar_table(mdev);
+
 		mthca_close_hca(mdev);
 
-		iounmap(mdev->kar);
 		iounmap(mdev->hcr);
 
 		if (mdev->mthca_flags & MTHCA_FLAG_MSI_X)
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_profile.c	2005-03-02 20:53:21.000000000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_profile.c	2005-03-03 14:12:56.153732464 -0800
@@ -236,6 +236,7 @@
 			init_hca->mtt_seg_sz     = ffs(dev_lim->mtt_seg_sz) - 7;
 			break;
 		case MTHCA_RES_UAR:
+			dev->limits.num_uars       = profile[i].num;
 			init_hca->uar_scratch_base = profile[i].start;
 			break;
 		case MTHCA_RES_UDAV:
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_provider.h	2005-03-03 14:12:54.674053653 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_provider.h	2005-03-03 14:12:56.153732464 -0800
@@ -49,6 +49,11 @@
 	DECLARE_PCI_UNMAP_ADDR(mapping)
 };
 
+struct mthca_uar {
+	unsigned long pfn;
+	int           index;
+};
+
 struct mthca_mr {
 	struct ib_mr ibmr;
 	int order;
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_qp.c	2005-03-03 14:12:54.675053436 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_qp.c	2005-03-03 14:12:56.155732030 -0800
@@ -625,7 +625,7 @@
 		qp_context->mtu_msgmax = cpu_to_be32((attr->path_mtu << 29) |
 						     (31 << 24));
 	}
-	qp_context->usr_page   = cpu_to_be32(MTHCA_KAR_PAGE);
+	qp_context->usr_page   = cpu_to_be32(dev->driver_uar.index);
 	qp_context->local_qpn  = cpu_to_be32(qp->qpn);
 	if (attr_mask & IB_QP_DEST_QPN) {
 		qp_context->remote_qpn = cpu_to_be32(attr->dest_qp_num);
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-export/drivers/infiniband/hw/mthca/mthca_uar.c	2005-03-03 14:12:56.152732681 -0800
@@ -0,0 +1,69 @@
+/*
+ * Copyright (c) 2005 Topspin Communications.  All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * $Id$
+ */
+
+#include "mthca_dev.h"
+
+int mthca_uar_alloc(struct mthca_dev *dev, struct mthca_uar *uar)
+{
+	uar->index = mthca_alloc(&dev->uar_table.alloc);
+	if (uar->index == -1)
+		return -ENOMEM;
+
+	uar->pfn = (pci_resource_start(dev->pdev, 2) >> PAGE_SHIFT) + uar->index;
+
+	return 0;
+}
+
+void mthca_uar_free(struct mthca_dev *dev, struct mthca_uar *uar)
+{
+	mthca_free(&dev->uar_table.alloc, uar->index);
+}
+
+int mthca_init_uar_table(struct mthca_dev *dev)
+{
+	int ret;
+
+	ret = mthca_alloc_init(&dev->uar_table.alloc,
+			       dev->limits.num_uars,
+			       dev->limits.num_uars - 1,
+			       dev->limits.reserved_uars);
+
+	return ret;
+}
+
+void mthca_cleanup_uar_table(struct mthca_dev *dev)
+{
+	/* XXX check if any UARs are still allocated? */
+	mthca_alloc_cleanup(&dev->uar_table.alloc);
+}

