Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423073AbWJRWOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423073AbWJRWOK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 18:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423077AbWJRWOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 18:14:09 -0400
Received: from mx3.mail.ru ([194.67.23.149]:48941 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S1423073AbWJRWOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 18:14:08 -0400
Date: Thu, 19 Oct 2006 02:15:06 +0400
From: Anton Vorontsov <cbou@mail.ru>
To: kernel-discuss@handhelds.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] genhd fix or ide workaround -- choose one
Message-ID: <20061018221506.GA4187@localhost>
Reply-To: cbou@mail.ru
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

Hi all,

I've caught deadlock inside IDE layer using IDE-CS: after accessing
to IDE disk placed in PCMCIA (CF card really), it will never probe
again after pulling it from PCMCIA/CF.

The kernel is stuck at
drivers/ide/ide.c:ide_unregister():604:

        602                 spin_unlock_irq(&ide_lock);
        603                 device_unregister(&drive->gendev);
        604                 wait_for_completion(&drive->gendev_rel_comp);
        605                 spin_lock_irq(&ide_lock);

ide_unregister() assumes that device_unregister() will call
ide-probe.c:drive_release_dev():

        1282 static void drive_release_dev (struct device *dev)
        1283 {
        ....         [...]
        1302         complete(&drive->gendev_rel_comp);
        1303 }

        1311 static void init_gendisk (ide_hwif_t *hwif)
        1312 {
        ....
        1323                 drive->gendev.release = drive_release_dev;
        ....
        1333 }

But release() function will not called because drive->gendev is still
referenced inside genhd layer.

I'm attaching two patches: the fix and the workaround. I assume that
first is a candidate to -mm, and workaround is a temporary solution.

There are two set of patches: for the Linus's git tree and for the
handhelds.org's 2.6.17-hh1 (prefixed with hh-).

Note: this is cross-posting, thus please keep To: and CC: headers, to
keep us all in sync.

Thanks,

-- Anton (irc: bd2)

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename="genhd-fix.patch"

From: Anton Vorontsov <cbou@mail.ru>

No need to get_device(driverfs_dev), because it's already gotten by
add_disk(). And no function will call put_device() second time.
This is the source of deadlock[1] in IDE layer. SCSI workaround it by
calling put_device() themself after put_disk(), thus it should reflect
this change by removing put_device().

[1] deadlock in ide_unregister()
at wait_for_completion(&drive->gendev_rel_comp) after
device_unregister(&drive->gendev). That happens by reason of
ide-probe.c:drive_release_dev() not called because of driverfs_dev
(which is drive->gendev) still referenced by add_disk().

diff --git a/fs/partitions/check.c b/fs/partitions/check.c
index 6fb4b61..8371adf 100644
--- a/fs/partitions/check.c
+++ b/fs/partitions/check.c
@@ -378,7 +378,7 @@ static char *make_block_name(struct gend
 
 static int disk_sysfs_symlinks(struct gendisk *disk)
 {
-	struct device *target = get_device(disk->driverfs_dev);
+	struct device *target = disk->driverfs_dev;
 	int err;
 	char *disk_name = NULL;
 
@@ -414,9 +414,8 @@ err_out_dev_link:
 		sysfs_remove_link(&disk->kobj, "device");
 err_out_disk_name:
 		kfree(disk_name);
-err_out:
-		put_device(target);
 	}
+err_out:
 	return err;
 }
 
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 84ff203..03dca98 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1760,7 +1760,6 @@ static void scsi_disk_release(struct cla
 
 	disk->private_data = NULL;
 	put_disk(disk);
-	put_device(&sdkp->device->sdev_gendev);
 
 	kfree(sdkp);
 }

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename="ide-genhd-workaround.patch"

From: Anton Vorontsov <cbou@mail.ru>

Because add_disk() getting driverfs_dev twice but putting it only once,
ide-{disk,cd,floppy} should put_device() themselfs. This is workaround
for the bug found in genhd, which causes deadlock in ide_unregister()
at wait_for_completion(&drive->gendev_rel_comp) after
device_unregister(&drive->gendev). That happens by reason of
ide-probe.c:drive_release_dev() not called because of driverfs_dev
(which is drive->gendev) still referenced by add_disk().

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index bddfebd..59121a3 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -3307,6 +3307,7 @@ static void ide_cd_release(struct kref *
 	blk_queue_prep_rq(drive->queue, NULL);
 	g->private_data = NULL;
 	put_disk(g);
+	put_device(&drive->gendev);
 	kfree(info);
 }
 
diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index 0a05a37..d5d02a1 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -1020,6 +1020,7 @@ static void ide_disk_release(struct kref
 	drive->driver_data = NULL;
 	g->private_data = NULL;
 	put_disk(g);
+	put_device(&drive->gendev);
 	kfree(idkp);
 }
 
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 8ccee9c..7a60d8c 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -1887,6 +1887,7 @@ static void ide_floppy_release(struct kr
 	drive->driver_data = NULL;
 	g->private_data = NULL;
 	put_disk(g);
+	put_device(&drive->gendev);
 	kfree(floppy);
 }
 

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename="hh-genhd-fix.patch"

