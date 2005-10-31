Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbVJaUGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbVJaUGI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 15:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbVJaUGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 15:06:08 -0500
Received: from rgminet02.oracle.com ([148.87.122.31]:18167 "EHLO
	rgminet02.oracle.com") by vger.kernel.org with ESMTP
	id S964810AbVJaUGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 15:06:05 -0500
Message-ID: <43667913.4030401@oracle.com>
Date: Mon, 31 Oct 2005 12:05:39 -0800
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>
CC: Mark Fasheh <mark.fasheh@oracle.com>
Subject: [Patch] add AOP_TRUNCATED_PAGE, prepend AOP_ to WRITEPAGE_ACTIVATE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


readpage(), prepare_write(), and commit_write() callers are updated to
understand the special return code AOP_TRUNCATED_PAGE in the style of
writepage() and WRITEPAGE_ACTIVATE.  AOP_TRUNCATED_PAGE tells the caller that
the callee has unlocked the page and that the operation should be tried again
with a new page.  OCFS2 uses this to detect and work around a lock inversion in
its aop methods.  There should be no change in behaviour for methods that don't
return AOP_TRUNCATED_PAGE.

WRITEPAGE_ACTIVATE is also prepended with AOP_ for consistency and they are
made enums so that kerneldoc can be used to document their semantics.

Signed-off-by: Zach Brown <zach.brown@oracle.com>

---

Andrew, this is against -mm instead of mainline so that it catches the reiser4
use of WRITEPAGE_ACTIVATE.  Also, right now the OCFS2 git repository doesn't
have the code that uses this, but it will once this is in -mm.

 drivers/block/loop.c      |   23 +++++++++++---
 drivers/block/rd.c        |    4 +-
 fs/mpage.c                |    2 -
 fs/reiser4/entd.c         |    2 -
 include/linux/fs.h        |   31 +++++++++++++++++++
 include/linux/writeback.h |    6 ---
 mm/filemap.c              |   73 +++++++++++++++++++++++++++++++---------------
 mm/readahead.c            |   15 +++++----
 mm/shmem.c                |    2 -
 mm/vmscan.c               |    2 -
 10 files changed, 114 insertions(+), 46 deletions(-)

Index: 2.6.14-rc5-mm1-aop-truncated-page/drivers/block/loop.c
===================================================================
--- 2.6.14-rc5-mm1-aop-truncated-page.orig/drivers/block/loop.c	2005-10-27 11:09:50.000000000 -0700
+++ 2.6.14-rc5-mm1-aop-truncated-page/drivers/block/loop.c	2005-10-27 11:14:56.000000000 -0700
@@ -213,7 +213,7 @@
 	struct address_space_operations *aops = mapping->a_ops;
 	pgoff_t index;
 	unsigned offset, bv_offs;
-	int len, ret = 0;
+	int len, ret;

 	down(&mapping->host->i_sem);
 	index = pos >> PAGE_CACHE_SHIFT;
@@ -232,9 +232,15 @@
 		page = grab_cache_page(mapping, index);
 		if (unlikely(!page))
 			goto fail;
-		if (unlikely(aops->prepare_write(file, page, offset,
-				offset + size)))
+		ret = aops->prepare_write(file, page, offset,
+					  offset + size);
+		if (unlikely(ret)) {
+			if (ret == AOP_TRUNCATED_PAGE) {
+				page_cache_release(page);
+				continue;
+			}
 			goto unlock;
+		}
 		transfer_result = lo_do_transfer(lo, WRITE, page, offset,
 				bvec->bv_page, bv_offs, size, IV);
 		if (unlikely(transfer_result)) {
@@ -251,9 +257,15 @@
 			kunmap_atomic(kaddr, KM_USER0);
 		}
 		flush_dcache_page(page);
-		if (unlikely(aops->commit_write(file, page, offset,
-				offset + size)))
+		ret = aops->commit_write(file, page, offset,
+					 offset + size);
+		if (unlikely(ret)) {
+			if (ret == AOP_TRUNCATED_PAGE) {
+				page_cache_release(page);
+				continue;
+			}
 			goto unlock;
+		}
 		if (unlikely(transfer_result))
 			goto unlock;
 		bv_offs += size;
@@ -264,6 +276,7 @@
 		unlock_page(page);
 		page_cache_release(page);
 	}
+	ret = 0;
 out:
 	up(&mapping->host->i_sem);
 	return ret;
