Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263000AbUDHW4s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 18:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbUDHW4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 18:56:42 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:57863 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262906AbUDHWyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 18:54:47 -0400
Date: Thu, 8 Apr 2004 23:54:41 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rmap 2 anon and swapcache
In-Reply-To: <Pine.LNX.4.44.0404082349580.1586-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0404082351540.1586-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tracking anonymous pages by anon_vma,pgoff or mm,address needs
a pointer,offset pair in struct page: mapping,index the natural
choice.  But swapcache uses those for &swapper_space,swp_entry_t.

It's trivial to separate swapcache from pagecache with radix
tree; most of swapper_space is actually unused, just a fiction
to pretend swap like file; and page->private is a good place
to keep swp_entry_t, now that swap never uses bufferheads.

Define PG_anon bit, page_add_rmap SetPageAnon and put an oopsable
address in page->mapping to test that we're not confused by it.
Define page_mapping(page) macro to give NULL when PageAnon,
whatever may be in page->mapping.  Define PG_swapcache bit,
deduce swapper_space from that in the few places we need it.

add_to_swap_cache now distinct from add_to_page_cache.
Separating the caches somewhat simplifies the tmpfs swizzling
in swap_state.c, now the page can briefly be in both caches.

The rmap method remains pte chains, no change to that yet.
But one small functional difference: the use of PageAnon implies
that a page truncated while still mapped will no longer be found
and freed (swapped out) by try_to_unmap, will only be freed by
exit or munmap.  But normally pages are unmapped by vmtruncate:
this should only affect nonlinear mappings, and a later patch
not in this batch will fix that.

If applying against 2.6.5-mm2+rmap1 instead of 2.6.5-mc2+rmap1,
blk_run_queues in sync_page must be changed to swap_unplug_io_fn.

 fs/buffer.c                |   19 +----
 include/linux/mm.h         |   38 +++++-----
 include/linux/page-flags.h |   17 ++--
 mm/filemap.c               |   27 ++++---
 mm/memory.c                |    4 -
 mm/page-writeback.c        |   28 ++++++-
 mm/page_alloc.c            |    9 ++
 mm/page_io.c               |   38 +---------
 mm/rmap.c                  |   50 +++++++++----
 mm/swap_state.c            |  166 ++++++++++++++++++++++-----------------------
 mm/swapfile.c              |   34 +++++----
 mm/vmscan.c                |   34 ++++-----
 12 files changed, 245 insertions(+), 219 deletions(-)

--- rmap1/fs/buffer.c	2004-04-07 08:19:27.000000000 +0100
+++ rmap2/fs/buffer.c	2004-04-08 20:56:40.932505200 +0100
@@ -833,19 +833,10 @@ EXPORT_SYMBOL(mark_buffer_dirty_inode);
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
@@ -874,8 +865,7 @@ int __set_page_dirty_buffers(struct page
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 	}
 	
-out:
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(__set_page_dirty_buffers);
 
