Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314268AbSDVQjM>; Mon, 22 Apr 2002 12:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314266AbSDVQjL>; Mon, 22 Apr 2002 12:39:11 -0400
Received: from [195.63.194.11] ([195.63.194.11]:38158 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314268AbSDVQjJ>; Mon, 22 Apr 2002 12:39:09 -0400
Message-ID: <3CC42E0D.7060703@evision-ventures.com>
Date: Mon, 22 Apr 2002 17:36:45 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.8 IDE 40
In-Reply-To: <Pine.LNX.4.33.0203181243210.10517-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------070603060200040408010108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070603060200040408010108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Thu Apr 18 00:08:00 CEST 2002 ide-clean-40

This applies on top of 2.5.8, all patches up to IDE 39 + the laters ide-update
for 2.5.8. from Jens Axboe.

- Make the ide-cd driver usable again in DMA mode by adapting it to the TCQ
   related request handling changes and fixing some other minor stuff related to
   this. This patch is ugly like hell I know. Cleanup will follow separately.
   It was hard enough to make this going agian at all.

--------------070603060200040408010108
Content-Type: text/plain;
 name="ide-clean-40.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-40.diff"

diff -urN linux-2.5.8/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.8/drivers/ide/ide-cd.c	Mon Apr 22 18:31:37 2002
+++ linux/drivers/ide/ide-cd.c	Mon Apr 22 18:23:43 2002
@@ -535,9 +535,9 @@
 
 	/* stuff the sense request in front of our current request */
 	rq = &info->request_sense_request;
+	ide_init_drive_cmd(rq);
 	rq->cmd[0] = GPCMD_REQUEST_SENSE;
 	rq->cmd[4] = pc->buflen;
-	ide_init_drive_cmd(rq);
 	rq->flags = REQ_SENSE;
 
 	/* FIXME --mdcki */
@@ -558,8 +558,10 @@
 	if ((rq->flags & REQ_CMD) && !rq->current_nr_sectors)
 		uptodate = 1;
 
+#if 0
 	/* FIXME --mdcki */
 	HWGROUP(drive)->rq->special = NULL;
+#endif
 	ide_end_request(drive, uptodate);
 }
 
@@ -1215,13 +1217,22 @@
 /*
  * Start a read request from the CD-ROM.
  */
-static ide_startstop_t cdrom_start_read (ide_drive_t *drive, unsigned int block)
+static ide_startstop_t cdrom_start_read(struct ata_device *drive, struct ata_request *ar, unsigned int block)
 {
 	struct cdrom_info *info = drive->driver_data;
-	struct request *rq = HWGROUP(drive)->rq;
+	struct request *rq = ar->ar_rq;
+
+	if (ar->ar_flags & ATA_AR_QUEUED) {
+//		spin_lock_irqsave(DRIVE_LOCK(drive), flags);
+		blkdev_dequeue_request(rq);
+//		spin_unlock_irqrestore(DRIVE_LOCK(drive), flags);
+	}
+
 
 	restore_request(rq);
 
+	rq->special = ar;
+
 	/* Satisfy whatever we can of this request from our cached sector. */
 	if (cdrom_read_from_buffer(drive))
 		return ide_stopped;
@@ -1404,10 +1415,10 @@
 	struct request rq;
 	int retries = 10;
 
-	memcpy(rq.cmd, cmd, CDROM_PACKET_SIZE);
 	/* Start of retry loop. */
 	do {
 		ide_init_drive_cmd(&rq);
+		memcpy(rq.cmd, cmd, CDROM_PACKET_SIZE);
 
 		rq.flags = REQ_PC;
 
@@ -1630,12 +1641,14 @@
  * cdrom driver request routine.
  */
 static ide_startstop_t
-ide_do_rw_cdrom(ide_drive_t *drive, struct request *rq, unsigned long block)
+ide_cdrom_do_request(struct ata_device *drive, struct request *rq, sector_t block)
 {
 	ide_startstop_t action;
 	struct cdrom_info *info = drive->driver_data;
 
 	if (rq->flags & REQ_CMD) {
+	
+
 		if (CDROM_CONFIG_FLAGS(drive)->seeking) {
 			unsigned long elpased = jiffies - info->start_seek;
 			int stat = GET_STAT();
@@ -1652,8 +1665,30 @@
 		if (IDE_LARGE_SEEK(info->last_block, block, IDECD_SEEK_THRESHOLD) && drive->dsc_overlap)
 			action = cdrom_start_seek (drive, block);
 		else {
+			unsigned long flags;
+			struct ata_request *ar;
+
+			/*
+			 * get a new command (push ar further down to avoid grabbing lock here
+			 */
+			spin_lock_irqsave(DRIVE_LOCK(drive), flags);
+
+			ar = ata_ar_get(drive);
+
+			/*
+			 * we've reached maximum queue depth, bail
+			 */
+			if (!ar) {
+				spin_unlock_irqrestore(DRIVE_LOCK(drive), flags);
+
+				return ide_started;
+			}
+
+			ar->ar_rq = rq;
+			spin_unlock_irqrestore(DRIVE_LOCK(drive), flags);
+
 			if (rq_data_dir(rq) == READ)
-				action = cdrom_start_read(drive, block);
+				action = cdrom_start_read(drive, ar, block);
 			else
 				action = cdrom_start_write(drive, rq);
 		}
@@ -2297,7 +2332,7 @@
 	struct request req;
 	int ret;
 
-	ide_init_drive_cmd (&req);
+	ide_init_drive_cmd(&req);
 	req.flags = REQ_SPECIAL;
 	ret = ide_do_drive_cmd(drive, &req, ide_wait);
 
@@ -2927,7 +2962,7 @@
 	owner:			THIS_MODULE,
 	cleanup:		ide_cdrom_cleanup,
 	standby:		NULL,
-	do_request:		ide_do_rw_cdrom,
+	do_request:		ide_cdrom_do_request,
 	end_request:		NULL,
 	ioctl:			ide_cdrom_ioctl,
 	open:			ide_cdrom_open,
diff -urN linux-2.5.8/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- linux-2.5.8/drivers/ide/ide-dma.c	Mon Apr 22 18:31:40 2002
+++ linux/drivers/ide/ide-dma.c	Mon Apr 22 13:19:24 2002
@@ -549,8 +549,11 @@
 	/* This can happen with drivers abusing the special request field.
 	 */
 
-	if (!ar)
+	if (!ar) {
+		printk(KERN_ERR "DMA without ATA request\n");
+
 		return 1;
+	}
 
 	if (rq_data_dir(ar->ar_rq) == READ)
 		reading = 1 << 3;
diff -urN linux-2.5.8/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux-2.5.8/drivers/ide/ide-probe.c	Mon Apr 22 18:31:32 2002
+++ linux/drivers/ide/ide-probe.c	Mon Apr 22 18:08:45 2002
@@ -168,6 +168,9 @@
 		}
 		printk (" drive\n");
 		drive->type = type;
+
+		goto init_queue;
+
 		return;
 	}
 
@@ -198,6 +201,7 @@
 	if (drive->channel->quirkproc)
 		drive->quirk_list = drive->channel->quirkproc(drive);
 
+init_queue:
 	/*
 	 * it's an ata drive, build command list
 	 */

--------------070603060200040408010108--

