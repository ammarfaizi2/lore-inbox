Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVCRAZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVCRAZY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 19:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVCRAZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 19:25:23 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:42145 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261400AbVCRAUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 19:20:25 -0500
Date: Thu, 17 Mar 2005 16:20:26 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: mingo@elte.hu
Cc: dipankar@in.ibm.com, shemminger@osdl.org, akpm@osdl.org, torvalds@osdl.org,
       rusty@au1.ibm.com, tgall@us.ibm.com, jim.houston@comcast.net,
       manfred@colorfullife.com, gh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Real-Time Preemption and RCU
Message-ID: <20050318002026.GA2693@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

As promised/threatened earlier in another forum...

							Thanx, Paul

------------------------------------------------------------------------

The Real-Time Preemption patch modified RCU to permit its read-side
critical sections to be safely preempted.  This has worked, but there
are a few serious problems with this variant of RCU.  [If you just want
to skip directly to the code, search for "synchronize_kernel(void)".
There are five occurrences, each a variation on the theme.  I recommend
the fifth one.  The third one might also be OK in some environments.
If you have better approaches, please do not keep them a secret!!!]

So, why am I saying that there are problems with the real-time preemption
implementation of RCU?

o	RCU read-side critical sections cannot be freely nested,
	since the read-side critical section now acquires locks.
	This means that the real-time preemption variant of RCU
	is subject to deadlock conditions that "classic" RCU
	is immune to.  This is not just a theoretical concern,
	for example, see nf_hook_slow() in linux/net/core/netfilter.c:

		+       /*
		+        * PREEMPT_RT semantics: different-type read-locks
		+        * dont nest that easily:
		+        */
		+//     rcu_read_lock_read(&ptype_lock);

	A number of other RCU read-side critical sections have been
	similarly disabled (17 total in the patch).  Perhaps most embedded
	systems will not be using netfilter heavily, but this does bring
	up a very real stability concern, even on UP systems (since
	preemption will eventually occur when and where least expected).

o	RCU read-side critical sections cannot be unconditionally
	upgraded to write-side critical sections in all cases.
	For example, in classic RCU, it is perfectly legal to do
	the following:

		rcu_read_lock();
		list_for_each_entry_rcu(lep, head, p) {
			if (p->needs_update) {
				spin_lock(&update_lock);
				update_it(p);
				spin_unlock(&update_lock);
			}
		}
		rcu_read_unlock()

	This would need to change to the following for real-time
	preempt kernels:

		rcu_read_lock_spin(&update_lock);
		list_for_each_entry_rcu(lep, head, p) {
			if (p->needs_update) {
				spin_lock(&update_lock);
				update_it(p);
				spin_unlock(&update_lock);
			}
		}
		rcu_read_unlock_spin(&update_lock)

	This results in self-deadlock.

o	There is an API expansion, with five different variants
	of rcu_read_lock():

	API			    # uses
	------------------------    ------
	rcu_read_lock_spin()		11
	rcu_read_unlock_spin()		12
	rcu_read_lock_read()		42
	rcu_read_unlock_read()		42
	rcu_read_lock_bh_read()		 2
	rcu_read_unlock_bh_read()	 3
	rcu_read_lock_down_read()	14
	rcu_read_unlock_up_read()	20
	rcu_read_lock_nort()		 3
	rcu_read_unlock_nort()		 4

	TOTAL			       153

o	The need to modify lots of RCU code expands the size of this
	patch -- roughly 10% of the 20K lines of this patch are devoted
	to modifying RCU code to meet this new API.  10% may not sound
	like much, but it comes to more than 2,000 lines of context diffs.

Seems to me that it would be good to have an RCU implementation
that meet the requirements of the Real-Time Preemption patch,
but that is 100% compatible with the "classic RCU" API.  Such
an implementation must meet a number of requirements, which are
listed at the end of this message (search for "REQUIREMENTS").

