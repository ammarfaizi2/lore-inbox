Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287578AbSBOIHw>; Fri, 15 Feb 2002 03:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287588AbSBOIHj>; Fri, 15 Feb 2002 03:07:39 -0500
Received: from [195.63.194.11] ([195.63.194.11]:55565 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S287578AbSBOIHN>; Fri, 15 Feb 2002 03:07:13 -0500
Message-ID: <3C6CC19C.3040608@evision-ventures.com>
Date: Fri, 15 Feb 2002 09:06:52 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Vojtech Pavlik <vojtech@suse.cz>, Jens Axboe <axboe@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Re: IDE cleanup for 2.5.4-pre3
In-Reply-To: <20020208231346.GA1209@elf.ucw.cz> <20020211094230.E1957@suse.de> <20020211134443.GC20854@atrey.karlin.mff.cuni.cz> <20020211181013.K729@suse.de> <20020213225326.A10409@suse.cz> <20020214094046.B37@toy.ucw.cz>
Content-Type: multipart/mixed;
 boundary="------------010801000802010208070303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010801000802010208070303
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

And here is a some more extreme cleanup:

It seems bigger as it is at first glance, however if you start to read 
it at ide.h, the rest should
be, well,  obivous...

Anyway please let me explain some bits: the end_request() function familiy
(not the global one, but the IDE specific ones), did bear a permuted 
parameter ordering.
After fixing this it turned out that at all places the huk parameter 
wasn't the
hwgroup, but just the drive in question itself. I have changed this to
be more sane, which allowed to remove many unneccessary code duplication,
or rather obfuscation, in between the __ide_end_request() and 
ide_end_request() functions.
This simplification is actually the "spreading" part of the game.

In a next step rather as much as possible should be moved from beeing 
hooked on
the disk to be hooked on the request itself - which seems more natural 
and would make
the overall code treamlined with other similar driver mid-layers (SCSI 
comes to mind).

In a third step one should take care to remove the excessive usage of 
single linked
lists inside the ide driver, where possible and make it be handled the 
same way like
in SCSI and elsewere in the kernel... The overall perspecive is to make 
as much as possible
common between all block device handlers no matter whatever SCSI/IDE/I2O 
or FW or iSCSI.

I have taken as much care as possible to not break anything. In esp. it 
all has ben tested
in life on my home system with L120 (aka ide-floppy), an CD-RW, and two 
disks.
The only blind fly is ide-tape... but the patch can be easly verifyed 
for correctness by reading
through it.

PS. I have killed deliberately some one-shoot functions as well, since 
those where only
obscuring the overall code structure even more....


--------------010801000802010208070303
Content-Type: text/plain;
 name="ide-cleanup-7.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-cleanup-7.patch"

diff -ur linux-2.5.4/arch/cris/drivers/ide.c linux/arch/cris/drivers/ide.c
--- linux-2.5.4/arch/cris/drivers/ide.c	Mon Feb 11 02:50:12 2002
+++ linux/arch/cris/drivers/ide.c	Fri Feb 15 08:53:07 2002
@@ -727,7 +727,7 @@
 			rq = HWGROUP(drive)->rq;
 			for (i = rq->nr_sectors; i > 0;) {
 				i -= rq->current_nr_sectors;
-				ide_end_request(1, HWGROUP(drive));
+				ide_end_request(drive, 1);
 			}
 			return ide_stopped;
 		}
diff -ur linux-2.5.4/drivers/ide/icside.c linux/drivers/ide/icside.c
--- linux-2.5.4/drivers/ide/icside.c	Mon Feb 11 02:50:09 2002
+++ linux/drivers/ide/icside.c	Fri Feb 15 08:53:07 2002
@@ -341,7 +341,7 @@
 			rq = HWGROUP(drive)->rq;
 			for (i = rq->nr_sectors; i > 0;) {
 				i -= rq->current_nr_sectors;
-				ide_end_request(1, HWGROUP(drive));
+				ide_end_request(drive, 1);
 			}
 			return ide_stopped;
 		}
diff -ur linux-2.5.4/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.4/drivers/ide/ide-cd.c	Mon Feb 11 02:50:16 2002
+++ linux/drivers/ide/ide-cd.c	Fri Feb 15 08:53:07 2002
@@ -540,7 +540,7 @@
 }
 
 
-static void cdrom_end_request (int uptodate, ide_drive_t *drive)
+static void cdrom_end_request(ide_drive_t *drive, int uptodate)
 {
 	struct request *rq = HWGROUP(drive)->rq;
 
@@ -554,7 +554,7 @@
 	if ((rq->flags & REQ_CMD) && !rq->current_nr_sectors)
 		uptodate = 1;
 
-	ide_end_request(uptodate, HWGROUP(drive));
+	ide_end_request(drive, uptodate);
 }
 
 
@@ -591,7 +591,7 @@
 
 		pc = (struct packet_command *) rq->special;
 		pc->stat = 1;
-		cdrom_end_request (1, drive);
+		cdrom_end_request(drive, 1);
 		*startstop = ide_error (drive, "request sense failure", stat);
 		return 1;
 	} else if (rq->flags & (REQ_PC | REQ_BLOCK_PC)) {
@@ -627,7 +627,7 @@
 		}
 
 		pc->stat = 1;
-		cdrom_end_request (1, drive);
+		cdrom_end_request(drive, 1);
 
 		if ((stat & ERR_STAT) != 0)
 			cdrom_queue_request_sense(drive, wait, pc->sense, pc);
@@ -640,7 +640,7 @@
 
 			/* Fail the request. */
 			printk ("%s: tray open\n", drive->name);
-			cdrom_end_request (0, drive);
+			cdrom_end_request(drive, 0);
 		} else if (sense_key == UNIT_ATTENTION) {
 			/* Media change. */
 			cdrom_saw_media_change (drive);
@@ -649,13 +649,13 @@
 			   But be sure to give up if we've retried
 			   too many times. */
 			if (++rq->errors > ERROR_MAX)
-				cdrom_end_request (0, drive);
+				cdrom_end_request(drive, 0);
 		} else if (sense_key == ILLEGAL_REQUEST ||
 			   sense_key == DATA_PROTECT) {
 			/* No point in retrying after an illegal
 			   request or data protect error.*/
 			ide_dump_status (drive, "command error", stat);
-			cdrom_end_request (0, drive);
+			cdrom_end_request(drive, 0);
 		} else if ((err & ~ABRT_ERR) != 0) {
 			/* Go to the default handler
 			   for other errors. */
@@ -663,7 +663,7 @@
 			return 1;
 		} else if ((++rq->errors > ERROR_MAX)) {
 			/* We've racked up too many retries.  Abort. */
-			cdrom_end_request (0, drive);
+			cdrom_end_request(drive, 0);
 		}
 
 		/* If we got a CHECK_CONDITION status,
@@ -879,7 +879,7 @@
 			drive->name, ireason);
 	}
 
-	cdrom_end_request (0, drive);
+	cdrom_end_request(drive, 0);
 	return -1;
 }
 
@@ -908,7 +908,7 @@
  
 	if (dma) {
 		if (!dma_error) {
-			__ide_end_request(HWGROUP(drive), 1, rq->nr_sectors);
+			__ide_end_request(drive, 1, rq->nr_sectors);
 			return ide_stopped;
 		} else
 			return ide_error (drive, "dma error", stat);
@@ -925,9 +925,9 @@
 		if (rq->current_nr_sectors > 0) {
 			printk ("%s: cdrom_read_intr: data underrun (%u blocks)\n",
 				drive->name, rq->current_nr_sectors);
-			cdrom_end_request (0, drive);
+			cdrom_end_request(drive, 0);
 		} else
-			cdrom_end_request (1, drive);
+			cdrom_end_request(drive, 1);
 		return ide_stopped;
 	}
 
@@ -947,7 +947,7 @@
 			printk ("  Trying to limit transfer sizes\n");
 			CDROM_CONFIG_FLAGS (drive)->limit_nframes = 1;
 		}
-		cdrom_end_request (0, drive);
+		cdrom_end_request(drive, 0);
 		return ide_stopped;
 	}
 
@@ -975,7 +975,7 @@
 		/* If we've filled the present buffer but there's another
 		   chained buffer after it, move on. */
 		if (rq->current_nr_sectors == 0 && rq->nr_sectors)
