Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261609AbTC0Xnw>; Thu, 27 Mar 2003 18:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261614AbTC0Xnw>; Thu, 27 Mar 2003 18:43:52 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:62105 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S261609AbTC0XnR>; Thu, 27 Mar 2003 18:43:17 -0500
Date: Fri, 28 Mar 2003 00:54:19 +0100 (MET)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       Andre Hedrick <andre@linux-ide.org>, Jens Axboe <axboe@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] IDE 2.5.66-masked_irq-fix-A0
In-Reply-To: <Pine.SOL.4.30.0303280051390.6453-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.SOL.4.30.0303280052480.6453-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# Revert previous masked_irq handling for ide_do_request().
# Fixes "hda: lost interrupt" bug.
#
# Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

diff -uNr linux-2.5.66/drivers/ide/ide-io.c linux/drivers/ide/ide-io.c
--- linux-2.5.66/drivers/ide/ide-io.c	Tue Mar 25 22:53:09 2003
+++ linux/drivers/ide/ide-io.c	Tue Mar 25 22:54:33 2003
@@ -850,14 +850,14 @@
 		 * happens anyway when any interrupt comes in, IDE or otherwise
 		 *  -- the kernel masks the IRQ while it is being handled.
 		 */
-		if (hwif->irq != masked_irq)
+		if (masked_irq && hwif->irq != masked_irq)
 			disable_irq_nosync(hwif->irq);
 		spin_unlock(&ide_lock);
 		local_irq_enable();
 			/* allow other IRQs while we start this request */
 		startstop = start_request(drive, rq);
 		spin_lock_irq(&ide_lock);
-		if (hwif->irq != masked_irq)
+		if (masked_irq && hwif->irq != masked_irq)
 			enable_irq(hwif->irq);
 		if (startstop == ide_released)
 			goto queue_next;
@@ -873,7 +873,7 @@
  */
 void do_ide_request(request_queue_t *q)
 {
-	ide_do_request(q->queuedata, IDE_NO_IRQ);
+	ide_do_request(q->queuedata, 0);
 }

 /*
@@ -1021,7 +1021,7 @@
 				hwgroup->busy = 0;
 		}
 	}
-	ide_do_request(hwgroup, IDE_NO_IRQ);
+	ide_do_request(hwgroup, 0);
 	spin_unlock_irqrestore(&ide_lock, flags);
 }

@@ -1311,7 +1311,7 @@
 		insert_end = 0;
 	}
 	__elv_add_request(&drive->queue, rq, insert_end, 0);
-	ide_do_request(hwgroup, IDE_NO_IRQ);
+	ide_do_request(hwgroup, 0);
 	spin_unlock_irqrestore(&ide_lock, flags);

 	err = 0;


