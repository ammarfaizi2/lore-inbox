Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315167AbSGDXu2>; Thu, 4 Jul 2002 19:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315207AbSGDXsa>; Thu, 4 Jul 2002 19:48:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45069 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315210AbSGDXqk>;
	Thu, 4 Jul 2002 19:46:40 -0400
Message-ID: <3D24E055.EFC9BFB1@zip.com.au>
Date: Thu, 04 Jul 2002 16:55:01 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 21/27] combine generic_writepages() and mpage_writepages()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



generic_writepages and mpage_writepages are basically identical,
except one calls ->writepage() and the other calls mpage_writepage(). 
This duplication is irritating.

The patch folds generic_writepage() into mpage_writepages().  It does
this rather kludgily: if the get_block argument to mpage_writepages()
is NULL then use ->writepage().

Can't think of a better way, really - we could go for a fully-blown
write_actor_t thing, but that would be overly elaborate and would not
allow mpage_writepage() to be inlined inside mpage_writepages(), which
is rather desirable.




 fs/mpage.c          |   55 +++++++++++++++++++++++++--
 mm/page-writeback.c |  104 +---------------------------------------------------
 2 files changed, 53 insertions(+), 106 deletions(-)

--- 2.5.24/mm/page-writeback.c~consolidate-writepages	Thu Jul  4 16:17:30 2002
+++ 2.5.24-akpm/mm/page-writeback.c	Thu Jul  4 16:17:30 2002
@@ -19,8 +19,9 @@
 #include <linux/pagemap.h>
 #include <linux/writeback.h>
 #include <linux/init.h>
-#include <linux/sysrq.h>
+//#include <linux/sysrq.h>
 #include <linux/backing-dev.h>
+#include <linux/mpage.h>
 
 /*
  * The maximum number of pages to writeout in a single bdflush/kupdate
@@ -313,108 +314,9 @@ int generic_vm_writeback(struct page *pa
 }
 EXPORT_SYMBOL(generic_vm_writeback);
 
-/**
- * generic_writepages - walk the list of dirty pages of the given
- * address space and writepage() all of them.
- * 
- * @mapping: address space structure to write
- * @nr_to_write: subtract the number of written pages from *@nr_to_write
- *
- * This is a library function, which implements the writepages()
- * address_space_operation.
- *
- * (The next two paragraphs refer to code which isn't here yet, but they
- *  explain the presence of address_space.io_pages)
- *
- * Pages can be moved from clean_pages or locked_pages onto dirty_pages
- * at any time - it's not possible to lock against that.  So pages which
- * have already been added to a BIO may magically reappear on the dirty_pages
- * list.  And generic_writepages() will again try to lock those pages.
- * But I/O has not yet been started against the page.  Thus deadlock.
- *
- * To avoid this, the entire contents of the dirty_pages list are moved
- * onto io_pages up-front.  We then walk io_pages, locking the
- * pages and submitting them for I/O, moving them to locked_pages.
- *
- * This has the added benefit of preventing a livelock which would otherwise
- * occur if pages are being dirtied faster than we can write them out.
- *
- * If a page is already under I/O, generic_writepages() skips it, even
- * if it's dirty.  This is desirable behaviour for memory-cleaning writeback,
- * but it is INCORRECT for data-integrity system calls such as fsync().  fsync()
- * and msync() need to guarentee that all the data which was dirty at the time
- * the call was made get new I/O started against them.  The way to do this is
- * to run filemap_fdatawait() before calling filemap_fdatawrite().
- *
- * It's fairly rare for PageWriteback pages to be on ->dirty_pages.  It
- * means that someone redirtied the page while it was under I/O.
- */
 int generic_writepages(struct address_space *mapping, int *nr_to_write)
 {
-	int (*writepage)(struct page *) = mapping->a_ops->writepage;
-	int ret = 0;
-	int done = 0;
-	int err;
-
-	write_lock(&mapping->page_lock);
-
-	list_splice(&mapping->dirty_pages, &mapping->io_pages);
-	INIT_LIST_HEAD(&mapping->dirty_pages);
-
-        while (!list_empty(&mapping->io_pages) && !done) {
-		struct page *page = list_entry(mapping->io_pages.prev,
-					struct page, list);
-		list_del(&page->list);
-		if (PageWriteback(page)) {
-			if (PageDirty(page)) {
-				list_add(&page->list, &mapping->dirty_pages);
-				continue;
-			}
-			list_add(&page->list, &mapping->locked_pages);
-			continue;
-		}
-		if (!PageDirty(page)) {
-			list_add(&page->list, &mapping->clean_pages);
-			continue;
-		}
-		list_add(&page->list, &mapping->locked_pages);
-		page_cache_get(page);
-		write_unlock(&mapping->page_lock);
-		lock_page(page);
-
-		/* It may have been removed from swapcache: check ->mapping */
-		if (page->mapping && !PageWriteback(page) &&
-					TestClearPageDirty(page)) {
-			/* FIXME: batch this up */
-			if (!PageActive(page) && PageLRU(page)) {
-				spin_lock(&pagemap_lru_lock);
-				if (!PageActive(page) && PageLRU(page)) {
-					list_del(&page->lru);
-					list_add(&page->lru, &inactive_list);
-				}
-				spin_unlock(&pagemap_lru_lock);
-			}
-			err = writepage(page);
-			if (!ret)
-				ret = err;
-			if (nr_to_write && --(*nr_to_write) <= 0)
-				done = 1;
-		} else {
-			unlock_page(page);
-		}
-
-		page_cache_release(page);
-		write_lock(&mapping->page_lock);
-	}
-	if (!list_empty(&mapping->io_pages)) {
-		/*
-		 * Put the rest back, in the correct order.
-		 */
-		list_splice(&mapping->io_pages, mapping->dirty_pages.prev);
-		INIT_LIST_HEAD(&mapping->io_pages);
-	}
-	write_unlock(&mapping->page_lock);
-	return ret;
+	return mpage_writepages(mapping, nr_to_write, NULL);
 }
 EXPORT_SYMBOL(generic_writepages);
 
