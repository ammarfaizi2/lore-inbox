Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264167AbTDWRbu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 13:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264161AbTDWRaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 13:30:22 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:13777 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264150AbTDWR20
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 13:28:26 -0400
Date: Wed, 23 Apr 2003 19:40:10 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andre Hedrick <andre@linux-ide.org>, Jens Axboe <axboe@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.67-ac2 direct-IO for IDE taskfile ioctl (4/4)
In-Reply-To: <Pine.SOL.4.30.0304231933360.10502-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.SOL.4.30.0304231939410.10502-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# Use direct-IO in ide_taskfile_ioctl() and in ide_cmd_ioctl().
#
# Detailed changelog:
# - add ide_bio_taskfile() which is equivalent to ide_diag_taskfile()
#   for non-fs rq->bio based requests
# - use direct-IO to user memory if possible in ide_taskfile_ioctl()
#   and in taskfile version of ide_cmd_ioctl()
#
# NOTE: user memory out/in buffers have to be hardsector (=512) aligned
#	to take advantage of direct-IO
#
# Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

diff -uNr linux-2.5.67-ac2-dtf3/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.67-ac2-dtf3/drivers/ide/ide-taskfile.c	Wed Apr 23 15:44:36 2003
+++ linux/drivers/ide/ide-taskfile.c	Wed Apr 23 16:22:12 2003
@@ -1054,6 +1054,25 @@

 EXPORT_SYMBOL(ide_raw_taskfile);

