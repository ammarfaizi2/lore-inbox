Return-Path: <linux-kernel-owner+w=401wt.eu-S1760966AbWLHSxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760966AbWLHSxA (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 13:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760964AbWLHSxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 13:53:00 -0500
Received: from smtp.osdl.org ([65.172.181.25]:48720 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760966AbWLHSw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 13:52:59 -0500
Message-Id: <20061208182500.684722000@osdl.org>
References: <20061208182241.786324000@osdl.org>
User-Agent: quilt/0.46-1
Date: Fri, 08 Dec 2006 10:22:46 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] QLA2 use pci read tuning interface
Content-Disposition: inline; filename=qla-mmrbc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Resend of earlier patch, driver name conflicts with porn filters)

Use new PCI read tuning interface. This makes sure driver doesn't
run into PCI chipset errata problems now or in future.
Untested on real hardware.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

--- pci-x.orig/drivers/scsi/qla2xxx/qla_init.c
+++ pci-x/drivers/scsi/qla2xxx/qla_init.c
@@ -250,7 +250,6 @@ qla24xx_pci_config(scsi_qla_host_t *ha)
 	uint32_t d;
 	unsigned long flags = 0;
 	struct device_reg_24xx __iomem *reg = &ha->iobase->isp24;
-	int pcix_cmd_reg, pcie_dctl_reg;
 
 	pci_set_master(ha->pdev);
 	mwi = 0;
@@ -265,28 +264,10 @@ qla24xx_pci_config(scsi_qla_host_t *ha)
 	pci_write_config_byte(ha->pdev, PCI_LATENCY_TIMER, 0x80);
 
 	/* PCI-X -- adjust Maximum Memory Read Byte Count (2048). */
-	pcix_cmd_reg = pci_find_capability(ha->pdev, PCI_CAP_ID_PCIX);
-	if (pcix_cmd_reg) {
-		uint16_t pcix_cmd;
-
-		pcix_cmd_reg += PCI_X_CMD;
-		pci_read_config_word(ha->pdev, pcix_cmd_reg, &pcix_cmd);
-		pcix_cmd &= ~PCI_X_CMD_MAX_READ;
-		pcix_cmd |= 0x0008;
-		pci_write_config_word(ha->pdev, pcix_cmd_reg, pcix_cmd);
-	}
+	pcix_set_mmrbc(ha->pdev, 2048);
 
 	/* PCIe -- adjust Maximum Read Request Size (2048). */
-	pcie_dctl_reg = pci_find_capability(ha->pdev, PCI_CAP_ID_EXP);
-	if (pcie_dctl_reg) {
-		uint16_t pcie_dctl;
-
-		pcie_dctl_reg += PCI_EXP_DEVCTL;
-		pci_read_config_word(ha->pdev, pcie_dctl_reg, &pcie_dctl);
-		pcie_dctl &= ~PCI_EXP_DEVCTL_READRQ;
-		pcie_dctl |= 0x4000;
-		pci_write_config_word(ha->pdev, pcie_dctl_reg, pcie_dctl);
-	}
+	pcie_set_readrq(ha->pdev, 2048);
 
 	/* Reset expansion ROM address decode enable */
 	pci_read_config_dword(ha->pdev, PCI_ROM_ADDRESS, &d);

-- 

