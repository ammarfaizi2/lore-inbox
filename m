Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272824AbRILODP>; Wed, 12 Sep 2001 10:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272829AbRILODG>; Wed, 12 Sep 2001 10:03:06 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:19304 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S272824AbRILOC7>; Wed, 12 Sep 2001 10:02:59 -0400
Date: Wed, 12 Sep 2001 16:03:13 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
        Paul Mckenney <paul.mckenney@us.ibm.com>
Subject: Re: 2.4.10pre7aa1
Message-ID: <20010912160313.A695@athlon.random>
In-Reply-To: <20010912163426.A5979@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010912163426.A5979@in.ibm.com>; from dipankar@in.ibm.com on Wed, Sep 12, 2001 at 04:34:26PM +0530
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2001 at 04:34:26PM +0530, Dipankar Sarma wrote:
> In article <20010912182440.3975719b.rusty@rustcorp.com.au> you wrote:
> > On Mon, 10 Sep 2001 17:54:17 +0200
> > Andrea Arcangeli <andrea@suse.de> wrote:
> >> Only in 2.4.10pre7aa1: 00_rcu-1
> >> 
> >> 	wait_for_rcu and call_rcu implementation (from IBM). I did some
> >> 	modifications with respect to the original version from IBM.
> >> 	In particular I dropped the vmalloc_rcu/kmalloc_rcu, the
> >> 	rcu_head must always be allocated in the data structures, it has
> >> 	to be a field of a class, rather than hiding it in the allocation
> >> 	and playing dirty and risky with casts on a bigger allocation.
> 
> > Hi Andrea, 
> 
> > 	Like the kernel threads approach, but AFAICT it won't work for the case of two CPUs running wait_for_rcu at the same time (on a 4-way or above).

Good catch!

As for your alternate approch patch I've a few comments:

1) there maybe an RT tasks running, shrinking ram without reschedules in
between (ignore the current page_alloc that does a bogus schedule before
starting memory balancing), so schedule may never run and the RT task
can run oom, so you should at least set need_resched of the interesting
cpus + send the IPI reschedule before returning from call_rcu to avoid
to be starved

2) the real design issue here if we should pay 8k per-cpu and zero cpu
cost for the fast paths, or if we want to pay with a new branch in
schedule() fast path, I preferred the krcud approch for that reason:

+       if (atomic_read(&rcu_pending))
+               goto rcu_process;
+rcu_process_back:

> The patch I submitted to Andrea had logic to make sure that
> two CPUs don't execute wait_for_rcu() at the same time.
> Somehow it seems to have got lost in Andrea's modifications.

I think the bug was in your original patch too, I'm pretty sure I didn't
broke anything while changing the API a little.

> I will look at that and submit a new patch to Andrea, if necessary.

I prefer to allow all cpus to enter wait_for_rcu at the same time rather
than putting a serializing semaphore around wait_for_rcu (it should
scale pretty well if we don't serialize around wait_for_rcu).

The way I prefer to fix it is just to replace the rcu_sema with a per-cpu
semaphore and have wait_for_rcu running down on such per-cpu semaphore
of the interesting cpu, should be a few liner patch (we have space
free for it in the per-cpu rcu_data cacheline).

> As for wrappers, I am agnostic. However, I think sooner or later
> people will start asking for them, if we go by our past experience.

Maybe I'm missing something but what's the problem in allocating the
struct rcu_head in the data structure? I don't think it's not much more
complicated than the cast magics, and in general I prefer to avoid casts
on larger buffers to get advantage of the C compile time sanity checking ;).

Andrea
