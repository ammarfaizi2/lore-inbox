Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262337AbUFFK7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbUFFK7Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 06:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263219AbUFFK7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 06:59:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:45762 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262337AbUFFK65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 06:58:57 -0400
Date: Sun, 6 Jun 2004 12:58:52 +0200
From: Jens Axboe <axboe@suse.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       der.eremit@email.de
Subject: Re: [OT] Who has record no. of  DriveReady SeekComplete DataRequest errors?
Message-ID: <20040606105852.GA19254@suse.de>
References: <200406060007.10150.kernel@kolivas.org> <20040606092825.GD2733@suse.de> <200406062038.31045.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406062038.31045.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06 2004, Con Kolivas wrote:
> On Sun, 6 Jun 2004 19:28, Jens Axboe wrote:
> > On Sun, Jun 06 2004, Con Kolivas wrote:
> > > Well since 2.6.3 I think I've been getting the record number of
> > >
> > > hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> > > hdd: status error: error=0x00
> > > hdd: drive not ready for command
> > > hdd: ATAPI reset complete
> > >
> > > errors from my cdrw on hdd; and it's only one drive's worth.
> > >
> > >
> > > dmesg -s 32768 | grep DataRequest | wc -l
> > > 88
> > >
> > > Note the -s 32768 is because my dmesg is so long due to the massive
> > > number of seekcomplete errors :-)
> > >
> > > Since the cdrw works fine after re-enabling dma I never really
> > > bothered to do anything about it, but I'm just curious if anyone has a
> > > higher record ;-)
> >
> > Interesting, and 2.6.2 works flawlessly? The only change in 2.6.3 wrt
> > ide-cd is the addition of the != 2kB sector size support from Pascal
> > Schmidt. A quick guess would be that blocklen isn't set, does this
> > change anything for you?
> 
> Sorry, it didn't help, but thanks for the suggestion.

I'll take a better look then. Can you check if backing out the entire
change makes 2.6.7-rcX work? I've attached it for you.

> P.S. Terribly sorry about the way I reported this bug; Although I
> originally thought it was funny I think it was quite rude in
> retrospect.

I didn't think it was rude, just an odd report :)

