Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291305AbSBSLr1>; Tue, 19 Feb 2002 06:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291306AbSBSLrO>; Tue, 19 Feb 2002 06:47:14 -0500
Received: from [195.63.194.11] ([195.63.194.11]:15631 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291305AbSBSLq7>; Tue, 19 Feb 2002 06:46:59 -0500
Message-ID: <3C723B15.2030409@evision-ventures.com>
Date: Tue, 19 Feb 2002 12:46:29 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <Pine.LNX.4.33.0202131434350.21395-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------010506060108010003080708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010506060108010003080708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch does the following:

1.  Kill the ide-probe-mod by merging it with ide-mod. There is *really*
     no reaons for having this stuff split up into two different
    modules unless you wan't to create artificial module dependancies 
and waste space
    of page boundaries during memmory allocation for the modules

2. Kill the ide_module_t - which is unnecessary and presents a 
"reimplementation"
   of module handling inside the  ide driver. This is achieved by 
attaching the
   initialization routine ot the ide_driver_t, which will be gone next 
time,
   since there is no sane reason apparently, which this couldn't be done
   during the module-generic initialization of the corresponding driver 
module.

3. Kill unnecessary tagging of "subdriver" with IDE_SUBDRIVER_VERSION - we
   have plenty of other mechanisms for module consistency checking. And 
anyway
   the ide code didn't any consistence checks on this  value at all.

NOTE: The ide_(un)register_module() functions will be killed in next round.

This patch should apply to mainstream, however it waws created on top of 
the others.



--------------010506060108010003080708
Content-Type: text/plain;
 name="ide-clean-9.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-9.diff"

diff -ur linux-2.5.4/drivers/ide/Makefile linux/drivers/ide/Makefile
--- linux-2.5.4/drivers/ide/Makefile	Mon Feb 11 02:50:09 2002
+++ linux/drivers/ide/Makefile	Tue Feb 19 02:27:50 2002
@@ -11,14 +11,14 @@
 O_TARGET := idedriver.o
 
 export-objs		:= ide-taskfile.o ide.o ide-features.o ide-probe.o ataraid.o
-list-multi		:= ide-mod.o ide-probe-mod.o
+list-multi		:= ide-mod.o
 
 obj-y		:=
 obj-m		:=
 ide-obj-y	:=
 
 obj-$(CONFIG_BLK_DEV_HD)	+= hd.o
-obj-$(CONFIG_BLK_DEV_IDE)       += ide-mod.o ide-probe-mod.o
+obj-$(CONFIG_BLK_DEV_IDE)       += ide-mod.o
 obj-$(CONFIG_BLK_DEV_IDECS)     += ide-cs.o
 obj-$(CONFIG_BLK_DEV_IDEDISK)   += ide-disk.o
 obj-$(CONFIG_BLK_DEV_IDECD)     += ide-cd.o
@@ -76,13 +76,9 @@
 
 ide-obj-$(CONFIG_PROC_FS)		+= ide-proc.o
 
-ide-mod-objs		:= ide-taskfile.o ide.o ide-features.o $(ide-obj-y)
-ide-probe-mod-objs	:= ide-probe.o ide-geometry.o
+ide-mod-objs		:= ide-taskfile.o ide.o ide-probe.o ide-geometry.o ide-features.o $(ide-obj-y)
 
 include $(TOPDIR)/Rules.make
 
 ide-mod.o: $(ide-mod-objs)
 	$(LD) -r -o $@ $(ide-mod-objs)
-
-ide-probe-mod.o: $(ide-probe-mod-objs)
-	$(LD) -r -o $@ $(ide-probe-mod-objs)
diff -ur linux-2.5.4/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.4/drivers/ide/ide-cd.c	Fri Feb 15 06:35:50 2002
+++ linux/drivers/ide/ide-cd.c	Tue Feb 19 03:11:03 2002
@@ -2906,6 +2906,7 @@
 	return 0;
 }
 
+int ide_cdrom_init(void);
 int ide_cdrom_reinit (ide_drive_t *drive);
 
 static ide_driver_t ide_cdrom_driver = {
@@ -2928,17 +2929,10 @@
 	capacity:		ide_cdrom_capacity,
 	special:		NULL,
 	proc:			NULL,
+	driver_init:		ide_cdrom_init,
 	driver_reinit:		ide_cdrom_reinit,
 };
 
