Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262436AbVADXbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbVADXbZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 18:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbVADX25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 18:28:57 -0500
Received: from zeus.kernel.org ([204.152.189.113]:59357 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262162AbVADXPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 18:15:12 -0500
Date: Tue, 4 Jan 2005 15:13:30 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, linux-mm@kvack.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Prezeroing V3 [1/4]: Allow request for zeroed memory
In-Reply-To: <Pine.LNX.4.58.0501041510430.1536@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0501041512450.1536@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
 <41C20E3E.3070209@yahoo.com.au> <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231132170.31791@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231133130.31791@schroedinger.engr.sgi.com>
 <Pine.GSO.4.61.0501011123550.27452@waterleaf.sonytel.be>
 <Pine.LNX.4.58.0501041510430.1536@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces __GFP_ZERO as an additional gfp_mask element to allow
to request zeroed pages from the page allocator.

o Modifies the page allocator so that it zeroes memory if __GFP_ZERO is set

o Replace all page zeroing after allocating pages by request for
  zeroed pages.

o requires arch updates to clear_page in order to function properly.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.10/mm/page_alloc.c
===================================================================
--- linux-2.6.10.orig/mm/page_alloc.c	2005-01-04 12:16:41.000000000 -0800
+++ linux-2.6.10/mm/page_alloc.c	2005-01-04 12:16:49.000000000 -0800
@@ -584,6 +584,18 @@
 		BUG_ON(bad_range(zone, page));
 		mod_page_state_zone(zone, pgalloc, 1 << order);
 		prep_new_page(page, order);
+
+		if (gfp_flags & __GFP_ZERO) {
+#ifdef CONFIG_HIGHMEM
+			if (PageHighMem(page)) {
+				int n = 1 << order;
+
+				while (n-- >0)
+					clear_highpage(page + n);
+			} else
+#endif
+			clear_page(page_address(page), order);
+		}
 		if (order && (gfp_flags & __GFP_COMP))
 			prep_compound_page(page, order);
 	}
@@ -796,12 +808,9 @@
 	 */
 	BUG_ON(gfp_mask & __GFP_HIGHMEM);

-	page = alloc_pages(gfp_mask, 0);
-	if (page) {
-		void *address = page_address(page);
-		clear_page(address);
-		return (unsigned long) address;
-	}
+	page = alloc_pages(gfp_mask | __GFP_ZERO, 0);
+	if (page)
+		return (unsigned long) page_address(page);
 	return 0;
 }

Index: linux-2.6.10/include/linux/gfp.h
===================================================================
--- linux-2.6.10.orig/include/linux/gfp.h	2004-12-24 13:34:27.000000000 -0800
+++ linux-2.6.10/include/linux/gfp.h	2005-01-04 12:16:49.000000000 -0800
@@ -37,6 +37,7 @@
 #define __GFP_NORETRY	0x1000	/* Do not retry.  Might fail */
 #define __GFP_NO_GROW	0x2000	/* Slab internal usage */
 #define __GFP_COMP	0x4000	/* Add compound page metadata */
+#define __GFP_ZERO	0x8000	/* Return zeroed page on success */

 #define __GFP_BITS_SHIFT 16	/* Room for 16 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((1 << __GFP_BITS_SHIFT) - 1)
@@ -52,6 +53,7 @@
 #define GFP_KERNEL	(__GFP_WAIT | __GFP_IO | __GFP_FS)
 #define GFP_USER	(__GFP_WAIT | __GFP_IO | __GFP_FS)
 #define GFP_HIGHUSER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HIGHMEM)
+#define GFP_HIGHZERO	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HIGHMEM | __GFP_ZERO)

 /* Flag - indicates that the buffer will be suitable for DMA.  Ignored on some
    platforms, used as appropriate on others */
Index: linux-2.6.10/mm/memory.c
===================================================================
--- linux-2.6.10.orig/mm/memory.c	2005-01-04 12:16:41.000000000 -0800
+++ linux-2.6.10/mm/memory.c	2005-01-04 12:16:49.000000000 -0800
@@ -1650,10 +1650,9 @@

 		if (unlikely(anon_vma_prepare(vma)))
 			goto no_mem;
