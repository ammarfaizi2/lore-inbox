Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263743AbUGLVv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUGLVv4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 17:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUGLVvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 17:51:55 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:34328 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263743AbUGLVuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 17:50:40 -0400
Date: Mon, 12 Jul 2004 22:50:32 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rmaplock 2/6 kill page_map_lock
In-Reply-To: <Pine.LNX.4.44.0407122248060.4005-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0407122249530.4005-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The pte_chains rmap used pte_chain_lock (bit_spin_lock on PG_chainlock)
to lock its pte_chains.  We kept this (as page_map_lock: bit_spin_lock
on PG_maplock) when we moved to objrmap.  But the file objrmap locks its
vma tree with mapping->i_mmap_lock, and the anon objrmap locks its vma
list with anon_vma->lock: so isn't the page_map_lock superfluous?

Pretty much, yes.  The mapcount was protected by it, and needs to become
an atomic: starting at -1 like page _count, so nr_mapped can be tracked
precisely up and down.  The last page_remove_rmap can't clear anon page
mapping any more, because of races with page_add_rmap; from which some
BUG_ONs must go for the same reason, but they've served their purpose.

vmscan decisions are naturally racy, little change there beyond removing
page_map_lock/unlock.  But to stabilize the file-backed page->mapping
against truncation while acquiring i_mmap_lock, page_referenced_file now
needs page lock to be held even for refill_inactive_zone.  There's a
similar issue in acquiring anon_vma->lock, where page lock doesn't help:
which this patch pretends to handle, but actually it needs the next.

Roughly 10% cut off lmbench fork numbers on my 2*HT*P4.  Must confess
my testing failed to show the races even while they were knowingly
exposed: would benefit from testing on racier equipment.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

 include/linux/mm.h         |   22 ++++++-
 include/linux/page-flags.h |    3 -
 include/linux/rmap.h       |   13 +---
 mm/page_alloc.c            |   10 +--
 mm/rmap.c                  |  135 +++++++++++++++++++++++++--------------------
 mm/vmscan.c                |   37 ++----------
 6 files changed, 110 insertions(+), 110 deletions(-)

