Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbUCZDYL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 22:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263776AbUCZDYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 22:24:11 -0500
Received: from gate.crashing.org ([63.228.1.57]:57736 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263638AbUCZDX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 22:23:56 -0500
Subject: [PATCH] ppc32: Fix racy access to TI_FLAGS
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Content-Type: text/plain
Message-Id: <1080271296.1206.9.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 26 Mar 2004 14:21:37 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The ppc32 syscall entry code could access the thread info flags
in a racy way, thus potentially losing bits sets there at interrupt
time or by another CPU, like NEED_RESCHED or SIGPENDING (ouch !).

This fixes it by moving the potentially racy bit to a different
field (I preferred that rather than turning the access into an
atomic operation for performances reasons).

Please apply,
Ben.

diff -urN linux-2.5/arch/ppc/kernel/entry.S linuxppc-2.5-benh/arch/ppc/kernel/entry.S
--- linux-2.5/arch/ppc/kernel/entry.S	2004-03-01 18:11:11.000000000 +1100
+++ linuxppc-2.5-benh/arch/ppc/kernel/entry.S	2004-03-25 14:10:41.000000000 +1100
@@ -171,9 +171,10 @@
 	bl	do_show_syscall
 #endif /* SHOW_SYSCALLS */
 	rlwinm	r10,r1,0,0,18	/* current_thread_info() */
+	lwz	r11,TI_LOCAL_FLAGS(r10)
+	rlwinm	r11,r11,0,~_TIFL_FORCE_NOERROR
+	stw	r11,TI_LOCAL_FLAGS(r10)
 	lwz	r11,TI_FLAGS(r10)
-	rlwinm	r11,r11,0,~_TIF_FORCE_NOERROR
-	stw	r11,TI_FLAGS(r10)
 	andi.	r11,r11,_TIF_SYSCALL_TRACE
 	bne-	syscall_dotrace
 syscall_dotrace_cont:
@@ -196,8 +197,8 @@
 	cmpl	0,r3,r11
 	rlwinm	r12,r1,0,0,18	/* current_thread_info() */
 	blt+	30f
-	lwz	r11,TI_FLAGS(r12)
-	andi.	r11,r11,_TIF_FORCE_NOERROR
+	lwz	r11,TI_LOCAL_FLAGS(r12)
+	andi.	r11,r11,_TIFL_FORCE_NOERROR
 	bne	30f
 	neg	r3,r3
 	lwz	r10,_CCR(r1)	/* Set SO bit in CR */
diff -urN linux-2.5/include/asm-ppc/ptrace.h linuxppc-2.5-benh/include/asm-ppc/ptrace.h
--- linux-2.5/include/asm-ppc/ptrace.h	2004-03-01 18:13:06.000000000 +1100
+++ linuxppc-2.5-benh/include/asm-ppc/ptrace.h	2004-03-25 14:02:44.000000000 +1100
@@ -49,7 +49,10 @@
 #define instruction_pointer(regs) ((regs)->nip)
 #define user_mode(regs) (((regs)->msr & MSR_PR) != 0)
 
-#define force_successful_syscall_return()   set_thread_flag(TIF_FORCE_NOERROR)
+#define force_successful_syscall_return()   \
+	do { \
+		current_thread_info()->local_flags |= _TIFL_FORCE_NOERROR; \
+	} while(0)
 
 /*
  * We use the least-significant bit of the trap field to indicate
diff -urN linux-2.5/include/asm-ppc/thread_info.h linuxppc-2.5-benh/include/asm-ppc/thread_info.h
--- linux-2.5/include/asm-ppc/thread_info.h	2004-03-01 18:13:06.000000000 +1100
+++ linuxppc-2.5-benh/include/asm-ppc/thread_info.h	2004-03-25 14:03:56.000000000 +1100
@@ -18,6 +18,7 @@
 	struct task_struct	*task;		/* main task structure */
 	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
+	unsigned long		local_flags;	/* non-racy flags */
 	int			cpu;		/* cpu we're on */
 	int			preempt_count;
 	struct restart_block	restart_block;
@@ -28,6 +29,7 @@
 	.task =		&tsk,			\
 	.exec_domain =	&default_exec_domain,	\
 	.flags =	0,			\
+	.local_flags =  0,			\
 	.cpu =		0,			\
 	.preempt_count = 1,			\
 	.restart_block = {			\
@@ -69,8 +71,9 @@
 #define TI_TASK		0
 #define TI_EXECDOMAIN	4
 #define TI_FLAGS	8
-#define TI_CPU		12
-#define TI_PREEMPT	16
+#define TI_LOCAL_FLAGS	12
+#define TI_CPU		16
+#define TI_PREEMPT	20
 
 #define PREEMPT_ACTIVE		0x4000000
 
@@ -83,16 +86,22 @@
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling
 					   TIF_NEED_RESCHED */
-#define TIF_FORCE_NOERROR	5	/* don't return error from current
-					   syscall even if result < 0 */
-
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
-#define _TIF_FORCE_NOERROR	(1<<TIF_FORCE_NOERROR)
+
+/*
+ * Non racy (local) flags bit numbers
+ */
+#define TIFL_FORCE_NOERROR	0	/* don't return error from current
+					   syscall even if result < 0 */
+
+/* as above, but as bit values */
+#define _TIFL_FORCE_NOERROR	(1<<TIFL_FORCE_NOERROR)
+
 
 #endif /* __KERNEL__ */
 


