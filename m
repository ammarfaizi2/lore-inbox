Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbUJYAtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbUJYAtb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 20:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbUJYAtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 20:49:31 -0400
Received: from gate.crashing.org ([63.228.1.57]:56268 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261643AbUJYAtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 20:49:16 -0400
Subject: [PATCH] ppc64: cleanups of ppc64 pci.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1098665227.16132.11.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 25 Oct 2004 10:47:09 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch applies on top of previously posted "ppc64: Move PCI IO mapping
from pSeries_pci.c to pci.c".

It does cosmetic cleanups & add some debug macros to pci.c without actually
changing any functionality. Further patches against ppc64 pci.c that I'll
post will be against a file already patched with this one.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


Index: linux-work/arch/ppc64/kernel/pci.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/pci.c	2004-10-25 10:30:34.841855848 +1000
+++ linux-work/arch/ppc64/kernel/pci.c	2004-10-25 10:36:50.724712968 +1000
@@ -11,6 +11,8 @@
  *      2 of the License, or (at your option) any later version.
  */
 
+#undef DEBUG
+
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
@@ -39,6 +41,12 @@
 
 #include "pci.h"
 
+#ifdef DEBUG
+#define DBG(fmt...) udbg_printf(fmt)
+#else
+#define DBG(fmt...)
+#endif
+
 unsigned long pci_probe_only = 1;
 unsigned long pci_assign_all_buses = 0;
 
@@ -106,11 +114,11 @@
 			dev->resource[i].flags &= ~IORESOURCE_IO;
 	}
 }
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105, fixup_windbond_82c105);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105,
+			 fixup_windbond_82c105);
 
-void 
-pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
-			struct resource *res)
+void  pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
+			      struct resource *res)
 {
 	unsigned long offset = 0;
 	struct pci_controller *hose = PCI_GET_PHB_PTR(dev);
@@ -215,8 +223,7 @@
 /*
  * Allocate pci_controller(phb) initialized common variables.
  */
-struct pci_controller * __init
-pci_alloc_pci_controller(enum phb_types controller_type)
+struct pci_controller * __init pci_alloc_pci_controller(enum phb_types controller_type)
 {
 	struct pci_controller *hose;
 
@@ -246,8 +253,7 @@
 /*
  * Dymnamically allocate pci_controller(phb), initialize common variables.
  */
-struct pci_controller *
-pci_alloc_phb_dynamic(enum phb_types controller_type)
+struct pci_controller * pci_alloc_phb_dynamic(enum phb_types controller_type)
 {
 	struct pci_controller *hose;
 
@@ -430,9 +436,9 @@
  *
  * Returns negative error code on failure, zero on success.
  */
-static __inline__ int
-__pci_mmap_make_offset(struct pci_dev *dev, struct vm_area_struct *vma,
-		       enum pci_mmap_state mmap_state)
+static __inline__ int __pci_mmap_make_offset(struct pci_dev *dev,
+					     struct vm_area_struct *vma,
+					     enum pci_mmap_state mmap_state)
 {
 	struct pci_controller *hose = PCI_GET_PHB_PTR(dev);
 	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
@@ -487,9 +493,9 @@
  * Set vm_flags of VMA, as appropriate for this architecture, for a pci device
  * mapping.
  */
-static __inline__ void
-__pci_mmap_set_flags(struct pci_dev *dev, struct vm_area_struct *vma,
-		     enum pci_mmap_state mmap_state)
+static __inline__ void __pci_mmap_set_flags(struct pci_dev *dev,
+					    struct vm_area_struct *vma,
+					    enum pci_mmap_state mmap_state)
 {
 	vma->vm_flags |= VM_SHM | VM_LOCKED | VM_IO;
 }
@@ -498,9 +504,10 @@
  * Set vm_page_prot of VMA, as appropriate for this architecture, for a pci
  * device mapping.
  */
-static __inline__ void
-__pci_mmap_set_pgprot(struct pci_dev *dev, struct vm_area_struct *vma,
-		      enum pci_mmap_state mmap_state, int write_combine)
+static __inline__ void __pci_mmap_set_pgprot(struct pci_dev *dev,
+					     struct vm_area_struct *vma,
+					     enum pci_mmap_state mmap_state,
+					     int write_combine)
 {
 	long prot = pgprot_val(vma->vm_page_prot);
 
@@ -613,7 +620,7 @@
 }
 
 void __devinit pci_process_bridge_OF_ranges(struct pci_controller *hose,
-					struct device_node *dev)
+					    struct device_node *dev)
 {
 	unsigned int *ranges;
 	unsigned long size;
@@ -654,6 +661,8 @@
 			res = &hose->io_resource;
 			res->flags = IORESOURCE_IO;
 			res->start = pci_addr;
+			DBG("phb%d: IO 0x%lx -> 0x%lx\n", hose->global_number,
+				    res->start, res->start + size - 1);
 			break;
 		case 2:		/* memory space */
 			memno = 0;
@@ -666,6 +675,8 @@
 				res = &hose->mem_resources[memno];
 				res->flags = IORESOURCE_MEM;
 				res->start = cpu_phys_addr;
+				DBG("phb%d: MEM 0x%lx -> 0x%lx\n", hose->global_number,
+					    res->start, res->start + size - 1);
 			}
 			break;
 		}
@@ -873,7 +884,8 @@
 
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 		if (dev->resource[i].flags & IORESOURCE_IO) {
-			unsigned long offset = (unsigned long)hose->io_base_virt - pci_io_base;
+			unsigned long offset = (unsigned long)hose->io_base_virt
+				- pci_io_base;
                         unsigned long start, end, mask;
 
                         start = dev->resource[i].start += offset;


