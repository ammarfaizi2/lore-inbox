Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271200AbRICDyP>; Sun, 2 Sep 2001 23:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271186AbRICDyF>; Sun, 2 Sep 2001 23:54:05 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:56749 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S271200AbRICDxp>;
	Sun, 2 Sep 2001 23:53:45 -0400
Date: Sun, 2 Sep 2001 23:54:04 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix for inode leak in rd.c
Message-ID: <Pine.GSO.4.21.0109022353420.22951-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Patch removes inode leak in drivers/block/rd.c. Instead of
grabbing an extra reference to inode upon the first open() we pin
down struct block_device - the real object we want to protect.
	Please, apply.


diff -urN S10-pre4/drivers/block/rd.c S10-pre4-rd/drivers/block/rd.c
--- S10-pre4/drivers/block/rd.c	Sun Jul 29 01:54:42 2001
+++ S10-pre4-rd/drivers/block/rd.c	Sun Sep  2 23:35:46 2001
@@ -100,7 +100,7 @@
 static int rd_blocksizes[NUM_RAMDISKS];		/* Size of 1024 byte blocks :)  */
 static int rd_kbsize[NUM_RAMDISKS];		/* Size in blocks of 1024 bytes */
 static devfs_handle_t devfs_handle;
-static struct inode *rd_inode[NUM_RAMDISKS];	/* Protected device inodes */
+static struct block_device *rd_bdev[NUM_RAMDISKS];/* Protected device data */
 
 /*
  * Parameters for the boot-loading of the RAM disk.  These are set by
@@ -259,7 +259,7 @@
 			/* special: we want to release the ramdisk memory,
 			   it's not like with the other blockdevices where
 			   this ioctl only flushes away the buffer cache. */
-			if ((atomic_read(&inode->i_bdev->bd_openers) > 2))
+			if ((atomic_read(rd_bdev[minor]->bd_openers) > 2))
 				return -EBUSY;
 			destroy_buffers(inode->i_rdev);
 			rd_blocksizes[minor] = 0;
@@ -305,7 +305,6 @@
 	lock_kernel();
 	if (!--initrd_users) {
 		blkdev_put(inode->i_bdev, BDEV_FILE);
-		iput(inode);
 		free_initrd_mem(initrd_start, initrd_end);
 		initrd_start = 0;
 	}
@@ -324,8 +323,10 @@
 
 static int rd_open(struct inode * inode, struct file * filp)
 {
+	int unit = DEVICE_NR(inode->i_rdev);
+
 #ifdef CONFIG_BLK_DEV_INITRD
-	if (DEVICE_NR(inode->i_rdev) == INITRD_MINOR) {
+	if (unit == INITRD_MINOR) {
 		if (!initrd_start) return -ENODEV;
 		initrd_users++;
 		filp->f_op = &initrd_fops;
@@ -333,16 +334,15 @@
 	}
 #endif
 
-	if (DEVICE_NR(inode->i_rdev) >= NUM_RAMDISKS)
+	if (unit >= NUM_RAMDISKS)
 		return -ENXIO;
 
 	/*
 	 * Immunize device against invalidate_buffers() and prune_icache().
 	 */
-	if (rd_inode[DEVICE_NR(inode->i_rdev)] == NULL) {
-		if (!inode->i_bdev) return -ENXIO;
-		if ((rd_inode[DEVICE_NR(inode->i_rdev)] = igrab(inode)) != NULL)
-			atomic_inc(&rd_inode[DEVICE_NR(inode->i_rdev)]->i_bdev->bd_openers);
+	if (rd_bdev[unit] == NULL) {
+		rd_bdev[unit] = bdget(kdev_t_to_nr(inode->i_rdev));
+		atomic_inc(&rd_bdev[unit]->bd_openers);
 	}
 
 	MOD_INC_USE_COUNT;
@@ -369,12 +369,11 @@
 	int i;
 
 	for (i = 0 ; i < NUM_RAMDISKS; i++) {
-		if (rd_inode[i]) {
-			/* withdraw invalidate_buffers() and prune_icache() immunity */
-			atomic_dec(&rd_inode[i]->i_bdev->bd_openers);
-			/* remove stale pointer to module address space */
-			rd_inode[i]->i_bdev->bd_op = NULL;
-			iput(rd_inode[i]);
+		struct block_device *bdev = rd_bdev[i];
+		rd_bdev[i] = NULL;
+		if (bdev) {
+			blkdev_put(bdev);
+			bdput(bdev);
 		}
 		destroy_buffers(MKDEV(MAJOR_NR, i));
 	}

