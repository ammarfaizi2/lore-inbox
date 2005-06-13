Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVFMPKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVFMPKq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 11:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVFMPKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 11:10:37 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:64214 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261592AbVFMPHc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 11:07:32 -0400
Subject: [RFC/PATCH -mm] execute in place: reduce code duplication
From: Carsten Otte <cotte@de.ibm.com>
Reply-To: cotte@freenet.de
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, hch@infradead.org,
       suparna@in.ibm.com
Content-Type: text/plain
Organization: IBM Deutschland Entwicklung
Date: Mon, 13 Jun 2005 17:07:27 +0200
Message-Id: <1118675248.2402.9.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[RFC/PATCH -mm] execute in place: reduce code duplication
This patch reworks filemap_xip.c with the goal to reduce code
duplication from mm/filemap.c. It applies agains 2.6.12-rc6-mm1.
Instead of implementing the aio functions, this one implements the
synchronous read/write functions only. For readv and writev, the generic
fallback is used. For aio, we rely on the application doing the
fallback. Since our "synchronous" function does memcpy immediately
anyway, there is no performance difference between using the fallbacks
or implementing each operation.
Feedback is highly appreciated.

Signed-off-by: Carsten Otte <cotte@de.ibm.com>
---
diff -ruN linux-2.6.12-rc6-mm1/fs/ext2/file.c linux-2.6.12-rc6-mm1-xip/fs/ext2/file.c
--- linux-2.6.12-rc6-mm1/fs/ext2/file.c	2005-06-09 18:49:00.000000000 +0200
+++ linux-2.6.12-rc6-mm1-xip/fs/ext2/file.c	2005-06-09 19:53:42.000000000 +0200
@@ -58,17 +58,13 @@
 #ifdef CONFIG_EXT2_FS_XIP
 struct file_operations ext2_xip_file_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= do_sync_read,
-	.write		= do_sync_write,
-	.aio_read	= xip_file_aio_read,
-	.aio_write	= xip_file_aio_write,
+	.read		= xip_file_read,
+	.write		= xip_file_write,
 	.ioctl		= ext2_ioctl,
 	.mmap		= xip_file_mmap,
 	.open		= generic_file_open,
 	.release	= ext2_release_file,
 	.fsync		= ext2_sync_file,
-	.readv		= xip_file_readv,
-	.writev		= xip_file_writev,
 	.sendfile	= xip_file_sendfile,
 };
 #endif
diff -ruN linux-2.6.12-rc6-mm1/include/linux/fs.h linux-2.6.12-rc6-mm1-xip/include/linux/fs.h
--- linux-2.6.12-rc6-mm1/include/linux/fs.h	2005-06-09 18:49:04.000000000 +0200
+++ linux-2.6.12-rc6-mm1-xip/include/linux/fs.h	2005-06-09 19:53:42.000000000 +0200
@@ -1524,18 +1524,14 @@
 extern int nonseekable_open(struct inode * inode, struct file * filp);
 
 #ifdef CONFIG_FS_XIP
-extern ssize_t xip_file_aio_read(struct kiocb *iocb, char __user *buf,
-				 size_t count, loff_t pos);
-extern ssize_t xip_file_readv(struct file *filp, const struct iovec *iov,
-			      unsigned long nr_segs, loff_t *ppos);
+extern ssize_t xip_file_read(struct file *filp, char __user *buf, size_t len,
+			     loff_t *ppos);
 extern ssize_t xip_file_sendfile(struct file *in_file, loff_t *ppos,
 				 size_t count, read_actor_t actor,
 				 void *target);
 extern int xip_file_mmap(struct file * file, struct vm_area_struct * vma);
-extern ssize_t xip_file_aio_write(struct kiocb *iocb, const char __user *buf,
-				  size_t count, loff_t pos);
-extern ssize_t xip_file_writev(struct file *file, const struct iovec *iov,
-			       unsigned long nr_segs, loff_t *ppos);
+extern ssize_t xip_file_write(struct file *filp, const char __user *buf,
+			      size_t len, loff_t *ppos);
 extern int xip_truncate_page(struct address_space *mapping, loff_t from);
 #else
 static inline int xip_truncate_page(struct address_space *mapping, loff_t from)
