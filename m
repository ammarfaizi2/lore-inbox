Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292991AbSCEKxj>; Tue, 5 Mar 2002 05:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293211AbSCEKx1>; Tue, 5 Mar 2002 05:53:27 -0500
Received: from [195.63.194.11] ([195.63.194.11]:49931 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292991AbSCEKxE>; Tue, 5 Mar 2002 05:53:04 -0500
Message-ID: <3C84A34E.6060708@evision-ventures.com>
Date: Tue, 05 Mar 2002 11:51:58 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: torvalds@transmeta.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.6-pre2 IDE cleanup 16
In-Reply-To: <E16i9mc-00043p-00@wagner.rustcorp.com.au>
Content-Type: multipart/mixed;
 boundary="------------010903050201000402030201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010903050201000402030201
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

There is no such a thing like a ide-clean-15. Never was.  But here comes
what has been done in ide-clean-16:

- Apply a patch for the initialization of the second PIIX channel.
   Found by Daniel Quinlan <quinlan@transmeta.com>

- Apply a patch for the DMA initialization of the serverworks chip.
   Ken Brownfield <brownfld@irridia.com>

- Make the ata_operations methods immune against device type drivers,
   which donot provide them by separating the access to them out. Audit
   them all.

- Resynchronize with 2.5.6-pre1.

- Remove unused IDE_DRIVE_CMD, IDE_DRIVE_TASK, IDE_DRIVE_TASK_MASK,
   IDE_DRIVE_TASKFILE macros.

- Disable configuration of the task file stuff. It is going to go away
   and will be replaced by a truly abstract interface based on
   functionality and *not* direct mess-up of hardware.

- Resync with 2.5.6-pre2.

- Add HPT entries to the fall-back list, since otherwise the driver
   won'trecognize the drives. We will have to make this the default
   behavior for allnot recognized host chip types.

- Fix compilation with no PCI host chip support enabled.

- Apply the overflow fixes for HPT366 by Vojtech Pavlik.

- Kill the one-shoot functions ide_wait_cmd_taks() ide_wait_cmd() by
   moving them to the places where they are actually used. Fix a
   potential buffer overflow on the way.

- Fix usage of ide.c as module. Thanks to Adam J. Richter for figuring
   out what was wrong.

- Various cleanups all along as well as removal of TONS of
   unfinished/dead code.

I think it's sometimes better to remove stuff, which isn't there,
instead of hoping for a "magical day" where it will be finished.

I intend to kill the largely overdesigned taskfile stuff. It's broken
by design to provide this micro level of device access to *anybody*.
Operating systems should try to present the functionality of devices
in a convenient way to the user and not just mapp it directly to
user space.

--------------010903050201000402030201
Content-Type: text/plain;
 name="ide-clean-16.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-16.diff"

diff -ur linux-2.5.5/arch/alpha/defconfig linux/arch/alpha/defconfig
--- linux-2.5.5/arch/alpha/defconfig	Wed Feb 20 03:11:03 2002
+++ linux/arch/alpha/defconfig	Mon Mar  4 02:50:08 2002
@@ -237,7 +237,6 @@
 # CONFIG_BLK_DEV_IDETAPE is not set
 # CONFIG_BLK_DEV_IDEFLOPPY is not set
 # CONFIG_BLK_DEV_IDESCSI is not set
-# CONFIG_IDE_TASK_IOCTL is not set
 
 #
 # IDE chipset support/bugfixes
diff -ur linux-2.5.5/arch/arm/def-configs/shannon linux/arch/arm/def-configs/shannon
--- linux-2.5.5/arch/arm/def-configs/shannon	Wed Feb 20 03:10:55 2002
+++ linux/arch/arm/def-configs/shannon	Mon Mar  4 02:50:08 2002
@@ -378,7 +378,6 @@
 # CONFIG_BLK_DEV_IDECD is not set
 # CONFIG_BLK_DEV_IDETAPE is not set
 # CONFIG_BLK_DEV_IDEFLOPPY is not set
-# CONFIG_IDE_TASK_IOCTL is not set
 
 #
 # IDE chipset support/bugfixes
diff -ur linux-2.5.5/arch/i386/defconfig linux/arch/i386/defconfig
--- linux-2.5.5/arch/i386/defconfig	Mon Mar  4 21:07:14 2002
+++ linux/arch/i386/defconfig	Mon Mar  4 02:50:08 2002
@@ -239,7 +239,6 @@
 # CONFIG_BLK_DEV_IDETAPE is not set
 # CONFIG_BLK_DEV_IDEFLOPPY is not set
 # CONFIG_BLK_DEV_IDESCSI is not set
-CONFIG_IDE_TASK_IOCTL=y
 
 #
 # IDE chipset support/bugfixes
diff -ur linux-2.5.5/arch/sparc64/defconfig linux/arch/sparc64/defconfig
--- linux-2.5.5/arch/sparc64/defconfig	Wed Feb 20 03:11:00 2002
+++ linux/arch/sparc64/defconfig	Mon Mar  4 02:50:08 2002
@@ -273,7 +273,6 @@
 # CONFIG_BLK_DEV_IDETAPE is not set
 # CONFIG_BLK_DEV_IDEFLOPPY is not set
 # CONFIG_BLK_DEV_IDESCSI is not set
-# CONFIG_IDE_TASK_IOCTL is not set
 
 #
 # IDE chipset support/bugfixes
diff -ur linux-2.5.5/arch/x86_64/defconfig linux/arch/x86_64/defconfig
--- linux-2.5.5/arch/x86_64/defconfig	Mon Mar  4 21:07:14 2002
+++ linux/arch/x86_64/defconfig	Mon Mar  4 02:50:08 2002
@@ -188,7 +188,6 @@
 # CONFIG_BLK_DEV_IDETAPE is not set
 # CONFIG_BLK_DEV_IDEFLOPPY is not set
 # CONFIG_BLK_DEV_IDESCSI is not set
-# CONFIG_IDE_TASK_IOCTL is not set
 
 #
 # IDE chipset support/bugfixes
diff -ur linux-2.5.5/drivers/ide/Config.help linux/drivers/ide/Config.help
--- linux-2.5.5/drivers/ide/Config.help	Wed Feb 20 03:11:04 2002
+++ linux/drivers/ide/Config.help	Mon Mar  4 02:50:08 2002
@@ -807,14 +807,6 @@
 
   If you are unsure, say N here.
 
-CONFIG_IDE_TASK_IOCTL
-  This is a direct raw access to the media.  It is a complex but
-  elegant solution to test and validate the domain of the hardware and
-  perform below the driver data recovery if needed.  This is the most
-  basic form of media-forensics.
-
-  If you are unsure, say N here.
-
 CONFIG_BLK_DEV_IDEDMA_FORCED
   This is an old piece of lost code from Linux 2.0 Kernels.
 
diff -ur linux-2.5.5/drivers/ide/Config.in linux/drivers/ide/Config.in
--- linux-2.5.5/drivers/ide/Config.in	Wed Feb 20 03:11:05 2002
+++ linux/drivers/ide/Config.in	Mon Mar  4 02:50:08 2002
@@ -33,9 +33,7 @@
    dep_tristate '  Include IDE/ATAPI FLOPPY support' CONFIG_BLK_DEV_IDEFLOPPY $CONFIG_BLK_DEV_IDE
    dep_tristate '  SCSI emulation support' CONFIG_BLK_DEV_IDESCSI $CONFIG_BLK_DEV_IDE $CONFIG_SCSI
 
-   bool '  IDE Taskfile Access' CONFIG_IDE_TASK_IOCTL
-
-   comment 'IDE chipset support/bugfixes'
+   comment 'IDE chipset support'
    if [ "$CONFIG_BLK_DEV_IDE" != "n" ]; then
       dep_bool '  CMD640 chipset bugfix/support' CONFIG_BLK_DEV_CMD640 $CONFIG_X86
       dep_bool '    CMD640 enhanced support' CONFIG_BLK_DEV_CMD640_ENHANCED $CONFIG_BLK_DEV_CMD640
diff -ur linux-2.5.5/drivers/ide/hpt366.c linux/drivers/ide/hpt366.c
--- linux-2.5.5/drivers/ide/hpt366.c	Mon Mar  4 21:07:15 2002
+++ linux/drivers/ide/hpt366.c	Mon Mar  4 13:07:07 2002
@@ -374,7 +374,8 @@
 		class_rev &= 0xff;
 
 		p += sprintf(p, "\nController: %d\n", i);
-		p += sprintf(p, "Chipset: HPT%s\n", chipset_nums[class_rev]);
+		p += sprintf(p, "Chipset: HPT%s\n",
+			class_rev < sizeof(chipset_nums) / sizeof(char *) ? chipset_nums[class_rev] : "???");
 		p += sprintf(p, "--------------- Primary Channel "
 				"--------------- Secondary Channel "
 				"--------------\n");
@@ -1119,12 +1120,11 @@
 	if (test != 0x08)
 		pci_write_config_byte(dev, PCI_MAX_LAT, 0x08);
 
-	if (pci_rev_check_hpt3xx(dev)) {
+	if (pci_rev_check_hpt3xx(dev))
 		init_hpt370(dev);
+
+	if (n_hpt_devs < HPT366_MAX_DEVS)
 		hpt_devs[n_hpt_devs++] = dev;
-	} else {
-		hpt_devs[n_hpt_devs++] = dev;
-	}
 	
 #if defined(DISPLAY_HPT366_TIMINGS) && defined(CONFIG_PROC_FS)
 	if (!hpt366_proc) {
diff -ur linux-2.5.5/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.5/drivers/ide/ide-cd.c	Mon Mar  4 21:07:15 2002
+++ linux/drivers/ide/ide-cd.c	Mon Mar  4 02:50:08 2002
@@ -2906,69 +2906,29 @@
 	return 0;
 }
 
-static int ide_cdrom_reinit (ide_drive_t *drive);
-
 static struct ata_operations ide_cdrom_driver = {
 	owner:			THIS_MODULE,
 	cleanup:		ide_cdrom_cleanup,
 	standby:		NULL,
-	flushcache:		NULL,
 	do_request:		ide_do_rw_cdrom,
 	end_request:		NULL,
 	ioctl:			ide_cdrom_ioctl,
 	open:			ide_cdrom_open,
 	release:		ide_cdrom_release,
-	media_change:		ide_cdrom_check_media_change,
+	check_media_change:	ide_cdrom_check_media_change,
 	revalidate:		ide_cdrom_revalidate,
 	pre_reset:		NULL,
 	capacity:		ide_cdrom_capacity,
 	special:		NULL,
-	proc:			NULL,
-	driver_reinit:		ide_cdrom_reinit,
+	proc:			NULL
 };
 
 /* options */
-char *ignore = NULL;
+static char *ignore = NULL;
 
 MODULE_PARM(ignore, "s");
 MODULE_DESCRIPTION("ATAPI CD-ROM Driver");
 
-static int ide_cdrom_reinit (ide_drive_t *drive)
-{
-	struct cdrom_info *info;
-	int failed = 0;
-
-	MOD_INC_USE_COUNT;
-	info = (struct cdrom_info *) kmalloc (sizeof (struct cdrom_info), GFP_KERNEL);
-	if (info == NULL) {
-		printk ("%s: Can't allocate a cdrom structure\n", drive->name);
-		return 1;
-	}
-	if (ide_register_subdriver (drive, &ide_cdrom_driver)) {
-		printk ("%s: Failed to register the driver with ide.c\n", drive->name);
-		kfree (info);
-		return 1;
-	}
-	memset (info, 0, sizeof (struct cdrom_info));
-	drive->driver_data = info;
-
-	/* ATA-PATTERN */
-	ata_ops(drive)->busy++;
-	if (ide_cdrom_setup (drive)) {
-		ata_ops(drive)->busy--;
-		if (ide_cdrom_cleanup (drive))
-			printk ("%s: ide_cdrom_cleanup failed in ide_cdrom_init\n", drive->name);
-		return 1;
-	}
-	ata_ops(drive)->busy--;
-
-	failed--;
-
-	revalidate_drives();
-	MOD_DEC_USE_COUNT;
-	return 0;
-}
-
 static void __exit ide_cdrom_exit(void)
 {
 	ide_drive_t *drive;
@@ -2980,7 +2940,7 @@
 			failed++;
 		}
 }
