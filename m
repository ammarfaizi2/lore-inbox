Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbWGaUeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWGaUeO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 16:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbWGaUeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 16:34:14 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:44552 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030193AbWGaUeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 16:34:13 -0400
Date: Mon, 31 Jul 2006 16:34:10 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: jesse.brandeburg@gmail.com, Andrew Morton <akpm@osdl.org>
cc: Kernel development list <linux-kernel@vger.kernel.org>,
       <torvalds@osdl.org>, <cpufreq@www.linux.org.uk>
Subject: Re: Linux v2.6.18-rc3
In-Reply-To: <20060731081112.05427677.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0607311627240.5805-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006, Andrew Morton wrote:

> core_initcall() would suit.  That's actually a bit late for this sort of
> thing, but we can always add a new section later if it becomes a problem. 
> I'd suggest that we ensure that srcu_notifier_chain_register() performs a
> reliable BUG() if it gets called too early.

Here's a patch to test.  I can't try it out on my machine because 
2.6.18-rc2-mm1 (even without the patch) crashes partway through a 
suspend-to-disk, in a way that's extremely hard to debug.  Some sort of 
spinlock-related bug occurs within ioapic_write_entry.

Alan Stern


Index: 2.6.18-rc2-mm1/kernel/sys.c
===================================================================
--- 2.6.18-rc2-mm1.orig/kernel/sys.c
+++ 2.6.18-rc2-mm1/kernel/sys.c
@@ -516,7 +516,7 @@ EXPORT_SYMBOL_GPL(srcu_notifier_call_cha
 void srcu_init_notifier_head(struct srcu_notifier_head *nh)
 {
 	mutex_init(&nh->mutex);
-	init_srcu_struct(&nh->srcu);
+	BUG_ON(init_srcu_struct(&nh->srcu) < 0);
 	nh->head = NULL;
 }
 
Index: 2.6.18-rc2-mm1/kernel/srcu.c
===================================================================
--- 2.6.18-rc2-mm1.orig/kernel/srcu.c
+++ 2.6.18-rc2-mm1/kernel/srcu.c
@@ -42,11 +42,12 @@
  * to any other function.  Each srcu_struct represents a separate domain
  * of SRCU protection.
  */
-void init_srcu_struct(struct srcu_struct *sp)
+int init_srcu_struct(struct srcu_struct *sp)
 {
 	sp->completed = 0;
-	sp->per_cpu_ref = alloc_percpu(struct srcu_struct_array);
 	mutex_init(&sp->mutex);
+	sp->per_cpu_ref = alloc_percpu(struct srcu_struct_array);
+	return (sp->per_cpu_ref ? 0 : -ENOMEM);
 }
 
 /*
Index: 2.6.18-rc2-mm1/include/linux/srcu.h
===================================================================
--- 2.6.18-rc2-mm1.orig/include/linux/srcu.h
+++ 2.6.18-rc2-mm1/include/linux/srcu.h
@@ -43,7 +43,7 @@ struct srcu_struct {
 #define srcu_barrier()
 #endif /* #else #ifndef CONFIG_PREEMPT */
 
-void init_srcu_struct(struct srcu_struct *sp);
+int init_srcu_struct(struct srcu_struct *sp);
 void cleanup_srcu_struct(struct srcu_struct *sp);
 int srcu_read_lock(struct srcu_struct *sp);
 void srcu_read_unlock(struct srcu_struct *sp, int idx);
Index: 2.6.18-rc2-mm1/drivers/cpufreq/cpufreq.c
===================================================================
--- 2.6.18-rc2-mm1.orig/drivers/cpufreq/cpufreq.c
+++ 2.6.18-rc2-mm1/drivers/cpufreq/cpufreq.c
@@ -52,8 +52,14 @@ static void handle_update(void *data);
  * The mutex locks both lists.
  */
 static BLOCKING_NOTIFIER_HEAD(cpufreq_policy_notifier_list);
-static BLOCKING_NOTIFIER_HEAD(cpufreq_transition_notifier_list);
+static struct srcu_notifier_head cpufreq_transition_notifier_list;
 
+static int __init init_cpufreq_transition_notifier_list(void)
+{
+	srcu_init_notifier_head(&cpufreq_transition_notifier_list);
+	return 0;
+}
+core_initcall(init_cpufreq_transition_notifier_list);
 
 static LIST_HEAD(cpufreq_governor_list);
 static DEFINE_MUTEX (cpufreq_governor_mutex);
@@ -262,14 +268,14 @@ void cpufreq_notify_transition(struct cp
 				freqs->old = policy->cur;
 			}
 		}
-		blocking_notifier_call_chain(&cpufreq_transition_notifier_list,
+		srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
 				CPUFREQ_PRECHANGE, freqs);
 		adjust_jiffies(CPUFREQ_PRECHANGE, freqs);
 		break;
 
 	case CPUFREQ_POSTCHANGE:
 		adjust_jiffies(CPUFREQ_POSTCHANGE, freqs);
-		blocking_notifier_call_chain(&cpufreq_transition_notifier_list,
+		srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
 				CPUFREQ_POSTCHANGE, freqs);
 		if (likely(policy) && likely(policy->cpu == freqs->cpu))
 			policy->cur = freqs->new;
@@ -1049,7 +1055,7 @@ static int cpufreq_suspend(struct sys_de
 		freqs.old = cpu_policy->cur;
 		freqs.new = cur_freq;
 
-		blocking_notifier_call_chain(&cpufreq_transition_notifier_list,
+		srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
 				    CPUFREQ_SUSPENDCHANGE, &freqs);
 		adjust_jiffies(CPUFREQ_SUSPENDCHANGE, &freqs);
 
@@ -1130,7 +1136,7 @@ static int cpufreq_resume(struct sys_dev
 			freqs.old = cpu_policy->cur;
 			freqs.new = cur_freq;
 
-			blocking_notifier_call_chain(
+			srcu_notifier_call_chain(
 					&cpufreq_transition_notifier_list,
 					CPUFREQ_RESUMECHANGE, &freqs);
 			adjust_jiffies(CPUFREQ_RESUMECHANGE, &freqs);
@@ -1176,7 +1182,7 @@ int cpufreq_register_notifier(struct not
 
 	switch (list) {
 	case CPUFREQ_TRANSITION_NOTIFIER:
-		ret = blocking_notifier_chain_register(
+		ret = srcu_notifier_chain_register(
 				&cpufreq_transition_notifier_list, nb);
 		break;
 	case CPUFREQ_POLICY_NOTIFIER:
@@ -1208,7 +1214,7 @@ int cpufreq_unregister_notifier(struct n
 
 	switch (list) {
 	case CPUFREQ_TRANSITION_NOTIFIER:
-		ret = blocking_notifier_chain_unregister(
+		ret = srcu_notifier_chain_unregister(
 				&cpufreq_transition_notifier_list, nb);
 		break;
 	case CPUFREQ_POLICY_NOTIFIER:

