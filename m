Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286315AbSAAWii>; Tue, 1 Jan 2002 17:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286322AbSAAWi3>; Tue, 1 Jan 2002 17:38:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47120 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S286315AbSAAWiQ>;
	Tue, 1 Jan 2002 17:38:16 -0500
Message-ID: <3C323A56.C22E2864@mandrakesoft.com>
Date: Tue, 01 Jan 2002 17:38:14 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: NFS "dev_t" issues..
In-Reply-To: <Pine.LNX.4.33.0201011402560.13397-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------7E951E4F5ABAD43F8811728D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7E951E4F5ABAD43F8811728D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> Because the types aren't at all compatible any more, the macros that are
> used for user-level "dev_t" are no longer working for a kdev_t. So we have
> 
>         dev_t                   kdev_t
> 
>         MKDEV(major,minor)      mk_kdev(major, minor)
>         MAJOR(dev)              major(dev)
>         MINOR(dev)              minor(dev)
>         dev == dev2             kdev_same(dev, dev2)
>         !dev                    kdev_none(dev)

And, assignments "kdev_t foo = 0" become "kdev_t foo = NODEV".

At least I hope so ;-)  The below patch fixes up rd.c and loop.c.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
--------------7E951E4F5ABAD43F8811728D
Content-Type: text/plain; charset=us-ascii;
 name="block.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="block.patch"

Index: drivers/block/rd.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_5/drivers/block/rd.c,v
retrieving revision 1.7
diff -u -r1.7 rd.c
--- drivers/block/rd.c	2001/12/20 18:55:32	1.7
+++ drivers/block/rd.c	2002/01/01 22:35:11
@@ -246,7 +246,7 @@
 	unsigned long offset, len;
 	int rw = sbh->bi_rw;
 
-	minor = MINOR(sbh->bi_dev);
+	minor = minor(sbh->bi_dev);
 
 	if (minor >= NUM_RAMDISKS)
 		goto fail;
@@ -280,10 +280,10 @@
 	int error = -EINVAL;
 	unsigned int minor;
 
-	if (!inode || !inode->i_rdev) 	
+	if (!inode || kdev_none(inode->i_rdev))
 		goto out;
 
-	minor = MINOR(inode->i_rdev);
+	minor = minor(inode->i_rdev);
 
 	switch (cmd) {
 		case BLKFLSBUF:
@@ -407,7 +407,7 @@
 		rd_bdev[i] = NULL;
 		if (bdev)
 			blkdev_put(bdev, BDEV_FILE);
-		destroy_buffers(MKDEV(MAJOR_NR, i));
+		destroy_buffers(mk_kdev(MAJOR_NR, i));
 	}
 
 	devfs_unregister (devfs_handle);
@@ -449,7 +449,7 @@
 			       &rd_bd_op, NULL);
 
 	for (i = 0; i < NUM_RAMDISKS; i++)
-		register_disk(NULL, MKDEV(MAJOR_NR,i), 1, &rd_bd_op, rd_size<<1);
+		register_disk(NULL, mk_kdev(MAJOR_NR,i), 1, &rd_bd_op, rd_size<<1);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* We ought to separate initrd operations here */
Index: drivers/block/loop.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_5/drivers/block/loop.c,v
retrieving revision 1.7
diff -u -r1.7 loop.c
--- drivers/block/loop.c	2001/12/30 22:22:58	1.7
+++ drivers/block/loop.c	2002/01/01 22:35:21
@@ -155,8 +155,8 @@
 {
 	if (S_ISREG(lo_dentry->d_inode->i_mode))
 		return (lo_dentry->d_inode->i_size - lo->lo_offset) >> BLOCK_SIZE_BITS;
-	if (blk_size[MAJOR(lodev)])
-		return blk_size[MAJOR(lodev)][MINOR(lodev)] -
+	if (blk_size[major(lodev)])
+		return blk_size[major(lodev)][minor(lodev)] -
                                 (lo->lo_offset >> BLOCK_SIZE_BITS);
 	return MAX_DISK_SIZE;
 }
