Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269872AbRHIXbs>; Thu, 9 Aug 2001 19:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269875AbRHIXbj>; Thu, 9 Aug 2001 19:31:39 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:6568 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269872AbRHIXbY>;
	Thu, 9 Aug 2001 19:31:24 -0400
Date: Thu, 9 Aug 2001 19:31:35 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fs/super.c fixes (3/8)
In-Reply-To: <Pine.GSO.4.21.0108091930490.25945-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0108091931170.25945-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Part 3/8:

blkdev_put(bdev, BDEV_FS) is always called when superblock is already
dead. No point trying to sync fs structures - they are gone at that
point. So instead of fsync_dev() we call fsync_no_super() - fsync_dev()
sans the sync_inodes()/sync_supers() calls. That allows to shift releasing
->s_umount to the very end of kill_super().

diff -urN S8-pre7-s_active/fs/block_dev.c S8-pre7-fsync_no_super/fs/block_dev.c
--- S8-pre7-s_active/fs/block_dev.c	Tue Jul  3 21:09:13 2001
+++ S8-pre7-fsync_no_super/fs/block_dev.c	Thu Aug  9 19:07:31 2001
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
diff -urN S8-pre7-s_active/fs/buffer.c S8-pre7-fsync_no_super/fs/buffer.c
--- S8-pre7-s_active/fs/buffer.c	Wed Aug  8 17:54:55 2001
+++ S8-pre7-fsync_no_super/fs/buffer.c	Thu Aug  9 19:07:31 2001
@@ -346,6 +346,12 @@
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
diff -urN S8-pre7-s_active/fs/super.c S8-pre7-fsync_no_super/fs/super.c
--- S8-pre7-s_active/fs/super.c	Thu Aug  9 19:07:31 2001
+++ S8-pre7-fsync_no_super/fs/super.c	Thu Aug  9 19:07:31 2001
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
diff -urN S8-pre7-s_active/include/linux/fs.h S8-pre7-fsync_no_super/include/linux/fs.h
--- S8-pre7-s_active/include/linux/fs.h	Thu Aug  9 19:07:31 2001
+++ S8-pre7-fsync_no_super/include/linux/fs.h	Thu Aug  9 19:07:31 2001
@@ -1161,6 +1161,7 @@
 extern void sync_dev(kdev_t);
 extern int fsync_dev(kdev_t);
 extern int fsync_super(struct super_block *);
+extern int fsync_no_super(kdev_t);
 extern void sync_inodes_sb(struct super_block *);
 extern int fsync_inode_buffers(struct inode *);
 extern int osync_inode_buffers(struct inode *);


