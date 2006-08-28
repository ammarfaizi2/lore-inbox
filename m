Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbWH1GRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbWH1GRQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 02:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWH1GRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 02:17:16 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:38339 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751396AbWH1GRP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 02:17:15 -0400
Subject: Re: Is stopmachine() preempt safe?
From: Rusty Russell <rusty@rustcorp.com.au>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <16193.1156733718@ocs10w.ocs.com.au>
References: <16193.1156733718@ocs10w.ocs.com.au>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 16:17:11 +1000
Message-Id: <1156745831.10467.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-28 at 12:55 +1000, Keith Owens wrote:
> Rusty Russell (on Mon, 28 Aug 2006 09:38:55 +1000) wrote:
> >On Sun, 2006-08-27 at 19:42 +1000, Keith Owens wrote:
> >> I cannot convince myself that stopmachine() is preempt safe.  What
> >> prevents this race with CONFIG_PREEMPT=y?
> >
> >Nothing.  Read side is preempt_disable.  Write side is stopmachine.
> 
> That is very worrying.  The whole point of stopmachine is to get all
> cpus to a known state with no locally cached global data, so the caller
> of stopmachine can safely fiddle with some global data (like updating
> the module lists).  But CONFIG_PREEMPT defeats this and turns any code
> that relies on stopmachine into a race.

Hi Keith,

	Do not panic: this is not a bug, and was never how stop_machine was to
be used.  try_module_get() disables preemption, and you are supposed to
disable preemption (or take cpu_hotplug_lock) when relying on
cpu_online_map.  Grep tells me that mm/page_alloc.c now uses it too:
looks like __alloc_pages might be buggy with this?

	I thought the comment on stop_machine_run made this pretty plain:

 * Description: This causes a thread to be scheduled on every other cpu,
 * each of which disables interrupts, and finally interrupts are disabled
 * on the current CPU.  The result is that noone is holding a spinlock
 * or inside any other preempt-disabled region when @fn() runs.
 *
 * This can be thought of as a very heavy write lock, equivalent to
 * grabbing every spinlock in the kernel. */

> At which point they have no locally cached global data, making
> stopmachine race safe again.

My main reason for considering a change is to get rid of the
preempt_disable()/preempt_enable() around try_module_get(), not to fix
any existing bugs.  Now we have multiple users, the branches in the
sched fastpath are probably worth it.

As to bug fixes, if people didn't understand how it worked before, I'm
not convinced making it more magic is really going to help them...

Here's an untested example patch:

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc4/Documentation/cpu-hotplug.txt working-2.6.18-rc4-stop_machine_no_preempt/Documentation/cpu-hotplug.txt
--- linux-2.6.18-rc4/Documentation/cpu-hotplug.txt	2006-08-10 11:27:59.000000000 +1000
+++ working-2.6.18-rc4-stop_machine_no_preempt/Documentation/cpu-hotplug.txt	2006-08-28 15:16:40.000000000 +1000
@@ -111,12 +111,12 @@ for_each_cpu_mask(x,mask) - Iterate over
 #include <linux/cpu.h>
 lock_cpu_hotplug() and unlock_cpu_hotplug():
 
-The above calls are used to inhibit cpu hotplug operations. While holding the
-cpucontrol mutex, cpu_online_map will not change. If you merely need to avoid
-cpus going away, you could also use preempt_disable() and preempt_enable()
-for those sections. Just remember the critical section cannot call any
-function that can sleep or schedule this process away. The preempt_disable()
-will work as long as stop_machine_run() is used to take a cpu down.
+The above calls are used to inhibit cpu hotplug operations while
+sleeping. While holding the cpucontrol mutex, cpu_online_map will not
+change. If you merely need to avoid cpus going away, simply avoid
+calling any function that can sleep or schedule this process away.
+(This will work as long as stop_machine_run() is used to take a cpu
+down).
 
 CPU Hotplug - Frequently Asked Questions.
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc4/include/linux/module.h working-2.6.18-rc4-stop_machine_no_preempt/include/linux/module.h
--- linux-2.6.18-rc4/include/linux/module.h	2006-08-10 11:29:15.000000000 +1000
+++ working-2.6.18-rc4-stop_machine_no_preempt/include/linux/module.h	2006-08-28 15:22:07.000000000 +1000
@@ -17,7 +17,7 @@
 #include <linux/stringify.h>
 #include <linux/kobject.h>
 #include <linux/moduleparam.h>
