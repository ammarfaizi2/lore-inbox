Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263726AbVBDDSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263726AbVBDDSn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 22:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbVBDDSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 22:18:32 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:49076 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S262464AbVBDC53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 21:57:29 -0500
Date: Fri, 4 Feb 2005 03:55:20 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 9/9] convert device drivers to driver-model 
Message-ID: <Pine.GSO.4.58.0502040353340.4393@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* add ide_bus_match() and export ide_bus_type
* split ide_remove_driver_from_hwgroup() out of ide_unregister()
* move device cleanup from ide_unregister() to drive_release_dev()
* convert ide_driver_t->name to driver->name
* convert ide_driver_t->{attach,cleanup} to driver->{probe,remove}
* remove ide_driver_t->busy as ide_bus_type->subsys.rwsem
  protects against concurrent ->{probe,remove} calls
* make ide_{un}register_driver() void as it cannot fail now
* use driver_{un}register() directly, remove ide_{un}register_driver()
* use device_register() instead of ata_attach(), remove ata_attach()
* add proc_print_driver() and ide_drivers_show(), remove ide_drivers_op
* fix ide_replace_subdriver() and move it to ide-proc.c
* remove ide_driver_t->drives, ide_drives and drives_lock
* remove ide_driver_t->drivers, drivers and drivers_lock
* remove ide_drive_t->driver and DRIVER() macro

diff -Nru a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
--- a/drivers/ide/ide-cd.c	2005-02-04 03:32:30 +01:00
+++ b/drivers/ide/ide-cd.c	2005-02-04 03:32:30 +01:00
@@ -3255,16 +3255,12 @@
 	return capacity * sectors_per_frame;
 }

-static
-int ide_cdrom_cleanup(ide_drive_t *drive)
+static int ide_cd_remove(struct device *dev)
 {
+	ide_drive_t *drive = to_ide_device(dev);
 	struct cdrom_info *info = drive->driver_data;

-	if (ide_unregister_subdriver(drive)) {
-		printk(KERN_ERR "%s: %s: failed to ide_unregister_subdriver\n",
-			__FUNCTION__, drive->name);
-		return 1;
-	}
+	ide_unregister_subdriver(drive, info->driver);

 	del_gendisk(info->disk);

@@ -3297,7 +3293,7 @@
 	kfree(info);
 }

-static int ide_cdrom_attach (ide_drive_t *drive);
+static int ide_cd_probe(struct device *);

 #ifdef CONFIG_PROC_FS
 static int proc_idecd_read_capacity
@@ -3320,19 +3316,20 @@

 static ide_driver_t ide_cdrom_driver = {
 	.owner			= THIS_MODULE,
-	.name			= "ide-cdrom",
+	.gen_driver = {
+		.name		= "ide-cdrom",
+		.bus		= &ide_bus_type,
+		.probe		= ide_cd_probe,
+		.remove		= ide_cd_remove,
+	},
 	.version		= IDECD_VERSION,
 	.media			= ide_cdrom,
-	.busy			= 0,
 	.supports_dsc_overlap	= 1,
-	.cleanup		= ide_cdrom_cleanup,
 	.do_request		= ide_do_rw_cdrom,
 	.end_request		= ide_end_request,
 	.error			= __ide_error,
 	.abort			= __ide_abort,
 	.proc			= idecd_proc,
-	.attach			= ide_cdrom_attach,
-	.drives			= LIST_HEAD_INIT(ide_cdrom_driver.drives),
 };

 static int idecd_open(struct inode * inode, struct file * file)
@@ -3418,8 +3415,9 @@
 module_param(ignore, charp, 0400);
 MODULE_DESCRIPTION("ATAPI CD-ROM Driver");

-static int ide_cdrom_attach (ide_drive_t *drive)
+static int ide_cd_probe(struct device *dev)
 {
+	ide_drive_t *drive = to_ide_device(dev);
 	struct cdrom_info *info;
 	struct gendisk *g;
 	struct request_sense sense;
@@ -3453,11 +3451,8 @@

 	ide_init_disk(g, drive);

-	if (ide_register_subdriver(drive, &ide_cdrom_driver)) {
-		printk(KERN_ERR "%s: Failed to register the driver with ide.c\n",
-			drive->name);
-		goto out_put_disk;
-	}
+	ide_register_subdriver(drive, &ide_cdrom_driver);
+
 	memset(info, 0, sizeof (struct cdrom_info));

 	kref_init(&info->kref);
@@ -3470,7 +3465,6 @@

 	drive->driver_data = info;

-	DRIVER(drive)->busy++;
 	g->minors = 1;
 	snprintf(g->devfs_name, sizeof(g->devfs_name),
 			"%s/cd", drive->devfs_name);
@@ -3478,8 +3472,7 @@
 	g->flags = GENHD_FL_CD | GENHD_FL_REMOVABLE;
 	if (ide_cdrom_setup(drive)) {
 		struct cdrom_device_info *devinfo = &info->devinfo;
-		DRIVER(drive)->busy--;
-		ide_unregister_subdriver(drive);
+		ide_unregister_subdriver(drive, &ide_cdrom_driver);
 		if (info->buffer != NULL)
 			kfree(info->buffer);
 		if (info->toc != NULL)
@@ -3492,7 +3485,6 @@
 		drive->driver_data = NULL;
 		goto failed;
 	}
-	DRIVER(drive)->busy--;

 	cdrom_read_toc(drive, &sense);
 	g->fops = &idecd_ops;
@@ -3500,8 +3492,6 @@
 	add_disk(g);
 	return 0;

-out_put_disk:
-	put_disk(g);
 out_free_cd:
 	kfree(info);
 failed:
@@ -3510,13 +3500,12 @@

 static void __exit ide_cdrom_exit(void)
 {
-	ide_unregister_driver(&ide_cdrom_driver);
+	driver_unregister(&ide_cdrom_driver.gen_driver);
 }

 static int ide_cdrom_init(void)
 {
-	ide_register_driver(&ide_cdrom_driver);
-	return 0;
+	return driver_register(&ide_cdrom_driver.gen_driver);
 }

 module_init(ide_cdrom_init);
diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	2005-02-04 03:32:30 +01:00
+++ b/drivers/ide/ide-disk.c	2005-02-04 03:32:30 +01:00
@@ -973,14 +973,16 @@
 		printk(KERN_INFO "%s: wcache flush failed!\n", drive->name);
 }

