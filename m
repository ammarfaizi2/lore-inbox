Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263419AbRFKFe3>; Mon, 11 Jun 2001 01:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263421AbRFKFeX>; Mon, 11 Jun 2001 01:34:23 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:7598 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263419AbRFKFeQ>;
	Mon, 11 Jun 2001 01:34:16 -0400
Date: Mon, 11 Jun 2001 01:34:14 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fs/super.c stuff (3/10)
In-Reply-To: <Pine.GSO.4.21.0106110133160.24249-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0106110133500.24249-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN S6-pre2-s_active/fs/block_dev.c S6-pre2-fsync_no_super/fs/block_dev.c
--- S6-pre2-s_active/fs/block_dev.c	Fri Jun  8 18:29:02 2001
+++ S6-pre2-fsync_no_super/fs/block_dev.c	Sun Jun 10 12:13:03 2001
@@ -678,8 +678,10 @@
 	down(&bdev->bd_sem);
 	/* syncing will go here */
 	lock_kernel();
-	if (kind == BDEV_FILE || kind == BDEV_FS)
+	if (kind == BDEV_FILE)
 		fsync_dev(rdev);
+	else if (kind == BDEV_FS)
+		fsync_no_super(rdev);
 	if (atomic_dec_and_test(&bdev->bd_openers)) {
 		/* invalidating buffers will go here */
 		invalidate_buffers(rdev);
diff -urN S6-pre2-s_active/fs/buffer.c S6-pre2-fsync_no_super/fs/buffer.c
--- S6-pre2-s_active/fs/buffer.c	Fri Jun  8 18:29:03 2001
+++ S6-pre2-fsync_no_super/fs/buffer.c	Sun Jun 10 12:13:03 2001
@@ -318,6 +318,12 @@
 	return sync_buffers(dev, 1);
 }
 
+int fsync_no_super(kdev_t dev)
+{
+	sync_buffers(dev, 0);
+	return sync_buffers(dev, 1);
+}
+
 int fsync_dev(kdev_t dev)
 {
 	sync_buffers(dev, 0);
diff -urN S6-pre2-s_active/fs/super.c S6-pre2-fsync_no_super/fs/super.c
--- S6-pre2-s_active/fs/super.c	Sun Jun 10 12:07:40 2001
+++ S6-pre2-fsync_no_super/fs/super.c	Sun Jun 10 12:13:04 2001
@@ -971,12 +971,12 @@
 	sb->s_type = NULL;
 	unlock_super(sb);
 	unlock_kernel();
-	up_write(&sb->s_umount);
 	if (bdev) {
 		blkdev_put(bdev, BDEV_FS);
 		bdput(bdev);
 	} else
 		put_unnamed_dev(dev);
+	up_write(&sb->s_umount);
 }
 
 /*
diff -urN S6-pre2-s_active/include/linux/fs.h S6-pre2-fsync_no_super/include/linux/fs.h
--- S6-pre2-s_active/include/linux/fs.h	Sun Jun 10 11:58:01 2001
+++ S6-pre2-fsync_no_super/include/linux/fs.h	Sun Jun 10 12:13:04 2001
@@ -1122,6 +1122,7 @@
 extern void sync_dev(kdev_t);
 extern int fsync_dev(kdev_t);
 extern int fsync_super(struct super_block *);
+extern int fsync_no_super(kdev_t);
 extern void sync_inodes_sb(struct super_block *);
 extern int fsync_inode_buffers(struct inode *);
 extern int osync_inode_buffers(struct inode *);


