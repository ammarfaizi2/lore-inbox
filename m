Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293591AbSBZMQn>; Tue, 26 Feb 2002 07:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293592AbSBZMQZ>; Tue, 26 Feb 2002 07:16:25 -0500
Received: from [195.63.194.11] ([195.63.194.11]:48144 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S293591AbSBZMQJ>; Tue, 26 Feb 2002 07:16:09 -0500
Message-ID: <3C7B7C57.4090000@evision-ventures.com>
Date: Tue, 26 Feb 2002 13:15:19 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.5 IDE clean 14
In-Reply-To: <Pine.LNX.4.33.0202250919580.4567-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------010506050108040504070406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010506050108040504070406
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello!

Most importantly this patch is making ide.c use the
new automagic for module initialization lists and further
preparing the rest of the code in question here for proper
module separation. Despite this the CMOS probe has been removed
as well... *Iff*, which I don't expect, this breaks anything
it can be reintroduced easely. During this effort an actual bug
in the initialization of the main module has been uncovered as well.
a quite serious BUG has been tagged in ide-scsi.c as well, but
as far as now I just didn't get along to actually fixing it.
(The patch is big enough as it is).

Details follow:

- Kill *unused* ide_media_verbose() funciton.

- Remove the unnecessary media and supports_dma fields from
   ide_driver_t.

- Remove the global name field from ide_driver_t struct by pushing it
   down to the places where it's actually used.

- Remove the unused hwif_data field from ide_hwif_t.

- Push the supports_dsc_overlap condition up to the level where it
   belongs: disk type as well.

- Make the initialization of ide main ide.c work with the new module
   initialization auto-magic instead of calling it explicitly in
   ll_rw_block.c This prevents the ide_init() from being called twice. We
   have BTW. renamed it to ata_module_init(), since  ata is more adequate
   then ide and xxx_module_init corresponds better to the naming
   conventions used elsewhere throughout the kernel.

   This BUG was there before any ide-clean.  It was worked around by a
   magic variable preventing the second call to succeed.  We have removed
   this variable in one of the previous patches and thus uncovered it.

- Kill proc_ide_read_driver() and proc_ide_write_driver(). The drivers
   already report on syslog which drives they have taken care of.  (Or
   at least they should). In esp. the proc_ide_write_driver() was just
   too offending for me.  Beleve it or not the purpose of it was to
   *request a particular* driver for a device, by echoing some magic
   values to a magic file...
   More importantly this "back door" was getting in the way of a properly
   done modularization of the IDE stuff.

- Made some not externally used functions static or not EXPORT-ed.

- Provide the start of a proper modularization between the main module
   and drivers for particular device types. Changing the name-space
   polluting DRIVER() macro to ata_ops() showed how inconsistently the
   busy (read: module  busy!) field from ide_driver_t
   is currently used across the    different device type modules.
   This has to be fixed soon.

- Make the ide code use the similar device type ID numbers as the SCSI
   code :-).  This is just tedious, but it will help in a distant
   feature. It helps reading the code anyway.

- Mark repettitive code with /* ATA-PATTERN */ comments for later
   consolidation at places where we did came across it.

- Various comments and notes added where some explanations was missing.

--------------010506050108040504070406
Content-Type: text/plain;
 name="ide-clean-14.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-14.diff"

diff -ur linux-2.5.5/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- linux-2.5.5/drivers/block/ll_rw_blk.c	Wed Feb 20 03:10:55 2002
+++ linux/drivers/block/ll_rw_blk.c	Mon Feb 25 21:30:03 2002
@@ -1697,9 +1697,6 @@
 	blk_max_low_pfn = max_low_pfn;
 	blk_max_pfn = max_pfn;
 
-#if defined(CONFIG_IDE) && defined(CONFIG_BLK_DEV_IDE)
-	ide_init();		/* this MUST precede hd_init */
-#endif
 #if defined(CONFIG_IDE) && defined(CONFIG_BLK_DEV_HD)
 	hd_init();
 #endif
diff -ur linux-2.5.5/drivers/ide/aec62xx.c linux/drivers/ide/aec62xx.c
--- linux-2.5.5/drivers/ide/aec62xx.c	Sun Feb 24 16:32:53 2002
+++ linux/drivers/ide/aec62xx.c	Tue Feb 26 01:23:43 2002
@@ -48,7 +48,6 @@
 
 static int aec62xx_get_info(char *, char **, off_t, int);
 extern int (*aec62xx_display_info)(char *, char **, off_t, int); /* ide-proc.c */
-extern char *ide_media_verbose(ide_drive_t *);
 static struct pci_dev *bmide_dev;
 
 static int aec62xx_get_info (char *buffer, char **addr, off_t offset, int count)
@@ -310,8 +309,8 @@
 	unsigned long dma_base	= hwif->dma_base;
 	byte speed		= -1;
 
