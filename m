Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWEOINu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWEOINu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 04:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWEOINu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 04:13:50 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:60042 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964797AbWEOINt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 04:13:49 -0400
Date: Mon, 15 May 2006 10:13:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: Lee Revell <rlrevell@joe-job.com>, lkml <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>, Mike Galbraith <efault@gmx.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: rt20 scheduling latency testcase and failure data
Message-ID: <20060515081341.GB24523@elte.hu>
References: <200605121924.53917.dvhltc@us.ibm.com> <200605131106.16864.dvhltc@us.ibm.com> <1147544472.6535.294.camel@mindpipe> <200605131601.31880.dvhltc@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <200605131601.31880.dvhltc@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Darren Hart <dvhltc@us.ibm.com> wrote:

> On Saturday 13 May 2006 11:21, Lee Revell wrote:
> > On Sat, 2006-05-13 at 11:06 -0700, Darren Hart wrote:
> > >      1 [softirq-timer/0]
> >
> > What happens if you set the softirq-timer threads to 99?
> >
> 
> After setting all 4 softirq-timer threads to prio 99 I seemed to get 
> only 2 failures in 100 runs. #51 slept too long (10ms too long!), the 
> latency appeared after the sleep in #90 (nearly 483ms worth).  Those 
> latencies seem huge to me.

have you tried to use the latency tracer to capture this latency? It is 
programmable to a high degree. (I've attached trace-it.c that shows how 
to use it)

(If the latency is particularly long you might want to increase 
kernel/latency.c:MAX_TRACE.)

once you have a latency trace, you can use grep to produce some 
highlevel overview of what's happening. E.g. syscall activity:

	grep ' [<>] ' latency_trace.txt

or context-switches done:

        grep ' : __schedule <' latency_trace

looking at the highlevel traces should give you a quick idea of what's 
going on, and then you can zoom into the time period that triggers the 
long latency. (but feel free to also send these traces to us, preferably 
in bzip2 -9 format.)

	Ingo

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="trace-it.c"


/*
 * Copyright (C) 2005, Ingo Molnar <mingo@redhat.com>
 *
 * user-triggered tracing.
 *
 * The -rt kernel has a built-in kernel tracer, which will trace
 * all kernel function calls (and a couple of special events as well),
 * by using a build-time gcc feature that instruments all kernel
 * functions.
 * 
 * The tracer is highly automated for a number of latency tracing purposes,
 * but it can also be switched into 'user-triggered' mode, which is a
 * half-automatic tracing mode where userspace apps start and stop the
 * tracer. This file shows a dumb example how to turn user-triggered
 * tracing on, and how to start/stop tracing. Note that if you do
 * multiple start/stop sequences, the kernel will do a maximum search
 * over their latencies, and will keep the trace of the largest latency
 * in /proc/latency_trace. The maximums are also reported to the kernel
 * log. (but can also be read from /proc/sys/kernel/preempt_max_latency)
 *
 * For the tracer to be activated, turn on CONFIG_WAKEUP_TIMING and
 * CONFIG_LATENCY_TRACE in the .config, rebuild the kernel and boot
 * into it. Note that the tracer can have significant runtime overhead,
 * so you dont want to use it for performance testing :)
 */

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/wait.h>
#include <linux/unistd.h>

int main (int argc, char **argv)
{
	int ret;

	if (getuid() != 0) {
		fprintf(stderr, "needs to run as root.\n");
		exit(1);
	}
	ret = system("cat /proc/sys/kernel/mcount_enabled >/dev/null 2>/dev/null");
	if (ret) {
		fprintf(stderr, "CONFIG_LATENCY_TRACING not enabled?\n");
		exit(1);
	}
	system("echo 0 > /proc/sys/kernel/trace_all_cpus");
	system("echo 1 > /proc/sys/kernel/trace_enabled");
	system("echo 0 > /proc/sys/kernel/trace_freerunning");
	system("echo 0 > /proc/sys/kernel/trace_print_at_crash");
	system("echo 1 > /proc/sys/kernel/trace_user_triggered");
	system("echo 0 > /proc/sys/kernel/trace_verbose");
	system("echo 0 > /proc/sys/kernel/preempt_max_latency");
	system("echo 0 > /proc/sys/kernel/preempt_thresh");
	system("[ -e /proc/sys/kernel/wakeup_timing ] && echo 1 > /proc/sys/kernel/wakeup_timing");
	system("echo 1 > /proc/sys/kernel/mcount_enabled");

	gettimeofday(0, 1); // start tracing
	usleep(100000);
	gettimeofday(0, 0); // stop tracing

	system("cat /proc/latency_trace");

	return 0;
}



--sm4nu43k4a2Rpi4c--
