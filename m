Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272838AbRIWFRy>; Sun, 23 Sep 2001 01:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273282AbRIWFRo>; Sun, 23 Sep 2001 01:17:44 -0400
Received: from hall.mail.mindspring.net ([207.69.200.60]:26649 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S272838AbRIWFRd>; Sun, 23 Sep 2001 01:17:33 -0400
Subject: Re: [PATCH][RFC] preemptive kernel: ptrace fix
From: Robert Love <rml@ufl.edu>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1001217135.1390.19.camel@phantasy>
In-Reply-To: <1001217135.1390.19.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.21.20.26 (Preview Release)
Date: 23 Sep 2001 01:18:08 -0400
Message-Id: <1001222290.864.3.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-09-22 at 23:52, Robert Love wrote:
> However, doing an `strace strace whatever' (ie, stracing strace), it
> still enters a stopped state about 20% of the time (before the patch, it
> locked almost 100%).  I can't figure out why.  Comments?

I fixed it.  I am not overly sure why it fixes it, but the following
patch (on top of the previous) fixes all the ptrace problems I can find.

In auditing the code, I fixed another problem which I will explain...

I'll put out a final patch in a bit...


diff -urN linux-2.4.9-ac14-preempt/arch/i386/kernel/signal.c linux/arch/i386/kernel/signal.c
--- linux-2.4.9-ac14-preempt/arch/i386/kernel/signal.c	Sat Sep 22 23:20:41 2001
+++ linux/arch/i386/kernel/signal.c	Sun Sep 23 00:51:15 2001
@@ -611,9 +611,11 @@
 		if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {
 			/* Let the debugger run.  */
 			current->exit_code = signr;
+			ctx_sw_off();
 			current->state = TASK_STOPPED;
 			notify_parent(current, SIGCHLD);
 			schedule();
+			ctx_sw_on();
 
 			/* We're back.  Did the debugger cancel the sig?  */
 			if (!(signr = current->exit_code))
@@ -667,11 +669,13 @@
 				/* FALLTHRU */
 
 			case SIGSTOP:
+				ctx_sw_off();
 				current->state = TASK_STOPPED;
 				current->exit_code = signr;
 				if (!(current->p_pptr->sig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDSTOP))
 					notify_parent(current, SIGCHLD);
 				schedule();
+				ctx_sw_on();
 				continue;
 
 			case SIGQUIT: case SIGILL: case SIGTRAP:


-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