- 
+
 int ide_cdrom_init(void)
 {
 	ide_drive_t *drive;
diff -ur linux-2.5.5/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.5/drivers/ide/ide-disk.c	Mon Mar  4 21:07:15 2002
+++ linux/drivers/ide/ide-disk.c	Mon Mar  4 02:50:08 2002
@@ -351,7 +351,19 @@
 	return 0;
 }
 
-static int do_idedisk_flushcache(ide_drive_t *drive);
+static int idedisk_flushcache(ide_drive_t *drive)
+{
+	struct hd_drive_task_hdr taskfile;
+	struct hd_drive_hob_hdr hobfile;
+	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
+	memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
+	if (drive->id->cfs_enable_2 & 0x2400) {
+		taskfile.command	= WIN_FLUSH_CACHE_EXT;
+	} else {
+		taskfile.command	= WIN_FLUSH_CACHE;
+	}
+	return ide_wait_taskfile(drive, &taskfile, &hobfile, NULL);
+}
 
 static void idedisk_release (struct inode *inode, struct file *filp, ide_drive_t *drive)
 {
@@ -367,15 +379,16 @@
 			drive->doorlocking = 0;
 	}
 	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
-		if (do_idedisk_flushcache(drive))
+		if (idedisk_flushcache(drive))
 			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
 				drive->name);
 	MOD_DEC_USE_COUNT;
 }
 
-static int idedisk_media_change (ide_drive_t *drive)
+static int idedisk_check_media_change (ide_drive_t *drive)
 {
-	return drive->removable;	/* if removable, always assume it was changed */
+	/* if removable, always assume it was changed */
+	return drive->removable;
 }
 
 /*
@@ -836,7 +849,7 @@
 	return 0;
 }
 
-static int do_idedisk_standby (ide_drive_t *drive)
+static int idedisk_standby (ide_drive_t *drive)
 {
 	struct hd_drive_task_hdr taskfile;
 	struct hd_drive_hob_hdr hobfile;
@@ -846,20 +859,6 @@
 	return ide_wait_taskfile(drive, &taskfile, &hobfile, NULL);
 }
 
-static int do_idedisk_flushcache (ide_drive_t *drive)
-{
-	struct hd_drive_task_hdr taskfile;
-	struct hd_drive_hob_hdr hobfile;
-	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
-	memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
-	if (drive->id->cfs_enable_2 & 0x2400) {
-		taskfile.command	= WIN_FLUSH_CACHE_EXT;
-	} else {
-		taskfile.command	= WIN_FLUSH_CACHE;
-	}
-	return ide_wait_taskfile(drive, &taskfile, &hobfile, NULL);
-}
-
 static int set_acoustic (ide_drive_t *drive, int arg)
 {
 	struct hd_drive_task_hdr taskfile;
@@ -1040,72 +1039,36 @@
 
 static int idedisk_cleanup (ide_drive_t *drive)
 {
-
-	/* FIXME: we will have to think twice whatever this is the proper place
-	 * to do it.
-	 */
-
 	put_device(&drive->device);
 	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
-		if (do_idedisk_flushcache(drive))
+		if (idedisk_flushcache(drive))
 			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
 				drive->name);
 	return ide_unregister_subdriver(drive);
 }
 
