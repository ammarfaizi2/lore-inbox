Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264285AbTKLTom (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 14:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbTKLTom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 14:44:42 -0500
Received: from mail2-116.ewetel.de ([212.6.122.116]:21247 "EHLO
	mail2.ewetel.de") by vger.kernel.org with ESMTP id S264285AbTKLTof
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 14:44:35 -0500
Date: Wed, 12 Nov 2003 20:44:24 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Jens Axboe <axboe@suse.de>
cc: Linus Torvalds <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <20031112183105.GR21141@suse.de>
Message-ID: <Pine.LNX.4.44.0311122031290.928-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Nov 2003, Jens Axboe wrote:

> Great! Can you please send a diff for review? It speaks more clearly
> than 1000 descriptions of what a patch does :)

Included at the end of the mail. I found one little problem. If I do

mke2fs -b 2048 /dev/hde
mount -t ext2 /dev/hde /mnt/mo
copy 10mbfile /mnt/mo/
umount /mnt/mo
e2fsck -f /dev/hde

I get complaints from e2fsck that the free blocks and free inodes counts
are wrong. However, if I do 

eject -r /dev/hde

and then reinsert the disk before the e2fsck, there are no errors
reported. Checking on 2.4 confirms the filesystem on disk is okay. This
look to me like the data makes it to disk in any case, but in the first
case e2fsck is somehow getting stale data from somewhere.

> > Now, assuming there is a reason that the cdrom_read_capacity() function
> > is only used as a fallback for normal ide-cd devices, my change might
> Fall back?

Yes, the code in cdrom_read_toc does only use cdrom_read_capacity if the
cdrom_get_last_written call fails or returns a 0 capacity. For the MO,
we never get that far because cdrom_read_toc exits a lot earlier because
the first cdrom_get_tocentry it tries fails and causes the function to
exit, never setting the capacity.
 
>> Jens, what do you think?
> Do what it currently does, set it to some high value? Then we'll just
> rely on the drive properly failing read requests. Better than not being
> able to reach the files.

Sounds reasonable. I rearranged what I did a little so that non-MO
drives should be handled almost the same as before. The 
cdrom_read_capacity is now attempted at the start of cdrom_read_toc and
the cdrom_get_last_written at the end can override the capacity if
needed. I don't fix up toc->capacity in that case, however, that
would need to be added, I think.


--- linux-2.6.0-test9/drivers/ide/ide-cd.c.orig	Tue Nov 11 22:21:38 2003
+++ linux-2.6.0-test9/drivers/ide/ide-cd.c	Wed Nov 12 20:12:31 2003
@@ -2257,6 +2257,13 @@
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
@@ -2365,12 +2372,8 @@
 
 	/* Now try to get the total cdrom capacity. */
 	stat = cdrom_get_last_written(cdi, (long *) &toc->capacity);
-	if (stat || !toc->capacity)
-		stat = cdrom_read_capacity(drive, &toc->capacity, sense);
-	if (stat)
-		toc->capacity = 0x1fffff;
-
-	set_capacity(drive->disk, toc->capacity * SECTORS_PER_FRAME);
+	if (!stat && toc->capacity)
+		set_capacity(drive->disk, toc->capacity * SECTORS_PER_FRAME);
 
 	/* Remember that we've read this stuff. */
 	CDROM_STATE_FLAGS(drive)->toc_valid = 1;
@@ -3211,7 +3214,8 @@
 
 	nslots = ide_cdrom_probe_capabilities (drive);
 
-	if (CDROM_CONFIG_FLAGS(drive)->dvd_ram)
+	if (CDROM_CONFIG_FLAGS(drive)->dvd_ram ||
+	    CDROM_CONFIG_FLAGS(drive)->mo_drive)
 		set_disk_ro(drive->disk, 0);
 
 #if 0
--- linux-2.6.0-test9/drivers/cdrom/cdrom.c.orig	Tue Nov 11 22:21:25 2003
+++ linux-2.6.0-test9/drivers/cdrom/cdrom.c	Wed Nov 12 20:13:33 2003
@@ -426,7 +426,8 @@
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

