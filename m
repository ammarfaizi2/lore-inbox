Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318275AbSHPJ53>; Fri, 16 Aug 2002 05:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318281AbSHPJ53>; Fri, 16 Aug 2002 05:57:29 -0400
Received: from mx2.elte.hu ([157.181.151.9]:16610 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318275AbSHPJ52>;
	Fri, 16 Aug 2002 05:57:28 -0400
Date: Fri, 16 Aug 2002 12:02:00 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
In-Reply-To: <20020816040902.A31570@kushida.apsleyroad.org>
Message-ID: <Pine.LNX.4.44.0208161153060.3509-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Aug 2002, Jamie Lokier wrote:

> > like i said in the original email, the point of CLONE_DETACHED is to avoid
> > the waitpid() overhead. I also said that exit notification is done via
> > mutexes (futexes).
> 
> How?  Scenario:
> 
>    1. a thread calls a 3rd party library which was _not_ compiled with
>       threading in mind.  (It shouldn't have to be).
>
>    2. 3rd party library sends itself a SIGABRT; perhaps an assertion
>       failed.  (Variants: SIGFPE, library does execve(), etc.)
> 
>    3. thread exits....   but the mutex was _not_ released

this is a simple and well-defined thing: if the thread exits by calling
the exit() function then libc calls the exit_thread_group() syscall [part
of my POSIX signals patch] and zaps all threads. This is a very clearly
defined thing in POSIX.

SIGABRT/SIGFPE if uncaught cause a segmentation fault that zaps all
threads (the kernel does this zapping). [note that for this you'll have to
use the POSIX signals patch i mentioned earlier.]

>    4. I _want_ to report the death to other thread, without having
>       to poll all my children in my main event loop.

POSIX says that in this case (when eg. non-threaded POSIX code calls
exit()) all threads must exit and a status code is sent to the parent of
the threaded application. And this is precisely how it works.

> This is a very legitimate and useful kind of thread death, and it's
> perfectly safe too.  (Not pthreads-conformant, but clone() is useful for
> more than just pthreads).

as long as you are using libc there are certain POSIX rules that must be
followed. NGPT has to do the same.

non-POSIX programming methods like JVMs can still implement *any*
semantics - but your whole example is based on POSIX issues like exit() or
default signal handlers, not Java.

	Ingo

