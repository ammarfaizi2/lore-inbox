Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWFOWsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWFOWsW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 18:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWFOWsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 18:48:22 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:60855 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750719AbWFOWsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 18:48:21 -0400
Date: Thu, 15 Jun 2006 15:48:25 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: Darren Hart <dvhltc@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>
Subject: Re: [RFC PATCH -rt] Priority preemption latency
Message-ID: <20060615224825.GA16911@monkey.ibm.com>
References: <200606091701.55185.dvhltc@us.ibm.com> <200606102324.58932.dvhltc@us.ibm.com> <20060611073609.GA12456@elte.hu> <200606120838.25200.dvhltc@us.ibm.com> <20060615210658.GA19525@monkey.ibm.com> <Pine.LNX.4.64.0606152347320.24056@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606152347320.24056@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2006 at 12:05:21AM +0100, Esben Nielsen wrote:
> Well, I can't say understand what your test is supposed to test. But I 
> know having printf() inside something which is supposed to be RT is a big 
> no-no as it can block.

You are correct.  John's modifications to the testcase actually removed
the printfs from the threads we are concerned with.  I left them in because
they were part of the 'original' tetscase, and I wanted to introduce as
few changes as possible.  In hindsight, that was a mistake.

With the printfs commented out (in the worker threads) the testcase still
fails at about the same rate.

Darren, can you comment those out in the version on your site?  An updated
copy is attached.
-- 
Mike

/*    Filename: prio-preempt.c
 *      Author: Dinakar Guniguntala <dino@us.ibm.com>
 * Description: Test priority preemption
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *
 * Copyright (C) IBM Corporation, 2006
 *
 * 2006-Jun-01:	Initial version by Dinakar Guniguntala
 *              Changes from John Stultz and Vivek Pallantla
 */

#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <time.h>
#include <pthread.h>
#include <sched.h>
#include <errno.h>
#include <sys/syscall.h>
#include "librt.h"

#define NUM_WORKERS	27
#define CHECK_LIMIT	1

volatile int busy_threads = 0;
volatile int test_over = 0;
volatile int threads_running=0;
static int rt_threads = 0;
static int int_threads = 0;
static pthread_mutex_t  bmutex = PTHREAD_MUTEX_INITIALIZER;

static pthread_mutex_t mutex[NUM_WORKERS+1];
static pthread_cond_t cond[NUM_WORKERS+1];
static int t_after_wait[NUM_WORKERS];

void *int_thread(void* arg)
{
	int j, a = 0;
	while (!test_over) {
		/* do some busy work */
		if (!(a%4))
			a = a * 3;
		else if (!(a%6))
			a = a /2;
		else
			a++;
		usleep(10);
	}
	return (void*)a;
}

void *busy_thread(void* arg)
{
	struct sched_param sched_param;
	int policy, mypri = 0, tid;
	tid = (int) (((struct thread *) arg)->arg);

	if (pthread_getschedparam(pthread_self(), &policy, &sched_param) != 0) {
		printf("ERR: Couldn't get pthread info \n");
	} else {
		mypri = sched_param.sched_priority;
	}

	pthread_mutex_lock(&bmutex);
	busy_threads++;
	printf("Busy Thread %d(%d): Running...\n", tid, mypri);
	pthread_mutex_unlock(&bmutex);

	/* TODO: Add sched set affinity here */

	/* Busy loop */
	while (!test_over);

	printf("Busy Thread %d(%d): Exiting\n", tid, mypri);
	return NULL;
}

