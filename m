Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270389AbUJVIVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270389AbUJVIVo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 04:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270089AbUJVIVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 04:21:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:30593 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269746AbUJSQfS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:35:18 -0400
X-Authenticated: #4399952
Date: Tue, 19 Oct 2004 18:50:16 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: "Rui Nuno Capela" <rncbc@rncbc.org>
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Lee Revell" <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, "Bill Huey" <bhuey@lnxw.com>,
       "Adam Heath" <doogie@debian.org>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U6
Message-ID: <20041019185016.2af4fa86@mango.fruits.de>
In-Reply-To: <28172.195.245.190.93.1098199429.squirrel@195.245.190.93>
References: <20041012123318.GA2102@elte.hu>
	<20041012195424.GA3961@elte.hu>
	<20041013061518.GA1083@elte.hu>
	<20041014002433.GA19399@elte.hu>
	<20041014143131.GA20258@elte.hu>
	<20041014234202.GA26207@elte.hu>
	<20041015102633.GA20132@elte.hu>
	<20041016153344.GA16766@elte.hu>
	<20041018145008.GA25707@elte.hu>
	<20041019124605.GA28896@elte.hu>
	<20041019144642.GA6512@elte.hu>
	<28172.195.245.190.93.1098199429.squirrel@195.245.190.93>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2004 16:23:49 +0100 (WEST)
"Rui Nuno Capela" <rncbc@rncbc.org> wrote:

> I'm experiencing terrible kernel panics at a very early bootstrap stage
> while testing the U5 and U6 latest patch(es) on my laptop (P4/UP) --
> (Ingo: this is about the very same trouble I've reported while pre-testing
> U6).

[..]

> OK. After some incremental configurations, I've isolated that those
> oops(es) only occurs if PREEMPT_TIMING and/or LATENCY_TRACE areset (Y). My
> first suspect was that newest RWSEM_DEADLOCK_DETECT, but it wasn't the
> case.
> 
> So something has broken on that non-preemptible critical section timing
> stuff since U4.
> 
> Hasn't anybody else stumbled on this?

I don't get any oopses or panics, but i can observer a rather interesting
behaviour. When i enable the latency traces via

echo 1 > /proc/sys/kernel/trace_enabled

my machine starts to make little pauses of ca 3-4 secs. X "hangs" for this
duration and so does aplay when playing a .wav file. "hangs" means that the
X display seems to be locked. Interestingly enough all keystrokes i entered
during the "hang" seem to arrive fine after the hang has ended. aplay
experiences an xrun.

jackd OTOH is not affected (probably since it runs SCHED_FIFO). I can
happily continue noodling with my guitar through jackd and jack-rack..

But besides that it runs fine here. I get some fairly long non preemptible
critical sections reports though.

here's one (i snipped off quite a few in the middle to make the email
smaller):

preemption latency trace v1.0.7 on 2.6.9-rc4-mm1-RT-U6
-------------------------------------------------------
 latency: 1841 us, entries: 4000 (12990)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:1]
    -----------------
    | task: aplay/2160, uid:1000 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: __schedule+0x3b/0x5d0 <c02a767b>
 => ended at:   finish_task_switch+0x43/0xb0 <c0114ae3>
