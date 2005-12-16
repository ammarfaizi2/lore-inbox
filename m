Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbVLPLDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbVLPLDE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 06:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbVLPLDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 06:03:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33986 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750875AbVLPLDC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 06:03:02 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <43A21E55.3060907@yahoo.com.au> 
References: <43A21E55.3060907@yahoo.com.au>  <1134560671.2894.30.camel@laptopd505.fenrus.org> <439EDC3D.5040808@nortel.com> <1134479118.11732.14.camel@localhost.localdomain> <dhowells1134431145@warthog.cambridge.redhat.com> <3874.1134480759@warthog.cambridge.redhat.com> <15167.1134488373@warthog.cambridge.redhat.com> <1134490205.11732.97.camel@localhost.localdomain> <1134556187.2894.7.camel@laptopd505.fenrus.org> <1134558188.25663.5.camel@localhost.localdomain> <1134558507.2894.22.camel@laptopd505.fenrus.org> <1134559470.25663.22.camel@localhost.localdomain> <20051214033536.05183668.akpm@osdl.org> <15412.1134561432@warthog.cambridge.redhat.com> 
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: David Howells <dhowells@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, cfriesen@nortel.com,
       torvalds@osdl.org, hch@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Fri, 16 Dec 2005 11:02:22 +0000
Message-ID: <11202.1134730942@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> >  (2) Those that have CMPXCHG or equivalent: 68020, i486+, x86_64, ia64,
> > sparc.
> >  (3) Those that have LL/SC or equivalent: mips (some), alpha, powerpc, arm6.
> > 
> 
> cmpxchg is basically exactly equivalent to a store-conditional, so 2 and 3
> are the same level.

No, they're not. LL/SC is more flexible than CMPXCHG because under some
circumstances, you can get away without doing the SC, and because sometimes
you can do one LL/SC in lieu of two CMPXCHG's because LL/SC allows you to
retrieve the value, consider it and then modify it if you want to. With
CMPXCHG you have to anticipate, and so you're more likely to get it wrong.

> I don't know why you don't implement a "good" default implementation with
> atomic_cmpxchg.

Because it wouldn't be a good default. I'm thinking the best default is simply
to wrap a counting semaphore. Where overriding this really matters is class 1
CPUs that don't have CMPXCHG, LL/SC, or in the x86 case, LOCK INC/DEC.

I've had a play with x86, and on there CMPXCHG, XCHG and XADD give worse
performance than INC/DEC for some reason. I assume this is something to do
with how the PPro CPU optimises itself. On PPro CPUs at least, counting
semaphores really are the most efficient way. CMPXCHG, whilst it ought to be
better, really isn't.

One thing I have noticed, though, is that the counting semaphore tends to be
quite uneven in its distribution across threads in a situation where a lot of
threads are all trying to thrash the semaphore at the same time:

	insmod /tmp/synchro-test.ko v=1 do_sched=1 sm=20 ism=1

gives:

	SEM: 2% 1% 2% 5% 4% 4% 3% 11% 2% 33% 1% 1% 5% 2% 2% 1% 2% 3% 3% 4%

on a dual 200MHz PPro.

Whereas my mutexes are much more even:

	MTX: 5% 5% 4% 4% 4% 5% 5% 5% 5% 4% 4% 4% 4% 4% 6% 5% 4% 4% 4% 6%

(See attached module).

Now, I don't think that this situation is very likely to crop up in ordinary
use, but it seems odd.

David

/* synchro-test.c: run some threads to test the synchronisation primitives
 *
 * Copyright (C) 2005 Red Hat, Inc. All Rights Reserved.
 * Written by David Howells (dhowells@redhat.com)
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version
 * 2 of the License, or (at your option) any later version.
 *
 * run as something like:
 *
 *	insmod synchro-test.ko rd=2 wr=2
 *	insmod synchro-test.ko mx=1
 *	insmod synchro-test.ko sm=2 ism=1
 *	insmod synchro-test.ko sm=2 ism=2
 */

#include <linux/config.h>
#include <linux/module.h>
#include <linux/poll.h>
#include <linux/moduleparam.h>
#include <linux/stat.h>
#include <linux/init.h>
#include <asm/atomic.h>
#include <linux/personality.h>
#include <linux/smp_lock.h>
#include <linux/delay.h>
#include <linux/timer.h>
#include <linux/completion.h>
#include <linux/mutex.h>

