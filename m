Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWGCAuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWGCAuW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 20:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWGCAuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 20:50:22 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:21468 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1750777AbWGCAuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 20:50:20 -0400
Message-Id: <20060703004055.344041000@myri.com>
References: <20060703003959.942374000@myri.com>
User-Agent: quilt/0.45-1
Date: Sun, 02 Jul 2006 20:40:00 -0400
From: Brice Goglin <brice@myri.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org
Subject: [patch 1/7] Merge existing MSI disabling quirks
Content-Disposition: inline; filename=01-merge_msi_disabling_quirks.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Merge existing MSI disabling quirks into a generic one that we will
use to blacklist all MSI-broken chipsets.
By the way, print the bus id of the device.

Signed-off-by: Brice Goglin <brice@myri.com>
---
 drivers/pci/quirks.c |   29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

Index: linux-git/drivers/pci/quirks.c
===================================================================
--- linux-git.orig/drivers/pci/quirks.c	2006-07-02 11:16:08.000000000 -0400
+++ linux-git/drivers/pci/quirks.c	2006-07-02 11:24:07.000000000 -0400
@@ -585,12 +585,6 @@
 { 
         unsigned char revid, tmp;
         
-	if (dev->subordinate) {
-		printk(KERN_WARNING "PCI: MSI quirk detected. "
-		       "PCI_BUS_FLAGS_NO_MSI set for subordinate bus.\n");
-		dev->subordinate->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
-	}
-
         if (nr_ioapics == 0) 
                 return;
 
@@ -603,13 +597,6 @@
         }
 } 
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_BRIDGE, quirk_amd_8131_ioapic);
-
-static void __init quirk_svw_msi(struct pci_dev *dev)
-{
-	pci_msi_quirk = 1;
-	printk(KERN_WARNING "PCI: MSI quirk detected. pci_msi_quirk set.\n");
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_GCNB_LE, quirk_svw_msi );
 #endif /* CONFIG_X86_IO_APIC */
 
 
@@ -1517,6 +1504,22 @@
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA,  PCI_DEVICE_ID_NVIDIA_CK804_PCIE,
 			quirk_nvidia_ck804_pcie_aer_ext_cap);
 
+#ifdef CONFIG_PCI_MSI
+/* Disable MSI on chipsets that are known to not support it */
+static void __devinit quirk_disable_msi(struct pci_dev *dev)
+{
+	if (dev->subordinate) {
+		printk(KERN_WARNING "PCI: MSI quirk detected. "
+		       "PCI_BUS_FLAGS_NO_MSI set for %s subordinate bus.\n",
+		       pci_name(dev));
+		dev->subordinate->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_BRIDGE, quirk_disable_msi);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_GCNB_LE,
+			quirk_disable_msi);
+#endif /* CONFIG_PCI_MSI */
+
 EXPORT_SYMBOL(pcie_mch_quirk);
 #ifdef CONFIG_HOTPLUG
 EXPORT_SYMBOL(pci_fixup_device);

