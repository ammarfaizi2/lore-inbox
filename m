Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbTIWSJi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 14:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263276AbTIWSJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 14:09:38 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:27888 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S263183AbTIWSJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 14:09:35 -0400
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide-io.c, kernel 2.4.22 Fix for IO stats in /proc/partitions, was Re: sard/iostat disk I/O statistics/accounting for 2.5.8-pre3
References: <vfxk789refm.fsf@sgi.com> <20030921224753.GA4548@werewolf.able.es>
From: Chad Talbott <ctalbott@google.com>
Date: 23 Sep 2003 11:09:17 -0700
Message-ID: <vfx7k3z2x82.fsf@sgi.com>
In-Reply-To: <20030921224753.GA4548@werewolf.able.es>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> writes:

> On 09.15, Chad Talbott wrote:
> > I found the cause of ide disks' ios_in_flight going negative in
> > /proc/partitions.
> [...]

[broken patch elided...]

> Did you ever built this ? req -> rq ?

Good catch.  Not that patch, obviously.  :)  I don't know where I came
up with that one; even with the req -> rq change it includes the call
to req_finished_io, so it's exactly a no-op.

Here's the one that I compiled and tested. It makes /proc/partitions
report correctly.

Thanks,
Chad

--- linux-2.4.22-old/drivers/ide/ide-io.c	15 Sep 2003 17:41:32 -0000
+++ linux-2.4.22-new/drivers/ide/ide-io.c	23 Sep 2003 17:40:27 -0000
@@ -148,6 +148,7 @@
 	ide_hwif_t *hwif = HWIF(drive);
 	unsigned long flags;
 	struct request *rq;
+	struct completion *waiting;
 
 	spin_lock_irqsave(&io_request_lock, flags);
 	rq = HWGROUP(drive)->rq;
@@ -221,7 +222,12 @@
 	spin_lock_irqsave(&io_request_lock, flags);
 	blkdev_dequeue_request(rq);
 	HWGROUP(drive)->rq = NULL;
-	end_that_request_last(rq);
+
+	waiting = rq->waiting;
+	blkdev_release_request(rq);
+	if (waiting)
+		complete(waiting);
+
 	spin_unlock_irqrestore(&io_request_lock, flags);
 }
 

