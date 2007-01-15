Return-Path: <linux-kernel-owner+w=401wt.eu-S1751156AbXAOR52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbXAOR52 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 12:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbXAOR52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 12:57:28 -0500
Received: from www.osadl.org ([213.239.205.134]:59180 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751137AbXAOR51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 12:57:27 -0500
Subject: [patch-mm] Workaround for RAID breakage
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Neil Brown <neilb@cse.unsw.edu.au>,
       LKML <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>
In-Reply-To: <1168848513.2941.100.camel@localhost.localdomain>
References: <6bffcb0e0701120533o609489den9ca02f42e4d4839@mail.gmail.com>
	 <20070115071747.GA31267@elte.hu>
	 <1168848513.2941.100.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 15 Jan 2007 19:03:39 +0100
Message-Id: <1168884220.2941.144.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-15 at 09:08 +0100, Thomas Gleixner wrote:
> > Thomas saw something similar yesterday and he the partial results that 
> > git.block (between rc2-mm1 and rc4-mm1) breaks certain disk drivers or 
> > filesystems drivers. For me it worked fine, so it must be only on some 
> > combinations. The changes to ll_rw_block.c look quite extensive.
> 
> Yes. Jens Axboe confirmed yesterday that the plug changes broke RAID.

I tracked this down and found two problems:

- The new plug/unplug code does not check for underruns. That allows the
plug count (ioc->plugged) to become negative. This gets triggered from
various places. 

AFAICS this is intentional to avoid checks all over the place, but the
underflow check is missing. All we need to do is make sure, that in case
of ioc->plugged == 0 we return early and bug, if there is either a queue
plugged in or the plugged_list is not empty.

Jens ?

- The raid1 code has no bitmap set in remount r/w. So the
pending_bio_list gets not processed for quite a time. The workaround is
to kick mddev->thread, so the list is processed. Not sure about that.

Neil ?

At least it boots and behaves normal.

	tglx


Index: linux-2.6.20-rc4-mm1/block/ll_rw_blk.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/block/ll_rw_blk.c
+++ linux-2.6.20-rc4-mm1/block/ll_rw_blk.c
@@ -3757,6 +3757,12 @@ void blk_unplug_current(void)
 	if (!ioc)
 		return;
 
+	if (!ioc->plugged) {
+		BUG_ON(!list_empty(&ioc->plugged_list));
+		BUG_ON(ioc->plugged_queue);
+		return;
+	}
+
 	ioc->plugged--;
 	if (ioc->plugged)
 		return;
Index: linux-2.6.20-rc4-mm1/drivers/md/raid1.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/drivers/md/raid1.c
+++ linux-2.6.20-rc4-mm1/drivers/md/raid1.c
@@ -897,7 +897,7 @@ static int make_request(request_queue_t 
 
 	spin_unlock_irqrestore(&conf->device_lock, flags);
 
-	if (do_sync)
+	if (do_sync || !bitmap)
 		md_wakeup_thread(mddev->thread);
 #if 0
 	while ((bio = bio_list_pop(&bl)) != NULL)



