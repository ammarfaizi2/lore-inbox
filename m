Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269801AbRHMVMy>; Mon, 13 Aug 2001 17:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269782AbRHMVMo>; Mon, 13 Aug 2001 17:12:44 -0400
Received: from ezri.xs4all.nl ([194.109.253.9]:26085 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S269144AbRHMVMf>;
	Mon, 13 Aug 2001 17:12:35 -0400
Date: Mon, 13 Aug 2001 23:12:42 +0200 (CEST)
From: Eric Lammerts <eric@lammerts.org>
To: Rik van Riel <riel@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] oom killer killing all threads
Message-ID: <Pine.LNX.4.33.0108132151110.31526-100000@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,
I recently had the following problem: Roxen (a webserver that uses
threads) was running out of control, eating up more and more memory.
(btw, I'd rather run Apache but it's not my decision to make).

The oom killer kicked in and started killing roxen processes.
Apparently it didn't succeed in killing _all_ threads. So it didn't
help at all, and the machine had to be rebooted.

Wouldn't it be a good idea to kill all processes that have the same
->mm as the process that was selected to be killed? The patch below
implements it. I've tested it and it seems to work nicely.

Eric

--- linux-2.4.8-ac3/mm/oom_kill.c.orig	Sat Jul  7 02:02:23 2001
+++ linux-2.4.8-ac3/mm/oom_kill.c	Mon Aug 13 23:06:07 2001
@@ -132,34 +132,20 @@
 		}
 	}
 	read_unlock(&tasklist_lock);
 	return chosen;
 }

 /**
- * oom_kill - kill the "best" process when we run out of memory
- *
- * If we run out of memory, we have the choice between either
- * killing a random task (bad), letting the system crash (worse)
- * OR try to be smart about which process to kill. Note that we
- * don't have to be perfect here, we just have to be good.
- *
  * We must be careful though to never send SIGKILL a process with
  * CAP_SYS_RAW_IO set, send SIGTERM instead (but it's unlikely that
  * we select a process with CAP_SYS_RAW_IO set).
  */
-void oom_kill(void)
+void oom_kill_task(struct task_struct *p)
 {
-
-	struct task_struct *p = select_bad_process();
-
-	/* Found nothing?!?! Either we hang forever, or we panic. */
-	if (p == NULL)
-		panic("Out of memory and no killable processes...\n");
-
 	printk(KERN_ERR "Out of Memory: Killed process %d (%s).\n", p->pid, p->comm);

 	/*
 	 * We give our sacrificial lamb high priority and access to
 	 * all the memory it needs. That way it should be able to
 	 * exit() and clear out its resources quickly...
 	 */
@@ -168,15 +154,39 @@

 	/* This process has hardware access, be more careful. */
 	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)) {
 		force_sig(SIGTERM, p);
 	} else {
 		force_sig(SIGKILL, p);
 	}
+}

+/**
+ * oom_kill - kill the "best" process when we run out of memory
+ *
+ * If we run out of memory, we have the choice between either
+ * killing a random task (bad), letting the system crash (worse)
+ * OR try to be smart about which process to kill. Note that we
+ * don't have to be perfect here, we just have to be good.
+ */
+void oom_kill(void)
+{
+	struct task_struct *p = select_bad_process(), *q;
+
+	/* Found nothing?!?! Either we hang forever, or we panic. */
+	if (p == NULL)
+		panic("Out of memory and no killable processes...\n");
+
+	/* kill all processes that share the ->mm (i.e. all threads) */
+	read_lock(&tasklist_lock);
+	for_each_task(q) {
+		if(q->mm == p->mm) oom_kill_task(q);
+	}
+	read_unlock(&tasklist_lock);
+
 	/*
 	 * Make kswapd go out of the way, so "p" has a good chance of
 	 * killing itself before someone else gets the chance to ask
 	 * for more memory.
 	 */
 	current->policy |= SCHED_YIELD;
 	schedule();


