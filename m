Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262111AbSIYUPt>; Wed, 25 Sep 2002 16:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262109AbSIYUOr>; Wed, 25 Sep 2002 16:14:47 -0400
Received: from [195.39.17.254] ([195.39.17.254]:3844 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262107AbSIYUOd>;
	Wed, 25 Sep 2002 16:14:33 -0400
Date: Wed, 25 Sep 2002 21:10:09 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>
Subject: IDE: prevent disk corruption on suspend
Message-ID: <20020925191009.GA804@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This makes IDE suspend disks properly (and not to eat data in the
way). Please apply,

								Pavel

--- clean/drivers/ide/ide-disk.c	2002-09-23 00:09:13.000000000 +0200
+++ linux-swsusp/drivers/ide/ide-disk.c	2002-09-25 20:30:26.000000000 +0200
@@ -1495,8 +1496,65 @@
  	ide_add_setting(drive,	"max_failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->max_failures,		NULL);
 }
 
+static int idedisk_suspend(struct device *dev, u32 state, u32 level)
+{
+	ide_drive_t *drive = dev->driver_data;
+
+	/* I hope that every freeze operations from the upper levels have
+	 * already been done...
+	 */
+
+	BUG_ON(in_interrupt());
+
+	if (level != SUSPEND_SAVE_STATE)
+		return 0;
+
+	/* wait until all commands are finished */
+	/* FIXME: waiting for spinlocks should be done instead. */
+	while (HWGROUP(drive)->handler)
+		yield();
+
+	/* set the drive to standby */
+	printk(KERN_INFO "suspending: %s ", drive->name);
+	if (drive->driver) {
+		if (drive->driver->standby)
+			drive->driver->standby(drive);
+	}
+	drive->blocked = 1;
+
+	while (HWGROUP(drive)->handler)
+		yield();
+
+	return 0;
+}
+
+static int idedisk_resume(struct device *dev, u32 level)
+{
+	ide_drive_t *drive = dev->driver_data;
+
+	if (level != RESUME_RESTORE_STATE)
+		return 0;
+	if (!drive->blocked)
+		panic("ide: Resume but not suspended?\n");
+
+	drive->blocked = 0;
+	return 0;
+}
+
+
+/* This is just a hook for the overall driver tree.
+ */
+
+static struct device_driver idedisk_devdrv = {
+	.bus = &ide_bus_type,
+	.name = "IDE disk driver",
+
+	.suspend = idedisk_suspend,
+	.resume = idedisk_resume,
+};
+
 static int idedisk_ioctl (ide_drive_t *drive, struct inode *inode,
-		struct file *file, unsigned int cmd, unsigned long arg)
+	struct file *file, unsigned int cmd, unsigned long arg)
 {
 #if 0
 HDIO_GET_ADDRESS
@@ -1540,6 +1597,10 @@
 			drive->doorlocking = 1;
 		}
 	}
+	{
+		sprintf(drive->disk->disk_dev.name, "ide-disk");
+		drive->disk->disk_dev.driver = &idedisk_devdrv;
+	}
 
 #if 1
 	(void) probe_lba_addressing(drive, 1);
@@ -1623,6 +1684,8 @@
 static int idedisk_cleanup (ide_drive_t *drive)
 {
 	struct gendisk *g = drive->disk;
+
+	put_device(&drive->disk->disk_dev);
 	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
 		if (do_idedisk_flushcache(drive))
 			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
@@ -1721,6 +1784,7 @@
 static int idedisk_init (void)
 {
 	ide_register_driver(&idedisk_driver);
+	driver_register(&idedisk_devdrv);
 	return 0;
 }
 
--- clean/drivers/ide/ide-pnp.c	2002-09-21 13:20:44.000000000 +0200
+++ linux-swsusp/drivers/ide/ide-pnp.c	2002-09-21 13:35:29.000000000 +0200
@@ -52,6 +52,7 @@
 static int __init pnpide_generic_init(struct pci_dev *dev, int enable)
 {
 	hw_regs_t hw;
+	ide_hwif_t *hwif;
 	int index;
 
 	if (!enable)
@@ -67,10 +68,11 @@
 //			generic_pnp_ide_iops,
 			DEV_IRQ(dev, 0));
 
-	index = ide_register_hw(&hw, NULL);
+	index = ide_register_hw(&hw, &hwif);
 
 	if (index != -1) {
 	    	printk(KERN_INFO "ide%d: %s IDE interface\n", index, DEV_NAME(dev));
+		hwif->pci_dev = dev;
 		return 0;
 	}
 
--- clean/drivers/ide/ide-probe.c	2002-09-23 00:09:13.000000000 +0200
+++ linux-swsusp/drivers/ide/ide-probe.c	2002-09-23 23:08:58.000000000 +0200
@@ -46,6 +46,7 @@
 #include <linux/delay.h>
 #include <linux/ide.h>
 #include <linux/spinlock.h>
+#include <linux/pci.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -566,6 +567,11 @@
 	/* register with global device tree */
 	strncpy(hwif->gendev.bus_id,hwif->name,BUS_ID_SIZE);
 	snprintf(hwif->gendev.name,DEVICE_NAME_SIZE,"IDE Controller");
+	hwif->gendev.driver_data = hwif;
+	if (hwif->pci_dev)
+		hwif->gendev.parent = &hwif->pci_dev->dev;
+	else
+		hwif->gendev.parent = NULL; /* Would like to do = &device_legacy */
 	device_register(&hwif->gendev);
 
 	if (hwif->mmio == 2)

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
