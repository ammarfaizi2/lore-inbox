Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263202AbUC3FqJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 00:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbUC3FqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 00:46:09 -0500
Received: from gate.crashing.org ([63.228.1.57]:56981 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263202AbUC3Fpj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 00:45:39 -0500
Subject: [PATCH] ppc32: PCI mmap update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1080625529.1195.17.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 30 Mar 2004 15:45:29 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the ppc32 PCI mmap facility to allow mmap'ing of
space outside of the actual devices, using the host bridge resources
instead. This allow userland to map things like legacy IO space by
either using the bridge device itself, or simply any PCI device on
the same bus domain

diff -urN linux-2.5/arch/ppc/kernel/pci.c linuxppc-2.5-benh/arch/ppc/kernel/pci.c
--- linux-2.5/arch/ppc/kernel/pci.c	2004-03-01 18:11:11.000000000 +1100
+++ linuxppc-2.5-benh/arch/ppc/kernel/pci.c	2004-03-29 13:56:09.000000000 +1000
@@ -159,7 +159,6 @@
 		ppc_md.pcibios_fixup_resources(dev);
 }
 
-
 void
 pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
 			struct resource *res)
@@ -1522,51 +1521,43 @@
 {
 	struct pci_controller *hose = (struct pci_controller *) dev->sysdata;
 	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
-	unsigned long io_offset = 0;
-	int i, res_bit;
+	unsigned long size = vma->vm_end - vma->vm_start;
+	unsigned long base;
+	struct resource *res;
+	int i;
+	int ret = -EINVAL;
 
 	if (hose == 0)
 		return -EINVAL;		/* should never happen */
+	if (offset + size <= offset)
+		return -EINVAL;
 
-	/* If memory, add on the PCI bridge address offset */
 	if (mmap_state == pci_mmap_mem) {
+		/* PCI memory space */
+		base = hose->pci_mem_offset;
+		for (i = 0; i < 3; ++i) {
+			res = &hose->mem_resources[i];
+			if (res->flags == 0)
+				continue;
+			if (offset >= res->start - base
+			    && offset + size - 1 <= res->end - base) {
+				ret = 0;
+				break;
+			}
+		}
 		offset += hose->pci_mem_offset;
-		res_bit = IORESOURCE_MEM;
 	} else {
-		io_offset = (unsigned long)hose->io_base_virt - isa_io_base;
-		offset += io_offset;
-		res_bit = IORESOURCE_IO;
+		/* PCI I/O space */
+		base = (unsigned long)hose->io_base_virt - isa_io_base;
+		res = &hose->io_resource;
+		if (offset >= res->start - base
+		    && offset + size - 1 <= res->end - base)
+			ret = 0;
+		offset += hose->io_base_phys;
 	}
 
-	/*
-	 * Check that the offset requested corresponds to one of the
-	 * resources of the device.
-	 */
-	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
-		struct resource *rp = &dev->resource[i];
-		int flags = rp->flags;
-
-		/* treat ROM as memory (should be already) */
-		if (i == PCI_ROM_RESOURCE)
-			flags |= IORESOURCE_MEM;
-
-		/* Active and same type? */
-		if ((flags & res_bit) == 0)
-			continue;
-
-		/* In the range of this resource? */
-		if (offset < (rp->start & PAGE_MASK) || offset > rp->end)
-			continue;
-
-		/* found it! construct the final physical address */
-		if (mmap_state == pci_mmap_io)
-			offset += hose->io_base_phys - io_offset;
-
-		vma->vm_pgoff = offset >> PAGE_SHIFT;
-		return 0;
-	}
-
-	return -EINVAL;
+	vma->vm_pgoff = offset >> PAGE_SHIFT;
+	return ret;
 }
 
 /*


