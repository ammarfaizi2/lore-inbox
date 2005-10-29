Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbVJ2Fr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbVJ2Fr6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 01:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbVJ2Frz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 01:47:55 -0400
Received: from ns.ustc.edu.cn ([202.38.64.1]:36491 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751355AbVJ2Frc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 01:47:32 -0400
Message-Id: <20051029060242.816955000@localhost.localdomain>
References: <20051029060216.159380000@localhost.localdomain>
Date: Sat, 29 Oct 2005 14:02:27 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 11/13] readahead: thrashing protection
Content-Disposition: inline; filename=readahead-thrashing-protection.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It tries to identify and protect live pages (sequential pages that are going
to be accessed in the near future) on vmscan time.

Almost all live pages can be sorted out and saved. The only problem is that
relavant pages can be mutilated into tiny chunks and ignored as random pages.

The cost: dead pages that won't be read will be kept in inactive_list for
another round. Hopefully there won't be much.

This feature is greatly demanded by file servers, though should be useless
for desktop. It saves the case when one fast reader flushes the cache and
strips the read-ahead size of slow readers, or the case where caching is just
a wasting of memory. Then you can raise readahead_ratio to 200 or more to
enforce a larger read-ahead size and strip the useless cached data out of lru.

Its use is currently limited, for the context based method is not ready for
the case. This problem will be solved when the timing info of evicted pages
are available. It can also be extended to further benefit large memory
systems.  I'll leave them as future work.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 include/linux/mm.h         |    2 
 include/linux/page-flags.h |    2 
 mm/page_alloc.c            |    2 
 mm/readahead.c             |  319 ++++++++++++++++++++++++++++++++++++++++++++-
 mm/vmscan.c                |    8 +
 5 files changed, 332 insertions(+), 1 deletion(-)

