Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262770AbVAFIHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbVAFIHW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 03:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbVAFIHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 03:07:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:7625 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262771AbVAFIHM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 03:07:12 -0500
Date: Thu, 6 Jan 2005 09:06:49 +0100
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, riel@redhat.com,
       marcelo.tosatti@cyclades.com, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
Message-ID: <20050106080649.GE17821@suse.de>
References: <20050105203217.GB17265@logos.cnet> <41DC7D86.8050609@yahoo.com.au> <Pine.LNX.4.61.0501052025450.11550@chimarrao.boston.redhat.com> <20050105173624.5c3189b9.akpm@osdl.org> <Pine.LNX.4.61.0501052240250.11550@chimarrao.boston.redhat.com> <41DCB577.9000205@yahoo.com.au> <20050105202611.65eb82cf.akpm@osdl.org> <41DCC014.80007@yahoo.com.au> <20050105204706.0781d672.akpm@osdl.org> <41DCC4C6.8000205@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DCC4C6.8000205@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06 2005, Nick Piggin wrote:
> Andrew Morton wrote:
> >Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> >
> >>> If the queue is not congested, blk_congestion_wait() will still sleep.  
> >>See
> >>> freed_request().
> >>> 
> >>
> >>Hmm... doesn't look like it to me:
> >>
> >>         if (rl->count[rw] < queue_congestion_off_threshold(q))
> >>                 clear_queue_congested(q, rw);
> >>
> >>And clear_queue_congested does an unconditional wakeup (if there
> >>is someone sleeping on the congestion queue).
> >
> >
> >That's my point.  blk_congestion_wait() will always sleep, regardless of
> >the queue's congestion state.
> >
> 
> Oh yes, but it will return as soon as a single request is finished.
> Which is probably a couple of milliseconds, rather than the 100 we
> had hoped for. So the allocators will wake up again and go around
> the loop and still make no progress.
> 
> However, if you had a plain io_schedule_timeout there, at least you
> would sleep for the full extend of the specified timeout.
> 
> BTW. Jens, now that I look at freed_request, is the memory barrier
> required? If so, what is it protecting?
> 

> 
> 
> This memory barrier is not needed because the waitqueue will only get
> waiters on it in the following situations:
> 
> rq->count has exceeded the threshold - however all manipulations of ->count
> are performed under the runqueue lock, and so we will correctly pick up any
> waiter.
> 
> Memory allocation for the request fails. In this case, there is no additional
> help provided by the memory barrier. We are guaranteed to eventually wake
> up waiters because the request allocation mempool guarantees that if the mem
> allocation for a request fails, there must be some requests in flight. They
> will wake up waiters when they are retired.

Not sure I agree completely. Yes it will work, but only because it tests
<= q->nr_requests and I don't think that 'eventually' is good enough :-)

The actual waitqueue manipulation doesn't happen under the queue lock,
so the memory barrier is needed to pickup the change on SMP. So I'd like
to keep the barrier.

I'd prefer to add smp_mb() to waitqueue_active() actually!

-- 
Jens Axboe

