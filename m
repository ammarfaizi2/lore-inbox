Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbWCRUhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWCRUhr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 15:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWCRUhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 15:37:46 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:59571 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1750954AbWCRUhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 15:37:46 -0500
Subject: Re: [RFC] Proposed manpage additions for ptrace(2)
From: "Charles P. Wright" <cwright@cs.sunysb.edu>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Daniel Jacobowitz <dan@debian.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Michael Kerrisk <mtk-manpages@gmx.net>
In-Reply-To: <200603171946.54784.blaisorblade@yahoo.it>
References: <200603150415_MC3-1-BAB1-D3CE@compuserve.com>
	 <20060316200201.GA20315@nevyn.them.org>
	 <1142543798.3284.6.camel@localhost.localdomain>
	 <200603171946.54784.blaisorblade@yahoo.it>
Content-Type: text/plain
Date: Sat, 18 Mar 2006 15:37:47 -0500
Message-Id: <1142714267.22366.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-17 at 19:46 +0100, Blaisorblade wrote:
> Side note - I'm attaching another (incomplete) patch for ptrace.2 with some 
> addition - there is already something worth adding, though I only listed the 
> 2.6-only ptrace options since I don't know what they do.
> 
> On Thursday 16 March 2006 22:16, Charles P. Wright wrote:
> > On Thu, 2006-03-16 at 15:02 -0500, Daniel Jacobowitz wrote:
> > > >        PTRACE_SYSEMU, PTRACE_SYSEMU_SINGLESTEP
> > > >               For  PTRACE_SYSEMU,  continue  and  stop  on  entry  to
> > > > the next syscall, which will not  be  executed.   For 
> > > > PTRACE_SYSEMU_SIN- GLESTEP, so the same but also singlestep if not a
> > > > syscall.
> > >
> > > I think this is right; I had nothing to do with these :-)
> >
> > I didn't have anything to do with it, but this description is correct
> > (if a bit confusing).  I think that you should explicitly say (assuming
> > that Paolo does not have any objections):
> 
> > PTRACE_SYSEMU only makes sense at a call's exit, not at entry.
> 
> I must indeed check the detail but I'm almost totally sure that this point is 
> totally wrong; conceptually, I understand what you mean, 
> but mixing PTRACE_SYSEMU and PTRACE_SYSCALL has non-obvious results.
Yes, that is probably a better warning that what I was suggesting.  

> Indeed, whether a syscall is performed or skipped is decided by the call which 
> stops at syscall entry, not by the call which resumes the syscall.
> 
> Actually, choosing what to do at resume time would make more sense, but for 
> historical reasons this was overlooked (also see at the end of this email).
> 
> I've described the exact semantics below, however I feel that mixing the calls 
> does not make any sense - we implemented this support mainly for testing - on 
> 2.4 hosts we could test UML performance this way, on 2.6 we couldn't and then 
> "fixed" the API to be again this strange one.
> 
> The exact semantics are these:
> 
> remember that PTRACE_SYSEMU is called once per syscall; you attach the 
> process, do a PTRACE_SYSEMU on it, and it'll stop at syscall #1 entry, and 
> this syscall will not be executed; you look at calls param, perform what you 
> want to do, and then resume it.
> 
> If you resume it with PTRACE_SYSEMU, it'll stop at next syscall entry, as 
> expected, and next syscall will not be executed.
> 
> If you resume it with PTRACE_SYSCALL (which made sense only for debugging), 
> the only thing which changes is that _next_ syscall will be executed 
> normally; then after stopping at syscall #2 exit you can choose to resume 
> with PTRACE_SYSEMU. You can do that even at syscall #2 entry, but you get the 
> same result.
If you do the PTRACE_SYSEMU at the entry, then it seems that you 

> However, I remember I answered to your request to fix this problem with some 
> patches to test (I remember I was sure enough of their correctness, for what 
> can be seen by code inspection), but got no answer and didn't finish 
> anything. Lost the email or the interest?
Actually, I remember that you said that it wasn't very practical to try
and fix SYSEMU because UML already relies on its interface.  You
suggested a "checked" version of the call, which I didn't actually lose
interest in.  I've included a patch to 2.6.15 (based on your original
patch) that I've been using that adds "PTRACE_CHECKEMU", which I think
has more user-friendly semantics.  

