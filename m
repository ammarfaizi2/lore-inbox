Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318518AbSIKINx>; Wed, 11 Sep 2002 04:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318526AbSIKING>; Wed, 11 Sep 2002 04:13:06 -0400
Received: from packet.digeo.com ([12.110.80.53]:4240 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S318518AbSIKILy>;
	Wed, 11 Sep 2002 04:11:54 -0400
Message-ID: <3D7EFF71.791C51E6@digeo.com>
Date: Wed, 11 Sep 2002 01:31:45 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] truncate/invalidate_inode_pages[2] rewrite
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Sep 2002 08:16:33.0666 (UTC) FILETIME=[8A4FE620:01C2596B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rewrite these functions to use gang lookup.

- This probably has similar performance to the old code in the common case.

- It will be vastly quicker than current code for the worst case
  (single-page truncate).

- invalidate_inode_pages() has been changed.  It used to use
  page_count(page) as the "is it mapped into pagetables" heuristic.  It
  now uses the (page->pte.direct != 0) heuristic.

- Nukes the worst cause of scheduling latency in the kernel.

- The code is just a tad cleaner.



 include/linux/pagemap.h |    3 
 include/linux/pagevec.h |    3 
 mm/Makefile             |    2 
 mm/filemap.c            |  367 ++++--------------------------------------------
 mm/swap.c               |   23 +++
 mm/truncate.c           |  202 ++++++++++++++++++++++++++
 6 files changed, 264 insertions(+), 336 deletions(-)

--- 2.5.34/mm/filemap.c~truncate_inode_pages	Wed Sep 11 01:21:03 2002
+++ 2.5.34-akpm/mm/filemap.c	Wed Sep 11 01:21:03 2002
@@ -104,341 +104,6 @@ static inline int sync_page(struct page 
 	return 0;
 }
 
-/**
- * invalidate_inode_pages - Invalidate all the unlocked pages of one inode
- * @inode: the inode which pages we want to invalidate
- *
- * This function only removes the unlocked pages, if you want to
- * remove all the pages of one inode, you must call truncate_inode_pages.
- */
-
-void invalidate_inode_pages(struct inode * inode)
-{
-	struct list_head *head, *curr;
-	struct page * page;
-	struct address_space *mapping = inode->i_mapping;
-	struct pagevec pvec;
-
-	head = &mapping->clean_pages;
-	pagevec_init(&pvec);
-	write_lock(&mapping->page_lock);
-	curr = head->next;
-
-	while (curr != head) {
-		page = list_entry(curr, struct page, list);
-		curr = curr->next;
-
-		/* We cannot invalidate something in dirty.. */
-		if (PageDirty(page))
-			continue;
-
-		/* ..or locked */
-		if (TestSetPageLocked(page))
-			continue;
-
-		if (PagePrivate(page) && !try_to_release_page(page, 0))
-			goto unlock;
-
-		if (page_count(page) != 1)
-			goto unlock;
-
-		__remove_from_page_cache(page);
-		unlock_page(page);
-		if (!pagevec_add(&pvec, page))
-			__pagevec_release(&pvec);
-		continue;
-unlock:
-		unlock_page(page);
-		continue;
-	}
-
-	write_unlock(&mapping->page_lock);
-	pagevec_release(&pvec);
-}
-
-static int do_invalidatepage(struct page *page, unsigned long offset)
-{
-	int (*invalidatepage)(struct page *, unsigned long);
-	invalidatepage = page->mapping->a_ops->invalidatepage;
-	if (invalidatepage)
-		return (*invalidatepage)(page, offset);
-	return block_invalidatepage(page, offset);
-}
-
-static inline void truncate_partial_page(struct page *page, unsigned partial)
-{
-	memclear_highpage_flush(page, partial, PAGE_CACHE_SIZE-partial);
-	if (PagePrivate(page))
-		do_invalidatepage(page, partial);
-}
-
-/*
- * If truncate cannot remove the fs-private metadata from the page, the page
- * becomes anonymous.  It will be left on the LRU and may even be mapped into
- * user pagetables if we're racing with filemap_nopage().
- */
-static void truncate_complete_page(struct page *page)
-{
-	if (PagePrivate(page))
-		do_invalidatepage(page, 0);
-
-	clear_page_dirty(page);
-	ClearPageUptodate(page);
-	remove_from_page_cache(page);
-	page_cache_release(page);
-}
-
-/*
- * Writeback walks the page list in ->prev order, which is low-to-high file
- * offsets in the common case where he file was written linearly. So truncate
- * walks the page list in the opposite (->next) direction, to avoid getting
- * into lockstep with writeback's cursor.  To prune as many pages as possible
- * before the truncate cursor collides with the writeback cursor.
- */
-static int truncate_list_pages(struct address_space *mapping,
-	struct list_head *head, unsigned long start, unsigned *partial)
-{
-	struct list_head *curr;
-	struct page * page;
-	int unlocked = 0;
-	struct pagevec release_pvec;
-
-	pagevec_init(&release_pvec);
-restart:
-	curr = head->next;
-	while (curr != head) {
-		unsigned long offset;
-
-		page = list_entry(curr, struct page, list);
-		offset = page->index;
-
-		/* Is one of the pages to truncate? */
-		if ((offset >= start) || (*partial && (offset + 1) == start)) {
-			int failed;
-
-			page_cache_get(page);
-			failed = TestSetPageLocked(page);
-			if (!failed && PageWriteback(page)) {
-				unlock_page(page);
-				list_del(head);
-				list_add_tail(head, curr);
-				write_unlock(&mapping->page_lock);
-				wait_on_page_writeback(page);
-				if (!pagevec_add(&release_pvec, page))
-					__pagevec_release(&release_pvec);
-				unlocked = 1;
-				write_lock(&mapping->page_lock);
-				goto restart;
-			}
-
-			list_del(head);
-			if (!failed)		/* Restart after this page */
-				list_add(head, curr);
-			else			/* Restart on this page */
-				list_add_tail(head, curr);
-
-			write_unlock(&mapping->page_lock);
-			unlocked = 1;
-
- 			if (!failed) {
-				if (*partial && (offset + 1) == start) {
-					truncate_partial_page(page, *partial);
-					*partial = 0;
-				} else {
-					truncate_complete_page(page);
-				}
-				unlock_page(page);
-			} else {
- 				wait_on_page_locked(page);
-			}
-			if (!pagevec_add(&release_pvec, page))
-				__pagevec_release(&release_pvec);
-			cond_resched();
-			write_lock(&mapping->page_lock);
-			goto restart;
-		}
-		curr = curr->next;
-	}
-	if (pagevec_count(&release_pvec)) {
-		write_unlock(&mapping->page_lock);
-		pagevec_release(&release_pvec);
-		write_lock(&mapping->page_lock);
-		unlocked = 1;
-	}
-	return unlocked;
-}
-
-/*
- * Unconditionally clean all pages outside `start'.  The mapping lock
- * must be held.
- */
-static void clean_list_pages(struct address_space *mapping,
-		struct list_head *head, unsigned long start)
-{
-	struct page *page;
-	struct list_head *curr;
-
-	for (curr = head->next; curr != head; curr = curr->next) {
-		page = list_entry(curr, struct page, list);
-		if (page->index > start)
-			clear_page_dirty(page);
-	}
-}
-
-/**
- * truncate_inode_pages - truncate *all* the pages from an offset
- * @mapping: mapping to truncate
- * @lstart: offset from with to truncate
- *
- * Truncate the page cache at a set offset, removing the pages
- * that are beyond that offset (and zeroing out partial pages).
- * If any page is locked we wait for it to become unlocked.
- */
-void truncate_inode_pages(struct address_space * mapping, loff_t lstart) 
-{
-	unsigned long start = (lstart + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
-	unsigned partial = lstart & (PAGE_CACHE_SIZE - 1);
-	int unlocked;
-
-	write_lock(&mapping->page_lock);
-	clean_list_pages(mapping, &mapping->io_pages, start);
-	clean_list_pages(mapping, &mapping->dirty_pages, start);
-	do {
-		unlocked = truncate_list_pages(mapping,
-				&mapping->io_pages, start, &partial);
-		unlocked |= truncate_list_pages(mapping,
-				&mapping->dirty_pages, start, &partial);
-		unlocked |= truncate_list_pages(mapping,
-				&mapping->clean_pages, start, &partial);
-		unlocked |= truncate_list_pages(mapping,
-				&mapping->locked_pages, start, &partial);
-	} while (unlocked);
-	/* Traversed all three lists without dropping the lock */
-	write_unlock(&mapping->page_lock);
-}
-
-static inline int invalidate_this_page2(struct address_space * mapping,
-					struct page * page,
-					struct list_head * curr,
-					struct list_head * head)
-{
-	int unlocked = 1;
-
-	/*
-	 * The page is locked and we hold the mapping lock as well
-	 * so both page_count(page) and page_buffers stays constant here.
-	 * AKPM: fixme: No global lock any more.  Is this still OK?
-	 */
-	if (page_count(page) == 1 + !!page_has_buffers(page)) {
-		/* Restart after this page */
-		list_del(head);
-		list_add_tail(head, curr);
-
-		page_cache_get(page);
-		write_unlock(&mapping->page_lock);
-		truncate_complete_page(page);
-	} else {
-		if (page_has_buffers(page)) {
-			/* Restart after this page */
-			list_del(head);
-			list_add_tail(head, curr);
-
-			page_cache_get(page);
-			write_unlock(&mapping->page_lock);
-			do_invalidatepage(page, 0);
-		} else
-			unlocked = 0;
-
-		clear_page_dirty(page);
-		ClearPageUptodate(page);
-	}
-
-	return unlocked;
-}
-
-static int invalidate_list_pages2(struct address_space * mapping,
-				  struct list_head * head)
-{
-	struct list_head *curr;
-	struct page * page;
-	int unlocked = 0;
-	struct pagevec release_pvec;
-
-	pagevec_init(&release_pvec);
-restart:
-	curr = head->prev;
-	while (curr != head) {
-		page = list_entry(curr, struct page, list);
-
-		if (!TestSetPageLocked(page)) {
-			int __unlocked;
-
-			if (PageWriteback(page)) {
-				write_unlock(&mapping->page_lock);
-				wait_on_page_writeback(page);
-				unlocked = 1;
-				write_lock(&mapping->page_lock);
-				unlock_page(page);
-				goto restart;
-			}
-
-			__unlocked = invalidate_this_page2(mapping,
-						page, curr, head);
-			unlock_page(page);
-			unlocked |= __unlocked;
-			if (!__unlocked) {
-				curr = curr->prev;
-				continue;
-			}
-		} else {
-			/* Restart on this page */
-			list_del(head);
-			list_add(head, curr);
-
-			page_cache_get(page);
-			write_unlock(&mapping->page_lock);
-			unlocked = 1;
-			wait_on_page_locked(page);
-		}
-
-		if (!pagevec_add(&release_pvec, page))
-			__pagevec_release(&release_pvec);
-		cond_resched();
-		write_lock(&mapping->page_lock);
-		goto restart;
-	}
-	if (pagevec_count(&release_pvec)) {
-		write_unlock(&mapping->page_lock);
-		pagevec_release(&release_pvec);
-		write_lock(&mapping->page_lock);
-		unlocked = 1;
-	}
-	return unlocked;
-}
-
-/**
- * invalidate_inode_pages2 - Clear all the dirty bits around if it can't
- * free the pages because they're mapped.
- * @mapping: the address_space which pages we want to invalidate
- */
-void invalidate_inode_pages2(struct address_space *mapping)
-{
-	int unlocked;
-
-	write_lock(&mapping->page_lock);
-	do {
-		unlocked = invalidate_list_pages2(mapping,
-				&mapping->clean_pages);
-		unlocked |= invalidate_list_pages2(mapping,
-				&mapping->dirty_pages);
-		unlocked |= invalidate_list_pages2(mapping,
-				&mapping->io_pages);
-		unlocked |= invalidate_list_pages2(mapping,
-				&mapping->locked_pages);
-	} while (unlocked);
-	write_unlock(&mapping->page_lock);
-}
-
 /*
  * In-memory filesystems have to fail their
  * writepage function - and this has to be
@@ -838,6 +503,38 @@ repeat:
 	return page;
 }
 
+/**
+ * page_cache_gang_lookup - gang pagecache lookup
+ * @pages:	Where the resulting pages are placed
+ * @mapping:	The address_space to search
+ * @start:	The starting page index
+ * @nr_pages:	The maximum number of pages
+ *
+ * page_cache_gang_lookup() will search for and return a group of up to
+ * @nr_pages pages in the mapping.  The pages are placed at @pages.
+ * page_cache_gang_lookup() takes a reference against the returned pages.
+ *
+ * The search returns a group of mapping-contiguous pages with ascending
+ * indexes.  There may be holes in the indices due to not-present pages.
+ *
+ * page_cache_gang_lookup() returns the number of pages which were found.
+ */
+unsigned int
+page_cache_gang_lookup(struct page **pages, struct address_space *mapping,
+		pgoff_t start, unsigned int nr_pages)
+{
+	unsigned int i;
+	unsigned int ret;
+
+	read_lock(&mapping->page_lock);
+	ret = radix_tree_gang_lookup(&mapping->page_tree,
+				(void **)pages, start, nr_pages);
+	for (i = 0; i < ret; i++)
+		page_cache_get(pages[i]);
+	read_unlock(&mapping->page_lock);
+	return ret;
+}
+
 /*
  * Same as grab_cache_page, but do not wait if the page is unavailable.
  * This is intended for speculative data generators, where the data can
--- /dev/null	Thu Aug 30 13:30:55 2001
+++ 2.5.34-akpm/mm/truncate.c	Wed Sep 11 01:21:03 2002
@@ -0,0 +1,202 @@
+/*
+ * mm/truncate.c - code for taking down pages from address_spaces
+ *
+ * Copyright (C) 2002, Linus Torvalds
+ *
+ * 10Sep2002	akpm@zip.com.au
+ *		Initial version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/pagevec.h>
+#include <linux/buffer_head.h>	/* grr. try_to_release_page,
+				   block_invalidatepage */
+
+static int do_invalidatepage(struct page *page, unsigned long offset)
+{
+	int (*invalidatepage)(struct page *, unsigned long);
+	invalidatepage = page->mapping->a_ops->invalidatepage;
+	if (invalidatepage == NULL)
+		invalidatepage = block_invalidatepage;
+	return (*invalidatepage)(page, offset);
+}
+
+static inline void truncate_partial_page(struct page *page, unsigned partial)
+{
+	memclear_highpage_flush(page, partial, PAGE_CACHE_SIZE-partial);
+	if (PagePrivate(page))
+		do_invalidatepage(page, partial);
+}
+
+/*
+ * If truncate cannot remove the fs-private metadata from the page, the page
+ * becomes anonymous.  It will be left on the LRU and may even be mapped into
+ * user pagetables if we're racing with filemap_nopage().
+ */
+static void truncate_complete_page(struct page *page)
+{
+	if (PagePrivate(page))
+		do_invalidatepage(page, 0);
+
+	clear_page_dirty(page);
+	ClearPageUptodate(page);
+	remove_from_page_cache(page);
+	page_cache_release(page);
+}
+
+/**
+ * truncate_inode_pages - truncate *all* the pages from an offset
+ * @mapping: mapping to truncate
+ * @lstart: offset from with to truncate
+ *
+ * Truncate the page cache at a set offset, removing the pages that are beyond
+ * that offset (and zeroing out partial pages).
+ *
+ * Truncate takes two passes - the first pass is nonblocking.  It will not
+ * block on page locks and it will not block on writeback.  The second pass
+ * will wait.  This is to prevent as much IO as possible in the affected region.
+ * The first pass will remove most pages, so the search cost of the second pass
+ * is low.
+ *
+ * Called under (and serialised by) inode->i_sem.
+ */
+void truncate_inode_pages(struct address_space *mapping, loff_t lstart)
+{
+	const pgoff_t start = (lstart + PAGE_CACHE_SIZE-1) >> PAGE_CACHE_SHIFT;
+	const unsigned partial = lstart & (PAGE_CACHE_SIZE - 1);
+	struct pagevec pvec;
+	pgoff_t next;
+	int i;
+
+	pagevec_init(&pvec);
+	next = start;
+	while (pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE)) {
+		for (i = 0; i < pagevec_count(&pvec); i++) {
+			struct page *page = pvec.pages[i];
+
+			next = page->index + 1;
+			if (TestSetPageLocked(page))
+				continue;
+			if (PageWriteback(page)) {
+				unlock_page(page);
+				continue;
+			}
+			truncate_complete_page(page);
+			unlock_page(page);
+		}
+		pagevec_release(&pvec);
+		cond_resched();
+	}
+
+	if (partial) {
+		struct page *page = find_lock_page(mapping, lstart);
+		if (page) {
+			wait_on_page_writeback(page);
+			truncate_partial_page(page, partial);
+			unlock_page(page);
+		}
+	}
+
+	next = start;
+	for ( ; ; ) {
+		if (!pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE)) {
+			if (next == start)
+				break;
+			next = start;
+			continue;
+		}
+		for (i = 0; i < pagevec_count(&pvec); i++) {
+			struct page *page = pvec.pages[i];
+
+			lock_page(page);
+			wait_on_page_writeback(page);
+			next = page->index + 1;
+			truncate_complete_page(page);
+			unlock_page(page);
+		}
+		pagevec_release(&pvec);
+	}
+	if (lstart == 0 && mapping->nrpages)
+		printk("%s: I goofed!\n", __FUNCTION__);
+}
+
+/**
+ * invalidate_inode_pages - Invalidate all the unlocked pages of one inode
+ * @inode: the inode which pages we want to invalidate
+ *
+ * This function only removes the unlocked pages, if you want to
+ * remove all the pages of one inode, you must call truncate_inode_pages.
+ *
+ * invalidate_inode_pages() is nonblocking.  It will not invalidate pages which
+ * are dirty, locked, under writeback or mapped into pagetables.
+ *
+ * FIXME: should take a mapping *.
+ */
+void invalidate_inode_pages(struct inode *inode)
+{
+	struct address_space *mapping = inode->i_mapping;
+	int i;
+	pgoff_t next = 0;
+	struct pagevec pvec;
+
+	pagevec_init(&pvec);
+	while (pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE)) {
+		for (i = 0; i < pagevec_count(&pvec); i++) {
+			struct page *page = pvec.pages[i];
+
+			if (TestSetPageLocked(page)) {
+				next++;
+				continue;
+			}
+			next = page->index + 1;
+			if (PageDirty(page) || PageWriteback(page))
+				goto unlock;
+			if (PagePrivate(page) && !try_to_release_page(page, 0))
+				goto unlock;
+			if (page_mapped(page))
+				goto unlock;
+			truncate_complete_page(page);
+unlock:
+			unlock_page(page);
+		}
+		pagevec_release(&pvec);
+		cond_resched();
+	}
+}
+
+/**
+ * invalidate_inode_pages2 - remove all unmapped pages from an address_space
+ * @mapping - the address_space
+ *
+ * invalidate_inode_pages2() is like truncate_inode_pages(), except for the case
+ * where the page is seen to be mapped into process pagetables.  In that case,
+ * the page is marked clean but is left attached to its address_space.
+ *
+ * FIXME: invalidate_inode_pages2() is probably trivially livelockable.
+ */
+void invalidate_inode_pages2(struct address_space *mapping)
+{
+	pgoff_t next = 0;
+	int i;
+	struct pagevec pvec;
+
+	pagevec_init(&pvec);
+	while (!pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE)) {
+		for (i = 0; i < pagevec_count(&pvec); i++) {
+			struct page *page = pvec.pages[i];
+
+			lock_page(page);
+			if (page->mapping) {	/* truncate race? */
+				wait_on_page_writeback(page);
+				next = page->index + 1;
+				if (!page_mapped(page))
+					truncate_complete_page(page);
+			}
+			unlock_page(page);
+		}
+		pagevec_release(&pvec);
+		cond_resched();
+	}
+}
--- 2.5.34/mm/Makefile~truncate_inode_pages	Wed Sep 11 01:21:03 2002
+++ 2.5.34-akpm/mm/Makefile	Wed Sep 11 01:21:03 2002
@@ -16,6 +16,6 @@ obj-y	 := memory.o mmap.o filemap.o mpro
 	    vmalloc.o slab.o bootmem.o swap.o vmscan.o page_io.o \
 	    page_alloc.o swap_state.o swapfile.o numa.o oom_kill.o \
 	    shmem.o highmem.o mempool.o msync.o mincore.o readahead.o \