-		page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
+		page = alloc_page_vma(GFP_HIGHZERO, vma, addr);
 		if (!page)
 			goto no_mem;
-		clear_user_highpage(page, addr);

 		spin_lock(&mm->page_table_lock);
 		page_table = pte_offset_map(pmd, addr);
Index: linux-2.6.10/kernel/profile.c
===================================================================
--- linux-2.6.10.orig/kernel/profile.c	2004-12-24 13:35:28.000000000 -0800
+++ linux-2.6.10/kernel/profile.c	2005-01-04 12:16:49.000000000 -0800
@@ -326,17 +326,15 @@
 		node = cpu_to_node(cpu);
 		per_cpu(cpu_profile_flip, cpu) = 0;
 		if (!per_cpu(cpu_profile_hits, cpu)[1]) {
-			page = alloc_pages_node(node, GFP_KERNEL, 0);
+			page = alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, 0);
 			if (!page)
 				return NOTIFY_BAD;
-			clear_highpage(page);
 			per_cpu(cpu_profile_hits, cpu)[1] = page_address(page);
 		}
 		if (!per_cpu(cpu_profile_hits, cpu)[0]) {
-			page = alloc_pages_node(node, GFP_KERNEL, 0);
+			page = alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, 0);
 			if (!page)
 				goto out_free;
-			clear_highpage(page);
 			per_cpu(cpu_profile_hits, cpu)[0] = page_address(page);
 		}
 		break;
@@ -510,16 +508,14 @@
 		int node = cpu_to_node(cpu);
 		struct page *page;

-		page = alloc_pages_node(node, GFP_KERNEL, 0);
+		page = alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, 0);
 		if (!page)
 			goto out_cleanup;
-		clear_highpage(page);
 		per_cpu(cpu_profile_hits, cpu)[1]
 				= (struct profile_hit *)page_address(page);
-		page = alloc_pages_node(node, GFP_KERNEL, 0);
+		page = alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, 0);
 		if (!page)
 			goto out_cleanup;
-		clear_highpage(page);
 		per_cpu(cpu_profile_hits, cpu)[0]
 				= (struct profile_hit *)page_address(page);
 	}
Index: linux-2.6.10/mm/shmem.c
===================================================================
--- linux-2.6.10.orig/mm/shmem.c	2004-12-24 13:34:32.000000000 -0800
+++ linux-2.6.10/mm/shmem.c	2005-01-04 12:16:49.000000000 -0800
@@ -369,9 +369,8 @@
 		}

 		spin_unlock(&info->lock);
-		page = shmem_dir_alloc(mapping_gfp_mask(inode->i_mapping));
+		page = shmem_dir_alloc(mapping_gfp_mask(inode->i_mapping) | __GFP_ZERO);
 		if (page) {
-			clear_highpage(page);
 			page->nr_swapped = 0;
 		}
 		spin_lock(&info->lock);
@@ -910,7 +909,7 @@
 	pvma.vm_policy = mpol_shared_policy_lookup(&info->policy, idx);
 	pvma.vm_pgoff = idx;
 	pvma.vm_end = PAGE_SIZE;
-	page = alloc_page_vma(gfp, &pvma, 0);
+	page = alloc_page_vma(gfp | __GFP_ZERO, &pvma, 0);
 	mpol_free(pvma.vm_policy);
 	return page;
 }
@@ -926,7 +925,7 @@
 shmem_alloc_page(unsigned long gfp,struct shmem_inode_info *info,
 				 unsigned long idx)
 {
-	return alloc_page(gfp);
+	return alloc_page(gfp | __GFP_ZERO);
 }
 #endif

@@ -1135,7 +1134,6 @@

 		info->alloced++;
 		spin_unlock(&info->lock);
-		clear_highpage(filepage);
 		flush_dcache_page(filepage);
 		SetPageUptodate(filepage);
 	}
