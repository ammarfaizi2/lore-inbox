Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262292AbVAUFy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbVAUFy3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 00:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbVAUFy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 00:54:28 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:38481
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262277AbVAUFuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 00:50:06 -0500
Date: Fri, 21 Jan 2005 06:50:04 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <npiggin@novell.com>
Subject: OOM fixes 4/5
Message-ID: <20050121055004.GD12647@dualathlon.random>
References: <20050121054840.GA12647@dualathlon.random> <20050121054916.GB12647@dualathlon.random> <20050121054945.GC12647@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121054945.GC12647@dualathlon.random>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 38 12 CD 76 E4 82 94 AF 02 0C 0F FA E1 FF 55 9D 9B 4F A5 9B
X-Cpushare-SSL-MD5-Cert: ED A5 F2 DA 1D 32 75 60 5E 07 6C 91 BF FC B8 85
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Arcangeli <andrea@suse.de>
Subject: convert memdie to an atomic thread bitflag

On Sat, Dec 25, 2004 at 03:27:21AM +0100, Andrea Arcangeli wrote:
> So my current plan is to make used_math a PF_USED_MATH, and memdie a
> TIF_MEMDIE. And of course oomtaskadj an int (that one requires more than

This makes memdie a TIF_MEMDIE.

memdie will not be modified by the current task, so it cannot be a
PF_MEMDIE but it must be a TIF_MEMDIE.

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

--- mainline-4/include/asm-alpha/thread_info.h.orig	2004-12-04 08:55:03.000000000 +0100
+++ mainline-4/include/asm-alpha/thread_info.h	2005-01-21 06:17:24.780786576 +0100
@@ -77,6 +77,7 @@ register struct thread_info *__current_t
 #define TIF_UAC_NOPRINT		6	/* see sysinfo.h */
 #define TIF_UAC_NOFIX		7
 #define TIF_UAC_SIGBUS		8
+#define TIF_MEMDIE		9
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
--- mainline-4/include/asm-arm/thread_info.h.orig	2005-01-04 01:13:27.000000000 +0100
+++ mainline-4/include/asm-arm/thread_info.h	2005-01-21 06:17:24.792784752 +0100
@@ -128,6 +128,7 @@ extern void iwmmxt_task_release(struct t
 #define TIF_SYSCALL_TRACE	8
 #define TIF_POLLING_NRFLAG	16
 #define TIF_USING_IWMMXT	17
+#define TIF_MEMDIE		18
 
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
--- mainline-4/include/asm-arm26/thread_info.h.orig	2005-01-15 20:44:58.000000000 +0100
+++ mainline-4/include/asm-arm26/thread_info.h	2005-01-21 06:17:24.797783992 +0100
@@ -126,6 +126,7 @@ extern void free_thread_info(struct thre
 #define TIF_SYSCALL_TRACE	8
 #define TIF_USED_FPU		16
 #define TIF_POLLING_NRFLAG	17
+#define TIF_MEMDIE		18
 
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
--- mainline-4/include/asm-cris/thread_info.h.orig	2003-07-10 19:33:07.000000000 +0200
+++ mainline-4/include/asm-cris/thread_info.h	2005-01-21 06:17:24.803783080 +0100
@@ -85,6 +85,7 @@ struct thread_info {
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
+#define TIF_MEMDIE		17
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
--- mainline-4/include/asm-h8300/thread_info.h.orig	2004-08-25 02:47:35.000000000 +0200
+++ mainline-4/include/asm-h8300/thread_info.h	2005-01-21 06:17:24.814781408 +0100
@@ -93,6 +93,7 @@ static inline struct thread_info *curren
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling
 					   TIF_NEED_RESCHED */
+#define TIF_MEMDIE		5
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
--- mainline-4/include/asm-i386/thread_info.h.orig	2005-01-04 01:13:27.000000000 +0100
+++ mainline-4/include/asm-i386/thread_info.h	2005-01-21 06:17:24.828779280 +0100
@@ -141,6 +141,7 @@ register unsigned long current_stack_poi
 #define TIF_IRET		5	/* return with iret */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
+#define TIF_MEMDIE		17
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
--- mainline-4/include/asm-ia64/thread_info.h.orig	2004-12-04 08:55:04.000000000 +0100
+++ mainline-4/include/asm-ia64/thread_info.h	2005-01-21 06:17:24.841777304 +0100
@@ -67,6 +67,7 @@ struct thread_info {
 #define TIF_SYSCALL_TRACE	3	/* syscall trace active */
 #define TIF_SYSCALL_AUDIT	4	/* syscall auditing active */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
+#define TIF_MEMDIE		17
 
 #define TIF_WORK_MASK		0x7	/* like TIF_ALLWORK_BITS but sans TIF_SYSCALL_TRACE */
 #define TIF_ALLWORK_MASK	0x1f	/* bits 0..4 are "work to do on user-return" bits */
--- mainline-4/include/asm-m68k/thread_info.h.orig	2004-08-25 02:47:35.000000000 +0200
+++ mainline-4/include/asm-m68k/thread_info.h	2005-01-21 06:17:24.851775784 +0100
@@ -48,6 +48,7 @@ struct thread_info {
 #define TIF_NOTIFY_RESUME	2	/* resumption notification requested */
 #define TIF_SIGPENDING		3	/* signal pending */
 #define TIF_NEED_RESCHED	4	/* rescheduling necessary */
+#define TIF_MEMDIE		5
 
 extern int thread_flag_fixme(void);
 
--- mainline-4/include/asm-m68knommu/thread_info.h.orig	2005-01-15 20:44:59.000000000 +0100
+++ mainline-4/include/asm-m68knommu/thread_info.h	2005-01-21 06:17:24.858774720 +0100
@@ -85,6 +85,7 @@ static inline struct thread_info *curren
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling
 					   TIF_NEED_RESCHED */
+#define TIF_MEMDIE		5
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
--- mainline-4/include/asm-mips/thread_info.h.orig	2005-01-04 01:13:29.000000000 +0100
+++ mainline-4/include/asm-mips/thread_info.h	2005-01-21 06:17:24.871772744 +0100
@@ -116,6 +116,7 @@ register struct thread_info *__current_t
 #define TIF_SYSCALL_AUDIT	4	/* syscall auditing active */
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling TIF_NEED_RESCHED */
+#define TIF_MEMDIE		18
 #define TIF_SYSCALL_TRACE	31	/* syscall trace active */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
--- mainline-4/include/asm-parisc/thread_info.h.orig	2005-01-04 01:13:29.000000000 +0100
+++ mainline-4/include/asm-parisc/thread_info.h	2005-01-21 06:17:24.885770616 +0100
@@ -63,6 +63,7 @@ struct thread_info {
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_32BIT               5       /* 32 bit binary */
+#define TIF_MEMDIE		6
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
--- mainline-4/include/asm-ppc/thread_info.h.orig	2005-01-04 01:13:29.000000000 +0100
+++ mainline-4/include/asm-ppc/thread_info.h	2005-01-21 06:17:24.892769552 +0100
@@ -76,6 +76,7 @@ static inline struct thread_info *curren
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling
 					   TIF_NEED_RESCHED */
+#define TIF_MEMDIE		5
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
--- mainline-4/include/asm-ppc64/thread_info.h.orig	2005-01-20 18:20:10.000000000 +0100
+++ mainline-4/include/asm-ppc64/thread_info.h	2005-01-21 06:17:50.185924408 +0100
@@ -100,6 +100,7 @@ static inline struct thread_info *curren
 #define TIF_ABI_PENDING		7	/* 32/64 bit switch needed */
 #define TIF_SYSCALL_AUDIT	8	/* syscall auditing active */
 #define TIF_SINGLESTEP		9	/* singlestepping active */
+#define TIF_MEMDIE		10
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
--- mainline-4/include/asm-s390/thread_info.h.orig	2004-12-04 08:55:04.000000000 +0100
+++ mainline-4/include/asm-s390/thread_info.h	2005-01-21 06:17:24.911766664 +0100
@@ -100,6 +100,7 @@ static inline struct thread_info *curren
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling 
 					   TIF_NEED_RESCHED */
 #define TIF_31BIT		18	/* 32bit process */ 
+#define TIF_MEMDIE		19
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
--- mainline-4/include/asm-sh/thread_info.h.orig	2005-01-04 01:13:29.000000000 +0100
+++ mainline-4/include/asm-sh/thread_info.h	2005-01-21 06:17:24.919765448 +0100
@@ -83,6 +83,7 @@ static inline struct thread_info *curren
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling TIF_NEED_RESCHED */
+#define TIF_MEMDIE		18
 #define TIF_USERSPACE		31	/* true if FS sets userspace */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
--- mainline-4/include/asm-sh64/thread_info.h.orig	2004-08-25 02:47:51.000000000 +0200
+++ mainline-4/include/asm-sh64/thread_info.h	2005-01-21 06:17:24.925764536 +0100
@@ -74,6 +74,7 @@ static inline struct thread_info *curren
 #define TIF_SYSCALL_TRACE	0	/* syscall trace active */
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
+#define TIF_MEMDIE		4
 
 #define THREAD_SIZE	16384
 
--- mainline-4/include/asm-sparc/thread_info.h.orig	2004-08-25 02:47:35.000000000 +0200
+++ mainline-4/include/asm-sparc/thread_info.h	2005-01-21 06:17:24.930763776 +0100
@@ -138,6 +138,7 @@ BTFIXUPDEF_CALL(void, free_thread_info, 
 					 * this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	9	/* true if poll_idle() is polling
 					 * TIF_NEED_RESCHED */
+#define TIF_MEMDIE		10
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
--- mainline-4/include/asm-sparc64/thread_info.h.orig	2004-08-25 02:47:57.000000000 +0200
+++ mainline-4/include/asm-sparc64/thread_info.h	2005-01-21 06:17:24.937762712 +0100
@@ -228,6 +228,7 @@ register struct thread_info *current_thr
  *       an immediate value in instructions such as andcc.
  */
 #define TIF_ABI_PENDING		12
+#define TIF_MEMDIE		13
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
--- mainline-4/include/asm-um/thread_info.h.orig	2005-01-15 20:45:00.000000000 +0100
+++ mainline-4/include/asm-um/thread_info.h	2005-01-21 06:17:24.943761800 +0100
@@ -71,6 +71,7 @@ static inline struct thread_info *curren
 					 * TIF_NEED_RESCHED 
 					 */
 #define TIF_RESTART_BLOCK 	4
+#define TIF_MEMDIE	 	5
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
--- mainline-4/include/asm-v850/thread_info.h.orig	2003-06-17 11:31:42.000000000 +0200
+++ mainline-4/include/asm-v850/thread_info.h	2005-01-21 06:17:24.954760128 +0100
@@ -83,6 +83,7 @@ struct thread_info {
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling
 					   TIF_NEED_RESCHED */
+#define TIF_MEMDIE		5
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
--- mainline-4/include/asm-x86_64/thread_info.h.orig	2005-01-04 01:13:29.000000000 +0100
+++ mainline-4/include/asm-x86_64/thread_info.h	2005-01-21 06:17:24.965758456 +0100
@@ -106,6 +106,7 @@ static inline struct thread_info *stack_
 #define TIF_IA32		17	/* 32bit process */ 
 #define TIF_FORK		18	/* ret_from_fork */
 #define TIF_ABI_PENDING		19
+#define TIF_MEMDIE		20
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
--- mainline-4/include/linux/sched.h.orig	2005-01-21 06:01:08.585190864 +0100
+++ mainline-4/include/linux/sched.h	2005-01-21 06:17:24.967758152 +0100
@@ -615,11 +615,6 @@ struct task_struct {
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
--- mainline-4/include/asm-m32r/thread_info.h.orig	2005-01-15 20:44:59.000000000 +0100
+++ mainline-4/include/asm-m32r/thread_info.h	2005-01-21 06:18:25.045624928 +0100
@@ -155,6 +155,7 @@ static inline unsigned int get_thread_fa
 #define TIF_IRET		5	/* return with iret */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 					/* 31..28 fault code */
+#define TIF_MEMDIE		17
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
--- mainline-4/mm/oom_kill.c.orig	2005-01-21 06:14:00.290873768 +0100
+++ mainline-4/mm/oom_kill.c	2005-01-21 06:17:24.980756176 +0100
@@ -152,7 +152,8 @@ static struct task_struct * select_bad_p
 			 * This is in the process of releasing memory so wait it
 			 * to finish before killing some other task by mistake.
 			 */
-			if ((p->memdie || (p->flags & PF_EXITING)) && !(p->flags & PF_DEAD))
+			if ((unlikely(test_tsk_thread_flag(p, TIF_MEMDIE)) || (p->flags & PF_EXITING)) &&
+			    !(p->flags & PF_DEAD))
 				return ERR_PTR(-1UL);
 			if (p->flags & PF_SWAPOFF)
 				return p;
@@ -196,7 +197,7 @@ static void __oom_kill_task(task_t *p)
 	 * exit() and clear out its resources quickly...
 	 */
 	p->time_slice = HZ;
-	p->memdie = 1;
+	set_tsk_thread_flag(p, TIF_MEMDIE);
 
 	/* This process has hardware access, be more careful. */
 	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)) {
--- mainline-4/mm/page_alloc.c.orig	2005-01-21 06:09:43.068977440 +0100
+++ mainline-4/mm/page_alloc.c	2005-01-21 06:17:24.996753744 +0100
@@ -756,7 +756,7 @@ __alloc_pages(unsigned int gfp_mask, uns
 	}
 
 	/* This allocation should allow future memory freeing. */
-	if (((p->flags & PF_MEMALLOC) || p->memdie) && !in_interrupt()) {
+	if (((p->flags & PF_MEMALLOC) || unlikely(test_thread_flag(TIF_MEMDIE))) && !in_interrupt()) {
 		/* go through the zonelist yet again, ignoring mins */
 		for (i = 0; (z = zones[i]) != NULL; i++) {
 			page = buffered_rmqueue(z, order, gfp_mask);
