Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262644AbUB0M1s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 07:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbUB0M1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 07:27:03 -0500
Received: from gate.crashing.org ([63.228.1.57]:49082 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262693AbUB0MYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 07:24:09 -0500
Subject: [PATCH] ppc64 iommu rewrite part 5/5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1077884114.22925.375.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 27 Feb 2004 23:15:14 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement support for Apple DART IOMMU (PowerMac G5)

This allows to use more than 2Gb of RAM on a PowerMac G5. You
can also boot with iommu=off to disable it, but then you get
back the 2Gb RAM limitation.

Ben.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/02/27 22:37:07+11:00 benh@kernel.crashing.org 
#   PowerMac G5 DART (iommu) support, by Olof Johansson with some hacks from me 
# 
# include/asm-ppc64/cacheflush.h
#   2004/02/27 22:36:53+11:00 benh@kernel.crashing.org +3 -0
#   PowerMac G5 DART (iommu) support, by Olof Johansson with some hacks from me 
# 
# arch/ppc64/mm/hash_utils.c
#   2004/02/27 22:36:53+11:00 benh@kernel.crashing.org +23 -0
#   PowerMac G5 DART (iommu) support, by Olof Johansson with some hacks from me 
# 
# arch/ppc64/kernel/prom.c
#   2004/02/27 22:36:53+11:00 benh@kernel.crashing.org +56 -2
#   PowerMac G5 DART (iommu) support, by Olof Johansson with some hacks from me 
# 
# arch/ppc64/kernel/pmac_pci.c
#   2004/02/27 22:36:53+11:00 benh@kernel.crashing.org +6 -0
#   PowerMac G5 DART (iommu) support, by Olof Johansson with some hacks from me 
# 
# arch/ppc64/kernel/misc.S
#   2004/02/27 22:36:53+11:00 benh@kernel.crashing.org +42 -0
#   PowerMac G5 DART (iommu) support, by Olof Johansson with some hacks from me 
# 
# arch/ppc64/kernel/Makefile
#   2004/02/27 22:36:53+11:00 benh@kernel.crashing.org +2 -0
#   PowerMac G5 DART (iommu) support, by Olof Johansson with some hacks from me 
# 
# arch/ppc64/Kconfig
#   2004/02/27 22:36:53+11:00 benh@kernel.crashing.org +11 -0
#   PowerMac G5 DART (iommu) support, by Olof Johansson with some hacks from me 
# 
# arch/ppc64/kernel/pmac_iommu.c
#   2004/02/27 22:30:15+11:00 benh@kernel.crashing.org +301 -0
# 
# arch/ppc64/kernel/pmac_iommu.c
#   2004/02/27 22:30:15+11:00 benh@kernel.crashing.org +0 -0
#   BitKeeper file /home/benh/kernels/linux-iommu/arch/ppc64/kernel/pmac_iommu.c
# 
diff -Nru a/arch/ppc64/Kconfig b/arch/ppc64/Kconfig
--- a/arch/ppc64/Kconfig	Fri Feb 27 22:44:57 2004
+++ b/arch/ppc64/Kconfig	Fri Feb 27 22:44:57 2004
@@ -89,6 +89,17 @@
 	bool "Apple PowerMac G5 support"
 	select ADB_PMU
 
+config PMAC_DART
+	bool "Enable DART/IOMMU on PowerMac (allow >2G of RAM)"
+	depends on PPC_PMAC
+	depends on EXPERIMENTAL
+	default n
+	help
+	  Enabling DART makes it possible to boot a PowerMac G5 with more
+	  than 2GB of memory. Note that the code is very new and untested
+	  at this time, so it has to be considered experimental. Enabling
+	  this might result in data loss.
+
 config PPC_PMAC64
 	bool
 	depends on PPC_PMAC
diff -Nru a/arch/ppc64/kernel/Makefile b/arch/ppc64/kernel/Makefile
--- a/arch/ppc64/kernel/Makefile	Fri Feb 27 22:44:57 2004
+++ b/arch/ppc64/kernel/Makefile	Fri Feb 27 22:44:57 2004
@@ -50,6 +50,8 @@
 obj-$(CONFIG_PPC_PMAC)		+= pmac_setup.o pmac_feature.o pmac_pci.o \
 				   pmac_time.o pmac_nvram.o pmac_low_i2c.o \
 				   open_pic_u3.o
+obj-$(CONFIG_PMAC_DART)		+= pmac_iommu.o
+
 ifdef CONFIG_SMP
 obj-$(CONFIG_PPC_PMAC)		+= pmac_smp.o smp-tbsync.o
 endif
diff -Nru a/arch/ppc64/kernel/misc.S b/arch/ppc64/kernel/misc.S
--- a/arch/ppc64/kernel/misc.S	Fri Feb 27 22:44:57 2004
+++ b/arch/ppc64/kernel/misc.S	Fri Feb 27 22:44:57 2004
@@ -210,6 +210,48 @@
 	blr
 
 /*
+ * Like above, but works on non-mapped physical addresses.
+ * Use only for non-LPAR setups ! It also assumes real mode
+ * is cacheable. Used for flushing out the DART before using
+ * it as uncacheable memory 
+ *
+ * flush_dcache_phys_range(unsigned long start, unsigned long stop)
+ *
+ *    flush all bytes from start to stop-1 inclusive
+ */
+_GLOBAL(flush_dcache_phys_range)
+	LOADADDR(r10,naca)		/* Get Naca address */
+	ld	r10,0(r10)
+	LOADADDR(r11,systemcfg)		/* Get systemcfg address */
+	ld	r11,0(r11)
+	lwz	r7,DCACHEL1LINESIZE(r11)	/* Get dcache line size */
+	addi	r5,r7,-1
+	andc	r6,r3,r5		/* round low to line bdy */
+	subf	r8,r6,r4		/* compute length */
+	add	r8,r8,r5		/* ensure we get enough */
+	lwz	r9,DCACHEL1LOGLINESIZE(r10)	/* Get log-2 of dcache line size */
+	srw.	r8,r8,r9		/* compute line count */
+	beqlr				/* nothing to do? */
+	mfmsr	r5			/* Disable MMU Data Relocation */
+	ori	r0,r5,MSR_DR
+	xori	r0,r0,MSR_DR
+	sync
+	mtmsr	r0
+	sync
+	isync
+	mtctr	r8
+0:	dcbst	0,r6
+	add	r6,r6,r7
+	bdnz	0b
+	sync
+	isync
+	mtmsr	r5			/* Re-enable MMU Data Relocation */
+	sync
+	isync
+	blr
+
+
+/*
  * Flush a particular page from the data cache to RAM.
  * Note: this is necessary because the instruction cache does *not*
  * snoop from the data cache.
diff -Nru a/arch/ppc64/kernel/pmac_iommu.c b/arch/ppc64/kernel/pmac_iommu.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/ppc64/kernel/pmac_iommu.c	Fri Feb 27 22:44:57 2004
@@ -0,0 +1,301 @@
+/*
+ * arch/ppc64/kernel/pmac_iommu.c
+ *
+ * Copyright (C) 2004 Olof Johansson <olof@austin.ibm.com>, IBM Corporation
+ *
+ * Based on pSeries_iommu.c:
+ * Copyright (C) 2001 Mike Corrigan & Dave Engebretsen, IBM Corporation
+ * Copyright (C) 2004 Olof Johansson <olof@austin.ibm.com>, IBM Corporation
+ *
+ * Dynamic DMA mapping support, PowerMac G5 (DART)-specific parts.
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
+#include <linux/vmalloc.h>
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/rtas.h>
+#include <asm/ppcdebug.h>
+#include <asm/iommu.h>
+#include <asm/pci-bridge.h>
+#include <asm/machdep.h>
+#include <asm/abs_addr.h>
+#include <asm/cacheflush.h>
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
+unsigned long dart_tablebase;
+unsigned long dart_tablesize;
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
+static struct iommu_table iommu_table_pmac;
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
+static void dart_build_pmac(struct iommu_table *tbl, long index, 
+			    long npages, unsigned long uaddr,
+			    int direction)
+{
+	unsigned int *dp;
+	unsigned int rpn;
+
+	DBG("dart: build at: %lx, %lx, addr: %x\n", index, npages, uaddr);
+
+	dp = ((unsigned int*)tbl->it_base) + index;
+	
+	/* On pmac, all memory is contigous, so we can move this
+	 * out of the loop.
+	 */
+	while (npages--) {
+		rpn = (virt_to_absolute(uaddr)) >> PAGE_SHIFT;
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
+static void dart_free_pmac(struct iommu_table *tbl, long index, long npages)
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
+		((virt_to_absolute(tmp) >> PAGE_SHIFT) & DARTMAP_RPNMASK);
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
+	dart_vbase = ioremap(virt_to_absolute(dart_tablebase), dart_tablesize);
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
+	iommu_table_pmac.it_busno = 0;
+	
+	/* Units of tce entries */
+	iommu_table_pmac.it_offset = 0;
+	
+	/* Set the tce table size - measured in pages */
+	iommu_table_pmac.it_size = dart_tablesize >> PAGE_SHIFT;
+
+	/* Initialize the common IOMMU code */
+	iommu_table_pmac.it_base = (unsigned long)dart_vbase;
+	iommu_table_pmac.it_index = 0;
+	iommu_table_pmac.it_blocksize = 1;
+	iommu_table_pmac.it_entrysize = sizeof(u32);
+	iommu_init_table(&iommu_table_pmac);
+
+	/* Reserve the last page of the DART to avoid possible prefetch
+	 * past the DART mapped area
+	 */
+	set_bit(iommu_table_pmac.it_mapsize - 1, iommu_table_pmac.it_map);
+
+	printk(KERN_INFO "U3-DART IOMMU initialized\n");
+
+	return 0;
+}
+
+
+void iommu_setup_pmac(void)
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
+	ppc_md.tce_build = dart_build_pmac;
+	ppc_md.tce_free  = dart_free_pmac;
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
+		dn = PCI_GET_DN(dev);
+
+		if (dn)
+			dn->iommu_table = &iommu_table_pmac;
+	}
+}
+
+
+
+
diff -Nru a/arch/ppc64/kernel/pmac_pci.c b/arch/ppc64/kernel/pmac_pci.c
--- a/arch/ppc64/kernel/pmac_pci.c	Fri Feb 27 22:44:57 2004
+++ b/arch/ppc64/kernel/pmac_pci.c	Fri Feb 27 22:44:57 2004
@@ -26,6 +26,7 @@
 #include <asm/pci-bridge.h>
 #include <asm/machdep.h>
 #include <asm/pmac_feature.h>
