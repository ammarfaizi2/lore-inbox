Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317980AbSHKH0H>; Sun, 11 Aug 2002 03:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318080AbSHKH0C>; Sun, 11 Aug 2002 03:26:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35334 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317980AbSHKHZ3>;
	Sun, 11 Aug 2002 03:25:29 -0400
Message-ID: <3D56149B.C6E9414@zip.com.au>
Date: Sun, 11 Aug 2002 00:39:07 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 9/21] batched addition of pages to the LRU
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The patch goes through the various places which were calling
lru_cache_add() against bulk pages and batches them up.

Also.  This whole patch series improves the behaviour of the system
under heavy writeback load.  There is a reduction in page allocation
failures, some reduction in loss of interactivity due to page
allocators getting stuck on writeback from the VM.  (This is still bad
though).

I think it's due to the change here in mpage_writepages().  That
function was originally unconditionally refiling written-back pages to
the head of the inactive list.  The theory being that they should be
moved out of the way of page allocators, who would end up waiting on
them.

It appears that this simply had the effect of pushing dirty, unwritten
data closer to the tail of the inactive list, making things worse.

So instead, if the caller is (typically) balance_dirty_pages() then
leave the pages where they are on the LRU.

If the caller is PF_MEMALLOC then the pages *have* to be refiled.  This
is because VM writeback is clustered along mapping->dirty_pages, and
it's almost certain that the pages which are being written are near the
tail of the LRU.  If they were left there, page allocators would block
on them too soon.  It would effectively become a synchronous write.



 fs/mpage.c              |   14 ++++++++++---
 include/linux/pagemap.h |    2 +
 mm/filemap.c            |   50 +++++++++++++++++++++++++++++++++++-------------
 mm/readahead.c          |   13 ++++++++++--
 mm/shmem.c              |    2 -
 mm/swap_state.c         |    6 +++--
 6 files changed, 66 insertions(+), 21 deletions(-)

--- 2.5.31/fs/mpage.c~batched-lru-add	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/fs/mpage.c	Sun Aug 11 00:20:57 2002
@@ -263,18 +263,25 @@ mpage_readpages(struct address_space *ma
 	struct bio *bio = NULL;
 	unsigned page_idx;
 	sector_t last_block_in_bio = 0;
+	struct pagevec lru_pvec;
 
+	pagevec_init(&lru_pvec);
 	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
 		struct page *page = list_entry(pages->prev, struct page, list);
 
 		prefetchw(&page->flags);
 		list_del(&page->list);
-		if (!add_to_page_cache(page, mapping, page->index))
+		if (!add_to_page_cache(page, mapping, page->index)) {
 			bio = do_mpage_readpage(bio, page,
 					nr_pages - page_idx,
 					&last_block_in_bio, get_block);
-		page_cache_release(page);
+			if (!pagevec_add(&lru_pvec, page))
+				__pagevec_lru_add(&lru_pvec);
+		} else {
+			page_cache_release(page);
+		}
 	}
+	pagevec_lru_add(&lru_pvec);
 	BUG_ON(!list_empty(pages));
 	if (bio)
 		mpage_bio_submit(READ, bio);
@@ -566,7 +573,8 @@ mpage_writepages(struct address_space *m
 				bio = mpage_writepage(bio, page, get_block,
 						&last_block_in_bio, &ret);
 			}
