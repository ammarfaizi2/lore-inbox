Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbWHXKdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbWHXKdS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 06:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWHXKdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 06:33:18 -0400
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:8636 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP
	id S1751048AbWHXKdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 06:33:16 -0400
Date: Thu, 24 Aug 2006 16:04:17 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: rusty@rustcorp.com.au, torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, arjan@intel.linux.com, mingo@elte.hu,
       davej@redhat.com, dipankar@in.ibm.com, vatsa@in.ibm.com,
       ashok.raj@intel.com
Subject: [RFC][PATCH 4/4] Rename lock_cpu_hotplug/unlock_cpu_hotplug
Message-ID: <20060824103417.GE2395@in.ibm.com>
Reply-To: ego@in.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rz+pwK2yUstbofK6"
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"

--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="4of4.patch"

This patch renames lock_cpu_hotplug to cpu_hotplug_disable and
unlock_cpu_hotplug to cpu_hotplug_enable throughout the kernel.

Signed-off-by : Gautham R Shenoy <ego@in.ibm.com>

Index: current/include/linux/cpu.h
===================================================================
--- current.orig/include/linux/cpu.h	2006-08-06 23:50:11.000000000 +0530
+++ current/include/linux/cpu.h	2006-08-24 15:00:07.000000000 +0530
@@ -66,8 +66,8 @@ extern struct sysdev_class cpu_sysdev_cl
 
 #ifdef CONFIG_HOTPLUG_CPU
 /* Stop CPUs going up and down. */
-extern void lock_cpu_hotplug(void);
-extern void unlock_cpu_hotplug(void);
+extern void cpu_hotplug_disable(void);
+extern void cpu_hotplug_enable(void);
 #define hotcpu_notifier(fn, pri) {				\
 	static struct notifier_block fn##_nb =			\
 		{ .notifier_call = fn, .priority = pri };	\
@@ -78,9 +78,8 @@ extern void unlock_cpu_hotplug(void);
 int cpu_down(unsigned int cpu);
 #define cpu_is_offline(cpu) unlikely(!cpu_online(cpu))
 #else
-#define lock_cpu_hotplug()	do { } while (0)
-#define unlock_cpu_hotplug()	do { } while (0)
-#define lock_cpu_hotplug_interruptible() 0
+#define cpu_hotplug_disable()	do { } while (0)
+#define cpu_hotplug_enable()	do { } while (0)
 #define hotcpu_notifier(fn, pri)	do { } while (0)
 #define register_hotcpu_notifier(nb)	do { } while (0)
 #define unregister_hotcpu_notifier(nb)	do { } while (0)
Index: current/arch/mips/kernel/mips-mt.c
===================================================================
--- current.orig/arch/mips/kernel/mips-mt.c	2006-08-06 23:50:11.000000000 +0530
+++ current/arch/mips/kernel/mips-mt.c	2006-08-24 15:00:07.000000000 +0530
@@ -71,13 +71,13 @@ asmlinkage long mipsmt_sys_sched_setaffi
 	if (copy_from_user(&new_mask, user_mask_ptr, sizeof(new_mask)))
 		return -EFAULT;
 
-	lock_cpu_hotplug();
+	cpu_hotplug_disable();
 	read_lock(&tasklist_lock);
 
 	p = find_process_by_pid(pid);
 	if (!p) {
 		read_unlock(&tasklist_lock);
-		unlock_cpu_hotplug();
+		cpu_hotplug_enable();
 		return -ESRCH;
 	}
 
@@ -115,7 +115,7 @@ asmlinkage long mipsmt_sys_sched_setaffi
 
 out_unlock:
 	put_task_struct(p);
-	unlock_cpu_hotplug();
+	cpu_hotplug_enable();
 	return retval;
 }
 
@@ -134,7 +134,7 @@ asmlinkage long mipsmt_sys_sched_getaffi
 	if (len < real_len)
 		return -EINVAL;
 
-	lock_cpu_hotplug();
+	cpu_hotplug_disable();
 	read_lock(&tasklist_lock);
 
 	retval = -ESRCH;
