Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbVJFBDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbVJFBDi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 21:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbVJFBDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 21:03:38 -0400
Received: from gate.crashing.org ([63.228.1.57]:17603 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751206AbVJFBDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 21:03:36 -0400
Subject: Re: IDE issues with  "choose_drive"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jens Axboe <axboe@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       list linux-ide <linux-ide@vger.kernel.org>
In-Reply-To: <1128559019.22073.19.camel@gaston>
References: <1128559019.22073.19.camel@gaston>
Content-Type: text/plain
Date: Thu, 06 Oct 2005 11:02:48 +1000
Message-Id: <1128560569.22073.25.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The first one is the one I'm trying to fix, it's basically a hang on
> wakeup from sleep. What happens is that both drives are blocked
> (suspended, drive->blocked is set). Their IO queues contains some
> requests that haven't been serviced yet. We receive the resume()
> callback for one of them. We react by inserting a wakeup request at the
> head of the queue and waiting for it to complete. However, when we reach
> ide_do_request(), choose_drive() may return the other drive (the one
> that is still sleeping). In this case, we hit the test for blocked queue
> and just break out of the loop. We end up never servicing the other
> drive queue which is the one we are trying to wakeup, thus we hang.

Oh, and here's the ugly workaround beeing tested by the users who are
having the problem so far. Not really a proper fix though...

--- linux-work.orig/drivers/ide/ide-io.c	2005-09-22 14:06:31.000000000 +1000
+++ linux-work/drivers/ide/ide-io.c	2005-10-06 10:49:53.000000000 +1000
@@ -1101,6 +1101,7 @@
 	ide_hwif_t	*hwif;
 	struct request	*rq;
 	ide_startstop_t	startstop;
+	int             loops = 0;
 
 	/* for atari only: POSSIBLY BROKEN HERE(?) */
 	ide_get_lock(ide_intr, hwgroup);
@@ -1153,6 +1154,7 @@
 			/* no more work for this hwgroup (for now) */
 			return;
 		}
+	again:
 		hwif = HWIF(drive);
 		if (hwgroup->hwif->sharing_irq &&
 		    hwif != hwgroup->hwif &&
@@ -1192,8 +1194,14 @@
 		 * though. I hope that doesn't happen too much, hopefully not
 		 * unless the subdriver triggers such a thing in its own PM
 		 * state machine.
+		 *
+		 * We count how many times we loop here to make sure we service
+		 * all drives in the hwgroup without looping for ever
 		 */
 		if (drive->blocked && !blk_pm_request(rq) && !(rq->flags & REQ_PREEMPT)) {
+			drive = drive->next ? drive->next : hwgroup->drive;
+			if (loops++ < 4 && !blk_queue_plugged(drive->queue))
+				goto again;
 			/* We clear busy, there should be no pending ATA command at this point. */
 			hwgroup->busy = 0;
 			break;


