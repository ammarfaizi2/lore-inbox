Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWBJQEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWBJQEu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 11:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWBJQEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 11:04:49 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:20362 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751269AbWBJQEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 11:04:48 -0500
Date: Fri, 10 Feb 2006 11:04:47 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/8] Notifier chain update: Remove unneeded protection
Message-ID: <Pine.LNX.4.44L0.0602101104130.5227-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Notifier chain re-implementation (as634b): Changes to chain head
definitions and removal of local protection schemes that are
no longer needed.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Chandra Seetharaman <sekharan@us.ibm.com>

Index: l2616/drivers/cpufreq/cpufreq.c
===================================================================
--- l2616.orig/drivers/cpufreq/cpufreq.c
+++ l2616/drivers/cpufreq/cpufreq.c
@@ -50,9 +50,8 @@ static void handle_update(void *data);
  * changes to devices when the CPU clock speed changes.
  * The mutex locks both lists.
  */
-static struct notifier_block    *cpufreq_policy_notifier_list;
-static struct notifier_block    *cpufreq_transition_notifier_list;
-static DECLARE_RWSEM		(cpufreq_notifier_rwsem);
+static BLOCKING_NOTIFIER_HEAD(cpufreq_policy_notifier_list);
+static BLOCKING_NOTIFIER_HEAD(cpufreq_transition_notifier_list);
 
 
 static LIST_HEAD(cpufreq_governor_list);
