Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313330AbSDQMZV>; Wed, 17 Apr 2002 08:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313784AbSDQMZU>; Wed, 17 Apr 2002 08:25:20 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:45069 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313330AbSDQMZL>;
	Wed, 17 Apr 2002 08:25:11 -0400
Date: Wed, 17 Apr 2002 14:25:02 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.8 IDE oops (TCQ breakage?)
Message-ID: <20020417122502.GB800@suse.de>
In-Reply-To: <200204161749.TAA16333@harpo.it.uu.se> <3CBD45BD.4040209@evision-ventures.com> <20020417120817.GA800@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 17 2002, Jens Axboe wrote:
> On Wed, Apr 17 2002, Martin Dalecki wrote:
> > Mikael Pettersson wrote:
> > >I have a 486 box which ran 2.5.7 fine, but 2.5.8 oopses during
> > >boot at the BUG_ON() in drivers/ide/ide-disk.c, line 360:
> > >
> > >	if (drive->using_tcq) {
> > >		int tag = ide_get_tag(drive);
> > >
> > >		BUG_ON(drive->tcq->active_tag != -1);
> > 
> > OK it could be that the tca goesn't get allocated if there
> > was no chipset selected. Lets have a look...
> 
> Add a drive->using_dma check to ide_dma_queued_on in ide-tcq.c, it needs
> to look like this:
> 
> ide_tcq_dmaproc()
> {
> 
> 	...
> 
> 		case ide_dma_queued_off:
> 			enable_tcq = 0;
> 		case ide_dma_queued_on:
> 			if (!drive->using_dma)
> 				return 1;
> 			return ide_enable_queued(drive, enable_tcq);
> 		default:
> 			break;
> 	}
> 
> that should fix it.

Should only be done if 'enable_tcq == 1' of course, and we also need to
switch off tcq when dma is being disabled. 4th patch set against 2.5.8.
Note to Martin: I'll merge with IDE-XX later today.

-- 
Jens Axboe


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ata-tcq-258-4

diff -urzN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- /opt/kernel/linux-2.5.8/drivers/block/ll_rw_blk.c	2002-04-17 12:15:35.000000000 +0200
+++ linux/drivers/block/ll_rw_blk.c	2002-04-17 11:43:00.000000000 +0200
@@ -899,10 +899,10 @@
 	spin_lock_prefetch(q->queue_lock);
 
 	generic_unplug_device(q);
-	add_wait_queue(&rl->wait, &wait);
+	add_wait_queue_exclusive(&rl->wait, &wait);
 	do {
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (rl->count < batch_requests)
+		if (!rl->count)
 			schedule();
 		spin_lock_irq(q->queue_lock);
 		rq = get_request(q, rw);
@@ -1720,9 +1720,11 @@
 	 * Free request slots per queue.
 	 * (Half for reads, half for writes)
 	 */
-	queue_nr_requests = 64;
-	if (total_ram > MB(32))
-		queue_nr_requests = 256;
+	queue_nr_requests = (total_ram >> 8) & ~15;	/* One per quarter-megabyte */
+	if (queue_nr_requests < 32)
+		queue_nr_requests = 32;
+	if (queue_nr_requests > 512)
+		queue_nr_requests = 512;
 
 	/*
 	 * Batch frees according to queue length
diff -urzN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8/drivers/ide/Config.help linux/drivers/ide/Config.help
--- /opt/kernel/linux-2.5.8/drivers/ide/Config.help	2002-04-17 12:15:35.000000000 +0200
+++ linux/drivers/ide/Config.help	2002-04-17 11:43:00.000000000 +0200
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
diff -urzN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8/drivers/ide/Config.in linux/drivers/ide/Config.in
--- /opt/kernel/linux-2.5.8/drivers/ide/Config.in	2002-04-17 12:15:35.000000000 +0200
+++ linux/drivers/ide/Config.in	2002-04-17 11:43:00.000000000 +0200
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
diff -urzN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- /opt/kernel/linux-2.5.8/drivers/ide/ide-disk.c	2002-04-17 12:15:34.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2002-04-17 13:59:00.000000000 +0200
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
 
diff -urzN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- /opt/kernel/linux-2.5.8/drivers/ide/ide-dma.c	2002-04-17 12:15:34.000000000 +0200
+++ linux/drivers/ide/ide-dma.c	2002-04-17 14:19:44.000000000 +0200
@@ -601,6 +601,9 @@
 			set_high = 0;
 			drive->using_tcq = 0;
 			outb(inb(dma_base+2) & ~(1<<(5+unit)), dma_base+2);
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+			ide_tcq_dmaproc(ide_dma_queued_off, drive);
+#endif
 		case ide_dma_on:
 			ide_toggle_bounce(drive, set_high);
 			drive->using_dma = (func == ide_dma_on);
@@ -610,9 +613,6 @@
 		case ide_dma_check:
 			return config_drive_for_dma (drive);
 		case ide_dma_begin:
-#ifdef DEBUG
-			printk("ide_dma_begin: from %p\n", __builtin_return_address(0));
-#endif
 			if (test_and_set_bit(IDE_DMA, &HWGROUP(drive)->flags))
 				BUG();
 			/* Note that this is done *after* the cmd has
@@ -629,19 +629,18 @@
 		case ide_dma_write_queued:
 		case ide_dma_queued_start:
 			return ide_tcq_dmaproc(func, drive);
-#endif
+#endif /* CONFIG_BLK_DEV_IDE_TCQ */
 
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
@@ -655,20 +654,13 @@
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
diff -urzN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- /opt/kernel/linux-2.5.8/drivers/ide/ide-probe.c	2002-04-17 12:15:34.000000000 +0200
+++ linux/drivers/ide/ide-probe.c	2002-04-17 11:43:00.000000000 +0200
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
@@ -482,11 +479,9 @@
 	sprintf(hwif->dev.bus_id, "%04x", hwif->io_ports[IDE_DATA_OFFSET]);
 	sprintf(hwif->dev.name, "ide");
 	hwif->dev.driver_data = hwif;
-#ifdef CONFIG_BLK_DEV_IDEPCI
 	if (hwif->pci_dev)
 		hwif->dev.parent = &hwif->pci_dev->dev;
 	else
-#endif
 		hwif->dev.parent = NULL; /* Would like to do = &device_legacy */
 	device_register(&hwif->dev);
 
diff -urzN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8/drivers/ide/ide-proc.c linux/drivers/ide/ide-proc.c
--- /opt/kernel/linux-2.5.8/drivers/ide/ide-proc.c	2002-04-17 12:15:34.000000000 +0200
+++ linux/drivers/ide/ide-proc.c	2002-04-17 11:43:00.000000000 +0200
@@ -422,7 +422,6 @@
 static void create_proc_ide_drives(struct ata_channel *hwif)
 {
 	int	d;
-	struct proc_dir_entry *ent;
 	struct proc_dir_entry *parent = hwif->proc;
 	char name[64];
 
diff -urzN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- /opt/kernel/linux-2.5.8/drivers/ide/ide-taskfile.c	2002-04-17 12:15:34.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-04-17 13:39:05.000000000 +0200
@@ -399,6 +399,20 @@
 	struct hd_driveid *id = drive->id;
 	u8 HIHI = (drive->addressing) ? 0xE0 : 0xEF;
 
+#if 0
+	printk("ata_taskfile ... %p\n", args->handler);
+
+	printk("   sector feature          %02x\n", args->taskfile.feature);
+	printk("   sector count            %02x\n", args->taskfile.sector_count);
+	printk("   drive/head              %02x\n", args->taskfile.device_head);
+	printk("   command                 %02x\n", args->taskfile.command);
+
+	if (rq)
+		printk("   rq->nr_sectors          %2li\n",  rq->nr_sectors);
+	else
+		printk("   rq->                   = null\n");
+#endif
+ 
 	/* (ks/hs): Moved to start, do not use for multiple out commands */
 	if (args->handler != task_mulout_intr) {
 		if (IDE_CONTROL_REG)
@@ -566,18 +580,22 @@
 	ide_unmap_rq(rq, pBuf, &flags);
 	drive->io_32bit = io_32bit;
 
+	/*
+	 * first segment of the request is complete. note that this does not
+	 * necessarily mean that the entire request is done!! this is only
+	 * true if ide_end_request() returns 0.
+	 */
 	if (--rq->current_nr_sectors <= 0) {
-		/* (hs): swapped next 2 lines */
 		DTF("Request Ended stat: %02x\n", GET_STAT());
-		if (ide_end_request(drive, 1)) {
-			ide_set_handler(drive, &task_in_intr,  WAIT_CMD, NULL);
-			return ide_started;
-		}
-	} else {
-		ide_set_handler(drive, &task_in_intr,  WAIT_CMD, NULL);
-		return ide_started;
+		if (!ide_end_request(drive, 1))
+			return ide_stopped;
 	}
-	return ide_stopped;
+
+	/*
+	 * still data left to transfer
+	 */
+	ide_set_handler(drive, &task_in_intr,  WAIT_CMD, NULL);
+	return ide_started;
 }
 
 static ide_startstop_t pre_task_out_intr(ide_drive_t *drive, struct request *rq)
@@ -870,7 +888,6 @@
 			return;
 
 		case WIN_NOP:
-
 			args->command_type = IDE_DRIVE_TASK_NO_DATA;
 			return;
 
diff -urzN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8/drivers/ide/ide-tcq.c linux/drivers/ide/ide-tcq.c
--- /opt/kernel/linux-2.5.8/drivers/ide/ide-tcq.c	2002-04-17 12:15:35.000000000 +0200
+++ linux/drivers/ide/ide-tcq.c	2002-04-17 14:19:43.000000000 +0200
@@ -29,9 +29,12 @@
 #include <asm/delay.h>
 
 /*
- * warning: it will be _very_ verbose if set to 1
+ * warning: it will be _very_ verbose if defined
  */
-#if 0
+#undef IDE_TCQ_DEBUG
+
+#ifdef IDE_TCQ_DEBUG
+#warning "Building debug enabled TCQ"
 #define TCQ_PRINTK printk
 #else
 #define TCQ_PRINTK(x...)
@@ -49,16 +52,17 @@
  */
 #undef IDE_TCQ_FIDDLE_SI
 
-int ide_tcq_end(ide_drive_t *drive);
 ide_startstop_t ide_dmaq_intr(ide_drive_t *drive);
+ide_startstop_t ide_service(ide_drive_t *drive);
 
 static inline void drive_ctl_nien(ide_drive_t *drive, int clear)
 {
 #ifdef IDE_TCQ_NIEN
-	int mask = clear ? 0 : 2;
+	if (IDE_CONTROL_REG) {
+		int mask = clear ? 0 : 1 << 1;
 
-	if (IDE_CONTROL_REG)
 		OUT_BYTE(drive->ctl | mask, IDE_CONTROL_REG);
+	}
 #endif
 }
 
@@ -116,7 +120,6 @@
 	init_taskfile_request(ar->ar_rq);
 	ar->ar_rq->rq_dev = mk_kdev(drive->channel->major, (drive->select.b.unit)<<PARTN_BITS);
 	ar->ar_rq->special = ar;
-	ar->ar_flags |= ATA_AR_RETURN;
 	_elv_add_request(q, ar->ar_rq, 0, 0);
 
 	/*
@@ -142,7 +145,7 @@
 
 	spin_lock_irqsave(&ide_lock, flags);
 
-	if (test_bit(IDE_BUSY, &hwgroup->flags))
+	if (test_and_set_bit(IDE_BUSY, &hwgroup->flags))
 		printk("ide_tcq_intr_timeout: hwgroup not busy\n");
 	if (hwgroup->handler == NULL)
 		printk("ide_tcq_intr_timeout: missing isr!\n");
@@ -151,6 +154,13 @@
 
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
@@ -192,6 +202,7 @@
 
 		if (unlikely(i++ > IDE_TCQ_WAIT))
 			return 1;
+
 	} while ((*stat = GET_ALTSTAT()) & busy_mask);
 
 	return 0;
@@ -206,7 +217,12 @@
 ide_startstop_t ide_service(ide_drive_t *drive)
 {
 	struct ata_request *ar;
-	byte feat, tag, stat;
+	byte feat, stat;
+	int tag, ret;
+
+	TCQ_PRINTK("%s: started service\n", drive->name);
+
+	drive->service_pending = 0;
 
 	if (test_bit(IDE_DMA, &HWGROUP(drive)->flags))
 		printk("ide_service: DMA in progress\n");
@@ -238,9 +254,9 @@
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
@@ -248,13 +264,10 @@
 	 */
 	if ((feat = GET_FEAT()) & NSEC_REL) {
 		printk("%s: release in service\n", drive->name);
-		IDE_SET_CUR_TAG(drive, -1);
+		IDE_SET_CUR_TAG(drive, IDE_INACTIVE_TAG);
 		return ide_stopped;
 	}
 
-	/*
-	 * start dma
-	 */
 	tag = feat >> 3;
 	IDE_SET_CUR_TAG(drive, tag);
 
@@ -265,28 +278,32 @@
 		return ide_stopped;
 	}
 
+	HWGROUP(drive)->rq = ar->ar_rq;
+
 	/*
 	 * we'll start a dma read or write, device will trigger
 	 * interrupt to indicate end of transfer, release is not allowed
 	 */
 	if (rq_data_dir(ar->ar_rq) == READ) {
 		TCQ_PRINTK("ide_service: starting READ %x\n", stat);
-		drive->channel->dmaproc(ide_dma_read_queued, drive);
+		ret = drive->channel->dmaproc(ide_dma_read_queued, drive);
 	} else {
 		TCQ_PRINTK("ide_service: starting WRITE %x\n", stat);
-		drive->channel->dmaproc(ide_dma_write_queued, drive);
+		ret = drive->channel->dmaproc(ide_dma_write_queued, drive);
 	}
 
 	/*
 	 * dmaproc set intr handler
 	 */
-	return ide_started;
+	return !ret ? ide_started : ide_stopped;
 }
 
 ide_startstop_t ide_check_service(ide_drive_t *drive)
 {
 	byte stat;
 
+	TCQ_PRINTK("%s: ide_check_service\n", drive->name);
+
 	if (!ide_pending_commands(drive))
 		return ide_stopped;
 
@@ -300,40 +317,14 @@
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
@@ -352,7 +343,23 @@
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
 
@@ -376,7 +383,7 @@
 	 * if a command completion interrupt is pending, do that first and
 	 * check service afterwards
 	 */
-	if (drive->tcq->active_tag != -1)
+	if (drive->tcq->active_tag != IDE_INACTIVE_TAG)
 		return ide_dmaq_complete(drive, stat);
 
 	/*
@@ -396,17 +403,16 @@
  */
 static int ide_tcq_configure(ide_drive_t *drive)
 {
+	int tcq_mask = 1 << 1 | 1 << 14;
+	int tcq_bits = tcq_mask | 1 << 15;
 	struct ata_taskfile args;
-	int tcq_supp = 1 << 1 | 1 << 14;
 
 	/*
 	 * bit 14 and 1 must be set in word 83 of the device id to indicate
-	 * support for dma queued protocol
+	 * support for dma queued protocol, and bit 15 must be cleared
 	 */
-	if ((drive->id->command_set_2 & tcq_supp) != tcq_supp) {
-		printk("%s: queued feature set not supported\n", drive->name);
-		return 1;
-	}
+	if ((drive->id->command_set_2 & tcq_bits) ^ tcq_mask)
+		return -EIO;
 
 	memset(&args, 0, sizeof(args));
 	args.taskfile.feature = SETFEATURES_EN_WCACHE;
@@ -446,6 +452,16 @@
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
 
@@ -461,26 +477,39 @@
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
+	/*
+	 * possibly expand command list
+	 */
+	if (ide_build_commandlist(drive))
+		return 1;
 
 	printk("%s: tagged command queueing enabled, command queue depth %d\n", drive->name, drive->queue_depth);
 	drive->using_tcq = 1;
 
+	/*
+	 * clear stats
+	 */
+	drive->tcq->max_depth = 0;
+	return 0;
+}
+
+int ide_tcq_wait_dataphase(ide_drive_t *drive)
+{
+	ide_startstop_t foo;
+
+	if (ide_wait_stat(&foo, drive, READY_STAT | DRQ_STAT, BUSY_STAT, WAIT_READY)) {
+		printk("%s: timeout waiting for data phase\n", drive->name);
+		return 1;
+	}
+
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
@@ -558,26 +589,33 @@
 
 			drive->tcq->immed_comp++;
 
-			if (ide_wait_stat(&startstop, drive, READY_STAT | DRQ_STAT, BUSY_STAT, WAIT_READY)) {
-				printk("%s: timeout waiting for data phase\n", drive->name);
-				return startstop;
-			}
+			if (ide_tcq_wait_dataphase(drive))
+				return ide_stopped;
 
 			if (ide_start_dma(hwif, drive, func))
 				return ide_stopped;
 
+			TCQ_PRINTK("IMMED in queued_start\n");
+
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
 			enable_tcq = 0;
 		case ide_dma_queued_on:
+			if (enable_tcq && !drive->using_dma)
+				return 1;
 			return ide_enable_queued(drive, enable_tcq);
 		default:
 			break;
@@ -590,6 +628,10 @@
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
@@ -597,5 +639,14 @@
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
diff -urzN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8/drivers/ide/ide.c linux/drivers/ide/ide.c
--- /opt/kernel/linux-2.5.8/drivers/ide/ide.c	2002-04-17 12:15:34.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-04-17 11:43:00.000000000 +0200
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
@@ -794,8 +808,7 @@
 				args->hobfile.high_cylinder = IN_BYTE(IDE_HCYL_REG);
 			}
 		}
-		if (ar->ar_flags & ATA_AR_RETURN)
-			ata_ar_put(drive, ar);
+		ata_ar_put(drive, ar);
 	}
 
 	blkdev_dequeue_request(rq);
