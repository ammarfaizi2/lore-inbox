Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbWG0Aiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbWG0Aiu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 20:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWG0Aiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 20:38:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:44884 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750835AbWG0Ait (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 20:38:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=CBEykWuLYYEi/VsJLFlvDx4f4LlBASjAqfpbVKb8qH4XJzF+Q9Fyx79abPleqXlhgrJiMoEeS7nI6heCuLiUafCFsF1vRTuKVI6hMuZcvWtq6Tq3PsJd2TUjyEllmQ2sOiFGBB2nNzS1ieKkL7RLYuJ3RXqf6iC7qRdswssbwI8=
Date: Thu, 27 Jul 2006 02:39:07 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: linux-kernel@vger.kernel.org, nielsen.esben@googlemail.com,
       compudj@krystal.dyndns.org, billh@gnuppy.monkey.org,
       billh@gnuppy.monkey.org, rostedt@goodmis.org, tglx@linutronix.de,
       mingo@elte.hu, dipankar@in.ibm.com, rusty@au1.ibm.com
Subject: Re: [RFC, PATCH -rt] NMI-safe mb- and atomic-free RT RCU
In-Reply-To: <20060726001733.GA1953@us.ibm.com>
Message-ID: <Pine.LNX.4.64.0607262202560.15681@localhost.localdomain>
References: <20060726001733.GA1953@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 Jul 2006, Paul E. McKenney wrote:

> Not for inclusion, should be viewed with great suspicion.
>
> This patch provides an NMI-safe realtime RCU.  Hopefully, Mathieu can
> make use of synchronize_sched() instead, since I have not yet figured
> out a way to make this NMI-safe and still get rid of the interrupt
> disabling.  ;-)
>
> 						Thanx, Paul

I must say I don't understand all this. It looks very complicated. Is it 
really needed?

I have been thinking about the following design:

void rcu_read_lock()
{
 	if (!in_interrupt())
 		current->rcu_read_lock_count++;
}
void rcu_read_unlock()
{
 	if (!in_interrupt())
 		current->rcu_read_lock_count--;
}

Somewhere in schedule():

 	rq->rcu_read_lock_count += prev->rcu_read_lock_count;
 	if (!rq->rcu_read_lock_count)
 		forward_waiting_rcu_jobs();
 	rq->rcu_read_lock_count -= next->rcu_read_lock_count;

Now what should forward_waiting_rcu_jobs() do?

I imagine a circular datastructur of all the CPUs. When a call_rcu() is 
run on a CPU it is first added a list of jobs for that CPU. When 
forward_waiting_rcu_jobs() is called all the pending jobs are forwarded to 
the next CPU. The next CPU will bring it along the next CPU in the circle 
along with it's own jobs. When jobs hit the original CPU they will be 
executed. Or rather, when the CPU just before calls 
forward_waiting_rcu_jobs(), it sends the jobs belonging to the next CPU to 
the RCU-task of the next CPU, where they will be executed, instead of to 
the scheduler (runqueue) of the next CPU, where it will just be send out on a
new roundtrip along the circle.

If you use a structure like the plist then the forwarding procedure can be 
done in O(number of online CPUs) time worst case - much less in the usual 
case where the lists are almost empty.

Now the problem is: What happens if a task in a rcu read-side lock is 
migrated? Then the rcu_read_lock_count on the source CPU will stay in plus 
while on the target CPU it will go in minus. This ought to be simply 
fixeable by adding task->rcu_read_lock_count to the target runqueue before 
migrating and subtracting it from the old runqueue after migrating. But 
there is another problem: RCU-jobs refering to data used by the task being 
migrated might have been forwarded from the target CPU. Thus the migration
task have to go back along the circle of CPUs and move all the relevant
RCU-jobs back to the target CPU to be forwarded again. This is also doable in
number of CPUs between source and target times O(<number of online CPUs>)
(see above) time.

To avoid a task in a read-side lock being starved for too long the 
following line can be added to normal_prio():
   if (p->rcu_read_lock_count)
 	p->prio = MAX_RT_PRIO;

I don't have time to code this nor a SMP machine to test it on. But I can 
give the idea to you anyways in the hope you might code it :-)

Esben


