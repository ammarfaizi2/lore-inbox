Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267733AbUHFEZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267733AbUHFEZE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 00:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267943AbUHFEZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 00:25:04 -0400
Received: from holomorphy.com ([207.189.100.168]:32456 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267733AbUHFEY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 00:24:27 -0400
Date: Thu, 5 Aug 2004 21:24:20 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm1
Message-ID: <20040806042420.GS17188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040805031918.08790a82.akpm@osdl.org> <20040806033448.GP17188@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806033448.GP17188@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 08:34:48PM -0700, William Lee Irwin III wrote:
> It appears that init_idle() and fork_by_hand() could be combined into
> a single method that calls init_idle() on behalf of the caller, which
> would amount to something like:
> task_t * __init fork_idle(int cpu)
[...]

Atop the full 2.6.8-rc3-mm1 series:

$ diffstat tmp/fork_idle.patch 
 arch/alpha/kernel/smp.c              |   14 +-------------
 arch/i386/kernel/smpboot.c           |   20 +-------------------
 arch/i386/mach-voyager/voyager_smp.c |   18 +-----------------
 arch/ia64/kernel/smpboot.c           |   27 ++++++---------------------
 arch/mips/kernel/smp.c               |   18 +-----------------
 arch/parisc/kernel/smp.c             |   23 +----------------------
 arch/ppc/kernel/smp.c                |    7 +------
 arch/ppc64/kernel/smp.c              |   10 +---------
 arch/s390/kernel/smp.c               |   11 +----------
 arch/sh/kernel/smp.c                 |    7 +------
 arch/sparc/kernel/sun4d_smp.c        |   11 +----------
 arch/sparc64/kernel/smp.c            |    9 +--------
 arch/um/kernel/smp.c                 |    4 +---
 arch/x86_64/kernel/smpboot.c         |   18 +-----------------
 include/linux/sched.h                |    2 +-
 init/main.c                          |    9 ---------
 kernel/fork.c                        |   16 +++++++++++++++-
 kernel/sched.c                       |    8 ++++++++
 18 files changed, 43 insertions(+), 189 deletions(-)


Index: mm1-2.6.8-rc3/arch/alpha/kernel/smp.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/alpha/kernel/smp.c	2004-08-05 05:30:43.000000000 -0700
+++ mm1-2.6.8-rc3/arch/alpha/kernel/smp.c	2004-08-05 20:42:56.581904632 -0700
@@ -412,15 +412,6 @@
 	return 0;
 }
 
-static struct task_struct * __init
-fork_by_hand(void)
-{
-	/* Don't care about the contents of regs since we'll never
-	   reschedule the forked task. */
-	struct pt_regs regs;
-	return copy_process(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
-}
-
 /*
  * Bring one cpu online.
  */
@@ -436,13 +427,10 @@
 	   the other task-y sort of data structures set up like we
 	   wish.  We can't use kernel_thread since we must avoid
 	   rescheduling the child.  */
-	idle = fork_by_hand();
+	idle = fork_idle(cpuid);
 	if (IS_ERR(idle))
 		panic("failed fork for CPU %d", cpuid);
 
-	init_idle(idle, cpuid);
-	unhash_process(idle);
-
 	DBGS(("smp_boot_one_cpu: CPU %d state 0x%lx flags 0x%lx\n",
 	      cpuid, idle->state, idle->flags));
 
Index: mm1-2.6.8-rc3/arch/i386/kernel/smpboot.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/i386/kernel/smpboot.c	2004-08-05 05:30:43.000000000 -0700
+++ mm1-2.6.8-rc3/arch/i386/kernel/smpboot.c	2004-08-05 20:43:33.993217248 -0700
@@ -502,16 +502,6 @@
 	unsigned short ss;
 } stack_start;
 
