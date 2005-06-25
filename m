Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263256AbVFYBj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263256AbVFYBj6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 21:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263264AbVFYBj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 21:39:58 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:58056 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263256AbVFYBiE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 21:38:04 -0400
Date: Fri, 24 Jun 2005 18:38:22 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu, dipankar@in.ibm.com
Subject: [RFC] RCU and CONFIG_PREEMPT_RT progress, part 2
Message-ID: <20050625013821.GA2996@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

More progress on CONFIG_PREEMPT_RT-compatible RCU.

o	Earlier this week, declared my CONFIG_PREEMPT_RT education
	complete enough to take on a counter-based approach.

o	Selected a simple counter-based approach, and created
	a Promela model of it, which passes spin.  See attached
	"ctrflipRCU.spin" and "ctrflipRCU.sh" files.  The
	spin analyzer is open-source software, available at
	http://spinroot.com/spin/whatispin.html if you want to check
	it out.  Will be running the model by some people here early
	next week.

o	Started prototyping Linux-kernel implementation, initially
	in the CONFIG_PREEMPT environment.  (Yes, I am still being
	cowardly!)  The implementation is as follows:

	o	Use a per-CPU pair of counters to track the number
		of outstanding RCU read-side critical sections
		started on the corresponding CPU (though these may
		have migrated to some other CPU in the meantime).

	o	In case of a race with the flipping of the counters,
		just increment the other counter for the corresponding
		CPU.  This suppresses further counter flips.

	o	Grace-period advancement depends entirely on
		synchronize_rcu() calls.  If your workload avoids
		making any synchronize_kernel() calls (which is not
		hard to do given that call_rcu() is often used
		instead of synchronize_rcu()), then RCU will be
		a big memory leak.  (This will be fixed later.)

	o	In theory, you can "cat /proc/rcugp" to force the
		kernel to invoke synchronize_rcu(), but I have not tested
		this yet, and will not do so until it actually boots.  ;-)
		The long-term fix will likely involve periodic
		grace-period forcing from a kernel task or from the
		workqueue environment.

	o	The rcu_read_lock() and rcu_read_unlock() primitives
		still use heavy-weight atomic operations in the common
		case (avoided only in the case of nested rcu_read_lock()
		calls).  Longer term, I expect to make changes to avoid
		the atomics in the (hopefully) common case where there
		is no preemption of RCU read-side critical sections.
		But simple things first!

	o	The rcu_read_lock() and rcu_read_unlock() primitives
		use memory-barrier instructions.  In theory, it is
		possible to dispense with these, but doing so requires
		some very strange code.  Not clear that this is practical.

o	Started running tests in vanilla CONFIG_PREEMPT environment
	to check solidity with stock RCU.  Will need solid base when
	stress-test time arrives.

Extremely broken patch included below for your amusement.  Feel free to
take bets on how much it differs from the eventual working patch.  ;-)

						Thanx, Paul

Not-signed-off-by: paulmck@us.ibm.com

diff -urpN -X dontdiff linux-2.6.12-rc6/arch/i386/Kconfig linux-2.6.12-rc6-ctrRCU/arch/i386/Kconfig
--- linux-2.6.12-rc6/arch/i386/Kconfig	Fri Jun 17 16:34:16 2005
+++ linux-2.6.12-rc6-ctrRCU/arch/i386/Kconfig	Fri Jun 24 10:22:39 2005
@@ -523,6 +523,19 @@ config PREEMPT
 	  Say Y here if you are building a kernel for a desktop, embedded
 	  or real-time system.  Say N if you are unsure.
 
+config PREEMPT_RCU
+	bool "Preemptible RCU read-side critical sections"
+	default y
+	help
+	  This option reduces the latency of the kernel when reacting to
+	  real-time or interactive events by allowing a low priority process to
+	  be preempted even if it is in an RCU read-side critical section.
+	  This allows applications to run more reliably even when the system is
+	  under load.
+
+	  Say Y here if you enjoy debugging random oopses.
+	  Say N if, for whatever reason, you want your kernel to actually work.
+
 config PREEMPT_BKL
 	bool "Preempt The Big Kernel Lock"
 	depends on PREEMPT
