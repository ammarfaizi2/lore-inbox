Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318205AbSHWFqe>; Fri, 23 Aug 2002 01:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318213AbSHWFqe>; Fri, 23 Aug 2002 01:46:34 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:6910 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S318205AbSHWFq3>; Fri, 23 Aug 2002 01:46:29 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15717.52510.31194.607129@wombat.chubb.wattle.id.au>
Date: Fri, 23 Aug 2002 15:50:22 +1000
To: torvalds@transmeta.com
CC: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Large Block Device patch part 3 of 9
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This part fixes the partitioning code to use sector_t not long.
I've cc'd it to Al Viro as he's been working in this area.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.510   -> 1.511  
#	drivers/block/blkpg.c	1.39    -> 1.40   
#	include/linux/genhd.h	1.13    -> 1.14   
#	include/linux/blkdev.h	1.59    -> 1.60   
#	  include/linux/fs.h	1.156   -> 1.157  
#	fs/partitions/check.c	1.44    -> 1.45   
#	fs/partitions/check.h	1.7     -> 1.8    
#	fs/partitions/acorn.c	1.8     -> 1.9    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/23	peterc@numbat.chubb.wattle.id.au	1.511
# Allow partitions to be specified in terms of sector_t not long.
# This allows 32-bit platforms with the right config options
# to address enormous partitions.
# --------------------------------------------
#
diff -Nru a/drivers/block/blkpg.c b/drivers/block/blkpg.c
--- a/drivers/block/blkpg.c	Fri Aug 23 14:17:46 2002
+++ b/drivers/block/blkpg.c	Fri Aug 23 14:17:46 2002
@@ -68,7 +68,7 @@
 {
 	struct gendisk *g;
 	long long ppstart, pplength;
-	long pstart, plength;
+	sector_t pstart, plength;
 	int i;
 	kdev_t dev = to_kdev_t(bdev->bd_dev);
 	struct hd_struct *part;
@@ -78,8 +78,9 @@
 	pplength = (p->length >> 9);
 	pstart = ppstart;
 	plength = pplength;
-	if (pstart != ppstart || plength != pplength
-	    || pstart < 0 || plength < 0)
+ 	if (sizeof(pstart) != sizeof(ppstart) && 
+		    (pstart != ppstart || plength != pplength
+		    || pstart < 0 || plength < 0))
 		return -EINVAL;
 
 	/* find the drive major */
diff -Nru a/fs/partitions/acorn.c b/fs/partitions/acorn.c
--- a/fs/partitions/acorn.c	Fri Aug 23 14:17:46 2002
+++ b/fs/partitions/acorn.c	Fri Aug 23 14:17:46 2002
@@ -17,10 +17,10 @@
 
 static struct adfs_discrecord *
 adfs_partition(struct parsed_partitions *state, char *name, char *data,
-	       unsigned long first_sector, int slot)
+	       sector_t first_sector, int slot)
 {
 	struct adfs_discrecord *dr;
-	unsigned int nr_sects;
+	sector_t nr_sects;
 
 	if (adfs_checkbblk(data))
 		return NULL;
@@ -42,7 +42,7 @@
 #ifdef CONFIG_ACORN_PARTITION_RISCIX
 static int
 riscix_partition(struct parsed_partitions *state, struct block_device *bdev,
-		unsigned long first_sect, int slot, unsigned long nr_sects)
+		sector_t first_sect, int slot, sector_t nr_sects)
 {
 	Sector sect;
 	struct riscix_record *rr;
@@ -55,7 +55,7 @@
 
 
 	if (rr->magic == RISCIX_MAGIC) {
-		unsigned long size = nr_sects > 2 ? 2 : nr_sects;
+		sector_t size = nr_sects > 2 ? 2 : nr_sects;
 		int part;
 
 		printk(" <");
@@ -83,11 +83,11 @@
 
 static int
 linux_partition(struct parsed_partitions *state, struct block_device *bdev,
-		unsigned long first_sect, int slot, unsigned long nr_sects)
+		sector_t first_sect, int slot, sector_t nr_sects)
 {
 	Sector sect;
 	struct linux_part *linuxp;
-	unsigned long size = nr_sects > 2 ? 2 : nr_sects;
+	sector_t size = nr_sects > 2 ? 2 : nr_sects;
 
 	printk(" [Linux]");
 
@@ -117,7 +117,7 @@
 static int
 adfspart_check_CUMANA(struct parsed_partitions *state, struct block_device *bdev)
 {
-	unsigned long first_sector = 0;
+	sector_t first_sector = 0;
 	unsigned int start_blk = 0;
 	Sector sect;
 	unsigned char *data;
@@ -209,7 +209,8 @@
 static int
 adfspart_check_ADFS(struct parsed_partitions *state, struct block_device *bdev)
 {
-	unsigned long start_sect, nr_sects, sectscyl, heads;
+	sector_t start_sect, nr_sects, sectscyl;
+	unsigned heads;
 	Sector sect;
 	unsigned char *data;
 	struct adfs_discrecord *dr;
@@ -268,7 +269,7 @@
 #endif
 
 #ifdef CONFIG_ACORN_PARTITION_ICS
-static int adfspart_check_ICSLinux(struct block_device *bdev, unsigned long block)
+static int adfspart_check_ICSLinux(struct block_device *bdev, sector_t block)
 {
 	Sector sect;
 	unsigned char *data = read_dev_sector(bdev, block, &sect);
@@ -306,7 +307,7 @@
 	/*
 	 * Try ICS style partitions - sector 0 contains partition info.
 	 */
-	data = read_dev_sector(bdev, 0, &sect);
+	data = read_dev_sector(bdev, (sector_t)0, &sect);
 	if (!data)
 	    	return -1;
 
@@ -374,7 +375,7 @@
 	int slot = 1;
 	int i;
 
-	data = read_dev_sector(bdev, 0, &sect);
+	data = read_dev_sector(bdev, (sector_t)0, &sect);
 	if (!data)
 		return -1;
 
diff -Nru a/fs/partitions/check.c b/fs/partitions/check.c
--- a/fs/partitions/check.c	Fri Aug 23 14:17:46 2002
+++ b/fs/partitions/check.c	Fri Aug 23 14:17:46 2002
@@ -415,14 +415,14 @@
  */
 
 void register_disk(struct gendisk *gdev, kdev_t dev, unsigned minors,
-	struct block_device_operations *ops, long size)
+	struct block_device_operations *ops, sector_t size)
 {
 	if (!gdev)
 		return;
 	grok_partitions(dev, size);
 }
 
-void grok_partitions(kdev_t dev, long size)
+void grok_partitions(kdev_t dev, sector_t size)
 {
 	struct block_device *bdev;
 	struct gendisk *g = get_gendisk(dev);
diff -Nru a/fs/partitions/check.h b/fs/partitions/check.h
--- a/fs/partitions/check.h	Fri Aug 23 14:17:46 2002
+++ b/fs/partitions/check.h	Fri Aug 23 14:17:46 2002
@@ -11,8 +11,8 @@
 struct parsed_partitions {
 	char name[40];
 	struct {
-		unsigned long from;
-		unsigned long size;
+		sector_t from;
+		sector_t size;
 		int flags;
 	} parts[MAX_PART];
 	int next;
@@ -20,7 +20,7 @@
 };
 
 static inline void
-put_partition(struct parsed_partitions *p, int n, int from, int size)
+put_partition(struct parsed_partitions *p, int n, sector_t from, sector_t size)
 {
 	if (n < p->limit) {
 		p->parts[n].from = from;
diff -Nru a/include/linux/blkdev.h b/include/linux/blkdev.h
--- a/include/linux/blkdev.h	Fri Aug 23 14:17:46 2002
+++ b/include/linux/blkdev.h	Fri Aug 23 14:17:46 2002
@@ -37,7 +37,7 @@
 	int errors;
 	sector_t sector;
 	unsigned long nr_sectors;
-	unsigned long hard_sector;	/* the hard_* are block layer
+	sector_t hard_sector;		/* the hard_* are block layer
 					 * internals, no driver should
 					 * touch them
 					 */
@@ -281,10 +281,10 @@
 
 extern struct sec_size * blk_sec[MAX_BLKDEV];
 extern struct blk_dev_struct blk_dev[MAX_BLKDEV];
-extern void grok_partitions(kdev_t dev, long size);
+extern void grok_partitions(kdev_t dev, sector_t size);
 extern int wipe_partitions(kdev_t dev);
-extern void register_disk(struct gendisk *dev, kdev_t first, unsigned minors, struct block_device_operations *ops, long size);
 extern void check_partition(struct gendisk *disk, struct block_device *bdev);
+extern void register_disk(struct gendisk *dev, kdev_t first, unsigned minors, struct block_device_operations *ops, sector_t size);
 extern void generic_make_request(struct bio *bio);
 extern inline request_queue_t *bdev_get_queue(struct block_device *bdev);
 extern void blk_put_request(struct request *);
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Fri Aug 23 14:17:46 2002
+++ b/include/linux/fs.h	Fri Aug 23 14:17:46 2002
@@ -355,7 +355,7 @@
 	int			bd_holders;
 	struct block_device *	bd_contains;
 	unsigned		bd_block_size;
-	unsigned long		bd_offset;
+	sector_t		bd_offset;
 	unsigned		bd_part_count;
 	int			bd_invalidated;
 };
diff -Nru a/include/linux/genhd.h b/include/linux/genhd.h
--- a/include/linux/genhd.h	Fri Aug 23 14:17:46 2002
+++ b/include/linux/genhd.h	Fri Aug 23 14:17:46 2002
@@ -59,8 +59,8 @@
 #  include <linux/devfs_fs_kernel.h>
 
 struct hd_struct {
-	unsigned long start_sect;
-	unsigned long nr_sects;
+	sector_t start_sect;
+	sector_t nr_sects;
 	devfs_handle_t de;              /* primary (master) devfs entry  */
 	int number;                     /* stupid old code wastes space  */
 	struct device hd_driverfs_dev;  /* support driverfs hiearchy     */
@@ -90,7 +90,7 @@
 extern void add_gendisk(struct gendisk *gp);
 extern void del_gendisk(struct gendisk *gp);
 extern struct gendisk *get_gendisk(kdev_t dev);
-static inline unsigned long get_start_sect(struct block_device *bdev)
+static inline sector_t get_start_sect(struct block_device *bdev)
 {
 	return bdev->bd_offset;
 }
