Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264156AbTDWR3d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 13:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264145AbTDWR2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 13:28:23 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:13777 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264150AbTDWR1P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 13:27:15 -0400
Date: Wed, 23 Apr 2003 19:39:09 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andre Hedrick <andre@linux-ide.org>, Jens Axboe <axboe@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.67-ac2 direct-IO for IDE taskfile ioctl (2/4)
In-Reply-To: <Pine.SOL.4.30.0304231933360.10502-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.SOL.4.30.0304231938460.10502-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# Pass bdev to IDE ioctl handlers.
#
# Pass bdev to ide_cmd_ioctl(), ide_task_ioctl() and ide_taskfile_ioctl()
# from generic_ide_ioctl().
#
# Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

diff -uNr linux-2.5.67-ac2-dtf1/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.67-ac2-dtf1/drivers/ide/ide-taskfile.c	Fri Apr 18 02:04:28 2003
+++ linux/drivers/ide/ide-taskfile.c	Tue Apr 22 18:43:32 2003
@@ -1056,7 +1056,8 @@

 #define MAX_DMA		(256*SECTOR_WORDS)

-int ide_taskfile_ioctl (ide_drive_t *drive, unsigned int cmd, unsigned long arg)
+int ide_taskfile_ioctl (struct block_device *bdev, ide_drive_t *drive,
+			unsigned int cmd, unsigned long arg)
 {
 	ide_task_request_t	*req_task;
 	ide_task_t		args;
@@ -1256,7 +1257,8 @@
 /*
  * FIXME : this needs to map into at taskfile. <andre@linux-ide.org>
  */
-int ide_cmd_ioctl (ide_drive_t *drive, unsigned int cmd, unsigned long arg)
+int ide_cmd_ioctl (struct block_device *bdev, ide_drive_t *drive,
+		   unsigned int cmd, unsigned long arg)
 {
 #ifndef CONFIG_IDE_TASKFILE_IO
 	int err = 0;
@@ -1400,7 +1402,8 @@
 /*
  * FIXME : this needs to map into at taskfile. <andre@linux-ide.org>
  */
-int ide_task_ioctl (ide_drive_t *drive, unsigned int cmd, unsigned long arg)
+int ide_task_ioctl (struct block_device *bdev, ide_drive_t *drive,
+		    unsigned int cmd, unsigned long arg)
 {
 	int err = 0;
 	u8 args[7], *argbuf = args;
@@ -1544,7 +1547,8 @@

 #ifdef CONFIG_PKT_TASK_IOCTL

-int pkt_taskfile_ioctl (ide_drive_t *drive, unsigned int cmd, unsigned long arg)
+int pkt_taskfile_ioctl (struct block_device *bdev, ide_drive_t *drive,
+			unsigned int cmd, unsigned long arg)
 {
 #if 0
 	switch(req_task->data_phase) {
diff -uNr linux-2.5.67-ac2-dtf1/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.67-ac2-dtf1/drivers/ide/ide.c	Wed Apr 23 15:14:10 2003
+++ linux/drivers/ide/ide.c	Wed Apr 23 15:25:13 2003
@@ -1533,29 +1533,47 @@
 		case HDIO_DRIVE_TASKFILE:
 		        if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 				return -EACCES;
+			err = bd_claim(bdev, current);
+			if (err)
+				return err;
 			switch(drive->media) {
 				case ide_disk:
-					return ide_taskfile_ioctl(drive, cmd, arg);
+					err = ide_taskfile_ioctl(bdev, drive, cmd, arg);
+					break;
 #ifdef CONFIG_PKT_TASK_IOCTL
 				case ide_cdrom:
 				case ide_tape:
 				case ide_floppy:
-					return pkt_taskfile_ioctl(drive, cmd, arg);
+					err = pkt_taskfile_ioctl(bdev, drive, cmd, arg);
+					break;
 #endif /* CONFIG_PKT_TASK_IOCTL */
 				default:
-					return -ENOMSG;
+					err = -ENOMSG;
+					break;
 			}
+			bd_release(bdev);
+			return err;
 #endif /* CONFIG_IDE_TASK_IOCTL */

 		case HDIO_DRIVE_CMD:
 			if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 				return -EACCES;
-			return ide_cmd_ioctl(drive, cmd, arg);
+			err = bd_claim(bdev, current);
+			if (err)
+				return err;
+			err = ide_cmd_ioctl(bdev, drive, cmd, arg);
+			bd_release(bdev);
+			return err;

 		case HDIO_DRIVE_TASK:
 			if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 				return -EACCES;
-			return ide_task_ioctl(drive, cmd, arg);
+			err = bd_claim(bdev, current);
+			if (err)
+				return err;
+			err = ide_task_ioctl(bdev, drive, cmd, arg);
+			bd_release(bdev);
+			return err;

 		case HDIO_SCAN_HWIF:
 		{
diff -uNr linux-2.5.67-ac2-dtf1/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.67-ac2-dtf1/include/linux/ide.h	Fri Apr 18 02:04:12 2003
+++ linux/include/linux/ide.h	Tue Apr 22 18:45:56 2003
@@ -1477,9 +1477,9 @@
 /* Expects args is a full set of TF registers and parses the command type */
 extern int ide_cmd_type_parser(ide_task_t *);

-int ide_taskfile_ioctl(ide_drive_t *, unsigned int, unsigned long);
-int ide_cmd_ioctl(ide_drive_t *, unsigned int, unsigned long);
-int ide_task_ioctl(ide_drive_t *, unsigned int, unsigned long);
+int ide_taskfile_ioctl(struct block_device *, ide_drive_t *, unsigned int, unsigned long);
+int ide_cmd_ioctl(struct block_device *, ide_drive_t *, unsigned int, unsigned long);
+int ide_task_ioctl(struct block_device *, ide_drive_t *, unsigned int, unsigned long);

 #if 0


