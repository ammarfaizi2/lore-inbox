Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbWACVVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWACVVt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWACVUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:20:19 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:30351 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932570AbWACVHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:42 -0500
To: torvalds@osdl.org
Subject: [PATCH 06/50] amd64: task_pt_regs()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008PO-6X@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/x86_64/ia32/ia32_binfmt.c |    7 +++----
 arch/x86_64/ia32/ptrace32.c    |    6 +++---
 arch/x86_64/kernel/process.c   |    3 +--
 arch/x86_64/kernel/ptrace.c    |   10 ++--------
 arch/x86_64/kernel/traps.c     |    2 +-
 include/asm-x86_64/compat.h    |    2 +-
 include/asm-x86_64/processor.h |    4 ++--
 7 files changed, 13 insertions(+), 21 deletions(-)

722968f3cfb9e1b83cec30919ec2c09e8c5e1e2b
diff --git a/arch/x86_64/ia32/ia32_binfmt.c b/arch/x86_64/ia32/ia32_binfmt.c
index 2b760d0..029bdda 100644
--- a/arch/x86_64/ia32/ia32_binfmt.c
+++ b/arch/x86_64/ia32/ia32_binfmt.c
@@ -197,8 +197,7 @@ static inline void elf_core_copy_regs(el
 
 static inline int elf_core_copy_task_regs(struct task_struct *t, elf_gregset_t* elfregs)
 {	
-	struct pt_regs *pp = (struct pt_regs *)(t->thread.rsp0);
-	--pp;
+	struct pt_regs *pp = task_pt_regs(t);
 	ELF_CORE_COPY_REGS((*elfregs), pp);
 	/* fix wrong segments */ 
 	(*elfregs)[7] = t->thread.ds; 
@@ -217,7 +216,7 @@ elf_core_copy_task_fpregs(struct task_st
 	if (!tsk_used_math(tsk))
 		return 0;
 	if (!regs)
-		regs = ((struct pt_regs *)tsk->thread.rsp0) - 1;
+		regs = task_pt_regs(tsk);
 	if (tsk == current)
 		unlazy_fpu(tsk);
 	set_fs(KERNEL_DS); 
@@ -233,7 +232,7 @@ elf_core_copy_task_fpregs(struct task_st
 static inline int 
 elf_core_copy_task_xfpregs(struct task_struct *t, elf_fpxregset_t *xfpu)
 {
-	struct pt_regs *regs = ((struct pt_regs *)(t->thread.rsp0))-1; 
+	struct pt_regs *regs = task_pt_regs(t);
 	if (!tsk_used_math(t))
 		return 0;
 	if (t == current)
diff --git a/arch/x86_64/ia32/ptrace32.c b/arch/x86_64/ia32/ptrace32.c
index 2a925e2..4fec831 100644
--- a/arch/x86_64/ia32/ptrace32.c
+++ b/arch/x86_64/ia32/ptrace32.c
@@ -38,7 +38,7 @@
 static int putreg32(struct task_struct *child, unsigned regno, u32 val)
 {
 	int i;
-	__u64 *stack = (__u64 *)(child->thread.rsp0 - sizeof(struct pt_regs)); 
+	__u64 *stack = (__u64 *)task_pt_regs(child);
 
 	switch (regno) {
 	case offsetof(struct user32, regs.fs):
@@ -134,7 +134,7 @@ static int putreg32(struct task_struct *
 
 static int getreg32(struct task_struct *child, unsigned regno, u32 *val)
 {
-	__u64 *stack = (__u64 *)(child->thread.rsp0 - sizeof(struct pt_regs)); 
+	__u64 *stack = (__u64 *)task_pt_regs(child);
 
 	switch (regno) {
 	case offsetof(struct user32, regs.fs):
@@ -258,7 +258,7 @@ asmlinkage long sys32_ptrace(long reques
 	if (!child)
 		return ret;
 
-	childregs = (struct pt_regs *)(child->thread.rsp0 - sizeof(struct pt_regs)); 
+	childregs = task_pt_regs(child);
 
 	switch (request) {
 	case PTRACE_PEEKDATA:
diff --git a/arch/x86_64/kernel/process.c b/arch/x86_64/kernel/process.c
index d0cfcc2..08e578f 100644
--- a/arch/x86_64/kernel/process.c
+++ b/arch/x86_64/kernel/process.c
@@ -794,8 +794,7 @@ int dump_task_regs(struct task_struct *t
 {
 	struct pt_regs *pp, ptregs;
 
-	pp = (struct pt_regs *)(tsk->thread.rsp0);
-	--pp; 
+	pp = task_pt_regs(tsk);
 
 	ptregs = *pp; 
 	ptregs.cs &= 0xffff;
diff --git a/arch/x86_64/kernel/ptrace.c b/arch/x86_64/kernel/ptrace.c
index a87b6ce..395b7e7 100644
--- a/arch/x86_64/kernel/ptrace.c
+++ b/arch/x86_64/kernel/ptrace.c
@@ -64,12 +64,6 @@ static inline unsigned long get_stack_lo
 	return (*((unsigned long *)stack));
 }
 
-static inline struct pt_regs *get_child_regs(struct task_struct *task)
-{
-	struct pt_regs *regs = (void *)task->thread.rsp0;
-	return regs - 1;
-}
-
 /*
  * this routine will put a word on the processes privileged stack. 
  * the offset is how far from the base addr as stored in the TSS.  
@@ -167,7 +161,7 @@ static int is_at_popf(struct task_struct
 
 static void set_singlestep(struct task_struct *child)
 {
-	struct pt_regs *regs = get_child_regs(child);
+	struct pt_regs *regs = task_pt_regs(child);
 
 	/*
 	 * Always set TIF_SINGLESTEP - this guarantees that
@@ -205,7 +199,7 @@ static void clear_singlestep(struct task
 
 	/* But touch TF only if it was set by us.. */
 	if (child->ptrace & PT_DTRACE) {
-		struct pt_regs *regs = get_child_regs(child);
+		struct pt_regs *regs = task_pt_regs(child);
 		regs->eflags &= ~TRAP_FLAG;
 		child->ptrace &= ~PT_DTRACE;
 	}
diff --git a/arch/x86_64/kernel/traps.c b/arch/x86_64/kernel/traps.c
index 96a56c0..4926378 100644
--- a/arch/x86_64/kernel/traps.c
+++ b/arch/x86_64/kernel/traps.c
@@ -620,7 +620,7 @@ asmlinkage struct pt_regs *sync_regs(str
 		;
 	/* Exception from user space */
 	else if (user_mode(eregs))
-		regs = ((struct pt_regs *)current->thread.rsp0) - 1;
+		regs = task_pt_regs(current);
 	/* Exception from kernel and interrupts are enabled. Move to
  	   kernel process stack. */
 	else if (eregs->eflags & X86_EFLAGS_IF)
diff --git a/include/asm-x86_64/compat.h b/include/asm-x86_64/compat.h
index f0155c3..e263890 100644
--- a/include/asm-x86_64/compat.h
+++ b/include/asm-x86_64/compat.h
@@ -198,7 +198,7 @@ static inline compat_uptr_t ptr_to_compa
 
 static __inline__ void __user *compat_alloc_user_space(long len)
 {
-	struct pt_regs *regs = (void *)current->thread.rsp0 - sizeof(struct pt_regs); 
+	struct pt_regs *regs = task_pt_regs(current);
 	return (void __user *)regs->rsp - len; 
 }
 
diff --git a/include/asm-x86_64/processor.h b/include/asm-x86_64/processor.h
index 4861246..ed068bb 100644
--- a/include/asm-x86_64/processor.h
+++ b/include/asm-x86_64/processor.h
@@ -317,8 +317,8 @@ extern long kernel_thread(int (*fn)(void
 #define thread_saved_pc(t) (*(unsigned long *)((t)->thread.rsp - 8))
 
 extern unsigned long get_wchan(struct task_struct *p);
-#define KSTK_EIP(tsk) \
-	(((struct pt_regs *)(tsk->thread.rsp0 - sizeof(struct pt_regs)))->rip)
+#define task_pt_regs(tsk) ((struct pt_regs *)(tsk)->thread.rsp0 - 1)
+#define KSTK_EIP(tsk) (task_pt_regs(tsk)->rip)
 #define KSTK_ESP(tsk) -1 /* sorry. doesn't work for syscall. */
 
 
-- 
0.99.9.GIT