===== drivers/ide/ide-cd.c 1.83 vs edited =====
--- 1.83/drivers/ide/ide-cd.c	2004-05-29 19:04:42 +02:00
+++ edited/drivers/ide/ide-cd.c	2004-06-06 12:56:28 +02:00
@@ -1182,9 +1172,6 @@
 {
 	struct cdrom_info *info = drive->driver_data;
 	struct request *rq = HWGROUP(drive)->rq;
-	unsigned short sectors_per_frame;
-
-	sectors_per_frame = queue_hardsect_size(drive->queue) >> SECTOR_BITS;
 
 	/* Can't do anything if there's no buffer. */
 	if (info->buffer == NULL) return 0;
@@ -1223,7 +1210,7 @@
 	   will fail.  I think that this will never happen, but let's be
 	   paranoid and check. */
 	if (rq->current_nr_sectors < bio_cur_sectors(rq->bio) &&
-	    (rq->sector & (sectors_per_frame - 1))) {
+	    (rq->sector % SECTORS_PER_FRAME) != 0) {
 		printk("%s: cdrom_read_from_buffer: buffer botch (%ld)\n",
 			drive->name, (long)rq->sector);
 		cdrom_end_request(drive, 0);
@@ -1242,10 +1229,13 @@
 static ide_startstop_t cdrom_start_read_continuation (ide_drive_t *drive)
 {
 	struct request *rq = HWGROUP(drive)->rq;
-	unsigned short sectors_per_frame;
-	int nskip;
+	int nsect, sector, nframes, frame, nskip;
 
-	sectors_per_frame = queue_hardsect_size(drive->queue) >> SECTOR_BITS;
+	/* Number of sectors to transfer. */
+	nsect = rq->nr_sectors;
+
+	/* Starting sector. */
+	sector = rq->sector;
 
 	/* If the requested sector doesn't start on a cdrom block boundary,
 	   we must adjust the start of the transfer so that it does,
@@ -1254,19 +1244,31 @@
 	   of the buffer, it will mean that we're to skip a number
 	   of sectors equal to the amount by which CURRENT_NR_SECTORS
 	   is larger than the buffer size. */
-	nskip = rq->sector & (sectors_per_frame - 1);
+	nskip = (sector % SECTORS_PER_FRAME);
 	if (nskip > 0) {
 		/* Sanity check... */
 		if (rq->current_nr_sectors != bio_cur_sectors(rq->bio) &&
-			(rq->sector & (sectors_per_frame - 1))) {
+			(rq->sector % CD_FRAMESIZE != 0)) {
 			printk ("%s: cdrom_start_read_continuation: buffer botch (%u)\n",
 				drive->name, rq->current_nr_sectors);
 			cdrom_end_request(drive, 0);
 			return ide_stopped;
 		}
+		sector -= nskip;
+		nsect += nskip;
 		rq->current_nr_sectors += nskip;
 	}
 
+	/* Convert from sectors to cdrom blocks, rounding up the transfer
+	   length if needed. */
+	nframes = (nsect + SECTORS_PER_FRAME-1) / SECTORS_PER_FRAME;
+	frame = sector / SECTORS_PER_FRAME;
+
+	/* Largest number of frames was can transfer at once is 64k-1. For
+	   some drives we need to limit this even more. */
+	nframes = MIN (nframes, (CDROM_CONFIG_FLAGS (drive)->limit_nframes) ?
+		(65534 / CD_FRAMESIZE) : 65535);
+
 	/* Set up the command */
 	rq->timeout = ATAPI_WAIT_PC;
 
@@ -1305,9 +1307,13 @@
 static ide_startstop_t cdrom_start_seek_continuation (ide_drive_t *drive)
 {
 	struct request *rq = HWGROUP(drive)->rq;
-	sector_t frame = rq->sector;
+	int sector, frame, nskip;
 
-	sector_div(frame, queue_hardsect_size(drive->queue) >> SECTOR_BITS);
+	sector = rq->sector;
+	nskip = (sector % SECTORS_PER_FRAME);
+	if (nskip > 0)
+		sector -= nskip;
+	frame = sector / SECTORS_PER_FRAME;
 
 	memset(rq->cmd, 0, sizeof(rq->cmd));
 	rq->cmd[0] = GPCMD_SEEK;
@@ -1351,9 +1357,6 @@
 {
 	struct cdrom_info *info = drive->driver_data;
 	struct request *rq = HWGROUP(drive)->rq;
-	unsigned short sectors_per_frame;
-
-	sectors_per_frame = queue_hardsect_size(drive->queue) >> SECTOR_BITS;
 
 	/* We may be retrying this request after an error.  Fix up
 	   any weirdness which might be present in the request packet. */
@@ -1369,9 +1372,10 @@
 	info->nsectors_buffered = 0;
 
 	/* use dma, if possible. */
-	info->dma = drive->using_dma;
-	if ((rq->sector & (sectors_per_frame - 1)) ||
-	    (rq->nr_sectors & (sectors_per_frame - 1)))
+	if (drive->using_dma && (rq->sector % SECTORS_PER_FRAME == 0) &&
+				(rq->nr_sectors % SECTORS_PER_FRAME == 0))
+		info->dma = 1;
+	else
 		info->dma = 0;
 
 	info->cmd = READ;
@@ -1907,22 +1911,11 @@
 static ide_startstop_t cdrom_start_write(ide_drive_t *drive, struct request *rq)
 {
 	struct cdrom_info *info = drive->driver_data;
-	struct gendisk *g = drive->disk;
-	unsigned short sectors_per_frame = queue_hardsect_size(drive->queue) >> SECTOR_BITS;
 
 	/*
-	 * writes *must* be hardware frame aligned
+	 * writes *must* be 2kB frame aligned
 	 */
-	if ((rq->nr_sectors & (sectors_per_frame - 1)) ||
-	    (rq->sector & (sectors_per_frame - 1))) {
-		cdrom_end_request(drive, 0);
-		return ide_stopped;
-	}
-
-	/*
-	 * disk has become write protected
-	 */
-	if (g->policy) {
+	if ((rq->nr_sectors & 3) || (rq->sector & 3)) {
 		cdrom_end_request(drive, 0);
 		return ide_stopped;
 	}
@@ -1937,12 +1930,12 @@
 
 	info->nsectors_buffered = 0;
 
-	/* use dma, if possible. we don't need to check more, since we
-	 * know that the transfer is always (at least!) frame aligned */
+        /* use dma, if possible. we don't need to check more, since we
+	 * know that the transfer is always (at least!) 2KB aligned */
 	info->dma = drive->using_dma ? 1 : 0;
 	info->cmd = WRITE;
 
-	/* Start sending the write request to the drive. */
+	/* Start sending the read request to the drive. */
 	return cdrom_start_packet_command(drive, 32768, cdrom_start_write_cont);
 }
 
@@ -2182,7 +2175,6 @@
 }
 
 static int cdrom_read_capacity(ide_drive_t *drive, unsigned long *capacity,
-			       unsigned long *sectors_per_frame,
 			       struct request_sense *sense)
 {
 	struct {
@@ -2201,11 +2193,8 @@
 	req.data_len = sizeof(capbuf);
 
 	stat = cdrom_queue_packet_command(drive, &req);
-	if (stat == 0) {
+	if (stat == 0)
 		*capacity = 1 + be32_to_cpu(capbuf.lba);
-		*sectors_per_frame =
-			be32_to_cpu(capbuf.blocklen) >> SECTOR_BITS;
-	}
 
 	return stat;
 }
@@ -2247,7 +2236,6 @@
 		struct atapi_toc_entry  ent;
 	} ms_tmp;
 	long last_written;
-	unsigned long sectors_per_frame = SECTORS_PER_FRAME;
 
 	if (toc == NULL) {
 		/* Try to allocate space. */
@@ -2267,15 +2255,12 @@
 	if (CDROM_STATE_FLAGS(drive)->toc_valid)
 		return 0;
 
-	/* Try to get the total cdrom capacity and sector size. */
-	stat = cdrom_read_capacity(drive, &toc->capacity, &sectors_per_frame,
-				   sense);
+	/* Try to get the total cdrom capacity. */
+	stat = cdrom_read_capacity(drive, &toc->capacity, sense);
 	if (stat)
 		toc->capacity = 0x1fffff;
 
-	set_capacity(drive->disk, toc->capacity * sectors_per_frame);
-	blk_queue_hardsect_size(drive->queue,
-				sectors_per_frame << SECTOR_BITS);
+	set_capacity(drive->disk, toc->capacity * SECTORS_PER_FRAME);
 
 	/* First read just the header, so we know how long the TOC is. */
 	stat = cdrom_read_tocentry(drive, 0, 1, 0, (char *) &toc->hdr,
@@ -2387,7 +2372,7 @@
 	stat = cdrom_get_last_written(cdi, &last_written);
 	if (!stat && (last_written > toc->capacity)) {
 		toc->capacity = last_written;
-		set_capacity(drive->disk, toc->capacity * sectors_per_frame);
+		set_capacity(drive->disk, toc->capacity * SECTORS_PER_FRAME);
 	}
 
 	/* Remember that we've read this stuff. */
@@ -2826,10 +2811,6 @@
 static
 void ide_cdrom_release_real (struct cdrom_device_info *cdi)
 {
-	ide_drive_t *drive = cdi->handle;
-
-	if (!cdi->use_count)
-		CDROM_STATE_FLAGS(drive)->toc_valid = 0;
 }
 
 
@@ -3297,12 +3278,12 @@
 static
 sector_t ide_cdrom_capacity (ide_drive_t *drive)
 {
-	unsigned long capacity, sectors_per_frame;
+	unsigned long capacity;
 
-	if (cdrom_read_capacity(drive, &capacity, &sectors_per_frame, NULL))
+	if (cdrom_read_capacity(drive, &capacity, NULL))
 		return 0;
 
-	return capacity * sectors_per_frame;
+	return capacity * SECTORS_PER_FRAME;
 }
 
 static

-- 
Jens Axboe

