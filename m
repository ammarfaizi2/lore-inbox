Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315425AbSEGMZl>; Tue, 7 May 2002 08:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315426AbSEGMZk>; Tue, 7 May 2002 08:25:40 -0400
Received: from [195.63.194.11] ([195.63.194.11]:43785 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315425AbSEGMZb>; Tue, 7 May 2002 08:25:31 -0400
Message-ID: <3CD7B8FE.1020505@evision-ventures.com>
Date: Tue, 07 May 2002 13:22:38 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.14 IDE 56
In-Reply-To: <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------030700000108070801080706"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030700000108070801080706
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Mon May  6 13:29:44 CEST 2002 ide-clean-56

- Push poll_timeout down from the hwgroup to the channel. We are resetting the
   channel and not a whole hwgroup. This way using multiple pdc202xxx cards
   should magically start to work with multiple performance and resets will no
   longer lock the system.

- Updates for PDC4030 by Peter Denison <peterd@marshadder.uklinux.net>.

- Make ide_raw_taskfile don't care about request buffers. They where always
   NULL.

- Port set multi mode count over from the special setting interface to
   ide_raw_taskfile. Fix errors in the corresponding interrupt handler in one go
   as well. It turned out that this is precisely the same code as in
   task_no_data_intr, so we can nuke it altogether. And finally we have found
   some problems with the set_pio_mode() command which can fail with -EBUSY -
   this is in esp. probably *very* common during boot hdparm usage those days!
   (OK it was masked by reportig too early that it finished...  Crap Crap utter
   crap it was!!!) Right now hdparm should just be extendid to properly
   sync and retry on   -EBUSY and everything should be fine.

   And now the 1 Milion EUR question for everybody who loves to put driver
   settings in to /proc:

   How the hell could echo > /proc/ide/ide0/settings blah blah blah blah handle
   properly cases like -EIO, -EBUSY and so on??? Having the possibility o do it
   does not mean that it is a good idea to use it.

   OK. After realizing the simple fact that quite a lot of low level hardware
   manipulating ioctls may require assistance in usage from proper logic which is
   *very* unlikely to be implemented in a bash (for me preferable still ksh) I
   have made my mind up.

	/proc/ide will be nuked.

- Execute the recalibration for error recovery on precisely the same request as
   the one which failed.

- Remove set geometry.  It's crap by means of standard specification. Because:

   1. We relay on the existence of the identify command anyway.

   2. This command was obsoleted *before* the identify command existed as far
   as I can see.

   2. I'm able to have a look at what other ATA/ATAPI drivers in the wild do:
   They don't do it.

- Just call tuneproc in set_pio_mode() directly - we are already behind the rq
   queue there.

- After we have uncovered the broken logics behind the whole ioctl handling we
   now just have made ide_spin_wait_hwgroup() waiting for a proper somehow
   longer timeout before giving up. This was previously just hiding the broken
   concept of setting ioctl values through /proc/ide/ideX/settings - now it just
   really helps hdparm to not to give up too early. (It shouldn't probably play
   wreck havock on the global driver spin lock as well. I will look in to this
   later.)

- Scrap the non necessary, to say the least, disabling of interrupts for 3,
   read it again please, 3 seconds, on the local CPU inside
   ide_spin_wait_hwgroup().  Spin lock handling needs checking there badly as I
   see now as well...

Hey apparently any "special" requests are gone. We now have only
to deal with REQ_DEVICE_ACB and REQ_DEVICE_CMD. One of them is still too
much and will be killed.


--------------030700000108070801080706
Content-Type: text/plain;
 name="ide-clean-56.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-56.diff"

diff -urN linux-2.5.14/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.14/drivers/ide/ide.c	2002-05-07 02:36:37.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-05-07 02:15:18.000000000 +0200
@@ -193,7 +193,7 @@
 #ifdef CONFIG_BLK_DEV_HD
 	if (ch->io_ports[IDE_DATA_OFFSET] == HD_DATA)
 		ch->noprobe = 1; /* may be overridden by ide_setup() */
-#endif /* CONFIG_BLK_DEV_HD */
+#endif
 	ch->major = ide_major[index];
 	sprintf(ch->name, "ide%d", index);
 	ch->bus_state = BUSSTATE_ON;
@@ -201,15 +201,14 @@
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		struct ata_device *drive = &ch->drives[unit];
 
-		drive->type			= ATA_DISK;
-		drive->select.all		= (unit<<4)|0xa0;
-		drive->channel			= ch;
-		drive->ctl			= 0x08;
-		drive->ready_stat		= READY_STAT;
-		drive->bad_wstat		= BAD_W_STAT;
-		drive->special_cmd = (ATA_SPECIAL_RECALIBRATE | ATA_SPECIAL_GEOMETRY);
+		drive->type		= ATA_DISK;
+		drive->select.all	= (unit<<4)|0xa0;
+		drive->channel		= ch;
+		drive->ctl		= 0x08;
+		drive->ready_stat	= READY_STAT;
+		drive->bad_wstat	= BAD_W_STAT;
 		sprintf(drive->name, "hd%c", 'a' + (index * MAX_DRIVES) + unit);
-		drive->max_failures		= IDE_DEFAULT_MAX_FAILURES;
+		drive->max_failures	= IDE_DEFAULT_MAX_FAILURES;
 
 		init_waitqueue_head(&drive->wqueue);
 	}
@@ -354,11 +353,8 @@
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
-static void ata_pre_reset(struct ata_device *drive)
+static void check_crc_errors(struct ata_device *drive)
 {
-	if (ata_ops(drive) && ata_ops(drive)->pre_reset)
-		ata_ops(drive)->pre_reset(drive);
-
 	if (!drive->using_dma)
 	    return;
 
@@ -392,38 +388,6 @@
 	return ~0UL;
 }
 
