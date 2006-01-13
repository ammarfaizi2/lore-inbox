Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422893AbWAMTzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422893AbWAMTzv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422895AbWAMTvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:51:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:63892 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422893AbWAMTug convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:36 -0500
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] Add ide_bus_type probe and remove methods
In-Reply-To: <11371818112032@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:12 -0800
Message-Id: <11371818123046@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add ide_bus_type probe and remove methods

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 4031bbe4bbec6c0fe50412ef7fb43a270b0f29f1
tree 1e1449ba492ab04d8c5fbc75f9761be237bcae72
parent bbbe3a41f7ee529f7f4fdcc1bc1157234bac0766
author Russell King <rmk@arm.linux.org.uk> Fri, 06 Jan 2006 11:41:00 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:10 -0800

 drivers/ide/ide-cd.c     |   14 +++++---------
 drivers/ide/ide-disk.c   |   22 ++++++++--------------
 drivers/ide/ide-floppy.c |   14 +++++---------
 drivers/ide/ide-tape.c   |   18 +++++++-----------
 drivers/ide/ide.c        |   31 +++++++++++++++++++++++++++++++
 include/linux/ide.h      |    5 +++++
 6 files changed, 61 insertions(+), 43 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 9b2ebd2..ef09a7e 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -3256,9 +3256,8 @@ sector_t ide_cdrom_capacity (ide_drive_t
 }
 #endif
 
