Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVGLRKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVGLRKz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 13:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVGLRIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 13:08:10 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:19645 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261704AbVGLRGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 13:06:13 -0400
Subject: Re: PREEMPT/PREEMPT_RT question
From: Steven Rostedt <rostedt@goodmis.org>
To: paulmck@us.ibm.com
Cc: shemminger@osdl.org, dipankar@in.ibm.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050712163031.GA1323@us.ibm.com>
References: <20050712163031.GA1323@us.ibm.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 12 Jul 2005 13:05:24 -0400
Message-Id: <1121187924.6917.75.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-12 at 09:30 -0700, Paul E. McKenney wrote:
> Hello!
> 
> OK, counter-flip RCU actually survives a pair of overnight runs on
> CONFIG_PREEMPT running on 4-CPU machines, and also survives five
> kernbenches and an LTP on another 4-CPU machine.  (Overnight-run script
> later in this message, FWIW.)
> 
> So, time to get serious about a bit of code cleanup:
> 
> o	The heavyweight atomic operations in rcu_read_lock() and
> 	rcu_read_unlock() are not needed in UP kernels, since
> 	interrupts are disabled.
> 
> 	Is there already something like smp_atomic_inc() and
> 	smp_atomic_dec() that generate atomic_inc()/atomic_dec() in
> 	SMP kernels, but ++/-- in UP kernels?  If not, any reasons
> 	not to add them, for example, as follows?
> 
> 		#ifdef CONFIG_SMP
> 		#define smp_atomic_inc(v) atomic_inc(v)
> 		#define smp_atomic_dec(v) atomic_dec(v)
> 		#else /* #ifdef CONFIG_SMP */
> 		#define smp_atomic_inc(v) ((v)++)
> 		#define smp_atomic_dec(v) ((v)++)
> 		#endif /* #else #ifdef CONFIG_SMP */

What's the problem with atomic_inc?  At least on x86, atomic inc is
defined as:

static __inline__ void atomic_inc(atomic_t *v)
{
	__asm__ __volatile__(
		LOCK "incl %0"
		:"=m" (v->counter)
		:"m" (v->counter));
}

With LOCK defined as:

#ifdef CONFIG_SMP
#define LOCK "lock ; "
#else
#define LOCK ""
#endif

So is there a difference on UP between x.counter++ and atomic_inc(&x)?

> 	Since interrupts must be disabled for these to be safe,
> 	my guess is that I should define them locally in rcupdate.c.
> 	If there turns out to be a general need for them, they can
> 	be moved somewhere more public.
> 
> 	Objections?
> 
> o	In order to get things to work in both CONFIG_PREEMPT and
> 	CONFIG_PREEMPT_RT, I ended up using the following:
> 
> 		#ifdef CONFIG_PREEMPT_RT
> 
> 		#define rcu_spinlock_t _raw_spinlock_t
> 		#define rcu_spin_lock(l, f) _raw_spin_lock(l)
> 		#define rcu_spin_trylock(l, f) _raw_spin_trylock(l)
> 		#define rcu_spin_unlock(l, f) _raw_spin_unlock(l)
> 		#define RCU_SPIN_LOCK_UNLOCKED RAW_SPIN_LOCK_UNLOCKED
> 
> 		#else /* #ifdef CONFIG_PREEMPT_RT */
> 
> 		#define rcu_spinlock_t spinlock_t
> 		#define rcu_spin_lock(l, f) spin_lock_irqsave(l, f)
> 		#define rcu_spin_trylock(l, f) spin_trylock_irqsave(l, f)
> 		#define rcu_spin_unlock(l, f) spin_unlock_irqrestore(l, f)
> 		#define RCU_SPIN_LOCK_UNLOCKED SPIN_LOCK_UNLOCKED
> 
> 		#endif /* #else #ifdef CONFIG_PREEMPT_RT */
> 
> 	Then using rcu_spin_lock() &c everywhere.  The problem is
> 	that (as near as I can tell) the only way to prevent interrupts 
> 	from running on the current CPU in CONFIG_PREEMPT kernels is
> 	to use the _irq spinlock primitives, but _raw_spin_lock() does
> 	the job in CONFIG_PREEMPT_RT (since interrupts are run in process
> 	context, right).  I could use _irq in both, but that would
> 	unnecessarily degrade interrupt latency in CONFIG_PREEMPT_RT.

Yep interrupts are threads in CONFIG_PREEMPT_RT.  I guess you could also
just use local_irq_save with spin_lock, since now local_irq_save no
longer disables interrupts in PREEMPT_RT.

-- Steve


