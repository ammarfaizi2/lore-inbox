Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262514AbVGLXsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbVGLXsd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 19:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVGLXsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 19:48:23 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:51863 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262492AbVGLXrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 19:47:40 -0400
Subject: Re: PREEMPT/PREEMPT_RT question
From: Steven Rostedt <rostedt@goodmis.org>
To: paulmck@us.ibm.com
Cc: shemminger@osdl.org, dipankar@in.ibm.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050712213426.GD1323@us.ibm.com>
References: <20050712163031.GA1323@us.ibm.com>
	 <1121187924.6917.75.camel@localhost.localdomain>
	 <20050712192832.GB1323@us.ibm.com>
	 <1121198657.3548.11.camel@localhost.localdomain>
	 <20050712213426.GD1323@us.ibm.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 12 Jul 2005 19:47:15 -0400
Message-Id: <1121212035.3548.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-12 at 14:34 -0700, Paul E. McKenney wrote:

> > 
> > Yeah, mips has the crazy Load Linked and Store Conditional crap, so it
> > is a little more complex than the simple add one.  And I think PPC does
> > too, although it has been a while since I've used them.  And older mips
> > don't have the LL SC command so the only option is to turn off
> > interrupts (of course those that don't have the LL and SC are not SMP
> > compatible).  So, I will admit that having a smp_atomic_inc might be
> > nice. I was just being a narrow minded x86 hacker ;-)
> 
> I am sure that LL/SC seemed like a good idea at the time.  ;-)
> 
> To be fair, LL/SC does allow allow some things to be done more easily
> than with cmpxchg, since it allows you to tell that the value changed
> even if it later changed back.  Helps with some linked-list operations.

I was being a little harsh in my statements.  I didn't really mind the
LL and SC but a true atomic inc would have been nice.  I actually had to
port Linux to a MIPS board once that didn't have the LL or SC, and that
was even more painful.

> > > > Yep interrupts are threads in CONFIG_PREEMPT_RT.  I guess you could also
> > > > just use local_irq_save with spin_lock, since now local_irq_save no
> > > > longer disables interrupts in PREEMPT_RT.
> > > 
> > > By this you mean the following?
> > > 
> > > 	local_irq_save(flags);
> > > 	_raw_spin_lock(&mylock);
> > > 
> > > 	/* critical section */
> > > 
> > > 	_raw_spin_unlock(&mylock);
> > > 	local_irq_restore(flags);
> > 
> > Yeah, that on PREEMP_RT would not turn off interrupts but just stops
> > preemption. This is fine as long as the mylock is not used in any
> > SA_NODELAY interrupt.
> 
> Cool!  Is the scheduling-clock interrupt an SA_NODELAY interrupt?

If you are talking about scheduler_tick, then yes, it is called by the
timer interrupt which is a SA_NODELAY interrupt.  If you don't want to
get interrupted by the timer interrupt, then you will need to disable
interrupts for both. Since currently, the timer interrupt is the only
true hard interrupt in the PREEMPT_RT and that may not change.

-- Steve


