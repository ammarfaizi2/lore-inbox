Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264320AbTIISkD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 14:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264329AbTIISkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 14:40:03 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:9705 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264320AbTIISj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 14:39:57 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Message-Id: <1063132760.642.15.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 09 Sep 2003 20:39:20 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: [PATCH] IDE: Fix Power Management request race on resume
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus !

The current IDE Power Management code I wrote has a race on wakeup
when the master device got resumed, it may take a request. At this
point, a PM resume request to a slave device of the same hwgroup
would clear hwgroup->rq and cause an Oops when the master device
request completes.

This patch fixes it. Due to the context in which PM resume requests
are sent, just not clearing hwgroup->rq for these is enough.

Please apply, this patch was already tested & discussed with Bart.

I also removed a useless debug message in the PM code that was
actually misleading (people though it indicated a problem while it
didn't, it's really useless) and fix a typo in a comment.

Cheers,
Ben.

diff -urN linux-2.5/drivers/ide/ide-io.c linuxppc-2.5-benh/drivers/ide/ide-io.c
--- linux-2.5/drivers/ide/ide-io.c	2003-09-09 20:15:34.000000000 +0200
+++ linuxppc-2.5-benh/drivers/ide/ide-io.c	2003-09-09 20:31:23.000000000 +0200
@@ -928,13 +928,10 @@
 		 * 
 		 * We let requests forced at head of queue with ide-preempt
 		 * though. I hope that doesn't happen too much, hopefully not
-		 * unless the subdriver triggers such a thing in it's own PM
+		 * unless the subdriver triggers such a thing in its own PM
 		 * state machine.
 		 */
 		if (drive->blocked && !blk_pm_request(rq) && !(rq->flags & REQ_PREEMPT)) {
-#ifdef DEBUG_PM
-			printk("%s: a request made it's way while we are power managing...\n", drive->name);
-#endif
 			/* We clear busy, there should be no pending ATA command at this point. */
 			hwgroup->busy = 0;
 			break;
@@ -1417,8 +1414,9 @@
 	}
 
 	spin_lock_irqsave(&ide_lock, flags);
-	if (action == ide_preempt || action == ide_head_wait) {
+	if (action == ide_preempt)
 		hwgroup->rq = NULL;
+	if (action == ide_preempt || action == ide_head_wait) {
 		where = ELEVATOR_INSERT_FRONT;
 		rq->flags |= REQ_PREEMPT;
 	}


