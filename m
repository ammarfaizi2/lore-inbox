Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315613AbSENLcF>; Tue, 14 May 2002 07:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315614AbSENLcE>; Tue, 14 May 2002 07:32:04 -0400
Received: from [195.63.194.11] ([195.63.194.11]:32011 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315613AbSENLbu>; Tue, 14 May 2002 07:31:50 -0400
Message-ID: <3CE0E6DB.6080001@evision-ventures.com>
Date: Tue, 14 May 2002 12:28:43 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.15 IDE 63
In-Reply-To: <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------010406000104080301020806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010406000104080301020806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Tue May 14 02:36:12 CEST 2002 ide-clean-63:

- Propagate the queue handling changes to pmac as well.

- Move set_transfer to ide-taskfile.c this is the only place where it's used
   and it can be made static there. Same applies to ide_ata66_check().

- Move ide_auto_reduce_xfer to ide.c.

- Make ide_cmd() local to the only place where it's used. Rename it to
   drive_cmd(). Don't pass drive_cmd_intr() as parameter.

- Remove ide_next command completion type. Nobody is using it.

- Move ide_do_drive_cmd to ide-taskfile. It's used there and in sub-drivers.
   Not in ide.c. The usage inside the device type drivers is entirely bogus
   inconsistent and so on...

- Kill bogus IRQ masking code. The kernel is supposed to handle this properly.
   We should not try to work against possible bugs in the overall irq handling
   code. Wow this is increasing the systems overall responsibility by a
   significant margin.

- Remove disfunctional pdcadma code. It is only misleading to the user.

Finally I know where the locking mis matches happen: It's in the device type
drivers, which entirely disobey the locking done inside the generic code and
which push REQ_DRIVE_CMD type request directly down through the request queue.
We will have to deal with them later, simple due to the fact that I can not do
everything at once. And finally I have different plans for them :-). (Hint: Why
there should be 4 different ATAPI device handling drivers instead of one?)

--------------010406000104080301020806
Content-Type: text/plain;
 name="ide-clean-63.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-63.diff"

diff -urN linux-2.5.15/arch/alpha/defconfig linux/arch/alpha/defconfig
--- linux-2.5.15/arch/alpha/defconfig	2002-05-10 00:24:42.000000000 +0200
+++ linux/arch/alpha/defconfig	2002-05-14 04:11:51.000000000 +0200
@@ -266,7 +266,6 @@
 # CONFIG_BLK_DEV_HPT366 is not set
 # CONFIG_BLK_DEV_NS87415 is not set
 # CONFIG_BLK_DEV_OPTI621 is not set
-# CONFIG_BLK_DEV_PDC_ADMA is not set
 # CONFIG_BLK_DEV_PDC202XX is not set
 # CONFIG_PDC202XX_BURST is not set
 # CONFIG_PDC202XX_FORCE is not set
diff -urN linux-2.5.15/arch/i386/defconfig linux/arch/i386/defconfig
--- linux-2.5.15/arch/i386/defconfig	2002-05-10 00:21:57.000000000 +0200
+++ linux/arch/i386/defconfig	2002-05-14 04:11:41.000000000 +0200
@@ -275,7 +275,6 @@
 CONFIG_BLK_DEV_PIIX=y
 # CONFIG_BLK_DEV_NS87415 is not set
 # CONFIG_BLK_DEV_OPTI621 is not set
-# CONFIG_BLK_DEV_PDC_ADMA is not set
 # CONFIG_BLK_DEV_PDC202XX is not set
 # CONFIG_PDC202XX_BURST is not set
 # CONFIG_PDC202XX_FORCE is not set
diff -urN linux-2.5.15/arch/ia64/defconfig linux/arch/ia64/defconfig
--- linux-2.5.15/arch/ia64/defconfig	2002-05-10 00:21:51.000000000 +0200
+++ linux/arch/ia64/defconfig	2002-05-14 04:11:58.000000000 +0200
@@ -247,7 +247,6 @@
 # CONFIG_BLK_DEV_PIIX is not set
 # CONFIG_BLK_DEV_NS87415 is not set
 # CONFIG_BLK_DEV_OPTI621 is not set
-# CONFIG_BLK_DEV_PDC_ADMA is not set
 # CONFIG_BLK_DEV_PDC202XX is not set
 # CONFIG_PDC202XX_BURST is not set
 # CONFIG_PDC202XX_FORCE is not set
diff -urN linux-2.5.15/arch/sparc64/defconfig linux/arch/sparc64/defconfig
--- linux-2.5.15/arch/sparc64/defconfig	2002-05-10 00:23:31.000000000 +0200
+++ linux/arch/sparc64/defconfig	2002-05-14 04:11:47.000000000 +0200
@@ -310,7 +310,6 @@
 # CONFIG_BLK_DEV_PIIX is not set
 CONFIG_BLK_DEV_NS87415=y
 # CONFIG_BLK_DEV_OPTI621 is not set
-# CONFIG_BLK_DEV_PDC_ADMA is not set
 # CONFIG_BLK_DEV_PDC202XX is not set
 # CONFIG_PDC202XX_BURST is not set
 # CONFIG_PDC202XX_FORCE is not set
diff -urN linux-2.5.15/arch/x86_64/defconfig linux/arch/x86_64/defconfig
--- linux-2.5.15/arch/x86_64/defconfig	2002-05-10 00:25:17.000000000 +0200
+++ linux/arch/x86_64/defconfig	2002-05-14 04:11:54.000000000 +0200
@@ -228,7 +228,6 @@
 # CONFIG_BLK_DEV_PIIX is not set
 # CONFIG_BLK_DEV_NS87415 is not set
 # CONFIG_BLK_DEV_OPTI621 is not set
-# CONFIG_BLK_DEV_PDC_ADMA is not set
 # CONFIG_BLK_DEV_PDC202XX is not set
 # CONFIG_PDC202XX_BURST is not set
 # CONFIG_PDC202XX_FORCE is not set
diff -urN linux-2.5.15/drivers/ide/ata-timing.c linux/drivers/ide/ata-timing.c
--- linux-2.5.15/drivers/ide/ata-timing.c	2002-05-10 00:23:31.000000000 +0200
+++ linux/drivers/ide/ata-timing.c	2002-05-14 02:39:39.000000000 +0200
@@ -70,7 +70,7 @@
  * then to be matched agains in esp. other drives no the same channel or even
  * the whole particular host chip.
  */
-short ata_timing_mode(ide_drive_t *drive, int map)
+short ata_timing_mode(struct ata_device *drive, int map)
 {
 	struct hd_driveid *id = drive->id;
 	short best = 0;
@@ -192,7 +192,7 @@
 	return t;
 }
 
