Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262734AbSJCFRv>; Thu, 3 Oct 2002 01:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262739AbSJCFRu>; Thu, 3 Oct 2002 01:17:50 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:39351 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S262734AbSJCFRg>; Thu, 3 Oct 2002 01:17:36 -0400
From: <peterc@gelato.unsw.edu.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Thu, 3 Oct 2002 15:20:33 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15771.54177.488730.544483@lemon.gelato.unsw.EDU.AU>
Subject: [PATCH] Large Block device patch part 3/4
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch can be picked up from http://www.gelato.unsw.edu.au or from
the bk repository at bk://gelato.unsw.edu.au:2023
See part 0/4 for details.

 drivers/block/cciss.c      |    8 ++--
 drivers/block/cciss.h      |    2 -
 drivers/block/loop.c       |   21 ++++++++----
 drivers/md/linear.c        |   10 +++---
 drivers/md/md.c            |   73 +++++++++++++++++++++++++++------------------
 drivers/md/multipath.c     |   12 +++----
 drivers/md/raid0.c         |   37 ++++++++++++----------
 drivers/md/raid1.c         |   17 +++++-----
 drivers/md/raid5.c         |   40 ++++++++++++------------
 include/linux/loop.h       |    4 +-
 include/linux/raid/md.h    |    2 -
 include/linux/raid/md_k.h  |    6 +--
 include/linux/raid/raid0.h |    6 +--
 13 files changed, 134 insertions(+), 104 deletions(-)


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.670   -> 1.673  
#	drivers/block/cciss.h	1.14    -> 1.15   
#	  drivers/md/raid1.c	1.46    -> 1.47   
#	include/linux/raid/md_k.h	1.45    -> 1.46   
#	include/linux/raid/md.h	1.21    -> 1.22   
#	  drivers/md/raid5.c	1.50    -> 1.51   
#	     drivers/md/md.c	1.112   -> 1.113  
#	 drivers/md/linear.c	1.18    -> 1.19   
#	drivers/md/multipath.c	1.40    -> 1.41   
#	  drivers/md/raid0.c	1.15    -> 1.16   
#	drivers/block/loop.c	1.63    -> 1.64   
#	drivers/block/cciss.c	1.58    -> 1.59   
#	include/linux/raid/raid0.h	1.1     -> 1.2    
#	include/linux/loop.h	1.9     -> 1.10   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/03	peterc@numbat.chubb.wattle.id.au	1.671
# Compaq Smart array sector_t cleanup: prepare for possible 64-bit sector_t
# --------------------------------------------
# 02/10/03	peterc@numbat.chubb.wattle.id.au	1.672
# Clean up loop device to allow huge backing files.
# --------------------------------------------
# 02/10/03	peterc@numbat.chubb.wattle.id.au	1.673
# MD transition to 64-bit sector_t.
#  -- Hold sizes and offsets as sector_t not int;
#  -- use 64-bit arithmetic if necessary to map block-in-raid to zone  
#     and block-in-zone
# --------------------------------------------
#
diff -Nru a/drivers/block/cciss.c b/drivers/block/cciss.c
--- a/drivers/block/cciss.c	Thu Oct  3 15:06:13 2002
+++ b/drivers/block/cciss.c	Thu Oct  3 15:06:13 2002
@@ -175,8 +175,8 @@
                 drv = &h->drv[i];
 		if (drv->block_size == 0)
 			continue;
-                size = sprintf(buffer+len, "cciss/c%dd%d: blksz=%d nr_blocks=%d\n",
-                                ctlr, i, drv->block_size, drv->nr_blocks);
+                size = sprintf(buffer+len, "cciss/c%dd%d: blksz=%d nr_blocks=%llu\n",
+                                ctlr, i, drv->block_size, (unsigned long long)drv->nr_blocks);
                 pos += size; len += size;
         }
 
