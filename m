Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVASVlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVASVlx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 16:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVASVlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 16:41:53 -0500
Received: from natpreptil.rzone.de ([81.169.145.163]:2440 "EHLO
	natpreptil.rzone.de") by vger.kernel.org with ESMTP id S261912AbVASViP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 16:38:15 -0500
Date: Wed, 19 Jan 2005 22:38:58 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: dhowells@redhat.com, linux-kernel@vger.kernel.org, anton@au.ibm.com,
       mingo@redhat.com
Subject: [RFC][PATCH 4/4] use disable_cpu_hotplug() instead of lock_cpu_hotplug() where appropriate
Message-ID: <20050119213858.GE8471@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	dhowells@redhat.com, linux-kernel@vger.kernel.org, anton@au.ibm.com,
	mingo@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use {dis,en}able_cpu_hotplug() instead of {un,}lock_cpu_hotplug() in
obvious(?) places which don't need serialization (or provide it on their
own) and don't need to be serialized against each other (like ppc64's rtasd
and cpufreq).

Signed-off-by: Dominik Brodowski <linux@brodo.de>
---

 arch/ppc64/kernel/rtasd.c |   10 +++++-----
 drivers/cpufreq/cpufreq.c |    4 ++--
 kernel/sched.c            |   14 +++++++-------
 kernel/stop_machine.c     |    4 ++--
 net/core/flow.c           |    4 ++--
 5 files changed, 18 insertions(+), 18 deletions(-)

Index: 2.6.11-rc1+/arch/ppc64/kernel/rtasd.c
===================================================================
--- 2.6.11-rc1+.orig/arch/ppc64/kernel/rtasd.c	2005-01-16 23:15:25.000000000 +0100
+++ 2.6.11-rc1+/arch/ppc64/kernel/rtasd.c	2005-01-18 19:54:21.000000000 +0100
@@ -437,7 +437,7 @@
 	}
 
 	/* First pass. */
-	lock_cpu_hotplug();
+	disable_cpu_hotplug();
 	for_each_online_cpu(cpu) {
 		DEBUG("scheduling on %d\n", cpu);
 		set_cpus_allowed(current, cpumask_of_cpu(cpu));
@@ -447,7 +447,7 @@
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(HZ);
 	}
-	unlock_cpu_hotplug();
+	enable_cpu_hotplug();
 
 	if (surveillance_timeout != -1) {
 		DEBUG("enabling surveillance\n");
@@ -455,7 +455,7 @@
 		DEBUG("surveillance enabled\n");
 	}
 
-	lock_cpu_hotplug();
+	disable_cpu_hotplug();
 	cpu = first_cpu(cpu_online_map);
 	for (;;) {
 		set_cpus_allowed(current, cpumask_of_cpu(cpu));
@@ -465,10 +465,10 @@
 		/* Drop hotplug lock, and sleep for a bit (at least
 		 * one second since some machines have problems if we
 		 * call event-scan too quickly). */
-		unlock_cpu_hotplug();
+		enable_cpu_hotplug();
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout((HZ*60/rtas_event_scan_rate) / 2);
-		lock_cpu_hotplug();
+		disable_cpu_hotplug();
 
 		cpu = next_cpu(cpu, cpu_online_map);
 		if (cpu == NR_CPUS)
Index: 2.6.11-rc1+/drivers/cpufreq/cpufreq.c
===================================================================
--- 2.6.11-rc1+.orig/drivers/cpufreq/cpufreq.c	2005-01-16 23:23:11.000000000 +0100
+++ 2.6.11-rc1+/drivers/cpufreq/cpufreq.c	2005-01-18 19:53:13.000000000 +0100
@@ -1027,12 +1027,12 @@
 			    unsigned int relation)
 {
 	int retval = -EINVAL;
-	lock_cpu_hotplug();
+	disable_cpu_hotplug();
 	dprintk("target for CPU %u: %u kHz, relation %u\n", policy->cpu,
 		target_freq, relation);
 	if (cpu_online(policy->cpu) && cpufreq_driver->target)
 		retval = cpufreq_driver->target(policy, target_freq, relation);
-	unlock_cpu_hotplug();
+	enable_cpu_hotplug();
 	return retval;
 }
 EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
