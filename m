Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266543AbUI0JSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266543AbUI0JSQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 05:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266467AbUI0JSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 05:18:16 -0400
Received: from gate.crashing.org ([63.228.1.57]:35979 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266547AbUI0JOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 05:14:46 -0400
Subject: [PATCH] ppc64: Make the DART "iommu" code more generic
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1096276351.1102.40.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 27 Sep 2004 19:12:32 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The "DART" iommu used on Apple U3 chipset will appear into 3rd party
products soon, thus the code shouldn't be named "pmac_*" anymore.
Also, the explicit config option is no longer needed, there is no
reason to build a PowerMac kernel without the iommu support, and
it can always be disabled at runtime with a cmdline option for
testing or debugging.

This patch do the appropriate renaming and makes the config option
implicit & selected when pmac support is included.

(Patch looks big because of the file renaming)

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

diff -Nru a/arch/ppc64/Kconfig b/arch/ppc64/Kconfig
--- a/arch/ppc64/Kconfig	2004-09-27 19:12:49 +10:00
+++ b/arch/ppc64/Kconfig	2004-09-27 19:12:49 +10:00
@@ -78,6 +78,7 @@
 	bool "  Apple G5 based machines"
 	default y
 	select ADB_PMU
+	select U3_DART
 
 config PPC
 	bool
@@ -109,16 +110,10 @@
 	  processors, that is, which share physical processors between
 	  two or more partitions.
 
-config PMAC_DART
-	bool "Enable DART/IOMMU on PowerMac (allow >2G of RAM)"
-	depends on PPC_PMAC
-	depends on EXPERIMENTAL
+config U3_DART
+	bool 
+	depends on PPC_MULTIPLATFORM
 	default n
-	help
-	  Enabling DART makes it possible to boot a PowerMac G5 with more
-	  than 2GB of memory. Note that the code is very new and untested
-	  at this time, so it has to be considered experimental. Enabling
-	  this might result in data loss.
 
 config PPC_PMAC64
 	bool
diff -Nru a/arch/ppc64/kernel/Makefile b/arch/ppc64/kernel/Makefile
--- a/arch/ppc64/kernel/Makefile	2004-09-27 19:12:49 +10:00
+++ b/arch/ppc64/kernel/Makefile	2004-09-27 19:12:49 +10:00
@@ -49,7 +49,7 @@
 obj-$(CONFIG_PPC_PMAC)		+= pmac_setup.o pmac_feature.o pmac_pci.o \
 				   pmac_time.o pmac_nvram.o pmac_low_i2c.o \
 				   open_pic_u3.o
-obj-$(CONFIG_PMAC_DART)		+= pmac_iommu.o
+obj-$(CONFIG_U3_DART)		+= u3_iommu.o
 
 ifdef CONFIG_SMP
 obj-$(CONFIG_PPC_PMAC)		+= pmac_smp.o smp-tbsync.o
diff -Nru a/arch/ppc64/kernel/pmac.h b/arch/ppc64/kernel/pmac.h
--- a/arch/ppc64/kernel/pmac.h	2004-09-27 19:12:49 +10:00
+++ b/arch/ppc64/kernel/pmac.h	2004-09-27 19:12:49 +10:00
@@ -29,6 +29,4 @@
 
 extern void pmac_nvram_init(void);
 
-extern void pmac_iommu_alloc(void);
-
 #endif /* __PMAC_H__ */
diff -Nru a/arch/ppc64/kernel/pmac_iommu.c b/arch/ppc64/kernel/pmac_iommu.c
--- a/arch/ppc64/kernel/pmac_iommu.c	2004-09-27 19:12:49 +10:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,321 +0,0 @@
-/*
- * arch/ppc64/kernel/pmac_iommu.c
- *
- * Copyright (C) 2004 Olof Johansson <olof@austin.ibm.com>, IBM Corporation
- *
- * Based on pSeries_iommu.c:
- * Copyright (C) 2001 Mike Corrigan & Dave Engebretsen, IBM Corporation
- * Copyright (C) 2004 Olof Johansson <olof@austin.ibm.com>, IBM Corporation
- *
- * Dynamic DMA mapping support, PowerMac G5 (DART)-specific parts.
- *
- * 
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- * 
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- * 
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-
-#include <linux/config.h>
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/slab.h>
-#include <linux/mm.h>
-#include <linux/spinlock.h>
-#include <linux/string.h>
-#include <linux/pci.h>
-#include <linux/dma-mapping.h>
-#include <linux/vmalloc.h>
-#include <asm/io.h>
-#include <asm/prom.h>
-#include <asm/ppcdebug.h>
-#include <asm/iommu.h>
-#include <asm/pci-bridge.h>
-#include <asm/machdep.h>
-#include <asm/abs_addr.h>
-#include <asm/cacheflush.h>
-#include <asm/lmb.h>
-
-#include "pci.h"
-
-
-/* physical base of DART registers */
-#define DART_BASE        0xf8033000UL
-
-/* Offset from base to control register */
-#define DARTCNTL   0
-/* Offset from base to exception register */
-#define DARTEXCP   0x10
-/* Offset from base to TLB tag registers */
-#define DARTTAG    0x1000
-
-
-/* Control Register fields */
-
-/* base address of table (pfn) */
-#define DARTCNTL_BASE_MASK    0xfffff
-#define DARTCNTL_BASE_SHIFT   12
-
-#define DARTCNTL_FLUSHTLB     0x400
-#define DARTCNTL_ENABLE       0x200
-
-/* size of table in pages */
-#define DARTCNTL_SIZE_MASK    0x1ff
-#define DARTCNTL_SIZE_SHIFT   0
-
-/* DART table fields */
-#define DARTMAP_VALID   0x80000000
-#define DARTMAP_RPNMASK 0x00ffffff
-
-/* Physical base address and size of the DART table */
-unsigned long dart_tablebase; /* exported to htab_initialize */
-static unsigned long dart_tablesize;
-
-/* Virtual base address of the DART table */
-static u32 *dart_vbase;
-
-/* Mapped base address for the dart */
-static unsigned int *dart; 
-
-/* Dummy val that entries are set to when unused */
-static unsigned int dart_emptyval;
-
-static struct iommu_table iommu_table_pmac;
-static int dart_dirty;
-
-#define DBG(...)
-
-static inline void dart_tlb_invalidate_all(void)
-{
-	unsigned long l = 0;
-	unsigned int reg;
-	unsigned long limit;
-
-	DBG("dart: flush\n");
-
-	/* To invalidate the DART, set the DARTCNTL_FLUSHTLB bit in the
-	 * control register and wait for it to clear.
-	 *
-	 * Gotcha: Sometimes, the DART won't detect that the bit gets
-	 * set. If so, clear it and set it again.
-	 */ 
-
-	limit = 0;
-
-retry:
-	reg = in_be32((unsigned int *)dart+DARTCNTL);
-	reg |= DARTCNTL_FLUSHTLB;
-	out_be32((unsigned int *)dart+DARTCNTL, reg);
-
-	l = 0;
-	while ((in_be32((unsigned int *)dart+DARTCNTL) & DARTCNTL_FLUSHTLB) &&
-		l < (1L<<limit)) {
-		l++;
-	}
-	if (l == (1L<<limit)) {
-		if (limit < 4) {
-			limit++;
-		        reg = in_be32((unsigned int *)dart+DARTCNTL);
-		        reg &= ~DARTCNTL_FLUSHTLB;
-		        out_be32((unsigned int *)dart+DARTCNTL, reg);
-			goto retry;
-		} else
-			panic("U3-DART: TLB did not flush after waiting a long "
-			      "time. Buggy U3 ?");
-	}
-}
-
-static void dart_flush(struct iommu_table *tbl)
-{
-	if (dart_dirty)
-		dart_tlb_invalidate_all();
-	dart_dirty = 0;
-}
-
-static void dart_build_pmac(struct iommu_table *tbl, long index, 
-			    long npages, unsigned long uaddr,
-			    enum dma_data_direction direction)
-{
-	unsigned int *dp;
-	unsigned int rpn;
-
-	DBG("dart: build at: %lx, %lx, addr: %x\n", index, npages, uaddr);
-
-	dp = ((unsigned int*)tbl->it_base) + index;
-	
-	/* On pmac, all memory is contigous, so we can move this
-	 * out of the loop.
-	 */
-	while (npages--) {
-		rpn = virt_to_abs(uaddr) >> PAGE_SHIFT;
-
-		*(dp++) = DARTMAP_VALID | (rpn & DARTMAP_RPNMASK);
-
-		rpn++;
-		uaddr += PAGE_SIZE;
-	}
-
-	dart_dirty = 1;
-}
-
-
-static void dart_free_pmac(struct iommu_table *tbl, long index, long npages)
-{
-	unsigned int *dp;
-	
-	/* We don't worry about flushing the TLB cache. The only drawback of
-	 * not doing it is that we won't catch buggy device drivers doing
-	 * bad DMAs, but then no 32-bit architecture ever does either.
-	 */
-
-	DBG("dart: free at: %lx, %lx\n", index, npages);
-
-	dp  = ((unsigned int *)tbl->it_base) + index;
-		
-	while (npages--)
-		*(dp++) = dart_emptyval;
-}
-
-
-static int dart_init(struct device_node *dart_node)
-{
-	unsigned int regword;
-	unsigned int i;
-	unsigned long tmp;
-	struct page *p;
-
-	if (dart_tablebase == 0 || dart_tablesize == 0) {
-		printk(KERN_INFO "U3-DART: table not allocated, using direct DMA\n");
-		return -ENODEV;
-	}
-
-	/* Make sure nothing from the DART range remains in the CPU cache
-	 * from a previous mapping that existed before the kernel took
-	 * over
-	 */
-	flush_dcache_phys_range(dart_tablebase, dart_tablebase + dart_tablesize);
-
-	/* Allocate a spare page to map all invalid DART pages. We need to do
-	 * that to work around what looks like a problem with the HT bridge
-	 * prefetching into invalid pages and corrupting data
-	 */
-	tmp = __get_free_pages(GFP_ATOMIC, 1);
-	if (tmp == 0)
-		panic("U3-DART: Cannot allocate spare page !");
-	dart_emptyval = DARTMAP_VALID |
-		((virt_to_abs(tmp) >> PAGE_SHIFT) & DARTMAP_RPNMASK);
-
-	/* Map in DART registers. FIXME: Use device node to get base address */
-	dart = ioremap(DART_BASE, 0x7000);
-	if (dart == NULL)
-		panic("U3-DART: Cannot map registers !");
-
-	/* Set initial control register contents: table base, 
-	 * table size and enable bit
-	 */
-	regword = DARTCNTL_ENABLE | 
-		((dart_tablebase >> PAGE_SHIFT) << DARTCNTL_BASE_SHIFT) |
-		(((dart_tablesize >> PAGE_SHIFT) & DARTCNTL_SIZE_MASK)
-				 << DARTCNTL_SIZE_SHIFT);
-	p = virt_to_page(dart_tablebase);
-	dart_vbase = ioremap(virt_to_abs(dart_tablebase), dart_tablesize);
-
-	/* Fill initial table */
-	for (i = 0; i < dart_tablesize/4; i++)
-		dart_vbase[i] = dart_emptyval;
-
-	/* Initialize DART with table base and enable it. */
-	out_be32((unsigned int *)dart, regword);
-
-	/* Invalidate DART to get rid of possible stale TLBs */
-	dart_tlb_invalidate_all();
-
-	iommu_table_pmac.it_busno = 0;
-	
-	/* Units of tce entries */
-	iommu_table_pmac.it_offset = 0;
-	
-	/* Set the tce table size - measured in pages */
-	iommu_table_pmac.it_size = dart_tablesize >> PAGE_SHIFT;
-
-	/* Initialize the common IOMMU code */
-	iommu_table_pmac.it_base = (unsigned long)dart_vbase;
-	iommu_table_pmac.it_index = 0;
-	iommu_table_pmac.it_blocksize = 1;
-	iommu_table_pmac.it_entrysize = sizeof(u32);
-	iommu_init_table(&iommu_table_pmac);
-
-	/* Reserve the last page of the DART to avoid possible prefetch
-	 * past the DART mapped area
-	 */
-	set_bit(iommu_table_pmac.it_mapsize - 1, iommu_table_pmac.it_map);
-
-	printk(KERN_INFO "U3-DART IOMMU initialized\n");
-
-	return 0;
-}
-
-void iommu_setup_pmac(void)
-{
-	struct pci_dev *dev = NULL;
-	struct device_node *dn;
-
-	/* Find the DART in the device-tree */
-	dn = of_find_compatible_node(NULL, "dart", "u3-dart");
-	if (dn == NULL)
-		return;
-
-	/* Setup low level TCE operations for the core IOMMU code */
-	ppc_md.tce_build = dart_build_pmac;
-	ppc_md.tce_free  = dart_free_pmac;
-	ppc_md.tce_flush = dart_flush;
-
-	/* Initialize the DART HW */
-	if (dart_init(dn))
-		return;
-
-	/* Setup pci_dma ops */
-	pci_iommu_init();
-
-	/* We only have one iommu table on the mac for now, which makes
-	 * things simple. Setup all PCI devices to point to this table
-	 */
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
-		/* We must use pci_device_to_OF_node() to make sure that
-		 * we get the real "final" pointer to the device in the
-		 * pci_dev sysdata and not the temporary PHB one
-		 */
-		struct device_node *dn = pci_device_to_OF_node(dev);
-		if (dn)
-			dn->iommu_table = &iommu_table_pmac;
-	}
-}
-
-void __init pmac_iommu_alloc(void)
-{
-	/* Only reserve DART space if machine has more than 2GB of RAM
-	 * or if requested with iommu=on on cmdline.
-	 */
-	if (lmb_end_of_DRAM() <= 0x80000000ull &&
-	    get_property(of_chosen, "linux,iommu-force-on", NULL) == NULL)
-		return;
-
-	/* 512 pages (2MB) is max DART tablesize. */
-	dart_tablesize = 1UL << 21;
-	/* 16MB (1 << 24) alignment. We allocate a full 16Mb chuck since we
-	 * will blow up an entire large page anyway in the kernel mapping
-	 */
-	dart_tablebase = (unsigned long)
-		abs_to_virt(lmb_alloc_base(1UL<<24, 1UL<<24, 0x80000000L));
-
-	printk(KERN_INFO "U3-DART allocated at: %lx\n", dart_tablebase);
-}
diff -Nru a/arch/ppc64/kernel/pmac_pci.c b/arch/ppc64/kernel/pmac_pci.c
--- a/arch/ppc64/kernel/pmac_pci.c	2004-09-27 19:12:49 +10:00
+++ b/arch/ppc64/kernel/pmac_pci.c	2004-09-27 19:12:49 +10:00
@@ -664,9 +664,7 @@
 
 	pci_fix_bus_sysdata();
 
