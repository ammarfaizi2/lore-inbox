Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbWERJOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWERJOL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 05:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbWERJOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 05:14:11 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:38125 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750853AbWERJOK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 05:14:10 -0400
From: Darren Hart <dvhltc@us.ibm.com>
Organization: IBM Linux Technology Center
To: =?iso-8859-1?q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Subject: Re: rt20 scheduling latency testcase and failure data
Date: Thu, 18 May 2006 02:14:04 -0700
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>, Mike Galbraith <efault@gmx.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Florian Schmidt <mista.tapas@gmx.net>
References: <200605121924.53917.dvhltc@us.ibm.com> <200605151830.23544.dvhltc@us.ibm.com> <1147764175.3970.33.camel@frecb000686>
In-Reply-To: <1147764175.3970.33.camel@frecb000686>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_drDbEcetfG1nRjB"
Message-Id: <200605180214.05690.dvhltc@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_drDbEcetfG1nRjB
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 16 May 2006 00:22, S=E9bastien Dugu=E9 wrote:
> On Mon, 2006-05-15 at 18:30 -0700, Darren Hart wrote:
> > Following Ingo's example I have included the modified test case (please
> > see the original mail for librt.h) that starts the trace before each
> > sleep and disables it after we wake up.  If we have missed a period, we
> > print the trace.
>

I found several flaws in my first two iterations of the test case. =20
Particularly false negatives.  It's printing would cause large latencies=20
waiting for the tty, or even the disk if output was being redirected.  The=
=20
new version uses buffered output, and I cleaned up the periodic loop using =
a=20
MARK() system.  You can run the test like this:

=2E/sched_latency_lkml -v4

It will refrain from spewing output until after the test completes, or a=20
missed period is detected.  If a missed period is detected it will stop and=
=20
print the latency trace as well.  Note that I restart the trace at each=20
iteration by just calling gettimeofday(0,1) - I don't stop it first.  This=
=20
was because I found that stopping it with gettimeofday(0,0) could take as=20
long as 30ms!

The output looks something like this:

000000: ----- ITERATION 1 -----
000001: MARK 97: 197 us (112606039526 us) delta 0
000002: MARK 102: 214 us (16 us) delta 16
000003: MARK 110: 5024 us (4826 us) delta 4810
000004: MARK 121: 5029 us (4831 us) delta 5
000005:
000006: ----- ITERATION 2 -----
000007: MARK 97: 5957 us (5759 us) delta 928
000008: MARK 102: 5977 us (19 us) delta 19
000009: MARK 110: 10018 us (4060 us) delta 4041
000010: MARK 121: 10023 us (4065 us) delta 4

=46ormat:
MARK LINE TIME_SINCE_START TIME_SINCE_TRACE_START TIME_SINCE_LAST_MARK

TIME_SINCE_TRACE_START is handy for indexing the latency_traces if you happ=
en=20
to get one.  Without all the added i/o and calls to stop the trace, I have=
=20
yet to see a missed period with the version of the program.  While getting =
to=20
this point, I did see some things that concerned me:

sched_la-4856  3D... 4083us!: math_state_restore (device_not_available)
sched_la-4856  3D... 16033us : smp_apic_timer_interrupt (4b3b98e8 0 0)

Am I reading that right?  12ms to complete math_state_restore()?  What=20
does "device_not_available" mean here?

Here are some other similar traces:

sched_la-5008  2D... 4104us!: math_state_restore (device_not_available)
sched_la-5008  2.... 4992us > sys_clock_gettime (00000001 b7fc8378 0000007b)
=2D-
sched_la-4187  3D... 4786us : math_state_restore (device_not_available)
sched_la-4187  3D... 4786us!: init_fpu (math_state_restore)
sched_la-4187  3D... 5524us : smp_apic_timer_interrupt (4b3b98e8 0 0)
=2D-
sched_la-4729  1D... 4078us!: math_state_restore (device_not_available)
sched_la-4729  1.... 4978us > sys_clock_gettime (00000001 b7f5a348 0000007b)

I'll run the test in a loop overnight and see if I can trigger a missed=20
period.  In the meantime, can anyone explain with the math_state_restore()=
=20
might be causing so much latency?


Thanks,

=2D-=20
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
Phone: 503 578 3185
  T/L: 775 3185

--Boundary-00=_drDbEcetfG1nRjB
Content-Type: text/x-csrc;
  charset="iso-8859-15";
  name="sched_latency_lkml.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sched_latency_lkml.c"

/*    Filename: sched_latency_lkml.c
 *      Author: Darren Hart <dvhltc@us.ibm.com>
 * Description: Measure the latency involved with periodic scheduling.
 * Compilation: gcc -O2 -g -D_GNU_SOURCE -I/usr/include/nptl -L/usr/lib/nptl -lpthread -lrt -lm sched_latency_lkml.c -o sched_latency_lkml
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
 * 2006-May-10:	Initial version by Darren Hart <dvhltc@us.ibm.com>
 * 2006-May-18: Buffered output, MARK() system, fixed varioius measurement
 *              glitches, other bug fixes by Darren Hart <dvhltc@us.ibm.com>
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <pthread.h>
#include "librt.h"

#define PRIO 98
//#define PERIOD 17*NS_PER_MS
//#define ITERATIONS 100
#define ITERATIONS 10000
#define PERIOD 5*NS_PER_MS
#define PASS_US 100

#define LATENCY_TRACE 1
#ifdef LATENCY_TRACE
#define latency_trace_enable() \
system("echo 0 > /proc/sys/kernel/trace_all_cpus"); \
system("echo 1 > /proc/sys/kernel/trace_enabled"); \
system("echo 0 > /proc/sys/kernel/trace_freerunning"); \
system("echo 0 > /proc/sys/kernel/trace_print_at_crash"); \
system("echo 1 > /proc/sys/kernel/trace_user_triggered"); \
system("echo 0 > /proc/sys/kernel/trace_verbose"); \
system("echo 0 > /proc/sys/kernel/preempt_max_latency"); \
system("echo 0 > /proc/sys/kernel/preempt_thresh"); \
system("[ -e /proc/sys/kernel/wakeup_timing ] && echo 1 > /proc/sys/kernel/wakeup_timing"); \
system("echo 1 > /proc/sys/kernel/mcount_enabled"); 
#define latency_trace_start() gettimeofday(NULL,(void *)1)
#define latency_trace_stop() gettimeofday(NULL,NULL)
#define latency_trace_print() system("cat /proc/latency_trace");
#else
#define latency_trace_enable() do { } while (0)
#define latency_trace_start() do { } while (0)
#define latency_trace_stop() do { } while (0)
#define latency_trace_print() do { } while (0)
#endif

#define MARK() { \
nsec_t prev = mark; \
mark = rt_gettime(); \
debug(DBG_DEBUG,"MARK %d: %llu us (%llu us) delta %llu\n", __LINE__, (mark-start)/NS_PER_US, (mark-lt_start)/NS_PER_US, (prev) ? (mark-prev)/NS_PER_US : 0); \
if (mark > next) {\
	retval = 1; \
	latency_trace_stop(); \
	latency_trace_print(); \
	break; \
}}

static nsec_t start;    // start of the test
static nsec_t lt_start; // last time latency_trace was started
static nsec_t mark;
static int retval;

void *periodic_thread(void *arg)
{
	struct thread *t = (struct thread *)arg;
	int i;
	int delay = 0, avg_delay = 0, start_delay, min_delay = 0x7FFFFFF, max_delay = 0;
	int failures = 0;
	nsec_t next=0, sched_delta=0, delta=0, prev=0;

	mark = 0;
	lt_start = 0;
	retval = 0;

	start_delay = (rt_gettime() - start)/NS_PER_US;

	prev = start;
	next = start+PERIOD;

	for (i = 1; i <= ITERATIONS; i++) {
		debug(DBG_DEBUG,"----- ITERATION %d -----\n", i);
		// start the latency tracer before we wait for the next period
		MARK();
		lt_start = mark;
		latency_trace_start();

		// sleep until the start of the next period
		MARK();
		sched_delta = next - mark; // how long we should sleep
		rt_nanosleep(sched_delta);
		delta = rt_gettime() - mark; // how long we did sleep

		// start of period
		prev = next;
		next += PERIOD;
		MARK();
		delay = (mark - start - (nsec_t)i*PERIOD)/NS_PER_US;
		if (delay < min_delay)
			min_delay = delay;
		if (delay > max_delay)
			max_delay = delay;
		if (delay > PASS_US)
			failures++;
		avg_delay += delay;
		
		// do some real work during the period
		MARK();
		busy_work_ms(1);
		debug(DBG_DEBUG,"\n");
	}

	avg_delay /= ITERATIONS;
	printf("\n\n");
	printf("Start Latency: %4d us: %s\n", start_delay, 
		start_delay < PASS_US ? "PASS" : "FAIL");
	printf("Min Latency:   %4d us: %s\n", min_delay,
		min_delay < PASS_US ? "PASS" : "FAIL");
	printf("Avg Latency:   %4d us: %s\n", avg_delay,
		avg_delay < PASS_US ? "PASS" : "FAIL");
	printf("Max Latency:   %4d us: %s\n", max_delay,
		max_delay < PASS_US ? "PASS" : "FAIL");
	printf("Failed Iterations: %d\n\n", failures);

	return NULL;
}

void *noise_thread(void *arg)
{
	struct thread *t = (struct thread *)arg;

	while (!thread_quit(t)) {
		busy_work_us(100);
		rt_nanosleep(3*NS_PER_MS);
	}
	return NULL;
}

int main(int argc, char *argv[])
{
	int per_id, mas_id;

	rt_init(NULL, NULL, argc, argv);

	printf("-------------------------------\n");
	printf("Scheduling Latency\n");
	printf("-------------------------------\n\n");
	printf("Running %d iterations with a period of %d ms\n", ITERATIONS, PERIOD/NS_PER_MS);
	printf("Expected running time: %d s\n\n", (nsec_t)ITERATIONS*PERIOD/NS_PER_SEC);

	latency_trace_enable();

	// create some extra floating point noise threads
	create_fifo_thread(noise_thread, (void*)0, PRIO);
	create_fifo_thread(noise_thread, (void*)0, PRIO);
	create_fifo_thread(noise_thread, (void*)0, PRIO);
	create_fifo_thread(noise_thread, (void*)0, PRIO);
	create_fifo_thread(noise_thread, (void*)0, PRIO);

	start = rt_gettime();
	per_id = create_fifo_thread(periodic_thread, (void*)0, PRIO-1);

	join_thread(per_id);
	join_threads();

	if (retval)
		buffer_print();	
	
	return retval;
}

--Boundary-00=_drDbEcetfG1nRjB--
