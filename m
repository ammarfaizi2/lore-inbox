Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422721AbWJFW5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422721AbWJFW5h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 18:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422723AbWJFW5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 18:57:37 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:41106 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422721AbWJFW5g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 18:57:36 -0400
Subject: Re: 2.6.18 Nasty Lockup
From: john stultz <johnstul@us.ibm.com>
To: caglar@pardus.org.tr
Cc: Greg Schafer <gschafer@zip.com.au>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@muc.de>
In-Reply-To: <200609291149.52443.caglar@pardus.org.tr>
References: <20060926123640.GA7826@tigers.local>
	 <1159384500.29040.3.camel@localhost>
	 <200609281439.58755.caglar@pardus.org.tr>
	 <200609291149.52443.caglar@pardus.org.tr>
Content-Type: multipart/mixed; boundary="=-d2p7oeR/CqJ0IcMXG2vH"
Date: Fri, 06 Oct 2006 15:57:32 -0700
Message-Id: <1160175452.6140.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-d2p7oeR/CqJ0IcMXG2vH
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Fri, 2006-09-29 at 11:49 +0300, S.Çağlar Onur wrote:
> 28 Eyl 2006 Per 14:39 tarihinde, S.Çağlar Onur şunları yazmıştı: 
> > 27 Eyl 2006 Çar 22:14 tarihinde, john stultz şunları yazmıştı:
> > > Ok. Good to hear you have a workaround. Now to sort out why your TSCs
> > > are becoming un-synced. From the dmesg you sent me privately, I noticed
> > > that while you have 4 cpus, the following message only shows up once:
> > >
> > > ACPI: Processor [CPU1] (supports 8 throttling states)
> > >
> > > Does disabling cpufreq change anything?
> >
> > By the way i tried but nothing changes :(
> 
> Is there any other advice available? Is there anything else you want me to 
> try?

Hey S.Çağlar,

	So I just wrote up this test case that will show how skewed the TSCs
are. I'd be interested if you could run it a few times quickly after a
fresh boot, and then again a day or so later.

See the header comment for instructions.

And just a fair warning: this runs w/ SCHED_FIFO, and thus has the
potential to hang your system (while writing it I made a few flubs and
it hung my system). I believe I've got all of the issues fixed (tested
on a few systems), but wanted to give you a fair warning before I
suggest you run this.  :)

thanks
-john

--=-d2p7oeR/CqJ0IcMXG2vH
Content-Disposition: attachment; filename=tsc-drift.c
Content-Type: text/x-csrc; name=tsc-drift.c; charset=utf-8
Content-Transfer-Encoding: 7bit

/* tsc-drift.c
 *	Checks TSC delta across cpus.
 *
 *	Build: gcc -lpthread tsc-drift.c -o tsc-drift
 *	Run: ./tsc-drift <NUM CPUS>
 *
 *	Copyright (C) 2006 IBM, John Stultz <johnstul@us.ibm.com>
 *	Licensed under the GPL.
 */

#include <stdio.h>
#include <sys/time.h>
#include <pthread.h>
#include <errno.h>
#include <stdlib.h>

#define MAX_THREADS 128
#define LISTSIZE 1000

# define	rdtscll(val)	__asm__ __volatile__("rdtsc" : "=A" (val))

typedef struct { volatile int counter; } atomic_t;

int thread_count = 1;
int done;
volatile int flag;
volatile int ready;
atomic_t check_in;

unsigned long long cpu_tsc_vals[MAX_THREADS][LISTSIZE];

static inline int atomic_add(int i, atomic_t *v)
{
	int __i;
	__i = i;
	asm volatile(
		"lock; xaddl %0, %1;"
		:"=r"(i)
		:"m"(v->counter), "0"(i));
	return i + __i;
}

void atomic_inc(atomic_t *v)
{
	atomic_add(1,v);
}

void atomic_dec(atomic_t *v)
{
	atomic_add(-1, v);
}

void atomic_set(atomic_t *v, int val)
{
	v->counter = val;
}

int atomic_get(atomic_t *v)
{
	return v->counter;
}


void* cpu_thread(void* arg)
{
	int cpu_id = (int)arg;
	int count = 0;
	long mask = 1<<cpu_id;
	/* bind to cpu */
	if(sched_setaffinity(0, sizeof(mask), &mask)){
		printf("Cannot bind to cpu %i (%i)\n", cpu_id, errno);
		exit(1);
	}
	usleep(10);
	while(1){
		while(!ready)
			usleep(1);
		if (done)
			break;
		atomic_inc(&check_in);
		while (!flag)
			/* spin */;
		rdtscll(cpu_tsc_vals[cpu_id][count++]);
		atomic_dec(&check_in);
	}
}

void* controlling_thread(void* arg)
{
	int count = 0;
	long mask = 1;
	/* bind to cpu */
	sched_setaffinity(0, sizeof(mask), &mask);
	usleep(10);
	for(count =0 ; count < LISTSIZE; count++) {		
		ready = 1;
		/* wait for check ins*/
		while(atomic_get(&check_in) < (thread_count -1)) 
			usleep(1);
		ready = 0;
		usleep(10);
		/* set flag*/
		while(!flag)
			flag=1;
		rdtscll(cpu_tsc_vals[0][count]);
		/* wait for check ins*/
		while(atomic_get(&check_in) > 0)
			usleep(1);
		flag = 0;
	}
	done = 1;
	ready =1;
}


void create_thread(pthread_t *thread, void*(*func)(void*), void* arg, int prio)
{
	pthread_attr_t attr;
	struct sched_param param;

	param.sched_priority = sched_get_priority_min(SCHED_FIFO) + prio;

	pthread_attr_init(&attr);
	pthread_attr_setinheritsched (&attr, PTHREAD_EXPLICIT_SCHED);
	pthread_attr_setschedparam(&attr, &param);
	pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
	if (pthread_create(thread, &attr, func, arg)) {
		perror("pthread_create failed");
	}
	pthread_attr_destroy(&attr);
}

int main(int argc, void** argv)
{
	int i,j;
	pthread_t pth[MAX_THREADS];
	void* ret;
	long long min_delta[MAX_THREADS];
	
	/* pull the thread count */
	if(argc > 1)
		thread_count = strtol(argv[1],0,0);
	if(thread_count > MAX_THREADS)
		thread_count = MAX_THREADS;

	/* spawn */
	for(i=1; i < thread_count; i++)
		create_thread(&pth[i], cpu_thread, (void*)i, 10);
	create_thread(&pth[0], controlling_thread, (void*)0, 15);

	/* wait */
	for(i=1; i< thread_count; i++)
		pthread_join(pth[i],&ret);

	/* calculate differences */
	for (i=0; i < thread_count; i++)
		min_delta[i] = -1L;
	for (j=0; j < LISTSIZE; j++) {
		for(i=0; i< thread_count; i++) {
			long long delta;
			delta = cpu_tsc_vals[i][j] - cpu_tsc_vals[0][j];
			if((unsigned long long)delta < 
					(unsigned long long)min_delta[i])
				min_delta[i] = delta;
		}
	}
	for (i=0; i < thread_count; i++)
		printf("cpu: %i  min_delta:%lld cycles\n", i, min_delta[i]);

	return 0;
}

--=-d2p7oeR/CqJ0IcMXG2vH--

