Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267301AbUBSPMV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 10:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267306AbUBSO64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 09:58:56 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:58340 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267305AbUBSOzm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 09:55:42 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IDE update for 2.6.3 (7/9)
Date: Thu, 19 Feb 2004 15:59:02 +0100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402191559.02022.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] remove dead/unfinished taskfile version of ide_cmd_ioctl()

 linux-2.6.3-root/drivers/ide/ide-taskfile.c |   65 ----------------------------
 1 files changed, 65 deletions(-)

diff -puN drivers/ide/ide-taskfile.c~ide_cmd_ioctl drivers/ide/ide-taskfile.c
--- linux-2.6.3/drivers/ide/ide-taskfile.c~ide_cmd_ioctl	2004-02-19 02:11:21.212111024 +0100
+++ linux-2.6.3-root/drivers/ide/ide-taskfile.c	2004-02-19 02:11:21.218110112 +0100
@@ -1669,7 +1669,6 @@ EXPORT_SYMBOL(ide_wait_cmd);
  */
 int ide_cmd_ioctl (ide_drive_t *drive, unsigned int cmd, unsigned long arg)
 {
-#if 1
 	int err = 0;
 	u8 args[4], *argbuf = args;
 	u8 xfer_rate = 0;
@@ -1720,70 +1719,6 @@ abort:
 	if (argsize > 4)
 		kfree(argbuf);
 	return err;
-
-#else
-
-	int err = -EIO;
-	u8 args[4], *argbuf = args;
-	u8 xfer_rate = 0;
-	int argsize = 0;
-	ide_task_t tfargs;
-
-	if (NULL == (void *) arg) {
-		struct request rq;
-		ide_init_drive_cmd(&rq);
-		return ide_do_drive_cmd(drive, &rq, ide_wait);
-	}
-
-	if (copy_from_user(args, (void *)arg, 4))
-		return -EFAULT;
-
-	memset(&tfargs, 0, sizeof(ide_task_t));
-	tfargs.tfRegister[IDE_FEATURE_OFFSET] = args[2];
-	tfargs.tfRegister[IDE_NSECTOR_OFFSET] = args[3];
-	tfargs.tfRegister[IDE_SECTOR_OFFSET]  = args[1];
-	tfargs.tfRegister[IDE_LCYL_OFFSET]    = 0x00;
-	tfargs.tfRegister[IDE_HCYL_OFFSET]    = 0x00;
-	tfargs.tfRegister[IDE_SELECT_OFFSET]  = 0x00;
-	tfargs.tfRegister[IDE_COMMAND_OFFSET] = args[0];
-
-	if (args[3]) {
-		argsize = (SECTOR_WORDS * 4 * args[3]);
-		argbuf = kmalloc(argsize, GFP_KERNEL);
-		if (argbuf == NULL)
-			return -ENOMEM;
-	}
-
-	if (set_transfer(drive, &tfargs)) {
-		xfer_rate = args[1];
-		if (ide_ata66_check(drive, &tfargs))
-			goto abort;
-	}
-
-	tfargs.command_type = ide_cmd_type_parser(&tfargs);
-	err = ide_raw_taskfile(drive, &tfargs, argbuf);
-
-	if (!err && xfer_rate) {
-		/* active-retuning-calls future */
-		ide_set_xfer_rate(driver, xfer_rate);
-		ide_driveid_update(drive);
-	}
-abort:
-	args[0] = tfargs.tfRegister[IDE_COMMAND_OFFSET];
-	args[1] = tfargs.tfRegister[IDE_FEATURE_OFFSET];
-	args[2] = tfargs.tfRegister[IDE_NSECTOR_OFFSET];
-	args[3] = 0;
-
-	if (copy_to_user((void *)arg, argbuf, 4))
-		err = -EFAULT;
-	if (argbuf != NULL) {
-		if (copy_to_user((void *)arg, argbuf + 4, argsize))
-			err = -EFAULT;
-		kfree(argbuf);
-	}
-	return err;
-
-#endif
 }
 
 EXPORT_SYMBOL(ide_cmd_ioctl);

_

