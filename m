Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291750AbSBTKuR>; Wed, 20 Feb 2002 05:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291745AbSBTKuA>; Wed, 20 Feb 2002 05:50:00 -0500
Received: from [195.63.194.11] ([195.63.194.11]:56326 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291746AbSBTKtq>; Wed, 20 Feb 2002 05:49:46 -0500
Message-ID: <3C737F29.7070105@evision-ventures.com>
Date: Wed, 20 Feb 2002 11:49:13 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.5-pre1 IDE cleanup 10
In-Reply-To: <Pine.LNX.4.33.0202131434350.21395-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------040004050500050908030805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040004050500050908030805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello!

This is finishing the cleanup parts already started in ide-clean-9.

It kills the ide_register_module() and ide_unregister_module() as well
as associated idiosyncracies alltogether. It turns out
that this patch is actually fixing a bug which was present in the
driver before: the sub-module initialization functions where called
at least twice - which is an abundance.

Tough there is a bit of global namespace pollution caused by this
patch - but I'm aware of it and will fix it just a bit later.
(The terminology used inside the IDE code is anyway nothing common
else in the linux universum...)

The next targets will be:

1. Code obfuscation by "wrappers" around generic BIO level functions.

2. ide_hwgroup_t - which is only used to serialize multiple
discs on the same interrupt and similar. This is however a tough one.

3. There is a plenty of code waste in the chipset drivers, where there
is baroque informative code for the proc file system for static stuff, 
which in fact belongs just to syslog(). In fact the default RedHat 
distribution kernel is killing this gratitious abuse of the /proc
concept since a long long time...


I'm still awaiting the day of /proc/GPL, where GPL contains the
full text of it...

--------------040004050500050908030805
Content-Type: text/plain;
 name="ide-clean-10.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-10.diff"

diff -ur linux-2.5.4/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.4/drivers/ide/ide-cd.c	Tue Feb 19 03:11:03 2002
+++ linux/drivers/ide/ide-cd.c	Wed Feb 20 02:35:14 2002
@@ -2906,7 +2906,6 @@
 	return 0;
 }
 
-int ide_cdrom_init(void);
 int ide_cdrom_reinit (ide_drive_t *drive);
 
 static ide_driver_t ide_cdrom_driver = {
@@ -2929,7 +2928,6 @@
 	capacity:		ide_cdrom_capacity,
 	special:		NULL,
 	proc:			NULL,
-	driver_init:		ide_cdrom_init,
 	driver_reinit:		ide_cdrom_reinit,
 };
 
@@ -2967,7 +2965,7 @@
 	DRIVER(drive)->busy--;
 	failed--;
 
-	ide_register_module(&ide_cdrom_driver);
+	revalidate_drives();
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
@@ -2982,7 +2980,6 @@
 			printk ("%s: cleanup_module() called while still busy\n", drive->name);
 			failed++;
 		}
-	ide_unregister_module (&ide_cdrom_driver);
 }
  
 int ide_cdrom_init(void)
@@ -3026,7 +3023,7 @@
 		DRIVER(drive)->busy--;
 		failed--;
 	}
-	ide_register_module(&ide_cdrom_driver);
+	revalidate_drives();
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
diff -ur linux-2.5.4/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.4/drivers/ide/ide-disk.c	Tue Feb 19 03:07:32 2002
+++ linux/drivers/ide/ide-disk.c	Wed Feb 20 02:32:25 2002
@@ -1030,7 +1030,6 @@
 	return ide_unregister_subdriver(drive);
 }
 
