Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312326AbSDSNfC>; Fri, 19 Apr 2002 09:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312395AbSDSNfB>; Fri, 19 Apr 2002 09:35:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29190 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S312326AbSDSNe6>;
	Fri, 19 Apr 2002 09:34:58 -0400
Date: Fri, 19 Apr 2002 15:34:46 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Martin Dalecki <dalecki@evision-ventures.com>
Subject: [patch] ide updates
Message-ID: <20020419133446.GA813@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

IDE sync up, please apply. Against 2.5.8 + IDE-39, or current BK tree.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.557   -> 1.558  
#	 include/linux/ide.h	1.42    -> 1.43   
#	   drivers/ide/ide.c	1.60    -> 1.61   
#	drivers/ide/ide-taskfile.c	1.23    -> 1.24   
#	drivers/ide/Config.help	1.11    -> 1.12   
#	drivers/ide/ide-tcq.c	1.4     -> 1.5    
#	drivers/ide/Config.in	1.14    -> 1.15   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/19	axboe@burns.home.kernel.dk	1.558
# - (tcq, general) Remove the 'attempt to keep queue full option'. It worked
#   on some IBM models, but failed miserably on others. Also removes some
#   uglies in ide_queue_commands()
# - (tcq0 Change default depth back to 32.
# - (general) Add isr for no-dataphase taskfile, like task_no_data_intr but
#   doesn't complain about failure. This is handy for commands what we _know_
#   will fail, such as WIN_NOP.
# - (general) ide_cmd_type_parser() must set a handler to WIN_NOP... Otherwise
#   we will just hang the ide system issuing a nop.
# - (general) HWGROUP(drive)->rq->special -> IDE_CUR_AR(drive)
# - (general) Have ide_raw_taskfile() copy back the taskfile after execution,
#   otherwise we cannot use the info that ide_end_drive_cmd() puts in
#   there.
# - (tcq) Use nIEN bit correctly in ide-tcq
# - (tcq) Small ide_tcq_wait_altstat() changes. Do initial 400ns delay (1us
#   here), then 10us each successive run.
# - (tcq) Add beginning for 'nop auto poll' support check.
# - (tcq) Arm handler before GET_STAT() service check in
#   ide_dma_queued_start, WD seemed to trigger interrupt before that.
#   Makes WD Expert drives work with tcq.
# --------------------------------------------
#
diff -Nru a/drivers/ide/Config.help b/drivers/ide/Config.help
--- a/drivers/ide/Config.help	Fri Apr 19 15:16:08 2002
+++ b/drivers/ide/Config.help	Fri Apr 19 15:16:08 2002
@@ -753,24 +753,11 @@
   Support for tagged command queueing on ATA disk drives. This enables
   the IDE layer to have multiple in-flight requests on hardware that
   supports it. For now this includes the IBM Deskstar series drives,
-  such as the GXP75, 40GV, GXP60, and GXP120 (ie any Deskstar made in
-  the last couple of years).
+  such as the 22GXP, 75GXP, 40GV, 60GXP, and 120GXP (ie any Deskstar made
+  in the last couple of years), and at least some of the Western
+  Digital drives in the Expert series.
 
   If you have such a drive, say Y here.
-
-CONFIG_BLK_DEV_IDE_TCQ_FULL
-  When a command completes from the drive, the SERVICE bit is checked to
-  see if other queued commands are ready to be started. Doing this
-  immediately after a command completes has a tendency to 'starve' the
-  device hardware queue, since we risk emptying the queue completely
-  before starting any new commands. This shows up during stressing the
-  drive as a /\/\/\/\ queue size balance, where we could instead try and
-  maintain a minimum queue size and get a /---------\ graph instead.
-
-  Saying Y here will attempt to always keep the queue full when possible
-  at the cost of possibly increasing command turn-around latency.
-
-  Generally say Y here.
 
 CONFIG_BLK_DEV_IDE_TCQ_DEPTH
   Maximum size of commands to enable per-drive. Any value between 1
diff -Nru a/drivers/ide/Config.in b/drivers/ide/Config.in
--- a/drivers/ide/Config.in	Fri Apr 19 15:16:08 2002
+++ b/drivers/ide/Config.in	Fri Apr 19 15:16:08 2002
@@ -48,10 +48,9 @@
          dep_bool '    Enable DMA only for disks ' CONFIG_IDEDMA_ONLYDISK $CONFIG_IDEDMA_PCI_AUTO
 	 define_bool CONFIG_BLK_DEV_IDEDMA $CONFIG_BLK_DEV_IDEDMA_PCI
 	 dep_bool '    ATA tagged command queueing' CONFIG_BLK_DEV_IDE_TCQ $CONFIG_BLK_DEV_IDEDMA_PCI
