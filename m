Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262737AbSJCFTj>; Thu, 3 Oct 2002 01:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262741AbSJCFSq>; Thu, 3 Oct 2002 01:18:46 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:41143 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S262737AbSJCFRv>; Thu, 3 Oct 2002 01:17:51 -0400
From: <peterc@gelato.unsw.edu.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Thu, 3 Oct 2002 15:20:34 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15771.54178.106397.870653@lemon.gelato.unsw.EDU.AU>
Subject: [PATCH] Large Block device patch part 2/4
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch can be picked up from http://www.gelato.unsw.edu.au or from
the bk repository at bk://gelato.unsw.edu.au:2023
See part 0/4 for details.

 drivers/block/genhd.c     |    8 ++++----
 drivers/block/ll_rw_blk.c |   16 +++++++++-------
 drivers/block/loop.c      |   35 +++++++++++++++++++++++++----------
 drivers/block/ps2esdi.c   |    4 ++--
 drivers/ieee1394/sbp2.c   |    5 +++--
 drivers/md/Makefile       |   13 +++++++++++++
 drivers/mtd/nftlcore.c    |    4 ++--
 drivers/scsi/scsi.c       |   10 +++++-----
 drivers/scsi/sd.c         |   40 ++++++++++++++++++++++++----------------
 drivers/scsi/sd.h         |    2 +-
 drivers/scsi/sr.c         |    4 ++--
 fs/ext3/ialloc.c          |    7 ++++---
 fs/isofs/inode.c          |    7 ++++---
 fs/jbd/commit.c           |    4 ++--
 fs/jbd/revoke.c           |    2 +-
 fs/reiserfs/journal.c     |   12 ++++++------
 fs/reiserfs/prints.c      |   40 ++++++++++++++++++++--------------------
 fs/reiserfs/super.c       |    8 ++++----
 18 files changed, 131 insertions(+), 90 deletions(-)


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.667   -> 1.670  
#	drivers/block/ps2esdi.c	1.50    -> 1.51   
#	 drivers/md/Makefile	1.5     -> 1.6    
#	drivers/mtd/nftlcore.c	1.34    -> 1.35   
#	     fs/jbd/revoke.c	1.10    -> 1.11   
#	drivers/block/ll_rw_blk.c	1.115   -> 1.116  
#	drivers/ieee1394/sbp2.c	1.11    -> 1.12   
#	   drivers/scsi/sr.c	1.46    -> 1.47   
#	 fs/reiserfs/super.c	1.52    -> 1.53   
#	drivers/block/genhd.c	1.42    -> 1.43   
#	    fs/ext3/ialloc.c	1.14    -> 1.15   
#	 drivers/scsi/scsi.c	1.37    -> 1.38   
#	drivers/block/loop.c	1.62    -> 1.63   
#	   drivers/scsi/sd.h	1.4     -> 1.5    
#	fs/reiserfs/journal.c	1.56    -> 1.57   
#	fs/reiserfs/prints.c	1.19    -> 1.20   
#	   drivers/scsi/sd.c	1.59    -> 1.60   
#	     fs/jbd/commit.c	1.12    -> 1.13   
#	    fs/isofs/inode.c	1.24    -> 1.25   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/03	peterc@numbat.chubb.wattle.id.au	1.668
# printk changes: A sector_t can be either 64 or 32 bits, so cast it
# to a printable type that is at least as large as 64-bits on all platforms (i.e.,
# cast to unsigned long long and use a %llu format)
# --------------------------------------------
# 02/10/03	peterc@numbat.chubb.wattle.id.au	1.669
# Transition to 64-bit sector_t: fix isofs_get_blocks by converting 
# the (possibly 64-bit) arg to a long.
# --------------------------------------------
# 02/10/03	peterc@numbat.chubb.wattle.id.au	1.670
# SCSI 64-bit sector_t cleanup:  capacity now stored as sector_t;
# make sure that the READ_CAPACITY command doesn't sign-extend its
# returned value; avoid 64-bit division when printing size in MB.
# 
# Still to do:
# 	-- 16-byte SCSI commands
# 	-- Individual scsi drivers.
# --------------------------------------------
#
diff -Nru a/drivers/block/genhd.c b/drivers/block/genhd.c
--- a/drivers/block/genhd.c	Thu Oct  3 15:05:15 2002
+++ b/drivers/block/genhd.c	Thu Oct  3 15:05:15 2002
@@ -177,16 +177,16 @@
 		return 0;
 
 	/* show the full disk and all non-0 size partitions of it */