-			cdrom_end_request (1, drive);
+			cdrom_end_request(drive, 1);
 
 		/* If the buffers are full, cache the rest of the data in our
 		   internal buffer. */
@@ -1027,7 +1027,7 @@
 	       rq->sector >= info->sector_buffered &&
 	       rq->sector < info->sector_buffered + info->nsectors_buffered) {
 		if (rq->current_nr_sectors == 0)
-			cdrom_end_request (1, drive);
+			cdrom_end_request(drive, 1);
 
 		memcpy (rq->buffer,
 			info->buffer +
@@ -1042,13 +1042,13 @@
 	/* If we've satisfied the current request,
 	   terminate it successfully. */
 	if (rq->nr_sectors == 0) {
-		cdrom_end_request (1, drive);
+		cdrom_end_request(drive, 1);
 		return -1;
 	}
 
 	/* Move on to the next buffer if needed. */
 	if (rq->current_nr_sectors == 0)
-		cdrom_end_request (1, drive);
+		cdrom_end_request(drive, 1);
 
 	/* If this condition does not hold, then the kluge i use to
 	   represent the number of sectors to skip at the start of a transfer
@@ -1058,7 +1058,7 @@
 	    (rq->sector % SECTORS_PER_FRAME) != 0) {
 		printk ("%s: cdrom_read_from_buffer: buffer botch (%ld)\n",
 			drive->name, rq->sector);
-		cdrom_end_request (0, drive);
+		cdrom_end_request(drive, 0);
 		return -1;
 	}
 
@@ -1097,7 +1097,7 @@
 			(rq->sector % CD_FRAMESIZE != 0)) {
 			printk ("%s: cdrom_start_read_continuation: buffer botch (%u)\n",
 				drive->name, rq->current_nr_sectors);
-			cdrom_end_request (0, drive);
+			cdrom_end_request(drive, 0);
 			return ide_stopped;
 		}
 		sector -= nskip;
@@ -1273,17 +1273,17 @@
 		}
 
 		if (pc->buflen == 0)
-			cdrom_end_request (1, drive);
+			cdrom_end_request(drive, 1);
 		else {
-			/* Comment this out, because this always happens 
-			   right after a reset occurs, and it is annoying to 
+			/* Comment this out, because this always happens
+			   right after a reset occurs, and it is annoying to
 			   always print expected stuff.  */
 			/*
 			printk ("%s: cdrom_pc_intr: data underrun %d\n",
 				drive->name, pc->buflen);
 			*/
 			pc->stat = 1;
-			cdrom_end_request (1, drive);
+			cdrom_end_request(drive, 1);
 		}
 		return ide_stopped;
 	}
@@ -1460,7 +1460,7 @@
 			drive->name, ireason);
 	}
 
-	cdrom_end_request(0, drive);
+	cdrom_end_request(drive, 0);
 	return 1;
 }
 
@@ -1495,7 +1495,7 @@
 			return ide_error(drive, "dma error", stat);
 
 		rq = HWGROUP(drive)->rq;
-		__ide_end_request(HWGROUP(drive), 1, rq->nr_sectors);
+		__ide_end_request(drive, 1, rq->nr_sectors);
 		return ide_stopped;
 	}
 
@@ -1514,7 +1514,7 @@
 			drive->name, rq->current_nr_sectors);
 			uptodate = 0;
 		}
-		cdrom_end_request(uptodate, drive);
+		cdrom_end_request(drive, uptodate);
 		return ide_stopped;
 	}
 
@@ -1555,7 +1555,7 @@
 		 * current buffer complete, move on
 		 */
 		if (rq->current_nr_sectors == 0 && rq->nr_sectors)
-			cdrom_end_request (1, drive);
+			cdrom_end_request(drive, 1);
 	}
 
 	/* re-arm handler */
@@ -1589,7 +1589,7 @@
 	 * writes *must* be 2kB frame aligned
 	 */
 	if ((rq->nr_sectors & 3) || (rq->sector & 3)) {
-		cdrom_end_request(0, drive);
+		cdrom_end_request(drive, 0);
 		return ide_stopped;
 	}
 
@@ -1673,14 +1673,14 @@
 		/*
 		 * right now this can only be a reset...
 		 */
-		cdrom_end_request(1, drive);
+		cdrom_end_request(drive, 1);
 		return ide_do_reset(drive);
 	} else if (rq->flags & REQ_BLOCK_PC) {
 		return cdrom_do_block_pc(drive, rq);
 	}
 
 	blk_dump_rq_flags(rq, "ide-cd bad flags");
-	cdrom_end_request(0, drive);
+	cdrom_end_request(drive, 0);
 	return ide_stopped;
 }
 
