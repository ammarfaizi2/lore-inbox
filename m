Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVARH4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVARH4R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 02:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVARH4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 02:56:17 -0500
Received: from colin2.muc.de ([193.149.48.15]:39177 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261168AbVARH4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 02:56:03 -0500
Date: 18 Jan 2005 08:56:02 +0100
Date: Tue, 18 Jan 2005 08:56:02 +0100
From: Andi Kleen <ak@muc.de>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Support compat_ioctl for block devices
Message-ID: <20050118075602.GD76018@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Support passing down of compat_ioctl on block devices.
This is needed for the compat_ioctl conversion of block drivers.

Signed-off-by: Andi Kleen <ak@muc.de>

diff -u linux-2.6.11-rc1-bk4/drivers/block/ioctl.c-o linux-2.6.11-rc1-bk4/drivers/block/ioctl.c
--- linux-2.6.11-rc1-bk4/drivers/block/ioctl.c-o	2004-10-19 01:55:10.000000000 +0200
+++ linux-2.6.11-rc1-bk4/drivers/block/ioctl.c	2005-01-18 03:53:40.000000000 +0100
@@ -3,6 +3,7 @@
 #include <linux/blkpg.h>
 #include <linux/backing-dev.h>
 #include <linux/buffer_head.h>
+#include <linux/smp_lock.h>
 #include <asm/uaccess.h>
 
 static int blkpg_ioctl(struct block_device *bdev, struct blkpg_ioctl_arg __user *arg)
@@ -220,3 +221,19 @@
 	}
 	return -ENOTTY;
 }
+
+/* Most of the generic ioctls are handled in the normal fallback path.
+   This assumes the blkdev's low level compat_ioctl always returns
+   ENOIOCTLCMD for unknown ioctls. */
+long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
+{
+	struct block_device *bdev = file->f_dentry->d_inode->i_bdev;
+	struct gendisk *disk = bdev->bd_disk;
+	int ret = -ENOIOCTLCMD;
+	if (disk->fops->compat_ioctl) {
+		lock_kernel();
+		ret = disk->fops->compat_ioctl(file, cmd, arg);
+		unlock_kernel();
+	}
+	return ret;
+}
diff -u linux-2.6.11-rc1-bk4/fs/block_dev.c-o linux-2.6.11-rc1-bk4/fs/block_dev.c
--- linux-2.6.11-rc1-bk4/fs/block_dev.c-o	2005-01-04 12:13:13.000000000 +0100
+++ linux-2.6.11-rc1-bk4/fs/block_dev.c	2005-01-18 07:26:45.000000000 +0100
@@ -804,6 +804,9 @@
 	.mmap		= generic_file_mmap,
 	.fsync		= block_fsync,
 	.ioctl		= block_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= compat_blkdev_ioctl,
+#endif
 	.readv		= generic_file_readv,
 	.writev		= generic_file_write_nolock,
 	.sendfile	= generic_file_sendfile,
diff -u linux-2.6.11-rc1-bk4/include/linux/fs.h-o linux-2.6.11-rc1-bk4/include/linux/fs.h
--- linux-2.6.11-rc1-bk4/include/linux/fs.h-o	2005-01-17 10:39:41.000000000 +0100
+++ linux-2.6.11-rc1-bk4/include/linux/fs.h	2005-01-18 04:54:29.000000000 +0100
@@ -879,6 +879,7 @@
 	int (*open) (struct inode *, struct file *);
 	int (*release) (struct inode *, struct file *);
 	int (*ioctl) (struct inode *, struct file *, unsigned, unsigned long);
+	long (*compat_ioctl) (struct file *, unsigned, unsigned long);
 	int (*media_changed) (struct gendisk *);
 	int (*revalidate_disk) (struct gendisk *);
 	struct module *owner;
@@ -1291,6 +1292,7 @@
 extern struct file_operations def_fifo_fops;
 extern int ioctl_by_bdev(struct block_device *, unsigned, unsigned long);
 extern int blkdev_ioctl(struct inode *, struct file *, unsigned, unsigned long);
+extern long compat_blkdev_ioctl(struct file *, unsigned, unsigned long);
 extern int blkdev_get(struct block_device *, mode_t, unsigned);
 extern int blkdev_put(struct block_device *);
 extern int bd_claim(struct block_device *, void *);
