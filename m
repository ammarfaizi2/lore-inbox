Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbUKSVWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbUKSVWf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 16:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbUKSVWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 16:22:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:32139 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261568AbUKSVW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 16:22:28 -0500
Date: Fri, 19 Nov 2004 13:22:02 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Eric Pouech <pouech-eric@wanadoo.fr>
cc: Roland McGrath <roland@redhat.com>, Mike Hearn <mh@codeweavers.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <419E5A88.1050701@wanadoo.fr>
Message-ID: <Pine.LNX.4.58.0411191319360.2222@ppc970.osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
 <419E42B3.8070901@wanadoo.fr> <Pine.LNX.4.58.0411191119320.2222@ppc970.osdl.org>
 <419E4A76.8020909@wanadoo.fr> <Pine.LNX.4.58.0411191148480.2222@ppc970.osdl.org>
 <419E5A88.1050701@wanadoo.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Nov 2004, Eric Pouech wrote:
> 
> wine mixes both approches, we have (to control what's generated inside the 
> various exception) to ptrace from our NT-kernel-like process (the ptracer) to 
> get the context of the exception. Restart from the ptracer is done with 
> PTRACE_SINGLESTEP.

Here's a new patch to try. Totally untested. 

It is more careful about clearing PT_DTRACED (which by now should probably
be renamed PT_PRACE_SINGLESTEP or something on x86, since we should never
be lazy about this thing any more), and it may or may not help.

Pls test _together_ with the previous patch (which is already applied in 
the current top-of-tree for anybody with really recent kernels).

		Linus

-----
===== arch/i386/kernel/ptrace.c 1.27 vs edited =====
--- 1.27/arch/i386/kernel/ptrace.c	2004-11-07 18:10:34 -08:00
+++ edited/arch/i386/kernel/ptrace.c	2004-11-19 13:18:56 -08:00
@@ -138,6 +138,26 @@
 	return retval;
 }
 
+static void set_singlestep(struct task_struct *child)
+{
+	long eflags;
+
+	set_tsk_thread_flag(child, TIF_SINGLESTEP);
+	eflags = get_stack_long(child, EFL_OFFSET);
+	put_stack_long(child, EFL_OFFSET, eflags | TRAP_FLAG);
+	child->ptrace |= PT_DTRACE;
+}
+
+static void clear_singlestep(struct task_struct *child)
+{
+	long eflags;
+
+	clear_tsk_thread_flag(child, TIF_SINGLESTEP);
+	eflags = get_stack_long(child, EFL_OFFSET);
+	put_stack_long(child, EFL_OFFSET, eflags & ~TRAP_FLAG);
+	child->ptrace &= ~PT_DTRACE;
+}
+
 /*
  * Called by kernel/ptrace.c when detaching..
  *
@@ -145,11 +165,7 @@
  */
 void ptrace_disable(struct task_struct *child)
 { 
-	long tmp;
-
-	clear_tsk_thread_flag(child, TIF_SINGLESTEP);
-	tmp = get_stack_long(child, EFL_OFFSET) & ~TRAP_FLAG;
-	put_stack_long(child, EFL_OFFSET, tmp);
+	clear_singlestep(child);
 }
 
 /*
@@ -388,10 +404,8 @@
 		  }
 		  break;
 
-	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
-	case PTRACE_CONT: { /* restart after signal. */
-		long tmp;
-
+	case PTRACE_SYSCALL:	/* continue and stop at next (return from) syscall */
+	case PTRACE_CONT:	/* restart after signal. */
 		ret = -EIO;
 		if ((unsigned long) data > _NSIG)
 			break;
@@ -401,56 +415,39 @@
 		else {
 			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		}
-		clear_tsk_thread_flag(child, TIF_SINGLESTEP);
 		child->exit_code = data;
-	/* make sure the single step bit is not set. */
-		tmp = get_stack_long(child, EFL_OFFSET) & ~TRAP_FLAG;
-		put_stack_long(child, EFL_OFFSET,tmp);
+		/* make sure the single step bit is not set. */
+		clear_singlestep(child);
 		wake_up_process(child);
 		ret = 0;
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
+	case PTRACE_KILL:
 		ret = 0;
 		if (child->exit_state == EXIT_ZOMBIE)	/* already dead */
 			break;
 		child->exit_code = SIGKILL;
-		clear_tsk_thread_flag(child, TIF_SINGLESTEP);
 		/* make sure the single step bit is not set. */
-		tmp = get_stack_long(child, EFL_OFFSET) & ~TRAP_FLAG;
-		put_stack_long(child, EFL_OFFSET, tmp);
+		clear_singlestep(child);
 		wake_up_process(child);
 		break;
-	}
-
-	case PTRACE_SINGLESTEP: {  /* set the trap flag. */
-		long tmp;
 
+	case PTRACE_SINGLESTEP:	/* set the trap flag. */
 		ret = -EIO;
 		if ((unsigned long) data > _NSIG)
 			break;
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
-		if ((child->ptrace & PT_DTRACE) == 0) {
-			/* Spurious delayed TF traps may occur */
-			child->ptrace |= PT_DTRACE;
-		}
-		tmp = get_stack_long(child, EFL_OFFSET) | TRAP_FLAG;
-		put_stack_long(child, EFL_OFFSET, tmp);
-		set_tsk_thread_flag(child, TIF_SINGLESTEP);
+		set_singlestep(child);
 		child->exit_code = data;
 		/* give it a chance to run. */
 		wake_up_process(child);
 		ret = 0;
 		break;
-	}
 
 	case PTRACE_DETACH:
 		/* detach a process that was attached. */
