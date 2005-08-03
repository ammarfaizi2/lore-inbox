Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262446AbVHCUpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbVHCUpR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 16:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbVHCUpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 16:45:16 -0400
Received: from mailhub.lss.emc.com ([168.159.2.31]:10963 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S262446AbVHCUpO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 16:45:14 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
From: Brett Russ <russb@emc.com>
Subject: [PATCH 2.6.12.3] PCI/libata INTx cleanup
Message-Id: <20050803204709.8BA0720B06@lns1058.lss.emc.com>
Date: Wed,  3 Aug 2005 16:47:09 -0400 (EDT)
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.8.3.24
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='IP_HTTP_ADDR 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simple cleanup to eliminate X copies of the same function in libata.  
Moved pci_enable_intx() to pci.c, added pci_disable_intx() as well, 
and use them throughout libata and msi.c.

Signed-off-by: Brett Russ <russb@emc.com>

Index: linux-2.6.12.3-mv/drivers/pci/msi.c
===================================================================
--- linux-2.6.12.3-mv.orig/drivers/pci/msi.c
+++ linux-2.6.12.3-mv/drivers/pci/msi.c
@@ -456,10 +456,7 @@ static void enable_msi_mode(struct pci_d
 	}
     	if (pci_find_capability(dev, PCI_CAP_ID_EXP)) {
 		/* PCI Express Endpoint device detected */
-		u16 cmd;
-		pci_read_config_word(dev, PCI_COMMAND, &cmd);
-		cmd |= PCI_COMMAND_INTX_DISABLE;
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
+		pci_disable_intx(dev);
 	}
 }
 
@@ -478,10 +475,7 @@ static void disable_msi_mode(struct pci_
 	}
     	if (pci_find_capability(dev, PCI_CAP_ID_EXP)) {
 		/* PCI Express Endpoint device detected */
-		u16 cmd;
-		pci_read_config_word(dev, PCI_COMMAND, &cmd);
-		cmd &= ~PCI_COMMAND_INTX_DISABLE;
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
+		pci_enable_intx(dev);
 	}
 }
 
Index: linux-2.6.12.3-mv/drivers/pci/pci.c
===================================================================
--- linux-2.6.12.3-mv.orig/drivers/pci/pci.c
+++ linux-2.6.12.3-mv/drivers/pci/pci.c
@@ -733,6 +733,43 @@ pci_clear_mwi(struct pci_dev *dev)
 	}
 }
 
+
+/**
+ * pci_enable_intx - enables INTx generation in PCI cfg space cmd register
+ * @dev: the PCI device to enable
+ *
+ * Enables PCI INTx generation for device
+ */
+void 
+pci_enable_intx(struct pci_dev *pdev)
+{
+        u16 pci_command;
+
+        pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
+        if (pci_command & PCI_COMMAND_INTX_DISABLE) {
+                pci_command &= ~PCI_COMMAND_INTX_DISABLE;
+                pci_write_config_word(pdev, PCI_COMMAND, pci_command);
+        }
+}
+
+/**
+ * pci_disable_intx - disables INTx generation in PCI cfg space cmd register
+ * @dev: the PCI device to disable
+ *
+ * Disables PCI INTx generation for device
+ */
+void 
+pci_disable_intx(struct pci_dev *pdev)
+{
+        u16 pci_command;
+
+        pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
+        if (!(pci_command & PCI_COMMAND_INTX_DISABLE)) {
+                pci_command |= PCI_COMMAND_INTX_DISABLE;
+                pci_write_config_word(pdev, PCI_COMMAND, pci_command);
+        }
+}
+
 #ifndef HAVE_ARCH_PCI_SET_DMA_MASK
 /*
  * These can be overridden by arch-specific implementations
@@ -809,6 +846,8 @@ EXPORT_SYMBOL(pci_request_region);
 EXPORT_SYMBOL(pci_set_master);
 EXPORT_SYMBOL(pci_set_mwi);
 EXPORT_SYMBOL(pci_clear_mwi);
+EXPORT_SYMBOL(pci_enable_intx);
+EXPORT_SYMBOL(pci_disable_intx);
 EXPORT_SYMBOL(pci_set_dma_mask);
 EXPORT_SYMBOL(pci_set_consistent_dma_mask);
 EXPORT_SYMBOL(pci_assign_resource);
Index: linux-2.6.12.3-mv/drivers/scsi/sata_sis.c
===================================================================
--- linux-2.6.12.3-mv.orig/drivers/scsi/sata_sis.c
+++ linux-2.6.12.3-mv/drivers/scsi/sata_sis.c
@@ -186,18 +186,6 @@ static void sis_scr_write (struct ata_po
 		outl(val, ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
-/* move to PCI layer, integrate w/ MSI stuff */
-static void pci_enable_intx(struct pci_dev *pdev)
-{
-	u16 pci_command;
-
-	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
-	if (pci_command & PCI_COMMAND_INTX_DISABLE) {
-		pci_command &= ~PCI_COMMAND_INTX_DISABLE;
-		pci_write_config_word(pdev, PCI_COMMAND, pci_command);
-	}
-}
-
 static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct ata_probe_ent *probe_ent = NULL;