The PTRACE_CHECKEMU call makes the emulation decision after
ptrace_notify is called so that the tracing process can examine/update
registers before issuing PTRACE_CHECKEMU (to emulate the call) or
PTRACE_SYSCALL (to let the call go through).

I've also got a patch that allows you to execute the call, but skip the
return.  This is useful when you are emulating a subset of calls, and
don't care about the return value of unemulated calls.

> I was also busy so I didn't test them myself (even because reading this code 
> and following the exact states causes me a headache).
There is indeed some headache in here.  I think particularly for SYSEMU,
because there is a large gap between calling it and the decision that is
made.

Charles

This patch adds support for checked PTRACE_SYSEMU, or PTRACE_CHECKEMU.  The key
difference between SYSEMU and CHECKEMU is that the ptrace monitor can decide
whether to emulate a call after examining the registers rather than only before
examining the registers.

This is the interface improvement described here:
http://lkml.org/lkml/2005/7/30/131

Signed-off-by: Gopalan Sivathanu <gopalan@cs.sunysb.edu>
Signed-off-by: Charles P. Wright <cwright@cs.sunysb.edu>

diff -ur linux-2.6.15-vanilla/arch/i386/kernel/entry.S linux-2.6.15-checkemu/arch/i386/kernel/entry.S
--- linux-2.6.15-vanilla/arch/i386/kernel/entry.S	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15-checkemu/arch/i386/kernel/entry.S	2006-02-03 00:46:37.000000000 -0500
@@ -203,7 +203,7 @@
 	GET_THREAD_INFO(%ebp)
 
 	/* Note, _TIF_SECCOMP is bit number 8, and so it needs testw and not testb */
-	testw $(_TIF_SYSCALL_EMU|_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT),TI_flags(%ebp)
+	testw $(_TIF_SYSCALL_CHECKEMU|_TIF_SYSCALL_EMU|_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT),TI_flags(%ebp)
 	jnz syscall_trace_entry
 	cmpl $(nr_syscalls), %eax
 	jae syscall_badsys
@@ -228,7 +228,7 @@
 	GET_THREAD_INFO(%ebp)
 					# system call tracing in operation / emulation
 	/* Note, _TIF_SECCOMP is bit number 8, and so it needs testw and not testb */
-	testw $(_TIF_SYSCALL_EMU|_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT),TI_flags(%ebp)
+	testw $(_TIF_SYSCALL_CHECKEMU|_TIF_SYSCALL_EMU|_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT),TI_flags(%ebp)
 	jnz syscall_trace_entry
 	cmpl $(nr_syscalls), %eax
 	jae syscall_badsys
diff -ur linux-2.6.15-vanilla/arch/i386/kernel/ptrace.c linux-2.6.15-checkemu/arch/i386/kernel/ptrace.c
--- linux-2.6.15-vanilla/arch/i386/kernel/ptrace.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15-checkemu/arch/i386/kernel/ptrace.c	2006-02-03 00:46:40.000000000 -0500
@@ -475,6 +475,7 @@
 		  break;
 
 	case PTRACE_SYSEMU: /* continue and stop at next syscall, which will not be executed */
+	case PTRACE_CHECKEMU: /* like SYSEMU, but allow per-call emulation decisions. */
 	case PTRACE_SYSCALL:	/* continue and stop at next (return from) syscall */
 	case PTRACE_CONT:	/* restart after signal. */
 		ret = -EIO;
@@ -483,12 +484,19 @@
 		if (request == PTRACE_SYSEMU) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+			clear_tsk_thread_flag(child, TIF_SYSCALL_CHECKEMU);
 		} else if (request == PTRACE_SYSCALL) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+			clear_tsk_thread_flag(child, TIF_SYSCALL_CHECKEMU);
+		} else if (request == PTRACE_CHECKEMU) {
+			set_tsk_thread_flag(child, TIF_SYSCALL_CHECKEMU);
+			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 		} else {
 			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+			clear_tsk_thread_flag(child, TIF_SYSCALL_CHECKEMU);
 		}
 		child->exit_code = data;
 		/* make sure the single step bit is not set. */
@@ -524,6 +532,7 @@
 			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+		clear_tsk_thread_flag(child, TIF_SYSCALL_CHECKEMU);
 		set_singlestep(child);
 		child->exit_code = data;
 		/* give it a chance to run. */
