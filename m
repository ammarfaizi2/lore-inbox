Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262302AbSITMBJ>; Fri, 20 Sep 2002 08:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262338AbSITMBJ>; Fri, 20 Sep 2002 08:01:09 -0400
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:25221 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S262302AbSITMBI>; Fri, 20 Sep 2002 08:01:08 -0400
Date: Fri, 20 Sep 2002 05:06:06 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020920120606.GA4961@gnuppy.monkey.org>
References: <20020920102031.GA4744@gnuppy.monkey.org> <Pine.LNX.4.44.0209201231430.2954-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209201231430.2954-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2002 at 12:47:12PM +0200, Ingo Molnar wrote:
> our kernel thread context switch latency is below 1 usec on a typical P4
> box, so our NPT library should compare pretty favorably even in such
> benchmarks. We get from the pthread_create() call to the first user
> instruction of the specified thread-function code in less than 2 usecs,
> and we get from pthread_exit() to the thread that does the pthread_join()
> in less than 2 usecs as well - all of these operations are done via a
> single system-call and a single context switch.

That's outstanding...

> also consider the fact that the true cost of M:N threading does not show
> up with just one or two threads running. The true cost comes when
> thousands of threads are running, each of them doing nontrivial work that
> matters, ie. IO. The true cost of M:N shows up when threading is actually
> used for what it's intended to be used :-) And basically nothing offloads
> work to threads for them to just do userspace synchronization - real,
> useful work always involves some sort of IO and kernel calls. At which
> point M:N loses out badly.

It can. Certainly, if IO upcall overhead is greater than just running the
thread that's blocked inside the kernel, then yes. Not sure how this is all
going to play out...
 
> M:N's big mistake is that it concentrates on what matters the least:  
> user<->user context switches. Nothing really wants to do that. And if it
> does, it's contended on some userspace locking object, at which point it
> doesnt really matter whether the cost of switching is 1 usec or 0.5 usecs,
> the main application cost is the lost paralellism and increased cache
> trashing due to the serialization - independently of what kind of
> threading abstraction is used.

Yeah, that's not a new argument and is a solid criticism...

Hmmm, random thoughts... This is probably outside the scope of lkml,
but...

I'm trying to think up a possible problem with how the JVM does threading that
might be able to exploit this kind of situation...Hmm, there's locks on
the method dictionary, but that's not something that's generally changing a
lot of the time... I'll give it some thought.

The JVM needs a couple of pretty critical things that are a bit off from
the normal Posix threading standard. One of them is very fast thread
suspension for both individual threads and the all threads accept the
currently running one...

In the Solaris threads implementation of JVM/HotSpot it has two methods of
getting a ucontext for doing GC and wierd exception/signal handling via
safepoints (a JIT compiler goody) and it would be nice to have...

1) Slow Version. Throw a SIGUSR1 at a thread and read/write the ucontext on
	the signal frame itself.

2) Fast Version. The thread state and ucontext is examined directly to determine
	the validity of the stored thread context, whether it's blocked on
	a syscall (ignore it) or was doing a CPU intensive operation (use it).  

That ucontext is used for various things:

a) Proper GC so that registers that might contain valid references are
	taken into account properly to maintain the correctness of the
	mark/sweep algorithms.
 
b) The thread's program counter value is altered to deal with safepoints.

(2) above being the most desireable since it's a kind of fast path for
	(a) and (b).

So userspace exposure to the thread's ucontext would be a good thing.
I'm not sure how this is dealt within the current implementation of
what you folks are doing at this moment.

> primitives (including internal glibc locks), all uncontended
> synchronization is done purely in user-space. [and for the contended case
> we *want* to switch into the kernel.]

If there's any thing on this planet that's going to stress a threading
system, it's going to be the JVM. I'll give what you've said a some
thought. My bias has been to FreeBSD's KSE project for the most part
over this last threading/development run.

/me thinks...

bill

