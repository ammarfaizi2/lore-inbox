Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264512AbTLTPUr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 10:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbTLTPUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 10:20:46 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:58248 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264497AbTLTPUf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 10:20:35 -0500
Message-ID: <3FE468BF.9000102@cyberone.com.au>
Date: Sun, 21 Dec 2003 02:20:31 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] 2.6.0 sched fork cleanup
References: <3FE46885.2030905@cyberone.com.au>
In-Reply-To: <3FE46885.2030905@cyberone.com.au>
Content-Type: multipart/mixed;
 boundary="------------060200050905010102090209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060200050905010102090209
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Move some fork related scheduler policy from fork.c to sched.c where it 
belongs.


--------------060200050905010102090209
Content-Type: text/plain;
 name="sched-fork-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-fork-cleanup.patch"


Move some fork related scheduler policy from fork.c to sched.c where it belongs.


 linux-2.6-npiggin/include/linux/sched.h |    1 
 linux-2.6-npiggin/kernel/fork.c         |   30 ++-------------------------
 linux-2.6-npiggin/kernel/sched.c        |   35 ++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 27 deletions(-)

diff -puN include/linux/sched.h~sched-fork-cleanup include/linux/sched.h
--- linux-2.6/include/linux/sched.h~sched-fork-cleanup	2003-12-19 14:22:29.000000000 +1100
+++ linux-2.6-npiggin/include/linux/sched.h	2003-12-19 14:22:29.000000000 +1100
@@ -580,6 +580,7 @@ extern int FASTCALL(wake_up_process(stru
  static inline void kick_process(struct task_struct *tsk) { }
 #endif
 extern void FASTCALL(wake_up_forked_process(struct task_struct * tsk));
+extern void FASTCALL(sched_fork(task_t * p));
 extern void FASTCALL(sched_exit(task_t * p));
 
 asmlinkage long sys_wait4(pid_t pid,unsigned int * stat_addr, int options, struct rusage * ru);
diff -puN kernel/fork.c~sched-fork-cleanup kernel/fork.c
--- linux-2.6/kernel/fork.c~sched-fork-cleanup	2003-12-19 14:22:29.000000000 +1100
+++ linux-2.6-npiggin/kernel/fork.c	2003-12-19 14:22:29.000000000 +1100
@@ -973,33 +973,9 @@ struct task_struct *copy_process(unsigne
 	p->exit_signal = (clone_flags & CLONE_THREAD) ? -1 : (clone_flags & CSIGNAL);
 	p->pdeath_signal = 0;
 
-	/*
-	 * Share the timeslice between parent and child, thus the
-	 * total amount of pending timeslices in the system doesn't change,
-	 * resulting in more scheduling fairness.
-	 */
-	local_irq_disable();
-        p->time_slice = (current->time_slice + 1) >> 1;
-	/*
-	 * The remainder of the first timeslice might be recovered by
-	 * the parent if the child exits early enough.
-	 */
-	p->first_time_slice = 1;
-	current->time_slice >>= 1;
-	p->timestamp = sched_clock();
-	if (!current->time_slice) {
-		/*
-	 	 * This case is rare, it happens when the parent has only
-	 	 * a single jiffy left from its timeslice. Taking the
-		 * runqueue lock is not a problem.
-		 */
-		current->time_slice = 1;
-		preempt_disable();
-		scheduler_tick(0, 0);
-		local_irq_enable();
-		preempt_enable();
-	} else
-		local_irq_enable();
+	/* Perform scheduler related accounting */
+	sched_fork(p);
+
 	/*
 	 * Ok, add it to the run-queues and make it
 	 * visible to the rest of the system.
diff -puN kernel/sched.c~sched-fork-cleanup kernel/sched.c
--- linux-2.6/kernel/sched.c~sched-fork-cleanup	2003-12-19 14:22:29.000000000 +1100
+++ linux-2.6-npiggin/kernel/sched.c	2003-12-19 14:22:29.000000000 +1100
@@ -674,6 +674,41 @@ int wake_up_state(task_t *p, unsigned in
 }
 
 /*
+ * Perform scheduler related accounting for a newly forked process p.
+ * p is forked by current.
+ */
+void sched_fork(task_t *p)
+{
+	/*
+	 * Share the timeslice between parent and child, thus the
+	 * total amount of pending timeslices in the system doesn't change,
+	 * resulting in more scheduling fairness.
+	 */
+	local_irq_disable();
+        p->time_slice = (current->time_slice + 1) >> 1;
+	/*
+	 * The remainder of the first timeslice might be recovered by
+	 * the parent if the child exits early enough.
+	 */
+	p->first_time_slice = 1;
+	current->time_slice >>= 1;
+	p->timestamp = sched_clock();
+	if (!current->time_slice) {
+		/*
+	 	 * This case is rare, it happens when the parent has only
+	 	 * a single jiffy left from its timeslice. Taking the
+		 * runqueue lock is not a problem.
+		 */
+		current->time_slice = 1;
+		preempt_disable();
+		scheduler_tick(0, 0);
+		local_irq_enable();
+		preempt_enable();
+	} else
+		local_irq_enable();
+}
+
+/*
  * wake_up_forked_process - wake up a freshly forked process.
  *
  * This function will do some initial scheduler statistics housekeeping

_

--------------060200050905010102090209--

