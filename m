Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263101AbVBDCya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbVBDCya (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 21:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbVBDCy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 21:54:28 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:28340 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S263223AbVBDCxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 21:53:30 -0500
Date: Fri, 4 Feb 2005 03:49:35 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 3/9] drive->dsc_overlap fix
Message-ID: <Pine.GSO.4.58.0502040348560.4393@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


drive->dsc_overlap is supported only by ide-{cd,tape} drivers.
Add missing clearing of ->dsc_overlap to ide_{cd,tape}_release()
and move ->dsc_overlap setup from ide_register_subdriver() to
ide_cdrom_setup() (ide-tape enables it unconditionally).

diff -Nru a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
--- a/drivers/ide/ide-cd.c	2005-02-04 03:31:14 +01:00
+++ b/drivers/ide/ide-cd.c	2005-02-04 03:31:14 +01:00
@@ -3219,6 +3219,9 @@
 	 */
 	blk_queue_hardsect_size(drive->queue, CD_FRAMESIZE);

+	if (drive->autotune == IDE_TUNE_DEFAULT ||
+	    drive->autotune == IDE_TUNE_AUTO)
+		drive->dsc_overlap = (drive->next != drive);
 #if 0
 	drive->dsc_overlap = (HWIF(drive)->no_dsc) ? 0 : 1;
 	if (HWIF(drive)->no_dsc) {
@@ -3282,6 +3285,7 @@
 	if (devinfo->handle == drive && unregister_cdrom(devinfo))
 		printk(KERN_ERR "%s: %s failed to unregister device from the cdrom "
 				"driver.\n", __FUNCTION__, drive->name);
+	drive->dsc_overlap = 0;
 	drive->driver_data = NULL;
 	blk_queue_prep_rq(drive->queue, NULL);
 	g->private_data = NULL;
diff -Nru a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
--- a/drivers/ide/ide-tape.c	2005-02-04 03:31:14 +01:00
+++ b/drivers/ide/ide-tape.c	2005-02-04 03:31:14 +01:00
@@ -4691,6 +4691,7 @@
 	ide_drive_t *drive = tape->drive;
 	struct gendisk *g = drive->disk;

+	drive->dsc_overlap = 0;
 	drive->driver_data = NULL;
 	devfs_remove("%s/mt", drive->devfs_name);
 	devfs_remove("%s/mtn", drive->devfs_name);
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2005-02-04 03:31:14 +01:00
+++ b/drivers/ide/ide.c	2005-02-04 03:31:14 +01:00
@@ -2029,11 +2029,6 @@
 	list_add_tail(&drive->list, &driver->drives);
 	spin_unlock(&drives_lock);
 //	printk(KERN_INFO "%s: attached %s driver.\n", drive->name, driver->name);
-	if ((drive->autotune == IDE_TUNE_DEFAULT) ||
-		(drive->autotune == IDE_TUNE_AUTO)) {
-		/* DMA timings and setup moved to ide-probe.c */
-		drive->dsc_overlap = (drive->next != drive && driver->supports_dsc_overlap);
-	}
 #ifdef CONFIG_PROC_FS
 	if (drive->driver != &idedefault_driver)
 		ide_add_proc_entries(drive->proc, driver->proc, drive);
