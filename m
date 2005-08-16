Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbVHPWQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbVHPWQm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 18:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbVHPWQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 18:16:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:11409 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750974AbVHPWQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 18:16:20 -0400
Date: Tue, 16 Aug 2005 15:15:58 -0700
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, kristen.c.accardi@intel.com
Subject: [patch 2/7] PCI: 6700/6702PXH quirk
Message-ID: <20050816221558.GC28619@kroah.com>
References: <20050816220001.699316000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pci-quirk-6700.patch"
In-Reply-To: <20050816221527.GA28619@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kristen Accardi <kristen.c.accardi@intel.com>

On the 6700/6702 PXH part, a MSI may get corrupted if an ACPI hotplug
driver and SHPC driver in MSI mode are used together.  This patch will
prevent MSI from being enabled for the SHPC as part of an early pci
quirk, as well as on any pci device which sets the no_msi bit.  

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/pci/msi.c       |    5 ++++-
 drivers/pci/pci.h       |    2 +-
 drivers/pci/quirks.c    |   21 +++++++++++++++++++++
 include/linux/pci.h     |    3 ++-
 include/linux/pci_ids.h |    5 +++++
 5 files changed, 33 insertions(+), 3 deletions(-)

--- gregkh-2.6.orig/drivers/pci/msi.c	2005-08-16 14:51:31.000000000 -0700
+++ gregkh-2.6/drivers/pci/msi.c	2005-08-16 14:57:12.000000000 -0700
@@ -453,7 +453,7 @@ static void enable_msi_mode(struct pci_d
 	}
 }
 
-static void disable_msi_mode(struct pci_dev *dev, int pos, int type)
+void disable_msi_mode(struct pci_dev *dev, int pos, int type)
 {
 	u16 control;
 
@@ -699,6 +699,9 @@ int pci_enable_msi(struct pci_dev* dev)
 	if (!pci_msi_enable || !dev)
  		return status;
 
+	if (dev->no_msi)
+		return status;
+
 	temp = dev->irq;
 
 	if ((status = msi_init()) < 0)
--- gregkh-2.6.orig/drivers/pci/pci.h	2005-08-16 14:51:31.000000000 -0700
+++ gregkh-2.6/drivers/pci/pci.h	2005-08-16 14:57:12.000000000 -0700
@@ -46,7 +46,7 @@ extern int pci_msi_quirk;
 #else
 #define pci_msi_quirk 0
 #endif
-
+void disable_msi_mode(struct pci_dev *dev, int pos, int type);
 extern int pcie_mch_quirk;
 extern struct device_attribute pci_dev_attrs[];
 extern struct class_device_attribute class_device_attr_cpuaffinity;
--- gregkh-2.6.orig/drivers/pci/quirks.c	2005-08-16 14:55:51.000000000 -0700
+++ gregkh-2.6/drivers/pci/quirks.c	2005-08-16 14:57:12.000000000 -0700
@@ -1291,6 +1291,27 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_IN
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7320_MCH,	quirk_pcie_mch );
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7525_MCH,	quirk_pcie_mch );
 
+
+/*
+ * It's possible for the MSI to get corrupted if shpc and acpi
+ * are used together on certain PXH-based systems.
+ */
+static void __devinit quirk_pcie_pxh(struct pci_dev *dev)
+{
+	disable_msi_mode(dev, pci_find_capability(dev, PCI_CAP_ID_MSI),
+					PCI_CAP_ID_MSI);
+	dev->no_msi = 1;
+
+	printk(KERN_WARNING "PCI: PXH quirk detected, "
+		"disabling MSI for SHPC device\n");
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXHD_0,	quirk_pcie_pxh);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXHD_1,	quirk_pcie_pxh);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXH_0,	quirk_pcie_pxh);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXH_1,	quirk_pcie_pxh);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXHV,	quirk_pcie_pxh);
+
+
 static void __devinit quirk_netmos(struct pci_dev *dev)
 {
 	unsigned int num_parallel = (dev->subsystem_device & 0xf0) >> 4;
--- gregkh-2.6.orig/include/linux/pci.h	2005-08-16 14:55:51.000000000 -0700
+++ gregkh-2.6/include/linux/pci.h	2005-08-16 14:57:37.000000000 -0700
@@ -556,7 +556,8 @@ struct pci_dev {
 	/* keep track of device state */
 	unsigned int	is_enabled:1;	/* pci_enable_device has been called */
 	unsigned int	is_busmaster:1; /* device is busmaster */
-	
+	unsigned int	no_msi:1;	/* device may not use msi */
+
 	u32		saved_config_space[16]; /* config space saved at suspend time */
 	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
 	int rom_attr_enabled;		/* has display of the rom attribute been enabled? */
--- gregkh-2.6.orig/include/linux/pci_ids.h	2005-08-16 14:51:31.000000000 -0700
+++ gregkh-2.6/include/linux/pci_ids.h	2005-08-16 14:57:12.000000000 -0700
@@ -2281,6 +2281,11 @@
 #define PCI_VENDOR_ID_INTEL		0x8086
 #define PCI_DEVICE_ID_INTEL_EESSC	0x0008
 #define PCI_DEVICE_ID_INTEL_21145	0x0039
+#define PCI_DEVICE_ID_INTEL_PXHD_0	0x0320
+#define PCI_DEVICE_ID_INTEL_PXHD_1	0x0321
+#define PCI_DEVICE_ID_INTEL_PXH_0	0x0329
+#define PCI_DEVICE_ID_INTEL_PXH_1	0x032A
+#define PCI_DEVICE_ID_INTEL_PXHV	0x032C
 #define PCI_DEVICE_ID_INTEL_82375	0x0482
 #define PCI_DEVICE_ID_INTEL_82424	0x0483
 #define PCI_DEVICE_ID_INTEL_82378	0x0484

--
