Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWACVK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWACVK7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbWACVHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:07:53 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:26767 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932526AbWACVHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:42 -0500
To: torvalds@osdl.org
Subject: [PATCH 11/50] sparc64: task_thread_info()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008PY-7q@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/sparc64/kernel/process.c     |    4 ++--
 arch/sparc64/kernel/ptrace.c      |   34 +++++++++++++++++-----------------
 arch/sparc64/kernel/setup.c       |    2 +-
 arch/sparc64/kernel/smp.c         |    2 +-
 include/asm-sparc64/mmu_context.h |    2 +-
 include/asm-sparc64/system.h      |    4 ++--
 6 files changed, 24 insertions(+), 24 deletions(-)

6cfb2e0b76db8ba49229addfc686169d48ba9e1a
diff --git a/arch/sparc64/kernel/process.c b/arch/sparc64/kernel/process.c
index 02f9dec..1bc7724 100644
--- a/arch/sparc64/kernel/process.c
+++ b/arch/sparc64/kernel/process.c
@@ -390,7 +390,7 @@ void show_regs32(struct pt_regs32 *regs)
 
 unsigned long thread_saved_pc(struct task_struct *tsk)
 {
-	struct thread_info *ti = tsk->thread_info;
+	struct thread_info *ti = task_thread_info(tsk);
 	unsigned long ret = 0xdeadbeefUL;
 	
 	if (ti && ti->ksp) {
@@ -847,7 +847,7 @@ unsigned long get_wchan(struct task_stru
 
 	thread_info_base = (unsigned long) task->thread_info;
 	bias = STACK_BIAS;
-	fp = task->thread_info->ksp + bias;
+	fp = task_thread_info(task)->ksp + bias;
 
 	do {
 		/* Bogus frame pointer? */
diff --git a/arch/sparc64/kernel/ptrace.c b/arch/sparc64/kernel/ptrace.c
index 774ecbb..7cdb897 100644
--- a/arch/sparc64/kernel/ptrace.c
+++ b/arch/sparc64/kernel/ptrace.c
@@ -348,7 +348,7 @@ asmlinkage void do_ptrace(struct pt_regs
 		unsigned long tpc = cregs->tpc;
 		int rval;
 
-		if ((child->thread_info->flags & _TIF_32BIT) != 0)
+		if ((task_thread_info(child)->flags & _TIF_32BIT) != 0)
 			tpc &= 0xffffffff;
 		if (__put_user(cregs->tstate, (&pregs->tstate)) ||
 		    __put_user(tpc, (&pregs->tpc)) ||
@@ -419,7 +419,7 @@ asmlinkage void do_ptrace(struct pt_regs
 			pt_error_return(regs, EFAULT);
 			goto out_tsk;
 		}
-		if ((child->thread_info->flags & _TIF_32BIT) != 0) {
+		if ((task_thread_info(child)->flags & _TIF_32BIT) != 0) {
 			tpc &= 0xffffffff;
 			tnpc &= 0xffffffff;
 		}
@@ -454,11 +454,11 @@ asmlinkage void do_ptrace(struct pt_regs
 			} fpq[16];
 		};
 		struct fps __user *fps = (struct fps __user *) addr;
-		unsigned long *fpregs = child->thread_info->fpregs;
+		unsigned long *fpregs = task_thread_info(child)->fpregs;
 
 		if (copy_to_user(&fps->regs[0], fpregs,
 				 (32 * sizeof(unsigned int))) ||
-		    __put_user(child->thread_info->xfsr[0], (&fps->fsr)) ||
+		    __put_user(task_thread_info(child)->xfsr[0], (&fps->fsr)) ||
 		    __put_user(0, (&fps->fpqd)) ||
 		    __put_user(0, (&fps->flags)) ||
 		    __put_user(0, (&fps->extra)) ||
@@ -476,11 +476,11 @@ asmlinkage void do_ptrace(struct pt_regs
 			unsigned long fsr;
 		};
 		struct fps __user *fps = (struct fps __user *) addr;
-		unsigned long *fpregs = child->thread_info->fpregs;
+		unsigned long *fpregs = task_thread_info(child)->fpregs;
 
 		if (copy_to_user(&fps->regs[0], fpregs,
 				 (64 * sizeof(unsigned int))) ||
-		    __put_user(child->thread_info->xfsr[0], (&fps->fsr))) {
+		    __put_user(task_thread_info(child)->xfsr[0], (&fps->fsr))) {
 			pt_error_return(regs, EFAULT);
 			goto out_tsk;
 		}
@@ -501,7 +501,7 @@ asmlinkage void do_ptrace(struct pt_regs
 			} fpq[16];
 		};
 		struct fps __user *fps = (struct fps __user *) addr;
-		unsigned long *fpregs = child->thread_info->fpregs;
+		unsigned long *fpregs = task_thread_info(child)->fpregs;
 		unsigned fsr;
 
 		if (copy_from_user(fpregs, &fps->regs[0],
@@ -510,11 +510,11 @@ asmlinkage void do_ptrace(struct pt_regs
 			pt_error_return(regs, EFAULT);
 			goto out_tsk;
 		}
-		child->thread_info->xfsr[0] &= 0xffffffff00000000UL;
-		child->thread_info->xfsr[0] |= fsr;
-		if (!(child->thread_info->fpsaved[0] & FPRS_FEF))
-			child->thread_info->gsr[0] = 0;
-		child->thread_info->fpsaved[0] |= (FPRS_FEF | FPRS_DL);
+		task_thread_info(child)->xfsr[0] &= 0xffffffff00000000UL;
+		task_thread_info(child)->xfsr[0] |= fsr;
+		if (!(task_thread_info(child)->fpsaved[0] & FPRS_FEF))
+			task_thread_info(child)->gsr[0] = 0;
+		task_thread_info(child)->fpsaved[0] |= (FPRS_FEF | FPRS_DL);
 		pt_succ_return(regs, 0);
 		goto out_tsk;
 	}
@@ -525,17 +525,17 @@ asmlinkage void do_ptrace(struct pt_regs
 			unsigned long fsr;
 		};
 		struct fps __user *fps = (struct fps __user *) addr;
-		unsigned long *fpregs = child->thread_info->fpregs;
+		unsigned long *fpregs = task_thread_info(child)->fpregs;
 
 		if (copy_from_user(fpregs, &fps->regs[0],
 				   (64 * sizeof(unsigned int))) ||
-		    __get_user(child->thread_info->xfsr[0], (&fps->fsr))) {
+		    __get_user(task_thread_info(child)->xfsr[0], (&fps->fsr))) {
 			pt_error_return(regs, EFAULT);
 			goto out_tsk;
 		}
-		if (!(child->thread_info->fpsaved[0] & FPRS_FEF))
-			child->thread_info->gsr[0] = 0;
-		child->thread_info->fpsaved[0] |= (FPRS_FEF | FPRS_DL | FPRS_DU);
+		if (!(task_thread_info(child)->fpsaved[0] & FPRS_FEF))
+			task_thread_info(child)->gsr[0] = 0;
+		task_thread_info(child)->fpsaved[0] |= (FPRS_FEF | FPRS_DL | FPRS_DU);
 		pt_succ_return(regs, 0);
 		goto out_tsk;
 	}
diff --git a/arch/sparc64/kernel/setup.c b/arch/sparc64/kernel/setup.c
index 4818053..2507458 100644
--- a/arch/sparc64/kernel/setup.c
+++ b/arch/sparc64/kernel/setup.c
@@ -520,7 +520,7 @@ void __init setup_arch(char **cmdline_p)
 	rd_doload = ((ram_flags & RAMDISK_LOAD_FLAG) != 0);	
 #endif
 
-	init_task.thread_info->kregs = &fake_swapper_regs;
+	task_thread_info(&init_task)->kregs = &fake_swapper_regs;
 
 #ifdef CONFIG_IP_PNP
 	if (!ic_set_manually) {
diff --git a/arch/sparc64/kernel/smp.c b/arch/sparc64/kernel/smp.c
index 6efc03d..1fb6323 100644
--- a/arch/sparc64/kernel/smp.c
+++ b/arch/sparc64/kernel/smp.c
@@ -335,7 +335,7 @@ static int __devinit smp_boot_one_cpu(un
 
 	p = fork_idle(cpu);
 	callin_flag = 0;
-	cpu_new_thread = p->thread_info;
+	cpu_new_thread = task_thread_info(p);
 	cpu_set(cpu, cpu_callout_map);
 
 	cpu_find_by_mid(cpu, &cpu_node);
diff --git a/include/asm-sparc64/mmu_context.h b/include/asm-sparc64/mmu_context.h
index 08ba72d..57ee7b3 100644
--- a/include/asm-sparc64/mmu_context.h
+++ b/include/asm-sparc64/mmu_context.h
@@ -60,7 +60,7 @@ do { \
 	register unsigned long pgd_cache asm("o4"); \
 	paddr = __pa((__mm)->pgd); \
 	pgd_cache = 0UL; \
-	if ((__tsk)->thread_info->flags & _TIF_32BIT) \
+	if (task_thread_info(__tsk)->flags & _TIF_32BIT) \
 		pgd_cache = get_pgd_cache((__mm)->pgd); \
 	__asm__ __volatile__("wrpr	%%g0, 0x494, %%pstate\n\t" \
 			     "mov	%3, %%g4\n\t" \
diff --git a/include/asm-sparc64/system.h b/include/asm-sparc64/system.h
index b541752..f380da0 100644
--- a/include/asm-sparc64/system.h
+++ b/include/asm-sparc64/system.h
@@ -212,7 +212,7 @@ do {	if (test_thread_flag(TIF_PERFCTR)) 
 	/* If you are tempted to conditionalize the following */	\
 	/* so that ASI is only written if it changes, think again. */	\
 	__asm__ __volatile__("wr %%g0, %0, %%asi"			\
-	: : "r" (__thread_flag_byte_ptr(next->thread_info)[TI_FLAG_BYTE_CURRENT_DS]));\
+	: : "r" (__thread_flag_byte_ptr(task_thread_info(next))[TI_FLAG_BYTE_CURRENT_DS]));\
 	__asm__ __volatile__(						\
 	"mov	%%g4, %%g7\n\t"						\
 	"wrpr	%%g0, 0x95, %%pstate\n\t"				\
@@ -242,7 +242,7 @@ do {	if (test_thread_flag(TIF_PERFCTR)) 
 	"b,a ret_from_syscall\n\t"					\
 	"1:\n\t"							\
 	: "=&r" (last)							\
-	: "0" (next->thread_info),					\
+	: "0" (task_thread_info(next)),					\
 	  "i" (TI_WSTATE), "i" (TI_KSP), "i" (TI_NEW_CHILD),            \
 	  "i" (TI_CWP), "i" (TI_TASK)					\
 	: "cc",								\
-- 
0.99.9.GIT