@@ -379,7 +379,7 @@
  */
 static int loop_end_io_transfer(struct bio *bio, int nr_sectors)
 {
-	struct loop_device *lo = &loop_dev[MINOR(bio->bi_dev)];
+	struct loop_device *lo = &loop_dev[minor(bio->bi_dev)];
 	int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
 
 	if (!uptodate || bio_rw(bio) == WRITE) {
@@ -429,10 +429,10 @@
 	unsigned long IV;
 	int rw = bio_rw(rbh);
 
-	if (MINOR(rbh->bi_dev) >= max_loop)
+	if (minor(rbh->bi_dev) >= max_loop)
 		goto out;
 
-	lo = &loop_dev[MINOR(rbh->bi_dev)];
+	lo = &loop_dev[minor(rbh->bi_dev)];
 	spin_lock_irq(&lo->lo_lock);
 	if (lo->lo_state != Lo_bound)
 		goto inactive;
@@ -615,7 +615,7 @@
 
 	if (S_ISBLK(inode->i_mode)) {
 		lo_device = inode->i_rdev;
-		if (lo_device == dev) {
+		if (kdev_same(lo_device, dev)) {
 			error = -EBUSY;
 			goto out;
 		}
@@ -725,7 +725,7 @@
 	loop_release_xfer(lo);
 	lo->transfer = NULL;
 	lo->ioctl = NULL;
-	lo->lo_device = 0;
+	lo->lo_device = NODEV;
 	lo->lo_encrypt_type = 0;
 	lo->lo_offset = 0;
 	lo->lo_encrypt_key_size = 0;
@@ -818,12 +818,12 @@
 
 	if (!inode)
 		return -EINVAL;
-	if (MAJOR(inode->i_rdev) != MAJOR_NR) {
+	if (major(inode->i_rdev) != MAJOR_NR) {
 		printk(KERN_WARNING "lo_ioctl: pseudo-major != %d\n",
 		       MAJOR_NR);
 		return -ENODEV;
 	}
-	dev = MINOR(inode->i_rdev);
+	dev = minor(inode->i_rdev);
 	if (dev >= max_loop)
 		return -ENODEV;
 	lo = &loop_dev[dev];
@@ -873,11 +873,11 @@
 
 	if (!inode)
 		return -EINVAL;
-	if (MAJOR(inode->i_rdev) != MAJOR_NR) {
+	if (major(inode->i_rdev) != MAJOR_NR) {
 		printk(KERN_WARNING "lo_open: pseudo-major != %d\n", MAJOR_NR);
 		return -ENODEV;
 	}
-	dev = MINOR(inode->i_rdev);
+	dev = minor(inode->i_rdev);
 	if (dev >= max_loop)
 		return -ENODEV;
 
@@ -900,12 +900,12 @@
 
 	if (!inode)
 		return 0;
-	if (MAJOR(inode->i_rdev) != MAJOR_NR) {
+	if (major(inode->i_rdev) != MAJOR_NR) {
 		printk(KERN_WARNING "lo_release: pseudo-major != %d\n",
 		       MAJOR_NR);
 		return 0;
 	}
-	dev = MINOR(inode->i_rdev);
+	dev = minor(inode->i_rdev);
 	if (dev >= max_loop)
 		return 0;
 
@@ -1016,7 +1016,7 @@
 	blk_size[MAJOR_NR] = loop_sizes;
 	blksize_size[MAJOR_NR] = loop_blksizes;
 	for (i = 0; i < max_loop; i++)
-		register_disk(NULL, MKDEV(MAJOR_NR, i), 1, &lo_fops, 0);
+		register_disk(NULL, mk_kdev(MAJOR_NR, i), 1, &lo_fops, 0);
 
 	printk(KERN_INFO "loop: loaded (max %d devices)\n", max_loop);
 	return 0;

--------------7E951E4F5ABAD43F8811728D--

