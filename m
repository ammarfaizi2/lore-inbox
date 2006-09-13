Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbWIMRqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWIMRqy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 13:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWIMRqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 13:46:54 -0400
Received: from [213.46.243.16] ([213.46.243.16]:2164 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750838AbWIMRqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 13:46:33 -0400
Message-Id: <20060913174650.312151000@chello.nl>
References: <20060913174312.528491000@chello.nl>
User-Agent: quilt/0.45-1
Date: Wed, 13 Sep 2006 19:43:13 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel@vger.kernel.org
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@linux.intel.com>, Andrew Morton <akpm@osdl.org>,
       Jason Baron <jbaron@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 1/2] remove the old bd_mutex lockdep annotation
Content-Disposition: inline; filename=remove_old_block_annotation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the old complex and crufty bd_mutex annotation.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Jason Baron <jbaron@redhat.com>
---
 block/ioctl.c      |    4 -
 drivers/md/md.c    |    6 -
 fs/block_dev.c     |  180 ++++++++++++++++-------------------------------------
 include/linux/fs.h |   17 -----
 4 files changed, 60 insertions(+), 147 deletions(-)

Index: linux-2.6-mm/drivers/md/md.c
===================================================================
--- linux-2.6-mm.orig/drivers/md/md.c
+++ linux-2.6-mm/drivers/md/md.c
@@ -1408,7 +1408,7 @@ static int lock_rdev(mdk_rdev_t *rdev, d
 	struct block_device *bdev;
 	char b[BDEVNAME_SIZE];
 
-	bdev = open_partition_by_devnum(dev, FMODE_READ|FMODE_WRITE);
+	bdev = open_by_devnum(dev, FMODE_READ|FMODE_WRITE);
 	if (IS_ERR(bdev)) {
 		printk(KERN_ERR "md: could not open %s.\n",
 			__bdevname(dev, b));
@@ -1418,7 +1418,7 @@ static int lock_rdev(mdk_rdev_t *rdev, d
 	if (err) {
 		printk(KERN_ERR "md: could not bd_claim %s.\n",
 			bdevname(bdev, b));
-		blkdev_put_partition(bdev);
+		blkdev_put(bdev);
 		return err;
 	}
 	rdev->bdev = bdev;
@@ -1432,7 +1432,7 @@ static void unlock_rdev(mdk_rdev_t *rdev
 	if (!bdev)
 		MD_BUG();
 	bd_release(bdev);
-	blkdev_put_partition(bdev);
+	blkdev_put(bdev);
 }
 
 void md_autodetect_dev(dev_t dev);
Index: linux-2.6-mm/fs/block_dev.c
===================================================================
--- linux-2.6-mm.orig/fs/block_dev.c
+++ linux-2.6-mm/fs/block_dev.c
@@ -751,7 +751,7 @@ static int bd_claim_by_kobject(struct bl
 	if (!bo)
 		return -ENOMEM;
 
-	mutex_lock_nested(&bdev->bd_mutex, BD_MUTEX_PARTITION);
+	mutex_lock(&bdev->bd_mutex);
 	res = bd_claim(bdev, holder);
 	if (res == 0)
 		res = add_bd_holder(bdev, bo);
@@ -778,7 +778,7 @@ static void bd_release_from_kobject(stru
 	if (!kobj)
 		return;
 
-	mutex_lock_nested(&bdev->bd_mutex, BD_MUTEX_PARTITION);
+	mutex_lock(&bdev->bd_mutex);
 	bd_release(bdev);
 	if ((bo = del_bd_holder(bdev, kobj)))
 		free_bd_holder(bo);
@@ -836,22 +836,6 @@ struct block_device *open_by_devnum(dev_
 
 EXPORT_SYMBOL(open_by_devnum);
 
-static int
-blkdev_get_partition(struct block_device *bdev, mode_t mode, unsigned flags);
-
-struct block_device *open_partition_by_devnum(dev_t dev, unsigned mode)
-{
-	struct block_device *bdev = bdget(dev);
-	int err = -ENOMEM;
-	int flags = mode & FMODE_WRITE ? O_RDWR : O_RDONLY;
-	if (bdev)
-		err = blkdev_get_partition(bdev, mode, flags);
-	return err ? ERR_PTR(err) : bdev;
-}
-
-EXPORT_SYMBOL(open_partition_by_devnum);
-
-
 /*
  * This routine checks whether a removable media has been changed,
  * and invalidates all buffer-cache-entries in that case. This
@@ -902,66 +886,7 @@ void bd_set_size(struct block_device *bd
 }
 EXPORT_SYMBOL(bd_set_size);
 
-static int __blkdev_put(struct block_device *bdev, unsigned int subclass)
-{
-	int ret = 0;
-	struct inode *bd_inode = bdev->bd_inode;
-	struct gendisk *disk = bdev->bd_disk;
-
-	mutex_lock_nested(&bdev->bd_mutex, subclass);
-	lock_kernel();
-	if (!--bdev->bd_openers) {
-		sync_blockdev(bdev);
-		kill_bdev(bdev);
-	}
-	if (bdev->bd_contains == bdev) {
-		if (disk->fops->release)
-			ret = disk->fops->release(bd_inode, NULL);
-	} else {
-		mutex_lock_nested(&bdev->bd_contains->bd_mutex,
-				  subclass + 1);
-		bdev->bd_contains->bd_part_count--;
-		mutex_unlock(&bdev->bd_contains->bd_mutex);
-	}
-	if (!bdev->bd_openers) {
-		struct module *owner = disk->fops->owner;
-
-		put_disk(disk);
-		module_put(owner);
-
-		if (bdev->bd_contains != bdev) {
-			kobject_put(&bdev->bd_part->kobj);
-			bdev->bd_part = NULL;
-		}
-		bdev->bd_disk = NULL;
-		bdev->bd_inode->i_data.backing_dev_info = &default_backing_dev_info;
-		if (bdev != bdev->bd_contains)
-			__blkdev_put(bdev->bd_contains, subclass + 1);
-		bdev->bd_contains = NULL;
-	}
-	unlock_kernel();
-	mutex_unlock(&bdev->bd_mutex);
-	bdput(bdev);
-	return ret;
-}
-
-int blkdev_put(struct block_device *bdev)
-{
-	return __blkdev_put(bdev, BD_MUTEX_NORMAL);
-}
-EXPORT_SYMBOL(blkdev_put);
-
-int blkdev_put_partition(struct block_device *bdev)
-{
-	return __blkdev_put(bdev, BD_MUTEX_PARTITION);
-}
-EXPORT_SYMBOL(blkdev_put_partition);
-
-static int
-blkdev_get_whole(struct block_device *bdev, mode_t mode, unsigned flags);
-
-static int
-do_open(struct block_device *bdev, struct file *file, unsigned int subclass)
+static int do_open(struct block_device *bdev, struct file *file)
 {
 	struct module *owner = NULL;
 	struct gendisk *disk;
@@ -978,8 +903,7 @@ do_open(struct block_device *bdev, struc
 	}
 	owner = disk->fops->owner;
 
-	mutex_lock_nested(&bdev->bd_mutex, subclass);
-
+	mutex_lock(&bdev->bd_mutex);
 	if (!bdev->bd_openers) {
 		bdev->bd_disk = disk;
 		bdev->bd_contains = bdev;
@@ -1006,11 +930,11 @@ do_open(struct block_device *bdev, struc
 			ret = -ENOMEM;
 			if (!whole)
 				goto out_first;
-			ret = blkdev_get_whole(whole, file->f_mode, file->f_flags);
+			ret = blkdev_get(whole, file->f_mode, file->f_flags);
 			if (ret)
 				goto out_first;
 			bdev->bd_contains = whole;
-			mutex_lock_nested(&whole->bd_mutex, BD_MUTEX_WHOLE);
+			mutex_lock(&whole->bd_mutex);
 			whole->bd_part_count++;
 			p = disk->part[part - 1];
 			bdev->bd_inode->i_data.backing_dev_info =
@@ -1038,8 +962,7 @@ do_open(struct block_device *bdev, struc
 			if (bdev->bd_invalidated)
 				rescan_partitions(bdev->bd_disk, bdev);
 		} else {
-			mutex_lock_nested(&bdev->bd_contains->bd_mutex,
-					  BD_MUTEX_WHOLE);
+			mutex_lock(&bdev->bd_contains->bd_mutex);
 			bdev->bd_contains->bd_part_count++;
 			mutex_unlock(&bdev->bd_contains->bd_mutex);
 		}
@@ -1053,7 +976,7 @@ out_first:
 	bdev->bd_disk = NULL;
 	bdev->bd_inode->i_data.backing_dev_info = &default_backing_dev_info;
 	if (bdev != bdev->bd_contains)
-		__blkdev_put(bdev->bd_contains, BD_MUTEX_WHOLE);
+		blkdev_put(bdev->bd_contains);
 	bdev->bd_contains = NULL;
 	put_disk(disk);
 	module_put(owner);
@@ -1080,49 +1003,11 @@ int blkdev_get(struct block_device *bdev
 	fake_file.f_dentry = &fake_dentry;
 	fake_dentry.d_inode = bdev->bd_inode;
 
-	return do_open(bdev, &fake_file, BD_MUTEX_NORMAL);
+	return do_open(bdev, &fake_file);
 }
 
 EXPORT_SYMBOL(blkdev_get);
 
-static int
-blkdev_get_whole(struct block_device *bdev, mode_t mode, unsigned flags)
-{
-	/*
-	 * This crockload is due to bad choice of ->open() type.
-	 * It will go away.
-	 * For now, block device ->open() routine must _not_
-	 * examine anything in 'inode' argument except ->i_rdev.
-	 */
-	struct file fake_file = {};
-	struct dentry fake_dentry = {};
-	fake_file.f_mode = mode;
-	fake_file.f_flags = flags;
-	fake_file.f_dentry = &fake_dentry;
-	fake_dentry.d_inode = bdev->bd_inode;
-
-	return do_open(bdev, &fake_file, BD_MUTEX_WHOLE);
-}
-
-static int
-blkdev_get_partition(struct block_device *bdev, mode_t mode, unsigned flags)
-{
-	/*
-	 * This crockload is due to bad choice of ->open() type.
-	 * It will go away.
-	 * For now, block device ->open() routine must _not_
-	 * examine anything in 'inode' argument except ->i_rdev.
-	 */
-	struct file fake_file = {};
-	struct dentry fake_dentry = {};
-	fake_file.f_mode = mode;
-	fake_file.f_flags = flags;
-	fake_file.f_dentry = &fake_dentry;
-	fake_dentry.d_inode = bdev->bd_inode;
-
-	return do_open(bdev, &fake_file, BD_MUTEX_PARTITION);
-}
-
 static int blkdev_open(struct inode * inode, struct file * filp)
 {
 	struct block_device *bdev;
@@ -1138,7 +1023,7 @@ static int blkdev_open(struct inode * in
 
 	bdev = bd_acquire(inode);
 
-	res = do_open(bdev, filp, BD_MUTEX_NORMAL);
+	res = do_open(bdev, filp);
 	if (res)
 		return res;
 
@@ -1152,6 +1037,51 @@ static int blkdev_open(struct inode * in
 	return res;
 }
 
+int blkdev_put(struct block_device *bdev)
+{
+	int ret = 0;
+	struct inode *bd_inode = bdev->bd_inode;
+	struct gendisk *disk = bdev->bd_disk;
+
+	mutex_lock(&bdev->bd_mutex);
+	lock_kernel();
+	if (!--bdev->bd_openers) {
+		sync_blockdev(bdev);
+		kill_bdev(bdev);
+	}
+	if (bdev->bd_contains == bdev) {
+		if (disk->fops->release)
+			ret = disk->fops->release(bd_inode, NULL);
+	} else {
+		mutex_lock(&bdev->bd_contains->bd_mutex);
+		bdev->bd_contains->bd_part_count--;
+		mutex_unlock(&bdev->bd_contains->bd_mutex);
+	}
+	if (!bdev->bd_openers) {
+		struct module *owner = disk->fops->owner;
+
+		put_disk(disk);
+		module_put(owner);
+
+		if (bdev->bd_contains != bdev) {
+			kobject_put(&bdev->bd_part->kobj);
+			bdev->bd_part = NULL;
+		}
+		bdev->bd_disk = NULL;
+		bdev->bd_inode->i_data.backing_dev_info = &default_backing_dev_info;
+		if (bdev != bdev->bd_contains) {
+			blkdev_put(bdev->bd_contains);
+		}
+		bdev->bd_contains = NULL;
+	}
+	unlock_kernel();
+	mutex_unlock(&bdev->bd_mutex);
+	bdput(bdev);
+	return ret;
+}
+
+EXPORT_SYMBOL(blkdev_put);
+
 static int blkdev_close(struct inode * inode, struct file * filp)
 {
 	struct block_device *bdev = I_BDEV(filp->f_mapping->host);
Index: linux-2.6-mm/include/linux/fs.h
===================================================================
--- linux-2.6-mm.orig/include/linux/fs.h
+++ linux-2.6-mm/include/linux/fs.h
@@ -504,21 +504,6 @@ struct block_device {
 };
 
 /*
- * bdev->bd_mutex nesting subclasses for the lock validator:
- *
- * 0: normal
- * 1: 'whole'
- * 2: 'partition'
- */
-enum bdev_bd_mutex_lock_class
-{
-	BD_MUTEX_NORMAL,
-	BD_MUTEX_WHOLE,
-	BD_MUTEX_PARTITION
-};
-
-
-/*
  * Radix-tree tags, for tagging dirty and writeback pages within the pagecache
  * radix trees
  */
@@ -1596,7 +1581,6 @@ extern void bd_set_size(struct block_dev
 extern void bd_forget(struct inode *inode);
 extern void bdput(struct block_device *);
 extern struct block_device *open_by_devnum(dev_t, unsigned);
-extern struct block_device *open_partition_by_devnum(dev_t, unsigned);
 extern const struct address_space_operations def_blk_aops;
 #else
 static inline void bd_forget(struct inode *inode) {}
@@ -1614,7 +1598,6 @@ extern int blkdev_driver_ioctl(struct in
 extern long compat_blkdev_ioctl(struct file *, unsigned, unsigned long);
 extern int blkdev_get(struct block_device *, mode_t, unsigned);
 extern int blkdev_put(struct block_device *);
-extern int blkdev_put_partition(struct block_device *);
 extern int bd_claim(struct block_device *, void *);
 extern void bd_release(struct block_device *);
 #ifdef CONFIG_SYSFS
Index: linux-2.6-mm/block/ioctl.c
===================================================================
--- linux-2.6-mm.orig/block/ioctl.c
+++ linux-2.6-mm/block/ioctl.c
@@ -72,7 +72,7 @@ static int blkpg_ioctl(struct block_devi
 			bdevp = bdget_disk(disk, part);
 			if (!bdevp)
 				return -ENOMEM;
-			mutex_lock_nested(&bdevp->bd_mutex, BD_MUTEX_PARTITION);
+			mutex_lock(&bdevp->bd_mutex);
 			if (bdevp->bd_openers) {
 				mutex_unlock(&bdevp->bd_mutex);
 				bdput(bdevp);
@@ -82,7 +82,7 @@ static int blkpg_ioctl(struct block_devi
 			fsync_bdev(bdevp);
 			invalidate_bdev(bdevp, 0);
 
-			mutex_lock_nested(&bdev->bd_mutex, BD_MUTEX_WHOLE);
+			mutex_lock(&bdev->bd_mutex);
 			delete_partition(disk, part);
 			mutex_unlock(&bdev->bd_mutex);
 			mutex_unlock(&bdevp->bd_mutex);

--