-static int idedisk_cleanup (ide_drive_t *drive)
+static int ide_disk_remove(struct device *dev)
 {
+	ide_drive_t *drive = to_ide_device(dev);
 	struct ide_disk_obj *idkp = drive->driver_data;
 	struct gendisk *g = idkp->disk;

 	ide_cacheflush_p(drive);
-	if (ide_unregister_subdriver(drive))
-		return 1;
+
+	ide_unregister_subdriver(drive, idkp->driver);
+
 	del_gendisk(g);

 	ide_disk_put(idkp);
@@ -1001,7 +1003,7 @@
 	kfree(idkp);
 }

-static int idedisk_attach(ide_drive_t *drive);
+static int ide_disk_probe(struct device *dev);

 static void ide_device_shutdown(struct device *dev)
 {
@@ -1031,27 +1033,23 @@
 	dev->bus->suspend(dev, PM_SUSPEND_STANDBY);
 }

-/*
- *      IDE subdriver functions, registered with ide.c
- */
 static ide_driver_t idedisk_driver = {
 	.owner			= THIS_MODULE,
 	.gen_driver = {
+		.name		= "ide-disk",
+		.bus		= &ide_bus_type,
+		.probe		= ide_disk_probe,
+		.remove		= ide_disk_remove,
 		.shutdown	= ide_device_shutdown,
 	},
-	.name			= "ide-disk",
 	.version		= IDEDISK_VERSION,
 	.media			= ide_disk,
-	.busy			= 0,
 	.supports_dsc_overlap	= 0,
-	.cleanup		= idedisk_cleanup,
 	.do_request		= ide_do_rw_disk,
 	.end_request		= ide_end_request,
 	.error			= __ide_error,
 	.abort			= __ide_abort,
 	.proc			= idedisk_proc,
-	.attach			= idedisk_attach,
-	.drives			= LIST_HEAD_INIT(idedisk_driver.drives),
 };

 static int idedisk_open(struct inode *inode, struct file *filp)
@@ -1148,8 +1146,9 @@

 MODULE_DESCRIPTION("ATA DISK Driver");

