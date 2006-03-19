Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWCSCnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWCSCnk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 21:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWCSCnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 21:43:05 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:40386 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751271AbWCSCed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 21:34:33 -0500
Message-Id: <20060319023456.950815000@localhost.localdomain>
References: <20060319023413.305977000@localhost.localdomain>
Date: Sun, 19 Mar 2006 10:34:30 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 17/23] readahead: call scheme
Content-Disposition: inline; filename=readahead-call-scheme.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The read-ahead logic is called when the reading hits
        - a look-ahead mark;
        - a non-present page.

ra.prev_page should be properly setup on entrance, and ra_access() should be
called on every page reference to maintain the cache_hits counter.

This call scheme achieves the following goals:
        - makes all stateful/stateless methods happy;
        - eliminates the cache hit problem naturally;
        - lives in harmony with application managed read-aheads via
          fadvise/madvise.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 include/linux/mm.h |    7 ++
 mm/filemap.c       |   47 ++++++++++++++--
 mm/readahead.c     |  155 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 205 insertions(+), 4 deletions(-)

--- linux-2.6.16-rc6-mm2.orig/include/linux/mm.h
+++ linux-2.6.16-rc6-mm2/include/linux/mm.h
@@ -1019,10 +1019,17 @@ unsigned long page_cache_readahead(struc
 void handle_ra_miss(struct address_space *mapping, 
 		    struct file_ra_state *ra, pgoff_t offset);
 unsigned long max_sane_readahead(unsigned long nr);
+unsigned long
+page_cache_readahead_adaptive(struct address_space *mapping,
+			struct file_ra_state *ra, struct file *filp,
+			struct page *prev_page, struct page *page,
+			pgoff_t first_index, pgoff_t index, pgoff_t last_index);
 
 #ifdef CONFIG_ADAPTIVE_READAHEAD
+void fastcall readahead_cache_hit(struct file_ra_state *ra, struct page *page);
 extern int readahead_ratio;
 #else
+#define readahead_cache_hit(ra, page) do { } while (0)
 #define readahead_ratio 1
 #endif /* CONFIG_ADAPTIVE_READAHEAD */
 
--- linux-2.6.16-rc6-mm2.orig/mm/filemap.c
+++ linux-2.6.16-rc6-mm2/mm/filemap.c
@@ -833,14 +833,32 @@ void do_generic_mapping_read(struct addr
 		nr = nr - offset;
 
 		cond_resched();
-		if (index == next_index)
+
+		if (!prefer_adaptive_readahead() && index == next_index)
 			next_index = page_cache_readahead(mapping, &ra, filp,
 					index, last_index - index);
 
 find_page:
 		page = find_get_page(mapping, index);
+		if (prefer_adaptive_readahead()) {
+			if (unlikely(page == NULL)) {
+				ra.prev_page = prev_index;
+				page_cache_readahead_adaptive(mapping, &ra,
+						filp, prev_page, NULL,
+						*ppos >> PAGE_CACHE_SHIFT,
+						index, last_index);
+				page = find_get_page(mapping, index);
+			} else if (PageReadahead(page)) {
+				ra.prev_page = prev_index;
+				page_cache_readahead_adaptive(mapping, &ra,
+						filp, prev_page, page,
+						*ppos >> PAGE_CACHE_SHIFT,
+						index, last_index);
+			}
+		}
 		if (unlikely(page == NULL)) {
-			handle_ra_miss(mapping, &ra, index);
+			if (!prefer_adaptive_readahead())
+				handle_ra_miss(mapping, &ra, index);
 			goto no_cached_page;
 		}
 
@@ -848,6 +866,7 @@ find_page:
 			page_cache_release(prev_page);
 		prev_page = page;
 
+		readahead_cache_hit(&ra, page);
 		if (!PageUptodate(page))
 			goto page_not_up_to_date;
 page_ok:
@@ -991,6 +1010,8 @@ no_cached_page:
 
 out:
 	*_ra = ra;
+	if (prefer_adaptive_readahead())
+		_ra->prev_page = prev_index;
 
 	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;
 	if (cached_page)
@@ -1275,6 +1296,7 @@ struct page *filemap_nopage(struct vm_ar
 	unsigned long size, pgoff;
 	int did_readaround = 0, majmin = VM_FAULT_MINOR;
 
+	ra->flags |= RA_FLAG_MMAP;
 	pgoff = ((address-area->vm_start) >> PAGE_CACHE_SHIFT) + area->vm_pgoff;
 
 retry_all:
@@ -1292,19 +1314,33 @@ retry_all:
 	 *
 	 * For sequential accesses, we use the generic readahead logic.
 	 */
-	if (VM_SequentialReadHint(area))
+	if (!prefer_adaptive_readahead() && VM_SequentialReadHint(area))
 		page_cache_readahead(mapping, ra, file, pgoff, 1);
 
+
 	/*
 	 * Do we have something in the page cache already?
 	 */
 retry_find:
 	page = find_get_page(mapping, pgoff);
+	if (prefer_adaptive_readahead() && VM_SequentialReadHint(area)) {
+		if (!page) {
+			page_cache_readahead_adaptive(mapping, ra,
+						file, NULL, NULL,
+						pgoff, pgoff, pgoff + 1);
+			page = find_get_page(mapping, pgoff);
+		} else if (PageReadahead(page)) {
+			page_cache_readahead_adaptive(mapping, ra,
+						file, NULL, page,
+						pgoff, pgoff, pgoff + 1);
+		}
+	}
 	if (!page) {
 		unsigned long ra_pages;
 
 		if (VM_SequentialReadHint(area)) {
-			handle_ra_miss(mapping, ra, pgoff);
+			if (!prefer_adaptive_readahead())
+				handle_ra_miss(mapping, ra, pgoff);
 			goto no_cached_page;
 		}
 		ra->mmap_miss++;
@@ -1341,6 +1377,7 @@ retry_find:
 	if (!did_readaround)
 		ra->mmap_hit++;
 
+	readahead_cache_hit(ra, page);
 	/*
 	 * Ok, found a page in the page cache, now we need to check
 	 * that it's up-to-date.
@@ -1355,6 +1392,8 @@ success:
 	mark_page_accessed(page);
 	if (type)
 		*type = majmin;
+	if (prefer_adaptive_readahead())
+		ra->prev_page = page->index;
 	return page;
 
 outside_data_content:
--- linux-2.6.16-rc6-mm2.orig/mm/readahead.c
+++ linux-2.6.16-rc6-mm2/mm/readahead.c
@@ -1858,4 +1858,159 @@ static inline void get_readahead_bounds(
 	*ra_min = min(min(MIN_RA_PAGES + (pages>>13), KB(128)), *ra_max/2);
 }
 
+/**
+ * page_cache_readahead_adaptive - adaptive read-ahead main function
+ * @mapping, @ra, @filp: the same as page_cache_readahead()
+ * @prev_page: the page at @index-1, may be NULL to let the function find it
+ * @page: the page at @index, or NULL if non-present
+ * @begin_index, @index, @end_index: offsets into @mapping
+ * 		[@begin_index, @end_index) is the read the caller is performing
+ *	 	@index indicates the page to be read now
+ *
+ * page_cache_readahead_adaptive() is the entry point of the adaptive
+ * read-ahead logic. It tries a set of methods in turn to determine the
+ * appropriate readahead action and submits the readahead I/O.
+ *
+ * The caller is expected to point ra->prev_page to the previously accessed
+ * page, and to call it on two conditions:
+ * 1. @page == NULL
+ *    A cache miss happened, some pages have to be read in
+ * 2. @page != NULL && PageReadahead(@page)
+ *    A look-ahead mark encountered, this is set by a previous read-ahead
+ *    invocation to instruct the caller to give the function a chance to
+ *    check up and do next read-ahead in advance.
+ */
+unsigned long
+page_cache_readahead_adaptive(struct address_space *mapping,
+			struct file_ra_state *ra, struct file *filp,
+			struct page *prev_page, struct page *page,
+			pgoff_t begin_index, pgoff_t index, pgoff_t end_index)
+{
+	unsigned long size;
+	unsigned long ra_min;
+	unsigned long ra_max;
+	int ret;
+
+	might_sleep();
+
+	if (page) {
+		if(!TestClearPageReadahead(page))
+			return 0;
+		if (bdi_read_congested(mapping->backing_dev_info)) {
+			ra_account(ra, RA_EVENT_IO_CONGESTION,
+							end_index - index);
+			return 0;
+		}
+	}
+
+	if (page)
+		ra_account(ra, RA_EVENT_LOOKAHEAD_HIT,
+				ra->readahead_index - ra->lookahead_index);
+	else if (index)
+		ra_account(ra, RA_EVENT_CACHE_MISS, end_index - begin_index);
+
+	size = end_index - index;
+	get_readahead_bounds(ra, &ra_min, &ra_max);
+
+	/* readahead disabled? */
+	if (unlikely(!ra_max || !readahead_ratio)) {
+		size = max_sane_readahead(size);
+		goto readit;
+	}
+
+	/*
+	 * Start of file.
+	 */
+	if (index == 0)
+		return newfile_readahead(mapping, filp, ra, end_index, ra_min);
+
+	/*
+	 * State based sequential read-ahead.
+	 */
+	if (!disable_stateful_method &&
+			index == ra->lookahead_index && ra_cache_hit_ok(ra))
+		return state_based_readahead(mapping, filp, ra, page,
+							index, size, ra_max);
+
+	/*
+	 * Recover from possible thrashing.
+	 */
+	if (!page && index == ra->prev_page + 1 && ra_has_index(ra, index))
+		return thrashing_recovery_readahead(mapping, filp, ra,
+								index, ra_max);
+
+	/*
+	 * Backward read-ahead.
+	 */
+	if (!page && begin_index == index &&
+				try_read_backward(ra, index, size, ra_max))
+		return ra_dispatch(ra, mapping, filp);
+
+	/*
+	 * Context based sequential read-ahead.
+	 */
+	ret = try_context_based_readahead(mapping, ra, prev_page, page,
+							index, ra_min, ra_max);
+	if (ret > 0)
+		return ra_dispatch(ra, mapping, filp);
+	if (ret < 0)
+		return 0;
+
+	/* No action on look ahead time? */
+	if (page) {
+		ra_account(ra, RA_EVENT_LOOKAHEAD_NOACTION,
+						ra->readahead_index - index);
+		return 0;
+	}
+
+	/*
+	 * Random read that follows a sequential one.
+	 */
+	if (try_readahead_on_seek(ra, index, size, ra_max))
+		return ra_dispatch(ra, mapping, filp);
+
+	/*
+	 * Random read.
+	 */
+	if (size > ra_max)
+		size = ra_max;
+
+readit:
+	size = __do_page_cache_readahead(mapping, filp, index, size, 0);
+
+	ra_account(ra, RA_EVENT_READRANDOM, size);
+	dprintk("readrandom(ino=%lu, pages=%lu, index=%lu-%lu-%lu) = %lu\n",
+			mapping->host->i_ino, mapping->nrpages,
+			begin_index, index, end_index, size);
+
+	return size;
+}
+
+/**
+ * readahead_cache_hit - adaptive read-ahead feedback function
+ * @ra: file_ra_state which holds the readahead state
+ * @page: the page just accessed
+ *
+ * readahead_cache_hit() is the feedback route of the adaptive read-ahead
+ * logic. It must be called on every access on the read-ahead pages.
+ */
+void fastcall readahead_cache_hit(struct file_ra_state *ra, struct page *page)
+{
+	if (PageActive(page) || PageReferenced(page))
+		return;
+
+	if (!PageUptodate(page))
+		ra_account(ra, RA_EVENT_IO_BLOCK, 1);
+
+	if (!ra_has_index(ra, page->index))
+		return;
+
+	ra->cache_hits++;
+
+	if (page->index >= ra->ra_index)
+		ra_account(ra, RA_EVENT_READAHEAD_HIT, 1);
+	else
+		ra_account(ra, RA_EVENT_READAHEAD_HIT, -1);
+}
+
 #endif /* CONFIG_ADAPTIVE_READAHEAD */

--
