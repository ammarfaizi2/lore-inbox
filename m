Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313131AbSECOCy>; Fri, 3 May 2002 10:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313161AbSECOCx>; Fri, 3 May 2002 10:02:53 -0400
Received: from [195.63.194.11] ([195.63.194.11]:47887 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313131AbSECOCp>; Fri, 3 May 2002 10:02:45 -0400
Message-ID: <3CD289CE.2070900@evision-ventures.com>
Date: Fri, 03 May 2002 14:59:58 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.13 IDE 50
In-Reply-To: <Pine.LNX.4.33.0203181243210.10517-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------010600010908030205050500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010600010908030205050500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Thu May  2 11:53:59 CEST 2002 ide-clean-50

Sync up with 2.5.13.

- Fix wrong usage of time_after in ide.c. This should cure the drive seek
   timeout problems some people where expierencing. This was clarified to me by
   Bartek, who apparently checked whatever the actual code is consistent with
   the comments in front of it. Thank you Bartlomiej Zolnierkiewicz.

   I think now that we should have time_past(xxx) in <linux/timer.h>.

- Fix hpt34x.c compilation.

- Minor improvements in ide-pci and some cleanups in ide-probe.c

- Nuke some vastly outdated comments.

--------------010600010908030205050500
Content-Type: text/plain;
 name="ide-clean-50.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-50.diff"

diff -urN linux-2.5.13/drivers/ide/hpt34x.c linux/drivers/ide/hpt34x.c
--- linux-2.5.13/drivers/ide/hpt34x.c	2002-05-03 02:22:41.000000000 +0200
+++ linux/drivers/ide/hpt34x.c	2002-05-03 13:32:07.000000000 +0200
@@ -249,14 +249,14 @@
 						     ide_dma_off_quietly);
 }
 
