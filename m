Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314079AbSDKOo6>; Thu, 11 Apr 2002 10:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314080AbSDKOo6>; Thu, 11 Apr 2002 10:44:58 -0400
Received: from [195.63.194.11] ([195.63.194.11]:25860 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314079AbSDKOow>; Thu, 11 Apr 2002 10:44:52 -0400
Message-ID: <3CB592DA.7000202@evision-ventures.com>
Date: Thu, 11 Apr 2002 15:42:50 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.8-pre3 IDE 32
In-Reply-To: <Pine.LNX.4.33.0204051657270.16281-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------080104070700090100010701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080104070700090100010701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Wed Apr 10 16:48:32 CEST 2002 ide-clean-32

- Don't provide symbolic links in /proc/ide - they are redundant data.

- Try to use a more reasonable default capacity value in ata_capacity().

- Fix ata_put() ata_get() usage in ide_check_media_change().

- Small readability fixes to the option parsing code.

- Apply Vojtech Pavliks /proc PIIX output fix.

- Replace all occurrences of ide_wait_taskfile() with ide_raw_taskfile().  One
   duplicated code path fewer.

--------------080104070700090100010701
Content-Type: text/plain;
 name="ide-clean-32.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-32.diff"

diff -urN linux-2.5.8-pre3/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.8-pre3/drivers/ide/ide-disk.c	Thu Apr 11 14:46:25 2002
+++ linux/drivers/ide/ide-disk.c	Thu Apr 11 13:37:04 2002
@@ -386,23 +386,22 @@
 {
 	MOD_INC_USE_COUNT;
 	if (drive->removable && drive->usage == 1) {
-		struct hd_drive_task_hdr taskfile;
-		struct hd_drive_hob_hdr hobfile;
-
-		memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
-		memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
+		struct ata_taskfile args;
 
 		check_disk_change(inode->i_rdev);
 
-		taskfile.command = WIN_DOORLOCK;
+		memset(&args, 0, sizeof(args));
+
+		args.taskfile.command = WIN_DOORLOCK;
+		ide_cmd_type_parser(&args);
 
 		/*
-		 * Ignore the return code from door_lock,
-		 * since the open() has already succeeded,
-		 * and the door_lock is irrelevant at this point.
+		 * Ignore the return code from door_lock, since the open() has
+		 * already succeeded, and the door_lock is irrelevant at this
+		 * point.
 		 */
-		if (drive->doorlocking &&
-		    ide_wait_taskfile(drive, &taskfile, &hobfile, NULL))
+
+		if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
 			drive->doorlocking = 0;
 	}
 	return 0;
@@ -410,33 +409,33 @@
 
 static int idedisk_flushcache(ide_drive_t *drive)
 {
-	struct hd_drive_task_hdr taskfile;
-	struct hd_drive_hob_hdr hobfile;
+	struct ata_taskfile args;
+
+	memset(&args, 0, sizeof(args));
 
-	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
-	memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
 	if (drive->id->cfs_enable_2 & 0x2400)
-		taskfile.command = WIN_FLUSH_CACHE_EXT;
+		args.taskfile.command = WIN_FLUSH_CACHE_EXT;
 	else
-		taskfile.command = WIN_FLUSH_CACHE;
+		args.taskfile.command = WIN_FLUSH_CACHE;
 
-	return ide_wait_taskfile(drive, &taskfile, &hobfile, NULL);
+	ide_cmd_type_parser(&args);
+
+	return ide_raw_taskfile(drive, &args, NULL);
 }
 
 static void idedisk_release (struct inode *inode, struct file *filp, ide_drive_t *drive)
 {
 	if (drive->removable && !drive->usage) {
-		struct hd_drive_task_hdr taskfile;
-		struct hd_drive_hob_hdr hobfile;
-
-		memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
-		memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
+		struct ata_taskfile args;
 
 		invalidate_bdev(inode->i_bdev, 0);
 
-		taskfile.command = WIN_DOORUNLOCK;
+		memset(&args, 0, sizeof(args));
+		args.taskfile.command = WIN_DOORUNLOCK;
+		ide_cmd_type_parser(&args);
+
 		if (drive->doorlocking &&
-		    ide_wait_taskfile(drive, &taskfile, &hobfile, NULL))
+		    ide_raw_taskfile(drive, &args, NULL))
 			drive->doorlocking = 0;
 	}
 	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
@@ -601,7 +600,7 @@
 	return flag;
 }
 
-#endif /* CONFIG_IDEDISK_STROKE */
+#endif
 
 /*
  * Compute drive->capacity, the full capacity of the drive
@@ -767,45 +766,50 @@
 
 static int smart_enable(ide_drive_t *drive)
 {
-	struct hd_drive_task_hdr taskfile;
-	struct hd_drive_hob_hdr hobfile;
-	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
-	memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
-	taskfile.feature	= SMART_ENABLE;
-	taskfile.low_cylinder	= SMART_LCYL_PASS;
-	taskfile.high_cylinder	= SMART_HCYL_PASS;
-	taskfile.command	= WIN_SMART;
-	return ide_wait_taskfile(drive, &taskfile, &hobfile, NULL);
-}
-
-static int get_smart_values(ide_drive_t *drive, byte *buf)
-{
-	struct hd_drive_task_hdr taskfile;
-	struct hd_drive_hob_hdr hobfile;
-	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
-	memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
-	taskfile.feature	= SMART_READ_VALUES;
-	taskfile.sector_count	= 0x01;
-	taskfile.low_cylinder	= SMART_LCYL_PASS;
-	taskfile.high_cylinder	= SMART_HCYL_PASS;
-	taskfile.command	= WIN_SMART;
+	struct ata_taskfile args;
+
+	memset(&args, 0, sizeof(args));
+	args.taskfile.feature = SMART_ENABLE;
+	args.taskfile.low_cylinder = SMART_LCYL_PASS;
+	args.taskfile.high_cylinder = SMART_HCYL_PASS;
+	args.taskfile.command = WIN_SMART;
+	ide_cmd_type_parser(&args);
+
+	return ide_raw_taskfile(drive, &args, NULL);
+}
+
+static int get_smart_values(ide_drive_t *drive, u8 *buf)
+{
+	struct ata_taskfile args;
+
+	memset(&args, 0, sizeof(args));
+	args.taskfile.feature = SMART_READ_VALUES;
+	args.taskfile.sector_count = 0x01;
+	args.taskfile.low_cylinder = SMART_LCYL_PASS;
+	args.taskfile.high_cylinder = SMART_HCYL_PASS;
+	args.taskfile.command = WIN_SMART;
+	ide_cmd_type_parser(&args);
+
 	smart_enable(drive);
-	return ide_wait_taskfile(drive, &taskfile, &hobfile, buf);
+
+	return ide_raw_taskfile(drive, &args, buf);
 }
 
-static int get_smart_thresholds(ide_drive_t *drive, byte *buf)
+static int get_smart_thresholds(ide_drive_t *drive, u8 *buf)
 {
-	struct hd_drive_task_hdr taskfile;
-	struct hd_drive_hob_hdr hobfile;
-	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
-	memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
-	taskfile.feature	= SMART_READ_THRESHOLDS;
-	taskfile.sector_count	= 0x01;
-	taskfile.low_cylinder	= SMART_LCYL_PASS;
-	taskfile.high_cylinder	= SMART_HCYL_PASS;
-	taskfile.command	= WIN_SMART;
+	struct ata_taskfile args;
+
+	memset(&args, 0, sizeof(args));
+	args.taskfile.feature = SMART_READ_THRESHOLDS;
+	args.taskfile.sector_count = 0x01;
+	args.taskfile.low_cylinder = SMART_LCYL_PASS;
+	args.taskfile.high_cylinder = SMART_HCYL_PASS;
+	args.taskfile.command = WIN_SMART;
+	ide_cmd_type_parser(&args);
+
 	smart_enable(drive);
-	return ide_wait_taskfile(drive, &taskfile, &hobfile, buf);
+
+	return ide_raw_taskfile(drive, &args, buf);
 }
 
 static int proc_idedisk_read_cache
@@ -947,7 +951,7 @@
 	ide_init_drive_cmd (&rq);
 	drive->mult_req = arg;
 	drive->special.b.set_multmode = 1;
-	(void) ide_do_drive_cmd (drive, &rq, ide_wait);
+	ide_do_drive_cmd (drive, &rq, ide_wait);
 	return (drive->mult_count == arg) ? 0 : -EIO;
 }
 
@@ -963,44 +967,46 @@
 
 static int write_cache(ide_drive_t *drive, int arg)
 {
-	struct hd_drive_task_hdr taskfile;
-	struct hd_drive_hob_hdr hobfile;
-	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
-	memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
-	taskfile.feature	= (arg) ? SETFEATURES_EN_WCACHE : SETFEATURES_DIS_WCACHE;
-	taskfile.command	= WIN_SETFEATURES;
+	struct ata_taskfile args;
 
 	if (!(drive->id->cfs_enable_2 & 0x3000))
 		return 1;
 
-	ide_wait_taskfile(drive, &taskfile, &hobfile, NULL);
+	memset(&args, 0, sizeof(args));
+	args.taskfile.feature	= (arg) ? SETFEATURES_EN_WCACHE : SETFEATURES_DIS_WCACHE;
+	args.taskfile.command	= WIN_SETFEATURES;
+	ide_cmd_type_parser(&args);
+	ide_raw_taskfile(drive, &args, NULL);
+
 	drive->wcache = arg;
+
 	return 0;
 }
 
 static int idedisk_standby(ide_drive_t *drive)
 {
-	struct hd_drive_task_hdr taskfile;
-	struct hd_drive_hob_hdr hobfile;
-	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
-	memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
-	taskfile.command	= WIN_STANDBYNOW1;
-	return ide_wait_taskfile(drive, &taskfile, &hobfile, NULL);
+	struct ata_taskfile args;
+
+	memset(&args, 0, sizeof(args));
+	args.taskfile.command = WIN_STANDBYNOW1;
+	ide_cmd_type_parser(&args);
+
+	return ide_raw_taskfile(drive, &args, NULL);
 }
 
 static int set_acoustic(ide_drive_t *drive, int arg)
 {
-	struct hd_drive_task_hdr taskfile;
-	struct hd_drive_hob_hdr hobfile;
-	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
-	memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
+	struct ata_taskfile args;
 
-	taskfile.feature	= (arg)?SETFEATURES_EN_AAM:SETFEATURES_DIS_AAM;
-	taskfile.sector_count	= arg;
+	memset(&args, 0, sizeof(args));
+	args.taskfile.feature = (arg)?SETFEATURES_EN_AAM:SETFEATURES_DIS_AAM;
+	args.taskfile.sector_count = arg;
+	args.taskfile.command = WIN_SETFEATURES;
+	ide_cmd_type_parser(&args);
+	ide_raw_taskfile(drive, &args, NULL);
 
-	taskfile.command	= WIN_SETFEATURES;
-	ide_wait_taskfile(drive, &taskfile, &hobfile, NULL);
 	drive->acoustic = arg;
+
 	return 0;
 }
 
diff -urN linux-2.5.8-pre3/drivers/ide/ide-proc.c linux/drivers/ide/ide-proc.c
--- linux-2.5.8-pre3/drivers/ide/ide-proc.c	Wed Apr 10 14:38:29 2002
+++ linux/drivers/ide/ide-proc.c	Thu Apr 11 13:48:32 2002
@@ -1,10 +1,6 @@
 /*
- *  linux/drivers/ide/ide-proc.c	Version 1.03	January  2, 1998
- *
  *  Copyright (C) 1997-1998	Mark Lord
- */
-
-/*
+ *
  * This is the /proc/ide/ filesystem implementation.
  *
  * The major reason this exists is to provide sufficient access
@@ -176,26 +172,26 @@
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
 
-static int proc_ide_get_identify(ide_drive_t *drive, byte *buf)
+static int get_identify(ide_drive_t *drive, u8 *buf)
 {
-	struct hd_drive_task_hdr taskfile;
-	struct hd_drive_hob_hdr hobfile;
-	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
-	memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
+	struct ata_taskfile args;
 
-	taskfile.sector_count = 0x01;
-	taskfile.command = (drive->type == ATA_DISK) ? WIN_IDENTIFY : WIN_PIDENTIFY ;
+	memset(&args, 0, sizeof(args));
+	args.taskfile.sector_count = 0x01;
+	args.taskfile.command = (drive->type == ATA_DISK) ? WIN_IDENTIFY : WIN_PIDENTIFY ;
+	ide_cmd_type_parser(&args);
 
-	return ide_wait_taskfile(drive, &taskfile, &hobfile, buf);
+	return ide_raw_taskfile(drive, &args, buf);
 }
 
 static int proc_ide_read_identify
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	ide_drive_t	*drive = data;
-	int		len = 0, i = 0;
+	ide_drive_t *drive = data;
+	int len = 0;
+	int i = 0;
 
-	if (drive && !proc_ide_get_identify(drive, page)) {
+	if (drive && !get_identify(drive, page)) {
 		unsigned short *val = (unsigned short *) page;
 		char *out = ((char *)val) + (SECTOR_WORDS * 4);
 		page = out;
@@ -204,8 +200,7 @@
 			val += 1;
 		} while (i < (SECTOR_WORDS * 2));
 		len = out - page;
-	}
-	else
+	} else
 		len = sprintf(page, "\n");
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
@@ -422,6 +417,8 @@
 	}
 }
 
+/* FIXME: we should iterate over the hwifs here as everywhere else.
+ */
 static void create_proc_ide_drives(struct ata_channel *hwif)
 {
 	int	d;
@@ -447,8 +444,6 @@
 			}
 		}
 		sprintf(name,"ide%d/%s", (drive->name[2]-'a')/2, drive->name);
