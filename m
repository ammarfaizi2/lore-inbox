Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265701AbUA1ACg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 19:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265763AbUA1ACg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 19:02:36 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:11222 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265701AbUA1ACV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 19:02:21 -0500
Date: Wed, 28 Jan 2004 01:02:16 +0100
From: Jens Axboe <axboe@suse.de>
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MO: opening for write in cdrom.c
Message-ID: <20040128000216.GD11683@suse.de>
References: <Pine.LNX.4.44.0401271538010.1498-100000@neptune.local> <Pine.LNX.4.44.0401271910130.878-100000@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401271910130.878-100000@neptune.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27 2004, Pascal Schmidt wrote:
> 
> [...]
> > I'll make that change everywhere and then send an updated version.
> 
> Here's an updated version, both patches as one.
> 
> This solves the remaining problems (512 byte sector discs) and
> rough edges (write-protect detection) with ATAPI MO support via
> ide-cd/cdrom for me.

Alright, this is your version plus write protect io error handling.
Could you check if this works for you?

--- include/linux/cdrom.h~	2004-01-28 00:59:18.918633482 +0100
+++ include/linux/cdrom.h	2004-01-28 00:57:11.684379155 +0100
@@ -496,6 +496,7 @@
 #define GPCMD_GET_MEDIA_STATUS		    0xda
 
 /* Mode page codes for mode sense/set */
+#define GPMODE_VENDOR_PAGE		0x00
 #define GPMODE_R_W_ERROR_PAGE		0x01
 #define GPMODE_WRITE_PARMS_PAGE		0x05
 #define GPMODE_AUDIO_CTL_PAGE		0x0e
--- drivers/cdrom/cdrom.c~	2004-01-28 00:59:07.878826161 +0100
+++ drivers/cdrom/cdrom.c	2004-01-28 00:57:11.690378507 +0100
@@ -696,6 +696,35 @@
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
@@ -707,11 +736,8 @@
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
--- drivers/ide/ide-cd.c~	2004-01-28 00:59:29.188523981 +0100
+++ drivers/ide/ide-cd.c	2004-01-28 01:00:41.412721285 +0100
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
@@ -818,6 +820,14 @@
 				do_end_request = 1;
 		} else if (sense_key == ILLEGAL_REQUEST ||
 			   sense_key == DATA_PROTECT) {
+			/*
+			 * check if this was a write protected media
+			 */
+			if (rq_data_dir(rq) == WRITE) {
+				printk("ide-cd: media marked write protected\n");
+				set_disk_ro(drive->disk, 1);
+			}
+				
 			/* No point in retrying after an illegal
 			   request or data protect error.*/
 			ide_dump_status (drive, "command error", stat);
@@ -1211,6 +1221,9 @@
 {
 	struct cdrom_info *info = drive->driver_data;
 	struct request *rq = HWGROUP(drive)->rq;
+	unsigned short sectors_per_frame;
+
+	sectors_per_frame = queue_hardsect_size(drive->queue) >> SECTOR_BITS;
 
 	/* Can't do anything if there's no buffer. */
 	if (info->buffer == NULL) return 0;
@@ -1249,7 +1262,7 @@
 	   will fail.  I think that this will never happen, but let's be
 	   paranoid and check. */
 	if (rq->current_nr_sectors < bio_cur_sectors(rq->bio) &&
-	    (rq->sector % SECTORS_PER_FRAME) != 0) {
+	    (rq->sector % sectors_per_frame) != 0) {
 		printk("%s: cdrom_read_from_buffer: buffer botch (%ld)\n",
 			drive->name, (long)rq->sector);
 		cdrom_end_request(drive, 0);
@@ -1268,13 +1281,10 @@
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
@@ -1283,31 +1293,19 @@
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
 
@@ -1346,13 +1344,11 @@
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
@@ -1396,6 +1392,9 @@
 {
 	struct cdrom_info *info = drive->driver_data;
 	struct request *rq = HWGROUP(drive)->rq;
+	unsigned short sectors_per_frame;
+
+	sectors_per_frame = queue_hardsect_size(drive->queue) >> SECTOR_BITS;
 
 	/* We may be retrying this request after an error.  Fix up
 	   any weirdness which might be present in the request packet. */
@@ -1411,8 +1410,8 @@
 	info->nsectors_buffered = 0;
 
 	/* use dma, if possible. */
-	if (drive->using_dma && (rq->sector % SECTORS_PER_FRAME == 0) &&
-				(rq->nr_sectors % SECTORS_PER_FRAME == 0))
+	if (drive->using_dma && (rq->sector % sectors_per_frame == 0) &&
+				(rq->nr_sectors % sectors_per_frame == 0))
 		info->dma = 1;
 	else
 		info->dma = 0;
@@ -1950,11 +1949,22 @@
 static ide_startstop_t cdrom_start_write(ide_drive_t *drive, struct request *rq)
 {
 	struct cdrom_info *info = drive->driver_data;
+	struct gendisk *g = drive->disk;
+	unsigned short sectors_per_frame = queue_hardsect_size(drive->queue) >> SECTOR_BITS;
 
 	/*
-	 * writes *must* be 2kB frame aligned
+	 * writes *must* be hardware frame aligned
 	 */
-	if ((rq->nr_sectors & 3) || (rq->sector & 3)) {
+	if ((rq->nr_sectors & (sectors_per_frame - 1)) ||
+	    (rq->sector & (sectors_per_frame - 1))) {
+		cdrom_end_request(drive, 0);
+		return ide_stopped;
+	}
+
+	/*
+	 * disk has become write protected
+	 */
+	if (g->policy) {
 		cdrom_end_request(drive, 0);
 		return ide_stopped;
 	}
@@ -1969,12 +1979,12 @@
 
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
 
@@ -2209,6 +2219,7 @@
 }
 
 static int cdrom_read_capacity(ide_drive_t *drive, unsigned long *capacity,
+			       unsigned long *sectors_per_frame,
 			       struct request_sense *sense)
 {
 	struct {
@@ -2227,8 +2238,11 @@
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
@@ -2270,6 +2284,7 @@
 		struct atapi_toc_entry  ent;
 	} ms_tmp;
 	long last_written;
+	unsigned long sectors_per_frame = SECTORS_PER_FRAME;
 
 	if (toc == NULL) {
 		/* Try to allocate space. */
@@ -2289,12 +2304,15 @@
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
@@ -2406,7 +2424,7 @@
 	stat = cdrom_get_last_written(cdi, &last_written);
 	if (!stat && last_written) {
 		toc->capacity = last_written;
-		set_capacity(drive->disk, toc->capacity * SECTORS_PER_FRAME);
+		set_capacity(drive->disk, toc->capacity * sectors_per_frame);
 	}
 
 	/* Remember that we've read this stuff. */
@@ -3306,12 +3324,12 @@
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
Jens Axboe

