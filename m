Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWE2V0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWE2V0A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWE2VZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:25:59 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:4051 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751351AbWE2VZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:25:35 -0400
Date: Mon, 29 May 2006 23:25:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 34/61] lock validator: special locking: bdev
Message-ID: <20060529212554.GH3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

teach special (recursive) locking code to the lock validator. Has no
effect on non-lockdep kernels.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/md/md.c    |    6 +--
 fs/block_dev.c     |  105 ++++++++++++++++++++++++++++++++++++++++++++++-------
 include/linux/fs.h |   17 ++++++++
 3 files changed, 112 insertions(+), 16 deletions(-)

Index: linux/drivers/md/md.c
===================================================================
--- linux.orig/drivers/md/md.c
+++ linux/drivers/md/md.c
@@ -1394,7 +1394,7 @@ static int lock_rdev(mdk_rdev_t *rdev, d
 	struct block_device *bdev;
 	char b[BDEVNAME_SIZE];
 
-	bdev = open_by_devnum(dev, FMODE_READ|FMODE_WRITE);
+	bdev = open_partition_by_devnum(dev, FMODE_READ|FMODE_WRITE);
 	if (IS_ERR(bdev)) {
 		printk(KERN_ERR "md: could not open %s.\n",
 			__bdevname(dev, b));
@@ -1404,7 +1404,7 @@ static int lock_rdev(mdk_rdev_t *rdev, d
 	if (err) {
 		printk(KERN_ERR "md: could not bd_claim %s.\n",
 			bdevname(bdev, b));
-		blkdev_put(bdev);
+		blkdev_put_partition(bdev);
 		return err;
 	}
 	rdev->bdev = bdev;
@@ -1418,7 +1418,7 @@ static void unlock_rdev(mdk_rdev_t *rdev
 	if (!bdev)
 		MD_BUG();
 	bd_release(bdev);
-	blkdev_put(bdev);
+	blkdev_put_partition(bdev);
 }
 
 void md_autodetect_dev(dev_t dev);
Index: linux/fs/block_dev.c
===================================================================
--- linux.orig/fs/block_dev.c
+++ linux/fs/block_dev.c
@@ -746,7 +746,7 @@ static int bd_claim_by_kobject(struct bl
 	if (!bo)
 		return -ENOMEM;
 
-	mutex_lock(&bdev->bd_mutex);
+	mutex_lock_nested(&bdev->bd_mutex, BD_MUTEX_PARTITION);
 	res = bd_claim(bdev, holder);
 	if (res || !add_bd_holder(bdev, bo))
 		free_bd_holder(bo);
@@ -771,7 +771,7 @@ static void bd_release_from_kobject(stru
 	if (!kobj)
 		return;
 
-	mutex_lock(&bdev->bd_mutex);
+	mutex_lock_nested(&bdev->bd_mutex, BD_MUTEX_PARTITION);
 	bd_release(bdev);
 	if ((bo = del_bd_holder(bdev, kobj)))
 		free_bd_holder(bo);
@@ -829,6 +829,22 @@ struct block_device *open_by_devnum(dev_
 
 EXPORT_SYMBOL(open_by_devnum);
 
+static int
+blkdev_get_partition(struct block_device *bdev, mode_t mode, unsigned flags);
+
+struct block_device *open_partition_by_devnum(dev_t dev, unsigned mode)
+{
+	struct block_device *bdev = bdget(dev);
+	int err = -ENOMEM;
+	int flags = mode & FMODE_WRITE ? O_RDWR : O_RDONLY;
+	if (bdev)
+		err = blkdev_get_partition(bdev, mode, flags);
+	return err ? ERR_PTR(err) : bdev;
+}
+
+EXPORT_SYMBOL(open_partition_by_devnum);
+
+
 /*
  * This routine checks whether a removable media has been changed,
  * and invalidates all buffer-cache-entries in that case. This
@@ -875,7 +891,11 @@ void bd_set_size(struct block_device *bd
 }
 EXPORT_SYMBOL(bd_set_size);
 
-static int do_open(struct block_device *bdev, struct file *file)
+static int
+blkdev_get_whole(struct block_device *bdev, mode_t mode, unsigned flags);
+
+static int
+do_open(struct block_device *bdev, struct file *file, unsigned int subtype)
 {
 	struct module *owner = NULL;
 	struct gendisk *disk;
@@ -892,7 +912,8 @@ static int do_open(struct block_device *
 	}
 	owner = disk->fops->owner;
 
-	mutex_lock(&bdev->bd_mutex);
+	mutex_lock_nested(&bdev->bd_mutex, subtype);
+
 	if (!bdev->bd_openers) {
 		bdev->bd_disk = disk;
 		bdev->bd_contains = bdev;
@@ -917,13 +938,17 @@ static int do_open(struct block_device *
 			struct block_device *whole;
 			whole = bdget_disk(disk, 0);
 			ret = -ENOMEM;
+			/*
+			 * We must not recurse deeper than 1:
+			 */
+			WARN_ON(subtype != 0);
 			if (!whole)
 				goto out_first;
-			ret = blkdev_get(whole, file->f_mode, file->f_flags);
+			ret = blkdev_get_whole(whole, file->f_mode, file->f_flags);
 			if (ret)
 				goto out_first;
 			bdev->bd_contains = whole;
-			mutex_lock(&whole->bd_mutex);
+			mutex_lock_nested(&whole->bd_mutex, BD_MUTEX_WHOLE);
 			whole->bd_part_count++;
 			p = disk->part[part - 1];
 			bdev->bd_inode->i_data.backing_dev_info =
@@ -951,7 +976,8 @@ static int do_open(struct block_device *
 			if (bdev->bd_invalidated)
 				rescan_partitions(bdev->bd_disk, bdev);
 		} else {
-			mutex_lock(&bdev->bd_contains->bd_mutex);
+			mutex_lock_nested(&bdev->bd_contains->bd_mutex,
+					  BD_MUTEX_PARTITION);
 			bdev->bd_contains->bd_part_count++;
 			mutex_unlock(&bdev->bd_contains->bd_mutex);
 		}
@@ -992,11 +1018,49 @@ int blkdev_get(struct block_device *bdev
 	fake_file.f_dentry = &fake_dentry;
 	fake_dentry.d_inode = bdev->bd_inode;
 
-	return do_open(bdev, &fake_file);
+	return do_open(bdev, &fake_file, BD_MUTEX_NORMAL);
 }
 
 EXPORT_SYMBOL(blkdev_get);
 
+static int
+blkdev_get_whole(struct block_device *bdev, mode_t mode, unsigned flags)
+{
+	/*
+	 * This crockload is due to bad choice of ->open() type.
+	 * It will go away.
+	 * For now, block device ->open() routine must _not_
+	 * examine anything in 'inode' argument except ->i_rdev.
+	 */
+	struct file fake_file = {};
+	struct dentry fake_dentry = {};
+	fake_file.f_mode = mode;
+	fake_file.f_flags = flags;
+	fake_file.f_dentry = &fake_dentry;
+	fake_dentry.d_inode = bdev->bd_inode;
+
+	return do_open(bdev, &fake_file, BD_MUTEX_WHOLE);
+}
+
+static int
+blkdev_get_partition(struct block_device *bdev, mode_t mode, unsigned flags)
+{
+	/*
+	 * This crockload is due to bad choice of ->open() type.
+	 * It will go away.
+	 * For now, block device ->open() routine must _not_
+	 * examine anything in 'inode' argument except ->i_rdev.
+	 */
+	struct file fake_file = {};
+	struct dentry fake_dentry = {};
+	fake_file.f_mode = mode;
+	fake_file.f_flags = flags;
+	fake_file.f_dentry = &fake_dentry;
+	fake_dentry.d_inode = bdev->bd_inode;
+
+	return do_open(bdev, &fake_file, BD_MUTEX_PARTITION);
+}
+
 static int blkdev_open(struct inode * inode, struct file * filp)
 {
 	struct block_device *bdev;
@@ -1012,7 +1076,7 @@ static int blkdev_open(struct inode * in
 
 	bdev = bd_acquire(inode);
 
-	res = do_open(bdev, filp);
+	res = do_open(bdev, filp, BD_MUTEX_NORMAL);
 	if (res)
 		return res;
 
@@ -1026,13 +1090,13 @@ static int blkdev_open(struct inode * in
 	return res;
 }
 
-int blkdev_put(struct block_device *bdev)
+static int __blkdev_put(struct block_device *bdev, unsigned int subtype)
 {
 	int ret = 0;
 	struct inode *bd_inode = bdev->bd_inode;
 	struct gendisk *disk = bdev->bd_disk;
 
-	mutex_lock(&bdev->bd_mutex);
+	mutex_lock_nested(&bdev->bd_mutex, subtype);
 	lock_kernel();
 	if (!--bdev->bd_openers) {
 		sync_blockdev(bdev);
@@ -1042,7 +1106,9 @@ int blkdev_put(struct block_device *bdev
 		if (disk->fops->release)
 			ret = disk->fops->release(bd_inode, NULL);
 	} else {
-		mutex_lock(&bdev->bd_contains->bd_mutex);
+		WARN_ON(subtype != 0);
+		mutex_lock_nested(&bdev->bd_contains->bd_mutex,
+				  BD_MUTEX_PARTITION);
 		bdev->bd_contains->bd_part_count--;
 		mutex_unlock(&bdev->bd_contains->bd_mutex);
 	}
@@ -1059,7 +1125,8 @@ int blkdev_put(struct block_device *bdev
 		bdev->bd_disk = NULL;
 		bdev->bd_inode->i_data.backing_dev_info = &default_backing_dev_info;
 		if (bdev != bdev->bd_contains) {
-			blkdev_put(bdev->bd_contains);
+			WARN_ON(subtype != 0);
+			__blkdev_put(bdev->bd_contains, 1);
 		}
 		bdev->bd_contains = NULL;
 	}
@@ -1069,8 +1136,20 @@ int blkdev_put(struct block_device *bdev
 	return ret;
 }
 
+int blkdev_put(struct block_device *bdev)
+{
+	return __blkdev_put(bdev, BD_MUTEX_NORMAL);
+}
+
 EXPORT_SYMBOL(blkdev_put);
 
+int blkdev_put_partition(struct block_device *bdev)
+{
+	return __blkdev_put(bdev, BD_MUTEX_PARTITION);
+}
+
+EXPORT_SYMBOL(blkdev_put_partition);
+
 static int blkdev_close(struct inode * inode, struct file * filp)
 {
 	struct block_device *bdev = I_BDEV(filp->f_mapping->host);
Index: linux/include/linux/fs.h
===================================================================
--- linux.orig/include/linux/fs.h
+++ linux/include/linux/fs.h
@@ -436,6 +436,21 @@ struct block_device {
 };
 
 /*
+ * bdev->bd_mutex nesting types for the LOCKDEP validator:
+ *
+ * 0: normal
+ * 1: 'whole'
+ * 2: 'partition'
+ */
+enum bdev_bd_mutex_lock_type
+{
+	BD_MUTEX_NORMAL,
+	BD_MUTEX_WHOLE,
+	BD_MUTEX_PARTITION
+};
+
+
+/*
  * Radix-tree tags, for tagging dirty and writeback pages within the pagecache
  * radix trees
  */
@@ -1404,6 +1419,7 @@ extern void bd_set_size(struct block_dev
 extern void bd_forget(struct inode *inode);
 extern void bdput(struct block_device *);
 extern struct block_device *open_by_devnum(dev_t, unsigned);
+extern struct block_device *open_partition_by_devnum(dev_t, unsigned);
 extern const struct file_operations def_blk_fops;
 extern const struct address_space_operations def_blk_aops;
 extern const struct file_operations def_chr_fops;
@@ -1414,6 +1430,7 @@ extern int blkdev_ioctl(struct inode *, 
 extern long compat_blkdev_ioctl(struct file *, unsigned, unsigned long);
 extern int blkdev_get(struct block_device *, mode_t, unsigned);
 extern int blkdev_put(struct block_device *);
+extern int blkdev_put_partition(struct block_device *);
 extern int bd_claim(struct block_device *, void *);
 extern void bd_release(struct block_device *);
 #ifdef CONFIG_SYSFS
