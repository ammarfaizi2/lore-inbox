Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314277AbSFBVMT>; Sun, 2 Jun 2002 17:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314278AbSFBVMS>; Sun, 2 Jun 2002 17:12:18 -0400
Received: from [195.63.194.11] ([195.63.194.11]:3079 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S314277AbSFBVMQ>;
	Sun, 2 Jun 2002 17:12:16 -0400
Message-ID: <3CFA7C7E.4020501@evision-ventures.com>
Date: Sun, 02 Jun 2002 22:13:50 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.19 IDE 82
In-Reply-To: <Pine.LNX.4.33.0205291146510.1344-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------010602000509040909070100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010602000509040909070100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Sun Jun  2 22:41:45 CEST 2002 ide-clean-82

- PPC compilation fix by Paul Mackerras.

- Various fixes by Bartek:

   fix ata_irq_enable() and ata_reset() for legacy ATA-1 devices

   in start_request() for REQ_DRIVE_ACB
   a) don't run ->prehandler() twice
   b) return ata_taskfile() value

--------------010602000509040909070100
Content-Type: text/plain;
 name="ide-clean-82.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-82.diff"

diff -urN linux-2.5.19/drivers/ide/device.c linux/drivers/ide/device.c
--- linux-2.5.19/drivers/ide/device.c	2002-06-02 23:03:00.000000000 +0200
+++ linux/drivers/ide/device.c	2002-06-02 22:48:12.000000000 +0200
@@ -105,11 +105,12 @@
 	if (!ch->io_ports[IDE_CONTROL_OFFSET])
 		return 0;
 
+	/* 0x08 is for legacy ATA-1 devices */
 	if (on)
-		OUT_BYTE(0x00, ch->io_ports[IDE_CONTROL_OFFSET]);
+		OUT_BYTE(0x08 | 0x00, ch->io_ports[IDE_CONTROL_OFFSET]);
 	else {
 		if (!ch->intrproc)
-			OUT_BYTE(0x02, ch->io_ports[IDE_CONTROL_OFFSET]);
+			OUT_BYTE(0x08 | 0x02, ch->io_ports[IDE_CONTROL_OFFSET]);
 		else
 			ch->intrproc(drive);
 	}
@@ -131,9 +132,11 @@
 		return;
 
 	printk("%s: reset\n", ch->name);
-	OUT_BYTE(0x04, ch->io_ports[IDE_CONTROL_OFFSET]);
+	/* 0x08 is for legacy ATA-1 devices */
+	OUT_BYTE(0x08 | 0x04, ch->io_ports[IDE_CONTROL_OFFSET]);
 	udelay(10);
-	OUT_BYTE(0x00, ch->io_ports[IDE_CONTROL_OFFSET]);
+	/* 0x08 is for legacy ATA-1 devices */
+	OUT_BYTE(0x08 | 0x00, ch->io_ports[IDE_CONTROL_OFFSET]);
 	do {
 		mdelay(50);
 		stat = IN_BYTE(ch->io_ports[IDE_STATUS_OFFSET]);
diff -urN linux-2.5.19/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.19/drivers/ide/ide.c	2002-06-02 23:03:06.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-06-02 22:48:20.000000000 +0200
@@ -754,14 +754,7 @@
 		if (!(ar))
 			goto args_error;
 
-		ata_taskfile(drive, ar, NULL);
-
-		if (((ar->command_type == IDE_DRIVE_TASK_RAW_WRITE) ||
-		     (ar->command_type == IDE_DRIVE_TASK_OUT)) &&
-				ar->prehandler && ar->handler)
-			return ar->prehandler(drive, rq);
-
-		return ide_started;
+		return ata_taskfile(drive, ar, NULL);
 	}
 
 	/* The normal way of execution is to pass and execute the request
diff -urN linux-2.5.19/drivers/ide/ide-pmac.c linux/drivers/ide/ide-pmac.c
--- linux-2.5.19/drivers/ide/ide-pmac.c	2002-06-02 23:03:06.000000000 +0200
+++ linux/drivers/ide/ide-pmac.c	2002-06-02 22:57:41.000000000 +0200
@@ -431,7 +431,7 @@
 		goto out;
 	}
 	udelay(10);
-	ata_irq_enale(drive, 0);
+	ata_irq_enable(drive, 0);
 	OUT_BYTE(command, IDE_NSECTOR_REG);
 	OUT_BYTE(SETFEATURES_XFER, IDE_FEATURE_REG);
 	OUT_BYTE(WIN_SETFEATURES, IDE_COMMAND_REG);
@@ -1577,9 +1577,9 @@
 	 */
 	if (used_dma && !ide_spin_wait_hwgroup(drive)) {
 		/* Lock HW group */
-		set_bit(IDE_BUSY, &drive->channel->active);
+		set_bit(IDE_BUSY, drive->channel->active);
 		pmac_ide_check_dma(drive);
-		clear_bit(IDE_BUSY, &drive->channel->active);
+		clear_bit(IDE_BUSY, drive->channel->active);
 		spin_unlock_irq(drive->channel->lock);
 	}
 #endif
@@ -1626,7 +1626,7 @@
 		return;
 	else {
 		/* Lock HW group */
-		set_bit(IDE_BUSY, &drive->channel->active);
+		set_bit(IDE_BUSY, drive->channel->active);
 		/* Stop the device */
 		idepmac_sleep_device(drive, idx, base);
 		spin_unlock_irq(drive->channel->lock);
@@ -1656,7 +1656,7 @@
 
 	/* We resume processing on the lock group */
 	spin_lock_irq(drive->channel->lock);
-	clear_bit(IDE_BUSY, &drive->channel->active);
+	clear_bit(IDE_BUSY, drive->channel->active);
 	if (!list_empty(&drive->queue.queue_head))
 		do_ide_request(&drive->queue);
 	spin_unlock_irq(drive->channel->lock);

--------------010602000509040909070100--

