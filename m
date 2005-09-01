Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbVIAAq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbVIAAq6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 20:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbVIAAq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 20:46:57 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:2518 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965009AbVIAAq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 20:46:56 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Subject: [PATCH,RFC] Move Cell platform code to arch/powerpc
Date: Thu, 1 Sep 2005 02:47:06 +0200
User-Agent: KMail/1.7.2
Cc: Paul Mackerras <paulus@samba.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       Kumar Gala <kumar.gala@freescale.com>, akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509010247.07399.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move all files from arch/ppc64/kernel/bpa_* to arch/powerpc/platforms/cell,

I would like to see a patch like this go into 2.6.14, for multiple reasons:

- The marketing folks have changed the names and we are no longer supposed
  to refer to Cell as 'BPA' or 'Broadband Processor Architecture'.
  The platform is officially known as 'Cell Broadband Engine Architecture',
  while the CPU is the 'Cell Broadband Engine'.

- We are now moving all platforms into arch/powerpc/platforms and someone
  has to start so we get a template for the other architectures to follow.

- It would be a big mess for me to maintain my own patches on top of file
  names that are different from mainline during the 2.6.14 freeze.

My impression is that Cell is a good target for moving first, because I
have to move it anyway and the number of users is extremely low, so it
doesn't cause too much harm if we screw up. What thing that makes moving
Cell relatively easy is that it only supports 64 bit and only a single
hardware configuration so far.

I have tested this a bit on Cell and also done compile-only test for the
other platforms, but it doesn't really make any changes to the code itself.

Please comment on wether this is what everybody like the merge process
be like.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

--
 arch/powerpc/platforms/cell/Makefile     |    1
 arch/ppc64/kernel/Makefile               |    5
 arch/powerpc/platforms/cell/pic.c        |  269 ++++++++++++++++++++++
 arch/ppc64/kernel/bpa_iic.c              |  270 ----------------------
 include/asm-powerpc/cell-pic.h           |   62 +++++
 arch/ppc64/kernel/bpa_iic.h              |   62 -----
 arch/powerpc/platforms/cell/iommu.c      |  377 +++++++++++++++++++++++++++++++
 arch/ppc64/kernel/bpa_iommu.c            |  377 -------------------------------
 arch/powerpc/platforms/cell/iommu.h      |   65 +++++
 arch/ppc64/kernel/bpa_iommu.h            |   65 -----
 arch/powerpc/platforms/cell/nvram.c      |  118 +++++++++
 arch/ppc64/kernel/bpa_nvram.c            |  118 ---------
 arch/powerpc/platforms/cell/setup.c      |  138 +++++++++++
 arch/ppc64/kernel/bpa_setup.c            |  140 -----------
 arch/powerpc/platforms/cell/spider-pic.c |  190 +++++++++++++++
 arch/ppc64/kernel/spider-pic.c           |  191 ---------------
 arch/ppc64/Kconfig                       |   10
 arch/ppc64/kernel/cpu_setup_power4.S     |    2
 arch/ppc64/kernel/cputable.c             |    6
 arch/ppc64/kernel/irq.c                  |    2
 arch/ppc64/kernel/pSeries_smp.c          |    4
 arch/ppc64/kernel/setup.c                |    8
 arch/ppc64/kernel/traps.c                |    4
 include/asm-ppc64/nvram.h                |    2
 include/asm-ppc64/processor.h            |    7
 25 files changed, 1248 insertions(+), 1245 deletions(-)