-	seq_printf(part, "%4d  %4d %10ld %s\n",
+	seq_printf(part, "%4d  %4d %10llu %s\n",
 		sgp->major, sgp->first_minor,
-		get_capacity(sgp) >> 1,
+		(unsigned long long)get_capacity(sgp) >> 1,
 		disk_name(sgp, 0, buf));
 	for (n = 0; n < (1<<sgp->minor_shift) - 1; n++) {
 		if (sgp->part[n].nr_sects == 0)
 			continue;
-		seq_printf(part, "%4d  %4d %10ld %s\n",
+		seq_printf(part, "%4d  %4d %10llu %s\n",
 			sgp->major, n + 1 + sgp->first_minor,
-			sgp->part[n].nr_sects >> 1 ,
+			(unsigned long long)sgp->part[n].nr_sects >> 1 ,
 			disk_name(sgp, n + 1, buf));
 	}
 
diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Thu Oct  3 15:05:15 2002
+++ b/drivers/block/ll_rw_blk.c	Thu Oct  3 15:05:15 2002
@@ -649,7 +649,7 @@
 	} while (bit < __REQ_NR_BITS);
 
 	if (rq->flags & REQ_CMD)
-		printk("sector %lu, nr/cnr %lu/%u\n", rq->sector,
+		printk("sector %llu, nr/cnr %lu/%u\n", (unsigned long long)rq->sector,
 						       rq->nr_sectors,
 						       rq->current_nr_sectors);
 
@@ -1795,10 +1795,10 @@
 			 * device, e.g., when mounting a device. */
 			printk(KERN_INFO
 			       "attempt to access beyond end of device\n");
-			printk(KERN_INFO "%s: rw=%ld, want=%ld, limit=%Lu\n",
+			printk(KERN_INFO "%s: rw=%ld, want=%Lu, limit=%Lu\n",
 			       bdevname(bio->bi_bdev),
 			       bio->bi_rw,
-			       sector + nr_sectors,
+			       (unsigned long long) sector + nr_sectors,
 			       (long long) maxsector);
 
 			set_bit(BIO_EOF, &bio->bi_flags);
@@ -1827,8 +1827,10 @@
 		}
 
 		if (unlikely(bio_sectors(bio) > q->max_sectors)) {
-			printk("bio too big (%u > %u)\n", bio_sectors(bio),
-							q->max_sectors);
+			printk("bio too big device %s (%u > %u)\n", 
+			       bdevname(bio->bi_bdev),
+			       bio_sectors(bio),
+			       q->max_sectors);
 			goto end_io;
 		}
 
@@ -1938,8 +1940,8 @@
 
 	req->errors = 0;
 	if (!uptodate) {
-		printk("end_request: I/O error, dev %s, sector %lu\n",
-			kdevname(req->rq_dev), req->sector);
+		printk("end_request: I/O error, dev %s, sector %llu\n",
+			kdevname(req->rq_dev), (unsigned long long)req->sector);
 		error = -EIO;
 	}
 
diff -Nru a/drivers/block/loop.c b/drivers/block/loop.c
--- a/drivers/block/loop.c	Thu Oct  3 15:05:15 2002
+++ b/drivers/block/loop.c	Thu Oct  3 15:05:15 2002
@@ -90,7 +90,7 @@
  * Transfer functions
  */
 static int transfer_none(struct loop_device *lo, int cmd, char *raw_buf,
-			 char *loop_buf, int size, int real_block)
+			 char *loop_buf, int size, sector_t real_block)
 {
 	if (raw_buf != loop_buf) {
 		if (cmd == READ)
@@ -103,7 +103,7 @@
 }
 
 static int transfer_xor(struct loop_device *lo, int cmd, char *raw_buf,
-			char *loop_buf, int size, int real_block)
+			char *loop_buf, int size, sector_t real_block)
 {
 	char	*in, *out, *key;
 	int	i, keysize;
@@ -181,18 +181,18 @@
 	struct address_space_operations *aops = mapping->a_ops;
 	struct page *page;
 	char *kaddr, *data;
-	unsigned long index;
+	pgoff_t index;
 	unsigned size, offset;
 	int len;
 	int ret = 0;
 
 	down(&mapping->host->i_sem);
 	index = pos >> PAGE_CACHE_SHIFT;
-	offset = pos & (PAGE_CACHE_SIZE - 1);
+	offset = pos & ((pgoff_t)PAGE_CACHE_SIZE - 1);
 	data = kmap(bvec->bv_page) + bvec->bv_offset;
 	len = bvec->bv_len;
 	while (len > 0) {
-		int IV = index * (PAGE_CACHE_SIZE/bsize) + offset/bsize;
+		sector_t IV = index * (PAGE_CACHE_SIZE/bsize) + offset/bsize;
 		int transfer_result;
 
 		size = PAGE_CACHE_SIZE - offset;
@@ -211,7 +211,7 @@
 			 * The transfer failed, but we still write the data to
 			 * keep prepare/commit calls balanced.
 			 */
-			printk(KERN_ERR "loop: transfer error block %ld\n", index);
+			printk(KERN_ERR "loop: transfer error block %llu\n", (unsigned long long)index);
 			memset(kaddr + offset, 0, size);
 		}
 		flush_dcache_page(page);
@@ -702,7 +702,11 @@
 	lo->lo_backing_file = file;
 	lo->transfer = NULL;
 	lo->ioctl = NULL;
-	figure_loop_size(lo);
+	if (figure_loop_size(lo)) {
+		error = -EFBIG;
+		fput(file);
+		goto out_putf;
+	}
 	lo->old_gfp_mask = inode->i_mapping->gfp_mask;
 	inode->i_mapping->gfp_mask = GFP_NOIO;
 
@@ -822,6 +826,7 @@
 	struct loop_info info; 
 	int err;
 	unsigned int type;
+	loff_t offset;
 
 	if (lo->lo_encrypt_key_size && lo->lo_key_owner != current->uid && 
 	    !capable(CAP_SYS_ADMIN))
@@ -837,13 +842,23 @@
 		return -EINVAL;
 	if (type == LO_CRYPT_XOR && info.lo_encrypt_key_size == 0)
 		return -EINVAL;
+
 	err = loop_release_xfer(lo);
 	if (!err) 
 		err = loop_init_xfer(lo, type, &info);
+
+	offset = lo->lo_offset;
+	if (offset != info.lo_offset) {
+		lo->lo_offset = info.lo_offset;
+		if (figure_loop_size(lo)){
+			err = -EFBIG;
+			lo->lo_offset = offset;
+		}
+	}
+
 	if (err)
 		return err;	
 
-	lo->lo_offset = info.lo_offset;
 	strncpy(lo->lo_name, info.lo_name, LO_NAME_SIZE);
 
 	lo->transfer = xfer_funcs[type]->transfer;
@@ -856,7 +871,7 @@
 		       info.lo_encrypt_key_size);
 		lo->lo_key_owner = current->uid; 
 	}	
-	figure_loop_size(lo);
+
 	return 0;
 }
 
@@ -1055,7 +1070,7 @@
 	for (i = 0; i < max_loop; i++) {
 		struct loop_device *lo = &loop_dev[i];
 		struct gendisk *disk = disks + i;
-		memset(lo, 0, sizeof(struct loop_device));
+		memset(lo, 0, sizeof(*lo));
 		init_MUTEX(&lo->lo_ctl_mutex);
 		init_MUTEX_LOCKED(&lo->lo_sem);
 		init_MUTEX_LOCKED(&lo->lo_bh_mutex);
diff -Nru a/drivers/block/ps2esdi.c b/drivers/block/ps2esdi.c
--- a/drivers/block/ps2esdi.c	Thu Oct  3 15:05:15 2002
+++ b/drivers/block/ps2esdi.c	Thu Oct  3 15:05:15 2002
@@ -532,8 +532,8 @@
 	}
 	/* is request is valid */ 
 	else {
-		printk("Grrr. error. ps2esdi_drives: %d, %lu %lu\n", ps2esdi_drives,
-		       CURRENT->sector, get_capacity(&ps2esdi_gendisk[unit]));
+		printk("Grrr. error. ps2esdi_drives: %d, %lu %llu\n", ps2esdi_drives,
+		       CURRENT->sector, (unsigned long long)get_capacity(&ps2esdi_gendisk[unit]));
 		end_request(CURRENT, FAIL);
 	}
 
diff -Nru a/drivers/ieee1394/sbp2.c b/drivers/ieee1394/sbp2.c
--- a/drivers/ieee1394/sbp2.c	Thu Oct  3 15:05:15 2002
+++ b/drivers/ieee1394/sbp2.c	Thu Oct  3 15:05:15 2002
@@ -3146,12 +3146,13 @@
 
 	heads = 64;
 	sectors = 32;
-	cylinders = disk->capacity / (heads * sectors);
+	cylinders = (int)disk->capacity / (heads * sectors);
+	
 
 	if (cylinders > 1024) {
 		heads = 255;
 		sectors = 63;
-		cylinders = disk->capacity / (heads * sectors);
+		cylinders = (int)disk->capacity / (heads * sectors);
 	}
 
 	geom[0] = heads;
diff -Nru a/drivers/md/Makefile b/drivers/md/Makefile
--- a/drivers/md/Makefile	Thu Oct  3 15:05:15 2002
+++ b/drivers/md/Makefile	Thu Oct  3 15:05:15 2002
@@ -19,3 +19,16 @@
 obj-$(CONFIG_BLK_DEV_LVM)	+= lvm-mod.o
 
 include $(TOPDIR)/Rules.make
