Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265031AbTFYUEp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 16:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265036AbTFYUEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 16:04:45 -0400
Received: from 216-42-72-146.ppp.netsville.net ([216.42.72.146]:60807 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S265031AbTFYUEl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 16:04:41 -0400
Subject: Re: [PATCH] io stalls
From: Chris Mason <mason@suse.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
In-Reply-To: <20030625192523.GB19940@dualathlon.random>
References: <1055353360.23697.235.camel@tiny.suse.com>
	 <20030611181217.GX26270@dualathlon.random>
	 <1055356032.24111.240.camel@tiny.suse.com>
	 <20030611183503.GY26270@dualathlon.random> <3EE7D1AA.30701@cyberone.com.au>
	 <20030612012951.GG1500@dualathlon.random>
	 <1055384547.24111.322.camel@tiny.suse.com> <3EE7E876.80808@cyberone.com.au>
	 <20030612024608.GE1415@dualathlon.random>
	 <1056567822.10097.133.camel@tiny.suse.com>
	 <20030625192523.GB19940@dualathlon.random>
Content-Type: text/plain
Organization: 
Message-Id: <1056572288.10091.161.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 25 Jun 2003 16:18:09 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-25 at 15:25, Andrea Arcangeli wrote:

> > There were a few other small changes to Andrea's patch, he wasn't
> > setting q->full when get_request decided there were too many sectors in
> 
> wasn't is really in the past, because I'm doing it in 2.4.21rc8aa1 and
> in my latest status.
> 

Hmm, I thought I grabbed the patch from rc8aa1, clearly not though,
sorry about that.

> > I changed generic_unplug_device to zero the elevator_sequence field of
> > the last request on the queue.  This means there won't be any merges
> > with requests pending once an unplug is done, and helps limit the number
> > of sectors that need to be sent down during the run_task_queue(&tq_disk)
> > in wait_on_buffer.
> 
> this sounds like an hack, forbidding merges is pretty bad for
> performance in general, of course most of the merging happens in between
> the unplugs, but during heavy I/O with frequent unplugs from many
> readers this may hurt performance. And as you said this mostly has the
> advantage of limiting the size of the queue, like I enforce in my tree
> with the elevator-lowlatency. I doubt this is right.
> 

Well, I would hit sysrq-t when I noticed read stalls, and the reader was
frequently in run_task_queue.  I kept the hunk because it made a
noticeable difference.  I agree there's a throughput tradeoff here, my
goal for the patch was to find the major places I could improve latency
and change them, then go back later and decide if each one was worth it.

Your elevator-lowlatency patch doesn't enforce sector limits for merged
requests, so a merger could constantly come in and steal space in the
sector limit from other waiters.  This lead to high latency in
__get_request_wait.  That hunk for generic_unplug_device solves both of
those problems.
 
> > I lowered the -aa default limit on sectors in flight from 4MB to 2MB. 
> 
> I got a few complains for performance slowdown, originally it was 2MB,
> so I increased it to 4, from 4M it should be enough for most hardware.
> 

I've no preference really.  I didn't notice a throughput difference but
my scsi drives only have 2MB of cache.

> this is very similar to my status in -aa, exept for the hack that
> forbids merging which I think is wrong and the fact you miss the 
> wake_up_nr that I added to give a meaning to the batching again and that
> you don't avoid the unplugs in get_request_wait_wakeup until the queue
> is empty. I mean this:
> 
> +static void get_request_wait_wakeup(request_queue_t *q, int rw)
> +{
> +	/*
> +	 * avoid losing an unplug if a second __get_request_wait did the
> +	 * generic_unplug_device while our __get_request_wait was
> running
> +	 * w/o the queue_lock held and w/ our request out of the queue.
> +	 */
> +	if (q->rq[rw].count == 0 && waitqueue_active(&q->wait_for_requests[rw]))
> +		__generic_unplug_device(q);
> +}
> +
> 
> you said last week the above is racy and it even hanged your box, could
> you elaborate? The above is in 2.4.21rc8aa1 and it works fine so far
> (though especially the race in wait_for_request is never been known to
> be reproducible)

It caused hangs/stalls, but I didn't have the sector throttling code at
the time and it really changes the interaction of things.  I think the
hang went a little like this:

Lets say all the pending io is done, but the wait queue isn't empty yet
because all the waiting tasks haven't yet been scheduled in.  Also, we
have fewer than nr_requests processes waiting to start io, so when they
do all get scheduled in they won't generate an unplug.

q->rq.count = q->nr_requests, q->full = 1

new io comes in, sees q->full = 1, unplugs and sleeps.  No io is done
because the queue is empty.

All the old waiters finally get scheduled in and grab their requests,
but get_request_wait_wakeup doesn't unplug because q->rq.count != 0.

If no additional io comes in, the queue never gets unplugged, and our
waiter never gets woken.

With the sector throttling on, we've got additional wakeups coming from
blk_finished_io (or blk_finished_sectors in my patch).  I kept out the
wakeup_nr idea because I couldn't figure out how to keep
__get_request_wait fair with it in.

-chris


