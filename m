Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262602AbVAUXfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbVAUXfk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 18:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262604AbVAUXdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 18:33:13 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:28591 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S262602AbVAUX1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 18:27:01 -0500
Date: Sat, 22 Jan 2005 00:22:44 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: [patch 7/8] ide-tape: add basic refcounting
Message-ID: <Pine.GSO.4.58.0501220022090.28844@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Similar changes as for ide-cd.c.

diff -Nru a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
--- a/drivers/ide/ide-tape.c	2005-01-21 23:41:25 +01:00
+++ b/drivers/ide/ide-tape.c	2005-01-21 23:41:25 +01:00
@@ -781,8 +781,10 @@
  *	driver due to an interrupt or a timer event is stored in a variable
  *	of type idetape_tape_t, defined below.
  */
-typedef struct {
-	ide_drive_t *drive;
+typedef struct ide_tape_obj {
+	ide_drive_t	*drive;
+	struct kref	kref;
+
 	/*
 	 *	Since a typical character device operation requires more
 	 *	than one packet command, we provide here enough memory
@@ -1007,6 +1009,33 @@
          int debug_level;
 } idetape_tape_t;

+static DECLARE_MUTEX(idetape_ref_sem);
+
+#define to_ide_tape(obj) container_of(obj, struct ide_tape_obj, kref)
+
+#define ide_tape_g(disk)	((disk)->private_data)
+
+static struct ide_tape_obj *ide_tape_get(struct gendisk *disk)
+{
+	struct ide_tape_obj *tape = NULL;
+
+	down(&idetape_ref_sem);
+	tape = ide_tape_g(disk);
+	if (tape)
+		kref_get(&tape->kref);
+	up(&idetape_ref_sem);
+	return tape;
+}
+
+static void ide_tape_release(struct kref *);
+
+static void ide_tape_put(struct ide_tape_obj *tape)
+{
+	down(&idetape_ref_sem);
+	kref_put(&tape->kref, ide_tape_release);
+	up(&idetape_ref_sem);
+}
+
 /*
  *	Tape door status
  */
@@ -4522,9 +4551,7 @@
 	int stage_size;
 	struct sysinfo si;

-	memset(tape, 0, sizeof (idetape_tape_t));
 	spin_lock_init(&tape->spinlock);
-	drive->driver_data = tape;
 	drive->dsc_overlap = 1;
 #ifdef CONFIG_BLK_DEV_IDEPCI
 	if (HWIF(drive)->pci_dev != NULL) {
@@ -4542,7 +4569,6 @@
 	/* Seagate Travan drives do not support DSC overlap. */
 	if (strstr(drive->id->model, "Seagate STT3401"))
 		drive->dsc_overlap = 0;
-	tape->drive = drive;
 	tape->minor = minor;
 	tape->name[0] = 'h';
 	tape->name[1] = 't';
@@ -4636,13 +4662,25 @@
 	spin_unlock_irqrestore(&ide_lock, flags);
 	DRIVER(drive)->busy = 0;
 	(void) ide_unregister_subdriver(drive);
+
+	ide_tape_put(tape);
+
+	return 0;
+}
+
+static void ide_tape_release(struct kref *kref)
+{
+	struct ide_tape_obj *tape = to_ide_tape(kref);
+	ide_drive_t *drive = tape->drive;
+	struct gendisk *g = drive->disk;
+
 	drive->driver_data = NULL;
 	devfs_remove("%s/mt", drive->devfs_name);
 	devfs_remove("%s/mtn", drive->devfs_name);
-	devfs_unregister_tape(drive->disk->number);
-	kfree (tape);
-	drive->disk->fops = ide_fops;
-	return 0;
+	devfs_unregister_tape(g->number);
+	g->private_data = NULL;
+	g->fops = ide_fops;
+	kfree(tape);
 }

 #ifdef CONFIG_PROC_FS
@@ -4707,15 +4745,30 @@

 static int idetape_open(struct inode *inode, struct file *filp)
 {
-	ide_drive_t *drive = inode->i_bdev->bd_disk->private_data;
+	struct gendisk *disk = inode->i_bdev->bd_disk;
+	struct ide_tape_obj *tape;
+	ide_drive_t *drive;
+
+	if (!(tape = ide_tape_get(disk)))
+		return -ENXIO;
+
+	drive = tape->drive;
+
 	drive->usage++;
+
 	return 0;
 }

 static int idetape_release(struct inode *inode, struct file *filp)
 {
-	ide_drive_t *drive = inode->i_bdev->bd_disk->private_data;
+	struct gendisk *disk = inode->i_bdev->bd_disk;
+	struct ide_tape_obj *tape = ide_tape_g(disk);
+	ide_drive_t *drive = tape->drive;
+
 	drive->usage--;
+
+	ide_tape_put(tape);
+
 	return 0;
 }

@@ -4723,7 +4776,8 @@
 			unsigned int cmd, unsigned long arg)
 {
 	struct block_device *bdev = inode->i_bdev;
-	ide_drive_t *drive = bdev->bd_disk->private_data;
+	struct ide_tape_obj *tape = ide_tape_g(bdev->bd_disk);
+	ide_drive_t *drive = tape->drive;
 	int err = generic_ide_ioctl(drive, file, bdev, cmd, arg);
 	if (err == -EINVAL)
 		err = idetape_blkdev_ioctl(drive, cmd, arg);
@@ -4740,6 +4794,7 @@
 static int idetape_attach (ide_drive_t *drive)
 {
 	idetape_tape_t *tape;
+	struct gendisk *g = drive->disk;
 	int minor;

 	if (!strstr("ide-tape", drive->driver_req))
@@ -4772,6 +4827,15 @@
 	}
 	for (minor = 0; idetape_chrdevs[minor].drive != NULL; minor++)
 		;
+
+	memset(tape, 0, sizeof(*tape));
+
+	kref_init(&tape->kref);
+
+	tape->drive = drive;
+
+	drive->driver_data = tape;
+
 	idetape_setup(drive, tape, minor);
 	idetape_chrdevs[minor].drive = drive;

@@ -4782,8 +4846,10 @@
 			S_IFCHR | S_IRUGO | S_IWUGO,
 			"%s/mtn", drive->devfs_name);

-	drive->disk->number = devfs_register_tape(drive->devfs_name);
-	drive->disk->fops = &idetape_block_ops;
+	g->number = devfs_register_tape(drive->devfs_name);
+	g->fops = &idetape_block_ops;
+	g->private_data = tape;
+
 	return 0;
 failed:
 	return 1;