-static int idedisk_attach(ide_drive_t *drive)
+static int ide_disk_probe(struct device *dev)
 {
+	ide_drive_t *drive = to_ide_device(dev);
 	struct ide_disk_obj *idkp;
 	struct gendisk *g;

@@ -1171,10 +1170,7 @@

 	ide_init_disk(g, drive);

-	if (ide_register_subdriver(drive, &idedisk_driver)) {
-		printk (KERN_ERR "ide-disk: %s: Failed to register the driver with ide.c\n", drive->name);
-		goto out_put_disk;
-	}
+	ide_register_subdriver(drive, &idedisk_driver);

 	memset(idkp, 0, sizeof(*idkp));

@@ -1188,7 +1184,6 @@

 	drive->driver_data = idkp;

-	DRIVER(drive)->busy++;
 	idedisk_setup(drive);
 	if ((!drive->head || drive->head > 16) && !drive->select.b.lba) {
 		printk(KERN_ERR "%s: INVALID GEOMETRY: %d PHYSICAL HEADS?\n",
@@ -1196,7 +1191,7 @@
 		drive->attach = 0;
 	} else
 		drive->attach = 1;
-	DRIVER(drive)->busy--;
+
 	g->minors = 1 << PARTN_BITS;
 	strcpy(g->devfs_name, drive->devfs_name);
 	g->driverfs_dev = &drive->gendev;
@@ -1206,8 +1201,6 @@
 	add_disk(g);
 	return 0;

-out_put_disk:
-	put_disk(g);
 out_free_idkp:
 	kfree(idkp);
 failed:
@@ -1216,12 +1209,12 @@

 static void __exit idedisk_exit (void)
 {
-	ide_unregister_driver(&idedisk_driver);
+	driver_unregister(&idedisk_driver.gen_driver);
 }

 static int idedisk_init (void)
 {
-	return ide_register_driver(&idedisk_driver);
+	return driver_register(&idedisk_driver.gen_driver);
 }

 module_init(idedisk_init);
diff -Nru a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
--- a/drivers/ide/ide-floppy.c	2005-02-04 03:32:30 +01:00
+++ b/drivers/ide/ide-floppy.c	2005-02-04 03:32:30 +01:00
@@ -1865,13 +1865,13 @@
 	idefloppy_add_settings(drive);
 }

-static int idefloppy_cleanup (ide_drive_t *drive)
+static int ide_floppy_remove(struct device *dev)
 {
+	ide_drive_t *drive = to_ide_device(dev);
 	idefloppy_floppy_t *floppy = drive->driver_data;
 	struct gendisk *g = floppy->disk;

-	if (ide_unregister_subdriver(drive))
-		return 1;
+	ide_unregister_subdriver(drive, floppy->driver);

 	del_gendisk(g);

@@ -1916,26 +1916,24 @@

 #endif	/* CONFIG_PROC_FS */

-static int idefloppy_attach(ide_drive_t *drive);
+static int ide_floppy_probe(struct device *);

-/*
- *	IDE subdriver functions, registered with ide.c
- */
 static ide_driver_t idefloppy_driver = {
 	.owner			= THIS_MODULE,
-	.name			= "ide-floppy",
+	.gen_driver = {
+		.name		= "ide-floppy",
+		.bus		= &ide_bus_type,
+		.probe		= ide_floppy_probe,
+		.remove		= ide_floppy_remove,
+	},
 	.version		= IDEFLOPPY_VERSION,
 	.media			= ide_floppy,
-	.busy			= 0,
 	.supports_dsc_overlap	= 0,
-	.cleanup		= idefloppy_cleanup,
 	.do_request		= idefloppy_do_request,
 	.end_request		= idefloppy_do_end_request,
 	.error			= __ide_error,
 	.abort			= __ide_abort,
 	.proc			= idefloppy_proc,
-	.attach			= idefloppy_attach,
-	.drives			= LIST_HEAD_INIT(idefloppy_driver.drives),
 };

 static int idefloppy_open(struct inode *inode, struct file *filp)
@@ -2122,8 +2120,9 @@
 	.revalidate_disk= idefloppy_revalidate_disk
 };

-static int idefloppy_attach (ide_drive_t *drive)
+static int ide_floppy_probe(struct device *dev)
 {
+	ide_drive_t *drive = to_ide_device(dev);
 	idefloppy_floppy_t *floppy;
 	struct gendisk *g;

@@ -2152,10 +2151,7 @@

 	ide_init_disk(g, drive);

-	if (ide_register_subdriver(drive, &idefloppy_driver)) {
-		printk (KERN_ERR "ide-floppy: %s: Failed to register the driver with ide.c\n", drive->name);
-		goto out_put_disk;
-	}
+	ide_register_subdriver(drive, &idefloppy_driver);

 	memset(floppy, 0, sizeof(*floppy));

@@ -2169,9 +2165,8 @@

 	drive->driver_data = floppy;

-	DRIVER(drive)->busy++;
 	idefloppy_setup (drive, floppy);
-	DRIVER(drive)->busy--;
+
 	g->minors = 1 << PARTN_BITS;
 	g->driverfs_dev = &drive->gendev;
 	strcpy(g->devfs_name, drive->devfs_name);
@@ -2181,8 +2176,6 @@
 	add_disk(g);
 	return 0;

-out_put_disk:
-	put_disk(g);
 out_free_floppy:
 	kfree(floppy);
 failed:
@@ -2193,7 +2186,7 @@

 static void __exit idefloppy_exit (void)
 {
-	ide_unregister_driver(&idefloppy_driver);
+	driver_unregister(&idefloppy_driver.gen_driver);
 }

 /*
@@ -2202,8 +2195,7 @@
 static int idefloppy_init (void)
 {
 	printk("ide-floppy driver " IDEFLOPPY_VERSION "\n");
-	ide_register_driver(&idefloppy_driver);
-	return 0;
+	return driver_register(&idefloppy_driver.gen_driver);
 }

 module_init(idefloppy_init);
diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	2005-02-04 03:32:30 +01:00
+++ b/drivers/ide/ide-probe.c	2005-02-04 03:32:30 +01:00
@@ -47,6 +47,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/ide.h>
+#include <linux/devfs_fs_kernel.h>
 #include <linux/spinlock.h>
 #include <linux/kmod.h>
 #include <linux/pci.h>
@@ -918,7 +919,7 @@
 			   want them on default or a new "empty" class
 			   for hotplug reprobing ? */
 			if (drive->present) {
-				ata_attach(drive);
+				device_register(&drive->gendev);
 			}
 		}
 	}
@@ -1279,10 +1280,51 @@

 EXPORT_SYMBOL_GPL(ide_init_disk);

+static void ide_remove_drive_from_hwgroup(ide_drive_t *drive)
+{
+	ide_hwgroup_t *hwgroup = drive->hwif->hwgroup;
+
+	if (drive == drive->next) {
+		/* special case: last drive from hwgroup. */
+		BUG_ON(hwgroup->drive != drive);
+		hwgroup->drive = NULL;
+	} else {
+		ide_drive_t *walk;
+
+		walk = hwgroup->drive;
+		while (walk->next != drive)
+			walk = walk->next;
+		walk->next = drive->next;
+		if (hwgroup->drive == drive) {
+			hwgroup->drive = drive->next;
+			hwgroup->hwif = hwgroup->drive->hwif;
+		}
+	}
+	BUG_ON(hwgroup->drive == drive);
+}
+
 static void drive_release_dev (struct device *dev)
 {
 	ide_drive_t *drive = container_of(dev, ide_drive_t, gendev);

+	spin_lock_irq(&ide_lock);
+	if (drive->devfs_name[0] != '\0') {
+		devfs_remove(drive->devfs_name);
+		drive->devfs_name[0] = '\0';
+	}
+	ide_remove_drive_from_hwgroup(drive);
+	if (drive->id != NULL) {
+		kfree(drive->id);
+		drive->id = NULL;
+	}
+	drive->present = 0;
+	/* Messed up locking ... */
+	spin_unlock_irq(&ide_lock);
+	blk_cleanup_queue(drive->queue);
+	spin_lock_irq(&ide_lock);
+	drive->queue = NULL;
+	spin_unlock_irq(&ide_lock);
+
 	up(&drive->gendev_rel_sem);
 }

@@ -1306,7 +1348,6 @@
 		drive->gendev.driver_data = drive;
 		drive->gendev.release = drive_release_dev;
 		if (drive->present) {
-			device_register(&drive->gendev);
 			sprintf(drive->devfs_name, "ide/host%d/bus%d/target%d/lun%d",
 				(hwif->channel && hwif->mate) ?
 				hwif->mate->index : hwif->index,
@@ -1411,7 +1452,7 @@
 				hwif->chipset = ide_generic;
 			for (unit = 0; unit < MAX_DRIVES; ++unit)
 				if (hwif->drives[unit].present)
-					ata_attach(&hwif->drives[unit]);
+					device_register(&hwif->drives[unit].gendev);
 		}
 	}
 	return 0;
