Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262441AbVGLVIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbVGLVIQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 17:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbVGLVFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 17:05:38 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:63149 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262438AbVGLVD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 17:03:56 -0400
Date: Tue, 12 Jul 2005 14:04:23 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com, shemminger@osdl.org
Subject: Re: PREEMPT/PREEMPT_RT question
Message-ID: <20050712210422.GC1323@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050712163031.GA1323@us.ibm.com> <20050712192635.GA28396@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050712192635.GA28396@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 09:26:35PM +0200, Ingo Molnar wrote:
> * Paul E. McKenney <paulmck@us.ibm.com> wrote:
> > So, time to get serious about a bit of code cleanup:
> > 
> > o	The heavyweight atomic operations in rcu_read_lock() and
> > 	rcu_read_unlock() are not needed in UP kernels, since
> > 	interrupts are disabled.
> 
> atomic_*() ops should already be lightweight on UP.

Agreed, will worry about architectures where they might not be later.

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
> > 
> > 	Suggestions???
> 
> in PREEMPT_RT, if you define a spinlock type as raw_spinlock_t (via 
> DEFINE_RAW_SPINLOCK(lock)) then the spin_lock*() APIs automatically 
> switch over to that type. I.e. no need to do the rcu_ stuff AFAICT.  
> (unless i missed some detail about what you are trying to do.) Raw 
> spinlocks under PREEMPT_RT pair with the raw IRQ flag, i.e.  
> spin_lock_irq() will disable hard interrupts. Generally i'd suggest to 
> go for the raw spinlock and raw-irq-flag-disabling variant, because RCU 
> locking is core enough functionality to warrant atomic treatment. If 
> there's any latency path in it, we can work on breaking it up later.

Fair enough!

The thing I am (perhaps foolishly) trying to do is get to a single
source base that provides PREEMPT_RCU under both CONFIG_PREEMPT and
CONFIG_PREEMPT_RT.  Since you are OK with RCU disabling interrupts,
I am happy.

> it's perfectly fine to disable raw interrupts with the RCU code, as long 
> as you do O(1) amount of work. (where the constant factor isnt 2^(2^32) 
> ;-)

Will try to keep it down to a dull roar.  ;-)

> > Some remaining shortcomings of the current code:
> > 
> > o	Untested on CONFIG_PREEMPT_RT (working on this, suggestions
> > 	for 4-CPU-stable CONFIG_PREEMPT_RT versions most welcome).
> 
> latest (-51-28) has no known regressions, and i regularly boot on 4-way 
> (and irregularly on 8-way) boxes. So if you see something strange on the 
> latest -RT kernel, please report it.

And stock -51-7 just passed nine rounds of kernbench + LTP on some 4-CPU
x86 machines, with one still running.  Good stuff!!!

							Thanx, Paul
