Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269621AbTGYRYa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 13:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272138AbTGYRYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 13:24:30 -0400
Received: from dp.samba.org ([66.70.73.150]:5050 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S269621AbTGYRXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 13:23:50 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: davem@redhat.com, arjanv@redhat.com, torvalds@transmeta.com,
       greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove module reference counting.
Date: Fri, 25 Jul 2003 04:00:18 +1000
Message-Id: <20030725173900.D7DE12C2A9@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	When the initial module patch was submitted, it made modules
start isolated, so they would not be accessible until (if)
initialization had succeeded.  This broke partition scanning, and was
immediately reverted, leaving us with a module reference count scheme
identical to the previous one (just a faster implementation): we still
have cases where modules can be access on failed load.

	Then Dave decided that the work of reference counting network
driver modules everywhere is too invasive, so network driver modules
now have zero reference counts always.  The idea is that if you don't
want the module removed, don't do it.  ie. only remove the module if
there's a bug, or you want to replace it.

	If module removal is to be a rare and unusual event, it
doesn't seem so sensible to go to great lengths in the code to handle
just that case.  In fact, it's easier to leave the module memory in
place, and not have the concept of parts of the kernel text (and some
types of kernel data) vanishing.

Polite feedback welcome,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Get Rid of Module Reference Counting
Author: Rusty Russell
Status: Tested on 2.6.0-test1-bk2

D: Several people have complained about the complexity of doing
D: reference counting on modules, and existing bugs in the unload
D: routines of modules.
D: 
D: In particular, David Miller has chosen not to reference count
D: modules for network devices: even when "in use" their reference
D: count remains zero, and the interfaces shut down when rmmod is
D: called.  This breaks the current "remove if it will have no effect,
D: otherwise fail" semantics of modules: the result is that modules
D: should not be removed unless there's a bug anyway.
D: 
D: So, a fair solution is to never free module memory.  When a module
D: fails initialization, or is deactivated, the memory is left around
D: so future calls into it (or references to its data) will not crash.
D: The payoff (other than lack of complexity) is that reference
D: counting disappears.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .6124-linux-2.6.0-test1-bk2/include/linux/module.h .6124-linux-2.6.0-test1-bk2.updated/include/linux/module.h
--- .6124-linux-2.6.0-test1-bk2/include/linux/module.h	2003-07-21 00:04:13.000000000 +1000
+++ .6124-linux-2.6.0-test1-bk2.updated/include/linux/module.h	2003-07-24 07:12:46.000000000 +1000
@@ -170,11 +170,6 @@ void *__symbol_get_gpl(const char *symbo
  * special casing EXPORT_SYMBOL_NOVERS.  FIXME: Deprecated */
 #define EXPORT_SYMBOL_NOVERS(sym) EXPORT_SYMBOL(sym)
 
-struct module_ref
-{
-	local_t count;
-} ____cacheline_aligned;
-
 enum module_state
 {
 	MODULE_STATE_LIVE,
@@ -224,25 +219,14 @@ struct module
 	/* Arch-specific module values */
 	struct mod_arch_specific arch;
 
-	/* Am I unsafe to unload? */
-	int unsafe;
-
 	/* Am I GPL-compatible */
 	int license_gplok;
 
-#ifdef CONFIG_MODULE_UNLOAD
-	/* Reference counts */
-	struct module_ref ref[NR_CPUS];
-
 	/* What modules depend on me? */
 	struct list_head modules_which_use_me;
 
-	/* Who is waiting for us to be unloaded */
-	struct task_struct *waiter;
-
 	/* Destruction function. */
 	void (*exit)(void);
-#endif
 
 #ifdef CONFIG_KALLSYMS
 	/* We keep the symbol and string tables for kallsyms. */
@@ -282,66 +266,9 @@ extern void __module_put_and_exit(struct
 	__attribute__((noreturn));
 #define module_put_and_exit(code) __module_put_and_exit(THIS_MODULE, code);
 
-#ifdef CONFIG_MODULE_UNLOAD
-unsigned int module_refcount(struct module *mod);
-void __symbol_put(const char *symbol);
-#define symbol_put(x) __symbol_put(MODULE_SYMBOL_PREFIX #x)
-void symbol_put_addr(void *addr);
-
-/* Sometimes we know we already have a refcount, and it's easier not
-   to handle the error case (which only happens with rmmod --wait). */
-static inline void __module_get(struct module *module)
-{
-	if (module) {
-		BUG_ON(module_refcount(module) == 0);
-		local_inc(&module->ref[get_cpu()].count);
-		put_cpu();
-	}
-}
-
-static inline int try_module_get(struct module *module)
-{
-	int ret = 1;
-
-	if (module) {
-		unsigned int cpu = get_cpu();
-		if (likely(module_is_live(module)))
-			local_inc(&module->ref[cpu].count);
-		else
-			ret = 0;
-		put_cpu();
-	}
-	return ret;
-}
-
-static inline void module_put(struct module *module)
-{
-	if (module) {
-		unsigned int cpu = get_cpu();
-		local_dec(&module->ref[cpu].count);
-		/* Maybe they're waiting for us to drop reference? */
-		if (unlikely(!module_is_live(module)))
-			wake_up_process(module->waiter);
-		put_cpu();
-	}
-}
-
-#else /*!CONFIG_MODULE_UNLOAD*/
-static inline int try_module_get(struct module *module)
-{
-	return !module || module_is_live(module);
-}
-static inline void module_put(struct module *module)
-{
-}
-static inline void __module_get(struct module *module)
-{
-}
 #define symbol_put(x) do { } while(0)
 #define symbol_put_addr(p) do { } while(0)
 
-#endif /* CONFIG_MODULE_UNLOAD */
-
 /* This is a #define so the string doesn't get put in every .o file */
 #define module_name(mod)			\
 ({						\
@@ -349,16 +276,6 @@ static inline void __module_get(struct m
 	__mod ? __mod->name : "kernel";		\
 })
 
-#define __unsafe(mod)							     \
-do {									     \
-	if (mod && !(mod)->unsafe) {					     \
-		printk(KERN_WARNING					     \
-		       "Module %s cannot be unloaded due to unsafe usage in" \
-		       " %s:%u\n", (mod)->name, __FILE__, __LINE__);	     \
-		(mod)->unsafe = 1;					     \
-	}								     \
-} while(0)
-
 /* For kallsyms to ask for address resolution.  NULL means not found. */
 const char *module_address_lookup(unsigned long addr,
 				  unsigned long *symbolsize,
@@ -394,23 +311,8 @@ static inline struct module *module_text
 #define symbol_put(x) do { } while(0)
 #define symbol_put_addr(x) do { } while(0)
 
-static inline void __module_get(struct module *module)
-{
-}
-
-static inline int try_module_get(struct module *module)
-{
-	return 1;
-}
-
-static inline void module_put(struct module *module)
-{
-}
-
 #define module_name(mod) "kernel"
 
-#define __unsafe(mod)
-
 /* For kallsyms to ask for address resolution.  NULL means not found. */
 static inline const char *module_address_lookup(unsigned long addr,
 						unsigned long *symbolsize,
@@ -448,6 +350,19 @@ static inline int unregister_module_noti
 
 #endif /* CONFIG_MODULES */
 
+static inline void __module_get(struct module *module)
+{
+}
+
+static inline int try_module_get(struct module *module)
+{
+	return 1;
+}
+
+static inline void module_put(struct module *module)
+{
+}
+
 #ifdef MODULE
 extern struct module __this_module;
 #ifdef KBUILD_MODNAME
@@ -480,19 +395,10 @@ struct obsolete_modparm __parm_##var __a
 
 static inline void __deprecated MOD_INC_USE_COUNT(struct module *module)
 {
-	__unsafe(module);
-
-#if defined(CONFIG_MODULE_UNLOAD) && defined(MODULE)
-	local_inc(&module->ref[get_cpu()].count);
-	put_cpu();
-#else
-	(void)try_module_get(module);
-#endif
 }
 
 static inline void __deprecated MOD_DEC_USE_COUNT(struct module *module)
 {
-	module_put(module);
 }
 
 #define MOD_INC_USE_COUNT	MOD_INC_USE_COUNT(THIS_MODULE)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .6124-linux-2.6.0-test1-bk2/kernel/module.c .6124-linux-2.6.0-test1-bk2.updated/kernel/module.c
--- .6124-linux-2.6.0-test1-bk2/kernel/module.c	2003-07-21 00:04:13.000000000 +1000
+++ .6124-linux-2.6.0-test1-bk2.updated/kernel/module.c	2003-07-24 07:20:43.000000000 +1000
@@ -63,6 +63,9 @@ static LIST_HEAD(modules);
 static DECLARE_MUTEX(notify_mutex);
 static struct notifier_block * module_notify_list;
 
+/* This is predeclared because we only want one CONFIG_UNLOAD block. */
+static void unlink_module(struct module *mod);
+
 int register_module_notifier(struct notifier_block * nb)
 {
 	int err;
@@ -378,20 +381,6 @@ static inline void percpu_modcopy(void *
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_MODULE_UNLOAD
-/* Init the unload section of the module. */
-static void module_unload_init(struct module *mod)
-{
-	unsigned int i;
-
-	INIT_LIST_HEAD(&mod->modules_which_use_me);
-	for (i = 0; i < NR_CPUS; i++)
-		local_set(&mod->ref[i].count, 0);
-	/* Hold reference count during initialization. */
-	local_set(&mod->ref[smp_processor_id()].count, 1);
-	/* Backwards compatibility macros put refcount during init. */
-	mod->waiter = current;
-}
-
 /* modules using other modules */
 struct module_use
 {
@@ -420,7 +409,7 @@ static int use_module(struct module *a, 
 	struct module_use *use;
 	if (b == NULL || already_uses(a, b)) return 1;
 
-	if (!strong_try_module_get(b))
+	if (b->state != MODULE_STATE_LIVE)
 		return 0;
 
 	DEBUGP("Allocating new usage for %s.\n", a->name);
@@ -457,167 +446,6 @@ static void module_unload_free(struct mo
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
-unsigned int module_refcount(struct module *mod)
-{
-	unsigned int i, total = 0;
-
-	for (i = 0; i < NR_CPUS; i++)
-		total += local_read(&mod->ref[i].count);
-	return total;
-}
-EXPORT_SYMBOL(module_refcount);
-
-/* This exists whether we can unload or not */
-static void free_module(struct module *mod);
-
 #ifdef CONFIG_MODULE_FORCE_UNLOAD
 static inline int try_force(unsigned int flags)
 {
@@ -639,21 +467,6 @@ void cleanup_module(void)
 }
 EXPORT_SYMBOL(cleanup_module);
 
-static void wait_for_zero_refcount(struct module *mod)
-{
-	/* Since we might sleep for some time, drop the semaphore first */
-	up(&module_mutex);
-	for (;;) {
-		DEBUGP("Looking at refcount...\n");
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (module_refcount(mod) == 0)
-			break;
-		schedule();
-	}
-	current->state = TASK_RUNNING;
-	down(&module_mutex);
-}
-
 asmlinkage long
 sys_delete_module(const char __user *name_user, unsigned int flags)
 {
@@ -693,8 +506,7 @@ sys_delete_module(const char __user *nam
 	}
 
 	/* If it has an init func, it must have an exit func to unload */
-	if ((mod->init != init_module && mod->exit == cleanup_module)
-	    || mod->unsafe) {
+	if (mod->init != init_module && mod->exit == cleanup_module) {
 		forced = try_force(flags);
 		if (!forced) {
 			/* This module can't be removed */
@@ -702,34 +514,18 @@ sys_delete_module(const char __user *nam
 			goto out;
 		}
 	}
-	/* Stop the machine so refcounts can't move: irqs disabled. */
-	DEBUGP("Stopping refcounts...\n");
-	ret = stop_refcounts();
-	if (ret != 0)
-		goto out;
-
-	/* If it's not unused, quit unless we are told to block. */
-	if ((flags & O_NONBLOCK) && module_refcount(mod) != 0) {
-		forced = try_force(flags);
-		if (!forced) {
-			ret = -EWOULDBLOCK;
-			restart_refcounts();
-			goto out;
-		}
-	}
 
 	/* Mark it as dying. */
-	mod->waiter = current;
 	mod->state = MODULE_STATE_GOING;
-	restart_refcounts();
-
-	/* Never wait if forced. */
-	if (!forced && module_refcount(mod) != 0)
-		wait_for_zero_refcount(mod);
 
-	/* Final destruction now noone is using it. */
+	/* Drop lock in case cleanup function dies. */
+	up(&module_mutex);
 	mod->exit();
-	free_module(mod);
+	down(&module_mutex);
+
+	/* Remove from lists now noone is using it. */
+	unlink_module(mod);
+	ret = 0;
 
  out:
 	up(&module_mutex);
@@ -741,7 +537,7 @@ static void print_unload_info(struct seq
 	struct module_use *use;
 	int printed_something = 0;
 
-	seq_printf(m, " %u ", module_refcount(mod));
+	seq_printf(m, " 0 ");
 
 	/* Always include a trailing , so userspace can differentiate
            between this and the old multi-field proc format. */
@@ -750,11 +546,6 @@ static void print_unload_info(struct seq
 		seq_printf(m, "%s,", use->module_which_uses->name);
 	}
 
-	if (mod->unsafe) {
-		printed_something = 1;
-		seq_printf(m, "[unsafe],");
-	}
-
 	if (mod->init != init_module && mod->exit == cleanup_module) {
 		printed_something = 1;
 		seq_printf(m, "[permanent],");
@@ -763,34 +554,6 @@ static void print_unload_info(struct seq
 	if (!printed_something)
 		seq_printf(m, "-");
 }
-
-void __symbol_put(const char *symbol)
-{
-	struct module *owner;
-	unsigned long flags;
-	const unsigned long *crc;
-
-	spin_lock_irqsave(&modlist_lock, flags);
-	if (!__find_symbol(symbol, &owner, &crc, 1))
-		BUG();
-	module_put(owner);
-	spin_unlock_irqrestore(&modlist_lock, flags);
-}
-EXPORT_SYMBOL(__symbol_put);
-
-void symbol_put_addr(void *addr)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&modlist_lock, flags);
-	if (!kernel_text_address((unsigned long)addr))
-		BUG();
-
-	module_put(module_text_address((unsigned long)addr));
-	spin_unlock_irqrestore(&modlist_lock, flags);
-}
-EXPORT_SYMBOL_GPL(symbol_put_addr);
-
 #else /* !CONFIG_MODULE_UNLOAD */
 static void print_unload_info(struct seq_file *m, struct module *mod)
 {
@@ -804,11 +567,9 @@ static inline void module_unload_free(st
 
 static inline int use_module(struct module *a, struct module *b)
 {
-	return strong_try_module_get(b);
-}
-
-static inline void module_unload_init(struct module *mod)
-{
+	if (b && b->state != MODULE_STATE_LIVE)
+		return 0;
+	return 1;
 }
 
 asmlinkage long
@@ -1071,28 +832,16 @@ static unsigned long resolve_symbol(Elf_
 	return ret;
 }
 
-/* Free a module, remove from lists, etc (must hold module mutex). */
-static void free_module(struct module *mod)
+/* Remove a module from lists, etc (must hold module mutex). */
+static void unlink_module(struct module *mod)
 {
 	/* Delete from various lists */
 	spin_lock_irq(&modlist_lock);
 	list_del(&mod->list);
 	spin_unlock_irq(&modlist_lock);
 
-	/* Arch-specific cleanup. */
-	module_arch_cleanup(mod);
-
-	/* Module unload stuff */
+	/* Clean up module unload stuff */
 	module_unload_free(mod);
-
-	/* This may be NULL, but that's OK */
-	module_free(mod, mod->module_init);
-	kfree(mod->args);
-	if (mod->percpu)
-		percpu_modfree(mod->percpu);
-
-	/* Finally, free the core (containing the module structure) */
-	module_free(mod, mod->module_core);
 }
 
 void *__symbol_get(const char *symbol)
@@ -1573,8 +1322,8 @@ static struct module *load_module(void _
 	/* Module has been moved. */
 	mod = (void *)sechdrs[modindex].sh_addr;
 
-	/* Now we've moved module, initialize linked lists, etc. */
-	module_unload_init(mod);
+	/* Now we've moved module, initialize the usage linked list. */
+	INIT_LIST_HEAD(&mod->modules_which_use_me);
 
 	/* Set up license info based on the info section */
 	set_license(mod, get_modinfo(sechdrs, infoindex, "license"));
@@ -1722,35 +1471,22 @@ sys_init_module(void __user *umod,
 
 	/* Start the module */
 	ret = mod->init();
-	if (ret < 0) {
-		/* Init routine failed: abort.  Try to protect us from
-                   buggy refcounters. */
-		mod->state = MODULE_STATE_GOING;
-		synchronize_kernel();
-		if (mod->unsafe)
-			printk(KERN_ERR "%s: module is now stuck!\n",
-			       mod->name);
-		else {
-			module_put(mod);
-			down(&module_mutex);
-			free_module(mod);
-			up(&module_mutex);
-		}
-		return ret;
-	}
 
-	/* Now it's a first class citizen! */
 	down(&module_mutex);
-	mod->state = MODULE_STATE_LIVE;
-	/* Drop initial reference. */
-	module_put(mod);
+	if (ret < 0)
+		/* Remove from lists and let it rot. */
+		unlink_module(mod);
+	else
+		/* Now it's a first class citizen! */
+		mod->state = MODULE_STATE_LIVE;
+
 	module_free(mod, mod->module_init);
 	mod->module_init = NULL;
 	mod->init_size = 0;
 	mod->init_text_size = 0;
 	up(&module_mutex);
 
-	return 0;
+	return ret;
 }
 
 static inline int within(unsigned long addr, void *start, unsigned long size)
@@ -1925,8 +1661,6 @@ const struct exception_table_entry *sear
 	}
 	spin_unlock_irqrestore(&modlist_lock, flags);
 
-	/* Now, if we found one, we are running inside it now, hence
-           we cannot unload the module, hence no refcnt needed. */
 	return e;
 }
 