Index: 2.6.11-rc1+/kernel/sched.c
===================================================================
--- 2.6.11-rc1+.orig/kernel/sched.c	2005-01-16 23:23:12.000000000 +0100
+++ 2.6.11-rc1+/kernel/sched.c	2005-01-18 19:56:59.000000000 +0100
@@ -3422,13 +3422,13 @@
 	task_t *p;
 	int retval;
 
-	lock_cpu_hotplug();
+	disable_cpu_hotplug();
 	read_lock(&tasklist_lock);
 
 	p = find_process_by_pid(pid);
 	if (!p) {
 		read_unlock(&tasklist_lock);
-		unlock_cpu_hotplug();
+		enable_cpu_hotplug();
 		return -ESRCH;
 	}
 
@@ -3449,7 +3449,7 @@
 
 out_unlock:
 	put_task_struct(p);
-	unlock_cpu_hotplug();
+	enable_cpu_hotplug();
 	return retval;
 }
 
@@ -3503,7 +3503,7 @@
 	int retval;
 	task_t *p;
 
-	lock_cpu_hotplug();
+	disable_cpu_hotplug();
 	read_lock(&tasklist_lock);
 
 	retval = -ESRCH;
@@ -3516,7 +3516,7 @@
 
 out_unlock:
 	read_unlock(&tasklist_lock);
-	unlock_cpu_hotplug();
+	enable_cpu_hotplug();
 	if (retval)
 		return retval;
 
@@ -4309,8 +4309,8 @@
 		BUG_ON(rq->nr_running != 0);
 
 		/* No need to migrate the tasks: it was best-effort if
-		 * they didn't do lock_cpu_hotplug().  Just wake up
-		 * the requestors. */
+		 * they didn't do lock_cpu_hotplug() or disable_cpu_hotplug().
+		 *  Just wake up the requestors. */
 		spin_lock_irq(&rq->lock);
 		while (!list_empty(&rq->migration_queue)) {
 			migration_req_t *req;
Index: 2.6.11-rc1+/kernel/stop_machine.c
===================================================================
--- 2.6.11-rc1+.orig/kernel/stop_machine.c	2005-01-16 23:15:30.000000000 +0100
+++ 2.6.11-rc1+/kernel/stop_machine.c	2005-01-18 19:55:25.000000000 +0100
@@ -195,13 +195,13 @@
 	int ret;
 
 	/* No CPUs can come up or down during this. */
-	lock_cpu_hotplug();
+	disable_cpu_hotplug();
 	p = __stop_machine_run(fn, data, cpu);
 	if (!IS_ERR(p))
 		ret = kthread_stop(p);
 	else
 		ret = PTR_ERR(p);
-	unlock_cpu_hotplug();
+	enable_cpu_hotplug();
 
 	return ret;
 }
Index: 2.6.11-rc1+/net/core/flow.c
===================================================================
--- 2.6.11-rc1+.orig/net/core/flow.c	2004-04-04 14:14:00.000000000 +0200
+++ 2.6.11-rc1+/net/core/flow.c	2005-01-18 19:54:57.000000000 +0100
@@ -286,7 +286,7 @@
 	static DECLARE_MUTEX(flow_flush_sem);
 
 	/* Don't want cpus going down or up during this. */
-	lock_cpu_hotplug();
+	disable_cpu_hotplug();
 	down(&flow_flush_sem);
 	atomic_set(&info.cpuleft, num_online_cpus());
 	init_completion(&info.completion);
@@ -298,7 +298,7 @@
 
 	wait_for_completion(&info.completion);
 	up(&flow_flush_sem);
-	unlock_cpu_hotplug();
+	enable_cpu_hotplug();
 }
 
 static void __devinit flow_cache_cpu_prepare(int cpu)