-int ata_timing_compute(ide_drive_t *drive, short speed, struct ata_timing *t,
+int ata_timing_compute(struct ata_device *drive, short speed, struct ata_timing *t,
 		int T, int UT)
 {
 	struct hd_driveid *id = drive->id;
diff -urN linux-2.5.15/drivers/ide/Config.help linux/drivers/ide/Config.help
--- linux-2.5.15/drivers/ide/Config.help	2002-05-10 00:25:30.000000000 +0200
+++ linux/drivers/ide/Config.help	2002-05-14 04:11:23.000000000 +0200
@@ -294,9 +294,6 @@
 
   It is normally safe to answer Y; however, the default is N.
 
-CONFIG_BLK_DEV_PDC_ADMA
-  Please read the comments at the top of <file:drivers/ide/ide-pci.c>.
-
 CONFIG_BLK_DEV_AEC62XX
   This driver adds up to 4 more EIDE devices sharing a single
   interrupt. This add-on card is a bootable PCI UDMA controller. In
diff -urN linux-2.5.15/drivers/ide/Config.in linux/drivers/ide/Config.in
--- linux-2.5.15/drivers/ide/Config.in	2002-05-10 00:25:33.000000000 +0200
+++ linux/drivers/ide/Config.in	2002-05-14 04:11:34.000000000 +0200
@@ -73,7 +73,6 @@
       fi
       dep_bool '    NS87415 chipset support (EXPERIMENTAL)' CONFIG_BLK_DEV_NS87415 $CONFIG_BLK_DEV_IDEDMA_PCI
       dep_mbool '    OPTi 82C621 chipset enhanced support (EXPERIMENTAL)' CONFIG_BLK_DEV_OPTI621 $CONFIG_PCI $CONFIG_EXPERIMENTAL
-      dep_mbool '    Pacific Digital A-DMA support (EXPERIMENTAL)' CONFIG_BLK_DEV_PDC_ADMA $CONFIG_EXPERIMENTAL
       dep_bool '    PROMISE PDC202{46|62|65|67|68|69|70} support' CONFIG_BLK_DEV_PDC202XX $CONFIG_BLK_DEV_IDEDMA_PCI
       dep_bool '      Special UDMA Feature' CONFIG_PDC202XX_BURST $CONFIG_BLK_DEV_PDC202XX
       dep_bool '      Special FastTrak Feature' CONFIG_PDC202XX_FORCE $CONFIG_BLK_DEV_PDC202XX
diff -urN linux-2.5.15/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.15/drivers/ide/ide.c	2002-05-14 04:22:37.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-05-14 04:11:13.000000000 +0200
@@ -54,7 +54,6 @@
 #include <linux/delay.h>
 #include <linux/ide.h>
 #include <linux/devfs_fs_kernel.h>
-#include <linux/completion.h>
 #include <linux/reboot.h>
 #include <linux/cdrom.h>
 #include <linux/device.h>
@@ -354,6 +353,31 @@
 	spin_unlock_irqrestore(ch->lock, flags);
 }
 
+static u8 auto_reduce_xfer(struct ata_device *drive)
+{
+	if (!drive->crc_count)
+		return drive->current_speed;
+	drive->crc_count = 0;
+
+	switch(drive->current_speed) {
+		case XFER_UDMA_7:	return XFER_UDMA_6;
+		case XFER_UDMA_6:	return XFER_UDMA_5;
+		case XFER_UDMA_5:	return XFER_UDMA_4;
+		case XFER_UDMA_4:	return XFER_UDMA_3;
+		case XFER_UDMA_3:	return XFER_UDMA_2;
+		case XFER_UDMA_2:	return XFER_UDMA_1;
+		case XFER_UDMA_1:	return XFER_UDMA_0;
+			/*
+			 * OOPS we do not goto non Ultra DMA modes
+			 * without iCRC's available we force
+			 * the system to PIO and make the user
+			 * invoke the ATA-1 ATA-2 DMA modes.
+			 */
+		case XFER_UDMA_0:
+		default:		return XFER_PIO_4;
+	}
+}
+
 static void check_crc_errors(struct ata_device *drive)
 {
 	if (!drive->using_dma)
@@ -362,8 +386,10 @@
 	/* check the DMA crc count */
 	if (drive->crc_count) {
 		udma_enable(drive, 0, 0);
-		if ((drive->channel->speedproc) != NULL)
-		        drive->channel->speedproc(drive, ide_auto_reduce_xfer(drive));
+		if (drive->channel->speedproc) {
+			u8 pio = auto_reduce_xfer(drive);
+		        drive->channel->speedproc(drive, pio);
+		}
 		if (drive->current_speed >= XFER_SW_DMA_0)
 			udma_enable(drive, 1, 1);
 	} else
@@ -835,19 +861,6 @@
 }
 
 /*
- * Issue a simple drive command.  The drive must be selected beforehand.
- */
-void ide_cmd(struct ata_device *drive, byte cmd, byte nsect, ata_handler_t handler)
-{
-	ide_set_handler (drive, handler, WAIT_CMD, NULL);
-	if (IDE_CONTROL_REG)
-		OUT_BYTE(drive->ctl,IDE_CONTROL_REG);	/* clear nIEN */
-	SELECT_MASK(drive->channel, drive, 0);
-	OUT_BYTE(nsect,IDE_NSECTOR_REG);
-	OUT_BYTE(cmd,IDE_COMMAND_REG);
-}
-
-/*
  * Invoked on completion of a special DRIVE_CMD.
  */
 static ide_startstop_t drive_cmd_intr(struct ata_device *drive, struct request *rq)
@@ -865,13 +878,27 @@
 	}
 
 	if (!OK_STAT(stat, READY_STAT, BAD_STAT))
-		return ide_error(drive, rq, "drive_cmd", stat); /* calls ide_end_drive_cmd */
+		return ide_error(drive, rq, "drive_cmd", stat); /* already calls ide_end_drive_cmd */
 	ide_end_drive_cmd(drive, rq, stat, GET_ERR());
 
 	return ide_stopped;
 }
 
 /*
+ * Issue a simple drive command.  The drive must be selected beforehand.
+ */
+static void drive_cmd(struct ata_device *drive, u8 cmd, u8 nsect)
+{
+	ide_set_handler(drive, drive_cmd_intr, WAIT_CMD, NULL);
+	if (IDE_CONTROL_REG)
+		OUT_BYTE(drive->ctl, IDE_CONTROL_REG);	/* clear nIEN */
+	SELECT_MASK(drive->channel, drive, 0);
+	OUT_BYTE(nsect, IDE_NSECTOR_REG);
+	OUT_BYTE(cmd, IDE_COMMAND_REG);
+}
+
+
+/*
  * Busy-wait for the drive status to be not "busy".  Check then the status for
  * all of the "good" bits and none of the "bad" bits, and if all is okay it
  * returns 0.  All other cases return 1 after invoking ide_error() -- caller
@@ -1014,12 +1041,12 @@
 			OUT_BYTE(0xc2, IDE_HCYL_REG);
 			OUT_BYTE(args[2],IDE_FEATURE_REG);
 			OUT_BYTE(args[1],IDE_SECTOR_REG);
-			ide_cmd(drive, args[0], args[3], &drive_cmd_intr);
+			drive_cmd(drive, args[0], args[3]);
 
 			return ide_started;
 		}
 		OUT_BYTE(args[2],IDE_FEATURE_REG);
-		ide_cmd(drive, args[0], args[1], &drive_cmd_intr);
+		drive_cmd(drive, args[0], args[1]);
 
 		return ide_started;
 	}
@@ -1187,10 +1214,10 @@
 
 
 /*
- * Feed commands to a drive until it barfs.  Called with ide_lock/DRIVE_LOCK
- * held and busy channel.
+ * Feed commands to a drive until it barfs.  Called with queue lock held and
+ * busy channel.
  */
