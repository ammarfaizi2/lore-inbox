Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266281AbUAVTX6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 14:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266292AbUAVTX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 14:23:58 -0500
Received: from mail4-141.ewetel.de ([212.6.122.141]:17360 "EHLO
	mail4.ewetel.de") by vger.kernel.org with ESMTP id S266281AbUAVTXW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 14:23:22 -0500
Date: Thu, 22 Jan 2004 20:23:18 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] make ide-cd handle non-2kB sector sizes
Message-ID: <Pine.LNX.4.44.0401222014390.1296-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Jens,

as I suspected, ide-cd doesn't want to play with my 512 byte sector
MO discs. You asked me whether I could cook up a patch to support
different hardware sector sizes, and here it is.

I've tested it with a 230 MB MO disc, which uses 512 byte sectors.
I filled the whole disk, then ejected - reinsert - fsck - read and
compare. Everything worked without problems. Then I inserted a
640 MB MO disc, which uses 2048 byte sectors, and went through the
same procedure. No problems either, so switching between different
sector sizes appears to work.

I've also tested with DVDs and CD-ROMs, which continue to work like
before the patch.

Without this patch, I only get tons of I/O errors when trying to read
or write the 512 byte sector disc.

Please check the logic of my changes.


--- linux-2.6.2-rc1/drivers/ide/ide-cd.h.orig	Thu Jan 22 18:05:04 2004
+++ linux-2.6.2-rc1/drivers/ide/ide-cd.h	Thu Jan 22 18:07:14 2004
@@ -109,6 +109,7 @@ struct ide_cd_state_flags {
 	__u8 door_locked   : 1; /* We think that the drive door is locked. */
 	__u8 writing       : 1; /* the drive is currently writing */
 	__u8 reserved      : 4;
+	byte sectors_per_frame;	/* Current sectors per hw frame */
 	byte current_speed;	/* Current speed of the drive */
 };
 
--- linux-2.6.2-rc1/drivers/ide/ide-cd.c.orig	Thu Jan 22 18:04:59 2004
+++ linux-2.6.2-rc1/drivers/ide/ide-cd.c	Thu Jan 22 20:07:47 2004
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
+	byte sectors_per_frame = CDROM_STATE_FLAGS(drive)->sectors_per_frame;
 
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
+	byte sectors_per_frame = CDROM_STATE_FLAGS(drive)->sectors_per_frame;
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
 
