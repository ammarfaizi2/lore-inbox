Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbUKVGZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbUKVGZh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 01:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbUKVGZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 01:25:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:660 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261943AbUKVGYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 01:24:47 -0500
Date: Sun, 21 Nov 2004 22:23:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Davide Libenzi <davidel@xmailserver.org>,
       Roland McGrath <roland@redhat.com>
cc: Andreas Schwab <schwab@suse.de>, Daniel Jacobowitz <dan@debian.org>,
       Eric Pouech <pouech-eric@wanadoo.fr>, Mike Hearn <mh@codeweavers.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <Pine.LNX.4.58.0411212022510.20993@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0411212212530.20993@ppc970.osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
 <419E42B3.8070901@wanadoo.fr> <Pine.LNX.4.58.0411191119320.2222@ppc970.osdl.org>
 <419E4A76.8020909@wanadoo.fr> <Pine.LNX.4.58.0411191148480.2222@ppc970.osdl.org>
 <419E5A88.1050701@wanadoo.fr> <20041119212327.GA8121@nevyn.them.org>
 <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org> <20041120214915.GA6100@tesore.ph.cox.net>
 <Pine.LNX.4.58.0411211326350.11274@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0411211414460.20993@ppc970.osdl.org> <je7joe91wz.fsf@sykes.suse.de>
 <Pine.LNX.4.58.0411211703160.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0411211947200.11274@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0411212022510.20993@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Nov 2004, Linus Torvalds wrote:
> 
> I'm by no means 100% sure that we should encourage the kind of programming 
> "skills" I showed with that example program, so in that sense this may not 
> be worth worrying about. That said, I do hate the notion of having 
> programs that are basically undebuggable, so from a QoI standpoint I'd 
> really like to say that you can run my horrid little program under the 
> debugger and see it work...

Ok, how about this patch?

It does basically two things:

 - it makes the x86 version of ptrace be a lot more careful about the TF 
   bit in eflags, and in particular it never touches it _unless_ the 
   tracer has explicitly asked for it (ie we set TF only when doing a
   PTRACE_SINGESTEP, and we clear it only when it has been set by us, not 
   if it has been set by the program itself).

   This patch also cleans up the codepaths by doing all the common stuff
   in set_singlestep()/clear_singlestep().

 - It clarifies signal handling, and makes it clear that we always push 
   the full eflags onto the signal stack, _except_ if the TF bit was set 
   by an external ptrace user, in which case we hide it so that the tracee 
   doesn't see it when it looks at its stack contents.

   It also adds a few comments, and makes it clear that the signal handler
   itself is always set up with TF _clear_. But if we were single-stepped 
   into it, we will have notified the debugger, so the debugger obviously 
   can (and often will) decide to continue single-stepping.

IMHO, this is a nice cleanup, and it also means that I can actually debug 
my "program from hell":

	[torvalds@evo ~]$ gdb ./a.out 
	GNU gdb Red Hat Linux (6.1post-1.20040607.41rh)
	Copyright 2004 Free Software Foundation, Inc.
	GDB is free software, covered by the GNU General Public License, and you are
	welcome to change it and/or distribute copies of it under certain conditions.
	Type "show copying" to see the conditions.
	There is absolutely no warranty for GDB.  Type "show warranty" for details.
	This GDB was configured as "i386-redhat-linux-gnu"...(no debugging symbols 
	found)...Using host libthread_db library "/lib/tls/libthread_db.so.1".

	(gdb) run
	Starting program: /home/torvalds/a.out 
	Reading symbols from shared object read from target memory...(no debugging 
	symbols found)...done.
	Loaded system supplied DSO at 0xffffe000
	(no debugging symbols found)...(no debugging symbols found)...
	Program received signal SIGTRAP, Trace/breakpoint trap.
	0x08048480 in main ()
	(gdb) signal SIGTRAP
	Continuing with signal SIGTRAP.

	Program received signal SIGTRAP, Trace/breakpoint trap.
	0x08048487 in main ()
	(gdb) signal SIGTRAP
	Continuing with signal SIGTRAP.

	Program received signal SIGTRAP, Trace/breakpoint trap.
	0x08048488 in smc ()
	(gdb) signal SIGTRAP
	Continuing with signal SIGTRAP.
	Copy protected: ok

	Program exited with code 01.
	(gdb) 

