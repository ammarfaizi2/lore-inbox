Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313714AbSDZIoQ>; Fri, 26 Apr 2002 04:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313715AbSDZIoP>; Fri, 26 Apr 2002 04:44:15 -0400
Received: from [195.63.194.11] ([195.63.194.11]:53778 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313714AbSDZIoB>; Fri, 26 Apr 2002 04:44:01 -0400
Message-ID: <3CC904AA.7020706@evision-ventures.com>
Date: Fri, 26 Apr 2002 09:41:30 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.10 IDE 42
In-Reply-To: <1019549894.1450.41.camel@turbulence.megapathdsl.net> <3CC7E358.8050905@evision-ventures.com> <20020425172508.GK3542@suse.de> <20020425173439.GM3542@suse.de> <aa9qtb$d8a$1@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------080503090107030001080705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080503090107030001080705
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Thu Apr 25 21:54:03 CEST 2002 ide-clean-42

- Streamline the usage of sector_t over the strategy routines in question a
   bit. Streamline the do_request code in ide-disk.c.

- Improve the readability of start_request in ide.c.

- Remove obsolete/nowhere used stuff from hdreg.h.

- Splitup special_t into classical flag field.

- Use only a single field to determine the capacity of a drive.  Make this
   field and the code paths it follows as far as possible use the sector_t
   instead of a hard coded integer types.  This increases the chances that at
   some distant point in time we will indeed be able to use 64 bit wide sector_t
   entities. (Disks are getting huge those times now...)

--------------080503090107030001080705
Content-Type: text/plain;
 name="ide-clean-42.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-42.diff"

diff -urN linux-2.5.10/arch/mips64/kernel/ioctl32.c linux/arch/mips64/kernel/ioctl32.c
--- linux-2.5.10/arch/mips64/kernel/ioctl32.c	2002-04-23 00:29:14.000000000 +0200
+++ linux/arch/mips64/kernel/ioctl32.c	2002-04-25 23:04:42.000000000 +0200
@@ -732,15 +732,12 @@
 	IOCTL32_HANDLER(HDIO_GETGEO, hdio_getgeo),	/* hdreg.h ioctls  */
 	IOCTL32_HANDLER(HDIO_GET_UNMASKINTR, hdio_ioctl_trans),
 	IOCTL32_HANDLER(HDIO_GET_MULTCOUNT, hdio_ioctl_trans),
-	// HDIO_OBSOLETE_IDENTITY
 	IOCTL32_HANDLER(HDIO_GET_KEEPSETTINGS, hdio_ioctl_trans),
 	IOCTL32_HANDLER(HDIO_GET_32BIT, hdio_ioctl_trans),
 	IOCTL32_HANDLER(HDIO_GET_NOWERR, hdio_ioctl_trans),
 	IOCTL32_HANDLER(HDIO_GET_DMA, hdio_ioctl_trans),
 	IOCTL32_HANDLER(HDIO_GET_NICE, hdio_ioctl_trans),
 	IOCTL32_DEFAULT(HDIO_GET_IDENTITY),
-	// HDIO_TRISTATE_HWIF				/* not implemented */
-	// HDIO_DRIVE_TASK				/* To do, need specs */
 	IOCTL32_DEFAULT(HDIO_DRIVE_CMD),
 	IOCTL32_DEFAULT(HDIO_SET_MULTCOUNT),
 	IOCTL32_DEFAULT(HDIO_SET_UNMASKINTR),
diff -urN linux-2.5.10/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- linux-2.5.10/drivers/block/ll_rw_blk.c	2002-04-23 00:27:58.000000000 +0200
+++ linux/drivers/block/ll_rw_blk.c	2002-04-25 23:27:41.000000000 +0200
@@ -334,7 +334,7 @@
 
 static char *rq_flags[] = { "REQ_RW", "REQ_RW_AHEAD", "REQ_BARRIER",
 			   "REQ_CMD", "REQ_NOMERGE", "REQ_STARTED",
-			   "REQ_DONTPREP", "REQ_DRIVE_CMD", "REQ_DRIVE_TASK",
+			   "REQ_DONTPREP", "REQ_DRIVE_CMD",
 			   "REQ_DRIVE_ACB", "REQ_PC", "REQ_BLOCK_PC",
 			   "REQ_SENSE", "REQ_SPECIAL" };
 
diff -urN linux-2.5.10/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.10/drivers/ide/ide.c	2002-04-26 03:38:13.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-04-26 03:30:21.000000000 +0200
@@ -283,6 +283,7 @@
 	hwif->major = ide_major[index];
 	sprintf(hwif->name, "ide%d", index);
 	hwif->bus_state = BUSSTATE_ON;
+
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		ide_drive_t *drive = &hwif->drives[unit];
 
@@ -292,10 +293,10 @@
 		drive->ctl			= 0x08;
 		drive->ready_stat		= READY_STAT;
 		drive->bad_wstat		= BAD_W_STAT;
-		drive->special.b.recalibrate	= 1;
-		drive->special.b.set_geometry	= 1;
+		drive->special_cmd = (ATA_SPECIAL_RECALIBRATE | ATA_SPECIAL_GEOMETRY);
 		sprintf(drive->name, "hd%c", 'a' + (index * MAX_DRIVES) + unit);
 		drive->max_failures		= IDE_DEFAULT_MAX_FAILURES;
+
 		init_waitqueue_head(&drive->wqueue);
 	}
 }
@@ -455,7 +456,7 @@
  * The capacity of a drive according to its current geometry/LBA settings in
  * sectors.
  */