@@ -2915,7 +2915,6 @@
 
 static ide_driver_t ide_cdrom_driver = {
 	name:			"ide-cdrom",
-	version:		IDECD_VERSION,
 	media:			ide_cdrom,
 	busy:			0,
 	supports_dma:		1,
diff -ur linux-2.5.4/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.4/drivers/ide/ide-disk.c	Fri Feb 15 08:57:37 2002
+++ linux/drivers/ide/ide-disk.c	Fri Feb 15 08:53:07 2002
@@ -125,7 +125,7 @@
 {
 	if (!(rq->flags & REQ_CMD)) {
 		blk_dump_rq_flags(rq, "do_rw_disk, bad command");
-		ide_end_request(0, HWGROUP(drive));
+		ide_end_request(drive, 0);
 		return ide_stopped;
 	}
 
@@ -324,7 +324,6 @@
 	args.posthandler	= NULL;
 	args.rq			= (struct request *) rq;
 	args.block		= block;
-	rq->special		= NULL;
 	rq->special		= (ide_task_t *)&args;
 
 	return do_rw_taskfile(drive, &args);
@@ -1042,7 +1041,6 @@
  */
 static ide_driver_t idedisk_driver = {
 	name:			"ide-disk",
-	version:		IDEDISK_VERSION,
 	media:			ide_disk,
 	busy:			0,
 	supports_dma:		1,
diff -ur linux-2.5.4/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- linux-2.5.4/drivers/ide/ide-dma.c	Fri Feb 15 08:57:37 2002
+++ linux/drivers/ide/ide-dma.c	Fri Feb 15 08:53:07 2002
@@ -215,7 +215,7 @@
 		if (!dma_stat) {
 			struct request *rq = HWGROUP(drive)->rq;
 
-			__ide_end_request(HWGROUP(drive), 1, rq->nr_sectors);
+			__ide_end_request(drive, 1, rq->nr_sectors);
 			return ide_stopped;
 		}
 		printk("%s: dma_intr: bad DMA status (dma_stat=%x)\n", 
diff -ur linux-2.5.4/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux-2.5.4/drivers/ide/ide-floppy.c	Mon Feb 11 02:50:12 2002
+++ linux/drivers/ide/ide-floppy.c	Fri Feb 15 08:53:07 2002
@@ -667,11 +667,10 @@
  *	For read/write requests, we will call ide_end_request to pass to the
  *	next buffer.
  */
-static void idefloppy_end_request (byte uptodate, ide_hwgroup_t *hwgroup)
+static int idefloppy_end_request(ide_drive_t *drive, int uptodate)
 {
-	ide_drive_t *drive = hwgroup->drive;
 	idefloppy_floppy_t *floppy = drive->driver_data;
-	struct request *rq = hwgroup->rq;
+	struct request *rq = HWGROUP(drive)->rq;
 	int error;
 
 #if IDEFLOPPY_DEBUG_LOG
@@ -687,13 +686,15 @@
 		floppy->failed_pc = NULL;
 	/* Why does this happen? */
 	if (!rq)
-		return;
+		return 0;
 	if (!(rq->flags & IDEFLOPPY_RQ)) {
-		ide_end_request (uptodate, hwgroup);
-		return;
+		ide_end_request(drive, uptodate);
+		return 0;
 	}
 	rq->errors = error;
 	ide_end_drive_cmd (drive, 0, 0);
+
+	return 0;
 }
 
 static void idefloppy_input_buffers (ide_drive_t *drive, idefloppy_pc_t *pc, unsigned int bcount)
@@ -706,7 +707,7 @@
 		if (pc->b_count == bio->bi_size) {
 			rq->sector += rq->current_nr_sectors;
 			rq->nr_sectors -= rq->current_nr_sectors;
-			idefloppy_end_request (1, HWGROUP(drive));
+			idefloppy_end_request(drive, 1);
 			if ((bio = rq->bio) != NULL)
 				pc->b_count = 0;
 		}
@@ -731,7 +732,7 @@
 		if (!pc->b_count) {
 			rq->sector += rq->current_nr_sectors;
 			rq->nr_sectors -= rq->current_nr_sectors;
-			idefloppy_end_request (1, HWGROUP(drive));
+			idefloppy_end_request(drive, 1);
 			if ((bio = rq->bio) != NULL) {
 				pc->b_data = bio_data(bio);
 				pc->b_count = bio->bi_size;
@@ -755,7 +756,7 @@
 	struct bio *bio = rq->bio;
 
 	while ((bio = rq->bio) != NULL)
-		idefloppy_end_request (1, HWGROUP(drive));
+		idefloppy_end_request(drive, 1);
 }
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 
@@ -818,10 +819,10 @@
 #endif /* IDEFLOPPY_DEBUG_LOG */
 	if (!floppy->pc->error) {
 		idefloppy_analyze_error (drive,(idefloppy_request_sense_result_t *) floppy->pc->buffer);
-		idefloppy_end_request (1,HWGROUP (drive));
+		idefloppy_end_request(drive, 1);
 	} else {
 		printk (KERN_ERR "Error in REQUEST SENSE itself - Aborting request!\n");
-		idefloppy_end_request (0,HWGROUP (drive));
+		idefloppy_end_request(drive, 0);
 	}
 }
 
@@ -836,7 +837,7 @@
 	printk (KERN_INFO "ide-floppy: Reached idefloppy_pc_callback\n");
 #endif /* IDEFLOPPY_DEBUG_LOG */
 
-	idefloppy_end_request (floppy->pc->error ? 0:1, HWGROUP(drive));
+	idefloppy_end_request(drive, floppy->pc->error ? 0:1);
 }
 
 /*
@@ -1159,7 +1160,7 @@
 	printk (KERN_INFO "ide-floppy: Reached idefloppy_rw_callback\n");
 #endif /* IDEFLOPPY_DEBUG_LOG */
 
-	idefloppy_end_request(1, HWGROUP(drive));
+	idefloppy_end_request(drive, 1);
 	return;
 }
 
@@ -1293,13 +1294,13 @@
 				drive->name, floppy->failed_pc->c[0], floppy->sense_key, floppy->asc, floppy->ascq);
 		else
 			printk (KERN_ERR "ide-floppy: %s: I/O error\n", drive->name);
-		idefloppy_end_request (0, HWGROUP(drive));
+		idefloppy_end_request(drive, 0);
 		return ide_stopped;
 	}
 	if (rq->flags & REQ_CMD) {
 		if (rq->sector % floppy->bs_factor || rq->nr_sectors % floppy->bs_factor) {
 			printk ("%s: unsupported r/w request size\n", drive->name);
-			idefloppy_end_request (0, HWGROUP(drive));
+			idefloppy_end_request(drive, 0);
 			return ide_stopped;
 		}
 		pc = idefloppy_next_pc_storage (drive);
@@ -1308,7 +1309,7 @@
 		pc = (idefloppy_pc_t *) rq->buffer;
 	} else {
 		blk_dump_rq_flags(rq, "ide-floppy: unsupported command in queue");
-		idefloppy_end_request (0,HWGROUP (drive));
+		idefloppy_end_request(drive, 0);
 		return ide_stopped;
 	}
 	pc->rq = rq;
@@ -2057,7 +2058,6 @@
  */
 static ide_driver_t idefloppy_driver = {
 	name:			"ide-floppy",
-	version:		IDEFLOPPY_VERSION,
 	media:			ide_floppy,
 	busy:			0,
 	supports_dma:		1,
diff -ur linux-2.5.4/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux-2.5.4/drivers/ide/ide-probe.c	Mon Feb 11 02:50:06 2002
+++ linux/drivers/ide/ide-probe.c	Fri Feb 15 08:53:07 2002
@@ -788,8 +788,7 @@
 static void init_gendisk (ide_hwif_t *hwif)
 {
 	struct gendisk *gd;
-	unsigned int unit, units, minors;
-	int *bs, *max_ra;
+	unsigned int unit, units, minors, i;
 	extern devfs_handle_t ide_devfs_handle;
 
 #if 1
@@ -802,33 +801,25 @@
 	}
 #endif
 
-	minors    = units * (1<<PARTN_BITS);
-	gd        = kmalloc (sizeof(struct gendisk), GFP_KERNEL);
+	minors = units * (1<<PARTN_BITS);
+
+	gd = kmalloc (sizeof(struct gendisk), GFP_KERNEL);
 	if (!gd)
 		goto err_kmalloc_gd;
 	gd->sizes = kmalloc (minors * sizeof(int), GFP_KERNEL);
 	if (!gd->sizes)
 		goto err_kmalloc_gd_sizes;
-	gd->part  = kmalloc (minors * sizeof(struct hd_struct), GFP_KERNEL);
+	gd->part = kmalloc (minors * sizeof(struct hd_struct), GFP_KERNEL);
 	if (!gd->part)
 		goto err_kmalloc_gd_part;
-	bs        = kmalloc (minors*sizeof(int), GFP_KERNEL);
-	if (!bs)
+	blksize_size[hwif->major] = kmalloc (minors*sizeof(int), GFP_KERNEL);
+	if (!blksize_size[hwif->major])
 		goto err_kmalloc_bs;
-	max_ra    = kmalloc (minors*sizeof(int), GFP_KERNEL);
-	if (!max_ra)
-		goto err_kmalloc_max_ra;
 
 	memset(gd->part, 0, minors * sizeof(struct hd_struct));
 
-	/* cdroms and msdos f/s are examples of non-1024 blocksizes */
-	blksize_size[hwif->major] = bs;
-	max_readahead[hwif->major] = max_ra;
-	for (unit = 0; unit < minors; ++unit) {
-		*bs++ = BLOCK_SIZE;
-		*max_ra++ = MAX_READAHEAD;
-	}
-
+	for (i = 0; i < minors; ++i)
+	    blksize_size[hwif->major][i] = BLOCK_SIZE;
 	for (unit = 0; unit < units; ++unit)
 		hwif->drives[unit].part = &gd->part[unit << PARTN_BITS];
 
@@ -875,8 +866,6 @@
 	}
 	return;
 
-err_kmalloc_max_ra:
-	kfree(bs);
 err_kmalloc_bs:
 	kfree(gd->part);
 err_kmalloc_gd_part:
