Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbTJMKbn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 06:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbTJMKbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 06:31:43 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:49803 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261606AbTJMKbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 06:31:38 -0400
Subject: [RFC][PATCH] Kernel thread signal handling.
From: David Woodhouse <dwmw2@infradead.org>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1066041096.24015.431.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Mon, 13 Oct 2003 11:31:37 +0100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: dwmw2@infradead.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. We need disallow_signal() to complement allow_signal().

2. We need a function which does dequeue_signal() _with_ locking.

3. We might need a better name for #2. Change if you care.

4. We need allow_signal() to actually allow signals other than
   SIGKILL. Currently they get either converted to SIGKILL or
   silently dropped, according to whether your kernel thread
   happens to have sa_handler set for the signal in question.

   It would be nicer to fix this in the signal delivery code
   itself if (!tsk->mm) rather than by faking a handler in
   allow_signal(). I'm not touching the signal delivery code
   with a bargepole though. Hopefully the proposed change to
   allow_signal() will provoke someone else into doing so.

===== include/linux/sched.h 1.171 vs edited =====
--- 1.171/include/linux/sched.h	Thu Oct  9 23:13:53 2003
+++ edited/include/linux/sched.h	Mon Oct 13 10:11:07 2003
@@ -576,6 +576,19 @@
 extern void flush_signals(struct task_struct *);
 extern void flush_signal_handlers(struct task_struct *, int force_default);
 extern int dequeue_signal(struct task_struct *tsk, sigset_t *mask, siginfo_t *info);
+
+static inline int dequeue_signal_lock(struct task_struct *tsk, sigset_t *mask, siginfo_t *info)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&tsk->sighand->siglock, flags);
+	ret = dequeue_signal(tsk, mask, info);
+	spin_unlock_irqrestore(&tsk->sighand->siglock, flags);
+
+	return ret;
+}	
+
 extern void block_all_signals(int (*notifier)(void *priv), void *priv,
 			      sigset_t *mask);
 extern void unblock_all_signals(void);
@@ -673,6 +686,7 @@
 extern void reparent_to_init(void);
 extern void daemonize(const char *, ...);
 extern int allow_signal(int);
+extern int disallow_signal(int);
 extern task_t *child_reaper;
 
 extern int do_execve(char *, char __user * __user *, char __user * __user *, struct pt_regs *);
===== kernel/exit.c 1.116 vs edited =====
--- 1.116/kernel/exit.c	Thu Oct  9 23:13:54 2003
+++ edited/kernel/exit.c	Mon Oct 13 11:19:04 2003
@@ -273,12 +273,33 @@
 
 	spin_lock_irq(&current->sighand->siglock);
 	sigdelset(&current->blocked, sig);
+	if (!current->mm) {
+		/* Kernel threads handle their own signals.
+		   Let the signal code know it'll be handled, so
+		   that they don't get converted to SIGKILL or
+		   just silently dropped */
+		current->sighand->action[(sig)-1].sa.sa_handler = (void *)2;
+	}
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
 	return 0;
 }
 
 EXPORT_SYMBOL(allow_signal);
+
+int disallow_signal(int sig)
+{
+	if (sig < 1 || sig > _NSIG)
+		return -EINVAL;
+
+	spin_lock_irq(&current->sighand->siglock);
+	sigaddset(&current->blocked, sig);
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
+	return 0;
+}
+
+EXPORT_SYMBOL(disallow_signal);
 
 /*
  *	Put all the gunge required to become a kernel thread without
===== fs/jffs2/background.c 1.20 vs edited =====
--- 1.20/fs/jffs2/background.c	Sat Oct 11 15:47:54 2003
+++ edited/fs/jffs2/background.c	Mon Oct 13 11:17:54 2003
@@ -19,6 +19,7 @@
 #include <linux/completion.h>
 #include <linux/sched.h>
 #include <linux/unistd.h>
+#include <linux/suspend.h>
 #include "nodelist.h"
 
 
@@ -75,6 +76,9 @@
 	struct jffs2_sb_info *c = _c;
 
 	daemonize("jffs2_gcd_mtd%d", c->mtd->index);
+	allow_signal(SIGKILL);
+	allow_signal(SIGSTOP);
+	allow_signal(SIGCONT);
 
 	c->gc_task = current;
 	up(&c->gc_thread_start);
@@ -82,10 +86,7 @@
 	set_user_nice(current, 10);
 
 	for (;;) {
-		spin_lock_irq(&current_sig_lock);
-		siginitsetinv (&current->blocked, sigmask(SIGHUP) | sigmask(SIGKILL) | sigmask(SIGSTOP) | sigmask(SIGCONT));
-		recalc_sigpending();
-		spin_unlock_irq(&current_sig_lock);
+		allow_signal(SIGHUP);
 
 		if (!thread_should_wake(c)) {
 			set_current_state (TASK_INTERRUPTIBLE);
@@ -97,6 +98,13 @@
 			schedule();
 		}
 
+		if (current->flags & PF_FREEZE) {
+			refrigerator(0);
+			/* refrigerator() should recalc sigpending for us
+			   but doesn't. No matter - allow_signal() will. */
+			continue;
+		}
+
 		cond_resched();
 
 		/* Put_super will send a SIGKILL and then wait on the sem. 
@@ -105,9 +113,7 @@
 			siginfo_t info;
 			unsigned long signr;
 
-			spin_lock_irq(&current_sig_lock);
-			signr = dequeue_signal(current, &current->blocked, &info);
-			spin_unlock_irq(&current_sig_lock);
+			signr = dequeue_signal_lock(current, &current->blocked, &info);
 
 			switch(signr) {
 			case SIGSTOP:
@@ -132,10 +138,7 @@
 			}
 		}
 		/* We don't want SIGHUP to interrupt us. STOP and KILL are OK though. */
-		spin_lock_irq(&current_sig_lock);
-		siginitsetinv (&current->blocked, sigmask(SIGKILL) | sigmask(SIGSTOP) | sigmask(SIGCONT));
-		recalc_sigpending();
-		spin_unlock_irq(&current_sig_lock);
+		disallow_signal(SIGHUP);
 
 		D1(printk(KERN_DEBUG "jffs2_garbage_collect_thread(): pass\n"));
 		if (jffs2_garbage_collect_pass(c) == -ENOSPC) {


-- 
dwmw2