-unsigned long ata_capacity(ide_drive_t *drive)
+sector_t ata_capacity(struct ata_device *drive)
 {
 	if (!drive->present || !drive->driver)
 		return 0;
@@ -472,31 +473,31 @@
 
 /*
  * This is used to issue WIN_SPECIFY, WIN_RESTORE, and WIN_SETMULT commands to
- * a drive.  It used to do much more, but has been scaled back.
+ * a drive.
  */
-static ide_startstop_t ata_special (ide_drive_t *drive)
+static ide_startstop_t ata_special(struct ata_device *drive)
 {
-	special_t *s = &drive->special;
+	unsigned char special_cmd = drive->special_cmd;
 
 #ifdef DEBUG
-	printk("%s: ata_special: 0x%02x\n", drive->name, s->all);
+	printk("%s: ata_special: 0x%02x\n", drive->name, special_cmd);
 #endif
-	if (s->b.set_tune) {
-		s->b.set_tune = 0;
+	if (special_cmd & ATA_SPECIAL_TUNE) {
+		drive->special_cmd &= ~ATA_SPECIAL_TUNE;
 		if (drive->channel->tuneproc != NULL)
 			drive->channel->tuneproc(drive, drive->tune_req);
 	} else if (drive->driver != NULL) {
 		if (ata_ops(drive)->special)
 			return ata_ops(drive)->special(drive);
 		else {
-			drive->special.all = 0;
+			drive->special_cmd = 0;
 			drive->mult_req = 0;
 
 			return ide_stopped;
 		}
-	} else if (s->all) {
-		printk("%s: bad special flag: 0x%02x\n", drive->name, s->all);
-		s->all = 0;
+	} else if (special_cmd) {
+		printk("%s: bad special flag: 0x%02x\n", drive->name, special_cmd);
+		drive->special_cmd = 0;
 	}
 
 	return ide_stopped;
@@ -584,27 +585,25 @@
 			drive->failures = 0;
 		} else {
 			drive->failures++;
+			char *msg = "";
 #if FANCY_STATUS_DUMPS
-			printk("master: ");
+			printk("master:");
 			switch (tmp & 0x7f) {
-				case 1: printk("passed");
+				case 1: msg = " passed";
 					break;
-				case 2: printk("formatter device error");
+				case 2: msg = " formatter device";
 					break;
-				case 3: printk("sector buffer error");
+				case 3: msg = " sector buffer";
 					break;
-				case 4: printk("ECC circuitry error");
+				case 4: msg = " ECC circuitry";
 					break;
-				case 5: printk("controlling MPU error");
+				case 5: msg = " controlling MPU error";
 					break;
-				default:printk("error (0x%02x?)", tmp);
 			}
 			if (tmp & 0x80)
-				printk("; slave: failed");
-			printk("\n");
-#else
-			printk("failed\n");
+				printk("; slave:");
 #endif
+			printk("%s error [%02x]\n", msg, tmp);
 		}
 	}
 	hwgroup->poll_timeout = 0;	/* done polling */
@@ -705,7 +704,7 @@
 /*
  * Clean up after success/failure of an explicit drive cmd
  */
-void ide_end_drive_cmd(ide_drive_t *drive, byte stat, byte err)
+void ide_end_drive_cmd(struct ata_device *drive, byte stat, byte err)
 {
 	unsigned long flags;
 	struct request *rq;
@@ -714,27 +713,16 @@
 	rq = HWGROUP(drive)->rq;
 
 	if (rq->flags & REQ_DRIVE_CMD) {
-		byte *args = (byte *) rq->buffer;
-		rq->errors = !OK_STAT(stat,READY_STAT,BAD_STAT);
-		if (args) {
-			args[0] = stat;
-			args[1] = err;
-			args[2] = IN_BYTE(IDE_NSECTOR_REG);
-		}
-	} else if (rq->flags & REQ_DRIVE_TASK) {
-		byte *args = (byte *) rq->buffer;
-		rq->errors = !OK_STAT(stat,READY_STAT,BAD_STAT);
+		u8 *args = rq->buffer;
+		rq->errors = !OK_STAT(stat, READY_STAT, BAD_STAT);
 		if (args) {
 			args[0] = stat;
 			args[1] = err;
 			args[2] = IN_BYTE(IDE_NSECTOR_REG);
-			args[3] = IN_BYTE(IDE_SECTOR_REG);
-			args[4] = IN_BYTE(IDE_LCYL_REG);
-			args[5] = IN_BYTE(IDE_HCYL_REG);
-			args[6] = IN_BYTE(IDE_SELECT_REG);
 		}
-	} else if (rq->flags & REQ_DRIVE_TASKFILE) {
+	} else if (rq->flags & REQ_DRIVE_ACB) {
 		struct ata_taskfile *args = rq->special;
+
 		rq->errors = !OK_STAT(stat, READY_STAT, BAD_STAT);
 		if (args) {
 			args->taskfile.feature = err;
@@ -783,16 +771,23 @@
 	if (stat & BUSY_STAT)
 		printk("Busy ");
 	else {
-		if (stat & READY_STAT)	printk("DriveReady ");
-		if (stat & WRERR_STAT)	printk("DeviceFault ");
-		if (stat & SEEK_STAT)	printk("SeekComplete ");
-		if (stat & DRQ_STAT)	printk("DataRequest ");
-		if (stat & ECC_STAT)	printk("CorrectedError ");
-		if (stat & INDEX_STAT)	printk("Index ");
-		if (stat & ERR_STAT)	printk("Error ");
+		if (stat & READY_STAT)
+			printk("DriveReady ");
+		if (stat & WRERR_STAT)
+			printk("DeviceFault ");
+		if (stat & SEEK_STAT)
+			printk("SeekComplete ");
+		if (stat & DRQ_STAT)
+			printk("DataRequest ");
+		if (stat & ECC_STAT)
+			printk("CorrectedError ");
+		if (stat & INDEX_STAT)
+			printk("Index ");
+		if (stat & ERR_STAT)
+			printk("Error ");
 	}
 	printk("}");
-#endif	/* FANCY_STATUS_DUMPS */
+#endif
 	printk("\n");
 	if ((stat & (BUSY_STAT|ERR_STAT)) == ERR_STAT) {
 		err = GET_ERR();
@@ -839,7 +834,7 @@
 					printk(", sector=%ld", HWGROUP(drive)->rq->sector);
 			}
 		}
-#endif	/* FANCY_STATUS_DUMPS */
+#endif
 		printk("\n");
 	}
 	__restore_flags (flags);	/* local CPU only */
@@ -907,7 +902,6 @@
 		OUT_BYTE(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG);	/* force an abort */
 
 	if (rq->errors >= ERROR_MAX) {
-		/* ATA-PATTERN */
 		if (ata_ops(drive) && ata_ops(drive)->end_request)
 			ata_ops(drive)->end_request(drive, 0);
 		else
@@ -918,7 +912,7 @@
 			return do_reset1(drive, 0);
 		}
 		if ((rq->errors & ERROR_RECAL) == ERROR_RECAL)
-			drive->special.b.recalibrate = 1;
+			drive->special_cmd |= ATA_SPECIAL_RECALIBRATE;
 		++rq->errors;
 	}
 	return ide_stopped;
@@ -1020,47 +1014,55 @@
  */
 static ide_startstop_t start_request(ide_drive_t *drive, struct request *rq)
 {
-	ide_startstop_t startstop;
-	unsigned long block;
-	unsigned int minor = minor(rq->rq_dev), unit = minor >> PARTN_BITS;
-	struct ata_channel *hwif = drive->channel;
+	sector_t block;
+	unsigned int minor = minor(rq->rq_dev);
+	unsigned int unit = minor >> PARTN_BITS;
+	struct ata_channel *ch = drive->channel;
 
 	BUG_ON(!(rq->flags & REQ_STARTED));
 
 #ifdef DEBUG
-	printk("%s: start_request: current=0x%08lx\n", hwif->name, (unsigned long) rq);
+	printk("%s: start_request: current=0x%08lx\n", ch->name, (unsigned long) rq);
 #endif
 
 	/* bail early if we've exceeded max_failures */
-	if (drive->max_failures && (drive->failures > drive->max_failures)) {
+	if (drive->max_failures && (drive->failures > drive->max_failures))
 		goto kill_rq;
-	}
 
 	if (unit >= MAX_DRIVES) {
-		printk("%s: bad device number: %s\n", hwif->name, kdevname(rq->rq_dev));
+		printk(KERN_ERR "%s: bad device number: %s\n", ch->name, kdevname(rq->rq_dev));
 		goto kill_rq;
 	}
+
 	block    = rq->sector;
 
-	/* Strange disk manager remap */
+	/* Strange disk manager remap.
+	 */
 	if ((rq->flags & REQ_CMD) &&
 	    (drive->type == ATA_DISK || drive->type == ATA_FLOPPY)) {
 		block += drive->sect0;
 	}
-	/* Yecch - this will shift the entire interval,
-	   possibly killing some innocent following sector */
+
+	/* Yecch - this will shift the entire interval, possibly killing some
+	 * innocent following sector.
+	 */
 	if (block == 0 && drive->remap_0_to_1 == 1)
 		block = 1;  /* redirect MBR access to EZ-Drive partn table */
 
 #if (DISK_RECOVERY_TIME > 0)
-	while ((read_timer() - hwif->last_time) < DISK_RECOVERY_TIME);
+	while ((read_timer() - ch->last_time) < DISK_RECOVERY_TIME);
 #endif
 
-	SELECT_DRIVE(hwif, drive);
-	if (ide_wait_stat(&startstop, drive, drive->ready_stat,
-			  BUSY_STAT|DRQ_STAT, WAIT_READY)) {
-		printk(KERN_WARNING "%s: drive not ready for command\n", drive->name);
-		return startstop;
+	{
+		ide_startstop_t res;
+
+		SELECT_DRIVE(ch, drive);
+		if (ide_wait_stat(&res, drive, drive->ready_stat,
+					BUSY_STAT|DRQ_STAT, WAIT_READY)) {
+			printk(KERN_WARNING "%s: drive not ready for command\n", drive->name);
+
+			return res;
+		}
 	}
 
 	/* FIXME: We can see nicely here that all commands should be submitted
@@ -1068,110 +1070,93 @@
 	 * go as soon as possible!
 	 */
 
-	if (!drive->special.all) {
-		if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK | REQ_DRIVE_TASKFILE)) {
-			/* This issues a special drive command, usually
-			 * initiated by ioctl() from the external hdparm
-			 * program.
-			 */
+	if (drive->special_cmd)
+		return ata_special(drive);
 
-			if (rq->flags & REQ_DRIVE_TASKFILE) {
-				struct ata_taskfile *args = rq->special;
+	/* This issues a special drive command, usually initiated by ioctl()
+	 * from the external hdparm program.
+	 */
+	if (rq->flags & REQ_DRIVE_ACB) {
+		struct ata_taskfile *args = rq->special;
 
-				if (!(args))
-					goto args_error;
+		if (!(args))
+			goto args_error;
 
-				ata_taskfile(drive, args, NULL);
+		ata_taskfile(drive, args, NULL);
 
-				if (((args->command_type == IDE_DRIVE_TASK_RAW_WRITE) ||
+		if (((args->command_type == IDE_DRIVE_TASK_RAW_WRITE) ||
 					(args->command_type == IDE_DRIVE_TASK_OUT)) &&
-						args->prehandler && args->handler)
-					return args->prehandler(drive, rq);
-				return ide_started;
-
-			} else if (rq->flags & REQ_DRIVE_TASK) {
-				byte *args = rq->buffer;
-				byte sel;
+				args->prehandler && args->handler)
+			return args->prehandler(drive, rq);
 
-				if (!(args)) goto args_error;
-#ifdef DEBUG
-				printk("%s: DRIVE_TASK_CMD ", drive->name);
-				printk("cmd=0x%02x ", args[0]);
-				printk("fr=0x%02x ", args[1]);
-				printk("ns=0x%02x ", args[2]);
-				printk("sc=0x%02x ", args[3]);
-				printk("lcyl=0x%02x ", args[4]);
-				printk("hcyl=0x%02x ", args[5]);
-				printk("sel=0x%02x\n", args[6]);
-#endif
-				OUT_BYTE(args[1], IDE_FEATURE_REG);
-				OUT_BYTE(args[3], IDE_SECTOR_REG);
-				OUT_BYTE(args[4], IDE_LCYL_REG);
-				OUT_BYTE(args[5], IDE_HCYL_REG);
-				sel = (args[6] & ~0x10);
-				if (drive->select.b.unit)
-					sel |= 0x10;
-				OUT_BYTE(sel, IDE_SELECT_REG);
-				ide_cmd(drive, args[0], args[2], &drive_cmd_intr);
-				return ide_started;
-			} else if (rq->flags & REQ_DRIVE_CMD) {
-				byte *args = rq->buffer;
-				if (!(args)) goto args_error;
-#ifdef DEBUG
-				printk("%s: DRIVE_CMD ", drive->name);
-				printk("cmd=0x%02x ", args[0]);
-				printk("sc=0x%02x ", args[1]);
-				printk("fr=0x%02x ", args[2]);
-				printk("xx=0x%02x\n", args[3]);
-#endif
-				if (args[0] == WIN_SMART) {
-					OUT_BYTE(0x4f, IDE_LCYL_REG);
-					OUT_BYTE(0xc2, IDE_HCYL_REG);
-					OUT_BYTE(args[2],IDE_FEATURE_REG);
-					OUT_BYTE(args[1],IDE_SECTOR_REG);
-					ide_cmd(drive, args[0], args[3], &drive_cmd_intr);
+		return ide_started;
+	}
 
-					return ide_started;
-				}
-				OUT_BYTE(args[2],IDE_FEATURE_REG);
-				ide_cmd(drive, args[0], args[1], &drive_cmd_intr);
-				return ide_started;
-			}
+	if (rq->flags & REQ_DRIVE_CMD) {
+		u8 *args = rq->buffer;
 
-args_error:
-			/*
-			 * NULL is actually a valid way of waiting for all
-			 * current requests to be flushed from the queue.
-			 */
+		if (!(args))
+			goto args_error;
 #ifdef DEBUG
-			printk("%s: DRIVE_CMD (null)\n", drive->name);
-#endif
-			ide_end_drive_cmd(drive, GET_STAT(), GET_ERR());
-			return ide_stopped;
+		printk("%s: DRIVE_CMD ", drive->name);
+		printk("cmd=0x%02x ", args[0]);
+		printk("sc=0x%02x ", args[1]);
+		printk("fr=0x%02x ", args[2]);
+		printk("xx=0x%02x\n", args[3]);
+#endif
+		if (args[0] == WIN_SMART) {
+			OUT_BYTE(0x4f, IDE_LCYL_REG);
+			OUT_BYTE(0xc2, IDE_HCYL_REG);
+			OUT_BYTE(args[2],IDE_FEATURE_REG);
+			OUT_BYTE(args[1],IDE_SECTOR_REG);
+			ide_cmd(drive, args[0], args[3], &drive_cmd_intr);
+
+			return ide_started;
 		}
+		OUT_BYTE(args[2],IDE_FEATURE_REG);
+		ide_cmd(drive, args[0], args[1], &drive_cmd_intr);
 
-		/* The normal way of execution is to pass execute the request
-		 * handler.
-		 */
+		return ide_started;
+	}
 
-		if (ata_ops(drive)) {
-			if (ata_ops(drive)->do_request)
-				return ata_ops(drive)->do_request(drive, rq, block);
-			else {
-				ide_end_request(drive, 0);
-				return ide_stopped;
-			}
+	/* The normal way of execution is to pass and execute the request
+	 * handler down to the device type driver.
+	 */
+	if (ata_ops(drive)) {
+		if (ata_ops(drive)->do_request)
+			return ata_ops(drive)->do_request(drive, rq, block);
+		else {
+			ide_end_request(drive, 0);
+			return ide_stopped;
 		}
-		printk(KERN_WARNING "%s: device type %d not supported\n",
-		       drive->name, drive->type);
-		goto kill_rq;
 	}
-	return ata_special(drive);
+
+	/*
+	 * Error handling:
+	 */
+
+	printk(KERN_WARNING "%s: device type %d not supported\n",
+			drive->name, drive->type);
+
 kill_rq:
 	if (ata_ops(drive) && ata_ops(drive)->end_request)
 		ata_ops(drive)->end_request(drive, 0);
 	else
 		ide_end_request(drive, 0);
+
+	return ide_stopped;
+
+args_error:
+
+	/* NULL as arguemnt is used by ioctls as a way of waiting for all
+	 * current requests to be flushed from the queue.
+	 */
+
+#ifdef DEBUG
+	printk("%s: DRIVE_CMD (null)\n", drive->name);
+#endif
+	ide_end_drive_cmd(drive, GET_STAT(), GET_ERR());
+
 	return ide_stopped;
 }
 
@@ -1678,7 +1663,7 @@
 /*
  * This function is intended to be used prior to invoking ide_do_drive_cmd().
  */
-void ide_init_drive_cmd (struct request *rq)
+void ide_init_drive_cmd(struct request *rq)
 {
 	memset(rq, 0, sizeof(*rq));
 	rq->flags = REQ_DRIVE_CMD;
@@ -1742,6 +1727,7 @@
 		wait_for_completion(&wait);	/* wait for it to be serviced */
 		return rq->errors ? -EIO : 0;	/* return -EIO if errors */
 	}
+
 	return 0;
 
 }
@@ -2386,18 +2372,21 @@
 	return 0;
 }
 
-static int set_pio_mode (ide_drive_t *drive, int arg)
+static int set_pio_mode(ide_drive_t *drive, int arg)
 {
 	struct request rq;
 
 	if (!drive->channel->tuneproc)
 		return -ENOSYS;
-	if (drive->special.b.set_tune)
+
+	if (drive->special_cmd & ATA_SPECIAL_TUNE)
 		return -EBUSY;
+
 	ide_init_drive_cmd(&rq);
-	drive->tune_req = (byte) arg;
-	drive->special.b.set_tune = 1;
+	drive->tune_req = (u8) arg;
+	drive->special_cmd |= ATA_SPECIAL_TUNE;
 	ide_do_drive_cmd(drive, &rq, ide_wait);
+
 	return 0;
 }
 
@@ -2433,8 +2422,7 @@
 #endif /* CONFIG_BLK_DEV_IDECS */
 }
 
-static int ide_ioctl (struct inode *inode, struct file *file,
-			unsigned int cmd, unsigned long arg)
+static int ide_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
 {
 	int err = 0, major, minor;
 	ide_drive_t *drive;
@@ -2468,7 +2456,7 @@
 		}
 	}
 
