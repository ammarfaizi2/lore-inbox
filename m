Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbWACVVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWACVVJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbWACVUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:20:25 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:34959 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932565AbWACVHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:42 -0500
To: torvalds@osdl.org
Subject: [PATCH 13/50] sparc64: task_pt_regs()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008Pf-A5@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/sparc64/kernel/ptrace.c    |   12 ++++++------
 include/asm-sparc64/elf.h       |    2 +-
 include/asm-sparc64/processor.h |    5 +++--
 3 files changed, 10 insertions(+), 9 deletions(-)

e37dce1f4a97b22c68d77e7567aa62db3a7e47b4
diff --git a/arch/sparc64/kernel/ptrace.c b/arch/sparc64/kernel/ptrace.c
index 7cdb897..6003f03 100644
--- a/arch/sparc64/kernel/ptrace.c
+++ b/arch/sparc64/kernel/ptrace.c
@@ -320,7 +320,7 @@ asmlinkage void do_ptrace(struct pt_regs
 	case PTRACE_GETREGS: {
 		struct pt_regs32 __user *pregs =
 			(struct pt_regs32 __user *) addr;
-		struct pt_regs *cregs = child->thread_info->kregs;
+		struct pt_regs *cregs = task_pt_regs(child);
 		int rval;
 
 		if (__put_user(tstate_to_psr(cregs->tstate), (&pregs->psr)) ||
@@ -344,7 +344,7 @@ asmlinkage void do_ptrace(struct pt_regs
 
 	case PTRACE_GETREGS64: {
 		struct pt_regs __user *pregs = (struct pt_regs __user *) addr;
-		struct pt_regs *cregs = child->thread_info->kregs;
+		struct pt_regs *cregs = task_pt_regs(child);
 		unsigned long tpc = cregs->tpc;
 		int rval;
 
@@ -372,7 +372,7 @@ asmlinkage void do_ptrace(struct pt_regs
 	case PTRACE_SETREGS: {
 		struct pt_regs32 __user *pregs =
 			(struct pt_regs32 __user *) addr;
-		struct pt_regs *cregs = child->thread_info->kregs;
+		struct pt_regs *cregs = task_pt_regs(child);
 		unsigned int psr, pc, npc, y;
 		int i;
 
@@ -405,7 +405,7 @@ asmlinkage void do_ptrace(struct pt_regs
 
 	case PTRACE_SETREGS64: {
 		struct pt_regs __user *pregs = (struct pt_regs __user *) addr;
-		struct pt_regs *cregs = child->thread_info->kregs;
+		struct pt_regs *cregs = task_pt_regs(child);
 		unsigned long tstate, tpc, tnpc, y;
 		int i;
 
@@ -586,8 +586,8 @@ asmlinkage void do_ptrace(struct pt_regs
 #ifdef DEBUG_PTRACE
 		printk("CONT: %s [%d]: set exit_code = %x %lx %lx\n", child->comm,
 			child->pid, child->exit_code,
-			child->thread_info->kregs->tpc,
-			child->thread_info->kregs->tnpc);
+			task_pt_regs(child)->tpc,
+			task_pt_regs(child)->tnpc);
 		       
 #endif
 		wake_up_process(child);
diff --git a/include/asm-sparc64/elf.h b/include/asm-sparc64/elf.h
index 9145811..69539a8 100644
--- a/include/asm-sparc64/elf.h
+++ b/include/asm-sparc64/elf.h
@@ -119,7 +119,7 @@ typedef struct {
 #endif
 
 #define ELF_CORE_COPY_TASK_REGS(__tsk, __elf_regs)	\
-	({ ELF_CORE_COPY_REGS((*(__elf_regs)), (__tsk)->thread_info->kregs); 1; })
+	({ ELF_CORE_COPY_REGS((*(__elf_regs)), task_pt_regs(__tsk)); 1; })
 
 /*
  * This is used to ensure we don't load something for the wrong architecture.
diff --git a/include/asm-sparc64/processor.h b/include/asm-sparc64/processor.h
index 3169f3e..cd8d9b4 100644
--- a/include/asm-sparc64/processor.h
+++ b/include/asm-sparc64/processor.h
@@ -186,8 +186,9 @@ extern pid_t kernel_thread(int (*fn)(voi
 
 extern unsigned long get_wchan(struct task_struct *task);
 
-#define KSTK_EIP(tsk)  ((tsk)->thread_info->kregs->tpc)
-#define KSTK_ESP(tsk)  ((tsk)->thread_info->kregs->u_regs[UREG_FP])
+#define task_pt_regs(tsk) (task_thread_info(tsk)->kregs)
+#define KSTK_EIP(tsk)  (task_pt_regs(tsk)->tpc)
+#define KSTK_ESP(tsk)  (task_pt_regs(tsk)->u_regs[UREG_FP])
 
 #define cpu_relax()	barrier()
 
-- 
0.99.9.GIT