@@ -937,7 +926,6 @@
 	init_gendisk(hwif);
 	blk_dev[hwif->major].data = hwif;
 	blk_dev[hwif->major].queue = ide_get_queue;
-	read_ahead[hwif->major] = 8;	/* (4kB) */
 	hwif->present = 1;	/* success */
 
 	return hwif->present;
diff -ur linux-2.5.4/drivers/ide/ide-proc.c linux/drivers/ide/ide-proc.c
--- linux-2.5.4/drivers/ide/ide-proc.c	Fri Feb 15 08:57:37 2002
+++ linux/drivers/ide/ide-proc.c	Fri Feb 15 08:53:07 2002
@@ -163,7 +163,7 @@
 static int proc_ide_write_config
 	(struct file *file, const char *buffer, unsigned long count, void *data)
 {
-	ide_hwif_t	*hwif = (ide_hwif_t *)data;
+	ide_hwif_t	*hwif = data;
 	int		for_real = 0;
 	unsigned long	startn = 0, n, flags;
 	const char	*start = NULL, *msg = NULL;
@@ -338,7 +338,7 @@
 	int		len;
 
 #ifdef CONFIG_BLK_DEV_IDEPCI
-	ide_hwif_t	*hwif = (ide_hwif_t *)data;
+	ide_hwif_t	*hwif = data;
 	struct pci_dev	*dev = hwif->pci_dev;
 	if (!IDE_PCI_DEVID_EQ(hwif->pci_devid, IDE_PCI_DEVID_NULL) && dev && dev->bus) {
 		int reg = 0;
@@ -384,7 +384,7 @@
 	while (p) {
 		driver = (ide_driver_t *) p->info;
 		if (driver)
-			out += sprintf(out, "%s version %s\n", driver->name, driver->version);
+			out += sprintf(out, "%s\n",driver->name);
 		p = p->next;
 	}
 	len = out - page;
@@ -394,7 +394,7 @@
 static int proc_ide_read_imodel
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	ide_hwif_t	*hwif = (ide_hwif_t *) data;
+	ide_hwif_t	*hwif = data;
 	int		len;
 	const char	*name;
 
@@ -424,7 +424,7 @@
 static int proc_ide_read_mate
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	ide_hwif_t	*hwif = (ide_hwif_t *) data;
+	ide_hwif_t	*hwif = data;
 	int		len;
 
 	if (hwif && hwif->mate && hwif->mate->present)
@@ -437,7 +437,7 @@
 static int proc_ide_read_channel
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	ide_hwif_t	*hwif = (ide_hwif_t *) data;
+	ide_hwif_t	*hwif = data;
 	int		len;
 
 	page[0] = hwif->channel ? '1' : '0';
@@ -462,7 +462,7 @@
 static int proc_ide_read_identify
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	ide_drive_t	*drive = (ide_drive_t *)data;
+	ide_drive_t	*drive = data;
 	int		len = 0, i = 0;
 
 	if (drive && !proc_ide_get_identify(drive, page)) {
@@ -483,8 +483,8 @@
 static int proc_ide_read_settings
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	ide_drive_t	*drive = (ide_drive_t *) data;
-	ide_settings_t	*setting = (ide_settings_t *) drive->settings;
+	ide_drive_t	*drive = data;
+	ide_settings_t	*setting = drive->settings;
 	char		*out = page;
 	int		len, rc, mul_factor, div_factor;
 
@@ -515,7 +515,7 @@
 static int proc_ide_write_settings
 	(struct file *file, const char *buffer, unsigned long count, void *data)
 {
-	ide_drive_t	*drive = (ide_drive_t *) data;
+	ide_drive_t	*drive = data;
 	char		name[MAX_LEN + 1];
 	int		for_real = 0, len;
 	unsigned long	n;
@@ -573,7 +573,15 @@
 				--n;
 				++p;
 			}
-			setting = ide_find_setting_by_name(drive, name);
+
+			/* Find setting by name */
+			setting = drive->settings;
+
+			while (setting) {
+			    if (strcmp(setting->name, name) == 0)
+				break;
+			    setting = setting->next;
+			}
 			if (!setting)
 				goto parse_error;
 
@@ -590,21 +598,21 @@
 int proc_ide_read_capacity
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	ide_drive_t	*drive = (ide_drive_t *) data;
-	ide_driver_t    *driver = (ide_driver_t *) drive->driver;
+	ide_drive_t	*drive = data;
+	ide_driver_t    *driver = drive->driver;
 	int		len;
 
 	if (!driver)
 		len = sprintf(page, "(none)\n");
         else
-		len = sprintf(page,"%llu\n", (unsigned long long) ((ide_driver_t *)drive->driver)->capacity(drive));
+		len = sprintf(page,"%llu\n", (unsigned long long) drive->driver->capacity(drive));
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
 
 int proc_ide_read_geometry
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	ide_drive_t	*drive = (ide_drive_t *) data;
+	ide_drive_t	*drive = data;
 	char		*out = page;
 	int		len;
 
@@ -617,7 +625,7 @@
 static int proc_ide_read_dmodel
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	ide_drive_t	*drive = (ide_drive_t *) data;
+	ide_drive_t	*drive = data;
 	struct hd_driveid *id = drive->id;
 	int		len;
 
@@ -635,14 +643,14 @@
 	if (!driver)
 		len = sprintf(page, "(none)\n");
 	else
-		len = sprintf(page, "%s version %s\n", driver->name, driver->version);
+		len = sprintf(page, "%s\n", driver->name);
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
 
 static int proc_ide_write_driver
 	(struct file *file, const char *buffer, unsigned long count, void *data)
 {
-	ide_drive_t	*drive = (ide_drive_t *) data;
+	ide_drive_t	*drive = data;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -654,7 +662,7 @@
 static int proc_ide_read_media
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	ide_drive_t	*drive = (ide_drive_t *) data;
+	ide_drive_t	*drive = data;
 	const char	*media;
 	int		len;
 
@@ -787,7 +795,6 @@
 
 	for (d = 0; d < MAX_DRIVES; d++) {
 		ide_drive_t *drive = &hwif->drives[d];
-//		ide_driver_t *driver = drive->driver;
 
 		if (drive->proc)
 			destroy_proc_ide_device(hwif, drive);
diff -ur linux-2.5.4/drivers/ide/ide-tape.c linux/drivers/ide/ide-tape.c
--- linux-2.5.4/drivers/ide/ide-tape.c	Mon Feb 11 02:50:11 2002
+++ linux/drivers/ide/ide-tape.c	Fri Feb 15 08:53:07 2002
@@ -1835,10 +1835,9 @@
  *	idetape_end_request is used to finish servicing a request, and to
  *	insert a pending pipeline request into the main device queue.
  */
-static void idetape_end_request (byte uptodate, ide_hwgroup_t *hwgroup)
+static int idetape_end_request(ide_drive_t *drive, int uptodate)
 {
-	ide_drive_t *drive = hwgroup->drive;
-	struct request *rq = hwgroup->rq;
+	struct request *rq = HWGROUP(drive)->rq;
 	idetape_tape_t *tape = drive->driver_data;
 	unsigned long flags;
 	int error;
@@ -1932,6 +1931,8 @@
 	if (tape->active_data_request == NULL)
 		clear_bit(IDETAPE_PIPELINE_ACTIVE, &tape->flags);
 	spin_unlock_irqrestore(&tape->spinlock, flags);
+
+	return 0;
 }
 
 static ide_startstop_t idetape_request_sense_callback (ide_drive_t *drive)
@@ -1944,10 +1945,10 @@
 #endif /* IDETAPE_DEBUG_LOG */
 	if (!tape->pc->error) {
 		idetape_analyze_error (drive, (idetape_request_sense_result_t *) tape->pc->buffer);
-		idetape_end_request (1, HWGROUP (drive));
+		idetape_end_request(drive, 1);
 	} else {
 		printk (KERN_ERR "ide-tape: Error in REQUEST SENSE itself - Aborting request!\n");
-		idetape_end_request (0, HWGROUP (drive));
+		idetape_end_request(drive, 0);
 	}
 	return ide_stopped;
 }
@@ -2012,7 +2013,7 @@
 /*
  *	idetape_postpone_request postpones the current request so that
  *	ide.c will be able to service requests from another device on
- *	the same hwgroup while we are polling for DSC.
+ *	the same interface while we are polling for DSC.
  */
 static void idetape_postpone_request (ide_drive_t *drive)
 {
@@ -2348,7 +2349,7 @@
 		printk (KERN_INFO "ide-tape: Reached idetape_pc_callback\n");
 #endif /* IDETAPE_DEBUG_LOG */
 
-	idetape_end_request (tape->pc->error ? 0 : 1, HWGROUP(drive));
+	idetape_end_request(drive, tape->pc->error ? 0 : 1);
 	return ide_stopped;
 }
 
@@ -2397,7 +2398,7 @@
 	if (tape->debug_level >= 1)
 		printk(KERN_INFO "ide-tape: buffer fill callback, %d/%d\n", tape->cur_frames, tape->max_frames);
 #endif
-	idetape_end_request (tape->pc->error ? 0 : 1, HWGROUP(drive));
+	idetape_end_request(drive, tape->pc->error ? 0 : 1);
 	return ide_stopped;
 }
 
@@ -2508,7 +2509,7 @@
 		tape->avg_time = jiffies;
 	}
 
-#if IDETAPE_DEBUG_LOG	
+#if IDETAPE_DEBUG_LOG
 	if (tape->debug_level >= 4)
 		printk (KERN_INFO "ide-tape: Reached idetape_rw_callback\n");
 #endif /* IDETAPE_DEBUG_LOG */
@@ -2517,9 +2518,9 @@
 	rq->current_nr_sectors -= blocks;
 
 	if (!tape->pc->error)
-		idetape_end_request (1, HWGROUP (drive));
+		idetape_end_request(drive, 1);
 	else
-		idetape_end_request (tape->pc->error, HWGROUP (drive));
+		idetape_end_request(drive, tape->pc->error);
 	return ide_stopped;
 }
 
@@ -2630,7 +2631,7 @@
 		 *	We do not support buffer cache originated requests.
 		 */
 		printk (KERN_NOTICE "ide-tape: %s: Unsupported command in request queue (%ld)\n", drive->name, rq->flags);
-		ide_end_request (0, HWGROUP (drive));			/* Let the common code handle it */
+		ide_end_request(drive, 0);			/* Let the common code handle it */
 		return ide_stopped;
 	}
 
