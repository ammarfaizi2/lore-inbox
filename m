Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262327AbVD1W4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbVD1W4T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 18:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbVD1W4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 18:56:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19622 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262323AbVD1Wy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 18:54:26 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050428182926.GC16545@kvack.org> 
References: <20050428182926.GC16545@kvack.org> 
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] unify semaphore implementations 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Thu, 28 Apr 2005 23:54:21 +0100
Message-ID: <10852.1114728861@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Benjamin LaHaise <bcrl@kvack.org> wrote:

> Please review the following series of patches for unifying the 
> semaphore implementation across all architectures (not posted as 
> they're about 350K), as they have only been tested on x86-64.

It's not as efficient as it could be. You get the semaphore spinlock again in
down_*failed() after you've slept. You can probably avoid doing that. If you
want just to wake up the first thing in the queue each time (as you seem to do
by using add_wait_queue_exclusive_locked()) then why not do as rwsems do and
make up() transfer ownership directly? up() has to take the spinlock anyway
when it examines the queue of sleepers. That way up() can also transfer the
ownership to things other than processes also; something that doesn't appear
easy with waitqueues.

And if you want to thoroughly test and benchmark your semaphores, see the
attached module. It tests both semaphores (as mutexes) and rw-semaphores.

David

/* rwsem-any.c: run some threads to do R/W semaphore tests
 *
 * Copyright (C) 2005 Red Hat, Inc. All Rights Reserved.
 * Written by David Howells (dhowells@redhat.com)
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version
 * 2 of the License, or (at your option) any later version.
 *
 * run as: insmod rwsem-any.ko rd=1 wr=1 dg=0 mx=0
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

#define SCHED
#define LOAD_TEST

static int nummx = 0, numrd = 1, numwr = 1, numdg = 1, elapse = 5;
static int verbose = 0;

MODULE_AUTHOR("David Howells");
MODULE_DESCRIPTION("R/W semaphore test demo");
MODULE_LICENSE("GPL");

module_param_named(v, verbose, int, 0);
MODULE_PARM_DESC(verbose, "Verbosity");

module_param_named(mx, nummx, int, 0);
MODULE_PARM_DESC(nummx, "Number of mutex threads");

module_param_named(rd, numrd, int, 0);
MODULE_PARM_DESC(numrd, "Number of reader threads");

module_param_named(wr, numwr, int, 0);
MODULE_PARM_DESC(numwr, "Number of writer threads");

module_param_named(dg, numdg, int, 0);
MODULE_PARM_DESC(numdg, "Number of downgrader threads");

module_param(elapse, int, 0);
MODULE_PARM_DESC(elapse, "Number of seconds to run for");

#ifdef LOAD_TEST
static int load = 0;
module_param(load, int, 0);
MODULE_PARM_DESC(load, "Length of load in uS");
#endif

#ifdef SCHED
static int do_sched = 0;
module_param(do_sched, int, 0);
MODULE_PARM_DESC(do_sched, "True if each thread should schedule regularly");
#endif

/* the semaphores under test */
static struct semaphore mutex_sem;
static struct rw_semaphore rwsem_sem;


#ifdef DEBUG_RWSEM
extern struct rw_semaphore *rwsem_to_monitor;
#endif

static atomic_t mutexes = ATOMIC_INIT(0);
static atomic_t readers = ATOMIC_INIT(0);
static atomic_t writers = ATOMIC_INIT(0);
static atomic_t do_stuff = ATOMIC_INIT(0);
static atomic_t mutexes_taken = ATOMIC_INIT(0);
static atomic_t reads_taken = ATOMIC_INIT(0);
static atomic_t writes_taken = ATOMIC_INIT(0);
static atomic_t downgrades_taken = ATOMIC_INIT(0);

static struct completion mx_comp[20], rd_comp[20], wr_comp[20], dg_comp[20];

static struct timer_list timer;

#define CHECK(expr)							\
do {									\
	if (!(expr))							\
		printk("check " #expr " failed in %s\n", __func__);	\
} while (0)

#define CHECKA(var, val)									\
do {												\
	int x = atomic_read(&(var));								\
	if (x != (val))										\
		printk("check [%s != %d, == %d] failed in %s\n", #var, (val), x, __func__);	\
} while (0)

static inline void d(void)
{
	down(&mutex_sem);
	atomic_inc(&mutexes);
	atomic_inc(&mutexes_taken);
	CHECKA(mutexes, 1);
}

static inline void u(void)
{
	CHECKA(mutexes, 1);
	atomic_dec(&mutexes);
	up(&mutex_sem);
}

static inline void dr(void)
{
	down_read(&rwsem_sem);
	atomic_inc(&readers);
	atomic_inc(&reads_taken);
	CHECKA(writers, 0);
}

static inline void ur(void)
{
	CHECKA(writers, 0);
	atomic_dec(&readers);
	up_read(&rwsem_sem);
}

static inline void dw(void)
{
	down_write(&rwsem_sem);
	atomic_inc(&writers);
	atomic_inc(&writes_taken);
	CHECKA(writers, 1);
	CHECKA(readers, 0);
}

static inline void uw(void)
{
	CHECKA(writers, 1);
	CHECKA(readers, 0);
	atomic_dec(&writers);
	up_write(&rwsem_sem);
}

static inline void dgw(void)
{
	CHECKA(writers, 1);
	CHECKA(readers, 0);
	atomic_dec(&writers);
	atomic_inc(&readers);
	downgrade_write(&rwsem_sem);
	atomic_inc(&downgrades_taken);
}

static inline void sched(void)
{
#ifdef SCHED
	if (do_sched)
		schedule();
#endif
}

int mutexer(void *arg)
{
	unsigned int N = (unsigned long) arg;

	daemonize("Mutex%u", N);

	while (atomic_read(&do_stuff)) {
		d();
#ifdef LOAD_TEST
		if (load)
			udelay(load);
#endif
		u();
		sched();
	}

	if (verbose)
		printk("%s: done\n", current->comm);
	complete_and_exit(&mx_comp[N], 0);
}

int reader(void *arg)
{
	unsigned int N = (unsigned long) arg;

	daemonize("Read%u", N);

	while (atomic_read(&do_stuff)) {
		dr();
#ifdef LOAD_TEST
		if (load)
			udelay(load);
#endif
		ur();
		sched();
	}

	if (verbose)
		printk("%s: done\n", current->comm);
	complete_and_exit(&rd_comp[N], 0);
}

int writer(void *arg)
{
	unsigned int N = (unsigned long) arg;

	daemonize("Write%u", N);

	while (atomic_read(&do_stuff)) {
		dw();
#ifdef LOAD_TEST
		if (load)
			udelay(load);
#endif
		uw();
		sched();
	}

	if (verbose)
		printk("%s: done\n", current->comm);
	complete_and_exit(&wr_comp[N], 0);
}

int downgrader(void *arg)
{
	unsigned int N = (unsigned long) arg;

	daemonize("Down%u", N);

	while (atomic_read(&do_stuff)) {
		dw();
#ifdef LOAD_TEST
		if (load)
			udelay(load);
#endif
		dgw();
#ifdef LOAD_TEST
		if (load)
			udelay(load);
#endif
		ur();
		sched();
	}

	if (verbose)
		printk("%s: done\n", current->comm);
	complete_and_exit(&dg_comp[N], 0);
}

static void stop_test(unsigned long dummy)
{
	atomic_set(&do_stuff, 0);
}

/*****************************************************************************/
/*
 *
 */
static int __init rwsem_init_module(void)
{
	unsigned long loop;

	if (verbose)
		printk("\nrwsem_any starting tests...\n");

	init_MUTEX(&mutex_sem);
	init_rwsem(&rwsem_sem);
	atomic_set(&do_stuff, 1);

#ifdef DEBUG_RWSEM
	rwsem_to_monitor = &rwsem_sem;
#endif

	/* kick off all the children */
	for (loop = 0; loop < 20; loop++) {
		if (loop < nummx) {
			init_completion(&mx_comp[loop]);
			kernel_thread(mutexer, (void *) loop, 0);
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

	for (loop = 0; loop < numrd; loop++)
		wait_for_completion(&rd_comp[loop]);

	for (loop = 0; loop < numwr; loop++)
		wait_for_completion(&wr_comp[loop]);

	for (loop = 0; loop < numdg; loop++)
		wait_for_completion(&dg_comp[loop]);

	atomic_set(&do_stuff, 0);
	del_timer(&timer);

	/* print the results */
	if (verbose) {
#ifdef CONFIG_RWSEM_XCHGADD_ALGORITHM
		printk("rwsem counter = %ld\n", rwsem_sem.count);
#else
		printk("rwsem counter = %d\n", rwsem_sem.activity);
#endif

		printk("mutexes taken: %d\n", atomic_read(&mutexes_taken));
		printk("reads taken: %d\n", atomic_read(&reads_taken));
		printk("writes taken: %d\n", atomic_read(&writes_taken));
		printk("downgrades taken: %d\n", atomic_read(&downgrades_taken));
	}
	else {
		printk("%3d %3d %3d %3d %c %3d %9d %9d %9d %9d\n",
		       nummx, numrd, numwr, numdg,
		       do_sched ? 's' : '-',
#ifdef LOAD_TEST
		       load,
#else
		       0,
#endif
		       atomic_read(&mutexes_taken),
		       atomic_read(&reads_taken),
		       atomic_read(&writes_taken),
		       atomic_read(&downgrades_taken));
	}

#ifdef DEBUG_RWSEM
	rwsem_to_monitor = NULL;
#endif

	/* tell insmod to discard the module */
	return -ENOANO;
} /* end rwsem_init_module() */

module_init(rwsem_init_module);

