Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVFVQGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVFVQGl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 12:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVFVQE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 12:04:57 -0400
Received: from fmr20.intel.com ([134.134.136.19]:55435 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261555AbVFVQBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 12:01:35 -0400
Date: Wed, 22 Jun 2005 09:09:54 -0700
From: long <tlnguyen@snoqualmie.dp.intel.com>
Message-Id: <200506221609.j5MG9svZ007179@snoqualmie.dp.intel.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] [ACPI]tg3 ethernet not coming back properly after S3 suspendon DellM70
Cc: acpi-devel@lists.sourceforge.net, gregkh@suse.de, shaohua@intel.com,
       tom.l.nguyen@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch, is based on kernel 2.6.12, provides a fix for PCIe
port bus driver suspend/resume.

Signed-off-by: T. Long Nguyen <tom.l.nguyen@intel.com>

--------------------------------------------------------------
diff -urpN linux-2.6.12/drivers/pci/pcie/portdrv_core.c patch-2.6.12-pcie-s3/drivers/pci/pcie/portdrv_core.c
--- linux-2.6.12/drivers/pci/pcie/portdrv_core.c	2005-06-17 15:48:29.000000000 -0400
+++ patch-2.6.12-pcie-s3/drivers/pci/pcie/portdrv_core.c	2005-06-21 09:25:18.000000000 -0400
@@ -278,10 +278,17 @@ int pcie_port_device_probe(struct pci_de
 
 int pcie_port_device_register(struct pci_dev *dev)
 {
+	struct pcie_port_device_ext *p_ext;
 	int status, type, capabilities, irq_mode, i;
 	int vectors[PCIE_PORT_DEVICE_MAXSERVICES];
 	u16 reg16;
 
+	/* Allocate port device extension */
+	if (!(p_ext = kmalloc(sizeof(struct pcie_port_device_ext), GFP_KERNEL)))
+		return -ENOMEM;
+		
+	pci_set_drvdata(dev, p_ext);
+
 	/* Get port type */
 	pci_read_config_word(dev, 
 		pci_find_capability(dev, PCI_CAP_ID_EXP) + 
@@ -291,6 +298,7 @@ int pcie_port_device_register(struct pci
 	/* Now get port services */
 	capabilities = get_port_device_capability(dev);
 	irq_mode = assign_interrupt_mode(dev, vectors, capabilities);
+	p_ext->interrupt_mode = irq_mode;
 
 	/* Allocate child services if any */
 	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
diff -urpN linux-2.6.12/drivers/pci/pcie/portdrv.h patch-2.6.12-pcie-s3/drivers/pci/pcie/portdrv.h
--- linux-2.6.12/drivers/pci/pcie/portdrv.h	2005-06-17 15:48:29.000000000 -0400
+++ patch-2.6.12-pcie-s3/drivers/pci/pcie/portdrv.h	2005-06-21 09:24:18.000000000 -0400
@@ -27,6 +27,11 @@
 
 #define get_descriptor_id(type, service) (((type - 4) << 4) | service)
 
+struct pcie_port_device_ext {
+	int interrupt_mode;	/* [0:INTx | 1:MSI | 2:MSI-X] */	
+	unsigned int saved_msi_config_space[5]; 
+};
+
 extern struct bus_type pcie_port_bus_type;
 extern int pcie_port_device_probe(struct pci_dev *dev);
 extern int pcie_port_device_register(struct pci_dev *dev);
diff -urpN linux-2.6.12/drivers/pci/pcie/portdrv_pci.c patch-2.6.12-pcie-s3/drivers/pci/pcie/portdrv_pci.c
--- linux-2.6.12/drivers/pci/pcie/portdrv_pci.c	2005-06-17 15:48:29.000000000 -0400
+++ patch-2.6.12-pcie-s3/drivers/pci/pcie/portdrv_pci.c	2005-06-21 09:25:48.000000000 -0400
@@ -29,6 +29,78 @@ MODULE_LICENSE("GPL");
 /* global data */
 static const char device_name[] = "pcieport-driver";
 
+static void pci_save_msi_state(struct pci_dev *dev)
+{
+	struct pcie_port_device_ext *p_ext = pci_get_drvdata(dev);
+	int i = 0, pos;
+	u16 control;
+
+   	if ((pos = pci_find_capability(dev, PCI_CAP_ID_MSI)) <= 0)
+		return;
+
+	pci_read_config_dword(dev, pos, &p_ext->saved_msi_config_space[i++]);
+	control = p_ext->saved_msi_config_space[0] >> 16;
+	pci_read_config_dword(dev, pos + PCI_MSI_ADDRESS_LO, 
+		&p_ext->saved_msi_config_space[i++]);
+	if (control & PCI_MSI_FLAGS_64BIT) {
+		pci_read_config_dword(dev, pos + PCI_MSI_ADDRESS_HI, 
+			&p_ext->saved_msi_config_space[i++]);
+		pci_read_config_dword(dev, pos + PCI_MSI_DATA_64, 
+			&p_ext->saved_msi_config_space[i++]);
+	} else 
+		pci_read_config_dword(dev, pos + PCI_MSI_DATA_32, 
+			&p_ext->saved_msi_config_space[i++]);
+	if (control & PCI_MSI_FLAGS_MASKBIT) 
+		pci_read_config_dword(dev, pos + PCI_MSI_MASK_BIT, 
+			&p_ext->saved_msi_config_space[i++]);
+}
+
+static void pci_restore_msi_state(struct pci_dev *dev)
+{
+	struct pcie_port_device_ext *p_ext = pci_get_drvdata(dev);
+	int i = 0, pos;
+	u16 control;
+
+   	if ((pos = pci_find_capability(dev, PCI_CAP_ID_MSI)) <= 0)
+		return;
+
+	control = p_ext->saved_msi_config_space[i++] >> 16;
+	pci_write_config_word(dev, pos + PCI_MSI_FLAGS, control);
+	pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_LO, 
+		p_ext->saved_msi_config_space[i++]);
+	if (control & PCI_MSI_FLAGS_64BIT) {
+		pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_HI, 
+			p_ext->saved_msi_config_space[i++]);
+		pci_write_config_dword(dev, pos + PCI_MSI_DATA_64, 
+			p_ext->saved_msi_config_space[i++]);
+	} else 
+		pci_write_config_dword(dev, pos + PCI_MSI_DATA_32, 
+			p_ext->saved_msi_config_space[i++]);
+	if (control & PCI_MSI_FLAGS_MASKBIT) 
+		pci_write_config_dword(dev, pos + PCI_MSI_MASK_BIT, 
+			p_ext->saved_msi_config_space[i++]);
+}
+
+static void pcie_portdrv_save_config(struct pci_dev *dev)
+{
+	struct pcie_port_device_ext *p_ext = pci_get_drvdata(dev);
+
+	pci_save_state(dev);	
+	if (p_ext->interrupt_mode == PCIE_PORT_MSI_MODE)
+		pci_save_msi_state(dev);
+}
+
+static void pcie_portdrv_restore_config(struct pci_dev *dev)
+{
+	struct pcie_port_device_ext *p_ext = pci_get_drvdata(dev);
+
+	pci_restore_state(dev);
+	if (p_ext->interrupt_mode == PCIE_PORT_MSI_MODE)
+		pci_restore_msi_state(dev);
+	pci_enable_device(dev);
+	pci_set_master(dev);
+}
+
 /*
  * pcie_portdrv_probe - Probe PCI-Express port devices
  * @dev: PCI-Express port device being probed
@@ -64,16 +136,21 @@ static int __devinit pcie_portdrv_probe 
 static void pcie_portdrv_remove (struct pci_dev *dev)
 {
 	pcie_port_device_remove(dev);
+	kfree(pci_get_drvdata(dev));
 }
 
 #ifdef CONFIG_PM
 static int pcie_portdrv_suspend (struct pci_dev *dev, pm_message_t state)
 {
-	return pcie_port_device_suspend(dev, state);
+	int ret = pcie_port_device_suspend(dev, state);
+
+	pcie_portdrv_save_config(dev);
+	return ret;
 }
 
 static int pcie_portdrv_resume (struct pci_dev *dev)
 {
+	pcie_portdrv_restore_config(dev);
 	return pcie_port_device_resume(dev);
 }
 #endif
