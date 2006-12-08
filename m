Return-Path: <linux-kernel-owner+w=401wt.eu-S1760810AbWLHS2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760810AbWLHS2g (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 13:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760813AbWLHS2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 13:28:22 -0500
Received: from smtp.osdl.org ([65.172.181.25]:46228 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760821AbWLHS2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 13:28:07 -0500
Message-Id: <20061208182500.611327000@osdl.org>
References: <20061208182241.786324000@osdl.org>
User-Agent: quilt/0.46-1
Date: Fri, 08 Dec 2006 10:22:45 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] MTHCA driver (infiniband) use new pci interfaces
Content-Disposition: inline; filename=mthca-rbc.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use new pci interfaces to set read request tuning values
Untested because of lack of hardware.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

---
 drivers/infiniband/hw/mthca/mthca_main.c |   38 +++++++------------------------
 1 file changed, 9 insertions(+), 29 deletions(-)

--- pci-x.orig/drivers/infiniband/hw/mthca/mthca_main.c
+++ pci-x/drivers/infiniband/hw/mthca/mthca_main.c
@@ -100,45 +100,25 @@ static struct mthca_profile default_prof
 
 static int mthca_tune_pci(struct mthca_dev *mdev)
 {
-	int cap;
-	u16 val;
-
 	if (!tune_pci)
 		return 0;
 
 	/* First try to max out Read Byte Count */
-	cap = pci_find_capability(mdev->pdev, PCI_CAP_ID_PCIX);
-	if (cap) {
-		if (pci_read_config_word(mdev->pdev, cap + PCI_X_CMD, &val)) {
-			mthca_err(mdev, "Couldn't read PCI-X command register, "
+	if (pci_find_capability(mdev->pdev, PCI_CAP_ID_PCIX)) {
+		if (pcix_set_mmrbc(mdev->pdev, 4096)) {
+			mthca_err(mdev, "Couldn't set PCI-X max read count, "
 				  "aborting.\n");
 			return -ENODEV;
 		}
-		val = (val & ~PCI_X_CMD_MAX_READ) | (3 << 2);
-		if (pci_write_config_word(mdev->pdev, cap + PCI_X_CMD, val)) {
-			mthca_err(mdev, "Couldn't write PCI-X command register, "
-				  "aborting.\n");
-			return -ENODEV;
-		}
-	} else if (!(mdev->mthca_flags & MTHCA_FLAG_PCIE))
-		mthca_info(mdev, "No PCI-X capability, not setting RBC.\n");
+	}
 
-	cap = pci_find_capability(mdev->pdev, PCI_CAP_ID_EXP);
-	if (cap) {
-		if (pci_read_config_word(mdev->pdev, cap + PCI_EXP_DEVCTL, &val)) {
-			mthca_err(mdev, "Couldn't read PCI Express device control "
-				  "register, aborting.\n");
-			return -ENODEV;
-		}
-		val = (val & ~PCI_EXP_DEVCTL_READRQ) | (5 << 12);
-		if (pci_write_config_word(mdev->pdev, cap + PCI_EXP_DEVCTL, val)) {
-			mthca_err(mdev, "Couldn't write PCI Express device control "
-				  "register, aborting.\n");
+	if (pci_find_capability(mdev->pdev, PCI_CAP_ID_EXP)) {
+		if (pcie_set_readrq(mdev->pdev, 4096)) {
+			mthca_err(mdev, "Couldn't write PCI Express read request, "
+				  "aborting.\n");
 			return -ENODEV;
 		}
-	} else if (mdev->mthca_flags & MTHCA_FLAG_PCIE)
-		mthca_info(mdev, "No PCI Express capability, "
-			   "not setting Max Read Request Size.\n");
+	}
 
 	return 0;
 }

-- 