I have looked into a number of seductive but subtly broken "solutions"
to this problem.  The solution listed here is not perfect, but I believe
that it has enough advantages to be worth pursuing.  The solution is
quite simple, and I feel a bit embarrassed that it took me so long
to come up with it.  All I can say in my defense is that the idea
of -adding- locks to improve scalability and eliminate deadlocks is
quite counterintuitive to me.  And, like I said earlier, if you
know of a better approach, please don't keep it a secret!

The following verbiage steps through several variations on this
solution, as follows:

1.	"Toy" implementation that has numerous API, scalability,
	and realtime problems, but is a very simple 28-line
	illustration of the underlying principles.  (In case you
	get excited about this being much smaller than "classic
	RCU", keep in mind that a similar "toy" implementation of
	"classic RCU" is even smaller.  To say nothing of faster
	and more scalable.)

2.	Expanded version of the "toy" implementation that exactly
	matches the "classic RCU" API, but still has realtime and
	scalability problems.

3.	Expanded version of solution #2 that meets realtime
	requirements (at least -I- think it does...).  It still does
	not scale well.

4.	Expanded version of solution #2 that scales, but that does
	not meet realtime requirements.

5.	The final version, which both scales and meets realtime
	requirements, as well as exactly matching the "classic RCU"
	API.

I have tested this approach, but in user-level scaffolding.  All of
these implementations should therefore be regarded with great suspicion:
untested, probably don't even compile.  Besides which, I certainly can't
claim to fully understand the real-time preempt patch, so I am bound
to have gotten something wrong somewhere.  In any case, none of these
implementations are a suitable replacement for "classic RCU" on large
servers, since they acquire locks in the RCU read-side critical sections.
However, they should scale enough to support small SMP systems, inflicting
only a modest performance penalty.

I believe that implementation #5 is most appropriate for real-time
preempt kernels.  Note that #1, #2, and #4 are not at all appropriate for
-any- kernel.  In theory, #3 might be appropriate, but if I understand
the real-time preempt implementation of reader-writer lock, it will
not perform well if there are long RCU read-side critical sections,
even in UP kernels.


------------------------------------------------------------------------

1. "Toy" Implementation.

[Inappropriate for actual use.]

The basic principle may be familiar to people who worked with the Linux
2.4 and early 2.5 networking code.  The RCU read-side critical section
read-acquires a lock, recursively if need be.  This lock is -not- acquired
by the update side, thus preventing the deadlocks caused by the current
real-time preempt implementation of RCU (and thus also deviating from the
aforementioned networking approach).  Instead, the lock is write-acquired
(and then immediately released) before freeing any memory removed from the
data structure.  The lock cannot be write-acquired until all currently
running read-side critical sections complete.  Therefore, the memory
cannot be released until all read-side critical sections have released
any references that they might have to the memory.

	rwlock_t rcu_deferral_lock = RW_LOCK_UNLOCKED;

	void
	rcu_read_lock(void)
	{
		read_lock(&rcu_deferral_lock);
	}

	void
	rcu_read_unlock(void)
	{
		read_unlock(&rcu_deferral_lock);
	}

	void
	synchronize_kernel(void)
	{
		write_lock(&rcu_deferral_lock);
		write_unlock(&rcu_deferral_lock);
	}

	void
	call_rcu(struct rcu_head *head,
		 void (*func)(struct rcu_head *rcu))
	{
		synchronize_kernel();
		func(head);
	}

This is quite small and simple, but before getting too excited, keep
in mind that a similar "toy" implementation of classic RCU would be
even smaller and simpler.

Note that, just as with classic RCU, the read-side and update-side
critical sections can run concurrently.  This means that the current
rcu_dereference() and rcu_assign_pointer() macros remain just as they
are in the current in-tree RCU implementation.  This is also true of
the other four implementations.

Note also that, just as with classic RCU, there has to be some sort
of mechanism (lock, semaphore, non-blocking synchronization, ...)
that prevents concurrent updates from making a mess.

Quick Quiz 1:  In what way does implementation #1 violate the
	current "classic RCU" API?  (Search for "ANSWER" if you can't
	wait.)

------------------------------------------------------------------------

