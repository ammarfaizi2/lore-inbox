Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262233AbVAJNlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262233AbVAJNlo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 08:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbVAJNlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 08:41:44 -0500
Received: from ozlabs.org ([203.10.76.45]:20635 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262233AbVAJNla (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 08:41:30 -0500
Date: Tue, 11 Jan 2005 00:38:38 +1100
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64: PCI cleanup
Message-ID: <20050110133838.GT14239@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- remove pci_fix_bus_sysdata. We required it for the old pci dma
  subsystem, but now it is useless.
- remove PCI_GET_PHB_PTR and use pci_bus_to_host instead
- remove pci_find_hose_for_OF_device
- remove some unused fields in struct pci_controller
- remove pci_device_loc stale prototype
- remove an old mask of pci bus number that was left around from the pre
  PCI domains days

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN arch/ppc64/kernel/maple_pci.c~remove_pci_find_hose_for_OF_device arch/ppc64/kernel/maple_pci.c
--- foobar2/arch/ppc64/kernel/maple_pci.c~remove_pci_find_hose_for_OF_device	2005-01-10 22:53:22.017106560 +1100
+++ foobar2-anton/arch/ppc64/kernel/maple_pci.c	2005-01-10 22:53:53.160314599 +1100
@@ -382,9 +382,6 @@ void __init maple_pcibios_fixup(void)
 	/* Do the mapping of the IO space */
 	phbs_remap_io();
 
-	/* Fixup the pci_bus sysdata pointers */
-	pci_fix_bus_sysdata();
-
 	DBG(" <- maple_pcibios_fixup\n");
 }
 
diff -puN arch/ppc64/kernel/pSeries_pci.c~remove_pci_find_hose_for_OF_device arch/ppc64/kernel/pSeries_pci.c
--- foobar2/arch/ppc64/kernel/pSeries_pci.c~remove_pci_find_hose_for_OF_device	2005-01-10 22:53:22.023106101 +1100
+++ foobar2-anton/arch/ppc64/kernel/pSeries_pci.c	2005-01-10 22:53:22.078101901 +1100
@@ -552,7 +552,6 @@ void __init pSeries_final_fixup(void)
 
 	phbs_remap_io();
 	pSeries_request_regions();
-	pci_fix_bus_sysdata();
 
 	pci_addr_cache_build();
 }
