Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265019AbSLBUtK>; Mon, 2 Dec 2002 15:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265033AbSLBUtK>; Mon, 2 Dec 2002 15:49:10 -0500
Received: from tolkor.SGI.COM ([198.149.18.6]:7828 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S265019AbSLBUtE>;
	Mon, 2 Dec 2002 15:49:04 -0500
Date: Mon, 2 Dec 2002 23:09:36 -0500
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: [PATCH] consolidate code opening blockdevices by name
Message-ID: <20021202230936.A30811@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	viro@math.psu.edu, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A large part of get_sb_bdev is used to properly open, setup and claim
a block device given it's pathname.  This same actions must be taken
by other kernel code, like opening of the log and rt volumes in XFS,
and volume setup in DM.

I'd suggest to split it out into a helper (and a surrounding close
routine) and makes XFS use that code.  I hope the DM folks will
start to use it aswell.

(p.s. there also some cosmetics for consistance naming in block_dev.c
 in this patch, the old naming just made my eyes burn)


--- 1.116/fs/block_dev.c	Fri Nov 22 13:54:09 2002
+++ edited/fs/block_dev.c	Mon Dec  2 19:32:55 2002
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
@@ -795,4 +794,64 @@
 
 	sprintf(buffer, "%s(%d,%d)", name, MAJOR(dev), MINOR(dev));
 	return buffer;
+}
+
+struct block_device *open_bdev_excl(const char *path, int flags,
+				    int kind, void *holder)
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
+	if (!(flags & MS_RDONLY))
+		mode |= FMODE_WRITE;
+	error = blkdev_get(bdev, mode, 0, kind);
+	if (error)
+		return ERR_PTR(error);
+	error = -EACCES;
+	if (!(flags & MS_RDONLY) && bdev_read_only(bdev))
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
===== fs/super.c 1.87 vs edited =====
--- 1.87/fs/super.c	Mon Nov 25 00:30:53 2002
+++ edited/fs/super.c	Mon Dec  2 19:22:59 2002
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
===== fs/xfs/xfs_mount.h 1.7 vs edited =====
--- 1.7/fs/xfs/xfs_mount.h	Mon Nov 25 22:59:17 2002
+++ edited/fs/xfs/xfs_mount.h	Mon Dec  2 19:30:18 2002
@@ -428,11 +428,6 @@
 void		xfs_initialize_perag(xfs_mount_t *, int);
 void		xfs_xlatesb(void *, struct xfs_sb *, int, xfs_arch_t, __int64_t);
 
-int		xfs_blkdev_get(const char *, struct block_device **);
-void		xfs_blkdev_put(struct block_device *);
-struct xfs_buftarg *xfs_alloc_buftarg(struct block_device *);
-void		xfs_free_buftarg(struct xfs_buftarg *);
-
 /*
  * Flags for freeze operations.
  */
===== fs/xfs/xfs_vfsops.c 1.18 vs edited =====
--- 1.18/fs/xfs/xfs_vfsops.c	Mon Nov 25 22:59:17 2002
+++ edited/fs/xfs/xfs_vfsops.c	Mon Dec  2 19:07:15 2002
@@ -397,20 +397,25 @@
 
 	ddev = vfsp->vfs_super->s_bdev;
 	logdev = rtdev = NULL;
+	
+	/*
+	 * Allocate VFS private data (xfs mount structure).
+	 */
+	mp = xfs_mount_init();
 
 	/*
 	 * Open real time and log devices - order is important.
 	 */
 	if (args->logname[0]) {
-		error = xfs_blkdev_get(args->logname, &logdev);
+		error = xfs_blkdev_get(mp, args->logname, &logdev);
 		if (error)
-			return error;
+			goto free_mp;
 	}
 	if (args->rtname[0]) {
-		error = xfs_blkdev_get(args->rtname, &rtdev);
+		error = xfs_blkdev_get(mp, args->rtname, &rtdev);
 		if (error) {
 			xfs_blkdev_put(logdev);
-			return error;
+			goto free_mp;
 		}
 
 		if (rtdev == ddev || rtdev == logdev) {
@@ -418,22 +423,20 @@
 	"XFS: Cannot mount filesystem with identical rtdev and ddev/logdev.");
 			xfs_blkdev_put(logdev);
 			xfs_blkdev_put(rtdev);
-			return EINVAL;
+			error = EINVAL;
+			goto free_mp;
 		}
 	}
 
-	/*
-	 * Allocate VFS private data (xfs mount structure).
-	 */
-	mp = xfs_mount_init();
-
 	vfs_insertbhv(vfsp, &mp->m_bhv, &xfs_vfsops, mp);
 
 	mp->m_ddev_targp = xfs_alloc_buftarg(ddev);
 	if (rtdev)
 		mp->m_rtdev_targp = xfs_alloc_buftarg(rtdev);
