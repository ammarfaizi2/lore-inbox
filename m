Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbVFUWEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbVFUWEP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 18:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbVFUWCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 18:02:52 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:12798 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262556AbVFUVja
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 17:39:30 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 9/11] ppc64: Add driver for BPA iommu
Date: Tue, 21 Jun 2005 23:28:28 +0200
User-Agent: KMail/1.7.2
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
References: <200506212310.54156.arnd@arndb.de> <200506212324.19713.arnd@arndb.de> <200506212326.18205.arnd@arndb.de>
In-Reply-To: <200506212326.18205.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506212328.28929.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implementation of software load support for the BE iommu. This is very
different from other iommu code on ppc64, since we only do a static mapping.
The mapping is currently hardcoded but should really be read from the
firmware, but they don't set up the device nodes yet. There is a single
512MB DMA window for PCI, USB and ethernet at 0x20000000 for our RAM.

The Cell processor can put the I/O page table either in memory like
the hashed page table (hardware load) or have the operating system
write the entries into memory mapped CPU registers (software load).

I use the software load mechanism because I know that all I/O page
table entries for the amount of installed physical memory fit into
the IO TLB cache. At the point when we get machines with more than
4GB of installed memory, we can either use hardware I/O page table
access like the other platforms do or dynamically update the I/O
TLB entries when a page fault occurs in the I/O subsystem.

The software load can then use the macros that I have implemented
for the static mapping in order to do the TLB cache updates.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

--

 Makefile    |    3
 bpa_iommu.c |  377 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 bpa_iommu.h |   65 ++++++++++
 bpa_setup.c |    3
 4 files changed, 446 insertions(+), 2 deletions(-)

Index: linus-2.5/arch/ppc64/kernel/Makefile
===================================================================
--- linus-2.5.orig/arch/ppc64/kernel/Makefile	2005-04-22 07:01:07.000000000 +0200
+++ linus-2.5/arch/ppc64/kernel/Makefile	2005-04-29 10:01:44.000000000 +0200
@@ -34,7 +34,8 @@
 			     pSeries_nvram.o rtasd.o ras.o pSeries_reconfig.o \
 			     pSeries_setup.o pSeries_iommu.o
 
-obj-$(CONFIG_PPC_BPA) += bpa_setup.o bpa_nvram.o bpa_iic.o spider-pic.o
+obj-$(CONFIG_PPC_BPA) += bpa_setup.o bpa_iommu.o bpa_nvram.o \
+			 bpa_iic.o spider-pic.o
 
 obj-$(CONFIG_EEH)		+= eeh.o
 obj-$(CONFIG_PROC_FS)		+= proc_ppc64.o
Index: linus-2.5/arch/ppc64/kernel/bpa_iommu.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linus-2.5/arch/ppc64/kernel/bpa_iommu.c	2005-04-29 10:24:03.000000000 +0200
@@ -0,0 +1,377 @@
+/*
+ * IOMMU implementation for Broadband Processor Architecture
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
+#include "pci.h"
+#include "bpa_iommu.h"
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
+static void bpa_map_iommu(void)
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
+static void *bpa_alloc_coherent(struct device *hwdev, size_t size,
+			   dma_addr_t *dma_handle, unsigned int __nocast flag)
+{
+	void *ret;
+
+	ret = (void *)__get_free_pages(flag, get_order(size));
+	if (ret != NULL) {
+		memset(ret, 0, size);
+		*dma_handle = virt_to_abs(ret) | BPA_DMA_VALID;
+	}
+	return ret;
+}
+
+static void bpa_free_coherent(struct device *hwdev, size_t size,
+				 void *vaddr, dma_addr_t dma_handle)
+{
+	free_pages((unsigned long)vaddr, get_order(size));
+}
+
+static dma_addr_t bpa_map_single(struct device *hwdev, void *ptr,
+		size_t size, enum dma_data_direction direction)
+{
+	return virt_to_abs(ptr) | BPA_DMA_VALID;
+}
+
+static void bpa_unmap_single(struct device *hwdev, dma_addr_t dma_addr,
+		size_t size, enum dma_data_direction direction)
+{
+}
+
+static int bpa_map_sg(struct device *hwdev, struct scatterlist *sg,
+		int nents, enum dma_data_direction direction)
+{
+	int i;
+
+	for (i = 0; i < nents; i++, sg++) {
+		sg->dma_address = (page_to_phys(sg->page) + sg->offset)
+					| BPA_DMA_VALID;
+		sg->dma_length = sg->length;
+	}
+
+	return nents;
+}
+
+static void bpa_unmap_sg(struct device *hwdev, struct scatterlist *sg,
+		int nents, enum dma_data_direction direction)
+{
+}
+
+static int bpa_dma_supported(struct device *dev, u64 mask)
+{
+	return mask < 0x100000000ull;
+}
+
+void bpa_init_iommu(void)
+{
+	bpa_map_iommu();
+
+	/* Direct I/O, IOMMU off */
+	ppc_md.iommu_dev_setup = iommu_dev_setup_null;
+	ppc_md.iommu_bus_setup = iommu_bus_setup_null;
+
+	pci_dma_ops.alloc_coherent = bpa_alloc_coherent;
+	pci_dma_ops.free_coherent = bpa_free_coherent;
+	pci_dma_ops.map_single = bpa_map_single;
+	pci_dma_ops.unmap_single = bpa_unmap_single;
+	pci_dma_ops.map_sg = bpa_map_sg;
+	pci_dma_ops.unmap_sg = bpa_unmap_sg;
+	pci_dma_ops.dma_supported = bpa_dma_supported;
+}
Index: linus-2.5/arch/ppc64/kernel/bpa_iommu.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linus-2.5/arch/ppc64/kernel/bpa_iommu.h	2005-04-29 09:47:29.000000000 +0200
@@ -0,0 +1,65 @@
+#ifndef BPA_IOMMU_H
+#define BPA_IOMMU_H
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
+	BPA_DMA_VALID	  = 0x80000000,
+	BPA_DMA_MASK	  = 0x7fffffff,
+};
+
+
+void bpa_init_iommu(void);
+
+#endif
Index: linus-2.5/arch/ppc64/kernel/bpa_setup.c
===================================================================
--- linus-2.5.orig/arch/ppc64/kernel/bpa_setup.c	2005-04-22 06:59:58.000000000 +0200
+++ linus-2.5/arch/ppc64/kernel/bpa_setup.c	2005-04-29 10:01:12.000000000 +0200
@@ -46,6 +46,7 @@
 
 #include "pci.h"
 #include "bpa_iic.h"
+#include "bpa_iommu.h"
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -179,7 +180,7 @@
 
 	hpte_init_native();
 
-	pci_direct_iommu_init();
+	bpa_init_iommu();
 
 	ppc64_interrupt_controller = IC_BPA_IIC;
 

