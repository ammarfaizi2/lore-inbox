Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132786AbRDQRk1>; Tue, 17 Apr 2001 13:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132785AbRDQRkS>; Tue, 17 Apr 2001 13:40:18 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:12348 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132784AbRDQRkN>; Tue, 17 Apr 2001 13:40:13 -0400
Date: Tue, 17 Apr 2001 19:55:05 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: David Howells <dhowells@cambridge.redhat.com>
Cc: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>,
        linux-kernel@vger.kernel.org, Peter Rival <frival@zk3.dec.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: generic rwsem [Re: Alpha "process table hang"]
Message-ID: <20010417195505.B31982@athlon.random>
In-Reply-To: <20010417170717.H2696@athlon.random> <10115.987526753@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10115.987526753@warthog.cambridge.redhat.com>; from dhowells@cambridge.redhat.com on Tue, Apr 17, 2001 at 05:59:13PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2001 at 05:59:13PM +0100, David Howells wrote:
> Andrea,
> 
> How did you generate the 00_rwsem-generic-1 patch? Against what did you diff?

2.4.4pre3 from kernel.org.

> You seem to have removed all the optimised i386 rwsem stuff... Did it not work
> for you?

As said the design of the framework to plugin per-arch rwsem implementation
isn't flexible enough and the generic spinlocks are as well broken, try to use
them if you can (yes I tried that for the alpha, it was just a mess and it was
more productive to rewrite than to fix).

> > (the generic rwsemaphores in those kernels is broken, try to use them in
> > other archs or x86 and you will notice) and I cannot reproduce the hang any
> > longer.
> 
> Can you supply a test case that demonstrates it not working?

#define __RWSEM_INITIALIZER(name,count) \
				 ^^^^^
{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
  ^^^^^^^^^^^^^^^^^^^^
	__WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
	__RWSEM_DEBUG_INIT __RWSEM_DEBUG_MINIT(name) }

#define __DECLARE_RWSEM_GENERIC(name,count) \
	struct rw_semaphore name = __RWSEM_INITIALIZER(name,count)
							    ^^^^^

#define DECLARE_RWSEM(name) __DECLARE_RWSEM_GENERIC(name,RW_LOCK_BIAS)
							 ^^^^^^^^^^^^
#define DECLARE_RWSEM_READ_LOCKED(name) __DECLARE_RWSEM_GENERIC(name,RW_LOCK_BIAS-1)
								     ^^^^^^^^^^^^^^
#define DECLARE_RWSEM_WRITE_LOCKED(name) __DECLARE_RWSEM_GENERIC(name,0)

> > My generic rwsem should be also cleaner and faster than the generic ones in
> > 2.4.4pre3 and they can be turned off completly so an architecture can really
> > takeover with its own asm implementation.
> 
> I quick look says it shouldn't be faster (inline functions and all that).

The spinlock based generic semaphores are quite large, so I don't want to waste
icache because of that, a call asm instruction isn't that costly (it's
obviously _very_ costly for a spinlock because a spinlock is 1 asm instruction
in the fast path, but not for a C based rwsem). But the real point is the
locking and the waitqueue mechanism that is superior in my implementation (not
the non inlining part).

And it's also more readable and it's not bloated code, 65+110 lines compared to
156+148+174 lines.

andrea@athlon:~/devel/kernel > wc -l 2.4.4pre3aa/include/linux/rwsem.h 
     65 2.4.4pre3aa/include/linux/rwsem.h
andrea@athlon:~/devel/kernel > wc -l 2.4.4pre3aa/lib/rwsem.c           
    110 2.4.4pre3aa/lib/rwsem.c
andrea@athlon:~/devel/kernel > wc -l 2.4.4pre3/lib/rwsem.c   
    156 2.4.4pre3/lib/rwsem.c
andrea@athlon:~/devel/kernel > wc -l 2.4.4pre3/include/linux/rwsem.h 
    148 2.4.4pre3/include/linux/rwsem.h
andrea@athlon:~/devel/kernel > wc -l 2.4.4pre3/include/linux/rwsem-spinlock.h 
    174 2.4.4pre3/include/linux/rwsem-spinlock.h
andrea@athlon:~/devel/kernel > 

I suggest you to apply my patch, read my implementation, tell me if you think
it's not more efficient and more readable, and then to set CONFIG_RWSEM_GENERIC
to n in arch/i386/config.in and to plugin your asm code taken from vanilla
2.4.4pre3 into include/asm-i386/rwsem.h and arch/i386/kernel/rwsem.c then we're
done, and if someone has problems with the asm code with a one liner he can
fallback in a obviously right and quite efficient implementation [even if the
fastpath is not 1 inlined asm instruction] (all archs will be allowed to do
that transparently to the arch dependent code). Same can be done on alpha and
other archs, resurrecting the inlined fast paths based on the atomic_add_return
APIs is easy too. Infact I'd _recommend_ for archs that can implement the
atomic_add_return and friends (included ia32 with xadd on >=586) to
implement the "fast path" version of the rwsem it in C too in the common code
selectable with a CONFIG_RWSEM_ATOMIC_RETURN (plus we add
linux/include/linux/compiler.h with the builtin_expect macro to be able to
define the fast path in C too). Most archs have the atomic_*_return and friends
and they will be able share completly the common code and have rwsem fast paths
as fast as ia32 without risk to introduce bugs in the port. The more we share
the less risk there is. After CONFIG_RWSEM_ATOMIC_RETURN is implemented we can
probably drop the file asm-i386/rwsem-xadd.h.

Andrea
