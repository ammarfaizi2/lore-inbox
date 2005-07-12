Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262316AbVGLT25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbVGLT25 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 15:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVGLT24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 15:28:56 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:14773 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262316AbVGLT2H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 15:28:07 -0400
Date: Tue, 12 Jul 2005 12:28:32 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: shemminger@osdl.org, dipankar@in.ibm.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: PREEMPT/PREEMPT_RT question
Message-ID: <20050712192832.GB1323@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050712163031.GA1323@us.ibm.com> <1121187924.6917.75.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121187924.6917.75.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 01:05:24PM -0400, Steven Rostedt wrote:
> On Tue, 2005-07-12 at 09:30 -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > OK, counter-flip RCU actually survives a pair of overnight runs on
> > CONFIG_PREEMPT running on 4-CPU machines, and also survives five
> > kernbenches and an LTP on another 4-CPU machine.  (Overnight-run script
> > later in this message, FWIW.)
> > 
> > So, time to get serious about a bit of code cleanup:
> > 
> > o	The heavyweight atomic operations in rcu_read_lock() and
> > 	rcu_read_unlock() are not needed in UP kernels, since
> > 	interrupts are disabled.
> > 
> > 	Is there already something like smp_atomic_inc() and
> > 	smp_atomic_dec() that generate atomic_inc()/atomic_dec() in
> > 	SMP kernels, but ++/-- in UP kernels?  If not, any reasons
> > 	not to add them, for example, as follows?
> > 
> > 		#ifdef CONFIG_SMP
> > 		#define smp_atomic_inc(v) atomic_inc(v)
> > 		#define smp_atomic_dec(v) atomic_dec(v)
> > 		#else /* #ifdef CONFIG_SMP */
> > 		#define smp_atomic_inc(v) ((v)++)
> > 		#define smp_atomic_dec(v) ((v)++)
> > 		#endif /* #else #ifdef CONFIG_SMP */
> 
> What's the problem with atomic_inc?  At least on x86, atomic inc is
> defined as:
> 
> static __inline__ void atomic_inc(atomic_t *v)
> {
> 	__asm__ __volatile__(
> 		LOCK "incl %0"
> 		:"=m" (v->counter)
> 		:"m" (v->counter));
> }
> 
> With LOCK defined as:
> 
> #ifdef CONFIG_SMP
> #define LOCK "lock ; "
> #else
> #define LOCK ""
> #endif
> 
> So is there a difference on UP between x.counter++ and atomic_inc(&x)?

On x86, you are right.  The full list of architectures that are atomic
only in SMP are i386 (as you noted), parisc, sparc, and x86_64.

The architectures that appear to always be atomic are: alpha, ia64, m32r
(but unfamiliar with this one), mips, ppc, ppc64, s390 (I think...),
and sparc64.  Most of these architectures need to disable interrupts
to provide "universal" atomic_inc() semantics in UP kernels, due to
their RISC-style atomic instructions.  

The following architectures avoid the issue entirely by refusing to
support SMP: arm, arm26, cris, frv, h8300, m68k, m68knommu, sh, sh64,
and v850.  Many of them disable interrupts in their atomic_inc()
implementations.

The advantage of smp_atomic_inc() is that architectures could dispense
with interrupt disabling.  The disadvantage is that it is yet another
contribution to Linux's combinatorial explosion of primitives.

For the moment, I will grit my teeth and keep atomic_inc() and atomic_dec().

Other thoughts?

> > 	Since interrupts must be disabled for these to be safe,
> > 	my guess is that I should define them locally in rcupdate.c.
> > 	If there turns out to be a general need for them, they can
> > 	be moved somewhere more public.
> > 
> > 	Objections?
> > 
> > o	In order to get things to work in both CONFIG_PREEMPT and
> > 	CONFIG_PREEMPT_RT, I ended up using the following:
> > 
> > 		#ifdef CONFIG_PREEMPT_RT
> > 
> > 		#define rcu_spinlock_t _raw_spinlock_t
> > 		#define rcu_spin_lock(l, f) _raw_spin_lock(l)
> > 		#define rcu_spin_trylock(l, f) _raw_spin_trylock(l)
> > 		#define rcu_spin_unlock(l, f) _raw_spin_unlock(l)
> > 		#define RCU_SPIN_LOCK_UNLOCKED RAW_SPIN_LOCK_UNLOCKED
> > 
> > 		#else /* #ifdef CONFIG_PREEMPT_RT */
> > 
> > 		#define rcu_spinlock_t spinlock_t
> > 		#define rcu_spin_lock(l, f) spin_lock_irqsave(l, f)
> > 		#define rcu_spin_trylock(l, f) spin_trylock_irqsave(l, f)
> > 		#define rcu_spin_unlock(l, f) spin_unlock_irqrestore(l, f)
> > 		#define RCU_SPIN_LOCK_UNLOCKED SPIN_LOCK_UNLOCKED
> > 
> > 		#endif /* #else #ifdef CONFIG_PREEMPT_RT */
> > 
> > 	Then using rcu_spin_lock() &c everywhere.  The problem is
> > 	that (as near as I can tell) the only way to prevent interrupts 
> > 	from running on the current CPU in CONFIG_PREEMPT kernels is
> > 	to use the _irq spinlock primitives, but _raw_spin_lock() does
> > 	the job in CONFIG_PREEMPT_RT (since interrupts are run in process
> > 	context, right).  I could use _irq in both, but that would
> > 	unnecessarily degrade interrupt latency in CONFIG_PREEMPT_RT.
> 
> Yep interrupts are threads in CONFIG_PREEMPT_RT.  I guess you could also
> just use local_irq_save with spin_lock, since now local_irq_save no
> longer disables interrupts in PREEMPT_RT.

By this you mean the following?

	local_irq_save(flags);
	_raw_spin_lock(&mylock);

	/* critical section */

	_raw_spin_unlock(&mylock);
	local_irq_restore(flags);

							Thanx, Paul