which I think is a sign that this patch actually fixes ptrace.

Does this help with wine? I dunno. Maybe some wine people can comment..

Roland, mind take a look? I assume you have some gdb test-suite that you 
use to test the things?

		Linus

----

===== arch/i386/kernel/ptrace.c 1.27 vs edited =====
--- 1.27/arch/i386/kernel/ptrace.c	2004-11-07 18:10:34 -08:00
+++ edited/arch/i386/kernel/ptrace.c	2004-11-21 21:34:58 -08:00
@@ -138,6 +138,28 @@
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
+	if (child->ptrace & PT_DTRACE) {
+		long eflags;
+
+		clear_tsk_thread_flag(child, TIF_SINGLESTEP);
+		eflags = get_stack_long(child, EFL_OFFSET);
+		put_stack_long(child, EFL_OFFSET, eflags & ~TRAP_FLAG);
+		child->ptrace &= ~PT_DTRACE;
+	}
+}
+
 /*
  * Called by kernel/ptrace.c when detaching..
  *
@@ -145,11 +167,7 @@
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
@@ -388,10 +406,8 @@
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
@@ -401,56 +417,39 @@
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
===== arch/i386/kernel/signal.c 1.48 vs edited =====
--- 1.48/arch/i386/kernel/signal.c	2004-11-15 00:56:24 -08:00
+++ edited/arch/i386/kernel/signal.c	2004-11-21 21:33:21 -08:00
@@ -292,10 +292,15 @@
 	err |= __put_user(current->thread.error_code, &sc->err);
 	err |= __put_user(regs->eip, &sc->eip);
 	err |= __put_user(regs->xcs, (unsigned int __user *)&sc->cs);
+
+	/*
+	 * Iff TF was set because the program is being single-stepped by a
+	 * debugger, don't save that information on the signal stack.. We
+	 * don't want debugging to change state.
+	 */
 	eflags = regs->eflags;
-	if (current->ptrace & PT_PTRACED) {
+	if (current->ptrace & PT_DTRACE)
 		eflags &= ~TF_MASK;
-	}
 	err |= __put_user(eflags, &sc->eflags);
 	err |= __put_user(regs->esp, &sc->esp_at_signal);
 	err |= __put_user(regs->xss, (unsigned int __user *)&sc->ss);
@@ -412,12 +417,17 @@
 	regs->xes = __USER_DS;
 	regs->xss = __USER_DS;
 	regs->xcs = __USER_CS;
+
+	/*
+	 * Clear TF when entering the signal handler, but
+	 * notify any tracer that was single-stepping it.
+	 * The tracer may want to single-step inside the
+	 * handler too.
+	 */
 	if (regs->eflags & TF_MASK) {
-		if ((current->ptrace & (PT_PTRACED | PT_DTRACE)) == (PT_PTRACED | PT_DTRACE)) {
+		regs->eflags &= ~TF_MASK;
+		if (current->ptrace & PT_DTRACE)
 			ptrace_notify(SIGTRAP);
-		} else {
-			regs->eflags &= ~TF_MASK;
-		}
 	}
 
 #if DEBUG_SIG
@@ -502,12 +512,17 @@
 	regs->xes = __USER_DS;
 	regs->xss = __USER_DS;
 	regs->xcs = __USER_CS;
+
+	/*
+	 * Clear TF when entering the signal handler, but
+	 * notify any tracer that was single-stepping it.
+	 * The tracer may want to single-step inside the
+	 * handler too.
+	 */
 	if (regs->eflags & TF_MASK) {
-		if (current->ptrace & PT_PTRACED) {
+		regs->eflags &= ~TF_MASK;
+		if (current->ptrace & PT_DTRACE)
 			ptrace_notify(SIGTRAP);
-		} else {
-			regs->eflags &= ~TF_MASK;
-		}
 	}
 
 #if DEBUG_SIG
