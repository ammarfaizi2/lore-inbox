Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286750AbSABFPe>; Wed, 2 Jan 2002 00:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286758AbSABFPZ>; Wed, 2 Jan 2002 00:15:25 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:40336 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S286750AbSABFPJ>; Wed, 2 Jan 2002 00:15:09 -0500
Date: Tue, 1 Jan 2002 21:15:08 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Patch?: linux-2.5.2-pre6/drivers/block/loop.c compilation fixes
Message-ID: <20020101211508.A31515@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	I made the following changes to compile
linux-2.5.2-pre6/drivers/block/loop.c.  I do not have 2.5.2-pre6
running yet and do not expect to for a little while, so I don't
know how correct these changes are.

	I removed two sanity checks that I think are absolutely
impossible cases, but I would appreciate some feedback on whether
I am misunderstanding something.

	Because I have another patch applied to my loop.c, I am
sending a cvs diff against my previous version rather than
against pristine 2.5.2-pre6, but I think the patch should apply
anyhow.

	Does anyone see any problems with this patch?

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="loop.diffs"

Index: linux/drivers/block/loop.c
===================================================================
RCS file: /usr/src.repository/repository/linux/drivers/block/loop.c,v
retrieving revision 1.28
diff -u -r1.28 loop.c
--- linux/drivers/block/loop.c	2002/01/01 00:01:40	1.28
+++ linux/drivers/block/loop.c	2002/01/02 05:05:59
@@ -155,9 +155,8 @@
 {
 	if (S_ISREG(lo_dentry->d_inode->i_mode))
 		return (lo_dentry->d_inode->i_size - lo->lo_offset) >> BLOCK_SIZE_BITS;
-	if (blk_size[MAJOR(lodev)])
-		return blk_size[MAJOR(lodev)][MINOR(lodev)] -
-                                (lo->lo_offset >> BLOCK_SIZE_BITS);
+	if (blk_size[major(lodev)])
+		return block_size(lodev) - (lo->lo_offset >> BLOCK_SIZE_BITS);
 	return MAX_DISK_SIZE;
 }
 
@@ -379,7 +378,7 @@
  */
 static int loop_end_io_transfer(struct bio *bio, int nr_sectors)
 {
-	struct loop_device *lo = &loop_dev[MINOR(bio->bi_dev)];
+	struct loop_device *lo = &loop_dev[minor(bio->bi_dev)];
 	int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
 
 	if (!uptodate || bio_rw(bio) == WRITE) {
@@ -429,10 +428,10 @@
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
@@ -615,7 +614,7 @@
 
 	if (S_ISBLK(inode->i_mode)) {
 		lo_device = inode->i_rdev;
-		if (lo_device == dev) {
+		if (kdev_same(lo_device, dev)) {
 			error = -EBUSY;
 			goto out;
 		}
@@ -725,7 +724,7 @@
 	loop_release_xfer(lo);
 	lo->transfer = NULL;
 	lo->ioctl = NULL;
-	lo->lo_device = 0;
+	lo->lo_device = NODEV;
 	lo->lo_encrypt_type = 0;
 	lo->lo_offset = 0;
 	lo->lo_encrypt_key_size = 0;
@@ -818,12 +817,8 @@
 
 	if (!inode)
 		return -EINVAL;
-	if (MAJOR(inode->i_rdev) != MAJOR_NR) {
-		printk(KERN_WARNING "lo_ioctl: pseudo-major != %d\n",
-		       MAJOR_NR);
-		return -ENODEV;
-	}
-	dev = MINOR(inode->i_rdev);
+
+	dev = minor(inode->i_rdev);
 	if (dev >= max_loop)
 		return -ENODEV;
 	lo = &loop_dev[dev];
@@ -873,11 +868,8 @@
 
 	if (!inode)
 		return -EINVAL;
-	if (MAJOR(inode->i_rdev) != MAJOR_NR) {
-		printk(KERN_WARNING "lo_open: pseudo-major != %d\n", MAJOR_NR);
-		return -ENODEV;
-	}
-	dev = MINOR(inode->i_rdev);
+
+	dev = minor(inode->i_rdev);
 	if (dev >= max_loop)
 		return -ENODEV;
 
@@ -899,13 +891,9 @@
 	int	dev, type;
 
 	if (!inode)
-		return 0;
-	if (MAJOR(inode->i_rdev) != MAJOR_NR) {
-		printk(KERN_WARNING "lo_release: pseudo-major != %d\n",
-		       MAJOR_NR);
 		return 0;
-	}
-	dev = MINOR(inode->i_rdev);
+
+	dev = minor(inode->i_rdev);
 	if (dev >= max_loop)
 		return 0;
 
@@ -1016,7 +1004,7 @@
 	blk_size[MAJOR_NR] = loop_sizes;
 	blksize_size[MAJOR_NR] = loop_blksizes;
 	for (i = 0; i < max_loop; i++)
-		register_disk(NULL, MKDEV(MAJOR_NR, i), 1, &lo_fops, 0);
+		register_disk(NULL, mk_kdev(MAJOR_NR, i), 1, &lo_fops, 0);
 
 	printk(KERN_INFO "loop: loaded (max %d devices)\n", max_loop);
 	return 0;

--XsQoSWH+UP9D9v3l--