@@ -148,7 +148,7 @@ asmlinkage long mipsmt_sys_sched_getaffi
 
 out_unlock:
 	read_unlock(&tasklist_lock);
-	unlock_cpu_hotplug();
+	cpu_hotplug_enable();
 	if (retval)
 		return retval;
 	if (copy_to_user(user_mask_ptr, &mask, real_len))
Index: current/arch/i386/kernel/cpu/mtrr/main.c
===================================================================
--- current.orig/arch/i386/kernel/cpu/mtrr/main.c	2006-08-06 23:50:11.000000000 +0530
+++ current/arch/i386/kernel/cpu/mtrr/main.c	2006-08-24 15:00:07.000000000 +0530
@@ -332,7 +332,7 @@ int mtrr_add_page(unsigned long base, un
 	error = -EINVAL;
 
 	/* No CPU hotplug when we change MTRR entries */
-	lock_cpu_hotplug();
+	cpu_hotplug_disable();
 	/*  Search for existing MTRR  */
 	mutex_lock(&mtrr_mutex);
 	for (i = 0; i < num_var_ranges; ++i) {
@@ -373,7 +373,7 @@ int mtrr_add_page(unsigned long base, un
 	error = i;
  out:
 	mutex_unlock(&mtrr_mutex);
-	unlock_cpu_hotplug();
+	cpu_hotplug_enable();
 	return error;
 }
 
@@ -464,7 +464,7 @@ int mtrr_del_page(int reg, unsigned long
 
 	max = num_var_ranges;
 	/* No CPU hotplug when we change MTRR entries */
-	lock_cpu_hotplug();
+	cpu_hotplug_disable();
 	mutex_lock(&mtrr_mutex);
 	if (reg < 0) {
 		/*  Search for existing MTRR  */
@@ -505,7 +505,7 @@ int mtrr_del_page(int reg, unsigned long
 	error = reg;
  out:
 	mutex_unlock(&mtrr_mutex);
-	unlock_cpu_hotplug();
+	cpu_hotplug_enable();
 	return error;
 }
 /**
Index: current/arch/powerpc/platforms/pseries/smp.c
===================================================================
--- current.orig/arch/powerpc/platforms/pseries/smp.c	2006-08-06 23:50:11.000000000 +0530
+++ current/arch/powerpc/platforms/pseries/smp.c	2006-08-24 15:00:07.000000000 +0530
@@ -155,7 +155,7 @@ static int pSeries_add_processor(struct 
 	for (i = 0; i < nthreads; i++)
 		cpu_set(i, tmp);
 
-	lock_cpu_hotplug();
+	cpu_hotplug_disable();
 
 	BUG_ON(!cpus_subset(cpu_present_map, cpu_possible_map));
 
@@ -192,7 +192,7 @@ static int pSeries_add_processor(struct 
 	}
 	err = 0;
 out_unlock:
-	unlock_cpu_hotplug();
+	cpu_hotplug_enable();
 	return err;
 }
 
@@ -213,7 +213,7 @@ static void pSeries_remove_processor(str
 
 	nthreads = len / sizeof(u32);
 
-	lock_cpu_hotplug();
+	cpu_hotplug_disable();
 	for (i = 0; i < nthreads; i++) {
 		for_each_present_cpu(cpu) {
 			if (get_hard_smp_processor_id(cpu) != intserv[i])
@@ -227,7 +227,7 @@ static void pSeries_remove_processor(str
 			printk(KERN_WARNING "Could not find cpu to remove "
 			       "with physical id 0x%x\n", intserv[i]);
 	}
-	unlock_cpu_hotplug();
+	cpu_hotplug_enable();
 }
 
 static int pSeries_smp_notifier(struct notifier_block *nb, unsigned long action, void *node)
Index: current/arch/powerpc/platforms/pseries/rtasd.c
===================================================================
--- current.orig/arch/powerpc/platforms/pseries/rtasd.c	2006-08-06 23:50:11.000000000 +0530
+++ current/arch/powerpc/platforms/pseries/rtasd.c	2006-08-24 15:00:07.000000000 +0530
@@ -404,7 +404,7 @@ static void do_event_scan_all_cpus(long 
 {
 	int cpu;
 
-	lock_cpu_hotplug();
+	cpu_hotplug_disable();
 	cpu = first_cpu(cpu_online_map);
 	for (;;) {
 		set_cpus_allowed(current, cpumask_of_cpu(cpu));
@@ -412,15 +412,15 @@ static void do_event_scan_all_cpus(long 
 		set_cpus_allowed(current, CPU_MASK_ALL);
 
 		/* Drop hotplug lock, and sleep for the specified delay */
-		unlock_cpu_hotplug();
+		cpu_hotplug_enable();
 		msleep_interruptible(delay);
-		lock_cpu_hotplug();
+		cpu_hotplug_disable();
 
 		cpu = next_cpu(cpu, cpu_online_map);
 		if (cpu == NR_CPUS)
 			break;
 	}
-	unlock_cpu_hotplug();
+	cpu_hotplug_enable();
 }
 
 static int rtasd(void *unused)
Index: current/net/core/flow.c
===================================================================
--- current.orig/net/core/flow.c	2006-08-06 23:50:11.000000000 +0530
+++ current/net/core/flow.c	2006-08-24 15:00:07.000000000 +0530
@@ -291,7 +291,7 @@ void flow_cache_flush(void)
 	static DEFINE_MUTEX(flow_flush_sem);
 
 	/* Don't want cpus going down or up during this. */
-	lock_cpu_hotplug();
+	cpu_hotplug_disable();
 	mutex_lock(&flow_flush_sem);
 	atomic_set(&info.cpuleft, num_online_cpus());
 	init_completion(&info.completion);
@@ -303,7 +303,7 @@ void flow_cache_flush(void)
 
 	wait_for_completion(&info.completion);
 	mutex_unlock(&flow_flush_sem);
-	unlock_cpu_hotplug();
+	cpu_hotplug_enable();
 }
 
 static void __devinit flow_cache_cpu_prepare(int cpu)
Index: current/drivers/cpufreq/cpufreq.c
===================================================================
--- current.orig/drivers/cpufreq/cpufreq.c	2006-08-24 14:59:59.000000000 +0530
+++ current/drivers/cpufreq/cpufreq.c	2006-08-24 15:00:07.000000000 +0530
@@ -394,12 +394,12 @@ static ssize_t store_##file_name					\
 	if (ret != 1)							\
 		return -EINVAL;						\
 									\
-	lock_cpu_hotplug();						\
+	cpu_hotplug_disable();						\
 	mutex_lock(&policy->lock);					\
 	ret = __cpufreq_set_policy(policy, &new_policy);		\
 	policy->user_policy.object = policy->object;			\
 	mutex_unlock(&policy->lock);					\
-	unlock_cpu_hotplug();						\
+	cpu_hotplug_enable();						\
 									\
 	return ret ? ret : count;					\
 }
