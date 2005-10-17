Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbVJQWVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbVJQWVJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 18:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbVJQWVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 18:21:09 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:37531 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S932336AbVJQWVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 18:21:08 -0400
Date: Mon, 17 Oct 2005 15:20:51 -0700
From: Zach Brown <zach.brown@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>
Subject: [RFC] page lock ordering and OCFS2
Message-ID: <20051017222051.GA26414@tetsuo.zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I sent an ealier version of this patch to linux-fsdevel and was met with
deafening silence.  I'm resending the commentary from that first mail and am
including a new version of the patch.  This time it has much clearer naming
and some kerneldoc blurbs.  Here goes...

--

In recent weeks we've been reworking the locking in OCFS2 to simplify things
and make it behave more like a "local" Linux file system.  We've run into an
ordering inversion between a page's PG_locked and OCFS2's DLM locks that
protect page cache contents.  I'm including a patch at the end of this mail
that I think is a clean way to give the file system a chance to get the
ordering right, but we're open to any and all suggestions.  We want to do the
cleanest thing.

OCFS2 maintains page cache coherence between nodes by requiring that a node
hold a valid lock while there are active pages in the page cache.  The page
cache is invalidated before a node releases a lock so that another node can
acquire it.  While this invalidation is happening new locks can not be acquired
on that node.  This is equivalent to a DLM processing thread acquiring
PG_locked during truncation while holding a DLM lock.  Normal file system user
tasks come to the a_ops with PG_locked acquired by their callers before they
have a chance to get DLM locks.

We talked a little about modifying the invalidation path to avoid waiting for
pages that are held by an OCFS2 path that is waiting for a DLM lock.  It seems
awfully hard to get right without some very nasty code.  The truncation on lock
removal has to write back dirty pages so that other nodes can read it -- it
can't simply skip these pages if they happened to be locked.

So we aimed right for the lock ordering inversion problem with the appended
patch.  It gives file systems a callback that is tried before page locks are
acquired that are going to be passed in to the file system's a_ops methods.

So, what do people think about this?  Is it reasonable to patch the core to
help OCFS2 with this ordering inversion?

- z

Index: 2.6.14-rc4-guard-page-locks/drivers/block/loop.c
===================================================================
--- 2.6.14-rc4-guard-page-locks.orig/drivers/block/loop.c	2005-10-14 16:47:25.000000000 -0700
+++ 2.6.14-rc4-guard-page-locks/drivers/block/loop.c	2005-10-14 17:01:42.000000000 -0700
@@ -229,9 +229,13 @@
 		size = PAGE_CACHE_SIZE - offset;
 		if (size > len)
 			size = len;
+		if (mapping_guard_page_locks(mapping, 1))
+			goto fail;
 		page = grab_cache_page(mapping, index);
-		if (unlikely(!page))
+		if (unlikely(!page)) {
+			mapping_page_locks_done(mapping, 1);
 			goto fail;
+		}
 		if (unlikely(aops->prepare_write(file, page, offset,
 				offset + size)))
 			goto unlock;
@@ -263,6 +267,7 @@
 		pos += size;
 		unlock_page(page);
 		page_cache_release(page);
+		mapping_page_locks_done(mapping, 1);
 	}
 out:
 	up(&mapping->host->i_sem);
@@ -270,6 +275,7 @@
 unlock:
 	unlock_page(page);
 	page_cache_release(page);
+	mapping_page_locks_done(mapping, 1);
 fail:
 	ret = -1;
 	goto out;
Index: 2.6.14-rc4-guard-page-locks/fs/buffer.c
===================================================================
--- 2.6.14-rc4-guard-page-locks.orig/fs/buffer.c	2005-10-14 16:48:12.000000000 -0700
+++ 2.6.14-rc4-guard-page-locks/fs/buffer.c	2005-10-14 16:55:34.000000000 -0700
@@ -2174,16 +2174,24 @@
 	if ((offset & (inode->i_sb->s_blocksize - 1)) == 0) {
 		offset++;
 	}
+
+	err = mapping_guard_page_locks(mapping, 1);
+	if (err)
+		goto out;
+
 	index = size >> PAGE_CACHE_SHIFT;
-	err = -ENOMEM;
 	page = grab_cache_page(mapping, index);
-	if (!page)
+	if (!page) {
+		err = -ENOMEM;
+		mapping_page_locks_done(mapping, 1);
 		goto out;
+	}
 	err = mapping->a_ops->prepare_write(NULL, page, offset, offset);
 	if (!err) {
 		err = mapping->a_ops->commit_write(NULL, page, offset, offset);
 	}
 	unlock_page(page);
+	mapping_page_locks_done(mapping, 1);
 	page_cache_release(page);
 	if (err > 0)
 		err = 0;
@@ -2572,10 +2580,16 @@
 	if ((offset & (blocksize - 1)) == 0)
 		goto out;
 
