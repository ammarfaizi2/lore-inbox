Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269184AbRIFXAw>; Thu, 6 Sep 2001 19:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269238AbRIFXAn>; Thu, 6 Sep 2001 19:00:43 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:62183 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S269184AbRIFXAd>;
	Thu, 6 Sep 2001 19:00:33 -0400
Date: Thu, 6 Sep 2001 16:00:51 -0700
Message-Id: <200109062300.QAA27430@napali.hpl.hp.com>
From: David Mosberger <davidm@hpl.hp.com>
To: linux-kernel@vger.kernel.org
cc: davidm@hpl.hp.com
Subject: [patch] proposed fix for ptrace() SMP race
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-to: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is currently a nasty race condition in ptrace().  The effect of
this varies from one platform to another but, for example, on ia64, it
could have the effect of corrupting the state of register f32-f127.
The problem is that ptrace() uses the expression (child->state ==
TASK_STOPPED) to determine whether or not a task has stopped
execution.  On SMP, this is not sufficient because the task may still
be executing while child->has_cpu is true.  This is easy to fix, but
there is a related concern: what would happen if a ptrace'd task was
woken up by another thread while ptrace() is running?  You could argue
that this is just a bug in the user-level program, but I'm worried
that the resulting race conditions could corrupt kernel data
structures and therefore could provide a means to attack the integrity
of the kernel.  The patch below is an attempt to address this issue by
clearing child->cpus_allowed while ptrace() is running.  This should
have the desired effect and as far as I know, it has no negative
impact.  However, it doesn't strike me as the most elegant solution
either and it could well be there there are some problems with it that
I'm overlooking.  Anyhow, I'd appreciate it if the maintainers of the
other platforms could take a look at the patch below and share their
thoughts.  The patch below fixes only the ia64 tree, but if the patch
is agreeable, I can make the same update for the other platforms as
well.

	--david

--- lia64/kernel/ptrace.c	Mon Jul 23 13:51:13 2001
+++ lia64-kdb/kernel/ptrace.c	Tue Sep  4 18:22:49 2001
@@ -60,6 +60,40 @@
 	return -EPERM;
 }
 
+long ptrace_freeze_child(struct task_struct *child, long request, unsigned long *freeze_info)
+{
+	unsigned long old_cpus_allowed;
+
+	if (request == PTRACE_KILL)
+		return 0;
+
+	if (child->state != TASK_STOPPED)
+		return -ESRCH;
+
+#ifdef CONFIG_SMP
+	while (child->has_cpu) {
+		if (child->state != TASK_STOPPED)
+			return -ESRCH;
+		barrier();
+	}
+#endif
+
+	old_cpus_allowed = xchg(&child->cpus_allowed, 0);
+
+	if (child->state != TASK_STOPPED) {
+		xchg(&child->cpus_allowed, old_cpus_allowed);
+		return -ESRCH;
+	}
+
+	*freeze_info = old_cpus_allowed;
+	return 0;
+}
+
+void ptrace_thaw_child(struct task_struct *child, long request, unsigned long freeze_info)
+{
+	if (request != PTRACE_KILL)
+		xchg(&child->cpus_allowed, freeze_info);
+}
 
 /*
  * Access another process' address space, one page at a time.
--- lia64/arch/ia64/kernel/ptrace.c	Mon Jul 23 13:50:57 2001
+++ lia64-kdb/arch/ia64/kernel/ptrace.c	Tue Sep  4 16:45:03 2001
@@ -794,7 +794,7 @@
 	    long arg4, long arg5, long arg6, long arg7, long stack)
 {
 	struct pt_regs *pt, *regs = (struct pt_regs *) &stack;
-	unsigned long flags, urbs_end;
+	unsigned long flags, urbs_end, freeze_info;
 	struct task_struct *child;
 	struct switch_stack *sw;
 	long ret;
@@ -840,6 +840,10 @@
 	if (child->p_pptr != current)
 		goto out_tsk;
 
+	ret = ptrace_freeze_child(child, request, &freeze_info);
+	if (ret < 0)
+		goto out_tsk;
+
 	pt = ia64_task_regs(child);
 	sw = (struct switch_stack *) (child->thread.ksp + 16);
 
@@ -856,7 +860,7 @@
 			ret = data;
 			regs->r8 = 0;	/* ensure "ret" is not mistaken as an error code */
 		}
