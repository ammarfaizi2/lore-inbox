Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312797AbSDOOrk>; Mon, 15 Apr 2002 10:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312799AbSDOOrj>; Mon, 15 Apr 2002 10:47:39 -0400
Received: from [195.63.194.11] ([195.63.194.11]:45071 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S312797AbSDOOra>; Mon, 15 Apr 2002 10:47:30 -0400
Message-ID: <3CBAD971.4030603@evision-ventures.com>
Date: Mon, 15 Apr 2002 15:45:21 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: [PATCH] 2.5.8 IDE 35
In-Reply-To: <Pine.LNX.4.33.0204051657270.16281-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------060405060804010009080108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060405060804010009080108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Mon Apr 15 16:33:24 CEST 2002 ide-clean-35

Just "raw" synchronization with Jens Axboe. This patch applies on top of
ide-clean-34. The his changelog is included just for the record. All the credit
for this work goes actually to Jens:

Updated the patch to 2.5.8 (painful). Changes:

- Expand configure help options a bit
- Fix xconfig bug (thanks to
- Decrease queue depth if a command takes too long to complete
- Test master/slave stuff. It works, but one device can heavily starve
   another. This is the simple approach right now, means that one device
   will wait until the other is completely idle before starting any
   commands This is not necessary since we can have queued commands on
   both devices at the same time. TODO.
- Add proc output for oldest command, just for testing.
- pci_dev compile fixes.
- Make sure ide-disk doesn't BUG if TCQ is not used, basically this was
   fixed by off-loading the using_tcq setting to ide-tcq.
- Remove warning about 'queued feature set not supported'
- Abstract ide_tcq_wait_dataphase() into a function

--------------060405060804010009080108
Content-Type: text/plain;
 name="ide-clean-35.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-35.diff"

diff -urN linux-2.5.8/drivers/ide/Config.help linux/drivers/ide/Config.help
--- linux-2.5.8/drivers/ide/Config.help	Mon Apr 15 08:53:44 2002
+++ linux/drivers/ide/Config.help	Mon Apr 15 16:07:45 2002
@@ -753,9 +753,17 @@
 
   If you have such a drive, say Y here.
 
-CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
-  Enabled tagged command queueing unconditionally on drives that report
-  support for it.
+CONFIG_BLK_DEV_IDE_TCQ_FULL
+  When a command completes from the drive, the SERVICE bit is checked to
+  see if other queued commands are ready to be started. Doing this
+  immediately after a command completes has a tendency to 'starve' the
+  device hardware queue, since we risk emptying the queue completely
+  before starting any new commands. This shows up during stressing the
+  drive as a /\/\/\/\ queue size balance, where we could instead try and
+  maintain a minimum queue size and get a /---------\ graph instead.
+
+  Saying Y here will attempt to always keep the queue full when possible
+  at the cost of possibly increasing command turn-around latency.
 
   Generally say Y here.
 
@@ -766,6 +774,18 @@
   You probably just want the default of 32 here. If you enter an invalid
   number, the default value will be used.
 
+CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
+  Enabled tagged command queueing unconditionally on drives that report
+  support for it. Regardless of the chosen value here, tagging can be
+  controlled at run time:
+
+  echo "using_tcq:32" > /proc/ide/hdX/settings
+
+  where any value between 1-32 selects chosen queue depth and enables
+  TCQ, and 0 disables it.
+
+  Generally say Y here.
+
 CONFIG_BLK_DEV_IT8172
   Say Y here to support the on-board IDE controller on the Integrated
   Technology Express, Inc. ITE8172 SBC.  Vendor page at
diff -urN linux-2.5.8/drivers/ide/Config.in linux/drivers/ide/Config.in
--- linux-2.5.8/drivers/ide/Config.in	Mon Apr 15 08:53:44 2002
+++ linux/drivers/ide/Config.in	Mon Apr 15 16:07:45 2002
@@ -48,10 +48,11 @@
          dep_bool '    Enable DMA only for disks ' CONFIG_IDEDMA_ONLYDISK $CONFIG_IDEDMA_PCI_AUTO
 	 define_bool CONFIG_BLK_DEV_IDEDMA $CONFIG_BLK_DEV_IDEDMA_PCI
 	 dep_bool '    ATA tagged command queueing' CONFIG_BLK_DEV_IDE_TCQ $CONFIG_BLK_DEV_IDEDMA_PCI
-	   dep_bool '      TCQ on by default' CONFIG_BLK_DEV_IDE_TCQ_DEFAULT $CONFIG_BLK_DEV_IDE_TCQ
-	   if [ $CONFIG_BLK_DEV_IDE_TCQ_DEFAULT != "n" ]; then
-		int '      Default queue depth' CONFIG_BLK_DEV_IDE_TCQ_DEPTH 32
-	   fi
+	 dep_bool '      Attempt to keep queue full' CONFIG_BLK_DEV_IDE_TCQ_FULL $CONFIG_BLK_DEV_IDE_TCQ
+	 dep_bool '      TCQ on by default' CONFIG_BLK_DEV_IDE_TCQ_DEFAULT $CONFIG_BLK_DEV_IDE_TCQ
+	 if [ "$CONFIG_BLK_DEV_IDE_TCQ" != "n" ]; then
+	    int '      Default queue depth' CONFIG_BLK_DEV_IDE_TCQ_DEPTH 8
+	 fi
 	 dep_bool '    ATA Work(s) In Progress (EXPERIMENTAL)' CONFIG_IDEDMA_PCI_WIP $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_EXPERIMENTAL
 	 dep_bool '    Good-Bad DMA Model-Firmware (WIP)' CONFIG_IDEDMA_NEW_DRIVE_LISTINGS $CONFIG_IDEDMA_PCI_WIP
 	 dep_bool '    AEC62XX chipset support' CONFIG_BLK_DEV_AEC62XX $CONFIG_BLK_DEV_IDEDMA_PCI
diff -urN linux-2.5.8/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.8/drivers/ide/ide-disk.c	Mon Apr 15 08:53:44 2002
+++ linux/drivers/ide/ide-disk.c	Mon Apr 15 16:07:45 2002
@@ -107,10 +107,7 @@
 	 * 48-bit commands are pretty sanely laid out
 	 */
 	if (lba48bit) {
-		if (cmd == READ)
-			command = WIN_READ_EXT;
-		else
-			command = WIN_WRITE_EXT;
+		command = cmd == READ ? WIN_READ_EXT : WIN_WRITE_EXT;
 
 		if (drive->using_dma) {
 			command++;		/* WIN_*DMA_EXT */
@@ -118,31 +115,33 @@
 				command++;	/* WIN_*DMA_QUEUED_EXT */
 		} else if (drive->mult_count)
 			command += 5;		/* WIN_MULT*_EXT */
-	} else {
-		/*
-		 * 28-bit commands seem not to be, though...
-		 */
-		if (cmd == READ) {
-			if (drive->using_dma) {
-				if (drive->using_tcq)
-					command = WIN_READDMA_QUEUED;
-				else
-					command = WIN_READDMA;
-			} else if (drive->mult_count)
-				command = WIN_MULTREAD;
+
+		return command;
+	}
+
+	/*
+	 * 28-bit commands seem not to be, though...
+	 */
+	if (cmd == READ) {
+		if (drive->using_dma) {
+			if (drive->using_tcq)
+				command = WIN_READDMA_QUEUED;
 			else
-				command = WIN_READ;
-		} else {
-			if (drive->using_dma) {
-				if (drive->using_tcq)
-					command = WIN_WRITEDMA_QUEUED;
-				else
-					command = WIN_WRITEDMA;
-			} else if (drive->mult_count)
-				command = WIN_MULTWRITE;
+				command = WIN_READDMA;
+		} else if (drive->mult_count)
+			command = WIN_MULTREAD;
+		else
+			command = WIN_READ;
+	} else {
+		if (drive->using_dma) {
+			if (drive->using_tcq)
+				command = WIN_WRITEDMA_QUEUED;
 			else
-				command = WIN_WRITE;
-		}
+				command = WIN_WRITEDMA;
+		} else if (drive->mult_count)
+			command = WIN_MULTWRITE;
+		else
+			command = WIN_WRITE;
 	}
 
 	return command;
@@ -895,24 +894,24 @@
 
 		__set_bit(i, &tag_mask);
 		len += sprintf(out+len, "%d, ", i);
-		if (ar->ar_time > max_jif)
-			max_jif = ar->ar_time;
+		if (cur_jif - ar->ar_time > max_jif)
+			max_jif = cur_jif - ar->ar_time;
 		cmds++;
 	}
 	len += sprintf(out+len, "]\n");
 
+	len += sprintf(out+len, "Queue:\t\t\treleased [ %d ] - started [ %d ]\n", drive->tcq->immed_rel, drive->tcq->immed_comp);
+
 	if (drive->tcq->queued != cmds)
-		len += sprintf(out+len, "pending request and queue count mismatch (%d)\n", cmds);
+		len += sprintf(out+len, "pending request and queue count mismatch (counted: %d)\n", cmds);
 
 	if (tag_mask != drive->tcq->tag_mask)
 		len += sprintf(out+len, "tag masks differ (counted %lx != %lx\n", tag_mask, drive->tcq->tag_mask);
 
 	len += sprintf(out+len, "DMA status:\t\t%srunning\n", test_bit(IDE_DMA, &HWGROUP(drive)->flags) ? "" : "not ");
 
-	if (max_jif)
-		len += sprintf(out+len, "Oldest command:\t\t%lu\n", cur_jif - max_jif);
-
-	len += sprintf(out+len, "immed rel %d, immed comp %d\n", drive->tcq->immed_rel, drive->tcq->immed_comp);
+	len += sprintf(out+len, "Oldest command:\t\t%lu jiffies\n", max_jif);
+	len += sprintf(out+len, "Oldest command ever:\t%lu\n", drive->tcq->oldest_command);
 
 	drive->tcq->max_last_depth = 0;
 
@@ -1017,8 +1016,10 @@
 		return -EPERM;
 	if (!drive->channel->dmaproc)
 		return -EPERM;
+	if (arg == drive->queue_depth && drive->using_tcq)
+		return 0;
 
-	drive->using_tcq = arg;
+	drive->queue_depth = arg ? arg : 1;
 	if (drive->channel->dmaproc(arg ? ide_dma_queued_on : ide_dma_queued_off, drive))
 		return -EIO;
 
diff -urN linux-2.5.8/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- linux-2.5.8/drivers/ide/ide-dma.c	Mon Apr 15 08:53:44 2002
+++ linux/drivers/ide/ide-dma.c	Mon Apr 15 16:07:45 2002
@@ -610,9 +610,6 @@
 		case ide_dma_check:
 			return config_drive_for_dma (drive);
 		case ide_dma_begin:
-#ifdef DEBUG
-			printk("ide_dma_begin: from %p\n", __builtin_return_address(0));
-#endif
 			if (test_and_set_bit(IDE_DMA, &HWGROUP(drive)->flags))
 				BUG();
 			/* Note that this is done *after* the cmd has
@@ -634,14 +631,13 @@
 		case ide_dma_read:
 			reading = 1 << 3;
 		case ide_dma_write:
-			ar = HWGROUP(drive)->rq->special;
+			ar = IDE_CUR_AR(drive);
 
 			if (ide_start_dma(hwif, drive, func))
 				return 1;
 
 			if (drive->type != ATA_DISK)
 				return 0;
-
 			BUG_ON(HWGROUP(drive)->handler);
 			ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, dma_timer_expiry);	/* issue cmd to drive */
 			if ((ar->ar_rq->flags & REQ_DRIVE_TASKFILE) &&
@@ -655,20 +651,13 @@
 			}
 			return hwif->dmaproc(ide_dma_begin, drive);
 		case ide_dma_end: /* returns 1 on error, 0 otherwise */
-#ifdef DEBUG
-			printk("ide_dma_end: from %p\n", __builtin_return_address(0));
-#endif
-			if (!test_and_clear_bit(IDE_DMA, &HWGROUP(drive)->flags)) {
-				printk("ide_dma_end: dma not going? %p\n", __builtin_return_address(0));
-				return 1;
-			}
+			if (!test_and_clear_bit(IDE_DMA, &HWGROUP(drive)->flags))
+				BUG();
 			drive->waiting_for_dma = 0;
 			outb(inb(dma_base)&~1, dma_base);	/* stop DMA */
 			dma_stat = inb(dma_base+2);	/* get DMA status */
 			outb(dma_stat|6, dma_base+2);	/* clear the INTR & ERROR bits */
 			ide_destroy_dmatable(drive);	/* purge DMA mappings */
-			if (drive->tcq)
-				IDE_SET_CUR_TAG(drive, -1);
 			return (dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;	/* verify good DMA status */
 		case ide_dma_test_irq: /* returns 1 if dma irq issued, 0 otherwise */
 			dma_stat = inb(dma_base+2);
diff -urN linux-2.5.8/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux-2.5.8/drivers/ide/ide-probe.c	Mon Apr 15 08:53:44 2002
+++ linux/drivers/ide/ide-probe.c	Mon Apr 15 16:07:45 2002
@@ -192,19 +192,16 @@
 	/*
 	 * it's an ata drive, build command list
 	 */
-#ifndef CONFIG_BLK_DEV_IDE_TCQ
 	drive->queue_depth = 1;
+#ifdef CONFIG_BLK_DEV_IDE_TCQ_DEPTH
+	drive->queue_depth = CONFIG_BLK_DEV_IDE_TCQ_DEPTH;
 #else
-# ifndef CONFIG_BLK_DEV_IDE_TCQ_DEPTH
-#  define CONFIG_BLK_DEV_IDE_TCQ_DEPTH 1
-# endif
 	drive->queue_depth = drive->id->queue_depth + 1;
-	if (drive->queue_depth > CONFIG_BLK_DEV_IDE_TCQ_DEPTH)
-		drive->queue_depth = CONFIG_BLK_DEV_IDE_TCQ_DEPTH;
+#endif
 	if (drive->queue_depth < 1 || drive->queue_depth > IDE_MAX_TAG)
 		drive->queue_depth = IDE_MAX_TAG;
-#endif
-	if (ide_build_commandlist(drive))
+
+	if (ide_init_commandlist(drive))
 		goto err_misc;
 
 	return;
diff -urN linux-2.5.8/drivers/ide/ide-tcq.c linux/drivers/ide/ide-tcq.c
--- linux-2.5.8/drivers/ide/ide-tcq.c	Mon Apr 15 08:53:44 2002
+++ linux/drivers/ide/ide-tcq.c	Mon Apr 15 16:07:45 2002
@@ -29,9 +29,11 @@
 #include <asm/delay.h>
 
 /*
- * warning: it will be _very_ verbose if set to 1
+ * warning: it will be _very_ verbose if defined
  */
-#if 0
+#undef IDE_TCQ_DEBUG
+
+#ifdef IDE_TCQ_DEBUG
 #define TCQ_PRINTK printk
 #else
 #define TCQ_PRINTK(x...)
@@ -49,13 +51,18 @@
  */
 #undef IDE_TCQ_FIDDLE_SI
 
-int ide_tcq_end(ide_drive_t *drive);
+/*
+ * wait for data phase before starting DMA or not
+ */
+#undef IDE_TCQ_WAIT_DATAPHASE
+
 ide_startstop_t ide_dmaq_intr(ide_drive_t *drive);
+ide_startstop_t ide_service(ide_drive_t *drive);
 
 static inline void drive_ctl_nien(ide_drive_t *drive, int clear)
 {
 #ifdef IDE_TCQ_NIEN
-	int mask = clear ? 0 : 2;
+	int mask = clear ? 0x00 : 0x02;
 
 	if (IDE_CONTROL_REG)
 		OUT_BYTE(drive->ctl | mask, IDE_CONTROL_REG);
@@ -142,7 +149,7 @@
 
 	spin_lock_irqsave(&ide_lock, flags);
 
-	if (test_bit(IDE_BUSY, &hwgroup->flags))
+	if (test_and_set_bit(IDE_BUSY, &hwgroup->flags))
 		printk("ide_tcq_intr_timeout: hwgroup not busy\n");
 	if (hwgroup->handler == NULL)
 		printk("ide_tcq_intr_timeout: missing isr!\n");
@@ -151,6 +158,13 @@
 
 	spin_unlock_irqrestore(&ide_lock, flags);
 
+	/*
+	 * if pending commands, try service before giving up
+	 */
+	if (ide_pending_commands(drive) && (GET_STAT() & SERVICE_STAT))
+		if (ide_service(drive) == ide_started)
+			return;
+
 	if (drive)
 		ide_tcq_invalidate_queue(drive);
 }
@@ -192,6 +206,7 @@
 
 		if (unlikely(i++ > IDE_TCQ_WAIT))
 			return 1;
+
 	} while ((*stat = GET_ALTSTAT()) & busy_mask);
 
 	return 0;
@@ -206,7 +221,12 @@
 ide_startstop_t ide_service(ide_drive_t *drive)
 {
 	struct ata_request *ar;
-	byte feat, tag, stat;
+	byte feat, stat;
+	int tag;
+
+	TCQ_PRINTK("%s: started service\n", drive->name);
+
+	drive->service_pending = 0;
 
 	if (test_bit(IDE_DMA, &HWGROUP(drive)->flags))
 		printk("ide_service: DMA in progress\n");
@@ -238,9 +258,9 @@
 	 * FIXME, invalidate queue
 	 */
 	if (stat & ERR_STAT) {
-		printk("%s: error SERVICING drive (%x)\n", drive->name, stat);
 		ide_dump_status(drive, "ide_service", stat);
-		return ide_tcq_end(drive);
+		ide_tcq_invalidate_queue(drive);
+		return ide_stopped;
 	}
 
 	/*
@@ -248,7 +268,7 @@
 	 */
 	if ((feat = GET_FEAT()) & NSEC_REL) {
 		printk("%s: release in service\n", drive->name);
-		IDE_SET_CUR_TAG(drive, -1);
+		IDE_SET_CUR_TAG(drive, IDE_INACTIVE_TAG);
 		return ide_stopped;
 	}
 
@@ -265,6 +285,8 @@
 		return ide_stopped;
 	}
 
+	HWGROUP(drive)->rq = ar->ar_rq;
+
 	/*
 	 * we'll start a dma read or write, device will trigger
 	 * interrupt to indicate end of transfer, release is not allowed
@@ -287,6 +309,8 @@
 {
 	byte stat;
 
+	TCQ_PRINTK("%s: ide_check_service\n", drive->name);
+
 	if (!ide_pending_commands(drive))
 		return ide_stopped;
 
@@ -300,40 +324,14 @@
 	return ide_started;
 }
 
-int ide_tcq_end(ide_drive_t *drive)
-{
-	byte stat = GET_STAT();
-
-	if (stat & ERR_STAT) {
-		ide_dump_status(drive, "ide_tcq_end", stat);
-		ide_tcq_invalidate_queue(drive);
-		return ide_stopped;
-	} else if (stat & SERVICE_STAT) {
-		TCQ_PRINTK("ide_tcq_end: serv stat=%x\n", stat);
-		return ide_service(drive);
-	}
-
-	TCQ_PRINTK("ide_tcq_end: stat=%x, feat=%x\n", stat, GET_FEAT());
-	return ide_stopped;
-}
-
 ide_startstop_t ide_dmaq_complete(ide_drive_t *drive, byte stat)
 {
-	struct ata_request *ar;
+	struct ata_request *ar = IDE_CUR_TAG(drive);
 	byte dma_stat;
 
-#if 0
-	byte feat = GET_FEAT();
-
-	if ((feat & (NSEC_CD | NSEC_IO)) != (NSEC_CD | NSEC_IO))
-		printk("%s: C/D | I/O not set\n", drive->name);
-#endif
-
 	/*
 	 * transfer was in progress, stop DMA engine
 	 */
-	ar = IDE_CUR_TAG(drive);
-
 	dma_stat = drive->channel->dmaproc(ide_dma_end, drive);
 
 	/*
@@ -352,7 +350,23 @@
 	TCQ_PRINTK("ide_dmaq_intr: ending %p, tag %d\n", ar, ar->ar_tag);
 	ide_end_queued_request(drive, !dma_stat, ar->ar_rq);
 
-	IDE_SET_CUR_TAG(drive, -1);
+	IDE_SET_CUR_TAG(drive, IDE_INACTIVE_TAG);
+
+	/*
+	 * keep the queue full, or honor SERVICE? note that this may race
+	 * and no new command will be started, in which case idedisk_do_request
+	 * will notice and do the service check
+	 */
+#if CONFIG_BLK_DEV_IDE_TCQ_FULL
+	if (!drive->service_pending && (ide_pending_commands(drive) > 1)) {
+		if (!blk_queue_empty(&drive->queue)) {
+			drive->service_pending = 1;
+			ide_tcq_set_intr(HWGROUP(drive), ide_dmaq_intr);
+			return ide_released;
+		}
+	}
+#endif
+
 	return ide_check_service(drive);
 }
 
