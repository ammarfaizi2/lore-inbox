Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262679AbVCCXap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbVCCXap (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 18:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVCCXaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 18:30:07 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:56054 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262749AbVCCXWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:22:34 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][23/26] IB/mthca: mem-free multicast table
In-Reply-To: <2005331520.ADYAIRdSQBiHhYiD@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 3 Mar 2005 15:20:28 -0800
Message-Id: <2005331520.kVkmRDQ3e4IStEy9@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 23:20:28.0488 (UTC) FILETIME=[9636FC80:01C52047]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tie up one last loose end by mapping enough context memory to cover
the whole multicast table during initialization, and then enable
mem-free mode.  mthca now supports enough of mem-free mode so that
IPoIB works with a mem-free HCA.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_dev.h	2005-03-03 14:13:02.565340719 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_dev.h	2005-03-03 14:13:03.005245231 -0800
@@ -207,8 +207,9 @@
 };
 
 struct mthca_mcg_table {
-	struct semaphore   sem;
-	struct mthca_alloc alloc;
+	struct semaphore   	sem;
+	struct mthca_alloc 	alloc;
+	struct mthca_icm_table *table;
 };
 
 struct mthca_dev {
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_main.c	2005-03-03 14:12:57.858362446 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_main.c	2005-03-03 14:13:03.005245231 -0800
@@ -412,8 +412,29 @@
 		goto err_unmap_eqp;
 	}
 
+	/*
+	 * It's not strictly required, but for simplicity just map the
+	 * whole multicast group table now.  The table isn't very big
+	 * and it's a lot easier than trying to track ref counts.
+	 */
+	mdev->mcg_table.table = mthca_alloc_icm_table(mdev, init_hca->mc_base,
+						      MTHCA_MGM_ENTRY_SIZE,
+						      mdev->limits.num_mgms +
+						      mdev->limits.num_amgms,
+						      mdev->limits.num_mgms +
+						      mdev->limits.num_amgms,
+						      0);
+	if (!mdev->mcg_table.table) {
+		mthca_err(mdev, "Failed to map MCG context memory, aborting.\n");
+		err = -ENOMEM;
+		goto err_unmap_cq;
+	}
+
 	return 0;
 
+err_unmap_cq:
+	mthca_free_icm_table(mdev, mdev->cq_table.table);
+
 err_unmap_eqp:
 	mthca_free_icm_table(mdev, mdev->qp_table.eqp_table);
 
@@ -587,7 +608,7 @@
 		goto err_uar_free;
 	}
 
-       err = mthca_init_pd_table(dev);
+	err = mthca_init_pd_table(dev);
 	if (err) {
 		mthca_err(dev, "Failed to initialize "
 			  "protection domain table, aborting.\n");
@@ -635,13 +656,6 @@
 
 	mthca_dbg(dev, "NOP command IRQ test passed\n");
 
-	if (dev->hca_type == ARBEL_NATIVE) {
-		mthca_warn(dev, "Sorry, native MT25208 mode support is not complete, "
-			   "aborting.\n");
-		err = -ENODEV;
-		goto err_cmd_poll;
-	}
-
 	err = mthca_init_cq_table(dev);
 	if (err) {
 		mthca_err(dev, "Failed to initialize "
@@ -704,7 +718,7 @@
 
 err_uar_table_free:
 	mthca_cleanup_uar_table(dev);
-       return err;
+	return err;
 }
 
 static int __devinit mthca_request_regions(struct pci_dev *pdev,
@@ -814,6 +828,7 @@
 				    const struct pci_device_id *id)
 {
 	static int mthca_version_printed = 0;
+	static int mthca_memfree_warned = 0;
 	int ddr_hidden = 0;
 	int err;
 	struct mthca_dev *mdev;
@@ -893,6 +908,10 @@
 	mdev->pdev     = pdev;
 	mdev->hca_type = id->driver_data;
 
+	if (mdev->hca_type == ARBEL_NATIVE && !mthca_memfree_warned++)
+		mthca_warn(mdev, "Warning: native MT25208 mode support is incomplete.  "
+			   "Your HCA may not work properly.\n");
+
 	if (ddr_hidden)
 		mdev->mthca_flags |= MTHCA_FLAG_DDR_HIDDEN;
 

