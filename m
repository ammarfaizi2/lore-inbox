Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135987AbREDJX3>; Fri, 4 May 2001 05:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136045AbREDJXK>; Fri, 4 May 2001 05:23:10 -0400
Received: from t2.redhat.com ([199.183.24.243]:11006 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S135987AbREDJXC>; Fri, 4 May 2001 05:23:02 -0400
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.4 alpha semaphores optimization 
In-Reply-To: Your message of "Thu, 03 May 2001 19:47:47 +0400."
             <20010503194747.A552@jurassic.park.msu.ru> 
Date: Fri, 04 May 2001 10:22:53 +0100
Message-ID: <14842.988968173@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ivan,

One reason I picked "signed long" as the count type in the lib/rwsem.c is that
this would be 64 bits on a 64-bit arch such as the alpha.

So I've taken your idea for include/asm-alpha/rwsem.h and modified it a
little. You'll find it attached at the bottom.

I don't know whether it will (a) compile, or (b) work... I don't have an alpha
to play with.

I also don't know the alpha function calling convention, so I can't put direct
calls to the fallback routines in lib/rwsem.c from the ".subsection 2"
bits. Can you do that, or can you tell me how the calling convention works?

Cheers,
David

===============================================================================
#ifndef _ALPHA_RWSEM_H
#define _ALPHA_RWSEM_H

/*
 * Written by Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 2001.
 * Based on asm-alpha/semaphore.h and asm-i386/rwsem.h
 */

#ifndef _LINUX_RWSEM_H
#error please dont include asm/rwsem.h directly, use linux/rwsem.h instead
#endif

#ifdef __KERNEL__

#include <linux/list.h>
#include <linux/spinlock.h>

struct rwsem_waiter;

extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem);
extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem);
extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *);

/*
 * the semaphore definition
 */
struct rw_semaphore {
	signed long		count;
#define RWSEM_UNLOCKED_VALUE		0x0000000000000000
#define RWSEM_ACTIVE_BIAS		0x0000000000000001
#define RWSEM_ACTIVE_MASK		0x00000000ffffffff
#define RWSEM_WAITING_BIAS		(-0x0000000100000000)
#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
	spinlock_t		wait_lock;
	struct list_head	wait_list;
#if RWSEM_DEBUG
	int			debug;
#endif
};

#if RWSEM_DEBUG
#define __RWSEM_DEBUG_INIT      , 0
#else
#define __RWSEM_DEBUG_INIT	/* */
#endif

#define __RWSEM_INITIALIZER(name) \
	{ ATOMIC_INIT(RWSEM_UNLOCKED_VALUE), SPIN_LOCK_UNLOCKED, \
	LIST_HEAD_INIT((name).wait_list) __RWSEM_DEBUG_INIT }

#define DECLARE_RWSEM(name) \
	struct rw_semaphore name = __RWSEM_INITIALIZER(name)

static inline void init_rwsem(struct rw_semaphore *sem)
{
	sem->count = RWSEM_UNLOCKED_VALUE;
	spin_lock_init(&sem->wait_lock);
	INIT_LIST_HEAD(&sem->wait_list);
#if RWSEM_DEBUG
	sem->debug = 0;
#endif
}

static inline void __down_read(struct rw_semaphore *sem)
{
	signed long oldcount, temp;
	__asm__ __volatile__(
	"1:	ldq_l %0,%1\n"
	"	addq %0,%3,%2\n"
	"	stq_c %2,%1\n"
	"	beq %2,2f\n"
#ifdef CONFIG_SMP
	"	mb\n"
#endif
	".subsection 2\n"
	"2:	br 1b\n"
	".previous"
	:"=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
	:"Ir" (RWSEM_ACTIVE_READ_BIAS), "m" (sem->count) : "memory");

	if (oldcount < 0)
		rwsem_down_read_failed(sem);
}

static inline void __down_write(struct rw_semaphore *sem)
{
	signed long granted, temp;
	__asm__ __volatile__(
	"1:	ldq_l %0,%1\n"
	"	addq %0,%3,%2\n"
	"	stq_c %2,%1\n"
	"	beq %2,2f\n"
#ifdef CONFIG_SMP
	"	mb\n"
	"	cmpeq %0,0,%0\n"
#endif
	".subsection 2\n"
	"2:	br 1b\n"
	".previous"
	:"=&r" (granted), "=m" (sem->count), "=&r" (temp)
	:"Ir" (RWSEM_ACTIVE_WRITE_BIAS), "m" (sem->count) : "memory");

	if (!granted)
		rwsem_down_write_failed(sem);
}

static inline void __up_read(struct rw_semaphore *sem)
{
	signed long oldcount, temp;
	__asm__ __volatile__(
	"1:	ldq_l %0,%1\n"
	"	subq %0,%3,%2\n"
	"	stq_c %2,%1\n"
	"	beq %2,2f\n"
#ifdef CONFIG_SMP
	"	mb\n"
#endif
	".subsection 2\n"
	"2:	br 1b\n"
	".previous"
	:"=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
	:"Ir" (RWSEM_ACTIVE_READ_BIAS), "m" (sem->count) : "memory");

	if (oldcount < 0)
		if ((count & RWSEM_ACTIVE_MASK) == 0)
			rwsem_wake(sem);
}

static inline void __up_write(struct rw_semaphore *sem)
{
	signed long count, cmp;
	__asm__ __volatile__(
	"1:	ldq_l %0,%1\n"
	"	subq %0,%3,%2\n"
	"	stq_c %2,%1\n"
	"	beq %2,2f\n"
#ifdef CONFIG_SMP
	"	mb\n"
	"	cmpeq %0,%3,%2\n"
	"	subq %0,%3,%0\n"
#endif
	".subsection 2\n"
	"2:	br 1b\n"
	".previous"
	:"=&r" (count), "=m" (sem->count), "=&r" (cmp)
	:"Ir" (RWSEM_ACTIVE_WRITE_BIAS), "m" (sem->count) : "memory");

	if (!cmp)
		if ((count & RWSEM_ACTIVE_MASK) == 0)
			rwsem_wake(sem);
}

#define rwsem_atomic_add(val, sem)	atomic_add(val, &(sem)->count)
#define rwsem_atomic_update(val, sem)	atomic_add_return(val, &(sem)->count)

#endif /* __KERNEL__ */
#endif /* _ALPHA_RWSEM_H */
