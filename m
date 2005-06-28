Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVF1WA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVF1WA7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 18:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVF1WAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 18:00:24 -0400
Received: from graphe.net ([209.204.138.32]:32204 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261491AbVF1Vyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 17:54:52 -0400
Date: Tue, 28 Jun 2005 14:54:43 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Ray Bryant <raybry@engr.sgi.com>
cc: Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Fix SMP brokenness for PF_FREEZE and make freezing usable
 for other purposes
In-Reply-To: <42C1C627.5040404@engr.sgi.com>
Message-ID: <Pine.LNX.4.62.0506281450490.5895@graphe.net>
References: <Pine.LNX.4.62.0506241316370.30503@graphe.net>
 <20050625025122.GC22393@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.62.0506242311220.7971@graphe.net>
 <20050626023053.GA2871@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.62.0506251954470.26198@graphe.net>
 <20050626030925.GA4156@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.62.0506261928010.1679@graphe.net>
 <Pine.LNX.4.58.0506262121070.19755@ppc970.osdl.org>
 <Pine.LNX.4.62.0506262249080.4374@graphe.net> <42C1C627.5040404@engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2005, Ray Bryant wrote:

> >  -			freeze(p);
> > +			set_thread_flag(TIF_FREEZE);
> 
> Shouldn't that be "set_ti_thread_flag(p->thread_info, TIF_FREEZE)"?
> Otherwise you freeze current, not the thread "p".

Correct. Which also means that we have not progressed yet beyond an 
academic version of the patch:

---

Revise handling of freezing in the suspend code

The current suspend code modifies thread flags from outside the context of process.
This creates a SMP race.

The patch fixes that by introducing a TIF_FREEZE flag (for all arches). Also

- Uses a completion handler instead of waiting in a schedule loop in the refrigerator.

- Introduces a semaphore freezer_sem to provide a way that multiple kernel
  subsystems can use the freezing ability without interfering with one another.

- Include necessary definitions for the migration code if CONFIG_MIGRATE is set.

- Removes PF_FREEZE

Signed-off-by: Christoph Lameter <christoph@lameter.com>

Index: linux-2.6.12/include/linux/sched.h
===================================================================
--- linux-2.6.12.orig/include/linux/sched.h	2005-06-27 05:20:15.000000000 +0000
+++ linux-2.6.12/include/linux/sched.h	2005-06-28 06:34:52.000000000 +0000
@@ -804,7 +804,6 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_MEMALLOC	0x00000800	/* Allocating memory */
 #define PF_FLUSHER	0x00001000	/* responsible for disk writeback */
 #define PF_USED_MATH	0x00002000	/* if unset the fpu must be initialized before use */
-#define PF_FREEZE	0x00004000	/* this task is being frozen for suspend now */
 #define PF_NOFREEZE	0x00008000	/* this thread should not be frozen */
 #define PF_FROZEN	0x00010000	/* frozen for system suspend */
 #define PF_FSTRANS	0x00020000	/* inside a filesystem transaction */
@@ -1265,78 +1264,37 @@ extern void normalize_rt_tasks(void);
 
 #endif
 
-#ifdef CONFIG_PM
-/*
- * Check if a process has been frozen
- */
-static inline int frozen(struct task_struct *p)
-{
-	return p->flags & PF_FROZEN;
-}
-
-/*
- * Check if there is a request to freeze a process
- */
-static inline int freezing(struct task_struct *p)
-{
-	return p->flags & PF_FREEZE;
-}
+#if defined(CONFIG_PM) || defined(CONFIG_MIGRATE)
+extern struct semaphore freezer_sem;
+extern struct completion thaw;
 
-/*
- * Request that a process be frozen
- * FIXME: SMP problem. We may not modify other process' flags!
- */
-static inline void freeze(struct task_struct *p)
-{
-	p->flags |= PF_FREEZE;
-}
-
-/*
- * Wake up a frozen process
- */
-static inline int thaw_process(struct task_struct *p)
-{
-	if (frozen(p)) {
-		p->flags &= ~PF_FROZEN;
-		wake_up_process(p);
-		return 1;
-	}
-	return 0;
-}
+extern void refrigerator(void);
 
-/*
- * freezing is complete, mark process as frozen
- */
-static inline void frozen_process(struct task_struct *p)
+static inline int freezing(struct task_struct *p)
 {
-	p->flags = (p->flags & ~PF_FREEZE) | PF_FROZEN;
+	return test_ti_thread_flag(p->thread_info, TIF_FREEZE);
 }
 
-extern void refrigerator(void);
-extern int freeze_processes(void);
-extern void thaw_processes(void);
-
 static inline int try_to_freeze(void)
 {
-	if (freezing(current)) {
+	if (test_thread_flag(TIF_FREEZE)) {
 		refrigerator();
 		return 1;
 	} else
 		return 0;
 }
 #else
-static inline int frozen(struct task_struct *p) { return 0; }
+static inline void refrigerator(void) {}
 static inline int freezing(struct task_struct *p) { return 0; }
-static inline void freeze(struct task_struct *p) { BUG(); }
-static inline int thaw_process(struct task_struct *p) { return 1; }
-static inline void frozen_process(struct task_struct *p) { BUG(); }
+static inline int try_to_freeze(void) { return 0; }
+#endif
 
-static inline void refrigerator(void) {}
+#ifdef CONFIG_PM
+extern int freeze_processes(void);
+extern void thaw_processes(void);
+#else
 static inline int freeze_processes(void) { BUG(); return 0; }
 static inline void thaw_processes(void) {}
-
-static inline int try_to_freeze(void) { return 0; }
-
 #endif /* CONFIG_PM */
 #endif /* __KERNEL__ */
 
Index: linux-2.6.12/kernel/power/process.c
===================================================================
--- linux-2.6.12.orig/kernel/power/process.c	2005-06-27 05:20:15.000000000 +0000
+++ linux-2.6.12/kernel/power/process.c	2005-06-28 21:52:47.000000000 +0000
@@ -18,7 +18,6 @@
  */
 #define TIMEOUT	(6 * HZ)
 
-
 static inline int freezeable(struct task_struct * p)
 {
 	if ((p == current) || 
@@ -31,28 +30,6 @@ static inline int freezeable(struct task
 	return 1;
 }
 
-/* Refrigerator is place where frozen processes are stored :-). */
-void refrigerator(void)
-{
-	/* Hmm, should we be allowed to suspend when there are realtime
-	   processes around? */
-	long save;
-	save = current->state;
-	current->state = TASK_UNINTERRUPTIBLE;
-	pr_debug("%s entered refrigerator\n", current->comm);
-	printk("=");
-
-	frozen_process(current);
-	spin_lock_irq(&current->sighand->siglock);
-	recalc_sigpending(); /* We sent fake signal, clean it up */
-	spin_unlock_irq(&current->sighand->siglock);
-
-	while (frozen(current))
-		schedule();
-	pr_debug("%s left refrigerator\n", current->comm);
-	current->state = save;
-}
-
 /* 0 = success, else # of processes that we failed to stop */
 int freeze_processes(void)
 {
@@ -60,6 +37,7 @@ int freeze_processes(void)
 	unsigned long start_time;
 	struct task_struct *g, *p;
 
+	down(&freezer_sem);
 	printk( "Stopping tasks: " );
 	start_time = jiffies;
 	do {
@@ -69,12 +47,13 @@ int freeze_processes(void)
 			unsigned long flags;
 			if (!freezeable(p))
 				continue;
-			if ((frozen(p)) ||
-			    (p->state == TASK_TRACED) ||
+			if ((p->state == TASK_TRACED) ||
 			    (p->state == TASK_STOPPED))
 				continue;
 
-			freeze(p);
+			set_ti_thread_flag(p->thread_info, TIF_FREEZE);
+			if (p->flags & PF_FROZEN)
+				continue;
 			spin_lock_irqsave(&p->sighand->siglock, flags);
 			signal_wake_up(p, 0);
 			spin_unlock_irqrestore(&p->sighand->siglock, flags);
@@ -85,6 +64,8 @@ int freeze_processes(void)
 		if (time_after(jiffies, start_time + TIMEOUT)) {
 			printk( "\n" );
 			printk(KERN_ERR " stopping tasks failed (%d tasks remaining)\n", todo );
+			complete_all(&thaw);
+			up(&freezer_sem);
 			return todo;
 		}
 	} while(todo);
@@ -96,20 +77,6 @@ int freeze_processes(void)
 
 void thaw_processes(void)
 {
-	struct task_struct *g, *p;
-
-	printk( "Restarting tasks..." );
-	read_lock(&tasklist_lock);
-	do_each_thread(g, p) {
-		if (!freezeable(p))
-			continue;
-		if (!thaw_process(p))
-			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
-	} while_each_thread(g, p);
-
-	read_unlock(&tasklist_lock);
-	schedule();
-	printk( " done\n" );
+	complete_all(&thaw);
+	up(&freezer_sem);
 }
-
-EXPORT_SYMBOL(refrigerator);
Index: linux-2.6.12/include/asm-x86_64/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-x86_64/thread_info.h	2005-06-27 05:20:15.000000000 +0000
+++ linux-2.6.12/include/asm-x86_64/thread_info.h	2005-06-27 05:37:24.000000000 +0000
@@ -108,6 +108,7 @@ static inline struct thread_info *stack_
 #define TIF_FORK		18	/* ret_from_fork */
 #define TIF_ABI_PENDING		19
 #define TIF_MEMDIE		20
+#define TIF_FREEZE		21	/* Freeze process */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
Index: linux-2.6.12/include/asm-ia64/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-ia64/thread_info.h	2005-06-27 05:20:15.000000000 +0000
+++ linux-2.6.12/include/asm-ia64/thread_info.h	2005-06-27 05:26:12.000000000 +0000
@@ -76,6 +76,7 @@ struct thread_info {
 #define TIF_SIGDELAYED		5	/* signal delayed from MCA/INIT/NMI/PMI context */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		17
+#define TIF_FREEZE		18	/* Freeze process */
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
Index: linux-2.6.12/include/asm-i386/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-i386/thread_info.h	2005-06-27 05:20:15.000000000 +0000
+++ linux-2.6.12/include/asm-i386/thread_info.h	2005-06-27 05:25:49.000000000 +0000
@@ -143,6 +143,7 @@ register unsigned long current_stack_poi
 #define TIF_SECCOMP		8	/* secure computing */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		17
+#define TIF_FREEZE		18	/* Freeze thread */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
Index: linux-2.6.12/include/asm-xtensa/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-xtensa/thread_info.h	2005-06-27 02:23:01.000000000 +0000
+++ linux-2.6.12/include/asm-xtensa/thread_info.h	2005-06-27 05:36:54.000000000 +0000
@@ -118,6 +118,7 @@ static inline struct thread_info *curren
 #define TIF_SINGLESTEP		4	/* restore singlestep on return to user mode */
 #define TIF_IRET		5	/* return with iret */
 #define TIF_MEMDIE		6
+#define TIF_FREEZE		7
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
Index: linux-2.6.12/include/asm-h8300/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-h8300/thread_info.h	2005-06-27 02:23:01.000000000 +0000
+++ linux-2.6.12/include/asm-h8300/thread_info.h	2005-06-27 05:25:25.000000000 +0000
@@ -94,6 +94,7 @@ static inline struct thread_info *curren
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling
 					   TIF_NEED_RESCHED */
 #define TIF_MEMDIE		5
+#define TIF_FREEZE		6
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
Index: linux-2.6.12/include/asm-ppc/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-ppc/thread_info.h	2005-06-27 02:23:01.000000000 +0000
+++ linux-2.6.12/include/asm-ppc/thread_info.h	2005-06-27 05:28:53.000000000 +0000
@@ -80,6 +80,7 @@ static inline struct thread_info *curren
 #define TIF_MEMDIE		5
 #define TIF_SYSCALL_AUDIT       6       /* syscall auditing active */
 #define TIF_SECCOMP             7      /* secure computing */
+#define TIF_FREEZE		8
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
Index: linux-2.6.12/include/asm-sh64/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-sh64/thread_info.h	2005-06-27 02:23:01.000000000 +0000
+++ linux-2.6.12/include/asm-sh64/thread_info.h	2005-06-27 05:35:02.000000000 +0000
@@ -80,6 +80,7 @@ static inline struct thread_info *curren
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_MEMDIE		4
+#define TIF_FREEZE		5
 
 
 #endif /* __KERNEL__ */
Index: linux-2.6.12/include/asm-alpha/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-alpha/thread_info.h	2005-06-17 19:48:29.000000000 +0000
+++ linux-2.6.12/include/asm-alpha/thread_info.h	2005-06-27 05:23:06.000000000 +0000
@@ -78,6 +78,7 @@ register struct thread_info *__current_t
 #define TIF_UAC_NOFIX		7
 #define TIF_UAC_SIGBUS		8
 #define TIF_MEMDIE		9
+#define TIF_FREEZE		10
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
Index: linux-2.6.12/include/asm-sparc/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-sparc/thread_info.h	2005-06-27 02:23:01.000000000 +0000
+++ linux-2.6.12/include/asm-sparc/thread_info.h	2005-06-27 05:35:23.000000000 +0000
@@ -139,6 +139,7 @@ BTFIXUPDEF_CALL(void, free_thread_info, 
 #define TIF_POLLING_NRFLAG	9	/* true if poll_idle() is polling
 					 * TIF_NEED_RESCHED */
 #define TIF_MEMDIE		10
+#define TIF_FREEZE		11
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
Index: linux-2.6.12/include/asm-frv/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-frv/thread_info.h	2005-06-27 02:23:01.000000000 +0000
+++ linux-2.6.12/include/asm-frv/thread_info.h	2005-06-27 05:25:02.000000000 +0000
@@ -133,6 +133,7 @@ register struct thread_info *__current_t
 #define TIF_IRET		5	/* return with iret */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		17	/* OOM killer killed process */
+#define TIF_FREEZE		18
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
Index: linux-2.6.12/include/asm-parisc/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-parisc/thread_info.h	2005-06-27 02:23:01.000000000 +0000
+++ linux-2.6.12/include/asm-parisc/thread_info.h	2005-06-27 05:28:34.000000000 +0000
@@ -64,6 +64,7 @@ struct thread_info {
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_32BIT               5       /* 32 bit binary */
 #define TIF_MEMDIE		6
+#define TIF_FREEZE		7
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
Index: linux-2.6.12/include/asm-m68knommu/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-m68knommu/thread_info.h	2005-06-27 02:23:01.000000000 +0000
+++ linux-2.6.12/include/asm-m68knommu/thread_info.h	2005-06-27 05:27:13.000000000 +0000
@@ -91,6 +91,7 @@ static inline struct thread_info *curren
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling
 					   TIF_NEED_RESCHED */
 #define TIF_MEMDIE		5
+#define TIF_FREEZE		6
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
Index: linux-2.6.12/include/asm-m68k/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-m68k/thread_info.h	2005-06-27 02:23:01.000000000 +0000
+++ linux-2.6.12/include/asm-m68k/thread_info.h	2005-06-27 05:26:49.000000000 +0000
@@ -49,6 +49,7 @@ struct thread_info {
 #define TIF_SIGPENDING		3	/* signal pending */
 #define TIF_NEED_RESCHED	4	/* rescheduling necessary */
 #define TIF_MEMDIE		5
+#define TIF_FREEZE		6
 
 extern int thread_flag_fixme(void);
 
Index: linux-2.6.12/include/asm-sh/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-sh/thread_info.h	2005-06-27 02:23:01.000000000 +0000
+++ linux-2.6.12/include/asm-sh/thread_info.h	2005-06-27 05:34:43.000000000 +0000
@@ -84,6 +84,7 @@ static inline struct thread_info *curren
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		18
+#define TIF_FREEZE		19
 #define TIF_USERSPACE		31	/* true if FS sets userspace */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
Index: linux-2.6.12/include/asm-s390/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-s390/thread_info.h	2005-06-27 02:23:01.000000000 +0000
+++ linux-2.6.12/include/asm-s390/thread_info.h	2005-06-27 05:34:19.000000000 +0000
@@ -102,6 +102,7 @@ static inline struct thread_info *curren
 					   TIF_NEED_RESCHED */
 #define TIF_31BIT		18	/* 32bit process */ 
 #define TIF_MEMDIE		19
+#define TIF_FREEZE		20
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
Index: linux-2.6.12/include/asm-arm/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-arm/thread_info.h	2005-06-27 02:23:01.000000000 +0000
+++ linux-2.6.12/include/asm-arm/thread_info.h	2005-06-27 05:23:34.000000000 +0000
@@ -132,6 +132,7 @@ extern void iwmmxt_task_release(struct t
 #define TIF_POLLING_NRFLAG	16
 #define TIF_USING_IWMMXT	17
 #define TIF_MEMDIE		18
+#define TIF_FREEZE		19
 
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
Index: linux-2.6.12/include/asm-v850/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-v850/thread_info.h	2005-06-27 02:23:01.000000000 +0000
+++ linux-2.6.12/include/asm-v850/thread_info.h	2005-06-27 05:36:25.000000000 +0000
@@ -85,6 +85,7 @@ struct thread_info {
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling
 					   TIF_NEED_RESCHED */
 #define TIF_MEMDIE		5
+#define TIF_FREEZE		6
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
Index: linux-2.6.12/include/asm-mips/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-mips/thread_info.h	2005-06-27 02:23:01.000000000 +0000
+++ linux-2.6.12/include/asm-mips/thread_info.h	2005-06-27 05:27:41.000000000 +0000
@@ -117,6 +117,7 @@ register struct thread_info *__current_t
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		18
+#define TIF_FREEZE		19
 #define TIF_SYSCALL_TRACE	31	/* syscall trace active */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
Index: linux-2.6.12/include/asm-cris/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-cris/thread_info.h	2005-06-27 02:23:01.000000000 +0000
+++ linux-2.6.12/include/asm-cris/thread_info.h	2005-06-27 05:24:28.000000000 +0000
@@ -86,6 +86,7 @@ struct thread_info {
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		17
+#define TIF_FREEZE		18
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
Index: linux-2.6.12/include/asm-arm26/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-arm26/thread_info.h	2005-06-27 02:23:01.000000000 +0000
+++ linux-2.6.12/include/asm-arm26/thread_info.h	2005-06-27 05:24:02.000000000 +0000
@@ -127,6 +127,7 @@ extern void free_thread_info(struct thre
 #define TIF_USED_FPU		16
 #define TIF_POLLING_NRFLAG	17
 #define TIF_MEMDIE		18
+#define TIF_FREEZE		19
 
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
Index: linux-2.6.12/include/asm-sparc64/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-sparc64/thread_info.h	2005-06-27 02:23:01.000000000 +0000
+++ linux-2.6.12/include/asm-sparc64/thread_info.h	2005-06-27 05:35:45.000000000 +0000
@@ -229,6 +229,7 @@ register struct thread_info *current_thr
  */
 #define TIF_ABI_PENDING		12
 #define TIF_MEMDIE		13
+#define TIF_FREEZE		14
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
Index: linux-2.6.12/include/asm-m32r/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-m32r/thread_info.h	2005-06-27 02:23:01.000000000 +0000
+++ linux-2.6.12/include/asm-m32r/thread_info.h	2005-06-27 05:26:33.000000000 +0000
@@ -156,6 +156,7 @@ static inline unsigned int get_thread_fa
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 					/* 31..28 fault code */
 #define TIF_MEMDIE		17
+#define TIF_FREEZE		18
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
Index: linux-2.6.12/include/asm-ppc64/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-ppc64/thread_info.h	2005-06-27 02:23:01.000000000 +0000
+++ linux-2.6.12/include/asm-ppc64/thread_info.h	2005-06-27 05:29:13.000000000 +0000
@@ -102,6 +102,7 @@ static inline struct thread_info *curren
 #define TIF_SINGLESTEP		9	/* singlestepping active */
 #define TIF_MEMDIE		10
 #define TIF_SECCOMP		11	/* secure computing */
+#define TIF_FREEZE		12
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
Index: linux-2.6.12/include/asm-um/thread_info.h
===================================================================
--- linux-2.6.12.orig/include/asm-um/thread_info.h	2005-06-27 02:23:01.000000000 +0000
+++ linux-2.6.12/include/asm-um/thread_info.h	2005-06-27 05:36:07.000000000 +0000
@@ -72,6 +72,7 @@ static inline struct thread_info *curren
 #define TIF_RESTART_BLOCK 	4
 #define TIF_MEMDIE	 	5
 #define TIF_SYSCALL_AUDIT	6
+#define TIF_FREEZE		7
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
Index: linux-2.6.12/kernel/sched.c
===================================================================
--- linux-2.6.12.orig/kernel/sched.c	2005-06-27 02:23:01.000000000 +0000
+++ linux-2.6.12/kernel/sched.c	2005-06-28 21:51:43.000000000 +0000
@@ -5203,6 +5203,25 @@ void __init sched_init(void)
 	init_idle(current, smp_processor_id());
 }
 
+#if defined(CONFIG_PM) || defined(CONFIG_MIGRATE)
+DECLARE_MUTEX(freezer_sem);
+DECLARE_COMPLETION(thaw);
+
+void refrigerator(void)
+{
+	current->flags |= PF_FROZEN;
+	wait_for_completion(&thaw);
+	clear_thread_flag(TIF_FREEZE);
+	current->flags &= ~PF_FROZEN;
+	/* A fake signal 0 may have been sent. Recalculate sigpending */
+	spin_lock_irq(&current->sighand->siglock);
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
+}
+EXPORT_SYMBOL(refrigerator);
+#endif
+
+
 #ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
 void __might_sleep(char *file, int line)
 {