--- linux-cg.orig/arch/powerpc/platforms/cell/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/arch/powerpc/platforms/cell/Makefile	2005-09-01 02:37:46.074992344 -0400
@@ -0,0 +1 @@
+obj-y += iommu.o nvram.o setup.o pic.o spider-pic.o
--- linux-cg.orig/arch/powerpc/platforms/cell/iommu.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/arch/powerpc/platforms/cell/iommu.c	2005-09-01 02:37:46.076992040 -0400
@@ -0,0 +1,377 @@
+/*
+ * IOMMU implementation for Cell Broadband Engine
+ *
+ * We just establish a linear mapping at boot by setting all the
+ * IOPT cache entries in the CPU.
+ * The mapping functions should be identical to pci_direct_iommu, 
+ * except for the handling of the high order bit that is required
+ * by the Spider bridge. These should be split into a separate
+ * file at the point where we get a different bridge chip.
+ *
+ * Copyright (C) 2005 IBM Deutschland Entwicklung GmbH,
+ *			 Arnd Bergmann <arndb@de.ibm.com>
+ *
+ * Based on linear mapping
+ * Copyright (C) 2003 Benjamin Herrenschmidt (benh@kernel.crashing.org)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/init.h>
+#include <linux/bootmem.h>
+#include <linux/mm.h>
+#include <linux/dma-mapping.h>
+
+#include <asm/sections.h>
+#include <asm/iommu.h>
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/pci-bridge.h>
+#include <asm/machdep.h>
+#include <asm/pmac_feature.h>
+#include <asm/abs_addr.h>
+#include <asm/system.h>
+
+#include "iommu.h"
+
+static inline unsigned long 
+get_iopt_entry(unsigned long real_address, unsigned long ioid,
+			 unsigned long prot)
+{
+	return (prot & IOPT_PROT_MASK)
+	     | (IOPT_COHERENT)
+	     | (IOPT_ORDER_VC)
+	     | (real_address & IOPT_RPN_MASK)
+	     | (ioid & IOPT_IOID_MASK);
+}
+
+typedef struct {
+	unsigned long val;
+} ioste;
+
+static inline ioste
+mk_ioste(unsigned long val)
+{
+	ioste ioste = { .val = val, };
+	return ioste;
+}
+
+static inline ioste
+get_iost_entry(unsigned long iopt_base, unsigned long io_address, unsigned page_size)
+{
+	unsigned long ps;
+	unsigned long iostep;
+	unsigned long nnpt;
+	unsigned long shift;
+
+	switch (page_size) {
+	case 0x1000000:
+		ps = IOST_PS_16M;
+		nnpt = 0;  /* one page per segment */
+		shift = 5; /* segment has 16 iopt entries */
+		break;
+
+	case 0x100000:
+		ps = IOST_PS_1M;
+		nnpt = 0;  /* one page per segment */
+		shift = 1; /* segment has 256 iopt entries */
+		break;
+
+	case 0x10000:
+		ps = IOST_PS_64K;
+		nnpt = 0x07; /* 8 pages per io page table */
+		shift = 0;   /* all entries are used */
+		break;
+
+	case 0x1000:
+		ps = IOST_PS_4K;
+		nnpt = 0x7f; /* 128 pages per io page table */
+		shift = 0;   /* all entries are used */
+		break;
+
+	default: /* not a known compile time constant */
+		BUILD_BUG_ON(1);
+		break;
+	}
+
+	iostep = iopt_base +
+			 /* need 8 bytes per iopte */
+			(((io_address / page_size * 8)
+			 /* align io page tables on 4k page boundaries */
+				 << shift) 
+			 /* nnpt+1 pages go into each iopt */
+				 & ~(nnpt << 12));
+
+	nnpt++; /* this seems to work, but the documentation is not clear
+		   about wether we put nnpt or nnpt-1 into the ioste bits.
+		   In theory, this can't work for 4k pages. */
+	return mk_ioste(IOST_VALID_MASK
+			| (iostep & IOST_PT_BASE_MASK)
+			| ((nnpt << 5) & IOST_NNPT_MASK)
+			| (ps & IOST_PS_MASK));
+}
+
+/* compute the address of an io pte */
+static inline unsigned long
+get_ioptep(ioste iost_entry, unsigned long io_address)
+{
+	unsigned long iopt_base;
+	unsigned long page_size;
+	unsigned long page_number;
+	unsigned long iopt_offset;
+
+	iopt_base = iost_entry.val & IOST_PT_BASE_MASK;
+	page_size = iost_entry.val & IOST_PS_MASK;
+
+	/* decode page size to compute page number */
+	page_number = (io_address & 0x0fffffff) >> (10 + 2 * page_size);
+	/* page number is an offset into the io page table */
+	iopt_offset = (page_number << 3) & 0x7fff8ul;
+	return iopt_base + iopt_offset;
+}
+
+/* compute the tag field of the iopt cache entry */
+static inline unsigned long
+get_ioc_tag(ioste iost_entry, unsigned long io_address)
+{
+	unsigned long iopte = get_ioptep(iost_entry, io_address);
+
+	return IOPT_VALID_MASK
+	     | ((iopte & 0x00000000000000ff8ul) >> 3)
+	     | ((iopte & 0x0000003fffffc0000ul) >> 9);
+}
+
+/* compute the hashed 6 bit index for the 4-way associative pte cache */
+static inline unsigned long
+get_ioc_hash(ioste iost_entry, unsigned long io_address)
+{
+	unsigned long iopte = get_ioptep(iost_entry, io_address);
+
+	return ((iopte & 0x000000000000001f8ul) >> 3)
+	     ^ ((iopte & 0x00000000000020000ul) >> 17)
+	     ^ ((iopte & 0x00000000000010000ul) >> 15)
+	     ^ ((iopte & 0x00000000000008000ul) >> 13)
+	     ^ ((iopte & 0x00000000000004000ul) >> 11)
+	     ^ ((iopte & 0x00000000000002000ul) >> 9)
+	     ^ ((iopte & 0x00000000000001000ul) >> 7);
+}
+
+/* same as above, but pretend that we have a simpler 1-way associative
+   pte cache with an 8 bit index */
+static inline unsigned long
+get_ioc_hash_1way(ioste iost_entry, unsigned long io_address)
+{
+	unsigned long iopte = get_ioptep(iost_entry, io_address);
+
+	return ((iopte & 0x000000000000001f8ul) >> 3)
+	     ^ ((iopte & 0x00000000000020000ul) >> 17)
+	     ^ ((iopte & 0x00000000000010000ul) >> 15)
+	     ^ ((iopte & 0x00000000000008000ul) >> 13)
+	     ^ ((iopte & 0x00000000000004000ul) >> 11)
+	     ^ ((iopte & 0x00000000000002000ul) >> 9)
+	     ^ ((iopte & 0x00000000000001000ul) >> 7)
+	     ^ ((iopte & 0x0000000000000c000ul) >> 8);
+}
+
+static inline ioste
+get_iost_cache(void __iomem *base, unsigned long index)
+{
+	unsigned long __iomem *p = (base + IOC_ST_CACHE_DIR);
+	return mk_ioste(in_be64(&p[index]));
+}
+
+static inline void
+set_iost_cache(void __iomem *base, unsigned long index, ioste ste)
+{
+	unsigned long __iomem *p = (base + IOC_ST_CACHE_DIR);
+	pr_debug("ioste %02lx was %016lx, store %016lx", index,
+			get_iost_cache(base, index).val, ste.val);
+	out_be64(&p[index], ste.val);
+	pr_debug(" now %016lx\n", get_iost_cache(base, index).val);
+}
+
+static inline unsigned long
+get_iopt_cache(void __iomem *base, unsigned long index, unsigned long *tag)
+{
+	unsigned long __iomem *tags = (void *)(base + IOC_PT_CACHE_DIR);
+	unsigned long __iomem *p = (void *)(base + IOC_PT_CACHE_REG);	
+
+	*tag = tags[index];
+	rmb();
+	return *p;
+}
+
+static inline void
+set_iopt_cache(void __iomem *base, unsigned long index,
+		 unsigned long tag, unsigned long val)
+{
+	unsigned long __iomem *tags = base + IOC_PT_CACHE_DIR;
+	unsigned long __iomem *p = base + IOC_PT_CACHE_REG;
+	pr_debug("iopt %02lx was v%016lx/t%016lx, store v%016lx/t%016lx\n",
+		index, get_iopt_cache(base, index, &oldtag), oldtag, val, tag);
+
+	out_be64(p, val);
+	out_be64(&tags[index], tag);
+}
+
+static inline void
+set_iost_origin(void __iomem *base)
+{
+	unsigned long __iomem *p = base + IOC_ST_ORIGIN;
+	unsigned long origin = IOSTO_ENABLE | IOSTO_SW;
+
+	pr_debug("iost_origin %016lx, now %016lx\n", in_be64(p), origin);
+	out_be64(p, origin);
+}
+
+static inline void
+set_iocmd_config(void __iomem *base)
+{
+	unsigned long __iomem *p = base + 0xc00;
+	unsigned long conf;
+
+	conf = in_be64(p);
+	pr_debug("iost_conf %016lx, now %016lx\n", conf, conf | IOCMD_CONF_TE);
+	out_be64(p, conf | IOCMD_CONF_TE);
+}
+
+/* FIXME: get these from the device tree */
+#define ioc_base	0x20000511000ull
+#define ioc_mmio_base	0x20000510000ull
+#define ioid		0x48a
+#define iopt_phys_offset (- 0x20000000) /* We have a 512MB offset from the SB */
+#define io_page_size	0x1000000
+
+static unsigned long map_iopt_entry(unsigned long address)
+{
+	switch (address >> 20) {
+	case 0x600:
+		address = 0x24020000000ull; /* spider i/o */
+		break;
+	default:
+		address += iopt_phys_offset;
+		break;
+	}
+
+	return get_iopt_entry(address, ioid, IOPT_PROT_RW);
+}
+
+static void iommu_bus_setup_null(struct pci_bus *b) { }
+static void iommu_dev_setup_null(struct pci_dev *d) { }
+
+/* initialize the iommu to support a simple linear mapping
+ * for each DMA window used by any device. For now, we
+ * happen to know that there is only one DMA window in use,
+ * starting at iopt_phys_offset. */
+static void cell_map_iommu(void)
+{
+	unsigned long address;
+	void __iomem *base;
+	ioste ioste;
+	unsigned long index;
+
+	base = __ioremap(ioc_base, 0x1000, _PAGE_NO_CACHE);
+	pr_debug("%lx mapped to %p\n", ioc_base, base);
+	set_iocmd_config(base);
+	iounmap(base);
+
+	base = __ioremap(ioc_mmio_base, 0x1000, _PAGE_NO_CACHE);
+	pr_debug("%lx mapped to %p\n", ioc_mmio_base, base);
+
+	set_iost_origin(base);
+
+	for (address = 0; address < 0x100000000ul; address += io_page_size) {
+		ioste = get_iost_entry(0x10000000000ul, address, io_page_size);
+		if ((address & 0xfffffff) == 0) /* segment start */
+			set_iost_cache(base, address >> 28, ioste);
+		index = get_ioc_hash_1way(ioste, address);
+		pr_debug("addr %08lx, index %02lx, ioste %016lx\n",
+					 address, index, ioste.val);
+		set_iopt_cache(base,
+			get_ioc_hash_1way(ioste, address),
+			get_ioc_tag(ioste, address),
+			map_iopt_entry(address));
+	}
+	iounmap(base);
+}
+
+
+static void *cell_alloc_coherent(struct device *hwdev, size_t size,
+			   dma_addr_t *dma_handle, unsigned int __nocast flag)
+{
+	void *ret;
+
+	ret = (void *)__get_free_pages(flag, get_order(size));
+	if (ret != NULL) {
+		memset(ret, 0, size);
+		*dma_handle = virt_to_abs(ret) | CELL_DMA_VALID;
+	}
+	return ret;
+}
+
+static void cell_free_coherent(struct device *hwdev, size_t size,
+				 void *vaddr, dma_addr_t dma_handle)
+{
+	free_pages((unsigned long)vaddr, get_order(size));
+}
+
+static dma_addr_t cell_map_single(struct device *hwdev, void *ptr,
+		size_t size, enum dma_data_direction direction)
+{
+	return virt_to_abs(ptr) | CELL_DMA_VALID;
+}
+
+static void cell_unmap_single(struct device *hwdev, dma_addr_t dma_addr,
+		size_t size, enum dma_data_direction direction)
+{
+}
+
+static int cell_map_sg(struct device *hwdev, struct scatterlist *sg,
+		int nents, enum dma_data_direction direction)
+{
+	int i;
+
+	for (i = 0; i < nents; i++, sg++) {
+		sg->dma_address = (page_to_phys(sg->page) + sg->offset)
+					| CELL_DMA_VALID;
+		sg->dma_length = sg->length;
+	}
+
+	return nents;
+}
+
+static void cell_unmap_sg(struct device *hwdev, struct scatterlist *sg,
+		int nents, enum dma_data_direction direction)
+{
+}
+
+static int cell_dma_supported(struct device *dev, u64 mask)
+{
+	return mask < 0x100000000ull;
+}
+
+void cell_init_iommu(void)
+{
+	cell_map_iommu();
+
+	/* Direct I/O, IOMMU off */
+	ppc_md.iommu_dev_setup = iommu_dev_setup_null;
+	ppc_md.iommu_bus_setup = iommu_bus_setup_null;
+
+	pci_dma_ops.alloc_coherent = cell_alloc_coherent;
+	pci_dma_ops.free_coherent = cell_free_coherent;
+	pci_dma_ops.map_single = cell_map_single;
+	pci_dma_ops.unmap_single = cell_unmap_single;
+	pci_dma_ops.map_sg = cell_map_sg;
+	pci_dma_ops.unmap_sg = cell_unmap_sg;
+	pci_dma_ops.dma_supported = cell_dma_supported;
+}
--- linux-cg.orig/arch/powerpc/platforms/cell/iommu.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/arch/powerpc/platforms/cell/iommu.h	2005-09-01 02:37:46.077991888 -0400
@@ -0,0 +1,65 @@
+#ifndef CELL_IOMMU_H
+#define CELL_IOMMU_H
+
+/* some constants */
+enum {
+	/* segment table entries */
+	IOST_VALID_MASK	  = 0x8000000000000000ul,
+	IOST_TAG_MASK     = 0x3000000000000000ul,
+	IOST_PT_BASE_MASK = 0x000003fffffff000ul,
+	IOST_NNPT_MASK	  = 0x0000000000000fe0ul,
+	IOST_PS_MASK	  = 0x000000000000000ful,
+
+	IOST_PS_4K	  = 0x1,
+	IOST_PS_64K	  = 0x3,
+	IOST_PS_1M	  = 0x5,
+	IOST_PS_16M	  = 0x7,
+
+	/* iopt tag register */
+	IOPT_VALID_MASK   = 0x0000000200000000ul,
+	IOPT_TAG_MASK	  = 0x00000001fffffffful,
+
+	/* iopt cache register */
+	IOPT_PROT_MASK	  = 0xc000000000000000ul,
+	IOPT_PROT_NONE	  = 0x0000000000000000ul,
+	IOPT_PROT_READ	  = 0x4000000000000000ul,
+	IOPT_PROT_WRITE	  = 0x8000000000000000ul,
+	IOPT_PROT_RW	  = 0xc000000000000000ul,
+	IOPT_COHERENT	  = 0x2000000000000000ul,
+	
+	IOPT_ORDER_MASK	  = 0x1800000000000000ul,
+	/* order access to same IOID/VC on same address */
+	IOPT_ORDER_ADDR	  = 0x0800000000000000ul,
+	/* similar, but only after a write access */
+	IOPT_ORDER_WRITES = 0x1000000000000000ul,
+	/* Order all accesses to same IOID/VC */
+	IOPT_ORDER_VC	  = 0x1800000000000000ul,
+	
+	IOPT_RPN_MASK	  = 0x000003fffffff000ul,
+	IOPT_HINT_MASK	  = 0x0000000000000800ul,
+	IOPT_IOID_MASK	  = 0x00000000000007fful,
+
+	IOSTO_ENABLE	  = 0x8000000000000000ul,
+	IOSTO_ORIGIN	  = 0x000003fffffff000ul,
+	IOSTO_HW	  = 0x0000000000000800ul,
+	IOSTO_SW	  = 0x0000000000000400ul,
+
+	IOCMD_CONF_TE	  = 0x0000800000000000ul,
+
+	/* memory mapped registers */
+	IOC_PT_CACHE_DIR  = 0x000,
+	IOC_ST_CACHE_DIR  = 0x800,
+	IOC_PT_CACHE_REG  = 0x910,
+	IOC_ST_ORIGIN     = 0x918,
+	IOC_CONF	  = 0x930,
+
+	/* The high bit needs to be set on every DMA address,
+	   only 2GB are addressable */
+	CELL_DMA_VALID	  = 0x80000000,
+	CELL_DMA_MASK	  = 0x7fffffff,
+};
+
+
+void cell_init_iommu(void);
+
+#endif
--- linux-cg.orig/arch/powerpc/platforms/cell/nvram.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/arch/powerpc/platforms/cell/nvram.c	2005-09-01 02:37:46.077991888 -0400
@@ -0,0 +1,118 @@
+/*
+ * NVRAM for Cell Blade
+ *
+ * (C) Copyright IBM Corp. 2005
+ *
+ * Authors : Utz Bacher <utz.bacher@de.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include <asm/machdep.h>
+#include <asm/nvram.h>
+#include <asm/prom.h>
+
+static void __iomem *cell_nvram_start;
+static long cell_nvram_len;
+static spinlock_t cell_nvram_lock = SPIN_LOCK_UNLOCKED;
+
+static ssize_t cell_nvram_read(char *buf, size_t count, loff_t *index)
+{
+	unsigned long flags;
+
+	if (*index >= cell_nvram_len)
+		return 0;
+	if (*index + count > cell_nvram_len)
+		count = cell_nvram_len - *index;
+
+	spin_lock_irqsave(&cell_nvram_lock, flags);
+
+	memcpy_fromio(buf, cell_nvram_start + *index, count);
+
+	spin_unlock_irqrestore(&cell_nvram_lock, flags);
+	
+	*index += count;
+	return count;
+}
+
+static ssize_t cell_nvram_write(char *buf, size_t count, loff_t *index)
+{
+	unsigned long flags;
+
+	if (*index >= cell_nvram_len)
+		return 0;
+	if (*index + count > cell_nvram_len)
+		count = cell_nvram_len - *index;
+
+	spin_lock_irqsave(&cell_nvram_lock, flags);
+
+	memcpy_toio(cell_nvram_start + *index, buf, count);
+
+	spin_unlock_irqrestore(&cell_nvram_lock, flags);
+	
+	*index += count;
+	return count;
+}
+
+static ssize_t cell_nvram_get_size(void)
+{
+	return cell_nvram_len;
+}
+
+int __init cell_nvram_init(void)
+{
+	struct device_node *nvram_node;
+	unsigned long *buffer;
+	int proplen;
+	unsigned long nvram_addr;
+	int ret;
+
+	ret = -ENODEV;
+	nvram_node = of_find_node_by_type(NULL, "nvram");
+	if (!nvram_node)
+		goto out;
+
+	ret = -EIO;
+	buffer = (unsigned long *)get_property(nvram_node, "reg", &proplen);
+	if (proplen != 2*sizeof(unsigned long))
+		goto out;
+
+	ret = -ENODEV;
+	nvram_addr = buffer[0];
+	cell_nvram_len = buffer[1];
+	if ( (!cell_nvram_len) || (!nvram_addr) )
+		goto out;
+
+	cell_nvram_start = ioremap(nvram_addr, cell_nvram_len);
+	if (!cell_nvram_start)
+		goto out;
+
+	printk(KERN_INFO "CBEA NVRAM, %luk mapped to %p\n",
+	       cell_nvram_len >> 10, cell_nvram_start);
+
+	ppc_md.nvram_read	= cell_nvram_read;
+	ppc_md.nvram_write	= cell_nvram_write;
+	ppc_md.nvram_size	= cell_nvram_get_size;
+
+out:
+	of_node_put(nvram_node);
+	return ret;
+}
--- linux-cg.orig/arch/powerpc/platforms/cell/pic.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/arch/powerpc/platforms/cell/pic.c	2005-09-01 02:37:46.079991584 -0400
@@ -0,0 +1,269 @@
+/*
+ * Cell Internal Interrupt Controller
+ *
+ * (C) Copyright IBM Deutschland Entwicklung GmbH 2005
+ *
+ * Author: Arnd Bergmann <arndb@de.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/config.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/percpu.h>
+#include <linux/types.h>
+
+#include <asm/cell-pic.h>
+#include <asm/io.h>
+#include <asm/pgtable.h>
+#include <asm/prom.h>
+#include <asm/ptrace.h>
+
+struct iic_pending_bits {
+	u32 data;
+	u8 flags;
+	u8 class;
+	u8 source;
+	u8 prio;
+};
+
+enum iic_pending_flags {
+	IIC_VALID = 0x80,
+	IIC_IPI   = 0x40,
+};
+
+struct iic_regs {
+	struct iic_pending_bits pending;
+	struct iic_pending_bits pending_destr;
+	u64 generate;
+	u64 prio;
+};
+
+struct iic {
+	struct iic_regs __iomem *regs;
+};
+
+static DEFINE_PER_CPU(struct iic, iic);
+
+void iic_local_enable(void)
+{
+	out_be64(&__get_cpu_var(iic).regs->prio, 0xff);
+}
+
+void iic_local_disable(void)
+{
+	out_be64(&__get_cpu_var(iic).regs->prio, 0x0);
+}
+
+static unsigned int iic_startup(unsigned int irq)
+{
+	return 0;
+}
+
+static void iic_enable(unsigned int irq)
+{
+	iic_local_enable();
+}
+
+static void iic_disable(unsigned int irq)
+{
+}
+
+static void iic_end(unsigned int irq)
+{
+	iic_local_enable();
+}
+
+static struct hw_interrupt_type iic_pic = {
+	.typename = " CELLPIC  ",
+	.startup = iic_startup,
+	.enable = iic_enable,
+	.disable = iic_disable,
+	.end = iic_end,
+};
+
+static int iic_external_get_irq(struct iic_pending_bits pending)
+{
+	int irq;
+	unsigned char node, unit;
+
+	node = pending.source >> 4;
+	unit = pending.source & 0xf;
+	irq = -1;
+
+	/*
+	 * This mapping is specific to the Broadband
+	 * Engine. We might need to get the numbers
+	 * from the device tree to support future CPUs.
+	 */
+	switch (unit) {
+	case 0x00:
+	case 0x0b:
+		/*
+		 * One of these units can be connected
+		 * to an external interrupt controller.
+		 */
+		if (pending.prio > 0x3f ||
+		    pending.class != 2)
+			break;
+		irq = IIC_EXT_OFFSET
+			+ spider_get_irq(pending.prio + node * IIC_NODE_STRIDE)
+			+ node * IIC_NODE_STRIDE;
+		break;
+	case 0x01 ... 0x04:
+	case 0x07 ... 0x0a:
+		/*
+		 * These units are connected to the SPEs
+		 */
+		if (pending.class > 2)
+			break;
+		irq = IIC_SPE_OFFSET
+			+ pending.class * IIC_CLASS_STRIDE
+			+ node * IIC_NODE_STRIDE
+			+ unit;
+		break;
+	}
+	if (irq == -1)
+		printk(KERN_WARNING "Unexpected interrupt class %02x, "
+			"source %02x, prio %02x, cpu %02x\n", pending.class,
+			pending.source, pending.prio, smp_processor_id());
+	return irq;
+}
+
+/* Get an IRQ number from the pending state register of the IIC */
+int iic_get_irq(struct pt_regs *regs)
+{
+	struct iic *iic;
+	int irq;
+	struct iic_pending_bits pending;
+
+	iic = &__get_cpu_var(iic);
+	*(unsigned long *) &pending = 
+		in_be64((unsigned long __iomem *) &iic->regs->pending_destr);
+
+	irq = -1;
+	if (pending.flags & IIC_VALID) {
+		if (pending.flags & IIC_IPI) {
+			irq = IIC_IPI_OFFSET + (pending.prio >> 4);
+/*
+			if (irq > 0x80)
+				printk(KERN_WARNING "Unexpected IPI prio %02x"
+					"on CPU %02x\n", pending.prio,
+							smp_processor_id());
+*/
+		} else {
+			irq = iic_external_get_irq(pending);
+		}
+	}
+	return irq;
+}
+
+static struct iic_regs __iomem *find_iic(int cpu)
+{
+	struct device_node *np;
+	int nodeid = cpu / 2;
+	unsigned long regs;
+	struct iic_regs __iomem *iic_regs;
+
+	for (np = of_find_node_by_type(NULL, "cpu");
+	     np;
+	     np = of_find_node_by_type(np, "cpu")) {
+		if (nodeid == *(int *)get_property(np, "node-id", NULL))
+			break;
+	}
+
+	if (!np) {
+		printk(KERN_WARNING "IIC: CPU %d not found\n", cpu);
+		iic_regs = NULL;
+	} else {
+		regs = *(long *)get_property(np, "iic", NULL);
+
+		/* hack until we have decided on the devtree info */
+		regs += 0x400;
+		if (cpu & 1)
+			regs += 0x20;
+
+		printk(KERN_DEBUG "IIC for CPU %d at %lx\n", cpu, regs);
+		iic_regs = __ioremap(regs, sizeof(struct iic_regs),
+						 _PAGE_NO_CACHE);
+	}
+	return iic_regs;
+}
+
+#ifdef CONFIG_SMP
+void iic_setup_cpu(void)
+{
+	out_be64(&__get_cpu_var(iic).regs->prio, 0xff);
+}
+
+void iic_cause_IPI(int cpu, int mesg)
+{
+	out_be64(&per_cpu(iic, cpu).regs->generate, mesg);
+}
+
+static irqreturn_t iic_ipi_action(int irq, void *dev_id, struct pt_regs *regs)
+{
+
+	smp_message_recv(irq - IIC_IPI_OFFSET, regs);
+	return IRQ_HANDLED;
+}
+
+static void iic_request_ipi(int irq, const char *name)
+{
+	/* IPIs are marked SA_INTERRUPT as they must run with irqs
+	 * disabled */
+	get_irq_desc(irq)->handler = &iic_pic;
+	get_irq_desc(irq)->status |= IRQ_PER_CPU;
+	request_irq(irq, iic_ipi_action, SA_INTERRUPT, name, NULL);
+}
+
+void iic_request_IPIs(void)
+{
+	iic_request_ipi(IIC_IPI_OFFSET + PPC_MSG_CALL_FUNCTION, "IPI-call");
+	iic_request_ipi(IIC_IPI_OFFSET + PPC_MSG_RESCHEDULE, "IPI-resched");
+#ifdef CONFIG_DEBUGGER
+	iic_request_ipi(IIC_IPI_OFFSET + PPC_MSG_DEBUGGER_BREAK, "IPI-debug");
+#endif /* CONFIG_DEBUGGER */
+}
+#endif /* CONFIG_SMP */
+
+static void iic_setup_spe_handlers(void)
+{
+	int be, isrc;
+
+	/* Assume two threads per BE are present */
+	for (be=0; be < num_present_cpus() / 2; be++) {
+		for (isrc = 0; isrc < IIC_CLASS_STRIDE * 3; isrc++) {
+			int irq = IIC_NODE_STRIDE * be + IIC_SPE_OFFSET + isrc;
+			get_irq_desc(irq)->handler = &iic_pic;
+		}
+	}
+}
+
+void iic_init_IRQ(void)
+{
+	int cpu, irq_offset;
+	struct iic *iic;
+
+	irq_offset = 0;
+	for_each_cpu(cpu) {
+		iic = &per_cpu(iic, cpu);
+		iic->regs = find_iic(cpu);
+		if (iic->regs)
+			out_be64(&iic->regs->prio, 0xff);
+	}
+	iic_setup_spe_handlers();
+}
--- linux-cg.orig/arch/powerpc/platforms/cell/setup.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/arch/powerpc/platforms/cell/setup.c	2005-09-01 02:37:46.079991584 -0400
@@ -0,0 +1,138 @@
+/*
+ *  Copyright (C) 1995  Linus Torvalds
+ *  Adapted from 'alpha' version by Gary Thomas
+ *  Modified by Cort Dougan (cort@cs.nmt.edu)
+ *  Modified by PPC64 Team, IBM Corp
+ *  Modified by Cell Team, IBM Deutschland Entwicklung GmbH
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#undef DEBUG
+
+#include <linux/config.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/stddef.h>
+#include <linux/unistd.h>
+#include <linux/slab.h>
+#include <linux/user.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/seq_file.h>
+#include <linux/root_dev.h>
+#include <linux/console.h>
+
+#include <asm/cell-pic.h>
+#include <asm/mmu.h>
+#include <asm/processor.h>
+#include <asm/io.h>
+#include <asm/pgtable.h>
+#include <asm/prom.h>
+#include <asm/rtas.h>
+#include <asm/pci-bridge.h>
+#include <asm/iommu.h>
+#include <asm/dma.h>
+#include <asm/machdep.h>
+#include <asm/time.h>
+#include <asm/nvram.h>
+#include <asm/cputable.h>
+
+#include "../../../ppc64/kernel/pci.h"
+#include "iommu.h"
+
+#ifdef DEBUG
+#define DBG(fmt...) udbg_printf(fmt)
+#else
+#define DBG(fmt...)
+#endif
+
+void cell_get_cpuinfo(struct seq_file *m)
+{
+	struct device_node *root;
+	const char *model = "";
+
+	root = of_find_node_by_path("/");
+	if (root)
+		model = get_property(root, "model", NULL);
+	seq_printf(m, "machine\t\t: Cell %s\n", model);
+	of_node_put(root);
+}
+
+static void cell_progress(char *s, unsigned short hex)
+{
+	printk("*** %04x : %s\n", hex, s ? s : "");
+}
+
+static void __init cell_setup_arch(void)
+{
+	ppc_md.init_IRQ       = iic_init_IRQ;
+	ppc_md.get_irq        = iic_get_irq;
+
+#ifdef CONFIG_SMP
+	smp_init_pSeries();
+#endif
+
+	/* init to some ~sane value until calibrate_delay() runs */
+	loops_per_jiffy = 50000000;
+
+	if (ROOT_DEV == 0) {
+		printk("No ramdisk, default root is /dev/hda2\n");
+		ROOT_DEV = Root_HDA2;
+	}
+
+	/* Find and initialize PCI host bridges */
+	init_pci_config_tokens();
+	find_and_init_phbs();
+	spider_init_IRQ();
+#ifdef CONFIG_DUMMY_CONSOLE
+	conswitchp = &dummy_con;
+#endif
+
+	cell_nvram_init();
+}
+
+/*
+ * Early initialization.  Relocation is on but do not reference unbolted pages
+ */
+static void __init cell_init_early(void)
+{
+	DBG(" -> cell_init_early()\n");
+
+	hpte_init_native();
+
+	cell_init_iommu();
+
+	ppc64_interrupt_controller = IC_CELL_PIC;
+
+	DBG(" <- cell_init_early()\n");
+}
+
+
+static int __init cell_probe(int platform)
+{
+	if (platform != PLATFORM_CELL)
+		return 0;
+
+	return 1;
+}
+
+struct machdep_calls __initdata cell_md = {
+	.probe			= cell_probe,
+	.setup_arch		= cell_setup_arch,
+	.init_early		= cell_init_early,
+	.get_cpuinfo		= cell_get_cpuinfo,
+	.restart		= rtas_restart,
+	.power_off		= rtas_power_off,
+	.halt			= rtas_halt,
+	.get_boot_time		= rtas_get_boot_time,
+	.get_rtc_time		= rtas_get_rtc_time,
+	.set_rtc_time		= rtas_set_rtc_time,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= cell_progress,
+};
--- linux-cg.orig/arch/powerpc/platforms/cell/spider-pic.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/arch/powerpc/platforms/cell/spider-pic.c	2005-09-01 02:37:46.081991280 -0400
@@ -0,0 +1,190 @@
+/*
+ * External Interrupt Controller on Spider South Bridge
+ *
+ * (C) Copyright IBM Deutschland Entwicklung GmbH 2005
+ *
+ * Author: Arnd Bergmann <arndb@de.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+
+#include <asm/cell-pic.h>
+#include <asm/pgtable.h>
+#include <asm/prom.h>
+#include <asm/io.h>
+
+/* register layout taken from Spider spec, table 7.4-4 */
+enum {
+	TIR_DEN		= 0x004, /* Detection Enable Register */
+	TIR_MSK		= 0x084, /* Mask Level Register */
+	TIR_EDC		= 0x0c0, /* Edge Detection Clear Register */
+	TIR_PNDA	= 0x100, /* Pending Register A */
+	TIR_PNDB	= 0x104, /* Pending Register B */
+	TIR_CS		= 0x144, /* Current Status Register */
+	TIR_LCSA	= 0x150, /* Level Current Status Register A */
+	TIR_LCSB	= 0x154, /* Level Current Status Register B */
+	TIR_LCSC	= 0x158, /* Level Current Status Register C */
+	TIR_LCSD	= 0x15c, /* Level Current Status Register D */
+	TIR_CFGA	= 0x200, /* Setting Register A0 */
+	TIR_CFGB	= 0x204, /* Setting Register B0 */
+			/* 0x208 ... 0x3ff Setting Register An/Bn */
+	TIR_PPNDA	= 0x400, /* Packet Pending Register A */
+	TIR_PPNDB	= 0x404, /* Packet Pending Register B */
+	TIR_PIERA	= 0x408, /* Packet Output Error Register A */
+	TIR_PIERB	= 0x40c, /* Packet Output Error Register B */
+	TIR_PIEN	= 0x444, /* Packet Output Enable Register */
+	TIR_PIPND	= 0x454, /* Packet Output Pending Register */
+	TIRDID		= 0x484, /* Spider Device ID Register */
+	REISTIM		= 0x500, /* Reissue Command Timeout Time Setting */
+	REISTIMEN	= 0x504, /* Reissue Command Timeout Setting */
+	REISWAITEN	= 0x508, /* Reissue Wait Control*/
+};
+
+static void __iomem *spider_pics[4];
+
+static void __iomem *spider_get_pic(int irq)
+{
+	int node = irq / IIC_NODE_STRIDE;
+	irq %= IIC_NODE_STRIDE;
+
+	if (irq >= IIC_EXT_OFFSET &&
+	    irq < IIC_EXT_OFFSET + IIC_NUM_EXT &&
+	    spider_pics)
+		return spider_pics[node];
+	return NULL;
+}
+
+static int spider_get_nr(unsigned int irq)
+{
+	return (irq % IIC_NODE_STRIDE) - IIC_EXT_OFFSET;
+}
+
+static void __iomem *spider_get_irq_config(int irq)
+{
+	void __iomem *pic;
+	pic = spider_get_pic(irq);
+	return pic + TIR_CFGA + 8 * spider_get_nr(irq);
+}
+
+static void spider_enable_irq(unsigned int irq)
+{
+	void __iomem *cfg = spider_get_irq_config(irq);
+	irq = spider_get_nr(irq);
+
+	out_be32(cfg, in_be32(cfg) | 0x3107000eu);
+	out_be32(cfg + 4, in_be32(cfg + 4) | 0x00020000u | irq);
+}
+
+static void spider_disable_irq(unsigned int irq)
+{
+	void __iomem *cfg = spider_get_irq_config(irq);
+	irq = spider_get_nr(irq);
+
+	out_be32(cfg, in_be32(cfg) & ~0x30000000u);
+}
+
+static unsigned int spider_startup_irq(unsigned int irq)
+{
+	spider_enable_irq(irq);
+	return 0;
+}
+
+static void spider_shutdown_irq(unsigned int irq)
+{
+	spider_disable_irq(irq);
+}
+
+static void spider_end_irq(unsigned int irq)
+{
+	spider_enable_irq(irq);
+}
+
+static void spider_ack_irq(unsigned int irq)
+{
+	spider_disable_irq(irq);
+	iic_local_enable();
+}
+
+static struct hw_interrupt_type spider_pic = {
+	.typename = " SPIDER   ",
+	.startup = spider_startup_irq,
+	.shutdown = spider_shutdown_irq,
+	.enable = spider_enable_irq,
+	.disable = spider_disable_irq,
+	.ack = spider_ack_irq,
+	.end = spider_end_irq,
+};
+
+
+int spider_get_irq(unsigned long int_pending)
+{
+	void __iomem *regs = spider_get_pic(int_pending);
+	unsigned long cs;
+	int irq;
+
+	cs = in_be32(regs + TIR_CS);
+
+	irq = cs >> 24;
+	if (irq != 63)
+		return irq;
+
+	return -1;
+}
+ 
+void spider_init_IRQ(void)
+{
+	int node;
+	struct device_node *dn;
+	unsigned int *property;
+	long spiderpic;
+	int n;
+
+/* FIXME: detect multiple PICs as soon as the device tree has them */
+	for (node = 0; node < 1; node++) {
+		dn = of_find_node_by_path("/");
+		n = prom_n_addr_cells(dn);
+		property = (unsigned int *) get_property(dn,
+				"platform-spider-pic", NULL);
+
+		if (!property)
+			continue;
+		for (spiderpic = 0; n > 0; --n)
+			spiderpic = (spiderpic << 32) + *property++;
+		printk(KERN_DEBUG "SPIDER addr: %lx\n", spiderpic);
+		spider_pics[node] = __ioremap(spiderpic, 0x800, _PAGE_NO_CACHE);
+		for (n = 0; n < IIC_NUM_EXT; n++) {
+			int irq = n + IIC_EXT_OFFSET + node * IIC_NODE_STRIDE;
+			get_irq_desc(irq)->handler = &spider_pic;
+
+ 		/* do not mask any interrupts because of level */
+ 		out_be32(spider_pics[node] + TIR_MSK, 0x0);
+ 		
+ 		/* disable edge detection clear */
+ 		/* out_be32(spider_pics[node] + TIR_EDC, 0x0); */
+ 		
+ 		/* enable interrupt packets to be output */
+ 		out_be32(spider_pics[node] + TIR_PIEN,
+			in_be32(spider_pics[node] + TIR_PIEN) | 0x1);
+ 		
+ 		/* Enable the interrupt detection enable bit. Do this last! */
+ 		out_be32(spider_pics[node] + TIR_DEN,
+			in_be32(spider_pics[node] +TIR_DEN) | 0x1);
+
+		}
+	}
+}
--- linux-cg.orig/arch/ppc64/Kconfig	2005-09-01 02:37:40.900980184 -0400
+++ linux-cg/arch/ppc64/Kconfig	2005-09-01 02:37:46.081991280 -0400
@@ -77,10 +77,16 @@ config PPC_PSERIES
 	bool "  IBM pSeries & new iSeries"
 	default y
 