@@ -241,7 +240,6 @@ void cpufreq_notify_transition(struct cp
 	freqs->flags = cpufreq_driver->flags;
 	dprintk("notification %u of frequency transition to %u kHz\n", state, freqs->new);
 
-	down_read(&cpufreq_notifier_rwsem);
 	switch (state) {
 	case CPUFREQ_PRECHANGE:
 		/* detect if the driver reported a value as "old frequency" which
@@ -258,18 +256,19 @@ void cpufreq_notify_transition(struct cp
 				freqs->old = cpufreq_cpu_data[freqs->cpu]->cur;
 			}
 		}
-		notifier_call_chain(&cpufreq_transition_notifier_list, CPUFREQ_PRECHANGE, freqs);
+		blocking_notifier_call_chain(&cpufreq_transition_notifier_list,
+				CPUFREQ_PRECHANGE, freqs);
 		adjust_jiffies(CPUFREQ_PRECHANGE, freqs);
 		break;
 	case CPUFREQ_POSTCHANGE:
 		adjust_jiffies(CPUFREQ_POSTCHANGE, freqs);
-		notifier_call_chain(&cpufreq_transition_notifier_list, CPUFREQ_POSTCHANGE, freqs);
+		blocking_notifier_call_chain(&cpufreq_transition_notifier_list,
+				CPUFREQ_POSTCHANGE, freqs);
 		if ((likely(cpufreq_cpu_data[freqs->cpu])) && 
 		    (likely(cpufreq_cpu_data[freqs->cpu]->cpu == freqs->cpu)))
 			cpufreq_cpu_data[freqs->cpu]->cur = freqs->new;
 		break;
 	}
-	up_read(&cpufreq_notifier_rwsem);
 }
 EXPORT_SYMBOL_GPL(cpufreq_notify_transition);
 
@@ -955,7 +954,7 @@ static int cpufreq_suspend(struct sys_de
 		freqs.old = cpu_policy->cur;
 		freqs.new = cur_freq;
 
-		notifier_call_chain(&cpufreq_transition_notifier_list,
+		blocking_notifier_call_chain(&cpufreq_transition_notifier_list,
 				    CPUFREQ_SUSPENDCHANGE, &freqs);
 		adjust_jiffies(CPUFREQ_SUSPENDCHANGE, &freqs);
 
@@ -1036,7 +1035,8 @@ static int cpufreq_resume(struct sys_dev
 			freqs.old = cpu_policy->cur;
 			freqs.new = cur_freq;
 
-			notifier_call_chain(&cpufreq_transition_notifier_list,
+			blocking_notifier_call_chain(
+					&cpufreq_transition_notifier_list,
 					CPUFREQ_RESUMECHANGE, &freqs);
 			adjust_jiffies(CPUFREQ_RESUMECHANGE, &freqs);
 
@@ -1073,24 +1073,24 @@ static struct sysdev_driver cpufreq_sysd
  *      changes in cpufreq policy.
  *
  *	This function may sleep, and has the same return conditions as
- *	notifier_chain_register.
+ *	blocking_notifier_chain_register.
  */
 int cpufreq_register_notifier(struct notifier_block *nb, unsigned int list)
 {
 	int ret;
 
-	down_write(&cpufreq_notifier_rwsem);
 	switch (list) {
 	case CPUFREQ_TRANSITION_NOTIFIER:
-		ret = notifier_chain_register(&cpufreq_transition_notifier_list, nb);
+		ret = blocking_notifier_chain_register(
+				&cpufreq_transition_notifier_list, nb);
 		break;
 	case CPUFREQ_POLICY_NOTIFIER:
-		ret = notifier_chain_register(&cpufreq_policy_notifier_list, nb);
+		ret = blocking_notifier_chain_register(
+				&cpufreq_policy_notifier_list, nb);
 		break;
 	default:
 		ret = -EINVAL;
 	}
-	up_write(&cpufreq_notifier_rwsem);
 
 	return ret;
 }
@@ -1105,24 +1105,24 @@ EXPORT_SYMBOL(cpufreq_register_notifier)
  *	Remove a driver from the CPU frequency notifier list.
  *
  *	This function may sleep, and has the same return conditions as
- *	notifier_chain_unregister.
+ *	blocking_notifier_chain_unregister.
  */
 int cpufreq_unregister_notifier(struct notifier_block *nb, unsigned int list)
 {
 	int ret;
 
-	down_write(&cpufreq_notifier_rwsem);
 	switch (list) {
 	case CPUFREQ_TRANSITION_NOTIFIER:
-		ret = notifier_chain_unregister(&cpufreq_transition_notifier_list, nb);
+		ret = blocking_notifier_chain_unregister(
+				&cpufreq_transition_notifier_list, nb);
 		break;
 	case CPUFREQ_POLICY_NOTIFIER:
-		ret = notifier_chain_unregister(&cpufreq_policy_notifier_list, nb);
+		ret = blocking_notifier_chain_unregister(
+				&cpufreq_policy_notifier_list, nb);
 		break;
 	default:
 		ret = -EINVAL;
 	}
-	up_write(&cpufreq_notifier_rwsem);
 
 	return ret;
 }
@@ -1300,29 +1300,23 @@ static int __cpufreq_set_policy(struct c
 	if (ret)
 		goto error_out;
 
-	down_read(&cpufreq_notifier_rwsem);
-
 	/* adjust if necessary - all reasons */
-	notifier_call_chain(&cpufreq_policy_notifier_list, CPUFREQ_ADJUST,
-			    policy);
+	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
+			CPUFREQ_ADJUST, policy);
 
 	/* adjust if necessary - hardware incompatibility*/
-	notifier_call_chain(&cpufreq_policy_notifier_list, CPUFREQ_INCOMPATIBLE,
-			    policy);
+	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
+			CPUFREQ_INCOMPATIBLE, policy);
 
 	/* verify the cpu speed can be set within this limit,
 	   which might be different to the first one */
 	ret = cpufreq_driver->verify(policy);
-	if (ret) {
-		up_read(&cpufreq_notifier_rwsem);
+	if (ret)
 		goto error_out;
-	}
 
 	/* notification of the new policy */
-	notifier_call_chain(&cpufreq_policy_notifier_list, CPUFREQ_NOTIFY,
-			    policy);
-
-	up_read(&cpufreq_notifier_rwsem);
+	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
+			CPUFREQ_NOTIFY, policy);
 
 	data->min    = policy->min;
 	data->max    = policy->max;
