Return-Path: <linux-kernel-owner+w=401wt.eu-S1161226AbXAMD00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161226AbXAMD00 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 22:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161225AbXAMD0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 22:26:24 -0500
Received: from mx1.suse.de ([195.135.220.2]:49637 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161238AbXAMDZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 22:25:55 -0500
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Filesystems <linux-fsdevel@vger.kernel.org>,
       Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>
Message-Id: <20070113011334.9449.61323.sendpatchset@linux.site>
In-Reply-To: <20070113011159.9449.4327.sendpatchset@linux.site>
References: <20070113011159.9449.4327.sendpatchset@linux.site>
Subject: [patch 10/10] mm: fix pagecache write deadlocks
Date: Sat, 13 Jan 2007 04:25:50 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the core write() code so that it won't take a pagefault while holding a
lock on the pagecache page. There are a number of different deadlocks possible
if we try to do such a thing:

1.  generic_buffered_write
2.   lock_page
3.    prepare_write
4.     unlock_page+vmtruncate
5.     copy_from_user
6.      mmap_sem(r)
7.       handle_mm_fault
8.        lock_page (filemap_nopage)
9.    commit_write
1.   unlock_page

b. sys_munmap / sys_mlock / others
c.  mmap_sem(w)
d.   make_pages_present
e.    get_user_pages
f.     handle_mm_fault
g.      lock_page (filemap_nopage)

2,8	- recursive deadlock if page is same
2,8;2,8	- ABBA deadlock is page is different
2,6;c,g	- ABBA deadlock if page is same

The solution is as follows:
1.  If we find the destination page is uptodate, continue as normal, but use
    atomic usercopies which do not take pagefaults and do not zero the uncopied
    tail of the destination. The destination is already uptodate, so we can
    commit_write the full length even if there was a partial copy: it does not
    matter that the tail was not modified, because if it is dirtied and written
    back to disk it will not cause any problems (uptodate *means* that the
    destination page is as new or newer than the copy on disk).

1a. The above requires that fault_in_pages_readable correctly returns access
    information, because atomic usercopies cannot distinguish between
    non-present pages in a readable mapping, from lack of a readable mapping.

2.  If we find the destination page is non uptodate, unlock it (this could be
    made slightly more optimal), then find and pin the source page with
    get_user_pages. Relock the destination page and continue with the copy.
    However, instead of a usercopy (which might take a fault), copy the data
    via the kernel address space.

(also, rename maxlen to seglen, because it was confusing)

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c
+++ linux-2.6/mm/filemap.c
@@ -1843,11 +1843,12 @@ generic_file_buffered_write(struct kiocb
 	filemap_set_next_iovec(&cur_iov, nr_segs, &iov_offset, written);
 
 	do {
+		struct page *src_page;
 		struct page *page;
 		pgoff_t index;		/* Pagecache index for current page */
 		unsigned long offset;	/* Offset into pagecache page */
-		unsigned long maxlen;	/* Bytes remaining in current iovec */
-		size_t bytes;		/* Bytes to write to page */
+		unsigned long seglen;	/* Bytes remaining in current iovec */
+		unsigned long bytes;	/* Bytes to write to page */
 		size_t copied;		/* Bytes copied from user */
 
 		buf = cur_iov->iov_base + iov_offset;
@@ -1857,20 +1858,30 @@ generic_file_buffered_write(struct kiocb
 		if (bytes > count)
 			bytes = count;
 
-		maxlen = cur_iov->iov_len - iov_offset;
-		if (maxlen > bytes)
-			maxlen = bytes;
+		/*
+		 * a non-NULL src_page indicates that we're doing the
+		 * copy via get_user_pages and kmap.
+		 */
+		src_page = NULL;
+
+		seglen = cur_iov->iov_len - iov_offset;
+		if (seglen > bytes)
+			seglen = bytes;
 
-#ifndef CONFIG_DEBUG_VM
 		/*
 		 * Bring in the user page that we will copy from _first_.
 		 * Otherwise there's a nasty deadlock on copying from the
 		 * same page as we're writing to, without it being marked
 		 * up-to-date.
+		 *
+		 * Not only is this an optimisation, but it is also required
+		 * to check that the address is actually valid, when atomic
+		 * usercopies are used, below.
 		 */
-		fault_in_pages_readable(buf, maxlen);
-#endif
-
+		if (unlikely(fault_in_pages_readable(buf, seglen))) {
+			status = -EFAULT;
+			break;
+		}
 
 		page = __grab_cache_page(mapping, index);
 		if (!page) {
@@ -1878,31 +1889,88 @@ generic_file_buffered_write(struct kiocb
 			break;
 		}
 
+		/*
+		 * non-uptodate pages cannot cope with short copies, and we
+		 * cannot take a pagefault with the destination page locked.
+		 * So pin the source page to copy it.
+		 */
+		if (!PageUptodate(page)) {
+			unlock_page(page);
+
+			bytes = min(bytes, PAGE_CACHE_SIZE -
+				     ((unsigned long)buf & ~PAGE_CACHE_MASK));
+
+			/*
+			 * Cannot get_user_pages with a page locked for the
+			 * same reason as we can't take a page fault with a
+			 * page locked (as explained below).
+			 */
+			status = get_user_pages(current, current->mm,
+					(unsigned long)buf & PAGE_CACHE_MASK, 1,
+					0, 0, &src_page, NULL);
+			if (status != 1) {
+				page_cache_release(page);
+				break;
+			}
+
+			lock_page(page);
+			if (!page->mapping) {
+				unlock_page(page);
+				page_cache_release(page);
+				page_cache_release(src_page);
+				continue;
+			}
+
+		}
+
 		status = a_ops->prepare_write(file, page, offset, offset+bytes);
 		if (unlikely(status))
 			goto fs_write_aop_error;
 
-		copied = filemap_copy_from_user(page, offset,
+		if (!src_page) {
+			/*
+			 * Must not enter the pagefault handler here, because
+			 * we hold the page lock, so we might recursively
+			 * deadlock on the same lock, or get an ABBA deadlock
+			 * against a different lock, or against the mmap_sem
+			 * (which nests outside the page lock).  So increment
+			 * preempt count, and use _atomic usercopies.
+			 *
+			 * The page is uptodate so we are OK to encounter a
+			 * short copy: if unmodified parts of the page are
+			 * marked dirty and written out to disk, it doesn't
+			 * really matter.
+			 */
+			copied = filemap_copy_from_user_atomic(page, offset,
 					cur_iov, nr_segs, iov_offset, bytes);
+		} else {
+			char *src, *dst;
+			src = kmap(src_page);
+			dst = kmap(page);
+			memcpy(dst + offset,
+				src + ((unsigned long)buf & ~PAGE_CACHE_MASK),
+				bytes);
+			kunmap(page);
+			kunmap(src_page);
+			copied = bytes;
+		}
 		flush_dcache_page(page);
 
 		status = a_ops->commit_write(file, page, offset, offset+bytes);
 		if (unlikely(status))
 			goto fs_write_aop_error;
 
+		unlock_page(page);
+		mark_page_accessed(page);
+		page_cache_release(page);
+		if (src_page)
+			page_cache_release(src_page);
+
 		written += copied;
 		count -= copied;
 		pos += copied;
-		filemap_set_next_iovec(&cur_iov, nr_segs,
-						&iov_offset, written);
-		if (unlikely(copied != bytes))
-			status = -EFAULT;
+		filemap_set_next_iovec(&cur_iov, nr_segs, &iov_offset, copied);
 
-		unlock_page(page);
-		mark_page_accessed(page);
-		page_cache_release(page);
-		if (status < 0)
-			break;
 		balance_dirty_pages_ratelimited(mapping);
 		cond_resched();
 		continue;
@@ -1911,6 +1979,8 @@ fs_write_aop_error:
 		if (status != AOP_TRUNCATED_PAGE)
 			unlock_page(page);
 		page_cache_release(page);
+		if (src_page)
+			page_cache_release(src_page);
 
 		/*
 		 * prepare_write() may have instantiated a few blocks
@@ -1923,7 +1993,6 @@ fs_write_aop_error:
 			continue;
 		else
 			break;
-
 	} while (count);
 	*ppos = pos;
 
Index: linux-2.6/include/linux/pagemap.h
===================================================================
--- linux-2.6.orig/include/linux/pagemap.h
+++ linux-2.6/include/linux/pagemap.h
@@ -198,6 +198,9 @@ static inline int fault_in_pages_writeab
 {
 	int ret;
 
+	if (unlikely(size == 0))
+		return 0;
+
 	/*
 	 * Writing zeroes into userspace here is OK, because we know that if
 	 * the zero gets there, we'll be overwriting it.
@@ -217,19 +220,23 @@ static inline int fault_in_pages_writeab
 	return ret;
 }
 
-static inline void fault_in_pages_readable(const char __user *uaddr, int size)
+static inline int fault_in_pages_readable(const char __user *uaddr, int size)
 {
 	volatile char c;
 	int ret;
 
+	if (unlikely(size == 0))
+		return 0;
+
 	ret = __get_user(c, uaddr);
 	if (ret == 0) {
 		const char __user *end = uaddr + size - 1;
 
 		if (((unsigned long)uaddr & PAGE_MASK) !=
 				((unsigned long)end & PAGE_MASK))
-		 	__get_user(c, end);
+		 	ret = __get_user(c, end);
 	}
+	return ret;
 }
 
 #endif /* _LINUX_PAGEMAP_H */
