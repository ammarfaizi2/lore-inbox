Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbWACVSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbWACVSr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWACVRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:17:44 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:24719 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932561AbWACVHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:42 -0500
To: torvalds@osdl.org
Subject: [PATCH 03/50] alpha: task_stack_page()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008PI-4d@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

use task_stack_page() for accesses to stack page of task in alpha-specific
parts of tree

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/alpha/kernel/process.c |    6 +++---
 arch/alpha/kernel/ptrace.c  |    2 +-
 include/asm-alpha/ptrace.h  |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

87f43fe7d9b15cb3f6533391a249adcdab8effea
diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index f15a456..04c5342 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -271,7 +271,7 @@ copy_thread(int nr, unsigned long clone_
 {
 	extern void ret_from_fork(void);
 
-	struct thread_info *childti = p->thread_info;
+	struct thread_info *childti = task_thread_info(p);
 	struct pt_regs * childregs;
 	struct switch_stack * childstack, *stack;
 	unsigned long stack_offset, settls;
@@ -280,7 +280,7 @@ copy_thread(int nr, unsigned long clone_
 	if (!(regs->ps & 8))
 		stack_offset = (PAGE_SIZE-1) & (unsigned long) regs;
 	childregs = (struct pt_regs *)
-	  (stack_offset + PAGE_SIZE + (long) childti);
+	  (stack_offset + PAGE_SIZE + task_stack_page(p));
 		
 	*childregs = *regs;
 	settls = regs->r20;
@@ -487,7 +487,7 @@ out:
 unsigned long
 thread_saved_pc(task_t *t)
 {
-	unsigned long base = (unsigned long)t->thread_info;
+	unsigned long base = (unsigned long)task_stack_page(t);
 	unsigned long fp, sp = task_thread_info(t)->pcb.ksp;
 
 	if (sp > base && sp+6*8 < base + 16*1024) {
diff --git a/arch/alpha/kernel/ptrace.c b/arch/alpha/kernel/ptrace.c
index c83ce5d..67c0cb6 100644
--- a/arch/alpha/kernel/ptrace.c
+++ b/arch/alpha/kernel/ptrace.c
@@ -110,7 +110,7 @@ get_reg_addr(struct task_struct * task, 
 		zero = 0;
 		addr = &zero;
 	} else {
-		addr = (void *)task->thread_info + regoff[regno];
+		addr = task_stack_page(task) + regoff[regno];
 	}
 	return addr;
 }
diff --git a/include/asm-alpha/ptrace.h b/include/asm-alpha/ptrace.h
index 072375c..994680b 100644
--- a/include/asm-alpha/ptrace.h
+++ b/include/asm-alpha/ptrace.h
@@ -76,7 +76,7 @@ struct switch_stack {
 extern void show_regs(struct pt_regs *);
 
 #define alpha_task_regs(task) \
-  ((struct pt_regs *) ((long) (task)->thread_info + 2*PAGE_SIZE) - 1)
+  ((struct pt_regs *) (task_stack_page(task) + 2*PAGE_SIZE) - 1)
 
 #define force_successful_syscall_return() (alpha_task_regs(current)->r0 = 0)
 
-- 
0.99.9.GIT