diff -puN arch/ppc64/kernel/pci.c~remove_pci_find_hose_for_OF_device arch/ppc64/kernel/pci.c
--- foobar2/arch/ppc64/kernel/pci.c~remove_pci_find_hose_for_OF_device	2005-01-10 22:53:22.029105643 +1100
+++ foobar2-anton/arch/ppc64/kernel/pci.c	2005-01-10 22:53:22.083101520 +1100
@@ -91,7 +91,7 @@ void  pcibios_resource_to_bus(struct pci
 			      struct resource *res)
 {
 	unsigned long offset = 0;
-	struct pci_controller *hose = PCI_GET_PHB_PTR(dev);
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
 
 	if (!hose)
 		return;
@@ -127,7 +127,7 @@ void pcibios_align_resource(void *data, 
 			    unsigned long size, unsigned long align)
 {
 	struct pci_dev *dev = data;
-	struct pci_controller *hose = PCI_GET_PHB_PTR(dev);
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
 	unsigned long start = res->start;
 	unsigned long alignto;
 
@@ -292,7 +292,7 @@ int pci_domain_nr(struct pci_bus *bus)
 #ifdef CONFIG_PPC_ISERIES
 	return 0;
 #else
-	struct pci_controller *hose = PCI_GET_PHB_PTR(bus);
+	struct pci_controller *hose = pci_bus_to_host(bus);
 
 	return hose->global_number;
 #endif
@@ -304,7 +304,7 @@ EXPORT_SYMBOL(pci_domain_nr);
 int pci_name_bus(char *name, struct pci_bus *bus)
 {
 #ifndef CONFIG_PPC_ISERIES
-	struct pci_controller *hose = PCI_GET_PHB_PTR(bus);
+	struct pci_controller *hose = pci_bus_to_host(bus);
 
 	if (hose->buid)
 		sprintf(name, "%04x:%02x", pci_domain_nr(bus), bus->number);
@@ -336,7 +336,7 @@ static __inline__ int __pci_mmap_make_of
 					     struct vm_area_struct *vma,
 					     enum pci_mmap_state mmap_state)
 {
-	struct pci_controller *hose = PCI_GET_PHB_PTR(dev);
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
 	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
 	unsigned long io_offset = 0;
 	int i, res_bit;
@@ -643,7 +643,7 @@ void __devinit pci_setup_phb_io_dynamic(
 static int get_bus_io_range(struct pci_bus *bus, unsigned long *start_phys,
 				unsigned long *start_virt, unsigned long *size)
 {
-	struct pci_controller *hose = PCI_GET_PHB_PTR(bus);
+	struct pci_controller *hose = pci_bus_to_host(bus);
 	struct pci_bus_region region;
 	struct resource *res;
 
@@ -728,23 +728,6 @@ void phbs_remap_io(void)
 		remap_bus_range(hose->bus);
 }
 
-
-/*
- * This function finds the PHB that matching device_node in the 
- * OpenFirmware by scanning all the pci_controllers.
- */
-struct pci_controller* pci_find_hose_for_OF_device(struct device_node *node)
-{
-	while (node) {
-		struct pci_controller *hose, *tmp;
-		list_for_each_entry_safe(hose, tmp, &hose_list, list_node)
-			if (hose->arch_data == node)
-				return hose;
-		node=node->parent;
-	}
-	return NULL;
-}
-
 /*
  * ppc64 can have multifunction devices that do not respond to function 0.
  * In this case we must scan all functions.
@@ -778,7 +761,7 @@ void __devinit pcibios_fixup_device_reso
 					   struct pci_bus *bus)
 {
 	/* Update device resources.  */
-	struct pci_controller *hose = PCI_GET_PHB_PTR(bus);
+	struct pci_controller *hose = pci_bus_to_host(bus);
 	int i;
 
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
@@ -814,7 +797,7 @@ EXPORT_SYMBOL(pcibios_fixup_device_resou
 
 void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 {
-	struct pci_controller *hose = PCI_GET_PHB_PTR(bus);
+	struct pci_controller *hose = pci_bus_to_host(bus);
 	struct pci_dev *dev = bus->self;
 	struct resource *res;
 	int i;
diff -puN arch/ppc64/kernel/pci.h~remove_pci_find_hose_for_OF_device arch/ppc64/kernel/pci.h
--- foobar2/arch/ppc64/kernel/pci.h~remove_pci_find_hose_for_OF_device	2005-01-10 22:53:22.035105185 +1100
+++ foobar2-anton/arch/ppc64/kernel/pci.h	2005-01-10 22:53:22.085101367 +1100
@@ -17,7 +17,6 @@ extern unsigned long isa_io_base;
 extern void pci_setup_pci_controller(struct pci_controller *hose);
 extern void pci_setup_phb_io(struct pci_controller *hose, int primary);
 
-extern struct pci_controller* pci_find_hose_for_OF_device(struct device_node* node);
 extern void pci_setup_phb_io_dynamic(struct pci_controller *hose);
 
 
@@ -36,11 +35,8 @@ void *traverse_pci_devices(struct device
 
 void pci_devs_phb_init(void);
 void pci_devs_phb_init_dynamic(struct pci_controller *phb);
-void pci_fix_bus_sysdata(void);
 struct device_node *fetch_dev_dn(struct pci_dev *dev);
 
-#define PCI_GET_PHB_PTR(dev)    (((struct device_node *)(dev)->sysdata)->phb)
-
 /* PCI address cache management routines */
 void pci_addr_cache_insert_device(struct pci_dev *dev);
 void pci_addr_cache_remove_device(struct pci_dev *dev);
diff -puN arch/ppc64/kernel/pci_dn.c~remove_pci_find_hose_for_OF_device arch/ppc64/kernel/pci_dn.c
--- foobar2/arch/ppc64/kernel/pci_dn.c~remove_pci_find_hose_for_OF_device	2005-01-10 22:53:22.040104803 +1100
+++ foobar2-anton/arch/ppc64/kernel/pci_dn.c	2005-01-10 22:54:49.270466932 +1100
@@ -21,19 +21,12 @@
  */
 #include <linux/kernel.h>
 #include <linux/pci.h>
-#include <linux/delay.h>
 #include <linux/string.h>
 #include <linux/init.h>
-#include <linux/bootmem.h>
 
 #include <asm/io.h>
-#include <asm/pgtable.h>
-#include <asm/irq.h>
 #include <asm/prom.h>
-#include <asm/machdep.h>
 #include <asm/pci-bridge.h>
-#include <asm/ppcdebug.h>
-#include <asm/iommu.h>
 
 #include "pci.h"
 
@@ -178,29 +171,3 @@ void __init pci_devs_phb_init(void)
 	list_for_each_entry_safe(phb, tmp, &hose_list, list_node)
 		pci_devs_phb_init_dynamic(phb);
 }
-
-
-static void __init pci_fixup_bus_sysdata_list(struct list_head *bus_list)
-{
-	struct pci_bus *bus;
-
-	list_for_each_entry(bus, bus_list, node) {
-		if (bus->self)
-			bus->sysdata = bus->self->sysdata;
-		pci_fixup_bus_sysdata_list(&bus->children);
-	}
-}
-
-/*
- * Fixup the bus->sysdata ptrs to point to the bus' device_node.
- * This is done late in pcibios_init().  We do this mostly for
- * sanity, but pci_dma.c uses these at DMA time so they must be
- * correct.
- * To do this we recurse down the bus hierarchy.  Note that PHB's
- * have bus->self == NULL, but fortunately bus->sysdata is already
- * correct in this case.
- */
-void __init pci_fix_bus_sysdata(void)
-{
-	pci_fixup_bus_sysdata_list(&pci_root_buses);
-}
diff -puN arch/ppc64/kernel/pmac_pci.c~remove_pci_find_hose_for_OF_device arch/ppc64/kernel/pmac_pci.c
--- foobar2/arch/ppc64/kernel/pmac_pci.c~remove_pci_find_hose_for_OF_device	2005-01-10 22:53:22.046104345 +1100
+++ foobar2-anton/arch/ppc64/kernel/pmac_pci.c	2005-01-10 22:55:18.460714142 +1100
@@ -664,8 +664,6 @@ void __init pmac_pcibios_fixup(void)
 
 	for_each_pci_dev(dev)
 		pci_read_irq_line(dev);
-
-	pci_fix_bus_sysdata();
 }
 
 static void __init pmac_fixup_phb_resources(void)
diff -puN include/asm-ppc64/pci-bridge.h~remove_pci_find_hose_for_OF_device include/asm-ppc64/pci-bridge.h
--- foobar2/include/asm-ppc64/pci-bridge.h~remove_pci_find_hose_for_OF_device	2005-01-10 22:53:22.050104040 +1100
+++ foobar2-anton/include/asm-ppc64/pci-bridge.h	2005-01-10 22:53:22.097100451 +1100
@@ -11,18 +11,10 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-struct device_node;
-struct pci_controller;
-
-/* Get the PCI host controller for an OF device */
-extern struct pci_controller*
-pci_find_hose_for_OF_device(struct device_node* node);
-
 /*
  * Structure of a PCI controller (host bridge)
  */
 struct pci_controller {
-	char what[8];                     /* Eye catcher      */
 	struct pci_bus *bus;
 	char is_dynamic;
 	void *arch_data;
@@ -49,7 +41,6 @@ struct pci_controller {
 	 */
 	struct resource io_resource;
 	struct resource mem_resources[3];
-	int mem_resource_count;
 	int global_number;		
 	int local_number;		
 	unsigned long buid;
@@ -57,14 +48,6 @@ struct pci_controller {
 	unsigned long dma_window_size;
 };
 
-/*
- * pci_device_loc returns the bus number and device/function number
- * for a device on a PCI bus, given its device_node struct.
- * It returns 0 if OK, -1 on error.
- */
-extern int pci_device_loc(struct device_node *dev, unsigned char *bus_ptr,
-			  unsigned char *devfn_ptr);
-
 struct device_node *fetch_dev_dn(struct pci_dev *dev);
 
 /* Get a device_node from a pci_dev.  This code must be fast except in the case
@@ -72,8 +55,9 @@ struct device_node *fetch_dev_dn(struct 
  */
 static inline struct device_node *pci_device_to_OF_node(struct pci_dev *dev)
 {
-	struct device_node *dn = (struct device_node *)(dev->sysdata);
-	if (dn->devfn == dev->devfn && dn->busno == (dev->bus->number&0xff))
+	struct device_node *dn = dev->sysdata;
+
+	if (dn->devfn == dev->devfn && dn->busno == dev->bus->number)
 		return dn;	/* fast path.  sysdata is good */
 	else
 		return fetch_dev_dn(dev);
@@ -102,6 +86,5 @@ static inline struct pci_controller *pci
 	return busdn->phb;
 }
 
-
 #endif
 #endif /* __KERNEL__ */
_
