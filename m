Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263566AbTHXNHj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 09:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263525AbTHXNGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 09:06:38 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:12275 "EHLO gaston")
	by vger.kernel.org with ESMTP id S263569AbTHXNF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 09:05:29 -0400
Subject: [PATCH] Fix ide unregister vs. driver model
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061730317.31688.10.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 24 Aug 2003 15:05:17 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart !

This patch seem to have been lost, so here it is again. It fixes
an Ooops on unregistering hwifs due to the device model now having
mandatory release() functions. It also close the possible race we
had on release if the entry was in use (by or /sys typically) by
using a semaphore waiting for the release() to be called after
doing an unregister.

It also include the fix for the gendev parent that wasn't merged
neither.

Please submit to Linus,

Regards,
Ben.

===== drivers/ide/ide-probe.c 1.58 vs edited =====
--- 1.58/drivers/ide/ide-probe.c	Fri Aug 15 01:52:06 2003
+++ edited/drivers/ide/ide-probe.c	Sun Aug 24 15:00:35 2003
@@ -644,15 +644,25 @@
 	return drive->present;
 }
 
+static void hwif_release_dev (struct device *dev)
+{
+	ide_hwif_t *hwif = container_of(dev, ide_hwif_t, gendev);
+
+	up(&hwif->gendev_rel_sem);
+}
+
 static void hwif_register (ide_hwif_t *hwif)
 {
 	/* register with global device tree */
 	strlcpy(hwif->gendev.bus_id,hwif->name,BUS_ID_SIZE);
 	hwif->gendev.driver_data = hwif;
+	if (hwif->gendev.parent == NULL) {
 	if (hwif->pci_dev)
 		hwif->gendev.parent = &hwif->pci_dev->dev;
 	else
 		hwif->gendev.parent = NULL; /* Would like to do = &device_legacy */
+	}
+	hwif->gendev.release = hwif_release_dev;
 	device_register(&hwif->gendev);
 }
 
@@ -1201,6 +1211,13 @@
 	return -ENOMEM;
 }
 
+static void drive_release_dev (struct device *dev)
+{
+	ide_drive_t *drive = container_of(dev, ide_drive_t, gendev);
+
+	up(&drive->gendev_rel_sem);
+}
+
 /*
  * init_gendisk() (as opposed to ide_geninit) is called for each major device,
  * after probing for drives, to allocate partition tables and other data
@@ -1219,6 +1236,7 @@
 		drive->gendev.parent = &hwif->gendev;
 		drive->gendev.bus = &ide_bus_type;
 		drive->gendev.driver_data = drive;
+		drive->gendev.release = drive_release_dev;
 		if (drive->present) {
 			device_register(&drive->gendev);
 			sprintf(drive->devfs_name, "ide/host%d/bus%d/target%d/lun%d",
===== drivers/ide/ide.c 1.87 vs edited =====
--- 1.87/drivers/ide/ide.c	Wed Aug 20 18:01:03 2003
+++ edited/drivers/ide/ide.c	Sun Aug 24 15:00:54 2003
@@ -255,6 +255,8 @@
 	hwif->mwdma_mask = 0x80;	/* disable all mwdma */
 	hwif->swdma_mask = 0x80;	/* disable all swdma */
 
+	sema_init(&hwif->gendev_rel_sem, 0);
+
 	default_hwif_iops(hwif);
 	default_hwif_transport(hwif);
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
@@ -277,6 +279,7 @@
 		drive->driver			= &idedefault_driver;
 		drive->vdma			= 0;
 		INIT_LIST_HEAD(&drive->list);
+		sema_init(&drive->gendev_rel_sem, 0);
 	}
 }
 
@@ -749,6 +752,7 @@
 		spin_unlock_irq(&ide_lock);
 		blk_cleanup_queue(drive->queue);
 		device_unregister(&drive->gendev);
+		down(&drive->gendev_rel_sem);
 		spin_lock_irq(&ide_lock);
 		drive->queue = NULL;
 	}
@@ -778,6 +782,7 @@
 	/* More messed up locking ... */
 	spin_unlock_irq(&ide_lock);
 	device_unregister(&hwif->gendev);
+	down(&hwif->gendev_rel_sem);
 
 	/*
 	 * Remove us from the kernel's knowledge
===== include/linux/ide.h 1.67 vs edited =====
--- 1.67/include/linux/ide.h	Wed Aug 20 18:01:03 2003
+++ edited/include/linux/ide.h	Sun Aug 24 15:01:22 2003
@@ -22,6 +22,7 @@
 #include <asm/system.h>
 #include <asm/hdreg.h>
 #include <asm/io.h>
+#include <asm/semaphore.h>
 
 #define DEBUG_PM
 
@@ -774,6 +775,7 @@
 	int		crc_count;	/* crc counter to reduce drive speed */
 	struct list_head list;
 	struct device	gendev;
+	struct semaphore gendev_rel_sem;	/* to deal with device release() */
 	struct gendisk *disk;
 } ide_drive_t;
 
@@ -1040,6 +1042,7 @@
 	unsigned	auto_poll  : 1; /* supports nop auto-poll */
 
 	struct device	gendev;
+	struct semaphore gendev_rel_sem; /* To deal with device release() */
 
 	void		*hwif_data;	/* extra hwif data */
 