-	    pdflush.o page-writeback.o rmap.o madvise.o
+	    pdflush.o page-writeback.o rmap.o madvise.o truncate.o
 
 include $(TOPDIR)/Rules.make
--- 2.5.34/mm/swap.c~truncate_inode_pages	Wed Sep 11 01:21:03 2002
+++ 2.5.34-akpm/mm/swap.c	Wed Sep 11 01:21:03 2002
@@ -273,6 +273,29 @@ void pagevec_strip(struct pagevec *pvec)
 	}
 }
 
+/**
+ * pagevec_lookup - gang pagecache lookup
+ * @pvec:	Where the resulting pages are placed
+ * @mapping:	The address_space to search
+ * @start:	The starting page index
+ * @nr_pages:	The maximum number of pages
+ *
+ * pagevec_lookup() will search for and return a group of up to @nr_pages pages
+ * in the mapping.  The pages are placed in @pvec.  pagevec_lookup() takes a
+ * reference against the pages in @pvec.
+ *
+ * The search returns a group of mapping-contiguous pages with ascending
+ * indexes.  There may be holes in the indices due to not-present pages.
+ *
+ * pagevec_lookup() returns the number of pages which were found.
+ */
+unsigned int pagevec_lookup(struct pagevec *pvec, struct address_space *mapping,
+		pgoff_t start, unsigned int nr_pages)
+{
+	pvec->nr = page_cache_gang_lookup(pvec->pages, mapping, start, nr_pages);
+	return pagevec_count(pvec);
+}
+
 /*
  * Perform any setup for the swap system
  */