-/*
- * This is used to issue WIN_SPECIFY, WIN_RESTORE, and WIN_SETMULT commands to
- * a drive.
- */
-static ide_startstop_t ata_special(struct ata_device *drive)
-{
-	unsigned char special_cmd = drive->special_cmd;
-
-#ifdef DEBUG
-	printk("%s: ata_special: 0x%02x\n", drive->name, special_cmd);
-#endif
-	if (special_cmd & ATA_SPECIAL_TUNE) {
-		drive->special_cmd &= ~ATA_SPECIAL_TUNE;
-		if (drive->channel->tuneproc != NULL)
-			drive->channel->tuneproc(drive, drive->tune_req);
-	} else if (drive->driver != NULL) {
-		if (ata_ops(drive)->special)
-			return ata_ops(drive)->special(drive);
-		else {
-			drive->special_cmd = 0;
-			drive->mult_req = 0;
-
-			return ide_stopped;
-		}
-	} else if (special_cmd) {
-		printk("%s: bad special flag: 0x%02x\n", drive->name, special_cmd);
-		drive->special_cmd = 0;
-	}
-
-	return ide_stopped;
-}
-
 extern struct block_device_operations ide_fops[];
 
 /*
@@ -460,24 +424,24 @@
  */
 static ide_startstop_t atapi_reset_pollfunc(struct ata_device *drive, struct request *__rq)
 {
-	ide_hwgroup_t *hwgroup = HWGROUP(drive);
-	byte stat;
+	struct ata_channel *ch = drive->channel;
+	u8 stat;
 
-	SELECT_DRIVE(drive->channel,drive);
+	SELECT_DRIVE(ch,drive);
 	udelay (10);
 
 	if (OK_STAT(stat=GET_STAT(), 0, BUSY_STAT)) {
 		printk("%s: ATAPI reset complete\n", drive->name);
 	} else {
-		if (time_before(jiffies, hwgroup->poll_timeout)) {
+		if (time_before(jiffies, ch->poll_timeout)) {
 			ide_set_handler (drive, atapi_reset_pollfunc, HZ/20, NULL);
 			return ide_started;	/* continue polling */
 		}
-		hwgroup->poll_timeout = 0;	/* end of polling */
+		ch->poll_timeout = 0;	/* end of polling */
 		printk("%s: ATAPI reset timed-out, status=0x%02x\n", drive->name, stat);
 		return do_reset1 (drive, 1);	/* do it the old fashioned way */
 	}
-	hwgroup->poll_timeout = 0;	/* done polling */
+	ch->poll_timeout = 0;	/* done polling */
 
 	return ide_stopped;
 }
@@ -489,19 +453,18 @@
  */
 static ide_startstop_t reset_pollfunc(struct ata_device *drive, struct request *__rq)
 {
-	ide_hwgroup_t *hwgroup = HWGROUP(drive);
-	struct ata_channel *hwif = drive->channel;
+	struct ata_channel *ch = drive->channel;
 	u8 stat;
 
 	if (!OK_STAT(stat=GET_STAT(), 0, BUSY_STAT)) {
-		if (time_before(jiffies, hwgroup->poll_timeout)) {
+		if (time_before(jiffies, ch->poll_timeout)) {
 			ide_set_handler(drive, reset_pollfunc, HZ/20, NULL);
 			return ide_started;	/* continue polling */
 		}
-		printk("%s: reset timed-out, status=0x%02x\n", hwif->name, stat);
+		printk("%s: reset timed-out, status=0x%02x\n", ch->name, stat);
 		drive->failures++;
 	} else  {
-		printk("%s: reset: ", hwif->name);
+		printk("%s: reset: ", ch->name);
 		if ((stat = GET_ERR()) == 1) {
 			printk("success\n");
 			drive->failures = 0;
@@ -531,7 +494,8 @@
 			drive->failures++;
 		}
 	}
-	hwgroup->poll_timeout = 0;	/* done polling */
+	ch->poll_timeout = 0;	/* done polling */
+
 	return ide_stopped;
 }
 
@@ -555,21 +519,21 @@
 {
 	unsigned int unit;
 	unsigned long flags;
-	struct ata_channel *hwif = drive->channel;
-	ide_hwgroup_t *hwgroup = HWGROUP(drive);
+	struct ata_channel *ch = drive->channel;
 
 	__save_flags(flags);	/* local CPU only */
 	__cli();		/* local CPU only */
 
 	/* For an ATAPI device, first try an ATAPI SRST. */
 	if (drive->type != ATA_DISK && !do_not_try_atapi) {
-		ata_pre_reset(drive);
-		SELECT_DRIVE(hwif,drive);
+		check_crc_errors(drive);
+		SELECT_DRIVE(ch, drive);
 		udelay (20);
 		OUT_BYTE(WIN_SRST, IDE_COMMAND_REG);
-		hwgroup->poll_timeout = jiffies + WAIT_WORSTCASE;
+		ch->poll_timeout = jiffies + WAIT_WORSTCASE;
 		ide_set_handler(drive, atapi_reset_pollfunc, HZ/20, NULL);
 		__restore_flags(flags);	/* local CPU only */
+
 		return ide_started;
 	}
 
@@ -578,11 +542,12 @@
 	 * for any of the drives on this interface.
 	 */
 	for (unit = 0; unit < MAX_DRIVES; ++unit)
-		ata_pre_reset(&hwif->drives[unit]);
+		check_crc_errors(&ch->drives[unit]);
 
 #if OK_TO_RESET_CONTROLLER
 	if (!IDE_CONTROL_REG) {
 		__restore_flags(flags);
+
 		return ide_stopped;
 	}
 	/*
@@ -601,7 +566,7 @@
 		OUT_BYTE(drive->ctl|2,IDE_CONTROL_REG);	/* clear SRST, leave nIEN */
 	}
 	udelay(10);			/* more than enough time */
-	hwgroup->poll_timeout = jiffies + WAIT_WORSTCASE;
+	ch->poll_timeout = jiffies + WAIT_WORSTCASE;
 	ide_set_handler(drive, reset_pollfunc, HZ/20, NULL);
 
 	/*
@@ -609,9 +574,10 @@
 	 * state when the disks are reset this way. At least, the Winbond
 	 * 553 documentation says that
 	 */
-	if (hwif->resetproc != NULL)
-		hwif->resetproc(drive);
+	if (ch->resetproc != NULL)
+		ch->resetproc(drive);
 
+	/* FIXME: we should handle mulit mode setting here as well ! */
 #endif
 
 	__restore_flags (flags);	/* local CPU only */
@@ -789,6 +755,36 @@
 	}
 }
 
