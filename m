Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262736AbSJCFSH>; Thu, 3 Oct 2002 01:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262739AbSJCFSH>; Thu, 3 Oct 2002 01:18:07 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:39863 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S262736AbSJCFRq>; Thu, 3 Oct 2002 01:17:46 -0400
From: <peterc@gelato.unsw.edu.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Thu, 3 Oct 2002 15:20:34 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15771.54178.765338.598679@lemon.gelato.unsw.EDU.AU>
Subject: [PATCH] Large Block device patch part 1/4
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch can be picked up from http://www.gelato.unsw.edu.au or from
the bk repository at bk://gelato.unsw.edu.au:2023
See part 0/4 for details.

 drivers/block/blkpg.c      |   38 +++++++++++++++++++++++++-------------
 drivers/block/floppy.c     |    8 ++++----
 drivers/ide/ide-cd.c       |    8 +++++---
 drivers/ide/ide-disk.c     |   35 +++++++++++++++++++----------------
 drivers/ide/ide-floppy.c   |    2 +-
 drivers/ide/ide-taskfile.c |    4 ++--
 drivers/ide/ide.c          |    4 ++--
 drivers/scsi/ide-scsi.c    |    2 +-
 fs/partitions/check.c      |    7 +++----
 fs/partitions/check.h      |    7 +++----
 include/linux/blkdev.h     |   20 ++++++++++++++++++--
 include/linux/genhd.h      |    6 +++---
 include/linux/ide.h        |    2 +-
 13 files changed, 87 insertions(+), 56 deletions(-)


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.664   -> 1.667  
#	drivers/ide/ide-taskfile.c	1.4     -> 1.5    
#	drivers/block/blkpg.c	1.42    -> 1.43   
#	include/linux/genhd.h	1.30    -> 1.31   
#	drivers/block/floppy.c	1.48    -> 1.49   
#	include/linux/blkdev.h	1.69    -> 1.70   
#	   drivers/ide/ide.c	1.23    -> 1.24   
#	fs/partitions/check.c	1.64    -> 1.65   
#	fs/partitions/check.h	1.7     -> 1.8    
#	 include/linux/ide.h	1.18    -> 1.19   
#	drivers/ide/ide-disk.c	1.16    -> 1.17   
#	drivers/ide/ide-cd.c	1.17    -> 1.18   
#	drivers/ide/ide-floppy.c	1.14    -> 1.15   
#	drivers/scsi/ide-scsi.c	1.10    -> 1.11   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/02	peterc@numbat.chubb.wattle.id.au	1.665
# Partition handling changes for transition to 64-bit sector_t:
# 
# * Make sure that partitions (reported to add_partition()) fit into 
#   a struct gendisk
# * store size and offset of partitions as a sector_t
# --------------------------------------------
# 02/10/02	peterc@numbat.chubb.wattle.id.au	1.666
# IDE changes to transition to 64-bit sector_t:
# 	-- do_request() function takes sector_t not unsigned long as the 
# 	   block number to operate on.
# 	-- Various casts to long where the underlying device can never get 
# 	   big enough to warrant a 64-bit sector offset.
# 	-- Cast sector_t to unsigned long long when printing.
# --------------------------------------------
# 02/10/02	peterc@numbat.chubb.wattle.id.au	1.667
# Change read_dev_sector to take sector_t not unsigned long
# --------------------------------------------
#
diff -Nru a/drivers/block/blkpg.c b/drivers/block/blkpg.c
--- a/drivers/block/blkpg.c	Thu Oct  3 15:04:51 2002
+++ b/drivers/block/blkpg.c	Thu Oct  3 15:04:51 2002
@@ -68,17 +68,22 @@
 {
 	struct gendisk *g;
 	long long ppstart, pplength;
-	long pstart, plength;
 	int part, i;
 
-	/* convert bytes to sectors, check for fit in a hd_struct */
+	/* convert bytes to sectors */
 	ppstart = (p->start >> 9);
 	pplength = (p->length >> 9);
-	pstart = ppstart;
-	plength = pplength;
-	if (pstart != ppstart || plength != pplength
-	    || pstart < 0 || plength < 0)
-		return -EINVAL;
+
+	/* check for fit in a hd_struct */ 
+	if (sizeof(sector_t) == sizeof(long) && 
+	    sizeof(long long) > sizeof(long)) {
+		long pstart, plength;
+		pstart = ppstart;
+		plength = pplength;
+		if (pstart != ppstart || plength != pplength
+		    || pstart < 0 || plength < 0)
+			return -EINVAL;
+	}
 
 	/* find the drive major */
 	g = get_gendisk(bdev->bd_dev, &part);
@@ -101,13 +106,13 @@
 
 	/* overlap? */
 	for (i = 0; i < (1<<g->minor_shift) - 1; i++)
-		if (!(pstart+plength <= g->part[i].start_sect ||
-		      pstart >= g->part[i].start_sect + g->part[i].nr_sects))
+		if (!(ppstart+pplength <= g->part[i].start_sect ||
+		      ppstart >= g->part[i].start_sect + g->part[i].nr_sects))
 			return -EBUSY;
 
 	/* all seems OK */
-	g->part[p->pno - 1].start_sect = pstart;
-	g->part[p->pno - 1].nr_sects = plength;
+	g->part[p->pno - 1].start_sect = ppstart;
+	g->part[p->pno - 1].nr_sects = pplength;
 	update_partition(g, p->pno);
 	return 0;
 }
