Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262590AbVAUXXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbVAUXXb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 18:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbVAUXWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 18:22:54 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:50605 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S262586AbVAUXO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 18:14:28 -0500
Date: Sat, 22 Jan 2005 00:06:35 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [ide-dev 4/5] fix some rare ide-default vs ide-disk races
Message-ID: <Pine.GSO.4.58.0501220005060.23959@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some rare races between ide-default and ide-disk are possible, i.e.:
* ide-default is used, I/O request is triggered (ie. /proc/ide/hd?/identify),
  drive->special is cleared silently (so CHS is not initialized properly),
  ide-disk is loaded and fails if drive uses CHS
* ide-disk is used, drive is resetted, ide-disk is unloaded, ide-default
  takes control over drive and on the first I/O request silently clears
  drive->special without restoring settings

Fix them by moving idedisk_{special,pre_reset}() and company to IDE core.

diff -Nru a/drivers/ide/Kconfig b/drivers/ide/Kconfig
--- a/drivers/ide/Kconfig	2005-01-21 23:53:42 +01:00
+++ b/drivers/ide/Kconfig	2005-01-21 23:53:42 +01:00
@@ -150,7 +150,6 @@

 config IDEDISK_MULTI_MODE
 	bool "Use multi-mode by default"
-	depends on BLK_DEV_IDEDISK
 	help
 	  If you get this error, try to say Y here:

diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	2005-01-21 23:53:42 +01:00
+++ b/drivers/ide/ide-disk.c	2005-01-21 23:53:42 +01:00
@@ -517,75 +517,6 @@
 	return drive->capacity64 - drive->sect0;
 }

-#define IS_PDC4030_DRIVE	0
-
-static ide_startstop_t idedisk_special (ide_drive_t *drive)
-{
-	special_t *s = &drive->special;
-
-	if (s->b.set_geometry) {
-		s->b.set_geometry	= 0;
-		if (!IS_PDC4030_DRIVE) {
-			ide_task_t args;
-			memset(&args, 0, sizeof(ide_task_t));
-			args.tfRegister[IDE_NSECTOR_OFFSET] = drive->sect;
-			args.tfRegister[IDE_SECTOR_OFFSET]  = drive->sect;
-			args.tfRegister[IDE_LCYL_OFFSET]    = drive->cyl;
-			args.tfRegister[IDE_HCYL_OFFSET]    = drive->cyl>>8;
-			args.tfRegister[IDE_SELECT_OFFSET]  = ((drive->head-1)|drive->select.all)&0xBF;
-			args.tfRegister[IDE_COMMAND_OFFSET] = WIN_SPECIFY;
-			args.command_type = IDE_DRIVE_TASK_NO_DATA;
-			args.handler	  = &set_geometry_intr;
-			do_rw_taskfile(drive, &args);
-		}
-	} else if (s->b.recalibrate) {
-		s->b.recalibrate = 0;
-		if (!IS_PDC4030_DRIVE) {
-			ide_task_t args;
-			memset(&args, 0, sizeof(ide_task_t));
-			args.tfRegister[IDE_NSECTOR_OFFSET] = drive->sect;
-			args.tfRegister[IDE_COMMAND_OFFSET] = WIN_RESTORE;
-			args.command_type = IDE_DRIVE_TASK_NO_DATA;
-			args.handler	  = &recal_intr;
-			do_rw_taskfile(drive, &args);
-		}
-	} else if (s->b.set_multmode) {
-		s->b.set_multmode = 0;
-		if (drive->mult_req > drive->id->max_multsect)
-			drive->mult_req = drive->id->max_multsect;
-		if (!IS_PDC4030_DRIVE) {
-			ide_task_t args;
-			memset(&args, 0, sizeof(ide_task_t));
-			args.tfRegister[IDE_NSECTOR_OFFSET] = drive->mult_req;
-			args.tfRegister[IDE_COMMAND_OFFSET] = WIN_SETMULT;
-			args.command_type = IDE_DRIVE_TASK_NO_DATA;
-			args.handler	  = &set_multmode_intr;
-			do_rw_taskfile(drive, &args);
-		}
-	} else if (s->all) {
-		int special = s->all;
-		s->all = 0;
-		printk(KERN_ERR "%s: bad special flag: 0x%02x\n", drive->name, special);
-		return ide_stopped;
-	}
-	return IS_PDC4030_DRIVE ? ide_stopped : ide_started;
-}
-
-static void idedisk_pre_reset (ide_drive_t *drive)
-{
-	int legacy = (drive->id->cfs_enable_2 & 0x0400) ? 0 : 1;
-
-	drive->special.all = 0;
-	drive->special.b.set_geometry = legacy;
-	drive->special.b.recalibrate  = legacy;
-	if (OK_TO_RESET_CONTROLLER)
-		drive->mult_count = 0;
-	if (!drive->keep_settings && !drive->using_dma)
-		drive->mult_req = 0;
-	if (drive->mult_req != drive->mult_count)
-		drive->special.b.set_multmode = 1;
-}
-
 #ifdef CONFIG_PROC_FS

 static int smart_enable(ide_drive_t *drive)