From: Anton Vorontsov <cbou@mail.ru>

No need to get_device(driverfs_dev), because it's already gotten by
add_disk(). And no function will call put_device() second time.
This is the source of deadlock[1] in IDE layer. SCSI workaround it by
calling put_device() themself after put_disk(), thus it should reflect
this change by removing put_device().

[1] deadlock in ide_unregister()
at wait_for_completion(&drive->gendev_rel_comp) after
device_unregister(&drive->gendev). That happens by reason of
ide-probe.c:drive_release_dev() not called because of driverfs_dev
(which is drive->gendev) still referenced by add_disk().

Index: fs/partitions/check.c
===================================================================
RCS file: /cvs/linux/kernel26/fs/partitions/check.c,v
retrieving revision 1.17
diff -u -p -b -B -r1.17 check.c
--- fs/partitions/check.c	23 Aug 2006 18:40:39 -0000	1.17
+++ fs/partitions/check.c	18 Oct 2006 21:13:26 -0000
@@ -389,7 +389,7 @@ static char *make_block_name(struct gend
 
 static void disk_sysfs_symlinks(struct gendisk *disk)
 {
-	struct device *target = get_device(disk->driverfs_dev);
+	struct device *target = disk->driverfs_dev;
 	if (target) {
 		char *disk_name = make_block_name(disk);
 		sysfs_create_link(&disk->kobj,&target->kobj,"device");
Index: drivers/scsi/sd.c
===================================================================
RCS file: /cvs/linux/kernel26/drivers/scsi/sd.c,v
retrieving revision 1.18
diff -u -p -b -B -r1.18 sd.c
--- drivers/scsi/sd.c	23 Aug 2006 18:38:06 -0000	1.18
+++ drivers/scsi/sd.c	18 Oct 2006 21:14:54 -0000
@@ -1756,7 +1756,6 @@ static void scsi_disk_release(struct cla
 
 	disk->private_data = NULL;
 	put_disk(disk);
-	put_device(&sdkp->device->sdev_gendev);
 
 	kfree(sdkp);
 }

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename="hh-ide-genhd-workaround.patch"

From: Anton Vorontsov <cbou@mail.ru>

Because add_disk() getting driverfs_dev twice but putting it only once,
ide-{disk,cd,floppy} should put_device() themselfs. This is workaround
for the bug found in genhd, which causes deadlock in ide_unregister()
at wait_for_completion(&drive->gendev_rel_comp) after
device_unregister(&drive->gendev). That happens by reason of
ide-probe.c:drive_release_dev() not called because of driverfs_dev
(which is drive->gendev) still referenced by add_disk().

Index: drivers/ide/ide-cd.c
===================================================================
RCS file: /cvs/linux/kernel26/drivers/ide/ide-cd.c,v
retrieving revision 1.21
diff -u -p -b -B -r1.21 ide-cd.c
--- drivers/ide/ide-cd.c	23 Aug 2006 18:35:05 -0000	1.21
+++ drivers/ide/ide-cd.c	18 Oct 2006 21:18:52 -0000
@@ -3240,6 +3240,7 @@ static void ide_cd_release(struct kref *
 	blk_queue_prep_rq(drive->queue, NULL);
 	g->private_data = NULL;
 	put_disk(g);
+	put_device(&drive->gendev);
 	kfree(info);
 }
 
Index: drivers/ide/ide-disk.c
===================================================================
RCS file: /cvs/linux/kernel26/drivers/ide/ide-disk.c,v
retrieving revision 1.19
diff -u -p -b -B -r1.19 ide-disk.c
--- drivers/ide/ide-disk.c	23 Aug 2006 18:35:05 -0000	1.19
+++ drivers/ide/ide-disk.c	18 Oct 2006 21:18:52 -0000
@@ -1021,6 +1021,7 @@ static void ide_disk_release(struct kref
 	drive->devfs_name[0] = '\0';
 	g->private_data = NULL;
 	put_disk(g);
+	put_device(&drive->gendev);
 	kfree(idkp);
 }
 
Index: drivers/ide/ide-floppy.c
===================================================================
RCS file: /cvs/linux/kernel26/drivers/ide/ide-floppy.c,v
retrieving revision 1.16
diff -u -p -b -B -r1.16 ide-floppy.c
--- drivers/ide/ide-floppy.c	23 Aug 2006 18:35:05 -0000	1.16
+++ drivers/ide/ide-floppy.c	18 Oct 2006 21:18:52 -0000
@@ -1893,6 +1893,7 @@ static void ide_floppy_release(struct kr
 	drive->driver_data = NULL;
 	g->private_data = NULL;
 	put_disk(g);
+	put_device(&drive->gendev);
 	kfree(floppy);
 }
 

--17pEHd4RhPHOinZp--
