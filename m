Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272764AbRIWDv4>; Sat, 22 Sep 2001 23:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273240AbRIWDvt>; Sat, 22 Sep 2001 23:51:49 -0400
Received: from granger.mail.mindspring.net ([207.69.200.148]:31039 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S272764AbRIWDvk>; Sat, 22 Sep 2001 23:51:40 -0400
Subject: [PATCH][RFC] preemptive kernel: ptrace fix
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: george@mvista.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.21.20.26 (Preview Release)
Date: 22 Sep 2001 23:52:12 -0400
Message-Id: <1001217135.1390.19.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed (actually, I had a thought ptrace wouldnt work under
preemption) that strace sometimes locks under the preemptible kernel,
although is killable by CTRL-C.

The following is from arch/i386/kernel/ptrace.c :: syscall_trace:

1	current->state = TASK_STOPPED;
2	notify_parent(current, SIGCHLD);
3	schedule();

What if, between line one and two, preemption occurs?  Now the task
state is TASK_STOPPED, and thus will never be rescheduled.  I presume
this is the problem.  The attached patch fixes this.

Running multiple straces in a tight loop for over an hour shows me the
problem is fixed.  Its obvious the above is a problem anyhow.

However, doing an `strace strace whatever' (ie, stracing strace), it
still enters a stopped state about 20% of the time (before the patch, it
locked almost 100%).  I can't figure out why.  Comments?

Yes, stracing strace is contorted and I don't care, but something else
is obviously wrong -- you can do so on a non-preemption machine.


diff -urN linux-2.4.9-ac14-preempt/arch/i386/kernel/ptrace.c linux/arch/i386/kernel/ptrace.c > patch-rml-2.4.9-ac14-preempt-strace-fix-1
--- linux-2.4.9-ac14-preempt/arch/i386/kernel/ptrace.c	Sat Sep 22 23:20:41 2001+++ linux/arch/i386/kernel/ptrace.c	Sat Sep 22 23:42:11 2001
@@ -455,9 +455,11 @@
 	   between a syscall stop and SIGTRAP delivery */
 	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
 					? 0x80 : 0);
+	ctx_sw_off();
 	current->state = TASK_STOPPED;
 	notify_parent(current, SIGCHLD);
 	schedule();
+	ctx_sw_on();
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the


-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

