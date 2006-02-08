Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161078AbWBHJMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161078AbWBHJMR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 04:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbWBHJMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 04:12:17 -0500
Received: from fmr20.intel.com ([134.134.136.19]:11665 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1161078AbWBHJMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 04:12:15 -0500
Subject: [PATCH 2/2]remove msi save/restore code in specific driver
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>,
       linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>
Cc: Andrew Morton <akpm@osdl.org>, Greg <greg@kroah.com>
Content-Type: text/plain
Date: Wed, 08 Feb 2006 17:11:40 +0800
Message-Id: <1139389900.14976.13.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove pcie port driver's msi save/restore code.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---

 linux-2.6.16-rc2-root/drivers/pci/pcie/portdrv.h     |    1 
 linux-2.6.16-rc2-root/drivers/pci/pcie/portdrv_pci.c |   66 +------------------
 2 files changed, 4 insertions(+), 63 deletions(-)

diff -puN drivers/pci/pcie/portdrv.h~remove_driver_msi_save_restore drivers/pci/pcie/portdrv.h
--- linux-2.6.16-rc2/drivers/pci/pcie/portdrv.h~remove_driver_msi_save_restore	2006-02-08 16:58:51.000000000 +0800
+++ linux-2.6.16-rc2-root/drivers/pci/pcie/portdrv.h	2006-02-08 16:58:51.000000000 +0800
@@ -29,7 +29,6 @@
 
 struct pcie_port_device_ext {
 	int interrupt_mode;	/* [0:INTx | 1:MSI | 2:MSI-X] */
-	unsigned int saved_msi_config_space[5];
 };
 
 extern struct bus_type pcie_port_bus_type;
diff -puN drivers/pci/pcie/portdrv_pci.c~remove_driver_msi_save_restore drivers/pci/pcie/portdrv_pci.c
--- linux-2.6.16-rc2/drivers/pci/pcie/portdrv_pci.c~remove_driver_msi_save_restore	2006-02-08 16:58:51.000000000 +0800
+++ linux-2.6.16-rc2-root/drivers/pci/pcie/portdrv_pci.c	2006-02-08 16:58:51.000000000 +0800
@@ -30,75 +30,16 @@ MODULE_LICENSE("GPL");
 /* global data */
 static const char device_name[] = "pcieport-driver";
 
-static void pci_save_msi_state(struct pci_dev *dev)
+static int pcie_portdrv_save_config(struct pci_dev *dev)
 {
-	struct pcie_port_device_ext *p_ext = pci_get_drvdata(dev);
-	int i = 0, pos;
-	u16 control;
-
-   	if ((pos = pci_find_capability(dev, PCI_CAP_ID_MSI)) <= 0)
-		return;
-
-	pci_read_config_dword(dev, pos, &p_ext->saved_msi_config_space[i++]);
-	control = p_ext->saved_msi_config_space[0] >> 16;
-	pci_read_config_dword(dev, pos + PCI_MSI_ADDRESS_LO,
-		&p_ext->saved_msi_config_space[i++]);
-	if (control & PCI_MSI_FLAGS_64BIT) {
-		pci_read_config_dword(dev, pos + PCI_MSI_ADDRESS_HI,
-			&p_ext->saved_msi_config_space[i++]);
-		pci_read_config_dword(dev, pos + PCI_MSI_DATA_64,
-			&p_ext->saved_msi_config_space[i++]);
-	} else
-		pci_read_config_dword(dev, pos + PCI_MSI_DATA_32,
-			&p_ext->saved_msi_config_space[i++]);
-	if (control & PCI_MSI_FLAGS_MASKBIT)
-		pci_read_config_dword(dev, pos + PCI_MSI_MASK_BIT,
-			&p_ext->saved_msi_config_space[i++]);
-}
-
-static void pci_restore_msi_state(struct pci_dev *dev)
-{
-	struct pcie_port_device_ext *p_ext = pci_get_drvdata(dev);
-	int i = 0, pos;
-	u16 control;
-
-   	if ((pos = pci_find_capability(dev, PCI_CAP_ID_MSI)) <= 0)
-		return;
-
-	control = p_ext->saved_msi_config_space[i++] >> 16;
-	pci_write_config_word(dev, pos + PCI_MSI_FLAGS, control);
-	pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_LO,
-		p_ext->saved_msi_config_space[i++]);
-	if (control & PCI_MSI_FLAGS_64BIT) {
-		pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_HI,
-			p_ext->saved_msi_config_space[i++]);
-		pci_write_config_dword(dev, pos + PCI_MSI_DATA_64,
-			p_ext->saved_msi_config_space[i++]);
-	} else
-		pci_write_config_dword(dev, pos + PCI_MSI_DATA_32,
-			p_ext->saved_msi_config_space[i++]);
-	if (control & PCI_MSI_FLAGS_MASKBIT)
-		pci_write_config_dword(dev, pos + PCI_MSI_MASK_BIT,
-			p_ext->saved_msi_config_space[i++]);
-}
-
-static void pcie_portdrv_save_config(struct pci_dev *dev)
-{
-	struct pcie_port_device_ext *p_ext = pci_get_drvdata(dev);
-
-	pci_save_state(dev);
-	if (p_ext->interrupt_mode == PCIE_PORT_MSI_MODE)
-		pci_save_msi_state(dev);
+	return pci_save_state(dev);
 }
 
 static int pcie_portdrv_restore_config(struct pci_dev *dev)
 {
-	struct pcie_port_device_ext *p_ext = pci_get_drvdata(dev);
 	int retval;
 
 	pci_restore_state(dev);
-	if (p_ext->interrupt_mode == PCIE_PORT_MSI_MODE)
-		pci_restore_msi_state(dev);
 	retval = pci_enable_device(dev);
 	if (retval)
 		return retval;
@@ -149,7 +90,8 @@ static int pcie_portdrv_suspend (struct 
 {
 	int ret = pcie_port_device_suspend(dev, state);
 
-	pcie_portdrv_save_config(dev);
+	if (!ret)
+		ret = pcie_portdrv_save_config(dev);
 	return ret;
 }
 
_


