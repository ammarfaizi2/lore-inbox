Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312344AbSDNO5y>; Sun, 14 Apr 2002 10:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312354AbSDNO5x>; Sun, 14 Apr 2002 10:57:53 -0400
Received: from [195.63.194.11] ([195.63.194.11]:16388 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S312344AbSDNO5v>; Sun, 14 Apr 2002 10:57:51 -0400
Message-ID: <3CB98A5C.6060407@evision-ventures.com>
Date: Sun, 14 Apr 2002 15:55:40 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.8-pre3 IDE 33
In-Reply-To: <Pine.LNX.4.33.0204051657270.16281-100000@penguin.transmeta.com> <3CB592DA.7000202@evision-ventures.com>
Content-Type: multipart/mixed;
 boundary="------------070009030303030906030100"
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070009030303030906030100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Thu Apr 11 16:42:43 CEST 2002 ide-clean-33

- Kill unneded parameters to ide_cmd_ioctl() and ide_task_ioctl().

- Apply Petr Vendrovecs fix for 32bit ver 16bit transfers.

- Make CD-ROM usable again by guarding the generic routines against request
   field abuse found there. We will try to convert this driver to the just to be
   finished struct ata_request after the generic changes stabilize a bit.
   The strcut ata_taskfile and struct ata_request merge to be more preciese.

Therefore it's time for the next patch round.

--------------070009030303030906030100
Content-Type: text/plain;
 name="ide-clean-33.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-33.diff"

diff -urN linux-2.5.8-pre3/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.8-pre3/drivers/ide/ide-cd.c	Wed Apr 10 14:38:29 2002
+++ linux/drivers/ide/ide-cd.c	Sun Apr 14 16:13:51 2002
@@ -512,7 +512,7 @@
 #endif /* not VERBOSE_IDE_CD_ERRORS */
 }
 
-static void cdrom_queue_request_sense(ide_drive_t *drive, 
+static void cdrom_queue_request_sense(ide_drive_t *drive,
 				      struct completion *wait,
 				      struct request_sense *sense,
 				      struct packet_command *failed_command)
@@ -536,7 +536,7 @@
 	rq->flags = REQ_SENSE;
 	rq->special = (char *) pc;
 	rq->waiting = wait;
-	(void) ide_do_drive_cmd(drive, rq, ide_preempt);
+	ide_do_drive_cmd(drive, rq, ide_preempt);
 }
 
 
@@ -554,6 +554,7 @@
 	if ((rq->flags & REQ_CMD) && !rq->current_nr_sectors)
 		uptodate = 1;
 
+	HWGROUP(drive)->rq->special = NULL;
 	ide_end_request(drive, uptodate);
 }
 
diff -urN linux-2.5.8-pre3/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- linux-2.5.8-pre3/drivers/ide/ide-dma.c	Fri Apr 12 00:43:19 2002
+++ linux/drivers/ide/ide-dma.c	Sun Apr 14 16:19:16 2002
@@ -546,6 +546,12 @@
 	unsigned long dma_base = hwif->dma_base;
 	struct ata_request *ar = IDE_CUR_AR(drive);
 
+	/* This can happen with drivers abusing the special request field.
+	 */
+
+	if (!ar)
+		return 1;
+
 	if (rq_data_dir(ar->ar_rq) == READ)
 		reading = 1 << 3;
 
diff -urN linux-2.5.8-pre3/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux-2.5.8-pre3/drivers/ide/ide-probe.c	Fri Apr 12 00:43:19 2002
+++ linux/drivers/ide/ide-probe.c	Fri Apr 12 01:16:27 2002
@@ -195,6 +195,9 @@
 #ifndef CONFIG_BLK_DEV_IDE_TCQ
 	drive->queue_depth = 1;
 #else
+# ifndef CONFIG_BLK_DEV_IDE_TCQ_DEPTH
+#  define CONFIG_BLK_DEV_IDE_TCQ_DEPTH 1
+# endif
 	drive->queue_depth = drive->id->queue_depth + 1;
 	if (drive->queue_depth > CONFIG_BLK_DEV_IDE_TCQ_DEPTH)
 		drive->queue_depth = CONFIG_BLK_DEV_IDE_TCQ_DEPTH;