-int ide_cdrom_init(void);
-static ide_module_t ide_cdrom_module = {
-	IDE_DRIVER_MODULE,
-	ide_cdrom_init,
-	&ide_cdrom_driver,
-	NULL
-};
-
 /* options */
 char *ignore = NULL;
 
@@ -2956,7 +2950,7 @@
 		printk ("%s: Can't allocate a cdrom structure\n", drive->name);
 		return 1;
 	}
-	if (ide_register_subdriver (drive, &ide_cdrom_driver, IDE_SUBDRIVER_VERSION)) {
+	if (ide_register_subdriver (drive, &ide_cdrom_driver)) {
 		printk ("%s: Failed to register the driver with ide.c\n", drive->name);
 		kfree (info);
 		return 1;
@@ -2973,7 +2967,7 @@
 	DRIVER(drive)->busy--;
 	failed--;
 
-	ide_register_module(&ide_cdrom_module);
+	ide_register_module(&ide_cdrom_driver);
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
@@ -2988,7 +2982,7 @@
 			printk ("%s: cleanup_module() called while still busy\n", drive->name);
 			failed++;
 		}
-	ide_unregister_module (&ide_cdrom_module);
+	ide_unregister_module (&ide_cdrom_driver);
 }
  
 int ide_cdrom_init(void)
@@ -3015,7 +3009,7 @@
 			printk ("%s: Can't allocate a cdrom structure\n", drive->name);
 			continue;
 		}
-		if (ide_register_subdriver (drive, &ide_cdrom_driver, IDE_SUBDRIVER_VERSION)) {
+		if (ide_register_subdriver (drive, &ide_cdrom_driver)) {
 			printk ("%s: Failed to register the driver with ide.c\n", drive->name);
 			kfree (info);
 			continue;
@@ -3032,7 +3026,7 @@
 		DRIVER(drive)->busy--;
 		failed--;
 	}
-	ide_register_module(&ide_cdrom_module);
+	ide_register_module(&ide_cdrom_driver);
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
diff -ur linux-2.5.4/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.4/drivers/ide/ide-disk.c	Fri Feb 15 06:23:11 2002
+++ linux/drivers/ide/ide-disk.c	Tue Feb 19 03:07:32 2002
@@ -1030,6 +1030,7 @@
 	return ide_unregister_subdriver(drive);
 }
 
+int idedisk_init (void);
 int idedisk_reinit(ide_drive_t *drive);
 
 /*
@@ -1055,17 +1056,10 @@
 	capacity:		idedisk_capacity,
 	special:		idedisk_special,
 	proc:			idedisk_proc,
+	driver_init:		idedisk_init,
 	driver_reinit:		idedisk_reinit,
 };
 
-int idedisk_init (void);
-static ide_module_t idedisk_module = {
-	IDE_DRIVER_MODULE,
-	idedisk_init,
-	&idedisk_driver,
-	NULL
-};
-
 MODULE_DESCRIPTION("ATA DISK Driver");
 
 int idedisk_reinit (ide_drive_t *drive)
@@ -1074,7 +1068,7 @@
 
 	MOD_INC_USE_COUNT;
 
-	if (ide_register_subdriver (drive, &idedisk_driver, IDE_SUBDRIVER_VERSION)) {
+	if (ide_register_subdriver (drive, &idedisk_driver)) {
 		printk (KERN_ERR "ide-disk: %s: Failed to register the driver with ide.c\n", drive->name);
 		return 1;
 	}
@@ -1089,7 +1083,7 @@
 	DRIVER(drive)->busy--;
 	failed--;
 
-	ide_register_module(&idedisk_module);
+	ide_register_module(&idedisk_driver);
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
@@ -1111,7 +1105,7 @@
 			ide_remove_proc_entries(drive->proc, idedisk_proc);
 #endif
 	}
-	ide_unregister_module(&idedisk_module);
+	ide_unregister_module(&idedisk_driver);
 }
 
 int idedisk_init (void)
@@ -1121,7 +1115,7 @@
 	
 	MOD_INC_USE_COUNT;
 	while ((drive = ide_scan_devices (ide_disk, idedisk_driver.name, NULL, failed++)) != NULL) {
-		if (ide_register_subdriver (drive, &idedisk_driver, IDE_SUBDRIVER_VERSION)) {
+		if (ide_register_subdriver (drive, &idedisk_driver)) {
 			printk (KERN_ERR "ide-disk: %s: Failed to register the driver with ide.c\n", drive->name);
 			continue;
 		}
@@ -1136,7 +1130,7 @@
 		DRIVER(drive)->busy--;
 		failed--;
 	}
-	ide_register_module(&idedisk_module);
+	ide_register_module(&idedisk_driver);
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
diff -ur linux-2.5.4/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux-2.5.4/drivers/ide/ide-floppy.c	Fri Feb 15 06:47:11 2002
+++ linux/drivers/ide/ide-floppy.c	Tue Feb 19 03:14:55 2002
@@ -2046,6 +2046,7 @@
 
 #endif	/* CONFIG_PROC_FS */
 
