Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290782AbSBUJkX>; Thu, 21 Feb 2002 04:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290881AbSBUJkQ>; Thu, 21 Feb 2002 04:40:16 -0500
Received: from [195.63.194.11] ([195.63.194.11]:53263 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S290782AbSBUJjz>; Thu, 21 Feb 2002 04:39:55 -0500
Message-ID: <3C74C03C.4060403@evision-ventures.com>
Date: Thu, 21 Feb 2002 10:39:08 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.5 IDE cleanup 11
In-Reply-To: <Pine.LNX.4.33.0202131434350.21395-100000@home.transmeta.com> <3C737F29.7070105@evision-ventures.com>
Content-Type: multipart/mixed;
 boundary="------------000507070909030102060301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000507070909030102060301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello!

This is the next round of IDE driver cleanups.
Please note tat this applies on top of ide-clean-10.diff.
ide-clean-10.diff, which was done agains 2.5.5-pre1 still applies
without glitch to 2.5.5 final. (For the sake of completeness I'm
attaching it as well.)

The patch does the following:

1. Start of driver tree usage upon suggestion from Pavel Machek.
    This still will needs a lot of further work in the future, but
    the current code doesn't hurt anything and allowa Pavel to work
    further from the base line. In esp. natively implemented
     suspend to file requires this - which I would love to see comming
    in,since I'm quite frequently using a notebook myself.

2. Kill the _IDE_C macro, which was playing games on entierly
    unnecessary declarations inside of header files in esp ide_modes.h

3. Replace the functionally totally equal system_bus_block() and
    ide_system_bus_speed() functions with one simple global
    variable: system_bus_speed. This saves quite a significatn amount of
    code. Unfortunately this is the part, which is makeing this
    patch to appear bigger then it really is...

4. Use ide_devalidate_drive() directly instead of idedisk_revalidate().

5. Kill conditional CONFIG_KMOD as well as some other minor tweaks.

Well this isn't that much in terms of functionality,  but it took me
quite q bit of time to catch up on the patch-2.5.5.gz ;-)

Regards.

--------------000507070909030102060301
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

--------------000507070909030102060301
Content-Type: text/plain;
 name="ide-clean-11.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-11.diff"

diff -ur linux-2.5.5/drivers/ide/aec62xx.c linux/drivers/ide/aec62xx.c
--- linux-2.5.5/drivers/ide/aec62xx.c	Wed Feb 20 03:11:00 2002
+++ linux/drivers/ide/aec62xx.c	Thu Feb 21 03:05:15 2002
@@ -203,22 +203,18 @@
 
 static byte pci_bus_clock_list (byte speed, struct chipset_bus_clock_list_entry * chipset_table)
 {
-	int bus_speed = system_bus_clock();
-
 	for ( ; chipset_table->xfer_speed ; chipset_table++)
 		if (chipset_table->xfer_speed == speed) {
-			return ((byte) ((bus_speed <= 33) ? chipset_table->chipset_settings_33 : chipset_table->chipset_settings_34));
+			return ((byte) ((system_bus_speed <= 33) ? chipset_table->chipset_settings_33 : chipset_table->chipset_settings_34));
 		}
 	return 0x00;
 }
 
 static byte pci_bus_clock_list_ultra (byte speed, struct chipset_bus_clock_list_entry * chipset_table)
 {
-	int bus_speed = system_bus_clock();
-
 	for ( ; chipset_table->xfer_speed ; chipset_table++)
 		if (chipset_table->xfer_speed == speed) {
-			return ((byte) ((bus_speed <= 33) ? chipset_table->ultra_settings_33 : chipset_table->ultra_settings_34));
+			return ((byte) ((system_bus_speed <= 33) ? chipset_table->ultra_settings_33 : chipset_table->ultra_settings_34));
 		}
 	return 0x00;
 }
diff -ur linux-2.5.5/drivers/ide/ali14xx.c linux/drivers/ide/ali14xx.c
--- linux-2.5.5/drivers/ide/ali14xx.c	Wed Feb 20 03:11:02 2002
+++ linux/drivers/ide/ali14xx.c	Thu Feb 21 03:08:53 2002
@@ -119,15 +119,14 @@
 	byte param1, param2, param3, param4;
 	unsigned long flags;
 	ide_pio_data_t d;
-	int bus_speed = system_bus_clock();
 
 	pio = ide_get_best_pio_mode(drive, pio, ALI_MAX_PIO, &d);
 
 	/* calculate timing, according to PIO mode */
 	time1 = d.cycle_time;
 	time2 = ide_pio_timings[pio].active_time;