@@ -455,7 +455,7 @@ static ssize_t store_scaling_governor (s
 	if (cpufreq_parse_governor(str_governor, &new_policy.policy, &new_policy.governor))
 		return -EINVAL;
 
-	lock_cpu_hotplug();
+	cpu_hotplug_disable();
 
 	/* Do not use cpufreq_set_policy here or the user_policy.max
 	   will be wrongly overridden */
@@ -466,7 +466,7 @@ static ssize_t store_scaling_governor (s
 	policy->user_policy.governor = policy->governor;
 	mutex_unlock(&policy->lock);
 
-	unlock_cpu_hotplug();
+	cpu_hotplug_enable();
 
 	return ret ? ret : count;
 }
@@ -1229,7 +1229,7 @@ EXPORT_SYMBOL(cpufreq_unregister_notifie
  *********************************************************************/
 
 
-/* Must be called with lock_cpu_hotplug held */
+/* Must be called with cpu_hotplug_disable held */
 int __cpufreq_driver_target(struct cpufreq_policy *policy,
 			    unsigned int target_freq,
 			    unsigned int relation)
@@ -1250,9 +1250,9 @@ int cpufreq_driver_target(struct cpufreq
 				    unsigned int relation)
 {
 	int ret=0;
-	lock_cpu_hotplug();
+	cpu_hotplug_disable();
 	ret= cpufreq_driver_target_cpulocked(policy,target_freq,relation);
-	unlock_cpu_hotplug();
+	cpu_hotplug_enable();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_target);
@@ -1279,7 +1279,7 @@ int cpufreq_driver_target_cpulocked(stru
 EXPORT_SYMBOL_GPL(cpufreq_driver_target_cpulocked);
 
 /*
- * Locking: Must be called with the lock_cpu_hotplug() lock held
+ * Locking: Must be called with the cpu_hotplug_disable() lock held
  * when "event" is CPUFREQ_GOV_LIMITS
  */
 
@@ -1369,7 +1369,7 @@ EXPORT_SYMBOL(cpufreq_get_policy);
 
 
 /*
- * Locking: Must be called with the lock_cpu_hotplug() lock held
+ * Locking: Must be called with the cpu_hotplug_disable() lock held
  */
 static int __cpufreq_set_policy(struct cpufreq_policy *data, struct cpufreq_policy *policy)
 {
@@ -1461,9 +1461,9 @@ error_out:
 int cpufreq_set_policy(struct cpufreq_policy *policy)
 {
 	int ret=0;
-	lock_cpu_hotplug();
+	cpu_hotplug_disable();
 	ret = cpufreq_set_policy_cpulocked(policy);
-	unlock_cpu_hotplug();
+	cpu_hotplug_enable();
 	return ret;
 }
 
@@ -1501,7 +1501,7 @@ EXPORT_SYMBOL(cpufreq_set_policy);
 /**
  *	cpufreq_update_policy_cpulocked - re-evaluate an existing cpufreq
  *	policy.
- *	To be called with lock_cpu_hotplug() held.
+ *	To be called with cpu_hotplug_disable() held.
  *	@cpu: CPU which shall be re-evaluated
  *
  *	Usefull for policy notifiers which have different necessities
@@ -1549,7 +1549,7 @@ EXPORT_SYMBOL(cpufreq_update_policy_cpul
 /**
  *	cpufreq_update_policy - re-evaluate an existing cpufreq
  *	policy.
- *	Must be called with lock_cpu_hotplug() *not* being held.
+ *	Must be called with cpu_hotplug_disable() *not* being held.
  *	@cpu: CPU which shall be re-evaluated
  *
  *	Usefull for policy notifiers which have different necessities
@@ -1558,9 +1558,9 @@ EXPORT_SYMBOL(cpufreq_update_policy_cpul
 int cpufreq_update_policy(unsigned int cpu)
 {
 	int ret=0;
-	lock_cpu_hotplug();
+	cpu_hotplug_disable();
 	cpufreq_update_policy_cpulocked(cpu);
-	unlock_cpu_hotplug();
+	cpu_hotplug_enable();
 	return ret;
 }
 EXPORT_SYMBOL(cpufreq_update_policy);
Index: current/drivers/cpufreq/cpufreq_stats.c
===================================================================
--- current.orig/drivers/cpufreq/cpufreq_stats.c	2006-08-24 14:59:59.000000000 +0530
+++ current/drivers/cpufreq/cpufreq_stats.c	2006-08-24 15:00:07.000000000 +0530
@@ -350,12 +350,12 @@ __init cpufreq_stats_init(void)
 	}
 
 	register_hotcpu_notifier(&cpufreq_stat_cpu_notifier);
-	lock_cpu_hotplug();
+	cpu_hotplug_disable();
 	for_each_online_cpu(cpu) {
 		cpufreq_stat_cpu_callback(&cpufreq_stat_cpu_notifier, CPU_ONLINE,
 			(void *)(long)cpu);
 	}
-	unlock_cpu_hotplug();
+	cpu_hotplug_enable();
 	return 0;
 }
 static void
@@ -368,12 +368,12 @@ __exit cpufreq_stats_exit(void)
 	cpufreq_unregister_notifier(&notifier_trans_block,
 			CPUFREQ_TRANSITION_NOTIFIER);
 	unregister_hotcpu_notifier(&cpufreq_stat_cpu_notifier);
-	lock_cpu_hotplug();
+	cpu_hotplug_disable();
 	for_each_online_cpu(cpu) {
 		cpufreq_stat_cpu_callback(&cpufreq_stat_cpu_notifier, CPU_DEAD,
 			(void *)(long)cpu);
 	}
-	unlock_cpu_hotplug();
+	cpu_hotplug_enable();
 }
 
 MODULE_AUTHOR ("Zou Nan hai <nanhai.zou@intel.com>");
Index: current/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- current.orig/drivers/cpufreq/cpufreq_ondemand.c	2006-08-06 23:50:11.000000000 +0530
+++ current/drivers/cpufreq/cpufreq_ondemand.c	2006-08-24 15:00:07.000000000 +0530
@@ -309,9 +309,9 @@ static void do_dbs_timer(void *data)
 	if (!dbs_info->enable)
 		return;
 
-	lock_cpu_hotplug();
+	cpu_hotplug_disable();
 	dbs_check_cpu(dbs_info);
-	unlock_cpu_hotplug();
+	cpu_hotplug_enable();
 	queue_delayed_work_on(cpu, kondemand_wq, &dbs_info->work,
 			usecs_to_jiffies(dbs_tuners_ins.sampling_rate));
 }
Index: current/drivers/cpufreq/cpufreq_userspace.c
===================================================================
--- current.orig/drivers/cpufreq/cpufreq_userspace.c	2006-08-06 23:50:11.000000000 +0530
+++ current/drivers/cpufreq/cpufreq_userspace.c	2006-08-24 15:00:07.000000000 +0530
@@ -71,7 +71,7 @@ static int cpufreq_set(unsigned int freq
 
 	dprintk("cpufreq_set for cpu %u, freq %u kHz\n", policy->cpu, freq);
 
-	lock_cpu_hotplug();
+	cpu_hotplug_disable();
 	mutex_lock(&userspace_mutex);
 	if (!cpu_is_managed[policy->cpu])
 		goto err;
@@ -94,7 +94,7 @@ static int cpufreq_set(unsigned int freq
 
  err:
 	mutex_unlock(&userspace_mutex);
-	unlock_cpu_hotplug();
+	cpu_hotplug_enable();
 	return ret;
 }
 
Index: current/drivers/cpufreq/cpufreq_conservative.c
===================================================================
--- current.orig/drivers/cpufreq/cpufreq_conservative.c	2006-08-06 23:50:11.000000000 +0530
+++ current/drivers/cpufreq/cpufreq_conservative.c	2006-08-24 15:00:07.000000000 +0530
@@ -423,14 +423,14 @@ static void dbs_check_cpu(int cpu)
 static void do_dbs_timer(void *data)
 { 
 	int i;
-	lock_cpu_hotplug();
+	cpu_hotplug_disable();
 	mutex_lock(&dbs_mutex);
 	for_each_online_cpu(i)
 		dbs_check_cpu(i);
 	schedule_delayed_work(&dbs_work, 
 			usecs_to_jiffies(dbs_tuners_ins.sampling_rate));
 	mutex_unlock(&dbs_mutex);
-	unlock_cpu_hotplug();
+	cpu_hotplug_enable();
 } 
 
 static inline void dbs_timer_init(void)
Index: current/kernel/stop_machine.c
===================================================================
--- current.orig/kernel/stop_machine.c	2006-08-06 23:50:11.000000000 +0530
+++ current/kernel/stop_machine.c	2006-08-24 15:00:07.000000000 +0530
@@ -196,13 +196,13 @@ int stop_machine_run(int (*fn)(void *), 
 	int ret;
 
 	/* No CPUs can come up or down during this. */
-	lock_cpu_hotplug();
+	cpu_hotplug_disable();
 	p = __stop_machine_run(fn, data, cpu);
 	if (!IS_ERR(p))
 		ret = kthread_stop(p);
 	else
 		ret = PTR_ERR(p);
-	unlock_cpu_hotplug();
+	cpu_hotplug_enable();
 
 	return ret;
 }
Index: current/kernel/cpuset.c
===================================================================
--- current.orig/kernel/cpuset.c	2006-08-06 23:50:11.000000000 +0530
+++ current/kernel/cpuset.c	2006-08-24 15:00:07.000000000 +0530
@@ -761,9 +761,9 @@ static int validate_change(const struct 
  * Build these two partitions by calling partition_sched_domains
  *
  * Call with manage_mutex held.  May nest a call to the
- * lock_cpu_hotplug()/unlock_cpu_hotplug() pair.
+ * cpu_hotplug_disable()/cpu_hotplug_enable() pair.
  * Must not be called holding callback_mutex, because we must
- * not call lock_cpu_hotplug() while holding callback_mutex.
+ * not call cpu_hotplug_disable() while holding callback_mutex.
  */
 
 static void update_cpu_domains(struct cpuset *cur)
@@ -802,9 +802,9 @@ static void update_cpu_domains(struct cp
 		}
 	}
 
-	lock_cpu_hotplug();
+	cpu_hotplug_disable();
 	partition_sched_domains(&pspan, &cspan);
-	unlock_cpu_hotplug();
+	cpu_hotplug_enable();
 }
 
 /*
@@ -1924,9 +1924,9 @@ static int cpuset_mkdir(struct inode *di
  *
  * If the cpuset being removed is marked cpu_exclusive, then simulate
  * turning cpu_exclusive off, which will call update_cpu_domains().
- * The lock_cpu_hotplug() call in update_cpu_domains() must not be
+ * The cpu_hotplug_disable() call in update_cpu_domains() must not be
  * made while holding callback_mutex.  Elsewhere the kernel nests
- * callback_mutex inside lock_cpu_hotplug() calls.  So the reverse
+ * callback_mutex inside cpu_hotplug_disable() calls.  So the reverse
  * nesting would risk an ABBA deadlock.
  */
 
Index: current/kernel/workqueue.c
===================================================================
--- current.orig/kernel/workqueue.c	2006-08-24 15:00:02.000000000 +0530
+++ current/kernel/workqueue.c	2006-08-24 15:01:45.000000000 +0530
@@ -320,10 +320,10 @@ void fastcall flush_workqueue(struct wor
 	} else {
 		int cpu;
 
-		lock_cpu_hotplug();
+		cpu_hotplug_disable();
 		for_each_online_cpu(cpu)
 			flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, cpu));
-		unlock_cpu_hotplug();
+		cpu_hotplug_enable();
 	}
 }
 EXPORT_SYMBOL_GPL(flush_workqueue);
