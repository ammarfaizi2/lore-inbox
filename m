Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266308AbSKZO3M>; Tue, 26 Nov 2002 09:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266310AbSKZO3M>; Tue, 26 Nov 2002 09:29:12 -0500
Received: from verein.lst.de ([212.34.181.86]:23569 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S266308AbSKZO3J>;
	Tue, 26 Nov 2002 09:29:09 -0500
Date: Tue, 26 Nov 2002 15:35:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: [PATCH] helper for inkernel opening of block devices
Message-ID: <20021126153546.A14530@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	viro@math.psu.edu, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A large part of get_sb_bdev is used to properly open, setup and claim
a block device given it's pathname.  This same actions must be taken
by other kernel code, like opening of the log and rt volumes in xfs,
and volume setup in DM.

I'd suggest to split it out into a helper (and a surrounding close
routine).  Once this is in I'll use it in XFS (couldn't do it in this
patch as there's a big XFS update pending for you), and I'll hope
the DM folks start to use it aswell.

(p.s. there also some cosmetics for consistance naming in block_dev.c
 in this patch, the old naming just made my eyes burn)

--- 1.115/fs/block_dev.c	Thu Nov 21 16:10:47 2002
+++ edited/fs/block_dev.c	Tue Nov 26 13:17:04 2002
@@ -22,6 +22,7 @@
 #include <linux/mpage.h>
 #include <linux/mount.h>
 #include <linux/uio.h>
+#include <linux/namei.h>
 #include <asm/uaccess.h>
 
 
@@ -151,7 +152,7 @@
  * for a block special file file->f_dentry->d_inode->i_size is zero
  * so we compute the size by hand (just as in block_read/write above)
  */
-static loff_t block_llseek(struct file *file, loff_t offset, int origin)
+static loff_t blkdev_llseek(struct file *file, loff_t offset, int origin)
 {
 	/* ewww */
 	loff_t size = file->f_dentry->d_inode->i_bdev->bd_inode->i_size;
@@ -182,11 +183,9 @@
  *	since the vma has no handle.
  */
  
-static int block_fsync(struct file *filp, struct dentry *dentry, int datasync)
+static int blkdev_fsync(struct file *filp, struct dentry *dentry, int datasync)
 {
-	struct inode * inode = dentry->d_inode;
-
-	return sync_blockdev(inode->i_bdev);
+	return sync_blockdev(dentry->d_inode->i_bdev);
 }
 
 /*
@@ -764,11 +763,11 @@
 struct file_operations def_blk_fops = {
 	.open		= blkdev_open,
 	.release	= blkdev_close,
-	.llseek		= block_llseek,
+	.llseek		= blkdev_llseek,
 	.read		= generic_file_read,
 	.write		= blkdev_file_write,
 	.mmap		= generic_file_mmap,
-	.fsync		= block_fsync,
+	.fsync		= blkdev_fsync,
 	.ioctl		= blkdev_ioctl,
 	.readv		= generic_file_readv,
 	.writev		= generic_file_writev,
@@ -795,4 +794,63 @@
 
 	sprintf(buffer, "%s(%d,%d)", name, MAJOR(dev), MINOR(dev));
 	return buffer;
+}
+
+struct block_device *open_bdev_excl(char *path, int fl, int kind, void *holder)
+{
+	struct inode *inode;
+	struct block_device *bdev;
+	struct nameidata nd;
+	mode_t mode = FMODE_READ;
+	int error = 0;
+
+	if (!path || !*path)
+		return ERR_PTR(-EINVAL);
+
+	error = path_lookup(path, LOOKUP_FOLLOW, &nd);
+	if (error)
+		return ERR_PTR(error);
+
+	inode = nd.dentry->d_inode;
+	error = -ENOTBLK;
+	if (!S_ISBLK(inode->i_mode))
+		goto path_release;
+	error = -EACCES;
+	if (nd.mnt->mnt_flags & MNT_NODEV)
+		goto path_release;
+	error = bd_acquire(inode);
+	if (error)
+		goto path_release;
+	bdev = inode->i_bdev;
+
+	/* Done with lookups */
+	path_release(&nd);
+
+	if (!(fl & MS_RDONLY))
+		mode |= FMODE_WRITE;
+	error = blkdev_get(bdev, mode, 0, kind);
+	if (error)
+		return ERR_PTR(error);
+	error = -EACCES;
+	if (!(fl & MS_RDONLY) && bdev_read_only(bdev))
+		goto blkdev_put;
+	error = bd_claim(bdev, holder);
+	if (error)
+		goto blkdev_put;
+
+	return bdev;
+	
+blkdev_put:
+	blkdev_put(bdev, BDEV_FS);
+	return ERR_PTR(error);
+
+path_release:
+	path_release(&nd);
+	return ERR_PTR(error);
+}
+
+void close_bdev_excl(struct block_device *bdev, int kind)
+{
+	bd_release(bdev);
+	blkdev_put(bdev, kind);
 }
