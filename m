Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263411AbVGARIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263411AbVGARIw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 13:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263409AbVGARIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 13:08:51 -0400
Received: from graphe.net ([209.204.138.32]:12474 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S263406AbVGARHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 13:07:05 -0400
Date: Fri, 1 Jul 2005 10:06:47 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Pavel Machek <pavel@ucw.cz>
cc: Kirill Korotaev <dev@sw.ru>, Linus Torvalds <torvalds@osdl.org>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: [SUSPEND 1/2]Replace PF_FREEZE with TIF_FREEZE
In-Reply-To: <20050628124750.GB11129@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.62.0507011004100.17205@graphe.net>
References: <Pine.LNX.4.62.0506242311220.7971@graphe.net>
 <20050626023053.GA2871@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.62.0506251954470.26198@graphe.net>
 <20050626030925.GA4156@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.62.0506261928010.1679@graphe.net>
 <Pine.LNX.4.58.0506262121070.19755@ppc970.osdl.org>
 <Pine.LNX.4.62.0506262249080.4374@graphe.net> <20050627141320.GA4945@atrey.karlin.mff.cuni.cz>
 <Pine.LNX.4.62.0506270804450.17400@graphe.net> <42C0EBAB.8070709@sw.ru>
 <20050628124750.GB11129@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current suspend code modifies thread->flags from outside the context of the
thread. This creates a SMP race.

This patch fixes that by introducing a TIF_FREEZE flag in thread_info

(This is not the end of the races in the suspend code since TIF_FREEZE is cleared
when setting PF_FROZEN creating a window for freeze_processes())

Signed-off-by: Christoph Lameter <christoph@lameter.com>

Index: linux-2.6.12/include/linux/sched.h
===================================================================
--- linux-2.6.12.orig/include/linux/sched.h	2005-06-30 23:26:07.000000000 +0000
+++ linux-2.6.12/include/linux/sched.h	2005-06-30 23:39:12.000000000 +0000
@@ -807,7 +807,6 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_MEMALLOC	0x00000800	/* Allocating memory */
 #define PF_FLUSHER	0x00001000	/* responsible for disk writeback */
 #define PF_USED_MATH	0x00002000	/* if unset the fpu must be initialized before use */
-#define PF_FREEZE	0x00004000	/* this task is being frozen for suspend now */
 #define PF_NOFREEZE	0x00008000	/* this thread should not be frozen */
 #define PF_FROZEN	0x00010000	/* frozen for system suspend */
 #define PF_FSTRANS	0x00020000	/* inside a filesystem transaction */
@@ -1283,16 +1282,15 @@ static inline int frozen(struct task_str
  */
 static inline int freezing(struct task_struct *p)
 {
-	return p->flags & PF_FREEZE;
+	return test_ti_thread_flag(p->thread_info, TIF_FREEZE);
 }
 
 /*
  * Request that a process be frozen
- * FIXME: SMP problem. We may not modify other process' flags!
  */
 static inline void freeze(struct task_struct *p)
 {
-	p->flags |= PF_FREEZE;
+	set_ti_thread_flag(p->thread_info, TIF_FREEZE);
 }
 
 /*
@@ -1313,7 +1311,8 @@ static inline int thaw_process(struct ta
  */
 static inline void frozen_process(struct task_struct *p)
 {
-	p->flags = (p->flags & ~PF_FREEZE) | PF_FROZEN;
+	p->flags |= PF_FROZEN;
+	clear_ti_thread_flag(p->thread_info, TIF_FREEZE);
 }
 
 extern void refrigerator(void);
Index: linux-2.6.12/include/asm-x86_64/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-x86_64/thread_info.h	2005-06-30 23:26:07.000000000 +0000
+++ linux-2.6.12/include/asm-x86_64/thread_info.h	2005-06-30 23:26:35.000000000 +0000
@@ -108,6 +108,7 @@ static inline struct thread_info *stack_
 #define TIF_FORK		18	/* ret_from_fork */
 #define TIF_ABI_PENDING		19
 #define TIF_MEMDIE		20
+#define TIF_FREEZE		21	/* Freeze process */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
Index: linux-2.6.12/include/asm-ia64/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-ia64/thread_info.h	2005-06-30 23:26:07.000000000 +0000
+++ linux-2.6.12/include/asm-ia64/thread_info.h	2005-06-30 23:26:35.000000000 +0000
@@ -76,6 +76,7 @@ struct thread_info {
 #define TIF_SIGDELAYED		5	/* signal delayed from MCA/INIT/NMI/PMI context */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		17
+#define TIF_FREEZE		18	/* Freeze process */
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
Index: linux-2.6.12/include/asm-i386/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-i386/thread_info.h	2005-06-30 23:26:07.000000000 +0000
+++ linux-2.6.12/include/asm-i386/thread_info.h	2005-06-30 23:26:35.000000000 +0000
@@ -143,6 +143,7 @@ register unsigned long current_stack_poi
 #define TIF_SECCOMP		8	/* secure computing */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		17
+#define TIF_FREEZE		18	/* Freeze thread */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
Index: linux-2.6.12/include/asm-xtensa/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-xtensa/thread_info.h	2005-06-30 23:26:07.000000000 +0000
+++ linux-2.6.12/include/asm-xtensa/thread_info.h	2005-06-30 23:26:35.000000000 +0000
@@ -118,6 +118,7 @@ static inline struct thread_info *curren
 #define TIF_SINGLESTEP		4	/* restore singlestep on return to user mode */
 #define TIF_IRET		5	/* return with iret */
 #define TIF_MEMDIE		6
+#define TIF_FREEZE		7
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
Index: linux-2.6.12/include/asm-h8300/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-h8300/thread_info.h	2005-06-30 23:26:07.000000000 +0000
+++ linux-2.6.12/include/asm-h8300/thread_info.h	2005-06-30 23:26:35.000000000 +0000
@@ -94,6 +94,7 @@ static inline struct thread_info *curren
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling
 					   TIF_NEED_RESCHED */
 #define TIF_MEMDIE		5
+#define TIF_FREEZE		6
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
Index: linux-2.6.12/include/asm-ppc/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-ppc/thread_info.h	2005-06-30 23:26:07.000000000 +0000
+++ linux-2.6.12/include/asm-ppc/thread_info.h	2005-06-30 23:26:35.000000000 +0000
@@ -80,6 +80,7 @@ static inline struct thread_info *curren
 #define TIF_MEMDIE		5
 #define TIF_SYSCALL_AUDIT       6       /* syscall auditing active */
 #define TIF_SECCOMP             7      /* secure computing */
+#define TIF_FREEZE		8
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
Index: linux-2.6.12/include/asm-sh64/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-sh64/thread_info.h	2005-06-30 23:26:07.000000000 +0000
+++ linux-2.6.12/include/asm-sh64/thread_info.h	2005-06-30 23:26:35.000000000 +0000
@@ -80,6 +80,7 @@ static inline struct thread_info *curren
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_MEMDIE		4
+#define TIF_FREEZE		5
 
 
 #endif /* __KERNEL__ */
Index: linux-2.6.12/include/asm-alpha/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-alpha/thread_info.h	2005-06-30 23:26:07.000000000 +0000
+++ linux-2.6.12/include/asm-alpha/thread_info.h	2005-06-30 23:26:35.000000000 +0000
@@ -78,6 +78,7 @@ register struct thread_info *__current_t
 #define TIF_UAC_NOFIX		7
 #define TIF_UAC_SIGBUS		8
 #define TIF_MEMDIE		9
+#define TIF_FREEZE		10
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
Index: linux-2.6.12/include/asm-sparc/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-sparc/thread_info.h	2005-06-30 23:26:07.000000000 +0000
+++ linux-2.6.12/include/asm-sparc/thread_info.h	2005-06-30 23:26:35.000000000 +0000
@@ -139,6 +139,7 @@ BTFIXUPDEF_CALL(void, free_thread_info, 
 #define TIF_POLLING_NRFLAG	9	/* true if poll_idle() is polling
 					 * TIF_NEED_RESCHED */
 #define TIF_MEMDIE		10
+#define TIF_FREEZE		11
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
Index: linux-2.6.12/include/asm-frv/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-frv/thread_info.h	2005-06-30 23:26:07.000000000 +0000
+++ linux-2.6.12/include/asm-frv/thread_info.h	2005-06-30 23:26:35.000000000 +0000
@@ -133,6 +133,7 @@ register struct thread_info *__current_t
 #define TIF_IRET		5	/* return with iret */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		17	/* OOM killer killed process */
+#define TIF_FREEZE		18
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
Index: linux-2.6.12/include/asm-parisc/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-parisc/thread_info.h	2005-06-30 23:26:07.000000000 +0000
+++ linux-2.6.12/include/asm-parisc/thread_info.h	2005-06-30 23:26:35.000000000 +0000
@@ -64,6 +64,7 @@ struct thread_info {
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_32BIT               5       /* 32 bit binary */
 #define TIF_MEMDIE		6
+#define TIF_FREEZE		7
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
Index: linux-2.6.12/include/asm-m68knommu/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-m68knommu/thread_info.h	2005-06-30 23:26:07.000000000 +0000
+++ linux-2.6.12/include/asm-m68knommu/thread_info.h	2005-06-30 23:26:35.000000000 +0000
@@ -91,6 +91,7 @@ static inline struct thread_info *curren
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling
 					   TIF_NEED_RESCHED */
 #define TIF_MEMDIE		5
+#define TIF_FREEZE		6
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
Index: linux-2.6.12/include/asm-m68k/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-m68k/thread_info.h	2005-06-30 23:26:07.000000000 +0000
+++ linux-2.6.12/include/asm-m68k/thread_info.h	2005-06-30 23:26:35.000000000 +0000
@@ -49,6 +49,7 @@ struct thread_info {
 #define TIF_SIGPENDING		3	/* signal pending */
 #define TIF_NEED_RESCHED	4	/* rescheduling necessary */
 #define TIF_MEMDIE		5
+#define TIF_FREEZE		6
 
 extern int thread_flag_fixme(void);
 
Index: linux-2.6.12/include/asm-sh/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-sh/thread_info.h	2005-06-30 23:26:07.000000000 +0000
+++ linux-2.6.12/include/asm-sh/thread_info.h	2005-06-30 23:26:35.000000000 +0000
@@ -84,6 +84,7 @@ static inline struct thread_info *curren
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		18
+#define TIF_FREEZE		19
 #define TIF_USERSPACE		31	/* true if FS sets userspace */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
Index: linux-2.6.12/include/asm-s390/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-s390/thread_info.h	2005-06-30 23:26:07.000000000 +0000
+++ linux-2.6.12/include/asm-s390/thread_info.h	2005-06-30 23:26:35.000000000 +0000
@@ -102,6 +102,7 @@ static inline struct thread_info *curren
 					   TIF_NEED_RESCHED */
 #define TIF_31BIT		18	/* 32bit process */ 
 #define TIF_MEMDIE		19
+#define TIF_FREEZE		20
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
Index: linux-2.6.12/include/asm-arm/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-arm/thread_info.h	2005-06-30 23:26:07.000000000 +0000
+++ linux-2.6.12/include/asm-arm/thread_info.h	2005-06-30 23:26:35.000000000 +0000
@@ -132,6 +132,7 @@ extern void iwmmxt_task_release(struct t
 #define TIF_POLLING_NRFLAG	16
 #define TIF_USING_IWMMXT	17
 #define TIF_MEMDIE		18
+#define TIF_FREEZE		19
 
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
Index: linux-2.6.12/include/asm-v850/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-v850/thread_info.h	2005-06-30 23:26:07.000000000 +0000
+++ linux-2.6.12/include/asm-v850/thread_info.h	2005-06-30 23:26:35.000000000 +0000
@@ -85,6 +85,7 @@ struct thread_info {
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling
 					   TIF_NEED_RESCHED */
 #define TIF_MEMDIE		5
+#define TIF_FREEZE		6
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
Index: linux-2.6.12/include/asm-mips/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-mips/thread_info.h	2005-06-30 23:26:07.000000000 +0000
+++ linux-2.6.12/include/asm-mips/thread_info.h	2005-06-30 23:26:35.000000000 +0000
@@ -117,6 +117,7 @@ register struct thread_info *__current_t
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		18
+#define TIF_FREEZE		19
 #define TIF_SYSCALL_TRACE	31	/* syscall trace active */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
Index: linux-2.6.12/include/asm-cris/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-cris/thread_info.h	2005-06-30 23:26:07.000000000 +0000
+++ linux-2.6.12/include/asm-cris/thread_info.h	2005-06-30 23:26:35.000000000 +0000
@@ -86,6 +86,7 @@ struct thread_info {
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		17
+#define TIF_FREEZE		18
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
Index: linux-2.6.12/include/asm-arm26/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-arm26/thread_info.h	2005-06-30 23:26:07.000000000 +0000
+++ linux-2.6.12/include/asm-arm26/thread_info.h	2005-06-30 23:26:35.000000000 +0000
@@ -127,6 +127,7 @@ extern void free_thread_info(struct thre
 #define TIF_USED_FPU		16
 #define TIF_POLLING_NRFLAG	17
 #define TIF_MEMDIE		18
+#define TIF_FREEZE		19
 
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
Index: linux-2.6.12/include/asm-sparc64/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-sparc64/thread_info.h	2005-06-30 23:26:07.000000000 +0000
+++ linux-2.6.12/include/asm-sparc64/thread_info.h	2005-06-30 23:26:35.000000000 +0000
@@ -229,6 +229,7 @@ register struct thread_info *current_thr
  */
 #define TIF_ABI_PENDING		12
 #define TIF_MEMDIE		13
+#define TIF_FREEZE		14
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
Index: linux-2.6.12/include/asm-m32r/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-m32r/thread_info.h	2005-06-30 23:26:07.000000000 +0000
+++ linux-2.6.12/include/asm-m32r/thread_info.h	2005-06-30 23:26:35.000000000 +0000
@@ -156,6 +156,7 @@ static inline unsigned int get_thread_fa
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 					/* 31..28 fault code */
 #define TIF_MEMDIE		17
+#define TIF_FREEZE		18
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
Index: linux-2.6.12/include/asm-ppc64/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-ppc64/thread_info.h	2005-06-30 23:26:07.000000000 +0000
+++ linux-2.6.12/include/asm-ppc64/thread_info.h	2005-06-30 23:26:35.000000000 +0000
@@ -102,6 +102,7 @@ static inline struct thread_info *curren
 #define TIF_SINGLESTEP		9	/* singlestepping active */
 #define TIF_MEMDIE		10
 #define TIF_SECCOMP		11	/* secure computing */
+#define TIF_FREEZE		12
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
Index: linux-2.6.12/include/asm-um/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-um/thread_info.h	2005-06-30 23:26:07.000000000 +0000
+++ linux-2.6.12/include/asm-um/thread_info.h	2005-06-30 23:26:35.000000000 +0000
@@ -72,6 +72,7 @@ static inline struct thread_info *curren
 #define TIF_RESTART_BLOCK 	4
 #define TIF_MEMDIE	 	5
 #define TIF_SYSCALL_AUDIT	6
+#define TIF_FREEZE		7
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
