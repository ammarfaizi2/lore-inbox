Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbVFUHXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbVFUHXn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 03:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVFUHXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 03:23:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:52707 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261990AbVFUGay convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 02:30:54 -0400
Cc: gregkh@suse.de
Subject: [PATCH] devfs: Remove the ide drive devfs_name field as it's no longer needed
In-Reply-To: <11193354443627@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 23:30:44 -0700
Message-Id: <1119335444907@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] devfs: Remove the ide drive devfs_name field as it's no longer needed

Also fixes all drivers that set this field.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit ea01c9408e24fdcd26b87d6f68cafdcdd19a791b
tree 28d6924dd91f30d5068536b8c071e4bccbeb2d20
parent 4a8c1e81ac1235c3861c0ab6c4bad960e945c451
author Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 21:15:16 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 23:13:38 -0700

 drivers/ide/ide-disk.c  |    1 -
 drivers/ide/ide-probe.c |    8 --------
 drivers/ide/ide.c       |    5 +----
 include/linux/ide.h     |    1 -
 4 files changed, 1 insertions(+), 14 deletions(-)

diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -1048,7 +1048,6 @@ static void ide_disk_release(struct kref
 	struct gendisk *g = idkp->disk;
 
 	drive->driver_data = NULL;
-	drive->devfs_name[0] = '\0';
 	g->private_data = NULL;
 	put_disk(g);
 	kfree(idkp);
diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1307,8 +1307,6 @@ static void drive_release_dev (struct de
 	ide_drive_t *drive = container_of(dev, ide_drive_t, gendev);
 
 	spin_lock_irq(&ide_lock);
-	if (drive->devfs_name[0] != '\0')
-		drive->devfs_name[0] = '\0';
 	ide_remove_drive_from_hwgroup(drive);
 	if (drive->id != NULL) {
 		kfree(drive->id);
@@ -1344,12 +1342,6 @@ static void init_gendisk (ide_hwif_t *hw
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
diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -592,11 +592,8 @@ void ide_unregister(unsigned int index)
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
diff --git a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -668,7 +668,6 @@ typedef struct ide_drive_s {
 	struct hd_driveid	*id;	/* drive model identification info */
 	struct proc_dir_entry *proc;	/* /proc/ide/ directory entry */
 	struct ide_settings_s *settings;/* /proc/ide/ drive settings */
-	char		devfs_name[64];	/* devfs crap */
 
 	struct hwif_s		*hwif;	/* actually (ide_hwif_t *) */
 

