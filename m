Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbWACVPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWACVPx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWACVPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:15:21 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:45711 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932557AbWACVHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:42 -0500
To: torvalds@osdl.org
Subject: [PATCH 39/50] powerpc: task_thread_info()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNb-0008Ri-5a@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/powerpc/kernel/process.c        |    4 ++--
 arch/powerpc/kernel/ptrace-common.h  |    4 ++--
 arch/powerpc/kernel/smp.c            |    6 +++---
 arch/powerpc/platforms/cell/smp.c    |    2 +-
 arch/powerpc/platforms/pseries/smp.c |    2 +-
 arch/ppc/kernel/process.c            |    2 +-
 arch/ppc/kernel/smp.c                |    4 ++--
 7 files changed, 12 insertions(+), 12 deletions(-)

a22cf75841f8ded0d85e8eae209dbdf138f67b3d
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 105d560..bc03526 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -424,7 +424,7 @@ void show_regs(struct pt_regs * regs)
 	if (trap == 0x300 || trap == 0x600)
 		printk("DAR: "REG", DSISR: "REG"\n", regs->dar, regs->dsisr);
 	printk("TASK = %p[%d] '%s' THREAD: %p",
-	       current, current->pid, current->comm, current->thread_info);
+	       current, current->pid, current->comm, task_thread_info(current));
 
 #ifdef CONFIG_SMP
 	printk(" CPU: %d", smp_processor_id());
@@ -516,7 +516,7 @@ int copy_thread(int nr, unsigned long cl
 #ifdef CONFIG_PPC32
 		childregs->gpr[2] = (unsigned long) p;
 #else
-		clear_ti_thread_flag(p->thread_info, TIF_32BIT);
+		clear_tsk_thread_flag(p, TIF_32BIT);
 #endif
 		p->thread.regs = NULL;	/* no user register state */
 	} else {
diff --git a/arch/powerpc/kernel/ptrace-common.h b/arch/powerpc/kernel/ptrace-common.h
index b1babb7..5ccbdbe 100644
--- a/arch/powerpc/kernel/ptrace-common.h
+++ b/arch/powerpc/kernel/ptrace-common.h
@@ -62,7 +62,7 @@ static inline void set_single_step(struc
 	struct pt_regs *regs = task->thread.regs;
 	if (regs != NULL)
 		regs->msr |= MSR_SE;
-	set_ti_thread_flag(task->thread_info, TIF_SINGLESTEP);
+	set_tsk_thread_flag(task, TIF_SINGLESTEP);
 }
 
 static inline void clear_single_step(struct task_struct *task)
@@ -70,7 +70,7 @@ static inline void clear_single_step(str
 	struct pt_regs *regs = task->thread.regs;
 	if (regs != NULL)
 		regs->msr &= ~MSR_SE;
-	clear_ti_thread_flag(task->thread_info, TIF_SINGLESTEP);
+	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
 }
 
 #ifdef CONFIG_ALTIVEC
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 30374d2..7082416 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -319,8 +319,8 @@ static void __init smp_create_idle(unsig
 #ifdef CONFIG_PPC64
 	paca[cpu].__current = p;
 #endif
-	current_set[cpu] = p->thread_info;
-	p->thread_info->cpu = cpu;
+	current_set[cpu] = task_thread_info(p);
+	task_thread_info(p)->cpu = cpu;
 }
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
@@ -356,7 +356,7 @@ void __devinit smp_prepare_boot_cpu(void
 #ifdef CONFIG_PPC64
 	paca[boot_cpuid].__current = current;
 #endif
-	current_set[boot_cpuid] = current->thread_info;
+	current_set[boot_cpuid] = task_thread_info(current);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/arch/powerpc/platforms/cell/smp.c b/arch/powerpc/platforms/cell/smp.c
index de96ead..bdf6c5f 100644
--- a/arch/powerpc/platforms/cell/smp.c
+++ b/arch/powerpc/platforms/cell/smp.c
@@ -86,7 +86,7 @@ static inline int __devinit smp_startup_
 	pcpu = get_hard_smp_processor_id(lcpu);
 
 	/* Fixup atomic count: it exited inside IRQ handler. */
-	paca[lcpu].__current->thread_info->preempt_count	= 0;
+	task_thread_info(paca[lcpu].__current)->preempt_count	= 0;
 
 	/*
 	 * If the RTAS start-cpu token does not exist then presume the
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index 25181c5..2f543ce 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -282,7 +282,7 @@ static inline int __devinit smp_startup_
 	pcpu = get_hard_smp_processor_id(lcpu);
 
 	/* Fixup atomic count: it exited inside IRQ handler. */
-	paca[lcpu].__current->thread_info->preempt_count	= 0;
+	task_thread_info(paca[lcpu].__current)->preempt_count	= 0;
 
 	/* 
 	 * If the RTAS start-cpu token does not exist then presume the
diff --git a/arch/ppc/kernel/process.c b/arch/ppc/kernel/process.c
index 25cbdc8..c3555a8 100644
--- a/arch/ppc/kernel/process.c
+++ b/arch/ppc/kernel/process.c
@@ -384,7 +384,7 @@ void show_regs(struct pt_regs * regs)
 	if (trap == 0x300 || trap == 0x600)
 		printk("DAR: %08lX, DSISR: %08lX\n", regs->dar, regs->dsisr);
 	printk("TASK = %p[%d] '%s' THREAD: %p\n",
-	       current, current->pid, current->comm, current->thread_info);
+	       current, current->pid, current->comm, task_thread_info(current));
 	printk("Last syscall: %ld ", current->thread.last_syscall);
 
 #ifdef CONFIG_SMP
diff --git a/arch/ppc/kernel/smp.c b/arch/ppc/kernel/smp.c
index becbfa3..e55cdda 100644
--- a/arch/ppc/kernel/smp.c
+++ b/arch/ppc/kernel/smp.c
@@ -318,7 +318,7 @@ void __init smp_prepare_cpus(unsigned in
 		p = fork_idle(cpu);
 		if (IS_ERR(p))
 			panic("failed fork for CPU %u: %li", cpu, PTR_ERR(p));
-		p->thread_info->cpu = cpu;
+		task_thread_info(p)->cpu = cpu;
 		idle_tasks[cpu] = p;
 	}
 }
@@ -369,7 +369,7 @@ int __cpu_up(unsigned int cpu)
 	char buf[32];
 	int c;
 
-	secondary_ti = idle_tasks[cpu]->thread_info;
+	secondary_ti = task_thread_info(idle_tasks[cpu]);
 	mb();
 
 	/*
-- 
0.99.9.GIT

