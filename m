Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268897AbRH0Uku>; Mon, 27 Aug 2001 16:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268861AbRH0Ukk>; Mon, 27 Aug 2001 16:40:40 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:41433 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S268908AbRH0Ukh>;
	Mon, 27 Aug 2001 16:40:37 -0400
Date: Mon, 27 Aug 2001 16:40:50 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] removal of bogus fsync_dev() calls
In-Reply-To: <Pine.LNX.4.33.0108271323290.5985-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0108271638180.29700-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Patch below removes bogus fsync_dev() calls from ->release() instances
and converts dasd.c to use of invalidate_device().  Please, apply.

diff -urN S10-pre1/drivers/i2o/i2o_block.c S10-pre1-sync/drivers/i2o/i2o_block.c
--- S10-pre1/drivers/i2o/i2o_block.c	Thu Aug 16 20:05:47 2001
+++ S10-pre1-sync/drivers/i2o/i2o_block.c	Mon Aug 27 16:36:41 2001
@@ -1195,9 +1195,6 @@
 	if(!dev->i2odev)
 		return 0;
 
-	/* Sync the device so we don't get errors */
-	fsync_dev(inode->i_rdev);
-
 	if (dev->refcnt <= 0)
 		printk(KERN_ALERT "i2ob_release: refcount(%d) <= 0\n", dev->refcnt);
 	dev->refcnt--;
diff -urN S10-pre1/drivers/md/lvm.c S10-pre1-sync/drivers/md/lvm.c
--- S10-pre1/drivers/md/lvm.c	Sun Jul 29 01:54:43 2001
+++ S10-pre1-sync/drivers/md/lvm.c	Mon Aug 27 16:36:41 2001
@@ -1059,7 +1059,6 @@
 	       lvm_name, minor, VG_BLK(minor), LV_BLK(minor));
 #endif
 
-	sync_dev(inode->i_rdev);
 	if (lv_ptr->lv_open == 1) vg_ptr->lv_open--;
 	lv_ptr->lv_open--;
 
diff -urN S10-pre1/drivers/s390/block/dasd.c S10-pre1-sync/drivers/s390/block/dasd.c
--- S10-pre1/drivers/s390/block/dasd.c	Sat Aug 11 14:59:23 2001
+++ S10-pre1-sync/drivers/s390/block/dasd.c	Mon Aug 27 16:36:41 2001
@@ -2140,13 +2140,7 @@
 	}
 	for (i = (1 << DASD_PARTN_BITS) - 1; i >= 0; i--) {
                 int major = device->major_info->gendisk.major;
-		int minor = start + i;
-		kdev_t devi = MKDEV (major, minor);
-		struct super_block *sb = get_super (devi);
-		sync_dev (devi);
-		if (sb)
-			invalidate_inodes (sb);
-		invalidate_buffers (devi);
+		invalidate_device(MKDEV (major, start+i), 1);
 	}
         dasd_destroy_partitions(device);
         dasd_setup_partitions(device);
@@ -2517,7 +2511,6 @@
 		rc = -ENODEV;
                 goto out;
 	}
-	fsync_dev (inp->i_rdev);	/* sync the device */
         count = atomic_dec_return (&device->open_count);
         if ( count == 0) {
                 invalidate_buffers (inp->i_rdev);
diff -urN S10-pre1/drivers/s390/block/xpram.c S10-pre1-sync/drivers/s390/block/xpram.c
--- S10-pre1/drivers/s390/block/xpram.c	Sat Aug 11 14:59:23 2001
+++ S10-pre1-sync/drivers/s390/block/xpram.c	Mon Aug 27 16:36:41 2001
@@ -625,8 +625,7 @@
 	 */
 	if (!atomic_dec_return(&(dev->usage))) {
 		/* but flush it right now */
-		fsync_dev(inode->i_rdev);
-		invalidate_buffers(inode->i_rdev);
+		/* Everything is already flushed by caller -- AV */
 	}
 	MOD_DEC_USE_COUNT;
 	return(0);
diff -urN S10-pre1/drivers/scsi/sr.c S10-pre1-sync/drivers/scsi/sr.c
--- S10-pre1/drivers/scsi/sr.c	Sun Jul 29 01:54:47 2001
+++ S10-pre1-sync/drivers/scsi/sr.c	Mon Aug 27 16:36:41 2001
@@ -101,7 +101,6 @@
 {
 	if (scsi_CDs[MINOR(cdi->dev)].device->sector_size > 2048)
 		sr_set_blocklength(MINOR(cdi->dev), 2048);
-	sync_dev(cdi->dev);
 	scsi_CDs[MINOR(cdi->dev)].device->access_count--;
 	if (scsi_CDs[MINOR(cdi->dev)].device->host->hostt->module)
 		__MOD_DEC_USE_COUNT(scsi_CDs[MINOR(cdi->dev)].device->host->hostt->module);


