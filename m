Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267292AbUBSPIF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 10:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267339AbUBSPFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 10:05:54 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:57828 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267285AbUBSOz1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 09:55:27 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IDE update for 2.6.3 (3/9)
Date: Thu, 19 Feb 2004 15:57:21 +0100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402191557.21350.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] kill useless IDE_SUBDRIVER_VERSION

 linux-2.6.3-root/drivers/ide/ide-cd.c      |    2 +-
 linux-2.6.3-root/drivers/ide/ide-default.c |    3 +--
 linux-2.6.3-root/drivers/ide/ide-disk.c    |    2 +-
 linux-2.6.3-root/drivers/ide/ide-floppy.c  |    2 +-
 linux-2.6.3-root/drivers/ide/ide-tape.c    |    2 +-
 linux-2.6.3-root/drivers/ide/ide.c         |   12 ++++++------
 linux-2.6.3-root/drivers/scsi/ide-scsi.c   |    3 +--
 linux-2.6.3-root/include/linux/ide.h       |    4 +---
 8 files changed, 13 insertions(+), 17 deletions(-)

diff -puN drivers/ide/ide.c~ide_subdriver_version drivers/ide/ide.c
--- linux-2.6.3/drivers/ide/ide.c~ide_subdriver_version	2004-02-19 02:09:06.038660512 +0100
+++ linux-2.6.3-root/drivers/ide/ide.c	2004-02-19 02:09:06.073655192 +0100
@@ -2274,15 +2274,15 @@ static void setup_driver_defaults (ide_d
 		d->start_power_step = default_start_power_step;
 }
 