+/*
+ * Comments to ide_diag_taskfile() apply here as well.
+ */
+static int ide_bio_taskfile (ide_drive_t *drive, ide_task_t *args,
+			     request_queue_t *q, struct bio *bio)
+{
+	struct request rq;
+
+	ide_init_drive_taskfile(&rq);
+	blk_rq_bio_prep(q, &rq, bio);
+
+	if (args->tf_out_flags.all == 0)
+		args->posthandler = ide_post_handler_parser(
+				(struct hd_drive_task_hdr *) args->tfRegister,
+				(struct hd_drive_hob_hdr *) args->hobRegister);
+	rq.special = args;
+	return ide_do_drive_cmd(drive, &rq, ide_wait);
+}
+
 #ifdef CONFIG_IDE_TASK_IOCTL_DEBUG
 char * ide_ioctl_verbose (unsigned int cmd)
 {
@@ -1081,10 +1100,19 @@
 	int tasksize		= sizeof(struct ide_task_request_s);
 	int taskin		= 0;
 	int taskout		= 0;
+
+	unsigned long outaddr, inaddr;
+	request_queue_t *q;
+	struct bio *outbio = NULL, *inbio = NULL;
+
 	u8 io_32bit		= drive->io_32bit;

 //	printk("IDE Taskfile ...\n");

+	q = bdev_get_queue(bdev);
+	if (!q)
+		return -ENXIO;
+
 	req_task = kmalloc(tasksize, GFP_KERNEL);
 	if (req_task == NULL) return -ENOMEM;
 	memset(req_task, 0, tasksize);
@@ -1097,7 +1125,21 @@
 	taskin  = (int) req_task->in_size;

 	if (taskout) {
+		outaddr = arg + tasksize;
+		/* writing to device -> reading from vm */
+		if (!access_ok(VERIFY_READ, (void *)outaddr, taskout)) {
+			kfree(req_task);
+			return -EFAULT;
+		}
+		outbio = bio_map_user(bdev, outaddr, taskout, 0);
+		if (outbio)
+			outbio->bi_rw |= (1 << BIO_RW);
+	}
+
+	if (taskout && !outbio) {
 		int outtotal = tasksize;
+		printk(KERN_INFO "%s: %s: taking OUT slow-path\n",
+				 drive->name, __FUNCTION__);
 		outbuf = kmalloc(taskout, GFP_KERNEL);
 		if (outbuf == NULL) {
 			err = -ENOMEM;
@@ -1111,7 +1153,19 @@
 	}

 	if (taskin) {
+		inaddr = arg + tasksize + taskout;
+		/* reading from device -> writing to vm */
+		if (!access_ok(VERIFY_WRITE, (void *)inaddr, taskin)) {
+			kfree(req_task);
+			return -EFAULT;
+		}
+		inbio = bio_map_user(bdev, inaddr, taskin, 1);
+	}
+
+	if (taskin && !inbio) {
 		int intotal = tasksize + taskout;
+		printk(KERN_INFO "%s: %s: taking IN slow-path\n",
+				 drive->name, __FUNCTION__);
 		inbuf = kmalloc(taskin, GFP_KERNEL);
 		if (inbuf == NULL) {
 			err = -ENOMEM;
@@ -1144,22 +1198,34 @@
 	switch(req_task->data_phase) {
 		case TASKFILE_OUT_DMAQ:
 		case TASKFILE_OUT_DMA:
-			err = ide_diag_taskfile(drive, &args, taskout, outbuf);
+			if (outbio)
+				err = ide_bio_taskfile(drive, &args, q, outbio);
+			else
+				err = ide_diag_taskfile(drive, &args, taskout, outbuf);
 			break;
 		case TASKFILE_IN_DMAQ:
 		case TASKFILE_IN_DMA:
-			err = ide_diag_taskfile(drive, &args, taskin, inbuf);
+			if (inbio)
+				err = ide_bio_taskfile(drive, &args, q, inbio);
+			else
+				err = ide_diag_taskfile(drive, &args, taskin, inbuf);
 			break;
 		case TASKFILE_IN_OUT:
 #if 0
 			args.prehandler = &pre_task_out_intr;
 			args.handler = &task_out_intr;
 			args.posthandler = NULL;
-			err = ide_diag_taskfile(drive, &args, taskout, outbuf);
+			if (outbio)
+				err = ide_bio_taskfile(drive, &args, q, outbio);
+			else
+				err = ide_diag_taskfile(drive, &args, taskout, outbuf);
 			args.prehandler = NULL;
 			args.handler = &task_in_intr;
 			args.posthandler = NULL;
-			err = ide_diag_taskfile(drive, &args, taskin, inbuf);
+			if (inbio)
+				err = ide_bio_taskfile(drive, &args, q, inbio);
+			else
+				err = ide_diag_taskfile(drive, &args, taskin, inbuf);
 			break;
 #else
 			err = -EFAULT;
@@ -1176,12 +1242,18 @@
 			}
 			args.prehandler = &pre_task_mulout_intr;
 			args.handler = &task_mulout_intr;
-			err = ide_diag_taskfile(drive, &args, taskout, outbuf);
+			if (outbio)
+				err = ide_bio_taskfile(drive, &args, q, outbio);
+			else
+				err = ide_diag_taskfile(drive, &args, taskout, outbuf);
 			break;
 		case TASKFILE_OUT:
 			args.prehandler = &pre_task_out_intr;
 			args.handler = &task_out_intr;
-			err = ide_diag_taskfile(drive, &args, taskout, outbuf);
+			if (outbio)
+				err = ide_bio_taskfile(drive, &args, q, outbio);
+			else
+				err = ide_diag_taskfile(drive, &args, taskout, outbuf);
 			break;
 		case TASKFILE_MULTI_IN:
 			if (!drive->mult_count) {
@@ -1193,11 +1265,17 @@
 				goto abort;
 			}
 			args.handler = &task_mulin_intr;
-			err = ide_diag_taskfile(drive, &args, taskin, inbuf);
+			if (inbio)
+				err = ide_bio_taskfile(drive, &args, q, inbio);
+			else
+				err = ide_diag_taskfile(drive, &args, taskin, inbuf);
 			break;
 		case TASKFILE_IN:
 			args.handler = &task_in_intr;
-			err = ide_diag_taskfile(drive, &args, taskin, inbuf);
+			if (inbio)
+				err = ide_bio_taskfile(drive, &args, q, inbio);
+			else
+				err = ide_diag_taskfile(drive, &args, taskin, inbuf);
 			break;
 		case TASKFILE_NO_DATA:
 			args.handler = &task_no_data_intr;
@@ -1208,6 +1286,11 @@
 			goto abort;
 	}

+	if (outbio)
+		bio_unmap_user(outbio, 0);
+	if (inbio)
+		bio_unmap_user(inbio, 1);
+
 	memcpy(req_task->io_ports, &(args.tfRegister), HDIO_DRIVE_TASK_HDR_SIZE);
 	memcpy(req_task->hob_ports, &(args.hobRegister), HDIO_DRIVE_HOB_HDR_SIZE);
 	req_task->in_flags  = args.tf_in_flags;
@@ -1217,14 +1300,14 @@
 		err = -EFAULT;
 		goto abort;
 	}
-	if (taskout) {
+	if (outbuf) {
 		int outtotal = tasksize;
 		if (copy_to_user((void *)arg+outtotal, outbuf, taskout)) {
 			err = -EFAULT;
 			goto abort;
 		}
 	}
-	if (taskin) {
+	if (inbuf) {
 		int intotal = tasksize + taskout;
 		if (copy_to_user((void *)arg+intotal, inbuf, taskin)) {
 			err = -EFAULT;
@@ -1331,6 +1414,9 @@
 	u8 xfer_rate = 0;
 	int argsize = 0;
 	ide_task_t tfargs;
+	int reading = 0, writing = 0;
+	request_queue_t *q;
+	struct bio *bio = NULL;

 	if (NULL == (void *) arg) {
 		struct request rq;
@@ -1338,6 +1424,10 @@
 		return ide_do_drive_cmd(drive, &rq, ide_wait);
 	}

+	q = bdev_get_queue(bdev);
+	if (!q)
+		return -ENXIO;
+
 	if (copy_from_user(args, (void *)arg, 4))
 		return -EFAULT;

@@ -1357,21 +1447,51 @@
 	if (drive->media != ide_disk && args[0] == WIN_IDENTIFY)
 		tfargs.tfRegister[IDE_COMMAND_OFFSET] = WIN_PIDENTIFY;

+	if (set_transfer(drive, &tfargs)) {
+		xfer_rate = args[1];
+		if (ide_ata66_check(drive, &tfargs))
+			goto abort;
+	}
+
+	tfargs.command_type = ide_cmd_type_parser(&tfargs);
+
 	if (args[3]) {
 		argsize = (SECTOR_WORDS * 4 * args[3]);
+
+		if (tfargs.command_type == IDE_DRIVE_TASK_OUT ||
+		    tfargs.command_type == IDE_DRIVE_TASK_RAW_WRITE)
+			writing = 1;
+		else if (tfargs.command_type == IDE_DRIVE_TASK_IN)
+			reading = 1;
+		else
+			return -EPERM;
+
+		if (writing && !access_ok(VERIFY_READ, arg+4, argsize))
+			return -EFAULT;
+		else if (reading && !access_ok(VERIFY_WRITE, arg+4, argsize))
+			return -EFAULT;
+
+		bio = bio_map_user(bdev, arg+4, argsize, reading);
+		if (bio && writing)
+			bio->bi_rw |= (1 << BIO_RW);
+	}
+
+	if (args[3] && !bio) {
+		printk(KERN_INFO "%s: %s: taking slow-path\n",
+				 drive->name, __FUNCTION__);
+		argsize = (SECTOR_WORDS * 4 * args[3]);
 		argbuf = kmalloc(argsize, GFP_KERNEL);
 		if (argbuf == NULL)
 			return -ENOMEM;
 	}

-	if (set_transfer(drive, &tfargs)) {
-		xfer_rate = args[1];
-		if (ide_ata66_check(drive, &tfargs))
-			goto abort;
-	}
+	if (bio)
+		err = ide_bio_taskfile(drive, &tfargs, q, bio);
+	else
+		err = ide_raw_taskfile(drive, &tfargs, argbuf);

-	tfargs.command_type = ide_cmd_type_parser(&tfargs);
-	err = ide_raw_taskfile(drive, &tfargs, argbuf);
+	if (bio)
+		bio_unmap_user(bio, reading);

 	if (!err && xfer_rate) {
 		/* active-retuning-calls future */

