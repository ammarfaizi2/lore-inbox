Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVCTW1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVCTW1F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 17:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVCTW1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 17:27:05 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:38574 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261308AbVCTW0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 17:26:43 -0500
Date: Sun, 20 Mar 2005 09:45:08 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-00
Message-ID: <20050320174508.GA3902@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050319191658.GA5921@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050319191658.GA5921@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2005 at 08:16:58PM +0100, Ingo Molnar wrote:
> 
> i have released the -V0.7.41-00 Real-Time Preemption patch (merged to
> 2.6.12-rc1), which can be downloaded from the usual place:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 
> the biggest change in this patch is the merge of Paul E. McKenney's
> preemptable RCU code. The new RCU code is active on PREEMPT_RT. While it
> is still quite experimental at this stage, it allowed the removal of
> locking cruft (mainly in the networking code), so it could solve some of
> the longstanding netfilter/networking deadlocks/crashes reported by a
> number of people. Be careful nevertheless.
> 
> there are a couple of minor changes relative to Paul's latest
> preemptable-RCU code drop:
> 
>  - made the two variants two #ifdef blocks - this is sufficient for now
>    and we'll see what the best way is in the longer run.
> 
>  - moved rcu_check_callbacks() from the timer IRQ to ksoftirqd. (the
>    timer IRQ still runs in hardirq context on PREEMPT_RT.)
> 
>  - changed the irq-flags method to a preempt_disable()-based method, and
>    moved the lock taking outside of the critical sections. (due to locks
>    potentially sleeping on PREEMPT_RT).
> 
> to create a -V0.7.41-00 tree from scratch, the patching order is:
> 
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.tar.bz2
>   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.12-rc1.bz2
>   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.12-rc1-V0.7.41-00

Some proposed fixes from a quick scan (untested, probably does not even
compile).  These proposed fixes fall into the following categories:

o	Some functions that should be static.

o	Introduced a synchronize_kernel_barrier() for a number of
	uses of synchronize_kernel() that are broken by the new
	implementation.  Note that synchronize_kernel_barrier() is
	the same as synchronize_kernel() in non-CONFIG_PREEMPT_RT
	kernels.  Not clear that synchronize_kernel_barrier()
	is strong enough for some uses, may need another API
	(synchronize_kernel_barrier_voluntary()???) that waits for all
	tasks to -voluntary- context switch or be executing in user
	space (these are marked with FIXME in the attached patch).
	Dipankar and/or Rusty put out a patch that did this some time
	back -- this was when we were trying to make an RCU that worked
	in CONFIG_PREEMPT kernels, but did not want preempt_disable()
	on the read side.

	That said, some of the synchronize_kernel_barrier()s marked
	with FIXME may be fixable more simply by inserting
	rcu_read_lock()/rcu_read_unlock() pairs in appropriate
	places.

o	Merged the two identical implementations each of
	rcu_dereference() and rcu_assign_pointer().

o	Added an rcu_read_lock() or two.  Clearly need to be searching
	for patches containing "synchronize_kernel" in addition to
	patches containing "rcu"...

Thoughts?

						Thanx, Paul

Signed-off-by: <paulmck@us.ibm.com>

diff -urpN -X dontdiff linux-2.6.11/arch/i386/oprofile/nmi_timer_int.c linux-2.6.11.fixes/arch/i386/oprofile/nmi_timer_int.c
--- linux-2.6.11/arch/i386/oprofile/nmi_timer_int.c	Tue Mar  1 23:37:52 2005
+++ linux-2.6.11.fixes/arch/i386/oprofile/nmi_timer_int.c	Sun Mar 20 08:40:31 2005
@@ -36,7 +36,7 @@ static void timer_stop(void)
 {
 	enable_timer_nmi_watchdog();
 	unset_nmi_callback();
-	synchronize_kernel();
+	synchronize_kernel_barrier();
 }
 
 