+#ifdef CONFIG_BLK_DEV_PDC4030
+# define IS_PDC4030_DRIVE (drive->channel->chipset == ide_pdc4030)
+#else
+# define IS_PDC4030_DRIVE (0)	/* auto-NULLs out pdc4030 code */
+#endif
+
+/*
+ * We are still on the old request path here so issuing the recalibrate command
+ * directly should just work.
+ */
+static int do_recalibrate(struct ata_device *drive)
+{
+	printk(KERN_INFO "%s: recalibrating!\n", drive->name);
+
+	if (drive->type != ATA_DISK)
+		return ide_stopped;
+
+	if (!IS_PDC4030_DRIVE) {
+		struct ata_taskfile args;
+
+		memset(&args, 0, sizeof(args));
+		args.taskfile.sector_count = drive->sect;
+		args.taskfile.command = WIN_RESTORE;
+		args.handler = recal_intr;
+		ata_taskfile(drive, &args, NULL);
+	}
+
+	return IS_PDC4030_DRIVE ? ide_stopped : ide_started;
+}
+
 /*
  * Take action based on the error returned by the drive.
  */
@@ -835,13 +831,11 @@
 		else
 			ide_end_request(drive, rq, 0);
 	} else {
-		if ((rq->errors & ERROR_RESET) == ERROR_RESET) {
-			++rq->errors;
+		++rq->errors;
+		if ((rq->errors & ERROR_RESET) == ERROR_RESET)
 			return do_reset1(drive, 0);
-		}
 		if ((rq->errors & ERROR_RECAL) == ERROR_RECAL)
-			drive->special_cmd |= ATA_SPECIAL_RECALIBRATE;
-		++rq->errors;
+			return do_recalibrate(drive);
 	}
 	return ide_stopped;
 }
@@ -960,7 +954,7 @@
 		goto kill_rq;
 	}
 
-	block    = rq->sector;
+	block = rq->sector;
 
 	/* Strange disk manager remap.
 	 */
@@ -991,14 +985,6 @@
 		}
 	}
 
-	/* FIXME: We can see nicely here that all commands should be submitted
-	 * through the request queue and that the special field in drive should
-	 * go as soon as possible!
-	 */
-
-	if (drive->special_cmd)
-		return ata_special(drive);
-
 	/* This issues a special drive command, usually initiated by ioctl()
 	 * from the external hdparm program.
 	 */
@@ -1011,7 +997,7 @@
 		ata_taskfile(drive, args, NULL);
 
 		if (((args->command_type == IDE_DRIVE_TASK_RAW_WRITE) ||
-					(args->command_type == IDE_DRIVE_TASK_OUT)) &&
+		     (args->command_type == IDE_DRIVE_TASK_OUT)) &&
 				args->prehandler && args->handler)
 			return args->prehandler(drive, rq);
 
@@ -1053,6 +1039,7 @@
 			return ata_ops(drive)->do_request(drive, rq, block);
 		else {
 			ide_end_request(drive, rq, 0);
+
 			return ide_stopped;
 		}
 	}
@@ -1499,7 +1486,7 @@
 			disable_irq(ch->irq);	/* disable_irq_nosync ?? */
 #endif
 			__cli();	/* local CPU only, as if we were handling an interrupt */