-static int idedisk_reinit(ide_drive_t *drive);
-
 /*
  *      IDE subdriver functions, registered with ide.c
  */
 static struct ata_operations idedisk_driver = {
 	owner:			THIS_MODULE,
 	cleanup:		idedisk_cleanup,
-	standby:		do_idedisk_standby,
-	flushcache:		do_idedisk_flushcache,
+	standby:		idedisk_standby,
 	do_request:		do_rw_disk,
 	end_request:		NULL,
 	ioctl:			NULL,
 	open:			idedisk_open,
 	release:		idedisk_release,
-	media_change:		idedisk_media_change,
-	revalidate:		ide_revalidate_drive,
+	check_media_change:	idedisk_check_media_change,
+	revalidate:		NULL, /* use default method */
 	pre_reset:		idedisk_pre_reset,
 	capacity:		idedisk_capacity,
 	special:		idedisk_special,
-	proc:			idedisk_proc,
-	driver_reinit:		idedisk_reinit,
+	proc:			idedisk_proc
 };
 
 MODULE_DESCRIPTION("ATA DISK Driver");
 
-static int idedisk_reinit(ide_drive_t *drive)
-{
-	int failed = 0;
-
-	MOD_INC_USE_COUNT;
-
-	if (ide_register_subdriver (drive, &idedisk_driver)) {
-		printk (KERN_ERR "ide-disk: %s: Failed to register the driver with ide.c\n", drive->name);
-		return 1;
-	}
-
-	ata_ops(drive)->busy++;
-	idedisk_setup(drive);
-	if ((!drive->head || drive->head > 16) && !drive->select.b.lba) {
-		printk(KERN_ERR "%s: INVALID GEOMETRY: %d PHYSICAL HEADS?\n", drive->name, drive->head);
-		idedisk_cleanup(drive);
-		ata_ops(drive)->busy--;
-		return 1;
-	}
-	ata_ops(drive)->busy--;
-	failed--;
-
-	revalidate_drives();
-	MOD_DEC_USE_COUNT;
-	return 0;
-}
-
 static void __exit idedisk_exit (void)
 {
 	ide_drive_t *drive;
@@ -1136,15 +1099,12 @@
 			printk (KERN_ERR "ide-disk: %s: Failed to register the driver with ide.c\n", drive->name);
 			continue;
 		}
-		ata_ops(drive)->busy++;
 		idedisk_setup(drive);
 		if ((!drive->head || drive->head > 16) && !drive->select.b.lba) {
 			printk(KERN_ERR "%s: INVALID GEOMETRY: %d PHYSICAL HEADS?\n", drive->name, drive->head);
 			idedisk_cleanup(drive);
-			ata_ops(drive)->busy--;
 			continue;
 		}
-		ata_ops(drive)->busy--;
 		failed--;
 	}
 	revalidate_drives();
diff -ur linux-2.5.5/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux-2.5.5/drivers/ide/ide-floppy.c	Mon Mar  4 21:07:15 2002
+++ linux/drivers/ide/ide-floppy.c	Mon Mar  4 02:50:08 2002
@@ -1819,10 +1819,10 @@
 /*
  *	Check media change. Use a simple algorithm for now.
  */
-static int idefloppy_media_change (ide_drive_t *drive)
+static int idefloppy_check_media_change (ide_drive_t *drive)
 {
 	idefloppy_floppy_t *floppy = drive->driver_data;
-	
+
 	return test_and_clear_bit (IDEFLOPPY_MEDIA_CHANGED, &floppy->flags);
 }
 
@@ -2038,8 +2038,6 @@
 
 #endif	/* CONFIG_PROC_FS */
 
-static int idefloppy_reinit(ide_drive_t *drive);
-
 /*
  *	IDE subdriver functions, registered with ide.c
  */
@@ -2047,58 +2045,19 @@
 	owner:			THIS_MODULE,
 	cleanup:		idefloppy_cleanup,
 	standby:		NULL,
-	flushcache:		NULL,
 	do_request:		idefloppy_do_request,
 	end_request:		idefloppy_end_request,
 	ioctl:			idefloppy_ioctl,
 	open:			idefloppy_open,
 	release:		idefloppy_release,
-	media_change:		idefloppy_media_change,
-	revalidate:		ide_revalidate_drive,
+	check_media_change:	idefloppy_check_media_change,
+	revalidate:		NULL, /* use default method */
 	pre_reset:		NULL,
 	capacity:		idefloppy_capacity,
 	special:		NULL,
-	proc:			idefloppy_proc,
-	driver_reinit:		idefloppy_reinit,
+	proc:			idefloppy_proc
 };
 
-static int idefloppy_reinit (ide_drive_t *drive)
-{
-	idefloppy_floppy_t *floppy;
-	int failed = 0;
-
-	MOD_INC_USE_COUNT;
-	while ((drive = ide_scan_devices(ATA_FLOPPY, "ide-floppy", NULL, failed++)) != NULL) {
-		if (!idefloppy_identify_device (drive, drive->id)) {
-			printk (KERN_ERR "ide-floppy: %s: not supported by this version of ide-floppy\n", drive->name);
-			continue;
-		}
-		if (drive->scsi) {
-			printk("ide-floppy: passing drive %s to ide-scsi emulation.\n", drive->name);
-			continue;
-		}
-		if ((floppy = (idefloppy_floppy_t *) kmalloc (sizeof (idefloppy_floppy_t), GFP_KERNEL)) == NULL) {
-			printk (KERN_ERR "ide-floppy: %s: Can't allocate a floppy structure\n", drive->name);
-			continue;
-		}
-		if (ide_register_subdriver (drive, &idefloppy_driver)) {
-			printk (KERN_ERR "ide-floppy: %s: Failed to register the driver with ide.c\n", drive->name);
-			kfree (floppy);
-			continue;
-		}
-
-		/* ATA-PATTERN */
-		ata_ops(drive)->busy++;
-		idefloppy_setup (drive, floppy);
-		ata_ops(drive)->busy--;
-
-		failed--;
-	}
-	revalidate_drives();
-	MOD_DEC_USE_COUNT;
-	return 0;
-}
-
 MODULE_DESCRIPTION("ATAPI FLOPPY Driver");
 
 static void __exit idefloppy_exit (void)
diff -ur linux-2.5.5/drivers/ide/ide-geometry.c linux/drivers/ide/ide-geometry.c
--- linux-2.5.5/drivers/ide/ide-geometry.c	Mon Mar  4 21:07:15 2002
+++ linux/drivers/ide/ide-geometry.c	Mon Mar  4 02:50:08 2002
@@ -14,14 +14,14 @@
 #if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
 
 extern ide_drive_t * get_info_ptr(kdev_t);
-extern unsigned long current_capacity (ide_drive_t *);
 
 /*
  * If heads is nonzero: find a translation with this many heads and S=63.
  * Otherwise: find out how OnTrack Disk Manager would translate the disk.
  */
 static void
-ontrack(ide_drive_t *drive, int heads, unsigned int *c, int *h, int *s) {
+ontrack(ide_drive_t *drive, int heads, unsigned int *c, int *h, int *s)
+{
 	static const byte dm_head_vals[] = {4, 8, 16, 32, 64, 128, 255, 0};
 	const byte *headp = dm_head_vals;
 	unsigned long total;
@@ -34,7 +34,7 @@
 	 * computes a geometry different from what OnTrack uses.]
 	 */
 
-	total = ata_ops(drive)->capacity(drive);
+	total = ata_capacity(drive);
 
 	*s = 63;
 
@@ -136,7 +136,7 @@
 		ret = 1;
 	}
 