@@ -2644,7 +2645,7 @@
 	if (postponed_rq != NULL)
 		if (rq != postponed_rq) {
 			printk (KERN_ERR "ide-tape: ide-tape.c bug - Two DSC requests were queued\n");
-			idetape_end_request (0, HWGROUP (drive));
+			idetape_end_request(drive, 0);
 			return ide_stopped;
 		}
 #endif /* IDETAPE_DEBUG_BUGS */
@@ -2772,7 +2773,7 @@
 			break;
 		case IDETAPE_ABORTED_WRITE_RQ:
 			rq->flags = IDETAPE_WRITE_RQ;
-			idetape_end_request (IDETAPE_ERROR_EOD, HWGROUP(drive));
+			idetape_end_request(drive, IDETAPE_ERROR_EOD);
 			return ide_stopped;
 		case IDETAPE_ABORTED_READ_RQ:
 #if IDETAPE_DEBUG_LOG
@@ -2780,7 +2781,7 @@
 				printk(KERN_INFO "ide-tape: %s: detected aborted read rq\n", tape->name);
 #endif
 			rq->flags = IDETAPE_READ_RQ;
-			idetape_end_request (IDETAPE_ERROR_EOD, HWGROUP(drive));
+			idetape_end_request(drive, IDETAPE_ERROR_EOD);
 			return ide_stopped;
 		case IDETAPE_PC_RQ1:
 			pc = (idetape_pc_t *) rq->buffer;
@@ -2791,7 +2792,7 @@
 			return ide_stopped;
 		default:
 			printk (KERN_ERR "ide-tape: bug in IDETAPE_RQ_CMD macro\n");
-			idetape_end_request (0, HWGROUP (drive));
+			idetape_end_request(drive, 0);
 			return ide_stopped;
 	}
 	return idetape_issue_packet_command (drive, pc);
@@ -3118,7 +3119,7 @@
 		if (result->bpu) {
 			printk (KERN_INFO "ide-tape: Block location is unknown to the tape\n");
 			clear_bit (IDETAPE_ADDRESS_VALID, &tape->flags);
-			idetape_end_request (0, HWGROUP (drive));
+			idetape_end_request(drive, 0);
 		} else {
 #if IDETAPE_DEBUG_LOG
 			if (tape->debug_level >= 2)
@@ -3129,10 +3130,10 @@
 			tape->last_frame_position = ntohl (result->last_block);
 			tape->blocks_in_buffer = result->blocks_in_buffer[2];
 			set_bit (IDETAPE_ADDRESS_VALID, &tape->flags);
-			idetape_end_request (1, HWGROUP (drive));
+			idetape_end_request(drive, 1);
 		}
 	} else {
-		idetape_end_request (0, HWGROUP (drive));
+		idetape_end_request(drive, 0);
 	}
 	return ide_stopped;
 }
@@ -6143,7 +6144,6 @@
  */
 static ide_driver_t idetape_driver = {
 	name:			"ide-tape",
-	version:		IDETAPE_VERSION,
 	media:			ide_tape,
 	busy:			1,
 	supports_dma:		1,
diff -ur linux-2.5.4/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.4/drivers/ide/ide-taskfile.c	Mon Feb 11 02:50:17 2002
+++ linux/drivers/ide/ide-taskfile.c	Fri Feb 15 08:53:07 2002
@@ -632,7 +632,7 @@
 		if (drive->driver != NULL)
 			DRIVER(drive)->end_request(0, HWGROUP(drive));
 		else
-			ide_end_request(0, HWGROUP(drive));
+			ide_end_request(drive, 0);
 	} else {
 		if ((rq->errors & ERROR_RESET) == ERROR_RESET) {
 			++rq->errors;
@@ -748,7 +748,7 @@
 	if (--rq->current_nr_sectors <= 0) {
 		/* (hs): swapped next 2 lines */
 		DTF("Request Ended stat: %02x\n", GET_STAT());
-		if (ide_end_request(1, HWGROUP(drive))) {
+		if (ide_end_request(drive, 1)) {
 			ide_set_handler(drive, &task_in_intr,  WAIT_CMD, NULL);
 			return ide_started;
 		}
@@ -851,7 +851,7 @@
 			rq->current_nr_sectors -= nsect;
 			stat = altstat_multi_poll(drive, GET_ALTSTAT(), "read");
 		}
-		ide_end_request(1, HWGROUP(drive));
+		ide_end_request(drive, 1);
 		return ide_stopped;
 	}
 #endif /* ALTSTAT_SCREW_UP */
@@ -873,7 +873,7 @@
 		rq->current_nr_sectors -= nsect;
 		msect -= nsect;
 		if (!rq->current_nr_sectors) {
-			if (!ide_end_request(1, HWGROUP(drive)))
+			if (!ide_end_request(drive, 1))
 				return ide_stopped;
 		}
 	} while (msect);
@@ -941,7 +941,7 @@
 		return ide_error(drive, "task_out_intr", stat);
 
 	if (!rq->current_nr_sectors)
-		if (!ide_end_request(1, HWGROUP(drive)))
+		if (!ide_end_request(drive, 1))
 			return ide_stopped;
 
 	if ((rq->current_nr_sectors==1) ^ (stat & DRQ_STAT)) {
@@ -993,7 +993,7 @@
 		 * there may be more, ide_do_request will restart it if
 		 * necessary
 		 */
-		ide_end_request(1, HWGROUP(drive));
+		ide_end_request(drive, 1);
 		return ide_stopped;
 	}
 
@@ -1028,7 +1028,7 @@
 			rq->current_nr_sectors -= nsect;
 			stat = altstat_multi_poll(drive, GET_ALTSTAT(), "write");
 		}
