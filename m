Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266983AbTAZUt5>; Sun, 26 Jan 2003 15:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266981AbTAZUt5>; Sun, 26 Jan 2003 15:49:57 -0500
Received: from pcp02781107pcs.eatntn01.nj.comcast.net ([68.85.61.149]:60412
	"EHLO linnie.riede.org") by vger.kernel.org with ESMTP
	id <S266977AbTAZUtl>; Sun, 26 Jan 2003 15:49:41 -0500
Date: Sun, 26 Jan 2003 15:58:31 -0500
From: Willem Riede <wrlk@riede.org>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Update to ide-scsi error handling
Message-ID: <20030126205831.GM24610@linnie.riede.org>
Reply-To: wrlk@riede.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

One of my ATAPI drives developed a real dislike to 2.5.55 and above, which gave
me plenty of opportunity to improve ide-scsi's error handling :-) .

To handle ide device resets and be able to wait for them in the scsi context, I 
have changed ide_do_reset and friends in drivers/ide/ide-iops.c to set the busy 
flag on the hwgroup while the reset is in progress.

I noticed, that ide-scsi didn't consistently use the printk priorities, so I
touched that up while I was at it.

The resulting changes (also attached as two separate files - I expect different
owners will have to apply them - ide-iops is a prerequisite for the ide-scsi 
patch to work):

--- drivers/ide/ide-iops.c.l2559	2003-01-16 21:22:00.000000000 -0500
+++ drivers/ide/ide-iops.c	2003-01-25 08:50:29.000000000 -0500
@@ -986,6 +986,7 @@
 	}
 	/* done polling */
 	hwgroup->poll_timeout = 0;
+	hwgroup->busy--;
 	return ide_stopped;
 }
 
@@ -1005,6 +1006,7 @@
 		if (hwif->reset_poll(drive)) {
 			printk(KERN_ERR "%s: host reset_poll failure for %s.\n",
 				hwif->name, drive->name);
+			hwgroup->busy--;
 			return ide_stopped;
 		}
 	}
@@ -1050,6 +1052,7 @@
 		}
 	}
 	hwgroup->poll_timeout = 0;	/* done polling */
+	hwgroup->busy--;
 	return ide_stopped;
 }
 
@@ -1135,6 +1138,7 @@
 #if OK_TO_RESET_CONTROLLER
 	if (!IDE_CONTROL_REG) {
 		local_irq_restore(flags);
+		hwgroup->busy--;
 		return ide_stopped;
 	}
 
@@ -1217,6 +1221,7 @@
 	u8 unmask	= drive->unmask;
 # endif
 
