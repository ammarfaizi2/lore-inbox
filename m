Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVAXG1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVAXG1d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 01:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVAXGZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 01:25:11 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:19986 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261459AbVAXGOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 01:14:30 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][11/12] InfiniBand/mthca: clean up ioremap()/request_region() usage
In-Reply-To: <20051232214.MwCsxKOebnykJtRc@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Sun, 23 Jan 2005 22:14:24 -0800
Message-Id: <20051232214.3TWW9w76vhKgw1zV@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 24 Jan 2005 06:14:25.0575 (UTC) FILETIME=[F4297370:01C501DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@mellanox.co.il>

Here are misc fixes for mthca mapping:

1. Thinkably, MSI tables or another region could fall between HCR
   and ECR tables.
   Thus its arguably wrong to map both tables in one region.
   So, do it separately.
   I think its also more readable to have ecr_base and access ecr there,
   not access ecr with hcr pointer.

2. mthca_request_regions error handling was borken
   (wrong order of cleanups). For example on all errors
   pci_release_region was called which is wrong if the region
   was not yet mapped. And other such cleanups.

3. Fixed some error messages too.

Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_eq.c	2005-01-23 20:51:23.740805592 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_eq.c	2005-01-23 20:58:55.772086392 -0800
@@ -366,10 +366,11 @@
 	if (dev->eq_table.clr_mask)
 		writel(dev->eq_table.clr_mask, dev->eq_table.clr_int);
 
-	if ((ecr = readl(dev->hcr + MTHCA_ECR_OFFSET + 4)) != 0) {
+	if ((ecr = readl(dev->ecr_base + 4)) != 0) {
 		work = 1;
 
-		writel(ecr, dev->hcr + MTHCA_ECR_CLR_OFFSET + 4);
+		writel(ecr, dev->ecr_base +
+		       MTHCA_ECR_CLR_BASE - MTHCA_ECR_BASE + 4);
 
 		for (i = 0; i < MTHCA_NUM_EQ; ++i)
 			if (ecr & dev->eq_table.eq[i].ecr_mask)
--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_main.c	2005-01-23 20:52:01.962994936 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_main.c	2005-01-23 20:58:55.771086544 -0800
@@ -699,57 +699,83 @@
 	 */
 	if (!request_mem_region(pci_resource_start(pdev, 0) +
 				MTHCA_HCR_BASE,
-				MTHCA_MAP_HCR_SIZE,
-				DRV_NAME))
-		return -EBUSY;
+				MTHCA_HCR_SIZE,
+				DRV_NAME)) {
+		err = -EBUSY;
+		goto err_hcr_failed;
+	}
+
+	if (!request_mem_region(pci_resource_start(pdev, 0) +
+				MTHCA_ECR_BASE,
+				MTHCA_MAP_ECR_SIZE,
+				DRV_NAME)) {
+		err = -EBUSY;
+		goto err_ecr_failed;
+	}
 
 	if (!request_mem_region(pci_resource_start(pdev, 0) +
 				MTHCA_CLR_INT_BASE,
 				MTHCA_CLR_INT_SIZE,
 				DRV_NAME)) {
 		err = -EBUSY;
-		goto err_bar0_beg;
+		goto err_int_failed;
 	}
 
+
 	err = pci_request_region(pdev, 2, DRV_NAME);
 	if (err)
-		goto err_bar0_end;
+		goto err_bar2_failed;
 
 	if (!ddr_hidden) {
 		err = pci_request_region(pdev, 4, DRV_NAME);
 		if (err)
-			goto err_bar2;
+			goto err_bar4_failed;
 	}
 
 	return 0;
 
-err_bar0_beg:
-	release_mem_region(pci_resource_start(pdev, 0) +
-			   MTHCA_HCR_BASE,
-			   MTHCA_MAP_HCR_SIZE);
+err_bar4_failed:
+
+	pci_release_region(pdev, 2);
+err_bar2_failed:
 
-err_bar0_end:
 	release_mem_region(pci_resource_start(pdev, 0) +
 			   MTHCA_CLR_INT_BASE,
 			   MTHCA_CLR_INT_SIZE);
+err_int_failed:
+
+	release_mem_region(pci_resource_start(pdev, 0) +
+			   MTHCA_ECR_BASE,
+			   MTHCA_MAP_ECR_SIZE);
+err_ecr_failed:
+
+	release_mem_region(pci_resource_start(pdev, 0) +
+			   MTHCA_HCR_BASE,
+			   MTHCA_HCR_SIZE);
+err_hcr_failed:
 
-err_bar2:
-	pci_release_region(pdev, 2);
 	return err;
 }
 
 static void mthca_release_regions(struct pci_dev *pdev,
 				  int ddr_hidden)
 {
-	release_mem_region(pci_resource_start(pdev, 0) +
-			   MTHCA_HCR_BASE,
-			   MTHCA_MAP_HCR_SIZE);
+	if (!ddr_hidden)
+		pci_release_region(pdev, 4);
+
+	pci_release_region(pdev, 2);
+
 	release_mem_region(pci_resource_start(pdev, 0) +
 			   MTHCA_CLR_INT_BASE,
 			   MTHCA_CLR_INT_SIZE);
-	pci_release_region(pdev, 2);
-	if (!ddr_hidden)
-		pci_release_region(pdev, 4);
+
+	release_mem_region(pci_resource_start(pdev, 0) +
+			   MTHCA_ECR_BASE,
+			   MTHCA_MAP_ECR_SIZE);
+
+	release_mem_region(pci_resource_start(pdev, 0) +
+			   MTHCA_HCR_BASE,
+			   MTHCA_HCR_SIZE);
 }
 
 static int __devinit mthca_enable_msi_x(struct mthca_dev *mdev)
