Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbWEZLxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWEZLxn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 07:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWEZLxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 07:53:40 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:987 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932453AbWEZLxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 07:53:12 -0400
Message-ID: <348644389.06434@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060526115314.929319286@localhost.localdomain>
References: <20060526113906.084341801@localhost.localdomain>
Date: Fri, 26 May 2006 19:39:32 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 26/33] readahead: call scheme
Content-Disposition: inline; filename=readahead-call-scheme.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The read-ahead logic is called when the reading hits
        - a PG_readahead marked page;
        - a non-present page.

ra.prev_page should be properly setup on entrance, and readahead_cache_hit()
should be called on every page reference to maintain the cache_hits counter.

This call scheme achieves the following goals:
        - makes all stateful/stateless methods happy;
        - eliminates the cache hit problem naturally;
        - lives in harmony with application managed read-aheads via
          fadvise/madvise.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 include/linux/mm.h |    6 ++
 mm/filemap.c       |   51 ++++++++++++++++-
 mm/readahead.c     |  152 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 205 insertions(+), 4 deletions(-)

--- linux-2.6.17-rc4-mm3.orig/include/linux/mm.h
+++ linux-2.6.17-rc4-mm3/include/linux/mm.h
@@ -1033,6 +1033,12 @@ void handle_ra_miss(struct address_space
 		    struct file_ra_state *ra, pgoff_t offset);
 unsigned long max_sane_readahead(unsigned long nr);
 void fastcall readahead_close(struct file *file);
+unsigned long
+page_cache_readahead_adaptive(struct address_space *mapping,
+			struct file_ra_state *ra, struct file *filp,
+			struct page *prev_page, struct page *page,
+			pgoff_t first_index, pgoff_t index, pgoff_t last_index);
+void fastcall readahead_cache_hit(struct file_ra_state *ra, struct page *page);
 
 #ifdef CONFIG_ADAPTIVE_READAHEAD
 extern int readahead_ratio;
--- linux-2.6.17-rc4-mm3.orig/mm/filemap.c
+++ linux-2.6.17-rc4-mm3/mm/filemap.c
@@ -847,14 +847,32 @@ void do_generic_mapping_read(struct addr
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
 
@@ -862,6 +880,9 @@ find_page:
 			page_cache_release(prev_page);
 		prev_page = page;
 
+		if (prefer_adaptive_readahead())
+			readahead_cache_hit(&ra, page);
+
 		if (!PageUptodate(page))
 			goto page_not_up_to_date;
 page_ok:
@@ -1005,6 +1026,8 @@ no_cached_page:
 
 out:
 	*_ra = ra;
+	if (prefer_adaptive_readahead())
+		_ra->prev_page = prev_index;
 
 	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;
 	if (cached_page)
@@ -1290,6 +1313,7 @@ struct page *filemap_nopage(struct vm_ar
 	unsigned long size, pgoff;
 	int did_readaround = 0, majmin = VM_FAULT_MINOR;
 
+	ra->flags |= RA_FLAG_MMAP;
 	pgoff = ((address-area->vm_start) >> PAGE_CACHE_SHIFT) + area->vm_pgoff;
 
 retry_all:
@@ -1307,19 +1331,33 @@ retry_all:
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
@@ -1356,6 +1394,9 @@ retry_find:
 	if (!did_readaround)
 		ra->mmap_hit++;
 
+	if (prefer_adaptive_readahead())
+		readahead_cache_hit(ra, page);
+
 	/*
 	 * Ok, found a page in the page cache, now we need to check
 	 * that it's up-to-date.
@@ -1370,6 +1411,8 @@ success:
 	mark_page_accessed(page);
 	if (type)
 		*type = majmin;
+	if (prefer_adaptive_readahead())
+		ra->prev_page = page->index;
 	return page;
 
 outside_data_content:
--- linux-2.6.17-rc4-mm3.orig/mm/readahead.c
+++ linux-2.6.17-rc4-mm3/mm/readahead.c
@@ -1717,6 +1717,158 @@ static inline void get_readahead_bounds(
 					PAGES_KB(128)), *ra_max / 2);
 }
 
+/**
+ * page_cache_readahead_adaptive - thrashing safe adaptive read-ahead
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
+		return initial_readahead(mapping, filp, ra, size);
+
+	/*
+	 * State based sequential read-ahead.
+	 */
+	if (!debug_option(disable_stateful_method) &&
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
+	ra_account(ra, RA_EVENT_RANDOM_READ, size);
+	dprintk("random_read(ino=%lu, pages=%lu, index=%lu-%lu-%lu) = %lu\n",
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
 /*
  * When closing a normal readonly file,
  * 	- on cache hit:  increase `backing_dev_info.ra_expect_bytes' slowly;

--