-	ret = -ENOMEM;
+	ret = mapping_guard_page_locks(mapping, 1);
+	if (ret)
+		goto out;
+
 	page = grab_cache_page(mapping, index);
-	if (!page)
+	if (!page) {
+		mapping_page_locks_done(mapping, 1);
+		ret = -ENOMEM;
 		goto out;
+	}
 
 	to = (offset + blocksize) & ~(blocksize - 1);
 	ret = a_ops->prepare_write(NULL, page, offset, to);
@@ -2588,6 +2602,7 @@
 	}
 	unlock_page(page);
 	page_cache_release(page);
+	mapping_page_locks_done(mapping, 1);
 out:
 	return ret;
 }
Index: 2.6.14-rc4-guard-page-locks/include/linux/fs.h
===================================================================
--- 2.6.14-rc4-guard-page-locks.orig/include/linux/fs.h	2005-10-14 16:48:15.000000000 -0700
+++ 2.6.14-rc4-guard-page-locks/include/linux/fs.h	2005-10-17 14:54:05.841846285 -0700
@@ -325,6 +325,10 @@
 			loff_t offset, unsigned long nr_segs);
 	struct page* (*get_xip_page)(struct address_space *, sector_t,
 			int);
+
+	/* see mapping_guard_page_locks() */
+	int (*guard_page_locks)(struct address_space *, int write);
+	void (*page_locks_done)(struct address_space *, int write);
 };
 
 struct backing_dev_info;
Index: 2.6.14-rc4-guard-page-locks/include/linux/pagemap.h
===================================================================
--- 2.6.14-rc4-guard-page-locks.orig/include/linux/pagemap.h	2005-10-14 16:48:15.000000000 -0700
+++ 2.6.14-rc4-guard-page-locks/include/linux/pagemap.h	2005-10-17 15:05:46.980757058 -0700
@@ -143,6 +143,54 @@
 	return ret;
 }
 
+/**
+ * mapping_guard_page_locks - call before handing locked pages to a_ops
+ * @mapping: mapping whose aops will be called
+ * @write: whether or not the pages will be written to 
+ *
+ * Call this before acquiring page locks and handing the locked pages to the
+ * following address_space_operations: readpage(), readpages(),
+ * prepare_write(), and commit_write().  This must be called before the page
+ * locks are acquired.  It must be called only once for a given series of page
+ * locks on a mapping.  A mapping_guard_page_locks() call must be completed
+ * with a call to mapping_page_locks_done() before another
+ * maping_guard_page_locks() call can be made -- it isn't recursive.
+ *
+ * Multiple pages may be locked and multiple a_ops methods may be called within
+ * a given mapping_guard_page_locks() and mapping_page_locks_done() pair. 
+ * 
+ * This may return -errno and must be considered fatal.  Page locks should not
+ * be acquired and handed to a_ops called if this fails.
+ *
+ * This exists because some file systems have lock ordering which requires that
+ * internal locks be acquired before page locks.
+ *
+ * This call must be ordered under i_sem.
+ */
+static inline int mapping_guard_page_locks(struct address_space *mapping, int write)
+{
+	might_sleep();
+	if (mapping->a_ops->guard_page_locks)
+		return mapping->a_ops->guard_page_locks(mapping, write);
+	else
+		return 0;
+}
+
+/**
+ * mapping_page_locks_done - called once locked pages are handed to a_ops
+ * @mapping: mapping whose aops will be called
+ * @write: matches paired mapping_guard_page_locks() call
+ *
+ * see mapping_guard_page_locks().  This must be called once all the pages
+ * that were locked after mapping_guard_page_locks() have been handed to
+ * the a_ops methods.  
+ */
+static inline void mapping_page_locks_done(struct address_space *mapping, int write)
+{
+	if (mapping->a_ops->page_locks_done)
+		mapping->a_ops->page_locks_done(mapping, write);
+}
+
 /*
  * Return byte-offset into filesystem object for page.
  */
Index: 2.6.14-rc4-guard-page-locks/mm/filemap.c
===================================================================
--- 2.6.14-rc4-guard-page-locks.orig/mm/filemap.c	2005-10-14 16:48:15.000000000 -0700
+++ 2.6.14-rc4-guard-page-locks/mm/filemap.c	2005-10-14 16:55:34.000000000 -0700
@@ -811,12 +811,17 @@
 		goto out;
 
 page_not_up_to_date:
+		error = mapping_guard_page_locks(mapping, 0);
+		if (error)
+			goto readpage_error;
+
 		/* Get exclusive access to the page ... */
 		lock_page(page);
 
 		/* Did it get unhashed before we got the lock? */
 		if (!page->mapping) {
 			unlock_page(page);
+			mapping_page_locks_done(mapping, 0);
 			page_cache_release(page);
 			continue;
 		}
