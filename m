Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261478AbRETH74>; Sun, 20 May 2001 03:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261480AbRETH7r>; Sun, 20 May 2001 03:59:47 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:16577 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261478AbRETH7i>;
	Sun, 20 May 2001 03:59:38 -0400
Date: Sun, 20 May 2001 03:59:37 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] is_mounted() - getting remnants of get_super() out of drivers.
Message-ID: <Pine.GSO.4.21.0105200356020.7162-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Linus, patch below adds an obvious helper function and converts
several places to using it. For one thing, it's cleaner, for another -
we won't have to change these places when we add refcounting on struct
superblock. Actually, it used be a part of invalidate_device() patch.
Please, apply it.


diff -urN S5-pre4/drivers/block/blkpg.c S5-pre4-is_mounted/drivers/block/blkpg.c
--- S5-pre4/drivers/block/blkpg.c	Fri Feb 16 09:58:32 2001
+++ S5-pre4-is_mounted/drivers/block/blkpg.c	Sun May 20 03:15:57 2001
@@ -157,8 +157,7 @@
 
 	/* partition in use? Incomplete check for now. */
 	devp = MKDEV(MAJOR(dev), minor);
-	if (get_super(devp) ||		/* mounted? */
-	    is_swap_partition(devp))
+	if (is_mounted(devp) || is_swap_partition(devp))
 		return -EBUSY;
 
 	/* all seems OK */
diff -urN S5-pre4/drivers/char/raw.c S5-pre4-is_mounted/drivers/char/raw.c
--- S5-pre4/drivers/char/raw.c	Sat Apr 28 02:12:50 2001
+++ S5-pre4-is_mounted/drivers/char/raw.c	Sun May 20 03:16:12 2001
@@ -131,7 +131,7 @@
 	 */
 	
 	sector_size = 512;
-	if (get_super(rdev) != NULL) {
+	if (is_mounted(rdev)) {
 		if (blksize_size[MAJOR(rdev)])
 			sector_size = blksize_size[MAJOR(rdev)][MINOR(rdev)];
 	} else {
diff -urN S5-pre4/drivers/md/md.c S5-pre4-is_mounted/drivers/md/md.c
--- S5-pre4/drivers/md/md.c	Sat May 19 22:46:31 2001
+++ S5-pre4-is_mounted/drivers/md/md.c	Sun May 20 03:16:38 2001
@@ -1097,7 +1097,7 @@
 	}
 	memset(rdev, 0, sizeof(*rdev));
 
-	if (get_super(newdev)) {
+	if (is_mounted(newdev)) {
 		printk("md: can not import %s, has active inodes!\n",
 			partition_name(newdev));
 		err = -EBUSY;
@@ -1735,7 +1735,7 @@
  	}
  
  	/* this shouldn't be needed as above would have fired */
-	if (!ro && get_super(dev)) {
+	if (!ro && is_mounted(dev)) {
 		printk (STILL_MOUNTED, mdidx(mddev));
 		OUT(-EBUSY);
 	}
diff -urN S5-pre4/include/linux/fs.h S5-pre4-is_mounted/include/linux/fs.h
--- S5-pre4/include/linux/fs.h	Sat May 19 22:46:36 2001
+++ S5-pre4-is_mounted/include/linux/fs.h	Sun May 20 03:18:47 2001
@@ -1301,6 +1301,15 @@
 extern struct file_system_type *get_fs_type(const char *name);
 extern struct super_block *get_super(kdev_t);
 extern void put_super(kdev_t);
+static inline int is_mounted(kdev_t dev)
+{
+	struct super_block *sb = get_super(dev);
+	if (sb) {
+		/* drop_super(sb); will go here */
+		return 1;
+	}
+	return 0;
+}
 unsigned long generate_cluster(kdev_t, int b[], int);
 unsigned long generate_cluster_swab32(kdev_t, int b[], int);
 extern kdev_t ROOT_DEV;

