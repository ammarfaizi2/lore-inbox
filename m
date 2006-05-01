Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWEAK3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWEAK3O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 06:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWEAK3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 06:29:13 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:5000 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751173AbWEAK3E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 06:29:04 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 05/14] drop task argument of audit_syscall_{entry,exit}
Message-Id: <E1FaVeJ-00051g-Iz@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Mon, 01 May 2006 11:29:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: Wed Mar 29 20:23:36 2006 -0500

... it's always current, and that's a good thing - allows simpler locking.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/i386/kernel/ptrace.c    |    7 +++----
 arch/i386/kernel/vm86.c      |    2 +-
 arch/ia64/kernel/ptrace.c    |    4 ++--
 arch/mips/kernel/ptrace.c    |    4 ++--
 arch/powerpc/kernel/ptrace.c |    5 ++---
 arch/s390/kernel/ptrace.c    |    5 ++---
 arch/sparc64/kernel/ptrace.c |    5 ++---
 arch/um/kernel/ptrace.c      |    6 ++----
 arch/x86_64/kernel/ptrace.c  |    6 +++---
 include/linux/audit.h        |    8 ++++----
 kernel/auditsc.c             |    8 ++++----
 11 files changed, 27 insertions(+), 33 deletions(-)

5411be59db80333039386f3b1ccfe5eb9023a916
diff --git a/arch/i386/kernel/ptrace.c b/arch/i386/kernel/ptrace.c
index 506462e..fd7eaf7 100644
--- a/arch/i386/kernel/ptrace.c
+++ b/arch/i386/kernel/ptrace.c
@@ -671,7 +671,7 @@ int do_syscall_trace(struct pt_regs *reg
 
 	if (unlikely(current->audit_context)) {
 		if (entryexit)
-			audit_syscall_exit(current, AUDITSC_RESULT(regs->eax),
+			audit_syscall_exit(AUDITSC_RESULT(regs->eax),
 						regs->eax);
 		/* Debug traps, when using PTRACE_SINGLESTEP, must be sent only
 		 * on the syscall exit path. Normally, when TIF_SYSCALL_AUDIT is
@@ -720,14 +720,13 @@ int do_syscall_trace(struct pt_regs *reg
 	ret = is_sysemu;
 out:
 	if (unlikely(current->audit_context) && !entryexit)
-		audit_syscall_entry(current, AUDIT_ARCH_I386, regs->orig_eax,
+		audit_syscall_entry(AUDIT_ARCH_I386, regs->orig_eax,
 				    regs->ebx, regs->ecx, regs->edx, regs->esi);
 	if (ret == 0)
 		return 0;
 
 	regs->orig_eax = -1; /* force skip of syscall restarting */
 	if (unlikely(current->audit_context))
-		audit_syscall_exit(current, AUDITSC_RESULT(regs->eax),
-				regs->eax);
+		audit_syscall_exit(AUDITSC_RESULT(regs->eax), regs->eax);
 	return 1;
 }
diff --git a/arch/i386/kernel/vm86.c b/arch/i386/kernel/vm86.c
index aee14fa..00e0118 100644
--- a/arch/i386/kernel/vm86.c
+++ b/arch/i386/kernel/vm86.c
@@ -312,7 +312,7 @@ static void do_sys_vm86(struct kernel_vm
 
 	/*call audit_syscall_exit since we do not exit via the normal paths */
 	if (unlikely(current->audit_context))
-		audit_syscall_exit(current, AUDITSC_RESULT(eax), eax);
+		audit_syscall_exit(AUDITSC_RESULT(eax), eax);
 
 	__asm__ __volatile__(
 		"movl %0,%%esp\n\t"
diff --git a/arch/ia64/kernel/ptrace.c b/arch/ia64/kernel/ptrace.c
index 9887c87..e61e15e 100644
--- a/arch/ia64/kernel/ptrace.c
+++ b/arch/ia64/kernel/ptrace.c
@@ -1644,7 +1644,7 @@ syscall_trace_enter (long arg0, long arg
 			arch = AUDIT_ARCH_IA64;
 		}
 
-		audit_syscall_entry(current, arch, syscall, arg0, arg1, arg2, arg3);
+		audit_syscall_entry(arch, syscall, arg0, arg1, arg2, arg3);
 	}
 
 }
@@ -1662,7 +1662,7 @@ syscall_trace_leave (long arg0, long arg
 
 		if (success != AUDITSC_SUCCESS)
 			result = -result;
-		audit_syscall_exit(current, success, result);
+		audit_syscall_exit(success, result);
 	}
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE)
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index f3106d0..9b4733c 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -483,7 +483,7 @@ #endif
 asmlinkage void do_syscall_trace(struct pt_regs *regs, int entryexit)
 {
 	if (unlikely(current->audit_context) && entryexit)
-		audit_syscall_exit(current, AUDITSC_RESULT(regs->regs[2]),
+		audit_syscall_exit(AUDITSC_RESULT(regs->regs[2]),
 		                   regs->regs[2]);
 
 	if (!(current->ptrace & PT_PTRACED))
@@ -507,7 +507,7 @@ asmlinkage void do_syscall_trace(struct 
 	}
  out:
 	if (unlikely(current->audit_context) && !entryexit)
-		audit_syscall_entry(current, audit_arch(), regs->regs[2],
+		audit_syscall_entry(audit_arch(), regs->regs[2],
 				    regs->regs[4], regs->regs[5],
 				    regs->regs[6], regs->regs[7]);
 }
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index bcb8357..4a677d1 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -538,7 +538,7 @@ #endif
 		do_syscall_trace();
 
 	if (unlikely(current->audit_context))
-		audit_syscall_entry(current,
+		audit_syscall_entry(
 #ifdef CONFIG_PPC32
 				    AUDIT_ARCH_PPC,
 #else
@@ -556,8 +556,7 @@ #ifdef CONFIG_PPC32
 #endif
 
 	if (unlikely(current->audit_context))
-		audit_syscall_exit(current,
-				   (regs->ccr&0x1000)?AUDITSC_FAILURE:AUDITSC_SUCCESS,
+		audit_syscall_exit((regs->ccr&0x1000)?AUDITSC_FAILURE:AUDITSC_SUCCESS,
 				   regs->result);
 
 	if ((test_thread_flag(TIF_SYSCALL_TRACE)
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 37dfe33..8f36504 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -734,7 +734,7 @@ asmlinkage void
 syscall_trace(struct pt_regs *regs, int entryexit)
 {
 	if (unlikely(current->audit_context) && entryexit)
-		audit_syscall_exit(current, AUDITSC_RESULT(regs->gprs[2]), regs->gprs[2]);
+		audit_syscall_exit(AUDITSC_RESULT(regs->gprs[2]), regs->gprs[2]);
 
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
 		goto out;
@@ -761,8 +761,7 @@ syscall_trace(struct pt_regs *regs, int 
 	}
  out:
 	if (unlikely(current->audit_context) && !entryexit)
-		audit_syscall_entry(current, 
-				    test_thread_flag(TIF_31BIT)?AUDIT_ARCH_S390:AUDIT_ARCH_S390X,
+		audit_syscall_entry(test_thread_flag(TIF_31BIT)?AUDIT_ARCH_S390:AUDIT_ARCH_S390X,
 				    regs->gprs[2], regs->orig_gpr2, regs->gprs[3],
 				    regs->gprs[4], regs->gprs[5]);
 }
diff --git a/arch/sparc64/kernel/ptrace.c b/arch/sparc64/kernel/ptrace.c
index 49e6ded..d31975e 100644
--- a/arch/sparc64/kernel/ptrace.c
+++ b/arch/sparc64/kernel/ptrace.c
@@ -653,7 +653,7 @@ asmlinkage void syscall_trace(struct pt_
 		if (unlikely(tstate & (TSTATE_XCARRY | TSTATE_ICARRY)))
 			result = AUDITSC_FAILURE;
 
-		audit_syscall_exit(current, result, regs->u_regs[UREG_I0]);
+		audit_syscall_exit(result, regs->u_regs[UREG_I0]);
 	}
 
 	if (!(current->ptrace & PT_PTRACED))
@@ -677,8 +677,7 @@ asmlinkage void syscall_trace(struct pt_
 
 out:
 	if (unlikely(current->audit_context) && !syscall_exit_p)
-		audit_syscall_entry(current,
-				    (test_thread_flag(TIF_32BIT) ?
+		audit_syscall_entry((test_thread_flag(TIF_32BIT) ?
 				     AUDIT_ARCH_SPARC :
 				     AUDIT_ARCH_SPARC64),
 				    regs->u_regs[UREG_G1],
diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index 60d2eda..9a77fb3 100644
--- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -275,15 +275,13 @@ void syscall_trace(union uml_pt_regs *re
 
 	if (unlikely(current->audit_context)) {
 		if (!entryexit)
-			audit_syscall_entry(current,
-                                            HOST_AUDIT_ARCH,
+			audit_syscall_entry(HOST_AUDIT_ARCH,
 					    UPT_SYSCALL_NR(regs),
 					    UPT_SYSCALL_ARG1(regs),
 					    UPT_SYSCALL_ARG2(regs),
 					    UPT_SYSCALL_ARG3(regs),
 					    UPT_SYSCALL_ARG4(regs));
-		else audit_syscall_exit(current,
-                                        AUDITSC_RESULT(UPT_SYSCALL_RET(regs)),
+		else audit_syscall_exit(AUDITSC_RESULT(UPT_SYSCALL_RET(regs)),
                                         UPT_SYSCALL_RET(regs));
 	}
 
diff --git a/arch/x86_64/kernel/ptrace.c b/arch/x86_64/kernel/ptrace.c
index da8e790..2d50024 100644
--- a/arch/x86_64/kernel/ptrace.c
+++ b/arch/x86_64/kernel/ptrace.c
@@ -600,12 +600,12 @@ asmlinkage void syscall_trace_enter(stru
 
 	if (unlikely(current->audit_context)) {
 		if (test_thread_flag(TIF_IA32)) {
-			audit_syscall_entry(current, AUDIT_ARCH_I386,
+			audit_syscall_entry(AUDIT_ARCH_I386,
 					    regs->orig_rax,
 					    regs->rbx, regs->rcx,
 					    regs->rdx, regs->rsi);
 		} else {
-			audit_syscall_entry(current, AUDIT_ARCH_X86_64,
+			audit_syscall_entry(AUDIT_ARCH_X86_64,
 					    regs->orig_rax,
 					    regs->rdi, regs->rsi,
 					    regs->rdx, regs->r10);
@@ -616,7 +616,7 @@ asmlinkage void syscall_trace_enter(stru
 asmlinkage void syscall_trace_leave(struct pt_regs *regs)
 {
 	if (unlikely(current->audit_context))
-		audit_syscall_exit(current, AUDITSC_RESULT(regs->rax), regs->rax);
+		audit_syscall_exit(AUDITSC_RESULT(regs->rax), regs->rax);
 
 	if ((test_thread_flag(TIF_SYSCALL_TRACE)
 	     || test_thread_flag(TIF_SINGLESTEP))
diff --git a/include/linux/audit.h b/include/linux/audit.h
index 1c47c59..39fef6e 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -287,10 +287,10 @@ #ifdef CONFIG_AUDITSYSCALL
 				/* Public API */
 extern int  audit_alloc(struct task_struct *task);
 extern void audit_free(struct task_struct *task);
-extern void audit_syscall_entry(struct task_struct *task, int arch,
+extern void audit_syscall_entry(int arch,
 				int major, unsigned long a0, unsigned long a1,
 				unsigned long a2, unsigned long a3);
-extern void audit_syscall_exit(struct task_struct *task, int failed, long return_code);
+extern void audit_syscall_exit(int failed, long return_code);
 extern void audit_getname(const char *name);
 extern void audit_putname(const char *name);
 extern void __audit_inode(const char *name, const struct inode *inode, unsigned flags);
@@ -323,8 +323,8 @@ extern int audit_set_macxattr(const char
 #else
 #define audit_alloc(t) ({ 0; })
 #define audit_free(t) do { ; } while (0)
-#define audit_syscall_entry(t,ta,a,b,c,d,e) do { ; } while (0)
-#define audit_syscall_exit(t,f,r) do { ; } while (0)
+#define audit_syscall_entry(ta,a,b,c,d,e) do { ; } while (0)
+#define audit_syscall_exit(f,r) do { ; } while (0)
 #define audit_getname(n) do { ; } while (0)
 #define audit_putname(n) do { ; } while (0)
 #define __audit_inode(n,i,f) do { ; } while (0)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index ba0ec1b..7ed82b0 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -736,10 +736,11 @@ void audit_free(struct task_struct *tsk)
  * will only be written if another part of the kernel requests that it
  * be written).
  */
-void audit_syscall_entry(struct task_struct *tsk, int arch, int major,
+void audit_syscall_entry(int arch, int major,
 			 unsigned long a1, unsigned long a2,
 			 unsigned long a3, unsigned long a4)
 {
+	struct task_struct *tsk = current;
 	struct audit_context *context = tsk->audit_context;
 	enum audit_state     state;
 
@@ -817,12 +818,11 @@ #endif
  * message), then write out the syscall information.  In call cases,
  * free the names stored from getname().
  */
-void audit_syscall_exit(struct task_struct *tsk, int valid, long return_code)
+void audit_syscall_exit(int valid, long return_code)
 {
+	struct task_struct *tsk = current;
 	struct audit_context *context;
 
-	/* tsk == current */
-
 	get_task_struct(tsk);
 	task_lock(tsk);
 	context = audit_get_context(tsk, valid, return_code);
-- 
1.3.0.g0080f