diff -Nru a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
--- a/drivers/ide/ide-proc.c	2005-02-04 03:32:30 +01:00
+++ b/drivers/ide/ide-proc.c	2005-02-04 03:32:30 +01:00
@@ -307,17 +307,41 @@
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
 	ide_drive_t	*drive = (ide_drive_t *) data;
-	ide_driver_t	*driver = drive->driver;
+	struct device	*dev = &drive->gendev;
+	ide_driver_t	*ide_drv;
 	int		len;

-	if (driver) {
+	down_read(&dev->bus->subsys.rwsem);
+	if (dev->driver) {
+		ide_drv = container_of(dev->driver, ide_driver_t, gen_driver);
 		len = sprintf(page, "%s version %s\n",
-				driver->name, driver->version);
+				dev->driver->name, ide_drv->version);
 	} else
 		len = sprintf(page, "ide-default version 0.9.newide\n");
+	up_read(&dev->bus->subsys.rwsem);
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }

+static int ide_replace_subdriver(ide_drive_t *drive, const char *driver)
+{
+	struct device *dev = &drive->gendev;
+	int ret = 1;
+
+	down_write(&dev->bus->subsys.rwsem);
+	device_release_driver(dev);
+	/* FIXME: device can still be in use by previous driver */
+	strlcpy(drive->driver_req, driver, sizeof(drive->driver_req));
+	device_attach(dev);
+	drive->driver_req[0] = 0;
+	if (dev->driver == NULL)
+		device_attach(dev);
+	if (dev->driver && !strcmp(dev->driver->name, driver))
+		ret = 0;
+	up_write(&dev->bus->subsys.rwsem);
+
+	return ret;
+}
+
 static int proc_ide_write_driver
 	(struct file *file, const char __user *buffer, unsigned long count, void *data)
 {
@@ -488,16 +512,32 @@
 	}
 }

-extern struct seq_operations ide_drivers_op;
+static int proc_print_driver(struct device_driver *drv, void *data)
+{
+	ide_driver_t *ide_drv = container_of(drv, ide_driver_t, gen_driver);
+	struct seq_file *s = data;
+
+	seq_printf(s, "%s version %s\n", drv->name, ide_drv->version);
+
+	return 0;
+}
+
+static int ide_drivers_show(struct seq_file *s, void *p)
+{
+	bus_for_each_drv(&ide_bus_type, NULL, s, proc_print_driver);
+	return 0;
+}
+
 static int ide_drivers_open(struct inode *inode, struct file *file)
 {
-	return seq_open(file, &ide_drivers_op);
+	return single_open(file, &ide_drivers_show, NULL);
 }
+
 static struct file_operations ide_drivers_operations = {
 	.open		= ide_drivers_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= seq_release,
+	.release	= single_release,
 };

 void proc_ide_create(void)
diff -Nru a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
--- a/drivers/ide/ide-tape.c	2005-02-04 03:32:30 +01:00
+++ b/drivers/ide/ide-tape.c	2005-02-04 03:32:30 +01:00
@@ -4674,21 +4674,12 @@
 	idetape_add_settings(drive);
 }

-static int idetape_cleanup (ide_drive_t *drive)
+static int ide_tape_remove(struct device *dev)
 {
+	ide_drive_t *drive = to_ide_device(dev);
 	idetape_tape_t *tape = drive->driver_data;
-	unsigned long flags;

-	spin_lock_irqsave(&ide_lock, flags);
-	if (test_bit(IDETAPE_BUSY, &tape->flags) || drive->usage ||
-	    tape->first_stage != NULL || tape->merge_stage_size) {
-		spin_unlock_irqrestore(&ide_lock, flags);
-		return 1;
-	}
-
-	spin_unlock_irqrestore(&ide_lock, flags);
-	DRIVER(drive)->busy = 0;
-	(void) ide_unregister_subdriver(drive);
+	ide_unregister_subdriver(drive, tape->driver);

 	ide_unregister_region(tape->disk);

@@ -4703,6 +4694,8 @@
 	ide_drive_t *drive = tape->drive;
 	struct gendisk *g = tape->disk;

+	BUG_ON(tape->first_stage != NULL || tape->merge_stage_size);
+
 	drive->dsc_overlap = 0;
 	drive->driver_data = NULL;
 	devfs_remove("%s/mt", drive->devfs_name);
@@ -4740,26 +4733,24 @@

 #endif

-static int idetape_attach(ide_drive_t *drive);
+static int ide_tape_probe(struct device *);

-/*
- *	IDE subdriver functions, registered with ide.c
- */
 static ide_driver_t idetape_driver = {
 	.owner			= THIS_MODULE,
-	.name			= "ide-tape",
+	.gen_driver = {
+		.name		= "ide-tape",
+		.bus		= &ide_bus_type,
+		.probe		= ide_tape_probe,
+		.remove		= ide_tape_remove,
+	},
 	.version		= IDETAPE_VERSION,
 	.media			= ide_tape,
-	.busy			= 1,
 	.supports_dsc_overlap 	= 1,
-	.cleanup		= idetape_cleanup,
 	.do_request		= idetape_do_request,
 	.end_request		= idetape_end_request,
 	.error			= __ide_error,
 	.abort			= __ide_abort,
 	.proc			= idetape_proc,
-	.attach			= idetape_attach,
-	.drives			= LIST_HEAD_INIT(idetape_driver.drives),
 };

 /*
@@ -4822,8 +4813,9 @@
 	.ioctl		= idetape_ioctl,
 };

-static int idetape_attach (ide_drive_t *drive)
+static int ide_tape_probe(struct device *dev)
 {
+	ide_drive_t *drive = to_ide_device(dev);
 	idetape_tape_t *tape;
 	struct gendisk *g;
 	int minor;
@@ -4858,10 +4850,7 @@

 	ide_init_disk(g, drive);

-	if (ide_register_subdriver(drive, &idetape_driver)) {
-		printk(KERN_ERR "ide-tape: %s: Failed to register the driver with ide.c\n", drive->name);
-		goto out_put_disk;
-	}
+	ide_register_subdriver(drive, &idetape_driver);

 	memset(tape, 0, sizeof(*tape));

@@ -4895,8 +4884,7 @@
 	ide_register_region(g);

 	return 0;
-out_put_disk:
-	put_disk(g);
+
 out_free_tape:
 	kfree(tape);
 failed:
@@ -4908,7 +4896,7 @@

 static void __exit idetape_exit (void)
 {
-	ide_unregister_driver(&idetape_driver);
+	driver_unregister(&idetape_driver.gen_driver);
 	unregister_chrdev(IDETAPE_MAJOR, "ht");
 }

@@ -4921,8 +4909,7 @@
 		printk(KERN_ERR "ide-tape: Failed to register character device interface\n");
 		return -EBUSY;
 	}
-	ide_register_driver(&idetape_driver);
-	return 0;
+	return driver_register(&idetape_driver.gen_driver);
 }

 module_init(idetape_init);
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2005-02-04 03:32:30 +01:00
+++ b/drivers/ide/ide.c	2005-02-04 03:32:30 +01:00
@@ -196,8 +196,6 @@

 EXPORT_SYMBOL(ide_hwifs);

-static struct list_head ide_drives = LIST_HEAD_INIT(ide_drives);
-
 /*
  * Do not even *think* about calling this!
  */
@@ -354,54 +352,6 @@
 	return system_bus_speed;
 }

