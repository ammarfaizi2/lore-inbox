Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbUCBVKA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 16:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbUCBVJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 16:09:59 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:30616 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261782AbUCBVHz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 16:07:55 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] IDE cleanups for 2.6.4-rc1 (2/3)
Date: Tue, 2 Mar 2004 22:15:07 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403022215.07385.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] remove ide_cmd_type_parser() logic

Set ide_task_t fields (command_type, handler and prehandler) directly.
Remove unused ide_task_t->posthandler and all ide_cmd_type_parser() logic.

ide_cmd_type_parser() was meant to be used for ioctls but
ended up checking validity of kernel generated requests (doh!).

Rationale for removal:
- it can't be used for existing ioctls (changes the way they work)
- kernel shouldn't check validity of (root only) user-space requests
  (it can and should be done in user-space)
- it wastes CPU cycles on going through parsers
- it makes code harder to understand/follow
  (now info about request is localized)

 linux-2.6.4-rc1-root/drivers/ide/ide-disk.c       |   79 +++--
 linux-2.6.4-rc1-root/drivers/ide/ide-taskfile.c   |  329 ----------------------
 linux-2.6.4-rc1-root/drivers/ide/ide-tcq.c        |   11 
 linux-2.6.4-rc1-root/drivers/ide/legacy/pdc4030.c |    9 
 linux-2.6.4-rc1-root/include/linux/ide.h          |   11 
 5 files changed, 63 insertions(+), 376 deletions(-)

diff -puN drivers/ide/ide-disk.c~ide_cmd_type_parser drivers/ide/ide-disk.c
--- linux-2.6.4-rc1/drivers/ide/ide-disk.c~ide_cmd_type_parser	2004-03-02 22:11:02.999670256 +0100
+++ linux-2.6.4-rc1-root/drivers/ide/ide-disk.c	2004-03-02 22:11:03.024666456 +0100
@@ -569,25 +569,35 @@ ide_startstop_t __ide_do_rw_disk (ide_dr
 }
 EXPORT_SYMBOL_GPL(__ide_do_rw_disk);
 
-static u8 get_command(ide_drive_t *drive, int cmd)
+static u8 get_command(ide_drive_t *drive, int cmd, ide_task_t *task)
 {
 	unsigned int lba48 = (drive->addressing == 1) ? 1 : 0;
 
 	if (cmd == READ) {
+		task->command_type = IDE_DRIVE_TASK_IN;
 		if (drive->using_tcq)
 			return lba48 ? WIN_READDMA_QUEUED_EXT : WIN_READDMA_QUEUED;
 		if (drive->using_dma)
 			return lba48 ? WIN_READDMA_EXT : WIN_READDMA;
-		if (drive->mult_count)
+		if (drive->mult_count) {
+			task->handler = &task_mulin_intr;
 			return lba48 ? WIN_MULTREAD_EXT : WIN_MULTREAD;
+		}
+		task->handler = &task_in_intr;
 		return lba48 ? WIN_READ_EXT : WIN_READ;
 	} else {
+		task->command_type = IDE_DRIVE_TASK_RAW_WRITE;
 		if (drive->using_tcq)
 			return lba48 ? WIN_WRITEDMA_QUEUED_EXT : WIN_WRITEDMA_QUEUED;
 		if (drive->using_dma)
 			return lba48 ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
-		if (drive->mult_count)
+		if (drive->mult_count) {
+			task->prehandler = &pre_task_mulout_intr;
+			task->handler = &task_mulout_intr;
 			return lba48 ? WIN_MULTWRITE_EXT : WIN_MULTWRITE;
+		}
+		task->prehandler = &pre_task_out_intr;
+		task->handler = &task_out_intr;
 		return lba48 ? WIN_WRITE_EXT : WIN_WRITE;
 	}
 }
