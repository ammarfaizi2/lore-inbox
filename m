Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316888AbSEVIUC>; Wed, 22 May 2002 04:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316891AbSEVIUB>; Wed, 22 May 2002 04:20:01 -0400
Received: from [195.63.194.11] ([195.63.194.11]:45581 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316888AbSEVITy>; Wed, 22 May 2002 04:19:54 -0400
Message-ID: <3CEB45D2.5080609@evision-ventures.com>
Date: Wed, 22 May 2002 09:16:34 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.17 IDE 66
In-Reply-To: <Pine.LNX.4.44.0205202211040.949-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------090105030206070502090908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090105030206070502090908
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Tue May 21 18:36:04 CEST 2002 ide-clean-66

- Move ll_10byte_cmd_build to the only place where it's used: ide-cd.  The SCSI
   layer does have it's own implementation which additionally it's messing
   around with the hard_nr_sectors struct request value.  One should *not*
   provide "infrastructure" until its really used as such.

   If anywhere this should reside in a file called ATAPI.

- Unfold the INIT_REQUEST macro from blk.h. This showed up plenty of duplicate
   checks for QUEUE_EMPTY. Clean them as well. Remove the over cautious
   major(CURRENT->rq_dev != MAJOR_NR) checks. During the last several years I
   never saw any report about it. Looking at the !CURRENT->bio it is clear that
   dereferencing NULL will provide the same kind of panic as the check.  Some
   comments around the code in question show nicely that indeed INIT_REQUEST
   was a good example of code obfuscation.

- A short look at RQ_INACTIVE shows that it is only used inside the scsi.c file
   and during the removal of devices. This shows that the many checks for
   RQ_INACTIVE are not necessary. Looking closer even shows that some of them
   did happen before checks for an empty queue. Plenty of drivers didn't care
   about it and the CD-ROM ones should be handled properly, because the
   most common drivers would fail as well. Comments indicate that this
   was an leftover from 1.3 days...

Well indeed this patch turned out to be more about blkdev handling then
ATA device handling, but anyway.

--------------090105030206070502090908
Content-Type: text/plain;
 name="ide-clean-66.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-66.diff"

diff -urN linux-2.5.17/arch/m68k/atari/stram.c linux/arch/m68k/atari/stram.c
--- linux-2.5.17/arch/m68k/atari/stram.c	2002-05-21 07:07:33.000000000 +0200
+++ linux/arch/m68k/atari/stram.c	2002-05-22 01:03:39.000000000 +0200
@@ -984,8 +984,11 @@
 	unsigned long len;
 
 	while (1) {
-		INIT_REQUEST;
-		
+		if (blk_queue_empty(QUEUE)) {
+			CLEAR_INTR;
+			return;
+		}
+
 		start = swap_start + (CURRENT->sector << 9);
 		len   = CURRENT->current_nr_sectors << 9;
 		if ((start + len) > swap_end) {
diff -urN linux-2.5.17/drivers/acorn/block/mfmhd.c linux/drivers/acorn/block/mfmhd.c
--- linux-2.5.17/drivers/acorn/block/mfmhd.c	2002-05-21 07:07:33.000000000 +0200
+++ linux/drivers/acorn/block/mfmhd.c	2002-05-22 01:12:52.000000000 +0200
@@ -889,17 +889,6 @@
 {
 	DBG("mfm_request CURRENT=%p Busy=%d\n", CURRENT, Busy);
 
-	if (QUEUE_EMPTY) {
-		DBG("mfm_request: Exited due to NULL Current 1\n");
-		return;
-	}
-
-	if (CURRENT->rq_status == RQ_INACTIVE) {
-		/* Hmm - seems to be happening a lot on 1.3.45 */
-		/*console_printf("mfm_request: Exited due to INACTIVE Current\n"); */
-		return;
-	}
-
 	/* If we are still processing then return; we will get called again */
 	if (Busy) {
 		/* Again seems to be common in 1.3.45 */
@@ -914,16 +903,14 @@
 		DBG("mfm_request: loop start\n");
 		sti();
 
-		DBG("mfm_request: before INIT_REQUEST\n");
+		DBG("mfm_request: before blk_queue_empty\n");
 
-		if (QUEUE_EMPTY) {
-			printk("mfm_request: Exiting due to !CURRENT (pre)\n");
+		if (blk_queue_empty(QUEUE)) {
+			printk("mfm_request: Exiting due to empty queue (pre)\n");
 			CLEAR_INTR;
 			Busy = 0;
 			return;
-		};
-
-		INIT_REQUEST;
+		}
 
 		DBG("mfm_request:                 before arg extraction\n");
 
diff -urN linux-2.5.17/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- linux-2.5.17/drivers/block/ll_rw_blk.c	2002-05-21 07:07:31.000000000 +0200
+++ linux/drivers/block/ll_rw_blk.c	2002-05-22 00:01:44.000000000 +0200
@@ -523,42 +523,6 @@
 	printk("\n");
 }
 
-/*
- * standard prep_rq_fn that builds 10 byte cmds
- */
-int ll_10byte_cmd_build(request_queue_t *q, struct request *rq)
-{
-	int hard_sect = queue_hardsect_size(q);
-	sector_t block = rq->hard_sector / (hard_sect >> 9);
-	unsigned long blocks = rq->hard_nr_sectors / (hard_sect >> 9);
-
-	if (!(rq->flags & REQ_CMD))
-		return 0;
-
-	memset(rq->cmd, 0, sizeof(rq->cmd));
-
-	if (rq_data_dir(rq) == READ)
-		rq->cmd[0] = READ_10;
-	else 
-		rq->cmd[0] = WRITE_10;
-
-	/*
-	 * fill in lba
-	 */
-	rq->cmd[2] = (block >> 24) & 0xff;
-	rq->cmd[3] = (block >> 16) & 0xff;
-	rq->cmd[4] = (block >>  8) & 0xff;
-	rq->cmd[5] = block & 0xff;
-
-	/*
-	 * and transfer length
-	 */
-	rq->cmd[7] = (blocks >> 8) & 0xff;
-	rq->cmd[8] = blocks & 0xff;
-
-	return 0;
-}
-
 void blk_recount_segments(request_queue_t *q, struct bio *bio)
 {
 	struct bio_vec *bv, *bvprv = NULL;
@@ -1763,9 +1727,8 @@
 {
 	if (rq->flags & REQ_CMD) {
 		rq->hard_sector += nsect;
-		rq->hard_nr_sectors -= nsect;
+		rq->nr_sectors = rq->hard_nr_sectors -= nsect;
 		rq->sector = rq->hard_sector;
-		rq->nr_sectors = rq->hard_nr_sectors;
 
 		rq->current_nr_sectors = bio_iovec(rq->bio)->bv_len >> 9;
 		rq->hard_cur_sectors = rq->current_nr_sectors;
@@ -1942,7 +1905,6 @@
 EXPORT_SYMBOL(blk_phys_contig_segment);
 EXPORT_SYMBOL(blk_hw_contig_segment);
 
-EXPORT_SYMBOL(ll_10byte_cmd_build);
 EXPORT_SYMBOL(blk_queue_prep_rq);
 
 EXPORT_SYMBOL(blk_queue_init_tags);
diff -urN linux-2.5.17/drivers/block/paride/pcd.c linux/drivers/block/paride/pcd.c
--- linux-2.5.17/drivers/block/paride/pcd.c	2002-05-21 07:07:38.000000000 +0200
+++ linux/drivers/block/paride/pcd.c	2002-05-22 01:13:05.000000000 +0200
@@ -760,8 +760,11 @@
 
 	if (pcd_busy) return;
         while (1) {
-	    if (QUEUE_EMPTY || (CURRENT->rq_status == RQ_INACTIVE)) return;
-	    INIT_REQUEST;
+	    if (blk_queue_empty(QUEUE)) {
+		    CLEAR_INTR;
+		    return;
+	    }
+
 	    if (rq_data_dir(CURRENT) == READ) {
 		unit = minor(CURRENT->rq_dev);
 		if (unit != pcd_unit) {
diff -urN linux-2.5.17/drivers/block/paride/pd.c linux/drivers/block/paride/pd.c
--- linux-2.5.17/drivers/block/paride/pd.c	2002-05-21 07:07:34.000000000 +0200
+++ linux/drivers/block/paride/pd.c	2002-05-22 01:12:02.000000000 +0200
@@ -835,8 +835,10 @@
 
         if (pd_busy) return;
 repeat:
-        if (QUEUE_EMPTY || (CURRENT->rq_status == RQ_INACTIVE)) return;
-        INIT_REQUEST;
+	if (blk_queue_empty(QUEUE)) {
+		CLEAR_INTR;
+		return;
+	}
 
         pd_dev = minor(CURRENT->rq_dev);
 	pd_unit = unit = DEVICE_NR(CURRENT->rq_dev);
diff -urN linux-2.5.17/drivers/block/paride/pf.c linux/drivers/block/paride/pf.c
--- linux-2.5.17/drivers/block/paride/pf.c	2002-05-21 07:07:32.000000000 +0200
+++ linux/drivers/block/paride/pf.c	2002-05-22 01:11:45.000000000 +0200
@@ -841,8 +841,10 @@
 
         if (pf_busy) return;
 repeat:
-        if (QUEUE_EMPTY || (CURRENT->rq_status == RQ_INACTIVE)) return;
-        INIT_REQUEST;
+	if (blk_queue_empty(QUEUE)) {
+		CLEAR_INTR;
+		return;
+	}
 
         pf_unit = unit = DEVICE_NR(CURRENT->rq_dev);
         pf_block = CURRENT->sector;
diff -urN linux-2.5.17/drivers/block/ps2esdi.c linux/drivers/block/ps2esdi.c
--- linux-2.5.17/drivers/block/ps2esdi.c	2002-05-21 07:07:29.000000000 +0200
+++ linux/drivers/block/ps2esdi.c	2002-05-22 01:02:12.000000000 +0200
@@ -471,9 +471,12 @@
 	       CURRENT->current_nr_sectors, CURRENT->buffer);
 #endif
 
-	/* standard macro that ensures that requests are really on the
+	/* standard procedure to ensure that requests are really on the
 	   list + sanity checks.                     */
-	INIT_REQUEST;
+	if (blk_queue_empty(QUEUE)) {
+		CLEAR_INTR;
+		return;
+	}
 
 	if (isa_virt_to_bus(CURRENT->buffer + CURRENT->current_nr_sectors * 512) > 16 * MB) {
 		printk("%s: DMA above 16MB not supported\n", DEVICE_NAME);
diff -urN linux-2.5.17/drivers/block/xd.c linux/drivers/block/xd.c
--- linux-2.5.17/drivers/block/xd.c	2002-05-21 07:07:34.000000000 +0200
+++ linux/drivers/block/xd.c	2002-05-22 01:04:21.000000000 +0200
@@ -279,8 +279,13 @@
 	sti();
 	if (xdc_busy)
 		return;
-	while (code = 0, !QUEUE_EMPTY) {
-		INIT_REQUEST;	/* do some checking on the request structure */
+	while (1) {
+		code = 0;
+		/* do some checking on the request structure */
+		if (blk_queue_empty(QUEUE)) {
+			CLEAR_INTR;
+			return;
+		}
 
 		if (CURRENT_DEV < xd_drives
 		    && (CURRENT->flags & REQ_CMD)
diff -urN linux-2.5.17/drivers/block/z2ram.c linux/drivers/block/z2ram.c
--- linux-2.5.17/drivers/block/z2ram.c	2002-05-21 07:07:41.000000000 +0200
+++ linux/drivers/block/z2ram.c	2002-05-22 00:59:50.000000000 +0200
@@ -76,7 +76,10 @@
 
     while ( TRUE )
     {
-	INIT_REQUEST;
+	if (blk_queue_empty(QUEUE)) {
+		CLEAR_INTR;
+		return;
+	}
 
 	start = CURRENT->sector << 9;
 	len  = CURRENT->current_nr_sectors << 9;
diff -urN linux-2.5.17/drivers/cdrom/cdu31a.c linux/drivers/cdrom/cdu31a.c
--- linux-2.5.17/drivers/cdrom/cdu31a.c	2002-05-21 07:07:32.000000000 +0200
+++ linux/drivers/cdrom/cdu31a.c	2002-05-22 01:11:00.000000000 +0200
@@ -1598,7 +1598,8 @@
 		 * The beginning here is stolen from the hard disk driver.  I hope
 		 * it's right.
 		 */
-		if (QUEUE_EMPTY || CURRENT->rq_status == RQ_INACTIVE) {
+		if (blk_queue_empty(QUEUE)) {
+			CLEAR_INTR;
 			goto end_do_cdu31a_request;
 		}
 
@@ -1606,8 +1607,6 @@
 			scd_spinup();
 		}
 
-		INIT_REQUEST;
-
 		block = CURRENT->sector;
 		nblock = CURRENT->nr_sectors;
 
diff -urN linux-2.5.17/drivers/cdrom/cm206.c linux/drivers/cdrom/cm206.c
--- linux-2.5.17/drivers/cdrom/cm206.c	2002-05-21 07:07:36.000000000 +0200
+++ linux/drivers/cdrom/cm206.c	2002-05-22 01:10:17.000000000 +0200
@@ -856,9 +856,11 @@
 	uch *source, *dest;
 
 	while (1) {		/* repeat until all requests have been satisfied */
-		INIT_REQUEST;
-		if (QUEUE_EMPTY || CURRENT->rq_status == RQ_INACTIVE)
+		if (blk_queue_empty(QUEUE)) {
+			CLEAR_INTR;
 			return;
+		}
+
 		if (CURRENT->cmd != READ) {
 			debug(("Non-read command %d on cdrom\n",
 			       CURRENT->cmd));
diff -urN linux-2.5.17/drivers/cdrom/gscd.c linux/drivers/cdrom/gscd.c
--- linux-2.5.17/drivers/cdrom/gscd.c	2002-05-21 07:07:30.000000000 +0200
+++ linux/drivers/cdrom/gscd.c	2002-05-22 01:11:10.000000000 +0200
@@ -279,9 +279,11 @@
 	unsigned int nsect;
 
       repeat:
-	if (QUEUE_EMPTY || CURRENT->rq_status == RQ_INACTIVE)
-		goto out;
-	INIT_REQUEST;
+	if (blk_queue_empty(QUEUE)) {
+		CLEAR_INTR;
+		return;
+	}
+
 	dev = minor(CURRENT->rq_dev);
 	block = CURRENT->sector;
 	nsect = CURRENT->nr_sectors;
diff -urN linux-2.5.17/drivers/cdrom/mcdx.c linux/drivers/cdrom/mcdx.c
--- linux-2.5.17/drivers/cdrom/mcdx.c	2002-05-21 07:07:38.000000000 +0200
+++ linux/drivers/cdrom/mcdx.c	2002-05-22 01:09:54.000000000 +0200
@@ -562,19 +562,11 @@
 
       again:
 
-	if (QUEUE_EMPTY) {
-		xtrace(REQUEST, "end_request(0): CURRENT == NULL\n");
+	if (blk_queue_empty(QUEUE)) {
+		CLEAR_INTR;
 		return;
 	}
 
-	if (CURRENT->rq_status == RQ_INACTIVE) {
-		xtrace(REQUEST,
-		       "end_request(0): rq_status == RQ_INACTIVE\n");
-		return;
-	}
-
-	INIT_REQUEST;
-
 	dev = minor(CURRENT->rq_dev);
 	stuffp = mcdx_stuffp[dev];
 
diff -urN linux-2.5.17/drivers/cdrom/sbpcd.c linux/drivers/cdrom/sbpcd.c
--- linux-2.5.17/drivers/cdrom/sbpcd.c	2002-05-21 07:07:33.000000000 +0200
+++ linux/drivers/cdrom/sbpcd.c	2002-05-22 01:09:26.000000000 +0200
@@ -4915,12 +4915,15 @@
 	printk(" do_sbpcd_request[%di](%p:%ld+%ld), Pid:%d, Time:%li\n",
 		xnr, CURRENT, CURRENT->sector, CURRENT->nr_sectors, current->pid, jiffies);
 #endif
-	INIT_REQUEST;
+
+	if (blk_queue_empty(QUEUE)) {
+		CLEAR_INTR;
+		return;
+	}
+
 	req=CURRENT;		/* take out our request so no other */
 	blkdev_dequeue_request(req);	/* task can fuck it up         GTL  */
-	
-	if (req->rq_status == RQ_INACTIVE)
-		sbpcd_end_request(req, 0);
+
 	if (req -> sector == -1)
 		sbpcd_end_request(req, 0);
 	spin_unlock_irq(q->queue_lock);
diff -urN linux-2.5.17/drivers/cdrom/sonycd535.c linux/drivers/cdrom/sonycd535.c
--- linux-2.5.17/drivers/cdrom/sonycd535.c	2002-05-21 07:07:36.000000000 +0200
+++ linux/drivers/cdrom/sonycd535.c	2002-05-22 01:10:43.000000000 +0200
@@ -806,10 +806,11 @@
 		 * The beginning here is stolen from the hard disk driver.  I hope
 		 * it's right.
 		 */
-		if (QUEUE_EMPTY || CURRENT->rq_status == RQ_INACTIVE) {
+		if (blk_queue_empty(QUEUE)) {
+			CLEAR_INTR;
 			return;
 		}
-		INIT_REQUEST;
+
 		dev = minor(CURRENT->rq_dev);
 		block = CURRENT->sector;
 		nsect = CURRENT->nr_sectors;
diff -urN linux-2.5.17/drivers/ide/hd.c linux/drivers/ide/hd.c
--- linux-2.5.17/drivers/ide/hd.c	2002-05-21 07:07:32.000000000 +0200
+++ linux/drivers/ide/hd.c	2002-05-22 01:08:50.000000000 +0200
@@ -544,13 +544,17 @@
 {
 	unsigned int dev, block, nsect, sec, track, head, cyl;
 
-	if (!QUEUE_EMPTY && CURRENT->rq_status == RQ_INACTIVE) return;
 	if (DEVICE_INTR)
 		return;
 repeat:
 	del_timer(&device_timer);
 	sti();
-	INIT_REQUEST;
+
+	if (blk_queue_empty(QUEUE)) {
+		CLEAR_INTR;
+		return;
+	}
+
 	if (reset) {
 		cli();
 		reset_hd();
diff -urN linux-2.5.17/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.17/drivers/ide/ide-cd.c	2002-05-22 01:35:08.000000000 +0200
+++ linux/drivers/ide/ide-cd.c	2002-05-22 01:21:25.000000000 +0200
@@ -2658,6 +2658,47 @@
 	return nslots;
 }
 
+
+/*
+ * standard prep_rq_fn that builds 10 byte cmds
+ */
+static int ll_10byte_cmd_build(request_queue_t *q, struct request *rq)
+{
+	int hard_sect = queue_hardsect_size(q);
+	sector_t block = rq->hard_sector / (hard_sect >> 9);
+	unsigned long blocks = rq->hard_nr_sectors / (hard_sect >> 9);
+
+	if (!(rq->flags & REQ_CMD))
+		return 0;
+
+	if (rq->hard_nr_sectors != rq->nr_sectors) {
+		printk(KERN_ERR "ide-cd: hard_nr_sectors differs from nr_sectors! %lu %lu\n",
+				rq->nr_sectors, rq->hard_nr_sectors);
+	}
+	memset(rq->cmd, 0, sizeof(rq->cmd));
+
+	if (rq_data_dir(rq) == READ)
+		rq->cmd[0] = GPCMD_READ_10;
+	else
+		rq->cmd[0] = GPCMD_WRITE_10;
+
+	/*
+	 * fill in lba
+	 */
+	rq->cmd[2] = (block >> 24) & 0xff;
+	rq->cmd[3] = (block >> 16) & 0xff;
+	rq->cmd[4] = (block >>  8) & 0xff;
+	rq->cmd[5] = block & 0xff;
+
+	/*
+	 * and transfer length
+	 */
+	rq->cmd[7] = (blocks >> 8) & 0xff;
+	rq->cmd[8] = blocks & 0xff;
+
+	return 0;
+}
+
 static int ide_cdrom_setup(struct ata_device *drive)
 {
 	struct cdrom_info *info = drive->driver_data;
diff -urN linux-2.5.17/drivers/mtd/ftl.c linux/drivers/mtd/ftl.c
--- linux-2.5.17/drivers/mtd/ftl.c	2002-05-21 07:07:35.000000000 +0200
+++ linux/drivers/mtd/ftl.c	2002-05-22 00:59:41.000000000 +0200
@@ -1191,11 +1191,14 @@
     partition_t *part;
 
     do {
-      //	    sti();
-	INIT_REQUEST;
+	//	    sti();
+	if (blk_queue_empty(QUEUE)) {
+		CLEAR_INTR;
+		return;
+	}
 
 	minor = minor(CURRENT->rq_dev);
-	
+
 	part = myparts[minor >> 4];
 	if (part) {
 	  ret = 0;
diff -urN linux-2.5.17/drivers/mtd/mtdblock.c linux/drivers/mtd/mtdblock.c
--- linux-2.5.17/drivers/mtd/mtdblock.c	2002-05-21 07:07:37.000000000 +0200
+++ linux/drivers/mtd/mtdblock.c	2002-05-22 01:00:09.000000000 +0200
@@ -405,7 +405,11 @@
 	unsigned int res;
 
 	for (;;) {
-		INIT_REQUEST;
+		if (blk_queue_empty(QUEUE)) {
+			CLEAR_INTR;
+			return;
+		}
+
 		req = CURRENT;
 		spin_unlock_irq(QUEUE->queue_lock);
 		mtdblk = mtdblks[minor(req->rq_dev)];
diff -urN linux-2.5.17/drivers/mtd/mtdblock_ro.c linux/drivers/mtd/mtdblock_ro.c
--- linux-2.5.17/drivers/mtd/mtdblock_ro.c	2002-05-21 07:07:39.000000000 +0200
+++ linux/drivers/mtd/mtdblock_ro.c	2002-05-22 01:04:34.000000000 +0200
@@ -112,11 +112,15 @@
 
    while (1)
    {
-      /* Grab the Request and unlink it from the request list, INIT_REQUEST
-       	 will execute a return if we are done. */
-      INIT_REQUEST;
+      /* Grab the Request and unlink it from the request list, we
+	 will execute a return if we are done. */
+	if (blk_queue_empty(QUEUE)) {
+		CLEAR_INTR;
+		return;
+	}
+
       current_request = CURRENT;
-   
+
       if (minor(current_request->rq_dev) >= MAX_MTD_DEVICES)
       {
 	 printk("mtd: Unsupported device!\n");
diff -urN linux-2.5.17/drivers/mtd/nftlcore.c linux/drivers/mtd/nftlcore.c
--- linux-2.5.17/drivers/mtd/nftlcore.c	2002-05-21 07:07:30.000000000 +0200
+++ linux/drivers/mtd/nftlcore.c	2002-05-22 00:59:11.000000000 +0200
@@ -837,7 +837,11 @@
 	int res;
 
 	while (1) {
-		INIT_REQUEST;	/* blk.h */
+		if (blk_queue_empty(QUEUE)) {
+			CLEAR_INTR;
+			return;
+		}
+
 		req = CURRENT;
 		
 		/* We can do this because the generic code knows not to
diff -urN linux-2.5.17/drivers/s390/block/xpram.c linux/drivers/s390/block/xpram.c
--- linux-2.5.17/drivers/s390/block/xpram.c	2002-05-21 07:07:41.000000000 +0200
+++ linux/drivers/s390/block/xpram.c	2002-05-22 01:03:03.000000000 +0200
@@ -747,7 +747,10 @@
 #endif /* V24 */
 
 	while(1) {
-		INIT_REQUEST;
+		if (blk_queue_empty(QUEUE)) {
+			CLEAR_INTR;
+			return;
+		}
 
 		fault=0;
 #if ( XPRAM_VERSION == 24 )
diff -urN linux-2.5.17/drivers/sbus/char/jsflash.c linux/drivers/sbus/char/jsflash.c
--- linux-2.5.17/drivers/sbus/char/jsflash.c	2002-05-21 07:07:38.000000000 +0200
+++ linux/drivers/sbus/char/jsflash.c	2002-05-22 01:04:14.000000000 +0200
@@ -207,7 +207,11 @@
 	size_t len;
 
 	for (;;) {
-		INIT_REQUEST;	/* if (QUEUE_EMPTY) return; */
+		if (blk_queue_empty(QUEUE)) {
+			CLEAR_INTR;
+			return;
+		}
+
 		req = CURRENT;
 
 		dev = MINOR(req->rq_dev);
diff -urN linux-2.5.17/include/linux/blkdev.h linux/include/linux/blkdev.h
--- linux-2.5.17/include/linux/blkdev.h	2002-05-21 07:07:34.000000000 +0200
+++ linux/include/linux/blkdev.h	2002-05-21 23:57:17.000000000 +0200
@@ -303,7 +303,6 @@
 extern inline int blk_phys_contig_segment(request_queue_t *q, struct bio *, struct bio *);
 extern inline int blk_hw_contig_segment(request_queue_t *q, struct bio *, struct bio *);
 extern int block_ioctl(struct block_device *, unsigned int, unsigned long);
-extern int ll_10byte_cmd_build(request_queue_t *, struct request *);
 
 /*
  * get ready for proper ref counting
diff -urN linux-2.5.17/include/linux/blk.h linux/include/linux/blk.h
--- linux-2.5.17/include/linux/blk.h	2002-05-21 07:07:35.000000000 +0200
+++ linux/include/linux/blk.h	2002-05-22 01:17:31.000000000 +0200
@@ -313,22 +313,11 @@
 
 #define SET_INTR(x) (DEVICE_INTR = (x))
 
-#ifdef DEVICE_INTR
-#define CLEAR_INTR SET_INTR(NULL)
-#else
-#define CLEAR_INTR
-#endif
-
-#define INIT_REQUEST						\
-	if (QUEUE_EMPTY) {					\
-		CLEAR_INTR;					\
-		return;						\
-	}							\
-	if (major(CURRENT->rq_dev) != MAJOR_NR) 			\
-		panic(DEVICE_NAME ": request list destroyed");	\
-	if (!CURRENT->bio)					\
-		panic(DEVICE_NAME ": no bio");			\
-
+# ifdef DEVICE_INTR
+#  define CLEAR_INTR SET_INTR(NULL)
+# else
+#  define CLEAR_INTR
+# endif
 #endif /* !defined(IDE_DRIVER) */
 
 /*

--------------090105030206070502090908--

