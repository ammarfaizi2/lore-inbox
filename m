Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030337AbVIAUAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbVIAUAV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbVIAUAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:00:21 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:64902 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030337AbVIAUAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:00:19 -0400
Date: Thu, 1 Sep 2005 22:00:15 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] m68k: sys_ptrace cleanup
Message-ID: <Pine.LNX.4.61.0509012159530.7110@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- create helper function singlestep_disable()
- move variable definitions to the top of the function
- use "out_eio" label as common error destination
- don't clear failure value for PTRACE_SETREGS/PTRACE_GETREGS

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/m68k/kernel/ptrace.c |  175 ++++++++++++++++------------------------------
 1 files changed, 64 insertions(+), 111 deletions(-)

Index: linux-2.6/arch/m68k/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/m68k/kernel/ptrace.c	2005-08-30 16:19:46.290131062 +0200
+++ linux-2.6/arch/m68k/kernel/ptrace.c	2005-08-30 16:25:52.175519382 +0200
@@ -103,48 +103,56 @@ static inline int put_reg(struct task_st
 }
 
 /*
- * Called by kernel/ptrace.c when detaching..
- *
  * Make sure the single step bit is not set.
  */
-void ptrace_disable(struct task_struct *child)
+static inline void singlestep_disable(struct task_struct *child)
 {
-	unsigned long tmp;
-	/* make sure the single step bit is not set. */
-	tmp = get_reg(child, PT_SR) & ~(TRACE_BITS << 16);
+	unsigned long tmp = get_reg(child, PT_SR) & ~(TRACE_BITS << 16);
 	put_reg(child, PT_SR, tmp);
 	child->thread.work.delayed_trace = 0;
+}
+
+/*
+ * Called by kernel/ptrace.c when detaching..
+ */
+void ptrace_disable(struct task_struct *child)
+{
+	singlestep_disable(child);
 	child->thread.work.syscall_trace = 0;
 }
 
 asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
-	int ret;
+	unsigned long tmp;
+	int i, ret = 0;
 
 	lock_kernel();
-	ret = -EPERM;
 	if (request == PTRACE_TRACEME) {
 		/* are we already being traced? */
-		if (current->ptrace & PT_PTRACED)
+		if (current->ptrace & PT_PTRACED) {
+			ret = -EPERM;
 			goto out;
+		}
 		/* set the ptrace bit in the process flags. */
 		current->ptrace |= PT_PTRACED;
-		ret = 0;
 		goto out;
 	}
-	ret = -ESRCH;
 	read_lock(&tasklist_lock);
 	child = find_task_by_pid(pid);
 	if (child)
 		get_task_struct(child);
 	read_unlock(&tasklist_lock);
-	if (!child)
+	if (unlikely(!child)) {
+		ret = -ESRCH;
 		goto out;
+	}
 
