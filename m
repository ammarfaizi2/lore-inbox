Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264538AbUGMAYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbUGMAYq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 20:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbUGMAYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 20:24:09 -0400
Received: from mail3.speakeasy.net ([216.254.0.203]:44008 "EHLO
	mail3.speakeasy.net") by vger.kernel.org with ESMTP id S264538AbUGMAWg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 20:22:36 -0400
Date: Mon, 12 Jul 2004 17:22:30 -0700
Message-Id: <200407130022.i6D0MUdI023333@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jim Paradis <jparadis@redhat.com>, Andrew Cagney <cagney@redhat.com>
Subject: [PATCH] x86-64 singlestep through sigreturn system call
X-Zippy-Says: Th' PINK SOCK... soaking... soaking... soaking...  Th' PINK
   SOCK... washing... washing... washing...  Th' PINK
   SOCK... rinsing... rinsing... rinsing...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With Davide Libenzi's patch for i386 and my follow-on patch for x86-64's
ia32 support, single-stepping through any system call correctly traps
immediately on return to user mode.  I still don't know why the same
problem doesn't arise for `syscall'/`sysret' on native 64-bit x86-64, and
would like someone to point me at what I misunderstood in the chip manuals.

But, there is a problem in the case of the rt_sigreturn system call on
native x86-64.  When using PTRACE_SINGLESTEP to step into an rt_sigreturn
system call and the sigcontext being restored does not have TF set in its
%eflags, then we miss the single-step trap.  This makes gdb unhappy.

Here is a test program to run under gdb.  Set a breakpoint on "keeper".
When SIGSEGV hits, just continue to let the program handle it.  When you
get into "keeper", do "display/i $pc" to see what's going on and then do
"stepi" repeatedly to get out of the handler and into the signal handler
trampoline as it makes the rt_sigreturn system call.  When you step into
the `syscall' instruction, you will lose control.  Rather than stopping
immediately, the program will reexecute the faulting instruction and take a
second SIGSEGV.

	#include <signal.h>
	#include <stdlib.h>
	#include <string.h>

	extern void
	keeper (int sig)
	{
	}

	volatile long v1 = 0;
	volatile long v2 = 0;
	volatile long v3 = 0;

	extern long
	bowler (void)
	{
	  /* Try to read address zero.  Do it in a slightly convoluted way so
	     that more than one instruction is used.  */
	  return *(char *) (v1 + v2 + v3);
	}

	int
	main ()
	{
	  static volatile int i;

	  struct sigaction act;
	  memset (&act, 0, sizeof act);
	  act.sa_handler = keeper;
	  sigaction (SIGSEGV, &act, NULL);

	  bowler ();
	  return 0;
	}


This patch fixes the problem by forcing a fake single-step trap at the end
of rt_sigreturn when PTRACE_SINGLESTEP was used to enter the system call.


Thanks,
Roland


Signed-off-by: Roland McGrath <roland@redhat.com>


Index: linux-2.6/arch/x86_64/kernel/signal.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/arch/x86_64/kernel/signal.c,v
retrieving revision 1.23
diff -b -p -u -r1.23 signal.c
--- linux-2.6/arch/x86_64/kernel/signal.c 31 May 2004 03:08:04 -0000 1.23
+++ linux-2.6/arch/x86_64/kernel/signal.c 12 Jul 2004 22:14:07 -0000
@@ -92,6 +92,7 @@ static int
 restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc, unsigned long *prax)
 {
 	unsigned int err = 0;
+	unsigned int caller_eflags;
 
 	/* Always make any pending restarted system calls return -EINTR */
 	current_thread_info()->restart_block.fn = do_no_restart_syscall;
@@ -112,6 +113,7 @@ restore_sigcontext(struct pt_regs *regs,
 	{
 		unsigned int tmpflags;
 		err |= __get_user(tmpflags, &sc->eflags);
+		caller_eflags = regs->eflags;
 		regs->eflags = (regs->eflags & ~0x40DD5) | (tmpflags & 0x40DD5);
 		regs->orig_rax = -1;		/* disable syscall checks */
 	}
@@ -128,6 +130,22 @@ restore_sigcontext(struct pt_regs *regs,
 	}
 
 	err |= __get_user(*prax, &sc->rax);
+
+	if (!err && unlikely(caller_eflags & X86_EFLAGS_TF) &&
+	    (current->ptrace & (PT_PTRACED|PT_DTRACE)) == (PT_PTRACED|PT_DTRACE)) {
+		/*
+		 * If ptrace single-stepped into the sigreturn system call,
+		 * then fake a single-step trap before we resume the restored
+		 * context.
+		 */
+		siginfo_t info;
+		info.si_signo = SIGTRAP;
+		info.si_errno = 0;
+		info.si_code = TRAP_BRKPT;
+		info.si_addr = (void *)regs->rip;
+		force_sig_info(SIGTRAP, &info, current);
+	}
+
 	return err;
 
 badframe:
