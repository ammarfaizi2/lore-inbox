Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbVHQRde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbVHQRde (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 13:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbVHQRde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 13:33:34 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:25055 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751185AbVHQRdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 13:33:33 -0400
Subject: Re: 2.6.13-rc6-rt6
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20050817064750.GA8395@elte.hu>
References: <1124208507.5764.20.camel@localhost.localdomain>
	 <20050816163202.GA5288@elte.hu> <20050816163730.GA7879@elte.hu>
	 <20050816165247.GA10386@elte.hu> <20050816170805.GA12959@elte.hu>
	 <1124214647.5764.40.camel@localhost.localdomain>
	 <1124215631.5764.43.camel@localhost.localdomain>
	 <1124218245.5764.52.camel@localhost.localdomain>
	 <1124252419.5764.83.camel@localhost.localdomain>
	 <1124257580.5764.105.camel@localhost.localdomain>
	 <20050817064750.GA8395@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 17 Aug 2005 13:32:47 -0400
Message-Id: <1124299967.5764.187.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-17 at 08:47 +0200, Ingo Molnar wrote:

> but stop_machine() looks quite preempt-unsafe to begin with. The 
> local_irq_disable() would not be needed at all if prior the 
> for_each_online_cpu() loop we'd use set_cpus_allowed. The current method 
> of achieving 'no preemption' is simply racy even during normal 
> CONFIG_PREEMPT.

The code does look flakey, but I think it still works, and it may need
to have a raw_local_irq_disable.

The do_stop is bound to a CPU when it was created, so it doesn't need to
have a set_cpus_allowed.

I guess this is what is happening:

--- 

You start do_stop in a thread on the cpu that you want to run a function
on. (it's bound to that cpu)

do_stop creates a thread on all the other cpus that will run
stopmachine.

While it creates the threads, the ones that are already created yield in
case a thread wakes up on its cpu, so that that thread can migrate to
its own cpu. (all the threads are at FIFO MAX_RT_PRIO-1, so they should
never be preempted.

After all the threads are created and acknowledge themselves, the
do_stop changes the state to PREPARE.

In stopmachine, when PREPARE is seen, it turns off preemption and stops
yielding.

do_stop then changes the state to DISABLE_IRQ.

In stopmachine, when DISABLE_IRQ is seen, it disables IRQs.

Then the do_stop runs the function that is expected to run in the
STOPPED STATE.

---

Notes:

Each time the state is changed, the ack counter is zeroed and it wont
continue until all the threads acknowledge they hit the expected point.

I'm currious why it needs to go to preempt disable before going to
irqs_disabled? It seems that once it is at the point to go, all
processes should be locked on their CPUS and it would only need to goto
irqs_disable.

I'm also assuming that whatever function is being run expects to have
interrupts off on all CPUs. So a raw_local_irq_disable may be in order.

The comment above the stop_machine (called by do_stop) local_irq_disable
looks incorrect. It says 
/* Don't schedule us away at this point, please */  I don't see how it
can be scheduled out if it is running FIFO MAX_RT_PRIO-1.  It just
assume that it doesn't want any interrupts to go off.

Do you still see a problem with stop_machine?

-- Steve


