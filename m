Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262609AbSJGT1c>; Mon, 7 Oct 2002 15:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262149AbSJGT0A>; Mon, 7 Oct 2002 15:26:00 -0400
Received: from air-2.osdl.org ([65.172.181.6]:6310 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S262589AbSJGTYR>;
	Mon, 7 Oct 2002 15:24:17 -0400
Date: Mon, 7 Oct 2002 12:31:41 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: torvalds@transmeta.com
cc: alan@lxorguk.ukuu.org.uk, <viro@math.psu.edu>, <andre@linux-ide.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] IDE driver model update
In-Reply-To: <Pine.LNX.4.44.0210071220020.16276-100000@cherise.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0210071231340.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.696.19.3, 2002-10-07 11:57:29-07:00, mochel@osdl.org
  IDE: Add generic remove() method for drives; remove reboot notifier.
  
  The remove() method is generic for all drives, and set in ide_driver_t::gen_driver.
  The call simply forwards the call to ide_driver_t::standby(). 
  
  ide_drive_release() is also added, and set when the device is registered with
  the driver model core. This cleans up the drive once the last reference has gone
  away by calling ide_driver_t::cleanup().
  
  These two additions obviate the need for IDE reboot notifier, since they exploit
  the constructs of the driver model core. It has been removed.

diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	Mon Oct  7 12:19:11 2002
+++ b/drivers/ide/ide-disk.c	Mon Oct  7 12:19:11 2002
@@ -1678,7 +1678,6 @@
 {
 	struct gendisk *g = drive->disk;
 
-	put_device(&drive->disk->disk_dev);
 	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
 		if (do_idedisk_flushcache(drive))
 			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	Mon Oct  7 12:19:11 2002
+++ b/drivers/ide/ide-probe.c	Mon Oct  7 12:19:11 2002
@@ -952,6 +952,15 @@
 
 EXPORT_SYMBOL(init_irq);
 
+static void ide_device_release(struct device * dev)
+{
+	ide_drive_t * drive = dev->driver_data;
+	ide_driver_t * driver = drive->driver;
+
+	if (driver && driver->cleanup)
+		driver->cleanup(drive);
+}
+
 /*
  * init_gendisk() (as opposed to ide_geninit) is called for each major device,
  * after probing for drives, to allocate partition tables and other data
@@ -986,6 +995,8 @@
 			 "%s","IDE Drive");
 		disk->disk_dev.parent = &hwif->gendev;
 		disk->disk_dev.bus = &ide_bus_type;
+		disk->disk_dev.driver_data = &hwif->drives[unit];
+		disk->disk_dev.release = ide_device_release;
 		if (hwif->drives[unit].present)
 			device_register(&disk->disk_dev);
 		hwif->drives[unit].disk = disk;
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	Mon Oct  7 12:19:11 2002
+++ b/drivers/ide/ide.c	Mon Oct  7 12:19:11 2002
@@ -2437,6 +2437,7 @@
 		if (driver->attach(drive) == 0) {
 			if (driver->owner)
 				__MOD_DEC_USE_COUNT(driver->owner);
+			drive->disk->disk_dev.driver = &driver->gen_driver;
 			return 0;
 		}
 		spin_lock(&drivers_lock);
@@ -3396,6 +3397,16 @@
 
 EXPORT_SYMBOL(ide_unregister_subdriver);
 
+static int ide_drive_remove(struct device * dev)
+{
+	ide_drive_t * drive = dev->driver_data;
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
@@ -3416,6 +3427,7 @@
 	}
 	driver->gen_driver.name = driver->name;
 	driver->gen_driver.bus = &ide_bus_type;
+	driver->gen_driver.remove = ide_drive_remove;
 	return driver_register(&driver->gen_driver);
 }
 
@@ -3467,52 +3479,6 @@
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
@@ -3538,7 +3504,6 @@
 	ide_init_builtin_drivers();
 	initializing = 0;
 
-	register_reboot_notifier(&ide_notifier);
 	return 0;
 }
 
@@ -3573,7 +3538,6 @@
 {
 	int index;
 
-	unregister_reboot_notifier(&ide_notifier);
 	for (index = 0; index < MAX_HWIFS; ++index) {
 		ide_unregister(index);
 #if defined(CONFIG_BLK_DEV_IDEDMA) && !defined(CONFIG_DMA_NONPCI)