=======>
00000001 0.000ms (+0.000ms): __schedule (ksoftirqd)
00000001 0.000ms (+0.000ms): sched_clock (__schedule)
00000002 0.000ms (+0.000ms): deactivate_task (__schedule)
00000002 0.000ms (+0.000ms): dequeue_task (deactivate_task)
04000002 0.000ms (+0.000ms): __switch_to (__schedule)
04000002 0.001ms (+0.000ms): finish_task_switch (__schedule)
04000000 0.001ms (+0.000ms): schedule (down_write)
04000000 0.001ms (+0.000ms): __schedule (down_write)
04000001 0.001ms (+0.000ms): sched_clock (__schedule)
04000000 0.001ms (+0.000ms): schedule (down_write)
04000000 0.001ms (+0.000ms): __schedule (down_write)
04000001 0.002ms (+0.000ms): sched_clock (__schedule)
04000000 0.002ms (+0.000ms): schedule (down_write)
04000000 0.002ms (+0.000ms): __schedule (down_write)
04000001 0.002ms (+0.000ms): sched_clock (__schedule)
04000000 0.002ms (+0.000ms): schedule (down_write)
04000000 0.002ms (+0.000ms): __schedule (down_write)
04000001 0.003ms (+0.000ms): sched_clock (__schedule)
04000000 0.003ms (+0.000ms): schedule (down_write)
04000000 0.003ms (+0.000ms): __schedule (down_write)
04000001 0.003ms (+0.000ms): sched_clock (__schedule)
04000000 0.003ms (+0.000ms): schedule (down_write)
04000000 0.003ms (+0.000ms): __schedule (down_write)
04000001 0.003ms (+0.000ms): sched_clock (__schedule)
04000000 0.004ms (+0.000ms): schedule (down_write)
04000000 0.004ms (+0.000ms): __schedule (down_write)
04000001 0.004ms (+0.000ms): sched_clock (__schedule)
04000000 0.004ms (+0.000ms): schedule (down_write)
04000000 0.004ms (+0.000ms): __schedule (down_write)
04000001 0.004ms (+0.000ms): sched_clock (__schedule)
04000000 0.005ms (+0.000ms): schedule (down_write)
04000000 0.005ms (+0.000ms): __schedule (down_write)
04000001 0.005ms (+0.000ms): sched_clock (__schedule)
04000000 0.005ms (+0.000ms): schedule (down_write)
04000000 0.005ms (+0.000ms): __schedule (down_write)
04000001 0.005ms (+0.000ms): sched_clock (__schedule)
04000000 0.006ms (+0.000ms): schedule (down_write)
04000000 0.006ms (+0.000ms): __schedule (down_write)
04000001 0.006ms (+0.000ms): sched_clock (__schedule)
04000000 0.006ms (+0.000ms): schedule (down_write)
04000000 0.006ms (+0.000ms): __schedule (down_write)
04000001 0.006ms (+0.000ms): sched_clock (__schedule)
04000000 0.006ms (+0.000ms): schedule (down_write)
04000000 0.007ms (+0.000ms): __schedule (down_write)
04000001 0.007ms (+0.000ms): sched_clock (__schedule)
04000000 0.007ms (+0.000ms): schedule (down_write)
04000000 0.007ms (+0.000ms): __schedule (down_write)
04000001 0.007ms (+0.000ms): sched_clock (__schedule)
04000000 0.007ms (+0.000ms): schedule (down_write)
04000000 0.007ms (+0.000ms): __schedule (down_write)
04000001 0.008ms (+0.000ms): sched_clock (__schedule)
04000000 0.008ms (+0.000ms): schedule (down_write)
04000000 0.008ms (+0.000ms): __schedule (down_write)
04000001 0.008ms (+0.000ms): sched_clock (__schedule)
04000000 0.008ms (+0.000ms): schedule (down_write)
04000000 0.008ms (+0.000ms): __schedule (down_write)
04000001 0.009ms (+0.000ms): sched_clock (__schedule)
04000000 0.009ms (+0.000ms): schedule (down_write)
04000000 0.009ms (+0.000ms): __schedule (down_write)
04000001 0.009ms (+0.000ms): sched_clock (__schedule)
04000000 0.009ms (+0.000ms): schedule (down_write)
04000000 0.009ms (+0.000ms): __schedule (down_write)
04000001 0.009ms (+0.000ms): sched_clock (__schedule)
04000000 0.010ms (+0.000ms): schedule (down_write)
04000000 0.010ms (+0.000ms): __schedule (down_write)
04000001 0.010ms (+0.000ms): sched_clock (__schedule)
04000000 0.010ms (+0.000ms): schedule (down_write)
04000000 0.010ms (+0.000ms): __schedule (down_write)
04000001 0.010ms (+0.000ms): sched_clock (__schedule)
04000000 0.011ms (+0.000ms): schedule (down_write)
04000000 0.011ms (+0.000ms): __schedule (down_write)
04000001 0.011ms (+0.000ms): sched_clock (__schedule)
04000000 0.011ms (+0.000ms): schedule (down_write)
04000000 0.011ms (+0.000ms): __schedule (down_write)
04000001 0.011ms (+0.000ms): sched_clock (__schedule)
04000000 0.012ms (+0.000ms): schedule (down_write)
04000000 0.012ms (+0.000ms): __schedule (down_write)
04000001 0.012ms (+0.000ms): sched_clock (__schedule)
04000000 0.012ms (+0.000ms): schedule (down_write)
04000000 0.012ms (+0.000ms): __schedule (down_write)
04000001 0.012ms (+0.000ms): sched_clock (__schedule)
04000000 0.012ms (+0.000ms): schedule (down_write)
04000000 0.013ms (+0.000ms): __schedule (down_write)
04000001 0.013ms (+0.000ms): sched_clock (__schedule)
04000000 0.013ms (+0.000ms): schedule (down_write)
04000000 0.013ms (+0.000ms): __schedule (down_write)
04000001 0.013ms (+0.000ms): sched_clock (__schedule)
04000000 0.013ms (+0.000ms): schedule (down_write)
04000000 0.013ms (+0.000ms): __schedule (down_write)
04000001 0.014ms (+0.000ms): sched_clock (__schedule)
04000000 0.014ms (+0.000ms): schedule (down_write)
04000000 0.014ms (+0.000ms): __schedule (down_write)
04000001 0.014ms (+0.000ms): sched_clock (__schedule)
04000000 0.014ms (+0.000ms): schedule (down_write)
04000000 0.014ms (+0.000ms): __schedule (down_write)
04000001 0.014ms (+0.000ms): sched_clock (__schedule)
04000000 0.015ms (+0.000ms): schedule (down_write)
04000000 0.015ms (+0.000ms): __schedule (down_write)
04000001 0.015ms (+0.000ms): sched_clock (__schedule)
04000000 0.015ms (+0.000ms): schedule (down_write)
04000000 0.015ms (+0.000ms): __schedule (down_write)
04000001 0.015ms (+0.000ms): sched_clock (__schedule)
04000000 0.016ms (+0.000ms): schedule (down_write)
04000000 0.016ms (+0.000ms): __schedule (down_write)
04000001 0.016ms (+0.000ms): sched_clock (__schedule)
04000000 0.016ms (+0.000ms): schedule (down_write)
04000000 0.016ms (+0.000ms): __schedule (down_write)
04000001 0.016ms (+0.000ms): sched_clock (__schedule)
04000000 0.017ms (+0.000ms): schedule (down_write)
04000000 0.017ms (+0.000ms): __schedule (down_write)
04000001 0.017ms (+0.000ms): sched_clock (__schedule)
04000000 0.017ms (+0.000ms): schedule (down_write)
04000000 0.017ms (+0.000ms): __schedule (down_write)
04000001 0.017ms (+0.000ms): sched_clock (__schedule)
04000000 0.018ms (+0.000ms): schedule (down_write)
04000000 0.018ms (+0.000ms): __schedule (down_write)
04000001 0.018ms (+0.000ms): sched_clock (__schedule)
04000000 0.018ms (+0.000ms): schedule (down_write)
04000000 0.018ms (+0.000ms): __schedule (down_write)
04000001 0.018ms (+0.000ms): sched_clock (__schedule)
04000000 0.018ms (+0.000ms): schedule (down_write)
04000000 0.019ms (+0.000ms): __schedule (down_write)
04000001 0.019ms (+0.000ms): sched_clock (__schedule)
04000000 0.019ms (+0.000ms): schedule (down_write)
04000000 0.019ms (+0.000ms): __schedule (down_write)
04000001 0.019ms (+0.000ms): sched_clock (__schedule)
04000000 0.019ms (+0.000ms): schedule (down_write)
04000000 0.019ms (+0.000ms): __schedule (down_write)
04000001 0.020ms (+0.000ms): sched_clock (__schedule)
04000000 0.020ms (+0.000ms): schedule (down_write)
04000000 0.020ms (+0.000ms): __schedule (down_write)
04000001 0.020ms (+0.000ms): sched_clock (__schedule)
04000000 0.020ms (+0.000ms): schedule (down_write)
04000000 0.020ms (+0.000ms): __schedule (down_write)
04000001 0.020ms (+0.000ms): sched_clock (__schedule)
04000000 0.021ms (+0.000ms): schedule (down_write)
04000000 0.021ms (+0.000ms): __schedule (down_write)
04000001 0.021ms (+0.000ms): sched_clock (__schedule)
04000000 0.021ms (+0.000ms): schedule (down_write)
04000000 0.021ms (+0.000ms): __schedule (down_write)
04000001 0.021ms (+0.000ms): sched_clock (__schedule)
04000000 0.022ms (+0.000ms): schedule (down_write)
04000000 0.022ms (+0.000ms): __schedule (down_write)
04000001 0.022ms (+0.000ms): sched_clock (__schedule)
04000000 0.022ms (+0.000ms): schedule (down_write)
04000000 0.022ms (+0.000ms): __schedule (down_write)
04000001 0.022ms (+0.000ms): sched_clock (__schedule)
04000000 0.023ms (+0.000ms): schedule (down_write)
04000000 0.023ms (+0.000ms): __schedule (down_write)
04000001 0.023ms (+0.000ms): sched_clock (__schedule)
04000000 0.023ms (+0.000ms): schedule (down_write)
04000000 0.023ms (+0.000ms): __schedule (down_write)
04000001 0.023ms (+0.000ms): sched_clock (__schedule)
04000000 0.023ms (+0.000ms): schedule (down_write)
04000000 0.024ms (+0.000ms): __schedule (down_write)
04000001 0.024ms (+0.000ms): sched_clock (__schedule)
04000000 0.024ms (+0.000ms): schedule (down_write)
04000000 0.024ms (+0.000ms): __schedule (down_write)
04000001 0.024ms (+0.000ms): sched_clock (__schedule)
04000000 0.024ms (+0.000ms): schedule (down_write)
04000000 0.025ms (+0.000ms): __schedule (down_write)
04000001 0.025ms (+0.000ms): sched_clock (__schedule)
04000000 0.025ms (+0.000ms): schedule (down_write)
04000000 0.025ms (+0.000ms): __schedule (down_write)
04000001 0.025ms (+0.000ms): sched_clock (__schedule)
04000000 0.025ms (+0.000ms): schedule (down_write)
04000000 0.025ms (+0.000ms): __schedule (down_write)
04000001 0.026ms (+0.000ms): sched_clock (__schedule)
04000000 0.026ms (+0.000ms): schedule (down_write)
04000000 0.026ms (+0.000ms): __schedule (down_write)
04000001 0.026ms (+0.000ms): sched_clock (__schedule)
04000000 0.026ms (+0.000ms): schedule (down_write)
04000000 0.026ms (+0.000ms): __schedule (down_write)
04000001 0.026ms (+0.000ms): sched_clock (__schedule)
04000000 0.027ms (+0.000ms): schedule (down_write)
04000000 0.027ms (+0.000ms): __schedule (down_write)
04000001 0.027ms (+0.000ms): sched_clock (__schedule)
04000000 0.027ms (+0.000ms): schedule (down_write)
04000000 0.027ms (+0.000ms): __schedule (down_write)
04000001 0.027ms (+0.000ms): sched_clock (__schedule)
04000000 0.028ms (+0.000ms): schedule (down_write)
04000000 0.028ms (+0.000ms): __schedule (down_write)
04000001 0.028ms (+0.000ms): sched_clock (__schedule)
04000000 0.028ms (+0.000ms): schedule (down_write)
04000000 0.028ms (+0.000ms): __schedule (down_write)
04000001 0.028ms (+0.000ms): sched_clock (__schedule)
04000000 0.029ms (+0.000ms): schedule (down_write)
04000000 0.029ms (+0.000ms): __schedule (down_write)
04000001 0.029ms (+0.000ms): sched_clock (__schedule)
04000000 0.029ms (+0.000ms): schedule (down_write)
04000000 0.029ms (+0.000ms): __schedule (down_write)
04000001 0.029ms (+0.000ms): sched_clock (__schedule)
04000000 0.029ms (+0.000ms): schedule (down_write)
04000000 0.030ms (+0.000ms): __schedule (down_write)
04000001 0.030ms (+0.000ms): sched_clock (__schedule)
04000000 0.030ms (+0.000ms): schedule (down_write)
04000000 0.030ms (+0.000ms): __schedule (down_write)
04000001 0.030ms (+0.000ms): sched_clock (__schedule)
04000000 0.030ms (+0.000ms): schedule (down_write)
04000000 0.030ms (+0.000ms): __schedule (down_write)
04000001 0.031ms (+0.000ms): sched_clock (__schedule)
04000000 0.031ms (+0.000ms): schedule (down_write)
04000000 0.031ms (+0.000ms): __schedule (down_write)
04000001 0.031ms (+0.000ms): sched_clock (__schedule)
04000000 0.031ms (+0.000ms): schedule (down_write)
04000000 0.031ms (+0.000ms): __schedule (down_write)
04000001 0.031ms (+0.000ms): sched_clock (__schedule)
04000000 0.032ms (+0.000ms): schedule (down_write)
04000000 0.032ms (+0.000ms): __schedule (down_write)
04000001 0.032ms (+0.000ms): sched_clock (__schedule)
04000000 0.032ms (+0.000ms): schedule (down_write)
04000000 0.032ms (+0.000ms): __schedule (down_write)
04000001 0.032ms (+0.000ms): sched_clock (__schedule)
04000000 0.033ms (+0.000ms): schedule (down_write)
04000000 0.033ms (+0.000ms): __schedule (down_write)
04000001 0.033ms (+0.000ms): sched_clock (__schedule)
04000000 0.033ms (+0.000ms): schedule (down_write)
04000000 0.033ms (+0.000ms): __schedule (down_write)
04000001 0.033ms (+0.000ms): sched_clock (__schedule)
04000000 0.034ms (+0.000ms): schedule (down_write)
04000000 0.034ms (+0.000ms): __schedule (down_write)
04000001 0.034ms (+0.000ms): sched_clock (__schedule)
04000000 0.034ms (+0.000ms): schedule (down_write)
04000000 0.034ms (+0.000ms): __schedule (down_write)
04000001 0.034ms (+0.000ms): sched_clock (__schedule)
04000000 0.035ms (+0.000ms): schedule (down_write)
04000000 0.035ms (+0.000ms): __schedule (down_write)
04000001 0.035ms (+0.000ms): sched_clock (__schedule)
04000000 0.035ms (+0.000ms): schedule (down_write)
04000000 0.035ms (+0.000ms): __schedule (down_write)
04000001 0.035ms (+0.000ms): sched_clock (__schedule)
04000000 0.035ms (+0.000ms): schedule (down_write)
04000000 0.036ms (+0.000ms): __schedule (down_write)