-config PPC_BPA
-	bool "  Broadband Processor Architecture"
+config PPC_CELL
+	bool "  Cell Broadband Engine Architecture"
 	depends on PPC_MULTIPLATFORM
 
+# This is being phased out in the move to arch/powerpc
+config PPC_BPA
+	bool
+	default y
+	depends on PPC_CELL
+
 config PPC_PMAC
 	depends on PPC_MULTIPLATFORM
 	bool "  Apple G5 based machines"
--- linux-cg.orig/arch/ppc64/kernel/Makefile	2005-09-01 02:37:40.903979728 -0400
+++ linux-cg/arch/ppc64/kernel/Makefile	2005-09-01 02:37:46.082991128 -0400
@@ -33,8 +33,7 @@ obj-$(CONFIG_PPC_PSERIES) += pSeries_pci
 			     pSeries_nvram.o rtasd.o ras.o pSeries_reconfig.o \
 			     pSeries_setup.o pSeries_iommu.o
 
-obj-$(CONFIG_PPC_BPA) += bpa_setup.o bpa_iommu.o bpa_nvram.o \
-			 bpa_iic.o spider-pic.o
+obj-$(CONFIG_PPC_CELL) += ../../powerpc/platforms/cell/
 
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o
 obj-$(CONFIG_EEH)		+= eeh.o
