Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262580AbVAUXUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbVAUXUY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 18:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbVAUXTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 18:19:49 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:7085 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S262585AbVAUXJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 18:09:24 -0500
Date: Sat, 22 Jan 2005 00:05:03 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [ide-dev 3/5] generic Power Management for IDE devices
Message-ID: <Pine.GSO.4.58.0501220004050.23959@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Move PM code from ide-cd.c and ide-disk.c to IDE core so:
* PM is supported for other ATAPI devices (floppy, tape)
* PM is supported even if specific driver is not loaded

diff -Nru a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
--- a/drivers/ide/ide-cd.c	2005-01-21 23:53:31 +01:00
+++ b/drivers/ide/ide-cd.c	2005-01-21 23:53:31 +01:00
@@ -3251,45 +3251,6 @@

 static int ide_cdrom_attach (ide_drive_t *drive);

-/*
- * Power Management state machine.
- *
- * We don't do much for CDs right now.
- */
-
-static void ide_cdrom_complete_power_step (ide_drive_t *drive, struct request *rq, u8 stat, u8 error)
-{
-}
-
-static ide_startstop_t ide_cdrom_start_power_step (ide_drive_t *drive, struct request *rq)
-{
-	ide_task_t *args = rq->special;
-
-	memset(args, 0, sizeof(*args));
-
-	switch (rq->pm->pm_step) {
-	case ide_pm_state_start_suspend:
-		break;
-
-	case ide_pm_state_start_resume:	/* Resume step 1 (restore DMA) */
-		/*
-		 * Right now, all we do is call hwif->ide_dma_check(drive),
-		 * we could be smarter and check for current xfer_speed
-		 * in struct drive etc...
-		 * Also, this step could be implemented as a generic helper
-		 * as most subdrivers will use it.
-		 */
-		if ((drive->id->capability & 1) == 0)
-			break;
-		if (HWIF(drive)->ide_dma_check == NULL)
-			break;
-		HWIF(drive)->ide_dma_check(drive);
-		break;
-	}
-	rq->pm->pm_step = ide_pm_state_completed;
-	return ide_stopped;
-}
-
 static ide_driver_t ide_cdrom_driver = {
 	.owner			= THIS_MODULE,
 	.name			= "ide-cdrom",
@@ -3302,8 +3263,6 @@
 	.capacity		= ide_cdrom_capacity,
 	.attach			= ide_cdrom_attach,
 	.drives			= LIST_HEAD_INIT(ide_cdrom_driver.drives),
-	.start_power_step	= ide_cdrom_start_power_step,
-	.complete_power_step	= ide_cdrom_complete_power_step,
 };

 static int idecd_open(struct inode * inode, struct file * file)
diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	2005-01-21 23:53:31 +01:00
+++ b/drivers/ide/ide-disk.c	2005-01-21 23:53:31 +01:00
@@ -855,90 +855,6 @@
  	ide_add_setting(drive,	"max_failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->max_failures,		NULL);
 }