Index: linux-2.6.10/mm/hugetlb.c
===================================================================
--- linux-2.6.10.orig/mm/hugetlb.c	2004-12-24 13:35:00.000000000 -0800
+++ linux-2.6.10/mm/hugetlb.c	2005-01-04 12:16:49.000000000 -0800
@@ -77,7 +77,6 @@
 struct page *alloc_huge_page(void)
 {
 	struct page *page;
-	int i;

 	spin_lock(&hugetlb_lock);
 	page = dequeue_huge_page();
@@ -88,8 +87,7 @@
 	spin_unlock(&hugetlb_lock);
 	set_page_count(page, 1);
 	page[1].mapping = (void *)free_huge_page;
-	for (i = 0; i < (HPAGE_SIZE/PAGE_SIZE); ++i)
-		clear_highpage(&page[i]);
+	clear_page(page_address(page), HUGETLB_PAGE_ORDER);
 	return page;
 }

Index: linux-2.6.10/include/asm-ia64/pgalloc.h
===================================================================
--- linux-2.6.10.orig/include/asm-ia64/pgalloc.h	2005-01-04 12:16:41.000000000 -0800
+++ linux-2.6.10/include/asm-ia64/pgalloc.h	2005-01-04 12:16:49.000000000 -0800
@@ -61,9 +61,7 @@
 	pgd_t *pgd = pgd_alloc_one_fast(mm);

 	if (unlikely(pgd == NULL)) {
-		pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
-		if (likely(pgd != NULL))
-			clear_page(pgd);
+		pgd = (pgd_t *)__get_free_page(GFP_KERNEL|__GFP_ZERO);
 	}
 	return pgd;
 }
@@ -106,10 +104,8 @@
 static inline pmd_t*
 pmd_alloc_one (struct mm_struct *mm, unsigned long addr)
 {
-	pmd_t *pmd = (pmd_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
+	pmd_t *pmd = (pmd_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);

-	if (likely(pmd != NULL))
-		clear_page(pmd);
 	return pmd;
 }

@@ -140,20 +136,16 @@
 static inline struct page *
 pte_alloc_one (struct mm_struct *mm, unsigned long addr)
 {
-	struct page *pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT, 0);
+	struct page *pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, 0);

-	if (likely(pte != NULL))
-		clear_page(page_address(pte));
 	return pte;
 }

 static inline pte_t *
 pte_alloc_one_kernel (struct mm_struct *mm, unsigned long addr)
 {
-	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
+	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);

-	if (likely(pte != NULL))
-		clear_page(pte);
 	return pte;
 }

Index: linux-2.6.10/arch/i386/mm/pgtable.c
===================================================================
--- linux-2.6.10.orig/arch/i386/mm/pgtable.c	2005-01-04 12:16:39.000000000 -0800
+++ linux-2.6.10/arch/i386/mm/pgtable.c	2005-01-04 12:16:49.000000000 -0800
@@ -140,10 +140,7 @@

 pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
-	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
-	if (pte)
-		clear_page(pte);
-	return pte;
+	return (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
 }

 struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
@@ -151,12 +148,10 @@
 	struct page *pte;

 #ifdef CONFIG_HIGHPTE
-	pte = alloc_pages(GFP_KERNEL|__GFP_HIGHMEM|__GFP_REPEAT, 0);
+	pte = alloc_pages(GFP_KERNEL|__GFP_HIGHMEM|__GFP_REPEAT|__GFP_ZERO, 0);
 #else
-	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT, 0);
+	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, 0);
 #endif
-	if (pte)
-		clear_highpage(pte);
 	return pte;
 }

