Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267486AbUIAUXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267486AbUIAUXE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267475AbUIAUWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:22:55 -0400
Received: from baikonur.stro.at ([213.239.196.228]:22419 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267670AbUIAUPw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:15:52 -0400
Subject: [patch 09/12]  list_for_each: 	arch-sparc64-kernel-pci_common.c
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:15:50 +0200
Message-ID: <E1C2bWJ-0006Ru-6Y@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi.

Replace for/while loops with list_for_each*.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/arch/sparc64/kernel/pci_common.c |  122 ++++++---------
 1 files changed, 49 insertions(+), 73 deletions(-)

diff -puN arch/sparc64/kernel/pci_common.c~list-for-each-arch_sparc64_kernel_pci_common arch/sparc64/kernel/pci_common.c
--- linux-2.6.9-rc1-bk7/arch/sparc64/kernel/pci_common.c~list-for-each-arch_sparc64_kernel_pci_common	2004-09-01 19:38:14.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/arch/sparc64/kernel/pci_common.c	2004-09-01 19:38:14.000000000 +0200
@@ -15,18 +15,13 @@
  */
 void __init pci_fixup_host_bridge_self(struct pci_bus *pbus)
 {
-	struct list_head *walk = &pbus->devices;
-
-	walk = walk->next;
-	while (walk != &pbus->devices) {
-		struct pci_dev *pdev = pci_dev_b(walk);
+	struct pci_dev *pdev;
 
+	list_for_each_entry(pdev, &pbus->devices, bus_list) {
 		if (pdev->class >> 8 == PCI_CLASS_BRIDGE_HOST) {
 			pbus->self = pdev;
 			return;
 		}
-
-		walk = walk->next;
 	}
 
 	prom_printf("PCI: Critical error, cannot find host bridge PDEV.\n");
@@ -217,31 +212,18 @@ void __init pci_fill_in_pbm_cookies(stru
 				    struct pci_pbm_info *pbm,
 				    int prom_node)
 {
-	struct list_head *walk = &pbus->devices;
-
-	/* This loop is coded like this because the cookie
-	 * fillin routine can delete devices from the tree.
-	 */
-	walk = walk->next;
-	while (walk != &pbus->devices) {
-		struct pci_dev *pdev = pci_dev_b(walk);
-		struct list_head *walk_next = walk->next;
+	struct pci_dev *pdev, *pdev_next;
+	struct pci_bus *this_pbus, *pbus_next;
 
+	/* This must be _safe because the cookie fillin
+	   routine can delete devices from the tree.  */
+	list_for_each_entry_safe(pdev, pdev_next, &pbus->devices, bus_list)
 		pdev_cookie_fillin(pbm, pdev, prom_node);
 
-		walk = walk_next;
-	}
-
-	walk = &pbus->children;
-	walk = walk->next;
-	while (walk != &pbus->children) {
-		struct pci_bus *this_pbus = pci_bus_b(walk);
+	list_for_each_entry_safe(this_pbus, pbus_next, &pbus->children, node) {
 		struct pcidev_cookie *pcp = this_pbus->self->sysdata;
-		struct list_head *walk_next = walk->next;
 
 		pci_fill_in_pbm_cookies(this_pbus, pbm, pcp->prom_node);
-
-		walk = walk_next;
 	}
 }
 
@@ -431,14 +413,14 @@ static void __init pdev_record_assignmen
 void __init pci_record_assignments(struct pci_pbm_info *pbm,
 				   struct pci_bus *pbus)
 {
-	struct list_head *walk = &pbus->devices;
+	struct pci_dev *dev;
+	struct pci_bus *bus;
 
-	for (walk = walk->next; walk != &pbus->devices; walk = walk->next)
-		pdev_record_assignments(pbm, pci_dev_b(walk));
+	list_for_each_entry(dev, &pbus->devices, bus_list)
+		pdev_record_assignments(pbm, dev);
 
-	walk = &pbus->children;
-	for (walk = walk->next; walk != &pbus->children; walk = walk->next)
-		pci_record_assignments(pbm, pci_bus_b(walk));
+	list_for_each_entry(bus, &pbus->children, node)
+		pci_record_assignments(pbm, bus);
 }
 
 /* Return non-zero if PDEV has implicit I/O resources even
@@ -549,14 +531,14 @@ static void __init pdev_assign_unassigne
 void __init pci_assign_unassigned(struct pci_pbm_info *pbm,
 				  struct pci_bus *pbus)
 {
-	struct list_head *walk = &pbus->devices;
+	struct pci_dev *dev;
+	struct pci_bus *bus;
 
-	for (walk = walk->next; walk != &pbus->devices; walk = walk->next)
-		pdev_assign_unassigned(pbm, pci_dev_b(walk));
+	list_for_each_entry(dev, &pbus->devices, bus_list)
+		pdev_assign_unassigned(pbm, dev);
 
-	walk = &pbus->children;
-	for (walk = walk->next; walk != &pbus->children; walk = walk->next)
-		pci_assign_unassigned(pbm, pci_bus_b(walk));
+	list_for_each_entry(bus, &pbus->children, node)
+		pci_assign_unassigned(pbm, bus);
 }
 
 static int __init pci_intmap_match(struct pci_dev *pdev, unsigned int *interrupt)
@@ -797,14 +779,14 @@ have_irq:
 void __init pci_fixup_irq(struct pci_pbm_info *pbm,
 			  struct pci_bus *pbus)
 {
-	struct list_head *walk = &pbus->devices;
+	struct pci_dev *dev;
+	struct pci_bus *bus;
 
-	for (walk = walk->next; walk != &pbus->devices; walk = walk->next)
-		pdev_fixup_irq(pci_dev_b(walk));
+	list_for_each_entry(dev, &pbus->devices, bus_list)
+		pdev_fixup_irq(dev);
 
-	walk = &pbus->children;
-	for (walk = walk->next; walk != &pbus->children; walk = walk->next)
-		pci_fixup_irq(pbm, pci_bus_b(walk));
+	list_for_each_entry(bus, &pbus->children, node)
+		pci_fixup_irq(pbm, bus);
 }
 
 static void pdev_setup_busmastering(struct pci_dev *pdev, int is_66mhz)
@@ -897,7 +879,7 @@ static void pdev_setup_busmastering(stru
 void pci_determine_66mhz_disposition(struct pci_pbm_info *pbm,
 				     struct pci_bus *pbus)
 {
-	struct list_head *walk;
+	struct pci_dev *pdev;
 	int all_are_66mhz;
 	u16 status;
 
@@ -906,11 +888,8 @@ void pci_determine_66mhz_disposition(str
 		goto out;
 	}
 
-	walk = &pbus->devices;
 	all_are_66mhz = 1;
-	for (walk = walk->next; walk != &pbus->devices; walk = walk->next) {
-		struct pci_dev *pdev = pci_dev_b(walk);
-
+	list_for_each_entry(pdev, &pbus->devices, bus_list) {
 		pci_read_config_word(pdev, PCI_STATUS, &status);
 		if (!(status & PCI_STATUS_66MHZ)) {
 			all_are_66mhz = 0;
@@ -929,17 +908,17 @@ out:
 void pci_setup_busmastering(struct pci_pbm_info *pbm,
 			    struct pci_bus *pbus)
 {
-	struct list_head *walk = &pbus->devices;
+	struct pci_dev *dev;
+	struct pci_bus *bus;
 	int is_66mhz;
 
 	is_66mhz = pbm->is_66mhz_capable && pbm->all_devs_66mhz;
 
-	for (walk = walk->next; walk != &pbus->devices; walk = walk->next)
-		pdev_setup_busmastering(pci_dev_b(walk), is_66mhz);
+	list_for_each_entry(dev, &pbus->devices, bus_list)
+		pdev_setup_busmastering(dev, is_66mhz);
 
-	walk = &pbus->children;
-	for (walk = walk->next; walk != &pbus->children; walk = walk->next)
-		pci_setup_busmastering(pbm, pci_bus_b(walk));
+	list_for_each_entry(bus, &pbus->children, node)
+		pci_setup_busmastering(pbm, bus);
 }
 
 void pci_register_legacy_regions(struct resource *io_res,
@@ -987,10 +966,10 @@ void pci_scan_for_target_abort(struct pc
 			       struct pci_pbm_info *pbm,
 			       struct pci_bus *pbus)
 {
-	struct list_head *walk = &pbus->devices;
+	struct pci_dev *pdev;
+	struct pci_bus *bus;
 
-	for (walk = walk->next; walk != &pbus->devices; walk = walk->next) {
-		struct pci_dev *pdev = pci_dev_b(walk);
+	list_for_each_entry(pdev, &pbus->devices, bus_list) {
 		u16 status, error_bits;
 
 		pci_read_config_word(pdev, PCI_STATUS, &status);
@@ -1005,19 +984,18 @@ void pci_scan_for_target_abort(struct pc
 		}
 	}
 
-	walk = &pbus->children;
-	for (walk = walk->next; walk != &pbus->children; walk = walk->next)
-		pci_scan_for_target_abort(p, pbm, pci_bus_b(walk));
+	list_for_each_entry(bus, &pbus->children, node)
+		pci_scan_for_target_abort(p, pbm, bus);
 }
 
 void pci_scan_for_master_abort(struct pci_controller_info *p,
 			       struct pci_pbm_info *pbm,
 			       struct pci_bus *pbus)
 {
-	struct list_head *walk = &pbus->devices;
+	struct pci_dev *pdev;
+	struct pci_bus *bus;
 
-	for (walk = walk->next; walk != &pbus->devices; walk = walk->next) {
-		struct pci_dev *pdev = pci_dev_b(walk);
+	list_for_each_entry(pdev, &pbus->devices, bus_list) {
 		u16 status, error_bits;
 
 		pci_read_config_word(pdev, PCI_STATUS, &status);
@@ -1031,19 +1009,18 @@ void pci_scan_for_master_abort(struct pc
 		}
 	}
 
-	walk = &pbus->children;
-	for (walk = walk->next; walk != &pbus->children; walk = walk->next)
-		pci_scan_for_master_abort(p, pbm, pci_bus_b(walk));
+	list_for_each_entry(bus, &pbus->children, node)
+		pci_scan_for_master_abort(p, pbm, bus);
 }
 
 void pci_scan_for_parity_error(struct pci_controller_info *p,
 			       struct pci_pbm_info *pbm,
 			       struct pci_bus *pbus)
 {
-	struct list_head *walk = &pbus->devices;
+	struct pci_dev *pdev;
+	struct pci_bus *bus;
 
-	for (walk = walk->next; walk != &pbus->devices; walk = walk->next) {
-		struct pci_dev *pdev = pci_dev_b(walk);
+	list_for_each_entry(pdev, &pbus->devices, bus_list) {
 		u16 status, error_bits;
 
 		pci_read_config_word(pdev, PCI_STATUS, &status);
@@ -1058,7 +1035,6 @@ void pci_scan_for_parity_error(struct pc
 		}
 	}
 
-	walk = &pbus->children;
-	for (walk = walk->next; walk != &pbus->children; walk = walk->next)
-		pci_scan_for_parity_error(p, pbm, pci_bus_b(walk));
+	list_for_each_entry(bus, &pbus->children, node)
+		pci_scan_for_parity_error(p, pbm, bus);
 }

_