@@ -911,29 +937,39 @@
 	mdev->cmd.use_events = 0;
 
 	mthca_base = pci_resource_start(pdev, 0);
-	mdev->hcr = ioremap(mthca_base + MTHCA_HCR_BASE, MTHCA_MAP_HCR_SIZE);
+	mdev->hcr = ioremap(mthca_base + MTHCA_HCR_BASE, MTHCA_HCR_SIZE);
 	if (!mdev->hcr) {
 		mthca_err(mdev, "Couldn't map command register, "
 			  "aborting.\n");
 		err = -ENOMEM;
 		goto err_free_dev;
 	}
+
 	mdev->clr_base = ioremap(mthca_base + MTHCA_CLR_INT_BASE,
 				 MTHCA_CLR_INT_SIZE);
 	if (!mdev->clr_base) {
-		mthca_err(mdev, "Couldn't map command register, "
+		mthca_err(mdev, "Couldn't map interrupt clear register, "
 			  "aborting.\n");
 		err = -ENOMEM;
 		goto err_iounmap;
 	}
 
+	mdev->ecr_base = ioremap(mthca_base + MTHCA_ECR_BASE,
+				 MTHCA_ECR_SIZE + MTHCA_ECR_CLR_SIZE);
+	if (!mdev->ecr_base) {
+		mthca_err(mdev, "Couldn't map ecr register, "
+			  "aborting.\n");
+		err = -ENOMEM;
+		goto err_iounmap_clr;
+	}
+
 	mthca_base = pci_resource_start(pdev, 2);
 	mdev->kar = ioremap(mthca_base + PAGE_SIZE * MTHCA_KAR_PAGE, PAGE_SIZE);
 	if (!mdev->kar) {
 		mthca_err(mdev, "Couldn't map kernel access region, "
 			  "aborting.\n");
 		err = -ENOMEM;
-		goto err_iounmap_clr;
+		goto err_iounmap_ecr;
 	}
 
 	err = mthca_tune_pci(mdev);
@@ -982,6 +1018,9 @@
 err_iounmap_kar:
 	iounmap(mdev->kar);
 
+err_iounmap_ecr:
+	iounmap(mdev->ecr_base);
+
 err_iounmap_clr:
 	iounmap(mdev->clr_base);
 
@@ -1033,6 +1072,7 @@
 		mthca_close_hca(mdev);
 
 		iounmap(mdev->hcr);
+		iounmap(mdev->ecr_base);
 		iounmap(mdev->clr_base);
 
 		if (mdev->mthca_flags & MTHCA_FLAG_MSI_X)
--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_config_reg.h	2005-01-23 08:30:41.000000000 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_config_reg.h	2005-01-23 20:58:55.772086392 -0800
@@ -43,13 +43,8 @@
 #define MTHCA_ECR_SIZE         0x00008
 #define MTHCA_ECR_CLR_BASE     0x80708
 #define MTHCA_ECR_CLR_SIZE     0x00008
-#define MTHCA_ECR_OFFSET       (MTHCA_ECR_BASE     - MTHCA_HCR_BASE)
-#define MTHCA_ECR_CLR_OFFSET   (MTHCA_ECR_CLR_BASE - MTHCA_HCR_BASE)
+#define MTHCA_MAP_ECR_SIZE     (MTHCA_ECR_SIZE + MTHCA_ECR_CLR_SIZE)
 #define MTHCA_CLR_INT_BASE     0xf00d8
 #define MTHCA_CLR_INT_SIZE     0x00008
 
-#define MTHCA_MAP_HCR_SIZE     (MTHCA_ECR_CLR_BASE   + \
-			        MTHCA_ECR_CLR_SIZE   - \
-			        MTHCA_HCR_BASE)
-
 #endif /* MTHCA_CONFIG_REG_H */
--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_dev.h	2005-01-23 20:39:02.036561776 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_dev.h	2005-01-23 20:58:55.770086696 -0800
@@ -237,6 +237,7 @@
 	struct semaphore cap_mask_mutex;
 
 	void __iomem    *hcr;
+	void __iomem    *ecr_base;
 	void __iomem    *clr_base;
 	void __iomem    *kar;
 