Index: l2616/kernel/cpu.c
===================================================================
--- l2616.orig/kernel/cpu.c
+++ l2616/kernel/cpu.c
@@ -18,7 +18,7 @@
 /* This protects CPUs going up and down... */
 static DECLARE_MUTEX(cpucontrol);
 
-static struct notifier_block *cpu_chain;
+static BLOCKING_NOTIFIER_HEAD(cpu_chain);
 
 #ifdef CONFIG_HOTPLUG_CPU
 static struct task_struct *lock_cpu_hotplug_owner;
@@ -71,21 +71,13 @@ EXPORT_SYMBOL_GPL(lock_cpu_hotplug_inter
 /* Need to know about CPUs going up/down? */
 int register_cpu_notifier(struct notifier_block *nb)
 {
-	int ret;
-
-	if ((ret = lock_cpu_hotplug_interruptible()) != 0)
-		return ret;
-	ret = notifier_chain_register(&cpu_chain, nb);
-	unlock_cpu_hotplug();
-	return ret;
+	return blocking_notifier_chain_register(&cpu_chain, nb);
 }
 EXPORT_SYMBOL(register_cpu_notifier);
 
 void unregister_cpu_notifier(struct notifier_block *nb)
 {
-	lock_cpu_hotplug();
-	notifier_chain_unregister(&cpu_chain, nb);
-	unlock_cpu_hotplug();
+	blocking_notifier_chain_unregister(&cpu_chain, nb);
 }
 EXPORT_SYMBOL(unregister_cpu_notifier);
 
@@ -141,7 +133,7 @@ int cpu_down(unsigned int cpu)
 		goto out;
 	}
 