-			if (!PageActive(page) && PageLRU(page)) {
+			if ((current->flags & PF_MEMALLOC) &&
+					!PageActive(page) && PageLRU(page)) {
 				if (!pagevec_add(&pvec, page))
 					pagevec_deactivate_inactive(&pvec);
 				page = NULL;
--- 2.5.31/mm/filemap.c~batched-lru-add	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/mm/filemap.c	Sun Aug 11 00:21:02 2002
@@ -21,6 +21,7 @@
 #include <linux/iobuf.h>
 #include <linux/hash.h>
 #include <linux/writeback.h>
+#include <linux/pagevec.h>
 #include <linux/security.h>
 /*
  * This is needed for the following functions:
@@ -530,27 +531,37 @@ int filemap_fdatawait(struct address_spa
  * In the case of swapcache, try_to_swap_out() has already locked the page, so
  * SetPageLocked() is ugly-but-OK there too.  The required page state has been
  * set up by swap_out_add_to_swap_cache().
+ *
+ * This function does not add the page to the LRU.  The caller must do that.
  */
 int add_to_page_cache(struct page *page,
-		struct address_space *mapping, unsigned long offset)
+		struct address_space *mapping, pgoff_t offset)
 {
 	int error;
 
+	page_cache_get(page);
 	write_lock(&mapping->page_lock);
 	error = radix_tree_insert(&mapping->page_tree, offset, page);
 	if (!error) {
 		SetPageLocked(page);
 		ClearPageDirty(page);
 		___add_to_page_cache(page, mapping, offset);
-		page_cache_get(page);
+	} else {
+		page_cache_release(page);
 	}
 	write_unlock(&mapping->page_lock);
-	/* Anon pages are already on the LRU */
-	if (!error && !PageSwapCache(page))
-		lru_cache_add(page);
 	return error;
 }
 
+int add_to_page_cache_lru(struct page *page,
+		struct address_space *mapping, pgoff_t offset)
+{
+	int ret = add_to_page_cache(page, mapping, offset);
+	if (ret == 0)
+		lru_cache_add(page);
+	return ret;
+}
+
 /*
  * This adds the requested page to the page cache if it isn't already there,
  * and schedules an I/O to read in its contents from disk.
@@ -566,7 +577,7 @@ static int page_cache_read(struct file *
 	if (!page)
 		return -ENOMEM;
 
-	error = add_to_page_cache(page, mapping, offset);
+	error = add_to_page_cache_lru(page, mapping, offset);
 	if (!error) {
 		error = mapping->a_ops->readpage(file, page);
 		page_cache_release(page);
@@ -797,7 +808,7 @@ repeat:
 			if (!cached_page)
 				return NULL;
 		}
-		err = add_to_page_cache(cached_page, mapping, index);
+		err = add_to_page_cache_lru(cached_page, mapping, index);
 		if (!err) {
 			page = cached_page;
 			cached_page = NULL;
@@ -830,7 +841,7 @@ grab_cache_page_nowait(struct address_sp
 		return NULL;
 	}
 	page = alloc_pages(mapping->gfp_mask & ~__GFP_FS, 0);
-	if (page && add_to_page_cache(page, mapping, index)) {
+	if (page && add_to_page_cache_lru(page, mapping, index)) {
 		page_cache_release(page);
 		page = NULL;
 	}
@@ -994,7 +1005,7 @@ no_cached_page:
 				break;
 			}
 		}
-		error = add_to_page_cache(cached_page, mapping, index);
+		error = add_to_page_cache_lru(cached_page, mapping, index);
 		if (error) {
 			if (error == -EEXIST)
 				goto find_page;
@@ -1704,7 +1715,7 @@ repeat:
 			if (!cached_page)
 				return ERR_PTR(-ENOMEM);
 		}
-		err = add_to_page_cache(cached_page, mapping, index);
+		err = add_to_page_cache_lru(cached_page, mapping, index);
 		if (err == -EEXIST)
 			goto repeat;
 		if (err < 0) {
@@ -1764,8 +1775,14 @@ retry:
 	return page;
 }
 
-static inline struct page * __grab_cache_page(struct address_space *mapping,
-				unsigned long index, struct page **cached_page)
+/*
+ * If the page was newly created, increment its refcount and add it to the
+ * caller's lru-buffering pagevec.  This function is specifically for
+ * generic_file_write().
+ */
+static inline struct page *
+__grab_cache_page(struct address_space *mapping, unsigned long index,
+			struct page **cached_page, struct pagevec *lru_pvec)
 {
 	int err;
 	struct page *page;
@@ -1782,6 +1799,9 @@ repeat:
 			goto repeat;
 		if (err == 0) {
 			page = *cached_page;
+			page_cache_get(page);
+			if (!pagevec_add(lru_pvec, page))
+				__pagevec_lru_add(lru_pvec);
 			*cached_page = NULL;
 		}
 	}
@@ -1829,6 +1849,7 @@ generic_file_write(struct file *file, co
 	int		err;
 	unsigned	bytes;
 	time_t		time_now;
+	struct pagevec	lru_pvec;
 
 	if (unlikely((ssize_t) count < 0))
 		return -EINVAL;
@@ -1836,6 +1857,8 @@ generic_file_write(struct file *file, co
 	if (unlikely(!access_ok(VERIFY_READ, buf, count)))
 		return -EFAULT;
 
+	pagevec_init(&lru_pvec);
+
 	down(&inode->i_sem);
 	pos = *ppos;
 	if (unlikely(pos < 0)) {
@@ -1976,7 +1999,7 @@ generic_file_write(struct file *file, co
 			__get_user(dummy, buf+bytes-1);
 		}
 
-		page = __grab_cache_page(mapping, index, &cached_page);
+		page = __grab_cache_page(mapping, index, &cached_page, &lru_pvec);
 		if (!page) {
 			status = -ENOMEM;
 			break;
@@ -2038,6 +2061,7 @@ generic_file_write(struct file *file, co
 out_status:	
 	err = written ? written : status;
 out:
+	pagevec_lru_add(&lru_pvec);
 	up(&inode->i_sem);
 	return err;
 }
--- 2.5.31/mm/readahead.c~batched-lru-add	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/mm/readahead.c	Sun Aug 11 00:20:33 2002
@@ -12,6 +12,7 @@
 #include <linux/mm.h>
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
+#include <linux/pagevec.h>
 
 struct backing_dev_info default_backing_dev_info = {
 	.ra_pages	= (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE,
@@ -36,6 +37,9 @@ read_pages(struct file *file, struct add
 		struct list_head *pages, unsigned nr_pages)
 {
 	unsigned page_idx;
+	struct pagevec lru_pvec;
+
+	pagevec_init(&lru_pvec);
 
 	if (mapping->a_ops->readpages)
 		return mapping->a_ops->readpages(mapping, pages, nr_pages);
@@ -43,10 +47,15 @@ read_pages(struct file *file, struct add
 	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
 		struct page *page = list_entry(pages->prev, struct page, list);
 		list_del(&page->list);
-		if (!add_to_page_cache(page, mapping, page->index))
+		if (!add_to_page_cache(page, mapping, page->index)) {
+			if (!pagevec_add(&lru_pvec, page))
+				__pagevec_lru_add(&lru_pvec);
 			mapping->a_ops->readpage(file, page);
-		page_cache_release(page);
+		} else {
+			page_cache_release(page);
+		}
 	}
+	pagevec_lru_add(&lru_pvec);
 	return 0;
 }
 
--- 2.5.31/mm/swap_state.c~batched-lru-add	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/mm/swap_state.c	Sun Aug 11 00:21:01 2002
@@ -72,6 +72,9 @@ int add_to_swap_cache(struct page *page,
 		return -ENOENT;
 	}
 	error = add_to_page_cache(page, &swapper_space, entry.val);
+	/*
+	 * Anon pages are already on the LRU, we don't run lru_cache_add here.
+	 */
 	if (error != 0) {
 		swap_free(entry);
 		if (error == -EEXIST)
@@ -276,8 +279,7 @@ int move_from_swap_cache(struct page *pa
 		SetPageDirty(page);
 		___add_to_page_cache(page, mapping, index);
 		/* fix that up */
-		list_del(&page->list);
-		list_add(&page->list, &mapping->dirty_pages);
+		list_move(&page->list, &mapping->dirty_pages);
 		write_unlock(&mapping->page_lock);
 		write_unlock(&swapper_space.page_lock);
 
--- 2.5.31/mm/shmem.c~batched-lru-add	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/mm/shmem.c	Sun Aug 11 00:20:33 2002
@@ -668,7 +668,7 @@ repeat:
 		page = page_cache_alloc(mapping);
 		if (!page)
 			goto no_mem;
-		error = add_to_page_cache(page, mapping, idx);
+		error = add_to_page_cache_lru(page, mapping, idx);
 		if (error < 0) {
 			page_cache_release(page);
 			goto no_mem;
--- 2.5.31/include/linux/pagemap.h~batched-lru-add	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/include/linux/pagemap.h	Sun Aug 11 00:21:02 2002
@@ -58,6 +58,8 @@ extern struct page * read_cache_page(str
 
 extern int add_to_page_cache(struct page *page,
 		struct address_space *mapping, unsigned long index);
+extern int add_to_page_cache_lru(struct page *page,
+		struct address_space *mapping, unsigned long index);
 extern void remove_from_page_cache(struct page *page);
 extern void __remove_from_page_cache(struct page *page);
 

.
