Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbTIOUW6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 16:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbTIOUW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 16:22:58 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:49359 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261566AbTIOUW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 16:22:56 -0400
To: jo-lkml@suckfuell.net, hch@infradead.org
Subject: [PATCH] ide-io.c, kernel 2.4.22 Fix for IO stats in /proc/partitions, was Re: sard/iostat disk I/O statistics/accounting for 2.5.8-pre3
Cc: linux-kernel@vger.kernel.org
From: Chad Talbott <ctalbott@google.com>
Date: 15 Sep 2003 13:21:01 -0700
Message-ID: <vfxk789refm.fsf@sgi.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found the cause of ide disks' ios_in_flight going negative in
/proc/partitions.

It's due to unbalanced calls to up_ios and down_ios.  After an
explicit drive command, ide-io.c's ide_end_drive_cmd calls
end_that_request_last which eventually calls down_ios to decrement
ios_in_flight, however there is no corresponding call to up_ios when
the command is initiated.

My guess is that ios_in_flight goes negative when the drive is idle
because many people run hdparm in an init script, and this decrements
ios_in_flight early on.  It stays off center from there.

The following hack to ide_end_drive_cmd is a workaround, I would
rather call up_ios appropriately, so that explicit ide commands are
properly accounted.  However I'm having a hard time identifying all
the places that initiate a low-level drive command.  I'll look into a
proper fix, but someone else probably knows the ide layer better than
me.

Chad

--- linux-2.4.18-old/drivers/ide/ide-io.c	15 Sep 2003 17:41:32 -0000
+++ linux-2.4.18-new/drivers/ide/ide-io.c	15 Sep 2003 20:11:12 -0000
@@ -148,6 +148,7 @@
 	ide_hwif_t *hwif = HWIF(drive);
 	unsigned long flags;
 	struct request *rq;
+	struct completion *waiting;
 
 	spin_lock_irqsave(&io_request_lock, flags);
 	rq = HWGROUP(drive)->rq;
@@ -221,7 +222,13 @@
 	spin_lock_irqsave(&io_request_lock, flags);
 	blkdev_dequeue_request(rq);
 	HWGROUP(drive)->rq = NULL;
-	end_that_request_last(rq);
+
+	waiting = req->waiting;
+	req_finished_io(req);
+	blkdev_release_request(req);
+	if (waiting)
+		complete(waiting);
+
 	spin_unlock_irqrestore(&io_request_lock, flags);
 }
 