>
> Signed-off-by: Paul E. McKenney <paulmck@us.ibm.com> (but please don't apply)
>
> include/linux/sched.h |    3
> kernel/rcupreempt.c   |  577 ++++++++++++++++++++++++++++++++++++++++----------
> 2 files changed, 470 insertions(+), 110 deletions(-)
>
> diff -urpNa -X dontdiff linux-2.6.17-rt7/include/linux/sched.h linux-2.6.17-rt7-norrupt/include/linux/sched.h
> --- linux-2.6.17-rt7/include/linux/sched.h	2006-07-19 01:43:09.000000000 -0700
> +++ linux-2.6.17-rt7-norrupt/include/linux/sched.h	2006-07-22 15:44:36.000000000 -0700
> @@ -868,8 +868,7 @@ struct task_struct {
>
> #ifdef CONFIG_PREEMPT_RCU
> 	int rcu_read_lock_nesting;
> -	atomic_t *rcu_flipctr1;
> -	atomic_t *rcu_flipctr2;
> +	int rcu_flipctr_idx;
> #endif
> #ifdef CONFIG_SCHEDSTATS
> 	struct sched_info sched_info;
> diff -urpNa -X dontdiff linux-2.6.17-rt7/kernel/rcupreempt.c linux-2.6.17-rt7-norrupt/kernel/rcupreempt.c
> --- linux-2.6.17-rt7/kernel/rcupreempt.c	2006-07-19 01:43:09.000000000 -0700
> +++ linux-2.6.17-rt7-norrupt/kernel/rcupreempt.c	2006-07-22 20:21:46.000000000 -0700
> @@ -15,11 +15,13 @@
>  * along with this program; if not, write to the Free Software
>  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
>  *
> - * Copyright (C) IBM Corporation, 2001
> + * Copyright (C) IBM Corporation, 2006
>  *
>  * Authors: Paul E. McKenney <paulmck@us.ibm.com>
>  *		With thanks to Esben Nielsen, Bill Huey, and Ingo Molnar
> - *		for pushing me away from locks and towards counters.
> + *		for pushing me away from locks and towards counters, and
> + *		to Suparna Bhattacharya for pushing me completely away
> + *		from atomic instructions on the read side.
>  *
>  * Papers:  http://www.rdrop.com/users/paulmck/RCU
>  *
> @@ -73,12 +75,20 @@ struct rcu_data {
> 	long		n_done_remove;
> 	atomic_t	n_done_invoked;
> 	long		n_rcu_check_callbacks;
> -	atomic_t	n_rcu_try_flip1;
> -	long		n_rcu_try_flip2;
> -	long		n_rcu_try_flip3;
> +	atomic_t	n_rcu_try_flip_1;
> 	atomic_t	n_rcu_try_flip_e1;
> -	long		n_rcu_try_flip_e2;
> -	long		n_rcu_try_flip_e3;
> +	long		n_rcu_try_flip_i1;
> +	long		n_rcu_try_flip_ie1;
> +	long		n_rcu_try_flip_g1;
> +	long		n_rcu_try_flip_a1;
> +	long		n_rcu_try_flip_ae1;
> +	long		n_rcu_try_flip_a2;
> +	long		n_rcu_try_flip_z1;
> +	long		n_rcu_try_flip_ze1;
> +	long		n_rcu_try_flip_z2;
> +	long		n_rcu_try_flip_m1;
> +	long		n_rcu_try_flip_me1;
> +	long		n_rcu_try_flip_m2;
> #endif /* #ifdef CONFIG_RCU_STATS */
> };
> struct rcu_ctrlblk {
> @@ -90,8 +100,51 @@ static struct rcu_ctrlblk rcu_ctrlblk =
> 	.fliplock = RAW_SPIN_LOCK_UNLOCKED,
> 	.completed = 0,
> };
> -static DEFINE_PER_CPU(atomic_t [2], rcu_flipctr) =
> -	{ ATOMIC_INIT(0), ATOMIC_INIT(0) };
> +static DEFINE_PER_CPU(int [2], rcu_flipctr) = { 0, 0 };
> +
> +/*
> + * States for rcu_try_flip() and friends.
> + */
> +
> +enum rcu_try_flip_states {
> +	rcu_try_flip_idle_state,	/* "I" */
> +	rcu_try_flip_in_gp_state,	/* "G" */
> +	rcu_try_flip_waitack_state, 	/* "A" */
> +	rcu_try_flip_waitzero_state,	/* "Z" */
> +	rcu_try_flip_waitmb_state	/* "M" */
> +};
> +static enum rcu_try_flip_states rcu_try_flip_state = rcu_try_flip_idle_state;
> +#ifdef CONFIG_RCU_STATS
> +static char *rcu_try_flip_state_names[] =
> +	{ "idle", "gp", "waitack", "waitzero", "waitmb" };
> +#endif /* #ifdef CONFIG_RCU_STATS */
> +
> +/*
> + * Enum and per-CPU flag to determine when each CPU has seen
> + * the most recent counter flip.
> + */
> +
> +enum rcu_flip_flag_values {
> +	rcu_flip_seen,		/* Steady/initial state, last flip seen. */
> +				/* Only GP detector can update. */
> +	rcu_flipped		/* Flip just completed, need confirmation. */
> +				/* Only corresponding CPU can update. */
> +};
> +static DEFINE_PER_CPU(enum rcu_flip_flag_values, rcu_flip_flag) = rcu_flip_seen;
> +
> +/*
> + * Enum and per-CPU flag to determine when each CPU has executed the
> + * needed memory barrier to fence in memory references from its last RCU
> + * read-side critical section in the just-completed grace period.
> + */
> +
> +enum rcu_mb_flag_values {
> +	rcu_mb_done,		/* Steady/initial state, no mb()s required. */
> +				/* Only GP detector can update. */
> +	rcu_mb_needed		/* Flip just completed, need an mb(). */
> +				/* Only corresponding CPU can update. */
> +};
> +static DEFINE_PER_CPU(enum rcu_mb_flag_values, rcu_mb_flag) = rcu_mb_done;
>
> /*
>  * Return the number of RCU batches processed thus far.  Useful
> @@ -105,93 +158,182 @@ long rcu_batches_completed(void)
> void
> rcu_read_lock(void)
> {
> -	int flipctr;
> +	int idx;
> +	int nesting;
> 	unsigned long oldirq;
>
> -	local_irq_save(oldirq);
> -
> +	raw_local_irq_save(oldirq);
> 	trace_special(current->rcu_read_lock_nesting,
> 		      (unsigned long) current->rcu_flipctr1,
> 		      rcu_ctrlblk.completed);
> -	if (current->rcu_read_lock_nesting++ == 0) {
> +
> +	nesting = current->rcu_read_lock_nesting;
> +
> +	/*
> +	 * Any rcu_read_lock()s called from NMI handlers
> +	 * at any point must have matching rcu_read_unlock()
> +	 * calls in that same handler, so we will not see the
> +	 * value of current->rcu_read_lock_nesting change.
> +	 */
> +
> +	if (nesting != 0) {
>
> 		/*
> -		 * Outermost nesting of rcu_read_lock(), so atomically
> +		 * There is an enclosing rcu_read_lock(), so all we
> +		 * need to do is to increment the counter.
> +		 */
> +
> +		current->rcu_read_lock_nesting = nesting + 1;
> +
> +	} else {
> +
> +		/*
> +		 * Outermost nesting of rcu_read_lock(), so we must
> 		 * increment the current counter for the current CPU.
> +		 * This must be done carefully, because NMIs can
> +		 * occur at any point in this code, and any rcu_read_lock()
> +		 * and rcu_read_unlock() pairs in the NMI handlers
> +		 * must interact non-destructively with this code.
> +		 * Lots of barrier() calls, and -very- careful ordering.
> +		 *
> +		 * Changes to this code, including this one, must be
> +		 * inspected, validated, and tested extremely carefully!!!
> 		 */
>
> -		flipctr = rcu_ctrlblk.completed & 0x1;
> +		/*
> +		 * First, pick up the index.  Enforce ordering for
> +		 * both compilers and for DEC Alpha.
> +		 */
> +
> +		idx = rcu_ctrlblk.completed & 0x1;
> 		smp_read_barrier_depends();
> -		current->rcu_flipctr1 = &(__get_cpu_var(rcu_flipctr)[flipctr]);
> -		/* Can optimize to non-atomic on fastpath, but start simple. */
> -		atomic_inc(current->rcu_flipctr1);
> -		smp_mb__after_atomic_inc();  /* might optimize out... */
> -		if (unlikely(flipctr != (rcu_ctrlblk.completed & 0x1))) {
> -
> -			/*
> -			 * We raced with grace-period processing (flip).
> -			 * Although we cannot be preempted here, there
> -			 * could be interrupts, ECC errors and the like,
> -			 * so just nail down both sides of the rcu_flipctr
> -			 * array for the duration of our RCU read-side
> -			 * critical section, preventing a second flip
> -			 * from racing with us.  At some point, it would
> -			 * be safe to decrement one of the counters, but
> -			 * we have no way of knowing when that would be.
> -			 * So just decrement them both in rcu_read_unlock().
> -			 */
> -
> -			current->rcu_flipctr2 =
> -				&(__get_cpu_var(rcu_flipctr)[!flipctr]);
> -			/* Can again optimize to non-atomic on fastpath. */
> -			atomic_inc(current->rcu_flipctr2);
> -			smp_mb__after_atomic_inc();  /* might optimize out... */
> -		}
> +		barrier();
> +
> +		/*
> +		 * Increment the per-CPU counter. NMI handlers
> +		 * might increment it as well, but they had better
> +		 * properly nest their rcu_read_lock()/rcu_read_unlock()
> +		 * pairs so that the value is restored before the handler
> +		 * returns to us.  Enforce ordering for compilers.
> +		 */
> +
> +		__get_cpu_var(rcu_flipctr)[idx]++;
> +		barrier();
> +
> +		/*
> +		 * It is now safe to increment the task's nesting count.
> +		 * NMIs that occur after this statement will route
> +		 * their rcu_read_lock() calls through the "then" clause
> +		 * of this "if" statement, and thus will no longer come
> +		 * through this path.  Enforce ordering for compilers.
> +		 */
> +
> +		current->rcu_read_lock_nesting = nesting + 1;
> +		barrier();
> +
> +		/*
> +		 * It is now safe to store the index into our task
> +		 * structure.  Doing so earlier would have resulted
> +		 * in it getting clobbered by NMI handlers.
> +		 */
> +
> +		current->rcu_flipctr_idx = idx;
> 	}
> +
> 	trace_special((unsigned long) current->rcu_flipctr1,
> 		      (unsigned long) current->rcu_flipctr2,
> 		      rcu_ctrlblk.completed);
> -	local_irq_restore(oldirq);
> +	raw_local_irq_restore(oldirq);
> }
>
> void
> rcu_read_unlock(void)
> {
> +	int idx;
> +	int nesting;
> 	unsigned long oldirq;
>
> -	local_irq_save(oldirq);
> +	raw_local_irq_save(oldirq);
> 	trace_special((unsigned long) current->rcu_flipctr1,
> 		      (unsigned long) current->rcu_flipctr2,
> 		      current->rcu_read_lock_nesting);
> -	if (--current->rcu_read_lock_nesting == 0) {
> +
> +	nesting = current->rcu_read_lock_nesting;
> +
> +	/*
> +	 * Any rcu_read_lock()s called from NMI handlers
> +	 * at any point must have matching rcu_read_unlock()
> +	 * calls in that same handler, so we will not see the
> +	 * value of current->rcu_read_lock_nesting change.
> +	 */
> +
> +	if (nesting > 1) {
>
> 		/*
> -		 * Just atomically decrement whatever we incremented.
> -		 * Might later want to awaken some task waiting for the
> -		 * grace period to complete, but keep it simple for the
> -		 * moment.
> +		 * There is an enclosing rcu_read_lock(), so all we
> +		 * need to do is to decrement the counter.
> 		 */
>
> -		smp_mb__before_atomic_dec();
> -		atomic_dec(current->rcu_flipctr1);
> -		current->rcu_flipctr1 = NULL;
> -		if (unlikely(current->rcu_flipctr2 != NULL)) {
> -			atomic_dec(current->rcu_flipctr2);
> -			current->rcu_flipctr2 = NULL;
> -		}
> +		current->rcu_read_lock_nesting = nesting - 1;
> +
> +	} else {
> +
> +		/*
> +		 * Outermost nesting of rcu_read_unlock(), so we must
> +		 * decrement the current counter for the current CPU.
> +		 * This must be done carefully, because NMIs can
> +		 * occur at any point in this code, and any rcu_read_lock()
> +		 * and rcu_read_unlock() pairs in the NMI handlers
> +		 * must interact non-destructively with this code.
> +		 * Lots of barrier() calls, and -very- careful ordering.
> +		 *
> +		 * Changes to this code, including this one, must be
> +		 * inspected, validated, and tested extremely carefully!!!
> +		 */
> +
> +		/*
> +		 * First, pick up the index.  Enforce ordering for
> +		 * both compilers and for DEC Alpha.
> +		 */
> +
> +		idx = current->rcu_flipctr_idx;
> +		smp_read_barrier_depends();
> +		barrier();
> +
> +		/*
> +		 * It is now safe to decrement the task's nesting count.
> +		 * NMIs that occur after this statement will route
> +		 * their rcu_read_lock() calls through this "else" clause
> +		 * of this "if" statement, and thus will start incrementing
> +		 * the per-CPU counter on their own.  Enforce ordering for
> +		 * compilers.
> +		 */
> +
> +		current->rcu_read_lock_nesting = nesting - 1;
> +		barrier();
> +
> +		/*
> +		 * Decrement the per-CPU counter. NMI handlers
> +		 * might increment it as well, but they had better
> +		 * properly nest their rcu_read_lock()/rcu_read_unlock()
> +		 * pairs so that the value is restored before the handler
> +		 * returns to us.
> +		 */
> +
> +		__get_cpu_var(rcu_flipctr)[idx]--;
> 	}
>
> 	trace_special((unsigned long)current->rcu_flipctr1,
> 		      (unsigned long) current->rcu_flipctr2,
> 		      current->rcu_read_lock_nesting);
> -	local_irq_restore(oldirq);
> +	raw_local_irq_restore(oldirq);
> }
>
> static void
> __rcu_advance_callbacks(void)
> {
>
> -	if (rcu_data.completed != rcu_ctrlblk.completed) {
> +	if ((rcu_data.completed >> 1) != (rcu_ctrlblk.completed >> 1)) {
> 		if (rcu_data.waitlist != NULL) {
> 			*rcu_data.donetail = rcu_data.waitlist;
> 			rcu_data.donetail = rcu_data.waittail;
> @@ -216,13 +358,186 @@ __rcu_advance_callbacks(void)
> 			rcu_data.waittail = &rcu_data.waitlist;
> 		}
> 		rcu_data.completed = rcu_ctrlblk.completed;
> +	} else if (rcu_data.completed != rcu_ctrlblk.completed) {
> +		rcu_data.completed = rcu_ctrlblk.completed;
> +	}
> +}
> +
> +/*
> + * Get here when RCU is idle.  Decide whether we need to
> + * move out of idle state, and return zero if so.
> + * "Straightforward" approach for the moment, might later
> + * use callback-list lengths, grace-period duration, or
> + * some such to determine when to exit idle state.
> + * Might also need a pre-idle test that does not acquire
> + * the lock, but let's get the simple case working first...
> + */
> +
> +static int
> +rcu_try_flip_idle(int flipctr)
> +{
> +#ifdef CONFIG_RCU_STATS
> +	rcu_data.n_rcu_try_flip_i1++;
> +#endif /* #ifdef CONFIG_RCU_STATS */
> +
> +	if (!rcu_pending(smp_processor_id())) {
> +#ifdef CONFIG_RCU_STATS
> +		rcu_data.n_rcu_try_flip_ie1++;
> +#endif /* #ifdef CONFIG_RCU_STATS */
> +		return 1;
> 	}
> +	return 0;
> +}
> +
> +/*
> + * Flip processing up to and including the flip, as well as
> + * telling CPUs to acknowledge the flip.
> + */
> +
> +static int
> +rcu_try_flip_in_gp(int flipctr)
> +{
> +	int cpu;
> +
> +#ifdef CONFIG_RCU_STATS
> +	rcu_data.n_rcu_try_flip_g1++;
> +#endif /* #ifdef CONFIG_RCU_STATS */
> +
> +	/*
> +	 * Do the flip.
> +	 */
> +
> +	rcu_ctrlblk.completed++;  /* stands in for rcu_try_flip_g2 */
> +
> +	/*
> +	 * Need a memory barrier so that other CPUs see the new
> +	 * counter value before they see the subsequent change of all
> +	 * the rcu_flip_flag instances to rcu_flipped.
> +	 */
> +
> +	smp_mb();
> +
> +	/* Now ask each CPU for acknowledgement of the flip. */
> +
> +	for_each_cpu(cpu)
> +		per_cpu(rcu_flip_flag, cpu) = rcu_flipped;
> +
> +	return 0;
> +}
> +
> +/*
> + * Wait for CPUs to acknowledge the flip.
> + */
> +
> +static int
> +rcu_try_flip_waitack(int flipctr)
> +{
> +	int cpu;
> +
> +#ifdef CONFIG_RCU_STATS
> +	rcu_data.n_rcu_try_flip_a1++;
> +#endif /* #ifdef CONFIG_RCU_STATS */
> +
> +	for_each_cpu(cpu)
> +		if (per_cpu(rcu_flip_flag, cpu) != rcu_flip_seen) {
> +#ifdef CONFIG_RCU_STATS
> +			rcu_data.n_rcu_try_flip_ae1++;
> +#endif /* #ifdef CONFIG_RCU_STATS */
> +			return 1;
> +		}
> +
> +	/*
> +	 * Make sure our checks above don't bleed into subsequent
> +	 * waiting for the sum of the counters to reach zero.
> +	 */
> +
> +	smp_mb();
> +
> +#ifdef CONFIG_RCU_STATS
> +	rcu_data.n_rcu_try_flip_a2++;
> +#endif /* #ifdef CONFIG_RCU_STATS */
> +
> +	return 0;
> +}
> +
> +/*
> + * Wait for collective ``last'' counter to reach zero,
> + * then tell all CPUs to do an end-of-grace-period memory barrier.
> + */
> +
> +static int
> +rcu_try_flip_waitzero(int flipctr)
> +{
> +	int cpu;
> +	int lastidx = !(flipctr & 0x1);
> +	int sum = 0;
> +
> +#ifdef CONFIG_RCU_STATS
> +	rcu_data.n_rcu_try_flip_z1++;
> +#endif /* #ifdef CONFIG_RCU_STATS */
> +
> +	/* Check to see if the sum of the "last" counters is zero. */
> +
> +	for_each_cpu(cpu)
> +		sum += per_cpu(rcu_flipctr, cpu)[lastidx];
> +	if (sum != 0) {
> +#ifdef CONFIG_RCU_STATS
> +		rcu_data.n_rcu_try_flip_ze1++;
> +#endif /* #ifdef CONFIG_RCU_STATS */
> +		return 1;
> +	}
> +
> +#ifdef CONFIG_RCU_STATS
> +	rcu_data.n_rcu_try_flip_z2++;
> +#endif /* #ifdef CONFIG_RCU_STATS */
> +
> +	/* Make sure we don't call for memory barriers before we see zero. */
> +
> +	smp_mb();
> +
> +	/* Call for a memory barrier from each CPU. */
> +
> +	for_each_cpu(cpu)
> +		per_cpu(rcu_mb_flag, cpu) = rcu_mb_needed;
> +
> +	return 0;
> +}
> +
> +/*
> + * Wait for all CPUs to do their end-of-grace-period memory barrier.
> + * Return 0 once all CPUs have done so.
> + */
> +
> +static int
> +rcu_try_flip_waitmb(int flipctr)
> +{
> +	int cpu;
> +
> +#ifdef CONFIG_RCU_STATS
> +	rcu_data.n_rcu_try_flip_m1++;
> +#endif /* #ifdef CONFIG_RCU_STATS */
> +
> +	for_each_cpu(cpu)
> +		if (per_cpu(rcu_mb_flag, cpu) != rcu_mb_done) {
> +#ifdef CONFIG_RCU_STATS
> +			rcu_data.n_rcu_try_flip_me1++;
> +#endif /* #ifdef CONFIG_RCU_STATS */
> +			return 1;
> +		}
> +
> +	smp_mb(); /* Ensure that the above checks precede any following flip. */
> +
> +#ifdef CONFIG_RCU_STATS
> +	rcu_data.n_rcu_try_flip_m2++;
> +#endif /* #ifdef CONFIG_RCU_STATS */
> +
> +	return 0;
> }
>
> /*
>  * Attempt a single flip of the counters.  Remember, a single flip does
>  * -not- constitute a grace period.  Instead, the interval between
> - * a pair of consecutive flips is a grace period.
> + * at least three consecutive flips is a grace period.
>  *
>  * If anyone is nuts enough to run this CONFIG_PREEMPT_RCU implementation
>  * on a large SMP, they might want to use a hierarchical organization of
> @@ -231,13 +546,11 @@ __rcu_advance_callbacks(void)
> static void
> rcu_try_flip(void)
> {
> -	int cpu;
> 	long flipctr;
> 	unsigned long oldirq;
>
> -	flipctr = rcu_ctrlblk.completed;
> #ifdef CONFIG_RCU_STATS
> -	atomic_inc(&rcu_data.n_rcu_try_flip1);
> +	atomic_inc(&rcu_data.n_rcu_try_flip_1);
> #endif /* #ifdef CONFIG_RCU_STATS */
> 	if (unlikely(!spin_trylock_irqsave(&rcu_ctrlblk.fliplock, oldirq))) {
> #ifdef CONFIG_RCU_STATS
> @@ -245,52 +558,82 @@ rcu_try_flip(void)
> #endif /* #ifdef CONFIG_RCU_STATS */
> 		return;
> 	}
> -	if (unlikely(flipctr != rcu_ctrlblk.completed)) {
> -
> -		/* Our work is done!  ;-) */
> -
> -#ifdef CONFIG_RCU_STATS
> -		rcu_data.n_rcu_try_flip_e2++;
> -#endif /* #ifdef CONFIG_RCU_STATS */
> -		spin_unlock_irqrestore(&rcu_ctrlblk.fliplock, oldirq);
> -		return;
> -	}
> -	flipctr &= 0x1;
>
> 	/*
> -	 * Check for completion of all RCU read-side critical sections
> -	 * that started prior to the previous flip.
> +	 * Take the next transition(s) through the RCU grace-period
> +	 * flip-counter state machine.
> 	 */
>
> -#ifdef CONFIG_RCU_STATS
> -	rcu_data.n_rcu_try_flip2++;
> -#endif /* #ifdef CONFIG_RCU_STATS */
> -	for_each_cpu(cpu) {
> -		if (atomic_read(&per_cpu(rcu_flipctr, cpu)[!flipctr]) != 0) {
> -#ifdef CONFIG_RCU_STATS
> -			rcu_data.n_rcu_try_flip_e3++;
> -#endif /* #ifdef CONFIG_RCU_STATS */
> -			spin_unlock_irqrestore(&rcu_ctrlblk.fliplock, oldirq);
> -			return;
> -		}
> +	flipctr = rcu_ctrlblk.completed;
> +	switch (rcu_try_flip_state) {
> +	case rcu_try_flip_idle_state:
> +		if (rcu_try_flip_idle(flipctr))
> +			break;
> +		rcu_try_flip_state = rcu_try_flip_in_gp_state;
> +	case rcu_try_flip_in_gp_state:
> +		if (rcu_try_flip_in_gp(flipctr))
> +			break;
> +		rcu_try_flip_state = rcu_try_flip_waitack_state;
> +	case rcu_try_flip_waitack_state:
> +		if (rcu_try_flip_waitack(flipctr))
> +			break;
> +		rcu_try_flip_state = rcu_try_flip_waitzero_state;
> +	case rcu_try_flip_waitzero_state:
> +		if (rcu_try_flip_waitzero(flipctr))
> +			break;
> +		rcu_try_flip_state = rcu_try_flip_waitmb_state;
> +	case rcu_try_flip_waitmb_state:
> +		if (rcu_try_flip_waitmb(flipctr))
> +			break;
> +		rcu_try_flip_state = rcu_try_flip_idle_state;
> 	}
> +	spin_unlock_irqrestore(&rcu_ctrlblk.fliplock, oldirq);
> +}
>
> -	/* Do the flip. */
> +/*
> + * Check to see if this CPU needs to report that it has seen the most
> + * recent counter flip, thereby declaring that all subsequent
> + * rcu_read_lock() invocations will respect this flip.
> + */
>
> -	smp_mb();
> -	rcu_ctrlblk.completed++;
> +static void
> +rcu_check_flipseen(int cpu)
> +{
> +	if (per_cpu(rcu_flip_flag, cpu) == rcu_flipped) {
> +		smp_mb();  /* Subsequent counter acccesses must see new value */
> +		per_cpu(rcu_flip_flag, cpu) = rcu_flip_seen;
> +		smp_mb();  /* probably be implied by interrupt, but... */
> +	}
> +}
>
> -#ifdef CONFIG_RCU_STATS
> -	rcu_data.n_rcu_try_flip3++;
> -#endif /* #ifdef CONFIG_RCU_STATS */
> -	spin_unlock_irqrestore(&rcu_ctrlblk.fliplock, oldirq);
> +/*
> + * Check to see if this CPU needs to do a memory barrier in order to
> + * ensure that any prior RCU read-side critical sections have committed
> + * their counter manipulations and critical-section memory references
> + * before declaring the grace period to be completed.
> + */
> +
> +static void
> +rcu_check_mb(int cpu)
> +{
> +	if (per_cpu(rcu_mb_flag, cpu) == rcu_mb_needed) {
> +		smp_mb();
> +		per_cpu(rcu_mb_flag, cpu) = rcu_mb_done;
> +	}
> }
>
> +/*
> + * This function is called periodically on each CPU in hardware interrupt
> + * context.
> + */
> +
> void
> rcu_check_callbacks(int cpu, int user)
> {
> 	unsigned long oldirq;
>
> +	rcu_check_flipseen(cpu);
> +	rcu_check_mb(cpu);
> 	if (rcu_ctrlblk.completed == rcu_data.completed) {
> 		rcu_try_flip();
> 		if (rcu_ctrlblk.completed == rcu_data.completed) {
> @@ -359,10 +702,10 @@ call_rcu(struct rcu_head *head,
> }
>
> /*
> - * Crude hack, reduces but does not eliminate possibility of failure.
> - * Needs to wait for all CPUs to pass through a -voluntary- context
> - * switch to eliminate possibility of failure.  (Maybe just crank
> - * priority down...)
> + * Wait until all currently running preempt_disable() code segments
> + * (including hardware-irq-disable segments) complete.  Note that
> + * in -rt this does -not- necessarily result in all currently executing
> + * interrupt -handlers- having completed.
>  */
> void
> synchronize_sched(void)
> @@ -390,7 +733,7 @@ rcu_pending(int cpu)
>
> void __init rcu_init(void)
> {
> -/*&&&&*/printk("WARNING: experimental RCU implementation.\n");
> +/*&&&&*/printk("WARNING: experimental non-atomic RCU implementation.\n");
> 	spin_lock_init(&rcu_data.lock);
> 	rcu_data.completed = 0;
> 	rcu_data.nextlist = NULL;
> @@ -416,7 +759,8 @@ int rcu_read_proc_data(char *page)
> 	return sprintf(page,
> 		       "ggp=%ld lgp=%ld rcc=%ld\n"
> 		       "na=%ld nl=%ld wa=%ld wl=%ld da=%ld dl=%ld dr=%ld di=%d\n"
> -		       "rtf1=%d rtf2=%ld rtf3=%ld rtfe1=%d rtfe2=%ld rtfe3=%ld\n",
> +		       "1=%d e1=%d i1=%ld ie1=%ld g1=%ld a1=%ld ae1=%ld a2=%ld\n"
> +		       "z1=%ld ze1=%ld z2=%ld m1=%ld me1=%ld m2=%ld\n",
>
> 		       rcu_ctrlblk.completed,
> 		       rcu_data.completed,
> @@ -431,12 +775,20 @@ int rcu_read_proc_data(char *page)
> 		       rcu_data.n_done_remove,
> 		       atomic_read(&rcu_data.n_done_invoked),
>
> -		       atomic_read(&rcu_data.n_rcu_try_flip1),
> -		       rcu_data.n_rcu_try_flip2,
> -		       rcu_data.n_rcu_try_flip3,
> +		       atomic_read(&rcu_data.n_rcu_try_flip_1),
> 		       atomic_read(&rcu_data.n_rcu_try_flip_e1),
> -		       rcu_data.n_rcu_try_flip_e2,
> -		       rcu_data.n_rcu_try_flip_e3);
> +		       rcu_data.n_rcu_try_flip_i1,
> +		       rcu_data.n_rcu_try_flip_ie1,
> +		       rcu_data.n_rcu_try_flip_g1,
> +		       rcu_data.n_rcu_try_flip_a1,
> +		       rcu_data.n_rcu_try_flip_ae1,
> +		       rcu_data.n_rcu_try_flip_a2,
> +		       rcu_data.n_rcu_try_flip_z1,
> +		       rcu_data.n_rcu_try_flip_ze1,
> +		       rcu_data.n_rcu_try_flip_z2,
> +		       rcu_data.n_rcu_try_flip_m1,
> +		       rcu_data.n_rcu_try_flip_me1,
> +		       rcu_data.n_rcu_try_flip_m2);
> }
>
> int rcu_read_proc_gp_data(char *page)
> @@ -464,14 +816,23 @@ int rcu_read_proc_ctrs_data(char *page)
> 	int cpu;
> 	int f = rcu_data.completed & 0x1;
>
> -	cnt += sprintf(&page[cnt], "CPU last cur\n");
> +	cnt += sprintf(&page[cnt], "CPU last cur F M\n");
> 	for_each_cpu(cpu) {
> -		cnt += sprintf(&page[cnt], "%3d %4d %3d\n",
> +		cnt += sprintf(&page[cnt], "%3d %4d %3d %d %d\n",
> 			       cpu,
> -			       atomic_read(&per_cpu(rcu_flipctr, cpu)[!f]),
> -			       atomic_read(&per_cpu(rcu_flipctr, cpu)[f]));
> -	}
> -	cnt += sprintf(&page[cnt], "ggp = %ld\n", rcu_data.completed);
> +			       per_cpu(rcu_flipctr, cpu)[!f],
> +			       per_cpu(rcu_flipctr, cpu)[f],
> +			       per_cpu(rcu_flip_flag, cpu),
> +			       per_cpu(rcu_mb_flag, cpu));
> +	}
> +	cnt += sprintf(&page[cnt], "ggp = %ld, state = %d",
> +		       rcu_data.completed, rcu_try_flip_state);
> +	if ((0 <= rcu_try_flip_state) &&
> +	    (rcu_try_flip_state <= sizeof(rcu_try_flip_state_names) /
> +	    			   sizeof(rcu_try_flip_state_names[0])))
> +		cnt += sprintf(&page[cnt], " (%s)",
> +			       rcu_try_flip_state_names[rcu_try_flip_state]);
> +	cnt += sprintf(&page[cnt], "\n");
> 	return (cnt);
> }
>
>