+#include <asm/iommu.h>
 
 #include "pci.h"
 #include "pmac.h"
@@ -655,6 +656,11 @@
 		pci_read_irq_line(dev);
 
 	pci_fix_bus_sysdata();
+
+#ifdef CONFIG_PMAC_DART
+	iommu_setup_pmac();
+#endif /* CONFIG_PMAC_DART */
+
 }
 
 static void __init pmac_fixup_phb_resources(void)
diff -Nru a/arch/ppc64/kernel/prom.c b/arch/ppc64/kernel/prom.c
--- a/arch/ppc64/kernel/prom.c	Fri Feb 27 22:44:57 2004
+++ b/arch/ppc64/kernel/prom.c	Fri Feb 27 22:44:57 2004
@@ -528,6 +528,28 @@
 	union lmb_reg_property reg;
 	unsigned long lmb_base, lmb_size;
 	unsigned long num_regs, bytes_per_reg = (_prom->encode_phys_size*2)/8;
+	int nodart = 0;
+
+#ifdef CONFIG_PMAC_DART
+	char *opt;
+
+	opt = strstr(RELOC(cmd_line), RELOC("iommu="));
+	if (opt) {
+		prom_print(RELOC("opt is:"));
+		prom_print(opt);
+		prom_print(RELOC("\n"));
+		opt += 6;
+		while(*opt && *opt == ' ')
+			opt++;
+		if (!strncmp(opt, RELOC("off"), 3))
+			nodart = 1;
+	}
+#else
+	nodart = 1;
+#endif /* CONFIG_PMAC_DART */
+
+	if (nodart)
+		prom_print(RELOC("DART disabled on PowerMac !\n"));
 
 	lmb_init();
 
