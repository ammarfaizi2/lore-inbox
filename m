Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbUA0FwT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 00:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbUA0FwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 00:52:19 -0500
Received: from CPE0080c6f0a1ca-CM014280009361.cpe.net.cable.rogers.com ([24.157.199.55]:1540
	"EHLO stargazer") by vger.kernel.org with ESMTP id S262228AbUA0FwR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 00:52:17 -0500
Date: Tue, 27 Jan 2004 00:52:06 -0500
From: Glenn Wurster <gwurster@scs.carleton.ca>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, andre@linux-ide.org
Subject: Re: [PATCH] ide-dma.c, ide.c, ide.h, kernel 2.4.24
Message-ID: <20040127055206.GA690@electric.ath.cx>
References: <20040123183245.GB853@desktop> <20040123213329.GH22615@devserv.devel.redhat.com> <20040123220958.GA891@desktop> <200401240045.56966.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401240045.56966.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Glenn, your patch hides potential problems - these functions shouldn't be
> called if host doesn't support DMA.  However there is one place when
> ->ide_dma_host_off() shouldn't be called unconditionally, here is a patch.
> It is not pretty but at least consistent - we check hwif->ide_dma_check
> to see if DMA is supported in other places too.  Does it fix the problem?

Not quite.  If we go forward with a patch like that, then it must be
updated to include at least two other places that I know of
immediately.  The updated patch would be something similar to the one
at the bottom of this e-mail. 

On a further note, how should hdparm -d behave on my controller, the
relivant lines from dmesg are:

SIS5513: IDE controller at PCI slot 00:01.1
SIS5513: chipset revision 8
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS551x ATA 16 controller
    ide0: BM-DMA at 0xf870-0xf877, BIOS settings: hda:pio, hdb:pio
SIS5513: simplex device: DMA disabled
ide1: SIS5513 Bus-Master DMA disabled (BIOS)
hda: WDC AC21000H, ATA DISK drive
hdc: Maxtor 6Y080L0, ATA DISK drive

"hdparm -d 1 /dev/hdc" returns an operation not permitted, but "hdparm
-d 1 /dev/hda" is successful and results in future calls to "hdparm -d
1 /dev/hdc" seemingly locking the computer.

> Are you sure that it doesn't happen on 2.6.1?  Maybe you've used a bit
> different config (ie. compiled without DMA support)?

Oops, on further research it did exhibit the exact same problem.
Sorry about the misdiagnosis.

Let me know how I can continue to help.

Glenn.

[Sorry about my tardy response]

--- linux-2.4.24-orig/drivers/ide/ide-iops.c	2003-11-28 18:26:20.000000000 +0000
+++ linux-2.4.24/drivers/ide/ide-iops.c	2004-01-27 05:19:41.000000000 +0000
@@ -912,7 +912,8 @@
 //		ide_delay_50ms();
 
 #if defined(CONFIG_BLK_DEV_IDEDMA) && !defined(CONFIG_DMA_NONPCI)
-	hwif->ide_dma_host_off(drive);
+	if (hwif->ide_dma_check) /* Check if host supports DMA */ 
+		hwif->ide_dma_host_off(drive);
 #endif /* (CONFIG_BLK_DEV_IDEDMA) && !(CONFIG_DMA_NONPCI) */
 
 	/*
@@ -980,10 +981,13 @@
 	drive->id->dma_1word &= ~0x0F00;
 
 #if defined(CONFIG_BLK_DEV_IDEDMA) && !defined(CONFIG_DMA_NONPCI)
-	if (speed >= XFER_SW_DMA_0)
-		hwif->ide_dma_host_on(drive);
-	else
-		hwif->ide_dma_off_quietly(drive);
+	if (speed >= XFER_SW_DMA_0) {
+		if (hwif->ide_dma_check) /* Check if host supports DMA */
+			hwif->ide_dma_host_on(drive);
+	} else {
+		if (hwif->ide_dma_check) /* Check if host supports DMA */
+			hwif->ide_dma_off_quietly(drive);
+	}
 #endif /* (CONFIG_BLK_DEV_IDEDMA) && !(CONFIG_DMA_NONPCI) */
 
 	switch(speed) {