Index: linux-2.6.12.3-mv/drivers/scsi/ahci.c
===================================================================
--- linux-2.6.12.3-mv.orig/drivers/scsi/ahci.c
+++ linux-2.6.12.3-mv/drivers/scsi/ahci.c
@@ -878,18 +878,6 @@ static int ahci_host_init(struct ata_pro
 	return 0;
 }
 
-/* move to PCI layer, integrate w/ MSI stuff */
-static void pci_enable_intx(struct pci_dev *pdev)
-{
-	u16 pci_command;
-
-	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
-	if (pci_command & PCI_COMMAND_INTX_DISABLE) {
-		pci_command &= ~PCI_COMMAND_INTX_DISABLE;
-		pci_write_config_word(pdev, PCI_COMMAND, pci_command);
-	}
-}
-
 static void ahci_print_info(struct ata_probe_ent *probe_ent)
 {
 	struct ahci_host_priv *hpriv = probe_ent->private_data;
Index: linux-2.6.12.3-mv/drivers/scsi/ata_piix.c
===================================================================
--- linux-2.6.12.3-mv.orig/drivers/scsi/ata_piix.c
+++ linux-2.6.12.3-mv/drivers/scsi/ata_piix.c
@@ -545,18 +545,6 @@ static void piix_set_dmamode (struct ata
 	}
 }
 
-/* move to PCI layer, integrate w/ MSI stuff */
-static void pci_enable_intx(struct pci_dev *pdev)
-{
-	u16 pci_command;
-
-	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
-	if (pci_command & PCI_COMMAND_INTX_DISABLE) {
-		pci_command &= ~PCI_COMMAND_INTX_DISABLE;
-		pci_write_config_word(pdev, PCI_COMMAND, pci_command);
-	}
-}
-
 #define AHCI_PCI_BAR 5
 #define AHCI_GLOBAL_CTL 0x04
 #define AHCI_ENABLE (1 << 31)
Index: linux-2.6.12.3-mv/drivers/scsi/sata_uli.c
===================================================================
--- linux-2.6.12.3-mv.orig/drivers/scsi/sata_uli.c
+++ linux-2.6.12.3-mv/drivers/scsi/sata_uli.c
@@ -171,18 +171,6 @@ static void uli_scr_write (struct ata_po
 	uli_scr_cfg_write(ap, sc_reg, val);
 }
 
-/* move to PCI layer, integrate w/ MSI stuff */
-static void pci_enable_intx(struct pci_dev *pdev)
-{
-	u16 pci_command;
-
-	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
-	if (pci_command & PCI_COMMAND_INTX_DISABLE) {
-		pci_command &= ~PCI_COMMAND_INTX_DISABLE;
-		pci_write_config_word(pdev, PCI_COMMAND, pci_command);
-	}
-}
-
 static int uli_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct ata_probe_ent *probe_ent;
Index: linux-2.6.12.3-mv/include/linux/pci.h
===================================================================
--- linux-2.6.12.3-mv.orig/include/linux/pci.h
+++ linux-2.6.12.3-mv/include/linux/pci.h
@@ -810,6 +810,8 @@ void pci_set_master(struct pci_dev *dev)
 #define HAVE_PCI_SET_MWI
 int pci_set_mwi(struct pci_dev *dev);
 void pci_clear_mwi(struct pci_dev *dev);
+void pci_enable_intx(struct pci_dev *pdev);
+void pci_disable_intx(struct pci_dev *pdev);
 int pci_set_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_assign_resource(struct pci_dev *dev, int i);
