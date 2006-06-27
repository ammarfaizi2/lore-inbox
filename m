Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161186AbWF0Qhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161186AbWF0Qhp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161185AbWF0Qho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:37:44 -0400
Received: from cantor2.suse.de ([195.135.220.15]:42730 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161183AbWF0Qhm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:37:42 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       Andy Isaacson <adi@hexapodia.org>
Subject: [PATCH 9/17] [PATCH] 64bit resource: fix up printks for resources in arch and core code
Reply-To: Greg KH <greg@kroah.com>
Date: Tue, 27 Jun 2006 09:33:45 -0700
Message-Id: <11514260612035-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11514260583661-git-send-email-greg@kroah.com>
References: <20060627163317.GA31073@kroah.com> <11514260331421-git-send-email-greg@kroah.com> <11514260373971-git-send-email-greg@kroah.com> <115142604066-git-send-email-greg@kroah.com> <11514260442539-git-send-email-greg@kroah.com> <11514260483754-git-send-email-greg@kroah.com> <11514260513485-git-send-email-greg@kroah.com> <11514260543854-git-send-email-greg@kroah.com> <11514260583661-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

This is needed if we wish to change the size of the resource structures.

Based on an original patch from Vivek Goyal <vgoyal@in.ibm.com> and
Andrew Morton.

(tweaked by Andy Isaacson <adi@hexapodia.org>)

Cc: Vivek Goyal <vgoyal@in.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Andy Isaacson <adi@hexapodia.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/i386/kernel/efi.c                |    6 +++--
 arch/powerpc/kernel/pci_32.c          |   37 +++++++++++++++--------------
 arch/powerpc/platforms/83xx/pci.c     |    5 ++--
 arch/powerpc/platforms/85xx/pci.c     |    5 ++--
 arch/powerpc/platforms/chrp/pci.c     |    4 ++-
 arch/powerpc/platforms/maple/pci.c    |    5 ++--
 arch/powerpc/platforms/powermac/pci.c |    5 ++--
 arch/ppc/kernel/pci.c                 |   42 ++++++++++++++++++++-------------
 arch/sparc/kernel/ioport.c            |    4 ++-
 kernel/resource.c                     |   10 +++++---
 10 files changed, 71 insertions(+), 52 deletions(-)

diff --git a/arch/i386/kernel/efi.c b/arch/i386/kernel/efi.c
index 9202b67..8beb0f0 100644
--- a/arch/i386/kernel/efi.c
+++ b/arch/i386/kernel/efi.c
@@ -601,8 +601,10 @@ efi_initialize_iomem_resources(struct re
 		res->end = res->start + ((md->num_pages << EFI_PAGE_SHIFT) - 1);
 		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 		if (request_resource(&iomem_resource, res) < 0)
-			printk(KERN_ERR PFX "Failed to allocate res %s : 0x%lx-0x%lx\n",
-				res->name, res->start, res->end);
+			printk(KERN_ERR PFX "Failed to allocate res %s : "
+				"0x%llx-0x%llx\n", res->name,
+				(unsigned long long)res->start,
+				(unsigned long long)res->end);
 		/*
 		 * We don't know which region contains kernel data so we try
 		 * it repeatedly and let the resource manager test it.
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index b5431cc..d9e2506 100644
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
@@ -183,7 +183,7 @@ void pcibios_align_resource(void *data, 
 
 		if (size > 0x100) {
 			printk(KERN_ERR "PCI: I/O Region %s/%d too large"
-			       " (%ld bytes)\n", pci_name(dev),
+			       " (%lld bytes)\n", pci_name(dev),
 			       dev->resource - res, size);
 		}
 
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
@@ -362,13 +362,14 @@ pci_relocate_bridge_resource(struct pci_
 		try = conflict->start - 1;
 	}
 	if (request_resource(pr, res)) {
-		DBG(KERN_ERR "PCI: huh? couldn't move to %lx..%lx\n",
+		DBG(KERN_ERR "PCI: huh? couldn't move to %llx..%llx\n",
 		    res->start, res->end);
 		return -1;		/* "can't happen" */
 	}
 	update_bridge_base(bus, i);
-	printk(KERN_INFO "PCI: bridge %d resource %d moved to %lx..%lx\n",
-	       bus->number, i, res->start, res->end);
+	printk(KERN_INFO "PCI: bridge %d resource %d moved to %llx..%llx\n",
+	       bus->number, i, (unsigned long long)res->start,
+	       (unsigned long long)res->end);
 	return 0;
 }
 