-static struct task_struct * __init fork_by_hand(void)
-{
-	struct pt_regs regs;
-	/*
-	 * don't care about the eip and regs settings since
-	 * we'll never reschedule the forked task.
-	 */
-	return copy_process(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
-}
-
 #ifdef CONFIG_NUMA
 
 /* which logical CPUs are on which nodes */
@@ -807,18 +797,10 @@
 	 * We can't use kernel_thread since we must avoid to
 	 * reschedule the child.
 	 */
-	idle = fork_by_hand();
+	idle = fork_idle(cpu);
 	if (IS_ERR(idle))
 		panic("failed fork for CPU %d", cpu);
-
-	/* Make this the idle thread */
-	init_idle(idle, cpu);
-
 	idle->thread.eip = (unsigned long) start_secondary;
-
-	/* Remove it from the pidhash */
-	unhash_process(idle);
-
 	/* start_eip had better be page-aligned! */
 	start_eip = setup_trampoline();
 
Index: mm1-2.6.8-rc3/arch/i386/mach-voyager/voyager_smp.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/i386/mach-voyager/voyager_smp.c	2004-08-05 05:30:43.000000000 -0700
+++ mm1-2.6.8-rc3/arch/i386/mach-voyager/voyager_smp.c	2004-08-05 20:51:52.557423968 -0700
@@ -523,15 +523,6 @@
 	return cpu_idle();
 }
 
-static struct task_struct * __init
-fork_by_hand(void)
-{
-	struct pt_regs regs;
-	/* don't care about the eip and regs settings since we'll
-	 * never reschedule the forked task. */
-	return copy_process(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
-}
-
 
 /* Routine to kick start the given CPU and wait for it to report ready
  * (or timeout in startup).  When this routine returns, the requested
@@ -587,17 +578,10 @@
 	hijack_source.idt.Segment = (start_phys_address >> 4) & 0xFFFF;
 
 	cpucount++;
-	idle = fork_by_hand();
+	idle = fork_idle(cpu);
 	if(IS_ERR(idle))
 		panic("failed fork for CPU%d", cpu);
-
-	/* Make this the idle thread */
-	init_idle(idle, cpu);
-
 	idle->thread.eip = (unsigned long) start_secondary;
-
-	/* Remove it from the pidhash */
-	unhash_process(idle);
 	/* init_tasks (in sched.c) is indexed logically */
 	stack_start.esp = (void *) idle->thread.esp;
 
Index: mm1-2.6.8-rc3/arch/ia64/kernel/smpboot.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/ia64/kernel/smpboot.c	2004-08-05 05:30:37.000000000 -0700
+++ mm1-2.6.8-rc3/arch/ia64/kernel/smpboot.c	2004-08-05 20:48:49.420265048 -0700
@@ -356,19 +356,10 @@
 	return cpu_idle();
 }
 
-static struct task_struct * __devinit
-fork_by_hand (void)
-{
-	/*
-	 * Don't care about the IP and regs settings since we'll never reschedule the
-	 * forked task.
-	 */
-	return copy_process(CLONE_VM|CLONE_IDLETASK, 0, 0, 0, NULL, NULL);
-}
-
 struct create_idle {
 	struct task_struct *idle;
 	struct completion done;
+	int cpu;
 };
 
 void
@@ -376,7 +367,7 @@
 {
 	struct create_idle *c_idle = _c_idle;
 
-	c_idle->idle = fork_by_hand();
+	c_idle->idle = fork_idle(c_idle->cpu);
 	complete(&c_idle->done);
 }
 
