Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWACVK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWACVK0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWACVHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:07:54 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36751 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932532AbWACVHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:42 -0500
To: torvalds@osdl.org
Subject: [PATCH 25/50] m32r: task_pt_regs(), task_stack_page(), task_thread_info()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008Qm-NA@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/m32r/kernel/process.c |    5 +----
 arch/m32r/kernel/ptrace.c  |   25 ++++---------------------
 arch/m32r/kernel/smpboot.c |    2 +-
 include/asm-m32r/ptrace.h  |    3 +++
 4 files changed, 9 insertions(+), 26 deletions(-)

280ab86fae79fc9399d24fbfa88baaf930fda0a3
diff --git a/arch/m32r/kernel/process.c b/arch/m32r/kernel/process.c
index cc4b571..9d68c0b 100644
--- a/arch/m32r/kernel/process.c
+++ b/arch/m32r/kernel/process.c
@@ -238,13 +238,10 @@ int dump_fpu(struct pt_regs *regs, elf_f
 int copy_thread(int nr, unsigned long clone_flags, unsigned long spu,
 	unsigned long unused, struct task_struct *tsk, struct pt_regs *regs)
 {
-	struct pt_regs *childregs;
-	unsigned long sp = (unsigned long)tsk->thread_info + THREAD_SIZE;
+	struct pt_regs *childregs = task_pt_regs(tsk);
 	extern void ret_from_fork(void);
 
 	/* Copy registers */
-	sp -= sizeof (struct pt_regs);
-	childregs = (struct pt_regs *)sp;
 	*childregs = *regs;
 
 	childregs->spu = spu;
diff --git a/arch/m32r/kernel/ptrace.c b/arch/m32r/kernel/ptrace.c
index 078d2a0..b67cabf 100644
--- a/arch/m32r/kernel/ptrace.c
+++ b/arch/m32r/kernel/ptrace.c
@@ -35,23 +35,6 @@
 #include <asm/mmu_context.h>
 
 /*
- * Get the address of the live pt_regs for the specified task.
- * These are saved onto the top kernel stack when the process
- * is not running.
- *
- * Note: if a user thread is execve'd from kernel space, the
- * kernel stack will not be empty on entry to the kernel, so
- * ptracing these tasks will fail.
- */
-static inline struct pt_regs *
-get_user_regs(struct task_struct *task)
-{
-        return (struct pt_regs *)
-                ((unsigned long)task->thread_info + THREAD_SIZE
-                 - sizeof(struct pt_regs));
-}
-
-/*
  * This routine will get a word off of the process kernel stack.
  */
 static inline unsigned long int
@@ -59,7 +42,7 @@ get_stack_long(struct task_struct *task,
 {
 	unsigned long *stack;
 
-	stack = (unsigned long *)get_user_regs(task);
+	stack = (unsigned long *)task_pt_regs(task);
 
 	return stack[offset];
 }
@@ -72,7 +55,7 @@ put_stack_long(struct task_struct *task,
 {
 	unsigned long *stack;
 
-	stack = (unsigned long *)get_user_regs(task);
+	stack = (unsigned long *)task_pt_regs(task);
 	stack[offset] = data;
 
 	return 0;
@@ -208,7 +191,7 @@ static int ptrace_write_user(struct task
  */
 static int ptrace_getregs(struct task_struct *tsk, void __user *uregs)
 {
-	struct pt_regs *regs = get_user_regs(tsk);
+	struct pt_regs *regs = task_pt_regs(tsk);
 
 	return copy_to_user(uregs, regs, sizeof(struct pt_regs)) ? -EFAULT : 0;
 }
@@ -223,7 +206,7 @@ static int ptrace_setregs(struct task_st
 
 	ret = -EFAULT;
 	if (copy_from_user(&newregs, uregs, sizeof(struct pt_regs)) == 0) {
-		struct pt_regs *regs = get_user_regs(tsk);
+		struct pt_regs *regs = task_pt_regs(tsk);
 		*regs = newregs;
 		ret = 0;
 	}
diff --git a/arch/m32r/kernel/smpboot.c b/arch/m32r/kernel/smpboot.c
index b90c541..d7ec16e 100644
--- a/arch/m32r/kernel/smpboot.c
+++ b/arch/m32r/kernel/smpboot.c
@@ -286,7 +286,7 @@ static void __init do_boot_cpu(int phys_
 	/* So we see what's up   */
 	printk("Booting processor %d/%d\n", phys_id, cpu_id);
 	stack_start.spi = (void *)idle->thread.sp;
-	idle->thread_info->cpu = cpu_id;
+	task_thread_info(idle)->cpu = cpu_id;
 
 	/*
 	 * Send Startup IPI
diff --git a/include/asm-m32r/ptrace.h b/include/asm-m32r/ptrace.h
index 55cd7ec..0d058b2 100644
--- a/include/asm-m32r/ptrace.h
+++ b/include/asm-m32r/ptrace.h
@@ -163,6 +163,9 @@ extern void show_regs(struct pt_regs *);
 
 extern void withdraw_debug_trap(struct pt_regs *regs);
 
+#define task_pt_regs(task) \
+        ((struct pt_regs *)(task_stack_page(task) + THREAD_SIZE) - 1)
+
 #endif /* __KERNEL */
 
 #endif /* _ASM_M32R_PTRACE_H */
-- 
0.99.9.GIT