-#include <asm/local.h>
+#include <asm/atomic.h>
 
 #include <asm/module.h>
 
@@ -216,7 +216,7 @@ void *__symbol_get_gpl(const char *symbo
 
 struct module_ref
 {
-	local_t count;
+	atomic_t count;
 } ____cacheline_aligned;
 
 enum module_state
@@ -386,8 +386,7 @@ static inline void __module_get(struct m
 {
 	if (module) {
 		BUG_ON(module_refcount(module) == 0);
-		local_inc(&module->ref[get_cpu()].count);
-		put_cpu();
+		atomic_inc(&module->ref[raw_smp_processor_id()].count);
 	}
 }
 
@@ -396,12 +395,10 @@ static inline int try_module_get(struct 
 	int ret = 1;
 
 	if (module) {
-		unsigned int cpu = get_cpu();
 		if (likely(module_is_live(module)))
-			local_inc(&module->ref[cpu].count);
+			atomic_inc(&module->ref[raw_smp_processor_id()].count);
 		else
 			ret = 0;
-		put_cpu();
 	}
 	return ret;
 }
@@ -409,12 +406,10 @@ static inline int try_module_get(struct 
 static inline void module_put(struct module *module)
 {
 	if (module) {
-		unsigned int cpu = get_cpu();
-		local_dec(&module->ref[cpu].count);
+		atomic_dec(&module->ref[raw_smp_processor_id()].count);
 		/* Maybe they're waiting for us to drop reference? */
 		if (unlikely(!module_is_live(module)))
 			wake_up_process(module->waiter);
-		put_cpu();
 	}
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc4/include/linux/sched.h working-2.6.18-rc4-stop_machine_no_preempt/include/linux/sched.h
--- linux-2.6.18-rc4/include/linux/sched.h	2006-08-10 11:29:16.000000000 +1000
+++ working-2.6.18-rc4-stop_machine_no_preempt/include/linux/sched.h	2006-08-28 15:08:20.000000000 +1000
@@ -126,7 +126,9 @@ extern unsigned long nr_uninterruptible(
 extern unsigned long nr_active(void);
 extern unsigned long nr_iowait(void);
 extern unsigned long weighted_cpuload(const int cpu);
-
+#ifdef CONFIG_PREEMPT
+DECLARE_PER_CPU(struct task_struct *, stop_machine_thread);
+#endif
 
 /*
  * Task state bitmask. NOTE! These bits are also
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc4/include/linux/stop_machine.h working-2.6.18-rc4-stop_machine_no_preempt/include/linux/stop_machine.h
--- linux-2.6.18-rc4/include/linux/stop_machine.h	2006-08-10 11:29:16.000000000 +1000
+++ working-2.6.18-rc4-stop_machine_no_preempt/include/linux/stop_machine.h	2006-08-28 15:01:30.000000000 +1000
@@ -1,13 +1,13 @@
 #ifndef _LINUX_STOP_MACHINE
 #define _LINUX_STOP_MACHINE
-/* "Bogolock": stop the entire machine, disable interrupts.  This is a
-   very heavy lock, which is equivalent to grabbing every spinlock
-   (and more).  So the "read" side to such a lock is anything which
-   diables preeempt. */
+
+/* "Bogolock": flushes all preempted tasks, stop the entire machine,
+   disable interrupts.  This is a very heavy lock, which is equivalent
+   to grabbing every spinlock (and more).  So the "read" side to such
+   a lock is anything which doesn't sleep. */
 #include <linux/cpu.h>
 #include <asm/system.h>
 
-#if defined(CONFIG_STOP_MACHINE) && defined(CONFIG_SMP)
 /**
  * stop_machine_run: freeze the machine on all CPUs and run this function
  * @fn: the function to run
@@ -36,16 +36,4 @@ int stop_machine_run(int (*fn)(void *), 
 struct task_struct *__stop_machine_run(int (*fn)(void *), void *data,
 				       unsigned int cpu);
 
-#else
-
-static inline int stop_machine_run(int (*fn)(void *), void *data,
-				   unsigned int cpu)
-{
-	int ret;
-	local_irq_disable();
-	ret = fn(data);
-	local_irq_enable();
-	return ret;
-}
-#endif /* CONFIG_SMP */
 #endif /* _LINUX_STOP_MACHINE */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc4/init/Kconfig working-2.6.18-rc4-stop_machine_no_preempt/init/Kconfig
--- linux-2.6.18-rc4/init/Kconfig	2006-08-10 11:29:18.000000000 +1000
+++ working-2.6.18-rc4-stop_machine_no_preempt/init/Kconfig	2006-08-28 15:18:57.000000000 +1000
@@ -502,13 +502,6 @@ config KMOD
 	  automatically: when a part of the kernel needs a module, it
 	  runs modprobe with the appropriate arguments, thereby
 	  loading the module if it is available.  If unsure, say Y.
-
-config STOP_MACHINE
-	bool
-	default y
-	depends on (SMP && MODULE_UNLOAD) || HOTPLUG_CPU
-	help
-	  Need stop_machine() primitive.
 endmenu
 
 menu "Block layer"
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc4/kernel/Makefile working-2.6.18-rc4-stop_machine_no_preempt/kernel/Makefile
--- linux-2.6.18-rc4/kernel/Makefile	2006-08-10 11:29:18.000000000 +1000
+++ working-2.6.18-rc4-stop_machine_no_preempt/kernel/Makefile	2006-08-28 15:19:14.000000000 +1000
@@ -8,7 +8,7 @@ obj-y     = sched.o fork.o exec_domain.o
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o extable.o params.o posix-timers.o \
 	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o mutex.o \
-	    hrtimer.o rwsem.o
+	    hrtimer.o rwsem.o stop_machine.o
 
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
 obj-y += time/
@@ -38,7 +38,6 @@ obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CPUSETS) += cpuset.o
 obj-$(CONFIG_IKCONFIG) += configs.o
-obj-$(CONFIG_STOP_MACHINE) += stop_machine.o
 obj-$(CONFIG_AUDIT) += audit.o auditfilter.o
 obj-$(CONFIG_AUDITSYSCALL) += auditsc.o
 obj-$(CONFIG_KPROBES) += kprobes.o
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc4/kernel/module.c working-2.6.18-rc4-stop_machine_no_preempt/kernel/module.c
--- linux-2.6.18-rc4/kernel/module.c	2006-08-10 11:29:19.000000000 +1000
+++ working-2.6.18-rc4-stop_machine_no_preempt/kernel/module.c	2006-08-28 15:23:16.000000000 +1000
@@ -498,9 +498,9 @@ static void module_unload_init(struct mo
 
 	INIT_LIST_HEAD(&mod->modules_which_use_me);
 	for (i = 0; i < NR_CPUS; i++)
-		local_set(&mod->ref[i].count, 0);
+		atomic_set(&mod->ref[i].count, 0);
 	/* Hold reference count during initialization. */
-	local_set(&mod->ref[raw_smp_processor_id()].count, 1);
+	atomic_set(&mod->ref[raw_smp_processor_id()].count, 1);
 	/* Backwards compatibility macros put refcount during init. */
 	mod->waiter = current;
 }
@@ -620,7 +620,7 @@ unsigned int module_refcount(struct modu
 	unsigned int i, total = 0;
 
 	for (i = 0; i < NR_CPUS; i++)
-		total += local_read(&mod->ref[i].count);
+		total += atomic_read(&mod->ref[i].count);
 	return total;
 }
 EXPORT_SYMBOL(module_refcount);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc4/kernel/sched.c working-2.6.18-rc4-stop_machine_no_preempt/kernel/sched.c
--- linux-2.6.18-rc4/kernel/sched.c	2006-08-10 11:29:19.000000000 +1000
+++ working-2.6.18-rc4-stop_machine_no_preempt/kernel/sched.c	2006-08-28 15:46:53.000000000 +1000
@@ -266,6 +266,7 @@ struct rq {
 };
 
 static DEFINE_PER_CPU(struct rq, runqueues);
+DEFINE_PER_CPU(struct task_struct *, stop_machine_thread);
 
 /*
  * The domain tree (rq->sd) is protected by RCU's quiescent state transition.
@@ -3245,6 +3246,45 @@ EXPORT_SYMBOL(sub_preempt_count);
 
 #endif
 
+#ifdef CONFIG_PREEMPT
+static inline struct task_struct *find_preempted_task(const struct rq *rq)
+{
+	unsigned int i, j;
+	for (i = 0; i < 2; i++) {
+		const struct prio_array *arr = &rq->arrays[i];
+		for (j = 0; j < MAX_PRIO; j++) {
+			struct task_struct *t;
+			list_for_each_entry(t, &arr->queue[j], run_list) {
+				if (task_thread_info(t)->preempt_count
+				    & PREEMPT_ACTIVE)
+					return t;
+			}
+		}
+	}
+	return NULL;
+}
+
+static inline struct task_struct *flush_for_stop_machine(const struct rq *rq)
+{
+	if (likely(__get_cpu_var(stop_machine_thread)))
+		return NULL;
+
+	if (preempt_count() & PREEMPT_ACTIVE)
+		return current;
+	else {
+		struct task_struct *tsk = find_preempted_task(rq);
+		if (!tsk)
+			tsk = __get_cpu_var(stop_machine_thread);
+		return tsk;
+	}
+}
+#else  /* ... !CONFIG_PREEMPT */
+static inline struct task_struct *flush_for_stop_machine(const struct rq *rq)
+{
+	return NULL;
+}
+#endif /* !CONFIG_PREEMPT */
+
 static inline int interactive_sleep(enum sleep_type sleep_type)
 {
 	return (sleep_type == SLEEP_INTERACTIVE ||
@@ -3327,6 +3367,9 @@ need_resched_nonpreemptible:
 		}
 	}
 
+	if (unlikely(next = flush_for_stop_machine(rq)))
+		goto switch_tasks;
+
 	cpu = smp_processor_id();
 	if (unlikely(!rq->nr_running)) {
 		idle_balance(cpu, rq);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc4/kernel/stop_machine.c working-2.6.18-rc4-stop_machine_no_preempt/kernel/stop_machine.c
--- linux-2.6.18-rc4/kernel/stop_machine.c	2006-03-23 12:45:07.000000000 +1100
+++ working-2.6.18-rc4-stop_machine_no_preempt/kernel/stop_machine.c	2006-08-28 15:29:07.000000000 +1000
@@ -8,6 +8,27 @@
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
 
+#ifdef CONFIG_PREEMPT
+static void start_preempt_flush(void)
+{
+	__get_cpu_var(stop_machine_thread) = current;
+}
+
+static void stop_preempt_flush(void)
+{
+	__get_cpu_var(stop_machine_thread) = NULL;
+}
+#else /* !CONFIG_PREEMPT */
+static void start_preempt_flush(void)
+{
+}
+
+static void stop_preempt_flush(void)
+{
+}
+#endif /* CONFIG_PREEMPT */
+
+#ifdef CONFIG_SMP
 /* Since we effect priority and affinity (both of which are visible
  * to, and settable by outside processes) we do indirection via a
  * kthread. */
@@ -47,9 +68,8 @@ static int stopmachine(void *cpu)
 			atomic_inc(&stopmachine_thread_ack);
 		} else if (stopmachine_state == STOPMACHINE_PREPARE
 			   && !prepared) {
-			/* Everyone is in place, hold CPU. */
-			preempt_disable();
-			prepared = 1;
+			/* Everyone is in place, flush preempted tasks. */
+			start_preempt_flush();
 			smp_mb(); /* Must read state first. */
 			atomic_inc(&stopmachine_thread_ack);
 		}
@@ -68,7 +88,7 @@ static int stopmachine(void *cpu)
 	if (irqs_disabled)
 		local_irq_enable();
 	if (prepared)
-		preempt_enable();
+		stop_preempt_flush();
 
 	return 0;
 }
@@ -115,9 +135,9 @@ static int stop_machine(void)
 		return ret;
 	}
 
-	/* Now they are all started, make them hold the CPUs, ready. */
-	preempt_disable();
+	/* Now they are all started, make them flush preempted tasks. */
 	stopmachine_set_state(STOPMACHINE_PREPARE);
+	start_preempt_flush();
 
 	/* Make them disable irqs. */
 	local_irq_disable();
@@ -130,7 +150,7 @@ static void restart_machine(void)
 {
 	stopmachine_set_state(STOPMACHINE_EXIT);
 	local_irq_enable();
-	preempt_enable_no_resched();
+	stop_preempt_flush();
 }
 
 struct stop_machine_data
@@ -206,3 +226,20 @@ int stop_machine_run(int (*fn)(void *), 
 
 	return ret;
 }
+#else  /* !CONFIG_SMP */
+int stop_machine_run(int (*fn)(void *), void *data, unsigned int cpu)
+{
+	int ret;
+
+	start_preempt_flush();
+	schedule();
+
+	local_irq_disable();
+	ret = fn(data);
+	local_irq_enable();
+
+	stop_preempt_flush();
+
+	return ret;
+}
+#endif /* CONFIG_SMP */

-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

