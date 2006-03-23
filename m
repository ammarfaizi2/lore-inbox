Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422673AbWCWUKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422673AbWCWUKq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 15:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422674AbWCWUKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 15:10:46 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:20866 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422673AbWCWUKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 15:10:45 -0500
Date: Thu, 23 Mar 2006 15:10:18 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, galak@kernel.crashing.org,
       gregkh@suse.de, bcrl@kvack.org, Dave Jiang <dave.jiang@gmail.com>,
       arjan@infradead.org, Maneesh Soni <maneesh@in.ibm.com>,
       Murali <muralim@in.ibm.com>
Subject: [RFC][PATCH 9/10] 64 bit resources arch changes
Message-ID: <20060323201018.GM7175@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060323195752.GD7175@in.ibm.com> <20060323195944.GE7175@in.ibm.com> <20060323200119.GF7175@in.ibm.com> <20060323200227.GG7175@in.ibm.com> <20060323200342.GH7175@in.ibm.com> <20060323200451.GI7175@in.ibm.com> <20060323200610.GJ7175@in.ibm.com> <20060323200744.GK7175@in.ibm.com> <20060323200902.GL7175@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323200902.GL7175@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Changes required for various arch/, for 64 bit resources.

Signed-off-by: Dave Jiang <dave.jiang@gmail.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/arm/kernel/bios32.c   |    6 ++---
 arch/arm/kernel/setup.c    |   42 +++++++++++++++++++++++++++++++++++------
 arch/i386/kernel/efi.c     |    6 +++--
 arch/i386/pci/i386.c       |    4 +--
 arch/ppc/kernel/pci.c      |   46 ++++++++++++++++++++++++++-------------------
 arch/sparc/kernel/ioport.c |    8 ++++---
 include/asm-arm/mach/pci.h |    2 -
 7 files changed, 78 insertions(+), 36 deletions(-)

