Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317429AbSFXHVX>; Mon, 24 Jun 2002 03:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317430AbSFXHVX>; Mon, 24 Jun 2002 03:21:23 -0400
Received: from [194.85.255.177] ([194.85.255.177]:20864 "HELO blacklake.uucp")
	by vger.kernel.org with SMTP id <S317429AbSFXHVV>;
	Mon, 24 Jun 2002 03:21:21 -0400
Date: Mon, 24 Jun 2002 10:22:49 +0300
From: Dzmitry Chekmarou <diavolo@mail.ru>
To: martin@dalecki.de
Cc: linux-kernel@vger.kernel.org
Subject: [2.5.24][patch] ide recalibrating bug
Message-ID: <20020624072249.GA1125@blacklake>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

previous message was with whitespaces(not tabs) in patch :(

the problem:
  kernel fails when ide recalibrating (dma should be turned on)
  when schedule called and in_interrupt() returns non-zero - BUG() executed
  do_recalibrate() is executed with in_interrupt() == 1

this happens after 2.5.20 to 2.5.21 patch

procedures call stack:
  drivers/ide/ide.c:
    do_recalibrate()
  drivers/ide/ide-taskfile.c:
    ide_raw_taskfile()
    ide_do_drive_cmd()
  kernel/sched.c:
    wait_for_completion()
    schedule()

solutions:
  do not use wait_for_completion when in_interrupt() non-zero (use old wait-scheme)
  return to old version

my hardware(this is not hw problem, i think):
  cpu: athlon 1000
  mb: sis735
  ram: 256ddr
  hdd: ibm

compiler(and not compiler problem):
  gcc 3.1

tested kernels:
  2.5.17-20(good)
  2.5.21-24(broken)

sorry for my bad english

wbr zmiter

===here is patch(applies to 2.5.24) to return old code for do_recalibrate (temporary fix)===
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	Sun Jun 23 17:08:19 2002
+++ b/drivers/ide/ide.c	Sun Jun 23 23:11:51 2002
@@ -550,6 +550,39 @@
  * We are still on the old request path here so issuing the recalibrate command
  * directly should just work.
  */
+
+/*
+ * Here is deleted ide_set_handler and recal_intr for do_recalibrate
+ */
+
+void ide_set_handler(struct ata_device *drive, ata_handler_t handler,
+		      unsigned long timeout, ata_expiry_t expiry)
+{
+	unsigned long flags;
+	struct ata_channel *ch = drive->channel;
+
+	spin_lock_irqsave(ch->lock, flags);
+
+	if (ch->handler != NULL) {
+		printk("%s: ide_set_handler: handler not null; old=%p, new=%p, from %p\n",
+			drive->name, ch->handler, handler, __builtin_return_address(0));
+	}
+	ch->handler = handler;
+	ch->expiry = expiry;
+	ch->timer.expires = jiffies + timeout;
+	add_timer(&ch->timer);
+
+	spin_unlock_irqrestore(ch->lock, flags);
+}
+
+ide_startstop_t recal_intr(struct ata_device *drive, struct request *rq)
+{
+	if (!ata_status(drive, READY_STAT, BAD_STAT))
+		return ata_error(drive, rq, __FUNCTION__);
+
+	return ide_stopped;
+}
+
 static int do_recalibrate(struct ata_device *drive)
 {
 
@@ -560,10 +593,28 @@
 		struct ata_taskfile args;
 
 		printk(KERN_INFO "%s: recalibrating...\n", drive->name);
+
 		memset(&args, 0, sizeof(args));
 		args.taskfile.sector_count = drive->sect;
 		args.cmd = WIN_RESTORE;
-		ide_raw_taskfile(drive, &args);
+		args.command_type = IDE_DRIVE_TASK_NO_DATA;
+
+		ata_irq_enable(drive, 1);
+		ata_mask(drive);
+
+		if ((drive->id->command_set_2 & 0x0400) && (drive->id->cfs_enable_2 & 0x0400) && (drive->addressing == 1))
+			ata_out_regfile(drive, &args.hobfile);
+
+		ata_out_regfile(drive, &args.taskfile);
+
+		{
+			u8 HIHI = (drive->addressing) ? 0xE0 : 0xEF;
+			OUT_BYTE((args.taskfile.device_head & HIHI) | drive->select.all, IDE_SELECT_REG);
+		}
+
+		ide_set_handler(drive, recal_intr, WAIT_CMD, NULL);
+		OUT_BYTE(args1->cmd, IDE_COMMAND_REG);
+
 		printk(KERN_INFO "%s: done!\n", drive->name);
 	}