-	 dep_bool '      Attempt to keep queue full' CONFIG_BLK_DEV_IDE_TCQ_FULL $CONFIG_BLK_DEV_IDE_TCQ
 	 dep_bool '      TCQ on by default' CONFIG_BLK_DEV_IDE_TCQ_DEFAULT $CONFIG_BLK_DEV_IDE_TCQ
 	 if [ "$CONFIG_BLK_DEV_IDE_TCQ" != "n" ]; then
-	    int '      Default queue depth' CONFIG_BLK_DEV_IDE_TCQ_DEPTH 8
+	    int '      Default queue depth' CONFIG_BLK_DEV_IDE_TCQ_DEPTH 32
 	 fi
 	 dep_bool '    ATA Work(s) In Progress (EXPERIMENTAL)' CONFIG_IDEDMA_PCI_WIP $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_EXPERIMENTAL
 	 dep_bool '    Good-Bad DMA Model-Firmware (WIP)' CONFIG_IDEDMA_NEW_DRIVE_LISTINGS $CONFIG_IDEDMA_PCI_WIP
diff -Nru a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
--- a/drivers/ide/ide-taskfile.c	Fri Apr 19 15:16:08 2002
+++ b/drivers/ide/ide-taskfile.c	Fri Apr 19 15:16:08 2002
@@ -545,11 +545,28 @@
 }
 
 /*
+ * Quiet handler for commands without a data phase -- handy instead of
+ * task_no_data_intr() for commands we _know_ will fail (such as WIN_NOP)
+ */
+ide_startstop_t task_no_data_quiet_intr(ide_drive_t *drive)
+{
+	struct ata_request *ar = IDE_CUR_AR(drive);
+	struct ata_taskfile *args = &ar->ar_task;
+
+	ide__sti();	/* local CPU only */
+
+	if (args)
+		ide_end_drive_cmd(drive, GET_STAT(), GET_ERR());
+
+	return ide_stopped;
+}
+
+/*
  * Handler for commands without a data phase
  */
 ide_startstop_t task_no_data_intr (ide_drive_t *drive)
 {
-	struct ata_request *ar = HWGROUP(drive)->rq->special;
+	struct ata_request *ar = IDE_CUR_AR(drive);
 	struct ata_taskfile *args = &ar->ar_task;
 	u8 stat = GET_STAT();
 
@@ -892,6 +909,7 @@
 			return;
 
 		case WIN_NOP:
+			args->handler = task_no_data_quiet_intr;
 			args->command_type = IDE_DRIVE_TASK_NO_DATA;
 			return;
 
@@ -919,6 +937,7 @@
 {
 	struct request rq;
 	struct ata_request star;
+	int ret;
 
 	ata_ar_init(drive, &star);
 	init_taskfile_request(&rq);
@@ -933,7 +952,13 @@
 
 	rq.special = &star;
 
-	return ide_do_drive_cmd(drive, &rq, ide_wait);
+	ret = ide_do_drive_cmd(drive, &rq, ide_wait);
+
+	/*
+	 * copy back status etc
+	 */
+	memcpy(args, &star.ar_task, sizeof(*args));
+	return ret;
 }
 
 /*
diff -Nru a/drivers/ide/ide-tcq.c b/drivers/ide/ide-tcq.c
--- a/drivers/ide/ide-tcq.c	Fri Apr 19 15:16:08 2002
+++ b/drivers/ide/ide-tcq.c	Fri Apr 19 15:16:08 2002
@@ -54,11 +54,11 @@
 ide_startstop_t ide_dmaq_intr(ide_drive_t *drive);
 ide_startstop_t ide_service(ide_drive_t *drive);
 
-static inline void drive_ctl_nien(ide_drive_t *drive, int clear)
+static inline void drive_ctl_nien(ide_drive_t *drive, int set)
 {
 #ifdef IDE_TCQ_NIEN
 	if (IDE_CONTROL_REG) {
-		int mask = clear ? 0x00 : 0x02;
+		int mask = set ? 0x02 : 0x00;
 
 		OUT_BYTE(drive->ctl | mask, IDE_CONTROL_REG);
 	}
@@ -77,12 +77,15 @@
 	struct ata_request *ar;
 	int i;
 
-	printk("%s: invalidating pending queue\n", drive->name);
+	printk("%s: invalidating pending queue (%d)\n", drive->name, drive->tcq->queued);
 
 	spin_lock_irqsave(&ide_lock, flags);
 
 	del_timer(&HWGROUP(drive)->timer);
 
+	if (test_bit(IDE_DMA, &HWGROUP(drive)->flags))
+		drive->channel->dmaproc(ide_dma_end, drive);
+
 	/*
 	 * assume oldest commands have the higher tags... doesn't matter
 	 * much. shove requests back into request queue.
@@ -188,21 +191,16 @@
 #define IDE_TCQ_WAIT	(10000)
 int ide_tcq_wait_altstat(ide_drive_t *drive, byte *stat, byte busy_mask)
 {
-	int i;
+	int i = 0;
 
-	/*
-	 * one initial udelay(1) should be enough, reading alt stat should
-	 * provide the required delay...
-	 */
-	*stat = 0;
-	i = 0;
-	do {
-		udelay(1);
+	udelay(1);
+
+	while ((*stat = GET_ALTSTAT()) & busy_mask) {
+		udelay(10);
 
 		if (unlikely(i++ > IDE_TCQ_WAIT))
 			return 1;
-
-	} while ((*stat = GET_ALTSTAT()) & busy_mask);
+	}
 
 	return 0;
 }
