Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264211AbVBDDXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264211AbVBDDXl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 22:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264063AbVBDDWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 22:22:05 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:36278 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S263118AbVBDDLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 22:11:33 -0500
Date: Fri, 4 Feb 2005 03:53:32 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 8/9] kill ide-default
Message-ID: <Pine.GSO.4.58.0502040352530.4393@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* add ide_drives list to list devices without a driver
* add __ide_add_setting() and use it for adding no auto remove entries
* kill ide-default pseudo-driver

diff -Nru a/drivers/ide/Makefile b/drivers/ide/Makefile
--- a/drivers/ide/Makefile	2005-02-04 03:32:17 +01:00
+++ b/drivers/ide/Makefile	2005-02-04 03:32:17 +01:00
@@ -13,8 +13,7 @@

 obj-$(CONFIG_BLK_DEV_IDE)		+= pci/

-ide-core-y += ide.o ide-default.o ide-io.o ide-iops.o ide-lib.o ide-probe.o \
-	ide-taskfile.o
+ide-core-y += ide.o ide-io.o ide-iops.o ide-lib.o ide-probe.o ide-taskfile.o

 ide-core-$(CONFIG_BLK_DEV_CMD640)	+= pci/cmd640.o

diff -Nru a/drivers/ide/ide-default.c b/drivers/ide/ide-default.c
--- a/drivers/ide/ide-default.c	2005-02-04 03:32:17 +01:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,76 +0,0 @@
-/*
- *	ide-default		-	Driver for unbound ide devices
- *
- *	This provides a clean way to bind a device to default operations
- *	by having an actual driver class that rather than special casing
- *	"no driver" all over the IDE code
- *
- *	Copyright (C) 2003, Red Hat <alan@redhat.com>
- */
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
-#include <linux/delay.h>
-#include <linux/timer.h>
-#include <linux/mm.h>
-#include <linux/interrupt.h>
-#include <linux/major.h>
-#include <linux/errno.h>
-#include <linux/genhd.h>
-#include <linux/slab.h>
-#include <linux/cdrom.h>
-#include <linux/ide.h>
-#include <linux/bitops.h>
-
-#include <asm/byteorder.h>
-#include <asm/irq.h>
-#include <asm/uaccess.h>
-#include <asm/io.h>
-#include <asm/unaligned.h>
-
-#define IDEDEFAULT_VERSION	"0.9.newide"
-/*
- *	Driver initialization.
- */
-
-static int idedefault_attach(ide_drive_t *drive);
-
-static ide_startstop_t idedefault_do_request(ide_drive_t *drive, struct request *rq, sector_t block)
-{
-	ide_end_request(drive, 0, 0);
-	return ide_stopped;
-}
-
-/*
- *	IDE subdriver functions, registered with ide.c
- */
-
-ide_driver_t idedefault_driver = {
-	.name		=	"ide-default",
-	.version	=	IDEDEFAULT_VERSION,
-	.attach		=	idedefault_attach,
-	.cleanup	=	ide_unregister_subdriver,
-	.do_request	=	idedefault_do_request,
-	.end_request	=	ide_end_request,
-	.error		=	__ide_error,
-	.abort		=	__ide_abort,
-	.drives		=	LIST_HEAD_INIT(idedefault_driver.drives)
-};
-
-static int idedefault_attach (ide_drive_t *drive)
-{
-	if (ide_register_subdriver(drive, &idedefault_driver)) {
-		printk(KERN_ERR "ide-default: %s: Failed to register the "
-			"driver with ide.c\n", drive->name);
-		return 1;
-	}
-
-	return 0;
-}
-
-MODULE_DESCRIPTION("IDE Default Driver");
-
-MODULE_LICENSE("GPL");
diff -Nru a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
--- a/drivers/ide/ide-proc.c	2005-02-04 03:32:17 +01:00
+++ b/drivers/ide/ide-proc.c	2005-02-04 03:32:17 +01:00
@@ -107,8 +107,6 @@
 	if (drive) {
 		unsigned short *val = (unsigned short *) page;

-		BUG_ON(!drive->driver);
-
 		err = taskfile_lib_get_identify(drive, page);
 		if (!err) {
 			char *out = ((char *)page) + (SECTOR_WORDS * 4);
@@ -312,8 +310,11 @@
 	ide_driver_t	*driver = drive->driver;
 	int		len;

-	len = sprintf(page, "%s version %s\n",
-			driver->name, driver->version);
+	if (driver) {
+		len = sprintf(page, "%s version %s\n",
+				driver->name, driver->version);
+	} else
+		len = sprintf(page, "ide-default version 0.9.newide\n");
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }

diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2005-02-04 03:32:17 +01:00
+++ b/drivers/ide/ide.c	2005-02-04 03:32:17 +01:00
@@ -196,7 +196,7 @@

 EXPORT_SYMBOL(ide_hwifs);

-extern ide_driver_t idedefault_driver;
+static struct list_head ide_drives = LIST_HEAD_INIT(ide_drives);

 /*
  * Do not even *think* about calling this!
@@ -245,7 +245,6 @@
 		drive->max_failures		= IDE_DEFAULT_MAX_FAILURES;
 		drive->using_dma		= 0;
 		drive->is_flash			= 0;
-		drive->driver			= &idedefault_driver;
 		drive->vdma			= 0;
 		INIT_LIST_HEAD(&drive->list);
 		sema_init(&drive->gendev_rel_sem, 0);
@@ -917,7 +916,7 @@
 DECLARE_MUTEX(ide_setting_sem);

 /**
- *	ide_add_setting	-	add an ide setting option
+ *	__ide_add_setting	-	add an ide setting option
  *	@drive: drive to use
  *	@name: setting name
  *	@rw: true if the function is read write
@@ -930,6 +929,7 @@
  *	@div_factor: divison scale
  *	@data: private data field
  *	@set: setting
+ *	@auto_remove: setting auto removal flag
  *
  *	Removes the setting named from the device if it is present.
  *	The function takes the settings_lock to protect against
@@ -941,8 +941,8 @@
  *	a driver is attached we assume the driver settings are auto
  *	remove.
  */
-
-int ide_add_setting (ide_drive_t *drive, const char *name, int rw, int read_ioctl, int write_ioctl, int data_type, int min, int max, int mul_factor, int div_factor, void *data, ide_procset_t *set)
+
+static int __ide_add_setting(ide_drive_t *drive, const char *name, int rw, int read_ioctl, int write_ioctl, int data_type, int min, int max, int mul_factor, int div_factor, void *data, ide_procset_t *set, int auto_remove)
 {
 	ide_settings_t **p = (ide_settings_t **) &drive->settings, *setting = NULL;

@@ -967,7 +967,7 @@
 	setting->set = set;

 	setting->next = *p;
-	if (drive->driver != &idedefault_driver)
+	if (auto_remove)
 		setting->auto_remove = 1;
 	*p = setting;
 	up(&ide_setting_sem);
@@ -979,6 +979,11 @@
 	return -1;
 }

+int ide_add_setting(ide_drive_t *drive, const char *name, int rw, int read_ioctl, int write_ioctl, int data_type, int min, int max, int mul_factor, int div_factor, void *data, ide_procset_t *set)
+{
+	return __ide_add_setting(drive, name, rw, read_ioctl, write_ioctl, data_type, min, max, mul_factor, div_factor, data, set, 1);
+}
+
 EXPORT_SYMBOL(ide_add_setting);

 /**
@@ -1268,17 +1273,17 @@
 void ide_add_generic_settings (ide_drive_t *drive)
 {
 /*
- *			drive	setting name		read/write access				read ioctl		write ioctl		data type	min	max				mul_factor	div_factor	data pointer			set function
+ *			  drive		setting name		read/write access				read ioctl		write ioctl		data type	min	max				mul_factor	div_factor	data pointer			set function
  */
-	ide_add_setting(drive,	"io_32bit",		drive->no_io_32bit ? SETTING_READ : SETTING_RW,	HDIO_GET_32BIT,		HDIO_SET_32BIT,		TYPE_BYTE,	0,	1 + (SUPPORT_VLB_SYNC << 1),	1,		1,		&drive->io_32bit,		set_io_32bit);
-	ide_add_setting(drive,	"keepsettings",		SETTING_RW,					HDIO_GET_KEEPSETTINGS,	HDIO_SET_KEEPSETTINGS,	TYPE_BYTE,	0,	1,				1,		1,		&drive->keep_settings,		NULL);
-	ide_add_setting(drive,	"nice1",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	1,				1,		1,		&drive->nice1,			NULL);
-	ide_add_setting(drive,	"pio_mode",		SETTING_WRITE,					-1,			HDIO_SET_PIO_MODE,	TYPE_BYTE,	0,	255,				1,		1,		NULL,				set_pio_mode);
-	ide_add_setting(drive,	"unmaskirq",		drive->no_unmask ? SETTING_READ : SETTING_RW,	HDIO_GET_UNMASKINTR,	HDIO_SET_UNMASKINTR,	TYPE_BYTE,	0,	1,				1,		1,		&drive->unmask,			NULL);
-	ide_add_setting(drive,	"using_dma",		SETTING_RW,					HDIO_GET_DMA,		HDIO_SET_DMA,		TYPE_BYTE,	0,	1,				1,		1,		&drive->using_dma,		set_using_dma);
-	ide_add_setting(drive,	"init_speed",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	70,				1,		1,		&drive->init_speed,		NULL);
-	ide_add_setting(drive,	"current_speed",	SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	70,				1,		1,		&drive->current_speed,		set_xfer_rate);
-	ide_add_setting(drive,	"number",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	3,				1,		1,		&drive->dn,			NULL);
+	__ide_add_setting(drive,	"io_32bit",		drive->no_io_32bit ? SETTING_READ : SETTING_RW,	HDIO_GET_32BIT,		HDIO_SET_32BIT,		TYPE_BYTE,	0,	1 + (SUPPORT_VLB_SYNC << 1),	1,		1,		&drive->io_32bit,		set_io_32bit,	0);
+	__ide_add_setting(drive,	"keepsettings",		SETTING_RW,					HDIO_GET_KEEPSETTINGS,	HDIO_SET_KEEPSETTINGS,	TYPE_BYTE,	0,	1,				1,		1,		&drive->keep_settings,		NULL,		0);
+	__ide_add_setting(drive,	"nice1",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	1,				1,		1,		&drive->nice1,			NULL,		0);
+	__ide_add_setting(drive,	"pio_mode",		SETTING_WRITE,					-1,			HDIO_SET_PIO_MODE,	TYPE_BYTE,	0,	255,				1,		1,		NULL,				set_pio_mode,	0);
+	__ide_add_setting(drive,	"unmaskirq",		drive->no_unmask ? SETTING_READ : SETTING_RW,	HDIO_GET_UNMASKINTR,	HDIO_SET_UNMASKINTR,	TYPE_BYTE,	0,	1,				1,		1,		&drive->unmask,			NULL,		0);
+	__ide_add_setting(drive,	"using_dma",		SETTING_RW,					HDIO_GET_DMA,		HDIO_SET_DMA,		TYPE_BYTE,	0,	1,				1,		1,		&drive->using_dma,		set_using_dma,	0);
+	__ide_add_setting(drive,	"init_speed",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	70,				1,		1,		&drive->init_speed,		NULL,		0);
+	__ide_add_setting(drive,	"current_speed",	SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	70,				1,		1,		&drive->current_speed,		set_xfer_rate,	0);
+	__ide_add_setting(drive,	"number",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	3,				1,		1,		&drive->dn,			NULL,		0);
 }

 /**
@@ -1316,7 +1321,7 @@
 	} else {
 		drive->driver_req[0] = 0;
 	}
-	if (DRIVER(drive)!= &idedefault_driver && !strcmp(DRIVER(drive)->name, driver))
+	if (drive->driver && !strcmp(drive->driver->name, driver))
 		return 0;
 abort:
 	return 1;
@@ -1355,9 +1360,9 @@
 		spin_lock(&drivers_lock);
 		module_put(driver->owner);
 	}
-	drive->gendev.driver = &idedefault_driver.gen_driver;
+	drive->gendev.driver = NULL;
 	spin_unlock(&drivers_lock);
-	if(idedefault_driver.attach(drive) != 0)
+	if (ide_register_subdriver(drive, NULL))
 		panic("ide: default attach failed");
 	return 1;
 }
@@ -2007,10 +2012,8 @@
 {
 	unsigned long flags;

-	BUG_ON(!drive->driver);
-
 	spin_lock_irqsave(&ide_lock, flags);
-	if (!drive->present || drive->driver != &idedefault_driver ||
+	if (!drive->present || drive->driver != NULL ||
 	    drive->usage || drive->dead) {
 		spin_unlock_irqrestore(&ide_lock, flags);
 		return 1;
@@ -2018,11 +2021,11 @@
 	drive->driver = driver;
 	spin_unlock_irqrestore(&ide_lock, flags);
 	spin_lock(&drives_lock);
-	list_add_tail(&drive->list, &driver->drives);
+	list_add_tail(&drive->list, driver ? &driver->drives : &ide_drives);
 	spin_unlock(&drives_lock);
 //	printk(KERN_INFO "%s: attached %s driver.\n", drive->name, driver->name);
 #ifdef CONFIG_PROC_FS
-	if (drive->driver != &idedefault_driver)
+	if (driver)
 		ide_add_proc_entries(drive->proc, driver->proc, drive);
 #endif
 	return 0;
@@ -2050,7 +2053,7 @@

 	down(&ide_setting_sem);
 	spin_lock_irqsave(&ide_lock, flags);
-	if (drive->usage || drive->driver == &idedefault_driver || DRIVER(drive)->busy) {
+	if (drive->usage || drive->driver == NULL || DRIVER(drive)->busy) {
 		spin_unlock_irqrestore(&ide_lock, flags);
 		up(&ide_setting_sem);
 		return 1;
@@ -2059,13 +2062,13 @@
 	ide_remove_proc_entries(drive->proc, DRIVER(drive)->proc);
 #endif
 	auto_remove_settings(drive);
-	drive->driver = &idedefault_driver;
+	drive->driver = NULL;
 	spin_unlock_irqrestore(&ide_lock, flags);
 	up(&ide_setting_sem);
 	spin_lock(&drives_lock);
 	list_del_init(&drive->list);
 	spin_unlock(&drives_lock);
-	/* drive will be added to &idedefault_driver->drives in ata_attach() */
+	/* drive will be added to &ide_drives in ata_attach() */
 	return 0;
 }

@@ -2101,7 +2104,7 @@

 	INIT_LIST_HEAD(&list);
 	spin_lock(&drives_lock);
-	list_splice_init(&idedefault_driver.drives, &list);
+	list_splice_init(&ide_drives, &list);
 	spin_unlock(&drives_lock);

 	list_for_each_safe(list_loop, tmp_storage, &list) {