@@ -384,10 +375,11 @@
 do_boot_cpu (int sapicid, int cpu)
 {
 	int timeout;
-	struct create_idle c_idle;
+	struct create_idle c_idle = {
+		.cpu	= cpu,
+		.done	= COMPLETION_INITIALIZER(c_idle.done),
+	};
 	DECLARE_WORK(work, do_fork_idle, &c_idle);
-
-	init_completion(&c_idle.done);
 	/*
 	 * We can't use kernel_thread since we must avoid to reschedule the child.
 	 */
@@ -400,13 +392,6 @@
 
 	if (IS_ERR(c_idle.idle))
 		panic("failed fork for CPU %d", cpu);
-
-	/* Make this the idle thread */
-	init_idle(c_idle.idle, cpu);
-
-	/* Remove it from the pidhash */
-	unhash_process(c_idle.idle);
-
 	task_for_booting_cpu = c_idle.idle;
 
 	Dprintk("Sending wakeup vector %lu to AP 0x%x/0x%x.\n", ap_wakeup_vector, cpu, sapicid);
Index: mm1-2.6.8-rc3/arch/mips/kernel/smp.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/mips/kernel/smp.c	2004-08-05 05:30:36.000000000 -0700
+++ mm1-2.6.8-rc3/arch/mips/kernel/smp.c	2004-08-05 20:50:52.425565400 -0700
@@ -254,16 +254,6 @@
 	cpu_set(0, cpu_callin_map);
 }
 