@@ -372,7 +372,7 @@ struct workqueue_struct *__create_workqu
 
 	wq->name = name;
 	/* We don't need the distraction of CPUs appearing and vanishing. */
-	lock_cpu_hotplug();
+	cpu_hotplug_disable();
 	if (singlethread) {
 		INIT_LIST_HEAD(&wq->list);
 		p = create_workqueue_thread(wq, singlethread_cpu);
@@ -393,7 +393,7 @@ struct workqueue_struct *__create_workqu
 				destroy = 1;
 		}
 	}
-	unlock_cpu_hotplug();
+	cpu_hotplug_enable();
 
 	/*
 	 * Was there any error during startup? If yes then clean up:
@@ -434,7 +434,7 @@ void destroy_workqueue(struct workqueue_
 	flush_workqueue(wq);
 
 	/* We don't need the distraction of CPUs appearing and vanishing. */
-	lock_cpu_hotplug();
+	cpu_hotplug_disable();
 	if (is_single_threaded(wq))
 		cleanup_workqueue_thread(wq, singlethread_cpu);
 	else {
@@ -444,7 +444,7 @@ void destroy_workqueue(struct workqueue_
 		list_del(&wq->list);
 		spin_unlock(&workqueue_lock);
 	}
-	unlock_cpu_hotplug();
+	cpu_hotplug_enable();
 	free_percpu(wq->cpu_wq);
 	kfree(wq);
 }