void *worker_thread(void* arg)
{
	struct sched_param sched_param;
	int policy, rc, mypri = 0, tid, times = 0;
	tid = (int) (((struct thread *) arg)->arg);
	nsec_t pstart, pend;
	
	if (pthread_getschedparam(pthread_self(), &policy, &sched_param) != 0) {
		printf("ERR: Couldn't get pthread info \n");
	} else {
		mypri = sched_param.sched_priority;
	}
	/* check in */
	pthread_mutex_lock(&bmutex);
	threads_running++;
	pthread_mutex_unlock(&bmutex);

	/* block */
	rc = pthread_mutex_lock(&mutex[tid]);
	rc = pthread_cond_wait(&cond[tid], &mutex[tid]);
	rc = pthread_mutex_unlock(&mutex[tid]);
	
	/* printf("%llu: Thread %d(%d) wakes up from sleep \n", rt_gettime(), tid, mypri); */
	
	/*check if we're the last thread */
	if (tid == NUM_WORKERS-1) {
		t_after_wait[tid] = 1;
		pthread_mutex_lock(&bmutex);
		threads_running--;
		pthread_mutex_unlock(&bmutex);
		return NULL;
	}

	/* Signal next thread */
	rc = pthread_mutex_lock(&mutex[tid+1]);
	rc = pthread_cond_signal(&cond[tid+1]);
	/* printf("%llu: Thread %d(%d): Sent signal (%d) to (%d)\n", rt_gettime(), tid, mypri,
                        rc, tid+1); */

   	pstart = pend = rt_gettime();
	rc = pthread_mutex_unlock(&mutex[tid+1]);

	/* printf("%llu: Thread %d(%d) setting it's bit \n",rt_gettime(), tid, mypri); */

	t_after_wait[tid] = 1;

	while (t_after_wait[tid+1] != 1) {
		pend = rt_gettime();
		times++;
	}

	if (times >= CHECK_LIMIT) {
		printf("Thread %d(%d): Non-Preempt limit reached. %llu ns max latency\n",
				tid, mypri, pend-pstart);
		exit(1);
	}

	/* check out */
	pthread_mutex_lock(&bmutex);
	threads_running--;
	pthread_mutex_unlock(&bmutex);

	return NULL;
}

void *master_thread(void* arg)
{
	int i, pri_boost;

	/* start interrupter thread */
	if (int_threads) {
		pri_boost = 90;
		for (i = 0; i < rt_threads; i++) {
			create_fifo_thread(int_thread, (void*)0,
					sched_get_priority_min(SCHED_FIFO) + pri_boost);
		}
	}

	/* start the (N-1) busy threads */
	pri_boost = 80;
	for (i = rt_threads; i > 1; i--) {
                create_fifo_thread(busy_thread, (void*)i,
			sched_get_priority_min(SCHED_FIFO) + pri_boost);
	}

	/* make sure children are started */
	while (busy_threads < (rt_threads-1))
		sleep(1);

	printf("Busy threads created!\n");

	/* start NUM_WORKERS worker threads */
	for (i = 0, pri_boost = 10; i < NUM_WORKERS ; i++, pri_boost+=2) {
		pthread_mutex_init(&mutex[i], NULL);
		pthread_cond_init(&cond[i], NULL);
                create_fifo_thread(worker_thread, (void*)i,
				sched_get_priority_min(SCHED_FIFO) + pri_boost);
	}


	printf("Worker threads created\n");
	/* Let the worker threads wait on the cond vars */
	while (threads_running < NUM_WORKERS)
		sleep(2);

	printf("Signaling first thread\n");
	pthread_mutex_lock(&mutex[0]);
	pthread_cond_signal(&cond[0]);
	pthread_mutex_unlock(&mutex[0]);

	while (threads_running)
		sleep(20);

	test_over = 1;
	return NULL;
}

int parse_args(int c, char *v)
{
	int handled = 1;
	switch (c) {
		case 'n':
			rt_threads = atoi(v);
			break;
		case 'i':
			int_threads = 1;
			break;
		default:
			handled = 0;
			break;
	}
	return handled;
}

int main(int argc, char* argv[])
{
	int pri_boost;

	rt_init("n:i", parse_args, argc, argv);

	if (rt_threads == 0) {
		printf("Usage: %s -n num_rt_threads [-i]\n", argv[0]);
		exit(1);
	}

	pri_boost = 81;
        create_fifo_thread(master_thread, (void*)0,
		 sched_get_priority_min(SCHED_FIFO) + pri_boost);

        /* wait for threads to complete */
        join_threads();

	return 0;
}