@@ -405,7 +405,7 @@
                 } else {
                         driver_geo.heads = 0xff;
                         driver_geo.sectors = 0x3f;
-                        driver_geo.cylinders = hba[ctlr]->drv[dsk].nr_blocks / (0xff*0x3f);
+                        driver_geo.cylinders = (int)hba[ctlr]->drv[dsk].nr_blocks / (0xff*0x3f);
                 }
                 driver_geo.start= get_start_sect(inode->i_bdev);
                 if (copy_to_user((void *) arg, &driver_geo,
@@ -1179,7 +1179,7 @@
 			total_size = 0;
 			block_size = BLOCK_SIZE;
 	}	
-	printk(KERN_INFO "      blocks= %d block_size= %d\n", 
+	printk(KERN_INFO "      blocks= %u block_size= %d\n", 
 					total_size, block_size);
 	/* Execute the command to read the disk geometry */
 	memset(inq_buff, 0, sizeof(InquiryData_struct));
diff -Nru a/drivers/block/cciss.h b/drivers/block/cciss.h
--- a/drivers/block/cciss.h	Thu Oct  3 15:06:13 2002
+++ b/drivers/block/cciss.h	Thu Oct  3 15:06:13 2002
@@ -29,7 +29,7 @@
 {
  	__u32   LunID;	
 	int 	usage_count;
-	int 	nr_blocks;
+	sector_t nr_blocks;
 	int	block_size;
 	int 	heads;
 	int	sectors;
diff -Nru a/drivers/block/loop.c b/drivers/block/loop.c
--- a/drivers/block/loop.c	Thu Oct  3 15:06:13 2002
+++ b/drivers/block/loop.c	Thu Oct  3 15:06:13 2002
@@ -154,18 +154,25 @@
 	&xor_funcs  
 };
 
-#define MAX_DISK_SIZE 1024*1024*1024
-
-static void figure_loop_size(struct loop_device *lo)
+static int figure_loop_size(struct loop_device *lo)
 {
-	loff_t size = lo->lo_backing_file->f_dentry->d_inode->i_size;
+	loff_t size = lo->lo_backing_file->f_dentry->d_inode->i_mapping->host->i_size;
+	sector_t x;
+	/*
+	 * Unfortunately, if we want to do I/O on the device,
+	 * the number of 512-byte sectors has to fit into a sector_t.
+	 */
+	size = (size - lo->lo_offset) >> 9;
+	x = (sector_t)size;
+	if ((loff_t)x != size)
+		return -EFBIG;
 
-	set_capacity(disks + lo->lo_number,
-		     (size - lo->lo_offset) >> 9);
+	set_capacity(disks + lo->lo_number, size);
+	return 0;					
 }
 
 static inline int lo_do_transfer(struct loop_device *lo, int cmd, char *rbuf,
-				 char *lbuf, int size, int rblock)
+				 char *lbuf, int size, sector_t rblock)
 {
 	if (!lo->transfer)
 		return 0;
diff -Nru a/drivers/md/linear.c b/drivers/md/linear.c
--- a/drivers/md/linear.c	Thu Oct  3 15:06:13 2002
+++ b/drivers/md/linear.c	Thu Oct  3 15:06:13 2002
@@ -72,10 +72,12 @@
 		goto out;
 	}
 
-	nb_zone = conf->nr_zones =
-		md_size[mdidx(mddev)] / conf->smallest->size +
-		((md_size[mdidx(mddev)] % conf->smallest->size) ? 1 : 0);
-  
+	{
+		sector_t sz = md_size[mdidx(mddev)];
+		unsigned round = sector_div(sz, conf->smallest->size);
+		nb_zone = conf->nr_zones = sz + (round ? 1 : 0);
+	}
+			
 	conf->hash_table = kmalloc (sizeof (struct linear_hash) * nb_zone,
 					GFP_KERNEL);
 	if (!conf->hash_table)
diff -Nru a/drivers/md/md.c b/drivers/md/md.c
--- a/drivers/md/md.c	Thu Oct  3 15:06:13 2002
+++ b/drivers/md/md.c	Thu Oct  3 15:06:13 2002
@@ -103,7 +103,7 @@
 static void md_recover_arrays(void);
 static mdk_thread_t *md_recovery_thread;
 
-int md_size[MAX_MD_DEVS];
+sector_t md_size[MAX_MD_DEVS];
 
 static struct block_device_operations md_fops;
 static devfs_handle_t devfs_handle;
@@ -243,35 +243,35 @@
 	return NULL;
 }
 
-static unsigned int calc_dev_sboffset(struct block_device *bdev)
+static sector_t calc_dev_sboffset(struct block_device *bdev)
 {
-	unsigned int size = bdev->bd_inode->i_size >> BLOCK_SIZE_BITS;
+	sector_t size = bdev->bd_inode->i_size >> BLOCK_SIZE_BITS;
 	return MD_NEW_SIZE_BLOCKS(size);
 }
 
-static unsigned int calc_dev_size(struct block_device *bdev, mddev_t *mddev)
+static sector_t calc_dev_size(struct block_device *bdev, mddev_t *mddev)
 {
-	unsigned int size;
+	sector_t size;
 
 	if (mddev->persistent)
 		size = calc_dev_sboffset(bdev);
 	else
 		size = bdev->bd_inode->i_size >> BLOCK_SIZE_BITS;
 	if (mddev->chunk_size)
-		size &= ~(mddev->chunk_size/1024 - 1);
+		size &= ~((sector_t)mddev->chunk_size/1024 - 1);
 	return size;
 }
 