-		ent = proc_symlink(drive->name, proc_ide_root, name);
-		if (!ent) return;
 	}
 }
 
diff -urN linux-2.5.8-pre3/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.8-pre3/drivers/ide/ide-taskfile.c	Thu Apr 11 14:46:25 2002
+++ linux/drivers/ide/ide-taskfile.c	Thu Apr 11 14:06:26 2002
@@ -891,39 +891,6 @@
 	rq->flags = REQ_DRIVE_TASKFILE;
 }
 
-/*
- * This is kept for internal use only !!!
- * This is an internal call and nobody in user-space has a
- * reason to call this taskfile.
- *
- * ide_raw_taskfile is the one that user-space executes.
- */
-
-int ide_wait_taskfile(ide_drive_t *drive, struct hd_drive_task_hdr *taskfile, struct hd_drive_hob_hdr *hobfile, byte *buf)
-{
-	struct request rq;
-	struct ata_request ar;
-	struct ata_taskfile *args = &ar.ar_task;
-
-	ata_ar_init(drive, &ar);
-
-	memcpy(&args->taskfile, taskfile, sizeof(*taskfile));
-	if (hobfile)
-		memcpy(&args->hobfile, hobfile, sizeof(*hobfile));
-
-	init_taskfile_request(&rq);
-
-	/* This is kept for internal use only !!! */
-	ide_cmd_type_parser(args);
-	if (args->command_type != IDE_DRIVE_TASK_NO_DATA)
-		rq.current_nr_sectors = rq.nr_sectors = (hobfile->sector_count << 8) | taskfile->sector_count;
-
-	rq.buffer = buf;
-	rq.special = &ar;
-
-	return ide_do_drive_cmd(drive, &rq, ide_wait);
-}
-
 int ide_raw_taskfile(ide_drive_t *drive, struct ata_taskfile *args, byte *buf)
 {
 	struct request rq;
@@ -932,6 +899,7 @@
 	ata_ar_init(drive, &ar);
 	init_taskfile_request(&rq);
 	rq.buffer = buf;
+
 	memcpy(&ar.ar_task, args, sizeof(*args));
 
 	if (args->command_type != IDE_DRIVE_TASK_NO_DATA)
@@ -1022,7 +990,7 @@
 	return err;
 }
 
