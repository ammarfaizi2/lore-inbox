Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbTE0Gl0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 02:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbTE0Gl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 02:41:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:40921 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262709AbTE0GlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 02:41:24 -0400
Date: Tue, 27 May 2003 08:54:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] add ata scsi driver
Message-ID: <20030527065436.GX845@suse.de>
References: <20030526205725.GT845@suse.de> <Pine.LNX.4.44.0305261429550.13489-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305261429550.13489-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26 2003, Linus Torvalds wrote:
> 
> On Mon, 26 May 2003, Jens Axboe wrote:
> > 
> > > Think of all the fairness issues we've had in the elevator code, and 
> > > realize that the low-level disk probably implements _none_ of those 
> > > fairness algorithms.
> > 
> > I think it does, to some extent at least.
> 
> I doubt they do a very good job of it. I know of bad cases, even with 
> "high-end" hardware. Sure, we can hope that it's getting better, but do we 
> want to bet on it.

No I agree, it's always nice to handle these cases in software so we
don't have to rely on these things getting fixed.

> > > Hmm.. Where does it keep track of request latency for requests that have 
> > > been removed from the queue?
> > 
> > Well, it doesn't...
> 
> Yeah. Which means that right now _really_ long starvation will show up as
> timeouts, while other cases will just show up as bad latency.
> 
> Which will _work_, of course (assuming the timeout handling is correct,
> which is a big if in itself), but it still sucks from a usability
> standpoint.
> 
> Even if we drop our timeouts from 30 seconds (or whatever they are now)
> down to just a few seconds, that's a _loooong_ time, and we should be a
> lot more proactive about things. Audio/video stuff tends to want things
> with latencies in the tenth-of-a-second range, even when they buffer
> things up internally to hide the worst cases.

Here's something ridicolously simple, that just wont start a new tag if
the oldest tag is older than 100ms. Clearly nothing for submission, but
it gets the point across.

Now only look at reads, and we've got something a little useful at
least.

James, speaking of queue localities and tcq... Doug mentioned some time
ago that aic7xxx dishes out tags numbers from a hba pool which makes it
impossible to support with out current block layer queueing code. Maybe
it we associate the blk_queue_tag structure with a bunch of queues
instead of having a 1:1 mapping it could work.

===== drivers/block/ll_rw_blk.c 1.170 vs edited =====
--- 1.170/drivers/block/ll_rw_blk.c	Thu May  8 11:30:11 2003
+++ edited/drivers/block/ll_rw_blk.c	Tue May 27 08:44:44 2003
@@ -574,6 +574,13 @@
 		BUG();
 	}
 
+	if (!list_empty(&bqt->busy_list)) {
+		struct request *__rq = list_entry_rq(bqt->busy_list.prev);
+
+		if (time_after(rq->timeout, jiffies))
+			return 1;
+	}
+
 	for (map = bqt->tag_map; *map == -1UL; map++) {
 		tag += BLK_TAGS_PER_LONG;
 
@@ -589,6 +596,7 @@
 	bqt->tag_index[tag] = rq;
 	blkdev_dequeue_request(rq);
 	list_add(&rq->queuelist, &bqt->busy_list);
+	rq->timeout = jiffies + HZ / 10;
 	bqt->busy++;
 	return 0;
 }

-- 
Jens Axboe