-	drive->part[0].nr_sects = current_capacity(drive);
+	drive->part[0].nr_sects = ata_capacity(drive);
 
 	if (ret)
 		printk("%s%s [%d/%d/%d]", msg, msg1,
diff -ur linux-2.5.5/drivers/ide/ide-pci.c linux/drivers/ide/ide-pci.c
--- linux-2.5.5/drivers/ide/ide-pci.c	Mon Mar  4 21:07:15 2002
+++ linux/drivers/ide/ide-pci.c	Mon Mar  4 11:54:25 2002
@@ -303,7 +303,9 @@
 #ifdef CONFIG_BLK_DEV_IT8172
 	{PCI_VENDOR_ID_ITE, PCI_DEVICE_ID_ITE_IT8172G, pci_init_it8172,	NULL, ide_init_it8172, NULL, {{0x00,0x00,0x00}, {0x40,0x00,0x01}}, ON_BOARD, 0, 0 },
 #endif
-	/* Those are id's of chips we don't deal currently with. */
+	/* Those are id's of chips we don't deal currently with,
+	 * but which still need some generic quirk handling.
+	 */
 	{PCI_VENDOR_ID_PCTECH, PCI_DEVICE_ID_PCTECH_SAMURAI_IDE, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, 0 },
 	{PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_CMD_640, NULL, NULL, IDE_IGNORE, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, 0 },
 	{PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_87410, NULL, NULL, NULL, NULL, {{0x43,0x08,0x08}, {0x47,0x08,0x08}}, ON_BOARD, 0, 0 },
@@ -313,6 +315,7 @@
 	{PCI_VENDOR_ID_UMC, PCI_DEVICE_ID_UMC_UM8886A, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, ATA_F_FIXIRQ },
 	{PCI_VENDOR_ID_UMC, PCI_DEVICE_ID_UMC_UM8886BF, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, ATA_F_FIXIRQ },
 	{PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C561, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, ATA_F_NOADMA },
+	{PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT366, NULL, NULL, IDE_NO_DRIVER, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 240, ATA_F_IRQ | ATA_F_HPTHACK },
 	{0, 0, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0 }};
 
 /*
diff -ur linux-2.5.5/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux-2.5.5/drivers/ide/ide-probe.c	Mon Mar  4 21:07:15 2002
+++ linux/drivers/ide/ide-probe.c	Mon Mar  4 11:59:04 2002
@@ -471,9 +471,11 @@
 	sprintf(hwif->device.bus_id, "%04x", hwif->io_ports[IDE_DATA_OFFSET]);
 	sprintf(hwif->device.name, "ide");
 	hwif->device.driver_data = hwif;
+#ifdef CONFIG_BLK_DEV_IDEPCI
 	if (hwif->pci_dev)
 		hwif->device.parent = &hwif->pci_dev->dev;
 	else
+#endif
 		hwif->device.parent = NULL; /* Would like to do = &device_legacy */
 	device_register(&hwif->device);
 
diff -ur linux-2.5.5/drivers/ide/ide-proc.c linux/drivers/ide/ide-proc.c
--- linux-2.5.5/drivers/ide/ide-proc.c	Mon Mar  4 21:07:15 2002
+++ linux/drivers/ide/ide-proc.c	Mon Mar  4 02:50:08 2002
@@ -353,7 +353,7 @@
 	if (!driver)
 		len = sprintf(page, "(none)\n");
         else
-		len = sprintf(page,"%llu\n", (unsigned long long) drive->driver->capacity(drive));
+		len = sprintf(page,"%llu\n", (unsigned long long) ata_capacity(drive));
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
 
diff -ur linux-2.5.5/drivers/ide/ide-tape.c linux/drivers/ide/ide-tape.c
--- linux-2.5.5/drivers/ide/ide-tape.c	Mon Mar  4 21:07:15 2002
+++ linux/drivers/ide/ide-tape.c	Mon Mar  4 02:50:08 2002
@@ -6140,7 +6140,12 @@
 
 #endif
 
-static int idetape_reinit(ide_drive_t *drive);
+static void idetape_revalidate(ide_drive_t *_dummy)
+{
+	/* We don't have to handle any partition information here, which is the
+	 * default behaviour of this method.
+	 */
+}
 
 /*
  *	IDE subdriver functions, registered with ide.c
@@ -6149,18 +6154,16 @@
 	owner:			THIS_MODULE,
 	cleanup:		idetape_cleanup,
 	standby:		NULL,
-	flushcache:		NULL,
 	do_request:		idetape_do_request,
 	end_request:		idetape_end_request,
 	ioctl:			idetape_blkdev_ioctl,
 	open:			idetape_blkdev_open,
 	release:		idetape_blkdev_release,
-	media_change:		NULL,
-	revalidate:		NULL,
+	check_media_change:	NULL,
+	revalidate:		idetape_revalidate,
 	pre_reset:		idetape_pre_reset,
 	capacity:		NULL,
-	proc:			idetape_proc,
-	driver_reinit:		idetape_reinit,
+	proc:			idetape_proc
 };
 
 /*
@@ -6175,12 +6178,6 @@
 	release:	idetape_chrdev_release,
 };
 
-/* This will propably just go entierly away... */
-static int idetape_reinit (ide_drive_t *drive)
-{
-	return 1;
-}
-
 MODULE_DESCRIPTION("ATAPI Streaming TAPE Driver");
 MODULE_LICENSE("GPL");
 
diff -ur linux-2.5.5/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.5/drivers/ide/ide-taskfile.c	Mon Mar  4 21:07:15 2002
+++ linux/drivers/ide/ide-taskfile.c	Mon Mar  4 13:32:18 2002
@@ -1750,6 +1750,29 @@
 	return err;
 }
 
