Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWHBUig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWHBUig (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 16:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWHBUig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 16:38:36 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:24324 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751317AbWHBUif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 16:38:35 -0400
Date: Wed, 2 Aug 2006 16:38:35 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Jesse Brandeburg <jesse.brandeburg@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] cpufreq: make the transition_notifier chain use SRCU
In-Reply-To: <4807377b0608021257p27882866i69a5a0a4a1f05dda@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.0608021631230.8004-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (as762) changes the cpufreq_transition_notifier_list from a 
blocking_notifier_head to an srcu_notifier_head.  This will prevent errors 
caused attempting to call down_read() to access the notifier chain at a 
time when interrupts must remain disabled, during system suspend.

It's not clear to me whether this is really necessary; perhaps the 
chain could be made into an atomic_notifier.  However a couple of the 
callout routines do use blocking operations, so this approach seems safer.

The head of the notifier chain needs to be initialized before use; this is 
done by an __init routine at core_initcall time.  If this turns out not to 
be a good choice, it can easily be changed.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

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

