Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318392AbSHWFwi>; Fri, 23 Aug 2002 01:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318447AbSHWFwi>; Fri, 23 Aug 2002 01:52:38 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:8958 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S318392AbSHWFwe>; Fri, 23 Aug 2002 01:52:34 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15717.52886.732426.131213@wombat.chubb.wattle.id.au>
Date: Fri, 23 Aug 2002 15:56:38 +1000
To: torvalds@transmeta.com
CC: linux-kernel@vger.kernel.org
Subject: Large Block Device patch part 6 of 9
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is a bit of a grab-bag; it adds the sector_div() macro
needed to make the previous RAID patch work; and it adds casts to avoid
64-bit division where it's not necessary, and where the dividend
cannot be more than 2^31.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.513   -> 1.514  
#	drivers/mtd/devices/blkmtd.c	1.15    -> 1.16   
#	drivers/block/ll_rw_blk.c	1.99    -> 1.100  
#	drivers/ieee1394/sbp2.c	1.9     -> 1.10   
#	drivers/block/floppy.c	1.36    -> 1.37   
#	   drivers/scsi/sd.c	1.52    -> 1.53   
#	include/linux/blkdev.h	1.60    -> 1.61   
#	   drivers/scsi/sr.c	1.35    -> 1.36   
#	drivers/mtd/mtdblock.c	1.21    -> 1.22   
#	drivers/ide/ide-cd.c	1.2     -> 1.3    
#	drivers/ide/ide-floppy.c	1.1     -> 1.2    
#	   drivers/scsi/sd.h	1.3     -> 1.4    
#	drivers/block/cciss.c	1.52    -> 1.53   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/23	peterc@numbat.chubb.wattle.id.au	1.514
# Fix various devices (cciss, scsi, floppy, ide-cd, sbp, mtd, etc; add sector_div() macro.
# --------------------------------------------
#
diff -Nru a/drivers/block/cciss.c b/drivers/block/cciss.c
--- a/drivers/block/cciss.c	Fri Aug 23 15:08:49 2002
+++ b/drivers/block/cciss.c	Fri Aug 23 15:08:49 2002
@@ -405,7 +405,7 @@
                 } else {
                         driver_geo.heads = 0xff;
                         driver_geo.sectors = 0x3f;
-                        driver_geo.cylinders = hba[ctlr]->drv[dsk].nr_blocks / (0xff*0x3f);
+                        driver_geo.cylinders = (int)hba[ctlr]->drv[dsk].nr_blocks / (0xff*0x3f);
                 }
                 driver_geo.start=
                         hba[ctlr]->hd[minor(inode->i_rdev)].start_sect;
@@ -1191,7 +1191,7 @@
 			total_size = 0;
 			block_size = BLOCK_SIZE;
 	}	
