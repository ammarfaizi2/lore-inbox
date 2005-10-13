Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbVJMAzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbVJMAzx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 20:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbVJMAzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 20:55:53 -0400
Received: from silver.veritas.com ([143.127.12.111]:30869 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932483AbVJMAzw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 20:55:52 -0400
Date: Thu, 13 Oct 2005 01:55:06 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/21] mm: init_mm without ptlock
In-Reply-To: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0510130153440.4060@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Oct 2005 00:55:51.0774 (UTC) FILETIME=[DBAD5FE0:01C5CF90]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First step in pushing down the page_table_lock.  init_mm.page_table_lock
has been used throughout the architectures (usually for ioremap): not to
serialize kernel address space allocation (that's usually vmlist_lock),
but because pud_alloc,pmd_alloc,pte_alloc_kernel expect caller holds it.

Reverse that: don't lock or unlock init_mm.page_table_lock in any of the
architectures; instead rely on pud_alloc,pmd_alloc,pte_alloc_kernel to
take and drop it when allocating a new one, to check lest a racing task
already did.  Similarly no page_table_lock in vmalloc's map_vm_area.

Some temporary ugliness in __pud_alloc and __pmd_alloc: since they also
handle user mms, which are converted only by a later patch, for now they
have to lock differently according to whether or not it's init_mm.

If sources get muddled, there's a danger that an arch source taking
init_mm.page_table_lock will be mixed with common source also taking it
(or neither take it).  So break the rules and make another change, which
should break the build for such a mismatch: remove the redundant mm arg
from pte_alloc_kernel (ppc64 scrapped its distinct ioremap_mm in 2.6.13).

Exceptions: arm26 used pte_alloc_kernel on user mm, now pte_alloc_map;
ia64 used pte_alloc_map on init_mm, now pte_alloc_kernel; parisc had bad
args to pmd_alloc and pte_alloc_kernel in unused USE_HPPA_IOREMAP code;
ppc64 map_io_page forgot to unlock on failure; ppc mmu_mapin_ram and
ppc64 im_free took page_table_lock for no good reason.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/alpha/mm/remap.c         |    6 ----
 arch/arm/mm/consistent.c      |    6 ----
 arch/arm/mm/ioremap.c         |    4 --
 arch/arm26/mm/memc.c          |    3 +-
 arch/cris/mm/ioremap.c        |    4 --
 arch/frv/mm/dma-alloc.c       |    5 ---
 arch/i386/mm/ioremap.c        |    4 --
 arch/ia64/mm/init.c           |   11 ++-----
 arch/m32r/mm/ioremap.c        |    4 --
 arch/m68k/mm/kmap.c           |    2 -
 arch/m68k/sun3x/dvma.c        |    2 -
 arch/mips/mm/ioremap.c        |    4 --
 arch/parisc/kernel/pci-dma.c  |    2 -
 arch/parisc/mm/ioremap.c      |    6 +---
 arch/ppc/kernel/dma-mapping.c |    6 ----
 arch/ppc/mm/4xx_mmu.c         |    4 --
 arch/ppc/mm/pgtable.c         |    4 --
 arch/ppc64/mm/imalloc.c       |    5 ---
 arch/ppc64/mm/init.c          |    4 --
 arch/s390/mm/ioremap.c        |    4 --
 arch/sh/mm/ioremap.c          |    4 --
 arch/sh64/mm/ioremap.c        |    4 --
 arch/x86_64/mm/ioremap.c      |    4 --
 include/linux/mm.h            |    2 -
 mm/memory.c                   |   60 ++++++++++++++++++------------------------
 mm/vmalloc.c                  |    4 --
 26 files changed, 54 insertions(+), 114 deletions(-)

--- mm08/arch/alpha/mm/remap.c	2003-01-17 01:23:07.000000000 +0000
+++ mm09/arch/alpha/mm/remap.c	2005-10-11 23:55:53.000000000 +0100
@@ -2,7 +2,6 @@
 #include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
 
-/* called with the page_table_lock held */
 static inline void 
 remap_area_pte(pte_t * pte, unsigned long address, unsigned long size, 
 	       unsigned long phys_addr, unsigned long flags)
@@ -31,7 +30,6 @@ remap_area_pte(pte_t * pte, unsigned lon
 	} while (address && (address < end));
 }
 
-/* called with the page_table_lock held */
 static inline int 
 remap_area_pmd(pmd_t * pmd, unsigned long address, unsigned long size, 
 	       unsigned long phys_addr, unsigned long flags)