+	HWGROUP(drive)->busy++;
 	if (HWGROUP(drive)->handler != NULL) {
 		unsigned long flags;
 		spin_lock_irqsave(&ide_lock, flags);
--- drivers/scsi/ide-scsi.c.l2559	2003-01-16 21:22:22.000000000 -0500
+++ drivers/scsi/ide-scsi.c	2003-01-26 10:55:08.000000000 -0500
@@ -29,9 +29,10 @@
  * Ver 0.9   Jul 04 99   Fix a bug in SG_SET_TRANSFORM.
  * Ver 0.91  Jun 10 02   Fix "off by one" error in transforms
  * Ver 0.92  Dec 31 02   Implement new SCSI mid level API
+ * Ver 0.93  Jan 26 03   Improved error handler.
  */
 
-#define IDESCSI_VERSION "0.92"
+#define IDESCSI_VERSION "0.93"
 
 #include <linux/module.h>
 #include <linux/config.h>
@@ -54,7 +55,9 @@
 #include "hosts.h"
 #include <scsi/sg.h>
 
-#define IDESCSI_DEBUG_LOG		0
+#define IDESCSI_DEBUG_LOG	0
+#define IDESCSI_DEBUG		KERN_NOTICE
+#define IDESCSI_LOG		KERN_INFO
 
 typedef struct idescsi_pc_s {
 	u8 c[12];				/* Actual packet bytes */
@@ -260,7 +263,7 @@
 	printk("]\n");
 }
 
-static int idescsi_check_condition(ide_drive_t *drive, struct request *failed_command)
+static int idescsi_check_condition(ide_drive_t *drive, idescsi_pc_t *failed_command)
 {
 	idescsi_scsi_t *scsi = drive->driver_data;
 	idescsi_pc_t   *pc;
@@ -288,10 +291,10 @@
 	rq->flags = REQ_SENSE;
 	pc->timeout = jiffies + WAIT_READY;
 	/* NOTE! Save the failed packet command in "rq->buffer" */
-	rq->buffer = (void *) failed_command->special;
-	pc->scsi_cmd = ((idescsi_pc_t *) failed_command->special)->scsi_cmd;
+	rq->buffer = (void *) failed_command;
+	pc->scsi_cmd = failed_command->scsi_cmd;
 	if (test_bit(IDESCSI_LOG_CMD, &scsi->log)) {
-		printk ("ide-scsi: %s: queue cmd = ", drive->name);
+		printk (IDESCSI_LOG "ide-scsi: %s: queue cmd = ", drive->name);
 		hexdump(pc->c, 6);
 	}
 	return ide_do_drive_cmd(drive, rq, ide_preempt);
@@ -302,7 +305,11 @@
 	idescsi_scsi_t *scsi = drive->driver_data;
 	struct request *rq = HWGROUP(drive)->rq;
 	idescsi_pc_t *pc = (idescsi_pc_t *) rq->special;
+#if IDESCSI_DEBUG_LOG
+	int log = 1;
+#else
 	int log = test_bit(IDESCSI_LOG_CMD, &scsi->log);
+#endif
 	struct Scsi_Host *host;
 	u8 *scsi_buf;
 	unsigned long flags;
@@ -315,7 +322,8 @@
 	if (rq->flags & REQ_SENSE) {
 		idescsi_pc_t *opc = (idescsi_pc_t *) rq->buffer;
 		if (log) {
-			printk ("ide-scsi: %s: wrap up check %lu, rst = ", drive->name, opc->scsi_cmd->serial_number);
+			printk (IDESCSI_LOG "ide-scsi: %s: wrap up check %lu, rst = ",
+				       	drive->name, opc->scsi_cmd->serial_number);
 			hexdump(pc->buffer,16);
 		}
 		memcpy((void *) opc->scsi_cmd->sense_buffer, pc->buffer, SCSI_SENSE_BUFFERSIZE);
@@ -328,11 +336,13 @@
 	} else if (rq->errors >= ERROR_MAX) {
 		pc->scsi_cmd->result = DID_ERROR << 16;
 		if (log)
-			printk ("ide-scsi: %s: I/O error for %lu\n", drive->name, pc->scsi_cmd->serial_number);
+			printk (IDESCSI_LOG "ide-scsi: %s: I/O error for %lu\n",
+				       	drive->name, pc->scsi_cmd->serial_number);
 	} else if (rq->errors) {
 		if (log)
-			printk ("ide-scsi: %s: check condition for %lu\n", drive->name, pc->scsi_cmd->serial_number);
-		if (!idescsi_check_condition(drive, rq))
+			printk (IDESCSI_LOG "ide-scsi: %s: check condition for %lu\n",
+				       	drive->name, pc->scsi_cmd->serial_number);
+		if (!idescsi_check_condition(drive, pc))
 			/* we started a request sense, so we'll be back, exit for now */
 			return 0;
 		pc->scsi_cmd->result = (CHECK_CONDITION << 1) | (DID_OK << 16);
@@ -340,7 +350,7 @@
 		pc->scsi_cmd->result = DID_OK << 16;
 		idescsi_transform_pc2 (drive, pc);
 		if (log) {
-			printk ("ide-scsi: %s: suc %lu", drive->name, pc->scsi_cmd->serial_number);
+			printk (IDESCSI_LOG "ide-scsi: %s: suc %lu", drive->name, pc->scsi_cmd->serial_number);
 			if (!test_bit(PC_WRITING, &pc->flags) && pc->actually_transferred && pc->actually_transferred <= 1024 && pc->buffer) {
 				printk(", rst = ");
 				scsi_buf = pc->scsi_cmd->request_buffer;
@@ -380,12 +390,12 @@
 	unsigned int temp;
 
 #if IDESCSI_DEBUG_LOG
-	printk (KERN_INFO "ide-scsi: Reached idescsi_pc_intr interrupt handler\n");
+	printk (IDESCSI_DEBUG "ide-scsi: Reached idescsi_pc_intr interrupt handler\n");
 #endif /* IDESCSI_DEBUG_LOG */
 
 	if (test_and_clear_bit (PC_DMA_IN_PROGRESS, &pc->flags)) {
 #if IDESCSI_DEBUG_LOG
-		printk ("ide-scsi: %s: DMA complete\n", drive->name);
+		printk (IDESCSI_DEBUG "ide-scsi: %s: DMA complete\n", drive->name);
 #endif /* IDESCSI_DEBUG_LOG */
 		pc->actually_transferred=pc->request_transfer;
 		(void) HWIF(drive)->ide_dma_end(drive);
@@ -398,7 +408,7 @@
 	if (!status.b.drq) {
 		/* No more interrupts */
 		if (test_bit(IDESCSI_LOG_CMD, &scsi->log))
-			printk (KERN_INFO "Packet command completed, %d bytes transferred\n", pc->actually_transferred);
+			printk (IDESCSI_LOG "Packet command completed, %d bytes transferred\n", pc->actually_transferred);
 		local_irq_enable();
 		if (status.b.check)
 			rq->errors++;
@@ -436,7 +446,7 @@
 				return ide_started;
 			}
 #if IDESCSI_DEBUG_LOG
-			printk (KERN_NOTICE "ide-scsi: The scsi wants to send us more data than expected - allowing transfer\n");
+			printk (IDESCSI_DEBUG "ide-scsi: The scsi wants to send us more data than expected - allowing transfer\n");
 #endif /* IDESCSI_DEBUG_LOG */
 		}
 	}
@@ -543,8 +553,10 @@
 static ide_startstop_t idescsi_do_request (ide_drive_t *drive, struct request *rq, sector_t block)
 {
 #if IDESCSI_DEBUG_LOG
-	printk (KERN_INFO "rq_status: %d, dev: %s, cmd: %x, errors: %d\n",rq->rq_status, rq->rq_disk->disk_name,rq->cmd[0],rq->errors);
-	printk (KERN_INFO "sector: %ld, nr_sectors: %ld, current_nr_sectors: %d\n",rq->sector,rq->nr_sectors,rq->current_nr_sectors);
+	printk (IDESCSI_DEBUG "rq_status: %d, dev: %s, cmd: %x, errors: %d\n",
+			rq->rq_status, rq->rq_disk->disk_name,rq->cmd[0],rq->errors);
+	printk (IDESCSI_DEBUG "sector: %ld, nr_sectors: %ld, current_nr_sectors: %d\n",
+			rq->sector,rq->nr_sectors,rq->current_nr_sectors);
 #endif /* IDESCSI_DEBUG_LOG */
 
 	if (rq->flags & (REQ_SPECIAL|REQ_SENSE)) {
@@ -763,7 +775,8 @@
 		if ((first_bh = bh = idescsi_kmalloc_bio (segments)) == NULL)
 			return NULL;
 #if IDESCSI_DEBUG_LOG
-		printk ("ide-scsi: %s: building DMA table, %d segments, %dkB total\n", drive->name, segments, pc->request_transfer >> 10);
+		printk (IDESCSI_DEBUG "ide-scsi: %s: building DMA table, %d segments, %dkB total\n",
+			       	drive->name, segments, pc->request_transfer >> 10);
 #endif /* IDESCSI_DEBUG_LOG */
 		while (segments--) {
 			bh->bi_io_vec[0].bv_page = sg->page;
@@ -777,7 +790,8 @@
 		if ((first_bh = bh = idescsi_kmalloc_bio (1)) == NULL)
 			return NULL;
 #if IDESCSI_DEBUG_LOG
-		printk ("ide-scsi: %s: building DMA table for a single buffer (%dkB)\n", drive->name, pc->request_transfer >> 10);
+		printk (IDESCSI_DEBUG "ide-scsi: %s: building DMA table for a single buffer (%dkB)\n",
+			       	drive->name, pc->request_transfer >> 10);
 #endif /* IDESCSI_DEBUG_LOG */
 		bh->bi_io_vec[0].bv_page = virt_to_page(pc->scsi_cmd->request_buffer);
 		bh->bi_io_vec[0].bv_len = pc->request_transfer;
@@ -841,10 +855,10 @@
 	idescsi_transform_pc1 (drive, pc);
 
 	if (test_bit(IDESCSI_LOG_CMD, &scsi->log)) {
-		printk ("ide-scsi: %s: que %lu, cmd = ", drive->name, cmd->serial_number);
+		printk (IDESCSI_LOG "ide-scsi: %s: que %lu, cmd = ", drive->name, cmd->serial_number);
 		hexdump(cmd->cmnd, cmd->cmd_len);
 		if (memcmp(pc->c, cmd->cmnd, cmd->cmd_len)) {
-			printk ("ide-scsi: %s: que %lu, tsl = ", drive->name, cmd->serial_number);
+			printk (IDESCSI_LOG "ide-scsi: %s: que %lu, tsl = ", drive->name, cmd->serial_number);
 			hexdump(pc->c, 12);
 		}
 	}
@@ -867,62 +881,115 @@
 
 int idescsi_abort (Scsi_Cmnd *cmd)
 {
-	int countdown = 8;
+	int countdown = 120;	/* maximum is 12 seconds because ide interrupt timeout is 10 sec. */
 	unsigned long flags;
 	ide_drive_t *drive = idescsi_drives[cmd->target];
 	idescsi_scsi_t *scsi;
 
-	printk (KERN_ERR "ide-scsi: abort called for %lu\n", cmd->serial_number);
-	if (drive && (scsi = drive->driver_data))
-		while (countdown--) {
-			/* is cmd active?
-			 *  need to lock so this stuff doesn't change under us */
-			spin_lock_irqsave(&ide_lock, flags);
-			if (scsi->pc && scsi->pc->scsi_cmd && 
-					scsi->pc->scsi_cmd->serial_number == cmd->serial_number) {
-				/* yep - let's give it some more time - 
-				 * we can do that, we're in _our_ error kernel thread */
-				spin_unlock_irqrestore(&ide_lock, flags);
-				scsi_sleep(HZ);
-				continue;
-			}
-			/* no, but is it queued in the ide subsystem? */
-			if (elv_queue_empty(&drive->queue)) {
-				spin_unlock_irqrestore(&ide_lock, flags);
-				return SUCCESS;
-			}
+	if (!drive || !(scsi = drive->driver_data))
+		return FAILED;
+#if IDESCSI_DEBUG_LOG
+	if (1)
+#else
+	if (test_bit(IDESCSI_LOG_CMD, &scsi->log))
+#endif
+		printk (IDESCSI_LOG "ide-scsi: abort called for %lu\n", cmd->serial_number);
+
+	spin_unlock_irq(cmd->host->host_lock);
+	while (countdown--) {
+		/* is cmd active?
+		 * need to lock so this stuff doesn't change under us */
+		spin_lock_irqsave(&ide_lock, flags);
+		if (scsi->pc && scsi->pc->scsi_cmd && 
+				scsi->pc->scsi_cmd->serial_number == cmd->serial_number) {
+			/* yep - let's give it some more time - 
+			 * we can do that, we're in _our_ error kernel thread */
 			spin_unlock_irqrestore(&ide_lock, flags);
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(HZ/10);
+			continue;
 		}
+		/* no, but is it queued in the ide subsystem? */
+		if (elv_queue_empty(&drive->queue)) {
+			spin_unlock_irqrestore(&ide_lock, flags);
+			spin_lock_irq(cmd->host->host_lock);
+			return SUCCESS;
+		}
+		spin_unlock_irqrestore(&ide_lock, flags);
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ/10);
+	}
+	spin_lock_irq(cmd->host->host_lock);
 	return FAILED;
 }
 
 int idescsi_reset (Scsi_Cmnd *cmd)
 {
+	int countdown = 8; 
 	unsigned long flags;
 	struct request *req;
 	ide_drive_t *drive = idescsi_drives[cmd->target];
-
-	printk (KERN_ERR "ide-scsi: reset called for %lu\n", cmd->serial_number);
+	idescsi_scsi_t *scsi;
+#if IDESCSI_DEBUG_LOG
+	int log = 1;
+#else
+	int log = 0;
+#endif
+
+	if (!drive || !(scsi = drive->driver_data))
+		return FAILED;
+	log |= test_bit(IDESCSI_LOG_CMD, &scsi->log);
+	if (log)
+		printk (IDESCSI_LOG "ide-scsi: reset called for %lu\n", cmd->serial_number);
 	/* first null the handler for the drive and let any process
 	 * doing IO (on another CPU) run to (partial) completion
-	 * the lock prevents processing new requests */
+	 * the lock prevents processing new requests 
+	 * we countdown to avoid deadlock */
+	spin_unlock_irq(cmd->host->host_lock);
 	spin_lock_irqsave(&ide_lock, flags);
-	while (HWGROUP(drive)->handler) {
+	while ((HWGROUP(drive)->busy || HWGROUP(drive)->handler) && countdown--) {
 		HWGROUP(drive)->handler = NULL;
+		del_timer(&HWGROUP(drive)->timer);
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(1);
 	}
+	if (HWGROUP(drive)->handler) {
+		if (log)
+			printk (IDESCSI_LOG "ide-scsi: handler did not finish\n");
+		HWGROUP(drive)->handler = NULL;
+		HWGROUP(drive)->busy = 0;
+		del_timer(&HWGROUP(drive)->timer);
+	}
 	/* now nuke the drive queue */
 	while ((req = elv_next_request(&drive->queue))) {
 		blkdev_dequeue_request(req);
 		end_that_request_last(req);
 	}
 	/* FIXME - this will probably leak memory */
-	HWGROUP(drive)->rq = NULL;
 	if (drive->driver_data) ((idescsi_scsi_t *)drive->driver_data)->pc = NULL;
+	HWGROUP(drive)->rq = NULL;
+	/* we use the busy flag to reserve the hwgroup for ourselves without
+	 * holding the ide lock for a long time during the reset */
+	HWGROUP(drive)->busy++;
 	spin_unlock_irqrestore(&ide_lock, flags);
-	/* finally, reset the drive (and its partner on the bus...) */
-	ide_do_reset (drive);	
+	/* finally, reset the drive (and possibly its partner on the bus...) */
+	ide_do_reset (drive);
+	HWGROUP(drive)->busy--;
+	/* in theory, this can take 30 seconds, but ide_spin_wait_hwgroup waits only 3,
+	 * usually, that is enough, but we call repeatedly, just to be covered */
+	countdown = 10;
+	while (ide_spin_wait_hwgroup(drive) && countdown--)
+		if (log)
+			printk (IDESCSI_LOG "ide-scsi: waiting for reset drive to complete\n");
+	/* for some reason when successful ide_spin_wait_hwgroup exits with ide_lock taken */
+	if (countdown) spin_unlock_irq(&ide_lock);
+	spin_lock_irq(cmd->host->host_lock);
+	if (HWGROUP(drive)->handler) {
+		printk (KERN_CRIT "ide-scsi: reset drive did not complete in time\n");
+		HWGROUP(drive)->handler = NULL;
+		del_timer(&HWGROUP(drive)->timer);
+		return FAILED;
+	}
 	return SUCCESS;
 }
 
@@ -948,6 +1015,8 @@
 	.queuecommand		= idescsi_queue,
 	.eh_abort_handler	= idescsi_abort,
 	.eh_device_reset_handler = idescsi_reset,
+	.eh_bus_reset_handler   = idescsi_reset,
+	.eh_host_reset_handler  = idescsi_reset,
 	.bios_param		= idescsi_bios,
 	.can_queue		= 40,
 	.this_id		= -1,

Works well for me now, though with some of the timeouts being substantial it can 
appear slow. Feedback welcome.

Thanks, Willem Riede.
--uQr8t48UFsdbeI+V
Content-Type: application/x-gzip
Content-Disposition: attachment; filename="ide-iops.l2559.patch.gz"
Content-Transfer-Encoding: base64

H4sICBtIND4CA2lkZS1pb3BzLmwyNTU5LnBhdGNoAJ2RW2vbMBSAn51fcdrS4dRRIis4zYWU
wGa60RAPL2UvA+PVciLiSK5kt4yR/z7JlxQ292UGIXSkc/k+I4QgkeyFSjViCTULMZGr4dMw
I543swjGY4Rd5E6AuHNC5hgPcfsBwh7GPcdx3ilyTice4Oncw3My+yd9tQI0m04GE3DMdgur
VQ+sk16jG0gEp5CLLGN8BzcjHdy/7qQoc3RnolHBjlSUBSwBL3rO2+XPUv1CaKHfS1qUkoMe
KlKFyHOa6KiuXvV1MfZMY72fO1ssBXv/ylJ0J6miRWQa2RVgvw+/zQsrl4wXB/vBDzeRH4Zw
ea3msBeqgLcUSGOWlZJCKiRcq+EPfjmokq26OI+PdFCLqw99Q2B1MVjdFFZl6dSQeLgm8ciZ
5NSIfN9Zl+P/0OiOa43ueNo0v9IWg4doG0Sh/83fRh+DzTYM1ms/1MWM4Ysvn/w2qt/cN2oz
8RRnEZPPkTZZCEntNIt3qnbTpabbzHky4t5WkxHitlrKKZT8GKuDtWz112edeAWUJyzV2Y71
+ft9GDx+bX593dRxFs38f9/uY55kVMLFEjaP63WDU3LFdpwmkAktt0KpplY545FmPRhUFb9Q
+4MhMJEBtMR/AFqHGzueAwAA

--uQr8t48UFsdbeI+V
Content-Type: application/x-gzip
Content-Disposition: attachment; filename="ide-scsi.l2559.patch.gz"
Content-Transfer-Encoding: base64

H4sICBxIND4CA2lkZS1zY3NpLmwyNTU5LnBhdGNoALVae3PaSBL/G3+KXm+tAxEQAcbGIfHG
sXHCJbF9YO/u7V5KJaTBaC0koocfdfF3v+4ejRBPoySbSmEYzfT0dP/6OapUKmAHzq0Iwheh
FTovHFtU6EvVqrr1ZvOgUNf1RkWvVWp7UK+9rNfxf1VX/6CiN3V9S9O0VVTS9fU9qOkvm82X
emth/Zs3UKkflA9Aw8+aDm/ebAE8h99EAHr1AAD+Fbug78IBfT917sGEQXwNjgf9d0a/c2lc
9o7O+qfnvU/V7MIaLfRwW9DrycJtfziEwQP4ntgGEQR+QFSiwPTCoR+Mw+xyXHMiLGjU5PLu
eOKKsfAi8MQd9I/7XRg7NrjiVrhwdNHd0qZLG7iz6QGeWW/IpYF/K+xkx5Hp2a4ImNcXW7BV
+dkWQ8cT0D3pEF3jt06v3z0/g23iYntLW/e8sY0U4GfHs9zYFvDKdbz4/sXYt2NXVEeHi48s
3xs61/SIxN7cLe+D1myi8Enq6eTtkR9GYXW0nSXAug157RKuTzpvr94ZH8/fFQr6Is/Tp6se
FgofOr0z4+z8snvcWZzDhHlG9+z0nA4dPUwEToIwCmIrAgQdMWhMLCOE/21BIW6B9Vet/rld
wH8vnsORFcWmCxPTuhERoiASISmA0benkxzqew38Q4IoTALHi26K25//622X2lvwSEcOIzNy
LITMdDdrJKwbA4VqO5Hje0UcN9gWjAie85eyYjAQX2IR4vDQdFxh46LxGKFQ2tK+kW7mxEuo
sgzUFP7ASfQXXktrrRxKozVsMzLbmclMD8E5sdpSOq0WmSVaZ02ZZyH4UjkcuuZ1iNR6nX+j
GZ71O0RkYlUOI2cs/DjCR387w6GDctbg96PupdHrHJ38h2ahOlDRnZ+gb94KiEYCJPtKO8kp
yDq3aatBPByKYJv0VSlMB3CH4q2PZvi8BLPnrxyGE2E5ptvGBcSTlOrYpiXFWcmtXFuaLmtv
aRvtS/PmtlsgnpJEkQ+hiDiMjIETFTNQN44/nZRhh6ZWDl3/ulRCdVYKCSyhuK1c7Ev4JXwJ
CKxYgNxuu6zU65ljUSKG0mWZHSAPCSgURuLejseTIh3OKsMejz4SEkQUBx4wQP0Eo0immIA0
+MJANSaBEONJVJKQauh1MriG3izXahJRuaA6b1LBF5z6/vd3vfOrC7kz6i74soBqxDTpbl7/
pNkUL9rPqJUFv4ViJPtEXSCBGs0SbiiIfjq6kSJ5JVr1cHqKPrHy3qdzkNttS9/FAjAQb/zb
C51rD+3D9b1rYMNLBFlrsiDr9XIrkSNCamqdO1PrLLFHmJOHv1ogEuqsfKJJzEsQrkLhXWBO
IJ4A+y74xY1R+2G0gKcy+FkLwW8iQMEbXjweiEACdhPErtmOSRRA/ivk2RsPOwN1KYRyTeKd
AV8Yi7E1eSimHmCBpBcKI1kIGSKcNUhdGG+vTk8pjP/ZURZRb5EpaI3GXrnWkKp8BMIYKI1y
+hDC4Wvo9HrnPePT0R+JTmcZCEQYuySIk+6JwVPh1Suo7c2ocp0iuy/Ok1wFsyKSLAbBORX+
EA0u3WeN7p5S3VJ5KdhvcG6JpDTofuvpK3K3n1bF8tQzlkqbSmoNZ98sL20zNicWsgkyhboT
mMyYQYSOyEydL+MdsxwfHz9zXRgIGGAUL4O4dyLm1PPvONVFIkm00NtrYFs8ft85/mAcn5+d
dC8p0SX0luArFAnQ5x8kmpXd7HLq1mjqKnVbZw1qcTvrCdP8H91fHTLnzuH7wtgihfwjZvJN
tEnYrN40Kl0cG7/3UKBn7zAg0WKOECXY2WFSJqfH7kMiDjQe1PK6Z68wDur1XTVHOrnE2gpp
Ap065YSnggprODavKMaToeIOa7ell2t1VO8B/2X9prGQIm+ESUVblkDLgnYllW9aOmSl2xMm
ot7OZtI4m4rCCM8YTyJVrMkqQFvQFu/0HRRB5gKAtrXAvKwOMzkiLjQsV5gBqRNInyefjvBM
xkXv/F2v0+/P6JU1sUoqq2CMBCn3xlI3EvNub3kquSCBDcg8eWppw8tQ95oeKKSocUYWh+MS
JoHd0zQD5KR0bBq4XTKWwOqgRU5jV28pp8GmQnVYHFYHVRt9swQyFSo+jP1ATFUYJjxunrzP
eI4MEi9mqx0lMrsMv9hJhZo5O0tylWDWuZMfuw2e3PUt9DVO8AUlaw5cUZy6ylSGHE5k5JgG
Y02TCtjFLIcUsLuXeu1CtpJIoox0GY9rcDwrVdk8yKLxEktLriTuTA8VF/kUrmyIQ6lTqiew
/DQ9DFaY/1NgqwCe2b9zMM9W51bWvwH6f+B+G1jJI9dgspHTwAJAazYbqkRXTQUlzTDyJ8a0
wYC1mgrgGzUtqI4LkWM/wEkDBMCNbDHk8LsIF4kOdBKIPVvckrcoU9GJX+7LMhfkp4RBQk26
pAzJT9sJb7AcxE+DwyANI4G/9M/lTM7XXs6BPABu4OL+XmDI32EyYMWIcC8yZh6krMgh/jqd
ILdfWLcuVuSUAsPu+0SxkpVvFUfKU06ZbBrtsuVrkevXi85x9+jj12ktS+6ZcL/PLTttf7+p
6l+mUBw6ATnmEWYZ/KFgfzMma7PQZfvoq8Q1dXQpVr5+DWdXHz+WskkqDbTzx9BB7Lg2mTNF
wYjcI/tZtRn9uHmLniEy3cXKYjprWaCDw0PMuXIE4py8sGKXlhIb8rWBz7obOa6Yyr5SUSnj
YIRJpGM4vnErLARxdXBrTMxrgdoLryuH9FUGj/39fdY55oT5dV77p5XNFY8JIQ7ij6RfWCQ5
l5YXkv+Akp/gYbWav1e5a3R46wRI0+efxXWZv8wlllFyhZdUDYsZIAGjtcsNaq3VbKaN6mVF
Xm2uyPuhjVjZiVrWSOXRpVXgZv3Z3JQzbVt+bo09O5mKHyTOad5GTa1pe3fV9Ceq4JTJKHRz
HD/X+XOQnm/m4cFq9WkjT2ZOrb398h6WmK0WgqfWZNRszdzFmAM/wCyJ27THKBN4jrtx9lPh
7q/lx15k+3cEzlY7aRRnB2t1vU2VxNi8d8bxGJwQhyib8j07hIGwzJjaVnamxgB1h0JzdZpb
lSa2tBPMMJ9L4TIOkH+Hf7GMMBW8FtHn9oqOO1nDXOrU6fWyypDSwPyfrmuyHbIVvTACl2Ro
B6P5yq6+LJKS4JAKT0aHiuw+oSgI/FiW4KpfeRSeA3gCGcFEm3JS6kJFI5wYRuhLwPZF6D1D
bjHjRicUeza6sziU10iFQjhxPIOWUSkTmreiuENypJGyFK3s5snChl3AxKJjqO+Zex4c5amy
wTH7cE4sFH+WCCs5KJ30QUywLsAa7VkI1yQ6rPdDfyxkEUHQwMdyNnBXzsKKwqajm1GZ2nBc
roLhx4GRdFhvROAJF2cEwrSVAKQEYk/JIEAPiDusEoPs3YSuEJPi+z/VIKI4crxYyJ+PSlue
X8bIwwBG7vl6ie/z6LKPoB7Gg/AhjMT4V8UNSVm4twbPNei26KG4kyCFx1L3k5fvJMb3r46P
O/2+YlSTVb8E59ev8NNadGopmdOj7sfOybqLoiHlGeqKSMvTKFCXQ08HhXx2qCHFOaHJmEA3
TvKTBccOebkVasuMUGMEfpsJahtaoLaxAWrfaX9aHvPTvsf6IBeIaatQRIaqqqgQFMXLo/4H
LGwv0UFfXVx2337sJDEvpBZk7GIskEEEjfWFyigz5grSCPIbq7aprWr5T5kFxGqELpq0lhwm
13YbylRbK9JHZVpPsQ3zDoTfKplJNZBdsTzV0JakGrA6H1ho34gv35YmVJ5IByTHG7uhFUlH
rjv37Kg+vU/Xvt+hF4jo181v8qe3ik/763yC4ldkuKAFL3ZdNsTk5oAX0295TurooqvCvw8w
CXxLhCGuRsdk+1QTds+h6Hv41MclARxfXJUgiD3y1sWJGUT0movqCDu+h9rGpUSdffkkELdU
pSvKRJHef0twlbjxXCvkfPKaKZaRF5Mv0230jkyFyW4Yr2DTPC4Ja/OviSRilf4qmbMwaRCH
DwSplYsx/MzFS3SvK2bD66TdgKixhcs+JSjuzM/m4VyOCpY4qlrypo4E69rDz8D5KTyrs9io
NwQXgtVzwlHaKt/g6EtlLE16Q7k8Sjuh+2UvvhEZq5CvM3GgVSpFBCJ1ClqeuI9U93s+aiWa
G7g3trg1bCEDnJqMf6WY0eUYFO/VE8M1M48Tvk67f3zqYKrA6dCdg2aMRjEwB+4DWqx5A1hz
+8GDTH8XX15KRQXTGmrWh2XeZFPutLRkGidNU7mv2UlLLvmpHCVZskbIgMhEyYEFydt6o7vr
wI8n7IowzQlRqoKOGI0QctLCR75sSqkUgu1a9qU4VHEaZceBmiP9Ixv+MmDQzRHkyvvZgXp0
gVVOiE/hUeSXC8lLoQv0EJa+pw5crVZLUiXJK21JTE7uDwtSSOspT3x0fKTm9Vtoy7dYIYFK
JVGQzMsQOWWJLEo/IxPh39BVUyHJ5ujuhyR2ZzqRoXRGP0LkBtlrlKWu4jCWpyFIUxIoPD++
HkkqnOAidgMxEeh5bJr3d4yBCTExIDeOQBO2PM9M10PP1BJLWUmON+8783oiIkkoInBJSUpV
IH+ZS+hSIj2axck8puIh6uRuJDx6xYKC1TB2VwiN3mWRAAeFNZa5l+hxmCmXSjAfuVJ8MhMb
5rhPu+uZvOy4171czDekJJSPVuJgCKH95fHWmwWqhYwq84pomqtz3ku9t4PdVnkPtJpeS69v
quxwk6vqQmGanfJ4mWaIkWzJGQmXmUk8riahA3csIY3LmJ5oJtcmA6C5aGBzE2HVVNbS3NyF
qcjBwPFDA43fHGePQaP8GK1Wnome7uo8RuZsOHzsSq289X+ywctSnzEAAA==

--uQr8t48UFsdbeI+V--
