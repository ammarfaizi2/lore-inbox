Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267475AbUIAUXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267475AbUIAUXE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267452AbUIAUV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:21:56 -0400
Received: from baikonur.stro.at ([213.239.196.228]:3743 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S267662AbUIAUPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:15:46 -0400
Subject: [patch 08/12]  list_for_each: 	arch-ppc-kernel-pci.c
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:15:45 +0200
Message-ID: <E1C2bWD-0006RC-Ml@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi.

s/for/list_for_each/

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/arch/ppc/kernel/pci.c |   28 ++++++++------------------
 1 files changed, 9 insertions(+), 19 deletions(-)

diff -puN arch/ppc/kernel/pci.c~list-for-each-arch_ppc_kernel_pci arch/ppc/kernel/pci.c
--- linux-2.6.9-rc1-bk7/arch/ppc/kernel/pci.c~list-for-each-arch_ppc_kernel_pci	2004-09-01 19:38:14.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/arch/ppc/kernel/pci.c	2004-09-01 19:38:14.000000000 +0200
@@ -230,14 +230,12 @@ EXPORT_SYMBOL(pcibios_align_resource);
 static void __init
 pcibios_allocate_bus_resources(struct list_head *bus_list)
 {
-	struct list_head *ln;
 	struct pci_bus *bus;
 	int i;
 	struct resource *res, *pr;
 
 	/* Depth-First Search on bus tree */
-	for (ln = bus_list->next; ln != bus_list; ln=ln->next) {
-		bus = pci_bus_b(ln);
+	list_for_each_entry(bus, bus_list, node) {
 		for (i = 0; i < 4; ++i) {
 			if ((res = bus->resource[i]) == NULL || !res->flags
 			    || res->start > res->end)
@@ -380,7 +378,6 @@ probe_resource(struct pci_bus *parent, s
 	struct pci_bus *bus;
 	struct pci_dev *dev;
 	struct resource *r;
-	struct list_head *ln;
 	int i;
 
 	for (r = pr->child; r != NULL; r = r->sibling) {
@@ -389,9 +386,7 @@ probe_resource(struct pci_bus *parent, s
 			return 1;
 		}
 	}
-	for (ln = parent->children.next; ln != &parent->children;
-	     ln = ln->next) {
-		bus = pci_bus_b(ln);
+	list_for_each_entry(bus, &parent->children, node) {
 		for (i = 0; i < 4; ++i) {
 			if ((r = bus->resource[i]) == NULL)
 				continue;
@@ -405,8 +400,7 @@ probe_resource(struct pci_bus *parent, s
 			}
 		}
 	}
-	for (ln = parent->devices.next; ln != &parent->devices; ln=ln->next) {
-		dev = pci_dev_b(ln);
+	list_for_each_entry(dev, &parent->devices, bus_list) {
 		for (i = 0; i < 6; ++i) {
 			r = &dev->resource[i];
 			if (!r->flags || (r->flags & IORESOURCE_UNSET))
@@ -1101,7 +1095,7 @@ do_update_p2p_io_resource(struct pci_bus
 static int __init
 check_for_io_childs(struct pci_bus *bus, struct resource* res, int *found_vga)
 {
-	struct list_head *ln;
+	struct pci_dev *dev;
 	int	i;
 	int	rc = 0;
 
@@ -1109,8 +1103,7 @@ check_for_io_childs(struct pci_bus *bus,
 	res->end = ((res->end + __sz) / (__sz + 1)) * (__sz + 1) + __sz; \
     } while (0)
 
-	for (ln=bus->devices.next; ln != &bus->devices; ln=ln->next) {
-		struct pci_dev *dev = pci_dev_b(ln);
+	list_for_each_entry(dev, &bus->devices, bus_list) {
 		u16 class = dev->class >> 8;
 
 		if (class == PCI_CLASS_DISPLAY_VGA ||
@@ -1151,7 +1144,7 @@ check_for_io_childs(struct pci_bus *bus,
 static void __init
 do_fixup_p2p_level(struct pci_bus *bus)
 {
-	struct list_head *ln;
+	struct pci_bus *b;
 	int i, parent_io;
 	int has_vga = 0;
 
@@ -1162,8 +1155,7 @@ do_fixup_p2p_level(struct pci_bus *bus)
 	if (parent_io >= 4)
 		return;
 
-	for (ln=bus->children.next; ln != &bus->children; ln=ln->next) {
-		struct pci_bus *b = pci_bus_b(ln);
+	list_for_each_entry(b, &bus->children, node) {
 		struct pci_dev *d = b->self;
 		struct pci_controller* hose = (struct pci_controller *)d->sysdata;
 		struct resource *res = b->resource[0];
@@ -1236,12 +1228,10 @@ do_fixup_p2p_level(struct pci_bus *bus)
 static void
 pcibios_fixup_p2p_bridges(void)
 {
-	struct list_head *ln;
+	struct pci_bus *b;
 
-	for(ln=pci_root_buses.next; ln != &pci_root_buses; ln=ln->next) {
-		struct pci_bus *b = pci_bus_b(ln);
+	list_for_each_entry(b, &pci_root_buses, node)
 		do_fixup_p2p_level(b);
-	}
 }
 
 #endif /* CONFIG_PPC_PMAC */

_
