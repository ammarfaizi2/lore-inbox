Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUDDNsi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 09:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbUDDNsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 09:48:38 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:47286 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262380AbUDDNsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 09:48:17 -0400
Date: Sun, 4 Apr 2004 14:48:15 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.5-aa1 arch updates
Message-ID: <Pine.LNX.4.44.0404041446430.22502-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've gone through our arch and include/asm files checking differences,
here's a patch to 2.6.5-aa1: page_mapping(page) and prio_tree updates.
All uncompiled and untested, but probably better than certainly wrong.

One fix: your ppc64 pte_alloc_one forgot to return NULL on failure:
I notice that's a __GFP_REPEAT allocation, but even those fail when
OOM-killed - I find its alias __GFP_NOFAIL very misleading.

I forget where you stand now on the ppc pgtable stuff: it naturally
shows up here again, ignore again if you're sure it's irrelevant.

 arch/arm/mm/fault-armv.c        |   82 +++++++++++++++----------------------
 arch/mips/mm/cache.c            |   13 +++--
 arch/parisc/kernel/cache.c      |   88 ++++++++++++++++++----------------------
 arch/parisc/kernel/sys_parisc.c |   14 ------
 arch/ppc/mm/pgtable.c           |   28 ++++++++----
 arch/sparc64/kernel/smp.c       |    8 +--
 arch/sparc64/mm/init.c          |   18 ++++----
 include/asm-arm/cacheflush.h    |   12 +++--
 include/asm-parisc/cacheflush.h |   10 +++-
 include/asm-ppc64/pgalloc.h     |    1 
 include/asm-sh/pgalloc.h        |    5 +-
 11 files changed, 137 insertions(+), 142 deletions(-)

--- 2.6.5-aa1/arch/arm/mm/fault-armv.c	2003-09-28 01:51:32.000000000 +0100
+++ linux/arch/arm/mm/fault-armv.c	2004-04-04 11:49:41.000000000 +0100
@@ -16,6 +16,7 @@
 #include <linux/bitops.h>
 #include <linux/vmalloc.h>
 #include <linux/init.h>
+#include <linux/pagemap.h>
 
 #include <asm/cacheflush.h>
 #include <asm/io.h>