diff -puN arch/arm/kernel/bios32.c~64bit-resources-arch-changes arch/arm/kernel/bios32.c
--- linux-2.6.16-mm1/arch/arm/kernel/bios32.c~64bit-resources-arch-changes	2006-03-23 11:39:21.000000000 -0500
+++ linux-2.6.16-mm1-root/arch/arm/kernel/bios32.c	2006-03-23 11:39:21.000000000 -0500
@@ -304,7 +304,7 @@ static inline int pdev_bad_for_parity(st
 static void __devinit
 pdev_fixup_device_resources(struct pci_sys_data *root, struct pci_dev *dev)
 {
-	unsigned long offset;
+	u64 offset;
 	int i;
 
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
@@ -634,9 +634,9 @@ char * __init pcibios_setup(char *str)
  * which might be mirrored at 0x0100-0x03ff..
  */
 void pcibios_align_resource(void *data, struct resource *res,
-			    unsigned long size, unsigned long align)
+			    u64 size, u64 align)
 {
-	unsigned long start = res->start;
+	u64 start = res->start;
 
 	if (res->flags & IORESOURCE_IO && start & 0x300)
 		start = (start + 0x3ff) & ~0x3ff;
diff -puN arch/arm/kernel/setup.c~64bit-resources-arch-changes arch/arm/kernel/setup.c
--- linux-2.6.16-mm1/arch/arm/kernel/setup.c~64bit-resources-arch-changes	2006-03-23 11:39:21.000000000 -0500
+++ linux-2.6.16-mm1-root/arch/arm/kernel/setup.c	2006-03-23 11:39:21.000000000 -0500
@@ -119,9 +119,24 @@ DEFINE_PER_CPU(struct cpuinfo_arm, cpu_d
  * Standard memory resources
  */
 static struct resource mem_res[] = {
-	{ "Video RAM",   0,     0,     IORESOURCE_MEM			},
-	{ "Kernel text", 0,     0,     IORESOURCE_MEM			},
-	{ "Kernel data", 0,     0,     IORESOURCE_MEM			}
+	{
+		.name = "Video RAM",
+		.start = 0,
+		.end = 0,
+		.flags = IORESOURCE_MEM
+	},
+	{
+		.name = "Kernel text",
+		.start = 0,
+		.end = 0,
+		.flags = IORESOURCE_MEM
+	},
+	{
+		.name = "Kernel data",
+		.start = 0,
+		.end = 0,
+		.flags = IORESOURCE_MEM
+	}
 };
 
 #define video_ram   mem_res[0]
@@ -129,9 +144,24 @@ static struct resource mem_res[] = {
 #define kernel_data mem_res[2]
 
 static struct resource io_res[] = {
-	{ "reserved",    0x3bc, 0x3be, IORESOURCE_IO | IORESOURCE_BUSY },
-	{ "reserved",    0x378, 0x37f, IORESOURCE_IO | IORESOURCE_BUSY },
-	{ "reserved",    0x278, 0x27f, IORESOURCE_IO | IORESOURCE_BUSY }
+	{
+		.name = "reserved",
+		.start = 0x3bc,
+		.end = 0x3be,
+		.flags = IORESOURCE_IO | IORESOURCE_BUSY
+	},
+	{
+		.name = "reserved",
+		.start = 0x378,
+		.end = 0x37f,
+		.flags = IORESOURCE_IO | IORESOURCE_BUSY
+	},
+	{
+		.name = "reserved",
+		.start = 0x278,
+		.end = 0x27f,
+		.flags = IORESOURCE_IO | IORESOURCE_BUSY
+	}
 };
 
 #define lp0 io_res[0]
diff -puN arch/i386/kernel/efi.c~64bit-resources-arch-changes arch/i386/kernel/efi.c
--- linux-2.6.16-mm1/arch/i386/kernel/efi.c~64bit-resources-arch-changes	2006-03-23 11:39:21.000000000 -0500
+++ linux-2.6.16-mm1-root/arch/i386/kernel/efi.c	2006-03-23 11:39:21.000000000 -0500
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
diff -puN arch/i386/pci/i386.c~64bit-resources-arch-changes arch/i386/pci/i386.c
--- linux-2.6.16-mm1/arch/i386/pci/i386.c~64bit-resources-arch-changes	2006-03-23 11:39:21.000000000 -0500
+++ linux-2.6.16-mm1-root/arch/i386/pci/i386.c	2006-03-23 11:39:21.000000000 -0500
@@ -48,10 +48,10 @@
  */
 void
 pcibios_align_resource(void *data, struct resource *res,
-		       unsigned long size, unsigned long align)
+		       u64 size, u64 align)
 {
 	if (res->flags & IORESOURCE_IO) {
-		unsigned long start = res->start;
+		u64 start = res->start;
 
 		if (start & 0x300) {
 			start = (start + 0x3ff) & ~0x3ff;
diff -puN arch/ppc/kernel/pci.c~64bit-resources-arch-changes arch/ppc/kernel/pci.c
--- linux-2.6.16-mm1/arch/ppc/kernel/pci.c~64bit-resources-arch-changes	2006-03-23 11:39:21.000000000 -0500
+++ linux-2.6.16-mm1-root/arch/ppc/kernel/pci.c	2006-03-23 11:39:21.000000000 -0500
@@ -98,8 +98,10 @@ pcibios_fixup_resources(struct pci_dev *
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
@@ -172,18 +174,18 @@ EXPORT_SYMBOL(pcibios_bus_to_resource);
  * but we want to try to avoid allocating at 0x2900-0x2bff
  * which might have be mirrored at 0x0100-0x03ff..
  */
-void pcibios_align_resource(void *data, struct resource *res, unsigned long size,
-		       unsigned long align)
+void pcibios_align_resource(void *data, struct resource *res, u64 size,
+		       u64 align)
 {
 	struct pci_dev *dev = data;
 
 	if (res->flags & IORESOURCE_IO) {
-		unsigned long start = res->start;
+		u64 start = res->start;
 
 		if (size > 0x100) {
 			printk(KERN_ERR "PCI: I/O Region %s/%d too large"
-			       " (%ld bytes)\n", pci_name(dev),
-			       dev->resource - res, size);
+			       " (%lld bytes)\n", pci_name(dev),
+			       dev->resource - res, (unsigned long long)size);
 		}
 
 		if (start & 0x300) {
@@ -254,8 +256,9 @@ pcibios_allocate_bus_resources(struct li
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
@@ -305,8 +308,9 @@ reparent_resources(struct resource *pare
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
@@ -361,13 +365,15 @@ pci_relocate_bridge_resource(struct pci_
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
 
@@ -478,15 +484,17 @@ static inline void alloc_resource(struct
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
diff -puN arch/sparc/kernel/ioport.c~64bit-resources-arch-changes arch/sparc/kernel/ioport.c
--- linux-2.6.16-mm1/arch/sparc/kernel/ioport.c~64bit-resources-arch-changes	2006-03-23 11:39:21.000000000 -0500
+++ linux-2.6.16-mm1-root/arch/sparc/kernel/ioport.c	2006-03-23 11:39:21.000000000 -0500
@@ -206,7 +206,7 @@ _sparc_ioremap(struct resource *res, u32
 	pa &= PAGE_MASK;
 	sparc_mapiorange(bus, pa, res->start, res->end - res->start + 1);
 
-	return (void __iomem *) (res->start + offset);
+	return (void __iomem *)(unsigned long)(res->start + offset);
 }
 
 /*
@@ -274,7 +274,7 @@ void *sbus_alloc_consistent(struct sbus_
 	if (mmu_map_dma_area(dma_addrp, va, res->start, len_total) != 0)
 		goto err_noiommu;
 
-	return (void *)res->start;
+	return (void *)(unsigned long)res->start;
 
 err_noiommu:
 	release_resource(res);
@@ -685,7 +685,9 @@ _sparc_io_get_info(char *buf, char **sta
 		if (p + 32 >= e)	/* Better than nothing */
 			break;
 		if ((nm = r->name) == 0) nm = "???";
-		p += sprintf(p, "%08lx-%08lx: %s\n", r->start, r->end, nm);
+		p += sprintf(p, "%016llx-%016llx: %s\n",
+				(unsigned long long)r->start,
+				(unsigned long long)r->end, nm);
 	}
 
 	return p-buf;
diff -puN include/asm-arm/mach/pci.h~64bit-resources-arch-changes include/asm-arm/mach/pci.h
--- linux-2.6.16-mm1/include/asm-arm/mach/pci.h~64bit-resources-arch-changes	2006-03-23 11:39:21.000000000 -0500
+++ linux-2.6.16-mm1-root/include/asm-arm/mach/pci.h	2006-03-23 11:39:21.000000000 -0500
@@ -28,7 +28,7 @@ struct hw_pci {
 struct pci_sys_data {
 	struct list_head node;
 	int		busnr;		/* primary bus number			*/
-	unsigned long	mem_offset;	/* bus->cpu memory mapping offset	*/
+	u64		mem_offset;	/* bus->cpu memory mapping offset	*/
 	unsigned long	io_offset;	/* bus->cpu IO mapping offset		*/
 	struct pci_bus	*bus;		/* PCI bus				*/
 	struct resource *resource[3];	/* Primary PCI bus resources		*/
_