diff -ruN linux-2.6.12-rc6-mm1/mm/filemap.h linux-2.6.12-rc6-mm1-xip/mm/filemap.h
--- linux-2.6.12-rc6-mm1/mm/filemap.h	2005-06-09 18:49:06.000000000 +0200
+++ linux-2.6.12-rc6-mm1-xip/mm/filemap.h	2005-06-13 15:18:36.000000000 +0200
@@ -15,7 +15,7 @@
 #include <linux/config.h>
 #include <asm/uaccess.h>
 
-extern size_t
+size_t
 __filemap_copy_from_user_iovec(char *vaddr,
 			       const struct iovec *iov,
 			       size_t base,
diff -ruN linux-2.6.12-rc6-mm1/mm/filemap_xip.c linux-2.6.12-rc6-mm1-xip/mm/filemap_xip.c
--- linux-2.6.12-rc6-mm1/mm/filemap_xip.c	2005-06-09 18:49:06.000000000 +0200
+++ linux-2.6.12-rc6-mm1-xip/mm/filemap_xip.c	2005-06-13 15:18:11.000000000 +0200
@@ -114,83 +114,28 @@
 		file_accessed(filp);
 }
 
-/*
- * This is the "read()" routine for all filesystems
- * that uses the get_xip_page address space operation.
- */
-static ssize_t
-__xip_file_aio_read(struct kiocb *iocb, const struct iovec *iov,
-		unsigned long nr_segs, loff_t *ppos)
-{
-	struct file *filp = iocb->ki_filp;
-	ssize_t retval;
-	unsigned long seg;
-	size_t count;
-
-	count = 0;
-	for (seg = 0; seg < nr_segs; seg++) {
-		const struct iovec *iv = &iov[seg];
-
-		/*
-		 * If any segment has a negative length, or the cumulative
-		 * length ever wraps negative then return -EINVAL.
-		 */
-		count += iv->iov_len;
-		if (unlikely((ssize_t)(count|iv->iov_len) < 0))
-			return -EINVAL;
-		if (access_ok(VERIFY_WRITE, iv->iov_base, iv->iov_len))
-			continue;
-		if (seg == 0)
-			return -EFAULT;
-		nr_segs = seg;
-		count -= iv->iov_len;	/* This segment is no good */
-		break;
-	}
-
-	retval = 0;
-	if (count) {
-		for (seg = 0; seg < nr_segs; seg++) {
-			read_descriptor_t desc;
-
-			desc.written = 0;
-			desc.arg.buf = iov[seg].iov_base;
-			desc.count = iov[seg].iov_len;
-			if (desc.count == 0)
-				continue;
-			desc.error = 0;
-			do_xip_mapping_read(filp->f_mapping, &filp->f_ra, filp,
-					    ppos, &desc, file_read_actor);
-			retval += desc.written;
-			if (!retval) {
-				retval = desc.error;
-				break;
-			}
-		}
-	}
-	return retval;
-}
-
 ssize_t
-xip_file_aio_read(struct kiocb *iocb, char __user *buf, size_t count,
-		  loff_t pos)
+xip_file_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos)
 {
-	struct iovec local_iov = { .iov_base = buf, .iov_len = count };
+	read_descriptor_t desc;
 
-	BUG_ON(iocb->ki_pos != pos);
-	return __xip_file_aio_read(iocb, &local_iov, 1, &iocb->ki_pos);
-}
-EXPORT_SYMBOL_GPL(xip_file_aio_read);
+	if (!access_ok(VERIFY_WRITE, buf, len))
+		return -EFAULT;
+	
+	desc.written = 0;
+	desc.arg.buf = buf;
+	desc.count = len;
+	desc.error = 0;
 
-ssize_t
-xip_file_readv(struct file *filp, const struct iovec *iov,
-	       unsigned long nr_segs, loff_t *ppos)
-{
-	struct kiocb kiocb;
+	do_xip_mapping_read(filp->f_mapping, &filp->f_ra, filp,
+			    ppos, &desc, file_read_actor);
 
-	init_sync_kiocb(&kiocb, filp);
-	return __xip_file_aio_read(&kiocb, iov, nr_segs, ppos);
+	if (desc.written)
+		return desc.written;
+	else
+		return desc.error;
 }