2. "Toy" Implementation That Exactly Matches the "Classic RCU" API.

[Inappropriate for actual use.]

The following implementation exactly matches the "Classic RCU" API,
but does not meet realtime requirements, nor does it scale.

Quick Quiz 2: Why does implementation #2 not meet realtime requirements?

Quick Quiz 3: Why does implementation #2 fail to scale?

	struct rcu_data {
		long		batch;
		struct rcu_head	*waitlist;
		struct rcu_head	**waittail;
	};
	struct rcu_ctrlblk {
		rwlock		lock;
		long		batch;
	};
	DECLARE_PER_CPU(struct rcu_data, rcu_data);
	struct rcu_ctrlblk rcu_ctrlblk = {
		.lock = RW_LOCK_UNLOCKED,
		.batch = 0,
	};

	void
	rcu_read_lock(void)
	{
		read_lock(&rcu_ctrlblk.lock);
	}

	void
	rcu_read_unlock(void)
	{
		read_unlock(&rcu_ctrlblk.lock);
	}

	void
	synchronize_kernel(void)
	{
		write_lock(&rcu_ctrlblk.lock);
		rcu_ctrlblk.batch++;
		write_unlock(&rcu_ctrlblk.lock);
	}

	void
	call_rcu(struct rcu_head *head,
		 void (*func)(struct rcu_head *rcu))
	{
		unsigned long flags;
		struct rcu_data *rdp;

		head->func = func;
		head->next = NULL;
		local_irq_save(flags);
		rcu_do_my_batch();
		rdp = &__get_cpu_var(rcu_data);
		*rdp->waittail = head;
		rdp->nexttail = &head->next;
		local_irq_restore(flags);
	}

	void rcu_do_my_batch(void)
	{
		unsigned long flags;
		struct rcu_data *rdp;
		struct rcu_head *next, *list;

		local_irq_save(flags);
		rdp = &__get_cpu_var(rcu_data);
		smp_mb();  /* prevent sampling batch # before list removal. */
		if (rdp->batch == rcu_ctrlblk.batch) {
			local_irq_restore(flags);
			return;
		}
		list = rdp->waitlist;
		rdp->waitlist = NULL;
		rdp->waittail = &rdp->waitlist;
		rdp->batch = rcu_ctrlblk.batch;
		local_irq_restore(flags);
		while (list) {
			next = list->next;
			list->func(list);
			list = next;
		}
	}

	/*
	 * Note: rcu_dereference() and rcu_assign_pointer() unchanged
	 * from current in-tree implementation.
	 */

The trick here is that call_rcu() does not write-acquire the lock,
either directly or indirectly.  This means that there is no way
for it to deadlock with an RCU read-side critical section.
However, the callbacks are still invoked with interrupts disabled,
so this implementation still does not meet realtime requirements.
In addition, it still uses a global reader-writer lock, so it does
not scale, either.

However, it -does- faithfully implement the classic RCU API.


------------------------------------------------------------------------

3. Meets Realtime Requirements, Doesn't Scale

The trick here is to break the callback processing out into a separate
rcu_process_callbacks() function, so that it may be invoked from a kernel
daemon, a work queue, or whatever.  It must be called periodically.
If the kernel is under memory pressure, one can get immediate relief
by doing the following:

	synchronize_kernel();
	rcu_process_callbacks();