[...many many more of similar ones...]

04000000 0.554ms (+0.000ms): __schedule (down_write)
04000001 0.554ms (+0.000ms): sched_clock (__schedule)
04000000 0.554ms (+0.000ms): schedule (down_write)
04000000 0.554ms (+0.000ms): __schedule (down_write)
04000001 0.554ms (+0.000ms): sched_clock (__schedule)
04000000 0.555ms (+0.000ms): schedule (down_write)
04000000 0.555ms (+0.000ms): __schedule (down_write)
04000001 0.555ms (+0.000ms): sched_clock (__schedule)
04000000 0.555ms (+0.000ms): schedule (down_write)
04000000 0.555ms (+0.000ms): __schedule (down_write)
04000001 0.555ms (+0.000ms): sched_clock (__schedule)
04000000 0.555ms (+0.000ms): schedule (down_write)
04000000 0.556ms (+0.000ms): __schedule (down_write)
04000001 0.556ms (+0.000ms): sched_clock (__schedule)
04000000 0.556ms (+0.000ms): schedule (down_write)
04000000 0.556ms (+0.000ms): __schedule (down_write)
04000001 0.556ms (+0.000ms): sched_clock (__schedule)
04000000 0.556ms (+0.000ms): schedule (down_write)
04000000 0.556ms (+0.000ms): __schedule (down_write)
04000001 0.557ms (+0.000ms): sched_clock (__schedule)
04000000 0.557ms (+0.000ms): schedule (down_write)
04000000 0.557ms (+0.000ms): __schedule (down_write)
04000001 0.557ms (+0.000ms): sched_clock (__schedule)
04000000 0.557ms (+0.000ms): schedule (down_write)
04000000 0.557ms (+0.000ms): __schedule (down_write)
04000001 0.557ms (+0.000ms): sched_clock (__schedule)
04000000 0.558ms (+0.000ms): schedule (down_write)
04000000 0.558ms (+0.000ms): __schedule (down_write)
04000001 0.558ms (+0.000ms): sched_clock (__schedule)
04000000 0.558ms (+0.000ms): schedule (down_write)
04000000 0.558ms (+0.000ms): __schedule (down_write)
04000001 0.558ms (+0.000ms): sched_clock (__schedule)
04000000 0.559ms (+0.000ms): schedule (down_write)
04000000 0.559ms (+0.000ms): __schedule (down_write)
04000001 0.559ms (+0.000ms): sched_clock (__schedule)
04000000 0.559ms (+0.000ms): schedule (down_write)
04000000 0.559ms (+0.000ms): __schedule (down_write)
04000001 0.559ms (+0.000ms): sched_clock (__schedule)
04000000 0.560ms (+0.000ms): schedule (down_write)
04000000 0.560ms (+0.000ms): __schedule (down_write)
04000001 0.560ms (+0.000ms): sched_clock (__schedule)
04000000 0.560ms (+0.000ms): schedule (down_write)
04000000 0.560ms (+0.000ms): __schedule (down_write)
04000001 0.560ms (+0.000ms): sched_clock (__schedule)
04000000 0.561ms (+0.000ms): schedule (down_write)
04000000 0.561ms (+0.000ms): __schedule (down_write)
04000001 0.561ms (+0.000ms): sched_clock (__schedule)
04000000 0.561ms (+0.000ms): schedule (down_write)
04000000 0.561ms (+0.000ms): __schedule (down_write)
04000001 0.561ms (+0.000ms): sched_clock (__schedule)
04000000 0.561ms (+0.000ms): schedule (down_write)
04000000 0.562ms (+0.000ms): __schedule (down_write)
04000001 0.562ms (+0.000ms): sched_clock (__schedule)
04000000 0.562ms (+0.000ms): schedule (down_write)
04000000 0.562ms (+0.000ms): __schedule (down_write)
04000001 0.562ms (+0.000ms): sched_clock (__schedule)
04000000 0.562ms (+0.000ms): schedule (down_write)
04000000 0.562ms (+0.000ms): __schedule (down_write)
04000001 0.563ms (+0.000ms): sched_clock (__schedule)
04000000 0.563ms (+0.000ms): schedule (down_write)
04000000 0.563ms (+0.000ms): __schedule (down_write)
04000001 0.563ms (+0.000ms): sched_clock (__schedule)
04000000 0.563ms (+0.000ms): schedule (down_write)
04000000 0.563ms (+0.000ms): __schedule (down_write)
04000001 0.563ms (+0.000ms): sched_clock (__schedule)
04000000 0.564ms (+0.000ms): schedule (down_write)
04000000 0.564ms (+0.000ms): __schedule (down_write)
04000001 0.564ms (+0.000ms): sched_clock (__schedule)
04000000 0.564ms (+0.000ms): schedule (down_write)
04000000 0.564ms (+0.000ms): __schedule (down_write)
04000001 0.564ms (+0.000ms): sched_clock (__schedule)
04000000 0.565ms (+0.000ms): schedule (down_write)
04000000 0.565ms (+0.000ms): __schedule (down_write)
04000001 0.565ms (+0.000ms): sched_clock (__schedule)
04000000 0.565ms (+0.000ms): schedule (down_write)
04000000 0.565ms (+0.000ms): __schedule (down_write)
04000001 0.565ms (+0.000ms): sched_clock (__schedule)
04000000 0.566ms (+0.000ms): schedule (down_write)
04000000 0.566ms (+0.000ms): __schedule (down_write)
04000001 0.566ms (+0.000ms): sched_clock (__schedule)
04000000 0.566ms (+0.000ms): schedule (down_write)
04000000 0.566ms (+0.000ms): __schedule (down_write)
04000001 0.566ms (+0.000ms): sched_clock (__schedule)
04000000 0.567ms (+0.000ms): schedule (down_write)
04000000 0.567ms (+0.000ms): __schedule (down_write)
04000001 0.567ms (+0.000ms): sched_clock (__schedule)
04000000 0.567ms (+0.000ms): schedule (down_write)
04000000 0.567ms (+0.000ms): __schedule (down_write)
04000001 0.567ms (+0.000ms): sched_clock (__schedule)
04000000 0.567ms (+0.000ms): schedule (down_write)
04000000 0.568ms (+0.000ms): __schedule (down_write)
04000001 0.568ms (+0.000ms): sched_clock (__schedule)
04000000 0.568ms (+0.000ms): schedule (down_write)
04000000 0.568ms (+0.000ms): __schedule (down_write)
04000001 0.568ms (+0.000ms): sched_clock (__schedule)
04000000 0.568ms (+0.000ms): schedule (down_write)
04000000 0.568ms (+0.000ms): __schedule (down_write)
04000001 0.569ms (+0.000ms): sched_clock (__schedule)
04000000 0.569ms (+0.000ms): schedule (down_write)
04000000 0.569ms (+0.000ms): __schedule (down_write)
04000001 0.569ms (+0.000ms): sched_clock (__schedule)
04000000 0.569ms (+0.000ms): schedule (down_write)
04000000 0.569ms (+0.000ms): __schedule (down_write)
04000001 0.569ms (+0.000ms): sched_clock (__schedule)
04000000 0.570ms (+0.000ms): schedule (down_write)
04000000 0.570ms (+0.000ms): __schedule (down_write)
04000001 0.570ms (+0.000ms): sched_clock (__schedule)
04000000 0.570ms (+0.000ms): schedule (down_write)
04000000 0.570ms (+0.000ms): __schedule (down_write)
04000001 0.570ms (+0.000ms): sched_clock (__schedule)
04000000 0.571ms (+0.000ms): schedule (down_write)
04000000 0.571ms (+0.000ms): __schedule (down_write)
04000001 0.571ms (+0.000ms): sched_clock (__schedule)
04000000 0.571ms (+0.000ms): schedule (down_write)
04000000 0.571ms (+0.000ms): __schedule (down_write)
04000001 0.571ms (+0.000ms): sched_clock (__schedule)
04000000 0.572ms (+0.000ms): schedule (down_write)
04000000 0.572ms (+0.000ms): __schedule (down_write)
04000001 0.572ms (+0.000ms): sched_clock (__schedule)
04000000 0.572ms (+0.000ms): schedule (down_write)
04000000 0.572ms (+0.000ms): __schedule (down_write)
04000001 0.572ms (+0.000ms): sched_clock (__schedule)
04000000 0.572ms (+0.000ms): schedule (down_write)
04000000 0.573ms (+0.000ms): __schedule (down_write)
04000001 0.573ms (+0.000ms): sched_clock (__schedule)
04000000 0.573ms (+0.000ms): schedule (down_write)
04000000 0.573ms (+0.000ms): __schedule (down_write)
04000001 0.573ms (+0.000ms): sched_clock (__schedule)
04000000 0.573ms (+0.000ms): schedule (down_write)
04000000 0.574ms (+0.000ms): __schedule (down_write)
04000001 0.574ms (+0.000ms): sched_clock (__schedule)
04000000 0.574ms (+0.000ms): schedule (down_write)
04000000 0.574ms (+0.000ms): __schedule (down_write)
04000001 0.574ms (+0.000ms): sched_clock (__schedule)
04000000 0.574ms (+0.000ms): schedule (down_write)
04000000 0.574ms (+0.000ms): __schedule (down_write)
04000001 0.575ms (+0.000ms): sched_clock (__schedule)
04000000 0.575ms (+0.000ms): schedule (down_write)
04000000 0.575ms (+0.000ms): __schedule (down_write)
04000001 0.575ms (+0.000ms): sched_clock (__schedule)
04000000 0.575ms (+0.000ms): schedule (down_write)
04000000 0.575ms (+0.000ms): __schedule (down_write)
04000001 0.575ms (+0.000ms): sched_clock (__schedule)
04000000 0.576ms (+0.000ms): schedule (down_write)
04000000 0.576ms (+0.000ms): __schedule (down_write)
04000001 0.576ms (+0.000ms): sched_clock (__schedule)
04000000 0.576ms (+0.000ms): schedule (down_write)
04000000 0.576ms (+0.000ms): __schedule (down_write)
04000001 0.576ms (+0.000ms): sched_clock (__schedule)
04000000 0.577ms (+0.000ms): schedule (down_write)
04000000 0.577ms (+0.000ms): __schedule (down_write)
04000001 0.577ms (+0.000ms): sched_clock (__schedule)
04000000 0.577ms (+0.000ms): schedule (down_write)
04000000 0.577ms (+0.000ms): __schedule (down_write)
04000001 0.577ms (+0.000ms): sched_clock (__schedule)
04000000 0.578ms (+0.000ms): schedule (down_write)
04000000 0.578ms (+0.000ms): __schedule (down_write)
04000001 0.578ms (+0.000ms): sched_clock (__schedule)
04000000 0.578ms (+0.000ms): schedule (down_write)
04000000 0.578ms (+0.000ms): __schedule (down_write)
04000001 0.578ms (+0.000ms): sched_clock (__schedule)
04000000 0.578ms (+0.000ms): schedule (down_write)
04000000 0.579ms (+0.000ms): __schedule (down_write)
04000001 0.579ms (+0.000ms): sched_clock (__schedule)
04000000 0.579ms (+0.000ms): schedule (down_write)
04000000 0.579ms (+0.000ms): __schedule (down_write)
04000001 0.579ms (+0.000ms): sched_clock (__schedule)
04000000 0.579ms (+0.000ms): schedule (down_write)
04000000 0.579ms (+0.000ms): __schedule (down_write)
04000001 0.580ms (+0.000ms): sched_clock (__schedule)
04000000 0.580ms (+0.000ms): schedule (down_write)
04000000 0.580ms (+0.000ms): __schedule (down_write)
04000001 0.580ms (+0.000ms): sched_clock (__schedule)
04000000 0.580ms (+0.000ms): schedule (down_write)
04000000 0.580ms (+0.000ms): __schedule (down_write)
04000001 0.581ms (+0.000ms): sched_clock (__schedule)
04000000 0.581ms (+0.000ms): schedule (down_write)
04000000 0.581ms (+0.000ms): __schedule (down_write)
04000001 0.581ms (+0.000ms): sched_clock (__schedule)
04000000 0.581ms (+0.000ms): schedule (down_write)
04000000 0.581ms (+0.000ms): __schedule (down_write)
04000001 0.581ms (+0.000ms): sched_clock (__schedule)
04000000 0.582ms (+0.000ms): schedule (down_write)
04000000 0.582ms (+0.000ms): __schedule (down_write)
04000001 0.582ms (+0.000ms): sched_clock (__schedule)
04000000 0.582ms (+0.000ms): schedule (down_write)
04000000 0.582ms (+0.000ms): __schedule (down_write)
04000001 0.582ms (+0.000ms): sched_clock (__schedule)
04000000 0.583ms (+0.000ms): schedule (down_write)
04000000 0.583ms (+0.000ms): __schedule (down_write)
04000001 0.583ms (+0.000ms): sched_clock (__schedule)
04000000 0.583ms (+0.000ms): schedule (down_write)
04000000 0.583ms (+0.000ms): __schedule (down_write)
04000001 0.583ms (+0.000ms): sched_clock (__schedule)
04000000 0.584ms (+0.000ms): schedule (down_write)
04000000 0.584ms (+0.000ms): __schedule (down_write)
04000001 0.584ms (+0.000ms): sched_clock (__schedule)
04000000 0.584ms (+0.000ms): schedule (down_write)
04000000 0.584ms (+0.000ms): __schedule (down_write)
04000001 0.584ms (+0.000ms): sched_clock (__schedule)
04000000 0.584ms (+0.000ms): schedule (down_write)
04000000 0.585ms (+0.000ms): __schedule (down_write)
04000001 0.585ms (+0.000ms): sched_clock (__schedule)
04000000 0.585ms (+0.000ms): schedule (down_write)
04000000 0.585ms (+0.000ms): __schedule (down_write)
04000001 0.585ms (+0.000ms): sched_clock (__schedule)
04000000 0.585ms (+0.000ms): schedule (down_write)
04000000 0.585ms (+0.000ms): __schedule (down_write)
04000001 0.586ms (+0.000ms): sched_clock (__schedule)
04000000 0.586ms (+0.000ms): schedule (down_write)
04000000 0.586ms (+0.000ms): __schedule (down_write)
04000001 0.586ms (+0.000ms): sched_clock (__schedule)
04000000 0.586ms (+0.000ms): schedule (down_write)
04000000 0.586ms (+0.000ms): __schedule (down_write)
04000001 0.586ms (+0.000ms): sched_clock (__schedule)
04000000 0.587ms (+0.000ms): schedule (down_write)
04000000 0.587ms (+0.000ms): __schedule (down_write)
04000001 0.587ms (+0.000ms): sched_clock (__schedule)
04000000 0.587ms (+0.000ms): schedule (down_write)
04000000 0.587ms (+0.000ms): __schedule (down_write)
04000001 0.587ms (+0.000ms): sched_clock (__schedule)
04000000 0.588ms (+0.000ms): schedule (down_write)
04000000 0.588ms (+0.000ms): __schedule (down_write)
04000001 0.588ms (+0.000ms): sched_clock (__schedule)
04000000 0.588ms (+0.000ms): schedule (down_write)
04000000 0.588ms (+0.000ms): __schedule (down_write)
04000001 0.588ms (+0.000ms): sched_clock (__schedule)
04000000 0.589ms (+0.000ms): schedule (down_write)
04000000 0.589ms (+0.000ms): __schedule (down_write)
04000001 0.589ms (+0.000ms): sched_clock (__schedule)
04000000 0.589ms (+0.000ms): schedule (down_write)
04000000 0.589ms (+0.000ms): __schedule (down_write)
04000001 0.589ms (+0.000ms): sched_clock (__schedule)
04000000 0.590ms (+0.000ms): schedule (down_write)
04000000 0.590ms (+0.000ms): __schedule (down_write)
04000001 0.590ms (+0.000ms): sched_clock (__schedule)
04000000 0.590ms (+0.000ms): schedule (down_write)
04000000 0.590ms (+0.000ms): __schedule (down_write)
04000001 0.590ms (+0.000ms): sched_clock (__schedule)
04000000 0.590ms (+0.000ms): schedule (down_write)
04000000 0.591ms (+0.000ms): __schedule (down_write)
04000001 0.591ms (+0.000ms): sched_clock (__schedule)
04000000 0.591ms (+0.000ms): schedule (down_write)
04000000 0.591ms (+0.000ms): __schedule (down_write)
04000001 0.591ms (+0.000ms): sched_clock (__schedule)
04000000 0.591ms (+0.000ms): schedule (down_write)
04000000 0.591ms (+0.000ms): __schedule (down_write)
04000001 0.592ms (+0.000ms): sched_clock (__schedule)
04000000 0.592ms (+0.000ms): schedule (down_write)
04000000 0.592ms (+0.000ms): __schedule (down_write)
04000001 0.592ms (+0.000ms): sched_clock (__schedule)
04000000 0.592ms (+0.000ms): schedule (down_write)
04000000 0.592ms (+0.000ms): __schedule (down_write)
04000001 0.592ms (+0.000ms): sched_clock (__schedule)
04000000 0.593ms (+0.000ms): schedule (down_write)
04000000 0.593ms (+0.000ms): __schedule (down_write)
04000001 0.593ms (+0.000ms): sched_clock (__schedule)
04000000 0.593ms (+0.000ms): schedule (down_write)
04000000 0.593ms (+0.000ms): __schedule (down_write)
04000001 0.593ms (+0.000ms): sched_clock (__schedule)
04000000 0.594ms (+0.000ms): schedule (down_write)
04000000 0.594ms (+0.000ms): __schedule (down_write)
04000001 0.594ms (+0.000ms): sched_clock (__schedule)
04000000 0.594ms (+0.000ms): schedule (down_write)
04000000 0.594ms (+0.000ms): __schedule (down_write)
04000001 0.594ms (+0.000ms): sched_clock (__schedule)
04000000 0.595ms (+0.000ms): schedule (down_write)
04000000 0.595ms (+0.000ms): __schedule (down_write)
04000001 0.595ms (+0.000ms): sched_clock (__schedule)
04000000 0.595ms (+0.000ms): schedule (down_write)
04000000 0.595ms (+0.000ms): __schedule (down_write)
04000001 0.595ms (+0.000ms): sched_clock (__schedule)
04000000 0.596ms (+0.000ms): schedule (down_write)
04000000 0.596ms (+0.000ms): __schedule (down_write)
04000001 0.596ms (+0.000ms): sched_clock (__schedule)
04000000 0.596ms (+0.000ms): schedule (down_write)
04000000 0.596ms (+0.000ms): __schedule (down_write)
04000001 0.596ms (+0.000ms): sched_clock (__schedule)
04000000 0.596ms (+0.000ms): schedule (down_write)
04000000 0.597ms (+0.000ms): __schedule (down_write)
04000001 0.597ms (+0.000ms): sched_clock (__schedule)
04000000 0.597ms (+0.000ms): schedule (down_write)
04000000 0.597ms (+0.000ms): __schedule (down_write)
04000001 0.597ms (+0.000ms): sched_clock (__schedule)
04000000 0.597ms (+0.000ms): schedule (down_write)
04000000 0.597ms (+0.000ms): __schedule (down_write)
04000001 0.598ms (+0.000ms): sched_clock (__schedule)
04000000 0.598ms (+0.000ms): schedule (down_write)
04000000 0.598ms (+0.000ms): __schedule (down_write)
04000001 0.598ms (+0.000ms): sched_clock (__schedule)
04000000 0.598ms (+0.000ms): schedule (down_write)
04000000 0.598ms (+0.000ms): __schedule (down_write)
04000001 0.598ms (+0.000ms): sched_clock (__schedule)
04000000 0.599ms (+0.000ms): schedule (down_write)
04000000 0.599ms (+0.000ms): __schedule (down_write)
04000001 0.599ms (+0.000ms): sched_clock (__schedule)
04000000 0.599ms (+0.000ms): schedule (down_write)
04000000 0.599ms (+0.000ms): __schedule (down_write)
04000001 0.599ms (+0.000ms): sched_clock (__schedule)
04000000 0.600ms (+0.000ms): schedule (down_write)
04000000 0.600ms (+0.000ms): __schedule (down_write)
04000001 0.600ms (+0.000ms): sched_clock (__schedule)
04000000 0.600ms (+0.000ms): schedule (down_write)
04000000 0.600ms (+0.000ms): __schedule (down_write)
04000001 0.600ms (+0.000ms): sched_clock (__schedule)
04000000 0.601ms (+0.000ms): schedule (down_write)
04000000 0.601ms (+0.000ms): __schedule (down_write)
04000001 0.601ms (+0.000ms): sched_clock (__schedule)
04000000 0.601ms (+0.000ms): schedule (down_write)
04000000 0.601ms (+0.000ms): __schedule (down_write)
04000001 0.601ms (+0.000ms): sched_clock (__schedule)
04000000 0.601ms (+0.000ms): schedule (down_write)
04000000 0.602ms (+0.000ms): __schedule (down_write)
04000001 0.602ms (+0.000ms): sched_clock (__schedule)
04000000 0.602ms (+0.000ms): schedule (down_write)
04000000 0.602ms (+0.000ms): __schedule (down_write)
04000001 0.602ms (+0.000ms): sched_clock (__schedule)
04000000 0.602ms (+0.000ms): schedule (down_write)
04000000 0.602ms (+0.000ms): __schedule (down_write)
04000001 0.603ms (+0.000ms): sched_clock (__schedule)
04000000 0.603ms (+0.000ms): schedule (down_write)
04000000 0.603ms (+0.000ms): __schedule (down_write)
04000001 0.603ms (+0.000ms): sched_clock (__schedule)
04000000 0.603ms (+0.000ms): schedule (down_write)
04000000 0.603ms (+0.000ms): __schedule (down_write)
04000001 0.604ms (+0.000ms): sched_clock (__schedule)
04000000 0.604ms (+0.000ms): schedule (down_write)
04000000 0.604ms (+0.000ms): __schedule (down_write)
04000001 0.604ms (+0.000ms): sched_clock (__schedule)
04000000 0.604ms (+0.000ms): schedule (down_write)
04000000 0.604ms (+0.000ms): __schedule (down_write)
04000001 0.604ms (+0.000ms): sched_clock (__schedule)
04000000 0.605ms (+0.000ms): schedule (down_write)
04000000 0.605ms (+0.000ms): __schedule (down_write)
04000001 0.605ms (+0.000ms): sched_clock (__schedule)
04000000 0.605ms (+0.000ms): schedule (down_write)
04000000 0.605ms (+0.000ms): __schedule (down_write)
04000001 0.605ms (+0.000ms): sched_clock (__schedule)
04000000 0.606ms (+0.000ms): schedule (down_write)
04000000 0.606ms (+0.000ms): __schedule (down_write)
04000001 0.606ms (+0.000ms): sched_clock (__schedule)
04000000 0.606ms (+0.000ms): schedule (down_write)
04000000 0.606ms (+0.000ms): __schedule (down_write)
04000001 0.606ms (+0.000ms): sched_clock (__schedule)
04000000 0.607ms (+0.000ms): schedule (down_write)
04000000 0.607ms (+0.000ms): __schedule (down_write)
04000001 0.607ms (+0.000ms): sched_clock (__schedule)
04000000 0.607ms (+0.000ms): schedule (down_write)
04000000 0.607ms (+0.000ms): __schedule (down_write)
04000001 0.607ms (+0.000ms): sched_clock (__schedule)
04000000 0.607ms (+0.000ms): schedule (down_write)
04000000 0.608ms (+0.000ms): __schedule (down_write)
04000001 0.608ms (+0.000ms): sched_clock (__schedule)
04000000 0.608ms (+0.000ms): schedule (down_write)
04000000 0.608ms (+0.000ms): __schedule (down_write)
04000001 0.608ms (+0.000ms): sched_clock (__schedule)
04000000 0.608ms (+0.000ms): schedule (down_write)
04000000 0.608ms (+0.000ms): __schedule (down_write)
04000001 0.609ms (+0.000ms): sched_clock (__schedule)
04000000 0.609ms (+0.000ms): schedule (down_write)
04000000 0.609ms (+0.000ms): __schedule (down_write)
04000001 0.609ms (+0.000ms): sched_clock (__schedule)
04000000 0.609ms (+0.000ms): schedule (down_write)
04000000 0.609ms (+0.000ms): __schedule (down_write)
04000001 0.610ms (+0.000ms): sched_clock (__schedule)
04000000 0.610ms (+0.000ms): schedule (down_write)
04000000 0.610ms (+0.000ms): __schedule (down_write)
04000001 0.610ms (+0.000ms): sched_clock (__schedule)
04000000 0.610ms (+0.000ms): schedule (down_write)
04000000 0.610ms (+0.000ms): __schedule (down_write)
04000001 0.610ms (+0.000ms): sched_clock (__schedule)
04000000 0.611ms (+0.000ms): schedule (down_write)
04000000 0.611ms (+0.000ms): __schedule (down_write)
04000001 0.611ms (+0.000ms): sched_clock (__schedule)
04000000 0.611ms (+0.000ms): schedule (down_write)
04000000 0.611ms (+0.000ms): __schedule (down_write)
04000001 0.611ms (+0.000ms): sched_clock (__schedule)
04000000 0.612ms (+0.000ms): schedule (down_write)
04000000 0.612ms (+0.000ms): __schedule (down_write)
04000001 0.612ms (+0.000ms): sched_clock (__schedule)
04000000 0.612ms (+0.000ms): schedule (down_write)
04000000 0.612ms (+0.000ms): __schedule (down_write)
04000001 0.612ms (+0.000ms): sched_clock (__schedule)
04000000 0.613ms (+0.000ms): schedule (down_write)
04000000 0.613ms (+0.000ms): __schedule (down_write)
04000001 0.613ms (+0.000ms): sched_clock (__schedule)
04000000 0.613ms (+0.000ms): schedule (down_write)
04000000 0.613ms (+0.000ms): __schedule (down_write)
04000001 0.613ms (+0.000ms): sched_clock (__schedule)
04000000 0.613ms (+1168210.574ms): schedule (down_write)


