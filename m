Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281772AbSAEUDB>; Sat, 5 Jan 2002 15:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281762AbSAEUCw>; Sat, 5 Jan 2002 15:02:52 -0500
Received: from mx2.elte.hu ([157.181.151.9]:8850 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S281504AbSAEUCl>;
	Sat, 5 Jan 2002 15:02:41 -0500
Date: Sat, 5 Jan 2002 23:00:05 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Mika Liljeberg <Mika.Liljeberg@welho.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <3C3758B3.9A84693C@welho.com>
Message-ID: <Pine.LNX.4.33.0201052247540.10321-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 5 Jan 2002, Mika Liljeberg wrote:

> Well, different RT tasks have different requirements and when multiple
> RT tasks are competing for the CPUs it gets more interesting. For
> instance, suppose that I have the MAC protocol for a software radio
> running on a dedicated CPU, clocking out a radio frame every 1 ms with
> very high time synchronization requirements. For this application I
> definately don't want my CPU suddenly racing to the door to see why
> the doorbell rang. :) This seems to suggest that it should be possible
> for a task to make itself non-interruptible, in which case it would
> not even receive reschedule IPIs for the global RT tasks.

yes, we can do the following: instead of sending the broadcast IPI, we can
skip CPUs that run a RT task that has a higher priority than the one that
just got woken up. This way we send the IPI only to CPUs that have a
chance to actually preempt their current task for the newly woken up task.
We do this optimization for SCHED_OTHER tasks already, behavior like this
is not something cast into stone.

this way you can mark your RT task 'uninterruptible' by giving it a high
RT priority.

i'd also like to note that Davide's description made the broadcast IPI
solution sound more scary than it is in fact. A broadcast IPI's handler is
pretty lightweight (it does a single APIC ACK and returns), and even a
pointless trip into the O(1) scheduler wont take more time than say 10-20
microseconds (pessimistic calculation), on a typical x86 system.

and there is another solution as well, we could simply pick a single CPU
where the RT task preempts the current task, and send a directed IPI. This
is similar to the reschedule_idle() code.

The reason i made the IPI a broadcast in the RT case is race avoidance:
right now our IPIs are 'inexact', ie. if the scheduling situation changes
while they are in flight (they can take 5-10 microseconds to get delivered
to the target) then they might hit the wrong target. In case of RT/SMP,
this might end up us missing to run a task that should be run. This was
the major reason why i took the broadcast IPI solution. Eg. consider the
following situation: we have 4 runnable RT tasks, two have priority 20,
the other two have a higher RT priority of 90. We do not want to end up
with this situation:

	CPU#0					CPU#1
        prio 90 task running			prio 20 task running
	prio 90 task pending			prio 20 task pending

because the pending prio 90 task should run on CPU#1:

	CPU#0					CPU#1
        prio 90 task running			prio 90 task running
	prio 20 task pending			prio 20 task pending

situations like this is the main reason why i made the RT scheduler use
heavier locking and more conservative constructs, like broadcast IPIs.

	Ingo

