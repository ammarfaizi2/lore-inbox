Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316431AbSEZUqU>; Sun, 26 May 2002 16:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316430AbSEZUpb>; Sun, 26 May 2002 16:45:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54544 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316388AbSEZUoB>;
	Sun, 26 May 2002 16:44:01 -0400
Message-ID: <3CF149CD.F0E36D69@zip.com.au>
Date: Sun, 26 May 2002 13:47:09 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 13/18] generic_file_write() cleanup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Fixes all the goto spaghetti in generic_file_write() and turns it into
something which humans can understand.

Andi tells me that gcc3 does a decent job of relocating blocks out of
line anyway.  This patch gives the compiler a helping hand with
appropriate use of likely() and unlikely().


=====================================

--- 2.5.18/mm/filemap.c~generic_file_write_cleanup	Sat May 25 23:25:49 2002
+++ 2.5.18-akpm/mm/filemap.c	Sat May 25 23:26:25 2002
@@ -2074,48 +2074,43 @@ inline void remove_suid(struct dentry *d
 /*
  * Write to a file through the page cache. 
  *
- * We currently put everything into the page cache prior to writing it.
- * This is not a problem when writing full pages. With partial pages,
- * however, we first have to read the data into the cache, then
- * dirty the page, and finally schedule it for writing. Alternatively, we
- * could write-through just the portion of data that would go into that
- * page, but that would kill performance for applications that write data
- * line by line, and it's prone to race conditions.
- *
- * Note that this routine doesn't try to keep track of dirty pages. Each
- * file system has to do this all by itself, unfortunately.
+ * We put everything into the page cache prior to writing it. This is not a
+ * problem when writing full pages. With partial pages, however, we first have
+ * to read the data into the cache, then dirty the page, and finally schedule
+ * it for writing by marking it dirty.
  *							okir@monad.swb.de
  */
 ssize_t
-generic_file_write(struct file *file,const char *buf,size_t count, loff_t *ppos)
+generic_file_write(struct file *file, const char *buf,
+		size_t count, loff_t *ppos)
 {
-	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
-	struct inode	*inode = mapping->host;
+	struct address_space * mapping = file->f_dentry->d_inode->i_mapping;
+	struct address_space_operations *a_ops = mapping->a_ops;
+	struct inode 	*inode = mapping->host;
 	unsigned long	limit = current->rlim[RLIMIT_FSIZE].rlim_cur;
+	long		status = 0;
 	loff_t		pos;
-	struct page	*page, *cached_page;
+	struct page	*page;
+	struct page	*cached_page = NULL;
 	ssize_t		written;
-	long		status = 0;
 	int		err;
 	unsigned	bytes;
 
-	if ((ssize_t) count < 0)
+	if (unlikely((ssize_t) count < 0))
 		return -EINVAL;
 
-	if (!access_ok(VERIFY_READ, buf, count))
+	if (unlikely(!access_ok(VERIFY_READ, buf, count)))
 		return -EFAULT;
 
-	cached_page = NULL;
-
 	down(&inode->i_sem);
-
 	pos = *ppos;
-	err = -EINVAL;
-	if (pos < 0)
+	if (unlikely(pos < 0)) {
+		err = -EINVAL;
 		goto out;
+	}
 
-	err = file->f_error;
-	if (err) {
+	if (unlikely(file->f_error)) {
+		err = file->f_error;
 		file->f_error = 0;
 		goto out;
 	}
@@ -2129,11 +2124,10 @@ generic_file_write(struct file *file,con
 	/*
 	 * Check whether we've reached the file size limit.
 	 */
-	err = -EFBIG;
-	
-	if (limit != RLIM_INFINITY) {
+	if (unlikely(limit != RLIM_INFINITY)) {
 		if (pos >= limit) {
 			send_sig(SIGXFSZ, current, 0);
+			err = -EFBIG;
 			goto out;
 		}
 		if (pos > 0xFFFFFFFFULL || count > limit - (u32)pos) {
@@ -2143,11 +2137,13 @@ generic_file_write(struct file *file,con
 	}
 
 	/*
-	 *	LFS rule 
+	 * LFS rule
 	 */
-	if ( pos + count > MAX_NON_LFS && !(file->f_flags&O_LARGEFILE)) {
+	if (unlikely(pos + count > MAX_NON_LFS &&
+				!(file->f_flags & O_LARGEFILE))) {
 		if (pos >= MAX_NON_LFS) {
 			send_sig(SIGXFSZ, current, 0);
+			err = -EFBIG;
 			goto out;
 		}
 		if (count > MAX_NON_LFS - (u32)pos) {
@@ -2157,18 +2153,14 @@ generic_file_write(struct file *file,con
 	}
 
 	/*
-	 *	Are we about to exceed the fs block limit ?
-	 *
-	 *	If we have written data it becomes a short write
-	 *	If we have exceeded without writing data we send
-	 *	a signal and give them an EFBIG.
+	 * Are we about to exceed the fs block limit ?
 	 *
-	 *	Linus frestrict idea will clean these up nicely..
+	 * If we have written data it becomes a short write.  If we have
+	 * exceeded without writing data we send a signal and return EFBIG.
+	 * Linus frestrict idea will clean these up nicely..
 	 */
-	 
-	if (!S_ISBLK(inode->i_mode)) {
-		if (pos >= inode->i_sb->s_maxbytes)
-		{
+	if (likely(!S_ISBLK(inode->i_mode))) {
+		if (unlikely(pos >= inode->i_sb->s_maxbytes)) {
 			if (count || pos > inode->i_sb->s_maxbytes) {
 				send_sig(SIGXFSZ, current, 0);
 				err = -EFBIG;
@@ -2177,7 +2169,7 @@ generic_file_write(struct file *file,con
 			/* zero-length writes at ->s_maxbytes are OK */
 		}
 
-		if (pos + count > inode->i_sb->s_maxbytes)
+		if (unlikely(pos + count > inode->i_sb->s_maxbytes))
 			count = inode->i_sb->s_maxbytes - pos;
 	} else {
 		if (is_read_only(inode->i_rdev)) {
@@ -2200,21 +2192,37 @@ generic_file_write(struct file *file,con
 		goto out;
 
 	remove_suid(file->f_dentry);
-	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+	inode->i_ctime = CURRENT_TIME;
+	inode->i_mtime = CURRENT_TIME;
 	mark_inode_dirty_sync(inode);
 
-	if (file->f_flags & O_DIRECT)
-		goto o_direct;
+	if (unlikely(file->f_flags & O_DIRECT)) {
+		written = generic_file_direct_IO(WRITE, file,
+						(char *) buf, count, pos);
+		if (written > 0) {
+			loff_t end = pos + written;
+			if (end > inode->i_size && !S_ISBLK(inode->i_mode)) {
+				inode->i_size = end;
+				mark_inode_dirty(inode);
+			}
+			*ppos = end;
+			invalidate_inode_pages2(mapping);
+		}
+		/*
+		 * Sync the fs metadata but not the minor inode changes and
+		 * of course not the data as we did direct DMA for the IO.
+		 */
+		if (written >= 0 && file->f_flags & O_SYNC)
+			status = generic_osync_inode(inode, OSYNC_METADATA);
+		goto out_status;
+	}
 
 	do {
-		unsigned long index, offset;
+		unsigned long index;
+		unsigned long offset;
 		long page_fault;
 		char *kaddr;
 
-		/*
-		 * Try to find the page in the cache. If it isn't there,
-		 * allocate a free page.
-		 */
 		offset = (pos & (PAGE_CACHE_SIZE -1)); /* Within page */
 		index = pos >> PAGE_CACHE_SHIFT;
 		bytes = PAGE_CACHE_SIZE - offset;
@@ -2232,96 +2240,67 @@ generic_file_write(struct file *file,con
 			__get_user(dummy, buf+bytes-1);
 		}
 
-		status = -ENOMEM;	/* we'll assign it later anyway */
 		page = __grab_cache_page(mapping, index, &cached_page);
-		if (!page)
+		if (!page) {
+			status = -ENOMEM;
 			break;
-
-		/* We have exclusive IO access to the page.. */
-		if (!PageLocked(page)) {
-			PAGE_BUG(page);
 		}
 
 		kaddr = kmap(page);
-		status = mapping->a_ops->prepare_write(file, page, offset, offset+bytes);
-		if (status)
-			goto sync_failure;
-		page_fault = __copy_from_user(kaddr+offset, buf, bytes);
+		status = a_ops->prepare_write(file, page, offset, offset+bytes);
+		if (unlikely(status)) {
+			/*
+			 * prepare_write() may have instantiated a few blocks
+			 * outside i_size.  Trim these off again.
+			 */
+			kunmap(page);
+			unlock_page(page);
+			page_cache_release(page);
+			if (pos + bytes > inode->i_size)
+				vmtruncate(inode, inode->i_size);
+			break;
+		}
+		page_fault = __copy_from_user(kaddr + offset, buf, bytes);
 		flush_dcache_page(page);
-		status = mapping->a_ops->commit_write(file, page, offset, offset+bytes);
-		if (page_fault)
-			goto fail_write;
-		if (!status)
-			status = bytes;
-
-		if (status >= 0) {
-			written += status;
-			count -= status;
-			pos += status;
-			buf += status;
+		status = a_ops->commit_write(file, page, offset, offset+bytes);
+		if (unlikely(page_fault)) {
+			status = -EFAULT;
+		} else {
+			if (!status)
+				status = bytes;
+
+			if (status >= 0) {
+				written += status;
+				count -= status;
+				pos += status;
+				buf += status;
+			}
 		}
-unlock:
 		kunmap(page);
-		/* Mark it unlocked again and drop the page.. */
 		SetPageReferenced(page);
 		unlock_page(page);
 		page_cache_release(page);
-
 		if (status < 0)
 			break;
 		balance_dirty_pages_ratelimited(mapping);
 	} while (count);
-done:
 	*ppos = pos;
 
 	if (cached_page)
 		page_cache_release(cached_page);
 
-	/* For now, when the user asks for O_SYNC, we'll actually
-	 * provide O_DSYNC. */
+	/*
+	 * For now, when the user asks for O_SYNC, we'll actually give O_DSYNC
+	 */
 	if (status >= 0) {
 		if ((file->f_flags & O_SYNC) || IS_SYNC(inode))
-			status = generic_osync_inode(inode, OSYNC_METADATA|OSYNC_DATA);
+			status = generic_osync_inode(inode,
+					OSYNC_METADATA|OSYNC_DATA);
 	}
 	
 out_status:	
 	err = written ? written : status;
 out:
-
 	up(&inode->i_sem);
 	return err;
-fail_write:
-	status = -EFAULT;
-	goto unlock;
-
-sync_failure:
-	/*
-	 * If blocksize < pagesize, prepare_write() may have instantiated a
-	 * few blocks outside i_size.  Trim these off again.
-	 */
-	kunmap(page);
-	unlock_page(page);
-	page_cache_release(page);
-	if (pos + bytes > inode->i_size)
-		vmtruncate(inode, inode->i_size);
-	goto done;
-
-o_direct:
-	written = generic_file_direct_IO(WRITE, file, (char *) buf, count, pos);
-	if (written > 0) {
-		loff_t end = pos + written;
-		if (end > inode->i_size && !S_ISBLK(inode->i_mode)) {
-			inode->i_size = end;
-			mark_inode_dirty(inode);
-		}
-		*ppos = end;
-		invalidate_inode_pages2(mapping);
-	}
-	/*
-	 * Sync the fs metadata but not the minor inode changes and
-	 * of course not the data as we did direct DMA for the IO.
-	 */
-	if (written >= 0 && file->f_flags & O_SYNC)
-		status = generic_osync_inode(inode, OSYNC_METADATA);
-	goto out_status;
 }


-
