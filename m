Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265238AbSKFA6P>; Tue, 5 Nov 2002 19:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265247AbSKFA6P>; Tue, 5 Nov 2002 19:58:15 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:33961 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265238AbSKFA6E>;
	Tue, 5 Nov 2002 19:58:04 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200211060101.gA611gE21063@eng2.beaverton.ibm.com>
Subject: [PATCH 1/2] 2.5.46 AIO support for raw/O_DIRECT
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org (lkml)
Date: Tue, 5 Nov 2002 17:01:42 -0800 (PST)
Cc: akpm@digeo.com, bcrl@redhat.com, pbadari@us.ibm.com (Badari Pulavarty)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is (part 1/2) 2.5.46 patch to support AIO for raw/O_DIRECT.

This patch adds the infrastructure only. It does not make
DIO code Async. (part 2/2 does). Here is summary of what this
patch does:

1) Adds generic_file_aio_write_nolock() and makes all other
   generic_file_*_write() to use it.

2) Modifies generic_file_direct_IO() and ->direct_IO() functions 
   to take "kiocb *" instead of "file *".

3) Renames generic_direct_IO() to blockdev_direct_IO().
	(Andrew's suggestion)

4) Moves generic_file_direct_IO() to mm/filemap.c
	(Andrew's suggestion)

5) Adds AIO read/write support for raw driver.

Any suggestions/comments ?

Thanks,
Badari

diff -Naur -X dontdiff linux-2.5.46/drivers/char/raw.c linux-2.5.46.aio/drivers/char/raw.c
--- linux-2.5.46/drivers/char/raw.c	Mon Nov  4 14:30:33 2002
+++ linux-2.5.46.aio/drivers/char/raw.c	Tue Nov  5 12:21:11 2002
@@ -213,9 +213,20 @@
 	return generic_file_write_nolock(file, &local_iov, 1, ppos);
 }
 
+static ssize_t raw_file_aio_write(struct kiocb *iocb, const char *buf,
+					size_t count, loff_t pos)
+{
+	struct iovec local_iov = { .iov_base = (void *)buf, .iov_len = count };
+
+	return generic_file_aio_write_nolock(iocb, &local_iov, 1, &iocb->ki_pos);
+}
+
+
 static struct file_operations raw_fops = {
 	.read	=	generic_file_read,
+	.aio_read = 	generic_file_aio_read,
 	.write	=	raw_file_write,
+	.aio_write = 	raw_file_aio_write,
 	.open	=	raw_open,
 	.release=	raw_release,
 	.ioctl	=	raw_ioctl,
diff -Naur -X dontdiff linux-2.5.46/fs/block_dev.c linux-2.5.46.aio/fs/block_dev.c
--- linux-2.5.46/fs/block_dev.c	Mon Nov  4 14:30:57 2002
+++ linux-2.5.46.aio/fs/block_dev.c	Tue Nov  5 12:21:11 2002
@@ -115,12 +115,13 @@
 }
 
 static int
-blkdev_direct_IO(int rw, struct file *file, const struct iovec *iov,
+blkdev_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov,
 			loff_t offset, unsigned long nr_segs)
 {
+	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_dentry->d_inode->i_mapping->host;
 
-	return generic_direct_IO(rw, inode, inode->i_bdev, iov, offset,
+	return blockdev_direct_IO(rw, iocb, inode, inode->i_bdev, iov, offset,
 				nr_segs, blkdev_get_blocks);
 }
 
diff -Naur -X dontdiff linux-2.5.46/fs/direct-io.c linux-2.5.46.aio/fs/direct-io.c
--- linux-2.5.46/fs/direct-io.c	Mon Nov  4 14:30:31 2002
+++ linux-2.5.46.aio/fs/direct-io.c	Tue Nov  5 12:21:11 2002
@@ -842,9 +842,9 @@
  * This is a library function for use by filesystem drivers.
  */
 int
-generic_direct_IO(int rw, struct inode *inode, struct block_device *bdev, 
-	const struct iovec *iov, loff_t offset, unsigned long nr_segs, 
-	get_blocks_t get_blocks)
+blockdev_direct_IO(int rw, struct kiocb *iocb, struct inode *inode, 
+	struct block_device *bdev, const struct iovec *iov, loff_t offset, 
+	unsigned long nr_segs, get_blocks_t get_blocks)
 {
 	int seg;
 	size_t size;
@@ -883,25 +883,3 @@
 out:
 	return retval;
 }
-
-ssize_t
-generic_file_direct_IO(int rw, struct file *file, const struct iovec *iov,
-	loff_t offset, unsigned long nr_segs)
-{
-	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
-	ssize_t retval;
-
-	if (mapping->nrpages) {
-		retval = filemap_fdatawrite(mapping);
-		if (retval == 0)
-			retval = filemap_fdatawait(mapping);
-		if (retval)
-			goto out;
-	}
-
-	retval = mapping->a_ops->direct_IO(rw, file, iov, offset, nr_segs);
-	if (rw == WRITE && mapping->nrpages)
-		invalidate_inode_pages2(mapping);
-out:
-	return retval;
-}
diff -Naur -X dontdiff linux-2.5.46/fs/ext2/inode.c linux-2.5.46.aio/fs/ext2/inode.c
--- linux-2.5.46/fs/ext2/inode.c	Mon Nov  4 14:30:06 2002
+++ linux-2.5.46.aio/fs/ext2/inode.c	Tue Nov  5 12:21:11 2002
@@ -630,12 +630,13 @@
 }
 
 static int
