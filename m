Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750756AbWFEIet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWFEIet (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 04:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWFEIes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 04:34:48 -0400
Received: from peabody.ximian.com ([130.57.169.10]:20366 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1750771AbWFEIen
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 04:34:43 -0400
Subject: [PATCH 2/9] PCI PM: generic capability detection
From: Adam Belay <abelay@novell.com>
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Type: text/plain
Date: Mon, 05 Jun 2006 04:45:50 -0400
Message-Id: <1149497150.7831.156.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces some infrastructure to detect the PCI PM
capability and record which features are available.  "struct pci_dev_pm"
is introduced to hold power management related data, and is dynamically
allocated when power management support is detected.  The correct value
for "pci_dev->current_state" is also recorded.

Signed-off-by: Adam Belay <abelay@novell.com>

---
 b/drivers/pci/pm.c    |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++
 b/drivers/pci/probe.c |    3 --
 b/include/linux/pci.h |   19 ++++++++++++++++
 drivers/pci/pci.h     |    2 +
 4 files changed, 78 insertions(+), 2 deletions(-)

diff -urN a/drivers/pci/pm.c b/drivers/pci/pm.c
--- a/drivers/pci/pm.c	2006-06-01 22:13:49.000000000 -0400
+++ b/drivers/pci/pm.c	2006-06-01 22:11:39.000000000 -0400
@@ -307,3 +307,59 @@
 }
 
 EXPORT_SYMBOL(pci_enable_wake);
+
+
+/*
+ * Detection and Setup
+ */
+
+/**
+ * pci_setup_device_pm - prepares a device for PCI power management features
+ * @dev: the device to prepare
+ */
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
+	pm_data->pm_offset = pm;
+
+	/* determine supported device states
+	 * -- all PM capable devices support at least D0 and D3 */
+	pm_data->D1_supported = (pmc & PCI_PM_CAP_D1) ? 1 : 0;
+	pm_data->D2_supported = (pmc & PCI_PM_CAP_D2) ? 1 : 0;
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
diff -urN a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	2006-06-01 22:13:49.000000000 -0400
+++ b/drivers/pci/probe.c	2006-05-31 20:44:18.000000000 -0400
@@ -646,8 +646,7 @@
 	pr_debug("PCI: Found %s [%04x/%04x] %06x %02x\n", pci_name(dev),
 		 dev->vendor, dev->device, class, dev->hdr_type);
 
-	/* "Unknown power state" */
-	dev->current_state = PCI_UNKNOWN;
+	pci_setup_device_pm(dev);
 
 	/* Early fixups, before probing the BARs */
 	pci_fixup_device(pci_fixup_early, dev);
diff -urN a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2006-06-01 22:13:49.000000000 -0400
+++ b/include/linux/pci.h	2006-06-01 22:12:13.000000000 -0400
@@ -68,6 +68,16 @@
 #define DEVICE_COUNT_COMPATIBLE	4
 #define DEVICE_COUNT_RESOURCE	12
 
+struct pci_dev_pm {
+	unsigned int	pm_offset;	/* the PCI PM capability offset */
+
+	unsigned char	dsi:1;		/* vendor-specific initilization needed after a reset */
+	unsigned char	no_soft_reset:1;/* PCI config context retained when going from D3_hot to D0 */
+	unsigned char	D1_supported:1;	/* does the device allow D1? */
+	unsigned char	D2_supported:1;	/* does the device allow D2? */
+	unsigned char	pme_mask;	/* a mask of power states that allow #PME */
+};
+
 typedef int __bitwise pci_power_t;
 
 #define PCI_D0		((pci_power_t __force) 0)
@@ -78,6 +88,14 @@
 #define PCI_UNKNOWN	((pci_power_t __force) 5)
 #define PCI_POWER_ERROR	((pci_power_t __force) -1)
 
+typedef int __bitwise pci_wake_t;
+
+#define PCI_PME_D0	((pci_wake_t __force) 0x01)
+#define PCI_PME_D1	((pci_wake_t __force) 0x02)
+#define PCI_PME_D2	((pci_wake_t __force) 0x04)
+#define PCI_PME_D3hot	((pci_wake_t __force) 0x08)
+#define PCI_PME_D3cold	((pci_wake_t __force) 0x10)
+
 /** The pci_channel state describes connectivity between the CPU and
  *  the pci device.  If some PCI bus between here and the pci device
  *  has crashed or locked up, this info is reflected here.
@@ -135,6 +153,7 @@
 					   this if your device has broken DMA
 					   or supports 64-bit transfers.  */
 
+	struct pci_dev_pm *pm;		/* power management information */
 	pci_power_t     current_state;  /* Current operating state. In ACPI-speak,
 					   this is D0-D3, D0 being fully functional,
 					   and D3 being off. */
--- a/drivers/pci/pci.h	2006-05-30 21:41:14.000000000 -0400
+++ b/drivers/pci/pci.h	2006-06-01 22:33:57.000000000 -0400
@@ -67,6 +67,8 @@
 static inline void pci_restore_msix_state(struct pci_dev *dev) {}
 #endif
 
+extern int pci_setup_device_pm(struct pci_dev *dev);
+
 extern int pcie_mch_quirk;
 extern struct device_attribute pci_dev_attrs[];
 extern struct class_device_attribute class_device_attr_cpuaffinity;


