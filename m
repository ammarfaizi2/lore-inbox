Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266845AbUAXA6s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 19:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266847AbUAXA6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 19:58:47 -0500
Received: from mail1-106.ewetel.de ([212.6.122.106]:49870 "EHLO
	mail1.ewetel.de") by vger.kernel.org with ESMTP id S266845AbUAXA5g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 19:57:36 -0500
Date: Sat, 24 Jan 2004 01:57:13 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make ide-cd handle non-2kB sector sizes
In-Reply-To: <200401240050.54792.bzolnier@elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.44.0401240155110.925-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jan 2004, Bartlomiej Zolnierkiewicz wrote:

> Maybe you've tested them differently?

Well, duh. Hand me the brown paper bag, please. I was accidentally
testing with a write-protected disk.

So here's a working patch, with the additional benefit of keeping
the logic in cdrom_start_write as close to the original as
possible:


--- linux-2.6.2-rc1/drivers/ide/ide-cd.c.orig	Sat Jan 24 01:24:03 2004
+++ linux-2.6.2-rc1/drivers/ide/ide-cd.c	Sat Jan 24 01:39:40 2004
@@ -294,10 +294,12 @@
  * 4.60  Dec 17, 2003	- Add mt rainier support
  *			- Bump timeout for packet commands, matches sr
  *			- Odd stuff
+ * 4.61  Jan 22, 2004	- support hardware sector sizes other than 2kB,
+ *			  Pascal Schmidt <der.eremit@email.de>
  *
  *************************************************************************/
  
-#define IDECD_VERSION "4.60"
+#define IDECD_VERSION "4.61"
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -1211,6 +1213,7 @@ static int cdrom_read_from_buffer (ide_d
 {
 	struct cdrom_info *info = drive->driver_data;
 	struct request *rq = HWGROUP(drive)->rq;
+	unsigned short sectors_per_frame = drive->queue->hardsect_size >> 9;
 
 	/* Can't do anything if there's no buffer. */
 	if (info->buffer == NULL) return 0;
@@ -1249,7 +1252,7 @@ static int cdrom_read_from_buffer (ide_d
 	   will fail.  I think that this will never happen, but let's be
 	   paranoid and check. */
 	if (rq->current_nr_sectors < bio_cur_sectors(rq->bio) &&
-	    (rq->sector % SECTORS_PER_FRAME) != 0) {
+	    (rq->sector % sectors_per_frame) != 0) {
 		printk("%s: cdrom_read_from_buffer: buffer botch (%ld)\n",
 			drive->name, (long)rq->sector);
 		cdrom_end_request(drive, 0);
@@ -1268,13 +1271,8 @@ static int cdrom_read_from_buffer (ide_d
 static ide_startstop_t cdrom_start_read_continuation (ide_drive_t *drive)
 {
 	struct request *rq = HWGROUP(drive)->rq;
-	int nsect, sector, nframes, frame, nskip;
-
-	/* Number of sectors to transfer. */
-	nsect = rq->nr_sectors;
-
-	/* Starting sector. */
-	sector = rq->sector;
+	unsigned short sectors_per_frame = drive->queue->hardsect_size >> 9;
+	int nskip;
 
 	/* If the requested sector doesn't start on a cdrom block boundary,
 	   we must adjust the start of the transfer so that it does,
@@ -1283,31 +1281,19 @@ static ide_startstop_t cdrom_start_read_
 	   of the buffer, it will mean that we're to skip a number
 	   of sectors equal to the amount by which CURRENT_NR_SECTORS
 	   is larger than the buffer size. */
-	nskip = (sector % SECTORS_PER_FRAME);
+	nskip = (rq->sector % sectors_per_frame);
 	if (nskip > 0) {
 		/* Sanity check... */
 		if (rq->current_nr_sectors != bio_cur_sectors(rq->bio) &&
-			(rq->sector % CD_FRAMESIZE != 0)) {
+			(rq->sector % sectors_per_frame != 0)) {
 			printk ("%s: cdrom_start_read_continuation: buffer botch (%u)\n",
 				drive->name, rq->current_nr_sectors);
 			cdrom_end_request(drive, 0);
 			return ide_stopped;
 		}
-		sector -= nskip;
-		nsect += nskip;
 		rq->current_nr_sectors += nskip;
 	}
 
-	/* Convert from sectors to cdrom blocks, rounding up the transfer
-	   length if needed. */
-	nframes = (nsect + SECTORS_PER_FRAME-1) / SECTORS_PER_FRAME;
-	frame = sector / SECTORS_PER_FRAME;
-
-	/* Largest number of frames was can transfer at once is 64k-1. For
-	   some drives we need to limit this even more. */
-	nframes = MIN (nframes, (CDROM_CONFIG_FLAGS (drive)->limit_nframes) ?
-		(65534 / CD_FRAMESIZE) : 65535);
-
 	/* Set up the command */
 	rq->timeout = ATAPI_WAIT_PC;
 
@@ -1346,13 +1332,10 @@ static ide_startstop_t cdrom_seek_intr (
 static ide_startstop_t cdrom_start_seek_continuation (ide_drive_t *drive)
 {
 	struct request *rq = HWGROUP(drive)->rq;
-	int sector, frame, nskip;
+	unsigned short sectors_per_frame = drive->queue->hardsect_size >> 9;
+	int frame;
 
-	sector = rq->sector;
-	nskip = (sector % SECTORS_PER_FRAME);
-	if (nskip > 0)
-		sector -= nskip;
-	frame = sector / SECTORS_PER_FRAME;
+	frame = rq->sector / sectors_per_frame;
 
 	memset(rq->cmd, 0, sizeof(rq->cmd));
 	rq->cmd[0] = GPCMD_SEEK;
@@ -1396,6 +1379,7 @@ static ide_startstop_t cdrom_start_read 
 {
 	struct cdrom_info *info = drive->driver_data;
 	struct request *rq = HWGROUP(drive)->rq;
+	unsigned short sectors_per_frame = drive->queue->hardsect_size >> 9;
 
 	/* We may be retrying this request after an error.  Fix up
 	   any weirdness which might be present in the request packet. */
@@ -1411,8 +1395,8 @@ static ide_startstop_t cdrom_start_read 
 	info->nsectors_buffered = 0;
 
 	/* use dma, if possible. */
-	if (drive->using_dma && (rq->sector % SECTORS_PER_FRAME == 0) &&
-				(rq->nr_sectors % SECTORS_PER_FRAME == 0))
+	if (drive->using_dma && (rq->sector % sectors_per_frame == 0) &&
+				(rq->nr_sectors % sectors_per_frame == 0))
 		info->dma = 1;
 	else
 		info->dma = 0;
@@ -1950,11 +1934,13 @@ static ide_startstop_t cdrom_start_write
 static ide_startstop_t cdrom_start_write(ide_drive_t *drive, struct request *rq)
 {
 	struct cdrom_info *info = drive->driver_data;
+	unsigned short sectors_per_frame = drive->queue->hardsect_size >> 9;
 
 	/*
-	 * writes *must* be 2kB frame aligned
+	 * writes *must* be hardware frame aligned
 	 */
-	if ((rq->nr_sectors & 3) || (rq->sector & 3)) {
+	if ((rq->nr_sectors & (sectors_per_frame - 1)) ||
+	    (rq->sector & (sectors_per_frame - 1))) {
 		cdrom_end_request(drive, 0);
 		return ide_stopped;
 	}
@@ -1969,12 +1955,12 @@ static ide_startstop_t cdrom_start_write
 
 	info->nsectors_buffered = 0;
 
-        /* use dma, if possible. we don't need to check more, since we
-	 * know that the transfer is always (at least!) 2KB aligned */
+	/* use dma, if possible. we don't need to check more, since we
+	 * know that the transfer is always (at least!) frame aligned */
 	info->dma = drive->using_dma ? 1 : 0;
 	info->cmd = WRITE;
 
-	/* Start sending the read request to the drive. */
+	/* Start sending the write request to the drive. */
 	return cdrom_start_packet_command(drive, 32768, cdrom_start_write_cont);
 }
 
@@ -2209,6 +2195,7 @@ static int cdrom_eject(ide_drive_t *driv
 }
 
 static int cdrom_read_capacity(ide_drive_t *drive, unsigned long *capacity,
+			       unsigned long *sectors_per_frame,
 			       struct request_sense *sense)
 {
 	struct {
@@ -2227,8 +2214,10 @@ static int cdrom_read_capacity(ide_drive
 	req.data_len = sizeof(capbuf);
 
 	stat = cdrom_queue_packet_command(drive, &req);
-	if (stat == 0)
+	if (stat == 0) {
 		*capacity = 1 + be32_to_cpu(capbuf.lba);
+		*sectors_per_frame = be32_to_cpu(capbuf.blocklen) >> 9;
+	}
 
 	return stat;
 }
@@ -2270,6 +2259,7 @@ static int cdrom_read_toc(ide_drive_t *d
 		struct atapi_toc_entry  ent;
 	} ms_tmp;
 	long last_written;
+	unsigned long sectors_per_frame = SECTORS_PER_FRAME;
 
 	if (toc == NULL) {
 		/* Try to allocate space. */
@@ -2289,12 +2279,14 @@ static int cdrom_read_toc(ide_drive_t *d
 	if (CDROM_STATE_FLAGS(drive)->toc_valid)
 		return 0;
 
-	/* Try to get the total cdrom capacity. */
-	stat = cdrom_read_capacity(drive, &toc->capacity, sense);
+	/* Try to get the total cdrom capacity and sector size. */
+	stat = cdrom_read_capacity(drive, &toc->capacity, &sectors_per_frame,
+				   sense);
 	if (stat)
 		toc->capacity = 0x1fffff;
 
-	set_capacity(drive->disk, toc->capacity * SECTORS_PER_FRAME);
+	set_capacity(drive->disk, toc->capacity * sectors_per_frame);
+	blk_queue_hardsect_size(drive->queue, sectors_per_frame << 9);
 
 	/* First read just the header, so we know how long the TOC is. */
 	stat = cdrom_read_tocentry(drive, 0, 1, 0, (char *) &toc->hdr,
@@ -2406,7 +2398,7 @@ static int cdrom_read_toc(ide_drive_t *d
 	stat = cdrom_get_last_written(cdi, &last_written);
 	if (!stat && last_written) {
 		toc->capacity = last_written;
-		set_capacity(drive->disk, toc->capacity * SECTORS_PER_FRAME);
+		set_capacity(drive->disk, toc->capacity * sectors_per_frame);
 	}
 
 	/* Remember that we've read this stuff. */
@@ -3306,12 +3298,12 @@ int ide_cdrom_setup (ide_drive_t *drive)
 static
 sector_t ide_cdrom_capacity (ide_drive_t *drive)
 {
-	unsigned long capacity;
+	unsigned long capacity, sectors_per_frame;
 
-	if (cdrom_read_capacity(drive, &capacity, NULL))
+	if (cdrom_read_capacity(drive, &capacity, &sectors_per_frame, NULL))
 		return 0;
 
-	return capacity * SECTORS_PER_FRAME;
+	return capacity * sectors_per_frame;
 }
 
 static


-- 
Ciao,
Pascal