-#ifdef CONFIG_PMAC_DART
-	iommu_setup_pmac();
-#endif /* CONFIG_PMAC_DART */
+	iommu_setup_u3();
 
 }
 
diff -Nru a/arch/ppc64/kernel/pmac_setup.c b/arch/ppc64/kernel/pmac_setup.c
--- a/arch/ppc64/kernel/pmac_setup.c	2004-09-27 19:12:49 +10:00
+++ b/arch/ppc64/kernel/pmac_setup.c	2004-09-27 19:12:49 +10:00
@@ -447,16 +447,6 @@
 	if (platform != PLATFORM_POWERMAC)
 		return 0;
 
-#ifdef CONFIG_PMAC_DART
-	/*
-	 * On U3, the DART (iommu) must be allocated now since it
-	 * has an impact on htab_initialize (due to the large page it
-	 * occupies having to be broken up so the DART itself is not
-	 * part of the cacheable linar mapping
-	 */
-	pmac_iommu_alloc();
-#endif /* CONFIG_PMAC_DART */
-
 	return 1;
 }
 
diff -Nru a/arch/ppc64/kernel/prom_init.c b/arch/ppc64/kernel/prom_init.c
--- a/arch/ppc64/kernel/prom_init.c	2004-09-27 19:12:49 +10:00
+++ b/arch/ppc64/kernel/prom_init.c	2004-09-27 19:12:49 +10:00
@@ -423,13 +423,6 @@
 		else if (!strncmp(opt, RELOC("force"), 5))
 			RELOC(iommu_force_on) = 1;
 	}
