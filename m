Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267263AbTAGCL6>; Mon, 6 Jan 2003 21:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267268AbTAGCL6>; Mon, 6 Jan 2003 21:11:58 -0500
Received: from h-64-105-35-112.SNVACAID.covad.net ([64.105.35.112]:56022 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267263AbTAGCLs>; Mon, 6 Jan 2003 21:11:48 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 6 Jan 2003 18:19:57 -0800
Message-Id: <200301070219.SAA12905@adam.yggdrasil.com>
To: rusty@rustcorp.com.au
Subject: Another idea for simplifying locking in kernel/module.c
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Here is a way to replace all of the specialized "stop CPU"
locking code in kernel/module.c with an rw_semaphore by using
down_read_trylock in try_module_get() and down_write when beginning to
unload the module.

	The following UNTESTED patch, a net deletion of 136 lines,
illustrates the basic idea.  I've only verified that the resulting
kernel/module.c compiles.  I'm sorry that I can't test it right now as
I'm in the midst of working on something else.

	By the way, I think this change could also help eliminate the
module->state variable, which I believe currently can change while
a reader could be trying to read it.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--- linux-2.5.54/include/linux/module.h	2003-01-01 19:22:53.000000000 -0800
+++ linux/include/linux/module.h	2003-01-06 17:17:17.000000000 -0800
@@ -13,12 +13,13 @@
 #include <linux/stat.h>
 #include <linux/compiler.h>
 #include <linux/cache.h>
 #include <linux/kmod.h>
 #include <linux/elf.h>
 #include <linux/stringify.h>
+#include <linux/rwsem.h>
 
 #include <asm/module.h>
 #include <asm/uaccess.h> /* For struct exception_table_entry */
 
 /* Not Yet Implemented */
 #define MODULE_LICENSE(name)
@@ -147,12 +148,14 @@
 	struct mod_arch_specific arch;
 
 	/* Am I unsafe to unload? */
 	int unsafe;
 
 #ifdef CONFIG_MODULE_UNLOAD
+	struct rw_semaphore	unload_rwsem;
+
 	/* Reference counts */
 	struct module_ref ref[NR_CPUS];
 
 	/* What modules depend on me? */
 	struct list_head modules_which_use_me;
 
@@ -198,15 +201,16 @@
 static inline int try_module_get(struct module *module)
 {
 	int ret = 1;
 
 	if (module) {
 		unsigned int cpu = get_cpu();
-		if (likely(module_is_live(module)))
+		if (down_read_trylock(&module->unload_rwsem)) {
 			local_inc(&module->ref[cpu].count);
-		else
+			up_read(&module->unload_rwsem);
+		} else
 			ret = 0;
 		put_cpu();
 	}
 	return ret;
 }
 
--- linux-2.5.54/kernel/module.c	2003-01-01 19:22:35.000000000 -0800
+++ linux/kernel/module.c	2003-01-06 17:29:09.000000000 -0800
@@ -18,6 +18,7 @@
 */
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/module_rwsem.h>
 #include <linux/moduleloader.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -126,6 +127,10 @@
 {
 	unsigned int i;
 
+	init_rwsem(&mod->unload_rwsem);
+	down_read(&mod->unload_rwsem);
+	/* Prevent unloading of module until module_init() completes. */
+
 	INIT_LIST_HEAD(&mod->modules_which_use_me);
 	for (i = 0; i < NR_CPUS; i++)
 		atomic_set(&mod->ref[i].count, 0);
@@ -195,154 +200,6 @@
 	}
 }
 