-	err = notifier_call_chain(&cpu_chain, CPU_DOWN_PREPARE,
+	err = blocking_notifier_call_chain(&cpu_chain, CPU_DOWN_PREPARE,
 						(void *)(long)cpu);
 	if (err == NOTIFY_BAD) {
 		printk("%s: attempt to take down CPU %u failed\n",
@@ -159,7 +151,7 @@ int cpu_down(unsigned int cpu)
 	p = __stop_machine_run(take_cpu_down, NULL, cpu);
 	if (IS_ERR(p)) {
 		/* CPU didn't die: tell everyone.  Can't complain. */
-		if (notifier_call_chain(&cpu_chain, CPU_DOWN_FAILED,
+		if (blocking_notifier_call_chain(&cpu_chain, CPU_DOWN_FAILED,
 				(void *)(long)cpu) == NOTIFY_BAD)
 			BUG();
 
@@ -182,8 +174,8 @@ int cpu_down(unsigned int cpu)
 	put_cpu();
 
 	/* CPU is completely dead: tell everyone.  Too late to complain. */
-	if (notifier_call_chain(&cpu_chain, CPU_DEAD, (void *)(long)cpu)
-	    == NOTIFY_BAD)
+	if (blocking_notifier_call_chain(&cpu_chain, CPU_DEAD,
+			(void *)(long)cpu) == NOTIFY_BAD)
 		BUG();
 
 	check_for_tasks(cpu);
@@ -211,7 +203,7 @@ int __devinit cpu_up(unsigned int cpu)
 		goto out;
 	}
 
-	ret = notifier_call_chain(&cpu_chain, CPU_UP_PREPARE, hcpu);
+	ret = blocking_notifier_call_chain(&cpu_chain, CPU_UP_PREPARE, hcpu);
 	if (ret == NOTIFY_BAD) {
 		printk("%s: attempt to bring up CPU %u failed\n",
 				__FUNCTION__, cpu);
@@ -227,11 +219,12 @@ int __devinit cpu_up(unsigned int cpu)
 		BUG();
 
 	/* Now call notifier in preparation. */
-	notifier_call_chain(&cpu_chain, CPU_ONLINE, hcpu);
+	blocking_notifier_call_chain(&cpu_chain, CPU_ONLINE, hcpu);
 
 out_notify:
 	if (ret != 0)
-		notifier_call_chain(&cpu_chain, CPU_UP_CANCELED, hcpu);
+		blocking_notifier_call_chain(&cpu_chain,
+				CPU_UP_CANCELED, hcpu);
 out:
 	unlock_cpu_hotplug();
 	return ret;
Index: l2616/kernel/module.c
===================================================================
--- l2616.orig/kernel/module.c
+++ l2616/kernel/module.c
@@ -63,26 +63,17 @@ static DEFINE_SPINLOCK(modlist_lock);
 static DECLARE_MUTEX(module_mutex);
 static LIST_HEAD(modules);
 
-static DECLARE_MUTEX(notify_mutex);
-static struct notifier_block * module_notify_list;
+static BLOCKING_NOTIFIER_HEAD(module_notify_list);
 
 int register_module_notifier(struct notifier_block * nb)
 {
-	int err;
-	down(&notify_mutex);
-	err = notifier_chain_register(&module_notify_list, nb);
-	up(&notify_mutex);
-	return err;
+	return blocking_notifier_chain_register(&module_notify_list, nb);
 }
 EXPORT_SYMBOL(register_module_notifier);
 
 int unregister_module_notifier(struct notifier_block * nb)
 {
-	int err;
-	down(&notify_mutex);
-	err = notifier_chain_unregister(&module_notify_list, nb);
-	up(&notify_mutex);
-	return err;
+	return blocking_notifier_chain_unregister(&module_notify_list, nb);
 }
 EXPORT_SYMBOL(unregister_module_notifier);
 
@@ -1947,9 +1938,8 @@ sys_init_module(void __user *umod,
 	/* Drop lock so they can recurse */
 	up(&module_mutex);
 
-	down(&notify_mutex);
-	notifier_call_chain(&module_notify_list, MODULE_STATE_COMING, mod);
-	up(&notify_mutex);
+	blocking_notifier_call_chain(&module_notify_list,
+			MODULE_STATE_COMING, mod);
 
 	/* Start the module */
 	if (mod->init != NULL)
Index: l2616/kernel/profile.c
===================================================================
--- l2616.orig/kernel/profile.c
+++ l2616/kernel/profile.c
@@ -86,72 +86,52 @@ void __init profile_init(void)
  
 #ifdef CONFIG_PROFILING
  
-static DECLARE_RWSEM(profile_rwsem);
-static DEFINE_RWLOCK(handoff_lock);
-static struct notifier_block * task_exit_notifier;
-static struct notifier_block * task_free_notifier;
-static struct notifier_block * munmap_notifier;
+static BLOCKING_NOTIFIER_HEAD(task_exit_notifier);
+static ATOMIC_NOTIFIER_HEAD(task_free_notifier);
+static BLOCKING_NOTIFIER_HEAD(munmap_notifier);
  
 void profile_task_exit(struct task_struct * task)
 {
-	down_read(&profile_rwsem);
-	notifier_call_chain(&task_exit_notifier, 0, task);
-	up_read(&profile_rwsem);
+	blocking_notifier_call_chain(&task_exit_notifier, 0, task);
 }
  
 int profile_handoff_task(struct task_struct * task)
 {
 	int ret;
-	read_lock(&handoff_lock);
-	ret = notifier_call_chain(&task_free_notifier, 0, task);
-	read_unlock(&handoff_lock);
+	ret = atomic_notifier_call_chain(&task_free_notifier, 0, task);
 	return (ret == NOTIFY_OK) ? 1 : 0;
 }
 
 void profile_munmap(unsigned long addr)
 {
-	down_read(&profile_rwsem);
-	notifier_call_chain(&munmap_notifier, 0, (void *)addr);
-	up_read(&profile_rwsem);
+	blocking_notifier_call_chain(&munmap_notifier, 0, (void *)addr);
 }
 
 int task_handoff_register(struct notifier_block * n)
 {
-	int err = -EINVAL;
-
-	write_lock(&handoff_lock);
-	err = notifier_chain_register(&task_free_notifier, n);
-	write_unlock(&handoff_lock);
-	return err;
+	return atomic_notifier_chain_register(&task_free_notifier, n);
 }
 
 int task_handoff_unregister(struct notifier_block * n)
 {
-	int err = -EINVAL;
-
-	write_lock(&handoff_lock);
-	err = notifier_chain_unregister(&task_free_notifier, n);
-	write_unlock(&handoff_lock);
-	return err;
+	return atomic_notifier_chain_unregister(&task_free_notifier, n);
 }
 
 int profile_event_register(enum profile_type type, struct notifier_block * n)
 {
 	int err = -EINVAL;
  
-	down_write(&profile_rwsem);
- 
 	switch (type) {
 		case PROFILE_TASK_EXIT:
-			err = notifier_chain_register(&task_exit_notifier, n);
+			err = blocking_notifier_chain_register(
+					&task_exit_notifier, n);
 			break;
 		case PROFILE_MUNMAP:
-			err = notifier_chain_register(&munmap_notifier, n);
+			err = blocking_notifier_chain_register(
+					&munmap_notifier, n);
 			break;
 	}
  
-	up_write(&profile_rwsem);
- 
 	return err;
 }
 
@@ -160,18 +140,17 @@ int profile_event_unregister(enum profil
 {
 	int err = -EINVAL;
  
-	down_write(&profile_rwsem);
- 
 	switch (type) {
 		case PROFILE_TASK_EXIT:
-			err = notifier_chain_unregister(&task_exit_notifier, n);
+			err = blocking_notifier_chain_unregister(
+					&task_exit_notifier, n);
 			break;
 		case PROFILE_MUNMAP:
-			err = notifier_chain_unregister(&munmap_notifier, n);
+			err = blocking_notifier_chain_unregister(
+					&munmap_notifier, n);
 			break;
 	}
 
-	up_write(&profile_rwsem);
 	return err;
 }
 
Index: l2616/arch/x86_64/kernel/process.c
===================================================================
--- l2616.orig/arch/x86_64/kernel/process.c
+++ l2616/arch/x86_64/kernel/process.c
@@ -66,24 +66,17 @@ EXPORT_SYMBOL(boot_option_idle_override)
 void (*pm_idle)(void);
 static DEFINE_PER_CPU(unsigned int, cpu_idle_state);
 
-static struct notifier_block *idle_notifier;
-static DEFINE_SPINLOCK(idle_notifier_lock);
+static BLOCKING_NOTIFIER_HEAD(idle_notifier);
 
 void idle_notifier_register(struct notifier_block *n)
 {
-	unsigned long flags;
-	spin_lock_irqsave(&idle_notifier_lock, flags);
-	notifier_chain_register(&idle_notifier, n);
-	spin_unlock_irqrestore(&idle_notifier_lock, flags);
+	blocking_notifier_chain_register(&idle_notifier, n);
 }
 EXPORT_SYMBOL_GPL(idle_notifier_register);
 
 void idle_notifier_unregister(struct notifier_block *n)
 {
-	unsigned long flags;
-	spin_lock_irqsave(&idle_notifier_lock, flags);
-	notifier_chain_unregister(&idle_notifier, n);
-	spin_unlock_irqrestore(&idle_notifier_lock, flags);
+	blocking_notifier_chain_unregister(&idle_notifier, n);
 }
 EXPORT_SYMBOL(idle_notifier_unregister);
 
@@ -93,13 +86,13 @@ static DEFINE_PER_CPU(enum idle_state, i
 void enter_idle(void)
 {
 	__get_cpu_var(idle_state) = CPU_IDLE;
-	notifier_call_chain(&idle_notifier, IDLE_START, NULL);
+	blocking_notifier_call_chain(&idle_notifier, IDLE_START, NULL);
 }
 
 static void __exit_idle(void)
 {
 	__get_cpu_var(idle_state) = CPU_NOT_IDLE;
-	notifier_call_chain(&idle_notifier, IDLE_END, NULL);
+	blocking_notifier_call_chain(&idle_notifier, IDLE_END, NULL);
 }
 
 /* Called from interrupts to signify idle end */

