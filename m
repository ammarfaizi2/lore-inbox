Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbTJDLZr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 07:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbTJDLZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 07:25:47 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:58768 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S261982AbTJDLZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 07:25:43 -0400
From: David Woodhouse <dwmw2@infradead.org>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <1065266733.16088.91.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Sat, 04 Oct 2003 12:25:33 +0100
X-SA-Exim-Mail-From: dwmw2@infradead.org
Subject: JFFS2 swsusp / signal cleanup.
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How's this look?

===== fs/jffs2/background.c 1.19 vs edited =====
--- 1.19/fs/jffs2/background.c	Wed May 28 16:01:05 2003
+++ edited/fs/jffs2/background.c	Sat Oct  4 12:23:52 2003
@@ -19,6 +19,7 @@
 #include <linux/completion.h>
 #include <linux/sched.h>
 #include <linux/unistd.h>
+#include <linux/suspend.h>
 #include "nodelist.h"
 
 
@@ -89,10 +90,10 @@
 	set_user_nice(current, 10);
 
 	for (;;) {
-		spin_lock_irq(&current_sig_lock);
-		siginitsetinv (&current->blocked, sigmask(SIGHUP) | sigmask(SIGKILL) | sigmask(SIGSTOP) | sigmask(SIGCONT));
-		recalc_sigpending();
-		spin_unlock_irq(&current_sig_lock);
+		allow_signal(SIGHUP);
+		allow_signal(SIGKILL);
+		allow_signal(SIGSTOP);
+		allow_signal(SIGCONT);
 
 		if (!thread_should_wake(c)) {
 			set_current_state (TASK_INTERRUPTIBLE);
@@ -104,6 +105,13 @@
 			schedule();
 		}
 
+		if (current->flags & PF_FREEZE) {
+			refrigerator(0);	/* When this loses its stupid flush_signals() 
+						   and starts just calling recalc_sigpending(),
+						   you can remove the following: */
+			recalc_sigpending();
+		}
+
 		cond_resched();
 
 		/* Put_super will send a SIGKILL and then wait on the sem. 
@@ -112,9 +120,7 @@
 			siginfo_t info;
 			unsigned long signr;
 
-			spin_lock_irq(&current_sig_lock);
-			signr = dequeue_signal(current, &current->blocked, &info);
-			spin_unlock_irq(&current_sig_lock);
+			signr = dequeue_signal_lock(current, &current->blocked, &info);
 
 			switch(signr) {
 			case SIGSTOP:
@@ -138,10 +144,7 @@
 			}
 		}
 		/* We don't want SIGHUP to interrupt us. STOP and KILL are OK though. */
-		spin_lock_irq(&current_sig_lock);
-		siginitsetinv (&current->blocked, sigmask(SIGKILL) | sigmask(SIGSTOP) | sigmask(SIGCONT));
-		recalc_sigpending();
-		spin_unlock_irq(&current_sig_lock);
+		disallow_signal(SIGHUP);
 
 		D1(printk(KERN_DEBUG "jffs2_garbage_collect_thread(): pass\n"));
 		jffs2_garbage_collect_pass(c);
===== include/linux/sched.h 1.168 vs edited =====
--- 1.168/include/linux/sched.h	Thu Oct  2 08:12:14 2003
+++ edited/include/linux/sched.h	Sat Oct  4 12:23:15 2003
@@ -577,6 +577,19 @@
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
@@ -674,6 +687,7 @@
 extern void reparent_to_init(void);
 extern void daemonize(const char *, ...);
 extern int allow_signal(int);
+extern int disallow_signal(int);
 extern task_t *child_reaper;
 
 extern int do_execve(char *, char __user * __user *, char __user * __user *, struct pt_regs *);
===== kernel/exit.c 1.113 vs edited =====
--- 1.113/kernel/exit.c	Sun Sep 21 22:49:52 2003
+++ edited/kernel/exit.c	Sat Oct  4 12:11:54 2003
@@ -278,7 +278,20 @@
 	return 0;
 }
 
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
 EXPORT_SYMBOL(allow_signal);
+EXPORT_SYMBOL(disallow_signal);
 
 /*
  *	Put all the gunge required to become a kernel thread without

-- 
dwmw2