Index: linux-2.6.10/arch/m68k/mm/motorola.c
===================================================================
--- linux-2.6.10.orig/arch/m68k/mm/motorola.c	2004-12-24 13:34:58.000000000 -0800
+++ linux-2.6.10/arch/m68k/mm/motorola.c	2005-01-04 12:16:49.000000000 -0800
@@ -1,4 +1,4 @@
-/*
+*
  * linux/arch/m68k/motorola.c
  *
  * Routines specific to the Motorola MMU, originally from:
@@ -50,7 +50,7 @@

 	ptablep = (pte_t *)alloc_bootmem_low_pages(PAGE_SIZE);

-	clear_page(ptablep);
+	clear_page(ptablep, 0);
 	__flush_page_to_ram(ptablep);
 	flush_tlb_kernel_page(ptablep);
 	nocache_page(ptablep);
@@ -90,7 +90,7 @@
 	if (((unsigned long)last_pgtable & ~PAGE_MASK) == 0) {
 		last_pgtable = (pmd_t *)alloc_bootmem_low_pages(PAGE_SIZE);

-		clear_page(last_pgtable);
+		clear_page(last_pgtable, 0);
 		__flush_page_to_ram(last_pgtable);
 		flush_tlb_kernel_page(last_pgtable);
 		nocache_page(last_pgtable);
Index: linux-2.6.10/include/asm-mips/pgalloc.h
===================================================================
--- linux-2.6.10.orig/include/asm-mips/pgalloc.h	2004-12-24 13:34:57.000000000 -0800
+++ linux-2.6.10/include/asm-mips/pgalloc.h	2005-01-04 12:16:49.000000000 -0800
@@ -56,9 +56,7 @@
 {
 	pte_t *pte;

-	pte = (pte_t *) __get_free_pages(GFP_KERNEL|__GFP_REPEAT, PTE_ORDER);
-	if (pte)
-		clear_page(pte);
+	pte = (pte_t *) __get_free_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, PTE_ORDER);

 	return pte;
 }
Index: linux-2.6.10/arch/alpha/mm/init.c
===================================================================
--- linux-2.6.10.orig/arch/alpha/mm/init.c	2004-12-24 13:35:28.000000000 -0800
+++ linux-2.6.10/arch/alpha/mm/init.c	2005-01-04 12:16:49.000000000 -0800
@@ -42,10 +42,9 @@
 {
 	pgd_t *ret, *init;

-	ret = (pgd_t *)__get_free_page(GFP_KERNEL);
+	ret = (pgd_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
 	init = pgd_offset(&init_mm, 0UL);
 	if (ret) {
-		clear_page(ret);
 #ifdef CONFIG_ALPHA_LARGE_VMALLOC
 		memcpy (ret + USER_PTRS_PER_PGD, init + USER_PTRS_PER_PGD,
 			(PTRS_PER_PGD - USER_PTRS_PER_PGD - 1)*sizeof(pgd_t));
@@ -63,9 +62,7 @@
 pte_t *
 pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
-	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
-	if (pte)
-		clear_page(pte);
+	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
 	return pte;
 }

Index: linux-2.6.10/include/asm-parisc/pgalloc.h
===================================================================
--- linux-2.6.10.orig/include/asm-parisc/pgalloc.h	2004-12-24 13:35:39.000000000 -0800
+++ linux-2.6.10/include/asm-parisc/pgalloc.h	2005-01-04 12:16:49.000000000 -0800
@@ -120,18 +120,14 @@
 static inline struct page *
 pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	struct page *page = alloc_page(GFP_KERNEL|__GFP_REPEAT);
-	if (likely(page != NULL))
-		clear_page(page_address(page));
+	struct page *page = alloc_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
 	return page;
 }

 static inline pte_t *
 pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr)
 {
-	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
-	if (likely(pte != NULL))
-		clear_page(pte);
+	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
 	return pte;
 }

Index: linux-2.6.10/arch/sh/mm/pg-sh4.c
===================================================================
--- linux-2.6.10.orig/arch/sh/mm/pg-sh4.c	2004-12-24 13:34:30.000000000 -0800
+++ linux-2.6.10/arch/sh/mm/pg-sh4.c	2005-01-04 12:16:49.000000000 -0800
@@ -34,7 +34,7 @@
 {
 	__set_bit(PG_mapped, &page->flags);
 	if (((address ^ (unsigned long)to) & CACHE_ALIAS) == 0)
-		clear_page(to);
+		clear_page(to, 0);
 	else {
 		pgprot_t pgprot = __pgprot(_PAGE_PRESENT |
 					   _PAGE_RW | _PAGE_CACHABLE |
Index: linux-2.6.10/include/asm-sparc64/pgalloc.h
===================================================================
--- linux-2.6.10.orig/include/asm-sparc64/pgalloc.h	2004-12-24 13:35:29.000000000 -0800
+++ linux-2.6.10/include/asm-sparc64/pgalloc.h	2005-01-04 12:16:49.000000000 -0800
@@ -73,10 +73,9 @@
 		struct page *page;

 		preempt_enable();
-		page = alloc_page(GFP_KERNEL|__GFP_REPEAT);
+		page = alloc_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
 		if (page) {
 			ret = (struct page *)page_address(page);
-			clear_page(ret);
 			page->lru.prev = (void *) 2UL;

 			preempt_disable();
Index: linux-2.6.10/include/asm-sh/pgalloc.h
===================================================================
--- linux-2.6.10.orig/include/asm-sh/pgalloc.h	2004-12-24 13:34:45.000000000 -0800
+++ linux-2.6.10/include/asm-sh/pgalloc.h	2005-01-04 12:16:49.000000000 -0800
@@ -44,9 +44,7 @@
 {
 	pte_t *pte;

-	pte = (pte_t *) __get_free_page(GFP_KERNEL | __GFP_REPEAT);
-	if (pte)
-		clear_page(pte);
+	pte = (pte_t *) __get_free_page(GFP_KERNEL | __GFP_REPEAT | __GFP_ZERO);

 	return pte;
 }
@@ -56,9 +54,7 @@
 {
 	struct page *pte;

-   	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT, 0);
-	if (pte)
-		clear_page(page_address(pte));
+   	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, 0);

 	return pte;
 }
Index: linux-2.6.10/include/asm-m32r/pgalloc.h
===================================================================
--- linux-2.6.10.orig/include/asm-m32r/pgalloc.h	2004-12-24 13:35:28.000000000 -0800
+++ linux-2.6.10/include/asm-m32r/pgalloc.h	2005-01-04 12:16:49.000000000 -0800
@@ -23,10 +23,7 @@
  */
 static __inline__ pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	pgd_t *pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
