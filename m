Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264346AbUIDQ55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbUIDQ55 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 12:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbUIDQ55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 12:57:57 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:30660 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264346AbUIDQ5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 12:57:42 -0400
Date: Sat, 4 Sep 2004 18:57:33 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] copyfile: generic_sendpage
Message-ID: <20040904165733.GC8579@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

looks like there are four independent groups interested in these
ground-laying patches for cowlinks:
o me (of course)
o vserver - they want cowlinks as well
o cifs - to optimize sys_copyfile() and reduce network transfers
o unionmount - you might remember Jan Blunck's fix to ext3

So I am, ready to accept my deserved beating and do the necessary
cleanups.

Jörn

-- 
Don't worry about people stealing your ideas. If your ideas are any good,
you'll have to ram them down people's throats.
-- Howard Aiken quoted by Ken Iverson quoted by Jim Horning quoted by
   Raph Levien, 1979


o Add sendfile() support for file targets to normal mm/filemap.c.
o Have ext[23] use that support.

 fs/ext2/file.c     |    1 
 fs/ext3/file.c     |    1 
 include/linux/fs.h |    1 
 mm/filemap.c       |  216 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 219 insertions(+)


--- linux-2.6.5cow/include/linux/fs.h~generic_sendpage	2004-05-06 10:04:00.000000000 +0200
+++ linux-2.6.5cow/include/linux/fs.h	2004-05-14 18:30:50.000000000 +0200
@@ -1332,6 +1332,7 @@
 ssize_t generic_file_write_nolock(struct file *file, const struct iovec *iov,
 				unsigned long nr_segs, loff_t *ppos);
 extern ssize_t generic_file_sendfile(struct file *, loff_t *, size_t, read_actor_t, void *);
+extern ssize_t generic_file_sendpage(struct file *, struct page *, int, size_t, loff_t *, int);
 extern void do_generic_mapping_read(struct address_space *mapping,
 				    struct file_ra_state *, struct file *,
 				    loff_t *, read_descriptor_t *, read_actor_t);
--- linux-2.6.5cow/mm/filemap.c~generic_sendpage	2004-05-06 10:03:59.000000000 +0200
+++ linux-2.6.5cow/mm/filemap.c	2004-05-06 10:04:33.000000000 +0200
@@ -896,6 +896,31 @@
 	return written;
 }
 
+/* FIXME: It would be as simple as this, if we had a (void __user*) to write.
+ * We already have a kernel buffer, so it should be even simpler, right? ;)
+ *
+ * Yes, sorta.  After duplicating the complete path of generic_file_write(),
+ * at least some special cases could be removed, so the copy is simpler than
+ * the original.  But it remains a copy, so overall complexity increases.
+ */
+static ssize_t
+generic_kernel_file_write(struct file *, const char *, size_t, loff_t *);
+
+ssize_t generic_file_sendpage(struct file *file, struct page *page,
+		int offset, size_t size, loff_t *ppos, int more)
+{
+	ssize_t ret;
+	char *kaddr;
+
+	kaddr = kmap(page);
+	ret = generic_kernel_file_write(file, kaddr + offset, size, ppos);
+	kunmap(page);
+
+	return ret;
+}
+
+EXPORT_SYMBOL(generic_file_sendpage);
+
 ssize_t generic_file_sendfile(struct file *in_file, loff_t *ppos,
 			 size_t count, read_actor_t actor, void *target)
 {
@@ -1554,6 +1579,19 @@
 	return bytes - left;
 }
 
+static inline size_t
+filemap_copy_from_kernel(struct page *page, unsigned long offset,
+			 const char *buf, unsigned bytes)
+{
+	char *kaddr;
+
+	kaddr = kmap(page);
+	memcpy(kaddr + offset, buf, bytes);
+	kunmap(page);
+
+	return bytes;
+}
+
 static size_t
 __filemap_copy_from_user_iovec(char *vaddr, 
 			const struct iovec *iov, size_t base, size_t bytes)