Index: current/kernel/cpu.c
===================================================================
--- current.orig/kernel/cpu.c	2006-08-24 15:00:04.000000000 +0530
+++ current/kernel/cpu.c	2006-08-24 15:00:27.000000000 +0530
@@ -88,10 +88,13 @@ static __cacheline_aligned_in_smp DECLAR
 *********************************************************************/
 #ifdef CONFIG_HOTPLUG_CPU
 
-/** lock_cpu_hotplug : Blocks iff
+/** cpu_hotplug_diable : Blocks iff
 	- Hotplug operation is underway.
+
+    Previously known *incorrectly* as lock_cpu_hotplug.
+    DO NOT call this from the hot-cpu callback callpath.
 */
-void lock_cpu_hotplug(void)
+void cpu_hotplug_disable(void)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	spin_lock(&cpu_hotplug.lock);
@@ -106,15 +109,18 @@ void lock_cpu_hotplug(void)
 	schedule();
 	remove_wait_queue(&read_queue, &wait);
 }
-EXPORT_SYMBOL_GPL(lock_cpu_hotplug);
+EXPORT_SYMBOL_GPL(cpu_hotplug_disable);
 
-/** unlock_cpu_hotplug:
+/** cpu_hotplug_enable:
 	- Decrements the reader_count.
 	- If no readers are holding reference AND there is a writer
 	waiting, we set the flag to HOTPLUG_ONGOING and wake up
 	one of the waiting writer.
+
+    Previously known *incorrectly* as unlock_cpu_hotplug
+    DO NOT call this from the hot-cpu callback callpath.
 */
