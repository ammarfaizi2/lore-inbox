Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161236AbVKSCUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161236AbVKSCUT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 21:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161228AbVKSCUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 21:20:19 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:63202 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161236AbVKSCUH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 21:20:07 -0500
Subject: [RFC][PATCH 3/7]: notifier_head changes with removal of reducdant
	protection
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: lse-tech@lists.sourceforge.net, Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain
Organization: IBM
Date: Fri, 18 Nov 2005 18:20:05 -0800
Message-Id: <1132366805.9617.15.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch includes changes to notifier chain head definitions and removal
of additional protection that is no longer needed.

Signed-off-by:  Chandra Seetharaman <sekharan@us.ibm.com>
Signed-off-by:  Alan Stern <stern@rowland.harvard.edu>
-----

 drivers/cpufreq/cpufreq.c |   19 +++----------------
 kernel/cpu.c              |   12 ++----------
 kernel/module.c           |   17 +++--------------
 kernel/profile.c          |   35 +++++------------------------------
 4 files changed, 13 insertions(+), 70 deletions(-)

Index: l2615-rc1-notifiers/drivers/cpufreq/cpufreq.c
===================================================================
--- l2615-rc1-notifiers.orig/drivers/cpufreq/cpufreq.c
+++ l2615-rc1-notifiers/drivers/cpufreq/cpufreq.c
@@ -50,9 +50,8 @@ static inline void adjust_jiffies(unsign
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
@@ -269,7 +267,6 @@ void cpufreq_notify_transition(struct cp
 			cpufreq_cpu_data[freqs->cpu]->cur = freqs->new;
 		break;
 	}
-	up_read(&cpufreq_notifier_rwsem);
 }
 EXPORT_SYMBOL_GPL(cpufreq_notify_transition);
 