-int idedisk_init (void);
 int idedisk_reinit(ide_drive_t *drive);
 
 /*
@@ -1056,7 +1055,6 @@
 	capacity:		idedisk_capacity,
 	special:		idedisk_special,
 	proc:			idedisk_proc,
-	driver_init:		idedisk_init,
 	driver_reinit:		idedisk_reinit,
 };
 
@@ -1083,7 +1081,7 @@
 	DRIVER(drive)->busy--;
 	failed--;
 
-	ide_register_module(&idedisk_driver);
+	revalidate_drives();
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
@@ -1105,7 +1103,6 @@
 			ide_remove_proc_entries(drive->proc, idedisk_proc);
 #endif
 	}
-	ide_unregister_module(&idedisk_driver);
 }
 
 int idedisk_init (void)
@@ -1130,7 +1127,7 @@
 		DRIVER(drive)->busy--;
 		failed--;
 	}
-	ide_register_module(&idedisk_driver);
+	revalidate_drives();
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
diff -ur linux-2.5.4/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux-2.5.4/drivers/ide/ide-floppy.c	Tue Feb 19 03:14:55 2002
+++ linux/drivers/ide/ide-floppy.c	Wed Feb 20 02:34:00 2002
@@ -2046,7 +2046,6 @@
 
 #endif	/* CONFIG_PROC_FS */
 
-int idefloppy_init(void);
 int idefloppy_reinit(ide_drive_t *drive);
 
 /*
@@ -2072,7 +2071,6 @@
 	capacity:		idefloppy_capacity,
 	special:		NULL,
 	proc:			idefloppy_proc,
-	driver_init:		idefloppy_init,
 	driver_reinit:		idefloppy_reinit,
 };
 
@@ -2105,7 +2103,7 @@
 		DRIVER(drive)->busy--;
 		failed--;
 	}
-	ide_register_module(&idefloppy_driver);
+	revalidate_drives();
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
@@ -2130,7 +2128,6 @@
 			ide_remove_proc_entries(drive->proc, idefloppy_proc);
 #endif
 	}
-	ide_unregister_module(&idefloppy_driver);
 }
 
 /*
@@ -2167,7 +2164,7 @@
 		DRIVER(drive)->busy--;
 		failed--;
 	}
-	ide_register_module(&idefloppy_driver);
+	revalidate_drives();
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
diff -ur linux-2.5.4/drivers/ide/ide-proc.c linux/drivers/ide/ide-proc.c
--- linux-2.5.4/drivers/ide/ide-proc.c	Tue Feb 19 02:59:27 2002
+++ linux/drivers/ide/ide-proc.c	Wed Feb 20 02:34:43 2002
@@ -373,20 +373,6 @@
 	return digit;
 }
 
-static int proc_ide_read_drivers
-	(char *page, char **start, off_t off, int count, int *eof, void *data)
-{
-	char		*out = page;
-	int		len;
-	struct ide_driver_s * driver;
-
-	for (driver = ide_drivers; driver; driver = driver->next) {
-		out += sprintf(out, "%s\n",driver->name);
-	}
-	len = out - page;
-	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
-}
-
 static int proc_ide_read_imodel
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
@@ -852,9 +838,6 @@
 
 	create_proc_ide_interfaces();
 
-	create_proc_read_entry("drivers", 0, proc_ide_root,
-				proc_ide_read_drivers, NULL);
-
 #ifdef CONFIG_BLK_DEV_AEC62XX
 	if ((aec62xx_display_info) && (aec62xx_proc))
 		create_proc_info_entry("aec62xx", 0, proc_ide_root, aec62xx_display_info);
diff -ur linux-2.5.4/drivers/ide/ide-tape.c linux/drivers/ide/ide-tape.c
--- linux-2.5.4/drivers/ide/ide-tape.c	Tue Feb 19 03:12:58 2002
+++ linux/drivers/ide/ide-tape.c	Wed Feb 20 02:33:24 2002
@@ -6137,7 +6137,6 @@
 
 #endif
 
-int idetape_init (void);
 int idetape_reinit(ide_drive_t *drive);
 
 /*
@@ -6162,7 +6161,6 @@
 	pre_reset:		idetape_pre_reset,
 	capacity:		NULL,
 	proc:			idetape_proc,
-	driver_init:		idetape_init,
 	driver_reinit:		idetape_reinit,
 };
 
@@ -6193,7 +6191,7 @@
 			idetape_chrdevs[minor].drive = NULL;
 
 	if ((drive = ide_scan_devices (ide_tape, idetape_driver.name, NULL, failed++)) == NULL) {
-		ide_register_module (&idetape_module);
+		revalidate_drives();
 		MOD_DEC_USE_COUNT;
 #if ONSTREAM_DEBUG
 		printk(KERN_INFO "ide-tape: MOD_DEC_USE_COUNT in idetape_init\n");
@@ -6252,7 +6250,7 @@
 		devfs_unregister_chrdev (IDETAPE_MAJOR, "ht");
 	} else
 		idetape_chrdev_present = 1;
-	ide_register_module (&idetape_module);
+	revalidate_drives();
 	MOD_DEC_USE_COUNT;
 #if ONSTREAM_DEBUG
 	printk(KERN_INFO "ide-tape: MOD_DEC_USE_COUNT in idetape_init\n");
@@ -6277,7 +6275,6 @@
 		if (drive != NULL && idetape_cleanup (drive))
 		printk (KERN_ERR "ide-tape: %s: cleanup_module() called while still busy\n", drive->name);
 	}
-	ide_unregister_module(&idetape_driver);
 }
 
 /*
@@ -6298,7 +6295,7 @@
 			idetape_chrdevs[minor].drive = NULL;
 
 	if ((drive = ide_scan_devices (ide_tape, idetape_driver.name, NULL, failed++)) == NULL) {
-		ide_register_module (&idetape_driver);
+		revalidate_drives();
 		MOD_DEC_USE_COUNT;
 #if ONSTREAM_DEBUG
 		printk(KERN_INFO "ide-tape: MOD_DEC_USE_COUNT in idetape_init\n");
@@ -6357,7 +6354,7 @@
 		devfs_unregister_chrdev (IDETAPE_MAJOR, "ht");
 	} else
 		idetape_chrdev_present = 1;
-	ide_register_module (&idetape_driver);
+	revalidate_drives();
 	MOD_DEC_USE_COUNT;
 #if ONSTREAM_DEBUG
 	printk(KERN_INFO "ide-tape: MOD_DEC_USE_COUNT in idetape_init\n");
diff -ur linux-2.5.4/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.4/drivers/ide/ide.c	Tue Feb 19 02:57:06 2002
+++ linux/drivers/ide/ide.c	Wed Feb 20 02:38:30 2002
@@ -196,11 +196,6 @@
 int noautodma = 0;
 
 /*
- * This is the anchor of the single linked list of ide device type drivers.
- */
-struct ide_driver_s *ide_drivers;
-
-/*
  * This is declared extern in ide.h, for access by other IDE modules:
  */
 ide_hwif_t	ide_hwifs[MAX_HWIFS];	/* master data repository */
