Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263224AbTCTXC0>; Thu, 20 Mar 2003 18:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263230AbTCTXC0>; Thu, 20 Mar 2003 18:02:26 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:63625 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S263224AbTCTXBP>; Thu, 20 Mar 2003 18:01:15 -0500
Date: Thu, 20 Mar 2003 23:14:02 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>
Subject: [PATCH] anobjrmap 2/6 mapping
In-Reply-To: <Pine.LNX.4.44.0303202310440.2743-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303202312560.2743-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

anobjrmap 2/6 free page->mapping for use by anon

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

Sorry to lose another PG_ bit?  Don't worry, I'm sure we can
deduce PageSwapCache from PageAnon && private when tight; but
that will demand a little care with the Anon/Swap transitions,
at present they're pleasantly independent.  Who owns page->list,
Anon or Swap?  Dunno, at present neither, useful for testing.

Separating the caches slightly simplifies the tmpfs swizzling,
can use functions with fewer underscores since page can briefly
be in both caches.  I've taken the liberty of moving a
page_cache_release into remove_from_page_cache,
and getting rid of ___add_to_page_cache.

Seemed natural to add nr_swapcache separate from nr_pagecache;
but if that poses a vmstat compatibility problem, easily reverted.
Similarly, natural to remove the total_swapcache_pages double
counting bogosity from vm_enough_memory: it dates from a time
when we didn't free the swap when a swapcache page was freed
(but though bogus in 2.4 also, I'd hesitate to change it there).

It is likely that I've screwed up on the "Morton pages", those
ext3 journal pages locked at truncate time which then turn into
fish with wings: please check them out, I never manage to wrap
my head around them.  Certainly don't want a page using private
for both bufferheads and swp_entry_t.

Although these patches are for applying to 2.5.65-mm2, they're
really based the version of rmap.c before Dave added the lovely
but flawed find_pte (sorry, you _need_ page_table_lock), and
the very unlovely page_convert_anon.  My idea for anon pages
doesn't let them be in the pagecache too, so I've had to erase
page_convert_anon in this patch (sys_remap_file pages will get
lost until freed, as if locked): 5/6 then puts that right.

Similarly, I'm not calling those !page->mapping driver pages
anon: count them in and out, but don't attempt to unmap them
(unless I'm mistaken, they're usually pages a driver has
allocated, has a reference to, can't be freed anyway).

In passing, noticed shrink_list's CONFIG_SWAP was excluding
try_to_unmap of file-backed pages, surely that's wrong?
Moved its #endif up to allow them; but suspect !CONFIG_MMU
was relying on !CONFIG_SWAP there?  So added a try_to_unmap
stub in linux/rmap.h; but I've not tested these configs.

 fs/buffer.c                |   14 +---
 fs/proc/proc_misc.c        |    4 -
 include/linux/mm.h         |   28 +++-----
 include/linux/page-flags.h |   16 ++--
 include/linux/pagemap.h    |   11 ---
 include/linux/rmap.h       |   14 ++--
 include/linux/swap.h       |    3 
 mm/filemap.c               |   29 ++++----
 mm/fremap.c                |   10 --
 mm/memory.c                |   13 +--
 mm/mmap.c                  |    8 --
 mm/page-writeback.c        |   32 +++++----
 mm/page_alloc.c            |   17 ++++
 mm/page_io.c               |   19 +----
 mm/rmap.c                  |  155 +++++++++------------------------------------
 mm/swap_state.c            |  152 ++++++++++++++++++++------------------------
 mm/swapfile.c              |   21 +++---
 mm/truncate.c              |    1 
 mm/vmscan.c                |   32 +++++----
 19 files changed, 224 insertions(+), 355 deletions(-)

--- anobjrmap1/fs/buffer.c	Wed Mar 19 11:05:11 2003
+++ anobjrmap2/fs/buffer.c	Thu Mar 20 17:10:01 2003
@@ -1457,7 +1457,7 @@
  */
 int try_to_release_page(struct page *page, int gfp_mask)
 {
-	struct address_space * const mapping = page->mapping;
+	struct address_space * const mapping = page_mapping(page);
 
 	if (!PageLocked(page))
 		BUG();
@@ -2717,22 +2717,18 @@
 
 int try_to_free_buffers(struct page *page)
 {
-	struct address_space * const mapping = page->mapping;
+	struct address_space * const mapping = page_mapping(page);
 	struct buffer_head *buffers_to_free = NULL;
 	int ret = 0;
 
+	BUG_ON(!mapping);
 	BUG_ON(!PageLocked(page));
 	if (PageWriteback(page))
 		return 0;
 
-	if (mapping == NULL) {		/* swapped-in anon page */
-		ret = drop_buffers(page, &buffers_to_free);
-		goto out;
-	}
-
 	spin_lock(&mapping->private_lock);
 	ret = drop_buffers(page, &buffers_to_free);
-	if (ret && !PageSwapCache(page)) {
+	if (ret) {
 		/*
 		 * If the filesystem writes its buffers by hand (eg ext3)
 		 * then we can have clean buffers against a dirty page.  We
@@ -2744,7 +2740,7 @@
 		clear_page_dirty(page);
 	}
 	spin_unlock(&mapping->private_lock);
-out:
+
 	if (buffers_to_free) {
 		struct buffer_head *bh = buffers_to_free;
 
--- anobjrmap1/fs/proc/proc_misc.c	Wed Mar 19 11:05:11 2003
+++ anobjrmap2/fs/proc/proc_misc.c	Thu Mar 20 17:10:01 2003
@@ -182,8 +182,8 @@
 		K(i.totalram),
 		K(i.freeram),
 		K(i.bufferram),
-		K(ps.nr_pagecache-total_swapcache_pages-i.bufferram),
-		K(total_swapcache_pages),
+		K(ps.nr_pagecache-i.bufferram),
+		K(ps.nr_swapcache),
 		K(active),
 		K(inactive),
 		K(i.totalhigh),
--- anobjrmap1/include/linux/mm.h	Wed Mar 19 11:05:15 2003
+++ anobjrmap2/include/linux/mm.h	Thu Mar 20 17:10:01 2003
@@ -363,6 +363,16 @@
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
@@ -430,6 +440,7 @@
 
 int __set_page_dirty_buffers(struct page *page);
 int __set_page_dirty_nobuffers(struct page *page);
+int set_page_dirty(struct page *page);
 int set_page_dirty_lock(struct page *page);
 
 /*
@@ -456,23 +467,6 @@
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
--- anobjrmap1/include/linux/page-flags.h	Wed Mar 19 11:05:15 2003
+++ anobjrmap2/include/linux/page-flags.h	Thu Mar 20 17:10:01 2003
@@ -74,7 +74,9 @@
 #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
 #define PG_reclaim		18	/* To be reclaimed asap */
 #define PG_compound		19	/* Part of a compound page */
-#define PG_anon			20	/* Anonymous page */
+
+#define PG_anon			20	/* Anonymous page: anonmm in mapping */
+#define PG_swapcache		21	/* Swap page: swp_entry_t in private */
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -84,6 +86,7 @@
 	unsigned long nr_dirty;		/* Dirty writeable pages */
 	unsigned long nr_writeback;	/* Pages under writeback */
 	unsigned long nr_pagecache;	/* Pages in pagecache */
+	unsigned long nr_swapcache;	/* Pages in swapcache */
 	unsigned long nr_page_table_pages;/* Pages used for pagetables */
 	unsigned long nr_reverse_maps;	/* includes PageDirect */
 	unsigned long nr_mapped;	/* mapped into pagetables */
@@ -261,15 +264,12 @@
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
--- anobjrmap1/include/linux/pagemap.h	Tue Feb 18 02:14:25 2003
+++ anobjrmap2/include/linux/pagemap.h	Thu Mar 20 17:10:01 2003
@@ -74,17 +74,6 @@
 extern void remove_from_page_cache(struct page *page);
 extern void __remove_from_page_cache(struct page *page);
 
-static inline void ___add_to_page_cache(struct page *page,
-		struct address_space *mapping, unsigned long index)
-{
-	list_add(&page->list, &mapping->clean_pages);
-	page->mapping = mapping;
-	page->index = index;
-
-	mapping->nrpages++;
-	inc_page_state(nr_pagecache);
-}
-
 extern void FASTCALL(__lock_page(struct page *page));
 extern void FASTCALL(unlock_page(struct page *page));
 
--- anobjrmap1/include/linux/rmap.h	Thu Mar 20 17:09:50 2003
+++ anobjrmap2/include/linux/rmap.h	Thu Mar 20 17:10:01 2003
@@ -22,7 +22,6 @@
 struct pte_chain *FASTCALL(
 	page_add_rmap(struct page *, pte_t *, struct pte_chain *));
 void FASTCALL(page_remove_rmap(struct page *, pte_t *));
-void page_convert_anon(struct page *page);
 
 /*
  * Called from mm/vmscan.c to handle paging out
@@ -30,6 +29,13 @@
 int FASTCALL(page_referenced(struct page *));
 int FASTCALL(try_to_unmap(struct page *));
 
+#else	/* !CONFIG_MMU */
+
+#define page_referenced(page)	TestClearPageReferenced(page)
+#define try_to_unmap(page)	SWAP_FAIL
+
+#endif /* CONFIG_MMU */
+
 /*
  * Return values of try_to_unmap
  */
@@ -37,12 +43,6 @@
 #define SWAP_AGAIN	1
 #define SWAP_FAIL	2
 
-#else	/* !CONFIG_MMU */
-
-#define page_referenced(page)	TestClearPageReferenced(page)
-
-#endif /* CONFIG_MMU */
-
 static inline void pte_chain_lock(struct page *page)
 {
 	/*
--- anobjrmap1/include/linux/swap.h	Thu Mar 20 17:09:50 2003
+++ anobjrmap2/include/linux/swap.h	Thu Mar 20 17:10:01 2003
@@ -179,9 +179,7 @@
 
 /* linux/mm/swap_state.c */
 extern struct address_space swapper_space;
-#define total_swapcache_pages  swapper_space.nrpages
 extern void show_swap_cache_info(void);
-extern int add_to_swap_cache(struct page *, swp_entry_t);
 extern int add_to_swap(struct page *);
 extern void __delete_from_swap_cache(struct page *);
 extern void delete_from_swap_cache(struct page *);
@@ -219,7 +217,6 @@
 #else /* CONFIG_SWAP */
 
 #define total_swap_pages			0
-#define total_swapcache_pages			0UL
 
 #define si_swapinfo(val) \
 	do { (val)->freeswap = (val)->totalswap = 0; } while (0)
--- anobjrmap1/mm/filemap.c	Wed Mar 19 11:05:16 2003
+++ anobjrmap2/mm/filemap.c	Thu Mar 20 17:10:01 2003
@@ -81,7 +81,7 @@
 {
 	struct address_space *mapping = page->mapping;
 
-	BUG_ON(PageDirty(page) && !PageSwapCache(page));
+	BUG_ON(PageDirty(page));
 
 	radix_tree_delete(&mapping->page_tree, page->index);
 	list_del(&page->list);
@@ -95,20 +95,22 @@
 {
 	struct address_space *mapping = page->mapping;
 
-	if (unlikely(!PageLocked(page)))
-		PAGE_BUG(page);
+	BUG_ON(!PageLocked(page));
 
 	write_lock(&mapping->page_lock);
 	__remove_from_page_cache(page);
 	write_unlock(&mapping->page_lock);
+	page_cache_release(page);
 }
 
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
 
@@ -192,16 +194,9 @@
  * This adds a page to the page cache, starting out as locked, unreferenced,
  * not uptodate and with no errors.
  *
- * This function is used for two things: adding newly allocated pagecache
- * pages and for moving existing anon pages into swapcache.
- *
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
@@ -216,7 +211,11 @@
 		error = radix_tree_insert(&mapping->page_tree, offset, page);
 		if (!error) {
 			SetPageLocked(page);
-			___add_to_page_cache(page, mapping, offset);
+			list_add(&page->list, &mapping->clean_pages);
+			page->mapping = mapping;
+			page->index = offset;
+			mapping->nrpages++;
+			inc_page_state(nr_pagecache);
 		} else {
 			page_cache_release(page);
 		}
--- anobjrmap1/mm/fremap.c	Thu Mar 20 17:09:50 2003
+++ anobjrmap2/mm/fremap.c	Thu Mar 20 17:10:01 2003
@@ -57,21 +57,11 @@
 	pgd_t *pgd;
 	pmd_t *pmd;
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
-	if (!PageAnon(page) && (page->index != pgidx))
-		page_convert_anon(page);
-
 	pgd = pgd_offset(mm, addr);
 	spin_lock(&mm->page_table_lock);
 
--- anobjrmap1/mm/memory.c	Thu Mar 20 17:09:50 2003
+++ anobjrmap2/mm/memory.c	Thu Mar 20 17:10:01 2003
@@ -419,8 +419,8 @@
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
@@ -1329,6 +1329,7 @@
 	struct page * new_page;
 	pte_t entry;
 	struct pte_chain *pte_chain;
+	int anon = 0;
 	int ret;
 
 	if (!vma->vm_ops || !vma->vm_ops->nopage)
@@ -1349,10 +1350,6 @@
 	if (!pte_chain)
 		goto oom;
 
-	/* See if nopage returned an anon page */
-	if (!new_page->mapping || PageSwapCache(new_page))
-		SetPageAnon(new_page);
-
 	/*
 	 * Should we do an early C-O-W break?
 	 */
@@ -1365,8 +1362,8 @@
 		copy_user_highpage(page, new_page, address);
 		page_cache_release(new_page);
 		lru_cache_add_active(page);
-		SetPageAnon(page);
 		new_page = page;
+		anon = 1;
 	}
 
 	spin_lock(&mm->page_table_lock);
@@ -1391,6 +1388,8 @@
 		if (write_access)
 			entry = pte_mkwrite(pte_mkdirty(entry));
 		set_pte(page_table, entry);
+		if (anon)
+			SetPageAnon(new_page);
 		pte_chain = page_add_rmap(new_page, page_table, pte_chain);
 		pte_unmap(page_table);
 	} else {
--- anobjrmap1/mm/mmap.c	Wed Mar 19 11:05:16 2003
+++ anobjrmap2/mm/mmap.c	Thu Mar 20 17:10:01 2003
@@ -82,14 +82,6 @@
 		free += nr_swap_pages;
 
 		/*
-		 * This double-counts: the nrpages are both in the
-		 * page-cache and in the swapper space. At the same time,
-		 * this compensates for the swap-space over-allocation
-		 * (ie "nr_swap_pages" being too small).
-		 */
-		free += total_swapcache_pages;
-
-		/*
 		 * The code below doesn't account for free space in the
 		 * inode and dentry slab cache, slab cache fragmentation,
 		 * inodes and dentries which will become freeable under
--- anobjrmap1/mm/page-writeback.c	Tue Mar 18 07:38:45 2003
+++ anobjrmap2/mm/page-writeback.c	Thu Mar 20 17:10:01 2003
@@ -477,21 +477,12 @@
  * FIXME: may need to call ->reservepage here as well.  That's rather up to the
  * address_space though.
  *
- * For now, we treat swapper_space specially.  It doesn't use the normal
- * block a_ops.
- *
  * FIXME: this should move over to fs/buffer.c - buffer_heads have no business in mm/
  */
 #include <linux/buffer_head.h>
 int __set_page_dirty_buffers(struct page *page)
 {
 	struct address_space * const mapping = page->mapping;
-	int ret = 0;
-
-	if (mapping == NULL) {
-		SetPageDirty(page);
-		goto out;
-	}
 
 	if (!PageUptodate(page))
 		buffer_error();
@@ -523,8 +514,7 @@
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 	}
 	
-out:
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(__set_page_dirty_buffers);
 
@@ -566,6 +556,24 @@
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
@@ -592,7 +600,7 @@
 int test_clear_page_dirty(struct page *page)
 {
 	if (TestClearPageDirty(page)) {
-		struct address_space *mapping = page->mapping;
+		struct address_space *mapping = page_mapping(page);
 
 		if (mapping && !mapping->backing_dev_info->memory_backed)
 			dec_page_state(nr_dirty);
--- anobjrmap1/mm/page_alloc.c	Wed Mar 19 11:05:16 2003
+++ anobjrmap2/mm/page_alloc.c	Thu Mar 20 17:10:01 2003
@@ -80,6 +80,10 @@
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
@@ -216,12 +220,14 @@
 			1 << PG_locked	|
 			1 << PG_active	|
 			1 << PG_reclaim	|
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
@@ -322,6 +328,10 @@
 			1 << PG_active	|
 			1 << PG_dirty	|
 			1 << PG_reclaim	|
+			1 << PG_chainlock |
+			1 << PG_direct    |
+			1 << PG_anon      |
+			1 << PG_swapcache |
 			1 << PG_writeback )))
 		bad_page(__FUNCTION__, page);
 
@@ -869,7 +879,7 @@
 	struct page_state ps;
 
 	get_page_state(&ps);
-	return ps.nr_pagecache;
+	return ps.nr_pagecache + ps.nr_swapcache;
 }
 
 void si_meminfo(struct sysinfo *val)
@@ -1442,6 +1452,7 @@
 	"nr_dirty",
 	"nr_writeback",
 	"nr_pagecache",
+	"nr_swapcache",
 	"nr_page_table_pages",
 	"nr_reverse_maps",
 	"nr_mapped",
--- anobjrmap1/mm/page_io.c	Mon Dec 16 10:37:02 2002
+++ anobjrmap2/mm/page_io.c	Thu Mar 20 17:10:01 2003
@@ -16,8 +16,6 @@
 #include <linux/swap.h>
 #include <linux/bio.h>
 #include <linux/swapops.h>
-#include <linux/buffer_head.h>	/* for block_sync_page() */
-#include <linux/mpage.h>
 #include <linux/writeback.h>
 #include <asm/pgtable.h>
 
@@ -32,7 +30,7 @@
 		swp_entry_t entry;
 
 		BUG_ON(!PageSwapCache(page));
-		entry.val = page->index;
+		entry.val = page->private;
 		sis = get_swap_info_struct(swp_type(entry));
 
 		bio->bi_sector = map_swap_page(sis, swp_offset(entry)) *
@@ -130,13 +128,6 @@
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
@@ -149,10 +140,8 @@
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
@@ -161,7 +150,7 @@
 		ret = swap_writepage(page, &swap_wbc);
 		wait_on_page_writeback(page);
 	}
-	page->mapping = NULL;
+	ClearPageSwapCache(page);
 	if (ret == 0 && (!PageUptodate(page) || PageError(page)))
 		ret = -EIO;
 	return ret;
--- anobjrmap1/mm/rmap.c	Thu Mar 20 17:09:50 2003
+++ anobjrmap2/mm/rmap.c	Thu Mar 20 17:10:01 2003
@@ -37,6 +37,20 @@
 /* #define DEBUG_RMAP */
 
 /*
+ * Something oopsable to put for now in the page->mapping
+ * of an anonymous page, to test that it is ignored.
+ */
+#define ANON_MAPPING_DEBUG	((struct address_space *) 1)
+
+static inline void
+clear_page_anon(struct page *page)
+{
+	BUG_ON(page->mapping != ANON_MAPPING_DEBUG);
+	page->mapping = NULL;
+	ClearPageAnon(page);
+}
+
+/*
  * Shared pages have a chain of pte_chain structures, used to locate
  * all the mappings to this page. We only need a pointer to the pte
  * here, the page struct for the page table page contains the process
@@ -185,7 +199,7 @@
 		return 0;
 
 	if (!mapping)
-		BUG();
+		return 0;
 
 	if (PageSwapCache(page))
 		BUG();
@@ -298,8 +312,6 @@
 	 * find the mappings by walking the object vma chain for that object.
 	 */
 	if (!PageAnon(page)) {
-		if (!page->mapping)
-			BUG();
 		if (PageSwapCache(page))
 			BUG();
 		if (!page->pte.mapcount)
@@ -331,6 +343,8 @@
 	}
 #endif
 
+	page->mapping = ANON_MAPPING_DEBUG;
+
 	if (page->pte.direct == 0) {
 		page->pte.direct = pte_paddr;
 		SetPageDirect(page);
@@ -392,8 +406,6 @@
 		BUG();
 	if (!pfn_valid(page_to_pfn(page)) || PageReserved(page))
 		return;
-	if (!page_mapped(page))
-		return;		/* remap_page_range() from a driver? */
 
 	pte_chain_lock(page);
 
@@ -402,8 +414,6 @@
 	 * find the mappings by walking the object vma chain for that object.
 	 */
 	if (!PageAnon(page)) {
-		if (!page->mapping)
-			BUG();
 		if (PageSwapCache(page))
 			BUG();
 		if (!page->pte.mapcount)
@@ -472,10 +482,11 @@
 #endif
 
 out:
-	pte_chain_unlock(page);
-	if (!page_mapped(page))
+	if (!page_mapped(page)) {
 		dec_page_state(nr_mapped);
-	return;
+		clear_page_anon(page);
+	}
+	pte_chain_unlock(page);
 }
 
 /**
@@ -565,8 +576,9 @@
 			goto out;
 	}
 
+	/* We lose track of sys_remap_file pages (for now) */
 	if (page->pte.mapcount)
-		BUG();
+		ret = SWAP_FAIL;
 
 out:
 	up(&mapping->i_shared_sem);
@@ -628,12 +640,13 @@
 	pte = ptep_get_and_clear(ptep);
 	flush_tlb_page(vma, address);
 
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
@@ -690,7 +703,7 @@
 	if (!PageLocked(page))
 		BUG();
 	/* We need backing store to swap out a page. */
-	if (!page->mapping)
+	if (!page_mapping(page) && !PageSwapCache(page))
 		BUG();
 
 	/*
@@ -757,118 +770,12 @@
 		}
 	}
 out:
-	if (!page_mapped(page))
+	if (!page_mapped(page)) {
 		dec_page_state(nr_mapped);
-	return ret;
-}
-
-/**
- * page_convert_anon - Convert an object-based mapped page to pte_chain-based.
- * @page: the page to convert
- *
- * Find all the mappings for an object-based page and convert them
- * to 'anonymous', ie create a pte_chain and store all the pte pointers there.
- *
- * This function takes the address_space->i_shared_sem and the pte_chain_lock
- * for the page.  It jumps through some hoops to preallocate the correct number
- * of pte_chain structures to ensure that it can complete without releasing
- * the lock.
- */
-void page_convert_anon(struct page *page)
-{
-	struct address_space *mapping = page->mapping;
-	struct vm_area_struct *vma;
-	struct pte_chain *pte_chain = NULL, *ptec;
-	pte_t *pte;
-	pte_addr_t pte_paddr;
-	int mapcount;
-	int index = 0;
-
-	if (PageAnon(page))
-		goto out;
-
-retry:
-	/*
-	 * Preallocate the pte_chains outside the lock.
-	 */
-	mapcount = page->pte.mapcount;
-	if (mapcount > 1) {
-		for (; index < mapcount; index += NRPTE) {
-			ptec = pte_chain_alloc(GFP_KERNEL);
-			ptec->next = pte_chain;
-			pte_chain = ptec;
-		}
-	}
-	down(&mapping->i_shared_sem);
-	pte_chain_lock(page);
-
-	/*
-	 * Check to make sure the number of mappings didn't change.  If they
-	 * did, either retry or free enough pte_chains to compensate.
-	 */
-	if (mapcount < page->pte.mapcount) {
-		pte_chain_unlock(page);
-		up(&mapping->i_shared_sem);
-		goto retry;
-	} else if ((mapcount > page->pte.mapcount) && (mapcount > 1)) {
-		mapcount = page->pte.mapcount;
-		while ((index - NRPTE) > mapcount) {
-			index -= NRPTE;
-			ptec = pte_chain->next;
-			pte_chain_free(pte_chain);
-			pte_chain = ptec;
-		}
-		if (mapcount <= 1)
-			pte_chain_free(pte_chain);
-	}
-	SetPageAnon(page);
-
-	if (mapcount == 0)
-		goto out_unlock;
-	else if (mapcount == 1) {
-		SetPageDirect(page);
-		page->pte.direct = 0;
-	} else
-		page->pte.chain = pte_chain;
-
-	index = NRPTE-1;
-	list_for_each_entry(vma, &mapping->i_mmap, shared) {
-		pte = find_pte(vma, page, NULL);
-		if (pte) {
-			pte_paddr = ptep_to_paddr(pte);
-			pte_unmap(pte);
-			if (PageDirect(page)) {
-				page->pte.direct = pte_paddr;
-				goto out_unlock;
-			}
-			pte_chain->ptes[index] = pte_paddr;
-			if (!--index) {
-				pte_chain = pte_chain->next;
-				index = NRPTE-1;
-			}
-		}
+		if (PageAnon(page))
+			clear_page_anon(page);
 	}
-	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
-		pte = find_pte(vma, page, NULL);
-		if (pte) {
-			pte_paddr = ptep_to_paddr(pte);
-			pte_unmap(pte);
-			if (PageDirect(page)) {
-				page->pte.direct = pte_paddr;
-				goto out_unlock;
-			}
-			pte_chain->ptes[index] = pte_paddr;
-			if (!--index) {
-				pte_chain = pte_chain->next;
-				index = NRPTE-1;
-			}
-		}
-	}
-out_unlock:
-	pte_chain_unlock(page);
-	up(&mapping->i_shared_sem);
-out:
-	return;
+	return ret;
 }
 
 /**
--- anobjrmap1/mm/swap_state.c	Wed Mar  5 07:26:34 2003
+++ anobjrmap2/mm/swap_state.c	Thu Mar 20 17:10:01 2003
@@ -13,40 +13,35 @@
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/backing-dev.h>
-#include <linux/buffer_head.h>	/* block_sync_page() */
+#include <linux/buffer_head.h>
 
 #include <asm/pgtable.h>
 
 /*
- * swapper_inode doesn't do anything much.  It is really only here to
- * avoid some special-casing in other parts of the kernel.
+ * Try to avoid special-casing swapcache in shrink_list.
  */
-static struct inode swapper_inode = {
-	.i_mapping	= &swapper_space,
-};
-
 static struct backing_dev_info swap_backing_dev_info = {
 	.ra_pages	= 0,	/* No readahead */
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
 
+/*
+ * Only a few fields of swapper_space, those initialized below,
+ * are ever used: leave most fields null to oops if ever used.
+ */
 struct address_space swapper_space = {
 	.page_tree	= RADIX_TREE_INIT(GFP_ATOMIC),
 	.page_lock	= RW_LOCK_UNLOCKED,
-	.clean_pages	= LIST_HEAD_INIT(swapper_space.clean_pages),
-	.dirty_pages	= LIST_HEAD_INIT(swapper_space.dirty_pages),
-	.io_pages	= LIST_HEAD_INIT(swapper_space.io_pages),
-	.locked_pages	= LIST_HEAD_INIT(swapper_space.locked_pages),
-	.host		= &swapper_inode,
 	.a_ops		= &swap_aops,
 	.backing_dev_info = &swap_backing_dev_info,
-	.i_mmap		= LIST_HEAD_INIT(swapper_space.i_mmap),
-	.i_mmap_shared	= LIST_HEAD_INIT(swapper_space.i_mmap_shared),
-	.i_shared_sem	= __MUTEX_INITIALIZER(swapper_space.i_shared_sem),
-	.private_lock	= SPIN_LOCK_UNLOCKED,
-	.private_list	= LIST_HEAD_INIT(swapper_space.private_list),
 };
 
 #define INC_CACHE_INFO(x)	do { swap_cache_info.x++; } while (0)
@@ -68,30 +63,50 @@
 		swap_cache_info.noent_race, swap_cache_info.exist_race);
 }
 
-int add_to_swap_cache(struct page *page, swp_entry_t entry)
+static int __add_to_swap_cache(struct page *page, swp_entry_t entry)
+{
+	int error;
+
+	BUG_ON(PageSwapCache(page));
+	BUG_ON(PagePrivate(page));
+	error = radix_tree_preload(GFP_ATOMIC);
+	if (!error) {
+		page_cache_get(page);
+		write_lock(&swapper_space.page_lock);
+		error = radix_tree_insert(&swapper_space.page_tree,
+						entry.val, page);
+		if (!error) {
+			SetPageLocked(page);
+			SetPageSwapCache(page);
+			page->private = entry.val;
+			inc_page_state(nr_swapcache);
+		} else
+			page_cache_release(page);
+		write_unlock(&swapper_space.page_lock);
+		radix_tree_preload_end();
+	}
+	return error;
+}
+
+static int add_to_swap_cache(struct page *page, swp_entry_t entry)
 {
 	int error;
 
-	if (page->mapping)
-		BUG();
 	if (!swap_duplicate(entry)) {
 		INC_CACHE_INFO(noent_race);
 		return -ENOENT;
 	}
-	error = add_to_page_cache(page, &swapper_space, entry.val, GFP_ATOMIC);
+	error = __add_to_swap_cache(page, entry);
 	/*
-	 * Anon pages are already on the LRU, we don't run lru_cache_add here.
+	 * Anon pages are already on the LRU,
+	 * we don't run lru_cache_add here.
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
@@ -105,7 +120,10 @@
 	BUG_ON(!PageLocked(page));
 	BUG_ON(!PageSwapCache(page));
 	BUG_ON(PageWriteback(page));
-	__remove_from_page_cache(page);
+
+	radix_tree_delete(&swapper_space.page_tree, page->private);
+	ClearPageSwapCache(page);
+	dec_page_state(nr_swapcache);
 	INC_CACHE_INFO(del_total);
 }
 
@@ -149,8 +167,7 @@
 		/*
 		 * Add it to the swap cache and mark it dirty
 		 */
-		err = add_to_page_cache(page, &swapper_space,
-					entry.val, GFP_ATOMIC);
+		err = __add_to_swap_cache(page, entry);
 
 		if (pf_flags & PF_MEMALLOC)
 			current->flags |= PF_MEMALLOC;
@@ -158,8 +175,7 @@
 		switch (err) {
 		case 0:				/* Success */
 			SetPageUptodate(page);
-			ClearPageDirty(page);
-			set_page_dirty(page);
+			SetPageDirty(page);
 			INC_CACHE_INFO(add_total);
 			return 1;
 		case -EEXIST:
@@ -185,11 +201,12 @@
 {
 	swp_entry_t entry;
 
+	BUG_ON(!PageSwapCache(page));
 	BUG_ON(!PageLocked(page));
 	BUG_ON(PageWriteback(page));
 	BUG_ON(page_has_buffers(page));
   
-	entry.val = page->index;
+	entry.val = page->private;
 
 	write_lock(&swapper_space.page_lock);
 	__delete_from_swap_cache(page);
@@ -201,27 +218,12 @@
 
 int move_to_swap_cache(struct page *page, swp_entry_t entry)
 {
-	struct address_space *mapping = page->mapping;
-	int err;
-
-	write_lock(&swapper_space.page_lock);
-	write_lock(&mapping->page_lock);
-
-	err = radix_tree_insert(&swapper_space.page_tree, entry.val, page);
-	if (!err) {
-		__remove_from_page_cache(page);
-		___add_to_page_cache(page, &swapper_space, entry.val);
-	}
-
-	write_unlock(&mapping->page_lock);
-	write_unlock(&swapper_space.page_lock);
-
+	int err = __add_to_swap_cache(page, entry);
 	if (!err) {
+		remove_from_page_cache(page);
 		if (!swap_duplicate(entry))
 			BUG();
-		/* shift page from clean_pages to dirty_pages list */
-		BUG_ON(PageDirty(page));
-		set_page_dirty(page);
+		SetPageDirty(page);
 		INC_CACHE_INFO(add_total);
 	} else if (err == -EEXIST)
 		INC_CACHE_INFO(exist_race);
@@ -231,29 +233,9 @@
 int move_from_swap_cache(struct page *page, unsigned long index,
 		struct address_space *mapping)
 {
-	swp_entry_t entry;
-	int err;
-
-	BUG_ON(!PageLocked(page));
-	BUG_ON(PageWriteback(page));
-	BUG_ON(page_has_buffers(page));
-
-	entry.val = page->index;
-
-	write_lock(&swapper_space.page_lock);
-	write_lock(&mapping->page_lock);
-
-	err = radix_tree_insert(&mapping->page_tree, index, page);
-	if (!err) {
-		__delete_from_swap_cache(page);
-		___add_to_page_cache(page, mapping, index);
-	}
-
-	write_unlock(&mapping->page_lock);
-	write_unlock(&swapper_space.page_lock);
-
+	int err = add_to_page_cache(page, mapping, index, GFP_ATOMIC);
 	if (!err) {
-		swap_free(entry);
+		delete_from_swap_cache(page);
 		/* shift page from clean_pages to dirty_pages list */
 		ClearPageDirty(page);
 		set_page_dirty(page);
@@ -261,7 +243,6 @@
 	return err;
 }
 
-
 /* 
  * If we are the only user, then try to free up the swap cache. 
  * 
@@ -319,9 +300,15 @@
  */
 struct page * lookup_swap_cache(swp_entry_t entry)
 {
-	struct page *found;
+	struct page *page;
 
-	found = find_get_page(&swapper_space, entry.val);
+	read_lock(&swapper_space.page_lock);
+	page = radix_tree_lookup(&swapper_space.page_tree, entry.val);
+	if (page) {
+		page_cache_get(page);
+		INC_CACHE_INFO(find_success);
+	}
+	read_unlock(&swapper_space.page_lock);
 	/*
 	 * Unsafe to assert PageSwapCache and mapping on page found:
 	 * if SMP nothing prevents swapoff from deleting this page from
@@ -329,9 +316,7 @@
 	 * that, but no need to change: we _have_ got the right page.
 	 */
 	INC_CACHE_INFO(find_total);
-	if (found)
-		INC_CACHE_INFO(find_success);
-	return found;
+	return page;
 }
 
 /* 
@@ -352,7 +337,12 @@
 		 * that would confuse statistics: use find_get_page()
 		 * directly.
 		 */
-		found_page = find_get_page(&swapper_space, entry.val);
+		read_lock(&swapper_space.page_lock);
+		found_page = radix_tree_lookup(&swapper_space.page_tree,
+						entry.val);
+		if (found_page)
+			page_cache_get(found_page);
+		read_unlock(&swapper_space.page_lock);
 		if (found_page)
 			break;
 
--- anobjrmap1/mm/swapfile.c	Thu Mar 20 17:09:50 2003
+++ anobjrmap2/mm/swapfile.c	Thu Mar 20 17:10:02 2003
@@ -242,7 +242,7 @@
 	struct swap_info_struct * p;
 	swp_entry_t entry;
 
-	entry.val = page->index;
+	entry.val = page->private;
 	p = swap_info_get(entry);
 	if (p) {
 		/* Is the only swap cache user the cache itself? */
@@ -310,7 +310,7 @@
 	if (page_count(page) != 2) /* 2: us + cache */
 		return 0;
 
-	entry.val = page->index;
+	entry.val = page->private;
 	p = swap_info_get(entry);
 	if (!p)
 		return 0;
@@ -348,8 +348,14 @@
 
 	p = swap_info_get(entry);
 	if (p) {
-		if (swap_entry_free(p, swp_offset(entry)) == 1)
-			page = find_trylock_page(&swapper_space, entry.val);
+		if (swap_entry_free(p, swp_offset(entry)) == 1) {
+			read_lock(&swapper_space.page_lock);
+			page = radix_tree_lookup(&swapper_space.page_tree,
+				entry.val);
+			if (page && TestSetPageLocked(page))
+				page = NULL;
+			read_unlock(&swapper_space.page_lock);
+		}
 		swap_info_put(p);
 	}
 	if (page) {
@@ -959,15 +965,14 @@
 	struct backing_dev_info *bdi;
 
 	BUG_ON(!PageLocked(page));	/* It pins the swap_info_struct */
-
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
--- anobjrmap1/mm/truncate.c	Mon Feb 10 20:12:55 2003
+++ anobjrmap2/mm/truncate.c	Thu Mar 20 17:10:02 2003
@@ -54,7 +54,6 @@
 	ClearPageUptodate(page);
 	ClearPageMappedToDisk(page);
 	remove_from_page_cache(page);
-	page_cache_release(page);	/* pagecache ref */
 }
 
 /*
--- anobjrmap1/mm/vmscan.c	Thu Mar 20 17:09:50 2003
+++ anobjrmap2/mm/vmscan.c	Thu Mar 20 17:10:02 2003
@@ -176,20 +176,20 @@
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
@@ -261,22 +261,25 @@
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
+#endif /* CONFIG_SWAP */
 
 		/*
 		 * The page is mapped into the page tables of one or more
@@ -294,7 +297,6 @@
 				; /* try to free the page below */
 			}
 		}
-#endif /* CONFIG_SWAP */
 		pte_chain_unlock(page);
 
 		/*
@@ -335,7 +337,9 @@
 					.for_reclaim = 1,
 				};
 
-				list_move(&page->list, &mapping->locked_pages);
+				if (!PageSwapCache(page))
+					list_move(&page->list,
+						&mapping->locked_pages);
 				write_unlock(&mapping->page_lock);
 
 				SetPageReclaim(page);
@@ -399,7 +403,7 @@
 
 #ifdef CONFIG_SWAP
 		if (PageSwapCache(page)) {
-			swp_entry_t swap = { .val = page->index };
+			swp_entry_t swap = { .val = page->private };
 			__delete_from_swap_cache(page);
 			write_unlock(&mapping->page_lock);
 			swap_free(swap);
@@ -641,7 +645,7 @@
 		 * FIXME: need to consider page_count(page) here if/when we
 		 * reap orphaned pages via the LRU (Daniel's locking stuff)
 		 */
-		if (total_swap_pages == 0 && !page->mapping &&
+		if (total_swap_pages == 0 && !page_mapping(page) &&
 						!PagePrivate(page)) {
 			list_add(&page->lru, &l_active);
 			continue;

