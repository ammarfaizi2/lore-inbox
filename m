Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262775AbVAFIdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbVAFIdT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 03:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbVAFIdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 03:33:19 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:36561 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262775AbVAFIdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 03:33:14 -0500
Date: Thu, 6 Jan 2005 09:32:52 +0100
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, riel@redhat.com,
       marcelo.tosatti@cyclades.com, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: memory barrier in ll_rw_blk.c (was Re: [PATCH][5/?] count writeback pages in nr_scanned)
Message-ID: <20050106083251.GH17821@suse.de>
References: <Pine.LNX.4.61.0501052025450.11550@chimarrao.boston.redhat.com> <20050105173624.5c3189b9.akpm@osdl.org> <Pine.LNX.4.61.0501052240250.11550@chimarrao.boston.redhat.com> <41DCB577.9000205@yahoo.com.au> <20050105202611.65eb82cf.akpm@osdl.org> <41DCC014.80007@yahoo.com.au> <20050105204706.0781d672.akpm@osdl.org> <41DCC4C6.8000205@yahoo.com.au> <20050106080649.GE17821@suse.de> <41DCF3EC.3090506@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DCF3EC.3090506@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06 2005, Nick Piggin wrote:
> Jens Axboe wrote:
> >On Thu, Jan 06 2005, Nick Piggin wrote:
> 
> >>
> >>This memory barrier is not needed because the waitqueue will only get
> >>waiters on it in the following situations:
> >>
> >>rq->count has exceeded the threshold - however all manipulations of 
> >>->count
> >>are performed under the runqueue lock, and so we will correctly pick up 
> >>any
> >>waiter.
> >>
> >>Memory allocation for the request fails. In this case, there is no 
> >>additional
> >>help provided by the memory barrier. We are guaranteed to eventually wake
> >>up waiters because the request allocation mempool guarantees that if the 
> >>mem
> >>allocation for a request fails, there must be some requests in flight. 
> >>They
> >>will wake up waiters when they are retired.
> >
> >
> >Not sure I agree completely. Yes it will work, but only because it tests
> ><= q->nr_requests and I don't think that 'eventually' is good enough :-)
> >
> >The actual waitqueue manipulation doesn't happen under the queue lock,
> >so the memory barrier is needed to pickup the change on SMP. So I'd like
> >to keep the barrier.
> >
> 
> No that's right... but between the prepare_to_wait and the io_schedule,
> get_request takes the lock and checks nr_requests. I think we are safe?

It looks like it, yes you are right. But it looks to be needed a few
lines further down instead, though :-)

===== drivers/block/ll_rw_blk.c 1.281 vs edited =====
--- 1.281/drivers/block/ll_rw_blk.c     2004-12-01 09:13:57 +01:00
+++ edited/drivers/block/ll_rw_blk.c    2005-01-06 09:32:19 +01:00
@@ -1630,11 +1630,11 @@
        if (rl->count[rw] < queue_congestion_off_threshold(q))
                clear_queue_congested(q, rw);
        if (rl->count[rw]+1 <= q->nr_requests) {
-               smp_mb();
                if (waitqueue_active(&rl->wait[rw]))
                        wake_up(&rl->wait[rw]);
                blk_clear_queue_full(q, rw);
        }
+       smp_mb();
        if (unlikely(waitqueue_active(&rl->drain)) &&
            !rl->count[READ] && !rl->count[WRITE])
                wake_up(&rl->drain);

> >I'd prefer to add smp_mb() to waitqueue_active() actually!
> >
> 
> That may be a good idea (I haven't really taken much notice of how other
> code uses it).
> 
> I'm not worried about any possible performance advantages of removing it,
> rather just having a memory barrier without comments can be perplexing.

I fully agree, subtle things like that should always be commented.

-- 
Jens Axboe