@@ -655,6 +664,7 @@
 int do_syscall_trace(struct pt_regs *regs, int entryexit)
 {
 	int is_sysemu = test_thread_flag(TIF_SYSCALL_EMU);
+	int is_systrace = test_thread_flag(TIF_SYSCALL_TRACE) || test_thread_flag(TIF_SYSCALL_CHECKEMU);
 	/*
 	 * With TIF_SYSCALL_EMU set we want to ignore TIF_SINGLESTEP for syscall
 	 * interception
@@ -697,7 +707,7 @@
 	if (is_singlestep)
 		send_sigtrap(current, regs, 0);
 
- 	if (!test_thread_flag(TIF_SYSCALL_TRACE) && !is_sysemu)
+	if (!is_systrace && !is_sysemu)
 		goto out;
 
 	/* the 0x80 provides a way for the tracing parent to distinguish
@@ -705,6 +715,12 @@
 	/* Note that the debugger could change the result of test_thread_flag!*/
 	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD) ? 0x80:0));
 
+	/* The difference between PTRACE_SYSEMU and PTRACE_CHECKEMU is
+         * that PTRACE_CHECKEMU allows you to decide whether to emulate
+	 * the call after you've examined the registers. */
+	if (test_thread_flag(TIF_SYSCALL_CHECKEMU))
+		is_sysemu = 1;
+
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
diff -ur linux-2.6.15-vanilla/include/asm-i386/thread_info.h linux-2.6.15-checkemu/include/asm-i386/thread_info.h
--- linux-2.6.15-vanilla/include/asm-i386/thread_info.h	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15-checkemu/include/asm-i386/thread_info.h	2006-02-03 00:47:15.000000000 -0500
@@ -142,6 +142,7 @@
 #define TIF_SYSCALL_EMU		6	/* syscall emulation active */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SECCOMP		8	/* secure computing */
+#define TIF_SYSCALL_CHECKEMU	9	/* checked syscall emulation active */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		17
 
@@ -152,6 +153,7 @@
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
 #define _TIF_IRET		(1<<TIF_IRET)
 #define _TIF_SYSCALL_EMU	(1<<TIF_SYSCALL_EMU)
+#define _TIF_SYSCALL_CHECKEMU	(1<<TIF_SYSCALL_CHECKEMU)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
@@ -159,7 +161,7 @@
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK \
   (0x0000FFFF & ~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP|\
-		  _TIF_SECCOMP|_TIF_SYSCALL_EMU))
+		  _TIF_SECCOMP|_TIF_SYSCALL_EMU|_TIF_SYSCALL_CHECKEMU))
 /* work to do on any return to u-space */
 #define _TIF_ALLWORK_MASK	(0x0000FFFF & ~_TIF_SECCOMP)
 
diff -ur linux-2.6.15-vanilla/include/linux/ptrace.h linux-2.6.15-checkemu/include/linux/ptrace.h
--- linux-2.6.15-vanilla/include/linux/ptrace.h	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15-checkemu/include/linux/ptrace.h	2006-02-03 00:47:18.000000000 -0500
@@ -22,6 +22,7 @@
 #define PTRACE_SYSCALL		  24
 #define PTRACE_SYSEMU		  31
 #define PTRACE_SYSEMU_SINGLESTEP  32
+#define PTRACE_CHECKEMU		  33
 
 /* 0x4200-0x4300 are reserved for architecture-independent additions.  */
 #define PTRACE_SETOPTIONS	0x4200
diff -ur linux-2.6.15-vanilla/kernel/fork.c linux-2.6.15-checkemu/kernel/fork.c
--- linux-2.6.15-vanilla/kernel/fork.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15-checkemu/kernel/fork.c	2006-02-03 00:47:11.000000000 -0500
@@ -1016,6 +1016,9 @@
 #ifdef TIF_SYSCALL_EMU
 	clear_tsk_thread_flag(p, TIF_SYSCALL_EMU);
 #endif
+#ifdef TIF_SYSCALL_CHECKEMU
+	clear_tsk_thread_flag(p, TIF_SYSCALL_CHECKEMU);
+#endif
 
 	/* Our parent execution domain becomes current domain
 	   These must match for thread signalling to apply */

