Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276209AbRJCNQi>; Wed, 3 Oct 2001 09:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276207AbRJCNQ3>; Wed, 3 Oct 2001 09:16:29 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:51421 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S276203AbRJCNQS>;
	Wed, 3 Oct 2001 09:16:18 -0400
Date: Wed, 3 Oct 2001 09:16:36 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Vladimir V. Saveliev" <vs@namesys.com>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com
Subject: [PATCH] Re: bug? in using generic read/write functions to read/write
 block devices  in 2.4.11-pre2
In-Reply-To: <3BBB01F2.F82BDB46@namesys.com>
Message-ID: <Pine.GSO.4.21.0110030839160.21861-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Oct 2001, Vladimir V. Saveliev wrote:

> Hi
> 
> It looks like something wrong happens with writing/reading to block
> device using generic read/write functions when one does:
> 
> mke2fs /dev/hda1 (blocksize is 4096)
> mount /dev/hda1
> umount /dev/hda1
> mke2fs /dev/hda1 - FAILS with
> Warning: could not write 8 blocks in inode table starting at 492004:
> Attempt to write block from filesystem resulted in short write
> 
> (note that /dev/hda1 should be big enough - 3gb is enogh for example)

Ehh... Linus, both blkdev_get() and blkdev_open() should set ->i_blkbits.
Vladimir, see if the patch below helps:

--- S11-pre2/fs/block_dev.c	Mon Oct  1 17:56:00 2001
+++ /tmp/block_dev.c	Wed Oct  3 09:12:31 2001
@@ -549,36 +549,23 @@
 	return res;
 }
 
-int blkdev_get(struct block_device *bdev, mode_t mode, unsigned flags, int kind)
+static int do_open(struct block_device *bdev, struct inode *inode, struct file *file)
 {
-	int ret = -ENODEV;
-	kdev_t rdev = to_kdev_t(bdev->bd_dev); /* this should become bdev */
-	down(&bdev->bd_sem);
+	int ret = -ENXIO;
+	kdev_t dev = to_kdev_t(bdev->bd_dev);
 
+	down(&bdev->bd_sem);
 	lock_kernel();
 	if (!bdev->bd_op)
-		bdev->bd_op = get_blkfops(MAJOR(rdev));
+		bdev->bd_op = get_blkfops(MAJOR(dev));
 	if (bdev->bd_op) {
-		/*
-		 * This crockload is due to bad choice of ->open() type.
-		 * It will go away.
-		 * For now, block device ->open() routine must _not_
-		 * examine anything in 'inode' argument except ->i_rdev.
-		 */
-		struct file fake_file = {};
-		struct dentry fake_dentry = {};
-		ret = -ENOMEM;
-		fake_file.f_mode = mode;
-		fake_file.f_flags = flags;
-		fake_file.f_dentry = &fake_dentry;
-		fake_dentry.d_inode = bdev->bd_inode;
 		ret = 0;
 		if (bdev->bd_op->open)
-			ret = bdev->bd_op->open(bdev->bd_inode, &fake_file);
+			ret = bdev->bd_op->open(inode, file);
 		if (!ret) {
 			bdev->bd_openers++;
-			bdev->bd_inode->i_size = blkdev_size(rdev);
-			bdev->bd_inode->i_blkbits = blksize_bits(block_size(rdev));
+			bdev->bd_inode->i_size = blkdev_size(dev);
+			bdev->bd_inode->i_blkbits = blksize_bits(block_size(dev));
 		} else if (!bdev->bd_openers)
 			bdev->bd_op = NULL;
 	}
@@ -589,9 +576,26 @@
 	return ret;
 }
 
+int blkdev_get(struct block_device *bdev, mode_t mode, unsigned flags, int kind)
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
+	return do_open(bdev, bdev->bd_inode, &fake_file);
+}
+
 int blkdev_open(struct inode * inode, struct file * filp)
 {
-	int ret;
 	struct block_device *bdev;
 
 	/*
@@ -604,29 +608,8 @@
 
 	bd_acquire(inode);
 	bdev = inode->i_bdev;
-	down(&bdev->bd_sem);
-
-	ret = -ENXIO;
-	lock_kernel();
-	if (!bdev->bd_op)
-		bdev->bd_op = get_blkfops(MAJOR(inode->i_rdev));
 
-	if (bdev->bd_op) {
-		ret = 0;
-		if (bdev->bd_op->open)
-			ret = bdev->bd_op->open(inode,filp);
-		if (!ret) {
-			bdev->bd_openers++;
-			bdev->bd_inode->i_size = blkdev_size(inode->i_rdev);
-		} else if (!bdev->bd_openers)
-			bdev->bd_op = NULL;
-	}	
-
-	unlock_kernel();
-	up(&bdev->bd_sem);
-	if (ret)
-		bdput(bdev);
-	return ret;
+	return do_open(bdev, inode, filp);
 }	
 
 int blkdev_put(struct block_device *bdev, int kind)