@@ -479,14 +480,14 @@ static inline void alloc_resource(struct
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
@@ -956,7 +957,7 @@ pci_process_bridge_OF_ranges(struct pci_
 			res = &hose->io_resource;
 			res->flags = IORESOURCE_IO;
 			res->start = ranges[2];
-			DBG("PCI: IO 0x%lx -> 0x%lx\n",
+			DBG("PCI: IO 0x%llx -> 0x%llx\n",
 				    res->start, res->start + size - 1);
 			break;
 		case 2:		/* memory space */
@@ -978,7 +979,7 @@ pci_process_bridge_OF_ranges(struct pci_
 				if(ranges[0] & 0x40000000)
 					res->flags |= IORESOURCE_PREFETCH;
 				res->start = ranges[na+2];
-				DBG("PCI: MEM[%d] 0x%lx -> 0x%lx\n", memno,
+				DBG("PCI: MEM[%d] 0x%llx -> 0x%llx\n", memno,
 					    res->start, res->start + size - 1);
 			}
 			break;
@@ -1074,7 +1075,7 @@ do_update_p2p_io_resource(struct pci_bus
 	DBG("Remapping Bus %d, bridge: %s\n", bus->number, pci_name(bridge));
 	res.start -= ((unsigned long) hose->io_base_virt - isa_io_base);
 	res.end -= ((unsigned long) hose->io_base_virt - isa_io_base);
-	DBG("  IO window: %08lx-%08lx\n", res.start, res.end);
+	DBG("  IO window: %016llx-%016llx\n", res.start, res.end);
 
 	/* Set up the top and bottom of the PCI I/O segment for this bus. */
 	pci_read_config_dword(bridge, PCI_IO_BASE, &l);
@@ -1223,8 +1224,8 @@ do_fixup_p2p_level(struct pci_bus *bus)
 					continue;
 				if ((r->flags & IORESOURCE_IO) == 0)
 					continue;
-				DBG("Trying to allocate from %08lx, size %08lx from parent"
-				    " res %d: %08lx -> %08lx\n",
+				DBG("Trying to allocate from %016llx, size %016llx from parent"
+				    " res %d: %016llx -> %016llx\n",
 					res->start, res->end, i, r->start, r->end);
 			
 				if (allocate_resource(r, res, res->end + 1, res->start, max,
@@ -1574,8 +1575,8 @@ static pgprot_t __pci_mmap_set_pgprot(st
 	else
 		prot |= _PAGE_GUARDED;
 
-	printk("PCI map for %s:%lx, prot: %lx\n", pci_name(dev), rp->start,
-	       prot);
+	printk("PCI map for %s:%llx, prot: %lx\n", pci_name(dev),
+		(unsigned long long)rp->start, prot);
 
 	return __pgprot(prot);
 }
diff --git a/arch/powerpc/platforms/83xx/pci.c b/arch/powerpc/platforms/83xx/pci.c
index 16f7d3b..3baceb0 100644
--- a/arch/powerpc/platforms/83xx/pci.c
+++ b/arch/powerpc/platforms/83xx/pci.c
@@ -91,9 +91,10 @@ int __init add_bridge(struct device_node
 		mpc83xx_pci2_busno = hose->first_busno;
 	}
 
-	printk(KERN_INFO "Found MPC83xx PCI host bridge at 0x%08lx. "
+	printk(KERN_INFO "Found MPC83xx PCI host bridge at 0x%016llx. "
 	       "Firmware bus number: %d->%d\n",
-	       rsrc.start, hose->first_busno, hose->last_busno);
+	       (unsigned long long)rsrc.start, hose->first_busno,
+	       hose->last_busno);
 
 	DBG(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
 	    hose, hose->cfg_addr, hose->cfg_data);
diff --git a/arch/powerpc/platforms/85xx/pci.c b/arch/powerpc/platforms/85xx/pci.c
index bad2901..48c8849 100644
--- a/arch/powerpc/platforms/85xx/pci.c
+++ b/arch/powerpc/platforms/85xx/pci.c
@@ -79,9 +79,10 @@ int __init add_bridge(struct device_node
 		mpc85xx_pci2_busno = hose->first_busno;
 	}
 
-	printk(KERN_INFO "Found MPC85xx PCI host bridge at 0x%08lx. "
+	printk(KERN_INFO "Found MPC85xx PCI host bridge at 0x%016llx. "
 	       "Firmware bus number: %d->%d\n",
-		rsrc.start, hose->first_busno, hose->last_busno);
+		(unsigned long long)rsrc.start, hose->first_busno,
+		hose->last_busno);
 
 	DBG(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
 		hose, hose->cfg_addr, hose->cfg_data);
diff --git a/arch/powerpc/platforms/chrp/pci.c b/arch/powerpc/platforms/chrp/pci.c
index ac22487..53515da 100644
--- a/arch/powerpc/platforms/chrp/pci.c
+++ b/arch/powerpc/platforms/chrp/pci.c
@@ -143,7 +143,7 @@ hydra_init(void)
 	if (np == NULL || of_address_to_resource(np, 0, &r))
 		return 0;
 	Hydra = ioremap(r.start, r.end-r.start);
-	printk("Hydra Mac I/O at %lx\n", r.start);
+	printk("Hydra Mac I/O at %llx\n", (unsigned long long)r.start);
 	printk("Hydra Feature_Control was %x",
 	       in_le32(&Hydra->Feature_Control));
 	out_le32(&Hydra->Feature_Control, (HYDRA_FC_SCC_CELL_EN |
@@ -267,7 +267,7 @@ chrp_find_bridges(void)
 			       bus_range[0], bus_range[1]);
 		printk(" controlled by %s", dev->type);
 		if (!is_longtrail)
-			printk(" at %lx", r.start);
+			printk(" at %llx", (unsigned long long)r.start);
 		printk("\n");
 
 		hose = pcibios_alloc_controller();
diff --git a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
index 9a4efc0..f7170ff 100644
--- a/arch/powerpc/platforms/maple/pci.c
+++ b/arch/powerpc/platforms/maple/pci.c
@@ -376,9 +376,10 @@ static void __init maple_fixup_phb_resou
 		unsigned long offset = (unsigned long)hose->io_base_virt - pci_io_base;
 		hose->io_resource.start += offset;
 		hose->io_resource.end += offset;
-		printk(KERN_INFO "PCI Host %d, io start: %lx; io end: %lx\n",
+		printk(KERN_INFO "PCI Host %d, io start: %llx; io end: %llx\n",
 		       hose->global_number,
-		       hose->io_resource.start, hose->io_resource.end);
+		       (unsigned long long)hose->io_resource.start,
+		       (unsigned long long)hose->io_resource.end);
 	}
 }
 
diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index 8003585..d524a91 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -939,9 +939,10 @@ #ifdef CONFIG_PPC32
 		disp_name = "Chaos";
 		primary = 0;
 	}
-	printk(KERN_INFO "Found %s PCI host bridge at 0x%08lx. "
+	printk(KERN_INFO "Found %s PCI host bridge at 0x%016llx. "
 	       "Firmware bus number: %d->%d\n",
-		disp_name, rsrc.start, hose->first_busno, hose->last_busno);
+		disp_name, (unsigned long long)rsrc.start, hose->first_busno,
+		hose->last_busno);
 #endif /* CONFIG_PPC32 */
 
 	DBG(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
diff --git a/arch/ppc/kernel/pci.c b/arch/ppc/kernel/pci.c
index d20accf..8544e10 100644
--- a/arch/ppc/kernel/pci.c
+++ b/arch/ppc/kernel/pci.c
@@ -95,8 +95,10 @@ pcibios_fixup_resources(struct pci_dev *
 		if (!res->flags)
 			continue;
 		if (res->end == 0xffffffff) {
-			DBG("PCI:%s Resource %d [%08lx-%08lx] is unassigned\n",
-			    pci_name(dev), i, res->start, res->end);
+			DBG("PCI:%s Resource %d [%016llx-%016llx] is unassigned\n",
+				pci_name(dev), i,
+				(unsigned long long)res->start,
+				(unsigned long long)res->end);
 			res->end -= res->start;
 			res->start = 0;
 			res->flags |= IORESOURCE_UNSET;
@@ -179,8 +181,8 @@ void pcibios_align_resource(void *data, 
 
 		if (size > 0x100) {
 			printk(KERN_ERR "PCI: I/O Region %s/%d too large"
-			       " (%ld bytes)\n", pci_name(dev),
-			       dev->resource - res, size);
+			       " (%lld bytes)\n", pci_name(dev),
+			       dev->resource - res, (unsigned long long)size);
 		}
 
 		if (start & 0x300) {
@@ -251,8 +253,9 @@ pcibios_allocate_bus_resources(struct li
 				}
 			}
 
-			DBG("PCI: bridge rsrc %lx..%lx (%lx), parent %p\n",
-			    res->start, res->end, res->flags, pr);
+			DBG("PCI: bridge rsrc %llx..%llx (%lx), parent %p\n",
+				(unsigned long long)res->start,
+				(unsigned long long)res->end, res->flags, pr);
 			if (pr) {
 				if (request_resource(pr, res) == 0)
 					continue;
@@ -302,8 +305,9 @@ reparent_resources(struct resource *pare
 	*pp = NULL;
 	for (p = res->child; p != NULL; p = p->sibling) {
 		p->parent = res;
-		DBG(KERN_INFO "PCI: reparented %s [%lx..%lx] under %s\n",
-		    p->name, p->start, p->end, res->name);
+		DBG(KERN_INFO "PCI: reparented %s [%llx..%llx] under %s\n",
+			p->name, (unsigned long long)p->start,
+			(unsigned long long)p->end, res->name);
 	}
 	return 0;
 }
@@ -358,13 +362,15 @@ pci_relocate_bridge_resource(struct pci_
 		try = conflict->start - 1;
 	}
 	if (request_resource(pr, res)) {
-		DBG(KERN_ERR "PCI: huh? couldn't move to %lx..%lx\n",
-		    res->start, res->end);
+		DBG(KERN_ERR "PCI: huh? couldn't move to %llx..%llx\n",
+			(unsigned long long)res->start,
+			(unsigned long long)res->end);
 		return -1;		/* "can't happen" */
 	}
 	update_bridge_base(bus, i);
-	printk(KERN_INFO "PCI: bridge %d resource %d moved to %lx..%lx\n",
-	       bus->number, i, res->start, res->end);
+	printk(KERN_INFO "PCI: bridge %d resource %d moved to %llx..%llx\n",
+		bus->number, i, (unsigned long long)res->start,
+		(unsigned long long)res->end);
 	return 0;
 }
 
@@ -475,15 +481,17 @@ static inline void alloc_resource(struct
 {
 	struct resource *pr, *r = &dev->resource[idx];
 
-	DBG("PCI:%s: Resource %d: %08lx-%08lx (f=%lx)\n",
-	    pci_name(dev), idx, r->start, r->end, r->flags);
+	DBG("PCI:%s: Resource %d: %016llx-%016llx (f=%lx)\n",
+	    pci_name(dev), idx, (unsigned long long)r->start,
+	    (unsigned long long)r->end, r->flags);
 	pr = pci_find_parent_resource(dev, r);
 	if (!pr || request_resource(pr, r) < 0) {
 		printk(KERN_ERR "PCI: Cannot allocate resource region %d"
 		       " of device %s\n", idx, pci_name(dev));
 		if (pr)
-			DBG("PCI:  parent is %p: %08lx-%08lx (f=%lx)\n",
-			    pr, pr->start, pr->end, pr->flags);
+			DBG("PCI:  parent is %p: %016llx-%016llx (f=%lx)\n",
+				pr, (unsigned long long)pr->start,
+				(unsigned long long)pr->end, pr->flags);
 		/* We'll assign a new address later */
 		r->flags |= IORESOURCE_UNSET;
 		r->end -= r->start;
@@ -952,7 +960,7 @@ static pgprot_t __pci_mmap_set_pgprot(st
 	else
 		prot |= _PAGE_GUARDED;
 
-	printk("PCI map for %s:%lx, prot: %lx\n", pci_name(dev), rp->start,
+	printk("PCI map for %s:%llx, prot: %llx\n", pci_name(dev), rp->start,
 	       prot);
 
 	return __pgprot(prot);
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index ae4c667..99d716b 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -819,7 +819,9 @@ _sparc_io_get_info(char *buf, char **sta
 		if (p + 32 >= e)	/* Better than nothing */
 			break;
 		if ((nm = r->name) == 0) nm = "???";
-		p += sprintf(p, "%08lx-%08lx: %s\n", r->start, r->end, nm);
+		p += sprintf(p, "%016llx-%016llx: %s\n",
+				(unsigned long long)r->start,
+				(unsigned long long)r->end, nm);
 	}
 
 	return p-buf;
diff --git a/kernel/resource.c b/kernel/resource.c
index e3080fc..ea5f781 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -83,10 +83,10 @@ static int r_show(struct seq_file *m, vo
 	for (depth = 0, p = r; depth < MAX_IORES_LEVEL; depth++, p = p->parent)
 		if (p->parent == root)
 			break;
-	seq_printf(m, "%*s%0*lx-%0*lx : %s\n",
+	seq_printf(m, "%*s%0*llx-%0*llx : %s\n",
 			depth * 2, "",
-			width, r->start,
-			width, r->end,
+			width, (unsigned long long) r->start,
+			width, (unsigned long long) r->end,
 			r->name ? r->name : "<BAD>");
 	return 0;
 }
@@ -511,7 +511,9 @@ void __release_region(struct resource *p
 
 	write_unlock(&resource_lock);
 
-	printk(KERN_WARNING "Trying to free nonexistent resource <%08lx-%08lx>\n", start, end);
+	printk(KERN_WARNING "Trying to free nonexistent resource "
+		"<%016llx-%016llx>\n", (unsigned long long)start,
+		(unsigned long long)end);
 }
 
 EXPORT_SYMBOL(__release_region);
-- 
1.4.0