-ext2_direct_IO(int rw, struct file *file, const struct iovec *iov,
+ext2_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov,
 			loff_t offset, unsigned long nr_segs)
 {
+	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_dentry->d_inode->i_mapping->host;
 
-	return generic_direct_IO(rw, inode, inode->i_sb->s_bdev, iov,
+	return blockdev_direct_IO(rw, iocb, inode, inode->i_sb->s_bdev, iov,
 				offset, nr_segs, ext2_get_blocks);
 }
 
diff -Naur -X dontdiff linux-2.5.46/fs/ext3/inode.c linux-2.5.46.aio/fs/ext3/inode.c
--- linux-2.5.46/fs/ext3/inode.c	Mon Nov  4 14:30:36 2002
+++ linux-2.5.46.aio/fs/ext3/inode.c	Tue Nov  5 12:21:11 2002
@@ -1411,10 +1411,11 @@
  * If the O_DIRECT write is intantiating holes inside i_size and the machine
  * crashes then stale disk data _may_ be exposed inside the file.
  */
-static int ext3_direct_IO(int rw, struct file *file,
+static int ext3_direct_IO(int rw, struct kiocb *iocb,
 			const struct iovec *iov, loff_t offset,
 			unsigned long nr_segs)
 {
+	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_dentry->d_inode->i_mapping->host;
 	struct ext3_inode_info *ei = EXT3_I(inode);
 	handle_t *handle = NULL;
@@ -1443,8 +1444,8 @@
 		}
 	}
 
-	ret = generic_direct_IO(rw, inode, inode->i_sb->s_bdev, iov, offset,
-				nr_segs, ext3_direct_io_get_blocks);
+	ret = blockdev_direct_IO(rw, iocb, inode, inode->i_sb->s_bdev, iov, 
+				offset, nr_segs, ext3_direct_io_get_blocks);
 
 out_stop:
 	if (handle) {
diff -Naur -X dontdiff linux-2.5.46/fs/jfs/inode.c linux-2.5.46.aio/fs/jfs/inode.c
--- linux-2.5.46/fs/jfs/inode.c	Mon Nov  4 14:30:03 2002
+++ linux-2.5.46.aio/fs/jfs/inode.c	Tue Nov  5 12:21:11 2002
@@ -310,12 +310,13 @@
 	return generic_block_bmap(mapping, block, jfs_get_block);
 }
 
-static int jfs_direct_IO(int rw, struct file *file, const struct iovec *iov,
+static int jfs_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov,
 			loff_t offset, unsigned long nr_segs)
 {
+	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_dentry->d_inode->i_mapping->host;
 
-	return generic_direct_IO(rw, inode, inode->i_sb->s_bdev, iov,
+	return blockdev_direct_IO(rw, iocb, inode, inode->i_sb->s_bdev, iov,
 				offset, nr_segs, jfs_get_blocks);
 }
 
diff -Naur -X dontdiff linux-2.5.46/fs/xfs/linux/xfs_aops.c linux-2.5.46.aio/fs/xfs/linux/xfs_aops.c
--- linux-2.5.46/fs/xfs/linux/xfs_aops.c	Mon Nov  4 14:30:50 2002
+++ linux-2.5.46.aio/fs/xfs/linux/xfs_aops.c	Tue Nov  5 12:21:11 2002
@@ -600,14 +600,15 @@
 STATIC int
 linvfs_direct_IO(
 	int			rw,
-	struct file		*file,
+	struct kiocb		*iocb,
 	const struct iovec	*iov,
 	loff_t			offset,
 	unsigned long		nr_segs)
 {
+	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_dentry->d_inode->i_mapping->host;
 
-        return generic_direct_IO(rw, inode, NULL,
+        return blockdev_direct_IO(rw, iocb, inode, NULL,
 			iov, offset, nr_segs, linvfs_get_blocks_direct);
 }
 
diff -Naur -X dontdiff linux-2.5.46/include/linux/fs.h linux-2.5.46.aio/include/linux/fs.h
--- linux-2.5.46/include/linux/fs.h	Mon Nov  4 14:30:15 2002
+++ linux-2.5.46.aio/include/linux/fs.h	Tue Nov  5 12:21:11 2002
@@ -282,6 +282,7 @@
 struct page;
 struct address_space;
 struct writeback_control;
+struct kiocb;
 
 struct address_space_operations {
 	int (*writepage)(struct page *);
@@ -310,7 +311,7 @@
 	sector_t (*bmap)(struct address_space *, sector_t);
 	int (*invalidatepage) (struct page *, unsigned long);
 	int (*releasepage) (struct page *, int);
-	int (*direct_IO)(int, struct file *, const struct iovec *iov,
+	int (*direct_IO)(int, struct kiocb *, const struct iovec *iov,
 			loff_t offset, unsigned long nr_segs);
 };
 
@@ -740,7 +741,6 @@
  * read, write, poll, fsync, readv, writev can be called
  *   without the big kernel lock held in all filesystems.
  */
-struct kiocb;
 struct file_operations {
 	struct module *owner;
 	loff_t (*llseek) (struct file *, loff_t, int);
@@ -1250,6 +1250,8 @@
 extern ssize_t generic_file_write(struct file *, const char *, size_t, loff_t *);
 extern ssize_t generic_file_aio_read(struct kiocb *, char *, size_t, loff_t);
 extern ssize_t generic_file_aio_write(struct kiocb *, const char *, size_t, loff_t);
+extern ssize_t generic_file_aio_write_nolock(struct kiocb *, const struct iovec *,
+				unsigned long, loff_t *);
 extern ssize_t do_sync_read(struct file *filp, char *buf, size_t len, loff_t *ppos);
 extern ssize_t do_sync_write(struct file *filp, const char *buf, size_t len, loff_t *ppos);
 ssize_t generic_file_write_nolock(struct file *file, const struct iovec *iov,
@@ -1259,10 +1261,11 @@
 				    loff_t *, read_descriptor_t *, read_actor_t);
 extern void
 file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping);
-extern ssize_t generic_file_direct_IO(int rw, struct file *file,
+extern ssize_t generic_file_direct_IO(int rw, struct kiocb *iocb,
 	const struct iovec *iov, loff_t offset, unsigned long nr_segs);
-extern int generic_direct_IO(int rw, struct inode *inode, struct block_device *bdev,
-	const struct iovec *iov, loff_t offset, unsigned long nr_segs, get_blocks_t *get_blocks);
+extern int blockdev_direct_IO(int rw, struct kiocb *iocb, struct inode *inode, 
+	struct block_device *bdev, const struct iovec *iov, loff_t offset, 
+	unsigned long nr_segs, get_blocks_t *get_blocks);
 extern ssize_t generic_file_readv(struct file *filp, const struct iovec *iov, 
 	unsigned long nr_segs, loff_t *ppos);
 ssize_t generic_file_writev(struct file *filp, const struct iovec *iov, 
diff -Naur -X dontdiff linux-2.5.46/kernel/ksyms.c linux-2.5.46.aio/kernel/ksyms.c
--- linux-2.5.46/kernel/ksyms.c	Mon Nov  4 14:30:04 2002
+++ linux-2.5.46.aio/kernel/ksyms.c	Tue Nov  5 12:21:11 2002
@@ -215,7 +215,7 @@
 EXPORT_SYMBOL(submit_bh);
 EXPORT_SYMBOL(unlock_buffer);
 EXPORT_SYMBOL(__wait_on_buffer);
-EXPORT_SYMBOL(generic_direct_IO);
+EXPORT_SYMBOL(blockdev_direct_IO);
 EXPORT_SYMBOL(block_write_full_page);
 EXPORT_SYMBOL(block_read_full_page);
 EXPORT_SYMBOL(block_prepare_write);
diff -Naur -X dontdiff linux-2.5.46/mm/filemap.c linux-2.5.46.aio/mm/filemap.c
--- linux-2.5.46/mm/filemap.c	Mon Nov  4 14:30:18 2002
+++ linux-2.5.46.aio/mm/filemap.c	Tue Nov  5 12:21:11 2002
@@ -812,7 +812,7 @@
 				nr_segs = iov_shorten((struct iovec *)iov,
 							nr_segs, count);
 			}
-			retval = generic_file_direct_IO(READ, filp,
+			retval = generic_file_direct_IO(READ, iocb,
 					iov, pos, nr_segs);
 			if (retval > 0)
 				*ppos = pos + retval;
@@ -1539,9 +1539,10 @@
  *							okir@monad.swb.de
  */
 ssize_t
-generic_file_write_nolock(struct file *file, const struct iovec *iov,
+generic_file_aio_write_nolock(struct kiocb *iocb, const struct iovec *iov,
 				unsigned long nr_segs, loff_t *ppos)
 {
+	struct file *file = iocb->ki_filp;
 	struct address_space * mapping = file->f_dentry->d_inode->i_mapping;
 	struct address_space_operations *a_ops = mapping->a_ops;
 	size_t ocount;		/* original count */
@@ -1686,7 +1687,7 @@
 		if (count != ocount)
 			nr_segs = iov_shorten((struct iovec *)iov,
 						nr_segs, count);
-		written = generic_file_direct_IO(WRITE, file,
+		written = generic_file_direct_IO(WRITE, iocb,
 					iov, pos, nr_segs);
 		if (written > 0) {
 			loff_t end = pos + written;
@@ -1797,12 +1798,39 @@
 	return err;
 }
 
+ssize_t
+generic_file_write_nolock(struct file *file, const struct iovec *iov,
+				unsigned long nr_segs, loff_t *ppos)
+{
+	struct kiocb kiocb;
+	ssize_t ret;
+
+	init_sync_kiocb(&kiocb, file);
+	ret = generic_file_aio_write_nolock(&kiocb, iov, nr_segs, ppos);
+	if (-EIOCBQUEUED == ret)
+		ret = wait_on_sync_kiocb(&kiocb);
+	return ret;
+}
+
 ssize_t generic_file_aio_write(struct kiocb *iocb, const char *buf,
 			       size_t count, loff_t pos)
 {
-	return generic_file_write(iocb->ki_filp, buf, count, &iocb->ki_pos);
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file->f_dentry->d_inode->i_mapping->host;
+	int err;
+	struct iovec local_iov = { .iov_base = (void *)buf, .iov_len = count };
+
+	BUG_ON(iocb->ki_pos != pos);
+
+	down(&inode->i_sem);
+	err = generic_file_aio_write_nolock(iocb, &local_iov, 1, 
+						&iocb->ki_pos);
+	up(&inode->i_sem);
+
+	return err;
 }
 EXPORT_SYMBOL(generic_file_aio_write);
+EXPORT_SYMBOL(generic_file_aio_write_nolock);
 
 ssize_t generic_file_write(struct file *file, const char *buf,
 			   size_t count, loff_t *ppos)
@@ -1842,3 +1870,26 @@
 	up(&inode->i_sem);
 	return ret;
 }
+
+ssize_t
+generic_file_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov,
+	loff_t offset, unsigned long nr_segs)
+{
+	struct file *file = iocb->ki_filp;
+	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
+	ssize_t retval;
+
+	if (mapping->nrpages) {
+		retval = filemap_fdatawrite(mapping);
+		if (retval == 0)
+			retval = filemap_fdatawait(mapping);
+		if (retval)
+			goto out;
+	}
+
+	retval = mapping->a_ops->direct_IO(rw, iocb, iov, offset, nr_segs);
+	if (rw == WRITE && mapping->nrpages)
+		invalidate_inode_pages2(mapping);
+out:
+	return retval;
+}