Even more relief can be obtained by using something like
smp_call_function() in order to invoke rcu_process_callbacks() on each
CPU in an SMP system.  Alternatively, one could awaken the kernel daemons
or schedule the function into the appropriate work queue, depending
on how this code fragment is integrated in.  Or, perhaps better yet,
restrict use of this approach to UP kernels.  ;-)

	struct rcu_data {
		long		batch;
		struct rcu_head	*waitlist;
		struct rcu_head	**waittail;
		struct rcu_head	*donelist;
		struct rcu_head	**donetail;
	};
	struct rcu_ctrlblk {
		rwlock		lock;
		long		batch;
	};
	DECLARE_PER_CPU(struct rcu_data, rcu_data);
	struct rcu_ctrlblk rcu_ctrlblk = {
		.lock = RW_LOCK_UNLOCKED,
		.batch = 0,
	};

	void
	rcu_read_lock(void)
	{
		read_lock(&rcu_ctrlblk.lock);
	}

	void
	rcu_read_unlock(void)
	{
		read_unlock(&rcu_ctrlblk.lock);
	}

	void
	synchronize_kernel(void)
	{
		write_lock(&rcu_ctrlblk.lock);
		rcu_ctrlblk.batch++;
		write_unlock(&rcu_ctrlblk.lock);
	}

	void
	call_rcu(struct rcu_head *head,
		 void (*func)(struct rcu_head *rcu))
	{
		unsigned long flags;
		struct rcu_data *rdp;

		head->func = func;
		head->next = NULL;
		local_irq_save(flags);
		rcu_advance_callbacks();
		rdp = &__get_cpu_var(rcu_data);
		*rdp->waittail = head;
		rdp->nexttail = &head->next;
		local_irq_restore(flags);
	}

	void rcu_advance_callbacks(void)
	{
		unsigned long flags;
		struct rcu_data *rdp;

		local_irq_save(flags);
		rdp = &__get_cpu_var(rcu_data);
		smp_mb();  /* prevent sampling batch # before list removal. */
		if (rdp->batch != rcu_ctrlblk.batch) {
			*rdp->donetail = rdp->waitlist;
			rdp->donetail = rdp->waittail;
			rdp->waitlist = NULL;
			rdp->waittail = &rdp->waitlist;
			rdp->batch = rcu_ctrlblk.batch;
		}
		local_irq_restore(flags);
	}

	void rcu_process_callbacks(void)
	{
		unsigned long flags;
		struct rcu_head *next, *list;
		struct rcu_data *rdp;

		local_irq_save(flags);
		rdp = &__get_cpu_var(rcu_data);
		list = rdp->donelist;
		if (list == NULL) {
			local_irq_restore(flags);
			return;
		}
		rdp->donelist = NULL;
		rdp->donetail = &rdp->waitlist;
		local_irq_restore(flags);
		while (list) {
			next = list->next;
			list->func(list);
			list = next;
		}
	}

	/*
	 * Note: rcu_dereference() and rcu_assign_pointer() unchanged
	 * from current in-tree implementation.
	 */

Since a single global rwlock is used, this implementation still does
not scale.


------------------------------------------------------------------------

4. Scalable Implementation

[Inappropriate for realtime use.]

This variant scales, though not well enough to recommend use on a
mid-range POWER machine, let alone a full-blown Altix.  In addition,
it fails to meet some realtime requirements.

