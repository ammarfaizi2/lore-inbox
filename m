Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261572AbSJMRFY>; Sun, 13 Oct 2002 13:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261574AbSJMRFY>; Sun, 13 Oct 2002 13:05:24 -0400
Received: from h-66-167-78-17.SNVACAID.covad.net ([66.167.78.17]:17878 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261572AbSJMRFW>; Sun, 13 Oct 2002 13:05:22 -0400
Date: Sun, 13 Oct 2002 10:11:03 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: alan@lxorguk.ukuu.org.uk, andre@linux-ide.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Patch?: linux-2.5.42/drivers/ide/ide-probe.c null pointer dereference
Message-ID: <20021013101103.A1304@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


	Linux-2.5.42 introduced a new IDE driver function
HWIF(drive)->ide_dma_queued_on().  It appears that if the device does
not do DMA at all, ide_dma_queued_on will be set to NULL.  I guess that
is intentional, as that other code in drivers/ide actually checks
for the possibility that ide_dma_queue_on may be null.

	Anyhow, when I booted 2.5.42, I got a null pointer dereference,
and I think it was because the system that I booted had an ATAPI CDROM
drive and I think my chip set and drive combination does not do DMA for
ATAPI devices.

	Anyhow, the following patch made the problem go away, although
I'm not that confident of the correctness of the fix.  For what it's worth,
I am composing this email on the system running the changed code.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ide-probe.diff"

--- linux-2.5.42/drivers/ide/ide-probe.c	2002-10-11 21:22:09.000000000 -0700
+++ linux/drivers/ide/ide-probe.c	2002-10-13 09:57:02.000000000 -0700
@@ -806,7 +806,8 @@
 	ide_toggle_bounce(drive, 1);
 
 #ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
-	HWIF(drive)->ide_dma_queued_on(drive);
+	if (HWIF(drive)->ide_dma_queued_on)
+		HWIF(drive)->ide_dma_queued_on(drive);
 #endif
 }
 

--r5Pyd7+fXNt84Ff3--
