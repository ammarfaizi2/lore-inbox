Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275968AbRJKNTn>; Thu, 11 Oct 2001 09:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276302AbRJKNTd>; Thu, 11 Oct 2001 09:19:33 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:64681 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S275968AbRJKNT2>;
	Thu, 11 Oct 2001 09:19:28 -0400
Date: Thu, 11 Oct 2001 09:19:58 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Vincent Sweeney <v.sweeney@dexterus.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: Lost Partition
In-Reply-To: <3BC58D32.F500422@dexterus.com>
Message-ID: <Pine.GSO.4.21.0110110919021.22698-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Oct 2001, Vincent Sweeney wrote:

> I have just upgrade my kernel to 2.4.12 and in the process I've lost a
> partition on my secondary IDE drive. Since this is my /usr partition
> it's kind of important ;)

Please, see if the following fixes the problem.

--- S11/fs/partitions/msdos.c	Tue Oct  9 21:47:27 2001
+++ /tmp/msdos.c	Thu Oct 11 09:18:22 2001
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

