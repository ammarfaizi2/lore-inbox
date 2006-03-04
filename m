Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWCDQpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWCDQpA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 11:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWCDQo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 11:44:58 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:64216 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932159AbWCDQop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 11:44:45 -0500
Date: Sat, 4 Mar 2006 11:44:38 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: shane Miller <gshanemiller@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: How linux schedules things when interrupts occur
In-Reply-To: <f89c9fd60603040742x1ae5ce29rbe4ccc39fb973e08@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0603041128090.15803@gandalf.stny.rr.com>
References: <f89c9fd60603040742x1ae5ce29rbe4ccc39fb973e08@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Shane, this is more of a www.kernelnewbies.org question, but I have
some free time on my hands, so I'll reply to some of your questions.

On Sat, 4 Mar 2006, shane Miller wrote:

> All-
>
> I know what interrupts are. I read the Linux Device driver book and
> see how to deal with them. But I don't see the full picture on how the
> kernel deals with scheduling it's work. Bsically I am leaking for more
> meat on this.

Good book, you might also want to read:

Understanding the Linux Kernel ISBN: 0596002130
Linux Kernel Development ISBN: 0672327201

>
> Suppose Linux is running on a single CPU system. Conceptually the CPU
> is executing a user thread/process --- whether  that be user code or
> library code on the user's behalf --- or the CPU is in the kernel.
>
> When an APIC processed hardware interrupt comes and assuming the
> interrupt is not masked off then if
>
> * the CPU is doing user code, the kernel arranges to block/preempt the
> current user process/thread and jumps into the kernel and runs the
> registered interrupt handler.
>
> * the CPU is in the kernel so it jumps to the interrupt handler and
> runs it.
>
> Can somebody put some more meat on this? For example,
>
> * how does the kernel decide what to schedule once the interrupt
> handler is done? Does it, as may be the case, resume the preempted user
> thread or resume where it left off in the kernel? Or does it merely
> call schedule().

Basically it goes back to where it was interrupted. Now there's some other
things that are affected by this.

If the timer interrupt went off it may run update_process_times and may
decide that the process ran enough. Or another interrupt went off and woke
up a higher priority process.  When the current running process needs to
be preempted, it has it's need_resched flag set (set_need_resched), so
when leaving the interrupt if:
1) going back to userland
2) going back to the kernel and CONFIG_PREEMPT is set and preempt_count is
   zero
Then schedule is called and it will most likely schedule another process.
If CONFIG_PREEMPT is not set, then the schedule waits till the kernel
calls schedule directly or goes back to userspace.
If CONFIG_PREEMPT is set but the preempt_count was active, then when
preempt_count gets down to zero, a check of need_resched is made, and if
set it calls schedule.

> * What happens if a signal comes during this work?

Signals are added to the task and are handled when going back to userland.

>
> Once I understand this I think I can deal with the case in which an
> interrupt comes while an interrupt is already being processed.
>

That's called nested interrupts, and that will never schedule until the
last interrupt returns.

Then we have the issue of softirqs and tasklets :) but that's another
story.


-- Steve

