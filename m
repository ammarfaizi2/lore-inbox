Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262239AbVAOH6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbVAOH6D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 02:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbVAOH6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 02:58:03 -0500
Received: from palrel13.hp.com ([156.153.255.238]:61621 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262239AbVAOH5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 02:57:14 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16872.52439.897466.910029@napali.hpl.hp.com>
Date: Fri, 14 Jan 2005 23:57:11 -0800
To: tony.luck@intel.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch] clean up pt_regs accesses
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces the idiom:

	func (args..., long stack) {
		struct pt_regs *regs = (struct pt_regs *) &stack;

with the more commonly used:

	func (args..., struct pt_regs regs) {

The latter didn't used to work with the very earliest kernels and
compilers (anybody remember egcs?) but gcc-3.3 and probably even
gcc-2.96 don't have a problem with it anymore.

The change also makes sparse happier, since it doesn't like it when
you access memory past the end of the declared size of that variable...

With this patch, the ia64-specific sparse warnings are now down to:

 arch/ia64/ia32/../../../fs/binfmt_elf.c:1073:33: warning: incorrect type in argument 2 (different address spaces)
 arch/ia64/kernel/mca_drv.c:430:4: warning: invalid access past the end of 'mca_handler_bhhook' (8 8)
 arch/ia64/kernel/mca_drv.c:430:4: warning: invalid access past the end of 'mca_handler_bhhook' (8 8)
 arch/ia64/kernel/mca_drv.c:430:4: warning: invalid access past the end of 'mca_handler_bhhook' (8 8)
 arch/ia64/hp/common/sba_iommu.c:240:40: warning: marked inline, but without a definition
 arch/ia64/hp/common/sba_iommu.c:241:38: warning: marked inline, but without a definition
 drivers/pci/pci-sysfs.c:204:16: warning: undefined identifier 'ia64_pci_legacy_read'
 drivers/pci/pci-sysfs.c:227:16: warning: undefined identifier 'ia64_pci_legacy_write'

Somebody else will have to look into these.

	--david

Signed-off-by: David Mosberger-Tang <davidm@hpl.hp.com>

===== arch/ia64/ia32/ia32_signal.c 1.34 vs edited =====
--- 1.34/arch/ia64/ia32/ia32_signal.c	2005-01-04 18:48:19 -08:00
+++ edited/arch/ia64/ia32/ia32_signal.c	2005-01-14 22:49:30 -08:00
@@ -1,7 +1,7 @@
 /*
  * IA32 Architecture-specific signal handling support.
  *
- * Copyright (C) 1999, 2001-2002 Hewlett-Packard Co
+ * Copyright (C) 1999, 2001-2002, 2005 Hewlett-Packard Co
  *	David Mosberger-Tang <davidm@hpl.hp.com>
  * Copyright (C) 1999 Arun Sharma <arun.sharma@intel.com>
  * Copyright (C) 2000 VA Linux Co
@@ -970,11 +970,10 @@
 }
 
 asmlinkage long
-sys32_sigreturn (int arg0, int arg1, int arg2, int arg3, int arg4, int arg5, int arg6, int arg7,
-		 unsigned long stack)
+sys32_sigreturn (int arg0, int arg1, int arg2, int arg3, int arg4, int arg5,
+		 int arg6, int arg7, struct pt_regs regs)
 {
-	struct pt_regs *regs = (struct pt_regs *) &stack;
-	unsigned long esp = (unsigned int) regs->r12;
+	unsigned long esp = (unsigned int) regs.r12;
 	struct sigframe_ia32 __user *frame = (struct sigframe_ia32 __user *)(esp - 8);
 	sigset_t set;
 	int eax;
@@ -993,7 +992,7 @@
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
 
-	if (restore_sigcontext_ia32(regs, &frame->sc, &eax))
+	if (restore_sigcontext_ia32(&regs, &frame->sc, &eax))
 		goto badframe;
 	return eax;
 
@@ -1003,11 +1002,10 @@
 }
 
 asmlinkage long
-sys32_rt_sigreturn (int arg0, int arg1, int arg2, int arg3, int arg4, int arg5, int arg6, int arg7,
-		    unsigned long stack)
+sys32_rt_sigreturn (int arg0, int arg1, int arg2, int arg3, int arg4,
+		    int arg5, int arg6, int arg7, struct pt_regs regs)
 {
-	struct pt_regs *regs = (struct pt_regs *) &stack;
-	unsigned long esp = (unsigned int) regs->r12;
+	unsigned long esp = (unsigned int) regs.r12;
 	struct rt_sigframe_ia32 __user *frame = (struct rt_sigframe_ia32 __user *)(esp - 4);
 	sigset_t set;
 	int eax;
@@ -1023,7 +1021,7 @@
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
 
-	if (restore_sigcontext_ia32(regs, &frame->uc.uc_mcontext, &eax))
+	if (restore_sigcontext_ia32(&regs, &frame->uc.uc_mcontext, &eax))
 		goto badframe;
 
 	/* It is more difficult to avoid calling this function than to
===== arch/ia64/ia32/sys_ia32.c 1.111 vs edited =====
--- 1.111/arch/ia64/ia32/sys_ia32.c	2005-01-11 15:58:41 -08:00
+++ edited/arch/ia64/ia32/sys_ia32.c	2005-01-14 23:26:05 -08:00
@@ -6,7 +6,7 @@
  * Copyright (C) 1999		Arun Sharma <arun.sharma@intel.com>
  * Copyright (C) 1997,1998	Jakub Jelinek (jj@sunsite.mff.cuni.cz)
  * Copyright (C) 1997		David S. Miller (davem@caip.rutgers.edu)
- * Copyright (C) 2000-2003 Hewlett-Packard Co
+ * Copyright (C) 2000-2003, 2005 Hewlett-Packard Co
  *	David Mosberger-Tang <davidm@hpl.hp.com>
  * Copyright (C) 2004		Gordon Jin <gordon.jin@intel.com>
  *
@@ -1436,7 +1436,7 @@
 }
 
 static unsigned int
-ia32_peek (struct pt_regs *regs, struct task_struct *child, unsigned long addr, unsigned int *val)
+ia32_peek (struct task_struct *child, unsigned long addr, unsigned int *val)
 {
 	size_t copied;
 	unsigned int ret;
@@ -1446,7 +1446,7 @@
 }
 
 static unsigned int
-ia32_poke (struct pt_regs *regs, struct task_struct *child, unsigned long addr, unsigned int val)
+ia32_poke (struct task_struct *child, unsigned long addr, unsigned int val)
 {
 
 	if (access_process_vm(child, addr, &val, sizeof(val), 1) != sizeof(val))
@@ -1751,25 +1751,16 @@
 	return 0;
 }
 
-/*
- *  Note that the IA32 version of `ptrace' calls the IA64 routine for
- *    many of the requests.  This will only work for requests that do
- *    not need access to the calling processes `pt_regs' which is located
- *    at the address of `stack'.  Once we call the IA64 `sys_ptrace' then
- *    the address of `stack' will not be the address of the `pt_regs'.
- */
 asmlinkage long
-sys32_ptrace (int request, pid_t pid, unsigned int addr, unsigned int data,
-	      long arg4, long arg5, long arg6, long arg7, long stack)
+sys32_ptrace (int request, pid_t pid, unsigned int addr, unsigned int data)
 {
-	struct pt_regs *regs = (struct pt_regs *) &stack;
 	struct task_struct *child;
 	unsigned int value, tmp;
 	long i, ret;
 
 	lock_kernel();
 	if (request == PTRACE_TRACEME) {
-		ret = sys_ptrace(request, pid, addr, data, arg4, arg5, arg6, arg7, stack);
+		ret = sys_ptrace(request, pid, addr, data);
 		goto out;
 	}
 
@@ -1786,7 +1777,7 @@
 		goto out_tsk;
 
 	if (request == PTRACE_ATTACH) {
-		ret = sys_ptrace(request, pid, addr, data, arg4, arg5, arg6, arg7, stack);
+		ret = sys_ptrace(request, pid, addr, data);
 		goto out_tsk;
 	}
 
@@ -1797,7 +1788,7 @@
 	switch (request) {
 	      case PTRACE_PEEKTEXT:
 	      case PTRACE_PEEKDATA:	/* read word at location addr */
-		ret = ia32_peek(regs, child, addr, &value);
+		ret = ia32_peek(child, addr, &value);
 		if (ret == 0)
 			ret = put_user(value, (unsigned int __user *) compat_ptr(data));
 		else
@@ -1806,7 +1797,7 @@
 
 	      case PTRACE_POKETEXT:
 	      case PTRACE_POKEDATA:	/* write the word at location addr */
-		ret = ia32_poke(regs, child, addr, data);
+		ret = ia32_poke(child, addr, data);
 		goto out_tsk;
 
 	      case PTRACE_PEEKUSR:	/* read word at addr in USER area */
@@ -1882,7 +1873,7 @@
 	      case PTRACE_KILL:
 	      case PTRACE_SINGLESTEP:	/* execute chile for one instruction */
 	      case PTRACE_DETACH:	/* detach a process */
-		ret = sys_ptrace(request, pid, addr, data, arg4, arg5, arg6, arg7, stack);
+		ret = sys_ptrace(request, pid, addr, data);
 		break;
 
 	      default:
@@ -1905,9 +1896,9 @@
 
 asmlinkage long
 sys32_sigaltstack (ia32_stack_t __user *uss32, ia32_stack_t __user *uoss32,
-		   long arg2, long arg3, long arg4, long arg5, long arg6, long arg7, long stack)
+		   long arg2, long arg3, long arg4, long arg5, long arg6,
+		   long arg7, struct pt_regs pt)
 {
-	struct pt_regs *pt = (struct pt_regs *) &stack;
 	stack_t uss, uoss;
 	ia32_stack_t buf32;
 	int ret;
@@ -1928,7 +1919,7 @@
 	}
 	set_fs(KERNEL_DS);
 	ret = do_sigaltstack(uss32 ? (stack_t __user *) &uss : NULL,
-			     (stack_t __user *) &uoss, pt->r12);
+			     (stack_t __user *) &uoss, pt.r12);
  	current->sas_ss_size = buf32.ss_size;
 	set_fs(old_fs);
 out:
===== arch/ia64/kernel/perfmon.c 1.104 vs edited =====
--- 1.104/arch/ia64/kernel/perfmon.c	2004-12-28 13:20:10 -08:00
+++ edited/arch/ia64/kernel/perfmon.c	2005-01-14 23:10:19 -08:00
@@ -5,13 +5,13 @@
  * The initial version of perfmon.c was written by
  * Ganesh Venkitachalam, IBM Corp.
  *
- * Then it was modified for perfmon-1.x by Stephane Eranian and 
+ * Then it was modified for perfmon-1.x by Stephane Eranian and
  * David Mosberger, Hewlett Packard Co.
- * 
+ *
  * Version Perfmon-2.x is a rewrite of perfmon-1.x
- * by Stephane Eranian, Hewlett Packard Co. 
+ * by Stephane Eranian, Hewlett Packard Co.
  *
- * Copyright (C) 1999-2003  Hewlett Packard Co
+ * Copyright (C) 1999-2003, 2005  Hewlett Packard Co
  *               Stephane Eranian <eranian@hpl.hp.com>
  *               David Mosberger-Tang <davidm@hpl.hp.com>
  *
@@ -4778,10 +4778,8 @@
  * system-call entry point (must return long)
  */
 asmlinkage long
-sys_perfmonctl (int fd, int cmd, void __user *arg, int count, long arg5, long arg6, long arg7,
-		long arg8, long stack)
+sys_perfmonctl (int fd, int cmd, void __user *arg, int count)
 {
-	struct pt_regs *regs = (struct pt_regs *)&stack;
 	struct file *file = NULL;
 	pfm_context_t *ctx = NULL;
 	unsigned long flags = 0UL;
@@ -4905,7 +4903,7 @@
 	if (unlikely(ret)) goto abort_locked;
 
 skip_fd:
-	ret = (*func)(ctx, args_k, count, regs);
+	ret = (*func)(ctx, args_k, count, ia64_task_regs(current));
 
 	call_made = 1;
 
@@ -6671,8 +6669,7 @@
 }
 #else  /* !CONFIG_PERFMON */
 asmlinkage long
-sys_perfmonctl (int fd, int cmd, void *arg, int count, long arg5, long arg6, long arg7,
-		long arg8, long stack)
+sys_perfmonctl (int fd, int cmd, void *arg, int count)
 {
 	return -ENOSYS;
 }
===== arch/ia64/kernel/ptrace.c 1.41 vs edited =====
--- 1.41/arch/ia64/kernel/ptrace.c	2005-01-12 23:34:46 -08:00
+++ edited/arch/ia64/kernel/ptrace.c	2005-01-14 22:57:58 -08:00
@@ -1384,10 +1384,9 @@
 }
 
 asmlinkage long
-sys_ptrace (long request, pid_t pid, unsigned long addr, unsigned long data,
-	    long arg4, long arg5, long arg6, long arg7, long stack)
+sys_ptrace (long request, pid_t pid, unsigned long addr, unsigned long data)
 {
-	struct pt_regs *pt, *regs = (struct pt_regs *) &stack;
+	struct pt_regs *pt;
 	unsigned long urbs_end, peek_or_poke;
 	struct task_struct *child;
 	struct switch_stack *sw;
@@ -1449,7 +1448,7 @@
 		if (ret == 0) {
 			ret = data;
 			/* ensure "ret" is not mistaken as an error code: */
-			regs->r8 = 0;
+			force_successful_syscall_return();
 		}
 		goto out_tsk;
 
@@ -1468,7 +1467,7 @@
 		}
 		ret = data;
 		/* ensure "ret" is not mistaken as an error code */
-		regs->r8 = 0;
+		force_successful_syscall_return();
 		goto out_tsk;
 
 	      case PTRACE_POKEUSR:
@@ -1612,16 +1611,16 @@
 
 asmlinkage void
 syscall_trace_enter (long arg0, long arg1, long arg2, long arg3,
-		     long arg4, long arg5, long arg6, long arg7, long stack)
+		     long arg4, long arg5, long arg6, long arg7,
+		     struct pt_regs regs)
 {
-	struct pt_regs *regs = (struct pt_regs *) &stack;
 	long syscall;
 
 	if (unlikely(current->audit_context)) {
-		if (IS_IA32_PROCESS(regs))
-			syscall = regs->r1;
+		if (IS_IA32_PROCESS(&regs))
+			syscall = regs.r1;
 		else
-			syscall = regs->r15;
+			syscall = regs.r15;
 
 		audit_syscall_entry(current, syscall, arg0, arg1, arg2, arg3);
 	}
@@ -1635,10 +1634,11 @@
 
 asmlinkage void
 syscall_trace_leave (long arg0, long arg1, long arg2, long arg3,
-		     long arg4, long arg5, long arg6, long arg7, long stack)
+		     long arg4, long arg5, long arg6, long arg7,
+		     struct pt_regs regs)
 {
 	if (unlikely(current->audit_context))
-		audit_syscall_exit(current, ((struct pt_regs *) &stack)->r8);
+		audit_syscall_exit(current, regs.r8);
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE)
 	    && (current->ptrace & PT_PTRACED))
