Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbUAMBou (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 20:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbUAMBou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 20:44:50 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:54502 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263472AbUAMBom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 20:44:42 -0500
Message-Id: <200401130142.i0D1ghM05647@owlet.beaverton.ibm.com>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Iostats reporting problems was: Linux 2.4.24-pre3 
In-reply-to: Your message of "Wed, 31 Dec 2003 10:51:35 PST."
             <20031231185135.GD1882@matchmail.com> 
Date: Mon, 12 Jan 2004 17:42:43 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I've made it through the challenging weather we've had here in the
Northwest and I do have a patch for you to try.

    Without the patch any of the 10 of 11 fields can go negative after
    enough activity, not just rd_ios.

True enough.  This is unusual but on an active machine with good uptime,
you'll use up those 31 bits soon enough. Giving an extra bit will postpone
it a little longer in addition to simply looking more correct.  It's up
to any application using these numbers, however, to watch for wraparound.

    With or without these patches, when there is activity on a partition
    ios_in_flight[1] looks sane for the individual partition statistics
    since ios_in_flight doesn't go negative, but the same activity
    causes ios_in_flight on the drive (hda instead of hda1 for example)
    to be consistantly negative (usually -2 or -3 in my case) with brief
    periods of being positive.  This causes use and aveq (hd->io_ticks
    and hd->aveq in the kernel) to have bogus numbers.

In 2.6, we noted that not all requests that come through the request code
are I/O requests.  SCSI devices are particularly prone to this but other
devices may also have non-IO requests come through from time to time.
This skews the ios_in_flight number, typically making it appear more
IOs completed than were started.  The accounting functions needed to
only be called for true IO requests.

    I'm hoping that there is a nice patch that has been waiting around
    somewhere, and that it's trivial enough for 2.4.24 inclusion.

It's trivial if it does the trick.  I've included it below.  I don't
have a machine which exhibits the problem but I did compile and run this
patch with no obviously ill effects.  Let me know if it fixes things.

I'm also sending, in a separate message, a 2.4-relevant version of the
iostats.txt that I wrote for 2.6, to be included in Documentation to
help the next poor sot who has to puzzle over these mysterious numbers.

Rick

diff -rup linux-2.4.24/drivers/block/ll_rw_blk.c linux-2.4.24-rl/drivers/block/ll_rw_blk.c
--- linux-2.4.24/drivers/block/ll_rw_blk.c	Fri Nov 28 10:26:19 2003
+++ linux-2.4.24-rl/drivers/block/ll_rw_blk.c	Mon Jan 12 17:10:20 2004
@@ -859,7 +859,8 @@ EXPORT_SYMBOL(req_finished_io);
 static inline void add_request(request_queue_t * q, struct request * req,
 			       struct list_head *insert_here)
 {
-	drive_stat_acct(req->rq_dev, req->cmd, req->nr_sectors, 1);
+	if (blk_fs_request(req))
+		drive_stat_acct(req->rq_dev, req->cmd, req->nr_sectors, 1);
 
 	if (!q->plugged && q->head_active && insert_here == &q->queue_head) {
 		spin_unlock_irq(&io_request_lock);
@@ -1493,7 +1494,9 @@ void end_that_request_last(struct reques
 	if (laptop_mode && req->cmd == READ)
 		mod_timer(&writeback_timer, jiffies + 5 * HZ);
 
-	req_finished_io(req);
+	if (blk_fs_request(req))
+		req_finished_io(req);
+
 	blkdev_release_request(req);
 	if (waiting)
 		complete(waiting);