@@ -1052,7 +1049,6 @@ int cpufreq_register_notifier(struct not
 {
 	int ret;
 
-	down_write(&cpufreq_notifier_rwsem);
 	switch (list) {
 	case CPUFREQ_TRANSITION_NOTIFIER:
 		ret = notifier_chain_register(&cpufreq_transition_notifier_list, nb);
@@ -1063,7 +1059,6 @@ int cpufreq_register_notifier(struct not
 	default:
 		ret = -EINVAL;
 	}
-	up_write(&cpufreq_notifier_rwsem);
 
 	return ret;
 }
@@ -1084,7 +1079,6 @@ int cpufreq_unregister_notifier(struct n
 {
 	int ret;
 
-	down_write(&cpufreq_notifier_rwsem);
 	switch (list) {
 	case CPUFREQ_TRANSITION_NOTIFIER:
 		ret = notifier_chain_unregister(&cpufreq_transition_notifier_list, nb);
@@ -1095,7 +1089,6 @@ int cpufreq_unregister_notifier(struct n
 	default:
 		ret = -EINVAL;
 	}
-	up_write(&cpufreq_notifier_rwsem);
 
 	return ret;
 }
@@ -1281,8 +1274,6 @@ static int __cpufreq_set_policy(struct c
 	if (ret)
 		goto error_out;
 
-	down_read(&cpufreq_notifier_rwsem);
-
 	/* adjust if necessary - all reasons */
 	notifier_call_chain(&cpufreq_policy_notifier_list, CPUFREQ_ADJUST,
 			    policy);
@@ -1294,17 +1285,13 @@ static int __cpufreq_set_policy(struct c
 	/* verify the cpu speed can be set within this limit,
 	   which might be different to the first one */
 	ret = cpufreq_driver->verify(policy);
-	if (ret) {
-		up_read(&cpufreq_notifier_rwsem);
+	if (ret)
 		goto error_out;
-	}
 
 	/* notification of the new policy */
 	notifier_call_chain(&cpufreq_policy_notifier_list, CPUFREQ_NOTIFY,
 			    policy);
 
-	up_read(&cpufreq_notifier_rwsem);
-
 	data->min    = policy->min;
 	data->max    = policy->max;
 
Index: l2615-rc1-notifiers/kernel/cpu.c
===================================================================
--- l2615-rc1-notifiers.orig/kernel/cpu.c
+++ l2615-rc1-notifiers/kernel/cpu.c
@@ -19,7 +19,7 @@
 DECLARE_MUTEX(cpucontrol);
 EXPORT_SYMBOL_GPL(cpucontrol);
 
-static struct notifier_block *cpu_chain;
+static BLOCKING_NOTIFIER_HEAD(cpu_chain);
 
 /*
  * Used to check by callers if they need to acquire the cpucontrol
@@ -42,21 +42,13 @@ EXPORT_SYMBOL_GPL(current_in_cpu_hotplug
 /* Need to know about CPUs going up/down? */
 int register_cpu_notifier(struct notifier_block *nb)
 {
-	int ret;
-
-	if ((ret = down_interruptible(&cpucontrol)) != 0)
-		return ret;
-	ret = notifier_chain_register(&cpu_chain, nb);
-	up(&cpucontrol);
-	return ret;
+	return notifier_chain_register(&cpu_chain, nb);
 }
 EXPORT_SYMBOL(register_cpu_notifier);
 
 void unregister_cpu_notifier(struct notifier_block *nb)
 {
-	down(&cpucontrol);
 	notifier_chain_unregister(&cpu_chain, nb);
-	up(&cpucontrol);
 }
 EXPORT_SYMBOL(unregister_cpu_notifier);
 
Index: l2615-rc1-notifiers/kernel/module.c
===================================================================
--- l2615-rc1-notifiers.orig/kernel/module.c
+++ l2615-rc1-notifiers/kernel/module.c
@@ -62,26 +62,17 @@ static DEFINE_SPINLOCK(modlist_lock);
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
+	return notifier_chain_register(&module_notify_list, nb);
 }
 EXPORT_SYMBOL(register_module_notifier);
 
 int unregister_module_notifier(struct notifier_block * nb)
 {
-	int err;
-	down(&notify_mutex);
-	err = notifier_chain_unregister(&module_notify_list, nb);
-	up(&notify_mutex);
-	return err;
+	return notifier_chain_unregister(&module_notify_list, nb);
 }
 EXPORT_SYMBOL(unregister_module_notifier);
 
@@ -1905,9 +1896,7 @@ sys_init_module(void __user *umod,
 	/* Drop lock so they can recurse */
 	up(&module_mutex);
 
-	down(&notify_mutex);
 	notifier_call_chain(&module_notify_list, MODULE_STATE_COMING, mod);
-	up(&notify_mutex);
 
 	/* Start the module */
 	if (mod->init != NULL)
Index: l2615-rc1-notifiers/kernel/profile.c
===================================================================
--- l2615-rc1-notifiers.orig/kernel/profile.c
+++ l2615-rc1-notifiers/kernel/profile.c
@@ -86,61 +86,41 @@ void __init profile_init(void)
  
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
 	notifier_call_chain(&task_exit_notifier, 0, task);
-	up_read(&profile_rwsem);
 }
  
 int profile_handoff_task(struct task_struct * task)
 {
 	int ret;
-	read_lock(&handoff_lock);
 	ret = notifier_call_chain(&task_free_notifier, 0, task);
-	read_unlock(&handoff_lock);
 	return (ret == NOTIFY_OK) ? 1 : 0;
 }
 
 void profile_munmap(unsigned long addr)
 {
-	down_read(&profile_rwsem);
 	notifier_call_chain(&munmap_notifier, 0, (void *)addr);
-	up_read(&profile_rwsem);
 }
 
 int task_handoff_register(struct notifier_block * n)
 {
-	int err = -EINVAL;
-
-	write_lock(&handoff_lock);
-	err = notifier_chain_register(&task_free_notifier, n);
-	write_unlock(&handoff_lock);
-	return err;
+	return notifier_chain_register(&task_free_notifier, n);
 }
 
 int task_handoff_unregister(struct notifier_block * n)
 {
-	int err = -EINVAL;
-
-	write_lock(&handoff_lock);
-	err = notifier_chain_unregister(&task_free_notifier, n);
-	write_unlock(&handoff_lock);
-	return err;
+	return notifier_chain_unregister(&task_free_notifier, n);
 }
 
 int profile_event_register(enum profile_type type, struct notifier_block * n)
 {
 	int err = -EINVAL;
  
-	down_write(&profile_rwsem);
- 
 	switch (type) {
 		case PROFILE_TASK_EXIT:
 			err = notifier_chain_register(&task_exit_notifier, n);
@@ -150,8 +130,6 @@ int profile_event_register(enum profile_
 			break;
 	}
  
-	up_write(&profile_rwsem);
- 
 	return err;
 }
 
@@ -160,8 +138,6 @@ int profile_event_unregister(enum profil
 {
 	int err = -EINVAL;
  
-	down_write(&profile_rwsem);
- 
 	switch (type) {
 		case PROFILE_TASK_EXIT:
 			err = notifier_chain_unregister(&task_exit_notifier, n);
@@ -171,7 +147,6 @@ int profile_event_unregister(enum profil
 			break;
 	}
 
-	up_write(&profile_rwsem);
 	return err;
 }
 

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


