Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263046AbVCDUWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263046AbVCDUWR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 15:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbVCDUQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 15:16:27 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:39484 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S263092AbVCDUEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:04:46 -0500
Date: Fri, 4 Mar 2005 15:04:45 -0500
From: Jeffrey Mahoney <jeffm@suse.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] blockdev: fixes race between mount/umount
Message-ID: <20050304200445.GA21908@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.111.19-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a race between mount and umount in set_blocksize. The results
can vary between buffer errors and infinite loops in __getblk_slow, and
possibly others.

The patch makes set_blocksize run under the bdev_lock if it is the sole holder
of the block device.

Changes:
    - Added missing sync_blockdev in kill_block_super, lost in the shuffle.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

diff -ruNpX dontdiff linux-2.6.11-rc4.orig/fs/block_dev.c linux-2.6.11-rc4/fs/block_dev.c
--- linux-2.6.11-rc4.orig/fs/block_dev.c	2005-02-28 14:06:59.000000000 -0500
+++ linux-2.6.11-rc4/fs/block_dev.c	2005-02-28 14:49:52.000000000 -0500
@@ -62,7 +62,7 @@ static void kill_bdev(struct block_devic
 	truncate_inode_pages(bdev->bd_inode->i_mapping, 0);
 }	
 
-int set_blocksize(struct block_device *bdev, int size)
+int __set_blocksize(struct block_device *bdev, int size, int sync)
 {
 	/* Size must be a power of two, and between 512 and PAGE_SIZE */
 	if (size > PAGE_SIZE || size < 512 || (size & (size-1)))
@@ -74,7 +74,8 @@ int set_blocksize(struct block_device *b
 
 	/* Don't change the size if it is same as current */
 	if (bdev->bd_block_size != size) {
-		sync_blockdev(bdev);
+		if (sync)
+			sync_blockdev(bdev);
 		bdev->bd_block_size = size;
 		bdev->bd_inode->i_blkbits = blksize_bits(size);
 		kill_bdev(bdev);
@@ -82,7 +83,7 @@ int set_blocksize(struct block_device *b
 	return 0;
 }
 
-EXPORT_SYMBOL(set_blocksize);
+EXPORT_SYMBOL(__set_blocksize);
 
 int sb_set_blocksize(struct super_block *sb, int size)
 {
@@ -480,17 +481,19 @@ int bd_claim(struct block_device *bdev, 
 
 EXPORT_SYMBOL(bd_claim);
 
-void bd_release(struct block_device *bdev)
+void __bd_release(struct block_device *bdev, int size)
 {
 	spin_lock(&bdev_lock);
 	if (!--bdev->bd_contains->bd_holders)
 		bdev->bd_contains->bd_holder = NULL;
-	if (!--bdev->bd_holders)
+	if (!--bdev->bd_holders) {
 		bdev->bd_holder = NULL;
+		set_blocksize_nosync (bdev, size);
+	}
 	spin_unlock(&bdev_lock);
 }
 
-EXPORT_SYMBOL(bd_release);
+EXPORT_SYMBOL(__bd_release);
 
 /*
  * Tries to open block device by device number.  Use it ONLY if you
@@ -914,10 +917,10 @@ EXPORT_SYMBOL(open_bdev_excl);
  *
  * This is the counterpart to open_bdev_excl().
  */
-void close_bdev_excl(struct block_device *bdev)
+void __close_bdev_excl(struct block_device *bdev, int size)
 {
-	bd_release(bdev);
+	__bd_release(bdev, size);
 	blkdev_put(bdev);
 }
 
-EXPORT_SYMBOL(close_bdev_excl);
+EXPORT_SYMBOL(__close_bdev_excl);
diff -ruNpX dontdiff linux-2.6.11-rc4.orig/fs/super.c linux-2.6.11-rc4/fs/super.c
--- linux-2.6.11-rc4.orig/fs/super.c	2005-02-28 14:07:01.000000000 -0500
+++ linux-2.6.11-rc4/fs/super.c	2005-02-28 14:42:49.000000000 -0500
@@ -732,8 +732,8 @@ void kill_block_super(struct super_block
 
 	bdev_uevent(bdev, KOBJ_UMOUNT);
 	generic_shutdown_super(sb);
-	set_blocksize(bdev, sb->s_old_blocksize);
-	close_bdev_excl(bdev);
+	sync_blockdev(bdev);
+	__close_bdev_excl(bdev, sb->s_old_blocksize);
 }
 
 EXPORT_SYMBOL(kill_block_super);
diff -ruNpX dontdiff linux-2.6.11-rc4.orig/include/linux/fs.h linux-2.6.11-rc4/include/linux/fs.h
--- linux-2.6.11-rc4.orig/include/linux/fs.h	2005-02-28 14:07:42.000000000 -0500
+++ linux-2.6.11-rc4/include/linux/fs.h	2005-02-28 14:50:53.000000000 -0500
@@ -1294,7 +1294,10 @@ extern long compat_blkdev_ioctl(struct f
 extern int blkdev_get(struct block_device *, mode_t, unsigned);
 extern int blkdev_put(struct block_device *);
 extern int bd_claim(struct block_device *, void *);
-extern void bd_release(struct block_device *);
+extern void __bd_release(struct block_device *, int);
+static inline void bd_release(struct block_device *bdev) {
+	__bd_release (bdev, bdev->bd_block_size);
+}
 
 /* fs/char_dev.c */
 extern int alloc_chrdev_region(dev_t *, unsigned, unsigned, const char *);
@@ -1311,7 +1314,10 @@ extern const char *__bdevname(dev_t, cha
 extern const char *bdevname(struct block_device *bdev, char *buffer);
 extern struct block_device *lookup_bdev(const char *);
 extern struct block_device *open_bdev_excl(const char *, int, void *);
-extern void close_bdev_excl(struct block_device *);
+extern void __close_bdev_excl(struct block_device *, int);
+static inline void close_bdev_excl(struct block_device *bdev) {
+	__close_bdev_excl(bdev, bdev->bd_block_size);
+}
 
 extern void init_special_inode(struct inode *, umode_t, dev_t);
 
@@ -1447,7 +1453,14 @@ extern void file_kill(struct file *f);
 struct bio;
 extern void submit_bio(int, struct bio *);
 extern int bdev_read_only(struct block_device *);
-extern int set_blocksize(struct block_device *, int);
+extern int __set_blocksize(struct block_device *, int, int);
+static inline int set_blocksize(struct block_device *bdev, int size) {
+	return __set_blocksize (bdev, size, 1);
+}
+static inline int set_blocksize_nosync(struct block_device *bdev, int size) {
+	return __set_blocksize (bdev, size, 0);
+}
+
 extern int sb_set_blocksize(struct super_block *, int);
 extern int sb_min_blocksize(struct super_block *, int);
 
-- 
Jeff Mahoney
SuSE Labs
