Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264962AbUGGIAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264962AbUGGIAi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 04:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbUGGIAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 04:00:38 -0400
Received: from mailgate.pit.comms.marconi.com ([169.144.68.6]:41858 "EHLO
	mailgate.pit.comms.marconi.com") by vger.kernel.org with ESMTP
	id S264962AbUGGIAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 04:00:31 -0400
Message-ID: <313680C9A886D511A06000204840E1CF08F42FD7@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'Mike Galbraith'" <efault@gmx.de>,
       "'elladan@eskimo.com'" <elladan@eskimo.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Maximum frequency of re-scheduling (minimum time quantum) que
	stio n
Date: Wed, 7 Jul 2004 03:59:01 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to both of you for answering !

>The catch here is, without the preemptable kernel option, the kernel
>can't preempt itself, so if the first process was doing something in the
>kernel, there'd be a delay.  Even with the option, it can't preempt
>itself inside of a critical section, so there will still be a (shorter)
>delay.

Yes, I am aware, - thanks to the previous answer (not included here), about
this Linux 2.6
configurable "preemptable kernel" option and was assuming it is configured
and in effect.

>In addition, the kernel can only preempt if something happens which lets
>it check its state.  Unless the low priority process makes some system
calls, 

does above means that "some system calls" have internal "built-in"
schedule()
call within their implementation ?
Is there (anywhere) documentation which lists all
system calls, which internally invoke the scheduler via calling schedule()
function call?

>the only thing that will trigger this is the timer interrupt
>which runs at eg. 100 or 400hz typically.

So I think that above is anwering my original question, that in the "worst
case" scenario - unless the rescheduling is induced earlier by explicit or
implicit (via certain system calls) invokation of the schedule() function
call, - the attempt of rescheduling (again, of course, by calling schedule()
function call) will be done at least at every "clock tick time" (say every
10 ms, which is default value)  ?

Thanks,
Best Regards,
Alexander Povolotsky

-----Original Message-----
From: Mike Galbraith [mailto:efault@gmx.de]
Sent: Monday, July 05, 2004 11:33 AM
To: Povolotsky, Alexander; 'linux-kernel@vger.kernel.org'
Subject: RE: Maximum frequency of re-scheduling (minimum time quantum)
que stio n


At 10:18 AM 7/5/2004 -0400, Povolotsky, Alexander wrote:

>Mike - the part of my original question was - what is the minimum "measure"
>(in time ticks or is fraction of the time tick ?) of that "(almost) any
time"
>? In another words, what is the latency between the moment, when
>the higher priority process (or thread ) is becoming available to run
>(assuming that "schedule()" system call is not explicitly called at that
time
>...) and the moment when the scheduler STARTS (I am not including context
>switch time into the question here) the process of preemtion (the start of
the
>context switch). Is this time settable (at compile time ) ?

Ah, you want wakeup latency numbers.  Sorry, I don't have any.  I believe 
Andrew and David both wrote tools for measuring in the wild, a search of 
the archives should turn up something that will give you the numbers you're 
looking for.

If I'm understanding your question, no, there is no latency guarantee.

> >If you're looking for an interface into the scheduler that allows you to
> >twiddle slice length
>
>you mean at the run time (vs compile time), I assume ?

Yes.

         -Mike 
-----Original Message-----
From: Elladan [mailto:elladan@eskimo.com]
Sent: Monday, July 05, 2004 10:51 PM
To: Povolotsky, Alexander
Subject: Re: Maximum frequency of re-scheduling (minimum time
quantum)question

Your question here isn't about time slices, it's about preemption
latency.

A time slice refers to the time in which the OS will hand to a process to
run,
provided no other operation preempts it during its execution.

If a higher priority task becomes runnable, the kernel will switch
execution to the task at that moment as best it can.  Eg., an interrupt
happens which causes an event that wakes up the high priority task.
Before returning to the first process, the kernel will determine that it
should switch, and will return to the high priority process instead.

The catch here is, without the preemptable kernel option, the kernel
can't preempt itself, so if the first process was doing something in the
kernel, there'd be a delay.  Even with the option, it can't preempt
itself inside of a critical section, so there will still be a (shorter)
delay.

The kernel is not real-time, so there is no guarantee about how long the
delay might be.  The critical sections, for instance, might persist for
a (relatively) long time.

In addition, the kernel can only preempt if something happens which lets
it check its state.  Unless the low priority process makes some system
calls, the only thing that will trigger this is the timer interrupt
which runs at eg. 100 or 400hz typically.

-J
-----Original Message-----
From: Mike Galbraith [mailto:efault@gmx.de]
Sent: Monday, July 05, 2004 9:39 AM
To: Povolotsky, Alexander
Subject: Re: Maximum frequency of re-scheduling (minimum time quantum)
questio n


At 04:13 AM 7/5/2004 -0400, you wrote:
>Hello,
>
>In Linux 2.6 kernel, configured with SCHED_RR, - could rescheduling be set
>to be attempted (and executed when appropriate) at EVERY CLOCK TICK, thus
>allowing the "other" process/thread (if available and ready at the moment)
>with the higher (highest at that time) priority or, otherwise, with the
same
>priority (the "next" process/thread in the same Round Robin queue, from
>which the "current" process/thread was "picked" ) to preempt the "current"
>process/thread ?

Well, you _could_ set (albeit only at compile time) the maximum timeslice 
to be 1 ms if you so desired, that would do the rapid round robin between 
peer threads thing you want.  Note however, that this won't give you a 
predictable 1 ms of cpu though, since a thread of higher priority, once 
awakened, will preempt anything of lower priority, and repeatedly receive 
renewed slices as long as it wants cpu and has not exhausted it's priority 
bonus... lower priority threads can starve.

>If EVERY CLOCK TICK is not conceptually possible (please note, that I am
not
>claiming that frequent rescheduling is "good", I am just asking to what
>measure it is possible ...) - then what is the minimum "rescheduling" time
>quantum (measured in clock ticks) is settable/possible ?
>
>What is the default value (which I presume was chosen as "optimal" ?) ?

Timeslices are normally 100ms, but as noted, wakeup of higher priority 
threads can preempt current at (almost) any time, so a slice may be spread 
over an indeterminate amount of time.  Also note that SCHED_FIFO tasks 
_have_ no slice, so queue rotation only happens at sleep time for this 
class of tasks.

If you're looking for an interface into the scheduler that allows you to 
twiddle slice length, there is none.

         -Mike 
