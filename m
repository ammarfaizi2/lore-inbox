Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314289AbSDRKSc>; Thu, 18 Apr 2002 06:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314288AbSDRKSb>; Thu, 18 Apr 2002 06:18:31 -0400
Received: from [195.63.194.11] ([195.63.194.11]:26639 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314289AbSDRKS2>; Thu, 18 Apr 2002 06:18:28 -0400
Message-ID: <3CBE8EDD.8020400@evision-ventures.com>
Date: Thu, 18 Apr 2002 11:16:13 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.8 IDE 37
In-Reply-To: <Pine.LNX.4.33.0204051657270.16281-100000@penguin.transmeta.com> <3CBBED42.50003@evision-ventures.com>
Content-Type: multipart/mixed;
 boundary="------------070006080501050805020708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070006080501050805020708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Tough I have made some progress in the adaptation of
the IDE-CD code to the new request handling introduced alognside
with the TCQ stuff it's still isn't read for public consumption.
Therefore:

Wed Apr 17 23:24:52 CEST 2002 ide-clean-39

Synchronize with Jens Axobe:

- Congruent ATA_AR_POOL fix to the ATA_AR_STATIC memmory corruption fix.

- Multi sector write handling fix.

- Fix drive capability deduction.

- Various other minor fixes.

--------------070006080501050805020708
Content-Type: text/plain;
 name="ide-clean-39.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-39.diff"

diff -urN linux-2.5.8/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- linux-2.5.8/drivers/ide/ide-dma.c	Wed Apr 17 23:09:19 2002
+++ linux/drivers/ide/ide-dma.c	Wed Apr 17 23:28:22 2002
@@ -599,13 +599,19 @@
 			printk("%s: DMA disabled\n", drive->name);
 		case ide_dma_off_quietly:
 			set_high = 0;
-			drive->using_tcq = 0;
 			outb(inb(dma_base+2) & ~(1<<(5+unit)), dma_base+2);
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+			hwif->dmaproc(ide_dma_queued_off, drive);
+#endif
 		case ide_dma_on:
 			ide_toggle_bounce(drive, set_high);
 			drive->using_dma = (func == ide_dma_on);
-			if (drive->using_dma)
+			if (drive->using_dma) {
 				outb(inb(dma_base+2)|(1<<(5+unit)), dma_base+2);
+#ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
+				hwif->dmaproc(ide_dma_queued_on, drive);
+#endif
+			}
 			return 0;
 		case ide_dma_check:
 			return config_drive_for_dma (drive);
diff -urN linux-2.5.8/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.8/drivers/ide/ide-taskfile.c	Wed Apr 17 23:22:53 2002
+++ linux/drivers/ide/ide-taskfile.c	Wed Apr 17 23:28:22 2002
@@ -413,6 +413,20 @@
 	struct hd_driveid *id = drive->id;
 	u8 HIHI = (drive->addressing) ? 0xE0 : 0xEF;
 
+#if 0
+	printk("ata_taskfile ... %p\n", args->handler);
+
+	printk("   sector feature          %02x\n", args->taskfile.feature);
+	printk("   sector count            %02x\n", args->taskfile.sector_count);
+	printk("   drive/head              %02x\n", args->taskfile.device_head);
+	printk("   command                 %02x\n", args->taskfile.command);
+
+	if (rq)
+		printk("   rq->nr_sectors          %2li\n",  rq->nr_sectors);
+	else
+		printk("   rq->                   = null\n");
+#endif
+ 
 	/* (ks/hs): Moved to start, do not use for multiple out commands */
 	if (args->handler != task_mulout_intr) {
 		if (IDE_CONTROL_REG)
@@ -577,18 +591,22 @@
 	ata_read(drive, pBuf, SECTOR_WORDS);
 	ide_unmap_rq(rq, pBuf, &flags);
 
+	/*
+	 * first segment of the request is complete. note that this does not
+	 * necessarily mean that the entire request is done!! this is only
+	 * true if ide_end_request() returns 0.
+	 */
 	if (--rq->current_nr_sectors <= 0) {
-		/* (hs): swapped next 2 lines */
 		DTF("Request Ended stat: %02x\n", GET_STAT());
-		if (ide_end_request(drive, 1)) {
-			ide_set_handler(drive, &task_in_intr,  WAIT_CMD, NULL);
-			return ide_started;
-		}
-	} else {
-		ide_set_handler(drive, &task_in_intr,  WAIT_CMD, NULL);
-		return ide_started;
+		if (!ide_end_request(drive, 1))
+			return ide_stopped;
 	}
-	return ide_stopped;
+
+	/*
+	 * still data left to transfer
+	 */
+	ide_set_handler(drive, &task_in_intr,  WAIT_CMD, NULL);
+	return ide_started;
 }
 
 static ide_startstop_t pre_task_out_intr(ide_drive_t *drive, struct request *rq)
@@ -874,7 +892,6 @@
 			return;
 
 		case WIN_NOP:
-
 			args->command_type = IDE_DRIVE_TASK_NO_DATA;
 			return;
 
@@ -904,11 +921,6 @@
 	struct ata_request star;
 
 	ata_ar_init(drive, &star);
-
-	/* Don't put this request on free_req list after usage.
-	 */
-	star.ar_flags |= ATA_AR_STATIC;
-
 	init_taskfile_request(&rq);
 	rq.buffer = buf;
 
diff -urN linux-2.5.8/drivers/ide/ide-tcq.c linux/drivers/ide/ide-tcq.c
--- linux-2.5.8/drivers/ide/ide-tcq.c	Wed Apr 17 23:09:14 2002
+++ linux/drivers/ide/ide-tcq.c	Wed Apr 17 23:28:22 2002
@@ -51,21 +51,17 @@
  */
 #undef IDE_TCQ_FIDDLE_SI
 
-/*
- * wait for data phase before starting DMA or not
- */
-#undef IDE_TCQ_WAIT_DATAPHASE
-
 ide_startstop_t ide_dmaq_intr(ide_drive_t *drive);
 ide_startstop_t ide_service(ide_drive_t *drive);
 
 static inline void drive_ctl_nien(ide_drive_t *drive, int clear)
 {
 #ifdef IDE_TCQ_NIEN
-	int mask = clear ? 0x00 : 0x02;
+	if (IDE_CONTROL_REG) {
+		int mask = clear ? 0x00 : 0x02;
 
-	if (IDE_CONTROL_REG)
 		OUT_BYTE(drive->ctl | mask, IDE_CONTROL_REG);
+	}
 #endif
 }
 
@@ -123,7 +119,6 @@
 	init_taskfile_request(ar->ar_rq);
 	ar->ar_rq->rq_dev = mk_kdev(drive->channel->major, (drive->select.b.unit)<<PARTN_BITS);
 	ar->ar_rq->special = ar;
-	ar->ar_flags |= ATA_AR_RETURN;
 	_elv_add_request(q, ar->ar_rq, 0, 0);
 
 	/*
@@ -222,7 +217,7 @@
 {
 	struct ata_request *ar;
 	byte feat, stat;
-	int tag;
+	int tag, ret;
 
 	TCQ_PRINTK("%s: started service\n", drive->name);
 
@@ -272,9 +267,6 @@
 		return ide_stopped;
 	}
 
-	/*
-	 * start dma
-	 */
 	tag = feat >> 3;
 	IDE_SET_CUR_TAG(drive, tag);
 
@@ -293,16 +285,16 @@
 	 */
 	if (rq_data_dir(ar->ar_rq) == READ) {
 		TCQ_PRINTK("ide_service: starting READ %x\n", stat);
-		drive->channel->dmaproc(ide_dma_read_queued, drive);
+		ret = drive->channel->dmaproc(ide_dma_read_queued, drive);
 	} else {
 		TCQ_PRINTK("ide_service: starting WRITE %x\n", stat);
-		drive->channel->dmaproc(ide_dma_write_queued, drive);
+		ret = drive->channel->dmaproc(ide_dma_write_queued, drive);
 	}
 
 	/*
 	 * dmaproc set intr handler
 	 */
-	return ide_started;
+	return !ret ? ide_started : ide_stopped;
 }
 
 ide_startstop_t ide_check_service(ide_drive_t *drive)
