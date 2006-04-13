Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWDMSTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWDMSTy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 14:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWDMSTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 14:19:54 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:37016 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964783AbWDMSTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 14:19:52 -0400
Message-Id: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [RFC] PATCH 3/4 - Time virtualization : PTRACE_SYSCALL_MASK
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 13 Apr 2006 13:20:50 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add PTRACE_SYSCALL_MASK, which allows system calls to be selectively
traced.  It takes a bitmask and a length.  A system call is traced
if its bit is one.  Otherwise, it executes normally, and is
invisible to the ptracing parent.

This is not just useful for UML - strace -e could make good use of it as well.

Index: linux-2.6.17-mm-vtime/arch/um/kernel/ptrace.c
===================================================================
--- linux-2.6.17-mm-vtime.orig/arch/um/kernel/ptrace.c	2006-04-13 13:48:02.000000000 -0400
+++ linux-2.6.17-mm-vtime/arch/um/kernel/ptrace.c	2006-04-13 13:49:32.000000000 -0400
@@ -83,7 +83,7 @@ long arch_ptrace(struct task_struct *chi
                 break;
 
 	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
-	case PTRACE_CONT: { /* restart after signal. */
+	case PTRACE_CONT: /* restart after signal. */
 		ret = -EIO;
 		if (!valid_signal(data))
 			break;
@@ -99,7 +99,9 @@ long arch_ptrace(struct task_struct *chi
 		wake_up_process(child);
 		ret = 0;
 		break;
-	}
+	case PTRACE_SYSCALL_MASK:
+		ret = set_syscall_mask(child, (char __user *) addr, data);
+		break;
 
 /*
  * make the child exit.  Best I can do is send it a sigkill. 
@@ -295,6 +297,12 @@ void syscall_trace(union uml_pt_regs *re
 	if (!(current->ptrace & PT_PTRACED))
 		return;
 
+	if((current->syscall_mask != NULL) &&
+	   ((long) UPT_SYSCALL_NR(regs) != -1) &&
+	   !(current->syscall_mask[UPT_SYSCALL_NR(regs) / (8 * sizeof(long))] &
+	     (1 << (UPT_SYSCALL_NR(regs) % (8 * sizeof(long))))))
+		return;
+
 	/* the 0x80 provides a way for the tracing parent to distinguish
 	   between a syscall stop and SIGTRAP delivery */
 	tracesysgood = (current->ptrace & PT_TRACESYSGOOD);
Index: linux-2.6.17-mm-vtime/include/linux/ptrace.h
===================================================================
--- linux-2.6.17-mm-vtime.orig/include/linux/ptrace.h	2006-04-13 13:48:02.000000000 -0400
+++ linux-2.6.17-mm-vtime/include/linux/ptrace.h	2006-04-13 13:49:32.000000000 -0400
@@ -93,6 +93,8 @@ extern void __ptrace_link(struct task_st
 extern void __ptrace_unlink(struct task_struct *child);
 extern void ptrace_untrace(struct task_struct *child);
 extern int ptrace_may_attach(struct task_struct *task);
+extern int set_syscall_mask(struct task_struct *child, char __user *mask,
+			    unsigned long len);
 
 static inline void ptrace_link(struct task_struct *child,
 			       struct task_struct *new_parent)
Index: linux-2.6.17-mm-vtime/arch/i386/kernel/ptrace.c
===================================================================
--- linux-2.6.17-mm-vtime.orig/arch/i386/kernel/ptrace.c	2006-04-13 13:48:02.000000000 -0400
+++ linux-2.6.17-mm-vtime/arch/i386/kernel/ptrace.c	2006-04-13 13:49:32.000000000 -0400
@@ -500,6 +500,9 @@ long arch_ptrace(struct task_struct *chi
 		ret = 0;
 		break;
 
+	case PTRACE_SYSCALL_MASK:
+		ret = set_syscall_mask(child, (char __user *) addr, data);
+		break;
 /*
  * make the child exit.  Best I can do is send it a sigkill. 
  * perhaps it should be put in the status that it wants to 
@@ -690,6 +693,11 @@ int do_syscall_trace(struct pt_regs *reg
 	if (!(current->ptrace & PT_PTRACED))
 		goto out;
 
+	if((current->syscall_mask != NULL) && ((long) regs->orig_eax != -1) &&
+	   !(current->syscall_mask[regs->orig_eax / (8 * sizeof(long))] &
+	     (1 << (regs->orig_eax % (8 * sizeof(long))))))
+		goto out;
+
 	/* If a process stops on the 1st tracepoint with SYSCALL_TRACE
 	 * and then is resumed with SYSEMU_SINGLESTEP, it will come in
 	 * here. We have to check this and return */
Index: linux-2.6.17-mm-vtime/include/asm-i386/ptrace.h
===================================================================
--- linux-2.6.17-mm-vtime.orig/include/asm-i386/ptrace.h	2006-04-13 13:48:02.000000000 -0400
+++ linux-2.6.17-mm-vtime/include/asm-i386/ptrace.h	2006-04-13 13:49:32.000000000 -0400
@@ -53,6 +53,7 @@ struct pt_regs {
 
 #define PTRACE_GET_THREAD_AREA    25
 #define PTRACE_SET_THREAD_AREA    26
+#define PTRACE_SYSCALL_MASK	  27
 
 #define PTRACE_SYSEMU		  31
 #define PTRACE_SYSEMU_SINGLESTEP  32
Index: linux-2.6.17-mm-vtime/include/linux/sched.h
===================================================================
--- linux-2.6.17-mm-vtime.orig/include/linux/sched.h	2006-04-13 13:49:11.000000000 -0400
+++ linux-2.6.17-mm-vtime/include/linux/sched.h	2006-04-13 13:49:32.000000000 -0400
@@ -899,6 +899,7 @@ struct task_struct {
 
 	unsigned long ptrace_message;
 	siginfo_t *last_siginfo; /* For ptrace use.  */
+	unsigned long *syscall_mask;
 /*
  * current io wait handle: wait queue entry to use for io waits
  * If this thread is processing aio, this points at the waitqueue
Index: linux-2.6.17-mm-vtime/kernel/ptrace.c
===================================================================
--- linux-2.6.17-mm-vtime.orig/kernel/ptrace.c	2006-04-13 13:48:02.000000000 -0400
+++ linux-2.6.17-mm-vtime/kernel/ptrace.c	2006-04-13 13:49:32.000000000 -0400
@@ -21,6 +21,7 @@
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
+#include <asm/unistd.h>
 
 /*
  * ptrace a task: make the debugger its new parent and
@@ -450,6 +451,41 @@ int ptrace_traceme(void)
 	return 0;
 }
 
+int set_syscall_mask(struct task_struct *child, char __user *mask,
+		     unsigned long len)
+{
+	int i, n = (NR_syscalls + 7) / 8;
+	char c;
+
+	if(len > n){
+		for(i = NR_syscalls; i < len * 8; i++){
+			get_user(c, &mask[i / 8]);
+			if(!(c & (1 << (i % 8)))){
+				printk("Out of range syscall at %d\n", i);
+				return -EINVAL;
+			}
+		}
+
+		len = n;
+	}
+
+	if(child->syscall_mask == NULL){
+		child->syscall_mask = kmalloc(n, GFP_KERNEL);
+		if(child->syscall_mask == NULL)
+			return -ENOMEM;
+
+		memset(child->syscall_mask, 0xff, n);
+	}
+
+	/* XXX If this partially fails, we will have a partially updated
+	 * mask.
+	 */
+	if(copy_from_user(child->syscall_mask, mask, len))
+		return -EFAULT;
+
+	return 0;
+}
+
 /**
  * ptrace_get_task_struct  --  grab a task struct reference for ptrace
  * @pid:       process id to grab a task_struct reference of
Index: linux-2.6.17-mm-vtime/include/linux/init_task.h
===================================================================
--- linux-2.6.17-mm-vtime.orig/include/linux/init_task.h	2006-04-13 13:48:32.000000000 -0400
+++ linux-2.6.17-mm-vtime/include/linux/init_task.h	2006-04-13 13:50:21.000000000 -0400
@@ -124,6 +124,7 @@ extern struct group_info init_groups;
 	.journal_info	= NULL,						\
 	.cpu_timers	= INIT_CPU_TIMERS(tsk.cpu_timers),		\
 	.fs_excl	= ATOMIC_INIT(0),				\
+	.syscall_mask	= NULL					\
 	INIT_RT_MUTEXES(tsk)						\
 }
 
Index: linux-2.6.17-mm-vtime/kernel/fork.c
===================================================================
--- linux-2.6.17-mm-vtime.orig/kernel/fork.c	2006-04-13 13:49:11.000000000 -0400
+++ linux-2.6.17-mm-vtime/kernel/fork.c	2006-04-13 13:49:32.000000000 -0400
@@ -1110,6 +1110,7 @@ static task_t *copy_process(unsigned lon
 #ifdef TIF_SYSCALL_EMU
 	clear_tsk_thread_flag(p, TIF_SYSCALL_EMU);
 #endif
+	p->syscall_mask = NULL;
 
 	/* Our parent execution domain becomes current domain
 	   These must match for thread signalling to apply */