@@ -824,13 +829,14 @@
 		/* Did somebody else fill it already? */
 		if (PageUptodate(page)) {
 			unlock_page(page);
+			mapping_page_locks_done(mapping, 0);
 			goto page_ok;
 		}
 
 readpage:
 		/* Start the actual read. The read will unlock the page. */
 		error = mapping->a_ops->readpage(filp, page);
-
+		mapping_page_locks_done(mapping, 0);
 		if (unlikely(error))
 			goto readpage_error;
 
@@ -890,21 +896,35 @@
 		 * Ok, it wasn't cached, so we need to create a new
 		 * page..
 		 */
+		error = mapping_guard_page_locks(mapping, 0);
+		if (error) {
+			desc->error = error;
+			goto out;
+		}
+
 		if (!cached_page) {
 			cached_page = page_cache_alloc_cold(mapping);
 			if (!cached_page) {
+				mapping_page_locks_done(mapping, 0);
 				desc->error = -ENOMEM;
 				goto out;
 			}
 		}
+
 		error = add_to_page_cache_lru(cached_page, mapping,
 						index, GFP_KERNEL);
 		if (error) {
+			mapping_page_locks_done(mapping, 0);
+			if (mapping->a_ops->guard_page_locks) {
+				page_cache_release(cached_page);
+				cached_page = NULL;
+			}
 			if (error == -EEXIST)
 				goto find_page;
 			desc->error = error;
 			goto out;
 		}
+
 		page = cached_page;
 		cached_page = NULL;
 		goto readpage;
@@ -1151,27 +1171,37 @@
 static int fastcall page_cache_read(struct file * file, unsigned long offset)
 {
 	struct address_space *mapping = file->f_mapping;
-	struct page *page; 
+	struct page *page;
 	int error;
 
+	error = mapping_guard_page_locks(mapping, 0);
+	if (error)
+		return error;
+
 	page = page_cache_alloc_cold(mapping);
-	if (!page)
-		return -ENOMEM;
+	if (!page) {
+		error = -ENOMEM;
+		goto out;
+	}
 
 	error = add_to_page_cache_lru(page, mapping, offset, GFP_KERNEL);
-	if (!error) {
-		error = mapping->a_ops->readpage(file, page);
-		page_cache_release(page);
-		return error;
+	if (error) {
+		if (error == -EEXIST) {
+			/*
+			 * We arrive here in the unlikely event that someone
+			 * raced with us and added our page to the cache first.
+			 */
+			error = 0;
+		}
+		goto out;
 	}
 
-	/*
-	 * We arrive here in the unlikely event that someone 
-	 * raced with us and added our page to the cache first
-	 * or we are out of memory for radix-tree nodes.
-	 */
-	page_cache_release(page);
-	return error == -EEXIST ? 0 : error;
+	error = mapping->a_ops->readpage(file, page);
+out:
+	if (page)
+		page_cache_release(page);
+	mapping_page_locks_done(mapping, 0);
+	return error;
 }
 
 #define MMAP_LOTSAMISS  (100)
@@ -1316,38 +1346,52 @@
 		majmin = VM_FAULT_MAJOR;
 		inc_page_state(pgmajfault);
 	}
+
+	if (mapping_guard_page_locks(mapping, 0))
+		goto retry;
+
 	lock_page(page);
 
 	/* Did it get unhashed while we waited for it? */
 	if (!page->mapping) {
 		unlock_page(page);
+		mapping_page_locks_done(mapping, 0);
 		page_cache_release(page);
 		goto retry_all;
 	}
 
 	/* Did somebody else get it up-to-date? */
 	if (PageUptodate(page)) {
+		mapping_page_locks_done(mapping, 0);
 		unlock_page(page);
 		goto success;
 	}
 
 	if (!mapping->a_ops->readpage(file, page)) {
+		mapping_page_locks_done(mapping, 0);
 		wait_on_page_locked(page);
 		if (PageUptodate(page))
 			goto success;
 	}
 
+	mapping_page_locks_done(mapping, 0);
+
 	/*
 	 * Umm, take care of errors if the page isn't up-to-date.
 	 * Try to re-read it _once_. We do this synchronously,
 	 * because there really aren't any performance issues here
 	 * and we need to check for errors.
 	 */
+retry:
+	if (mapping_guard_page_locks(mapping, 0))
+		goto error;
+
 	lock_page(page);
 
 	/* Somebody truncated the page on us? */
 	if (!page->mapping) {
 		unlock_page(page);
+		mapping_page_locks_done(mapping, 0);
 		page_cache_release(page);
 		goto retry_all;
 	}
