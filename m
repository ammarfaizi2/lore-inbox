Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbVF0DwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbVF0DwR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 23:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVF0DwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 23:52:17 -0400
Received: from graphe.net ([209.204.138.32]:61395 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261794AbVF0DvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 23:51:17 -0400
Date: Sun, 26 Jun 2005 20:51:11 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Pavel Machek <pavel@ucw.cz>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, raybry@engr.sgi.com,
       torvalds@osdl.org
Subject: Re: [RFC] Fix SMP brokenness for PF_FREEZE and make freezing usable
 for other purposes
In-Reply-To: <20050626030925.GA4156@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.62.0506261928010.1679@graphe.net>
References: <Pine.LNX.4.62.0506241316370.30503@graphe.net>
 <20050625025122.GC22393@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.62.0506242311220.7971@graphe.net>
 <20050626023053.GA2871@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.62.0506251954470.26198@graphe.net>
 <20050626030925.GA4156@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jun 2005, Pavel Machek wrote:

> > Why do you want to specify a parameter that is never used? It was quite confusing to me 
> > and I would think that such a parameter will also be confusing to others.
> 
> Well, yes, it is slightly confusing, but such patch can go in through
> different maintainers, and different pieces can come in at different
> times.

The cleanup patch is already in Linus' tree so the discussion is moot. So 
I think the basic API is now stable.

The other outstanding issues may best be addressed in the 
following way.

1. Have a semaphore to insure that allows control over the freezing 
process. Each action involving freezing of processes needs to first 
take the semaphore. This will insure that only the suspend code or the 
process migration code (or something else in the future) are freezing processes.

2. A completion handler seems to be the right instrument in the 
refrigerator and allows the removal of a lot of code.

3. I wish there would be a better way to handle the PF_FREEZE. Its like a 
signal delivery after all. Is there any way to define an in kernel signal? 
Or a way to make a process execute a certain bit of code?

The following patch will still need to be verified to be correct, 
cleaned up to move code around and do the right thing with 
CONFIG_FREEZING CONFIG_PM and CONFIG_MIGRATE???

---

Revise handling of freezing in the suspend code (against 2.6.12-git8)

The current suspend code modifies thread flags from outside the context of process.
This creates a SMP race.

The patch fixes that by introducing a freeze_request flag and uses a completion
handler instead of waiting in a schedule loop in the refrigerator.

It also introduces a semaphore freezer_sem to provide a way that multiple kernel
subsystems can use the freezing ability without interfering.

Would this be satisfying everyones concerns? I have never used a completion handler
before so some better check up on me.

Signed-off-by: Christoph Lameter <christoph@lameter.com>

Index: linux-2.6.12/include/linux/sched.h
===================================================================
--- linux-2.6.12.orig/include/linux/sched.h	2005-06-27 02:23:01.000000000 +0000
+++ linux-2.6.12/include/linux/sched.h	2005-06-27 03:43:02.000000000 +0000
@@ -719,6 +719,8 @@ struct task_struct {
 	struct audit_context *audit_context;
 	seccomp_t seccomp;
 
+	int freeze_request;	/* Written to by external process to request freeze */
+
 /* Thread group tracking */
    	u32 parent_exec_id;
    	u32 self_exec_id;
@@ -804,7 +806,6 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_MEMALLOC	0x00000800	/* Allocating memory */
 #define PF_FLUSHER	0x00001000	/* responsible for disk writeback */
 #define PF_USED_MATH	0x00002000	/* if unset the fpu must be initialized before use */
-#define PF_FREEZE	0x00004000	/* this task is being frozen for suspend now */
 #define PF_NOFREEZE	0x00008000	/* this thread should not be frozen */
 #define PF_FROZEN	0x00010000	/* frozen for system suspend */
 #define PF_FSTRANS	0x00020000	/* inside a filesystem transaction */
@@ -1265,7 +1266,13 @@ extern void normalize_rt_tasks(void);
 
 #endif
 
-#ifdef CONFIG_PM
+#if defined(CONFIG_PM) || defined(CONFIG_MIGRATE)
+#define CONFIG_FREEZING
+#endif
+
+#ifdef CONFIG_FREEZING
+extern struct semaphore freezer_sem;
+extern struct completion thaw;
 /*
  * Check if a process has been frozen
  */
@@ -1279,39 +1286,20 @@ static inline int frozen(struct task_str
  */
 static inline int freezing(struct task_struct *p)
 {
-	return p->flags & PF_FREEZE;
+	return p->freeze_request;
 }
 
 /*
  * Request that a process be frozen
- * FIXME: SMP problem. We may not modify other process' flags!
  */
 static inline void freeze(struct task_struct *p)
 {
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
+	p->freeze_request = 1;
 }
 
 /*
  * freezing is complete, mark process as frozen
  */
-static inline void frozen_process(struct task_struct *p)
-{
-	p->flags = (p->flags & ~PF_FREEZE) | PF_FROZEN;
-}
-
 extern void refrigerator(void);
 extern int freeze_processes(void);
 extern void thaw_processes(void);
@@ -1328,16 +1316,11 @@ static inline int try_to_freeze(void)
 static inline int frozen(struct task_struct *p) { return 0; }
 static inline int freezing(struct task_struct *p) { return 0; }
 static inline void freeze(struct task_struct *p) { BUG(); }
-static inline int thaw_process(struct task_struct *p) { return 1; }
-static inline void frozen_process(struct task_struct *p) { BUG(); }
-
 static inline void refrigerator(void) {}
 static inline int freeze_processes(void) { BUG(); return 0; }
 static inline void thaw_processes(void) {}
-
 static inline int try_to_freeze(void) { return 0; }
-
-#endif /* CONFIG_PM */
+#endif /* CONFIG_FREEZING */
 #endif /* __KERNEL__ */
 
 #endif
Index: linux-2.6.12/kernel/power/process.c
===================================================================
--- linux-2.6.12.orig/kernel/power/process.c	2005-06-27 02:23:01.000000000 +0000
+++ linux-2.6.12/kernel/power/process.c	2005-06-27 03:42:15.000000000 +0000
@@ -18,6 +18,8 @@
  */
 #define TIMEOUT	(6 * HZ)
 
+DECLARE_MUTEX(freezer_sem);
+DECLARE_COMPLETION(thaw);
 
 static inline int freezeable(struct task_struct * p)
 {
@@ -31,27 +33,14 @@ static inline int freezeable(struct task
 	return 1;
 }
 
-/* Refrigerator is place where frozen processes are stored :-). */
 void refrigerator(void)
 {
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
+	current->flags |= PF_FROZEN;
+	current->freeze_request = 0;
+	wait_for_completion(&thaw);
+	current->flags &= ~PF_FROZEN;
 }
+EXPORT_SYMBOL(refrigerator);
 
 /* 0 = success, else # of processes that we failed to stop */
 int freeze_processes(void)
@@ -60,6 +49,7 @@ int freeze_processes(void)
 	unsigned long start_time;
 	struct task_struct *g, *p;
 
+	down(&freezer_sem);
 	printk( "Stopping tasks: " );
 	start_time = jiffies;
 	do {
@@ -96,20 +86,6 @@ int freeze_processes(void)
 
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