@@ -1346,13 +1332,14 @@ static ide_startstop_t cdrom_seek_intr (
 static ide_startstop_t cdrom_start_seek_continuation (ide_drive_t *drive)
 {
 	struct request *rq = HWGROUP(drive)->rq;
+	byte sectors_per_frame = CDROM_STATE_FLAGS(drive)->sectors_per_frame;
 	int sector, frame, nskip;
 
 	sector = rq->sector;
-	nskip = (sector % SECTORS_PER_FRAME);
+	nskip = (sector % sectors_per_frame);
 	if (nskip > 0)
 		sector -= nskip;
-	frame = sector / SECTORS_PER_FRAME;
+	frame = sector / sectors_per_frame;
 
 	memset(rq->cmd, 0, sizeof(rq->cmd));
 	rq->cmd[0] = GPCMD_SEEK;
@@ -1396,6 +1383,7 @@ static ide_startstop_t cdrom_start_read 
 {
 	struct cdrom_info *info = drive->driver_data;
 	struct request *rq = HWGROUP(drive)->rq;
+	byte sectors_per_frame = CDROM_STATE_FLAGS(drive)->sectors_per_frame;
 
 	/* We may be retrying this request after an error.  Fix up
 	   any weirdness which might be present in the request packet. */
@@ -1411,8 +1399,8 @@ static ide_startstop_t cdrom_start_read 
 	info->nsectors_buffered = 0;
 
 	/* use dma, if possible. */
-	if (drive->using_dma && (rq->sector % SECTORS_PER_FRAME == 0) &&
-				(rq->nr_sectors % SECTORS_PER_FRAME == 0))
+	if (drive->using_dma && (rq->sector % sectors_per_frame == 0) &&
+				(rq->nr_sectors % sectors_per_frame == 0))
 		info->dma = 1;
 	else
 		info->dma = 0;
@@ -1950,14 +1938,16 @@ static ide_startstop_t cdrom_start_write
 static ide_startstop_t cdrom_start_write(ide_drive_t *drive, struct request *rq)
 {
 	struct cdrom_info *info = drive->driver_data;
+	byte sectors_per_frame = CDROM_STATE_FLAGS(drive)->sectors_per_frame;
 
 	/*
-	 * writes *must* be 2kB frame aligned
+	 * writes *must* be 2kB frame aligned if not MO
 	 */
-	if ((rq->nr_sectors & 3) || (rq->sector & 3)) {
-		cdrom_end_request(drive, 0);
-		return ide_stopped;
-	}
+	if (!CDROM_CONFIG_FLAGS(drive)->mo_drive)
+		if ((rq->nr_sectors & 3) || (rq->sector & 3)) {
+			cdrom_end_request(drive, 0);
+			return ide_stopped;
+		}
 
 	/*
 	 * for dvd-ram and such media, it's a really big deal to get
@@ -1969,9 +1959,13 @@ static ide_startstop_t cdrom_start_write
 
 	info->nsectors_buffered = 0;
 
-        /* use dma, if possible. we don't need to check more, since we
-	 * know that the transfer is always (at least!) 2KB aligned */
-	info->dma = drive->using_dma ? 1 : 0;
+	/* use dma, if possible */
+	if (drive->using_dma && (rq->sector % sectors_per_frame == 0) &&
+				(rq->nr_sectors % sectors_per_frame == 0))
+		info->dma = 1;
+	else
+		info->dma = 0;
+
 	info->cmd = WRITE;
 
 	/* Start sending the read request to the drive. */
@@ -2209,6 +2203,7 @@ static int cdrom_eject(ide_drive_t *driv
 }
 
 static int cdrom_read_capacity(ide_drive_t *drive, unsigned long *capacity,
+			       unsigned long *sectors_per_frame,
 			       struct request_sense *sense)
 {
 	struct {
@@ -2227,8 +2222,10 @@ static int cdrom_read_capacity(ide_drive
 	req.data_len = sizeof(capbuf);
 
 	stat = cdrom_queue_packet_command(drive, &req);
-	if (stat == 0)
+	if (stat == 0) {
 		*capacity = 1 + be32_to_cpu(capbuf.lba);
+		*sectors_per_frame = be32_to_cpu(capbuf.blocklen) >> 9;
+	}
 
 	return stat;
 }
@@ -2270,6 +2267,7 @@ static int cdrom_read_toc(ide_drive_t *d
 		struct atapi_toc_entry  ent;
 	} ms_tmp;
 	long last_written;
+	unsigned long sectors_per_frame = SECTORS_PER_FRAME;
 
 	if (toc == NULL) {
 		/* Try to allocate space. */
@@ -2289,12 +2287,20 @@ static int cdrom_read_toc(ide_drive_t *d
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
+
+	if (CDROM_STATE_FLAGS(drive)->sectors_per_frame != sectors_per_frame)
+		printk(KERN_INFO "%s: new hardware sector size %lu\n",
+			drive->name, sectors_per_frame << 9);
+
+	CDROM_STATE_FLAGS(drive)->sectors_per_frame = sectors_per_frame;
+	blk_queue_hardsect_size(drive->queue, sectors_per_frame << 9);
 
 	/* First read just the header, so we know how long the TOC is. */
 	stat = cdrom_read_tocentry(drive, 0, 1, 0, (char *) &toc->hdr,
@@ -2406,7 +2412,7 @@ static int cdrom_read_toc(ide_drive_t *d
 	stat = cdrom_get_last_written(cdi, &last_written);
 	if (!stat && last_written) {
 		toc->capacity = last_written;
-		set_capacity(drive->disk, toc->capacity * SECTORS_PER_FRAME);
+		set_capacity(drive->disk, toc->capacity * sectors_per_frame);
 	}
 
 	/* Remember that we've read this stuff. */
@@ -3184,6 +3190,7 @@ int ide_cdrom_setup (ide_drive_t *drive)
 	CDROM_STATE_FLAGS(drive)->media_changed = 1;
 	CDROM_STATE_FLAGS(drive)->toc_valid     = 0;
 	CDROM_STATE_FLAGS(drive)->door_locked   = 0;
+	CDROM_STATE_FLAGS(drive)->sectors_per_frame = SECTORS_PER_FRAME;
 
 #if NO_DOOR_LOCKING
 	CDROM_CONFIG_FLAGS(drive)->no_doorlock = 1;
@@ -3306,12 +3313,12 @@ int ide_cdrom_setup (ide_drive_t *drive)
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

