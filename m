Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270774AbTHOSpn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 14:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270765AbTHOSns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 14:43:48 -0400
Received: from chaos.analogic.com ([204.178.40.224]:56960 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S270755AbTHOSnQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 14:43:16 -0400
Date: Fri, 15 Aug 2003 14:45:40 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Timothy Miller <miller@techsource.com>
cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       gaxt <gaxt@rogers.com>, Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O16int for interactivity
In-Reply-To: <3F3D25D0.7010701@techsource.com>
Message-ID: <Pine.LNX.4.53.0308151422140.19832@chaos>
References: <200308160149.29834.kernel@kolivas.org> <3F3D25D0.7010701@techsource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Aug 2003, Timothy Miller wrote:

>
>
> Con Kolivas wrote:
>
> > Preemption of tasks at the same level with twice as much timeslice has been
> > dropped as this is not necessary with timeslice granularity (may improve
> > performance of cpu intensive tasks).
>
> Does this situation happen where two tasks at different nice levels have
> dynamic priority adjustments which make them effectively have the same
> priority?
>
> > Preemption of user tasks is limited to those in the interactive range; cpu
> > intensive non interactive tasks can run out their full timeslice (may also
> > improve cpu intensive performance)
>
> What can cause preemption of a task that has not used up its timeslice?
>   I assume a device interrupt could do this, but... there's a question I
> asked earlier which I haven't read the answer to yet, so I'm going to guess:
>
> A hardware timer interrupt happens at timeslice granularity.  If the
> interrupt occurs, but the timeslice is not expired, then NORMALLY, the
> ISR would just return right back to the running task, but sometimes, it
> might decided to end the time-slice early and run some other task.
>
> Right?
>

Never. However, since the time-slice is 'time', the very instant that
the hardware interrupt executes it's "iret", the hardware-timer may
interrupt and the CPU gets taken away from the task.

Suppose that the preemption timer ticked at 1 HZ intervals. Suppose
that an awful interrupt service routine (one that loops inside) took 1
second to be serviced. What would happen if a task was 3/4 of a second
into its time-slice and then a hardware interrupt occurred?

The CPU would be taken away at 3/4 second, given to the bad ISR, then
the CPU would not be returned until (1) the one-second execution time
had occurred, and (2), all other higher priority tasks had gotten their
time-slices. Each of those higher-priority tasks, could further get
interrupted by the rogue ISR. The result may be that you get the CPU
back next Tuesday.

> So, what might cause the scheduler to decide to preempt a task which has
> not used up its timeslice?
>

The scheduler does not preempt a task until its time has expired.
However time is a constantly-expiring thing so interrupts can
eat up a processes' time.

The usual way for a process (task) to lose it's allocated CPU time-
slice is to perform some I/O. When waiting for I/O, the kernel may
give the CPU to somebody else.

If, the scheduler worked on task-CPU time, rather than hardware-clock
"wall time", maybe it would be more "fair" during periods of high
interrupt activity. However, since interrupts occur anytime, they
tend to attack all competing processes equally, therefore becoming
"fair" unless it's one task that's generating all that interrupt
activity, like network I/O, or some kinds of screen-interactivity.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


