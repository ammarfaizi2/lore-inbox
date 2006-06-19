Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWFSBJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWFSBJA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 21:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWFSBJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 21:09:00 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:13214 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S932341AbWFSBI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 21:08:59 -0400
Date: Sun, 18 Jun 2006 21:08:56 -0400
From: Brice Goglin <brice@myri.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/8] Stop inheriting bus flags and check root chipset bus flags instead
Message-ID: <20060619010855.GE29950@myri.com>
References: <20060619010544.GA29950@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619010544.GA29950@myri.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 4/8] Stop inheriting bus flags and check root chipset bus flags instead

Inheriting bus flags requires to set them during the PCI hierarchy is
scanned, with EARLY or HEADER quirks. But the subordinate bus has not
been set at this point, so the bus flags cannot be set.

Signed-off-by: Brice Goglin <brice@myri.com>
---
 drivers/pci/msi.c   |   13 +++++++++----
 drivers/pci/probe.c |    2 +-
 include/linux/pci.h |    2 +-
 3 files changed, 11 insertions(+), 6 deletions(-)

Index: linux-mm/drivers/pci/probe.c
===================================================================
--- linux-mm.orig/drivers/pci/probe.c	2006-06-17 23:24:50.000000000 -0400
+++ linux-mm/drivers/pci/probe.c	2006-06-17 23:25:41.000000000 -0400
@@ -351,7 +351,7 @@
 	child->parent = parent;
 	child->ops = parent->ops;
 	child->sysdata = parent->sysdata;
-	child->bus_flags = parent->bus_flags;
+	child->bus_flags = 0;
 	child->bridge = get_device(&bridge->dev);
 
 	child->class_dev.class = &pcibus_class;
Index: linux-mm/include/linux/pci.h
===================================================================
--- linux-mm.orig/include/linux/pci.h	2006-06-17 23:24:51.000000000 -0400
+++ linux-mm/include/linux/pci.h	2006-06-17 23:25:41.000000000 -0400
@@ -242,7 +242,7 @@
 	char		name[48];
 
 	unsigned short  bridge_ctl;	/* manage NO_ISA/FBB/et al behaviors */
-	pci_bus_flags_t bus_flags;	/* Inherited by child busses */
+	pci_bus_flags_t bus_flags;
 	struct device		*bridge;
 	struct class_device	class_dev;
 	struct bin_attribute	*legacy_io; /* legacy I/O for this bus */
Index: linux-mm/drivers/pci/msi.c
===================================================================
--- linux-mm.orig/drivers/pci/msi.c	2006-06-17 23:24:50.000000000 -0400
+++ linux-mm/drivers/pci/msi.c	2006-06-17 23:25:41.000000000 -0400
@@ -911,14 +911,19 @@
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
+	/* check its bus flags */
+	if (pdev->subordinate->bus_flags & PCI_BUS_FLAGS_NO_MSI)
+		return -1;
 
 	return 0;
 }
