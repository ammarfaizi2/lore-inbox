Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbULYDZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbULYDZy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 22:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbULYDZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 22:25:54 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:44685 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261478AbULYDZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 22:25:13 -0500
Date: Sat, 25 Dec 2004 04:24:30 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, akpm@osdl.org
Subject: VM fixes [PF_MEMDIE to TIF_MEMDIE] [5/4]
Message-ID: <20041225032430.GT13747@dualathlon.random>
References: <20041224174156.GE13747@dualathlon.random> <20041224100147.32ad4268.davem@davemloft.net> <20041224182219.GH13747@dualathlon.random> <Pine.LNX.4.58.0412241533170.2353@ppc970.osdl.org> <20041225022721.GR13747@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041225022721.GR13747@dualathlon.random>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2004 at 03:27:21AM +0100, Andrea Arcangeli wrote:
> So my current plan is to make used_math a PF_USED_MATH, and memdie a
> TIF_MEMDIE. And of course oomtaskadj an int (that one requires more than

Here it is the first part. This makes memdie a TIF_MEMDIE. It's
incremental with the last 4 patches (so I call this one 5/4).

From: Andrea Arcangeli <andrea@suse.de>
Subject: convert memdie to an atomic thread bitflag

memdie will not be modified by the current task, so it cannot be a
PF_MEMDIE but it must be a TIF_MEMDIE.

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

--- x/include/asm-alpha/thread_info.h.~1~	2004-12-04 08:55:03.000000000 +0100
+++ x/include/asm-alpha/thread_info.h	2004-12-25 03:52:04.377884048 +0100
@@ -77,6 +77,7 @@ register struct thread_info *__current_t
 #define TIF_UAC_NOPRINT		6	/* see sysinfo.h */
 #define TIF_UAC_NOFIX		7
 #define TIF_UAC_SIGBUS		8
+#define TIF_MEMDIE		9
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
--- x/include/asm-arm/thread_info.h.~1~	2004-12-04 08:56:31.000000000 +0100
+++ x/include/asm-arm/thread_info.h	2004-12-25 03:52:50.000000000 +0100
@@ -128,6 +128,7 @@ extern void iwmmxt_task_release(struct t
 #define TIF_SYSCALL_TRACE	8
 #define TIF_POLLING_NRFLAG	16
 #define TIF_USING_IWMMXT	17
+#define TIF_MEMDIE		18
 
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
--- x/include/asm-arm26/thread_info.h.~1~	2004-04-04 08:09:28.000000000 +0200
+++ x/include/asm-arm26/thread_info.h	2004-12-25 03:53:01.000000000 +0100
@@ -125,6 +125,7 @@ extern void free_thread_info(struct thre
 #define TIF_SYSCALL_TRACE	8
 #define TIF_USED_FPU		16
 #define TIF_POLLING_NRFLAG	17
+#define TIF_MEMDIE		18
 
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
--- x/include/asm-cris/thread_info.h.~1~	2003-07-10 19:33:07.000000000 +0200
+++ x/include/asm-cris/thread_info.h	2004-12-25 03:58:28.000000000 +0100
@@ -85,6 +85,7 @@ struct thread_info {
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
+#define TIF_MEMDIE		17
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
--- x/include/asm-h8300/thread_info.h.~1~	2004-08-25 02:47:35.000000000 +0200
+++ x/include/asm-h8300/thread_info.h	2004-12-25 03:53:45.000000000 +0100
@@ -93,6 +93,7 @@ static inline struct thread_info *curren
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling
 					   TIF_NEED_RESCHED */
+#define TIF_MEMDIE		5
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
--- x/include/asm-i386/thread_info.h.~1~	2004-12-04 08:56:31.000000000 +0100
+++ x/include/asm-i386/thread_info.h	2004-12-25 03:54:03.000000000 +0100
@@ -141,6 +141,7 @@ register unsigned long current_stack_poi
 #define TIF_IRET		5	/* return with iret */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
+#define TIF_MEMDIE		17
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
--- x/include/asm-ia64/thread_info.h.~1~	2004-12-04 08:55:04.000000000 +0100
+++ x/include/asm-ia64/thread_info.h	2004-12-25 03:54:38.000000000 +0100
@@ -67,6 +67,7 @@ struct thread_info {
 #define TIF_SYSCALL_TRACE	3	/* syscall trace active */
 #define TIF_SYSCALL_AUDIT	4	/* syscall auditing active */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
+#define TIF_MEMDIE		17
 
 #define TIF_WORK_MASK		0x7	/* like TIF_ALLWORK_BITS but sans TIF_SYSCALL_TRACE */
 #define TIF_ALLWORK_MASK	0x1f	/* bits 0..4 are "work to do on user-return" bits */
--- x/include/asm-m68k/thread_info.h.~1~	2004-08-25 02:47:35.000000000 +0200
+++ x/include/asm-m68k/thread_info.h	2004-12-25 03:55:32.000000000 +0100
@@ -48,6 +48,7 @@ struct thread_info {
 #define TIF_NOTIFY_RESUME	2	/* resumption notification requested */
 #define TIF_SIGPENDING		3	/* signal pending */
 #define TIF_NEED_RESCHED	4	/* rescheduling necessary */
+#define TIF_MEMDIE		5
 
 extern int thread_flag_fixme(void);
 
--- x/include/asm-m68knommu/thread_info.h.~1~	2004-12-04 08:56:32.000000000 +0100
+++ x/include/asm-m68knommu/thread_info.h	2004-12-25 03:55:44.000000000 +0100
@@ -91,6 +91,7 @@ static inline struct thread_info *curren
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling
 					   TIF_NEED_RESCHED */
+#define TIF_MEMDIE		5
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
--- x/include/asm-mips/thread_info.h.~1~	2004-12-04 08:56:32.000000000 +0100
+++ x/include/asm-mips/thread_info.h	2004-12-25 03:55:59.000000000 +0100
@@ -116,6 +116,7 @@ register struct thread_info *__current_t
 #define TIF_SYSCALL_AUDIT	4	/* syscall auditing active */
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling TIF_NEED_RESCHED */
+#define TIF_MEMDIE		18
 #define TIF_SYSCALL_TRACE	31	/* syscall trace active */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
--- x/include/asm-parisc/thread_info.h.~1~	2004-12-04 08:56:32.000000000 +0100
+++ x/include/asm-parisc/thread_info.h	2004-12-25 03:56:10.000000000 +0100
@@ -63,6 +63,7 @@ struct thread_info {
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_32BIT               5       /* 32 bit binary */
+#define TIF_MEMDIE		6
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
--- x/include/asm-ppc/thread_info.h.~1~	2004-12-04 08:56:32.000000000 +0100
+++ x/include/asm-ppc/thread_info.h	2004-12-25 03:56:23.000000000 +0100
@@ -76,6 +76,7 @@ static inline struct thread_info *curren
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling
 					   TIF_NEED_RESCHED */
+#define TIF_MEMDIE		5
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
--- x/include/asm-ppc64/thread_info.h.~1~	2004-12-04 08:56:32.000000000 +0100
+++ x/include/asm-ppc64/thread_info.h	2004-12-25 03:56:34.000000000 +0100
@@ -97,6 +97,7 @@ static inline struct thread_info *curren
 #define TIF_RUN_LIGHT		6	/* iSeries run light */
 #define TIF_ABI_PENDING		7	/* 32/64 bit switch needed */
 #define TIF_SYSCALL_AUDIT	8	/* syscall auditing active */
+#define TIF_MEMDIE		9
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
--- x/include/asm-s390/thread_info.h.~1~	2004-12-04 08:55:04.000000000 +0100
+++ x/include/asm-s390/thread_info.h	2004-12-25 03:56:45.000000000 +0100
@@ -100,6 +100,7 @@ static inline struct thread_info *curren
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling 
 					   TIF_NEED_RESCHED */
 #define TIF_31BIT		18	/* 32bit process */ 
+#define TIF_MEMDIE		19
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
--- x/include/asm-sh/thread_info.h.~1~	2004-12-04 08:56:32.000000000 +0100
+++ x/include/asm-sh/thread_info.h	2004-12-25 03:56:58.000000000 +0100
@@ -83,6 +83,7 @@ static inline struct thread_info *curren
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling TIF_NEED_RESCHED */
+#define TIF_MEMDIE		18
 #define TIF_USERSPACE		31	/* true if FS sets userspace */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
--- x/include/asm-sh64/thread_info.h.~1~	2004-08-25 02:47:51.000000000 +0200
+++ x/include/asm-sh64/thread_info.h	2004-12-25 03:57:08.000000000 +0100
@@ -74,6 +74,7 @@ static inline struct thread_info *curren
 #define TIF_SYSCALL_TRACE	0	/* syscall trace active */
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
+#define TIF_MEMDIE		4
 
 #define THREAD_SIZE	16384
 
--- x/include/asm-sparc/thread_info.h.~1~	2004-08-25 02:47:35.000000000 +0200
+++ x/include/asm-sparc/thread_info.h	2004-12-25 03:57:18.000000000 +0100
@@ -138,6 +138,7 @@ BTFIXUPDEF_CALL(void, free_thread_info, 
 					 * this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	9	/* true if poll_idle() is polling
 					 * TIF_NEED_RESCHED */
+#define TIF_MEMDIE		10
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
--- x/include/asm-sparc64/thread_info.h.~1~	2004-08-25 02:47:57.000000000 +0200
+++ x/include/asm-sparc64/thread_info.h	2004-12-25 03:57:29.000000000 +0100
@@ -228,6 +228,7 @@ register struct thread_info *current_thr
  *       an immediate value in instructions such as andcc.
  */
 #define TIF_ABI_PENDING		12
+#define TIF_MEMDIE		13
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
--- x/include/asm-um/thread_info.h.~1~	2004-12-04 08:56:32.000000000 +0100
+++ x/include/asm-um/thread_info.h	2004-12-25 03:57:42.000000000 +0100
@@ -71,6 +71,7 @@ static inline struct thread_info *curren
 					 * TIF_NEED_RESCHED 
 					 */
 #define TIF_RESTART_BLOCK 	4
+#define TIF_MEMDIE	 	5
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
--- x/include/asm-v850/thread_info.h.~1~	2003-06-17 11:31:42.000000000 +0200
+++ x/include/asm-v850/thread_info.h	2004-12-25 03:57:51.000000000 +0100
@@ -83,6 +83,7 @@ struct thread_info {
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling
 					   TIF_NEED_RESCHED */
+#define TIF_MEMDIE		5
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
--- x/include/asm-x86_64/thread_info.h.~1~	2004-12-04 08:56:32.000000000 +0100
+++ x/include/asm-x86_64/thread_info.h	2004-12-25 03:58:00.000000000 +0100
@@ -106,6 +106,7 @@ static inline struct thread_info *stack_
 #define TIF_IA32		17	/* 32bit process */ 
 #define TIF_FORK		18	/* ret_from_fork */
 #define TIF_ABI_PENDING		19
+#define TIF_MEMDIE		20
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
--- x/include/linux/sched.h.~1~	2004-12-25 03:49:05.883019392 +0100
+++ x/include/linux/sched.h	2004-12-25 03:59:16.000000000 +0100
@@ -601,11 +601,6 @@ struct task_struct {
 	struct key *thread_keyring;	/* keyring private to this thread */
 #endif
 /*
- * All archs should support atomic ops with
- * 1 byte granularity.
- */
-	unsigned char memdie;
-/*
  * Must be changed atomically so it shouldn't be
  * be a shareable bitflag.
  */
--- x/include/asm-m32r/thread_info.h.~1~	2004-12-04 08:55:04.000000000 +0100
+++ x/include/asm-m32r/thread_info.h	2004-12-25 03:55:23.000000000 +0100
@@ -123,6 +123,7 @@ static inline struct thread_info *curren
 #define TIF_SINGLESTEP		4	/* restore singlestep on return to user mode */
 #define TIF_IRET		5	/* return with iret */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
+#define TIF_MEMDIE		17
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
--- x/mm/oom_kill.c.~1~	2004-12-25 03:49:05.000000000 +0100
+++ x/mm/oom_kill.c	2004-12-25 04:16:46.300597552 +0100
@@ -151,7 +151,8 @@ static struct task_struct * select_bad_p
 			 * This is in the process of releasing memory so wait it
 			 * to finish before killing some other task by mistake.
 			 */
-			if ((p->memdie || (p->flags & PF_EXITING)) && !(p->flags & PF_DEAD))
+			if ((unlikely(test_tsk_thread_flag(p, TIF_MEMDIE)) || (p->flags & PF_EXITING)) &&
+			    !(p->flags & PF_DEAD))
 				return ERR_PTR(-1UL);
 			if (p->flags & PF_SWAPOFF)
 				return p;
@@ -195,7 +196,7 @@ static void __oom_kill_task(task_t *p)
 	 * exit() and clear out its resources quickly...
 	 */
 	p->time_slice = HZ;
-	p->memdie = 1;
+	set_tsk_thread_flag(p, TIF_MEMDIE);
 
 	/* This process has hardware access, be more careful. */
 	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)) {
--- x/mm/page_alloc.c.~1~	2004-12-25 03:49:05.000000000 +0100
+++ x/mm/page_alloc.c	2004-12-25 04:01:41.000000000 +0100
@@ -663,7 +663,7 @@ __alloc_pages(unsigned int gfp_mask, uns
 	}
 
 	/* This allocation should allow future memory freeing. */
-	if (((p->flags & PF_MEMALLOC) || p->memdie) && !in_interrupt()) {
+	if (((p->flags & PF_MEMALLOC) || unlikely(test_thread_flag(TIF_MEMDIE))) && !in_interrupt()) {
 		/* go through the zonelist yet again, ignoring mins */
 		for (i = 0; (z = zones[i]) != NULL; i++) {
 			page = buffered_rmqueue(z, order, gfp_mask);
