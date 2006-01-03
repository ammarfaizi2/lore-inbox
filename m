Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWACVOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWACVOm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWACVOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:14:09 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:25231 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932562AbWACVHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:42 -0500
To: torvalds@osdl.org
Subject: [PATCH 04/50] alpha: task_pt_regs()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008PK-53@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

rename alpha_task_regs() to task_pt_regs(), switch open-coded instances
to use of the helper.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/alpha/kernel/process.c   |   19 ++-----------------
 arch/alpha/kernel/ptrace.c    |    7 +++++++
 include/asm-alpha/processor.h |   11 +----------
 include/asm-alpha/ptrace.h    |    4 ++--
 4 files changed, 12 insertions(+), 29 deletions(-)

1e0e86cf54c28396e85a85bab125822292264ce3
diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index 04c5342..3b967de 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -423,30 +423,15 @@ dump_elf_thread(elf_greg_t *dest, struct
 int
 dump_elf_task(elf_greg_t *dest, struct task_struct *task)
 {
-	struct thread_info *ti;
-	struct pt_regs *pt;
-
-	ti = task->thread_info;
-	pt = (struct pt_regs *)((unsigned long)ti + 2*PAGE_SIZE) - 1;
-
-	dump_elf_thread(dest, pt, ti);
-
+	dump_elf_thread(dest, task_pt_regs(task), task_thread_info(task));
 	return 1;
 }
 
 int
 dump_elf_task_fp(elf_fpreg_t *dest, struct task_struct *task)
 {
-	struct thread_info *ti;
-	struct pt_regs *pt;
-	struct switch_stack *sw;
-
-	ti = task->thread_info;
-	pt = (struct pt_regs *)((unsigned long)ti + 2*PAGE_SIZE) - 1;
-	sw = (struct switch_stack *)pt - 1;
-
+	struct switch_stack *sw = (struct switch_stack *)task_pt_regs(task) - 1;
 	memcpy(dest, sw->fp, 32 * 8);
-
 	return 1;
 }
 
diff --git a/arch/alpha/kernel/ptrace.c b/arch/alpha/kernel/ptrace.c
index 67c0cb6..0f9753f 100644
--- a/arch/alpha/kernel/ptrace.c
+++ b/arch/alpha/kernel/ptrace.c
@@ -72,6 +72,13 @@ enum {
 	REG_R0 = 0, REG_F0 = 32, REG_FPCR = 63, REG_PC = 64
 };
 
+#define PT_REG(reg) \
+  (PAGE_SIZE*2 - sizeof(struct pt_regs) + offsetof(struct pt_regs, reg))
+
+#define SW_REG(reg) \
+ (PAGE_SIZE*2 - sizeof(struct pt_regs) - sizeof(struct switch_stack) \
+  + offsetof(struct switch_stack, reg))
+
 static int regoff[] = {
 	PT_REG(	   r0), PT_REG(	   r1), PT_REG(	   r2), PT_REG(	  r3),
 	PT_REG(	   r4), PT_REG(	   r5), PT_REG(	   r6), PT_REG(	  r7),
diff --git a/include/asm-alpha/processor.h b/include/asm-alpha/processor.h
index e59a6ec..f414fd0 100644
--- a/include/asm-alpha/processor.h
+++ b/include/asm-alpha/processor.h
@@ -52,16 +52,7 @@ extern long kernel_thread(int (*fn)(void
 
 unsigned long get_wchan(struct task_struct *p);
 
-/* See arch/alpha/kernel/ptrace.c for details.  */
-#define PT_REG(reg) \
-  (PAGE_SIZE*2 - sizeof(struct pt_regs) + offsetof(struct pt_regs, reg))
-
-#define SW_REG(reg) \
- (PAGE_SIZE*2 - sizeof(struct pt_regs) - sizeof(struct switch_stack) \
-  + offsetof(struct switch_stack, reg))
-
-#define KSTK_EIP(tsk) \
-  (*(unsigned long *)(PT_REG(pc) + (unsigned long) ((tsk)->thread_info)))
+#define KSTK_EIP(tsk) (task_pt_regs(tsk)->pc)
 
 #define KSTK_ESP(tsk) \
   ((tsk) == current ? rdusp() : task_thread_info(tsk)->pcb.usp)
diff --git a/include/asm-alpha/ptrace.h b/include/asm-alpha/ptrace.h
index 994680b..9933b8b 100644
--- a/include/asm-alpha/ptrace.h
+++ b/include/asm-alpha/ptrace.h
@@ -75,10 +75,10 @@ struct switch_stack {
 #define profile_pc(regs) instruction_pointer(regs)
 extern void show_regs(struct pt_regs *);
 
-#define alpha_task_regs(task) \
+#define task_pt_regs(task) \
   ((struct pt_regs *) (task_stack_page(task) + 2*PAGE_SIZE) - 1)
 
-#define force_successful_syscall_return() (alpha_task_regs(current)->r0 = 0)
+#define force_successful_syscall_return() (task_pt_regs(current)->r0 = 0)
 
 #endif
 
-- 
0.99.9.GIT