Index: 2.6.14-rc5-mm1-aop-truncated-page/drivers/block/rd.c
===================================================================
--- 2.6.14-rc5-mm1-aop-truncated-page.orig/drivers/block/rd.c	2005-10-27 11:09:21.000000000 -0700
+++ 2.6.14-rc5-mm1-aop-truncated-page/drivers/block/rd.c	2005-10-27 12:01:40.000000000 -0700
@@ -154,7 +154,7 @@

 /*
  * ->writepage to the the blockdev's mapping has to redirty the page so that the
- * VM doesn't go and steal it.  We return WRITEPAGE_ACTIVATE so that the VM
+ * VM doesn't go and steal it.  We return AOP_WRITEPAGE_ACTIVATE so that the VM
  * won't try to (pointlessly) write the page again for a while.
  *
  * Really, these pages should not be on the LRU at all.
@@ -165,7 +165,7 @@
 		make_page_uptodate(page);
 	SetPageDirty(page);
 	if (wbc->for_reclaim)
-		return WRITEPAGE_ACTIVATE;
+		return AOP_WRITEPAGE_ACTIVATE;
 	unlock_page(page);
 	return 0;
 }
Index: 2.6.14-rc5-mm1-aop-truncated-page/fs/mpage.c
===================================================================
--- 2.6.14-rc5-mm1-aop-truncated-page.orig/fs/mpage.c	2005-10-27 11:10:45.000000000 -0700
+++ 2.6.14-rc5-mm1-aop-truncated-page/fs/mpage.c	2005-10-27 12:02:32.000000000 -0700
@@ -721,7 +721,7 @@
 						&last_block_in_bio, &ret, wbc,
 						page->mapping->a_ops->writepage);
 			}
-			if (unlikely(ret == WRITEPAGE_ACTIVATE))
+			if (unlikely(ret == AOP_WRITEPAGE_ACTIVATE))
 				unlock_page(page);
 			if (ret || (--(wbc->nr_to_write) <= 0))
 				done = 1;
Index: 2.6.14-rc5-mm1-aop-truncated-page/fs/reiser4/entd.c
===================================================================
--- 2.6.14-rc5-mm1-aop-truncated-page.orig/fs/reiser4/entd.c	2005-10-27 11:11:26.000000000 -0700
+++ 2.6.14-rc5-mm1-aop-truncated-page/fs/reiser4/entd.c	2005-10-27 12:03:40.000000000 -0700
@@ -390,7 +390,7 @@
 		return 1;
 	}
 	lock_page(page);
-	return WRITEPAGE_ACTIVATE;
+	return AOP_WRITEPAGE_ACTIVATE;
 }

 void ent_writes_page(struct super_block *sb, struct page *page)
Index: 2.6.14-rc5-mm1-aop-truncated-page/include/linux/fs.h
===================================================================
--- 2.6.14-rc5-mm1-aop-truncated-page.orig/include/linux/fs.h	2005-10-27 11:11:26.000000000 -0700
+++ 2.6.14-rc5-mm1-aop-truncated-page/include/linux/fs.h	2005-10-27 12:12:39.078455633 -0700
@@ -292,6 +292,37 @@
  */
 #include <linux/quota.h>

+/**
+ * enum positive_aop_returns - aop return codes with specific semantics
+ *
+ * @AOP_WRITEPAGE_ACTIVATE: Informs the caller that page writeback has
+ * 			    completed, that the page is still locked, and
+ * 			    should be considered active.  The VM uses this hint
+ * 			    to return the page to the active list -- it won't
+ * 			    be a candidate for writeback again in the near
+ * 			    future.  Other callers must be careful to unlock
+ * 			    the page if they get this return.  Returned by
+ * 			    writepage();
+ *
+ * @AOP_TRUNCATED_PAGE: The AOP method that was handed a locked page has
+ *  			unlocked it and the page might have been truncated.
+ *  			The caller should back up to acquiring a new page and
+ *  			trying again.  The aop will be taking reasonable
+ *  			precautions not to livelock.  If the caller held a page
+ *  			reference, it should drop it before retrying.  Returned
+ *  			by readpage(), prepare_write(), and commit_write().
+ *
+ * address_space_operation functions return these large constants to indicate
+ * special semantics to the caller.  These are much larger than the bytes in a
+ * page to allow for functions that return the number of bytes operated on in a
+ * given page.
+ */
+
+enum positive_aop_returns {
+	AOP_WRITEPAGE_ACTIVATE	= 0x80000,
+	AOP_TRUNCATED_PAGE	= 0x80001,
+};
+
 /*
  * oh the beauties of C type declarations.
  */