-		ide_end_request(1, HWGROUP(drive));
+		ide_end_request(drive, 1);
 		return ide_stopped;
 	}
 #endif /* ALTSTAT_SCREW_UP */
@@ -1109,7 +1109,7 @@
 			return startstop;
 		}
 
-		__ide_end_request(HWGROUP(drive), 1, rq->hard_nr_sectors);
+		__ide_end_request(drive, 1, rq->hard_nr_sectors);
 		HWGROUP(drive)->wrq.bio = NULL;
 		return ide_stopped;
 	}
diff -ur linux-2.5.4/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.4/drivers/ide/ide.c	Mon Feb 11 02:50:16 2002
+++ linux/drivers/ide/ide.c	Fri Feb 15 08:53:08 2002
@@ -372,15 +372,14 @@
 	return system_bus_speed;
 }
 
-inline int __ide_end_request(ide_hwgroup_t *hwgroup, int uptodate, int nr_secs)
+int __ide_end_request(ide_drive_t *drive, int uptodate, int nr_secs)
 {
-	ide_drive_t *drive = hwgroup->drive;
 	struct request *rq;
 	unsigned long flags;
 	int ret = 1;
 
 	spin_lock_irqsave(&ide_lock, flags);
-	rq = hwgroup->rq;
+	rq = HWGROUP(drive)->rq;
 
 	BUG_ON(!(rq->flags & REQ_STARTED));
 
@@ -397,13 +396,13 @@
 	 */
 	if (drive->state == DMA_PIO_RETRY && drive->retry_pio <= 3) {
 		drive->state = 0;
-		hwgroup->hwif->dmaproc(ide_dma_on, drive);
+		HWGROUP(drive)->hwif->dmaproc(ide_dma_on, drive);
 	}
 
 	if (!end_that_request_first(rq, uptodate, nr_secs)) {
 		add_blkdev_randomness(major(rq->rq_dev));
 		blkdev_dequeue_request(rq);
-        	hwgroup->rq = NULL;
+		HWGROUP(drive)->rq = NULL;
 		end_that_request_last(rq);
 		ret = 0;
 	}
@@ -413,14 +412,6 @@
 }
 
 /*
- * This is our end_request replacement function.
- */
-int ide_end_request (byte uptodate, ide_hwgroup_t *hwgroup)
-{
-	return __ide_end_request(hwgroup, uptodate, 0);
-}
-
-/*
  * This should get invoked any time we exit the driver to
  * wait for an interrupt response from a drive.  handler() points
  * at the appropriate code to handle the next interrupt, and a
@@ -909,9 +900,9 @@
 
 	if (rq->errors >= ERROR_MAX) {
 		if (drive->driver != NULL)
-			DRIVER(drive)->end_request(0, HWGROUP(drive));
+			DRIVER(drive)->end_request(drive, 0);
 		else
-	 		ide_end_request(0, HWGROUP(drive));
+			ide_end_request(drive, 0);
 	} else {
 		if ((rq->errors & ERROR_RESET) == ERROR_RESET) {
 			++rq->errors;
@@ -1212,9 +1203,9 @@
 	return do_special(drive);
 kill_rq:
 	if (drive->driver != NULL)
-		DRIVER(drive)->end_request(0, HWGROUP(drive));
+		DRIVER(drive)->end_request(drive, 0);
 	else
-		ide_end_request(0, HWGROUP(drive));
+		ide_end_request(drive, 0);
 	return ide_stopped;
 }
 
@@ -2126,7 +2117,6 @@
 	 */
 	unregister_blkdev(hwif->major, hwif->name);
 	kfree(blksize_size[hwif->major]);
-	kfree(max_readahead[hwif->major]);
 	blk_dev[hwif->major].data = NULL;
 	blk_dev[hwif->major].queue = NULL;
 	blk_clear(hwif->major);
