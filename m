Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbTHUQON (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 12:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbTHUQON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 12:14:13 -0400
Received: from ns.aratech.co.kr ([61.34.11.200]:41861 "EHLO ns.aratech.co.kr")
	by vger.kernel.org with ESMTP id S262756AbTHUQOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 12:14:04 -0400
Date: Fri, 22 Aug 2003 01:15:38 +0900
From: TeJun Huh <tejun@aratech.co.kr>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible race condition in i386 global_irq_lock handling.
Message-ID: <20030821161538.GA504@atj.dyndns.org>
Mail-Followup-To: Zwane Mwaikambo <zwane@linuxpower.ca>,
	linux-kernel@vger.kernel.org
References: <20030821084807.GA29913@atj.dyndns.org> <Pine.LNX.4.53.0308210601530.17457@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0308210601530.17457@montezuma.mastecende.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 06:07:34AM -0400, Zwane Mwaikambo wrote:
> 
> Ok 2.4 (but for future try and mention which kernel version). You'll have 
> to forgive me if i misunderstand you..

 The version I'm looking at is 2.4.21. Sorry about forgetting to
mention.

> Are you referring to hardirq_trylock()?
>...cut...
> >  For this to work, the locking CPU should fetch the value of
> > local_irq_count after global_irq_lock value becomes visible to other
> > CPUs, and other CPUs should fetch the value of global_irq_lock after
> > making the incremented local_irq_count visible to other CPUs.
> 
> Why after? it's currently in an interrupt anyway, the local_irq_count is 
> per cpu so it's not used on other cpus why do you need to make it 
> visible on other processors? (save irqs_running() but even that's ok)

 I'm talking about global_irq_lock synchronization. local_irq_count
_is_ local but used to synchronize global irq lock. Sparc uses big
reader lock for this purpose but x86 code seems to use memory-ordered
lockless synchronization.

 I'll describe it in more detail. On MP, cli() is __global_cli(),
which in turn calls get_irqlock(). get_irqlock() uses
test_and_set_bit() and wait_on_irq() to achieve global irq locking.
The counterpart of this locking is irq_enter() and irq_exit().
Simplified version of the mechanism is as following.

A. get_irqlock() -> wait_on_irq()

1. Repeat test_and_set_bit(0, &global_irq_lock) until we're the winner.
2. Test if all local_irq_count's are zero. If there is any non-zero
   value, the CPU might have entered interrupt handler already. Clear
   global_irq_lock and go back to step 1.

=> If the test succeeded, we should be sure that no other cpu is
   running an interrupt handler and none will enter interrupt handler
   until global_irq_lock is cleared.

B. irq_enter()

1. Increment local_irq_count.
2. Do test_bit(0, &global_irq_lock). If it's set, someone is trying to
   grab or have grabbed global_irq_lock, loop until it gets cleared.
   If global_irq_lock is clear, the CPU enters interrupt handler.

 The race condition occurs because there is no mb() between step 1 and
2 of irq_enter(). Example scenarios would be

 [AM]: atomic & memory barrier
 [L] : local to cpu (not yet visible to other cpus)
 [G] : became global

	A				B
  calls cli()			Interrupt occurs
  executing get_irqlock()	executing irq_enter()

** Scenario #1
				[L]++local_irq_counter
				fetch global_irq_lock
  [AM]set global_irq_lock	test global_irq_lock
  fetch local_irq_counter
  test local_irq_counter	[G]++local_irq_counter
  
** Scenario #2
				fetch global_irq_lock
  [AM]set global_irq_lock
  fetch local_irq_counter
  test local_irq_counter	[L]++local_irq_counter
				[G]++local_irq_counter
				test global_irq_lock

 On above scenarios, B enters interrupt handler and A returns
successfully from cli() - B will be executing an interrupt handler
while A is inside cli(), sti() critical section. This occurs because
there is nothing which forces fetching of global_irq_lock occur after
making local_irq_counter increment visible to other cpus.

 If I misunderstood the synchronization mechanism or architectural
characteristics, please point out.
