Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbUCHMYQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 07:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbUCHMYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 07:24:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:23464 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262470AbUCHMYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 07:24:09 -0500
Date: Mon, 8 Mar 2004 04:24:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: blk_congestion_wait racy?
Message-Id: <20040308042411.3b2cc9dd.akpm@osdl.org>
In-Reply-To: <20040308095919.GA1117@mschwid3.boeblingen.de.ibm.com>
References: <20040308095919.GA1117@mschwid3.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
>
> Hi,
> we have a stupid little program that linearly allocates and touches
> memory. We use this to see how fast s390 can swap. If this is combined
> with the fastest block device we have (xpram) we see a very strange
> effect:
> 
> 2.6.4-rc2 with 1 cpu
> # time ./mempig 600
> Count (1Meg blocks) = 600
> 600  of 600
> Done.
> 
> real    0m2.516s
> user    0m0.150s
> sys     0m0.570s
> #
> 
> 2.6.4-rc2 with 2 cpus
> # time ./mempig 600
> Count (1Meg blocks) = 600
> 600  of 600
> Done.
> 
> real    0m56.086s
> user    0m0.110s
> sys     0m0.630s
> #

Interesting.

> I have the suspicion that the call to blk_congestion_wait in
> try_to_free_pages is part of the problem. It initiates a wait for
> a queue to exit congestion but this could already have happened
> on another cpu before blk_congestion_wait has setup the wait
> queue. In this case the process sleeps for 0.1 seconds.

The comment may be a bit stale.  The idea is that the VM needs to take a
nap while the disk system retires some writes.  So we go to sleep until a
write request gets put back.  We do this regardless of the queue's
congestion state - the queue could have thousands of request slots and may
never even become congested.

> the swap test setup this happens all the time. If I "fix"
> blk_congestion_wait not to wait:
> 
> diff -urN linux-2.6/drivers/block/ll_rw_blk.c linux-2.6-fix/drivers/block/ll_rw_blk.c
> --- linux-2.6/drivers/block/ll_rw_blk.c	Fri Mar  5 14:50:28 2004
> +++ linux-2.6-fix/drivers/block/ll_rw_blk.c	Fri Mar  5 14:51:05 2004
> @@ -1892,7 +1892,9 @@
>  
>  	blk_run_queues();
>  	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
> +#if 0
>  	io_schedule_timeout(timeout);
> +#endif
>  	finish_wait(wqh, &wait);
>  }

Gad, that'll make the VM scan its guts out.

> then the system reacts normal again:
> 
> 2.6.4-rc2 + "fix" with 1 cpu
> # time ./mempig 600
> Count (1Meg blocks) = 600
> 600  of 600
> Done.
> 
> real    0m2.523s
> user    0m0.200s
> sys     0m0.880s
> #
> 
> 2.6.4-rc2 + "fix" with 2 cpu
> # time ./mempig 600
> Count (1Meg blocks) = 600
> 600  of 600
> Done.
> 
> real    0m2.029s
> user    0m0.250s
> sys     0m1.560s
> #

system time was doubled though.

> Since it isn't a solution to remove the call to io_schedule_timeout
> I tried to understand what the event is, that blk_congestion_wait
> is waiting for. The comment says it waits for a queue to exit congestion.

It's just waiting for a write request to complete.  It's a pretty crude way
of throttling page reclaim to the I/O system's speed.

> That is starting from prepare_to_wait it waits for a call to
> clear_queue_congested. In my test scenario NO queue is congested on
> enter to blk_congestion_wait. I'd like to see a proper wait_event
> there but it is non-trivial to define the event to wait for.
> Any useful hints ?

Nope, something is obviously broken.   I'll take a look.

Perhaps with two CPUs you are able to get kswapd and mempig running page
reclaim at the same time, which causes seekier swap I/O patterns than with
one CPU, where we only run one app or the other at any time.

Serialising balance_pgdat() and try_to_free_pages() with a global semaphore
would be a way of testing that theory.

