Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318348AbSHPNNu>; Fri, 16 Aug 2002 09:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318349AbSHPNNu>; Fri, 16 Aug 2002 09:13:50 -0400
Received: from mx1.elte.hu ([157.181.1.137]:47321 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318348AbSHPNNs>;
	Fri, 16 Aug 2002 09:13:48 -0400
Date: Fri, 16 Aug 2002 15:18:23 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
In-Reply-To: <20020816133456.A342@kushida.apsleyroad.org>
Message-ID: <Pine.LNX.4.44.0208161448190.16655-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Aug 2002, Jamie Lokier wrote:

> Sorry if I was unclear.  I'm specifically talking about non-POSIX
> threading methods (normal C code though, not complicated JVMs).

if you define your own threading method then it's your responsibility to
make it work wrt. the exit() method for example. Just one example:
application code can technically call sys_exit() in a 'raw' form anytime:

	asm volatile ("movl $1, %eax; int $0x80;")

and if it's a clone()ed thread then all thread-local resources are
lost/leaked. malloc() space, private file descriptors, held futexes.

there's nothing about CLONE_DETACHED or libpthreads that changes this
fundamental situation.

the only guarantee the kernel can make is to clean up nicely when a
resource-group is released. You can use CLONE_VM but not CLONE_FILES, and
then the kernel will clean up per-thread file descriptors on exit. It's an
expensive but nice property for certain uses. Furthermore it can help a
bit to give a signal towards user-space that a thread has 'unused' a given
TID. But it *cannot* possibly clean up after shared resources completely -
that's the point in sharing resources between threads - the kernel cannot
know which ones are private and which not. Eg. if you use CLONE_VM then
your threads can leak memory upon sys_exit(). If you use CLONE_FILES only
then you can leak file descriptors upon sys_exit().

> Most uses of clone() that I've seen are not using any threading library
> at all: [...]

this is still possible, of course.

> It's conceptually fine that individual threads can die.  
> _Conceptually_, clone-by-hand threads are very similar to processes, and
> I have seen this used in practice a few times.
> 
> And it all works fine: just use SIGCHLD and waitpid().

huh? Nothing cleans up leaked memory if a CLONE_VM thread sys_exits, or
leaked file descriptors if a CLONE_FILES thread exits.

only a tiny segment of resource cleanup can be 'solved' by SIGCHLD. How do
you clean up a held futex via SIGCHLD notification? How do you clean up a
malloc() via SIGCHLD, if sys_exit() is called by application code
directly?

'polite exit' when threads hold shared resources simply *does not exist*.

the truth is that this is not possible and not desirable either - in
threaded C code there must be some harmony between application code and
exit methods, and applications still have the 'cooperative' responsibility
to not leak resources.

> Now you have written this wonderful resource optimisation, which removes
> zombies: CLONE_DETACHED.  Unfortunately, catching invidual thread death
> relies on the thread "exiting politely", as they say. [...]

again, calling sys_exit directly is not 'polite' in any way - you can lose
malloc() and futex (and other) state, you can leak basically any resource
that can be used by a thread, and you can corrupt the threading library's
internal variables as well (except the really simple uses which do no
resource allocation at all). So a thread has to be careful how to exit no
matter what - CLONE_DETACHED does not change this in any way.

but if you dont like CLONE_DETACHED and want to use SIGCHLD notification
then you can do it. Lots of POSIX-conform code relies on SIGCHLD
notification so it's not like we want to remove it anytime soon.

> [...] So I still have to use SIGCHLD and waitpid(), or a pipe(), for
> non-POSIX-model threads that want to robustly detect "impolite" thread
> death.

well, i think this is ineffecitve and doesnt buy you anything - but it's
clearly up to you.

> I think that's an unfair penalty on non-POSIX-model threads.

there's nothing, i repeat, *NOTHING* POSIX about CLONE_DETACHED. POSIX
threading has cleanup needs as well, which are handled by intercepting all
exit() activity and doing the cleanups and notifications that are
necessery. The only difference here is that notification is not done via a
signal, but via faster futexes.

Why is CLONE_DETACHED such a big problem for you, why do you want to force
a more expensive notification method? If you want to spin your own
threading library which has a completely new API (good luck at that) then
dont use pthread_create() but raw clone() and you wont get any detached
threads - end of story. You have complete control over what kind of
notification method you use.

	Ingo