@@ -410,14 +402,15 @@
  */
 static int ide_tcq_configure(ide_drive_t *drive)
 {
+	int tcq_mask = 1 << 1 | 1 << 14;
+	int tcq_bits = tcq_mask | 1 << 15;
 	struct ata_taskfile args;
-	int tcq_supp = 1 << 1 | 1 << 14;
 
 	/*
 	 * bit 14 and 1 must be set in word 83 of the device id to indicate
-	 * support for dma queued protocol
+	 * support for dma queued protocol, and bit 15 must be cleared
 	 */
-	if ((drive->id->command_set_2 & tcq_supp) != tcq_supp)
+	if ((drive->id->command_set_2 & tcq_bits) ^ tcq_mask)
 		return -EIO;
 
 	memset(&args, 0, sizeof(args));
@@ -477,11 +470,14 @@
  */
 static int ide_enable_queued(ide_drive_t *drive, int on)
 {
+	int depth = drive->using_tcq ? drive->queue_depth : 0;
+
 	/*
 	 * disable or adjust queue depth
 	 */
 	if (!on) {
-		printk("%s: TCQ disabled\n", drive->name);
+		if (drive->using_tcq)
+			printk("%s: TCQ disabled\n", drive->name);
 		drive->using_tcq = 0;
 		return 0;
 	}
@@ -491,25 +487,33 @@
 		return 1;
 	}
 
+	/*
+	 * possibly expand command list
+	 */
 	if (ide_build_commandlist(drive))
 		return 1;
 
-	printk("%s: tagged command queueing enabled, command queue depth %d\n", drive->name, drive->queue_depth);
+	if (depth != drive->queue_depth)
+		printk("%s: tagged command queueing enabled, command queue depth %d\n", drive->name, drive->queue_depth);
+
 	drive->using_tcq = 1;
+
+	/*
+	 * clear stats
+	 */
 	drive->tcq->max_depth = 0;
 	return 0;
 }
 
 int ide_tcq_wait_dataphase(ide_drive_t *drive)
 {
-#ifdef IDE_TCQ_WAIT_DATAPHASE
 	ide_startstop_t foo;
 
-	if (ide_wait_stat(&startstop, drive, READY_STAT | DRQ_STAT, BUSY_STAT, WAIT_READY)) {
+	if (ide_wait_stat(&foo, drive, READY_STAT | DRQ_STAT, BUSY_STAT, WAIT_READY)) {
 		printk("%s: timeout waiting for data phase\n", drive->name);
 		return 1;
 	}
-#endif
+
 	return 0;
 }
 
@@ -595,6 +599,8 @@
 			if (ide_start_dma(hwif, drive, func))
 				return ide_stopped;
 
+			TCQ_PRINTK("IMMED in queued_start\n");
+
 			/*
 			 * need to arm handler before starting dma engine,
 			 * transfer could complete right away
@@ -612,6 +618,8 @@
 		case ide_dma_queued_off:
 			enable_tcq = 0;
 		case ide_dma_queued_on:
+			if (enable_tcq && !drive->using_dma)
+				return 1;
 			return ide_enable_queued(drive, enable_tcq);
 		default:
 			break;
diff -urN linux-2.5.8/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.8/drivers/ide/ide.c	Wed Apr 17 23:22:53 2002
+++ linux/drivers/ide/ide.c	Wed Apr 17 23:28:22 2002
@@ -803,8 +803,7 @@
 				args->hobfile.high_cylinder = IN_BYTE(IDE_HCYL_REG);
 			}
 		}
-		if (ar->ar_flags & ATA_AR_RETURN)
-			ata_ar_put(drive, ar);
+		ata_ar_put(drive, ar);
 	}
 
 	blkdev_dequeue_request(rq);
diff -urN linux-2.5.8/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.8/include/linux/ide.h	Wed Apr 17 23:22:53 2002
+++ linux/include/linux/ide.h	Wed Apr 17 23:30:30 2002
@@ -968,10 +968,9 @@
 /*
  * ata_request flag bits
  */
-#define ATA_AR_QUEUED	1
-#define ATA_AR_SETUP	2
-#define ATA_AR_RETURN	4
-#define ATA_AR_STATIC	8
+#define ATA_AR_QUEUED	1	/* was queued */
+#define ATA_AR_SETUP	2	/* dma table mapped */
+#define ATA_AR_POOL	4	/* originated from drive pool */
 
 /*
  * if turn-around time is longer than this, halve queue depth
@@ -1003,8 +1002,10 @@
 
 	if (!list_empty(&drive->free_req)) {
 		ar = list_ata_entry(drive->free_req.next);
+
 		list_del(&ar->ar_queue);
 		ata_ar_init(drive, ar);
+		ar->ar_flags |= ATA_AR_POOL;
 	}
 
 	return ar;
@@ -1012,8 +1013,8 @@
 
 static inline void ata_ar_put(ide_drive_t *drive, struct ata_request *ar)
 {
-	if (!(ar->ar_flags & ATA_AR_STATIC))
-	    list_add(&ar->ar_queue, &drive->free_req);
+	if (ar->ar_flags & ATA_AR_POOL)
+		list_add(&ar->ar_queue, &drive->free_req);
 
 	if (ar->ar_flags & ATA_AR_QUEUED) {
 		/* clear the tag */

--------------070006080501050805020708--