+/*
+ * Issue ATA command and wait for completion. use for implementing commands in
+ * kernel.
+ *
+ * The caller has to make sure buf is never NULL!
+ */
+static int ide_wait_cmd(ide_drive_t *drive, int cmd, int nsect, int feature, int sectors, byte *argbuf)
+{
+	struct request rq;
+
+	/* FIXME: Do we really have to zero out the buffer?
+	 */
+	memset(argbuf, 0, 4 + SECTOR_WORDS * 4 * sectors);
+	ide_init_drive_cmd(&rq);
+	rq.buffer = argbuf;
+	*argbuf++ = cmd;
+	*argbuf++ = nsect;
+	*argbuf++ = feature;
+	*argbuf++ = sectors;
+
+	return ide_do_drive_cmd(drive, &rq, ide_wait);
+}
+
 int ide_cmd_ioctl (ide_drive_t *drive, struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
 {
 	int err = 0;
@@ -1806,12 +1829,20 @@
 int ide_task_ioctl (ide_drive_t *drive, struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
 {
 	int err = 0;
-	byte args[7], *argbuf = args;
+	u8 args[7];
+	u8 *argbuf;
 	int argsize = 7;
+	struct request rq;
+
+	argbuf = args;
 
 	if (copy_from_user(args, (void *)arg, 7))
 		return -EFAULT;
-	err = ide_wait_cmd_task(drive, argbuf);
+
+	ide_init_drive_cmd(&rq);
+	rq.flags = REQ_DRIVE_TASK;
+	rq.buffer = argbuf;
+	err = ide_do_drive_cmd(drive, &rq, ide_wait);
 	if (copy_to_user((void *)arg, argbuf, argsize))
 		err = -EFAULT;
 	return err;
diff -ur linux-2.5.5/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.5/drivers/ide/ide.c	Mon Mar  4 21:07:15 2002
+++ linux/drivers/ide/ide.c	Mon Mar  4 16:15:55 2002
@@ -581,15 +581,76 @@
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
+static void ata_pre_reset (ide_drive_t *drive)
+{
+	if (ata_ops(drive) && ata_ops(drive)->pre_reset)
+		ata_ops(drive)->pre_reset(drive);
+
+	if (!drive->keep_settings && !drive->using_dma) {
+		drive->unmask = 0;
+		drive->io_32bit = 0;
+	}
+
+	if (drive->using_dma) {
+		/* check the DMA crc count */
+		if (drive->crc_count) {
+			HWIF(drive)->dmaproc(ide_dma_off_quietly, drive);
+			if ((HWIF(drive)->speedproc) != NULL)
+				HWIF(drive)->speedproc(drive, ide_auto_reduce_xfer(drive));
+			if (drive->current_speed >= XFER_SW_DMA_0)
+				HWIF(drive)->dmaproc(ide_dma_on, drive);
+		} else
+			HWIF(drive)->dmaproc(ide_dma_off, drive);
+	}
+}
+
 /*
  * The capacity of a drive according to its current geometry/LBA settings in
  * sectors.
  */
-unsigned long current_capacity (ide_drive_t *drive)
+unsigned long ata_capacity(ide_drive_t *drive)
 {
 	if (!drive->present || !drive->driver)
 		return 0;
-	return ata_ops(drive)->capacity(drive);
+
+	if (ata_ops(drive) && ata_ops(drive)->capacity)
+		return ata_ops(drive)->capacity(drive);
+
+	/* FIXME: This magic number seems to be bogous. */
+	return 0x7fffffff;
+}
+
+/*
+ * This is used to issue WIN_SPECIFY, WIN_RESTORE, and WIN_SETMULT commands to
+ * a drive.  It used to do much more, but has been scaled back.
+ */
+static ide_startstop_t ata_special (ide_drive_t *drive)
+{
+	special_t *s = &drive->special;
+
+#ifdef DEBUG
+	printk("%s: ata_special: 0x%02x\n", drive->name, s->all);
+#endif
+	if (s->b.set_tune) {
+		ide_tuneproc_t *tuneproc = HWIF(drive)->tuneproc;
+		s->b.set_tune = 0;
+		if (tuneproc != NULL)
+			tuneproc(drive, drive->tune_req);
+	} else if (drive->driver != NULL) {
+		if (ata_ops(drive)->special)
+			return ata_ops(drive)->special(drive);
+		else {
+			drive->special.all = 0;
+			drive->mult_req = 0;
+
+			return ide_stopped;
+		}
+	} else if (s->all) {
+		printk("%s: bad special flag: 0x%02x\n", drive->name, s->all);
+		s->all = 0;
+	}
+
+	return ide_stopped;
 }
 
 extern struct block_device_operations ide_fops[];
@@ -612,9 +673,8 @@
 		register_disk(gd,mk_kdev(hwif->major,unit<<PARTN_BITS),
 #ifdef CONFIG_BLK_DEV_ISAPNP
 			(drive->forced_geom && drive->noprobe) ? 1 :
-#endif /* CONFIG_BLK_DEV_ISAPNP */
-			1<<PARTN_BITS, ide_fops,
-			current_capacity(drive));
+#endif
+			1 << PARTN_BITS, ide_fops, ata_capacity(drive));
 	}
 }
 
@@ -702,37 +762,6 @@
 	return ide_stopped;
 }
 
-static void check_dma_crc (ide_drive_t *drive)
-{
-	if (drive->crc_count) {
-		(void) HWIF(drive)->dmaproc(ide_dma_off_quietly, drive);
-		if ((HWIF(drive)->speedproc) != NULL)
-			HWIF(drive)->speedproc(drive, ide_auto_reduce_xfer(drive));
-		if (drive->current_speed >= XFER_SW_DMA_0)
-			(void) HWIF(drive)->dmaproc(ide_dma_on, drive);
-	} else {
-		(void) HWIF(drive)->dmaproc(ide_dma_off, drive);
-	}
-}
-
-static void pre_reset (ide_drive_t *drive)
-{
-	if (drive->driver != NULL)
-		ata_ops(drive)->pre_reset(drive);
-
-	if (!drive->keep_settings) {
-		if (drive->using_dma) {
-			check_dma_crc(drive);
-		} else {
-			drive->unmask = 0;
-			drive->io_32bit = 0;
-		}
-		return;
-	}
-	if (drive->using_dma)
-		check_dma_crc(drive);
-}
-
 /*
  * do_reset1() attempts to recover a confused drive by resetting it.
  * Unfortunately, resetting a disk drive actually resets all devices on
@@ -760,7 +789,7 @@
 
 	/* For an ATAPI device, first try an ATAPI SRST. */
 	if (drive->type != ATA_DISK && !do_not_try_atapi) {
-		pre_reset(drive);
+		ata_pre_reset(drive);
 		SELECT_DRIVE(hwif,drive);
 		udelay (20);
 		OUT_BYTE (WIN_SRST, IDE_COMMAND_REG);
@@ -775,7 +804,7 @@
 	 * for any of the drives on this interface.
 	 */
 	for (unit = 0; unit < MAX_DRIVES; ++unit)
-		pre_reset(&hwif->drives[unit]);
+		ata_pre_reset(&hwif->drives[unit]);
 
 #if OK_TO_RESET_CONTROLLER
 	if (!IDE_CONTROL_REG) {
@@ -1044,7 +1073,7 @@
 
 	if (rq->errors >= ERROR_MAX) {
 		/* ATA-PATTERN */
-		if (drive->driver != NULL)
+		if (ata_ops(drive) && ata_ops(drive)->end_request)
 			ata_ops(drive)->end_request(drive, 0);
 		else
 			ide_end_request(drive, 0);
@@ -1101,31 +1130,6 @@
 }
 
 /*
- * do_special() is used to issue WIN_SPECIFY, WIN_RESTORE, and WIN_SETMULT
- * commands to a drive.  It used to do much more, but has been scaled back.
- */
-static ide_startstop_t do_special (ide_drive_t *drive)
-{
-	special_t *s = &drive->special;
-
-#ifdef DEBUG
-	printk("%s: do_special: 0x%02x\n", drive->name, s->all);
-#endif
-	if (s->b.set_tune) {
-		ide_tuneproc_t *tuneproc = HWIF(drive)->tuneproc;
-		s->b.set_tune = 0;
-		if (tuneproc != NULL)
-			tuneproc(drive, drive->tune_req);
-	} else if (drive->driver != NULL) {
-		return ata_ops(drive)->special(drive);
-	} else if (s->all) {
-		printk("%s: bad special flag: 0x%02x\n", drive->name, s->all);
-		s->all = 0;
-	}
-	return ide_stopped;
-}
-
-/*
  * This routine busy-waits for the drive status to be not "busy".
  * It then checks the status for all of the "good" bits and none
  * of the "bad" bits, and if all is okay it returns 0.  All other
@@ -1338,16 +1342,21 @@
 		if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK | REQ_DRIVE_TASKFILE))
 			return execute_drive_cmd(drive, rq);
 
-		if (drive->driver != NULL) {
-			return ata_ops(drive)->do_request(drive, rq, block);
+		if (ata_ops(drive)) {
+			if (ata_ops(drive)->do_request)
+				return ata_ops(drive)->do_request(drive, rq, block);
+			else {
+				ide_end_request(drive, 0);
+				return ide_stopped;
+			}
 		}
 		printk(KERN_WARNING "%s: device type %d not supported\n",
 		       drive->name, drive->type);
 		goto kill_rq;
 	}
-	return do_special(drive);
+	return ata_special(drive);
 kill_rq:
-	if (drive->driver != NULL)
+	if (ata_ops(drive) && ata_ops(drive)->end_request)
 		ata_ops(drive)->end_request(drive, 0);
 	else
 		ide_end_request(drive, 0);
@@ -1569,13 +1578,13 @@
 	/*
 	 * end current dma transaction
 	 */
-	(void) hwif->dmaproc(ide_dma_end, drive);
+	hwif->dmaproc(ide_dma_end, drive);
 
 	/*
 	 * complain a little, later we might remove some of this verbosity
 	 */
 	printk("%s: timeout waiting for DMA\n", drive->name);
-	(void) hwif->dmaproc(ide_dma_timeout, drive);
+	hwif->dmaproc(ide_dma_timeout, drive);
 
 	/*
 	 * disable dma for now, but remember that we did so because of
@@ -1584,7 +1593,7 @@
 	 */
 	drive->retry_pio++;
 	drive->state = DMA_PIO_RETRY;
-	(void) hwif->dmaproc(ide_dma_off_quietly, drive);
+	hwif->dmaproc(ide_dma_off_quietly, drive);
 
 	/*
 	 * un-busy drive etc (hwgroup->busy is cleared on return) and
@@ -1611,7 +1620,7 @@
 	ide_hwgroup_t	*hwgroup = (ide_hwgroup_t *) data;
 	ide_handler_t	*handler;
 	ide_expiry_t	*expiry;
- 	unsigned long	flags;
+	unsigned long	flags;
 	unsigned long	wait;
 
 	/*
@@ -1937,16 +1946,6 @@
 
 }
 
-/* Common for ide-floppy.c and ide-disk.c */
-void ide_revalidate_drive (ide_drive_t *drive)
-{
-        struct gendisk *g = HWIF(drive)->gd;
-        int minor = (drive->select.b.unit << g->minor_shift);
-        kdev_t dev = mk_kdev(g->major, minor);
-
-        grok_partitions(dev, current_capacity(drive));
-}
-
 /*
  * This routine is called to flush all partitions and partition tables
  * for a changed disk, and then re-read the new partition table.
@@ -1975,13 +1974,16 @@
 	spin_unlock_irqrestore(&ide_lock, flags);
 
 	res = wipe_partitions(i_rdev);
-	if (res)
-		goto leave;
-
-	if (ata_ops(drive)->revalidate)
-		ata_ops(drive)->revalidate(drive);
+	if (!res) {
+		if (ata_ops(drive) && ata_ops(drive)->revalidate) {
+			ata_get(ata_ops(drive));
+			/* this is a no-op for tapes and SCSI based access */
+			ata_ops(drive)->revalidate(drive);
+			ata_put(ata_ops(drive));
+		} else
+			grok_partitions(i_rdev, ata_capacity(drive));
+	}
 
