Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288890AbSANHna>; Mon, 14 Jan 2002 02:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288922AbSANHnU>; Mon, 14 Jan 2002 02:43:20 -0500
Received: from mx2.elte.hu ([157.181.151.9]:60554 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288890AbSANHnD>;
	Mon, 14 Jan 2002 02:43:03 -0500
Date: Mon, 14 Jan 2002 10:40:16 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: The O(1) scheduler breaks UML
In-Reply-To: <200201140239.VAA05307@ccure.karaya.com>
Message-ID: <Pine.LNX.4.33.0201140954300.2248-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 13 Jan 2002, Jeff Dike wrote:

> The new scheduler holds IRQs off across the call to context_switch.
> UML's _switch_to expects them to be enabled when it is called, and
> things go badly wrong when they are not.

unfortunately this cannot be done, due to exit(), ptrace() and other SMP
races. On SMP, the 'previous' task is protected by the runqueue lock. If
we do the context switch outside the runqueue lock then a task might be
freed on another CPU while it's in fact still in use.

there are other heavy implications as well:

- current->processor is no longer valid from IRQ handlers.

- a CPU might execute the 'previous' task before we have switched away
  from it. (nothing but the runqueue lock keeps the load balancer from
  taking the task from the runqueue.)

in 2.4 i've implemented irq-enabled context switches, and it was a major
PITA. To do it correctly one has to do reintroduce __schedule_tail() and
do a task_lock/task_unlock to get context-switch atomicity via other means
than the local runqueue lock. On 2.4 i did this because global runqueue
contention was such an issue for certain workloads that even the
task-unlocking overhead was worth it. With the O(1) scheduler this is
pretty much out of the question.

we could enable interrupts on UP - because UP is special, disabling
interrupts there is in essence a cheap 'global interrupt lock'. But that
doesnt help the SMP/UML situation much.

i'd suggest to find some other solution for UML, besides signals.
__switch_to is a very internal function that can very well be called with
spinlocks disabled, we just cannot guarantee that it will be called with
irqs enabled. Signals are something that is often 'heavy', it cannot be
done atomically in the generic case.

	Ingo

