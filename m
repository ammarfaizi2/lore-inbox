Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269214AbTCBODK>; Sun, 2 Mar 2003 09:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269216AbTCBOCr>; Sun, 2 Mar 2003 09:02:47 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:43526 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S269214AbTCBOCW>; Sun, 2 Mar 2003 09:02:22 -0500
Date: Sun, 2 Mar 2003 15:12:37 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: rusty@rustcorp.com.au, <linux-kernel@vger.kernel.org>
Subject: Re: Patch/resubmit linux-2.5.63-bk4 try_module_get simplification
In-Reply-To: <20030228203039.A12990@baldur.yggdrasil.com>
Message-ID: <Pine.LNX.4.44.0303021457010.32518-100000@serv>
References: <20030228203039.A12990@baldur.yggdrasil.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 28 Feb 2003, Adam J. Richter wrote:

> 	The following patch shrinks changes the implementation of
> try_module_get() and friends to eliminate the special stopping of all
> CPU's when a module is unloaded.  Instead, it uses a read/write
> semaphore in a perhaps slightly non-intuitive way.

Hmm, I was waiting a bit for Rusty's comment, but there isn't any...
Anyway the patch below does the same, but it gets the module ref 
speculative and calls module_get_sync() if there is a problem.
The patch is against an older kernel, but it should still apply and 
someone else has to get it past Rusty.
BTW making the module ref functions not inline saves about 5KB with the 
standard config.

bye, Roman

diff -pur -X /home/roman/nodiff linux-2.5.59.org/include/linux/module.h linux-2.5.59.mod/include/linux/module.h
--- linux-2.5.59.org/include/linux/module.h	2003-01-20 20:23:33.000000000 +0100
+++ linux-2.5.59.mod/include/linux/module.h	2003-02-08 14:16:54.000000000 +0100
@@ -259,16 +259,18 @@ void symbol_put_addr(void *addr);
 #define local_dec(x) atomic_dec(x)
 #endif
 
+extern int module_get_sync(struct module *module);
+
 static inline int try_module_get(struct module *module)
 {
 	int ret = 1;
 
 	if (module) {
 		unsigned int cpu = get_cpu();
-		if (likely(module_is_live(module)))
-			local_inc(&module->ref[cpu].count);
-		else
-			ret = 0;
+		local_inc(&module->ref[cpu].count);
+		smp_mb();
+		if (unlikely(!module_is_live(module)))
+			ret = module_get_sync(module);
 		put_cpu();
 	}
 	return ret;
diff -pur -X /home/roman/nodiff linux-2.5.59.org/kernel/module.c linux-2.5.59.mod/kernel/module.c
--- linux-2.5.59.org/kernel/module.c	2003-01-20 20:23:33.000000000 +0100
+++ linux-2.5.59.mod/kernel/module.c	2003-02-08 15:05:02.000000000 +0100
@@ -203,154 +203,6 @@ static void module_unload_free(struct mo
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
@@ -381,12 +233,30 @@ void cleanup_module(void)
 }
 EXPORT_SYMBOL(cleanup_module);
 
+static spinlock_t unload_lock = SPIN_LOCK_UNLOCKED;
+
+int module_get_sync(struct module *module)
+{
+	unsigned long flags;
+	int ret = 1;
+
+	spin_lock_irqsave(&unload_lock, flags);
+	if (!module_is_live(module)) {
+		local_dec(&module->ref[smp_processor_id()].count);
+		ret = 0;
+	}
+	spin_unlock_irqrestore(&unload_lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(module_get_sync);
+
 asmlinkage long
 sys_delete_module(const char *name_user, unsigned int flags)
 {
 	struct module *mod;
 	char name[MODULE_NAME_LEN];
 	int ret, forced = 0;
+	unsigned long flags;
 
 	if (!capable(CAP_SYS_MODULE))
 		return -EPERM;
@@ -439,22 +309,15 @@ sys_delete_module(const char *name_user,
 			goto out;
 		}
 	}
-	/* Stop the machine so refcounts can't move: irqs disabled. */
-	DEBUGP("Stopping refcounts...\n");
-	ret = stop_refcounts();
-	if (ret != 0)
-		goto out;
 
-	/* If it's not unused, quit unless we are told to block. */
-	if ((flags & O_NONBLOCK) && module_refcount(mod) != 0) {
-		forced = try_force(flags);
-		if (!forced)
-			ret = -EWOULDBLOCK;
-	} else {
-		mod->waiter = current;
-		mod->state = MODULE_STATE_GOING;
-	}
-	restart_refcounts();
+	spin_lock_irqsave(&unload_lock, flags);
+	mod->state = MODULE_STATE_GOING;
+	smp_mb();
+	if (module_refcount(mod))
+		mod->state = MODULE_STATE_LIVE;
+	else
+		ret = -EBUSY;
+	spin_unlock_irqrestore(&unload_lock, flags);
 
 	if (ret != 0)
 		goto out;