- leave:
 	drive->busy = 0;
 	wake_up(&drive->wqueue);
 	MOD_DEC_USE_COUNT;
@@ -2073,9 +2075,14 @@
 #endif /* CONFIG_KMOD */
 	while (drive->busy)
 		sleep_on(&drive->wqueue);
-	drive->usage++;
-	if (drive->driver != NULL)
+	++drive->usage;
+	if (ata_ops(drive) && ata_ops(drive)->open)
 		return ata_ops(drive)->open(inode, filp, drive);
+	else {
+		--drive->usage;
+		return -ENODEV;
+	}
+
 	printk ("%s: driver not present\n", drive->name);
 	drive->usage--;
 	return -ENXIO;
@@ -2085,15 +2092,16 @@
  * Releasing a block device means we sync() it, so that it can safely
  * be forgotten about...
  */
-static int ide_release (struct inode * inode, struct file * file)
+static int ide_release(struct inode * inode, struct file * file)
 {
 	ide_drive_t *drive;
 
-	if ((drive = get_info_ptr(inode->i_rdev)) != NULL) {
-		drive->usage--;
-		if (drive->driver != NULL)
-			ata_ops(drive)->release(inode, file, drive);
-	}
+	if (!(drive = get_info_ptr(inode->i_rdev)))
+		return 0;
+
+	drive->usage--;
+	if (ata_ops(drive) && ata_ops(drive)->release)
+		ata_ops(drive)->release(inode, file, drive);
 	return 0;
 }
 
@@ -2164,11 +2172,17 @@
 			continue;
 		if (drive->busy || drive->usage)
 			goto abort;
-		if (drive->driver != NULL && ata_ops(drive)->cleanup(drive))
-			goto abort;
+		if (ata_ops(drive)) {
+			if (ata_ops(drive)->cleanup) {
+				if (ata_ops(drive)->cleanup(drive))
+					goto abort;
+			} else {
+				ide_unregister_subdriver(drive);
+			}
+		}
 	}
 	hwif->present = 0;
-	
+
 	/*
 	 * All clear?  Then blow away the buffer cache
 	 */
@@ -2595,33 +2609,6 @@
 	ide_add_setting(drive,	"number",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	3,				1,		1,		&drive->dn,			NULL);
 }
 
-int ide_wait_cmd (ide_drive_t *drive, int cmd, int nsect, int feature, int sectors, byte *buf)
-{
-	struct request rq;
-	byte buffer[4];
-
-	if (!buf)
-		buf = buffer;
-	memset(buf, 0, 4 + SECTOR_WORDS * 4 * sectors);
-	ide_init_drive_cmd(&rq);
-	rq.buffer = buf;
-	*buf++ = cmd;
-	*buf++ = nsect;
-	*buf++ = feature;
-	*buf++ = sectors;
-	return ide_do_drive_cmd(drive, &rq, ide_wait);
-}
-
-int ide_wait_cmd_task (ide_drive_t *drive, byte *buf)
-{
-	struct request rq;
-
-	ide_init_drive_cmd(&rq);
-	rq.flags = REQ_DRIVE_TASK;
-	rq.buffer = buf;
-	return ide_do_drive_cmd(drive, &rq, ide_wait);
-}
-
 /*
  * Delay for *at least* 50ms.  As we don't know how much time is left
  * until the next tick occurs, we wait an extra tick to be safe.
@@ -2721,7 +2708,8 @@
 		}
 
 		case BLKRRPART: /* Re-read partition tables */
-			if (!capable(CAP_SYS_ADMIN)) return -EACCES;
+			if (!capable(CAP_SYS_ADMIN))
+				return -EACCES;
 			return ide_revalidate_disk(inode->i_rdev);
 
 		case HDIO_OBSOLETE_IDENTITY:
@@ -2866,9 +2854,9 @@
 			return 0;
 
 		default:
-			if (drive->driver != NULL)
+			if (ata_ops(drive) && ata_ops(drive)->ioctl)
 				return ata_ops(drive)->ioctl(drive, inode, file, cmd, arg);
-			return -EPERM;
+			return -EINVAL;
 	}
 }
 
@@ -2878,8 +2866,14 @@
 
 	if ((drive = get_info_ptr(i_rdev)) == NULL)
 		return -ENODEV;
-	if (drive->driver != NULL)
-		return ata_ops(drive)->media_change(drive);
+	if (ata_ops(drive)) {
+		ata_get(ata_ops(drive));
+		if (ata_ops(drive)->check_media_change)
+			return ata_ops(drive)->check_media_change(drive);
+		else
+			return 1; /* assume it was changed */
+		ata_put(ata_ops(drive));
+	}
 	return 0;
 }
 
@@ -3470,24 +3464,24 @@
 	 */
 	probe_for_hwifs ();
 
-#ifdef CONFIG_BLK_DEV_IDE
-#if defined(__mc68000__) || defined(CONFIG_APUS)
+#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULES)
+# if defined(__mc68000__) || defined(CONFIG_APUS)
 	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET]) {
 		ide_get_lock(&ide_intr_lock, NULL, NULL);/* for atari only */
 		disable_irq(ide_hwifs[0].irq);	/* disable_irq_nosync ?? */
 //		disable_irq_nosync(ide_hwifs[0].irq);
 	}
-#endif /* __mc68000__ || CONFIG_APUS */
+# endif
 
 	ideprobe_init();
 