#define VALIDATE_OPERATORS 0

static int nummx = 0;
static int numsm = 0, seminit = 4;
static int numrd = 0, numwr = 0, numdg = 0;
static int elapse = 5, load = 0, do_sched = 0;
static int verbose = 0;

MODULE_AUTHOR("David Howells");
MODULE_DESCRIPTION("Synchronisation primitive test demo");
MODULE_LICENSE("GPL");

module_param_named(v, verbose, int, 0);
MODULE_PARM_DESC(verbose, "Verbosity");

module_param_named(mx, nummx, int, 0);
MODULE_PARM_DESC(nummx, "Number of mutex threads");

module_param_named(sm, numsm, int, 0);
MODULE_PARM_DESC(numsm, "Number of semaphore threads");

module_param_named(ism, seminit, int, 0);
MODULE_PARM_DESC(seminit, "Initial semaphore value");

module_param_named(rd, numrd, int, 0);
MODULE_PARM_DESC(numrd, "Number of reader threads");

module_param_named(wr, numwr, int, 0);
MODULE_PARM_DESC(numwr, "Number of writer threads");

module_param_named(dg, numdg, int, 0);
MODULE_PARM_DESC(numdg, "Number of downgrader threads");

module_param(elapse, int, 0);
MODULE_PARM_DESC(elapse, "Number of seconds to run for");

module_param(load, int, 0);
MODULE_PARM_DESC(load, "Length of load in uS");

module_param(do_sched, int, 0);
MODULE_PARM_DESC(do_sched, "True if each thread should schedule regularly");

/* the semaphores under test */
static struct mutex ____cacheline_aligned mutex;
static struct semaphore ____cacheline_aligned sem;
static struct rw_semaphore ____cacheline_aligned rwsem;

static atomic_t ____cacheline_aligned do_stuff		= ATOMIC_INIT(0);

#if VALIDATE_OPERATORS
static atomic_t ____cacheline_aligned mutexes		= ATOMIC_INIT(0);
static atomic_t ____cacheline_aligned semaphores	= ATOMIC_INIT(0);
static atomic_t ____cacheline_aligned readers		= ATOMIC_INIT(0);
static atomic_t ____cacheline_aligned writers		= ATOMIC_INIT(0);
#endif

static unsigned int ____cacheline_aligned mutexes_taken[20];
static unsigned int ____cacheline_aligned semaphores_taken[20];
static unsigned int ____cacheline_aligned reads_taken[20];
static unsigned int ____cacheline_aligned writes_taken[20];
static unsigned int ____cacheline_aligned downgrades_taken[20];

static struct completion ____cacheline_aligned mx_comp[20];
static struct completion ____cacheline_aligned sm_comp[20];
static struct completion ____cacheline_aligned rd_comp[20];
static struct completion ____cacheline_aligned wr_comp[20];
static struct completion ____cacheline_aligned dg_comp[20];

static struct timer_list ____cacheline_aligned timer;

#define ACCOUNT(var, N) var##_taken[N]++;

#if VALIDATE_OPERATORS
#define TRACK(var, dir) atomic_##dir(&(var))

