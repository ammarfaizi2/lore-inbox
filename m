Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbUJYAel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUJYAel (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 20:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbUJYAel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 20:34:41 -0400
Received: from gate.crashing.org ([63.228.1.57]:51660 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261638AbUJYAe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 20:34:26 -0400
Subject: [PATCH] ppc64: Move PCI IO mapping from pSeries_pci.c to pci.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1098664345.16135.7.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 25 Oct 2004 10:32:25 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves some of the routines responsible for dealing
with the mapping of PCI host bridges IO space from pSeries to
the generic ppc64 pci code. PowerMac doesn't use it currently,
but a new platform will soon.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc64/kernel/pci.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/pci.c	2004-10-21 11:47:00.000000000 +1000
+++ linux-work/arch/ppc64/kernel/pci.c	2004-10-25 10:28:49.816822080 +1000
@@ -729,6 +729,96 @@
 	res->end += io_virt_offset;
 }
 
+
+static int get_bus_io_range(struct pci_bus *bus, unsigned long *start_phys,
+				unsigned long *start_virt, unsigned long *size)
+{
+	struct pci_controller *hose = PCI_GET_PHB_PTR(bus);
+	struct pci_bus_region region;
+	struct resource *res;
+
+	if (bus->self) {
+		res = bus->resource[0];
+		pcibios_resource_to_bus(bus->self, &region, res);
+		*start_phys = hose->io_base_phys + region.start;
+		*start_virt = (unsigned long) hose->io_base_virt + 
+				region.start;
+		if (region.end > region.start) 
+			*size = region.end - region.start + 1;
+		else {
+			printk("%s(): unexpected region 0x%lx->0x%lx\n", 
+					__FUNCTION__, region.start, region.end);
+			return 1;
+		}
+		
+	} else {
+		/* Root Bus */
+		res = &hose->io_resource;
+		*start_phys = hose->io_base_phys;
+		*start_virt = (unsigned long) hose->io_base_virt;
+		if (res->end > res->start)
+			*size = res->end - res->start + 1;
+		else {
+			printk("%s(): unexpected region 0x%lx->0x%lx\n", 
+					__FUNCTION__, res->start, res->end);
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+int unmap_bus_range(struct pci_bus *bus)
+{
+	unsigned long start_phys;
+	unsigned long start_virt;
+	unsigned long size;
+
+	if (!bus) {
+		printk(KERN_ERR "%s() expected bus\n", __FUNCTION__);
+		return 1;
+	}
+	
+	if (get_bus_io_range(bus, &start_phys, &start_virt, &size))
+		return 1;
+	if (iounmap_explicit((void *) start_virt, size))
+		return 1;
+
+	return 0;
+}
+EXPORT_SYMBOL(unmap_bus_range);
+
+int remap_bus_range(struct pci_bus *bus)
+{
+	unsigned long start_phys;
+	unsigned long start_virt;
+	unsigned long size;
+
+	if (!bus) {
+		printk(KERN_ERR "%s() expected bus\n", __FUNCTION__);
+		return 1;
+	}
+	
+	
+	if (get_bus_io_range(bus, &start_phys, &start_virt, &size))
+		return 1;
+	printk("mapping IO %lx -> %lx, size: %lx\n", start_phys, start_virt, size);
+	if (__ioremap_explicit(start_phys, start_virt, size, _PAGE_NO_CACHE))
+		return 1;
+
+	return 0;
+}
+EXPORT_SYMBOL(remap_bus_range);
+
+void phbs_remap_io(void)
+{
+	struct pci_controller *hose, *tmp;
+
+	list_for_each_entry_safe(hose, tmp, &hose_list, list_node)
+		remap_bus_range(hose->bus);
+}
+
+
 /*********************************************************************** 
  * pci_find_hose_for_OF_device
  *
Index: linux-work/arch/ppc64/kernel/pSeries_pci.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/pSeries_pci.c	2004-10-25 10:24:50.886145064 +1000
+++ linux-work/arch/ppc64/kernel/pSeries_pci.c	2004-10-25 10:28:40.498238720 +1000
@@ -482,92 +482,6 @@
 	}
 }
 
-static int get_bus_io_range(struct pci_bus *bus, unsigned long *start_phys,
-				unsigned long *start_virt, unsigned long *size)
-{
-	struct pci_controller *hose = PCI_GET_PHB_PTR(bus);
-	struct pci_bus_region region;
-	struct resource *res;
-
-	if (bus->self) {
-		res = bus->resource[0];
-		pcibios_resource_to_bus(bus->self, &region, res);
-		*start_phys = hose->io_base_phys + region.start;
-		*start_virt = (unsigned long) hose->io_base_virt + 
-				region.start;
-		if (region.end > region.start) 
-			*size = region.end - region.start + 1;
-		else {
-			printk("%s(): unexpected region 0x%lx->0x%lx\n", 
-					__FUNCTION__, region.start, region.end);
-			return 1;
-		}
-		
-	} else {
-		/* Root Bus */
-		res = &hose->io_resource;
-		*start_phys = hose->io_base_phys;
-		*start_virt = (unsigned long) hose->io_base_virt;
-		if (res->end > res->start)
-			*size = res->end - res->start + 1;
-		else {
-			printk("%s(): unexpected region 0x%lx->0x%lx\n", 
-					__FUNCTION__, res->start, res->end);
-			return 1;
-		}
-	}
-
-	return 0;
-}
-
-int unmap_bus_range(struct pci_bus *bus)
-{
-	unsigned long start_phys;
-	unsigned long start_virt;
-	unsigned long size;
-
-	if (!bus) {
-		printk(KERN_ERR "%s() expected bus\n", __FUNCTION__);
-		return 1;
-	}
-	
-	if (get_bus_io_range(bus, &start_phys, &start_virt, &size))
-		return 1;
-	if (iounmap_explicit((void *) start_virt, size))
-		return 1;
-
-	return 0;
-}
-EXPORT_SYMBOL(unmap_bus_range);
-
-int remap_bus_range(struct pci_bus *bus)
-{
-	unsigned long start_phys;
-	unsigned long start_virt;
-	unsigned long size;
-
-	if (!bus) {
-		printk(KERN_ERR "%s() expected bus\n", __FUNCTION__);
-		return 1;
-	}
-	
-	if (get_bus_io_range(bus, &start_phys, &start_virt, &size))
-		return 1;
-	if (__ioremap_explicit(start_phys, start_virt, size, _PAGE_NO_CACHE))
-		return 1;
-
-	return 0;
-}
-EXPORT_SYMBOL(remap_bus_range);
-
-static void phbs_remap_io(void)
-{
-	struct pci_controller *hose, *tmp;
-
-	list_for_each_entry_safe(hose, tmp, &hose_list, list_node)
-		remap_bus_range(hose->bus);
-}
-
 /* RPA-specific bits for removing PHBs */
 int pcibios_remove_root_bus(struct pci_controller *phb)
 {
Index: linux-work/include/asm-ppc64/pci-bridge.h
===================================================================
--- linux-work.orig/include/asm-ppc64/pci-bridge.h	2004-10-20 13:01:04.000000000 +1000
+++ linux-work/include/asm-ppc64/pci-bridge.h	2004-10-25 10:30:23.388597008 +1000
@@ -99,5 +99,7 @@
  */
 #define PCI_GET_DN(dev) ((struct device_node *)((dev)->sysdata))
 
+extern void phbs_remap_io(void);
+
 #endif
 #endif /* __KERNEL__ */


