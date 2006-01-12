Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbWALSDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbWALSDo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 13:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbWALSDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 13:03:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:18953 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932518AbWALSDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 13:03:43 -0500
Date: Thu, 12 Jan 2006 19:05:41 +0100
From: Jens Axboe <axboe@suse.de>
To: Jurriaan on adsl-gate <thunder7@xs4all.nl>
Cc: neilb@suse.de, linux-raid@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-mm3 hangs during boot (raid related?)
Message-ID: <20060112180541.GV3945@suse.de>
References: <20060112062310.GA12471@gates.of.nowhere> <17349.63738.220760.681335@cse.unsw.edu.au> <20060112172900.GA3687@gates.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060112172900.GA3687@gates.of.nowhere>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12 2006, Jurriaan on adsl-gate wrote:
> From: Neil Brown <neilb@suse.de>
> Date: Thu, Jan 12, 2006 at 05:36:42PM +1100
> Sent-To: 
> > On Thursday January 12, thunder7@xs4all.nl wrote:
> > > 
> > > 2.6.15-mm3 hangs during boot for me, after the lines
> > > 
> > > ========
> > > md4: bitmap initialized from disk: read 15/15 pages, set 51 bits, status: 0
> > > created bitmap (224 pages) for device md4
> > > ========
> > > 
> > > ctrl-alt-del to reboot works sometimes (2 out of 3). Below is complete
> > > dmesg (from 2.6.15-mm2, ver_linux output, .config and raid details).
> > 
> > Yep, this is probably a known problem with recent changes to the
> > 'barrier' code.
> > 
> > Try to convince md not to use barrier by changing md_super_write in
> > drivers/md/md.c.  Simply remove
> > 
> > 	if (!test_bit(BarriersNotsupp, &rdev->flags)) {
> > 		struct bio *rbio;
> > 		rw |= (1<<BIO_RW_BARRIER);
> > 		rbio = bio_clone(bio, GFP_NOIO);
> > 		rbio->bi_private = bio;
> > 		rbio->bi_end_io = super_written_barrier;
> > 		submit_bio(rw, rbio);
> > 	} else
> > 
> > leaving the
> > 		submit_bio(rw, rbio);
> > 
> > which comes after it.
> > 
> With this patch, it boots and works just fine.

Please reverse that patch and try this on top of -mm2/3 instead (it's
the patch from Tejun to fix the actual issue, from another similar
thread):

diff --git a/block/elevator.c b/block/elevator.c
index 1b5b5d9..f905e47 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -615,23 +615,23 @@ void elv_completed_request(request_queue
 	 * request is released from the driver, io must be done
 	 */
 	if (blk_account_rq(rq)) {
-		struct request *first_rq = list_entry_rq(q->queue_head.next);
-
 		q->in_flight--;
+		if (blk_sorted_rq(rq) && e->ops->elevator_completed_req_fn)
+			e->ops->elevator_completed_req_fn(q, rq);
+	}
 
-		/*
-		 * Check if the queue is waiting for fs requests to be
-		 * drained for flush sequence.
-		 */
-		if (q->ordseq && q->in_flight == 0 &&
+	/*
+	 * Check if the queue is waiting for fs requests to be
+	 * drained for flush sequence.
+	 */
+	if (unlikely(q->ordseq)) {
+		struct request *first_rq = list_entry_rq(q->queue_head.next);
+		if (q->in_flight == 0 &&
 		    blk_ordered_cur_seq(q) == QUEUE_ORDSEQ_DRAIN &&
 		    blk_ordered_req_seq(first_rq) > QUEUE_ORDSEQ_DRAIN) {
 			blk_ordered_complete_seq(q, QUEUE_ORDSEQ_DRAIN, 0);
 			q->request_fn(q);
 		}
-
-		if (blk_sorted_rq(rq) && e->ops->elevator_completed_req_fn)
-			e->ops->elevator_completed_req_fn(q, rq);
 	}
 }


-- 
Jens Axboe

