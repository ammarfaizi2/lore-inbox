Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318626AbSHUSiJ>; Wed, 21 Aug 2002 14:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318627AbSHUSiJ>; Wed, 21 Aug 2002 14:38:09 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:48644 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S318626AbSHUSiI>; Wed, 21 Aug 2002 14:38:08 -0400
Message-ID: <3D63DE8A.9F139B42@zip.com.au>
Date: Wed, 21 Aug 2002 11:40:10 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@sgi.com>
CC: phillips@arcor.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lock assertion macros for 2.5.31
In-Reply-To: <20020808172335.GA29509@sgi.com> <Pine.LNX.4.44L.0208081435400.2589-100000@duckman.distro.conectiva> <20020808173933.GA29474@sgi.com> <E17czxG-0000e8-00@starship> <20020812210336.GA40112@sgi.com> <3D5829B9.D281B855@zip.com.au> <20020812223645.GB40343@sgi.com> <3D5840E9.89C8680C@zip.com.au> <20020821182627.GA62297@sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
> 
> On Mon, Aug 12, 2002 at 04:12:41PM -0700, Andrew Morton wrote:
> > ...
> > #define might_sleep() BUG_ON(preempt_count())
> >
> > _this_ would catch numerous bugs, including code which is not buggy
> > in 2.4, but became buggy when wild-eyed loonies changed core kernel
> > rules without even looking at what drivers were doing (rant).
> >
> > I expect something like this will fall out of the wash soon, at
> > least for preemptible kernels.
> 
> Is it really that simple?

It sure is:

/**
 * in_atomic_region() - determine whether it is legal to perform a context
 *                      switch
 *
 * The in_atomic_region() predicate returns true if the current task is
 * executing atomically, and may not perform a context switch.
 *
 * If preemption is enabled, in_atomic_region() is most accurate, because it
 * returns true if this task has taken any spinlocks.
 *
 * If preemption is disabled then there is no spinlocking record available, and
 * we can only look at the interrupt state.
 *
 * If the task has taken a lock_kernel() then it is still legal to perform a
 * context switch.
 */
#ifdef CONFIG_PREEMPT
#define in_atomic_region() (preempt_count() - !!(current->lock_depth + 1))
#else
#define in_atomic_region() in_interrupt()
#endif

/**
 * may_sleep() - debugging check for possible illegal scheduling.
 *
 * may_sleep() is to be used in code paths which _may_ perform a context switch.
 * It will force a BUG if the caller is executing in an atomic region.
 */
extern void __in_atomic_region(char *file, int line);
#define may_sleep()							\
	do {								\
		if (in_atomic_region())					\
			__in_atomic_region(__FILE__, __LINE__);		\
	} while (0)

>  Maybe it should go into sched.h sometime
> soon?  I guess the real work is sprinkling it in all the places where
> it needs to go.

Well I added checks just to kmalloc, kmem_cache_alloc, __alloc_pages
and saw a shower of bloopers during bootup.  Such as drivers/ide/probe.c:init_irq()
calling request_irq() inside ide_lock.

> Anyway, here's an updated version of the lock assertion patch.

Well I like it.  It's unintrusive, imparts useful info to the reader
and checks stuff at runtime.

>  Should
> it be split into two patches, one that implements the macros and
> another that puts checks everywhere?

I don't think it needs splitting.  You have the core infrastructure plus
a couple of example applications.

>  Should I add a small doc to
> Documentation/ (maybe the might_sleep() could be documented there
> too)?

These things are self-evident and even self-checking.  They don't need
supporting documentation.   I'll put out a test tree RSN, include this
in it.
