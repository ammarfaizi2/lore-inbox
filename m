Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbUEFHF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbUEFHF2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 03:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbUEFHF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 03:05:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61862 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261764AbUEFHFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 03:05:04 -0400
Date: Thu, 6 May 2004 09:04:49 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
Cc: akpm@osdl.org
Subject: Force IDE cache flush on shutdown
Message-ID: <20040506070449.GA12862@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Alan discovered the hard way that the current 2.6 IDE code doesn't do a
cache-flush on shutdown. The patch below forward ports this from 2.4. In
addition it fixes a bug where the ->wcache value only got determined for
removable disks not all disks. (that fix is from Alan, all other bugs are
mine ;)

Greetings,
   Arjan van de Ven

diff -urNp linux-1110/drivers/ide/ide-disk.c linux-1120/drivers/ide/ide-disk.c
--- linux-1110/drivers/ide/ide-disk.c
+++ linux-1120/drivers/ide/ide-disk.c
@@ -58,6 +58,8 @@
 #include <linux/genhd.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/reboot.h>
+
 
 #define _IDE_DISK
 
@@ -1729,11 +1733,11 @@ static ide_driver_t idedisk_driver = {
 
 static int idedisk_open(struct inode *inode, struct file *filp)
 {
+	u8 cf;
 	ide_drive_t *drive = inode->i_bdev->bd_disk->private_data;
 	drive->usage++;
 	if (drive->removable && drive->usage == 1) {
 		ide_task_t args;
-		u8 cf;
 		memset(&args, 0, sizeof(ide_task_t));
 		args.tfRegister[IDE_COMMAND_OFFSET] = WIN_DOORLOCK;
 		args.command_type = IDE_DRIVE_TASK_NO_DATA;
@@ -1746,18 +1750,18 @@ static int idedisk_open(struct inode *in
 		 */
 		if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
 			drive->doorlocking = 0;
-		drive->wcache = 0;
-		/* Cache enabled ? */
-		if (drive->id->csfo & 1)
-		drive->wcache = 1;
-		/* Cache command set available ? */
-		if (drive->id->cfs_enable_1 & (1<<5))
-			drive->wcache = 1;
-		/* ATA6 cache extended commands */
-		cf = drive->id->command_set_2 >> 24;
-		if((cf & 0xC0) == 0x40 && (cf & 0x30) != 0)
-			drive->wcache = 1;
 	}
+	drive->wcache = 0;
+	/* Cache enabled ? */
+	if (drive->id->csfo & 1)
+		drive->wcache = 1;
+	/* Cache command set available ? */
+	if (drive->id->cfs_enable_1 & (1<<5))
+		drive->wcache = 1;
+	/* ATA6 cache extended commands */
+	cf = drive->id->command_set_2 >> 24;
+	if((cf & 0xC0) == 0x40 && (cf & 0x30) != 0)
+		drive->wcache = 1;
 	return 0;
 }
 
@@ -1779,6 +1783,7 @@ static int ide_cacheflush_p(ide_drive_t 
 static int idedisk_release(struct inode *inode, struct file *filp)
 {
 	ide_drive_t *drive = inode->i_bdev->bd_disk->private_data;
+	ide_cacheflush_p(drive);
 	if (drive->removable && drive->usage == 1) {
 		ide_task_t args;
 		memset(&args, 0, sizeof(ide_task_t));
@@ -1788,7 +1793,6 @@ static int idedisk_release(struct inode 
 		if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
 			drive->doorlocking = 0;
 	}
-	ide_cacheflush_p(drive);
 	drive->usage--;
 	return 0;
 }
@@ -1874,14 +1878,68 @@ failed:
 	return 1;
 }
 
+
+static int ide_disk_notify_reboot (struct notifier_block *this, unsigned long event, void *x)
+{
+	ide_hwif_t *hwif;
+	ide_drive_t *drive;
+	int i, unit;
+	
+	switch (event) {
+		case SYS_HALT:
+		case SYS_POWER_OFF:
+			break;
+		default:
+			return NOTIFY_DONE;
+	}
+	printk(KERN_INFO "flushing ide devices: ");
+	for (i = 0; i < MAX_HWIFS; i++) {
+		hwif = &ide_hwifs[i];
+		if (!hwif->present)
+			continue;
+		for (unit = 0; unit < MAX_DRIVES; ++unit) {
+			drive = &hwif->drives[unit];
+			if (!drive->present)
+				continue;
+			if (drive->media != ide_disk)
+				continue;
+                                                                                                                       
+			/* set the drive to standby */
+			printk("%s ", drive->name);
+
+			ide_cacheflush_p(drive);
+		}
+	}
+	printk("\n");
+	mdelay(1000);
+        return NOTIFY_DONE;
+
+}
+
+static struct notifier_block ide_notifier = {
+        ide_disk_notify_reboot,
+        NULL,
+        5
+};
+
+
+
 static void __exit idedisk_exit (void)
 {
+	unregister_reboot_notifier(&ide_notifier);
 	ide_unregister_driver(&idedisk_driver);
 }
 
 static int idedisk_init (void)
-{
-	return ide_register_driver(&idedisk_driver);
+{	
+	int i;
+	i = ide_register_driver(&idedisk_driver);
+
+	if (i) 
+		return i;
+
+	register_reboot_notifier(&ide_notifier);
+	return 0;
 }
 
 module_init(idedisk_init);
