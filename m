Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319410AbSIFW0Y>; Fri, 6 Sep 2002 18:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319414AbSIFW0Y>; Fri, 6 Sep 2002 18:26:24 -0400
Received: from [195.39.17.254] ([195.39.17.254]:20352 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S319410AbSIFW0U>;
	Fri, 6 Sep 2002 18:26:20 -0400
Date: Sat, 7 Sep 2002 00:29:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andre Hedrick <andre@linux-ide.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, alan@redhat.com,
       torvalds@transmeta.com
Subject: Re: IDE support for suspend -- prevent data corruption
Message-ID: <20020906222859.GC10888@elf.ucw.cz>
References: <20020905230605.GA26735@elf.ucw.cz> <Pine.LNX.4.10.10209052328020.11256-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10209052328020.11256-100000@master.linux-ide.org>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Go for it, all I ask is you put a stub rapper around it as to isolate the
> code.  I just am asking for a variable reduction on features until I clear
> all business w/ Alan.  I am trying to do clean up for Jens on the
> portforward stuff.

You surely don't want #ifdef around every change, do you?

Impact should be introducing driver model (you want that even without
CONFIG_SOFTWARE_SUSPEND). idedisk_suspend/idedisk_resume can only be
called by software suspend or ACPI S3. No need for #ifdef hell.

Turned drive->blocked test into BUG_ON(). If it triggers you'll know
it triggered, but I can promise you it will not on
!CONFIG_SOFTWARE_SUSPEND case.

New patch attached, please apply.
								Pavel

--- linux-swsusp.2/drivers/ide/ide-disk.c	2002-09-05 23:30:28.000000000 +0200
+++ linux-swsusp/drivers/ide/ide-disk.c	2002-09-07 00:19:06.000000000 +0200
@@ -365,6 +365,7 @@
  */
 static ide_startstop_t do_rw_disk (ide_drive_t *drive, struct request *rq, unsigned long block)
 {
+	BUG_ON(drive->blocked);
 	if (!(rq->flags & REQ_CMD)) {
 		blk_dump_rq_flags(rq, "do_rw_disk - bad command");
 		idedisk_end_request(drive, 0);
@@ -1514,12 +1515,65 @@
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
 static void idedisk_setup (ide_drive_t *drive)
 {
 	int i;
 	
 	struct hd_driveid *id = drive->id;
 	unsigned long capacity;
+	int myid = -1;
 	
 	idedisk_add_settings(drive);
 
@@ -1542,11 +1596,21 @@
 		ide_hwif_t *hwif = HWIF(drive);
 
 		if (drive != &hwif->drives[i]) continue;
+		myid = i;
 		hwif->gd[i]->de_arr[i] = drive->de;
 		if (drive->removable)
 			hwif->gd[i]->flags[i] |= GENHD_FL_REMOVABLE;
 		break;
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
@@ -1632,6 +1696,8 @@
 	ide_hwif_t *hwif = HWIF(drive);
 	int unit = drive - hwif->drives;
 	struct gendisk *g = hwif->gd[unit];
+
+	put_device(&drive->device);
 	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
 		if (do_idedisk_flushcache(drive))
 			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
--- linux-swsusp.2/drivers/ide/ide-pnp.c	2002-08-28 23:12:14.000000000 +0200
+++ linux-swsusp/drivers/ide/ide-pnp.c	2002-09-06 00:28:57.000000000 +0200
@@ -57,6 +57,7 @@
 static int __init pnpide_generic_init(struct pci_dev *dev, int enable)
 {
 	hw_regs_t hw;
+	ide_hwif_t *hwif;
 	int index;
 
 	if (!enable)
@@ -69,9 +70,10 @@
 			generic_ide_offsets, (ide_ioreg_t) DEV_IO(dev, 1),
 			0, NULL, DEV_IRQ(dev, 0));
 
-	index = ide_register_hw(&hw, NULL);
+	index = ide_register_hw(&hw, &hwif);
 
 	if (index != -1) {
+		hwif->pci_dev = dev;
 	    	printk("ide%d: %s IDE interface\n", index, DEV_NAME(dev));
 		return 0;
 	}
--- linux-swsusp.2/drivers/ide/ide-probe.c	2002-09-05 23:30:28.000000000 +0200
+++ linux-swsusp/drivers/ide/ide-probe.c	2002-09-06 00:28:57.000000000 +0200
@@ -46,6 +46,7 @@
 #include <linux/delay.h>
 #include <linux/ide.h>
 #include <linux/spinlock.h>
+#include <linux/pci.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -477,6 +478,14 @@
 
 static void hwif_register (ide_hwif_t *hwif)
 {
+	sprintf(hwif->device.bus_id, "%04x", hwif->io_ports[IDE_DATA_OFFSET]);
+	sprintf(hwif->device.name, "ide");
+	hwif->device.driver_data = hwif;
+	if (hwif->pci_dev)
+		hwif->device.parent = &hwif->pci_dev->dev;
+	else
+		hwif->device.parent = NULL; /* Would like to do = &device_legacy */
+	device_register(&hwif->device);
 	if (((unsigned long)hwif->io_ports[IDE_DATA_OFFSET] | 7) ==
 	    ((unsigned long)hwif->io_ports[IDE_STATUS_OFFSET])) {
 		ide_request_region(hwif->io_ports[IDE_DATA_OFFSET], 8, hwif->name);
--- linux-swsusp.2/drivers/ide/ide-proc.c	2002-09-05 23:30:28.000000000 +0200
+++ linux-swsusp/drivers/ide/ide-proc.c	2002-09-06 00:20:43.000000000 +0200
@@ -562,14 +562,14 @@
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
 	ide_drive_t	*drive = (ide_drive_t *) data;
-	ide_driver_t    *driver = (ide_driver_t *) drive->driver;
+	ide_driver_t    *driver = drive->driver;
 	int		len;
 
 	if (!driver)
 		len = sprintf(page, "(none)\n");
         else
 		len = sprintf(page,"%llu\n",
-			      (unsigned long long) ((ide_driver_t *)drive->driver)->capacity(drive));
+			      (unsigned long long) drive->driver->capacity(drive));
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
 
@@ -601,7 +601,7 @@
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
 	ide_drive_t	*drive = (ide_drive_t *) data;
-	ide_driver_t	*driver = (ide_driver_t *) drive->driver;
+	ide_driver_t	*driver = drive->driver;
 	int		len;
 
 	if (!driver)
@@ -718,7 +718,6 @@
 	struct proc_dir_entry *ent;
 	struct proc_dir_entry *parent = hwif->proc;
 	char name[64];
-//	ide_driver_t *driver = drive->driver;
 
 	if (drive->present && !drive->proc) {
 		drive->proc = proc_mkdir(drive->name, parent);
@@ -760,7 +759,6 @@
 
 	for (d = 0; d < MAX_DRIVES; d++) {
 		ide_drive_t *drive = &hwif->drives[d];
-//		ide_driver_t *driver = drive->driver;
 
 		if (drive->proc)
 			destroy_proc_ide_device(hwif, drive);
--- linux-swsusp.2/drivers/ide/ide.c	2002-09-05 23:30:28.000000000 +0200
+++ linux-swsusp/drivers/ide/ide.c	2002-09-06 00:31:24.000000000 +0200
@@ -141,9 +141,7 @@
 #include <linux/genhd.h>
 #include <linux/blkpg.h>
 #include <linux/slab.h>
-#ifndef MODULE
 #include <linux/init.h>
-#endif /* MODULE */
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/ide.h>
@@ -152,6 +150,8 @@
 #include <linux/reboot.h>
 #include <linux/cdrom.h>
 #include <linux/seq_file.h>
+#include <linux/device.h>
+#include <linux/kmod.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -161,9 +161,6 @@
 
 #include "ide_modes.h"
 
-#ifdef CONFIG_KMOD
-#include <linux/kmod.h>
-#endif /* CONFIG_KMOD */
 
 /* default maximum number of failures */
 #define IDE_DEFAULT_MAX_FAILURES 	1
@@ -1957,6 +1954,7 @@
 	hwif = &ide_hwifs[index];
 	if (!hwif->present)
 		goto abort;
+	put_device(&hwif->device);
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		drive = &hwif->drives[unit];
 		if (!drive->present)
--- linux-swsusp.2/include/linux/ide.h	2002-09-05 23:30:41.000000000 +0200
+++ linux-swsusp/include/linux/ide.h	2002-09-06 00:39:30.000000000 +0200
@@ -15,6 +15,7 @@
 #include <linux/proc_fs.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/bio.h>
+#include <linux/device.h>
 #include <asm/byteorder.h>
 #include <asm/system.h>
 #include <asm/hdreg.h>
@@ -477,6 +478,7 @@
 	unsigned autotune	: 2;	/* 1=autotune, 2=noautotune, 0=default */
 	unsigned remap_0_to_1	: 2;	/* 0=remap if ezdrive, 1=remap, 2=noremap */
 	unsigned ata_flash	: 1;	/* 1=present, 0=default */
+	unsigned blocked        : 1;	/* 1=powermanagment told us not to do anything, so sleep nicely */
 	unsigned addressing;		/*	: 3;
 					 *  0=28-bit
 					 *  1=48-bit
@@ -530,6 +532,7 @@
 	unsigned int	failures;	/* current failure count */
 	unsigned int	max_failures;	/* maximum allowed failure count */
 	struct list_head list;
+	struct device	device;
 } ide_drive_t;
 
 /*
@@ -765,6 +768,7 @@
 	byte		straight8;	/* Alan's straight 8 check */
 	void		*hwif_data;	/* extra hwif data */
 	byte		bus_state;	/* power state of the IDE bus */
+	struct device	device;
 } ide_hwif_t;
 
 /*


-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