@@ -1910,6 +1948,155 @@
 
 EXPORT_SYMBOL(generic_file_aio_write_nolock);
 
+/*
+ * TODO:
+ * This largely tries to copy generic_file_aio_write_nolock(), although it
+ * doesn't have to be nearly as generic.  A real cleanup should either
+ * merge this into generic_file_aio_write_nolock() as well or keep it special
+ * and remove as much code as possible.
+ */
+static ssize_t
+generic_kernel_file_aio_write_nolock(struct kiocb *iocb, const struct iovec*iov,
+				     unsigned long nr_segs, loff_t *ppos)
+{
+	struct file *file = iocb->ki_filp;
+	struct address_space * mapping = file->f_mapping;
+	struct address_space_operations *a_ops = mapping->a_ops;
+	size_t ocount;		/* original count */
+	size_t count;		/* after file limit checks */
+	struct inode 	*inode = mapping->host;
+	long		status = 0;
+	loff_t		pos;
+	struct page	*page;
+	struct page	*cached_page = NULL;
+	const int	isblk = S_ISBLK(inode->i_mode);
+	ssize_t		written;
+	ssize_t		err;
+	size_t		bytes;
+	struct pagevec	lru_pvec;
+	const struct iovec *cur_iov = iov; /* current iovec */
+	size_t		iov_base = 0;	   /* offset in the current iovec */
+	unsigned long	seg;
+	char		*buf;
+
+	ocount = 0;
+	for (seg = 0; seg < nr_segs; seg++) {
+		const struct iovec *iv = &iov[seg];
+
+		/*
+		 * If any segment has a negative length, or the cumulative
+		 * length ever wraps negative then return -EINVAL.
+		 */
+		ocount += iv->iov_len;
+		if (unlikely((ssize_t)(ocount|iv->iov_len) < 0))
+			return -EINVAL;
+	}
+
+	count = ocount;
+	pos = *ppos;
+	pagevec_init(&lru_pvec, 0);
+
+	/* We can write back this queue in page reclaim */
+	current->backing_dev_info = mapping->backing_dev_info;
+	written = 0;
+
+	err = generic_write_checks(file, &pos, &count, isblk);
+	if (err)
+		goto out;
+
+
+	if (count == 0)
+		goto out;
+
+	remove_suid(file->f_dentry);
+	inode_update_time(inode, 1);
+
+	/* There is no sane reason to use O_DIRECT */
+	BUG_ON(file->f_flags & O_DIRECT);
+
+	buf = (char *)iov->iov_base;
+	do {
+		unsigned long index;
+		unsigned long offset;
+		size_t copied;
+
+		offset = (pos & (PAGE_CACHE_SIZE -1)); /* Within page */
+		index = pos >> PAGE_CACHE_SHIFT;
+		bytes = PAGE_CACHE_SIZE - offset;
+		if (bytes > count)
+			bytes = count;
+
+		page = __grab_cache_page(mapping,index,&cached_page,&lru_pvec);
+		if (!page) {
+			status = -ENOMEM;
+			break;
+		}
+
+		status = a_ops->prepare_write(file, page, offset, offset+bytes);
+		if (unlikely(status)) {
+			loff_t isize = i_size_read(inode);
+			/*
+			 * prepare_write() may have instantiated a few blocks
+			 * outside i_size.  Trim these off again.
+			 */
+			unlock_page(page);
+			page_cache_release(page);
+			if (pos + bytes > isize)
+				vmtruncate(inode, isize);
+			break;
+		}
+
+		BUG_ON(nr_segs != 1);
+		copied = filemap_copy_from_kernel(page, offset, buf, bytes);
+
+		flush_dcache_page(page);
+		status = a_ops->commit_write(file, page, offset, offset+bytes);
+		if (likely(copied > 0)) {
+			if (!status)
+				status = copied;
+
+			if (status >= 0) {
+				written += status;
+				count -= status;
+				pos += status;
+				buf += status;
+				if (unlikely(nr_segs > 1))
+					filemap_set_next_iovec(&cur_iov,
+							&iov_base, status);
+			}
+		}
+		if (unlikely(copied != bytes))
+			if (status >= 0)
+				status = -EFAULT;
+		unlock_page(page);
+		mark_page_accessed(page);
+		page_cache_release(page);
+		if (status < 0)
+			break;
+		balance_dirty_pages_ratelimited(mapping);
+		cond_resched();
+	} while (count);
+	*ppos = pos;
+
+	if (cached_page)
+		page_cache_release(cached_page);
+
+	/*
+	 * For now, when the user asks for O_SYNC, we'll actually give O_DSYNC
+	 */
+	if (status >= 0) {
+		if ((file->f_flags & O_SYNC) || IS_SYNC(inode))
+			status = generic_osync_inode(inode, mapping,
+					OSYNC_METADATA|OSYNC_DATA);
+	}
+	
+	err = written ? written : status;
+out:
+	pagevec_lru_add(&lru_pvec);
+	current->backing_dev_info = 0;
+	return err;
+}
+
 ssize_t
 generic_file_write_nolock(struct file *file, const struct iovec *iov,
 				unsigned long nr_segs, loff_t *ppos)