--- 2.5.24/fs/mpage.c~consolidate-writepages	Thu Jul  4 16:17:30 2002
+++ 2.5.24-akpm/fs/mpage.c	Thu Jul  4 16:17:30 2002
@@ -475,9 +475,44 @@ out:
 	return bio;
 }
 
-/*
- * This is a cut-n-paste of generic_writepages().  We _could_
- * generalise that function.  It'd get a bit messy.  We'll see.
+/**
+ * mpage_writepages - walk the list of dirty pages of the given
+ * address space and writepage() all of them.
+ * 
+ * @mapping: address space structure to write
+ * @nr_to_write: subtract the number of written pages from *@nr_to_write
+ * @get_block: the filesystem's block mapper function.
+ *             If this is NULL then use a_ops->writepage.  Otherwise, go
+ *             direct-to-BIO.
+ *
+ * This is a library function, which implements the writepages()
+ * address_space_operation.
+ *
+ * (The next two paragraphs refer to code which isn't here yet, but they
+ *  explain the presence of address_space.io_pages)
+ *
+ * Pages can be moved from clean_pages or locked_pages onto dirty_pages
+ * at any time - it's not possible to lock against that.  So pages which
+ * have already been added to a BIO may magically reappear on the dirty_pages
+ * list.  And generic_writepages() will again try to lock those pages.
+ * But I/O has not yet been started against the page.  Thus deadlock.
+ *
+ * To avoid this, the entire contents of the dirty_pages list are moved
+ * onto io_pages up-front.  We then walk io_pages, locking the
+ * pages and submitting them for I/O, moving them to locked_pages.
+ *
+ * This has the added benefit of preventing a livelock which would otherwise
+ * occur if pages are being dirtied faster than we can write them out.
+ *
+ * If a page is already under I/O, generic_writepages() skips it, even
+ * if it's dirty.  This is desirable behaviour for memory-cleaning writeback,
+ * but it is INCORRECT for data-integrity system calls such as fsync().  fsync()
+ * and msync() need to guarentee that all the data which was dirty at the time
+ * the call was made get new I/O started against them.  The way to do this is
+ * to run filemap_fdatawait() before calling filemap_fdatawrite().
+ *
+ * It's fairly rare for PageWriteback pages to be on ->dirty_pages.  It
+ * means that someone redirtied the page while it was under I/O.
  */
 int
 mpage_writepages(struct address_space *mapping,
@@ -487,6 +522,11 @@ mpage_writepages(struct address_space *m
 	sector_t last_block_in_bio = 0;
 	int ret = 0;
 	int done = 0;
+	int (*writepage)(struct page *);
+
+	writepage = NULL;
+	if (get_block == NULL)
+		writepage = mapping->a_ops->writepage;
 
 	write_lock(&mapping->page_lock);
 
@@ -526,8 +566,13 @@ mpage_writepages(struct address_space *m
 				}
 				spin_unlock(&pagemap_lru_lock);
 			}
-			bio = mpage_writepage(bio, page, get_block,
-					&last_block_in_bio, &ret);
+
+			if (writepage) {
+				ret = (*writepage)(page);
+			} else {
+				bio = mpage_writepage(bio, page, get_block,
+						&last_block_in_bio, &ret);
+			}
 			if (ret || (nr_to_write && --(*nr_to_write) <= 0))
 				done = 1;
 		} else {

-
