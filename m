Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263053AbVBDC7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbVBDC7n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 21:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263021AbVBDC4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 21:56:19 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:37812 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S263230AbVBDCx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 21:53:59 -0500
Date: Fri, 4 Feb 2005 03:50:56 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 5/9] add ide_{un}register_region()
Message-ID: <Pine.GSO.4.58.0502040350060.4393@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add ide_{un}register_region() and fix ide-{tape,scsi}.c to register
block device number ranges.  In ata_probe() only probe for modules.

Behavior is unchanged because:
* if driver is already loaded and attached to drive ata_probe()
  is not called et all
* if driver is loaded by ata_probe() it will register new number range
  for a drive and this range will be found by kobj_lookup()

If this is not clear please read http://lwn.net/Articles/25711/
and see drivers/base/map.c.

This patch makes it possible to move drive->disk allocation from
ide-probe.c to device drivers.

diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	2005-02-04 03:31:35 +01:00
+++ b/drivers/ide/ide-probe.c	2005-02-04 03:31:35 +01:00
@@ -1214,8 +1214,6 @@
 	return 0;
 }

-extern ide_driver_t idedefault_driver;
-
 static struct kobject *ata_probe(dev_t dev, int *part, void *data)
 {
 	ide_hwif_t *hwif = data;
@@ -1223,23 +1221,52 @@
 	ide_drive_t *drive = &hwif->drives[unit];
 	if (!drive->present)
 		return NULL;
-	if (drive->driver == &idedefault_driver) {
-		if (drive->media == ide_disk)
-			(void) request_module("ide-disk");
-		if (drive->scsi)
-			(void) request_module("ide-scsi");
-		if (drive->media == ide_cdrom || drive->media == ide_optical)
-			(void) request_module("ide-cd");
-		if (drive->media == ide_tape)
-			(void) request_module("ide-tape");
-		if (drive->media == ide_floppy)
-			(void) request_module("ide-floppy");
-	}
-	if (drive->driver == &idedefault_driver)
-		return NULL;
+
+	if (drive->media == ide_disk)
+		request_module("ide-disk");
+	if (drive->scsi)
+		request_module("ide-scsi");
+	if (drive->media == ide_cdrom || drive->media == ide_optical)
+		request_module("ide-cd");
+	if (drive->media == ide_tape)
+		request_module("ide-tape");
+	if (drive->media == ide_floppy)
+		request_module("ide-floppy");
+
+	return NULL;
+}
+
+static struct kobject *exact_match(dev_t dev, int *part, void *data)
+{
+	struct gendisk *p = data;
 	*part &= (1 << PARTN_BITS) - 1;
-	return get_disk(drive->disk);
+	return &p->kobj;
 }
+
+static int exact_lock(dev_t dev, void *data)
+{
+	struct gendisk *p = data;
+
+	if (!get_disk(p))
+		return -1;
+	return 0;
+}
+
+void ide_register_region(struct gendisk *disk)
+{
+	blk_register_region(MKDEV(disk->major, disk->first_minor),
+			    disk->minors, NULL, exact_match, exact_lock, disk);
+}
+
+EXPORT_SYMBOL_GPL(ide_register_region);
+
+void ide_unregister_region(struct gendisk *disk)
+{
+	blk_unregister_region(MKDEV(disk->major, disk->first_minor),
+			      disk->minors);
+}
+
+EXPORT_SYMBOL_GPL(ide_unregister_region);

 static int alloc_disks(ide_hwif_t *hwif)
 {
diff -Nru a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
--- a/drivers/ide/ide-tape.c	2005-02-04 03:31:35 +01:00
+++ b/drivers/ide/ide-tape.c	2005-02-04 03:31:35 +01:00
@@ -4680,6 +4680,8 @@
 	DRIVER(drive)->busy = 0;
 	(void) ide_unregister_subdriver(drive);

+	ide_unregister_region(drive->disk);
+
 	ide_tape_put(tape);

 	return 0;
@@ -4871,6 +4873,7 @@
 	g->number = devfs_register_tape(drive->devfs_name);
 	g->fops = &idetape_block_ops;
 	g->private_data = tape;
+	ide_register_region(g);

 	return 0;
 failed:
diff -Nru a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
--- a/drivers/scsi/ide-scsi.c	2005-02-04 03:31:35 +01:00
+++ b/drivers/scsi/ide-scsi.c	2005-02-04 03:31:35 +01:00
@@ -723,6 +723,8 @@
 	if (ide_unregister_subdriver(drive))
 		return 1;

+	ide_unregister_region(g);
+
 	/* FIXME: drive->driver_data shouldn't be used */
 	drive->driver_data = NULL;
 	/* FIXME: add driver's private struct gendisk */
@@ -1122,12 +1124,14 @@
 		idescsi_setup (drive, idescsi);
 		g->fops = &idescsi_ops;
 		g->private_data = idescsi;
+		ide_register_region(g);
 		err = scsi_add_host(host, &drive->gendev);
 		if (!err) {
 			scsi_scan_host(host);
 			return 0;
 		}
 		/* fall through on error */
+		ide_unregister_region(g);
 		ide_unregister_subdriver(drive);
 	}

diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	2005-02-04 03:31:35 +01:00
+++ b/include/linux/ide.h	2005-02-04 03:31:35 +01:00
@@ -1456,6 +1456,9 @@
 extern void ide_hwif_release_regions(ide_hwif_t* hwif);
 extern void ide_unregister (unsigned int index);

+void ide_register_region(struct gendisk *);
+void ide_unregister_region(struct gendisk *);
+
 void ide_undecoded_slave(ide_hwif_t *);

 int probe_hwif_init_with_fixup(ide_hwif_t *, void (*)(ide_hwif_t *));
