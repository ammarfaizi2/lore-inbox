Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262617AbVGAU5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbVGAU5s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 16:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbVGAU5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 16:57:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:51169 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262720AbVGAUtj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 16:49:39 -0400
Cc: tlnguyen@snoqualmie.dp.intel.com
Subject: [PATCH] PCI: acpi tg3 ethernet not coming back properly after S3 suspendon DellM70
In-Reply-To: <11202509121295@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Jul 2005 13:48:32 -0700
Message-Id: <11202509124001@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: acpi tg3 ethernet not coming back properly after S3 suspendon DellM70

This patch, is based on kernel 2.6.12, provides a fix for PCIe
port bus driver suspend/resume.

Signed-off-by: T. Long Nguyen <tom.l.nguyen@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 5823d100ae260d022b4dd5ec9cc0b85f0bf0d646
tree 20cb85773cb51eed009a8b0f4646ebc4db7c293a
parent a00db371624e2e3718e5ab7d73bf364681098106
author long <tlnguyen@snoqualmie.dp.intel.com> Wed, 22 Jun 2005 09:09:54 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 01 Jul 2005 13:35:51 -0700

 drivers/pci/pcie/portdrv.h      |    5 ++
 drivers/pci/pcie/portdrv_core.c |    8 ++++
 drivers/pci/pcie/portdrv_pci.c  |   79 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
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
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -275,10 +275,17 @@ int pcie_port_device_probe(struct pci_de
 
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
@@ -288,6 +295,7 @@ int pcie_port_device_register(struct pci
 	/* Now get port services */
 	capabilities = get_port_device_capability(dev);
 	irq_mode = assign_interrupt_mode(dev, vectors, capabilities);
+	p_ext->interrupt_mode = irq_mode;
 
 	/* Allocate child services if any */
 	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
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

