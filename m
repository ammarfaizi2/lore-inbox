Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262790AbVCDBnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbVCDBnk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 20:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbVCDADY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:03:24 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:53494 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262730AbVCCXWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:22:09 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][7/26] IB/mthca: map registers for mem-free mode
In-Reply-To: <2005331520.psAuTRchMaqO6dem@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 3 Mar 2005 15:20:27 -0800
Message-Id: <2005331520.q2c4004P8DuwgJEx@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 23:20:27.0378 (UTC) FILETIME=[958D9D20:01C52047]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the request/ioremap of regions related to event handling into
mthca_eq.c.  Map the correct regions depending on whether we're in
Tavor or native mem-free mode.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_config_reg.h	2005-01-25 20:48:48.000000000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_config_reg.h	2005-03-03 14:12:55.516870705 -0800
@@ -46,5 +46,6 @@
 #define MTHCA_MAP_ECR_SIZE     (MTHCA_ECR_SIZE + MTHCA_ECR_CLR_SIZE)
 #define MTHCA_CLR_INT_BASE     0xf00d8
 #define MTHCA_CLR_INT_SIZE     0x00008
+#define MTHCA_EQ_SET_CI_SIZE   (8 * 32)
 
 #endif /* MTHCA_CONFIG_REG_H */
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_dev.h	2005-03-03 14:12:54.672054087 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_dev.h	2005-03-03 14:12:55.515870922 -0800
@@ -237,9 +237,17 @@
 	struct semaphore cap_mask_mutex;
 
 	void __iomem    *hcr;
-	void __iomem    *ecr_base;
-	void __iomem    *clr_base;
 	void __iomem    *kar;
+	void __iomem    *clr_base;
+	union {
+		struct {
+			void __iomem *ecr_base;
+		} tavor;
+		struct {
+			void __iomem *eq_arm;
+			void __iomem *eq_set_ci_base;
+		} arbel;
+	} eq_regs;
 
 	struct mthca_cmd    cmd;
 	struct mthca_limits limits;
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_eq.c	2005-01-25 20:48:48.000000000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_eq.c	2005-03-03 14:12:55.516870705 -0800
@@ -366,10 +366,10 @@
 	if (dev->eq_table.clr_mask)
 		writel(dev->eq_table.clr_mask, dev->eq_table.clr_int);
 
