Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWDJSNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWDJSNZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 14:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWDJSNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 14:13:25 -0400
Received: from gate.crashing.org ([63.228.1.57]:6366 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932066AbWDJSNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 14:13:24 -0400
Date: Mon, 10 Apr 2006 13:11:26 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: fixup pci resource DBG code to handle size change
Message-ID: <Pine.LNX.4.44.0604101310560.3666-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A number of DBG() calls needed to be fixed up to properly handle the size
change in struct resource

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 8e55334e29b2996d921641911a3802f9d004566d
tree 723945265ad953fd6ce4f59c66e560165e78da41
parent 6d05f46f58f45d4aa74cf328f9f7935a71d4fe87
author Kumar Gala <galak@kernel.crashing.org> Mon, 10 Apr 2006 13:10:45 -0500
committer Kumar Gala <galak@kernel.crashing.org> Mon, 10 Apr 2006 13:10:45 -0500

 arch/powerpc/kernel/pci_32.c |   28 ++++++++++++++--------------
 arch/ppc/kernel/pci.c        |    2 +-
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 96a5ee9..9607a09 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -99,7 +99,7 @@ pcibios_fixup_resources(struct pci_dev *
 		if (!res->flags)
 			continue;
 		if (res->end == 0xffffffff) {
-			DBG("PCI:%s Resource %d [%08lx-%08lx] is unassigned\n",
+			DBG("PCI:%s Resource %d [%016llx-%016llx] is unassigned\n",
 			    pci_name(dev), i, res->start, res->end);
 			res->end -= res->start;
 			res->start = 0;
@@ -117,7 +117,7 @@ pcibios_fixup_resources(struct pci_dev *
 			res->start += offset;
 			res->end += offset;
 #ifdef DEBUG
-			printk("Fixup res %d (%lx) of dev %s: %lx -> %lx\n",
+			printk("Fixup res %d (%lx) of dev %s: %llx -> %llx\n",
 			       i, res->flags, pci_name(dev),
 			       res->start - offset, res->start);
 #endif
@@ -179,7 +179,7 @@ void pcibios_align_resource(void *data, 
 	struct pci_dev *dev = data;
 
 	if (res->flags & IORESOURCE_IO) {
-		unsigned long start = res->start;
+		u64 start = res->start;
 
 		if (size > 0x100) {
 			printk(KERN_ERR "PCI: I/O Region %s/%d too large"
@@ -255,8 +255,8 @@ pcibios_allocate_bus_resources(struct li
 				}
 			}
 
-			DBG("PCI: bridge rsrc %lx..%lx (%lx), parent %p\n",
-			    res->start, res->end, res->flags, pr);
+			DBG("PCI: bridge rsrc %llx..%llx (%lx), parent %p\n",
+				res->start, res->end, res->flags, pr);
 			if (pr) {
 				if (request_resource(pr, res) == 0)
 					continue;
@@ -306,7 +306,7 @@ reparent_resources(struct resource *pare
 	*pp = NULL;
 	for (p = res->child; p != NULL; p = p->sibling) {
 		p->parent = res;
-		DBG(KERN_INFO "PCI: reparented %s [%lx..%lx] under %s\n",
+		DBG(KERN_INFO "PCI: reparented %s [%llx..%llx] under %s\n",
 		    p->name, p->start, p->end, res->name);
 	}
 	return 0;
@@ -362,7 +362,7 @@ pci_relocate_bridge_resource(struct pci_
 		try = conflict->start - 1;
 	}
 	if (request_resource(pr, res)) {
-		DBG(KERN_ERR "PCI: huh? couldn't move to %lx..%lx\n",
+		DBG(KERN_ERR "PCI: huh? couldn't move to %llx..%llx\n",
 		    res->start, res->end);
 		return -1;		/* "can't happen" */
 	}
@@ -480,14 +480,14 @@ static inline void alloc_resource(struct
 {
 	struct resource *pr, *r = &dev->resource[idx];
 
-	DBG("PCI:%s: Resource %d: %08lx-%08lx (f=%lx)\n",
+	DBG("PCI:%s: Resource %d: %016llx-%016llx (f=%lx)\n",
 	    pci_name(dev), idx, r->start, r->end, r->flags);
 	pr = pci_find_parent_resource(dev, r);
 	if (!pr || request_resource(pr, r) < 0) {
 		printk(KERN_ERR "PCI: Cannot allocate resource region %d"
 		       " of device %s\n", idx, pci_name(dev));
 		if (pr)
-			DBG("PCI:  parent is %p: %08lx-%08lx (f=%lx)\n",
+			DBG("PCI:  parent is %p: %016llx-%016llx (f=%lx)\n",
 			    pr, pr->start, pr->end, pr->flags);
 		/* We'll assign a new address later */
 		r->flags |= IORESOURCE_UNSET;
@@ -957,7 +957,7 @@ pci_process_bridge_OF_ranges(struct pci_
 			res = &hose->io_resource;
 			res->flags = IORESOURCE_IO;
 			res->start = ranges[2];
-			DBG("PCI: IO 0x%lx -> 0x%lx\n",
+			DBG("PCI: IO 0x%llx -> 0x%llx\n",
 				    res->start, res->start + size - 1);
 			break;
 		case 2:		/* memory space */
@@ -979,7 +979,7 @@ pci_process_bridge_OF_ranges(struct pci_
 				if(ranges[0] & 0x40000000)
 					res->flags |= IORESOURCE_PREFETCH;
 				res->start = ranges[na+2];
-				DBG("PCI: MEM[%d] 0x%lx -> 0x%lx\n", memno,
+				DBG("PCI: MEM[%d] 0x%llx -> 0x%llx\n", memno,
 					    res->start, res->start + size - 1);
 			}
 			break;
@@ -1075,7 +1075,7 @@ do_update_p2p_io_resource(struct pci_bus
 	DBG("Remapping Bus %d, bridge: %s\n", bus->number, pci_name(bridge));
 	res.start -= ((unsigned long) hose->io_base_virt - isa_io_base);
 	res.end -= ((unsigned long) hose->io_base_virt - isa_io_base);
-	DBG("  IO window: %08lx-%08lx\n", res.start, res.end);
+	DBG("  IO window: %016llx-%016llx\n", res.start, res.end);
 
 	/* Set up the top and bottom of the PCI I/O segment for this bus. */
 	pci_read_config_dword(bridge, PCI_IO_BASE, &l);
@@ -1223,8 +1223,8 @@ do_fixup_p2p_level(struct pci_bus *bus)
 					continue;
 				if ((r->flags & IORESOURCE_IO) == 0)
 					continue;
-				DBG("Trying to allocate from %08lx, size %08lx from parent"
-				    " res %d: %08lx -> %08lx\n",
+				DBG("Trying to allocate from %016llx, size %016llx from parent"
+				    " res %d: %016llx -> %016llx\n",
 					res->start, res->end, i, r->start, r->end);
 			
 				if (allocate_resource(r, res, res->end + 1, res->start, max,
diff --git a/arch/ppc/kernel/pci.c b/arch/ppc/kernel/pci.c
index ffbae40..fb25b30 100644
--- a/arch/ppc/kernel/pci.c
+++ b/arch/ppc/kernel/pci.c
@@ -960,7 +960,7 @@ static pgprot_t __pci_mmap_set_pgprot(st
 	else
 		prot |= _PAGE_GUARDED;
 
-	printk("PCI map for %s:%lx, prot: %lx\n", pci_name(dev), rp->start,
+	printk("PCI map for %s:%llx, prot: %llx\n", pci_name(dev), rp->start,
 	       prot);
 
 	return __pgprot(prot);