mango:~# uname -a
Linux mango.fruits.de 2.6.9-rc4-mm1-RT-U6 #1 Tue Oct 19 17:59:48 CEST 2004 i686 GNU/Linux

mango:~# cat /proc/cpuinfo 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1195.144
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2359.29

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.9-rc4-mm1-RT-U6
# Tue Oct 19 17:39:11 2004
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_HOTPLUG is not set
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SHMEM=y
# CONFIG_TINY_SHMEM is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_GENERIC=y
CONFIG_GENERIC_SEMAPHORES=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_PREEMPT_VOLUNTARY=y
CONFIG_PREEMPT_SOFTIRQS=y
CONFIG_PREEMPT_HARDIRQS=y
CONFIG_PREEMPT_REALTIME=y
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_TSC=y
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

#
# Performance-monitoring counters support
#
# CONFIG_PERFCTR is not set
# CONFIG_KEXEC is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI is not set
CONFIG_ACPI_BLACKLIST_YEAR=0

#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
CONFIG_APM_REAL_MODE_POWER_OFF=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
# CONFIG_DEBUG_DRIVER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_LBD is not set
# CONFIG_CDROM_PKTCDVD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
CONFIG_BLK_DEV_SIS5513=y
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=m
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLOGIC_1280_1040 is not set
CONFIG_SCSI_QLA2XXX=m
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA6322 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK_DEV=y
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
# CONFIG_IP_MULTIPLE_TABLES is not set
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_VERBOSE is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
# CONFIG_IP_NF_CT_ACCT is not set
# CONFIG_IP_NF_CT_PROTO_SCTP is not set
# CONFIG_IP_NF_FTP is not set
# CONFIG_IP_NF_IRC is not set
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_AMANDA is not set
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_MATCH_REALM=m
# CONFIG_IP_NF_MATCH_SCTP is not set
# CONFIG_IP_NF_MATCH_COMMENT is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
# CONFIG_IP_NF_NAT_LOCAL is not set
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
# CONFIG_IP_NF_RAW is not set
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CLK_JIFFIES=y
# CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set
# CONFIG_NET_SCH_CLK_CPU is not set
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
# CONFIG_NET_SCH_HFSC is not set
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
# CONFIG_NET_SCH_NETEM is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
# CONFIG_CLS_U32_PERF is not set
# CONFIG_NET_CLS_IND is not set
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
# CONFIG_NET_CLS_ACT is not set
CONFIG_NET_CLS_POLICE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_KGDBOE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_SIS900=m
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
CONFIG_GAMEPORT=m
CONFIG_SOUND_GAMEPORT=m
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_VORTEX is not set
# CONFIG_GAMEPORT_FM801 is not set
# CONFIG_GAMEPORT_CS461x is not set
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=y
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=m
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_INTEL_MCH is not set
# CONFIG_AGP_NVIDIA is not set
CONFIG_AGP_SIS=m
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HANGCHECK_TIMER=m