-/*
- *	drives_lock protects the list of drives, drivers_lock the
- *	list of drivers.  Currently nobody takes both at once.
- */
-
-static DEFINE_SPINLOCK(drives_lock);
-static DEFINE_SPINLOCK(drivers_lock);
-static LIST_HEAD(drivers);
-
-/* Iterator for the driver list. */
-
-static void *m_start(struct seq_file *m, loff_t *pos)
-{
-	struct list_head *p;
-	loff_t l = *pos;
-	spin_lock(&drivers_lock);
-	list_for_each(p, &drivers)
-		if (!l--)
-			return list_entry(p, ide_driver_t, drivers);
-	return NULL;
-}
-
-static void *m_next(struct seq_file *m, void *v, loff_t *pos)
-{
-	struct list_head *p = ((ide_driver_t *)v)->drivers.next;
-	(*pos)++;
-	return p==&drivers ? NULL : list_entry(p, ide_driver_t, drivers);
-}
-
-static void m_stop(struct seq_file *m, void *v)
-{
-	spin_unlock(&drivers_lock);
-}
-
-static int show_driver(struct seq_file *m, void *v)
-{
-	ide_driver_t *driver = v;
-	seq_printf(m, "%s version %s\n", driver->name, driver->version);
-	return 0;
-}
-
-struct seq_operations ide_drivers_op = {
-	.start	= m_start,
-	.next	= m_next,
-	.stop	= m_stop,
-	.show	= show_driver
-};
-
 #ifdef CONFIG_PROC_FS
 struct proc_dir_entry *proc_ide_root;
 #endif
@@ -626,7 +576,7 @@
 	ide_hwif_t *hwif, *g;
 	static ide_hwif_t tmp_hwif; /* protected by ide_cfg_sem */
 	ide_hwgroup_t *hwgroup;
-	int irq_count = 0, unit, i;
+	int irq_count = 0, unit;

 	BUG_ON(index >= MAX_HWIFS);

@@ -639,23 +589,22 @@
 		goto abort;
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		drive = &hwif->drives[unit];
-		if (!drive->present)
+		if (!drive->present) {
+			if (drive->devfs_name[0] != '\0') {
+				devfs_remove(drive->devfs_name);
+				drive->devfs_name[0] = '\0';
+			}
 			continue;
-		if (drive->usage || DRIVER(drive)->busy)
-			goto abort;
-		drive->dead = 1;
+		}
+		spin_unlock_irq(&ide_lock);
+		device_unregister(&drive->gendev);
+		down(&drive->gendev_rel_sem);
+		spin_lock_irq(&ide_lock);
 	}
 	hwif->present = 0;

 	spin_unlock_irq(&ide_lock);

-	for (unit = 0; unit < MAX_DRIVES; ++unit) {
-		drive = &hwif->drives[unit];
-		if (!drive->present)
-			continue;
-		DRIVER(drive)->cleanup(drive);
-	}
-
 	destroy_proc_ide_interface(hwif);

 	hwgroup = hwif->hwgroup;
@@ -683,44 +632,6 @@
 	 * Remove us from the hwgroup, and free
 	 * the hwgroup if we were the only member
 	 */