Quick Quiz 4: Why does implementation #4 fail the realtime test?

	#define GRACE_PERIODS_PER_SEC 10

	struct rcu_data {
		rwlock		lock;
		long		batch;
		struct rcu_head	*waitlist;
		struct rcu_head	**waittail;
	};
	struct rcu_ctrlblk {
		long		batch;
	};
	DECLARE_PER_CPU(struct rcu_data, rcu_data);
	struct rcu_ctrlblk rcu_ctrlblk = {
		.batch = 0,
	};

	void
	rcu_read_lock(void)
	{
		read_lock(&__get_cpu_var(rcu_data).lock);
	}

	void
	rcu_read_unlock(void)
	{
		read_unlock(&__get_cpu_var(rcu_data).lock);
	}

	void
	_synchronize_kernel(void)
	{
		int cpu;

		for_each_cpu(cpu) {
			write_lock(&per_cpu(rcu_data, cpu).lock);
		}
		rcu_ctrlblk.batch++;
		for_each_cpu(cpu) {
			write_unlock(&per_cpu(rcu_data, cpu).lock);
		}
	}

	void
	synchronize_kernel(void)
	{
		long oldbatch;

		smp_mb();
		oldbatch = rcu_ctrlblk.batch;
		schedule_timeout(HZ/GRACE_PERIODS_PER_SEC);
		if (rcu_ctrlblk.batch == oldbatch) {
			_synchronize_kernel();
		}
	}

	void
	call_rcu(struct rcu_head *head,
		 void (*func)(struct rcu_head *rcu))
	{
		unsigned long flags;
		struct rcu_data *rdp;

		head->func = func;
		head->next = NULL;
		local_irq_save(flags);
		rcu_do_my_batch();
		rdp = &__get_cpu_var(rcu_data);
		*rdp->waittail = head;
		rdp->nexttail = &head->next;
		local_irq_restore(flags);
	}

	void rcu_do_my_batch(void)
	{
		unsigned long flags;
		struct rcu_data *rdp;
		struct rcu_head *next, *list;

		local_irq_save(flags);
		rdp = &__get_cpu_var(rcu_data);
		smp_mb();  /* prevent sampling batch # before list removal. */
		if (rdp->batch == rcu_ctrlblk.batch) {
			local_irq_restore(flags);
			return;
		}
		list = rdp->waitlist;
		rdp->waitlist = NULL;
		rdp->waittail = &rdp->waitlist;
		rdp->batch = rcu_ctrlblk.batch;
		local_irq_restore(flags);
		while (list) {
			next = list->next;
			list->func(list);
			list = next;
		}
	}

	/*
	 * Note: rcu_dereference() and rcu_assign_pointer() unchanged
	 * from current in-tree implementation.
	 */

Quick Quiz 5: Why the use of for_each_cpu() rather than (say)
	for_each_online_cpu() in _synchronize_kernel() in
	implementation #4?

Quick Quiz 6: Why aren't there write-side contention problems
	in implementation #4?


------------------------------------------------------------------------

5. Scalability -and- Realtime Response.

The trick here is to keep track of the CPU that did the rcu_read_lock()
in the task structure.  If there is a preemption, there will be some
slight inefficiency, but the correct lock will be released, preserving
correctness.

	#define GRACE_PERIODS_PER_SEC 10

	struct rcu_data {
		rwlock		lock;
		long		batch;
		struct rcu_head	*waitlist;
		struct rcu_head	**waittail;
		struct rcu_head	*donelist;
		struct rcu_head	**donetail;
	};
	struct rcu_ctrlblk {
		long		batch;
	};
	DECLARE_PER_CPU(struct rcu_data, rcu_data);
	struct rcu_ctrlblk rcu_ctrlblk = {
		.batch = 0,
	};

	void
	rcu_read_lock(void)
	{
		preempt_disable();
		if (current->rcu_read_lock_nesting++ == 0) {
			current->rcu_read_lock_ptr =
				&__get_cpu_var(rcu_data).lock;
			read_lock(current->rcu_read_lock_ptr);
		}
		preempt_enable();
	}

	void
	rcu_read_unlock(void)
	{
		preempt_disable();
		if (--current->rcu_read_lock_nesting == 0) {
			read_unlock(current->rcu_read_lock_ptr);
		}
		preempt_enable();
	}

	void
	_synchronize_kernel(void)
	{
		int cpu;

		for_each_cpu(cpu) {
			write_lock(&per_cpu(rcu_data, cpu).lock);
		}
		rcu_ctrlblk.batch++;
		for_each_cpu(cpu) {
			write_unlock(&per_cpu(rcu_data, cpu).lock);
		}
	}

	void
	synchronize_kernel(void)
	{
		long oldbatch;

		smp_mb();
		oldbatch = rcu_ctrlblk.batch;
		schedule_timeout(HZ/GRACE_PERIODS_PER_SEC);
		if (rcu_ctrlblk.batch == oldbatch) {
			_synchronize_kernel();
		}
	}

	void
	call_rcu(struct rcu_head *head,
		 void (*func)(struct rcu_head *rcu))
	{
		unsigned long flags;
		struct rcu_data *rdp;

		head->func = func;
		head->next = NULL;
		local_irq_save(flags);
		rcu_advance_callbacks();
		rdp = &__get_cpu_var(rcu_data);
		*rdp->waittail = head;
		rdp->nexttail = &head->next;
		local_irq_restore(flags);
	}

	void rcu_advance_callbacks(void)
	{
		unsigned long flags;
		struct rcu_data *rdp;

		local_irq_save(flags);  /* allow invocation from OOM handler. */
		rdp = &__get_cpu_var(rcu_data);
		smp_mb(); /* prevent sampling batch # before list removal. */
		if (rdp->batch != rcu_ctrlblk.batch) {
			*rdp->donetail = rdp->waitlist;
			rdp->donetail = rdp->waittail;
			rdp->waitlist = NULL;
			rdp->waittail = &rdp->waitlist;
			rdp->batch = rcu_ctrlblk.batch;
		}
		local_irq_restore(flags);
	}

	void rcu_process_callbacks(void)
	{
		unsigned long flags;
		struct rcu_head *next, *list;
		struct rcu_data *rdp;

		local_irq_save(flags);
		rdp = &__get_cpu_var(rcu_data);
		list = rdp->donelist;
		if (list == NULL) {
			local_irq_restore(flags);
			return;
		}
		rdp->donelist = NULL;
		rdp->donetail = &rdp->waitlist;
		local_irq_restore(flags);
		while (list) {
			next = list->next;
			list->func(list);
			list = next;
		}
	}

	/*
	 * Note: rcu_dereference() and rcu_assign_pointer() unchanged
	 * from current in-tree implementation.
	 */

