Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262373AbVBXO4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbVBXO4Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 09:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbVBXOyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 09:54:46 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:51105 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S262362AbVBXOsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 09:48:03 -0500
Date: Thu, 24 Feb 2005 15:41:06 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
cc: Tejun Heo <htejun@gmail.com>
Subject: [patch ide-dev 4/9] add ide_task_init_flush() helper
Message-ID: <Pine.GSO.4.58.0502241540250.13534@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* add ide_task_init_flush() helper
* use it in do_idedisk_cacheflush() and ide_start_power_step()
* inline do_idedisk_cacheflush() into ide_cacheflush_p()

diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	2005-02-19 17:22:58 +01:00
+++ b/drivers/ide/ide-disk.c	2005-02-19 17:22:58 +01:00
@@ -723,24 +723,6 @@
 	return 0;
 }

-static int do_idedisk_flushcache (ide_drive_t *drive)
-{
-	ide_task_t args;
-	struct ata_taskfile *tf = &args.tf;
-
-	memset(&args, 0, sizeof(ide_task_t));
-
-	if (ide_id_has_flush_cache_ext(drive->id)) {
-		tf->command = WIN_FLUSH_CACHE_EXT;
-		tf->flags |= ATA_TFLAG_LBA48;
-	} else
-		tf->command = WIN_FLUSH_CACHE;
-
-	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
-	args.handler				= &task_no_data_intr;
-	return ide_raw_taskfile(drive, &args, NULL);
-}
-
 static int set_acoustic (ide_drive_t *drive, int arg)
 {
 	ide_task_t args;
@@ -931,10 +913,14 @@

 static void ide_cacheflush_p(ide_drive_t *drive)
 {
+	ide_task_t task;
+
 	if (!drive->wcache || !ide_id_has_flush_cache(drive->id))
 		return;

-	if (do_idedisk_flushcache(drive))
+	ide_task_init_flush(drive, &task);
+
+	if (ide_raw_taskfile(drive, &task, NULL))
 		printk(KERN_INFO "%s: wcache flush failed!\n", drive->name);
 }

diff -Nru a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c	2005-02-19 17:22:58 +01:00
+++ b/drivers/ide/ide-io.c	2005-02-19 17:22:58 +01:00
@@ -55,6 +55,24 @@
 #include <asm/io.h>
 #include <asm/bitops.h>

+void ide_task_init_flush(ide_drive_t *drive, ide_task_t *task)
+{
+	struct ata_taskfile *tf = &task->tf;
+
+	memset(task, 0, sizeof(*task));
+
+	if (ide_id_has_flush_cache_ext(drive->id)) {
+		tf->command = WIN_FLUSH_CACHE_EXT;
+		tf->flags |= ATA_TFLAG_LBA48;
+	} else
+		tf->command = WIN_FLUSH_CACHE;
+
+	task->command_type = IDE_DRIVE_TASK_NO_DATA;
+	task->handler	   = &task_no_data_intr;
+}
+
+EXPORT_SYMBOL_GPL(ide_task_init_flush);
+
 static void ide_fill_flush_cmd(ide_drive_t *drive, struct request *rq)
 {
 	char *buf = rq->cmd;
@@ -247,14 +265,8 @@
 			return ide_stopped;
 		}

-		if (ide_id_has_flush_cache_ext(drive->id)) {
-			tf->command = WIN_FLUSH_CACHE_EXT;
-			tf->flags |= ATA_TFLAG_LBA48;
-		} else
-			tf->command = WIN_FLUSH_CACHE;
+		ide_task_init_flush(drive, args);

-		args->command_type = IDE_DRIVE_TASK_NO_DATA;
-		args->handler	   = &task_no_data_intr;
 		return do_rw_taskfile(drive, args);

 	case idedisk_pm_standby:	/* Suspend step 2 (standby) */
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	2005-02-19 17:22:58 +01:00
+++ b/include/linux/ide.h	2005-02-19 17:22:58 +01:00
@@ -924,6 +924,19 @@
 typedef ide_startstop_t (ide_handler_t)(ide_drive_t *);
 typedef int (ide_expiry_t)(ide_drive_t *);

+typedef struct ide_task_s {
+	struct ata_taskfile	tf;
+	u16			data;
+	ide_reg_valid_t		tf_out_flags;
+	ide_reg_valid_t		tf_in_flags;
+	int			data_phase;
+	int			command_type;
+	ide_pre_handler_t	*prehandler;
+	ide_handler_t		*handler;
+	struct request		*rq;		/* copy of request */
+	void			*special;	/* valid_t generally */
+} ide_task_t;
+
 typedef struct hwgroup_s {
 		/* irq handler, if active */
 	ide_startstop_t	(*handler)(ide_drive_t *);
@@ -1189,6 +1202,8 @@
  */
 extern void ide_init_drive_cmd (struct request *rq);

+void ide_task_init_flush(ide_drive_t *, ide_task_t *);
+
 u64 ide_tf_get_address(struct ata_taskfile *);

 /*
@@ -1250,19 +1265,6 @@
  *  (ide_drive_t *drive, u8 cmd, u8 nsect, u8 feature, u8 sectors, u8 *buf)
  */
 extern int ide_wait_cmd(ide_drive_t *, u8, u8, u8, u8, u8 *);
-
-typedef struct ide_task_s {
-	struct ata_taskfile	tf;
-	u16			data;
-	ide_reg_valid_t		tf_out_flags;
-	ide_reg_valid_t		tf_in_flags;
-	int			data_phase;
-	int			command_type;
-	ide_pre_handler_t	*prehandler;
-	ide_handler_t		*handler;
-	struct request		*rq;		/* copy of request */
-	void			*special;	/* valid_t generally */
-} ide_task_t;

 extern u32 ide_read_24(ide_drive_t *);