-int ide_task_ioctl (ide_drive_t *drive, struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+int ide_task_ioctl(ide_drive_t *drive, struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
 {
 	int err = 0;
 	u8 args[7];
@@ -1051,15 +1019,14 @@
 EXPORT_SYMBOL(atapi_output_bytes);
 EXPORT_SYMBOL(taskfile_input_data);
 EXPORT_SYMBOL(taskfile_output_data);
-EXPORT_SYMBOL(ata_taskfile);
 
+EXPORT_SYMBOL(ata_taskfile);
 EXPORT_SYMBOL(recal_intr);
 EXPORT_SYMBOL(set_geometry_intr);
 EXPORT_SYMBOL(set_multmode_intr);
 EXPORT_SYMBOL(task_no_data_intr);
-
-EXPORT_SYMBOL(ide_wait_taskfile);
 EXPORT_SYMBOL(ide_raw_taskfile);
 EXPORT_SYMBOL(ide_cmd_type_parser);
+
 EXPORT_SYMBOL(ide_cmd_ioctl);
 EXPORT_SYMBOL(ide_task_ioctl);
diff -urN linux-2.5.8-pre3/drivers/ide/ide-tcq.c linux/drivers/ide/ide-tcq.c
--- linux-2.5.8-pre3/drivers/ide/ide-tcq.c	Thu Apr 11 14:46:25 2002
+++ linux/drivers/ide/ide-tcq.c	Thu Apr 11 13:49:30 2002
@@ -396,11 +396,9 @@
  */
 static int ide_tcq_configure(ide_drive_t *drive)
 {
-	struct hd_drive_task_hdr taskfile;
+	struct ata_taskfile args;
 	int tcq_supp = 1 << 1 | 1 << 14;
 
-	memset(&taskfile, 0, sizeof(taskfile));
-
 	/*
 	 * bit 14 and 1 must be set in word 83 of the device id to indicate
 	 * support for dma queued protocol
@@ -410,9 +408,12 @@
 		return 1;
 	}
 
-	taskfile.feature = SETFEATURES_EN_WCACHE;
-	taskfile.command = WIN_SETFEATURES;
-	if (ide_wait_taskfile(drive, &taskfile, NULL, NULL)) {
+	memset(&args, 0, sizeof(args));
+	args.taskfile.feature = SETFEATURES_EN_WCACHE;
+	args.taskfile.command = WIN_SETFEATURES;
+	ide_cmd_type_parser(&args);
+
+	if (ide_raw_taskfile(drive, &args, NULL)) {
 		printk("%s: failed to enable write cache\n", drive->name);
 		return 1;
 	}
@@ -421,9 +422,12 @@
 	 * disable RELease interrupt, it's quicker to poll this after
 	 * having sent the command opcode
 	 */
-	taskfile.feature = SETFEATURES_DIS_RI;
-	taskfile.command = WIN_SETFEATURES;
-	if (ide_wait_taskfile(drive, &taskfile, NULL, NULL)) {
+	memset(&args, 0, sizeof(args));
+	args.taskfile.feature = SETFEATURES_DIS_RI;
+	args.taskfile.command = WIN_SETFEATURES;
+	ide_cmd_type_parser(&args);
+
+	if (ide_raw_taskfile(drive, &args, NULL)) {
 		printk("%s: disabling release interrupt fail\n", drive->name);
 		return 1;
 	}
@@ -432,9 +436,12 @@
 	/*
 	 * enable SERVICE interrupt
 	 */
-	taskfile.feature = SETFEATURES_EN_SI;
-	taskfile.command = WIN_SETFEATURES;
-	if (ide_wait_taskfile(drive, &taskfile, NULL, NULL)) {
+	memset(&args, 0, sizeof(args));
+	args.taskfile.feature = SETFEATURES_EN_SI;
+	args.taskfile.command = WIN_SETFEATURES;
+	ide_cmd_type_parser(&args);
+
+	if (ide_raw_taskfile(drive, &args, NULL)) {
 		printk("%s: enabling service interrupt fail\n", drive->name);
 		return 1;
 	}
diff -urN linux-2.5.8-pre3/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.8-pre3/drivers/ide/ide.c	Thu Apr 11 14:46:25 2002
+++ linux/drivers/ide/ide.c	Wed Apr 10 17:31:17 2002
@@ -494,8 +494,11 @@
 	if (ata_ops(drive) && ata_ops(drive)->capacity)
 		return ata_ops(drive)->capacity(drive);
 
-	/* FIXME: This magic number seems to be bogous. */
-	return 0x7fffffff;
+	/* This used to be 0x7fffffff, but since now we use the maximal drive
+	 * capacity value used by other kernel subsystems as well.
+	 */
+
+	return ~0UL;
 }
 
 /*
@@ -556,13 +559,12 @@
 	}
 }
 
-static ide_startstop_t do_reset1 (ide_drive_t *, int);		/* needed below */
+static ide_startstop_t do_reset1(ide_drive_t *, int);		/* needed below */
 
 /*
- * ATAPI_reset_pollfunc() gets invoked to poll the interface for completion every 50ms
- * during an ATAPI drive reset operation. If the drive has not yet responded,
- * and we have not yet hit our maximum waiting time, then the timer is restarted
- * for another 50ms.
+ * Poll the interface for completion every 50ms during an ATAPI drive reset
+ * operation. If the drive has not yet responded, and we have not yet hit our
+ * maximum waiting time, then the timer is restarted for another 50ms.
  */
 static ide_startstop_t atapi_reset_pollfunc (ide_drive_t *drive)
 {
@@ -589,10 +591,9 @@
 }
 
 /*
- * reset_pollfunc() gets invoked to poll the interface for completion every 50ms
- * during an ide reset operation. If the drives have not yet responded,
- * and we have not yet hit our maximum waiting time, then the timer is restarted
- * for another 50ms.
+ * Poll the interface for completion every 50ms during an ata reset operation.
+ * If the drives have not yet responded, and we have not yet hit our maximum
+ * waiting time, then the timer is restarted for another 50ms.
  */
 static ide_startstop_t reset_pollfunc (ide_drive_t *drive)
 {
@@ -905,9 +906,9 @@
 }
 
 /*
- * ide_error() takes action based on the error returned by the drive.
+ * Take action based on the error returned by the drive.
  */
-ide_startstop_t ide_error (ide_drive_t *drive, const char *msg, byte stat)
+ide_startstop_t ide_error(ide_drive_t *drive, const char *msg, byte stat)
 {
 	struct request *rq;
 	byte err;
@@ -968,10 +969,9 @@
 }
 
 /*
- * Issue a simple drive command
- * The drive must be selected beforehand.
+ * Issue a simple drive command.  The drive must be selected beforehand.
  */
-void ide_cmd (ide_drive_t *drive, byte cmd, byte nsect, ide_handler_t *handler)
+void ide_cmd(ide_drive_t *drive, byte cmd, byte nsect, ide_handler_t *handler)
 {
 	BUG_ON(HWGROUP(drive)->handler);
 	ide_set_handler (drive, handler, WAIT_CMD, NULL);
@@ -983,7 +983,7 @@
 }
 
 /*
- * drive_cmd_intr() is invoked on completion of a special DRIVE_CMD.
+ * Invoked on completion of a special DRIVE_CMD.
  */
 static ide_startstop_t drive_cmd_intr (ide_drive_t *drive)
 {
@@ -1009,15 +1009,15 @@
 }
 
 /*
- * This routine busy-waits for the drive status to be not "busy".
- * It then checks the status for all of the "good" bits and none
- * of the "bad" bits, and if all is okay it returns 0.  All other
- * cases return 1 after invoking ide_error() -- caller should just return.
+ * Busy-wait for the drive status to be not "busy".  Check then the status for
+ * all of the "good" bits and none of the "bad" bits, and if all is okay it
+ * returns 0.  All other cases return 1 after invoking ide_error() -- caller
+ * should just return.
  *
  * This routine should get fixed to not hog the cpu during extra long waits..
  * That could be done by busy-waiting for the first jiffy or two, and then
- * setting a timer to wake up at half second intervals thereafter,
- * until timeout is achieved, before timing out.
+ * setting a timer to wake up at half second intervals thereafter, until
+ * timeout is achieved, before timing out.
  */
 int ide_wait_stat(ide_startstop_t *startstop, ide_drive_t *drive, byte good, byte bad, unsigned long timeout) {
 	byte stat;
@@ -1243,8 +1243,8 @@
 }
 
 /*
- * ide_stall_queue() can be used by a drive to give excess bandwidth back
- * to the hwgroup by sleeping for timeout jiffies.
+ * This is used by a drive to give excess bandwidth back to the hwgroup by
+ * sleeping for timeout jiffies.
  */
 void ide_stall_queue(ide_drive_t *drive, unsigned long timeout)
 {
@@ -1254,7 +1254,7 @@
 }
 
 /*
- * choose_drive() selects the next drive which will be serviced.
+ * Select the next drive which will be serviced.
  */
 static inline ide_drive_t *choose_drive(ide_hwgroup_t *hwgroup)
 {
@@ -1482,7 +1482,7 @@
 	hwif->dmaproc(ide_dma_timeout, drive);
 
 	/*
-	 * disable dma for now, but remember that we did so because of
+	 * Disable dma for now, but remember that we did so because of
 	 * a timeout -- we'll reenable after we finish this next request
 	 * (or rather the first chunk of it) in pio.
 	 */
@@ -1631,7 +1631,7 @@
  */
 static void unexpected_intr(int irq, ide_hwgroup_t *hwgroup)
 {
-	byte stat;
+	u8 stat;
 	struct ata_channel *hwif = hwgroup->hwif;
 
 	/*
@@ -2167,7 +2167,7 @@
 #endif
 
 	/*
-	 * Remove us from the kernel's knowledge
+	 * Remove us from the kernel's knowledge.
 	 */
 	unregister_blkdev(channel->major, channel->name);
 	kfree(blksize_size[channel->major]);
@@ -2249,7 +2249,7 @@
 				case IDE_IRQ_OFFSET:
 					hw->io_ports[i] = intr;
 					break;
-#endif /* (CONFIG_AMIGA) || (CONFIG_MAC) */
+#endif
 				default:
 					hw->io_ports[i] = 0;
 					break;
@@ -2316,7 +2316,7 @@
 }
 
 /*
- * Compatability function with existing drivers.  If you want
+ * Compatability function for existing drivers.  If you want
  * something different, use the function above.
  */
 int ide_register(int arg1, int arg2, int irq)
@@ -2327,7 +2327,7 @@
 	return ide_register_hw(&hw, NULL);
 }
 
-void ide_add_setting (ide_drive_t *drive, const char *name, int rw, int read_ioctl, int write_ioctl, int data_type, int min, int max, int mul_factor, int div_factor, void *data, ide_procset_t *set)
+void ide_add_setting(ide_drive_t *drive, const char *name, int rw, int read_ioctl, int write_ioctl, int data_type, int min, int max, int mul_factor, int div_factor, void *data, ide_procset_t *set)
 {
 	ide_settings_t **p = &drive->settings;
 	ide_settings_t *setting = NULL;
@@ -2506,9 +2506,7 @@
 
 void ide_add_generic_settings (ide_drive_t *drive)
 {
-/*
- *			drive	setting name		read/write access				read ioctl		write ioctl		data type	min	max				mul_factor	div_factor	data pointer			set function
- */
+/*			drive	setting name		read/write access				read ioctl		write ioctl		data type	min	max				mul_factor	div_factor	data pointer			set function */
 	ide_add_setting(drive,	"io_32bit",		drive->no_io_32bit ? SETTING_READ : SETTING_RW,	HDIO_GET_32BIT,		HDIO_SET_32BIT,		TYPE_BYTE,	0,	1 + (SUPPORT_VLB_SYNC << 1),	1,		1,		&drive->io_32bit,		set_io_32bit);
 	ide_add_setting(drive,	"keepsettings",		SETTING_RW,					HDIO_GET_KEEPSETTINGS,	HDIO_SET_KEEPSETTINGS,	TYPE_BYTE,	0,	1,				1,		1,		&drive->keep_settings,		NULL);
 	ide_add_setting(drive,	"pio_mode",		SETTING_WRITE,					-1,			HDIO_SET_PIO_MODE,	TYPE_BYTE,	0,	255,				1,		1,		NULL,				set_pio_mode);
@@ -2757,8 +2755,6 @@
 			break;
 		}
 
-		
-
 		/*
 		 * pheew, all done, add to list
 		 */
@@ -2787,18 +2783,21 @@
 static int ide_check_media_change (kdev_t i_rdev)
 {
 	ide_drive_t *drive;
+	int res = 0; /* not changed */
 
-	if ((drive = get_info_ptr(i_rdev)) == NULL)
+	drive = get_info_ptr(i_rdev);
+	if (!drive)
 		return -ENODEV;
+
 	if (ata_ops(drive)) {
 		ata_get(ata_ops(drive));
 		if (ata_ops(drive)->check_media_change)
-			return ata_ops(drive)->check_media_change(drive);
+			res = ata_ops(drive)->check_media_change(drive);
 		else
-			return 1; /* assume it was changed */
+			res = 1; /* assume it was changed */
 		ata_put(ata_ops(drive));
 	}
-	return 0;
+	return res;
 }
 
 void ide_fixstring (byte *s, const int bytecount, const int byteswap)
@@ -2828,6 +2827,10 @@
 		*p++ = '\0';
 }
 
+/****************************************************************************
+ * FIXME: rewrite the following crap:
+ */
+
 /*
  * stridx() returns the offset of c within s,
  * or -1 if c is '\0' or not found within s.
@@ -2835,11 +2838,12 @@
 static int __init stridx (const char *s, char c)
 {
 	char *i = strchr(s, c);
+
 	return (i && c) ? i - s : -1;
 }
 
 /*
- * match_parm() does parsing for ide_setup():
+ * Parsing for ide_setup():
  *
  * 1. the first char of s must be '='.
  * 2. if the remainder matches one of the supplied keywords,
@@ -3000,6 +3004,7 @@
 
 		printk(" : Enabled support for IDE doublers\n");
 		ide_doubler = 1;
+
 		return 1;
 	}
 #endif
@@ -3007,6 +3012,7 @@
 	if (!strcmp(s, "ide=nodma")) {
 		printk("IDE: Prevented DMA\n");
 		noautodma = 1;
+
 		return 1;
 	}
 
@@ -3014,14 +3020,15 @@
 	if (!strcmp(s, "ide=reverse")) {
 		ide_scan_direction = 1;
 		printk(" : Enabled support for IDE inverse scan order.\n");
+
 		return 1;
 	}
-#endif /* CONFIG_BLK_DEV_IDEPCI */
+#endif
 
 	/*
 	 * Look for drive options:  "hdx="
 	 */
-	if (s[0] == 'h' && s[1] == 'd' && s[2] >= 'a' && s[2] <= max_drive) {
+	if (!strncmp(s, "hd", 2) && s[2] >= 'a' && s[2] <= max_drive) {
 		const char *hd_words[] = {"none", "noprobe", "nowerr", "cdrom",
 				"serialize", "autotune", "noautotune",
 				"slow", "swapdata", "bswap", "flash",
@@ -3038,7 +3045,7 @@
 		/*
 		 * Look for last lun option:  "hdxlun="
 		 */
-		if (s[3] == 'l' && s[4] == 'u' && s[5] == 'n') {
+		if (!strncmp(&s[3], "lun", 3)) {
 			if (match_parm(&s[6], NULL, vals, 1) != 1)
 				goto bad_option;
 			if (vals[0] >= 0 && vals[0] <= 7) {
@@ -3095,7 +3102,7 @@
 #else
 				drive->scsi = 0;
 				goto bad_option;
-#endif /* defined(CONFIG_BLK_DEV_IDESCSI) && defined(CONFIG_SCSI) */
+#endif
 			case 3: /* cyl,head,sect */
 				drive->type	= ATA_DISK;
 				drive->cyl	= drive->bios_cyl  = vals[0];
@@ -3110,12 +3117,10 @@
 		}
 	}
 
-	if (s[0] != 'i' || s[1] != 'd' || s[2] != 'e')
-		goto bad_option;
 	/*
 	 * Look for bus speed option:  "idebus="
 	 */
-	if (s[3] == 'b' && s[4] == 'u' && s[5] == 's') {
+	if (strncmp(s, "idebus", 6)) {
 		if (match_parm(&s[6], NULL, vals, 1) != 1)
 			goto bad_option;
 		if (vals[0] >= 20 && vals[0] <= 66) {
@@ -3124,13 +3129,14 @@
 			printk(" -- BAD BUS SPEED! Expected value from 20 to 66");
 		goto done;
 	}
+
 	/*
 	 * Look for interface options:  "idex="
 	 */
-	if (s[3] >= '0' && s[3] <= max_hwif) {
+	if (!strncmp(s, "ide", 3) && s[3] >= '0' && s[3] <= max_hwif) {
 		/*
 		 * Be VERY CAREFUL changing this: note hardcoded indexes below
-		 * -8,-9,-10 : are reserved for future idex calls to ease the hardcoding.
+		 * -8,-9,-10. -11 : are reserved for future idex calls to ease the hardcoding.
 		 */
 		const char *ide_words[] = {
 			"noprobe", "serialize", "autotune", "noautotune", "reset", "dma", "ata66",
@@ -3138,6 +3144,7 @@
 			"qd65xx", "ht6560b", "cmd640_vlb", "dtc2278", "umc8672", "ali14xx", "dc4030", NULL };
 		hw = s[3] - '0';
 		hwif = &ide_hwifs[hw];
+
 		i = match_parm(&s[4], ide_words, vals, 3);
 
 		/*
@@ -3169,7 +3176,7 @@
 				init_ali14xx();
 				goto done;
 			}
-#endif /* CONFIG_BLK_DEV_ALI14XX */
+#endif
 #ifdef CONFIG_BLK_DEV_UMC8672
 			case -16: /* "umc8672" */
 			{
@@ -3177,7 +3184,7 @@
 				init_umc8672();
 				goto done;
 			}
-#endif /* CONFIG_BLK_DEV_UMC8672 */
+#endif
 #ifdef CONFIG_BLK_DEV_DTC2278
 			case -15: /* "dtc2278" */
 			{
@@ -3185,7 +3192,7 @@
 				init_dtc2278();
 				goto done;
 			}
-#endif /* CONFIG_BLK_DEV_DTC2278 */
+#endif
 #ifdef CONFIG_BLK_DEV_CMD640
 			case -14: /* "cmd640_vlb" */
 			{
@@ -3193,7 +3200,7 @@
 				cmd640_vlb = 1;
 				goto done;
 			}
-#endif /* CONFIG_BLK_DEV_CMD640 */
+#endif
 #ifdef CONFIG_BLK_DEV_HT6560B
 			case -13: /* "ht6560b" */
 			{
@@ -3201,7 +3208,7 @@
 				init_ht6560b();
 				goto done;
 			}
-#endif /* CONFIG_BLK_DEV_HT6560B */
+#endif
 #if CONFIG_BLK_DEV_QD65XX
 			case -12: /* "qd65xx" */
 			{
@@ -3209,7 +3216,7 @@
 				init_qd65xx();
 				goto done;
 			}
-#endif /* CONFIG_BLK_DEV_QD65XX */
+#endif
 			case -11: /* minus11 */
 			case -10: /* minus10 */
 			case -9: /* minus9 */
@@ -3219,10 +3226,10 @@
 #ifdef CONFIG_BLK_DEV_IDEPCI
 				hwif->udma_four = 1;
 				goto done;
-#else /* !CONFIG_BLK_DEV_IDEPCI */
+#else
 				hwif->udma_four = 0;
 				goto bad_hwif;
-#endif /* CONFIG_BLK_DEV_IDEPCI */
+#endif
 			case -6: /* dma */
 				hwif->autodma = 1;
 				goto done;
@@ -3271,16 +3278,22 @@
 				return 1;
 		}
 	}
+
 bad_option:
 	printk(" -- BAD OPTION\n");
 	return 1;
+
 bad_hwif:
 	printk("-- NOT SUPPORTED ON ide%d", hw);
+
 done:
 	printk("\n");
+
 	return 1;
 }
 
+/****************************************************************************/
+
 /* This is the default end request function as well */
 int ide_end_request(ide_drive_t *drive, int uptodate)
 {
diff -urN linux-2.5.8-pre3/drivers/ide/piix.c linux/drivers/ide/piix.c
--- linux-2.5.8-pre3/drivers/ide/piix.c	Wed Apr 10 14:38:29 2002
+++ linux/drivers/ide/piix.c	Thu Apr 11 11:22:45 2002
@@ -199,7 +199,7 @@
 
 		if (~piix_config->flags & PIIX_VICTORY) {
 			if ((piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_66 && (u & (1 << i))) umul = 2;
-			if ((piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_100 && (u & ((1 << i) + 12))) umul = 1;
+			if ((piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_100 && (u & (1 << (i + 12)))) umul = 1;
 			udma[i] = (4 - ((e >> (i << 2)) & 3)) * umul;
 		} else  udma[i] = (8 - ((e >> (i << 2)) & 7)) * 2;
 
diff -urN linux-2.5.8-pre3/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.8-pre3/include/linux/ide.h	Thu Apr 11 14:46:25 2002
+++ linux/include/linux/ide.h	Thu Apr 11 13:56:22 2002
@@ -858,16 +858,14 @@
 extern ide_startstop_t set_multmode_intr(ide_drive_t *drive);
 extern ide_startstop_t task_no_data_intr(ide_drive_t *drive);
 
-int ide_wait_taskfile (ide_drive_t *drive, struct hd_drive_task_hdr *taskfile, struct hd_drive_hob_hdr *hobfile, byte *buf);
-
-int ide_raw_taskfile (ide_drive_t *drive, struct ata_taskfile *cmd, byte *buf);
 
 /* This is setting up all fields in args, which depend upon the command type.
  */
 extern void ide_cmd_type_parser(struct ata_taskfile *args);
+extern int ide_raw_taskfile(ide_drive_t *drive, struct ata_taskfile *cmd, byte *buf);
 
-int ide_cmd_ioctl (ide_drive_t *drive, struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg);
-int ide_task_ioctl (ide_drive_t *drive, struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg);
+extern int ide_cmd_ioctl(ide_drive_t *drive, struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg);
+extern int ide_task_ioctl(ide_drive_t *drive, struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg);
 
 void ide_delay_50ms (void);
 

--------------080104070700090100010701--