@@ -1924,6 +2111,20 @@
 	return ret;
 }
 
+static ssize_t
+generic_kernel_file_write_nolock(struct file *file, const struct iovec *iov,
+				 unsigned long nr_segs, loff_t *ppos)
+{
+	struct kiocb kiocb;
+	ssize_t ret;
+
+	init_sync_kiocb(&kiocb, file);
+	ret = generic_kernel_file_aio_write_nolock(&kiocb, iov, nr_segs, ppos);
+	if (ret == -EIOCBQUEUED)
+		ret = wait_on_sync_kiocb(&kiocb);
+	return ret;
+}
+
 EXPORT_SYMBOL(generic_file_write_nolock);
 
 ssize_t generic_file_aio_write(struct kiocb *iocb, const char __user *buf,
@@ -1962,6 +2163,21 @@
 }
 EXPORT_SYMBOL(generic_file_write);
 
+static ssize_t generic_kernel_file_write(struct file *file, const char *buf,
+					 size_t count, loff_t *ppos)
+{
+	struct inode	*inode = file->f_mapping->host;
+	ssize_t		err;
+	struct iovec local_iov = {.iov_base = (void __user *)buf,
+				  .iov_len = count };
+
+	down(&inode->i_sem);
+	err = generic_kernel_file_write_nolock(file, &local_iov, 1, ppos);
+	up(&inode->i_sem);
+
+	return err;
+}
+
 ssize_t generic_file_readv(struct file *filp, const struct iovec *iov,
 			unsigned long nr_segs, loff_t *ppos)
 {
--- linux-2.6.5cow/fs/ext2/file.c~generic_sendpage	2004-05-06 10:03:59.000000000 +0200
+++ linux-2.6.5cow/fs/ext2/file.c	2004-05-06 10:04:33.000000000 +0200
@@ -53,6 +53,7 @@
 	.readv		= generic_file_readv,
 	.writev		= generic_file_writev,
 	.sendfile	= generic_file_sendfile,
+	.sendpage	= generic_file_sendpage,
 };
 
 struct inode_operations ext2_file_inode_operations = {
--- linux-2.6.5cow/fs/ext3/file.c~generic_sendpage	2004-05-06 10:03:59.000000000 +0200
+++ linux-2.6.5cow/fs/ext3/file.c	2004-05-06 10:04:33.000000000 +0200
@@ -127,6 +127,7 @@
 	.release	= ext3_release_file,
 	.fsync		= ext3_sync_file,
 	.sendfile	= generic_file_sendfile,
+	.sendpage	= generic_file_sendpage,
 };
 
 struct inode_operations ext3_file_inode_operations = {