--- 1.85/fs/super.c	Sat Nov 16 15:40:24 2002
+++ edited/fs/super.c	Tue Nov 26 14:28:00 2002
@@ -463,55 +463,25 @@
 	int flags, char *dev_name, void * data,
 	int (*fill_super)(struct super_block *, void *, int))
 {
-	struct inode *inode;
 	struct block_device *bdev;
-	struct super_block * s;
-	struct nameidata nd;
+	struct super_block *s;
 	int error = 0;
-	mode_t mode = FMODE_READ; /* we always need it ;-) */
 
-	/* What device it is? */
-	if (!dev_name || !*dev_name)
-		return ERR_PTR(-EINVAL);
-	error = path_lookup(dev_name, LOOKUP_FOLLOW, &nd);
-	if (error)
-		return ERR_PTR(error);
-	inode = nd.dentry->d_inode;
-	error = -ENOTBLK;
-	if (!S_ISBLK(inode->i_mode))
-		goto out;
-	error = -EACCES;
-	if (nd.mnt->mnt_flags & MNT_NODEV)
-		goto out;
-	error = bd_acquire(inode);
-	if (error)
-		goto out;
-	bdev = inode->i_bdev;
-	/* Done with lookups, semaphore down */
-	if (!(flags & MS_RDONLY))
-		mode |= FMODE_WRITE;
-	error = blkdev_get(bdev, mode, 0, BDEV_FS);
-	if (error)
-		goto out;
-	error = -EACCES;
-	if (!(flags & MS_RDONLY) && bdev_read_only(bdev))
-		goto out1;
-	error = bd_claim(bdev, fs_type);
-	if (error)
-		goto out1;
+	bdev = open_bdev_excl(dev_name, flags, BDEV_FS, fs_type);
+	if (IS_ERR(bdev))
+		return (struct super_block *)bdev;
 
 	s = sget(fs_type, test_bdev_super, set_bdev_super, bdev);
-	if (IS_ERR(s)) {
-		bd_release(bdev);
-		blkdev_put(bdev, BDEV_FS);
-	} else if (s->s_root) {
+	if (IS_ERR(s))
+		goto out;
+
+	if (s->s_root) {
 		if ((flags ^ s->s_flags) & MS_RDONLY) {
 			up_write(&s->s_umount);
 			deactivate_super(s);
 			s = ERR_PTR(-EBUSY);
 		}
-		bd_release(bdev);
-		blkdev_put(bdev, BDEV_FS);
+		goto out;
 	} else {
 		s->s_flags = flags;
 		strncpy(s->s_id, bdevname(bdev), sizeof(s->s_id));
@@ -525,14 +495,12 @@
 		} else
 			s->s_flags |= MS_ACTIVE;
 	}
-	path_release(&nd);
+
 	return s;
 
-out1:
-	blkdev_put(bdev, BDEV_FS);
 out:
-	path_release(&nd);
-	return ERR_PTR(error);
+	close_bdev_excl(bdev, BDEV_FS);
+	return s;
 }
 
 void kill_block_super(struct super_block *sb)
@@ -540,8 +508,7 @@
 	struct block_device *bdev = sb->s_bdev;
 	generic_shutdown_super(sb);
 	set_blocksize(bdev, sb->s_old_blocksize);
-	bd_release(bdev);
-	blkdev_put(bdev, BDEV_FS);
+	close_bdev_excl(bdev, BDEV_FS);
 }
 
 struct super_block *get_sb_nodev(struct file_system_type *fs_type,
--- 1.200/include/linux/fs.h	Thu Nov 21 16:10:47 2002
+++ edited/include/linux/fs.h	Tue Nov 26 13:07:17 2002
@@ -1096,15 +1096,20 @@
 extern void bd_release(struct block_device *);
 extern void blk_run_queues(void);
 
-/* fs/devices.c */
+/* fs/char_dev.c */
 extern int register_chrdev(unsigned int, const char *, struct file_operations *);
 extern int unregister_chrdev(unsigned int, const char *);
 extern int chrdev_open(struct inode *, struct file *);
+
+/* fs/block_dev.c */
 extern const char *__bdevname(dev_t);
 extern inline const char *bdevname(struct block_device *bdev)
 {
 	return __bdevname(bdev->bd_dev);
 }
+extern struct block_device *open_bdev_excl(char *, int, int, void *);
+extern void close_bdev_excl(struct block_device *, int);
+
 extern const char * cdevname(kdev_t);
 extern const char * kdevname(kdev_t);
 extern void init_special_inode(struct inode *, umode_t, dev_t);
--- 1.167/kernel/ksyms.c	Thu Nov 21 13:05:17 2002
+++ edited/kernel/ksyms.c	Tue Nov 26 13:11:20 2002
@@ -202,6 +202,8 @@
 EXPORT_SYMBOL(bdput);
 EXPORT_SYMBOL(bd_claim);
 EXPORT_SYMBOL(bd_release);
+EXPORT_SYMBOL(open_bdev_excl);
+EXPORT_SYMBOL(close_bdev_excl);
 EXPORT_SYMBOL(__brelse);
 EXPORT_SYMBOL(__bforget);
 EXPORT_SYMBOL(ll_rw_block);
