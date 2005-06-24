Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263113AbVFXEW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263113AbVFXEW1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 00:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbVFXENB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 00:13:01 -0400
Received: from webmail.topspin.com ([12.162.17.3]:33605 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S263101AbVFXEEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 00:04:25 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 12/14] IB/mthca: Encapsulate command interface init
In-Reply-To: <2005623214.gjur4MFr788QnYf6@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 23 Jun 2005 21:04:21 -0700
Message-Id: <2005623214.Wl3n9twXcA60cNkd@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 24 Jun 2005 04:04:21.0230 (UTC) FILETIME=[CCC928E0:01C57871]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Encapsulate mthca command interface initialization/cleanup.

Signed-off-by: Roland Dreier <roland@topspin.com>

---

 linux.git/drivers/infiniband/hw/mthca/mthca_cmd.c  |   21 +++++++++++++++++++++
 linux.git/drivers/infiniband/hw/mthca/mthca_cmd.h  |    2 ++
 linux.git/drivers/infiniband/hw/mthca/mthca_main.c |   23 +++++++----------------
 3 files changed, 30 insertions(+), 16 deletions(-)



--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-06-23 13:03:01.180861451 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-06-23 13:03:08.794213733 -0700
@@ -431,6 +431,27 @@ static int mthca_cmd_imm(struct mthca_de
 				      timeout, status);
 }
 
+int mthca_cmd_init(struct mthca_dev *dev)
+{
+	sema_init(&dev->cmd.hcr_sem, 1);
+	sema_init(&dev->cmd.poll_sem, 1);
+	dev->cmd.use_events = 0;
+
+	dev->hcr = ioremap(pci_resource_start(dev->pdev, 0) + MTHCA_HCR_BASE,
+			   MTHCA_HCR_SIZE);
+	if (!dev->hcr) {
+		mthca_err(dev, "Couldn't map command register.");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void mthca_cmd_cleanup(struct mthca_dev *dev)
+{
+	iounmap(dev->hcr);
+}
+
 /*
  * Switch to using events to issue FW commands (should be called after
  * event queue to command events has been initialized).
--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_cmd.h	2005-06-23 13:03:01.180861451 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_cmd.h	2005-06-23 13:03:08.795213517 -0700
@@ -235,6 +235,8 @@ struct mthca_set_ib_param {
 	u32 cap_mask;
 };
 
+int mthca_cmd_init(struct mthca_dev *dev);
+void mthca_cmd_cleanup(struct mthca_dev *dev);
 int mthca_cmd_use_events(struct mthca_dev *dev);
 void mthca_cmd_use_polling(struct mthca_dev *dev);
 void mthca_cmd_event(struct mthca_dev *dev, u16 token,
--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_main.c	2005-06-23 13:03:03.703315530 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_main.c	2005-06-23 13:03:08.795213517 -0700
@@ -1005,25 +1005,18 @@ static int __devinit mthca_init_one(stru
 	    !pci_enable_msi(pdev))
 		mdev->mthca_flags |= MTHCA_FLAG_MSI;
 
-	sema_init(&mdev->cmd.hcr_sem, 1);
-	sema_init(&mdev->cmd.poll_sem, 1);
-	mdev->cmd.use_events = 0;
-
-	mdev->hcr = ioremap(pci_resource_start(pdev, 0) + MTHCA_HCR_BASE, MTHCA_HCR_SIZE);
-	if (!mdev->hcr) {
-		mthca_err(mdev, "Couldn't map command register, "
-			  "aborting.\n");
-		err = -ENOMEM;
+	if (mthca_cmd_init(mdev)) {
+		mthca_err(mdev, "Failed to init command interface, aborting.\n");
 		goto err_free_dev;
 	}
 
 	err = mthca_tune_pci(mdev);
 	if (err)
-		goto err_iounmap;
+		goto err_cmd;
 
 	err = mthca_init_hca(mdev);
 	if (err)
-		goto err_iounmap;
+		goto err_cmd;
 
 	if (mdev->fw_ver < mthca_hca_table[id->driver_data].latest_fw) {
 		mthca_warn(mdev, "HCA FW version %x.%x.%x is old (%x.%x.%x is current).\n",
@@ -1071,8 +1064,8 @@ err_cleanup:
 err_close:
 	mthca_close_hca(mdev);
 
-err_iounmap:
-	iounmap(mdev->hcr);
+err_cmd:
+	mthca_cmd_cleanup(mdev);
 
 err_free_dev:
 	if (mdev->mthca_flags & MTHCA_FLAG_MSI_X)
@@ -1119,10 +1112,8 @@ static void __devexit mthca_remove_one(s
 		iounmap(mdev->kar);
 		mthca_uar_free(mdev, &mdev->driver_uar);
 		mthca_cleanup_uar_table(mdev);
-
 		mthca_close_hca(mdev);
-
-		iounmap(mdev->hcr);
+		mthca_cmd_cleanup(mdev);
 
 		if (mdev->mthca_flags & MTHCA_FLAG_MSI_X)
 			pci_disable_msix(pdev);

