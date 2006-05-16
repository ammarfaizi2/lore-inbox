Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbWEPBaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWEPBaf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 21:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWEPBaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 21:30:35 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:1409 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750972AbWEPBae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 21:30:34 -0400
From: Darren Hart <dvhltc@us.ibm.com>
Organization: IBM Linux Technology Center
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: rt20 scheduling latency testcase and failure data
Date: Mon, 15 May 2006 18:30:22 -0700
User-Agent: KMail/1.9.1
Cc: Lee Revell <rlrevell@joe-job.com>, lkml <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>, Mike Galbraith <efault@gmx.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Florian Schmidt <mista.tapas@gmx.net>
References: <200605121924.53917.dvhltc@us.ibm.com> <200605131601.31880.dvhltc@us.ibm.com> <20060515081341.GB24523@elte.hu>
In-Reply-To: <20060515081341.GB24523@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_vsSaEX7aHog1xZz"
Message-Id: <200605151830.23544.dvhltc@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_vsSaEX7aHog1xZz
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 15 May 2006 01:13, Ingo Molnar wrote:
>
> have you tried to use the latency tracer to capture this latency? It is
> programmable to a high degree. (I've attached trace-it.c that shows how
> to use it)
> ...
> looking at the highlevel traces should give you a quick idea of what's
> going on, and then you can zoom into the time period that triggers the
> long latency. (but feel free to also send these traces to us, preferably
> in bzip2 -9 format.)

Following Ingo's example I have included the modified test case (please see 
the original mail for librt.h) that starts the trace before each sleep and 
disables it after we wake up.  If we have missed a period, we print the 
trace.

My initial trace (lt_01.log.bz2) contained entries like the following:

  <idle>-0     2...1   24us!: default_idle (cpu_idle)
  <idle>-0     2D..1 1609us : smp_apic_timer_interrupt (c0100c80 0 0)

  <idle>-0     2...1 1635us!: default_idle (cpu_idle)
  <idle>-0     2D..1 4756us : smp_apic_timer_interrupt (c0100c80 0 0)

I noticed the that there were long latencies (as high as 3ms) all related to 
irq handling in the idle loop.  I thought it might have something to do with 
the CPU going into some kind of a sleep state and taking a long time to wake 
up.  John Stultz suggested I boot with idle=poll.

The idle=poll trace (lt_02.log.bz2) had much smaller maximum latencies, like 
the following:

  <idle>-0     0D..1 1341us+: write_watchdog_counter (nmi_watchdog_tick)
  <idle>-0     0D..1 1441us : do_nmi (poll_idle)

  <idle>-0     0D..1 1445us+: write_watchdog_counter (nmi_watchdog_tick)
  <idle>-0     0D..1 1545us : do_nmi (poll_idle)

All the longest latencies were related to the nmi watchdogs.  Booting with 
idle=poll nmi_watchdog=0 unfortunately seemed to return to the original 
behavior - so perhaps the second test was just a fluke.  This trace 
(lt_03.log.bz2) had entries like the following:

  <idle>-0     1...1   19us!: poll_idle (cpu_idle)
  <idle>-0     1D..1 1089us : smp_apic_timer_interrupt (c0100ccf 0 0)

  <idle>-0     1...1 1113us!: poll_idle (cpu_idle)
  <idle>-0     1D..1 4765us : smp_apic_timer_interrupt (c0100ccf 0 0)

sched_la-2978  1D... 4798us!: init_fpu (math_state_restore)
sched_la-2978  1D... 5088us : smp_apic_timer_interrupt (4b3b98e8 0 0)

sched_la-2978  1D.h. 5103us!: irq_exit (smp_apic_timer_interrupt)
sched_la-2978  1.... 5719us > sys_clock_gettime (00000001 b7f65378 0000007b)

Finally I booted with idle=poll and nmi_watchdog=0.  The very first run 
failed, (I've noticed that the first iteration seems to always hit PERIOD 
MISSED! while the second usually passes fine).  It's still running a 1M 
iteration run with no more failures so far (100K so far).

The latency tracer is a very interesting tool.  I have a few 
questions/assumptions I'd like to run by you to make sure I understand the 
output of the latency trace:

o ! in the delay column means there is a long latency here?
o + in the delay column means there is a > 1us latency here?
o > means entering the kernel from a sys_call?
o < means returning from the sys_call?
o : is not < or >
o Why do I only see ~5ms of trace when it appears that I am seeing more like
  ~25ms between the time when I start and stop the trace?
o What are the maximum latencies that get printed to /var/log/messages?  What
  exacly do they measure? From what point to what point?
