Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315287AbSGEEpU>; Fri, 5 Jul 2002 00:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315293AbSGEEpT>; Fri, 5 Jul 2002 00:45:19 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:18561 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315287AbSGEEpS>;
	Fri, 5 Jul 2002 00:45:18 -0400
Date: Fri, 5 Jul 2002 00:47:51 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kdev_t crapectomy
Message-ID: <Pine.GSO.4.21.0207050042270.14718-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	* since the last caller of is_read_only() is gone, the function
itself is removed.
	* destroy_buffers() is not used anymore; gone.
	* fsync_dev() is gone; the only user is (broken) lvm.c and first
step in fixing lvm.c will consist of propagating struct block_device *
anyway; at that point we'll just use fsync_bdev() in there.
	* prototype of bio_ioctl() removed - function doesn't exist
anymore.

diff -urN C24-0/Documentation/filesystems/porting C24-current/Documentation/filesystems/porting
--- C24-0/Documentation/filesystems/porting	Thu Jun 20 13:37:23 2002
+++ C24-current/Documentation/filesystems/porting	Sat Jun 22 20:38:52 2002
@@ -228,3 +228,21 @@
 	Use bdev_read_only(bdev) instead of is_read_only(kdev).  The latter
 is still alive, but only because of the mess in drivers/s390/block/dasd.c.
 As soon as it gets fixed is_read_only() will die.
+
+---
+[mandatory]
+
+	is_read_only() is gone; use bdev_read_only() instead.
+
+---
+[mandatory]
+
+	destroy_buffers() is gone; use invalidate_bdev().
+
+---
+[mandatory]
+
+	fsync_dev() is gone; use fsync_bdev().  NOTE: lvm breakage is
+deliberate; as soon as struct block_device * is propagated in a reasonable
+way by that code fixing will become trivial; until then nothing can be
+done.
diff -urN C24-0/drivers/block/ll_rw_blk.c C24-current/drivers/block/ll_rw_blk.c
--- C24-0/drivers/block/ll_rw_blk.c	Thu Jun 20 13:37:24 2002
+++ C24-current/drivers/block/ll_rw_blk.c	Sat Jun 22 20:34:24 2002
@@ -1212,19 +1212,17 @@
 
 static long ro_bits[MAX_BLKDEV][8];
 
-int is_read_only(kdev_t dev)
+int bdev_read_only(struct block_device *bdev)
 {
 	int minor,major;
 
-	major = major(dev);
-	minor = minor(dev);
-	if (major < 0 || major >= MAX_BLKDEV) return 0;
+	if (!bdev)
+		return 0;
+	major = MAJOR(bdev->bd_dev);
+	minor = MINOR(bdev->bd_dev);
+	if (major < 0 || major >= MAX_BLKDEV)
+		return 0;
 	return ro_bits[major][minor >> 5] & (1 << (minor & 31));
-}
-
-int bdev_read_only(struct block_device *bdev)
-{
-	return bdev && is_read_only(to_kdev_t(bdev->bd_dev));
 }
 
 void set_device_ro(kdev_t dev,int flag)
diff -urN C24-0/fs/buffer.c C24-current/fs/buffer.c
--- C24-0/fs/buffer.c	Thu Jun 20 13:37:24 2002
+++ C24-current/fs/buffer.c	Sat Jun 22 20:36:37 2002
@@ -244,22 +244,6 @@
 }
 
 /*
- * Write out and wait upon all dirty data associated with this
- * kdev_t.   Filesystem data as well as the underlying block
- * device.  Takes the superblock lock.
- */
-int fsync_dev(kdev_t dev)
-{
-	struct block_device *bdev = bdget(kdev_t_to_nr(dev));
-	if (bdev) {
-		int res = fsync_bdev(bdev);
-		bdput(bdev);
-		return res;
-	}
-	return 0;
-}
-
-/*
  * sync everything.
  */
 asmlinkage long sys_sync(void)
diff -urN C24-0/include/linux/bio.h C24-current/include/linux/bio.h
--- C24-0/include/linux/bio.h	Thu Jun 20 13:37:25 2002
+++ C24-current/include/linux/bio.h	Sat Jun 22 20:47:32 2002
@@ -203,8 +203,6 @@
 
 extern inline void bio_init(struct bio *);
 
-extern int bio_ioctl(kdev_t, unsigned int, unsigned long);
-
 #ifdef CONFIG_HIGHMEM
 /*
  * remember to add offset! and never ever reenable interrupts between a
diff -urN C24-0/include/linux/buffer_head.h C24-current/include/linux/buffer_head.h
--- C24-0/include/linux/buffer_head.h	Thu Jun 20 13:37:25 2002
+++ C24-current/include/linux/buffer_head.h	Sat Jun 22 20:36:56 2002
@@ -121,7 +121,6 @@
 #define page_has_buffers(page)	PagePrivate(page)
 
 #define invalidate_buffers(dev)	__invalidate_buffers((dev), 0)
-#define destroy_buffers(dev)	__invalidate_buffers((dev), 1)
 
 
 /*
@@ -156,7 +155,6 @@
 void __wait_on_buffer(struct buffer_head *);
 void sleep_on_buffer(struct buffer_head *bh);
 void wake_up_buffer(struct buffer_head *bh);
-int fsync_dev(kdev_t);
 int fsync_bdev(struct block_device *);
 int fsync_super(struct super_block *);
 int fsync_no_super(struct block_device *);
diff -urN C24-0/include/linux/fs.h C24-current/include/linux/fs.h
--- C24-0/include/linux/fs.h	Thu Jun 20 13:37:25 2002
+++ C24-current/include/linux/fs.h	Sat Jun 22 20:34:32 2002
@@ -1220,7 +1220,6 @@
 extern int submit_bh(int, struct buffer_head *);
 struct bio;
 extern int submit_bio(int, struct bio *);
-extern int is_read_only(kdev_t);
 extern int bdev_read_only(struct block_device *);
 extern int set_blocksize(struct block_device *, int);
 extern int sb_set_blocksize(struct super_block *, int);
diff -urN C24-0/kernel/ksyms.c C24-current/kernel/ksyms.c
--- C24-0/kernel/ksyms.c	Thu Jun 20 20:28:00 2002
+++ C24-current/kernel/ksyms.c	Sat Jun 22 20:37:00 2002
@@ -185,7 +185,6 @@
 EXPORT_SYMBOL(invalidate_device);
 EXPORT_SYMBOL(invalidate_inode_pages);
 EXPORT_SYMBOL(truncate_inode_pages);
-EXPORT_SYMBOL(fsync_dev);
 EXPORT_SYMBOL(fsync_bdev);
 EXPORT_SYMBOL(permission);
 EXPORT_SYMBOL(vfs_permission);
@@ -329,7 +328,6 @@
 /* block device driver support */
 EXPORT_SYMBOL(blk_size);
 EXPORT_SYMBOL(blk_dev);
-EXPORT_SYMBOL(is_read_only);
 EXPORT_SYMBOL(bdev_read_only);
 EXPORT_SYMBOL(set_device_ro);
 EXPORT_SYMBOL(bmap);