@@ -259,10 +264,17 @@
 			intval = bdev_hardsect_size(bdev);
 			return put_user(intval, (int *) arg);
 
-		case BLKGETSIZE:
+		case BLKGETSIZE: 
+		{
+			unsigned long ret;
 			/* size in sectors, works up to 2 TB */
 			ullval = bdev->bd_inode->i_size;
-			return put_user((unsigned long)(ullval >> 9), (unsigned long *) arg);
+			ret = ullval >> 9;
+			if ((u64)ret != (ullval >> 9))
+				return -EFBIG;
+			return put_user(ret, (unsigned long *) arg);
+		}
+		
 		case BLKGETSIZE64:
 			/* size in bytes */
 			ullval = bdev->bd_inode->i_size;
diff -Nru a/drivers/block/floppy.c b/drivers/block/floppy.c
--- a/drivers/block/floppy.c	Thu Oct  3 15:04:51 2002
+++ b/drivers/block/floppy.c	Thu Oct  3 15:04:51 2002
@@ -493,7 +493,7 @@
  */
 static struct floppy_struct user_params[N_DRIVE];
 
-static int floppy_sizes[256];
+static sector_t floppy_sizes[256];
 
 /*
  * The driver is trying to determine the correct media format
@@ -2653,8 +2653,8 @@
 
 	max_sector = _floppy->sect * _floppy->head;
 
-	TRACK = current_req->sector / max_sector;
-	fsector_t = current_req->sector % max_sector;
+	TRACK = (int)current_req->sector / max_sector;
+	fsector_t = (int)current_req->sector % max_sector;
 	if (_floppy->track && TRACK >= _floppy->track) {
 		if (current_req->current_nr_sectors & 1) {
 			current_count_sectors = 1;
@@ -2991,7 +2991,7 @@
 
 	if (usage_count == 0) {
 		printk("warning: usage count=0, current_req=%p exiting\n", current_req);
-		printk("sect=%ld flags=%lx\n", current_req->sector, current_req->flags);
+		printk("sect=%ld flags=%lx\n", (long)current_req->sector, current_req->flags);
 		return;
 	}
 	if (fdc_busy){
diff -Nru a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
--- a/drivers/ide/ide-cd.c	Thu Oct  3 15:04:51 2002
+++ b/drivers/ide/ide-cd.c	Thu Oct  3 15:04:51 2002
@@ -1160,7 +1160,7 @@
 	if (rq->current_nr_sectors < bio_sectors(rq->bio) &&
 	    (rq->sector % SECTORS_PER_FRAME) != 0) {
 		printk("%s: cdrom_read_from_buffer: buffer botch (%ld)\n",
-			drive->name, rq->sector);
+			drive->name, (long)rq->sector);
 		cdrom_end_request(drive, 0);
 		return -1;
 	}
@@ -1747,7 +1747,7 @@
  * cdrom driver request routine.
  */
 static ide_startstop_t
