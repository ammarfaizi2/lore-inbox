Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263806AbUIJHMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUIJHMj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 03:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266888AbUIJHLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 03:11:01 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:2455 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263806AbUIJHJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 03:09:04 -0400
Subject: Re: voluntary-preemption: understanding latency trace
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Kevin Hilman <kjh-lkml@hilman.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040910063749.GA25298@elte.hu>
References: <83656nk9mk.fsf@www2.muking.org>
	 <1094763737.1362.325.camel@krustophenia.net>
	 <20040910063749.GA25298@elte.hu>
Content-Type: text/plain
Message-Id: <1094800144.15407.4.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 10 Sep 2004 03:09:04 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-10 at 02:37, Ingo Molnar wrote:
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
> 

Ah, this is probably it, this is pretty close to the latency I get when
/proc/latency_trace is updated, and this is also the one latency that
doesn't show in the traces by design.

rlrevell@mindpipe:~$ ./amlat-rlr/amlat 
599.895 MHz
secondsPerTick=0.000000
ticksPerSecond=599894954.372806
599.895 MHz
Using rtc interval of 1024
u=0
latency = 53 microseconds
latency = 60 microseconds
latency = 60 microseconds
latency = 62 microseconds
latency = 66 microseconds
latency = 76 microseconds
latency = 78 microseconds
latency = 2548 microseconds

The last line is the latency trace being updated.  If I turn off tracing
or set preempt_max_latency to a high value then amlat doesn't show
these.

Lee