-static unsigned int zoned_raid_size(mddev_t *mddev)
+static sector_t zoned_raid_size(mddev_t *mddev)
 {
-	unsigned int mask;
+	sector_t mask;
 	mdk_rdev_t * rdev;
 	struct list_head *tmp;
 
 	/*
 	 * do size and offset calculations.
 	 */
-	mask = ~(mddev->chunk_size/1024 - 1);
+	mask = ~((sector_t)mddev->chunk_size/1024 - 1);
 
 	ITERATE_RDEV(mddev,rdev,tmp) {
 		rdev->size &= mask;
@@ -362,7 +362,7 @@
 
 static int read_disk_sb(mdk_rdev_t * rdev)
 {
-	unsigned long sb_offset;
+	sector_t sb_offset;
 
 	if (!rdev->sb) {
 		MD_BUG();
@@ -614,9 +614,9 @@
 
 static void print_rdev(mdk_rdev_t *rdev)
 {
-	printk(KERN_INFO "md: rdev %s, SZ:%08ld F:%d S:%d DN:%d ",
+	printk(KERN_INFO "md: rdev %s, SZ:%08llu F:%d S:%d DN:%d ",
 		bdev_partition_name(rdev->bdev),
-		rdev->size, rdev->faulty, rdev->in_sync, rdev->desc_nr);
+		(unsigned long long)rdev->size, rdev->faulty, rdev->in_sync, rdev->desc_nr);
 	if (rdev->sb) {
 		printk(KERN_INFO "md: rdev superblock:\n");
 		print_sb(rdev->sb);
@@ -698,7 +698,8 @@
 
 static int write_disk_sb(mdk_rdev_t * rdev)
 {
-	unsigned long sb_offset, size;
+	sector_t sb_offset;
+	sector_t size;
 
 	if (!rdev->sb) {
 		MD_BUG();
@@ -715,8 +716,10 @@
 
 	sb_offset = calc_dev_sboffset(rdev->bdev);
 	if (rdev->sb_offset != sb_offset) {
-		printk(KERN_INFO "%s's sb offset has changed from %ld to %ld, skipping\n",
-		       bdev_partition_name(rdev->bdev), rdev->sb_offset, sb_offset);
+		printk(KERN_INFO "%s's sb offset has changed from %llu to %llu, skipping\n",
+		       bdev_partition_name(rdev->bdev), 
+		    (unsigned long long)rdev->sb_offset, 
+		    (unsigned long long)sb_offset);
 		goto skip;
 	}
 	/*
@@ -726,12 +729,14 @@
 	 */
 	size = calc_dev_size(rdev->bdev, rdev->mddev);
 	if (size != rdev->size) {
-		printk(KERN_INFO "%s's size has changed from %ld to %ld since import, skipping\n",
-		       bdev_partition_name(rdev->bdev), rdev->size, size);
+		printk(KERN_INFO "%s's size has changed from %llu to %llu since import, skipping\n",
+		       bdev_partition_name(rdev->bdev),
+		       (unsigned long long)rdev->size, 
+		       (unsigned long long)size);
 		goto skip;
 	}
 
-	printk(KERN_INFO "(write) %s's sb offset: %ld\n", bdev_partition_name(rdev->bdev), sb_offset);
+	printk(KERN_INFO "(write) %s's sb offset: %llu\n", bdev_partition_name(rdev->bdev), (unsigned long long)sb_offset);
 
 	if (!sync_page_io(rdev->bdev, sb_offset<<1, MD_SB_BYTES, rdev->sb_page, WRITE))
 		goto fail;
@@ -929,7 +934,7 @@
 {
 	int err;
 	mdk_rdev_t *rdev;
-	unsigned int size;
+	sector_t size;
 
 	rdev = (mdk_rdev_t *) kmalloc(sizeof(*rdev), GFP_KERNEL);
 	if (!rdev) {
@@ -1209,9 +1214,9 @@
 		rdev->size = calc_dev_size(rdev->bdev, mddev);
 		if (rdev->size < mddev->chunk_size / 1024) {
 			printk(KERN_WARNING
-				"md: Dev %s smaller than chunk_size: %ldk < %dk\n",
+				"md: Dev %s smaller than chunk_size: %lluk < %dk\n",
 				bdev_partition_name(rdev->bdev),
-				rdev->size, mddev->chunk_size / 1024);
+				(unsigned long long)rdev->size, mddev->chunk_size / 1024);
 			return -EINVAL;
 		}
 	}
@@ -1402,6 +1407,12 @@
 	mddev->pers = pers[pnum];
 
 	blk_queue_make_request(&mddev->queue, mddev->pers->make_request);
+	printk("%s: setting max_sectors to %d, segment boundary to %d\n",
+	       disk->disk_name,
+	       chunk_size >> 9,
+	       (chunk_size>>1)-1);
+	blk_queue_max_sectors(&mddev->queue, chunk_size >> 9);
+	blk_queue_segment_boundary(&mddev->queue, (chunk_size>>1) - 1);
 	mddev->queue.queuedata = mddev;
 
 	err = mddev->pers->run(mddev);
@@ -1873,7 +1884,7 @@
 
 static int add_new_disk(mddev_t * mddev, mdu_disk_info_t *info)
 {
-	int size;
+	sector_t size;
 	mdk_rdev_t *rdev;
 	dev_t dev;
 	dev = MKDEV(info->major,info->minor);
@@ -2026,8 +2037,9 @@
 	size = calc_dev_size(rdev->bdev, mddev);
 
 	if (size < mddev->size) {
-		printk(KERN_WARNING "md%d: disk size %d blocks < array size %ld\n",
-				mdidx(mddev), size, mddev->size);
+		printk(KERN_WARNING "md%d: disk size %llu blocks < array size %llu\n",
+				mdidx(mddev), (unsigned long long)size, 
+				(unsigned long long)mddev->size);
 		err = -ENOSPC;
 		goto abort_export;
 	}
@@ -2629,7 +2641,8 @@
 static int md_status_read_proc(char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	int sz = 0, j, size;
+	int sz = 0, j;
+	sector_t size;
 	struct list_head *tmp, *tmp2;
 	mdk_rdev_t *rdev;
 	mddev_t *mddev;
@@ -2663,10 +2676,10 @@
 
 		if (!list_empty(&mddev->disks)) {
 			if (mddev->pers)
-				sz += sprintf(page + sz, "\n      %d blocks",
-						 md_size[mdidx(mddev)]);
+				sz += sprintf(page + sz, "\n      %llu blocks",
+						 (unsigned long long)md_size[mdidx(mddev)]);
 			else
-				sz += sprintf(page + sz, "\n      %d blocks", size);
+				sz += sprintf(page + sz, "\n      %llu blocks", (unsigned long long)size);
 		}
 
 		if (!mddev->pers) {
@@ -3467,6 +3480,8 @@
 }
 #endif
 
+extern u64 __udivdi3(u64, u64);
+extern u64 __umoddi3(u64, u64);
 EXPORT_SYMBOL(md_size);
 EXPORT_SYMBOL(register_md_personality);
 EXPORT_SYMBOL(unregister_md_personality);
@@ -3478,4 +3493,6 @@
 EXPORT_SYMBOL(md_wakeup_thread);
 EXPORT_SYMBOL(md_print_devices);
 EXPORT_SYMBOL(md_interrupt_thread);
+EXPORT_SYMBOL(__udivdi3);
+EXPORT_SYMBOL(__umoddi3);
 MODULE_LICENSE("GPL");
diff -Nru a/drivers/md/multipath.c b/drivers/md/multipath.c
--- a/drivers/md/multipath.c	Thu Oct  3 15:06:13 2002
+++ b/drivers/md/multipath.c	Thu Oct  3 15:06:13 2002
@@ -130,8 +130,8 @@
 		 * oops, IO error:
 		 */
 		md_error (mp_bh->mddev, rdev);
-		printk(KERN_ERR "multipath: %s: rescheduling sector %lu\n", 
-		       bdev_partition_name(rdev->bdev), bio->bi_sector);
+		printk(KERN_ERR "multipath: %s: rescheduling sector %llu\n", 
+		       bdev_partition_name(rdev->bdev), (unsigned long long)bio->bi_sector);
 		multipath_reschedule_retry(mp_bh);
 	}
 	atomic_dec(&rdev->nr_pending);
@@ -320,10 +320,10 @@
 }
 
 #define IO_ERROR KERN_ALERT \
-"multipath: %s: unrecoverable IO read error for block %lu\n"
+"multipath: %s: unrecoverable IO read error for block %llu\n"
 
 #define REDIRECT_SECTOR KERN_ERR \
-"multipath: %s: redirecting sector %lu to another IO path\n"
+"multipath: %s: redirecting sector %llu to another IO path\n"
 
 /*
  * This is a kernel thread which:
@@ -356,11 +356,11 @@
 		rdev = NULL;
 		if (multipath_map (mddev, &rdev)<0) {
 			printk(IO_ERROR,
-				bdev_partition_name(bio->bi_bdev), bio->bi_sector);
+				bdev_partition_name(bio->bi_bdev), (unsigned long long)bio->bi_sector);
 			multipath_end_bh_io(mp_bh, 0);
 		} else {
 			printk(REDIRECT_SECTOR,
-				bdev_partition_name(bio->bi_bdev), bio->bi_sector);
+				bdev_partition_name(bio->bi_bdev), (unsigned long long)bio->bi_sector);
 			bio->bi_bdev = rdev->bdev;
 			generic_make_request(bio);
 		}
diff -Nru a/drivers/md/raid0.c b/drivers/md/raid0.c
--- a/drivers/md/raid0.c	Thu Oct  3 15:06:13 2002
+++ b/drivers/md/raid0.c	Thu Oct  3 15:06:13 2002
@@ -30,7 +30,7 @@
 static int create_strip_zones (mddev_t *mddev)
 {
 	int i, c, j;
-	unsigned long current_offset, curr_zone_offset;
+	sector_t current_offset, curr_zone_offset;
 	raid0_conf_t *conf = mddev_to_conf(mddev);
 	mdk_rdev_t *smallest, *rdev1, *rdev2, *rdev;
 	struct list_head *tmp1, *tmp2;
@@ -46,9 +46,9 @@
 		printk("raid0: looking at %s\n", bdev_partition_name(rdev1->bdev));
 		c = 0;
 		ITERATE_RDEV(mddev,rdev2,tmp2) {
-			printk("raid0:   comparing %s(%ld) with %s(%ld)\n",
-			       bdev_partition_name(rdev1->bdev), rdev1->size,
-			       bdev_partition_name(rdev2->bdev), rdev2->size);
+			printk("raid0:   comparing %s(%llu) with %s(%llu)\n",
+			       bdev_partition_name(rdev1->bdev), (unsigned long long)rdev1->size,
+			       bdev_partition_name(rdev2->bdev), (unsigned long long)rdev2->size);
 			if (rdev2 == rdev1) {
 				printk("raid0:   END\n");
 				break;
@@ -135,7 +135,8 @@
 				c++;
 				if (!smallest || (rdev->size <smallest->size)) {
 					smallest = rdev;
-					printk("  (%ld) is smallest!.\n", rdev->size);
+					printk("  (%llu) is smallest!.\n", 
+					       (unsigned long long)rdev->size);
 				}
 			} else
 				printk(" nope.\n");
@@ -152,7 +153,7 @@
 		curr_zone_offset += zone->size;
 
 		current_offset = smallest->size;
-		printk("raid0: current zone offset: %ld\n", current_offset);
+		printk("raid0: current zone offset: %llu\n", (unsigned long long)current_offset);
 	}
 	printk("raid0: done.\n");
 	return 0;
@@ -163,7 +164,9 @@
 
 static int raid0_run (mddev_t *mddev)
 {
-	unsigned long cur=0, i=0, size, zone0_size, nb_zone;
+	unsigned  cur=0, i=0, nb_zone;
+	sector_t zone0_size;
+	s64 size;
 	raid0_conf_t *conf;
 
 	MOD_INC_USE_COUNT;
@@ -176,16 +179,15 @@
 	if (create_strip_zones (mddev)) 
 		goto out_free_conf;
 
-	printk("raid0 : md_size is %d blocks.\n", md_size[mdidx(mddev)]);
+	printk("raid0 : md_size is %llu blocks.\n", (unsigned long long)md_size[mdidx(mddev)]);
 	printk("raid0 : conf->smallest->size is %ld blocks.\n", conf->smallest->size);
 	nb_zone = md_size[mdidx(mddev)]/conf->smallest->size +
-			(md_size[mdidx(mddev)] % conf->smallest->size ? 1 : 0);
-	printk("raid0 : nb_zone is %ld.\n", nb_zone);
+		(md_size[mdidx(mddev)] % conf->smallest->size ? 1 : 0);
+	printk("raid0 : nb_zone is %d.\n", nb_zone);
 	conf->nr_zones = nb_zone;
 
-	printk("raid0 : Allocating %ld bytes for hash.\n",
+	printk("raid0 : Allocating %d bytes for hash.\n",
 				nb_zone*sizeof(struct raid0_hash));
-
 	conf->hash_table = vmalloc (sizeof (struct raid0_hash)*nb_zone);
 	if (!conf->hash_table)
 		goto out_free_zone_conf;
@@ -269,7 +271,8 @@
 	struct raid0_hash *hash;
 	struct strip_zone *zone;
 	mdk_rdev_t *tmp_dev;
-	unsigned long chunk, block, rsect;
+	unsigned long chunk;
+	sector_t block, rsect;
 
 	chunk_size = mddev->chunk_size >> 10;
 	chunksize_bits = ffz(~chunk_size);
@@ -312,16 +315,16 @@
 	return 1;
 
 bad_map:
-	printk ("raid0_make_request bug: can't convert block across chunks or bigger than %dk %ld %d\n", chunk_size, bio->bi_sector, bio->bi_size >> 10);
+	printk ("raid0_make_request bug: can't convert block across chunks or bigger than %dk %llu %d\n", chunk_size, (unsigned long long)bio->bi_sector, bio->bi_size >> 10);
 	goto outerr;
 bad_hash:
-	printk("raid0_make_request bug: hash==NULL for block %ld\n", block);
+	printk("raid0_make_request bug: hash==NULL for block %llu\n", (unsigned long long)block);
 	goto outerr;
 bad_zone0:
-	printk ("raid0_make_request bug: hash->zone0==NULL for block %ld\n", block);
+	printk ("raid0_make_request bug: hash->zone0==NULL for block %llu\n", (unsigned long long)block);
 	goto outerr;
 bad_zone1:
-	printk ("raid0_make_request bug: hash->zone1==NULL for block %ld\n", block);
+	printk ("raid0_make_request bug: hash->zone1==NULL for block %llu\n", (unsigned long long)block);
  outerr:
 	bio_io_error(bio, bio->bi_size);
 	return 0;
diff -Nru a/drivers/md/raid1.c b/drivers/md/raid1.c
--- a/drivers/md/raid1.c	Thu Oct  3 15:06:13 2002
+++ b/drivers/md/raid1.c	Thu Oct  3 15:06:13 2002
@@ -298,8 +298,8 @@
 			/*
 			 * oops, read error:
 			 */
-			printk(KERN_ERR "raid1: %s: rescheduling sector %lu\n",
-			       bdev_partition_name(conf->mirrors[mirror].rdev->bdev), r1_bio->sector);
+			printk(KERN_ERR "raid1: %s: rescheduling sector %llu\n",
+			       bdev_partition_name(conf->mirrors[mirror].rdev->bdev), (unsigned long long)r1_bio->sector);
 			reschedule_retry(r1_bio);
 		}
 	} else {
@@ -747,10 +747,10 @@
 }
 
 #define IO_ERROR KERN_ALERT \
-"raid1: %s: unrecoverable I/O read error for block %lu\n"
+"raid1: %s: unrecoverable I/O read error for block %llu\n"
 
 #define REDIRECT_SECTOR KERN_ERR \
-"raid1: %s: redirecting sector %lu to another mirror\n"
+"raid1: %s: redirecting sector %llu to another mirror\n"
 
 static int end_sync_read(struct bio *bio, unsigned int bytes_done, int error)
 {
@@ -827,7 +827,7 @@
 		 * There is no point trying a read-for-reconstruct as
 		 * reconstruct is about to be aborted
 		 */
-		printk(IO_ERROR, bdev_partition_name(bio->bi_bdev), r1_bio->sector);
+		printk(IO_ERROR, bdev_partition_name(bio->bi_bdev), (unsigned long long)r1_bio->sector);
 		md_done_sync(mddev, r1_bio->master_bio->bi_size >> 9, 0);
 		resume_device(conf);
 		put_buf(r1_bio);
@@ -878,7 +878,8 @@
 		 * Nowhere to write this to... I guess we
 		 * must be done
 		 */
-		printk(KERN_ALERT "raid1: sync aborting as there is nowhere to write sector %lu\n", r1_bio->sector);
+		printk(KERN_ALERT "raid1: sync aborting as there is nowhere to write sector %llu\n", 
+			(unsigned long long)r1_bio->sector);
 		md_done_sync(mddev, r1_bio->master_bio->bi_size >> 9, 0);
 		resume_device(conf);
 		put_buf(r1_bio);
@@ -931,12 +932,12 @@
 		case READ:
 		case READA:
 			if (map(mddev, &rdev) == -1) {
-				printk(IO_ERROR, bdev_partition_name(bio->bi_bdev), r1_bio->sector);
+				printk(IO_ERROR, bdev_partition_name(bio->bi_bdev), (unsigned long long)r1_bio->sector);
 				raid_end_bio_io(r1_bio, 0);
 				break;
 			}
 			printk(REDIRECT_SECTOR,
-				bdev_partition_name(rdev->bdev), r1_bio->sector);
+				bdev_partition_name(rdev->bdev), (unsigned long long)r1_bio->sector);
 			bio->bi_bdev = rdev->bdev;
 			bio->bi_sector = r1_bio->sector;
 			bio->bi_rw = r1_bio->cmd;
diff -Nru a/drivers/md/raid5.c b/drivers/md/raid5.c
--- a/drivers/md/raid5.c	Thu Oct  3 15:06:13 2002
+++ b/drivers/md/raid5.c	Thu Oct  3 15:06:13 2002
@@ -96,7 +96,7 @@
 
 static void remove_hash(struct stripe_head *sh)
 {
-	PRINTK("remove_hash(), stripe %lu\n", sh->sector);
+	PRINTK("remove_hash(), stripe %llu\n", (unsigned long long)sh->sector);
 
 	if (sh->hash_pprev) {
 		if (sh->hash_next)
@@ -110,7 +110,7 @@
 {
 	struct stripe_head **shp = &stripe_hash(conf, sh->sector);
 
-	PRINTK("insert_hash(), stripe %lu\n",sh->sector);
+	PRINTK("insert_hash(), stripe %llu\n", (unsigned long long)sh->sector);
 
 	CHECK_DEVLOCK();
 	if ((sh->hash_next = *shp) != NULL)
@@ -180,7 +180,7 @@
 		BUG();
 	
 	CHECK_DEVLOCK();
-	PRINTK("init_stripe called, stripe %lu\n", sh->sector);
+	PRINTK("init_stripe called, stripe %llu\n", (unsigned long long)sh->sector);
 
 	remove_hash(sh);
 	
@@ -193,8 +193,8 @@
 
 		if (dev->toread || dev->towrite || dev->written ||
 		    test_bit(R5_LOCKED, &dev->flags)) {
-			printk("sector=%lx i=%d %p %p %p %d\n",
-			       sh->sector, i, dev->toread,
+			printk("sector=%llx i=%d %p %p %p %d\n",
+			       (unsigned long long)sh->sector, i, dev->toread,
 			       dev->towrite, dev->written,
 			       test_bit(R5_LOCKED, &dev->flags));
 			BUG();
@@ -336,7 +336,7 @@
 		if (bi == &sh->dev[i].req)
 			break;
 
-	PRINTK("end_read_request %lu/%d, count: %d, uptodate %d.\n", sh->sector, i, atomic_read(&sh->count), uptodate);
+	PRINTK("end_read_request %llu/%d, count: %d, uptodate %d.\n", (unsigned long long)sh->sector, i, atomic_read(&sh->count), uptodate);
 	if (i == disks) {
 		BUG();
 		return 0;
@@ -407,7 +407,7 @@
 		if (bi == &sh->dev[i].req)
 			break;
 
-	PRINTK("end_write_request %lu/%d, count %d, uptodate: %d.\n", sh->sector, i, atomic_read(&sh->count), uptodate);
+	PRINTK("end_write_request %llu/%d, count %d, uptodate: %d.\n", (unsigned long long)sh->sector, i, atomic_read(&sh->count), uptodate);
 	if (i == disks) {
 		BUG();
 		return 0;
@@ -427,7 +427,7 @@
 }
 
 
-static unsigned long compute_blocknr(struct stripe_head *sh, int i);
+static sector_t compute_blocknr(struct stripe_head *sh, int i);
 	
 static void raid5_build_block (struct stripe_head *sh, int i)
 {
@@ -648,7 +648,7 @@
 	int i, count, disks = conf->raid_disks;
 	void *ptr[MAX_XOR_BLOCKS], *p;
 
-	PRINTK("compute_block, stripe %lu, idx %d\n", sh->sector, dd_idx);
+	PRINTK("compute_block, stripe %llu, idx %d\n", (unsigned long long)sh->sector, dd_idx);
 
 	ptr[0] = page_address(sh->dev[dd_idx].page);
 	memset(ptr[0], 0, STRIPE_SIZE);
@@ -660,7 +660,7 @@
 		if (test_bit(R5_UPTODATE, &sh->dev[i].flags))
 			ptr[count++] = p;
 		else
-			printk("compute_block() %d, stripe %lu, %d not present\n", dd_idx, sh->sector, i);
+			printk("compute_block() %d, stripe %llu, %d not present\n", dd_idx, (unsigned long long)sh->sector, i);
 
 		check_xor();
 	}
@@ -676,7 +676,7 @@
 	void *ptr[MAX_XOR_BLOCKS];
 	struct bio *chosen[MD_SB_DISKS];
 
-	PRINTK("compute_parity, stripe %lu, method %d\n", sh->sector, method);
+	PRINTK("compute_parity, stripe %llu, method %d\n", (unsigned long long)sh->sector, method);
 	memset(chosen, 0, sizeof(chosen));
 
 	count = 1;
@@ -762,7 +762,7 @@
 	struct bio **bip;
 	raid5_conf_t *conf = sh->raid_conf;
 
-	PRINTK("adding bh b#%lu to stripe s#%lu\n", bi->bi_sector, sh->sector);
+	PRINTK("adding bh b#%llu to stripe s#%llu\n", (unsigned long long)bi->bi_sector, (unsigned long long)sh->sector);
 
 
 	spin_lock(&sh->lock);
@@ -783,7 +783,7 @@
 	spin_unlock_irq(&conf->device_lock);
 	spin_unlock(&sh->lock);
 
-	PRINTK("added bi b#%lu to stripe s#%lu, disk %d.\n", bi->bi_sector, sh->sector, dd_idx);
+	PRINTK("added bi b#%llu to stripe s#%llu, disk %d.\n", (unsigned long long)bi->bi_sector, (unsigned long long)sh->sector, dd_idx);
 
 	if (forwrite) {
 		/* check if page is coverred */
@@ -831,7 +831,7 @@
 	int failed_num=0;
 	struct r5dev *dev;
 
-	PRINTK("handling stripe %ld, cnt=%d, pd_idx=%d\n", sh->sector, atomic_read(&sh->count), sh->pd_idx);
+	PRINTK("handling stripe %llu, cnt=%d, pd_idx=%d\n", (unsigned long long)sh->sector, atomic_read(&sh->count), sh->pd_idx);
 
 	spin_lock(&sh->lock);
 	clear_bit(STRIPE_HANDLE, &sh->state);
@@ -1035,7 +1035,7 @@
 				else rcw += 2*disks;
 			}
 		}
-		PRINTK("for sector %ld, rmw=%d rcw=%d\n", sh->sector, rmw, rcw);
+		PRINTK("for sector %llu, rmw=%d rcw=%d\n", (unsigned long long)sh->sector, rmw, rcw);
 		set_bit(STRIPE_HANDLE, &sh->state);
 		if (rmw < rcw && rmw > 0)
 			/* prefer read-modify-write, but need to get some data */
@@ -1178,7 +1178,7 @@
 					md_sync_acct(rdev, STRIPE_SECTORS);
 
 				bi->bi_bdev = rdev->bdev;
-				PRINTK("for %ld schedule op %ld on disc %d\n", sh->sector, bi->bi_rw, i);
+				PRINTK("for %llu schedule op %ld on disc %d\n", (unsigned long long)sh->sector, bi->bi_rw, i);
 				atomic_inc(&sh->count);
 				bi->bi_sector = sh->sector;
 				bi->bi_flags = 1 << BIO_UPTODATE;
@@ -1189,7 +1189,7 @@
 				bi->bi_next = NULL;
 				generic_make_request(bi);
 			} else {
-				PRINTK("skip op %ld on disc %d for sector %ld\n", bi->bi_rw, i, sh->sector);
+				PRINTK("skip op %ld on disc %d for sector %llu\n", bi->bi_rw, i, (unsigned long long)sh->sector);
 				clear_bit(R5_LOCKED, &dev->flags);
 				set_bit(STRIPE_HANDLE, &sh->state);
 			}
@@ -1510,9 +1510,9 @@
 {
 	int i;
 
-	printk("sh %lu, pd_idx %d, state %ld.\n", sh->sector, sh->pd_idx, sh->state);
-	printk("sh %lu,  count %d.\n", sh->sector, atomic_read(&sh->count));
-	printk("sh %lu, ", sh->sector);
+	printk("sh %llu, pd_idx %d, state %ld.\n", (unsigned long long)sh->sector, sh->pd_idx, sh->state);
+	printk("sh %llu,  count %d.\n", (unsigned long long)sh->sector, atomic_read(&sh->count));
+	printk("sh %llu, ", (unsigned long long)sh->sector);
 	for (i = 0; i < sh->raid_conf->raid_disks; i++) {
 		printk("(cache%d: %p %ld) ", i, sh->dev[i].page, sh->dev[i].flags);
 	}
diff -Nru a/include/linux/loop.h b/include/linux/loop.h
--- a/include/linux/loop.h	Thu Oct  3 15:06:13 2002
+++ b/include/linux/loop.h	Thu Oct  3 15:06:13 2002
@@ -33,7 +33,7 @@
 	int		lo_flags;
 	int		(*transfer)(struct loop_device *, int cmd,
 				    char *raw_buf, char *loop_buf, int size,
-				    int real_block);
+				    sector_t real_block);
 	char		lo_name[LO_NAME_SIZE];
 	char		lo_encrypt_key[LO_KEY_SIZE];
 	__u32           lo_init[2];
@@ -123,7 +123,7 @@
 struct loop_func_table {
 	int number; 	/* filter type */ 
 	int (*transfer)(struct loop_device *lo, int cmd, char *raw_buf,
-			char *loop_buf, int size, int real_block);
+			char *loop_buf, int size, sector_t real_block);
 	int (*init)(struct loop_device *, struct loop_info *); 
 	/* release is called from loop_unregister_transfer or clr_fd */
 	int (*release)(struct loop_device *); 
diff -Nru a/include/linux/raid/md.h b/include/linux/raid/md.h
--- a/include/linux/raid/md.h	Thu Oct  3 15:06:13 2002
+++ b/include/linux/raid/md.h	Thu Oct  3 15:06:13 2002
@@ -60,7 +60,7 @@
 #define MD_MINOR_VERSION                90
 #define MD_PATCHLEVEL_VERSION           0
 
-extern int md_size[MAX_MD_DEVS];
+extern sector_t md_size[MAX_MD_DEVS];
 
 extern inline char * bdev_partition_name (struct block_device *bdev)
 {
diff -Nru a/include/linux/raid/md_k.h b/include/linux/raid/md_k.h
--- a/include/linux/raid/md_k.h	Thu Oct  3 15:06:13 2002
+++ b/include/linux/raid/md_k.h	Thu Oct  3 15:06:13 2002
@@ -144,7 +144,7 @@
 {
 	struct list_head same_set;	/* RAID devices within the same set */
 
-	unsigned long size;		/* Device size (in blocks) */
+	sector_t size;			/* Device size (in blocks) */
 	mddev_t *mddev;			/* RAID array if running */
 	unsigned long last_events;	/* IO event timestamp */
 
@@ -152,7 +152,7 @@
 
 	struct page	*sb_page;
 	mdp_super_t	*sb;
-	unsigned long	sb_offset;
+	sector_t	sb_offset;
 
 	/* A device can be in one of three states based on two flags:
 	 * Not working:   faulty==1 in_sync==0
@@ -350,5 +350,5 @@
 	__wait_disk_event(wq, condition);				\
 } while (0)
 
-#endif 
+#endif
 
diff -Nru a/include/linux/raid/raid0.h b/include/linux/raid/raid0.h
--- a/include/linux/raid/raid0.h	Thu Oct  3 15:06:13 2002
+++ b/include/linux/raid/raid0.h	Thu Oct  3 15:06:13 2002
@@ -5,9 +5,9 @@
 
 struct strip_zone
 {
-	unsigned long zone_offset;	/* Zone offset in md_dev */
-	unsigned long dev_offset;	/* Zone offset in real dev */
-	unsigned long size;		/* Zone size */
+	sector_t zone_offset;	/* Zone offset in md_dev */
+	sector_t dev_offset;	/* Zone offset in real dev */
+	sector_t size;		/* Zone size */
 	int nb_dev;			/* # of devices attached to the zone */
 	mdk_rdev_t *dev[MD_SB_DISKS]; /* Devices attached to the zone */
 };