+int idefloppy_init(void);
 int idefloppy_reinit(ide_drive_t *drive);
 
 /*
@@ -2071,17 +2072,10 @@
 	capacity:		idefloppy_capacity,
 	special:		NULL,
 	proc:			idefloppy_proc,
+	driver_init:		idefloppy_init,
 	driver_reinit:		idefloppy_reinit,
 };
 
-int idefloppy_init (void);
-static ide_module_t idefloppy_module = {
-	IDE_DRIVER_MODULE,
-	idefloppy_init,
-	&idefloppy_driver,
-	NULL
-};
-
 int idefloppy_reinit (ide_drive_t *drive)
 {
 	idefloppy_floppy_t *floppy;
@@ -2101,7 +2095,7 @@
 			printk (KERN_ERR "ide-floppy: %s: Can't allocate a floppy structure\n", drive->name);
 			continue;
 		}
-		if (ide_register_subdriver (drive, &idefloppy_driver, IDE_SUBDRIVER_VERSION)) {
+		if (ide_register_subdriver (drive, &idefloppy_driver)) {
 			printk (KERN_ERR "ide-floppy: %s: Failed to register the driver with ide.c\n", drive->name);
 			kfree (floppy);
 			continue;
@@ -2111,7 +2105,7 @@
 		DRIVER(drive)->busy--;
 		failed--;
 	}
-	ide_register_module(&idefloppy_module);
+	ide_register_module(&idefloppy_driver);
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
@@ -2136,7 +2130,7 @@
 			ide_remove_proc_entries(drive->proc, idefloppy_proc);
 #endif
 	}
-	ide_unregister_module(&idefloppy_module);
+	ide_unregister_module(&idefloppy_driver);
 }
 
 /*
@@ -2163,7 +2157,7 @@
 			printk (KERN_ERR "ide-floppy: %s: Can't allocate a floppy structure\n", drive->name);
 			continue;
 		}
-		if (ide_register_subdriver (drive, &idefloppy_driver, IDE_SUBDRIVER_VERSION)) {
+		if (ide_register_subdriver (drive, &idefloppy_driver)) {
 			printk (KERN_ERR "ide-floppy: %s: Failed to register the driver with ide.c\n", drive->name);
 			kfree (floppy);
 			continue;
@@ -2173,7 +2167,7 @@
 		DRIVER(drive)->busy--;
 		failed--;
 	}
-	ide_register_module(&idefloppy_module);
+	ide_register_module(&idefloppy_driver);
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
diff -ur linux-2.5.4/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux-2.5.4/drivers/ide/ide-probe.c	Mon Feb 18 01:46:29 2002
+++ linux/drivers/ide/ide-probe.c	Tue Feb 19 02:34:37 2002
@@ -927,19 +927,11 @@
 	return hwif->present;
 }
 
-int ideprobe_init (void);
-static ide_module_t ideprobe_module = {
-	IDE_PROBE_MODULE,
-	ideprobe_init,
-	NULL
-};
-
 int ideprobe_init (void)
 {
 	unsigned int index;
 	int probe[MAX_HWIFS];
 	
-	MOD_INC_USE_COUNT;
 	memset(probe, 0, MAX_HWIFS * sizeof(int));
 	for (index = 0; index < MAX_HWIFS; ++index)
 		probe[index] = !ide_hwifs[index].present;
@@ -953,31 +945,5 @@
 	for (index = 0; index < MAX_HWIFS; ++index)
 		if (probe[index])
 			hwif_init(&ide_hwifs[index]);
-	if (!ide_probe)
-		ide_probe = &ideprobe_module;
-	MOD_DEC_USE_COUNT;
-	return 0;
-}
-
-#ifdef MODULE
-extern int (*ide_xlate_1024_hook)(kdev_t, int, int, const char *);
-
-int init_module (void)
-{
-	unsigned int index;
-	
-	for (index = 0; index < MAX_HWIFS; ++index)
-		ide_unregister(index);
-	ideprobe_init();
-	create_proc_ide_interfaces();
-	ide_xlate_1024_hook = ide_xlate_1024;
 	return 0;
 }
-
-void cleanup_module (void)
-{
-	ide_probe = NULL;
-	ide_xlate_1024_hook = 0;
-}
-MODULE_LICENSE("GPL");
-#endif /* MODULE */
diff -ur linux-2.5.4/drivers/ide/ide-proc.c linux/drivers/ide/ide-proc.c
--- linux-2.5.4/drivers/ide/ide-proc.c	Sun Feb 17 03:43:38 2002
+++ linux/drivers/ide/ide-proc.c	Tue Feb 19 02:59:27 2002
@@ -378,14 +378,10 @@
 {
 	char		*out = page;
 	int		len;
-	ide_module_t	*p = ide_modules;
-	ide_driver_t	*driver;
+	struct ide_driver_s * driver;
 
-	while (p) {
-		driver = (ide_driver_t *) p->info;
-		if (driver)
-			out += sprintf(out, "%s\n",driver->name);
-		p = p->next;
+	for (driver = ide_drivers; driver; driver = driver->next) {
+		out += sprintf(out, "%s\n",driver->name);
 	}
 	len = out - page;
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
diff -ur linux-2.5.4/drivers/ide/ide-tape.c linux/drivers/ide/ide-tape.c
--- linux-2.5.4/drivers/ide/ide-tape.c	Fri Feb 15 06:33:15 2002
+++ linux/drivers/ide/ide-tape.c	Tue Feb 19 03:12:58 2002
@@ -6137,6 +6137,7 @@
 
 #endif
 
+int idetape_init (void);
 int idetape_reinit(ide_drive_t *drive);
 
 /*
@@ -6161,17 +6162,10 @@
 	pre_reset:		idetape_pre_reset,
 	capacity:		NULL,
 	proc:			idetape_proc,
+	driver_init:		idetape_init,
 	driver_reinit:		idetape_reinit,
 };
 
-int idetape_init (void);
-static ide_module_t idetape_module = {
-	IDE_DRIVER_MODULE,
-	idetape_init,
-	&idetape_driver,
-	NULL
-};
-
 /*
  *	Our character device supporting functions, passed to register_chrdev.
  */
@@ -6233,7 +6227,7 @@
 			printk (KERN_ERR "ide-tape: %s: Can't allocate a tape structure\n", drive->name);
 			continue;
 		}
-		if (ide_register_subdriver (drive, &idetape_driver, IDE_SUBDRIVER_VERSION)) {
+		if (ide_register_subdriver (drive, &idetape_driver)) {
 			printk (KERN_ERR "ide-tape: %s: Failed to register the driver with ide.c\n", drive->name);
 			kfree (tape);
 			continue;
@@ -6283,7 +6277,7 @@
 		if (drive != NULL && idetape_cleanup (drive))
 		printk (KERN_ERR "ide-tape: %s: cleanup_module() called while still busy\n", drive->name);
 	}
-	ide_unregister_module(&idetape_module);
+	ide_unregister_module(&idetape_driver);
 }
 
 /*
@@ -6304,7 +6298,7 @@
 			idetape_chrdevs[minor].drive = NULL;
 
 	if ((drive = ide_scan_devices (ide_tape, idetape_driver.name, NULL, failed++)) == NULL) {
-		ide_register_module (&idetape_module);
+		ide_register_module (&idetape_driver);
 		MOD_DEC_USE_COUNT;
 #if ONSTREAM_DEBUG
 		printk(KERN_INFO "ide-tape: MOD_DEC_USE_COUNT in idetape_init\n");
@@ -6338,7 +6332,7 @@
 			printk (KERN_ERR "ide-tape: %s: Can't allocate a tape structure\n", drive->name);
 			continue;
 		}
-		if (ide_register_subdriver (drive, &idetape_driver, IDE_SUBDRIVER_VERSION)) {
+		if (ide_register_subdriver (drive, &idetape_driver)) {
 			printk (KERN_ERR "ide-tape: %s: Failed to register the driver with ide.c\n", drive->name);
 			kfree (tape);
 			continue;
@@ -6363,7 +6357,7 @@
 		devfs_unregister_chrdev (IDETAPE_MAJOR, "ht");
 	} else
 		idetape_chrdev_present = 1;
-	ide_register_module (&idetape_module);
+	ide_register_module (&idetape_driver);
 	MOD_DEC_USE_COUNT;
 #if ONSTREAM_DEBUG
 	printk(KERN_INFO "ide-tape: MOD_DEC_USE_COUNT in idetape_init\n");
diff -ur linux-2.5.4/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.4/drivers/ide/ide.c	Mon Feb 18 01:48:31 2002
+++ linux/drivers/ide/ide.c	Tue Feb 19 02:57:06 2002
@@ -196,10 +196,9 @@
 int noautodma = 0;
 
 /*
- * ide_modules keeps track of the available IDE chipset/probe/driver modules.
+ * This is the anchor of the single linked list of ide device type drivers.
  */
-ide_module_t *ide_modules;
-ide_module_t *ide_probe;
+struct ide_driver_s *ide_drivers;
 
 /*
  * This is declared extern in ide.h, for access by other IDE modules:
@@ -1864,30 +1863,23 @@
 
 static void ide_probe_module (void)
 {
-	if (!ide_probe) {
-#if defined(CONFIG_KMOD) && defined(CONFIG_BLK_DEV_IDE_MODULE)
-		(void) request_module("ide-probe-mod");
-#endif /* (CONFIG_KMOD) && (CONFIG_BLK_DEV_IDE_MODULE) */
-	} else {
-		(void) ide_probe->init();
-	}
+	ideprobe_init();
 	revalidate_drives();
 }
 
 static void ide_driver_module (void)
 {
 	int index;
-	ide_module_t *module = ide_modules;
+	struct ide_driver_s *d;
 
 	for (index = 0; index < MAX_HWIFS; ++index)
 		if (ide_hwifs[index].present)
 			goto search;
 	ide_probe_module();
 search:
-	while (module) {
-		(void) module->init();
-		module = module->next;
-	}
+	for (d = ide_drivers; d != NULL; d = d->next)
+		d->driver_init();
+
 	revalidate_drives();
 }
 
