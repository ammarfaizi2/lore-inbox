Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264716AbSLGTte>; Sat, 7 Dec 2002 14:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264724AbSLGTte>; Sat, 7 Dec 2002 14:49:34 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:9179 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264716AbSLGTtB>; Sat, 7 Dec 2002 14:49:01 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4.20-BK] Needed patch to build ide-scsi with new IDE -ac merge
Date: Sat, 7 Dec 2002 20:56:03 +0100
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
MIME-Version: 1.0
Message-Id: <200212072055.55152.m.c.p@wolk-project.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_F1MROUH22OUJUK3BX8KY"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_F1MROUH22OUJUK3BX8KY
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Marcelo,

$subject says it all. It's taken out of latest -ac 2.4 tree.

ciao, Marc


--------------Boundary-00=_F1MROUH22OUJUK3BX8KY
Content-Type: text/x-diff;
  charset="us-ascii";
  name="missing-ide-scsi-stuff.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="missing-ide-scsi-stuff.patch"

--- linux-2.4.20-wolk4.0-fullkernel/drivers/scsi/ide-scsi.c	2002-12-06 16:17:03.000000000 +0100
+++ linux-2.4.20-ac1/drivers/scsi/ide-scsi.c	2002-12-06 16:14:02.000000000 +0100
@@ -1,7 +1,8 @@
 /*
- * linux/drivers/scsi/ide-scsi.c	Version 0.9		Jul   4, 1999
+ * linux/drivers/scsi/ide-scsi.c	Version 0.93    June 10, 2002
  *
  * Copyright (C) 1996 - 1999 Gadi Oxman <gadio@netvision.net.il>
+ * Copyright (C) 2001 - 2002 Andre Hedrick <andre@linux-ide.org>
  */
 
 /*
@@ -27,11 +28,19 @@
  *                        detection of devices with CONFIG_SCSI_MULTI_LUN
  * Ver 0.8   Feb 05 99   Optical media need translation too. Reverse 0.7.
  * Ver 0.9   Jul 04 99   Fix a bug in SG_SET_TRANSFORM.
+ * Ver 0.91  Jan 06 02   Added 'ignore' parameter when ide-scsi is a module
+ *                        so that use of scsi emulation can be made independent
+ *                        of load order when other IDE drivers are modules.
+ *                        Chris Ebenezer <chriseb@pobox.com>
+ * Ver 0.92  Mar 21 02   Include DevFs support
+ *                        Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
+ * Ver 0.93  Jun 10 02   Fix "off by one" error in transforms
  */
 
-#define IDESCSI_VERSION "0.9"
+#define IDESCSI_VERSION "0.93"
 
 #include <linux/module.h>
+#include <linux/config.h>
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
@@ -53,76 +62,76 @@
 #include "ide-scsi.h"
 #include <scsi/sg.h>
 
-#define IDESCSI_DEBUG_LOG		0
+#define IDESCSI_DEBUG_LOG	0
 
 typedef struct idescsi_pc_s {
-	u8 c[12];				/* Actual packet bytes */
-	int request_transfer;			/* Bytes to transfer */
-	int actually_transferred;		/* Bytes actually transferred */
-	int buffer_size;			/* Size of our data buffer */
-	struct request *rq;			/* The corresponding request */
-	byte *buffer;				/* Data buffer */
-	byte *current_position;			/* Pointer into the above buffer */
-	struct scatterlist *sg;			/* Scatter gather table */
-	int b_count;				/* Bytes transferred from current entry */
-	Scsi_Cmnd *scsi_cmd;			/* SCSI command */
-	void (*done)(Scsi_Cmnd *);		/* Scsi completion routine */
-	unsigned long flags;			/* Status/Action flags */
-	unsigned long timeout;			/* Command timeout */
+	u8 c[12];			/* Actual packet bytes */
+	int request_transfer;		/* Bytes to transfer */
+	int actually_transferred;	/* Bytes actually transferred */
+	int buffer_size;		/* Size of our data buffer */
+	struct request *rq;		/* The corresponding request */
+	u8 *buffer;			/* Data buffer */
+	u8 *current_position;		/* Pointer into the above buffer */
+	struct scatterlist *sg;		/* Scatter gather table */
+	int b_count;			/* Bytes transferred from current entry */
+	Scsi_Cmnd *scsi_cmd;		/* SCSI command */
+	void (*done)(Scsi_Cmnd *);	/* Scsi completion routine */
+	unsigned long flags;		/* Status/Action flags */
+	unsigned long timeout;		/* Command timeout */
 } idescsi_pc_t;
 
 /*
  *	Packet command status bits.
  */
-#define PC_DMA_IN_PROGRESS		0	/* 1 while DMA in progress */
-#define PC_WRITING			1	/* Data direction */
-#define PC_TRANSFORM			2	/* transform SCSI commands */
+#define PC_DMA_IN_PROGRESS	0	/* 1 while DMA in progress */
+#define PC_WRITING		1	/* Data direction */
+#define PC_TRANSFORM		2	/* transform SCSI commands */
 
 /*
  *	SCSI command transformation layer
  */
-#define IDESCSI_TRANSFORM		0	/* Enable/Disable transformation */
-#define IDESCSI_SG_TRANSFORM		1	/* /dev/sg transformation */
+#define IDESCSI_TRANSFORM	0	/* Enable/Disable transformation */
+#define IDESCSI_SG_TRANSFORM	1	/* /dev/sg transformation */
 
 /*
  *	Log flags
  */
-#define IDESCSI_LOG_CMD			0	/* Log SCSI commands */
+#define IDESCSI_LOG_CMD		0	/* Log SCSI commands */
+
+#define IDESCSI_DEVFS
 
 typedef struct {
 	ide_drive_t *drive;
-	idescsi_pc_t *pc;			/* Current packet command */
-	unsigned long flags;			/* Status/Action flags */
-	unsigned long transform;		/* SCSI cmd translation layer */
-	unsigned long log;			/* log flags */
+	idescsi_pc_t *pc;		/* Current packet command */
+	unsigned long flags;		/* Status/Action flags */
+	unsigned long transform;	/* SCSI cmd translation layer */
+	unsigned long log;		/* log flags */
+	int id;				/* id */
+#ifdef IDESCSI_DEVFS
+	devfs_handle_t de;		/* pointer to IDE device */
+#endif /* IDESCSI_DEVFS */
 } idescsi_scsi_t;
 
 /*
  *	Per ATAPI device status bits.
  */
-#define IDESCSI_DRQ_INTERRUPT		0	/* DRQ interrupt device */
+#define IDESCSI_DRQ_INTERRUPT	0	/* DRQ interrupt device */
 
 /*
  *	ide-scsi requests.
  */
