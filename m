Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbUARMgT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 07:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbUARMgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 07:36:19 -0500
Received: from mail0-96.ewetel.de ([212.6.122.96]:28033 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S261660AbUARMgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 07:36:15 -0500
Date: Sun, 18 Jan 2004 13:36:05 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Andries.Brouwer@cwi.nl
cc: axboe@suse.de, <linux-kernel@vger.kernel.org>
Subject: Re: Making MO drive work with ide-cd
In-Reply-To: <UTC200401181220.i0ICKpx05161.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0401181329540.1196-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Jan 2004 Andries.Brouwer@cwi.nl wrote:

> Unable to handle kernel paging request at virtual address 6b6b6b6b.
> Followed by a bad kernel crash (vanilla 2.6.1).
[...]
> Since small amounts of I/O work - a race somewhere? bad locking?

The above virtual address looks like a poison value, so maybe there's
a use-after-free bug somewhere.

>> There is a patch by me with some rework by Jens Axboe in -mm that
>> corrects this situation. It hasn't seen much testing, though.
> OK, will find that and try later.

I've included my old patch (not exactly what is in -mm) at the end
of the mail. It's for 2.6.0 but maybe it applies to vanilla 2.6.1
still.

> It uses media with 512-byte and media with 2048-byte sectors.

The 2048 byte ones should work with my patch, but I guess the 512 byte
ones will not.

> Yes. We must find out what is wrong in ide-scsi and fix it.

Or make one of the ide drivers work with MO drives. The problem
there is the different sector sizes, it seems. ide-cd is not happy
with sector sizes other than 2048 and ide-floppy (my first try)
doesn't want to play with anything different from 512 bytes. That
leaves ide-disk where I suspect it doesn't do removable media, apart
from the sector size issue.


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