-	if (drive->media != ide_disk)
-		return ((int) ide_dma_off_quietly);
+	if (drive->type != ATA_DISK)
+		return ide_dma_off_quietly;
 
 	if (((id->dma_ultra & 0x0010) ||
 	     (id->dma_ultra & 0x0008) ||
@@ -356,7 +355,7 @@
 	byte speed		= -1;
 	byte ultra66		= eighty_ninty_three(drive);
 
-	if (drive->media != ide_disk)
+	if (drive->type != ATA_DISK)
 		return ((int) ide_dma_off_quietly);
 
 	if ((id->dma_ultra & 0x0010) && (ultra) && (ultra66)) {
diff -ur linux-2.5.5/drivers/ide/alim15x3.c linux/drivers/ide/alim15x3.c
--- linux-2.5.5/drivers/ide/alim15x3.c	Sun Feb 24 16:32:53 2002
+++ linux/drivers/ide/alim15x3.c	Tue Feb 26 01:25:26 2002
@@ -278,7 +278,7 @@
 	 * PIO mode => ATA FIFO on, ATAPI FIFO off
 	 */
 	pci_read_config_byte(dev, portFIFO, &cd_dma_fifo);
-	if (drive->media==ide_disk) {
+	if (drive->type == ATA_DISK) {
 		if (hwif->index) {
 			pci_write_config_byte(dev, portFIFO, (cd_dma_fifo & 0x0F) | 0x50);
 		} else {
@@ -424,9 +424,9 @@
 	} else if ((m5229_revision < 0xC2) &&
 #ifndef CONFIG_WDC_ALI15X3
 		   ((chip_is_1543c_e && strstr(id->model, "WDC ")) ||
-		    (drive->media!=ide_disk))) {
+		    (drive->type != ATA_DISK))) {
 #else /* CONFIG_WDC_ALI15X3 */
-		   (drive->media!=ide_disk)) {
+		   (drive->type != ATA_DISK)) {
 #endif /* CONFIG_WDC_ALI15X3 */
 		return 0;
 	} else {
@@ -441,7 +441,7 @@
 	ide_dma_action_t dma_func	= ide_dma_on;
 	byte can_ultra_dma		= ali15x3_can_ultra(drive);
 
-	if ((m5229_revision<=0x20) && (drive->media!=ide_disk))
+	if ((m5229_revision<=0x20) && (drive->type != ATA_DISK))
 		return hwif->dmaproc(ide_dma_off_quietly, drive);
 
 	if ((id != NULL) && ((id->capability & 1) != 0) && hwif->autodma) {
@@ -494,7 +494,7 @@
 		case ide_dma_check:
 			return ali15x3_config_drive_for_dma(drive);
 		case ide_dma_write:
-			if ((m5229_revision < 0xC2) && (drive->media != ide_disk))
+			if ((m5229_revision < 0xC2) && (drive->type != ATA_DISK))
 				return 1;	/* try PIO instead of DMA */
 			break;
 		default:
diff -ur linux-2.5.5/drivers/ide/amd74xx.c linux/drivers/ide/amd74xx.c
--- linux-2.5.5/drivers/ide/amd74xx.c	Sun Feb 24 16:32:53 2002
+++ linux/drivers/ide/amd74xx.c	Mon Feb 25 01:54:28 2002
@@ -34,7 +34,6 @@
 
 static int amd74xx_get_info(char *, char **, off_t, int);
 extern int (*amd74xx_display_info)(char *, char **, off_t, int); /* ide-proc.c */
-extern char *ide_media_verbose(ide_drive_t *);
 static struct pci_dev *bmide_dev;
 
 static int amd74xx_get_info (char *buffer, char **addr, off_t offset, int count)
diff -ur linux-2.5.5/drivers/ide/cmd64x.c linux/drivers/ide/cmd64x.c
--- linux-2.5.5/drivers/ide/cmd64x.c	Sun Feb 24 16:32:53 2002
+++ linux/drivers/ide/cmd64x.c	Tue Feb 26 01:27:04 2002
@@ -88,7 +88,6 @@
 static int cmd64x_get_info(char *, char **, off_t, int);
 static int cmd680_get_info(char *, char **, off_t, int);
 extern int (*cmd64x_display_info)(char *, char **, off_t, int); /* ide-proc.c */
-extern char *ide_media_verbose(ide_drive_t *);
 static struct pci_dev *bmide_dev;
 
 static int cmd64x_get_info (char *buffer, char **addr, off_t offset, int count)
@@ -448,7 +447,8 @@
 	u8 regU			= 0;
 	u8 regD			= 0;
 
-	if ((drive->media != ide_disk) && (speed < XFER_SW_DMA_0))	return 1;
+	if ((drive->type != ATA_DISK) && (speed < XFER_SW_DMA_0))
+		return 1;
 
 	(void) pci_read_config_byte(dev, pciD, &regD);
 	(void) pci_read_config_byte(dev, pciU, &regU);
@@ -641,8 +641,8 @@
 			break;
 	}
 
-	if (drive->media != ide_disk) {
-		cmdprintk("CMD64X: drive->media != ide_disk at double check, inital check failed!!\n");
+	if (drive->type != ATA_DISK) {
+		cmdprintk("CMD64X: drive is not a disk at double check, inital check failed!!\n");
 		return ((int) ide_dma_off);
 	}
 
@@ -788,7 +788,7 @@
 	}
 
 	if ((id != NULL) && ((id->capability & 1) != 0) &&
-	    hwif->autodma && (drive->media == ide_disk)) {
+	    hwif->autodma && (drive->type == ATA_DISK)) {
 		/* Consult the list of known "bad" drives */
 		if (ide_dmaproc(ide_dma_bad_drive, drive)) {
 			dma_func = ide_dma_off;
diff -ur linux-2.5.5/drivers/ide/cs5530.c linux/drivers/ide/cs5530.c
--- linux-2.5.5/drivers/ide/cs5530.c	Sun Feb 24 16:32:53 2002
+++ linux/drivers/ide/cs5530.c	Mon Feb 25 01:54:35 2002
@@ -37,7 +37,6 @@
 
 static int cs5530_get_info(char *, char **, off_t, int);
 extern int (*cs5530_display_info)(char *, char **, off_t, int); /* ide-proc.c */
-extern char *ide_media_verbose(ide_drive_t *);
 static struct pci_dev *bmide_dev;
 
 static int cs5530_get_info (char *buffer, char **addr, off_t offset, int count)
diff -ur linux-2.5.5/drivers/ide/hpt34x.c linux/drivers/ide/hpt34x.c
--- linux-2.5.5/drivers/ide/hpt34x.c	Sun Feb 24 16:32:53 2002
+++ linux/drivers/ide/hpt34x.c	Tue Feb 26 01:27:49 2002
@@ -56,7 +56,6 @@
 
 static int hpt34x_get_info(char *, char **, off_t, int);
 extern int (*hpt34x_display_info)(char *, char **, off_t, int); /* ide-proc.c */
-extern char *ide_media_verbose(ide_drive_t *);
 static struct pci_dev *bmide_dev;
 
 static int hpt34x_get_info (char *buffer, char **addr, off_t offset, int count)
@@ -210,7 +209,7 @@
 	struct hd_driveid *id	= drive->id;
 	byte speed		= 0x00;
 
-	if (drive->media != ide_disk)
+	if (drive->type != ATA_DISK)
 		return ((int) ide_dma_off_quietly);
 
 	hpt34x_clear_chipset(drive);
@@ -333,7 +332,7 @@
 			outb(reading, dma_base);		/* specify r/w */
 			outb(inb(dma_base+2)|6, dma_base+2);	/* clear INTR & ERROR flags */
 			drive->waiting_for_dma = 1;
-			if (drive->media != ide_disk)
+			if (drive->type != ATA_DISK)
 				return 0;
 			ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, NULL);	/* issue cmd to drive */
 			OUT_BYTE((reading == 9) ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
diff -ur linux-2.5.5/drivers/ide/hpt366.c linux/drivers/ide/hpt366.c
--- linux-2.5.5/drivers/ide/hpt366.c	Sun Feb 24 16:32:53 2002
+++ linux/drivers/ide/hpt366.c	Tue Feb 26 01:28:31 2002
@@ -355,7 +355,6 @@
 #if defined(DISPLAY_HPT366_TIMINGS) && defined(CONFIG_PROC_FS)
 static int hpt366_get_info(char *, char **, off_t, int);
 extern int (*hpt366_display_info)(char *, char **, off_t, int); /* ide-proc.c */
-extern char *ide_media_verbose(ide_drive_t *);
 
 static int hpt366_get_info (char *buffer, char **addr, off_t offset, int count)
 {
@@ -579,7 +578,7 @@
 
 static int hpt3xx_tune_chipset (ide_drive_t *drive, byte speed)
 {
-	if ((drive->media != ide_disk) && (speed < XFER_SW_DMA_0))
+	if ((drive->type != ATA_DISK) && (speed < XFER_SW_DMA_0))
 		return -1;
 
 	if (!drive->init_speed)
@@ -664,7 +663,7 @@
 	byte ultra66		= eighty_ninty_three(drive);
 	int  rval;
 
-	if ((drive->media != ide_disk) && (speed < XFER_SW_DMA_0))
+	if ((drive->type != ATA_DISK) && (speed < XFER_SW_DMA_0))
 		return ((int) ide_dma_off_quietly);
 
 	if ((id->dma_ultra & 0x0020) &&
diff -ur linux-2.5.5/drivers/ide/ht6560b.c linux/drivers/ide/ht6560b.c
--- linux-2.5.5/drivers/ide/ht6560b.c	Sun Feb 24 16:32:49 2002
+++ linux/drivers/ide/ht6560b.c	Tue Feb 26 01:29:05 2002
@@ -143,7 +143,7 @@
 	if (select != current_select || timing != current_timing) {
 		current_select = select;
 		current_timing = timing;
-		if (drive->media != ide_disk || !drive->present)
+		if (drive->type != ATA_DISK || !drive->present)
 			select |= HT_PREFETCH_MODE;
 		(void) inb(HT_CONFIG_PORT);
 		(void) inb(HT_CONFIG_PORT);
diff -ur linux-2.5.5/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.5/drivers/ide/ide-cd.c	Sun Feb 24 16:32:45 2002
+++ linux/drivers/ide/ide-cd.c	Tue Feb 26 01:41:58 2002
@@ -2906,14 +2906,10 @@
 	return 0;
 }
 
-int ide_cdrom_reinit (ide_drive_t *drive);
+static int ide_cdrom_reinit (ide_drive_t *drive);
 
-static ide_driver_t ide_cdrom_driver = {
-	name:			"ide-cdrom",
-	media:			ide_cdrom,
-	busy:			0,
-	supports_dma:		1,
-	supports_dsc_overlap:	1,
+static struct ata_operations ide_cdrom_driver = {
+	owner:			THIS_MODULE,
 	cleanup:		ide_cdrom_cleanup,
 	standby:		NULL,
 	flushcache:		NULL,
@@ -2937,7 +2933,7 @@
 MODULE_PARM(ignore, "s");
 MODULE_DESCRIPTION("ATAPI CD-ROM Driver");
 
-int ide_cdrom_reinit (ide_drive_t *drive)
+static int ide_cdrom_reinit (ide_drive_t *drive)
 {
 	struct cdrom_info *info;
 	int failed = 0;
@@ -2955,14 +2951,17 @@
 	}
 	memset (info, 0, sizeof (struct cdrom_info));
 	drive->driver_data = info;
-	DRIVER(drive)->busy++;
+
+	/* ATA-PATTERN */
+	ata_ops(drive)->busy++;
 	if (ide_cdrom_setup (drive)) {
-		DRIVER(drive)->busy--;
+		ata_ops(drive)->busy--;
 		if (ide_cdrom_cleanup (drive))
 			printk ("%s: ide_cdrom_cleanup failed in ide_cdrom_init\n", drive->name);
 		return 1;
 	}
-	DRIVER(drive)->busy--;
+	ata_ops(drive)->busy--;
+
 	failed--;
 
 	revalidate_drives();
@@ -2975,7 +2974,7 @@
 	ide_drive_t *drive;
 	int failed = 0;
 
-	while ((drive = ide_scan_devices (ide_cdrom, ide_cdrom_driver.name, &ide_cdrom_driver, failed)) != NULL)
+	while ((drive = ide_scan_devices(ATA_ROM, "ide-cdrom", &ide_cdrom_driver, failed)) != NULL)
 		if (ide_cdrom_cleanup (drive)) {
 			printk ("%s: cleanup_module() called while still busy\n", drive->name);
 			failed++;
@@ -2989,7 +2988,7 @@
 	int failed = 0;
 
 	MOD_INC_USE_COUNT;
-	while ((drive = ide_scan_devices (ide_cdrom, ide_cdrom_driver.name, NULL, failed++)) != NULL) {
+	while ((drive = ide_scan_devices (ATA_ROM, "ide-cdrom", NULL, failed++)) != NULL) {
 		/* skip drives that we were told to ignore */
 		if (ignore != NULL) {
 			if (strstr(ignore, drive->name)) {
@@ -3013,14 +3012,17 @@
 		}
 		memset (info, 0, sizeof (struct cdrom_info));
 		drive->driver_data = info;
-		DRIVER(drive)->busy++;
+
+		/* ATA-PATTERN */
+		ata_ops(drive)->busy++;
 		if (ide_cdrom_setup (drive)) {
-			DRIVER(drive)->busy--;
+			ata_ops(drive)->busy--;
 			if (ide_cdrom_cleanup (drive))
 				printk ("%s: ide_cdrom_cleanup failed in ide_cdrom_init\n", drive->name);
 			continue;
 		}
-		DRIVER(drive)->busy--;
+		ata_ops(drive)->busy--;
+
 		failed--;
 	}
 	revalidate_drives();
diff -ur linux-2.5.5/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.5/drivers/ide/ide-disk.c	Sun Feb 24 16:32:49 2002
+++ linux/drivers/ide/ide-disk.c	Tue Feb 26 01:39:24 2002
@@ -1053,17 +1053,13 @@
 	return ide_unregister_subdriver(drive);
 }
 
-int idedisk_reinit(ide_drive_t *drive);
+static int idedisk_reinit(ide_drive_t *drive);
 
 /*
  *      IDE subdriver functions, registered with ide.c
  */
-static ide_driver_t idedisk_driver = {
-	name:			"ide-disk",
-	media:			ide_disk,
-	busy:			0,
-	supports_dma:		1,
-	supports_dsc_overlap:	0,
+static struct ata_operations idedisk_driver = {
+	owner:			THIS_MODULE,
 	cleanup:		idedisk_cleanup,
 	standby:		do_idedisk_standby,
 	flushcache:		do_idedisk_flushcache,
@@ -1083,7 +1079,7 @@
 
 MODULE_DESCRIPTION("ATA DISK Driver");
 
-int idedisk_reinit (ide_drive_t *drive)
+static int idedisk_reinit(ide_drive_t *drive)
 {
 	int failed = 0;
 
@@ -1093,15 +1089,16 @@
 		printk (KERN_ERR "ide-disk: %s: Failed to register the driver with ide.c\n", drive->name);
 		return 1;
 	}
-	DRIVER(drive)->busy++;
+
+	ata_ops(drive)->busy++;
 	idedisk_setup(drive);
 	if ((!drive->head || drive->head > 16) && !drive->select.b.lba) {
 		printk(KERN_ERR "%s: INVALID GEOMETRY: %d PHYSICAL HEADS?\n", drive->name, drive->head);
-		(void) idedisk_cleanup(drive);
-		DRIVER(drive)->busy--;
+		idedisk_cleanup(drive);
+		ata_ops(drive)->busy--;
 		return 1;
 	}
-	DRIVER(drive)->busy--;
+	ata_ops(drive)->busy--;
 	failed--;
 
 	revalidate_drives();
@@ -1114,7 +1111,7 @@
 	ide_drive_t *drive;
 	int failed = 0;
 
-	while ((drive = ide_scan_devices (ide_disk, idedisk_driver.name, &idedisk_driver, failed)) != NULL) {
+	while ((drive = ide_scan_devices(ATA_DISK, "ide-disk", &idedisk_driver, failed)) != NULL) {
 		if (idedisk_cleanup (drive)) {
 			printk (KERN_ERR "%s: cleanup_module() called while still busy\n", drive->name);
 			failed++;
@@ -1134,20 +1131,20 @@
 	int failed = 0;
 	
 	MOD_INC_USE_COUNT;
-	while ((drive = ide_scan_devices (ide_disk, idedisk_driver.name, NULL, failed++)) != NULL) {
+	while ((drive = ide_scan_devices(ATA_DISK, "ide-disk", NULL, failed++)) != NULL) {
 		if (ide_register_subdriver (drive, &idedisk_driver)) {
 			printk (KERN_ERR "ide-disk: %s: Failed to register the driver with ide.c\n", drive->name);
 			continue;
 		}
-		DRIVER(drive)->busy++;
+		ata_ops(drive)->busy++;
 		idedisk_setup(drive);
 		if ((!drive->head || drive->head > 16) && !drive->select.b.lba) {
 			printk(KERN_ERR "%s: INVALID GEOMETRY: %d PHYSICAL HEADS?\n", drive->name, drive->head);
-			(void) idedisk_cleanup(drive);
-			DRIVER(drive)->busy--;
+			idedisk_cleanup(drive);
+			ata_ops(drive)->busy--;
 			continue;
 		}
-		DRIVER(drive)->busy--;
+		ata_ops(drive)->busy--;
 		failed--;
 	}
 	revalidate_drives();
diff -ur linux-2.5.5/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- linux-2.5.5/drivers/ide/ide-dma.c	Wed Feb 20 03:10:57 2002
+++ linux/drivers/ide/ide-dma.c	Tue Feb 26 01:29:56 2002
@@ -470,7 +470,7 @@
 	ide_hwif_t *hwif = HWIF(drive);
 
 #ifdef CONFIG_IDEDMA_ONLYDISK
-	if (drive->media != ide_disk)
+	if (drive->type != ATA_DISK)
 		config_allows_dma = 0;
 #endif
 
@@ -555,7 +555,7 @@
 {
 	u64 addr = BLK_BOUNCE_HIGH;
 
-	if (on && drive->media == ide_disk && HWIF(drive)->highmem) {
+	if (on && drive->type == ATA_DISK && HWIF(drive)->highmem) {
 		if (!PCI_DMA_BUS_IS_PHYS)
 			addr = BLK_BOUNCE_ANY;
 		else
@@ -613,7 +613,7 @@
 			outb(reading, dma_base);			/* specify r/w */
 			outb(inb(dma_base+2)|6, dma_base+2);		/* clear INTR & ERROR flags */
 			drive->waiting_for_dma = 1;
-			if (drive->media != ide_disk)
+			if (drive->type != ATA_DISK)
 				return 0;
 #ifdef CONFIG_BLK_DEV_IDEDMA_TIMEOUT
 			ide_set_handler(drive, &ide_dma_intr, 2*WAIT_CMD, NULL);	/* issue cmd to drive */
diff -ur linux-2.5.5/drivers/ide/ide-features.c linux/drivers/ide/ide-features.c
--- linux-2.5.5/drivers/ide/ide-features.c	Wed Feb 20 03:11:04 2002
+++ linux/drivers/ide/ide-features.c	Mon Feb 25 01:54:49 2002
@@ -70,22 +70,6 @@
 }
 
 /*
- *
- */
-char *ide_media_verbose (ide_drive_t *drive)
-{
-	switch (drive->media) {
-		case ide_scsi:		return("scsi   ");
-		case ide_disk:		return("disk   ");
-		case ide_optical:	return("optical");
-		case ide_cdrom:		return("cdrom  ");
-		case ide_tape:		return("tape   ");
-		case ide_floppy:	return("floppy ");
-		default:		return("???????");
-	}
-}
-
-/*
  * A Verbose noise maker for debugging on the attempted dmaing calls.
  */
 char *ide_dmafunc_verbose (ide_dma_action_t dmafunc)
diff -ur linux-2.5.5/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux-2.5.5/drivers/ide/ide-floppy.c	Sun Feb 24 16:32:45 2002
+++ linux/drivers/ide/ide-floppy.c	Tue Feb 26 01:43:48 2002
@@ -1827,14 +1827,6 @@
 }
 
 /*
- *	Revalidate the new media. Should set blk_size[]
- */
-static void idefloppy_revalidate (ide_drive_t *drive)
-{
-	ide_revalidate_drive(drive);
-}
-
-/*
  *	Return the current floppy capacity to ide.c.
  */
 static unsigned long idefloppy_capacity (ide_drive_t *drive)
@@ -2046,17 +2038,13 @@
 
 #endif	/* CONFIG_PROC_FS */
 
-int idefloppy_reinit(ide_drive_t *drive);
+static int idefloppy_reinit(ide_drive_t *drive);
 
 /*
  *	IDE subdriver functions, registered with ide.c
  */
-static ide_driver_t idefloppy_driver = {
-	name:			"ide-floppy",
-	media:			ide_floppy,
-	busy:			0,
-	supports_dma:		1,
-	supports_dsc_overlap:	0,
+static struct ata_operations idefloppy_driver = {
+	owner:			THIS_MODULE,
 	cleanup:		idefloppy_cleanup,
 	standby:		NULL,
 	flushcache:		NULL,
@@ -2066,7 +2054,7 @@
 	open:			idefloppy_open,
 	release:		idefloppy_release,
 	media_change:		idefloppy_media_change,
-	revalidate:		idefloppy_revalidate,
+	revalidate:		ide_revalidate_drive,
 	pre_reset:		NULL,
 	capacity:		idefloppy_capacity,
 	special:		NULL,
@@ -2074,13 +2062,13 @@
 	driver_reinit:		idefloppy_reinit,
 };
 
-int idefloppy_reinit (ide_drive_t *drive)
+static int idefloppy_reinit (ide_drive_t *drive)
 {
 	idefloppy_floppy_t *floppy;
 	int failed = 0;
 
 	MOD_INC_USE_COUNT;
-	while ((drive = ide_scan_devices (ide_floppy, idefloppy_driver.name, NULL, failed++)) != NULL) {
+	while ((drive = ide_scan_devices(ATA_FLOPPY, "ide-floppy", NULL, failed++)) != NULL) {
 		if (!idefloppy_identify_device (drive, drive->id)) {
 			printk (KERN_ERR "ide-floppy: %s: not supported by this version of ide-floppy\n", drive->name);
 			continue;
@@ -2098,9 +2086,12 @@
 			kfree (floppy);
 			continue;
 		}
-		DRIVER(drive)->busy++;
+
+		/* ATA-PATTERN */
+		ata_ops(drive)->busy++;
 		idefloppy_setup (drive, floppy);
-		DRIVER(drive)->busy--;
+		ata_ops(drive)->busy--;
+
 		failed--;
 	}
 	revalidate_drives();
@@ -2115,7 +2106,7 @@
 	ide_drive_t *drive;
 	int failed = 0;
 
-	while ((drive = ide_scan_devices (ide_floppy, idefloppy_driver.name, &idefloppy_driver, failed)) != NULL) {
+	while ((drive = ide_scan_devices(ATA_FLOPPY, "ide-floppy", &idefloppy_driver, failed)) != NULL) {
 		if (idefloppy_cleanup (drive)) {
 			printk ("%s: cleanup_module() called while still busy\n", drive->name);
 			failed++;
@@ -2141,7 +2132,7 @@
 
 	printk("ide-floppy driver " IDEFLOPPY_VERSION "\n");
 	MOD_INC_USE_COUNT;
-	while ((drive = ide_scan_devices (ide_floppy, idefloppy_driver.name, NULL, failed++)) != NULL) {
+	while ((drive = ide_scan_devices (ATA_FLOPPY, "ide-floppy", NULL, failed++)) != NULL) {
 		if (!idefloppy_identify_device (drive, drive->id)) {
 			printk (KERN_ERR "ide-floppy: %s: not supported by this version of ide-floppy\n", drive->name);
 			continue;
@@ -2159,9 +2150,11 @@
 			kfree (floppy);
 			continue;
 		}
-		DRIVER(drive)->busy++;
+		/* ATA-PATTERN */
+		ata_ops(drive)->busy++;
 		idefloppy_setup (drive, floppy);
-		DRIVER(drive)->busy--;
+		ata_ops(drive)->busy--;
+
 		failed--;
 	}
 	revalidate_drives();
diff -ur linux-2.5.5/drivers/ide/ide-geometry.c linux/drivers/ide/ide-geometry.c
--- linux-2.5.5/drivers/ide/ide-geometry.c	Wed Feb 20 03:10:53 2002
+++ linux/drivers/ide/ide-geometry.c	Tue Feb 26 00:26:47 2002
@@ -1,94 +1,16 @@
 /*
  * linux/drivers/ide/ide-geometry.c
+ *
+ * Sun Feb 24 23:13:03 CET 2002: Patch by Andries Brouwer to remove the
+ * confused CMOS probe applied. This is solving more problems then it my
+ * (unexpectedly) introduce.
  */
+
 #include <linux/config.h>
 #include <linux/ide.h>
 #include <linux/mc146818rtc.h>
 #include <asm/io.h>
 
-#ifdef CONFIG_BLK_DEV_IDE
-
-/*
- * We query CMOS about hard disks : it could be that we have a SCSI/ESDI/etc
- * controller that is BIOS compatible with ST-506, and thus showing up in our
- * BIOS table, but not register compatible, and therefore not present in CMOS.
- *
- * Furthermore, we will assume that our ST-506 drives <if any> are the primary
- * drives in the system -- the ones reflected as drive 1 or 2.  The first
- * drive is stored in the high nibble of CMOS byte 0x12, the second in the low
- * nibble.  This will be either a 4 bit drive type or 0xf indicating use byte
- * 0x19 for an 8 bit type, drive 1, 0x1a for drive 2 in CMOS.  A non-zero value
- * means we have an AT controller hard disk for that drive.
- *
- * Of course, there is no guarantee that either drive is actually on the
- * "primary" IDE interface, but we don't bother trying to sort that out here.
- * If a drive is not actually on the primary interface, then these parameters
- * will be ignored.  This results in the user having to supply the logical
- * drive geometry as a boot parameter for each drive not on the primary i/f.
- */
-/*
- * The only "perfect" way to handle this would be to modify the setup.[cS] code
- * to do BIOS calls Int13h/Fn08h and Int13h/Fn48h to get all of the drive info
- * for us during initialization.  I have the necessary docs -- any takers?  -ml
- */
-/*
- * I did this, but it doesnt work - there is no reasonable way to find the
- * correspondence between the BIOS numbering of the disks and the Linux
- * numbering. -aeb
- *
- * The code below is bad. One of the problems is that drives 1 and 2
- * may be SCSI disks (even when IDE disks are present), so that
- * the geometry we read here from BIOS is attributed to the wrong disks.
- * Consequently, also the former "drive->present = 1" below was a mistake.
- *
- * Eventually the entire routine below should be removed.
- *
- * 17-OCT-2000 rjohnson@analogic.com Added spin-locks for reading CMOS
- * chip.
- */
-
-void probe_cmos_for_drives (ide_hwif_t *hwif)
-{
-#ifdef __i386__
-	extern struct drive_info_struct drive_info;
-	byte cmos_disks, *BIOS = (byte *) &drive_info;
-	int unit;
-	unsigned long flags;
-
-#ifdef CONFIG_BLK_DEV_PDC4030
-	if (hwif->chipset == ide_pdc4030 && hwif->channel != 0)
-		return;
-#endif /* CONFIG_BLK_DEV_PDC4030 */
-	spin_lock_irqsave(&rtc_lock, flags);
-	cmos_disks = CMOS_READ(0x12);
-	spin_unlock_irqrestore(&rtc_lock, flags);
-	/* Extract drive geometry from CMOS+BIOS if not already setup */
-	for (unit = 0; unit < MAX_DRIVES; ++unit) {
-		ide_drive_t *drive = &hwif->drives[unit];
-
-		if ((cmos_disks & (0xf0 >> (unit*4)))
-		   && !drive->present && !drive->nobios) {
-			unsigned short cyl = *(unsigned short *)BIOS;
-			unsigned char head = *(BIOS+2);
-			unsigned char sect = *(BIOS+14);
-			if (cyl > 0 && head > 0 && sect > 0 && sect < 64) {
-				drive->cyl   = drive->bios_cyl  = cyl;
-				drive->head  = drive->bios_head = head;
-				drive->sect  = drive->bios_sect = sect;
-				drive->ctl   = *(BIOS+8);
-			} else {
-				printk("hd%c: C/H/S=%d/%d/%d from BIOS ignored\n",
-				       unit+'a', cyl, head, sect);
-			}
-		}
-
-		BIOS += 16;
-	}
-#endif
-}
-#endif /* CONFIG_BLK_DEV_IDE */
-
-
 #if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
 
 extern ide_drive_t * get_info_ptr(kdev_t);
@@ -105,14 +27,14 @@
 	unsigned long total;
 
 	/*
-	 * The specs say: take geometry as obtained from Identify,
-	 * compute total capacity C*H*S from that, and truncate to
-	 * 1024*255*63. Now take S=63, H the first in the sequence
-	 * 4, 8, 16, 32, 64, 128, 255 such that 63*H*1024 >= total.
-	 * [Please tell aeb@cwi.nl in case this computes a
-	 * geometry different from what OnTrack uses.]
+	 * The specs say: take geometry as obtained from Identify, compute
+	 * total capacity C*H*S from that, and truncate to 1024*255*63. Now
+	 * take S=63, H the first in the sequence 4, 8, 16, 32, 64, 128, 255
+	 * such that 63*H*1024 >= total.  [Please tell aeb@cwi.nl in case this
+	 * computes a geometry different from what OnTrack uses.]
 	 */
-	total = DRIVER(drive)->capacity(drive);
+
+	total = ata_ops(drive)->capacity(drive);
 
 	*s = 63;
 
diff -ur linux-2.5.5/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux-2.5.5/drivers/ide/ide-probe.c	Sun Feb 24 16:32:49 2002
+++ linux/drivers/ide/ide-probe.c	Tue Feb 26 01:19:39 2002
@@ -130,17 +130,17 @@
 		}
 #endif /* CONFIG_BLK_DEV_PDC4030 */
 		switch (type) {
-			case ide_floppy:
+			case ATA_FLOPPY:
 				if (!strstr(id->model, "CD-ROM")) {
 					if (!strstr(id->model, "oppy") && !strstr(id->model, "poyp") && !strstr(id->model, "ZIP"))
 						printk("cdrom or floppy?, assuming ");
-					if (drive->media != ide_cdrom) {
+					if (drive->type != ATA_ROM) {
 						printk ("FLOPPY");
 						break;
 					}
 				}
-				type = ide_cdrom;	/* Early cdrom models used zero */
-			case ide_cdrom:
+				type = ATA_ROM;	/* Early cdrom models used zero */
+			case ATA_ROM:
 				drive->removable = 1;
 #ifdef CONFIG_PPC
 				/* kludge for Apple PowerBook internal zip */
@@ -152,10 +152,10 @@
 #endif
 				printk ("CD/DVD-ROM");
 				break;
-			case ide_tape:
+			case ATA_TAPE:
 				printk ("TAPE");
 				break;
-			case ide_optical:
+			case ATA_MOD:
 				printk ("OPTICAL");
 				drive->removable = 1;
 				break;
@@ -164,7 +164,7 @@
 				break;
 		}
 		printk (" drive\n");
-		drive->media = type;
+		drive->type = type;
 		return;
 	}
 
@@ -184,7 +184,7 @@
 			mate->noprobe = 1;
 		}
 	}
-	drive->media = ide_disk;
+	drive->type = ATA_DISK;
 	printk("ATA DISK drive\n");
 	QUIRK_LIST(HWIF(drive),drive);
 	return;
@@ -327,12 +327,12 @@
 	int rc;
 	ide_hwif_t *hwif = HWIF(drive);
 	if (drive->present) {	/* avoid waiting for inappropriate probes */
-		if ((drive->media != ide_disk) && (cmd == WIN_IDENTIFY))
+		if ((drive->type != ATA_DISK) && (cmd == WIN_IDENTIFY))
 			return 4;
 	}
 #ifdef DEBUG
-	printk("probing for %s: present=%d, media=%d, probetype=%s\n",
-		drive->name, drive->present, drive->media,
+	printk("probing for %s: present=%d, type=%d, probetype=%s\n",
+		drive->name, drive->present, drive->type,
 		(cmd == WIN_IDENTIFY) ? "ATA" : "ATAPI");
 #endif
 	ide_delay_50ms();	/* needed for some systems (e.g. crw9624 as drive0 with disk as slave) */
@@ -421,10 +421,10 @@
 	if (!drive->present)
 		return;			/* drive not found */
 	if (drive->id == NULL) {		/* identification failed? */
-		if (drive->media == ide_disk) {
+		if (drive->type == ATA_DISK) {
 			printk ("%s: non-IDE drive, CHS=%d/%d/%d\n",
 			 drive->name, drive->cyl, drive->head, drive->sect);
-		} else if (drive->media == ide_cdrom) {
+		} else if (drive->type == ATA_ROM) {
 			printk("%s: ATAPI cdrom (?)\n", drive->name);
 		} else {
 			drive->present = 0;	/* nuke it */
@@ -481,33 +481,31 @@
 	    ((unsigned long)hwif->io_ports[IDE_STATUS_OFFSET])) {
 		ide_request_region(hwif->io_ports[IDE_DATA_OFFSET], 8, hwif->name);
 		hwif->straight8 = 1;
-		goto jump_straight8;
-	}
-
-	if (hwif->io_ports[IDE_DATA_OFFSET])
-		ide_request_region(hwif->io_ports[IDE_DATA_OFFSET], 1, hwif->name);
-	if (hwif->io_ports[IDE_ERROR_OFFSET])
-		ide_request_region(hwif->io_ports[IDE_ERROR_OFFSET], 1, hwif->name);
-	if (hwif->io_ports[IDE_NSECTOR_OFFSET])
-		ide_request_region(hwif->io_ports[IDE_NSECTOR_OFFSET], 1, hwif->name);
-	if (hwif->io_ports[IDE_SECTOR_OFFSET])
-		ide_request_region(hwif->io_ports[IDE_SECTOR_OFFSET], 1, hwif->name);
-	if (hwif->io_ports[IDE_LCYL_OFFSET])
-		ide_request_region(hwif->io_ports[IDE_LCYL_OFFSET], 1, hwif->name);
-	if (hwif->io_ports[IDE_HCYL_OFFSET])
-		ide_request_region(hwif->io_ports[IDE_HCYL_OFFSET], 1, hwif->name);
-	if (hwif->io_ports[IDE_SELECT_OFFSET])
-		ide_request_region(hwif->io_ports[IDE_SELECT_OFFSET], 1, hwif->name);
-	if (hwif->io_ports[IDE_STATUS_OFFSET])
-		ide_request_region(hwif->io_ports[IDE_STATUS_OFFSET], 1, hwif->name);
+	} else {
+		if (hwif->io_ports[IDE_DATA_OFFSET])
+			ide_request_region(hwif->io_ports[IDE_DATA_OFFSET], 1, hwif->name);
+		if (hwif->io_ports[IDE_ERROR_OFFSET])
+			ide_request_region(hwif->io_ports[IDE_ERROR_OFFSET], 1, hwif->name);
+		if (hwif->io_ports[IDE_NSECTOR_OFFSET])
+			ide_request_region(hwif->io_ports[IDE_NSECTOR_OFFSET], 1, hwif->name);
+		if (hwif->io_ports[IDE_SECTOR_OFFSET])
+			ide_request_region(hwif->io_ports[IDE_SECTOR_OFFSET], 1, hwif->name);
+		if (hwif->io_ports[IDE_LCYL_OFFSET])
+			ide_request_region(hwif->io_ports[IDE_LCYL_OFFSET], 1, hwif->name);
+		if (hwif->io_ports[IDE_HCYL_OFFSET])
+			ide_request_region(hwif->io_ports[IDE_HCYL_OFFSET], 1, hwif->name);
+		if (hwif->io_ports[IDE_SELECT_OFFSET])
+			ide_request_region(hwif->io_ports[IDE_SELECT_OFFSET], 1, hwif->name);
+		if (hwif->io_ports[IDE_STATUS_OFFSET])
+			ide_request_region(hwif->io_ports[IDE_STATUS_OFFSET], 1, hwif->name);
 
-jump_straight8:
+	}
 	if (hwif->io_ports[IDE_CONTROL_OFFSET])
 		ide_request_region(hwif->io_ports[IDE_CONTROL_OFFSET], 1, hwif->name);
 #if defined(CONFIG_AMIGA) || defined(CONFIG_MAC)
 	if (hwif->io_ports[IDE_IRQ_OFFSET])
 		ide_request_region(hwif->io_ports[IDE_IRQ_OFFSET], 1, hwif->name);
-#endif /* (CONFIG_AMIGA) || (CONFIG_MAC) */
+#endif
 }
 
 /*
@@ -521,13 +519,6 @@
 
 	if (hwif->noprobe)
 		return;
-#ifdef CONFIG_BLK_DEV_IDE
-	if (hwif->io_ports[IDE_DATA_OFFSET] == HD_DATA) {
-		extern void probe_cmos_for_drives(ide_hwif_t *);
-
-		probe_cmos_for_drives (hwif);
-	}
-#endif
 
 	if ((hwif->chipset != ide_4drives || !hwif->mate->present) &&
 #if CONFIG_BLK_DEV_PDC4030
@@ -545,7 +536,7 @@
 		}
 		if (!msgout)
 			printk("%s: ports already in use, skipping probe\n", hwif->name);
-		return;	
+		return;
 	}
 
 	__save_flags(flags);	/* local CPU only */
@@ -796,60 +787,51 @@
 static void init_gendisk (ide_hwif_t *hwif)
 {
 	struct gendisk *gd;
-	unsigned int unit, units, minors, i;
+	unsigned int unit, minors, i;
 	extern devfs_handle_t ide_devfs_handle;
 
-#if 1
-	units = MAX_DRIVES;
-#else
-	/* figure out maximum drive number on the interface */
-	for (units = MAX_DRIVES; units > 0; --units) {
-		if (hwif->drives[units-1].present)
-			break;
-	}
-#endif
-
-	minors = units * (1<<PARTN_BITS);
+	minors = MAX_DRIVES * (1 << PARTN_BITS);
 
 	gd = kmalloc (sizeof(struct gendisk), GFP_KERNEL);
 	if (!gd)
 		goto err_kmalloc_gd;
+
 	gd->sizes = kmalloc (minors * sizeof(int), GFP_KERNEL);
 	if (!gd->sizes)
 		goto err_kmalloc_gd_sizes;
+
 	gd->part = kmalloc (minors * sizeof(struct hd_struct), GFP_KERNEL);
 	if (!gd->part)
 		goto err_kmalloc_gd_part;
+	memset(gd->part, 0, minors * sizeof(struct hd_struct));
+
 	blksize_size[hwif->major] = kmalloc (minors*sizeof(int), GFP_KERNEL);
 	if (!blksize_size[hwif->major])
 		goto err_kmalloc_bs;
-
-	memset(gd->part, 0, minors * sizeof(struct hd_struct));
-
 	for (i = 0; i < minors; ++i)
 	    blksize_size[hwif->major][i] = BLOCK_SIZE;
-	for (unit = 0; unit < units; ++unit)
+
+	for (unit = 0; unit < MAX_DRIVES; ++unit)
 		hwif->drives[unit].part = &gd->part[unit << PARTN_BITS];
 
 	gd->major	= hwif->major;		/* our major device number */
 	gd->major_name	= IDE_MAJOR_NAME;	/* treated special in genhd.c */
 	gd->minor_shift	= PARTN_BITS;		/* num bits for partitions */
-	gd->nr_real	= units;		/* current num real drives */
+	gd->nr_real	= MAX_DRIVES;		/* current num real drives */
 	gd->next	= NULL;			/* linked list of major devs */
 	gd->fops        = ide_fops;             /* file operations */
-	gd->de_arr	= kmalloc (sizeof *gd->de_arr * units, GFP_KERNEL);
-	gd->flags	= kmalloc (sizeof *gd->flags * units, GFP_KERNEL);
+	gd->de_arr	= kmalloc(sizeof(*gd->de_arr) * MAX_DRIVES, GFP_KERNEL);
+	gd->flags	= kmalloc(sizeof(*gd->flags) * MAX_DRIVES, GFP_KERNEL);
 	if (gd->de_arr)
-		memset (gd->de_arr, 0, sizeof *gd->de_arr * units);
+		memset(gd->de_arr, 0, sizeof(*gd->de_arr) * MAX_DRIVES);
 	if (gd->flags)
-		memset (gd->flags, 0, sizeof *gd->flags * units);
+		memset(gd->flags, 0, sizeof(*gd->flags) * MAX_DRIVES);
 
 	hwif->gd = gd;
 	add_gendisk(gd);
 
-	for (unit = 0; unit < units; ++unit) {
-#if 1
-		char name[64];
+	for (unit = 0; unit < MAX_DRIVES; ++unit) {
+		char name[80];
 		ide_add_generic_settings(hwif->drives + unit);
 		hwif->drives[unit].dn = ((hwif->channel ? 2 : 0) + unit);
 		sprintf (name, "host%d/bus%d/target%d/lun%d",
@@ -858,19 +840,6 @@
 			hwif->channel, unit, hwif->drives[unit].lun);
 		if (hwif->drives[unit].present)
 			hwif->drives[unit].de = devfs_mk_dir(ide_devfs_handle, name, NULL);
-#else
-		if (hwif->drives[unit].present) {
-			char name[64];
-
-			ide_add_generic_settings(hwif->drives + unit);
-			hwif->drives[unit].dn = ((hwif->channel ? 2 : 0) + unit);
-			sprintf (name, "host%d/bus%d/target%d/lun%d",
-				 (hwif->channel && hwif->mate) ? hwif->mate->index : hwif->index,
-				 hwif->channel, unit, hwif->drives[unit].lun);
-			hwif->drives[unit].de =
-				devfs_mk_dir (ide_devfs_handle, name, NULL);
-		}
-#endif
 	}
 	return;
 
@@ -881,7 +850,7 @@
 err_kmalloc_gd_sizes:
 	kfree(gd);
 err_kmalloc_gd:
-	printk(KERN_WARNING "(ide::init_gendisk) Out of memory\n");
+	printk(KERN_CRIT "(ide::init_gendisk) Out of memory\n");
 	return;
 }
 
diff -ur linux-2.5.5/drivers/ide/ide-proc.c linux/drivers/ide/ide-proc.c
--- linux-2.5.5/drivers/ide/ide-proc.c	Sun Feb 24 16:32:54 2002
+++ linux/drivers/ide/ide-proc.c	Tue Feb 26 01:37:25 2002
@@ -202,7 +202,7 @@
 	memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
 
 	taskfile.sector_count = 0x01;
-	taskfile.command = (drive->media == ide_disk) ? WIN_IDENTIFY : WIN_PIDENTIFY ;
+	taskfile.command = (drive->type == ATA_DISK) ? WIN_IDENTIFY : WIN_PIDENTIFY ;
 
 	return ide_wait_taskfile(drive, &taskfile, &hobfile, buf);
 }
@@ -346,9 +346,9 @@
 int proc_ide_read_capacity
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	ide_drive_t	*drive = data;
-	ide_driver_t    *driver = drive->driver;
-	int		len;
+	ide_drive_t *drive = data;
+	struct ata_operations *driver = drive->driver;
+	int len;
 
 	if (!driver)
 		len = sprintf(page, "(none)\n");
@@ -381,58 +381,31 @@
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
 
-static int proc_ide_read_driver
-	(char *page, char **start, off_t off, int count, int *eof, void *data)
-{
-	ide_drive_t	*drive = (ide_drive_t *) data;
-	ide_driver_t	*driver = drive->driver;
-	int		len;
-
-	if (!driver)
-		len = sprintf(page, "(none)\n");
-	else
-		len = sprintf(page, "%s\n", driver->name);
-	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
-}
-
-static int proc_ide_write_driver
-	(struct file *file, const char *buffer, unsigned long count, void *data)
-{
-	ide_drive_t	*drive = data;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-	if (ide_replace_subdriver(drive, buffer))
-		return -EINVAL;
-	return count;
-}
-
 static int proc_ide_read_media
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
 	ide_drive_t	*drive = data;
-	const char	*media;
+	const char	*type;
 	int		len;
 
-	switch (drive->media) {
-		case ide_disk:	media = "disk\n";
+	switch (drive->type) {
+		case ATA_DISK:	type = "disk\n";
 				break;
-		case ide_cdrom:	media = "cdrom\n";
+		case ATA_ROM:	type = "cdrom\n";
 				break;
-		case ide_tape:	media = "tape\n";
+		case ATA_TAPE:	type = "tape\n";
 				break;
-		case ide_floppy:media = "floppy\n";
+		case ATA_FLOPPY:type = "floppy\n";
 				break;
-		default:	media = "UNKNOWN\n";
+		default:	type = "UNKNOWN\n";
 				break;
 	}
-	strcpy(page,media);
-	len = strlen(media);
+	strcpy(page,type);
+	len = strlen(type);
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
 
 static ide_proc_entry_t generic_drive_entries[] = {
-	{ "driver",	S_IFREG|S_IRUGO,	proc_ide_read_driver,	proc_ide_write_driver },
 	{ "identify",	S_IFREG|S_IRUSR,	proc_ide_read_identify,	NULL },
 	{ "media",	S_IFREG|S_IRUGO,	proc_ide_read_media,	NULL },
 	{ "model",	S_IFREG|S_IRUGO,	proc_ide_read_dmodel,	NULL },
@@ -476,7 +449,7 @@
 
 	for (d = 0; d < MAX_DRIVES; d++) {
 		ide_drive_t *drive = &hwif->drives[d];
-		ide_driver_t *driver = drive->driver;
+		struct ata_operations *driver = drive->driver;
 
 		if (!drive->present)
 			continue;
@@ -497,35 +470,9 @@
 	}
 }
 
-void recreate_proc_ide_device(ide_hwif_t *hwif, ide_drive_t *drive)
-{
-	struct proc_dir_entry *ent;
-	struct proc_dir_entry *parent = hwif->proc;
-	char name[64];
-
-	if (drive->present && !drive->proc) {
-		drive->proc = proc_mkdir(drive->name, parent);
-		if (drive->proc)
-			ide_add_proc_entries(drive->proc, generic_drive_entries, drive);
-
-/*
- * assume that we have these already, however, should test FIXME!
- * if (driver) {
- *      ide_add_proc_entries(drive->proc, generic_subdriver_entries, drive);
- *      ide_add_proc_entries(drive->proc, driver->proc, drive);
- * }
- *
- */
-		sprintf(name,"ide%d/%s", (drive->name[2]-'a')/2, drive->name);
-		ent = proc_symlink(drive->name, proc_ide_root, name);
-		if (!ent)
-			return;
-	}
-}
-
-void destroy_proc_ide_device(ide_hwif_t *hwif, ide_drive_t *drive)
+static void destroy_proc_ide_device(ide_hwif_t *hwif, ide_drive_t *drive)
 {
-	ide_driver_t *driver = drive->driver;
+	struct ata_operations *driver = drive->driver;
 
 	if (drive->proc) {
 		if (driver)
diff -ur linux-2.5.5/drivers/ide/ide-tape.c linux/drivers/ide/ide-tape.c
--- linux-2.5.5/drivers/ide/ide-tape.c	Sun Feb 24 16:32:45 2002
+++ linux/drivers/ide/ide-tape.c	Tue Feb 26 01:42:59 2002
@@ -6098,8 +6098,11 @@
 	}
 	idetape_chrdevs[minor].drive = NULL;
 	restore_flags (flags);	/* all CPUs (overkill?) */
-	DRIVER(drive)->busy = 0;
-	(void) ide_unregister_subdriver (drive);
+
+	/* FIXME: this appears to be totally wrong! */
+	ata_ops(drive)->busy = 0;
+
+	ide_unregister_subdriver (drive);
 	drive->driver_data = NULL;
 	devfs_unregister (tape->de_r);
 	devfs_unregister (tape->de_n);
@@ -6137,17 +6140,13 @@
 
 #endif
 
-int idetape_reinit(ide_drive_t *drive);
+static int idetape_reinit(ide_drive_t *drive);
 
 /*
  *	IDE subdriver functions, registered with ide.c
  */
-static ide_driver_t idetape_driver = {
-	name:			"ide-tape",
-	media:			ide_tape,
-	busy:			1,
-	supports_dma:		1,
-	supports_dsc_overlap: 	1,
+static struct ata_operations idetape_driver = {
+	owner:			THIS_MODULE,
 	cleanup:		idetape_cleanup,
 	standby:		NULL,
 	flushcache:		NULL,
@@ -6176,90 +6175,10 @@
 	release:	idetape_chrdev_release,
 };
 
-int idetape_reinit (ide_drive_t *drive)
+/* This will propably just go entierly away... */
+static int idetape_reinit (ide_drive_t *drive)
 {
-#if 0
-	idetape_tape_t *tape;
-	int minor, failed = 0, supported = 0;
-/* DRIVER(drive)->busy++; */
-	MOD_INC_USE_COUNT;
-#if ONSTREAM_DEBUG
-        printk(KERN_INFO "ide-tape: MOD_INC_USE_COUNT in idetape_init\n");
-#endif
-	if (!idetape_chrdev_present)
-		for (minor = 0; minor < MAX_HWIFS * MAX_DRIVES; minor++ )
-			idetape_chrdevs[minor].drive = NULL;
-
-	if ((drive = ide_scan_devices (ide_tape, idetape_driver.name, NULL, failed++)) == NULL) {
-		revalidate_drives();
-		MOD_DEC_USE_COUNT;
-#if ONSTREAM_DEBUG
-		printk(KERN_INFO "ide-tape: MOD_DEC_USE_COUNT in idetape_init\n");
-#endif
-		return 0;
-	}
-	if (!idetape_chrdev_present &&
-	    devfs_register_chrdev (IDETAPE_MAJOR, "ht", &idetape_fops)) {
-		printk (KERN_ERR "ide-tape: Failed to register character device interface\n");
-		MOD_DEC_USE_COUNT;
-#if ONSTREAM_DEBUG
-		printk(KERN_INFO "ide-tape: MOD_DEC_USE_COUNT in idetape_init\n");
-#endif
-		return -EBUSY;
-	}
-	do {
-		if (!idetape_identify_device (drive, drive->id)) {
-			printk (KERN_ERR "ide-tape: %s: not supported by this version of ide-tape\n", drive->name);
-			continue;
-		}
-		if (drive->scsi) {
-			if (strstr(drive->id->model, "OnStream DI-30")) {
-				printk("ide-tape: ide-scsi emulation is not supported for %s.\n", drive->id->model);
-			} else {
-				printk("ide-tape: passing drive %s to ide-scsi emulation.\n", drive->name);
-				continue;
-			}
-		}
-		tape = (idetape_tape_t *) kmalloc (sizeof (idetape_tape_t), GFP_KERNEL);
-		if (tape == NULL) {
-			printk (KERN_ERR "ide-tape: %s: Can't allocate a tape structure\n", drive->name);
-			continue;
-		}
-		if (ide_register_subdriver (drive, &idetape_driver)) {
-			printk (KERN_ERR "ide-tape: %s: Failed to register the driver with ide.c\n", drive->name);
-			kfree (tape);
-			continue;
-		}
-		for (minor = 0; idetape_chrdevs[minor].drive != NULL; minor++);
-		idetape_setup (drive, tape, minor);
-		idetape_chrdevs[minor].drive = drive;
-		tape->de_r =
-		    devfs_register (drive->de, "mt", DEVFS_FL_DEFAULT,
-				    HWIF(drive)->major, minor,
-				    S_IFCHR | S_IRUGO | S_IWUGO,
-				    &idetape_fops, NULL);
-		tape->de_n =
-		    devfs_register (drive->de, "mtn", DEVFS_FL_DEFAULT,
-				    HWIF(drive)->major, minor + 128,
-				    S_IFCHR | S_IRUGO | S_IWUGO,
-				    &idetape_fops, NULL);
-		devfs_register_tape (tape->de_r);
-		supported++; failed--;
-	} while ((drive = ide_scan_devices (ide_tape, idetape_driver.name, NULL, failed++)) != NULL);
-	if (!idetape_chrdev_present && !supported) {
-		devfs_unregister_chrdev (IDETAPE_MAJOR, "ht");
-	} else
-		idetape_chrdev_present = 1;
-	revalidate_drives();
-	MOD_DEC_USE_COUNT;
-#if ONSTREAM_DEBUG
-	printk(KERN_INFO "ide-tape: MOD_DEC_USE_COUNT in idetape_init\n");
-#endif
-
-	return 0;
-#else
 	return 1;
-#endif
 }
 
 MODULE_DESCRIPTION("ATAPI Streaming TAPE Driver");
@@ -6294,7 +6213,7 @@
 		for (minor = 0; minor < MAX_HWIFS * MAX_DRIVES; minor++ )
 			idetape_chrdevs[minor].drive = NULL;
 
-	if ((drive = ide_scan_devices (ide_tape, idetape_driver.name, NULL, failed++)) == NULL) {
+	if ((drive = ide_scan_devices(ATA_TAPE, "ide-tape", NULL, failed++)) == NULL) {
 		revalidate_drives();
 		MOD_DEC_USE_COUNT;
 #if ONSTREAM_DEBUG
@@ -6349,7 +6268,7 @@
 				    &idetape_fops, NULL);
 		devfs_register_tape (tape->de_r);
 		supported++; failed--;
-	} while ((drive = ide_scan_devices (ide_tape, idetape_driver.name, NULL, failed++)) != NULL);
+	} while ((drive = ide_scan_devices(ATA_TAPE, "ide-tape", NULL, failed++)) != NULL);
 	if (!idetape_chrdev_present && !supported) {
 		devfs_unregister_chrdev (IDETAPE_MAJOR, "ht");
 	} else
diff -ur linux-2.5.5/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.5/drivers/ide/ide-taskfile.c	Sun Feb 24 16:32:54 2002
+++ linux/drivers/ide/ide-taskfile.c	Tue Feb 26 00:31:26 2002
@@ -648,7 +648,7 @@
 
 	if (rq->errors >= ERROR_MAX) {
 		if (drive->driver != NULL)
-			DRIVER(drive)->end_request(0, HWGROUP(drive));
+			ata_ops(drive)->end_request(0, HWGROUP(drive));
 		else
 			ide_end_request(drive, 0);
 	} else {
diff -ur linux-2.5.5/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.5/drivers/ide/ide.c	Sun Feb 24 16:32:54 2002
+++ linux/drivers/ide/ide.c	Tue Feb 26 01:15:47 2002
@@ -1,6 +1,4 @@
 /*
- *  linux/drivers/ide/ide.c		Version 6.31	June 9, 2000
- *
  *  Copyright (C) 1994-1998  Linus Torvalds & authors (see below)
  */
 
@@ -114,17 +112,12 @@
  *			Native ATA-100 support
  *			Prep for Cascades Project
  * Version 6.32		4GB highmem support for DMA, and mapping of those for
- * 			PIO transfer (Jens Axboe)
+ *			PIO transfer (Jens Axboe)
  *
  *  Some additional driver compile-time options are in ./include/linux/ide.h
- *
- *  To do, in likely order of completion:
- *	- modify kernel to obtain BIOS geometry for drives on 2nd/3rd/4th i/f
- *
  */
 
-#define	REVISION	"Revision: 6.32"
-#define	VERSION		"Id: ide.c 6.32 2001/05/24"
+#define	VERSION	"7.0.0"
 
 #undef REALLY_SLOW_IO		/* most systems can safely undef this */
 
@@ -254,8 +247,6 @@
 /* default maximum number of failures */
 #define IDE_DEFAULT_MAX_FAILURES	1
 
-static const byte ide_hwif_to_major[] = { IDE0_MAJOR, IDE1_MAJOR, IDE2_MAJOR, IDE3_MAJOR, IDE4_MAJOR, IDE5_MAJOR, IDE6_MAJOR, IDE7_MAJOR, IDE8_MAJOR, IDE9_MAJOR };
-
 static int	idebus_parameter; /* holds the "idebus=" parameter */
 int system_bus_speed; /* holds what we think is VESA/PCI bus speed */
 static int	initializing;     /* set while initializing built-in drivers */
@@ -418,6 +409,11 @@
  */
 static void init_hwif_data (unsigned int index)
 {
+	static const byte ide_major[] = {
+		IDE0_MAJOR, IDE1_MAJOR, IDE2_MAJOR, IDE3_MAJOR, IDE4_MAJOR,
+		IDE5_MAJOR, IDE6_MAJOR, IDE7_MAJOR, IDE8_MAJOR, IDE9_MAJOR
+	};
+
 	unsigned int unit;
 	hw_regs_t hw;
 	ide_hwif_t *hwif = &ide_hwifs[index];
@@ -436,16 +432,13 @@
 	if (hwif->io_ports[IDE_DATA_OFFSET] == HD_DATA)
 		hwif->noprobe = 1; /* may be overridden by ide_setup() */
 #endif /* CONFIG_BLK_DEV_HD */
-	hwif->major	= ide_hwif_to_major[index];
-	hwif->name[0]	= 'i';
-	hwif->name[1]	= 'd';
-	hwif->name[2]	= 'e';
-	hwif->name[3]	= '0' + index;
+	hwif->major = ide_major[index];
+	sprintf(hwif->name, "ide%d", index);
 	hwif->bus_state = BUSSTATE_ON;
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		ide_drive_t *drive = &hwif->drives[unit];
 
-		drive->media			= ide_disk;
+		drive->type			= ATA_DISK;
 		drive->select.all		= (unit<<4)|0xa0;
 		drive->hwif			= hwif;
 		drive->ctl			= 0x08;
@@ -453,9 +446,7 @@
 		drive->bad_wstat		= BAD_W_STAT;
 		drive->special.b.recalibrate	= 1;
 		drive->special.b.set_geometry	= 1;
-		drive->name[0]			= 'h';
-		drive->name[1]			= 'd';
-		drive->name[2]			= 'a' + (index * MAX_DRIVES) + unit;
+		sprintf(drive->name, "hd%c", 'a' + (index * MAX_DRIVES) + unit);
 		drive->max_failures		= IDE_DEFAULT_MAX_FAILURES;
 		init_waitqueue_head(&drive->wqueue);
 	}
@@ -591,19 +582,18 @@
 }
 
 /*
- * current_capacity() returns the capacity (in sectors) of a drive
- * according to its current geometry/LBA settings.
+ * The capacity of a drive according to its current geometry/LBA settings in
+ * sectors.
  */
 unsigned long current_capacity (ide_drive_t *drive)
 {
-	if (!drive->present)
+	if (!drive->present || !drive->driver)
 		return 0;
-	if (drive->driver != NULL)
-		return DRIVER(drive)->capacity(drive);
-	return 0;
+	return ata_ops(drive)->capacity(drive);
 }
 
 extern struct block_device_operations ide_fops[];
+
 /*
  * ide_geninit() is called exactly *once* for each interface.
  */
@@ -617,7 +607,7 @@
 
 		if (!drive->present)
 			continue;
-		if (drive->media!=ide_disk && drive->media!=ide_floppy)
+		if (drive->type != ATA_DISK && drive->type != ATA_FLOPPY)
 			continue;
 		register_disk(gd,mk_kdev(hwif->major,unit<<PARTN_BITS),
 #ifdef CONFIG_BLK_DEV_ISAPNP
@@ -728,7 +718,7 @@
 static void pre_reset (ide_drive_t *drive)
 {
 	if (drive->driver != NULL)
-		DRIVER(drive)->pre_reset(drive);
+		ata_ops(drive)->pre_reset(drive);
 
 	if (!drive->keep_settings) {
 		if (drive->using_dma) {
@@ -769,7 +759,7 @@
 	__cli();		/* local CPU only */
 
 	/* For an ATAPI device, first try an ATAPI SRST. */
-	if (drive->media != ide_disk && !do_not_try_atapi) {
+	if (drive->type != ATA_DISK && !do_not_try_atapi) {
 		pre_reset(drive);
 		SELECT_DRIVE(hwif,drive);
 		udelay (20);
@@ -938,7 +928,7 @@
 		err = GET_ERR();
 		printk("%s: %s: error=0x%02x", drive->name, msg, err);
 #if FANCY_STATUS_DUMPS
-		if (drive->media == ide_disk) {
+		if (drive->type == ATA_DISK) {
 			printk(" { ");
 			if (err & ABRT_ERR)	printk("DriveStatusError ");
 			if (err & ICRC_ERR)	printk("%s", (err & ABRT_ERR) ? "BadCRC " : "BadSector ");
@@ -997,7 +987,7 @@
 {
 	int i = (drive->mult_count ? drive->mult_count : 1) * SECTOR_WORDS;
 
-	if (drive->media != ide_disk)
+	if (drive->type != ATA_DISK)
 		return;
 	while (i > 0) {
 		u32 buffer[16];
@@ -1033,7 +1023,7 @@
 	if (stat & BUSY_STAT || ((stat & WRERR_STAT) && !drive->nowerr)) { /* other bits are useless when BUSY */
 		rq->errors |= ERROR_RESET;
 	} else {
-		if (drive->media == ide_disk && (stat & ERR_STAT)) {
+		if (drive->type == ATA_DISK && (stat & ERR_STAT)) {
 			/* err has different meaning on cdrom and tape */
 			if (err == ABRT_ERR) {
 				if (drive->select.b.lba && IN_BYTE(IDE_COMMAND_REG) == WIN_SPECIFY)
@@ -1053,8 +1043,9 @@
 		OUT_BYTE(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG);	/* force an abort */
 
 	if (rq->errors >= ERROR_MAX) {
+		/* ATA-PATTERN */
 		if (drive->driver != NULL)
-			DRIVER(drive)->end_request(drive, 0);
+			ata_ops(drive)->end_request(drive, 0);
 		else
 			ide_end_request(drive, 0);
 	} else {
@@ -1126,7 +1117,7 @@
 		if (tuneproc != NULL)
 			tuneproc(drive, drive->tune_req);
 	} else if (drive->driver != NULL) {
-		return DRIVER(drive)->special(drive);
+		return ata_ops(drive)->special(drive);
 	} else if (s->all) {
 		printk("%s: bad special flag: 0x%02x\n", drive->name, s->all);
 		s->all = 0;
@@ -1324,8 +1315,8 @@
 	block    = rq->sector;
 
 	/* Strange disk manager remap */
-	if ((rq->flags & REQ_CMD) && 
-	    (drive->media == ide_disk || drive->media == ide_floppy)) {
+	if ((rq->flags & REQ_CMD) &&
+	    (drive->type == ATA_DISK || drive->type == ATA_FLOPPY)) {
 		block += drive->sect0;
 	}
 	/* Yecch - this will shift the entire interval,
@@ -1340,7 +1331,7 @@
 	SELECT_DRIVE(hwif, drive);
 	if (ide_wait_stat(&startstop, drive, drive->ready_stat,
 			  BUSY_STAT|DRQ_STAT, WAIT_READY)) {
-		printk("%s: drive not ready for command\n", drive->name);
+		printk(KERN_WARNING "%s: drive not ready for command\n", drive->name);
 		return startstop;
 	}
 	if (!drive->special.all) {
@@ -1348,16 +1339,16 @@
 			return execute_drive_cmd(drive, rq);
 
 		if (drive->driver != NULL) {
-			return (DRIVER(drive)->do_request(drive, rq, block));
+			return ata_ops(drive)->do_request(drive, rq, block);
 		}
-		printk("%s: media type %d not supported\n",
-		       drive->name, drive->media);
+		printk(KERN_WARNING "%s: device type %d not supported\n",
+		       drive->name, drive->type);
 		goto kill_rq;
 	}
 	return do_special(drive);
 kill_rq:
 	if (drive->driver != NULL)
-		DRIVER(drive)->end_request(drive, 0);
+		ata_ops(drive)->end_request(drive, 0);
 	else
 		ide_end_request(drive, 0);
 	return ide_stopped;
@@ -1987,8 +1978,8 @@
 	if (res)
 		goto leave;
 
-	if (DRIVER(drive)->revalidate)
-		DRIVER(drive)->revalidate(drive);
+	if (ata_ops(drive)->revalidate)
+		ata_ops(drive)->revalidate(drive);
 
  leave:
 	drive->busy = 0;
@@ -2014,7 +2005,7 @@
 			if (drive->revalidate) {
 				drive->revalidate = 0;
 				if (!initializing)
-					(void) ide_revalidate_disk(mk_kdev(hwif->major, unit<<PARTN_BITS));
+					ide_revalidate_disk(mk_kdev(hwif->major, unit<<PARTN_BITS));
 			}
 		}
 	}
@@ -2047,27 +2038,44 @@
 		return -ENXIO;
 	if (drive->driver == NULL)
 		ide_driver_module();
+
+	/* Request a particular device type module.
+	 *
+	 * FIXME: The function which should rather requests the drivers is
+	 * ide_driver_module(), since it seems illogical and even a bit
+	 * dangerous to delay this until open time!
+	 */
+
 #ifdef CONFIG_KMOD
 	if (drive->driver == NULL) {
-		if (drive->media == ide_disk)
-			(void) request_module("ide-disk");
-		if (drive->media == ide_cdrom)
-			(void) request_module("ide-cd");
-		if (drive->media == ide_tape)
-			(void) request_module("ide-tape");
-		if (drive->media == ide_floppy)
-			(void) request_module("ide-floppy");
+		switch (drive->type) {
+			case ATA_DISK:
+				request_module("ide-disk");
+				break;
+			case ATA_ROM:
+				request_module("ide-cd");
+				break;
+			case ATA_TAPE:
+				request_module("ide-tape");
+				break;
+			case ATA_FLOPPY:
+				request_module("ide-floppy");
+				break;
 #if defined(CONFIG_BLK_DEV_IDESCSI) && defined(CONFIG_SCSI)
-		if (drive->media == ide_scsi)
-			(void) request_module("ide-scsi");
-#endif /* defined(CONFIG_BLK_DEV_IDESCSI) && defined(CONFIG_SCSI) */
+			case ATA_SCSI:
+				request_module("ide-scsi");
+				break;
+#endif
+			default:
+				/* nothing to be done about it */ ;
+		}
 	}
 #endif /* CONFIG_KMOD */
 	while (drive->busy)
 		sleep_on(&drive->wqueue);
 	drive->usage++;
 	if (drive->driver != NULL)
-		return DRIVER(drive)->open(inode, filp, drive);
+		return ata_ops(drive)->open(inode, filp, drive);
 	printk ("%s: driver not present\n", drive->name);
 	drive->usage--;
 	return -ENXIO;
@@ -2084,27 +2092,11 @@
 	if ((drive = get_info_ptr(inode->i_rdev)) != NULL) {
 		drive->usage--;
 		if (drive->driver != NULL)
-			DRIVER(drive)->release(inode, file, drive);
+			ata_ops(drive)->release(inode, file, drive);
 	}
 	return 0;
 }
 
-int ide_replace_subdriver (ide_drive_t *drive, const char *driver)
-{
-	if (!drive->present || drive->busy || drive->usage)
-		goto abort;
-	if (drive->driver != NULL && DRIVER(drive)->cleanup(drive))
-		goto abort;
-	strncpy(drive->driver_req, driver, 9);
-	ide_driver_module();
-	drive->driver_req[0] = 0;
-	ide_driver_module();
-	if (DRIVER(drive) && !strcmp(DRIVER(drive)->name, driver))
-		return 0;
-abort:
-	return 1;
-}
-
 #ifdef CONFIG_PROC_FS
 ide_proc_entry_t generic_subdriver_entries[] = {
 	{ "capacity",	S_IFREG|S_IRUGO,	proc_ide_read_capacity,	NULL },
@@ -2172,7 +2164,7 @@
 			continue;
 		if (drive->busy || drive->usage)
 			goto abort;
-		if (drive->driver != NULL && DRIVER(drive)->cleanup(drive))
+		if (drive->driver != NULL && ata_ops(drive)->cleanup(drive))
 			goto abort;
 	}
 	hwif->present = 0;
@@ -2306,7 +2298,6 @@
 	hwif->pci_dev		= old_hwif.pci_dev;
 #endif /* CONFIG_BLK_DEV_IDEPCI */
 	hwif->straight8		= old_hwif.straight8;
-	hwif->hwif_data		= old_hwif.hwif_data;
 abort:
 	restore_flags(flags);	/* all CPUs */
 }
@@ -2562,7 +2553,7 @@
 
 static int set_using_dma (ide_drive_t *drive, int arg)
 {
-	if (!drive->driver || !DRIVER(drive)->supports_dma)
+	if (!drive->driver)
 		return -EPERM;
 	if (!drive->id || !(drive->id->capability & 1) || !HWIF(drive)->dmaproc)
 		return -EPERM;
@@ -2690,7 +2681,9 @@
 		{
 			struct hd_geometry *loc = (struct hd_geometry *) arg;
 			unsigned short bios_cyl = drive->bios_cyl; /* truncate */
-			if (!loc || (drive->media != ide_disk && drive->media != ide_floppy)) return -EINVAL;
+
+			if (!loc || (drive->type != ATA_DISK && drive->type != ATA_FLOPPY))
+				return -EINVAL;
 			if (put_user(drive->bios_head, (byte *) &loc->heads)) return -EFAULT;
 			if (put_user(drive->bios_sect, (byte *) &loc->sectors)) return -EFAULT;
 			if (put_user(bios_cyl, (unsigned short *) &loc->cylinders)) return -EFAULT;
@@ -2702,7 +2695,9 @@
 		case HDIO_GETGEO_BIG:
 		{
 			struct hd_big_geometry *loc = (struct hd_big_geometry *) arg;
-			if (!loc || (drive->media != ide_disk && drive->media != ide_floppy)) return -EINVAL;
+
+			if (!loc || (drive->type != ATA_DISK && drive->type != ATA_FLOPPY))
+				return -EINVAL;
 
 			if (put_user(drive->bios_head, (byte *) &loc->heads)) return -EFAULT;
 			if (put_user(drive->bios_sect, (byte *) &loc->sectors)) return -EFAULT;
@@ -2715,7 +2710,8 @@
 		case HDIO_GETGEO_BIG_RAW:
 		{
 			struct hd_big_geometry *loc = (struct hd_big_geometry *) arg;
-			if (!loc || (drive->media != ide_disk && drive->media != ide_floppy)) return -EINVAL;
+			if (!loc || (drive->type != ATA_DISK && drive->type != ATA_FLOPPY))
+				return -EINVAL;
 			if (put_user(drive->head, (byte *) &loc->heads)) return -EFAULT;
 			if (put_user(drive->sect, (byte *) &loc->sectors)) return -EFAULT;
 			if (put_user(drive->cyl, (unsigned int *) &loc->cylinders)) return -EFAULT;
@@ -2750,15 +2746,15 @@
 		case HDIO_DRIVE_TASKFILE:
 		        if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 				return -EACCES;
-			switch(drive->media) {
-				case ide_disk:
+			switch(drive->type) {
+				case ATA_DISK:
 					return ide_taskfile_ioctl(drive, inode, file, cmd, arg);
 #ifdef CONFIG_PKT_TASK_IOCTL
-				case ide_cdrom:
-				case ide_tape:
-				case ide_floppy:
+				case ATA_CDROM:
+				case ATA_TAPE:
+				case ATA_FLOPPY:
 					return pkt_taskfile_ioctl(drive, inode, file, cmd, arg);
-#endif /* CONFIG_PKT_TASK_IOCTL */
+#endif
 				default:
 					return -ENOMSG;
 			}
@@ -2791,12 +2787,11 @@
 			return 0;
 		case HDIO_SET_NICE:
 			if (!capable(CAP_SYS_ADMIN)) return -EACCES;
-			if (drive->driver == NULL)
-				return -EPERM;
 			if (arg != (arg & ((1 << IDE_NICE_DSC_OVERLAP) | (1 << IDE_NICE_1))))
 				return -EPERM;
 			drive->dsc_overlap = (arg >> IDE_NICE_DSC_OVERLAP) & 1;
-			if (drive->dsc_overlap && !DRIVER(drive)->supports_dsc_overlap) {
+			/* Only CD-ROM's and tapes support DSC overlap. */
+			if (drive->dsc_overlap && !(drive->type == ATA_ROM || drive->type == ATA_TAPE)) {
 				drive->dsc_overlap = 0;
 				return -EPERM;
 			}
@@ -2872,7 +2867,7 @@
 
 		default:
 			if (drive->driver != NULL)
-				return DRIVER(drive)->ioctl(drive, inode, file, cmd, arg);
+				return ata_ops(drive)->ioctl(drive, inode, file, cmd, arg);
 			return -EPERM;
 	}
 }
@@ -2884,7 +2879,7 @@
 	if ((drive = get_info_ptr(i_rdev)) == NULL)
 		return -ENODEV;
 	if (drive->driver != NULL)
-		return DRIVER(drive)->media_change(drive);
+		return ata_ops(drive)->media_change(drive);
 	return 0;
 }
 
@@ -3068,7 +3063,6 @@
 	const char max_drive = 'a' + ((MAX_HWIFS * MAX_DRIVES) - 1);
 	const char max_hwif  = '0' + (MAX_HWIFS - 1);
 
-	
 	if (strncmp(s,"hd",2) == 0 && s[2] == '=')	/* hd= is for hd.c   */
 		return 0;				/* driver and not us */
 
@@ -3146,7 +3140,7 @@
 				goto done;
 			case -4: /* "cdrom" */
 				drive->present = 1;
-				drive->media = ide_cdrom;
+				drive->type = ATA_ROM;
 				hwif->noprobe = 0;
 				goto done;
 			case -5: /* "serialize" */
@@ -3183,7 +3177,7 @@
 				goto bad_option;
 #endif /* defined(CONFIG_BLK_DEV_IDESCSI) && defined(CONFIG_SCSI) */
 			case 3: /* cyl,head,sect */
-				drive->media	= ide_disk;
+				drive->type	= ATA_DISK;
 				drive->cyl	= drive->bios_cyl  = vals[0];
 				drive->head	= drive->bios_head = vals[1];
 				drive->sect	= drive->bios_sect = vals[2];
@@ -3485,7 +3479,7 @@
 	}
 #endif /* __mc68000__ || CONFIG_APUS */
 
-	(void) ideprobe_init();
+	ideprobe_init();
 
 #if defined(__mc68000__) || defined(CONFIG_APUS)
 	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET]) {
@@ -3500,27 +3494,27 @@
 #endif
 
 	/*
-	 * Attempt to match drivers for the available drives
+	 * Initialize all device type driver modules.
 	 */
 #ifdef CONFIG_BLK_DEV_IDEDISK
 	idedisk_init();
-#endif /* CONFIG_BLK_DEV_IDEDISK */
+#endif
 #ifdef CONFIG_BLK_DEV_IDECD
 	ide_cdrom_init();
-#endif /* CONFIG_BLK_DEV_IDECD */
+#endif
 #ifdef CONFIG_BLK_DEV_IDETAPE
 	idetape_init();
-#endif /* CONFIG_BLK_DEV_IDETAPE */
+#endif
 #ifdef CONFIG_BLK_DEV_IDEFLOPPY
 	idefloppy_init();
-#endif /* CONFIG_BLK_DEV_IDEFLOPPY */
+#endif
 #ifdef CONFIG_BLK_DEV_IDESCSI
  #ifdef CONFIG_SCSI
 	idescsi_init();
  #else
     #warning ide scsi-emulation selected but no SCSI-subsystem in kernel
  #endif
-#endif /* CONFIG_BLK_DEV_IDESCSI */
+#endif
 }
 
 static int default_cleanup (ide_drive_t *drive)
@@ -3596,7 +3590,10 @@
 	return 0;
 }
 
-ide_drive_t *ide_scan_devices (byte media, const char *name, ide_driver_t *driver, int n)
+/*
+ * Lookup IDE devices, which requested a particular deriver
+ */
+ide_drive_t *ide_scan_devices(byte type, const char *name, struct ata_operations *driver, int n)
 {
 	unsigned int unit, index, i;
 
@@ -3609,7 +3606,7 @@
 			char *req = drive->driver_req;
 			if (*req && !strstr(name, req))
 				continue;
-			if (drive->present && drive->media == media && drive->driver == driver && ++i > n)
+			if (drive->present && drive->type == type && drive->driver == driver && ++i > n)
 				return drive;
 		}
 	}
@@ -3619,7 +3616,7 @@
 /*
  * This is in fact registering a drive not a driver.
  */
-int ide_register_subdriver (ide_drive_t *drive, ide_driver_t *driver)
+int ide_register_subdriver(ide_drive_t *drive, struct ata_operations *driver)
 {
 	unsigned long flags;
 
@@ -3663,18 +3660,24 @@
 	    driver->driver_reinit = default_driver_reinit;
 
 	restore_flags(flags);		/* all CPUs */
+	/* FIXME: Check what this magic number is supposed to be about? */
 	if (drive->autotune != 2) {
-		if (driver->supports_dma && HWIF(drive)->dmaproc != NULL) {
+		if (HWIF(drive)->dmaproc != NULL) {
+
 			/*
-			 * Force DMAing for the beginning of the check.
-			 * Some chipsets appear to do interesting things,
-			 * if not checked and cleared.
+			 * Force DMAing for the beginning of the check.  Some
+			 * chipsets appear to do interesting things, if not
+			 * checked and cleared.
+			 *
 			 *   PARANOIA!!!
 			 */
-			(void) (HWIF(drive)->dmaproc(ide_dma_off_quietly, drive));
-			(void) (HWIF(drive)->dmaproc(ide_dma_check, drive));
+
+			HWIF(drive)->dmaproc(ide_dma_off_quietly, drive);
+			HWIF(drive)->dmaproc(ide_dma_check, drive);
 		}
-		drive->dsc_overlap = (drive->next != drive && driver->supports_dsc_overlap);
+		/* Only CD-ROMs and tape drives support DSC overlap. */
+		drive->dsc_overlap = (drive->next != drive
+				&& (drive->type == ATA_ROM || drive->type == ATA_TAPE));
 		drive->nice1 = 1;
 	}
 	drive->revalidate = 1;
@@ -3686,13 +3689,13 @@
 	return 0;
 }
 
-int ide_unregister_subdriver (ide_drive_t *drive)
+int ide_unregister_subdriver(ide_drive_t *drive)
 {
 	unsigned long flags;
 
 	save_flags(flags);		/* all CPUs */
 	cli();				/* all CPUs */
-	if (drive->usage || drive->busy || drive->driver == NULL || DRIVER(drive)->busy) {
+	if (drive->usage || drive->busy || drive->driver == NULL || ata_ops(drive)->busy) {
 		restore_flags(flags);	/* all CPUs */
 		return 1;
 	}
@@ -3700,7 +3703,7 @@
 	pnpide_init(0);
 #endif /* CONFIG_BLK_DEV_ISAPNP */
 #ifdef CONFIG_PROC_FS
-	ide_remove_proc_entries(drive->proc, DRIVER(drive)->proc);
+	ide_remove_proc_entries(drive->proc, ata_ops(drive)->proc);
 	ide_remove_proc_entries(drive->proc, generic_subdriver_entries);
 #endif
 	auto_remove_settings(drive);
@@ -3709,6 +3712,29 @@
 	return 0;
 }
 
+
+/*
+ * Register an ATA driver for a particular device type.
+ */
+
+int register_ata_driver(unsigned int type, struct ata_operations *driver)
+{
+	return 0;
+}
+
+EXPORT_SYMBOL(register_ata_driver);
+
+/*
+ * Unregister an ATA driver for a particular device type.
+ */
+
+int unregister_ata_driver(unsigned int type, struct ata_operations *driver)
+{
+	return 0;
+}
+
+EXPORT_SYMBOL(unregister_ata_driver);
+
 struct block_device_operations ide_fops[] = {{
 	owner:			THIS_MODULE,
 	open:			ide_open,
@@ -3731,10 +3757,8 @@
 EXPORT_SYMBOL(drive_is_flashcard);
 EXPORT_SYMBOL(ide_timer_expiry);
 EXPORT_SYMBOL(ide_intr);
-EXPORT_SYMBOL(ide_fops);
 EXPORT_SYMBOL(ide_get_queue);
 EXPORT_SYMBOL(ide_add_generic_settings);
-EXPORT_SYMBOL(ide_devfs_handle);
 EXPORT_SYMBOL(do_ide_request);
 /*
  * Driver module
@@ -3742,7 +3766,6 @@
 EXPORT_SYMBOL(ide_scan_devices);
 EXPORT_SYMBOL(ide_register_subdriver);
 EXPORT_SYMBOL(ide_unregister_subdriver);
-EXPORT_SYMBOL(ide_replace_subdriver);
 EXPORT_SYMBOL(ide_set_handler);
 EXPORT_SYMBOL(ide_dump_status);
 EXPORT_SYMBOL(ide_error);
@@ -3766,9 +3789,6 @@
 EXPORT_SYMBOL(ide_add_proc_entries);
 EXPORT_SYMBOL(ide_remove_proc_entries);
 EXPORT_SYMBOL(proc_ide_read_geometry);
-EXPORT_SYMBOL(create_proc_ide_interfaces);
-EXPORT_SYMBOL(recreate_proc_ide_device);
-EXPORT_SYMBOL(destroy_proc_ide_device);
 #endif
 EXPORT_SYMBOL(ide_add_setting);
 EXPORT_SYMBOL(ide_remove_setting);
@@ -3809,10 +3829,10 @@
 			/* set the drive to standby */
 			printk("%s ", drive->name);
 			if (event != SYS_RESTART)
-				if (drive->driver != NULL && DRIVER(drive)->standby(drive))
-				continue;
+				if (drive->driver != NULL && ata_ops(drive)->standby(drive))
+					continue;
 
-			if (drive->driver != NULL && DRIVER(drive)->cleanup(drive))
+			if (drive->driver != NULL && ata_ops(drive)->cleanup(drive))
 				continue;
 		}
 	}
@@ -3827,13 +3847,14 @@
 };
 
 /*
- * This is gets invoked once during initialization, to set *everything* up
+ * This is the global initialization entry point.
  */
-int __init ide_init(void)
+static int __init ata_module_init(void)
 {
 	int i;
 
-	printk(KERN_INFO "Uniform Multi-Platform E-IDE driver " REVISION "\n");
+	printk(KERN_INFO "Uniform Multi-Platform E-IDE driver ver.:" VERSION "\n");
+
 	ide_devfs_handle = devfs_mk_dir (NULL, "ide", NULL);
 
 	/* Initialize system bus speed.
@@ -3859,7 +3880,9 @@
 	init_ide_data ();
 
 	initializing = 1;
+
 	ide_init_builtin_drivers();
+
 	initializing = 0;
 
 	for (i = 0; i < MAX_HWIFS; ++i) {
@@ -3872,8 +3895,7 @@
 	return 0;
 }
 
-#ifdef MODULE
-char *options = NULL;
+static char *options = NULL;
 MODULE_PARM(options,"s");
 MODULE_LICENSE("GPL");
 
@@ -3884,40 +3906,44 @@
 	if (line == NULL || !*line)
 		return;
 	while ((line = next) != NULL) {
- 		if ((next = strchr(line,' ')) != NULL)
+		if ((next = strchr(line,' ')) != NULL)
 			*next++ = 0;
 		if (!ide_setup(line))
 			printk ("Unknown option '%s'\n", line);
 	}
 }
 
-int init_module (void)
+static int __init init_ata (void)
 {
 	parse_options(options);
-	return ide_init();
+	return ata_module_init();
 }
 
-void cleanup_module (void)
+static void __exit cleanup_ata (void)
 {
 	int index;
 
 	unregister_reboot_notifier(&ide_notifier);
 	for (index = 0; index < MAX_HWIFS; ++index) {
 		ide_unregister(index);
-#if defined(CONFIG_BLK_DEV_IDEDMA) && !defined(CONFIG_DMA_NONPCI)
+# if defined(CONFIG_BLK_DEV_IDEDMA) && !defined(CONFIG_DMA_NONPCI)
 		if (ide_hwifs[index].dma_base)
 			(void) ide_release_dma(&ide_hwifs[index]);
-#endif /* (CONFIG_BLK_DEV_IDEDMA) && !(CONFIG_DMA_NONPCI) */
+# endif /* (CONFIG_BLK_DEV_IDEDMA) && !(CONFIG_DMA_NONPCI) */
 	}
 
-#ifdef CONFIG_PROC_FS
+# ifdef CONFIG_PROC_FS
 	proc_ide_destroy();
-#endif
+# endif
 	devfs_unregister (ide_devfs_handle);
 }
 
-#else /* !MODULE */
+module_init(init_ata);
+module_exit(cleanup_ata);
 
+#ifndef MODULE
+
+/* command line option parser */
 __setup("", ide_setup);
 
-#endif /* MODULE */
+#endif
diff -ur linux-2.5.5/drivers/ide/ns87415.c linux/drivers/ide/ns87415.c
--- linux-2.5.5/drivers/ide/ns87415.c	Wed Feb 20 03:11:00 2002
+++ linux/drivers/ide/ns87415.c	Tue Feb 26 01:30:43 2002
@@ -103,7 +103,7 @@
 			ns87415_prepare_drive(drive, 0);	/* DMA failed: select PIO xfer */
 			return 1;
 		case ide_dma_check:
-			if (drive->media != ide_disk)
+			if (drive->type != ATA_DISK)
 				return ide_dmaproc(ide_dma_off_quietly, drive);
 			/* Fallthrough... */
 		default:
diff -ur linux-2.5.5/drivers/ide/pdc202xx.c linux/drivers/ide/pdc202xx.c
--- linux-2.5.5/drivers/ide/pdc202xx.c	Sun Feb 24 16:32:54 2002
+++ linux/drivers/ide/pdc202xx.c	Tue Feb 26 01:32:17 2002
@@ -63,7 +63,6 @@
 
 static int pdc202xx_get_info(char *, char **, off_t, int);
 extern int (*pdc202xx_display_info)(char *, char **, off_t, int); /* ide-proc.c */
-extern char *ide_media_verbose(ide_drive_t *);
 static struct pci_dev *bmide_dev;
 
 char *pdc202xx_pio_verbose (u32 drive_pci)
@@ -412,7 +411,8 @@
 		default: return -1;
 	}
 
-	if ((drive->media != ide_disk) && (speed < XFER_SW_DMA_0))	return -1;
+	if ((drive->type != ATA_DISK) && (speed < XFER_SW_DMA_0))
+		return -1;
 
 	pci_read_config_dword(dev, drive_pci, &drive_conf);
 	pci_read_config_byte(dev, (drive_pci), &AP);
@@ -820,7 +820,8 @@
 	}
 
 	if (jumpbit) {
-		if (drive->media != ide_disk)	return ide_dma_off_quietly;
+		if (drive->type != ATA_DISK)
+			return ide_dma_off_quietly;
 		if (id->capability & 4) {	/* IORDY_EN & PREFETCH_EN */
 			OUT_BYTE((iordy + adj), indexreg);
 			OUT_BYTE((IN_BYTE(datareg)|0x03), datareg);
@@ -869,13 +870,14 @@
 
 chipset_is_set:
 
-	if (drive->media != ide_disk)	return ide_dma_off_quietly;
+	if (drive->type != ATA_DISK)
+		return ide_dma_off_quietly;
 
 	pci_read_config_byte(dev, (drive_pci), &AP);
 	if (id->capability & 4)	/* IORDY_EN */
 		pci_write_config_byte(dev, (drive_pci), AP|IORDY_EN);
 	pci_read_config_byte(dev, (drive_pci), &AP);
-	if (drive->media == ide_disk)	/* PREFETCH_EN */
+	if (drive->type == ATA_DISK)	/* PREFETCH_EN */
 		pci_write_config_byte(dev, (drive_pci), AP|PREFETCH_EN);
 
 jumpbit_is_set:
diff -ur linux-2.5.5/drivers/ide/pdcadma.c linux/drivers/ide/pdcadma.c
--- linux-2.5.5/drivers/ide/pdcadma.c	Sun Feb 24 16:32:54 2002
+++ linux/drivers/ide/pdcadma.c	Mon Feb 25 01:54:02 2002
@@ -34,7 +34,6 @@
 
 static int pdcadma_get_info(char *, char **, off_t, int);
 extern int (*pdcadma_display_info)(char *, char **, off_t, int); /* ide-proc.c */
-extern char *ide_media_verbose(ide_drive_t *);
 static struct pci_dev *bmide_dev;
 
 static int pdcadma_get_info (char *buffer, char **addr, off_t offset, int count)
diff -ur linux-2.5.5/drivers/ide/piix.c linux/drivers/ide/piix.c
--- linux-2.5.5/drivers/ide/piix.c	Sun Feb 24 16:32:54 2002
+++ linux/drivers/ide/piix.c	Mon Feb 25 01:54:22 2002
@@ -77,7 +77,6 @@
 
 static int piix_get_info(char *, char **, off_t, int);
 extern int (*piix_display_info)(char *, char **, off_t, int); /* ide-proc.c */
-extern char *ide_media_verbose(ide_drive_t *);
 static struct pci_dev *bmide_dev;
 
 static int piix_get_info (char *buffer, char **addr, off_t offset, int count)
diff -ur linux-2.5.5/drivers/ide/qd65xx.c linux/drivers/ide/qd65xx.c
--- linux-2.5.5/drivers/ide/qd65xx.c	Sun Feb 24 16:32:49 2002
+++ linux/drivers/ide/qd65xx.c	Tue Feb 26 01:32:52 2002
@@ -293,7 +293,7 @@
 		printk(KERN_INFO "%s: PIO mode%d\n",drive->name,pio);
 	}
 
-	if (!HWIF(drive)->channel && drive->media != ide_disk) {
+	if (!HWIF(drive)->channel && drive->type != ATA_DISK) {
 		qd_write_reg(0x5f,QD_CONTROL_PORT);
 		printk(KERN_WARNING "%s: ATAPI: disabled read-ahead FIFO and post-write buffer on %s.\n",drive->name,HWIF(drive)->name);
 	}
diff -ur linux-2.5.5/drivers/ide/serverworks.c linux/drivers/ide/serverworks.c
--- linux-2.5.5/drivers/ide/serverworks.c	Sun Feb 24 16:32:54 2002
+++ linux/drivers/ide/serverworks.c	Mon Feb 25 01:52:46 2002
@@ -105,7 +105,6 @@
 
 static int svwks_get_info(char *, char **, off_t, int);
 extern int (*svwks_display_info)(char *, char **, off_t, int); /* ide-proc.c */
-extern char *ide_media_verbose(ide_drive_t *);
 
 static int svwks_get_info (char *buffer, char **addr, off_t offset, int count)
 {
diff -ur linux-2.5.5/drivers/ide/sis5513.c linux/drivers/ide/sis5513.c
--- linux-2.5.5/drivers/ide/sis5513.c	Sun Feb 24 16:32:54 2002
+++ linux/drivers/ide/sis5513.c	Tue Feb 26 01:33:19 2002
@@ -238,7 +238,7 @@
 	byte rw_prefetch	= (0x11 << drive->dn);
 
 	pci_read_config_byte(dev, 0x4b, &reg4bh);
-	if (drive->media != ide_disk)
+	if (drive->type != ATA_DISK)
 		return;
 	
 	if ((reg4bh & rw_prefetch) != rw_prefetch)
diff -ur linux-2.5.5/drivers/ide/slc90e66.c linux/drivers/ide/slc90e66.c
--- linux-2.5.5/drivers/ide/slc90e66.c	Sun Feb 24 16:32:54 2002
+++ linux/drivers/ide/slc90e66.c	Mon Feb 25 01:53:00 2002
@@ -60,7 +60,6 @@
 
 static int slc90e66_get_info(char *, char **, off_t, int);
 extern int (*slc90e66_display_info)(char *, char **, off_t, int); /* ide-proc.c */
-extern char *ide_media_verbose(ide_drive_t *);
 static struct pci_dev *bmide_dev;
 
 static int slc90e66_get_info (char *buffer, char **addr, off_t offset, int count)
diff -ur linux-2.5.5/drivers/ide/trm290.c linux/drivers/ide/trm290.c
--- linux-2.5.5/drivers/ide/trm290.c	Wed Feb 20 03:10:57 2002
+++ linux/drivers/ide/trm290.c	Tue Feb 26 01:33:48 2002
@@ -192,7 +192,7 @@
 			outl(hwif->dmatable_dma|reading|writing, hwif->dma_base);
 			drive->waiting_for_dma = 1;
 			outw((count * 2) - 1, hwif->dma_base+2); /* start DMA */
-			if (drive->media != ide_disk)
+			if (drive->type != ATA_DISK)
 				return 0;
 			ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, NULL);
 			OUT_BYTE(reading ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
diff -ur linux-2.5.5/drivers/scsi/ide-scsi.c linux/drivers/scsi/ide-scsi.c
--- linux-2.5.5/drivers/scsi/ide-scsi.c	Sun Feb 24 16:32:45 2002
+++ linux/drivers/scsi/ide-scsi.c	Tue Feb 26 01:45:37 2002
@@ -182,7 +182,7 @@
 
 	if (!test_bit(PC_TRANSFORM, &pc->flags))
 		return;
-	if (drive->media == ide_cdrom || drive->media == ide_optical) {
+	if (drive->type == ATA_ROM || drive->type == ATA_MOD) {
 		if (c[0] == READ_6 || c[0] == WRITE_6) {
 			c[8] = c[4];		c[5] = c[3];		c[4] = c[2];
 			c[3] = c[1] & 0x1f;	c[2] = 0;		c[1] &= 0xe0;
@@ -221,7 +221,7 @@
 
 	if (!test_bit(PC_TRANSFORM, &pc->flags))
 		return;
-	if (drive->media == ide_cdrom || drive->media == ide_optical) {
+	if (drive->type == ATA_ROM || drive->type == ATA_MOD) {
 		if (pc->c[0] == MODE_SENSE_10 && sc[0] == MODE_SENSE) {
 			scsi_buf[0] = atapi_buf[1];		/* Mode data length */
 			scsi_buf[1] = atapi_buf[2];		/* Medium type */
@@ -508,7 +508,8 @@
  */
 static void idescsi_setup (ide_drive_t *drive, idescsi_scsi_t *scsi, int id)
 {
-	DRIVER(drive)->busy++;
+	ata_ops(drive)->busy++;
+
 	idescsi_drives[id] = drive;
 	drive->driver_data = scsi;
 	drive->ready_stat = 0;
@@ -535,17 +536,13 @@
 	return 0;
 }
 
-int idescsi_reinit(ide_drive_t *drive);
+static int idescsi_reinit(ide_drive_t *drive);
 
 /*
  *	IDE subdriver functions, registered with ide.c
  */
-static ide_driver_t idescsi_driver = {
-	name:			"ide-scsi",
-	media:			ide_scsi,
-	busy:			0,
-	supports_dma:		1,
-	supports_dsc_overlap:	0,
+static struct ata_operations idescsi_driver = {
+	owner:			THIS_MODULE,
 	cleanup:		idescsi_cleanup,
 	standby:		NULL,
 	flushcache:		NULL,
@@ -563,50 +560,20 @@
 	driver_reinit:		idescsi_reinit,
 };
 
-int idescsi_reinit (ide_drive_t *drive)
+static int idescsi_reinit (ide_drive_t *drive)
 {
-#if 0
-	idescsi_scsi_t *scsi;
-	byte media[] = {TYPE_DISK, TYPE_TAPE, TYPE_PROCESSOR, TYPE_WORM, TYPE_ROM, TYPE_SCANNER, TYPE_MOD, 255};
-	int i, failed, id;
-
-	if (!idescsi_initialized)
-		return 0;
-	for (i = 0; i < MAX_HWIFS * MAX_DRIVES; i++)
-		idescsi_drives[i] = NULL;
-
-	MOD_INC_USE_COUNT;
-	for (i = 0; media[i] != 255; i++) {
-		failed = 0;
-		while ((drive = ide_scan_devices (media[i], idescsi_driver.name, NULL, failed++)) != NULL) {
-
-			if ((scsi = (idescsi_scsi_t *) kmalloc (sizeof (idescsi_scsi_t), GFP_KERNEL)) == NULL) {
-				printk (KERN_ERR "ide-scsi: %s: Can't allocate a scsi structure\n", drive->name);
-				continue;
-			}
-			if (ide_register_subdriver (drive, &idescsi_driver)) {
-				printk (KERN_ERR "ide-scsi: %s: Failed to register the driver with ide.c\n", drive->name);
-				kfree (scsi);
-				continue;
-			}
-			for (id = 0; id < MAX_HWIFS * MAX_DRIVES && idescsi_drives[id]; id++);
-				idescsi_setup (drive, scsi, id);
-			failed--;
-		}
-	}
-	revalidate_drives();
-	MOD_DEC_USE_COUNT;
-#endif
 	return 0;
 }
 
 /*
  *	idescsi_init will register the driver for each scsi.
  */
-int idescsi_init (void)
+static int idescsi_init(void)
 {
 	ide_drive_t *drive;
 	idescsi_scsi_t *scsi;
+	/* FIXME: The following is just plain wrong, since those are definitely *not* the
+	 * media types supported by the ATA layer */
 	byte media[] = {TYPE_DISK, TYPE_TAPE, TYPE_PROCESSOR, TYPE_WORM, TYPE_ROM, TYPE_SCANNER, TYPE_MOD, 255};
 	int i, failed, id;
 
@@ -618,7 +585,7 @@
 	MOD_INC_USE_COUNT;
 	for (i = 0; media[i] != 255; i++) {
 		failed = 0;
-		while ((drive = ide_scan_devices (media[i], idescsi_driver.name, NULL, failed++)) != NULL) {
+		while ((drive = ide_scan_devices (media[i], "ide-scsi", NULL, failed++)) != NULL) {
 
 			if ((scsi = (idescsi_scsi_t *) kmalloc (sizeof (idescsi_scsi_t), GFP_KERNEL)) == NULL) {
 				printk (KERN_ERR "ide-scsi: %s: Can't allocate a scsi structure\n", drive->name);
@@ -666,7 +633,7 @@
 	for (id = 0; id < MAX_HWIFS * MAX_DRIVES; id++) {
 		drive = idescsi_drives[id];
 		if (drive)
-			DRIVER(drive)->busy--;
+			ata_ops(drive)->busy--;
 	}
 	return 0;
 }
@@ -896,9 +863,17 @@
 	int i, failed;
 
 	scsi_unregister_host(&idescsi_template);
+
+	/* FIXME: The media types scanned here have literally nothing to do
+	 * with the media types used by the overall ATA code!
+	 *
+	 * This is basically showing us, that there is something wrong with the
+	 * ide_scan_devices function.
+	 */
+
 	for (i = 0; media[i] != 255; i++) {
 		failed = 0;
-		while ((drive = ide_scan_devices (media[i], idescsi_driver.name, &idescsi_driver, failed)) != NULL)
+		while ((drive = ide_scan_devices (media[i], "ide-scsi", &idescsi_driver, failed)) != NULL)
 			if (idescsi_cleanup (drive)) {
 				printk ("%s: exit_idescsi_module() called while still busy\n", drive->name);
 				failed++;
diff -ur linux-2.5.5/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.5/include/linux/ide.h	Sun Feb 24 22:48:39 2002
+++ linux/include/linux/ide.h	Tue Feb 26 01:22:15 2002
@@ -1,9 +1,7 @@
 #ifndef _IDE_H
 #define _IDE_H
 /*
- *  linux/include/linux/ide.h
- *
- *  Copyright (C) 1994-1998  Linus Torvalds & authors
+ *  Copyright (C) 1994-2002  Linus Torvalds & authors
  */
 
 #include <linux/config.h>
@@ -350,12 +348,13 @@
  * Now for the data we need to maintain per-drive:  ide_drive_t
  */
 
-#define ide_scsi	0x21
-#define ide_disk	0x20
-#define ide_optical	0x7
-#define ide_cdrom	0x5
-#define ide_tape	0x1
-#define ide_floppy	0x0
+#define ATA_DISK        0x20
+#define ATA_TAPE        0x01
+#define ATA_ROM         0x05	/* CD-ROM */
+#define ATA_MOD		0x07    /* optical */
+#define ATA_FLOPPY	0x00
+#define ATA_SCSI	0x21
+#define ATA_NO_LUN      0x7f
 
 typedef union {
 	unsigned all			: 8;	/* all of the bits together */
@@ -371,7 +370,14 @@
 struct ide_settings_s;
 
 typedef struct ide_drive_s {
-	request_queue_t		 queue;	/* request queue */
+	char type; /* distingiush different devices: disk, cdrom, tape, floppy, ... */
+
+	/* NOTE: If we had proper separation between channel and host chip, we
+	 * could move this to the chanell and many sync problems would
+	 * magically just go away.
+	 */
+	request_queue_t		 queue;	/* per device request queue */
+
 	struct ide_drive_s	*next;	/* circular list of hwgroup drives */
 	unsigned long sleep;		/* sleep until this time */
 	unsigned long service_start;	/* time we started last request */
@@ -406,7 +412,6 @@
 	unsigned ata_flash	: 1;	/* 1=present, 0=default */
 	unsigned	addressing;	/* : 2; 0=28-bit, 1=48-bit, 2=64-bit */
 	byte		scsi;		/* 0=default, 1=skip current ide-subdriver for ide-scsi emulation */
-	byte		media;		/* disk, cdrom, tape, floppy, ... */
 	select_t	select;		/* basic drive/head select reg value */
 	byte		ctl;		/* "normal" value for IDE_CONTROL_REG */
 	byte		ready_stat;	/* min status value for drive ready */
@@ -432,7 +437,7 @@
 	struct hd_driveid *id;		/* drive model identification info */
 	struct hd_struct  *part;	/* drive partition table */
 	char		name[4];	/* drive name, such as "hda" */
-	struct ide_driver_s *driver;	/* (ide_driver_t *) */
+	struct ata_operations *driver;
 	void		*driver_data;	/* extra driver data */
 	devfs_handle_t	de;		/* directory for device */
 	struct proc_dir_entry *proc;	/* /proc/ide/ directory entry */
@@ -570,7 +575,6 @@
 	unsigned long	last_time;	/* time when previous rq was done */
 #endif
 	byte		straight8;	/* Alan's straight 8 check */
-	void		*hwif_data;	/* extra hwif data */
 	ide_busproc_t	*busproc;	/* driver soft-power interface */
 	byte		bus_state;	/* power state of the IDE bus */
 	struct device	device;		/* global device tree handle */
@@ -663,8 +667,6 @@
 #ifdef CONFIG_PROC_FS
 void proc_ide_create(void);
 void proc_ide_destroy(void);
-void recreate_proc_ide_device(ide_hwif_t *, ide_drive_t *);
-void destroy_proc_ide_device(ide_hwif_t *, ide_drive_t *);
 void destroy_proc_ide_drives(ide_hwif_t *);
 void create_proc_ide_interfaces(void);
 void ide_add_proc_entries(struct proc_dir_entry *dir, ide_proc_entry_t *p, void *data);
@@ -692,32 +694,54 @@
 #endif
 
 /*
- * Subdrivers support.
+ * This structure describes the operations possible on a particular device type
+ * (CD-ROM, tape, DISK and so on).
+ *
+ * This is the main hook for device type support submodules.
  */
-typedef struct ide_driver_s {
-	const char			*name;
-	byte				media;
-	unsigned busy			: 1;
-	unsigned supports_dma		: 1;
-	unsigned supports_dsc_overlap	: 1;
+
+struct ata_operations {
+	struct module *owner;
+	unsigned busy: 1; /* FIXME: this will go soon away... */
 	int (*cleanup)(ide_drive_t *);
 	int (*standby)(ide_drive_t *);
 	int (*flushcache)(ide_drive_t *);
 	ide_startstop_t	(*do_request)(ide_drive_t *, struct request *, unsigned long);
 	int (*end_request)(ide_drive_t *drive, int uptodate);
+
 	int (*ioctl)(ide_drive_t *, struct inode *, struct file *, unsigned int, unsigned long);
 	int (*open)(struct inode *, struct file *, ide_drive_t *);
 	void (*release)(struct inode *, struct file *, ide_drive_t *);
 	int (*media_change)(ide_drive_t *);
 	void (*revalidate)(ide_drive_t *);
+
 	void (*pre_reset)(ide_drive_t *);
 	unsigned long (*capacity)(ide_drive_t *);
 	ide_startstop_t	(*special)(ide_drive_t *);
 	ide_proc_entry_t		*proc;
 	int (*driver_reinit)(ide_drive_t *);
-} ide_driver_t;
+};
+
+/* Alas, no aliases. Too much hassle with bringing module.h everywhere */
+#define ata_get(ata) \
+	(((ata) && (ata)->owner)	\
+		? ( try_inc_mod_count((ata)->owner) ? (ata) : NULL ) \
+		: (ata))
+
+#define ata_put(ata) \
+do {	\
+	if ((ata) && (ata)->owner) \
+		__MOD_DEC_USE_COUNT((ata)->owner);	\
+} while(0)
 
-#define DRIVER(drive)		((drive)->driver)
+
+/* FIXME: Actually implement and use them as soon as possible!  to make the
+ * ide_scan_devices() go away! */
+
+extern int unregister_ata_driver(unsigned int type, struct ata_operations *driver);
+extern int register_ata_driver(unsigned int type, struct ata_operations *driver);
+
+#define ata_ops(drive)		((drive)->driver)
 
 /*
  * ide_hwifs[] is the master data structure used to keep track
@@ -994,30 +1018,24 @@
 extern int ideprobe_init (void);
 #endif
 #ifdef CONFIG_BLK_DEV_IDEDISK
-extern int idedisk_reinit (ide_drive_t *drive);
 extern int idedisk_init (void);
-#endif /* CONFIG_BLK_DEV_IDEDISK */
+#endif
 #ifdef CONFIG_BLK_DEV_IDECD
-extern int ide_cdrom_reinit (ide_drive_t *drive);
 extern int ide_cdrom_init (void);
-#endif /* CONFIG_BLK_DEV_IDECD */
+#endif
 #ifdef CONFIG_BLK_DEV_IDETAPE
-extern int idetape_reinit (ide_drive_t *drive);
 extern int idetape_init (void);
-#endif /* CONFIG_BLK_DEV_IDETAPE */
+#endif
 #ifdef CONFIG_BLK_DEV_IDEFLOPPY
-extern int idefloppy_reinit (ide_drive_t *drive);
 extern int idefloppy_init (void);
-#endif /* CONFIG_BLK_DEV_IDEFLOPPY */
+#endif
 #ifdef CONFIG_BLK_DEV_IDESCSI
-extern int idescsi_reinit (ide_drive_t *drive);
 extern int idescsi_init (void);
-#endif /* CONFIG_BLK_DEV_IDESCSI */
+#endif
 
-ide_drive_t *ide_scan_devices (byte media, const char *name, ide_driver_t *driver, int n);
-extern int ide_register_subdriver(ide_drive_t *drive, ide_driver_t *driver);
+ide_drive_t *ide_scan_devices (byte media, const char *name, struct ata_operations *driver, int n);
+extern int ide_register_subdriver(ide_drive_t *drive, struct ata_operations *driver);
 extern int ide_unregister_subdriver(ide_drive_t *drive);
-extern int ide_replace_subdriver(ide_drive_t *drive, const char *driver);
 
 #ifdef CONFIG_BLK_DEV_IDEPCI
 #define ON_BOARD		1

--------------010506050108040504070406--

