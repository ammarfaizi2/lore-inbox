Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284138AbSAEVFE>; Sat, 5 Jan 2002 16:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284139AbSAEVEy>; Sat, 5 Jan 2002 16:04:54 -0500
Received: from cs182172.pp.htv.fi ([213.243.182.172]:33157 "EHLO
	cs182172.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S284138AbSAEVEp>; Sat, 5 Jan 2002 16:04:45 -0500
Message-ID: <3C376A51.623258C9@welho.com>
Date: Sat, 05 Jan 2002 23:04:17 +0200
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: Davide Libenzi <davidel@xmailserver.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <Pine.LNX.4.33.0201052247540.10321-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> yes, we can do the following: instead of sending the broadcast IPI, we can
> skip CPUs that run a RT task that has a higher priority than the one that
> just got woken up. This way we send the IPI only to CPUs that have a
> chance to actually preempt their current task for the newly woken up task.
> We do this optimization for SCHED_OTHER tasks already, behavior like this
> is not something cast into stone.
> 
> this way you can mark your RT task 'uninterruptible' by giving it a high
> RT priority.

This is sort of what I was thinking, although it makes it more expensive
to determine to IPI mask. A very light weight alternative could be to
make only the highest priority RT tasks uninterruptible. If a CPU is
busy with one of these it can simply be taken out of the global group
for the duration. If a task is worried about interruptions, it can boost
its prio to max for the critical part and the return it to normal
afterwards.

> i'd also like to note that Davide's description made the broadcast IPI
> solution sound more scary than it is in fact. A broadcast IPI's handler is
> pretty lightweight (it does a single APIC ACK and returns), and even a
> pointless trip into the O(1) scheduler wont take more time than say 10-20
> microseconds (pessimistic calculation), on a typical x86 system.

I guess the worry is that the overhead isn't bounded and the per-CPU
overhead increases with the number of CPUs. If the interrupts happen
come in a burst, a running task can experience a longer interruption.

> The reason i made the IPI a broadcast in the RT case is race avoidance:
> right now our IPIs are 'inexact', ie. if the scheduling situation changes
> while they are in flight (they can take 5-10 microseconds to get delivered
> to the target) then they might hit the wrong target. In case of RT/SMP,
> this might end up us missing to run a task that should be run. This was
> the major reason why i took the broadcast IPI solution.

I see your point. I may be getting off base here, but how does the cost
of making the IPIs exact compare to the cost of using broadcast IPIs on
an n-way machine (depends on n I suppose)?

Regards,

	MikaL
