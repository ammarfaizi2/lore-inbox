Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136452AbREDQqs>; Fri, 4 May 2001 12:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136454AbREDQqj>; Fri, 4 May 2001 12:46:39 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:3332 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S136452AbREDQqd>; Fri, 4 May 2001 12:46:33 -0400
Date: Fri, 4 May 2001 20:46:16 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.4 alpha semaphores optimization
Message-ID: <20010504204616.A579@jurassic.park.msu.ru>
In-Reply-To: <20010503194747.A552@jurassic.park.msu.ru> <14842.988968173@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14842.988968173@warthog.cambridge.redhat.com>; from dhowells@redhat.com on Fri, May 04, 2001 at 10:22:53AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 04, 2001 at 10:22:53AM +0100, David Howells wrote:
> I don't know whether it will (a) compile, or (b) work... I don't have an alpha
> to play with.

Neither (a) nor (b) ;-)  Corrected asm-alpha/rwsem.h attached.
Also small fix for lib/rwsem.c -- RWSEM_WAITING_BIAS-RWSEM_ACTIVE_BIAS
won't fit in the __s32 if counters are 64-bit.

--- linux/lib/rwsem.c.orig	Sat Apr 28 00:58:28 2001
+++ linux/lib/rwsem.c	Fri May  4 17:38:06 2001
@@ -112,7 +112,7 @@ static inline struct rw_semaphore *__rws
  */
 static inline struct rw_semaphore *rwsem_down_failed_common(struct rw_semaphore *sem,
 								 struct rwsem_waiter *waiter,
-								 __s32 adjustment)
+								 signed long adjustment)
 {
 	struct task_struct *tsk = current;
 	signed long count;

Ivan.


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Description: rwsem.h
Content-Disposition: attachment; filename="rwsem64.h"

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
	long		count;
#define RWSEM_UNLOCKED_VALUE		0x0000000000000000L
#define RWSEM_ACTIVE_BIAS		0x0000000000000001L
#define RWSEM_ACTIVE_MASK		0x00000000ffffffffL
#define RWSEM_WAITING_BIAS		(-0x0000000100000000L)
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
	{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
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
	long oldcount, temp;
	__asm__ __volatile__(
	"1:	ldq_l	%0,%1\n"
	"	addq	%0,%3,%2\n"
	"	stq_c	%2,%1\n"
	"	beq	%2,2f\n"
#ifdef CONFIG_SMP
	"	mb\n"
#endif
	".subsection 2\n"
	"2:	br	1b\n"
	".previous"
	:"=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
	:"Ir" (RWSEM_ACTIVE_READ_BIAS), "m" (sem->count) : "memory");

	if (oldcount < 0)
		rwsem_down_read_failed(sem);
}

static inline void __down_write(struct rw_semaphore *sem)
{
	long granted, temp;
	__asm__ __volatile__(
	"1:	ldq_l	%0,%1\n"
	"	addq	%0,%3,%2\n"
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
	:"Ir" (RWSEM_ACTIVE_WRITE_BIAS), "m" (sem->count) : "memory");

	if (!granted)
		rwsem_down_write_failed(sem);
}

static inline void __up_read(struct rw_semaphore *sem)
{
	long oldcount, temp;
	__asm__ __volatile__(
#ifdef CONFIG_SMP
	"	mb\n"
#endif
	"1:	ldq_l	%0,%1\n"
	"	subq	%0,%3,%2\n"
	"	stq_c	%2,%1\n"
	"	beq	%2,2f\n"
	".subsection 2\n"
	"2:	br	1b\n"
	".previous"
	:"=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
	:"Ir" (RWSEM_ACTIVE_READ_BIAS), "m" (sem->count) : "memory");

	if (oldcount < 0)
		if ((oldcount & RWSEM_ACTIVE_MASK) == 0)
			rwsem_wake(sem);
}

static inline void __up_write(struct rw_semaphore *sem)
{
	long count, cmp;
	__asm__ __volatile__(
#ifdef CONFIG_SMP
	"	mb\n"
#endif
	"1:	ldq_l	%0,%1\n"
	"	subq	%0,%3,%2\n"
	"	stq_c	%2,%1\n"
	"	beq	%2,2f\n"
	"	cmpeq	%0,%3,%2\n"
	".subsection 2\n"
	"2:	br	1b\n"
	".previous"
	:"=&r" (count), "=m" (sem->count), "=&r" (cmp)
	:"Ir" (RWSEM_ACTIVE_WRITE_BIAS), "m" (sem->count) : "memory");

	if (!cmp)
		if ((int)count - RWSEM_ACTIVE_BIAS == 0)
			rwsem_wake(sem);
}

static inline void rwsem_atomic_add(long val, struct rw_semaphore *sem)
{
	long temp;
	__asm__ __volatile__(
	"1:	ldq_l	%0,%1\n"
	"	addq	%0,%2,%0\n"
	"	stq_c	%0,%1\n"
	"	beq	%0,2f\n"
	".subsection 2\n"
	"2:	br	1b\n"
	".previous"
	:"=&r" (temp), "=m" (sem->count)
	:"Ir" (val), "m" (sem->count));
}

static inline long rwsem_atomic_update(long val, struct rw_semaphore *sem)
{
	long temp, ret;
	__asm__ __volatile__(
	"1:	ldq_l	%0,%1\n"
	"	addq 	%0,%3,%2\n"
	"	addq	%0,%3,%0\n"
	"	stq_c	%2,%1\n"
	"	beq	%2,2f\n"
	".subsection 2\n"
	"2:	br	1b\n"
	".previous"
	:"=&r" (ret), "=m" (sem->count), "=&r" (temp)
	:"Ir" (val), "m" (sem->count));

	return ret;
}

#endif /* __KERNEL__ */
#endif /* _ALPHA_RWSEM_H */

--DocE+STaALJfprDB--
