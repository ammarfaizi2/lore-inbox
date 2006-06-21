Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751927AbWFUCbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbWFUCbq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 22:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWFUCbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 22:31:46 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:65278 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1751929AbWFUCbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 22:31:45 -0400
Date: Tue, 20 Jun 2006 22:31:42 -0400
From: Brice Goglin <brice@myri.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] Merge existing MSI disabling quirks
Message-ID: <20060621023141.GA16292@myri.com>
References: <20060621023104.GA16271@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621023104.GA16271@myri.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 1/6] Merge existing MSI disabling quirks

Merge existing MSI disabling quirks into a generic one that we will
use to blacklist all MSI-broken chipsets.
By the way, print the bus id of the device.

Signed-off-by: Brice Goglin <brice@myri.com>
---
 drivers/pci/quirks.c |   29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

Index: linux-mm/drivers/pci/quirks.c
===================================================================
--- linux-mm.orig/drivers/pci/quirks.c	2006-06-20 22:02:02.000000000 -0400
+++ linux-mm/drivers/pci/quirks.c	2006-06-20 22:03:53.000000000 -0400
@@ -586,12 +586,6 @@
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
 
@@ -604,13 +598,6 @@
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
 
 
@@ -1556,6 +1543,22 @@
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	0x1460,		quirk_p64h2_1k_io);
 
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