-EXPORT_SYMBOL_GPL(xip_file_readv);
+EXPORT_SYMBOL_GPL(xip_file_read);
 
 ssize_t
 xip_file_sendfile(struct file *in_file, loff_t *ppos,
@@ -326,25 +271,19 @@
 EXPORT_SYMBOL_GPL(xip_file_mmap);
 
 static ssize_t
-do_xip_file_write(struct kiocb *iocb, const struct iovec *iov,
-		  unsigned long nr_segs, loff_t pos, loff_t *ppos,
-		  size_t count)
+__xip_file_write(struct file *filp, const char __user *buf,
+		  size_t count, loff_t pos, loff_t *ppos)
 {
-	struct file *file = iocb->ki_filp;
-	struct address_space * mapping = file->f_mapping;
+	struct address_space * mapping = filp->f_mapping;
 	struct address_space_operations *a_ops = mapping->a_ops;
 	struct inode 	*inode = mapping->host;
 	long		status = 0;
 	struct page	*page;
 	size_t		bytes;
-	const struct iovec *cur_iov = iov; /* current iovec */
-	size_t		iov_base = 0;	   /* offset in the current iovec */
-	char __user	*buf;
 	ssize_t		written = 0;
 
 	BUG_ON(!mapping->a_ops->get_xip_page);
 
-	buf = iov->iov_base;
 	do {
 		unsigned long index;
 		unsigned long offset;
@@ -365,15 +304,14 @@
 		fault_in_pages_readable(buf, bytes);
 
 		page = a_ops->get_xip_page(mapping,
-						    index*(PAGE_SIZE/512), 0);
+					   index*(PAGE_SIZE/512), 0);
 		if (IS_ERR(page) && (PTR_ERR(page) == -ENODATA)) {
 			/* we allocate a new page unmap it */
 			page = a_ops->get_xip_page(mapping,
-				index*(PAGE_SIZE/512), 1);
+						   index*(PAGE_SIZE/512), 1);
 			if (!IS_ERR(page))
-			/* unmap page at pgoff from all other vmas */
-			__xip_unmap(mapping, index);
-
+				/* unmap page at pgoff from all other vmas */
+				__xip_unmap(mapping, index);
 		}
 
 		if (IS_ERR(page)) {
@@ -383,12 +321,7 @@
 
 		BUG_ON(!PageUptodate(page));
 
-		if (likely(nr_segs == 1))
-			copied = filemap_copy_from_user(page, offset,
-							buf, bytes);
-		else
-			copied = filemap_copy_from_user_iovec(page, offset,
-						cur_iov, iov_base, bytes);
+		copied = filemap_copy_from_user(page, offset, buf, bytes);
 		flush_dcache_page(page);
 		if (likely(copied > 0)) {
 			status = copied;
@@ -398,9 +331,6 @@
 				count -= status;
 				pos += status;
 				buf += status;
-				if (unlikely(nr_segs > 1))
-					filemap_set_next_iovec(&cur_iov,
-							&iov_base, status);
 			}
 		}
 		if (unlikely(copied != bytes))
@@ -422,110 +352,52 @@
 	return written ? written : status;
 }
 
