Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318757AbSIPDBe>; Sun, 15 Sep 2002 23:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318769AbSIPDBe>; Sun, 15 Sep 2002 23:01:34 -0400
Received: from dp.samba.org ([66.70.73.150]:16354 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S318757AbSIPDBd>;
	Sun, 15 Sep 2002 23:01:33 -0400
Date: Mon, 16 Sep 2002 13:06:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Remove CONFIG_SMP around wait_task_inactive()
Message-ID: <20020916030624.GB4482@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.  This defines wait_task_inactive() to be a no-op
on UP machines, and removes the #ifdef CONFIG_SMP which surrounds
current calls.

This also fixes compile on UP which was broken by the addition of a
call to wait_task_inactive in fs/exec.c which was not protected by an
#ifdef.

The patch is against 2.5.34

diff -urN /home/dgibson/kernel/linuxppc-2.5/arch/ia64/kernel/perfmon.c linux-bluefish/arch/ia64/kernel/perfmon.c
--- /home/dgibson/kernel/linuxppc-2.5/arch/ia64/kernel/perfmon.c	2002-08-14 18:28:28.000000000 +1000
+++ linux-bluefish/arch/ia64/kernel/perfmon.c	2002-09-16 12:57:56.000000000 +1000
@@ -2345,22 +2345,19 @@
 check_task_state(struct task_struct *task)
 {
 	int ret = 0;
-#ifdef CONFIG_SMP
+
 	/* We must wait until the state has been completely
 	 * saved. There can be situations where the reader arrives before
 	 * after the task is marked as STOPPED but before pfm_save_regs()
 	 * is completed.
 	 */
-	if (task->state != TASK_ZOMBIE && task->state != TASK_STOPPED) return -EBUSY;
-	DBprintk(("before wait_task_inactive [%d] state %ld\n", task->pid, task->state));
-	wait_task_inactive(task);
-	DBprintk(("after wait_task_inactive [%d] state %ld\n", task->pid, task->state));
-#else
 	if (task->state != TASK_ZOMBIE && task->state != TASK_STOPPED) {
 		DBprintk(("warning [%d] not in stable state %ld\n", task->pid, task->state));
 		ret = -EBUSY;
 	}
-#endif
+	DBprintk(("before wait_task_inactive [%d] state %ld\n", task->pid, task->state));
+	wait_task_inactive(task);
+	DBprintk(("after wait_task_inactive [%d] state %ld\n", task->pid, task->state));
 	return ret;
 }
 
diff -urN /home/dgibson/kernel/linuxppc-2.5/include/linux/sched.h linux-bluefish/include/linux/sched.h
--- /home/dgibson/kernel/linuxppc-2.5/include/linux/sched.h	2002-09-16 10:32:57.000000000 +1000
+++ linux-bluefish/include/linux/sched.h	2002-09-16 12:59:29.000000000 +1000
@@ -690,7 +690,11 @@
 extern void FASTCALL(add_wait_queue_exclusive(wait_queue_head_t *q, wait_queue_t * wait));
 extern void FASTCALL(remove_wait_queue(wait_queue_head_t *q, wait_queue_t * wait));
 
+#ifdef CONFIG_SMP
 extern void wait_task_inactive(task_t * p);
+#else
+#define wait_task_inactive(p)	do { } while (0)
+#endif
 extern void kick_if_running(task_t * p);
 
 #define __wait_event(wq, condition) 					\
diff -urN /home/dgibson/kernel/linuxppc-2.5/kernel/exit.c linux-bluefish/kernel/exit.c
--- /home/dgibson/kernel/linuxppc-2.5/kernel/exit.c	2002-09-16 10:32:57.000000000 +1000
+++ linux-bluefish/kernel/exit.c	2002-09-16 12:57:22.000000000 +1000
@@ -55,10 +55,8 @@
 
 	if (p->state != TASK_ZOMBIE)
 		BUG();
-#ifdef CONFIG_SMP
 	if (p != current)
 		wait_task_inactive(p);
-#endif
 	atomic_dec(&p->user->processes);
 	security_ops->task_free_security(p);
 	free_uid(p->user);
diff -urN /home/dgibson/kernel/linuxppc-2.5/kernel/ptrace.c linux-bluefish/kernel/ptrace.c
--- /home/dgibson/kernel/linuxppc-2.5/kernel/ptrace.c	2002-09-09 11:45:00.000000000 +1000
+++ linux-bluefish/kernel/ptrace.c	2002-09-16 12:57:15.000000000 +1000
@@ -69,9 +69,7 @@
 	if (!kill) {
 		if (child->state != TASK_STOPPED)
 			return -ESRCH;
-#ifdef CONFIG_SMP
 		wait_task_inactive(child);
-#endif		
 	}
 
 	/* All systems go.. */


-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