-void unlock_cpu_hotplug(void)
+void cpu_hotplug_enable(void)
 {
 	spin_lock(&cpu_hotplug.lock);
 	/* This should not happen, but in case it does... */
@@ -128,7 +134,7 @@ void unlock_cpu_hotplug(void)
 	}
 	spin_unlock(&cpu_hotplug.lock);
 }
-EXPORT_SYMBOL_GPL(unlock_cpu_hotplug);
+EXPORT_SYMBOL_GPL(cpu_hotplug_enable);
 
 /** cpu_hotplug_begin : Blocks unless
 	No reader has the reference
Index: current/kernel/rcutorture.c
===================================================================
--- current.orig/kernel/rcutorture.c	2006-08-06 23:50:11.000000000 +0530
+++ current/kernel/rcutorture.c	2006-08-24 15:00:07.000000000 +0530
@@ -488,11 +488,11 @@ void rcu_torture_shuffle_tasks(void)
 	cpumask_t tmp_mask = CPU_MASK_ALL;
 	int i;
 
-	lock_cpu_hotplug();
+	cpu_hotplug_disable();
 
 	/* No point in shuffling if there is only one online CPU (ex: UP) */
 	if (num_online_cpus() == 1) {
-		unlock_cpu_hotplug();
+		cpu_hotplug_enable();
 		return;
 	}
 