@@ -1101,11 +1114,7 @@
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
@@ -1277,6 +1286,170 @@
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
@@ -1311,115 +1484,34 @@
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
 
 		/*
-		 * there's a small window between where the queue could be
-		 * replugged while we are in here when using tcq (in which
-		 * case the queue is probably empty anyways...), so check
-		 * and leave if appropriate. When not using tcq, this is
-		 * still a severe BUG!
+		 * main queueing loop
 		 */
-		if (blk_queue_plugged(&drive->queue)) {
-			BUG_ON(!drive->using_tcq);
-			break;
-		}
-
-		/*
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
-		 */
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
 
@@ -1673,6 +1765,7 @@
 		goto out_lock;
 
 	if ((handler = hwgroup->handler) == NULL || hwgroup->poll_timeout != 0) {
+		printk("ide: unexpected interrupt\n");
 		/*
 		 * Not expecting an interrupt from this drive.
 		 * That means this could be:
@@ -1685,9 +1778,7 @@
 		 * For PCI, we cannot tell the difference,
 		 * so in that case we just ignore it and hope it goes away.
 		 */
-#ifdef CONFIG_BLK_DEV_IDEPCI
 		if (hwif->pci_dev && !hwif->pci_dev->vendor)
-#endif
 		{
 			/*
 			 * Probably not a shared PCI interrupt,
@@ -1751,7 +1842,8 @@
 		} else {
 			printk("%s: ide_intr: huh? expected NULL handler on exit\n", drive->name);
 		}
-	}
+	} else if (startstop == ide_released)
+		ide_queue_commands(drive, hwif->irq);
 
 out_lock:
 	spin_unlock_irqrestore(&ide_lock, flags);
@@ -2221,6 +2313,8 @@
 	channel->udma_four = old_hwif.udma_four;
 #ifdef CONFIG_BLK_DEV_IDEPCI
 	channel->pci_dev = old_hwif.pci_dev;
+#else
+	channel->pci_dev = NULL;
 #endif
 	channel->straight8 = old_hwif.straight8;
 abort:
@@ -2699,42 +2793,29 @@
 	}
 }
 
-void ide_teardown_commandlist(ide_drive_t *drive)
-{
-	struct pci_dev *pdev= drive->channel->pci_dev;
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
 	struct pci_dev *pdev= drive->channel->pci_dev;
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
@@ -2755,29 +2836,40 @@
 			break;
 		}
 
+		
+
 		/*
 		 * pheew, all done, add to list
 		 */
 		list_add_tail(&ar->ar_queue, &drive->free_req);
+		cur++;
 	}
 
-	if (i) {
-		drive->queue_depth = i;
-		if (i >= 1) {
-			drive->using_tcq = 1;
-			drive->tcq->queued = 0;
-			drive->tcq->active_tag = -1;
-			return 0;
-		}
+	drive->queue_depth = cur;
+	spin_unlock_irqrestore(&ide_lock, flags);
+	return 0;
+}
 
-		kfree(drive->tcq);
-		drive->tcq = NULL;
-		err = 0;
-	}
+int ide_init_commandlist(ide_drive_t *drive)
+{
+	INIT_LIST_HEAD(&drive->free_req);
 
-	kfree(drive->tcq);
-	drive->tcq = NULL;
-	return err;
+	return ide_build_commandlist(drive);
+}
+
+void ide_teardown_commandlist(ide_drive_t *drive)
+{
+	struct pci_dev *pdev= drive->channel->pci_dev;
+	struct list_head *entry;
+
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
diff -urzN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8/include/linux/ide.h linux/include/linux/ide.h
--- /opt/kernel/linux-2.5.8/include/linux/ide.h	2002-04-17 12:16:08.000000000 +0200
+++ linux/include/linux/ide.h	2002-04-17 11:47:36.000000000 +0200
@@ -273,36 +273,44 @@
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
-	 * Either the command completed immediately after being started
+	 * either the command complete immediately after being started
 	 * (immed_comp), or the device did a bus release before dma was
-	 * started (immed_rel).
+	 * started (immed_rel)
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
@@ -493,9 +502,7 @@
 
 	ide_ioreg_t	io_ports[IDE_NR_PORTS];	/* task file registers */
 	hw_regs_t	hw;		/* Hardware info */
-#ifdef CONFIG_BLK_DEV_IDEPCI
 	struct pci_dev	*pci_dev;	/* for pci chipsets */
-#endif
 	ide_drive_t	drives[MAX_DRIVES];	/* drive info */
 	struct gendisk	*gd;		/* gendisk structure */
 	ide_tuneproc_t	*tuneproc;	/* routine to tune PIO mode for drives */
@@ -546,7 +553,7 @@
 typedef enum {
 	ide_stopped,	/* no drive operation was started */
 	ide_started,	/* a drive operation was started, and a handler was set */
-	ide_released	/* started and released bus */
+	ide_released,	/* started, handler set, bus released */
 } ide_startstop_t;
 
 /*
@@ -976,9 +983,14 @@
 /*
  * ata_request flag bits
  */
-#define ATA_AR_QUEUED	1
-#define ATA_AR_SETUP	2
-#define ATA_AR_RETURN	4
+#define ATA_AR_QUEUED	1	/* was queued */
+#define ATA_AR_SETUP	2	/* dma table mapped */
+#define ATA_AR_POOL	4	/* originated from drive pool */
+
+/*
+ * if turn-around time is longer than this, halve queue depth
+ */
+#define ATA_AR_MAX_TURNAROUND	(3 * HZ)
 
 #define list_ata_entry(entry) list_entry((entry), struct ata_request, ar_queue)
 
@@ -1005,8 +1017,10 @@
 
 	if (!list_empty(&drive->free_req)) {
 		ar = list_ata_entry(drive->free_req.next);
+
 		list_del(&ar->ar_queue);
 		ata_ar_init(drive, ar);
+		ar->ar_flags |= ATA_AR_POOL;
 	}
 
 	return ar;
@@ -1014,10 +1028,13 @@
 
 static inline void ata_ar_put(ide_drive_t *drive, struct ata_request *ar)
 {
-	list_add(&ar->ar_queue, &drive->free_req);
+	if (ar->ar_flags & ATA_AR_POOL)
+		list_add(&ar->ar_queue, &drive->free_req);
 
 	if (ar->ar_flags & ATA_AR_QUEUED) {
-		/* clear the tag */
+		/*
+		 * clear tag
+		 */
 		drive->tcq->ar[ar->ar_tag] = NULL;
 		__clear_bit(ar->ar_tag, &drive->tcq->tag_mask);
 		drive->tcq->queued--;
@@ -1026,7 +1043,7 @@
 	ar->ar_rq = NULL;
 }
 
-extern inline int ide_get_tag(ide_drive_t *drive)
+static inline int ide_get_tag(ide_drive_t *drive)
 {
 	int tag = ffz(drive->tcq->tag_mask);
 
@@ -1043,14 +1060,30 @@
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
 
-#endif
+#endif /* _IDE_H */


--Dxnq1zWXvFF0Q93v--
