Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWJMQpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWJMQpk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 12:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWJMQpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 12:45:08 -0400
Received: from ns1.suse.de ([195.135.220.2]:11994 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751380AbWJMQo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 12:44:59 -0400
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>
Cc: Neil Brown <neilb@suse.de>, Andrew Morton <akpm@osdl.org>,
       Anton Altaparmakov <aia21@cam.ac.uk>,
       Chris Mason <chris.mason@oracle.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <npiggin@suse.de>
Message-Id: <20061013143616.15438.77140.sendpatchset@linux.site>
In-Reply-To: <20061013143516.15438.8802.sendpatchset@linux.site>
References: <20061013143516.15438.8802.sendpatchset@linux.site>
Subject: [patch 6/6] mm: fix pagecache write deadlocks
Date: Fri, 13 Oct 2006 18:44:52 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org> and Nick Piggin <npiggin@suse.de>

The idea is to modify the core write() code so that it won't take a pagefault
while holding a lock on the pagecache page. There are a number of different
deadlocks possible if we try to do such a thing:

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
2,8;2,7	- ABBA deadlock is page is different
2,6;c,g	- ABBA deadlock if page is same

- Instead of copy_from_user(), use inc_preempt_count() and
  copy_from_user_inatomic().

- If the copy_from_user_inatomic() hits a pagefault, it'll return a short
  copy.

  - if the page was not uptodate, we cannot commit the write, because the
    uncopied bit could have uninitialised data. Commit zero length copy,
    which should do the right thing (ie. not set the page uptodate).

  - if the page was uptodate, commit the copied portion so we make some
    progress.
    
  - unlock_page()

  - go back and try to fault the page in again, redo the lock_page,
    prepare_write, copy_from_user_inatomic(), etc.

- Now we have a non uptodate page, and we keep faulting on a 2nd or later
  iovec, this gives a deadlock, because fault_in_pages readable only faults
  in the first iovec. To fix this situation, if we fault on a !uptodate page,
  make the next iteration only attempt to copy a single iovec.

- This also showed up a number of buggy prepare_write / commit_write
  implementations that were setting the page uptodate in the prepare_write
  side: bad! this allows uninitialised data to be read. Fix these.

(also, rename maxlen to seglen, because it was confusing)

Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c
+++ linux-2.6/mm/filemap.c
@@ -1881,7 +1881,7 @@ generic_file_buffered_write(struct kiocb
 	do {
 		pgoff_t index;		/* Pagecache index for current page */
 		unsigned long offset;	/* Offset into pagecache page */
-		unsigned long maxlen;	/* Bytes remaining in current iovec */
+		unsigned long seglen;	/* Bytes remaining in current iovec */
 		size_t bytes;		/* Bytes to write to page */
 		size_t copied;		/* Bytes copied from user */
 
@@ -1891,18 +1891,16 @@ generic_file_buffered_write(struct kiocb
 		if (bytes > count)
 			bytes = count;
 
-		maxlen = cur_iov->iov_len - iov_offset;
-		if (maxlen > bytes)
-			maxlen = bytes;
+		seglen = min(cur_iov->iov_len - iov_offset, bytes);
 
+retry_noprogress:
 #ifndef CONFIG_DEBUG_VM
 		/*
-		 * Bring in the user page that we will copy from _first_.
-		 * Otherwise there's a nasty deadlock on copying from the
-		 * same page as we're writing to, without it being marked
-		 * up-to-date.
+		 * Bring in the user page that we will copy from _first_, this
+		 * minimises the chance we have to break into the slowpath
+		 * below.
 		 */
-		fault_in_pages_readable(buf, maxlen);
+		fault_in_pages_readable(buf, seglen);
 #endif
 
 		page = __grab_cache_page(mapping,index,&cached_page,&lru_pvec);
@@ -1913,8 +1911,6 @@ generic_file_buffered_write(struct kiocb
 
 		status = a_ops->prepare_write(file, page, offset, offset+bytes);
 		if (unlikely(status)) {
-			loff_t isize = i_size_read(inode);
-
 			if (status != AOP_TRUNCATED_PAGE)
 				unlock_page(page);
 			page_cache_release(page);
@@ -1922,52 +1918,86 @@ generic_file_buffered_write(struct kiocb
 				continue;
 			/*
 			 * prepare_write() may have instantiated a few blocks
-			 * outside i_size.  Trim these off again.
+			 * outside i_size.  Trim these off again. Don't need
+			 * i_size_read because we hold i_mutex.
 			 */
-			if (pos + bytes > isize)
-				vmtruncate(inode, isize);
+			if (pos + bytes > inode->i_size)
+				vmtruncate(inode, inode->i_size);
 			break;
 		}
+
+		/*
+		 * Must not enter the pagefault handler here, because we hold
+		 * the page lock, so we might recursively deadlock on the same
+		 * lock, or get an ABBA deadlock against a different lock, or
+		 * against the mmap_sem (which nests outside the page lock).
+		 * So increment preempt count, and use _atomic usercopies.
+		 */
+		inc_preempt_count();
 		if (likely(nr_segs == 1))
-			copied = filemap_copy_from_user(page, offset,
+			copied = filemap_copy_from_user_atomic(page, offset,
 							buf, bytes);
 		else
-			copied = filemap_copy_from_user_iovec(page, offset,
-						cur_iov, iov_offset, bytes);
+			copied = filemap_copy_from_user_iovec_atomic(page,
+						offset, cur_iov, iov_offset,
+						bytes);
+		dec_preempt_count();
+
+		if (!PageUptodate(page)) {
+			/*
+			 * If the page is not uptodate, we cannot allow a
+			 * partial commit_write, because that might expose
+			 * uninitialised data.
+			 *
+			 * We will enter the single-segment path below, which
+			 * should get the filesystem to bring the page
+			 * uputodate for us next time.
+			 */
+			if (unlikely(copied != bytes))
+				copied = 0;
+		}
+
 		flush_dcache_page(page);
-		status = a_ops->commit_write(file, page, offset, offset+bytes);
+		status = a_ops->commit_write(file, page, offset, offset+copied);
 		if (status == AOP_TRUNCATED_PAGE) {
 			page_cache_release(page);
 			continue;
 		}
-		if (likely(copied > 0)) {
-			if (!status)
-				status = copied;
-
-			if (status >= 0) {
-				written += status;
-				count -= status;
-				pos += status;
-				buf += status;
-				if (unlikely(nr_segs > 1)) {
-					filemap_set_next_iovec(&cur_iov,
-							&iov_offset, status);
-					if (count)
-						buf = cur_iov->iov_base +
-							iov_offset;
-				} else {
-					iov_offset += status;
-				}
-			}
-		}
-		if (unlikely(copied != bytes))
-			if (status >= 0)
-				status = -EFAULT;
 		unlock_page(page);
 		mark_page_accessed(page);
 		page_cache_release(page);
+
 		if (status < 0)
 			break;
+		if (likely(copied > 0)) {
+			written += copied;
+			count -= copied;
+			pos += copied;
+			buf += copied;
+			if (unlikely(nr_segs > 1)) {
+				filemap_set_next_iovec(&cur_iov,
+						&iov_offset, copied);
+				if (count)
+					buf = cur_iov->iov_base + iov_offset;
+			} else {
+				iov_offset += copied;
+			}
+		} else {
+#ifdef CONFIG_DEBUG_VM
+			fault_in_pages_readable(buf, bytes);
+#endif
+			/*
+			 * OK, we took a fault without making progress. Fall
+			 * back to trying just a single segment next time.
+			 * This is important to prevent deadlock if a full
+			 * page write was not causing the page to be brought
+			 * uptodate. A smaller write will tend to bring it
+			 * uptodate in ->prepare_write, and thus we have a
+			 * chance of making some progress.
+			 */
+			bytes = seglen;
+			goto retry_noprogress;
+		}
 		balance_dirty_pages_ratelimited(mapping);
 		cond_resched();
 	} while (count);
Index: linux-2.6/mm/filemap.h
===================================================================
--- linux-2.6.orig/mm/filemap.h
+++ linux-2.6/mm/filemap.h
@@ -22,19 +22,19 @@ __filemap_copy_from_user_iovec_inatomic(
 
 /*
  * Copy as much as we can into the page and return the number of bytes which
- * were sucessfully copied.  If a fault is encountered then clear the page
- * out to (offset+bytes) and return the number of bytes which were copied.
+ * were sucessfully copied.  If a fault is encountered then return the number of
+ * bytes which were copied.
  *
- * NOTE: For this to work reliably we really want copy_from_user_inatomic_nocache
- * to *NOT* zero any tail of the buffer that it failed to copy.  If it does,
- * and if the following non-atomic copy succeeds, then there is a small window
- * where the target page contains neither the data before the write, nor the
- * data after the write (it contains zero).  A read at this time will see
- * data that is inconsistent with any ordering of the read and the write.
- * (This has been detected in practice).
+ * NOTE: For this to work reliably we really want
+ * copy_from_user_inatomic_nocache to *NOT* zero any tail of the buffer that it
+ * failed to copy.  If it does, and if the following non-atomic copy succeeds,
+ * then there is a small window where the target page contains neither the data
+ * before the write, nor the data after the write (it contains zero).  A read at
+ * this time will see data that is inconsistent with any ordering of the read
+ * and the write.  (This has been detected in practice).
  */
 static inline size_t
-filemap_copy_from_user(struct page *page, unsigned long offset,
+filemap_copy_from_user_atomic(struct page *page, unsigned long offset,
 			const char __user *buf, unsigned bytes)
 {
 	char *kaddr;
@@ -44,23 +44,32 @@ filemap_copy_from_user(struct page *page
 	left = __copy_from_user_inatomic_nocache(kaddr + offset, buf, bytes);
 	kunmap_atomic(kaddr, KM_USER0);
 
-	if (left != 0) {
-		/* Do it the slow way */
-		kaddr = kmap(page);
-		left = __copy_from_user_nocache(kaddr + offset, buf, bytes);
-		kunmap(page);
-	}
+	return bytes - left;
+}
+
+static inline size_t
+filemap_copy_from_user_nonatomic(struct page *page, unsigned long offset,
+			const char __user *buf, unsigned bytes)
+{
+	char *kaddr;
+	int left;
+
+	kaddr = kmap(page);
+	left = __copy_from_user_nocache(kaddr + offset, buf, bytes);
+	kunmap(page);
+
 	return bytes - left;
 }
 
 /*
- * This has the same sideeffects and return value as filemap_copy_from_user().
+ * This has the same sideeffects and return value as
+ * filemap_copy_from_user_atomic().
  * The difference is that on a fault we need to memset the remainder of the
  * page (out to offset+bytes), to emulate filemap_copy_from_user()'s
  * single-segment behaviour.
  */
 static inline size_t
-filemap_copy_from_user_iovec(struct page *page, unsigned long offset,
+filemap_copy_from_user_iovec_atomic(struct page *page, unsigned long offset,
 			const struct iovec *iov, size_t base, size_t bytes)
 {
 	char *kaddr;
@@ -70,14 +79,27 @@ filemap_copy_from_user_iovec(struct page
 	copied = __filemap_copy_from_user_iovec_inatomic(kaddr + offset, iov,
 							 base, bytes);
 	kunmap_atomic(kaddr, KM_USER0);
-	if (copied != bytes) {
-		kaddr = kmap(page);
-		copied = __filemap_copy_from_user_iovec_inatomic(kaddr + offset, iov,
-								 base, bytes);
-		if (bytes - copied)
-			memset(kaddr + offset + copied, 0, bytes - copied);
-		kunmap(page);
-	}
+	return copied;
+}
+
+/*
+ * This has the same sideeffects and return value as
+ * filemap_copy_from_user_nonatomic().
+ * The difference is that on a fault we need to memset the remainder of the
+ * page (out to offset+bytes), to emulate filemap_copy_from_user_nonatomic()'s
+ * single-segment behaviour.
+ */
+static inline size_t
+filemap_copy_from_user_iovec_nonatomic(struct page *page, unsigned long offset,
+			const struct iovec *iov, size_t base, size_t bytes)
+{
+	char *kaddr;
+	size_t copied;
+
+	kaddr = kmap(page);
+	copied = __filemap_copy_from_user_iovec_inatomic(kaddr + offset, iov,
+							 base, bytes);
+	kunmap(page);
 	return copied;
 }
 
Index: linux-2.6/fs/libfs.c
===================================================================
--- linux-2.6.orig/fs/libfs.c
+++ linux-2.6/fs/libfs.c
@@ -327,32 +327,35 @@ int simple_readpage(struct file *file, s
 int simple_prepare_write(struct file *file, struct page *page,
 			unsigned from, unsigned to)
 {
-	if (!PageUptodate(page)) {
-		if (to - from != PAGE_CACHE_SIZE) {
-			void *kaddr = kmap_atomic(page, KM_USER0);
-			memset(kaddr, 0, from);
-			memset(kaddr + to, 0, PAGE_CACHE_SIZE - to);
-			flush_dcache_page(page);
-			kunmap_atomic(kaddr, KM_USER0);
-		}
+	if (PageUptodate(page))
+		return 0;
+
+	if (to - from != PAGE_CACHE_SIZE) {
+		clear_highpage(page);
+		flush_dcache_page(page);
 		SetPageUptodate(page);
 	}
+
 	return 0;
 }
 
 int simple_commit_write(struct file *file, struct page *page,
-			unsigned offset, unsigned to)
+			unsigned from, unsigned to)
 {
-	struct inode *inode = page->mapping->host;
-	loff_t pos = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
-
-	/*
-	 * No need to use i_size_read() here, the i_size
-	 * cannot change under us because we hold the i_mutex.
-	 */
-	if (pos > inode->i_size)
-		i_size_write(inode, pos);
-	set_page_dirty(page);
+	if (to > from) {
+		struct inode *inode = page->mapping->host;
+		loff_t pos = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
+
+		if (to - from == PAGE_CACHE_SIZE)
+			SetPageUptodate(page);
+		/*
+		 * No need to use i_size_read() here, the i_size
+		 * cannot change under us because we hold the i_mutex.
+		 */
+		if (pos > inode->i_size)
+			i_size_write(inode, pos);
+		set_page_dirty(page);
+	}
 	return 0;
 }
 
Index: linux-2.6/fs/buffer.c
===================================================================
--- linux-2.6.orig/fs/buffer.c
+++ linux-2.6/fs/buffer.c
@@ -1856,6 +1856,9 @@ static int __block_commit_write(struct i
 	unsigned blocksize;
 	struct buffer_head *bh, *head;
 
+	if (from == to)
+		return 0;
+
 	blocksize = 1 << inode->i_blkbits;
 
 	for(bh = head = page_buffers(page), block_start = 0;
@@ -2317,17 +2320,6 @@ int nobh_prepare_write(struct page *page
 
 	if (is_mapped_to_disk)
 		SetPageMappedToDisk(page);
-	SetPageUptodate(page);
-
-	/*
-	 * Setting the page dirty here isn't necessary for the prepare_write
-	 * function - commit_write will do that.  But if/when this function is
-	 * used within the pagefault handler to ensure that all mmapped pages
-	 * have backing space in the filesystem, we will need to dirty the page
-	 * if its contents were altered.
-	 */
-	if (dirtied_it)
-		set_page_dirty(page);
 
 	return 0;
 
@@ -2337,15 +2329,6 @@ failed:
 			free_buffer_head(read_bh[i]);
 	}
 
-	/*
-	 * Error recovery is pretty slack.  Clear the page and mark it dirty
-	 * so we'll later zero out any blocks which _were_ allocated.
-	 */
-	kaddr = kmap_atomic(page, KM_USER0);
-	memset(kaddr, 0, PAGE_CACHE_SIZE);
-	kunmap_atomic(kaddr, KM_USER0);
-	SetPageUptodate(page);
-	set_page_dirty(page);
 	return ret;
 }
 EXPORT_SYMBOL(nobh_prepare_write);
@@ -2353,13 +2336,16 @@ EXPORT_SYMBOL(nobh_prepare_write);
 int nobh_commit_write(struct file *file, struct page *page,
 		unsigned from, unsigned to)
 {
-	struct inode *inode = page->mapping->host;
-	loff_t pos = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
+	if (to > from) {
+		struct inode *inode = page->mapping->host;
+		loff_t pos = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
 
-	set_page_dirty(page);
-	if (pos > inode->i_size) {
-		i_size_write(inode, pos);
-		mark_inode_dirty(inode);
+		SetPageUptodate(page);
+		set_page_dirty(page);
+		if (pos > inode->i_size) {
+			i_size_write(inode, pos);
+			mark_inode_dirty(inode);
+		}
 	}
 	return 0;
 }
@@ -2450,6 +2436,7 @@ int nobh_truncate_page(struct address_sp
 		memset(kaddr + offset, 0, PAGE_CACHE_SIZE - offset);
 		flush_dcache_page(page);
 		kunmap_atomic(kaddr, KM_USER0);
+		SetPageUptodate(page);
 		set_page_dirty(page);
 	}
 	unlock_page(page);
