Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSGPJKk>; Tue, 16 Jul 2002 05:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293203AbSGPJKj>; Tue, 16 Jul 2002 05:10:39 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:54177 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S311885AbSGPJKh>;
	Tue, 16 Jul 2002 05:10:37 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] migrate_to_cpu helper.
Date: Tue, 16 Jul 2002 18:00:06 +1000
Message-Id: <20020716091406.012C342FF@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part I of II, weaning us off "cpu mask is always an unsigned long".

Name: migrate_to_cpu patch
Author: Rusty Russell
Status: Trivial

D: This patch adds an easy "migrate_to_cpu()" call for simple
D: in-kernel affinity, in preparation for generic cpu maps.

diff -urpN -I $.*$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.25.30418/Documentation/sched-coding.txt linux-2.5.25.30418.updated/Documentation/sched-coding.txt
--- linux-2.5.25.30418/Documentation/sched-coding.txt	Thu May 30 10:00:45 2002
+++ linux-2.5.25.30418.updated/Documentation/sched-coding.txt	Tue Jul 16 17:22:36 2002
@@ -103,7 +103,10 @@ void set_user_nice(task_t *p, long nice)
 	Sets the "nice" value of task p to the given value.
 int setscheduler(pid_t pid, int policy, struct sched_param *param)
 	Sets the scheduling policy and parameters for the given pid.
-void set_cpus_allowed(task_t *p, unsigned long new_mask)
+void migrate_to_cpu(unsigned int cpu)
+	Migrates the current task to the cpu and nails it there.  This
+	is a more convenient form of:
+void set_cpus_allowed(task_t *p, cpu_mask_t new_mask)
 	Sets a given task's CPU affinity and migrates it to a proper cpu.
 	Callers must have a valid reference to the task and assure the
 	task not exit prematurely.  No locks can be held during the call.
diff -urpN -I $.*$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.25.30418/include/linux/sched.h linux-2.5.25.30418.updated/include/linux/sched.h
--- linux-2.5.25.30418/include/linux/sched.h	Sun Jul  7 02:12:24 2002
+++ linux-2.5.25.30418.updated/include/linux/sched.h	Tue Jul 16 17:22:36 2002
@@ -408,8 +408,16 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 
 #if CONFIG_SMP
 extern void set_cpus_allowed(task_t *p, unsigned long new_mask);
+static inline void migrate_to_cpu(unsigned int cpu)
+{
+	unsigned long mask = 0;
+	BUG_ON(!cpu_online(cpu));
+	__set_bit(cpu, &mask);
+	set_cpus_allowed(current, mask);
+}
 #else
-# define set_cpus_allowed(p, new_mask) do { } while (0)
+#define set_cpus_allowed(p, new_mask) do { } while (0)
+#define migrate_to_cpu(cpu) do { BUG_ON((cpu) != 0); } while(0)
 #endif
 
 extern void set_user_nice(task_t *p, long nice);
diff -urpN -I $.*$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.25.30418/kernel/sched.c linux-2.5.25.30418.updated/kernel/sched.c
--- linux-2.5.25.30418/kernel/sched.c	Sun Jul  7 02:12:24 2002
+++ linux-2.5.25.30418.updated/kernel/sched.c	Tue Jul 16 17:22:52 2002
@@ -1807,7 +1807,7 @@ static int migration_thread(void * bind_
 	if (cpu != master_migration_thread) {
 		while (!cpu_rq(master_migration_thread)->migration_thread)
 			yield();
-		set_cpus_allowed(current, 1UL << cpu);
+		migrate_to_cpu(cpu);
 	}
 	printk("migration_task %d on cpu=%dn", cpu, smp_processor_id());
 	ret = setscheduler(0, SCHED_FIFO, &param);
@@ -1870,7 +1870,7 @@ void __init migration_init(void)
 	int cpu;
 
 	master_migration_thread = smp_processor_id();
-	current->cpus_allowed = 1UL << master_migration_thread;
+	migrate_to_cpu(master_migration_thread);
 	
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		if (!cpu_online(cpu))
diff -urpN -I $.*$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.25.30418/kernel/softirq.c linux-2.5.25.30418.updated/kernel/softirq.c
--- linux-2.5.25.30418/kernel/softirq.c	Sun Jul  7 02:12:24 2002
+++ linux-2.5.25.30418.updated/kernel/softirq.c	Tue Jul 16 17:22:36 2002
@@ -370,8 +370,7 @@ static int ksoftirqd(void * __bind_cpu)
 	current->flags |= PF_IOTHREAD;
 	sigfillset(&current->blocked);
 
-	/* Migrate to the right CPU */
-	set_cpus_allowed(current, 1UL << cpu);
+	migrate_to_cpu(cpu);
 	if (smp_processor_id() != cpu)
 		BUG();
 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