--- 2.5.34/include/linux/pagemap.h~truncate_inode_pages	Wed Sep 11 01:21:03 2002
+++ 2.5.34-akpm/include/linux/pagemap.h	Wed Sep 11 01:21:03 2002
@@ -41,6 +41,9 @@ extern struct page * find_trylock_page(s
 				unsigned long index);
 extern struct page * find_or_create_page(struct address_space *mapping,
 				unsigned long index, unsigned int gfp_mask);
+unsigned int
+page_cache_gang_lookup(struct page **pages, struct address_space *mapping,
+		pgoff_t start, unsigned int nr_pages);
 
 /*
  * Returns locked page at given index in given cache, creating it if needed.
--- 2.5.34/include/linux/pagevec.h~truncate_inode_pages	Wed Sep 11 01:21:03 2002
+++ 2.5.34-akpm/include/linux/pagevec.h	Wed Sep 11 01:21:03 2002
@@ -8,6 +8,7 @@
 #define PAGEVEC_SIZE	16
 
 struct page;
+struct address_space;
 
 struct pagevec {
 	unsigned nr;
@@ -22,6 +23,8 @@ void __pagevec_deactivate_active(struct 
 void lru_add_drain(void);
 void pagevec_deactivate_inactive(struct pagevec *pvec);
 void pagevec_strip(struct pagevec *pvec);
+unsigned int pagevec_lookup(struct pagevec *pvec, struct address_space *mapping,
+		pgoff_t start, unsigned int nr_pages);
 
 static inline void pagevec_init(struct pagevec *pvec)
 {

.
