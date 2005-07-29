Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262824AbVG2UiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262824AbVG2UiK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 16:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262816AbVG2UgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 16:36:02 -0400
Received: from graphe.net ([209.204.138.32]:13782 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262781AbVG2Udj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 16:33:39 -0400
Date: Fri, 29 Jul 2005 13:33:36 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Pavel Machek <pavel@ucw.cz>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 2/4] Task notifier against mm: Implement todo list in
 task_struct
In-Reply-To: <Pine.LNX.4.62.0507291328170.5304@graphe.net>
Message-ID: <Pine.LNX.4.62.0507291332100.5304@graphe.net>
References: <Pine.LNX.4.62.0507291328170.5304@graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a todo notifier in the task_struct so that a task can be told to do
certain things. Abuse the suspend hooks try_to_freeze, freezing and refrigerator
to establish checkpoints where the todo list is processed. This will break software
suspend (next patch fixes and cleans up software suspend).

Signed-off-by: Christoph Lameter <christoph@lameter.com>

Index: linux-2.6.13-rc3-mm3/include/linux/sched.h
===================================================================
--- linux-2.6.13-rc3-mm3.orig/include/linux/sched.h	2005-07-29 12:32:17.000000000 -0700
+++ linux-2.6.13-rc3-mm3/include/linux/sched.h	2005-07-29 12:37:44.000000000 -0700
@@ -35,6 +35,7 @@
 #include <linux/topology.h>
 #include <linux/seccomp.h>
 #include <linux/taskdelays.h>
+#include <linux/notifier.h>
 
 #include <linux/auxvec.h>	/* For AT_VECTOR_SIZE */
 
@@ -783,7 +784,10 @@
 	int (*notifier)(void *priv);
 	void *notifier_data;
 	sigset_t *notifier_mask;
-	
+
+	/* todo list to be executed in the context of this thread */
+	struct notifier_block *todo;
+
 	void *security;
 	struct audit_context *audit_context;
 	seccomp_t seccomp;
@@ -1353,79 +1357,36 @@
 
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
-
-/*
- * Request that a process be frozen
- * FIXME: SMP problem. We may not modify other process' flags!
- */
-static inline void freeze(struct task_struct *p)
-{
-	p->flags |= PF_FREEZE;
-}
-
 /*
- * Wake up a frozen process
+ * Check if there is a todo list request
  */
-static inline int thaw_process(struct task_struct *p)
+static inline int todo_list_active(void)
 {
-	if (frozen(p)) {
-		p->flags &= ~PF_FROZEN;
-		wake_up_process(p);
-		return 1;
-	}
-	return 0;
+	return current->todo != NULL;
 }
 
-/*
- * freezing is complete, mark process as frozen
- */
-static inline void frozen_process(struct task_struct *p)
+static inline void run_todo_list(void)
 {
-	p->flags = (p->flags & ~PF_FREEZE) | PF_FROZEN;
+	notifier_call_chain(&current->todo, 0, current);
 }
 
