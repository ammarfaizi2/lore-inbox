Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264283AbUA0SPj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 13:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264459AbUA0SPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 13:15:39 -0500
Received: from mail3-126.ewetel.de ([212.6.122.126]:42406 "EHLO
	mail3.ewetel.de") by vger.kernel.org with ESMTP id S264283AbUA0SP3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 13:15:29 -0500
Date: Tue, 27 Jan 2004 19:13:17 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: MO: opening for write in cdrom.c
In-Reply-To: <Pine.LNX.4.44.0401271538010.1498-100000@neptune.local>
Message-ID: <Pine.LNX.4.44.0401271910130.878-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[...]
> I'll make that change everywhere and then send an updated version.

Here's an updated version, both patches as one.

This solves the remaining problems (512 byte sector discs) and
rough edges (write-protect detection) with ATAPI MO support via
ide-cd/cdrom for me.


--- linux-2.6.2-rc1/include/linux/cdrom.h.orig	Sun Jan 25 23:21:19 2004
+++ linux-2.6.2-rc1/include/linux/cdrom.h	Mon Jan 26 18:46:54 2004
@@ -496,6 +496,7 @@ struct cdrom_generic_command
 #define GPCMD_GET_MEDIA_STATUS		    0xda
 
 /* Mode page codes for mode sense/set */
+#define GPMODE_VENDOR_PAGE		0x00
 #define GPMODE_R_W_ERROR_PAGE		0x01
 #define GPMODE_WRITE_PARMS_PAGE		0x05
 #define GPMODE_AUDIO_CTL_PAGE		0x0e
--- linux-2.6.2-rc1/drivers/cdrom/cdrom.c.orig	Sat Jan 24 01:23:30 2004
+++ linux-2.6.2-rc1/drivers/cdrom/cdrom.c	Tue Jan 27 18:49:02 2004
@@ -696,6 +696,35 @@ static int cdrom_mrw_open_write(struct c
 	return ret;
 }
 
+static int mo_open_write(struct cdrom_device_info *cdi)
+{
+	struct cdrom_generic_command cgc;
+	char buffer[255];
+	int ret;
+	
+	init_cdrom_command(&cgc, &buffer, 4, CGC_DATA_READ);
+	cgc.quiet = 1;
+
+	/*
+	 * obtain write protect information as per
+	 * drivers/scsi/sd.c:sd_read_write_protect_flag
+	 */
+
+	ret = cdrom_mode_sense(cdi, &cgc, GPMODE_ALL_PAGES, 0);
+	if (ret)
+		ret = cdrom_mode_sense(cdi, &cgc, GPMODE_VENDOR_PAGE, 0);
+	if (ret) {
+		cgc.buflen = 255;
+		ret = cdrom_mode_sense(cdi, &cgc, GPMODE_ALL_PAGES, 0);
+	}
+
+	/* drive gave us no info, let the user go ahead */
+	if (ret)
+		return 0;
+	
+	return buffer[3] & 0x80;
+}
+
 /*
  * returns 0 for ok to open write, non-0 to disallow
  */
@@ -707,11 +736,8 @@ static int cdrom_open_write(struct cdrom
 		ret = cdrom_mrw_open_write(cdi);
 	else if (CDROM_CAN(CDC_DVD_RAM))
 		ret = cdrom_dvdram_open_write(cdi);
-	/*
-	 * needs to really check whether media is writeable
-	 */
 	else if (CDROM_CAN(CDC_MO_DRIVE))
-		ret = 0;
+		ret = mo_open_write(cdi);
 
 	return ret;
 }
--- linux-2.6.2-rc1/drivers/ide/ide-cd.c.orig	Sat Jan 24 01:24:03 2004
+++ linux-2.6.2-rc1/drivers/ide/ide-cd.c	Tue Jan 27 18:53:09 2004
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
@@ -1211,6 +1213,9 @@ static int cdrom_read_from_buffer (ide_d
 {
 	struct cdrom_info *info = drive->driver_data;
 	struct request *rq = HWGROUP(drive)->rq;
+	unsigned short sectors_per_frame;
+
+	sectors_per_frame = queue_hardsect_size(drive->queue) >> SECTOR_BITS;
 
 	/* Can't do anything if there's no buffer. */
 	if (info->buffer == NULL) return 0;
@@ -1249,7 +1254,7 @@ static int cdrom_read_from_buffer (ide_d
 	   will fail.  I think that this will never happen, but let's be
 	   paranoid and check. */
 	if (rq->current_nr_sectors < bio_cur_sectors(rq->bio) &&
-	    (rq->sector % SECTORS_PER_FRAME) != 0) {
+	    (rq->sector % sectors_per_frame) != 0) {
 		printk("%s: cdrom_read_from_buffer: buffer botch (%ld)\n",
 			drive->name, (long)rq->sector);
 		cdrom_end_request(drive, 0);
@@ -1268,13 +1273,10 @@ static int cdrom_read_from_buffer (ide_d
 static ide_startstop_t cdrom_start_read_continuation (ide_drive_t *drive)
 {
 	struct request *rq = HWGROUP(drive)->rq;
-	int nsect, sector, nframes, frame, nskip;
-
-	/* Number of sectors to transfer. */
-	nsect = rq->nr_sectors;
+	unsigned short sectors_per_frame;
+	int nskip;
 
-	/* Starting sector. */
-	sector = rq->sector;
+	sectors_per_frame = queue_hardsect_size(drive->queue) >> SECTOR_BITS;
 
 	/* If the requested sector doesn't start on a cdrom block boundary,
 	   we must adjust the start of the transfer so that it does,
@@ -1283,31 +1285,19 @@ static ide_startstop_t cdrom_start_read_
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
 
@@ -1346,13 +1336,11 @@ static ide_startstop_t cdrom_seek_intr (
 static ide_startstop_t cdrom_start_seek_continuation (ide_drive_t *drive)
 {
 	struct request *rq = HWGROUP(drive)->rq;
-	int sector, frame, nskip;
+	unsigned short sectors_per_frame;
+	int frame;
 
-	sector = rq->sector;
-	nskip = (sector % SECTORS_PER_FRAME);
-	if (nskip > 0)
-		sector -= nskip;
-	frame = sector / SECTORS_PER_FRAME;
+	sectors_per_frame = queue_hardsect_size(drive->queue) >> SECTOR_BITS;
+	frame = rq->sector / sectors_per_frame;
 
 	memset(rq->cmd, 0, sizeof(rq->cmd));
 	rq->cmd[0] = GPCMD_SEEK;
@@ -1396,6 +1384,9 @@ static ide_startstop_t cdrom_start_read 
 {
 	struct cdrom_info *info = drive->driver_data;
 	struct request *rq = HWGROUP(drive)->rq;
+	unsigned short sectors_per_frame;
+
+	sectors_per_frame = queue_hardsect_size(drive->queue) >> SECTOR_BITS;
 
 	/* We may be retrying this request after an error.  Fix up
 	   any weirdness which might be present in the request packet. */
@@ -1411,8 +1402,8 @@ static ide_startstop_t cdrom_start_read 
 	info->nsectors_buffered = 0;
 
 	/* use dma, if possible. */
-	if (drive->using_dma && (rq->sector % SECTORS_PER_FRAME == 0) &&
-				(rq->nr_sectors % SECTORS_PER_FRAME == 0))
+	if (drive->using_dma && (rq->sector % sectors_per_frame == 0) &&
+				(rq->nr_sectors % sectors_per_frame == 0))
 		info->dma = 1;
 	else
 		info->dma = 0;
@@ -1950,11 +1941,15 @@ static ide_startstop_t cdrom_start_write
 static ide_startstop_t cdrom_start_write(ide_drive_t *drive, struct request *rq)
 {
 	struct cdrom_info *info = drive->driver_data;
+	unsigned short sectors_per_frame;
+
+	sectors_per_frame = queue_hardsect_size(drive->queue) >> SECTOR_BITS;
 
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
@@ -1969,12 +1964,12 @@ static ide_startstop_t cdrom_start_write
 
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
 
@@ -2209,6 +2204,7 @@ static int cdrom_eject(ide_drive_t *driv
 }
 
 static int cdrom_read_capacity(ide_drive_t *drive, unsigned long *capacity,
+			       unsigned long *sectors_per_frame,
 			       struct request_sense *sense)
 {
 	struct {
@@ -2227,8 +2223,11 @@ static int cdrom_read_capacity(ide_drive
 	req.data_len = sizeof(capbuf);
 
 	stat = cdrom_queue_packet_command(drive, &req);
-	if (stat == 0)
+	if (stat == 0) {
 		*capacity = 1 + be32_to_cpu(capbuf.lba);
+		*sectors_per_frame =
+			be32_to_cpu(capbuf.blocklen) >> SECTOR_BITS;
+	}
 
 	return stat;
 }
@@ -2270,6 +2269,7 @@ static int cdrom_read_toc(ide_drive_t *d
 		struct atapi_toc_entry  ent;
 	} ms_tmp;
 	long last_written;
+	unsigned long sectors_per_frame = SECTORS_PER_FRAME;
 
 	if (toc == NULL) {
 		/* Try to allocate space. */
@@ -2289,12 +2289,15 @@ static int cdrom_read_toc(ide_drive_t *d
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
+	blk_queue_hardsect_size(drive->queue,
+				sectors_per_frame << SECTOR_BITS);
 
 	/* First read just the header, so we know how long the TOC is. */
 	stat = cdrom_read_tocentry(drive, 0, 1, 0, (char *) &toc->hdr,
@@ -2406,7 +2409,7 @@ static int cdrom_read_toc(ide_drive_t *d
 	stat = cdrom_get_last_written(cdi, &last_written);
 	if (!stat && last_written) {
 		toc->capacity = last_written;
-		set_capacity(drive->disk, toc->capacity * SECTORS_PER_FRAME);
+		set_capacity(drive->disk, toc->capacity * sectors_per_frame);
 	}
 
 	/* Remember that we've read this stuff. */
@@ -3306,12 +3309,12 @@ int ide_cdrom_setup (ide_drive_t *drive)
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

