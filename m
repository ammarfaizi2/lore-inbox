Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbUCLKGG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 05:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbUCLKGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 05:06:06 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:55050 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261743AbUCLKFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 05:05:24 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] hdparm_X.patch (was: Re: 2.6.4-rc-bk3: hdparm -X locks up IDE)
Date: Fri, 12 Mar 2004 11:39:41 +0200
X-Mailer: KMail [version 1.4]
Cc: Jens Axboe <axboe@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
References: <200403111614.08778.vda@port.imtp.ilyichevsk.odessa.ua> <200403120202.06097.bzolnier@elka.pw.edu.pl> <200403120924.03431.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200403120924.03431.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_5UIGFGS2WCD7H1VJ9606"
Message-Id: <200403121139.41402.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_5UIGFGS2WCD7H1VJ9606
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> I forgot to remove now-extraneous if() from ide.c:
>
> static int set_xfer_rate (ide_drive_t *drive, int arg)
> {
>         int err =3D ide_wait_cmd(drive,
>                         WIN_SETFEATURES, (u8) arg,
>                         SETFEATURES_XFER, 0, NULL);
>
>         if (!err && arg) {
>                 ide_set_xfer_rate(drive, (u8) arg);
>                 ide_driveid_update(drive);
>         }
>         return err;
> }
>
> And second, in ide_do_drive_cmd(), mdelay(2000)
> after WIN_SETFEATURES is a bit rude.

=2E..and wrongly placed. I just realized that ide_driveid_update(drive)
actually talks with the drive!

New patch is attached.
--=20
vda
--------------Boundary-00=_5UIGFGS2WCD7H1VJ9606
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="hdparm_X-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="hdparm_X-2.patch"

diff -urN linux-2.6.4.orig/drivers/ide/ide-io.c linux-2.6.4/drivers/ide/ide-io.c
--- linux-2.6.4.orig/drivers/ide/ide-io.c	Fri Mar 12 11:15:00 2004
+++ linux-2.6.4/drivers/ide/ide-io.c	Fri Mar 12 11:33:30 2004
@@ -1387,10 +1387,25 @@
 
 	err = 0;
 	if (must_wait) {
+		int xfer_rate = -1;
+		/* Are we going to do hdparm -X n ? */
+		if(rq->buffer
+		&& rq->buffer[0] == (char)WIN_SETFEATURES
+		&& rq->buffer[2] == (char)SETFEATURES_XFER
+		) {
+			xfer_rate = rq->buffer[1]; /* -X n */
+		}
+			
 		wait_for_completion(&wait);
 		if (rq->errors)
 			err = -EIO;
 
+		if(!err && xfer_rate != -1) {
+			ide_delay_50ms(); /* be gentle */
+			/* ask chipset to change DMA/PIO timings */
+			ide_set_xfer_rate(drive, xfer_rate);
+			ide_driveid_update(drive);
+		}
 		blk_put_request(rq);
 	}
 
diff -urN linux-2.6.4.orig/drivers/ide/ide-iops.c linux-2.6.4/drivers/ide/ide-iops.c
--- linux-2.6.4.orig/drivers/ide/ide-iops.c	Fri Mar 12 11:07:07 2004
+++ linux-2.6.4/drivers/ide/ide-iops.c	Fri Mar 12 11:26:55 2004
@@ -660,52 +660,34 @@
 
 EXPORT_SYMBOL(eighty_ninty_three);
 
