Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264940AbTFYTLd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 15:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264943AbTFYTLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 15:11:32 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:51636
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264940AbTFYTLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 15:11:30 -0400
Date: Wed, 25 Jun 2003 21:25:23 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
Subject: Re: [PATCH] io stalls
Message-ID: <20030625192523.GB19940@dualathlon.random>
References: <1055353360.23697.235.camel@tiny.suse.com> <20030611181217.GX26270@dualathlon.random> <1055356032.24111.240.camel@tiny.suse.com> <20030611183503.GY26270@dualathlon.random> <3EE7D1AA.30701@cyberone.com.au> <20030612012951.GG1500@dualathlon.random> <1055384547.24111.322.camel@tiny.suse.com> <3EE7E876.80808@cyberone.com.au> <20030612024608.GE1415@dualathlon.random> <1056567822.10097.133.camel@tiny.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1056567822.10097.133.camel@tiny.suse.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 03:03:43PM -0400, Chris Mason wrote:
> Hello all,
> 
> [ short version, the patch attached should fix io latencies in 2.4.21. 
> Please review and/or give it a try ]
>  
> My last set of patches was directed at reducing the latencies in
> __get_request_wait, which really helped reduce stalls when you had lots
> of io to one device and balance_dirty() was causing pauses while you
> tried to do io to other devices.
> 
> But, a streaming write could still starve reads to the same device,
> mostly because the read would have to send down any huge merged writes
> that were before it in the queue.
> 
> Andrea's kernel has a fix for this too, he limits the total number of
> sectors that can be in the request queue at any given time.  But, his
> patches change blk_finished_io, both in the arguments it takes and the
> side effects of calling it.  I don't think we can merge his current form
> without breaking external drivers.
> 
> So, I added a can_throttle flag to the queue struct, drivers can enable
> it if they are going to call the new blk_started_sectors and
> blk_finished_sectors funcs any time they call blk_{started,finished}_io,
> and these do all the -aa style sector throttling.
> 
> There were a few other small changes to Andrea's patch, he wasn't
> setting q->full when get_request decided there were too many sectors in

wasn't is really in the past, because I'm doing it in 2.4.21rc8aa1 and
in my latest status.

> flight.  This resulted in large latencies in __get_request_wait.  He was
> also unconditionally clearing q->full in blkdev_release_request, my code
> only clears q->full when all the waiters are gone.

my current code including the older 2.4.21rc8aa1 does that too, merged
from your previous patches.

> I changed generic_unplug_device to zero the elevator_sequence field of
> the last request on the queue.  This means there won't be any merges
> with requests pending once an unplug is done, and helps limit the number
> of sectors that need to be sent down during the run_task_queue(&tq_disk)
> in wait_on_buffer.

this sounds like an hack, forbidding merges is pretty bad for
performance in general, of course most of the merging happens in between
the unplugs, but during heavy I/O with frequent unplugs from many
readers this may hurt performance. And as you said this mostly has the
advantage of limiting the size of the queue, like I enforce in my tree
with the elevator-lowlatency. I doubt this is right.

> I lowered the -aa default limit on sectors in flight from 4MB to 2MB. 

I got a few complains for performance slowdown, originally it was 2MB,
so I increased it to 4, from 4M it should be enough for most hardware.

> We probably want an elvtune for it, large arrays with writeback cache
> should be able to tolerate larger values.

Yes, it largely depends on the speed of the device.

> There's still a little work left to do, this patch enables sector
> throttling for scsi and IDE.  cciss, DAC960 and cpqarray need
> modification too (99% done already in -aa).  No sense in doing that
> until after the bulk of the patch is reviewed though.
> 
> As before, most of the code here is from Andrea and Nick, I've just
> wrapped a lot of duct tape around it and done some tweaking.  The
> primary pieces are:
> 
> fix-pausing (andrea, corner cases where wakeups are missed)
> elevator-low-latency (andrea, limit sectors in flight)
> queue_full (Nick, fairness in __get_request_wait)
> 
> I've removed my latency stats for __get_request_wait in hopes of making
> it a better merging candidate.

this is very similar to my status in -aa, exept for the hack that
forbids merging which I think is wrong and the fact you miss the 
wake_up_nr that I added to give a meaning to the batching again and that
you don't avoid the unplugs in get_request_wait_wakeup until the queue
is empty. I mean this:

+static void get_request_wait_wakeup(request_queue_t *q, int rw)
+{
+	/*
+	 * avoid losing an unplug if a second __get_request_wait did the
+	 * generic_unplug_device while our __get_request_wait was
running
+	 * w/o the queue_lock held and w/ our request out of the queue.
+	 */
+	if (q->rq[rw].count == 0 && waitqueue_active(&q->wait_for_requests[rw]))
+		__generic_unplug_device(q);
+}
+

you said last week the above is racy and it even hanged your box, could
you elaborate? The above is in 2.4.21rc8aa1 and it works fine so far
(though especially the race in wait_for_request is never been known to
be reproducible)

thanks,

Andrea
