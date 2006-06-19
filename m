Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWFSBIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWFSBIK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 21:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWFSBIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 21:08:09 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:8862 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S932339AbWFSBII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 21:08:08 -0400
Date: Sun, 18 Jun 2006 21:08:04 -0400
From: Brice Goglin <brice@myri.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/8] Factorize common MSI detection code from pci_enable_msi() and msix()
Message-ID: <20060619010804.GC29950@myri.com>
References: <20060619010544.GA29950@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619010544.GA29950@myri.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pci_enable_msi() and pci_enable_msix() have to check same things
before enabling MSI. Factorize this code in pci_msi_supported().

Signed-off-by: Brice Goglin <brice@myri.com>
---
 drivers/pci/msi.c |   46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

Index: linux-mm/drivers/pci/msi.c
===================================================================
--- linux-mm.orig/drivers/pci/msi.c	2006-06-17 22:11:05.000000000 -0400
+++ linux-mm/drivers/pci/msi.c	2006-06-17 23:11:30.000000000 -0400
@@ -902,6 +902,28 @@
 }
 
 /**
+ * pci_msi_supported - check whether MSI may be enabled on device
+ * @dev: pointer to the pci_dev data structure of MSI device function
+ *
+ * Check parent busses for MSI flags, or disable except
+ * if forced.
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
@@ -913,19 +935,11 @@
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
+ 		return -EINVAL;
 
 	temp = dev->irq;
 
@@ -1135,22 +1149,14 @@
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
