Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966421AbWKOHxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966421AbWKOHxW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966596AbWKOHvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:51:04 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:47822 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S966299AbWKOHuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:50:39 -0500
Message-ID: <363577027.15756@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20061115075031.524129110@localhost.localdomain>
References: <20061115075007.832957580@localhost.localdomain>
Date: Wed, 15 Nov 2006 15:50:29 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 22/28] readahead: call scheme
Content-Disposition: inline; filename=readahead-call-scheme.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The read-ahead logic is called when the reading hits
        - a PG_readahead marked page;
        - a non-present page.

ra.prev_page should be properly setup on entrance, and readahead_cache_hit()
should be called on every page reference as a feedback.

This call scheme achieves the following goals:
        - makes all stateful/stateless methods happy;
        - eliminates the cache hit problem naturally;
        - lives in harmony with application managed read-aheads via
          fadvise/madvise.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
DESC
readahead: initial method - expected read size - fix fastcall
EDESC
From: Fengguang Wu <wfg@mail.ustc.edu.cn>

Remove 'fastcall' directive for function readahead_close().

It has drawn concerns from Andrew Morton. Now I have some benchmarks
on it, and proved it as a _false_ optimization.

The tests are simple runs of the following command over _cached_ dirs:
                time find / > /dev/null

Table of summary(averages):
		user		sys		cpu		total
fastcall:	1.236		4.39		89%		6.2936
non-fastcall:	1.18		4.14166667	92%		5.75416667
stock:		1.25833333	4.14666667	93.3%		5.75866667

Detailed outputs:

readahead patched kernel with fastcall:
noglob find / > /dev/null  1.21s user 4.58s system 90% cpu 6.378 total
noglob find / > /dev/null  1.25s user 4.47s system 86% cpu 6.623 total
noglob find / > /dev/null  1.23s user 4.36s system 90% cpu 6.173 total
noglob find / > /dev/null  1.25s user 4.33s system 92% cpu 6.067 total
noglob find / > /dev/null  1.24s user 4.21s system 87% cpu 6.227 total

readahead patched kernel without fastcall:
noglob find / > /dev/null  1.21s user 4.46s system 95% cpu 5.962 total
noglob find / > /dev/null  1.26s user 4.58s system 94% cpu 6.142 total
noglob find / > /dev/null  1.10s user 3.80s system 86% cpu 5.661 total
noglob find / > /dev/null  1.13s user 3.98s system 95% cpu 5.355 total
noglob find / > /dev/null  1.18s user 4.00s system 89% cpu 5.805 total
noglob find / > /dev/null  1.22s user 4.03s system 93% cpu 5.600 total

stock kernel:
noglob find / > /dev/null  1.22s user 4.24s system 94% cpu 5.803 total
noglob find / > /dev/null  1.31s user 4.21s system 95% cpu 5.784 total
noglob find / > /dev/null  1.27s user 4.24s system 97% cpu 5.676 total
noglob find / > /dev/null  1.34s user 4.21s system 94% cpu 5.844 total
noglob find / > /dev/null  1.26s user 4.08s system 89% cpu 5.935 total
noglob find / > /dev/null  1.15s user 3.90s system 91% cpu 5.510 total

Similar regression has also been found by Voluspa <lista1@comhem.se>:
> "cd /usr ; time find . -type f -exec md5sum {} \;"
>
> 2.6.17-rc5 ------- 2.6.17-rc5-ar
>
> real 21m21.009s -- 21m37.663s
> user 3m20.784s  -- 3m20.701s
> sys  6m34.261s  -- 6m41.735s

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
DESC
readahead: call scheme - no fastcall for readahead_cache_hit()
EDESC
From: Wu Fengguang <wfg@mail.ustc.edu.cn>

Remove 'fastcall' directive for readahead_cache_hit().

It leads to unfavorable performance in the following micro benchmark on i386
with CONFIG_REGPARM=n:

Command:
        time cp cold /dev/null

Summary:
              user     sys     cpu    total
no-fastcall   1.24    24.88    90.9   28.57
fastcall      1.16    25.69    91.5   29.23

Details:
without fastcall:
cp cold /dev/null  1.27s user 24.63s system 91% cpu 28.348 total
cp cold /dev/null  1.17s user 25.09s system 91% cpu 28.653 total
cp cold /dev/null  1.24s user 24.75s system 91% cpu 28.448 total
cp cold /dev/null  1.20s user 25.04s system 91% cpu 28.614 total
cp cold /dev/null  1.31s user 24.67s system 91% cpu 28.499 total
cp cold /dev/null  1.30s user 24.87s system 91% cpu 28.530 total
cp cold /dev/null  1.26s user 24.84s system 91% cpu 28.542 total
cp cold /dev/null  1.16s user 25.15s system 90% cpu 28.925 total

with fastcall:
cp cold /dev/null  1.16s user 26.39s system 91% cpu 30.061 total
cp cold /dev/null  1.25s user 26.53s system 91% cpu 30.378 total
cp cold /dev/null  1.10s user 25.32s system 92% cpu 28.679 total
cp cold /dev/null  1.15s user 25.20s system 91% cpu 28.747 total
cp cold /dev/null  1.19s user 25.38s system 92% cpu 28.841 total
cp cold /dev/null  1.11s user 25.75s system 92% cpu 29.126 total
cp cold /dev/null  1.17s user 25.49s system 91% cpu 29.042 total
cp cold /dev/null  1.17s user 25.49s system 92% cpu 28.970 total

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
DESC
readahead-call-scheme fix
EDESC
From: Mike Galbraith <efault@gmx.de>

On Thu, 2006-08-10 at 02:19 -0700, Andrew Morton wrote:

> It would be interesting to try disabling CONFIG_ADAPTIVE_READAHEAD -
> perhaps that got broken.

A typo was pinning pagecache.  Fixes leak encountered with rpm -qaV.

Signed-off-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
--- linux-2.6.19-rc5-mm2.orig/include/linux/mm.h
+++ linux-2.6.19-rc5-mm2/include/linux/mm.h
@@ -1067,6 +1067,22 @@ unsigned long page_cache_readahead(struc
 void handle_ra_miss(struct address_space *mapping, 
 		    struct file_ra_state *ra, pgoff_t offset);
 unsigned long max_sane_readahead(unsigned long nr);
+unsigned long
+page_cache_readahead_adaptive(struct address_space *mapping,
+				struct file_ra_state *ra,
+				struct file *filp,
+				struct page *page,
+				pgoff_t offset,
+				unsigned long size);
+
+#if defined(CONFIG_DEBUG_READAHEAD)
+void readahead_cache_hit(struct file_ra_state *ra, struct page *page);
+#else
+static inline void readahead_cache_hit(struct file_ra_state *ra,
+					struct page *page)
+{
+}
+#endif
 
 #ifdef CONFIG_ADAPTIVE_READAHEAD
 extern int readahead_ratio;
--- linux-2.6.19-rc5-mm2.orig/mm/filemap.c
+++ linux-2.6.19-rc5-mm2/mm/filemap.c
@@ -974,16 +974,33 @@ void do_generic_mapping_read(struct addr
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
+				page_cache_readahead_adaptive(mapping,
+						&ra, filp, NULL,
+						index, last_index - index);
+				page = find_get_page(mapping, index);
+			} else if (PageReadahead(page)) {
+				ra.prev_page = prev_index;
+				page_cache_readahead_adaptive(mapping,
+						&ra, filp, page,
+						index, last_index - index);
+			}
+		}
 		if (unlikely(page == NULL)) {
-			handle_ra_miss(mapping, &ra, index);
+			if (!prefer_adaptive_readahead())
+				handle_ra_miss(mapping, &ra, index);
 			goto no_cached_page;
 		}