-
-	if (pgd)
-		clear_page(pgd);
+	pgd_t *pgd = (pgd_t *)__get_free_page(GFP_KERNEL|__GFP_ZERO);

 	return pgd;
 }
@@ -39,10 +36,7 @@
 static __inline__ pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
 	unsigned long address)
 {
-	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL);
-
-	if (pte)
-		clear_page(pte);
+	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_ZERO);

 	return pte;
 }
@@ -50,10 +44,8 @@
 static __inline__ struct page *pte_alloc_one(struct mm_struct *mm,
 	unsigned long address)
 {
-	struct page *pte = alloc_page(GFP_KERNEL);
+	struct page *pte = alloc_page(GFP_KERNEL|__GFP_ZERO);

-	if (pte)
-		clear_page(page_address(pte));

 	return pte;
 }
Index: linux-2.6.10/arch/um/kernel/mem.c
===================================================================
--- linux-2.6.10.orig/arch/um/kernel/mem.c	2005-01-04 12:16:40.000000000 -0800
+++ linux-2.6.10/arch/um/kernel/mem.c	2005-01-04 12:16:49.000000000 -0800
@@ -327,9 +327,7 @@
 {
 	pte_t *pte;

-	pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
-	if (pte)
-		clear_page(pte);
+	pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
 	return pte;
 }

@@ -337,9 +335,7 @@
 {
 	struct page *pte;

-	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT, 0);
-	if (pte)
-		clear_highpage(pte);
+	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, 0);
 	return pte;
 }

