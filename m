Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWFSBJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWFSBJT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 21:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWFSBJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 21:09:19 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:15262 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S932340AbWFSBJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 21:09:17 -0400
Date: Sun, 18 Jun 2006 21:09:14 -0400
From: Brice Goglin <brice@myri.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/8] Whitelist non-PCI-E chipsets that are known to support MSI
Message-ID: <20060619010913.GF29950@myri.com>
References: <20060619010544.GA29950@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619010544.GA29950@myri.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 5/8] Whitelist non-PCI-E chipsets that are known to support MSI

With MSI being disabled by default on non-PCI-E chipsets, we have
to explicitely whitelist chipsets that support MSI and set the
PCI_BUS_FLAGS_MSI flag.
Add a generic quirk quirk_msi_supported() to do so, and enable it
for all Intel chipsets.

Signed-off-by: Brice Goglin <brice@myri.com>
---
 drivers/pci/quirks.c |   12 ++++++++++++
 include/linux/pci.h  |    1 +
 2 files changed, 13 insertions(+)

Index: linux-mm/drivers/pci/quirks.c
===================================================================
--- linux-mm.orig/drivers/pci/quirks.c	2006-06-17 23:07:41.000000000 -0400
+++ linux-mm/drivers/pci/quirks.c	2006-06-17 23:11:01.000000000 -0400
@@ -1556,6 +1556,18 @@
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	0x1460,		quirk_p64h2_1k_io);
 
+/* Mark MSI bus flags on chipset that are known to support it */
+static void __devinit quirk_msi_supported(struct pci_dev *dev)
+{
+	if (dev->subordinate) {
+		printk(KERN_WARNING "PCI: MSI quirk detected. "
+		       "PCI_BUS_FLAGS_MSI set for %s subordinate bus.\n",
+		       pci_name(dev));
+		dev->subordinate->bus_flags |= PCI_BUS_FLAGS_MSI;
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_ANY_ID, quirk_msi_supported);
+
 /* Returns 1 if the HT MSI capability is found and enabled */
 static pci_bus_flags_t __devinit msi_ht_cap_enabled(struct pci_dev *dev)
 {
Index: linux-mm/include/linux/pci.h
===================================================================
--- linux-mm.orig/include/linux/pci.h	2006-06-17 22:11:04.000000000 -0400
+++ linux-mm/include/linux/pci.h	2006-06-17 23:11:30.000000000 -0400
@@ -97,6 +97,7 @@
 typedef unsigned short __bitwise pci_bus_flags_t;
 enum pci_bus_flags {
 	PCI_BUS_FLAGS_NO_MSI = (__force pci_bus_flags_t) 1,
+	PCI_BUS_FLAGS_MSI = (__force pci_bus_flags_t) 2,
 };
 
 struct pci_cap_saved_state {