-#ifdef CONFIG_SMP
-/* Thread to stop each CPU in user context. */
-enum stopref_state {
-	STOPREF_WAIT,
-	STOPREF_PREPARE,
-	STOPREF_DISABLE_IRQ,
-	STOPREF_EXIT,
-};
-
-static enum stopref_state stopref_state;
-static unsigned int stopref_num_threads;
-static atomic_t stopref_thread_ack;
-
-static int stopref(void *cpu)
-{
-	int irqs_disabled = 0;
-	int prepared = 0;
-
-	sprintf(current->comm, "kmodule%lu\n", (unsigned long)cpu);
-
-	/* Highest priority we can manage, and move to right CPU. */
-#if 0 /* FIXME */
-	struct sched_param param = { .sched_priority = MAX_RT_PRIO-1 };
-	setscheduler(current->pid, SCHED_FIFO, &param);
-#endif
-	set_cpus_allowed(current, 1UL << (unsigned long)cpu);
-
-	/* Ack: we are alive */
-	atomic_inc(&stopref_thread_ack);
-
-	/* Simple state machine */
-	while (stopref_state != STOPREF_EXIT) {
-		if (stopref_state == STOPREF_DISABLE_IRQ && !irqs_disabled) {
-			local_irq_disable();
-			irqs_disabled = 1;
-			/* Ack: irqs disabled. */
-			atomic_inc(&stopref_thread_ack);
-		} else if (stopref_state == STOPREF_PREPARE && !prepared) {
-			/* Everyone is in place, hold CPU. */
-			preempt_disable();
-			prepared = 1;
-			atomic_inc(&stopref_thread_ack);
-		}
-		if (irqs_disabled || prepared)
-			cpu_relax();
-		else
-			yield();
-	}
-
-	/* Ack: we are exiting. */
-	atomic_inc(&stopref_thread_ack);
-
-	if (irqs_disabled)
-		local_irq_enable();
-	if (prepared)
-		preempt_enable();
-
-	return 0;
-}
-
-/* Change the thread state */
-static void stopref_set_state(enum stopref_state state, int sleep)
-{
-	atomic_set(&stopref_thread_ack, 0);
-	wmb();
-	stopref_state = state;
-	while (atomic_read(&stopref_thread_ack) != stopref_num_threads) {
-		if (sleep)
-			yield();
-		else
-			cpu_relax();
-	}
-}
-
-/* Stop the machine.  Disables irqs. */
-static int stop_refcounts(void)
-{
-	unsigned int i, cpu;
-	unsigned long old_allowed;
-	int ret = 0;
-
-	/* One thread per cpu.  We'll do our own. */
-	cpu = smp_processor_id();
-
-	/* FIXME: racy with set_cpus_allowed. */
-	old_allowed = current->cpus_allowed;
-	set_cpus_allowed(current, 1UL << (unsigned long)cpu);
-
-	atomic_set(&stopref_thread_ack, 0);
-	stopref_num_threads = 0;
-	stopref_state = STOPREF_WAIT;
-
-	/* No CPUs can come up or down during this. */
-	down(&cpucontrol);
-
-	for (i = 0; i < NR_CPUS; i++) {
-		if (i == cpu || !cpu_online(i))
-			continue;
-		ret = kernel_thread(stopref, (void *)(long)i, CLONE_KERNEL);
-		if (ret < 0)
-			break;
-		stopref_num_threads++;
-	}
-
-	/* Wait for them all to come to life. */
-	while (atomic_read(&stopref_thread_ack) != stopref_num_threads)
-		yield();
-
-	/* If some failed, kill them all. */
-	if (ret < 0) {
-		stopref_set_state(STOPREF_EXIT, 1);
-		up(&cpucontrol);
-		return ret;
-	}
-
-	/* Don't schedule us away at this point, please. */
-	preempt_disable();
-
-	/* Now they are all scheduled, make them hold the CPUs, ready. */
-	stopref_set_state(STOPREF_PREPARE, 0);
-
-	/* Make them disable irqs. */
-	stopref_set_state(STOPREF_DISABLE_IRQ, 0);
-
-	local_irq_disable();
-	return 0;
-}
-
-/* Restart the machine.  Re-enables irqs. */
-static void restart_refcounts(void)
-{
-	stopref_set_state(STOPREF_EXIT, 0);
-	local_irq_enable();
-	preempt_enable();
-	up(&cpucontrol);
-}
-#else /* ...!SMP */
-static inline int stop_refcounts(void)
-{
-	local_irq_disable();
-	return 0;
-}
-static inline void restart_refcounts(void)
-{
-	local_irq_enable();
-}
-#endif
-
 static unsigned int module_refcount(struct module *mod)
 {
 	unsigned int i, total = 0;
@@ -378,7 +235,8 @@
 {
 	struct module *mod;
 	char name[MODULE_NAME_LEN];
-	int ret, forced = 0;
+	int ret = 0;
+	int forced = 0;
 
 	if (!capable(CAP_SYS_MODULE))
 		return -EPERM;
@@ -431,25 +289,21 @@
 			goto out;
 		}
 	}
-	/* Stop the machine so refcounts can't move: irqs disabled. */
-	DEBUGP("Stopping refcounts...\n");
-	ret = stop_refcounts();
-	if (ret != 0)
-		goto out;
+
+	down_write(&mod->unload_rwsem);
 
 	/* If it's not unused, quit unless we are told to block. */
 	if ((flags & O_NONBLOCK) && module_refcount(mod) != 0) {
 		forced = try_force(flags);
-		if (!forced)
+		if (!forced) {
+			up_write(&mod->unload_rwsem);
 			ret = -EWOULDBLOCK;
+			goto out;
+		}
 	} else {
 		mod->waiter = current;
 		mod->state = MODULE_STATE_GOING;
 	}
-	restart_refcounts();
-
-	if (ret != 0)
-		goto out;
 
 	if (forced)
 		goto destroy;
@@ -471,9 +325,12 @@
  destroy:
 	/* Final destruction now noone is using it. */
 	mod->exit();
+	up_write(&mod->unload_rwsem);
 	free_module(mod);
+	mod = NULL;
 
  out:
+
 	up(&module_mutex);
 	return ret;
 }
@@ -1236,6 +1093,9 @@
 
 	/* Start the module */
 	ret = mod->init();
+#ifdef CONFIG_MODULE_UNLOAD
+	up_read(&mod->unload_rwsem);
+#endif
 	if (ret < 0) {
 		/* Init routine failed: abort.  Try to protect us from
                    buggy refcounters. */
