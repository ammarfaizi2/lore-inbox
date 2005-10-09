Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbVJIAkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbVJIAkQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 20:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbVJIAkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 20:40:16 -0400
Received: from gate.crashing.org ([63.228.1.57]:46048 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932197AbVJIAkP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 20:40:15 -0400
Subject: [PATCH] ide: Workaround PM problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Content-Type: text/plain
Date: Sun, 09 Oct 2005 10:37:47 +1000
Message-Id: <1128818268.17365.90.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The logic in ide_do_request() doesn't guarantee that both drives will be
serviced after a call. It may "forget" to service one in some circumstances,
including when one of the drive is suspended (it will eventually fail to
service the slave when the master is suspended for example). This prevents
the wakeup requests that gets queued on wakeup from sleep from beeing serviced
in some cases when 2 drives are sharing an IDE bus.

The problem is deep enough in the way this code works (and there are probably
a few other problematic but rare corner cases) and fixing it would require
some major rethinking of the way IDE decides which channel to service. This
is not 2.6.14 material. However, in the meantime, Bart has accepted this simple
workaround that will fix the crash on wakeup from sleep since this specific
corner case is actually hitting users to get into 2.6.14.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/ide/ide-io.c
===================================================================
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