-#define IDESCSI_PC_RQ			90
-
-/*
- *	Bits of the interrupt reason register.
- */
-#define IDESCSI_IREASON_COD	0x1		/* Information transferred is command */
-#define IDESCSI_IREASON_IO	0x2		/* The device requests us to read */
+#define IDESCSI_PC_RQ		90
 
 static void idescsi_discard_data (ide_drive_t *drive, unsigned int bcount)
 {
 	while (bcount--)
-		IN_BYTE (IDE_DATA_REG);
+		(void) HWIF(drive)->INB(IDE_DATA_REG);
 }
 
 static void idescsi_output_zeros (ide_drive_t *drive, unsigned int bcount)
 {
 	while (bcount--)
-		OUT_BYTE (0, IDE_DATA_REG);
+		HWIF(drive)->OUTB(0, IDE_DATA_REG);
 }
 
 /*
@@ -134,13 +143,15 @@
 
 	while (bcount) {
 		if (pc->sg - (struct scatterlist *) pc->scsi_cmd->request_buffer > pc->scsi_cmd->use_sg) {
-			printk (KERN_ERR "ide-scsi: scatter gather table too small, discarding data\n");
-			idescsi_discard_data (drive, bcount);
+			printk(KERN_ERR "ide-scsi: scatter gather "
+				"table too small, discarding data\n");
+			idescsi_discard_data(drive, bcount);
 			return;
 		}
-		count = IDE_MIN (pc->sg->length - pc->b_count, bcount);
-		atapi_input_bytes (drive, pc->sg->address + pc->b_count, count);
-		bcount -= count; pc->b_count += count;
+		count = IDE_MIN(pc->sg->length - pc->b_count, bcount);
+		HWIF(drive)->atapi_input_bytes(drive, pc->sg->address + pc->b_count, count);
+		bcount -= count;
+		pc->b_count += count;
 		if (pc->b_count == pc->sg->length) {
 			pc->sg++;
 			pc->b_count = 0;
@@ -154,13 +165,15 @@
 
 	while (bcount) {
 		if (pc->sg - (struct scatterlist *) pc->scsi_cmd->request_buffer > pc->scsi_cmd->use_sg) {
-			printk (KERN_ERR "ide-scsi: scatter gather table too small, padding with zeros\n");
-			idescsi_output_zeros (drive, bcount);
+			printk(KERN_ERR "ide-scsi: scatter gather table "
+				"too small, padding with zeros\n");
+			idescsi_output_zeros(drive, bcount);
 			return;
 		}
-		count = IDE_MIN (pc->sg->length - pc->b_count, bcount);
-		atapi_output_bytes (drive, pc->sg->address + pc->b_count, count);
-		bcount -= count; pc->b_count += count;
+		count = IDE_MIN(pc->sg->length - pc->b_count, bcount);
+		HWIF(drive)->atapi_output_bytes(drive, pc->sg->address + pc->b_count, count);
+		bcount -= count;
+		pc->b_count += count;
 		if (pc->b_count == pc->sg->length) {
 			pc->sg++;
 			pc->b_count = 0;
@@ -181,26 +194,38 @@
 		return;
 	if (drive->media == ide_cdrom || drive->media == ide_optical) {
 		if (c[0] == READ_6 || c[0] == WRITE_6) {
-			c[8] = c[4];		c[5] = c[3];		c[4] = c[2];
-			c[3] = c[1] & 0x1f;	c[2] = 0;		c[1] &= 0xe0;
+			c[8] = c[4];
+			c[5] = c[3];
+			c[4] = c[2];
+			c[3] = c[1] & 0x1f;
+			c[2] = 0;
+			c[1] &= 0xe0;
 			c[0] += (READ_10 - READ_6);
 		}
 		if (c[0] == MODE_SENSE || c[0] == MODE_SELECT) {
+			unsigned short new_len;
 			if (!scsi_buf)
 				return;
 			if ((atapi_buf = kmalloc(pc->buffer_size + 4, GFP_ATOMIC)) == NULL)
 				return;
 			memset(atapi_buf, 0, pc->buffer_size + 4);
 			memset (c, 0, 12);
-			c[0] = sc[0] | 0x40;	c[1] = sc[1];		c[2] = sc[2];
-			c[8] = sc[4] + 4;	c[9] = sc[5];
-			if (sc[4] + 4 > 255)
-				c[7] = sc[4] + 4 - 255;
+			c[0] = sc[0] | 0x40;
+			c[1] = sc[1];
+			c[2] = sc[2];
+ 			new_len = sc[4] + 4;
+			c[8] = new_len;
+			c[7] = new_len >> 8;
+			c[9] = sc[5];
 			if (c[0] == MODE_SELECT_10) {
-				atapi_buf[1] = scsi_buf[0];	/* Mode data length */
-				atapi_buf[2] = scsi_buf[1];	/* Medium type */
-				atapi_buf[3] = scsi_buf[2];	/* Device specific parameter */
-				atapi_buf[7] = scsi_buf[3];	/* Block descriptor length */
+				/* Mode data length */
+				atapi_buf[1] = scsi_buf[0];
+				/* Medium type */
+				atapi_buf[2] = scsi_buf[1];
+				/* Device specific parameter */
+				atapi_buf[3] = scsi_buf[2];
+				/* Block descriptor length */
+				atapi_buf[7] = scsi_buf[3];
 				memcpy(atapi_buf + 8, scsi_buf + 4, pc->buffer_size - 4);
 			}
 			pc->buffer = atapi_buf;
@@ -220,15 +245,21 @@
 		return;
 	if (drive->media == ide_cdrom || drive->media == ide_optical) {
 		if (pc->c[0] == MODE_SENSE_10 && sc[0] == MODE_SENSE) {
-			scsi_buf[0] = atapi_buf[1];		/* Mode data length */
-			scsi_buf[1] = atapi_buf[2];		/* Medium type */
-			scsi_buf[2] = atapi_buf[3];		/* Device specific parameter */
-			scsi_buf[3] = atapi_buf[7];		/* Block descriptor length */
+			/* Mode data length */
+			scsi_buf[0] = atapi_buf[1];
+			/* Medium type */
+			scsi_buf[1] = atapi_buf[2];
+			/* Device specific parameter */
+			scsi_buf[2] = atapi_buf[3];
+			/* Block descriptor length */
+			scsi_buf[3] = atapi_buf[7];
 			memcpy(scsi_buf + 4, atapi_buf + 8, pc->request_transfer - 8);
 		}
 		if (pc->c[0] == INQUIRY) {
-			scsi_buf[2] |= 2;			/* ansi_revision */
-			scsi_buf[3] = (scsi_buf[3] & 0xf0) | 2;	/* response data format */
+			/* ansi_revision */
+			scsi_buf[2] |= 2;
+			/* response data format */
+			scsi_buf[3] = (scsi_buf[3] & 0xf0) | 2;
 		}
 	}
 	if (atapi_buf && atapi_buf != scsi_buf)
@@ -256,47 +287,83 @@
 	printk("]\n");
 }
 
