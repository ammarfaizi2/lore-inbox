Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293656AbSCKMmY>; Mon, 11 Mar 2002 07:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293724AbSCKMmR>; Mon, 11 Mar 2002 07:42:17 -0500
Received: from [195.63.194.11] ([195.63.194.11]:32518 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S293656AbSCKMmD>; Mon, 11 Mar 2002 07:42:03 -0500
Message-ID: <3C8CA5D8.50203@evision-ventures.com>
Date: Mon, 11 Mar 2002 13:40:56 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.6 IDE 19
In-Reply-To: <Pine.LNX.4.33.0202220901470.6365-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------010702090808090704040903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010702090808090704040903
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


- Fix oversight in replacement of sti() cli() pairs for data structure 
access
   protection. This finally resolvs my problems with the 2.5.6 kernel 
series.
   Now I'm in fact quite puzzled how it was even possible for the system 
to get
   into the init stage without this fix..

- Fix usage of CONFIG_BLK_DEV_IDE_MODULES instead of 
CONFIG_BLK_DEV_IDE_MODULE.

- Make idescsi_init global for usage in systems without module support 
enabled.

- Apply Pavels Macheks patch for suspend support. Whatever some persons 
argue
   that it's not fully implemented, I think that we are in development 
series
   right now.  I don't buy the mock-up examples for problems with either
   outdated or broken hardware. Micro Drives are for example expected to 
be drop
   in replacements for CF cards in digital cameras and I would rather expect
   them to be very tolerant about the driver in front of them. And then 
the WB
   caches of IDE devices are not caches in the sense of a MESI cache, 
they are
   more like buffer caches and should therefore flush them self after s 
short
   period of inactivity without the application of any special flush 
command.
   The upcomming explicit flushing commands in the ATA standard are 
about data
   integrity guarantees in high reliability systems, like DB servers for 
example,
   and not about simple cache validity.

- Apply Vojtech Pavliks fix to the VIA host chip initialization code.

- Add missing if-defs around PIO timing tables.

- Fix max() min() related compile warnings in IDE-scsi.

OK thin on top of patch 18 this is actually useful.

--------------010702090808090704040903
Content-Type: text/plain;
 name="ide-clean-19.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-19.diff"

diff -urN linux-2.5.6/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.6/drivers/ide/ide-disk.c	Fri Mar  8 03:18:04 2002
+++ linux/drivers/ide/ide-disk.c	Mon Mar 11 12:50:44 2002
@@ -117,6 +117,8 @@
  */
 static ide_startstop_t do_rw_disk (ide_drive_t *drive, struct request *rq, unsigned long block)
 {
+	if (drive->blocked)
+		panic("ide: Request while drive blocked? You don't like your data intact?");
 	if (!(rq->flags & REQ_CMD)) {
 		blk_dump_rq_flags(rq, "do_rw_disk, bad command");
 		ide_end_request(drive, 0);
@@ -903,13 +905,36 @@
 	ide_add_setting(drive,	"max_failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->max_failures,		NULL);
 }
 
+static int idedisk_suspend(struct device *dev, u32 state, u32 level)
+{
+	int i;
+	ide_drive_t *drive = dev->driver_data;
+
+	printk("ide_disk_suspend()\n");
+	while (HWGROUP(drive)->handler)
+		schedule();
+	drive->blocked = 1;
+}
+
+static int idedisk_resume(struct device *dev, u32 level)
+{
+	ide_drive_t *drive = dev->driver_data;
+	if (!drive->blocked)
+		panic("ide: Resume but not suspended?\n");
+	drive->blocked = 0;
+}
+
+
 /* This is just a hook for the overall driver tree.
  *
  * FIXME: This is soon goig to replace the custom linked list games played up
  * to great extend between the different components of the IDE drivers.
  */
 
-static struct device_driver idedisk_devdrv = {};
+static struct device_driver idedisk_devdrv = {
+	suspend: idedisk_suspend,
+	resume: idedisk_resume,
+};
 
 static void idedisk_setup(ide_drive_t *drive)
 {
@@ -956,6 +981,7 @@
 	    sprintf(drive->device.name, "ide-disk");
 	    drive->device.driver = &idedisk_devdrv;
 	    drive->device.parent = &HWIF(drive)->device;
+	    drive->device.driver_data = drive;
 	    device_register(&drive->device);
 	}
 
diff -urN linux-2.5.6/drivers/ide/ide-pci.c linux/drivers/ide/ide-pci.c
--- linux-2.5.6/drivers/ide/ide-pci.c	Mon Mar 11 13:05:59 2002
+++ linux/drivers/ide/ide-pci.c	Mon Mar 11 02:44:27 2002
@@ -35,6 +35,7 @@
  */
 
 #define	ATA_PCI_IGNORE	((void *)-1)
+#define IDE_NO_DRIVER	((void *)-2)
 
 #ifdef CONFIG_BLK_DEV_AEC62XX
 extern unsigned int pci_init_aec62xx(struct pci_dev *);
@@ -313,7 +314,7 @@
 	{PCI_VENDOR_ID_UMC, PCI_DEVICE_ID_UMC_UM8886A, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, ATA_F_FIXIRQ },
 	{PCI_VENDOR_ID_UMC, PCI_DEVICE_ID_UMC_UM8886BF, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, ATA_F_FIXIRQ },
 	{PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C561, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, ATA_F_NOADMA },
-	{PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT366, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 240, ATA_F_IRQ | ATA_F_HPTHACK },
+	{PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT366, NULL, NULL, IDE_NO_DRIVER, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 240, ATA_F_IRQ | ATA_F_HPTHACK },
 	{0, 0, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0 }};
 
 /*
@@ -682,6 +683,11 @@
 		autodma = 1;
 #endif
 
+	if (d->init_hwif == IDE_NO_DRIVER) {
+		printk(KERN_WARNING "%s: detected chipset, but driver not compiled in!\n", dev->name);
+		d->init_hwif = NULL;
+	}
+
 	if (pci_enable_device(dev)) {
 		printk(KERN_WARNING "%s: Could not enable PCI device.\n", dev->name);
 		return;
@@ -916,15 +922,17 @@
 	}
 }
 
-void __init ide_scan_pcibus (int scan_direction)
+void __init ide_scan_pcibus(int scan_direction)
 {
 	struct pci_dev *dev;
 
 	if (!scan_direction) {
-		pci_for_each_dev(dev)
+		pci_for_each_dev(dev) {
 			scan_pcidev(dev);
+		}
 	} else {
-		pci_for_each_dev_reverse(dev)
+		pci_for_each_dev_reverse(dev) {
 			scan_pcidev(dev);
+		}
 	}
 }
diff -urN linux-2.5.6/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux-2.5.6/drivers/ide/ide-probe.c	Mon Mar 11 13:05:59 2002
+++ linux/drivers/ide/ide-probe.c	Mon Mar 11 02:43:32 2002
@@ -575,7 +575,7 @@
 static void ide_init_queue(ide_drive_t *drive)
 {
 	request_queue_t *q = &drive->queue;
-	int max_sectors;
+	int max_sectors = 255;
 
 	q->queuedata = HWGROUP(drive);
 	blk_init_queue(q, do_ide_request, &ide_lock);
@@ -585,9 +585,6 @@
 #ifdef CONFIG_BLK_DEV_PDC4030
 	if (HWIF(drive)->chipset == ide_pdc4030)
 		max_sectors = 127;
-	else
-#else
-		max_sectors = 255;
 #endif
 	blk_queue_max_sectors(q, max_sectors);
 
diff -urN linux-2.5.6/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.6/drivers/ide/ide.c	Mon Mar 11 13:05:59 2002
+++ linux/drivers/ide/ide.c	Mon Mar 11 12:56:00 2002
@@ -194,6 +194,7 @@
 extern void pnpide_init(int);
 #endif
 
+#ifdef CONFIG_BLK_DEV_IDE_MODES
 /*
  * Constant tables for PIO mode programming:
  */
@@ -282,6 +283,7 @@
         { "QUANTUM FIREBALL_1280", 3 },
 	{ NULL,	0 }
 };
+#endif
 
 /* default maximum number of failures */
 #define IDE_DEFAULT_MAX_FAILURES	1
@@ -314,7 +316,7 @@
  */
 ide_hwif_t ide_hwifs[MAX_HWIFS];	/* master data repository */
 
-
+#ifdef CONFIG_BLK_DEV_IDE_MODES
 /*
  * This routine searches the ide_pio_blacklist for an entry
  * matching the start/whole of the supplied model name.
@@ -332,6 +334,7 @@
 	}
 	return -1;
 }
+#endif
 
 /*
  * This routine returns the recommended PIO settings for a given drive,
@@ -445,7 +448,7 @@
 /*
  * Do not even *think* about calling this!
  */
-static void init_hwif_data(ide_hwif_t *hwif, int index)
+static void init_hwif_data(ide_hwif_t *hwif, unsigned int index)
 {
 	static const byte ide_major[] = {
 		IDE0_MAJOR, IDE1_MAJOR, IDE2_MAJOR, IDE3_MAJOR, IDE4_MAJOR,
@@ -1866,7 +1869,7 @@
  * get_info_ptr() returns the (ide_drive_t *) for a given device number.
  * It returns NULL if the given device number does not match any present drives.
  */
-ide_drive_t *get_info_ptr (kdev_t i_rdev)
+ide_drive_t *get_info_ptr(kdev_t i_rdev)
 {
 	unsigned int major = major(i_rdev);
 	int h;
@@ -2174,8 +2177,7 @@
 	unsigned int p, minor;
 	ide_hwif_t old_hwif;
 
-	save_flags(flags);	/* all CPUs */
-	cli();			/* all CPUs */
+	spin_lock_irqsave(&ide_lock, flags);
 	if (!hwif->present)
 		goto abort;
 	put_device(&hwif->device);
@@ -2198,7 +2200,7 @@
 	/*
 	 * All clear?  Then blow away the buffer cache
 	 */
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_unlock_irqrestore(&ide_lock, flags);
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		drive = &hwif->drives[unit];
 		if (!drive->present)
@@ -2210,13 +2212,11 @@
 				invalidate_device(devp, 0);
 			}
 		}
-
 	}
-
 #ifdef CONFIG_PROC_FS
 	destroy_proc_ide_drives(hwif);
 #endif
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_lock_irqsave(&ide_lock, flags);
 	hwgroup = hwif->hwgroup;
 
 	/*
@@ -2330,7 +2330,7 @@
 #endif
 	hwif->straight8		= old_hwif.straight8;
 abort:
-	restore_flags(flags);	/* all CPUs */
+	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
 /*
@@ -2375,23 +2375,23 @@
  */
 int ide_register_hw(hw_regs_t *hw, ide_hwif_t **hwifp)
 {
-	int index, retry = 1;
+	int h, retry = 1;
 	ide_hwif_t *hwif;
 
 	do {
-		for (index = 0; index < MAX_HWIFS; ++index) {
-			hwif = &ide_hwifs[index];
+		for (h = 0; h < MAX_HWIFS; ++h) {
+			hwif = &ide_hwifs[h];
 			if (hwif->hw.io_ports[IDE_DATA_OFFSET] == hw->io_ports[IDE_DATA_OFFSET])
 				goto found;
 		}
-		for (index = 0; index < MAX_HWIFS; ++index) {
-			hwif = &ide_hwifs[index];
+		for (h = 0; h < MAX_HWIFS; ++h) {
+			hwif = &ide_hwifs[h];
 			if ((!hwif->present && !hwif->mate && !initializing) ||
 			    (!hwif->hw.io_ports[IDE_DATA_OFFSET] && initializing))
 				goto found;
 		}
-		for (index = 0; index < MAX_HWIFS; index++)
-			ide_unregister(&ide_hwifs[index]);
+		for (h = 0; h < MAX_HWIFS; ++h)
+			ide_unregister(&ide_hwifs[h]);
 	} while (retry--);
 	return -1;
 found:
@@ -2415,7 +2415,7 @@
 	if (hwifp)
 		*hwifp = hwif;
 
-	return (initializing || hwif->present) ? index : -1;
+	return (initializing || hwif->present) ? h : -1;
 }
 
 /*
@@ -3476,6 +3476,7 @@
 
 EXPORT_SYMBOL(ide_lock);
 EXPORT_SYMBOL(drive_is_flashcard);
+EXPORT_SYMBOL(ide_timer_expiry);
 EXPORT_SYMBOL(ide_intr);
 EXPORT_SYMBOL(ide_get_queue);
 EXPORT_SYMBOL(ide_add_generic_settings);
@@ -3651,7 +3652,7 @@
 	pnpide_init(1);
 #endif
 
-#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULES)
+#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
 # if defined(__mc68000__) || defined(CONFIG_APUS)
 	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET]) {
 		ide_get_lock(&ide_intr_lock, NULL, NULL);/* for atari only */
diff -urN linux-2.5.6/drivers/ide/via82cxxx.c linux/drivers/ide/via82cxxx.c
--- linux-2.5.6/drivers/ide/via82cxxx.c	Fri Mar  8 03:18:22 2002
+++ linux/drivers/ide/via82cxxx.c	Mon Mar 11 12:48:51 2002
@@ -1,5 +1,5 @@
 /*
- * $Id: via82cxxx.c,v 3.33 2001/12/23 22:46:12 vojtech Exp $
+ * $Id: via82cxxx.c,v 3.34 2002/02/12 11:26:11 vojtech Exp $
  *
  *  Copyright (c) 2000-2001 Vojtech Pavlik
  *
@@ -163,7 +163,7 @@
 
 	via_print("----------VIA BusMastering IDE Configuration----------------");
 
-	via_print("Driver Version:                     3.33");
+	via_print("Driver Version:                     3.34");
 	via_print("South Bridge:                       VIA %s", via_config->name);
 
 	pci_read_config_byte(isa_dev, PCI_REVISION_ID, &t);
@@ -495,7 +495,7 @@
 	if (via_clock < 20000 || via_clock > 50000) {
 		printk(KERN_WARNING "VP_IDE: User given PCI clock speed impossible (%d), using 33 MHz instead.\n", via_clock);
 		printk(KERN_WARNING "VP_IDE: Use ide0=ata66 if you want to assume 80-wire cable.\n");
-		via_clock = 33;
+		via_clock = 33333;
 	}
 
 /*
diff -urN linux-2.5.6/drivers/scsi/ide-scsi.c linux/drivers/scsi/ide-scsi.c
--- linux-2.5.6/drivers/scsi/ide-scsi.c	Fri Mar  8 03:18:06 2002
+++ linux/drivers/scsi/ide-scsi.c	Mon Mar 11 12:47:42 2002
@@ -290,7 +290,7 @@
 			if (!test_bit(PC_WRITING, &pc->flags) && pc->actually_transferred && pc->actually_transferred <= 1024 && pc->buffer) {
 				printk(", rst = ");
 				scsi_buf = pc->scsi_cmd->request_buffer;
-				hexdump(scsi_buf, min(16, pc->scsi_cmd->request_bufflen));
+				hexdump(scsi_buf, min(16U, pc->scsi_cmd->request_bufflen));
 			} else printk("\n");
 		}
 	}
@@ -307,7 +307,7 @@
 
 static inline unsigned long get_timeout(idescsi_pc_t *pc)
 {
-	return max(WAIT_CMD, pc->timeout - jiffies);
+	return max((unsigned long) WAIT_CMD, pc->timeout - jiffies);
 }
 
 /*
@@ -565,7 +565,7 @@
 /*
  *	idescsi_init will register the driver for each scsi.
  */
-static int idescsi_init(void)
+int idescsi_init(void)
 {
 	ide_drive_t *drive;
 	idescsi_scsi_t *scsi;
diff -urN linux-2.5.6/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.6/include/linux/ide.h	Mon Mar 11 13:05:59 2002
+++ linux/include/linux/ide.h	Mon Mar 11 12:50:44 2002
@@ -240,10 +240,6 @@
 } hw_regs_t;
 
 /*
- * Register new hardware with ide
- */
-extern int ide_register_hw(hw_regs_t *hw, struct hwif_s **hwifp);
-/*
  * Set up hw_regs_t structure before calling ide_register_hw (optional)
  */
 void ide_setup_ports(hw_regs_t *hw,
@@ -336,6 +332,7 @@
 	unsigned autotune	: 2;	/* 1=autotune, 2=noautotune, 0=default */
 	unsigned remap_0_to_1	: 2;	/* 0=remap if ezdrive, 1=remap, 2=noremap */
 	unsigned ata_flash	: 1;	/* 1=present, 0=default */
+	unsigned blocked        : 1;	/* 1=powermanagment told us not to do anything, so sleep nicely */
 	unsigned	addressing;	/* : 2; 0=28-bit, 1=48-bit, 2=64-bit */
 	byte		scsi;		/* 0=default, 1=skip current ide-subdriver for ide-scsi emulation */
 	select_t	select;		/* basic drive/head select reg value */
@@ -505,6 +502,10 @@
 	struct device	device;		/* global device tree handle */
 } ide_hwif_t;
 
+/*
+ * Register new hardware with ide
+ */
+extern int ide_register_hw(hw_regs_t *hw, struct hwif_s **hwifp);
 extern void ide_unregister(ide_hwif_t *hwif);
 
 /*

--------------010702090808090704040903--