===== arch/ia64/kernel/signal.c 1.47 vs edited =====
--- 1.47/arch/ia64/kernel/signal.c	2004-11-10 15:48:43 -08:00
+++ edited/arch/ia64/kernel/signal.c	2005-01-14 23:34:16 -08:00
@@ -84,12 +84,11 @@
 }
 
 asmlinkage long
-sys_sigaltstack (const stack_t __user *uss, stack_t __user *uoss, long arg2, long arg3, long arg4,
-		 long arg5, long arg6, long arg7, long stack)
+sys_sigaltstack (const stack_t __user *uss, stack_t __user *uoss, long arg2,
+		 long arg3, long arg4, long arg5, long arg6, long arg7,
+		 struct pt_regs regs)
 {
-	struct pt_regs *pt = (struct pt_regs *) &stack;
-
-	return do_sigaltstack(uss, uoss, pt->r12);
+	return do_sigaltstack(uss, uoss, regs.r12);
 }
 
 static long
===== arch/ia64/kernel/sys_ia64.c 1.32 vs edited =====
--- 1.32/arch/ia64/kernel/sys_ia64.c	2004-10-18 22:26:36 -07:00
+++ edited/arch/ia64/kernel/sys_ia64.c	2005-01-14 23:02:51 -08:00
@@ -2,7 +2,7 @@
  * This file contains various system calls that have different calling
  * conventions on different platforms.
  *