-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team


--Boundary-00=_vsSaEX7aHog1xZz
Content-Type: application/x-bzip2;
  name="lt_01.log.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="lt_01.log.bz2"

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
nro6oFRI1b/xdyRThQkHERh4QA==

--Boundary-00=_vsSaEX7aHog1xZz
Content-Type: application/x-bzip2;
  name="lt_02.log.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="lt_02.log.bz2"

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
uSKcKEgFni18gA==

--Boundary-00=_vsSaEX7aHog1xZz
Content-Type: application/x-bzip2;
  name="lt_03.log.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="lt_03.log.bz2"

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
ckU4UJA6Ho80

--Boundary-00=_vsSaEX7aHog1xZz
Content-Type: text/x-csrc;
  charset="iso-8859-15";
  name="sched_latency_lkml.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sched_latency_lkml.c"

/*    Filename: sched_latency_lkml.c
 *      Author: Darren Hart <dvhltc@us.ibm.com>
 * Description: Measure the latency involved with periodic scheduling.
 * Compilation: gcc -O2 -g -D_GNU_SOURCE -I/usr/include/nptl -I -L/usr/lib/nptl -lpthread -lrt -lm sched_latency_lkml.c -o sched_latency_lkml
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
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
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
#define latency_trace_start() gettimeofday(0,1)
#define latency_trace_stop() gettimeofday(0,0)
#define latency_trace_print() system("cat /proc/latency_trace");
#else
#define latency_trace_enable() do { } while (0)
#define latency_trace_start() do { } while (0)
#define latency_trace_stop() do { } while (0)
#define latency_trace_print() do { } while (0)
#endif

nsec_t start;
int retval;

void *periodic_thread(void *arg)
{
	struct thread *t = (struct thread *)arg;
	int i;
	int delay, avg_delay = 0, start_delay, min_delay = 0x7FFFFFF, max_delay = 0;
	int failures = 0;
	nsec_t next=0, now=0, sched_delta=0, delta=0, prev=0;

	retval = 0;

	prev = start;
	next = start;
	now = rt_gettime();
	start_delay = (now - start)/NS_PER_US;

	printf("ITERATION DELAY(US) MAX_DELAY(US) FAILURES\n");
	printf("--------- --------- ------------- --------\n");
	for (i = 1; i <= ITERATIONS; i++) {
		/* wait for the period to start */
		next += PERIOD;
		prev = now;
		now = rt_gettime();

		if (i > 1) latency_trace_stop();

		if (next < now) {
			printf("\n\nPERIOD MISSED!\n");
			printf("     scheduled delta: %8llu us\n", sched_delta/1000);
			printf("        actual delta: %8llu us\n", delta/1000);
			printf("             latency: %8llu us\n", (delta-sched_delta)/1000);
			printf("---------------------------------------\n");
			printf("      previous start: %8llu us\n", (prev-start)/1000);
			printf("                 now: %8llu us\n", (now-start)/1000);
			printf("     scheduled start: %8llu us\n", (next-start)/1000);
			printf("next scheduled start is in the past!\n");
			retval = 1;
			latency_trace_print();
			break;
		}

		latency_trace_start();
		sched_delta = next - now; /* how long we should sleep */
		delta = 0;
		do {
			rt_nanosleep(next - now);
			delta += rt_gettime() - now; /* how long we did sleep */
			now = rt_gettime();
		} while (now < next);

		/* start of period */
		now = rt_gettime();
		delay = (now - start - (nsec_t)i*PERIOD)/NS_PER_US;
		if (delay < min_delay)
			min_delay = delay;
		if (delay > max_delay)
			max_delay = delay;
		if (delay > PASS_US)
			failures++;
		avg_delay += delay;
		

		/* continuous status ticker */
		//printf("%9i %9i %13i %8i\r", i, delay, max_delay, failures);
		//fflush(stdout);
		
		busy_work_ms(1);
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

int main(int argc, char *argv[])
{
	int per_id, mas_id;

	printf("-------------------------------\n");
	printf("Scheduling Latency\n");
	printf("-------------------------------\n\n");
	printf("Running %d iterations with a period of %d ms\n", ITERATIONS, PERIOD/NS_PER_MS);
	printf("Expected running time: %d s\n\n", (nsec_t)ITERATIONS*PERIOD/NS_PER_SEC);

	latency_trace_enable();

	start = rt_gettime();
	per_id = create_fifo_thread(periodic_thread, (void*)0, PRIO);

	join_thread(per_id);
	join_threads();

	return retval;
}

--Boundary-00=_vsSaEX7aHog1xZz--
