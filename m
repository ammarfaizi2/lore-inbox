Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbUCRXd4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 18:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263331AbUCRXcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:32:53 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:62841 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263315AbUCRXXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:23:34 -0500
Date: Thu, 18 Mar 2004 23:23:24 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: linux-kernel@vger.kernel.org
Subject: [PATCH] anobjrmap 3/6 page->mapping
In-Reply-To: <Pine.LNX.4.44.0403182317050.16911-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0403182322480.16911-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

anobjrmap 3/6 free page->mapping for use by anon

Tracking anonymous pages by mm,address needs a pointer,offset
pair in struct page: mapping,index the natural choice.  However,
swapcache already uses them for &swapper_space,swp_entry_t.

But it's trivial to separate swapcache from pagecache with radix
tree; most of swapper_space is actually unused, just a fiction
to pretend swap like file; and page->private is a good place to
keep swp_entry_t now swap never uses bufferheads.

Define page_mapping(page) macro to give NULL when PageAnon,
whatever that may put in page->mapping; define PG_swapcache bit,
deduce swapper_space from that.  This does mean more conditionals
(many hidden in page_mapping), but I believe they'll be worth it.

Some arches refer to page->mapping for their cache flushing,
generally use page_mapping(page) instead: it appears that they're
coping with shared pagecache issues, rather than anon swap.

Sorry to lose another PG_ bit?  Don't worry, I'm sure we can
deduce PageSwapCache from PageAnon && private when tight; but
that will demand a little care with the Anon/Swap transitions,
at present they're pleasantly independent.  Who owns page->list,
Anon or Swap?  Dunno, at present neither, useful for testing.

Separating the caches slightly simplifies the tmpfs swizzling,
can use functions with fewer underscores since page can briefly
be in both caches.

Removed the unloved page_convert_anon for non-linear vmas, new rules
for PageAnon don't allow it to be abused for objects in that way:
non-linear freeing to be solved by a later patch, not in this group.
Similarly, I'm not calling those !page->mapping driver pages anon:
count them in and out, but don't attempt to unmap them (unless I'm
mistaken, they're usually pages a driver has allocated, has a
reference to, can't be freed anyway).

 arch/arm/mm/fault-armv.c        |    4 -
 arch/mips/mm/cache.c            |    6 -
 arch/parisc/kernel/cache.c      |    4 -
 arch/sparc64/kernel/smp.c       |    8 +-
 arch/sparc64/mm/init.c          |   12 +--
 fs/buffer.c                     |   20 +----
 include/asm-arm/cacheflush.h    |    4 -
 include/asm-parisc/cacheflush.h |    2 
 include/asm-sh/pgalloc.h        |    2 
 include/linux/mm.h              |   28 ++-----
 include/linux/page-flags.h      |   14 +--
 include/linux/pagemap.h         |   11 --
 include/linux/rmap.h            |    1 
 mm/filemap.c                    |   20 ++---
 mm/fremap.c                     |   16 ----
 mm/memory.c                     |   16 ++--
 mm/page-writeback.c             |   20 +++++
 mm/page_alloc.c                 |   14 +++
 mm/page_io.c                    |   19 +----
 mm/rmap.c                       |  133 ++++++-----------------------------
 mm/swap_state.c                 |  152 ++++++++++++++++++----------------------
 mm/swapfile.c                   |   20 +++--
 mm/vmscan.c                     |   33 ++++----
 23 files changed, 223 insertions(+), 336 deletions(-)