@@ -893,28 +824,6 @@

 	printk(KERN_INFO "%s: max request size: %dKiB\n", drive->name, drive->queue->max_sectors / 2);

-	/* Extract geometry if we did not already have one for the drive */
-	if (!drive->cyl || !drive->head || !drive->sect) {
-		drive->cyl     = drive->bios_cyl  = id->cyls;
-		drive->head    = drive->bios_head = id->heads;
-		drive->sect    = drive->bios_sect = id->sectors;
-	}
-
-	/* Handle logical geometry translation by the drive */
-	if ((id->field_valid & 1) && id->cur_cyls &&
-	    id->cur_heads && (id->cur_heads <= 16) && id->cur_sectors) {
-		drive->cyl  = id->cur_cyls;
-		drive->head = id->cur_heads;
-		drive->sect = id->cur_sectors;
-	}
-
-	/* Use physical geometry if what we have still makes no sense */
-	if (drive->head > 16 && id->heads && id->heads <= 16) {
-		drive->cyl  = id->cyls;
-		drive->head = id->heads;
-		drive->sect = id->sectors;
-	}
-
 	/* calculate drive capacity, and select LBA if possible */
 	init_idedisk_capacity (drive);

@@ -978,21 +887,6 @@
 		ide_dma_verbose(drive);
 	printk("\n");

-	drive->mult_count = 0;
-	if (id->max_multsect) {
-#ifdef CONFIG_IDEDISK_MULTI_MODE
-		id->multsect = ((id->max_multsect/2) > 1) ? id->max_multsect : 0;
-		id->multsect_valid = id->multsect ? 1 : 0;
-		drive->mult_req = id->multsect_valid ? id->max_multsect : INITIAL_MULT_COUNT;
-		drive->special.b.set_multmode = drive->mult_req ? 1 : 0;
-#else	/* original, pre IDE-NFG, per request of AC */
-		drive->mult_req = INITIAL_MULT_COUNT;
-		if (drive->mult_req > id->max_multsect)
-			drive->mult_req = id->max_multsect;
-		if (drive->mult_req || ((id->multsect_valid & 1) && id->multsect))
-			drive->special.b.set_multmode = 1;
-#endif	/* CONFIG_IDEDISK_MULTI_MODE */
-	}
 	drive->no_io_32bit = id->dword_io ? 1 : 0;

 	/* write cache enabled? */
@@ -1091,9 +985,7 @@
 	.supports_dsc_overlap	= 0,
 	.cleanup		= idedisk_cleanup,
 	.do_request		= ide_do_rw_disk,
-	.pre_reset		= idedisk_pre_reset,
 	.capacity		= idedisk_capacity,
-	.special		= idedisk_special,
 	.proc			= idedisk_proc,
 	.attach			= idedisk_attach,
 	.drives			= LIST_HEAD_INIT(idedisk_driver.drives),
diff -Nru a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c	2005-01-21 23:53:42 +01:00
+++ b/drivers/ide/ide-io.c	2005-01-21 23:53:42 +01:00
@@ -754,6 +754,65 @@
 	return ide_stopped;
 }