diff -urpN -X dontdiff linux-2.6.11/arch/ppc64/kernel/ItLpQueue.c linux-2.6.11.fixes/arch/ppc64/kernel/ItLpQueue.c
--- linux-2.6.11/arch/ppc64/kernel/ItLpQueue.c	Tue Mar  1 23:37:48 2005
+++ linux-2.6.11.fixes/arch/ppc64/kernel/ItLpQueue.c	Sun Mar 20 08:48:29 2005
@@ -142,7 +142,9 @@ unsigned ItLpQueue_process( struct ItLpQ
 				lpQueue->xLpIntCountByType[nextLpEvent->xType]++;
 			if ( nextLpEvent->xType < HvLpEvent_Type_NumTypes &&
 			     lpEventHandler[nextLpEvent->xType] ) 
+				rcu_read_lock();
 				lpEventHandler[nextLpEvent->xType](nextLpEvent, regs);
+				rcu_read_unlock();
 			else
 				printk(KERN_INFO "Unexpected Lp Event type=%d\n", nextLpEvent->xType );
 			
diff -urpN -X dontdiff linux-2.6.11/arch/x86_64/kernel/mce.c linux-2.6.11.fixes/arch/x86_64/kernel/mce.c
--- linux-2.6.11/arch/x86_64/kernel/mce.c	Tue Mar  1 23:37:52 2005
+++ linux-2.6.11.fixes/arch/x86_64/kernel/mce.c	Sun Mar 20 08:49:45 2005
@@ -392,7 +392,7 @@ static ssize_t mce_read(struct file *fil
 	memset(mcelog.entry, 0, next * sizeof(struct mce));
 	mcelog.next = 0;
 
-	synchronize_kernel();	
+	synchronize_kernel_barrier();	
 
 	/* Collect entries that were still getting written before the synchronize. */
 
diff -urpN -X dontdiff linux-2.6.11/drivers/acpi/processor_idle.c linux-2.6.11.fixes/drivers/acpi/processor_idle.c
--- linux-2.6.11/drivers/acpi/processor_idle.c	Tue Mar  1 23:38:25 2005
+++ linux-2.6.11.fixes/drivers/acpi/processor_idle.c	Sun Mar 20 09:01:44 2005
@@ -838,7 +838,7 @@ int acpi_processor_cst_has_changed (stru
 
 	/* Fall back to the default idle loop */
 	pm_idle = pm_idle_save;
-	synchronize_kernel();
+	synchronize_kernel_barrier(); /* FIXME: strong enough? */
 
 	pr->flags.power = 0;
 	result = acpi_processor_get_power_info(pr);
diff -urpN -X dontdiff linux-2.6.11/drivers/char/ipmi/ipmi_si_intf.c linux-2.6.11.fixes/drivers/char/ipmi/ipmi_si_intf.c
--- linux-2.6.11/drivers/char/ipmi/ipmi_si_intf.c	Sat Mar 19 14:04:13 2005
+++ linux-2.6.11.fixes/drivers/char/ipmi/ipmi_si_intf.c	Sun Mar 20 08:39:49 2005
@@ -2194,7 +2194,7 @@ static int init_one_smi(int intf_num, st
 	/* Wait until we know that we are out of any interrupt
 	   handlers might have been running before we freed the
 	   interrupt. */
-	synchronize_kernel();
+	synchronize_kernel_barrier();
 
 	if (new_smi->si_sm) {
 		if (new_smi->handlers)
@@ -2307,7 +2307,7 @@ static void __exit cleanup_one_si(struct
 	/* Wait until we know that we are out of any interrupt
 	   handlers might have been running before we freed the
 	   interrupt. */
-	synchronize_kernel();
+	synchronize_kernel_barrier();
 
 	/* Wait for the timer to stop.  This avoids problems with race
 	   conditions removing the timer here. */
diff -urpN -X dontdiff linux-2.6.11/drivers/input/keyboard/atkbd.c linux-2.6.11.fixes/drivers/input/keyboard/atkbd.c
--- linux-2.6.11/drivers/input/keyboard/atkbd.c	Sat Mar 19 14:04:16 2005
+++ linux-2.6.11.fixes/drivers/input/keyboard/atkbd.c	Sun Mar 20 09:02:33 2005
@@ -678,7 +678,7 @@ static void atkbd_disconnect(struct seri
 	atkbd_disable(atkbd);
 
 	/* make sure we don't have a command in flight */
-	synchronize_kernel();
+	synchronize_kernel_barrier(); /* FIXME: Strong enough? */
 	flush_scheduled_work();
 
 	device_remove_file(&serio->dev, &atkbd_attr_extra);
diff -urpN -X dontdiff linux-2.6.11/drivers/input/serio/i8042.c linux-2.6.11.fixes/drivers/input/serio/i8042.c
--- linux-2.6.11/drivers/input/serio/i8042.c	Sat Mar 19 14:04:16 2005
+++ linux-2.6.11.fixes/drivers/input/serio/i8042.c	Sun Mar 20 09:27:35 2005
@@ -396,7 +396,7 @@ static void i8042_stop(struct serio *ser
 	struct i8042_port *port = serio->port_data;
 
 	port->exists = 0;
-	synchronize_kernel();
+	synchronize_kernel_barrier(); /* FIXME: Strong enough? */
 	port->serio = NULL;
 }
 
diff -urpN -X dontdiff linux-2.6.11/drivers/net/r8169.c linux-2.6.11.fixes/drivers/net/r8169.c
--- linux-2.6.11/drivers/net/r8169.c	Sat Mar 19 14:04:19 2005
+++ linux-2.6.11.fixes/drivers/net/r8169.c	Sun Mar 20 09:09:06 2005
@@ -2385,7 +2385,7 @@ core_down:
 	}
 
 	/* Give a racing hard_start_xmit a few cycles to complete. */
-	synchronize_kernel();
+	synchronize_kernel_barrier(); /* FIXME: Strong enough? */
 
 	/*
 	 * And now for the 50k$ question: are IRQ disabled or not ?
diff -urpN -X dontdiff linux-2.6.11/drivers/s390/cio/airq.c linux-2.6.11.fixes/drivers/s390/cio/airq.c
--- linux-2.6.11/drivers/s390/cio/airq.c	Tue Mar  1 23:38:17 2005
+++ linux-2.6.11.fixes/drivers/s390/cio/airq.c	Sun Mar 20 09:11:57 2005
@@ -45,7 +45,7 @@ s390_register_adapter_interrupt (adapter
 	else
 		ret = (cmpxchg(&adapter_handler, NULL, handler) ? -EBUSY : 0);
 	if (!ret)
-		synchronize_kernel();
+		synchronize_kernel_barrier(); /* FIXME: Strong enough? */
 
 	sprintf (dbf_txt, "ret:%d", ret);
 	CIO_TRACE_EVENT (4, dbf_txt);
@@ -65,7 +65,7 @@ s390_unregister_adapter_interrupt (adapt
 		ret = -EINVAL;
 	else {
 		adapter_handler = NULL;
-		synchronize_kernel();
+		synchronize_kernel_barrier(); /* FIXME: Strong enough? */
 		ret = 0;
 	}
 	sprintf (dbf_txt, "ret:%d", ret);
diff -urpN -X dontdiff linux-2.6.11/include/linux/rcupdate.h linux-2.6.11.fixes/include/linux/rcupdate.h
--- linux-2.6.11/include/linux/rcupdate.h	Sat Mar 19 14:09:52 2005
+++ linux-2.6.11.fixes/include/linux/rcupdate.h	Sun Mar 20 09:24:20 2005
@@ -222,6 +222,8 @@ static inline int rcu_pending(int cpu)
  */
 #define rcu_read_unlock_bh()	local_bh_enable()
 
+#endif /* CONFIG_PREEMPT_RT */
+
 /**
  * rcu_dereference - fetch an RCU-protected pointer in an
  * RCU read-side critical section.  This pointer may later
@@ -256,6 +258,22 @@ static inline int rcu_pending(int cpu)
 						(p) = (v); \
 					})
 
+#ifndef CONFIG_PREEMPT_RT
+
+/**
+ * synchronize_kernel_barrier - block until each CPU executes a
+ * context switch, appears in the idle loop, or otherwise exits
+ * kernel execution.  This is synonymous with synchronize_kernel()
+ * in the classic RCU implementation, but not in some RCU
+ * implementations optimized for realtime use.  In these realtime
+ * uses, synchronize_kernel() can potentially return immediately,
+ * even on SMP systems.
+ *
+ * NMI-related uses of RCU need to use synchronize_kernel_barrier().
+ */
+
+#define synchronize_kernel_barrer() synchronize_kernel()
+
 extern void rcu_init(void);
 extern void rcu_check_callbacks(int cpu, int user);
 extern void rcu_restart_cpu(int cpu);
@@ -275,40 +293,6 @@ extern void synchronize_kernel(void);
 #define rcu_bh_qsctr_inc(cpu)
 #define rcu_qsctr_inc(cpu)
 
-/**
- * rcu_dereference - fetch an RCU-protected pointer in an
- * RCU read-side critical section.  This pointer may later
- * be safely dereferenced.
- *
- * Inserts memory barriers on architectures that require them
- * (currently only the Alpha), and, more importantly, documents
- * exactly which pointers are protected by RCU.
- */
-
-#define rcu_dereference(p)     ({ \
-				typeof(p) _________p1 = p; \
-				smp_read_barrier_depends(); \
-				(_________p1); \
-				})
-
-/**
- * rcu_assign_pointer - assign (publicize) a pointer to a newly
- * initialized structure that will be dereferenced by RCU read-side
- * critical sections.  Returns the value assigned.
- *
- * Inserts memory barriers on architectures that require them
- * (pretty much all of them other than x86), and also prevents
- * the compiler from reordering the code that initializes the
- * structure after the pointer assignment.  More importantly, this
- * call documents which pointers will be dereferenced by RCU read-side
- * code.
- */
-
-#define rcu_assign_pointer(p, v)	({ \
-						smp_wmb(); \
-						(p) = (v); \
-					})
-
 extern void rcu_init(void);
 
 /* Exported interfaces */
@@ -317,6 +301,7 @@ extern void FASTCALL(call_rcu(struct rcu
 extern void rcu_read_lock(void);
 extern void rcu_read_unlock(void);
 extern void synchronize_kernel(void);
+extern void synchronize_kernel_barrier(void);
 extern int rcu_pending(int cpu);
 extern void rcu_check_callbacks(int cpu, int user);
 
diff -urpN -X dontdiff linux-2.6.11/kernel/module.c linux-2.6.11.fixes/kernel/module.c
--- linux-2.6.11/kernel/module.c	Sat Mar 19 14:09:51 2005
+++ linux-2.6.11.fixes/kernel/module.c	Sun Mar 20 09:13:23 2005
@@ -1812,7 +1812,7 @@ sys_init_module(void __user *umod,
 		/* Init routine failed: abort.  Try to protect us from
                    buggy refcounters. */
 		mod->state = MODULE_STATE_GOING;
-		synchronize_kernel();
+		synchronize_kernel_barrier(); /* FIXME: Strong enough? */
 		if (mod->unsafe)
 			printk(KERN_ERR "%s: module is now stuck!\n",
 			       mod->name);
diff -urpN -X dontdiff linux-2.6.11/kernel/profile.c linux-2.6.11.fixes/kernel/profile.c
--- linux-2.6.11/kernel/profile.c	Sat Mar 19 14:09:51 2005
+++ linux-2.6.11.fixes/kernel/profile.c	Sun Mar 20 09:18:05 2005
@@ -194,7 +194,7 @@ void unregister_timer_hook(int (*hook)(s
 	WARN_ON(hook != timer_hook);
 	timer_hook = NULL;
 	/* make sure all CPUs see the NULL hook */
-	synchronize_kernel();
+	synchronize_kernel_barrier(); /* FIXME: Strong enough? */
 }
 
 EXPORT_SYMBOL_GPL(register_timer_hook);
diff -urpN -X dontdiff linux-2.6.11/kernel/rcupdate.c linux-2.6.11.fixes/kernel/rcupdate.c
--- linux-2.6.11/kernel/rcupdate.c	Sat Mar 19 14:09:51 2005
+++ linux-2.6.11.fixes/kernel/rcupdate.c	Sun Mar 20 09:32:13 2005
@@ -548,7 +548,37 @@ void synchronize_kernel(void)
 	}
 }
 
-void rcu_advance_callbacks(void)
+/*
+ * FIXME: Note that this implementation might not be strong enough
+ * for a number of driver uses of synchronize_kernel.  Some of these
+ * uses seem to assume a non-CONFIG_PREEMPT kernel, so may need
+ * to come up with a different approach.  Note that these uses
+ * are -not- waiting to free memory, but rather to ensure that
+ * a change is seen by all future driver invocations.
+ *
+ * The correct implementation is likely to be a tasklist scan,
+ * which blocks until all tasks encounter a voluntary context switch.
+ * If so, this implementation is required in CONFIG_PREEMPT
+ * kernels as well as CONFIG_PREEMPT_RT kernels.
+ */
+
+void synchronize_kernel_barrier(void)
+{
+	cpumask_t oldmask;
+	cpumask_t curmask;
+	int cpu;
+
+	if (sched_getaffinity(0, &oldmask) < 0) {
+		oldmask = cpu_possible_mask;
+	}
+	for_each_cpu(cpu) {
+		sched_setaffinity(0, cpumask_of_cpu(cpu));
+		schedule();
+	}
+	sched_setaffinity(0, oldmask);
+}
+
+static void rcu_advance_callbacks(void)
 {
 	struct rcu_data *rdp;
 
@@ -578,7 +608,7 @@ void fastcall call_rcu(struct rcu_head *
 	put_cpu_var(rcu_data);
 }
 
-void rcu_process_callbacks(void)
+static void rcu_process_callbacks(void)
 {
 	struct rcu_head *next, *list;
 	struct rcu_data *rdp;
