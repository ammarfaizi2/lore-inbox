Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262495AbVGLVeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262495AbVGLVeX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 17:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbVGLVeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 17:34:11 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:2699 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262491AbVGLVd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 17:33:58 -0400
Date: Tue, 12 Jul 2005 14:34:26 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: shemminger@osdl.org, dipankar@in.ibm.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: PREEMPT/PREEMPT_RT question
Message-ID: <20050712213426.GD1323@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050712163031.GA1323@us.ibm.com> <1121187924.6917.75.camel@localhost.localdomain> <20050712192832.GB1323@us.ibm.com> <1121198657.3548.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121198657.3548.11.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 04:04:17PM -0400, Steven Rostedt wrote:
> On Tue, 2005-07-12 at 12:28 -0700, Paul E. McKenney wrote:
> > > 
> > > So is there a difference on UP between x.counter++ and atomic_inc(&x)?
> > 
> > On x86, you are right.  The full list of architectures that are atomic
> > only in SMP are i386 (as you noted), parisc, sparc, and x86_64.
> > 
> > The architectures that appear to always be atomic are: alpha, ia64, m32r
> > (but unfamiliar with this one), mips, ppc, ppc64, s390 (I think...),
> > and sparc64.  Most of these architectures need to disable interrupts
> > to provide "universal" atomic_inc() semantics in UP kernels, due to
> > their RISC-style atomic instructions.  
> > 
> > The following architectures avoid the issue entirely by refusing to
> > support SMP: arm, arm26, cris, frv, h8300, m68k, m68knommu, sh, sh64,
> > and v850.  Many of them disable interrupts in their atomic_inc()
> > implementations.
> > 
> > The advantage of smp_atomic_inc() is that architectures could dispense
> > with interrupt disabling.  The disadvantage is that it is yet another
> > contribution to Linux's combinatorial explosion of primitives.
> > 
> > For the moment, I will grit my teeth and keep atomic_inc() and atomic_dec().
> > 
> > Other thoughts?
> 
> How did I know that you would mention mips and the like :-)
> 
> Yeah, mips has the crazy Load Linked and Store Conditional crap, so it
> is a little more complex than the simple add one.  And I think PPC does
> too, although it has been a while since I've used them.  And older mips
> don't have the LL SC command so the only option is to turn off
> interrupts (of course those that don't have the LL and SC are not SMP
> compatible).  So, I will admit that having a smp_atomic_inc might be
> nice. I was just being a narrow minded x86 hacker ;-)

I am sure that LL/SC seemed like a good idea at the time.  ;-)

To be fair, LL/SC does allow allow some things to be done more easily
than with cmpxchg, since it allows you to tell that the value changed
even if it later changed back.  Helps with some linked-list operations.

> > > Yep interrupts are threads in CONFIG_PREEMPT_RT.  I guess you could also
> > > just use local_irq_save with spin_lock, since now local_irq_save no
> > > longer disables interrupts in PREEMPT_RT.
> > 
> > By this you mean the following?
> > 
> > 	local_irq_save(flags);
> > 	_raw_spin_lock(&mylock);
> > 
> > 	/* critical section */
> > 
> > 	_raw_spin_unlock(&mylock);
> > 	local_irq_restore(flags);
> 
> Yeah, that on PREEMP_RT would not turn off interrupts but just stops
> preemption. This is fine as long as the mylock is not used in any
> SA_NODELAY interrupt.

Cool!  Is the scheduling-clock interrupt an SA_NODELAY interrupt?

							Thanx, Paul