@@ -3528,13 +3520,13 @@
 	return NULL;
 }
 
-int ide_register_subdriver (ide_drive_t *drive, ide_driver_t *driver, int version)
+int ide_register_subdriver (ide_drive_t *drive, ide_driver_t *driver)
 {
 	unsigned long flags;
 
 	save_flags(flags);		/* all CPUs */
 	cli();				/* all CPUs */
-	if (version != IDE_SUBDRIVER_VERSION || !drive->present || drive->driver != NULL || drive->busy || drive->usage) {
+	if (!drive->present || drive->driver != NULL || drive->busy || drive->usage) {
 		restore_flags(flags);	/* all CPUs */
 		return 1;
 	}
@@ -3618,26 +3610,26 @@
 	return 0;
 }
 
-int ide_register_module (ide_module_t *module)
+int ide_register_module (struct ide_driver_s *d)
 {
-	ide_module_t *p = ide_modules;
+	struct ide_driver_s *p = ide_drivers;
 
 	while (p) {
-		if (p == module)
+		if (p == d)
 			return 1;
 		p = p->next;
 	}
-	module->next = ide_modules;
-	ide_modules = module;
+	d->next = ide_drivers;
+	ide_drivers = d;
 	revalidate_drives();
 	return 0;
 }
 
-void ide_unregister_module (ide_module_t *module)
+void ide_unregister_module (struct ide_driver_s *d)
 {
-	ide_module_t **p;
+	struct ide_driver_s **p;
 
-	for (p = &ide_modules; (*p) && (*p) != module; p = &((*p)->next));
+	for (p = &ide_drivers; (*p) && (*p) != d; p = &((*p)->next));
 	if (*p)
 		*p = (*p)->next;
 }
@@ -3662,7 +3654,6 @@
 devfs_handle_t ide_devfs_handle;
 
 EXPORT_SYMBOL(ide_lock);
-EXPORT_SYMBOL(ide_probe);
 EXPORT_SYMBOL(drive_is_flashcard);
 EXPORT_SYMBOL(ide_timer_expiry);
 EXPORT_SYMBOL(ide_intr);
diff -ur linux-2.5.4/drivers/scsi/ide-scsi.c linux/drivers/scsi/ide-scsi.c
--- linux-2.5.4/drivers/scsi/ide-scsi.c	Fri Feb 15 06:43:18 2002
+++ linux/drivers/scsi/ide-scsi.c	Tue Feb 19 03:16:52 2002
@@ -535,6 +535,7 @@
 	return 0;
 }
 
