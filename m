Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268316AbTCAEUb>; Fri, 28 Feb 2003 23:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268327AbTCAEUb>; Fri, 28 Feb 2003 23:20:31 -0500
Received: from h-64-105-35-98.SNVACAID.covad.net ([64.105.35.98]:44444 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S268316AbTCAEUZ>; Fri, 28 Feb 2003 23:20:25 -0500
Date: Fri, 28 Feb 2003 20:30:39 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Patch/resubmit linux-2.5.63-bk4 try_module_get simplification
Message-ID: <20030228203039.A12990@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	The following patch shrinks changes the implementation of
try_module_get() and friends to eliminate the special stopping of all
CPU's when a module is unloaded.  Instead, it uses a read/write
semaphore in a perhaps slightly non-intuitive way.

	Note that because try_module_get uses the non-blocking
down_read_trylock, it is apparently safe for use in an interrupt
context.  The only complaints about this patch in the past were
apparently misunderstandings of this, where people thought that
this version of try_module_get could block.

	I have been using this change on numerous machines for the
past seven weeks without problems, including on a router using
iptables.

	Can you please apply it?  Thanks in advance.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="module.diff"

--- linux-2.5.63.bk4/include/linux/module.h	2003-02-24 11:05:39.000000000 -0800
+++ linux/include/linux/module.h	2003-02-28 20:14:09.000000000 -0800
@@ -16,6 +16,7 @@
 #include <linux/kmod.h>
 #include <linux/elf.h>
 #include <linux/stringify.h>
+#include <linux/rwsem.h>
 
 #include <asm/module.h>
 #include <asm/uaccess.h> /* For struct exception_table_entry */
@@ -244,6 +245,8 @@
 	int license_gplok;
 
 #ifdef CONFIG_MODULE_UNLOAD
+	struct rw_semaphore	unload_rwsem;
+
 	/* Reference counts */
 	struct module_ref ref[NR_CPUS];
 
@@ -298,9 +301,10 @@
 
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
--- linux-2.5.63.bk4/kernel/module.c	2003-02-28 09:37:55.000000000 -0800
+++ linux/kernel/module.c	2003-02-28 20:14:40.000000000 -0800
@@ -18,6 +18,7 @@
 */
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/module_rwsem.h>
 #include <linux/moduleloader.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -154,6 +155,10 @@
 {
 	unsigned int i;
 
+	init_rwsem(&mod->unload_rwsem);
+	down_read(&mod->unload_rwsem);
+	/* Prevent unloading of module until module_init() completes. */
+
 	INIT_LIST_HEAD(&mod->modules_which_use_me);
 	for (i = 0; i < NR_CPUS; i++)
 		atomic_set(&mod->ref[i].count, 0);
@@ -226,154 +231,6 @@
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
@@ -409,7 +266,8 @@
 {
 	struct module *mod;
 	char name[MODULE_NAME_LEN];
-	int ret, forced = 0;
+	int ret = 0;
+	int forced = 0;
 
 	if (!capable(CAP_SYS_MODULE))
 		return -EPERM;
@@ -462,25 +320,21 @@
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
@@ -502,6 +356,8 @@
  destroy:
 	/* Final destruction now noone is using it. */
 	mod->exit();
+	/* up_write(&mod->unload_rwsem);  -- No need.  Nobody is blocking
+	   on this semaphore or testing it, and we're just going to free it. */
 	free_module(mod);
 
  out:
@@ -1370,6 +1226,9 @@
 
 	/* Start the module */
 	ret = mod->init();
+#ifdef CONFIG_MODULE_UNLOAD
+	up_read(&mod->unload_rwsem);
+#endif
 	if (ret < 0) {
 		/* Init routine failed: abort.  Try to protect us from
                    buggy refcounters. */

--M9NhX3UHpAaciwkO--
