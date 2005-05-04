Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbVEDQGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVEDQGF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 12:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbVEDQGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 12:06:05 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:24490 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261906AbVEDQFx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 12:05:53 -0400
Date: Wed, 4 May 2005 18:04:37 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: bstroesser@fujitsu-siemens.com
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: Again: UML on s390 (31Bit)
Message-ID: <20050504160437.GA573@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes. That's what I suggested as a "special magic number". Only if that magic
> is written as syscall number at the first interception, syscall_trace() would
> modify regs->trap to -1.
> Currently my patch uses -1 as the magic number, but there might be better
> choices.
> 
> > 3) -Eyyy, skip the system call but leave regs->trap intact so that a pending
> >    signal will restart the system call.
> Not only -Eyyy, but all values unequal to "special magic number" could leave
> regs->trap intact.
> 
> > 
> > But we really have to be very careful not to break either strace or gdb if
> > we do this change. Probably it is much easier to introduce PTRACE_SET/GET_TRAP.
> It's easier for s390-kernel, but from UML's point of view, the magic number
> solution would be better.
> Anyway, if you decide not to allow the magic number, we have to find a way
> to use PTRACE_SETTRAP in UML without having to call it too often (Performance).
> Because of UML's splitting in kernel-obj and user-obj, this might be a bit
> tricky.
> 
> BTW: I see no reason to implement PTRACE_GETTRAP, as
> PTRACE_SETOPTIONS/PTRACE_TRACESYSGOOD give us a way to distinguish between
> syscall interceptions and other SIGTRAPs.

I talked with Uli about the problem and we came up with a more
elegant solution. We already have a debugger specific code in
do_signal that sets up the registers for system call restarting
BEFORE calling the debugger. Only if the debugger did not change
the restart psw and the return value still indicates 
-ERESTARTNOHAND or -ERESTARTSYS we undo this change. In the case
that the debugger did change the psw or the return value we do
not want to restart a system call if another signal is pending.
This is in fact a bug in the signal delivery code. To fix it we
have to set regs->traps to something != __LC_SVC_OLD_PSW while
the debugger has control. regs->traps is reset to the value
indicating a system call if the system call is not restarted
after all.

Will that make UML happy?

blue skies,
  Martin.

---

Index: arch/s390/kernel/signal.c
===================================================================
RCS file: /home/cvs/linux-2.5/arch/s390/kernel/signal.c,v
retrieving revision 1.22
diff -u -p -r1.22 signal.c
--- arch/s390/kernel/signal.c	23 Mar 2005 08:30:01 -0000	1.22
+++ arch/s390/kernel/signal.c	4 May 2005 14:51:31 -0000
@@ -482,6 +482,7 @@ int do_signal(struct pt_regs *regs, sigs
 		} else if (retval == -ERESTART_RESTARTBLOCK) {
 			regs->gprs[2] = -EINTR;
 		}
+		regs->trap = -1;
 	}
 
 	/* Get signal to deliver.  When running under ptrace, at this point
@@ -497,6 +498,7 @@ int do_signal(struct pt_regs *regs, sigs
 			      & SA_RESTART))) {
 			regs->gprs[2] = -EINTR;
 			regs->psw.addr = continue_addr;
+			regs->trap = __LC_SVC_OLD_PSW;
 		}
 	}
 