-static void queue_commands(struct ata_device *drive, int masked_irq)
+static void queue_commands(struct ata_device *drive)
 {
 	struct ata_channel *ch = drive->channel;
 	ide_startstop_t startstop = -1;
@@ -1199,7 +1226,7 @@
 		struct request *rq = NULL;
 
 		if (!test_bit(IDE_BUSY, &ch->active))
-			printk(KERN_ERR"%s: error: not busy while queueing!\n", drive->name);
+			printk(KERN_ERR "%s: error: not busy while queueing!\n", drive->name);
 
 		/* Abort early if we can't queue another command. for non
 		 * tcq, ata_can_queue is always 1 since we never get here
@@ -1214,7 +1241,7 @@
 		drive->sleep = 0;
 
 		if (test_bit(IDE_DMA, &ch->active)) {
-			printk("ide_do_request: DMA in progress...\n");
+			printk(KERN_ERR "%s: error: DMA in progress...\n", drive->name);
 			break;
 		}
 
@@ -1245,18 +1272,6 @@
 
 		drive->rq = rq;
 
-		/* Some systems have trouble with IDE IRQs arriving while the
-		 * driver is still setting things up.  So, here we disable the
-		 * IRQ used by this interface while the request is being
-		 * started.  This may look bad at first, but pretty much the
-		 * same thing happens anyway when any interrupt comes in, IDE
-		 * or otherwise -- the kernel masks the IRQ while it is being
-		 * handled.
-		 */
-
-		if (masked_irq && drive->channel->irq != masked_irq)
-			disable_irq_nosync(drive->channel->irq);
-
 		spin_unlock(drive->channel->lock);
 
 		ide__sti();	/* allow other IRQs while we start this request */
@@ -1264,9 +1279,6 @@
 
 		spin_lock_irq(drive->channel->lock);
 
-		if (masked_irq && drive->channel->irq != masked_irq)
-			enable_irq(drive->channel->irq);
-
 		/* command started, we are busy */
 		if (startstop == ide_started)
 			break;
@@ -1288,7 +1300,7 @@
  * Issue a new request.
  * Caller must have already done spin_lock_irqsave(channel->lock, ...)
  */
-static void ide_do_request(struct ata_channel *channel, int masked_irq)
+static void do_request(struct ata_channel *channel)
 {
 	ide_get_lock(&irq_lock, ata_irq_request, hwgroup);/* for atari only: POSSIBLY BROKEN HERE(?) */
 //	__cli();	/* necessary paranoia: ensure IRQs are masked on local CPU */
@@ -1319,14 +1331,14 @@
 		 */
 		ch->drive = drive;
 
-		queue_commands(drive, masked_irq);
+		queue_commands(drive);
 	}
 
 }
 
 void do_ide_request(request_queue_t *q)
 {
-	ide_do_request(q->queuedata, 0);
+	do_request(q->queuedata);
 }
 
 /*
@@ -1368,7 +1380,7 @@
 /*
  * This is our timeout function for all drive operations.  But note that it can
  * also be invoked as a result of a "sleep" operation triggered by the
- * mod_timer() call in ide_do_request.
+ * mod_timer() call in do_request.
  */
 void ide_timer_expiry(unsigned long data)
 {
@@ -1462,7 +1474,7 @@
 		}
 	}
 
-	ide_do_request(ch->drive->channel, 0);
+	do_request(ch->drive->channel);
 
 	spin_unlock_irqrestore(ch->lock, flags);
 }
@@ -1606,12 +1618,12 @@
 	if (startstop == ide_stopped) {
 		if (!ch->handler) {	/* paranoia */
 			clear_bit(IDE_BUSY, &ch->active);
-			ide_do_request(ch, ch->irq);
+			do_request(ch);
 		} else {
 			printk("%s: %s: huh? expected NULL handler on exit\n", drive->name, __FUNCTION__);
 		}
 	} else if (startstop == ide_released)
-		queue_commands(drive, ch->irq);
+		queue_commands(drive);
 
 out_lock:
 	spin_unlock_irqrestore(ch->lock, flags);