@@ -553,8 +575,9 @@
 				lmb_base = ((unsigned long)reg.addrPM[i].address_hi) << 32;
 				lmb_base |= (unsigned long)reg.addrPM[i].address_lo;
 				lmb_size = reg.addrPM[i].size;
-				if (lmb_base > 0x80000000ull) {
-					prom_print(RELOC("Skipping memory above 2Gb for now, not yet supported\n"));
+				if (nodart && lmb_base > 0x80000000ull) {
+					prom_print(RELOC("Skipping memory above 2Gb for "
+							 "now, DART support disabled\n"));
 					continue;
 				}
 			} else if (_prom->encode_phys_size == 32) {
@@ -733,6 +756,32 @@
 #endif /* DEBUG_PROM */
 
 
+#ifdef CONFIG_PMAC_DART
+void prom_initialize_dart_table(void)
+{
+	unsigned long offset = reloc_offset();
+	extern unsigned long dart_tablebase;
+	extern unsigned long dart_tablesize;
+
+	/* Only reserve DART space if machine has more than 2Gb of RAM */
+	if (lmb_end_of_DRAM() <= 0x80000000ull)
+		return;
+
+	/* 512 pages is max DART tablesize. */
+	RELOC(dart_tablesize) = 1UL << 19;
+	/* 16MB (1 << 24) alignment. We allocate a full 16Mb chuck since we
+	 * will blow up an entire large page anyway in the kernel mapping
+	 */
+	RELOC(dart_tablebase) =
+		absolute_to_virt(lmb_alloc_base(1UL<<24, 1UL<<24, 0x80000000L));
+
+	prom_print(RELOC("Dart at: "));
+	prom_print_hex(RELOC(dart_tablebase));
+	prom_print(RELOC("\n"));
+}
+#endif /* CONFIG_PMAC_DART */
+
+
 void
 prom_initialize_tce_table(void)
 {
@@ -1541,6 +1590,11 @@
 
 	if (_systemcfg->platform == PLATFORM_PSERIES)
 		prom_initialize_tce_table();
+
+#ifdef CONFIG_PMAC_DART
+	if (_systemcfg->platform == PLATFORM_POWERMAC)
+		prom_initialize_dart_table();
+#endif
 
 #ifdef CONFIG_BOOTX_TEXT
 	if(_prom->disp_node) {
diff -Nru a/arch/ppc64/mm/hash_utils.c b/arch/ppc64/mm/hash_utils.c
--- a/arch/ppc64/mm/hash_utils.c	Fri Feb 27 22:44:57 2004
+++ b/arch/ppc64/mm/hash_utils.c	Fri Feb 27 22:44:57 2004
@@ -61,6 +61,10 @@
  *
  */
 
+#ifdef CONFIG_PMAC_DART
+extern unsigned long dart_tablebase;
+#endif /* CONFIG_PMAC_DART */
+
 HTAB htab_data = {NULL, 0, 0, 0, 0};
 
 extern unsigned long _SDR1;
@@ -180,6 +184,25 @@
 		base = lmb.memory.region[i].physbase + KERNELBASE;
 		size = lmb.memory.region[i].size;
 
+#ifdef CONFIG_PMAC_DART
+		/* Do not map the DART space. Fortunately, it will be aligned
+		 * in such a way that it will not cross two lmb regions and will
+		 * fit within a single 16Mb page.
+		 * The DART space is assumed to be a full 16Mb region even if we
+		 * only use 2Mb of that space. We will use more of it later for
+		 * AGP GART. We have to use a full 16Mb large page.
+		 */
+		if (dart_tablebase != 0 && dart_tablebase >= base
+		    && dart_tablebase < (base + size)) {
+			if (base != dart_tablebase)
+				create_pte_mapping(base, dart_tablebase, mode_rw,
+						   use_largepages);
+			if ((base + size) > (dart_tablebase + 16*MB))
+				create_pte_mapping(dart_tablebase + 16*MB, base + size,
+						   mode_rw, use_largepages);
+			continue;
+		}
+#endif /* CONFIG_PMAC_DART */
 		create_pte_mapping(base, base + size, mode_rw, use_largepages);
 	}
 }
diff -Nru a/include/asm-ppc64/cacheflush.h b/include/asm-ppc64/cacheflush.h
--- a/include/asm-ppc64/cacheflush.h	Fri Feb 27 22:44:57 2004
+++ b/include/asm-ppc64/cacheflush.h	Fri Feb 27 22:44:57 2004
@@ -23,6 +23,9 @@
 				    struct page *page, unsigned long addr,
 				    int len);
 
+extern void flush_dcache_range(unsigned long start, unsigned long stop);
+extern void flush_dcache_phys_range(unsigned long start, unsigned long stop);
+
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
 do { memcpy(dst, src, len); \
      flush_icache_user_range(vma, page, vaddr, len); \


