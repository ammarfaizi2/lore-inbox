Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264538AbSIVUsp>; Sun, 22 Sep 2002 16:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264534AbSIVUso>; Sun, 22 Sep 2002 16:48:44 -0400
Received: from [195.39.17.254] ([195.39.17.254]:9600 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S264533AbSIVUrN>;
	Sun, 22 Sep 2002 16:47:13 -0400
Date: Sat, 21 Sep 2002 23:04:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andre Hedrick <andre@linux-ide.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: devicefs & sleep support for IDE
Message-ID: <20020921210456.GA31784@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

New patch, rediffed against 2.5.36.

More patches will be needed to support IDE properly (like DVD burners
you mentioned), but this is known to fix data corruption. It has zero
impact on actual I/O. It affects initialization and suspend only.
Please apply this time.

								Pavel

--- clean/drivers/ide/ide-disk.c	2002-09-21 13:20:43.000000000 +0200
+++ linux-swsusp/drivers/ide/ide-disk.c	2002-09-21 13:34:46.000000000 +0200
@@ -544,6 +544,7 @@
  */
 static ide_startstop_t do_rw_disk (ide_drive_t *drive, struct request *rq, unsigned long block)
 {
+	BUG_ON(drive->blocked);
 	if (!blk_fs_request(rq)) {
 		blk_dump_rq_flags(rq, "do_rw_disk - bad command");
 		ide_end_request(drive, 0, 0);
@@ -1495,8 +1496,63 @@
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
+	.lock = RW_LOCK_UNLOCKED,
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
@@ -1517,12 +1573,13 @@
 {
 	struct hd_driveid *id = drive->id;
 	unsigned long capacity;
+	int myid = -1;
 
 #if 0
 	if (IS_PDC4030_DRIVE)
 		DRIVER(drive)->do_request = promise_rw_disk;
 #endif
-	
+
 	idedisk_add_settings(drive);
 
 	if (id == NULL)
@@ -1540,6 +1597,15 @@
 			drive->doorlocking = 1;
 		}
 	}
+	{
+		ide_hwif_t *hwif = HWIF(drive);
+		sprintf(drive->device.bus_id, "%d", myid);
+		sprintf(drive->device.name, "ide-disk");
+		drive->device.driver = &idedisk_devdrv;
+		drive->device.parent = &hwif->device;
+		drive->device.driver_data = drive;
+		device_register(&drive->device);
+	}
 
 #if 1
 	(void) probe_lba_addressing(drive, 1);
@@ -1623,6 +1689,8 @@
 static int idedisk_cleanup (ide_drive_t *drive)
 {
 	struct gendisk *g = drive->disk;
+
+	put_device(&drive->device);
 	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
 		if (do_idedisk_flushcache(drive))
 			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
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
 
--- clean/drivers/ide/ide-probe.c	2002-09-21 13:46:39.000000000 +0200
+++ linux-swsusp/drivers/ide/ide-probe.c	2002-09-21 13:49:56.000000000 +0200
@@ -46,6 +46,7 @@
 #include <linux/delay.h>
 #include <linux/ide.h>
 #include <linux/spinlock.h>
+#include <linux/pci.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -563,6 +564,15 @@
 {
 	u32 i = 0;
 
+	sprintf(hwif->device.bus_id, "%04x", hwif->io_ports[IDE_DATA_OFFSET]);
+	sprintf(hwif->device.name, "ide");
+	hwif->device.driver_data = hwif;
+	if (hwif->pci_dev)
+		hwif->device.parent = &hwif->pci_dev->dev;
+	else
+		hwif->device.parent = NULL; /* Would like to do = &device_legacy */
+	device_register(&hwif->device);
+
 	if (hwif->mmio == 2)
 		return;
 	if (hwif->io_ports[IDE_CONTROL_OFFSET])
--- clean/drivers/ide/ide.c	2002-09-21 13:46:39.000000000 +0200
+++ linux-swsusp/drivers/ide/ide.c	2002-09-21 13:49:56.000000000 +0200
@@ -152,6 +152,8 @@
 #include <linux/reboot.h>
 #include <linux/cdrom.h>
 #include <linux/seq_file.h>
+#include <linux/device.h>
+#include <linux/kmod.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -161,7 +163,6 @@
 
 #include "ide_modes.h"
 
-#include <linux/kmod.h>
 
 /* default maximum number of failures */
 #define IDE_DEFAULT_MAX_FAILURES 	1
@@ -1755,6 +1756,7 @@
 	hwif = &ide_hwifs[index];
 	if (!hwif->present)
 		goto abort;
+	put_device(&hwif->device);
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		drive = &hwif->drives[unit];
 		if (!drive->present)
--- clean/include/linux/ide.h	2002-09-21 13:46:42.000000000 +0200
+++ linux-swsusp/include/linux/ide.h	2002-09-21 13:50:10.000000000 +0200
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/bitops.h>
 #include <linux/bio.h>
+#include <linux/device.h>
 #include <linux/pci.h>
 #include <asm/byteorder.h>
 #include <asm/system.h>
@@ -789,6 +790,7 @@
 	unsigned autotune	: 2;	/* 1=autotune, 2=noautotune, 0=default */
 	unsigned remap_0_to_1	: 2;	/* 0=remap if ezdrive, 1=remap, 2=noremap */
 	unsigned ata_flash	: 1;	/* 1=present, 0=default */
+	unsigned blocked        : 1;	/* 1=powermanagment told us not to do anything, so sleep nicely */
 	unsigned addressing;		/*      : 3;
 					 *  0=28-bit
 					 *  1=48-bit
@@ -835,6 +837,7 @@
 	int		crc_count;	/* crc counter to reduce drive speed */
 	struct list_head list;
 	struct gendisk *disk;
+	struct device	device;		/* for driverfs */
 } ide_drive_t;
 
 typedef struct ide_pio_ops_s {
@@ -1073,6 +1076,7 @@
 	unsigned	no_dsc     : 1;	/* 0 default, 1 dsc_overlap disabled */
 
 	void		*hwif_data;	/* extra hwif data */
+	struct device	device;		/* for devicefs */
 } ide_hwif_t;
 
 /*

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