@@ -518,7 +518,7 @@ void rcu_torture_shuffle_tasks(void)
 	else
 		rcu_idle_cpu--;
 
-	unlock_cpu_hotplug();
+	cpu_hotplug_enable();
 }
 
 /* Shuffle tasks across CPUs, with the intent of allowing each CPU in the
Index: current/kernel/sched.c
===================================================================
--- current.orig/kernel/sched.c	2006-08-06 23:50:11.000000000 +0530
+++ current/kernel/sched.c	2006-08-24 15:00:07.000000000 +0530
@@ -4268,13 +4268,13 @@ long sched_setaffinity(pid_t pid, cpumas
 	struct task_struct *p;
 	int retval;
 
-	lock_cpu_hotplug();
+	cpu_hotplug_disable();
 	read_lock(&tasklist_lock);
 
 	p = find_process_by_pid(pid);
 	if (!p) {
 		read_unlock(&tasklist_lock);
-		unlock_cpu_hotplug();
+		cpu_hotplug_enable();
 		return -ESRCH;
 	}
 
@@ -4301,7 +4301,7 @@ long sched_setaffinity(pid_t pid, cpumas
 
 out_unlock:
 	put_task_struct(p);
-	unlock_cpu_hotplug();
+	cpu_hotplug_enable();
 	return retval;
 }
 
@@ -4355,7 +4355,7 @@ long sched_getaffinity(pid_t pid, cpumas
 	struct task_struct *p;
 	int retval;
 
-	lock_cpu_hotplug();
+	cpu_hotplug_disable();
 	read_lock(&tasklist_lock);
 
 	retval = -ESRCH;
@@ -4371,7 +4371,7 @@ long sched_getaffinity(pid_t pid, cpumas
 
 out_unlock:
 	read_unlock(&tasklist_lock);
-	unlock_cpu_hotplug();
+	cpu_hotplug_enable();
 	if (retval)
 		return retval;
 
@@ -5208,7 +5208,7 @@ migration_call(struct notifier_block *nf
 		BUG_ON(rq->nr_running != 0);
 
 		/* No need to migrate the tasks: it was best-effort if
-		 * they didn't do lock_cpu_hotplug().  Just wake up
+		 * they didn't do cpu_hotplug_disable().  Just wake up
 		 * the requestors. */
 		spin_lock_irq(&rq->lock);
 		while (!list_empty(&rq->migration_queue)) {
@@ -6596,10 +6596,10 @@ int arch_reinit_sched_domains(void)
 {
 	int err;
 
-	lock_cpu_hotplug();
+	cpu_hotplug_disable();
 	detach_destroy_domains(&cpu_online_map);
 	err = arch_init_sched_domains(&cpu_online_map);
-	unlock_cpu_hotplug();
+	cpu_hotplug_enable();
 
 	return err;
 }
@@ -6705,9 +6705,9 @@ static int update_sched_domains(struct n
 
 void __init sched_init_smp(void)
 {
-	lock_cpu_hotplug();
+	cpu_hotplug_disable();
 	arch_init_sched_domains(&cpu_online_map);
-	unlock_cpu_hotplug();
+	cpu_hotplug_enable();
 	/* XXX: Theoretical race here - CPU may be hotplugged now */
 	hotcpu_notifier(update_sched_domains, 0);
 }
Index: current/mm/slab.c
===================================================================
--- current.orig/mm/slab.c	2006-08-06 23:50:11.000000000 +0530
+++ current/mm/slab.c	2006-08-24 15:00:07.000000000 +0530
@@ -2008,9 +2008,9 @@ kmem_cache_create (const char *name, siz
 
 	/*
 	 * Prevent CPUs from coming and going.
-	 * lock_cpu_hotplug() nests outside cache_chain_mutex
+	 * cpu_hotplug_disable() nests outside cache_chain_mutex
 	 */
-	lock_cpu_hotplug();
+	cpu_hotplug_disable();
 
 	mutex_lock(&cache_chain_mutex);
 
@@ -2216,7 +2216,7 @@ oops:
 		panic("kmem_cache_create(): failed to create slab `%s'\n",
 		      name);
 	mutex_unlock(&cache_chain_mutex);
-	unlock_cpu_hotplug();
+	cpu_hotplug_enable();
 	return cachep;
 }
 EXPORT_SYMBOL(kmem_cache_create);
@@ -2395,7 +2395,7 @@ int kmem_cache_destroy(struct kmem_cache
 	BUG_ON(!cachep || in_interrupt());
 
 	/* Don't let CPUs to come and go */
-	lock_cpu_hotplug();
+	cpu_hotplug_disable();
 
 	/* Find the cache in the chain of caches. */
 	mutex_lock(&cache_chain_mutex);
@@ -2410,7 +2410,7 @@ int kmem_cache_destroy(struct kmem_cache
 		mutex_lock(&cache_chain_mutex);
 		list_add(&cachep->next, &cache_chain);
 		mutex_unlock(&cache_chain_mutex);
-		unlock_cpu_hotplug();
+		cpu_hotplug_enable();
 		return 1;
 	}
 
@@ -2430,7 +2430,7 @@ int kmem_cache_destroy(struct kmem_cache
 		}
 	}
 	kmem_cache_free(&cache_cache, cachep);
-	unlock_cpu_hotplug();
+	cpu_hotplug_enable();
 	return 0;
 }
 EXPORT_SYMBOL(kmem_cache_destroy);

--rz+pwK2yUstbofK6--
