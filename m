Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261897AbSJIShz>; Wed, 9 Oct 2002 14:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262442AbSJISgZ>; Wed, 9 Oct 2002 14:36:25 -0400
Received: from air-2.osdl.org ([65.172.181.6]:6576 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S262426AbSJISfh>;
	Wed, 9 Oct 2002 14:35:37 -0400
Date: Wed, 9 Oct 2002 11:43:48 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [bk/patch] IDE driver model update
In-Reply-To: <Pine.LNX.4.44.0210091131360.16276-100000@cherise.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0210091143410.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.729, 2002-10-09 11:18:47-07:00, mochel@osdl.org
  IDE: Add generic remove() method for drives; remove reboot notifier.
    
  The remove() method is generic for all drives, and set in ide_driver_t::gen_driver.
  The call simply forwards the call to ide_driver_t::standby(). 
  
  This obviates the need for IDE reboot notifier. The core iterates over all present
  devices in device_shutdown() and unregisters each one. 

diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	Wed Oct  9 11:41:37 2002
+++ b/drivers/ide/ide-disk.c	Wed Oct  9 11:41:37 2002
@@ -1792,7 +1792,6 @@
 {
 	struct gendisk *g = drive->disk;
 
-	device_unregister(&drive->gendev);
 	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
 		if (do_idedisk_flushcache(drive))
 			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	Wed Oct  9 11:41:37 2002
+++ b/drivers/ide/ide.c	Wed Oct  9 11:41:37 2002
@@ -2463,6 +2463,7 @@
 		if (driver->attach(drive) == 0) {
 			if (driver->owner)
 				__MOD_DEC_USE_COUNT(driver->owner);
+			drive->gendev.driver = &driver->gen_driver;
 			return 0;
 		}
 		spin_lock(&drivers_lock);
@@ -3422,6 +3423,16 @@
 
 EXPORT_SYMBOL(ide_unregister_subdriver);
 
+static int ide_drive_remove(struct device * dev)
+{
+	ide_drive_t * drive = container_of(dev,ide_drive_t,gendev);
+	ide_driver_t * driver = drive->driver;
+
+	if (driver && driver->standby)
+		driver->standby(drive);
+	return 0;
+}
+
 int ide_register_driver(ide_driver_t *driver)
 {
 	struct list_head list;
@@ -3442,6 +3453,7 @@
 	}
 	driver->gen_driver.name = driver->name;
 	driver->gen_driver.bus = &ide_bus_type;
+	driver->gen_driver.remove = ide_drive_remove;
 	return driver_register(&driver->gen_driver);
 }
 
@@ -3493,52 +3505,6 @@
 EXPORT_SYMBOL(ide_probe);
 EXPORT_SYMBOL(ide_devfs_handle);
 
-static int ide_notify_reboot (struct notifier_block *this, unsigned long event, void *x)
-{
-	ide_hwif_t *hwif;
-	ide_drive_t *drive;
-	int i, unit;
-
-	switch (event) {
-		case SYS_HALT:
-		case SYS_POWER_OFF:
-		case SYS_RESTART:
-			break;
-		default:
-			return NOTIFY_DONE;
-	}
-
-	printk(KERN_INFO "flushing ide devices: ");
-
-	for (i = 0; i < MAX_HWIFS; i++) {
-		hwif = &ide_hwifs[i];
-		if (!hwif->present)
-			continue;
-		for (unit = 0; unit < MAX_DRIVES; ++unit) {
-			drive = &hwif->drives[unit];
-			if (!drive->present)
-				continue;
-
-			/* set the drive to standby */
-			printk("%s ", drive->name);
-			if (event != SYS_RESTART)
-				if (drive->driver != NULL && DRIVER(drive)->standby(drive))
-				continue;
-
-			if (drive->driver != NULL && DRIVER(drive)->cleanup(drive))
-				continue;
-		}
-	}
-	printk("\n");
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block ide_notifier = {
-	ide_notify_reboot,
-	NULL,
-	5
-};
-
 struct bus_type ide_bus_type = {
 	.name		= "ide",
 };
@@ -3564,7 +3530,6 @@
 	ide_init_builtin_drivers();
 	initializing = 0;
 
-	register_reboot_notifier(&ide_notifier);
 	return 0;
 }
 
@@ -3599,7 +3564,6 @@
 {
 	int index;
 
-	unregister_reboot_notifier(&ide_notifier);
 	for (index = 0; index < MAX_HWIFS; ++index) {
 		ide_unregister(index);
 #if defined(CONFIG_BLK_DEV_IDEDMA) && !defined(CONFIG_DMA_NONPCI)