-ide_do_rw_cdrom (ide_drive_t *drive, struct request *rq, unsigned long block)
+ide_do_rw_cdrom (ide_drive_t *drive, struct request *rq, sector_t block)
 {
 	ide_startstop_t action;
 	struct cdrom_info *info = drive->driver_data;
@@ -2770,11 +2770,13 @@
 static int ll_10byte_cmd_build(request_queue_t *q, struct request *rq)
 {
 	int hard_sect = queue_hardsect_size(q);
-	sector_t block = rq->hard_sector / (hard_sect >> 9);
+	long block = (long)rq->hard_sector / (hard_sect >> 9);
 	unsigned long blocks = rq->hard_nr_sectors / (hard_sect >> 9);
 
 	if (!(rq->flags & REQ_CMD))
 		return 0;
+
+	BUG_ON(sizeof(rq->hard_sector) > 4 && (rq->hard_sector >> 32));
 
 	if (rq->hard_nr_sectors != rq->nr_sectors) {
 		printk(KERN_ERR "ide-cd: hard_nr_sectors differs from nr_sectors! %lu %lu\n",
diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	Thu Oct  3 15:04:51 2002
+++ b/drivers/ide/ide-disk.c	Thu Oct  3 15:04:51 2002
@@ -358,7 +358,7 @@
  * using LBA if supported, or CHS otherwise, to address sectors.
  * It also takes care of issuing special DRIVE_CMDs.
  */
-static ide_startstop_t do_rw_disk (ide_drive_t *drive, struct request *rq, unsigned long block)
+static ide_startstop_t do_rw_disk (ide_drive_t *drive, struct request *rq, sector_t block)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
@@ -390,19 +390,22 @@
 			tasklets[5] = (task_ioreg_t) (block>>8);
 			tasklets[6] = (task_ioreg_t) (block>>16);
 			tasklets[7] = (task_ioreg_t) (block>>24);
-			tasklets[8] = (task_ioreg_t) 0;
-			tasklets[9] = (task_ioreg_t) 0;
-//			tasklets[8] = (task_ioreg_t) (block>>32);
-//			tasklets[9] = (task_ioreg_t) (block>>40);
+			if (sizeof(block) == 4) {
+				tasklets[8] = (task_ioreg_t) 0;
+				tasklets[9] = (task_ioreg_t) 0;
+			} else {
+				tasklets[8] = (task_ioreg_t) (block>>32);
+				tasklets[9] = (task_ioreg_t) (block>>40);
+			}
 #ifdef DEBUG
-			printk("%s: %sing: LBAsect=%lu, sectors=%ld, "
-				"buffer=0x%08lx, LBAsect=0x%012lx\n",
+			printk("%s: %sing: LBAsect=%llu, sectors=%ld, "
+				"buffer=0x%08lx, LBAsect=0x%012llx\n",
 				drive->name,
 				(rq->cmd==READ)?"read":"writ",
-				block,
+				(unsigned long long)block,
 				rq->nr_sectors,
 				(unsigned long) rq->buffer,
-				block);
+				(unsigned long long)block);
 			printk("%s: 0x%02x%02x 0x%02x%02x%02x%02x%02x%02x\n",
 				drive->name, tasklets[3], tasklets[2],
 				tasklets[9], tasklets[8], tasklets[7],
@@ -422,10 +425,10 @@
 			hwif->OUTB(0x00|drive->select.all,IDE_SELECT_REG);
 		} else {
 #ifdef DEBUG
-			printk("%s: %sing: LBAsect=%ld, sectors=%ld, "
+			printk("%s: %sing: LBAsect=%llu, sectors=%ld, "
 				"buffer=0x%08lx\n",
 				drive->name, (rq->cmd==READ)?"read":"writ",
-				block, rq->nr_sectors,
+				(unsigned long long)block, rq->nr_sectors,
 				(unsigned long) rq->buffer);
 #endif
 			hwif->OUTB(0x00, IDE_FEATURE_REG);
@@ -437,8 +440,8 @@
 		}
 	} else {
 		unsigned int sect,head,cyl,track;
-		track = block / drive->sect;
-		sect  = block % drive->sect + 1;
+		track = (int)block / drive->sect;
+		sect  = (int)block % drive->sect + 1;
 		hwif->OUTB(sect, IDE_SECTOR_REG);
 		head  = track % drive->head;
 		cyl   = track / drive->head;
@@ -542,7 +545,7 @@
  * using LBA if supported, or CHS otherwise, to address sectors.
  * It also takes care of issuing special DRIVE_CMDs.
  */
-static ide_startstop_t do_rw_disk (ide_drive_t *drive, struct request *rq, unsigned long block)
+static ide_startstop_t do_rw_disk (ide_drive_t *drive, struct request *rq, sector_t block)
 {
 	if (!blk_fs_request(rq)) {
 		blk_dump_rq_flags(rq, "do_rw_disk - bad command");
@@ -824,8 +827,8 @@
 				}
 			}
 			if (HWGROUP(drive) && HWGROUP(drive)->rq)
-				printk(", sector=%ld",
-					HWGROUP(drive)->rq->sector);
+				printk(", sector=%llu",
+					(unsigned long long)HWGROUP(drive)->rq->sector);
 		}
 	}
 #endif	/* FANCY_STATUS_DUMPS */
diff -Nru a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
--- a/drivers/ide/ide-floppy.c	Thu Oct  3 15:04:51 2002
+++ b/drivers/ide/ide-floppy.c	Thu Oct  3 15:04:51 2002
@@ -1268,7 +1268,7 @@
 		return ide_stopped;
 	}
 	if (rq->flags & REQ_CMD) {
-		if ((rq->sector % floppy->bs_factor) ||
+		if (((long)rq->sector % floppy->bs_factor) ||
 		    (rq->nr_sectors % floppy->bs_factor)) {
 			printk("%s: unsupported r/w request size\n",
 				drive->name);
diff -Nru a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
--- a/drivers/ide/ide-taskfile.c	Thu Oct  3 15:04:51 2002
+++ b/drivers/ide/ide-taskfile.c	Thu Oct  3 15:04:51 2002
@@ -289,8 +289,8 @@
 				}
 			}
 			if (HWGROUP(drive)->rq)
-				printk(", sector=%lu",
-					HWGROUP(drive)->rq->sector);
+				printk(", sector=%llu",
+					(unsigned long long)HWGROUP(drive)->rq->sector);
 		}
 media_out:
 #endif  /* FANCY_STATUS_DUMPS */
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	Thu Oct  3 15:04:51 2002
+++ b/drivers/ide/ide.c	Thu Oct  3 15:04:51 2002
@@ -587,7 +587,7 @@
 					}
 				}
 				if (HWGROUP(drive) && HWGROUP(drive)->rq)