Index: 2.6.14-rc5-mm1-aop-truncated-page/include/linux/writeback.h
===================================================================
--- 2.6.14-rc5-mm1-aop-truncated-page.orig/include/linux/writeback.h	2005-10-27 11:10:45.000000000 -0700
+++ 2.6.14-rc5-mm1-aop-truncated-page/include/linux/writeback.h	2005-10-27 11:14:42.879021785 -0700
@@ -60,12 +60,6 @@
 };

 /*
- * ->writepage() return values (make these much larger than a pagesize, in
- * case some fs is returning number-of-bytes-written from writepage)
- */
-#define WRITEPAGE_ACTIVATE	0x80000	/* IO was not started: activate page */
-
-/*
  * fs/fs-writeback.c
  */	
 void writeback_inodes(struct writeback_control *wbc);
Index: 2.6.14-rc5-mm1-aop-truncated-page/mm/filemap.c
===================================================================
--- 2.6.14-rc5-mm1-aop-truncated-page.orig/mm/filemap.c	2005-10-27 11:11:26.000000000 -0700
+++ 2.6.14-rc5-mm1-aop-truncated-page/mm/filemap.c	2005-10-27 11:56:32.000000000 -0700
@@ -853,8 +853,13 @@
 		/* Start the actual read. The read will unlock the page. */
 		error = mapping->a_ops->readpage(filp, page);

-		if (unlikely(error))
+		if (unlikely(error)) {
+			if (error == AOP_TRUNCATED_PAGE) {
+				page_cache_release(page);
+				goto find_page;
+			}
 			goto readpage_error;
+		}

 		if (!PageUptodate(page)) {
 			lock_page(page);
@@ -1174,26 +1179,24 @@
 {
 	struct address_space *mapping = file->f_mapping;
 	struct page *page;
-	int error;
+	int ret;

-	page = page_cache_alloc_cold(mapping);
-	if (!page)
-		return -ENOMEM;
+	do {
+		page = page_cache_alloc_cold(mapping);
+		if (!page)
+			return -ENOMEM;
+
+		ret = add_to_page_cache_lru(page, mapping, offset, GFP_KERNEL);
+		if (ret == 0)
+			ret = mapping->a_ops->readpage(file, page);
+		else if (ret == -EEXIST)
+			ret = 0; /* losing race to add is OK */

-	error = add_to_page_cache_lru(page, mapping, offset, GFP_KERNEL);
-	if (!error) {
-		error = mapping->a_ops->readpage(file, page);
 		page_cache_release(page);
-		return error;
-	}

-	/*
-	 * We arrive here in the unlikely event that someone
-	 * raced with us and added our page to the cache first
-	 * or we are out of memory for radix-tree nodes.
-	 */
-	page_cache_release(page);
-	return error == -EEXIST ? 0 : error;
+	} while (ret == AOP_TRUNCATED_PAGE);
+		
+	return ret;
 }

 #define MMAP_LOTSAMISS  (100)
@@ -1353,10 +1356,14 @@
 		goto success;
 	}

-	if (!mapping->a_ops->readpage(file, page)) {
+	error = mapping->a_ops->readpage(file, page);
+	if (!error) {
 		wait_on_page_locked(page);
 		if (PageUptodate(page))
 			goto success;
+	} else if (error == AOP_TRUNCATED_PAGE) {
+		page_cache_release(page);
+		goto retry_find;
 	}

 	/*
@@ -1380,10 +1387,14 @@
 		goto success;
 	}
 	ClearPageError(page);
-	if (!mapping->a_ops->readpage(file, page)) {
+	error = mapping->a_ops->readpage(file, page);
+	if (!error) {
 		wait_on_page_locked(page);
 		if (PageUptodate(page))
 			goto success;
+	} else if (error == AOP_TRUNCATED_PAGE) {
+		page_cache_release(page);
+		goto retry_find;
 	}

 	/*
@@ -1466,10 +1477,14 @@
 		goto success;
 	}

-	if (!mapping->a_ops->readpage(file, page)) {
+	error = mapping->a_ops->readpage(file, page);
+	if (!error) {
 		wait_on_page_locked(page);
 		if (PageUptodate(page))
 			goto success;
+	} else if (error == AOP_TRUNCATED_PAGE) {
+		page_cache_release(page);
+		goto retry_find;
 	}

 	/*
@@ -1492,10 +1507,14 @@
 	}

 	ClearPageError(page);
-	if (!mapping->a_ops->readpage(file, page)) {
+	error = mapping->a_ops->readpage(file, page);
+	if (!error) {
 		wait_on_page_locked(page);
 		if (PageUptodate(page))
 			goto success;
+	} else if (error == AOP_TRUNCATED_PAGE) {
+		page_cache_release(page);
+		goto retry_find;
 	}

 	/*
@@ -1956,12 +1975,16 @@
 		status = a_ops->prepare_write(file, page, offset, offset+bytes);
 		if (unlikely(status)) {
 			loff_t isize = i_size_read(inode);
+
+			if (status != AOP_TRUNCATED_PAGE)
+				unlock_page(page);
+			page_cache_release(page);
+			if (status == AOP_TRUNCATED_PAGE)
+				continue;
 			/*
 			 * prepare_write() may have instantiated a few blocks
 			 * outside i_size.  Trim these off again.
 			 */
-			unlock_page(page);
-			page_cache_release(page);
 			if (pos + bytes > isize)
 				vmtruncate(inode, isize);
 			break;
@@ -1974,6 +1997,10 @@
 						cur_iov, iov_base, bytes);
 		flush_dcache_page(page);
 		status = a_ops->commit_write(file, page, offset, offset+bytes);