#define CHECK(var, cond, val)						\
do {									\
	int x = atomic_read(&(var));					\
	if (unlikely(!(x cond (val))))					\
		printk("check [%s %s %d, == %d] failed in %s\n",	\
		       #var, #cond, (val), x, __func__);		\
} while (0)

#else
#define TRACK(var, dir)		do {} while(0)
#define CHECK(var, cond, val)	do {} while(0)
#endif

static inline void do_mutex_lock(unsigned int N)
{
	mutex_lock(&mutex);

	ACCOUNT(mutexes, N);
	TRACK(mutexes, inc);
	CHECK(mutexes, ==, 1);
}

static inline void do_mutex_unlock(unsigned int N)
{
	CHECK(mutexes, ==, 1);
	TRACK(mutexes, dec);

	mutex_unlock(&mutex);
}

static inline void do_down(unsigned int N)
{
	CHECK(mutexes, <, seminit);

	down(&sem);

	ACCOUNT(semaphores, N);
	TRACK(semaphores, inc);
}

static inline void do_up(unsigned int N)
{
	CHECK(semaphores, >, 0);
	TRACK(semaphores, dec);

	up(&sem);
}

static inline void do_down_read(unsigned int N)
{
	down_read(&rwsem);

	ACCOUNT(reads, N);
	TRACK(readers, inc);
	CHECK(readers, >, 0);
	CHECK(writers, ==, 0);
}

static inline void do_up_read(unsigned int N)
{
	CHECK(readers, >, 0);
	CHECK(writers, ==, 0);
	TRACK(readers, dec);

	up_read(&rwsem);
}

static inline void do_down_write(unsigned int N)
{
	down_write(&rwsem);

	ACCOUNT(writes, N);
	TRACK(writers, inc);
	CHECK(writers, ==, 1);
	CHECK(readers, ==, 0);
}

static inline void do_up_write(unsigned int N)
{
	CHECK(writers, ==, 1);
	CHECK(readers, ==, 0);
	TRACK(writers, dec);

	up_write(&rwsem);
}

static inline void do_downgrade_write(unsigned int N)
{
	CHECK(writers, ==, 1);
	CHECK(readers, ==, 0);
	TRACK(writers, dec);
	TRACK(readers, inc);

	downgrade_write(&rwsem);

	ACCOUNT(downgrades, N);
}

static inline void sched(void)
{
	if (do_sched)
		schedule();
}

int mutexer(void *arg)
{
	unsigned int N = (unsigned long) arg;

	daemonize("Mutex%u", N);

	while (atomic_read(&do_stuff)) {
		do_mutex_lock(N);
		if (load)
			udelay(load);
		do_mutex_unlock(N);
		sched();
	}

	if (verbose >= 2)
		printk("%s: done\n", current->comm);
	complete_and_exit(&mx_comp[N], 0);
}

int semaphorer(void *arg)
{
	unsigned int N = (unsigned long) arg;

	daemonize("Sem%u", N);

	while (atomic_read(&do_stuff)) {
		do_down(N);
		if (load)
			udelay(load);
		do_up(N);
		sched();
	}

	if (verbose >= 2)
		printk("%s: done\n", current->comm);
	complete_and_exit(&sm_comp[N], 0);
}

int reader(void *arg)
{
	unsigned int N = (unsigned long) arg;

	daemonize("Read%u", N);

	while (atomic_read(&do_stuff)) {
		do_down_read(N);
#ifdef LOAD_TEST
		if (load)
			udelay(load);
#endif
		do_up_read(N);
		sched();
	}

	if (verbose >= 2)
		printk("%s: done\n", current->comm);
	complete_and_exit(&rd_comp[N], 0);
}

int writer(void *arg)
{
	unsigned int N = (unsigned long) arg;

	daemonize("Write%u", N);

	while (atomic_read(&do_stuff)) {
		do_down_write(N);
#ifdef LOAD_TEST
		if (load)
			udelay(load);
#endif
		do_up_write(N);
		sched();
	}

	if (verbose >= 2)
		printk("%s: done\n", current->comm);
	complete_and_exit(&wr_comp[N], 0);
}

int downgrader(void *arg)
{
	unsigned int N = (unsigned long) arg;

	daemonize("Down%u", N);

	while (atomic_read(&do_stuff)) {
		do_down_write(N);
#ifdef LOAD_TEST
		if (load)
			udelay(load);
#endif
		do_downgrade_write(N);
#ifdef LOAD_TEST
		if (load)
			udelay(load);
#endif
		do_up_read(N);
		sched();
	}

	if (verbose >= 2)
		printk("%s: done\n", current->comm);
	complete_and_exit(&dg_comp[N], 0);
}

static void stop_test(unsigned long dummy)
{
	atomic_set(&do_stuff, 0);
}

static unsigned int total(const char *what, unsigned int counts[], int num)
{
	unsigned int tot = 0, max = 0, min = UINT_MAX, zeros = 0, cnt;
	int loop;

	for (loop = 0; loop < num; loop++) {
		cnt = counts[loop];

		if (cnt == 0) {
			zeros++;
			min = 0;
			continue;
		}

		tot += cnt;
		if (tot > max)
			max = tot;
		if (tot < min)
			min = tot;
	}

	if (verbose && tot > 0) {
		printk("%s:", what);

		for (loop = 0; loop < num; loop++) {
			cnt = counts[loop];

			if (cnt == 0)
				printk(" zzz");
			else
				printk(" %d%%", cnt * 100 / tot);
		}

		printk("\n");
	}

	return tot;
}

/*****************************************************************************/
/*
 *
 */
static int __init do_tests(void)
{
	unsigned long loop;
	unsigned int mutex_total, sem_total, rd_total, wr_total, dg_total;

	if (nummx < 0 || nummx > 20 ||
	    numsm < 0 || numsm > 20 ||
	    numrd < 0 || numrd > 20 ||
	    numwr < 0 || numwr > 20 ||
	    numdg < 0 || numdg > 20 ||
	    seminit < 1 ||
	    elapse < 1
	    ) {
		printk("Parameter out of range\n");
		return -ERANGE;
	}

	if ((nummx | numsm | numrd | numwr | numdg) == 0) {
		printk("Nothing to do\n");
		return -EINVAL;
	}

	if (verbose)
		printk("\nStarting synchronisation primitive tests...\n");

	mutex_init(&mutex);
	sema_init(&sem, seminit);
	init_rwsem(&rwsem);
	atomic_set(&do_stuff, 1);

	/* kick off all the children */
	for (loop = 0; loop < 20; loop++) {
		if (loop < nummx) {
			init_completion(&mx_comp[loop]);
			kernel_thread(mutexer, (void *) loop, 0);
		}

		if (loop < numsm) {
			init_completion(&sm_comp[loop]);
			kernel_thread(semaphorer, (void *) loop, 0);
		}

		if (loop < numrd) {
			init_completion(&rd_comp[loop]);
			kernel_thread(reader, (void *) loop, 0);
		}

		if (loop < numwr) {
			init_completion(&wr_comp[loop]);
			kernel_thread(writer, (void *) loop, 0);
		}

		if (loop < numdg) {
			init_completion(&dg_comp[loop]);
			kernel_thread(downgrader, (void *) loop, 0);
		}
	}

	/* set a stop timer */
	init_timer(&timer);
	timer.function = stop_test;
	timer.expires = jiffies + elapse * HZ;
	add_timer(&timer);

	/* now wait until it's all done */
	for (loop = 0; loop < nummx; loop++)
		wait_for_completion(&mx_comp[loop]);

	for (loop = 0; loop < numsm; loop++)
		wait_for_completion(&sm_comp[loop]);

	for (loop = 0; loop < numrd; loop++)
		wait_for_completion(&rd_comp[loop]);

	for (loop = 0; loop < numwr; loop++)
		wait_for_completion(&wr_comp[loop]);

	for (loop = 0; loop < numdg; loop++)
		wait_for_completion(&dg_comp[loop]);

	atomic_set(&do_stuff, 0);
	del_timer(&timer);

	if (mutex_is_locked(&mutex))
		printk(KERN_ERR "Mutex is still locked!\n");

	/* count up */
	mutex_total	= total("MTX", mutexes_taken, nummx);
	sem_total	= total("SEM", semaphores_taken, numsm);
	rd_total	= total("RD ", reads_taken, numrd);
	wr_total	= total("WR ", writes_taken, numwr);
	dg_total	= total("DG ", downgrades_taken, numdg);

	/* print the results */
	if (verbose) {
		printk("mutexes taken: %u\n", mutex_total);
		printk("semaphores taken: %u\n", sem_total);
		printk("reads taken: %u\n", rd_total);
		printk("writes taken: %u\n", wr_total);
		printk("downgrades taken: %u\n", dg_total);
	}
	else {
		printk("%3d %3d %3d %3d %3d %c %3d %9u %9u %9u %9u %9u\n",
		       nummx, numsm, numrd, numwr, numdg,
		       do_sched ? 's' : '-',
		       load,
		       mutex_total,
		       sem_total,
		       rd_total,
		       wr_total,
		       dg_total);
	}

	/* tell insmod to discard the module */
	if (verbose)
		printk("Tests complete\n");
	return -ENOANO;

} /* end do_tests() */

module_init(do_tests);