--- rmaplock1/include/linux/mm.h	2004-07-12 18:20:07.949982720 +0100
+++ rmaplock2/include/linux/mm.h	2004-07-12 18:20:22.331796352 +0100
@@ -195,10 +195,9 @@ struct page {
 	page_flags_t flags;		/* Atomic flags, some possibly
 					 * updated asynchronously */
 	atomic_t _count;		/* Usage count, see below. */
-	unsigned int mapcount;		/* Count of ptes mapped in mms,
+	atomic_t _mapcount;		/* Count of ptes mapped in mms,
 					 * to show when page is mapped
-					 * & limit reverse map searches,
-					 * protected by PG_maplock.
+					 * & limit reverse map searches.
 					 */
 	unsigned long private;		/* Mapping-private opaque data:
 					 * usually used for buffer_heads
@@ -472,11 +471,26 @@ static inline pgoff_t page_index(struct 
 }
 
 /*
+ * The atomic page->_mapcount, like _count, starts from -1:
+ * so that transitions both from it and to it can be tracked,
+ * using atomic_inc_and_test and atomic_add_negative(-1).
+ */
+static inline void reset_page_mapcount(struct page *page)
+{
+	atomic_set(&(page)->_mapcount, -1);
+}
+
+static inline int page_mapcount(struct page *page)
+{
+	return atomic_read(&(page)->_mapcount) + 1;
+}
+
+/*
  * Return true if this page is mapped into pagetables.
  */
 static inline int page_mapped(struct page *page)
 {
-	return page->mapcount != 0;
+	return atomic_read(&(page)->_mapcount) >= 0;
 }
 
 /*
--- rmaplock1/include/linux/page-flags.h	2004-07-12 18:20:07.950982568 +0100
+++ rmaplock2/include/linux/page-flags.h	2004-07-12 18:20:22.332796200 +0100
@@ -69,12 +69,11 @@
 #define PG_private		12	/* Has something at ->private */
 #define PG_writeback		13	/* Page is under writeback */
 #define PG_nosave		14	/* Used for system suspend/resume */
-#define PG_maplock		15	/* Lock bit for rmap to ptes */
+#define PG_compound		15	/* Part of a compound page */
 
 #define PG_swapcache		16	/* Swap page: swp_entry_t in private */
 #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
 #define PG_reclaim		18	/* To be reclaimed asap */
-#define PG_compound		19	/* Part of a compound page */
 
 
 /*
--- rmaplock1/include/linux/rmap.h	2004-06-16 06:20:36.000000000 +0100
+++ rmaplock2/include/linux/rmap.h	2004-07-12 18:20:22.333796048 +0100
@@ -9,11 +9,6 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
-#define page_map_lock(page) \
-	bit_spin_lock(PG_maplock, (unsigned long *)&(page)->flags)
-#define page_map_unlock(page) \
-	bit_spin_unlock(PG_maplock, (unsigned long *)&(page)->flags)
-
 /*
  * The anon_vma heads a list of private "related" vmas, to scan if
  * an anonymous page pointing to this anon_vma needs to be unmapped:
@@ -87,15 +82,13 @@ void page_remove_rmap(struct page *);
  */
 static inline void page_dup_rmap(struct page *page)
 {
-	page_map_lock(page);
-	page->mapcount++;
-	page_map_unlock(page);
+	atomic_inc(&page->_mapcount);
 }
 
 /*
  * Called from mm/vmscan.c to handle paging out
  */
-int page_referenced(struct page *);
+int page_referenced(struct page *, int is_locked);
 int try_to_unmap(struct page *);
 
 #else	/* !CONFIG_MMU */
@@ -104,7 +97,7 @@ int try_to_unmap(struct page *);
 #define anon_vma_prepare(vma)	(0)
 #define anon_vma_link(vma)	do {} while (0)
 
-#define page_referenced(page)	TestClearPageReferenced(page)
+#define page_referenced(page,l)	TestClearPageReferenced(page)
 #define try_to_unmap(page)	SWAP_FAIL
 
 #endif	/* CONFIG_MMU */
--- rmaplock1/mm/page_alloc.c	2004-07-12 18:20:07.952982264 +0100
+++ rmaplock2/mm/page_alloc.c	2004-07-12 18:20:22.335795744 +0100
@@ -78,7 +78,7 @@ static void bad_page(const char *functio
 		function, current->comm, page);
 	printk(KERN_EMERG "flags:0x%08lx mapping:%p mapcount:%d count:%d\n",
 		(unsigned long)page->flags, page->mapping,
-		(int)page->mapcount, page_count(page));
+		page_mapcount(page), page_count(page));
 	printk(KERN_EMERG "Backtrace:\n");
 	dump_stack();
 	printk(KERN_EMERG "Trying to fix it up, but a reboot is needed\n");
@@ -87,12 +87,11 @@ static void bad_page(const char *functio
 			1 << PG_lru	|
 			1 << PG_active	|
 			1 << PG_dirty	|
-			1 << PG_maplock |
 			1 << PG_swapcache |
 			1 << PG_writeback);
 	set_page_count(page, 0);
+	reset_page_mapcount(page);
 	page->mapping = NULL;
-	page->mapcount = 0;
 }
 
 #ifndef CONFIG_HUGETLB_PAGE
@@ -228,7 +227,6 @@ static inline void free_pages_check(cons
 			1 << PG_active	|
 			1 << PG_reclaim	|
 			1 << PG_slab	|
-			1 << PG_maplock |
 			1 << PG_swapcache |
 			1 << PG_writeback )))
 		bad_page(function, page);
@@ -350,7 +348,6 @@ static void prep_new_page(struct page *p
 			1 << PG_active	|
 			1 << PG_dirty	|
 			1 << PG_reclaim	|
-			1 << PG_maplock |
 			1 << PG_swapcache |
 			1 << PG_writeback )))
 		bad_page(__FUNCTION__, page);
@@ -512,6 +509,8 @@ static void fastcall free_hot_cold_page(
 
 	kernel_map_pages(page, 1, 0);
 	inc_page_state(pgfree);
+	if (PageAnon(page))
+		page->mapping = NULL;
 	free_pages_check(__FUNCTION__, page);
 	pcp = &zone->pageset[get_cpu()].pcp[cold];
 	local_irq_save(flags);
@@ -1399,6 +1398,7 @@ void __init memmap_init_zone(struct page
 	for (page = start; page < (start + size); page++) {
 		set_page_zone(page, NODEZONE(nid, zone));
 		set_page_count(page, 0);
+		reset_page_mapcount(page);
 		SetPageReserved(page);
 		INIT_LIST_HEAD(&page->lru);
 #ifdef WANT_PAGE_VIRTUAL
--- rmaplock1/mm/rmap.c	2004-07-12 18:20:07.954981960 +0100
+++ rmaplock2/mm/rmap.c	2004-07-12 18:20:22.338795288 +0100
@@ -163,13 +163,6 @@ void __init anon_vma_init(void)
 		sizeof(struct anon_vma), 0, SLAB_PANIC, anon_vma_ctor, NULL);
 }
 
-/* this needs the page->flags PG_maplock held */
-static inline void clear_page_anon(struct page *page)
-{
-	BUG_ON(!page->mapping);
-	page->mapping = NULL;
-}
-
 /*
  * At what user virtual address is page expected in vma?
  */
@@ -239,15 +232,22 @@ out:
 	return referenced;
 }
 
