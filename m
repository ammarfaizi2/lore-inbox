Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268286AbUIJGgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268286AbUIJGgr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 02:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268327AbUIJGgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 02:36:47 -0400
Received: from mx1.elte.hu ([157.181.1.137]:11731 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268286AbUIJGgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 02:36:43 -0400
Date: Fri, 10 Sep 2004 08:37:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Kevin Hilman <kjh-lkml@hilman.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: voluntary-preemption: understanding latency trace
Message-ID: <20040910063749.GA25298@elte.hu>
References: <83656nk9mk.fsf@www2.muking.org> <1094763737.1362.325.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094763737.1362.325.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> > I've got a SCHED_FIFO kernel thread at the highest priority
> > (MAX_USER_RT_PRIO-1) and it's sleeping on a wait queue.  The wake is
> > called from an ISR.  Since this thread is the highest priority in the
> > system, I expect it to run before the ISR threads and softIRQ threads
> > etc. 
> > 
> > In the ISR I sample sched_clock() just before the call to wake_up()
> > and in the thread I sample sched_clock() again just after the call to
> > sleep.  I'm seeing an almost 4ms latency between the call to wake_up
> > and the actual wakeup.  However, in /proc/latency_trace, the worst
> > latency I see during the running of this test is <500us.

> Ingo, any ideas here?  Looks like maybe the use of sched_clock is the
> problem.

sched_clock() is not 100% accurate (it takes a few shortcuts to avoid a
division) but it should be better than 90% so 4 msec measured means
there's likely some big delay.

if the priority setup is indeed as described above then the RT task
should have run much faster. First i'd suggest to check whether it's not
console printing (printing of a stacktrace or a latency trace) that 
slows things down.

If the console is silent and sched_clock() still indicates a ~4msec
delay then i'd suggest the following thing to debug this:

- upgrade to the -S0 patch

- edit kernel/latency.c's MAX_TRACE value to be 20000 or so

- reboot into the modified kernel and do:

     echo 2 > /proc/sys/kernel/trace_enabled

  (this turns on 'user defined tracing')

- modify the second sched_clock() call to do this instead:

     user_trace_start();

  modify the second sched_clock() call to do:

     user_trace_stop();

you should have the full trace of what happens between the wakeup and
the process activation in /proc/latency_trace. Please send it to me
(off-list). [NOTE: the usecs item in this special kind of latency_trace
is not accurate because trace_enabled=2 does not measure the latency -
but the absolute timestamps and relative latencies displayed in the
latency_trace will still be accurate.]

	Ingo
