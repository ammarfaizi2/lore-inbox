Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272320AbTHDX4S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 19:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272321AbTHDX4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 19:56:18 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:4998 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S272320AbTHDX4P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 19:56:15 -0400
Date: Tue, 5 Aug 2003 01:56:01 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jani Monoses <jani@iv.ro>
cc: <viro@parcelfarce.linux.theplanet.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: ide-cs stack_dump
In-Reply-To: <20030804174828.08dfc5f4.jani@iv.ro>
Message-ID: <Pine.SOL.4.30.0308050032490.16314-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 4 Aug 2003, Jani Monoses wrote:

> Hi
> as reported by someone earlier this year there's a long stack_dump
> starting from kobject_register failed with -17 (EEXISTS) when ide-cs
> detects a CF card.
> The reason is as I see it that both rescan_partitions and register_disk

I think I know how this happens:

register_disk()->blkdev_get()->do_open(), then disk->fops->open()
(idedisk_open() for ide-disk) calls check_disk_change().
check_disk_change() calls disk->fops->media_changed().
idedisk_media_changes() returns drive->removable, so instead of returning
from check_disk_change() block_device is invalidated
and bdev->bd_invalidated is set to 1.  Later in do_open(),
bdev->bd_invalidated flag is checked and since it is 1 rescan_partitions()
is triggered.  Thus partitions are checked and added twice:
in do_open()->rescan_partitions() and in register_disk().

[ The same applies to ide-floppy driver and probably some other drivers. ]

Ufff... I hope it is a correct description (I don't have hardware to
reproduce the problem).

Easy way is to fix is to add drive->attach flag, set it in
idedisk_attach() and check+clear in idedisk_media_changed(),
but I don't like this solution (patch below, Jani, can you test it?).

Any other ideas?

> are called, both of which in turn call add_partition for all partitions
> on the CF card. add_partition calls kobject_register. Also devfs_mk_bdev
> is called twice but it only prints an error msg 'could not append...'. I
> don't know if that is how things should be called or whether kobjects
> for IDE are broken as Alan responded to that earlier post but apart from
> this initial stack_dump the card works fine (not eject of course) So is
> kobject_register to verbose or calling code should make sure it does not
> attempt to register the same object multiple times?

It is a bug to try to register some objects multiple times,
not a feature :-).

> 2.6.0-test2

Thanks,
--
Bartlomiej

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