@@ -221,10 +219,12 @@
 
 	TCQ_PRINTK("%s: started service\n", drive->name);
 
-	drive->service_pending = 0;
-
+	/*
+	 * could be called with IDE_DMA in-progress from invalidate
+	 * handler, refuse to do anything
+	 */
 	if (test_bit(IDE_DMA, &HWGROUP(drive)->flags))
-		printk("ide_service: DMA in progress\n");
+		return ide_stopped;
 
 	/*
 	 * need to select the right drive first...
@@ -243,6 +243,7 @@
 
 	if (ide_tcq_wait_altstat(drive, &stat, BUSY_STAT)) {
 		printk("ide_service: BUSY clear took too long\n");
+		ide_dump_status(drive, "ide_service", stat);
 		ide_tcq_invalidate_queue(drive);
 		return ide_stopped;
 	}
@@ -342,23 +343,11 @@
 	TCQ_PRINTK("ide_dmaq_intr: ending %p, tag %d\n", ar, ar->ar_tag);
 	ide_end_queued_request(drive, !dma_stat, ar->ar_rq);
 
-	IDE_SET_CUR_TAG(drive, IDE_INACTIVE_TAG);
-
 	/*
-	 * keep the queue full, or honor SERVICE? note that this may race
-	 * and no new command will be started, in which case idedisk_do_request
-	 * will notice and do the service check
-	 */
-#if CONFIG_BLK_DEV_IDE_TCQ_FULL
-	if (!drive->service_pending && (ide_pending_commands(drive) > 1)) {
-		if (!blk_queue_empty(&drive->queue)) {
-			drive->service_pending = 1;
-			ide_tcq_set_intr(HWGROUP(drive), ide_dmaq_intr);
-			return ide_released;
-		}
-	}
-#endif
-
+	 * we completed this command, set tcq inactive and check if we
+	 * can service a new command
+	 */
+	IDE_SET_CUR_TAG(drive, IDE_INACTIVE_TAG);
 	return ide_check_service(drive);
 }
 
@@ -398,6 +387,43 @@
 }
 
 /*
+ * check if the ata adapter this drive is attached to supports the
+ * NOP auto-poll for multiple tcq enabled drives on one channel
+ */
+static int ide_tcq_check_autopoll(ide_drive_t *drive)
+{
+	struct ata_channel *ch = HWIF(drive);
+	struct ata_taskfile args;
+	ide_drive_t *next;
+
+	/*
+	 * only need to probe if both drives on a channel support tcq
+	 */
+	next = drive->next;
+	if (next == drive || !next->using_tcq)
+		return 0;
+
+	memset(&args, 0, sizeof(args));
+
+	args.taskfile.feature = 0x01;
+	args.taskfile.command = WIN_NOP;
+	ide_cmd_type_parser(&args);
+
+	/*
+	 * do taskfile and check ABRT bit -- intelligent adapters will not
+	 * pass NOP with sub-code 0x01 to device, so the command will not
+	 * fail there
+	 */
+	ide_raw_taskfile(drive, &args, NULL);
+	if (args.taskfile.feature & ABRT_ERR)
+		return 1;
+
+	ch->auto_poll = 1;
+	printk("%s: NOP Auto-poll enabled\n", ch->name);
+	return 0;
+}
+
+/*
  * configure the drive for tcq
  */
 static int ide_tcq_configure(ide_drive_t *drive)
