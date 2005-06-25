Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263345AbVFYG0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263345AbVFYG0D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 02:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263357AbVFYGYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 02:24:31 -0400
Received: from graphe.net ([209.204.138.32]:12453 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S263349AbVFYGSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 02:18:30 -0400
Date: Fri, 24 Jun 2005 23:18:26 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Pavel Machek <pavel@ucw.cz>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, raybry@engr.sgi.com,
       torvalds@osdl.org
Subject: Re: [RFC] Fix SMP brokenness for PF_FREEZE and make freezing usable
 for other purposes
In-Reply-To: <20050625025122.GC22393@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.62.0506242317150.8078@graphe.net>
References: <Pine.LNX.4.62.0506241316370.30503@graphe.net>
 <20050625025122.GC22393@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And the patch to deal with the SMP issue:

---

Fix SMP brokenness for PF_FREEZE and make freezing usable for other purposes

The process freezing used by software suspend currently relies on modifying
current->flags from outside of the processes context. This makes freezing and
unfreezing SMP unsafe since a process may change the flags at any time without
locking. The following patch introduces a new atomic_t field in task_struct
to allow SMP safe freezing and unfreezing.

Signed-off-by: Christoph Lameter <christoph@lameter.com>

Index: linux-2.6.12/include/linux/sched.h
===================================================================
--- linux-2.6.12.orig/include/linux/sched.h	2005-06-25 05:41:28.000000000 +0000
+++ linux-2.6.12/include/linux/sched.h	2005-06-25 06:03:30.000000000 +0000
@@ -720,6 +720,8 @@ struct task_struct {
 
 	unsigned long ptrace_message;
 	siginfo_t *last_siginfo; /* For ptrace use.  */
+
+	atomic_t freeze;	/* For freezing a process. 0 = running, if >0 freezing request pending, if < 0 frozen */
 /*
  * current io wait handle: wait queue entry to use for io waits
  * If this thread is processing aio, this points at the waitqueue
@@ -784,9 +786,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_MEMALLOC	0x00000800	/* Allocating memory */
 #define PF_FLUSHER	0x00001000	/* responsible for disk writeback */
 #define PF_USED_MATH	0x00002000	/* if unset the fpu must be initialized before use */
-#define PF_FREEZE	0x00004000	/* this task is being frozen for suspend now */
 #define PF_NOFREEZE	0x00008000	/* this thread should not be frozen */
-#define PF_FROZEN	0x00010000	/* frozen for system suspend */
 #define PF_FSTRANS	0x00020000	/* inside a filesystem transaction */
 #define PF_KSWAPD	0x00040000	/* I am kswapd */
 #define PF_SWAPOFF	0x00080000	/* I am in swapoff */
@@ -1245,13 +1245,12 @@ extern void normalize_rt_tasks(void);
 
 #endif
 
-#ifdef CONFIG_PM
 /*
  * Check if a process has been frozen
  */
 static inline int frozen(struct task_struct *p)
 {
-	return p->flags & PF_FROZEN;
+	return atomic_read(&p->freeze) < 0;
 }
 
 /*
@@ -1259,16 +1258,15 @@ static inline int frozen(struct task_str
  */
 static inline int freezing(struct task_struct *p)
 {
-	return p->flags & PF_FREEZE;
+	return atomic_read(&p->freeze) > 0;
 }
 
 /*
  * Request that a process be frozen
- * FIXME: SMP problem. We may not modify other process' flags!
  */
 static inline void freeze(struct task_struct *p)
 {
-	p->flags |= PF_FREEZE;
+	atomic_inc(&p->freeze);
 }
 
 /*
@@ -1277,21 +1275,13 @@ static inline void freeze(struct task_st
 static inline int thaw_process(struct task_struct *p)
 {
 	if (frozen(p)) {
-		p->flags &= ~PF_FROZEN;
+		atomic_set(&p->freeze, 0);
 		wake_up_process(p);
 		return 1;
 	}
 	return 0;
 }
 
-/*
- * freezing is complete, mark process as frozen
- */
-static inline void frozen_process(struct task_struct *p)
-{
-	p->flags = (p->flags & ~PF_FREEZE) | PF_FROZEN;
-}
-
 extern void refrigerator(void);
 extern int freeze_processes(void);
 extern void thaw_processes(void);
@@ -1304,20 +1294,6 @@ static inline int try_to_freeze(void)
 	} else
 		return 0;
 }
-#else
-static inline int frozen(struct task_struct *p) { return 0; }
-static inline int freezing(struct task_struct *p) { return 0; }
-static inline void freeze(struct task_struct *p) { BUG(); }
-static inline int thaw_process(struct task_struct *p) { return 1; }
-static inline void frozen_process(struct task_struct *p) { BUG(); }
-
-static inline void refrigerator(void) {}
-static inline int freeze_processes(void) { BUG(); return 0; }
-static inline void thaw_processes(void) {}
-
-static inline int try_to_freeze(void) { return 0; }
-
-#endif /* CONFIG_PM */
 #endif /* __KERNEL__ */
 
 #endif
Index: linux-2.6.12/kernel/power/process.c
===================================================================
--- linux-2.6.12.orig/kernel/power/process.c	2005-06-25 05:33:16.000000000 +0000
+++ linux-2.6.12/kernel/power/process.c	2005-06-25 05:57:34.000000000 +0000
@@ -31,28 +31,6 @@ static inline int freezeable(struct task
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
Index: linux-2.6.12/kernel/sched.c
===================================================================
--- linux-2.6.12.orig/kernel/sched.c	2005-06-25 05:01:28.000000000 +0000
+++ linux-2.6.12/kernel/sched.c	2005-06-25 06:04:03.000000000 +0000
@@ -4988,6 +4988,35 @@ void __might_sleep(char *file, int line)
 EXPORT_SYMBOL(__might_sleep);
 #endif
 
+/*
+ * The refrigerator is called by a process if a request has been made
+ * to the process by freeze()
+ */
+void refrigerator(void)
+{
+	/* Hmm, should we be allowed to suspend when there are realtime
+	   processes around? */
+	long save;
+	save = current->state;
+	current->state = TASK_UNINTERRUPTIBLE;
+
+	/* Use large negative value to be able to tolerate
+	 * additional freeze requests that may be issued
+	 * while moving into the refrigerator.
+	 * We have no way of locking for the freeze
+	 * field.
+	 */
+	atomic_set(&current->freeze, - (1 << 30));
+
+	spin_lock_irq(&current->sighand->siglock);
+	recalc_sigpending(); /* We may have sent a fake signal, clean it up */
+	spin_unlock_irq(&current->sighand->siglock);
+
+	while (frozen(current))
+		schedule();
+	current->state = save;
+}
+
 #ifdef CONFIG_MAGIC_SYSRQ
 void normalize_rt_tasks(void)
 {