+static void ide_init_specify_cmd(ide_drive_t *drive, ide_task_t *task)
+{
+	task->tfRegister[IDE_NSECTOR_OFFSET] = drive->sect;
+	task->tfRegister[IDE_SECTOR_OFFSET]  = drive->sect;
+	task->tfRegister[IDE_LCYL_OFFSET]    = drive->cyl;
+	task->tfRegister[IDE_HCYL_OFFSET]    = drive->cyl>>8;
+	task->tfRegister[IDE_SELECT_OFFSET]  = ((drive->head-1)|drive->select.all)&0xBF;
+	task->tfRegister[IDE_COMMAND_OFFSET] = WIN_SPECIFY;
+
+	task->handler = &set_geometry_intr;
+}
+
+static void ide_init_restore_cmd(ide_drive_t *drive, ide_task_t *task)
+{
+	task->tfRegister[IDE_NSECTOR_OFFSET] = drive->sect;
+	task->tfRegister[IDE_COMMAND_OFFSET] = WIN_RESTORE;
+
+	task->handler = &recal_intr;
+}
+
+static void ide_init_setmult_cmd(ide_drive_t *drive, ide_task_t *task)
+{
+	task->tfRegister[IDE_NSECTOR_OFFSET] = drive->mult_req;
+	task->tfRegister[IDE_COMMAND_OFFSET] = WIN_SETMULT;
+
+	task->handler = &set_multmode_intr;
+}
+
+static ide_startstop_t ide_disk_special(ide_drive_t *drive)
+{
+	special_t *s = &drive->special;
+	ide_task_t args;
+
+	memset(&args, 0, sizeof(ide_task_t));
+	args.command_type = IDE_DRIVE_TASK_NO_DATA;
+
+	if (s->b.set_geometry) {
+		s->b.set_geometry = 0;
+		ide_init_specify_cmd(drive, &args);
+	} else if (s->b.recalibrate) {
+		s->b.recalibrate = 0;
+		ide_init_restore_cmd(drive, &args);
+	} else if (s->b.set_multmode) {
+		s->b.set_multmode = 0;
+		if (drive->mult_req > drive->id->max_multsect)
+			drive->mult_req = drive->id->max_multsect;
+		ide_init_setmult_cmd(drive, &args);
+	} else if (s->all) {
+		int special = s->all;
+		s->all = 0;
+		printk(KERN_ERR "%s: bad special flag: 0x%02x\n", drive->name, special);
+		return ide_stopped;
+	}
+
+	do_rw_taskfile(drive, &args);
+
+	return ide_started;
+}
+
 /**
  *	do_special		-	issue some special commands
  *	@drive: drive the command is for
@@ -775,9 +834,14 @@
 		if (HWIF(drive)->tuneproc != NULL)
 			HWIF(drive)->tuneproc(drive, drive->tune_req);
 		return ide_stopped;
+	} else {
+		if (drive->media == ide_disk)
+			return ide_disk_special(drive);
+
+		s->all = 0;
+		drive->mult_req = 0;
+		return ide_stopped;
 	}
-	else
-		return DRIVER(drive)->special(drive);
 }

 void ide_map_sg(ide_drive_t *drive, struct request *rq)
diff -Nru a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
--- a/drivers/ide/ide-iops.c	2005-01-21 23:53:42 +01:00
+++ b/drivers/ide/ide-iops.c	2005-01-21 23:53:42 +01:00
@@ -1112,9 +1112,27 @@
 #endif
 }

+static void ide_disk_pre_reset(ide_drive_t *drive)
+{
+	int legacy = (drive->id->cfs_enable_2 & 0x0400) ? 0 : 1;
+
+	drive->special.all = 0;
+	drive->special.b.set_geometry = legacy;
+	drive->special.b.recalibrate  = legacy;
+	if (OK_TO_RESET_CONTROLLER)
+		drive->mult_count = 0;
+	if (!drive->keep_settings && !drive->using_dma)
+		drive->mult_req = 0;
+	if (drive->mult_req != drive->mult_count)
+		drive->special.b.set_multmode = 1;
+}
+
 void pre_reset (ide_drive_t *drive)
 {
-	DRIVER(drive)->pre_reset(drive);
+	if (drive->media == ide_disk)
+		ide_disk_pre_reset(drive);
+	else
+		drive->driver->pre_reset(drive);

 	if (!drive->keep_settings) {
 		if (drive->using_dma) {
diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	2005-01-21 23:53:42 +01:00
+++ b/drivers/ide/ide-probe.c	2005-01-21 23:53:42 +01:00
@@ -74,7 +74,55 @@
 	drive->id->cur_heads = drive->head;
 	drive->id->cur_sectors = drive->sect;
 }
-
+
+static void ide_disk_init_chs(ide_drive_t *drive)
+{
+	struct hd_driveid *id = drive->id;
+
+	/* Extract geometry if we did not already have one for the drive */
+	if (!drive->cyl || !drive->head || !drive->sect) {
+		drive->cyl  = drive->bios_cyl  = id->cyls;
+		drive->head = drive->bios_head = id->heads;
+		drive->sect = drive->bios_sect = id->sectors;
+	}
+
+	/* Handle logical geometry translation by the drive */
+	if ((id->field_valid & 1) && id->cur_cyls &&
+	    id->cur_heads && (id->cur_heads <= 16) && id->cur_sectors) {
+		drive->cyl  = id->cur_cyls;
+		drive->head = id->cur_heads;
+		drive->sect = id->cur_sectors;
+	}
+
+	/* Use physical geometry if what we have still makes no sense */
+	if (drive->head > 16 && id->heads && id->heads <= 16) {
+		drive->cyl  = id->cyls;
+		drive->head = id->heads;
+		drive->sect = id->sectors;
+	}
+}
+
+static void ide_disk_init_mult_count(ide_drive_t *drive)
+{
+	struct hd_driveid *id = drive->id;
+
+	drive->mult_count = 0;
+	if (id->max_multsect) {
+#ifdef CONFIG_IDEDISK_MULTI_MODE
+		id->multsect = ((id->max_multsect/2) > 1) ? id->max_multsect : 0;
+		id->multsect_valid = id->multsect ? 1 : 0;
+		drive->mult_req = id->multsect_valid ? id->max_multsect : INITIAL_MULT_COUNT;
+		drive->special.b.set_multmode = drive->mult_req ? 1 : 0;
+#else	/* original, pre IDE-NFG, per request of AC */
+		drive->mult_req = INITIAL_MULT_COUNT;
+		if (drive->mult_req > id->max_multsect)
+			drive->mult_req = id->max_multsect;
+		if (drive->mult_req || ((id->multsect_valid & 1) && id->multsect))
+			drive->special.b.set_multmode = 1;
+#endif
+	}
+}
+
 /**
  *	drive_is_flashcard	-	check for compact flash
  *	@drive: drive to check
@@ -590,8 +638,16 @@
 	if(!drive->present)
 		return 0;
 	/* The drive wasn't being helpful. Add generic info only */