-	if ((ecr = readl(dev->ecr_base + 4)) != 0) {
+	if ((ecr = readl(dev->eq_regs.tavor.ecr_base + 4)) != 0) {
 		work = 1;
 
-		writel(ecr, dev->ecr_base +
+		writel(ecr, dev->eq_regs.tavor.ecr_base +
 		       MTHCA_ECR_CLR_BASE - MTHCA_ECR_BASE + 4);
 
 		for (i = 0; i < MTHCA_NUM_EQ; ++i)
@@ -578,6 +578,129 @@
 				 dev->eq_table.eq + i);
 }
 
+static int __devinit mthca_map_reg(struct mthca_dev *dev,
+				   unsigned long offset, unsigned long size,
+				   void __iomem **map)
+{
+	unsigned long base = pci_resource_start(dev->pdev, 0);
+
+	if (!request_mem_region(base + offset, size, DRV_NAME))
+		return -EBUSY;
+
+	*map = ioremap(base + offset, size);
+	if (!*map) {
+		release_mem_region(base + offset, size);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void mthca_unmap_reg(struct mthca_dev *dev, unsigned long offset,
+			    unsigned long size, void __iomem *map)
+{
+	unsigned long base = pci_resource_start(dev->pdev, 0);
+
+	release_mem_region(base + offset, size);
+	iounmap(map);
+}
+
+static int __devinit mthca_map_eq_regs(struct mthca_dev *dev)
+{
+	unsigned long mthca_base;
+
+	mthca_base = pci_resource_start(dev->pdev, 0);
+
+	if (dev->hca_type == ARBEL_NATIVE) {
+		/*
+		 * We assume that the EQ arm and EQ set CI registers
+		 * fall within the first BAR.  We can't trust the
+		 * values firmware gives us, since those addresses are
+		 * valid on the HCA's side of the PCI bus but not
+		 * necessarily the host side.
+		 */
+		if (mthca_map_reg(dev, (pci_resource_len(dev->pdev, 0) - 1) &
+				  dev->fw.arbel.clr_int_base, MTHCA_CLR_INT_SIZE,
+				  &dev->clr_base)) {
+			mthca_err(dev, "Couldn't map interrupt clear register, "
+				  "aborting.\n");
+			return -ENOMEM;
+		}
+
+		/*
+		 * Add 4 because we limit ourselves to EQs 0 ... 31,
+		 * so we only need the low word of the register.
+		 */
+		if (mthca_map_reg(dev, ((pci_resource_len(dev->pdev, 0) - 1) &
+					dev->fw.arbel.eq_arm_base) + 4, 4,
+				  &dev->eq_regs.arbel.eq_arm)) {
+			mthca_err(dev, "Couldn't map interrupt clear register, "
+				  "aborting.\n");
+			mthca_unmap_reg(dev, (pci_resource_len(dev->pdev, 0) - 1) &
+					dev->fw.arbel.clr_int_base, MTHCA_CLR_INT_SIZE,
+					dev->clr_base);
+			return -ENOMEM;
+		}
+
+		if (mthca_map_reg(dev, (pci_resource_len(dev->pdev, 0) - 1) &
+				  dev->fw.arbel.eq_set_ci_base,
+				  MTHCA_EQ_SET_CI_SIZE,
+				  &dev->eq_regs.arbel.eq_set_ci_base)) {
+			mthca_err(dev, "Couldn't map interrupt clear register, "
+				  "aborting.\n");
+			mthca_unmap_reg(dev, ((pci_resource_len(dev->pdev, 0) - 1) &
+					      dev->fw.arbel.eq_arm_base) + 4, 4,
+					dev->eq_regs.arbel.eq_arm);
+			mthca_unmap_reg(dev, (pci_resource_len(dev->pdev, 0) - 1) &
+					dev->fw.arbel.clr_int_base, MTHCA_CLR_INT_SIZE,
+					dev->clr_base);
+			return -ENOMEM;
+		}
+	} else {
+		if (mthca_map_reg(dev, MTHCA_CLR_INT_BASE, MTHCA_CLR_INT_SIZE,
+				  &dev->clr_base)) {
+			mthca_err(dev, "Couldn't map interrupt clear register, "
+				  "aborting.\n");
+			return -ENOMEM;
+		}
+
+		if (mthca_map_reg(dev, MTHCA_ECR_BASE,
+				  MTHCA_ECR_SIZE + MTHCA_ECR_CLR_SIZE,
+				  &dev->eq_regs.tavor.ecr_base)) {
+			mthca_err(dev, "Couldn't map ecr register, "
+				  "aborting.\n");
+			mthca_unmap_reg(dev, MTHCA_CLR_INT_BASE, MTHCA_CLR_INT_SIZE,
+					dev->clr_base);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+
+}
+
+static void __devexit mthca_unmap_eq_regs(struct mthca_dev *dev)
+{
+	if (dev->hca_type == ARBEL_NATIVE) {
+		mthca_unmap_reg(dev, (pci_resource_len(dev->pdev, 0) - 1) &
+				dev->fw.arbel.eq_set_ci_base,
+				MTHCA_EQ_SET_CI_SIZE,
+				dev->eq_regs.arbel.eq_set_ci_base);
+		mthca_unmap_reg(dev, ((pci_resource_len(dev->pdev, 0) - 1) &
+				      dev->fw.arbel.eq_arm_base) + 4, 4,
+				dev->eq_regs.arbel.eq_arm);
+		mthca_unmap_reg(dev, (pci_resource_len(dev->pdev, 0) - 1) &
+				dev->fw.arbel.clr_int_base, MTHCA_CLR_INT_SIZE,
+				dev->clr_base);
+	} else {
+		mthca_unmap_reg(dev, MTHCA_ECR_BASE,
+				MTHCA_ECR_SIZE + MTHCA_ECR_CLR_SIZE,
+				dev->eq_regs.tavor.ecr_base);
+		mthca_unmap_reg(dev, MTHCA_CLR_INT_BASE, MTHCA_CLR_INT_SIZE,
+				dev->clr_base);
+	}
+}
+
 int __devinit mthca_map_eq_icm(struct mthca_dev *dev, u64 icm_virt)
 {
 	int ret;
@@ -636,6 +759,10 @@
 	if (err)
 		return err;
 
+	err = mthca_map_eq_regs(dev);
+	if (err)
+		goto err_out_free;
+
 	if (dev->mthca_flags & MTHCA_FLAG_MSI ||
 	    dev->mthca_flags & MTHCA_FLAG_MSI_X) {
 		dev->eq_table.clr_mask = 0;
@@ -653,7 +780,7 @@
 			      (dev->mthca_flags & MTHCA_FLAG_MSI_X) ? 128 : intr,
 			      &dev->eq_table.eq[MTHCA_EQ_COMP]);
 	if (err)
-		goto err_out_free;
+		goto err_out_unmap;
 
 	err = mthca_create_eq(dev, MTHCA_NUM_ASYNC_EQE,
 			      (dev->mthca_flags & MTHCA_FLAG_MSI_X) ? 129 : intr,
@@ -720,6 +847,9 @@
 err_out_comp:
 	mthca_free_eq(dev, &dev->eq_table.eq[MTHCA_EQ_COMP]);
 
+err_out_unmap:
+	mthca_unmap_eq_regs(dev);
+
 err_out_free:
 	mthca_alloc_cleanup(&dev->eq_table.alloc);
 	return err;
@@ -740,5 +870,7 @@
 	for (i = 0; i < MTHCA_NUM_EQ; ++i)
 		mthca_free_eq(dev, &dev->eq_table.eq[i]);
 
+	mthca_unmap_eq_regs(dev);
+
 	mthca_alloc_cleanup(&dev->eq_table.alloc);
 }
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_main.c	2005-01-25 20:49:05.000000000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_main.c	2005-03-03 14:12:55.516870705 -0800
@@ -686,37 +686,18 @@
 	int err;
 
 	/*
-	 * We request our first BAR in two chunks, since the MSI-X
-	 * vector table is right in the middle.
+	 * We can't just use pci_request_regions() because the MSI-X
+	 * table is right in the middle of the first BAR.  If we did
+	 * pci_request_region and grab all of the first BAR, then
+	 * setting up MSI-X would fail, since the PCI core wants to do
+	 * request_mem_region on the MSI-X vector table.
 	 *
-	 * This is why we can't just use pci_request_regions() -- if
-	 * we did then setting up MSI-X would fail, since the PCI core
-	 * wants to do request_mem_region on the MSI-X vector table.
+	 * So just request what we need right now, and request any
+	 * other regions we need when setting up EQs.
 	 */
-	if (!request_mem_region(pci_resource_start(pdev, 0) +
-				MTHCA_HCR_BASE,
-				MTHCA_HCR_SIZE,
-				DRV_NAME)) {
-		err = -EBUSY;
-		goto err_hcr_failed;
-	}
-
-	if (!request_mem_region(pci_resource_start(pdev, 0) +
-				MTHCA_ECR_BASE,
-				MTHCA_MAP_ECR_SIZE,
-				DRV_NAME)) {
-		err = -EBUSY;
-		goto err_ecr_failed;
-	}
-
-	if (!request_mem_region(pci_resource_start(pdev, 0) +
-				MTHCA_CLR_INT_BASE,
-				MTHCA_CLR_INT_SIZE,
-				DRV_NAME)) {
-		err = -EBUSY;
-		goto err_int_failed;
-	}
-
+	if (!request_mem_region(pci_resource_start(pdev, 0) + MTHCA_HCR_BASE,
+				MTHCA_HCR_SIZE, DRV_NAME))
+		return -EBUSY;
 
 	err = pci_request_region(pdev, 2, DRV_NAME);
 	if (err)
@@ -731,24 +712,11 @@
 	return 0;
 
 err_bar4_failed:
-
 	pci_release_region(pdev, 2);
-err_bar2_failed:
-
-	release_mem_region(pci_resource_start(pdev, 0) +
-			   MTHCA_CLR_INT_BASE,
-			   MTHCA_CLR_INT_SIZE);
-err_int_failed:
-
-	release_mem_region(pci_resource_start(pdev, 0) +
-			   MTHCA_ECR_BASE,
-			   MTHCA_MAP_ECR_SIZE);
-err_ecr_failed:
 
-	release_mem_region(pci_resource_start(pdev, 0) +
-			   MTHCA_HCR_BASE,
+err_bar2_failed:
+	release_mem_region(pci_resource_start(pdev, 0) + MTHCA_HCR_BASE,
 			   MTHCA_HCR_SIZE);
-err_hcr_failed:
 
 	return err;
 }
@@ -761,16 +729,7 @@
 
 	pci_release_region(pdev, 2);
 
-	release_mem_region(pci_resource_start(pdev, 0) +
-			   MTHCA_CLR_INT_BASE,
-			   MTHCA_CLR_INT_SIZE);
-
-	release_mem_region(pci_resource_start(pdev, 0) +
-			   MTHCA_ECR_BASE,
-			   MTHCA_MAP_ECR_SIZE);
-
-	release_mem_region(pci_resource_start(pdev, 0) +
-			   MTHCA_HCR_BASE,
+	release_mem_region(pci_resource_start(pdev, 0) + MTHCA_HCR_BASE,
 			   MTHCA_HCR_SIZE);
 }
 
@@ -941,31 +900,13 @@
 		goto err_free_dev;
 	}
 
-	mdev->clr_base = ioremap(mthca_base + MTHCA_CLR_INT_BASE,
-				 MTHCA_CLR_INT_SIZE);
-	if (!mdev->clr_base) {
-		mthca_err(mdev, "Couldn't map interrupt clear register, "
-			  "aborting.\n");
-		err = -ENOMEM;
-		goto err_iounmap;
-	}
-
-	mdev->ecr_base = ioremap(mthca_base + MTHCA_ECR_BASE,
-				 MTHCA_ECR_SIZE + MTHCA_ECR_CLR_SIZE);
-	if (!mdev->ecr_base) {
-		mthca_err(mdev, "Couldn't map ecr register, "
-			  "aborting.\n");
-		err = -ENOMEM;
-		goto err_iounmap_clr;
-	}
-
 	mthca_base = pci_resource_start(pdev, 2);
 	mdev->kar = ioremap(mthca_base + PAGE_SIZE * MTHCA_KAR_PAGE, PAGE_SIZE);
 	if (!mdev->kar) {
 		mthca_err(mdev, "Couldn't map kernel access region, "
 			  "aborting.\n");
 		err = -ENOMEM;
-		goto err_iounmap_ecr;
+		goto err_iounmap;
 	}
 
 	err = mthca_tune_pci(mdev);
@@ -1014,12 +955,6 @@
 err_iounmap_kar:
 	iounmap(mdev->kar);
 
-err_iounmap_ecr:
-	iounmap(mdev->ecr_base);
-
-err_iounmap_clr:
-	iounmap(mdev->clr_base);
-
 err_iounmap:
 	iounmap(mdev->hcr);
 
@@ -1067,9 +1002,8 @@
 
 		mthca_close_hca(mdev);
 
+		iounmap(mdev->kar);
 		iounmap(mdev->hcr);
-		iounmap(mdev->ecr_base);
-		iounmap(mdev->clr_base);
 
 		if (mdev->mthca_flags & MTHCA_FLAG_MSI_X)
 			pci_disable_msix(pdev);