+int idescsi_init(void);
 int idescsi_reinit(ide_drive_t *drive);
 
 /*
@@ -560,17 +561,10 @@
 	capacity:		NULL,
 	special:		NULL,
 	proc:			NULL,
+	driver_init:		idescsi_init,
 	driver_reinit:		idescsi_reinit,
 };
 
-int idescsi_init (void);
-static ide_module_t idescsi_module = {
-	IDE_DRIVER_MODULE,
-	idescsi_init,
-	&idescsi_driver,
-	NULL
-};
-
 int idescsi_reinit (ide_drive_t *drive)
 {
 #if 0
@@ -592,7 +586,7 @@
 				printk (KERN_ERR "ide-scsi: %s: Can't allocate a scsi structure\n", drive->name);
 				continue;
 			}
-			if (ide_register_subdriver (drive, &idescsi_driver, IDE_SUBDRIVER_VERSION)) {
+			if (ide_register_subdriver (drive, &idescsi_driver)) {
 				printk (KERN_ERR "ide-scsi: %s: Failed to register the driver with ide.c\n", drive->name);
 				kfree (scsi);
 				continue;
@@ -632,7 +626,7 @@
 				printk (KERN_ERR "ide-scsi: %s: Can't allocate a scsi structure\n", drive->name);
 				continue;
 			}
-			if (ide_register_subdriver (drive, &idescsi_driver, IDE_SUBDRIVER_VERSION)) {
+			if (ide_register_subdriver (drive, &idescsi_driver)) {
 				printk (KERN_ERR "ide-scsi: %s: Failed to register the driver with ide.c\n", drive->name);
 				kfree (scsi);
 				continue;
@@ -642,7 +636,7 @@
 			failed--;
 		}
 	}
-	ide_register_module(&idescsi_module);
+	ide_register_module(&idescsi_driver);
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
@@ -912,7 +906,7 @@
 				failed++;
 			}
 	}
-	ide_unregister_module(&idescsi_module);
+	ide_unregister_module(&idescsi_driver);
 }
 
 module_init(init_idescsi_module);
diff -ur linux-2.5.4/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.4/include/linux/ide.h	Mon Feb 18 02:04:57 2002
+++ linux/include/linux/ide.h	Tue Feb 19 03:02:28 2002
@@ -99,8 +99,8 @@
 #undef REALLY_FAST_IO
 #endif
 
-#define HWIF(drive)		((ide_hwif_t *)((drive)->hwif))
-#define HWGROUP(drive)		((ide_hwgroup_t *)(HWIF(drive)->hwgroup))
+#define HWIF(drive)		((drive)->hwif)
+#define HWGROUP(drive)		(HWIF(drive)->hwgroup)
 
 /*
  * Definitions for accessing IDE controller registers
@@ -371,7 +371,7 @@
 
 typedef struct ide_drive_s {
 	request_queue_t		 queue;	/* request queue */