@@ -493,6 +519,11 @@
 	if (ide_build_commandlist(drive))
 		return 1;
 
+	/*
+	 * check auto-poll support
+	 */
+	ide_tcq_check_autopoll(drive);
+
 	if (depth != drive->queue_depth)
 		printk("%s: tagged command queueing enabled, command queue depth %d\n", drive->name, drive->queue_depth);
 
@@ -563,7 +594,8 @@
 			OUT_BYTE(AR_TASK_CMD(ar), IDE_COMMAND_REG);
 
 			if (ide_tcq_wait_altstat(drive, &stat, BUSY_STAT)) {
-				printk("ide_dma_queued_start: abort (stat=%x)\n", stat);
+				ide_dump_status(drive, "queued start", stat);
+				ide_tcq_invalidate_queue(drive);
 				return ide_stopped;
 			}
 
@@ -582,12 +614,13 @@
 				IDE_SET_CUR_TAG(drive, IDE_INACTIVE_TAG);
 				drive->tcq->immed_rel++;
 
+				ide_tcq_set_intr(HWGROUP(drive), ide_dmaq_intr);
+
 				TCQ_PRINTK("REL in queued_start\n");
 
 				if ((stat = GET_STAT()) & SERVICE_STAT)
 					return ide_service(drive);
 
-				ide_tcq_set_intr(HWGROUP(drive), ide_dmaq_intr);
 				return ide_released;
 			}
 
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	Fri Apr 19 15:16:08 2002
+++ b/drivers/ide/ide.c	Fri Apr 19 15:16:08 2002
@@ -1317,12 +1317,6 @@
 	return NULL;
 }
 
-#ifdef CONFIG_BLK_DEV_IDE_TCQ
-ide_startstop_t ide_check_service(ide_drive_t *drive);
-#else
-#define ide_check_service(drive)	(ide_stopped)
-#endif
-
 /*
  * feed commands to a drive until it barfs. used to be part of ide_do_request.
  * called with ide_lock/DRIVE_LOCK held and busy hwgroup
@@ -1332,7 +1326,6 @@
 	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 	ide_startstop_t startstop = -1;
 	struct request *rq;
-	int do_service = 0;
 
 	do {
 		rq = NULL;
@@ -1388,7 +1381,6 @@
 
 		hwgroup->rq = rq;
 
-service:
 		/*
 		 * Some systems have trouble with IDE IRQs arriving while
 		 * the driver is still setting things up.  So, here we disable
@@ -1403,10 +1395,7 @@
 
 		spin_unlock(&ide_lock);
 		ide__sti();	/* allow other IRQs while we start this request */
-		if (!do_service)
-			startstop = start_request(drive, rq);
-		else
-			startstop = ide_check_service(drive);
+		startstop = start_request(drive, rq);
 
 		spin_lock_irq(&ide_lock);
 		if (masked_irq && HWIF(drive)->irq != masked_irq)
@@ -1433,9 +1422,6 @@
 
 	if (startstop == ide_started)
 		return;
-
-	if ((do_service = drive->service_pending))
-		goto service;
 }
 
 /*
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	Fri Apr 19 15:16:08 2002
+++ b/include/linux/ide.h	Fri Apr 19 15:16:08 2002
@@ -363,7 +363,6 @@
 	unsigned autotune	: 2;	/* 1=autotune, 2=noautotune, 0=default */
 	unsigned remap_0_to_1	: 2;	/* 0=remap if ezdrive, 1=remap, 2=noremap */
 	unsigned ata_flash	: 1;	/* 1=present, 0=default */
-	unsigned service_pending: 1;
 	unsigned	addressing;	/* : 2; 0=28-bit, 1=48-bit, 2=64-bit */
 	byte		scsi;		/* 0=default, 1=skip current ide-subdriver for ide-scsi emulation */
 	select_t	select;		/* basic drive/head select reg value */
@@ -518,7 +517,7 @@
 	byte		io_32bit;	/* 0=16-bit, 1=32-bit, 2/3=32bit+sync */
 	unsigned no_unmask	   : 1;	/* disallow setting unmask bit */
 	byte		unmask;		/* flag: okay to unmask other irqs */
-
+	unsigned	auto_poll  : 1; /* supports nop auto-poll */
 #if (DISK_RECOVERY_TIME > 0)
 	unsigned long	last_time;	/* time when previous rq was done */
 #endif

-- 
Jens Axboe

