Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbTDQXLX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 19:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262685AbTDQXLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 19:11:22 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:21132 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262683AbTDQXLM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 19:11:12 -0400
Date: Fri, 18 Apr 2003 01:22:47 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.67-ac1 IDE - fix Taskfile IOCTLs
In-Reply-To: <Pine.SOL.4.30.0304180052130.20946-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.SOL.4.30.0304180122260.22161-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


tf-ioctls-3.diff:

# Map HDIO_DRIVE_CMD ioctl onto taskfile.
# Incremental to tf-ioctls-2b patch.
#
# Detailed changelog:
# - fix taskfile version of ide_cmd_ioctl() and make it backward compatible
# - workaround issuing WIN_IDENTIFY for ATAPI devices for now
#
# To use taskfile ide_cmd_ioctl() you have to turn on CONFIG_IDE_TASKFILE_IO.
#
# Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

diff -uNr linux-2.5.67-ac1-tf2b/drivers/ide/Kconfig linux/drivers/ide/Kconfig
--- linux-2.5.67-ac1-tf2b/drivers/ide/Kconfig	Thu Apr 17 20:03:36 2003
+++ linux/drivers/ide/Kconfig	Thu Apr 17 22:41:38 2003
@@ -220,7 +220,7 @@
 	  If you are unsure, say N here.

 config IDE_TASKFILE_IO
-	bool
+	bool "IDE Taskfile IO"
 	depends on BLK_DEV_IDE

 comment "IDE chipset support/bugfixes"
diff -uNr linux-2.5.67-ac1-tf2b/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.67-ac1-tf2b/drivers/ide/ide-taskfile.c	Thu Apr 17 22:32:32 2003
+++ linux/drivers/ide/ide-taskfile.c	Thu Apr 17 23:24:51 2003
@@ -1318,7 +1318,7 @@
  */
 int ide_cmd_ioctl (ide_drive_t *drive, unsigned int cmd, unsigned long arg)
 {
-#if 1
+#ifndef CONFIG_IDE_TASKFILE_IO
 	int err = 0;
 	u8 args[4], *argbuf = args;
 	u8 xfer_rate = 0;
@@ -1373,7 +1373,7 @@
 #else

 	int err = -EIO;
-	u8 args[4], *argbuf = args;
+	u8 args[4], *argbuf = NULL;
 	u8 xfer_rate = 0;
 	int argsize = 0;
 	ide_task_t tfargs;
@@ -1396,6 +1396,13 @@
 	tfargs.tfRegister[IDE_SELECT_OFFSET]  = 0x00;
 	tfargs.tfRegister[IDE_COMMAND_OFFSET] = args[0];

+	/*
+	 * FIXME: fix ->error() to do abort properly and hdparm to check
+	 *	  returned error value for abort not ioctl!  --bzolnier
+	 */
+	if (drive->media != ide_disk && args[0] == WIN_IDENTIFY)
+		tfargs.tfRegister[IDE_COMMAND_OFFSET] = WIN_PIDENTIFY;
+
 	if (args[3]) {
 		argsize = (SECTOR_WORDS * 4 * args[3]);
 		argbuf = kmalloc(argsize, GFP_KERNEL);
@@ -1414,19 +1421,20 @@

 	if (!err && xfer_rate) {
 		/* active-retuning-calls future */
-		ide_set_xfer_rate(driver, xfer_rate);
+		ide_set_xfer_rate(drive, xfer_rate);
 		ide_driveid_update(drive);
 	}
-abort:
-	args[0] = tfargs.tfRegister[IDE_COMMAND_OFFSET];
-	args[1] = tfargs.tfRegister[IDE_FEATURE_OFFSET];
+
+	args[0] = tfargs.tfRegister[IDE_STATUS_OFFSET];
+	args[1] = tfargs.tfRegister[IDE_ERROR_OFFSET];
 	args[2] = tfargs.tfRegister[IDE_NSECTOR_OFFSET];
-	args[3] = 0;

-	if (copy_to_user((void *)arg, argbuf, 4))
+abort:
+	if (copy_to_user((void *)arg, &args, 4))
 		err = -EFAULT;
+
 	if (argbuf != NULL) {
-		if (copy_to_user((void *)arg, argbuf + 4, argsize))
+		if (copy_to_user((void *)(arg+4), argbuf, argsize))
 			err = -EFAULT;
 		kfree(argbuf);
 	}