-
-#ifndef CONFIG_PMAC_DART
-	if (RELOC(of_platform) == PLATFORM_POWERMAC) {
-		RELOC(ppc64_iommu_off) = 1;
-		prom_printf("DART disabled on PowerMac !\n");
-	}
-#endif
 }
 
 /*
diff -Nru a/arch/ppc64/kernel/setup.c b/arch/ppc64/kernel/setup.c
--- a/arch/ppc64/kernel/setup.c	2004-09-27 19:12:49 +10:00
+++ b/arch/ppc64/kernel/setup.c	2004-09-27 19:12:49 +10:00
@@ -50,6 +50,7 @@
 #include <asm/setup.h>
 #include <asm/system.h>
 #include <asm/rtas.h>
+#include <asm/iommu.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -404,6 +405,16 @@
 	EARLY_DEBUG_INIT();
 
 	DBG("Found, Initializing memory management...\n");
+
+#ifdef CONFIG_U3_DART
+	/*
+	 * On U3, the DART (iommu) must be allocated now since it
+	 * has an impact on htab_initialize (due to the large page it
+	 * occupies having to be broken up so the DART itself is not
+	 * part of the cacheable linar mapping
+	 */
+	alloc_u3_dart_table();
+#endif /* CONFIG_U3_DART */
 
 	/*
 	 * Initialize stab / SLB management
diff -Nru a/arch/ppc64/kernel/u3_iommu.c b/arch/ppc64/kernel/u3_iommu.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc64/kernel/u3_iommu.c	2004-09-27 19:12:49 +10:00
@@ -0,0 +1,321 @@
+/*
+ * arch/ppc64/kernel/u3_iommu.c
+ *
+ * Copyright (C) 2004 Olof Johansson <olof@austin.ibm.com>, IBM Corporation
+ *
+ * Based on pSeries_iommu.c:
+ * Copyright (C) 2001 Mike Corrigan & Dave Engebretsen, IBM Corporation
+ * Copyright (C) 2004 Olof Johansson <olof@austin.ibm.com>, IBM Corporation
+ *
+ * Dynamic DMA mapping support, Apple U3 & IBM CPC925 "DART" iommu.
+ *
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ * 
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ * 
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/pci.h>
+#include <linux/dma-mapping.h>
+#include <linux/vmalloc.h>
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/ppcdebug.h>
+#include <asm/iommu.h>
+#include <asm/pci-bridge.h>
+#include <asm/machdep.h>
+#include <asm/abs_addr.h>
+#include <asm/cacheflush.h>
+#include <asm/lmb.h>
+
+#include "pci.h"
+
+
+/* physical base of DART registers */
+#define DART_BASE        0xf8033000UL
+
+/* Offset from base to control register */
+#define DARTCNTL   0
+/* Offset from base to exception register */
+#define DARTEXCP   0x10
+/* Offset from base to TLB tag registers */
+#define DARTTAG    0x1000
+
+
+/* Control Register fields */
+
+/* base address of table (pfn) */
+#define DARTCNTL_BASE_MASK    0xfffff
+#define DARTCNTL_BASE_SHIFT   12
+
+#define DARTCNTL_FLUSHTLB     0x400
+#define DARTCNTL_ENABLE       0x200
+
+/* size of table in pages */
+#define DARTCNTL_SIZE_MASK    0x1ff
+#define DARTCNTL_SIZE_SHIFT   0
+
+/* DART table fields */
+#define DARTMAP_VALID   0x80000000
+#define DARTMAP_RPNMASK 0x00ffffff
+
+/* Physical base address and size of the DART table */
+unsigned long dart_tablebase; /* exported to htab_initialize */
+static unsigned long dart_tablesize;
+
+/* Virtual base address of the DART table */
+static u32 *dart_vbase;
+
+/* Mapped base address for the dart */
+static unsigned int *dart; 
+
+/* Dummy val that entries are set to when unused */
+static unsigned int dart_emptyval;
+
+static struct iommu_table iommu_table_u3;
+static int dart_dirty;
+
+#define DBG(...)
+
+static inline void dart_tlb_invalidate_all(void)
+{
+	unsigned long l = 0;
+	unsigned int reg;
+	unsigned long limit;
+
+	DBG("dart: flush\n");
+
+	/* To invalidate the DART, set the DARTCNTL_FLUSHTLB bit in the
+	 * control register and wait for it to clear.
+	 *
+	 * Gotcha: Sometimes, the DART won't detect that the bit gets
+	 * set. If so, clear it and set it again.
+	 */ 
+
+	limit = 0;
+
+retry:
+	reg = in_be32((unsigned int *)dart+DARTCNTL);
+	reg |= DARTCNTL_FLUSHTLB;
+	out_be32((unsigned int *)dart+DARTCNTL, reg);
+
+	l = 0;
+	while ((in_be32((unsigned int *)dart+DARTCNTL) & DARTCNTL_FLUSHTLB) &&
+		l < (1L<<limit)) {
+		l++;
+	}
+	if (l == (1L<<limit)) {
+		if (limit < 4) {
+			limit++;
+		        reg = in_be32((unsigned int *)dart+DARTCNTL);
+		        reg &= ~DARTCNTL_FLUSHTLB;
+		        out_be32((unsigned int *)dart+DARTCNTL, reg);
+			goto retry;
+		} else
+			panic("U3-DART: TLB did not flush after waiting a long "
+			      "time. Buggy U3 ?");
+	}
+}
+
+static void dart_flush(struct iommu_table *tbl)
+{
+	if (dart_dirty)
+		dart_tlb_invalidate_all();
+	dart_dirty = 0;
+}
+
+static void dart_build(struct iommu_table *tbl, long index, 
+		       long npages, unsigned long uaddr,
+		       enum dma_data_direction direction)
+{
+	unsigned int *dp;
+	unsigned int rpn;
+
+	DBG("dart: build at: %lx, %lx, addr: %x\n", index, npages, uaddr);
+
+	dp = ((unsigned int*)tbl->it_base) + index;
+	
+	/* On U3, all memory is contigous, so we can move this
+	 * out of the loop.
+	 */
+	while (npages--) {
+		rpn = virt_to_abs(uaddr) >> PAGE_SHIFT;
+
+		*(dp++) = DARTMAP_VALID | (rpn & DARTMAP_RPNMASK);
+
+		rpn++;
+		uaddr += PAGE_SIZE;
+	}
+
+	dart_dirty = 1;
+}
+
+
+static void dart_free(struct iommu_table *tbl, long index, long npages)
+{
+	unsigned int *dp;
+	
+	/* We don't worry about flushing the TLB cache. The only drawback of
+	 * not doing it is that we won't catch buggy device drivers doing
+	 * bad DMAs, but then no 32-bit architecture ever does either.
+	 */
+
+	DBG("dart: free at: %lx, %lx\n", index, npages);
+
+	dp  = ((unsigned int *)tbl->it_base) + index;
+		
+	while (npages--)
+		*(dp++) = dart_emptyval;
+}
+
+
+static int dart_init(struct device_node *dart_node)
+{
+	unsigned int regword;
+	unsigned int i;
+	unsigned long tmp;
+	struct page *p;
+
+	if (dart_tablebase == 0 || dart_tablesize == 0) {
+		printk(KERN_INFO "U3-DART: table not allocated, using direct DMA\n");
+		return -ENODEV;
+	}
+
+	/* Make sure nothing from the DART range remains in the CPU cache
+	 * from a previous mapping that existed before the kernel took
+	 * over
+	 */
+	flush_dcache_phys_range(dart_tablebase, dart_tablebase + dart_tablesize);
+
+	/* Allocate a spare page to map all invalid DART pages. We need to do
+	 * that to work around what looks like a problem with the HT bridge
+	 * prefetching into invalid pages and corrupting data
+	 */
+	tmp = __get_free_pages(GFP_ATOMIC, 1);
+	if (tmp == 0)
+		panic("U3-DART: Cannot allocate spare page !");
+	dart_emptyval = DARTMAP_VALID |
+		((virt_to_abs(tmp) >> PAGE_SHIFT) & DARTMAP_RPNMASK);
+
+	/* Map in DART registers. FIXME: Use device node to get base address */
+	dart = ioremap(DART_BASE, 0x7000);
+	if (dart == NULL)
+		panic("U3-DART: Cannot map registers !");
+
+	/* Set initial control register contents: table base, 
+	 * table size and enable bit
+	 */
+	regword = DARTCNTL_ENABLE | 
+		((dart_tablebase >> PAGE_SHIFT) << DARTCNTL_BASE_SHIFT) |
+		(((dart_tablesize >> PAGE_SHIFT) & DARTCNTL_SIZE_MASK)
+				 << DARTCNTL_SIZE_SHIFT);
+	p = virt_to_page(dart_tablebase);
+	dart_vbase = ioremap(virt_to_abs(dart_tablebase), dart_tablesize);
+
+	/* Fill initial table */
+	for (i = 0; i < dart_tablesize/4; i++)
+		dart_vbase[i] = dart_emptyval;
+
+	/* Initialize DART with table base and enable it. */
+	out_be32((unsigned int *)dart, regword);
+
+	/* Invalidate DART to get rid of possible stale TLBs */
+	dart_tlb_invalidate_all();
+
+	iommu_table_u3.it_busno = 0;
+	
+	/* Units of tce entries */
+	iommu_table_u3.it_offset = 0;
+	
+	/* Set the tce table size - measured in pages */
+	iommu_table_u3.it_size = dart_tablesize >> PAGE_SHIFT;
+
+	/* Initialize the common IOMMU code */
+	iommu_table_u3.it_base = (unsigned long)dart_vbase;
+	iommu_table_u3.it_index = 0;
+	iommu_table_u3.it_blocksize = 1;
+	iommu_table_u3.it_entrysize = sizeof(u32);
+	iommu_init_table(&iommu_table_u3);
+
+	/* Reserve the last page of the DART to avoid possible prefetch
+	 * past the DART mapped area
+	 */
+	set_bit(iommu_table_u3.it_mapsize - 1, iommu_table_u3.it_map);
+
+	printk(KERN_INFO "U3/CPC925 DART IOMMU initialized\n");
+
+	return 0;
+}
+
+void iommu_setup_u3(void)
+{
+	struct pci_dev *dev = NULL;
+	struct device_node *dn;
+
+	/* Find the DART in the device-tree */
+	dn = of_find_compatible_node(NULL, "dart", "u3-dart");
+	if (dn == NULL)
+		return;
+
+	/* Setup low level TCE operations for the core IOMMU code */
+	ppc_md.tce_build = dart_build;
+	ppc_md.tce_free  = dart_free;
+	ppc_md.tce_flush = dart_flush;
+
+	/* Initialize the DART HW */
+	if (dart_init(dn))
+		return;
+
+	/* Setup pci_dma ops */
+	pci_iommu_init();
+
+	/* We only have one iommu table on the mac for now, which makes
+	 * things simple. Setup all PCI devices to point to this table
+	 */
+	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+		/* We must use pci_device_to_OF_node() to make sure that
+		 * we get the real "final" pointer to the device in the
+		 * pci_dev sysdata and not the temporary PHB one
+		 */
+		struct device_node *dn = pci_device_to_OF_node(dev);
+		if (dn)
+			dn->iommu_table = &iommu_table_u3;
+	}
+}
+
+void __init alloc_u3_dart_table(void)
+{
+	/* Only reserve DART space if machine has more than 2GB of RAM
+	 * or if requested with iommu=on on cmdline.
+	 */
+	if (lmb_end_of_DRAM() <= 0x80000000ull &&
+	    get_property(of_chosen, "linux,iommu-force-on", NULL) == NULL)
+		return;
+
+	/* 512 pages (2MB) is max DART tablesize. */
+	dart_tablesize = 1UL << 21;
+	/* 16MB (1 << 24) alignment. We allocate a full 16Mb chuck since we
+	 * will blow up an entire large page anyway in the kernel mapping
+	 */
+	dart_tablebase = (unsigned long)
+		abs_to_virt(lmb_alloc_base(1UL<<24, 1UL<<24, 0x80000000L));
+
+	printk(KERN_INFO "U3-DART allocated at: %lx\n", dart_tablebase);
+}
diff -Nru a/arch/ppc64/mm/hash_utils.c b/arch/ppc64/mm/hash_utils.c
--- a/arch/ppc64/mm/hash_utils.c	2004-09-27 19:12:49 +10:00
+++ b/arch/ppc64/mm/hash_utils.c	2004-09-27 19:12:49 +10:00
@@ -71,9 +71,9 @@
  *
  */
 