- * Copyright (C) 1999-2000, 2002-2003 Hewlett-Packard Co
+ * Copyright (C) 1999-2000, 2002-2003, 2005 Hewlett-Packard Co
  *	David Mosberger-Tang <davidm@hpl.hp.com>
  */
 #include <linux/config.h>
@@ -163,10 +163,9 @@
  * and r9) as this is faster than doing a copy_to_user().
  */
 asmlinkage long
-sys_pipe (long arg0, long arg1, long arg2, long arg3,
-	  long arg4, long arg5, long arg6, long arg7, long stack)
+sys_pipe (void)
 {
-	struct pt_regs *regs = (struct pt_regs *) &stack;
+	struct pt_regs *regs = ia64_task_regs(current);
 	int fd[2];
 	int retval;
 
===== arch/ia64/kernel/traps.c 1.47 vs edited =====
--- 1.47/arch/ia64/kernel/traps.c	2004-10-05 11:27:40 -07:00
+++ edited/arch/ia64/kernel/traps.c	2005-01-14 23:41:36 -08:00
@@ -358,11 +358,10 @@
 };
 
 struct illegal_op_return
-ia64_illegal_op_fault (unsigned long ec, unsigned long arg1, unsigned long arg2,
-		       unsigned long arg3, unsigned long arg4, unsigned long arg5,
-		       unsigned long arg6, unsigned long arg7, unsigned long stack)
+ia64_illegal_op_fault (unsigned long ec, long arg1, long arg2, long arg3,
+		       long arg4, long arg5, long arg6, long arg7,
+		       struct pt_regs regs)
 {
-	struct pt_regs *regs = (struct pt_regs *) &stack;
 	struct illegal_op_return rv;
 	struct siginfo si;
 	char buf[128];
@@ -371,19 +370,19 @@
 	{
 		extern struct illegal_op_return ia64_emulate_brl (struct pt_regs *, unsigned long);
 
-		rv = ia64_emulate_brl(regs, ec);
+		rv = ia64_emulate_brl(&regs, ec);
 		if (rv.fkt != (unsigned long) -1)
 			return rv;
 	}
 #endif
 
 	sprintf(buf, "IA-64 Illegal operation fault");
-	die_if_kernel(buf, regs, 0);
+	die_if_kernel(buf, &regs, 0);
 
 	memset(&si, 0, sizeof(si));
 	si.si_signo = SIGILL;
 	si.si_code = ILL_ILLOPC;
-	si.si_addr = (void __user *) (regs->cr_iip + ia64_psr(regs)->ri);
+	si.si_addr = (void __user *) (regs.cr_iip + ia64_psr(&regs)->ri);
 	force_sig_info(SIGILL, &si, current);
 	rv.fkt = 0;
 	return rv;
@@ -391,11 +390,10 @@
 
 void
 ia64_fault (unsigned long vector, unsigned long isr, unsigned long ifa,
-	    unsigned long iim, unsigned long itir, unsigned long arg5,
-	    unsigned long arg6, unsigned long arg7, unsigned long stack)
+	    unsigned long iim, unsigned long itir, long arg5, long arg6,
+	    long arg7, struct pt_regs regs)
 {
-	struct pt_regs *regs = (struct pt_regs *) &stack;
-	unsigned long code, error = isr;
+	unsigned long code, error = isr, iip;
 	struct siginfo siginfo;
 	char buf[128];
 	int result, sig;
@@ -415,10 +413,12 @@
 		 * This fault was due to lfetch.fault, set "ed" bit in the psr to cancel
 		 * the lfetch.
 		 */
-		ia64_psr(regs)->ed = 1;
+		ia64_psr(&regs)->ed = 1;
 		return;
 	}
 