--- linux-2.6.14-rc5-mm1.orig/include/linux/page-flags.h
+++ linux-2.6.14-rc5-mm1/include/linux/page-flags.h
@@ -107,6 +107,8 @@ struct page_state {
 	unsigned long pgfree;		/* page freeings */
 	unsigned long pgactivate;	/* pages moved inactive->active */
 	unsigned long pgdeactivate;	/* pages moved active->inactive */
+	unsigned long pgkeephot;	/* pages sent back to active */
+	unsigned long pgkeepcold;	/* pages sent back to inactive */
 
 	unsigned long pgfault;		/* faults (major+minor) */
 	unsigned long pgmajfault;	/* faults (major only) */
--- linux-2.6.14-rc5-mm1.orig/include/linux/mm.h
+++ linux-2.6.14-rc5-mm1/include/linux/mm.h
@@ -954,6 +954,8 @@ page_cache_readahead_adaptive(struct add
 			unsigned long first_index,
 			unsigned long index, unsigned long last_index);
 void fastcall ra_access(struct file_ra_state *ra, struct page *page);
+int rescue_ra_pages(struct list_head *page_list, struct list_head *save_list);
+
 
 /* Do stack extension */
 extern int expand_stack(struct vm_area_struct *vma, unsigned long address);
--- linux-2.6.14-rc5-mm1.orig/mm/page_alloc.c
+++ linux-2.6.14-rc5-mm1/mm/page_alloc.c
@@ -2389,6 +2389,8 @@ static char *vmstat_text[] = {
 	"pgfree",
 	"pgactivate",
 	"pgdeactivate",
+	"pgkeephot",
+	"pgkeepcold",
 
 	"pgfault",
 	"pgmajfault",
--- linux-2.6.14-rc5-mm1.orig/mm/vmscan.c
+++ linux-2.6.14-rc5-mm1/mm/vmscan.c
@@ -370,6 +370,7 @@ static pageout_t pageout(struct page *pa
 	return PAGE_CLEAN;
 }
 
+extern int readahead_ratio;
 DECLARE_PER_CPU(unsigned long, smooth_aging);
 
 /*
@@ -380,10 +381,14 @@ static int shrink_list(struct list_head 
 	LIST_HEAD(ret_pages);
 	struct pagevec freed_pvec;
 	int pgactivate = 0;
+	int pgkeep = 0;
 	int reclaimed = 0;
 
 	cond_resched();
 
+	if (readahead_ratio >= VM_READAHEAD_PROTECT_RATIO)
+		rescue_ra_pages(page_list, &ret_pages);
+
 	pagevec_init(&freed_pvec, 1);
 	while (!list_empty(page_list)) {
 		struct address_space *mapping;
@@ -569,11 +574,13 @@ keep_locked:
 keep:
 		list_add(&page->lru, &ret_pages);
 		BUG_ON(PageLRU(page));
+		pgkeep++;
 	}
 	list_splice(&ret_pages, page_list);
 	if (pagevec_count(&freed_pvec))
 		__pagevec_release_nonlru(&freed_pvec);
 	mod_page_state(pgactivate, pgactivate);
+	mod_page_state(pgkeepcold, pgkeep - pgactivate);
 	sc->nr_reclaimed += reclaimed;
 	return reclaimed;
 }
@@ -837,6 +844,7 @@ refill_inactive_zone(struct zone *zone, 
 
 	mod_page_state_zone(zone, pgrefill, pgscanned);
 	mod_page_state(pgdeactivate, pgdeactivate);
+	mod_page_state(pgkeephot, pgmoved);
 }
 
 /*
--- linux-2.6.14-rc5-mm1.orig/mm/readahead.c
+++ linux-2.6.14-rc5-mm1/mm/readahead.c
@@ -345,7 +345,7 @@ __do_page_cache_readahead(struct address
 	read_lock_irq(&mapping->tree_lock);
 	for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
 		unsigned long page_offset = offset + page_idx;
-		
+
 		if (page_offset > end_index)
 			break;
 
@@ -1676,3 +1676,320 @@ void fastcall ra_access(struct file_ra_s
 		ra_account(ra, RA_EVENT_READAHEAD_HIT, -1);
 }
 
+/*
+ * Detect and protect live read-ahead pages.
+ *
+ * This function provides safty guarantee for file servers with big
+ * readahead_ratio(>=VM_READAHEAD_PROTECT_RATIO) set.  The goal is to save all
+ * and only the sequential pages that are to be accessed in the near future.
+ *
+ * This function is called when pages in @page_list are to be freed,
+ * it protects live read-ahead pages by moving them into @save_list.
+ *
+ * The general idea is to classify pages of a file into random pages and groups
+ * of sequential accessed pages. Random pages and dead sequential pages are
+ * left over, live sequential pages are saved.
+ *
+ * Live read-ahead pages are defined as sequential pages that have reading in
+ * progress. They are detected by reference count pattern of:
+ *
+ *                        live head       live pages
+ *  ra pages group -->   ------------___________________
+ *                                   [  pages to save  ] (*)
+ *
+ * (*) for now, an extra page from the live head may also be saved.
+ *
+ * In pratical, the group of pages are fragmented into chunks. To tell whether
+ * pages inside a chunk are alive, we must check:
+ * 1) Are there any live heads inside the chunk?
+ * 2) Are there any live heads in the group before the chunk?
+ * 3) Sepcial case: live head just sits on the boundary of current chunk?
+ *
+ * The detailed rules employed must ensure:
+ * - no page is pinned in inactive_list.
+ * - no excessive pages are saved.
+ *
+ * A picture of common cases:
+ *             back search            chunk             case
+ *           -----___________|[____________________]    Normal
+ *           ----------------|----[________________]    Normal
+ *                           |----[________________]    Normal
+ *           ----------------|----------------------    Normal
+ *                           |----------------------    Normal
+ *           ________________|______________________    ra miss
+ *                           |______________________    ra miss
+ *           ________________|_______--------[_____]    two readers
+ *           ----____________|[______--------______]    two readers
+ *                           |_______--------[_____]    two readers
+ *                           |----[____------______]    two readers
+ *           ----------------|----[____------______]    two readers
+ *           _______---------|---------------[_____]    two readers
+ *           ----___---------|[--------------______]    two readers
+ *           ________________|---------------[_____]    two readers
+ *           ----____________|[--------------______]    two readers
+ *           ====------------|[---_________________]    two readers
+ *                           |====[----------______]    two readers
+ *                           |###======[-----------]    three readers
+ *
+ * Read backward pattern support is possible, in which case the pages should be
+ * pushed into inactive_list in reverse order.
+ *
+ * The two special cases are awkwardly delt with for now. They will be all set
+ * when the timing information of recently evicted pages are available.
+ * Dead pages can also be purged earlier with the timing info.
+ */
+static int save_chunk(struct page *head, struct page *live_head,
+			struct page *tail, struct list_head *save_list)
+{
+	struct page *page;
+	struct address_space *mapping;
+	struct radix_tree_cache cache;
+	int i;
+	unsigned long index;
+	unsigned long refcnt;
+
+#ifdef DEBUG_READAHEAD
+	static char static_buf[PAGE_SIZE];
+	static char *zone_names[1 << ZONES_SHIFT] = {
+			"DMA", "DMA32", "Normal", "HighMem", "Z5", "Z6", "Z7" };
+	char *pat = static_buf;
+	unsigned long pidx = PAGE_SIZE / 2;
+
+	if ((readahead_ratio & 3) == 3) {
+		pat = (char *)get_zeroed_page(GFP_KERNEL);
+		if (!pat)
+			pat = static_buf;
+	}
+#endif
+
+#define LIVE_PAGE_SCAN		(4 * MAX_RA_PAGES)
+	index = head->index;
+	refcnt = page_refcnt(head);
+	mapping = head->mapping;
+	radix_tree_cache_init(&cache);
+
+	BUG_ON(!mapping); /* QUESTION: in what case mapping will be NULL ? */
+	read_lock_irq(&mapping->tree_lock);
+
+	/*
+	 * Common case test:
+	 * Does the far end indicates a leading live head?
+	 */
+	index = radix_tree_lookup_head(&mapping->page_tree,
+						index, LIVE_PAGE_SCAN);
+	page = __find_page(mapping, index);
+	if (cold_page_refcnt(page) > refcnt) {
+#ifdef DEBUG_READAHEAD
+		if ((readahead_ratio & 3) == 3) {
+			pat[--pidx] = '.';
+			pat[--pidx] = '.';
+			pat[--pidx] = '.';
+			pat[--pidx] = page_refcnt_symbol(page);
+			pat[--pidx] = '|';
+		}
+#endif
+		live_head = head;
+		goto skip_scan_locked;
+	}
+
+	/*
+	 * Special case 1:
+	 * If @head is a live head, rescue_ra_pages() will not detect it.
+	 * Check it here.
+	 */
+	index = head->index;
+	page = radix_tree_cache_lookup(&mapping->page_tree, &cache, --index);
+	if (!page || PageActive(page)) {
+#ifdef DEBUG_READAHEAD
+		if ((readahead_ratio & 3) == 3)
+			pat[--pidx] = page_refcnt_symbol(page);
+#endif
+		goto skip_scan_locked;
+	}
+	if (refcnt > page_refcnt(next_page(head)) &&
+			page_refcnt(page) > page_refcnt(next_page(head))) {
+#ifdef DEBUG_READAHEAD
+		if ((readahead_ratio & 3) == 3)
+			pat[--pidx] = page_refcnt_symbol(page);
+#endif
+		live_head = head;
+		goto skip_scan_locked;
+	}
+
+	/*
+	 * Scan backward to see if the whole chunk should be saved.
+	 * It can be costly. But can be made rare in future.
+	 */
+	for (i = LIVE_PAGE_SCAN; i >= 0; i--) {
+		page = radix_tree_cache_lookup(&mapping->page_tree, &cache,
+								--index);
+#ifdef DEBUG_READAHEAD
+		if ((readahead_ratio & 3) == 3 && pidx)
+			pat[--pidx] = page_refcnt_symbol(page);
+#endif
+
+		if (!page)
+			break;
+
+		/* Avoid being pinned by active page. */
+		if (unlikely(PageActive(page)))
+			break;
+
+		if (page_refcnt(page) > refcnt) { /* So we are alive! */
+			live_head = head;
+			break;
+		}
+
+		refcnt = page_refcnt(page);
+	}
+
+skip_scan_locked:
+	/*
+	 * Special case 2:
+	 * Save one extra page if it is a live head of the following chunk.
+	 * Just to be safe.  It protects the rare situation when the reader
+	 * is just crossing the chunk boundary, and the following chunk is not
+	 * far away from tail of inactive_list.
+	 */
+	if (live_head != head) {
+		struct page *last_page = prev_page(tail);
+		page = radix_tree_cache_lookup(&mapping->page_tree, &cache,
+						last_page->index + 1);
+		if (page && !live_head) {
+			refcnt = page_refcnt(last_page);
+			if (page_refcnt(page) >= refcnt)
+				page = radix_tree_cache_lookup(
+						&mapping->page_tree, &cache,
+						last_page->index + 2);
+			if (page && page_refcnt(page) < refcnt)
+				live_head = last_page;
+		} else if (!page && live_head)
+			live_head = next_page(live_head);
+	}
+
+	read_unlock_irq(&mapping->tree_lock);
+
+#ifdef DEBUG_READAHEAD
+	if ((readahead_ratio & 3) == 3) {
+		for (i = 0; pidx < PAGE_SIZE / 2;)
+			pat[i++] = pat[pidx++];
+		pat[i++] = '|';
+		for (page = head; page != tail; page = next_page(page)) {
+			pidx = page->index;
+			if (page == live_head)
+				pat[i++] = '[';
+			pat[i++] = page_refcnt_symbol(page);
+			BUG_ON(PageAnon(page));
+			BUG_ON(PageSwapCache(page));
+			/* BUG_ON(page_mapped(page)); */
+			if (i >= PAGE_SIZE - 2)
+				break;
+		}
+		if (live_head)
+			pat[i++] = ']';
+		pat[i] = 0;
+		pat[PAGE_SIZE - 1] = 0;
+	}
+#endif
+
+	/*
+	 * Now save the alive pages.
+	 */
+	i = 0;
+	if (live_head) {
+		for (; live_head != tail;) { /* never dereference tail! */
+			page = next_page(live_head);
+			if (!PageActivate(live_head)) {
+				if (!page_refcnt(live_head))
+					__get_cpu_var(smooth_aging)++;
+				i++;
+				list_move(&live_head->lru, save_list);
+			}
+			live_head = page;
+		}
+
+		if (i)
+			ra_account(0, RA_EVENT_READAHEAD_RESCUE, i);
+	}
+
+#ifdef DEBUG_READAHEAD
+	if ((readahead_ratio & 3) == 3) {
+		ddprintk("save_chunk(ino=%lu, idx=%lu-%lu-%lu, %s@%s:%s)"
+				" = %d\n",
+				mapping->host->i_ino,
+				index, head->index, pidx,
+				mapping_mapped(mapping) ? "mmap" : "file",
+				zone_names[page_zonenum(head)], pat, i);
+		if (pat != static_buf)
+			free_page((unsigned long)pat);
+	}
+#endif
+
+	return i;
+}
+
+int rescue_ra_pages(struct list_head *page_list, struct list_head *save_list)
+{
+	struct address_space *mapping;
+	struct page *chunk_head;
+	struct page *live_head;
+	struct page *page;
+	unsigned long refcnt;
+	int n;
+	int ret = 0;
+
+	page = list_to_page(page_list);
+
+next_chunk:
+	chunk_head = page;
+	live_head = NULL;
+	mapping = page->mapping;
+	n = 0;
+
+next_rs_page:
+	refcnt = page_refcnt(page);
+	page = next_page(page);
+
+	if (mapping != page->mapping || &page->lru == page_list)
+		goto save_chunk;
+
+	if (refcnt == page_refcnt(page))
+		n++;
+	else if (refcnt < page_refcnt(page))
+		n = 0;
+	else if (n < 1)
+		n = INT_MIN;
+	else
+		goto got_live_head;
+
+	goto next_rs_page;
+
+got_live_head:
+	n = 0;
+	live_head = prev_page(page);
+
+next_page:
+	if (refcnt < page_refcnt(page))
+		n++;
+	refcnt = page_refcnt(page);
+	page = next_page(page);
+
+	if (mapping != page->mapping || &page->lru == page_list)
+		goto save_chunk;
+
+	goto next_page;
+
+save_chunk:
+	if (mapping && !PageAnon(chunk_head) &&
+			!PageSwapCache(chunk_head) &&
+			/* !page_mapped(chunk_head) && */
+			n <= 3 &&
+			(!refcnt ||
+			 prev_page(page)->index >= chunk_head->index + 5))
+		ret += save_chunk(chunk_head, live_head, page, save_list);
+
+	if (&page->lru != page_list)
+		goto next_chunk;
+
+	return ret;
+}

--
