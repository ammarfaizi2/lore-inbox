Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262870AbSJAWTs>; Tue, 1 Oct 2002 18:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262873AbSJAWTq>; Tue, 1 Oct 2002 18:19:46 -0400
Received: from [195.39.17.254] ([195.39.17.254]:16644 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262870AbSJAWSt>;
	Tue, 1 Oct 2002 18:18:49 -0400
Date: Wed, 2 Oct 2002 00:24:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Swsusp updates, do not thrash ide disk on suspend
Message-ID: <20021001222434.GA2498@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This cleans up swsusp a little bit and fixes ide disk corruption on
suspend/resume. Please apply,
									Pavel
--- clean/Documentation/swsusp.txt	2002-07-09 04:54:06.000000000 +0200
+++ linux-swsusp/Documentation/swsusp.txt	2002-09-25 21:14:42.000000000 +0200
@@ -156,6 +156,23 @@
 - do IDE cdroms need some kind of support?
 - IDE CD-RW -- how to deal with that?
 
+FAQ:
+
+Q: well, suspending a server is IMHO a really stupid thing,
+but... (Diego Zuccato):
+
+A: You bought new UPS for your server. How do you install it without
+bringing machine down? Suspend to disk, rearrange power cables,
+resume.
+
+You have your server on UPS. Power died, and UPS is indicating 30
+seconds to failure. What do you do? Suspend to disk.
+
+Ethernet card in your server died. You want to replace it. Your
+server is not hotplug capable. What do you do? Suspend to disk,
+replace ethernet card, resume. If you are fast your users will not
+even see broken connections.
+
 Any other idea you might have tell me!
 
 Contacting the author
--- clean/drivers/ide/ide-disk.c	2002-09-23 00:09:13.000000000 +0200
+++ linux-swsusp/drivers/ide/ide-disk.c	2002-10-01 23:58:17.000000000 +0200
@@ -544,6 +544,7 @@
  */
 static ide_startstop_t do_rw_disk (ide_drive_t *drive, struct request *rq, unsigned long block)
 {
+	BUG_ON(drive->blocked);
 	if (!blk_fs_request(rq)) {
 		blk_dump_rq_flags(rq, "do_rw_disk - bad command");
 		ide_end_request(drive, 0, 0);
@@ -1495,8 +1496,70 @@
  	ide_add_setting(drive,	"max_failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->max_failures,		NULL);
 }
 
+static int idedisk_suspend(struct device *dev, u32 state, u32 level)
+{
+	ide_drive_t *drive = dev->driver_data;
+
+	printk("Suspending device %lx\n", dev->driver_data);
+
+	/* I hope that every freeze operation from the upper levels have
+	 * already been done...
+	 */
+
+	if (level != SUSPEND_SAVE_STATE)
+		return 0;
+	BUG_ON(in_interrupt());
+
+	printk("Waiting for commands to finish\n");
+
+	/* wait until all commands are finished */
+	/* FIXME: waiting for spinlocks should be done instead. */
+	if (!(HWGROUP(drive)))
+		printk("No hwgroup?\n");
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
@@ -1540,6 +1603,11 @@
 			drive->doorlocking = 1;
 		}
 	}
+	{
+		sprintf(drive->disk->disk_dev.name, "ide-disk");
+		drive->disk->disk_dev.driver = &idedisk_devdrv;
+		drive->disk->disk_dev.driver_data = drive;
+	}
 
 #if 1
 	(void) probe_lba_addressing(drive, 1);
@@ -1623,6 +1691,8 @@
 static int idedisk_cleanup (ide_drive_t *drive)
 {
 	struct gendisk *g = drive->disk;
+
+	put_device(&drive->disk->disk_dev);
 	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
 		if (do_idedisk_flushcache(drive))
 			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
@@ -1721,6 +1791,7 @@
 static int idedisk_init (void)
 {
 	ide_register_driver(&idedisk_driver);
+	driver_register(&idedisk_devdrv);
 	return 0;
 }
 
--- clean/drivers/ide/ide-pnp.c	2002-09-21 13:20:44.000000000 +0200
+++ linux-swsusp/drivers/ide/ide-pnp.c	2002-09-25 21:14:42.000000000 +0200
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
+++ linux-swsusp/drivers/ide/ide-probe.c	2002-09-25 21:14:42.000000000 +0200
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
--- clean/include/linux/ide.h	2002-09-23 00:09:14.000000000 +0200
+++ linux-swsusp/include/linux/ide.h	2002-09-25 21:14:42.000000000 +0200
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
--- clean/kernel/suspend.c	2002-09-30 20:33:52.000000000 +0200
+++ linux-swsusp/kernel/suspend.c	2002-09-30 20:36:03.000000000 +0200
@@ -470,19 +470,22 @@
 	int nr_copy_pages = 0;
 	int pfn;
 	struct page *page;
-
-#ifndef CONFIG_DISCONTIGMEM	
-	if (max_mapnr != num_physpages)
-		panic("mapnr is not expected");
+	
+#ifdef CONFIG_DISCONTIGMEM
+	panic("Discontingmem not supported");
+#else
+	BUG_ON (max_mapnr != num_physpages);
 #endif
-	for (pfn = 0; pfn < num_physpages; pfn++) {
+	for (pfn = 0; pfn < max_mapnr; pfn++) {
 		page = pfn_to_page(pfn);
 		if (PageHighMem(page))
 			panic("Swsusp not supported on highmem boxes. Send 1GB of RAM to <pavel@ucw.cz> and try again ;-).");
+
 		if (!PageReserved(page)) {
 			if (PageNosave(page))
 				continue;
 
+
 			if ((chunk_size=is_head_of_free_region(page))!=0) {
 				pfn += chunk_size - 1;
 				continue;
@@ -776,9 +789,10 @@
 	BUG_ON (nr_copy_pages_check != nr_copy_pages);
 	BUG_ON (pagedir_order_check != pagedir_order);
 
+	__flush_tlb_global();		/* Even mappings of "global" things (vmalloc) need to be fixed */
+
 	PRINTK( "Freeing prev allocated pagedir\n" );
 	free_suspend_pagedir((unsigned long) pagedir_save);
-	__flush_tlb_global();		/* Even mappings of "global" things (vmalloc) need to be fixed */
 	drivers_resume(RESUME_ALL_PHASES);
 	spin_unlock_irq(&suspend_pagedir_lock);
 
@@ -809,12 +823,10 @@
 
 	barrier();
 	mb();
-	drivers_resume(RESUME_PHASE2);
 	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */ 
 	mdelay(1000);
 
 	free_pages((unsigned long) pagedir_nosave, pagedir_order);
-	drivers_resume(RESUME_PHASE1);
 	spin_unlock_irq(&suspend_pagedir_lock);
 	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
 	PRINTK(KERN_WARNING "%sLeaving do_magic_suspend_2...\n", name_suspend);	
@@ -1037,6 +1049,7 @@
 	return 0;
 #endif
 	printk(KERN_CRIT "%sWarning %s: Fixing swap signatures unimplemented...\n", name_resume, resume_file);
+	return 0;
 }
 
 extern kdev_t __init name_to_kdev_t(const char *line);

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