@@ -1842,7 +1837,11 @@
 	return res;
 }
 
-static void revalidate_drives (void)
+/*
+ * Look again for all drives in the system on all interfaces.  This is used
+ * after a new driver cathegory has been loaded as module.
+ */
+void revalidate_drives (void)
 {
 	ide_hwif_t *hwif;
 	ide_drive_t *drive;
@@ -1870,15 +1869,12 @@
 static void ide_driver_module (void)
 {
 	int index;
-	struct ide_driver_s *d;
 
 	for (index = 0; index < MAX_HWIFS; ++index)
 		if (ide_hwifs[index].present)
 			goto search;
 	ide_probe_module();
 search:
-	for (d = ide_drivers; d != NULL; d = d->next)
-		d->driver_init();
 
 	revalidate_drives();
 }
@@ -3610,30 +3606,6 @@
 	return 0;
 }
 
-int ide_register_module (struct ide_driver_s *d)
-{
-	struct ide_driver_s *p = ide_drivers;
-
-	while (p) {
-		if (p == d)
-			return 1;
-		p = p->next;
-	}
-	d->next = ide_drivers;
-	ide_drivers = d;
-	revalidate_drives();
-	return 0;
-}
-
-void ide_unregister_module (struct ide_driver_s *d)
-{
-	struct ide_driver_s **p;
-
-	for (p = &ide_drivers; (*p) && (*p) != d; p = &((*p)->next));
-	if (*p)
-		*p = (*p)->next;
-}
-
 struct block_device_operations ide_fops[] = {{
 	owner:			THIS_MODULE,
 	open:			ide_open,
@@ -3644,9 +3616,8 @@
 }};
 
 EXPORT_SYMBOL(ide_hwifs);
