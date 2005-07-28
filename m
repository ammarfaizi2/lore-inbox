Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVG1T77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVG1T77 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 15:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVG1T6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 15:58:40 -0400
Received: from graphe.net ([209.204.138.32]:59369 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261709AbVG1T4F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 15:56:05 -0400
Date: Thu, 28 Jul 2005 12:55:58 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Pavel Machek <pavel@ucw.cz>
cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] Task notifier: Implement todo list in task_struct
In-Reply-To: <Pine.LNX.4.62.0507281251040.12675@graphe.net>
Message-ID: <Pine.LNX.4.62.0507281254380.12781@graphe.net>
References: <200507260340.j6Q3eoGh029135@shell0.pdx.osdl.net>
 <Pine.LNX.4.62.0507272018060.11863@graphe.net> <20050728074116.GF6529@elf.ucw.cz>
 <Pine.LNX.4.62.0507280804310.23907@graphe.net> <20050728193433.GA1856@elf.ucw.cz>
 <Pine.LNX.4.62.0507281251040.12675@graphe.net>
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

Index: linux-2.6.13-rc3/include/linux/sched.h
===================================================================
--- linux-2.6.13-rc3.orig/include/linux/sched.h	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/include/linux/sched.h	2005-07-28 11:54:40.000000000 -0700
@@ -34,6 +34,7 @@
 #include <linux/percpu.h>
 #include <linux/topology.h>
 #include <linux/seccomp.h>
+#include <linux/notifier.h>
 
 struct exec_domain;
 
@@ -720,7 +721,10 @@
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
@@ -1273,79 +1275,37 @@
 
 #endif
 
-#ifdef CONFIG_PM
 /*
- * Check if a process has been frozen
+ * Check if there is a todo list request
  */
-static inline int frozen(struct task_struct *p)
+static inline int todo_list_active(void)
 {
-	return p->flags & PF_FROZEN;
+	return current->todo != NULL;
 }
 
-/*
- * Check if there is a request to freeze a process
- */
-static inline int freezing(struct task_struct *p)
+static inline void run_todo_list(void)
 {
-	return p->flags & PF_FREEZE;
+	notifier_call_chain(&current->todo, 0, current);
 }
 
-/*
- * Request that a process be frozen
- * FIXME: SMP problem. We may not modify other process' flags!
- */
-static inline void freeze(struct task_struct *p)
+static inline int try_todo_list(void)
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
-}
-
-/*
- * freezing is complete, mark process as frozen
- */
-static inline void frozen_process(struct task_struct *p)
-{
-	p->flags = (p->flags & ~PF_FREEZE) | PF_FROZEN;
-}
-
-extern void refrigerator(void);
-extern int freeze_processes(void);
-extern void thaw_processes(void);
-
-static inline int try_to_freeze(void)
-{
-	if (freezing(current)) {
-		refrigerator();
+	if (todo_list_active()) {
+		run_todo_list();
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
 
-static inline int try_to_freeze(void) { return 0; }
+/*
+ * Compatibility definitions to use the suspend checkpoints for the task todo list.
+ * These may be removed once all uses of try_to_free,  refrigerator and freezing
+ * have been removed.
+ */
+#define try_to_freeze try_todo_list
+#define refrigerator run_todo_list
+#define freezing(p) todo_list_active()
 
-#endif /* CONFIG_PM */
 #endif /* __KERNEL__ */
 
 #endif
Index: linux-2.6.13-rc3/kernel/signal.c
===================================================================
--- linux-2.6.13-rc3.orig/kernel/signal.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/kernel/signal.c	2005-07-28 10:46:49.000000000 -0700
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
Index: linux-2.6.13-rc3/arch/frv/kernel/signal.c
===================================================================
--- linux-2.6.13-rc3.orig/arch/frv/kernel/signal.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/arch/frv/kernel/signal.c	2005-07-28 10:46:49.000000000 -0700
@@ -536,7 +536,7 @@
 	if (!user_mode(regs))
 		return 1;
 
-	if (try_to_freeze())
+	if (try_todo_list())
 		goto no_signal;
 
 	if (!oldset)
Index: linux-2.6.13-rc3/arch/h8300/kernel/signal.c
===================================================================
--- linux-2.6.13-rc3.orig/arch/h8300/kernel/signal.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/arch/h8300/kernel/signal.c	2005-07-28 10:46:49.000000000 -0700
@@ -517,7 +517,7 @@
 	if ((regs->ccr & 0x10))
 		return 1;
 
-	if (try_to_freeze())
+	if (try_todo_list())
 		goto no_signal;
 
 	current->thread.esp0 = (unsigned long) regs;
Index: linux-2.6.13-rc3/arch/i386/kernel/io_apic.c
===================================================================
--- linux-2.6.13-rc3.orig/arch/i386/kernel/io_apic.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/arch/i386/kernel/io_apic.c	2005-07-28 10:46:49.000000000 -0700
@@ -574,7 +574,7 @@
 	for ( ; ; ) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		time_remaining = schedule_timeout(time_remaining);
-		try_to_freeze();
+		try_todo_list();
 		if (time_after(jiffies,
 				prev_balance_time+balanced_irq_interval)) {
 			preempt_disable();
Index: linux-2.6.13-rc3/arch/i386/kernel/signal.c
===================================================================
--- linux-2.6.13-rc3.orig/arch/i386/kernel/signal.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/arch/i386/kernel/signal.c	2005-07-28 10:46:49.000000000 -0700
@@ -608,7 +608,7 @@
 	if (!user_mode(regs))
 		return 1;
 
-	if (try_to_freeze())
+	if (try_todo_list())
 		goto no_signal;
 
 	if (!oldset)
Index: linux-2.6.13-rc3/arch/m32r/kernel/signal.c
===================================================================
--- linux-2.6.13-rc3.orig/arch/m32r/kernel/signal.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/arch/m32r/kernel/signal.c	2005-07-28 10:46:49.000000000 -0700
@@ -371,7 +371,7 @@
 	if (!user_mode(regs))
 		return 1;
 
-	if (try_to_freeze()) 
+	if (try_todo_list())
 		goto no_signal;
 
 	if (!oldset)
Index: linux-2.6.13-rc3/arch/ppc/kernel/signal.c
===================================================================
--- linux-2.6.13-rc3.orig/arch/ppc/kernel/signal.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/arch/ppc/kernel/signal.c	2005-07-28 10:46:49.000000000 -0700
@@ -705,7 +705,7 @@
 	unsigned long frame, newsp;
 	int signr, ret;
 
-	if (try_to_freeze()) {
+	if (try_todo_list()) {
 		signr = 0;
 		if (!signal_pending(current))
 			goto no_signal;
Index: linux-2.6.13-rc3/arch/x86_64/kernel/signal.c
===================================================================
--- linux-2.6.13-rc3.orig/arch/x86_64/kernel/signal.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/arch/x86_64/kernel/signal.c	2005-07-28 10:46:49.000000000 -0700
@@ -425,7 +425,7 @@
 	if (!user_mode(regs))
 		return 1;
 
-	if (try_to_freeze())
+	if (try_todo_list())
 		goto no_signal;
 
 	if (!oldset)