diff -urN linux-2.5.8-pre3/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.8-pre3/drivers/ide/ide-taskfile.c	Fri Apr 12 00:43:23 2002
+++ linux/drivers/ide/ide-taskfile.c	Fri Apr 12 14:33:01 2002
@@ -311,6 +311,7 @@
 static ide_startstop_t task_mulout_intr (ide_drive_t *drive)
 {
 	byte stat		= GET_STAT();
+	/* FIXME: this should go possible as well */
 	byte io_32bit		= drive->io_32bit;
 	struct request *rq	= &HWGROUP(drive)->wrq;
 	ide_hwgroup_t *hwgroup	= HWGROUP(drive);
@@ -612,6 +613,7 @@
 static ide_startstop_t task_out_intr(ide_drive_t *drive)
 {
 	byte stat		= GET_STAT();
+	/* FIXME: this should go possible as well */
 	byte io_32bit		= drive->io_32bit;
 	struct request *rq	= HWGROUP(drive)->rq;
 	char *pBuf		= NULL;
@@ -628,7 +630,7 @@
 		rq = HWGROUP(drive)->rq;
 		pBuf = ide_map_rq(rq, &flags);
 		DTF("write: %p, rq->current_nr_sectors: %d\n", pBuf, (int) rq->current_nr_sectors);
-		drive->io_32bit = 0;
+
 		taskfile_output_data(drive, pBuf, SECTOR_WORDS);
 		ide_unmap_rq(rq, pBuf, &flags);
 		drive->io_32bit = io_32bit;
@@ -647,6 +649,7 @@
 {
 	unsigned int		msect, nsect;
 	byte stat		= GET_STAT();
+	/* FIXME: this should go possible as well */
 	byte io_32bit		= drive->io_32bit;
 	struct request *rq	= HWGROUP(drive)->rq;
 	char *pBuf		= NULL;
@@ -913,68 +916,76 @@
 }
 
 /*
- * Issue ATA command and wait for completion. Use for implementing commands in
- * kernel.
+ * Implement generic ioctls invoked from userspace to imlpement specific
+ * functionality.
+ *
+ * FIXME:
+ *
+ * 1. Rewrite hdparm to use the ide_task_ioctl function.
  *
- * The caller has to make sure buf is never NULL!
+ * 2. Publish it.
+ *
+ * 3. Kill this and HDIO_DRIVE_CMD alltogether.
  */
-static int ide_wait_cmd(ide_drive_t *drive, u8 cmd, u8 nsect, u8 feature, u8 sectors, u8 *argbuf)
-{
-	struct request rq;
-
-	/* FIXME: Do we really have to zero out the buffer?
-	 */
-	memset(argbuf, 0, 4 + SECTOR_WORDS * 4 * sectors);
-	ide_init_drive_cmd(&rq);
-	rq.buffer = argbuf;
-	argbuf[0] = cmd;
-	argbuf[1] = nsect;
-	argbuf[2] = feature;
-	argbuf[3] = sectors;
-
-	return ide_do_drive_cmd(drive, &rq, ide_wait);
-}
 
-int ide_cmd_ioctl(ide_drive_t *drive, struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+int ide_cmd_ioctl(ide_drive_t *drive, unsigned long arg)
 {
 	int err = 0;
-	u8 args[4];
-	u8 *argbuf = args;
+	u8 vals[4];
+	u8 *argbuf = vals;
 	byte xfer_rate = 0;
 	int argsize = 4;
-	/* FIXME: this should not reside on the stack */
-	struct ata_taskfile tfargs;
+	struct ata_taskfile args;
+	struct request rq;
 
+	/*
+	 * First phase.
+	 */
 	if (NULL == (void *) arg) {
 		struct request rq;
 		ide_init_drive_cmd(&rq);
 		return ide_do_drive_cmd(drive, &rq, ide_wait);
 	}
-	if (copy_from_user(args, (void *)arg, 4))
+
+	/*
+	 * Second phase.
+	 */
+	if (copy_from_user(vals, (void *)arg, 4))
 		return -EFAULT;
 
-	tfargs.taskfile.feature = args[2];
-	tfargs.taskfile.sector_count = args[3];
-	tfargs.taskfile.sector_number = args[1];
-	tfargs.taskfile.low_cylinder = 0x00;
-	tfargs.taskfile.high_cylinder = 0x00;
-	tfargs.taskfile.device_head = 0x00;
-	tfargs.taskfile.command = args[0];
+	args.taskfile.feature = vals[2];
+	args.taskfile.sector_count = vals[3];
+	args.taskfile.sector_number = vals[1];
+	args.taskfile.low_cylinder = 0x00;
+	args.taskfile.high_cylinder = 0x00;
+	args.taskfile.device_head = 0x00;
+	args.taskfile.command = vals[0];
 
-	if (args[3]) {
-		argsize = 4 + (SECTOR_WORDS * 4 * args[3]);
+	if (vals[3]) {
+		argsize = 4 + (SECTOR_WORDS * 4 * vals[3]);
 		argbuf = kmalloc(argsize, GFP_KERNEL);
 		if (argbuf == NULL)
 			return -ENOMEM;
-		memcpy(argbuf, args, 4);
+		memcpy(argbuf, vals, 4);
 	}
-	if (set_transfer(drive, &tfargs)) {
-		xfer_rate = args[1];
-		if (ide_ata66_check(drive, &tfargs))
+
+	if (set_transfer(drive, &args)) {
+		xfer_rate = vals[1];
+		if (ide_ata66_check(drive, &args))
 			goto abort;
 	}
 
-	err = ide_wait_cmd(drive, args[0], args[1], args[2], args[3], argbuf);
+	/* Issue ATA command and wait for completion.
+	 */
+
+	/* FIXME: Do we really have to zero out the buffer?
+	 */
+	memset(argbuf, 0, 4 + SECTOR_WORDS * 4 * vals[3]);
+	ide_init_drive_cmd(&rq);
+	rq.buffer = argbuf;
+	memcpy(argbuf, vals, 4);
+
+	err = ide_do_drive_cmd(drive, &rq, ide_wait);
 
 	if (!err && xfer_rate) {
 		/* active-retuning-calls future */
@@ -987,10 +998,11 @@
 		err = -EFAULT;
 	if (argsize > 4)
 		kfree(argbuf);
+
 	return err;
 }
 
-int ide_task_ioctl(ide_drive_t *drive, struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+int ide_task_ioctl(ide_drive_t *drive, unsigned long arg)
 {
 	int err = 0;
 	u8 args[7];
diff -urN linux-2.5.8-pre3/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.8-pre3/drivers/ide/ide.c	Fri Apr 12 00:43:23 2002
+++ linux/drivers/ide/ide.c	Fri Apr 12 01:40:11 2002
@@ -2640,12 +2640,12 @@
 		case HDIO_DRIVE_CMD:
 			if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 				return -EACCES;
-			return ide_cmd_ioctl(drive, inode, file, cmd, arg);
+			return ide_cmd_ioctl(drive, arg);
 
 		case HDIO_DRIVE_TASK:
 			if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 				return -EACCES;
-			return ide_task_ioctl(drive, inode, file, cmd, arg);
+			return ide_task_ioctl(drive, arg);
 
 		case HDIO_SET_NICE:
 			if (!capable(CAP_SYS_ADMIN)) return -EACCES;
diff -urN linux-2.5.8-pre3/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.8-pre3/include/linux/ide.h	Fri Apr 12 00:43:23 2002
+++ linux/include/linux/ide.h	Sun Apr 14 15:48:46 2002
@@ -864,10 +864,10 @@
 extern void ide_cmd_type_parser(struct ata_taskfile *args);
 extern int ide_raw_taskfile(ide_drive_t *drive, struct ata_taskfile *cmd, byte *buf);
 
-extern int ide_cmd_ioctl(ide_drive_t *drive, struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg);
-extern int ide_task_ioctl(ide_drive_t *drive, struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg);
+extern int ide_cmd_ioctl(ide_drive_t *drive, unsigned long arg);
+extern int ide_task_ioctl(ide_drive_t *drive, unsigned long arg);
 
-void ide_delay_50ms (void);
+void ide_delay_50ms(void);
 
 byte ide_auto_reduce_xfer (ide_drive_t *drive);
 int ide_driveid_update (ide_drive_t *drive);

--------------070009030303030906030100--