@@ -376,7 +390,7 @@
 	 * if a command completion interrupt is pending, do that first and
 	 * check service afterwards
 	 */
-	if (drive->tcq->active_tag != -1)
+	if (drive->tcq->active_tag != IDE_INACTIVE_TAG)
 		return ide_dmaq_complete(drive, stat);
 
 	/*
@@ -403,10 +417,8 @@
 	 * bit 14 and 1 must be set in word 83 of the device id to indicate
 	 * support for dma queued protocol
 	 */
-	if ((drive->id->command_set_2 & tcq_supp) != tcq_supp) {
-		printk("%s: queued feature set not supported\n", drive->name);
-		return 1;
-	}
+	if ((drive->id->command_set_2 & tcq_supp) != tcq_supp)
+		return -EIO;
 
 	memset(&args, 0, sizeof(args));
 	args.taskfile.feature = SETFEATURES_EN_WCACHE;
@@ -446,6 +458,16 @@
 		return 1;
 	}
 #endif
+
+	if (!drive->tcq) {
+		drive->tcq = kmalloc(sizeof(ide_tag_info_t), GFP_ATOMIC);
+		if (!drive->tcq)
+			return -ENOMEM;
+
+		memset(drive->tcq, 0, sizeof(ide_tag_info_t));
+		drive->tcq->active_tag = IDE_INACTIVE_TAG;
+	}
+
 	return 0;
 }
 
