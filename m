Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWF2TRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWF2TRe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWF2TRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:17:33 -0400
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:24032 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932252AbWF2TRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:17:32 -0400
Message-ID: <44A42750.5020807@namesys.com>
Date: Thu, 29 Jun 2006 12:17:36 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] batch-write.patch
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090901050004030106020409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090901050004030106020409
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit




--------------090901050004030106020409
Content-Type: text/x-patch;
 name="batched-write.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="batched-write.patch"


This patch adds a method batch_write to struct address_space_operations.
A filesystem may want to implement this operation to improve write performance.
Generic implementation for the method is made by cut-n-paste off generic_file_buffered_write:
it writes one page using prepare_write and commit_write address space operations.

diff -puN mm/filemap.c~batched-write mm/filemap.c

diff -puN include/linux/fs.h~batched-write include/linux/fs.h



diff -puN include/linux/fs.h~batched-write include/linux/fs.h
--- linux-2.6.17-mm3/include/linux/fs.h~batched-write	2006-06-28 21:39:27.000000000 +0400
+++ linux-2.6.17-mm3-root/include/linux/fs.h	2006-06-28 21:39:27.000000000 +0400
@@ -346,6 +346,39 @@ enum positive_aop_returns {
 struct page;
 struct address_space;
 struct writeback_control;
+typedef struct write_descriptor write_descriptor_t;
+
+/*
+ * This is "write_actor" function type, used by write() to copy data from user
+ * space. There are two functions of this type: write_actor and
+ * write_iovec_actor. First is used when user data are in one segment, second
+ * is used in case of vectored write.
+ */
+typedef size_t (*write_actor_t)(struct page *, unsigned long, size_t,
+				const write_descriptor_t *);
+
+/**
+ * struct write_descriptor - set of write arguments
+ * @pos: offset from the start of the file to write to
+ * @count: number of bytes to write
+ * @cur_iov: current i/o vector
+ * @iov_off: offset within current i/o vector
+ * @buf: user data
+ * @actor: function to copy user data with 
+ *
+ * This structure is to pass to batch_write address space operation all
+ * information which is needed to continue write.
+ */
+struct write_descriptor {
+	loff_t pos;
+	size_t count;
+	const struct iovec *cur_iov;
+	size_t iov_off;
+	char __user *buf;
+	write_actor_t actor;
+};
+
+#include <linux/pagevec.h>
 
 struct address_space_operations {
 	int (*writepage)(struct page *page, struct writeback_control *wbc);
@@ -367,6 +400,8 @@ struct address_space_operations {
 	 */
 	int (*prepare_write)(struct file *, struct page *, unsigned, unsigned);
 	int (*commit_write)(struct file *, struct page *, unsigned, unsigned);
+	long (*batch_write)(struct file *, const write_descriptor_t *,
+			    struct pagevec *, struct page **, size_t *);
 	/* Unfortunately this kludge is needed for FIBMAP. Don't use it */
 	sector_t (*bmap)(struct address_space *, sector_t);
 	void (*invalidatepage) (struct page *, unsigned long);
diff -puN mm/filemap.c~batched-write mm/filemap.c
--- linux-2.6.17-mm3/mm/filemap.c~batched-write	2006-06-28 21:39:27.000000000 +0400
+++ linux-2.6.17-mm3-root/mm/filemap.c	2006-06-28 22:03:59.000000000 +0400
@@ -2160,72 +2160,101 @@ generic_file_direct_write(struct kiocb *
 }
 EXPORT_SYMBOL(generic_file_direct_write);
 
-ssize_t
-generic_file_buffered_write(struct kiocb *iocb, const struct iovec *iov,
-		unsigned long nr_segs, loff_t pos, loff_t *ppos,
-		size_t count, ssize_t written)
+/**
+ * write_actor - copy data from user buffer
+ * @page: the page to copy data to
+ * @offset: offset within the page
+ * @bytes: number of bytes to copy
+ * @desc: pointer to user buffer is obtained from here
+ *
+ * This is used to copy data from user buffer into @page in case of i/o vector
+ * has 1 segment. In case of write, in short.
+ */
+static size_t write_actor(struct page *page, unsigned long offset,
+			  size_t bytes, const write_descriptor_t *desc)
 {
-	struct file *file = iocb->ki_filp;
-	struct address_space * mapping = file->f_mapping;
-	const struct address_space_operations *a_ops = mapping->a_ops;
-	struct inode 	*inode = mapping->host;
-	long		status = 0;
-	struct page	*page;
-	struct page	*cached_page = NULL;
-	size_t		bytes;
-	struct pagevec	lru_pvec;
-	const struct iovec *cur_iov = iov; /* current iovec */
-	size_t		iov_base = 0;	   /* offset in the current iovec */
-	char __user	*buf;
+	return filemap_copy_from_user(page, offset, desc->buf, bytes);
+}
 
-	pagevec_init(&lru_pvec, 0);
+/**
+ * write_iovec_actor - copy data from i/o vector
+ * @page: the page to copy data to
+ * @offset: offset within the page
+ * @bytes: number of bytes to copy
+ * @desc: current iovec and offset in it are obtained from here
+ *
+ * This is used to copy data from user buffer into @page in case of i/o vector
+ * has more than segment. In case of writev, in short.
+ */
+static size_t write_iovec_actor(struct page *page, unsigned long offset,
+ 				size_t bytes, const write_descriptor_t *desc)
+{
+ 	return filemap_copy_from_user_iovec(page, offset, desc->cur_iov,
+					    desc->iov_off, bytes);
+}
 
-	/*
-	 * handle partial DIO write.  Adjust cur_iov if needed.
-	 */
-	if (likely(nr_segs == 1))
-		buf = iov->iov_base + written;
-	else {
-		filemap_set_next_iovec(&cur_iov, &iov_base, written);
-		buf = cur_iov->iov_base + iov_base;
-	}
+/**
+ * generic_batch_write - generic implementation of batched write
+ * @file: the file to write to
+ * @desc: set of write arguments
+ * @lru_pvec: multipage container to batch adding pages to LRU list
+ * @cached_page: allocated but not used on previous call
+ * @written: returned number of bytes successfully written
+ *
+ * This implementation of batch_write method writes not more than one page of
+ * file. It faults in user space, allocates page and calls prepare_write and
+ * commit_write address space operations. User data are copied by an actor
+ * which is set by caller depending on whether write or writev is on the way.
+ */
+static long generic_batch_write(struct file *file,
+ 				const write_descriptor_t *desc,
+ 				struct pagevec *lru_pvec,
+ 				struct page **cached_page, size_t *written)
+{
+ 	const struct address_space_operations *a_ops = file->f_mapping->a_ops;
+	struct page *page;
+	unsigned long index;
+	size_t bytes;
+	unsigned long offset;
+	long status;
+
+	/* offset within page write is to start at */
+	offset = (desc->pos & (PAGE_CACHE_SIZE - 1));
 
-	do {
-		unsigned long index;
-		unsigned long offset;
-		size_t copied;
-
-		offset = (pos & (PAGE_CACHE_SIZE -1)); /* Within page */
-		index = pos >> PAGE_CACHE_SHIFT;
-		bytes = PAGE_CACHE_SIZE - offset;
+	/* index of page we are to write to */
+	index = desc->pos >> PAGE_CACHE_SHIFT;
 
-		/* Limit the size of the copy to the caller's write size */
-		bytes = min(bytes, count);
+	/* number of bytes which can be written to the page */
+	bytes = PAGE_CACHE_SIZE - offset;
 
-		/*
-		 * Limit the size of the copy to that of the current segment,
-		 * because fault_in_pages_readable() doesn't know how to walk
-		 * segments.
-		 */
-		bytes = min(bytes, cur_iov->iov_len - iov_base);
+	/* Limit the size of the copy to the caller's write size */
+	bytes = min(bytes, desc->count);
 
+	/*
+	 * Limit the size of the copy to that of the current segment,
+	 * because fault_in_pages_readable() doesn't know how to walk
+	 * segments.
+	 */
+	bytes = min(bytes, desc->cur_iov->iov_len - desc->iov_off);
+
+	while (1) {
 		/*
 		 * Bring in the user page that we will copy from _first_.
 		 * Otherwise there's a nasty deadlock on copying from the
 		 * same page as we're writing to, without it being marked
 		 * up-to-date.
 		 */
-		fault_in_pages_readable(buf, bytes);
+		fault_in_pages_readable(desc->buf, bytes);
 
-		page = __grab_cache_page(mapping,index,&cached_page,&lru_pvec);
-		if (!page) {
-			status = -ENOMEM;
-			break;
-		}
+		page = __grab_cache_page(file->f_mapping, index, cached_page,
+					 lru_pvec);
+		if (!page)
+			return -ENOMEM;
 
-		status = a_ops->prepare_write(file, page, offset, offset+bytes);
+		status = a_ops->prepare_write(file, page, offset,
+					      offset+bytes);
 		if (unlikely(status)) {
-			loff_t isize = i_size_read(inode);
+			loff_t isize = i_size_read(file->f_mapping->host);
 
 			if (status != AOP_TRUNCATED_PAGE)
 				unlock_page(page);
@@ -2233,57 +2262,127 @@ generic_file_buffered_write(struct kiocb
 			if (status == AOP_TRUNCATED_PAGE)
 				continue;
 			/*
-			 * prepare_write() may have instantiated a few blocks
-			 * outside i_size.  Trim these off again.
+			 * prepare_write() may have instantiated a few
+			 * blocks outside i_size.  Trim these off
+			 * again.
 			 */
-			if (pos + bytes > isize)
-				vmtruncate(inode, isize);
-			break;
+			if (desc->pos + bytes > isize)
+				vmtruncate(file->f_mapping->host, isize);
+			return status;
 		}
-		if (likely(nr_segs == 1))
-			copied = filemap_copy_from_user(page, offset,
-							buf, bytes);
-		else
-			copied = filemap_copy_from_user_iovec(page, offset,
-						cur_iov, iov_base, bytes);
+
+		/*
+		 * call write actor in order to copy user data to the
+		 * page
+		 */
+		*written = desc->actor(page, offset, bytes, desc);
+
 		flush_dcache_page(page);
 		status = a_ops->commit_write(file, page, offset, offset+bytes);
 		if (status == AOP_TRUNCATED_PAGE) {
 			page_cache_release(page);
 			continue;
 		}
-		if (likely(copied > 0)) {
-			if (!status)
-				status = copied;
 
-			if (status >= 0) {
-				written += status;
-				count -= status;
-				pos += status;
-				buf += status;
-				if (unlikely(nr_segs > 1)) {
-					filemap_set_next_iovec(&cur_iov,
-							&iov_base, status);
-					if (count)
-						buf = cur_iov->iov_base +
-							iov_base;
-				} else {
-					iov_base += status;
-				}
-			}
-		}
-		if (unlikely(copied != bytes))
-			if (status >= 0)
-				status = -EFAULT;
 		unlock_page(page);
 		mark_page_accessed(page);
 		page_cache_release(page);
+		break;
+	}
+	/*
+	 * If commit_write returned error - write failed and we zero
+	 * number of written bytes. If write_actor copied less than it
+	 * was asked to we return -EFAULT and number of bytes
+	 * actually written.
+	 */
+	if (status)
+		*written = 0;
+	else if (*written != bytes)
+		status = -EFAULT;
+	return status;
+}
+
+ssize_t
+generic_file_buffered_write(struct kiocb *iocb, const struct iovec *iov,
+			    unsigned long nr_segs, loff_t pos, loff_t *ppos,
+			    size_t count, ssize_t written)
+{
+	struct file *file = iocb->ki_filp;
+	struct address_space * mapping = file->f_mapping;
+	const struct address_space_operations *a_ops = mapping->a_ops;
+	struct inode 	*inode = mapping->host;
+	long		status;
+	struct page	*cached_page = NULL;
+	struct pagevec	lru_pvec;
+	write_descriptor_t desc;
+	size_t copied = 0;
+
+	pagevec_init(&lru_pvec, 0);
+
+	/*
+	 * initialize write descriptor fields: position to write to
+	 * and number of bytes to write
+	 */
+	desc.pos = pos;
+	desc.count = count;
+
+	/*
+	 * handle partial DIO write.  Adjust cur_iov if needed.
+	 */
+	if (likely(nr_segs == 1)) {
+		desc.cur_iov = iov;
+		desc.iov_off = written;
+		desc.actor = write_actor;
+	} else {
+		filemap_set_next_iovec(&desc.cur_iov, &desc.iov_off, written);
+		desc.actor = write_iovec_actor;
+	}
+	/* pointer to user buffer */
+	desc.buf = desc.cur_iov->iov_base + desc.iov_off;
+
+	do {
+		/*
+		 * When calling the filesystem for writes, there is processing
+		 * that must be done:
+		 * 1) per word
+		 * 2) per page
+		 * 3) per call to the FS
+		 * If the FS is called per page, then it turns out that 3)
+		 * costs more than 1) and 2) for sophisticated filesystems.  To
+		 * allow the FS to choose to pay the cost of 3) only once we
+		 * call batch_write, if the FS supports it.
+		 */
+		if (a_ops->batch_write)
+			status = a_ops->batch_write(file, &desc, &lru_pvec,
+						    &cached_page, &copied);
+		else
+			status = generic_batch_write(file, &desc, &lru_pvec,
+						     &cached_page, &copied);
+		if (likely(copied > 0)) {
+			written += copied;
+			desc.count -= copied;
+			if (desc.count) {
+				/*
+				 * not everything is written yet. Adjust write
+				 * descriptor for next iteration
+				 */
+				desc.pos += copied;
+				if (unlikely(nr_segs > 1))
+					filemap_set_next_iovec(&desc.cur_iov,
+							       &desc.iov_off,
+							       copied);
+				else
+					desc.iov_off += copied;
+				desc.buf = desc.cur_iov->iov_base +
+					desc.iov_off;
+			}
+		}
 		if (status < 0)
 			break;
 		balance_dirty_pages_ratelimited(mapping);
 		cond_resched();
-	} while (count);
-	*ppos = pos;
+	} while (desc.count);	
+	*ppos = pos + written;
 
 	if (cached_page)
 		page_cache_release(cached_page);

_


--------------090901050004030106020409--
