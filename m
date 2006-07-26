Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751626AbWGZNpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbWGZNpv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 09:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbWGZNpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 09:45:51 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:33222 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1751615AbWGZNpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 09:45:50 -0400
Subject: [patch] Reorganize the cpufreq cpu hotplug locking to not be
	totally bizare
From: Arjan van de Ven <arjan@linux.intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Chuck Ebbert <76306.1226@compuserve.com>,
       Ashok Raj <ashok.raj@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607251355080.29649@g5.osdl.org>
References: <200607242023_MC3-1-C5FE-CADB@compuserve.com>
	 <Pine.LNX.4.64.0607241752290.29649@g5.osdl.org>
	 <20060725185449.GA8074@elte.hu>
	 <1153855844.8932.56.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0607251355080.29649@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 26 Jul 2006 15:40:07 +0200
Message-Id: <1153921207.3381.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-25 at 13:57 -0700, Linus Torvalds wrote:
> 
> On Tue, 25 Jul 2006, Arjan van de Ven wrote:
> >
> > so cpufreq_set_policy() takes policy->lock, and then calls into the
> > userspace governer code
> > (__cpufreq_set_policy->cpufreq_governor->cpufreq_governor_userspace)
> > which calls __cpufreq_driver_target... which does lock_cpu_hotplug().
> 
> Yeah. I think the target should _not_ take the lock_cpu_hotplug(), since 
> the call chain (much much earlier) should have done it. 
> 
> Ie we should probably do it at the "cpufreq_set_policy()" level.
> 
> >      Arjan -- who's just cleaned Linus' wall to prepare it for more head
> > banging
> 
> It's not actually "my wall". I'll happily share it with anybody else.
> 
> Please. Take my wall.

I had to clean the wall again after making the following patch, but at
least something useful came out of it:



Subject: Reorganize the cpufreq cpu hotplug locking to not be totally bizare
From: Arjan van de Ven <arjan@linux.intel.com>

The patch below moves the cpu hotplugging higher up in the cpufreq
layering; this is needed to avoid recursive taking of the cpu hotplug
lock and to otherwise detangle the mess.

The new rules are:
1. you must do lock_cpu_hotplug() around the following functions:
   __cpufreq_driver_target
   __cpufreq_governor (for CPUFREQ_GOV_LIMITS operation only)
   __cpufreq_set_policy
2. governer methods (.governer) must NOT take the lock_cpu_hotplug()
   lock in any way; they are called with the lock taken already
3. if your governer spawns a thread that does things, like calling
   __cpufreq_driver_target, your thread must honor rule #1.
4. the policy lock and other cpufreq internal locks nest within 
   the lock_cpu_hotplug() lock. 

I'm not entirely happy about how the __cpufreq_governor rule ended up
(conditional locking rule depending on the argument) but basically all
callers pass this as a constant so it's not too horrible.

The patch also removes the cpufreq_governor() function since during the
locking audit it turned out to be entirely unused (so no need to fix it)

The patch works on my testbox, but it could use more testing 
(otoh... it can't be much worse than the current code)

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

Index: linux-2.6.18-rc2-git5/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-2.6.18-rc2-git5.orig/drivers/cpufreq/cpufreq.c
+++ linux-2.6.18-rc2-git5/drivers/cpufreq/cpufreq.c
@@ -364,10 +364,12 @@ static ssize_t store_##file_name					\
 	if (ret != 1)							\
 		return -EINVAL;						\
 									\
+	lock_cpu_hotplug();						\
 	mutex_lock(&policy->lock);					\
 	ret = __cpufreq_set_policy(policy, &new_policy);		\
 	policy->user_policy.object = policy->object;			\
 	mutex_unlock(&policy->lock);					\
+	unlock_cpu_hotplug();						\
 									\
 	return ret ? ret : count;					\
 }