-					printk(", sector=%ld", HWGROUP(drive)->rq->sector);
+					printk(", sector=%llu", (unsigned long long)HWGROUP(drive)->rq->sector);
 			}
 		}
 #endif	/* FANCY_STATUS_DUMPS */
@@ -3254,7 +3254,7 @@
 	return 0;
 }
 
-static ide_startstop_t default_do_request (ide_drive_t *drive, struct request *rq, unsigned long block)
+static ide_startstop_t default_do_request (ide_drive_t *drive, struct request *rq, sector_t block)
 {
 	ide_end_request(drive, 0, 0);
 	return ide_stopped;
diff -Nru a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
--- a/drivers/scsi/ide-scsi.c	Thu Oct  3 15:04:51 2002
+++ b/drivers/scsi/ide-scsi.c	Thu Oct  3 15:04:51 2002
@@ -487,7 +487,7 @@
 /*
  *	idescsi_do_request is our request handling function.
  */
-static ide_startstop_t idescsi_do_request (ide_drive_t *drive, struct request *rq, unsigned long block)
+static ide_startstop_t idescsi_do_request (ide_drive_t *drive, struct request *rq, sector_t block)
 {
 #if IDESCSI_DEBUG_LOG
 	printk (KERN_INFO "rq_status: %d, rq_dev: %u, cmd: %d, errors: %d\n",rq->rq_status,(unsigned int) rq->rq_dev,rq->cmd,rq->errors);
diff -Nru a/fs/partitions/check.c b/fs/partitions/check.c
--- a/fs/partitions/check.c	Thu Oct  3 15:04:51 2002
+++ b/fs/partitions/check.c	Thu Oct  3 15:04:51 2002
@@ -471,13 +471,12 @@
 	return res;
 }
 
-unsigned char *read_dev_sector(struct block_device *bdev, unsigned long n, Sector *p)
+unsigned char *read_dev_sector(struct block_device *bdev, sector_t n, Sector *p)
 {
 	struct address_space *mapping = bdev->bd_inode->i_mapping;
-	int sect = PAGE_CACHE_SIZE / 512;
 	struct page *page;
 
-	page = read_cache_page(mapping, n/sect,
+	page = read_cache_page(mapping, (pgoff_t)(n >> (PAGE_CACHE_SHIFT-9)),
 			(filler_t *)mapping->a_ops->readpage, NULL);
 	if (!IS_ERR(page)) {
 		wait_on_page_locked(page);
@@ -486,7 +485,7 @@
 		if (PageError(page))
 			goto fail;
 		p->v = page;
-		return (unsigned char *)page_address(page) + 512 * (n % sect);
+		return (unsigned char *)page_address(page) +  ((n & ((1 << (PAGE_CACHE_SHIFT - 9)) - 1)) << 9);
 fail:
 		page_cache_release(page);
 	}
diff -Nru a/fs/partitions/check.h b/fs/partitions/check.h
--- a/fs/partitions/check.h	Thu Oct  3 15:04:51 2002
+++ b/fs/partitions/check.h	Thu Oct  3 15:04:51 2002
@@ -5,14 +5,13 @@
  * add_gd_partition adds a partitions details to the devices partition
  * description.
  */
-
 enum { MAX_PART = 256 };
 
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
@@ -20,7 +19,7 @@
 };
 
 static inline void
-put_partition(struct parsed_partitions *p, int n, int from, int size)
+put_partition(struct parsed_partitions *p, int n, sector_t from, sector_t size)
 {
 	if (n < p->limit) {
 		p->parts[n].from = from;
diff -Nru a/include/linux/blkdev.h b/include/linux/blkdev.h
--- a/include/linux/blkdev.h	Thu Oct  3 15:04:51 2002
+++ b/include/linux/blkdev.h	Thu Oct  3 15:04:51 2002
@@ -37,7 +37,7 @@
 	int errors;
 	sector_t sector;
 	unsigned long nr_sectors;
-	unsigned long hard_sector;	/* the hard_* are block layer
+	sector_t hard_sector;		/* the hard_* are block layer
 					 * internals, no driver should
 					 * touch them
 					 */
@@ -394,11 +394,27 @@
 
 typedef struct {struct page *v;} Sector;
 
-unsigned char *read_dev_sector(struct block_device *, unsigned long, Sector *);
+unsigned char *read_dev_sector(struct block_device *, sector_t, Sector *);
 
 static inline void put_dev_sector(Sector p)
 {
 	page_cache_release(p.v);
 }
+
+#ifdef CONFIG_LBD
+# include <asm/div64.h>
+# define sector_div(a, b) do_div(a, b)
+#else
+# define sector_div(n, b)( \
+{ \
+	int _res; \
+	_res = (n) % (b); \
+	(n) /= (b); \
+	_res; \
+} \
+)
+#endif 
+ 
+
 
 #endif
diff -Nru a/include/linux/genhd.h b/include/linux/genhd.h
--- a/include/linux/genhd.h	Thu Oct  3 15:04:51 2002
+++ b/include/linux/genhd.h	Thu Oct  3 15:04:51 2002
@@ -59,8 +59,8 @@
 #  include <linux/devfs_fs_kernel.h>
 
 struct hd_struct {
-	unsigned long start_sect;
-	unsigned long nr_sects;
+	sector_t start_sect;
+	sector_t nr_sects;
 	devfs_handle_t de;              /* primary (master) devfs entry  */
 	struct device hd_driverfs_dev;  /* support driverfs hiearchy     */
 };
@@ -95,7 +95,7 @@
 extern void del_gendisk(struct gendisk *gp);
 extern void unlink_gendisk(struct gendisk *gp);
 extern struct gendisk *get_gendisk(dev_t dev, int *part);
-static inline unsigned long get_start_sect(struct block_device *bdev)
+static inline sector_t get_start_sect(struct block_device *bdev)
 {
 	return bdev->bd_offset;
 }
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	Thu Oct  3 15:04:51 2002
+++ b/include/linux/ide.h	Thu Oct  3 15:04:51 2002
@@ -1224,7 +1224,7 @@
 	int		(*suspend)(ide_drive_t *);
 	int		(*resume)(ide_drive_t *);
 	int		(*flushcache)(ide_drive_t *);
-	ide_startstop_t	(*do_request)(ide_drive_t *, struct request *, unsigned long);
+	ide_startstop_t	(*do_request)(ide_drive_t *, struct request *, sector_t);
 	int		(*end_request)(ide_drive_t *, int, int);
 	u8		(*sense)(ide_drive_t *, const char *, u8);
 	ide_startstop_t	(*error)(ide_drive_t *, const char *, u8);
