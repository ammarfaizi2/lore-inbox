Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVCWGTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVCWGTT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 01:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVCWGTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 01:19:19 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:14729 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261185AbVCWGTG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 01:19:06 -0500
Date: Tue, 22 Mar 2005 22:16:01 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050323061601.GE1294@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050320174508.GA3902@us.ibm.com> <20050321085332.GA7163@elte.hu> <20050321090122.GA8066@elte.hu> <20050321090622.GA8430@elte.hu> <20050322054345.GB1296@us.ibm.com> <20050322072413.GA6149@elte.hu> <20050322092331.GA21465@elte.hu> <20050322093201.GA21945@elte.hu> <20050322100153.GA23143@elte.hu> <20050322112856.GA25129@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050322112856.GA25129@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2005 at 12:28:56PM +0100, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > 
> > * Ingo Molnar <mingo@elte.hu> wrote:
> > 
> > > hm, another thing: i think call_rcu() needs to take the read-lock.
> > > Right now it assumes that it has the data structure private, but
> > > that's only statistically true on PREEMPT_RT: another CPU may have
> > > this CPU's RCU control structure in use. So IRQs-off (or preempt-off)
> > > is not a guarantee to have the data structure, the read lock has to be
> > > taken.
> > 
> > i've reworked the code to use the read-lock to access the per-CPU data
> > RCU structures, and it boots with 2 CPUs and PREEMPT_RT now. The
> > -40-05 patch can be downloaded from the usual place:
> 
> bah, it's leaking dentries at a massive scale. I'm giving up on this
> variant for the time being and have gone towards a much simpler variant,
> implemented in the -40-07 patch at:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 
> it's along the lines of Esben's patch, but with the conceptual bug fixed
> via the rcu_read_lock_nesting code from Paul's patch.

Fair enough!

> there's a new CONFIG_PREEMPT_RCU option. (always-enabled on PREEMPT_RT)
> It builds & boots fine on my 2-way box, doesnt leak dentries and
> networking is up and running.
> 
> first question, (ignoring the grace priod problem) is this a correct RCU
> implementation? The critical scenario is when a task gets migrated to
> another CPU, so that current->rcu_data is that of another CPU's. That is
> why ->active_readers is an atomic variable now. [ Note that while
> ->active_readers may be decreased from another CPU, it's always
> increased on the current CPU, so when a preemption-off section
> determines that a quiescent state has passed that determination stays
> true up until it enables preemption again. This is needed for correct
> callback processing. ]

+#ifdef CONFIG_PREEMPT_RCU
+
+void rcu_read_lock(void)
+{
+	if (current->rcu_read_lock_nesting++ == 0) {
+		current->rcu_data = &get_cpu_var(rcu_data);
+		atomic_inc(&current->rcu_data->active_readers);
+		put_cpu_var(rcu_data);

Need an smp_mb() here for non-x86 CPUs.  Otherwise, the CPU can
re-order parts of the critical section to precede the rcu_read_lock().
Could precede the put_cpu_var(), but why increase latency?

+	}
+}
+EXPORT_SYMBOL(rcu_read_lock);
+
+void rcu_read_unlock(void)
+{
+	int cpu;
+
+	if (--current->rcu_read_lock_nesting == 0) {
+		atomic_dec(&current->rcu_data->active_readers);
+		/*
+		 * Check whether we have reached quiescent state.
+		 * Note! This is only for the local CPU, not for
+		 * current->rcu_data's CPU [which typically is the
+		 * current CPU, but may also be another CPU].
+		 */
+		cpu = get_cpu();

And need an smp_mb() here, again for non-x86 CPUs.

+		rcu_qsctr_inc(cpu);
+		put_cpu();
+	}
+}
+EXPORT_SYMBOL(rcu_read_unlock);
+
+#endif

Assuming that the memory barriers are added, I can see a bunch of ways for
races to extend grace periods, but none so far that result in the fatal
too-short grace period.  Since rcu_qsctr_inc() refuses to increment
the quiescent-state counter on any CPU that started an RCU read-side
critical section that has not yet completed, any long critical section
will have a corresponding CPU that will refuse to go through a quiescent
state.  And that will prevent the grace period from completing.

> this implementation has the 'long grace periods' problem. Starvation
> should only be possible if a system has zero idle time for a long period
> of time, and even then it needs the permanent starvation of
> involuntarily preempted rcu-read-locked tasks. Is there any way to force
> such a situation? (which would turn this into a DoS)

If the sum of all the RCU read-side critical sections consumed much more
than 1/N of the CPU time, where N is the number of CPUs, then you would
see infinite grace periods just by statistics.  But my guess is that
you would be in the tens of CPUs before hitting this.  That said, I have
never measured this, since there has not been a reason to care.

> [ in OOM situations we could force quiescent state by walking all tasks
> and checking for nonzero ->rcu_read_lock_nesting values and priority
> boosting affected tasks (to RT prio 99 or RT prio 1), which they'd
> automatically drop when they decrease their rcu_read_lock_nesting
> counter to zero. ]

Makes sense to me.  If there are too-long RCU read-side critical sections,
they could cause other tasks to miss deadlines once boosted.
Of course, if RCU read-side critical sections are all short enough,
you would already just be disabling preemption across all of them.  ;-)

						Thanx, Paul