-int ide_ata66_check (ide_drive_t *drive, ide_task_t *args)
+/*
+ * Is drive/channel capable of handling this?
+ * Currently checks only for ioctl(HDIO_DRIVE_CMD, SETFEATURES_XFER)
+ * (hdparm -X n)
+ */
+int unsupported_by_drive (ide_drive_t *drive, ide_task_t *args)
 {
-	if ((args->tfRegister[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
-	    (args->tfRegister[IDE_SECTOR_OFFSET] > XFER_UDMA_2) &&
-	    (args->tfRegister[IDE_FEATURE_OFFSET] == SETFEATURES_XFER)) {
+	if (args->tfRegister[IDE_COMMAND_OFFSET] != WIN_SETFEATURES) return 0;
+	if (args->tfRegister[IDE_FEATURE_OFFSET] != SETFEATURES_XFER) return 0;
+	if (args->tfRegister[IDE_SECTOR_OFFSET] <= XFER_UDMA_2) return 0;
+
 #ifndef CONFIG_IDEDMA_IVB
-		if ((drive->id->hw_config & 0x6000) == 0) {
+	if ( (drive->id->hw_config & 0x6000) == 0) {
 #else /* !CONFIG_IDEDMA_IVB */
-		if (((drive->id->hw_config & 0x2000) == 0) ||
-		    ((drive->id->hw_config & 0x4000) == 0)) {
+	if ( ((drive->id->hw_config & 0x2000) == 0) ||
+	     ((drive->id->hw_config & 0x4000) == 0) ) {
 #endif /* CONFIG_IDEDMA_IVB */
-			printk("%s: Speed warnings UDMA 3/4/5 is not "
-				"functional.\n", drive->name);
-			return 1;
-		}
-		if (!HWIF(drive)->udma_four) {
-			printk("%s: Speed warnings UDMA 3/4/5 is not "
-				"functional.\n",
-				HWIF(drive)->name);
-			return 1;
-		}
+		printk("%s is not capable of UDMA 3/4/5\n", drive->name);
+		return 1;
 	}
-	return 0;
-}
-
-EXPORT_SYMBOL(ide_ata66_check);
-
-/*
- * Backside of HDIO_DRIVE_CMD call of SETFEATURES_XFER.
- * 1 : Safe to update drive->id DMA registers.
- * 0 : OOPs not allowed.
- */
-int set_transfer (ide_drive_t *drive, ide_task_t *args)
-{
-	if ((args->tfRegister[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
-	    (args->tfRegister[IDE_SECTOR_OFFSET] >= XFER_SW_DMA_0) &&
-	    (args->tfRegister[IDE_FEATURE_OFFSET] == SETFEATURES_XFER) &&
-	    (drive->id->dma_ultra ||
-	     drive->id->dma_mword ||
-	     drive->id->dma_1word))
+	if (!HWIF(drive)->udma_four) {
+		printk("%s is not capable of UDMA 3/4/5\n", HWIF(drive)->name);
 		return 1;
-
+	}
 	return 0;
 }
 
-EXPORT_SYMBOL(set_transfer);
+EXPORT_SYMBOL(unsupported_by_drive);
 
 u8 ide_auto_reduce_xfer (ide_drive_t *drive)
 {
diff -urN linux-2.6.4.orig/drivers/ide/ide-taskfile.c linux-2.6.4/drivers/ide/ide-taskfile.c
--- linux-2.6.4.orig/drivers/ide/ide-taskfile.c	Fri Mar 12 11:15:00 2004
+++ linux-2.6.4/drivers/ide/ide-taskfile.c	Fri Mar 12 11:26:55 2004
@@ -1592,7 +1592,6 @@
 {
 	int err = 0;
 	u8 args[4], *argbuf = args;
-	u8 xfer_rate = 0;
 	int argsize = 4;
 	ide_task_t tfargs;
 
@@ -1621,19 +1620,13 @@
 			return -ENOMEM;
 		memcpy(argbuf, args, 4);
 	}
-	if (set_transfer(drive, &tfargs)) {
-		xfer_rate = args[1];
-		if (ide_ata66_check(drive, &tfargs))
-			goto abort;
+
+	if (unsupported_by_drive(drive, &tfargs)) {
+		goto abort;
 	}
 
 	err = ide_wait_cmd(drive, args[0], args[1], args[2], args[3], argbuf);
 
-	if (!err && xfer_rate) {
-		/* active-retuning-calls future */
-		ide_set_xfer_rate(drive, xfer_rate);
-		ide_driveid_update(drive);
-	}
 abort:
 	if (copy_to_user((void *)arg, argbuf, argsize))
 		err = -EFAULT;

--------------Boundary-00=_5UIGFGS2WCD7H1VJ9606--

