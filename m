Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271706AbTHILzL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 07:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272336AbTHILzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 07:55:11 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:1254 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S271706AbTHILzH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 07:55:07 -0400
Date: Sat, 9 Aug 2003 13:55:06 +0200 (MEST)
Message-Id: <200308091155.h79Bt66Y015611@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.6.0-test3] fix ide-scsi for ide_drive_t->queue change
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes ide-scsi.c for the ide_drive_t->queue type change
in 2.6.0-test3.

Without the patch you'll get these new warnings in -test3:

drivers/scsi/ide-scsi.c: In function `idescsi_abort':
drivers/scsi/ide-scsi.c:875: warning: passing arg 1 of `elv_queue_empty' from incompatible pointer type
drivers/scsi/ide-scsi.c: In function `idescsi_reset':
drivers/scsi/ide-scsi.c:902: warning: passing arg 1 of `elv_next_request' from incompatible pointer type

/Mikael

diff -ruN linux-2.6.0-test3/drivers/scsi/ide-scsi.c linux-2.6.0-test3.ide-scsi-fixes-2.6.0-test3/drivers/scsi/ide-scsi.c
--- linux-2.6.0-test3/drivers/scsi/ide-scsi.c	2003-07-28 01:24:44.000000000 +0200
+++ linux-2.6.0-test3.ide-scsi-fixes-2.6.0-test3/drivers/scsi/ide-scsi.c	2003-08-09 12:58:38.000000000 +0200
@@ -872,7 +872,7 @@
 			continue;
 		}
 		/* no, but is it queued in the ide subsystem? */
-		if (elv_queue_empty(&drive->queue)) {
+		if (elv_queue_empty(drive->queue)) {
 			spin_unlock_irqrestore(&ide_lock, flags);
 			return SUCCESS;
 		}
@@ -899,7 +899,7 @@
 		schedule_timeout(1);
 	}
 	/* now nuke the drive queue */
-	while ((req = elv_next_request(&drive->queue))) {
+	while ((req = elv_next_request(drive->queue))) {
 		blkdev_dequeue_request(req);
 		end_that_request_last(req);
 	}
