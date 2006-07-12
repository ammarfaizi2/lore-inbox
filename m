Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbWGLP7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbWGLP7L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 11:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWGLP7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 11:59:11 -0400
Received: from fmr18.intel.com ([134.134.136.17]:36745 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751429AbWGLP7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 11:59:09 -0400
Date: Wed, 12 Jul 2006 08:59:00 -0700
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, mochel@linux.intel.com,
       rajesh.shah@intel.com, arjan@linux.intel.com
Subject: [patch] pci: PCIE power management quirk
Message-Id: <20060712085900.b2a9fd70.kristen.c.accardi@intel.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.19; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When changing power states from D0->DX and then from DX->D0, some
Intel PCIE chipsets will cause a device reset to occur.  This will
cause problems for any D State other than D3, since any state 
information that the driver will expect to be present coming from
a D1 or D2 state will have been cleared.  This patch addes a 
flag to the pci_dev structure to indicate that devices should
not use states D1 or D2, and will set that flag for the affected
chipsets.  This patch also modifies pci_set_power_state() so that
when a device driver tries to set the power state on
a device that is downstream from an affected chipset, or on one
of the affected devices it only allows state changes to or
from D0 & D3.  In addition, this patch allows the delay time
between D3->D0 to be changed via a quirk.  These chipsets also
need additional time to change states beyond the normal 10ms.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

---
 drivers/pci/pci.c    |   11 ++++++++++-
 drivers/pci/pci.h    |   10 +++++++++-
 drivers/pci/quirks.c |   31 +++++++++++++++++++++++++++++++
 include/linux/pci.h  |    1 +
 4 files changed, 51 insertions(+), 2 deletions(-)

--- 2.6-git.orig/drivers/pci/pci.c
+++ 2.6-git/drivers/pci/pci.c
@@ -19,6 +19,7 @@
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
 #include "pci.h"
 
+unsigned int pci_pm_d3_delay = 10;
 
 /**
  * pci_bus_max_busnr - returns maximum PCI bus number of given bus' children
@@ -313,6 +314,14 @@ pci_set_power_state(struct pci_dev *dev,
 	} else if (dev->current_state == state)
 		return 0;        /* we're already there */
 
+	/*
+	 * If the device or the parent bridge can't support PCI PM, ignore
+	 * the request if we're doing anything besides putting it into D0
+	 * (which would only happen on boot).
+	 */
+	if ((state == PCI_D1 || state == PCI_D2) && pci_no_d1d2(dev))
+		return 0;
+
 	/* find PCI PM capability in list */
 	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
 	
@@ -363,7 +372,7 @@ pci_set_power_state(struct pci_dev *dev,
 	/* Mandatory power management transition delays */
 	/* see PCI PM 1.1 5.6.1 table 18 */
 	if (state == PCI_D3hot || dev->current_state == PCI_D3hot)
-		msleep(10);
+		msleep(pci_pm_d3_delay);
 	else if (state == PCI_D2 || dev->current_state == PCI_D2)
 		udelay(200);
 
--- 2.6-git.orig/drivers/pci/pci.h
+++ 2.6-git/drivers/pci/pci.h
@@ -47,7 +47,7 @@ extern int pci_msi_quirk;
 #else
 #define pci_msi_quirk 0
 #endif
-
+extern unsigned int pci_pm_d3_delay;
 #ifdef CONFIG_PCI_MSI
 void disable_msi_mode(struct pci_dev *dev, int pos, int type);
 void pci_no_msi(void);
@@ -66,7 +66,15 @@ static inline int pci_save_msix_state(st
 static inline void pci_restore_msi_state(struct pci_dev *dev) {}
 static inline void pci_restore_msix_state(struct pci_dev *dev) {}
 #endif
+static inline int pci_no_d1d2(struct pci_dev *dev)
+{
+	unsigned int parent_dstates = 0;
 
+	if (dev->bus->self)
+		parent_dstates = dev->bus->self->no_d1d2;
+	return (dev->no_d1d2 || parent_dstates);
+
+}
 extern int pcie_mch_quirk;
 extern struct device_attribute pci_dev_attrs[];
 extern struct class_device_attribute class_device_attr_cpuaffinity;
--- 2.6-git.orig/drivers/pci/quirks.c
+++ 2.6-git/drivers/pci/quirks.c
@@ -1341,6 +1341,37 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_IN
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXH_1,	quirk_pcie_pxh);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXHV,	quirk_pcie_pxh);
 
+/*
+ * Some Intel PCI Express chipsets have trouble with downstream
+ * device power management.
+ */
+static void quirk_intel_pcie_pm(struct pci_dev * dev)
+{
+	pci_pm_d3_delay = 120;
+	dev->no_d1d2 = 1;
+}
+
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x25e2, quirk_intel_pcie_pm);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x25e3, quirk_intel_pcie_pm);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x25e4, quirk_intel_pcie_pm);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x25e5, quirk_intel_pcie_pm);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x25e6, quirk_intel_pcie_pm);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x25e7, quirk_intel_pcie_pm);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x25f7, quirk_intel_pcie_pm);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x25f8, quirk_intel_pcie_pm);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x25f9, quirk_intel_pcie_pm);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x25fa, quirk_intel_pcie_pm);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x2601, quirk_intel_pcie_pm);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x2602, quirk_intel_pcie_pm);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x2603, quirk_intel_pcie_pm);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x2604, quirk_intel_pcie_pm);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x2605, quirk_intel_pcie_pm);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x2606, quirk_intel_pcie_pm);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x2607, quirk_intel_pcie_pm);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x2608, quirk_intel_pcie_pm);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x2609, quirk_intel_pcie_pm);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x260a, quirk_intel_pcie_pm);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x260b, quirk_intel_pcie_pm);
 
 /*
  * Fixup the cardbus bridges on the IBM Dock II docking station
--- 2.6-git.orig/include/linux/pci.h
+++ 2.6-git/include/linux/pci.h
@@ -161,6 +161,7 @@ struct pci_dev {
 	unsigned int	is_enabled:1;	/* pci_enable_device has been called */
 	unsigned int	is_busmaster:1; /* device is busmaster */
 	unsigned int	no_msi:1;	/* device may not use msi */
+	unsigned int	no_d1d2:1;   /* only allow d0 or d3 */
 	unsigned int	block_ucfg_access:1;	/* userspace config space access is blocked */
 	unsigned int	broken_parity_status:1;	/* Device generates false positive parity */
 	unsigned int 	msi_enabled:1;
