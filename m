Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262137AbUKDJRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262137AbUKDJRe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 04:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbUKDJRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 04:17:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5525 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262137AbUKDJRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 04:17:22 -0500
Date: Thu, 4 Nov 2004 10:16:47 +0100
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: blk_queue_congestion_threshold()
Message-ID: <20041104091646.GC14993@suse.de>
References: <200411031913_MC3-1-8DE3-3DC@compuserve.com> <41897C21.2030403@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41897C21.2030403@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04 2004, Nick Piggin wrote:
> Chuck Ebbert wrote:
> >  Looking at this function in ll_rw_blk.c:
> >
> >
> >static void blk_queue_congestion_threshold(struct request_queue *q)
> >{
> >        int nr;
> >
> >        nr = q->nr_requests - (q->nr_requests / 8) + 1;
> >        if (nr > q->nr_requests)
> >                nr = q->nr_requests;
> >        q->nr_congestion_on = nr;
> >
> >        nr = q->nr_requests - (q->nr_requests / 8) - 1;
> >        if (nr < 1)
> >                nr = 1;
> >        q->nr_congestion_off = nr;
> >}
> >
> >
> >  Why are the "on" and "off" thresholds the same, i.e. shouldn't there be 
> >  some
> 
> They aren't the same, there is some hysteresis.
> 
> >hysteresis?  Con Kolivas posted a patch that changed the "off" threshold to
> >"nr_requests - nr_requests/8 - nr_requests/16" and it was said to be 
> >better,
> >but it never made it into mainline (it also changed get_request_wait() and 
> >that
> >was never merged either):
> >
> 
> Patch was from Arjan. IIRC everyone agreed it looked good, and from
> all the feedback I have seen it has worked well. Jens just may not
> have had time to get it merged, or forgotten about it.
> 
> It can probably at least go to -mm for now.

It should just go to Linus, imho. It just got lost, I'll send it out
today.

> >--- patches/linux-2.6.9-rc4-ck1/drivers/block/ll_rw_blk.c       2004-10-12 
> >12:25:09.798003278 +0200
> >+++ linux-2.6.9-rc4-ck1/drivers/block/ll_rw_blk.c       2004-10-12 
> >12:25:42.959479479 +0200
> >@@ -100,7 +100,7 @@
> >                nr = q->nr_requests;
> >        q->nr_congestion_on = nr;
> > 
> >-       nr = q->nr_requests - (q->nr_requests / 8) - 1;
> >+       nr = q->nr_requests - (q->nr_requests / 8) - (q->nr_requests/16)- 
> >1;
> >        if (nr < 1)
> >                nr = 1;
> >        q->nr_congestion_off = nr;
> 
> The stuff below this hunk is a different thing altogether, and should
> not be merged.
> 
> >@@ -1758,8 +1758,10 @@
> > {
> >        DEFINE_WAIT(wait);
> >        struct request *rq;
> >+       struct io_context *ioc;
> > 
> >        generic_unplug_device(q);
> >+       ioc = get_io_context(GFP_NOIO);
> >        do {
> >                struct request_list *rl = &q->rq;
> > 
> >@@ -1769,7 +1771,6 @@
> >                rq = get_request(q, rw, GFP_NOIO);
> > 
> >                if (!rq) {
> >-                       struct io_context *ioc;
> > 
> >                        io_schedule();
> > 
> >@@ -1779,12 +1780,11 @@
> >                         * up to a big batch of them for a small period 
> >                         time.
> >                         * See ioc_batching, ioc_set_batching
> >                         */
> >-                       ioc = get_io_context(GFP_NOIO);
> >                        ioc_set_batching(q, ioc);
> >-                       put_io_context(ioc);
> >                }
> >                finish_wait(&rl->wait[rw], &wait);
> >        } while (!rq);
> >+       put_io_context(ioc);
> > 
> >        return rq;
> > }

Yes this isn't valid, as discussed several times on linux-kernel.

-- 
Jens Axboe