@@ -597,7 +607,6 @@ static ide_startstop_t chs_rw_disk (ide_
 	ide_task_t		args;
 	int			sectors;
 	ata_nsector_t		nsectors;
-	task_ioreg_t command	= get_command(drive, rq_data_dir(rq));
 	unsigned int track	= (block / drive->sect);
 	unsigned int sect	= (block % drive->sect) + 1;
 	unsigned int head	= (track % drive->head);
@@ -627,8 +636,7 @@ static ide_startstop_t chs_rw_disk (ide_
 	args.tfRegister[IDE_HCYL_OFFSET]	= (cyl>>8);
 	args.tfRegister[IDE_SELECT_OFFSET]	= head;
 	args.tfRegister[IDE_SELECT_OFFSET]	|= drive->select.all;
-	args.tfRegister[IDE_COMMAND_OFFSET]	= command;
-	args.command_type			= ide_cmd_type_parser(&args);
+	args.tfRegister[IDE_COMMAND_OFFSET]	= get_command(drive, rq_data_dir(rq), &args);
 	args.rq					= (struct request *) rq;
 	rq->special				= (ide_task_t *)&args;
 	return do_rw_taskfile(drive, &args);
@@ -639,7 +647,6 @@ static ide_startstop_t lba_28_rw_disk (i
 	ide_task_t		args;
 	int			sectors;
 	ata_nsector_t		nsectors;
-	task_ioreg_t command	= get_command(drive, rq_data_dir(rq));
 
 	nsectors.all = (u16) rq->nr_sectors;
 
@@ -665,8 +672,7 @@ static ide_startstop_t lba_28_rw_disk (i
 	args.tfRegister[IDE_HCYL_OFFSET]	= (block>>=8);
 	args.tfRegister[IDE_SELECT_OFFSET]	= ((block>>8)&0x0f);
 	args.tfRegister[IDE_SELECT_OFFSET]	|= drive->select.all;
-	args.tfRegister[IDE_COMMAND_OFFSET]	= command;
-	args.command_type			= ide_cmd_type_parser(&args);
+	args.tfRegister[IDE_COMMAND_OFFSET]	= get_command(drive, rq_data_dir(rq), &args);
 	args.rq					= (struct request *) rq;
 	rq->special				= (ide_task_t *)&args;
 	return do_rw_taskfile(drive, &args);
@@ -683,7 +689,6 @@ static ide_startstop_t lba_48_rw_disk (i
 	ide_task_t		args;
 	int			sectors;
 	ata_nsector_t		nsectors;
-	task_ioreg_t command	= get_command(drive, rq_data_dir(rq));
 
 	nsectors.all = (u16) rq->nr_sectors;
 
@@ -712,13 +717,12 @@ static ide_startstop_t lba_48_rw_disk (i
 	args.tfRegister[IDE_LCYL_OFFSET]	= (block>>=8);	/* mid lba */
 	args.tfRegister[IDE_HCYL_OFFSET]	= (block>>=8);	/* hi  lba */
 	args.tfRegister[IDE_SELECT_OFFSET]	= drive->select.all;
-	args.tfRegister[IDE_COMMAND_OFFSET]	= command;
+	args.tfRegister[IDE_COMMAND_OFFSET]	= get_command(drive, rq_data_dir(rq), &args);
 	args.hobRegister[IDE_SECTOR_OFFSET_HOB]	= (block>>=8);	/* low lba */
 	args.hobRegister[IDE_LCYL_OFFSET_HOB]	= (block>>=8);	/* mid lba */
 	args.hobRegister[IDE_HCYL_OFFSET_HOB]	= (block>>=8);	/* hi  lba */
 	args.hobRegister[IDE_SELECT_OFFSET_HOB]	= drive->select.all;
 	args.hobRegister[IDE_CONTROL_OFFSET_HOB]= (drive->ctl|0x80);
-	args.command_type			= ide_cmd_type_parser(&args);
 	args.rq					= (struct request *) rq;
 	rq->special				= (ide_task_t *)&args;
 	return do_rw_taskfile(drive, &args);
@@ -926,7 +930,8 @@ static unsigned long idedisk_read_native
 	memset(&args, 0, sizeof(ide_task_t));
 	args.tfRegister[IDE_SELECT_OFFSET]	= 0x40;
 	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_READ_NATIVE_MAX;
-	args.command_type			= ide_cmd_type_parser(&args);
+	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
+	args.handler				= &task_no_data_intr;
 	/* submit command request */
 	ide_raw_taskfile(drive, &args, NULL);
 
@@ -951,7 +956,8 @@ static unsigned long long idedisk_read_n
 
 	args.tfRegister[IDE_SELECT_OFFSET]	= 0x40;
 	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_READ_NATIVE_MAX_EXT;
-	args.command_type			= ide_cmd_type_parser(&args);
+	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
+	args.handler				= &task_no_data_intr;
         /* submit command request */
         ide_raw_taskfile(drive, &args, NULL);
 
@@ -987,7 +993,8 @@ static unsigned long idedisk_set_max_add
 	args.tfRegister[IDE_HCYL_OFFSET]	= ((addr_req >> 16) & 0xff);
 	args.tfRegister[IDE_SELECT_OFFSET]	= ((addr_req >> 24) & 0x0f) | 0x40;
 	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SET_MAX;
-	args.command_type			= ide_cmd_type_parser(&args);
+	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
+	args.handler				= &task_no_data_intr;
 	/* submit command request */
 	ide_raw_taskfile(drive, &args, NULL);
 	/* if OK, read new maximum address value */
@@ -1019,7 +1026,8 @@ static unsigned long long idedisk_set_ma
 	args.hobRegister[IDE_HCYL_OFFSET_HOB]	= ((addr_req >>= 8) & 0xff);
 	args.hobRegister[IDE_SELECT_OFFSET_HOB]	= 0x40;
 	args.hobRegister[IDE_CONTROL_OFFSET_HOB]= (drive->ctl|0x80);
-	args.command_type			= ide_cmd_type_parser(&args);
+	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
+	args.handler				= &task_no_data_intr;
 	/* submit command request */
 	ide_raw_taskfile(drive, &args, NULL);
 	/* if OK, compute maximum address value */
@@ -1157,7 +1165,8 @@ static ide_startstop_t idedisk_special (
 			args.tfRegister[IDE_HCYL_OFFSET]    = drive->cyl>>8;
 			args.tfRegister[IDE_SELECT_OFFSET]  = ((drive->head-1)|drive->select.all)&0xBF;
 			args.tfRegister[IDE_COMMAND_OFFSET] = WIN_SPECIFY;
-			args.command_type = ide_cmd_type_parser(&args);
+			args.command_type = IDE_DRIVE_TASK_NO_DATA;
+			args.handler	  = &set_geometry_intr;
 			do_rw_taskfile(drive, &args);
 		}
 	} else if (s->b.recalibrate) {
@@ -1167,7 +1176,8 @@ static ide_startstop_t idedisk_special (
 			memset(&args, 0, sizeof(ide_task_t));
 			args.tfRegister[IDE_NSECTOR_OFFSET] = drive->sect;
 			args.tfRegister[IDE_COMMAND_OFFSET] = WIN_RESTORE;
-			args.command_type = ide_cmd_type_parser(&args);
+			args.command_type = IDE_DRIVE_TASK_NO_DATA;
+			args.handler	  = &recal_intr;
 			do_rw_taskfile(drive, &args);
 		}
 	} else if (s->b.set_multmode) {
@@ -1179,7 +1189,8 @@ static ide_startstop_t idedisk_special (
 			memset(&args, 0, sizeof(ide_task_t));
 			args.tfRegister[IDE_NSECTOR_OFFSET] = drive->mult_req;
 			args.tfRegister[IDE_COMMAND_OFFSET] = WIN_SETMULT;
-			args.command_type = ide_cmd_type_parser(&args);
+			args.command_type = IDE_DRIVE_TASK_NO_DATA;
+			args.handler	  = &set_multmode_intr;
 			do_rw_taskfile(drive, &args);
 		}
 	} else if (s->all) {
@@ -1217,7 +1228,8 @@ static int smart_enable(ide_drive_t *dri
 	args.tfRegister[IDE_LCYL_OFFSET]	= SMART_LCYL_PASS;
 	args.tfRegister[IDE_HCYL_OFFSET]	= SMART_HCYL_PASS;
 	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SMART;
-	args.command_type			= ide_cmd_type_parser(&args);
+	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
+	args.handler				= &task_no_data_intr;
 	return ide_raw_taskfile(drive, &args, NULL);
 }
 
@@ -1231,7 +1243,8 @@ static int get_smart_values(ide_drive_t 
 	args.tfRegister[IDE_LCYL_OFFSET]	= SMART_LCYL_PASS;
 	args.tfRegister[IDE_HCYL_OFFSET]	= SMART_HCYL_PASS;
 	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SMART;
-	args.command_type			= ide_cmd_type_parser(&args);
+	args.command_type			= IDE_DRIVE_TASK_IN;
+	args.handler				= &task_in_intr;
 	(void) smart_enable(drive);
 	return ide_raw_taskfile(drive, &args, buf);
 }
@@ -1245,7 +1258,8 @@ static int get_smart_thresholds(ide_driv
 	args.tfRegister[IDE_LCYL_OFFSET]	= SMART_LCYL_PASS;
 	args.tfRegister[IDE_HCYL_OFFSET]	= SMART_HCYL_PASS;
 	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SMART;
-	args.command_type			= ide_cmd_type_parser(&args);
+	args.command_type			= IDE_DRIVE_TASK_IN;
+	args.handler				= &task_in_intr;
 	(void) smart_enable(drive);
 	return ide_raw_taskfile(drive, &args, buf);
 }
@@ -1355,7 +1369,8 @@ static int write_cache (ide_drive_t *dri
 	args.tfRegister[IDE_FEATURE_OFFSET]	= (arg) ?
 			SETFEATURES_EN_WCACHE : SETFEATURES_DIS_WCACHE;
 	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SETFEATURES;
-	args.command_type			= ide_cmd_type_parser(&args);
+	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
+	args.handler				= &task_no_data_intr;
 	(void) ide_raw_taskfile(drive, &args, NULL);
 
 	drive->wcache = arg;
@@ -1371,7 +1386,8 @@ static int do_idedisk_flushcache (ide_dr
 		args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_FLUSH_CACHE_EXT;
 	else
 		args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_FLUSH_CACHE;
-	args.command_type	 		= ide_cmd_type_parser(&args);
+	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
+	args.handler				= &task_no_data_intr;
 	return ide_raw_taskfile(drive, &args, NULL);
 }
 
@@ -1384,7 +1400,8 @@ static int set_acoustic (ide_drive_t *dr
 							  SETFEATURES_DIS_AAM;
 	args.tfRegister[IDE_NSECTOR_OFFSET]	= arg;
 	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SETFEATURES;
-	args.command_type = ide_cmd_type_parser(&args);
+	args.command_type = IDE_DRIVE_TASK_NO_DATA;
+	args.handler	  = &task_no_data_intr;
 	ide_raw_taskfile(drive, &args, NULL);
 	drive->acoustic = arg;
 	return 0;
@@ -1503,11 +1520,13 @@ static ide_startstop_t idedisk_start_pow
 			args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE_EXT;
 		else
 			args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE;
-		args->command_type = ide_cmd_type_parser(args);
+		args->command_type = IDE_DRIVE_TASK_NO_DATA;
+		args->handler	   = &task_no_data_intr;
 		return do_rw_taskfile(drive, args);
 	case idedisk_pm_standby:	/* Suspend step 2 (standby) */
 		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_STANDBYNOW1;
-		args->command_type = ide_cmd_type_parser(args);
+		args->command_type = IDE_DRIVE_TASK_NO_DATA;
+		args->handler	   = &task_no_data_intr;
 		return do_rw_taskfile(drive, args);
 
 	case idedisk_pm_restore_dma:	/* Resume step 1 (restore DMA) */
@@ -1715,7 +1734,8 @@ static int idedisk_open(struct inode *in
 		u8 cf;
 		memset(&args, 0, sizeof(ide_task_t));
 		args.tfRegister[IDE_COMMAND_OFFSET] = WIN_DOORLOCK;
-		args.command_type = ide_cmd_type_parser(&args);
+		args.command_type = IDE_DRIVE_TASK_NO_DATA;
+		args.handler	  = &task_no_data_intr;
 		check_disk_change(inode->i_bdev);
 		/*
 		 * Ignore the return code from door_lock,
@@ -1761,7 +1781,8 @@ static int idedisk_release(struct inode 
 		ide_task_t args;
 		memset(&args, 0, sizeof(ide_task_t));
 		args.tfRegister[IDE_COMMAND_OFFSET] = WIN_DOORUNLOCK;
-		args.command_type = ide_cmd_type_parser(&args);
+		args.command_type = IDE_DRIVE_TASK_NO_DATA;
+		args.handler	  = &task_no_data_intr;
 		if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
 			drive->doorlocking = 0;
 	}
diff -puN drivers/ide/ide-taskfile.c~ide_cmd_type_parser drivers/ide/ide-taskfile.c
--- linux-2.6.4-rc1/drivers/ide/ide-taskfile.c~ide_cmd_type_parser	2004-03-02 22:11:03.009668736 +0100
+++ linux-2.6.4-rc1-root/drivers/ide/ide-taskfile.c	2004-03-02 22:11:03.026666152 +0100
@@ -101,7 +101,8 @@ int taskfile_lib_get_identify (ide_drive
 		args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_IDENTIFY;
 	else
 		args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_PIDENTIFY;
-	args.command_type			= ide_cmd_type_parser(&args);
+	args.command_type = IDE_DRIVE_TASK_IN;
+	args.handler	  = &task_in_intr;
 	return ide_raw_taskfile(drive, &args, buf);
 }
 
@@ -990,320 +991,6 @@ EXPORT_SYMBOL(pre_task_mulout_intr);
 
 #endif /* !CONFIG_IDE_TASKFILE_IO */
 
-/* Called by internal to feature out type of command being called */
-//ide_pre_handler_t * ide_pre_handler_parser (task_struct_t *taskfile, hob_struct_t *hobfile)
-ide_pre_handler_t * ide_pre_handler_parser (struct hd_drive_task_hdr *taskfile, struct hd_drive_hob_hdr *hobfile)
-{
-	switch(taskfile->command) {
-				/* IDE_DRIVE_TASK_RAW_WRITE */
-		case CFA_WRITE_MULTI_WO_ERASE:
-	//	case WIN_WRITE_LONG:
-	//	case WIN_WRITE_LONG_ONCE:
-		case WIN_MULTWRITE:
-		case WIN_MULTWRITE_EXT:
-			return &pre_task_mulout_intr;
-			
-				/* IDE_DRIVE_TASK_OUT */
-		case WIN_WRITE:
-	//	case WIN_WRITE_ONCE:
-		case WIN_WRITE_EXT:
-		case WIN_WRITE_VERIFY:
-		case WIN_WRITE_BUFFER:
-		case CFA_WRITE_SECT_WO_ERASE:
-		case WIN_DOWNLOAD_MICROCODE:
-			return &pre_task_out_intr;
-				/* IDE_DRIVE_TASK_OUT */
-		case WIN_SMART:
-			if (taskfile->feature == SMART_WRITE_LOG_SECTOR)
-				return &pre_task_out_intr;
-		case WIN_WRITEDMA:
-	//	case WIN_WRITEDMA_ONCE:
-		case WIN_WRITEDMA_QUEUED:
-		case WIN_WRITEDMA_EXT:
-		case WIN_WRITEDMA_QUEUED_EXT:
-				/* IDE_DRIVE_TASK_OUT */
-		default:
-			break;
-	}
-	return(NULL);
-}
-
-EXPORT_SYMBOL(ide_pre_handler_parser);
-
-/* Called by internal to feature out type of command being called */
-//ide_handler_t * ide_handler_parser (task_struct_t *taskfile, hob_struct_t *hobfile)
-ide_handler_t * ide_handler_parser (struct hd_drive_task_hdr *taskfile, struct hd_drive_hob_hdr *hobfile)
-{
-	switch(taskfile->command) {
-		case WIN_IDENTIFY:
-		case WIN_PIDENTIFY:
-		case CFA_TRANSLATE_SECTOR:
-		case WIN_READ_BUFFER:
-		case WIN_READ:
-	//	case WIN_READ_ONCE:
-		case WIN_READ_EXT:
-			return &task_in_intr;
-		case WIN_SECURITY_DISABLE:
-		case WIN_SECURITY_ERASE_UNIT:
-		case WIN_SECURITY_SET_PASS:
-		case WIN_SECURITY_UNLOCK:
-		case WIN_DOWNLOAD_MICROCODE:
-		case CFA_WRITE_SECT_WO_ERASE:
-		case WIN_WRITE_BUFFER:
-		case WIN_WRITE_VERIFY:
-		case WIN_WRITE:
-	//	case WIN_WRITE_ONCE:	
-		case WIN_WRITE_EXT:
-			return &task_out_intr;
-	//	case WIN_READ_LONG:
-	//	case WIN_READ_LONG_ONCE:
-		case WIN_MULTREAD:
-		case WIN_MULTREAD_EXT:
-			return &task_mulin_intr;
-	//	case WIN_WRITE_LONG:
-	//	case WIN_WRITE_LONG_ONCE:
-		case CFA_WRITE_MULTI_WO_ERASE:
-		case WIN_MULTWRITE:
-		case WIN_MULTWRITE_EXT:
-			return &task_mulout_intr;
-		case WIN_SMART:
-			switch(taskfile->feature) {
-				case SMART_READ_VALUES:
-				case SMART_READ_THRESHOLDS:
-				case SMART_READ_LOG_SECTOR:
-					return &task_in_intr;
-				case SMART_WRITE_LOG_SECTOR:
-					return &task_out_intr;
-				default:
-					return &task_no_data_intr;
-			}
-		case CFA_REQ_EXT_ERROR_CODE:
-		case CFA_ERASE_SECTORS:
-		case WIN_VERIFY:
-	//	case WIN_VERIFY_ONCE:
-		case WIN_VERIFY_EXT:
-		case WIN_SEEK:
-			return &task_no_data_intr;
-		case WIN_SPECIFY:
-			return &set_geometry_intr;
-		case WIN_RECAL:
-	//	case WIN_RESTORE:
-			return &recal_intr;
-		case WIN_NOP:
-		case WIN_DIAGNOSE:
-		case WIN_FLUSH_CACHE:
-		case WIN_FLUSH_CACHE_EXT:
-		case WIN_STANDBYNOW1:
-		case WIN_STANDBYNOW2:
-		case WIN_SLEEPNOW1:
-		case WIN_SLEEPNOW2:
-		case WIN_SETIDLE1:
-		case WIN_CHECKPOWERMODE1:
-		case WIN_CHECKPOWERMODE2:
-		case WIN_GETMEDIASTATUS:
-		case WIN_MEDIAEJECT:
-			return &task_no_data_intr;
-		case WIN_SETMULT:
-			return &set_multmode_intr;
-		case WIN_READ_NATIVE_MAX:
-		case WIN_SET_MAX:
-		case WIN_READ_NATIVE_MAX_EXT:
-		case WIN_SET_MAX_EXT:
-		case WIN_SECURITY_ERASE_PREPARE:
-		case WIN_SECURITY_FREEZE_LOCK:
-		case WIN_DOORLOCK:
-		case WIN_DOORUNLOCK:
-		case WIN_SETFEATURES:
-			return &task_no_data_intr;
-		case DISABLE_SEAGATE:
-		case EXABYTE_ENABLE_NEST:
-			return &task_no_data_intr;
-		case WIN_READDMA:
-	//	case WIN_READDMA_ONCE:
-		case WIN_IDENTIFY_DMA:
-		case WIN_READDMA_QUEUED:
-		case WIN_READDMA_EXT:
-		case WIN_READDMA_QUEUED_EXT:
-		case WIN_WRITEDMA:
-	//	case WIN_WRITEDMA_ONCE:
-		case WIN_WRITEDMA_QUEUED:
-		case WIN_WRITEDMA_EXT:
-		case WIN_WRITEDMA_QUEUED_EXT:
-		case WIN_FORMAT:
-		case WIN_INIT:
-		case WIN_DEVICE_RESET:
-		case WIN_QUEUED_SERVICE:
-		case WIN_PACKETCMD:
-		default:
-			return(NULL);
-	}	
-}
-
-EXPORT_SYMBOL(ide_handler_parser);
-
-ide_post_handler_t * ide_post_handler_parser (struct hd_drive_task_hdr *taskfile, struct hd_drive_hob_hdr *hobfile)
-{
-	switch(taskfile->command) {
-		case WIN_SPECIFY:	/* set_geometry_intr */
-		case WIN_RESTORE:	/* recal_intr */
-		case WIN_SETMULT:	/* set_multmode_intr */
-		default:
-			return(NULL);
-	}
-}
-
-EXPORT_SYMBOL(ide_post_handler_parser);
-
-/* Called by ioctl to feature out type of command being called */
-int ide_cmd_type_parser (ide_task_t *args)
-{
-
-	task_struct_t *taskfile = (task_struct_t *) args->tfRegister;
-	hob_struct_t *hobfile   = (hob_struct_t *) args->hobRegister;
-
-	args->prehandler	= ide_pre_handler_parser(taskfile, hobfile);
-	args->handler		= ide_handler_parser(taskfile, hobfile);
-	args->posthandler	= ide_post_handler_parser(taskfile, hobfile);
-
-	switch(args->tfRegister[IDE_COMMAND_OFFSET]) {
-		case WIN_IDENTIFY:
-		case WIN_PIDENTIFY:
-			return IDE_DRIVE_TASK_IN;
-		case CFA_TRANSLATE_SECTOR:
-		case WIN_READ:
-	//	case WIN_READ_ONCE:
-		case WIN_READ_EXT:
-		case WIN_READ_BUFFER:
-			return IDE_DRIVE_TASK_IN;
-		case WIN_WRITE:
-	//	case WIN_WRITE_ONCE:
-		case WIN_WRITE_EXT:
-		case WIN_WRITE_VERIFY:
-		case WIN_WRITE_BUFFER:
-		case CFA_WRITE_SECT_WO_ERASE:
-		case WIN_DOWNLOAD_MICROCODE:
-			return IDE_DRIVE_TASK_RAW_WRITE;
-	//	case WIN_READ_LONG:
-	//	case WIN_READ_LONG_ONCE:
-		case WIN_MULTREAD:
-		case WIN_MULTREAD_EXT:
-			return IDE_DRIVE_TASK_IN;
-	//	case WIN_WRITE_LONG:
-	//	case WIN_WRITE_LONG_ONCE:
-		case CFA_WRITE_MULTI_WO_ERASE:
-		case WIN_MULTWRITE:
-		case WIN_MULTWRITE_EXT:
-			return IDE_DRIVE_TASK_RAW_WRITE;
-		case WIN_SECURITY_DISABLE:
-		case WIN_SECURITY_ERASE_UNIT:
-		case WIN_SECURITY_SET_PASS:
-		case WIN_SECURITY_UNLOCK:
-			return IDE_DRIVE_TASK_OUT;
-		case WIN_SMART:
-			args->tfRegister[IDE_LCYL_OFFSET] = SMART_LCYL_PASS;
-			args->tfRegister[IDE_HCYL_OFFSET] = SMART_HCYL_PASS;
-			switch(args->tfRegister[IDE_FEATURE_OFFSET]) {
-				case SMART_READ_VALUES:
-				case SMART_READ_THRESHOLDS:
-				case SMART_READ_LOG_SECTOR:
-					return IDE_DRIVE_TASK_IN;
-				case SMART_WRITE_LOG_SECTOR:
-					return IDE_DRIVE_TASK_OUT;
-				default:
-					return IDE_DRIVE_TASK_NO_DATA;
-			}
-		case WIN_READDMA:
-	//	case WIN_READDMA_ONCE:
-		case WIN_IDENTIFY_DMA:
-		case WIN_READDMA_QUEUED:
-		case WIN_READDMA_EXT:
-		case WIN_READDMA_QUEUED_EXT:
-			return IDE_DRIVE_TASK_IN;
-		case WIN_WRITEDMA:
-	//	case WIN_WRITEDMA_ONCE:
-		case WIN_WRITEDMA_QUEUED:
-		case WIN_WRITEDMA_EXT:
-		case WIN_WRITEDMA_QUEUED_EXT:
-			return IDE_DRIVE_TASK_RAW_WRITE;
-		case WIN_SETFEATURES:
-			switch(args->tfRegister[IDE_FEATURE_OFFSET]) {
-				case SETFEATURES_EN_8BIT:
-				case SETFEATURES_EN_WCACHE:
-					return IDE_DRIVE_TASK_NO_DATA;
-				case SETFEATURES_XFER:
-					return IDE_DRIVE_TASK_SET_XFER;
-				case SETFEATURES_DIS_DEFECT:
-				case SETFEATURES_EN_APM:
-				case SETFEATURES_DIS_MSN:
-				case SETFEATURES_DIS_RETRY:
-				case SETFEATURES_EN_AAM:
-				case SETFEATURES_RW_LONG:
-				case SETFEATURES_SET_CACHE:
-				case SETFEATURES_DIS_RLA:
-				case SETFEATURES_EN_RI:
-				case SETFEATURES_EN_SI:
-				case SETFEATURES_DIS_RPOD:
-				case SETFEATURES_DIS_WCACHE:
-				case SETFEATURES_EN_DEFECT:
-				case SETFEATURES_DIS_APM:
-				case SETFEATURES_EN_ECC:
-				case SETFEATURES_EN_MSN:
-				case SETFEATURES_EN_RETRY:
-				case SETFEATURES_EN_RLA:
-				case SETFEATURES_PREFETCH:
-				case SETFEATURES_4B_RW_LONG:
-				case SETFEATURES_DIS_AAM:
-				case SETFEATURES_EN_RPOD:
-				case SETFEATURES_DIS_RI:
-				case SETFEATURES_DIS_SI:
-				default:
-					return IDE_DRIVE_TASK_NO_DATA;
-			}
-		case WIN_NOP:
-		case CFA_REQ_EXT_ERROR_CODE:
-		case CFA_ERASE_SECTORS:
-		case WIN_VERIFY:
-	//	case WIN_VERIFY_ONCE:
-		case WIN_VERIFY_EXT:
-		case WIN_SEEK:
-		case WIN_SPECIFY:
-		case WIN_RESTORE:
-		case WIN_DIAGNOSE:
-		case WIN_FLUSH_CACHE:
-		case WIN_FLUSH_CACHE_EXT:
-		case WIN_STANDBYNOW1:
-		case WIN_STANDBYNOW2:
-		case WIN_SLEEPNOW1:
-		case WIN_SLEEPNOW2:
-		case WIN_SETIDLE1:
-		case DISABLE_SEAGATE:
-		case WIN_CHECKPOWERMODE1:
-		case WIN_CHECKPOWERMODE2:
-		case WIN_GETMEDIASTATUS:
-		case WIN_MEDIAEJECT:
-		case WIN_SETMULT:
-		case WIN_READ_NATIVE_MAX:
-		case WIN_SET_MAX:
-		case WIN_READ_NATIVE_MAX_EXT:
-		case WIN_SET_MAX_EXT:
-		case WIN_SECURITY_ERASE_PREPARE:
-		case WIN_SECURITY_FREEZE_LOCK:
-		case EXABYTE_ENABLE_NEST:
-		case WIN_DOORLOCK:
-		case WIN_DOORUNLOCK:
-			return IDE_DRIVE_TASK_NO_DATA;
-		case WIN_FORMAT:
-		case WIN_INIT:
-		case WIN_DEVICE_RESET:
-		case WIN_QUEUED_SERVICE:
-		case WIN_PACKETCMD:
-		default:
-			return IDE_DRIVE_TASK_INVALID;
-	}
-}
-
-EXPORT_SYMBOL(ide_cmd_type_parser);
-
 /*
  * This function is intended to be used prior to invoking ide_do_drive_cmd().
  */
@@ -1339,16 +1026,6 @@ int ide_diag_taskfile (ide_drive_t *driv
 		rq.hard_cur_sectors = rq.current_nr_sectors = rq.nr_sectors;
 	}
 
-	if (args->tf_out_flags.all == 0) {
-		/*
-		 * clean up kernel settings for driver sanity, regardless.
-		 * except for discrete diag services.
-		 */
-		args->posthandler = ide_post_handler_parser(
-				(struct hd_drive_task_hdr *) args->tfRegister,
-				(struct hd_drive_hob_hdr *) args->hobRegister);
-
-	}
 	rq.special = args;
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
@@ -1451,11 +1128,9 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 #if 0
 			args.prehandler = &pre_task_out_intr;
 			args.handler = &task_out_intr;
-			args.posthandler = NULL;
 			err = ide_diag_taskfile(drive, &args, taskout, outbuf);
 			args.prehandler = NULL;
 			args.handler = &task_in_intr;
-			args.posthandler = NULL;
 			err = ide_diag_taskfile(drive, &args, taskin, inbuf);
 			break;
 #else
diff -puN drivers/ide/ide-tcq.c~ide_cmd_type_parser drivers/ide/ide-tcq.c
--- linux-2.6.4-rc1/drivers/ide/ide-tcq.c~ide_cmd_type_parser	2004-03-02 22:11:03.013668128 +0100
+++ linux-2.6.4-rc1-root/drivers/ide/ide-tcq.c	2004-03-02 22:11:03.027666000 +0100
@@ -483,7 +483,7 @@ static int ide_tcq_check_autopoll(ide_dr
 
 	args->tfRegister[IDE_FEATURE_OFFSET] = 0x01;
 	args->tfRegister[IDE_COMMAND_OFFSET] = WIN_NOP;
-	args->command_type = ide_cmd_type_parser(args);
+	args->command_type = IDE_DRIVE_TASK_NO_DATA;
 	args->handler = ide_tcq_nop_handler;
 	return ide_raw_taskfile(drive, args, NULL);
 }
@@ -513,7 +513,8 @@ static int ide_tcq_configure(ide_drive_t
 	memset(args, 0, sizeof(ide_task_t));
 	args->tfRegister[IDE_COMMAND_OFFSET] = WIN_SETFEATURES;
 	args->tfRegister[IDE_FEATURE_OFFSET] = SETFEATURES_EN_WCACHE;
-	args->command_type = ide_cmd_type_parser(args);
+	args->command_type = IDE_DRIVE_TASK_NO_DATA;
+	args->handler	   = &task_no_data_intr;
 
 	if (ide_raw_taskfile(drive, args, NULL)) {
 		printk(KERN_WARNING "%s: failed to enable write cache\n", drive->name);
@@ -527,7 +528,8 @@ static int ide_tcq_configure(ide_drive_t
 	memset(args, 0, sizeof(ide_task_t));
 	args->tfRegister[IDE_COMMAND_OFFSET] = WIN_SETFEATURES;
 	args->tfRegister[IDE_FEATURE_OFFSET] = SETFEATURES_DIS_RI;
-	args->command_type = ide_cmd_type_parser(args);
+	args->command_type = IDE_DRIVE_TASK_NO_DATA;
+	args->handler	   = &task_no_data_intr;
 
 	if (ide_raw_taskfile(drive, args, NULL)) {
 		printk(KERN_ERR "%s: disabling release interrupt fail\n", drive->name);
@@ -541,7 +543,8 @@ static int ide_tcq_configure(ide_drive_t
 	memset(args, 0, sizeof(ide_task_t));
 	args->tfRegister[IDE_COMMAND_OFFSET] = WIN_SETFEATURES;
 	args->tfRegister[IDE_FEATURE_OFFSET] = SETFEATURES_EN_SI;
-	args->command_type = ide_cmd_type_parser(args);
+	args->command_type = IDE_DRIVE_TASK_NO_DATA;
+	args->handler	   = &task_no_data_intr;
 
 	if (ide_raw_taskfile(drive, args, NULL)) {
 		printk(KERN_ERR "%s: enabling service interrupt fail\n", drive->name);
diff -puN drivers/ide/legacy/pdc4030.c~ide_cmd_type_parser drivers/ide/legacy/pdc4030.c
--- linux-2.6.4-rc1/drivers/ide/legacy/pdc4030.c~ide_cmd_type_parser	2004-03-02 22:11:03.016667672 +0100
+++ linux-2.6.4-rc1-root/drivers/ide/legacy/pdc4030.c	2004-03-02 22:11:03.029665696 +0100
@@ -814,11 +814,10 @@ static ide_startstop_t promise_rw_disk (
 
 	memcpy(args.tfRegister, &taskfile, sizeof(struct hd_drive_task_hdr));
 	memset(args.hobRegister, 0, sizeof(struct hd_drive_hob_hdr));
-	/* We can't call ide_cmd_type_parser here, since it won't understand
-	   our command, but that doesn't matter, since we don't use the
-	   generic interrupt handlers either. Setup the bits of args that we
-	   do need.
-	*/
+	/*
+	 * Setup the bits of args that we do need.
+	 * Note that we don't use the generic interrupt handlers.
+	 */
 	args.handler		= NULL;
 	args.rq			= (struct request *) rq;
 	rq->special		= (ide_task_t *)&args;
diff -puN include/linux/ide.h~ide_cmd_type_parser include/linux/ide.h
--- linux-2.6.4-rc1/include/linux/ide.h~ide_cmd_type_parser	2004-03-02 22:11:03.019667216 +0100
+++ linux-2.6.4-rc1-root/include/linux/ide.h	2004-03-02 22:11:03.030665544 +0100
@@ -999,7 +999,6 @@ typedef struct hwif_s {
  */
 typedef ide_startstop_t (ide_pre_handler_t)(ide_drive_t *, struct request *);
 typedef ide_startstop_t (ide_handler_t)(ide_drive_t *);
-typedef ide_startstop_t (ide_post_handler_t)(ide_drive_t *);
 typedef int (ide_expiry_t)(ide_drive_t *);
 
 typedef struct hwgroup_s {
@@ -1361,7 +1360,6 @@ typedef struct ide_task_s {
 	int			command_type;
 	ide_pre_handler_t	*prehandler;
 	ide_handler_t		*handler;
-	ide_post_handler_t	*posthandler;
 	struct request		*rq;		/* copy of request */
 	void			*special;	/* valid_t generally */
 } ide_task_t;
@@ -1460,15 +1458,6 @@ extern void ide_init_drive_taskfile(stru
 
 extern int ide_raw_taskfile(ide_drive_t *, ide_task_t *, u8 *);
 
-extern ide_pre_handler_t * ide_pre_handler_parser(struct hd_drive_task_hdr *, struct hd_drive_hob_hdr *);
-
-extern ide_handler_t * ide_handler_parser(struct hd_drive_task_hdr *, struct hd_drive_hob_hdr *);
-
-extern ide_post_handler_t * ide_post_handler_parser(struct hd_drive_task_hdr *, struct hd_drive_hob_hdr *);
-
-/* Expects args is a full set of TF registers and parses the command type */
-extern int ide_cmd_type_parser(ide_task_t *);
-
 int ide_taskfile_ioctl(ide_drive_t *, unsigned int, unsigned long);
 int ide_cmd_ioctl(ide_drive_t *, unsigned int, unsigned long);
 int ide_task_ioctl(ide_drive_t *, unsigned int, unsigned long);

_