#
# I2C support
#
# CONFIG_I2C is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set
CONFIG_VIDEO_SELECT=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
CONFIG_SND_DEBUG=y
# CONFIG_SND_DEBUG_MEMORY is not set
# CONFIG_SND_DEBUG_DETECT is not set

#
# Generic devices
#
CONFIG_SND_DUMMY=m
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=m
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
# CONFIG_USB is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
CONFIG_ROMFS_FS=y
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS_XATTR=y
# CONFIG_DEVPTS_FS_SECURITY is not set
CONFIG_TMPFS=y
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_EXPORTFS is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
CONFIG_AFS_FS=m
CONFIG_RXRPC=m

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_PREEMPT=y
CONFIG_PREEMPT_TIMING=y
CONFIG_PREEMPT_TRACE=y
CONFIG_LATENCY_TRACE=y
CONFIG_MCOUNT=y
CONFIG_RWSEM_DEADLOCK_DETECT=y
CONFIG_RWSEM_MAX_OWNERS=64
# CONFIG_DEBUG_INFO is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_KPROBES is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_4KSTACKS=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_KGDB is not set

#
# Security options
#
# CONFIG_KEYS is not set
CONFIG_SECURITY=y
# CONFIG_SECURITY_NETWORK is not set
CONFIG_SECURITY_CAPABILITIES=m
# CONFIG_SECURITY_SECLVL is not set
# CONFIG_SECURITY_SELINUX is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
# CONFIG_CRYPTO_MD5 is not set
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_AES_586 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC32=m
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_GENERIC_HARDIRQS=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y
