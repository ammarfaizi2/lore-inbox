Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbVLCHLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVLCHLp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 02:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbVLCHLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 02:11:32 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:24255 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751164AbVLCHLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 02:11:06 -0500
Message-Id: <20051203071712.097406000@localhost.localdomain>
References: <20051203071444.260068000@localhost.localdomain>
Date: Sat, 03 Dec 2005 15:14:49 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 05/16] readahead: call scheme
Content-Disposition: inline; filename=readahead-call-scheme.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An new page flag PG_readahead is introduced as a look-ahead mark.
The look-ahead mark corresponds to `ahead_start' of the current logic.

The read-ahead logic is called when
        - read reaches a look-ahead mark;
        - read on a non-present page.

And ra_access() is called on every page reference to maintain the cache_hit
counter.

This scheme has the following benefits:
        - makes all stateful/stateless methods happy;
        - eliminates the cache hit problem naturally;
        - lives in harmony with application managed read-aheads via
          fadvise/madvise.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 include/linux/mm.h         |   13 +++
 include/linux/page-flags.h |    5 +
 mm/filemap.c               |   73 ++++++++++++++++--
 mm/page_alloc.c            |    2 
 mm/readahead.c             |  176 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 258 insertions(+), 11 deletions(-)

--- linux.orig/include/linux/page-flags.h
+++ linux/include/linux/page-flags.h
@@ -77,6 +77,7 @@
 #define PG_nosave_free		18	/* Free, should not be written */
 #define PG_uncached		19	/* Page has been mapped as uncached */
 #define PG_activate		20	/* delayed activate */
+#define PG_readahead		21	/* check readahead when reading this page */
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -321,6 +322,10 @@ extern void __mod_page_state(unsigned lo
 #define TestClearPageActivate(page) test_and_clear_bit(PG_activate, &(page)->flags)
 #define TestSetPageActivate(page) test_and_set_bit(PG_activate, &(page)->flags)
 
+#define PageReadahead(page)	test_bit(PG_readahead, &(page)->flags)
+#define SetPageReadahead(page)	set_bit(PG_readahead, &(page)->flags)
+#define TestClearPageReadahead(page) test_and_clear_bit(PG_readahead, &(page)->flags)
+
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
--- linux.orig/include/linux/mm.h
+++ linux/include/linux/mm.h
@@ -1008,6 +1008,13 @@ unsigned long page_cache_readahead(struc
 void handle_ra_miss(struct address_space *mapping, 
 		    struct file_ra_state *ra, pgoff_t offset);
 unsigned long max_sane_readahead(unsigned long nr);
+unsigned long
+page_cache_readahead_adaptive(struct address_space *mapping,
+			struct file_ra_state *ra, struct file *filp,
+			struct page *prev_page, struct page *page,
+			pgoff_t first_index,
+			pgoff_t index, pgoff_t last_index);
+void fastcall ra_access(struct file_ra_state *ra, struct page *page);
 
 #ifdef CONFIG_DEBUG_FS
 extern u32 readahead_debug_level;
@@ -1016,6 +1023,12 @@ extern u32 readahead_debug_level;
 #define READAHEAD_DEBUG_LEVEL(n)	(0)
 #endif
 
+extern int readahead_ratio;
+static inline int prefer_adaptive_readahead(void)
+{
+	return readahead_ratio > 9;
+}
+
 /* Do stack extension */
 extern int expand_stack(struct vm_area_struct *vma, unsigned long address);
 #ifdef CONFIG_IA64
--- linux.orig/mm/page_alloc.c
+++ linux/mm/page_alloc.c
@@ -543,7 +543,7 @@ static int prep_new_page(struct page *pa
 
 	page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
 			1 << PG_referenced | 1 << PG_arch_1 |
-			1 << PG_activate |
+			1 << PG_activate | 1 << PG_readahead |
 			1 << PG_checked | 1 << PG_mappedtodisk);
 	set_page_private(page, 0);
 	set_page_refs(page, order);
--- linux.orig/mm/filemap.c
+++ linux/mm/filemap.c
@@ -766,10 +766,12 @@ void do_generic_mapping_read(struct addr
 	unsigned long prev_index;
 	loff_t isize;
 	struct page *cached_page;
+	struct page *prev_page;
 	int error;
 	struct file_ra_state ra = *_ra;
 
 	cached_page = NULL;
+	prev_page = NULL;
 	index = *ppos >> PAGE_CACHE_SHIFT;
 	next_index = index;
 	prev_index = ra.prev_page;
@@ -802,16 +804,42 @@ void do_generic_mapping_read(struct addr
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
+				page_cache_readahead_adaptive(mapping, &ra,
+						filp, prev_page, NULL,
+						*ppos >> PAGE_CACHE_SHIFT,
+						index, last_index);
+				page = find_get_page(mapping, index);
+			} else if (PageReadahead(page)) {
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
+		if (prev_page)
+			page_cache_release(prev_page);
+		prev_page = page;
+
+		ra_access(&ra, page);
+		if (READAHEAD_DEBUG_LEVEL(7))
+			printk(KERN_DEBUG "read-file(ino=%lu, idx=%lu, io=%s)\n",
+				inode->i_ino, index,
+				PageUptodate(page) ? "hit" : "miss");
+
 		if (!PageUptodate(page))
 			goto page_not_up_to_date;
 page_ok:
@@ -846,7 +874,6 @@ page_ok:
 		index += offset >> PAGE_CACHE_SHIFT;
 		offset &= ~PAGE_CACHE_MASK;
 
-		page_cache_release(page);
 		if (ret == nr && desc->count)
 			continue;
 		goto out;
@@ -858,7 +885,6 @@ page_not_up_to_date:
 		/* Did it get unhashed before we got the lock? */
 		if (!page->mapping) {
 			unlock_page(page);
-			page_cache_release(page);
 			continue;
 		}
 
@@ -888,7 +914,6 @@ readpage:
 					 * invalidate_inode_pages got it
 					 */
 					unlock_page(page);
-					page_cache_release(page);
 					goto find_page;
 				}
 				unlock_page(page);
@@ -909,7 +934,6 @@ readpage:
 		isize = i_size_read(inode);
 		end_index = (isize - 1) >> PAGE_CACHE_SHIFT;
 		if (unlikely(!isize || index > end_index)) {
-			page_cache_release(page);
 			goto out;
 		}
 
@@ -918,7 +942,6 @@ readpage:
 		if (index == end_index) {
 			nr = ((isize - 1) & ~PAGE_CACHE_MASK) + 1;
 			if (nr <= offset) {
-				page_cache_release(page);
 				goto out;
 			}
 		}
@@ -928,7 +951,6 @@ readpage:
 readpage_error:
 		/* UHHUH! A synchronous read error occurred. Report it */
 		desc->error = error;
-		page_cache_release(page);
 		goto out;
 
 no_cached_page:
@@ -953,15 +975,22 @@ no_cached_page:
 		}
 		page = cached_page;
 		cached_page = NULL;
+		if (prev_page)
+			page_cache_release(prev_page);
+		prev_page = page;
 		goto readpage;
 	}
 
 out:
 	*_ra = ra;
+	if (prefer_adaptive_readahead())
+		_ra->prev_page = prev_index;
 
 	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;
 	if (cached_page)
 		page_cache_release(cached_page);
+	if (prev_page)
+		page_cache_release(prev_page);
 	if (filp)
 		file_accessed(filp);
 }
@@ -1257,19 +1286,33 @@ retry_all:
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
@@ -1306,6 +1349,14 @@ retry_find:
 	if (!did_readaround)
 		ra->mmap_hit++;
 
+	ra_access(ra, page);
+	if (READAHEAD_DEBUG_LEVEL(6))
+		printk(KERN_DEBUG "read-mmap(ino=%lu, idx=%lu, hint=%s, io=%s)\n",
+			inode->i_ino, pgoff,
+			VM_RandomReadHint(area) ? "random" :
+			(VM_SequentialReadHint(area) ? "sequential" : "none"),
+			PageUptodate(page) ? "hit" : "miss");
+
 	/*
 	 * Ok, found a page in the page cache, now we need to check
 	 * that it's up-to-date.
@@ -1320,6 +1371,8 @@ success:
 	mark_page_accessed(page);
 	if (type)
 		*type = majmin;
+	if (prefer_adaptive_readahead())
+		ra->prev_page = page->index;
 	return page;
 
 outside_data_content:
--- linux.orig/mm/readahead.c
+++ linux/mm/readahead.c
@@ -20,6 +20,45 @@
 #define MAX_RA_PAGES	KB(VM_MAX_READAHEAD)
 #define MIN_RA_PAGES	KB(VM_MIN_READAHEAD)
 
+/* Detailed classification of read-ahead behaviors. */
+#define RA_CLASS_SHIFT 4
+#define RA_CLASS_MASK  ((1 << RA_CLASS_SHIFT) - 1)
+enum ra_class {
+	RA_CLASS_ALL,
+	RA_CLASS_NEWFILE,
+	RA_CLASS_STATE,
+	RA_CLASS_CONTEXT,
+	RA_CLASS_CONTEXT_ACCELERATED,
+	RA_CLASS_AROUND,
+	RA_CLASS_BACKWARD,
+	RA_CLASS_RANDOM_THRASHING,
+	RA_CLASS_RANDOM_SEEK,
+	RA_CLASS_END,
+};
+
+/* Read-ahead events to be accounted. */
+enum ra_event {
+	RA_EVENT_CACHE_MISS,		/* read cache misses */
+	RA_EVENT_READRANDOM,		/* random reads */
+	RA_EVENT_IO_CONGESTION,		/* io congestion */
+	RA_EVENT_IO_CACHE_HIT,		/* canceled io due to cache hit */
+	RA_EVENT_IO_BLOCK,		/* read on locked page */
+
+	RA_EVENT_READAHEAD,		/* read-ahead issued */
+	RA_EVENT_READAHEAD_HIT,		/* read-ahead page hit */
+	RA_EVENT_LOOKAHEAD,		/* look-ahead issued */
+	RA_EVENT_LOOKAHEAD_HIT,		/* look-ahead mark hit */
+	RA_EVENT_LOOKAHEAD_NOACTION,	/* look-ahead mark ignored */
+	RA_EVENT_READAHEAD_MMAP,	/* read-ahead for memory mapped file */
+	RA_EVENT_READAHEAD_EOF,		/* read-ahead reaches EOF */
+	RA_EVENT_READAHEAD_SHRINK,	/* ra_size decreased, reflects var. */
+	RA_EVENT_READAHEAD_THRASHING,	/* read-ahead thrashing happened */
+	RA_EVENT_READAHEAD_MUTILATE,	/* read-ahead request mutilated */
+	RA_EVENT_READAHEAD_RESCUE,	/* read-ahead rescued */
+
+	RA_EVENT_END
+};
+
 #define next_page(pg) (list_entry((pg)->lru.prev, struct page, lru))
 #define prev_page(pg) (list_entry((pg)->lru.next, struct page, lru))
 
@@ -755,3 +794,140 @@ out:
 
 	return nr_pages ? index : 0;
 }
+
+/*
+ * This is the entry point of the adaptive read-ahead logic.
+ *
+ * It is only called on two conditions:
+ * 1. page == NULL
+ *    A cache miss happened, it can be either a random read or a sequential one.
+ * 2. page != NULL
+ *    There is a look-ahead mark(PG_readahead) from a previous sequential read.
+ *    It's time to do some checking and submit the next read-ahead IO.
+ *
+ * That has the merits of:
+ * - makes all stateful/stateless methods happy;
+ * - eliminates the cache hit problem naturally;
+ * - lives in harmony with application managed read-aheads via fadvise/madvise.
+ */
+unsigned long
+page_cache_readahead_adaptive(struct address_space *mapping,
+			struct file_ra_state *ra, struct file *filp,
+			struct page *prev_page, struct page *page,
+			pgoff_t begin_index,
+			pgoff_t index, pgoff_t end_index)
+{
+	unsigned long size;
+	unsigned long ra_min;
+	unsigned long ra_max;
+	int ret;
+
+	if (page) {
+		if(!TestClearPageReadahead(page))
+			return 0;
+		if (bdi_read_congested(mapping->backing_dev_info))
+			return 0;
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
+	if (unlikely(!ra_min || !readahead_ratio)) {
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
+	if (!disable_stateful_method() &&
+		index == ra->lookahead_index &&
+		(page || index == ra->readahead_index) &&
+		(ra_cache_hit_ok(ra) ||
+		 end_index - begin_index >= ra_max))
+		return state_based_readahead(mapping, filp, ra, page,
+								size, ra_max);
+
+	/*
+	 * Backward read-ahead.
+	 */
+	if (try_read_backward(ra, begin_index, end_index, size, ra_min, ra_max))
+		return ra_dispatch(ra, mapping, filp);
+
+	/*
+	 * Context based sequential read-ahead.
+	 */
+	ret = try_context_based_readahead(mapping, ra, prev_page, page,
+						index, size, ra_min, ra_max);
+	if (ret > 0)
+		return ra_dispatch(ra, mapping, filp);
+	if (ret < 0)
+		return 0;
+
+	/* No action on look ahead time? */
+	if (page) {
+		ra_account(ra, RA_EVENT_LOOKAHEAD_NOACTION,
+					ra->readahead_index - index);
+		return 0;
+	}
+
+	/*
+	 * Random read that follows a sequential one.
+	 */
+	if (try_random_readahead(ra, index, size, ra_max))
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
+/*
+ * Call me!
+ */
+void fastcall ra_access(struct file_ra_state *ra, struct page *page)
+{
+	if (page->flags & ((1 << PG_active)   |
+			   (1 << PG_activate) |
+			   (1 << PG_referenced)))
+		return;
+
+	if (!PageUptodate(page))
+		ra_account(ra, RA_EVENT_IO_BLOCK, 1);
+
+	if (!ra_has_index(ra, page->index))
+		return;
+
+	ra->cache_hit++;
+
+	if (page->index >= ra->ra_index)
+		ra_account(ra, RA_EVENT_READAHEAD_HIT, 1);
+	else
+		ra_account(ra, RA_EVENT_READAHEAD_HIT, -1);
+}
+

--
