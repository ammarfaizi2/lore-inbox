Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbUJ0GMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbUJ0GMR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 02:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbUJ0GLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 02:11:21 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:40610 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261668AbUJ0GIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 02:08:37 -0400
Date: Tue, 26 Oct 2004 23:08:28 -0700
To: LKML <linux-kernel@vger.kernel.org>
Cc: Chris Wedgwood <cw@taniwha.stupidest.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [RFC] Rename SECTOR_SIZE to IDE_SECTOR_SIZE
Message-ID: <20041027060828.GA32396@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
From: cw@f00f.org (Chris Wedgwood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The token SECTOR_SIZE is used in multiple places that have (almost)
the same defintion everywhere.

How do people feel about rename this vague token?



===== drivers/char/ftape/lowlevel/ftape-bsm.h 1.2 vs edited =====
--- 1.2/drivers/char/ftape/lowlevel/ftape-bsm.h	2004-04-29 02:41:09 -07:00
+++ edited/drivers/char/ftape/lowlevel/ftape-bsm.h	2004-10-26 17:15:36 -07:00
@@ -36,7 +36,7 @@
 
 /*  maximum (format code 4) bad sector map size (bytes).
  */
-#define BAD_SECTOR_MAP_SIZE     (29 * SECTOR_SIZE - 256)
+#define BAD_SECTOR_MAP_SIZE     (29 * IDE_SECTOR_SIZE - 256)
 
 /*  format code 4 bad sector entry, ftape uses this
  *  internally for all format codes
===== drivers/ide/ide-cd.c 1.96 vs edited =====
--- 1.96/drivers/ide/ide-cd.c	2004-10-25 13:06:46 -07:00
+++ edited/drivers/ide/ide-cd.c	2004-10-26 17:43:24 -07:00
@@ -965,7 +965,7 @@ static void cdrom_buffer_sectors (ide_dr
 
 	/* Number of sectors to read into the buffer. */
 	int sectors_to_buffer = min_t(int, sectors_to_transfer,
-				     (SECTOR_BUFFER_SIZE >> SECTOR_BITS) -
+				     (CD_SECTOR_BUFFER_SIZE >> CD_SECTOR_BITS) -
 				       info->nsectors_buffered);
 
 	char *dest;
@@ -979,18 +979,18 @@ static void cdrom_buffer_sectors (ide_dr
 		info->sector_buffered = sector;
 
 	/* Read the data into the buffer. */
-	dest = info->buffer + info->nsectors_buffered * SECTOR_SIZE;
+	dest = info->buffer + info->nsectors_buffered * IDE_SECTOR_SIZE;
 	while (sectors_to_buffer > 0) {
-		HWIF(drive)->atapi_input_bytes(drive, dest, SECTOR_SIZE);
+		HWIF(drive)->atapi_input_bytes(drive, dest, IDE_SECTOR_SIZE);
 		--sectors_to_buffer;
 		--sectors_to_transfer;
 		++info->nsectors_buffered;
-		dest += SECTOR_SIZE;
+		dest += IDE_SECTOR_SIZE;
 	}
 
 	/* Throw away any remaining data. */
 	while (sectors_to_transfer > 0) {
-		static char dum[SECTOR_SIZE];
+		static char dum[IDE_SECTOR_SIZE];
 		HWIF(drive)->atapi_input_bytes(drive, dum, sizeof (dum));
 		--sectors_to_transfer;
 	}
@@ -1093,9 +1093,9 @@ static ide_startstop_t cdrom_read_intr (
 		return ide_stopped;
 
 	/* Assume that the drive will always provide data in multiples
-	   of at least SECTOR_SIZE, as it gets hairy to keep track
+	   of at least IDE_SECTOR_SIZE, as it gets hairy to keep track
 	   of the transfers otherwise. */
-	if ((len % SECTOR_SIZE) != 0) {
+	if ((len % IDE_SECTOR_SIZE) != 0) {
 		printk ("%s: cdrom_read_intr: Bad transfer size %d\n",
 			drive->name, len);
 		if (CDROM_CONFIG_FLAGS(drive)->limit_nframes)
@@ -1109,7 +1109,7 @@ static ide_startstop_t cdrom_read_intr (
 	}
 
 	/* The number of sectors we need to read from the drive. */
-	sectors_to_transfer = len / SECTOR_SIZE;
+	sectors_to_transfer = len / IDE_SECTOR_SIZE;
 
 	/* First, figure out if we need to bit-bucket
 	   any of the leading sectors. */
@@ -1117,7 +1117,7 @@ static ide_startstop_t cdrom_read_intr (
 
 	while (nskip > 0) {
 		/* We need to throw away a sector. */
-		static char dum[SECTOR_SIZE];
+		static char dum[IDE_SECTOR_SIZE];
 		HWIF(drive)->atapi_input_bytes(drive, dum, sizeof (dum));
 
 		--rq->current_nr_sectors;
@@ -1149,8 +1149,8 @@ static ide_startstop_t cdrom_read_intr (
 			/* Read this_transfer sectors
 			   into the current buffer. */
 			while (this_transfer > 0) {
-				HWIF(drive)->atapi_input_bytes(drive, rq->buffer, SECTOR_SIZE);
-				rq->buffer += SECTOR_SIZE;
+				HWIF(drive)->atapi_input_bytes(drive, rq->buffer, IDE_SECTOR_SIZE);
+				rq->buffer += IDE_SECTOR_SIZE;
 				--rq->nr_sectors;
 				--rq->current_nr_sectors;
 				++rq->sector;
@@ -1175,7 +1175,7 @@ static int cdrom_read_from_buffer (ide_d
 	struct request *rq = HWGROUP(drive)->rq;
 	unsigned short sectors_per_frame;
 
-	sectors_per_frame = queue_hardsect_size(drive->queue) >> SECTOR_BITS;
+	sectors_per_frame = queue_hardsect_size(drive->queue) >> CD_SECTOR_BITS;
 
 	/* Can't do anything if there's no buffer. */
 	if (info->buffer == NULL) return 0;
@@ -1190,9 +1190,9 @@ static int cdrom_read_from_buffer (ide_d
 
 		memcpy (rq->buffer,
 			info->buffer +
-			(rq->sector - info->sector_buffered) * SECTOR_SIZE,
-			SECTOR_SIZE);
-		rq->buffer += SECTOR_SIZE;
+			(rq->sector - info->sector_buffered) * IDE_SECTOR_SIZE,
+			IDE_SECTOR_SIZE);
+		rq->buffer += IDE_SECTOR_SIZE;
 		--rq->current_nr_sectors;
 		--rq->nr_sectors;
 		++rq->sector;
@@ -1236,7 +1236,7 @@ static ide_startstop_t cdrom_start_read_
 	unsigned short sectors_per_frame;
 	int nskip;
 
-	sectors_per_frame = queue_hardsect_size(drive->queue) >> SECTOR_BITS;
+	sectors_per_frame = queue_hardsect_size(drive->queue) >> CD_SECTOR_BITS;
 
 	/* If the requested sector doesn't start on a cdrom block boundary,
 	   we must adjust the start of the transfer so that it does,
@@ -1298,7 +1298,7 @@ static ide_startstop_t cdrom_start_seek_
 	struct request *rq = HWGROUP(drive)->rq;
 	sector_t frame = rq->sector;
 
-	sector_div(frame, queue_hardsect_size(drive->queue) >> SECTOR_BITS);
+	sector_div(frame, queue_hardsect_size(drive->queue) >> CD_SECTOR_BITS);
 
 	memset(rq->cmd, 0, sizeof(rq->cmd));
 	rq->cmd[0] = GPCMD_SEEK;
@@ -1323,7 +1323,7 @@ static ide_startstop_t cdrom_start_seek 
 static void restore_request (struct request *rq)
 {
 	if (rq->buffer != bio_data(rq->bio)) {
-		sector_t n = (rq->buffer - (char *) bio_data(rq->bio)) / SECTOR_SIZE;
+		sector_t n = (rq->buffer - (char *) bio_data(rq->bio)) / IDE_SECTOR_SIZE;
 
 		rq->buffer = bio_data(rq->bio);
 		rq->nr_sectors += n;
@@ -1344,7 +1344,7 @@ static ide_startstop_t cdrom_start_read 
 	struct request *rq = HWGROUP(drive)->rq;
 	unsigned short sectors_per_frame;
 
-	sectors_per_frame = queue_hardsect_size(drive->queue) >> SECTOR_BITS;
+	sectors_per_frame = queue_hardsect_size(drive->queue) >> CD_SECTOR_BITS;
 
 	/* We may be retrying this request after an error.  Fix up
 	   any weirdness which might be present in the request packet. */
@@ -1837,7 +1837,7 @@ static ide_startstop_t cdrom_write_intr(
 	if (cdrom_write_check_ireason(drive, len, ireason))
 		return ide_stopped;
 
-	sectors_to_transfer = len / SECTOR_SIZE;
+	sectors_to_transfer = len / IDE_SECTOR_SIZE;
 
 	/*
 	 * now loop and write out the data
@@ -1856,8 +1856,8 @@ static ide_startstop_t cdrom_write_intr(
 		this_transfer = min_t(int, sectors_to_transfer, rq->current_nr_sectors);
 
 		while (this_transfer > 0) {
-			HWIF(drive)->atapi_output_bytes(drive, rq->buffer, SECTOR_SIZE);
-			rq->buffer += SECTOR_SIZE;
+			HWIF(drive)->atapi_output_bytes(drive, rq->buffer, IDE_SECTOR_SIZE);
+			rq->buffer += IDE_SECTOR_SIZE;
 			--rq->nr_sectors;
 			--rq->current_nr_sectors;
 			++rq->sector;
@@ -1893,7 +1893,7 @@ static ide_startstop_t cdrom_start_write
 {
 	struct cdrom_info *info = drive->driver_data;
 	struct gendisk *g = drive->disk;
-	unsigned short sectors_per_frame = queue_hardsect_size(drive->queue) >> SECTOR_BITS;
+	unsigned short sectors_per_frame = queue_hardsect_size(drive->queue) >> CD_SECTOR_BITS;
 
 	/*
 	 * writes *must* be hardware frame aligned
@@ -2195,7 +2195,7 @@ static int cdrom_read_capacity(ide_drive
 	if (stat == 0) {
 		*capacity = 1 + be32_to_cpu(capbuf.lba);
 		*sectors_per_frame =
-			be32_to_cpu(capbuf.blocklen) >> SECTOR_BITS;
+			be32_to_cpu(capbuf.blocklen) >> CD_SECTOR_BITS;
 	}
 
 	return stat;
@@ -2238,7 +2238,7 @@ static int cdrom_read_toc(ide_drive_t *d
 		struct atapi_toc_entry  ent;
 	} ms_tmp;
 	long last_written;
-	unsigned long sectors_per_frame = SECTORS_PER_FRAME;
+	unsigned long sectors_per_frame = CD_SECTORS_PER_FRAME;
 
 	if (toc == NULL) {
 		/* Try to allocate space. */
@@ -2266,7 +2266,7 @@ static int cdrom_read_toc(ide_drive_t *d
 
 	set_capacity(drive->disk, toc->capacity * sectors_per_frame);
 	blk_queue_hardsect_size(drive->queue,
-				sectors_per_frame << SECTOR_BITS);
+				sectors_per_frame << CD_SECTOR_BITS);
 
 	/* First read just the header, so we know how long the TOC is. */
 	stat = cdrom_read_tocentry(drive, 0, 1, 0, (char *) &toc->hdr,
@@ -3375,7 +3375,7 @@ static int idecd_open(struct inode * ino
 	drive->usage++;
 
 	if (!info->buffer)
-		info->buffer = kmalloc(SECTOR_BUFFER_SIZE,
+		info->buffer = kmalloc(CD_SECTOR_BUFFER_SIZE,
 					GFP_KERNEL|__GFP_REPEAT);
         if (!info->buffer || (rc = cdrom_open(&info->devinfo, inode, file)))
 		drive->usage--;
===== drivers/ide/ide-cd.h 1.11 vs edited =====
--- 1.11/drivers/ide/ide-cd.h	2004-06-18 08:08:15 -07:00
+++ edited/drivers/ide/ide-cd.h	2004-10-26 17:10:27 -07:00
@@ -43,14 +43,11 @@
 
 /************************************************************************/
 
-#define SECTOR_BITS 		9
-#ifndef SECTOR_SIZE
-#define SECTOR_SIZE		(1 << SECTOR_BITS)
-#endif
-#define SECTORS_PER_FRAME	(CD_FRAMESIZE >> SECTOR_BITS)
-#define SECTOR_BUFFER_SIZE	(CD_FRAMESIZE * 32)
-#define SECTORS_BUFFER		(SECTOR_BUFFER_SIZE >> SECTOR_BITS)
-#define SECTORS_MAX		(131072 >> SECTOR_BITS)
+#define CD_SECTOR_BITS 		9
+#define CD_SECTORS_PER_FRAME	(CD_FRAMESIZE >> CD_SECTOR_BITS)
+#define CD_SECTOR_BUFFER_SIZE	(CD_FRAMESIZE * 32)
+#define CD_SECTORS_BUFFER	(SECTOR_BUFFER_SIZE >> CD_SECTOR_BITS)
+#define CD_SECTORS_MAX		(131072 >> CD_SECTOR_BITS)
 
 #define BLOCKS_PER_FRAME	(CD_FRAMESIZE / BLOCK_SIZE)
 
@@ -84,7 +81,7 @@ struct ide_cd_config_flags {
 	__u8 supp_disc_present	: 1; /* Changer can report exact contents
 					of slots. */
 	__u8 limit_nframes	: 1; /* Drive does not provide data in
-					multiples of SECTOR_SIZE when more
+					multiples of CD_SECTOR_SIZE when more
 					than one interrupt is needed. */
 	__u8 seeking		: 1; /* Seeking in progress */
 	__u8 audio_play		: 1; /* can do audio related commands */
===== drivers/ide/ide-io.c 1.34 vs edited =====
--- 1.34/drivers/ide/ide-io.c	2004-10-21 16:46:25 -07:00
+++ edited/drivers/ide/ide-io.c	2004-10-26 17:15:36 -07:00
@@ -686,7 +686,7 @@ void ide_map_sg(ide_drive_t *drive, stru
 	if ((rq->flags & REQ_DRIVE_TASKFILE) == 0) {
 		hwif->sg_nents = blk_rq_map_sg(drive->queue, rq, sg);
 	} else {
-		sg_init_one(sg, rq->buffer, rq->nr_sectors * SECTOR_SIZE);
+		sg_init_one(sg, rq->buffer, rq->nr_sectors * IDE_SECTOR_SIZE);
 		hwif->sg_nents = 1;
 	}
 }
===== drivers/ide/ide-taskfile.c 1.69 vs edited =====
--- 1.69/drivers/ide/ide-taskfile.c	2004-10-25 08:54:48 -07:00
+++ edited/drivers/ide/ide-taskfile.c	2004-10-26 17:15:36 -07:00
@@ -288,12 +288,12 @@ static void ide_pio_sector(ide_drive_t *
 	local_irq_save(flags);
 #endif
 	buf = kmap_atomic(page, KM_BIO_SRC_IRQ) +
-	      sg[hwif->cursg].offset + (hwif->cursg_ofs * SECTOR_SIZE);
+	      sg[hwif->cursg].offset + (hwif->cursg_ofs * IDE_SECTOR_SIZE);
 
 	hwif->nleft--;
 	hwif->cursg_ofs++;
 
-	if ((hwif->cursg_ofs * SECTOR_SIZE) == sg[hwif->cursg].length) {
+	if ((hwif->cursg_ofs * IDE_SECTOR_SIZE) == sg[hwif->cursg].length) {
 		hwif->cursg++;
 		hwif->cursg_ofs = 0;
 	}
@@ -488,7 +488,7 @@ int ide_diag_taskfile (ide_drive_t *driv
 		if (data_size == 0)
 			rq.nr_sectors = (args->hobRegister[IDE_NSECTOR_OFFSET] << 8) | args->tfRegister[IDE_NSECTOR_OFFSET];
 		else
-			rq.nr_sectors = data_size / SECTOR_SIZE;
+			rq.nr_sectors = data_size / IDE_SECTOR_SIZE;
 
 		if (!rq.nr_sectors) {
 			printk(KERN_ERR "%s: in/out command without data\n",
===== drivers/ide/pci/siimage.c 1.35 vs edited =====
--- 1.35/drivers/ide/pci/siimage.c	2004-10-22 09:12:34 -07:00
+++ edited/drivers/ide/pci/siimage.c	2004-10-26 17:15:36 -07:00
@@ -491,7 +491,7 @@ static int siimage_mmio_ide_dma_count (i
 #ifdef SIIMAGE_VIRTUAL_DMAPIO
 	struct request *rq	= HWGROUP(drive)->rq;
 	ide_hwif_t *hwif	= HWIF(drive);
-	u32 count		= (rq->nr_sectors * SECTOR_SIZE);
+	u32 count		= (rq->nr_sectors * IDE_SECTOR_SIZE);
 	u32 rcount		= 0;
 	unsigned long addr	= siimage_selreg(hwif, 0x1C);
 
===== include/linux/ide.h 1.148 vs edited =====
--- 1.148/include/linux/ide.h	2004-10-22 09:12:35 -07:00
+++ edited/include/linux/ide.h	2004-10-26 17:15:36 -07:00
@@ -202,8 +202,8 @@ typedef unsigned char	byte;	/* used ever
 #define PARTN_BITS	6	/* number of minor dev bits for partitions */
 #define PARTN_MASK	((1<<PARTN_BITS)-1)	/* a useful bit mask */
 #define MAX_DRIVES	2	/* per interface; 2 assumed by lots of code */
-#define SECTOR_SIZE	512
-#define SECTOR_WORDS	(SECTOR_SIZE / 4)	/* number of 32bit words per sector */
+#define IDE_SECTOR_SIZE	512
+#define SECTOR_WORDS	(IDE_SECTOR_SIZE / 4)	/* number of 32bit words per sector */
 #define IDE_LARGE_SEEK(b1,b2,t)	(((b1) > (b2) + (t)) || ((b2) > (b1) + (t)))
 
 /*