+
+# I can't get around the need for 64-bit division in raid[0-5]
+ifdef CONFIG_LBD
+
+LIBGCC:= $(shell ${CC} ${CFLAGS} -print-libgcc-file-name)
+
+md.o: md.c _udivdi3.o _umoddi3.o
+	$(CC) $(c_flags) -c -o md-tmp.o md.c
+	$(LD) -r  -o md.o md-tmp.o _udivdi3.o _umoddi3.o
+
+_udivdi3.o _umoddi3.o: $(LIBGCC)
+	$(AR) x $(LIBGCC) $@
+endif
diff -Nru a/drivers/mtd/nftlcore.c b/drivers/mtd/nftlcore.c
--- a/drivers/mtd/nftlcore.c	Thu Oct  3 15:05:15 2002
+++ b/drivers/mtd/nftlcore.c	Thu Oct  3 15:05:15 2002
@@ -803,9 +803,9 @@
 
 		DEBUG(MTD_DEBUG_LEVEL2, "NFTL_request\n");
 		DEBUG(MTD_DEBUG_LEVEL3,
-		      "NFTL %s request, from sector 0x%04lx for %d sectors\n",
+		      "NFTL %s request, from sector 0x%04llx for %d sectors\n",
 		      (req->cmd == READ) ? "Read " : "Write",
-		      req->sector, req->current_nr_sectors);
+		      (unsigned long long)req->sector, req->current_nr_sectors);
 
 		dev = minor(req->rq_dev);
 		block = req->sector;
