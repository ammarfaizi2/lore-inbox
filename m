Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVCOOPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVCOOPO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 09:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVCOOPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 09:15:14 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:40998 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S261256AbVCOOOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 09:14:50 -0500
Date: Tue, 15 Mar 2005 09:14:49 -0500
From: Jeff Mahoney <jeffm@suse.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH] blockdev: fix for racing mount/umount
Message-ID: <20050315141449.GA13653@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.111.19-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is another take at fixing the race between mount and umount
resetting the blocksize and causing buffer errors, infinite loops in
__getblk_slow, and possibly other undiscovered effects.

It adds possible flags to bd_claim such that the caller can request
exclusive access and/or wait until the device becomes available. Since bd_claim
already allows/denies access based on the holder, the BD_EXCL flag operates
under the assumption that all callers of bd_claim for a particular holder will
use the flag. This is currently true. BD_WAIT places the request on a wait
queue until access can be granted. It uses a global wait queue, which isn't a
contention point since bd_claim/bd_release both operate under the global
bdev_lock anyway.

Filesystems (via get_sb_bdev) now use BD_EXCL|BD_WAIT to ensure the previous
mount has completely shut down and closed the device before re-opening it
for a new mount. 

It's ugly, and I'm open to suggestions, but it seems to be the only way to
stop this race reliably.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

diff -ruNpX dontdiff linux-2.6.11/fs/block_dev.c linux-2.6.11.bs/fs/block_dev.c
--- linux-2.6.11/fs/block_dev.c	2005-03-14 21:25:20.000000000 -0500
+++ linux-2.6.11.bs/fs/block_dev.c	2005-03-14 22:17:16.000000000 -0500
@@ -238,6 +238,7 @@ static int block_fsync(struct file *filp
  */
 
 static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(bdev_lock);
+static DECLARE_WAIT_QUEUE_HEAD(bdev_wq);
 static kmem_cache_t * bdev_cachep;
 
 static struct inode *bdev_alloc_inode(struct super_block *sb)
@@ -443,20 +444,33 @@ void bd_forget(struct inode *inode)
 	spin_unlock(&bdev_lock);
 }
 
-int bd_claim(struct block_device *bdev, void *holder)
+/*
+ * flags:
+ * BD_NONE: No special behavior.
+ * BD_EXCL: Must have sole access to device, even if holder is the same.
+ *          This is really enforced by the holder always using BD_EXCL.
+ * BD_WAIT: Wait until access is available before returning.
+ */
+int __bd_claim(struct block_device *bdev, void *holder, int flags)
 {
 	int res;
+	DEFINE_WAIT (wait);
+
+retry:
 	spin_lock(&bdev_lock);
+	prepare_to_wait (&bdev_wq, &wait, TASK_UNINTERRUPTIBLE);
 
 	/* first decide result */
-	if (bdev->bd_holder == holder)
+	if (bdev->bd_holder == holder) {
 		res = 0;	 /* already a holder */
-	else if (bdev->bd_holder != NULL)
+		if (flags & BD_EXCL)
+			res = -EBUSY;
+	} else if (bdev->bd_holder != NULL)
 		res = -EBUSY; 	 /* held by someone else */
 	else if (bdev->bd_contains == bdev)
 		res = 0;  	 /* is a whole device which isn't held */
 
-	else if (bdev->bd_contains->bd_holder == bd_claim)
+	else if (bdev->bd_contains->bd_holder == __bd_claim)
 		res = 0; 	 /* is a partition of a device that is being partitioned */
 	else if (bdev->bd_contains->bd_holder != NULL)
 		res = -EBUSY;	 /* is a partition of a held device */
@@ -470,15 +484,21 @@ int bd_claim(struct block_device *bdev, 
 		 * be set to bd_claim before being set to holder
 		 */
 		bdev->bd_contains->bd_holders ++;
-		bdev->bd_contains->bd_holder = bd_claim;
+		bdev->bd_contains->bd_holder = __bd_claim;
 		bdev->bd_holders++;
 		bdev->bd_holder = holder;
+	} else if (flags & BD_WAIT) {
+		spin_unlock (&bdev_lock);
+		schedule();
+		goto retry;
 	}
+
+	finish_wait (&bdev_wq, &wait);
 	spin_unlock(&bdev_lock);
 	return res;
 }
 