@@ -1574,8 +1564,7 @@ int try_to_release_page(struct page *pag
 {
 	struct address_space * const mapping = page->mapping;
 
-	if (!PageLocked(page))
-		BUG();
+	BUG_ON(!PageLocked(page));
 	if (PageWriteback(page))
 		return 0;
 	
@@ -2892,14 +2881,14 @@ int try_to_free_buffers(struct page *pag
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
--- rmap1/include/linux/mm.h	2004-04-07 08:19:29.000000000 +0100
+++ rmap2/include/linux/mm.h	2004-04-08 20:56:40.934504896 +0100
@@ -189,8 +189,11 @@ struct page {
 					 * protected by PG_chainlock */
 		pte_addr_t direct;
 	} pte;
-	unsigned long private;		/* mapping-private opaque data */
-
+	unsigned long private;		/* Mapping-private opaque data:
+					 * usually used for buffer_heads
+					 * if PagePrivate set; used for
+					 * swp_entry_t if PageSwapCache
+					 */
 	/*
 	 * On machines where all RAM is mapped into kernel address space,
 	 * we can simply calculate the virtual address. On machines with
@@ -403,6 +406,19 @@ void page_address_init(void);
 #endif
 
 /*
+ * On an anonymous page mapped into a user virtual memory area,
+ * page->mapping points to its anon_vma, not to a struct address_space.
+ *
+ * Please note that, confusingly, "page_mapping" refers to the inode
+ * address_space which maps the page from disk; whereas "page_mapped"
+ * refers to user virtual address space into which the page is mapped.
+ */
+static inline struct address_space *page_mapping(struct page *page)
+{
+	return PageAnon(page)? NULL: page->mapping;
+}
+
+/*
  * Return true if this page is mapped into pagetables.  Subtle: test pte.direct
  * rather than pte.chain.  Because sometimes pte.direct is 64-bit, and .chain
  * is only 32-bit.
@@ -471,6 +487,7 @@ int get_user_pages(struct task_struct *t
 
 int __set_page_dirty_buffers(struct page *page);
 int __set_page_dirty_nobuffers(struct page *page);
+int FASTCALL(set_page_dirty(struct page *page));
 int set_page_dirty_lock(struct page *page);
 int clear_page_dirty_for_io(struct page *page);
 
@@ -498,23 +515,6 @@ extern struct shrinker *set_shrinker(int
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
--- rmap1/include/linux/page-flags.h	2004-04-08 20:56:29.709211400 +0100
+++ rmap2/include/linux/page-flags.h	2004-04-08 20:56:40.935504744 +0100
@@ -75,6 +75,8 @@
 #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
 #define PG_reclaim		18	/* To be reclaimed asap */
 #define PG_compound		19	/* Part of a compound page */
+#define PG_anon			20	/* Anonymous page: anon_vma in mapping*/
+#define PG_swapcache		21	/* Swap page: swp_entry_t in private */
 
 
 /*
@@ -298,15 +300,16 @@ extern void get_full_page_state(struct p
 #define SetPageCompound(page)	set_bit(PG_compound, &(page)->flags)
 #define ClearPageCompound(page)	clear_bit(PG_compound, &(page)->flags)
 
-/*
- * The PageSwapCache predicate doesn't use a PG_flag at this time,
- * but it may again do so one day.
- */
+#define PageAnon(page)		test_bit(PG_anon, &(page)->flags)
+#define SetPageAnon(page)	set_bit(PG_anon, &(page)->flags)
+#define ClearPageAnon(page)	clear_bit(PG_anon, &(page)->flags)
+
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
--- rmap1/mm/filemap.c	2004-04-07 08:19:30.000000000 +0100
+++ rmap2/mm/filemap.c	2004-04-08 20:56:40.937504440 +0100
@@ -119,10 +119,16 @@ void remove_from_page_cache(struct page 
 
 static inline int sync_page(struct page *page)
 {
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping;
 
-	if (mapping && mapping->a_ops && mapping->a_ops->sync_page)
-		return mapping->a_ops->sync_page(page);
+	smp_mb();
+	mapping = page_mapping(page);
+	if (mapping) {
+		if (mapping->a_ops && mapping->a_ops->sync_page)
+			return mapping->a_ops->sync_page(page);
+	} else if (PageSwapCache(page)) {
+		blk_run_queues(); /* swap_unplug_io_fn(NULL); */
+	}
 	return 0;
 }
 
@@ -240,13 +246,9 @@ int filemap_write_and_wait(struct addres
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
@@ -261,7 +263,10 @@ int add_to_page_cache(struct page *page,
 		error = radix_tree_insert(&mapping->page_tree, offset, page);
 		if (!error) {
 			SetPageLocked(page);
-			___add_to_page_cache(page, mapping, offset);
+			page->mapping = mapping;
+			page->index = offset;
+			mapping->nrpages++;
+			pagecache_acct(1);
 		} else {
 			page_cache_release(page);
 		}
--- rmap1/mm/memory.c	2004-04-08 20:56:29.722209424 +0100
+++ rmap2/mm/memory.c	2004-04-08 20:56:40.940503984 +0100
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
--- rmap1/mm/page-writeback.c	2004-04-07 08:19:30.000000000 +0100
+++ rmap2/mm/page-writeback.c	2004-04-08 20:56:40.942503680 +0100
@@ -580,6 +580,24 @@ int __set_page_dirty_nobuffers(struct pa
 EXPORT_SYMBOL(__set_page_dirty_nobuffers);
 
 /*
+ * If the mapping doesn't provide a set_page_dirty a_op, then
+ * just fall through and assume that it wants buffer_heads.
+ */
+int fastcall set_page_dirty(struct page *page)
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
@@ -606,7 +624,7 @@ EXPORT_SYMBOL(set_page_dirty_lock);
  */
 int test_clear_page_dirty(struct page *page)
 {
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping = page_mapping(page);
 	unsigned long flags;
 
 	if (mapping) {
@@ -642,7 +660,7 @@ EXPORT_SYMBOL(test_clear_page_dirty);
  */
 int clear_page_dirty_for_io(struct page *page)
 {
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping = page_mapping(page);
 
 	if (mapping) {
 		if (TestClearPageDirty(page)) {
@@ -661,7 +679,7 @@ EXPORT_SYMBOL(clear_page_dirty_for_io);
  */
 int __clear_page_dirty(struct page *page)
 {
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping = page_mapping(page);
 
 	if (mapping) {
 		unsigned long flags;
@@ -681,7 +699,7 @@ int __clear_page_dirty(struct page *page
 
 int test_clear_page_writeback(struct page *page)
 {
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping = page_mapping(page);
 	int ret;
 
 	if (mapping) {
@@ -701,7 +719,7 @@ int test_clear_page_writeback(struct pag
 
 int test_set_page_writeback(struct page *page)
 {
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping = page_mapping(page);
 	int ret;
 
 	if (mapping) {
--- rmap1/mm/page_alloc.c	2004-04-07 08:19:30.000000000 +0100
+++ rmap2/mm/page_alloc.c	2004-04-08 20:56:40.944503376 +0100
@@ -84,6 +84,9 @@ static void bad_page(const char *functio
 			1 << PG_lru	|
 			1 << PG_active	|
 			1 << PG_dirty	|
+			1 << PG_maplock |
+			1 << PG_anon    |
+			1 << PG_swapcache |
 			1 << PG_writeback);
 	set_page_count(page, 0);
 	page->mapping = NULL;
@@ -224,6 +227,9 @@ static inline void free_pages_check(cons
 			1 << PG_active	|
 			1 << PG_reclaim	|
 			1 << PG_slab	|
+			1 << PG_maplock |
+			1 << PG_anon    |
+			1 << PG_swapcache |
 			1 << PG_writeback )))
 		bad_page(function, page);
 	if (PageDirty(page))
@@ -331,6 +337,9 @@ static void prep_new_page(struct page *p
 			1 << PG_active	|
 			1 << PG_dirty	|
 			1 << PG_reclaim	|
+			1 << PG_maplock |
+			1 << PG_anon    |
+			1 << PG_swapcache |
 			1 << PG_writeback )))
 		bad_page(__FUNCTION__, page);
 
--- rmap1/mm/page_io.c	2004-04-07 08:19:30.000000000 +0100
+++ rmap2/mm/page_io.c	2004-04-08 20:56:40.945503224 +0100
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
 #if defined(CONFIG_SOFTWARE_SUSPEND) || defined(CONFIG_PM_DISK)
 
 /*
@@ -146,25 +137,15 @@ struct address_space_operations swap_aop
 int rw_swap_page_sync(int rw, swp_entry_t entry, struct page *page)
 {
 	int ret;
+	unsigned long save_private;
 	struct writeback_control swap_wbc = {
 		.sync_mode = WB_SYNC_ALL,
 	};
 
 	lock_page(page);
-
-	BUG_ON(page->mapping);
-	ret = add_to_page_cache(page, &swapper_space,
-				entry.val, GFP_NOIO|__GFP_NOFAIL);
-	if (ret) {
-		unlock_page(page);
-		goto out;
-	}
-
-	/*
-	 * get one more reference to make page non-exclusive so
-	 * remove_exclusive_swap_page won't mess with it.
-	 */
-	page_cache_get(page);
+	SetPageSwapCache(page);
+	save_private = page->private;
+	page->private = entry.val;
 
 	if (rw == READ) {
 		ret = swap_readpage(NULL, page);
@@ -174,15 +155,10 @@ int rw_swap_page_sync(int rw, swp_entry_
 		wait_on_page_writeback(page);
 	}
 
-	lock_page(page);
-	remove_from_page_cache(page);
-	unlock_page(page);
-	page_cache_release(page);
-	page_cache_release(page);	/* For add_to_page_cache() */
-
+	ClearPageSwapCache(page);
+	page->private = save_private;
 	if (ret == 0 && (!PageUptodate(page) || PageError(page)))
 		ret = -EIO;
-out:
 	return ret;
 }
 #endif
--- rmap1/mm/rmap.c	2004-04-08 20:56:29.726208816 +0100
+++ rmap2/mm/rmap.c	2004-04-08 20:56:40.947502920 +0100
@@ -35,7 +35,18 @@
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
-/* #define DEBUG_RMAP */
+/*
+ * Something oopsable to put for now in the page->mapping
+ * of an anonymous page, to test that it is ignored.
+ */
+#define ANON_MAPPING_DEBUG	((struct address_space *) 0xADB)
+
+static inline void clear_page_anon(struct page *page)
+{
+	BUG_ON(page->mapping != ANON_MAPPING_DEBUG);
+	page->mapping = NULL;
+	ClearPageAnon(page);
+}
 
 /*
  * Shared pages have a chain of pte_chain structures, used to locate
@@ -180,6 +191,10 @@ page_add_rmap(struct page *page, pte_t *
 	if (page->pte.direct == 0) {
 		page->pte.direct = pte_paddr;
 		SetPageDirect(page);
+		if (!page->mapping) {
+			SetPageAnon(page);
+			page->mapping = ANON_MAPPING_DEBUG;
+		}
 		inc_page_state(nr_mapped);
 		goto out;
 	}
@@ -271,10 +286,13 @@ void fastcall page_remove_rmap(struct pa
 		}
 	}
 out:
-	if (page->pte.direct == 0 && page_test_and_clear_dirty(page))
-		set_page_dirty(page);
-	if (!page_mapped(page))
+	if (!page_mapped(page)) {
+		if (page_test_and_clear_dirty(page))
+			set_page_dirty(page);
+		if (PageAnon(page))
+			clear_page_anon(page);
 		dec_page_state(nr_mapped);
+	}
 out_unlock:
 	rmap_unlock(page);
 }
@@ -330,12 +348,13 @@ static int fastcall try_to_unmap_one(str
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
@@ -345,6 +364,7 @@ static int fastcall try_to_unmap_one(str
 		 * If a nonlinear mapping then store the file page offset
 		 * in the pte.
 		 */
+		BUG_ON(!page->mapping);
 		pgidx = (address - vma->vm_start) >> PAGE_SHIFT;
 		pgidx += vma->vm_pgoff;
 		pgidx >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;
@@ -391,20 +411,15 @@ int fastcall try_to_unmap(struct page * 
 		BUG();
 	if (!PageLocked(page))
 		BUG();
-	/* We need backing store to swap out a page. */
-	if (!page->mapping)
-		BUG();
 
 	if (PageDirect(page)) {
 		ret = try_to_unmap_one(page, page->pte.direct);
 		if (ret == SWAP_SUCCESS) {
-			if (page_test_and_clear_dirty(page))
-				set_page_dirty(page);
 			page->pte.direct = 0;
 			ClearPageDirect(page);
 		}
 		goto out;
-	}		
+	}
 
 	start = page->pte.chain;
 	victim_i = pte_chain_idx(start);
@@ -436,9 +451,6 @@ int fastcall try_to_unmap(struct page * 
 				} else {
 					start->next_and_idx++;
 				}
-				if (page->pte.direct == 0 &&
-				    page_test_and_clear_dirty(page))
-					set_page_dirty(page);
 				break;
 			case SWAP_AGAIN:
 				/* Skip this pte, remembering status. */
@@ -451,8 +463,14 @@ int fastcall try_to_unmap(struct page * 
 		}
 	}
 out:
-	if (!page_mapped(page))
+	if (!page_mapped(page)) {
+		if (page_test_and_clear_dirty(page))
+			set_page_dirty(page);
+		if (PageAnon(page))
+			clear_page_anon(page);
 		dec_page_state(nr_mapped);
+		ret = SWAP_SUCCESS;
+	}
 	return ret;
 }
 
--- rmap1/mm/swap_state.c	2004-04-07 08:19:30.000000000 +0100
+++ rmap2/mm/swap_state.c	2004-04-08 20:56:40.949502616 +0100
@@ -16,24 +16,22 @@
 
 #include <asm/pgtable.h>
 
+/*
+ * swapper_space is a fiction, retained to simplify the path through
+ * vmscan's shrink_list.  Only those fields initialized below are used.
+ */
+static struct address_space_operations swap_aops = {
+	.writepage	= swap_writepage,
+};
 static struct backing_dev_info swap_backing_dev_info = {
-	.ra_pages	= 0,	/* No readahead */
-	.memory_backed	= 1,	/* Does not contribute to dirty memory */
+	.state		= 0,	/* uncongested */
 };
-
-extern struct address_space_operations swap_aops;
-
 struct address_space swapper_space = {
 	.page_tree	= RADIX_TREE_INIT(GFP_ATOMIC),
 	.tree_lock	= SPIN_LOCK_UNLOCKED,
+	.nrpages	= 0,	/* total_swapcache_pages */
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
@@ -55,30 +53,55 @@ void show_swap_cache_info(void)
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
+		spin_lock(&swapper_space.tree_lock);
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
+		spin_unlock(&swapper_space.tree_lock);
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
@@ -92,7 +115,12 @@ void __delete_from_swap_cache(struct pag
 	BUG_ON(!PageLocked(page));
 	BUG_ON(!PageSwapCache(page));
 	BUG_ON(PageWriteback(page));
-	__remove_from_page_cache(page);
+
+	radix_tree_delete(&swapper_space.page_tree, page->private);
+	page->private = 0;
+	ClearPageSwapCache(page);
+	total_swapcache_pages--;
+	pagecache_acct(-1);
 	INC_CACHE_INFO(del_total);
 }
 
@@ -136,8 +164,7 @@ int add_to_swap(struct page * page)
 		/*
 		 * Add it to the swap cache and mark it dirty
 		 */
-		err = add_to_page_cache(page, &swapper_space,
-					entry.val, GFP_ATOMIC);
+		err = __add_to_swap_cache(page, entry, GFP_ATOMIC);
 
 		if (pf_flags & PF_MEMALLOC)
 			current->flags |= PF_MEMALLOC;
@@ -145,8 +172,7 @@ int add_to_swap(struct page * page)
 		switch (err) {
 		case 0:				/* Success */
 			SetPageUptodate(page);
-			__clear_page_dirty(page);
-			set_page_dirty(page);
+			SetPageDirty(page);
 			INC_CACHE_INFO(add_total);
 			return 1;
 		case -EEXIST:
@@ -172,81 +198,55 @@ void delete_from_swap_cache(struct page 
 {
 	swp_entry_t entry;
 
+	BUG_ON(!PageSwapCache(page));
 	BUG_ON(!PageLocked(page));
 	BUG_ON(PageWriteback(page));
 	BUG_ON(PagePrivate(page));
   
-	entry.val = page->index;
+	entry.val = page->private;
 
-	spin_lock_irq(&swapper_space.tree_lock);
+	spin_lock(&swapper_space.tree_lock);
 	__delete_from_swap_cache(page);
-	spin_unlock_irq(&swapper_space.tree_lock);
+	spin_unlock(&swapper_space.tree_lock);
 
 	swap_free(entry);
 	page_cache_release(page);
 }
 
+/*
+ * Strange swizzling function only for use by shmem_writepage
+ */
 int move_to_swap_cache(struct page *page, swp_entry_t entry)
 {
-	struct address_space *mapping = page->mapping;
-	int err;
-
-	spin_lock_irq(&swapper_space.tree_lock);
-	spin_lock(&mapping->tree_lock);
-
-	err = radix_tree_insert(&swapper_space.page_tree, entry.val, page);
-	if (!err) {
-		__remove_from_page_cache(page);
-		___add_to_page_cache(page, &swapper_space, entry.val);
-	}
-
-	spin_unlock(&mapping->tree_lock);
-	spin_unlock_irq(&swapper_space.tree_lock);
-
+	int err = __add_to_swap_cache(page, entry, GFP_ATOMIC);
 	if (!err) {
+		remove_from_page_cache(page);
+		page_cache_release(page);	/* pagecache ref */
 		if (!swap_duplicate(entry))
 			BUG();
-		BUG_ON(PageDirty(page));
-		set_page_dirty(page);
+		SetPageDirty(page);
 		INC_CACHE_INFO(add_total);
 	} else if (err == -EEXIST)
 		INC_CACHE_INFO(exist_race);
 	return err;
 }
 
+/*
+ * Strange swizzling function for shmem_getpage (and shmem_unuse)
+ */
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
-	spin_lock_irq(&swapper_space.tree_lock);
-	spin_lock(&mapping->tree_lock);
-
-	err = radix_tree_insert(&mapping->page_tree, index, page);
+	int err = add_to_page_cache(page, mapping, index, GFP_ATOMIC);
 	if (!err) {
-		__delete_from_swap_cache(page);
-		___add_to_page_cache(page, mapping, index);
-	}
-
-	spin_unlock(&mapping->tree_lock);
-	spin_unlock_irq(&swapper_space.tree_lock);
-
-	if (!err) {
-		swap_free(entry);
-		__clear_page_dirty(page);
+		delete_from_swap_cache(page);
+		/* shift page from clean_pages to dirty_pages list */
+		ClearPageDirty(page);
 		set_page_dirty(page);
 	}
 	return err;
 }
 
-
 /* 
  * If we are the only user, then try to free up the swap cache. 
  * 
@@ -304,19 +304,17 @@ void free_pages_and_swap_cache(struct pa
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
+	spin_lock(&swapper_space.tree_lock);
+	page = radix_tree_lookup(&swapper_space.page_tree, entry.val);
+	if (page) {
+		page_cache_get(page);
 		INC_CACHE_INFO(find_success);
-	return found;
+	}
+	spin_unlock(&swapper_space.tree_lock);
+	INC_CACHE_INFO(find_total);
+	return page;
 }
 
 /* 
@@ -334,10 +332,14 @@ struct page * read_swap_cache_async(swp_
 		/*
 		 * First check the swap cache.  Since this is normally
 		 * called after lookup_swap_cache() failed, re-calling
-		 * that would confuse statistics: use find_get_page()
-		 * directly.
+		 * that would confuse statistics.
 		 */
-		found_page = find_get_page(&swapper_space, entry.val);
+		spin_lock(&swapper_space.tree_lock);
+		found_page = radix_tree_lookup(&swapper_space.page_tree,
+						entry.val);
+		if (found_page)
+			page_cache_get(found_page);
+		spin_unlock(&swapper_space.tree_lock);
 		if (found_page)
 			break;
 
--- rmap1/mm/swapfile.c	2004-04-08 20:56:29.728208512 +0100
+++ rmap2/mm/swapfile.c	2004-04-08 20:56:40.951502312 +0100
@@ -247,16 +247,16 @@ static int exclusive_swap_page(struct pa
 	struct swap_info_struct * p;
 	swp_entry_t entry;
 
-	entry.val = page->index;
+	entry.val = page->private;
 	p = swap_info_get(entry);
 	if (p) {
 		/* Is the only swap cache user the cache itself? */
 		if (p->swap_map[swp_offset(entry)] == 1) {
-			/* Recheck the page count with the pagecache lock held.. */
-			spin_lock_irq(&swapper_space.tree_lock);
-			if (page_count(page) - !!PagePrivate(page) == 2)
+			/* Recheck the page count with the swapcache lock held.. */
+			spin_lock(&swapper_space.tree_lock);
+			if (page_count(page) == 2)
 				retval = 1;
-			spin_unlock_irq(&swapper_space.tree_lock);
+			spin_unlock(&swapper_space.tree_lock);
 		}
 		swap_info_put(p);
 	}
@@ -315,7 +315,7 @@ int remove_exclusive_swap_page(struct pa
 	if (page_count(page) != 2) /* 2: us + cache */
 		return 0;
 
-	entry.val = page->index;
+	entry.val = page->private;
 	p = swap_info_get(entry);
 	if (!p)
 		return 0;
@@ -323,14 +323,14 @@ int remove_exclusive_swap_page(struct pa
 	/* Is the only swap cache user the cache itself? */
 	retval = 0;
 	if (p->swap_map[swp_offset(entry)] == 1) {
-		/* Recheck the page count with the pagecache lock held.. */
-		spin_lock_irq(&swapper_space.tree_lock);
+		/* Recheck the page count with the swapcache lock held.. */
+		spin_lock(&swapper_space.tree_lock);
 		if ((page_count(page) == 2) && !PageWriteback(page)) {
 			__delete_from_swap_cache(page);
 			SetPageDirty(page);
 			retval = 1;
 		}
-		spin_unlock_irq(&swapper_space.tree_lock);
+		spin_unlock(&swapper_space.tree_lock);
 	}
 	swap_info_put(p);
 
@@ -353,8 +353,14 @@ void free_swap_and_cache(swp_entry_t ent
 
 	p = swap_info_get(entry);
 	if (p) {
-		if (swap_entry_free(p, swp_offset(entry)) == 1)
-			page = find_trylock_page(&swapper_space, entry.val);
+		if (swap_entry_free(p, swp_offset(entry)) == 1) {
+			spin_lock(&swapper_space.tree_lock);
+			page = radix_tree_lookup(&swapper_space.page_tree,
+				entry.val);
+			if (page && TestSetPageLocked(page))
+				page = NULL;
+			spin_unlock(&swapper_space.tree_lock);
+		}
 		swap_info_put(p);
 	}
 	if (page) {
@@ -996,14 +1002,14 @@ int page_queue_congested(struct page *pa
 
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
--- rmap1/mm/vmscan.c	2004-04-08 20:56:29.730208208 +0100
+++ rmap2/mm/vmscan.c	2004-04-08 20:56:40.953502008 +0100
@@ -176,20 +176,20 @@ static int shrink_slab(unsigned long sca
 /* Must be called with page's rmap lock held. */
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
@@ -233,7 +233,7 @@ static void handle_write_error(struct ad
 				struct page *page, int error)
 {
 	lock_page(page);
-	if (page->mapping == mapping) {
+	if (page_mapping(page) == mapping) {
 		if (error == -ENOSPC)
 			set_bit(AS_ENOSPC, &mapping->flags);
 		else
@@ -286,27 +286,28 @@ shrink_list(struct list_head *page_list,
 			goto activate_locked;
 		}
 
-		mapping = page->mapping;
+		mapping = page_mapping(page);
+		may_enter_fs = (gfp_mask & __GFP_FS);
 
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
+		if (PageAnon(page) && !PageSwapCache(page)) {
 			rmap_unlock(page);
 			if (!add_to_swap(page))
 				goto activate_locked;
 			rmap_lock(page);
-			mapping = page->mapping;
+		}
+		if (PageSwapCache(page)) {
+			mapping = &swapper_space;
+			may_enter_fs = (gfp_mask & __GFP_IO);
 		}
 #endif /* CONFIG_SWAP */
 
-		may_enter_fs = (gfp_mask & __GFP_FS) ||
-				(PageSwapCache(page) && (gfp_mask & __GFP_IO));
-
 		/*
 		 * The page is mapped into the page tables of one or more
 		 * processes. Try to unmap it here.
@@ -427,7 +428,7 @@ shrink_list(struct list_head *page_list,
 
 #ifdef CONFIG_SWAP
 		if (PageSwapCache(page)) {
-			swp_entry_t swap = { .val = page->index };
+			swp_entry_t swap = { .val = page->private };
 			__delete_from_swap_cache(page);
 			spin_unlock_irq(&mapping->tree_lock);
 			swap_free(swap);
@@ -669,8 +670,7 @@ refill_inactive_zone(struct zone *zone, 
 		 * FIXME: need to consider page_count(page) here if/when we
 		 * reap orphaned pages via the LRU (Daniel's locking stuff)
 		 */
-		if (total_swap_pages == 0 && !page->mapping &&
-						!PagePrivate(page)) {
+		if (total_swap_pages == 0 && PageAnon(page)) {
 			list_add(&page->lru, &l_active);
 			continue;
 		}