-static int config_drive_xfer_rate (ide_drive_t *drive)
+static int config_drive_xfer_rate(struct ata_device *drive, struct request *rq)
 {
 	struct hd_driveid *id = drive->id;
 	ide_dma_action_t dma_func = ide_dma_on;
 
 	if (id && (id->capability & 1) && drive->channel->autodma) {
 		/* Consult the list of known "bad" drives */
-		if (ide_dmaproc(ide_dma_bad_drive, drive)) {
+		if (ide_dmaproc(ide_dma_bad_drive, drive, rq)) {
 			dma_func = ide_dma_off;
 			goto fast_ata_pio;
 		}
@@ -278,7 +278,7 @@
 				if (dma_func != ide_dma_on)
 					goto no_dma_set;
 			}
-		} else if (ide_dmaproc(ide_dma_good_drive, drive)) {
+		} else if (ide_dmaproc(ide_dma_good_drive, drive, rq)) {
 			if (id->eide_dma_time > 150) {
 				goto no_dma_set;
 			}
@@ -301,7 +301,7 @@
 		dma_func = ide_dma_off;
 #endif /* CONFIG_HPT34X_AUTODMA */
 
-	return drive->channel->dmaproc(dma_func, drive);
+	return drive->channel->udma(dma_func, drive, rq);
 }
 
 /*
@@ -312,7 +312,7 @@
  * by HighPoint|Triones Technologies, Inc.
  */
 
-int hpt34x_dmaproc (ide_dma_action_t func, ide_drive_t *drive)
+int hpt34x_dmaproc (ide_dma_action_t func, struct ata_device *drive, struct request *rq)
 {
 	struct ata_channel *hwif = drive->channel;
 	unsigned long dma_base = hwif->dma_base;
@@ -321,7 +321,7 @@
 
 	switch (func) {
 		case ide_dma_check:
-			return config_drive_xfer_rate(drive);
+			return config_drive_xfer_rate(drive, rq);
 		case ide_dma_read:
 			reading = 1 << 3;
 		case ide_dma_write:
@@ -347,7 +347,7 @@
 		default:
 			break;
 	}
-	return ide_dmaproc(func, drive);	/* use standard DMA stuff */
+	return ide_dmaproc(func, drive, rq);	/* use standard DMA stuff */
 }
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 
@@ -423,7 +423,7 @@
 		else
 			hwif->autodma = 0;
 
-		hwif->dmaproc = &hpt34x_dmaproc;
+		hwif->udma = &hpt34x_dmaproc;
 		hwif->highmem = 1;
 	} else {
 		hwif->drives[0].autotune = 1;
diff -urN linux-2.5.13/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.13/drivers/ide/ide.c	2002-05-03 02:22:52.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-05-03 13:29:23.000000000 +0200
@@ -1,15 +1,19 @@
-/*
- *  Copyright (C) 1994-1998  Linus Torvalds & authors (see below)
+/**** vi:set ts=8 sts=8 sw=8:************************************************
+ *
+ *  Copyright (C) 1994-1998,2002  Linus Torvalds and authors:
  *
- *  Mostly written by Mark Lord  <mlord@pobox.com>
- *                and Gadi Oxman <gadio@netvision.net.il>
- *                and Andre Hedrick <andre@linux-ide.org>
+ *	Mark Lord	<mlord@pobox.com>
+ *      Gadi Oxman	<gadio@netvision.net.il>
+ *      Andre Hedrick	<andre@linux-ide.org>
+ *	Jens Axboe	<axboe@suse.de>
+ *      Marcin Dalecki	<martin@dalecki.de>
  *
  *  See linux/MAINTAINERS for address of current maintainer.
  *
- * This is the multiple IDE interface driver, as evolved from hd.c.
- * It supports up to MAX_HWIFS IDE interfaces, on one or more IRQs (usually 14 & 15).
- * There can be up to two drives per interface, as per the ATA-2 spec.
+ * This is the basic common code of the ATA interface drivers.
+ *
+ * It supports up to MAX_HWIFS IDE interfaces, on one or more IRQs (usually 14
+ * & 15).  There can be up to two drives per interface, as per the ATA-7 spec.
  *
  * Primary:    ide0, port 0x1f0; major=3;  hda is minor=0; hdb is minor=64
  * Secondary:  ide1, port 0x170; major=22; hdc is minor=0; hdd is minor=64
@@ -17,102 +21,15 @@
  * Quaternary: ide3, port 0x???; major=34; hdg is minor=0; hdh is minor=64
  * ...
  *
- *  From hd.c:
- *  |
- *  | It traverses the request-list, using interrupts to jump between functions.
- *  | As nearly all functions can be called within interrupts, we may not sleep.
- *  | Special care is recommended.  Have Fun!
- *  |
- *  | modified by Drew Eckhardt to check nr of hd's from the CMOS.
- *  |
- *  | Thanks to Branko Lankester, lankeste@fwi.uva.nl, who found a bug
- *  | in the early extended-partition checks and added DM partitions.
- *  |
- *  | Early work on error handling by Mika Liljeberg (liljeber@cs.Helsinki.FI).
- *  |
- *  | IRQ-unmask, drive-id, multiple-mode, support for ">16 heads",
- *  | and general streamlining by Mark Lord (mlord@pobox.com).
- *
- *  October, 1994 -- Complete line-by-line overhaul for linux 1.1.x, by:
- *
- *	Mark Lord	(mlord@pobox.com)		(IDE Perf.Pkg)
- *	Delman Lee	(delman@ieee.org)		("Mr. atdisk2")
- *	Scott Snyder	(snyder@fnald0.fnal.gov)	(ATAPI IDE cd-rom)
- *
- *  This was a rewrite of just about everything from hd.c, though some original
- *  code is still sprinkled about.  Think of it as a major evolution, with
- *  inspiration from lots of linux users, esp.  hamish@zot.apana.org.au
- *
- *  Version 1.0 ALPHA	initial code, primary i/f working okay
- *  Version 1.3 BETA	dual i/f on shared irq tested & working!
- *  Version 1.4 BETA	added auto probing for irq(s)
- *  Version 1.5 BETA	added ALPHA (untested) support for IDE cd-roms,
- *  ...
- * Version 5.50		allow values as small as 20 for idebus=
- * Version 5.51		force non io_32bit in drive_cmd_intr()
- *			change delay_10ms() to delay_50ms() to fix problems
- * Version 5.52		fix incorrect invalidation of removable devices
- *			add "hdx=slow" command line option
- * Version 5.60		start to modularize the driver; the disk and ATAPI
- *			 drivers can be compiled as loadable modules.
- *			move IDE probe code to ide-probe.c
- *			move IDE disk code to ide-disk.c
- *			add support for generic IDE device subdrivers
- *			add m68k code from Geert Uytterhoeven
- *			probe all interfaces by default
- *			add ioctl to (re)probe an interface
- * Version 6.00		use per device request queues
- *			attempt to optimize shared hwgroup performance
- *			add ioctl to manually adjust bandwidth algorithms
- *			add kerneld support for the probe module
- *			fix bug in ide_error()
- *			fix bug in the first ide_get_lock() call for Atari
- *			don't flush leftover data for ATAPI devices
- * Version 6.01		clear hwgroup->active while the hwgroup sleeps
- *			support HDIO_GETGEO for floppies
- * Version 6.02		fix ide_ack_intr() call
- *			check partition table on floppies
- * Version 6.03		handle bad status bit sequencing in ide_wait_stat()
- * Version 6.10		deleted old entries from this list of updates
- *			replaced triton.c with ide-dma.c generic PCI DMA
- *			added support for BIOS-enabled UltraDMA
- *			rename all "promise" things to "pdc4030"
- *			fix EZ-DRIVE handling on small disks
- * Version 6.11		fix probe error in ide_scan_devices()
- *			fix ancient "jiffies" polling bugs
- *			mask all hwgroup interrupts on each irq entry
- * Version 6.12		integrate ioctl and proc interfaces
- *			fix parsing of "idex=" command line parameter
- * Version 6.13		add support for ide4/ide5 courtesy rjones@orchestream.com
- * Version 6.14		fixed IRQ sharing among PCI devices
- * Version 6.15		added SMP awareness to IDE drivers
- * Version 6.16		fixed various bugs; even more SMP friendly
- * Version 6.17		fix for newest EZ-Drive problem
- * Version 6.18		default unpartitioned-disk translation now "BIOS LBA"
- * Version 6.19		Re-design for a UNIFORM driver for all platforms,
- *			  model based on suggestions from Russell King and
- *			  Geert Uytterhoeven
- *			Promise DC4030VL now supported.
- *			add support for ide6/ide7
- *			delay_50ms() changed to ide_delay_50ms() and exported.
- * Version 6.20		Added/Fixed Generic ATA-66 support and hwif detection.
- *			Added hdx=flash to allow for second flash disk
- *			  detection w/o the hang loop.
- *			Added support for ide8/ide9
- *			Added idex=ata66 for the quirky chipsets that are
- *			  ATA-66 compliant, but have yet to determine a method
- *			  of verification of the 80c cable presence.
- *			  Specifically Promise's PDC20262 chipset.
- * Version 6.21		Fixing/Fixed SMP spinlock issue with insight from an old
- *			  hat that clarified original low level driver design.
- * Version 6.30		Added SMP support; fixed multmode issues.  -ml
- * Version 6.31		Debug Share INTR's and request queue streaming
- *			Native ATA-100 support
- *			Prep for Cascades Project
- * Version 6.32		4GB highmem support for DMA, and mapping of those for
- *			PIO transfer (Jens Axboe)
+ *  Contributors:
+ *
+ *	Drew Eckhardt
+ *	Branko Lankester	<lankeste@fwi.uva.nl>
+ *	Mika Liljeberg
+ *	Delman Lee		<delman@ieee.org>
+ *	Scott Snyder		<snyder@fnald0.fnal.gov>
  *
- *  Some additional driver compile-time options are in ./include/linux/ide.h
+ *  Some additional driver compile-time options are in <linux/ide.h>
  */
 
 #define	VERSION	"7.0.0"
@@ -253,10 +170,7 @@
 #endif
 }
 
-/*
- * Do not even *think* about calling this!
- */
-static void init_hwif_data(struct ata_channel *hwif, unsigned int index)
+static void init_hwif_data(struct ata_channel *ch, unsigned int index)
 {
 	static const byte ide_major[] = {
 		IDE0_MAJOR, IDE1_MAJOR, IDE2_MAJOR, IDE3_MAJOR, IDE4_MAJOR,
@@ -266,30 +180,30 @@
 	unsigned int unit;
 	hw_regs_t hw;
 
-	/* bulk initialize hwif & drive info with zeros */
-	memset(hwif, 0, sizeof(struct ata_channel));
+	/* bulk initialize channel & drive info with zeros */
+	memset(ch, 0, sizeof(struct ata_channel));
 	memset(&hw, 0, sizeof(hw_regs_t));
 
 	/* fill in any non-zero initial values */
-	hwif->index     = index;
-	ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, &hwif->irq);
-	memcpy(&hwif->hw, &hw, sizeof(hw));
-	memcpy(hwif->io_ports, hw.io_ports, sizeof(hw.io_ports));
-	hwif->noprobe	= !hwif->io_ports[IDE_DATA_OFFSET];
+	ch->index     = index;
+	ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, &ch->irq);
+	memcpy(&ch->hw, &hw, sizeof(hw));
+	memcpy(ch->io_ports, hw.io_ports, sizeof(hw.io_ports));
+	ch->noprobe	= !ch->io_ports[IDE_DATA_OFFSET];
 #ifdef CONFIG_BLK_DEV_HD
