Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288588AbSADKen>; Fri, 4 Jan 2002 05:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288587AbSADKed>; Fri, 4 Jan 2002 05:34:33 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:57868 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S288588AbSADKeU>;
	Fri, 4 Jan 2002 05:34:20 -0500
Date: Fri, 4 Jan 2002 21:30:18 +1100
From: Anton Blanchard <anton@samba.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
Message-ID: <20020104103018.GA22745@krispykreme>
In-Reply-To: <Pine.LNX.4.33.0201040050440.1363-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201040050440.1363-100000@localhost.localdomain>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Great stuff Ingo!

> now that new-year's parties are over things are getting boring again. For
> those who want to see and perhaps even try something more complex, i'm
> announcing this patch that is a pretty radical rewrite of the Linux
> scheduler for 2.5.2-pre6:

Good timing :) We were just looking at an application that hit sched_yield
heavily on a large SMP machine (dont have the source so fixing the
symptoms not the cause). Performance was pretty bad with the standard
scheduler.

We managed to get a 4 way ppc64 machine to boot, but unfortunately the
18 way hung somewhere after smp initialisation and before execing
init. More testing to come :)

Is the idle loop optimisation (atomic exchange -1 into need_resched
to avoid IPI) gone forever?

Is my understanding of this right?:

#define BITMAP_SIZE (MAX_RT_PRIO/8+1)

...

char bitmap[BITMAP_SIZE+1];
list_t queue[MAX_RT_PRIO];

You have an bitmap of size MAX_RT_PRIO+1 (actually I think you have one too
many +1 here :) and you zero the last bit to terminate it. You use
find_first_zero_bit to search the entire priority list and
sched_find_first_zero_bit to search only the first MAX_PRIO (64) bits.

> the SMP load-balancer can be extended/switched with additional parallel
> computing and cache hierarchy concepts: NUMA scheduling, multi-core CPUs
> can be supported easily by changing the load-balancer. Right now it's
> tuned for my SMP systems.

It will be interesting to test this on our HMT hardware.

> - the SMP idle-task startup code was still racy and the new scheduler
> triggered this. So i streamlined the idle-setup code a bit. We do not call
> into schedule() before all processors have started up fully and all idle
> threads are in place.

I like this cleanup, it pushes more stuff out the arch specific code
into init_idle().

> another benchmark measures sched_yield() performance. (which the pthreads
> code relies on pretty heavily.)

Can you send me this benchmark and I'll get some more results :)

I dont think pthreads uses sched_yield on spinlocks any more, but there
seems to be enough userspace code that does. 

Anton