-static inline int page_referenced_anon(struct page *page)
+static int page_referenced_anon(struct page *page)
 {
-	unsigned int mapcount = page->mapcount;
+	unsigned int mapcount;
 	struct anon_vma *anon_vma = (void *) page->mapping - PAGE_MAPPING_ANON;
 	struct vm_area_struct *vma;
 	int referenced = 0;
 
+	/*
+	 * Recheck mapcount: it is not safe to take anon_vma->lock after
+	 * last page_remove_rmap, since struct anon_vma might be reused.
+	 */
+	mapcount = page_mapcount(page);
+	if (!mapcount)
+		return referenced;
+
 	spin_lock(&anon_vma->lock);
-	BUG_ON(list_empty(&anon_vma->head));
 	list_for_each_entry(vma, &anon_vma->head, anon_vma_node) {
 		referenced += page_referenced_one(page, vma, &mapcount);
 		if (!mapcount)
@@ -271,18 +271,39 @@ static inline int page_referenced_anon(s
  * The spinlock address_space->i_mmap_lock is tried.  If it can't be gotten,
  * assume a reference count of 0, so try_to_unmap will then have a go.
  */
-static inline int page_referenced_file(struct page *page)
+static int page_referenced_file(struct page *page)
 {
-	unsigned int mapcount = page->mapcount;
+	unsigned int mapcount;
 	struct address_space *mapping = page->mapping;
 	pgoff_t pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
 	struct vm_area_struct *vma = NULL;
 	struct prio_tree_iter iter;
 	int referenced = 0;
 
+	/*
+	 * The caller's checks on page->mapping and !PageAnon have made
+	 * sure that this is a file page: the check for page->mapping
+	 * excludes the case just before it gets set on an anon page.
+	 */
+	BUG_ON(PageAnon(page));
+
+	/*
+	 * The page lock not only makes sure that page->mapping cannot
+	 * suddenly be NULLified by truncation, it makes sure that the
+	 * structure at mapping cannot be freed and reused yet,
+	 * so we can safely take mapping->i_mmap_lock.
+	 */
+	BUG_ON(!PageLocked(page));
+
 	if (!spin_trylock(&mapping->i_mmap_lock))
 		return 0;
 
+	/*
+	 * i_mmap_lock does not stabilize mapcount at all, but mapcount
+	 * is more likely to be accurate if we note it after spinning.
+	 */
+	mapcount = page_mapcount(page);
+
 	while ((vma = vma_prio_tree_next(vma, &mapping->i_mmap,
 					&iter, pgoff, pgoff)) != NULL) {
 		if ((vma->vm_flags & (VM_LOCKED|VM_MAYSHARE))
@@ -302,12 +323,12 @@ static inline int page_referenced_file(s
 /**
  * page_referenced - test if the page was referenced
  * @page: the page to test
+ * @is_locked: caller holds lock on the page
  *
  * Quick test_and_clear_referenced for all mappings to a page,
  * returns the number of ptes which referenced the page.
- * Caller needs to hold the rmap lock.
  */
-int page_referenced(struct page *page)
+int page_referenced(struct page *page, int is_locked)
 {
 	int referenced = 0;
 
@@ -317,11 +338,17 @@ int page_referenced(struct page *page)
 	if (TestClearPageReferenced(page))
 		referenced++;
 
-	if (page->mapcount && page->mapping) {
+	if (page_mapped(page) && page->mapping) {
 		if (PageAnon(page))
 			referenced += page_referenced_anon(page);
-		else
+		else if (is_locked)
+			referenced += page_referenced_file(page);
+		else if (TestSetPageLocked(page))
+			referenced++;
+		else if (page->mapping) {
 			referenced += page_referenced_file(page);
+			unlock_page(page);
+		}
 	}
 	return referenced;
 }
@@ -348,18 +375,12 @@ void page_add_anon_rmap(struct page *pag
 	index += vma->vm_pgoff;
 	index >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;
 
-	page_map_lock(page);
-	if (!page->mapcount) {
-		BUG_ON(page->mapping);
+	if (atomic_inc_and_test(&page->_mapcount)) {
 		page->index = index;
 		page->mapping = (struct address_space *) anon_vma;
 		inc_page_state(nr_mapped);
-	} else {
-		BUG_ON(page->index != index);
-		BUG_ON(page->mapping != (struct address_space *) anon_vma);
 	}
-	page->mapcount++;
-	page_map_unlock(page);
+	/* else checking page index and mapping is racy */
 }
 
 /**
@@ -374,11 +395,8 @@ void page_add_file_rmap(struct page *pag
 	if (!pfn_valid(page_to_pfn(page)) || PageReserved(page))
 		return;
 
-	page_map_lock(page);
-	if (!page->mapcount)
+	if (atomic_inc_and_test(&page->_mapcount))
 		inc_page_state(nr_mapped);
-	page->mapcount++;
-	page_map_unlock(page);
 }
 
 /**
@@ -390,18 +408,20 @@ void page_add_file_rmap(struct page *pag
 void page_remove_rmap(struct page *page)
 {
 	BUG_ON(PageReserved(page));
-	BUG_ON(!page->mapcount);
 
-	page_map_lock(page);
-	page->mapcount--;
-	if (!page->mapcount) {
+	if (atomic_add_negative(-1, &page->_mapcount)) {
+		BUG_ON(page_mapcount(page) < 0);
+		/*
+		 * It would be tidy to reset the PageAnon mapping here,
+		 * but that might overwrite a racing page_add_anon_rmap
+		 * which increments mapcount after us but sets mapping
+		 * before us: so leave the reset to free_hot_cold_page,
+		 * and remember that it's only reliable while mapped.
+		 */
 		if (page_test_and_clear_dirty(page))
 			set_page_dirty(page);
-		if (PageAnon(page))
-			clear_page_anon(page);
 		dec_page_state(nr_mapped);
 	}
-	page_map_unlock(page);
 }
 
 /*
@@ -469,7 +489,7 @@ static int try_to_unmap_one(struct page 
 	 * the original page for.
 	 */
 	if (PageSwapCache(page) &&
-	    page_count(page) != page->mapcount + 2) {
+	    page_count(page) != page_mapcount(page) + 2) {
 		ret = SWAP_FAIL;
 		goto out_unmap;
 	}
@@ -495,8 +515,7 @@ static int try_to_unmap_one(struct page 
 	}
 
 	mm->rss--;
-	BUG_ON(!page->mapcount);
-	page->mapcount--;
+	page_remove_rmap(page);
 	page_cache_release(page);
 
 out_unmap:
@@ -607,17 +626,23 @@ out_unlock:
 	return SWAP_AGAIN;
 }
 
-static inline int try_to_unmap_anon(struct page *page)
+static int try_to_unmap_anon(struct page *page)
 {
 	struct anon_vma *anon_vma = (void *) page->mapping - PAGE_MAPPING_ANON;
 	struct vm_area_struct *vma;
 	int ret = SWAP_AGAIN;
 
+	/*
+	 * Recheck mapped: it is not safe to take anon_vma->lock after
+	 * last page_remove_rmap, since struct anon_vma might be reused.
+	 */
+	if (!page_mapped(page))
+		return ret;
+
 	spin_lock(&anon_vma->lock);
-	BUG_ON(list_empty(&anon_vma->head));
 	list_for_each_entry(vma, &anon_vma->head, anon_vma_node) {
 		ret = try_to_unmap_one(page, vma);
-		if (ret == SWAP_FAIL || !page->mapcount)
+		if (ret == SWAP_FAIL || !page_mapped(page))
 			break;
 	}
 	spin_unlock(&anon_vma->lock);
@@ -636,7 +661,7 @@ static inline int try_to_unmap_anon(stru
  * The spinlock address_space->i_mmap_lock is tried.  If it can't be gotten,
  * return a temporary error.
  */
-static inline int try_to_unmap_file(struct page *page)
+static int try_to_unmap_file(struct page *page)
 {
 	struct address_space *mapping = page->mapping;
 	pgoff_t pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
@@ -654,7 +679,7 @@ static inline int try_to_unmap_file(stru
 	while ((vma = vma_prio_tree_next(vma, &mapping->i_mmap,
 					&iter, pgoff, pgoff)) != NULL) {
 		ret = try_to_unmap_one(page, vma);
-		if (ret == SWAP_FAIL || !page->mapcount)
+		if (ret == SWAP_FAIL || !page_mapped(page))
 			goto out;
 	}
 
@@ -683,8 +708,9 @@ static inline int try_to_unmap_file(stru
 	 * The mapcount of the page we came in with is irrelevant,
 	 * but even so use it as a guide to how hard we should try?
 	 */
-	mapcount = page->mapcount;
-	page_map_unlock(page);
+	mapcount = page_mapcount(page);
+	if (!mapcount)
+		goto out;
 	cond_resched_lock(&mapping->i_mmap_lock);
 
 	max_nl_size = (max_nl_size + CLUSTER_SIZE - 1) & CLUSTER_MASK;
@@ -707,7 +733,7 @@ static inline int try_to_unmap_file(stru
 				cursor += CLUSTER_SIZE;
 				vma->vm_private_data = (void *) cursor;
 				if ((int)mapcount <= 0)
-					goto relock;
+					goto out;
 			}
 			if (ret != SWAP_FAIL)
 				vma->vm_private_data =
@@ -728,8 +754,6 @@ static inline int try_to_unmap_file(stru
 		if (!(vma->vm_flags & VM_RESERVED))
 			vma->vm_private_data = NULL;
 	}
-relock:
-	page_map_lock(page);
 out:
 	spin_unlock(&mapping->i_mmap_lock);
 	return ret;
@@ -740,11 +764,11 @@ out:
  * @page: the page to get unmapped
  *
  * Tries to remove all the page table entries which are mapping this
- * page, used in the pageout path.  Caller must hold the page lock
- * and its rmap lock.  Return values are:
+ * page, used in the pageout path.  Caller must hold the page lock.
+ * Return values are:
  *
  * SWAP_SUCCESS	- we succeeded in removing all mappings
- * SWAP_AGAIN	- we missed a trylock, try again later
+ * SWAP_AGAIN	- we missed a mapping, try again later
  * SWAP_FAIL	- the page is unswappable
  */
 int try_to_unmap(struct page *page)
@@ -753,20 +777,13 @@ int try_to_unmap(struct page *page)
 
 	BUG_ON(PageReserved(page));
 	BUG_ON(!PageLocked(page));
-	BUG_ON(!page->mapcount);
 
 	if (PageAnon(page))
 		ret = try_to_unmap_anon(page);
 	else
 		ret = try_to_unmap_file(page);
 
-	if (!page->mapcount) {
-		if (page_test_and_clear_dirty(page))
-			set_page_dirty(page);
-		if (PageAnon(page))
-			clear_page_anon(page);
-		dec_page_state(nr_mapped);
+	if (!page_mapped(page))
 		ret = SWAP_SUCCESS;
-	}
 	return ret;
 }
--- rmaplock1/mm/vmscan.c	2004-07-09 10:53:47.000000000 +0100
+++ rmaplock2/mm/vmscan.c	2004-07-12 18:20:22.340794984 +0100
@@ -209,7 +209,7 @@ static int shrink_slab(unsigned long sca
 	return 0;
 }
 
-/* Must be called with page's rmap lock held. */
+/* Called without lock on whether page is mapped, so answer is unstable */
 static inline int page_mapping_inuse(struct page *page)
 {
 	struct address_space *mapping;
@@ -367,26 +367,19 @@ static int shrink_list(struct list_head 
 		if (page_mapped(page) || PageSwapCache(page))
 			sc->nr_scanned++;
 
-		page_map_lock(page);
-		referenced = page_referenced(page);
-		if (referenced && page_mapping_inuse(page)) {
-			/* In active use or really unfreeable.  Activate it. */
-			page_map_unlock(page);
+		referenced = page_referenced(page, 1);
+		/* In active use or really unfreeable?  Activate it. */
+		if (referenced && page_mapping_inuse(page))
 			goto activate_locked;
-		}
 
 #ifdef CONFIG_SWAP
 		/*
 		 * Anonymous process memory has backing store?
 		 * Try to allocate it some swap space here.
-		 *
-		 * XXX: implement swap clustering ?
 		 */
 		if (PageAnon(page) && !PageSwapCache(page)) {
-			page_map_unlock(page);
 			if (!add_to_swap(page))
 				goto activate_locked;
-			page_map_lock(page);
 		}
 #endif /* CONFIG_SWAP */
 
@@ -401,16 +394,13 @@ static int shrink_list(struct list_head 
 		if (page_mapped(page) && mapping) {
 			switch (try_to_unmap(page)) {
 			case SWAP_FAIL:
-				page_map_unlock(page);
 				goto activate_locked;
 			case SWAP_AGAIN:
-				page_map_unlock(page);
 				goto keep_locked;
 			case SWAP_SUCCESS:
 				; /* try to free the page below */
 			}
 		}
-		page_map_unlock(page);
 
 		if (PageDirty(page)) {
 			if (referenced)
@@ -713,25 +703,12 @@ refill_inactive_zone(struct zone *zone, 
 		page = lru_to_page(&l_hold);
 		list_del(&page->lru);
 		if (page_mapped(page)) {
-			if (!reclaim_mapped) {
-				list_add(&page->lru, &l_active);
-				continue;
-			}
-			page_map_lock(page);
-			if (page_referenced(page)) {
-				page_map_unlock(page);
+			if (!reclaim_mapped ||
+			    (total_swap_pages == 0 && PageAnon(page)) ||
+			    page_referenced(page, 0)) {
 				list_add(&page->lru, &l_active);
 				continue;
 			}
-			page_map_unlock(page);
-		}
-		/*
-		 * FIXME: need to consider page_count(page) here if/when we
-		 * reap orphaned pages via the LRU (Daniel's locking stuff)
-		 */
-		if (total_swap_pages == 0 && PageAnon(page)) {
-			list_add(&page->lru, &l_active);
-			continue;
 		}
 		list_add(&page->lru, &l_inactive);
 	}