-	if (hwif->io_ports[IDE_DATA_OFFSET] == HD_DATA)
-		hwif->noprobe = 1; /* may be overridden by ide_setup() */
+	if (ch->io_ports[IDE_DATA_OFFSET] == HD_DATA)
+		ch->noprobe = 1; /* may be overridden by ide_setup() */
 #endif /* CONFIG_BLK_DEV_HD */
-	hwif->major = ide_major[index];
-	sprintf(hwif->name, "ide%d", index);
-	hwif->bus_state = BUSSTATE_ON;
+	ch->major = ide_major[index];
+	sprintf(ch->name, "ide%d", index);
+	ch->bus_state = BUSSTATE_ON;
 
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
-		struct ata_device *drive = &hwif->drives[unit];
+		struct ata_device *drive = &ch->drives[unit];
 
 		drive->type			= ATA_DISK;
 		drive->select.all		= (unit<<4)|0xa0;
-		drive->channel			= hwif;
+		drive->channel			= ch;
 		drive->ctl			= 0x08;
 		drive->ready_stat		= READY_STAT;
 		drive->bad_wstat		= BAD_W_STAT;
@@ -1258,7 +1172,7 @@
 
 			/* This device still wants to remain idle.
 			 */
-			if (drive->sleep && time_after(jiffies, drive->sleep))
+			if (drive->sleep && time_after(drive->sleep, jiffies))
 				continue;
 
 			/* Take this device, if there is no device choosen thus far or
@@ -1285,8 +1199,8 @@
 		 * want to hog the cpu too much.
 		 */
 
-		if (0 < (signed long)(jiffies + WAIT_MIN_SLEEP - sleep))
-		    sleep = jiffies + WAIT_MIN_SLEEP;
+		if (time_after(jiffies, sleep - WAIT_MIN_SLEEP))
+			sleep = jiffies + WAIT_MIN_SLEEP;
 #if 1
 		if (timer_pending(&channel->hwgroup->timer))
 			printk(KERN_ERR "ide_set_handler: timer already active\n");
@@ -2861,7 +2775,7 @@
  * "hdx=flash"		: allows for more than one ata_flash disk to be
  *				registered. In most cases, only one device
  *				will be present.
- * "hdx=scsi"		: the return of the ide-scsi flag, this is useful for
+ * "hdx=ide-scsi"	: the return of the ide-scsi flag, this is useful for
  *				allowwing ide-floppy, ide-tape, and ide-cdrom|writers
  *				to use ide-scsi emulation on a device specific option.
  * "idebus=xx"		: inform IDE driver of VESA/PCI bus speed in MHz,
@@ -2928,14 +2842,14 @@
 	    strncmp(s,"hd",2))		/* hdx= & hdxlun= */
 		return 0;
 