Index: linux-2.6.10/arch/ppc64/mm/init.c
===================================================================
--- linux-2.6.10.orig/arch/ppc64/mm/init.c	2004-12-24 13:34:58.000000000 -0800
+++ linux-2.6.10/arch/ppc64/mm/init.c	2005-01-04 12:16:49.000000000 -0800
@@ -761,7 +761,7 @@

 void clear_user_page(void *page, unsigned long vaddr, struct page *pg)
 {
-	clear_page(page);
+	clear_page(page, 0);

 	if (cur_cpu_spec->cpu_features & CPU_FTR_COHERENT_ICACHE)
 		return;
Index: linux-2.6.10/include/asm-sh64/pgalloc.h
===================================================================
--- linux-2.6.10.orig/include/asm-sh64/pgalloc.h	2004-12-24 13:34:00.000000000 -0800
+++ linux-2.6.10/include/asm-sh64/pgalloc.h	2005-01-04 12:16:49.000000000 -0800
@@ -112,9 +112,7 @@
 {
 	pte_t *pte;

-	pte = (pte_t *)__get_free_page(GFP_KERNEL | __GFP_REPEAT);
-	if (pte)
-		clear_page(pte);
+	pte = (pte_t *)__get_free_page(GFP_KERNEL | __GFP_REPEAT|__GFP_ZERO);

 	return pte;
 }
@@ -123,9 +121,7 @@
 {
 	struct page *pte;

-	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT, 0);
-	if (pte)
-		clear_page(page_address(pte));
+	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, 0);

 	return pte;
 }
@@ -150,9 +146,7 @@
 static __inline__ pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	pmd_t *pmd;
-	pmd = (pmd_t *) __get_free_page(GFP_KERNEL|__GFP_REPEAT);
-	if (pmd)
-		clear_page(pmd);
+	pmd = (pmd_t *) __get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
 	return pmd;
 }

Index: linux-2.6.10/include/asm-cris/pgalloc.h
===================================================================
--- linux-2.6.10.orig/include/asm-cris/pgalloc.h	2004-12-24 13:35:25.000000000 -0800
+++ linux-2.6.10/include/asm-cris/pgalloc.h	2005-01-04 12:16:49.000000000 -0800
@@ -24,18 +24,14 @@

 extern inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
-  	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
-	if (pte)
-		clear_page(pte);
+  	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
  	return pte;
 }

 extern inline struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	struct page *pte;
-	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT, 0);
-	if (pte)
-		clear_page(page_address(pte));
+	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, 0);
 	return pte;
 }

Index: linux-2.6.10/arch/ppc/mm/pgtable.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/mm/pgtable.c	2004-12-24 13:34:26.000000000 -0800
+++ linux-2.6.10/arch/ppc/mm/pgtable.c	2005-01-04 12:16:49.000000000 -0800
@@ -85,8 +85,7 @@
 {
 	pgd_t *ret;

-	if ((ret = (pgd_t *)__get_free_pages(GFP_KERNEL, PGDIR_ORDER)) != NULL)
-		clear_pages(ret, PGDIR_ORDER);
+	ret = (pgd_t *)__get_free_pages(GFP_KERNEL|__GFP_ZERO, PGDIR_ORDER);
 	return ret;
 }

@@ -102,7 +101,7 @@
 	extern void *early_get_page(void);

 	if (mem_init_done) {
-		pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
+		pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
 		if (pte) {
 			struct page *ptepage = virt_to_page(pte);
 			ptepage->mapping = (void *) mm;
@@ -110,8 +109,6 @@
 		}
 	} else
 		pte = (pte_t *)early_get_page();
-	if (pte)
-		clear_page(pte);
 	return pte;
 }

Index: linux-2.6.10/arch/ppc/mm/init.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/mm/init.c	2005-01-04 12:16:40.000000000 -0800
+++ linux-2.6.10/arch/ppc/mm/init.c	2005-01-04 12:16:49.000000000 -0800
@@ -594,7 +594,7 @@
 }
 void clear_user_page(void *page, unsigned long vaddr, struct page *pg)
 {
-	clear_page(page);
+	clear_page(page, 0);
 	clear_bit(PG_arch_1, &pg->flags);
 }

