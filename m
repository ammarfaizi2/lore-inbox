Return-Path: <linux-kernel-owner+w=401wt.eu-S1752566AbWLQNAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566AbWLQNAO (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 08:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752568AbWLQNAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 08:00:13 -0500
Received: from ns.suse.de ([195.135.220.2]:32800 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752566AbWLQNAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 08:00:11 -0500
X-Greylist: delayed 1017 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Dec 2006 08:00:10 EST
Date: Sun, 17 Dec 2006 13:43:01 +0100
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>,
       linux-fsdevel@vger.kernel.org
Cc: Mark Fasheh <mark.fasheh@oracle.com>,
       Christoph Hellwig <hch@infradead.org>
Subject: [rfc][patch] fix buffered write deadlocks with extra copy (and a way out?)
Message-ID: <20061217124301.GA24637@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My attempt to fix this problem by modifying the prepare_write/commit_write
API fell on its face because it ended up breaking filesystems and the
buffer layer in various interesting ways, but probably more importantly
the logic was getting complex and fragile and the fixes would have made
that even worse.

What I will now propose is basically the simplest possible solution (AFAIKS),
which is almost obviously correct, and fixes not only the deadlock but
also corruption that comes from a failed usercopy inserting zeroes into
the pagecache (eg. upon EFAULT).

The price is quite large. An extra copy. One from userspace into a temporary
buffer, then a second from temp buffer to actual pagecache. I wanted to
avoid this for obvious reasons, but now I think I have to advocate it for
correctness over performance.

There are a number of things we can do to avoid some of this overhead -- we
could avoid the extra copy when doing a full-page write into a newly
allocated page, and when writing to uptodate pagecache. But I prefer not
to (and haven't in this patch) because it adds quite a bit of complexity
and does not solve _all_ cases.

What I propose instead is to add a new aop, perform_write which can be
implemented instead of the inflexible 2-phase API. It would be up to the
filesystem implementation to perform the data copy. Initially I tried
wrapping up the iovec stuff into an iterator structure passed into
perform_write, which can then pass it back to filemap_copy_from_user
helpers. However this is not enough to handle stuff like loop.c usage
if we wanted the API to be able to replace prepare/commmit completely.
Maybe passing down a generic "filler" function would be a better idea?

Anyway, as an aside, the perform_write API need not be a page based one
(in my half-done implementation it is not), so it can end up fulfilling
the role of Hans's batch_write proposal. Actually now that I look at
his patch there are similarities (eg. my iovec iterator struct
looks similar).

I would like more input about this from filesystems people, and will post
a sample implementation after a first round of feedback.

For now, I just submit the double-buffer patch for comments. It is not
quite polished (but does run OK). It does rely on some previous cleanups
and changes not posted. If there are no objections I'll submit the whole
patchset for inclusion.

Thanks,
Nick

--
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

(also, rename maxlen to seglen, because it was confusing)

Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c
+++ linux-2.6/mm/filemap.c
@@ -1837,7 +1837,7 @@ generic_file_buffered_write(struct kiocb
 	long		status = 0;
 	const struct iovec *cur_iov = iov; /* current iovec */
 	size_t		iov_offset = 0;	   /* offset in the current iovec */
-	char __user	*buf;
+	struct page	*tmp_pg = NULL;
 
 	/*
 	 * handle partial DIO write.  Adjust cur_iov if needed.
@@ -1846,72 +1846,70 @@ generic_file_buffered_write(struct kiocb
 
 	do {
 		struct page *page;
+		char *src, *dst;
 		pgoff_t index;		/* Pagecache index for current page */
 		unsigned long offset;	/* Offset into pagecache page */
-		unsigned long maxlen;	/* Bytes remaining in current iovec */
 		size_t bytes;		/* Bytes to write to page */
 		size_t copied;		/* Bytes copied from user */
 
-		buf = cur_iov->iov_base + iov_offset;
 		offset = (pos & (PAGE_CACHE_SIZE - 1));
 		index = pos >> PAGE_CACHE_SHIFT;
 		bytes = PAGE_CACHE_SIZE - offset;
 		if (bytes > count)
 			bytes = count;
 
-		maxlen = cur_iov->iov_len - iov_offset;
-		if (maxlen > bytes)
-			maxlen = bytes;
-
-#ifndef CONFIG_DEBUG_VM
-		/*
-		 * Bring in the user page that we will copy from _first_.
-		 * Otherwise there's a nasty deadlock on copying from the
-		 * same page as we're writing to, without it being marked
-		 * up-to-date.
-		 */
-		fault_in_pages_readable(buf, maxlen);
-#endif
+		if (!tmp_pg) {
+			tmp_pg = page_cache_alloc(mapping);
+			if (!tmp_pg) {
+				status = -ENOMEM;
+				break;
+			}
+			src = kmap(tmp_pg);
+		}
 
+		copied = filemap_copy_from_user(tmp_pg, offset,
+				cur_iov, nr_segs, iov_offset, bytes);
+		if (unlikely(!copied)) {
+			status = -EFAULT;
+			break;
+		}
+		bytes = copied;
 
 		page = __grab_cache_page(mapping, index);
 		if (!page) {
 			status = -ENOMEM;
 			break;
 		}
+		dst = kmap(page);
 
 		status = a_ops->prepare_write(file, page, offset, offset+bytes);
 		if (unlikely(status))
 			goto fs_write_aop_error;
 
-		copied = filemap_copy_from_user(page, offset,
-					cur_iov, nr_segs, iov_offset, bytes);
+		memcpy(dst+offset, src+offset, bytes);
 		flush_dcache_page(page);
 
 		status = a_ops->commit_write(file, page, offset, offset+bytes);
 		if (unlikely(status))
 			goto fs_write_aop_error;
 
-		if (likely(copied > 0)) {
-			written += copied;
-			count -= copied;
-			pos += copied;
-			filemap_set_next_iovec(&cur_iov, nr_segs,
-						&iov_offset, written);
-		}
-		if (unlikely(copied != bytes))
-			status = -EFAULT;
-
+		kunmap(page);
 		unlock_page(page);
 		mark_page_accessed(page);
 		page_cache_release(page);
-		if (status < 0)
-			break;
 		balance_dirty_pages_ratelimited(mapping);
 		cond_resched();
+
+		if (likely(copied > 0)) {
+			written += copied;
+			count -= copied;
+			pos += copied;
+			filemap_set_next_iovec(&cur_iov, nr_segs, &iov_offset, copied);
+		}
 		continue;
 
 fs_write_aop_error:
+		kunmap(page);
 		if (status != AOP_TRUNCATED_PAGE)
 			unlock_page(page);
 		page_cache_release(page);
@@ -1931,6 +1929,11 @@ fs_write_aop_error:
 	} while (count);
 	*ppos = pos;
 
+	if (tmp_pg) {
+		kunmap(tmp_pg);
+		page_cache_release(tmp_pg);
+	}
+
 	/*
 	 * For now, when the user asks for O_SYNC, we'll actually give O_DSYNC
 	 */
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