-		goto out_tsk;
+		goto out_thaw;
 
 	      case PTRACE_POKETEXT:
 	      case PTRACE_POKEDATA:		/* write the word at location addr */
@@ -865,45 +869,45 @@
 			threads_sync_user_rbs(child, urbs_end, 1);
 
 		ret = ia64_poke(child, sw, urbs_end, addr, data);
-		goto out_tsk;
+		goto out_thaw;
 
 	      case PTRACE_PEEKUSR:		/* read the word at addr in the USER area */
 		if (access_uarea(child, addr, &data, 0) < 0) {
 			ret = -EIO;
-			goto out_tsk;
+			goto out_thaw;
 		}
 		ret = data;
 		regs->r8 = 0;	/* ensure "ret" is not mistaken as an error code */
-		goto out_tsk;
+		goto out_thaw;
 
 	      case PTRACE_POKEUSR:	      /* write the word at addr in the USER area */
 		if (access_uarea(child, addr, &data, 1) < 0) {
 			ret = -EIO;
-			goto out_tsk;
+			goto out_thaw;
 		}
 		ret = 0;
-		goto out_tsk;
+		goto out_thaw;
 
 	      case PTRACE_GETSIGINFO:
 		ret = -EIO;
 		if (!access_ok(VERIFY_WRITE, data, sizeof (siginfo_t)) || !child->thread.siginfo)
-			goto out_tsk;
+			goto out_thaw;
 		ret = copy_siginfo_to_user((siginfo_t *) data, child->thread.siginfo);
-		goto out_tsk;
+		goto out_thaw;
 
 	      case PTRACE_SETSIGINFO:
 		ret = -EIO;
 		if (!access_ok(VERIFY_READ, data, sizeof (siginfo_t))
 		    || child->thread.siginfo == 0)
-			goto out_tsk;
+			goto out_thaw;
 		ret = copy_siginfo_from_user(child->thread.siginfo, (siginfo_t *) data);
-		goto out_tsk;
+		goto out_thaw;
 
 	      case PTRACE_SYSCALL:	/* continue and stop at next (return from) syscall */
 	      case PTRACE_CONT:		/* restart after signal. */
 		ret = -EIO;
 		if (data > _NSIG)
-			goto out_tsk;
+			goto out_thaw;
 		if (request == PTRACE_SYSCALL)
 			child->ptrace |= PT_TRACESYS;
 		else
@@ -919,7 +923,7 @@
 
 		wake_up_process(child);
 		ret = 0;
-		goto out_tsk;
+		goto out_thaw;
 
 	      case PTRACE_KILL:
 		/*
@@ -928,7 +932,7 @@
 		 * that it wants to exit.
 		 */
 		if (child->state == TASK_ZOMBIE)		/* already dead */
-			goto out_tsk;
+			goto out_thaw;
 		child->exit_code = SIGKILL;
 
 		/* make sure the single step/take-branch tra bits are not set: */
@@ -940,13 +944,13 @@
 
 		wake_up_process(child);
 		ret = 0;
-		goto out_tsk;
+		goto out_thaw;
 
 	      case PTRACE_SINGLESTEP:		/* let child execute for one instruction */
 	      case PTRACE_SINGLEBLOCK:
 		ret = -EIO;
 		if (data > _NSIG)
-			goto out_tsk;
+			goto out_thaw;
 
 		child->ptrace &= ~PT_TRACESYS;
 		if (request == PTRACE_SINGLESTEP) {
@@ -962,12 +966,12 @@
 		/* give it a chance to run. */
 		wake_up_process(child);
 		ret = 0;
-		goto out_tsk;
+		goto out_thaw;
 
 	      case PTRACE_DETACH:		/* detach a process that was attached. */
 		ret = -EIO;
 		if (data > _NSIG)
-			goto out_tsk;
+			goto out_thaw;
 
 		child->ptrace &= ~(PT_PTRACED|PT_TRACESYS);
 		child->exit_code = data;
@@ -986,12 +990,14 @@
 
 		wake_up_process(child);
 		ret = 0;
-		goto out_tsk;
+		goto out_thaw;
 
 	      default:
 		ret = -EIO;
-		goto out_tsk;
+		goto out_thaw;
 	}
+  out_thaw:
+	ptrace_thaw_child(child, request, freeze_info);
   out_tsk:
 	free_task_struct(child);
   out:


