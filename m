Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275074AbTHGCjP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 22:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275085AbTHGCjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 22:39:14 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:60925 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S275074AbTHGCjH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 22:39:07 -0400
Date: Thu, 7 Aug 2003 04:38:50 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "J.C. Wren" <jcwren@jcwren.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2, compact flash, IDE, and kobject errors
In-Reply-To: <200308062218.06159.jcwren@jcwren.com>
Message-ID: <Pine.SOL.4.30.0308070432360.24953-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 6 Aug 2003, J.C. Wren wrote:

> As I've mentioned before, I have an embedded Linux system that has been
> running 2.2.12, and I'm looking at bringing it up to a modern kernel for some
> features that we're looking at implementing.  It's a 386EX system, 2MB flash
> (for BIOS and kernel), 8MB RAM, and a 32MB compact flash card.
>
> WIth both 2.5.69 (last version I attempted), and 2.6.0-test2, when the CF is
> probed, I would get a message indicating kobject had failed with an EEXISTS
> error code.  After the the kernel spits out the message about the HD size,
> I'd get:
>
> 	hda: hda1
> 	hda: hda1
> 	(then the kobject failure and stack trace)
>
> After a lot of printk's, I determine that the kernel is attempting to register
> the partition or drive twice.  This happens because in fs/partions/check.c,
> register_disk() calls blkdev_get().  If blkdev_get() sees the media change
> flag set, he calls rescan_partitions(), which causes the partition to be
> registered.  After it returns, register_disk() calls add_partition(), which
> results in the kernel throwing a kobject error that it's already registered.
>
> The solution that I think is correct (the audience LAUGH sign is now lit) is
> to add a 'hdx=removable' and 'hdx=notremovable' config parameter.  If you are
> booting from a removable media device, such as a CF card (and certain items
> like floppies seems to be special cased out, which I'm guessing is why you
> don't see this on certain media types), this flag would override the
> removable flag determined by the probe.  And for whatever reason someone
> might want to, a non-removable device could be marked as removable.

Known problem.  "ide-cs stack_dump" thread :-).
Does this patch help?

 drivers/ide/ide-disk.c   |    7 +++++++
 drivers/ide/ide-floppy.c |    8 +++++++-
 include/linux/ide.h      |    1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

diff -puN drivers/ide/ide-disk.c~ide-attach-flag drivers/ide/ide-disk.c
--- linux-2.6.0-test2-bk3/drivers/ide/ide-disk.c~ide-attach-flag	2003-08-05 01:43:03.312872768 +0200
+++ linux-2.6.0-test2-bk3-root/drivers/ide/ide-disk.c	2003-08-05 01:48:44.197050496 +0200
@@ -1790,6 +1790,12 @@ static int idedisk_ioctl(struct inode *i
 static int idedisk_media_changed(struct gendisk *disk)
 {
 	ide_drive_t *drive = disk->private_data;
+
+	/* do not scan partitions twice if we are attaching this device */
+	if (drive->attach) {
+		drive->attach = 0;
+		return 0;
+	}
 	/* if removable, always assume it was changed */
 	return drive->removable;
 }
@@ -1848,6 +1854,7 @@ static int idedisk_attach(ide_drive_t *d
 	g->flags = drive->removable ? GENHD_FL_REMOVABLE : 0;
 	set_capacity(g, current_capacity(drive));
 	g->fops = &idedisk_ops;
+	drive->attach = 1;
 	add_disk(g);
 	return 0;
 failed:
diff -puN drivers/ide/ide-floppy.c~ide-attach-flag drivers/ide/ide-floppy.c
--- linux-2.6.0-test2-bk3/drivers/ide/ide-floppy.c~ide-attach-flag	2003-08-05 01:43:06.710356272 +0200
+++ linux-2.6.0-test2-bk3-root/drivers/ide/ide-floppy.c	2003-08-05 01:48:59.546716992 +0200
@@ -2006,7 +2006,12 @@ static int idefloppy_media_changed(struc
 {
 	ide_drive_t *drive = disk->private_data;
 	idefloppy_floppy_t *floppy = drive->driver_data;
-
+
+	/* do not scan partitions twice if we are attaching this device */
+	if (drive->attach) {
+		drive->attach = 0;
+		return 0;
+	}
 	return test_and_clear_bit(IDEFLOPPY_MEDIA_CHANGED, &floppy->flags);
 }

@@ -2061,6 +2066,7 @@ static int idefloppy_attach (ide_drive_t
 	strcpy(g->devfs_name, drive->devfs_name);
 	g->flags = drive->removable ? GENHD_FL_REMOVABLE : 0;
 	g->fops = &idefloppy_ops;
+	drive->attach = 1;
 	add_disk(g);
 	return 0;
 failed:
diff -puN include/linux/ide.h~ide-attach-flag include/linux/ide.h
--- linux-2.6.0-test2-bk3/include/linux/ide.h~ide-attach-flag	2003-08-05 01:43:14.735136320 +0200
+++ linux-2.6.0-test2-bk3-root/include/linux/ide.h	2003-08-05 01:45:19.069234664 +0200
@@ -711,6 +711,7 @@ typedef struct ide_drive_s {
 	unsigned id_read	: 1;	/* 1=id read from disk 0 = synthetic */
 	unsigned noprobe 	: 1;	/* from:  hdx=noprobe */
 	unsigned removable	: 1;	/* 1 if need to do check_media_change */
+	unsigned attach		: 1;	/* set to 1 in ->attach() */
 	unsigned is_flash	: 1;	/* 1 if probed as flash */
 	unsigned forced_geom	: 1;	/* 1 if hdx=c,h,s was given at boot */
 	unsigned no_unmask	: 1;	/* disallow setting unmask bit */

_

> I need to clean out a bunch of printks, but if this isn't the totally wrong
> approach, I'll submit a patch for it.  So far, this patch seems to have fixed
> my problem.

Can you send your patch (even with bunch of printks)?

> One question I do have is that e2fsck seems phenominally slower under
> 2.6.0-test2 than 2.2.12.  It's the same version of e2fsck, so I'm guessing
> the disk throughput is slower (it's all PIO), but I'm not sure what in the
> IDE driver could have halfed or one-thirded the disk throughput.  Any
> thoughts on that would be greatly appreciated.

There was a bug in e2fsck resulting in CPU hogging.

What makes you think that the disk throughput is halfed?
Can you check with hdparm?

Thanks,
--
Bartlomiej