-EXPORT_SYMBOL(ide_register_module);
-EXPORT_SYMBOL(ide_unregister_module);
 EXPORT_SYMBOL(ide_spin_wait_hwgroup);
+EXPORT_SYMBOL(revalidate_drives);
 
 /*
  * Probe module
diff -ur linux-2.5.4/drivers/scsi/ide-scsi.c linux/drivers/scsi/ide-scsi.c
--- linux-2.5.4/drivers/scsi/ide-scsi.c	Tue Feb 19 03:16:52 2002
+++ linux/drivers/scsi/ide-scsi.c	Wed Feb 20 02:34:31 2002
@@ -535,7 +535,6 @@
 	return 0;
 }
 
-int idescsi_init(void);
 int idescsi_reinit(ide_drive_t *drive);
 
 /*
@@ -561,7 +560,6 @@
 	capacity:		NULL,
 	special:		NULL,
 	proc:			NULL,
-	driver_init:		idescsi_init,
 	driver_reinit:		idescsi_reinit,
 };
 
@@ -596,7 +594,7 @@
 			failed--;
 		}
 	}
-	ide_register_module(&idescsi_module);
+	revalidate_drives();
 	MOD_DEC_USE_COUNT;
 #endif
 	return 0;
@@ -636,7 +634,7 @@
 			failed--;
 		}
 	}
-	ide_register_module(&idescsi_driver);
+	revalidate_drives();
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
@@ -906,7 +904,6 @@
 				failed++;
 			}
 	}
-	ide_unregister_module(&idescsi_driver);
 }
 
 module_init(init_idescsi_module);
diff -ur linux-2.5.4/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.4/include/linux/ide.h	Tue Feb 19 03:02:28 2002
+++ linux/include/linux/ide.h	Wed Feb 20 02:39:09 2002
@@ -722,12 +722,7 @@
 	unsigned long (*capacity)(ide_drive_t *);
 	ide_startstop_t	(*special)(ide_drive_t *);
 	ide_proc_entry_t		*proc;
-	int (*driver_init)(void);
 	int (*driver_reinit)(ide_drive_t *);
-
-	/* FIXME: Single linked list of drivers for iteration.
-	 */
-	struct ide_driver_s *next;
 } ide_driver_t;
 
 #define DRIVER(drive)		((drive)->driver)
@@ -742,7 +737,6 @@
  */
 #ifndef _IDE_C
 extern struct hwif_s ide_hwifs[];		/* master data repository */
-extern struct ide_driver_s *ide_drivers;
 #endif
 extern int noautodma;
 
@@ -1072,8 +1066,6 @@
 #endif /* CONFIG_BLK_DEV_IDESCSI */
 #endif /* _IDE_C */
 
-extern int ide_register_module (struct ide_driver_s *d);
-extern void ide_unregister_module (struct ide_driver_s *d);
 ide_drive_t *ide_scan_devices (byte media, const char *name, ide_driver_t *driver, int n);
 extern int ide_register_subdriver(ide_drive_t *drive, ide_driver_t *driver);
 extern int ide_unregister_subdriver(ide_drive_t *drive);
@@ -1108,5 +1100,6 @@
 extern spinlock_t ide_lock;
 
 extern int drive_is_ready(ide_drive_t *drive);
+extern void revalidate_drives(void);
 
 #endif /* _IDE_H */

--------------040004050500050908030805--