@@ -1197,20 +1199,18 @@ EXPORT_SYMBOL(cpufreq_unregister_notifie
  *********************************************************************/
 
 
+/* Must be called with lock_cpu_hotplug held */
 int __cpufreq_driver_target(struct cpufreq_policy *policy,
 			    unsigned int target_freq,
 			    unsigned int relation)
 {
 	int retval = -EINVAL;
 
-	lock_cpu_hotplug();
 	dprintk("target for CPU %u: %u kHz, relation %u\n", policy->cpu,
 		target_freq, relation);
 	if (cpu_online(policy->cpu) && cpufreq_driver->target)
 		retval = cpufreq_driver->target(policy, target_freq, relation);
 
-	unlock_cpu_hotplug();
-
 	return retval;
 }
 EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
@@ -1225,17 +1225,23 @@ int cpufreq_driver_target(struct cpufreq
 	if (!policy)
 		return -EINVAL;
 
+	lock_cpu_hotplug();
 	mutex_lock(&policy->lock);
 
 	ret = __cpufreq_driver_target(policy, target_freq, relation);
 
 	mutex_unlock(&policy->lock);
+	unlock_cpu_hotplug();
 
 	cpufreq_cpu_put(policy);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_target);
 
+/*
+ * Locking: Must be called with the lock_cpu_hotplug() lock held
+ * when "event" is CPUFREQ_GOV_LIMITS
+ */
 
 static int __cpufreq_governor(struct cpufreq_policy *policy, unsigned int event)
 {
@@ -1257,24 +1263,6 @@ static int __cpufreq_governor(struct cpu
 }
 
 
-int cpufreq_governor(unsigned int cpu, unsigned int event)
-{
-	int ret = 0;
-	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
-
-	if (!policy)
-		return -EINVAL;
-
-	mutex_lock(&policy->lock);
-	ret = __cpufreq_governor(policy, event);
-	mutex_unlock(&policy->lock);
-
-	cpufreq_cpu_put(policy);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(cpufreq_governor);
-
-
 int cpufreq_register_governor(struct cpufreq_governor *governor)
 {
 	struct cpufreq_governor *t;
@@ -1342,6 +1330,9 @@ int cpufreq_get_policy(struct cpufreq_po
 EXPORT_SYMBOL(cpufreq_get_policy);
 
 
+/*
+ * Locking: Must be called with the lock_cpu_hotplug() lock held
+ */
 static int __cpufreq_set_policy(struct cpufreq_policy *data, struct cpufreq_policy *policy)
 {
 	int ret = 0;
@@ -1436,6 +1427,8 @@ int cpufreq_set_policy(struct cpufreq_po
 	if (!data)
 		return -EINVAL;
 
+	lock_cpu_hotplug();
+
 	/* lock this CPU */
 	mutex_lock(&data->lock);
 
@@ -1446,6 +1439,8 @@ int cpufreq_set_policy(struct cpufreq_po
 	data->user_policy.governor = data->governor;
 
 	mutex_unlock(&data->lock);
+
+	unlock_cpu_hotplug();
 	cpufreq_cpu_put(data);
 
 	return ret;
@@ -1469,6 +1464,7 @@ int cpufreq_update_policy(unsigned int c
 	if (!data)
 		return -ENODEV;
 
+	lock_cpu_hotplug();
 	mutex_lock(&data->lock);
 
 	dprintk("updating policy for CPU %u\n", cpu);
@@ -1494,7 +1490,7 @@ int cpufreq_update_policy(unsigned int c
 	ret = __cpufreq_set_policy(data, &policy);
 
 	mutex_unlock(&data->lock);
-
+	unlock_cpu_hotplug();
 	cpufreq_cpu_put(data);
 	return ret;
 }
Index: linux-2.6.18-rc2-git5/drivers/cpufreq/cpufreq_conservative.c
===================================================================
--- linux-2.6.18-rc2-git5.orig/drivers/cpufreq/cpufreq_conservative.c
+++ linux-2.6.18-rc2-git5/drivers/cpufreq/cpufreq_conservative.c
@@ -525,7 +525,6 @@ static int cpufreq_governor_dbs(struct c
 		break;
 
 	case CPUFREQ_GOV_LIMITS:
-		lock_cpu_hotplug();
 		mutex_lock(&dbs_mutex);
 		if (policy->max < this_dbs_info->cur_policy->cur)
 			__cpufreq_driver_target(
@@ -536,7 +535,6 @@ static int cpufreq_governor_dbs(struct c
 					this_dbs_info->cur_policy,
 				       	policy->min, CPUFREQ_RELATION_L);
 		mutex_unlock(&dbs_mutex);
-		unlock_cpu_hotplug();
 		break;
 	}
 	return 0;
Index: linux-2.6.18-rc2-git5/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-2.6.18-rc2-git5.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-2.6.18-rc2-git5/drivers/cpufreq/cpufreq_ondemand.c
@@ -309,7 +309,9 @@ static void do_dbs_timer(void *data)
 	if (!dbs_info->enable)
 		return;
 
+	lock_cpu_hotplug();
 	dbs_check_cpu(dbs_info);
+	unlock_cpu_hotplug();
 	queue_delayed_work_on(cpu, kondemand_wq, &dbs_info->work,
 			usecs_to_jiffies(dbs_tuners_ins.sampling_rate));
 }
@@ -412,7 +414,6 @@ static int cpufreq_governor_dbs(struct c
 		break;
 
 	case CPUFREQ_GOV_LIMITS:
-		lock_cpu_hotplug();
 		mutex_lock(&dbs_mutex);
 		if (policy->max < this_dbs_info->cur_policy->cur)
 			__cpufreq_driver_target(this_dbs_info->cur_policy,
@@ -423,7 +424,6 @@ static int cpufreq_governor_dbs(struct c
 			                        policy->min,
 			                        CPUFREQ_RELATION_L);
 		mutex_unlock(&dbs_mutex);
-		unlock_cpu_hotplug();
 		break;
 	}
 	return 0;
Index: linux-2.6.18-rc2-git5/include/linux/cpufreq.h
===================================================================
--- linux-2.6.18-rc2-git5.orig/include/linux/cpufreq.h
+++ linux-2.6.18-rc2-git5/include/linux/cpufreq.h
@@ -172,9 +172,6 @@ extern int __cpufreq_driver_target(struc
 				   unsigned int relation);
 
 
-/* pass an event to the cpufreq governor */
-int cpufreq_governor(unsigned int cpu, unsigned int event);
-
 int cpufreq_register_governor(struct cpufreq_governor *governor);
 void cpufreq_unregister_governor(struct cpufreq_governor *governor);
 
Index: linux-2.6.18-rc2-git5/drivers/cpufreq/cpufreq_userspace.c
===================================================================
--- linux-2.6.18-rc2-git5.orig/drivers/cpufreq/cpufreq_userspace.c
+++ linux-2.6.18-rc2-git5/drivers/cpufreq/cpufreq_userspace.c
@@ -18,6 +18,7 @@
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/cpufreq.h>
+#include <linux/cpu.h>
 #include <linux/types.h>
 #include <linux/fs.h>
 #include <linux/sysfs.h>
@@ -70,6 +71,7 @@ static int cpufreq_set(unsigned int freq
 
 	dprintk("cpufreq_set for cpu %u, freq %u kHz\n", policy->cpu, freq);
 
+	lock_cpu_hotplug();
 	mutex_lock(&userspace_mutex);
 	if (!cpu_is_managed[policy->cpu])
 		goto err;
@@ -92,6 +94,7 @@ static int cpufreq_set(unsigned int freq
 
  err:
 	mutex_unlock(&userspace_mutex);
+	unlock_cpu_hotplug();
 	return ret;
 }
 

