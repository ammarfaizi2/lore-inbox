Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbVCIWyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbVCIWyn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 17:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVCIWyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 17:54:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8072 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262516AbVCIV6t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 16:58:49 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1110366614.6280.86.camel@laptopd505.fenrus.org> 
References: <1110366614.6280.86.camel@laptopd505.fenrus.org>  <20050308170107.231a145c.akpm@osdl.org> <1110327267.24286.139.camel@dyn318077bld.beaverton.ibm.com> <18744.1110364438@redhat.com> <20050309110404.GA4088@in.ibm.com> 
To: Arjan van de Ven <arjan@infradead.org>
Cc: suparna@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       Badari Pulavarty <pbadari@us.ibm.com>, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: aio stress panic on 2.6.11-mm1 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 09 Mar 2005 21:58:15 +0000
Message-ID: <15606.1110405495@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:

> On Wed, 2005-03-09 at 16:34 +0530, Suparna Bhattacharya wrote:
> > Any sense of how costly it is to use spin_lock_irq's vs spin_lock
> > (across different architectures) ? Isn't rwsem used very widely ?
> 
> oh also rwsems aren't used all that much simply because they are quite
> more expensive than regular semaphores, so that you need a HUGE bias in
> reader/writer ratio to make it even worth it...

I can put some numbers to that. I've attached the module that I use for
destruct testing rwsems. I've extended it to splat ordinary semaphores too.

You run it by insmod'ing it. It will hammer the box for a few seconds, print a
summary to the console log and then return -ENOANO to cause insmod to abort
module addition.

You can give it a number of parameters:

	mx=N		Number of mutex splatting threads to run
	rd=N		Number of rwsem read-splatting threads to run
	wr=N		Number of rwsem write-splatting threads to run
	dg=N		Number of rwsem downgrader threads ro run
	elapse=N	Number of seconds to run for (default 5)
	do_sched=1	Schedule occasionally
	load=N		Number of microseconds of load
	verbose=0	Print only a summary (as in the table below)
	verbose=1	Print more information

So, some statistics for a dual 200MHz Pentium Pro box, running the test for
the default time:

	MODULE PARAM          RESULTS
	===================== =======================================
	mx  rd  wr  dg  S ld  mutexes   reads     writes    downgrade
	=== === === === = === ========= ========= ========= =========

With no load and without scheduling:

	  1   0   0   0 -   0   7331475         0         0         0
	  1   0   0   0 -   0   7465404         0         0         0
	  1   0   0   0 -   0   7319429         0         0         0
	  0   1   0   0 -   0         0   7743129         0         0
	  0   1   0   0 -   0         0   7698473         0         0
	  0   1   0   0 -   0         0   7614090         0         0
	  0   0   1   0 -   0         0         0   7051591         0
	  0   0   1   0 -   0         0         0   7027214         0
	  0   0   1   0 -   0         0         0   7054375         0
	  0   1   1   0 -   0         0    119838    106730         0
	  0   1   1   0 -   0         0    637862     96867         0
	  0   1   1   0 -   0         0    520168     89630         0

	 10   0   0   0 -   0   1068401         0         0         0
	 10   0   0   0 -   0   1035501         0         0         0
	 10   0   0   0 -   0   1170587         0         0         0
	  0  10   0   0 -   0         0   2865253         0         0
	  0  10   0   0 -   0         0   2983333         0         0
	  0  10   0   0 -   0         0   2969689         0         0
	  0   0  10   0 -   0         0         0    503357         0
	  0   0  10   0 -   0         0         0    657964         0
	  0   0  10   0 -   0         0         0    758048         0
	  0  10  10   0 -   0         0    382710    117488         0
	  0  10  10   0 -   0         0    519159    121845         0
	  0  10  10   0 -   0         0    639660    103995         0
	  0  10   1   0 -   0         0   2876112         0         0
	  0  10   1   0 -   0         0   2954678         0         0
	  0  10   1   0 -   0         0   1438340     37437         0

With no load and with occasional scheduling:

	  0   1   1   0 s   0         0    130326    110929         0
	  0   1   1   0 s   0         0    135551     99816         0
	  0   1   1   0 s   0         0    136236    117179         0

	 10   0   0   0 s   0    283945         0         0         0
	 10   0   0   0 s   0    253822         0         0         0
	 10   0   0   0 s   0    275887         0         0         0
	  0  10   0   0 s   0         0   2398587         0         0
	  0  10   0   0 s   0         0   2329326         0         0
	  0  10   0   0 s   0         0   2326537         0         0
	  0   0  10   0 s   0         0         0    305368         0
	  0   0  10   0 s   0         0         0    277164         0
	  0   0  10   0 s   0         0         0    310533         0
	  0  10  10   0 s   0         0    155986    156444         0
	  0  10  10   0 s   0         0    141763    172333         0
	  0  10  10   0 s   0         0    157835    130404         0
	  0  10   1   0 s   0         0   2120867      4928         0
	  0  10   1   0 s   0         0   2076650     11902         0
	  0  10   1   0 s   0         0   2243057     16289         0

With a load of 2uS:

	  1   0   0   0 -   2   1607186         0         0         0
	  0   1   0   0 -   2         0   1627802         0         0
	  0   0   1   0 -   2         0         0   1595146         0
	  0   1   1   0 -   2         0     92531     87686         0

	  1   0   0   0 s   2    988549         0         0         0
	  0   1   0   0 s   2         0    987335         0         0
	  0   0   1   0 s   2         0         0    969585         0
	  0   1   1   0 s   2         0    101914     93392         0

	 10   0   0   0 -   2    188636         0         0         0
	  0  10   0   0 -   2         0   2139068         0         0
	  0   0  10   0 -   2         0         0    273576         0
	  0  10  10   0 -   2         0    178319    113583         0
	  0  10   1   0 -   2         0   2132616         0         0

	 10   0   0   0 s   2    175498         0         0         0
	  0  10   0   0 s   2         0   1303410         0         0
	  0   0  10   0 s   2         0         0    239851         0
	  0  10  10   0 s   2         0    116714    125319         0
	  0  10   1   0 s   2         0   1063463      7678         0

	  2   0   0   0 s   2    190007         0         0         0
	  0   2   0   0 s   2         0   1309071         0         0
	  0   0   2   0 s   2         0         0    187197         0

	  3   0   0   0 s   2    180995         0         0         0
	  0   3   0   0 s   2         0   1282154         0         0
	  0   0   3   0 s   2         0         0    219858         0

It's interesting to note that using only write-locks on an rwsem can actually
be somewhat _more_ efficient than using an ordinary semaphore configured as a
mutex; particularly as the number of competing threads increases.

And, of course, you have to take these results with a small pinch of salt; the
box I've been running them on has most the usual clutch of userspace services
you'd expect to find on an FC3 or newer installation. Ideally, these tests
should be run from a shell started by the kernel in place of /sbin/init.

David
---
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