@@ -461,26 +483,33 @@
 	if (!on) {
 		printk("%s: TCQ disabled\n", drive->name);
 		drive->using_tcq = 0;
-
 		return 0;
-	} else if (drive->using_tcq) {
-		drive->queue_depth = drive->using_tcq;
-
-		goto out;
 	}
 
 	if (ide_tcq_configure(drive)) {
 		drive->using_tcq = 0;
-
 		return 1;
 	}
 
-out:
-	drive->tcq->max_depth = 0;
+	if (ide_build_commandlist(drive))
+		return 1;
 
 	printk("%s: tagged command queueing enabled, command queue depth %d\n", drive->name, drive->queue_depth);
 	drive->using_tcq = 1;
+	drive->tcq->max_depth = 0;
+	return 0;
+}
 
+int ide_tcq_wait_dataphase(ide_drive_t *drive)
+{
+#ifdef IDE_TCQ_WAIT_DATAPHASE
+	ide_startstop_t foo;
+
+	if (ide_wait_stat(&startstop, drive, READY_STAT | DRQ_STAT, BUSY_STAT, WAIT_READY)) {
+		printk("%s: timeout waiting for data phase\n", drive->name);
+		return 1;
+	}
+#endif
 	return 0;
 }
 
@@ -488,7 +517,6 @@
 {
 	struct ata_channel *hwif = drive->channel;
 	unsigned int reading = 0, enable_tcq = 1;
-	ide_startstop_t startstop;
 	struct ata_request *ar;
 	byte stat, feat;
 
@@ -501,15 +529,13 @@
 			reading = 1 << 3;
 		case ide_dma_write_queued:
 			TCQ_PRINTK("ide_dma: setting up queued %d\n", drive->tcq->active_tag);
-			BUG_ON(drive->tcq->active_tag == -1);
+			BUG_ON(drive->tcq->active_tag == IDE_INACTIVE_TAG);
 
 			if (!test_bit(IDE_BUSY, &HWGROUP(drive)->flags))
 				printk("queued_rw: IDE_BUSY not set\n");
 
-			if (ide_wait_stat(&startstop, drive, READY_STAT | DRQ_STAT, BUSY_STAT, WAIT_READY)) {
-				printk("%s: timeout waiting for data phase\n", drive->name);
-				return startstop;
-			}
+			if (ide_tcq_wait_dataphase(drive))
+				return ide_stopped;
 
 			if (ide_start_dma(hwif, drive, func))
 				return 1;
@@ -521,7 +547,7 @@
 			 * start a queued command from scratch
 			 */
 		case ide_dma_queued_start:
-			BUG_ON(drive->tcq->active_tag == -1);
+			BUG_ON(drive->tcq->active_tag == IDE_INACTIVE_TAG);
 			ar = IDE_CUR_TAG(drive);
 
 			/*
@@ -540,14 +566,19 @@
 			drive_ctl_nien(drive, 0);
 
 			if (stat & ERR_STAT) {
-				printk("ide_dma_queued_start: abort (stat=%x)\n", stat);
+				ide_dump_status(drive, "tcq_start", stat);
 				return ide_stopped;
 			}
 
+			/*
+			 * drive released the bus, clear active tag and
+			 * check for service
+			 */
 			if ((feat = GET_FEAT()) & NSEC_REL) {
+				IDE_SET_CUR_TAG(drive, IDE_INACTIVE_TAG);
 				drive->tcq->immed_rel++;
+
 				TCQ_PRINTK("REL in queued_start\n");
-				IDE_SET_CUR_TAG(drive, -1);
 
 				if ((stat = GET_STAT()) & SERVICE_STAT)
 					return ide_service(drive);
@@ -558,21 +589,24 @@
 
 			drive->tcq->immed_comp++;
 
-			if (ide_wait_stat(&startstop, drive, READY_STAT | DRQ_STAT, BUSY_STAT, WAIT_READY)) {
-				printk("%s: timeout waiting for data phase\n", drive->name);
-				return startstop;
-			}
+			if (ide_tcq_wait_dataphase(drive))
+				return ide_stopped;
 
 			if (ide_start_dma(hwif, drive, func))
 				return ide_stopped;
 
+			/*
+			 * need to arm handler before starting dma engine,
+			 * transfer could complete right away
+			 */
+			ide_tcq_set_intr(HWGROUP(drive), ide_dmaq_intr);
+
 			if (hwif->dmaproc(ide_dma_begin, drive))
 				return ide_stopped;
 
 			/*
 			 * wait for SERVICE or completion interrupt
 			 */
-			ide_tcq_set_intr(HWGROUP(drive), ide_dmaq_intr);
 			return ide_started;
 
 		case ide_dma_queued_off:
@@ -590,6 +624,10 @@
 ide_startstop_t ide_start_tag(ide_dma_action_t func, ide_drive_t *drive,
 			      struct ata_request *ar)
 {
+	ide_startstop_t startstop;
+
+	TCQ_PRINTK("%s: ide_start_tag: begin tag %p/%d, rq %p\n", drive->name,ar,ar->ar_tag, ar->ar_rq);
+
 	/*
 	 * do this now, no need to run that with interrupts disabled
 	 */
@@ -597,5 +635,14 @@
 		return ide_stopped;
 
 	IDE_SET_CUR_TAG(drive, ar->ar_tag);
-	return ide_tcq_dmaproc(func, drive);
+	HWGROUP(drive)->rq = ar->ar_rq;
+
+	startstop = ide_tcq_dmaproc(func, drive);
+
+	if (unlikely(startstop == ide_stopped)) {
+		IDE_SET_CUR_TAG(drive, IDE_INACTIVE_TAG);
+		HWGROUP(drive)->rq = NULL;
+	}
+
+	return startstop;
 }
diff -urN linux-2.5.8/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.8/drivers/ide/ide.c	Mon Apr 15 16:36:43 2002
+++ linux/drivers/ide/ide.c	Mon Apr 15 16:13:05 2002
@@ -381,8 +381,23 @@
 		add_blkdev_randomness(major(rq->rq_dev));
 
 		spin_lock_irqsave(&ide_lock, flags);
+
+		if ((jiffies - ar->ar_time > ATA_AR_MAX_TURNAROUND) && drive->queue_depth > 1) {
+			printk("%s: exceeded max command turn-around time (%d seconds)\n", drive->name, ATA_AR_MAX_TURNAROUND / HZ);
+			drive->queue_depth >>= 1;
+		}
+
+		if (jiffies - ar->ar_time > drive->tcq->oldest_command)
+			drive->tcq->oldest_command = jiffies - ar->ar_time;
+
 		ata_ar_put(drive, ar);
 		end_that_request_last(rq);
+		/*
+		 * IDE_SET_CUR_TAG(drive, IDE_INACTIVE_TAG) will do this
+		 * too, but it really belongs here. assumes that the
+		 * ended request is the active one.
+		 */
+		HWGROUP(drive)->rq = NULL;
 		spin_unlock_irqrestore(&ide_lock, flags);
 	}
 }