-	mp->m_logdev_targp = (logdev && logdev != ddev) ?
-				xfs_alloc_buftarg(logdev) : mp->m_ddev_targp;
+	if (logdev && logdev != ddev)
+		mp->m_logdev_targp = xfs_alloc_buftarg(logdev);
+	else
+		mp->m_logdev_targp = mp->m_ddev_targp;
 
 	error = xfs_start_flags(args, mp, ronly);
 	if (error)
@@ -472,6 +475,8 @@
 		xfs_binval(mp->m_rtdev_targp);
 	}
 	xfs_unmountfs_close(mp, NULL);
+
+ free_mp:
 	xfs_mount_free(mp, 1);
 	return error;
 }
===== fs/xfs/linux/xfs_super.c 1.21 vs edited =====
--- 1.21/fs/xfs/linux/xfs_super.c	Mon Nov 25 23:14:07 2002
+++ edited/fs/xfs/linux/xfs_super.c	Mon Dec  2 19:33:21 2002
@@ -468,27 +468,18 @@
 
 int
 xfs_blkdev_get(
+	xfs_mount_t		*mp,
 	const char		*name,
 	struct block_device	**bdevp)
 {
-	struct nameidata	nd;
-	int			error;
+	int			error = 0;
 
-	error = path_lookup(name, LOOKUP_FOLLOW, &nd);
-	if (error) {
+	*bdevp = open_bdev_excl(name, 0, BDEV_FS, mp);
+	if (IS_ERR(*bdevp)) {
+		error = PTR_ERR(*bdevp);
 		printk("XFS: Invalid device [%s], error=%d\n", name, error);
-		return -error;
 	}
 
-	/* I think we actually want bd_acquire here..  --hch */
-	*bdevp = bdget(kdev_t_to_nr(nd.dentry->d_inode->i_rdev));
-	if (*bdevp) {
-		error = blkdev_get(*bdevp, FMODE_READ|FMODE_WRITE, 0, BDEV_FS);
-	} else {
-		error = -ENOMEM;
-	}
-
-	path_release(&nd);
 	return -error;
 }
 
@@ -497,7 +488,7 @@
 	struct block_device	*bdev)
 {
 	if (bdev)
-		blkdev_put(bdev, BDEV_FS);
+		close_bdev_excl(bdev, BDEV_FS);
 }
 
 void
===== fs/xfs/linux/xfs_super.h 1.7 vs edited =====
--- 1.7/fs/xfs/linux/xfs_super.h	Mon Nov 25 22:59:17 2002
+++ edited/fs/xfs/linux/xfs_super.h	Mon Dec  2 19:28:58 2002
@@ -80,10 +80,12 @@
 
 struct pb_target;
 struct block_device;
+struct xfs_mount;
 
 extern void xfs_initialize_vnode (bhv_desc_t *, vnode_t *, bhv_desc_t *, int);
 
-extern int  xfs_blkdev_get (const char *, struct block_device **);
+extern int  xfs_blkdev_get (struct xfs_mount *, const char *,
+				struct block_device **);
 extern void xfs_blkdev_put (struct block_device *);
 
 extern struct pb_target *xfs_alloc_buftarg (struct block_device *);
===== include/linux/fs.h 1.200 vs edited =====
--- 1.200/include/linux/fs.h	Thu Nov 21 22:10:47 2002
+++ edited/include/linux/fs.h	Mon Dec  2 19:33:07 2002
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
+extern struct block_device *open_bdev_excl(const char *, int, int, void *);
+extern void close_bdev_excl(struct block_device *, int);
+
 extern const char * cdevname(kdev_t);
 extern const char * kdevname(kdev_t);
 extern void init_special_inode(struct inode *, umode_t, dev_t);
===== kernel/ksyms.c 1.168 vs edited =====
--- 1.168/kernel/ksyms.c	Sun Dec  1 17:37:26 2002
+++ edited/kernel/ksyms.c	Mon Dec  2 18:59:14 2002
@@ -202,6 +202,8 @@
 EXPORT_SYMBOL(bdput);
 EXPORT_SYMBOL(bd_claim);
 EXPORT_SYMBOL(bd_release);
+EXPORT_SYMBOL(open_bdev_excl);
+EXPORT_SYMBOL(close_bdev_excl);
 EXPORT_SYMBOL(__brelse);
 EXPORT_SYMBOL(__bforget);
 EXPORT_SYMBOL(ll_rw_block);