-	param3 = param1 = (time2 * bus_speed + 999) / 1000;
-	param4 = param2 = (time1 * bus_speed + 999) / 1000 - param1;
+	param3 = param1 = (time2 * system_bus_speed + 999) / 1000;
+	param4 = param2 = (time1 * system_bus_speed + 999) / 1000 - param1;
 	if (pio < 3) {
 		param3 += 8;
 		param4 += 8;
diff -ur linux-2.5.5/drivers/ide/alim15x3.c linux/drivers/ide/alim15x3.c
--- linux-2.5.5/drivers/ide/alim15x3.c	Wed Feb 20 03:10:55 2002
+++ linux/drivers/ide/alim15x3.c	Thu Feb 21 03:01:29 2002
@@ -247,7 +247,6 @@
 	int s_time, a_time, c_time;
 	byte s_clc, a_clc, r_clc;
 	unsigned long flags;
-	int bus_speed = system_bus_clock();
 	int port = hwif->index ? 0x5c : 0x58;
 	int portFIFO = hwif->channel ? 0x55 : 0x54;
 	byte cd_dma_fifo = 0;
@@ -255,18 +254,18 @@
 	pio = ide_get_best_pio_mode(drive, pio, 5, &d);
 	s_time = ide_pio_timings[pio].setup_time;
 	a_time = ide_pio_timings[pio].active_time;
-	if ((s_clc = (s_time * bus_speed + 999) / 1000) >= 8)
+	if ((s_clc = (s_time * system_bus_speed + 999) / 1000) >= 8)
 		s_clc = 0;
-	if ((a_clc = (a_time * bus_speed + 999) / 1000) >= 8)
+	if ((a_clc = (a_time * system_bus_speed + 999) / 1000) >= 8)
 		a_clc = 0;
 	c_time = ide_pio_timings[pio].cycle_time;
 
 #if 0
-	if ((r_clc = ((c_time - s_time - a_time) * bus_speed + 999) / 1000) >= 16)
+	if ((r_clc = ((c_time - s_time - a_time) * system_bus_speed + 999) / 1000) >= 16)
 		r_clc = 0;
 #endif
 
-	if (!(r_clc = (c_time * bus_speed + 999) / 1000 - a_clc - s_clc)) {
+	if (!(r_clc = (c_time * system_bus_speed + 999) / 1000 - a_clc - s_clc)) {
 		r_clc = 1;
 	} else {
 		if (r_clc >= 16)
diff -ur linux-2.5.5/drivers/ide/cmd640.c linux/drivers/ide/cmd640.c
--- linux-2.5.5/drivers/ide/cmd640.c	Wed Feb 20 03:11:01 2002
+++ linux/drivers/ide/cmd640.c	Thu Feb 21 03:06:52 2002
@@ -23,7 +23,7 @@
  *
  *  A.Hartgers@stud.tue.nl, JZDQC@CUNYVM.CUNY.edu, abramov@cecmow.enet.dec.com,
  *  bardj@utopia.ppp.sn.no, bart@gaga.tue.nl, bbol001@cs.auckland.ac.nz,
- *  chrisc@dbass.demon.co.uk, dalecki@namu26.Num.Math.Uni-Goettingen.de,
+ *  chrisc@dbass.demon.co.uk, dalecki@evision-ventures.com,
  *  derekn@vw.ece.cmu.edu, florian@btp2x3.phy.uni-bayreuth.de,
  *  flynn@dei.unipd.it, gadio@netvision.net.il, godzilla@futuris.net,
  *  j@pobox.com, jkemp1@mises.uni-paderborn.de, jtoppe@hiwaay.net,
@@ -596,14 +596,13 @@
 {
 	int setup_time, active_time, recovery_time, clock_time;
 	byte setup_count, active_count, recovery_count, recovery_count2, cycle_count;
-	int bus_speed = system_bus_clock();
 
 	if (pio_mode > 5)
 		pio_mode = 5;
 	setup_time  = ide_pio_timings[pio_mode].setup_time;
 	active_time = ide_pio_timings[pio_mode].active_time;
 	recovery_time = cycle_time - (setup_time + active_time);
-	clock_time = 1000 / bus_speed;
+	clock_time = 1000 / system_bus_speed;
 	cycle_count = (cycle_time + clock_time - 1) / clock_time;
 
 	setup_count = (setup_time + clock_time - 1) / clock_time;
diff -ur linux-2.5.5/drivers/ide/cmd64x.c linux/drivers/ide/cmd64x.c
--- linux-2.5.5/drivers/ide/cmd64x.c	Wed Feb 20 03:11:00 2002
+++ linux/drivers/ide/cmd64x.c	Thu Feb 21 03:05:52 2002
@@ -283,8 +283,6 @@
 	int setup_time, active_time, recovery_time, clock_time, pio_mode, cycle_time;
 	byte recovery_count2, cycle_count;
 	int setup_count, active_count, recovery_count;
-	int bus_speed = system_bus_clock();
-	/*byte b;*/
 	ide_pio_data_t  d;
 
 	switch (mode_wanted) {
@@ -309,7 +307,7 @@
 	setup_time  = ide_pio_timings[pio_mode].setup_time;
 	active_time = ide_pio_timings[pio_mode].active_time;
 	recovery_time = cycle_time - (setup_time + active_time);
-	clock_time = 1000 / bus_speed;
+	clock_time = 1000 / system_bus_speed;
 	cycle_count = (cycle_time + clock_time - 1) / clock_time;
 
 	setup_count = (setup_time + clock_time - 1) / clock_time;
diff -ur linux-2.5.5/drivers/ide/cy82c693.c linux/drivers/ide/cy82c693.c
--- linux-2.5.5/drivers/ide/cy82c693.c	Wed Feb 20 03:10:58 2002
+++ linux/drivers/ide/cy82c693.c	Thu Feb 21 03:03:52 2002
@@ -141,7 +141,6 @@
 static void compute_clocks (byte pio, pio_clocks_t *p_pclk)
 {
 	int clk1, clk2;
-	int bus_speed = system_bus_clock();	/* get speed of PCI bus */
 
 	/* we don't check against CY82C693's min and max speed,
 	 * so you can play with the idebus=xx parameter
@@ -151,17 +150,17 @@
 		pio = CY82C693_MAX_PIO;
 
 	/* let's calc the address setup time clocks */
-	p_pclk->address_time = (byte)calc_clk(ide_pio_timings[pio].setup_time, bus_speed);
+	p_pclk->address_time = (byte)calc_clk(ide_pio_timings[pio].setup_time, system_bus_speed);
 
 	/* let's calc the active and recovery time clocks */
-	clk1 = calc_clk(ide_pio_timings[pio].active_time, bus_speed);
+	clk1 = calc_clk(ide_pio_timings[pio].active_time, system_bus_speed);
 
 	/* calc recovery timing */
 	clk2 =	ide_pio_timings[pio].cycle_time -
 		ide_pio_timings[pio].active_time -
 		ide_pio_timings[pio].setup_time;
 
-	clk2 = calc_clk(clk2, bus_speed);
+	clk2 = calc_clk(clk2, system_bus_speed);
 
 	clk1 = (clk1<<4)|clk2;	/* combine active and recovery clocks */
 
diff -ur linux-2.5.5/drivers/ide/ht6560b.c linux/drivers/ide/ht6560b.c
--- linux-2.5.5/drivers/ide/ht6560b.c	Wed Feb 20 03:10:57 2002
+++ linux/drivers/ide/ht6560b.c	Thu Feb 21 03:03:11 2002
@@ -207,7 +207,6 @@
 	int active_time, recovery_time;
 	int active_cycles, recovery_cycles;
 	ide_pio_data_t d;
-	int bus_speed = system_bus_clock();
 	
         if (pio) {
 		pio = ide_get_best_pio_mode(drive, pio, 5, &d);
@@ -224,8 +223,8 @@
 		/*
 		 *  Cycle times should be Vesa bus cycles
 		 */
-		active_cycles   = (active_time   * bus_speed + 999) / 1000;
-		recovery_cycles = (recovery_time * bus_speed + 999) / 1000;
+		active_cycles   = (active_time   * system_bus_speed + 999) / 1000;
+		recovery_cycles = (recovery_time * system_bus_speed + 999) / 1000;
 		/*
 		 *  Upper and lower limits
 		 */
diff -ur linux-2.5.5/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.5/drivers/ide/ide-disk.c	Thu Feb 21 03:58:10 2002
+++ linux/drivers/ide/ide-disk.c	Thu Feb 21 03:32:18 2002
@@ -378,11 +378,6 @@
 	return drive->removable;	/* if removable, always assume it was changed */
 }
 
-static void idedisk_revalidate (ide_drive_t *drive)
-{
-	ide_revalidate_drive(drive);
-}
-
 /*
  * Queries for true maximum capacity of the drive.
  * Returns maximum LBA address (> 0) of the drive, 0 if failed.
@@ -915,13 +910,22 @@
 	ide_add_setting(drive,	"max_failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->max_failures,		NULL);
 }
 
-static void idedisk_setup (ide_drive_t *drive)
+/* This is just a hook for the overall driver tree.
+ *
+ * FIXME: This is soon goig to replace the custom linked list games played up
+ * to great extend between the different components of the IDE drivers.
+ */
+
+static struct device_driver idedisk_devdrv = {};
+
+static void idedisk_setup(ide_drive_t *drive)
 {
 	int i;
-	
+
 	struct hd_driveid *id = drive->id;
 	unsigned long capacity;
-	
+	int drvid = -1;
+
 	idedisk_add_settings(drive);
 
 	if (id == NULL)
@@ -933,7 +937,7 @@
 	 */
 	if (drive->removable && !drive_is_flashcard(drive)) {
 		/*
-		 * Removable disks (eg. SYQUEST); ignore 'WD' drives 
+		 * Removable disks (eg. SYQUEST); ignore 'WD' drives.
 		 */
 		if (id->model[0] != 'W' || id->model[1] != 'D') {
 			drive->doorlocking = 1;
@@ -942,13 +946,26 @@
 	for (i = 0; i < MAX_DRIVES; ++i) {
 		ide_hwif_t *hwif = HWIF(drive);
 
-		if (drive != &hwif->drives[i]) continue;
+		if (drive != &hwif->drives[i])
+		    continue;
+		drvid = i;
 		hwif->gd->de_arr[i] = drive->de;
 		if (drive->removable)
 			hwif->gd->flags[i] |= GENHD_FL_REMOVABLE;
 		break;
 	}
 
+	/* Register us within the device tree.
+	 */
+
+	if (drvid != -1) {
+	    sprintf(drive->device.bus_id, "%d", drvid);
+	    sprintf(drive->device.name, "ide-disk");
+	    drive->device.driver = &idedisk_devdrv;
+	    drive->device.parent = &HWIF(drive)->device;
+	    device_register(&drive->device);
+	}
+
 	/* Extract geometry if we did not already have one for the drive */
 	if (!drive->cyl || !drive->head || !drive->sect) {
 		drive->cyl     = drive->bios_cyl  = id->cyls;
@@ -1023,6 +1040,12 @@
 
 static int idedisk_cleanup (ide_drive_t *drive)
 {
+
+	/* FIXME: we will have to think twice whatever this is the proper place
+	 * to do it.
+	 */
+
+	put_device(&drive->device);
 	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
 		if (do_idedisk_flushcache(drive))
 			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
@@ -1050,7 +1073,7 @@
 	open:			idedisk_open,
 	release:		idedisk_release,
 	media_change:		idedisk_media_change,
-	revalidate:		idedisk_revalidate,
+	revalidate:		ide_revalidate_drive,
 	pre_reset:		idedisk_pre_reset,
 	capacity:		idedisk_capacity,
 	special:		idedisk_special,
diff -ur linux-2.5.5/drivers/ide/ide-pnp.c linux/drivers/ide/ide-pnp.c
--- linux-2.5.5/drivers/ide/ide-pnp.c	Wed Feb 20 03:10:59 2002
+++ linux/drivers/ide/ide-pnp.c	Thu Feb 21 01:39:37 2002
@@ -57,6 +57,7 @@
 static int __init pnpide_generic_init(struct pci_dev *dev, int enable)
 {
 	hw_regs_t hw;
+	ide_hwif_t *hwif;
 	int index;
 
 	if (!enable)
@@ -69,10 +70,11 @@
 			generic_ide_offsets, (ide_ioreg_t) DEV_IO(dev, 1),
 			0, NULL, DEV_IRQ(dev, 0));
 
-	index = ide_register_hw(&hw, NULL);
+	index = ide_register_hw(&hw, &hwif);
 
 	if (index != -1) {
-	    	printk("ide%d: %s IDE interface\n", index, DEV_NAME(dev));
+		hwif->pci_dev = dev;
+		printk("ide%d: %s IDE interface\n", index, DEV_NAME(dev));
 		return 0;
 	}
 
diff -ur linux-2.5.5/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux-2.5.5/drivers/ide/ide-probe.c	Wed Feb 20 03:10:53 2002
+++ linux/drivers/ide/ide-probe.c	Thu Feb 21 01:31:32 2002
@@ -46,6 +46,7 @@
 #include <linux/delay.h>
 #include <linux/ide.h>
 #include <linux/spinlock.h>
+#include <linux/pci.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -465,6 +466,17 @@
 
 static void hwif_register (ide_hwif_t *hwif)
 {
+	/* Register this hardware interface within the global device tree.
+	 */
+	sprintf(hwif->device.bus_id, "%04x", hwif->io_ports[IDE_DATA_OFFSET]);
+	sprintf(hwif->device.name, "ide");
+	hwif->device.driver_data = hwif;
+	if (hwif->pci_dev)
+		hwif->device.parent = &hwif->pci_dev->dev;
+	else
+		hwif->device.parent = NULL; /* Would like to do = &device_legacy */
+	device_register(&hwif->device);
+
 	if (((unsigned long)hwif->io_ports[IDE_DATA_OFFSET] | 7) ==
 	    ((unsigned long)hwif->io_ports[IDE_STATUS_OFFSET])) {
 		ide_request_region(hwif->io_ports[IDE_DATA_OFFSET], 8, hwif->name);
diff -ur linux-2.5.5/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.5/drivers/ide/ide.c	Thu Feb 21 03:58:10 2002
+++ linux/drivers/ide/ide.c	Thu Feb 21 03:49:46 2002
@@ -128,8 +128,6 @@
 
 #undef REALLY_SLOW_IO		/* most systems can safely undef this */
 
-#define _IDE_C			/* Tell ide.h it's really us */
-
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/types.h>
@@ -153,6 +151,8 @@
 #include <linux/completion.h>
 #include <linux/reboot.h>
 #include <linux/cdrom.h>
+#include <linux/device.h>
+#include <linux/kmod.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -162,17 +162,102 @@
 
 #include "ide_modes.h"
 
-#ifdef CONFIG_KMOD
-#include <linux/kmod.h>
-#endif /* CONFIG_KMOD */
+/* Constant tables for PIO mode programming:
+ */
+
+const ide_pio_timings_t ide_pio_timings[6] = {
+	{ 70,	165,	600 },	/* PIO Mode 0 */
+	{ 50,	125,	383 },	/* PIO Mode 1 */
+	{ 30,	100,	240 },	/* PIO Mode 2 */
+	{ 30,	80,	180 },	/* PIO Mode 3 with IORDY */
+	{ 25,	70,	120 },	/* PIO Mode 4 with IORDY */
+	{ 20,	50,	100 }	/* PIO Mode 5 with IORDY (nonstandard) */
+};
+
+/*
+ * Black list. Some drives incorrectly report their maximal PIO mode,
+ * at least in respect to CMD640. Here we keep info on some known drives.
+ */
+static struct ide_pio_info {
+	const char	*name;
+	int		pio;
+} ide_pio_blacklist [] = {
+/*	{ "Conner Peripherals 1275MB - CFS1275A", 4 }, */
+	{ "Conner Peripherals 540MB - CFS540A", 3 },
+
+	{ "WDC AC2700",  3 },
+	{ "WDC AC2540",  3 },
+	{ "WDC AC2420",  3 },
+	{ "WDC AC2340",  3 },
+	{ "WDC AC2250",  0 },
+	{ "WDC AC2200",  0 },
+	{ "WDC AC21200", 4 },
+	{ "WDC AC2120",  0 },
+	{ "WDC AC2850",  3 },
+	{ "WDC AC1270",  3 },
+	{ "WDC AC1170",  1 },
+	{ "WDC AC1210",  1 },
+	{ "WDC AC280",   0 },
+/*	{ "WDC AC21000", 4 }, */
+	{ "WDC AC31000", 3 },
+	{ "WDC AC31200", 3 },
+/*	{ "WDC AC31600", 4 }, */
+
+	{ "Maxtor 7131 AT", 1 },
+	{ "Maxtor 7171 AT", 1 },
+	{ "Maxtor 7213 AT", 1 },
+	{ "Maxtor 7245 AT", 1 },
+	{ "Maxtor 7345 AT", 1 },
+	{ "Maxtor 7546 AT", 3 },
+	{ "Maxtor 7540 AV", 3 },
+
+	{ "SAMSUNG SHD-3121A", 1 },
+	{ "SAMSUNG SHD-3122A", 1 },
+	{ "SAMSUNG SHD-3172A", 1 },
+
+/*	{ "ST51080A", 4 },
+ *	{ "ST51270A", 4 },
+ *	{ "ST31220A", 4 },
+ *	{ "ST31640A", 4 },
+ *	{ "ST32140A", 4 },
+ *	{ "ST3780A",  4 },
+ */
+	{ "ST5660A",  3 },
+	{ "ST3660A",  3 },
+	{ "ST3630A",  3 },
+	{ "ST3655A",  3 },
+	{ "ST3391A",  3 },
+	{ "ST3390A",  1 },
+	{ "ST3600A",  1 },
+	{ "ST3290A",  0 },
+	{ "ST3144A",  0 },
+	{ "ST3491A",  1 },	/* reports 3, should be 1 or 2 (depending on */	
+				/* drive) according to Seagates FIND-ATA program */
+
+	{ "QUANTUM ELS127A", 0 },
+	{ "QUANTUM ELS170A", 0 },
+	{ "QUANTUM LPS240A", 0 },
+	{ "QUANTUM LPS210A", 3 },
+	{ "QUANTUM LPS270A", 3 },
+	{ "QUANTUM LPS365A", 3 },
+	{ "QUANTUM LPS540A", 3 },
+	{ "QUANTUM LIGHTNING 540A", 3 },
+	{ "QUANTUM LIGHTNING 730A", 3 },
+
+        { "QUANTUM FIREBALL_540", 3 }, /* Older Quantum Fireballs don't work */
+        { "QUANTUM FIREBALL_640", 3 }, 
+        { "QUANTUM FIREBALL_1080", 3 },
+        { "QUANTUM FIREBALL_1280", 3 },
+	{ NULL,	0 }
+};
 
 /* default maximum number of failures */
-#define IDE_DEFAULT_MAX_FAILURES 	1
+#define IDE_DEFAULT_MAX_FAILURES	1
 
 static const byte ide_hwif_to_major[] = { IDE0_MAJOR, IDE1_MAJOR, IDE2_MAJOR, IDE3_MAJOR, IDE4_MAJOR, IDE5_MAJOR, IDE6_MAJOR, IDE7_MAJOR, IDE8_MAJOR, IDE9_MAJOR };
 
 static int	idebus_parameter; /* holds the "idebus=" parameter */
-static int	system_bus_speed; /* holds what we think is VESA/PCI bus speed */
+int system_bus_speed; /* holds what we think is VESA/PCI bus speed */
 static int	initializing;     /* set while initializing built-in drivers */
 
 /*
@@ -200,6 +285,106 @@
  */
 ide_hwif_t	ide_hwifs[MAX_HWIFS];	/* master data repository */
 
+
+/*
+ * This routine searches the ide_pio_blacklist for an entry
+ * matching the start/whole of the supplied model name.
+ *
+ * Returns -1 if no match found.
+ * Otherwise returns the recommended PIO mode from ide_pio_blacklist[].
+ */
+int ide_scan_pio_blacklist (char *model)
+{
+	struct ide_pio_info *p;
+
+	for (p = ide_pio_blacklist; p->name != NULL; p++) {
+		if (strncmp(p->name, model, strlen(p->name)) == 0)
+			return p->pio;
+	}
+	return -1;
+}
+
+/*
+ * This routine returns the recommended PIO settings for a given drive,
+ * based on the drive->id information and the ide_pio_blacklist[].
+ * This is used by most chipset support modules when "auto-tuning".
+ */
+
+/*
+ * Drive PIO mode auto selection
+ */
+byte ide_get_best_pio_mode (ide_drive_t *drive, byte mode_wanted, byte max_mode, ide_pio_data_t *d)
+{
+	int pio_mode;
+	int cycle_time = 0;
+	int use_iordy = 0;
+	struct hd_driveid* id = drive->id;
+	int overridden  = 0;
+	int blacklisted = 0;
+
+	if (mode_wanted != 255) {
+		pio_mode = mode_wanted;
+	} else if (!drive->id) {
+		pio_mode = 0;
+	} else if ((pio_mode = ide_scan_pio_blacklist(id->model)) != -1) {
+		overridden = 1;
+		blacklisted = 1;
+		use_iordy = (pio_mode > 2);
+	} else {
+		pio_mode = id->tPIO;
+		if (pio_mode > 2) {	/* 2 is maximum allowed tPIO value */
+			pio_mode = 2;
+			overridden = 1;
+		}
+		if (id->field_valid & 2) {	  /* drive implements ATA2? */
+			if (id->capability & 8) { /* drive supports use_iordy? */
+				use_iordy = 1;
+				cycle_time = id->eide_pio_iordy;
+				if (id->eide_pio_modes & 7) {
+					overridden = 0;
+					if (id->eide_pio_modes & 4)
+						pio_mode = 5;
+					else if (id->eide_pio_modes & 2)
+						pio_mode = 4;
+					else
+						pio_mode = 3;
+				}
+			} else {
+				cycle_time = id->eide_pio;
+			}
+		}
+
+#if 0
+		if (drive->id->major_rev_num & 0x0004) printk("ATA-2 ");
+#endif
+
+		/*
+		 * Conservative "downgrade" for all pre-ATA2 drives
+		 */
+		if (pio_mode && pio_mode < 4) {
+			pio_mode--;
+			overridden = 1;
+#if 0
+			use_iordy = (pio_mode > 2);
+#endif
+			if (cycle_time && cycle_time < ide_pio_timings[pio_mode].cycle_time)
+				cycle_time = 0; /* use standard timing */
+		}
+	}
+	if (pio_mode > max_mode) {
+		pio_mode = max_mode;
+		cycle_time = 0;
+	}
+	if (d) {
+		d->pio_mode = pio_mode;
+		d->cycle_time = cycle_time ? cycle_time : ide_pio_timings[pio_mode].cycle_time;
+		d->use_iordy = use_iordy;
+		d->overridden = overridden;
+		d->blacklisted = blacklisted;
+	}
+	return pio_mode;
+}
+
 #if (DISK_RECOVERY_TIME > 0)
 /*
  * For really screwy hardware (hey, at least it *can* be used with Linux)
@@ -308,7 +493,6 @@
 	ide_init_default_hwifs();
 
 	idebus_parameter = 0;
-	system_bus_speed = 0;
 }
 
 /*
@@ -342,30 +526,6 @@
 	return 0;	/* no, it is not a flash memory card */
 }
 
-/*
- * ide_system_bus_speed() returns what we think is the system VESA/PCI
- * bus speed (in MHz).  This is used for calculating interface PIO timings.
- * The default is 40 for known PCI systems, 50 otherwise.
- * The "idebus=xx" parameter can be used to override this value.
- * The actual value to be used is computed/displayed the first time through.
- */
-int ide_system_bus_speed (void)
-{
-	if (!system_bus_speed) {
-		if (idebus_parameter)
-			system_bus_speed = idebus_parameter;	/* user supplied value */
-#ifdef CONFIG_PCI
-		else if (pci_present())
-			system_bus_speed = 33;	/* safe default value for PCI */
-#endif /* CONFIG_PCI */
-		else
-			system_bus_speed = 50;	/* safe default value for VESA and PCI */
-		printk("ide: Assuming %dMHz system bus speed for PIO modes%s\n", system_bus_speed,
-			idebus_parameter ? "" : "; override with idebus=xx");
-	}
-	return system_bus_speed;
-}
-
 int __ide_end_request(ide_drive_t *drive, int uptodate, int nr_secs)
 {
 	struct request *rq;
@@ -2005,6 +2165,7 @@
 	hwif = &ide_hwifs[index];
 	if (!hwif->present)
 		goto abort;
+	put_device(&hwif->device);
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		drive = &hwif->drives[unit];
 		if (!drive->present)
@@ -2489,11 +2650,6 @@
 #endif /* CONFIG_BLK_DEV_IDECS */
 }
 
-int system_bus_clock (void)
-{
-	return((int) ((!system_bus_speed) ? ide_system_bus_speed() : system_bus_speed ));
-}
-
 int ide_reinit_drive (ide_drive_t *drive)
 {
 	switch (drive->media) {
@@ -3676,9 +3832,6 @@
 EXPORT_SYMBOL(ide_setup_ports);
 EXPORT_SYMBOL(get_info_ptr);
 EXPORT_SYMBOL(current_capacity);
-
-EXPORT_SYMBOL(system_bus_clock);
-
 EXPORT_SYMBOL(ide_reinit_drive);
 
 static int ide_notify_reboot (struct notifier_block *this, unsigned long event, void *x)
@@ -3730,17 +3883,32 @@
 /*
  * This is gets invoked once during initialization, to set *everything* up
  */
-int __init ide_init (void)
+int __init ide_init(void)
 {
-	static char banner_printed;
 	int i;
 
-	if (!banner_printed) {
-		printk(KERN_INFO "Uniform Multi-Platform E-IDE driver " REVISION "\n");
-		ide_devfs_handle = devfs_mk_dir (NULL, "ide", NULL);
-		system_bus_speed = ide_system_bus_speed();
-		banner_printed = 1;
-	}
+	printk(KERN_INFO "Uniform Multi-Platform E-IDE driver " REVISION "\n");
+	ide_devfs_handle = devfs_mk_dir (NULL, "ide", NULL);
+
+	/* Initialize system bus speed.
+	 *
+	 * This can be changed by a particular chipse initialization module.
+	 * Otherwise we assume 33MHz as a safe value for PCI bus based systems.
+	 * 50MHz will be assumed for abolitions like VESA, since higher values
+	 * result in more conservative timing setups.
+	 *
+	 * The kernel parameter idebus=XX overrides the default settings.
+	 */
+
+	system_bus_speed = 50;
+	if (idebus_parameter)
+	    system_bus_speed = idebus_parameter;
+#ifdef CONFIG_PCI
+	else if (pci_present())
+	    system_bus_speed = 33;
+#endif
+
+	printk("ide: system bus speed %dMHz\n", system_bus_speed);
 
 	init_ide_data ();
 
diff -ur linux-2.5.5/drivers/ide/ide_modes.h linux/drivers/ide/ide_modes.h
--- linux-2.5.5/drivers/ide/ide_modes.h	Wed Feb 20 03:10:57 2002
+++ linux/drivers/ide/ide_modes.h	Thu Feb 21 02:33:24 2002
@@ -11,9 +11,6 @@
 
 /*
  * Shared data/functions for determining best PIO mode for an IDE drive.
- * Most of this stuff originally lived in cmd640.c, and changes to the
- * ide_pio_blacklist[] table should be made with EXTREME CAUTION to avoid
- * breaking the fragile cmd640.c support.
  */
 
 #ifdef CONFIG_BLK_DEV_IDE_MODES
@@ -37,200 +34,9 @@
 	byte blacklisted;
 	unsigned int cycle_time;
 } ide_pio_data_t;
-	
-#ifndef _IDE_C
 
-int ide_scan_pio_blacklist (char *model);
-byte ide_get_best_pio_mode (ide_drive_t *drive, byte mode_wanted, byte max_mode, ide_pio_data_t *d);
+extern int ide_scan_pio_blacklist (char *model);
+extern byte ide_get_best_pio_mode (ide_drive_t *drive, byte mode_wanted, byte max_mode, ide_pio_data_t *d);
 extern const ide_pio_timings_t ide_pio_timings[6];
-
-#else /* _IDE_C */
-
-const ide_pio_timings_t ide_pio_timings[6] = {
-	{ 70,	165,	600 },	/* PIO Mode 0 */
-	{ 50,	125,	383 },	/* PIO Mode 1 */
-	{ 30,	100,	240 },	/* PIO Mode 2 */
-	{ 30,	80,	180 },	/* PIO Mode 3 with IORDY */
-	{ 25,	70,	120 },	/* PIO Mode 4 with IORDY */
-	{ 20,	50,	100 }	/* PIO Mode 5 with IORDY (nonstandard) */
-};
-
-/*
- * Black list. Some drives incorrectly report their maximal PIO mode,
- * at least in respect to CMD640. Here we keep info on some known drives.
- */
-static struct ide_pio_info {
-	const char	*name;
-	int		pio;
-} ide_pio_blacklist [] = {
-/*	{ "Conner Peripherals 1275MB - CFS1275A", 4 }, */
-	{ "Conner Peripherals 540MB - CFS540A", 3 },
-
-	{ "WDC AC2700",  3 },
-	{ "WDC AC2540",  3 },
-	{ "WDC AC2420",  3 },
-	{ "WDC AC2340",  3 },
-	{ "WDC AC2250",  0 },
-	{ "WDC AC2200",  0 },
-	{ "WDC AC21200", 4 },
-	{ "WDC AC2120",  0 },
-	{ "WDC AC2850",  3 },
-	{ "WDC AC1270",  3 },
-	{ "WDC AC1170",  1 },
-	{ "WDC AC1210",  1 },
-	{ "WDC AC280",   0 },
-/*	{ "WDC AC21000", 4 }, */
-	{ "WDC AC31000", 3 },
-	{ "WDC AC31200", 3 },
-/*	{ "WDC AC31600", 4 }, */
-
-	{ "Maxtor 7131 AT", 1 },
-	{ "Maxtor 7171 AT", 1 },
-	{ "Maxtor 7213 AT", 1 },
-	{ "Maxtor 7245 AT", 1 },
-	{ "Maxtor 7345 AT", 1 },
-	{ "Maxtor 7546 AT", 3 },
-	{ "Maxtor 7540 AV", 3 },
-
-	{ "SAMSUNG SHD-3121A", 1 },
-	{ "SAMSUNG SHD-3122A", 1 },
-	{ "SAMSUNG SHD-3172A", 1 },
-
-/*	{ "ST51080A", 4 },
- *	{ "ST51270A", 4 },
- *	{ "ST31220A", 4 },
- *	{ "ST31640A", 4 },
- *	{ "ST32140A", 4 },
- *	{ "ST3780A",  4 },
- */
-	{ "ST5660A",  3 },
-	{ "ST3660A",  3 },
-	{ "ST3630A",  3 },
-	{ "ST3655A",  3 },
-	{ "ST3391A",  3 },
-	{ "ST3390A",  1 },
-	{ "ST3600A",  1 },
-	{ "ST3290A",  0 },
-	{ "ST3144A",  0 },
-	{ "ST3491A",  1 },	/* reports 3, should be 1 or 2 (depending on */	
-				/* drive) according to Seagates FIND-ATA program */
-
-	{ "QUANTUM ELS127A", 0 },
-	{ "QUANTUM ELS170A", 0 },
-	{ "QUANTUM LPS240A", 0 },
-	{ "QUANTUM LPS210A", 3 },
-	{ "QUANTUM LPS270A", 3 },
-	{ "QUANTUM LPS365A", 3 },
-	{ "QUANTUM LPS540A", 3 },
-	{ "QUANTUM LIGHTNING 540A", 3 },
-	{ "QUANTUM LIGHTNING 730A", 3 },
-
-        { "QUANTUM FIREBALL_540", 3 }, /* Older Quantum Fireballs don't work */
-        { "QUANTUM FIREBALL_640", 3 }, 
-        { "QUANTUM FIREBALL_1080", 3 },
-        { "QUANTUM FIREBALL_1280", 3 },
-	{ NULL,	0 }
-};
-
-/*
- * This routine searches the ide_pio_blacklist for an entry
- * matching the start/whole of the supplied model name.
- *
- * Returns -1 if no match found.
- * Otherwise returns the recommended PIO mode from ide_pio_blacklist[].
- */
-int ide_scan_pio_blacklist (char *model)
-{
-	struct ide_pio_info *p;
-
-	for (p = ide_pio_blacklist; p->name != NULL; p++) {
-		if (strncmp(p->name, model, strlen(p->name)) == 0)
-			return p->pio;
-	}
-	return -1;
-}
-
-/*
- * This routine returns the recommended PIO settings for a given drive,
- * based on the drive->id information and the ide_pio_blacklist[].
- * This is used by most chipset support modules when "auto-tuning".
- */
-
-/*
- * Drive PIO mode auto selection
- */
-byte ide_get_best_pio_mode (ide_drive_t *drive, byte mode_wanted, byte max_mode, ide_pio_data_t *d)
-{
-	int pio_mode;
-	int cycle_time = 0;
-	int use_iordy = 0;
-	struct hd_driveid* id = drive->id;
-	int overridden  = 0;
-	int blacklisted = 0;
-
-	if (mode_wanted != 255) {
-		pio_mode = mode_wanted;
-	} else if (!drive->id) {
-		pio_mode = 0;
-	} else if ((pio_mode = ide_scan_pio_blacklist(id->model)) != -1) {
-		overridden = 1;
-		blacklisted = 1;
-		use_iordy = (pio_mode > 2);
-	} else {
-		pio_mode = id->tPIO;
-		if (pio_mode > 2) {	/* 2 is maximum allowed tPIO value */
-			pio_mode = 2;
-			overridden = 1;
-		}
-		if (id->field_valid & 2) {	  /* drive implements ATA2? */
-			if (id->capability & 8) { /* drive supports use_iordy? */
-				use_iordy = 1;
-				cycle_time = id->eide_pio_iordy;
-				if (id->eide_pio_modes & 7) {
-					overridden = 0;
-					if (id->eide_pio_modes & 4)
-						pio_mode = 5;
-					else if (id->eide_pio_modes & 2)
-						pio_mode = 4;
-					else
-						pio_mode = 3;
-				}
-			} else {
-				cycle_time = id->eide_pio;
-			}
-		}
-
-#if 0
-		if (drive->id->major_rev_num & 0x0004) printk("ATA-2 ");
 #endif
-
-		/*
-		 * Conservative "downgrade" for all pre-ATA2 drives
-		 */
-		if (pio_mode && pio_mode < 4) {
-			pio_mode--;
-			overridden = 1;
-#if 0
-			use_iordy = (pio_mode > 2);
 #endif
-			if (cycle_time && cycle_time < ide_pio_timings[pio_mode].cycle_time)
-				cycle_time = 0; /* use standard timing */
-		}
-	}
-	if (pio_mode > max_mode) {
-		pio_mode = max_mode;
-		cycle_time = 0;
-	}
-	if (d) {
-		d->pio_mode = pio_mode;
-		d->cycle_time = cycle_time ? cycle_time : ide_pio_timings[pio_mode].cycle_time;
-		d->use_iordy = use_iordy;
-		d->overridden = overridden;
-		d->blacklisted = blacklisted;
-	}
-	return pio_mode;
-}
-
-#endif /* _IDE_C */
-#endif /* CONFIG_BLK_DEV_IDE_MODES */
-#endif /* _IDE_MODES_H */
diff -ur linux-2.5.5/drivers/ide/opti621.c linux/drivers/ide/opti621.c
--- linux-2.5.5/drivers/ide/opti621.c	Wed Feb 20 03:10:56 2002
+++ linux/drivers/ide/opti621.c	Thu Feb 21 03:02:35 2002
@@ -164,7 +164,7 @@
 	}
 }
 
-int cmpt_clk(int time, int bus_speed)
+static int cmpt_clk(int time, int bus_speed)
 /* Returns (rounded up) time in clocks for time in ns,
  * with bus_speed in MHz.
  * Example: bus_speed = 40 MHz, time = 80 ns
@@ -216,14 +216,13 @@
 {
         if (pio != PIO_NOT_EXIST) {
         	int adr_setup, data_pls;
-		int bus_speed = system_bus_clock();
 
  	       	adr_setup = ide_pio_timings[pio].setup_time;
   	      	data_pls = ide_pio_timings[pio].active_time;
-	  	clks->address_time = cmpt_clk(adr_setup, bus_speed);
-	     	clks->data_time = cmpt_clk(data_pls, bus_speed);
+	  	clks->address_time = cmpt_clk(adr_setup, system_bus_speed);
+	     	clks->data_time = cmpt_clk(data_pls, system_bus_speed);
      		clks->recovery_time = cmpt_clk(ide_pio_timings[pio].cycle_time
-     			- adr_setup-data_pls, bus_speed);
+     			- adr_setup-data_pls, system_bus_speed);
      		if (clks->address_time<1) clks->address_time = 1;
      		if (clks->address_time>4) clks->address_time = 4;
      		if (clks->data_time<1) clks->data_time = 1;
diff -ur linux-2.5.5/drivers/ide/qd65xx.c linux/drivers/ide/qd65xx.c
--- linux-2.5.5/drivers/ide/qd65xx.c	Wed Feb 20 03:10:58 2002
+++ linux/drivers/ide/qd65xx.c	Thu Feb 21 02:59:32 2002
@@ -139,12 +139,12 @@
 {
 	byte active_cycle,recovery_cycle;
 
-	if (ide_system_bus_speed()<=33) {
-		active_cycle =   9  - IDE_IN(active_time   * ide_system_bus_speed() / 1000 + 1, 2, 9);
-		recovery_cycle = 15 - IDE_IN(recovery_time * ide_system_bus_speed() / 1000 + 1, 0, 15);
+	if (system_bus_speed <= 33) {
+		active_cycle =   9  - IDE_IN(active_time   * system_bus_speed / 1000 + 1, 2, 9);
+		recovery_cycle = 15 - IDE_IN(recovery_time * system_bus_speed / 1000 + 1, 0, 15);
 	} else {
-		active_cycle =   8  - IDE_IN(active_time   * ide_system_bus_speed() / 1000 + 1, 1, 8);
-		recovery_cycle = 18 - IDE_IN(recovery_time * ide_system_bus_speed() / 1000 + 1, 3, 18);
+		active_cycle =   8  - IDE_IN(active_time   * system_bus_speed / 1000 + 1, 1, 8);
+		recovery_cycle = 18 - IDE_IN(recovery_time * system_bus_speed / 1000 + 1, 3, 18);
 	}
 
 	return((recovery_cycle<<4) | 0x08 | active_cycle);
@@ -158,8 +158,8 @@
 
 static byte qd6580_compute_timing (int active_time, int recovery_time)
 {
-	byte active_cycle   = 17-IDE_IN(active_time   * ide_system_bus_speed() / 1000 + 1, 2, 17);
-	byte recovery_cycle = 15-IDE_IN(recovery_time * ide_system_bus_speed() / 1000 + 1, 2, 15);
+	byte active_cycle   = 17-IDE_IN(active_time   * system_bus_speed / 1000 + 1, 2, 17);
+	byte recovery_cycle = 15-IDE_IN(recovery_time * system_bus_speed / 1000 + 1, 2, 15);
 
 	return((recovery_cycle<<4) | active_cycle);
 }
diff -ur linux-2.5.5/drivers/ide/via82cxxx.c linux/drivers/ide/via82cxxx.c
--- linux-2.5.5/drivers/ide/via82cxxx.c	Wed Feb 20 03:10:59 2002
+++ linux/drivers/ide/via82cxxx.c	Thu Feb 21 03:04:19 2002
@@ -484,7 +484,7 @@
  * Determine system bus clock.
  */
 
-	via_clock = system_bus_clock() * 1000;
+	via_clock = system_bus_speed * 1000;
 
 	switch (via_clock) {
 		case 33000: via_clock = 33333; break;
diff -ur linux-2.5.5/include/linux/blk.h linux/include/linux/blk.h
--- linux-2.5.5/include/linux/blk.h	Wed Feb 20 03:10:59 2002
+++ linux/include/linux/blk.h	Thu Feb 21 03:49:40 2002
@@ -8,11 +8,6 @@
 #include <linux/spinlock.h>
 #include <linux/compiler.h>
 
-/*
- * get rid of this next...
- */
-extern int ide_init(void);
-
 extern void set_device_ro(kdev_t dev,int flag);
 extern void add_blkdev_randomness(int major);
 
diff -ur linux-2.5.5/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.5/include/linux/ide.h	Thu Feb 21 03:58:10 2002
+++ linux/include/linux/ide.h	Thu Feb 21 03:49:57 2002
@@ -13,6 +13,7 @@
 #include <linux/hdsmart.h>
 #include <linux/blkdev.h>
 #include <linux/proc_fs.h>
+#include <linux/device.h>
 #include <linux/devfs_fs_kernel.h>
 #include <asm/hdreg.h>
 
@@ -426,7 +427,7 @@
 	unsigned long	capacity;	/* total number of sectors */
 	unsigned long long capacity48;	/* total number of sectors */
 	unsigned int	drive_data;	/* for use by tuneproc/selectproc as needed */
-	struct hwif_s   *hwif;		/* actually (ide_hwif_t *) */
+	struct hwif_s   *hwif;		/* parent pointer to the interface we are attached to  */
 	wait_queue_head_t wqueue;	/* used to wait for drive in open() */
 	struct hd_driveid *id;		/* drive model identification info */
 	struct hd_struct  *part;	/* drive partition table */
@@ -450,6 +451,7 @@
 	byte		acoustic;	/* acoustic management */
 	unsigned int	failures;	/* current failure count */
 	unsigned int	max_failures;	/* maximum allowed failure count */
+	struct device	device;		/* global device tree handle */
 } ide_drive_t;
 
 /*
@@ -582,6 +584,7 @@
 	void		*hwif_data;	/* extra hwif data */
 	ide_busproc_t	*busproc;	/* driver soft-power interface */
 	byte		bus_state;	/* power state of the IDE bus */
+	struct device	device;		/* global device tree handle */
 } ide_hwif_t;
 
 /*
@@ -735,9 +738,7 @@
  * structure directly (the allocation/layout may change!).
  *
  */
-#ifndef _IDE_C
 extern struct hwif_s ide_hwifs[];		/* master data repository */
-#endif
 extern int noautodma;
 
 /*
@@ -812,7 +813,7 @@
 /*
  * Revalidate (read partition tables)
  */
-void ide_revalidate_drive (ide_drive_t *drive);
+extern void ide_revalidate_drive (ide_drive_t *drive);
 
 /*
  * Start a reset operation for an IDE interface.
@@ -953,7 +954,6 @@
 /*
  * Special Flagged Register Validation Caller
  */
-// ide_startstop_t flagged_taskfile (ide_drive_t *drive, ide_task_t *task);
 
 ide_startstop_t set_multmode_intr (ide_drive_t *drive);
 ide_startstop_t set_geometry_intr (ide_drive_t *drive);
@@ -984,7 +984,6 @@
 #endif /* CONFIG_PKT_TASK_IOCTL */
 
 void ide_delay_50ms (void);
-int system_bus_clock(void);
 
 byte ide_auto_reduce_xfer (ide_drive_t *drive);
 int ide_driveid_update (ide_drive_t *drive);
@@ -993,13 +992,7 @@
 byte eighty_ninty_three (ide_drive_t *drive);
 int set_transfer (ide_drive_t *drive, ide_task_t *args);
 
-/*
- * ide_system_bus_speed() returns what we think is the system VESA/PCI
- * bus speed (in MHz).  This is used for calculating interface PIO timings.
- * The default is 40 for known PCI systems, 50 otherwise.
- * The "idebus=xx" parameter can be used to override this value.
- */
-int ide_system_bus_speed (void);
+extern int system_bus_speed;
 
 /*
  * idedisk_input_data() is a wrapper around ide_input_data() which copes
@@ -1031,40 +1024,36 @@
 void do_ide_request (request_queue_t * q);
 void ide_init_subdrivers (void);
 
-#ifndef _IDE_C
 extern struct block_device_operations ide_fops[];
 extern ide_proc_entry_t generic_subdriver_entries[];
-#endif
 
-int ide_reinit_drive (ide_drive_t *drive);
+extern int ide_reinit_drive (ide_drive_t *drive);
 
-#ifdef _IDE_C
-# ifdef CONFIG_BLK_DEV_IDE
+#ifdef CONFIG_BLK_DEV_IDE
 /* Probe for devices attached to the systems host controllers.
  */
 extern int ideprobe_init (void);
-# endif
+#endif
 #ifdef CONFIG_BLK_DEV_IDEDISK
-int idedisk_reinit (ide_drive_t *drive);
-int idedisk_init (void);
+extern int idedisk_reinit (ide_drive_t *drive);
+extern int idedisk_init (void);
 #endif /* CONFIG_BLK_DEV_IDEDISK */
 #ifdef CONFIG_BLK_DEV_IDECD
-int ide_cdrom_reinit (ide_drive_t *drive);
-int ide_cdrom_init (void);
+extern int ide_cdrom_reinit (ide_drive_t *drive);
+extern int ide_cdrom_init (void);
 #endif /* CONFIG_BLK_DEV_IDECD */
 #ifdef CONFIG_BLK_DEV_IDETAPE
-int idetape_reinit (ide_drive_t *drive);
-int idetape_init (void);
+extern int idetape_reinit (ide_drive_t *drive);
+extern int idetape_init (void);
 #endif /* CONFIG_BLK_DEV_IDETAPE */
 #ifdef CONFIG_BLK_DEV_IDEFLOPPY
-int idefloppy_reinit (ide_drive_t *drive);
-int idefloppy_init (void);
+extern int idefloppy_reinit (ide_drive_t *drive);
+extern int idefloppy_init (void);
 #endif /* CONFIG_BLK_DEV_IDEFLOPPY */
 #ifdef CONFIG_BLK_DEV_IDESCSI
-int idescsi_reinit (ide_drive_t *drive);
-int idescsi_init (void);
+extern int idescsi_reinit (ide_drive_t *drive);
+extern int idescsi_init (void);
 #endif /* CONFIG_BLK_DEV_IDESCSI */
-#endif /* _IDE_C */
 
 ide_drive_t *ide_scan_devices (byte media, const char *name, ide_driver_t *driver, int n);
 extern int ide_register_subdriver(ide_drive_t *drive, ide_driver_t *driver);

--------------000507070909030102060301--

