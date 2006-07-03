Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWGCAvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWGCAvV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 20:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWGCAux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 20:50:53 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:23004 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1750775AbWGCAuY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 20:50:24 -0400
Message-Id: <20060703004055.613299000@myri.com>
References: <20060703003959.942374000@myri.com>
User-Agent: quilt/0.45-1
Date: Sun, 02 Jul 2006 20:40:01 -0400
From: Brice Goglin <brice@myri.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2/7] Factorize common MSI detection code from pci_enable_msi() and msix()
Content-Disposition: inline; filename=02-factorize_pci_msi_supported.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pci_enable_msi() and pci_enable_msix() have to check same things
before enabling MSI. Factorize this code in pci_msi_supported().

Signed-off-by: Brice Goglin <brice@myri.com>
---
 drivers/pci/msi.c |   46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

Index: linux-git/drivers/pci/msi.c
===================================================================
--- linux-git.orig/drivers/pci/msi.c	2006-07-02 20:39:11.000000000 -0400
+++ linux-git/drivers/pci/msi.c	2006-07-02 20:39:20.000000000 -0400
@@ -901,6 +901,28 @@
 }
 
 /**
+ * pci_msi_supported - check whether MSI may be enabled on device
+ * @dev: pointer to the pci_dev data structure of MSI device function
+ *
+ * MSI must be globally enabled and supported by the device and
+ * its parent busses.
+ **/
+static
+int pci_msi_supported(struct pci_dev * dev)
+{
+	struct pci_bus *bus;
+
+	if (!pci_msi_enable || !dev || dev->no_msi)
+		return -1;
+
+	for (bus = dev->bus; bus; bus = bus->parent)
+		if (bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
+			return -1;
+
+	return 0;
+}
+
+/**
  * pci_enable_msi - configure device's MSI capability structure
  * @dev: pointer to the pci_dev data structure of MSI device function
  *
@@ -912,19 +934,11 @@
  **/
 int pci_enable_msi(struct pci_dev* dev)
 {
-	struct pci_bus *bus;
-	int pos, temp, status = -EINVAL;
+	int pos, temp, status;
 	u16 control;
 
-	if (!pci_msi_enable || !dev)
- 		return status;
-
-	if (dev->no_msi)
-		return status;
-
-	for (bus = dev->bus; bus; bus = bus->parent)
-		if (bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
-			return -EINVAL;
+	if (pci_msi_supported(dev) < 0)
+		return -EINVAL;
 
 	temp = dev->irq;
 
@@ -1134,22 +1148,14 @@
  **/
 int pci_enable_msix(struct pci_dev* dev, struct msix_entry *entries, int nvec)
 {
-	struct pci_bus *bus;
 	int status, pos, nr_entries, free_vectors;
 	int i, j, temp;
 	u16 control;
 	unsigned long flags;
 
-	if (!pci_msi_enable || !dev || !entries)
+	if (!entries || pci_msi_supported(dev) < 0)
  		return -EINVAL;
 
-	if (dev->no_msi)
-		return -EINVAL;
-
-	for (bus = dev->bus; bus; bus = bus->parent)
-		if (bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
-			return -EINVAL;
-
 	status = msi_init();
 	if (status < 0)
 		return status;

