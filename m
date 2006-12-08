Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760821AbWLHS2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760821AbWLHS2g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 13:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760810AbWLHS2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 13:28:24 -0500
Received: from smtp.osdl.org ([65.172.181.25]:46227 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760818AbWLHS2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 13:28:07 -0500
Message-Id: <20061208182500.750734000@osdl.org>
References: <20061208182241.786324000@osdl.org>
User-Agent: quilt/0.46-1
Date: Fri, 08 Dec 2006 10:22:47 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] PCI-X relaxed ordering interface
Content-Disposition: inline; filename=pcix-ero
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an interface for set/clearing relaxed ordering

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
---
 drivers/net/bnx2.c  |   10 +-------
 drivers/net/tg3.c   |    4 ---
 drivers/pci/pci.c   |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h |    2 +
 4 files changed, 63 insertions(+), 11 deletions(-)

--- pci-x.orig/drivers/net/bnx2.c
+++ pci-x/drivers/net/bnx2.c
@@ -3384,14 +3384,8 @@ bnx2_init_chip(struct bnx2 *bp)
 		REG_WR(bp, BNX2_TDMA_CONFIG, val);
 	}
 
-	if (bp->flags & PCIX_FLAG) {
-		u16 val16;
-
-		pci_read_config_word(bp->pdev, bp->pcix_cap + PCI_X_CMD,
-				     &val16);
-		pci_write_config_word(bp->pdev, bp->pcix_cap + PCI_X_CMD,
-				      val16 & ~PCI_X_CMD_ERO);
-	}
+	if (bp->flags & PCIX_FLAG)
+		pcix_clear_ero(bp->pdev);
 
 	REG_WR(bp, BNX2_MISC_ENABLE_SET_BITS,
 	       BNX2_MISC_ENABLE_SET_BITS_HOST_COALESCE_ENABLE |
--- pci-x.orig/drivers/net/tg3.c
+++ pci-x/drivers/net/tg3.c
@@ -4884,9 +4884,7 @@ static int tg3_chip_reset(struct tg3 *tp
 	pci_restore_state(tp->pdev);
 
 	/* Make sure PCI-X relaxed ordering bit is clear. */
-	pci_read_config_dword(tp->pdev, TG3PCI_X_CAPS, &val);
-	val &= ~PCIX_CAPS_RELAXED_ORDERING;
-	pci_write_config_dword(tp->pdev, TG3PCI_X_CAPS, val);
+	pcix_clear_ero(tp->pdev);
 
 	if (tp->tg3_flags2 & TG3_FLG2_5780_CLASS) {
 		u32 val;
--- pci-x.orig/drivers/pci/pci.c
+++ pci-x/drivers/pci/pci.c
@@ -1203,6 +1203,64 @@ out:
 }
 EXPORT_SYMBOL(pcie_set_readrq);
 
+/**
+ * pcix_set_ero - enable relaxed operations
+ * @dev: PCI device to enable
+ *
+ * Enables PCI-X Relaxed Ordering
+ */
+int
+pcix_set_ero(struct pci_dev *dev)
+{
+	int cap, err;
+	u16 val;
+
+	cap = pci_find_capability(dev, PCI_CAP_ID_PCIX);
+	if (!cap)
+		return -EINVAL;
+
+	err = pci_read_config_word(dev, cap + PCI_X_CMD, &val);
+	if (err)
+		goto out;
+
+	if (!(val & PCI_X_CMD_ERO)) {
+		val |= PCI_X_CMD_ERO;
+		err = pci_write_config_dword(dev, cap + PCI_X_CMD, val);
+	}
+out:
+	return err;
+}
+EXPORT_SYMBOL(pcix_set_ero);
+
+/**
+ * pcix_clear_ero - enable relaxed operations
+ * @dev: PCI device to disable reordering
+ *
+ * Disables PCI-X Relaxed Ordering
+ */
+int
+pcix_clear_ero(struct pci_dev *dev)
+{
+	int cap, err;
+	u16 val;
+
+	cap = pci_find_capability(dev, PCI_CAP_ID_PCIX);
+	if (!cap)
+		return -EINVAL;
+
+	err = pci_read_config_word(dev, cap + PCI_X_CMD, &val);
+	if (err)
+		goto out;
+
+	if (val & PCI_X_CMD_ERO) {
+		val &= ~PCI_X_CMD_ERO;
+		err = pci_write_config_dword(dev, cap + PCI_X_CMD, val);
+	}
+out:
+	return err;
+}
+EXPORT_SYMBOL(pcix_clear_ero);
+
 static int __devinit pci_init(void)
 {
 	struct pci_dev *dev = NULL;
--- pci-x.orig/include/linux/pci.h
+++ pci-x/include/linux/pci.h
@@ -516,6 +516,8 @@ int pcix_get_mmrbc(struct pci_dev *dev);
 int pcix_set_mmrbc(struct pci_dev *dev, int rq);
 int pcie_get_readrq(struct pci_dev *dev);
 int pcie_set_readrq(struct pci_dev *dev, int rq);
+int pcix_set_ero(struct pci_dev *dev);
+int pcix_clear_ero(struct pci_dev *dev);
 void pci_update_resource(struct pci_dev *dev, struct resource *res, int resno);
 int __must_check pci_assign_resource(struct pci_dev *dev, int i);
 int __must_check pci_assign_resource_fixed(struct pci_dev *dev, int i);

-- 