-/*
- * Power Management state machine. This one is rather trivial for now,
- * we should probably add more, like switching back to PIO on suspend
- * to help some BIOSes, re-do the door locking on resume, etc...
- */
-
-enum {
-	idedisk_pm_flush_cache	= ide_pm_state_start_suspend,
-	idedisk_pm_standby,
-
-	idedisk_pm_idle		= ide_pm_state_start_resume,
-	idedisk_pm_restore_dma,
-};
-
-static void idedisk_complete_power_step (ide_drive_t *drive, struct request *rq, u8 stat, u8 error)
-{
-	switch (rq->pm->pm_step) {
-	case idedisk_pm_flush_cache:	/* Suspend step 1 (flush cache) complete */
-		if (rq->pm->pm_state == 4)
-			rq->pm->pm_step = ide_pm_state_completed;
-		else
-			rq->pm->pm_step = idedisk_pm_standby;
-		break;
-	case idedisk_pm_standby:	/* Suspend step 2 (standby) complete */
-		rq->pm->pm_step = ide_pm_state_completed;
-		break;
-	case idedisk_pm_idle:		/* Resume step 1 (idle) complete */
-		rq->pm->pm_step = idedisk_pm_restore_dma;
-		break;
-	}
-}
-
-static ide_startstop_t idedisk_start_power_step (ide_drive_t *drive, struct request *rq)
-{
-	ide_task_t *args = rq->special;
-
-	memset(args, 0, sizeof(*args));
-
-	switch (rq->pm->pm_step) {
-	case idedisk_pm_flush_cache:	/* Suspend step 1 (flush cache) */
-		/* Not supported? Switch to next step now. */
-		if (!drive->wcache || !ide_id_has_flush_cache(drive->id)) {
-			idedisk_complete_power_step(drive, rq, 0, 0);
-			return ide_stopped;
-		}
-		if (ide_id_has_flush_cache_ext(drive->id))
-			args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE_EXT;
-		else
-			args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE;
-		args->command_type = IDE_DRIVE_TASK_NO_DATA;
-		args->handler	   = &task_no_data_intr;
-		return do_rw_taskfile(drive, args);
-
-	case idedisk_pm_standby:	/* Suspend step 2 (standby) */
-		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_STANDBYNOW1;
-		args->command_type = IDE_DRIVE_TASK_NO_DATA;
-		args->handler	   = &task_no_data_intr;
-		return do_rw_taskfile(drive, args);
-
-	case idedisk_pm_idle:		/* Resume step 1 (idle) */
-		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_IDLEIMMEDIATE;
-		args->command_type = IDE_DRIVE_TASK_NO_DATA;
-		args->handler = task_no_data_intr;
-		return do_rw_taskfile(drive, args);
-
-	case idedisk_pm_restore_dma:	/* Resume step 2 (restore DMA) */
-		/*
-		 * Right now, all we do is call hwif->ide_dma_check(drive),
-		 * we could be smarter and check for current xfer_speed
-		 * in struct drive etc...
-		 * Also, this step could be implemented as a generic helper
-		 * as most subdrivers will use it
-		 */
-		if ((drive->id->capability & 1) == 0)
-			break;
-		if (HWIF(drive)->ide_dma_check == NULL)
-			break;
-		HWIF(drive)->ide_dma_check(drive);
-		break;
-	}
-	rq->pm->pm_step = ide_pm_state_completed;
-	return ide_stopped;
-}
-
 static void idedisk_setup (ide_drive_t *drive)
 {
 	struct hd_driveid *id = drive->id;
@@ -1181,8 +1097,6 @@
 	.proc			= idedisk_proc,
 	.attach			= idedisk_attach,
 	.drives			= LIST_HEAD_INIT(idedisk_driver.drives),
-	.start_power_step	= idedisk_start_power_step,
-	.complete_power_step	= idedisk_complete_power_step,
 };

 static int idedisk_open(struct inode *inode, struct file *filp)
diff -Nru a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c	2005-01-21 23:53:31 +01:00
+++ b/drivers/ide/ide-io.c	2005-01-21 23:53:31 +01:00
@@ -189,6 +189,93 @@
 }
 EXPORT_SYMBOL(ide_end_request);

