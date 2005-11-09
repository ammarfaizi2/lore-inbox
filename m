Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbVKIOPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbVKIOPW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 09:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbVKIOOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 09:14:55 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:4334 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750866AbVKIOOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 09:14:43 -0500
Message-Id: <20051109141527.180858000@localhost.localdomain>
References: <20051109134938.757187000@localhost.localdomain>
Date: Wed, 09 Nov 2005 21:49:49 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 11/16] readahead: mandatory thrashing protection
Content-Disposition: inline; filename=readahead-thrashing-protection.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It tries to identify and protect live pages (sequential pages that are going
to be accessed in the near future) on vmscan time. Almost all live pages can
be sorted out and saved.

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
 mm/vmscan.c                |   10 +
 5 files changed, 334 insertions(+), 1 deletion(-)

--- linux-2.6.14-mm1.orig/include/linux/page-flags.h
+++ linux-2.6.14-mm1/include/linux/page-flags.h
@@ -107,6 +107,8 @@ struct page_state {
 	unsigned long pgfree;		/* page freeings */
 	unsigned long pgactivate;	/* pages moved inactive->active */
 	unsigned long pgdeactivate;	/* pages moved active->inactive */
+	unsigned long pgkeephot;	/* pages sent back to active */
+	unsigned long pgkeepcold;	/* pages sent back to inactive */
 
 	unsigned long pgfault;		/* faults (major+minor) */
 	unsigned long pgmajfault;	/* faults (major only) */
--- linux-2.6.14-mm1.orig/include/linux/mm.h
+++ linux-2.6.14-mm1/include/linux/mm.h
@@ -995,6 +995,8 @@ page_cache_readahead_adaptive(struct add
 			pgoff_t first_index,
 			pgoff_t index, pgoff_t last_index);
 void fastcall ra_access(struct file_ra_state *ra, struct page *page);
+int rescue_ra_pages(struct list_head *page_list, struct list_head *save_list);
+
 
 /* Do stack extension */
 extern int expand_stack(struct vm_area_struct *vma, unsigned long address);
--- linux-2.6.14-mm1.orig/mm/page_alloc.c
+++ linux-2.6.14-mm1/mm/page_alloc.c
@@ -2391,6 +2391,8 @@ static char *vmstat_text[] = {
 	"pgfree",
 	"pgactivate",
 	"pgdeactivate",
+	"pgkeephot",
+	"pgkeepcold",
 
 	"pgfault",
 	"pgmajfault",
--- linux-2.6.14-mm1.orig/mm/vmscan.c
+++ linux-2.6.14-mm1/mm/vmscan.c
@@ -406,6 +406,8 @@ cannot_free:
 	return 0;
 }
 
+extern int readahead_ratio;
+extern int readahead_live_chunk;
 DECLARE_PER_CPU(unsigned long, smooth_aging);
 
 /*
@@ -416,10 +418,15 @@ static int shrink_list(struct list_head 
 	LIST_HEAD(ret_pages);
 	struct pagevec freed_pvec;
 	int pgactivate = 0;
+	int pgkeep = 0;
 	int reclaimed = 0;
 
 	cond_resched();
 
+	if (readahead_ratio >= VM_READAHEAD_PROTECT_RATIO &&
+							readahead_live_chunk)
+		pgkeep += rescue_ra_pages(page_list, &ret_pages);
+
 	pagevec_init(&freed_pvec, 1);
 	while (!list_empty(page_list)) {
 		struct address_space *mapping;
@@ -572,11 +579,13 @@ keep_locked:
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
@@ -1054,6 +1063,7 @@ refill_inactive_zone(struct zone *zone, 
 
 	mod_page_state_zone(zone, pgrefill, pgscanned);
 	mod_page_state(pgdeactivate, pgdeactivate);
+	mod_page_state(pgkeephot, pgmoved);
 }
 
 /*
--- linux-2.6.14-mm1.orig/mm/readahead.c
+++ linux-2.6.14-mm1/mm/readahead.c
@@ -365,7 +365,7 @@ __do_page_cache_readahead(struct address
 	read_lock_irq(&mapping->tree_lock);
 	for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
 		pgoff_t page_offset = offset + page_idx;
-		
+
 		if (page_offset > end_index)
 			break;
 
@@ -1734,3 +1734,320 @@ void fastcall ra_access(struct file_ra_s
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
+ * The general idea is to classify pages of a file into groups of sequential
+ * accessed pages. Dead sequential pages are left over, live sequential pages
+ * are saved.
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
+ */
+static int save_chunk(struct page *head, struct page *live_head,
+			struct page *tail, struct list_head *save_list)
+{
+	struct page *page;
+	struct address_space *mapping;
+	struct radix_tree_cache cache;
+	int i;
+	pgoff_t index;
+	pgoff_t head_index;
+	unsigned long refcnt;
+
+#ifdef DEBUG_READAHEAD
+	static char static_buf[PAGE_SIZE];
+	static char *zone_names[] = {"DMA", "DMA32", "Normal", "HighMem"};
+	char *pat = static_buf;
+	int pidx = 0;
+#define	log_symbol(symbol)					\
+	do { 							\
+		if ((readahead_ratio & 3) == 3 &&		\
+				pidx < PAGE_SIZE - 1)	\
+			pat[pidx++] = symbol; 			\
+	} while (0)
+
+	if ((readahead_ratio & 3) == 3) {
+		pat = (char *)get_zeroed_page(GFP_KERNEL);
+		if (!pat)
+			pat = static_buf;
+	}
+#else
+#define log_symbol(symbol) do {} while (0)
+#endif
+#define	log_page(page)	log_symbol(page_refcnt_symbol(page))
+
+	head_index = head->index;
+	mapping = head->mapping;
+	radix_tree_cache_init(&cache);
+
+	BUG_ON(!mapping); /* QUESTION: in what case mapping will be NULL ? */
+	read_lock_irq(&mapping->tree_lock);
+
+	/*
+	 * Common case test.
+	 * Does the far end indicates a leading live head?
+	 */
+	index = radix_tree_lookup_head(&mapping->page_tree,
+					head_index, readahead_live_chunk);
+	if (index >= head_index)
+		goto skip_scan_locked;
+
+	page = __find_page(mapping, index);
+	BUG_ON(!page);
+	log_symbol('|');
+	log_page(page);
+	refcnt = cold_page_refcnt(page);
+	if (head_index - index < readahead_live_chunk &&
+			refcnt > page_refcnt(head)) {
+		live_head = head;
+		goto skip_scan_locked;
+	}
+
+	/*
+	 * The slow path.
+	 * Scan page by page to see if the whole chunk should be saved.
+	 */
+	if (next_page(head) != tail)
+		head_index = next_page(head)->index;
+	else
+		head_index++;
+	for (i = 0, index++; index <= head_index; index++) {
+		page = radix_tree_cache_lookup(&mapping->page_tree, &cache,
+									index);
+		if (index == head->index)
+			log_symbol('|');
+		log_page(page);
+
+		if (!page) {
+			WARN_ON(index < head->index);
+			break;
+		}
+
+		if (refcnt == page_refcnt(page))
+			i++;
+		else if (refcnt < page_refcnt(page))
+			i = 0;
+		else if (i < 1)
+			i = INT_MIN;
+		else {
+			live_head = head;
+			break;
+		}
+
+		refcnt = page_refcnt(page);
+	}
+
+skip_scan_locked:
+#ifdef DEBUG_READAHEAD
+	if (index < head->index)
+		log_symbol('*');
+	index = prev_page(tail)->index;
+
+	log_symbol('|');
+	for (page = head; page != tail; page = next_page(page)) {
+		BUG_ON(PageAnon(page));
+		BUG_ON(PageSwapCache(page));
+		/* BUG_ON(page_mapped(page)); */
+
+		if (page == live_head)
+			log_symbol('[');
+		log_page(page);
+	}
+	if (live_head)
+		log_symbol(']');
+#endif
+
+	/*
+	 * Special case work around.
+	 *
+	 * Save one extra page if it is a live head of the following chunk.
+	 * Just to be safe.  It protects the rare situation when the reader
+	 * is just crossing the chunk boundary, and the following chunk is not
+	 * far away from tail of inactive_list.
+	 *
+	 * The special case is awkwardly delt with for now. They will be all set
+	 * when the timing information of recently evicted pages are available.
+	 * Dead pages can also be purged earlier with the timing info.
+	 */
+	if (live_head != head) {
+		struct page *last_page = prev_page(tail);
+		page = radix_tree_cache_lookup(&mapping->page_tree, &cache,
+						last_page->index + 1);
+		log_symbol('|');
+		log_page(page);
+		if (page && !live_head) {
+			refcnt = page_refcnt(last_page);
+			if (page_refcnt(page) >= refcnt)
+				page = radix_tree_cache_lookup(
+						&mapping->page_tree, &cache,
+						last_page->index + 2);
+			log_page(page);
+			if (page && page_refcnt(page) < refcnt) {
+				live_head = last_page;
+				log_symbol('I');
+			}
+		} else if (!page && live_head) {
+			live_head = next_page(live_head);
+				log_symbol('D');
+		}
+	}
+	log_symbol('\0');
+
+	read_unlock_irq(&mapping->tree_lock);
+
+	/*
+	 * Now save the alive pages.
+	 */
+	i = 0;
+	if (live_head) {
+		for (; live_head != tail;) { /* never dereference tail! */
+			page = next_page(live_head);
+			if (!PageActivate(live_head)) {
+				list_move(&live_head->lru, save_list);
+				i++;
+				if (!page_refcnt(live_head))
+					__get_cpu_var(smooth_aging)++;
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
+		ddprintk("save_chunk(ino=%lu, idx=%lu-%lu, %s@%s:%s)"
+				" = %d\n",
+				mapping->host->i_ino,
+				head->index, index,
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
+	unsigned long min_refcnt;
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
+	min_refcnt = LONG_MAX;
+
+next_head_page:
+	refcnt = page_refcnt(page);
+	if (min_refcnt > refcnt)
+		min_refcnt = refcnt;
+	page = next_page(page);
+
+	if (mapping != page->mapping || &page->lru == page_list)
+		goto save_chunk;
+
+	/* At least 2 pages followed by a fall in refcnt makes a live head:
+	 *               --_
+	 *                ^ live_head
+	 */
+	if (refcnt == page_refcnt(page))
+		n++;
+	else if (refcnt < page_refcnt(page))
+		n = 0;
+	else if (n < 1)
+		n = INT_MIN;
+	else
+		goto got_live_head;
+
+	goto next_head_page;
+
+got_live_head:
+	n = 0;
+	live_head = prev_page(page);
+
+next_page:
+	if (refcnt < page_refcnt(page)) /* limit the number of rises */
+		n++;
+	refcnt = page_refcnt(page);
+	if (min_refcnt > refcnt)
+		min_refcnt = refcnt;
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
+			min_refcnt < PAGE_REFCNT_2 &&
+			n <= 3)
+		ret += save_chunk(chunk_head, live_head, page, save_list);
+
+	if (&page->lru != page_list)
+		goto next_chunk;
+
+	return ret;
+}

--
