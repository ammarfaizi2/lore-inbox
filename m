Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWDFSJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWDFSJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 14:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWDFSJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 14:09:28 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:26776 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932151AbWDFSJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 14:09:26 -0400
Date: Fri, 7 Apr 2006 02:06:31 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] coredump: kill ptrace related stuff
Message-ID: <20060406220631.GA240@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With this patch zap_process() sets SIGNAL_GROUP_EXIT while sending
SIGKILL to the thread group. This means that a TASK_TRACED task

	1. Will be awakened by signal_wake_up(1)

	2. Can't sleep again via ptrace_notify()

	3. Can't go to do_signal_stop() after return
	   from ptrace_stop() in get_signal_to_deliver()

So we can remove all ptrace related stuff from coredump path.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- rc1/fs/exec.c~3_PTRACE	2006-04-06 15:19:33.000000000 +0400
+++ rc1/fs/exec.c	2006-04-06 19:56:36.000000000 +0400
@@ -1384,12 +1384,14 @@ static void format_corename(char *corena
 	*out_ptr = 0;
 }
 
-static void zap_process(struct task_struct *start, int *ptraced)
+static void zap_process(struct task_struct *start)
 {
 	struct task_struct *t;
 	unsigned long flags;
 
 	spin_lock_irqsave(&start->sighand->siglock, flags);
+	start->signal->flags = SIGNAL_GROUP_EXIT;
+	start->signal->group_stop_count = 0;
 
 	t = start;
 	do {
@@ -1397,22 +1399,17 @@ static void zap_process(struct task_stru
 			t->mm->core_waiters++;
 			sigaddset(&t->pending.signal, SIGKILL);
 			signal_wake_up(t, 1);
-
-			if (unlikely(t->ptrace) &&
-			    unlikely(t->parent->mm == t->mm))
-				*ptraced = 1;
 		}
 	} while ((t = next_thread(t)) != start);
 
 	spin_unlock_irqrestore(&start->sighand->siglock, flags);
 }
 
-static void zap_threads (struct mm_struct *mm)
+static void zap_threads(struct mm_struct *mm)
 {
 	struct task_struct *g, *p;
 	struct task_struct *tsk = current;
 	struct completion *vfork_done = tsk->vfork_done;
-	int traced = 0;
 
 	/*
 	 * Make sure nobody is waiting for us to release the VM,
@@ -1429,29 +1426,12 @@ static void zap_threads (struct mm_struc
 		do {
 			if (p->mm) {
 				if (p->mm == mm)
-					zap_process(p, &traced);
+					zap_process(p);
 				break;
 			}
 		} while ((p = next_thread(p)) != g);
 	}
 	read_unlock(&tasklist_lock);
-
-	if (unlikely(traced)) {
-		/*
-		 * We are zapping a thread and the thread it ptraces.
-		 * If the tracee went into a ptrace stop for exit tracing,
-		 * we could deadlock since the tracer is waiting for this
-		 * coredump to finish.  Detach them so they can both die.
-		 */
-		write_lock_irq(&tasklist_lock);
-		do_each_thread(g,p) {
-			if (mm == p->mm && p != tsk &&
-			    p->ptrace && p->parent->mm == mm) {
-				__ptrace_detach(p, 0);
-			}
-		} while_each_thread(g,p);
-		write_unlock_irq(&tasklist_lock);
-	}
 }
 
 static void coredump_wait(struct mm_struct *mm)
--- rc1/include/linux/ptrace.h~3_PTRACE	2006-03-01 21:57:22.000000000 +0300
+++ rc1/include/linux/ptrace.h	2006-04-06 16:37:54.000000000 +0400
@@ -84,7 +84,6 @@ extern int ptrace_readdata(struct task_s
 extern int ptrace_writedata(struct task_struct *tsk, char __user *src, unsigned long dst, int len);
 extern int ptrace_attach(struct task_struct *tsk);
 extern int ptrace_detach(struct task_struct *, unsigned int);
-extern void __ptrace_detach(struct task_struct *, unsigned int);
 extern void ptrace_disable(struct task_struct *);
 extern int ptrace_check_attach(struct task_struct *task, int kill);
 extern int ptrace_request(struct task_struct *child, long request, long addr, long data);
--- rc1/kernel/ptrace.c~3_PTRACE	2006-04-03 16:21:26.000000000 +0400
+++ rc1/kernel/ptrace.c	2006-04-06 16:41:41.000000000 +0400
@@ -183,7 +183,7 @@ bad:
 	return retval;
 }
 
-void __ptrace_detach(struct task_struct *child, unsigned int data)
+static inline void __ptrace_detach(struct task_struct *child, unsigned int data)
 {
 	child->exit_code = data;
 	/* .. re-parent .. */
@@ -202,8 +202,7 @@ int ptrace_detach(struct task_struct *ch
 	ptrace_disable(child);
 
 	write_lock_irq(&tasklist_lock);
-	if (child->ptrace)
-		__ptrace_detach(child, data);
+	__ptrace_detach(child, data);
 	write_unlock_irq(&tasklist_lock);
 
 	return 0;

