Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314446AbSF2WwO>; Sat, 29 Jun 2002 18:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314433AbSF2WwN>; Sat, 29 Jun 2002 18:52:13 -0400
Received: from p015.as-l031.contactel.cz ([212.65.234.207]:43648 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S314422AbSF2WwJ>;
	Sat, 29 Jun 2002 18:52:09 -0400
Date: Sun, 30 Jun 2002 02:12:14 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: dalecki@evision-ventures.com, alex@ssi.bg, zwane@linux.realnet.co.sz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.24 IDE 95
Message-ID: <20020630001214.GF25118@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I know that IDE95 is broken when it comes to IDE, but... not only
that. Patch below does:

(1) ide-taskfile.c: ide_do_drive_cmd(..., ide_preempt) holds channel 
    lock. Do not reacquire. NMI watchdog triggered by just booting 
    computer with IDE cdrom.

(2) ide.c: if we clear BUSY, use goto ... instead of break. There is
    set_bit(IDE_BUSY, ch->active); below loop. Channel stopped by 'hdparm
    -I /dev/hdd': it uses ide_raw_taskfile() which sets REQ_SPECIAL.
    But ide-cd:ide_cdrom_do_request() does not handle REQ_SPECIAL,
    it returns ide_stopped immediately. And ide:do_request() does not
    cope with ide_stopped + empty queue correctly.

(3) unfixed: hdparm -I returns garbage on CDROM: REQ_SPECIAL command
    on CD drive returns success without trying to execute it in
    current driver. I think that ide-cd should handle direct interface
    to its registers properly.

Patch is for 2.5.24+IDE94+IDE95.
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz




diff -urdN linux/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux/drivers/ide/ide-taskfile.c	Sun Jun 30 00:54:05 2002
+++ linux/drivers/ide/ide-taskfile.c	Sat Jun 29 12:54:48 2002
@@ -209,10 +209,16 @@
 	rq->errors = 0;
 	rq->rq_status = RQ_ACTIVE;
 	rq->rq_dev = mk_kdev(major,(drive->select.b.unit)<<PARTN_BITS);
-	if (action == ide_wait)
+	if (action == ide_wait) {
 		rq->waiting = &wait;
-
-	spin_lock_irqsave(drive->channel->lock, flags);
+		spin_lock_irqsave(drive->channel->lock, flags);
+	} else if (action == ide_preempt) {
+		if (0 /* SMP... !spin_is_locked(drive->channel->lock) */) {
+			BUG();
+		}
+	} else {
+		BUG();
+	}
 
 	if (blk_queue_empty(&drive->queue) || action == ide_preempt) {
 		if (action == ide_preempt)
@@ -227,9 +233,9 @@
 
 	do_ide_request(q);
 
-	spin_unlock_irqrestore(drive->channel->lock, flags);
-
 	if (action == ide_wait) {
+		spin_unlock_irqrestore(drive->channel->lock, flags);
+
 		wait_for_completion(&wait);	/* wait for it to be serviced */
 		return rq->errors ? -EIO : 0;	/* return -EIO if errors */
 	}
diff -urdN linux/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux/drivers/ide/ide.c	Sun Jun 30 00:54:05 2002
+++ linux/drivers/ide/ide.c	Sat Jun 29 23:45:47 2002
@@ -864,7 +864,7 @@
 			if (!ata_can_queue(drive)) {
 				if (!ata_pending_commands(drive))
 					clear_bit(IDE_BUSY, ch->active);
-				break;
+				goto dontsetbusy;
 			}
 
 			drive->sleep = 0;
@@ -889,7 +889,7 @@
 				if (!ata_pending_commands(drive))
 					clear_bit(IDE_BUSY, ch->active);
 				drive->rq = NULL;
-				break;
+				goto dontsetbusy;
 			}
 
 			/* If there are queued commands, we can't start a
@@ -906,6 +906,7 @@
 		/* make sure the BUSY bit is set */
 		/* FIXME: perhaps there is some place where we miss to set it? */
 		set_bit(IDE_BUSY, ch->active);
+dontsetbusy:;		
 	}
 }
 
