Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266509AbUHaEor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266509AbUHaEor (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 00:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266513AbUHaEor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 00:44:47 -0400
Received: from mail1.speakeasy.net ([216.254.0.201]:49375 "EHLO
	mail1.speakeasy.net") by vger.kernel.org with ESMTP id S266509AbUHaEol
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 00:44:41 -0400
Date: Mon, 30 Aug 2004 21:44:38 -0700
Message-Id: <200408310444.i7V4icex001871@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Andrew Cagney <cagney@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] make single-step into signal delivery stop in handler
Emacs: because one operating system isn't enough.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On x86 and x86-64, setting up to run a signal handler clears the
single-step bit (TF) in the processor flags before starting the handler.
This makes sense when a process is handling its own SIGTRAPs.

But when TF is set because PTRACE_SINGLESTEP was used, and that call
specified a handled signal so the handler setup is happening, it doesn't
make so much sense.  When the debugger stops to show you a signal about to
be delivered, and that signal should be handled, and then you do step or
stepi, you expect to see the signal handler code.  In fact, the signal
handler runs to completion and then you see the single-step trap at the
resumed code instead of seeing the handler.  

This patch changes signal handler setup so that when TF is set and the
thread is under ptrace control, it synthesizes a single-step trap after
setting up the PC and registers to start the handler.  This makes that
PTRACE_SINGLESTEP not strictly a "step", since it actually runs no user
instructions at all.  But it is definitely what a debugger user wants, so
that single-stepping always stops and shows each and every instruction
before it gets executed.



Thanks,
Roland

Signed-off-by: Roland McGrath <roland@redhat.com>

--- vanilla-linux-2.6/arch/i386/kernel/signal.c	2004-08-30 20:48:24.132472094 -0700
+++ linux-2.6-ptracefix/arch/i386/kernel/signal.c	2004-08-30 20:47:30.000000000 -0700
@@ -19,6 +19,7 @@
 #include <linux/stddef.h>
 #include <linux/personality.h>
 #include <linux/suspend.h>
+#include <linux/ptrace.h>
 #include <linux/elf.h>
 #include <asm/processor.h>
 #include <asm/ucontext.h>
@@ -401,7 +402,13 @@ static void setup_frame(int sig, struct 
 	regs->xes = __USER_DS;
 	regs->xss = __USER_DS;
 	regs->xcs = __USER_CS;
-	regs->eflags &= ~TF_MASK;
+	if (regs->eflags & TF_MASK) {
+		if (current->ptrace & PT_PTRACED) {
+			ptrace_notify(SIGTRAP);
+		} else {
+			regs->eflags &= ~TF_MASK;
+		}
+	}
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=%p pc=%p ra=%p\n",
@@ -480,7 +487,13 @@ static void setup_rt_frame(int sig, stru
 	regs->xes = __USER_DS;
 	regs->xss = __USER_DS;
 	regs->xcs = __USER_CS;
-	regs->eflags &= ~TF_MASK;
+	if (regs->eflags & TF_MASK) {
+		if (current->ptrace & PT_PTRACED) {
+			ptrace_notify(SIGTRAP);
+		} else {
+			regs->eflags &= ~TF_MASK;
+		}
+	}
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=%p pc=%p ra=%p\n",
--- vanilla-linux-2.6/arch/x86_64/ia32/ia32_signal.c	2004-08-30 20:48:24.160468505 -0700
+++ linux-2.6-ptracefix/arch/x86_64/ia32/ia32_signal.c	2004-08-30 20:47:46.000000000 -0700
@@ -489,7 +491,13 @@ void ia32_setup_frame(int sig, struct k_
 	regs->ss = __USER32_DS; 
 
 	set_fs(USER_DS);
-	regs->eflags &= ~TF_MASK;
+	if (regs->eflags & TF_MASK) {
+		if (current->ptrace & PT_PTRACED) {
+			ptrace_notify(SIGTRAP);
+		} else {
+			regs->eflags &= ~TF_MASK;
+		}
+	}
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=%p pc=%p ra=%p\n",
@@ -583,7 +591,13 @@ void ia32_setup_rt_frame(int sig, struct
 	regs->ss = __USER32_DS; 
 
 	set_fs(USER_DS);
-	regs->eflags &= ~TF_MASK;
+	if (regs->eflags & TF_MASK) {
+		if (current->ptrace & PT_PTRACED) {
+			ptrace_notify(SIGTRAP);
+		} else {
+			regs->eflags &= ~TF_MASK;
+		}
+	}
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=%p pc=%p ra=%p\n",
--- vanilla-linux-2.6/arch/x86_64/kernel/signal.c	2004-08-30 20:48:24.186465171 -0700
+++ linux-2.6-ptracefix/arch/x86_64/kernel/signal.c	2004-08-30 20:47:58.000000000 -0700
@@ -319,7 +319,13 @@ static void setup_rt_frame(int sig, stru
 	regs->rsp = (unsigned long)frame;
 
 	set_fs(USER_DS);
-	regs->eflags &= ~TF_MASK;
+	if (regs->eflags & TF_MASK) {
+		if (current->ptrace & PT_PTRACED) {
+			ptrace_notify(SIGTRAP);
+		} else {
+			regs->eflags &= ~TF_MASK;
+		}
+	}
 
 #ifdef DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=%p pc=%p ra=%p\n",