-	for (i = 0; i < MAX_DRIVES; ++i) {
-		drive = &hwif->drives[i];
-		if (drive->devfs_name[0] != '\0') {
-			devfs_remove(drive->devfs_name);
-			drive->devfs_name[0] = '\0';
-		}
-		if (!drive->present)
-			continue;
-		if (drive == drive->next) {
-			/* special case: last drive from hwgroup. */
-			BUG_ON(hwgroup->drive != drive);
-			hwgroup->drive = NULL;
-		} else {
-			ide_drive_t *walk;
-
-			walk = hwgroup->drive;
-			while (walk->next != drive)
-				walk = walk->next;
-			walk->next = drive->next;
-			if (hwgroup->drive == drive) {
-				hwgroup->drive = drive->next;
-				hwgroup->hwif = HWIF(hwgroup->drive);
-			}
-		}
-		BUG_ON(hwgroup->drive == drive);
-		if (drive->id != NULL) {
-			kfree(drive->id);
-			drive->id = NULL;
-		}
-		drive->present = 0;
-		/* Messed up locking ... */
-		spin_unlock_irq(&ide_lock);
-		blk_cleanup_queue(drive->queue);
-		device_unregister(&drive->gendev);
-		down(&drive->gendev_rel_sem);
-		spin_lock_irq(&ide_lock);
-		drive->queue = NULL;
-	}
 	if (hwif->next == hwif) {
 		BUG_ON(hwgroup->hwif != hwif);
 		kfree(hwgroup);
@@ -1300,73 +1211,6 @@

 EXPORT_SYMBOL(system_bus_clock);

-/*
- *	Locking is badly broken here - since way back.  That sucker is
- * root-only, but that's not an excuse...  The real question is what
- * exclusion rules do we want here.
- */
-int ide_replace_subdriver (ide_drive_t *drive, const char *driver)
-{
-	if (!drive->present || drive->usage || drive->dead)
-		goto abort;
-	if (DRIVER(drive)->cleanup(drive))
-		goto abort;
-	strlcpy(drive->driver_req, driver, sizeof(drive->driver_req));
-	if (ata_attach(drive)) {
-		spin_lock(&drives_lock);
-		list_del_init(&drive->list);
-		spin_unlock(&drives_lock);
-		drive->driver_req[0] = 0;
-		ata_attach(drive);
-	} else {
-		drive->driver_req[0] = 0;
-	}
-	if (drive->driver && !strcmp(drive->driver->name, driver))
-		return 0;
-abort:
-	return 1;
-}
-
-/**
- *	ata_attach		-	attach an ATA/ATAPI device
- *	@drive: drive to attach
- *
- *	Takes a drive that is as yet not assigned to any midlayer IDE
- *	driver (or is assigned to the default driver) and figures out
- *	which driver would like to own it. If nobody claims the drive
- *	then it is automatically attached to the default driver used for
- *	unclaimed objects.
- *
- *	A return of zero indicates attachment to a driver, of one
- *	attachment to the default driver.
- *
- *	Takes drivers_lock.
- */
-
-int ata_attach(ide_drive_t *drive)
-{
-	struct list_head *p;
-	spin_lock(&drivers_lock);
-	list_for_each(p, &drivers) {
-		ide_driver_t *driver = list_entry(p, ide_driver_t, drivers);
-		if (!try_module_get(driver->owner))
-			continue;
-		spin_unlock(&drivers_lock);
-		if (driver->attach(drive) == 0) {
-			module_put(driver->owner);
-			drive->gendev.driver = &driver->gen_driver;
-			return 0;
-		}
-		spin_lock(&drivers_lock);
-		module_put(driver->owner);
-	}
-	drive->gendev.driver = NULL;
-	spin_unlock(&drivers_lock);
-	if (ide_register_subdriver(drive, NULL))
-		panic("ide: default attach failed");
-	return 1;
-}
-
 static int generic_ide_suspend(struct device *dev, pm_message_t state)
 {
 	ide_drive_t *drive = dev->driver_data;
@@ -2008,27 +1852,11 @@
 #endif
 }

-int ide_register_subdriver(ide_drive_t *drive, ide_driver_t *driver)
+void ide_register_subdriver(ide_drive_t *drive, ide_driver_t *driver)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&ide_lock, flags);
-	if (!drive->present || drive->driver != NULL ||
-	    drive->usage || drive->dead) {
-		spin_unlock_irqrestore(&ide_lock, flags);
-		return 1;
-	}
-	drive->driver = driver;
-	spin_unlock_irqrestore(&ide_lock, flags);
-	spin_lock(&drives_lock);
-	list_add_tail(&drive->list, driver ? &driver->drives : &ide_drives);
-	spin_unlock(&drives_lock);
-//	printk(KERN_INFO "%s: attached %s driver.\n", drive->name, driver->name);
 #ifdef CONFIG_PROC_FS
-	if (driver)
-		ide_add_proc_entries(drive->proc, driver->proc, drive);
+	ide_add_proc_entries(drive->proc, driver->proc, drive);
 #endif
-	return 0;
 }

 EXPORT_SYMBOL(ide_register_subdriver);
@@ -2036,135 +1864,50 @@
 /**
  *	ide_unregister_subdriver	-	disconnect drive from driver
  *	@drive: drive to unplug
+ *	@driver: driver
  *
  *	Disconnect a drive from the driver it was attached to and then
  *	clean up the various proc files and other objects attached to it.
  *
- *	Takes ide_setting_sem, ide_lock and drives_lock.
+ *	Takes ide_setting_sem and ide_lock.
  *	Caller must hold none of the locks.
- *
- *	No locking versus subdriver unload because we are moving to the
- *	default driver anyway. Wants double checking.
  */

-int ide_unregister_subdriver (ide_drive_t *drive)
+void ide_unregister_subdriver(ide_drive_t *drive, ide_driver_t *driver)
 {
 	unsigned long flags;

 	down(&ide_setting_sem);
 	spin_lock_irqsave(&ide_lock, flags);
-	if (drive->usage || drive->driver == NULL || DRIVER(drive)->busy) {
-		spin_unlock_irqrestore(&ide_lock, flags);
-		up(&ide_setting_sem);
-		return 1;
-	}
 #ifdef CONFIG_PROC_FS
-	ide_remove_proc_entries(drive->proc, DRIVER(drive)->proc);
+	ide_remove_proc_entries(drive->proc, driver->proc);
 #endif
 	auto_remove_settings(drive);
-	drive->driver = NULL;
 	spin_unlock_irqrestore(&ide_lock, flags);
 	up(&ide_setting_sem);
-	spin_lock(&drives_lock);
-	list_del_init(&drive->list);
-	spin_unlock(&drives_lock);
-	/* drive will be added to &ide_drives in ata_attach() */
-	return 0;
 }

 EXPORT_SYMBOL(ide_unregister_subdriver);