+/*
+ * Power Management state machine. This one is rather trivial for now,
+ * we should probably add more, like switching back to PIO on suspend
+ * to help some BIOSes, re-do the door locking on resume, etc...
+ */
+
+enum {
+	ide_pm_flush_cache	= ide_pm_state_start_suspend,
+	idedisk_pm_standby,
+
+	idedisk_pm_idle		= ide_pm_state_start_resume,
+	ide_pm_restore_dma,
+};
+
+static void ide_complete_power_step(ide_drive_t *drive, struct request *rq, u8 stat, u8 error)
+{
+	if (drive->media != ide_disk)
+		return;
+
+	switch (rq->pm->pm_step) {
+	case ide_pm_flush_cache:	/* Suspend step 1 (flush cache) complete */
+		if (rq->pm->pm_state == 4)
+			rq->pm->pm_step = ide_pm_state_completed;
+		else
+			rq->pm->pm_step = idedisk_pm_standby;
+		break;
+	case idedisk_pm_standby:	/* Suspend step 2 (standby) complete */
+		rq->pm->pm_step = ide_pm_state_completed;
+		break;
+	case idedisk_pm_idle:		/* Resume step 1 (idle) complete */
+		rq->pm->pm_step = ide_pm_restore_dma;
+		break;
+	}
+}
+
+static ide_startstop_t ide_start_power_step(ide_drive_t *drive, struct request *rq)
+{
+	ide_task_t *args = rq->special;
+
+	memset(args, 0, sizeof(*args));
+
+	switch (rq->pm->pm_step) {
+	case ide_pm_flush_cache:	/* Suspend step 1 (flush cache) */
+		if (drive->media != ide_disk)
+			break;
+		/* Not supported? Switch to next step now. */
+		if (!drive->wcache || !ide_id_has_flush_cache(drive->id)) {
+			ide_complete_power_step(drive, rq, 0, 0);
+			return ide_stopped;
+		}
+		if (ide_id_has_flush_cache_ext(drive->id))
+			args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE_EXT;
+		else
+			args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE;
+		args->command_type = IDE_DRIVE_TASK_NO_DATA;
+		args->handler	   = &task_no_data_intr;
+		return do_rw_taskfile(drive, args);
+
+	case idedisk_pm_standby:	/* Suspend step 2 (standby) */
+		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_STANDBYNOW1;
+		args->command_type = IDE_DRIVE_TASK_NO_DATA;
+		args->handler	   = &task_no_data_intr;
+		return do_rw_taskfile(drive, args);
+
+	case idedisk_pm_idle:		/* Resume step 1 (idle) */
+		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_IDLEIMMEDIATE;
+		args->command_type = IDE_DRIVE_TASK_NO_DATA;
+		args->handler = task_no_data_intr;
+		return do_rw_taskfile(drive, args);
+
+	case ide_pm_restore_dma:	/* Resume step 2 (restore DMA) */
+		/*
+		 * Right now, all we do is call hwif->ide_dma_check(drive),
+		 * we could be smarter and check for current xfer_speed
+		 * in struct drive etc...
+		 */
+		if ((drive->id->capability & 1) == 0)
+			break;
+		if (drive->hwif->ide_dma_check == NULL)
+			break;
+		drive->hwif->ide_dma_check(drive);
+		break;
+	}
+	rq->pm->pm_step = ide_pm_state_completed;
+	return ide_stopped;
+}
+
 /**
  *	ide_complete_pm_request - end the current Power Management request
  *	@drive: target drive
@@ -408,7 +495,7 @@
 		printk("%s: complete_power_step(step: %d, stat: %x, err: %x)\n",
 			drive->name, rq->pm->pm_step, stat, err);
 #endif
-		DRIVER(drive)->complete_power_step(drive, rq, stat, err);
+		ide_complete_power_step(drive, rq, stat, err);
 		if (rq->pm->pm_step == ide_pm_state_completed)
 			ide_complete_pm_request(drive, rq);
 		return;
@@ -905,7 +992,7 @@
 			printk("%s: start_power_step(step: %d)\n",
 				drive->name, rq->pm->pm_step);
 #endif
-			startstop = DRIVER(drive)->start_power_step(drive, rq);
+			startstop = ide_start_power_step(drive, rq);
 			if (startstop == ide_stopped &&
 			    rq->pm->pm_step == ide_pm_state_completed)
 				ide_complete_pm_request(drive, rq);
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2005-01-21 23:53:31 +01:00
+++ b/drivers/ide/ide.c	2005-01-21 23:53:31 +01:00
@@ -2060,13 +2060,6 @@
 	return __ide_abort(drive, rq);
 }

-static ide_startstop_t default_start_power_step(ide_drive_t *drive,
-						struct request *rq)
-{
-	rq->pm->pm_step = ide_pm_state_completed;
-	return ide_stopped;
-}
-
 static void setup_driver_defaults (ide_driver_t *d)
 {
 	BUG_ON(d->attach == NULL || d->cleanup == NULL);
@@ -2078,8 +2071,6 @@
 	if (d->pre_reset == NULL)	d->pre_reset = default_pre_reset;
 	if (d->capacity == NULL)	d->capacity = default_capacity;
 	if (d->special == NULL)		d->special = default_special;
-	if (d->start_power_step == NULL)
-		d->start_power_step = default_start_power_step;
 }

 int ide_register_subdriver(ide_drive_t *drive, ide_driver_t *driver)
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	2005-01-21 23:53:31 +01:00
+++ b/include/linux/ide.h	2005-01-21 23:53:31 +01:00
@@ -1106,8 +1106,6 @@
 	int		(*attach)(ide_drive_t *);
 	void		(*ata_prebuilder)(ide_drive_t *);
 	void		(*atapi_prebuilder)(ide_drive_t *);
-	ide_startstop_t	(*start_power_step)(ide_drive_t *, struct request *);
-	void		(*complete_power_step)(ide_drive_t *, struct request *, u8, u8);
 	struct device_driver	gen_driver;
 	struct list_head drives;
 	struct list_head drivers;