-static ssize_t
-xip_file_aio_write_nolock(struct kiocb *iocb, const struct iovec *iov,
-				unsigned long nr_segs, loff_t *ppos)
+ssize_t
+xip_file_write(struct file *filp, const char __user *buf, size_t len,
+	       loff_t *ppos)
 {
-	struct file *file = iocb->ki_filp;
-	struct address_space * mapping = file->f_mapping;
-	size_t ocount;		/* original count */
-	size_t count;		/* after file limit checks */
-	struct inode 	*inode = mapping->host;
-	unsigned long	seg;
-	loff_t		pos;
-	ssize_t		written;
-	ssize_t		err;
-
-	ocount = 0;
-	for (seg = 0; seg < nr_segs; seg++) {
-		const struct iovec *iv = &iov[seg];
+	struct address_space *mapping = filp->f_mapping;
+	struct inode *inode = mapping->host;
+	size_t count;
+	loff_t pos;
+	ssize_t ret;
 
-		/*
-		 * If any segment has a negative length, or the cumulative
-		 * length ever wraps negative then return -EINVAL.
-		 */
-		ocount += iv->iov_len;
-		if (unlikely((ssize_t)(ocount|iv->iov_len) < 0))
-			return -EINVAL;
-		if (access_ok(VERIFY_READ, iv->iov_base, iv->iov_len))
-			continue;
-		if (seg == 0)
-			return -EFAULT;
-		nr_segs = seg;
-		ocount -= iv->iov_len;	/* This segment is no good */
-		break;
+	down(&inode->i_sem);
+
+	if (!access_ok(VERIFY_READ, buf, len)) {
+		ret=-EFAULT;
+		goto out_up;
 	}
 
-	count = ocount;
 	pos = *ppos;
+	count = len;
 
 	vfs_check_frozen(inode->i_sb, SB_FREEZE_WRITE);
 
-	written = 0;
-
-	err = generic_write_checks(file, &pos, &count, S_ISBLK(inode->i_mode));
-	if (err)
-		goto out;
+	/* We can write back this queue in page reclaim */
+	current->backing_dev_info = mapping->backing_dev_info;
 
+	ret = generic_write_checks(filp, &pos, &count, S_ISBLK(inode->i_mode));
+	if (ret)
+		goto out_backing;
 	if (count == 0)
-		goto out;
+		goto out_backing;
 
-	err = remove_suid(file->f_dentry);
-	if (err)
-		goto out;
+	ret = remove_suid(filp->f_dentry);
+	if (ret)
+		goto out_backing;
 
 	inode_update_time(inode, 1);
 
-	/* use execute in place to copy directly to disk */
-	written = do_xip_file_write (iocb, iov,
-				  nr_segs, pos, ppos, count);
- out:
-	return written ? written : err;
-}
-
-static ssize_t
-__xip_file_write_nolock(struct file *file, const struct iovec *iov,
-			unsigned long nr_segs, loff_t *ppos)
-{
-	struct kiocb kiocb;
-
-	init_sync_kiocb(&kiocb, file);
-	return xip_file_aio_write_nolock(&kiocb, iov, nr_segs, ppos);
-}
-
-ssize_t
-xip_file_aio_write(struct kiocb *iocb, const char __user *buf,
-		       size_t count, loff_t pos)
-{
-	struct file *file = iocb->ki_filp;
-	struct address_space *mapping = file->f_mapping;
-	struct inode *inode = mapping->host;
-	ssize_t ret;
-	struct iovec local_iov = { .iov_base = (void __user *)buf,
-				   .iov_len = count };
-
-	BUG_ON(iocb->ki_pos != pos);
-
-	down(&inode->i_sem);
-	ret = xip_file_aio_write_nolock(iocb, &local_iov, 1, &iocb->ki_pos);
-	up(&inode->i_sem);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(xip_file_aio_write);
-
-ssize_t xip_file_writev(struct file *file, const struct iovec *iov,
-			unsigned long nr_segs, loff_t *ppos)
-{
-	struct address_space *mapping = file->f_mapping;
-	struct inode *inode = mapping->host;
-	ssize_t ret;
+	ret = __xip_file_write (filp, buf, count, pos, ppos);
 
-	down(&inode->i_sem);
-	ret = __xip_file_write_nolock(file, iov, nr_segs, ppos);
+ out_backing:
+	current->backing_dev_info = NULL;
+ out_up:
 	up(&inode->i_sem);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(xip_file_writev);
+EXPORT_SYMBOL_GPL(xip_file_write);
 
 /*
  * truncate a page used for execute in place
@@ -541,7 +413,6 @@
 	unsigned length;
 	struct page *page;
 	void *kaddr;
-	int err;
 
 	BUG_ON(!mapping->a_ops->get_xip_page);
 
@@ -556,17 +427,14 @@
 
 	page = mapping->a_ops->get_xip_page(mapping,
 					    index*(PAGE_SIZE/512), 0);
-	err = -ENOMEM;
 	if (!page)
-		goto out;
+		return -ENOMEM;
 	if (unlikely(IS_ERR(page))) {
-		if (PTR_ERR(page) == -ENODATA) {
+		if (PTR_ERR(page) == -ENODATA)
 			/* Hole? No need to truncate */
 			return 0;
-		} else {
-			err = PTR_ERR(page);
-			goto out;
-		}
+		else
+			return PTR_ERR(page);
 	} else
 		BUG_ON(!PageUptodate(page));
 	kaddr = kmap_atomic(page, KM_USER0);
@@ -574,8 +442,6 @@
 	kunmap_atomic(kaddr, KM_USER0);
 
 	flush_dcache_page(page);
-	err = 0;
-out:
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(xip_truncate_page);