-	struct ide_drive_s 	*next;	/* circular list of hwgroup drives */
+	struct ide_drive_s	*next;	/* circular list of hwgroup drives */
 	unsigned long sleep;		/* sleep until this time */
 	unsigned long service_start;	/* time we started last request */
 	unsigned long service_time;	/* service time of last request */
@@ -531,7 +531,7 @@
 
 typedef struct hwif_s {
 	struct hwif_s	*next;		/* for linked-list in ide_hwgroup_t */
-	void		*hwgroup;	/* actually (ide_hwgroup_t *) */
+	struct hwgroup_s *hwgroup;	/* actually (ide_hwgroup_t *) */
 	ide_ioreg_t	io_ports[IDE_NR_PORTS];	/* task file registers */
 	hw_regs_t	hw;		/* Hardware info */
 	ide_drive_t	drives[MAX_DRIVES];	/* drive info */
@@ -702,10 +702,6 @@
 /*
  * Subdrivers support.
  */
-#define IDE_SUBDRIVER_VERSION	1
-
-typedef void		(ide_setting_proc)(ide_drive_t *);
-
 typedef struct ide_driver_s {
 	const char			*name;
 	byte				media;
@@ -726,25 +722,15 @@
 	unsigned long (*capacity)(ide_drive_t *);
 	ide_startstop_t	(*special)(ide_drive_t *);
 	ide_proc_entry_t		*proc;
+	int (*driver_init)(void);
 	int (*driver_reinit)(ide_drive_t *);
-} ide_driver_t;
-
-#define DRIVER(drive)		((ide_driver_t *)((drive)->driver))
-
-/*
- * IDE modules.
- */
-#define IDE_CHIPSET_MODULE		0	/* not supported yet */
-#define IDE_PROBE_MODULE		1
-#define IDE_DRIVER_MODULE		2
 
+	/* FIXME: Single linked list of drivers for iteration.
+	 */
+	struct ide_driver_s *next;
+} ide_driver_t;
 