@@ -1355,10 +1399,12 @@
 	/* Somebody else successfully read it in? */
 	if (PageUptodate(page)) {
 		unlock_page(page);
+		mapping_page_locks_done(mapping, 0);
 		goto success;
 	}
 	ClearPageError(page);
 	if (!mapping->a_ops->readpage(file, page)) {
+		mapping_page_locks_done(mapping, 0);
 		wait_on_page_locked(page);
 		if (PageUptodate(page))
 			goto success;
@@ -1368,6 +1414,7 @@
 	 * Things didn't work out. Return zero to tell the
 	 * mm layer so, possibly freeing the page cache page first.
 	 */
+error:
 	page_cache_release(page);
 	return NULL;
 }
@@ -1430,52 +1477,69 @@
 	return NULL;
 
 page_not_uptodate:
+	if (mapping_guard_page_locks(mapping, 0))
+		goto retry;
+
 	lock_page(page);
 
 	/* Did it get unhashed while we waited for it? */
 	if (!page->mapping) {
 		unlock_page(page);
+		mapping_page_locks_done(mapping, 0);
 		goto err;
 	}
 
 	/* Did somebody else get it up-to-date? */
 	if (PageUptodate(page)) {
 		unlock_page(page);
+		mapping_page_locks_done(mapping, 0);
 		goto success;
 	}
 
 	if (!mapping->a_ops->readpage(file, page)) {
+		mapping_page_locks_done(mapping, 0);
 		wait_on_page_locked(page);
 		if (PageUptodate(page))
 			goto success;
 	}
 
+	mapping_page_locks_done(mapping, 0);
+
 	/*
 	 * Umm, take care of errors if the page isn't up-to-date.
 	 * Try to re-read it _once_. We do this synchronously,
 	 * because there really aren't any performance issues here
 	 * and we need to check for errors.
 	 */
+retry:
+	if (mapping_guard_page_locks(mapping, 0))
+		goto err;
+
 	lock_page(page);
 
 	/* Somebody truncated the page on us? */
 	if (!page->mapping) {
 		unlock_page(page);
+		mapping_page_locks_done(mapping, 0);
 		goto err;
 	}
 	/* Somebody else successfully read it in? */
 	if (PageUptodate(page)) {
 		unlock_page(page);
+		mapping_page_locks_done(mapping, 0);
 		goto success;
 	}
 
 	ClearPageError(page);
 	if (!mapping->a_ops->readpage(file, page)) {
+		mapping_page_locks_done(mapping, 0);
 		wait_on_page_locked(page);
 		if (PageUptodate(page))
 			goto success;
 	}
 
+	mapping_page_locks_done(mapping, 0);
+
 	/*
 	 * Things didn't work out. Return zero to tell the
 	 * mm layer so, possibly freeing the page cache page first.
@@ -1889,6 +1953,7 @@
 	const struct iovec *cur_iov = iov; /* current iovec */
 	size_t		iov_base = 0;	   /* offset in the current iovec */
 	char __user	*buf;
+	int		guarding = 0;
 
 	pagevec_init(&lru_pvec, 0);
 
@@ -1925,6 +1990,11 @@
 			maxlen = bytes;
 		fault_in_pages_readable(buf, maxlen);
 
+		status = mapping_guard_page_locks(mapping, 1);
+		if (status)
+			break;
+		guarding = 1;
+
 		page = __grab_cache_page(mapping,index,&cached_page,&lru_pvec);
 		if (!page) {
 			status = -ENOMEM;
@@ -1976,6 +2046,8 @@
 			if (status >= 0)
 				status = -EFAULT;
 		unlock_page(page);
+		mapping_page_locks_done(mapping, 1);
+		guarding = 0;
 		mark_page_accessed(page);
 		page_cache_release(page);
 		if (status < 0)
@@ -1987,6 +2059,8 @@
 
 	if (cached_page)
 		page_cache_release(cached_page);
+	if (guarding)
+		mapping_page_locks_done(mapping, 1);
 
 	/*
 	 * For now, when the user asks for O_SYNC, we'll actually give O_DSYNC
Index: 2.6.14-rc4-guard-page-locks/mm/readahead.c
===================================================================
--- 2.6.14-rc4-guard-page-locks.orig/mm/readahead.c	2005-10-14 16:48:15.000000000 -0700
+++ 2.6.14-rc4-guard-page-locks/mm/readahead.c	2005-10-14 16:55:34.000000000 -0700
@@ -269,6 +269,10 @@
 
  	end_index = ((isize - 1) >> PAGE_CACHE_SHIFT);
 
+	ret = mapping_guard_page_locks(mapping, 0);
+	if (ret)
+		goto out;
+
 	/*
 	 * Preallocate as many pages as we will need.
 	 */
@@ -302,6 +306,7 @@
 	if (ret)
 		read_pages(mapping, filp, &page_pool, ret);
 	BUG_ON(!list_empty(&page_pool));
+	mapping_page_locks_done(mapping, 0);
 out:
 	return ret;
 }