Index: linux-2.6.10/fs/afs/file.c
===================================================================
--- linux-2.6.10.orig/fs/afs/file.c	2004-12-24 13:35:59.000000000 -0800
+++ linux-2.6.10/fs/afs/file.c	2005-01-04 12:16:49.000000000 -0800
@@ -172,7 +172,7 @@
 				      (size_t) PAGE_SIZE);
 		desc.buffer	= kmap(page);

-		clear_page(desc.buffer);
+		clear_page(desc.buffer, 0);

 		/* read the contents of the file from the server into the
 		 * page */
Index: linux-2.6.10/include/asm-alpha/pgalloc.h
===================================================================
--- linux-2.6.10.orig/include/asm-alpha/pgalloc.h	2004-12-24 13:35:50.000000000 -0800
+++ linux-2.6.10/include/asm-alpha/pgalloc.h	2005-01-04 12:16:49.000000000 -0800
@@ -40,9 +40,7 @@
 static inline pmd_t *
 pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	pmd_t *ret = (pmd_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
-	if (ret)
-		clear_page(ret);
+	pmd_t *ret = (pmd_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
 	return ret;
 }

Index: linux-2.6.10/include/linux/highmem.h
===================================================================
--- linux-2.6.10.orig/include/linux/highmem.h	2005-01-04 12:16:41.000000000 -0800
+++ linux-2.6.10/include/linux/highmem.h	2005-01-04 12:16:49.000000000 -0800
@@ -45,7 +45,7 @@
 static inline void clear_highpage(struct page *page)
 {
 	void *kaddr = kmap_atomic(page, KM_USER0);
-	clear_page(kaddr);
+	clear_page(kaddr, 0);
 	kunmap_atomic(kaddr, KM_USER0);
 }

Index: linux-2.6.10/arch/sh64/mm/ioremap.c
===================================================================
--- linux-2.6.10.orig/arch/sh64/mm/ioremap.c	2004-12-24 13:34:58.000000000 -0800
+++ linux-2.6.10/arch/sh64/mm/ioremap.c	2005-01-04 12:16:49.000000000 -0800
@@ -399,7 +399,7 @@
 	if (pte_none(*ptep) || !pte_present(*ptep))
 		return;

-	clear_page((void *)ptep);
+	clear_page((void *)ptep, 0);
 	pte_clear(ptep);
 }