This implementation meets all of the requirements, -except- that it
imposes significant (but probably not crippling) synchronization overhead
on RCU read-side critical sections.  This implementation is probably
serviceable on systems with up to 2-4 CPUs, and perhaps a few more.
However, it is not going to cut it on a mid-range POWER system, much
less a high-end Altix system.  So, if you don't need heavy-duty realtime
response, you should stick with "classic RCU".  Or, better yet, come
up with a single RCU implementation that is suited to both realtime and
server usage!

Quick Quiz 7: What if there is real interrupt or softirq code that
	needs to call rcu_read_lock()?

Quick Quiz 8: What other bugs are present in implementation #5?


------------------------------------------------------------------------

REQUIREMENTS

These are -not- in strict priority order.  Nor can they be, since
different people have different priorities.  ;-)

1. Deferred destruction.

	No data element may be destroyed (for example, freed) while an
	RCU read-side critical section is referencing it.  This property
	absolutely must be implemented, as failing to do so will break
	pretty much all the code that uses RCU.

2. Reliable.

	The implementation must not be prone to gratuitous failure; it
	must be able to run 24x7 for months at a time, and preferably
	for years.

	[This is a problem for so-called "hazard pointer" mechanisms,
	which require that hazard pointers be allocated and freed.
	So what do you do when the allocation fails while nested
	way down in the bowels of some lock's critical section?
	Avoiding this sort of unwind code was a major motivation
	for Jack and I to come up with RCU in the first place!]

3. Callable from IRQ.

	Since RCU is used from softirq state, a realtime implementation
	must either eliminate softirq and interrupt states, eliminate use
	of RCU from these states, or make RCU callable from these states.

	[I believe that the real-time preemption patch moves code
	from softirq/interrupt to process context, but could easily be
	missing something.  If need be, there are ways of handling cases
	were realtime RCU is called from softirq and interrupt contexts,
	for an example approach, see the Quick Quiz answers.]

4. Preemptible read side.

	RCU read-side critical sections can (in theory, anyway) be quite
	large, degrading realtime scheduling response.	Preemptible RCU
	read-side critical sections avoid such degradation.  Manual
	insertion of "preemption points" might be an alternative as well.
	But I have no intention of trying to settle the long-running
	argument between proponents of preemption and of preemption
	points.  Not today, anyway!  ;-)

	[This is one of classic RCU's weak points.  No surprise, as
	it was not designed with aggressive realtime in mind.]