-extern void refrigerator(void);
-extern int freeze_processes(void);
-extern void thaw_processes(void);
-
-static inline int try_to_freeze(void)
+static inline int try_todo_list(void)
 {
-	if (freezing(current)) {
-		refrigerator();
+	if (todo_list_active()) {
+        	run_todo_list();
 		return 1;
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
 
-#endif /* CONFIG_PM */
+/*
+ * Compatibility definitions to use the suspend checkpoints for the task todo list.
+ * These may be removed once all uses of try_to_free,  refrigerator and freezing
+ * have been removed.
+ */
+#define try_to_freeze try_todo_list
+#define refrigerator run_todo_list
+#define freezing(p) todo_list_active()
 
 /* API for registering delay info */
 #ifdef CONFIG_DELAY_ACCT
Index: linux-2.6.13-rc3-mm3/kernel/signal.c
===================================================================
--- linux-2.6.13-rc3-mm3.orig/kernel/signal.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3-mm3/kernel/signal.c	2005-07-29 12:32:32.000000000 -0700
@@ -213,7 +213,7 @@
 fastcall void recalc_sigpending_tsk(struct task_struct *t)
 {
 	if (t->signal->group_stop_count > 0 ||
-	    (freezing(t)) ||
+	    (t->todo) ||
 	    PENDING(&t->pending, &t->blocked) ||
 	    PENDING(&t->signal->shared_pending, &t->blocked))
 		set_tsk_thread_flag(t, TIF_SIGPENDING);
@@ -2231,7 +2231,7 @@
 			current->state = TASK_INTERRUPTIBLE;
 			timeout = schedule_timeout(timeout);
 
-			try_to_freeze();
+			try_todo_list();
 			spin_lock_irq(&current->sighand->siglock);
 			sig = dequeue_signal(current, &these, &info);
 			current->blocked = current->real_blocked;
Index: linux-2.6.13-rc3-mm3/arch/frv/kernel/signal.c
===================================================================
--- linux-2.6.13-rc3-mm3.orig/arch/frv/kernel/signal.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3-mm3/arch/frv/kernel/signal.c	2005-07-29 12:32:32.000000000 -0700
@@ -536,7 +536,7 @@
 	if (!user_mode(regs))
 		return 1;
 
-	if (try_to_freeze())
+	if (try_todo_list())
 		goto no_signal;
 
 	if (!oldset)
Index: linux-2.6.13-rc3-mm3/arch/h8300/kernel/signal.c
===================================================================
--- linux-2.6.13-rc3-mm3.orig/arch/h8300/kernel/signal.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3-mm3/arch/h8300/kernel/signal.c	2005-07-29 12:32:32.000000000 -0700
@@ -517,7 +517,7 @@
 	if ((regs->ccr & 0x10))
 		return 1;
 
-	if (try_to_freeze())
+	if (try_todo_list())
 		goto no_signal;
 
 	current->thread.esp0 = (unsigned long) regs;
Index: linux-2.6.13-rc3-mm3/arch/i386/kernel/io_apic.c
===================================================================
--- linux-2.6.13-rc3-mm3.orig/arch/i386/kernel/io_apic.c	2005-07-29 12:32:11.000000000 -0700
+++ linux-2.6.13-rc3-mm3/arch/i386/kernel/io_apic.c	2005-07-29 12:32:32.000000000 -0700
@@ -575,7 +575,7 @@
 	for ( ; ; ) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		time_remaining = schedule_timeout(time_remaining);
-		try_to_freeze();
+		try_todo_list();
 		if (time_after(jiffies,
 				prev_balance_time+balanced_irq_interval)) {
 			preempt_disable();
Index: linux-2.6.13-rc3-mm3/arch/i386/kernel/signal.c
===================================================================
--- linux-2.6.13-rc3-mm3.orig/arch/i386/kernel/signal.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3-mm3/arch/i386/kernel/signal.c	2005-07-29 12:32:32.000000000 -0700
@@ -608,7 +608,7 @@
 	if (!user_mode(regs))
 		return 1;
 
-	if (try_to_freeze())
+	if (try_todo_list())
 		goto no_signal;
 
 	if (!oldset)
Index: linux-2.6.13-rc3-mm3/arch/m32r/kernel/signal.c
===================================================================
--- linux-2.6.13-rc3-mm3.orig/arch/m32r/kernel/signal.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3-mm3/arch/m32r/kernel/signal.c	2005-07-29 12:32:32.000000000 -0700
@@ -371,7 +371,7 @@
 	if (!user_mode(regs))
 		return 1;
 
-	if (try_to_freeze()) 
+	if (try_todo_list())
 		goto no_signal;
 
 	if (!oldset)
Index: linux-2.6.13-rc3-mm3/arch/ppc/kernel/signal.c
===================================================================
--- linux-2.6.13-rc3-mm3.orig/arch/ppc/kernel/signal.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3-mm3/arch/ppc/kernel/signal.c	2005-07-29 12:32:32.000000000 -0700
@@ -705,7 +705,7 @@
 	unsigned long frame, newsp;
 	int signr, ret;
 
-	if (try_to_freeze()) {
+	if (try_todo_list()) {
 		signr = 0;
 		if (!signal_pending(current))
 			goto no_signal;
Index: linux-2.6.13-rc3-mm3/arch/x86_64/kernel/signal.c
===================================================================
--- linux-2.6.13-rc3-mm3.orig/arch/x86_64/kernel/signal.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3-mm3/arch/x86_64/kernel/signal.c	2005-07-29 12:32:32.000000000 -0700
@@ -425,7 +425,7 @@
 	if (!user_mode(regs))
 		return 1;
 
-	if (try_to_freeze())
+	if (try_todo_list())
 		goto no_signal;
 
 	if (!oldset)
