Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272837AbRILOhx>; Wed, 12 Sep 2001 10:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272838AbRILOhn>; Wed, 12 Sep 2001 10:37:43 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:48848 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S272837AbRILOhc>; Wed, 12 Sep 2001 10:37:32 -0400
Date: Wed, 12 Sep 2001 20:12:29 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
        Paul Mckenney <paul.mckenney@us.ibm.com>
Subject: Re: 2.4.10pre7aa1
Message-ID: <20010912201229.F5819@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20010912163426.A5979@in.ibm.com> <20010912160313.A695@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010912160313.A695@athlon.random>; from andrea@suse.de on Wed, Sep 12, 2001 at 04:03:13PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2001 at 04:03:13PM +0200, Andrea Arcangeli wrote:
> > > 	Like the kernel threads approach, but AFAICT it won't work for the case of two CPUs running wait_for_rcu at the same time (on a 4-way or above).
> 
> Good catch!

It barfs on our 4way with the FD management patch and chat benchmark :-)

> > The patch I submitted to Andrea had logic to make sure that
> > two CPUs don't execute wait_for_rcu() at the same time.
> > Somehow it seems to have got lost in Andrea's modifications.
> 
> I think the bug was in your original patch too, I'm pretty sure I didn't
> broke anything while changing the API a little.

You changed the way I maintained the wait_list and current_list.
The basic logic was that new callbacks are always added to the
wait list. The wait_for_rcu() is started only if current_list
was empty and we just moved the wait_list to current_list. The
key step was moving the wait_list to current_list *after* doing
a wait_for_rcu(). This prevents another CPU from doing a wait_for_rcu().
Either that or I missed something big time :-)


> 
> > I will look at that and submit a new patch to Andrea, if necessary.
> 
> I prefer to allow all cpus to enter wait_for_rcu at the same time rather
> than putting a serializing semaphore around wait_for_rcu (it should
> scale pretty well if we don't serialize around wait_for_rcu).

Serializing is not what I want to do either. Instead the other
CPUs just add to the wait_list and return if there is a wait_for_rcu()
going on. What we have seen is that relatively larger batches around
a single recurring wait_for_rcu() will do reasonably well in terms
of performance.

> 
> The way I prefer to fix it is just to replace the rcu_sema with a per-cpu
> semaphore and have wait_for_rcu running down on such per-cpu semaphore
> of the interesting cpu, should be a few liner patch (we have space
> free for it in the per-cpu rcu_data cacheline).

It should be possible to do this. However, I am not sure we would
really benefit significantly from allowing multiple wait_for_rcu()s
to run parallelly. I would much rather see per-CPU lists implemented
and avoid keventd eventually.


> 
> > As for wrappers, I am agnostic. However, I think sooner or later
> > people will start asking for them, if we go by our past experience.
> 
> Maybe I'm missing something but what's the problem in allocating the
> struct rcu_head in the data structure? I don't think it's not much more
> complicated than the cast magics, and in general I prefer to avoid casts
> on larger buffers to get advantage of the C compile time sanity checking ;).

One disadvantage of the wrappers is that we would be wasting most of
the L1 cache line for rcu_head and that could be relatively significant for 
a small frequently allocated structure. And no, I don't see any problem asking
people to allocate the rcu_head in the data structure.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> Project: http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