-typedef struct ide_module_s {
-	int type;
-	int (*init)(void);
-	void *info;
-	struct ide_module_s *next;
-} ide_module_t;
+#define DRIVER(drive)		((drive)->driver)
 
 /*
  * ide_hwifs[] is the master data structure used to keep track
@@ -755,9 +741,8 @@
  *
  */
 #ifndef _IDE_C
-extern	ide_hwif_t	ide_hwifs[];		/* master data repository */
-extern	ide_module_t	*ide_modules;
-extern	ide_module_t	*ide_probe;
+extern struct hwif_s ide_hwifs[];		/* master data repository */
+extern struct ide_driver_s *ide_drivers;
 #endif
 extern int noautodma;
 
@@ -1060,9 +1045,11 @@
 int ide_reinit_drive (ide_drive_t *drive);
 
 #ifdef _IDE_C
-#ifdef CONFIG_BLK_DEV_IDE
-int ideprobe_init (void);
-#endif /* CONFIG_BLK_DEV_IDE */
+# ifdef CONFIG_BLK_DEV_IDE
+/* Probe for devices attached to the systems host controllers.
+ */
+extern int ideprobe_init (void);
+# endif
 #ifdef CONFIG_BLK_DEV_IDEDISK
 int idedisk_reinit (ide_drive_t *drive);
 int idedisk_init (void);
@@ -1085,12 +1072,12 @@
 #endif /* CONFIG_BLK_DEV_IDESCSI */
 #endif /* _IDE_C */
 
-int ide_register_module (ide_module_t *module);
-void ide_unregister_module (ide_module_t *module);
+extern int ide_register_module (struct ide_driver_s *d);
+extern void ide_unregister_module (struct ide_driver_s *d);
 ide_drive_t *ide_scan_devices (byte media, const char *name, ide_driver_t *driver, int n);
-int ide_register_subdriver (ide_drive_t *drive, ide_driver_t *driver, int version);
-int ide_unregister_subdriver (ide_drive_t *drive);
-int ide_replace_subdriver(ide_drive_t *drive, const char *driver);
+extern int ide_register_subdriver(ide_drive_t *drive, ide_driver_t *driver);
+extern int ide_unregister_subdriver(ide_drive_t *drive);
+extern int ide_replace_subdriver(ide_drive_t *drive, const char *driver);
 
 #ifdef CONFIG_BLK_DEV_IDEPCI
 #define ON_BOARD		1

--------------010506060108010003080708--

