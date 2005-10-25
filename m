Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbVJYAEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbVJYAEe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 20:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbVJYAEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 20:04:34 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:55727 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751396AbVJYAEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 20:04:33 -0400
Message-ID: <435D763F.1070901@oracle.com>
Date: Mon, 24 Oct 2005 17:03:11 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [RFC] page lock ordering and OCFS2
References: <20051017222051.GA26414@tetsuo.zabbo.net> <20051017161744.7df90a67.akpm@osdl.org> <43544499.5010601@oracle.com> <435928BC.5000509@oracle.com> <20051021175730.GD22372@infradead.org>
In-Reply-To: <20051021175730.GD22372@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
>
> The way you do it looks nice, but the exports aren't a big no-way.  That
> stuff is far too internal to be exported.

Yeah, understood.

So here's an entirely different approach.  We add a return value to readpage,
prepare_write, and commit_write in the style of WRITEPAGE_ACTIVATE.  It tells
the callers that the locked page they handed to the op has been unlocked and
that they should back off and try again.  This lets the ocfs2 methods notice
when they're going to sleep on the DLM and can unlock the page before sleeping.

This compiles but hasn't been tested.

Index: 2.6.14-rc5-mm1-aop-truncated-page/include/linux/fs.h
===================================================================
--- 2.6.14-rc5-mm1-aop-truncated-page.orig/include/linux/fs.h
+++ 2.6.14-rc5-mm1-aop-truncated-page/include/linux/fs.h
@@ -292,6 +292,30 @@ struct iattr {
  */
 #include <linux/quota.h>

+/**
+ * enum positive_aop_returns - aop return codes with specific semantics
+ *
+ * @WRITEPAGE_ACTIVATE: IO was not started: activate page.  Returned by
+ * 			writepage();
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
+enum positive_aop_returns {
+	WRITEPAGE_ACTIVATE	= 0x80000,
+	AOP_TRUNCATED_PAGE	= 0x80001,
+};
+
 /*
  * oh the beauties of C type declarations.
  */
Index: 2.6.14-rc5-mm1-aop-truncated-page/include/linux/writeback.h
===================================================================
--- 2.6.14-rc5-mm1-aop-truncated-page.orig/include/linux/writeback.h
+++ 2.6.14-rc5-mm1-aop-truncated-page/include/linux/writeback.h
@@ -60,12 +60,6 @@ struct writeback_control {
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
Index: 2.6.14-rc5-mm1-aop-truncated-page/drivers/block/loop.c
===================================================================
--- 2.6.14-rc5-mm1-aop-truncated-page.orig/drivers/block/loop.c
+++ 2.6.14-rc5-mm1-aop-truncated-page/drivers/block/loop.c
@@ -213,7 +213,7 @@ static int do_lo_send_aops(struct loop_d
 	struct address_space_operations *aops = mapping->a_ops;
 	pgoff_t index;
 	unsigned offset, bv_offs;
-	int len, ret = 0;
+	int len, ret;

 	down(&mapping->host->i_sem);
 	index = pos >> PAGE_CACHE_SHIFT;
@@ -232,9 +232,15 @@ static int do_lo_send_aops(struct loop_d
 		page = grab_cache_page(mapping, index);
 		if (unlikely(!page))
 			goto fail;
-		if (unlikely(aops->prepare_write(file, page, offset,
-				offset + size)))
+		ret = aops->prepare_write(file, page, offset,
+					  offset + size);
+		if (unlikely(ret)) {
+			if (ret == AOP_TRUNCTED_PAGE) {
+				page_cache_release(page);
+				continue;
+			}
 			goto unlock;
+		}
 		transfer_result = lo_do_transfer(lo, WRITE, page, offset,
 				bvec->bv_page, bv_offs, size, IV);
 		if (unlikely(transfer_result)) {
@@ -251,9 +257,15 @@ static int do_lo_send_aops(struct loop_d
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
@@ -264,6 +276,7 @@ static int do_lo_send_aops(struct loop_d
 		unlock_page(page);
 		page_cache_release(page);
 	}
+	ret = 0;
 out:
 	up(&mapping->host->i_sem);
 	return ret;
Index: 2.6.14-rc5-mm1-aop-truncated-page/mm/filemap.c
===================================================================
--- 2.6.14-rc5-mm1-aop-truncated-page.orig/mm/filemap.c
+++ 2.6.14-rc5-mm1-aop-truncated-page/mm/filemap.c
@@ -853,8 +853,13 @@ readpage:
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
@@ -1174,26 +1179,24 @@ static int fastcall page_cache_read(stru
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
@@ -1353,10 +1356,14 @@ page_not_uptodate:
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
@@ -1380,10 +1387,14 @@ page_not_uptodate:
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
@@ -1466,10 +1477,14 @@ page_not_uptodate:
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
@@ -1492,10 +1507,14 @@ page_not_uptodate:
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
@@ -1956,12 +1975,16 @@ generic_file_buffered_write(struct kiocb
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
@@ -1975,6 +1998,10 @@ generic_file_buffered_write(struct kiocb
 		flush_dcache_page(page);
 		status = a_ops->commit_write(file, page, offset, offset+bytes);
 		if (likely(copied > 0)) {
+			if (status == AOP_TRUNCATED_PAGE) {
+				page_cache_release(page);
+				continue;
+			}
 			if (!status)
 				status = copied;

Index: 2.6.14-rc5-mm1-aop-truncated-page/mm/readahead.c
===================================================================
--- 2.6.14-rc5-mm1-aop-truncated-page.orig/mm/readahead.c
+++ 2.6.14-rc5-mm1-aop-truncated-page/mm/readahead.c
@@ -159,7 +159,7 @@ static int read_pages(struct address_spa
 {
 	unsigned page_idx;
 	struct pagevec lru_pvec;
-	int ret = 0;
+	int ret;

 	if (mapping->a_ops->readpages) {
 		ret = mapping->a_ops->readpages(filp, mapping, pages, nr_pages);
@@ -172,14 +172,17 @@ static int read_pages(struct address_spa
 		list_del(&page->lru);
 		if (!add_to_page_cache(page, mapping,
 					page->index, GFP_KERNEL)) {
-			mapping->a_ops->readpage(filp, page);
-			if (!pagevec_add(&lru_pvec, page))
+			ret = mapping->a_ops->readpage(filp, page);
+			if (ret != AOP_TRUNCATED_PAGE &&
+			    !pagevec_add(&lru_pvec, page)) {
 				__pagevec_lru_add(&lru_pvec);
-		} else {
-			page_cache_release(page);
+				continue;
+			}
 		}
+		page_cache_release(page);
 	}
 	pagevec_lru_add(&lru_pvec);
+	ret = 0;
 out:
 	return ret;
 }
