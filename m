Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263320AbVGOMdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263320AbVGOMdF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 08:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbVGOMdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 08:33:05 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:24139 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S263314AbVGOMco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 08:32:44 -0400
Message-ID: <42D7AD4A.60105@tu-harburg.de>
Date: Fri, 15 Jul 2005 14:34:18 +0200
From: Jan Blunck <j.blunck@tu-harburg.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       joern@wohnheim.fh-wedel.de
Subject: Re: [PATCH] generic_file_sendpage (updated patch)
References: <42D79468.3050808@tu-harburg.de> <20050715040611.05907f4a.akpm@osdl.org>
In-Reply-To: <20050715040611.05907f4a.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------000708020900040805000809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000708020900040805000809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
 >
 >>+static inline size_t
 >>+filemap_copy_from_kernel(struct page *page, unsigned long offset,
 >>+			 const char *buf, unsigned bytes)
 >>+{
 >>+	char *kaddr;
 >>+
 >>+	kaddr = kmap(page);
 >>+	memcpy(kaddr + offset, buf, bytes);
 >>+	kunmap(page);
 >
 >
 > Use kmap_atomic().
 >
 > Move the flush_dcache_page() into here.
 >

Ok

 >>+
 >>+	/* There is no sane reason to use O_DIRECT */
 >>+	BUG_ON(file->f_flags & O_DIRECT);
 >
 >
 > err, this seems like an easy way for people to make the kernel go BUG.
 >

Hmm, yeah ... -EINVAL should do it.

 >
 >>+	if (unlikely(signal_pending(current)))
 >>+		return -EINTR;
 >
 >
 > This doesn't help.  The reason we've avoided file-to-file sendfile() is
 > that it can cause applications to get uninterruptibly stuck in the kernel
 > for ages.  This code doesn't solve that problem.  It needs to handle
 > signal_pending() inside the main loop.

The sendfile() mainloop is in generic_file_sendfile().
generic_file_sendpage() is called via the file_send_actor() from
do_generic_file_read(). Therefore generic_file_sendpage() is called for
every page which is written to the file. Since signals are checked
before every page this is solving the uninterruptible problem. IMHO, the
sendpage() should not be interrupted in between a single page.

 >
 > And it probably needs to return a sane value (number of bytes copied)
 > rather than -EINTR.

The return value of sendfile() is not the same as the return value of
sendpage(). This is done in file_send_actor().

 >
 > I don't know if we want to add this feature, really.  It's such a
 > specialised thing.

This issue comes up every now and than. I know of at least two users: 
COW links and my union mounts. I think this solution is quite good. I 
tested it under qemu and it is working for me.

Jan

BTW: I'm out for the weekend now.


--------------000708020900040805000809
Content-Type: text/x-patch;
 name="generic_file_sendpage.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="generic_file_sendpage.diff"

Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
Signed-off-by: Jan Blunck <j.blunck@tu-harburg.de>

 fs/ext2/file.c     |    1 
 fs/ext3/file.c     |    1 
 include/linux/fs.h |    2 
 mm/filemap.c       |  172 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 176 insertions(+)

Index: linux-2.6/include/linux/fs.h
===================================================================
--- linux-2.6.orig/include/linux/fs.h
+++ linux-2.6/include/linux/fs.h
@@ -1502,6 +1502,8 @@ extern ssize_t do_sync_write(struct file
 ssize_t generic_file_write_nolock(struct file *file, const struct iovec *iov,
 				unsigned long nr_segs, loff_t *ppos);
 extern ssize_t generic_file_sendfile(struct file *, loff_t *, size_t, read_actor_t, void *);
+extern ssize_t generic_file_sendpage(struct file *, struct page *, int, size_t,
+				     loff_t *, int);
 extern void do_generic_mapping_read(struct address_space *mapping,
 				    struct file_ra_state *, struct file *,
 				    loff_t *, read_descriptor_t *, read_actor_t);
Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c
+++ linux-2.6/mm/filemap.c
@@ -1086,6 +1086,27 @@ int file_send_actor(read_descriptor_t * 
 	return written;
 }
 
+/*
+ * Simple generic file sendpage. Just write a kernel buffer to the file.
+ */
+static ssize_t
+__generic_kernel_file_write(struct file *, const char *, size_t, loff_t *);
+
+ssize_t generic_file_sendpage(struct file *file, struct page *page,
+			      int offset, size_t size, loff_t *ppos, int more)
+{
+	ssize_t ret;
+	char *kaddr;
+
+	kaddr = kmap(page);
+	ret = __generic_kernel_file_write(file, kaddr + offset, size, ppos);
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
@@ -1715,6 +1736,21 @@ int remove_suid(struct dentry *dentry)
 }
 EXPORT_SYMBOL(remove_suid);
 
+static inline size_t
+filemap_copy_from_kernel(struct page *page, unsigned long offset,
+			 const char *buf, unsigned bytes)
+{
+	char *kaddr;
+
+	kaddr = kmap_atomic(page, KM_USER0);
+	memcpy(kaddr + offset, buf, bytes);
+	kunmap_atomic(page, KM_USER0);
+
+	flush_dcache_page(page);
+
+	return bytes;
+}
+
 size_t
 __filemap_copy_from_user_iovec(char *vaddr, 
 			const struct iovec *iov, size_t base, size_t bytes)
@@ -1862,6 +1898,142 @@ generic_file_direct_write(struct kiocb *
 }
 EXPORT_SYMBOL(generic_file_direct_write);
 
+/*
+ * TODO:
+ * This largely tries to copy generic_file_aio_write_nolock(), although it
+ * doesn't have to be nearly as generic.  A real cleanup should either
+ * merge this into generic_file_aio_write_nolock() as well or keep it special
+ * and remove as much code as possible.
+ *
+ * Check for pending signals here. Otherwise return -EINTR early.
+ *
+ * No iov, no kiocb. If you think this is a problem, use the source ;)
+ */
+static ssize_t
+__generic_kernel_file_write(struct file *file, const char *buf,
+			    size_t count, loff_t *ppos)
+{
+	struct address_space * mapping = file->f_mapping;
+	struct address_space_operations *a_ops = mapping->a_ops;
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
+
+	/* There is no sane reason to use O_DIRECT */
+	if (file->f_flags & O_DIRECT)
+		return -EINVAL;
+
+	if (unlikely(signal_pending(current)))
+		return -EINTR;
+
+	if (unlikely(count < 0))
+		return -EINVAL;
+
+	down(&inode->i_sem);
+
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
+	if (count == 0)
+		goto out;
+
+	remove_suid(file->f_dentry);
+	inode_update_time(inode, 1);
+
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
+		copied = filemap_copy_from_kernel(page, offset, buf, bytes);
+
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
+
+	up(&inode->i_sem);
+	return err;
+}
+
 ssize_t
 generic_file_buffered_write(struct kiocb *iocb, const struct iovec *iov,
 		unsigned long nr_segs, loff_t pos, loff_t *ppos,
Index: linux-2.6/fs/ext2/file.c
===================================================================
--- linux-2.6.orig/fs/ext2/file.c
+++ linux-2.6/fs/ext2/file.c
@@ -53,6 +53,7 @@ struct file_operations ext2_file_operati
 	.readv		= generic_file_readv,
 	.writev		= generic_file_writev,
 	.sendfile	= generic_file_sendfile,
+	.sendpage	= generic_file_sendpage,
 };
 
 #ifdef CONFIG_EXT2_FS_XIP
Index: linux-2.6/fs/ext3/file.c
===================================================================
--- linux-2.6.orig/fs/ext3/file.c
+++ linux-2.6/fs/ext3/file.c
@@ -119,6 +119,7 @@ struct file_operations ext3_file_operati
 	.release	= ext3_release_file,
 	.fsync		= ext3_sync_file,
 	.sendfile	= generic_file_sendfile,
+	.sendpage	= generic_file_sendpage,
 };
 
 struct inode_operations ext3_file_inode_operations = {

--------------000708020900040805000809--