@@ -46,7 +44,7 @@ remap_area_pmd(pmd_t * pmd, unsigned lon
 	if (address >= end)
 		BUG();
 	do {
-		pte_t * pte = pte_alloc_kernel(&init_mm, pmd, address);
+		pte_t * pte = pte_alloc_kernel(pmd, address);
 		if (!pte)
 			return -ENOMEM;
 		remap_area_pte(pte, address, end - address, 
@@ -70,7 +68,6 @@ __alpha_remap_area_pages(unsigned long a
 	flush_cache_all();
 	if (address >= end)
 		BUG();
-	spin_lock(&init_mm.page_table_lock);
 	do {
 		pmd_t *pmd;
 		pmd = pmd_alloc(&init_mm, dir, address);
@@ -84,7 +81,6 @@ __alpha_remap_area_pages(unsigned long a
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (address && (address < end));
-	spin_unlock(&init_mm.page_table_lock);
 	return error;
 }
 
--- mm08/arch/arm/mm/consistent.c	2005-06-17 20:48:29.000000000 +0100
+++ mm09/arch/arm/mm/consistent.c	2005-10-11 23:55:53.000000000 +0100
@@ -397,8 +397,6 @@ static int __init consistent_init(void)
 	pte_t *pte;
 	int ret = 0;
 
-	spin_lock(&init_mm.page_table_lock);
-
 	do {
 		pgd = pgd_offset(&init_mm, CONSISTENT_BASE);
 		pmd = pmd_alloc(&init_mm, pgd, CONSISTENT_BASE);
@@ -409,7 +407,7 @@ static int __init consistent_init(void)
 		}
 		WARN_ON(!pmd_none(*pmd));
 
-		pte = pte_alloc_kernel(&init_mm, pmd, CONSISTENT_BASE);
+		pte = pte_alloc_kernel(pmd, CONSISTENT_BASE);
 		if (!pte) {
 			printk(KERN_ERR "%s: no pte tables\n", __func__);
 			ret = -ENOMEM;
@@ -419,8 +417,6 @@ static int __init consistent_init(void)
 		consistent_pte = pte;
 	} while (0);
 
-	spin_unlock(&init_mm.page_table_lock);
-
 	return ret;
 }
 
--- mm08/arch/arm/mm/ioremap.c	2005-08-29 00:41:01.000000000 +0100
+++ mm09/arch/arm/mm/ioremap.c	2005-10-11 23:55:53.000000000 +0100
@@ -74,7 +74,7 @@ remap_area_pmd(pmd_t * pmd, unsigned lon
 
 	pgprot = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY | L_PTE_WRITE | flags);
 	do {
-		pte_t * pte = pte_alloc_kernel(&init_mm, pmd, address);
+		pte_t * pte = pte_alloc_kernel(pmd, address);
 		if (!pte)
 			return -ENOMEM;
 		remap_area_pte(pte, address, end - address, address + phys_addr, pgprot);
@@ -96,7 +96,6 @@ remap_area_pages(unsigned long start, un
 	phys_addr -= address;
 	dir = pgd_offset(&init_mm, address);
 	BUG_ON(address >= end);
-	spin_lock(&init_mm.page_table_lock);
 	do {
 		pmd_t *pmd = pmd_alloc(&init_mm, dir, address);
 		if (!pmd) {
@@ -113,7 +112,6 @@ remap_area_pages(unsigned long start, un
 		dir++;
 	} while (address && (address < end));
 
-	spin_unlock(&init_mm.page_table_lock);
 	flush_cache_vmap(start, end);
 	return err;
 }
--- mm08/arch/arm26/mm/memc.c	2005-03-02 07:39:17.000000000 +0000
+++ mm09/arch/arm26/mm/memc.c	2005-10-11 23:55:53.000000000 +0100
@@ -92,7 +92,7 @@ pgd_t *get_pgd_slow(struct mm_struct *mm
 	if (!new_pmd)
 		goto no_pmd;
 
-	new_pte = pte_alloc_kernel(mm, new_pmd, 0);
+	new_pte = pte_alloc_map(mm, new_pmd, 0);
 	if (!new_pte)
 		goto no_pte;
 
@@ -101,6 +101,7 @@ pgd_t *get_pgd_slow(struct mm_struct *mm
 	init_pte = pte_offset(init_pmd, 0);
 
 	set_pte(new_pte, *init_pte);
+	pte_unmap(new_pte);
 
 	/*
 	 * the page table entries are zeroed
--- mm08/arch/cris/mm/ioremap.c	2005-08-29 00:41:01.000000000 +0100
+++ mm09/arch/cris/mm/ioremap.c	2005-10-11 23:55:53.000000000 +0100
@@ -52,7 +52,7 @@ static inline int remap_area_pmd(pmd_t *
 	if (address >= end)
 		BUG();
 	do {
-		pte_t * pte = pte_alloc_kernel(&init_mm, pmd, address);
+		pte_t * pte = pte_alloc_kernel(pmd, address);
 		if (!pte)
 			return -ENOMEM;
 		remap_area_pte(pte, address, end - address, address + phys_addr, prot);
@@ -74,7 +74,6 @@ static int remap_area_pages(unsigned lon
 	flush_cache_all();
 	if (address >= end)
 		BUG();
-	spin_lock(&init_mm.page_table_lock);
 	do {
 		pud_t *pud;
 		pmd_t *pmd;
@@ -94,7 +93,6 @@ static int remap_area_pages(unsigned lon
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (address && (address < end));
-	spin_unlock(&init_mm.page_table_lock);
 	flush_tlb_all();
 	return error;
 }
--- mm08/arch/frv/mm/dma-alloc.c	2005-03-02 07:39:19.000000000 +0000
+++ mm09/arch/frv/mm/dma-alloc.c	2005-10-11 23:55:53.000000000 +0100
@@ -55,21 +55,18 @@ static int map_page(unsigned long va, un
 	pte_t *pte;
 	int err = -ENOMEM;
 
-	spin_lock(&init_mm.page_table_lock);
-
 	/* Use upper 10 bits of VA to index the first level map */
 	pge = pgd_offset_k(va);
 	pue = pud_offset(pge, va);
 	pme = pmd_offset(pue, va);
 
 	/* Use middle 10 bits of VA to index the second-level map */
-	pte = pte_alloc_kernel(&init_mm, pme, va);
+	pte = pte_alloc_kernel(pme, va);
 	if (pte != 0) {
 		err = 0;
 		set_pte(pte, mk_pte_phys(pa & PAGE_MASK, prot));
 	}
 
-	spin_unlock(&init_mm.page_table_lock);
 	return err;
 }
 
--- mm08/arch/i386/mm/ioremap.c	2005-09-30 11:58:53.000000000 +0100
+++ mm09/arch/i386/mm/ioremap.c	2005-10-11 23:55:53.000000000 +0100
@@ -28,7 +28,7 @@ static int ioremap_pte_range(pmd_t *pmd,
 	unsigned long pfn;
 
 	pfn = phys_addr >> PAGE_SHIFT;
-	pte = pte_alloc_kernel(&init_mm, pmd, addr);
+	pte = pte_alloc_kernel(pmd, addr);
 	if (!pte)
 		return -ENOMEM;
 	do {
@@ -87,14 +87,12 @@ static int ioremap_page_range(unsigned l
 	flush_cache_all();
 	phys_addr -= addr;
 	pgd = pgd_offset_k(addr);
-	spin_lock(&init_mm.page_table_lock);
 	do {
 		next = pgd_addr_end(addr, end);
 		err = ioremap_pud_range(pgd, addr, next, phys_addr+addr, flags);
 		if (err)
 			break;
 	} while (pgd++, addr = next, addr != end);
-	spin_unlock(&init_mm.page_table_lock);
 	flush_tlb_all();
 	return err;
 }
--- mm08/arch/ia64/mm/init.c	2005-10-11 23:55:38.000000000 +0100
+++ mm09/arch/ia64/mm/init.c	2005-10-11 23:55:53.000000000 +0100
@@ -275,26 +275,21 @@ put_kernel_page (struct page *page, unsi
 
 	pgd = pgd_offset_k(address);		/* note: this is NOT pgd_offset()! */
 
-	spin_lock(&init_mm.page_table_lock);
 	{
 		pud = pud_alloc(&init_mm, pgd, address);
 		if (!pud)
 			goto out;
-
 		pmd = pmd_alloc(&init_mm, pud, address);
 		if (!pmd)
 			goto out;
-		pte = pte_alloc_map(&init_mm, pmd, address);
+		pte = pte_alloc_kernel(pmd, address);
 		if (!pte)
 			goto out;
-		if (!pte_none(*pte)) {
-			pte_unmap(pte);
+		if (!pte_none(*pte))
 			goto out;
-		}
 		set_pte(pte, mk_pte(page, pgprot));
-		pte_unmap(pte);
 	}
-  out:	spin_unlock(&init_mm.page_table_lock);
+  out:
 	/* no need for flush_tlb */
 	return page;
 }
--- mm08/arch/m32r/mm/ioremap.c	2004-10-18 22:57:23.000000000 +0100
+++ mm09/arch/m32r/mm/ioremap.c	2005-10-11 23:55:53.000000000 +0100
@@ -67,7 +67,7 @@ remap_area_pmd(pmd_t * pmd, unsigned lon
 	if (address >= end)
 		BUG();
 	do {
-		pte_t * pte = pte_alloc_kernel(&init_mm, pmd, address);
+		pte_t * pte = pte_alloc_kernel(pmd, address);
 		if (!pte)
 			return -ENOMEM;
 		remap_area_pte(pte, address, end - address, address + phys_addr, flags);
@@ -90,7 +90,6 @@ remap_area_pages(unsigned long address, 
 	flush_cache_all();
 	if (address >= end)
 		BUG();
-	spin_lock(&init_mm.page_table_lock);
 	do {
 		pmd_t *pmd;
 		pmd = pmd_alloc(&init_mm, dir, address);
@@ -104,7 +103,6 @@ remap_area_pages(unsigned long address, 
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (address && (address < end));
-	spin_unlock(&init_mm.page_table_lock);
 	flush_tlb_all();
 	return error;
 }
--- mm08/arch/m68k/mm/kmap.c	2004-08-14 06:39:28.000000000 +0100
+++ mm09/arch/m68k/mm/kmap.c	2005-10-11 23:55:53.000000000 +0100
@@ -201,7 +201,7 @@ void *__ioremap(unsigned long physaddr, 
 			virtaddr += PTRTREESIZE;
 			size -= PTRTREESIZE;
 		} else {
-			pte_dir = pte_alloc_kernel(&init_mm, pmd_dir, virtaddr);
+			pte_dir = pte_alloc_kernel(pmd_dir, virtaddr);
 			if (!pte_dir) {
 				printk("ioremap: no mem for pte_dir\n");
 				return NULL;
--- mm08/arch/m68k/sun3x/dvma.c	2004-06-16 06:20:37.000000000 +0100
+++ mm09/arch/m68k/sun3x/dvma.c	2005-10-11 23:55:53.000000000 +0100
@@ -116,7 +116,7 @@ inline int dvma_map_cpu(unsigned long ka
 			pte_t *pte;
 			unsigned long end3;
 
-			if((pte = pte_alloc_kernel(&init_mm, pmd, vaddr)) == NULL) {
+			if((pte = pte_alloc_kernel(pmd, vaddr)) == NULL) {
 				ret = -ENOMEM;
 				goto out;
 			}
--- mm08/arch/mips/mm/ioremap.c	2004-12-24 21:36:49.000000000 +0000
+++ mm09/arch/mips/mm/ioremap.c	2005-10-11 23:55:53.000000000 +0100
@@ -55,7 +55,7 @@ static inline int remap_area_pmd(pmd_t *
 	if (address >= end)
 		BUG();
 	do {
-		pte_t * pte = pte_alloc_kernel(&init_mm, pmd, address);
+		pte_t * pte = pte_alloc_kernel(pmd, address);
 		if (!pte)
 			return -ENOMEM;
 		remap_area_pte(pte, address, end - address, address + phys_addr, flags);
@@ -77,7 +77,6 @@ static int remap_area_pages(unsigned lon
 	flush_cache_all();
 	if (address >= end)
 		BUG();
-	spin_lock(&init_mm.page_table_lock);
 	do {
 		pmd_t *pmd;
 		pmd = pmd_alloc(&init_mm, dir, address);
@@ -91,7 +90,6 @@ static int remap_area_pages(unsigned lon
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (address && (address < end));
-	spin_unlock(&init_mm.page_table_lock);
 	flush_tlb_all();
 	return error;
 }
--- mm08/arch/parisc/kernel/pci-dma.c	2005-06-17 20:48:29.000000000 +0100
+++ mm09/arch/parisc/kernel/pci-dma.c	2005-10-11 23:55:53.000000000 +0100
@@ -114,7 +114,7 @@ static inline int map_pmd_uncached(pmd_t
 	if (end > PGDIR_SIZE)
 		end = PGDIR_SIZE;
 	do {
-		pte_t * pte = pte_alloc_kernel(&init_mm, pmd, vaddr);
+		pte_t * pte = pte_alloc_kernel(pmd, vaddr);
 		if (!pte)
 			return -ENOMEM;
 		if (map_pte_uncached(pte, orig_vaddr, end - vaddr, paddr_ptr))
--- mm08/arch/parisc/mm/ioremap.c	2005-03-02 07:38:55.000000000 +0000
+++ mm09/arch/parisc/mm/ioremap.c	2005-10-11 23:55:53.000000000 +0100
@@ -52,7 +52,7 @@ static inline int remap_area_pmd(pmd_t *
 	if (address >= end)
 		BUG();
 	do {
-		pte_t * pte = pte_alloc_kernel(NULL, pmd, address);
+		pte_t * pte = pte_alloc_kernel(pmd, address);
 		if (!pte)
 			return -ENOMEM;
 		remap_area_pte(pte, address, end - address, address + phys_addr, flags);
@@ -75,10 +75,9 @@ static int remap_area_pages(unsigned lon
 	flush_cache_all();
 	if (address >= end)
 		BUG();
-	spin_lock(&init_mm.page_table_lock);
 	do {
 		pmd_t *pmd;
-		pmd = pmd_alloc(dir, address);
+		pmd = pmd_alloc(&init_mm, dir, address);
 		error = -ENOMEM;
 		if (!pmd)
 			break;
@@ -89,7 +88,6 @@ static int remap_area_pages(unsigned lon
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (address && (address < end));
-	spin_unlock(&init_mm.page_table_lock);
 	flush_tlb_all();
 	return error;
 }
--- mm08/arch/ppc/kernel/dma-mapping.c	2005-09-21 12:16:17.000000000 +0100
+++ mm09/arch/ppc/kernel/dma-mapping.c	2005-10-11 23:55:53.000000000 +0100
@@ -335,8 +335,6 @@ static int __init dma_alloc_init(void)
 	pte_t *pte;
 	int ret = 0;
 
-	spin_lock(&init_mm.page_table_lock);
-
 	do {
 		pgd = pgd_offset(&init_mm, CONSISTENT_BASE);
 		pmd = pmd_alloc(&init_mm, pgd, CONSISTENT_BASE);
@@ -347,7 +345,7 @@ static int __init dma_alloc_init(void)
 		}
 		WARN_ON(!pmd_none(*pmd));
 
-		pte = pte_alloc_kernel(&init_mm, pmd, CONSISTENT_BASE);
+		pte = pte_alloc_kernel(pmd, CONSISTENT_BASE);
 		if (!pte) {
 			printk(KERN_ERR "%s: no pte tables\n", __func__);
 			ret = -ENOMEM;
@@ -357,8 +355,6 @@ static int __init dma_alloc_init(void)
 		consistent_pte = pte;
 	} while (0);
 
-	spin_unlock(&init_mm.page_table_lock);
-
 	return ret;
 }
 
--- mm08/arch/ppc/mm/4xx_mmu.c	2005-08-29 00:41:01.000000000 +0100
+++ mm09/arch/ppc/mm/4xx_mmu.c	2005-10-11 23:55:54.000000000 +0100
@@ -110,13 +110,11 @@ unsigned long __init mmu_mapin_ram(void)
 		pmd_t *pmdp;
 		unsigned long val = p | _PMD_SIZE_16M | _PAGE_HWEXEC | _PAGE_HWWRITE;
 
-		spin_lock(&init_mm.page_table_lock);
 		pmdp = pmd_offset(pgd_offset_k(v), v);
 		pmd_val(*pmdp++) = val;
 		pmd_val(*pmdp++) = val;
 		pmd_val(*pmdp++) = val;
 		pmd_val(*pmdp++) = val;
-		spin_unlock(&init_mm.page_table_lock);
 
 		v += LARGE_PAGE_SIZE_16M;
 		p += LARGE_PAGE_SIZE_16M;
@@ -127,10 +125,8 @@ unsigned long __init mmu_mapin_ram(void)
 		pmd_t *pmdp;
 		unsigned long val = p | _PMD_SIZE_4M | _PAGE_HWEXEC | _PAGE_HWWRITE;
 
-		spin_lock(&init_mm.page_table_lock);
 		pmdp = pmd_offset(pgd_offset_k(v), v);
 		pmd_val(*pmdp) = val;
-		spin_unlock(&init_mm.page_table_lock);
 
 		v += LARGE_PAGE_SIZE_4M;
 		p += LARGE_PAGE_SIZE_4M;
--- mm08/arch/ppc/mm/pgtable.c	2005-08-29 00:41:01.000000000 +0100
+++ mm09/arch/ppc/mm/pgtable.c	2005-10-11 23:55:54.000000000 +0100
@@ -280,18 +280,16 @@ map_page(unsigned long va, phys_addr_t p
 	pte_t *pg;
 	int err = -ENOMEM;
 
-	spin_lock(&init_mm.page_table_lock);
 	/* Use upper 10 bits of VA to index the first level map */
 	pd = pmd_offset(pgd_offset_k(va), va);
 	/* Use middle 10 bits of VA to index the second-level map */
-	pg = pte_alloc_kernel(&init_mm, pd, va);
+	pg = pte_alloc_kernel(pd, va);
 	if (pg != 0) {
 		err = 0;
 		set_pte_at(&init_mm, va, pg, pfn_pte(pa >> PAGE_SHIFT, __pgprot(flags)));
 		if (mem_init_done)
 			flush_HPTE(0, va, pmd_val(*pd));
 	}
-	spin_unlock(&init_mm.page_table_lock);
 	return err;
 }
 
--- mm08/arch/ppc64/mm/imalloc.c	2005-09-21 12:16:19.000000000 +0100
+++ mm09/arch/ppc64/mm/imalloc.c	2005-10-11 23:55:54.000000000 +0100
@@ -300,12 +300,7 @@ void im_free(void * addr)
 	for (p = &imlist ; (tmp = *p) ; p = &tmp->next) {
 		if (tmp->addr == addr) {
 			*p = tmp->next;
-
-			/* XXX: do we need the lock? */
-			spin_lock(&init_mm.page_table_lock);
 			unmap_vm_area(tmp);
-			spin_unlock(&init_mm.page_table_lock);
-
 			kfree(tmp);
 			up(&imlist_sem);
 			return;
--- mm08/arch/ppc64/mm/init.c	2005-09-30 11:58:54.000000000 +0100
+++ mm09/arch/ppc64/mm/init.c	2005-10-11 23:55:54.000000000 +0100
@@ -158,7 +158,6 @@ static int map_io_page(unsigned long ea,
 	unsigned long vsid;
 
 	if (mem_init_done) {
-		spin_lock(&init_mm.page_table_lock);
 		pgdp = pgd_offset_k(ea);
 		pudp = pud_alloc(&init_mm, pgdp, ea);
 		if (!pudp)
@@ -166,12 +165,11 @@ static int map_io_page(unsigned long ea,
 		pmdp = pmd_alloc(&init_mm, pudp, ea);
 		if (!pmdp)
 			return -ENOMEM;
-		ptep = pte_alloc_kernel(&init_mm, pmdp, ea);
+		ptep = pte_alloc_kernel(pmdp, ea);
 		if (!ptep)
 			return -ENOMEM;
 		set_pte_at(&init_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT,
 							  __pgprot(flags)));
-		spin_unlock(&init_mm.page_table_lock);
 	} else {
 		unsigned long va, vpn, hash, hpteg;
 
--- mm08/arch/s390/mm/ioremap.c	2004-06-16 06:20:37.000000000 +0100
+++ mm09/arch/s390/mm/ioremap.c	2005-10-11 23:55:54.000000000 +0100
@@ -58,7 +58,7 @@ static inline int remap_area_pmd(pmd_t *
 	if (address >= end)
 		BUG();
 	do {
-		pte_t * pte = pte_alloc_kernel(&init_mm, pmd, address);
+		pte_t * pte = pte_alloc_kernel(pmd, address);
 		if (!pte)
 			return -ENOMEM;
 		remap_area_pte(pte, address, end - address, address + phys_addr, flags);
@@ -80,7 +80,6 @@ static int remap_area_pages(unsigned lon
 	flush_cache_all();
 	if (address >= end)
 		BUG();
-	spin_lock(&init_mm.page_table_lock);
 	do {
 		pmd_t *pmd;
 		pmd = pmd_alloc(&init_mm, dir, address);
@@ -94,7 +93,6 @@ static int remap_area_pages(unsigned lon
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (address && (address < end));
-	spin_unlock(&init_mm.page_table_lock);
 	flush_tlb_all();
 	return 0;
 }
--- mm08/arch/sh/mm/ioremap.c	2004-12-24 21:37:00.000000000 +0000
+++ mm09/arch/sh/mm/ioremap.c	2005-10-11 23:55:54.000000000 +0100
@@ -57,7 +57,7 @@ static inline int remap_area_pmd(pmd_t *
 	if (address >= end)
 		BUG();
 	do {
-		pte_t * pte = pte_alloc_kernel(&init_mm, pmd, address);
+		pte_t * pte = pte_alloc_kernel(pmd, address);
 		if (!pte)
 			return -ENOMEM;
 		remap_area_pte(pte, address, end - address, address + phys_addr, flags);
@@ -79,7 +79,6 @@ int remap_area_pages(unsigned long addre
 	flush_cache_all();
 	if (address >= end)
 		BUG();
-	spin_lock(&init_mm.page_table_lock);
 	do {
 		pmd_t *pmd;
 		pmd = pmd_alloc(&init_mm, dir, address);
@@ -93,7 +92,6 @@ int remap_area_pages(unsigned long addre
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (address && (address < end));
-	spin_unlock(&init_mm.page_table_lock);
 	flush_tlb_all();
 	return error;
 }
--- mm08/arch/sh64/mm/ioremap.c	2005-06-17 20:48:29.000000000 +0100
+++ mm09/arch/sh64/mm/ioremap.c	2005-10-11 23:55:54.000000000 +0100
@@ -79,7 +79,7 @@ static inline int remap_area_pmd(pmd_t *
 		BUG();
 
 	do {
-		pte_t * pte = pte_alloc_kernel(&init_mm, pmd, address);
+		pte_t * pte = pte_alloc_kernel(pmd, address);
 		if (!pte)
 			return -ENOMEM;
 		remap_area_pte(pte, address, end - address, address + phys_addr, flags);
@@ -101,7 +101,6 @@ static int remap_area_pages(unsigned lon
 	flush_cache_all();
 	if (address >= end)
 		BUG();
-	spin_lock(&init_mm.page_table_lock);
 	do {
 		pmd_t *pmd = pmd_alloc(&init_mm, dir, address);
 		error = -ENOMEM;
@@ -115,7 +114,6 @@ static int remap_area_pages(unsigned lon
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (address && (address < end));
-	spin_unlock(&init_mm.page_table_lock);
 	flush_tlb_all();
 	return 0;
 }
--- mm08/arch/x86_64/mm/ioremap.c	2005-09-30 11:58:56.000000000 +0100
+++ mm09/arch/x86_64/mm/ioremap.c	2005-10-11 23:55:54.000000000 +0100
@@ -60,7 +60,7 @@ static inline int remap_area_pmd(pmd_t *
 	if (address >= end)
 		BUG();
 	do {
-		pte_t * pte = pte_alloc_kernel(&init_mm, pmd, address);
+		pte_t * pte = pte_alloc_kernel(pmd, address);
 		if (!pte)
 			return -ENOMEM;
 		remap_area_pte(pte, address, end - address, address + phys_addr, flags);
@@ -105,7 +105,6 @@ static int remap_area_pages(unsigned lon
 	flush_cache_all();
 	if (address >= end)
 		BUG();
-	spin_lock(&init_mm.page_table_lock);
 	do {
 		pud_t *pud;
 		pud = pud_alloc(&init_mm, pgd, address);
@@ -119,7 +118,6 @@ static int remap_area_pages(unsigned lon
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		pgd++;
 	} while (address && (address < end));
-	spin_unlock(&init_mm.page_table_lock);
 	flush_tlb_all();
 	return error;
 }
--- mm08/include/linux/mm.h	2005-10-11 23:55:38.000000000 +0100
+++ mm09/include/linux/mm.h	2005-10-11 23:55:54.000000000 +0100
@@ -711,7 +711,7 @@ static inline void unmap_shared_mapping_
 extern int vmtruncate(struct inode * inode, loff_t offset);
 extern pud_t *FASTCALL(__pud_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address));
 extern pmd_t *FASTCALL(__pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address));
-extern pte_t *FASTCALL(pte_alloc_kernel(struct mm_struct *mm, pmd_t *pmd, unsigned long address));
+extern pte_t *FASTCALL(pte_alloc_kernel(pmd_t *pmd, unsigned long address));
 extern pte_t *FASTCALL(pte_alloc_map(struct mm_struct *mm, pmd_t *pmd, unsigned long address));
 extern int install_page(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, struct page *page, pgprot_t prot);
 extern int install_file_pte(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, unsigned long pgoff, pgprot_t prot);
--- mm08/mm/memory.c	2005-10-11 23:54:33.000000000 +0100
+++ mm09/mm/memory.c	2005-10-11 23:55:54.000000000 +0100
@@ -307,28 +307,22 @@ out:
 	return pte_offset_map(pmd, address);
 }
 
-pte_t fastcall * pte_alloc_kernel(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
+pte_t fastcall * pte_alloc_kernel(pmd_t *pmd, unsigned long address)
 {
 	if (!pmd_present(*pmd)) {
 		pte_t *new;
 
-		spin_unlock(&mm->page_table_lock);
-		new = pte_alloc_one_kernel(mm, address);
-		spin_lock(&mm->page_table_lock);
+		new = pte_alloc_one_kernel(&init_mm, address);
 		if (!new)
 			return NULL;
 
-		/*
-		 * Because we dropped the lock, we should re-check the
-		 * entry, as somebody else could have populated it..
-		 */
-		if (pmd_present(*pmd)) {
+		spin_lock(&init_mm.page_table_lock);
+		if (pmd_present(*pmd))
 			pte_free_kernel(new);
-			goto out;
-		}
-		pmd_populate_kernel(mm, pmd, new);
+		else
+			pmd_populate_kernel(&init_mm, pmd, new);
+		spin_unlock(&init_mm.page_table_lock);
 	}
-out:
 	return pte_offset_kernel(pmd, address);
 }
 
@@ -2097,30 +2091,30 @@ int __handle_mm_fault(struct mm_struct *
 #ifndef __PAGETABLE_PUD_FOLDED
 /*
  * Allocate page upper directory.
- *
- * We've already handled the fast-path in-line, and we own the
- * page table lock.
+ * We've already handled the fast-path in-line.
  */
 pud_t fastcall *__pud_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
 {
 	pud_t *new;
 
-	spin_unlock(&mm->page_table_lock);
+	if (mm != &init_mm)		/* Temporary bridging hack */
+		spin_unlock(&mm->page_table_lock);
 	new = pud_alloc_one(mm, address);
-	spin_lock(&mm->page_table_lock);
-	if (!new)
+	if (!new) {
+		if (mm != &init_mm)	/* Temporary bridging hack */
+			spin_lock(&mm->page_table_lock);
 		return NULL;
+	}
 
-	/*
-	 * Because we dropped the lock, we should re-check the
-	 * entry, as somebody else could have populated it..
-	 */
+	spin_lock(&mm->page_table_lock);
 	if (pgd_present(*pgd)) {
 		pud_free(new);
 		goto out;
 	}
 	pgd_populate(mm, pgd, new);
  out:
+	if (mm == &init_mm)		/* Temporary bridging hack */
+		spin_unlock(&mm->page_table_lock);
 	return pud_offset(pgd, address);
 }
 #endif /* __PAGETABLE_PUD_FOLDED */
@@ -2128,24 +2122,22 @@ pud_t fastcall *__pud_alloc(struct mm_st
 #ifndef __PAGETABLE_PMD_FOLDED
 /*
  * Allocate page middle directory.
- *
- * We've already handled the fast-path in-line, and we own the
- * page table lock.
+ * We've already handled the fast-path in-line.
  */
 pmd_t fastcall *__pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 {
 	pmd_t *new;
 
-	spin_unlock(&mm->page_table_lock);
+	if (mm != &init_mm)		/* Temporary bridging hack */
+		spin_unlock(&mm->page_table_lock);
 	new = pmd_alloc_one(mm, address);
-	spin_lock(&mm->page_table_lock);
-	if (!new)
+	if (!new) {
+		if (mm != &init_mm)	/* Temporary bridging hack */
+			spin_lock(&mm->page_table_lock);
 		return NULL;
+	}
 
-	/*
-	 * Because we dropped the lock, we should re-check the
-	 * entry, as somebody else could have populated it..
-	 */
+	spin_lock(&mm->page_table_lock);
 #ifndef __ARCH_HAS_4LEVEL_HACK
 	if (pud_present(*pud)) {
 		pmd_free(new);
@@ -2161,6 +2153,8 @@ pmd_t fastcall *__pmd_alloc(struct mm_st
 #endif /* __ARCH_HAS_4LEVEL_HACK */
 
  out:
+	if (mm == &init_mm)		/* Temporary bridging hack */
+		spin_unlock(&mm->page_table_lock);
 	return pmd_offset(pud, address);
 }
 #endif /* __PAGETABLE_PMD_FOLDED */
--- mm08/mm/vmalloc.c	2005-09-21 12:16:59.000000000 +0100
+++ mm09/mm/vmalloc.c	2005-10-11 23:55:54.000000000 +0100
@@ -88,7 +88,7 @@ static int vmap_pte_range(pmd_t *pmd, un
 {
 	pte_t *pte;
 
-	pte = pte_alloc_kernel(&init_mm, pmd, addr);
+	pte = pte_alloc_kernel(pmd, addr);
 	if (!pte)
 		return -ENOMEM;
 	do {
@@ -146,14 +146,12 @@ int map_vm_area(struct vm_struct *area, 
 
 	BUG_ON(addr >= end);
 	pgd = pgd_offset_k(addr);
-	spin_lock(&init_mm.page_table_lock);
 	do {
 		next = pgd_addr_end(addr, end);
 		err = vmap_pud_range(pgd, addr, next, prot, pages);
 		if (err)
 			break;
 	} while (pgd++, addr = next, addr != end);
-	spin_unlock(&init_mm.page_table_lock);
 	flush_cache_vmap((unsigned long) area->addr, end);
 	return err;
 }
