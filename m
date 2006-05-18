Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWERIxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWERIxr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 04:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWERIxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 04:53:47 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:27041 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751224AbWERIxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 04:53:46 -0400
Subject: Re: rt20 scheduling latency testcase and failure data
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Darren Hart <dvhltc@us.ibm.com>, Lee Revell <rlrevell@joe-job.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>, Mike Galbraith <efault@gmx.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <20060518084722.GA3343@elte.hu>
References: <200605121924.53917.dvhltc@us.ibm.com>
	 <200605131601.31880.dvhltc@us.ibm.com> <20060515081341.GB24523@elte.hu>
	 <200605151830.23544.dvhltc@us.ibm.com>
	 <1147941862.4996.15.camel@frecb000686>  <20060518084722.GA3343@elte.hu>
Date: Thu, 18 May 2006 10:58:07 +0200
Message-Id: <1147942687.4996.28.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 18/05/2006 10:56:51,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 18/05/2006 10:56:54,
	Serialize complete at 18/05/2006 10:56:54
Content-Type: multipart/mixed; boundary="=-TmIo6rSAB5cKTO5CfkUa"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TmIo6rSAB5cKTO5CfkUa
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-15

On Thu, 2006-05-18 at 10:47 +0200, Ingo Molnar wrote:
> * S=E9bastien Dugu=E9 <sebastien.dugue@bull.net> wrote:
>=20
> >   Darren,
> >=20
> > On Mon, 2006-05-15 at 18:30 -0700, Darren Hart wrote:
> > > Following Ingo's example I have included the modified test case (plea=
se see=20
> > > the original mail for librt.h) that starts the trace before each slee=
p and=20
> > > disables it after we wake up.  If we have missed a period, we print t=
he=20
> > > trace.
> > >=20
> >=20
> >   Your test program fails (at least on my box) as the overhead of=20
> > starting and stopping the trace in the 5 ms period is just too high.
> >=20
> >   By moving the latency_trace_start() at the start of the thread=20
> > function and latency_trace_stop() at the end, everything runs fine. I=20
> > did not have any period missed even under heavy load.
>=20
> could you send us the fixed testcase?

  No problem, see attachment.

>=20
> thanks for tracking this down. FYI, the latency of stopping the trace is=20
> that expensive because we are copying large amounts of trace data=20
> around, to ensure that /proc/latency_trace is always consistent and is=20
> updated atomically, and to make sure that we can update the trace from=20
> interrupt contexts too - without /proc/latency_trace accesses blocking=20
> them. The latency of stopping the trace is hidden from the tracer itself=20
> - but it cannot prevent indirect effects such as your app from missing=20
> periods, if the periods are in the 5msec range.
>=20

  Thanks for the explanation, will have to look deeper into the code
to understand how it works though.

  S=E9bastien.


--=-TmIo6rSAB5cKTO5CfkUa
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=sched_latency_lkml2.c
Content-Type: text/x-csrc; name=sched_latency_lkml2.c; charset=ISO-8859-15

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
	latency_trace_start();

	prev = start;
	next = start;
	now = rt_gettime();
	start_delay = (now - start)/NS_PER_US;

	//printf("ITERATION DELAY(US) MAX_DELAY(US) FAILURES\n");
	//printf("--------- --------- ------------- --------\n");
	for (i = 1; i <= ITERATIONS; i++) {
		/* wait for the period to start */
		next += PERIOD;
		prev = now;
		now = rt_gettime();

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

	latency_trace_stop();

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

--=-TmIo6rSAB5cKTO5CfkUa--

