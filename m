Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313112AbSC1J0F>; Thu, 28 Mar 2002 04:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313115AbSC1JZw>; Thu, 28 Mar 2002 04:25:52 -0500
Received: from [195.63.194.11] ([195.63.194.11]:18187 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313113AbSC1JZb>; Thu, 28 Mar 2002 04:25:31 -0500
Message-ID: <3CA2E129.7040706@evision-ventures.com>
Date: Thu, 28 Mar 2002 10:23:53 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PATCH 2.5.7 IDE 24
In-Reply-To: <Pine.LNX.4.33.0203181243210.10517-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------000906000603020409070307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000906000603020409070307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Tue Mar 19 22:39:10 CET 2002 ide-clean-24

- Push BAD_DMA_DRIVE and GOOD_DMA_DRIVE to the ide-pmac.c file, since this is
   the only place where those get used.

- Kill unused fields from the ide_task_s structure. In esp. we pass a task
   attached to a request and not the other way around!

- Rename hwif field to channel in struct ide_drive_s.

- Move the request queue to the level where proper serialization has to happen
   anyway - the channel structure.

--------------000906000603020409070307
Content-Type: text/plain;
 name="ide-clean-24.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-24.diff"

diff -urN linux-2.5.7/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.7/drivers/ide/ide-disk.c	Wed Mar 20 01:32:05 2002
+++ linux/drivers/ide/ide-disk.c	Wed Mar 20 00:20:27 2002
@@ -189,8 +189,6 @@
 	memcpy(args.tfRegister, &taskfile, sizeof(struct hd_drive_task_hdr));
 	memcpy(args.hobRegister, &hobfile, sizeof(struct hd_drive_hob_hdr));
 	ide_cmd_type_parser(&args);
-	args.rq	= rq;
-	args.block = block;
 	rq->special = &args;
 
 	return ata_taskfile(drive,
@@ -198,7 +196,7 @@
 			(struct hd_drive_hob_hdr *) &args.hobRegister,
 			args.handler,
 			args.prehandler,
-			args.rq);
+			rq);
 }
 
 static ide_startstop_t lba28_do_request(ide_drive_t *drive, struct request *rq, unsigned long block)
@@ -235,8 +233,6 @@
 	memcpy(args.tfRegister, &taskfile, sizeof(struct hd_drive_task_hdr));
 	memcpy(args.hobRegister, &hobfile, sizeof(struct hd_drive_hob_hdr));
 	ide_cmd_type_parser(&args);
-	args.rq = rq;
-	args.block = block;
 	rq->special = &args;
 
 	return ata_taskfile(drive,
@@ -244,7 +240,7 @@
 			(struct hd_drive_hob_hdr *) &args.hobRegister,
 			args.handler,
 			args.prehandler,
-			args.rq);
+			rq);
 }
 
 /*
@@ -298,8 +294,6 @@
 	memcpy(args.tfRegister, &taskfile, sizeof(struct hd_drive_task_hdr));
 	memcpy(args.hobRegister, &hobfile, sizeof(struct hd_drive_hob_hdr));
 	ide_cmd_type_parser(&args);
-	args.rq = rq;
-	args.block = block;
 	rq->special = &args;
 
 	return ata_taskfile(drive,
@@ -307,7 +301,7 @@
 			(struct hd_drive_hob_hdr *) &args.hobRegister,
 			args.handler,
 			args.prehandler,
-			args.rq);
+			rq);
 }
 
 /*
diff -urN linux-2.5.7/drivers/ide/ide-pmac.c linux/drivers/ide/ide-pmac.c
--- linux-2.5.7/drivers/ide/ide-pmac.c	Mon Mar 18 21:37:17 2002
+++ linux/drivers/ide/ide-pmac.c	Tue Mar 19 22:38:11 2002
@@ -71,6 +71,9 @@
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
 
+# define BAD_DMA_DRIVE		0
+# define GOOD_DMA_DRIVE		1
+
 typedef struct {
 	int	accessTime;
 	int	cycleTime;
diff -urN linux-2.5.7/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.7/drivers/ide/ide-taskfile.c	Wed Mar 20 01:32:05 2002
+++ linux/drivers/ide/ide-taskfile.c	Tue Mar 19 23:59:50 2002
@@ -927,7 +927,7 @@
 /*
  * This function is intended to be used prior to invoking ide_do_drive_cmd().
  */