-	printk(KERN_INFO "      blocks= %d block_size= %d\n", 
+	printk(KERN_INFO "      blocks= %u block_size= %d\n", 
 					total_size, block_size);
 	/* Execute the command to read the disk geometry */
 	memset(inq_buff, 0, sizeof(InquiryData_struct));
diff -Nru a/drivers/block/floppy.c b/drivers/block/floppy.c
--- a/drivers/block/floppy.c	Fri Aug 23 15:08:49 2002
+++ b/drivers/block/floppy.c	Fri Aug 23 15:08:49 2002
@@ -489,7 +489,7 @@
  */
 static struct floppy_struct user_params[N_DRIVE];
 
-static int floppy_sizes[256];
+static sector_t floppy_sizes[256];
 
 /*
  * The driver is trying to determine the correct media format
@@ -2664,8 +2664,10 @@
 
 	max_sector = _floppy->sect * _floppy->head;
 
-	TRACK = CURRENT->sector / max_sector;
-	fsector_t = CURRENT->sector % max_sector;
+	/* There can't be more than 2^16 (minimum max int) sectors on 
+	   a floppy, for goodness sake! */
+	TRACK = (int)CURRENT->sector / max_sector;
+	fsector_t = (int)CURRENT->sector % max_sector;
 	if (_floppy->track && TRACK >= _floppy->track) {
 		if (CURRENT->current_nr_sectors & 1) {
 			current_count_sectors = 1;
diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Fri Aug 23 15:08:49 2002
+++ b/drivers/block/ll_rw_blk.c	Fri Aug 23 15:08:49 2002
@@ -70,10 +70,10 @@
  *
  * if (!blk_size[MAJOR]) then no minor size checking is done.
  */
-int * blk_size[MAX_BLKDEV];
+sector_t * blk_size[MAX_BLKDEV];
 
 /*
- * How many reqeusts do we allocate per queue,
+ * How many requests do we allocate per queue,
  * and how many do we "batch" on freeing them?
  */
 int queue_nr_requests, batch_requests;
diff -Nru a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
--- a/drivers/ide/ide-cd.c	Fri Aug 23 15:08:49 2002
+++ b/drivers/ide/ide-cd.c	Fri Aug 23 15:08:49 2002
@@ -2784,11 +2784,13 @@
 static int ll_10byte_cmd_build(request_queue_t *q, struct request *rq)
 {
 	int hard_sect = queue_hardsect_size(q);
-	sector_t block = rq->hard_sector / (hard_sect >> 9);
+	unsigned block = (long)rq->hard_sector / (hard_sect >> 9);
 	unsigned long blocks = rq->hard_nr_sectors / (hard_sect >> 9);
 
 	if (!(rq->flags & REQ_CMD))
 		return 0;
+
+	BUG_ON(sizeof(rq->hard_sector) > 4 && (rq->hard_sector >> 32));
 
 	if (rq->hard_nr_sectors != rq->nr_sectors) {
 		printk(KERN_ERR "ide-cd: hard_nr_sectors differs from nr_sectors! %lu %lu\n",
diff -Nru a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
--- a/drivers/ide/ide-floppy.c	Fri Aug 23 15:08:49 2002
+++ b/drivers/ide/ide-floppy.c	Fri Aug 23 15:08:49 2002
@@ -1379,7 +1379,7 @@
 		return ide_stopped;
 	}
 	if (rq->flags & REQ_CMD) {
-		if ((rq->sector % floppy->bs_factor) ||
+		if (((long)rq->sector % floppy->bs_factor) ||
 		    (rq->nr_sectors % floppy->bs_factor)) {
 			printk("%s: unsupported r/w request size\n",
 				drive->name);
diff -Nru a/drivers/ieee1394/sbp2.c b/drivers/ieee1394/sbp2.c
--- a/drivers/ieee1394/sbp2.c	Fri Aug 23 15:08:49 2002
+++ b/drivers/ieee1394/sbp2.c	Fri Aug 23 15:08:49 2002
@@ -3105,12 +3105,13 @@
 
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
diff -Nru a/drivers/mtd/devices/blkmtd.c b/drivers/mtd/devices/blkmtd.c
--- a/drivers/mtd/devices/blkmtd.c	Fri Aug 23 15:08:49 2002
+++ b/drivers/mtd/devices/blkmtd.c	Fri Aug 23 15:08:49 2002
@@ -163,9 +163,10 @@
 static int blkmtd_readpage(mtd_raw_dev_data_t *rawdevice, struct page *page)
 {  
   int err;
-  int sectornr, sectors, i;
+  sector_t sectornr;
+  int sectors, i;
   struct kiobuf *iobuf;
-  unsigned long *blocks;
+  sector_t *blocks;
 
   if(!rawdevice) {
     printk("blkmtd: readpage: PANIC file->private_data == NULL\n");
@@ -224,7 +225,7 @@
 
   /* Pre 2.4.4 doesn't have space for the block list in the kiobuf */ 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,4)
-  blocks = kmalloc(KIO_MAX_SECTORS * sizeof(unsigned long));
+  blocks = kmalloc(KIO_MAX_SECTORS * sizeof(*blocks));
   if(blocks == NULL) {
     printk("blkmtd: cant allocate iobuf blocks\n");
     free_kiovec(1, &iobuf);
@@ -240,7 +241,7 @@
   iobuf->length = PAGE_SIZE;
   iobuf->locked = 1;
   iobuf->maplist[0] = page;
-  sectornr = page->index << (PAGE_SHIFT - rawdevice->sector_bits);
+  sectornr = (sector_t)page->index << (PAGE_SHIFT - rawdevice->sector_bits);
   sectors = 1 << (PAGE_SHIFT - rawdevice->sector_bits);
   if(rawdevice->partial_last_page && page->index == rawdevice->partial_last_page) {
     DEBUG(3, "blkmtd: handling partial last page\n");
diff -Nru a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
--- a/drivers/mtd/mtdblock.c	Fri Aug 23 15:08:49 2002
+++ b/drivers/mtd/mtdblock.c	Fri Aug 23 15:08:49 2002
@@ -46,7 +46,7 @@
 
 static spinlock_t mtdblks_lock;
 
-static int mtd_sizes[MAX_MTD_DEVICES];
+static sector_t mtd_sizes[MAX_MTD_DEVICES];
 
 /*
  * Cache stuff...
diff -Nru a/drivers/scsi/sd.c b/drivers/scsi/sd.c
--- a/drivers/scsi/sd.c	Fri Aug 23 15:08:49 2002
+++ b/drivers/scsi/sd.c	Fri Aug 23 15:08:49 2002
@@ -298,7 +298,8 @@
  **/
 static int sd_init_command(Scsi_Cmnd * SCpnt)
 {
-	int dsk_nr, part_nr, block, this_count;
+	int dsk_nr, part_nr, this_count;
+	sector_t block;
 	Scsi_Device *sdp;
 #if CONFIG_SCSI_LOGGING
 	char nbuff[6];
@@ -611,8 +612,8 @@
 	int result = SCpnt->result;
 	int this_count = SCpnt->bufflen >> 9;
 	int good_sectors = (result == 0 ? this_count : 0);
-	int block_sectors = 1;
-	long error_sector;
+	sector_t block_sectors = 1;
+	sector_t error_sector;
 #if CONFIG_SCSI_LOGGING
 	char nbuff[6];
 
@@ -947,7 +948,7 @@
 		    SRpnt->sr_sense_buffer[2] == NOT_READY)
 			sdp->changed = 1;
 
-		/* Either no media are present but the drive didnt tell us,
+		/* Either no media are present but the drive didn't tell us,
 		   or they are present but the read capacity command fails */
 		/* sdkp->media_present = 0; -- not always correct */
 		sdkp->capacity = 0x200000; /* 1 GB - random */
@@ -955,7 +956,7 @@
 		return;
 	}
 
-	sdkp->capacity = 1 + ((buffer[0] << 24) |
+	sdkp->capacity = 1 + (((sector_t)buffer[0] << 24) |
 			      (buffer[1] << 16) |
 			      (buffer[2] << 8) |
 			      buffer[3]);
diff -Nru a/drivers/scsi/sd.h b/drivers/scsi/sd.h
--- a/drivers/scsi/sd.h	Fri Aug 23 15:08:49 2002
+++ b/drivers/scsi/sd.h	Fri Aug 23 15:08:49 2002
@@ -23,7 +23,7 @@
 extern struct hd_struct *sd;
 
 typedef struct scsi_disk {
-	unsigned capacity;		/* size in 512-byte sectors */
+	sector_t capacity;		/* size in 512-byte sectors */
 	Scsi_Device *device;
 	unsigned char media_present;
 	unsigned char write_prot;
diff -Nru a/drivers/scsi/sr.c b/drivers/scsi/sr.c
--- a/drivers/scsi/sr.c	Fri Aug 23 15:08:49 2002
+++ b/drivers/scsi/sr.c	Fri Aug 23 15:08:49 2002
@@ -88,7 +88,7 @@
 };
 
 Scsi_CD *scsi_CDs;
-static int *sr_sizes;
+static sector_t *sr_sizes;
 
 static int sr_open(struct cdrom_device_info *, int);
 void get_sectorsize(int);
@@ -324,7 +324,7 @@
 	/*
 	 * request doesn't start on hw block boundary, add scatter pads
 	 */
-	if ((SCpnt->request->sector % (s_size >> 9)) || (SCpnt->request_bufflen % s_size)) {
+	if (((unsigned int)SCpnt->request->sector % (s_size >> 9)) || (SCpnt->request_bufflen % s_size)) {
 		printk("sr: unaligned transfer\n");
 		return 0;
 	}
@@ -340,7 +340,7 @@
 	SCpnt->cmnd[1] = (SCpnt->device->scsi_level <= SCSI_2) ?
 			 ((SCpnt->lun << 5) & 0xe0) : 0;
 
-	block = SCpnt->request->sector / (s_size >> 9);
+	block = (unsigned int)SCpnt->request->sector / (s_size >> 9);
 
 	if (this_count > 0xffff)
 		this_count = 0xffff;
@@ -715,10 +715,10 @@
 		goto cleanup_dev;
 	memset(scsi_CDs, 0, sr_template.dev_max * sizeof(Scsi_CD));
 
-	sr_sizes = kmalloc(sr_template.dev_max * sizeof(int), GFP_ATOMIC);
+	sr_sizes = kmalloc(sr_template.dev_max * sizeof(sr_sizes[0]), GFP_ATOMIC);
 	if (!sr_sizes)
 		goto cleanup_cds;
-	memset(sr_sizes, 0, sr_template.dev_max * sizeof(int));
+	memset(sr_sizes, 0, sr_template.dev_max * sizeof(sr_sizes[0]));
 	return 0;
 
 cleanup_cds:
diff -Nru a/include/linux/blkdev.h b/include/linux/blkdev.h
--- a/include/linux/blkdev.h	Fri Aug 23 15:08:49 2002
+++ b/include/linux/blkdev.h	Fri Aug 23 15:08:49 2002
@@ -404,4 +404,20 @@
 	page_cache_release(p.v);
 }
 
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
+
 #endif