-			if (hwgroup->poll_timeout != 0) {
+			if (ch->poll_timeout != 0) {
 				startstop = handler(drive, ch->hwgroup->rq);
 			} else if (drive_is_ready(drive)) {
 				if (drive->waiting_for_dma)
@@ -1598,7 +1585,7 @@
 	if (!ide_ack_intr(ch))
 		goto out_lock;
 
-	if (handler == NULL || hwgroup->poll_timeout != 0) {
+	if (handler == NULL || ch->poll_timeout != 0) {
 #if 0
 		printk(KERN_INFO "ide: unexpected interrupt %d %d\n", ch->unit, irq);
 #endif
@@ -2327,23 +2314,24 @@
 int ide_spin_wait_hwgroup(struct ata_device *drive)
 {
 	ide_hwgroup_t *hwgroup = HWGROUP(drive);
-	unsigned long timeout = jiffies + (3 * HZ);
+
+	/* FIXME: Wait on a proper timer. Instead of playing games on the
+	 * spin_lock().
+	 */
+
+	unsigned long timeout = jiffies + (10 * HZ);
 
 	spin_lock_irq(&ide_lock);
 
 	while (test_bit(IDE_BUSY, &hwgroup->flags)) {
-		unsigned long lflags;
 		spin_unlock_irq(&ide_lock);
-		__save_flags(lflags);	/* local CPU only */
-		__sti();		/* local CPU only; needed for jiffies */
-		if (0 < (signed long)(jiffies - timeout)) {
-			__restore_flags(lflags);	/* local CPU only */
+		if (time_after(jiffies, timeout)) {
 			printk("%s: channel busy\n", drive->name);
 			return -EBUSY;
 		}
-		__restore_flags(lflags);	/* local CPU only */
 		spin_lock_irq(&ide_lock);
 	}
+
 	return 0;
 }
 
@@ -2411,18 +2399,17 @@
 
 static int set_pio_mode(struct ata_device *drive, int arg)
 {
-	struct request rq;
-
 	if (!drive->channel->tuneproc)
 		return -ENOSYS;
 
-	if (drive->special_cmd & ATA_SPECIAL_TUNE)
+	/* FIXME: This is very much the same kind of problem as we have with
+	 * set_mutlmode() see for a edscription there.
+	 */
+	if (HWGROUP(drive)->handler)
 		return -EBUSY;
 
-	ide_init_drive_cmd(&rq);
-	drive->tune_req = (u8) arg;
-	drive->special_cmd |= ATA_SPECIAL_TUNE;
-	ide_do_drive_cmd(drive, &rq, ide_wait);
+	if (drive->channel->tuneproc != NULL)
+		drive->channel->tuneproc(drive, (u8) arg);
 
 	return 0;
 }
diff -urN linux-2.5.14/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.14/drivers/ide/ide-disk.c	2002-05-07 02:36:37.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2002-05-07 02:01:48.000000000 +0200
@@ -34,9 +34,9 @@
 #include <asm/io.h>
 
 #ifdef CONFIG_BLK_DEV_PDC4030
-#define IS_PDC4030_DRIVE (drive->channel->chipset == ide_pdc4030)
+# define IS_PDC4030_DRIVE (drive->channel->chipset == ide_pdc4030)
 #else
-#define IS_PDC4030_DRIVE (0)	/* auto-NULLs out pdc4030 code */
+# define IS_PDC4030_DRIVE (0)	/* auto-NULLs out pdc4030 code */
 #endif
 
 /*
@@ -304,9 +304,9 @@
 	}
 
 	if (IS_PDC4030_DRIVE) {
-		extern ide_startstop_t promise_rw_disk(struct ata_device *, struct request *, unsigned long);
+		extern ide_startstop_t promise_do_request(struct ata_device *, struct request *, sector_t);
 
-		return promise_rw_disk(drive, rq, block);
+		return promise_do_request(drive, rq, block);
 	}
 
 	/*
@@ -364,7 +364,7 @@
 		 * point.
 		 */
 
-		if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
+		if (drive->doorlocking && ide_raw_taskfile(drive, &args))
 			drive->doorlocking = 0;
 	}
 	return 0;
@@ -383,10 +383,10 @@
 
 	ide_cmd_type_parser(&args);
 
-	return ide_raw_taskfile(drive, &args, NULL);
+	return ide_raw_taskfile(drive, &args);
 }
 
-static void idedisk_release (struct inode *inode, struct file *filp, struct ata_device *drive)
+static void idedisk_release(struct inode *inode, struct file *filp, struct ata_device *drive)
 {
 	if (drive->removable && !drive->usage) {
 		struct ata_taskfile args;
@@ -398,7 +398,7 @@
 		ide_cmd_type_parser(&args);
 
 		if (drive->doorlocking &&
-		    ide_raw_taskfile(drive, &args, NULL))
+		    ide_raw_taskfile(drive, &args))
 			drive->doorlocking = 0;
 	}
 	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
@@ -419,75 +419,6 @@
 	return drive->capacity - drive->sect0;
 }
 
-static ide_startstop_t idedisk_special(struct ata_device *drive)
-{
-	unsigned char special_cmd = drive->special_cmd;
-
-	if (special_cmd & ATA_SPECIAL_GEOMETRY) {
-		struct ata_taskfile args;
-
-		drive->special_cmd &= ~ATA_SPECIAL_GEOMETRY;
-
-		memset(&args, 0, sizeof(args));
-		args.taskfile.sector_number	= drive->sect;
-		args.taskfile.low_cylinder	= drive->cyl;
-		args.taskfile.high_cylinder	= drive->cyl>>8;
-		args.taskfile.device_head	= ((drive->head-1)|drive->select.all)&0xBF;
-		if (!IS_PDC4030_DRIVE) {
-			args.taskfile.sector_count = drive->sect;
-			args.taskfile.command = WIN_SPECIFY;
-			args.handler = set_geometry_intr;;
-		}
-		ata_taskfile(drive, &args, NULL);
-	} else if (special_cmd & ATA_SPECIAL_RECALIBRATE) {
-		drive->special_cmd &= ~ATA_SPECIAL_RECALIBRATE;
-
-		if (!IS_PDC4030_DRIVE) {
-			struct ata_taskfile args;
-
-			memset(&args, 0, sizeof(args));
-			args.taskfile.sector_count = drive->sect;
-			args.taskfile.command = WIN_RESTORE;
-			args.handler = recal_intr;
-			ata_taskfile(drive, &args, NULL);
-		}
-	} else if (special_cmd & ATA_SPECIAL_MMODE) {
-		drive->special_cmd &= ~ATA_SPECIAL_MMODE;
-		if (drive->id && drive->mult_req > drive->id->max_multsect)
-			drive->mult_req = drive->id->max_multsect;
-		if (!IS_PDC4030_DRIVE) {
-			struct ata_taskfile args;
-
-			memset(&args, 0, sizeof(args));
-			args.taskfile.sector_count = drive->mult_req;
-			args.taskfile.command = WIN_SETMULT;
-			args.handler = set_multmode_intr;
-
-			ata_taskfile(drive, &args, NULL);
-		}
-	} else if (special_cmd) {
-		drive->special_cmd = 0;
-
-		printk(KERN_ERR "%s: bad special flag: 0x%02x\n", drive->name, special_cmd);
-		return ide_stopped;
-	}
-	return IS_PDC4030_DRIVE ? ide_stopped : ide_started;
-}
-
-static void idedisk_pre_reset(struct ata_device *drive)
-{
-	int legacy = (drive->id->cfs_enable_2 & 0x0400) ? 0 : 1;
-
-	if (legacy)
-		drive->special_cmd = (ATA_SPECIAL_GEOMETRY | ATA_SPECIAL_RECALIBRATE);
-	else
-		drive->special_cmd = 0;
-	if (OK_TO_RESET_CONTROLLER)
-		drive->mult_count = 0;
-	if (drive->mult_req != drive->mult_count)
-		drive->special_cmd |= ATA_SPECIAL_MMODE;
-}
-
 #ifdef CONFIG_PROC_FS
 
 #ifdef CONFIG_BLK_DEV_IDE_TCQ
@@ -556,28 +487,58 @@
  */
 static int set_multcount(struct ata_device *drive, int arg)
 {
-	struct request rq;
+	struct ata_taskfile args;
+
+	/* Setting multi mode count on this channel type is not supported/not
+	 * handled.
+	 */
+	if (IS_PDC4030_DRIVE)
+		return -EIO;
+
+	/* Hugh, we still didn't detect the devices capabilities.
+	 */
+	if (!drive->id)
+		return -EIO;
 
-	if (drive->special_cmd & ATA_SPECIAL_MMODE)
+	/* FIXME: Hmm... just bailing out my be problematic, since there *is*
+	 * activity during boot. For now the same problem persists in
+	 * set_pio_mode() we will have to do something about it soon.
+	 */
+	if (HWGROUP(drive)->handler)
 		return -EBUSY;
 
-	ide_init_drive_cmd(&rq);
+	if (arg > drive->id->max_multsect)
+		arg = drive->id->max_multsect;
 
-	drive->mult_req = arg;
-	drive->special_cmd |= ATA_SPECIAL_MMODE;
+	memset(&args, 0, sizeof(args));
+	args.taskfile.sector_count = arg;
+	args.taskfile.command	= WIN_SETMULT;
+	ide_cmd_type_parser(&args);
 
-	ide_do_drive_cmd(drive, &rq, ide_wait);
+	if (!ide_raw_taskfile(drive, &args)) {
+		/* all went well track this setting as valid */
+		drive->mult_count = arg;
+
+		return 0;
+	} else
+		drive->mult_count = 0; /* reset */
 
-	return (drive->mult_count == arg) ? 0 : -EIO;
+	return -EIO;
 }
 
 static int set_nowerr(struct ata_device *drive, int arg)
 {
-	if (ide_spin_wait_hwgroup(drive))
+	if (HWGROUP(drive)->handler)
 		return -EBUSY;
+
 	drive->nowerr = arg;
 	drive->bad_wstat = arg ? BAD_R_STAT : BAD_W_STAT;
+
+	/* FIXME: I'm less then sure that we are under the global request lock here!
+	 */
+#if 0
 	spin_unlock_irq(&ide_lock);
+#endif
 
 	return 0;
 }
@@ -593,7 +554,7 @@
 	args.taskfile.feature	= (arg) ? SETFEATURES_EN_WCACHE : SETFEATURES_DIS_WCACHE;
 	args.taskfile.command	= WIN_SETFEATURES;
 	ide_cmd_type_parser(&args);
-	ide_raw_taskfile(drive, &args, NULL);
+	ide_raw_taskfile(drive, &args);
 
 	drive->wcache = arg;
 
@@ -608,7 +569,7 @@
 	args.taskfile.command = WIN_STANDBYNOW1;
 	ide_cmd_type_parser(&args);
 
-	return ide_raw_taskfile(drive, &args, NULL);
+	return ide_raw_taskfile(drive, &args);
 }
 
 static int set_acoustic(struct ata_device *drive, int arg)
@@ -620,7 +581,7 @@
 	args.taskfile.sector_count = arg;
 	args.taskfile.command = WIN_SETFEATURES;
 	ide_cmd_type_parser(&args);
-	ide_raw_taskfile(drive, &args, NULL);
+	ide_raw_taskfile(drive, &args);
 
 	drive->acoustic = arg;
 
@@ -673,17 +634,11 @@
 {
 	struct hd_driveid *id = drive->id;
 
-	ide_add_setting(drive,	"bios_cyl",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->bios_cyl,		NULL);
-	ide_add_setting(drive,	"bios_head",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	255,				1,	1,	&drive->bios_head,		NULL);
-	ide_add_setting(drive,	"bios_sect",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	63,				1,	1,	&drive->bios_sect,		NULL);
 	ide_add_setting(drive,	"address",		SETTING_RW,					HDIO_GET_ADDRESS,	HDIO_SET_ADDRESS,	TYPE_INTA,	0,	2,				1,	1,	&drive->addressing,	set_lba_addressing);
 	ide_add_setting(drive,	"multcount",		id ? SETTING_RW : SETTING_READ,			HDIO_GET_MULTCOUNT,	HDIO_SET_MULTCOUNT,	TYPE_BYTE,	0,	id ? id->max_multsect : 0,	1,	1,	&drive->mult_count,		set_multcount);
 	ide_add_setting(drive,	"nowerr",		SETTING_RW,					HDIO_GET_NOWERR,	HDIO_SET_NOWERR,	TYPE_BYTE,	0,	1,				1,	1,	&drive->nowerr,			set_nowerr);
-	ide_add_setting(drive,	"lun",			SETTING_RW,					-1,			-1,			TYPE_INT,	0,	7,				1,	1,	&drive->lun,			NULL);
 	ide_add_setting(drive,	"wcache",		SETTING_RW,					HDIO_GET_WCACHE,	HDIO_SET_WCACHE,	TYPE_BYTE,	0,	1,				1,	1,	&drive->wcache,			write_cache);
 	ide_add_setting(drive,	"acoustic",		SETTING_RW,					HDIO_GET_ACOUSTIC,	HDIO_SET_ACOUSTIC,	TYPE_BYTE,	0,	254,				1,	1,	&drive->acoustic,		set_acoustic);
-	ide_add_setting(drive,	"failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->failures,		NULL);
-	ide_add_setting(drive,	"max_failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->max_failures,		NULL);
 #ifdef CONFIG_BLK_DEV_IDE_TCQ
 	ide_add_setting(drive,	"using_tcq",		SETTING_RW,					HDIO_GET_QDMA,		HDIO_SET_QDMA,		TYPE_BYTE,	0,	IDE_MAX_TAG,			1,		1,		&drive->using_tcq,		set_using_tcq);
 #endif
@@ -761,7 +716,7 @@
 	args.handler = task_no_data_intr;
 
 	/* submit command request */
-	ide_raw_taskfile(drive, &args, NULL);
+	ide_raw_taskfile(drive, &args);
 
 	/* if OK, compute maximum address value */
 	if ((args.taskfile.command & 0x01) == 0) {
@@ -789,7 +744,7 @@
 	args.handler = task_no_data_intr;
 
         /* submit command request */
-        ide_raw_taskfile(drive, &args, NULL);
+        ide_raw_taskfile(drive, &args);
 
 	/* if OK, compute maximum address value */
 	if ((args.taskfile.command & 0x01) == 0) {
@@ -829,7 +784,7 @@
 	args.taskfile.command = WIN_SET_MAX;
 	args.handler = task_no_data_intr;
 	/* submit command request */
-	ide_raw_taskfile(drive, &args, NULL);
+	ide_raw_taskfile(drive, &args);
 	/* if OK, read new maximum address value */
 	if ((args.taskfile.command & 0x01) == 0) {
 		addr_set = ((args.taskfile.device_head & 0x0f) << 24)
@@ -865,7 +820,7 @@
 
         args.handler = task_no_data_intr;
 	/* submit command request */
-	ide_raw_taskfile(drive, &args, NULL);
+	ide_raw_taskfile(drive, &args);
 	/* if OK, compute maximum address value */
 	if ((args.taskfile.command & 0x01) == 0) {
 		u32 high = (args.hobfile.high_cylinder << 16) |
@@ -1078,7 +1033,13 @@
 	printk("\n");
 
 	drive->mult_count = 0;
+#if 0
 	if (id->max_multsect) {
+
+		/* FIXME: reenable this again after making it to use
+		 * the same code path as the ioctl stuff.
+		 */
+
 #ifdef CONFIG_IDEDISK_MULTI_MODE
 		id->multsect = ((id->max_multsect/2) > 1) ? id->max_multsect : 0;
 		id->multsect_valid = id->multsect ? 1 : 0;
@@ -1094,6 +1055,7 @@
 			drive->special_cmd |= ATA_SPECIAL_MMODE;
 #endif
 	}
+#endif
 
 	/* FIXME: Nowadays there are many chipsets out there which *require* 32
 	 * bit IO. Those will most propably not work properly with drives not
@@ -1136,9 +1098,7 @@
 	release:		idedisk_release,
 	check_media_change:	idedisk_check_media_change,
 	revalidate:		NULL, /* use default method */
-	pre_reset:		idedisk_pre_reset,
 	capacity:		idedisk_capacity,
-	special:		idedisk_special,
 	proc:			idedisk_proc
 };
 
diff -urN linux-2.5.14/drivers/ide/ide-tape.c linux/drivers/ide/ide-tape.c
--- linux-2.5.14/drivers/ide/ide-tape.c	2002-05-07 02:36:37.000000000 +0200
+++ linux/drivers/ide/ide-tape.c	2002-05-07 01:23:42.000000000 +0200
@@ -4273,16 +4273,6 @@
 }
 
 /*
- *	idetape_pre_reset is called before an ATAPI/ATA software reset.
- */
-static void idetape_pre_reset (ide_drive_t *drive)
-{
-	idetape_tape_t *tape = drive->driver_data;
-	if (tape != NULL)
-		set_bit (IDETAPE_IGNORE_DSC, &tape->flags);
-}
-
-/*
  *	Character device interface functions
  */
 static ide_drive_t *get_drive_ptr (kdev_t i_rdev)
@@ -6164,8 +6154,6 @@
 	release:		idetape_blkdev_release,
 	check_media_change:	NULL,
 	revalidate:		idetape_revalidate,
-	pre_reset:		idetape_pre_reset,
-	capacity:		NULL,
 	proc:			idetape_proc
 };
 
diff -urN linux-2.5.14/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.14/drivers/ide/ide-taskfile.c	2002-05-07 02:36:37.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-05-07 02:30:11.000000000 +0200
@@ -489,40 +489,6 @@
 }
 
 /*
- * This is invoked on completion of a WIN_SETMULT cmd.
- */
-ide_startstop_t set_multmode_intr(struct ata_device *drive, struct request *__rq)
-{
-	u8 stat;
-
-	if (OK_STAT(stat = GET_STAT(),READY_STAT,BAD_STAT)) {
-		drive->mult_count = drive->mult_req;
-	} else {
-		drive->mult_req = drive->mult_count = 0;
-		drive->special_cmd |= ATA_SPECIAL_RECALIBRATE;
-		ide_dump_status(drive, "set_multmode", stat);
-	}
-	return ide_stopped;
-}
-
-/*
- * This is invoked on completion of a WIN_SPECIFY cmd.
- */
-ide_startstop_t set_geometry_intr(struct ata_device *drive, struct request *__rq)
-{
-	u8 stat;
-
-	if (OK_STAT(stat=GET_STAT(),READY_STAT,BAD_STAT))
-		return ide_stopped;
-
-	if (stat & (ERR_STAT|DRQ_STAT))
-		return ide_error(drive, "set_geometry_intr", stat);
-
-	ide_set_handler(drive, set_geometry_intr, WAIT_CMD, NULL);
-	return ide_started;
-}
-
-/*
  * This is invoked on completion of a WIN_RESTORE (recalibrate) cmd.
  */
 ide_startstop_t recal_intr(struct ata_device *drive, struct request *__rq)
@@ -729,11 +695,11 @@
 			args->command_type = IDE_DRIVE_TASK_IN;
 			return;
 
+		case CFA_WRITE_SECT_WO_ERASE:
 		case WIN_WRITE:
 		case WIN_WRITE_EXT:
 		case WIN_WRITE_VERIFY:
 		case WIN_WRITE_BUFFER:
-		case CFA_WRITE_SECT_WO_ERASE:
 		case WIN_DOWNLOAD_MICROCODE:
 			args->prehandler = pre_task_out_intr;
 			args->handler = task_out_intr;
@@ -832,7 +798,7 @@
 			}
 
 		case WIN_SPECIFY:
-			args->handler = set_geometry_intr;
+			args->handler = task_no_data_intr;
 			args->command_type = IDE_DRIVE_TASK_NO_DATA;
 			return;
 
@@ -874,7 +840,7 @@
 			return;
 
 		case WIN_SETMULT:
-			args->handler = set_multmode_intr;
+			args->handler = task_no_data_intr;
 			args->command_type = IDE_DRIVE_TASK_NO_DATA;
 			return;
 
@@ -894,19 +860,19 @@
 	}
 }
 
-int ide_raw_taskfile(struct ata_device *drive, struct ata_taskfile *args, byte *buf)
+int ide_raw_taskfile(struct ata_device *drive, struct ata_taskfile *args)
 {
 	struct request rq;
 
 	memset(&rq, 0, sizeof(rq));
 	rq.flags = REQ_DRIVE_ACB;
-	rq.buffer = buf;
 
+#if 0
 	if (args->command_type != IDE_DRIVE_TASK_NO_DATA)
 		rq.current_nr_sectors = rq.nr_sectors
 			= (args->hobfile.sector_count << 8)
 			| args->taskfile.sector_count;
-
+#endif
 	rq.special = args;
 
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
@@ -996,8 +962,6 @@
 EXPORT_SYMBOL(atapi_write);
 EXPORT_SYMBOL(ata_taskfile);
 EXPORT_SYMBOL(recal_intr);
-EXPORT_SYMBOL(set_geometry_intr);
-EXPORT_SYMBOL(set_multmode_intr);
 EXPORT_SYMBOL(task_no_data_intr);
 EXPORT_SYMBOL(ide_raw_taskfile);
 EXPORT_SYMBOL(ide_cmd_type_parser);
diff -urN linux-2.5.14/drivers/ide/pdc4030.c linux/drivers/ide/pdc4030.c
--- linux-2.5.14/drivers/ide/pdc4030.c	2002-05-06 05:37:57.000000000 +0200
+++ linux/drivers/ide/pdc4030.c	2002-05-06 19:55:23.000000000 +0200
@@ -39,6 +39,7 @@
  *  Version 0.90	Transition to BETA code. No lost/unexpected interrupts
  *  Version 0.91	Bring in line with new bio code in 2.5.1
  *  Version 0.92	Update for IDE driver taskfile changes
+ *  Version 0.93	Sync with 2.5.10, minor taskfile changes
  */
 
 /*
@@ -380,6 +381,7 @@
 }
 
 /*
+ * promise_complete_pollfunc()
  * This is the polling function for waiting (nicely!) until drive stops
  * being busy. It is invoked at the end of a write, after the previous poll
  * has finished.
@@ -388,20 +390,20 @@
  */
 static ide_startstop_t promise_complete_pollfunc(struct ata_device *drive, struct request *rq)
 {
-	ide_hwgroup_t *hwgroup = HWGROUP(drive);
+	struct ata_channel *ch = drive->channel;
 
 	if (GET_STAT() & BUSY_STAT) {
-		if (time_before(jiffies, hwgroup->poll_timeout)) {
+		if (time_before(jiffies, ch->poll_timeout)) {
 			ide_set_handler(drive, promise_complete_pollfunc, HZ/100, NULL);
 			return ide_started; /* continue polling... */
 		}
-		hwgroup->poll_timeout = 0;
+		ch->poll_timeout = 0;
 		printk(KERN_ERR "%s: completion timeout - still busy!\n",
 		       drive->name);
 		return ide_error(drive, "busy timeout", GET_STAT());
 	}
 
-	hwgroup->poll_timeout = 0;
+	ch->poll_timeout = 0;
 #ifdef DEBUG_WRITE
 	printk(KERN_DEBUG "%s: Write complete - end_request\n", drive->name);
 #endif
@@ -432,7 +434,7 @@
 			nsect = mcount;
 		mcount -= nsect;
 
-		buffer = bio_kmap_irq(rq->bio, flags) + ide_rq_offset(rq);
+		buffer = bio_kmap_irq(rq->bio, &flags) + ide_rq_offset(rq);
 		rq->sector += nsect;
 		rq->nr_sectors -= nsect;
 		rq->current_nr_sectors -= nsect;
@@ -467,23 +469,23 @@
  */
 static ide_startstop_t promise_write_pollfunc(struct ata_device *drive, struct request *rq)
 {
-	ide_hwgroup_t *hwgroup = HWGROUP(drive);
+	struct ata_channel *ch = drive->channel;
 
 	if (IN_BYTE(IDE_NSECTOR_REG) != 0) {
-		if (time_before(jiffies, hwgroup->poll_timeout)) {
+		if (time_before(jiffies, ch->poll_timeout)) {
 			ide_set_handler(drive, promise_write_pollfunc, HZ/100, NULL);
 			return ide_started; /* continue polling... */
 		}
-		hwgroup->poll_timeout = 0;
+		ch->poll_timeout = 0;
 		printk(KERN_ERR "%s: write timed-out!\n",drive->name);
-		return ide_error (drive, "write timeout", GET_STAT());
+		return ide_error(drive, "write timeout", GET_STAT());
 	}
 
 	/*
 	 * Now write out last 4 sectors and poll for not BUSY
 	 */
 	promise_multwrite(drive, rq, 4);
-	hwgroup->poll_timeout = jiffies + WAIT_WORSTCASE;
+	ch->poll_timeout = jiffies + WAIT_WORSTCASE;
 	ide_set_handler(drive, promise_complete_pollfunc, HZ/100, NULL);
 #ifdef DEBUG_WRITE
 	printk(KERN_DEBUG "%s: Done last 4 sectors - status = %02x\n",
@@ -501,7 +503,7 @@
  */
 static ide_startstop_t promise_write(struct ata_device *drive, struct request *rq)
 {
-	ide_hwgroup_t *hwgroup = HWGROUP(drive);
+	struct ata_channel *ch = drive->channel;
 
 #ifdef DEBUG_WRITE
 	printk(KERN_DEBUG "%s: promise_write: sectors(%ld-%ld), "
@@ -516,7 +518,7 @@
 	if (rq->nr_sectors > 4) {
 		if (promise_multwrite(drive, rq, rq->nr_sectors - 4))
 			return ide_stopped;
-		hwgroup->poll_timeout = jiffies + WAIT_WORSTCASE;
+		ch->poll_timeout = jiffies + WAIT_WORSTCASE;
 		ide_set_handler(drive, promise_write_pollfunc, HZ/100, NULL);
 		return ide_started;
 	} else {
@@ -526,7 +528,7 @@
 	 */
 		if (promise_multwrite(drive, rq, rq->nr_sectors))
 			return ide_stopped;
-		hwgroup->poll_timeout = jiffies + WAIT_WORSTCASE;
+		ch->poll_timeout = jiffies + WAIT_WORSTCASE;
 		ide_set_handler(drive, promise_complete_pollfunc, HZ/100, NULL);
 #ifdef DEBUG_WRITE
 		printk(KERN_DEBUG "%s: promise_write: <= 4 sectors, "
@@ -537,13 +539,13 @@
 }
 
 /*
- * do_pdc4030_io() is called from do_rw_disk, having had the block number
- * already set up. It issues a READ or WRITE command to the Promise
+ * do_pdc4030_io() is called from promise_do_request, having had the block
+ * number already set up. It issues a READ or WRITE command to the Promise
  * controller, assuming LBA has been used to set up the block number.
  */
-ide_startstop_t do_pdc4030_io(struct ata_device *drive, struct ata_taskfile *task, struct request *rq)
+ide_startstop_t do_pdc4030_io(struct ata_device *drive, struct ata_taskfile *args, struct request *rq)
 {
-	struct hd_drive_task_hdr *taskfile = &task->taskfile;
+	struct hd_drive_task_hdr *taskfile = &(args->taskfile);
 	unsigned long timeout;
 	byte stat;
 
@@ -628,7 +630,7 @@
 	}
 }
 
-ide_startstop_t promise_rw_disk(struct ata_device *drive, struct request *rq, sector_t block)
+ide_startstop_t promise_do_request(struct ata_device *drive, struct request *rq, sector_t block)
 {
 	struct ata_taskfile args;
 
@@ -647,12 +649,12 @@
 	args.taskfile.device_head	= ((block>>8)&0x0f)|drive->select.all;
 	args.taskfile.command		= (rq_data_dir(rq)==READ)?PROMISE_READ:PROMISE_WRITE;
 
-	ide_cmd_type_parser(&args);
-	/* We don't use the generic inerrupt handlers here? */
-	args.prehandler		= NULL;
+	/* We can't call ide_cmd_type_parser here, since it won't understand
+	   our command, but that doesn't matter, since we don't use the
+	   generic interrupt handlers either. Setup the bits of args that we
+	   will need. */
 	args.handler		= NULL;
 	rq->special		= &args;
 
 	return do_pdc4030_io(drive, &args, rq);
 }
-
diff -urN linux-2.5.14/drivers/ide/tcq.c linux/drivers/ide/tcq.c
--- linux-2.5.14/drivers/ide/tcq.c	2002-05-06 05:38:05.000000000 +0200
+++ linux/drivers/ide/tcq.c	2002-05-06 20:11:27.000000000 +0200
@@ -418,7 +418,7 @@
 	 * pass NOP with sub-code 0x01 to device, so the command will not
 	 * fail there
 	 */
-	ide_raw_taskfile(drive, &args, NULL);
+	ide_raw_taskfile(drive, &args);
 	if (args.taskfile.feature & ABRT_ERR)
 		return 1;
 
@@ -448,7 +448,7 @@
 	args.taskfile.command = WIN_SETFEATURES;
 	ide_cmd_type_parser(&args);
 
-	if (ide_raw_taskfile(drive, &args, NULL)) {
+	if (ide_raw_taskfile(drive, &args)) {
 		printk("%s: failed to enable write cache\n", drive->name);
 		return 1;
 	}
@@ -462,7 +462,7 @@
 	args.taskfile.command = WIN_SETFEATURES;
 	ide_cmd_type_parser(&args);
 
-	if (ide_raw_taskfile(drive, &args, NULL)) {
+	if (ide_raw_taskfile(drive, &args)) {
 		printk("%s: disabling release interrupt fail\n", drive->name);
 		return 1;
 	}
@@ -476,7 +476,7 @@
 	args.taskfile.command = WIN_SETFEATURES;
 	ide_cmd_type_parser(&args);
 
-	if (ide_raw_taskfile(drive, &args, NULL)) {
+	if (ide_raw_taskfile(drive, &args)) {
 		printk("%s: enabling service interrupt fail\n", drive->name);
 		return 1;
 	}
diff -urN linux-2.5.14/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.14/include/linux/ide.h	2002-05-07 02:36:38.000000000 +0200
+++ linux/include/linux/ide.h	2002-05-07 02:30:15.000000000 +0200
@@ -47,7 +47,7 @@
 # define DISK_RECOVERY_TIME	0	/*  for hardware that needs it */
 #endif
 #ifndef OK_TO_RESET_CONTROLLER		/* 1 needed for good error recovery */
-# define OK_TO_RESET_CONTROLLER	1	/* 0 for use with AH2372A/B interface */
+# define OK_TO_RESET_CONTROLLER	0	/* 0 for use with AH2372A/B interface */
 #endif
 #ifndef FANCY_STATUS_DUMPS		/* 1 for human-readable drive errors */
 # define FANCY_STATUS_DUMPS	1	/* 0 to reduce kernel size */
@@ -327,19 +327,9 @@
 	 */
 	request_queue_t	queue;	/* per device request queue */
 
-
 	unsigned long sleep;	/* sleep until this time */
 
-	/* Flags requesting/indicating one of the following special commands
-	 * executed on the request queue.
-	 */
-#define ATA_SPECIAL_GEOMETRY		0x01
-#define ATA_SPECIAL_RECALIBRATE		0x02
-#define ATA_SPECIAL_MMODE		0x04
-#define ATA_SPECIAL_TUNE		0x08
-	unsigned char special_cmd;
-	u8 mult_req;			/* requested multiple sector setting */
-	u8 tune_req;			/* requested drive tuning setting */
+	u8 XXX_tune_req;			/* requested drive tuning setting */
 
 	byte     using_dma;		/* disk is using dma for read/write */
 	byte	 using_tcq;		/* disk is using queueing */
@@ -409,6 +399,7 @@
 	unsigned int	failures;	/* current failure count */
 	unsigned int	max_failures;	/* maximum allowed failure count */
 	struct device	device;		/* global device tree handle */
+
 	/*
 	 * tcq statistics
 	 */
@@ -517,6 +508,8 @@
 	/* driver soft-power interface */
 	int (*busproc)(struct ata_device *, int);
 	byte		bus_state;	/* power state of the IDE bus */
+
+	unsigned long poll_timeout; /* timeout value during polled operations */
 };
 
 /*
@@ -565,17 +558,19 @@
 	return 1;
 }
 #else
-#define ata_pending_commands(drive)	(0)
-#define ata_can_queue(drive)		(1)
+# define ata_pending_commands(drive)	(0)
+# define ata_can_queue(drive)		(1)
 #endif
 
 typedef struct hwgroup_s {
+	/* FIXME: We should look for busy request queues instead of looking at
+	 * the !NULL state of this field.
+	 */
 	ide_startstop_t (*handler)(struct ata_device *, struct request *);	/* irq handler, if active */
 	unsigned long flags;		/* BUSY, SLEEPING */
 	struct ata_device *XXX_drive;	/* current drive */
 	struct request *rq;		/* current request */
 	struct timer_list timer;	/* failsafe timer */
-	unsigned long poll_timeout;	/* timeout value during long polls */
 	int (*expiry)(struct ata_device *, struct request *);	/* irq handler, if active */
 } ide_hwgroup_t;
 
@@ -675,9 +670,7 @@
 	int (*check_media_change)(struct ata_device *);
 	void (*revalidate)(struct ata_device *);
 
-	void (*pre_reset)(struct ata_device *);
 	sector_t (*capacity)(struct ata_device *);
-	ide_startstop_t	(*special)(struct ata_device *);
 
 	ide_proc_entry_t *proc;
 };
@@ -827,15 +820,13 @@
  */
 
 extern ide_startstop_t recal_intr(struct ata_device *, struct request *);
-extern ide_startstop_t set_geometry_intr(struct ata_device *, struct request *);
-extern ide_startstop_t set_multmode_intr(struct ata_device *, struct request *);
 extern ide_startstop_t task_no_data_intr(struct ata_device *, struct request *);
 
 
 /* This is setting up all fields in args, which depend upon the command type.
  */
 extern void ide_cmd_type_parser(struct ata_taskfile *args);
-extern int ide_raw_taskfile(struct ata_device *drive, struct ata_taskfile *cmd, byte *buf);
+extern int ide_raw_taskfile(struct ata_device *, struct ata_taskfile *);
 extern int ide_cmd_ioctl(struct ata_device *drive, unsigned long arg);
 
 void ide_delay_50ms(void);

--------------030700000108070801080706--