@@ -186,47 +187,47 @@ no_pmd:
 
 void __flush_dcache_page(struct page *page)
 {
+	struct address_space *mapping = page_mapping(page);
 	struct mm_struct *mm = current->active_mm;
-	struct list_head *l;
+	struct vm_area_struct *mpnt;
+	struct prio_tree_iter iter;
+	unsigned long offset;
+	pgoff_t pgoff;
 
 	__cpuc_flush_dcache_page(page_address(page));
 
-	if (!page->mapping)
+	if (!mapping)
 		return;
 
 	/*
 	 * With a VIVT cache, we need to also write back
 	 * and invalidate any user data.
 	 */
-	list_for_each(l, &page->mapping->i_mmap_shared) {
-		struct vm_area_struct *mpnt;
-		unsigned long off;
-
-		mpnt = list_entry(l, struct vm_area_struct, shared);
-
+	pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
+	mpnt = __vma_prio_tree_first(&mapping->i_mmap_shared,
+					&iter, pgoff, pgoff);
+	while (mpnt) {
 		/*
 		 * If this VMA is not in our MM, we can ignore it.
 		 */
-		if (mpnt->vm_mm != mm)
-			continue;
-
-		if (page->index < mpnt->vm_pgoff)
-			continue;
-
-		off = page->index - mpnt->vm_pgoff;
-		if (off >= (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT)
-			continue;
-
-		flush_cache_page(mpnt, mpnt->vm_start + (off << PAGE_SHIFT));
+		if (mpnt->vm_mm == mm) {
+			offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
+			flush_cache_page(mpnt, mpnt->vm_start + offset);
+		}
+		mpnt = __vma_prio_tree_next(mpnt, &mapping->i_mmap_shared,
+						&iter, pgoff, pgoff);
 	}
 }
 
 static void
 make_coherent(struct vm_area_struct *vma, unsigned long addr, struct page *page, int dirty)
 {
-	struct list_head *l;
+	struct address_space *mapping = page->mapping;
 	struct mm_struct *mm = vma->vm_mm;
-	unsigned long pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
+	struct vm_area_struct *mpnt;
+	struct prio_tree_iter iter;
+	unsigned long offset;
+	pgoff_t pgoff;
 	int aliases = 0;
 
 	/*
@@ -234,36 +235,21 @@ make_coherent(struct vm_area_struct *vma
 	 * space, then we need to handle them specially to maintain
 	 * cache coherency.
 	 */
-	list_for_each(l, &page->mapping->i_mmap_shared) {
-		struct vm_area_struct *mpnt;
-		unsigned long off;
-
-		mpnt = list_entry(l, struct vm_area_struct, shared);
-
+	pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
+	mpnt = __vma_prio_tree_first(&mapping->i_mmap_shared,
+					&iter, pgoff, pgoff);
+	while (mpnt) {
 		/*
 		 * If this VMA is not in our MM, we can ignore it.
-		 * Note that we intentionally don't mask out the VMA
+		 * Note that we intentionally mask out the VMA
 		 * that we are fixing up.
 		 */
-		if (mpnt->vm_mm != mm || mpnt == vma)
-			continue;
-
-		/*
-		 * If the page isn't in this VMA, we can also ignore it.
-		 */
-		if (pgoff < mpnt->vm_pgoff)
-			continue;
-
-		off = pgoff - mpnt->vm_pgoff;
-		if (off >= (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT)
-			continue;
-
-		off = mpnt->vm_start + (off << PAGE_SHIFT);
-
-		/*
-		 * Ok, it is within mpnt.  Fix it up.
-		 */
-		aliases += adjust_pte(mpnt, off);
+		if (mpnt->vm_mm == mm && mpnt != vma) {
+			offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
+			aliases += adjust_pte(mpnt, mpnt->vm_start + offset);
+		}
+		mpnt = __vma_prio_tree_next(mpnt, &mapping->i_mmap_shared,
+						&iter, pgoff, pgoff);
 	}
 	if (aliases)
 		adjust_pte(vma, addr);
@@ -292,7 +278,7 @@ void update_mmu_cache(struct vm_area_str
 	if (!pfn_valid(pfn))
 		return;
 	page = pfn_to_page(pfn);
-	if (page->mapping) {
+	if (page_mapping(page)) {
 		int dirty = test_and_clear_bit(PG_dcache_dirty, &page->flags);
 
 		if (dirty)
--- 2.6.5-aa1/arch/mips/mm/cache.c	2004-03-11 01:56:08.000000000 +0000
+++ linux/arch/mips/mm/cache.c	2004-04-04 11:49:41.000000000 +0100
@@ -55,18 +55,19 @@ asmlinkage int sys_cacheflush(void *addr
 
 void flush_dcache_page(struct page *page)
 {
+	struct address_space *mapping = page_mapping(page);
 	unsigned long addr;
 
-	if (page->mapping &&
-	    list_empty(&page->mapping->i_mmap) &&
-	    list_empty(&page->mapping->i_mmap_shared)) {
+	if (mapping &&
+	    prio_tree_empty(&mapping->i_mmap) &&
+	    prio_tree_empty(&mapping->i_mmap_shared) &&
+	    list_empty(&mapping->i_mmap_nonlinear)) {
 		SetPageDcacheDirty(page);
-
 		return;
 	}
 
 	/*
-	 * We could delay the flush for the !page->mapping case too.  But that
+	 * We could delay the flush for the !page_mapping case too.  But that
 	 * case is for exec env/arg pages and those are %99 certainly going to
 	 * get faulted into the tlb (and thus flushed) anyways.
 	 */
@@ -81,7 +82,7 @@ void __update_cache(struct vm_area_struc
 	unsigned long pfn, addr;
 
 	pfn = pte_pfn(pte);
-	if (pfn_valid(pfn) && (page = pfn_to_page(pfn), page->mapping) &&
+	if (pfn_valid(pfn) && (page = pfn_to_page(pfn), page_mapping(page)) &&
 	    Page_dcache_dirty(page)) {
 		if (pages_do_alias((unsigned long)page_address(page),
 		                   address & PAGE_MASK)) {
--- 2.6.5-aa1/arch/parisc/kernel/cache.c	2004-01-09 06:00:23.000000000 +0000
+++ linux/arch/parisc/kernel/cache.c	2004-04-04 11:49:41.000000000 +0100
@@ -17,6 +17,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/seq_file.h>
+#include <linux/pagemap.h>
 
 #include <asm/pdc.h>
 #include <asm/cache.h>
@@ -68,7 +69,7 @@ update_mmu_cache(struct vm_area_struct *
 {
 	struct page *page = pte_page(pte);
 
-	if (VALID_PAGE(page) && page->mapping &&
+	if (VALID_PAGE(page) && page_mapping(page) &&
 	    test_bit(PG_dcache_dirty, &page->flags)) {
 
 		flush_kernel_dcache_page(page_address(page));
@@ -229,67 +230,60 @@ void disable_sr_hashing(void)
 
 void __flush_dcache_page(struct page *page)
 {
+	struct address_space *mapping = page_mapping(page);
 	struct mm_struct *mm = current->active_mm;
-	struct list_head *l;
+	struct vm_area_struct *mpnt;
+	struct prio_tree_iter iter;
+	unsigned long offset;
+	pgoff_t pgoff;
 
 	flush_kernel_dcache_page(page_address(page));
 
-	if (!page->mapping)
+	if (!mapping)
 		return;
-	/* check shared list first if it's not empty...it's usually
-	 * the shortest */
-	list_for_each(l, &page->mapping->i_mmap_shared) {
-		struct vm_area_struct *mpnt;
-		unsigned long off;
 
-		mpnt = list_entry(l, struct vm_area_struct, shared);
+	pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
 
+	/* check shared list first if it's not empty...it's usually
+	 * the shortest */
+	mpnt = __vma_prio_tree_first(&mapping->i_mmap_shared,
+					&iter, pgoff, pgoff);
+	while (mpnt) {
 		/*
 		 * If this VMA is not in our MM, we can ignore it.
 		 */
-		if (mpnt->vm_mm != mm)
-			continue;
-
-		if (page->index < mpnt->vm_pgoff)
-			continue;
-
-		off = page->index - mpnt->vm_pgoff;
-		if (off >= (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT)
-			continue;
-
-		flush_cache_page(mpnt, mpnt->vm_start + (off << PAGE_SHIFT));
-
-		/* All user shared mappings should be equivalently mapped,
-		 * so once we've flushed one we should be ok
-		 */
-		return;
+		if (mpnt->vm_mm == mm) {
+			offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
+			flush_cache_page(mpnt, mpnt->vm_start + offset);
+
+			/* All user shared mappings should be equivalently
+			 * mapped, so once we've flushed one we should be ok
+			 */
+			return;
+		}
+		mpnt = __vma_prio_tree_next(mpnt, &mapping->i_mmap_shared,
+						&iter, pgoff, pgoff);
 	}
 
 	/* then check private mapping list for read only shared mappings
 	 * which are flagged by VM_MAYSHARE */
-	list_for_each(l, &page->mapping->i_mmap) {
-		struct vm_area_struct *mpnt;
-		unsigned long off;
-
-		mpnt = list_entry(l, struct vm_area_struct, shared);
-
-
-		if (mpnt->vm_mm != mm || !(mpnt->vm_flags & VM_MAYSHARE))
-			continue;
-
-		if (page->index < mpnt->vm_pgoff)
-			continue;
-
-		off = page->index - mpnt->vm_pgoff;
-		if (off >= (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT)
-			continue;
-
-		flush_cache_page(mpnt, mpnt->vm_start + (off << PAGE_SHIFT));
-
-		/* All user shared mappings should be equivalently mapped,
-		 * so once we've flushed one we should be ok
+	mpnt = __vma_prio_tree_first(&mapping->i_mmap,
+					&iter, pgoff, pgoff);
+	while (mpnt) {
+		/*
+		 * If this VMA is not in our MM, we can ignore it.
 		 */
-		break;
+		if (mpnt->vm_mm == mm && (mpnt->vm_flags & VM_MAYSHARE)) {
+			offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
+			flush_cache_page(mpnt, mpnt->vm_start + offset);
+
+			/* All user shared mappings should be equivalently
+			 * mapped, so once we've flushed one we should be ok
+			 */
+			return;
+		}
+		mpnt = __vma_prio_tree_next(mpnt, &mapping->i_mmap_shared,
+						&iter, pgoff, pgoff);
 	}
 }
 EXPORT_SYMBOL(__flush_dcache_page);
--- 2.6.5-aa1/arch/parisc/kernel/sys_parisc.c	2004-04-04 03:38:55.000000000 +0100
+++ linux/arch/parisc/kernel/sys_parisc.c	2004-04-04 11:49:41.000000000 +0100
@@ -68,17 +68,8 @@ static unsigned long get_unshared_area(u
  * existing mapping and use the same offset.  New scheme is to use the
  * address of the kernel data structure as the seed for the offset.
  * We'll see how that works...
- */
-#if 0
-static int get_offset(struct address_space *mapping)
-{
-	struct vm_area_struct *vma = list_entry(mapping->i_mmap_shared.next,
-			struct vm_area_struct, shared);
-	return (vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT)) &
-		(SHMLBA - 1);
-}
-#else
-/* The mapping is cacheline aligned, so there's no information in the bottom
+ *
+ * The mapping is cacheline aligned, so there's no information in the bottom
  * few bits of the address.  We're looking for 10 bits (4MB / 4k), so let's
  * drop the bottom 8 bits and use bits 8-17.  
  */
@@ -87,7 +78,6 @@ static int get_offset(struct address_spa
 	int offset = (unsigned long) mapping << (PAGE_SHIFT - 8);
 	return offset & 0x3FF000;
 }
-#endif
 
 static unsigned long get_shared_area(struct address_space *mapping,
 		unsigned long addr, unsigned long len, unsigned long pgoff)
--- 2.6.5-aa1/arch/ppc/mm/pgtable.c	2004-04-04 03:38:41.000000000 +0100
+++ linux/arch/ppc/mm/pgtable.c	2004-04-01 21:34:57.000000000 +0100
@@ -86,9 +86,14 @@ pte_t *pte_alloc_one_kernel(struct mm_st
 	extern int mem_init_done;
 	extern void *early_get_page(void);
 
-	if (mem_init_done)
+	if (mem_init_done) {
 		pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
-	else
+		if (pte) {
+			struct page *ptepage = virt_to_page(pte);
+			ptepage->mapping = (void *) mm;
+			ptepage->index = address & PMD_MASK;
+		}
+	} else
 		pte = (pte_t *)early_get_page();
 	if (pte)
 		clear_page(pte);
@@ -97,7 +102,7 @@ pte_t *pte_alloc_one_kernel(struct mm_st
 
 struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	struct page *pte;
+	struct page *ptepage;
 
 #ifdef CONFIG_HIGHPTE
 	int flags = GFP_KERNEL | __GFP_HIGHMEM | __GFP_REPEAT;
@@ -105,10 +110,13 @@ struct page *pte_alloc_one(struct mm_str
 	int flags = GFP_KERNEL | __GFP_REPEAT;
 #endif
 
-	pte = alloc_pages(flags, 0);
-	if (pte)
-		clear_highpage(pte);
-	return pte;
+	ptepage = alloc_pages(flags, 0);
+	if (ptepage) {
+		ptepage->mapping = (void *) mm;
+		ptepage->index = address & PMD_MASK;
+		clear_highpage(ptepage);
+	}
+	return ptepage;
 }
 
 void pte_free_kernel(pte_t *pte)
@@ -116,15 +124,17 @@ void pte_free_kernel(pte_t *pte)
 #ifdef CONFIG_SMP
 	hash_page_sync();
 #endif
+	virt_to_page(pte)->mapping = NULL;
 	free_page((unsigned long)pte);
 }
 
-void pte_free(struct page *pte)
+void pte_free(struct page *ptepage)
 {
 #ifdef CONFIG_SMP
 	hash_page_sync();
 #endif
-	__free_page(pte);
+	ptepage->mapping = NULL;
+	__free_page(ptepage);
 }
 
 #ifndef CONFIG_44x
--- 2.6.5-aa1/arch/sparc64/kernel/smp.c	2004-04-04 03:38:40.000000000 +0100
+++ linux/arch/sparc64/kernel/smp.c	2004-04-01 21:34:57.000000000 +0100
@@ -671,9 +671,9 @@ static __inline__ void __local_flush_dca
 #if (L1DCACHE_SIZE > PAGE_SIZE)
 	__flush_dcache_page(page->virtual,
 			    ((tlb_type == spitfire) &&
-			     page->mapping != NULL));
+			     page_mapping(page) != NULL));
 #else
-	if (page->mapping != NULL &&
+	if (page_mapping(page) != NULL &&
 	    tlb_type == spitfire)
 		__flush_icache_page(__pa(page->virtual));
 #endif
@@ -694,7 +694,7 @@ void smp_flush_dcache_page_impl(struct p
 		if (tlb_type == spitfire) {
 			data0 =
 				((u64)&xcall_flush_dcache_page_spitfire);
-			if (page->mapping != NULL)
+			if (page_mapping(page) != NULL)
 				data0 |= ((u64)1 << 32);
 			spitfire_xcall_deliver(data0,
 					       __pa(page->virtual),
@@ -727,7 +727,7 @@ void flush_dcache_page_all(struct mm_str
 		goto flush_self;
 	if (tlb_type == spitfire) {
 		data0 = ((u64)&xcall_flush_dcache_page_spitfire);
-		if (page->mapping != NULL)
+		if (page_mapping(page) != NULL)
 			data0 |= ((u64)1 << 32);
 		spitfire_xcall_deliver(data0,
 				       __pa(page->virtual),
--- 2.6.5-aa1/arch/sparc64/mm/init.c	2004-04-04 03:38:42.000000000 +0100
+++ linux/arch/sparc64/mm/init.c	2004-04-04 11:49:41.000000000 +0100
@@ -139,9 +139,9 @@ __inline__ void flush_dcache_page_impl(s
 #if (L1DCACHE_SIZE > PAGE_SIZE)
 	__flush_dcache_page(page->virtual,
 			    ((tlb_type == spitfire) &&
-			     page->mapping != NULL));
+			     page_mapping(page) != NULL));
 #else
-	if (page->mapping != NULL &&
+	if (page_mapping(page) != NULL &&
 	    tlb_type == spitfire)
 		__flush_icache_page(__pa(page->virtual));
 #endif
@@ -203,7 +203,7 @@ void update_mmu_cache(struct vm_area_str
 
 	pfn = pte_pfn(pte);
 	if (pfn_valid(pfn) &&
-	    (page = pfn_to_page(pfn), page->mapping) &&
+	    (page = pfn_to_page(pfn), page_mapping(page)) &&
 	    ((pg_flags = page->flags) & (1UL << PG_dcache_dirty))) {
 		int cpu = ((pg_flags >> 24) & (NR_CPUS - 1UL));
 
@@ -224,12 +224,14 @@ void update_mmu_cache(struct vm_area_str
 
 void flush_dcache_page(struct page *page)
 {
+	struct address_space *mapping = page_mapping(page);
 	int dirty = test_bit(PG_dcache_dirty, &page->flags);
 	int dirty_cpu = dcache_dirty_cpu(page);
 
-	if (page->mapping &&
-	    list_empty(&page->mapping->i_mmap) &&
-	    list_empty(&page->mapping->i_mmap_shared)) {
+	if (mapping &&
+	    prio_tree_empty(&mapping->i_mmap) &&
+	    prio_tree_empty(&mapping->i_mmap_shared) &&
+	    list_empty(&mapping->i_mmap_nonlinear)) {
 		if (dirty) {
 			if (dirty_cpu == smp_processor_id())
 				return;
@@ -237,7 +239,7 @@ void flush_dcache_page(struct page *page
 		}
 		set_dcache_dirty(page);
 	} else {
-		/* We could delay the flush for the !page->mapping
+		/* We could delay the flush for the !page_mapping
 		 * case too.  But that case is for exec env/arg
 		 * pages and those are %99 certainly going to get
 		 * faulted into the tlb (and thus flushed) anyways.
@@ -279,7 +281,7 @@ static inline void flush_cache_pte_range
 			if (!pfn_valid(pfn))
 				continue;
 			page = pfn_to_page(pfn);
-			if (PageReserved(page) || !page->mapping)
+			if (PageReserved(page) || !page_mapping(page))
 				continue;
 			pgaddr = (unsigned long) page_address(page);
 			uaddr = address + offset;
--- 2.6.5-aa1/include/asm-arm/cacheflush.h	2004-03-11 01:56:12.000000000 +0000
+++ linux/include/asm-arm/cacheflush.h	2004-04-04 11:49:41.000000000 +0100
@@ -283,7 +283,7 @@ flush_cache_page(struct vm_area_struct *
  * flush_dcache_page is used when the kernel has written to the page
  * cache page at virtual address page->virtual.
  *
- * If this page isn't mapped (ie, page->mapping = NULL), or it has
+ * If this page isn't mapped (ie, page_mapping == NULL), or it has
  * userspace mappings (page->mapping->i_mmap or page->mapping->i_mmap_shared)
  * then we _must_ always clean + invalidate the dcache entries associated
  * with the kernel mapping.
@@ -292,14 +292,18 @@ flush_cache_page(struct vm_area_struct *
  * about to change to user space.  This is the same method as used on SPARC64.
  * See update_mmu_cache for the user space part.
  */
-#define mapping_mapped(map)	(!list_empty(&(map)->i_mmap) || \
-				 !list_empty(&(map)->i_mmap_shared))
+static inline int mapping_mapped(struct address_space *mapping)
+{
+	return	!prio_tree_empty(&mapping->i_mmap) ||
+		!prio_tree_empty(&mapping->i_mmap_shared) ||
+		!list_empty(&mapping->i_mmap_nonlinear);
+}
 
 extern void __flush_dcache_page(struct page *);
 
 static inline void flush_dcache_page(struct page *page)
 {
-	if (page->mapping && !mapping_mapped(page->mapping))
+	if (page_mapping(page) && !mapping_mapped(page->mapping))
 		set_bit(PG_dcache_dirty, &page->flags);
 	else
 		__flush_dcache_page(page);
--- 2.6.5-aa1/include/asm-parisc/cacheflush.h	2003-10-08 20:24:57.000000000 +0100
+++ linux/include/asm-parisc/cacheflush.h	2004-04-04 11:49:41.000000000 +0100
@@ -65,12 +65,18 @@ flush_user_icache_range(unsigned long st
 #endif
 }
 
+static inline int mapping_mapped(struct address_space *mapping)
+{
+	return	!prio_tree_empty(&mapping->i_mmap) ||
+		!prio_tree_empty(&mapping->i_mmap_shared) ||
+		!list_empty(&mapping->i_mmap_nonlinear);
+}
+
 extern void __flush_dcache_page(struct page *page);
 
 static inline void flush_dcache_page(struct page *page)
 {
-	if (page->mapping && list_empty(&page->mapping->i_mmap) &&
-			list_empty(&page->mapping->i_mmap_shared)) {
+	if (page_mapping(page) && !mapping_mapped(page->mapping)) {
 		set_bit(PG_dcache_dirty, &page->flags);
 	} else {
 		__flush_dcache_page(page);
--- 2.6.5-aa1/include/asm-ppc64/pgalloc.h	2004-04-04 12:16:30.064142664 +0100
+++ linux/include/asm-ppc64/pgalloc.h	2004-04-01 21:34:58.000000000 +0100
@@ -71,6 +71,7 @@ pte_alloc_one(struct mm_struct *mm, unsi
 		ptepage->index = address & PMD_MASK;
 		return ptepage;
 	}
+	return NULL;
 }
 		
 static inline void pte_free_kernel(pte_t *pte)
--- 2.6.5-aa1/include/asm-sh/pgalloc.h	2004-02-04 02:45:26.000000000 +0000
+++ linux/include/asm-sh/pgalloc.h	2004-04-04 11:49:41.000000000 +0100
@@ -101,8 +101,9 @@ static inline pte_t ptep_get_and_clear(p
 		unsigned long pfn = pte_pfn(pte);
 		if (pfn_valid(pfn)) {
 			page = pfn_to_page(pfn);
-			if (!page->mapping
-			    || list_empty(&page->mapping->i_mmap_shared))
+			if (!page_mapping(page) ||
+			    (prio_tree_empty(&page->mapping->i_mmap_shared) &&
+			     list_empty(&page->mapping->i_mmap_nonlinear)))
 				__clear_bit(PG_mapped, &page->flags);
 		}
 	}

