Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262484AbVGMBp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbVGMBp7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 21:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbVGMBp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 21:45:59 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:48789 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262484AbVGMBpy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 21:45:54 -0400
Date: Tue, 12 Jul 2005 18:46:27 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: shemminger@osdl.org, dipankar@in.ibm.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: PREEMPT/PREEMPT_RT question
Message-ID: <20050713014627.GF1323@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050712163031.GA1323@us.ibm.com> <1121187924.6917.75.camel@localhost.localdomain> <20050712192832.GB1323@us.ibm.com> <1121198657.3548.11.camel@localhost.localdomain> <20050712213426.GD1323@us.ibm.com> <1121212035.3548.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121212035.3548.34.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 07:47:15PM -0400, Steven Rostedt wrote:
> On Tue, 2005-07-12 at 14:34 -0700, Paul E. McKenney wrote:
> > > Yeah, mips has the crazy Load Linked and Store Conditional crap, so it
> > > is a little more complex than the simple add one.  And I think PPC does
> > > too, although it has been a while since I've used them.  And older mips
> > > don't have the LL SC command so the only option is to turn off
> > > interrupts (of course those that don't have the LL and SC are not SMP
> > > compatible).  So, I will admit that having a smp_atomic_inc might be
> > > nice. I was just being a narrow minded x86 hacker ;-)
> > 
> > I am sure that LL/SC seemed like a good idea at the time.  ;-)
> > 
> > To be fair, LL/SC does allow allow some things to be done more easily
> > than with cmpxchg, since it allows you to tell that the value changed
> > even if it later changed back.  Helps with some linked-list operations.
> 
> I was being a little harsh in my statements.  I didn't really mind the
> LL and SC but a true atomic inc would have been nice.  I actually had to
> port Linux to a MIPS board once that didn't have the LL or SC, and that
> was even more painful.

I could believe that!

> > > > > Yep interrupts are threads in CONFIG_PREEMPT_RT.  I guess you could also
> > > > > just use local_irq_save with spin_lock, since now local_irq_save no
> > > > > longer disables interrupts in PREEMPT_RT.
> > > > 
> > > > By this you mean the following?
> > > > 
> > > > 	local_irq_save(flags);
> > > > 	_raw_spin_lock(&mylock);
> > > > 
> > > > 	/* critical section */
> > > > 
> > > > 	_raw_spin_unlock(&mylock);
> > > > 	local_irq_restore(flags);
> > > 
> > > Yeah, that on PREEMP_RT would not turn off interrupts but just stops
> > > preemption. This is fine as long as the mylock is not used in any
> > > SA_NODELAY interrupt.
> > 
> > Cool!  Is the scheduling-clock interrupt an SA_NODELAY interrupt?
> 
> If you are talking about scheduler_tick, then yes, it is called by the
> timer interrupt which is a SA_NODELAY interrupt.  If you don't want to
> get interrupted by the timer interrupt, then you will need to disable
> interrupts for both. Since currently, the timer interrupt is the only
> true hard interrupt in the PREEMPT_RT and that may not change.

OK, so if I take a spinlock in something invoked from scheduler_tick(),
then any other acquisitions of that spinlock must disable hardware
interrupts, right?

							Thanx, Paul
