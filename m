Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUCLA26 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 19:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbUCLA25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 19:28:57 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:50954 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261857AbUCLA2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 19:28:49 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Jeff Garzik <jgarzik@pobox.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] hdparm_X.patch (was: Re: 2.6.4-rc-bk3: hdparm -X locks up IDE)
Date: Fri, 12 Mar 2004 02:21:41 +0200
User-Agent: KMail/1.5.4
Cc: Jens Axboe <axboe@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
References: <200403111614.08778.vda@port.imtp.ilyichevsk.odessa.ua> <200403111607.39235.bzolnier@elka.pw.edu.pl> <4050A913.50809@pobox.com>
In-Reply-To: <4050A913.50809@pobox.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_VKQUATFDIWV/pvJ"
Message-Id: <200403120221.42082.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_VKQUATFDIWV/pvJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 11 March 2004 19:59, Jeff Garzik wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > On Thursday 11 of March 2004 15:48, Jens Axboe wrote:
> >>On Thu, Mar 11 2004, Bartlomiej Zolnierkiewicz wrote:
> >>>On Thursday 11 of March 2004 15:14, Denis Vlasenko wrote:
> >>>>I discovered that hdparm -X <mode> /dev/hda can lock up IDE
> >>>>interface if there is some activity.
> >>>
> >>>Known bug and is on TODO but fixing it ain't easy.
> >>>Thanks for a report anyway.
> >>
> >>Wouldn't it be possible to do the stuff that needs serializing from the
> >>end_request() part and get automatic synchronization with normal
> >>requests?
> >
> > That's the way to do it (REQ_SPECIAL) but unfortunately on some chipsets
> > we need to synchronize both channels (whereas we don't need to serialize
> > normal operations).
>
> blk_stop_queue() on all queues attached to the hardware?
>
> You need to synchronize anyway for the rare hardware that reports itself
> as "simplex" -- one DMA engine for both channels.

This patch survived cyclic switching of all DMA modes from mwdma0 to udma4
and continuous write load of type
while(1) { dd if=/dev/zero of=file bs=1M count=<RAM size>; sync; }
for five minutes.

It does not handle crippled/simplex chipset, it is a TODO.

Things commented by C++ style comments (//) aren't meant to stay.

I think original code was a bit buggy:
set_transfer() returned 0 for modes < XFER_SW_DMA_0, ie,
for all PIO modes. Later,
       if (set_transfer(drive, &tfargs)) {
               xfer_rate = args[1];
               if (ide_ata66_check(drive, &tfargs))
                       goto abort;
        }
        err = ide_wait_cmd(drive, args[0], args[1], args[2], args[3], argbuf);
        if (!err && xfer_rate) {
               ide_set_xfer_rate(drive, xfer_rate);
               ide_driveid_update(drive);
       }
This will never execute ide_set_xfer_rate() for PIO modes
--
vda

--Boundary-00=_VKQUATFDIWV/pvJ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="hdparm_X.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hdparm_X.patch"

diff -urN linux-2.6.4.orig/drivers/ide/ide-io.c linux-2.6.4/drivers/ide/ide-io.c
--- linux-2.6.4.orig/drivers/ide/ide-io.c	Thu Mar 11 21:25:17 2004
+++ linux-2.6.4/drivers/ide/ide-io.c	Fri Mar 12 02:03:49 2004
@@ -1387,10 +1387,32 @@
 
 	err = 0;
 	if (must_wait) {
+		int xfer_rate = -1;
+		/* Are we going to do hdparm -X n ? */
+		if(rq->buffer
+		&& rq->buffer[0] == (char)WIN_SETFEATURES
+		// original code checked for !0 below. Is that right?
+		&& (int)rq->buffer[1] != 0
+		&& rq->buffer[2] == (char)SETFEATURES_XFER
+		// original code checked for 0 below. It is always true, can we nuke it?
+		&& rq->buffer[3] == 0
+		// original code did it but I think it's wrong:
+		//&& (drive->id->dma_ultra || drive->id->dma_mword
+		//			|| drive->id->dma_1word)
+		) {
+			xfer_rate = rq->buffer[1]; /* -X n */
+		}
+			
 		wait_for_completion(&wait);
 		if (rq->errors)
 			err = -EIO;
 
+		if(!err && xfer_rate != -1) {
+			/* asking chipset to change DMA/PIO timings */
+			ide_set_xfer_rate(drive, xfer_rate);
+			ide_driveid_update(drive);
+			mdelay(2000); // give it a name like WAIT_XFER_RATE
+		}
 		blk_put_request(rq);
 	}
 
diff -urN linux-2.6.4.orig/drivers/ide/ide-iops.c linux-2.6.4/drivers/ide/ide-iops.c
--- linux-2.6.4.orig/drivers/ide/ide-iops.c	Wed Feb 18 05:57:24 2004
+++ linux-2.6.4/drivers/ide/ide-iops.c	Fri Mar 12 02:04:19 2004
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
--- linux-2.6.4.orig/drivers/ide/ide-taskfile.c	Thu Mar 11 21:25:18 2004
+++ linux-2.6.4/drivers/ide/ide-taskfile.c	Fri Mar 12 02:03:55 2004
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

--Boundary-00=_VKQUATFDIWV/pvJ--

