Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932691AbWFUTeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691AbWFUTeF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbWFUTeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:34:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27811 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932691AbWFUTeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:34:01 -0400
Date: Wed, 21 Jun 2006 20:33:53 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: [PATCH 04/15] dm: export blkdev_driver_ioctl
Message-ID: <20060621193353.GS4521@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Export blkdev_driver_ioctl for device-mapper.

If we get as far as the device-mapper ioctl handler, we know the ioctl is
not a standard block layer BLK* one, so we don't need to check for them a
second time and can call blkdev_driver_ioctl() directly.

Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.17/block/ioctl.c
===================================================================
--- linux-2.6.17.orig/block/ioctl.c	2006-06-21 16:19:39.000000000 +0100
+++ linux-2.6.17/block/ioctl.c	2006-06-21 17:16:50.000000000 +0100
@@ -199,8 +199,8 @@ static int blkdev_locked_ioctl(struct fi
 	return -ENOIOCTLCMD;
 }
 
-static int blkdev_driver_ioctl(struct inode *inode, struct file *file,
-		struct gendisk *disk, unsigned cmd, unsigned long arg)
+int blkdev_driver_ioctl(struct inode *inode, struct file *file,
+			struct gendisk *disk, unsigned cmd, unsigned long arg)
 {
 	int ret;
 	if (disk->fops->unlocked_ioctl)
@@ -215,6 +215,7 @@ static int blkdev_driver_ioctl(struct in
 
 	return -ENOTTY;
 }
+EXPORT_SYMBOL_GPL(blkdev_driver_ioctl);
 
 int blkdev_ioctl(struct inode *inode, struct file *file, unsigned cmd,
 			unsigned long arg)
Index: linux-2.6.17/drivers/md/dm-linear.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm-linear.c	2006-06-21 16:19:39.000000000 +0100
+++ linux-2.6.17/drivers/md/dm-linear.c	2006-06-21 17:16:50.000000000 +0100
@@ -103,7 +103,7 @@ static int linear_ioctl(struct dm_target
 	struct linear_c *lc = (struct linear_c *) ti->private;
 	struct block_device *bdev = lc->dev->bdev;
 
-	return blkdev_ioctl(bdev->bd_inode, filp, cmd, arg);
+	return blkdev_driver_ioctl(bdev->bd_inode, filp, bdev->bd_disk, cmd, arg);
 }
 
 static struct target_type linear_target = {
Index: linux-2.6.17/drivers/md/dm-mpath.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm-mpath.c	2006-06-21 17:03:58.000000000 +0100
+++ linux-2.6.17/drivers/md/dm-mpath.c	2006-06-21 17:17:46.000000000 +0100
@@ -1290,7 +1290,8 @@ static int multipath_ioctl(struct dm_tar
 
 	spin_unlock_irqrestore(&m->lock, flags);
 
-	return r ? : blkdev_ioctl(bdev->bd_inode, filp, cmd, arg);
+	return r ? : blkdev_driver_ioctl(bdev->bd_inode, filp, bdev->bd_disk,
+		     cmd, arg);
 }
 
 /*-----------------------------------------------------------------
Index: linux-2.6.17/include/linux/fs.h
===================================================================
--- linux-2.6.17.orig/include/linux/fs.h	2006-06-21 16:19:39.000000000 +0100
+++ linux-2.6.17/include/linux/fs.h	2006-06-21 17:16:50.000000000 +0100
@@ -1407,6 +1407,9 @@ extern const struct file_operations bad_
 extern const struct file_operations def_fifo_fops;
 extern int ioctl_by_bdev(struct block_device *, unsigned, unsigned long);
 extern int blkdev_ioctl(struct inode *, struct file *, unsigned, unsigned long);
+extern int blkdev_driver_ioctl(struct inode *inode, struct file *file,
+			       struct gendisk *disk, unsigned cmd,
+			       unsigned long arg);
 extern long compat_blkdev_ioctl(struct file *, unsigned, unsigned long);
 extern int blkdev_get(struct block_device *, mode_t, unsigned);
 extern int blkdev_put(struct block_device *);