-static void ide_init_drive_taskfile (struct request *rq)
+static void init_taskfile_request(struct request *rq)
 {
 	memset(rq, 0, sizeof(*rq));
 	rq->flags = REQ_DRIVE_TASKFILE;
@@ -935,11 +935,12 @@
 
 /*
  * This is kept for internal use only !!!
- * This is an internal call and nobody in user-space has a damn
+ * This is an internal call and nobody in user-space has a
  * reason to call this taskfile.
  *
  * ide_raw_taskfile is the one that user-space executes.
  */
+
 int ide_wait_taskfile(ide_drive_t *drive, struct hd_drive_task_hdr *taskfile, struct hd_drive_hob_hdr *hobfile, byte *buf)
 {
 	struct request rq;
@@ -965,7 +966,8 @@
 	args.hobRegister[IDE_SELECT_OFFSET_HOB]  = hobfile->device_head;
 	args.hobRegister[IDE_CONTROL_OFFSET_HOB] = hobfile->control;
 
-	ide_init_drive_taskfile(&rq);
+	init_taskfile_request(&rq);
+
 	/* This is kept for internal use only !!! */
 	ide_cmd_type_parser(&args);
 	if (args.command_type != IDE_DRIVE_TASK_NO_DATA)
@@ -973,59 +975,26 @@
 
 	rq.buffer = buf;
 	rq.special = &args;
+
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
 
 int ide_raw_taskfile(ide_drive_t *drive, ide_task_t *args, byte *buf)
 {
 	struct request rq;
-	ide_init_drive_taskfile(&rq);
+	init_taskfile_request(&rq);
 	rq.buffer = buf;
 
 	if (args->command_type != IDE_DRIVE_TASK_NO_DATA)
 		rq.current_nr_sectors = rq.nr_sectors = (args->hobRegister[IDE_NSECTOR_OFFSET_HOB] << 8) | args->tfRegister[IDE_NSECTOR_OFFSET];
 
 	rq.special = args;
+
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
 
 /*
- *  The taskfile glue table
- *
- *  reqtask.data_phase	reqtask.req_cmd
- *			args.command_type		args.handler
- *
- *  TASKFILE_P_OUT_DMAQ	??				??
- *  TASKFILE_P_IN_DMAQ	??				??
- *  TASKFILE_P_OUT_DMA	??				??
- *  TASKFILE_P_IN_DMA	??				??
- *  TASKFILE_P_OUT	??				??
- *  TASKFILE_P_IN	??				??
- *
- *  TASKFILE_OUT_DMAQ	IDE_DRIVE_TASK_RAW_WRITE	NULL
- *  TASKFILE_IN_DMAQ	IDE_DRIVE_TASK_IN		NULL
- *
- *  TASKFILE_OUT_DMA	IDE_DRIVE_TASK_RAW_WRITE	NULL
- *  TASKFILE_IN_DMA	IDE_DRIVE_TASK_IN		NULL
- *
- *  TASKFILE_IN_OUT	??				??
- *
- *  TASKFILE_MULTI_OUT	IDE_DRIVE_TASK_RAW_WRITE	task_mulout_intr
- *  TASKFILE_MULTI_IN	IDE_DRIVE_TASK_IN		task_mulin_intr
- *
- *  TASKFILE_OUT	IDE_DRIVE_TASK_RAW_WRITE	task_out_intr
- *  TASKFILE_OUT	IDE_DRIVE_TASK_OUT		task_out_intr
- *
- *  TASKFILE_IN		IDE_DRIVE_TASK_IN		task_in_intr
- *  TASKFILE_NO_DATA	IDE_DRIVE_TASK_NO_DATA		task_no_data_intr
- *
- *			IDE_DRIVE_TASK_SET_XFER		task_no_data_intr
- *			IDE_DRIVE_TASK_INVALID
- *
- */
-
-/*
- * Issue ATA command and wait for completion. use for implementing commands in
+ * Issue ATA command and wait for completion. Use for implementing commands in
  * kernel.
  *
  * The caller has to make sure buf is never NULL!
diff -urN linux-2.5.7/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.7/drivers/ide/ide.c	Wed Mar 20 01:32:05 2002
+++ linux/drivers/ide/ide.c	Wed Mar 20 01:19:21 2002
@@ -288,7 +288,7 @@
 
 		drive->type			= ATA_DISK;
 		drive->select.all		= (unit<<4)|0xa0;
-		drive->hwif			= hwif;
+		drive->channel			= hwif;
 		drive->ctl			= 0x08;
 		drive->ready_stat		= READY_STAT;
 		drive->bad_wstat		= BAD_W_STAT;
@@ -737,11 +737,6 @@
 		ide_task_t *args = (ide_task_t *) rq->special;
 		rq->errors = !OK_STAT(stat,READY_STAT,BAD_STAT);
 		if (args) {
-			if (args->tf_in_flags.b.data) {
-				unsigned short data			= IN_WORD(IDE_DATA_REG);
-				args->tfRegister[IDE_DATA_OFFSET]	= (data) & 0xFF;
-				args->hobRegister[IDE_DATA_OFFSET_HOB]	= (data >> 8) & 0xFF;
-			}
 			args->tfRegister[IDE_ERROR_OFFSET]   = err;
 			args->tfRegister[IDE_NSECTOR_OFFSET] = IN_BYTE(IDE_NSECTOR_REG);
 			args->tfRegister[IDE_SECTOR_OFFSET]  = IN_BYTE(IDE_SECTOR_REG);
diff -urN linux-2.5.7/drivers/ide/pdc202xx.c linux/drivers/ide/pdc202xx.c
--- linux-2.5.7/drivers/ide/pdc202xx.c	Wed Mar 20 01:32:05 2002
+++ linux/drivers/ide/pdc202xx.c	Wed Mar 20 00:08:25 2002
@@ -664,6 +664,7 @@
 			OUT_BYTE(0xac, datareg);
 			break;
 		default:
+			;
 	}
 
 	if (!drive->init_speed)
diff -urN linux-2.5.7/drivers/ide/pdc4030.c linux/drivers/ide/pdc4030.c
--- linux-2.5.7/drivers/ide/pdc4030.c	Mon Mar 18 21:37:08 2002
+++ linux/drivers/ide/pdc4030.c	Wed Mar 20 00:17:41 2002
@@ -658,9 +658,6 @@
 	/* We don't use the generic inerrupt handlers here? */
 	args.prehandler		= NULL;
 	args.handler		= NULL;
-	args.rq			= rq;
-	args.block		= block;
-	rq->special		= NULL;
 	rq->special		= &args;
 
 	return do_pdc4030_io(drive, &args);
diff -urN linux-2.5.7/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.7/include/linux/ide.h	Wed Mar 20 01:32:05 2002
+++ linux/include/linux/ide.h	Wed Mar 20 01:19:34 2002
@@ -68,7 +68,7 @@
  */
 #define DMA_PIO_RETRY	1	/* retrying in PIO */
 
-#define HWIF(drive)		((drive)->hwif)
+#define HWIF(drive)		((drive)->channel)
 #define HWGROUP(drive)		(HWIF(drive)->hwgroup)
 
 /*
@@ -175,17 +175,17 @@
 #define WAIT_CMD	(10*HZ)		/* 10sec  - maximum wait for an IRQ to happen */
 #define WAIT_MIN_SLEEP	(2*HZ/100)	/* 20msec - minimum sleep time */
 
-#define SELECT_DRIVE(hwif,drive)				\
+#define SELECT_DRIVE(channel, drive)				\
 {								\
-	if (hwif->selectproc)					\
-		hwif->selectproc(drive);			\
-	OUT_BYTE((drive)->select.all, hwif->io_ports[IDE_SELECT_OFFSET]); \
+	if (channel->selectproc)				\
+		channel->selectproc(drive);			\
+	OUT_BYTE((drive)->select.all, channel->io_ports[IDE_SELECT_OFFSET]); \
 }
 
-#define SELECT_MASK(hwif,drive,mask)				\
+#define SELECT_MASK(channel, drive, mask)			\
 {								\
-	if (hwif->maskproc)					\
-		hwif->maskproc(drive,mask);			\
+	if (channel->maskproc)					\
+		channel->maskproc(drive,mask);			\
 }
 
 /*
@@ -235,7 +235,6 @@
 	int		irq;			/* our irq number */
 	int		dma;			/* our dma entry */
 	ide_ack_intr_t	*ack_intr;		/* acknowledge interrupt */
-	void		*priv;			/* interface specific data */
 	hwif_chipset_t  chipset;
 } hw_regs_t;
 
@@ -291,6 +290,8 @@
 struct ide_settings_s;
 
 typedef struct ide_drive_s {
+	struct hwif_s   *channel;	/* parent pointer to the channel we are attached to  */
+
 	unsigned int	usage;		/* current "open()" count for drive */
 	char type; /* distingiush different devices: disk, cdrom, tape, floppy, ... */
 
@@ -339,8 +340,8 @@
 	byte		ctl;		/* "normal" value for IDE_CONTROL_REG */
 	byte		ready_stat;	/* min status value for drive ready */
 	byte		mult_count;	/* current multiple sector setting */
-	byte 		mult_req;	/* requested multiple sector setting */
-	byte 		tune_req;	/* requested drive tuning setting */
+	byte		mult_req;	/* requested multiple sector setting */
+	byte		tune_req;	/* requested drive tuning setting */
 	byte		io_32bit;	/* 0=16-bit, 1=32-bit, 2/3=32bit+sync */
 	byte		bad_wstat;	/* used for ignoring WRERR_STAT */
 	byte		nowerr;		/* used for ignoring WRERR_STAT */
@@ -354,20 +355,25 @@
 	unsigned long	capacity;	/* total number of sectors */
 	unsigned long long capacity48;	/* total number of sectors */
 	unsigned int	drive_data;	/* for use by tuneproc/selectproc as needed */
-	struct hwif_s   *hwif;		/* parent pointer to the interface we are attached to  */
+
 	wait_queue_head_t wqueue;	/* used to wait for drive in open() */
+
 	struct hd_driveid *id;		/* drive model identification info */
 	struct hd_struct  *part;	/* drive partition table */
+
 	char		name[4];	/* drive name, such as "hda" */
 	struct ata_operations *driver;
+
 	void		*driver_data;	/* extra driver data */
 	devfs_handle_t	de;		/* directory for device */
 	struct proc_dir_entry *proc;	/* /proc/ide/ directory entry */
 	struct ide_settings_s *settings;    /* /proc/ide/ drive settings */
 	char		driver_req[10];	/* requests specific driver */
+
 	int		last_lun;	/* last logical unit */
 	int		forced_lun;	/* if hdxlun was given at boot */
 	int		lun;		/* logical unit */
+
 	int		crc_count;	/* crc counter to reduce drive speed */
 	byte		quirk_list;	/* drive is considered quirky if set for a specific host */
 	byte		suspend_reset;	/* drive suspend mode flag, soft-reset recovers */
@@ -409,7 +415,7 @@
  *
  * If it is not defined for a controller, standard-code is used from ide.c.
  *
- * Controllers which are not memory-mapped in the standard way need to 
+ * Controllers which are not memory-mapped in the standard way need to
  * override that mechanism using this function to work.
  *
  */
@@ -478,7 +484,7 @@
 	struct proc_dir_entry *proc;	/* /proc/ide/ directory entry */
 	int		irq;		/* our irq number */
 	int		major;		/* our major number */
-	char		name[80];	/* name of interface */
+	char		name[8];	/* name of interface */
 	int		index;		/* 0 for ide0; 1 for ide1; ... */
 	hwif_chipset_t	chipset;	/* sub-module for tuning.. */
 	unsigned	noprobe    : 1;	/* don't probe for this interface */
@@ -781,15 +787,9 @@
 typedef struct ide_task_s {
 	task_ioreg_t		tfRegister[8];
 	task_ioreg_t		hobRegister[8];
-	ide_reg_valid_t		tf_out_flags;
-	ide_reg_valid_t		tf_in_flags;
-	int			data_phase;
 	int			command_type;
 	ide_pre_handler_t	*prehandler;
 	ide_handler_t		*handler;
-	void			*special;	/* valid_t generally */
-	struct request		*rq;		/* copy of request */
-	unsigned long		block;		/* copy of block */
 } ide_task_t;
 
 void ata_input_data (ide_drive_t *drive, void *buffer, unsigned int wcount);
@@ -908,8 +908,6 @@
 void __init ide_scan_pcibus(int scan_direction);
 #endif
 #ifdef CONFIG_BLK_DEV_IDEDMA
-# define BAD_DMA_DRIVE		0
-# define GOOD_DMA_DRIVE		1
 int ide_build_dmatable (ide_drive_t *drive, ide_dma_action_t func);
 void ide_destroy_dmatable (ide_drive_t *drive);
 ide_startstop_t ide_dma_intr (ide_drive_t *drive);

--------------000906000603020409070307--

