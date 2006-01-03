Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWACVO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWACVO4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWACVOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:14:55 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:35983 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932551AbWACVHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:42 -0500
To: torvalds@osdl.org
Subject: [PATCH 23/50] xtensa: task_pt_regs(), task_stack_page()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008Qc-MG@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/xtensa/kernel/process.c   |    4 ++--
 arch/xtensa/kernel/ptrace.c    |   12 ++++++------
 include/asm-xtensa/processor.h |    6 +++---
 include/asm-xtensa/ptrace.h    |    4 ++--
 4 files changed, 13 insertions(+), 13 deletions(-)

05742756efda39221d12ca3923470becfc4cf860
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index 6a44b54..f1f5966 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -145,7 +145,7 @@ int copy_thread(int nr, unsigned long cl
 	int user_mode = user_mode(regs);
 
 	/* Set up new TSS. */
-	tos = (unsigned long)p->thread_info + THREAD_SIZE;
+	tos = (unsigned long)task_stack_page(p) + THREAD_SIZE;
 	if (user_mode)
 		childregs = (struct pt_regs*)(tos - PT_USER_SIZE);
 	else
@@ -217,7 +217,7 @@ int kernel_thread(int (*fn)(void *), voi
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long sp, pc;
-	unsigned long stack_page = (unsigned long) p->thread_info;
+	unsigned long stack_page = (unsigned long) task_stack_page(p);
 	int count = 0;
 
 	if (!p || p == current || p->state == TASK_RUNNING)
diff --git a/arch/xtensa/kernel/ptrace.c b/arch/xtensa/kernel/ptrace.c
index ab5c4c6..4cc8528 100644
--- a/arch/xtensa/kernel/ptrace.c
+++ b/arch/xtensa/kernel/ptrace.c
@@ -72,7 +72,7 @@ long arch_ptrace(struct task_struct *chi
 		struct pt_regs *regs;
 		unsigned long tmp;
 
-		regs = xtensa_pt_regs(child);
+		regs = task_pt_regs(child);
 		tmp = 0;  /* Default return value. */
 
 		switch(addr) {
@@ -149,7 +149,7 @@ long arch_ptrace(struct task_struct *chi
 	case PTRACE_POKEUSR:
 		{
 		struct pt_regs *regs;
-		regs = xtensa_pt_regs(child);
+		regs = task_pt_regs(child);
 
 		switch (addr) {
 		case REG_AR_BASE ... REG_AR_BASE + XCHAL_NUM_AREGS - 1:
@@ -240,7 +240,7 @@ long arch_ptrace(struct task_struct *chi
 		 * elf_gregset_t format. */
 
 		xtensa_gregset_t format;
-		struct pt_regs *regs = xtensa_pt_regs(child);
+		struct pt_regs *regs = task_pt_regs(child);
 
 		do_copy_regs (&format, regs, child);
 
@@ -257,7 +257,7 @@ long arch_ptrace(struct task_struct *chi
 		 * values in the elf_gregset_t format. */
 
 		xtensa_gregset_t format;
-		struct pt_regs *regs = xtensa_pt_regs(child);
+		struct pt_regs *regs = task_pt_regs(child);
 
 		if (copy_from_user(&format,(void *)data,sizeof(elf_gregset_t))){
 			ret = -EFAULT;
@@ -281,7 +281,7 @@ long arch_ptrace(struct task_struct *chi
 		 * elf_fpregset_t format. */
 
 		elf_fpregset_t fpregs;
-		struct pt_regs *regs = xtensa_pt_regs(child);
+		struct pt_regs *regs = task_pt_regs(child);
 
 		do_save_fpregs (&fpregs, regs, child);
 
@@ -299,7 +299,7 @@ long arch_ptrace(struct task_struct *chi
 		 * values in the elf_fpregset_t format.
 		 */
 		elf_fpregset_t fpregs;
-		struct pt_regs *regs = xtensa_pt_regs(child);
+		struct pt_regs *regs = task_pt_regs(child);
 
 		ret = 0;
 		if (copy_from_user(&fpregs, (void *)data, sizeof(elf_fpregset_t))) {
diff --git a/include/asm-xtensa/processor.h b/include/asm-xtensa/processor.h
index 9cab5e4..d1d72ad 100644
--- a/include/asm-xtensa/processor.h
+++ b/include/asm-xtensa/processor.h
@@ -184,12 +184,12 @@ extern int kernel_thread(int (*fn)(void 
 #define release_segments(mm)	do { } while(0)
 #define forget_segments()	do { } while (0)
 
-#define thread_saved_pc(tsk)	(xtensa_pt_regs(tsk)->pc)
+#define thread_saved_pc(tsk)	(task_pt_regs(tsk)->pc)
 
 extern unsigned long get_wchan(struct task_struct *p);
 
-#define KSTK_EIP(tsk)		(xtensa_pt_regs(tsk)->pc)
-#define KSTK_ESP(tsk)		(xtensa_pt_regs(tsk)->areg[1])
+#define KSTK_EIP(tsk)		(task_pt_regs(tsk)->pc)
+#define KSTK_ESP(tsk)		(task_pt_regs(tsk)->areg[1])
 
 #define cpu_relax()  do { } while (0)
 
diff --git a/include/asm-xtensa/ptrace.h b/include/asm-xtensa/ptrace.h
index aa4fd7f..a5ac71a 100644
--- a/include/asm-xtensa/ptrace.h
+++ b/include/asm-xtensa/ptrace.h
@@ -113,8 +113,8 @@ struct pt_regs {
 };
 
 #ifdef __KERNEL__
-# define xtensa_pt_regs(tsk) ((struct pt_regs*) \
-  (((long)(tsk)->thread_info + KERNEL_STACK_SIZE - (XCHAL_NUM_AREGS-16)*4)) - 1)
+# define task_pt_regs(tsk) ((struct pt_regs*) \
+  (task_stack_page(tsk) + KERNEL_STACK_SIZE - (XCHAL_NUM_AREGS-16)*4) - 1)
 # define user_mode(regs) (((regs)->ps & 0x00000020)!=0)
 # define instruction_pointer(regs) ((regs)->pc)
 extern void show_regs(struct pt_regs *);
-- 
0.99.9.GIT

