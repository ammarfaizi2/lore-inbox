Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVFAXF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVFAXF5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 19:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVFAXF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 19:05:57 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:60865 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S261355AbVFAXFW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 19:05:22 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [patch 5/11] s390: #ifdefs in compat_ioctls.
Date: Thu, 2 Jun 2005 00:43:51 +0200
User-Agent: KMail/1.7.2
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
References: <20050601180312.GE6418@localhost.localdomain> <20050601181137.GA24268@infradead.org>
In-Reply-To: <20050601181137.GA24268@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200506020043.52484.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Middeweken 01 Juni 2005 20:11, Christoph Hellwig wrote:
> Actually is there any chance you could just provide ->compat_ioctl handlers
> in the drivers?  All these ioctls are specific to drivers, and it sounds like
> a rather bad idea to pollute the global has table with them.  This is also
> a good chance to switch the drivers to drop BKL usage in the ioctl path and
> use the same handler for ->unlocked_ioctl and ->compat_ioctl.

I just checked and found that block_device_operations don't support
unlocked_ioctl() yet. I have hacked up a patch to add that without
changing the semantics of blkdev_ioctl(). I have not done thorough
testing, but my system is running fine with this applied.
Does it look ok to you?

[PATCH] block: add unlocked_ioctl support for block devices

This patch allows block device drivers to convert their ioctl functions
to unlocked_ioctl() like character devices and other subsystems.
All functions that were called with the BKL held before are still
used that way, but I would not be surprised if it could be removed
from the ioctl functions in drivers/block/ioctl.c themselves.

As a side note, I found that compat_blkdev_ioctl() acquires the BKL
as well, which looks like a bug. I have checked that every user
of disk->fops->compat_ioctl() in the current git tree gets the BKL
itself, so it could easily be removed from compat_blkdev_ioctl().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

--

Index: drivers/block/ioctl.c
===================================================================
--- 3ac19ebb77c3cd8a1df31b7170c6eaf9e1afb1a4/drivers/block/ioctl.c  (mode:100644)
+++ uncommitted/drivers/block/ioctl.c  (mode:100644)
@@ -133,11 +133,9 @@
 	return put_user(val, (u64 __user *)arg);
 }
 
-int blkdev_ioctl(struct inode *inode, struct file *file, unsigned cmd,
-			unsigned long arg)
+static int blkdev_locked_ioctl(struct file *file, struct block_device *bdev,
+				unsigned cmd, unsigned long arg)
 {
-	struct block_device *bdev = inode->i_bdev;
-	struct gendisk *disk = bdev->bd_disk;
 	struct backing_dev_info *bdi;
 	int ret, n;
 
@@ -190,36 +188,72 @@
 		return put_ulong(arg, bdev->bd_inode->i_size >> 9);
 	case BLKGETSIZE64:
 		return put_u64(arg, bdev->bd_inode->i_size);
+	}
+	return -ENOIOCTLCMD;
+}
+
+static int blkdev_driver_ioctl(struct inode *inode, struct file *file,
+		struct gendisk *disk, unsigned cmd, unsigned long arg)
+{
+	int ret;
+	if (disk->fops->unlocked_ioctl)
+		return disk->fops->unlocked_ioctl(file, cmd, arg);
+
+	if (disk->fops->ioctl) {
+		lock_kernel();
+		ret = disk->fops->ioctl(inode, file, cmd, arg);
+		unlock_kernel();
+		return ret;
+	}
+
+	return -ENOTTY;
+}
+
+int blkdev_ioctl(struct inode *inode, struct file *file, unsigned cmd,
+			unsigned long arg)
+{
+	struct block_device *bdev = inode->i_bdev;
+	struct gendisk *disk = bdev->bd_disk;
+	int ret, n;
+
+	switch(cmd) {
 	case BLKFLSBUF:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
-		if (disk->fops->ioctl) {
-			ret = disk->fops->ioctl(inode, file, cmd, arg);
-			/* -EINVAL to handle old uncorrected drivers */
-			if (ret != -EINVAL && ret != -ENOTTY)
-				return ret;
-		}
+
+		ret = blkdev_driver_ioctl(inode, file, disk, cmd, arg);
+		/* -EINVAL to handle old uncorrected drivers */
+		if (ret != -EINVAL && ret != -ENOTTY)
+			return ret;
+
+		lock_kernel();
 		fsync_bdev(bdev);
 		invalidate_bdev(bdev, 0);
+		unlock_kernel();
 		return 0;
+
 	case BLKROSET:
-		if (disk->fops->ioctl) {
-			ret = disk->fops->ioctl(inode, file, cmd, arg);
-			/* -EINVAL to handle old uncorrected drivers */
-			if (ret != -EINVAL && ret != -ENOTTY)
-				return ret;
-		}
+		ret = blkdev_driver_ioctl(inode, file, disk, cmd, arg);
+		/* -EINVAL to handle old uncorrected drivers */
+		if (ret != -EINVAL && ret != -ENOTTY)
+			return ret;
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
 		if (get_user(n, (int __user *)(arg)))
 			return -EFAULT;
+		lock_kernel();
 		set_device_ro(bdev, n);
+		unlock_kernel();
 		return 0;
-	default:
-		if (disk->fops->ioctl)
-			return disk->fops->ioctl(inode, file, cmd, arg);
 	}
-	return -ENOTTY;
+
+	lock_kernel();
+	ret = blkdev_locked_ioctl(file, bdev, cmd, arg);
+	unlock_kernel();
+	if (ret != -ENOIOCTLCMD)
+		return ret;
+
+	return blkdev_driver_ioctl(inode, file, disk, cmd, arg);
 }
 
 /* Most of the generic ioctls are handled in the normal fallback path.
Index: fs/block_dev.c
===================================================================
--- 3ac19ebb77c3cd8a1df31b7170c6eaf9e1afb1a4/fs/block_dev.c  (mode:100644)
+++ uncommitted/fs/block_dev.c  (mode:100644)
@@ -777,8 +777,7 @@
 	return generic_file_aio_write_nolock(iocb, &local_iov, 1, &iocb->ki_pos);
 }
 
-static int block_ioctl(struct inode *inode, struct file *file, unsigned cmd,
-			unsigned long arg)
+static long block_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 {
 	return blkdev_ioctl(file->f_mapping->host, file, cmd, arg);
 }
@@ -803,7 +802,7 @@
   	.aio_write	= blkdev_file_aio_write, 
 	.mmap		= generic_file_mmap,
 	.fsync		= block_fsync,
-	.ioctl		= block_ioctl,
+	.unlocked_ioctl	= block_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= compat_blkdev_ioctl,
 #endif
Index: include/linux/fs.h
===================================================================
--- 3ac19ebb77c3cd8a1df31b7170c6eaf9e1afb1a4/include/linux/fs.h  (mode:100644)
+++ uncommitted/include/linux/fs.h  (mode:100644)
@@ -883,6 +883,7 @@
 	int (*open) (struct inode *, struct file *);
 	int (*release) (struct inode *, struct file *);
 	int (*ioctl) (struct inode *, struct file *, unsigned, unsigned long);
+	long (*unlocked_ioctl) (struct file *, unsigned, unsigned long);
 	long (*compat_ioctl) (struct file *, unsigned, unsigned long);
 	int (*media_changed) (struct gendisk *);
 	int (*revalidate_disk) (struct gendisk *);