diff -urpN -X dontdiff linux-2.6.12-rc6/fs/proc/proc_misc.c linux-2.6.12-rc6-ctrRCU/fs/proc/proc_misc.c
--- linux-2.6.12-rc6/fs/proc/proc_misc.c	Fri Jun 17 16:35:03 2005
+++ linux-2.6.12-rc6-ctrRCU/fs/proc/proc_misc.c	Thu Jun 23 21:42:30 2005
@@ -549,6 +549,20 @@ void create_seq_entry(char *name, mode_t
 		entry->proc_fops = f;
 }
 
+#define RCU_STATS
+
+#ifdef RCU_STATS
+int rcu_read_proc_gp(char *page, char **start, off_t off,
+		     int count, int *eof, void *data)
+{
+	int len;
+	extern int rcu_read_proc_gp_data(char *page);
+
+	len = rcu_read_proc_gp_data(page);
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+#endif /* #ifdef RCU_STATS */
+
 void __init proc_misc_init(void)
 {
 	struct proc_dir_entry *entry;
@@ -571,6 +585,9 @@ void __init proc_misc_init(void)
 		{"cmdline",	cmdline_read_proc},
 		{"locks",	locks_read_proc},
 		{"execdomains",	execdomains_read_proc},
+#ifdef RCU_STATS
+		{"rcugp",	rcu_read_proc_gp},
+#endif /* #ifdef RCU_STATS */
 		{NULL,}
 	};
 	for (p = simple_ones; p->name; p++)
diff -urpN -X dontdiff linux-2.6.12-rc6/include/linux/rcupdate.h linux-2.6.12-rc6-ctrRCU/include/linux/rcupdate.h
--- linux-2.6.12-rc6/include/linux/rcupdate.h	Fri Jun 17 16:35:13 2005
+++ linux-2.6.12-rc6-ctrRCU/include/linux/rcupdate.h	Fri Jun 24 14:59:04 2005
@@ -59,6 +59,7 @@ struct rcu_head {
 } while (0)
 
 
+#ifndef CONFIG_PREEMPT_RCU
 
 /* Global control variables for rcupdate callback mechanism. */
 struct rcu_ctrlblk {
@@ -192,6 +193,18 @@ static inline int rcu_pending(int cpu)
  */
 #define rcu_read_unlock()	preempt_enable()
 
+#else /* #ifndef CONFIG_PREEMPT_RCU */
+
+#define rcu_qsctr_inc(cpu)
+#define rcu_bh_qsctr_inc(cpu)
+#define call_rcu_bh(head, rcu) call_rcu(head, rcu)
+
+extern void rcu_read_lock(void);
+extern void rcu_read_unlock(void);
+extern int rcu_pending(int cpu);
+
+#endif /* #else #ifndef CONFIG_PREEMPT_RCU */
+
 /*
  * So where is rcu_write_lock()?  It does not exist, as there is no
  * way for writers to lock out RCU readers.  This is a feature, not
@@ -213,14 +226,22 @@ static inline int rcu_pending(int cpu)
  * can use just rcu_read_lock().
  *
  */
+#ifndef CONFIG_PREEMPT_RCU
 #define rcu_read_lock_bh()	local_bh_disable()
+#else /* #ifndef CONFIG_PREEMPT_RCU */
+#define rcu_read_lock_bh()	{ rcu_read_lock(); local_bh_disable(); }
+#endif /* #else #ifndef CONFIG_PREEMPT_RCU */
 
 /*
  * rcu_read_unlock_bh - marks the end of a softirq-only RCU critical section
  *
  * See rcu_read_lock_bh() for more information.
  */
+#ifndef CONFIG_PREEMPT_RCU
 #define rcu_read_unlock_bh()	local_bh_enable()
+#else /* #ifndef CONFIG_PREEMPT_RCU */
+#define rcu_read_unlock_bh()	{ local_bh_enable(); rcu_read_unlock(); }
+#endif /* #else #ifndef CONFIG_PREEMPT_RCU */
 
 /**
  * rcu_dereference - fetch an RCU-protected pointer in an
@@ -238,6 +259,7 @@ static inline int rcu_pending(int cpu)
 				(_________p1); \
 				})
 
+
 /**
  * rcu_assign_pointer - assign (publicize) a pointer to a newly
  * initialized structure that will be dereferenced by RCU read-side
@@ -256,6 +278,7 @@ static inline int rcu_pending(int cpu)
 						(p) = (v); \
 					})
 
+
 /**
  * synchronize_sched - block until all CPUs have exited any non-preemptive
  * kernel code sequences.
@@ -269,7 +292,11 @@ static inline int rcu_pending(int cpu)
  * synchronize_kernel() API.  In contrast, synchronize_rcu() only
  * guarantees that rcu_read_lock() sections will have completed.
  */
+#ifdef CONFIG_PREEMPT_RCU
+extern void synchronize_sched(void);
+#else /* #ifdef CONFIG_PREEMPT_RCU */
 #define synchronize_sched() synchronize_rcu()
+#endif /* #else #ifdef CONFIG_PREEMPT_RCU */
 
 extern void rcu_init(void);
 extern void rcu_check_callbacks(int cpu, int user);
diff -urpN -X dontdiff linux-2.6.12-rc6/include/linux/sched.h linux-2.6.12-rc6-ctrRCU/include/linux/sched.h
--- linux-2.6.12-rc6/include/linux/sched.h	Fri Jun 17 16:35:13 2005
+++ linux-2.6.12-rc6-ctrRCU/include/linux/sched.h	Wed Jun 22 17:25:49 2005
@@ -740,6 +740,11 @@ struct task_struct {
 	nodemask_t mems_allowed;
 	int cpuset_mems_generation;
 #endif
+#ifdef CONFIG_PREEMPT_RCU
+	int rcu_read_lock_nesting;
+	atomic_t *rcu_flipctr1;
+	atomic_t *rcu_flipctr2;
+#endif
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
diff -urpN -X dontdiff linux-2.6.12-rc6/kernel/rcupdate.c linux-2.6.12-rc6-ctrRCU/kernel/rcupdate.c
--- linux-2.6.12-rc6/kernel/rcupdate.c	Fri Jun 17 16:35:15 2005
+++ linux-2.6.12-rc6-ctrRCU/kernel/rcupdate.c	Fri Jun 24 17:47:26 2005
@@ -47,6 +47,8 @@
 #include <linux/rcupdate.h>
 #include <linux/cpu.h>
 
+#ifndef CONFIG_PREEMPT_RCU
+
 /* Definition for rcupdate control block. */
 struct rcu_ctrlblk rcu_ctrlblk = 
 	{ .cur = -300, .completed = -300 };
@@ -480,3 +482,342 @@ EXPORT_SYMBOL(call_rcu);  /* WARNING: GP
 EXPORT_SYMBOL(call_rcu_bh);  /* WARNING: GPL-only in April 2006. */
 EXPORT_SYMBOL_GPL(synchronize_rcu);
 EXPORT_SYMBOL(synchronize_kernel);  /* WARNING: GPL-only in April 2006. */
+
+#else /* #ifndef CONFIG_PREEMPT_RCU */
+
+#ifdef CONFIG_PREEMPT_RT
+#error "Hey!!!  This hasn't been tested yet!!!  No way it works!!!"
+#endif /* #ifdef CONFIG_PREEMPT_RT */
+
+#define RCU_STATS
+
+#define raw_spinlock_t spinlock_t
+#define _raw_spin_lock(l) spin_lock(l)
+#define _raw_spin_unlock(l) spin_unlock(l)
+#define RAW_SPIN_LOCK_UNLOCKED SPIN_LOCK_UNLOCKED
+
+struct rcu_data {
+	raw_spinlock_t	lock;
+	long		batch;
+	struct tasklet_struct rcu_tasklet;
+	struct rcu_head *nextlist;
+	struct rcu_head **nexttail;
+	struct rcu_head *waitlist;
+	struct rcu_head **waittail;
+	struct rcu_head *donelist;
+	struct rcu_head **donetail;
+};
+struct rcu_ctrlblk {
+	long		batch;
+};
+static struct rcu_data rcu_data;
+static struct rcu_ctrlblk rcu_ctrlblk = {
+	.batch = 0,
+};
+DECLARE_MUTEX(rcu_flipmutex);
+static DEFINE_PER_CPU(atomic_t [2], rcu_flipctr) =
+	{ ATOMIC_INIT(0), ATOMIC_INIT(0) };
+
+void
+rcu_read_lock(void)
+{
+	int flipctr;
+
+	if (current->rcu_read_lock_nesting++ == 0) {
+
+		/*
+		 * Outermost nesting of rcu_read_lock(), so atomically
+		 * increment the current counter for the current CPU.
+		 */
+
+		preempt_disable();
+		flipctr = rcu_data.batch & 0x1;
+		smp_read_barrier_depends();
+		current->rcu_flipctr1 = &(__get_cpu_var(rcu_flipctr)[flipctr]);
+		/* Can optimize to non-atomic on fastpath, but start simple. */
+		atomic_inc(current->rcu_flipctr1);
+		smp_mb__after_atomic_inc();  /* might optimize out... */
+		if (flipctr != (rcu_data.batch & 0x1)) {
+
+			/*
+			 * We raced with grace-period processing (flip).
+			 * Although we cannot be preempted here, there
+			 * could be interrupts, ECC errors and the like,
+			 * so just nail down both sides of the rcu_flipctr
+			 * array for the duration of our RCU read-side
+			 * critical section, preventing a second flip
+			 * from racing with us.  At some point, it would
+			 * be safe to decrement one of the counter, but
+			 * we have no way of knowing when that would be.
+			 * So just decrement them both in rcu_read_unlock().
+			 */
+
+			current->rcu_flipctr2 =
+				&(__get_cpu_var(rcu_flipctr)[!flipctr]);
+			/* Can again optimize to non-atomic on fastpath. */
+			atomic_inc(current->rcu_flipctr2);
+			smp_mb__after_atomic_inc();  /* might optimize out... */
+		}
+		preempt_enable();
+	}
+}
+
+void
+rcu_read_unlock(void)
+{
+
+	if (--current->rcu_read_lock_nesting == 0) {
+
+		/*
+		 * Just atomically decrement whatever we incremented.
+		 * Might later want to awaken some task waiting for the
+		 * grace period to complete, but keep it simple for the
+		 * moment.
+		 */
+
+		smp_mb__before_atomic_dec();
+		atomic_dec(current->rcu_flipctr1);
+		current->rcu_flipctr1 = NULL;
+		if (current->rcu_flipctr2 != NULL) {
+			atomic_dec(current->rcu_flipctr2);
+			current->rcu_flipctr2 = NULL;
+		}
+	}
+}
+
+static void
+__rcu_advance_callbacks(void)
+{
+	if (rcu_data.batch != rcu_ctrlblk.batch) {
+		if (rcu_data.waitlist != NULL) {
+			*rcu_data.donetail = rcu_data.waitlist;
+			rcu_data.donetail = rcu_data.waittail;
+		}
+		if (rcu_data.nextlist != NULL) {
+			rcu_data.waitlist = rcu_data.nextlist;
+			rcu_data.waittail = rcu_data.nexttail;
+			rcu_data.nextlist = NULL;
+			rcu_data.nexttail = &rcu_data.nextlist;
+		} else {
+			rcu_data.waitlist = NULL;
+			rcu_data.waittail = &rcu_data.waitlist;
+		}
+		rcu_data.batch = rcu_ctrlblk.batch;
+	}
+}
+
+void
+call_rcu(struct rcu_head *head,
+	 void (*func)(struct rcu_head *rcu))
+{
+	head->func = func;
+	head->next = NULL;
+	_raw_spin_lock(&rcu_data.lock);
+	__rcu_advance_callbacks();
+	*rcu_data.waittail = head;
+	rcu_data.waittail = &head->next;
+	_raw_spin_unlock(&rcu_data.lock);
+}
+
+void
+rcu_check_callbacks(int cpu, int user)
+{
+	_raw_spin_lock(&rcu_data.lock);
+	__rcu_advance_callbacks();
+	if (rcu_data.donelist == NULL) {
+		_raw_spin_unlock(&rcu_data.lock);
+		return;
+	}
+	_raw_spin_unlock(&rcu_data.lock);
+	tasklet_schedule(&rcu_data.rcu_tasklet);
+}
+
+static
+void rcu_process_callbacks(unsigned long data)
+{
+	struct rcu_head *next, *list;
+
+	_raw_spin_lock(&rcu_data.lock);
+	list = rcu_data.donelist;
+	if (list == NULL) {
+		_raw_spin_unlock(&rcu_data.lock);
+		return;
+	}
+	rcu_data.donelist = NULL;
+	rcu_data.donetail = &rcu_data.donelist;
+	_raw_spin_unlock(&rcu_data.lock);
+	while (list) {
+		next = list->next;
+		list->func(list);
+		list = next;
+	}
+}
+
+/*
+ * Force a single flip of the counters.  Remember, a single flip does
+ * -not- constitute a grace period.  Instead, the interval between
+ * a pair of consecutive flips is a grace period.
+ *
+ * If anyone is nuts enough to run this CONFIG_PREEMPT_RCU implementation
+ * on a large SMP, they might want to use a hierarchical organization of
+ * the per-CPU-counter pairs.
+ */
+static void
+__synchronize_rcu_flip(void)
+{
+	int cpu;
+	long flipctr;
+
+	flipctr = rcu_data.batch;
+	down(&rcu_flipmutex);
+	if (flipctr != rcu_data.batch) {
+	
+		/* Our work is done!  ;-) */
+
+		up(&rcu_flipmutex);
+		return;
+	}
+	flipctr &= 0x1;
+
+	/*
+	 * Wait for the completion of all RCU read-side critical sections
+	 * that started prior to the previous flip.
+	 */
+
+	for_each_cpu(cpu) {
+		while (atomic_read(&per_cpu(rcu_flipctr, cpu)[!flipctr]) != 0) {
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout(HZ / 100);
+		}
+	}
+
+	/* Do the flip. */
+
+	smp_mb();
+	rcu_data.batch++;
+	smp_mb(); /* Not 100% certain that this one is required. */
+		  /* In fact, it seems likely that it can go. */
+	
+	/* A bit awkward -- looking ahead to per-CPU callback queues. */
+	/* Process callbacks... */
+
+	_raw_spin_lock(&rcu_data.lock);
+	__rcu_advance_callbacks();
+	_raw_spin_unlock(&rcu_data.lock);
+	tasklet_schedule(&rcu_data.rcu_tasklet);
+
+	up(&rcu_flipmutex);
+}
+
+/*
+ * Force a single flip of the counters, but do it lazily, waiting
+ * a bit to see if someone else will do it for us.
+ */
+static void
+synchronize_rcu_flip(void)
+{
+	long oldbatch = rcu_data.batch;
+
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(HZ / 100);
+	if ((rcu_data.batch - oldbatch) >= 2) {
+		
+		/* Our work is done! */
+
+		return;
+	}
+
+	/* No one else did it for us, so force the flip. */
+
+	__synchronize_rcu_flip();
+}
+
+void
+synchronize_rcu(void)
+{
+	long oldbatch = rcu_data.batch;
+
+	/* Need two flips to get a grace period. */
+
+	synchronize_rcu_flip();
+
+	if ((rcu_data.batch - oldbatch) >= 2) {
+		
+		/* Someone else helped with the second flip, we are done! */
+
+		return;
+	}
+
+	synchronize_rcu_flip();
+}
+
+/*
+ * Crude hack, reduces but does not eliminate possibility of failure.
+ * Needs to wait for all CPUs to pass through a -voluntary- context
+ * switch to eliminate possibility of failure.  (Maybe just crank
+ * priority down...)
+ */
+void
+synchronize_sched(void)
+{
+	cpumask_t oldmask;
+	int cpu;
+
+	if (sched_getaffinity(0, &oldmask) < 0) {
+		oldmask = cpu_possible_map; 
+	}
+	for_each_cpu(cpu) {
+		sched_setaffinity(0, cpumask_of_cpu(cpu));
+		schedule();
+	}
+	sched_setaffinity(0, oldmask);
+}
+
+int
+rcu_pending(int cpu)
+{
+	return (rcu_data.donelist != NULL ||
+		rcu_data.waitlist != NULL ||
+		rcu_data.nextlist != NULL);
+}
+
+void __init rcu_init(void)
+{
+	rcu_data.lock = RAW_SPIN_LOCK_UNLOCKED;
+	rcu_data.batch = 0;
+	rcu_data.nextlist = NULL;
+	rcu_data.nexttail = &rcu_data.nextlist;
+	rcu_data.waitlist = NULL;
+	rcu_data.waittail = &rcu_data.waitlist;
+	rcu_data.donelist = NULL;
+	rcu_data.donetail = &rcu_data.donelist;
+	tasklet_init(&rcu_data.rcu_tasklet, rcu_process_callbacks, 0UL);
+}
+
+/*
+ * Deprecated, use synchronize_rcu() or synchronize_sched() instead.
+ */
+void synchronize_kernel(void)
+{
+	synchronize_rcu();
+}
+
+#ifdef RCU_STATS
+int rcu_read_proc_gp_data(char *page)
+{
+	long oldgp = rcu_ctrlblk.batch;
+
+	synchronize_rcu();
+	return sprintf(page, "oldggp=%ld  newggp=%ld\n",
+		       oldgp, rcu_ctrlblk.batch);
+}
+#endif /* #ifdef RCU_STATS */
+
+EXPORT_SYMBOL(call_rcu); /* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL_GPL(synchronize_rcu);
+EXPORT_SYMBOL(synchronize_sched);  /* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL(rcu_read_lock);  /* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL(rcu_read_unlock);  /* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL(synchronize_kernel);  /* WARNING: Removal in April 2006. */
+
+#endif /* #else #ifndef CONFIG_PREEMPT_RCU */

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ctrflipRCU.spin"

#define PASSES 10

bit flip = 0;
bit ctr[2];
byte passctr = 0;

proctype rdr()
{
	bit lcl_flip;
	bit both;

	do
	:: passctr < PASSES ->
		lcl_flip = flip;
		/* need smp_read_barrier_depends() */
		ctr[lcl_flip]++;
		/* need smp_mb__after_atomic_inc() */
		if
		:: lcl_flip == flip ->
			both = 0
		:: else ->
			ctr[!lcl_flip]++;
			/* need smp_mb__after_atomic_inc() */
			both = 1
		fi;
		passctr++;
		passctr++;
		/* need smp_mb__before_atomic_dec() */
		ctr[lcl_flip]--;
		if
		:: both ->
			ctr[!lcl_flip]--;
		:: else -> skip
		fi;
	:: passctr >= PASSES ->
		break
	od
}

proctype upd()
{
	byte lcl_passctr;

	do
	::	passctr < PASSES ->
		lcl_passctr = passctr;
		if
		::	lcl_passctr / 2 * 2 == lcl_passctr ->
			lcl_passctr = 255
		::	else -> skip
		fi;
		do
		::	ctr[!flip] == 0 -> break
		::	true -> skip
		od;
		/* Need smp_mb()? */
		flip = !flip;
		/* Need smp_mb()? */
		do
		::	ctr[!flip] == 0 -> break
		::	true -> skip
		od;
		assert(lcl_passctr != passctr);
	::	passctr >= PASSES ->
		break
	od
}

init {
	atomic {
		ctr[0] = 0;
		ctr[1] = 0;
		run rdr();
		run upd();
	}
}

--k1lZvvs/B4yU6o8G
Content-Type: application/x-sh
Content-Disposition: attachment; filename="ctrflipRCU.sh"
Content-Transfer-Encoding: quoted-printable

spin -a ctrflipRCU.spin=0Acc -o pan pan.c=0A./pan=0A# if you get an error, =
do the following:=0Aspin -t -p ctrflipRCU.spin > ctrflipRCU.spin.trail.txt=
=0A
--k1lZvvs/B4yU6o8G--