@@ -770,8 +785,7 @@
 		struct ata_taskfile *args = &ar->ar_task;
 
 		rq->errors = !OK_STAT(stat, READY_STAT, BAD_STAT);
-		if (args && args->taskfile.command == WIN_NOP)
-			printk(KERN_INFO "%s: NOP completed\n", __FUNCTION__);
+
 		if (args) {
 			args->taskfile.feature = err;
 			args->taskfile.sector_count = IN_BYTE(IDE_NSECTOR_REG);
@@ -1101,11 +1115,7 @@
 	while ((read_timer() - hwif->last_time) < DISK_RECOVERY_TIME);
 #endif
 
-	if (test_bit(IDE_DMA, &HWGROUP(drive)->flags))
-		printk("start_request: auch, DMA in progress 1\n");
 	SELECT_DRIVE(hwif, drive);
-	if (test_bit(IDE_DMA, &HWGROUP(drive)->flags))
-		printk("start_request: auch, DMA in progress 2\n");
 	if (ide_wait_stat(&startstop, drive, drive->ready_stat,
 			  BUSY_STAT|DRQ_STAT, WAIT_READY)) {
 		printk(KERN_WARNING "%s: drive not ready for command\n", drive->name);
@@ -1277,6 +1287,170 @@
 	return best;
 }
 
+static ide_drive_t *ide_choose_drive(ide_hwgroup_t *hwgroup)
+{
+	ide_drive_t *drive = choose_drive(hwgroup);
+	unsigned long sleep = 0;
+
+	if (drive)
+		return drive;
+
+	hwgroup->rq = NULL;
+	drive = hwgroup->drive;
+	do {
+		if (drive->PADAM_sleep && (!sleep || time_after(sleep, drive->PADAM_sleep)))
+			sleep = drive->PADAM_sleep;
+	} while ((drive = drive->next) != hwgroup->drive);
+
+	if (sleep) {
+		/*
+		 * Take a short snooze, and then wake up this hwgroup
+		 * again.  This gives other hwgroups on the same a
+		 * chance to play fairly with us, just in case there
+		 * are big differences in relative throughputs.. don't
+		 * want to hog the cpu too much.
+		 */
+		if (0 < (signed long)(jiffies + WAIT_MIN_SLEEP - sleep))
+			sleep = jiffies + WAIT_MIN_SLEEP;
+
+		if (timer_pending(&hwgroup->timer))
+			printk("ide_set_handler: timer already active\n");
+
+		set_bit(IDE_SLEEP, &hwgroup->flags);
+		mod_timer(&hwgroup->timer, sleep);
+		/* we purposely leave hwgroup busy while
+		 * sleeping */
+	} else {
+		/* Ugly, but how can we sleep for the lock
+		 * otherwise? perhaps from tq_disk? */
+		ide_release_lock(&ide_intr_lock);/* for atari only */
+		clear_bit(IDE_BUSY, &hwgroup->flags);
+	}
+
+	return NULL;
+}
+
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+ide_startstop_t ide_check_service(ide_drive_t *drive);
+#else
+#define ide_check_service(drive)	(ide_stopped)
+#endif
+
+/*
+ * feed commands to a drive until it barfs. used to be part of ide_do_request.
+ * called with ide_lock/DRIVE_LOCK held and busy hwgroup
+ */
+static void ide_queue_commands(ide_drive_t *drive, int masked_irq)
+{
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
+	ide_startstop_t startstop = -1;
+	struct request *rq;
+	int do_service = 0;
+
+	do {
+		rq = NULL;
+
+		if (!test_bit(IDE_BUSY, &hwgroup->flags))
+			printk("%s: hwgroup not busy while queueing\n", drive->name);
+
+		/*
+		 * abort early if we can't queue another command. for non
+		 * tcq, ide_can_queue is always 1 since we never get here
+		 * unless the drive is idle.
+		 */
+		if (!ide_can_queue(drive)) {
+			if (!ide_pending_commands(drive))
+				clear_bit(IDE_BUSY, &hwgroup->flags);
+			break;
+		}
+
+		drive->PADAM_sleep = 0;
+		drive->PADAM_service_start = jiffies;
+
+		if (test_bit(IDE_DMA, &hwgroup->flags)) {
+			printk("ide_do_request: DMA in progress...\n");
+			break;
+		}
+
+		/*
+		 * there's a small window between where the queue could be
+		 * replugged while we are in here when using tcq (in which
+		 * case the queue is probably empty anyways...), so check
+		 * and leave if appropriate. When not using tcq, this is
+		 * still a severe BUG!
+		 */
+		if (blk_queue_plugged(&drive->queue)) {
+			BUG_ON(!drive->using_tcq);
+			break;
+		}
+
+		if (!(rq = elv_next_request(&drive->queue))) {
+			if (!ide_pending_commands(drive))
+				clear_bit(IDE_BUSY, &hwgroup->flags);
+			hwgroup->rq = NULL;
+			break;
+		}
+
+		/*
+		 * if there are queued commands, we can't start a non-fs
+		 * request (really, a non-queuable command) until the
+		 * queue is empty
+		 */
+		if (!(rq->flags & REQ_CMD) && ide_pending_commands(drive))
+			break;
+
+		hwgroup->rq = rq;
+
+service:
+		/*
+		 * Some systems have trouble with IDE IRQs arriving while
+		 * the driver is still setting things up.  So, here we disable
+		 * the IRQ used by this interface while the request is being
+		 * started.  This may look bad at first, but pretty much the
+		 * same thing happens anyway when any interrupt comes in, IDE
+		 * or otherwise -- the kernel masks the IRQ while it is being
+		 * handled.
+		 */
+		if (masked_irq && HWIF(drive)->irq != masked_irq)
+			disable_irq_nosync(HWIF(drive)->irq);
+
+		spin_unlock(&ide_lock);
+		ide__sti();	/* allow other IRQs while we start this request */
+		if (!do_service)
+			startstop = start_request(drive, rq);
+		else
+			startstop = ide_check_service(drive);
+
+		spin_lock_irq(&ide_lock);
+		if (masked_irq && HWIF(drive)->irq != masked_irq)
+			enable_irq(HWIF(drive)->irq);
+
+		/*
+		 * command started, we are busy
+		 */
+		if (startstop == ide_started)
+			break;
+
+		/*
+		 * start_request() can return either ide_stopped (no command
+		 * was started), ide_started (command started, don't queue
+		 * more), or ide_released (command started, try and queue
+		 * more).
+		 */
+#if 0
+		if (startstop == ide_stopped)
+			set_bit(IDE_BUSY, &hwgroup->flags);
+#endif
+
+	} while (1);
+
+	if (startstop == ide_started)
+		return;
+
+	if ((do_service = drive->service_pending))
+		goto service;
+}
+
 /*
  * Issue a new request to a drive from hwgroup
  * Caller must have already done spin_lock_irqsave(&ide_lock, ...)
@@ -1311,115 +1485,34 @@
 {
 	ide_drive_t *drive;
 	struct ata_channel *hwif;
-	ide_startstop_t	startstop;
-	struct request	*rq;
 
 	ide_get_lock(&ide_intr_lock, ide_intr, hwgroup);/* for atari only: POSSIBLY BROKEN HERE(?) */
 
 	__cli();	/* necessary paranoia: ensure IRQs are masked on local CPU */
 
 	while (!test_and_set_bit(IDE_BUSY, &hwgroup->flags)) {
-		drive = choose_drive(hwgroup);
-		if (drive == NULL) {
-			unsigned long sleep = 0;
-			hwgroup->rq = NULL;
-			drive = hwgroup->drive;
-			do {
-				if (drive->PADAM_sleep && (!sleep || time_after(sleep, drive->PADAM_sleep)))
-					sleep = drive->PADAM_sleep;
-			} while ((drive = drive->next) != hwgroup->drive);
-			if (sleep) {
-				/*
-				 * Take a short snooze, and then wake up this hwgroup again.
-				 * This gives other hwgroups on the same a chance to
-				 * play fairly with us, just in case there are big differences
-				 * in relative throughputs.. don't want to hog the cpu too much.
-				 */
-				if (0 < (signed long)(jiffies + WAIT_MIN_SLEEP - sleep))
-					sleep = jiffies + WAIT_MIN_SLEEP;
-#if 1
-				if (timer_pending(&hwgroup->timer))
-					printk("ide_set_handler: timer already active\n");
-#endif
-				set_bit(IDE_SLEEP, &hwgroup->flags);
-				mod_timer(&hwgroup->timer, sleep);
-				/* we purposely leave hwgroup busy while sleeping */
-			} else {
-				/* Ugly, but how can we sleep for the lock otherwise? perhaps from tq_disk? */
-				ide_release_lock(&ide_intr_lock);/* for atari only */
-				clear_bit(IDE_BUSY, &hwgroup->flags);
-			}
-			return;		/* no more work for this hwgroup (for now) */
-		}
+
+		/*
+		 * will clear IDE_BUSY, if appropriate
+		 */
+		if ((drive = ide_choose_drive(hwgroup)) == NULL)
+			break;
+
 		hwif = drive->channel;
-		if (hwgroup->hwif->sharing_irq && hwif != hwgroup->hwif && hwif->io_ports[IDE_CONTROL_OFFSET]) {
+		if (hwgroup->hwif->sharing_irq && hwif != hwgroup->hwif && IDE_CONTROL_REG) {
 			/* set nIEN for previous hwif */
-
 			if (hwif->intrproc)
 				hwif->intrproc(drive);
 			else
-				OUT_BYTE((drive)->ctl|2, hwif->io_ports[IDE_CONTROL_OFFSET]);
+				OUT_BYTE(drive->ctl|2, IDE_CONTROL_REG);
 		}
 		hwgroup->hwif = hwif;
 		hwgroup->drive = drive;
-		drive->PADAM_sleep = 0;
-queue_next:
-		drive->PADAM_service_start = jiffies;
-
-		if (test_bit(IDE_DMA, &hwgroup->flags)) {
-			printk("ide_do_request: DMA in progress...\n");
-			break;
-		}
-
-		/*
-		 * there's a small window between where the queue could be
-		 * replugged while we are in here when using tcq (in which
-		 * case the queue is probably empty anyways...), so check
-		 * and leave if appropriate. When not using tcq, this is
-		 * still a severe BUG!
-		 */
-		if (blk_queue_plugged(&drive->queue)) {
-			BUG_ON(!drive->using_tcq);
-			break;
-		}
 
 		/*
-		 * just continuing an interrupted request maybe
-		 */
-		rq = hwgroup->rq = elv_next_request(&drive->queue);
-
-		if (!rq) {
-			if (!ide_pending_commands(drive))
-				clear_bit(IDE_BUSY, &HWGROUP(drive)->flags);
-			break;
-		}
-
-		/*
-		 * Some systems have trouble with IDE IRQs arriving while
-		 * the driver is still setting things up.  So, here we disable
-		 * the IRQ used by this interface while the request is being started.
-		 * This may look bad at first, but pretty much the same thing
-		 * happens anyway when any interrupt comes in, IDE or otherwise
-		 *  -- the kernel masks the IRQ while it is being handled.
+		 * main queueing loop
 		 */
-		if (masked_irq && hwif->irq != masked_irq)
-			disable_irq_nosync(hwif->irq);
-
-		spin_unlock(&ide_lock);
-		ide__sti();	/* allow other IRQs while we start this request */
-		startstop = start_request(drive, rq);
-
-		spin_lock_irq(&ide_lock);
-		if (masked_irq && hwif->irq != masked_irq)
-			enable_irq(hwif->irq);
-
-		if (startstop == ide_released)
-			goto queue_next;
-		else if (startstop == ide_stopped) {
-			if (test_bit(IDE_DMA, &hwgroup->flags))
-				printk("2nd illegal clear\n");
-			clear_bit(IDE_BUSY, &hwgroup->flags);
-		}
+		ide_queue_commands(drive, masked_irq);
 	}
 }
 
@@ -1673,6 +1766,7 @@
 		goto out_lock;
 
 	if ((handler = hwgroup->handler) == NULL || hwgroup->poll_timeout != 0) {
+		printk("ide: unexpected interrupt\n");
 		/*
 		 * Not expecting an interrupt from this drive.
 		 * That means this could be:
@@ -1751,7 +1845,8 @@
 		} else {
 			printk("%s: ide_intr: huh? expected NULL handler on exit\n", drive->name);
 		}
-	}
+	} else if (startstop == ide_released)
+		ide_queue_commands(drive, hwif->irq);
 
 out_lock:
 	spin_unlock_irqrestore(&ide_lock, flags);
@@ -2221,6 +2316,8 @@
 	channel->udma_four = old_hwif.udma_four;
 #ifdef CONFIG_BLK_DEV_IDEPCI
 	channel->pci_dev = old_hwif.pci_dev;
+#else
+	channel->pci_dev = NULL;
 #endif
 	channel->straight8 = old_hwif.straight8;
 abort:
@@ -2699,25 +2796,6 @@
 	}
 }
 
-void ide_teardown_commandlist(ide_drive_t *drive)
-{
-#ifdef CONFIG_BLK_DEV_IDEPCI
-	struct pci_dev *pdev = drive->channel->pci_dev;
-#else
-	struct pci_dev *pdev = NULL;
-#endif
-	struct list_head *entry;
-
-	list_for_each(entry, &drive->free_req) {
-		struct ata_request *ar = list_ata_entry(entry);
-
-		list_del(&ar->ar_queue);
-		kfree(ar->ar_sg_table);
-		pci_free_consistent(pdev, PRD_SEGMENTS * PRD_BYTES, ar->ar_dmatable_cpu, ar->ar_dmatable);
-		kfree(ar);
-	}
-}
-
 int ide_build_commandlist(ide_drive_t *drive)
 {
 #ifdef CONFIG_BLK_DEV_IDEPCI
@@ -2725,24 +2803,26 @@
 #else
 	struct pci_dev *pdev = NULL;
 #endif
+	struct list_head *p;
+	unsigned long flags;
 	struct ata_request *ar;
-	ide_tag_info_t *tcq;
-	int i, err;
+	int i, cur;
 
-	tcq = kmalloc(sizeof(ide_tag_info_t), GFP_ATOMIC);
-	if (!tcq)
-		return -ENOMEM;
+	spin_lock_irqsave(&ide_lock, flags);
 
-	drive->tcq = tcq;
-	memset(drive->tcq, 0, sizeof(ide_tag_info_t));
+	cur = 0;
+	list_for_each(p, &drive->free_req)
+		cur++;
 
-	INIT_LIST_HEAD(&drive->free_req);
-	drive->using_tcq = 0;
+	/*
+	 * for now, just don't shrink it...
+	 */
+	if (drive->queue_depth <= cur) {
+		spin_unlock_irqrestore(&ide_lock, flags);
+		return 0;
+	}
 
-	err = -ENOMEM;
-	for (i = 0; i < drive->queue_depth; i++) {
-		/* Having kzmalloc would help reduce code size at quite
-		 * many places in kernel. */
+	for (i = cur; i < drive->queue_depth; i++) {
 		ar = kmalloc(sizeof(*ar), GFP_ATOMIC);
 		if (!ar)
 			break;
@@ -2767,25 +2847,33 @@
 		 * pheew, all done, add to list
 		 */
 		list_add_tail(&ar->ar_queue, &drive->free_req);
+		++cur;
 	}
+	drive->queue_depth = cur;
+	spin_unlock_irqrestore(&ide_lock, flags);
+	return 0;
+}
 
-	if (i) {
-		drive->queue_depth = i;
-		if (i >= 1) {
-			drive->tcq->queued = 0;
-			drive->tcq->active_tag = -1;
+int ide_init_commandlist(ide_drive_t *drive)
+{
+	INIT_LIST_HEAD(&drive->free_req);
 
-			return 0;
-		}
+	return ide_build_commandlist(drive);
+}
 
-		kfree(drive->tcq);
-		drive->tcq = NULL;
-		err = 0;
-	}
+void ide_teardown_commandlist(ide_drive_t *drive)
+{
+	struct pci_dev *pdev= drive->channel->pci_dev;
+	struct list_head *entry;
 
-	kfree(drive->tcq);
-	drive->tcq = NULL;
-	return err;
+	list_for_each(entry, &drive->free_req) {
+		struct ata_request *ar = list_ata_entry(entry);
+
+		list_del(&ar->ar_queue);
+		kfree(ar->ar_sg_table);
+		pci_free_consistent(pdev, PRD_SEGMENTS * PRD_BYTES, ar->ar_dmatable_cpu, ar->ar_dmatable);
+		kfree(ar);
+	}
 }
 
 static int ide_check_media_change (kdev_t i_rdev)
@@ -3046,7 +3134,7 @@
 		unit = unit % MAX_DRIVES;
 		hwif = &ide_hwifs[hw];
 		drive = &hwif->drives[unit];
-		if (strncmp(s + 4, "ide-", 4) == 0) {
+		if (!strncmp(s + 4, "ide-", 4)) {
 			strncpy(drive->driver_req, s + 4, 9);
 			goto done;
 		}
@@ -3128,7 +3216,7 @@
 	/*
 	 * Look for bus speed option:  "idebus="
 	 */
-	if (strncmp(s, "idebus", 6)) {
+	if (!strncmp(s, "idebus", 6)) {
 		if (match_parm(&s[6], NULL, vals, 1) != 1)
 			goto bad_option;
 		if (vals[0] >= 20 && vals[0] <= 66) {
diff -urN linux-2.5.8/drivers/ide/pdc4030.c linux/drivers/ide/pdc4030.c
--- linux-2.5.8/drivers/ide/pdc4030.c	Mon Apr 15 08:53:44 2002
+++ linux/drivers/ide/pdc4030.c	Mon Apr 15 13:10:51 2002
@@ -648,6 +648,12 @@
 
 	memset(&taskfile, 0, sizeof(struct hd_drive_task_hdr));
 
+	/* The four drives on the two logical (one physical) interfaces
+	   are distinguished by writing the drive number (0-3) to the
+	   Feature register.
+	   FIXME: Is promise_selectproc now redundant??
+	 */
+	taskfile.feature    = (drive->channel->unit << 1) + drive->select.b.unit;
 	taskfile.sector_count	= rq->nr_sectors;
 	taskfile.sector_number	= block;
 	taskfile.low_cylinder	= (block>>=8);
diff -urN linux-2.5.8/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.8/include/linux/ide.h	Mon Apr 15 08:53:56 2002
+++ linux/include/linux/ide.h	Mon Apr 15 16:07:45 2002
@@ -273,19 +273,22 @@
 	} b;
 } special_t;
 
-#define IDE_MAX_TAG	32		/* spec says 32 max */
+#define IDE_MAX_TAG		(32)		/* spec says 32 max */
+#define IDE_INACTIVE_TAG	(-1)
 
 struct ata_request;
 typedef struct ide_tag_info_s {
 	unsigned long tag_mask;			/* next tag bit mask */
 	struct ata_request *ar[IDE_MAX_TAG];	/* in-progress requests */
 	int active_tag;				/* current active tag */
+
 	int queued;				/* current depth */
 
 	/*
 	 * stats ->
 	 */
 	int max_depth;				/* max depth ever */
+
 	int max_last_depth;			/* max since last check */
 
 	/*
@@ -295,14 +298,19 @@
 	 */
 	int immed_rel;
 	int immed_comp;
+	unsigned long oldest_command;
 } ide_tag_info_t;
 
 #define IDE_GET_AR(drive, tag)	((drive)->tcq->ar[(tag)])
 #define IDE_CUR_TAG(drive)	(IDE_GET_AR((drive), (drive)->tcq->active_tag))
-#define IDE_SET_CUR_TAG(drive, tag)	((drive)->tcq->active_tag = (tag))
+#define IDE_SET_CUR_TAG(drive, tag)	\
+	do {						\
+		((drive)->tcq->active_tag = (tag));	\
+		if ((tag) == IDE_INACTIVE_TAG)		\
+			HWGROUP((drive))->rq = NULL;	\
+	} while (0);
 
-#define IDE_CUR_AR(drive)	\
-	((drive)->using_tcq ? IDE_CUR_TAG((drive)) : HWGROUP((drive))->rq->special)
+#define IDE_CUR_AR(drive)	(HWGROUP((drive))->rq->special)
 
 struct ide_settings_s;
 
@@ -359,6 +367,7 @@
 	unsigned autotune	: 2;	/* 1=autotune, 2=noautotune, 0=default */
 	unsigned remap_0_to_1	: 2;	/* 0=remap if ezdrive, 1=remap, 2=noremap */
 	unsigned ata_flash	: 1;	/* 1=present, 0=default */
+	unsigned service_pending: 1;
 	unsigned	addressing;	/* : 2; 0=28-bit, 1=48-bit, 2=64-bit */
 	byte		scsi;		/* 0=default, 1=skip current ide-subdriver for ide-scsi emulation */
 	select_t	select;		/* basic drive/head select reg value */
@@ -546,7 +555,7 @@
 typedef enum {
 	ide_stopped,	/* no drive operation was started */
 	ide_started,	/* a drive operation was started, and a handler was set */
-	ide_released	/* started and released bus */
+	ide_released,	/* started, handler set, bus released */
 } ide_startstop_t;
 
 /*
@@ -980,6 +989,11 @@
 #define ATA_AR_SETUP	2
 #define ATA_AR_RETURN	4
 
+/*
+ * if turn-around time is longer than this, halve queue depth
+ */
+#define ATA_AR_MAX_TURNAROUND	(3 * HZ)
+
 #define list_ata_entry(entry) list_entry((entry), struct ata_request, ar_queue)
 
 static inline void ata_ar_init(ide_drive_t *drive, struct ata_request *ar)
@@ -1026,7 +1040,7 @@
 	ar->ar_rq = NULL;
 }
 
-extern inline int ide_get_tag(ide_drive_t *drive)
+static inline int ide_get_tag(ide_drive_t *drive)
 {
 	int tag = ffz(drive->tcq->tag_mask);
 
@@ -1043,12 +1057,28 @@
 }
 
 #ifdef CONFIG_BLK_DEV_IDE_TCQ
-# define ide_pending_commands(drive)	((drive)->using_tcq && (drive)->tcq->queued)
+static inline int ide_pending_commands(ide_drive_t *drive)
+{
+	if (!drive->tcq)
+		return 0;
+
+	return drive->tcq->queued;
+}
+
+static inline int ide_can_queue(ide_drive_t *drive)
+{
+	if (!drive->tcq)
+		return 1;
+
+	return drive->tcq->queued < drive->queue_depth;
+}
 #else
-# define ide_pending_commands(drive)	0
+#define ide_pending_commands(drive)	(0)
+#define ide_can_queue(drive)		(1)
 #endif
 
 int ide_build_commandlist(ide_drive_t *);
+int ide_init_commandlist(ide_drive_t *);
 void ide_teardown_commandlist(ide_drive_t *);
 int ide_tcq_dmaproc(ide_dma_action_t, ide_drive_t *);
 ide_startstop_t ide_start_tag(ide_dma_action_t, ide_drive_t *, struct ata_request *);

--------------060405060804010009080108--

