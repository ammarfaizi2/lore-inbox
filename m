Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbTCZF7z>; Wed, 26 Mar 2003 00:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261363AbTCZF7z>; Wed, 26 Mar 2003 00:59:55 -0500
Received: from rj.SGI.COM ([192.82.208.96]:45461 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S261353AbTCZF7p>;
	Wed, 26 Mar 2003 00:59:45 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.21-pre5 correct scheduling of idle tasks [ all arch ]
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 26 Mar 2003 17:10:43 +1100
Message-ID: <31961.1048659043@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are several inconsistencies in the scheduling of idle tasks and,
for UP, tracking which task is on the cpu.  This patch standardizes
idle task scheduling across all architectures and corrects the UP
error, it is just a bug fix.

For each task, the cpus_runnable, cpus_allowed and processor fields
should be set.  They are set correctly for normal tasks, but not for
the idle tasks.  Each architecture manually sets these fields as each
idle task is created, but no architecture gets it exactly right.
x86_64 comes close but it is using 1<<cpu instead of 1UL<<cpu so will
break past 32 cpus.

To make it worse, on UP a task is assigned to a cpu but never released.
Very quickly, all tasks are marked as currently running on cpu 0 :(.

Add inline function task_set_cpu_only() to set cpus_runnable,
cpus_allowed and processor.  Call that function from every arch setup
of the idle task, plus from start_kernel for the boot idle task.
Release the cpu in the UP case.

Tested on i386 2.4.21-pre5 and ia64 2.4.20.  Eyeballed for other
architectures but not compiled, please verify.

diff -ur 2.4.20-pristine/arch/alpha/kernel/smp.c 2.4.20-sched/arch/alpha/kernel/smp.c
--- 2.4.20-pristine/arch/alpha/kernel/smp.c	Sat Aug  3 11:07:43 2002
+++ 2.4.20-sched/arch/alpha/kernel/smp.c	Wed Mar 26 16:16:21 2003
@@ -505,8 +505,7 @@
 	if (idle == &init_task)
 		panic("idle process is init_task for CPU %d", cpuid);
 
-	idle->processor = cpuid;
-	idle->cpus_runnable = 1 << cpuid; /* we schedule the first task manually */
+	task_set_cpu_only(idle, cpuid);	/* we schedule the first task manually */
 	__cpu_logical_map[cpunum] = cpuid;
 	__cpu_number_map[cpuid] = cpunum;
  
diff -ur 2.4.20-pristine/arch/i386/kernel/smpboot.c 2.4.20-sched/arch/i386/kernel/smpboot.c
--- 2.4.20-pristine/arch/i386/kernel/smpboot.c	Fri Nov 29 11:38:59 2002
+++ 2.4.20-sched/arch/i386/kernel/smpboot.c	Wed Mar 26 16:22:49 2003
@@ -803,8 +803,7 @@
 	if (!idle)
 		panic("No idle process for CPU %d", cpu);
 
-	idle->processor = cpu;
-	idle->cpus_runnable = 1 << cpu; /* we schedule the first task manually */
+	task_set_cpu_only(idle, cpu);	/* we schedule the first task manually */
 
 	map_cpu_to_boot_apicid(cpu, apicid);
 
diff -ur 2.4.20-pristine/arch/ia64/kernel/smpboot.c 2.4.20-sched/arch/ia64/kernel/smpboot.c
--- 2.4.20-pristine/arch/ia64/kernel/smpboot.c	Fri Nov 29 11:39:02 2002
+++ 2.4.20-sched/arch/ia64/kernel/smpboot.c	Wed Mar 26 16:14:40 2003
@@ -422,7 +422,7 @@
 	if (!idle)
 		panic("No idle process for CPU %d", cpu);
 
-	task_set_cpu(idle, cpu);	/* we schedule the first task manually */
+	task_set_cpu_only(idle, cpu);	/* we schedule the first task manually */
 
 	ia64_cpu_to_sapicid[cpu] = sapicid;
 
diff -ur 2.4.20-pristine/arch/mips/sgi-ip27/ip27-init.c 2.4.20-sched/arch/mips/sgi-ip27/ip27-init.c
--- 2.4.20-pristine/arch/mips/sgi-ip27/ip27-init.c	Fri Nov 29 11:39:17 2002
+++ 2.4.20-sched/arch/mips/sgi-ip27/ip27-init.c	Wed Mar 26 16:17:36 2003
@@ -479,8 +479,7 @@
 			init_tasks[num_cpus] = p;
 			alloc_cpupda(cpu, num_cpus);
 			del_from_runqueue(p);
-			p->processor = num_cpus;
-			p->cpus_runnable = 1 << num_cpus; /* we schedule the first task manually */
+			task_set_cpu_only(p, num_cpus);	/* we schedule the first task manually */
 			unhash_process(p);
 			/* Attach to the address space of init_task. */
 			atomic_inc(&init_mm.mm_count);
diff -ur 2.4.20-pristine/arch/mips/sibyte/sb1250/smp.c 2.4.20-sched/arch/mips/sibyte/sb1250/smp.c
--- 2.4.20-pristine/arch/mips/sibyte/sb1250/smp.c	Fri Nov 29 11:39:18 2002
+++ 2.4.20-sched/arch/mips/sibyte/sb1250/smp.c	Wed Mar 26 16:18:20 2003
@@ -124,9 +124,7 @@
 		do_fork(CLONE_VM|CLONE_PID, 0, &regs, 0);
 		p = init_task.prev_task;
 
-		/* Schedule the first task manually */
-		p->processor = i;
-		p->cpus_runnable = 1 << i; /* we schedule the first task manually */
+		task_set_cpu_only(p, i);	/* we schedule the first task manually */
 
 		/* Attach to the address space of init_task. */
 		atomic_inc(&init_mm.mm_count);
diff -ur 2.4.20-pristine/arch/parisc/kernel/smp.c 2.4.20-sched/arch/parisc/kernel/smp.c
--- 2.4.20-pristine/arch/parisc/kernel/smp.c	Fri Nov 29 11:39:25 2002
+++ 2.4.20-sched/arch/parisc/kernel/smp.c	Wed Mar 26 16:14:40 2003
@@ -542,7 +542,7 @@
 	if (!idle)
 		panic("SMP: No idle process for CPU:%d", cpuid);
 
-	task_set_cpu(idle, cpunum);	/* manually schedule idle task */
+	task_set_cpu_only(idle, cpunum);	/* manually schedule idle task */
 	del_from_runqueue(idle);
 	unhash_process(idle);
 	init_tasks[cpunum] = idle;
diff -ur 2.4.20-pristine/arch/ppc/kernel/smp.c 2.4.20-sched/arch/ppc/kernel/smp.c
--- 2.4.20-pristine/arch/ppc/kernel/smp.c	Sat Aug  3 11:07:46 2002
+++ 2.4.20-sched/arch/ppc/kernel/smp.c	Wed Mar 26 16:19:16 2003
@@ -352,8 +352,7 @@
 		unhash_process(p);
 		init_tasks[i] = p;
 
-		p->processor = i;
-		p->cpus_runnable = 1 << i; /* we schedule the first task manually */
+		task_set_cpu_only(p, i);	/* we schedule the first task manually */
 		current_set[i] = p;
 
 		/*
diff -ur 2.4.20-pristine/arch/ppc64/kernel/smp.c 2.4.20-sched/arch/ppc64/kernel/smp.c
--- 2.4.20-pristine/arch/ppc64/kernel/smp.c	Fri Nov 29 11:39:35 2002
+++ 2.4.20-sched/arch/ppc64/kernel/smp.c	Wed Mar 26 16:14:40 2003
@@ -688,8 +688,7 @@
 		unhash_process(p);
 		init_tasks[i] = p;
 
-		p->processor = i;
-		p->cpus_runnable = 1 << i; /* we schedule the first task manually */
+		task_set_cpu_only(p, i);	/* we schedule the first task manually */
 		current_set[i].task = p;
 		sp = ((unsigned long)p) + sizeof(union task_union)
 			- STACK_FRAME_OVERHEAD;
diff -ur 2.4.20-pristine/arch/s390/kernel/smp.c 2.4.20-sched/arch/s390/kernel/smp.c
--- 2.4.20-pristine/arch/s390/kernel/smp.c	Fri Nov 29 11:39:36 2002
+++ 2.4.20-sched/arch/s390/kernel/smp.c	Wed Mar 26 16:14:40 2003
@@ -547,8 +547,7 @@
         idle = init_task.prev_task;
         if (!idle)
                 panic("No idle process for CPU %d",cpu);
-        idle->processor = cpu;
-	idle->cpus_runnable = 1 << cpu; /* we schedule the first task manually */
+	task_set_cpu_only(idle, cpu);	/* we schedule the first task manually */
 
         del_from_runqueue(idle);
         unhash_process(idle);
diff -ur 2.4.20-pristine/arch/s390x/kernel/smp.c 2.4.20-sched/arch/s390x/kernel/smp.c
--- 2.4.20-pristine/arch/s390x/kernel/smp.c	Fri Nov 29 11:39:37 2002
+++ 2.4.20-sched/arch/s390x/kernel/smp.c	Wed Mar 26 16:14:40 2003
@@ -533,8 +533,7 @@
         idle = init_task.prev_task;
         if (!idle)
                 panic("No idle process for CPU %d",cpu);
-        idle->processor = cpu;
-	idle->cpus_runnable = 1 << cpu; /* we schedule the first task manually */
+	task_set_cpu_only(idle, cpu);	/* we schedule the first task manually */
 
         del_from_runqueue(idle);
         unhash_process(idle);
diff -ur 2.4.20-pristine/arch/sparc/kernel/sun4d_smp.c 2.4.20-sched/arch/sparc/kernel/sun4d_smp.c
--- 2.4.20-pristine/arch/sparc/kernel/sun4d_smp.c	Sat Aug  3 11:07:47 2002
+++ 2.4.20-sched/arch/sparc/kernel/sun4d_smp.c	Wed Mar 26 16:19:33 2003
@@ -224,8 +224,7 @@
 			p = init_task.prev_task;
 			init_tasks[i] = p;
 
-			p->processor = i;
-			p->cpus_runnable = 1 << i; /* we schedule the first task manually */
+			task_set_cpu_only(p, i);	/* we schedule the first task manually */
 
 			current_set[i] = p;
 
diff -ur 2.4.20-pristine/arch/sparc/kernel/sun4m_smp.c 2.4.20-sched/arch/sparc/kernel/sun4m_smp.c
--- 2.4.20-pristine/arch/sparc/kernel/sun4m_smp.c	Fri Nov 23 11:58:49 2001
+++ 2.4.20-sched/arch/sparc/kernel/sun4m_smp.c	Wed Mar 26 16:19:58 2003
@@ -197,8 +197,7 @@
 			p = init_task.prev_task;
 			init_tasks[i] = p;
 
-			p->processor = i;
-			p->cpus_runnable = 1 << i; /* we schedule the first task manually */
+			task_set_cpu_only(p, i);	/* we schedule the first task manually */
 
 			current_set[i] = p;
 
diff -ur 2.4.20-pristine/arch/sparc64/kernel/smp.c 2.4.20-sched/arch/sparc64/kernel/smp.c
--- 2.4.20-pristine/arch/sparc64/kernel/smp.c	Fri Nov 29 11:39:39 2002
+++ 2.4.20-sched/arch/sparc64/kernel/smp.c	Wed Mar 26 16:21:15 2003
@@ -284,8 +284,7 @@
 			p = init_task.prev_task;
 			init_tasks[cpucount] = p;
 
-			p->processor = i;
-			p->cpus_runnable = 1UL << i; /* we schedule the first task manually */
+			task_set_cpu_only(p, i);	/* we schedule the first task manually */
 
 			del_from_runqueue(p);
 			unhash_process(p);
diff -ur 2.4.20-pristine/arch/x86_64/kernel/smpboot.c 2.4.20-sched/arch/x86_64/kernel/smpboot.c
--- 2.4.20-pristine/arch/x86_64/kernel/smpboot.c	Fri Nov 29 11:39:41 2002
+++ 2.4.20-sched/arch/x86_64/kernel/smpboot.c	Wed Mar 26 16:14:40 2003
@@ -540,11 +540,9 @@
 	if (!idle)
 		panic("No idle process for CPU %d", cpu);
 
-	idle->processor = cpu;
 	x86_cpu_to_apicid[cpu] = apicid;
 	x86_apicid_to_cpu[apicid] = cpu;
-	idle->cpus_runnable = 1<<cpu; 
-	idle->cpus_allowed = 1<<cpu;
+	task_set_cpu_only(idle, cpu);	/* we schedule the first task manually */
 	idle->thread.rip = (unsigned long)start_secondary;
 	idle->thread.rsp = (unsigned long)idle + THREAD_SIZE - 8;
 
diff -ur 2.4.20-pristine/include/linux/sched.h 2.4.20-sched/include/linux/sched.h
--- 2.4.20-pristine/include/linux/sched.h	Mon Mar 17 15:35:32 2003
+++ 2.4.20-sched/include/linux/sched.h	Wed Mar 26 16:14:40 2003
@@ -568,6 +568,12 @@
 	tsk->cpus_runnable = 1UL << cpu;
 }
 
+static inline void task_set_cpu_only(struct task_struct *tsk, unsigned int cpu)
+{
+	task_set_cpu(tsk, cpu);
+	tsk->cpus_allowed = 1UL << cpu;
+}
+
 static inline void task_release_cpu(struct task_struct *tsk)
 {
 	tsk->cpus_runnable = ~0UL;
diff -ur 2.4.20-pristine/init/main.c 2.4.20-sched/init/main.c
--- 2.4.20-pristine/init/main.c	Wed May 29 14:00:22 2002
+++ 2.4.20-sched/init/main.c	Wed Mar 26 16:30:23 2003
@@ -354,6 +354,7 @@
  * enable them
  */
 	lock_kernel();
+	task_set_cpu_only(current, 0);
 	printk(linux_banner);
 	setup_arch(&command_line);
 	printk("Kernel command line: %s\n", saved_command_line);
diff -ur 2.4.20-pristine/kernel/sched.c 2.4.20-sched/kernel/sched.c
--- 2.4.20-pristine/kernel/sched.c	Fri Aug 30 13:51:40 2002
+++ 2.4.20-sched/kernel/sched.c	Wed Mar 26 16:27:35 2003
@@ -525,6 +525,7 @@
 		goto out_unlock;
 	}
 #else
+	task_release_cpu(prev);
 	prev->policy &= ~SCHED_YIELD;
 #endif /* CONFIG_SMP */
 }

