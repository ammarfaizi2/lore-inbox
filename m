Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965207AbVKPDWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965207AbVKPDWe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 22:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965209AbVKPDWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 22:22:34 -0500
Received: from peabody.ximian.com ([130.57.169.10]:3288 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S965207AbVKPDWc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 22:22:32 -0500
Subject: [RFC][PATCH 2/6] PCI PM: capability probing and setup
From: Adam Belay <abelay@novell.com>
To: Linux-pm mailing list <linux-pm@lists.osdl.org>, Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 15 Nov 2005 22:31:17 -0500
Message-Id: <1132111878.9809.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the PCI subsystem to probe the PCI capability
registers in one pass.  This data is stored in "struct pci_dev_pm".  As
a result, we can avoid having to redetect PCI PM support in every PM
related call.  Also, we don't have to access PCI config space as often.

"struct pci_dev_pm" will likely be expanded to include PM accounting
data in the near future.


--- a/drivers/pci/pm.c	2005-11-07 08:08:00.000000000 -0500
+++ b/drivers/pci/pm.c	2005-11-07 08:09:11.000000000 -0500
@@ -294,3 +294,60 @@
 }
 
 EXPORT_SYMBOL(pci_enable_wake);
+
+
+/*
+ * PCI PM capability detection and setup
+ */
+
+int pci_setup_device_pm(struct pci_dev *dev)
+{
+	int pm;
+	u16 pmcsr, pmc;
+	struct pci_dev_pm *pm_data;
+
+	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
+	if (!pm) {
+		dev->current_state = PCI_D0;
+		return 0;
+	}
+
+	pci_read_config_word(dev,pm + PCI_PM_PMC,&pmc);
+
+	if ((pmc & PCI_PM_CAP_VER_MASK) > 3) {
+		printk(KERN_DEBUG
+		       "PCI: %s has unsupported PM cap regs version (%u)\n",
+		       pci_name(dev), pmc & PCI_PM_CAP_VER_MASK);
+		return -EIO;
+	}
+
+	dev->pm = pm_data = kmalloc(sizeof(struct pci_dev_pm), GFP_KERNEL);
+	if (!pm_data)
+		return -ENOMEM;
+
+	memset(pm_data, 0, sizeof(struct pci_dev_pm));
+
+	pm_data->pm_offset = pm;
+
+	/* determine supported device states */
+	/* all PM capable devices support at least D0 and D3 */
+	pm_data->state_mask |= ((1 << PCI_D0) | (1 << PCI_D3hot));
+	if (pmc & PCI_PM_CAP_D1)
+		pm_data->state_mask |= (1 << PCI_D1);
+	if (pmc & PCI_PM_CAP_D2)
+		pm_data->state_mask |= (1 << PCI_D2);
+
+	/* PME capabilities */
+	pm_data->pme_mask = ((pmc & PCI_PM_CAP_PME_MASK)
+			 >> (ffs(PCI_PM_CAP_PME_MASK) - 1));
+
+	pci_read_config_word(dev, pm + PCI_PM_CTRL, &pmcsr);
+
+	/* device context retention */
+	pm_data->dsi = (pmc & PCI_PM_CAP_DSI) ? 1 : 0;
+	pm_data->no_soft_reset = (pmcsr & PCI_PM_CTRL_NO_SOFT_RESET) ? 1 : 0;
+
+	dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
+
+	return 0;
+}
--- a/drivers/pci/probe.c	2005-11-07 08:08:00.000000000 -0500
+++ b/drivers/pci/probe.c	2005-11-07 08:05:10.000000000 -0500
@@ -601,8 +601,7 @@
 	pr_debug("PCI: Found %s [%04x/%04x] %06x %02x\n", pci_name(dev),
 		 dev->vendor, dev->device, class, dev->hdr_type);
 
-	/* "Unknown power state" */
-	dev->current_state = PCI_UNKNOWN;
+	pci_setup_device_pm(dev);
 
 	/* Early fixups, before probing the BARs */
 	pci_fixup_device(pci_fixup_early, dev);
--- a/include/linux/pci.h	2005-11-07 08:08:00.000000000 -0500
+++ b/include/linux/pci.h	2005-11-07 08:02:55.000000000 -0500
@@ -68,6 +68,18 @@
 #define DEVICE_COUNT_COMPATIBLE	4
 #define DEVICE_COUNT_RESOURCE	12
 
+struct pci_dev_pm {
+	unsigned int	pm_offset;	/* the PCI PM capability offset */
+
+	unsigned int	dsi:1;		/* vendor-specific initialization needed
+					   after a reset */
+	unsigned int	no_soft_reset:1; /* PCI config context retained when
+					    going from D3_hot to D0 */
+
+	unsigned char	state_mask;	/* a mask of supported power states */
+	unsigned char	pme_mask;	/* a mask of power states that allow #PME */ 
+};
+
 typedef int __bitwise pci_power_t;
 
 #define PCI_D0		((pci_power_t __force) 0)
@@ -78,6 +90,12 @@
 #define PCI_UNKNOWN	((pci_power_t __force) 5)
 #define PCI_POWER_ERROR	((pci_power_t __force) -1)
 
+#define PCI_PME_D0	0x01;
+#define PCI_PME_D1	0x02;
+#define PCI_PME_D2	0x04;
+#define PCI_PME_D3hot	0x08;
+#define PCI_PME_D3cold	0x10;
+
 /*
  * The pci_dev structure is used to describe PCI devices.
  */
@@ -106,6 +124,7 @@
 					   this if your device has broken DMA
 					   or supports 64-bit transfers.  */
 
+	struct pci_dev_pm *pm;		/* power management information */
 	pci_power_t     current_state;  /* Current operating state. In ACPI-speak,
 					   this is D0-D3, D0 being fully functional,
 					   and D3 being off. */


