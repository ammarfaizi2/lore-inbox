Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264998AbUGGI7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264998AbUGGI7h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 04:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265022AbUGGI7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 04:59:37 -0400
Received: from ultra1.eskimo.com ([204.122.16.64]:55563 "EHLO
	ultra1.eskimo.com") by vger.kernel.org with ESMTP id S264998AbUGGI7d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 04:59:33 -0400
Date: Wed, 7 Jul 2004 01:59:23 -0700
From: Elladan <elladan@eskimo.com>
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
Cc: "'Mike Galbraith'" <efault@gmx.de>,
       "'elladan@eskimo.com'" <elladan@eskimo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Maximum frequency of re-scheduling (minimum time quantum) que stio n
Message-ID: <20040707085923.GA29731@eskimo.com>
References: <313680C9A886D511A06000204840E1CF08F42FD7@whq-msgusr-02.pit.comms.marconi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <313680C9A886D511A06000204840E1CF08F42FD7@whq-msgusr-02.pit.comms.marconi.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 03:59:01AM -0400, Povolotsky, Alexander wrote:
> Thanks to both of you for answering !
> 
> >The catch here is, without the preemptable kernel option, the kernel
> >can't preempt itself, so if the first process was doing something in the
> >kernel, there'd be a delay.  Even with the option, it can't preempt
> >itself inside of a critical section, so there will still be a (shorter)
> >delay.
> 
> Yes, I am aware, - thanks to the previous answer (not included here), about
> this Linux 2.6
> configurable "preemptable kernel" option and was assuming it is configured
> and in effect.

Note that the preemptable kernel gives you no guarantee of latency,
though it does reduce the average latency.  A different patch was
constructed in the 2.4 era which attempted to provide guaranteed latency
through a different approach (effectively, having all long-running
operations yield).

> >In addition, the kernel can only preempt if something happens which lets
> >it check its state.  Unless the low priority process makes some system
> calls, 
> 
> does above means that "some system calls" have internal "built-in"
> schedule()
> call within their implementation ?
> Is there (anywhere) documentation which lists all
> system calls, which internally invoke the scheduler via calling schedule()
> function call?

All system calls execute schedule() before returning to user space, if
schedule has been requested.  It's done in the system call handler.  An
interrupt will also schedule if necessary.

In addition, if you have a preemptable kernel, schedule() may be
executed on demand at any time the kernel isn't in a critical section,
or upon exiting a critical section if it is.

> >the only thing that will trigger this is the timer interrupt
> >which runs at eg. 100 or 400hz typically.
> 
> So I think that above is anwering my original question, that in the "worst
> case" scenario - unless the rescheduling is induced earlier by explicit or
> implicit (via certain system calls) invokation of the schedule() function
> call, - the attempt of rescheduling (again, of course, by calling schedule()
> function call) will be done at least at every "clock tick time" (say every
> 10 ms, which is default value)  ?

The reschedule will be done whenever the kernel does it.  There is no
guaranteed worst case.  It's just based on "best effort."

If an interrupt from some device, or the timer interrupt, causes a
high-priority process to become runnable, the kernel will attempt to
schedule as soon as possible.  With a preemptable kernel, that will be
as soon as it releases all locks and can thus be safely interrupted.
But the kernel makes no guarantee that locks won't be held for long
periods of time, so the worst case latency is the longest possible
duration of an operation in the kernel.  That could be quite long (many
milliseconds) if it's walking tables, hitting worst-case hash behavior,
etc.

The thing to note about the timer is that, if you have no external
interrupt driving your wakeup, then you're waking up based on some sort
of timer.  The best resolution you can get from a timer is approximately
based on HZ.  In 2.6 kernels, the interrupt frequency is 1000hz, but
ticks are represented to userspace as if they were 100hz.  Also, you may
have an RTC available if you need high frequency interrupts.

-J