-static int ide_drive_remove(struct device * dev)
-{
-	ide_drive_t * drive = container_of(dev,ide_drive_t,gendev);
-	DRIVER(drive)->cleanup(drive);
-	return 0;
-}
-
-/**
- *	ide_register_driver	-	register IDE device driver
- *	@driver: the IDE device driver
- *
- *	Register a new device driver and then scan the devices
- *	on the IDE bus in case any should be attached to the
- *	driver we have just registered.  If so attach them.
- *
- *	Takes drivers_lock and drives_lock.
- */
-
-int ide_register_driver(ide_driver_t *driver)
-{
-	struct list_head list;
-	struct list_head *list_loop;
-	struct list_head *tmp_storage;
-
-	spin_lock(&drivers_lock);
-	list_add(&driver->drivers, &drivers);
-	spin_unlock(&drivers_lock);
-
-	INIT_LIST_HEAD(&list);
-	spin_lock(&drives_lock);
-	list_splice_init(&ide_drives, &list);
-	spin_unlock(&drives_lock);
-
-	list_for_each_safe(list_loop, tmp_storage, &list) {
-		ide_drive_t *drive = container_of(list_loop, ide_drive_t, list);
-		list_del_init(&drive->list);
-		if (drive->present)
-			ata_attach(drive);
-	}
-	driver->gen_driver.name = (char *) driver->name;
-	driver->gen_driver.bus = &ide_bus_type;
-	driver->gen_driver.remove = ide_drive_remove;
-	return driver_register(&driver->gen_driver);
-}
-
-EXPORT_SYMBOL(ide_register_driver);
-
-/**
- *	ide_unregister_driver	-	unregister IDE device driver
- *	@driver: the IDE device driver
- *
- *	Called when a driver module is being unloaded. We reattach any
- *	devices to whatever driver claims them next (typically the default
- *	driver).
- *
- *	Takes drivers_lock and called functions will take ide_setting_sem.
- */
-
-void ide_unregister_driver(ide_driver_t *driver)
-{
-	ide_drive_t *drive;
-
-	spin_lock(&drivers_lock);
-	list_del(&driver->drivers);
-	spin_unlock(&drivers_lock);
-
-	driver_unregister(&driver->gen_driver);
-
-	while(!list_empty(&driver->drives)) {
-		drive = list_entry(driver->drives.next, ide_drive_t, list);
-		if (driver->cleanup(drive)) {
-			printk(KERN_ERR "%s: cleanup_module() called while still busy\n", drive->name);
-			BUG();
-		}
-		ata_attach(drive);
-	}
-}
-
-EXPORT_SYMBOL(ide_unregister_driver);
-
 /*
  * Probe module
  */

 EXPORT_SYMBOL(ide_lock);

+static int ide_bus_match(struct device *dev, struct device_driver *drv)
+{
+	return 1;
+}
+
 struct bus_type ide_bus_type = {
 	.name		= "ide",
+	.match		= ide_bus_match,
 	.suspend	= generic_ide_suspend,
 	.resume		= generic_ide_resume,
 };
+
+EXPORT_SYMBOL_GPL(ide_bus_type);

 /*
  * This is gets invoked once during initialization, to set *everything* up
diff -Nru a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
--- a/drivers/scsi/ide-scsi.c	2005-02-04 03:32:30 +01:00
+++ b/drivers/scsi/ide-scsi.c	2005-02-04 03:32:30 +01:00
@@ -713,7 +713,6 @@
  */
 static void idescsi_setup (ide_drive_t *drive, idescsi_scsi_t *scsi)
 {
-	DRIVER(drive)->busy++;
 	if (drive->id && (drive->id->config & 0x0060) == 0x20)
 		set_bit (IDESCSI_DRQ_INTERRUPT, &scsi->flags);
 	set_bit(IDESCSI_TRANSFORM, &scsi->transform);
@@ -722,17 +721,16 @@
 	set_bit(IDESCSI_LOG_CMD, &scsi->log);
 #endif /* IDESCSI_DEBUG_LOG */
 	idescsi_add_settings(drive);
-	DRIVER(drive)->busy--;
 }

-static int idescsi_cleanup (ide_drive_t *drive)
+static int ide_scsi_remove(struct device *dev)
 {
+	ide_drive_t *drive = to_ide_device(dev);
 	struct Scsi_Host *scsihost = drive->driver_data;
 	struct ide_scsi_obj *scsi = scsihost_to_idescsi(scsihost);
 	struct gendisk *g = scsi->disk;

-	if (ide_unregister_subdriver(drive))
-		return 1;
+	ide_unregister_subdriver(drive, scsi->driver);

 	ide_unregister_region(g);

@@ -748,7 +746,7 @@
 	return 0;
 }

-static int idescsi_attach(ide_drive_t *drive);
+static int ide_scsi_probe(struct device *);

 #ifdef CONFIG_PROC_FS
 static ide_proc_entry_t idescsi_proc[] = {
@@ -759,24 +757,22 @@
 # define idescsi_proc	NULL
 #endif

-/*
- *	IDE subdriver functions, registered with ide.c
- */
 static ide_driver_t idescsi_driver = {
 	.owner			= THIS_MODULE,
-	.name			= "ide-scsi",
+	.gen_driver = {
+		.name		= "ide-scsi",
+		.bus		= &ide_bus_type,
+		.probe		= ide_scsi_probe,
+		.remove		= ide_scsi_remove,
+	},
 	.version		= IDESCSI_VERSION,
 	.media			= ide_scsi,
-	.busy			= 0,
 	.supports_dsc_overlap	= 0,
 	.proc			= idescsi_proc,
-	.attach			= idescsi_attach,
-	.cleanup		= idescsi_cleanup,
 	.do_request		= idescsi_do_request,
 	.end_request		= idescsi_end_request,
 	.error                  = idescsi_atapi_error,
 	.abort                  = idescsi_atapi_abort,
-	.drives			= LIST_HEAD_INIT(idescsi_driver.drives),
 };

 static int idescsi_ide_open(struct inode *inode, struct file *filp)
@@ -823,8 +819,6 @@
 	.ioctl		= idescsi_ide_ioctl,
 };

