Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWGCAut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWGCAut (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 20:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWGCAuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 20:50:46 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:23516 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1750807AbWGCAuY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 20:50:24 -0400
Message-Id: <20060703004055.835863000@myri.com>
References: <20060703003959.942374000@myri.com>
User-Agent: quilt/0.45-1
Date: Sun, 02 Jul 2006 20:40:02 -0400
From: Brice Goglin <brice@myri.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org
Subject: [patch 3/7] Check root chipset no_msi flag instead of all parent busses flags
Content-Disposition: inline; filename=03-use_root_chipset_dev_no_msi_instead_of_pci_bus_flags.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MSI only requires support in the root chipset, which may not even have
a subordinate bus.
pci_msi_supported() now checks the no_msi flag in the root_chipset pci_dev
struct instead of the PCI_BUS_FLAGS_NO_MSI flag of all its parent busses.
The MSI quirk now sets the no_msi flag accordingly.

Signed-off-by: Brice Goglin <brice@myri.com>
---
 drivers/pci/msi.c    |   15 ++++++++++-----
 drivers/pci/quirks.c |   10 ++++------
 2 files changed, 14 insertions(+), 11 deletions(-)

Index: linux-git/drivers/pci/msi.c
===================================================================
--- linux-git.orig/drivers/pci/msi.c	2006-07-02 20:28:28.000000000 -0400
+++ linux-git/drivers/pci/msi.c	2006-07-02 20:28:58.000000000 -0400
@@ -905,19 +905,24 @@
  * @dev: pointer to the pci_dev data structure of MSI device function
  *
  * MSI must be globally enabled and supported by the device and
- * its parent busses.
+ * its root chipset.
  **/
 static
 int pci_msi_supported(struct pci_dev * dev)
 {
-	struct pci_bus *bus;
+	struct pci_dev *pdev;
 
 	if (!pci_msi_enable || !dev || dev->no_msi)
 		return -1;
 
-	for (bus = dev->bus; bus; bus = bus->parent)
-		if (bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
-			return -1;
+	/* find root complex for our device */
+	pdev = dev;
+	while (pdev->bus && pdev->bus->self)
+		pdev = pdev->bus->self;
+
+	/* check whether it supports MSI */
+	if (pdev->no_msi)
+		return -1;
 
 	return 0;
 }
Index: linux-git/drivers/pci/quirks.c
===================================================================
--- linux-git.orig/drivers/pci/quirks.c	2006-07-02 20:25:32.000000000 -0400
+++ linux-git/drivers/pci/quirks.c	2006-07-02 20:28:41.000000000 -0400
@@ -1508,12 +1508,10 @@
 /* Disable MSI on chipsets that are known to not support it */
 static void __devinit quirk_disable_msi(struct pci_dev *dev)
 {
-	if (dev->subordinate) {
-		printk(KERN_WARNING "PCI: MSI quirk detected. "
-		       "PCI_BUS_FLAGS_NO_MSI set for %s subordinate bus.\n",
-		       pci_name(dev));
-		dev->subordinate->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
-	}
+	printk(KERN_WARNING "PCI: MSI quirk detected. "
+	       "MSI disabled on chipset %s.\n",
+	       pci_name(dev));
+	dev->no_msi = 1;
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_BRIDGE, quirk_disable_msi);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_GCNB_LE,

