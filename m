Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265412AbTLRXah (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 18:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265411AbTLRXah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 18:30:37 -0500
Received: from mail0-96.ewetel.de ([212.6.122.96]:12197 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S265410AbTLRXac (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 18:30:32 -0500
Date: Fri, 19 Dec 2003 00:30:18 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6: ATAPI MO drive support
Message-ID: <Pine.LNX.4.44.0312190022480.1134-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

The below patch is needed to support ATAPI MO drives in 2.6. ide-scsi
doesn't work any more for this, so ide-cd has to take over the job of
running the MO drive. Without this, there is no way to write to an
ATAPI MO drive.

This patch has been discussed with Linus and Jens already around test9
time and it was agreed this is the right way to go about it. I have
rediffed it against 2.6.0. Compiles, runs, works just fine for me.

Somebody please apply.


--- linux-2.6.0/drivers/ide/ide-cd.c	Thu Dec 18 23:36:59 2003
+++ linux-2.6.0-mo/drivers/ide/ide-cd.c	Thu Dec 18 23:46:47 2003
@@ -2242,6 +2242,7 @@ static int cdrom_read_toc(ide_drive_t *d
 		struct atapi_toc_header hdr;
 		struct atapi_toc_entry  ent;
 	} ms_tmp;
+	long last_written;
 
 	if (toc == NULL) {
 		/* Try to allocate space. */
@@ -2261,6 +2262,13 @@ static int cdrom_read_toc(ide_drive_t *d
 	if (CDROM_STATE_FLAGS(drive)->toc_valid)
 		return 0;
 
+	/* Try to get the total cdrom capacity. */
+	stat = cdrom_read_capacity(drive, &toc->capacity, sense);
+	if (stat)
+		toc->capacity = 0x1fffff;
+
+	set_capacity(drive->disk, toc->capacity * SECTORS_PER_FRAME);
+
 	/* First read just the header, so we know how long the TOC is. */
 	stat = cdrom_read_tocentry(drive, 0, 1, 0, (char *) &toc->hdr,
 				    sizeof(struct atapi_toc_header), sense);
@@ -2368,13 +2376,11 @@ static int cdrom_read_toc(ide_drive_t *d
 	toc->xa_flag = (ms_tmp.hdr.first_track != ms_tmp.hdr.last_track);
 
 	/* Now try to get the total cdrom capacity. */
-	stat = cdrom_get_last_written(cdi, (long *) &toc->capacity);
-	if (stat || !toc->capacity)
-		stat = cdrom_read_capacity(drive, &toc->capacity, sense);
-	if (stat)
-		toc->capacity = 0x1fffff;
-
-	set_capacity(drive->disk, toc->capacity * SECTORS_PER_FRAME);
+	stat = cdrom_get_last_written(cdi, &last_written);
+	if (!stat && last_written) {
+		toc->capacity = last_written;
+		set_capacity(drive->disk, toc->capacity * SECTORS_PER_FRAME);
+	}
 
 	/* Remember that we've read this stuff. */
 	CDROM_STATE_FLAGS(drive)->toc_valid = 1;
@@ -3215,7 +3221,8 @@ int ide_cdrom_setup (ide_drive_t *drive)
 
 	nslots = ide_cdrom_probe_capabilities (drive);
 
-	if (CDROM_CONFIG_FLAGS(drive)->dvd_ram)
+	if (CDROM_CONFIG_FLAGS(drive)->dvd_ram ||
+	    CDROM_CONFIG_FLAGS(drive)->mo_drive)
 		set_disk_ro(drive->disk, 0);
 
 #if 0
--- linux-2.6.0/drivers/cdrom/cdrom.c	Thu Dec 18 23:36:59 2003
+++ linux-2.6.0-mo/drivers/cdrom/cdrom.c	Thu Dec 18 23:40:51 2003
@@ -426,7 +426,8 @@ int cdrom_open(struct cdrom_device_info 
 	if ((fp->f_flags & O_NONBLOCK) && (cdi->options & CDO_USE_FFLAGS))
 		ret = cdi->ops->open(cdi, 1);
 	else {
-		if ((fp->f_mode & FMODE_WRITE) && !CDROM_CAN(CDC_DVD_RAM))
+		if ((fp->f_mode & FMODE_WRITE) &&
+		    !(CDROM_CAN(CDC_DVD_RAM) || CDROM_CAN(CDC_MO_DRIVE)))
 			return -EROFS;
 
 		ret = open_for_data(cdi);


-- 
Ciao,
Pascal

