Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277022AbRJKWmD>; Thu, 11 Oct 2001 18:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277021AbRJKWlx>; Thu, 11 Oct 2001 18:41:53 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:24222 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S277022AbRJKWlj>;
	Thu, 11 Oct 2001 18:41:39 -0400
Date: Thu, 11 Oct 2001 18:42:06 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Christian Ullrich <chris@chrullrich.de>,
        Vincent Sweeney <v.sweeney@dexterus.com>, arvest@orphansonfire.com,
        linux-kernel@vger.kernel.org
Subject: Re: Partitioning problems in 2.4.11
In-Reply-To: <Pine.GSO.4.21.0110111538200.24742-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0110111835360.24742-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	*Damn*.  grok_partitions() doesn't set the size of entire device
until it's done with check_partition().  Which means max_blocks() behaving
in all sorts of interesting ways, depending on phase of moon, etc.

	Could you check if the following helps?

diff -urN S11/fs/block_dev.c S11-part/fs/block_dev.c
--- S11/fs/block_dev.c	Thu Oct 11 11:29:27 2001
+++ S11-part/fs/block_dev.c	Thu Oct 11 15:50:52 2001
@@ -24,29 +24,6 @@
 
 #define MAX_BUF_PER_PAGE (PAGE_CACHE_SIZE / 512)
 
-static inline unsigned int blksize_bits(unsigned int size)
-{
-	unsigned int bits = 8;
-	do {
-		bits++;
-		size >>= 1;
-	} while (size > 256);
-	return bits;
-}
-
-static inline unsigned int block_size(kdev_t dev)
-{
-	int retval = BLOCK_SIZE;
-	int major = MAJOR(dev);
-
-	if (blksize_size[major]) {
-		int minor = MINOR(dev);
-		if (blksize_size[major][minor])
-			retval = blksize_size[major][minor];
-	}
-	return retval;
-}
-
 static unsigned long max_block(kdev_t dev)
 {
 	unsigned int retval = ~0U;
diff -urN S11/fs/partitions/check.c S11-part/fs/partitions/check.c
--- S11/fs/partitions/check.c	Tue Oct  9 21:47:27 2001
+++ S11-part/fs/partitions/check.c	Thu Oct 11 18:39:41 2001
@@ -247,6 +247,7 @@
 		printk(KERN_INFO " %s:", disk_name(hd, MINOR(dev), buf));
 	bdev = bdget(kdev_t_to_nr(dev));
 	bdev->bd_inode->i_size = (loff_t)hd->part[MINOR(dev)].nr_sects << 9;
+	bdev->bd_inode->i_blkbits = blksize_bits(block_size(dev));
 	for (i = 0; check_part[i]; i++) {
 		int res;
 		res = check_part[i](hd, bdev, first_sector, first_part_minor);
@@ -385,6 +386,12 @@
 	if (!size || minors == 1)
 		return;
 
+	if (dev->sizes) {
+		dev->sizes[first_minor] = size >> (BLOCK_SIZE_BITS - 9);
+		for (i = first_minor + 1; i < end_minor; i++)
+			dev->sizes[i] = 0;
+	}
+	blk_size[dev->major] = dev->sizes;
 	check_partition(dev, MKDEV(dev->major, first_minor), 1 + first_minor);
 
  	/*
@@ -394,7 +401,6 @@
 	if (dev->sizes != NULL) {	/* optional safeguard in ll_rw_blk.c */
 		for (i = first_minor; i < end_minor; i++)
 			dev->sizes[i] = dev->part[i].nr_sects >> (BLOCK_SIZE_BITS - 9);
-		blk_size[dev->major] = dev->sizes;
 	}
 }
 
diff -urN S11/fs/partitions/msdos.c S11-part/fs/partitions/msdos.c
--- S11/fs/partitions/msdos.c	Tue Oct  9 21:47:27 2001
+++ S11-part/fs/partitions/msdos.c	Thu Oct 11 13:28:27 2001
@@ -103,21 +103,20 @@
  */
 
 static void extended_partition(struct gendisk *hd, struct block_device *bdev,
-				int minor, int *current_minor)
+			int minor, unsigned long first_size, int *current_minor)
 {
 	struct partition *p;
 	Sector sect;
 	unsigned char *data;
-	unsigned long first_sector, first_size, this_sector, this_size;
+	unsigned long first_sector, this_sector, this_size;
 	int mask = (1 << hd->minor_shift) - 1;
 	int sector_size = get_hardsect_size(to_kdev_t(bdev->bd_dev)) / 512;
 	int loopct = 0;		/* number of links followed
 				   without finding a data partition */
 	int i;
 
-	first_sector = hd->part[minor].start_sect;
-	first_size = hd->part[minor].nr_sects;
-	this_sector = first_sector;
+	this_sector = first_sector = hd->part[minor].start_sect;
+	this_size = first_size;
 
 	while (1) {
 		if (++loopct > 100)
@@ -133,8 +132,6 @@
 
 		p = (struct partition *) (data + 0x1be);
 
-		this_size = hd->part[minor].nr_sects;
-
 		/*
 		 * Usually, the first entry is the real data partition,
 		 * the 2nd entry is the next extended partition, or empty,
@@ -196,6 +193,7 @@
 			goto done;	 /* nothing left to do */
 
 		this_sector = first_sector + START_SECT(p) * sector_size;
+		this_size = NR_SECTS(p) * sector_size;
 		minor = *current_minor;
 		put_dev_sector(sect);
 	}
@@ -586,12 +584,13 @@
 		}
 #endif
 		if (is_extended_partition(p)) {
+			unsigned long size = hd->part[minor].nr_sects;
 			printk(" <");
 			/* prevent someone doing mkfs or mkswap on an
 			   extended partition, but leave room for LILO */
-			if (hd->part[minor].nr_sects > 2)
+			if (size > 2)
 				hd->part[minor].nr_sects = 2;
-			extended_partition(hd, bdev, minor, &current_minor);
+			extended_partition(hd, bdev, minor, size, &current_minor);
 			printk(" >");
 		}
 	}
diff -urN S11/include/linux/blkdev.h S11-part/include/linux/blkdev.h
--- S11/include/linux/blkdev.h	Tue Oct  9 21:47:28 2001
+++ S11-part/include/linux/blkdev.h	Thu Oct 11 11:30:01 2001
@@ -203,4 +203,27 @@
 #define blk_finished_io(nsects)	do { } while (0)
 #define blk_started_io(nsects)	do { } while (0)
 
+static inline unsigned int blksize_bits(unsigned int size)
+{
+	unsigned int bits = 8;
+	do {
+		bits++;
+		size >>= 1;
+	} while (size > 256);
+	return bits;
+}
+
+static inline unsigned int block_size(kdev_t dev)
+{
+	int retval = BLOCK_SIZE;
+	int major = MAJOR(dev);
+
+	if (blksize_size[major]) {
+		int minor = MINOR(dev);
+		if (blksize_size[major][minor])
+			retval = blksize_size[major][minor];
+	}
+	return retval;
+}
+
 #endif

