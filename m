Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWIAQCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWIAQCv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 12:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWIAQCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 12:02:43 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:23193 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932277AbWIAQCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 12:02:32 -0400
Date: Fri, 1 Sep 2006 11:02:22 -0500 (CDT)
From: John Keller <jpk@sgi.com>
To: linux-ia64@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, ayoung@sgi.com, linux-kernel@vger.kernel.org,
       John Keller <jpk@sgi.com>, pcihpd-discuss@lists.sourceforge.net
Message-Id: <20060901160222.32120.99445.48436@attica.americas.sgi.com>
Subject: [PATCH 3/3] - Altix: Initial ACPI support - ROM shadowing.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Support a shadowed ROM when running with an ACPI capable PROM.

Define a new dev.resource flag IORESOURCE_ROM_BIOS_COPY to
describe the case of a BIOS shadowed ROM, which can then
be used to avoid pci_map_rom() making an unneeded call to
pci_enable_rom().


Signed-off-by: John Keller <jpk@sgi.com>

 arch/ia64/sn/kernel/io_acpi_init.c |   33 +++++++++++++++++++++++++++++++++
 arch/ia64/sn/kernel/io_common.c    |    5 +++--
 arch/ia64/sn/kernel/io_init.c      |    3 +++
 drivers/pci/rom.c                  |    9 ++++++---
 include/linux/ioport.h             |    1 +
 5 files changed, 46 insertions(+), 5 deletions(-)