5. Small memory footprint.

	Many realtime systems are configured with modest amounts
	of memory, so it is highly desirable to limit the number of
	outstanding RCU callbacks.  It is also necessary to force
	"reaping" of callbacks should the system run short of memory.

	[This is another of classic RCU's weak points.  No surprise,
	it was not designed with tiny-memory embedded systems in
	mind.]

6. Independent of memory blocks.

	The implementation should not make assumptions about the size
	and extent of the data elements being protected by RCU, since
	such assumptions constrain memory allocation design and can
	impose increased complexity.

	[This requirement makes it difficult to use so-called
	"hazard pointer" techniques.]

7. Synchronization-free read side.

	RCU read-side critical sections should avoid expensive
	synchronization instructions or cache misses.  It is most
	important to avoid global locks and atomic instructions that
	modify global memory, as these operations can inflict severe
	performance and scalability bottlenecks.  Avoiding memory barriers
	is desirable but not as critical.

	[This is where classic RCU shines.  The realtime scheme does not
	have a synchronization-free read side, but implementation #5 at
	least has decent cache locality for read-mostly workloads.]

8. Freely nestable read-side critical sections.

	Restrictions on nestability can result in code duplication,
	so should be avoided if possible.

	[This is where the current real-time preempt RCU implementation
	has -serious- problems.]

9. Unconditional read-to-write upgrade.

	RCU permits a read-side critical section to acquire the
	corresponding write-side lock.	This capability can be convenient
	in some cases.	However, since it is rarely used, it cannot be
	considered mandatory.  Then again, working around the lack of
	such upgrade usually results in code bloat.

	[This is another big issue with the current real-time preempt
	RCU implementation.]

10. Compatible API.

	A realtime RCU implementation should have an API compatible with
	that in the kernel.

	[Another big issue with the current real-time preempt RCU
	implementation.]


------------------------------------------------------------------------

ANSWERS TO QUICK QUIZ

Quick Quiz 1:  In what way does implementation #1 violate the
	current "classic RCU" API?

	Answer: Unlike "classic RCU", it is not legal to invoke
		call_rcu() from within an RCU read-side critical
		section.  Doing so will result in deadlock.

Quick Quiz 2: Why does implementation #2 not meet realtime requirements?

	Answer: Because all the callbacks are invoked with interrupts
		disabled.  If there are a lot of callbacks, realtime
		latency will suffer.

Quick Quiz 3: Why does implementation #2 fail to scale?

	Answer: Because the large cache-miss penalties of modern
		microprocessors.  See http://linuxjournal.com/article/6993
		for more details on why this is so.

Quick Quiz 4: Why does implementation #4 fail the realtime test?

	Answer: Because the realtime-preempt version of locks can be
		preempted.  Therefore, the rcu_read_unlock() might
		run on a different CPU than did the corresponding
		rcu_read_lock(), resulting in horrible confusion and
		a great decrease in the expected lifespan of your
		kernel.
		
		Also because it reverts to invoking the callbacks
		with interrupts disabled.

Quick Quiz 5: Why the use of for_each_cpu() rather than (say)
	for_each_online_cpu() in _synchronize_kernel()?

	Answer: To completely avoid any races with CPU hotplug.
		Admittedly a large hammer to use, but it does
		have the advantage of simplicity.  Suggestions
		for improvements welcome!

Quick Quiz 6: Why aren't there write-side contention problems
	in implementation #4?

	Answer: Because synchronize_kernel() refuses to acquire
		the lock more than 10 times a second.  Of course,
		if you invoke _synchronize_kernel() frequently
		from an OOM handler, or if you are running on
		a 100-CPU machine, some adjustments may be needed.
		In a -lot- of places in the latter case.

Quick Quiz 7: What if there is real interrupt or softirq code that
	needs to call rcu_read_lock()?

	Answer: Use something like the call_rcu_bh() API.  This could
		have a similar implementation to the ones laid out here,
		but rcu_read_lock_bh() must disable preemption, and
		perhaps also interrupts.  As must _synchronize_kernel().

Quick Quiz 8: What other bugs are present in implementation #5?

	Answer: Beats me!  If I knew, I might have fixed them.  ;-)
