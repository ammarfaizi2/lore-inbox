Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263034AbVCXF3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263034AbVCXF3V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 00:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263038AbVCXF3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 00:29:20 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:3030 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263034AbVCXF2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 00:28:50 -0500
Date: Wed, 23 Mar 2005 21:28:54 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050324052854.GA1298@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050321090122.GA8066@elte.hu> <20050321090622.GA8430@elte.hu> <20050322054345.GB1296@us.ibm.com> <20050322072413.GA6149@elte.hu> <20050322092331.GA21465@elte.hu> <20050322093201.GA21945@elte.hu> <20050322100153.GA23143@elte.hu> <20050322112856.GA25129@elte.hu> <20050323061601.GE1294@us.ibm.com> <20050323063317.GB31626@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050323063317.GB31626@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 07:33:17AM +0100, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@us.ibm.com> wrote:
> 
> > +#ifdef CONFIG_PREEMPT_RCU
> > +
> > +void rcu_read_lock(void)
> > +{
> > +	if (current->rcu_read_lock_nesting++ == 0) {
> > +		current->rcu_data = &get_cpu_var(rcu_data);
> > +		atomic_inc(&current->rcu_data->active_readers);
> > +		put_cpu_var(rcu_data);
> > 
> > Need an smp_mb() here for non-x86 CPUs.  Otherwise, the CPU can
> > re-order parts of the critical section to precede the rcu_read_lock().
> > Could precede the put_cpu_var(), but why increase latency?
> 
> ok. It's enough to put a barrier into the else branch here, because the
> atomic op in the main brain is a barrier by itself.

For x86, the atomic op is a barrier, but not for other architectures.
You don't need a barrier in the else branch, because in that case
you are already in an enclosing RCU read-side critical section, so
any bleeding of code will be into this enclosing section, thus still
safe.

> > +void rcu_read_unlock(void)
> > +{
> [...]
> > And need an smp_mb() here, again for non-x86 CPUs.
> 
> ok.
> 
> > Assuming that the memory barriers are added, I can see a bunch of ways
> > for races to extend grace periods, but none so far that result in the
> > fatal too-short grace period.  Since rcu_qsctr_inc() refuses to
> > increment the quiescent-state counter on any CPU that started an RCU
> > read-side critical section that has not yet completed, any long
> > critical section will have a corresponding CPU that will refuse to go
> > through a quiescent state.  And that will prevent the grace period
> > from completing.
> 
> i'm worried about the following scenario: what happens when a task is
> migrated from CPU#1 to CPU#2, while in an RCU read section that it
> acquired on CPU#1, and queues a callback. E.g. d_free() does a
> call_rcu(), to queue the freeing of the dentry.
> 
> That callback will be queued on CPU#2 - while the task still keeps
> current->rcu_data of CPU#1. It also means that CPU#2's read counter did
> _not_ get increased - and a too short grace period may occur.

Let me make sure I understand the sequence of events:

	CPU#1				CPU#2

	task1: rcu_read_lock()

	task1: migrate to CPU#2

					task1: call_rcu()

					task1: rcu_read_unlock()

This sequence will be safe because CPU#1's active_readers field will
be non-zero throughout, so that CPU#1 will refuse to record any
quiescent state from the time that task1 does the rcu_read_lock()
on CPU#1 until the time that it does the rcu_read_unlock() on CPU#2.

Now, it is true that CPU#2 might record a quiescent state during this
time, but this will have no effect because -all- CPUs must pass through
a quiescent state before any callbacks will be invoked.  Since CPU#1
is refusing to record a quiescent state, grace periods will be blocked
for the full extent of task 1's RCU read-side critical section.

Or am I misunderstanding your scenario?  Or, for that matter, your code?

> it seems to me that that only safe method is to pick an 'RCU CPU' when
> first entering the read section, and then sticking to it, no matter
> where the task gets migrated to. Or to 'migrate' the +1 read count from
> one CPU to the other, within the scheduler.

This would work too, but I don't believe it is necessary given what
you are already doing.

> the 'migrate read count' solution seems more promising, as it would keep
> other parts of the RCU code unchanged. [ But it seems to break the nice
> 'flip pointers' method you found to force a grace period. If a 'read
> section' can migrate from one CPU to another then it can migrate back as
> well, at which point it cannot have the 'old' pointer. Maybe it would
> still work better than no flip pointers. ]

Well, I do believe that suppressing migration of tasks during RCU read-side
critical sections would simplify the flip-pointers/counters code.  But
that is easy to say in advance of actually producing this code.  ;-)

							Thanx, Paul
