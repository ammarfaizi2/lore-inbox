Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265417AbTFZFfK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 01:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265419AbTFZFfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 01:35:10 -0400
Received: from static-ctb-210-9-247-235.webone.com.au ([210.9.247.235]:777
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S265417AbTFZFfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 01:35:01 -0400
Message-ID: <3EFA8920.8050509@cyberone.com.au>
Date: Thu, 26 Jun 2003 15:48:16 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Andrea Arcangeli <andrea@suse.de>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
Subject: Re: [PATCH] io stalls
References: <1055296630.23697.195.camel@tiny.suse.com>	 <20030611021030.GQ26270@dualathlon.random>	 <1055353360.23697.235.camel@tiny.suse.com>	 <20030611181217.GX26270@dualathlon.random>	 <1055356032.24111.240.camel@tiny.suse.com>	 <20030611183503.GY26270@dualathlon.random> <3EE7D1AA.30701@cyberone.com.au>	 <20030612012951.GG1500@dualathlon.random>	 <1055384547.24111.322.camel@tiny.suse.com> <3EE7E876.80808@cyberone.com.au>	 <20030612024608.GE1415@dualathlon.random> <1056567822.10097.133.camel@tiny.suse.com>
In-Reply-To: <1056567822.10097.133.camel@tiny.suse.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chris Mason wrote:

>Hello all,
>
>[ short version, the patch attached should fix io latencies in 2.4.21. 
>Please review and/or give it a try ]
> 
>My last set of patches was directed at reducing the latencies in
>__get_request_wait, which really helped reduce stalls when you had lots
>of io to one device and balance_dirty() was causing pauses while you
>tried to do io to other devices.
>
>But, a streaming write could still starve reads to the same device,
>mostly because the read would have to send down any huge merged writes
>that were before it in the queue.
>
>Andrea's kernel has a fix for this too, he limits the total number of
>sectors that can be in the request queue at any given time.  But, his
>patches change blk_finished_io, both in the arguments it takes and the
>side effects of calling it.  I don't think we can merge his current form
>without breaking external drivers.
>
>So, I added a can_throttle flag to the queue struct, drivers can enable
>it if they are going to call the new blk_started_sectors and
>blk_finished_sectors funcs any time they call blk_{started,finished}_io,
>and these do all the -aa style sector throttling.
>
>There were a few other small changes to Andrea's patch, he wasn't
>setting q->full when get_request decided there were too many sectors in
>flight.  This resulted in large latencies in __get_request_wait.  He was
>also unconditionally clearing q->full in blkdev_release_request, my code
>only clears q->full when all the waiters are gone.
>
>I changed generic_unplug_device to zero the elevator_sequence field of
>the last request on the queue.  This means there won't be any merges
>with requests pending once an unplug is done, and helps limit the number
>of sectors that need to be sent down during the run_task_queue(&tq_disk)
>in wait_on_buffer.
>
>I lowered the -aa default limit on sectors in flight from 4MB to 2MB. 
>We probably want an elvtune for it, large arrays with writeback cache
>should be able to tolerate larger values.
>
>There's still a little work left to do, this patch enables sector
>throttling for scsi and IDE.  cciss, DAC960 and cpqarray need
>modification too (99% done already in -aa).  No sense in doing that
>until after the bulk of the patch is reviewed though.
>
>As before, most of the code here is from Andrea and Nick, I've just
>wrapped a lot of duct tape around it and done some tweaking.  The
>primary pieces are:
>
>fix-pausing (andrea, corner cases where wakeups are missed)
>elevator-low-latency (andrea, limit sectors in flight)
>queue_full (Nick, fairness in __get_request_wait)
>

I am hoping to go a slightly different way in 2.5 pending
inclusion of process io contexts. If you had time to look
over my changes there (in current mm tree) it would be
appreciated, but they don't help your problem for 2.4.

I found that my queue full fairness for 2.4 didn't address
the batching issue well. It does, guarantee lowest possible
maximum latency for singular requests, but due to lowered
throughput this can cause worse "high level" latency.

I couldn't find a really good, comprehensive method of
allowing processes to batch without resorting to very
complex wakeup methods unless process io contexts are used.
The other possibility would be to keep a list of "batching"
processes which should achieve the same as io contexts.

An easier approach would be to just allow the last woken
process to submit a batch of requests. This wouldn't have
as good guaranteed fairness, but not to say that it would
have starvation issues. I'll help you implement it if you
are interested.