-EXPORT_SYMBOL(bd_claim);
+EXPORT_SYMBOL(__bd_claim);
 
 void bd_release(struct block_device *bdev)
 {
@@ -488,6 +508,7 @@ void bd_release(struct block_device *bde
 	if (!--bdev->bd_holders)
 		bdev->bd_holder = NULL;
 	spin_unlock(&bdev_lock);
+	wake_up_all (&bdev_wq);
 }
 
 EXPORT_SYMBOL(bd_release);
@@ -876,7 +897,8 @@ fail:
  * Open the blockdevice described by the special file at @path, claim it
  * for the @holder.
  */
-struct block_device *open_bdev_excl(const char *path, int flags, void *holder)
+struct block_device *__open_bdev_excl(const char *path, int flags,
+                                      void *holder, int bdflags)
 {
 	struct block_device *bdev;
 	mode_t mode = FMODE_READ;
@@ -894,7 +916,7 @@ struct block_device *open_bdev_excl(cons
 	error = -EACCES;
 	if (!(flags & MS_RDONLY) && bdev_read_only(bdev))
 		goto blkdev_put;
-	error = bd_claim(bdev, holder);
+	error = __bd_claim(bdev, holder, bdflags);
 	if (error)
 		goto blkdev_put;
 
@@ -905,7 +927,7 @@ blkdev_put:
 	return ERR_PTR(error);
 }
 
-EXPORT_SYMBOL(open_bdev_excl);
+EXPORT_SYMBOL(__open_bdev_excl);
 
 /**
  * close_bdev_excl  -  release a blockdevice openen by open_bdev_excl()
diff -ruNpX dontdiff linux-2.6.11/fs/super.c linux-2.6.11.bs/fs/super.c
--- linux-2.6.11/fs/super.c	2005-03-14 21:25:20.000000000 -0500
+++ linux-2.6.11.bs/fs/super.c	2005-03-14 21:38:22.000000000 -0500
@@ -677,7 +677,7 @@ struct super_block *get_sb_bdev(struct f
 	struct super_block *s;
 	int error = 0;
 
-	bdev = open_bdev_excl(dev_name, flags, fs_type);
+	bdev = __open_bdev_excl(dev_name, flags, fs_type, BD_EXCL|BD_WAIT);
 	if (IS_ERR(bdev))
 		return (struct super_block *)bdev;
 
diff -ruNpX dontdiff linux-2.6.11/include/linux/fs.h linux-2.6.11.bs/include/linux/fs.h
--- linux-2.6.11/include/linux/fs.h	2005-03-14 21:25:20.000000000 -0500
+++ linux-2.6.11.bs/include/linux/fs.h	2005-03-14 21:45:21.000000000 -0500
@@ -1320,7 +1320,14 @@ extern int blkdev_ioctl(struct inode *, 
 extern long compat_blkdev_ioctl(struct file *, unsigned, unsigned long);
 extern int blkdev_get(struct block_device *, mode_t, unsigned);
 extern int blkdev_put(struct block_device *);
-extern int bd_claim(struct block_device *, void *);
+#define BD_NONE 0x0
+#define BD_EXCL 0x1
+#define BD_WAIT 0x2
+extern int __bd_claim(struct block_device *, void *, int);
+static inline int bd_claim(struct block_device *bdev, void *holder)
+{
+	return __bd_claim(bdev, holder, 0);
+}
 extern void bd_release(struct block_device *);
 
 /* fs/char_dev.c */
@@ -1337,6 +1344,11 @@ extern int chrdev_open(struct inode *, s
 extern const char *__bdevname(dev_t, char *buffer);
 extern const char *bdevname(struct block_device *bdev, char *buffer);
 extern struct block_device *lookup_bdev(const char *);
+extern struct block_device *__open_bdev_excl(const char *, int, void *, int);
+static inline struct block_device *open_bdev_excl(const char *path, int flags, void *holder)
+{
+	return __open_bdev_excl(path, flags, holder, BD_NONE);
+}
 extern struct block_device *open_bdev_excl(const char *, int, void *);
 extern void close_bdev_excl(struct block_device *);
 
-- 
Jeff Mahoney
SuSE Labs