@@ -1642,81 +1654,6 @@
 }
 
 /*
- * This function is intended to be used prior to invoking ide_do_drive_cmd().
- */
-void ide_init_drive_cmd(struct request *rq)
-{
-	memset(rq, 0, sizeof(*rq));
-	rq->flags = REQ_DRIVE_CMD;
-}
-
-/*
- * This function issues a special IDE device request onto the request queue.
- *
- * If action is ide_wait, then the rq is queued at the end of the request
- * queue, and the function sleeps until it has been processed.  This is for use
- * when invoked from an ioctl handler.
- *
- * If action is ide_preempt, then the rq is queued at the head of the request
- * queue, displacing the currently-being-processed request and this function
- * returns immediately without waiting for the new rq to be completed.  This is
- * VERY DANGEROUS, and is intended for careful use by the ATAPI tape/cdrom
- * driver code.
- *
- * If action is ide_next, then the rq is queued immediately after the
- * currently-being-processed-request (if any), and the function returns without
- * waiting for the new rq to be completed.  As above, This is VERY DANGEROUS,
- * and is intended for careful use by the ATAPI tape/cdrom driver code.
- *
- * If action is ide_end, then the rq is queued at the end of the request queue,
- * and the function returns immediately without waiting for the new rq to be
- * completed. This is again intended for careful use by the ATAPI tape/cdrom
- * driver code.
- */
-int ide_do_drive_cmd(struct ata_device *drive, struct request *rq, ide_action_t action)
-{
-	unsigned long flags;
-	unsigned int major = drive->channel->major;
-	request_queue_t *q = &drive->queue;
-	struct list_head *queue_head = &q->queue_head;
-	DECLARE_COMPLETION(wait);
-
-#ifdef CONFIG_BLK_DEV_PDC4030
-	if (drive->channel->chipset == ide_pdc4030 && rq->buffer != NULL)
-		return -ENOSYS;  /* special drive cmds not supported */
-#endif
-	rq->errors = 0;
-	rq->rq_status = RQ_ACTIVE;
-	rq->rq_dev = mk_kdev(major,(drive->select.b.unit)<<PARTN_BITS);
-	if (action == ide_wait)
-		rq->waiting = &wait;
-
-	spin_lock_irqsave(drive->channel->lock, flags);
-
-	if (blk_queue_empty(&drive->queue) || action == ide_preempt) {
-		if (action == ide_preempt)
-			drive->rq = NULL;
-	} else {
-		if (action == ide_wait || action == ide_end)
-			queue_head = queue_head->prev;
-		else
-			queue_head = queue_head->next;
-	}
-	q->elevator.elevator_add_req_fn(q, rq, queue_head);
-	ide_do_request(drive->channel, 0);
-
-	spin_unlock_irqrestore(drive->channel->lock, flags);
-
-	if (action == ide_wait) {
-		wait_for_completion(&wait);	/* wait for it to be serviced */
-		return rq->errors ? -EIO : 0;	/* return -EIO if errors */
-	}
-
-	return 0;
-
-}
-
-/*
  * This routine is called to flush all partitions and partition tables
  * for a changed disk, and then re-read the new partition table.
  * If we are revalidating a disk because of a media change, then we
@@ -3206,13 +3143,10 @@
 EXPORT_SYMBOL(ide_fixstring);
 EXPORT_SYMBOL(ide_wait_stat);
 EXPORT_SYMBOL(restart_request);
-EXPORT_SYMBOL(ide_init_drive_cmd);
-EXPORT_SYMBOL(ide_do_drive_cmd);
 EXPORT_SYMBOL(ide_end_drive_cmd);
 EXPORT_SYMBOL(__ide_end_request);
 EXPORT_SYMBOL(ide_end_request);
 EXPORT_SYMBOL(ide_revalidate_disk);
-EXPORT_SYMBOL(ide_cmd);
 EXPORT_SYMBOL(ide_delay_50ms);
 EXPORT_SYMBOL(ide_stall_queue);
 
@@ -3362,9 +3296,6 @@
 # ifdef CONFIG_BLK_DEV_AMD74XX
 	init_amd74xx();
 # endif
-# ifdef CONFIG_BLK_DEV_PDC_ADMA
-	init_pdcadma();
-# endif
 # ifdef CONFIG_BLK_DEV_SVWKS
 	init_svwks();
 # endif
diff -urN linux-2.5.15/drivers/ide/ide-features.c linux/drivers/ide/ide-features.c
--- linux-2.5.15/drivers/ide/ide-features.c	2002-05-14 00:50:21.000000000 +0200
+++ linux/drivers/ide/ide-features.c	2002-05-14 02:56:51.000000000 +0200
@@ -78,31 +78,6 @@
 	return "XFER ERROR";
 }
 
-byte ide_auto_reduce_xfer (ide_drive_t *drive)
-{
-	if (!drive->crc_count)
-		return drive->current_speed;
-	drive->crc_count = 0;
-
-	switch(drive->current_speed) {
-		case XFER_UDMA_7:	return XFER_UDMA_6;
-		case XFER_UDMA_6:	return XFER_UDMA_5;
-		case XFER_UDMA_5:	return XFER_UDMA_4;
-		case XFER_UDMA_4:	return XFER_UDMA_3;
-		case XFER_UDMA_3:	return XFER_UDMA_2;
-		case XFER_UDMA_2:	return XFER_UDMA_1;
-		case XFER_UDMA_1:	return XFER_UDMA_0;
-			/*
-			 * OOPS we do not goto non Ultra DMA modes
-			 * without iCRC's available we force
-			 * the system to PIO and make the user
-			 * invoke the ATA-1 ATA-2 DMA modes.
-			 */
-		case XFER_UDMA_0:
-		default:		return XFER_PIO_4;
-	}
-}
-
 /*
  * hd_driveid data come as little endian,
  * they need to be converted on big endian machines
@@ -110,7 +85,7 @@
 void ide_fix_driveid(struct hd_driveid *id)
 {
 #ifndef __LITTLE_ENDIAN
-#ifdef __BIG_ENDIAN
+# ifdef __BIG_ENDIAN
 	int i;
 	unsigned short *stringcast;
 
@@ -196,13 +171,13 @@
 	for (i = 0; i < 48; i++)
 		id->words206_254[i] = __le16_to_cpu(id->words206_254[i]);
 	id->integrity_word  = __le16_to_cpu(id->integrity_word);
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif /* __BIG_ENDIAN */
-#endif /* __LITTLE_ENDIAN */
+# else
+#  error "Please fix <asm/byteorder.h>"
+# endif
+#endif
 }
 