-	ide_init_drive_cmd (&rq);
+	ide_init_drive_cmd(&rq);
 	switch (cmd) {
 		case HDIO_GETGEO:
 		{
@@ -2518,13 +2506,12 @@
 				return -EACCES;
 			return ide_revalidate_disk(inode->i_rdev);
 
-		case HDIO_OBSOLETE_IDENTITY:
 		case HDIO_GET_IDENTITY:
 			if (minor(inode->i_rdev) & PARTN_MASK)
 				return -EINVAL;
 			if (drive->id == NULL)
 				return -ENOMSG;
-			if (copy_to_user((char *)arg, (char *)drive->id, (cmd == HDIO_GET_IDENTITY) ? sizeof(*drive->id) : 142))
+			if (copy_to_user((char *)arg, (char *)drive->id, sizeof(*drive->id)))
 				return -EFAULT;
 			return 0;
 
@@ -2538,11 +2525,6 @@
 				return -EACCES;
 			return ide_cmd_ioctl(drive, arg);
 
-		case HDIO_DRIVE_TASK:
-			if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
-				return -EACCES;
-			return ide_task_ioctl(drive, arg);
-
 		case HDIO_SET_NICE:
 			if (!capable(CAP_SYS_ADMIN)) return -EACCES;
 			if (arg != (arg & ((1 << IDE_NICE_DSC_OVERLAP))))
diff -urN linux-2.5.10/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.10/drivers/ide/ide-cd.c	2002-04-26 03:38:13.000000000 +0200
+++ linux/drivers/ide/ide-cd.c	2002-04-26 03:07:04.000000000 +0200
@@ -1162,11 +1162,12 @@
 	return ide_stopped;
 }
 
-static ide_startstop_t cdrom_start_seek_continuation (ide_drive_t *drive)
+static ide_startstop_t cdrom_start_seek_continuation(struct ata_device *drive)
 {
 	unsigned char cmd[CDROM_PACKET_SIZE];
 	struct request *rq = HWGROUP(drive)->rq;
-	int sector, frame, nskip;
+	sector_t sector;
+	int frame, nskip;
 
 	sector = rq->sector;
 	nskip = (sector % SECTORS_PER_FRAME);
@@ -1181,14 +1182,14 @@
 	return cdrom_transfer_packet_command(drive, cmd, WAIT_CMD, &cdrom_seek_intr);
 }
 
-static ide_startstop_t cdrom_start_seek (ide_drive_t *drive, unsigned int block)
+static ide_startstop_t cdrom_start_seek(struct ata_device *drive, sector_t block)
 {
 	struct cdrom_info *info = drive->driver_data;
 
 	info->dma = 0;
 	info->cmd = 0;
 	info->start_seek = jiffies;
-	return cdrom_start_packet_command (drive, 0, cdrom_start_seek_continuation);
+	return cdrom_start_packet_command(drive, 0, cdrom_start_seek_continuation);
 }
 
 /*
@@ -1199,7 +1200,7 @@
 static void restore_request (struct request *rq)
 {
 	if (rq->buffer != bio_data(rq->bio)) {
-		int n = (rq->buffer - (char *) bio_data(rq->bio)) / SECTOR_SIZE;
+		sector_t n = (rq->buffer - (char *) bio_data(rq->bio)) / SECTOR_SIZE;
 		rq->buffer = bio_data(rq->bio);
 		rq->nr_sectors += n;
 		rq->sector -= n;
@@ -1213,7 +1214,7 @@
 /*
  * Start a read request from the CD-ROM.
  */
-static ide_startstop_t cdrom_start_read (ide_drive_t *drive, unsigned int block)
+static ide_startstop_t cdrom_start_read(struct ata_device *drive, sector_t block)
 {
 	struct cdrom_info *info = drive->driver_data;
 	struct request *rq = HWGROUP(drive)->rq;
@@ -1634,8 +1635,6 @@
 	struct cdrom_info *info = drive->driver_data;
 
 	if (rq->flags & REQ_CMD) {
-	
-
 		if (CDROM_CONFIG_FLAGS(drive)->seeking) {
 			unsigned long elpased = jiffies - info->start_seek;
 			int stat = GET_STAT();
@@ -1650,7 +1649,7 @@
 			CDROM_CONFIG_FLAGS(drive)->seeking = 0;
 		}
 		if (IDE_LARGE_SEEK(info->last_block, block, IDECD_SEEK_THRESHOLD) && drive->dsc_overlap)
-			action = cdrom_start_seek (drive, block);
+			action = cdrom_start_seek(drive, block);
 		else {
 			if (rq_data_dir(rq) == READ)
 				action = cdrom_start_read(drive, block);
@@ -1837,7 +1836,7 @@
 	return cdrom_queue_packet_command(drive, cmd, sense, &pc);
 }
 
-static int cdrom_read_capacity(ide_drive_t *drive, unsigned long *capacity,
+static int cdrom_read_capacity(ide_drive_t *drive, u32 *capacity,
 			       struct request_sense *sense)
 {
 	struct {
@@ -2027,7 +2026,8 @@
 	/* Now try to get the total cdrom capacity. */
 	minor = (drive->select.b.unit) << PARTN_BITS;
 	dev = mk_kdev(drive->channel->major, minor);
-	stat = cdrom_get_last_written(dev, &toc->capacity);
+	/* FIXME: This is making worng assumptions about register layout. */
+	stat = cdrom_get_last_written(dev, (unsigned long *) &toc->capacity);
 	if (stat)
 		stat = cdrom_read_capacity(drive, &toc->capacity, sense);
 	if (stat)
@@ -2686,7 +2686,7 @@
 }
 
 static
-int ide_cdrom_setup (ide_drive_t *drive)
+int ide_cdrom_setup(ide_drive_t *drive)
 {
 	struct cdrom_info *info = drive->driver_data;
 	struct cdrom_device_info *cdi = &info->devinfo;
@@ -2702,7 +2702,6 @@
 
 	blk_queue_prep_rq(&drive->queue, ll_10byte_cmd_build);
 
-	drive->special.all	= 0;
 	drive->ready_stat	= 0;
 
 	CDROM_STATE_FLAGS (drive)->media_changed = 1;
@@ -2891,10 +2890,9 @@
 	set_blocksize(mk_kdev(drive->channel->major, minor), CD_FRAMESIZE);
 }
 
-static
-unsigned long ide_cdrom_capacity (ide_drive_t *drive)
+static sector_t ide_cdrom_capacity(struct ata_device *drive)
 {
-	unsigned long capacity;
+	u32 capacity;
 
 	if (cdrom_read_capacity(drive, &capacity, NULL))
 		return 0;
@@ -2934,9 +2932,7 @@
 	release:		ide_cdrom_release,
 	check_media_change:	ide_cdrom_check_media_change,
 	revalidate:		ide_cdrom_revalidate,
-	pre_reset:		NULL,
 	capacity:		ide_cdrom_capacity,
-	special:		NULL,
 	proc:			NULL
 };
 
diff -urN linux-2.5.10/drivers/ide/ide-cd.h linux/drivers/ide/ide-cd.h
--- linux-2.5.10/drivers/ide/ide-cd.h	2002-04-23 00:29:47.000000000 +0200
+++ linux/drivers/ide/ide-cd.h	2002-04-26 03:04:52.000000000 +0200
@@ -151,12 +151,11 @@
 };
 
 struct atapi_toc {
-	int    last_session_lba;
-	int    xa_flag;
-	unsigned long capacity;
+	int last_session_lba;
+	int xa_flag;
+	u32 capacity;
 	struct atapi_toc_header hdr;
-	struct atapi_toc_entry  ent[MAX_TRACKS+1];
-	  /* One extra for the leadout. */
+	struct atapi_toc_entry ent[MAX_TRACKS+1];  /* one extra for the leadout. */
 };
 
 
diff -urN linux-2.5.10/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.10/drivers/ide/ide-disk.c	2002-04-26 03:38:13.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2002-04-26 03:20:07.000000000 +0200
@@ -132,34 +132,31 @@
 	return WIN_NOP;
 }
 
-static ide_startstop_t chs_do_request(ide_drive_t *drive, struct request *rq, unsigned long block)
+static ide_startstop_t chs_do_request(struct ata_device *drive, struct request *rq, sector_t block)
 {
-	struct hd_drive_task_hdr	taskfile;
-	struct hd_drive_hob_hdr		hobfile;
-	struct ata_taskfile		args;
-	int				sectors;
+	struct ata_taskfile args;
+	int sectors;
 
 	unsigned int track	= (block / drive->sect);
 	unsigned int sect	= (block % drive->sect) + 1;
 	unsigned int head	= (track % drive->head);
 	unsigned int cyl	= (track / drive->head);
 
-	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
-	memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
-
 	sectors = rq->nr_sectors;
 	if (sectors == 256)
 		sectors = 0;
 
-	taskfile.sector_count	= sectors;
+	memset(&args, 0, sizeof(args));
+
+	args.taskfile.sector_count = sectors;
 
-	taskfile.sector_number	= sect;
-	taskfile.low_cylinder	= cyl;
-	taskfile.high_cylinder	= (cyl>>8);
-
-	taskfile.device_head	= head;
-	taskfile.device_head	|= drive->select.all;
-	taskfile.command	=  get_command(drive, rq_data_dir(rq));
+	args.taskfile.sector_number = sect;
+	args.taskfile.low_cylinder = cyl;
+	args.taskfile.high_cylinder = (cyl>>8);
+
+	args.taskfile.device_head = head;
+	args.taskfile.device_head |= drive->select.all;
+	args.taskfile.command =  get_command(drive, rq_data_dir(rq));
 
 #ifdef DEBUG
 	printk("%s: %sing: ", drive->name,
@@ -167,40 +164,35 @@
 	if (lba)	printk("LBAsect=%lld, ", block);
 	else		printk("CHS=%d/%d/%d, ", cyl, head, sect);
 	printk("sectors=%ld, ", rq->nr_sectors);
-	printk("buffer=0x%08lx\n", (unsigned long) rq->buffer);
+	printk("buffer=%p\n", rq->buffer);
 #endif
 
-	args.taskfile = taskfile;
-	args.hobfile = hobfile;
 	ide_cmd_type_parser(&args);
 	rq->special = &args;
 
 	return ata_taskfile(drive, &args, rq);
 }
 
-static ide_startstop_t lba28_do_request(ide_drive_t *drive, struct request *rq, unsigned long block)
+static ide_startstop_t lba28_do_request(struct ata_device *drive, struct request *rq, sector_t block)
 {
-	struct hd_drive_task_hdr	taskfile;
-	struct hd_drive_hob_hdr		hobfile;
-	struct ata_taskfile		args;
-	int				sectors;
+	struct ata_taskfile args;
+	int sectors;
 
 	sectors = rq->nr_sectors;
 	if (sectors == 256)
 		sectors = 0;
 
-	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
-	memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
+	memset(&args, 0, sizeof(args));
 
-	taskfile.sector_count	= sectors;
-	taskfile.sector_number	= block;
-	taskfile.low_cylinder	= (block >>= 8);
-
-	taskfile.high_cylinder	= (block >>= 8);
-
-	taskfile.device_head	= ((block >> 8) & 0x0f);
-	taskfile.device_head	|= drive->select.all;
-	taskfile.command	= get_command(drive, rq_data_dir(rq));
+	args.taskfile.sector_count = sectors;
+	args.taskfile.sector_number = block;
+	args.taskfile.low_cylinder = (block >>= 8);
+
+	args.taskfile.high_cylinder = (block >>= 8);
+
+	args.taskfile.device_head = ((block >> 8) & 0x0f);
+	args.taskfile.device_head |= drive->select.all;
+	args.taskfile.command = get_command(drive, rq_data_dir(rq));
 
 #ifdef DEBUG
 	printk("%s: %sing: ", drive->name,
@@ -208,11 +200,9 @@
 	if (lba)	printk("LBAsect=%lld, ", block);
 	else		printk("CHS=%d/%d/%d, ", cyl, head, sect);
 	printk("sectors=%ld, ", rq->nr_sectors);
-	printk("buffer=0x%08lx\n", (unsigned long) rq->buffer);
+	printk("buffer=%p\n", rq->buffer);
 #endif
 
-	args.taskfile = taskfile;
-	args.hobfile = hobfile;
 	ide_cmd_type_parser(&args);
 	rq->special = &args;
 
@@ -225,40 +215,32 @@
  * 1073741822 == 549756 MB or 48bit addressing fake drive
  */
 
-static ide_startstop_t lba48_do_request(ide_drive_t *drive, struct request *rq, unsigned long long block)
+static ide_startstop_t lba48_do_request(struct ata_device *drive, struct request *rq, sector_t block)
 {
-	struct hd_drive_task_hdr	taskfile;
-	struct hd_drive_hob_hdr		hobfile;
-	struct ata_taskfile		args;
-	int				sectors;
-
-	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
-	memset(&hobfile, 0, sizeof(struct hd_drive_hob_hdr));
+	struct ata_taskfile args;
+	int sectors;
 
 	sectors = rq->nr_sectors;
 	if (sectors == 65536)
 		sectors = 0;
 
-	taskfile.sector_count	= sectors;
-	hobfile.sector_count	= sectors >> 8;
+	memset(&args, 0, sizeof(args));
+
+	args.taskfile.sector_count = sectors;
+	args.hobfile.sector_count = sectors >> 8;
 
-	if (rq->nr_sectors == 65536) {
-		taskfile.sector_count	= 0x00;
-		hobfile.sector_count	= 0x00;
-	}
-
-	taskfile.sector_number	= block;		/* low lba */
-	taskfile.low_cylinder	= (block >>= 8);	/* mid lba */
-	taskfile.high_cylinder	= (block >>= 8);	/* hi  lba */
-
-	hobfile.sector_number	= (block >>= 8);	/* low lba */
-	hobfile.low_cylinder	= (block >>= 8);	/* mid lba */
-	hobfile.high_cylinder	= (block >>= 8);	/* hi  lba */
-
-	taskfile.device_head	= drive->select.all;
-	hobfile.device_head	= taskfile.device_head;
-	hobfile.control		= (drive->ctl|0x80);
-	taskfile.command	= get_command(drive, rq_data_dir(rq));
+	args.taskfile.sector_number = block;		/* low lba */
+	args.taskfile.low_cylinder = (block >>= 8);	/* mid lba */
+	args.taskfile.high_cylinder = (block >>= 8);	/* hi  lba */
+
+	args.hobfile.sector_number = (block >>= 8);	/* low lba */
+	args.hobfile.low_cylinder = (block >>= 8);	/* mid lba */
+	args.hobfile.high_cylinder = (block >>= 8);	/* hi  lba */
+
+	args.taskfile.device_head = drive->select.all;
+	args.hobfile.device_head = args.taskfile.device_head;
+	args.hobfile.control = (drive->ctl|0x80);
+	args.taskfile.command = get_command(drive, rq_data_dir(rq));
 
 #ifdef DEBUG
 	printk("%s: %sing: ", drive->name,
@@ -266,11 +248,9 @@
 	if (lba)	printk("LBAsect=%lld, ", block);
 	else		printk("CHS=%d/%d/%d, ", cyl, head, sect);
 	printk("sectors=%ld, ", rq->nr_sectors);
-	printk("buffer=0x%08lx\n", (unsigned long) rq->buffer);
+	printk("buffer=%p\n",rq->buffer);
 #endif
 
-	args.taskfile = taskfile;
-	args.hobfile = hobfile;
 	ide_cmd_type_parser(&args);
 	rq->special = &args;
 
@@ -282,7 +262,7 @@
  * otherwise, to address sectors.  It also takes care of issuing special
  * DRIVE_CMDs.
  */
-static ide_startstop_t idedisk_do_request(ide_drive_t *drive, struct request *rq, unsigned long block)
+static ide_startstop_t idedisk_do_request(struct ata_device *drive, struct request *rq, sector_t block)
 {
 	/*
 	 * Wait until all request have bin finished.
@@ -290,7 +270,7 @@
 
 	while (drive->blocked) {
 		yield();
-		printk("ide: Request while drive blocked?");
+		printk(KERN_ERR "ide: Request while drive blocked?");
 	}
 
 	if (!(rq->flags & REQ_CMD)) {
@@ -300,7 +280,7 @@
 	}
 
 	if (IS_PDC4030_DRIVE) {
-		extern ide_startstop_t promise_rw_disk(ide_drive_t *, struct request *, unsigned long);
+		extern ide_startstop_t promise_rw_disk(struct ata_device *, struct request *, unsigned long);
 
 		return promise_rw_disk(drive, rq, block);
 	}
@@ -386,256 +366,19 @@
 	return drive->removable;
 }
 
-/*
- * Queries for true maximum capacity of the drive.
- * Returns maximum LBA address (> 0) of the drive, 0 if failed.
- */
-static unsigned long idedisk_read_native_max_address(ide_drive_t *drive)
+static sector_t idedisk_capacity(struct ata_device *drive)
 {
-	struct ata_taskfile args;
-	unsigned long addr = 0;
-
-	if (!(drive->id->command_set_1 & 0x0400) &&
-	    !(drive->id->cfs_enable_2 & 0x0100))
-		return addr;
-
-	/* Create IDE/ATA command request structure */
-	memset(&args, 0, sizeof(args));
-	args.taskfile.device_head = 0x40;
-	args.taskfile.command = WIN_READ_NATIVE_MAX;
-	args.handler = task_no_data_intr;
-
-	/* submit command request */
-	ide_raw_taskfile(drive, &args, NULL);
-
-	/* if OK, compute maximum address value */
-	if ((args.taskfile.command & 0x01) == 0) {
-		addr = ((args.taskfile.device_head & 0x0f) << 24)
-		     | (args.taskfile.high_cylinder << 16)
-		     | (args.taskfile.low_cylinder <<  8)
-		     | args.taskfile.sector_number;
-	}
-
-	addr++;	/* since the return value is (maxlba - 1), we add 1 */
-
-	return addr;
-}
-
-static unsigned long long idedisk_read_native_max_address_ext(ide_drive_t *drive)
-{
-	struct ata_taskfile args;
-	unsigned long long addr = 0;
-
-	/* Create IDE/ATA command request structure */
-	memset(&args, 0, sizeof(args));
-
-	args.taskfile.device_head = 0x40;
-	args.taskfile.command = WIN_READ_NATIVE_MAX_EXT;
-	args.handler = task_no_data_intr;
-
-        /* submit command request */
-        ide_raw_taskfile(drive, &args, NULL);
-
-	/* if OK, compute maximum address value */
-	if ((args.taskfile.command & 0x01) == 0) {
-		u32 high = (args.hobfile.high_cylinder << 16) |
-			   (args.hobfile.low_cylinder << 8) |
-			    args.hobfile.sector_number;
-		u32 low  = (args.taskfile.high_cylinder << 16) |
-			   (args.taskfile.low_cylinder << 8) |
-			    args.taskfile.sector_number;
-		addr = ((__u64)high << 24) | low;
-	}
-
-	addr++;	/* since the return value is (maxlba - 1), we add 1 */
-
-	return addr;
+	return drive->capacity - drive->sect0;
 }
 
-#ifdef CONFIG_IDEDISK_STROKE
-/*
- * Sets maximum virtual LBA address of the drive.
- * Returns new maximum virtual LBA address (> 0) or 0 on failure.
- */
-static unsigned long idedisk_set_max_address(ide_drive_t *drive, unsigned long addr_req)
+static ide_startstop_t idedisk_special(struct ata_device *drive)
 {
-	struct ata_taskfile args;
-	unsigned long addr_set = 0;
-
-	addr_req--;
-	/* Create IDE/ATA command request structure */
-	memset(&args, 0, sizeof(args));
-
-	args.taskfile.sector_number = (addr_req >> 0);
-	args.taskfile.low_cylinder = (addr_req >> 8);
-	args.taskfile.high_cylinder = (addr_req >> 16);
+	unsigned char special_cmd = drive->special_cmd;
 
-	args.taskfile.device_head = ((addr_req >> 24) & 0x0f) | 0x40;
-	args.taskfile.command = WIN_SET_MAX;
-	args.handler = task_no_data_intr;
-	/* submit command request */
-	ide_raw_taskfile(drive, &args, NULL);
-	/* if OK, read new maximum address value */
-	if ((args.taskfile.command & 0x01) == 0) {
-		addr_set = ((args.taskfile.device_head & 0x0f) << 24)
-			 | (args.taskfile.high_cylinder << 16)
-			 | (args.taskfile.low_cylinder <<  8)
-			 | args.taskfile.sector_number;
-	}
-	addr_set++;
-	return addr_set;
-}
-
-static unsigned long long idedisk_set_max_address_ext(ide_drive_t *drive, unsigned long long addr_req)
-{
-	struct ata_taskfile args;
-	unsigned long long addr_set = 0;
-
-	addr_req--;
-	/* Create IDE/ATA command request structure */
-	memset(&args, 0, sizeof(args));
-
-	args.taskfile.sector_number = (addr_req >>  0);
-	args.taskfile.low_cylinder = (addr_req >>= 8);
-	args.taskfile.high_cylinder = (addr_req >>= 8);
-	args.taskfile.device_head = 0x40;
-	args.taskfile.command = WIN_SET_MAX_EXT;
-
-	args.hobfile.sector_number = (addr_req >>= 8);
-	args.hobfile.low_cylinder = (addr_req >>= 8);
-	args.hobfile.high_cylinder = (addr_req >>= 8);
-
-	args.hobfile.device_head = 0x40;
-	args.hobfile.control = (drive->ctl | 0x80);
-
-        args.handler = task_no_data_intr;
-	/* submit command request */
-	ide_raw_taskfile(drive, &args, NULL);
-	/* if OK, compute maximum address value */
-	if ((args.taskfile.command & 0x01) == 0) {
-		u32 high = (args.hobfile.high_cylinder << 16) |
-			   (args.hobfile.low_cylinder << 8) |
-			    args.hobfile.sector_number;
-		u32 low  = (args.taskfile.high_cylinder << 16) |
-			   (args.taskfile.low_cylinder << 8) |
-			    args.taskfile.sector_number;
-		addr_set = ((__u64)high << 24) | low;
-	}
-	return addr_set;
-}
-
-/*
- * Tests if the drive supports Host Protected Area feature.
- * Returns true if supported, false otherwise.
- */
-static inline int idedisk_supports_host_protected_area(ide_drive_t *drive)
-{
-	int flag = (drive->id->cfs_enable_1 & 0x0400) ? 1 : 0;
-	printk("%s: host protected area => %d\n", drive->name, flag);
-	return flag;
-}
-
-#endif
-
-/*
- * Compute drive->capacity, the full capacity of the drive
- * Called with drive->id != NULL.
- *
- * To compute capacity, this uses either of
- *
- *    1. CHS value set by user       (whatever user sets will be trusted)
- *    2. LBA value from target drive (require new ATA feature)
- *    3. LBA value from system BIOS  (new one is OK, old one may break)
- *    4. CHS value from system BIOS  (traditional style)
- *
- * in above order (i.e., if value of higher priority is available,
- * reset will be ignored).
- */
-static void init_idedisk_capacity (ide_drive_t  *drive)
-{
-	struct hd_driveid *id = drive->id;
-	unsigned long capacity = drive->cyl * drive->head * drive->sect;
-	unsigned long set_max = idedisk_read_native_max_address(drive);
-	unsigned long long capacity_2 = capacity;
-	unsigned long long set_max_ext;
-
-	drive->capacity48 = 0;
-	drive->select.b.lba = 0;
-
-	if (id->cfs_enable_2 & 0x0400) {
-		capacity_2 = id->lba_capacity_2;
-		drive->cyl = (unsigned int) capacity_2 / (drive->head * drive->sect);
-		drive->head		= drive->bios_head = 255;
-		drive->sect		= drive->bios_sect = 63;
-		drive->select.b.lba	= 1;
-		set_max_ext = idedisk_read_native_max_address_ext(drive);
-		if (set_max_ext > capacity_2) {
-#ifdef CONFIG_IDEDISK_STROKE
-			set_max_ext = idedisk_read_native_max_address_ext(drive);
-			set_max_ext = idedisk_set_max_address_ext(drive, set_max_ext);
-			if (set_max_ext) {
-				drive->capacity48 = capacity_2 = set_max_ext;
-				drive->cyl = (unsigned int) set_max_ext / (drive->head * drive->sect);
-				drive->select.b.lba = 1;
-				drive->id->lba_capacity_2 = capacity_2;
-                        }
-#else
-			printk("%s: setmax_ext LBA %llu, native  %llu\n",
-				drive->name, set_max_ext, capacity_2);
-#endif
-		}
-		drive->bios_cyl		= drive->cyl;
-		drive->capacity48	= capacity_2;
-		drive->capacity		= (unsigned long) capacity_2;
-		return;
-	/* Determine capacity, and use LBA if the drive properly supports it */
-	} else if ((id->capability & 2) && lba_capacity_is_ok(id)) {
-		capacity = id->lba_capacity;
-		drive->cyl = capacity / (drive->head * drive->sect);
-		drive->select.b.lba = 1;
-	}
-
-	if (set_max > capacity) {
-#ifdef CONFIG_IDEDISK_STROKE
-		set_max = idedisk_read_native_max_address(drive);
-		set_max = idedisk_set_max_address(drive, set_max);
-		if (set_max) {
-			drive->capacity = capacity = set_max;
-			drive->cyl = set_max / (drive->head * drive->sect);
-			drive->select.b.lba = 1;
-			drive->id->lba_capacity = capacity;
-		}
-#else
-		printk("%s: setmax LBA %lu, native  %lu\n",
-			drive->name, set_max, capacity);
-#endif
-	}
-
-	drive->capacity = capacity;
-
-	if ((id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400)) {
-                drive->capacity48 = id->lba_capacity_2;
-		drive->head = 255;
-		drive->sect = 63;
-		drive->cyl = (unsigned long)(drive->capacity48) / (drive->head * drive->sect);
-	}
-}
-
-static unsigned long idedisk_capacity (ide_drive_t *drive)
-{
-	if (drive->id->cfs_enable_2 & 0x0400)
-		return (drive->capacity48 - drive->sect0);
-	return (drive->capacity - drive->sect0);
-}
-
-static ide_startstop_t idedisk_special (ide_drive_t *drive)
-{
-	special_t *s = &drive->special;
-
-	if (s->b.set_geometry) {
+	if (special_cmd & ATA_SPECIAL_GEOMETRY) {
 		struct ata_taskfile args;
 
-		s->b.set_geometry	= 0;
+		drive->special_cmd &= ~ATA_SPECIAL_GEOMETRY;
 
 		memset(&args, 0, sizeof(args));
 		args.taskfile.sector_number	= drive->sect;
@@ -648,8 +391,9 @@
 			args.handler = set_geometry_intr;;
 		}
 		ata_taskfile(drive, &args, NULL);
-	} else if (s->b.recalibrate) {
-		s->b.recalibrate = 0;
+	} else if (special_cmd & ATA_SPECIAL_RECALIBRATE) {
+		drive->special_cmd &= ~ATA_SPECIAL_RECALIBRATE;
+
 		if (!IS_PDC4030_DRIVE) {
 			struct ata_taskfile args;
 
@@ -659,8 +403,8 @@
 			args.handler = recal_intr;
 			ata_taskfile(drive, &args, NULL);
 		}
-	} else if (s->b.set_multmode) {
-		s->b.set_multmode = 0;
+	} else if (special_cmd & ATA_SPECIAL_MMODE) {
+		drive->special_cmd &= ~ATA_SPECIAL_MMODE;
 		if (drive->id && drive->mult_req > drive->id->max_multsect)
 			drive->mult_req = drive->id->max_multsect;
 		if (!IS_PDC4030_DRIVE) {
@@ -673,10 +417,10 @@
 
 			ata_taskfile(drive, &args, NULL);
 		}
-	} else if (s->all) {
-		int special = s->all;
-		s->all = 0;
-		printk(KERN_ERR "%s: bad special flag: 0x%02x\n", drive->name, special);
+	} else if (special_cmd) {
+		drive->special_cmd = 0;
+
+		printk(KERN_ERR "%s: bad special flag: 0x%02x\n", drive->name, special_cmd);
 		return ide_stopped;
 	}
 	return IS_PDC4030_DRIVE ? ide_stopped : ide_started;
@@ -686,13 +430,14 @@
 {
 	int legacy = (drive->id->cfs_enable_2 & 0x0400) ? 0 : 1;
 
-	drive->special.all = 0;
-	drive->special.b.set_geometry = legacy;
-	drive->special.b.recalibrate  = legacy;
+	if (legacy)
+		drive->special_cmd = (ATA_SPECIAL_GEOMETRY | ATA_SPECIAL_RECALIBRATE);
+	else
+		drive->special_cmd = 0;
 	if (OK_TO_RESET_CONTROLLER)
 		drive->mult_count = 0;
 	if (drive->mult_req != drive->mult_count)
-		drive->special.b.set_multmode = 1;
+		drive->special_cmd |= ATA_SPECIAL_MMODE;
 }
 
 #ifdef CONFIG_PROC_FS
@@ -812,19 +557,23 @@
 #endif	/* CONFIG_PROC_FS */
 
 /*
- * This is tightly woven into the driver->do_special can not touch.
+ * This is tightly woven into the driver->special can not touch.
  * DON'T do it again until a total personality rewrite is committed.
  */
 static int set_multcount(ide_drive_t *drive, int arg)
 {
-	struct request rq;
+	struct ata_taskfile args;
 
-	if (drive->special.b.set_multmode)
+	if (drive->special_cmd & ATA_SPECIAL_MMODE)
 		return -EBUSY;
-	ide_init_drive_cmd (&rq);
+
+	memset(&args, 0, sizeof(args));
+
 	drive->mult_req = arg;
-	drive->special.b.set_multmode = 1;
-	ide_do_drive_cmd (drive, &rq, ide_wait);
+	drive->special_cmd |= ATA_SPECIAL_MMODE;
+
+	ide_raw_taskfile(drive, &args, NULL);
+
 	return (drive->mult_count == arg) ? 0 : -EIO;
 }
 
@@ -835,6 +584,7 @@
 	drive->nowerr = arg;
 	drive->bad_wstat = arg ? BAD_R_STAT : BAD_W_STAT;
 	spin_unlock_irq(&ide_lock);
+
 	return 0;
 }
 
@@ -968,12 +718,153 @@
 	resume: idedisk_resume,
 };
 
-static void idedisk_setup(ide_drive_t *drive)
+/*
+ * Queries for true maximum capacity of the drive.
+ * Returns maximum LBA address (> 0) of the drive, 0 if failed.
+ */
+static unsigned long native_max_address(struct ata_device *drive)
+{
+	struct ata_taskfile args;
+	unsigned long addr = 0;
+
+	if (!(drive->id->command_set_1 & 0x0400) &&
+	    !(drive->id->cfs_enable_2 & 0x0100))
+		return addr;
+
+	/* Create IDE/ATA command request structure */
+	memset(&args, 0, sizeof(args));
+	args.taskfile.device_head = 0x40;
+	args.taskfile.command = WIN_READ_NATIVE_MAX;
+	args.handler = task_no_data_intr;
+
+	/* submit command request */
+	ide_raw_taskfile(drive, &args, NULL);
+
+	/* if OK, compute maximum address value */
+	if ((args.taskfile.command & 0x01) == 0) {
+		addr = ((args.taskfile.device_head & 0x0f) << 24)
+		     | (args.taskfile.high_cylinder << 16)
+		     | (args.taskfile.low_cylinder <<  8)
+		     | args.taskfile.sector_number;
+	}
+
+	addr++;	/* since the return value is (maxlba - 1), we add 1 */
+
+	return addr;
+}
+
+static u64 native_max_address_ext(struct ata_device *drive)
+{
+	struct ata_taskfile args;
+	u64 addr = 0;
+
+	/* Create IDE/ATA command request structure */
+	memset(&args, 0, sizeof(args));
+
+	args.taskfile.device_head = 0x40;
+	args.taskfile.command = WIN_READ_NATIVE_MAX_EXT;
+	args.handler = task_no_data_intr;
+
+        /* submit command request */
+        ide_raw_taskfile(drive, &args, NULL);
+
+	/* if OK, compute maximum address value */
+	if ((args.taskfile.command & 0x01) == 0) {
+		u32 high = (args.hobfile.high_cylinder << 16) |
+			   (args.hobfile.low_cylinder << 8) |
+			    args.hobfile.sector_number;
+		u32 low  = (args.taskfile.high_cylinder << 16) |
+			   (args.taskfile.low_cylinder << 8) |
+			    args.taskfile.sector_number;
+		addr = ((u64)high << 24) | low;
+	}
+
+	addr++;	/* since the return value is (maxlba - 1), we add 1 */
+
+	return addr;
+}
+
+#ifdef CONFIG_IDEDISK_STROKE
+/*
+ * Sets maximum virtual LBA address of the drive.
+ * Returns new maximum virtual LBA address (> 0) or 0 on failure.
+ */
+static sector_t set_max_address(ide_drive_t *drive, sector_t addr_req)
+{
+	struct ata_taskfile args;
+	sector_t addr_set = 0;
+
+	addr_req--;
+	/* Create IDE/ATA command request structure */
+	memset(&args, 0, sizeof(args));
+
+	args.taskfile.sector_number = (addr_req >> 0);
+	args.taskfile.low_cylinder = (addr_req >> 8);
+	args.taskfile.high_cylinder = (addr_req >> 16);
+
+	args.taskfile.device_head = ((addr_req >> 24) & 0x0f) | 0x40;
+	args.taskfile.command = WIN_SET_MAX;
+	args.handler = task_no_data_intr;
+	/* submit command request */
+	ide_raw_taskfile(drive, &args, NULL);
+	/* if OK, read new maximum address value */
+	if ((args.taskfile.command & 0x01) == 0) {
+		addr_set = ((args.taskfile.device_head & 0x0f) << 24)
+			 | (args.taskfile.high_cylinder << 16)
+			 | (args.taskfile.low_cylinder <<  8)
+			 | args.taskfile.sector_number;
+	}
+	addr_set++;
+	return addr_set;
+}
+
+static u64 set_max_address_ext(ide_drive_t *drive, u64 addr_req)
+{
+	struct ata_taskfile args;
+	u64 addr_set = 0;
+
+	addr_req--;
+	/* Create IDE/ATA command request structure */
+	memset(&args, 0, sizeof(args));
+
+	args.taskfile.sector_number = (addr_req >>  0);
+	args.taskfile.low_cylinder = (addr_req >>= 8);
+	args.taskfile.high_cylinder = (addr_req >>= 8);
+	args.taskfile.device_head = 0x40;
+	args.taskfile.command = WIN_SET_MAX_EXT;
+
+	args.hobfile.sector_number = (addr_req >>= 8);
+	args.hobfile.low_cylinder = (addr_req >>= 8);
+	args.hobfile.high_cylinder = (addr_req >>= 8);
+
+	args.hobfile.device_head = 0x40;
+	args.hobfile.control = (drive->ctl | 0x80);
+
+        args.handler = task_no_data_intr;
+	/* submit command request */
+	ide_raw_taskfile(drive, &args, NULL);
+	/* if OK, compute maximum address value */
+	if ((args.taskfile.command & 0x01) == 0) {
+		u32 high = (args.hobfile.high_cylinder << 16) |
+			   (args.hobfile.low_cylinder << 8) |
+			    args.hobfile.sector_number;
+		u32 low  = (args.taskfile.high_cylinder << 16) |
+			   (args.taskfile.low_cylinder << 8) |
+			    args.taskfile.sector_number;
+		addr_set = ((u64)high << 24) | low;
+	}
+	return addr_set;
+}
+
+#endif
+
+static void idedisk_setup(struct ata_device *drive)
 {
 	int i;
 
 	struct hd_driveid *id = drive->id;
-	unsigned long capacity;
+	sector_t capacity;
+	sector_t set_max;
 	int drvid = -1;
 
 	idedisk_add_settings(drive);
@@ -1024,7 +915,7 @@
 		drive->sect    = drive->bios_sect = id->sectors;
 	}
 
-	/* Handle logical geometry translation by the drive */
+	/* Handle logical geometry translation by the drive. */
 	if ((id->field_valid & 1) && id->cur_cyls &&
 	    id->cur_heads && (id->cur_heads <= 16) && id->cur_sectors) {
 		drive->cyl  = id->cur_cyls;
@@ -1032,31 +923,126 @@
 		drive->sect = id->cur_sectors;
 	}
 
-	/* Use physical geometry if what we have still makes no sense */
+	/* Use physical geometry if what we have still makes no sense. */
 	if (drive->head > 16 && id->heads && id->heads <= 16) {
 		drive->cyl  = id->cyls;
 		drive->head = id->heads;
 		drive->sect = id->sectors;
 	}
 
-	/* calculate drive capacity, and select LBA if possible */
-	init_idedisk_capacity (drive);
+	/* Calculate drive capacity, and select LBA if possible.
+	 * drive->id != NULL is spected
+	 *
+	 * To compute capacity, this uses either of
+	 *
+	 *    1. CHS value set by user       (whatever user sets will be trusted)
+	 *    2. LBA value from target drive (require new ATA feature)
+	 *    3. LBA value from system BIOS  (new one is OK, old one may break)
+	 *    4. CHS value from system BIOS  (traditional style)
+	 *
+	 * in above order (i.e., if value of higher priority is available,
+	 * reset will be ignored).
+	 */
+	capacity = drive->cyl * drive->head * drive->sect;
+	set_max = native_max_address(drive);
+
+	drive->capacity = 0;
+	drive->select.b.lba = 0;
+
+	if (id->cfs_enable_2 & 0x0400) {
+		u64 set_max_ext;
+		u64 capacity_2;
+		capacity_2 = capacity;
+		capacity_2 = id->lba_capacity_2;
+
+		drive->cyl = (unsigned int) capacity_2 / (drive->head * drive->sect);
+		drive->head = drive->bios_head = 255;
+		drive->sect = drive->bios_sect = 63;
+
+		drive->select.b.lba = 1;
+		set_max_ext = native_max_address_ext(drive);
+		if (set_max_ext > capacity_2) {
+#ifdef CONFIG_IDEDISK_STROKE
+			set_max_ext = native_max_address_ext(drive);
+			set_max_ext = set_max_address_ext(drive, set_max_ext);
+			if (set_max_ext) {
+				drive->capacity = capacity_2 = set_max_ext;
+				drive->cyl = (unsigned int) set_max_ext / (drive->head * drive->sect);
+				drive->select.b.lba = 1;
+				drive->id->lba_capacity_2 = capacity_2;
+                        }
+#else
+			printk("%s: setmax_ext LBA %llu, native  %llu\n",
+				drive->name, set_max_ext, capacity_2);
+#endif
+		}
+		drive->bios_cyl	= drive->cyl;
+		drive->capacity	= capacity_2;
+	} else {
+
+		/*
+		 * Determine capacity, and use LBA if the drive properly
+		 * supports it.
+		 */
+
+		if ((id->capability & 2) && lba_capacity_is_ok(id)) {
+			capacity = id->lba_capacity;
+			drive->cyl = capacity / (drive->head * drive->sect);
+			drive->select.b.lba = 1;
+		}
+
+		if (set_max > capacity) {
+#ifdef CONFIG_IDEDISK_STROKE
+			set_max = native_max_address(drive);
+			set_max = set_max_address(drive, set_max);
+			if (set_max) {
+				drive->capacity = capacity = set_max;
+				drive->cyl = set_max / (drive->head * drive->sect);
+				drive->select.b.lba = 1;
+				drive->id->lba_capacity = capacity;
+			}
+#else
+			printk("%s: setmax LBA %lu, native  %lu\n",
+					drive->name, set_max, capacity);
+#endif
+		}
+
+		drive->capacity = capacity;
+
+		if ((id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400)) {
+			drive->capacity = id->lba_capacity_2;
+			drive->head = 255;
+			drive->sect = 63;
+			drive->cyl = (unsigned long)(drive->capacity) / (drive->head * drive->sect);
+		}
+	}
 
 	/*
-	 * if possible, give fdisk access to more of the drive,
+	 * If possible, give fdisk access to more of the drive,
 	 * by correcting bios_cyls:
 	 */
-	capacity = idedisk_capacity (drive);
+	capacity = idedisk_capacity(drive);
 	if ((capacity >= (drive->bios_cyl * drive->bios_sect * drive->bios_head)) &&
 	    (!drive->forced_geom) && drive->bios_sect && drive->bios_head)
 		drive->bios_cyl = (capacity / drive->bios_sect) / drive->bios_head;
 	printk(KERN_INFO "%s: %ld sectors", drive->name, capacity);
 
-	/* Give size in megabytes (MB), not mebibytes (MiB). */
-	/* We compute the exact rounded value, avoiding overflow. */
+#if 0
+
+	/* Right now we avoid this calculation, since it can result in the
+	 * usage of not supported compiler internal functions on 32 bit hosts.
+	 * However since the calculation appears to be an interesting piece of
+	 * number theory let's preserve the formula here.
+	 */
+
+	/* Give size in megabytes (MB), not mebibytes (MiB).
+	 * We compute the exact rounded value, avoiding overflow.
+	 */
 	printk(" (%ld MB)", (capacity - capacity/625 + 974)/1950);
+#endif
 
-	/* Only print cache size when it was specified */
+	/* Only print cache size when it was specified.
+	 */
 	if (id->buf_size)
 		printk (" w/%dKiB Cache", id->buf_size/2);
 
@@ -1074,14 +1060,15 @@
 		id->multsect = ((id->max_multsect/2) > 1) ? id->max_multsect : 0;
 		id->multsect_valid = id->multsect ? 1 : 0;
 		drive->mult_req = id->multsect_valid ? id->max_multsect : INITIAL_MULT_COUNT;
-		drive->special.b.set_multmode = drive->mult_req ? 1 : 0;
+		if (drive->mult_req)
+			drive->special_cmd |= ATA_SPECIAL_MMODE;
 #else
 		/* original, pre IDE-NFG, per request of AC */
 		drive->mult_req = INITIAL_MULT_COUNT;
 		if (drive->mult_req > id->max_multsect)
 			drive->mult_req = id->max_multsect;
 		if (drive->mult_req || ((id->multsect_valid & 1) && id->multsect))
-			drive->special.b.set_multmode = 1;
+			drive->special_cmd |= ATA_SPECIAL_MMODE;
 #endif
 	}
 
@@ -1095,6 +1082,7 @@
 
 	if (drive->id->cfs_enable_2 & 0x3000)
 		write_cache(drive, (id->cfs_enable_2 & 0x3000));
+
 	probe_lba_addressing(drive, 1);
 }
 
diff -urN linux-2.5.10/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- linux-2.5.10/drivers/ide/ide-dma.c	2002-04-26 03:38:13.000000000 +0200
+++ linux/drivers/ide/ide-dma.c	2002-04-25 23:20:20.000000000 +0200
@@ -295,7 +295,7 @@
 	int i;
 	struct scatterlist *sg;
 
-	if (HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE) {
+	if (HWGROUP(drive)->rq->flags & REQ_DRIVE_ACB) {
 		hwif->sg_nents = i = raw_build_sglist(hwif, HWGROUP(drive)->rq);
 	} else {
 		hwif->sg_nents = i = ide_build_sglist(hwif, HWGROUP(drive)->rq);
@@ -590,9 +590,10 @@
 
 			BUG_ON(HWGROUP(drive)->handler);
 			ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, dma_timer_expiry);	/* issue cmd to drive */
-			if ((HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE) &&
+			if ((HWGROUP(drive)->rq->flags & REQ_DRIVE_ACB) &&
 			    (drive->addressing == 1)) {
 				struct ata_taskfile *args = HWGROUP(drive)->rq->special;
+
 				OUT_BYTE(args->taskfile.command, IDE_COMMAND_REG);
 			} else if (drive->addressing) {
 				OUT_BYTE(reading ? WIN_READDMA_EXT : WIN_WRITEDMA_EXT, IDE_COMMAND_REG);
diff -urN linux-2.5.10/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux-2.5.10/drivers/ide/ide-floppy.c	2002-04-23 00:28:19.000000000 +0200
+++ linux/drivers/ide/ide-floppy.c	2002-04-26 00:32:21.000000000 +0200
@@ -1255,12 +1255,12 @@
 	pc->c[0] = IDEFLOPPY_TEST_UNIT_READY_CMD;
 }
 
-static void idefloppy_create_rw_cmd (idefloppy_floppy_t *floppy, idefloppy_pc_t *pc, struct request *rq, unsigned long sector)
+static void idefloppy_create_rw_cmd(idefloppy_floppy_t *floppy, idefloppy_pc_t *pc, struct request *rq, sector_t sector)
 {
 	int block = sector / floppy->bs_factor;
 	int blocks = rq->nr_sectors / floppy->bs_factor;
 	int cmd = rq_data_dir(rq);
-	
+
 #if IDEFLOPPY_DEBUG_LOG
 	printk ("create_rw1%d_cmd: block == %d, blocks == %d\n",
 		2 * test_bit (IDEFLOPPY_USE_READ12, &floppy->flags), block, blocks);
@@ -1287,9 +1287,9 @@
 }
 
 /*
- *	idefloppy_do_request is our request handling function.	
+ * This is our request handling function.
  */
-static ide_startstop_t idefloppy_do_request (ide_drive_t *drive, struct request *rq, unsigned long block)
+static ide_startstop_t idefloppy_do_request(struct ata_device *drive, struct request *rq, sector_t block)
 {
 	idefloppy_floppy_t *floppy = drive->driver_data;
 	idefloppy_pc_t *pc;
@@ -1297,7 +1297,7 @@
 #if IDEFLOPPY_DEBUG_LOG
 	printk (KERN_INFO "rq_status: %d, rq_dev: %u, flags: %lx, errors: %d\n",rq->rq_status,(unsigned int) rq->rq_dev,rq->flags,rq->errors);
 	printk (KERN_INFO "sector: %ld, nr_sectors: %ld, current_nr_sectors: %d\n",rq->sector,rq->nr_sectors,rq->current_nr_sectors);
-#endif /* IDEFLOPPY_DEBUG_LOG */
+#endif
 
 	if (rq->errors >= ERROR_MAX) {
 		if (floppy->failed_pc != NULL)
@@ -1314,7 +1314,7 @@
 			idefloppy_end_request(drive, 0);
 			return ide_stopped;
 		}
-		pc = idefloppy_next_pc_storage (drive);
+		pc = idefloppy_next_pc_storage(drive);
 		idefloppy_create_rw_cmd (floppy, pc, rq, block);
 	} else if (rq->flags & IDEFLOPPY_RQ) {
 		pc = (idefloppy_pc_t *) rq->buffer;
@@ -2063,9 +2063,7 @@
 	release:		idefloppy_release,
 	check_media_change:	idefloppy_check_media_change,
 	revalidate:		NULL, /* use default method */
-	pre_reset:		NULL,
 	capacity:		idefloppy_capacity,
-	special:		NULL,
 	proc:			idefloppy_proc
 };
 
diff -urN linux-2.5.10/drivers/ide/ide-pmac.c linux/drivers/ide/ide-pmac.c
--- linux-2.5.10/drivers/ide/ide-pmac.c	2002-04-23 00:29:34.000000000 +0200
+++ linux/drivers/ide/ide-pmac.c	2002-04-25 23:27:08.000000000 +0200
@@ -1109,7 +1109,7 @@
 		udelay(1);
 
 	/* Build sglist */
-	if (rq->flags & REQ_DRIVE_TASKFILE) {
+	if (rq->flags & REQ_DRIVE_ACB) {
 		pmac_ide[ix].sg_nents = i = pmac_raw_build_sglist(ix, rq);
 	} else {
 		pmac_ide[ix].sg_nents = i = pmac_ide_build_sglist(ix, rq);
@@ -1386,7 +1386,7 @@
 			return 0;
 		BUG_ON(HWGROUP(drive)->handler);
 		ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, NULL);
-		if ((HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE) &&
+		if ((HWGROUP(drive)->rq->flags & REQ_DRIVE_ACB) &&
 		    (drive->addressing == 1)) {
 			struct ata_taskfile *args = HWGROUP(drive)->rq->special;
 			OUT_BYTE(args->taskfile.command, IDE_COMMAND_REG);
diff -urN linux-2.5.10/drivers/ide/ide-proc.c linux/drivers/ide/ide-proc.c
--- linux-2.5.10/drivers/ide/ide-proc.c	2002-04-23 00:27:49.000000000 +0200
+++ linux/drivers/ide/ide-proc.c	2002-04-26 00:09:09.000000000 +0200
@@ -160,8 +160,8 @@
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
 
-static int proc_ide_read_channel
-	(char *page, char **start, off_t off, int count, int *eof, void *data)
+static int proc_ide_read_channel(char *page, char **start,
+		off_t off, int count, int *eof, void *data)
 {
 	struct ata_channel *hwif = data;
 	int		len;
diff -urN linux-2.5.10/drivers/ide/ide-tape.c linux/drivers/ide/ide-tape.c
--- linux-2.5.10/drivers/ide/ide-tape.c	2002-04-23 00:28:08.000000000 +0200
+++ linux/drivers/ide/ide-tape.c	2002-04-25 21:57:49.000000000 +0200
@@ -2614,9 +2614,9 @@
 }
 
 /*
- *	idetape_do_request is our request handling function.	
+ * This is our request handling function.
  */
-static ide_startstop_t idetape_do_request (ide_drive_t *drive, struct request *rq, unsigned long block)
+static ide_startstop_t idetape_do_request(struct ata_device *drive, struct request *rq, sector_t block)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	idetape_pc_t *pc;
diff -urN linux-2.5.10/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.10/drivers/ide/ide-taskfile.c	2002-04-26 03:38:13.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-04-26 01:44:57.000000000 +0200
@@ -476,15 +476,15 @@
 /*
  * This is invoked on completion of a WIN_SETMULT cmd.
  */
-ide_startstop_t set_multmode_intr (ide_drive_t *drive)
+ide_startstop_t set_multmode_intr(struct ata_device *drive)
 {
-	byte stat;
+	u8 stat;
 
 	if (OK_STAT(stat=GET_STAT(),READY_STAT,BAD_STAT)) {
 		drive->mult_count = drive->mult_req;
 	} else {
 		drive->mult_req = drive->mult_count = 0;
-		drive->special.b.recalibrate = 1;
+		drive->special_cmd |= ATA_SPECIAL_RECALIBRATE;
 		ide_dump_status(drive, "set_multmode", stat);
 	}
 	return ide_stopped;
@@ -879,20 +879,12 @@
 	}
 }
 
-/*
- * This function is intended to be used prior to invoking ide_do_drive_cmd().
- */
-static void init_taskfile_request(struct request *rq)
-{
-	memset(rq, 0, sizeof(*rq));
-	rq->flags = REQ_DRIVE_TASKFILE;
-}
-
 int ide_raw_taskfile(ide_drive_t *drive, struct ata_taskfile *args, byte *buf)
 {
 	struct request rq;
-	init_taskfile_request(&rq);
 
+	memset(&rq, 0, sizeof(rq));
+	rq.flags = REQ_DRIVE_ACB;
 	rq.buffer = buf;
 
 	if (args->command_type != IDE_DRIVE_TASK_NO_DATA)
@@ -909,13 +901,8 @@
  * Implement generic ioctls invoked from userspace to imlpement specific
  * functionality.
  *
- * FIXME:
- *
- * 1. Rewrite hdparm to use the ide_task_ioctl function.
- *
- * 2. Publish it.
- *
- * 3. Kill this and HDIO_DRIVE_CMD alltogether.
+ * Unfortunately every single low level programm out there is using this
+ * interface.
  */
 
 int ide_cmd_ioctl(ide_drive_t *drive, unsigned long arg)
@@ -923,22 +910,19 @@
 	int err = 0;
 	u8 vals[4];
 	u8 *argbuf = vals;
-	byte xfer_rate = 0;
+	u8 xfer_rate = 0;
 	int argsize = 4;
 	struct ata_taskfile args;
 	struct request rq;
 
-	/*
-	 * First phase.
+	ide_init_drive_cmd(&rq);
+
+	/* Wait for drive ready.
 	 */
-	if (NULL == (void *) arg) {
-		struct request rq;
-		ide_init_drive_cmd(&rq);
+	if (!arg)
 		return ide_do_drive_cmd(drive, &rq, ide_wait);
-	}
 
-	/*
-	 * Second phase.
+	/* Second phase.
 	 */
 	if (copy_from_user(vals, (void *)arg, 4))
 		return -EFAULT;
@@ -960,6 +944,8 @@
 		memset(argbuf + 4, 0, argsize - 4);
 	}
 
+	/* Always make sure the transfer reate has been setup.
+	 */
 	if (set_transfer(drive, &args)) {
 		xfer_rate = vals[1];
 		if (ide_ata66_check(drive, &args))
@@ -968,7 +954,6 @@
 
 	/* Issue ATA command and wait for completion.
 	 */
-	ide_init_drive_cmd(&rq);
 	rq.buffer = argbuf;
 	err = ide_do_drive_cmd(drive, &rq, ide_wait);
 
@@ -978,44 +963,22 @@
 			drive->channel->speedproc(drive, xfer_rate);
 		ide_driveid_update(drive);
 	}
+
 abort:
 	if (copy_to_user((void *)arg, argbuf, argsize))
 		err = -EFAULT;
+
 	if (argsize > 4)
 		kfree(argbuf);
 
 	return err;
 }
 
-int ide_task_ioctl(ide_drive_t *drive, unsigned long arg)
-{
-	int err = 0;
-	u8 args[7];
-	u8 *argbuf;
-	int argsize = 7;
-	struct request rq;
-
-	argbuf = args;
-
-	if (copy_from_user(args, (void *)arg, 7))
-		return -EFAULT;
-
-	ide_init_drive_cmd(&rq);
-	rq.flags = REQ_DRIVE_TASK;
-	rq.buffer = argbuf;
-	err = ide_do_drive_cmd(drive, &rq, ide_wait);
-	if (copy_to_user((void *)arg, argbuf, argsize))
-		err = -EFAULT;
-	return err;
-}
-
 EXPORT_SYMBOL(drive_is_ready);
-
 EXPORT_SYMBOL(ata_read);
 EXPORT_SYMBOL(ata_write);
 EXPORT_SYMBOL(atapi_read);
 EXPORT_SYMBOL(atapi_write);
-
 EXPORT_SYMBOL(ata_taskfile);
 EXPORT_SYMBOL(recal_intr);
 EXPORT_SYMBOL(set_geometry_intr);
@@ -1023,6 +986,4 @@
 EXPORT_SYMBOL(task_no_data_intr);
 EXPORT_SYMBOL(ide_raw_taskfile);
 EXPORT_SYMBOL(ide_cmd_type_parser);
-
 EXPORT_SYMBOL(ide_cmd_ioctl);
-EXPORT_SYMBOL(ide_task_ioctl);
diff -urN linux-2.5.10/drivers/scsi/ide-scsi.c linux/drivers/scsi/ide-scsi.c
--- linux-2.5.10/drivers/scsi/ide-scsi.c	2002-04-23 00:27:48.000000000 +0200
+++ linux/drivers/scsi/ide-scsi.c	2002-04-26 00:32:14.000000000 +0200
@@ -458,9 +458,9 @@
 }
 
 /*
- *	idescsi_do_request is our request handling function.
+ * This is our request handling function.
  */
-static ide_startstop_t idescsi_do_request (ide_drive_t *drive, struct request *rq, unsigned long block)
+static ide_startstop_t idescsi_do_request(struct ata_device *drive, struct request *rq, sector_t block)
 {
 #if IDESCSI_DEBUG_LOG
 	printk (KERN_INFO "rq_status: %d, rq_dev: %u, cmd: %d, errors: %d\n",rq->rq_status,(unsigned int) rq->rq_dev,rq->cmd,rq->errors);
@@ -468,20 +468,20 @@
 #endif /* IDESCSI_DEBUG_LOG */
 
 	if (rq->flags & REQ_SPECIAL) {
-		return idescsi_issue_pc (drive, (idescsi_pc_t *) rq->special);
+		return idescsi_issue_pc(drive, (idescsi_pc_t *) rq->special);
 	}
 	blk_dump_rq_flags(rq, "ide-scsi: unsup command");
 	idescsi_end_request(drive, 0);
 	return ide_stopped;
 }
 
-static int idescsi_open (struct inode *inode, struct file *filp, ide_drive_t *drive)
+static int idescsi_open(struct inode *inode, struct file *filp, struct ata_device *drive)
 {
 	MOD_INC_USE_COUNT;
 	return 0;
 }
 
-static void idescsi_ide_release (struct inode *inode, struct file *filp, ide_drive_t *drive)
+static void idescsi_ide_release(struct inode *inode, struct file *filp, struct ata_device *drive)
 {
 	MOD_DEC_USE_COUNT;
 }
@@ -556,9 +556,7 @@
 	release:		idescsi_ide_release,
 	check_media_change:	NULL,
 	revalidate:		idescsi_revalidate,
-	pre_reset:		NULL,
 	capacity:		NULL,
-	special:		NULL,
 	proc:			NULL
 };
 
diff -urN linux-2.5.10/include/linux/blkdev.h linux/include/linux/blkdev.h
--- linux-2.5.10/include/linux/blkdev.h	2002-04-23 00:28:15.000000000 +0200
+++ linux/include/linux/blkdev.h	2002-04-25 23:28:54.000000000 +0200
@@ -76,17 +76,16 @@
 	__REQ_STARTED,	/* drive already may have started this one */
 	__REQ_DONTPREP,	/* don't call prep for this one */
 	/*
-	 * for IDE
- 	*/
+	 * for ATA/ATAPI devices
+	 */
 	__REQ_DRIVE_CMD,
-	__REQ_DRIVE_TASK,
 	__REQ_DRIVE_ACB,
 
 	__REQ_PC,	/* packet command (special) */
 	__REQ_BLOCK_PC,	/* queued down pc from block layer */
 	__REQ_SENSE,	/* sense retrival */
 
-	__REQ_SPECIAL,	/* driver special command */
+	__REQ_SPECIAL,	/* driver special command (currently reset) */
 
 	__REQ_NR_BITS,	/* stops here */
 };
@@ -99,15 +98,12 @@
 #define REQ_STARTED	(1 << __REQ_STARTED)
 #define REQ_DONTPREP	(1 << __REQ_DONTPREP)
 #define REQ_DRIVE_CMD	(1 << __REQ_DRIVE_CMD)
-#define REQ_DRIVE_TASK	(1 << __REQ_DRIVE_TASK)
 #define REQ_DRIVE_ACB	(1 << __REQ_DRIVE_ACB)
 #define REQ_PC		(1 << __REQ_PC)
-#define REQ_SENSE	(1 << __REQ_SENSE)
 #define REQ_BLOCK_PC	(1 << __REQ_BLOCK_PC)
+#define REQ_SENSE	(1 << __REQ_SENSE)
 #define REQ_SPECIAL	(1 << __REQ_SPECIAL)
 
-#define REQ_DRIVE_TASKFILE	REQ_DRIVE_ACB
-
 #include <linux/elevator.h>
 
 typedef int (merge_request_fn) (request_queue_t *, struct request *,
diff -urN linux-2.5.10/include/linux/hdreg.h linux/include/linux/hdreg.h
--- linux-2.5.10/include/linux/hdreg.h	2002-04-26 03:38:13.000000000 +0200
+++ linux/include/linux/hdreg.h	2002-04-25 23:05:19.000000000 +0200
@@ -3,7 +3,7 @@
 
 /*
  * This file contains some defines for the AT-hd-controller.
- * Various sources.  
+ * Various sources.
  */
 
 #define HD_IRQ 14			/* the standard disk interrupt */
@@ -51,11 +51,9 @@
 
 /*
  * Command Header sizes for IOCTL commands
- *	HDIO_DRIVE_CMD and HDIO_DRIVE_TASK
  */
 
 #define HDIO_DRIVE_CMD_HDR_SIZE		(4 * sizeof(u8))
-#define HDIO_DRIVE_TASK_HDR_SIZE	(8 * sizeof(u8))
 #define HDIO_DRIVE_HOB_HDR_SIZE		(8 * sizeof(u8))
 
 #define IDE_DRIVE_TASK_INVALID		-1
@@ -287,7 +285,6 @@
 #define HDIO_GET_UNMASKINTR	0x0302	/* get current unmask setting */
 #define HDIO_GET_MULTCOUNT	0x0304	/* get current IDE blockmode setting */
 #define HDIO_GET_QDMA		0x0305	/* get use-qdma flag */
-#define HDIO_OBSOLETE_IDENTITY	0x0307	/* OBSOLETE, DO NOT USE: returns 142 bytes */
 #define HDIO_GET_32BIT		0x0309	/* get current io_32bit setting */
 #define HDIO_GET_NOWERR		0x030a	/* get ignore-write-error flag */
 #define HDIO_GET_DMA		0x030b	/* get use-dma flag */
@@ -298,12 +295,8 @@
 #define	HDIO_GET_ADDRESS	0x0310	/* */
 
 #define HDIO_GET_BUSSTATE	0x031a	/* get the bus state of the hwif */
-#define HDIO_TRISTATE_HWIF	0x031b	/* execute a channel tristate */
-#define HDIO_DRIVE_TASK		0x031e	/* execute task and special drive command */
 #define HDIO_DRIVE_CMD		0x031f	/* execute a special drive command */
 
-#define HDIO_DRIVE_CMD_AEB	HDIO_DRIVE_TASK
-
 /* hd/ide ctl's that pass (arg) non-ptr values are numbered 0x032n/0x033n */
 #define HDIO_SET_MULTCOUNT	0x0321	/* change IDE blockmode */
 #define HDIO_SET_UNMASKINTR	0x0322	/* permit other irqs during I/O */
@@ -521,11 +514,7 @@
 					 *  7:0	current value
 					 */
 	unsigned short	words95_99[5];	/* reserved words 95-99 */
-#if 0
-	unsigned short	words100_103[4]	;/* reserved words 100-103 */
-#else
 	unsigned long long lba_capacity_2;/* 48-bit total number of sectors */
-#endif
 	unsigned short	words104_125[22];/* reserved words 104-125 */
 	unsigned short	last_lun;	/* (word 126) */
 	unsigned short	word127;	/* (word 127) Feature Set
@@ -573,7 +562,7 @@
 					 * 15:8 Checksum
 					 *  7:0 Signature
 					 */
-};
+} __attribute__((packed));
 
 /*
  * IDE "nice" flags. These are used on a per drive basis to determine
diff -urN linux-2.5.10/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.10/include/linux/ide.h	2002-04-26 03:38:13.000000000 +0200
+++ linux/include/linux/ide.h	2002-04-26 03:30:50.000000000 +0200
@@ -33,23 +33,26 @@
  */
 #define INITIAL_MULT_COUNT	0	/* off=0; on=2,4,8,16,32, etc.. */
 
-#ifndef SUPPORT_SLOW_DATA_PORTS		/* 1 to support slow data ports */
-#define SUPPORT_SLOW_DATA_PORTS	1	/* 0 to reduce kernel size */
+#ifndef SUPPORT_SLOW_DATA_PORTS			/* 1 to support slow data ports */
+# define SUPPORT_SLOW_DATA_PORTS	1	/* 0 to reduce kernel size */
 #endif
+
+/* Right now this is only needed by a promise controlled.
+ */
 #ifndef SUPPORT_VLB_SYNC		/* 1 to support weird 32-bit chips */
-#define SUPPORT_VLB_SYNC	1	/* 0 to reduce kernel size */
+# define SUPPORT_VLB_SYNC	1	/* 0 to reduce kernel size */
 #endif
 #ifndef DISK_RECOVERY_TIME		/* off=0; on=access_delay_time */
-#define DISK_RECOVERY_TIME	0	/*  for hardware that needs it */
+# define DISK_RECOVERY_TIME	0	/*  for hardware that needs it */
 #endif
 #ifndef OK_TO_RESET_CONTROLLER		/* 1 needed for good error recovery */
-#define OK_TO_RESET_CONTROLLER	1	/* 0 for use with AH2372A/B interface */
+# define OK_TO_RESET_CONTROLLER	1	/* 0 for use with AH2372A/B interface */
 #endif
 #ifndef FANCY_STATUS_DUMPS		/* 1 for human-readable drive errors */
-#define FANCY_STATUS_DUMPS	1	/* 0 to reduce kernel size */
+# define FANCY_STATUS_DUMPS	1	/* 0 to reduce kernel size */
 #endif
 #ifndef DISABLE_IRQ_NOSYNC
-#define DISABLE_IRQ_NOSYNC	0
+# define DISABLE_IRQ_NOSYNC	0
 #endif
 
 /*
@@ -262,17 +265,6 @@
 #define ATA_SCSI	0x21
 #define ATA_NO_LUN      0x7f
 
-typedef union {
-	unsigned all			: 8;	/* all of the bits together */
-	struct {
-		unsigned set_geometry	: 1;	/* respecify drive geometry */
-		unsigned recalibrate	: 1;	/* seek to cyl 0      */
-		unsigned set_multmode	: 1;	/* set multmode count */
-		unsigned set_tune	: 1;	/* tune interface for drive */
-		unsigned reserved	: 4;	/* unused */
-	} b;
-} special_t;
-
 struct ide_settings_s;
 /* structure describing an ATA/ATAPI device */
 typedef
@@ -300,7 +292,17 @@
 	unsigned long PADAM_service_time;	/* service time of last request */
 	unsigned long PADAM_timeout;		/* max time to wait for irq */
 
-	special_t	special;	/* special action flags */
+	/* Flags requesting/indicating one of the following special commands
+	 * executed on the request queue.
+	 */
+#define ATA_SPECIAL_GEOMETRY		0x01
+#define ATA_SPECIAL_RECALIBRATE		0x02
+#define ATA_SPECIAL_MMODE		0x04
+#define ATA_SPECIAL_TUNE		0x08
+	unsigned char special_cmd;
+	u8 mult_req;			/* requested multiple sector setting */
+	u8 tune_req;			/* requested drive tuning setting */
+
 	byte     using_dma;		/* disk is using dma for read/write */
 	byte	 retry_pio;		/* retrying dma capable host in pio */
 	byte	 state;			/* retry state */
@@ -327,8 +329,6 @@
 	byte		ctl;		/* "normal" value for IDE_CONTROL_REG */
 	byte		ready_stat;	/* min status value for drive ready */
 	byte		mult_count;	/* current multiple sector setting */
-	byte		mult_req;	/* requested multiple sector setting */
-	byte		tune_req;	/* requested drive tuning setting */
 	byte		bad_wstat;	/* used for ignoring WRERR_STAT */
 	byte		nowerr;		/* used for ignoring WRERR_STAT */
 	byte		sect0;		/* offset of first sector for DM6:DDO */
@@ -338,8 +338,7 @@
 	byte		bios_sect;	/* BIOS/fdisk/LILO sectors per track */
 	unsigned int	bios_cyl;	/* BIOS/fdisk/LILO number of cyls */
 	unsigned int	cyl;		/* "real" number of cyls */
-	unsigned long	capacity;	/* total number of sectors */
-	unsigned long long capacity48;	/* total number of sectors */
+	u64		capacity;	/* total number of sectors */
 	unsigned int	drive_data;	/* for use by tuneproc/selectproc as needed */
 
 	wait_queue_head_t wqueue;	/* used to wait for drive in open() */
@@ -462,19 +461,19 @@
 	char		name[8];	/* name of interface */
 	int		index;		/* 0 for ide0; 1 for ide1; ... */
 	hwif_chipset_t	chipset;	/* sub-module for tuning.. */
-	unsigned	noprobe    : 1;	/* don't probe for this interface */
-	unsigned	present    : 1;	/* there is a device on this interface */
-	unsigned	serialized : 1;	/* serialized operation between channels */
-	unsigned	sharing_irq: 1;	/* 1 = sharing irq with another hwif */
-	unsigned	reset      : 1;	/* reset after probe */
-	unsigned	autodma    : 1;	/* automatically try to enable DMA at boot */
-	unsigned	udma_four  : 1;	/* 1=ATA-66 capable, 0=default */
-	unsigned	highmem	   : 1; /* can do full 32-bit dma */
-	byte		slow;		/* flag: slow data port */
-	unsigned no_io_32bit	   : 1;	/* disallow enabling 32bit I/O */
+	unsigned noprobe	: 1;	/* don't probe for this interface */
+	unsigned present	: 1;	/* there is a device on this interface */
+	unsigned serialized	: 1;	/* serialized operation between channels */
+	unsigned sharing_irq	: 1;	/* 1 = sharing irq with another hwif */
+	unsigned reset		: 1;	/* reset after probe */
+	unsigned autodma	: 1;	/* automatically try to enable DMA at boot */
+	unsigned udma_four	: 1;	/* 1=ATA-66 capable, 0=default */
+	unsigned highmem	: 1;	/* can do full 32-bit dma */
+	unsigned no_io_32bit	: 1;	/* disallow enabling 32bit I/O */
+	unsigned no_unmask	: 1;	/* disallow setting unmask bit */
 	byte		io_32bit;	/* 0=16-bit, 1=32-bit, 2/3=32bit+sync */
-	unsigned no_unmask	   : 1;	/* disallow setting unmask bit */
 	byte		unmask;		/* flag: okay to unmask other irqs */
+	byte		slow;		/* flag: slow data port */
 
 #if (DISK_RECOVERY_TIME > 0)
 	unsigned long	last_time;	/* time when previous rq was done */
@@ -616,20 +615,20 @@
 
 struct ata_operations {
 	struct module *owner;
-	int (*cleanup)(ide_drive_t *);
-	int (*standby)(ide_drive_t *);
-	ide_startstop_t	(*do_request)(ide_drive_t *, struct request *, unsigned long);
-	int (*end_request)(ide_drive_t *drive, int uptodate);
-
-	int (*ioctl)(ide_drive_t *, struct inode *, struct file *, unsigned int, unsigned long);
-	int (*open)(struct inode *, struct file *, ide_drive_t *);
-	void (*release)(struct inode *, struct file *, ide_drive_t *);
-	int (*check_media_change)(ide_drive_t *);
-	void (*revalidate)(ide_drive_t *);
-
-	void (*pre_reset)(ide_drive_t *);
-	unsigned long (*capacity)(ide_drive_t *);
-	ide_startstop_t	(*special)(ide_drive_t *);
+	int (*cleanup)(struct ata_device *);
+	int (*standby)(struct ata_device *);
+	ide_startstop_t	(*do_request)(struct ata_device *, struct request *, sector_t);
+	int (*end_request)(struct ata_device *, int);
+
+	int (*ioctl)(struct ata_device *, struct inode *, struct file *, unsigned int, unsigned long);
+	int (*open)(struct inode *, struct file *, struct ata_device *);
+	void (*release)(struct inode *, struct file *, struct ata_device *);
+	int (*check_media_change)(struct ata_device *);
+	void (*revalidate)(struct ata_device *);
+
+	void (*pre_reset)(struct ata_device *);
+	sector_t (*capacity)(struct ata_device *);
+	ide_startstop_t	(*special)(struct ata_device *);
 
 	ide_proc_entry_t *proc;
 };
@@ -646,7 +645,7 @@
 		__MOD_DEC_USE_COUNT((ata)->owner);	\
 } while(0)
 
-extern unsigned long ata_capacity(ide_drive_t *drive);
+extern sector_t ata_capacity(struct ata_device *drive);
 
 /* FIXME: Actually implement and use them as soon as possible!  to make the
  * ide_scan_devices() go away! */
@@ -733,7 +732,6 @@
  * This function is intended to be used prior to invoking ide_do_drive_cmd().
  */
 extern void ide_init_drive_cmd(struct request *rq);
-extern void init_taskfile_request(struct request *rq);
 
 /*
  * "action" parameter type for ide_do_drive_cmd() below.
@@ -787,10 +785,8 @@
 /* This is setting up all fields in args, which depend upon the command type.
  */
 extern void ide_cmd_type_parser(struct ata_taskfile *args);
-extern int ide_raw_taskfile(ide_drive_t *drive, struct ata_taskfile *cmd, byte *buf);
-
-extern int ide_cmd_ioctl(ide_drive_t *drive, unsigned long arg);
-extern int ide_task_ioctl(ide_drive_t *drive, unsigned long arg);
+extern int ide_raw_taskfile(struct ata_device *drive, struct ata_taskfile *cmd, byte *buf);
+extern int ide_cmd_ioctl(struct ata_device *drive, unsigned long arg);
 
 void ide_delay_50ms(void);
 
@@ -864,13 +860,13 @@
 extern int ide_unregister_subdriver(ide_drive_t *drive);
 
 #ifdef CONFIG_BLK_DEV_IDEPCI
-#define ON_BOARD		1
-#define NEVER_BOARD		0
-#ifdef CONFIG_BLK_DEV_OFFBOARD
-# define OFF_BOARD		ON_BOARD
-#else
-# define OFF_BOARD		NEVER_BOARD
-#endif
+# define ON_BOARD		1
+# define NEVER_BOARD		0
+# ifdef CONFIG_BLK_DEV_OFFBOARD
+#  define OFF_BOARD		ON_BOARD
+# else
+#  define OFF_BOARD		NEVER_BOARD
+# endif
 
 void __init ide_scan_pcibus(int scan_direction);
 #endif
@@ -892,4 +888,4 @@
 extern int drive_is_ready(ide_drive_t *drive);
 extern void revalidate_drives(void);
 
-#endif /* _IDE_H */
+#endif

--------------080503090107030001080705--