+	iip = regs.cr_iip + ia64_psr(&regs)->ri;
+
 	switch (vector) {
 	      case 24: /* General Exception */
 		code = (isr >> 4) & 0xf;
@@ -428,8 +428,8 @@
 		if (code == 8) {
 # ifdef CONFIG_IA64_PRINT_HAZARDS
 			printk("%s[%d]: possible hazard @ ip=%016lx (pr = %016lx)\n",
-			       current->comm, current->pid, regs->cr_iip + ia64_psr(regs)->ri,
-			       regs->pr);
+			       current->comm, current->pid,
+			       regs.cr_iip + ia64_psr(&regs)->ri, regs.pr);
 # endif
 			return;
 		}
@@ -437,14 +437,14 @@
 
 	      case 25: /* Disabled FP-Register */
 		if (isr & 2) {
-			disabled_fph_fault(regs);
+			disabled_fph_fault(&regs);
 			return;
 		}
 		sprintf(buf, "Disabled FPL fault---not supposed to happen!");
 		break;
 
 	      case 26: /* NaT Consumption */
-		if (user_mode(regs)) {
+		if (user_mode(&regs)) {
 			void __user *addr;
 
 			if (((isr >> 4) & 0xf) == 2) {
@@ -456,7 +456,8 @@
 				/* register NaT consumption */
 				sig = SIGILL;
 				code = ILL_ILLOPN;
-				addr = (void __user *) (regs->cr_iip + ia64_psr(regs)->ri);
+				addr = (void __user *) (regs.cr_iip
+							+ ia64_psr(&regs)->ri);
 			}
 			siginfo.si_signo = sig;
 			siginfo.si_code = code;
@@ -467,17 +468,17 @@
 			siginfo.si_isr = isr;
 			force_sig_info(sig, &siginfo, current);
 			return;
-		} else if (ia64_done_with_exception(regs))
+		} else if (ia64_done_with_exception(&regs))
 			return;
 		sprintf(buf, "NaT consumption");
 		break;
 
 	      case 31: /* Unsupported Data Reference */
