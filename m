Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288594AbSADK4H>; Fri, 4 Jan 2002 05:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288595AbSADKz5>; Fri, 4 Jan 2002 05:55:57 -0500
Received: from mx2.elte.hu ([157.181.151.9]:61319 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288594AbSADKzt>;
	Fri, 4 Jan 2002 05:55:49 -0500
Date: Fri, 4 Jan 2002 13:53:14 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <20020104103018.GA22745@krispykreme>
Message-ID: <Pine.LNX.4.33.0201041338590.2717-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Jan 2002, Anton Blanchard wrote:

> Good timing :) We were just looking at an application that hit
> sched_yield heavily on a large SMP machine (dont have the source so
> fixing the symptoms not the cause). Performance was pretty bad with
> the standard scheduler.

hey, great. I mean, what a pity :-| But in any case, sched_yield() is just
a tiny portion of the scheduler spectrum, and it's certainly not the most
important one.

> We managed to get a 4 way ppc64 machine to boot, but unfortunately the
> 18 way hung somewhere after smp initialisation and before execing
> init. More testing to come :)

could this be the child-runs-first problem perhaps? You can disable it by
exchanging wake_up_forked_process() for wake_up_process() in fork.c, and
removing the current->need_resched = 1 line.

> Is the idle loop optimisation (atomic exchange -1 into need_resched to
> avoid IPI) gone forever?

it's just broken temporarily, i will fix it. The two places the need to
set need_resched is the timer interrupt (that triggers periodic
load_balance()) and the wakeup code, i'll fix this in the next patch.

> Is my understanding of this right?:
>
> #define BITMAP_SIZE (MAX_RT_PRIO/8+1)
>
> ...
>
> char bitmap[BITMAP_SIZE+1];
> list_t queue[MAX_RT_PRIO];
>
> You have an bitmap of size MAX_RT_PRIO+1 (actually I think you have
> one too many +1 here :) [...]

[ yes :-) paranoia. will fix it. ]

>           [...] and you zero the last bit to terminate it. You
> use find_first_zero_bit to search the entire priority list and
> sched_find_first_zero_bit to search only the first MAX_PRIO (64) bits.

correct.

the reason for this logic inversion is temporary as well: we'll have to
add find_next_set_bit before doing the more intuitive thing of setting the
bit when the runlist is active. Right now sched_find_first_zero_bit() has
to invert the value (on x86) again to get it right for BSFL.

> > - the SMP idle-task startup code was still racy and the new scheduler
> > triggered this. So i streamlined the idle-setup code a bit. We do not call
> > into schedule() before all processors have started up fully and all idle
> > threads are in place.
>
> I like this cleanup, it pushes more stuff out the arch specific code
> into init_idle().

the new rules are this: no schedule() must be called before all bits in
wait_init_idle are clear. I'd suggest for you to add this to the top of
schedule():

	if (wait_init_idle)
		BUG();

to debug the SMP startup code.

the other new property is that the init thread wakes itself up and then
later on becomes an idle thread just like the other idle threads. This
makes the idle startup code more symmetric, and the scheduler more
debuggable.

	Ingo

