Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbVIMWvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbVIMWvL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 18:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbVIMWvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 18:51:11 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:44241 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964935AbVIMWvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 18:51:10 -0400
Date: Tue, 13 Sep 2005 19:20:02 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: andrew.vasquez@qlogic.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] qla2xxx: Use dword accessors for PCI_ROM_ADDRESS
Message-ID: <20050913192002.E10911@mail.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-reply-to: <20050913182550.A10911@mail.kroptech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PCI_ROM_ADDRESS is a 32 bit register and as such should be accessed
using pci_bus_{read,write}_config_dword(). A recent audit of drivers/
turned up several cases of byte- and word-sized accesses. The harmful
ones were fixed by Linus directly. This patches up one of the remaining
harmless-but-still-wrong cases caught in the dragnet.

Signed-off-by: Adam Kropelin <akropel1@rochester.rr.com>

--- linux-2.6.14-rc1.orig/drivers/scsi/qla2xxx/qla_init.c	2005-09-13 11:59:16.000000000 -0400
+++ linux-2.6.14-rc1/drivers/scsi/qla2xxx/qla_init.c	2005-09-13 11:54:06.000000000 -0400
@@ -201,6 +201,7 @@
 qla2100_pci_config(scsi_qla_host_t *ha)
 {
 	uint16_t w, mwi;
+	uint32_t d;
 	unsigned long flags;
 	struct device_reg_2xxx __iomem *reg = &ha->iobase->isp;
 
@@ -215,9 +216,9 @@
 	pci_write_config_word(ha->pdev, PCI_COMMAND, w);
 
 	/* Reset expansion ROM address decode enable */
-	pci_read_config_word(ha->pdev, PCI_ROM_ADDRESS, &w);
-	w &= ~PCI_ROM_ADDRESS_ENABLE;
-	pci_write_config_word(ha->pdev, PCI_ROM_ADDRESS, w);
+	pci_read_config_dword(ha->pdev, PCI_ROM_ADDRESS, &d);
+	d &= ~PCI_ROM_ADDRESS_ENABLE;
+	pci_write_config_dword(ha->pdev, PCI_ROM_ADDRESS, d);
 
 	/* Get PCI bus information. */
 	spin_lock_irqsave(&ha->hardware_lock, flags);
@@ -237,6 +238,7 @@
 qla2300_pci_config(scsi_qla_host_t *ha)
 {
 	uint16_t	w, mwi;
+	uint32_t	d;
 	unsigned long   flags = 0;
 	uint32_t	cnt;
 	struct device_reg_2xxx __iomem *reg = &ha->iobase->isp;
@@ -302,9 +304,9 @@
 	pci_write_config_byte(ha->pdev, PCI_LATENCY_TIMER, 0x80);
 
 	/* Reset expansion ROM address decode enable */
-	pci_read_config_word(ha->pdev, PCI_ROM_ADDRESS, &w);
-	w &= ~PCI_ROM_ADDRESS_ENABLE;
-	pci_write_config_word(ha->pdev, PCI_ROM_ADDRESS, w);
+	pci_read_config_dword(ha->pdev, PCI_ROM_ADDRESS, &d);
+	d &= ~PCI_ROM_ADDRESS_ENABLE;
+	pci_write_config_dword(ha->pdev, PCI_ROM_ADDRESS, d);
 
 	/* Get PCI bus information. */
 	spin_lock_irqsave(&ha->hardware_lock, flags);
@@ -324,6 +326,7 @@
 qla24xx_pci_config(scsi_qla_host_t *ha)
 {
 	uint16_t w, mwi;
+	uint32_t d;
 	unsigned long flags = 0;
 	struct device_reg_24xx __iomem *reg = &ha->iobase->isp24;
 	int pcix_cmd_reg, pcie_dctl_reg;
@@ -366,9 +369,9 @@
 	}
 
 	/* Reset expansion ROM address decode enable */
-	pci_read_config_word(ha->pdev, PCI_ROM_ADDRESS, &w);
-	w &= ~PCI_ROM_ADDRESS_ENABLE;
-	pci_write_config_word(ha->pdev, PCI_ROM_ADDRESS, w);
+	pci_read_config_dword(ha->pdev, PCI_ROM_ADDRESS, &d);
+	d &= ~PCI_ROM_ADDRESS_ENABLE;
+	pci_write_config_dword(ha->pdev, PCI_ROM_ADDRESS, d);
 
 	/* Get PCI bus information. */
 	spin_lock_irqsave(&ha->hardware_lock, flags);