-static struct task_struct * __init fork_by_hand(void)
-{
-	struct pt_regs regs;
-	/*
-	 * don't care about the eip and regs settings since
-	 * we'll never reschedule the forked task.
-	 */
-	return copy_process(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
-}
-
 /*
  * Startup the CPU with this logical number
  */
@@ -275,16 +265,10 @@
 	 * The following code is purely to make sure
 	 * Linux can schedule processes on this slave.
 	 */
-	idle = fork_by_hand();
+	idle = fork_idle(cpu);
 	if (IS_ERR(idle))
 		panic("failed fork for CPU %d\n", cpu);
 
-	/* Make this the idle thread */
-	init_idle(idle, cpu);
-
-	/* Remove it from the pidhash */
-	unhash_process(idle);
-
 	prom_boot_secondary(cpu, idle);
 
 	/* XXXKW timeout */
Index: mm1-2.6.8-rc3/arch/parisc/kernel/smp.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/parisc/kernel/smp.c	2004-08-05 05:30:36.000000000 -0700
+++ mm1-2.6.8-rc3/arch/parisc/kernel/smp.c	2004-08-05 20:45:09.552690000 -0700
@@ -504,24 +504,6 @@
 
 #if 0
 /*
- * Create the idle task for a new Slave CPU.  DO NOT use kernel_thread()
- * because that could end up calling schedule(). If it did, the new idle
- * task could get scheduled before we had a chance to remove it from the
- * run-queue...
- */
-static struct task_struct *fork_by_hand(void)
-{
-	struct pt_regs regs;  
-
-	/*
-	 * don't care about the regs settings since
-	 * we'll never reschedule the forked task.
-	 */
-	return copy_process(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
-}
-
-
-/*
  * Bring one cpu online.
  */
 int __init smp_boot_one_cpu(int cpuid, int cpunum)
@@ -539,12 +521,9 @@
 	 * Sheesh . . .
 	 */
 
-	idle = fork_by_hand();
+	idle = fork_idle(cpunum);
 	if (IS_ERR(idle))
 		panic("SMP: fork failed for CPU:%d", cpuid);
-
-	init_idle(idle, cpunum);
-	unhash_process(idle);
 	idle->thread_info->cpu = cpunum;
 
 	/* Let _start know what logical CPU we're booting
Index: mm1-2.6.8-rc3/arch/ppc/kernel/smp.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/ppc/kernel/smp.c	2004-08-05 05:30:36.000000000 -0700
+++ mm1-2.6.8-rc3/arch/ppc/kernel/smp.c	2004-08-05 20:51:11.882607480 -0700
@@ -364,20 +364,15 @@
 
 int __cpu_up(unsigned int cpu)
 {
-	struct pt_regs regs;
 	struct task_struct *p;
 	char buf[32];
 	int c;
 
 	/* create a process for the processor */
 	/* only regs.msr is actually used, and 0 is OK for it */
-	memset(&regs, 0, sizeof(struct pt_regs));
-	p = copy_process(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
+	p = fork_idle(cpu);
 	if (IS_ERR(p))
 		panic("failed fork for CPU %u: %li", cpu, PTR_ERR(p));
-	init_idle(p, cpu);
-	unhash_process(p);
-
 	secondary_ti = p->thread_info;
 	p->thread_info->cpu = cpu;
 
Index: mm1-2.6.8-rc3/arch/ppc64/kernel/smp.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/ppc64/kernel/smp.c	2004-08-05 05:30:37.000000000 -0700
+++ mm1-2.6.8-rc3/arch/ppc64/kernel/smp.c	2004-08-05 20:45:36.135648776 -0700
@@ -800,20 +800,12 @@
 
 static void __init smp_create_idle(unsigned int cpu)
 {
-	struct pt_regs regs;
 	struct task_struct *p;
 
 	/* create a process for the processor */
-	/* only regs.msr is actually used, and 0 is OK for it */
-	memset(&regs, 0, sizeof(struct pt_regs));
-	p = copy_process(CLONE_VM | CLONE_IDLETASK,
-			 0, &regs, 0, NULL, NULL);
+	p = fork_idle(cpu);
 	if (IS_ERR(p))
 		panic("failed fork for CPU %u: %li", cpu, PTR_ERR(p));
-
-	init_idle(p, cpu);
-	unhash_process(p);
-
 	paca[cpu].__current = p;
 	current_set[cpu] = p->thread_info;
 }
Index: mm1-2.6.8-rc3/arch/s390/kernel/smp.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/s390/kernel/smp.c	2004-08-05 05:30:36.000000000 -0700
+++ mm1-2.6.8-rc3/arch/s390/kernel/smp.c	2004-08-05 20:44:04.400594624 -0700
@@ -562,24 +562,15 @@
 
 static void __init smp_create_idle(unsigned int cpu)
 {
-	struct pt_regs regs;
 	struct task_struct *p;
 
 	/*
 	 *  don't care about the psw and regs settings since we'll never
 	 *  reschedule the forked task.
 	 */
-	memset(&regs, 0, sizeof(struct pt_regs));
-	p = copy_process(CLONE_VM | CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
+	p = fork_idle(cpu);
 	if (IS_ERR(p))
 		panic("failed fork for CPU %u: %li", cpu, PTR_ERR(p));
-
-	/* Make this the idle thread */
-	init_idle(p, cpu);
-
-	/* Remove it from the pidhash */
-	unhash_process(p);
-
 	current_set[cpu] = p;
 }
 
Index: mm1-2.6.8-rc3/arch/sh/kernel/smp.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/sh/kernel/smp.c	2004-08-05 05:30:36.000000000 -0700
+++ mm1-2.6.8-rc3/arch/sh/kernel/smp.c	2004-08-05 20:50:24.947742664 -0700
@@ -98,17 +98,12 @@
 int __cpu_up(unsigned int cpu)
 {
 	struct task_struct *tsk;
-	struct pt_regs regs;
 
-	memset(&regs, 0, sizeof(struct pt_regs));
-	tsk = copy_process(CLONE_VM | CLONE_IDLETASK, 0, &regs, 0, 0, 0);
+	tsk = fork_idle(cpu);
 
 	if (IS_ERR(tsk))
 		panic("Failed forking idle task for cpu %d\n", cpu);
 	
-	init_idle(tsk, cpu);
-	unhash_process(tsk);
-	
 	tsk->thread_info->cpu = cpu;
 
 	cpu_set(cpu, cpu_online_map);
Index: mm1-2.6.8-rc3/arch/sparc/kernel/sun4d_smp.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/sparc/kernel/sun4d_smp.c	2004-08-05 05:30:44.000000000 -0700
+++ mm1-2.6.8-rc3/arch/sparc/kernel/sun4d_smp.c	2004-08-05 20:42:08.015287880 -0700
@@ -201,18 +201,9 @@
 			int no;
 
 			/* Cook up an idler for this guy. */
-			kernel_thread(NULL, NULL, CLONE_IDLETASK);
-
+			p = fork_idle(p, cpu);
 			cpucount++;
-
-			p = prev_task(&init_task);
-
-			init_idle(p, i);
-
 			current_set[i] = p->thread_info;
-
-			unhash_process(p);
-
 			for (no = 0; !cpu_find_by_instance(no, NULL, &mid)
 				     && mid != i; no++) ;
 
Index: mm1-2.6.8-rc3/arch/sparc64/kernel/smp.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/sparc64/kernel/smp.c	2004-08-05 05:30:43.000000000 -0700
+++ mm1-2.6.8-rc3/arch/sparc64/kernel/smp.c	2004-08-05 20:41:23.502054920 -0700
@@ -302,14 +302,7 @@
 	struct task_struct *p;
 	int timeout, ret, cpu_node;
 
-	kernel_thread(NULL, NULL, CLONE_IDLETASK);
-
-	p = prev_task(&init_task);
-
-	init_idle(p, cpu);
-
-	unhash_process(p);
-
+	p = fork_idle(cpu);
 	callin_flag = 0;
 	cpu_new_thread = p->thread_info;
 	cpu_set(cpu, cpu_callout_map);
Index: mm1-2.6.8-rc3/arch/um/kernel/smp.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/um/kernel/smp.c	2004-08-05 05:30:39.000000000 -0700
+++ mm1-2.6.8-rc3/arch/um/kernel/smp.c	2004-08-05 20:49:33.637543000 -0700
@@ -105,8 +105,7 @@
 
         current->thread.request.u.thread.proc = idle_proc;
         current->thread.request.u.thread.arg = (void *) cpu;
-	new_task = copy_process(CLONE_VM | CLONE_IDLETASK, 0, NULL, 0, NULL,
-				NULL);
+	new_task = fork_idle(cpu);
 	if(IS_ERR(new_task))
 		panic("copy_process failed in idle_thread, error = %ld",
 		      PTR_ERR(new_task));
@@ -118,7 +117,6 @@
 	CHOOSE_MODE(os_write_file(new_task->thread.mode.tt.switch_pipe[1], &c,
 			  sizeof(c)),
 		    ({ panic("skas mode doesn't support SMP"); }));
-	wake_up_forked_process(new_task);
 	return(new_task);
 }
 
Index: mm1-2.6.8-rc3/arch/x86_64/kernel/smpboot.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/x86_64/kernel/smpboot.c	2004-08-05 05:30:36.000000000 -0700
+++ mm1-2.6.8-rc3/arch/x86_64/kernel/smpboot.c	2004-08-05 20:44:34.780976104 -0700
@@ -392,16 +392,6 @@
 extern volatile unsigned long init_rsp; 
 extern void (*initial_code)(void);
 
-static struct task_struct * __init fork_by_hand(void)
-{
-	struct pt_regs regs;
-	/*
-	 * don't care about the eip and regs settings since
-	 * we'll never reschedule the forked task.
-	 */
-	return copy_process(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
-}
-
 #if APIC_DEBUG
 static inline void inquire_remote_apic(int apicid)
 {
@@ -575,17 +565,11 @@
 	 * We can't use kernel_thread since we must avoid to
 	 * reschedule the child.
 	 */
-	idle = fork_by_hand();
+	idle = fork_idle(cpu);
 	if (IS_ERR(idle))
 		panic("failed fork for CPU %d", cpu);
 	x86_cpu_to_apicid[cpu] = apicid;
 
-	/* Make this the idle thread */
-	init_idle(idle,cpu);
-
-	/* Remove it from the pidhash */
-	unhash_process(idle);
-
 	cpu_pda[cpu].pcurrent = idle;
 
 	start_rip = setup_trampoline();
Index: mm1-2.6.8-rc3/include/linux/sched.h
===================================================================
--- mm1-2.6.8-rc3.orig/include/linux/sched.h	2004-08-05 05:30:44.000000000 -0700
+++ mm1-2.6.8-rc3/include/linux/sched.h	2004-08-05 20:34:52.309525224 -0700
@@ -968,7 +968,7 @@
 
 extern int do_execve(char *, char __user * __user *, char __user * __user *, struct pt_regs *);
 extern long do_fork(unsigned long, unsigned long, struct pt_regs *, unsigned long, int __user *, int __user *);
-extern struct task_struct * copy_process(unsigned long, unsigned long, struct pt_regs *, unsigned long, int __user *, int __user *);
+task_t *fork_idle(int);
 
 #ifdef CONFIG_SMP
 extern void wait_task_inactive(task_t * p);
Index: mm1-2.6.8-rc3/init/main.c
===================================================================
--- mm1-2.6.8-rc3.orig/init/main.c	2004-08-05 05:30:44.000000000 -0700
+++ mm1-2.6.8-rc3/init/main.c	2004-08-05 20:37:56.806477424 -0700
@@ -495,15 +495,6 @@
 	 * time - but meanwhile we still have a functioning scheduler.
 	 */
 	sched_init();
-
-	/*
-	 * Make us the idle thread. Technically, schedule() should not be
-	 * called from this thread, however somewhere below it might be,
-	 * but because we are the idle thread, we just pick up running again
-	 * when this runqueue becomes "idle".
-	 */
-	init_idle(current, smp_processor_id());
-
 	build_all_zonelists();
 	page_alloc_init();
 	trap_init();
Index: mm1-2.6.8-rc3/kernel/fork.c
===================================================================
--- mm1-2.6.8-rc3.orig/kernel/fork.c	2004-08-05 05:30:44.000000000 -0700
+++ mm1-2.6.8-rc3/kernel/fork.c	2004-08-05 20:37:17.587439624 -0700
@@ -881,7 +881,7 @@
  * parts of the process environment (as per the clone
  * flags). The actual kick-off is left to the caller.
  */
-struct task_struct *copy_process(unsigned long clone_flags,
+static task_t *copy_process(unsigned long clone_flags,
 				 unsigned long stack_start,
 				 struct pt_regs *regs,
 				 unsigned long stack_size,
@@ -1181,6 +1181,20 @@
 	goto fork_out;
 }
 
+task_t * __init fork_idle(int cpu)
+{
+	task_t *task;
+	struct pt_regs regs;
+
+	memset(&regs, 0, sizeof(struct pt_regs));
+	task = copy_process(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
+	if (!task)
+		return ERR_PTR(-ENOMEM);
+	init_idle(task, cpu);
+	unhash_process(task);
+	return task;
+}
+
 static inline int fork_traceflag (unsigned clone_flags)
 {
 	if (clone_flags & (CLONE_UNTRACED | CLONE_IDLETASK))
Index: mm1-2.6.8-rc3/kernel/sched.c
===================================================================
--- mm1-2.6.8-rc3.orig/kernel/sched.c	2004-08-05 05:30:43.000000000 -0700
+++ mm1-2.6.8-rc3/kernel/sched.c	2004-08-05 20:38:07.266887200 -0700
@@ -4391,6 +4391,14 @@
 	 */
 	atomic_inc(&init_mm.mm_count);
 	enter_lazy_tlb(&init_mm, current);
+
+	/*
+	 * Make us the idle thread. Technically, schedule() should not be
+	 * called from this thread, however somewhere below it might be,
+	 * but because we are the idle thread, we just pick up running again
+	 * when this runqueue becomes "idle".
+	 */
+	init_idle(current, smp_processor_id());
 }
 
 #ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
