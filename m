Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136458AbREDRDT>; Fri, 4 May 2001 13:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136459AbREDRDF>; Fri, 4 May 2001 13:03:05 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:7940 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S136458AbREDRCv>; Fri, 4 May 2001 13:02:51 -0400
Date: Fri, 4 May 2001 21:02:33 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.4 alpha semaphores optimization
Message-ID: <20010504210233.A653@jurassic.park.msu.ru>
In-Reply-To: <20010503194747.A552@jurassic.park.msu.ru> <20010503192848.V1162@athlon.random> <20010504131528.A2228@jurassic.park.msu.ru> <20010504163359.F3762@athlon.random>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010504163359.F3762@athlon.random>; from andrea@suse.de on Fri, May 04, 2001 at 04:33:59PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 04, 2001 at 04:33:59PM +0200, Andrea Arcangeli wrote:
> the 2^16 limit is not a per-user limit it is a global one so the max
> user process ulimit is irrelevant.
> 
> Only the number of pid and the max number of tasks supported by the
> architecture is a relevant limit for this.

Thanks for the correction. I thought about a case where one user could
exhaust 2^16 limit.

> > b. "long" count would cost extra 8 bytes in the struct rw_semaphore;
> 
> correct but that's the "feature" to be able to support 2^32 concurrent
> sleepers at not relevant runtime cost 8).

But I can't imagine how this "feature" could be useful in a real life :-)

> > c. I can use existing atomic routines which deal with ints.
> 
> I was thinking at a dedicated routine that implements the slow path by
> hand as well like x86 just do. Then using ldq instead of ldl isn't
> really a big deal programmer wise.

You meant "the fast path", I guess? Then it's true. However with those
atomic functions code is much more readable.

Anyway, I've attached asm-alpha/rwsem_xchgadd.h for your implementation.
However I got processes in D state early on boot with it -- maybe
I've made a typo somewhere...

Ivan.


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Description: rwsem_xchgadd.h
Content-Disposition: attachment; filename="rwsem_xchgadd.h"

#ifndef _ALPHA_RWSEM_XCHGADD_H
#define _ALPHA_RWSEM_XCHGADD_H

#include <asm/types.h>	/* BITS_PER_LONG */

static inline void __down_read(struct rw_semaphore *sem)
{
	long count, temp;
	__asm__ __volatile__(
	"1:	ldq_l	%0,%1\n"
	"	addq	%0,1,%2\n"
	"	stq_c	%2,%1\n"
	"	beq	%2,2f\n"
#ifdef CONFIG_SMP
	"	mb\n"
#endif
	".subsection 2\n"
	"2:	br	1b\n"
	".previous"
	:"=&r" (count), "=m" (sem->count), "=&r" (temp)
	:"m" (sem->count) : "memory");

	if (count < 0)
		rwsem_down_failed(sem, RWSEM_READ_BLOCKING_BIAS);
}

static inline void __down_write(struct rw_semaphore *sem)
{
	long granted, temp = RWSEM_WRITE_BIAS + RWSEM_READ_BIAS;
	__asm__ __volatile__(
	"1:	ldq_l	%0,%1\n"
	"	addq	%0,%2,%2\n"
	"	stq_c	%2,%1\n"
	"	beq	%2,2f\n"
#ifdef CONFIG_SMP
	"	mb\n"
#endif
	"	cmpeq	%0,0,%0\n"
	".subsection 2\n"
	"2:	br	1b\n"
	".previous"
	:"=&r" (granted), "=m" (sem->count), "=&r" (temp)
	:"2" (temp),"m" (sem->count) : "memory");

	if (!granted)
		rwsem_down_failed(sem, RWSEM_WRITE_BLOCKING_BIAS);
}


static inline void __up_read(struct rw_semaphore *sem)
{
	long oldcount, temp;
	__asm__ __volatile__(
#ifdef CONFIG_SMP
	"	mb\n"
#endif
	"1:	ldq_l	%0,%1\n"
	"	subq	%0,1,%2\n"
	"	stq_c	%2,%1\n"
	"	beq	%2,2f\n"
	"	subl	%0,1,%2\n"
	".subsection 2\n"
	"2:	br	1b\n"
	".previous"
	:"=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
	:"m" (sem->count) : "memory");

	if (oldcount < 0 && temp == 0)
			rwsem_wake(sem);
}

static inline void __up_write(struct rw_semaphore *sem)
{
	long count, temp = RWSEM_READ_BIAS + RWSEM_WRITE_BIAS;
	__asm__ __volatile__(
#ifdef CONFIG_SMP
	"	mb\n"
#endif
	"1:	ldq_l	%0,%1\n"
	"	subq	%0,%2,%2\n"
	"	mov	%2,%0\n"
	"	stq_c	%2,%1\n"
	"	beq	%2,2f\n"
	".subsection 2\n"
	"2:	br	1b\n"
	".previous"
	:"=&r" (count), "=m" (sem->count), "=&r" (temp)
	:"2" (temp), "m" (sem->count) : "memory");

	if (count < 0)
		rwsem_wake(sem);
}

static inline long rwsem_xchgadd(long value, long * count)
{
	long ret, temp;
	__asm__ __volatile__(
	"1:	ldq_l	%0,%1\n"
	"	addq	%0,%3,%2\n"
	"	stq_c	%2,%1\n"
	"	beq	%2,2f\n"
	".subsection 2\n"
	"2:	br	1b\n"
	".previous"
	:"=&r" (ret), "=m" (count), "=&r" (temp)
	:"Ir" (value), "m" (count) : "memory");

	return ret;
}

#endif

--opJtzjQTFsWo+cga--