@@ -68,7 +67,7 @@ ifdef CONFIG_SMP
 obj-$(CONFIG_PPC_PMAC)		+= pmac_smp.o smp-tbsync.o
 obj-$(CONFIG_PPC_ISERIES)	+= iSeries_smp.o
 obj-$(CONFIG_PPC_PSERIES)	+= pSeries_smp.o
-obj-$(CONFIG_PPC_BPA)		+= pSeries_smp.o
+obj-$(CONFIG_PPC_CELL)		+= pSeries_smp.o
 obj-$(CONFIG_PPC_MAPLE)		+= smp-tbsync.o
 endif
 
--- linux-cg.orig/arch/ppc64/kernel/bpa_iic.c	2005-09-01 02:37:40.905979424 -0400
+++ linux-cg/arch/ppc64/kernel/bpa_iic.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,270 +0,0 @@
-/*
- * BPA Internal Interrupt Controller
- *
- * (C) Copyright IBM Deutschland Entwicklung GmbH 2005
- *
- * Author: Arnd Bergmann <arndb@de.ibm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2, or (at your option)
- * any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/config.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/percpu.h>
-#include <linux/types.h>
-
-#include <asm/io.h>
-#include <asm/pgtable.h>
-#include <asm/prom.h>
-#include <asm/ptrace.h>
-
-#include "bpa_iic.h"
-
-struct iic_pending_bits {
-	u32 data;
-	u8 flags;
-	u8 class;
-	u8 source;
-	u8 prio;
-};
-
-enum iic_pending_flags {
-	IIC_VALID = 0x80,
-	IIC_IPI   = 0x40,
-};
-
-struct iic_regs {
-	struct iic_pending_bits pending;
-	struct iic_pending_bits pending_destr;
-	u64 generate;
-	u64 prio;
-};
-
-struct iic {
-	struct iic_regs __iomem *regs;
-};
-
-static DEFINE_PER_CPU(struct iic, iic);
-
-void iic_local_enable(void)
-{
-	out_be64(&__get_cpu_var(iic).regs->prio, 0xff);
-}
-
-void iic_local_disable(void)
-{
-	out_be64(&__get_cpu_var(iic).regs->prio, 0x0);
-}
-
-static unsigned int iic_startup(unsigned int irq)
-{
-	return 0;
-}
-
-static void iic_enable(unsigned int irq)
-{
-	iic_local_enable();
-}
-
-static void iic_disable(unsigned int irq)
-{
-}
-
-static void iic_end(unsigned int irq)
-{
-	iic_local_enable();
-}
-
-static struct hw_interrupt_type iic_pic = {
-	.typename = " BPA-IIC  ",
-	.startup = iic_startup,
-	.enable = iic_enable,
-	.disable = iic_disable,
-	.end = iic_end,
-};
-
-static int iic_external_get_irq(struct iic_pending_bits pending)
-{
-	int irq;
-	unsigned char node, unit;
-
-	node = pending.source >> 4;
-	unit = pending.source & 0xf;
-	irq = -1;
-
-	/*
-	 * This mapping is specific to the Broadband
-	 * Engine. We might need to get the numbers
-	 * from the device tree to support future CPUs.
-	 */
-	switch (unit) {
-	case 0x00:
-	case 0x0b:
-		/*
-		 * One of these units can be connected
-		 * to an external interrupt controller.
-		 */
-		if (pending.prio > 0x3f ||
-		    pending.class != 2)
-			break;
-		irq = IIC_EXT_OFFSET
-			+ spider_get_irq(pending.prio + node * IIC_NODE_STRIDE)
-			+ node * IIC_NODE_STRIDE;
-		break;
-	case 0x01 ... 0x04:
-	case 0x07 ... 0x0a:
-		/*
-		 * These units are connected to the SPEs
-		 */
-		if (pending.class > 2)
-			break;
-		irq = IIC_SPE_OFFSET
-			+ pending.class * IIC_CLASS_STRIDE
-			+ node * IIC_NODE_STRIDE
-			+ unit;
-		break;
-	}
-	if (irq == -1)
-		printk(KERN_WARNING "Unexpected interrupt class %02x, "
-			"source %02x, prio %02x, cpu %02x\n", pending.class,
-			pending.source, pending.prio, smp_processor_id());
-	return irq;
-}
-
-/* Get an IRQ number from the pending state register of the IIC */
-int iic_get_irq(struct pt_regs *regs)
-{
-	struct iic *iic;
-	int irq;
-	struct iic_pending_bits pending;
-
-	iic = &__get_cpu_var(iic);
-	*(unsigned long *) &pending = 
-		in_be64((unsigned long __iomem *) &iic->regs->pending_destr);
-
-	irq = -1;
-	if (pending.flags & IIC_VALID) {
-		if (pending.flags & IIC_IPI) {
-			irq = IIC_IPI_OFFSET + (pending.prio >> 4);
-/*
-			if (irq > 0x80)
-				printk(KERN_WARNING "Unexpected IPI prio %02x"
-					"on CPU %02x\n", pending.prio,
-							smp_processor_id());
-*/
-		} else {
-			irq = iic_external_get_irq(pending);
-		}
-	}
-	return irq;
-}
-
-static struct iic_regs __iomem *find_iic(int cpu)
-{
-	struct device_node *np;
-	int nodeid = cpu / 2;
-	unsigned long regs;
-	struct iic_regs __iomem *iic_regs;
-
-	for (np = of_find_node_by_type(NULL, "cpu");
-	     np;
-	     np = of_find_node_by_type(np, "cpu")) {
-		if (nodeid == *(int *)get_property(np, "node-id", NULL))
-			break;
-	}
-
-	if (!np) {
-		printk(KERN_WARNING "IIC: CPU %d not found\n", cpu);
-		iic_regs = NULL;
-	} else {
-		regs = *(long *)get_property(np, "iic", NULL);
-
-		/* hack until we have decided on the devtree info */
-		regs += 0x400;
-		if (cpu & 1)
-			regs += 0x20;
-
-		printk(KERN_DEBUG "IIC for CPU %d at %lx\n", cpu, regs);
-		iic_regs = __ioremap(regs, sizeof(struct iic_regs),
-						 _PAGE_NO_CACHE);
-	}
-	return iic_regs;
-}
-
-#ifdef CONFIG_SMP
-void iic_setup_cpu(void)
-{
-	out_be64(&__get_cpu_var(iic).regs->prio, 0xff);
-}
-
-void iic_cause_IPI(int cpu, int mesg)
-{
-	out_be64(&per_cpu(iic, cpu).regs->generate, mesg);
-}
-
-static irqreturn_t iic_ipi_action(int irq, void *dev_id, struct pt_regs *regs)
-{
-
-	smp_message_recv(irq - IIC_IPI_OFFSET, regs);
-	return IRQ_HANDLED;
-}
-
-static void iic_request_ipi(int irq, const char *name)
-{
-	/* IPIs are marked SA_INTERRUPT as they must run with irqs
-	 * disabled */
-	get_irq_desc(irq)->handler = &iic_pic;
-	get_irq_desc(irq)->status |= IRQ_PER_CPU;
-	request_irq(irq, iic_ipi_action, SA_INTERRUPT, name, NULL);
-}
-
-void iic_request_IPIs(void)
-{
-	iic_request_ipi(IIC_IPI_OFFSET + PPC_MSG_CALL_FUNCTION, "IPI-call");
-	iic_request_ipi(IIC_IPI_OFFSET + PPC_MSG_RESCHEDULE, "IPI-resched");
-#ifdef CONFIG_DEBUGGER
-	iic_request_ipi(IIC_IPI_OFFSET + PPC_MSG_DEBUGGER_BREAK, "IPI-debug");
-#endif /* CONFIG_DEBUGGER */
-}
-#endif /* CONFIG_SMP */
-
-static void iic_setup_spe_handlers(void)
-{
-	int be, isrc;
-
-	/* Assume two threads per BE are present */
-	for (be=0; be < num_present_cpus() / 2; be++) {
-		for (isrc = 0; isrc < IIC_CLASS_STRIDE * 3; isrc++) {
-			int irq = IIC_NODE_STRIDE * be + IIC_SPE_OFFSET + isrc;
-			get_irq_desc(irq)->handler = &iic_pic;
-		}
-	}
-}
-
-void iic_init_IRQ(void)
-{
-	int cpu, irq_offset;
-	struct iic *iic;
-
-	irq_offset = 0;
-	for_each_cpu(cpu) {
-		iic = &per_cpu(iic, cpu);
-		iic->regs = find_iic(cpu);
-		if (iic->regs)
-			out_be64(&iic->regs->prio, 0xff);
-	}
-	iic_setup_spe_handlers();
-}
--- linux-cg.orig/arch/ppc64/kernel/bpa_iic.h	2005-09-01 02:37:40.908978968 -0400
+++ linux-cg/arch/ppc64/kernel/bpa_iic.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,62 +0,0 @@
-#ifndef ASM_BPA_IIC_H
-#define ASM_BPA_IIC_H
-#ifdef __KERNEL__
-/*
- * Mapping of IIC pending bits into per-node
- * interrupt numbers.
- *
- * IRQ     FF CC SS PP   FF CC SS PP	Description
- *
- * 00-3f   80 02 +0 00 - 80 02 +0 3f	South Bridge
- * 00-3f   80 02 +b 00 - 80 02 +b 3f	South Bridge
- * 41-4a   80 00 +1 ** - 80 00 +a **	SPU Class 0
- * 51-5a   80 01 +1 ** - 80 01 +a **	SPU Class 1
- * 61-6a   80 02 +1 ** - 80 02 +a **	SPU Class 2
- * 70-7f   C0 ** ** 00 - C0 ** ** 0f	IPI
- *
- *    F flags
- *    C class
- *    S source
- *    P Priority
- *    + node number
- *    * don't care
- *
- * A node consists of a Broadband Engine and an optional
- * south bridge device providing a maximum of 64 IRQs.
- * The south bridge may be connected to either IOIF0
- * or IOIF1.
- * Each SPE is represented as three IRQ lines, one per
- * interrupt class.
- * 16 IRQ numbers are reserved for inter processor
- * interruptions, although these are only used in the
- * range of the first node.
- *
- * This scheme needs 128 IRQ numbers per BIF node ID,
- * which means that with the total of 512 lines
- * available, we can have a maximum of four nodes.
- */
-
-enum {
-	IIC_EXT_OFFSET   = 0x00, /* Start of south bridge IRQs */
-	IIC_NUM_EXT      = 0x40, /* Number of south bridge IRQs */
-	IIC_SPE_OFFSET   = 0x40, /* Start of SPE interrupts */
-	IIC_CLASS_STRIDE = 0x10, /* SPE IRQs per class    */
-	IIC_IPI_OFFSET   = 0x70, /* Start of IPI IRQs */
-	IIC_NUM_IPIS     = 0x10, /* IRQs reserved for IPI */
-	IIC_NODE_STRIDE  = 0x80, /* Total IRQs per node   */
-};
-
-extern void iic_init_IRQ(void);
-extern int  iic_get_irq(struct pt_regs *regs);
-extern void iic_cause_IPI(int cpu, int mesg);
-extern void iic_request_IPIs(void);
-extern void iic_setup_cpu(void);
-extern void iic_local_enable(void);
-extern void iic_local_disable(void);
-
-
-extern void spider_init_IRQ(void);
-extern int spider_get_irq(unsigned long int_pending);
-
-#endif
-#endif /* ASM_BPA_IIC_H */
--- linux-cg.orig/arch/ppc64/kernel/bpa_iommu.c	2005-09-01 02:37:40.910978664 -0400
+++ linux-cg/arch/ppc64/kernel/bpa_iommu.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,377 +0,0 @@
-/*
- * IOMMU implementation for Broadband Processor Architecture
- * We just establish a linear mapping at boot by setting all the
- * IOPT cache entries in the CPU.
- * The mapping functions should be identical to pci_direct_iommu, 
- * except for the handling of the high order bit that is required
- * by the Spider bridge. These should be split into a separate
- * file at the point where we get a different bridge chip.
- *
- * Copyright (C) 2005 IBM Deutschland Entwicklung GmbH,
- *			 Arnd Bergmann <arndb@de.ibm.com>
- *
- * Based on linear mapping
- * Copyright (C) 2003 Benjamin Herrenschmidt (benh@kernel.crashing.org)
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#undef DEBUG
-
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/delay.h>
-#include <linux/string.h>
-#include <linux/init.h>
-#include <linux/bootmem.h>
-#include <linux/mm.h>
-#include <linux/dma-mapping.h>
-
-#include <asm/sections.h>
-#include <asm/iommu.h>
-#include <asm/io.h>
-#include <asm/prom.h>
-#include <asm/pci-bridge.h>
-#include <asm/machdep.h>
-#include <asm/pmac_feature.h>
-#include <asm/abs_addr.h>
-#include <asm/system.h>
-
-#include "pci.h"
-#include "bpa_iommu.h"
-
-static inline unsigned long 
-get_iopt_entry(unsigned long real_address, unsigned long ioid,
-			 unsigned long prot)
-{
-	return (prot & IOPT_PROT_MASK)
-	     | (IOPT_COHERENT)
-	     | (IOPT_ORDER_VC)
-	     | (real_address & IOPT_RPN_MASK)
-	     | (ioid & IOPT_IOID_MASK);
-}
-
-typedef struct {
-	unsigned long val;
-} ioste;
-
-static inline ioste
-mk_ioste(unsigned long val)
-{
-	ioste ioste = { .val = val, };
-	return ioste;
-}
-
-static inline ioste
-get_iost_entry(unsigned long iopt_base, unsigned long io_address, unsigned page_size)
-{
-	unsigned long ps;
-	unsigned long iostep;
-	unsigned long nnpt;
-	unsigned long shift;
-
-	switch (page_size) {
-	case 0x1000000:
-		ps = IOST_PS_16M;
-		nnpt = 0;  /* one page per segment */
-		shift = 5; /* segment has 16 iopt entries */
-		break;
-
-	case 0x100000:
-		ps = IOST_PS_1M;
-		nnpt = 0;  /* one page per segment */
-		shift = 1; /* segment has 256 iopt entries */
-		break;
-
-	case 0x10000:
-		ps = IOST_PS_64K;
-		nnpt = 0x07; /* 8 pages per io page table */
-		shift = 0;   /* all entries are used */
-		break;
-
-	case 0x1000:
-		ps = IOST_PS_4K;
-		nnpt = 0x7f; /* 128 pages per io page table */
-		shift = 0;   /* all entries are used */
-		break;
-
-	default: /* not a known compile time constant */
-		BUILD_BUG_ON(1);
-		break;
-	}
-
-	iostep = iopt_base +
-			 /* need 8 bytes per iopte */
-			(((io_address / page_size * 8)
-			 /* align io page tables on 4k page boundaries */
-				 << shift) 
-			 /* nnpt+1 pages go into each iopt */
-				 & ~(nnpt << 12));
-
-	nnpt++; /* this seems to work, but the documentation is not clear
-		   about wether we put nnpt or nnpt-1 into the ioste bits.
-		   In theory, this can't work for 4k pages. */
-	return mk_ioste(IOST_VALID_MASK
-			| (iostep & IOST_PT_BASE_MASK)
-			| ((nnpt << 5) & IOST_NNPT_MASK)
-			| (ps & IOST_PS_MASK));
-}
-
-/* compute the address of an io pte */
-static inline unsigned long
-get_ioptep(ioste iost_entry, unsigned long io_address)
-{
-	unsigned long iopt_base;
-	unsigned long page_size;
-	unsigned long page_number;
-	unsigned long iopt_offset;
-
-	iopt_base = iost_entry.val & IOST_PT_BASE_MASK;
-	page_size = iost_entry.val & IOST_PS_MASK;
-
-	/* decode page size to compute page number */
-	page_number = (io_address & 0x0fffffff) >> (10 + 2 * page_size);
-	/* page number is an offset into the io page table */
-	iopt_offset = (page_number << 3) & 0x7fff8ul;
-	return iopt_base + iopt_offset;
-}
-
-/* compute the tag field of the iopt cache entry */
-static inline unsigned long
-get_ioc_tag(ioste iost_entry, unsigned long io_address)
-{
-	unsigned long iopte = get_ioptep(iost_entry, io_address);
-
-	return IOPT_VALID_MASK
-	     | ((iopte & 0x00000000000000ff8ul) >> 3)
-	     | ((iopte & 0x0000003fffffc0000ul) >> 9);
-}
-
-/* compute the hashed 6 bit index for the 4-way associative pte cache */
-static inline unsigned long
-get_ioc_hash(ioste iost_entry, unsigned long io_address)
-{
-	unsigned long iopte = get_ioptep(iost_entry, io_address);
-
-	return ((iopte & 0x000000000000001f8ul) >> 3)
-	     ^ ((iopte & 0x00000000000020000ul) >> 17)
-	     ^ ((iopte & 0x00000000000010000ul) >> 15)
-	     ^ ((iopte & 0x00000000000008000ul) >> 13)
-	     ^ ((iopte & 0x00000000000004000ul) >> 11)
-	     ^ ((iopte & 0x00000000000002000ul) >> 9)
-	     ^ ((iopte & 0x00000000000001000ul) >> 7);
-}
-
-/* same as above, but pretend that we have a simpler 1-way associative
-   pte cache with an 8 bit index */
-static inline unsigned long
-get_ioc_hash_1way(ioste iost_entry, unsigned long io_address)
-{
-	unsigned long iopte = get_ioptep(iost_entry, io_address);
-
-	return ((iopte & 0x000000000000001f8ul) >> 3)
-	     ^ ((iopte & 0x00000000000020000ul) >> 17)
-	     ^ ((iopte & 0x00000000000010000ul) >> 15)
-	     ^ ((iopte & 0x00000000000008000ul) >> 13)
-	     ^ ((iopte & 0x00000000000004000ul) >> 11)
-	     ^ ((iopte & 0x00000000000002000ul) >> 9)
-	     ^ ((iopte & 0x00000000000001000ul) >> 7)
-	     ^ ((iopte & 0x0000000000000c000ul) >> 8);
-}
-
-static inline ioste
-get_iost_cache(void __iomem *base, unsigned long index)
-{
-	unsigned long __iomem *p = (base + IOC_ST_CACHE_DIR);
-	return mk_ioste(in_be64(&p[index]));
-}
-
-static inline void
-set_iost_cache(void __iomem *base, unsigned long index, ioste ste)
-{
-	unsigned long __iomem *p = (base + IOC_ST_CACHE_DIR);
-	pr_debug("ioste %02lx was %016lx, store %016lx", index,
-			get_iost_cache(base, index).val, ste.val);
-	out_be64(&p[index], ste.val);
-	pr_debug(" now %016lx\n", get_iost_cache(base, index).val);
-}
-
-static inline unsigned long
-get_iopt_cache(void __iomem *base, unsigned long index, unsigned long *tag)
-{
-	unsigned long __iomem *tags = (void *)(base + IOC_PT_CACHE_DIR);
-	unsigned long __iomem *p = (void *)(base + IOC_PT_CACHE_REG);	
-
-	*tag = tags[index];
-	rmb();
-	return *p;
-}
-
-static inline void
-set_iopt_cache(void __iomem *base, unsigned long index,
-		 unsigned long tag, unsigned long val)
-{
-	unsigned long __iomem *tags = base + IOC_PT_CACHE_DIR;
-	unsigned long __iomem *p = base + IOC_PT_CACHE_REG;
-	pr_debug("iopt %02lx was v%016lx/t%016lx, store v%016lx/t%016lx\n",
-		index, get_iopt_cache(base, index, &oldtag), oldtag, val, tag);
-
-	out_be64(p, val);
-	out_be64(&tags[index], tag);
-}
-
-static inline void
-set_iost_origin(void __iomem *base)
-{
-	unsigned long __iomem *p = base + IOC_ST_ORIGIN;
-	unsigned long origin = IOSTO_ENABLE | IOSTO_SW;
-
-	pr_debug("iost_origin %016lx, now %016lx\n", in_be64(p), origin);
-	out_be64(p, origin);
-}
-
-static inline void
-set_iocmd_config(void __iomem *base)
-{
-	unsigned long __iomem *p = base + 0xc00;
-	unsigned long conf;
-
-	conf = in_be64(p);
-	pr_debug("iost_conf %016lx, now %016lx\n", conf, conf | IOCMD_CONF_TE);
-	out_be64(p, conf | IOCMD_CONF_TE);
-}
-
-/* FIXME: get these from the device tree */
-#define ioc_base	0x20000511000ull
-#define ioc_mmio_base	0x20000510000ull
-#define ioid		0x48a
-#define iopt_phys_offset (- 0x20000000) /* We have a 512MB offset from the SB */
-#define io_page_size	0x1000000
-
-static unsigned long map_iopt_entry(unsigned long address)
-{
-	switch (address >> 20) {
-	case 0x600:
-		address = 0x24020000000ull; /* spider i/o */
-		break;
-	default:
-		address += iopt_phys_offset;
-		break;
-	}
-
-	return get_iopt_entry(address, ioid, IOPT_PROT_RW);
-}
-
-static void iommu_bus_setup_null(struct pci_bus *b) { }
-static void iommu_dev_setup_null(struct pci_dev *d) { }
-
-/* initialize the iommu to support a simple linear mapping
- * for each DMA window used by any device. For now, we
- * happen to know that there is only one DMA window in use,
- * starting at iopt_phys_offset. */
-static void bpa_map_iommu(void)
-{
-	unsigned long address;
-	void __iomem *base;
-	ioste ioste;
-	unsigned long index;
-
-	base = __ioremap(ioc_base, 0x1000, _PAGE_NO_CACHE);
-	pr_debug("%lx mapped to %p\n", ioc_base, base);
-	set_iocmd_config(base);
-	iounmap(base);
-
-	base = __ioremap(ioc_mmio_base, 0x1000, _PAGE_NO_CACHE);
-	pr_debug("%lx mapped to %p\n", ioc_mmio_base, base);
-
-	set_iost_origin(base);
-
-	for (address = 0; address < 0x100000000ul; address += io_page_size) {
-		ioste = get_iost_entry(0x10000000000ul, address, io_page_size);
-		if ((address & 0xfffffff) == 0) /* segment start */
-			set_iost_cache(base, address >> 28, ioste);
-		index = get_ioc_hash_1way(ioste, address);
-		pr_debug("addr %08lx, index %02lx, ioste %016lx\n",
-					 address, index, ioste.val);
-		set_iopt_cache(base,
-			get_ioc_hash_1way(ioste, address),
-			get_ioc_tag(ioste, address),
-			map_iopt_entry(address));
-	}
-	iounmap(base);
-}
-
-
-static void *bpa_alloc_coherent(struct device *hwdev, size_t size,
-			   dma_addr_t *dma_handle, unsigned int __nocast flag)
-{
-	void *ret;
-
-	ret = (void *)__get_free_pages(flag, get_order(size));
-	if (ret != NULL) {
-		memset(ret, 0, size);
-		*dma_handle = virt_to_abs(ret) | BPA_DMA_VALID;
-	}
-	return ret;
-}
-
-static void bpa_free_coherent(struct device *hwdev, size_t size,
-				 void *vaddr, dma_addr_t dma_handle)
-{
-	free_pages((unsigned long)vaddr, get_order(size));
-}
-
-static dma_addr_t bpa_map_single(struct device *hwdev, void *ptr,
-		size_t size, enum dma_data_direction direction)
-{
-	return virt_to_abs(ptr) | BPA_DMA_VALID;
-}
-
-static void bpa_unmap_single(struct device *hwdev, dma_addr_t dma_addr,
-		size_t size, enum dma_data_direction direction)
-{
-}
-
-static int bpa_map_sg(struct device *hwdev, struct scatterlist *sg,
-		int nents, enum dma_data_direction direction)
-{
-	int i;
-
-	for (i = 0; i < nents; i++, sg++) {
-		sg->dma_address = (page_to_phys(sg->page) + sg->offset)
-					| BPA_DMA_VALID;
-		sg->dma_length = sg->length;
-	}
-
-	return nents;
-}
-
-static void bpa_unmap_sg(struct device *hwdev, struct scatterlist *sg,
-		int nents, enum dma_data_direction direction)
-{
-}
-
-static int bpa_dma_supported(struct device *dev, u64 mask)
-{
-	return mask < 0x100000000ull;
-}
-
-void bpa_init_iommu(void)
-{
-	bpa_map_iommu();
-
-	/* Direct I/O, IOMMU off */
-	ppc_md.iommu_dev_setup = iommu_dev_setup_null;
-	ppc_md.iommu_bus_setup = iommu_bus_setup_null;
-
-	pci_dma_ops.alloc_coherent = bpa_alloc_coherent;
-	pci_dma_ops.free_coherent = bpa_free_coherent;
-	pci_dma_ops.map_single = bpa_map_single;
-	pci_dma_ops.unmap_single = bpa_unmap_single;
-	pci_dma_ops.map_sg = bpa_map_sg;
-	pci_dma_ops.unmap_sg = bpa_unmap_sg;
-	pci_dma_ops.dma_supported = bpa_dma_supported;
-}
--- linux-cg.orig/arch/ppc64/kernel/bpa_iommu.h	2005-09-01 02:37:40.912978360 -0400
+++ linux-cg/arch/ppc64/kernel/bpa_iommu.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,65 +0,0 @@
-#ifndef BPA_IOMMU_H
-#define BPA_IOMMU_H
-
-/* some constants */
-enum {
-	/* segment table entries */
-	IOST_VALID_MASK	  = 0x8000000000000000ul,
-	IOST_TAG_MASK     = 0x3000000000000000ul,
-	IOST_PT_BASE_MASK = 0x000003fffffff000ul,
-	IOST_NNPT_MASK	  = 0x0000000000000fe0ul,
-	IOST_PS_MASK	  = 0x000000000000000ful,
-
-	IOST_PS_4K	  = 0x1,
-	IOST_PS_64K	  = 0x3,
-	IOST_PS_1M	  = 0x5,
-	IOST_PS_16M	  = 0x7,
-
-	/* iopt tag register */
-	IOPT_VALID_MASK   = 0x0000000200000000ul,
-	IOPT_TAG_MASK	  = 0x00000001fffffffful,
-
-	/* iopt cache register */
-	IOPT_PROT_MASK	  = 0xc000000000000000ul,
-	IOPT_PROT_NONE	  = 0x0000000000000000ul,
-	IOPT_PROT_READ	  = 0x4000000000000000ul,
-	IOPT_PROT_WRITE	  = 0x8000000000000000ul,
-	IOPT_PROT_RW	  = 0xc000000000000000ul,
-	IOPT_COHERENT	  = 0x2000000000000000ul,
-	
-	IOPT_ORDER_MASK	  = 0x1800000000000000ul,
-	/* order access to same IOID/VC on same address */
-	IOPT_ORDER_ADDR	  = 0x0800000000000000ul,
-	/* similar, but only after a write access */
-	IOPT_ORDER_WRITES = 0x1000000000000000ul,
-	/* Order all accesses to same IOID/VC */
-	IOPT_ORDER_VC	  = 0x1800000000000000ul,
-	
-	IOPT_RPN_MASK	  = 0x000003fffffff000ul,
-	IOPT_HINT_MASK	  = 0x0000000000000800ul,
-	IOPT_IOID_MASK	  = 0x00000000000007fful,
-
-	IOSTO_ENABLE	  = 0x8000000000000000ul,
-	IOSTO_ORIGIN	  = 0x000003fffffff000ul,
-	IOSTO_HW	  = 0x0000000000000800ul,
-	IOSTO_SW	  = 0x0000000000000400ul,
-
-	IOCMD_CONF_TE	  = 0x0000800000000000ul,
-
-	/* memory mapped registers */
-	IOC_PT_CACHE_DIR  = 0x000,
-	IOC_ST_CACHE_DIR  = 0x800,
-	IOC_PT_CACHE_REG  = 0x910,
-	IOC_ST_ORIGIN     = 0x918,
-	IOC_CONF	  = 0x930,
-
-	/* The high bit needs to be set on every DMA address,
-	   only 2GB are addressable */
-	BPA_DMA_VALID	  = 0x80000000,
-	BPA_DMA_MASK	  = 0x7fffffff,
-};
-
-
-void bpa_init_iommu(void);
-
-#endif
--- linux-cg.orig/arch/ppc64/kernel/bpa_nvram.c	2005-09-01 02:37:40.914978056 -0400
+++ linux-cg/arch/ppc64/kernel/bpa_nvram.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,118 +0,0 @@
-/*
- * NVRAM for CPBW
- *
- * (C) Copyright IBM Corp. 2005
- *
- * Authors : Utz Bacher <utz.bacher@de.ibm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2, or (at your option)
- * any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/fs.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/spinlock.h>
-#include <linux/types.h>
-
-#include <asm/machdep.h>
-#include <asm/nvram.h>
-#include <asm/prom.h>
-
-static void __iomem *bpa_nvram_start;
-static long bpa_nvram_len;
-static spinlock_t bpa_nvram_lock = SPIN_LOCK_UNLOCKED;
-
-static ssize_t bpa_nvram_read(char *buf, size_t count, loff_t *index)
-{
-	unsigned long flags;
-
-	if (*index >= bpa_nvram_len)
-		return 0;
-	if (*index + count > bpa_nvram_len)
-		count = bpa_nvram_len - *index;
-
-	spin_lock_irqsave(&bpa_nvram_lock, flags);
-
-	memcpy_fromio(buf, bpa_nvram_start + *index, count);
-
-	spin_unlock_irqrestore(&bpa_nvram_lock, flags);
-	
-	*index += count;
-	return count;
-}
-
-static ssize_t bpa_nvram_write(char *buf, size_t count, loff_t *index)
-{
-	unsigned long flags;
-
-	if (*index >= bpa_nvram_len)
-		return 0;
-	if (*index + count > bpa_nvram_len)
-		count = bpa_nvram_len - *index;
-
-	spin_lock_irqsave(&bpa_nvram_lock, flags);
-
-	memcpy_toio(bpa_nvram_start + *index, buf, count);
-
-	spin_unlock_irqrestore(&bpa_nvram_lock, flags);
-	
-	*index += count;
-	return count;
-}
-
-static ssize_t bpa_nvram_get_size(void)
-{
-	return bpa_nvram_len;
-}
-
-int __init bpa_nvram_init(void)
-{
-	struct device_node *nvram_node;
-	unsigned long *buffer;
-	int proplen;
-	unsigned long nvram_addr;
-	int ret;
-
-	ret = -ENODEV;
-	nvram_node = of_find_node_by_type(NULL, "nvram");
-	if (!nvram_node)
-		goto out;
-
-	ret = -EIO;
-	buffer = (unsigned long *)get_property(nvram_node, "reg", &proplen);
-	if (proplen != 2*sizeof(unsigned long))
-		goto out;
-
-	ret = -ENODEV;
-	nvram_addr = buffer[0];
-	bpa_nvram_len = buffer[1];
-	if ( (!bpa_nvram_len) || (!nvram_addr) )
-		goto out;
-
-	bpa_nvram_start = ioremap(nvram_addr, bpa_nvram_len);
-	if (!bpa_nvram_start)
-		goto out;
-
-	printk(KERN_INFO "BPA NVRAM, %luk mapped to %p\n",
-	       bpa_nvram_len >> 10, bpa_nvram_start);
-
-	ppc_md.nvram_read	= bpa_nvram_read;
-	ppc_md.nvram_write	= bpa_nvram_write;
-	ppc_md.nvram_size	= bpa_nvram_get_size;
-
-out:
-	of_node_put(nvram_node);
-	return ret;
-}
--- linux-cg.orig/arch/ppc64/kernel/bpa_setup.c	2005-09-01 02:37:40.917977600 -0400
+++ linux-cg/arch/ppc64/kernel/bpa_setup.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,140 +0,0 @@
-/*
- *  linux/arch/ppc/kernel/bpa_setup.c
- *
- *  Copyright (C) 1995  Linus Torvalds
- *  Adapted from 'alpha' version by Gary Thomas
- *  Modified by Cort Dougan (cort@cs.nmt.edu)
- *  Modified by PPC64 Team, IBM Corp
- *  Modified by BPA Team, IBM Deutschland Entwicklung GmbH
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-#undef DEBUG
-
-#include <linux/config.h>
-#include <linux/sched.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/stddef.h>
-#include <linux/unistd.h>
-#include <linux/slab.h>
-#include <linux/user.h>
-#include <linux/reboot.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/irq.h>
-#include <linux/seq_file.h>
-#include <linux/root_dev.h>
-#include <linux/console.h>
-
-#include <asm/mmu.h>
-#include <asm/processor.h>
-#include <asm/io.h>
-#include <asm/pgtable.h>
-#include <asm/prom.h>
-#include <asm/rtas.h>
-#include <asm/pci-bridge.h>
-#include <asm/iommu.h>
-#include <asm/dma.h>
-#include <asm/machdep.h>
-#include <asm/time.h>
-#include <asm/nvram.h>
-#include <asm/cputable.h>
-
-#include "pci.h"
-#include "bpa_iic.h"
-#include "bpa_iommu.h"
-
-#ifdef DEBUG
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
-void bpa_get_cpuinfo(struct seq_file *m)
-{
-	struct device_node *root;
-	const char *model = "";
-
-	root = of_find_node_by_path("/");
-	if (root)
-		model = get_property(root, "model", NULL);
-	seq_printf(m, "machine\t\t: BPA %s\n", model);
-	of_node_put(root);
-}
-
-static void bpa_progress(char *s, unsigned short hex)
-{
-	printk("*** %04x : %s\n", hex, s ? s : "");
-}
-
-static void __init bpa_setup_arch(void)
-{
-	ppc_md.init_IRQ       = iic_init_IRQ;
-	ppc_md.get_irq        = iic_get_irq;
-
-#ifdef CONFIG_SMP
-	smp_init_pSeries();
-#endif
-
-	/* init to some ~sane value until calibrate_delay() runs */
-	loops_per_jiffy = 50000000;
-
-	if (ROOT_DEV == 0) {
-		printk("No ramdisk, default root is /dev/hda2\n");
-		ROOT_DEV = Root_HDA2;
-	}
-
-	/* Find and initialize PCI host bridges */
-	init_pci_config_tokens();
-	find_and_init_phbs();
-	spider_init_IRQ();
-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
-
-	bpa_nvram_init();
-}
-
-/*
- * Early initialization.  Relocation is on but do not reference unbolted pages
- */
-static void __init bpa_init_early(void)
-{
-	DBG(" -> bpa_init_early()\n");
-
-	hpte_init_native();
-
-	bpa_init_iommu();
-
-	ppc64_interrupt_controller = IC_BPA_IIC;
-
-	DBG(" <- bpa_init_early()\n");
-}
-
-
-static int __init bpa_probe(int platform)
-{
-	if (platform != PLATFORM_BPA)
-		return 0;
-
-	return 1;
-}
-
-struct machdep_calls __initdata bpa_md = {
-	.probe			= bpa_probe,
-	.setup_arch		= bpa_setup_arch,
-	.init_early		= bpa_init_early,
-	.get_cpuinfo		= bpa_get_cpuinfo,
-	.restart		= rtas_restart,
-	.power_off		= rtas_power_off,
-	.halt			= rtas_halt,
-	.get_boot_time		= rtas_get_boot_time,
-	.get_rtc_time		= rtas_get_rtc_time,
-	.set_rtc_time		= rtas_set_rtc_time,
-	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= bpa_progress,
-};
--- linux-cg.orig/arch/ppc64/kernel/cpu_setup_power4.S	2005-09-01 02:37:44.101892936 -0400
+++ linux-cg/arch/ppc64/kernel/cpu_setup_power4.S	2005-09-01 02:37:49.128927440 -0400
@@ -77,7 +77,7 @@ _GLOBAL(__970_cpu_preinit)
 _GLOBAL(__setup_cpu_power4)
 	blr
 