Index: linux-2.6/arch/ia64/sn/kernel/io_common.c
===================================================================
--- linux-2.6.orig/arch/ia64/sn/kernel/io_common.c	2006-08-31 16:07:39.070573026 -0500
+++ linux-2.6/arch/ia64/sn/kernel/io_common.c	2006-08-31 16:09:00.764554984 -0500
@@ -286,9 +286,10 @@ void sn_pci_fixup_slot(struct pci_dev *d
 	list_add_tail(&pcidev_info->pdi_list,
 		      &(SN_PLATFORM_DATA(dev->bus)->pcidev_info));
 
-	if (!SN_ACPI_BASE_SUPPORT())
+	if (SN_ACPI_BASE_SUPPORT())
+		sn_acpi_slot_fixup(dev, pcidev_info);
+	else
 		sn_more_slot_fixup(dev, pcidev_info);
-
 	/*
 	 * Using the PROMs values for the PCI host bus, get the Linux
  	 * PCI host_pci_dev struct and set up host bus linkages
Index: linux-2.6/drivers/pci/rom.c
===================================================================
--- linux-2.6.orig/drivers/pci/rom.c	2006-08-31 16:07:39.074573515 -0500
+++ linux-2.6/drivers/pci/rom.c	2006-08-31 16:09:00.764554984 -0500
@@ -77,7 +77,8 @@ void __iomem *pci_map_rom(struct pci_dev
 		start = (loff_t)0xC0000;
 		*size = 0x20000; /* cover C000:0 through E000:0 */
 	} else {
-		if (res->flags & IORESOURCE_ROM_COPY) {
+		if (res->flags &
+			(IORESOURCE_ROM_COPY | IORESOURCE_ROM_BIOS_COPY)) {
 			*size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
 			return (void __iomem *)(unsigned long)
 				pci_resource_start(pdev, PCI_ROM_RESOURCE);
@@ -161,7 +162,8 @@ void __iomem *pci_map_rom_copy(struct pc
 	if (!rom)
 		return NULL;
 
-	if (res->flags & (IORESOURCE_ROM_COPY | IORESOURCE_ROM_SHADOW))
+	if (res->flags & (IORESOURCE_ROM_COPY | IORESOURCE_ROM_SHADOW |
+			  IORESOURCE_ROM_BIOS_COPY))
 		return rom;
 
 	res->start = (unsigned long)kmalloc(*size, GFP_KERNEL);
@@ -187,7 +189,7 @@ void pci_unmap_rom(struct pci_dev *pdev,
 {
 	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
 
-	if (res->flags & IORESOURCE_ROM_COPY)
+	if (res->flags & (IORESOURCE_ROM_COPY | IORESOURCE_ROM_BIOS_COPY))
 		return;
 
 	iounmap(rom);
@@ -211,6 +213,7 @@ void pci_remove_rom(struct pci_dev *pdev
 		sysfs_remove_bin_file(&pdev->dev.kobj, pdev->rom_attr);
 	if (!(res->flags & (IORESOURCE_ROM_ENABLE |
 			    IORESOURCE_ROM_SHADOW |
+			    IORESOURCE_ROM_BIOS_COPY |
 			    IORESOURCE_ROM_COPY)))
 		pci_disable_rom(pdev);
 }
Index: linux-2.6/include/linux/ioport.h
===================================================================
--- linux-2.6.orig/include/linux/ioport.h	2006-08-31 16:07:39.074573515 -0500
+++ linux-2.6/include/linux/ioport.h	2006-08-31 16:09:00.768555473 -0500
@@ -89,6 +89,7 @@ struct resource_list {
 #define IORESOURCE_ROM_ENABLE		(1<<0)	/* ROM is enabled, same as PCI_ROM_ADDRESS_ENABLE */
 #define IORESOURCE_ROM_SHADOW		(1<<1)	/* ROM is copy at C000:0 */
 #define IORESOURCE_ROM_COPY		(1<<2)	/* ROM is alloc'd copy, resource field overlaid */
+#define IORESOURCE_ROM_BIOS_COPY	(1<<3)	/* ROM is BIOS copy, resource field overlaid */
 
 /* PC/ISA/whatever - the normal PC address spaces: IO and memory */
 extern struct resource ioport_resource;
Index: linux-2.6/arch/ia64/sn/kernel/io_acpi_init.c
===================================================================
--- linux-2.6.orig/arch/ia64/sn/kernel/io_acpi_init.c	2006-08-31 16:07:39.074573515 -0500
+++ linux-2.6/arch/ia64/sn/kernel/io_acpi_init.c	2006-08-31 16:09:00.768555473 -0500
@@ -169,6 +169,39 @@ sn_acpi_bus_fixup(struct pci_bus *bus)
 	}
 }
 
+/*
+ * sn_acpi_slot_fixup - Perform any SN specific slot fixup.
+ *			At present there does not appear to be
+ *			any generic way to handle a ROM image
+ *			that has been shadowed by the PROM, so
+ *			we pass a pointer to it	within the
+ *			pcidev_info structure.
+ */
+
+void
+sn_acpi_slot_fixup(struct pci_dev *dev, struct pcidev_info *pcidev_info)
+{
+	void __iomem *addr;
+	size_t size;
+
+	if (pcidev_info->pdi_pio_mapped_addr[PCI_ROM_RESOURCE]) {
+		/*
+		 * A valid ROM image exists and has been shadowed by the
+		 * PROM. Setup the pci_dev ROM resource to point to
+		 * the shadowed copy.
+		 */
+		size = dev->resource[PCI_ROM_RESOURCE].end -
+				dev->resource[PCI_ROM_RESOURCE].start;
+		addr =
+		     ioremap(pcidev_info->pdi_pio_mapped_addr[PCI_ROM_RESOURCE],
+			     size);
+		dev->resource[PCI_ROM_RESOURCE].start = (unsigned long) addr;
+		dev->resource[PCI_ROM_RESOURCE].end =
+						(unsigned long) addr + size;
+		dev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_BIOS_COPY;
+	}
+}
+
 static struct acpi_driver acpi_sn_hubdev_driver = {
 	.name = "SGI HUBDEV Driver",
 	.ids = "SGIHUB,SGITIO",
Index: linux-2.6/arch/ia64/sn/kernel/io_init.c
===================================================================
--- linux-2.6.orig/arch/ia64/sn/kernel/io_init.c	2006-08-30 13:01:01.000000000 -0500
+++ linux-2.6/arch/ia64/sn/kernel/io_init.c	2006-08-31 16:27:50.643626522 -0500
@@ -210,6 +210,9 @@ sn_more_slot_fixup(struct pci_dev *dev, 
 			dev->resource[idx].parent = &ioport_resource;
 		else
 			dev->resource[idx].parent = &iomem_resource;
+		/* If ROM, mark as shadowed in PROM */
+		if (idx == PCI_ROM_RESOURCE)
+			dev->resource[idx].flags |= IORESOURCE_ROM_BIOS_COPY;
 	}
 	/* Create a pci_window in the pci_controller struct for
 	 * each device resource.