+		if (status == AOP_TRUNCATED_PAGE) {
+			page_cache_release(page);
+			continue;
+		}
 		if (likely(copied > 0)) {
 			if (!status)
 				status = copied;
Index: 2.6.14-rc5-mm1-aop-truncated-page/mm/readahead.c
===================================================================
--- 2.6.14-rc5-mm1-aop-truncated-page.orig/mm/readahead.c	2005-10-27 11:11:26.000000000 -0700
+++ 2.6.14-rc5-mm1-aop-truncated-page/mm/readahead.c	2005-10-27 11:58:59.000000000 -0700
@@ -159,7 +159,7 @@
 {
 	unsigned page_idx;
 	struct pagevec lru_pvec;
-	int ret = 0;
+	int ret;

 	if (mapping->a_ops->readpages) {
 		ret = mapping->a_ops->readpages(filp, mapping, pages, nr_pages);
@@ -172,14 +172,17 @@
 		list_del(&page->lru);
 		if (!add_to_page_cache(page, mapping,
 					page->index, GFP_KERNEL)) {
-			mapping->a_ops->readpage(filp, page);
-			if (!pagevec_add(&lru_pvec, page))
-				__pagevec_lru_add(&lru_pvec);
-		} else {
-			page_cache_release(page);
+			ret = mapping->a_ops->readpage(filp, page);
+			if (ret != AOP_TRUNCATED_PAGE) {
+				if (!pagevec_add(&lru_pvec, page))
+					__pagevec_lru_add(&lru_pvec);
+				continue;
+			} /* else fall through to release */
 		}
+		page_cache_release(page);
 	}
 	pagevec_lru_add(&lru_pvec);
+	ret = 0;
 out:
 	return ret;
 }
Index: 2.6.14-rc5-mm1-aop-truncated-page/mm/shmem.c
===================================================================
--- 2.6.14-rc5-mm1-aop-truncated-page.orig/mm/shmem.c	2005-10-27 11:11:26.000000000 -0700
+++ 2.6.14-rc5-mm1-aop-truncated-page/mm/shmem.c	2005-10-27 12:04:18.000000000 -0700
@@ -855,7 +855,7 @@
 	swap_free(swap);
 redirty:
 	set_page_dirty(page);
-	return WRITEPAGE_ACTIVATE;	/* Return with the page locked */
+	return AOP_WRITEPAGE_ACTIVATE;	/* Return with the page locked */
 }

 #ifdef CONFIG_NUMA
Index: 2.6.14-rc5-mm1-aop-truncated-page/mm/vmscan.c
===================================================================
--- 2.6.14-rc5-mm1-aop-truncated-page.orig/mm/vmscan.c	2005-10-27 11:11:26.000000000 -0700
+++ 2.6.14-rc5-mm1-aop-truncated-page/mm/vmscan.c	2005-10-27 12:12:45.000000000 -0700
@@ -355,7 +355,7 @@
 		res = mapping->a_ops->writepage(page, &wbc);
 		if (res < 0)
 			handle_write_error(mapping, page, res);
-		if (res == WRITEPAGE_ACTIVATE) {
+		if (res == AOP_WRITEPAGE_ACTIVATE) {
 			ClearPageReclaim(page);
 			return PAGE_ACTIVATE;
 		}