diff -Nru a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
--- a/drivers/scsi/scsi.c	Thu Oct  3 15:05:15 2002
+++ b/drivers/scsi/scsi.c	Thu Oct  3 15:05:15 2002
@@ -2407,16 +2407,16 @@
 		for (SDpnt = shpnt->host_queue; SDpnt; SDpnt = SDpnt->next) {
 			for (SCpnt = SDpnt->device_queue; SCpnt; SCpnt = SCpnt->next) {
 				/*  (0) h:c:t:l (dev sect nsect cnumsec sg) (ret all flg) (to/cmd to ito) cmd snse result %d %x      */
-				printk(KERN_INFO "(%3d) %2d:%1d:%2d:%2d (%6s %4ld %4ld %4ld %4x %1d) (%1d %1d 0x%2x) (%4d %4d %4d) 0x%2.2x 0x%2.2x 0x%8.8x\n",
+				printk(KERN_INFO "(%3d) %2d:%1d:%2d:%2d (%6s %4llu %4ld %4ld %4x %1d) (%1d %1d 0x%2x) (%4d %4d %4d) 0x%2.2x 0x%2.2x 0x%8.8x\n",
 				       i++,
 
 				       SCpnt->host->host_no,
 				       SCpnt->channel,
-				       SCpnt->target,
-				       SCpnt->lun,
+                                       SCpnt->target,
+                                       SCpnt->lun,
 
-				       kdevname(SCpnt->request->rq_dev),
-				       SCpnt->request->sector,
+                                       kdevname(SCpnt->request->rq_dev),
+                                       (unsigned long long)SCpnt->request->sector,
 				       SCpnt->request->nr_sectors,
 				       (long)SCpnt->request->current_nr_sectors,
 				       SCpnt->request->rq_status,
diff -Nru a/drivers/scsi/sd.c b/drivers/scsi/sd.c
--- a/drivers/scsi/sd.c	Thu Oct  3 15:05:15 2002
+++ b/drivers/scsi/sd.c	Thu Oct  3 15:05:15 2002
@@ -295,7 +295,8 @@
  **/
 static int sd_init_command(Scsi_Cmnd * SCpnt)
 {
-	int dsk_nr, part_nr, block, this_count;
+	int dsk_nr, part_nr, this_count;
+	sector_t block;
 	Scsi_Device *sdp;
 #if CONFIG_SCSI_LOGGING
 	char nbuff[6];
@@ -312,8 +313,8 @@
 	block = SCpnt->request->sector;
 	this_count = SCpnt->request_bufflen >> 9;
 
-	SCSI_LOG_HLQUEUE(1, printk("sd_command_init: dsk_nr=%d, block=%d, "
-			    "count=%d\n", dsk_nr, block, this_count));
+	SCSI_LOG_HLQUEUE(1, printk("sd_command_init: dsk_nr=%d, block=%llu, "
+			    "count=%d\n", dsk_nr, (unsigned long long)block, this_count));
 
 	sdp = SCpnt->device;
 	/* >>>>> the "(part_nr & 0xf)" excludes 15th partition, why?? */
@@ -336,8 +337,8 @@
 		return 0;
 	}
 	SCSI_LOG_HLQUEUE(2, sd_dskname(dsk_nr, nbuff));
-	SCSI_LOG_HLQUEUE(2, printk("%s : [part_nr=%d], block=%d\n",
-				   nbuff, part_nr, block));
+	SCSI_LOG_HLQUEUE(2, printk("%s : [part_nr=%d], block=%llu\n",
+				   nbuff, part_nr, (unsigned long long)block));
 
 	/*
 	 * If we have a 1K hardware sectorsize, prevent access to single
@@ -599,8 +600,8 @@
 	int result = SCpnt->result;
 	int this_count = SCpnt->bufflen >> 9;
 	int good_sectors = (result == 0 ? this_count : 0);
-	int block_sectors = 1;
-	long error_sector;
+	sector_t block_sectors = 1;
+	sector_t error_sector;
 #if CONFIG_SCSI_LOGGING
 	char nbuff[6];
 
@@ -935,7 +936,7 @@
 		    SRpnt->sr_sense_buffer[2] == NOT_READY)
 			sdp->changed = 1;
 
-		/* Either no media are present but the drive didnt tell us,
+		/* Either no media are present but the drive didn't tell us,
 		   or they are present but the read capacity command fails */
 		/* sdkp->media_present = 0; -- not always correct */
 		sdkp->capacity = 0x200000; /* 1 GB - random */
@@ -943,7 +944,7 @@
 		return;
 	}
 
-	sdkp->capacity = 1 + ((buffer[0] << 24) |
+	sdkp->capacity = 1 + (((sector_t)buffer[0] << 24) |
 			      (buffer[1] << 16) |
 			      (buffer[2] << 8) |
 			      buffer[3]);
@@ -979,24 +980,31 @@
 		 * Jacques Gelinas (Jacques@solucorp.qc.ca)
 		 */
 		int hard_sector = sector_size;
-		int sz = sdkp->capacity * (hard_sector/256);
+		sector_t sz = sdkp->capacity * (hard_sector/256);
 		request_queue_t *queue = &sdp->request_queue;
+		sector_t mb;
 
 		blk_queue_hardsect_size(queue, hard_sector);
+		/* avoid 64-bit division on 32-bit platforms */
+		mb = sz >> 1;
+		sector_div(sz, 1250);
+		mb -= sz - 974;
+		sector_div(mb, 1950);
+
 		printk(KERN_NOTICE "SCSI device %s: "
-		       "%d %d-byte hdwr sectors (%d MB)\n",
-		       diskname, sdkp->capacity,
-		       hard_sector, (sz/2 - sz/1250 + 974)/1950);
+		       "%llu %d-byte hdwr sectors (%llu MB)\n",
+		       diskname, (unsigned long long)sdkp->capacity,
+		       hard_sector, (unsigned long long)mb);
 	}
 
 	/* Rescale capacity to 512-byte units */
 	if (sector_size == 4096)
 		sdkp->capacity <<= 3;
-	if (sector_size == 2048)
+	else if (sector_size == 2048)
 		sdkp->capacity <<= 2;
-	if (sector_size == 1024)
+	else if (sector_size == 1024)
 		sdkp->capacity <<= 1;
-	if (sector_size == 256)
+	else if (sector_size == 256)
 		sdkp->capacity >>= 1;
 
 	sdkp->device->sector_size = sector_size;
diff -Nru a/drivers/scsi/sd.h b/drivers/scsi/sd.h
--- a/drivers/scsi/sd.h	Thu Oct  3 15:05:15 2002
+++ b/drivers/scsi/sd.h	Thu Oct  3 15:05:15 2002
@@ -21,7 +21,7 @@
 #endif
 
 typedef struct scsi_disk {
-	unsigned capacity;		/* size in 512-byte sectors */
+	sector_t capacity;		/* size in 512-byte sectors */
 	Scsi_Device *device;
 	unsigned char media_present;
 	unsigned char write_prot;
diff -Nru a/drivers/scsi/sr.c b/drivers/scsi/sr.c
--- a/drivers/scsi/sr.c	Thu Oct  3 15:05:15 2002
+++ b/drivers/scsi/sr.c	Thu Oct  3 15:05:15 2002
@@ -323,7 +323,7 @@
 	/*
 	 * request doesn't start on hw block boundary, add scatter pads
 	 */
-	if ((SCpnt->request->sector % (s_size >> 9)) || (SCpnt->request_bufflen % s_size)) {
+	if (((unsigned int)SCpnt->request->sector % (s_size >> 9)) || (SCpnt->request_bufflen % s_size)) {
 		printk("sr: unaligned transfer\n");
 		return 0;
 	}
@@ -339,7 +339,7 @@
 	SCpnt->cmnd[1] = (SCpnt->device->scsi_level <= SCSI_2) ?
 			 ((SCpnt->lun << 5) & 0xe0) : 0;
 
-	block = SCpnt->request->sector / (s_size >> 9);
+	block = (unsigned int)SCpnt->request->sector / (s_size >> 9);
 
 	if (this_count > 0xffff)
 		this_count = 0xffff;
diff -Nru a/fs/ext3/ialloc.c b/fs/ext3/ialloc.c
--- a/fs/ext3/ialloc.c	Thu Oct  3 15:05:15 2002
+++ b/fs/ext3/ialloc.c	Thu Oct  3 15:05:15 2002
@@ -479,9 +479,10 @@
 			!(inode = iget(sb, ino)) || is_bad_inode(inode) ||
 			NEXT_ORPHAN(inode) > max_ino) {
 		ext3_warning(sb, __FUNCTION__,
-			     "bad orphan inode %ld!  e2fsck was run?\n", ino);
-		printk(KERN_NOTICE "ext3_test_bit(bit=%d, block=%ld) = %d\n",
-			bit, bitmap_bh->b_blocknr,
+			     "bad orphan inode %lu!  e2fsck was run?\n", ino);
+		printk(KERN_NOTICE "ext3_test_bit(bit=%d, block=%llu) = %d\n",
+		       bit, 
+			(unsigned long long)bitmap_bh->b_blocknr, 
 			ext3_test_bit(bit, bitmap_bh->b_data));
 		printk(KERN_NOTICE "inode=%p\n", inode);
 		if (inode) {
diff -Nru a/fs/isofs/inode.c b/fs/isofs/inode.c
--- a/fs/isofs/inode.c	Thu Oct  3 15:05:15 2002
+++ b/fs/isofs/inode.c	Thu Oct  3 15:05:15 2002
@@ -934,21 +934,22 @@
  * or getblk() if they are not.  Returns the number of blocks inserted
  * (0 == error.)
  */
-int isofs_get_blocks(struct inode *inode, sector_t iblock,
+int isofs_get_blocks(struct inode *inode, sector_t iblock_s,
 		     struct buffer_head **bh, unsigned long nblocks)
 {
 	unsigned long b_off;
 	unsigned offset, sect_size;
 	unsigned int firstext;
 	unsigned long nextino;
+	long iblock = (long)iblock_s;
 	int section, rv;
 	struct iso_inode_info *ei = ISOFS_I(inode);
 
 	lock_kernel();
 
 	rv = 0;
-	if (iblock < 0) {
-		printk("isofs_get_blocks: block < 0\n");
+	if (iblock < 0 || iblock != iblock_s) {
+		printk("isofs_get_blocks: block number too large\n");
 		goto abort;
 	}
 
diff -Nru a/fs/jbd/commit.c b/fs/jbd/commit.c
--- a/fs/jbd/commit.c	Thu Oct  3 15:05:15 2002
+++ b/fs/jbd/commit.c	Thu Oct  3 15:05:15 2002
@@ -355,8 +355,8 @@
 			}
 			
 			bh = jh2bh(descriptor);
-			jbd_debug(4, "JBD: got buffer %ld (%p)\n",
-				bh->b_blocknr, bh->b_data);
+			jbd_debug(4, "JBD: got buffer %llu (%p)\n",
+				(unsigned long long)bh->b_blocknr, bh->b_data);
 			header = (journal_header_t *)&bh->b_data[0];
 			header->h_magic     = htonl(JFS_MAGIC_NUMBER);
 			header->h_blocktype = htonl(JFS_DESCRIPTOR_BLOCK);
diff -Nru a/fs/jbd/revoke.c b/fs/jbd/revoke.c
--- a/fs/jbd/revoke.c	Thu Oct  3 15:05:15 2002
+++ b/fs/jbd/revoke.c	Thu Oct  3 15:05:15 2002
@@ -388,7 +388,7 @@
 		record = find_revoke_record(journal, bh->b_blocknr);
 		if (record) {
 			jbd_debug(4, "cancelled existing revoke on "
-				  "blocknr %lu\n", bh->b_blocknr);
+				  "blocknr %llu\n", (u64)bh->b_blocknr);
 			list_del(&record->hash);
 			kmem_cache_free(revoke_record_cache, record);
 			did_revoke = 1;
diff -Nru a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
--- a/fs/reiserfs/journal.c	Thu Oct  3 15:05:15 2002
+++ b/fs/reiserfs/journal.c	Thu Oct  3 15:05:15 2002
@@ -1008,15 +1008,15 @@
     ** is not marked JDirty_wait
     */
     if ((!was_jwait) && !buffer_locked(saved_bh)) {
-printk("journal-813: BAD! buffer %lu %cdirty %cjwait, not in a newer tranasction\n", saved_bh->b_blocknr,
+printk("journal-813: BAD! buffer %llu %cdirty %cjwait, not in a newer tranasction\n", (unsigned long long)saved_bh->b_blocknr,
         was_dirty ? ' ' : '!', was_jwait ? ' ' : '!') ;
     }
     /* kupdate_one_transaction waits on the buffers it is writing, so we
     ** should never see locked buffers here
     */
     if (buffer_locked(saved_bh)) {
-      printk("clm-2083: locked buffer %lu in flush_journal_list\n", 
-              saved_bh->b_blocknr) ;
+      printk("clm-2083: locked buffer %llu in flush_journal_list\n", 
+              (unsigned long long)saved_bh->b_blocknr) ;
       wait_on_buffer(saved_bh) ;
       if (!buffer_uptodate(saved_bh)) {
         reiserfs_panic(s, "journal-923: buffer write failed\n") ;
@@ -1029,8 +1029,8 @@
       submit_logged_buffer(saved_bh) ;
       count++ ;
     } else {
-      printk("clm-2082: Unable to flush buffer %lu in flush_journal_list\n",
-              saved_bh->b_blocknr) ;
+      printk("clm-2082: Unable to flush buffer %llu in flush_journal_list\n",
+              (unsigned long long)saved_bh->b_blocknr) ;
     }
 free_cnode:
     last = cn ;
@@ -2310,7 +2310,7 @@
   ** could get to disk too early.  NOT GOOD.
   */
   if (!prepared || buffer_locked(bh)) {
-    printk("journal-1777: buffer %lu bad state %cPREPARED %cLOCKED %cDIRTY %cJDIRTY_WAIT\n", bh->b_blocknr, prepared ? ' ' : '!', 
+    printk("journal-1777: buffer %llu bad state %cPREPARED %cLOCKED %cDIRTY %cJDIRTY_WAIT\n", (unsigned long long)bh->b_blocknr, prepared ? ' ' : '!', 
                             buffer_locked(bh) ? ' ' : '!',
 			    buffer_dirty(bh) ? ' ' : '!',
 			    buffer_journal_dirty(bh) ? ' ' : '!') ;
diff -Nru a/fs/reiserfs/prints.c b/fs/reiserfs/prints.c
--- a/fs/reiserfs/prints.c	Thu Oct  3 15:05:15 2002
+++ b/fs/reiserfs/prints.c	Thu Oct  3 15:05:15 2002
@@ -139,8 +139,8 @@
 
 static void sprintf_buffer_head (char * buf, struct buffer_head * bh) 
 {
-  sprintf (buf, "dev %s, size %d, blocknr %ld, count %d, state 0x%lx, page %p, (%s, %s, %s)",
-	   bdevname (bh->b_bdev), bh->b_size, bh->b_blocknr,
+  sprintf (buf, "dev %s, size %d, blocknr %llu, count %d, state 0x%lx, page %p, (%s, %s, %s)",
+	   bdevname (bh->b_bdev), bh->b_size, (unsigned long long)bh->b_blocknr,
 	   atomic_read (&(bh->b_count)),
 	   bh->b_state, bh->b_page,
 	   buffer_uptodate (bh) ? "UPTODATE" : "!UPTODATE",
@@ -367,7 +367,7 @@
     if (tb) {
 	while (tb->insert_size[h]) {
 	    bh = PATH_H_PBUFFER (path, h);
-	    printk ("block %lu (level=%d), position %d\n", bh ? bh->b_blocknr : 0,
+	    printk ("block %llu (level=%d), position %d\n", bh ? (unsigned long long)bh->b_blocknr : 0LL,
 		    bh ? B_LEVEL (bh) : 0, PATH_H_POSITION (path, h));
 	    h ++;
 	}
@@ -377,8 +377,8 @@
       printk ("Offset    Bh     (b_blocknr, b_count) Position Nr_item\n");
       while ( offset > ILLEGAL_PATH_ELEMENT_OFFSET ) {
 	  bh = PATH_OFFSET_PBUFFER (path, offset);
-	  printk ("%6d %10p (%9lu, %7d) %8d %7d\n", offset, 
-		  bh, bh ? bh->b_blocknr : 0, bh ? atomic_read (&(bh->b_count)) : 0,
+	  printk ("%6d %10p (%9llu, %7d) %8d %7d\n", offset, 
+		  bh, bh ? (unsigned long long)bh->b_blocknr : 0LL, bh ? atomic_read (&(bh->b_count)) : 0,
 		  PATH_OFFSET_POSITION (path, offset), bh ? B_NR_ITEMS (bh) : -1);
 	  
 	  offset --;
@@ -510,8 +510,8 @@
 	return 1;
     }
 
-    printk ("%s\'s super block is in block %ld\n", bdevname (bh->b_bdev), 
-            bh->b_blocknr);
+    printk ("%s\'s super block is in block %llu\n", bdevname (bh->b_bdev), 
+            (unsigned long long)bh->b_blocknr);
     printk ("Reiserfs version %s\n", version );
     printk ("Block count %u\n", sb_block_count(rs));
     printk ("Blocksize %d\n", sb_blocksize(rs));
@@ -547,8 +547,8 @@
     if (memcmp(desc->j_magic, JOURNAL_DESC_MAGIC, 8))
 	return 1;
 
-    printk ("Desc block %lu (j_trans_id %d, j_mount_id %d, j_len %d)",
-	    bh->b_blocknr, desc->j_trans_id, desc->j_mount_id, desc->j_len);
+    printk ("Desc block %llu (j_trans_id %d, j_mount_id %d, j_len %d)",
+	    (unsigned long long)bh->b_blocknr, desc->j_trans_id, desc->j_mount_id, desc->j_len);
 
     return 0;
 }
@@ -573,7 +573,7 @@
 	if (print_internal (bh, first, last))
 	    if (print_super_block (bh))
 		if (print_desc_block (bh))
-		    printk ("Block %ld contains unformatted data\n", bh->b_blocknr);
+		    printk ("Block %llu contains unformatted data\n", (unsigned long long)bh->b_blocknr);
 }
 
 
@@ -608,19 +608,19 @@
 	    tbFh = 0;
 	}
 	sprintf (print_tb_buf + strlen (print_tb_buf),
-		 "* %d * %3ld(%2d) * %3ld(%2d) * %3ld(%2d) * %5ld * %5ld * %5ld * %5ld * %5ld *\n",
+		 "* %d * %3lld(%2d) * %3lld(%2d) * %3lld(%2d) * %5lld * %5lld * %5lld * %5lld * %5lld *\n",
 		 h, 
-		 (tbSh) ? (tbSh->b_blocknr):(-1),
+		 (tbSh) ? (long long)(tbSh->b_blocknr):(-1LL),
 		 (tbSh) ? atomic_read (&(tbSh->b_count)) : -1,
-		 (tb->L[h]) ? (tb->L[h]->b_blocknr):(-1),
+		 (tb->L[h]) ? (long long)(tb->L[h]->b_blocknr):(-1LL),
 		 (tb->L[h]) ? atomic_read (&(tb->L[h]->b_count)) : -1,
-		 (tb->R[h]) ? (tb->R[h]->b_blocknr):(-1),
+		 (tb->R[h]) ? (long long)(tb->R[h]->b_blocknr):(-1LL),
 		 (tb->R[h]) ? atomic_read (&(tb->R[h]->b_count)) : -1,
-		 (tbFh) ? (tbFh->b_blocknr):(-1),
-		 (tb->FL[h]) ? (tb->FL[h]->b_blocknr):(-1),
-		 (tb->FR[h]) ? (tb->FR[h]->b_blocknr):(-1),
-		 (tb->CFL[h]) ? (tb->CFL[h]->b_blocknr):(-1),
-		 (tb->CFR[h]) ? (tb->CFR[h]->b_blocknr):(-1));
+		 (tbFh) ? (long long)(tbFh->b_blocknr):(-1LL),
+		 (tb->FL[h]) ? (long long)(tb->FL[h]->b_blocknr):(-1LL),
+		 (tb->FR[h]) ? (long long)(tb->FR[h]->b_blocknr):(-1LL),
+		 (tb->CFL[h]) ? (long long)(tb->CFL[h]->b_blocknr):(-1LL),
+		 (tb->CFR[h]) ? (long long)(tb->CFR[h]->b_blocknr):(-1LL));
     }
 
     sprintf (print_tb_buf + strlen (print_tb_buf), 
@@ -647,7 +647,7 @@
     h = 0;
     for (i = 0; i < sizeof (tb->FEB) / sizeof (tb->FEB[0]); i ++)
 	sprintf (print_tb_buf + strlen (print_tb_buf),
-		 "%p (%lu %d)%s", tb->FEB[i], tb->FEB[i] ? tb->FEB[i]->b_blocknr : 0,
+		 "%p (%llu %d)%s", tb->FEB[i], tb->FEB[i] ? (unsigned long long)tb->FEB[i]->b_blocknr : 0ULL,
 		 tb->FEB[i] ? atomic_read (&(tb->FEB[i]->b_count)) : 0, 
 		 (i == sizeof (tb->FEB) / sizeof (tb->FEB[0]) - 1) ? "\n" : ", ");
 
diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Thu Oct  3 15:05:15 2002
+++ b/fs/reiserfs/super.c	Thu Oct  3 15:05:15 2002
@@ -916,8 +916,8 @@
     rs = (struct reiserfs_super_block *)bh->b_data;
     if (sb_blocksize(rs) != s->s_blocksize) {
 	printk ("sh-2011: read_super_block: "
-		"can't find a reiserfs filesystem on (dev %s, block %lu, size %lu)\n",
-		reiserfs_bdevname (s), bh->b_blocknr, s->s_blocksize);
+		"can't find a reiserfs filesystem on (dev %s, block %Lu, size %lu)\n",
+		reiserfs_bdevname (s), (unsigned long long)bh->b_blocknr, s->s_blocksize);
 	brelse (bh);
 	return 1;
     }
@@ -980,8 +980,8 @@
     ll_rw_block(READ, 1, &(SB_AP_BITMAP(s)[i].bh)) ;
     wait_on_buffer(SB_AP_BITMAP(s)[i].bh) ;
     if (!buffer_uptodate(SB_AP_BITMAP(s)[i].bh)) {
-      printk("reread_meta_blocks, error reading bitmap block number %d at
-      %ld\n", i, SB_AP_BITMAP(s)[i].bh->b_blocknr) ;
+      printk("reread_meta_blocks, error reading bitmap block number %d at %llu\n", 
+        i, (unsigned long long)SB_AP_BITMAP(s)[i].bh->b_blocknr) ;
       return 1 ;
     }
   }