-	printk("ide_setup: %s", s);
+	printk(KERN_INFO  "ide_setup: %s", s);
 	init_ide_data ();
 
 #ifdef CONFIG_BLK_DEV_IDEDOUBLER
 	if (!strcmp(s, "ide=doubler")) {
 		extern int ide_doubler;
 
-		printk(" : Enabled support for IDE doublers\n");
+		printk(KERN_INFO" : Enabled support for IDE doublers\n");
 		ide_doubler = 1;
 
 		return 1;
@@ -2943,7 +2857,7 @@
 #endif
 
 	if (!strcmp(s, "ide=nodma")) {
-		printk("IDE: Prevented DMA\n");
+		printk(KERN_INFO "ATA: Prevented DMA\n");
 		noautodma = 1;
 
 		return 1;
@@ -3497,7 +3411,7 @@
 {
 	int h;
 
-	printk(KERN_INFO "Uniform Multi-Platform E-IDE driver ver.:" VERSION "\n");
+	printk(KERN_INFO "ATA/ATAPI driver v" VERSION "\n");
 
 	ide_devfs_handle = devfs_mk_dir (NULL, "ide", NULL);
 
@@ -3519,7 +3433,7 @@
 	    system_bus_speed = 33;
 #endif
 
-	printk("ide: system bus speed %dMHz\n", system_bus_speed);
+	printk(KERN_INFO "ATA: system bus speed %dMHz\n", system_bus_speed);
 
 	init_ide_data ();
 
@@ -3640,27 +3554,23 @@
 MODULE_PARM(options,"s");
 MODULE_LICENSE("GPL");
 
-static void __init parse_options (char *line)
+static int __init init_ata(void)
 {
-	char *next = line;
 
-	if (line == NULL || !*line)
-		return;
-	while ((line = next) != NULL) {
-		if ((next = strchr(line,' ')) != NULL)
-			*next++ = 0;
-		if (!ide_setup(line))
-			printk ("Unknown option '%s'\n", line);
-	}
-}
+	if (options != NULL && *options) {
+		char *next = options;
 
-static int __init init_ata (void)
-{
-	parse_options(options);
+		while ((options = next) != NULL) {
+			if ((next = strchr(options,' ')) != NULL)
+				*next++ = 0;
+			if (!ide_setup(options))
+				printk(KERN_ERR "Unknown option '%s'\n", options);
+		}
+	}
 	return ata_module_init();
 }
 
-static void __exit cleanup_ata (void)
+static void __exit cleanup_ata(void)
 {
 	int h;
 
diff -urN linux-2.5.13/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.13/drivers/ide/ide-disk.c	2002-05-03 02:22:38.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2002-05-03 13:29:23.000000000 +0200
@@ -1,11 +1,12 @@
-/*
- *  Copyright (C) 1994-1998  Linus Torvalds and authors:
+/***** vi:set ts=8 sts=8 sw=8:************************************************
+ *
+ *  Copyright (C) 1994-1998,2002  Linus Torvalds and authors:
  *
- *	Mark Lord <mlord@pobox.com>
- *	Gadi Oxman <gadio@netvision.net.il>
- *	Andre Hedrick <andre@linux-ide.org>
- *	Jens Axboe <axboe@suse.de>
- *	Marcin Dalecki <dalecki@evision.ag>
+ *	Mark Lord	<mlord@pobox.com>
+ *	Gadi Oxman	<gadio@netvision.net.il>
+ *	Andre Hedrick	<andre@linux-ide.org>
+ *	Jens Axboe	<axboe@suse.de>
+ *	Marcin Dalecki	<martin@dalecki.de>
  *
  * This is the ATA disk device driver, as evolved from hd.c and ide.c.
  */
diff -urN linux-2.5.13/drivers/ide/ide-pci.c linux/drivers/ide/ide-pci.c
--- linux-2.5.13/drivers/ide/ide-pci.c	2002-05-03 02:22:56.000000000 +0200
+++ linux/drivers/ide/ide-pci.c	2002-05-03 14:19:57.000000000 +0200
@@ -1,6 +1,8 @@
-/*
- *  Copyright (c) 1998-2000  Andre Hedrick <andre@linux-ide.org>
- *  Copyright (c) 1995-1998  Mark Lord
+/**** vi:set ts=8 sts=8 sw=8:************************************************
+ *
+ *  Copyright (C) 2002	     Marcin Dalecki <martin@dalecki.de>
+ *  Copyright (C) 1998-2000  Andre Hedrick <andre@linux-ide.org>
+ *  Copyright (C) 1995-1998  Mark Lord
  *
  *  May be copied or modified under the terms of the GNU General Public License
  */
@@ -81,17 +83,10 @@
 #endif
 
 #ifdef CONFIG_BLK_DEV_HPT366
-extern byte hpt363_shared_irq;
-extern byte hpt363_shared_pin;
-
 extern unsigned int pci_init_hpt366(struct pci_dev *);
 extern unsigned int ata66_hpt366(struct ata_channel *);
 extern void ide_init_hpt366(struct ata_channel *);
 extern void ide_dmacapable_hpt366(struct ata_channel *, unsigned long);
-#else
-/* FIXME: those have to be killed */
-static byte hpt363_shared_irq;
-static byte hpt363_shared_pin;
 #endif
 
 #ifdef CONFIG_BLK_DEV_NS87415
@@ -177,7 +172,7 @@
 #define ATA_F_PHACK	0x40	/* apply PROMISE hacks */
 #define ATA_F_HPTHACK	0x80	/* apply HPT366 hacks */
 
-typedef struct ide_pci_device_s {
+struct ata_pci_device {
 	unsigned short		vendor;
 	unsigned short		device;
 	unsigned int		(*init_chipset)(struct pci_dev *dev);
@@ -188,9 +183,9 @@
 	unsigned int		bootable;
 	unsigned int		extra;
 	unsigned int		flags;
-} ide_pci_device_t;
+};
 
-static ide_pci_device_t pci_chipsets[] __initdata = {
+static struct ata_pci_device pci_chipsets[] __initdata = {
 #ifdef CONFIG_BLK_DEV_PIIX
 	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371FB_1, pci_init_piix, ata66_piix, ide_init_piix, ide_dmacapable_piix, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
 	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371SB_1, pci_init_piix, ata66_piix, ide_init_piix, ide_dmacapable_piix, {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, ON_BOARD, 0, 0 },
@@ -319,7 +314,7 @@
  * settings of split-mirror pci-config space, place chipset into init-mode,
  * and/or preserve an interrupt if the card is not native ide support.
  */
-static unsigned int __init trust_pci_irq(ide_pci_device_t *d, struct pci_dev *dev)
+static unsigned int __init trust_pci_irq(struct ata_pci_device *d, struct pci_dev *dev)
 {
 	if (d->flags & ATA_F_IRQ)
 		return dev->irq;
@@ -484,7 +479,7 @@
  * Setup DMA transfers on a channel.
  */
 static void __init setup_channel_dma(struct ata_channel *hwif, struct pci_dev *dev,
-		ide_pci_device_t *d,
+		struct ata_pci_device *d,
 		int port,
 		u8 class_rev,
 		int pciirq,
@@ -534,7 +529,7 @@
  * This gets called once for the master and for the slave interface.
  */
 static int __init setup_host_channel(struct pci_dev *dev,
-		ide_pci_device_t *d,
+		struct ata_pci_device *d,
 		int port,
 		u8 class_rev,
 		int pciirq,
@@ -648,17 +643,16 @@
 }
 
 /*
- * Looks at the primary/secondary channels on a PCI IDE device and, if they
- * are enabled, prepares the IDE driver for use with them.  This generic code
- * works for most PCI chipsets.
+ * Looks at the primary/secondary channels on a PCI IDE device and, if they are
+ * enabled, prepares the IDE driver for use with them.  This generic code works
+ * for most PCI chipsets.
  *
  * One thing that is not standardized is the location of the primary/secondary
  * interface "enable/disable" bits.  For chipsets that we "know" about, this
- * information is in the ide_pci_device_t struct; for all other chipsets, we
- * just assume both interfaces are enabled.
+ * information is in the struct ata_pci_device struct; for all other chipsets,
+ * we just assume both interfaces are enabled.
  */
-
-static void __init setup_pci_device(struct pci_dev *dev, ide_pci_device_t *d)
+static void __init setup_pci_device(struct pci_dev *dev, struct ata_pci_device *d)
 {
 	int autodma = 0;
 	int pciirq = 0;
@@ -775,10 +769,11 @@
 	setup_host_channel(dev, d, ATA_SECONDARY, class_rev, pciirq, autodma, &pcicmd);
 }
 
-static void __init pdc20270_device_order_fixup (struct pci_dev *dev, ide_pci_device_t *d)
+static void __init pdc20270_device_order_fixup (struct pci_dev *dev, struct ata_pci_device *d)
 {
-	struct pci_dev *dev2 = NULL, *findev;
-	ide_pci_device_t *d2;
+	struct pci_dev *dev2 = NULL;
+	struct pci_dev *findev;
+	struct ata_pci_device *d2;
 
 	if (dev->bus->self &&
 	    dev->bus->self->vendor == PCI_VENDOR_ID_DEC &&
@@ -814,10 +809,10 @@
 	setup_pci_device(dev2, d2);
 }
 
-static void __init hpt366_device_order_fixup (struct pci_dev *dev, ide_pci_device_t *d)
+static void __init hpt366_device_order_fixup (struct pci_dev *dev, struct ata_pci_device *d)
 {
 	struct pci_dev *dev2 = NULL, *findev;
-	ide_pci_device_t *d2;
+	struct ata_pci_device *d2;
 	unsigned char pin1 = 0, pin2 = 0;
 	unsigned int class_rev;
 
@@ -843,9 +838,7 @@
 		    (PCI_FUNC(findev->devfn) & 1)) {
 			dev2 = findev;
 			pci_read_config_byte(dev2, PCI_INTERRUPT_PIN, &pin2);
-			hpt363_shared_pin = (pin1 != pin2) ? 1 : 0;
-			hpt363_shared_irq = (dev->irq == dev2->irq) ? 1 : 0;
-			if (hpt363_shared_pin && hpt363_shared_irq) {
+			if ((pin1 != pin2) && (dev->irq == dev2->irq)) {
 				d->bootable = ON_BOARD;
 				printk("%s: onboard version of chipset, pin1=%d pin2=%d\n", dev->name, pin1, pin2);
 			}
@@ -869,7 +862,7 @@
 {
 	unsigned short vendor;
 	unsigned short device;
-	ide_pci_device_t *d;
+	struct ata_pci_device *d;
 
 	vendor = dev->vendor;
 	device = dev->device;
@@ -881,7 +874,7 @@
 		++d;
 
 	if (d->init_channel == ATA_PCI_IGNORE)
-		printk("%s: has been ignored by PCI bus scan\n", dev->name);
+		printk(KERN_INFO "ATA: %s: ignored by PCI bus scan\n", dev->name);
 	else if ((d->vendor == PCI_VENDOR_ID_OPTI && d->device == PCI_DEVICE_ID_OPTI_82C558) && !(PCI_FUNC(dev->devfn) & 1))
 		return;
 	else if ((d->vendor == PCI_VENDOR_ID_CONTAQ && d->device == PCI_DEVICE_ID_CONTAQ_82C693) && (!(PCI_FUNC(dev->devfn) & 1) || !((dev->class >> 8) == PCI_CLASS_STORAGE_IDE)))
@@ -896,10 +889,10 @@
 		pdc20270_device_order_fixup(dev, d);
 	else if (!(d->vendor == 0 && d->device == 0) || (dev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
 		if (d->vendor == 0 && d->device == 0)
-			printk("%s: unknown IDE controller on PCI slot %s, vendor=%04x, device=%04x\n",
-			       dev->name, dev->slot_name, vendor, device);
+			printk(KERN_INFO "ATA: unknown ATA interface %s (%04x:%04x) on PCI slot %s\n",
+			       dev->name, vendor, device, dev->slot_name);
 		else
-			printk("%s: IDE controller on PCI slot %s\n", dev->name, dev->slot_name);
+			printk(KERN_INFO "ATA: interface %s on PCI slot %s\n", dev->name, dev->slot_name);
 		setup_pci_device(dev, d);
 	}
 }
diff -urN linux-2.5.13/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux-2.5.13/drivers/ide/ide-probe.c	2002-05-03 02:22:37.000000000 +0200
+++ linux/drivers/ide/ide-probe.c	2002-05-03 15:18:13.000000000 +0200
@@ -1,4 +1,5 @@
-/*
+/**** vi:set ts=8 sts=8 sw=8:************************************************
+ *
  *  Copyright (C) 1994-1998  Linus Torvalds & authors (see below)
  *
  *  Mostly written by Mark Lord <mlord@pobox.com>
@@ -47,7 +48,7 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
-static inline void do_identify (ide_drive_t *drive, byte cmd)
+static inline void do_identify(struct ata_device *drive, u8 cmd)
 {
 	int bswap = 1;
 	struct hd_driveid *id;
@@ -121,7 +122,7 @@
 	drive->present = 1;
 
 	/*
-	 * Check for an ATAPI device
+	 * Check for an ATAPI device:
 	 */
 	if (cmd == WIN_PIDENTIFY) {
 		byte type = (id->config >> 8) & 0x1f;
@@ -172,7 +173,7 @@
 	}
 
 	/*
-	 * Not an ATAPI device: looks like a "regular" hard disk
+	 * Not an ATAPI device: looks like a "regular" hard disk:
 	 */
 	if (id->config & (1<<7))
 		drive->removable = 1;
@@ -185,7 +186,7 @@
 	 */
 
 	if (drive_is_flashcard(drive)) {
-		ide_drive_t *mate = &drive->channel->drives[1 ^ drive->select.b.unit];
+		struct ata_device *mate = &drive->channel->drives[1 ^ drive->select.b.unit];
 		if (!mate->ata_flash) {
 			mate->present = 0;
 			mate->noprobe = 1;
@@ -204,26 +205,37 @@
 	kfree(id);
 err_kmalloc:
 	drive->present = 0;
+
 	return;
 }
 
 /*
- * try_to_identify() sends an ATA(PI) IDENTIFY request to a drive
- * and waits for a response.  It also monitors irqs while this is
- * happening, in hope of automatically determining which one is
- * being used by the interface.
+ * Sends an ATA(PI) IDENTIFY request to a drive and wait for a response.  It
+ * also monitor irqs while this is happening, in hope of automatically
+ * determining which one is being used by the interface.
  *
  * Returns:	0  device was identified
  *		1  device timed-out (no response to identify request)
  *		2  device aborted the command (refused to identify itself)
  */
-static int actual_try_to_identify (ide_drive_t *drive, byte cmd)
+static int identify(struct ata_device *drive, u8 cmd)
 {
 	int rc;
+	int autoprobe = 0;
+	unsigned long cookie = 0;
 	ide_ioreg_t hd_status;
 	unsigned long timeout;
-	byte s, a;
+	u8 s;
+	u8 a;
+
+
+	if (IDE_CONTROL_REG && !drive->channel->irq) {
+		autoprobe = 1;
+		cookie = probe_irq_on();
+		OUT_BYTE(drive->ctl,IDE_CONTROL_REG);	/* enable device irq */
+	}
 
+	rc = 1;
 	if (IDE_CONTROL_REG) {
 		/* take a deep breath */
 		ide_delay_50ms();
@@ -247,19 +259,18 @@
 #if CONFIG_BLK_DEV_PDC4030
 	if (drive->channel->chipset == ide_pdc4030) {
 		/* DC4030 hosted drives need their own identify... */
-		extern int pdc4030_identify(ide_drive_t *);
-		if (pdc4030_identify(drive)) {
-			return 1;
-		}
+		extern int pdc4030_identify(struct ata_device *);
+
+		if (pdc4030_identify(drive))
+			goto out;
 	} else
-#endif /* CONFIG_BLK_DEV_PDC4030 */
+#endif
 		OUT_BYTE(cmd,IDE_COMMAND_REG);		/* ask drive for ID */
 	timeout = ((cmd == WIN_IDENTIFY) ? WAIT_WORSTCASE : WAIT_PIDENTIFY) / 2;
 	timeout += jiffies;
 	do {
-		if (0 < (signed long)(jiffies - timeout)) {
-			return 1;	/* drive timed-out */
-		}
+		if (time_after(jiffies, timeout))
+			goto out;	/* drive timed-out */
 		ide_delay_50ms();		/* give drive a breather */
 	} while (IN_BYTE(hd_status) & BUSY_STAT);
 
@@ -274,23 +285,8 @@
 		__restore_flags(flags);	/* local CPU only */
 	} else
 		rc = 2;			/* drive refused ID */
-	return rc;
-}
-
-static int try_to_identify (ide_drive_t *drive, byte cmd)
-{
-	int retval;
-	int autoprobe = 0;
-	unsigned long cookie = 0;
-
-	if (IDE_CONTROL_REG && !drive->channel->irq) {
-		autoprobe = 1;
-		cookie = probe_irq_on();
-		OUT_BYTE(drive->ctl,IDE_CONTROL_REG);	/* enable device irq */
-	}
-
-	retval = actual_try_to_identify(drive, cmd);
 
+out:
 	if (autoprobe) {
 		int irq;
 		OUT_BYTE(drive->ctl | 0x02, IDE_CONTROL_REG);	/* mask device irq */
@@ -304,7 +300,8 @@
 				printk("%s: IRQ probe failed (0x%lx)\n", drive->name, cookie);
 		}
 	}
-	return retval;
+
+	return rc;
 }
 
 
@@ -324,10 +321,11 @@
  *		3  bad status from device (possible for ATAPI drives)
  *		4  probe was not attempted because failure was obvious
  */
-static int do_probe (ide_drive_t *drive, byte cmd)
+static int do_probe(struct ata_device *drive, byte cmd)
 {
 	int rc;
 	struct ata_channel *hwif = drive->channel;
+
 	if (drive->present) {	/* avoid waiting for inappropriate probes */
 		if ((drive->type != ATA_DISK) && (cmd == WIN_IDENTIFY))
 			return 4;
@@ -348,11 +346,10 @@
 		return 3;    /* no i/f present: mmm.. this should be a 4 -ml */
 	}
 
-	if (OK_STAT(GET_STAT(),READY_STAT,BUSY_STAT)
-	 || drive->present || cmd == WIN_PIDENTIFY)
+	if (OK_STAT(GET_STAT(),READY_STAT,BUSY_STAT) || drive->present || cmd == WIN_PIDENTIFY)
 	{
-		if ((rc = try_to_identify(drive,cmd)))   /* send cmd and wait */
-			rc = try_to_identify(drive,cmd); /* failed: try again */
+		if ((rc = identify(drive,cmd)))   /* send cmd and wait */
+			rc = identify(drive,cmd); /* failed: try again */
 		if (rc == 1 && cmd == WIN_PIDENTIFY && drive->autotune != 2) {
 			unsigned long timeout;
 			printk("%s: no response (status = 0x%02x), resetting drive\n", drive->name, GET_STAT());
@@ -363,14 +360,14 @@
 			timeout = jiffies;
 			while ((GET_STAT() & BUSY_STAT) && time_before(jiffies, timeout + WAIT_WORSTCASE))
 				ide_delay_50ms();
-			rc = try_to_identify(drive, cmd);
+			rc = identify(drive, cmd);
 		}
 		if (rc == 1)
 			printk("%s: no response (status = 0x%02x)\n", drive->name, GET_STAT());
 		(void) GET_STAT();		/* ensure drive irq is clear */
-	} else {
+	} else
 		rc = 3;				/* not present or maybe ATAPI */
-	}
+
 	if (drive->select.b.unit != 0) {
 		SELECT_DRIVE(hwif,&hwif->drives[0]);	/* exit with drive0 selected */
 		ide_delay_50ms();
@@ -379,10 +376,7 @@
 	return rc;
 }
 
-/*
- *
- */
-static void enable_nest(ide_drive_t *drive)
+static void enable_nest(struct ata_device *drive)
 {
 	unsigned long timeout;
 
@@ -392,7 +386,7 @@
 	OUT_BYTE(EXABYTE_ENABLE_NEST, IDE_COMMAND_REG);
 	timeout = jiffies + WAIT_WORSTCASE;
 	do {
-		if (jiffies > timeout) {
+		if (time_after(jiffies, timeout)) {
 			printk("failed (timeout)\n");
 			return;
 		}
@@ -411,17 +405,21 @@
 /*
  * Tests for existence of a given drive using do_probe().
  */
-static inline void probe_for_drive (ide_drive_t *drive)
+static inline void probe_for_drive(struct ata_device *drive)
 {
 	if (drive->noprobe)			/* skip probing? */
 		return;
+
 	if (do_probe(drive, WIN_IDENTIFY) >= 2) { /* if !(success||timed-out) */
 		do_probe(drive, WIN_PIDENTIFY); /* look for ATAPI device */
 	}
+
 	if (drive->id && strstr(drive->id->model, "E X A B Y T E N E S T"))
 		enable_nest(drive);
+
 	if (!drive->present)
 		return;			/* drive not found */
+
 	if (drive->id == NULL) {		/* identification failed? */
 		if (drive->type == ATA_DISK) {
 			printk ("%s: non-IDE drive, CHS=%d/%d/%d\n",
@@ -545,7 +543,7 @@
 		do {
 			ide_delay_50ms();
 			stat = IN_BYTE(ch->io_ports[IDE_STATUS_OFFSET]);
-		} while ((stat & BUSY_STAT) && 0 < (signed long)(timeout - jiffies));
+		} while ((stat & BUSY_STAT) && time_before(jiffies, timeout));
 	}
 
 	__restore_flags(flags);	/* local CPU only */
@@ -568,34 +566,7 @@
 	__restore_flags(flags);
 }
 
-/*
- * init request queue
- */
-static void init_device_queue(struct ata_device *drive)
-{
-	request_queue_t *q = &drive->queue;
-	int max_sectors = 255;
-
-	q->queuedata = drive->channel;
-	blk_init_queue(q, do_ide_request, &ide_lock);
-	blk_queue_segment_boundary(q, 0xffff);
-
-	/* IDE can do up to 128K per request, pdc4030 needs smaller limit */
-#ifdef CONFIG_BLK_DEV_PDC4030
-	if (drive->channel->chipset == ide_pdc4030)
-		max_sectors = 127;
-#endif
-	blk_queue_max_sectors(q, max_sectors);
-
-	/* IDE DMA can do PRD_ENTRIES number of segments. */
-	blk_queue_max_hw_segments(q, PRD_SEGMENTS);
-
-	/* This is a driver limit and could be eliminated. */
-	blk_queue_max_phys_segments(q, PRD_SEGMENTS);
-}
-
 #if MAX_HWIFS > 1
-
 /*
  * This is used to simplify logic in init_irq() below.
  *
@@ -607,18 +578,19 @@
  *
  * This routine detects and reports such situations, but does not fix them.
  */
-static void save_match(struct ata_channel *hwif, struct ata_channel *new,
-		struct ata_channel **match)
+static struct ata_channel *save_match(struct ata_channel *ch, struct ata_channel *h,
+		struct ata_channel *match)
 {
-	struct ata_channel *m = *match;
+	if (match && match->hwgroup && match->hwgroup != h->hwgroup) {
+		if (!h->hwgroup)
+			return match;
 
-	if (m && m->hwgroup && m->hwgroup != new->hwgroup) {
-		if (!new->hwgroup)
-			return;
-		printk("%s: potential irq problem with %s and %s\n", hwif->name, new->name, m->name);
+		printk("%s: potential irq problem with %s and %s\n", ch->name,h->name, match->name);
 	}
-	if (!m || m->irq != hwif->irq) /* don't undo a prior perfect match */
-		*match = new;
+	if (!match || match->irq != ch->irq) /* don't undo a prior perfect match */
+		match = h;
+
+	return match;
 }
 #endif
 
@@ -643,10 +615,8 @@
 	ide_hwgroup_t *new_hwgroup;
 	struct ata_channel *match = NULL;
 
-
-	/* Allocate the buffer and potentially sleep first */
-
-	new_hwgroup = kmalloc(sizeof(ide_hwgroup_t),GFP_KERNEL);
+	/* Spare allocation before sleep. */
+	new_hwgroup = kmalloc(sizeof(*hwgroup), GFP_KERNEL);
 
 	spin_lock_irqsave(&ide_lock, flags);
 	ch->hwgroup = NULL;
@@ -658,19 +628,22 @@
 	for (i = 0; i < MAX_HWIFS; ++i) {
 		struct ata_channel *h = &ide_hwifs[i];
 
-		if (h->hwgroup) {  /* scan only initialized channels */
-			if (ch->irq == h->irq) {
-				ch->sharing_irq = h->sharing_irq = 1;
-				if (ch->chipset != ide_pci || h->chipset != ide_pci)
-					save_match(ch, h, &match);
-
-				/* FIXME: This is still confusing. What would
-				 * happen if we match-ed two times?
-				 */
-
-				if (ch->serialized || h->serialized)
-					save_match(ch, h, &match);
-			}
+		/* scan only initialized channels */
+		if (!h->hwgroup)
+			continue;
+
+		if (ch->irq != h->irq)
+		        continue;
+
+		ch->sharing_irq = h->sharing_irq = 1;
+
+		if (ch->chipset != ide_pci || h->chipset != ide_pci ||
+		     ch->serialized || h->serialized) {
+			if (match && match->hwgroup && match->hwgroup != h->hwgroup)
+				printk("%s: potential irq problem with %s and %s\n", ch->name, h->name, match->name);
+			/* don't undo a prior perfect match */
+			if (!match || match->irq != ch->irq)
+				match = h;
 		}
 	}
 #endif
@@ -721,6 +694,8 @@
 	ch->hwgroup = hwgroup;
 	for (i = 0; i < MAX_DRIVES; ++i) {
 		struct ata_device *drive = &ch->drives[i];
+		request_queue_t *q;
+		int max_sectors = 255;
 
 		if (!drive->present)
 			continue;
@@ -728,7 +703,27 @@
 		if (!hwgroup->XXX_drive)
 			hwgroup->XXX_drive = drive;
 
-		init_device_queue(drive);
+		/*
+		 * Init the per device request queue
+		 */
+
+		q = &drive->queue;
+		q->queuedata = drive->channel;
+		blk_init_queue(q, do_ide_request, &ide_lock);
+		blk_queue_segment_boundary(q, 0xffff);
+
+		/* ATA can do up to 128K per request, pdc4030 needs smaller limit */
+#ifdef CONFIG_BLK_DEV_PDC4030
+		if (drive->channel->chipset == ide_pdc4030)
+			max_sectors = 127;
+#endif
+		blk_queue_max_sectors(q, max_sectors);
+
+		/* IDE DMA can do PRD_ENTRIES number of segments. */
+		blk_queue_max_hw_segments(q, PRD_ENTRIES);
+
+		/* FIXME: This is a driver limit and could be eliminated. */
+		blk_queue_max_phys_segments(q, PRD_ENTRIES);
 	}
 	spin_unlock_irqrestore(&ide_lock, flags);
 
@@ -755,80 +750,10 @@
 }
 
 /*
- * init_gendisk() (as opposed to ide_geninit) is called for each major device,
- * after probing for drives, to allocate partition tables and other data
- * structures needed for the routines in genhd.c.  ide_geninit() gets called
- * somewhat later, during the partition check.
- */
-static void init_gendisk(struct ata_channel *hwif)
-{
-	struct gendisk *gd;
-	unsigned int unit, minors, i;
-	extern devfs_handle_t ide_devfs_handle;
-
-	minors = MAX_DRIVES * (1 << PARTN_BITS);
-
-	gd = kmalloc (sizeof(struct gendisk), GFP_KERNEL);
-	if (!gd)
-		goto err_kmalloc_gd;
-
-	gd->sizes = kmalloc (minors * sizeof(int), GFP_KERNEL);
-	if (!gd->sizes)
-		goto err_kmalloc_gd_sizes;
-
-	gd->part = kmalloc (minors * sizeof(struct hd_struct), GFP_KERNEL);
-	if (!gd->part)
-		goto err_kmalloc_gd_part;
-	memset(gd->part, 0, minors * sizeof(struct hd_struct));
-
-	for (unit = 0; unit < MAX_DRIVES; ++unit)
-		hwif->drives[unit].part = &gd->part[unit << PARTN_BITS];
-
-	gd->major	= hwif->major;		/* our major device number */
-	gd->major_name	= IDE_MAJOR_NAME;	/* treated special in genhd.c */
-	gd->minor_shift	= PARTN_BITS;		/* num bits for partitions */
-	gd->nr_real	= MAX_DRIVES;		/* current num real drives */
-	gd->next	= NULL;			/* linked list of major devs */
-	gd->fops        = ide_fops;             /* file operations */
-	gd->de_arr	= kmalloc(sizeof(*gd->de_arr) * MAX_DRIVES, GFP_KERNEL);
-	gd->flags	= kmalloc(sizeof(*gd->flags) * MAX_DRIVES, GFP_KERNEL);
-	if (gd->de_arr)
-		memset(gd->de_arr, 0, sizeof(*gd->de_arr) * MAX_DRIVES);
-	if (gd->flags)
-		memset(gd->flags, 0, sizeof(*gd->flags) * MAX_DRIVES);
-
-	hwif->gd = gd;
-	add_gendisk(gd);
-
-	for (unit = 0; unit < MAX_DRIVES; ++unit) {
-		char name[80];
-
-		ide_add_generic_settings(hwif->drives + unit);
-		hwif->drives[unit].dn = ((hwif->unit ? 2 : 0) + unit);
-		sprintf (name, "host%d/bus%d/target%d/lun%d",
-			hwif->index, hwif->unit, unit, hwif->drives[unit].lun);
-		if (hwif->drives[unit].present)
-			hwif->drives[unit].de = devfs_mk_dir(ide_devfs_handle, name, NULL);
-	}
-	return;
-
-err_kmalloc_bs:
-	kfree(gd->part);
-err_kmalloc_gd_part:
-	kfree(gd->sizes);
-err_kmalloc_gd_sizes:
-	kfree(gd);
-err_kmalloc_gd:
-	printk(KERN_CRIT "(ide::init_gendisk) Out of memory\n");
-	return;
-}
-
-/*
  * Returns the queue which corresponds to a given device.
  *
  * FIXME: this should take struct block_device * as argument in future.
  */
-
 static request_queue_t *ata_get_queue(kdev_t dev)
 {
 	struct ata_channel *ch = (struct ata_channel *)blk_dev[major(dev)].data;
@@ -837,8 +762,15 @@
 	return &ch->drives[DEVICE_NR(dev) & 1].queue;
 }
 
+/* Number of minor numbers we consume par channel. */
+#define ATA_MINORS	(MAX_DRIVES * (1 << PARTN_BITS))
+
 static void channel_init(struct ata_channel *ch)
 {
+	struct gendisk *gd;
+	unsigned int unit;
+	extern devfs_handle_t ide_devfs_handle;
+
 	if (!ch->present)
 		return;
 
@@ -888,33 +820,96 @@
 		printk(KERN_INFO "%s: probed IRQ %d failed, using default.\n", ch->name, ch->irq);
 	}
 
-	init_gendisk(ch);
+	/* Initialize partition and global device data.  ide_geninit() gets
+	 * called somewhat later, during the partition check.
+	 */
+
+	gd = kmalloc (sizeof(struct gendisk), GFP_KERNEL);
+	if (!gd)
+		goto err_kmalloc_gd;
+
+	gd->sizes = kmalloc(ATA_MINORS * sizeof(int), GFP_KERNEL);
+	if (!gd->sizes)
+		goto err_kmalloc_gd_sizes;
+
+	gd->part = kmalloc(ATA_MINORS * sizeof(struct hd_struct), GFP_KERNEL);
+	if (!gd->part)
+		goto err_kmalloc_gd_part;
+	memset(gd->part, 0, ATA_MINORS * sizeof(struct hd_struct));
+
+	for (unit = 0; unit < MAX_DRIVES; ++unit)
+		ch->drives[unit].part = &gd->part[unit << PARTN_BITS];
+
+	gd->major	= ch->major;		/* our major device number */
+	gd->major_name	= IDE_MAJOR_NAME;	/* treated special in genhd.c */
+	gd->minor_shift	= PARTN_BITS;		/* num bits for partitions */
+	gd->nr_real	= MAX_DRIVES;		/* current num real drives */
+	gd->next	= NULL;			/* linked list of major devs */
+	gd->fops        = ide_fops;             /* file operations */
+
+	gd->de_arr	= kmalloc(sizeof(*gd->de_arr) * MAX_DRIVES, GFP_KERNEL);
+	if (gd->de_arr)
+		memset(gd->de_arr, 0, sizeof(*gd->de_arr) * MAX_DRIVES);
+	else
+	    goto err_kmalloc_gd_de_arr;
+
+	gd->flags	= kmalloc(sizeof(*gd->flags) * MAX_DRIVES, GFP_KERNEL);
+	if (gd->flags)
+		memset(gd->flags, 0, sizeof(*gd->flags) * MAX_DRIVES);
+	else
+	    goto err_kmalloc_gd_flags;
+
+	ch->gd = gd;
+	add_gendisk(gd);
+
+	for (unit = 0; unit < MAX_DRIVES; ++unit) {
+		char name[80];
+
+		ide_add_generic_settings(ch->drives + unit);
+		ch->drives[unit].dn = ((ch->unit ? 2 : 0) + unit);
+		sprintf(name, "host%d/bus%d/target%d/lun%d",
+			ch->index, ch->unit, unit, ch->drives[unit].lun);
+		if (ch->drives[unit].present)
+			ch->drives[unit].de = devfs_mk_dir(ide_devfs_handle, name, NULL);
+	}
+
 	blk_dev[ch->major].data = ch;
 	blk_dev[ch->major].queue = ata_get_queue;
 
-	/* all went well, flag this channel entry as valid */
+	/* All went well, flag this channel entry as valid again. */
 	ch->present = 1;
 
 	return;
+
+err_kmalloc_gd_flags:
+	kfree(gd->de_arr);
+err_kmalloc_gd_de_arr:
+	kfree(gd->part);
+err_kmalloc_gd_part:
+	kfree(gd->sizes);
+err_kmalloc_gd_sizes:
+	kfree(gd);
+err_kmalloc_gd:
+	printk(KERN_CRIT "(%s) Out of memory\n", __FUNCTION__);
 }
 
 int ideprobe_init (void)
 {
-	unsigned int index;
+	unsigned int i;
 	int probe[MAX_HWIFS];
 
-	memset(probe, 0, MAX_HWIFS * sizeof(int));
-	for (index = 0; index < MAX_HWIFS; ++index)
-		probe[index] = !ide_hwifs[index].present;
+	for (i = 0; i < MAX_HWIFS; ++i)
+		probe[i] = !ide_hwifs[i].present;
 
 	/*
 	 * Probe for drives in the usual way.. CMOS/BIOS, then poke at ports
 	 */
-	for (index = 0; index < MAX_HWIFS; ++index)
-		if (probe[index])
-			channel_probe(&ide_hwifs[index]);
-	for (index = 0; index < MAX_HWIFS; ++index)
-		if (probe[index])
-			channel_init(&ide_hwifs[index]);
+	for (i = 0; i < MAX_HWIFS; ++i)
+		if (probe[i])
+			channel_probe(&ide_hwifs[i]);
+	for (i = 0; i < MAX_HWIFS; ++i)
+		if (probe[i])
+			channel_init(&ide_hwifs[i]);
+
 	return 0;
 }

--------------010600010908030205050500--