-	ret = -EPERM;
-	if (pid == 1)		/* you may not mess with init */
+	/* you may not mess with init */
+	if (unlikely(pid == 1)) {
+		ret = -EPERM;
 		goto out_tsk;
+	}
 
 	if (request == PTRACE_ATTACH) {
 		ret = ptrace_attach(child);
@@ -152,86 +160,62 @@ asmlinkage int sys_ptrace(long request, 
 	}
 
 	ret = ptrace_check_attach(child, request == PTRACE_KILL);
-	if (ret < 0)
+	if (ret)
 		goto out_tsk;
 
 	switch (request) {
 	/* when I and D space are separate, these will need to be fixed. */
 	case PTRACE_PEEKTEXT:	/* read word at location addr. */
-	case PTRACE_PEEKDATA: {
-		unsigned long tmp;
-		int copied;
-
-		copied = access_process_vm(child, addr, &tmp, sizeof(tmp), 0);
-		ret = -EIO;
-		if (copied != sizeof(tmp))
-			break;
+	case PTRACE_PEEKDATA:
+		i = access_process_vm(child, addr, &tmp, sizeof(tmp), 0);
+		if (i != sizeof(tmp))
+			goto out_eio;
 		ret = put_user(tmp, (unsigned long *)data);
 		break;
-	}
 
 	/* read the word at location addr in the USER area. */
-	case PTRACE_PEEKUSR: {
-		unsigned long tmp;
-
-		ret = -EIO;
-		if ((addr & 3) || addr < 0 ||
-		    addr > sizeof(struct user) - 3)
-			break;
+	case PTRACE_PEEKUSR:
+		if (addr & 3)
+			goto out_eio;
+		addr >>= 2;	/* temporary hack. */
 
-		tmp = 0;  /* Default return condition */
-		addr = addr >> 2; /* temporary hack. */
-		ret = -EIO;
-		if (addr < 19) {
+		if (addr >= 0 && addr < 19) {
 			tmp = get_reg(child, addr);
 			if (addr == PT_SR)
 				tmp >>= 16;
 		} else if (addr >= 21 && addr < 49) {
 			tmp = child->thread.fp[addr - 21];
-#ifdef CONFIG_M68KFPU_EMU
 			/* Convert internal fpu reg representation
 			 * into long double format
 			 */
 			if (FPU_IS_EMU && (addr < 45) && !(addr % 3))
 				tmp = ((tmp & 0xffff0000) << 15) |
 				      ((tmp & 0x0000ffff) << 16);
-#endif
 		} else
 			break;
 		ret = put_user(tmp, (unsigned long *)data);
 		break;
-	}
 
 	/* when I and D space are separate, this will have to be fixed. */
 	case PTRACE_POKETEXT:	/* write the word at location addr. */
 	case PTRACE_POKEDATA:
-		ret = 0;
-		if (access_process_vm(child, addr, &data, sizeof(data), 1) == sizeof(data))
-			break;
-		ret = -EIO;
+		if (access_process_vm(child, addr, &data, sizeof(data), 1) != sizeof(data))
+			goto out_eio;
 		break;
 
 	case PTRACE_POKEUSR:	/* write the word at location addr in the USER area */
-		ret = -EIO;
-		if ((addr & 3) || addr < 0 ||
-		    addr > sizeof(struct user) - 3)
-			break;
-
-		addr = addr >> 2; /* temporary hack. */
+		if (addr & 3)
+			goto out_eio;
+		addr >>= 2;	/* temporary hack. */
 
 		if (addr == PT_SR) {
 			data &= SR_MASK;
 			data <<= 16;
 			data |= get_reg(child, PT_SR) & ~(SR_MASK << 16);
-		}
-		if (addr < 19) {
+		} else if (addr >= 0 && addr < 19) {
 			if (put_reg(child, addr, data))
-				break;
-			ret = 0;
-			break;
-		}
-		if (addr >= 21 && addr < 48) {
-#ifdef CONFIG_M68KFPU_EMU
+				goto out_eio;
+		} else if (addr >= 21 && addr < 48) {
 			/* Convert long double format
 			 * into internal fpu reg representation
 			 */
@@ -240,60 +224,42 @@ asmlinkage int sys_ptrace(long request, 
 				data = (data & 0xffff0000) |
 				       ((data & 0x0000ffff) >> 1);
 			}
-#endif
 			child->thread.fp[addr - 21] = data;
-			ret = 0;
-		}
+		} else
+			goto out_eio;
 		break;
 
 	case PTRACE_SYSCALL:	/* continue and stop at next (return from) syscall */
-	case PTRACE_CONT: {	/* restart after signal. */
-		long tmp;
-
-		ret = -EIO;
+	case PTRACE_CONT:	/* restart after signal. */
 		if (!valid_signal(data))
-			break;
-		if (request == PTRACE_SYSCALL) {
+			goto out_eio;
+
+		if (request == PTRACE_SYSCALL)
 			child->thread.work.syscall_trace = ~0;
-		} else {
+		else
 			child->thread.work.syscall_trace = 0;
-		}
 		child->exit_code = data;
-		/* make sure the single step bit is not set. */
-		tmp = get_reg(child, PT_SR) & ~(TRACE_BITS << 16);
-		put_reg(child, PT_SR, tmp);
-		child->thread.work.delayed_trace = 0;
+		singlestep_disable(child);
 		wake_up_process(child);
-		ret = 0;
 		break;
-	}
 
 	/*
 	 * make the child exit.  Best I can do is send it a sigkill.
 	 * perhaps it should be put in the status that it wants to
 	 * exit.
 	 */
-	case PTRACE_KILL: {
-		long tmp;
-
-		ret = 0;
+	case PTRACE_KILL:
 		if (child->exit_state == EXIT_ZOMBIE) /* already dead */
 			break;
 		child->exit_code = SIGKILL;
-		/* make sure the single step bit is not set. */
-		tmp = get_reg(child, PT_SR) & ~(TRACE_BITS << 16);
-		put_reg(child, PT_SR, tmp);
-		child->thread.work.delayed_trace = 0;
+		singlestep_disable(child);
 		wake_up_process(child);
 		break;
-	}
-
-	case PTRACE_SINGLESTEP: {  /* set the trap flag. */
-		long tmp;
 
-		ret = -EIO;
+	case PTRACE_SINGLESTEP:	/* set the trap flag. */
 		if (!valid_signal(data))
-			break;
+			goto out_eio;
+
 		child->thread.work.syscall_trace = 0;
 		tmp = get_reg(child, PT_SR) | (TRACE_BITS << 16);
 		put_reg(child, PT_SR, tmp);
@@ -302,39 +268,29 @@ asmlinkage int sys_ptrace(long request, 
 		child->exit_code = data;
 		/* give it a chance to run. */
 		wake_up_process(child);
-		ret = 0;
 		break;
-	}
 
 	case PTRACE_DETACH:	/* detach a process that was attached. */
 		ret = ptrace_detach(child, data);
 		break;
 
-	case PTRACE_GETREGS: { /* Get all gp regs from the child. */
-		int i;
-		unsigned long tmp;
+	case PTRACE_GETREGS:	/* Get all gp regs from the child. */
 		for (i = 0; i < 19; i++) {
 			tmp = get_reg(child, i);
 			if (i == PT_SR)
 				tmp >>= 16;
-			if (put_user(tmp, (unsigned long *)data)) {
-				ret = -EFAULT;
+			ret = put_user(tmp, (unsigned long *)data);
+			if (ret)
 				break;
-			}
 			data += sizeof(long);
 		}
-		ret = 0;
 		break;
-	}
 
-	case PTRACE_SETREGS: { /* Set all gp regs in the child. */
-		int i;
-		unsigned long tmp;
+	case PTRACE_SETREGS:	/* Set all gp regs in the child. */
 		for (i = 0; i < 19; i++) {
-			if (get_user(tmp, (unsigned long *)data)) {
-				ret = -EFAULT;
+			ret = get_user(tmp, (unsigned long *)data);
+			if (ret)
 				break;
-			}
 			if (i == PT_SR) {
 				tmp &= SR_MASK;
 				tmp <<= 16;
@@ -343,25 +299,19 @@ asmlinkage int sys_ptrace(long request, 
 			put_reg(child, i, tmp);
 			data += sizeof(long);
 		}
-		ret = 0;
 		break;
-	}
 
-	case PTRACE_GETFPREGS: { /* Get the child FPU state. */
-		ret = 0;
+	case PTRACE_GETFPREGS:	/* Get the child FPU state. */
 		if (copy_to_user((void *)data, &child->thread.fp,
 				 sizeof(struct user_m68kfp_struct)))
 			ret = -EFAULT;
 		break;
-	}
 
-	case PTRACE_SETFPREGS: { /* Set the child FPU state. */
-		ret = 0;
+	case PTRACE_SETFPREGS:	/* Set the child FPU state. */
 		if (copy_from_user(&child->thread.fp, (void *)data,
 				   sizeof(struct user_m68kfp_struct)))
 			ret = -EFAULT;
 		break;
-	}
 
 	default:
 		ret = ptrace_request(child, request, addr, data);
@@ -372,6 +322,9 @@ out_tsk:
 out:
 	unlock_kernel();
 	return ret;
+out_eio:
+	ret = -EIO;
+	goto out_tsk;
 }
 
 asmlinkage void syscall_trace(void)