Index: linux-2.6.10/include/asm-m68k/motorola_pgalloc.h
===================================================================
--- linux-2.6.10.orig/include/asm-m68k/motorola_pgalloc.h	2004-12-24 13:35:50.000000000 -0800
+++ linux-2.6.10/include/asm-m68k/motorola_pgalloc.h	2005-01-04 12:16:49.000000000 -0800
@@ -12,9 +12,8 @@
 {
 	pte_t *pte;

-	pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
+	pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
 	if (pte) {
-		clear_page(pte);
 		__flush_page_to_ram(pte);
 		flush_tlb_kernel_page(pte);
 		nocache_page(pte);
@@ -31,7 +30,7 @@

 static inline struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	struct page *page = alloc_pages(GFP_KERNEL|__GFP_REPEAT, 0);
+	struct page *page = alloc_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, 0);
 	pte_t *pte;

 	if(!page)
@@ -39,7 +38,6 @@

 	pte = kmap(page);
 	if (pte) {
-		clear_page(pte);
 		__flush_page_to_ram(pte);
 		flush_tlb_kernel_page(pte);
 		nocache_page(pte);
Index: linux-2.6.10/arch/sh/mm/pg-sh7705.c
===================================================================
--- linux-2.6.10.orig/arch/sh/mm/pg-sh7705.c	2004-12-24 13:34:58.000000000 -0800
+++ linux-2.6.10/arch/sh/mm/pg-sh7705.c	2005-01-04 12:16:49.000000000 -0800
@@ -78,13 +78,13 @@

 	__set_bit(PG_mapped, &page->flags);
 	if (((address ^ (unsigned long)to) & CACHE_ALIAS) == 0) {
-		clear_page(to);
+		clear_page(to, 0);
 		__flush_wback_region(to, PAGE_SIZE);
 	} else {
 		__flush_purge_virtual_region(to,
 					     (void *)(address & 0xfffff000),
 					     PAGE_SIZE);
-		clear_page(to);
+		clear_page(to, 0);
 		__flush_wback_region(to, PAGE_SIZE);
 	}
 }
Index: linux-2.6.10/arch/sparc64/mm/init.c
===================================================================
--- linux-2.6.10.orig/arch/sparc64/mm/init.c	2004-12-24 13:34:31.000000000 -0800
+++ linux-2.6.10/arch/sparc64/mm/init.c	2005-01-04 12:16:49.000000000 -0800
@@ -1687,13 +1687,12 @@
 	 * Set up the zero page, mark it reserved, so that page count
 	 * is not manipulated when freeing the page from user ptes.
 	 */
-	mem_map_zero = alloc_pages(GFP_KERNEL, 0);
+	mem_map_zero = alloc_pages(GFP_KERNEL|__GFP_ZERO, 0);
 	if (mem_map_zero == NULL) {
 		prom_printf("paging_init: Cannot alloc zero page.\n");
 		prom_halt();
 	}
 	SetPageReserved(mem_map_zero);
-	clear_page(page_address(mem_map_zero));

 	codepages = (((unsigned long) _etext) - ((unsigned long) _start));
 	codepages = PAGE_ALIGN(codepages) >> PAGE_SHIFT;
Index: linux-2.6.10/include/asm-arm/pgalloc.h
===================================================================
--- linux-2.6.10.orig/include/asm-arm/pgalloc.h	2004-12-24 13:35:29.000000000 -0800
+++ linux-2.6.10/include/asm-arm/pgalloc.h	2005-01-04 12:16:49.000000000 -0800
@@ -50,9 +50,8 @@
 {
 	pte_t *pte;

-	pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
+	pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
 	if (pte) {
-		clear_page(pte);
 		clean_dcache_area(pte, sizeof(pte_t) * PTRS_PER_PTE);
 		pte += PTRS_PER_PTE;
 	}
@@ -65,10 +64,9 @@
 {
 	struct page *pte;

-	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT, 0);
+	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, 0);
 	if (pte) {
 		void *page = page_address(pte);
-		clear_page(page);
 		clean_dcache_area(page, sizeof(pte_t) * PTRS_PER_PTE);
 	}

Index: linux-2.6.10/drivers/net/tc35815.c
===================================================================
--- linux-2.6.10.orig/drivers/net/tc35815.c	2004-12-24 13:33:48.000000000 -0800
+++ linux-2.6.10/drivers/net/tc35815.c	2005-01-04 12:16:49.000000000 -0800
@@ -657,7 +657,7 @@
 		dma_cache_wback_inv((unsigned long)lp->fd_buf, PAGE_SIZE * FD_PAGE_NUM);
 #endif
 	} else {
-		clear_page(lp->fd_buf);
+		clear_page(lp->fd_buf, 0);
 #ifdef __mips__
 		dma_cache_wback_inv((unsigned long)lp->fd_buf, PAGE_SIZE * FD_PAGE_NUM);
 #endif
Index: linux-2.6.10/drivers/block/pktcdvd.c
===================================================================
--- linux-2.6.10.orig/drivers/block/pktcdvd.c	2004-12-24 13:33:49.000000000 -0800
+++ linux-2.6.10/drivers/block/pktcdvd.c	2005-01-04 12:16:49.000000000 -0800
@@ -135,12 +135,10 @@
 		goto no_bio;

 	for (i = 0; i < PAGES_PER_PACKET; i++) {
-		pkt->pages[i] = alloc_page(GFP_KERNEL);
+		pkt->pages[i] = alloc_page(GFP_KERNEL|| __GFP_ZERO);
 		if (!pkt->pages[i])
 			goto no_page;
 	}
-	for (i = 0; i < PAGES_PER_PACKET; i++)
-		clear_page(page_address(pkt->pages[i]));

 	spin_lock_init(&pkt->lock);