-_GLOBAL(__setup_cpu_be)
+_GLOBAL(__setup_cpu_cbe)
         /* Set large page sizes LP=0: 16MB, LP=1: 64KB */
         addi    r3, 0,  0
         ori     r3, r3, HID6_LB
--- linux-cg.orig/arch/ppc64/kernel/cputable.c	2005-09-01 02:37:40.919977296 -0400
+++ linux-cg/arch/ppc64/kernel/cputable.c	2005-09-01 02:37:46.088990216 -0400
@@ -34,7 +34,7 @@ EXPORT_SYMBOL(cur_cpu_spec);
 extern void __setup_cpu_power3(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_power4(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_ppc970(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_be(unsigned long offset, struct cpu_spec* spec);
+extern void __setup_cpu_cbe(unsigned long offset, struct cpu_spec* spec);
 
 
 /* We only set the altivec features if the kernel was compiled with altivec
@@ -218,7 +218,7 @@ struct cpu_spec	cpu_specs[] = {
 	{	/* BE DD1.x */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x00700000,
-		.cpu_name		= "Broadband Engine",
+		.cpu_name		= "Cell Broadband Engine",
 		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
 			CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE |
 			CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_ALTIVEC_COMP |
@@ -227,7 +227,7 @@ struct cpu_spec	cpu_specs[] = {
 			PPC_FEATURE_HAS_ALTIVEC_COMP,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
-		.cpu_setup		= __setup_cpu_be,
+		.cpu_setup		= __setup_cpu_cbe,
 	},
 	{	/* default match */
 		.pvr_mask		= 0x00000000,
--- linux-cg.orig/arch/ppc64/kernel/irq.c	2005-09-01 02:37:40.921976992 -0400
+++ linux-cg/arch/ppc64/kernel/irq.c	2005-09-01 02:37:46.089990064 -0400
@@ -392,7 +392,7 @@ int virt_irq_create_mapping(unsigned int
 	if (ppc64_interrupt_controller == IC_OPEN_PIC)
 		return real_irq;	/* no mapping for openpic (for now) */
 
-	if (ppc64_interrupt_controller == IC_BPA_IIC)
+	if (ppc64_interrupt_controller == IC_CELL_PIC)
 		return real_irq;	/* no mapping for iic either */
 
 	/* don't map interrupts < MIN_VIRT_IRQ */
--- linux-cg.orig/arch/ppc64/kernel/pSeries_smp.c	2005-09-01 02:37:40.924976536 -0400
+++ linux-cg/arch/ppc64/kernel/pSeries_smp.c	2005-09-01 02:37:46.089990064 -0400
@@ -40,6 +40,7 @@
 #include <asm/time.h>
 #include <asm/machdep.h>
 #include <asm/xics.h>
+#include <asm/cell-pic.h>
 #include <asm/cputable.h>
 #include <asm/firmware.h>
 #include <asm/system.h>
@@ -48,7 +49,6 @@
 #include <asm/pSeries_reconfig.h>
 
 #include "mpic.h"
-#include "bpa_iic.h"
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -464,7 +464,7 @@ void __init smp_init_pSeries(void)
 		break;
 #endif
 #ifdef CONFIG_BPA_IIC
-	case IC_BPA_IIC:
+	case IC_CELL_PIC:
 		smp_ops = &bpa_iic_smp_ops;
 		break;
 #endif
--- linux-cg.orig/arch/ppc64/kernel/setup.c	2005-09-01 02:37:40.926976232 -0400
+++ linux-cg/arch/ppc64/kernel/setup.c	2005-09-01 02:37:46.091989760 -0400
@@ -343,7 +343,7 @@ static void __init setup_cpu_maps(void)
 extern struct machdep_calls pSeries_md;
 extern struct machdep_calls pmac_md;
 extern struct machdep_calls maple_md;
-extern struct machdep_calls bpa_md;
+extern struct machdep_calls cell_md;
 
 /* Ultimately, stuff them in an elf section like initcalls... */
 static struct machdep_calls __initdata *machines[] = {
@@ -356,9 +356,9 @@ static struct machdep_calls __initdata *
 #ifdef CONFIG_PPC_MAPLE
 	&maple_md,
 #endif /* CONFIG_PPC_MAPLE */
-#ifdef CONFIG_PPC_BPA
-	&bpa_md,
-#endif
+#ifdef CONFIG_PPC_CELL
+	&cell_md,
+#endif /* CONFIG_PPC_CELL */
 	NULL
 };
 
--- linux-cg.orig/arch/ppc64/kernel/spider-pic.c	2005-09-01 02:37:40.928975928 -0400
+++ linux-cg/arch/ppc64/kernel/spider-pic.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,191 +0,0 @@
-/*
- * External Interrupt Controller on Spider South Bridge
- *
- * (C) Copyright IBM Deutschland Entwicklung GmbH 2005
- *
- * Author: Arnd Bergmann <arndb@de.ibm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2, or (at your option)
- * any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-
-#include <asm/pgtable.h>
-#include <asm/prom.h>
-#include <asm/io.h>
-
-#include "bpa_iic.h"
-
-/* register layout taken from Spider spec, table 7.4-4 */
-enum {
-	TIR_DEN		= 0x004, /* Detection Enable Register */
-	TIR_MSK		= 0x084, /* Mask Level Register */
-	TIR_EDC		= 0x0c0, /* Edge Detection Clear Register */
-	TIR_PNDA	= 0x100, /* Pending Register A */
-	TIR_PNDB	= 0x104, /* Pending Register B */
-	TIR_CS		= 0x144, /* Current Status Register */
-	TIR_LCSA	= 0x150, /* Level Current Status Register A */
-	TIR_LCSB	= 0x154, /* Level Current Status Register B */
-	TIR_LCSC	= 0x158, /* Level Current Status Register C */
-	TIR_LCSD	= 0x15c, /* Level Current Status Register D */
-	TIR_CFGA	= 0x200, /* Setting Register A0 */
-	TIR_CFGB	= 0x204, /* Setting Register B0 */
-			/* 0x208 ... 0x3ff Setting Register An/Bn */
-	TIR_PPNDA	= 0x400, /* Packet Pending Register A */
-	TIR_PPNDB	= 0x404, /* Packet Pending Register B */
-	TIR_PIERA	= 0x408, /* Packet Output Error Register A */
-	TIR_PIERB	= 0x40c, /* Packet Output Error Register B */
-	TIR_PIEN	= 0x444, /* Packet Output Enable Register */
-	TIR_PIPND	= 0x454, /* Packet Output Pending Register */
-	TIRDID		= 0x484, /* Spider Device ID Register */
-	REISTIM		= 0x500, /* Reissue Command Timeout Time Setting */
-	REISTIMEN	= 0x504, /* Reissue Command Timeout Setting */
-	REISWAITEN	= 0x508, /* Reissue Wait Control*/
-};
-
-static void __iomem *spider_pics[4];
-
-static void __iomem *spider_get_pic(int irq)
-{
-	int node = irq / IIC_NODE_STRIDE;
-	irq %= IIC_NODE_STRIDE;
-
-	if (irq >= IIC_EXT_OFFSET &&
-	    irq < IIC_EXT_OFFSET + IIC_NUM_EXT &&
-	    spider_pics)
-		return spider_pics[node];
-	return NULL;
-}
-
-static int spider_get_nr(unsigned int irq)
-{
-	return (irq % IIC_NODE_STRIDE) - IIC_EXT_OFFSET;
-}
-
-static void __iomem *spider_get_irq_config(int irq)
-{
-	void __iomem *pic;
-	pic = spider_get_pic(irq);
-	return pic + TIR_CFGA + 8 * spider_get_nr(irq);
-}
-
-static void spider_enable_irq(unsigned int irq)
-{
-	void __iomem *cfg = spider_get_irq_config(irq);
-	irq = spider_get_nr(irq);
-
-	out_be32(cfg, in_be32(cfg) | 0x3107000eu);
-	out_be32(cfg + 4, in_be32(cfg + 4) | 0x00020000u | irq);
-}
-
-static void spider_disable_irq(unsigned int irq)
-{
-	void __iomem *cfg = spider_get_irq_config(irq);
-	irq = spider_get_nr(irq);
-
-	out_be32(cfg, in_be32(cfg) & ~0x30000000u);
-}
-
-static unsigned int spider_startup_irq(unsigned int irq)
-{
-	spider_enable_irq(irq);
-	return 0;
-}
-
-static void spider_shutdown_irq(unsigned int irq)
-{
-	spider_disable_irq(irq);
-}
-
-static void spider_end_irq(unsigned int irq)
-{
-	spider_enable_irq(irq);
-}
-
-static void spider_ack_irq(unsigned int irq)
-{
-	spider_disable_irq(irq);
-	iic_local_enable();
-}
-
-static struct hw_interrupt_type spider_pic = {
-	.typename = " SPIDER   ",
-	.startup = spider_startup_irq,
-	.shutdown = spider_shutdown_irq,
-	.enable = spider_enable_irq,
-	.disable = spider_disable_irq,
-	.ack = spider_ack_irq,
-	.end = spider_end_irq,
-};
-
-
-int spider_get_irq(unsigned long int_pending)
-{
-	void __iomem *regs = spider_get_pic(int_pending);
-	unsigned long cs;
-	int irq;
-
-	cs = in_be32(regs + TIR_CS);
-
-	irq = cs >> 24;
-	if (irq != 63)
-		return irq;
-
-	return -1;
-}
- 
-void spider_init_IRQ(void)
-{
-	int node;
-	struct device_node *dn;
-	unsigned int *property;
-	long spiderpic;
-	int n;
-
-/* FIXME: detect multiple PICs as soon as the device tree has them */
-	for (node = 0; node < 1; node++) {
-		dn = of_find_node_by_path("/");
-		n = prom_n_addr_cells(dn);
-		property = (unsigned int *) get_property(dn,
-				"platform-spider-pic", NULL);
-
-		if (!property)
-			continue;
-		for (spiderpic = 0; n > 0; --n)
-			spiderpic = (spiderpic << 32) + *property++;
-		printk(KERN_DEBUG "SPIDER addr: %lx\n", spiderpic);
-		spider_pics[node] = __ioremap(spiderpic, 0x800, _PAGE_NO_CACHE);
-		for (n = 0; n < IIC_NUM_EXT; n++) {
-			int irq = n + IIC_EXT_OFFSET + node * IIC_NODE_STRIDE;
-			get_irq_desc(irq)->handler = &spider_pic;
-
- 		/* do not mask any interrupts because of level */
- 		out_be32(spider_pics[node] + TIR_MSK, 0x0);
- 		
- 		/* disable edge detection clear */
- 		/* out_be32(spider_pics[node] + TIR_EDC, 0x0); */
- 		
- 		/* enable interrupt packets to be output */
- 		out_be32(spider_pics[node] + TIR_PIEN,
-			in_be32(spider_pics[node] + TIR_PIEN) | 0x1);
- 		
- 		/* Enable the interrupt detection enable bit. Do this last! */
- 		out_be32(spider_pics[node] + TIR_DEN,
-			in_be32(spider_pics[node] +TIR_DEN) | 0x1);
-
-		}
-	}
-}
--- linux-cg.orig/arch/ppc64/kernel/traps.c	2005-09-01 02:37:40.931975472 -0400
+++ linux-cg/arch/ppc64/kernel/traps.c	2005-09-01 02:37:46.093989456 -0400
@@ -126,8 +126,8 @@ int die(const char *str, struct pt_regs 
 			printk("POWERMAC ");
 			nl = 1;
 			break;
-		case PLATFORM_BPA:
-			printk("BPA ");
+		case PLATFORM_CELL:
+			printk("CBEA ");
 			nl = 1;
 			break;
 	}
--- linux-cg.orig/include/asm-powerpc/cell-pic.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/include/asm-powerpc/cell-pic.h	2005-09-01 02:37:46.093989456 -0400
@@ -0,0 +1,62 @@
+#ifndef __ASM_CELL_PIC_H
+#define __ASM_CELL_PIC_H
+#ifdef __KERNEL__
+/*
+ * Mapping of IIC pending bits into per-node
+ * interrupt numbers.
+ *
+ * IRQ     FF CC SS PP   FF CC SS PP	Description
+ *
+ * 00-3f   80 02 +0 00 - 80 02 +0 3f	South Bridge
+ * 00-3f   80 02 +b 00 - 80 02 +b 3f	South Bridge
+ * 41-4a   80 00 +1 ** - 80 00 +a **	SPU Class 0
+ * 51-5a   80 01 +1 ** - 80 01 +a **	SPU Class 1
+ * 61-6a   80 02 +1 ** - 80 02 +a **	SPU Class 2
+ * 70-7f   C0 ** ** 00 - C0 ** ** 0f	IPI
+ *
+ *    F flags
+ *    C class
+ *    S source
+ *    P Priority
+ *    + node number
+ *    * don't care
+ *
+ * A node consists of a Cell Processor and an optional
+ * south bridge device providing a maximum of 64 IRQs.
+ * The south bridge may be connected to either IOIF0
+ * or IOIF1.
+ * Each SPE is represented as three IRQ lines, one per
+ * interrupt class.
+ * 16 IRQ numbers are reserved for inter processor
+ * interruptions, although these are only used in the
+ * range of the first node.
+ *
+ * This scheme needs 128 IRQ numbers per BIF node ID,
+ * which means that with the total of 512 lines
+ * available, we can have a maximum of four nodes.
+ */
+
+enum {
+	IIC_EXT_OFFSET   = 0x00, /* Start of south bridge IRQs */
+	IIC_NUM_EXT      = 0x40, /* Number of south bridge IRQs */
+	IIC_SPE_OFFSET   = 0x40, /* Start of SPE interrupts */
+	IIC_CLASS_STRIDE = 0x10, /* SPE IRQs per class    */
+	IIC_IPI_OFFSET   = 0x70, /* Start of IPI IRQs */
+	IIC_NUM_IPIS     = 0x10, /* IRQs reserved for IPI */
+	IIC_NODE_STRIDE  = 0x80, /* Total IRQs per node   */
+};
+
+extern void iic_init_IRQ(void);
+extern int  iic_get_irq(struct pt_regs *regs);
+extern void iic_cause_IPI(int cpu, int mesg);
+extern void iic_request_IPIs(void);
+extern void iic_setup_cpu(void);
+extern void iic_local_enable(void);
+extern void iic_local_disable(void);
+
+
+extern void spider_init_IRQ(void);
+extern int spider_get_irq(unsigned long int_pending);
+
+#endif /* __KERNEL__ */
+#endif /* __ASM_CELL_PIC_H */
--- linux-cg.orig/include/asm-ppc64/nvram.h	2005-09-01 02:37:40.935974864 -0400
+++ linux-cg/include/asm-ppc64/nvram.h	2005-09-01 02:37:46.094989304 -0400
@@ -70,7 +70,7 @@ extern struct nvram_partition *nvram_fin
 
 extern int pSeries_nvram_init(void);
 extern int pmac_nvram_init(void);
-extern int bpa_nvram_init(void);
+extern int cell_nvram_init(void);
 
 /* PowerMac specific nvram stuffs */
 
--- linux-cg.orig/include/asm-ppc64/processor.h	2005-09-01 02:37:40.938974408 -0400
+++ linux-cg/include/asm-ppc64/processor.h	2005-09-01 02:37:46.095989152 -0400
@@ -269,7 +269,7 @@
 #define	PV_630        	0x0040
 #define	PV_630p	        0x0041
 #define	PV_970MP	0x0044
-#define	PV_BE		0x0070
+#define	PV_CBE		0x0070
 
 /* Platforms supported by PPC64 */
 #define PLATFORM_PSERIES      0x0100
@@ -278,7 +278,8 @@
 #define PLATFORM_LPAR         0x0001
 #define PLATFORM_POWERMAC     0x0400
 #define PLATFORM_MAPLE        0x0500
-#define PLATFORM_BPA          0x1000
+#define PLATFORM_CELL         0x1000
+#define PLATFORM_BPA          PLATFORM_CELL
 
 /* Compatibility with drivers coming from PPC32 world */
 #define _machine	(systemcfg->platform)
@@ -290,7 +291,7 @@
 #define IC_INVALID    0
 #define IC_OPEN_PIC   1
 #define IC_PPC_XIC    2
-#define IC_BPA_IIC    3
+#define IC_CELL_PIC   3
 
 #define XGLUE(a,b) a##b
 #define GLUE(a,b) XGLUE(a,b)
