Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263133AbTDRQCi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 12:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263146AbTDRQBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 12:01:20 -0400
Received: from verein.lst.de ([212.34.181.86]:12301 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S263133AbTDRQBA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 12:01:00 -0400
Date: Fri, 18 Apr 2003 18:12:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] devfs (3/7) - cleanup devfs use in ide
Message-ID: <20030418181254.C363@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Store the path of it's devfs directory in ide_drive_t.  Use
it in the devfs_register calls instead of the devfs_handle_t
which will go away soon.


diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	Fri Apr 18 15:57:08 2003
+++ b/drivers/ide/ide-probe.c	Fri Apr 18 15:57:08 2003
@@ -1289,7 +1289,6 @@
 
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		ide_drive_t * drive = &hwif->drives[unit];
-		char name[64];
 		ide_add_generic_settings(drive);
 		snprintf(drive->gendev.bus_id,BUS_ID_SIZE,"%u.%u",
 			 hwif->index,unit);
@@ -1298,13 +1297,13 @@
 		drive->gendev.parent = &hwif->gendev;
 		drive->gendev.bus = &ide_bus_type;
 		drive->gendev.driver_data = drive;
-		sprintf (name, "ide/host%d/bus%d/target%d/lun%d",
-			(hwif->channel && hwif->mate) ?
-			hwif->mate->index : hwif->index,
-			hwif->channel, unit, drive->lun);
 		if (drive->present) {
 			device_register(&drive->gendev);
-			drive->de = devfs_mk_dir(name);
+			sprintf(drive->devfs_name, "ide/host%d/bus%d/target%d/lun%d",
+				(hwif->channel && hwif->mate) ?
+				hwif->mate->index : hwif->index,
+				hwif->channel, unit, drive->lun);
+			drive->de = devfs_mk_dir(drive->devfs_name);
 		}
 	}
 	blk_register_region(MKDEV(hwif->major, 0), MAX_DRIVES << PARTN_BITS,
diff -Nru a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
--- a/drivers/ide/ide-tape.c	Fri Apr 18 15:57:08 2003
+++ b/drivers/ide/ide-tape.c	Fri Apr 18 15:57:08 2003
@@ -866,8 +866,6 @@
  */
 typedef struct {
 	ide_drive_t *drive;
-	devfs_handle_t de_r, de_n;
-
 	/*
 	 *	Since a typical character device operation requires more
 	 *	than one packet command, we provide here enough memory
@@ -6170,8 +6168,8 @@
 	DRIVER(drive)->busy = 0;
 	(void) ide_unregister_subdriver(drive);
 	drive->driver_data = NULL;
-	devfs_unregister(tape->de_r);
-	devfs_unregister(tape->de_n);
+	devfs_remove("%s/mt");
+	devfs_remove("%s/mtn");
 	devfs_unregister_tape(drive->disk->number);
 	kfree (tape);
 	drive->disk->fops = ide_fops;
@@ -6272,6 +6270,7 @@
 static int idetape_attach (ide_drive_t *drive)
 {
 	idetape_tape_t *tape;
+	char devfs_name[64];
 	int minor;
 
 	if (!strstr("ide-tape", drive->driver_req))
@@ -6306,16 +6305,19 @@
 		;
 	idetape_setup(drive, tape, minor);
 	idetape_chrdevs[minor].drive = drive;
-	tape->de_r =
-	    devfs_register (drive->de, "mt", DEVFS_FL_DEFAULT,
-			    HWIF(drive)->major, minor,
-			    S_IFCHR | S_IRUGO | S_IWUGO,
-			    &idetape_fops, NULL);
-	tape->de_n =
-	    devfs_register (drive->de, "mtn", DEVFS_FL_DEFAULT,
-			    HWIF(drive)->major, minor + 128,
-			    S_IFCHR | S_IRUGO | S_IWUGO,
-			    &idetape_fops, NULL);
+
+	sprintf(devfs_name, "%s/mt", drive->devfs_name);
+	tape->de_r = devfs_register (NULL, devfs_name, 0,
+			HWIF(drive)->major, minor,
+			S_IFCHR | S_IRUGO | S_IWUGO,
+			&idetape_fops, NULL);
+
+	sprintf(devfs_name, "%s/mtn", drive->devfs_name);
+	tape->de_n = devfs_register (NULL, devfs_name, 0,
+			HWIF(drive)->major, minor + 128,
+			S_IFCHR | S_IRUGO | S_IWUGO,
+			&idetape_fops, NULL);
+
 	drive->disk->number = devfs_register_tape(drive->de);
 	drive->disk->fops = &idetape_block_ops;
 	return 0;
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	Fri Apr 18 15:57:08 2003
+++ b/drivers/ide/ide.c	Fri Apr 18 15:57:08 2003
@@ -650,9 +650,9 @@
 	 */
 	for (i = 0; i < MAX_DRIVES; ++i) {
 		drive = &hwif->drives[i];
-		if (drive->de) {
-			devfs_unregister(drive->de);
-			drive->de = NULL;
+		if (drive->devfs_name[0] != '\0') {
+			devfs_remove(drive->devfs_name);
+			drive->devfs_name[0] = '\0';
 		}
 		if (!drive->present)
 			continue;
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	Fri Apr 18 15:57:08 2003
+++ b/include/linux/ide.h	Fri Apr 18 15:57:08 2003
@@ -699,7 +699,8 @@
 	struct hd_driveid	*id;	/* drive model identification info */
 	struct proc_dir_entry *proc;	/* /proc/ide/ directory entry */
 	struct ide_settings_s *settings;/* /proc/ide/ drive settings */
-	devfs_handle_t		de;	/* directory for device */
+	char		devfs_name[64];	/* devfs crap */
+	devfs_handle_t		de;	/* will go away soon */
 
 	struct hwif_s		*hwif;	/* actually (ide_hwif_t *) */
 
