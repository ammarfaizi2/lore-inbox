Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267447AbUIJO5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267447AbUIJO5t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 10:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267413AbUIJO5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 10:57:49 -0400
Received: from www2.muking.org ([216.231.42.228]:28776 "HELO www2.muking.org")
	by vger.kernel.org with SMTP id S267475AbUIJO4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 10:56:37 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: voluntary-preemption: understanding latency trace
References: <83656nk9mk.fsf@www2.muking.org>
	<1094763737.1362.325.camel@krustophenia.net>
	<20040910063749.GA25298@elte.hu>
From: Kevin Hilman <kjh-lkml@hilman.org>
Organization: None to speak of.
Date: 10 Sep 2004 07:56:33 -0700
Message-ID: <83eklaf9zy.fsf@www2.muking.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > > I've got a SCHED_FIFO kernel thread at the highest priority
> > > (MAX_USER_RT_PRIO-1) and it's sleeping on a wait queue.  The wake is
> > > called from an ISR.  Since this thread is the highest priority in the
> > > system, I expect it to run before the ISR threads and softIRQ threads
> > > etc. 
> > > 
> > > In the ISR I sample sched_clock() just before the call to wake_up()
> > > and in the thread I sample sched_clock() again just after the call to
> > > sleep.  I'm seeing an almost 4ms latency between the call to wake_up
> > > and the actual wakeup.  However, in /proc/latency_trace, the worst
> > > latency I see during the running of this test is <500us.
> 
> > Ingo, any ideas here?  Looks like maybe the use of sched_clock is the
> > problem.
> 
> sched_clock() is not 100% accurate (it takes a few shortcuts to avoid a
> division) but it should be better than 90% so 4 msec measured means
> there's likely some big delay.
> 
> if the priority setup is indeed as described above then the RT task
> should have run much faster. First i'd suggest to check whether it's not
> console printing (printing of a stacktrace or a latency trace) that 
> slows things down.

It must've been the latency trace itself as with it turned off, I'm
not seeing the 4ms latency between sched_clock() calls anymore.

> If the console is silent and sched_clock() still indicates a ~4msec
> delay then i'd suggest the following thing to debug this:
> 
> - upgrade to the -S0 patch
> 
> - edit kernel/latency.c's MAX_TRACE value to be 20000 or so
> 
> - reboot into the modified kernel and do:
> 
>      echo 2 > /proc/sys/kernel/trace_enabled
> 
>   (this turns on 'user defined tracing')
> 
> - modify the second sched_clock() call to do this instead:
> 
>      user_trace_start();
> 
>   modify the second sched_clock() call to do:
> 
>      user_trace_stop();
> 
> you should have the full trace of what happens between the wakeup and
> the process activation in /proc/latency_trace.

Using -S0 and the user_trace, I indeed see that the high-priority task
is beeing switched in very quickly.

Kevin
