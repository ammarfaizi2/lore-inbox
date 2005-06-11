Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbVFKI3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbVFKI3M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 04:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVFKI2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 04:28:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:4292 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261652AbVFKHsv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 03:48:51 -0400
Subject: [PATCH] Remove the ide drive devfs_name field as it's no longer needed
In-Reply-To: <11184761121906@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Sat, 11 Jun 2005 00:48:32 -0700
Message-Id: <11184761123101@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Also fixes all drivers that set this field.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/ide/ide-disk.c  |    1 -
 drivers/ide/ide-probe.c |    8 --------
 drivers/ide/ide.c       |    5 +----
 include/linux/ide.h     |    1 -
 4 files changed, 1 insertion(+), 14 deletions(-)

--- gregkh-2.6.orig/include/linux/ide.h	2005-06-10 23:28:58.000000000 -0700
+++ gregkh-2.6/include/linux/ide.h	2005-06-10 23:37:24.000000000 -0700
@@ -668,7 +668,6 @@
 	struct hd_driveid	*id;	/* drive model identification info */
 	struct proc_dir_entry *proc;	/* /proc/ide/ directory entry */
 	struct ide_settings_s *settings;/* /proc/ide/ drive settings */
-	char		devfs_name[64];	/* devfs crap */
 
 	struct hwif_s		*hwif;	/* actually (ide_hwif_t *) */
 
--- gregkh-2.6.orig/drivers/ide/ide-disk.c	2005-06-10 23:37:22.000000000 -0700
+++ gregkh-2.6/drivers/ide/ide-disk.c	2005-06-10 23:37:24.000000000 -0700
@@ -1048,7 +1048,6 @@
 	struct gendisk *g = idkp->disk;
 
 	drive->driver_data = NULL;
-	drive->devfs_name[0] = '\0';
 	g->private_data = NULL;
 	put_disk(g);
 	kfree(idkp);
--- gregkh-2.6.orig/drivers/ide/ide-probe.c	2005-06-10 23:37:21.000000000 -0700
+++ gregkh-2.6/drivers/ide/ide-probe.c	2005-06-10 23:37:24.000000000 -0700
@@ -1307,8 +1307,6 @@
 	ide_drive_t *drive = container_of(dev, ide_drive_t, gendev);
 
 	spin_lock_irq(&ide_lock);
-	if (drive->devfs_name[0] != '\0')
-		drive->devfs_name[0] = '\0';
 	ide_remove_drive_from_hwgroup(drive);
 	if (drive->id != NULL) {
 		kfree(drive->id);
@@ -1344,12 +1342,6 @@
 		drive->gendev.bus = &ide_bus_type;
 		drive->gendev.driver_data = drive;
 		drive->gendev.release = drive_release_dev;
-		if (drive->present) {
-			sprintf(drive->devfs_name, "ide/host%d/bus%d/target%d/lun%d",
-				(hwif->channel && hwif->mate) ?
-				hwif->mate->index : hwif->index,
-				hwif->channel, unit, drive->lun);
-		}
 	}
 	blk_register_region(MKDEV(hwif->major, 0), MAX_DRIVES << PARTN_BITS,
 			THIS_MODULE, ata_probe, ata_lock, hwif);
--- gregkh-2.6.orig/drivers/ide/ide.c	2005-06-10 23:37:21.000000000 -0700
+++ gregkh-2.6/drivers/ide/ide.c	2005-06-10 23:37:24.000000000 -0700
@@ -592,11 +592,8 @@
 		goto abort;
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		drive = &hwif->drives[unit];
-		if (!drive->present) {
-			if (drive->devfs_name[0] != '\0')
-				drive->devfs_name[0] = '\0';
+		if (!drive->present)
 			continue;
-		}
 		spin_unlock_irq(&ide_lock);
 		device_unregister(&drive->gendev);
 		down(&drive->gendev_rel_sem);

