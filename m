Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965334AbWKNMXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965334AbWKNMXQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 07:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965335AbWKNMXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 07:23:16 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:49882 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP id S965334AbWKNMXP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 07:23:15 -0500
Date: Tue, 14 Nov 2006 17:53:25 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Gautham R Shenoy <ego@in.ibm.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       vatsa@in.ibm.com, dipankar@in.ibm.com, davej@redhat.com, mingo@elte.hu,
       kiran@scalex86.org
Subject: [PATCH 3/4] Eliminate lock_cpu_hotplug in kernel/sched.c
Message-ID: <20061114122325.GD31787@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061114121832.GA31787@in.ibm.com> <20061114122050.GB31787@in.ibm.com> <20061114122214.GC31787@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114122214.GC31787@in.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate lock_cpu_hotplug from kernel/sched.c and use sched_hotcpu_mutex
instead to postpone a hotplug event. 

In the migration_call hotcpu callback function, take sched_hotcpu_mutex
while handling the event CPU_LOCK_ACQUIRE and release it while handling
CPU_LOCK_RELEASE event.

Signed-off-by: Gautham R Shenoy <ego@in.ibm.com>

--
 kernel/sched.c |   29 +++++++++++++++++++----------
 1 files changed, 19 insertions(+), 10 deletions(-)

Index: hotplug/kernel/sched.c
===================================================================
--- hotplug.orig/kernel/sched.c
+++ hotplug/kernel/sched.c
@@ -267,6 +267,7 @@ struct rq {
 };
 
 static DEFINE_PER_CPU(struct rq, runqueues);
+static DEFINE_MUTEX(sched_hotcpu_mutex);
 
 static inline int cpu_of(struct rq *rq)
 {
@@ -4327,13 +4328,13 @@ long sched_setaffinity(pid_t pid, cpumas
 	struct task_struct *p;
 	int retval;
 
-	lock_cpu_hotplug();
+	mutex_lock(&sched_hotcpu_mutex);
 	read_lock(&tasklist_lock);
 
 	p = find_process_by_pid(pid);
 	if (!p) {
 		read_unlock(&tasklist_lock);
-		unlock_cpu_hotplug();
+		mutex_unlock(&sched_hotcpu_mutex);
 		return -ESRCH;
 	}
 
@@ -4360,7 +4361,7 @@ long sched_setaffinity(pid_t pid, cpumas
 
 out_unlock:
 	put_task_struct(p);
-	unlock_cpu_hotplug();
+	mutex_unlock(&sched_hotcpu_mutex);
 	return retval;
 }
 
@@ -4417,7 +4418,7 @@ long sched_getaffinity(pid_t pid, cpumas
 	struct task_struct *p;
 	int retval;
 
-	lock_cpu_hotplug();
+	mutex_lock(&sched_hotcpu_mutex);
 	read_lock(&tasklist_lock);
 
 	retval = -ESRCH;
@@ -4433,7 +4434,7 @@ long sched_getaffinity(pid_t pid, cpumas
 
 out_unlock:
 	read_unlock(&tasklist_lock);
-	unlock_cpu_hotplug();
+	mutex_unlock(&sched_hotcpu_mutex);
 	if (retval)
 		return retval;
 
@@ -5225,6 +5226,10 @@ migration_call(struct notifier_block *nf
 	struct rq *rq;
 
 	switch (action) {
+	case CPU_LOCK_ACQUIRE:
+		mutex_lock(&sched_hotcpu_mutex);
+		break;
+
 	case CPU_UP_PREPARE:
 		p = kthread_create(migration_thread, hcpu, "migration/%d",cpu);
 		if (IS_ERR(p))
@@ -5270,7 +5275,7 @@ migration_call(struct notifier_block *nf
 		BUG_ON(rq->nr_running != 0);
 
 		/* No need to migrate the tasks: it was best-effort if
-		 * they didn't do lock_cpu_hotplug().  Just wake up
+		 * they didn't take sched_hotcpu_mutex.  Just wake up
 		 * the requestors. */
 		spin_lock_irq(&rq->lock);
 		while (!list_empty(&rq->migration_queue)) {
@@ -5283,6 +5288,10 @@ migration_call(struct notifier_block *nf
 		}
 		spin_unlock_irq(&rq->lock);
 		break;
+
+	case CPU_LOCK_RELEASE:
+		mutex_unlock(&sched_hotcpu_mutex);
+		break;
 #endif
 	}
 	return NOTIFY_OK;
@@ -6652,10 +6661,10 @@ int arch_reinit_sched_domains(void)
 {
 	int err;
 
-	lock_cpu_hotplug();
+	mutex_lock(&sched_hotcpu_mutex);
 	detach_destroy_domains(&cpu_online_map);
 	err = arch_init_sched_domains(&cpu_online_map);
-	unlock_cpu_hotplug();
+	mutex_unlock(&sched_hotcpu_mutex);
 
 	return err;
 }
@@ -6763,12 +6772,12 @@ void __init sched_init_smp(void)
 {
 	cpumask_t non_isolated_cpus;
 
-	lock_cpu_hotplug();
+	mutex_lock(&sched_hotcpu_mutex);
 	arch_init_sched_domains(&cpu_online_map);
 	cpus_andnot(non_isolated_cpus, cpu_online_map, cpu_isolated_map);
 	if (cpus_empty(non_isolated_cpus))
 		cpu_set(smp_processor_id(), non_isolated_cpus);
-	unlock_cpu_hotplug();
+	mutex_unlock(&sched_hotcpu_mutex);
 	/* XXX: Theoretical race here - CPU may be hotplugged now */
 	hotcpu_notifier(update_sched_domains, 0);
 
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
