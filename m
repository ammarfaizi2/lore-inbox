Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbWACVTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbWACVTX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbWACVRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:17:38 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:31119 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932568AbWACVHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:42 -0500
To: torvalds@osdl.org
Subject: [PATCH 17/50] sparc: task_thread_info()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008Pr-Hg@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/sparc/kernel/process.c   |    4 ++--
 arch/sparc/kernel/ptrace.c    |    4 ++--
 arch/sparc/kernel/sun4d_smp.c |    2 +-
 arch/sparc/kernel/sun4m_smp.c |    2 +-
 arch/sparc/kernel/traps.c     |    4 ++--
 include/asm-sparc/system.h    |    2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

57a365b614ef7e2218c53bf4c15b4ba993902906
diff --git a/arch/sparc/kernel/process.c b/arch/sparc/kernel/process.c
index ea86474..7eebb08 100644
--- a/arch/sparc/kernel/process.c
+++ b/arch/sparc/kernel/process.c
@@ -337,7 +337,7 @@ EXPORT_SYMBOL(dump_stack);
  */
 unsigned long thread_saved_pc(struct task_struct *tsk)
 {
-	return tsk->thread_info->kpc;
+	return task_thread_info(tsk)->kpc;
 }
 
 /*
@@ -724,7 +724,7 @@ unsigned long get_wchan(struct task_stru
             task->state == TASK_RUNNING)
 		goto out;
 
-	fp = task->thread_info->ksp + bias;
+	fp = task_thread_info(task)->ksp + bias;
 	do {
 		/* Bogus frame pointer? */
 		if (fp < (task_base + sizeof(struct thread_info)) ||
diff --git a/arch/sparc/kernel/ptrace.c b/arch/sparc/kernel/ptrace.c
index 475c4c1..34705a8 100644
--- a/arch/sparc/kernel/ptrace.c
+++ b/arch/sparc/kernel/ptrace.c
@@ -75,7 +75,7 @@ static inline void read_sunos_user(struc
 				   struct task_struct *tsk, long __user *addr)
 {
 	struct pt_regs *cregs = tsk->thread.kregs;
-	struct thread_info *t = tsk->thread_info;
+	struct thread_info *t = task_thread_info(tsk);
 	int v;
 	
 	if(offset >= 1024)
@@ -170,7 +170,7 @@ static inline void write_sunos_user(stru
 				    struct task_struct *tsk)
 {
 	struct pt_regs *cregs = tsk->thread.kregs;
-	struct thread_info *t = tsk->thread_info;
+	struct thread_info *t = task_thread_info(tsk);
 	unsigned long value = regs->u_regs[UREG_I3];
 
 	if(offset >= 1024)
diff --git a/arch/sparc/kernel/sun4d_smp.c b/arch/sparc/kernel/sun4d_smp.c
index cc1fc89..40d426c 100644
--- a/arch/sparc/kernel/sun4d_smp.c
+++ b/arch/sparc/kernel/sun4d_smp.c
@@ -200,7 +200,7 @@ void __init smp4d_boot_cpus(void)
 			/* Cook up an idler for this guy. */
 			p = fork_idle(i);
 			cpucount++;
-			current_set[i] = p->thread_info;
+			current_set[i] = task_thread_info(p);
 			for (no = 0; !cpu_find_by_instance(no, NULL, &mid)
 				     && mid != i; no++) ;
 
diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.c
index f113422..a21f27d 100644
--- a/arch/sparc/kernel/sun4m_smp.c
+++ b/arch/sparc/kernel/sun4m_smp.c
@@ -173,7 +173,7 @@ void __init smp4m_boot_cpus(void)
 			/* Cook up an idler for this guy. */
 			p = fork_idle(i);
 			cpucount++;
-			current_set[i] = p->thread_info;
+			current_set[i] = task_thread_info(p);
 			/* See trampoline.S for details... */
 			entry += ((i-1) * 3);
 
diff --git a/arch/sparc/kernel/traps.c b/arch/sparc/kernel/traps.c
index 3f451ae..41d45c2 100644
--- a/arch/sparc/kernel/traps.c
+++ b/arch/sparc/kernel/traps.c
@@ -291,7 +291,7 @@ void do_fpe_trap(struct pt_regs *regs, u
 #ifndef CONFIG_SMP
 	if(!fpt) {
 #else
-        if(!(fpt->thread_info->flags & _TIF_USEDFPU)) {
+        if(!(task_thread_info(fpt)->flags & _TIF_USEDFPU)) {
 #endif
 		fpsave(&fake_regs[0], &fake_fsr, &fake_queue[0], &fake_depth);
 		regs->psr &= ~PSR_EF;
@@ -334,7 +334,7 @@ void do_fpe_trap(struct pt_regs *regs, u
 	/* nope, better SIGFPE the offending process... */
 	       
 #ifdef CONFIG_SMP
-	fpt->thread_info->flags &= ~_TIF_USEDFPU;
+	task_thread_info(fpt)->flags &= ~_TIF_USEDFPU;
 #endif
 	if(psr & PSR_PS) {
 		/* The first fsr store/load we tried trapped,
diff --git a/include/asm-sparc/system.h b/include/asm-sparc/system.h
index 1f6b71f..20bf381 100644
--- a/include/asm-sparc/system.h
+++ b/include/asm-sparc/system.h
@@ -155,7 +155,7 @@ extern void fpsave(unsigned long *fpregs
 	"here:\n"									\
         : "=&r" (last)									\
         : "r" (&(current_set[hard_smp_processor_id()])),	\
-	  "r" ((next)->thread_info),				\
+	  "r" (task_thread_info(next)),				\
 	  "i" (TI_KPSR),					\
 	  "i" (TI_KSP),						\
 	  "i" (TI_TASK)						\
-- 
0.99.9.GIT