-int ide_register_subdriver (ide_drive_t *drive, ide_driver_t *driver, int version)
+int ide_register_subdriver(ide_drive_t *drive, ide_driver_t *driver)
 {
 	unsigned long flags;
-	
-	BUG_ON(drive->driver == NULL);
-	
+
+	BUG_ON(!drive->driver);
+
 	spin_lock_irqsave(&ide_lock, flags);
-	if (version != IDE_SUBDRIVER_VERSION || !drive->present ||
-	    drive->driver != &idedefault_driver || drive->usage || drive->dead) {
+	if (!drive->present || drive->driver != &idedefault_driver ||
+	    drive->usage || drive->dead) {
 		spin_unlock_irqrestore(&ide_lock, flags);
 		return 1;
 	}
diff -puN drivers/ide/ide-cd.c~ide_subdriver_version drivers/ide/ide-cd.c
--- linux-2.6.3/drivers/ide/ide-cd.c~ide_subdriver_version	2004-02-19 02:09:06.043659752 +0100
+++ linux-2.6.3-root/drivers/ide/ide-cd.c	2004-02-19 02:09:06.078654432 +0100
@@ -3517,7 +3517,7 @@ static int ide_cdrom_attach (ide_drive_t
 		printk("%s: Can't allocate a cdrom structure\n", drive->name);
 		goto failed;
 	}
-	if (ide_register_subdriver(drive, &ide_cdrom_driver, IDE_SUBDRIVER_VERSION)) {
+	if (ide_register_subdriver(drive, &ide_cdrom_driver)) {
 		printk("%s: Failed to register the driver with ide.c\n",
 			drive->name);
 		kfree(info);
diff -puN drivers/ide/ide-default.c~ide_subdriver_version drivers/ide/ide-default.c
--- linux-2.6.3/drivers/ide/ide-default.c~ide_subdriver_version	2004-02-19 02:09:06.047659144 +0100
+++ linux-2.6.3-root/drivers/ide/ide-default.c	2004-02-19 02:09:06.079654280 +0100
@@ -51,8 +51,7 @@ ide_driver_t idedefault_driver = {
 
 static int idedefault_attach (ide_drive_t *drive)
 {
-	if (ide_register_subdriver(drive,
-			&idedefault_driver, IDE_SUBDRIVER_VERSION)) {
+	if (ide_register_subdriver(drive, &idedefault_driver)) {
 		printk(KERN_ERR "ide-default: %s: Failed to register the "
 			"driver with ide.c\n", drive->name);
 		return 1;
diff -puN drivers/ide/ide-disk.c~ide_subdriver_version drivers/ide/ide-disk.c
--- linux-2.6.3/drivers/ide/ide-disk.c~ide_subdriver_version	2004-02-19 02:09:06.050658688 +0100
+++ linux-2.6.3-root/drivers/ide/ide-disk.c	2004-02-19 02:09:06.081653976 +0100
@@ -1829,7 +1829,7 @@ static int idedisk_attach(ide_drive_t *d
 	if (drive->media != ide_disk)
 		goto failed;
 
-	if (ide_register_subdriver (drive, &idedisk_driver, IDE_SUBDRIVER_VERSION)) {
+	if (ide_register_subdriver(drive, &idedisk_driver)) {
 		printk (KERN_ERR "ide-disk: %s: Failed to register the driver with ide.c\n", drive->name);
 		goto failed;
 	}
diff -puN drivers/ide/ide-floppy.c~ide_subdriver_version drivers/ide/ide-floppy.c
--- linux-2.6.3/drivers/ide/ide-floppy.c~ide_subdriver_version	2004-02-19 02:09:06.054658080 +0100
+++ linux-2.6.3-root/drivers/ide/ide-floppy.c	2004-02-19 02:09:06.084653520 +0100
@@ -2055,7 +2055,7 @@ static int idefloppy_attach (ide_drive_t
 		printk (KERN_ERR "ide-floppy: %s: Can't allocate a floppy structure\n", drive->name);
 		goto failed;
 	}
-	if (ide_register_subdriver (drive, &idefloppy_driver, IDE_SUBDRIVER_VERSION)) {
+	if (ide_register_subdriver(drive, &idefloppy_driver)) {
 		printk (KERN_ERR "ide-floppy: %s: Failed to register the driver with ide.c\n", drive->name);
 		kfree (floppy);
 		goto failed;
diff -puN drivers/ide/ide-tape.c~ide_subdriver_version drivers/ide/ide-tape.c
--- linux-2.6.3/drivers/ide/ide-tape.c~ide_subdriver_version	2004-02-19 02:09:06.061657016 +0100
+++ linux-2.6.3-root/drivers/ide/ide-tape.c	2004-02-19 02:09:06.091652456 +0100
@@ -6454,7 +6454,7 @@ static int idetape_attach (ide_drive_t *
 		printk(KERN_ERR "ide-tape: %s: Can't allocate a tape structure\n", drive->name);
 		goto failed;
 	}
-	if (ide_register_subdriver (drive, &idetape_driver, IDE_SUBDRIVER_VERSION)) {
+	if (ide_register_subdriver(drive, &idetape_driver)) {
 		printk(KERN_ERR "ide-tape: %s: Failed to register the driver with ide.c\n", drive->name);
 		kfree(tape);
 		goto failed;
diff -puN drivers/scsi/ide-scsi.c~ide_subdriver_version drivers/scsi/ide-scsi.c
--- linux-2.6.3/drivers/scsi/ide-scsi.c~ide_subdriver_version	2004-02-19 02:09:06.065656408 +0100
+++ linux-2.6.3-root/drivers/scsi/ide-scsi.c	2004-02-19 02:09:06.094652000 +0100
@@ -971,8 +971,7 @@ static int idescsi_attach(ide_drive_t *d
 	drive->driver_data = host;
 	idescsi = scsihost_to_idescsi(host);
 	idescsi->drive = drive;
-	err = ide_register_subdriver (drive, &idescsi_driver,
-				      IDE_SUBDRIVER_VERSION);
+	err = ide_register_subdriver(drive, &idescsi_driver);
 	if (!err) {
 		idescsi_setup (drive, idescsi);
 		drive->disk->fops = &idescsi_ops;
diff -puN include/linux/ide.h~ide_subdriver_version include/linux/ide.h
--- linux-2.6.3/include/linux/ide.h~ide_subdriver_version	2004-02-19 02:09:06.069655800 +0100
+++ linux-2.6.3-root/include/linux/ide.h	2004-02-19 02:09:06.096651696 +0100
@@ -1152,8 +1152,6 @@ enum {
 /*
  * Subdrivers support.
  */
-#define IDE_SUBDRIVER_VERSION	1
-
 typedef struct ide_driver_s {
 	struct module			*owner;
 	const char			*name;
@@ -1525,7 +1523,7 @@ extern void default_hwif_transport(ide_h
 
 int ide_register_driver(ide_driver_t *driver);
 void ide_unregister_driver(ide_driver_t *driver);
-int ide_register_subdriver (ide_drive_t *drive, ide_driver_t *driver, int version);
+int ide_register_subdriver(ide_drive_t *, ide_driver_t *);
 int ide_unregister_subdriver (ide_drive_t *drive);
 int ide_replace_subdriver(ide_drive_t *drive, const char *driver);
 

_