+		readahead_cache_hit(&ra, page);
 		if (!PageUptodate(page))
 			goto page_not_up_to_date;
 page_ok:
@@ -1131,6 +1148,8 @@ no_cached_page:
 
 out:
 	*_ra = ra;
+	if (prefer_adaptive_readahead())
+		_ra->prev_page = prev_index;
 
 	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;
 	if (cached_page)
@@ -1401,6 +1420,7 @@ struct page *filemap_nopage(struct vm_ar
 	unsigned long size, pgoff;
 	int did_readaround = 0, majmin = VM_FAULT_MINOR;
 
+	ra->flags |= RA_FLAG_MMAP;
 	pgoff = ((address-area->vm_start) >> PAGE_CACHE_SHIFT) + area->vm_pgoff;
 
 retry_all:
@@ -1418,7 +1438,7 @@ retry_all:
 	 *
 	 * For sequential accesses, we use the generic readahead logic.
 	 */
-	if (VM_SequentialReadHint(area))
+	if (!prefer_adaptive_readahead() && VM_SequentialReadHint(area))
 		page_cache_readahead(mapping, ra, file, pgoff, 1);
 
 	/*
@@ -1426,11 +1446,22 @@ retry_all:
 	 */
 retry_find:
 	page = find_get_page(mapping, pgoff);
+	if (prefer_adaptive_readahead() && VM_SequentialReadHint(area)) {
+		if (!page) {
+			page_cache_readahead_adaptive(mapping, ra, file, NULL,
+								   pgoff, 1);
+			page = find_get_page(mapping, pgoff);
+		} else if (PageReadahead(page)) {
+			page_cache_readahead_adaptive(mapping, ra, file, page,
+								   pgoff, 1);
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
@@ -1466,6 +1497,7 @@ retry_find:
 
 	if (!did_readaround)
 		ra->mmap_hit++;
+	readahead_cache_hit(ra, page);
 
 	/*
 	 * Ok, found a page in the page cache, now we need to check
@@ -1481,6 +1513,8 @@ success:
 	mark_page_accessed(page);
 	if (type)
 		*type = majmin;
+	if (prefer_adaptive_readahead())
+		ra->prev_page = page->index;
 	return page;
 
 outside_data_content:
--- linux-2.6.19-rc5-mm2.orig/mm/readahead.c
+++ linux-2.6.19-rc5-mm2/mm/readahead.c
@@ -1591,6 +1591,149 @@ static inline void get_readahead_bounds(
 
 #endif /* CONFIG_ADAPTIVE_READAHEAD */
 
+/**
+ * page_cache_readahead_adaptive - thrashing safe adaptive read-ahead
+ * @mapping, @ra, @filp, @offset, @req_size: the same as page_cache_readahead()
+ * @page: the page at @offset, or NULL if non-present
+ *
+ * page_cache_readahead_adaptive() is the entry point of the adaptive
+ * read-ahead logic. It tries a set of methods in turn to determine the
+ * appropriate readahead action and submits the readahead I/O.
+ *
+ * This function is expected to be called on two conditions:
+ * 1. @page == NULL
+ *    A cache miss happened, some pages have to be read in
+ * 2. @page != NULL && PageReadahead(@page)
+ *    A look-ahead mark encountered, this is set by a previous read-ahead
+ *    invocation to instruct the caller to give the function a chance to
+ *    check up and do next read-ahead in advance.
+ */
+unsigned long
+page_cache_readahead_adaptive(struct address_space *mapping,
+				struct file_ra_state *ra, struct file *filp,
+				struct page *page,
+				pgoff_t offset, unsigned long req_size)
+{
+	unsigned long ra_size;
+	unsigned long ra_min;
+	unsigned long ra_max;
+	int ret;
+
+	if (page) {
+		ClearPageReadahead(page);
+
+		/*
+		 * Defer read-ahead on IO congestion.
+		 */
+		if (bdi_read_congested(mapping->backing_dev_info)) {
+			ra_account(ra, RA_EVENT_IO_CONGESTION, req_size);
+			return 0;
+		}
+	}
+
+	if (page)
+		ra_account(ra, RA_EVENT_LOOKAHEAD_HIT, ra_lookahead_size(ra));
+	else if (offset)
+		ra_account(ra, RA_EVENT_CACHE_MISS, req_size);
+
+	get_readahead_bounds(ra, &ra_min, &ra_max);
+
+	/* read-ahead disabled? */
+	if (unlikely(!ra_max || !readahead_ratio)) {
+		ra_size = max_sane_readahead(req_size);
+		goto readit;
+	}
+
+	/*
+	 * Start of file.
+	 */
+	if (offset == 0)
+		return initial_readahead(mapping, filp, ra, req_size);
+
+	/*
+	 * State based sequential read-ahead.
+	 */
+	if (offset == ra->prev_page + 1 &&
+	    offset == ra->lookahead_index &&
+					!debug_option(disable_stateful_method))
+		return state_based_readahead(mapping, filp, ra, page,
+						offset, req_size, ra_max);
+
+	/*
+	 * Recover from possible thrashing.
+	 */
+	if (!page && offset == ra->prev_page + 1 && ra_has_index(ra, offset))
+		return thrashing_recovery_readahead(mapping, filp, ra,
+								offset, ra_max);
+
+	/*
+	 * Backward read-ahead.
+	 */
+	if (!page && try_backward_prefetching(ra, offset, req_size, ra_max))
+		return ra_submit(ra, mapping, filp);
+
+	/*
+	 * Context based sequential read-ahead.
+	 */
+	ret = try_context_based_readahead(mapping, ra, page,
+							offset, ra_min, ra_max);
+	if (ret > 0)
+		return ra_submit(ra, mapping, filp);
+	if (ret < 0)
+		return 0;
+
+	/* No action on look-ahead time? */
+	if (page) {
+		ra_account(ra, RA_EVENT_LOOKAHEAD_NOACTION,
+						ra->readahead_index - offset);
+		return 0;
+	}
+
+	/*
+	 * Random read.
+	 */
+	ra_size = min(req_size, ra_max);
+readit:
+	ra_size = __do_page_cache_readahead(mapping, filp, offset, ra_size, 0);
+
+	ra_account(ra, RA_EVENT_RANDOM_READ, ra_size);
+	dprintk("random_read(ino=%lu, req=%lu+%lu) = %lu\n",
+		mapping->host->i_ino, offset, req_size, ra_size);
+
+	return ra_size;
+}
+EXPORT_SYMBOL_GPL(page_cache_readahead_adaptive);
+
+#if CONFIG_DEBUG_READAHEAD
+/**
+ * readahead_cache_hit - adaptive read-ahead feedback function
+ * @ra: file_ra_state which holds the readahead state
+ * @page: the page just accessed
+ *
+ * This is the optional feedback route of the adaptive read-ahead logic.
+ * It must be called on every access on the read-ahead pages.
+ */
+void readahead_cache_hit(struct file_ra_state *ra, struct page *page)
+{
+	if (!prefer_adaptive_readahead())
+		return;
+
+	if (PageActive(page) || PageReferenced(page))
+		return;
+
+	if (!PageUptodate(page))
+		ra_account(ra, RA_EVENT_IO_BLOCK, 1);
+
+	if (!ra_has_index(ra, page->index))
+		return;
+
+	if (page->index >= ra->ra_index)
+		ra_account(ra, RA_EVENT_READAHEAD_HIT, 1);
+	else
+		ra_account(ra, RA_EVENT_READAHEAD_HIT, -1);
+}
+#endif /* CONFIG_DEBUG_READAHEAD */
+
 /*
  * Read-ahead events accounting.
  */

--