--- anobjrmap2/arch/arm/mm/fault-armv.c	2003-09-28 01:51:32.000000000 +0100
+++ anobjrmap3/arch/arm/mm/fault-armv.c	2004-03-18 21:27:03.794314896 +0000
@@ -191,7 +191,7 @@ void __flush_dcache_page(struct page *pa
 
 	__cpuc_flush_dcache_page(page_address(page));
 
-	if (!page->mapping)
+	if (!page_mapping(page))
 		return;
 
 	/*
@@ -292,7 +292,7 @@ void update_mmu_cache(struct vm_area_str
 	if (!pfn_valid(pfn))
 		return;
 	page = pfn_to_page(pfn);
-	if (page->mapping) {
+	if (page_mapping(page)) {
 		int dirty = test_and_clear_bit(PG_dcache_dirty, &page->flags);
 
 		if (dirty)
--- anobjrmap2/arch/mips/mm/cache.c	2004-03-11 01:56:08.000000000 +0000
+++ anobjrmap3/arch/mips/mm/cache.c	2004-03-18 21:27:03.795314744 +0000
@@ -57,7 +57,7 @@ void flush_dcache_page(struct page *page
 {
 	unsigned long addr;
 
-	if (page->mapping &&
+	if (page_mapping(page) &&
 	    list_empty(&page->mapping->i_mmap) &&
 	    list_empty(&page->mapping->i_mmap_shared)) {
 		SetPageDcacheDirty(page);
@@ -66,7 +66,7 @@ void flush_dcache_page(struct page *page
 	}
 
 	/*
-	 * We could delay the flush for the !page->mapping case too.  But that
+	 * We could delay the flush for the !page_mapping case too.  But that
 	 * case is for exec env/arg pages and those are %99 certainly going to
 	 * get faulted into the tlb (and thus flushed) anyways.
 	 */
@@ -81,7 +81,7 @@ void __update_cache(struct vm_area_struc
 	unsigned long pfn, addr;
 
 	pfn = pte_pfn(pte);
-	if (pfn_valid(pfn) && (page = pfn_to_page(pfn), page->mapping) &&
+	if (pfn_valid(pfn) && (page = pfn_to_page(pfn), page_mapping(page)) &&
 	    Page_dcache_dirty(page)) {
 		if (pages_do_alias((unsigned long)page_address(page),
 		                   address & PAGE_MASK)) {
--- anobjrmap2/arch/parisc/kernel/cache.c	2004-01-09 06:00:23.000000000 +0000
+++ anobjrmap3/arch/parisc/kernel/cache.c	2004-03-18 21:27:03.796314592 +0000
@@ -68,7 +68,7 @@ update_mmu_cache(struct vm_area_struct *
 {
 	struct page *page = pte_page(pte);
 
-	if (VALID_PAGE(page) && page->mapping &&
+	if (VALID_PAGE(page) && page_mapping(page) &&
 	    test_bit(PG_dcache_dirty, &page->flags)) {
 
 		flush_kernel_dcache_page(page_address(page));
@@ -234,7 +234,7 @@ void __flush_dcache_page(struct page *pa
 
 	flush_kernel_dcache_page(page_address(page));
 
-	if (!page->mapping)
+	if (!page_mapping(page))
 		return;
 	/* check shared list first if it's not empty...it's usually
 	 * the shortest */
--- anobjrmap2/arch/sparc64/kernel/smp.c	2004-03-16 07:00:18.257670408 +0000
+++ anobjrmap3/arch/sparc64/kernel/smp.c	2004-03-18 21:27:03.798314288 +0000
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
--- anobjrmap2/arch/sparc64/mm/init.c	2004-03-11 01:56:08.000000000 +0000
+++ anobjrmap3/arch/sparc64/mm/init.c	2004-03-18 21:27:03.801313832 +0000
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
 
@@ -227,7 +227,7 @@ void flush_dcache_page(struct page *page
 	int dirty = test_bit(PG_dcache_dirty, &page->flags);
 	int dirty_cpu = dcache_dirty_cpu(page);
 
-	if (page->mapping &&
+	if (page_mapping(page) &&
 	    list_empty(&page->mapping->i_mmap) &&
 	    list_empty(&page->mapping->i_mmap_shared)) {
 		if (dirty) {
@@ -237,7 +237,7 @@ void flush_dcache_page(struct page *page
 		}
 		set_dcache_dirty(page);
 	} else {
-		/* We could delay the flush for the !page->mapping
+		/* We could delay the flush for the !page_mapping
 		 * case too.  But that case is for exec env/arg
 		 * pages and those are %99 certainly going to get
 		 * faulted into the tlb (and thus flushed) anyways.
@@ -279,7 +279,7 @@ static inline void flush_cache_pte_range
 			if (!pfn_valid(pfn))
 				continue;
 			page = pfn_to_page(pfn);
-			if (PageReserved(page) || !page->mapping)
+			if (PageReserved(page) || !page_mapping(page))
 				continue;
 			pgaddr = (unsigned long) page_address(page);
 			uaddr = address + offset;
--- anobjrmap2/fs/buffer.c	2004-03-11 01:56:10.000000000 +0000
+++ anobjrmap3/fs/buffer.c	2004-03-18 21:27:03.805313224 +0000
@@ -837,19 +837,10 @@ EXPORT_SYMBOL(mark_buffer_dirty_inode);
  *
  * FIXME: may need to call ->reservepage here as well.  That's rather up to the
  * address_space though.
- *
- * For now, we treat swapper_space specially.  It doesn't use the normal
- * block a_ops.
  */
 int __set_page_dirty_buffers(struct page *page)
 {
 	struct address_space * const mapping = page->mapping;
-	int ret = 0;
-
-	if (mapping == NULL) {
-		SetPageDirty(page);
-		goto out;
-	}
 
 	spin_lock(&mapping->private_lock);
 	if (page_has_buffers(page)) {
@@ -878,8 +869,7 @@ int __set_page_dirty_buffers(struct page
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 	}
 	
-out:
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(__set_page_dirty_buffers);
 
@@ -1576,7 +1566,7 @@ static inline void discard_buffer(struct
  */
 int try_to_release_page(struct page *page, int gfp_mask)
 {
-	struct address_space * const mapping = page->mapping;
+	struct address_space * const mapping = page_mapping(page);
 
 	if (!PageLocked(page))
 		BUG();
@@ -2881,7 +2871,7 @@ failed:
 
 int try_to_free_buffers(struct page *page)
 {
-	struct address_space * const mapping = page->mapping;
+	struct address_space * const mapping = page_mapping(page);
 	struct buffer_head *buffers_to_free = NULL;
 	int ret = 0;
 
@@ -2889,14 +2879,14 @@ int try_to_free_buffers(struct page *pag
 	if (PageWriteback(page))
 		return 0;
 
-	if (mapping == NULL) {		/* swapped-in anon page */
+	if (mapping == NULL) {		/* can this still happen? */
 		ret = drop_buffers(page, &buffers_to_free);
 		goto out;
 	}
 
 	spin_lock(&mapping->private_lock);
 	ret = drop_buffers(page, &buffers_to_free);
-	if (ret && !PageSwapCache(page)) {
+	if (ret) {
 		/*
 		 * If the filesystem writes its buffers by hand (eg ext3)
 		 * then we can have clean buffers against a dirty page.  We
--- anobjrmap2/include/asm-arm/cacheflush.h	2004-03-11 01:56:12.000000000 +0000
+++ anobjrmap3/include/asm-arm/cacheflush.h	2004-03-18 21:27:03.807312920 +0000
@@ -283,7 +283,7 @@ flush_cache_page(struct vm_area_struct *
  * flush_dcache_page is used when the kernel has written to the page
  * cache page at virtual address page->virtual.
  *
- * If this page isn't mapped (ie, page->mapping = NULL), or it has
+ * If this page isn't mapped (ie, page_mapping == NULL), or it has
  * userspace mappings (page->mapping->i_mmap or page->mapping->i_mmap_shared)
  * then we _must_ always clean + invalidate the dcache entries associated
  * with the kernel mapping.
@@ -299,7 +299,7 @@ extern void __flush_dcache_page(struct p
 
 static inline void flush_dcache_page(struct page *page)
 {
-	if (page->mapping && !mapping_mapped(page->mapping))
+	if (page_mapping(page) && !mapping_mapped(page->mapping))
 		set_bit(PG_dcache_dirty, &page->flags);
 	else
 		__flush_dcache_page(page);
--- anobjrmap2/include/asm-parisc/cacheflush.h	2003-10-08 20:24:57.000000000 +0100
+++ anobjrmap3/include/asm-parisc/cacheflush.h	2004-03-18 21:27:03.808312768 +0000
@@ -69,7 +69,7 @@ extern void __flush_dcache_page(struct p
 
 static inline void flush_dcache_page(struct page *page)
 {
-	if (page->mapping && list_empty(&page->mapping->i_mmap) &&
+	if (page_mapping(page) && list_empty(&page->mapping->i_mmap) &&
 			list_empty(&page->mapping->i_mmap_shared)) {
 		set_bit(PG_dcache_dirty, &page->flags);
 	} else {
--- anobjrmap2/include/asm-sh/pgalloc.h	2004-02-04 02:45:26.000000000 +0000
+++ anobjrmap3/include/asm-sh/pgalloc.h	2004-03-18 21:27:03.808312768 +0000
@@ -101,7 +101,7 @@ static inline pte_t ptep_get_and_clear(p
 		unsigned long pfn = pte_pfn(pte);
 		if (pfn_valid(pfn)) {
 			page = pfn_to_page(pfn);
-			if (!page->mapping
+			if (!page_mapping(page)
 			    || list_empty(&page->mapping->i_mmap_shared))
 				__clear_bit(PG_mapped, &page->flags);
 		}
--- anobjrmap2/include/linux/mm.h	2004-03-18 21:26:40.787812416 +0000
+++ anobjrmap3/include/linux/mm.h	2004-03-18 21:27:03.810312464 +0000
@@ -396,6 +396,16 @@ void page_address_init(void);
 #endif
 
 /*
+ * On an anonymous page mapped into a user virtual memory area,
+ * page->mapping points to its anonmm, not to a struct address_space.
+ *
+ * Please note that, confusingly, "page_mapping" refers to the inode
+ * address_space which maps the page from disk; whereas "page_mapped"
+ * refers to user virtual address space into which the page is mapped.
+ */
+#define page_mapping(page) (PageAnon(page)? NULL: (page)->mapping)
+
+/*
  * Return true if this page is mapped into pagetables.  Subtle: test pte.direct
  * rather than pte.chain.  Because sometimes pte.direct is 64-bit, and .chain
  * is only 32-bit.
@@ -464,6 +474,7 @@ int get_user_pages(struct task_struct *t
 
 int __set_page_dirty_buffers(struct page *page);
 int __set_page_dirty_nobuffers(struct page *page);
+int set_page_dirty(struct page *page);
 int set_page_dirty_lock(struct page *page);
 
 /*
@@ -490,23 +501,6 @@ extern struct shrinker *set_shrinker(int
 extern void remove_shrinker(struct shrinker *shrinker);
 
 /*
- * If the mapping doesn't provide a set_page_dirty a_op, then
- * just fall through and assume that it wants buffer_heads.
- * FIXME: make the method unconditional.
- */
-static inline int set_page_dirty(struct page *page)
-{
-	if (page->mapping) {
-		int (*spd)(struct page *);
-
-		spd = page->mapping->a_ops->set_page_dirty;
-		if (spd)
-			return (*spd)(page);
-	}
-	return __set_page_dirty_buffers(page);
-}
-
-/*
  * On a two-level page table, this ends up being trivial. Thus the
  * inlining and the symmetry break with pte_alloc_map() that does all
  * of this out-of-line.
--- anobjrmap2/include/linux/page-flags.h	2004-03-18 21:26:40.789812112 +0000
+++ anobjrmap3/include/linux/page-flags.h	2004-03-18 21:27:03.812312160 +0000
@@ -75,8 +75,9 @@
 #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
 #define PG_reclaim		18	/* To be reclaimed asap */
 #define PG_compound		19	/* Part of a compound page */
-#define PG_anon			20	/* Anonymous page */
 
+#define PG_anon			20	/* Anonymous page: anonmm in mapping */
+#define PG_swapcache		21	/* Swap page: swp_entry_t in private */
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -306,15 +307,12 @@ extern void get_full_page_state(struct p
 #define SetPageAnon(page)	set_bit(PG_anon, &(page)->flags)
 #define ClearPageAnon(page)	clear_bit(PG_anon, &(page)->flags)
 
-/*
- * The PageSwapCache predicate doesn't use a PG_flag at this time,
- * but it may again do so one day.
- */
 #ifdef CONFIG_SWAP
-extern struct address_space swapper_space;
-#define PageSwapCache(page) ((page)->mapping == &swapper_space)
+#define PageSwapCache(page)	test_bit(PG_swapcache, &(page)->flags)
+#define SetPageSwapCache(page)	set_bit(PG_swapcache, &(page)->flags)
+#define ClearPageSwapCache(page) clear_bit(PG_swapcache, &(page)->flags)
 #else
-#define PageSwapCache(page) 0
+#define PageSwapCache(page)	0
 #endif
 
 struct page;	/* forward declaration */
--- anobjrmap2/include/linux/pagemap.h	2004-01-09 06:00:23.000000000 +0000
+++ anobjrmap3/include/linux/pagemap.h	2004-03-18 21:27:03.812312160 +0000
@@ -138,17 +138,6 @@ static inline unsigned long get_page_cac
         return atomic_read(&nr_pagecache);
 }
 
-static inline void ___add_to_page_cache(struct page *page,
-		struct address_space *mapping, unsigned long index)
-{
-	list_add(&page->list, &mapping->clean_pages);
-	page->mapping = mapping;
-	page->index = index;
-
-	mapping->nrpages++;
-	pagecache_acct(1);
-}
-
 extern void FASTCALL(__lock_page(struct page *page));
 extern void FASTCALL(unlock_page(struct page *page));
 
--- anobjrmap2/include/linux/rmap.h	2004-03-18 21:26:52.280065328 +0000
+++ anobjrmap3/include/linux/rmap.h	2004-03-18 21:27:03.813312008 +0000
@@ -26,7 +26,6 @@ static inline void pte_chain_free(struct
 struct pte_chain * fastcall
 	page_add_rmap(struct page *, pte_t *, struct pte_chain *);
 void fastcall page_remove_rmap(struct page *, pte_t *);
-int page_convert_anon(struct page *page);
 
 /*
  * Called from mm/vmscan.c to handle paging out
--- anobjrmap2/mm/filemap.c	2004-03-11 01:56:08.000000000 +0000
+++ anobjrmap3/mm/filemap.c	2004-03-18 21:27:03.816311552 +0000
@@ -118,10 +118,12 @@ void remove_from_page_cache(struct page 
 
 static inline int sync_page(struct page *page)
 {
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping = page_mapping(page);
 
 	if (mapping && mapping->a_ops && mapping->a_ops->sync_page)
 		return mapping->a_ops->sync_page(page);
+	if (PageSwapCache(page))
+		blk_run_queues();
 	return 0;
 }
 
@@ -235,13 +237,9 @@ EXPORT_SYMBOL(filemap_fdatawait);
  * This function is used for two things: adding newly allocated pagecache
  * pages and for moving existing anon pages into swapcache.
  *
- * In the case of pagecache pages, the page is new, so we can just run
- * SetPageLocked() against it.  The other page state flags were set by
- * rmqueue()
- *
- * In the case of swapcache, try_to_swap_out() has already locked the page, so
- * SetPageLocked() is ugly-but-OK there too.  The required page state has been
- * set up by swap_out_add_to_swap_cache().
+ * This function is used to add newly allocated pagecache pages:
+ * the page is new, so we can just run SetPageLocked() against it.
+ * The other page state flags were set by rmqueue().
  *
  * This function does not add the page to the LRU.  The caller must do that.
  */
@@ -256,7 +254,11 @@ int add_to_page_cache(struct page *page,
 		error = radix_tree_insert(&mapping->page_tree, offset, page);
 		if (!error) {
 			SetPageLocked(page);
-			___add_to_page_cache(page, mapping, offset);
+			list_add(&page->list, &mapping->clean_pages);
+			page->mapping = mapping;
+			page->index = offset;
+			mapping->nrpages++;
+			pagecache_acct(1);
 		} else {
 			page_cache_release(page);
 		}
--- anobjrmap2/mm/fremap.c	2004-03-18 21:26:52.282065024 +0000
+++ anobjrmap3/mm/fremap.c	2004-03-18 21:27:03.817311400 +0000
@@ -61,26 +61,11 @@ int install_page(struct mm_struct *mm, s
 	pmd_t *pmd;
 	pte_t pte_val;
 	struct pte_chain *pte_chain;
-	unsigned long pgidx;
 
 	pte_chain = pte_chain_alloc(GFP_KERNEL);
 	if (!pte_chain)
 		goto err;
 
-	/*
-	 * Convert this page to anon for objrmap if it's nonlinear
-	 */
-	pgidx = (addr - vma->vm_start) >> PAGE_SHIFT;
-	pgidx += vma->vm_pgoff;
-	pgidx >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;
-	if (!PageAnon(page) && (page->index != pgidx)) {
-		lock_page(page);
-		err = page_convert_anon(page);
-		unlock_page(page);
-		if (err < 0)
-			goto err_free;
-	}
-
 	pgd = pgd_offset(mm, addr);
 	spin_lock(&mm->page_table_lock);
 
@@ -105,7 +90,6 @@ int install_page(struct mm_struct *mm, s
 	err = 0;
 err_unlock:
 	spin_unlock(&mm->page_table_lock);
-err_free:
 	pte_chain_free(pte_chain);
 err:
 	return err;
--- anobjrmap2/mm/memory.c	2004-03-18 21:26:52.285064568 +0000
+++ anobjrmap3/mm/memory.c	2004-03-18 21:27:03.820310944 +0000
@@ -417,8 +417,8 @@ zap_pte_range(struct mmu_gather *tlb, pm
 				if (!PageReserved(page)) {
 					if (pte_dirty(pte))
 						set_page_dirty(page);
-					if (page->mapping && pte_young(pte) &&
-							!PageSwapCache(page))
+					if (pte_young(pte) &&
+							page_mapping(page))
 						mark_page_accessed(page);
 					tlb->freed++;
 					page_remove_rmap(page, ptep);
@@ -1422,6 +1422,7 @@ do_no_page(struct mm_struct *mm, struct 
 	struct pte_chain *pte_chain;
 	int sequence = 0;
 	int ret = VM_FAULT_MINOR;
+	int anon = 0;
 
 	if (!vma->vm_ops || !vma->vm_ops->nopage)
 		return do_anonymous_page(mm, vma, page_table,
@@ -1447,10 +1448,6 @@ retry:
 	if (!pte_chain)
 		goto oom;
 
-	/* See if nopage returned an anon page */
-	if (!new_page->mapping || PageSwapCache(new_page))
-		SetPageAnon(new_page);
-
 	/*
 	 * Should we do an early C-O-W break?
 	 */
@@ -1460,9 +1457,8 @@ retry:
 			goto oom;
 		copy_user_highpage(page, new_page, address);
 		page_cache_release(new_page);
-		lru_cache_add_active(page);
-		SetPageAnon(page);
 		new_page = page;
+		anon = 1;
 	}
 
 	spin_lock(&mm->page_table_lock);
@@ -1500,6 +1496,10 @@ retry:
 		if (write_access)
 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 		set_pte(page_table, entry);
+		if (anon) {
+			SetPageAnon(new_page);
+			lru_cache_add_active(new_page);
+		}
 		pte_chain = page_add_rmap(new_page, page_table, pte_chain);
 		pte_unmap(page_table);
 	} else {
--- anobjrmap2/mm/page-writeback.c	2004-02-04 02:45:34.000000000 +0000
+++ anobjrmap3/mm/page-writeback.c	2004-03-18 21:27:03.821310792 +0000
@@ -532,6 +532,24 @@ int __set_page_dirty_nobuffers(struct pa
 EXPORT_SYMBOL(__set_page_dirty_nobuffers);
 
 /*
+ * If the mapping doesn't provide a set_page_dirty a_op, then
+ * just fall through and assume that it wants buffer_heads.
+ */
+int set_page_dirty(struct page *page)
+{
+	struct address_space *mapping = page_mapping(page);
+	int (*spd)(struct page *);
+
+	if (!mapping) {
+		SetPageDirty(page);
+		return 0;
+	}
+	spd = mapping->a_ops->set_page_dirty;
+	return spd? (*spd)(page): __set_page_dirty_buffers(page);
+}
+EXPORT_SYMBOL(set_page_dirty);
+
+/*
  * set_page_dirty() is racy if the caller has no reference against
  * page->mapping->host, and if the page is unlocked.  This is because another
  * CPU could truncate the page off the mapping and then free the mapping.
@@ -559,7 +577,7 @@ EXPORT_SYMBOL(set_page_dirty_lock);
 int test_clear_page_dirty(struct page *page)
 {
 	if (TestClearPageDirty(page)) {
-		struct address_space *mapping = page->mapping;
+		struct address_space *mapping = page_mapping(page);
 
 		if (mapping && !mapping->backing_dev_info->memory_backed)
 			dec_page_state(nr_dirty);
--- anobjrmap2/mm/page_alloc.c	2004-03-18 21:26:40.796811048 +0000
+++ anobjrmap3/mm/page_alloc.c	2004-03-18 21:27:03.824310336 +0000
@@ -83,6 +83,10 @@ static void bad_page(const char *functio
 			1 << PG_lru	|
 			1 << PG_active	|
 			1 << PG_dirty	|
+			1 << PG_chainlock |
+			1 << PG_direct    |
+			1 << PG_anon      |
+			1 << PG_swapcache |
 			1 << PG_writeback);
 	set_page_count(page, 0);
 	page->mapping = NULL;
@@ -220,12 +224,14 @@ static inline void free_pages_check(cons
 			1 << PG_active	|
 			1 << PG_reclaim	|
 			1 << PG_slab	|
+			1 << PG_chainlock |
+			1 << PG_direct    |
+			1 << PG_anon      |
+			1 << PG_swapcache |
 			1 << PG_writeback )))
 		bad_page(function, page);
 	if (PageDirty(page))
 		ClearPageDirty(page);
-	if (PageAnon(page))
-		ClearPageAnon(page);
 }
 
 /*
@@ -329,6 +335,10 @@ static void prep_new_page(struct page *p
 			1 << PG_active	|
 			1 << PG_dirty	|
 			1 << PG_reclaim	|
+			1 << PG_chainlock |
+			1 << PG_direct    |
+			1 << PG_anon      |
+			1 << PG_swapcache |
 			1 << PG_writeback )))
 		bad_page(__FUNCTION__, page);
 
--- anobjrmap2/mm/page_io.c	2002-12-16 01:08:28.000000000 +0000
+++ anobjrmap3/mm/page_io.c	2004-03-18 21:27:03.825310184 +0000
@@ -16,8 +16,6 @@
 #include <linux/swap.h>
 #include <linux/bio.h>
 #include <linux/swapops.h>
-#include <linux/buffer_head.h>	/* for block_sync_page() */
-#include <linux/mpage.h>
 #include <linux/writeback.h>
 #include <asm/pgtable.h>
 
@@ -32,7 +30,7 @@ get_swap_bio(int gfp_flags, struct page 
 		swp_entry_t entry;
 
 		BUG_ON(!PageSwapCache(page));
-		entry.val = page->index;
+		entry.val = page->private;
 		sis = get_swap_info_struct(swp_type(entry));
 
 		bio->bi_sector = map_swap_page(sis, swp_offset(entry)) *
@@ -130,13 +128,6 @@ out:
 	return ret;
 }
 
-struct address_space_operations swap_aops = {
-	.writepage	= swap_writepage,
-	.readpage	= swap_readpage,
-	.sync_page	= block_sync_page,
-	.set_page_dirty	= __set_page_dirty_nobuffers,
-};
-
 /*
  * A scruffy utility function to read or write an arbitrary swap page
  * and wait on the I/O.
@@ -149,10 +140,8 @@ int rw_swap_page_sync(int rw, swp_entry_
 	};
 
 	lock_page(page);
-
-	BUG_ON(page->mapping);
-	page->mapping = &swapper_space;
-	page->index = entry.val;
+	SetPageSwapCache(page);
+	page->private = entry.val;
 
 	if (rw == READ) {
 		ret = swap_readpage(NULL, page);
@@ -161,7 +150,7 @@ int rw_swap_page_sync(int rw, swp_entry_
 		ret = swap_writepage(page, &swap_wbc);
 		wait_on_page_writeback(page);
 	}
-	page->mapping = NULL;
+	ClearPageSwapCache(page);
 	if (ret == 0 && (!PageUptodate(page) || PageError(page)))
 		ret = -EIO;
 	return ret;
--- anobjrmap2/mm/rmap.c	2004-03-18 21:26:52.290063808 +0000
+++ anobjrmap3/mm/rmap.c	2004-03-18 21:27:03.828309728 +0000
@@ -35,7 +35,18 @@
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
-/* #define DEBUG_RMAP */
+/*
+ * Something oopsable to put for now in the page->mapping
+ * of an anonymous page, to test that it is ignored.
+ */
+#define ANON_MAPPING_DEBUG	((struct address_space *) 1)
+
+static inline void clear_page_anon(struct page *page)
+{
+	BUG_ON(page->mapping != ANON_MAPPING_DEBUG);
+	page->mapping = NULL;
+	ClearPageAnon(page);
+}
 
 /*
  * Shared pages have a chain of pte_chain structures, used to locate
@@ -212,7 +223,7 @@ page_referenced_obj(struct page *page)
 		return 0;
 
 	if (!mapping)
-		BUG();
+		return 0;
 
 	if (PageSwapCache(page))
 		BUG();
@@ -316,8 +327,6 @@ page_add_rmap(struct page *page, pte_t *
  	 * find the mappings by walking the object vma chain for that object.
 	 */
 	if (!PageAnon(page)) {
-		if (!page->mapping)
-			BUG();
 		if (PageSwapCache(page))
 			BUG();
 		if (!page->pte.mapcount)
@@ -326,6 +335,8 @@ page_add_rmap(struct page *page, pte_t *
 		goto out;
 	}
 
+	page->mapping = ANON_MAPPING_DEBUG;
+
 	if (page->pte.direct == 0) {
 		page->pte.direct = pte_paddr;
 		SetPageDirect(page);
@@ -389,8 +400,6 @@ void fastcall page_remove_rmap(struct pa
 	 * find the mappings by walking the object vma chain for that object.
 	 */
 	if (!PageAnon(page)) {
-		if (!page->mapping)
-			BUG();
 		if (PageSwapCache(page))
 			BUG();
 		page->pte.mapcount--;
@@ -436,6 +445,8 @@ out:
 	if (!page_mapped(page)) {
 		if (page_test_and_clear_dirty(page))
 			set_page_dirty(page);
+		if (PageAnon(page))
+			clear_page_anon(page);
 		dec_page_state(nr_mapped);
 	}
 out_unlock:
@@ -590,12 +601,13 @@ static int fastcall try_to_unmap_one(str
 	flush_cache_page(vma, address);
 	pte = ptep_clear_flush(vma, address, ptep);
 
-	if (PageSwapCache(page)) {
+	if (PageAnon(page)) {
+		swp_entry_t entry = { .val = page->private };
 		/*
 		 * Store the swap location in the pte.
 		 * See handle_pte_fault() ...
 		 */
-		swp_entry_t entry = { .val = page->index };
+		BUG_ON(!PageSwapCache(page));
 		swap_duplicate(entry);
 		set_pte(ptep, swp_entry_to_pte(entry));
 		BUG_ON(pte_file(*ptep));
@@ -652,7 +664,7 @@ int fastcall try_to_unmap(struct page * 
 	if (!PageLocked(page))
 		BUG();
 	/* We need backing store to swap out a page. */
-	if (!page->mapping)
+	if (!page_mapping(page) && !PageSwapCache(page))
 		BUG();
 
 	/*
@@ -718,6 +730,8 @@ out:
 	if (!page_mapped(page)) {
 		if (page_test_and_clear_dirty(page))
 			set_page_dirty(page);
+		if (PageAnon(page))
+			clear_page_anon(page);
 		dec_page_state(nr_mapped);
 		ret = SWAP_SUCCESS;
 	}
@@ -725,107 +739,6 @@ out:
 }
 
 /**
- * page_convert_anon - Convert an object-based mapped page to pte_chain-based.
- * @page: the page to convert
- *
- * Find all the mappings for an object-based page and convert them
- * to 'anonymous', ie create a pte_chain and store all the pte pointers there.
- *
- * This function takes the address_space->i_shared_sem, sets the PageAnon flag,
- * then sets the mm->page_table_lock for each vma and calls page_add_rmap. This
- * means there is a period when PageAnon is set, but still has some mappings
- * with no pte_chain entry.  This is in fact safe, since page_remove_rmap will
- * simply not find it.  try_to_unmap might erroneously return success, but it
- * will never be called because the page_convert_anon() caller has locked the
- * page.
- *
- * page_referenced() may fail to scan all the appropriate pte's and may return
- * an inaccurate result.  This is so rare that it does not matter.
- */
-int page_convert_anon(struct page *page)
-{
-	struct address_space *mapping;
-	struct vm_area_struct *vma;
-	struct pte_chain *pte_chain = NULL;
-	pte_t *pte;
-	int err = 0;
-
-	mapping = page->mapping;
-	if (mapping == NULL)
-		goto out;		/* truncate won the lock_page() race */
-
-	down(&mapping->i_shared_sem);
-	pte_chain_lock(page);
-
-	/*
-	 * Has someone else done it for us before we got the lock?
-	 * If so, pte.direct or pte.chain has replaced pte.mapcount.
-	 */
-	if (PageAnon(page)) {
-		pte_chain_unlock(page);
-		goto out_unlock;
-	}
-
-	SetPageAnon(page);
-	if (page->pte.mapcount == 0) {
-		pte_chain_unlock(page);
-		goto out_unlock;
-	}
-	/* This is gonna get incremented by page_add_rmap */
-	dec_page_state(nr_mapped);
-	page->pte.mapcount = 0;
-
-	/*
-	 * Now that the page is marked as anon, unlock it.  page_add_rmap will
-	 * lock it as necessary.
-	 */
-	pte_chain_unlock(page);
-
-	list_for_each_entry(vma, &mapping->i_mmap, shared) {
-		if (!pte_chain) {
-			pte_chain = pte_chain_alloc(GFP_KERNEL);
-			if (!pte_chain) {
-				err = -ENOMEM;
-				goto out_unlock;
-			}
-		}
-		spin_lock(&vma->vm_mm->page_table_lock);
-		pte = find_pte(vma, page, NULL);
-		if (pte) {
-			/* Make sure this isn't a duplicate */
-			page_remove_rmap(page, pte);
-			pte_chain = page_add_rmap(page, pte, pte_chain);
-			pte_unmap(pte);
-		}
-		spin_unlock(&vma->vm_mm->page_table_lock);
-	}
-	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
-		if (!pte_chain) {
-			pte_chain = pte_chain_alloc(GFP_KERNEL);
-			if (!pte_chain) {
-				err = -ENOMEM;
-				goto out_unlock;
-			}
-		}
-		spin_lock(&vma->vm_mm->page_table_lock);
-		pte = find_pte(vma, page, NULL);
-		if (pte) {
-			/* Make sure this isn't a duplicate */
-			page_remove_rmap(page, pte);
-			pte_chain = page_add_rmap(page, pte, pte_chain);
-			pte_unmap(pte);
-		}
-		spin_unlock(&vma->vm_mm->page_table_lock);
-	}
-
-out_unlock:
-	pte_chain_free(pte_chain);
-	up(&mapping->i_shared_sem);
-out:
-	return err;
-}
-
-/**
  ** No more VM stuff below this comment, only pte_chain helper
  ** functions.
  **/
--- anobjrmap2/mm/swap_state.c	2003-08-09 05:44:10.000000000 +0100
+++ anobjrmap3/mm/swap_state.c	2004-03-18 21:27:03.830309424 +0000
@@ -21,23 +21,20 @@ static struct backing_dev_info swap_back
 	.memory_backed	= 1,	/* Does not contribute to dirty memory */
 };
 
-extern struct address_space_operations swap_aops;
+static struct address_space_operations swap_aops = {
+	.writepage	= swap_writepage,
+	.readpage	= swap_readpage,
+	/*
+	 * sync_page and set_page_dirty are special-cased.
+	 */
+};
 
 struct address_space swapper_space = {
 	.page_tree	= RADIX_TREE_INIT(GFP_ATOMIC),
 	.page_lock	= SPIN_LOCK_UNLOCKED,
-	.clean_pages	= LIST_HEAD_INIT(swapper_space.clean_pages),
-	.dirty_pages	= LIST_HEAD_INIT(swapper_space.dirty_pages),
-	.io_pages	= LIST_HEAD_INIT(swapper_space.io_pages),
-	.locked_pages	= LIST_HEAD_INIT(swapper_space.locked_pages),
+	.nrpages	= 0,
 	.a_ops		= &swap_aops,
 	.backing_dev_info = &swap_backing_dev_info,
-	.i_mmap		= LIST_HEAD_INIT(swapper_space.i_mmap),
-	.i_mmap_shared	= LIST_HEAD_INIT(swapper_space.i_mmap_shared),
-	.i_shared_sem	= __MUTEX_INITIALIZER(swapper_space.i_shared_sem),
-	.truncate_count  = ATOMIC_INIT(0),
-	.private_lock	= SPIN_LOCK_UNLOCKED,
-	.private_list	= LIST_HEAD_INIT(swapper_space.private_list),
 };
 
 #define INC_CACHE_INFO(x)	do { swap_cache_info.x++; } while (0)
@@ -59,30 +56,55 @@ void show_swap_cache_info(void)
 		swap_cache_info.noent_race, swap_cache_info.exist_race);
 }
 
+/*
+ * __add_to_swap_cache resembles add_to_page_cache on swapper_space,
+ * but sets SwapCache flag and private instead of mapping and index.
+ */
+static int __add_to_swap_cache(struct page *page,
+		swp_entry_t entry, int gfp_mask)
+{
+	int error;
+
+	BUG_ON(PageSwapCache(page));
+	BUG_ON(PagePrivate(page));
+	error = radix_tree_preload(gfp_mask);
+	if (!error) {
+		page_cache_get(page);
+		spin_lock(&swapper_space.page_lock);
+		error = radix_tree_insert(&swapper_space.page_tree,
+						entry.val, page);
+		if (!error) {
+			SetPageLocked(page);
+			SetPageSwapCache(page);
+			page->private = entry.val;
+			total_swapcache_pages++;
+			pagecache_acct(1);
+		} else
+			page_cache_release(page);
+		spin_unlock(&swapper_space.page_lock);
+		radix_tree_preload_end();
+	}
+	return error;
+}
+
 static int add_to_swap_cache(struct page *page, swp_entry_t entry)
 {
 	int error;
 
-	if (page->mapping)
-		BUG();
 	if (!swap_duplicate(entry)) {
 		INC_CACHE_INFO(noent_race);
 		return -ENOENT;
 	}
-	error = add_to_page_cache(page, &swapper_space, entry.val, GFP_KERNEL);
+	error = __add_to_swap_cache(page, entry, GFP_KERNEL);
 	/*
 	 * Anon pages are already on the LRU, we don't run lru_cache_add here.
 	 */
-	if (error != 0) {
+	if (error) {
 		swap_free(entry);
 		if (error == -EEXIST)
 			INC_CACHE_INFO(exist_race);
 		return error;
 	}
-	if (!PageLocked(page))
-		BUG();
-	if (!PageSwapCache(page))
-		BUG();
 	INC_CACHE_INFO(add_total);
 	return 0;
 }
@@ -96,7 +118,11 @@ void __delete_from_swap_cache(struct pag
 	BUG_ON(!PageLocked(page));
 	BUG_ON(!PageSwapCache(page));
 	BUG_ON(PageWriteback(page));
-	__remove_from_page_cache(page);
+
+	radix_tree_delete(&swapper_space.page_tree, page->private);
+	ClearPageSwapCache(page);
+	total_swapcache_pages--;
+	pagecache_acct(-1);
 	INC_CACHE_INFO(del_total);
 }
 
@@ -140,8 +166,7 @@ int add_to_swap(struct page * page)
 		/*
 		 * Add it to the swap cache and mark it dirty
 		 */
-		err = add_to_page_cache(page, &swapper_space,
-					entry.val, GFP_ATOMIC);
+		err = __add_to_swap_cache(page, entry, GFP_ATOMIC);
 
 		if (pf_flags & PF_MEMALLOC)
 			current->flags |= PF_MEMALLOC;
@@ -149,8 +174,7 @@ int add_to_swap(struct page * page)
 		switch (err) {
 		case 0:				/* Success */
 			SetPageUptodate(page);
-			ClearPageDirty(page);
-			set_page_dirty(page);
+			SetPageDirty(page);
 			INC_CACHE_INFO(add_total);
 			return 1;
 		case -EEXIST:
@@ -176,11 +200,12 @@ void delete_from_swap_cache(struct page 
 {
 	swp_entry_t entry;
 
+	BUG_ON(!PageSwapCache(page));
 	BUG_ON(!PageLocked(page));
 	BUG_ON(PageWriteback(page));
 	BUG_ON(PagePrivate(page));
   
-	entry.val = page->index;
+	entry.val = page->private;
 
 	spin_lock(&swapper_space.page_lock);
 	__delete_from_swap_cache(page);
@@ -192,27 +217,13 @@ void delete_from_swap_cache(struct page 
 
 int move_to_swap_cache(struct page *page, swp_entry_t entry)
 {
-	struct address_space *mapping = page->mapping;
-	int err;
-
-	spin_lock(&swapper_space.page_lock);
-	spin_lock(&mapping->page_lock);
-
-	err = radix_tree_insert(&swapper_space.page_tree, entry.val, page);
-	if (!err) {
-		__remove_from_page_cache(page);
-		___add_to_page_cache(page, &swapper_space, entry.val);
-	}
-
-	spin_unlock(&mapping->page_lock);
-	spin_unlock(&swapper_space.page_lock);
-
+	int err = __add_to_swap_cache(page, entry, GFP_ATOMIC);
 	if (!err) {
+		remove_from_page_cache(page);
+		page_cache_release(page);	/* pagecache ref */
 		if (!swap_duplicate(entry))
 			BUG();
-		/* shift page from clean_pages to dirty_pages list */
-		BUG_ON(PageDirty(page));
-		set_page_dirty(page);
+		SetPageDirty(page);
 		INC_CACHE_INFO(add_total);
 	} else if (err == -EEXIST)
 		INC_CACHE_INFO(exist_race);
@@ -222,29 +233,9 @@ int move_to_swap_cache(struct page *page
 int move_from_swap_cache(struct page *page, unsigned long index,
 		struct address_space *mapping)
 {
-	swp_entry_t entry;
-	int err;
-
-	BUG_ON(!PageLocked(page));
-	BUG_ON(PageWriteback(page));
-	BUG_ON(PagePrivate(page));
-
-	entry.val = page->index;
-
-	spin_lock(&swapper_space.page_lock);
-	spin_lock(&mapping->page_lock);
-
-	err = radix_tree_insert(&mapping->page_tree, index, page);
+	int err = add_to_page_cache(page, mapping, index, GFP_ATOMIC);
 	if (!err) {
-		__delete_from_swap_cache(page);
-		___add_to_page_cache(page, mapping, index);
-	}
-
-	spin_unlock(&mapping->page_lock);
-	spin_unlock(&swapper_space.page_lock);
-
-	if (!err) {
-		swap_free(entry);
+		delete_from_swap_cache(page);
 		/* shift page from clean_pages to dirty_pages list */
 		ClearPageDirty(page);
 		set_page_dirty(page);
@@ -252,7 +243,6 @@ int move_from_swap_cache(struct page *pa
 	return err;
 }
 
-
 /* 
  * If we are the only user, then try to free up the swap cache. 
  * 
@@ -310,19 +300,17 @@ void free_pages_and_swap_cache(struct pa
  */
 struct page * lookup_swap_cache(swp_entry_t entry)
 {
-	struct page *found;
+	struct page *page;
 
-	found = find_get_page(&swapper_space, entry.val);
-	/*
-	 * Unsafe to assert PageSwapCache and mapping on page found:
-	 * if SMP nothing prevents swapoff from deleting this page from
-	 * the swap cache at this moment.  find_lock_page would prevent
-	 * that, but no need to change: we _have_ got the right page.
-	 */
-	INC_CACHE_INFO(find_total);
-	if (found)
+	spin_lock(&swapper_space.page_lock);
+	page = radix_tree_lookup(&swapper_space.page_tree, entry.val);
+	if (page) {
+		page_cache_get(page);
 		INC_CACHE_INFO(find_success);
-	return found;
+	}
+	spin_unlock(&swapper_space.page_lock);
+	INC_CACHE_INFO(find_total);
+	return page;
 }
 
 /* 
@@ -340,10 +328,14 @@ struct page * read_swap_cache_async(swp_
 		/*
 		 * First check the swap cache.  Since this is normally
 		 * called after lookup_swap_cache() failed, re-calling
-		 * that would confuse statistics: use find_get_page()
-		 * directly.
+		 * that would confuse statistics.
 		 */
-		found_page = find_get_page(&swapper_space, entry.val);
+		spin_lock(&swapper_space.page_lock);
+		found_page = radix_tree_lookup(&swapper_space.page_tree,
+						entry.val);
+		if (found_page)
+			page_cache_get(found_page);
+		spin_unlock(&swapper_space.page_lock);
 		if (found_page)
 			break;
 
--- anobjrmap2/mm/swapfile.c	2004-03-18 21:26:52.292063504 +0000
+++ anobjrmap3/mm/swapfile.c	2004-03-18 21:27:03.832309120 +0000
@@ -247,7 +247,7 @@ static int exclusive_swap_page(struct pa
 	struct swap_info_struct * p;
 	swp_entry_t entry;
 
-	entry.val = page->index;
+	entry.val = page->private;
 	p = swap_info_get(entry);
 	if (p) {
 		/* Is the only swap cache user the cache itself? */
@@ -315,7 +315,7 @@ int remove_exclusive_swap_page(struct pa
 	if (page_count(page) != 2) /* 2: us + cache */
 		return 0;
 
-	entry.val = page->index;
+	entry.val = page->private;
 	p = swap_info_get(entry);
 	if (!p)
 		return 0;
@@ -353,8 +353,14 @@ void free_swap_and_cache(swp_entry_t ent
 
 	p = swap_info_get(entry);
 	if (p) {
-		if (swap_entry_free(p, swp_offset(entry)) == 1)
-			page = find_trylock_page(&swapper_space, entry.val);
+		if (swap_entry_free(p, swp_offset(entry)) == 1) {
+			spin_lock(&swapper_space.page_lock);
+			page = radix_tree_lookup(&swapper_space.page_tree,
+				entry.val);
+			if (page && TestSetPageLocked(page))
+				page = NULL;
+			spin_unlock(&swapper_space.page_lock);
+		}
 		swap_info_put(p);
 	}
 	if (page) {
@@ -997,14 +1003,14 @@ int page_queue_congested(struct page *pa
 
 	BUG_ON(!PageLocked(page));	/* It pins the swap_info_struct */
 
-	bdi = page->mapping->backing_dev_info;
 	if (PageSwapCache(page)) {
-		swp_entry_t entry = { .val = page->index };
+		swp_entry_t entry = { .val = page->private };
 		struct swap_info_struct *sis;
 
 		sis = get_swap_info_struct(swp_type(entry));
 		bdi = sis->bdev->bd_inode->i_mapping->backing_dev_info;
-	}
+	} else
+		bdi = page->mapping->backing_dev_info;
 	return bdi_write_congested(bdi);
 }
 #endif
--- anobjrmap2/mm/vmscan.c	2004-03-18 21:26:52.294063200 +0000
+++ anobjrmap3/mm/vmscan.c	2004-03-18 21:27:03.835308664 +0000
@@ -174,20 +174,20 @@ static int shrink_slab(unsigned long sca
 /* Must be called with page's pte_chain_lock held. */
 static inline int page_mapping_inuse(struct page *page)
 {
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping;
 
 	/* Page is in somebody's page tables. */
 	if (page_mapped(page))
 		return 1;
 
-	/* XXX: does this happen ? */
-	if (!mapping)
-		return 0;
-
 	/* Be more reluctant to reclaim swapcache than pagecache */
 	if (PageSwapCache(page))
 		return 1;
 
+	mapping = page_mapping(page);
+	if (!mapping)
+		return 0;
+
 	/* File is mmap'd by somebody. */
 	if (!list_empty(&mapping->i_mmap))
 		return 1;
@@ -231,7 +231,7 @@ static void handle_write_error(struct ad
 				struct page *page, int error)
 {
 	lock_page(page);
-	if (page->mapping == mapping) {
+	if (page_mapping(page) == mapping) {
 		if (error == -ENOSPC)
 			set_bit(AS_ENOSPC, &mapping->flags);
 		else
@@ -283,21 +283,23 @@ shrink_list(struct list_head *page_list,
 			goto activate_locked;
 		}
 
-		mapping = page->mapping;
+		mapping = page_mapping(page);
 
 #ifdef CONFIG_SWAP
 		/*
-		 * Anonymous process memory without backing store. Try to
-		 * allocate it some swap space here.
+		 * Anonymous process memory has backing store?
+		 * Try to allocate it some swap space here.
 		 *
 		 * XXX: implement swap clustering ?
 		 */
-		if (page_mapped(page) && !mapping && !PagePrivate(page)) {
+		if (PageSwapCache(page))
+			mapping = &swapper_space;
+		else if (PageAnon(page)) {
 			pte_chain_unlock(page);
 			if (!add_to_swap(page))
 				goto activate_locked;
 			pte_chain_lock(page);
-			mapping = page->mapping;
+			mapping = &swapper_space;
 		}
 #endif /* CONFIG_SWAP */
 
@@ -362,7 +364,9 @@ shrink_list(struct list_head *page_list,
 					.for_reclaim = 1,
 				};
 
-				list_move(&page->list, &mapping->locked_pages);
+				if (!PageSwapCache(page))
+					list_move(&page->list,
+						&mapping->locked_pages);
 				spin_unlock(&mapping->page_lock);
 
 				SetPageReclaim(page);
@@ -427,7 +431,7 @@ shrink_list(struct list_head *page_list,
 
 #ifdef CONFIG_SWAP
 		if (PageSwapCache(page)) {
-			swp_entry_t swap = { .val = page->index };
+			swp_entry_t swap = { .val = page->private };
 			__delete_from_swap_cache(page);
 			spin_unlock(&mapping->page_lock);
 			swap_free(swap);
@@ -668,8 +672,7 @@ refill_inactive_zone(struct zone *zone, 
 		 * FIXME: need to consider page_count(page) here if/when we
 		 * reap orphaned pages via the LRU (Daniel's locking stuff)
 		 */
-		if (total_swap_pages == 0 && !page->mapping &&
-						!PagePrivate(page)) {
+		if (total_swap_pages == 0 && PageAnon(page)) {
 			list_add(&page->lru, &l_active);
 			continue;
 		}