-static void idescsi_end_request (byte uptodate, ide_hwgroup_t *hwgroup)
+static int idescsi_do_end_request (ide_drive_t *drive, int uptodate)
+{
+	struct request *rq;
+	unsigned long flags;
+	int ret = 1;
+
+	spin_lock_irqsave(&io_request_lock, flags);
+	rq = HWGROUP(drive)->rq;
+
+	/*
+	 * decide whether to reenable DMA -- 3 is a random magic for now,
+	 * if we DMA timeout more than 3 times, just stay in PIO
+	 */
+	if (drive->state == DMA_PIO_RETRY && drive->retry_pio <= 3) {
+		drive->state = 0;
+		HWGROUP(drive)->hwif->ide_dma_on(drive);
+	}
+
+	if (!end_that_request_first(rq, uptodate, drive->name)) {
+		add_blkdev_randomness(MAJOR(rq->rq_dev));
+		blkdev_dequeue_request(rq);
+		HWGROUP(drive)->rq = NULL;
+		end_that_request_last(rq);
+		ret = 0;
+	}
+	spin_unlock_irqrestore(&io_request_lock, flags);
+	return ret;
+}
+
+static int idescsi_end_request (ide_drive_t *drive, int uptodate)
 {
-	ide_drive_t *drive = hwgroup->drive;
 	idescsi_scsi_t *scsi = drive->driver_data;
-	struct request *rq = hwgroup->rq;
+	struct request *rq = HWGROUP(drive)->rq;
 	idescsi_pc_t *pc = (idescsi_pc_t *) rq->buffer;
 	int log = test_bit(IDESCSI_LOG_CMD, &scsi->log);
 	u8 *scsi_buf;
 	unsigned long flags;
 
 	if (rq->cmd != IDESCSI_PC_RQ) {
-		ide_end_request (uptodate, hwgroup);
-		return;
+		idescsi_do_end_request(drive, uptodate);
+		return 0;
 	}
-	ide_end_drive_cmd (drive, 0, 0);
+	ide_end_drive_cmd(drive, 0, 0);
 	if (rq->errors >= ERROR_MAX) {
 		pc->scsi_cmd->result = DID_ERROR << 16;
 		if (log)
-			printk ("ide-scsi: %s: I/O error for %lu\n", drive->name, pc->scsi_cmd->serial_number);
+			printk("ide-scsi: %s: I/O error for %lu\n",
+				drive->name, pc->scsi_cmd->serial_number);
 	} else if (rq->errors) {
 		pc->scsi_cmd->result = (CHECK_CONDITION << 1) | (DID_OK << 16);
 		if (log)
-			printk ("ide-scsi: %s: check condition for %lu\n", drive->name, pc->scsi_cmd->serial_number);
+			printk("ide-scsi: %s: check condition for %lu\n",
+				drive->name, pc->scsi_cmd->serial_number);
 	} else {
 		pc->scsi_cmd->result = DID_OK << 16;
-		idescsi_transform_pc2 (drive, pc);
+		idescsi_transform_pc2(drive, pc);
 		if (log) {
-			printk ("ide-scsi: %s: suc %lu", drive->name, pc->scsi_cmd->serial_number);
-			if (!test_bit(PC_WRITING, &pc->flags) && pc->actually_transferred && pc->actually_transferred <= 1024 && pc->buffer) {
+			printk("ide-scsi: %s: suc %lu", drive->name,
+				pc->scsi_cmd->serial_number);
+			if (!test_bit(PC_WRITING, &pc->flags) &&
+			    pc->actually_transferred &&
+			    pc->actually_transferred <= 1024 &&
+			    pc->buffer) {
 				printk(", rst = ");
 				scsi_buf = pc->scsi_cmd->request_buffer;
 				hexdump(scsi_buf, IDE_MIN(16, pc->scsi_cmd->request_bufflen));
 			} else printk("\n");
 		}
 	}
-	spin_lock_irqsave(&io_request_lock,flags);	
+	spin_lock_irqsave(&io_request_lock, flags);	
 	pc->done(pc->scsi_cmd);
-	spin_unlock_irqrestore(&io_request_lock,flags);
-	idescsi_free_bh (rq->bh);
-	kfree(pc); kfree(rq);
+	spin_unlock_irqrestore(&io_request_lock, flags);
+	idescsi_free_bh(rq->bh);
+	kfree(pc);
+	kfree(rq);
 	scsi->pc = NULL;
+	return 0;
 }
 
 static inline unsigned long get_timeout(idescsi_pc_t *pc)
@@ -310,84 +377,112 @@
 static ide_startstop_t idescsi_pc_intr (ide_drive_t *drive)
 {
 	idescsi_scsi_t *scsi = drive->driver_data;
-	byte status, ireason;
-	int bcount;
-	idescsi_pc_t *pc=scsi->pc;
+	idescsi_pc_t *pc = scsi->pc;
 	struct request *rq = pc->rq;
+	atapi_bcount_t bcount;
+	atapi_status_t status;
+	atapi_ireason_t ireason;
+	atapi_feature_t feature;
 	unsigned int temp;
 
 #if IDESCSI_DEBUG_LOG
-	printk (KERN_INFO "ide-scsi: Reached idescsi_pc_intr interrupt handler\n");
+	printk(KERN_INFO "ide-scsi: Reached idescsi_pc_intr "
+		"interrupt handler\n");
 #endif /* IDESCSI_DEBUG_LOG */
 
-	if (test_and_clear_bit (PC_DMA_IN_PROGRESS, &pc->flags)) {
+	if (test_and_clear_bit(PC_DMA_IN_PROGRESS, &pc->flags)) {
 #if IDESCSI_DEBUG_LOG
-		printk ("ide-scsi: %s: DMA complete\n", drive->name);
+		printk("ide-scsi: %s: DMA complete\n", drive->name);
 #endif /* IDESCSI_DEBUG_LOG */
-		pc->actually_transferred=pc->request_transfer;
-		(void) (HWIF(drive)->dmaproc(ide_dma_end, drive));
+		pc->actually_transferred = pc->request_transfer;
+		(void) (HWIF(drive)->ide_dma_end(drive));
 	}
 
-	status = GET_STAT();						/* Clear the interrupt */
+	feature.all = 0;
+	/* Clear the interrupt */
+	status.all = HWIF(drive)->INB(IDE_STATUS_REG);
 
-	if ((status & DRQ_STAT) == 0) {					/* No more interrupts */
+	if (!status.b.drq) {
+		/* No more interrupts */
 		if (test_bit(IDESCSI_LOG_CMD, &scsi->log))
-			printk (KERN_INFO "Packet command completed, %d bytes transferred\n", pc->actually_transferred);
-		ide__sti();
-		if (status & ERR_STAT)
+			printk(KERN_INFO "Packet command completed, %d "
+				"bytes transferred\n",
+				pc->actually_transferred);
+		local_irq_enable();
+		if (status.b.check)
 			rq->errors++;
-		idescsi_end_request (1, HWGROUP(drive));
+		idescsi_end_request(drive, 1);
 		return ide_stopped;
 	}
-	bcount = IN_BYTE (IDE_BCOUNTH_REG) << 8 | IN_BYTE (IDE_BCOUNTL_REG);
-	ireason = IN_BYTE (IDE_IREASON_REG);
 
-	if (ireason & IDESCSI_IREASON_COD) {
-		printk (KERN_ERR "ide-scsi: CoD != 0 in idescsi_pc_intr\n");
-		return ide_do_reset (drive);
-	}
-	if (ireason & IDESCSI_IREASON_IO) {
-		temp = pc->actually_transferred + bcount;
-		if ( temp > pc->request_transfer) {
+	bcount.b.low	= HWIF(drive)->INB(IDE_BCOUNTL_REG);
+	bcount.b.high	= HWIF(drive)->INB(IDE_BCOUNTH_REG);
+	ireason.all	= HWIF(drive)->INB(IDE_IREASON_REG);
+
+	if (ireason.b.cod) {
+		printk(KERN_ERR "ide-scsi: CoD != 0 in idescsi_pc_intr\n");
+		return ide_do_reset(drive);
+	}
+	if (ireason.b.io) {
+		temp = pc->actually_transferred + bcount.all;
+		if (temp > pc->request_transfer) {
 			if (temp > pc->buffer_size) {
-				printk (KERN_ERR "ide-scsi: The scsi wants to send us more data than expected - discarding data\n");
+				printk(KERN_ERR "ide-scsi: The scsi wants to "
+					"send us more data than expected "
+					"- discarding data\n");
+				printk(KERN_ERR "ide-scsi: [");
+				hexdump(pc->c, 12);
+				printk("]\n");
+				printk(KERN_ERR "ide-scsi: expected %d got %d limit %d\n",
+					pc->request_transfer, temp, pc->buffer_size);
 				temp = pc->buffer_size - pc->actually_transferred;
 				if (temp) {
 					clear_bit(PC_WRITING, &pc->flags);
 					if (pc->sg)
 						idescsi_input_buffers(drive, pc, temp);
 					else
-						atapi_input_bytes(drive, pc->current_position, temp);
-					printk(KERN_ERR "ide-scsi: transferred %d of %d bytes\n", temp, bcount);
+						HWIF(drive)->atapi_input_bytes(drive, pc->current_position, temp);
+					printk(KERN_ERR "ide-scsi: transferred %d of %d bytes\n", temp, bcount.all);
 				}
 				pc->actually_transferred += temp;
 				pc->current_position += temp;
-				idescsi_discard_data (drive,bcount - temp);
-				ide_set_handler(drive, &idescsi_pc_intr, get_timeout(pc), NULL);
+				idescsi_discard_data(drive, bcount.all - temp);
+				if (HWGROUP(drive)->handler != NULL)
+					BUG();
+				ide_set_handler(drive,
+						&idescsi_pc_intr,
+						get_timeout(pc),
+						NULL);
 				return ide_started;
 			}
 #if IDESCSI_DEBUG_LOG
-			printk (KERN_NOTICE "ide-scsi: The scsi wants to send us more data than expected - allowing transfer\n");
+			printk(KERN_NOTICE "ide-scsi: The scsi wants to send "
+				"us more data than expected - "
+				"allowing transfer\n");
 #endif /* IDESCSI_DEBUG_LOG */
 		}
 	}
-	if (ireason & IDESCSI_IREASON_IO) {
+	if (ireason.b.io) {
 		clear_bit(PC_WRITING, &pc->flags);
 		if (pc->sg)
-			idescsi_input_buffers (drive, pc, bcount);
+			idescsi_input_buffers(drive, pc, bcount.all);
 		else
-			atapi_input_bytes (drive,pc->current_position,bcount);
+			HWIF(drive)->atapi_input_bytes(drive, pc->current_position, bcount.all);
 	} else {
 		set_bit(PC_WRITING, &pc->flags);
 		if (pc->sg)
-			idescsi_output_buffers (drive, pc, bcount);
+			idescsi_output_buffers(drive, pc, bcount.all);
 		else
-			atapi_output_bytes (drive,pc->current_position,bcount);
+			HWIF(drive)->atapi_output_bytes(drive, pc->current_position, bcount.all);
 	}
-	pc->actually_transferred+=bcount;				/* Update the current position */
-	pc->current_position+=bcount;
-
-	ide_set_handler(drive, &idescsi_pc_intr, get_timeout(pc), NULL);	/* And set the interrupt handler again */
+	/* Update the current position */
+	pc->actually_transferred += bcount.all;
+	pc->current_position += bcount.all;
+
+	if (HWGROUP(drive)->handler != NULL)
+		BUG();
+	/* And set the interrupt handler again */
+	ide_set_handler(drive, &idescsi_pc_intr, get_timeout(pc), NULL);
 	return ide_started;
 }
 
@@ -395,20 +490,29 @@
 {
 	idescsi_scsi_t *scsi = drive->driver_data;
 	idescsi_pc_t *pc = scsi->pc;
-	byte ireason;
+	atapi_ireason_t ireason;
 	ide_startstop_t startstop;
 
-	if (ide_wait_stat (&startstop,drive,DRQ_STAT,BUSY_STAT,WAIT_READY)) {
-		printk (KERN_ERR "ide-scsi: Strange, packet command initiated yet DRQ isn't asserted\n");
+	if (ide_wait_stat(&startstop,drive,DRQ_STAT,BUSY_STAT,WAIT_READY)) {
+		printk(KERN_ERR "ide-scsi: Strange, packet command "
+			"initiated yet DRQ isn't asserted\n");
 		return startstop;
 	}
-	ireason = IN_BYTE (IDE_IREASON_REG);
-	if ((ireason & (IDESCSI_IREASON_IO | IDESCSI_IREASON_COD)) != IDESCSI_IREASON_COD) {
-		printk (KERN_ERR "ide-scsi: (IO,CoD) != (0,1) while issuing a packet command\n");
-		return ide_do_reset (drive);
+
+	ireason.all	= HWIF(drive)->INB(IDE_IREASON_REG);
+
+	if (!ireason.b.cod || ireason.b.io) {
+		printk(KERN_ERR "ide-scsi: (IO,CoD) != (0,1) while "
+				"issuing a packet command\n");
+		return ide_do_reset(drive);
 	}
-	ide_set_handler(drive, &idescsi_pc_intr, get_timeout(pc), NULL);	/* Set the interrupt routine */
-	atapi_output_bytes (drive, scsi->pc->c, 12);			/* Send the actual packet */
+
+	if (HWGROUP(drive)->handler != NULL)
+		BUG();
+	/* Set the interrupt routine */
+	ide_set_handler(drive, &idescsi_pc_intr, get_timeout(pc), NULL);
+	/* Send the actual packet */
+	HWIF(drive)->atapi_output_bytes(drive, scsi->pc->c, 12);
 	return ide_started;
 }
 
@@ -418,36 +522,50 @@
 static ide_startstop_t idescsi_issue_pc (ide_drive_t *drive, idescsi_pc_t *pc)
 {
 	idescsi_scsi_t *scsi = drive->driver_data;
-	int bcount;
+	atapi_feature_t feature;
+	atapi_bcount_t bcount;
 	struct request *rq = pc->rq;
-	int dma_ok = 0;
-
-	scsi->pc=pc;							/* Set the current packet command */
-	pc->actually_transferred=0;					/* We haven't transferred any data yet */
-	pc->current_position=pc->buffer;
-	bcount = IDE_MIN (pc->request_transfer, 63 * 1024);		/* Request to transfer the entire buffer at once */
 
-	if (drive->using_dma && rq->bh)
-		dma_ok=!HWIF(drive)->dmaproc(test_bit (PC_WRITING, &pc->flags) ? ide_dma_write : ide_dma_read, drive);
+	/* Set the current packet command */
+	scsi->pc = pc;
+	/* We haven't transferred any data yet */
+	pc->actually_transferred = 0;
+	pc->current_position = pc->buffer;
+	/* Request to transfer the entire buffer at once */
+	bcount.all = IDE_MIN(pc->request_transfer, 63 * 1024);
+
+	if (drive->using_dma && rq->bh) {
+		if (test_bit(PC_WRITING, &pc->flags))
+			feature.b.dma = !HWIF(drive)->ide_dma_write(drive);
+		else
+			feature.b.dma = !HWIF(drive)->ide_dma_read(drive);
+	}
 
-	SELECT_DRIVE(HWIF(drive), drive);
+	SELECT_DRIVE(drive);
 	if (IDE_CONTROL_REG)
-		OUT_BYTE (drive->ctl,IDE_CONTROL_REG);
-	OUT_BYTE (dma_ok,IDE_FEATURE_REG);
-	OUT_BYTE (bcount >> 8,IDE_BCOUNTH_REG);
-	OUT_BYTE (bcount & 0xff,IDE_BCOUNTL_REG);
-
-	if (dma_ok) {
-		set_bit (PC_DMA_IN_PROGRESS, &pc->flags);
-		(void) (HWIF(drive)->dmaproc(ide_dma_begin, drive));
-	}
-	if (test_bit (IDESCSI_DRQ_INTERRUPT, &scsi->flags)) {
-		ide_set_handler (drive, &idescsi_transfer_pc, get_timeout(pc), NULL);
-		OUT_BYTE (WIN_PACKETCMD, IDE_COMMAND_REG);		/* Issue the packet command */
+		HWIF(drive)->OUTB(drive->ctl, IDE_CONTROL_REG);
+	HWIF(drive)->OUTB(feature.all, IDE_FEATURE_REG);
+	HWIF(drive)->OUTB(bcount.b.high, IDE_BCOUNTH_REG);
+	HWIF(drive)->OUTB(bcount.b.low, IDE_BCOUNTL_REG);
+
+	if (feature.b.dma) {
+		set_bit(PC_DMA_IN_PROGRESS, &pc->flags);
+		(void) (HWIF(drive)->ide_dma_begin(drive));
+	}
+	if (test_bit(IDESCSI_DRQ_INTERRUPT, &scsi->flags)) {
+		if (HWGROUP(drive)->handler != NULL)
+			BUG();
+		ide_set_handler(drive,
+				&idescsi_transfer_pc,
+				get_timeout(pc),
+				NULL);
+		/* Issue the packet command */
+		HWIF(drive)->OUTB(WIN_PACKETCMD, IDE_COMMAND_REG);
 		return ide_started;
 	} else {
-		OUT_BYTE (WIN_PACKETCMD, IDE_COMMAND_REG);
-		return idescsi_transfer_pc (drive);
+		/* Issue the packet command */
+		HWIF(drive)->OUTB(WIN_PACKETCMD, IDE_COMMAND_REG);
+		return idescsi_transfer_pc(drive);
 	}
 }
 
@@ -457,19 +575,30 @@
 static ide_startstop_t idescsi_do_request (ide_drive_t *drive, struct request *rq, unsigned long block)
 {
 #if IDESCSI_DEBUG_LOG
-	printk (KERN_INFO "rq_status: %d, rq_dev: %u, cmd: %d, errors: %d\n",rq->rq_status,(unsigned int) rq->rq_dev,rq->cmd,rq->errors);
-	printk (KERN_INFO "sector: %ld, nr_sectors: %ld, current_nr_sectors: %ld\n",rq->sector,rq->nr_sectors,rq->current_nr_sectors);
+	printk(KERN_INFO "rq_status: %d, rq_dev: %u, cmd: %d, errors: %d\n",
+		rq->rq_status, (unsigned int) rq->rq_dev, rq->cmd, rq->errors);
+	printk(KERN_INFO "sector: %ld, nr_sectors: %ld, "
+		"current_nr_sectors: %ld\n", rq->sector,
+		rq->nr_sectors, rq->current_nr_sectors);
 #endif /* IDESCSI_DEBUG_LOG */
 
 	if (rq->cmd == IDESCSI_PC_RQ) {
-		return idescsi_issue_pc (drive, (idescsi_pc_t *) rq->buffer);
+		return idescsi_issue_pc(drive, (idescsi_pc_t *) rq->buffer);
 	}
-	printk (KERN_ERR "ide-scsi: %s: unsupported command in request queue (%x)\n", drive->name, rq->cmd);
-	idescsi_end_request (0,HWGROUP (drive));
+	printk(KERN_ERR "ide-scsi: %s: unsupported command in request "
+		"queue (%x)\n", drive->name, rq->cmd);
+	idescsi_end_request(drive, 0);
 	return ide_stopped;
 }
 
-static int idescsi_open (struct inode *inode, struct file *filp, ide_drive_t *drive)
+static int idescsi_do_ioctl (ide_drive_t *drive, struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+{
+	/* need to figure out how to parse scsi-atapi media type */
+
+	return -EINVAL;
+}
+
+static int idescsi_ide_open (struct inode *inode, struct file *filp, ide_drive_t *drive)
 {
 	MOD_INC_USE_COUNT;
 	return 0;
@@ -482,6 +611,7 @@
 
 static ide_drive_t *idescsi_drives[MAX_HWIFS * MAX_DRIVES];
 static int idescsi_initialized = 0;
+static int drive_count = 0;
 
 static void idescsi_add_settings(ide_drive_t *drive)
 {
@@ -502,34 +632,58 @@
  */
 static void idescsi_setup (ide_drive_t *drive, idescsi_scsi_t *scsi, int id)
 {
+	int minor = (drive->select.b.unit) << PARTN_BITS;
+
 	DRIVER(drive)->busy++;
 	idescsi_drives[id] = drive;
 	drive->driver_data = scsi;
 	drive->ready_stat = 0;
-	memset (scsi, 0, sizeof (idescsi_scsi_t));
+	memset(scsi, 0, sizeof(idescsi_scsi_t));
 	scsi->drive = drive;
+	scsi->id = id;
 	if (drive->id && (drive->id->config & 0x0060) == 0x20)
-		set_bit (IDESCSI_DRQ_INTERRUPT, &scsi->flags);
+		set_bit(IDESCSI_DRQ_INTERRUPT, &scsi->flags);
 	set_bit(IDESCSI_TRANSFORM, &scsi->transform);
 	clear_bit(IDESCSI_SG_TRANSFORM, &scsi->transform);
 #if IDESCSI_DEBUG_LOG
 	set_bit(IDESCSI_LOG_CMD, &scsi->log);
 #endif /* IDESCSI_DEBUG_LOG */
 	idescsi_add_settings(drive);
+#ifdef IDESCSI_DEVFS
+	scsi->de = devfs_register(drive->de, "generic", DEVFS_FL_DEFAULT,
+					HWIF(drive)->major, minor,
+					S_IFBLK | S_IRUSR | S_IWUSR,
+					ide_fops, NULL);
+#endif /* IDESCSI_DEVFS */
+	drive_count++;
+	DRIVER(drive)->busy--;
 }
 
 static int idescsi_cleanup (ide_drive_t *drive)
 {
 	idescsi_scsi_t *scsi = drive->driver_data;
 
-	if (ide_unregister_subdriver (drive))
+	if (ide_unregister_subdriver(drive)) {
+		printk("%s: %s: failed to unregister! \n",
+			__FUNCTION__, drive->name);
+		printk("%s: usage %d, busy %d, driver %p, Dbusy %d\n",
+			drive->name, drive->usage, drive->busy,
+			drive->driver, DRIVER(drive)->busy);
 		return 1;
+	}
+	idescsi_drives[scsi->id] = NULL;
+#ifdef IDESCSI_DEVFS
+	if (scsi->de)
+		devfs_unregister(scsi->de);
+#endif /* IDESCSI_DEVFS */
 	drive->driver_data = NULL;
-	kfree (scsi);
+	kfree(scsi);
+	drive_count--;
 	return 0;
 }
 
-int idescsi_reinit(ide_drive_t *drive);
+int idescsi_init(void);
+int idescsi_attach(ide_drive_t *drive);
 
 /*
  *	IDE subdriver functions, registered with ide.c
@@ -539,15 +693,23 @@
 	version:		IDESCSI_VERSION,
 	media:			ide_scsi,
 	busy:			0,
+#ifdef CONFIG_IDEDMA_ONLYDISK
+	supports_dma:		0,
+#else
 	supports_dma:		1,
+#endif
 	supports_dsc_overlap:	0,
 	cleanup:		idescsi_cleanup,
 	standby:		NULL,
+	suspend:		NULL,
+	resume:			NULL,
 	flushcache:		NULL,
 	do_request:		idescsi_do_request,
 	end_request:		idescsi_end_request,
-	ioctl:			NULL,
-	open:			idescsi_open,
+	sense:			NULL,
+	error:			NULL,
+	ioctl:			idescsi_do_ioctl,
+	open:			idescsi_ide_open,
 	release:		idescsi_ide_release,
 	media_change:		NULL,
 	revalidate:		NULL,
@@ -555,12 +717,12 @@
 	capacity:		NULL,
 	special:		NULL,
 	proc:			NULL,
-	reinit:			idescsi_reinit,
+	init:			idescsi_init,
+	attach:			idescsi_attach,
 	ata_prebuilder:		NULL,
 	atapi_prebuilder:	NULL,
 };
 
-int idescsi_init (void);
 static ide_module_t idescsi_module = {
 	IDE_DRIVER_MODULE,
 	idescsi_init,
@@ -568,51 +730,91 @@
 	NULL
 };
 
-int idescsi_reinit (ide_drive_t *drive)
+int idescsi_attach (ide_drive_t *drive)
 {
-#if 0
 	idescsi_scsi_t *scsi;
-	byte media[] = {TYPE_DISK, TYPE_TAPE, TYPE_PROCESSOR, TYPE_WORM, TYPE_ROM, TYPE_SCANNER, TYPE_MOD, 255};
-	int i, failed, id;
-
-	if (!idescsi_initialized)
-		return 0;
-	for (i = 0; i < MAX_HWIFS * MAX_DRIVES; i++)
-		idescsi_drives[i] = NULL;
+	u8 media[] = {	TYPE_DISK,		/* 0x00 */
+			TYPE_TAPE,		/* 0x01 */
+			TYPE_PRINTER,		/* 0x02 */
+			TYPE_PROCESSOR,		/* 0x03 */
+			TYPE_WORM,		/* 0x04 */
+			TYPE_ROM,		/* 0x05 */
+			TYPE_SCANNER,		/* 0x06 */
+			TYPE_MOD,		/* 0x07 */
+			255};
+	int i = 0, ret = 0, id = 0;
+//	int id = 2 * HWIF(drive)->index + drive->select.b.unit;
+//	int id = drive_count + 1;
+
+	for (id = 0; id < MAX_HWIFS*MAX_DRIVES; id++)
+		if (idescsi_drives[id] == NULL)
+			break;
+
+	printk("%s: id = %d\n", drive->name, id);
+
+	if ((!idescsi_initialized) || (drive->media == ide_disk)) {
+		printk(KERN_ERR "ide-scsi: (%sinitialized) %s: "
+				"media-type (%ssupported)\n",
+			(idescsi_initialized) ? "" : "! ",
+			drive->name,
+			(drive->media == ide_disk) ? "! " : "");
+		return (drive->media == ide_disk) ? 2 : 0;
+	}
 
 	MOD_INC_USE_COUNT;
+
 	for (i = 0; media[i] != 255; i++) {
-		failed = 0;
-		while ((drive = ide_scan_devices (media[i], idescsi_driver.name, NULL, failed++)) != NULL) {
+		if (drive->media != media[i])
+			continue;
+		else
+			break;
+	}
 
-			if ((scsi = (idescsi_scsi_t *) kmalloc (sizeof (idescsi_scsi_t), GFP_KERNEL)) == NULL) {
-				printk (KERN_ERR "ide-scsi: %s: Can't allocate a scsi structure\n", drive->name);
-				continue;
-			}
-			if (ide_register_subdriver (drive, &idescsi_driver, IDE_SUBDRIVER_VERSION)) {
-				printk (KERN_ERR "ide-scsi: %s: Failed to register the driver with ide.c\n", drive->name);
-				kfree (scsi);
-				continue;
-			}
-			for (id = 0; id < MAX_HWIFS * MAX_DRIVES && idescsi_drives[id]; id++);
-				idescsi_setup (drive, scsi, id);
-			failed--;
-		}
+	if ((scsi = (idescsi_scsi_t *) kmalloc(sizeof(idescsi_scsi_t), GFP_KERNEL)) == NULL) {
+		printk(KERN_ERR "ide-scsi: %s: Can't allocate a scsi "
+			"structure\n", drive->name);
+		ret = 1;
+		goto bye_game_over;
 	}
-	ide_register_module(&idescsi_module);
+	if (ide_register_subdriver(drive, &idescsi_driver,
+			IDE_SUBDRIVER_VERSION)) {
+		printk(KERN_ERR "ide-scsi: %s: Failed to register the "
+			"driver with ide.c\n", drive->name);
+		kfree(scsi);
+		ret = 1;
+		goto bye_game_over;
+	}
+
+	idescsi_setup(drive, scsi, id);
+
+//	scan_scsis(HBA, 1, channel, id, lun);
+bye_game_over:
 	MOD_DEC_USE_COUNT;
-#endif
-	return 0;
+	return ret;
 }
 
-/*
- *	idescsi_init will register the driver for each scsi.
- */
+#ifdef MODULE
+/* options */
+char *ignore = NULL;
+
+MODULE_PARM(ignore, "s");
+#endif
+
 int idescsi_init (void)
 {
+#ifdef CLASSIC_BUILTINS_METHOD
 	ide_drive_t *drive;
 	idescsi_scsi_t *scsi;
-	byte media[] = {TYPE_DISK, TYPE_TAPE, TYPE_PROCESSOR, TYPE_WORM, TYPE_ROM, TYPE_SCANNER, TYPE_MOD, 255};
+	u8 media[] = {  TYPE_DISK,		/* 0x00 */
+			TYPE_TAPE,		/* 0x01 */
+			TYPE_PRINTER,		/* 0x02 */
+			TYPE_PROCESSOR,		/* 0x03 */
+			TYPE_WORM,		/* 0x04 */
+			TYPE_ROM,		/* 0x05 */
+			TYPE_SCANNER,		/* 0x06 */
+			TYPE_MOD,		/* 0x07 */
+			255};
+
 	int i, failed, id;
 
 	if (idescsi_initialized)
@@ -623,22 +825,47 @@
 	MOD_INC_USE_COUNT;
 	for (i = 0; media[i] != 255; i++) {
 		failed = 0;
-		while ((drive = ide_scan_devices (media[i], idescsi_driver.name, NULL, failed++)) != NULL) {
+		while ((drive = ide_scan_devices(media[i],
+				idescsi_driver.name, NULL, failed++)) != NULL) {
+#ifdef MODULE
+			/* skip drives we were told to ignore */
+			if (ignore != NULL && strstr(ignore, drive->name)) {
+				printk("ide-scsi: ignoring drive %s\n",
+					drive->name);
+				continue;
+			}
+#endif
 
-			if ((scsi = (idescsi_scsi_t *) kmalloc (sizeof (idescsi_scsi_t), GFP_KERNEL)) == NULL) {
-				printk (KERN_ERR "ide-scsi: %s: Can't allocate a scsi structure\n", drive->name);
+		if ((scsi = (idescsi_scsi_t *) kmalloc(sizeof(idescsi_scsi_t), GFP_KERNEL)) == NULL) {
+				printk(KERN_ERR "ide-scsi: %s: Can't allocate "
+					"a scsi structure\n", drive->name);
 				continue;
 			}
-			if (ide_register_subdriver (drive, &idescsi_driver, IDE_SUBDRIVER_VERSION)) {
-				printk (KERN_ERR "ide-scsi: %s: Failed to register the driver with ide.c\n", drive->name);
-				kfree (scsi);
+			if (ide_register_subdriver(drive, &idescsi_driver,
+					IDE_SUBDRIVER_VERSION)) {
+				printk(KERN_ERR "ide-scsi: %s: Failed to "
+					"register the driver with ide.c\n",
+					drive->name);
+				kfree(scsi);
 				continue;
 			}
-			for (id = 0; id < MAX_HWIFS * MAX_DRIVES && idescsi_drives[id]; id++);
-				idescsi_setup (drive, scsi, id);
+			for (id = 0;
+				id < MAX_HWIFS*MAX_DRIVES && idescsi_drives[id];
+					id++);
+				idescsi_setup(drive, scsi, id);
 			failed--;
 		}
 	}
+#else /* ! CLASSIC_BUILTINS_METHOD */
+	int i;
+
+	if (idescsi_initialized)
+		return 0;
+	idescsi_initialized = 1;
+	for (i = 0; i < MAX_HWIFS * MAX_DRIVES; i++)
+		idescsi_drives[i] = NULL;
+	MOD_INC_USE_COUNT;
+#endif /* CLASSIC_BUILTINS_METHOD */
 	ide_register_module(&idescsi_module);
 	MOD_DEC_USE_COUNT;
 	return 0;
@@ -652,9 +879,11 @@
 
 	host_template->proc_name = "ide-scsi";
 	host = scsi_register(host_template, 0);
-	if(host == NULL)
+	if (host == NULL) {
+		printk(KERN_WARNING "%s: host failure!\n", __FUNCTION__);
 		return 0;
-		
+	}
+
 	for (id = 0; id < MAX_HWIFS * MAX_DRIVES && idescsi_drives[id]; id++)
 		last_lun = IDE_MAX(last_lun, idescsi_drives[id]->last_lun);
 	host->max_id = id;
@@ -701,32 +930,36 @@
 {
 	struct buffer_head *bh, *bhp, *first_bh;
 
-	if ((first_bh = bhp = bh = kmalloc (sizeof(struct buffer_head), GFP_ATOMIC)) == NULL)
+	if ((first_bh = bhp = bh = kmalloc(sizeof(struct buffer_head), GFP_ATOMIC)) == NULL)
 		goto abort;
-	memset (bh, 0, sizeof (struct buffer_head));
+	memset(bh, 0, sizeof(struct buffer_head));
 	bh->b_reqnext = NULL;
 	while (--count) {
-		if ((bh = kmalloc (sizeof(struct buffer_head), GFP_ATOMIC)) == NULL)
+		if ((bh = kmalloc(sizeof(struct buffer_head), GFP_ATOMIC)) == NULL)
 			goto abort;
-		memset (bh, 0, sizeof (struct buffer_head));
+		memset(bh, 0, sizeof(struct buffer_head));
 		bhp->b_reqnext = bh;
 		bhp = bh;
 		bh->b_reqnext = NULL;
 	}
 	return first_bh;
 abort:
-	idescsi_free_bh (first_bh);
+	idescsi_free_bh(first_bh);
 	return NULL;
 }
 
 static inline int idescsi_set_direction (idescsi_pc_t *pc)
 {
 	switch (pc->c[0]) {
-		case READ_6: case READ_10: case READ_12:
-			clear_bit (PC_WRITING, &pc->flags);
+		case READ_6:
+		case READ_10:
+		case READ_12:
+			clear_bit(PC_WRITING, &pc->flags);
 			return 0;
-		case WRITE_6: case WRITE_10: case WRITE_12:
-			set_bit (PC_WRITING, &pc->flags);
+		case WRITE_6:
+		case WRITE_10:
+		case WRITE_12:
+			set_bit(PC_WRITING, &pc->flags);
 			return 0;
 		default:
 			return 1;
@@ -744,12 +977,17 @@
 	if (idescsi_set_direction(pc))
 		return NULL;
 	if (segments) {
-		if ((first_bh = bh = idescsi_kmalloc_bh (segments)) == NULL)
+		if ((first_bh = bh = idescsi_kmalloc_bh(segments)) == NULL)
 			return NULL;
 #if IDESCSI_DEBUG_LOG
-		printk ("ide-scsi: %s: building DMA table, %d segments, %dkB total\n", drive->name, segments, pc->request_transfer >> 10);
+		printk("ide-scsi: %s: building DMA table, %d segments, "
+			"%dkB total\n", drive->name, segments,
+			pc->request_transfer >> 10);
 #endif /* IDESCSI_DEBUG_LOG */
 		while (segments--) {
+#if 1
+			bh->b_data = sg->address;
+#else
 			if (sg->address) {
 				bh->b_page = virt_to_page(sg->address);
 				bh->b_data = (char *) ((unsigned long) sg->address & ~PAGE_MASK);
@@ -757,7 +995,7 @@
 				bh->b_page = sg->page;
 				bh->b_data = (char *) sg->offset;
 			}
-
+#endif
 			bh->b_size = sg->length;
 			bh = bh->b_reqnext;
 			sg++;
@@ -766,10 +1004,12 @@
 		/*
 		 * non-sg requests are guarenteed not to reside in highmem /jens
 		 */
-		if ((first_bh = bh = idescsi_kmalloc_bh (1)) == NULL)
+		if ((first_bh = bh = idescsi_kmalloc_bh(1)) == NULL)
 			return NULL;
 #if IDESCSI_DEBUG_LOG
-		printk ("ide-scsi: %s: building DMA table for a single buffer (%dkB)\n", drive->name, pc->request_transfer >> 10);
+		printk("ide-scsi: %s: building DMA table for a single "
+			"buffer (%dkB)\n", drive->name,
+			pc->request_transfer >> 10);
 #endif /* IDESCSI_DEBUG_LOG */
 		bh->b_data = pc->scsi_cmd->request_buffer;
 		bh->b_size = pc->request_transfer;
@@ -794,21 +1034,22 @@
 	idescsi_pc_t *pc = NULL;
 
 	if (!drive) {
-		printk (KERN_ERR "ide-scsi: drive id %d not present\n", cmd->target);
+		printk(KERN_ERR "ide-scsi: drive id %d not present\n",
+			cmd->target);
 		goto abort;
 	}
 	scsi = drive->driver_data;
-	pc = kmalloc (sizeof (idescsi_pc_t), GFP_ATOMIC);
-	rq = kmalloc (sizeof (struct request), GFP_ATOMIC);
+	pc = kmalloc(sizeof(idescsi_pc_t), GFP_ATOMIC);
+	rq = kmalloc(sizeof(struct request), GFP_ATOMIC);
 	if (rq == NULL || pc == NULL) {
-		printk (KERN_ERR "ide-scsi: %s: out of memory\n", drive->name);
+		printk(KERN_ERR "ide-scsi: %s: out of memory\n", drive->name);
 		goto abort;
 	}
 
-	memset (pc->c, 0, 12);
+	memset(pc->c, 0, 12);
 	pc->flags = 0;
 	pc->rq = rq;
-	memcpy (pc->c, cmd->cmnd, cmd->cmd_len);
+	memcpy(pc->c, cmd->cmnd, cmd->cmd_len);
 	if (cmd->use_sg) {
 		pc->buffer = NULL;
 		pc->sg = cmd->request_buffer;
@@ -824,28 +1065,30 @@
 
 	if (should_transform(drive, cmd))
 		set_bit(PC_TRANSFORM, &pc->flags);
-	idescsi_transform_pc1 (drive, pc);
+	idescsi_transform_pc1(drive, pc);
 
 	if (test_bit(IDESCSI_LOG_CMD, &scsi->log)) {
-		printk ("ide-scsi: %s: que %lu, cmd = ", drive->name, cmd->serial_number);
+		printk("ide-scsi: %s: que %lu, cmd = ",
+			drive->name, cmd->serial_number);
 		hexdump(cmd->cmnd, cmd->cmd_len);
 		if (memcmp(pc->c, cmd->cmnd, cmd->cmd_len)) {
-			printk ("ide-scsi: %s: que %lu, tsl = ", drive->name, cmd->serial_number);
+			printk("ide-scsi: %s: que %lu, tsl = ",
+				drive->name, cmd->serial_number);
 			hexdump(pc->c, 12);
 		}
 	}
 
-	ide_init_drive_cmd (rq);
+	ide_init_drive_cmd(rq);
 	rq->buffer = (char *) pc;
-	rq->bh = idescsi_dma_bh (drive, pc);
+	rq->bh = idescsi_dma_bh(drive, pc);
 	rq->cmd = IDESCSI_PC_RQ;
 	spin_unlock_irq(&io_request_lock);
-	(void) ide_do_drive_cmd (drive, rq, ide_end);
+	(void) ide_do_drive_cmd(drive, rq, ide_end);
 	spin_lock_irq(&io_request_lock);
 	return 0;
 abort:
-	if (pc) kfree (pc);
-	if (rq) kfree (rq);
+	if (pc) kfree(pc);
+	if (rq) kfree(rq);
 	cmd->result = DID_ERROR << 16;
 	done(cmd);
 	return 0;
@@ -858,6 +1101,9 @@
 
 int idescsi_reset (Scsi_Cmnd *cmd, unsigned int resetflags)
 {
+	ide_drive_t *drive	= idescsi_drives[cmd->target];
+
+	(void) ide_do_reset(drive);
 	return SCSI_RESET_SUCCESS;
 }
 
@@ -877,24 +1123,25 @@
 
 static int __init init_idescsi_module(void)
 {
+	drive_count = 0;
 	idescsi_init();
 	idescsi_template.module = THIS_MODULE;
-	scsi_register_module (MODULE_SCSI_HA, &idescsi_template);
+	scsi_register_module(MODULE_SCSI_HA, &idescsi_template);
 	return 0;
 }
 
 static void __exit exit_idescsi_module(void)
 {
 	ide_drive_t *drive;
-	byte media[] = {TYPE_DISK, TYPE_TAPE, TYPE_PROCESSOR, TYPE_WORM, TYPE_ROM, TYPE_SCANNER, TYPE_MOD, 255};
+	u8 media[] = {TYPE_DISK, TYPE_TAPE, TYPE_PROCESSOR, TYPE_WORM, TYPE_ROM, TYPE_SCANNER, TYPE_MOD, 255};
 	int i, failed;
 
-	scsi_unregister_module (MODULE_SCSI_HA, &idescsi_template);
+	scsi_unregister_module(MODULE_SCSI_HA, &idescsi_template);
 	for (i = 0; media[i] != 255; i++) {
 		failed = 0;
-		while ((drive = ide_scan_devices (media[i], idescsi_driver.name, &idescsi_driver, failed)) != NULL)
-			if (idescsi_cleanup (drive)) {
-				printk ("%s: exit_idescsi_module() called while still busy\n", drive->name);
+		while ((drive = ide_scan_devices(media[i], idescsi_driver.name, &idescsi_driver, failed)) != NULL)
+			if (idescsi_cleanup(drive)) {
+				printk("%s: exit_idescsi_module() called while still busy\n", drive->name);
 				failed++;
 			}
 	}
--- linux-2.4.20-wolk4.0-fullkernel/drivers/scsi/ide-scsi.h	1998-04-11 00:22:21.000000000 +0200
+++ linux-2.4.20-ac1/drivers/scsi/ide-scsi.h	2002-12-06 16:14:02.000000000 +0100
@@ -16,22 +16,22 @@
 extern int idescsi_reset (Scsi_Cmnd *cmd, unsigned int resetflags);
 extern int idescsi_bios (Disk *disk, kdev_t dev, int *parm);
 
-#define IDESCSI  {								\
-	name:            "idescsi",		/* name		*/		\
-	detect:          idescsi_detect,	/* detect	*/		\
-	release:         idescsi_release,	/* release	*/		\
-	info:            idescsi_info,		/* info		*/		\
-	ioctl:           idescsi_ioctl,		/* ioctl        */		\
-	queuecommand:    idescsi_queue,		/* queuecommand */		\
-	abort:           idescsi_abort,		/* abort	*/		\
-	reset:           idescsi_reset,		/* reset	*/		\
-	bios_param:      idescsi_bios,		/* bios_param	*/		\
-	can_queue:       10,			/* can_queue	*/		\
-	this_id:         -1,			/* this_id	*/		\
-	sg_tablesize:    256,			/* sg_tablesize	*/		\
-	cmd_per_lun:     5,			/* cmd_per_lun	*/		\
-	use_clustering:  DISABLE_CLUSTERING,	/* clustering	*/		\
-	emulated:        1			/* emulated     */		\
+#define IDESCSI  {							\
+	name:            "idescsi",		/* name		*/	\
+	detect:          idescsi_detect,	/* detect	*/	\
+	release:         idescsi_release,	/* release	*/	\
+	info:            idescsi_info,		/* info		*/	\
+	ioctl:           idescsi_ioctl,		/* ioctl        */	\
+	queuecommand:    idescsi_queue,		/* queuecommand */	\
+	abort:           idescsi_abort,		/* abort	*/	\
+	reset:           idescsi_reset,		/* reset	*/	\
+	bios_param:      idescsi_bios,		/* bios_param	*/	\
+	can_queue:       10,			/* can_queue	*/	\
+	this_id:         -1,			/* this_id	*/	\
+	sg_tablesize:    256,			/* sg_tablesize	*/	\
+	cmd_per_lun:     5,			/* cmd_per_lun	*/	\
+	use_clustering:  DISABLE_CLUSTERING,	/* clustering	*/	\
+	emulated:        1			/* emulated     */	\
 }
 
 #endif /* IDESCSI_H */

--------------Boundary-00=_F1MROUH22OUJUK3BX8KY--