-		if (user_mode(regs)) {
+		if (user_mode(&regs)) {
 			siginfo.si_signo = SIGILL;
 			siginfo.si_code = ILL_ILLOPN;
 			siginfo.si_errno = 0;
-			siginfo.si_addr = (void __user *) (regs->cr_iip + ia64_psr(regs)->ri);
+			siginfo.si_addr = (void __user *) iip;
 			siginfo.si_imm = vector;
 			siginfo.si_flags = __ISR_VALID;
 			siginfo.si_isr = isr;
@@ -490,7 +491,7 @@
 	      case 29: /* Debug */
 	      case 35: /* Taken Branch Trap */
 	      case 36: /* Single Step Trap */
-		if (fsys_mode(current, regs)) {
+		if (fsys_mode(current, &regs)) {
 			extern char __kernel_syscall_via_break[];
 			/*
 			 * Got a trap in fsys-mode: Taken Branch Trap and Single Step trap
@@ -498,13 +499,13 @@
 			 */
 			if (unlikely(vector == 29)) {
 				die("Got debug trap in fsys-mode---not supposed to happen!",
-				    regs, 0);
+				    &regs, 0);
 				return;
 			}
 			/* re-do the system call via break 0x100000: */
-			regs->cr_iip = (unsigned long) __kernel_syscall_via_break;
-			ia64_psr(regs)->ri = 0;
-			ia64_psr(regs)->cpl = 3;
+			regs.cr_iip = (unsigned long) __kernel_syscall_via_break;
+			ia64_psr(&regs)->ri = 0;
+			ia64_psr(&regs)->cpl = 3;
 			return;
 		}
 		switch (vector) {
@@ -515,8 +516,8 @@
 			 * Erratum 10 (IFA may contain incorrect address) now has
 			 * "NoFix" status.  There are no plans for fixing this.
 			 */
-			if (ia64_psr(regs)->is == 0)
-			  ifa = regs->cr_iip;
+			if (ia64_psr(&regs)->is == 0)
+			  ifa = regs.cr_iip;
 #endif
 			break;
 		      case 35: siginfo.si_code = TRAP_BRANCH; ifa = 0; break;
@@ -533,12 +534,12 @@
 
 	      case 32: /* fp fault */
 	      case 33: /* fp trap */
-		result = handle_fpu_swa((vector == 32) ? 1 : 0, regs, isr);
+		result = handle_fpu_swa((vector == 32) ? 1 : 0, &regs, isr);
 		if ((result < 0) || (current->thread.flags & IA64_THREAD_FPEMU_SIGFPE)) {
 			siginfo.si_signo = SIGFPE;
 			siginfo.si_errno = 0;
 			siginfo.si_code = FPE_FLTINV;
-			siginfo.si_addr = (void __user *) (regs->cr_iip + ia64_psr(regs)->ri);
+			siginfo.si_addr = (void __user *) iip;
 			siginfo.si_flags = __ISR_VALID;
 			siginfo.si_isr = isr;
 			siginfo.si_imm = 0;
@@ -554,19 +555,18 @@
 			 * interesting work (e.g., signal delivery is done in the kernel
 			 * exit path).
 			 */
-			ia64_psr(regs)->lp = 0;
+			ia64_psr(&regs)->lp = 0;
 			return;
 		} else {
 			/* Unimplemented Instr. Address Trap */
-			if (user_mode(regs)) {
+			if (user_mode(&regs)) {
 				siginfo.si_signo = SIGILL;
 				siginfo.si_code = ILL_BADIADDR;
 				siginfo.si_errno = 0;
 				siginfo.si_flags = 0;
 				siginfo.si_isr = 0;
 				siginfo.si_imm = 0;
-				siginfo.si_addr = (void __user *)
-					(regs->cr_iip + ia64_psr(regs)->ri);
+				siginfo.si_addr = (void __user *) iip;
 				force_sig_info(SIGILL, &siginfo, current);
 				return;
 			}
@@ -576,23 +576,23 @@
 
 	      case 45:
 #ifdef CONFIG_IA32_SUPPORT
-		if (ia32_exception(regs, isr) == 0)
+		if (ia32_exception(&regs, isr) == 0)
 			return;
 #endif
 		printk(KERN_ERR "Unexpected IA-32 exception (Trap 45)\n");
 		printk(KERN_ERR "  iip - 0x%lx, ifa - 0x%lx, isr - 0x%lx\n",
-		       regs->cr_iip, ifa, isr);
+		       iip, ifa, isr);
 		force_sig(SIGSEGV, current);
 		break;
 
 	      case 46:
 #ifdef CONFIG_IA32_SUPPORT
-		if (ia32_intercept(regs, isr) == 0)
+		if (ia32_intercept(&regs, isr) == 0)
 			return;
 #endif
 		printk(KERN_ERR "Unexpected IA-32 intercept trap (Trap 46)\n");
 		printk(KERN_ERR "  iip - 0x%lx, ifa - 0x%lx, isr - 0x%lx, iim - 0x%lx\n",
-		       regs->cr_iip, ifa, isr, iim);
+		       iip, ifa, isr, iim);
 		force_sig(SIGSEGV, current);
 		return;
 
@@ -604,6 +604,6 @@
 		sprintf(buf, "Fault %lu", vector);
 		break;
 	}
-	die_if_kernel(buf, regs, error);
+	die_if_kernel(buf, &regs, error);
 	force_sig(SIGILL, current);
 }
===== include/asm-ia64/unistd.h 1.54 vs edited =====
--- 1.54/include/asm-ia64/unistd.h	2005-01-04 18:48:14 -08:00
+++ edited/include/asm-ia64/unistd.h	2005-01-14 23:26:27 -08:00
@@ -4,7 +4,7 @@
 /*
  * IA-64 Linux syscall numbers and inline-functions.
  *
- * Copyright (C) 1998-2004 Hewlett-Packard Co
+ * Copyright (C) 1998-2005 Hewlett-Packard Co
  *	David Mosberger-Tang <davidm@hpl.hp.com>
  */
 
@@ -376,15 +376,13 @@
 struct sigaction;
 asmlinkage long sys_execve(char __user *filename, char __user * __user *argv,
 			   char __user * __user *envp, struct pt_regs *regs);
-asmlinkage long sys_pipe(long arg0, long arg1, long arg2, long arg3,
-			long arg4, long arg5, long arg6, long arg7, long stack);
+asmlinkage long sys_pipe(void);
 asmlinkage long sys_ptrace(long request, pid_t pid,
-			unsigned long addr, unsigned long data,
-			long arg4, long arg5, long arg6, long arg7, long stack);
+			   unsigned long addr, unsigned long data);
 asmlinkage long sys_rt_sigaction(int sig,
-				const struct sigaction __user *act,
-				struct sigaction __user *oact,
-				size_t sigsetsize);
+				 const struct sigaction __user *act,
+				 struct sigaction __user *oact,
+				 size_t sigsetsize);
 
 /*
  * "Conditional" syscalls
