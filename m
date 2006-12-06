Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760621AbWLFNrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760621AbWLFNrZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 08:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760623AbWLFNrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 08:47:24 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:34211 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760621AbWLFNrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 08:47:24 -0500
Date: Wed, 6 Dec 2006 13:41:43 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] PCI legacy resource fix
Message-ID: <20061206134143.GA6772@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 368c73d4f689dae0807d0a2aa74c61fd2b9b075f the kernel will try
to update the non-writeable BAR registers 0..3 of PIIX4 IDE adapters if
pci_assign_unassigned_resources() is used to do full resource assignment
of the bus.  This fails because in the PIIX4 these BAR registers have
implicitly assumed values and read back as zero; it used to work because
the kernel used to just write zero to that register the read back value
did match what was written.

The fix is a new resource flag IORESOURCE_PCI_FIXED used to mark a
resource as non-movable.  This will also be useful to keep other import
system resources from being moved around - for example system consoles
on PCI busses.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0eeac60..045ad71 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -649,6 +649,9 @@ static void pci_read_irq(struct pci_dev 
  * Returns 0 on success and -1 if unknown type of device (not normal, bridge
  * or CardBus).
  */
+
+#define LEGACY_IO_RESOURCE	(IORESOURCE_IO | IORESOURCE_PCI_FIXED)
+
 static int pci_setup_device(struct pci_dev * dev)
 {
 	u32 class;
@@ -692,18 +695,18 @@ static int pci_setup_device(struct pci_d
 			if ((progif & 1) == 0) {
 				dev->resource[0].start = 0x1F0;
 				dev->resource[0].end = 0x1F7;
-				dev->resource[0].flags = IORESOURCE_IO;
+				dev->resource[0].flags = LEGACY_IO_RESOURCE;
 				dev->resource[1].start = 0x3F6;
 				dev->resource[1].end = 0x3F6;
-				dev->resource[1].flags = IORESOURCE_IO;
+				dev->resource[1].flags = LEGACY_IO_RESOURCE;
 			}
 			if ((progif & 4) == 0) {
 				dev->resource[2].start = 0x170;
 				dev->resource[2].end = 0x177;
-				dev->resource[2].flags = IORESOURCE_IO;
+				dev->resource[2].flags = LEGACY_IO_RESOURCE;
 				dev->resource[3].start = 0x376;
 				dev->resource[3].end = 0x376;
-				dev->resource[3].flags = IORESOURCE_IO;
+				dev->resource[3].flags = LEGACY_IO_RESOURCE;
 			}
 		}
 		break;
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index ab78e4b..064b3f3 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -38,6 +38,13 @@ pci_update_resource(struct pci_dev *dev,
 	if (!res->flags)
 		return;
 
+	/* Ignore non-moveable resources.  This might be legacy resources for
+	   which no functional BAR register exists or another important
+	   system resource we should better not move around in system address
+	   space.  */
+	if (res->flags & IORESOURCE_PCI_FIXED)
+		return;
+
 	pcibios_resource_to_bus(dev, &region, res);
 
 	pr_debug("  got res [%llx:%llx] bus [%lx:%lx] flags %lx for "
@@ -212,6 +219,10 @@ pdev_sort_resources(struct pci_dev *dev,
 		resource_size_t r_align;
 
 		r = &dev->resource[i];
+
+		if (r->flags & IORESOURCE_PCI_FIXED)
+			continue;
+
 		r_align = r->end - r->start;
 		
 		if (!(r->flags) || r->parent)
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index cf8696d..15228d7 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -91,6 +91,9 @@ #define IORESOURCE_ROM_SHADOW		(1<<1)	/*
 #define IORESOURCE_ROM_COPY		(1<<2)	/* ROM is alloc'd copy, resource field overlaid */
 #define IORESOURCE_ROM_BIOS_COPY	(1<<3)	/* ROM is BIOS copy, resource field overlaid */
 
+/* PCI control bits.  Shares IORESOURCE_BITS with above PCI ROM.  */
+#define IORESOURCE_PCI_FIXED		(1<<4)	/* Do not move resource */
+
 /* PC/ISA/whatever - the normal PC address spaces: IO and memory */
 extern struct resource ioport_resource;
 extern struct resource iomem_resource;