-#ifdef CONFIG_PMAC_DART
+#ifdef CONFIG_U3_DART
 extern unsigned long dart_tablebase;
-#endif /* CONFIG_PMAC_DART */
+#endif /* CONFIG_U3_DART */
 
 HTAB htab_data = {NULL, 0, 0, 0, 0};
 
@@ -203,7 +203,7 @@
 
 		DBG("creating mapping for region: %lx : %lx\n", base, size);
 
-#ifdef CONFIG_PMAC_DART
+#ifdef CONFIG_U3_DART
 		/* Do not map the DART space. Fortunately, it will be aligned
 		 * in such a way that it will not cross two lmb regions and will
 		 * fit within a single 16Mb page.
@@ -223,7 +223,7 @@
 						   mode_rw, use_largepages);
 			continue;
 		}
-#endif /* CONFIG_PMAC_DART */
+#endif /* CONFIG_U3_DART */
 		create_pte_mapping(base, base + size, mode_rw, use_largepages);
 	}
 	DBG(" <- htab_initialize()\n");
diff -Nru a/include/asm-ppc64/iommu.h b/include/asm-ppc64/iommu.h
--- a/include/asm-ppc64/iommu.h	2004-09-27 19:12:49 +10:00
+++ b/include/asm-ppc64/iommu.h	2004-09-27 19:12:49 +10:00
@@ -108,7 +108,7 @@
 
 /* Walks all buses and creates iommu tables */
 extern void iommu_setup_pSeries(void);
-extern void iommu_setup_pmac(void);
+extern void iommu_setup_u3(void);
 
 /* Creates table for an individual device node */
 extern void iommu_devnode_init(struct device_node *dn);
@@ -154,6 +154,8 @@
 
 extern void pci_iommu_init(void);
 extern void pci_dma_init_direct(void);
+
+extern void alloc_u3_dart_table(void);
 
 extern int ppc64_iommu_off;
 