-static int idescsi_attach(ide_drive_t *drive);
-
 static int idescsi_slave_configure(struct scsi_device * sdp)
 {
 	/* Configure detected device */
@@ -1097,8 +1091,9 @@
 	.proc_name		= "ide-scsi",
 };

-static int idescsi_attach(ide_drive_t *drive)
+static int ide_scsi_probe(struct device *dev)
 {
+	ide_drive_t *drive = to_ide_device(dev);
 	idescsi_scsi_t *idescsi;
 	struct Scsi_Host *host;
 	struct gendisk *g;
@@ -1140,7 +1135,8 @@
 	idescsi->host = host;
 	idescsi->disk = g;
 	g->private_data = &idescsi->driver;
-	err = ide_register_subdriver(drive, &idescsi_driver);
+	ide_register_subdriver(drive, &idescsi_driver);
+	err = 0;
 	if (!err) {
 		idescsi_setup (drive, idescsi);
 		g->fops = &idescsi_ops;
@@ -1152,7 +1148,7 @@
 		}
 		/* fall through on error */
 		ide_unregister_region(g);
-		ide_unregister_subdriver(drive);
+		ide_unregister_subdriver(drive, &idescsi_driver);
 	}

 	put_disk(g);
@@ -1163,12 +1159,12 @@

 static int __init init_idescsi_module(void)
 {
-	return ide_register_driver(&idescsi_driver);
+	return driver_register(&idescsi_driver.gen_driver);
 }

 static void __exit exit_idescsi_module(void)
 {
-	ide_unregister_driver(&idescsi_driver);
+	driver_unregister(&idescsi_driver.gen_driver);
 }

 module_init(init_idescsi_module);
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	2005-02-04 03:32:30 +01:00
+++ b/include/linux/ide.h	2005-02-04 03:32:30 +01:00
@@ -664,7 +664,6 @@

 	struct request		*rq;	/* current request */
 	struct ide_drive_s 	*next;	/* circular list of hwgroup drives */
-	struct ide_driver_s	*driver;/* (ide_driver_t *) */
 	void		*driver_data;	/* extra driver data */
 	struct hd_driveid	*id;	/* drive model identification info */
 	struct proc_dir_entry *proc;	/* /proc/ide/ directory entry */
@@ -759,6 +758,8 @@
 	struct semaphore gendev_rel_sem;	/* to deal with device release() */
 } ide_drive_t;

+#define to_ide_device(dev)container_of(dev, ide_drive_t, gendev)
+
 #define IDE_CHIPSET_PCI_MASK	\
     ((1<<ide_pci)|(1<<ide_cmd646)|(1<<ide_ali14xx))
 #define IDE_CHIPSET_IS_PCI(c)	((IDE_CHIPSET_PCI_MASK >> (c)) & 1)
@@ -1087,28 +1088,20 @@
  */
 typedef struct ide_driver_s {
 	struct module			*owner;
-	const char			*name;
 	const char			*version;
 	u8				media;
-	unsigned busy			: 1;
 	unsigned supports_dsc_overlap	: 1;
-	int		(*cleanup)(ide_drive_t *);
 	ide_startstop_t	(*do_request)(ide_drive_t *, struct request *, sector_t);
 	int		(*end_request)(ide_drive_t *, int, int);
 	ide_startstop_t	(*error)(ide_drive_t *, struct request *rq, u8, u8);
 	ide_startstop_t	(*abort)(ide_drive_t *, struct request *rq);
 	int		(*ioctl)(ide_drive_t *, struct inode *, struct file *, unsigned int, unsigned long);
 	ide_proc_entry_t	*proc;
-	int		(*attach)(ide_drive_t *);
 	void		(*ata_prebuilder)(ide_drive_t *);
 	void		(*atapi_prebuilder)(ide_drive_t *);
 	struct device_driver	gen_driver;
-	struct list_head drives;
-	struct list_head drivers;
 } ide_driver_t;

-#define DRIVER(drive)		((drive)->driver)
-
 int generic_ide_ioctl(ide_drive_t *, struct file *, struct block_device *, unsigned, unsigned long);

 /*
@@ -1343,8 +1336,6 @@

 void ide_init_disk(struct gendisk *, ide_drive_t *);

-extern int ata_attach(ide_drive_t *);
-
 extern int ideprobe_init(void);

 extern void ide_scan_pcibus(int scan_direction) __init;
@@ -1357,11 +1348,8 @@
 extern void default_hwif_mmiops(ide_hwif_t *);
 extern void default_hwif_transport(ide_hwif_t *);

-int ide_register_driver(ide_driver_t *driver);
-void ide_unregister_driver(ide_driver_t *driver);
-int ide_register_subdriver(ide_drive_t *, ide_driver_t *);
-int ide_unregister_subdriver (ide_drive_t *drive);
-int ide_replace_subdriver(ide_drive_t *drive, const char *driver);
+void ide_register_subdriver(ide_drive_t *, ide_driver_t *);
+void ide_unregister_subdriver(ide_drive_t *, ide_driver_t *);

 #define ON_BOARD		1
 #define NEVER_BOARD		0
