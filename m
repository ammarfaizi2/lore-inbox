Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266849AbUHXGcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266849AbUHXGcN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 02:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267165AbUHXGcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 02:32:13 -0400
Received: from ozlabs.org ([203.10.76.45]:50579 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266849AbUHXGb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 02:31:56 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16682.57544.685323.638898@cargo.ozlabs.ibm.com>
Date: Tue, 24 Aug 2004 16:31:36 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: anton@samba.org, johnrose@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 Use struct list_head for hose_list
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes hose_list from a simple linked list to a
"list.h"-style list.  This is in preparation for the runtime
addition/removal of PCI Host Bridges.

Signed-off-by: John Rose <johnrose@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/pSeries_iommu.c akpm/arch/ppc64/kernel/pSeries_iommu.c
--- linux-2.5/arch/ppc64/kernel/pSeries_iommu.c	2004-08-24 11:25:47.000000000 +1000
+++ akpm/arch/ppc64/kernel/pSeries_iommu.c	2004-08-24 16:05:41.000000000 +1000
@@ -90,7 +90,7 @@
 
 static void iommu_buses_init(void)
 {
-	struct pci_controller* phb;
+	struct pci_controller *phb, *tmp;
 	struct device_node *dn, *first_dn;
 	int num_slots, num_slots_ilog2;
 	int first_phb = 1;
@@ -106,10 +106,10 @@
 	else
 		tcetable_ilog2 = 22;
 
-	/* XXX Should we be using pci_root_buses instead?  -ojn 
+	/* XXX Should we be using pci_root_buses instead?  -ojn
 	 */
 
-	for (phb=hose_head; phb; phb=phb->next) {
+	list_for_each_entry_safe(phb, tmp, &hose_list, list_node) {
 		first_dn = ((struct device_node *)phb->arch_data)->child;
 
 		/* Carve 2GB into the largest dma_window_size possible */
diff -urN linux-2.5/arch/ppc64/kernel/pSeries_pci.c akpm/arch/ppc64/kernel/pSeries_pci.c
--- linux-2.5/arch/ppc64/kernel/pSeries_pci.c	2004-08-24 11:25:47.000000000 +1000
+++ akpm/arch/ppc64/kernel/pSeries_pci.c	2004-08-24 16:07:32.000000000 +1000
@@ -729,9 +729,9 @@
 
 static void phbs_fixup_io(void)
 {
-	struct pci_controller *hose;
+	struct pci_controller *hose, *tmp;
 
-	for (hose=hose_head;hose;hose=hose->next) 
+	list_for_each_entry_safe(hose, tmp, &hose_list, list_node)
 		remap_bus_range(hose->bus);
 }
 
@@ -764,8 +764,8 @@
 pci_find_hose_for_OF_device(struct device_node *node)
 {
 	while (node) {
-		struct pci_controller *hose;
-		for (hose=hose_head;hose;hose=hose->next)
+		struct pci_controller *hose, *tmp;
+		list_for_each_entry_safe(hose, tmp, &hose_list, list_node)
 			if (hose->arch_data == node)
 				return hose;
 		node=node->parent;
diff -urN linux-2.5/arch/ppc64/kernel/pci.c akpm/arch/ppc64/kernel/pci.c
--- linux-2.5/arch/ppc64/kernel/pci.c	2004-08-24 11:25:47.000000000 +1000
+++ akpm/arch/ppc64/kernel/pci.c	2004-08-24 16:09:15.000000000 +1000
@@ -23,6 +23,7 @@
 #include <linux/bootmem.h>
 #include <linux/module.h>
 #include <linux/mm.h>
+#include <linux/list.h>
 
 #include <asm/processor.h>
 #include <asm/io.h>
@@ -57,8 +58,7 @@
 
 void iSeries_pcibios_init(void);
 
-struct pci_controller *hose_head;
-struct pci_controller **hose_tail = &hose_head;
+LIST_HEAD(hose_list);
 
 struct pci_dma_ops pci_dma_ops;
 EXPORT_SYMBOL(pci_dma_ops);
@@ -221,9 +221,9 @@
 		memcpy(hose->what,model,7);
         hose->type = controller_type;
         hose->global_number = global_phb_number++;
-        
-        *hose_tail = hose;
-        hose_tail = &hose->next;
+
+	list_add_tail(&hose->list_node, &hose_list);
+
         return hose;
 }
 
@@ -263,7 +263,7 @@
 
 static int __init pcibios_init(void)
 {
-	struct pci_controller *hose;
+	struct pci_controller *hose, *tmp;
 	struct pci_bus *bus;
 
 #ifdef CONFIG_PPC_ISERIES
@@ -274,7 +274,7 @@
 	printk("PCI: Probing PCI hardware\n");
 
 	/* Scan all of the recorded PCI controllers.  */
-	for (hose = hose_head; hose; hose = hose->next) {
+	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
 		hose->last_busno = 0xff;
 		bus = pci_scan_bus(hose->first_busno, hose->ops,
 				   hose->arch_data);
diff -urN linux-2.5/arch/ppc64/kernel/pci.h akpm/arch/ppc64/kernel/pci.h
--- linux-2.5/arch/ppc64/kernel/pci.h	2004-08-08 12:05:16.000000000 +1000
+++ akpm/arch/ppc64/kernel/pci.h	2004-08-24 16:03:26.000000000 +1000
@@ -17,9 +17,7 @@
 extern struct pci_controller* pci_alloc_pci_controller(enum phb_types controller_type);
 extern struct pci_controller* pci_find_hose_for_OF_device(struct device_node* node);
 
-extern struct pci_controller* hose_head;
-extern struct pci_controller** hose_tail;
-
+extern struct list_head hose_list;
 extern int global_phb_number;
 
 /*******************************************************************
diff -urN linux-2.5/arch/ppc64/kernel/pci_dn.c akpm/arch/ppc64/kernel/pci_dn.c
--- linux-2.5/arch/ppc64/kernel/pci_dn.c	2004-08-08 12:05:16.000000000 +1000
+++ akpm/arch/ppc64/kernel/pci_dn.c	2004-08-24 16:03:26.000000000 +1000
@@ -129,10 +129,10 @@
  */
 static void *traverse_all_pci_devices(traverse_func pre)
 {
-	struct pci_controller *phb;
+	struct pci_controller *phb, *tmp;
 	void *ret;
 
-	for (phb = hose_head; phb; phb = phb->next)
+	list_for_each_entry_safe(phb, tmp, &hose_list, list_node)
 		if ((ret = traverse_pci_devices(phb->arch_data, pre, phb))
 				!= NULL)
 			return ret;
diff -urN linux-2.5/arch/ppc64/kernel/pmac_pci.c akpm/arch/ppc64/kernel/pmac_pci.c
--- linux-2.5/arch/ppc64/kernel/pmac_pci.c	2004-08-24 11:25:47.000000000 +1000
+++ akpm/arch/ppc64/kernel/pmac_pci.c	2004-08-24 16:10:00.000000000 +1000
@@ -672,9 +672,9 @@
 
 static void __init pmac_fixup_phb_resources(void)
 {
-	struct pci_controller *hose;
+	struct pci_controller *hose, *tmp;
 	
-	for (hose = hose_head; hose; hose = hose->next) {
+	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
 		unsigned long offset = (unsigned long)hose->io_base_virt - pci_io_base;
 		hose->io_resource.start += offset;
 		hose->io_resource.end += offset;
diff -urN linux-2.5/include/asm-ppc64/pci-bridge.h akpm/include/asm-ppc64/pci-bridge.h
--- linux-2.5/include/asm-ppc64/pci-bridge.h	2004-08-03 08:07:44.000000000 +1000
+++ akpm/include/asm-ppc64/pci-bridge.h	2004-08-24 16:03:26.000000000 +1000
@@ -33,9 +33,9 @@
 struct pci_controller {
 	char what[8];                     /* Eye catcher      */
 	enum phb_types type;              /* Type of hardware */
-	struct pci_controller *next;
 	struct pci_bus *bus;
 	void *arch_data;
+	struct list_head list_node;
 
 	int first_busno;
 	int last_busno;
