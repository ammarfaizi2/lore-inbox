Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbTHUKHj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 06:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbTHUKHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 06:07:39 -0400
Received: from [66.212.224.118] ([66.212.224.118]:50189 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S262524AbTHUKHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 06:07:37 -0400
Date: Thu, 21 Aug 2003 06:07:34 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: TeJun Huh <tejun@aratech.co.kr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible race condition in i386 global_irq_lock handling.
In-Reply-To: <20030821084807.GA29913@atj.dyndns.org>
Message-ID: <Pine.LNX.4.53.0308210601530.17457@montezuma.mastecende.com>
References: <20030821084807.GA29913@atj.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Aug 2003, TeJun Huh wrote:

>  I've been reading i386 interrupt handling code for a couple of days
> and encountered something that looks like a race condition.  It's
> between include/asm-i386/hardirq.h:irq_enter() and
> arch/i386/kernel/irq.c:get_irqlock().  They seem to be using lockless
> synchronization with local_irq_count of each cpu and global_irq_lock
> variable.

Ok 2.4 (but for future try and mention which kernel version). You'll have 
to forgive me if i misunderstand you..

>  A. locking CPU
> 
>  1. Do test_and_set_bit() on global_irq_lock, if fail, repeat.
>  2. If all local_irq_count's are zero, we're the winner.  Check other
>     stuff; otherwise, clear global_irq_lock and retry.

Are you referring to hardirq_trylock()?

>  B. other CPUs
> 
>  1. Increment local_irq_count
>  2. test_bit() on global_irq_lock, if zero, continue handling interrupt;
>     otherwise, wait till it's cleared.
> 
>  For this to work, the locking CPU should fetch the value of
> local_irq_count after global_irq_lock value becomes visible to other
> CPUs, and other CPUs should fetch the value of global_irq_lock after
> making the incremented local_irq_count visible to other CPUs.

Why after? it's currently in an interrupt anyway, the local_irq_count is 
per cpu so it's not used on other cpus why do you need to make it 
visible on other processors? (save irqs_running() but even that's ok)

>  The locking CPU is OK because test_and_set_bit() forces ordering on
> x86, but there should be a mb() betweewn step 1 and 2 for other CPUs
> because none of ++ and test_bit is ordering.  The B part is irq_enter()
> in hardirq.h which looks like the following.
> 
> static inline void irq_enter(int cpu, int irq)
> {
> 	++local_irq_count(cpu);
> 
> 	while (test_bit(0,&global_irq_lock)) {
> 		cpu_relax();
> 	}
> }
> 
>  Is it a race condition or am I getting it horribly wrong?  Thx in
> advance.

I don't see or understand the race condition you're describing, 
local_irq_count is per cpu.

	Zwane