-#if defined(__mc68000__) || defined(CONFIG_APUS)
+# if defined(__mc68000__) || defined(CONFIG_APUS)
 	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET]) {
 		enable_irq(ide_hwifs[0].irq);
 		ide_release_lock(&ide_intr_lock);/* for atari only */
 	}
-#endif /* __mc68000__ || CONFIG_APUS */
-#endif /* CONFIG_BLK_DEV_IDE */
+# endif
+#endif
 
 #ifdef CONFIG_PROC_FS
 	proc_ide_create();
@@ -3517,79 +3511,12 @@
 #endif
 }
 
-static int default_cleanup (ide_drive_t *drive)
-{
-	return ide_unregister_subdriver(drive);
-}
-
-static int default_standby (ide_drive_t *drive)
-{
-	return 0;
-}
-
-static int default_flushcache (ide_drive_t *drive)
-{
-	return 0;
-}
-
-static ide_startstop_t default_do_request(ide_drive_t *drive, struct request *rq, unsigned long block)
-{
-	ide_end_request(drive, 0);
-	return ide_stopped;
-}
-
 /* This is the default end request function as well */
 int ide_end_request(ide_drive_t *drive, int uptodate)
 {
 	return __ide_end_request(drive, uptodate, 0);
 }
 
-static int default_ioctl (ide_drive_t *drive, struct inode *inode, struct file *file,
-			  unsigned int cmd, unsigned long arg)
-{
-	return -EIO;
-}
-
-static int default_open (struct inode *inode, struct file *filp, ide_drive_t *drive)
-{
-	drive->usage--;
-	return -EIO;
-}
-
-static void default_release (struct inode *inode, struct file *filp, ide_drive_t *drive)
-{
-}
-
-static int default_check_media_change (ide_drive_t *drive)
-{
-	return 1;
-}
-
-static void default_pre_reset (ide_drive_t *drive)
-{
-}
-
-static unsigned long default_capacity (ide_drive_t *drive)
-{
-	return 0x7fffffff;
-}
-
-static ide_startstop_t default_special (ide_drive_t *drive)
-{
-	special_t *s = &drive->special;
-
-	s->all = 0;
-	drive->mult_req = 0;
-	return ide_stopped;
-}
-
-static int default_driver_reinit (ide_drive_t *drive)
-{
-	printk(KERN_ERR "%s: does not support hotswap of device class !\n", drive->name);
-
-	return 0;
-}
-
 /*
  * Lookup IDE devices, which requested a particular deriver
  */
@@ -3627,37 +3554,11 @@
 		return 1;
 	}
 
-	drive->driver = driver;
-
-	/* Fill in the default handlers
+	/* FIXME: This will be pushed to the drivers! Thus allowing us to
+	 * save one parameter here eparate this out.
 	 */
 
-	if (driver->cleanup == NULL)
-	    driver->cleanup = default_cleanup;
-	if (driver->standby == NULL)
-	    driver->standby = default_standby;
-	if (driver->flushcache == NULL)
-	    driver->flushcache = default_flushcache;
-	if (driver->do_request == NULL)
-	    driver->do_request = default_do_request;
-	if (driver->end_request == NULL)
-	    driver->end_request = ide_end_request;
-	if (driver->ioctl == NULL)
-	    driver->ioctl = default_ioctl;
-	if (driver->open == NULL)
-	    driver->open = default_open;
-	if (driver->release == NULL)
-	    driver->release = default_release;
-	if (driver->media_change == NULL)
-	    driver->media_change = default_check_media_change;
-	if (driver->pre_reset == NULL)
-	    driver->pre_reset = default_pre_reset;
-	if (driver->capacity == NULL)
-	    driver->capacity = default_capacity;
-	if (driver->special == NULL)
-	    driver->special = default_special;
-	if (driver->driver_reinit == NULL)
-	    driver->driver_reinit = default_driver_reinit;
+	drive->driver = driver;
 
 	restore_flags(flags);		/* all CPUs */
 	/* FIXME: Check what this magic number is supposed to be about? */
@@ -3684,26 +3585,33 @@
 	drive->suspend_reset = 0;
 #ifdef CONFIG_PROC_FS
 	ide_add_proc_entries(drive->proc, generic_subdriver_entries, drive);
-	ide_add_proc_entries(drive->proc, driver->proc, drive);
+	if (ata_ops(drive))
+		ide_add_proc_entries(drive->proc, ata_ops(drive)->proc, drive);
 #endif
 	return 0;
 }
 
+/*
+ * This is in fact the default cleanup routine.
+ *
+ * FIXME: Check whatever we maybe don't call it twice!.
+ */
 int ide_unregister_subdriver(ide_drive_t *drive)
 {
 	unsigned long flags;
 
 	save_flags(flags);		/* all CPUs */
 	cli();				/* all CPUs */
-	if (drive->usage || drive->busy || drive->driver == NULL || ata_ops(drive)->busy) {
+	if (drive->usage || drive->busy || !ata_ops(drive) || ata_ops(drive)->busy) {
 		restore_flags(flags);	/* all CPUs */
 		return 1;
 	}
 #if defined(CONFIG_BLK_DEV_ISAPNP) && defined(CONFIG_ISAPNP) && defined(MODULE)
 	pnpide_init(0);
-#endif /* CONFIG_BLK_DEV_ISAPNP */
+#endif
 #ifdef CONFIG_PROC_FS
-	ide_remove_proc_entries(drive->proc, ata_ops(drive)->proc);
+	if (ata_ops(drive))
+		ide_remove_proc_entries(drive->proc, ata_ops(drive)->proc);
 	ide_remove_proc_entries(drive->proc, generic_subdriver_entries);
 #endif
 	auto_remove_settings(drive);
@@ -3778,11 +3686,8 @@
 EXPORT_SYMBOL(ide_end_drive_cmd);
 EXPORT_SYMBOL(__ide_end_request);
 EXPORT_SYMBOL(ide_end_request);
-EXPORT_SYMBOL(ide_revalidate_drive);
 EXPORT_SYMBOL(ide_revalidate_disk);
 EXPORT_SYMBOL(ide_cmd);
-EXPORT_SYMBOL(ide_wait_cmd);
-EXPORT_SYMBOL(ide_wait_cmd_task);
 EXPORT_SYMBOL(ide_delay_50ms);
 EXPORT_SYMBOL(ide_stall_queue);
 #ifdef CONFIG_PROC_FS
@@ -3798,7 +3703,6 @@
 EXPORT_SYMBOL(ide_unregister);
 EXPORT_SYMBOL(ide_setup_ports);
 EXPORT_SYMBOL(get_info_ptr);
-EXPORT_SYMBOL(current_capacity);
 
 static int ide_notify_reboot (struct notifier_block *this, unsigned long event, void *x)
 {
@@ -3828,12 +3732,14 @@
 
 			/* set the drive to standby */
 			printk("%s ", drive->name);
-			if (event != SYS_RESTART)
-				if (drive->driver != NULL && ata_ops(drive)->standby(drive))
-					continue;
+			if (ata_ops(drive)) {
+				if (event != SYS_RESTART)
+					if (ata_ops(drive)->standby && ata_ops(drive)->standby(drive))
+						continue;
 
-			if (drive->driver != NULL && ata_ops(drive)->cleanup(drive))
-				continue;
+				if (ata_ops(drive)->cleanup)
+					ata_ops(drive)->cleanup(drive);
+			}
 		}
 	}
 	printk("\n");
@@ -3928,7 +3834,7 @@
 		ide_unregister(index);
 # if defined(CONFIG_BLK_DEV_IDEDMA) && !defined(CONFIG_DMA_NONPCI)
 		if (ide_hwifs[index].dma_base)
-			(void) ide_release_dma(&ide_hwifs[index]);
+			ide_release_dma(&ide_hwifs[index]);
 # endif /* (CONFIG_BLK_DEV_IDEDMA) && !(CONFIG_DMA_NONPCI) */
 	}
 