-static int ide_cd_remove(struct device *dev)
+static void ide_cd_remove(ide_drive_t *drive)
 {
-	ide_drive_t *drive = to_ide_device(dev);
 	struct cdrom_info *info = drive->driver_data;
 
 	ide_unregister_subdriver(drive, info->driver);
@@ -3266,8 +3265,6 @@ static int ide_cd_remove(struct device *
 	del_gendisk(info->disk);
 
 	ide_cd_put(info);
-
-	return 0;
 }
 
 static void ide_cd_release(struct kref *kref)
@@ -3291,7 +3288,7 @@ static void ide_cd_release(struct kref *
 	kfree(info);
 }
 
-static int ide_cd_probe(struct device *);
+static int ide_cd_probe(ide_drive_t *);
 
 #ifdef CONFIG_PROC_FS
 static int proc_idecd_read_capacity
@@ -3317,9 +3314,9 @@ static ide_driver_t ide_cdrom_driver = {
 		.owner		= THIS_MODULE,
 		.name		= "ide-cdrom",
 		.bus		= &ide_bus_type,
-		.probe		= ide_cd_probe,
-		.remove		= ide_cd_remove,
 	},
+	.probe			= ide_cd_probe,
+	.remove			= ide_cd_remove,
 	.version		= IDECD_VERSION,
 	.media			= ide_cdrom,
 	.supports_dsc_overlap	= 1,
@@ -3413,9 +3410,8 @@ static char *ignore = NULL;
 module_param(ignore, charp, 0400);
 MODULE_DESCRIPTION("ATAPI CD-ROM Driver");
 
-static int ide_cd_probe(struct device *dev)
+static int ide_cd_probe(ide_drive_t *drive)
 {
-	ide_drive_t *drive = to_ide_device(dev);
 	struct cdrom_info *info;
 	struct gendisk *g;
 	struct request_sense sense;
diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index cab362e..245b508 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -997,9 +997,8 @@ static void ide_cacheflush_p(ide_drive_t
 		printk(KERN_INFO "%s: wcache flush failed!\n", drive->name);
 }
 
-static int ide_disk_remove(struct device *dev)
+static void ide_disk_remove(ide_drive_t *drive)
 {
-	ide_drive_t *drive = to_ide_device(dev);
 	struct ide_disk_obj *idkp = drive->driver_data;
 	struct gendisk *g = idkp->disk;
 
@@ -1010,8 +1009,6 @@ static int ide_disk_remove(struct device
 	ide_cacheflush_p(drive);
 
 	ide_disk_put(idkp);
-
-	return 0;
 }
 
 static void ide_disk_release(struct kref *kref)
@@ -1027,12 +1024,10 @@ static void ide_disk_release(struct kref
 	kfree(idkp);
 }
 
-static int ide_disk_probe(struct device *dev);
+static int ide_disk_probe(ide_drive_t *drive);
 
-static void ide_device_shutdown(struct device *dev)
+static void ide_device_shutdown(ide_drive_t *drive)
 {
-	ide_drive_t *drive = container_of(dev, ide_drive_t, gendev);
-
 #ifdef	CONFIG_ALPHA
 	/* On Alpha, halt(8) doesn't actually turn the machine off,
 	   it puts you into the sort of firmware monitor. Typically,
@@ -1054,7 +1049,7 @@ static void ide_device_shutdown(struct d
 	}
 
 	printk("Shutdown: %s\n", drive->name);
-	dev->bus->suspend(dev, PMSG_SUSPEND);
+	drive->gendev.bus->suspend(&drive->gendev, PMSG_SUSPEND);
 }
 
 static ide_driver_t idedisk_driver = {
@@ -1062,10 +1057,10 @@ static ide_driver_t idedisk_driver = {
 		.owner		= THIS_MODULE,
 		.name		= "ide-disk",
 		.bus		= &ide_bus_type,
-		.probe		= ide_disk_probe,
-		.remove		= ide_disk_remove,
-		.shutdown	= ide_device_shutdown,
 	},
+	.probe			= ide_disk_probe,
+	.remove			= ide_disk_remove,
+	.shutdown		= ide_device_shutdown,
 	.version		= IDEDISK_VERSION,
 	.media			= ide_disk,
 	.supports_dsc_overlap	= 0,
@@ -1182,9 +1177,8 @@ static struct block_device_operations id
 
 MODULE_DESCRIPTION("ATA DISK Driver");
 
-static int ide_disk_probe(struct device *dev)
+static int ide_disk_probe(ide_drive_t *drive)
 {
-	ide_drive_t *drive = to_ide_device(dev);
 	struct ide_disk_obj *idkp;
 	struct gendisk *g;
 
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 5945f55..1f8db9a 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -1871,9 +1871,8 @@ static void idefloppy_setup (ide_drive_t
 	idefloppy_add_settings(drive);
 }
 
-static int ide_floppy_remove(struct device *dev)
+static void ide_floppy_remove(ide_drive_t *drive)
 {
-	ide_drive_t *drive = to_ide_device(dev);
 	idefloppy_floppy_t *floppy = drive->driver_data;
 	struct gendisk *g = floppy->disk;
 
@@ -1882,8 +1881,6 @@ static int ide_floppy_remove(struct devi
 	del_gendisk(g);
 
 	ide_floppy_put(floppy);
-
-	return 0;
 }
 
 static void ide_floppy_release(struct kref *kref)
@@ -1922,16 +1919,16 @@ static ide_proc_entry_t idefloppy_proc[]
 
 #endif	/* CONFIG_PROC_FS */
 
-static int ide_floppy_probe(struct device *);
+static int ide_floppy_probe(ide_drive_t *);
 
 static ide_driver_t idefloppy_driver = {
 	.gen_driver = {
 		.owner		= THIS_MODULE,
 		.name		= "ide-floppy",
 		.bus		= &ide_bus_type,
-		.probe		= ide_floppy_probe,
-		.remove		= ide_floppy_remove,
 	},
+	.probe			= ide_floppy_probe,
+	.remove			= ide_floppy_remove,
 	.version		= IDEFLOPPY_VERSION,
 	.media			= ide_floppy,
 	.supports_dsc_overlap	= 0,
@@ -2136,9 +2133,8 @@ static struct block_device_operations id
 	.revalidate_disk= idefloppy_revalidate_disk
 };
 
-static int ide_floppy_probe(struct device *dev)
+static int ide_floppy_probe(ide_drive_t *drive)
 {
-	ide_drive_t *drive = to_ide_device(dev);
 	idefloppy_floppy_t *floppy;
 	struct gendisk *g;
 
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index fab9b2b..0101d0d 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -4682,9 +4682,8 @@ static void idetape_setup (ide_drive_t *
 	idetape_add_settings(drive);
 }
 
-static int ide_tape_remove(struct device *dev)
+static void ide_tape_remove(ide_drive_t *drive)
 {
-	ide_drive_t *drive = to_ide_device(dev);
 	idetape_tape_t *tape = drive->driver_data;
 
 	ide_unregister_subdriver(drive, tape->driver);
@@ -4692,8 +4691,6 @@ static int ide_tape_remove(struct device
 	ide_unregister_region(tape->disk);
 
 	ide_tape_put(tape);
-
-	return 0;
 }
 
 static void ide_tape_release(struct kref *kref)
@@ -4745,16 +4742,16 @@ static ide_proc_entry_t idetape_proc[] =
 
 #endif
 
-static int ide_tape_probe(struct device *);
+static int ide_tape_probe(ide_drive_t *);
 
 static ide_driver_t idetape_driver = {
 	.gen_driver = {
 		.owner		= THIS_MODULE,
 		.name		= "ide-tape",
 		.bus		= &ide_bus_type,
-		.probe		= ide_tape_probe,
-		.remove		= ide_tape_remove,
 	},
+	.probe			= ide_tape_probe,
+	.remove			= ide_tape_remove,
 	.version		= IDETAPE_VERSION,
 	.media			= ide_tape,
 	.supports_dsc_overlap 	= 1,
@@ -4825,9 +4822,8 @@ static struct block_device_operations id
 	.ioctl		= idetape_ioctl,
 };
 
-static int ide_tape_probe(struct device *dev)
+static int ide_tape_probe(ide_drive_t *drive)
 {
-	ide_drive_t *drive = to_ide_device(dev);
 	idetape_tape_t *tape;
 	struct gendisk *g;
 	int minor;
@@ -4883,9 +4879,9 @@ static int ide_tape_probe(struct device 
 	idetape_setup(drive, tape, minor);
 
 	class_device_create(idetape_sysfs_class, NULL,
-			MKDEV(IDETAPE_MAJOR, minor), dev, "%s", tape->name);
+			MKDEV(IDETAPE_MAJOR, minor), &drive->gendev, "%s", tape->name);
 	class_device_create(idetape_sysfs_class, NULL,
-			MKDEV(IDETAPE_MAJOR, minor + 128), dev, "n%s", tape->name);
+			MKDEV(IDETAPE_MAJOR, minor + 128), &drive->gendev, "n%s", tape->name);
 
 	devfs_mk_cdev(MKDEV(HWIF(drive)->major, minor),
 			S_IFCHR | S_IRUGO | S_IWUGO,
diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
index ec5a4cb..afeb02b 100644
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -1949,10 +1949,41 @@ static int ide_uevent(struct device *dev
 	return 0;
 }
 
+static int generic_ide_probe(struct device *dev)
+{
+	ide_drive_t *drive = to_ide_device(dev);
+	ide_driver_t *drv = to_ide_driver(dev->driver);
+
+	return drv->probe ? drv->probe(drive) : -ENODEV;
+}
+
+static int generic_ide_remove(struct device *dev)
+{
+	ide_drive_t *drive = to_ide_device(dev);
+	ide_driver_t *drv = to_ide_driver(dev->driver);
+
+	if (drv->remove)
+		drv->remove(drive);
+
+	return 0;
+}
+
+static void generic_ide_shutdown(struct device *dev)
+{
+	ide_drive_t *drive = to_ide_device(dev);
+	ide_driver_t *drv = to_ide_driver(dev->driver);
+
+	if (dev->driver && drv->shutdown)
+		drv->shutdown(drive);
+}
+
 struct bus_type ide_bus_type = {
 	.name		= "ide",
 	.match		= ide_bus_match,
 	.uevent		= ide_uevent,
+	.probe		= generic_ide_probe,
+	.remove		= generic_ide_remove,
+	.shutdown	= generic_ide_shutdown,
 	.dev_attrs	= ide_dev_attrs,
 	.suspend	= generic_ide_suspend,
 	.resume		= generic_ide_resume,
diff --git a/include/linux/ide.h b/include/linux/ide.h
index f2e1b5b..110b3cf 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -983,8 +983,13 @@ typedef struct ide_driver_s {
 	ide_startstop_t	(*abort)(ide_drive_t *, struct request *rq);
 	ide_proc_entry_t	*proc;
 	struct device_driver	gen_driver;
+	int		(*probe)(ide_drive_t *);
+	void		(*remove)(ide_drive_t *);
+	void		(*shutdown)(ide_drive_t *);
 } ide_driver_t;
 
+#define to_ide_driver(drv) container_of(drv, ide_driver_t, gen_driver)
+
 int generic_ide_ioctl(ide_drive_t *, struct file *, struct block_device *, unsigned, unsigned long);
 
 /*

