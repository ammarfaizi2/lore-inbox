Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262137AbSITKeq>; Fri, 20 Sep 2002 06:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262173AbSITKeq>; Fri, 20 Sep 2002 06:34:46 -0400
Received: from mx1.elte.hu ([157.181.1.137]:43694 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262137AbSITKep>;
	Fri, 20 Sep 2002 06:34:45 -0400
Date: Fri, 20 Sep 2002 12:47:12 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: <20020920102031.GA4744@gnuppy.monkey.org>
Message-ID: <Pine.LNX.4.44.0209201231430.2954-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Sep 2002, Bill Huey wrote:

> You might like to try a context switching/thread wakeup performance
> measurement against FreeBSD's libc_r. I'd imagine that it's difficult to
> beat a system like that since they keep all of that stuff in userspace
> since it's just 2 context switches and a call to their thread-kernel.

our kernel thread context switch latency is below 1 usec on a typical P4
box, so our NPT library should compare pretty favorably even in such
benchmarks. We get from the pthread_create() call to the first user
instruction of the specified thread-function code in less than 2 usecs,
and we get from pthread_exit() to the thread that does the pthread_join()
in less than 2 usecs as well - all of these operations are done via a
single system-call and a single context switch.

also consider the fact that the true cost of M:N threading does not show
up with just one or two threads running. The true cost comes when
thousands of threads are running, each of them doing nontrivial work that
matters, ie. IO. The true cost of M:N shows up when threading is actually
used for what it's intended to be used :-) And basically nothing offloads
work to threads for them to just do userspace synchronization - real,
useful work always involves some sort of IO and kernel calls. At which
point M:N loses out badly.

M:N's big mistake is that it concentrates on what matters the least:  
user<->user context switches. Nothing really wants to do that. And if it
does, it's contended on some userspace locking object, at which point it
doesnt really matter whether the cost of switching is 1 usec or 0.5 usecs,
the main application cost is the lost paralellism and increased cache
trashing due to the serialization - independently of what kind of
threading abstraction is used.

and since our NPT library uses futexes for *all* userspace synchronization
primitives (including internal glibc locks), all uncontended
synchronization is done purely in user-space. [and for the contended case
we *want* to switch into the kernel.]

	Ingo