diff -ur linux-2.5.5/drivers/ide/piix.c linux/drivers/ide/piix.c
--- linux-2.5.5/drivers/ide/piix.c	Mon Mar  4 21:07:15 2002
+++ linux/drivers/ide/piix.c	Mon Mar  4 02:50:08 2002
@@ -214,7 +214,7 @@
 {
 	unsigned long flags;
 	u16 master_data;
-	byte slave_data;
+	u8 slave_data;
 	int is_slave		= (&HWIF(drive)->drives[1] == drive);
 	int master_port		= HWIF(drive)->index ? 0x42 : 0x40;
 	int slave_port		= 0x44;
diff -ur linux-2.5.5/drivers/ide/serverworks.c linux/drivers/ide/serverworks.c
--- linux-2.5.5/drivers/ide/serverworks.c	Mon Mar  4 21:07:15 2002
+++ linux/drivers/ide/serverworks.c	Mon Mar  4 02:50:08 2002
@@ -660,8 +660,10 @@
 	hwif->autodma = 0;
 #else /* CONFIG_BLK_DEV_IDEDMA */
 	if (hwif->dma_base) {
+#ifdef CONFIG_IDEDMA_AUTO
 		if (!noautodma)
 			hwif->autodma = 1;
+#endif
 		hwif->dmaproc = &svwks_dmaproc;
 		hwif->highmem = 1;
 	} else {
diff -ur linux-2.5.5/drivers/scsi/ide-scsi.c linux/drivers/scsi/ide-scsi.c
--- linux-2.5.5/drivers/scsi/ide-scsi.c	Mon Mar  4 21:07:15 2002
+++ linux/drivers/scsi/ide-scsi.c	Mon Mar  4 02:50:08 2002
@@ -536,7 +536,11 @@
 	return 0;
 }
 
-static int idescsi_reinit(ide_drive_t *drive);
+static void idescsi_revalidate(ide_drive_t *_dummy)
+{
+	/* The partition information will be handled by the SCSI layer.
+	 */
+}
 
 /*
  *	IDE subdriver functions, registered with ide.c
@@ -545,26 +549,19 @@
 	owner:			THIS_MODULE,
 	cleanup:		idescsi_cleanup,
 	standby:		NULL,
-	flushcache:		NULL,
 	do_request:		idescsi_do_request,
 	end_request:		idescsi_end_request,
 	ioctl:			NULL,
 	open:			idescsi_open,
 	release:		idescsi_ide_release,
-	media_change:		NULL,
-	revalidate:		NULL,
+	check_media_change:	NULL,
+	revalidate:		idescsi_revalidate,
 	pre_reset:		NULL,
 	capacity:		NULL,
 	special:		NULL,
-	proc:			NULL,
-	driver_reinit:		idescsi_reinit,
+	proc:			NULL
 };
 
-static int idescsi_reinit (ide_drive_t *drive)
-{
-	return 0;
-}
-
 /*
  *	idescsi_init will register the driver for each scsi.
  */
diff -ur linux-2.5.5/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.5/include/linux/ide.h	Mon Mar  4 21:07:16 2002
+++ linux/include/linux/ide.h	Mon Mar  4 20:52:43 2002
@@ -51,29 +51,17 @@
 #endif
 
 #ifdef CONFIG_BLK_DEV_CMD640
-#if 0	/* change to 1 when debugging cmd640 problems */
+# if 0	/* change to 1 when debugging cmd640 problems */
 void cmd640_dump_regs (void);
-#define CMD640_DUMP_REGS cmd640_dump_regs() /* for debugging cmd640 chipset */
+#  define CMD640_DUMP_REGS cmd640_dump_regs() /* for debugging cmd640 chipset */
+# endif
 #endif
-#endif  /* CONFIG_BLK_DEV_CMD640 */
 
 #ifndef DISABLE_IRQ_NOSYNC
-#define DISABLE_IRQ_NOSYNC	0
+# define DISABLE_IRQ_NOSYNC	0
 #endif
 
 /*
- * IDE_DRIVE_CMD is used to implement many features of the hdparm utility
- */
-#define IDE_DRIVE_CMD			99	/* (magic) undef to reduce kernel size*/
-
-#define IDE_DRIVE_TASK			98
-
-/*
- * IDE_DRIVE_TASKFILE is used to implement many features needed for raw tasks
- */
-#define IDE_DRIVE_TASKFILE		97
-
-/*
  *  "No user-serviceable parts" beyond this point  :)
  *****************************************************************************/
 
@@ -95,7 +83,7 @@
  * Ensure that various configuration flags have compatible settings
  */
 #ifdef REALLY_SLOW_IO
-#undef REALLY_FAST_IO
+# undef REALLY_FAST_IO
 #endif
 
 #define HWIF(drive)		((drive)->hwif)
@@ -705,21 +693,19 @@
 	unsigned busy: 1; /* FIXME: this will go soon away... */
 	int (*cleanup)(ide_drive_t *);
 	int (*standby)(ide_drive_t *);
-	int (*flushcache)(ide_drive_t *);
 	ide_startstop_t	(*do_request)(ide_drive_t *, struct request *, unsigned long);
 	int (*end_request)(ide_drive_t *drive, int uptodate);
 
 	int (*ioctl)(ide_drive_t *, struct inode *, struct file *, unsigned int, unsigned long);
 	int (*open)(struct inode *, struct file *, ide_drive_t *);
 	void (*release)(struct inode *, struct file *, ide_drive_t *);
-	int (*media_change)(ide_drive_t *);
+	int (*check_media_change)(ide_drive_t *);
 	void (*revalidate)(ide_drive_t *);
 
 	void (*pre_reset)(ide_drive_t *);
 	unsigned long (*capacity)(ide_drive_t *);
 	ide_startstop_t	(*special)(ide_drive_t *);
-	ide_proc_entry_t		*proc;
-	int (*driver_reinit)(ide_drive_t *);
+	ide_proc_entry_t *proc;
 };
 
 /* Alas, no aliases. Too much hassle with bringing module.h everywhere */
@@ -734,6 +720,7 @@
 		__MOD_DEC_USE_COUNT((ata)->owner);	\
 } while(0)
 
+extern unsigned long ata_capacity(ide_drive_t *drive);
 
 /* FIXME: Actually implement and use them as soon as possible!  to make the
  * ide_scan_devices() go away! */
@@ -819,16 +806,6 @@
 ide_drive_t *get_info_ptr (kdev_t i_rdev);
 
 /*
- * Return the current idea about the total capacity of this drive.
- */
-unsigned long current_capacity (ide_drive_t *drive);
-
-/*
- * Revalidate (read partition tables)
- */
-extern void ide_revalidate_drive (ide_drive_t *drive);
-
-/*
  * Start a reset operation for an IDE interface.
  * The caller should return immediately after invoking this.
  */
@@ -892,18 +869,9 @@
 
 /*
  * Clean up after success/failure of an explicit drive cmd.
- * stat/err are used only when (HWGROUP(drive)->rq->cmd == IDE_DRIVE_CMD).
- * stat/err are used only when (HWGROUP(drive)->rq->cmd == IDE_DRIVE_TASK_MASK).
  */
 void ide_end_drive_cmd (ide_drive_t *drive, byte stat, byte err);
 
-/*
- * Issue ATA command and wait for completion. use for implementing commands in kernel
- */
-int ide_wait_cmd (ide_drive_t *drive, int cmd, int nsect, int feature, int sectors, byte *buf);
-
-int ide_wait_cmd_task (ide_drive_t *drive, byte *buf);
- 
 typedef struct ide_task_s {
 	task_ioreg_t		tfRegister[8];
 	task_ioreg_t		hobRegister[8];

--------------010903050201000402030201--