-	if(!drive->id_read)
+	if (drive->id_read == 0) {
 		generic_id(drive);
+		return 1;
+	}
+
+	if (drive->media == ide_disk) {
+		ide_disk_init_chs(drive);
+		ide_disk_init_mult_count(drive);
+	}
+
 	return drive->present;
 }

diff -Nru a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
--- a/drivers/ide/ide-taskfile.c	2005-01-21 23:53:42 +01:00
+++ b/drivers/ide/ide-taskfile.c	2005-01-21 23:53:42 +01:00
@@ -181,8 +181,6 @@
 	return ide_stopped;
 }

-EXPORT_SYMBOL(set_multmode_intr);
-
 /*
  * set_geometry_intr() is invoked on completion of a WIN_SPECIFY cmd.
  */
@@ -207,8 +205,6 @@
 	return ide_started;
 }

-EXPORT_SYMBOL(set_geometry_intr);
-
 /*
  * recal_intr() is invoked on completion of a WIN_RESTORE (recalibrate) cmd.
  */
@@ -221,8 +217,6 @@
 		return ide_error(drive, "recal_intr", stat);
 	return ide_stopped;
 }
-
-EXPORT_SYMBOL(recal_intr);

 /*
  * Handler for commands without a data phase
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2005-01-21 23:53:42 +01:00
+++ b/drivers/ide/ide.c	2005-01-21 23:53:42 +01:00
@@ -2046,15 +2046,6 @@
 	return 0x7fffffff;
 }

-static ide_startstop_t default_special (ide_drive_t *drive)
-{
-	special_t *s = &drive->special;
-
-	s->all = 0;
-	drive->mult_req = 0;
-	return ide_stopped;
-}
-
 static ide_startstop_t default_abort(ide_drive_t *drive, struct request *rq)
 {
 	return __ide_abort(drive, rq);
@@ -2070,7 +2061,6 @@
 	if (d->abort == NULL)		d->abort = default_abort;
 	if (d->pre_reset == NULL)	d->pre_reset = default_pre_reset;
 	if (d->capacity == NULL)	d->capacity = default_capacity;
-	if (d->special == NULL)		d->special = default_special;
 }

 int ide_register_subdriver(ide_drive_t *drive, ide_driver_t *driver)
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	2005-01-21 23:53:42 +01:00
+++ b/include/linux/ide.h	2005-01-21 23:53:42 +01:00
@@ -1101,7 +1101,6 @@
 	int		(*ioctl)(ide_drive_t *, struct inode *, struct file *, unsigned int, unsigned long);
 	void		(*pre_reset)(ide_drive_t *);
 	sector_t	(*capacity)(ide_drive_t *);
-	ide_startstop_t	(*special)(ide_drive_t *);
 	ide_proc_entry_t	*proc;
 	int		(*attach)(ide_drive_t *);
 	void		(*ata_prebuilder)(ide_drive_t *);
