Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424690AbWKPVsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424690AbWKPVsT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 16:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424691AbWKPVsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 16:48:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32971 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1424690AbWKPVsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 16:48:18 -0500
Date: Thu, 16 Nov 2006 13:47:48 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Thomas Gleixner <tglx@timesys.com>
cc: Ingo Molnar <mingo@elte.hu>, Alan Stern <stern@rowland.harvard.edu>,
       LKML <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>,
       David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
In-Reply-To: <1163709936.10333.32.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0611161342320.3349@woody.osdl.org>
References: <1163707250.10333.24.camel@localhost.localdomain> 
 <20061116201531.GA31469@elte.hu> <1163709936.10333.32.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Nov 2006, Thomas Gleixner wrote:
> 
> Here is the i386/sparc fixup

Gag me with a volvo.

This is disgusting, but I would actually prefer the following version over 
the patches I've seen, because

 - it doesn't end up having any architecture-specific parts

 - it doesn't use the new "xxx_sync()" thing that I'm not even sure we 
   should be using.

 - it makes it clear that this should be fixed, preferably by just having 
   some way to initialize SRCU structs staticalyl. If we get that, the fix 
   is to just replace the horrible "initialize by hand" with a static 
   initializer once and for all.

Hmm?

Totally untested, but it compiles and it _looks_ sane. The overhead of the 
function call should be minimal, once things are initialized.

Paul, it would be _really_ nice to have some way to just initialize that 
SRCU thing statically. This kind of crud is just crazy.

Comments?

		Linus

----
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 86e69b7..02326b2 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -52,14 +52,39 @@ static void handle_update(void *data);
  * The mutex locks both lists.
  */
 static BLOCKING_NOTIFIER_HEAD(cpufreq_policy_notifier_list);
-static struct srcu_notifier_head cpufreq_transition_notifier_list;
 
-static int __init init_cpufreq_transition_notifier_list(void)
+/*
+ * This is horribly horribly ugly.
+ *
+ * We really want to initialize the transition notifier list
+ * statically and just once, but there is no static way to
+ * initialize a srcu lock, so we instead make up all this nasty
+ * infrastructure to make sure it's initialized when we use it.
+ *
+ * Bleaargh.
+ */
+static struct srcu_notifier_head *cpufreq_transition_notifier_list(void)
 {
-	srcu_init_notifier_head(&cpufreq_transition_notifier_list);
-	return 0;
+	static struct srcu_notifier_head *initialized;
+	struct srcu_notifier_head *ret;
+
+	ret = initialized;
+	if (!ret) {
+		static DEFINE_MUTEX(init_lock);
+
+		mutex_lock(&init_lock);
+		ret = initialized;
+		if (!ret) {
+			static struct srcu_notifier_head list_head;
+			ret = &list_head;
+			srcu_init_notifier_head(ret);
+			smp_wmb();
+			initialized = ret;
+		}
+		mutex_unlock(&init_lock);
+	}
+	return ret;
 }
-core_initcall(init_cpufreq_transition_notifier_list);
 
 static LIST_HEAD(cpufreq_governor_list);
 static DEFINE_MUTEX (cpufreq_governor_mutex);
@@ -268,14 +293,14 @@ void cpufreq_notify_transition(struct cp
 				freqs->old = policy->cur;
 			}
 		}
-		srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
+		srcu_notifier_call_chain(cpufreq_transition_notifier_list(),
 				CPUFREQ_PRECHANGE, freqs);
 		adjust_jiffies(CPUFREQ_PRECHANGE, freqs);
 		break;
 
 	case CPUFREQ_POSTCHANGE:
 		adjust_jiffies(CPUFREQ_POSTCHANGE, freqs);
-		srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
+		srcu_notifier_call_chain(cpufreq_transition_notifier_list(),
 				CPUFREQ_POSTCHANGE, freqs);
 		if (likely(policy) && likely(policy->cpu == freqs->cpu))
 			policy->cur = freqs->new;
@@ -1055,7 +1080,7 @@ static int cpufreq_suspend(struct sys_de
 		freqs.old = cpu_policy->cur;
 		freqs.new = cur_freq;
 
-		srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
+		srcu_notifier_call_chain(cpufreq_transition_notifier_list(),
 				    CPUFREQ_SUSPENDCHANGE, &freqs);
 		adjust_jiffies(CPUFREQ_SUSPENDCHANGE, &freqs);
 
@@ -1137,7 +1162,7 @@ static int cpufreq_resume(struct sys_dev
 			freqs.new = cur_freq;
 
 			srcu_notifier_call_chain(
-					&cpufreq_transition_notifier_list,
+					cpufreq_transition_notifier_list(),
 					CPUFREQ_RESUMECHANGE, &freqs);
 			adjust_jiffies(CPUFREQ_RESUMECHANGE, &freqs);
 
@@ -1183,7 +1208,7 @@ int cpufreq_register_notifier(struct not
 	switch (list) {
 	case CPUFREQ_TRANSITION_NOTIFIER:
 		ret = srcu_notifier_chain_register(
-				&cpufreq_transition_notifier_list, nb);
+				cpufreq_transition_notifier_list(), nb);
 		break;
 	case CPUFREQ_POLICY_NOTIFIER:
 		ret = blocking_notifier_chain_register(
@@ -1215,7 +1240,7 @@ int cpufreq_unregister_notifier(struct n
 	switch (list) {
 	case CPUFREQ_TRANSITION_NOTIFIER:
 		ret = srcu_notifier_chain_unregister(
-				&cpufreq_transition_notifier_list, nb);
+				cpufreq_transition_notifier_list(), nb);
 		break;
 	case CPUFREQ_POLICY_NOTIFIER:
 		ret = blocking_notifier_chain_unregister(
