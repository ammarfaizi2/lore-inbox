Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315455AbSE2T6t>; Wed, 29 May 2002 15:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315456AbSE2T6s>; Wed, 29 May 2002 15:58:48 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:35311 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S315455AbSE2T6p>; Wed, 29 May 2002 15:58:45 -0400
Subject: Re: [PATCH] updated O(1) scheduler for 2.4
From: Robert Love <rml@mvista.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020529191336.GK31701@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 29 May 2002 12:58:43 -0700
Message-Id: <1022702324.985.37.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-05-29 at 12:13, Andrea Arcangeli wrote:

> of course, I'm asking why not cli/sti, see my current status of
> incrmental fixes on top of the o1 scheduler, some old in -aa, some from
> -ac

Right.  I suspect Ingo knew something, otherwise he would not of used
the save/restore variant... but it is good to remove it if we can.

> (I dropped an optimization from you, I assume it's ok but quite
> frankly I don't care about the performance of setting the cpu affinity
> and I preferred to stay safe in sync with -ac and 2.5),

Well, that optimize is not just for benefiting the affinity syscalls but
any caller of set_cpus_allowed ... but OK.  However, it is now in 2.5.19
and should be in 2.4.19-pre9-ac1 as I pushed it to Alan.

> some new noticed
> while mering (and still uncertain about the questions). also the
> force_cpu_reschedule from the 2.5 rcu-poll was buggy and that's fixed
> too now in my tree.
> 
> beware I cannot test anything yet, the tree still doesn't compile, it seems
> the last thing to make uml link is to update the init_task, then I will
> also need to do the same for x86-64 at least, and possibly other archs
> if Robert didn't took care of them. after x86-64 and uml works I will
> check sparc64 alpha and finally x86 smp + up.

There are missing bits from non-x86 architectures.  I am going to get to
that next but as I only have x86 it will be slow.  I suspect it is very
easy, however - just grabbing the bitop instructions from include/asm. 
I deliberately did not backport any changes that had significant
arch-specific ramifications.

> --- ./kernel/sched.c.~1~	Wed May 29 04:50:30 2002
> +++ ./kernel/sched.c	Wed May 29 05:22:04 2002
> @@ -569,7 +569,7 @@ skip_queue:
>  #define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
>  	((jiffies - (p)->sleep_timestamp > cache_decay_ticks) &&	\
>  		((p) != (rq)->curr) &&					\
> -			((p)->cpus_allowed & (1 << (this_cpu))))
> +			((p)->cpus_allowed & (1UL << (this_cpu))))
>  
>  	if (!CAN_MIGRATE_TASK(tmp, busiest, this_cpu)) {
>  		curr = curr->next;

Ahh, good eye...

> see the above serie of patches, again it may be broken, still untested yet.

I need to look into your patches and the current behavior, as I do not
see anything broken with the current implementation.

> I actually removed it enterely, need_resched will be fore sure read
> before overwriting it because it's guaranteed by reading and writing to
> the same mem address.
> 
> still I wonder if the other cpu will see the need_resched set when it
> goes to read it, I can imagine a needed wmb() on the writer cpu and an rmb() in
> the reader, hopefully it serializes via the spinlocks, I didn't touch
> this area, but if the wmb() was meant to be after need_resced = 1, that
> had to be one line below, so still it would be a bug, the wmb() in such
> place looks superflous so I dropped it until somebody comments.

Best to ask Ingo his intentions here.

> > But resched_task is the only bit from 2.5 I have not fully back
> > ported...take a look at resched_task in 2.5: I need to bring that to
> > 2.4.  I suspect idle polling is broken in 2.4, too.
> 
> your version looks ok at first glance.

Regards,

	Robert Love