@@ -2279,7 +2269,8 @@
 
 void ide_add_setting (ide_drive_t *drive, const char *name, int rw, int read_ioctl, int write_ioctl, int data_type, int min, int max, int mul_factor, int div_factor, void *data, ide_procset_t *set)
 {
-	ide_settings_t **p = (ide_settings_t **) &drive->settings, *setting = NULL;
+	ide_settings_t **p = &drive->settings;
+	ide_settings_t *setting = NULL;
 
 	while ((*p) && strcmp((*p)->name, name) < 0)
 		p = &((*p)->next);
@@ -2305,7 +2296,7 @@
 
 void ide_remove_setting (ide_drive_t *drive, char *name)
 {
-	ide_settings_t **p = (ide_settings_t **) &drive->settings, *setting;
+	ide_settings_t **p = &drive->settings, *setting;
 
 	while ((*p) && strcmp((*p)->name, name))
 		p = &((*p)->next);
@@ -2316,30 +2307,6 @@
 	kfree(setting);
 }
 
-static ide_settings_t *ide_find_setting_by_ioctl (ide_drive_t *drive, int cmd)
-{
-	ide_settings_t *setting = drive->settings;
-
-	while (setting) {
-		if (setting->read_ioctl == cmd || setting->write_ioctl == cmd)
-			break;
-		setting = setting->next;
-	}
-	return setting;
-}
-
-ide_settings_t *ide_find_setting_by_name (ide_drive_t *drive, char *name)
-{
-	ide_settings_t *setting = drive->settings;
-
-	while (setting) {
-		if (strcmp(setting->name, name) == 0)
-			break;
-		setting = setting->next;
-	}
-	return setting;
-}
-
 static void auto_remove_settings (ide_drive_t *drive)
 {
 	ide_settings_t *setting;
@@ -2614,7 +2581,17 @@
 	if ((drive = get_info_ptr(inode->i_rdev)) == NULL)
 		return -ENODEV;
 
-	if ((setting = ide_find_setting_by_ioctl(drive, cmd)) != NULL) {
+	/* Find setting by ioctl */
+
+	setting = drive->settings;
+
+	while (setting) {
+		if (setting->read_ioctl == cmd || setting->write_ioctl == cmd)
+			break;
+		setting = setting->next;
+	}
+
+	if (setting != NULL) {
 		if (cmd == setting->read_ioctl) {
 			err = ide_read_setting(drive, setting);
 			return err >= 0 ? put_user(err, (long *) arg) : err;
@@ -3481,15 +3458,16 @@
 
 static ide_startstop_t default_do_request(ide_drive_t *drive, struct request *rq, unsigned long block)
 {
-	ide_end_request(0, HWGROUP(drive));
+	ide_end_request(drive, 0);
 	return ide_stopped;
 }
- 
-static void default_end_request (byte uptodate, ide_hwgroup_t *hwgroup)
+
+/* This is the default end request function as well */
+int ide_end_request(ide_drive_t *drive, int uptodate)
 {
-	ide_end_request(uptodate, hwgroup);
+	return __ide_end_request(drive, uptodate, 0);
 }
-  
+
 static int default_ioctl (ide_drive_t *drive, struct inode *inode, struct file *file,
 			  unsigned int cmd, unsigned long arg)
 {
@@ -3536,25 +3514,6 @@
 	return 0;
 }
 
-static void setup_driver_defaults (ide_drive_t *drive)
-{
-	ide_driver_t *d = drive->driver;
-
-	if (d->cleanup == NULL)		d->cleanup = default_cleanup;
-	if (d->standby == NULL)		d->standby = default_standby;
-	if (d->flushcache == NULL)	d->flushcache = default_flushcache;
-	if (d->do_request == NULL)	d->do_request = default_do_request;
-	if (d->end_request == NULL)	d->end_request = default_end_request;
-	if (d->ioctl == NULL)		d->ioctl = default_ioctl;
-	if (d->open == NULL)		d->open = default_open;
-	if (d->release == NULL)		d->release = default_release;
-	if (d->media_change == NULL)	d->media_change = default_check_media_change;
-	if (d->pre_reset == NULL)	d->pre_reset = default_pre_reset;
-	if (d->capacity == NULL)	d->capacity = default_capacity;
-	if (d->special == NULL)		d->special = default_special;
-	if (d->driver_reinit == NULL)	d->driver_reinit = default_driver_reinit;
-}
-
 ide_drive_t *ide_scan_devices (byte media, const char *name, ide_driver_t *driver, int n)
 {
 	unsigned int unit, index, i;
@@ -3578,15 +3537,46 @@
 int ide_register_subdriver (ide_drive_t *drive, ide_driver_t *driver, int version)
 {
 	unsigned long flags;
-	
+
 	save_flags(flags);		/* all CPUs */
 	cli();				/* all CPUs */
 	if (version != IDE_SUBDRIVER_VERSION || !drive->present || drive->driver != NULL || drive->busy || drive->usage) {
 		restore_flags(flags);	/* all CPUs */
 		return 1;
 	}
+
 	drive->driver = driver;
-	setup_driver_defaults(drive);
+
+	/* Fill in the default handlers
+	 */
+
+	if (driver->cleanup == NULL)
+	    driver->cleanup = default_cleanup;
+	if (driver->standby == NULL)
+	    driver->standby = default_standby;
+	if (driver->flushcache == NULL)
+	    driver->flushcache = default_flushcache;
+	if (driver->do_request == NULL)
+	    driver->do_request = default_do_request;
+	if (driver->end_request == NULL)
+	    driver->end_request = ide_end_request;
+	if (driver->ioctl == NULL)
+	    driver->ioctl = default_ioctl;
+	if (driver->open == NULL)
+	    driver->open = default_open;
+	if (driver->release == NULL)
+	    driver->release = default_release;
+	if (driver->media_change == NULL)
+	    driver->media_change = default_check_media_change;
+	if (driver->pre_reset == NULL)
+	    driver->pre_reset = default_pre_reset;
+	if (driver->capacity == NULL)
+	    driver->capacity = default_capacity;
+	if (driver->special == NULL)
+	    driver->special = default_special;
+	if (driver->driver_reinit == NULL)
+	    driver->driver_reinit = default_driver_reinit;
+
 	restore_flags(flags);		/* all CPUs */
 	if (drive->autotune != 2) {
 		if (driver->supports_dma && HWIF(drive)->dmaproc != NULL) {
@@ -3614,7 +3604,7 @@
 int ide_unregister_subdriver (ide_drive_t *drive)
 {
 	unsigned long flags;
-	
+
 	save_flags(flags);		/* all CPUs */
 	cli();				/* all CPUs */
 	if (drive->usage || drive->busy || drive->driver == NULL || DRIVER(drive)->busy) {
@@ -3704,8 +3694,8 @@
 EXPORT_SYMBOL(ide_init_drive_cmd);
 EXPORT_SYMBOL(ide_do_drive_cmd);
 EXPORT_SYMBOL(ide_end_drive_cmd);
-EXPORT_SYMBOL(ide_end_request);
 EXPORT_SYMBOL(__ide_end_request);
+EXPORT_SYMBOL(ide_end_request);
 EXPORT_SYMBOL(ide_revalidate_drive);
 EXPORT_SYMBOL(ide_revalidate_disk);
 EXPORT_SYMBOL(ide_cmd);
diff -ur linux-2.5.4/drivers/ide/pdc4030.c linux/drivers/ide/pdc4030.c
--- linux-2.5.4/drivers/ide/pdc4030.c	Mon Feb 11 02:50:12 2002
+++ linux/drivers/ide/pdc4030.c	Fri Feb 15 08:53:08 2002
@@ -345,7 +345,7 @@
 	rq->nr_sectors -= nsect;
 	total_remaining = rq->nr_sectors;
 	if ((rq->current_nr_sectors -= nsect) <= 0) {
-		ide_end_request(1, HWGROUP(drive));
+		ide_end_request(drive, 1);
 	}
 /*
  * Now the data has been read in, do the following:
@@ -407,7 +407,8 @@
 #ifdef DEBUG_WRITE
 	printk(KERN_DEBUG "%s: Write complete - end_request\n", drive->name);
 #endif
-	__ide_end_request(hwgroup, 1, rq->nr_sectors);
+	__ide_end_request(drive, 1, rq->nr_sectors);
+
 	return ide_stopped;
 }
 
@@ -571,7 +572,7 @@
 /* Check that it's a regular command. If not, bomb out early. */
 	if (!(rq->flags & REQ_CMD)) {
 		blk_dump_rq_flags(rq, "pdc4030 bad flags");
-		ide_end_request(0, HWGROUP(drive));
+		ide_end_request(drive, 0);
 		return ide_stopped;
 	}
 
@@ -633,7 +634,7 @@
 
 	default:
 		printk(KERN_ERR "pdc4030: command not READ or WRITE! Huh?\n");
-		ide_end_request(0, HWGROUP(drive));
+		ide_end_request(drive, 0);
 		return ide_stopped;
 	}
 }
diff -ur linux-2.5.4/drivers/scsi/ide-scsi.c linux/drivers/scsi/ide-scsi.c
--- linux-2.5.4/drivers/scsi/ide-scsi.c	Mon Feb 11 02:50:08 2002
+++ linux/drivers/scsi/ide-scsi.c	Fri Feb 15 08:53:08 2002
@@ -259,11 +259,10 @@
 	printk("]\n");
 }
 
-static void idescsi_end_request (byte uptodate, ide_hwgroup_t *hwgroup)
+static int idescsi_end_request(ide_drive_t *drive, int uptodate)
 {
-	ide_drive_t *drive = hwgroup->drive;
 	idescsi_scsi_t *scsi = drive->driver_data;
-	struct request *rq = hwgroup->rq;
+	struct request *rq = HWGROUP(drive)->rq;
 	idescsi_pc_t *pc = (idescsi_pc_t *) rq->special;
 	int log = test_bit(IDESCSI_LOG_CMD, &scsi->log);
 	struct Scsi_Host *host;
@@ -271,8 +270,8 @@
 	unsigned long flags;
 
 	if (!(rq->flags & REQ_SPECIAL)) {
-		ide_end_request (uptodate, hwgroup);
-		return;
+		ide_end_request(drive, uptodate);
+		return 0;
 	}
 	ide_end_drive_cmd (drive, 0, 0);
 	if (rq->errors >= ERROR_MAX) {
@@ -302,6 +301,8 @@
 	idescsi_free_bio (rq->bio);
 	kfree(pc); kfree(rq);
 	scsi->pc = NULL;
+
+	return 0;
 }
 
 static inline unsigned long get_timeout(idescsi_pc_t *pc)
@@ -341,7 +342,7 @@
 		ide__sti();
 		if (status & ERR_STAT)
 			rq->errors++;
-		idescsi_end_request (1, HWGROUP(drive));
+		idescsi_end_request(drive, 1);
 		return ide_stopped;
 	}
 	bcount = IN_BYTE (IDE_BCOUNTH_REG) << 8 | IN_BYTE (IDE_BCOUNTL_REG);
@@ -470,7 +471,7 @@
 		return idescsi_issue_pc (drive, (idescsi_pc_t *) rq->special);
 	}
 	blk_dump_rq_flags(rq, "ide-scsi: unsup command");
-	idescsi_end_request (0,HWGROUP (drive));
+	idescsi_end_request(drive, 0);
 	return ide_stopped;
 }
 
@@ -541,7 +542,6 @@
  */
 static ide_driver_t idescsi_driver = {
 	name:			"ide-scsi",
-	version:		IDESCSI_VERSION,
 	media:			ide_scsi,
 	busy:			0,
 	supports_dma:		1,
diff -ur linux-2.5.4/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.4/include/linux/ide.h	Fri Feb 15 08:57:41 2002
+++ linux/include/linux/ide.h	Fri Feb 15 08:53:08 2002
@@ -367,6 +367,8 @@
 	} b;
 } special_t;
 
+struct ide_settings_s;
+
 typedef struct ide_drive_s {
 	request_queue_t		 queue;	/* request queue */
 	struct ide_drive_s 	*next;	/* circular list of hwgroup drives */
@@ -415,7 +417,7 @@
 	byte		nowerr;		/* used for ignoring WRERR_STAT */
 	byte		sect0;		/* offset of first sector for DM6:DDO */
 	unsigned int	usage;		/* current "open()" count for drive */
-	byte 		head;		/* "real" number of heads */
+	byte		head;		/* "real" number of heads */
 	byte		sect;		/* "real" sectors per track */
 	byte		bios_head;	/* BIOS/fdisk/LILO number of heads */
 	byte		bios_sect;	/* BIOS/fdisk/LILO sectors per track */
@@ -433,7 +435,7 @@
 	void		*driver_data;	/* extra driver data */
 	devfs_handle_t	de;		/* directory for device */
 	struct proc_dir_entry *proc;	/* /proc/ide/ directory entry */
-	void		*settings;	/* /proc/ide/ drive settings */
+	struct ide_settings_s *settings;    /* /proc/ide/ drive settings */
 	char		driver_req[10];	/* requests specific driver */
 	int		last_lun;	/* last logical unit */
 	int		forced_lun;	/* if hdxlun was given at boot */
@@ -652,7 +654,6 @@
 
 void ide_add_setting(ide_drive_t *drive, const char *name, int rw, int read_ioctl, int write_ioctl, int data_type, int min, int max, int mul_factor, int div_factor, void *data, ide_procset_t *set);
 void ide_remove_setting(ide_drive_t *drive, char *name);
-ide_settings_t *ide_find_setting_by_name(ide_drive_t *drive, char *name);
 int ide_read_setting(ide_drive_t *t, ide_settings_t *setting);
 int ide_write_setting(ide_drive_t *drive, ide_settings_t *setting, int val);
 void ide_add_generic_settings(ide_drive_t *drive);
@@ -703,44 +704,29 @@
  */
 #define IDE_SUBDRIVER_VERSION	1
 
-typedef int		(ide_cleanup_proc)(ide_drive_t *);
-typedef int		(ide_standby_proc)(ide_drive_t *);
-typedef int		(ide_flushcache_proc)(ide_drive_t *);
-typedef ide_startstop_t	(ide_do_request_proc)(ide_drive_t *, struct request *, unsigned long);
-typedef void		(ide_end_request_proc)(byte, ide_hwgroup_t *);
-typedef int		(ide_ioctl_proc)(ide_drive_t *, struct inode *, struct file *, unsigned int, unsigned long);
-typedef int		(ide_open_proc)(struct inode *, struct file *, ide_drive_t *);
-typedef void		(ide_release_proc)(struct inode *, struct file *, ide_drive_t *);
-typedef int		(ide_check_media_change_proc)(ide_drive_t *);
-typedef void		(ide_revalidate_proc)(ide_drive_t *);
-typedef void		(ide_pre_reset_proc)(ide_drive_t *);
-typedef unsigned long	(ide_capacity_proc)(ide_drive_t *);
-typedef ide_startstop_t	(ide_special_proc)(ide_drive_t *);
 typedef void		(ide_setting_proc)(ide_drive_t *);
-typedef int		(ide_driver_reinit_proc)(ide_drive_t *);
 
 typedef struct ide_driver_s {
 	const char			*name;
-	const char			*version;
 	byte				media;
 	unsigned busy			: 1;
 	unsigned supports_dma		: 1;
 	unsigned supports_dsc_overlap	: 1;
-	ide_cleanup_proc		*cleanup;
-	ide_standby_proc		*standby;
-	ide_flushcache_proc		*flushcache;
-	ide_do_request_proc		*do_request;
-	ide_end_request_proc		*end_request;
-	ide_ioctl_proc			*ioctl;
-	ide_open_proc			*open;
-	ide_release_proc		*release;
-	ide_check_media_change_proc	*media_change;
-	ide_revalidate_proc		*revalidate;
-	ide_pre_reset_proc		*pre_reset;
-	ide_capacity_proc		*capacity;
-	ide_special_proc		*special;
+	int (*cleanup)(ide_drive_t *);
+	int (*standby)(ide_drive_t *);
+	int (*flushcache)(ide_drive_t *);
+	ide_startstop_t	(*do_request)(ide_drive_t *, struct request *, unsigned long);
+	int (*end_request)(ide_drive_t *drive, int uptodate);
+	int (*ioctl)(ide_drive_t *, struct inode *, struct file *, unsigned int, unsigned long);
+	int (*open)(struct inode *, struct file *, ide_drive_t *);
+	void (*release)(struct inode *, struct file *, ide_drive_t *);
+	int (*media_change)(ide_drive_t *);
+	void (*revalidate)(ide_drive_t *);
+	void (*pre_reset)(ide_drive_t *);
+	unsigned long (*capacity)(ide_drive_t *);
+	ide_startstop_t	(*special)(ide_drive_t *);
 	ide_proc_entry_t		*proc;
-	ide_driver_reinit_proc		*driver_reinit;
+	int (*driver_reinit)(ide_drive_t *);
 } ide_driver_t;
 
 #define DRIVER(drive)		((ide_driver_t *)((drive)->driver))
@@ -752,13 +738,12 @@
 #define IDE_PROBE_MODULE		1
 #define IDE_DRIVER_MODULE		2
 
-typedef int	(ide_module_init_proc)(void);
 
 typedef struct ide_module_s {
-	int				type;
-	ide_module_init_proc		*init;
-	void				*info;
-	struct ide_module_s		*next;
+	int type;
+	int (*init)(void);
+	void *info;
+	struct ide_module_s *next;
 } ide_module_t;
 
 /*
@@ -783,10 +768,8 @@
 #define LOCAL_END_REQUEST	/* Don't generate end_request in blk.h */
 #include <linux/blk.h>
 
-inline int __ide_end_request(ide_hwgroup_t *, int, int);
-int ide_end_request(byte uptodate, ide_hwgroup_t *hwgroup);
-
-int drive_is_ready (ide_drive_t *drive);
+extern int __ide_end_request(ide_drive_t *drive, int uptodate, int nr_secs);
+extern int ide_end_request(ide_drive_t *drive, int uptodate);
 
 /*
  * This is used on exit from the driver, to designate the next irq handler
@@ -1142,4 +1125,6 @@
 
 extern spinlock_t ide_lock;
 
+extern int drive_is_ready(ide_drive_t *drive);
+
 #endif /* _IDE_H */

--------------010801000802010208070303--