-int ide_driveid_update (ide_drive_t *drive)
+int ide_driveid_update(struct ata_device *drive)
 {
 	/*
 	 * Re-read drive->id for possible DMA mode
@@ -255,56 +230,9 @@
 }
 
 /*
- * Verify that we are doing an approved SETFEATURES_XFER with respect
- * to the hardware being able to support request.  Since some hardware
- * can improperly report capabilties, we check to see if the host adapter
- * in combination with the device (usually a disk) properly detect
- * and acknowledge each end of the ribbon.
- */
-int ide_ata66_check (ide_drive_t *drive, struct ata_taskfile *args)
-{
-	if ((args->taskfile.command == WIN_SETFEATURES) &&
-	    (args->taskfile.sector_number > XFER_UDMA_2) &&
-	    (args->taskfile.feature == SETFEATURES_XFER)) {
-		if (!drive->channel->udma_four) {
-			printk("%s: Speed warnings UDMA 3/4/5 is not functional.\n", drive->channel->name);
-			return 1;
-		}
-#ifndef CONFIG_IDEDMA_IVB
-		if ((drive->id->hw_config & 0x6000) == 0) {
-#else
-		if (((drive->id->hw_config & 0x2000) == 0) ||
-		    ((drive->id->hw_config & 0x4000) == 0)) {
-#endif
-			printk("%s: Speed warnings UDMA 3/4/5 is not functional.\n", drive->name);
-			return 1;
-		}
-	}
-	return 0;
-}
-
-/*
- * Backside of HDIO_DRIVE_CMD call of SETFEATURES_XFER.
- * 1 : Safe to update drive->id DMA registers.
- * 0 : OOPs not allowed.
- */
-int set_transfer (ide_drive_t *drive, struct ata_taskfile *args)
-{
-	if ((args->taskfile.command == WIN_SETFEATURES) &&
-	    (args->taskfile.sector_number >= XFER_SW_DMA_0) &&
-	    (args->taskfile.feature == SETFEATURES_XFER) &&
-	    (drive->id->dma_ultra ||
-	     drive->id->dma_mword ||
-	     drive->id->dma_1word))
-		return 1;
-
-	return 0;
-}
-
-/*
- *  All hosts that use the 80c ribbon mus use!
+ *  All hosts that use the 80c ribbon must use this!
  */
-byte eighty_ninty_three (ide_drive_t *drive)
+byte eighty_ninty_three(struct ata_device *drive)
 {
 	return ((byte) ((drive->channel->udma_four) &&
 #ifndef CONFIG_IDEDMA_IVB
@@ -324,7 +252,7 @@
  *
  * const char *msg == consider adding for verbose errors.
  */
-int ide_config_drive_speed (ide_drive_t *drive, byte speed)
+int ide_config_drive_speed(struct ata_device *drive, byte speed)
 {
 	struct ata_channel *hwif = drive->channel;
 	int i;
@@ -407,7 +335,7 @@
 	} else {
 		outb(inb(hwif->dma_base+2) & ~(1<<(5+unit)), hwif->dma_base+2);
 	}
-#endif /* (CONFIG_BLK_DEV_IDEDMA) && !(CONFIG_DMA_NONPCI) */
+#endif
 
 	switch(speed) {
 		case XFER_UDMA_7:   drive->id->dma_ultra |= 0x8080; break;
@@ -429,11 +357,7 @@
 	return error;
 }
 
-EXPORT_SYMBOL(ide_auto_reduce_xfer);
 EXPORT_SYMBOL(ide_fix_driveid);
 EXPORT_SYMBOL(ide_driveid_update);
-EXPORT_SYMBOL(ide_ata66_check);
-EXPORT_SYMBOL(set_transfer);
 EXPORT_SYMBOL(eighty_ninty_three);
 EXPORT_SYMBOL(ide_config_drive_speed);
-
diff -urN linux-2.5.15/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux-2.5.15/drivers/ide/ide-floppy.c	2002-05-14 00:50:21.000000000 +0200
+++ linux/drivers/ide/ide-floppy.c	2002-05-14 03:32:32.000000000 +0200
@@ -879,7 +879,7 @@
 	pc = idefloppy_next_pc_storage (drive);
 	rq = idefloppy_next_rq_storage (drive);
 	idefloppy_create_request_sense_cmd (pc);
-	idefloppy_queue_pc_head (drive, pc, rq);
+	idefloppy_queue_pc_head(drive, pc, rq);
 }
 
 /*
diff -urN linux-2.5.15/drivers/ide/ide-geometry.c linux/drivers/ide/ide-geometry.c
--- linux-2.5.15/drivers/ide/ide-geometry.c	2002-05-10 00:21:32.000000000 +0200
+++ linux/drivers/ide/ide-geometry.c	2002-05-14 02:45:46.000000000 +0200
@@ -1,6 +1,4 @@
 /*
- * linux/drivers/ide/ide-geometry.c
- *
  * Sun Feb 24 23:13:03 CET 2002: Patch by Andries Brouwer to remove the
  * confused CMOS probe applied. This is solving more problems than it may
  * (unexpectedly) introduce.
@@ -14,17 +12,17 @@
 
 #if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
 
-extern ide_drive_t * get_info_ptr(kdev_t);
+extern struct ata_device * get_info_ptr(kdev_t);
 
 /*
  * If heads is nonzero: find a translation with this many heads and S=63.
  * Otherwise: find out how OnTrack Disk Manager would translate the disk.
  */
 static void
-ontrack(ide_drive_t *drive, int heads, unsigned int *c, int *h, int *s)
+ontrack(struct ata_device *drive, int heads, unsigned int *c, int *h, int *s)
 {
-	static const byte dm_head_vals[] = {4, 8, 16, 32, 64, 128, 255, 0};
-	const byte *headp = dm_head_vals;
+	static const u8 dm_head_vals[] = {4, 8, 16, 32, 64, 128, 255, 0};
+	const u8 *headp = dm_head_vals;
 	unsigned long total;
 
 	/*
@@ -72,13 +70,13 @@
  *	-1 = similar to "0", plus redirect sector 0 to sector 1.
  *	 2 = convert to a CHS geometry with "ptheads" heads.
  *
- * Returns 0 if the translation was not possible, if the device was not 
+ * Returns 0 if the translation was not possible, if the device was not
  * an IDE disk drive, or if a geometry was "forced" on the commandline.
  * Returns 1 if the geometry translation was successful.
  */
-int ide_xlate_1024 (kdev_t i_rdev, int xparm, int ptheads, const char *msg)
+int ide_xlate_1024(kdev_t i_rdev, int xparm, int ptheads, const char *msg)
 {
-	ide_drive_t *drive;
+	struct ata_device *drive;
 	const char *msg1 = "";
 	int heads = 0;
 	int c, h, s;
@@ -144,4 +142,4 @@
 		       drive->bios_cyl, drive->bios_head, drive->bios_sect);
 	return ret;
 }
-#endif /* defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE) */
+#endif
diff -urN linux-2.5.15/drivers/ide/ide-pmac.c linux/drivers/ide/ide-pmac.c
--- linux-2.5.15/drivers/ide/ide-pmac.c	2002-05-14 04:22:37.000000000 +0200
+++ linux/drivers/ide/ide-pmac.c	2002-05-14 02:23:23.000000000 +0200
@@ -55,8 +55,6 @@
 #endif
 #include "ata-timing.h"
 
-extern spinlock_t ide_lock;
-
 #undef IDE_PMAC_DEBUG
 
 #define DMA_WAIT_TIMEOUT	500
@@ -1669,12 +1667,12 @@
 			break;
 	}
 
-	/* We resume processing on the HW group */
-	spin_lock_irq(&ide_lock);
+	/* We resume processing on the lock group */
+	spin_lock_irq(drive->channel->lock);
 	clear_bit(IDE_BUSY, &drive->channel->active);
 	if (!list_empty(&drive->queue.queue_head))
 		do_ide_request(&drive->queue);
-	spin_unlock_irq(&ide_lock);
+	spin_unlock_irq(drive->channel->lock);
 }
 
 /* Note: We support only master drives for now. This will have to be
diff -urN linux-2.5.15/drivers/ide/ide-tape.c linux/drivers/ide/ide-tape.c
--- linux-2.5.15/drivers/ide/ide-tape.c	2002-05-14 00:50:21.000000000 +0200
+++ linux/drivers/ide/ide-tape.c	2002-05-14 03:56:21.000000000 +0200
@@ -1917,9 +1917,9 @@
 			idetape_active_next_stage (drive);
 
 			/*
-			 *	Insert the next request into the request queue.
+			 * Insert the next request into the request queue.
 			 */
-			(void) ide_do_drive_cmd (drive, tape->active_data_request, ide_end);
+			ide_do_drive_cmd(drive, tape->active_data_request, ide_end);
 		} else if (!error) {
 			if (!tape->onstream)
 				idetape_increase_max_pipeline_stages (drive);
@@ -1986,7 +1986,7 @@
 	ide_init_drive_cmd (rq);
 	rq->buffer = (char *) pc;
 	rq->flags = IDETAPE_PC_RQ1;
-	(void) ide_do_drive_cmd (drive, rq, ide_preempt);
+	ide_do_drive_cmd(drive, rq, ide_preempt);
 }
 
 /*
@@ -3197,7 +3197,7 @@
 	ide_init_drive_cmd (&rq);
 	rq.buffer = (char *) pc;
 	rq.flags = IDETAPE_PC_RQ1;
-	return ide_do_drive_cmd (drive, &rq, ide_wait);
+	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
 
 static void idetape_create_load_unload_cmd (ide_drive_t *drive, idetape_pc_t *pc,int cmd)
diff -urN linux-2.5.15/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.15/drivers/ide/ide-taskfile.c	2002-05-14 04:22:37.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-05-14 03:56:48.000000000 +0200
@@ -19,6 +19,7 @@
 #include <linux/errno.h>
 #include <linux/genhd.h>
 #include <linux/blkpg.h>
+#include <linux/completion.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
@@ -813,6 +814,77 @@
 	}
 }
 
+/*
+ * This function is intended to be used prior to invoking ide_do_drive_cmd().
+ */
+void ide_init_drive_cmd(struct request *rq)
+{
+	memset(rq, 0, sizeof(*rq));
+	rq->flags = REQ_DRIVE_CMD;
+}
+
+/*
+ * This function issues a special IDE device request onto the request queue.
+ *
+ * If action is ide_wait, then the rq is queued at the end of the request
+ * queue, and the function sleeps until it has been processed.  This is for use
+ * when invoked from an ioctl handler.
+ *
+ * If action is ide_preempt, then the rq is queued at the head of the request
+ * queue, displacing the currently-being-processed request and this function
+ * returns immediately without waiting for the new rq to be completed.  This is
+ * VERY DANGEROUS, and is intended for careful use by the ATAPI tape/cdrom
+ * driver code.
+ *
+ * If action is ide_end, then the rq is queued at the end of the request queue,
+ * and the function returns immediately without waiting for the new rq to be
+ * completed. This is again intended for careful use by the ATAPI tape/cdrom
+ * driver code.
+ */
+int ide_do_drive_cmd(struct ata_device *drive, struct request *rq, ide_action_t action)
+{
+	unsigned long flags;
+	unsigned int major = drive->channel->major;
+	request_queue_t *q = &drive->queue;
+	struct list_head *queue_head = &q->queue_head;
+	DECLARE_COMPLETION(wait);
+
+#ifdef CONFIG_BLK_DEV_PDC4030
+	if (drive->channel->chipset == ide_pdc4030 && rq->buffer != NULL)
+		return -ENOSYS;  /* special drive cmds not supported */
+#endif
+	rq->errors = 0;
+	rq->rq_status = RQ_ACTIVE;
+	rq->rq_dev = mk_kdev(major,(drive->select.b.unit)<<PARTN_BITS);
+	if (action == ide_wait)
+		rq->waiting = &wait;
+
+	spin_lock_irqsave(drive->channel->lock, flags);
+
+	if (blk_queue_empty(&drive->queue) || action == ide_preempt) {
+		if (action == ide_preempt)
+			drive->rq = NULL;
+	} else {
+		if (action == ide_wait)
+			queue_head = queue_head->prev;
+		else
+			queue_head = queue_head->next;
+	}
+	q->elevator.elevator_add_req_fn(q, rq, queue_head);
+
+	do_ide_request(q);
+
+	spin_unlock_irqrestore(drive->channel->lock, flags);
+
+	if (action == ide_wait) {
+		wait_for_completion(&wait);	/* wait for it to be serviced */
+		return rq->errors ? -EIO : 0;	/* return -EIO if errors */
+	}
+
+	return 0;
+
+}
+
 int ide_raw_taskfile(struct ata_device *drive, struct ata_taskfile *args)
 {
 	struct request rq;
@@ -839,12 +911,59 @@
  * interface.
  */
 
+/*
+ * Backside of HDIO_DRIVE_CMD call of SETFEATURES_XFER.
+ * 1 : Safe to update drive->id DMA registers.
+ * 0 : OOPs not allowed.
+ */
+static int set_transfer(struct ata_device *drive, struct ata_taskfile *args)
+{
+	if ((args->taskfile.command == WIN_SETFEATURES) &&
+	    (args->taskfile.sector_number >= XFER_SW_DMA_0) &&
+	    (args->taskfile.feature == SETFEATURES_XFER) &&
+	    (drive->id->dma_ultra ||
+	     drive->id->dma_mword ||
+	     drive->id->dma_1word))
+		return 1;
+
+	return 0;
+}
+
+/*
+ * Verify that we are doing an approved SETFEATURES_XFER with respect
+ * to the hardware being able to support request.  Since some hardware
+ * can improperly report capabilties, we check to see if the host adapter
+ * in combination with the device (usually a disk) properly detect
+ * and acknowledge each end of the ribbon.
+ */
+static int ata66_check(struct ata_device *drive, struct ata_taskfile *args)
+{
+	if ((args->taskfile.command == WIN_SETFEATURES) &&
+	    (args->taskfile.sector_number > XFER_UDMA_2) &&
+	    (args->taskfile.feature == SETFEATURES_XFER)) {
+		if (!drive->channel->udma_four) {
+			printk("%s: Speed warnings UDMA 3/4/5 is not functional.\n", drive->channel->name);
+			return 1;
+		}
+#ifndef CONFIG_IDEDMA_IVB
+		if ((drive->id->hw_config & 0x6000) == 0) {
+#else
+		if (((drive->id->hw_config & 0x2000) == 0) ||
+		    ((drive->id->hw_config & 0x4000) == 0)) {
+#endif
+			printk("%s: Speed warnings UDMA 3/4/5 is not functional.\n", drive->name);
+			return 1;
+		}
+	}
+	return 0;
+}
+
 int ide_cmd_ioctl(struct ata_device *drive, unsigned long arg)
 {
 	int err = 0;
 	u8 vals[4];
 	u8 *argbuf = vals;
-	u8 xfer_rate = 0;
+	u8 pio = 0;
 	int argsize = 4;
 	struct ata_taskfile args;
 	struct request rq;
@@ -879,10 +998,11 @@
 	}
 
 	/* Always make sure the transfer reate has been setup.
+	 * FIXME: what about setting up the drive with ->tuneproc?
 	 */
 	if (set_transfer(drive, &args)) {
-		xfer_rate = vals[1];
-		if (ide_ata66_check(drive, &args))
+		pio = vals[1];
+		if (ata66_check(drive, &args))
 			goto abort;
 	}
 
@@ -891,10 +1011,11 @@
 	rq.buffer = argbuf;
 	err = ide_do_drive_cmd(drive, &rq, ide_wait);
 
-	if (!err && xfer_rate) {
+	if (!err && pio) {
 		/* active-retuning-calls future */
-		if ((drive->channel->speedproc) != NULL)
-			drive->channel->speedproc(drive, xfer_rate);
+		/* FIXME: what about the setup for the drive?! */
+		if (drive->channel->speedproc)
+			drive->channel->speedproc(drive, pio);
 		ide_driveid_update(drive);
 	}
 
@@ -916,6 +1037,8 @@
 EXPORT_SYMBOL(ata_taskfile);
 EXPORT_SYMBOL(recal_intr);
 EXPORT_SYMBOL(task_no_data_intr);
+EXPORT_SYMBOL(ide_init_drive_cmd);
+EXPORT_SYMBOL(ide_do_drive_cmd);
 EXPORT_SYMBOL(ide_raw_taskfile);
 EXPORT_SYMBOL(ide_cmd_type_parser);
 EXPORT_SYMBOL(ide_cmd_ioctl);
diff -urN linux-2.5.15/drivers/ide/Makefile linux/drivers/ide/Makefile
--- linux-2.5.15/drivers/ide/Makefile	2002-05-10 00:21:51.000000000 +0200
+++ linux/drivers/ide/Makefile	2002-05-14 04:11:02.000000000 +0200
@@ -54,7 +54,6 @@
 ide-obj-$(CONFIG_BLK_DEV_SVWKS)		+= serverworks.o
 ide-obj-$(CONFIG_BLK_DEV_PDC202XX)	+= pdc202xx.o
 ide-obj-$(CONFIG_BLK_DEV_PDC4030)	+= pdc4030.o
-ide-obj-$(CONFIG_BLK_DEV_PDC_ADMA)	+= pdcadma.o
 ide-obj-$(CONFIG_BLK_DEV_PIIX)		+= piix.o
 ide-obj-$(CONFIG_BLK_DEV_QD65XX)	+= qd65xx.o
 ide-obj-$(CONFIG_BLK_DEV_IDE_RAPIDE)	+= rapide.o
@@ -72,6 +71,6 @@
 obj-$(CONFIG_BLK_DEV_ATARAID_PDC)	+= pdcraid.o
 obj-$(CONFIG_BLK_DEV_ATARAID_HPT)	+= hptraid.o
 
-ide-mod-objs		:= ide-taskfile.o ide.o ide-probe.o ide-geometry.o ide-features.o ata-timing.o $(ide-obj-y)
+ide-mod-objs	:= ide-taskfile.o ide.o ide-probe.o ide-geometry.o ide-features.o ata-timing.o $(ide-obj-y)
 
 include $(TOPDIR)/Rules.make
diff -urN linux-2.5.15/drivers/ide/pcihost.h linux/drivers/ide/pcihost.h
--- linux-2.5.15/drivers/ide/pcihost.h	2002-05-10 00:21:38.000000000 +0200
+++ linux/drivers/ide/pcihost.h	2002-05-14 04:10:46.000000000 +0200
@@ -72,9 +72,6 @@
 #ifdef CONFIG_BLK_DEV_AMD74XX
 extern int init_amd74xx(void);
 #endif
-#ifdef CONFIG_BLK_DEV_PDC_ADMA
-extern int init_pdcadma(void);
-#endif
 #ifdef CONFIG_BLK_DEV_SVWKS
 extern int init_svwks(void);
 #endif
diff -urN linux-2.5.15/drivers/ide/pdc4030.c linux/drivers/ide/pdc4030.c
--- linux-2.5.15/drivers/ide/pdc4030.c	2002-05-14 04:22:37.000000000 +0200
+++ linux/drivers/ide/pdc4030.c	2002-05-14 03:11:56.000000000 +0200
@@ -316,8 +316,7 @@
 	memcpy(hwif2->io_ports, hwif->hw.io_ports, sizeof(hwif2->io_ports));
 	hwif2->irq = hwif->irq;
 	hwif2->hw.irq = hwif->hw.irq = hwif->irq;
-	hwif->io_32bit = 3;
-	hwif2->io_32bit = 3;
+	hwif->io_32bit = hwif2->io_32bit = 1;
 	for (i=0; i<2 ; i++) {
 		if (!ident.current_tm[i].cyl)
 			hwif->drives[i].noprobe = 1;
diff -urN linux-2.5.15/drivers/ide/pdcadma.c linux/drivers/ide/pdcadma.c
--- linux-2.5.15/drivers/ide/pdcadma.c	2002-05-10 00:22:52.000000000 +0200
+++ linux/drivers/ide/pdcadma.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,128 +0,0 @@
-/*
- * linux/drivers/ide/pdcadma.c		Version 0.01	June 21, 2001
- *
- * Copyright (C) 1999-2000		Andre Hedrick <andre@linux-ide.org>
- * May be copied or modified under the terms of the GNU General Public License
- *
- */
-
-#include <linux/config.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/delay.h>
-#include <linux/timer.h>
-#include <linux/mm.h>
-#include <linux/ioport.h>
-#include <linux/blkdev.h>
-#include <linux/hdreg.h>
-
-#include <linux/interrupt.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-#include <asm/io.h>
-#include <asm/irq.h>
-
-#include "ata-timing.h"
-#include "pcihost.h"
-
-#undef DISPLAY_PDCADMA_TIMINGS
-
-#if defined(DISPLAY_PDCADMA_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static int pdcadma_get_info(char *, char **, off_t, int);
-extern int (*pdcadma_display_info)(char *, char **, off_t, int); /* ide-proc.c */
-static struct pci_dev *bmide_dev;
-
-static int pdcadma_get_info (char *buffer, char **addr, off_t offset, int count)
-{
-	char *p = buffer;
-	u32 bibma = pci_resource_start(bmide_dev, 4);
-
-	p += sprintf(p, "\n                                PDC ADMA %04X Chipset.\n", bmide_dev->device);
-	p += sprintf(p, "UDMA\n");
-	p += sprintf(p, "PIO\n");
-
-	return p-buffer;	/* => must be less than 4k! */
-}
-#endif
-
-byte pdcadma_proc = 0;
-
-extern char *ide_xfer_verbose (byte xfer_rate);
-
-#ifdef CONFIG_BLK_DEV_IDEDMA
-
-/*
- * This initiates/aborts (U)DMA read/write operations on a drive.
- */
-static int pdcadma_dmaproc(struct ata_device *drive)
-{
-	udma_enable(drive, 0, 0);
-
-	return 0;
-}
-#endif
-
-static unsigned int __init pci_init_pdcadma(struct pci_dev *dev)
-{
-#if defined(DISPLAY_PDCADMA_TIMINGS) && defined(CONFIG_PROC_FS)
-	if (!pdcadma_proc) {
-		pdcadma_proc = 1;
-		bmide_dev = dev;
-		pdcadma_display_info = pdcadma_get_info;
-	}
-#endif
-	return 0;
-}
-
-static unsigned int __init ata66_pdcadma(struct ata_channel *channel)
-{
-	return 1;
-}
-
-static void __init ide_init_pdcadma(struct ata_channel *hwif)
-{
-	hwif->autodma = 0;
-	hwif->dma_base = 0;
-
-//	hwif->tuneproc = &pdcadma_tune_drive;
-//	hwif->speedproc = &pdcadma_tune_chipset;
-
-//	if (hwif->dma_base) {
-//		hwif->XXX_dmaproc = &pdcadma_dmaproc;
-//		hwif->autodma = 1;
-//	}
-}
-
-static void __init ide_dmacapable_pdcadma(struct ata_channel *hwif, unsigned long dmabase)
-{
-//	ide_setup_dma(hwif, dmabase, 8);
-}
-
-
-/* module data table */
-static struct ata_pci_device chipset __initdata = {
-	PCI_VENDOR_ID_PDC, PCI_DEVICE_ID_PDC_1841,
-	pci_init_pdcadma,
-	ata66_pdcadma,
-	ide_init_pdcadma,
-	ide_dmacapable_pdcadma,
-	{
-		{0x00,0x00,0x00},
-		{0x00,0x00,0x00}
-	},
-	OFF_BOARD,
-	0,
-	ATA_F_NODMA
-};
-
-int __init init_pdcadma(void)
-{
-	ata_register_chipset(&chipset);
-
-        return 0;
-}
diff -urN linux-2.5.15/drivers/ide/tcq.c linux/drivers/ide/tcq.c
--- linux-2.5.15/drivers/ide/tcq.c	2002-05-14 04:22:37.000000000 +0200
+++ linux/drivers/ide/tcq.c	2002-05-14 02:22:11.000000000 +0200
@@ -90,7 +90,7 @@
 
 	printk(KERN_INFO "ATA: %s: invalidating pending queue (%d)\n", drive->name, ata_pending_commands(drive));
 
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(ch->lock, flags);
 
 	del_timer(&ch->timer);
 
@@ -144,7 +144,7 @@
 	 * start doing stuff again
 	 */
 	q->request_fn(q);
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(ch->lock, flags);
 	printk(KERN_DEBUG "ATA: tcq_invalidate_queue: done\n");
 }
 
@@ -156,14 +156,14 @@
 
 	printk(KERN_ERR "ATA: %s: timeout waiting for interrupt...\n", __FUNCTION__);
 
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(ch->lock, flags);
 
 	if (test_and_set_bit(IDE_BUSY, &ch->active))
 		printk(KERN_ERR "ATA: %s: IRQ handler not busy\n", __FUNCTION__);
 	if (!ch->handler)
 		printk(KERN_ERR "ATA: %s: missing ISR!\n", __FUNCTION__);
 
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(ch->lock, flags);
 
 	/*
 	 * if pending commands, try service before giving up
@@ -181,7 +181,7 @@
 	struct ata_channel *ch = drive->channel;
 	unsigned long flags;
 
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(ch->lock, flags);
 
 	/*
 	 * always just bump the timer for now, the timeout handling will
@@ -196,7 +196,7 @@
 	mod_timer(&ch->timer, jiffies + 5 * HZ);
 	ch->handler = handler;
 
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(ch->lock, flags);
 }
 
 /*
diff -urN linux-2.5.15/drivers/scsi/ide-scsi.c linux/drivers/scsi/ide-scsi.c
--- linux-2.5.15/drivers/scsi/ide-scsi.c	2002-05-14 00:50:21.000000000 +0200
+++ linux/drivers/scsi/ide-scsi.c	2002-05-14 03:54:24.000000000 +0200
@@ -792,18 +792,6 @@
  */
 int idescsi_device_reset (Scsi_Cmnd *cmd)
 {
-#if 0
-	ide_drive_t *drive = idescsi_drives[cmd->target];
-        struct request req;
-
-        ide_init_drive_cmd(&req);
-        req.flags = REQ_SPECIAL;
-
-	/* FIX ME, the next executable line causes on oops in lk 2.5.10-dj1
-	 * [code copied from ide-cd's ide_cdrom_reset(), does it work?]
-	 */
-        ide_do_drive_cmd(drive, &req, ide_wait);
-#endif
 	return SUCCESS;
 }
 
diff -urN linux-2.5.15/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.15/include/linux/ide.h	2002-05-14 04:22:38.000000000 +0200
+++ linux/include/linux/ide.h	2002-05-14 03:38:06.000000000 +0200
@@ -449,19 +449,20 @@
 	spinlock_t *lock;
 
 	ide_startstop_t (*handler)(struct ata_device *, struct request *);	/* irq handler, if active */
-	struct timer_list timer;	/* failsafe timer */
+	struct timer_list timer;				/* failsafe timer */
 	int (*expiry)(struct ata_device *, struct request *);	/* irq handler, if active */
-	unsigned long poll_timeout;	/* timeout value during polled operations */
-	struct ata_device *drive;	/* last serviced drive */
+	unsigned long poll_timeout;				/* timeout value during polled operations */
+	struct ata_device *drive;				/* last serviced drive */
+
 	unsigned long active;		/* active processing request */
 
-	ide_ioreg_t	io_ports[IDE_NR_PORTS];	/* task file registers */
-	hw_regs_t	hw;		/* Hardware info */
+	ide_ioreg_t io_ports[IDE_NR_PORTS];	/* task file registers */
+	hw_regs_t hw;				/* hardware info */
 #ifdef CONFIG_PCI
-	struct pci_dev	*pci_dev;	/* for pci chipsets */
+	struct pci_dev *pci_dev;		/* for pci chipsets */
 #endif
 	struct ata_device drives[MAX_DRIVES];	/* drive info */
-	struct gendisk	*gd;		/* gendisk structure */
+	struct gendisk *gd;			/* gendisk structure */
 
 	/*
 	 * Routines to tune PIO and DMA mode for drives.
@@ -469,7 +470,11 @@
 	 * A value of 255 indicates that the function should choose the optimal
 	 * mode itself.
 	 */
+
+	/* setup disk on a channel for a particular transfer mode */
 	void (*tuneproc) (struct ata_device *, byte pio);
+
+	/* setup the chipset timing for a particular transfer mode */
 	int (*speedproc) (struct ata_device *, byte pio);
 
 	/* tweaks hardware to select drive */
@@ -487,6 +492,9 @@
 	/* check host's drive quirk list */
 	int (*quirkproc) (struct ata_device *);
 
+	/* driver soft-power interface */
+	int (*busproc)(struct ata_device *, int);
+
 	/* CPU-polled transfer routines */
 	void (*ata_read)(struct ata_device *, void *, unsigned int);
 	void (*ata_write)(struct ata_device *, void *, unsigned int);
@@ -535,17 +543,14 @@
 	unsigned no_io_32bit	: 1;	/* disallow enabling 32bit I/O */
 	unsigned no_unmask	: 1;	/* disallow setting unmask bit */
 	unsigned auto_poll	: 1;	/* supports nop auto-poll */
-	byte		io_32bit;	/* 0=16-bit, 1=32-bit, 2/3=32bit+sync */
-	byte		unmask;		/* flag: okay to unmask other irqs */
-	byte		slow;		/* flag: slow data port */
+	unsigned unmask		: 1;	/* flag: okay to unmask other irqs */
+	unsigned slow		: 1;	/* flag: slow data port */
+	unsigned io_32bit	: 1;	/* 0=16-bit, 1=32-bit */
+	unsigned char bus_state;	/* power state of the IDE bus */
 
 #if (DISK_RECOVERY_TIME > 0)
-	unsigned long	last_time;	/* time when previous rq was done */
+	unsigned long last_time;	/* time when previous rq was done */
 #endif
-	/* driver soft-power interface */
-	int (*busproc)(struct ata_device *, int);
-
-	byte		bus_state;	/* power state of the IDE bus */
 };
 
 /*
@@ -656,12 +661,6 @@
 		const char *, byte);
 
 /*
- * Issue a simple drive command
- * The drive must be selected beforehand.
- */
-void ide_cmd(struct ata_device *, byte, byte, ata_handler_t);
-
-/*
  * ide_fixstring() cleans up and (optionally) byte-swaps a text string,
  * removing leading/trailing blanks and compressing internal blanks.
  * It is primarily used to tidy up the model name/number fields as
@@ -710,7 +709,6 @@
  */
 typedef enum {
 	ide_wait,	/* insert rq at end of list, and wait for it */
-	ide_next,	/* insert rq immediately after current request */
 	ide_preempt,	/* insert rq in front of current request */
 	ide_end		/* insert rq at end of list, but don't wait for it */
 } ide_action_t;
@@ -760,13 +758,10 @@
 
 void ide_delay_50ms(void);
 
-extern byte ide_auto_reduce_xfer(struct ata_device *);
 extern void ide_fix_driveid(struct hd_driveid *id);
 extern int ide_driveid_update(struct ata_device *);
-extern int ide_ata66_check(struct ata_device *, struct ata_taskfile *);
 extern int ide_config_drive_speed(struct ata_device *, byte);
 extern byte eighty_ninty_three(struct ata_device *);
-extern int set_transfer(struct ata_device *, struct ata_taskfile *);
 
 extern int system_bus_speed;
 

--------------010406000104080301020806--

