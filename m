Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266810AbUHZIBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266810AbUHZIBe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 04:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266813AbUHZIBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 04:01:34 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:60142 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S266810AbUHZIB2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 04:01:28 -0400
Subject: [PATCH 1/2] Neaten migrate_all_tasks
From: Rusty Russell <rusty@rustcorp.com.au>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
In-Reply-To: <1093475339.7056.6.camel@pants.austin.ibm.com>
References: <20040822013402.5917b991.akpm@osdl.org>
	 <1093299523.5284.70.camel@pants.austin.ibm.com>
	 <1093475339.7056.6.camel@pants.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1093507039.13516.2508.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 26 Aug 2004 17:57:19 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: Neaten migrate_all_tasks
Status: Tested on 2.6.8.1-mm4
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Version: -mm

A followup patch wants to do forced migration, so separate that part
of the code out of migrate_all_tasks().

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13565-linux-2.6.8.1-mm4/kernel/sched.c .13565-linux-2.6.8.1-mm4.updated/kernel/sched.c
--- .13565-linux-2.6.8.1-mm4/kernel/sched.c	2004-08-23 10:11:51.000000000 +1000
+++ .13565-linux-2.6.8.1-mm4.updated/kernel/sched.c	2004-08-26 16:58:45.000000000 +1000
@@ -3784,52 +3784,55 @@ wait_to_die:
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
+/* Figure out where task on dead CPU should go, use force if neccessary. */
+static void move_task_off_dead_cpu(int dead_cpu, struct task_struct *tsk)
+{
+	int dest_cpu;
+	cpumask_t mask = node_to_cpumask(cpu_to_node(dead_cpu));
+
+	/* On same node? */
+	mask = node_to_cpumask(node);
+	cpus_and(mask, mask, tsk->cpus_allowed);
+	dest_cpu = any_online_cpu(mask);
+
+	/* On any allowed CPU? */
+	if (dest_cpu == NR_CPUS)
+		dest_cpu = any_online_cpu(tsk->cpus_allowed);
+
+	/* No more Mr. Nice Guy. */
+	if (dest_cpu == NR_CPUS) {
+		/* Anything online CPU set?  If not, allow on anything. */
+		tsk->cpus_allowed = cpuset_cpus_allowed(tsk);
+		if (!cpus_intersects(tsk->cpus_allowed, cpu_online_map))
+			cpus_setall(tsk->cpus_allowed);
+		dest_cpu = any_online_cpu(tsk->cpus_allowed);
+
+		/* 
+		 * Don't tell them about moving exiting tasks or
+		 * kernel threads (both mm NULL), since they never
+		 * leave kernel.
+		 */
+		if (tsk->mm && printk_ratelimit())
+			printk(KERN_INFO "process %d (%s) no "
+			       "longer affine to cpu%d\n",
+			       tsk->pid, tsk->comm, task_cpu(tsk));
+	}
+	__migrate_task(tsk, dead_cpu, dest_cpu);
+}
+
 /* migrate_all_tasks - function to migrate all tasks from the dead cpu. */
 static void migrate_all_tasks(int src_cpu)
 {
 	struct task_struct *tsk, *t;
-	int dest_cpu;
-	unsigned int node;
 
 	write_lock_irq(&tasklist_lock);
 
-	/* watch out for per node tasks, let's stay on this node */
-	node = cpu_to_node(src_cpu);
-
 	do_each_thread(t, tsk) {
-		cpumask_t mask;
 		if (tsk == current)
 			continue;
 
-		if (task_cpu(tsk) != src_cpu)
-			continue;
-
-		/* Figure out where this task should go (attempting to
-		 * keep it on-node), and check if it can be migrated
-		 * as-is.  NOTE that kernel threads bound to more than
-		 * one online cpu will be migrated. */
-		mask = node_to_cpumask(node);
-		cpus_and(mask, mask, tsk->cpus_allowed);
-		dest_cpu = any_online_cpu(mask);
-		if (dest_cpu == NR_CPUS)
-			dest_cpu = any_online_cpu(tsk->cpus_allowed);
-		if (dest_cpu == NR_CPUS) {
-			tsk->cpus_allowed = cpuset_cpus_allowed(tsk);
-			if (!cpus_intersects(tsk->cpus_allowed, cpu_online_map))
-				cpus_setall(tsk->cpus_allowed);
-			dest_cpu = any_online_cpu(tsk->cpus_allowed);
-
-			/*
-			 * Don't tell them about moving exiting tasks
-			 * or kernel threads (both mm NULL), since
-			 * they never leave kernel.
-			 */
-			if (tsk->mm && printk_ratelimit())
-				printk(KERN_INFO "process %d (%s) no "
-				       "longer affine to cpu%d\n",
-				       tsk->pid, tsk->comm, src_cpu);
-		}
-		__migrate_task(tsk, src_cpu, dest_cpu);
+		if (task_cpu(tsk) == src_cpu)
+			move_task_off_dead_cpu(src_cpu, tsk);
 	} while_each_thread(t, tsk);
 
 	write_unlock_irq(&tasklist_lock);


-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

