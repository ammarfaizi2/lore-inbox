Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314444AbSFDPx4>; Tue, 4 Jun 2002 11:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314451AbSFDPxz>; Tue, 4 Jun 2002 11:53:55 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:16890 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S314444AbSFDPxy>; Tue, 4 Jun 2002 11:53:54 -0400
Subject: [PATCH] scheduler hints
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Jun 2002 08:53:54 -0700
Message-Id: <1023206034.912.89.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So I went ahead and implemented scheduler hints on top of the O(1)
scheduler. 

I tried to find a decent paper on the web covering scheduler hints
(sometimes referred to as hint-based scheduling) but could not find
anything worthwhile.  Solaris, for example, implements scheduler hints
so perhaps the "Solaris Internals" book has some information. 

Basically, scheduler hints are a way for a program to give a "hint" to
the scheduler about its present behavior in the hopes of the scheduler
subsequently making better scheduling decisions.  After all, who knows
better than the application what it is about to do? 

For example, consider a group of SCHED_RR threads that share a
semaphore.  Before one of the threads were to acquire the semaphore, it
could give a "hint" to the scheduler to increase its remaining timeslice
in order to ensure it could complete its work and drop the semaphore
before being preempted.  Since, if it were preempted, it would just end
up being rescheduled as the other real-time threads would eventually
block on the held semaphore. 

Other hints could be "I am interactive" or "I am a batch (i.e. cpu hog)
task" or "I am cache hot: try to keep me on this CPU". 

The scheduler tries hard to figure out the three qualities and it is
usually right, although perhaps it can react quicker to these hints than
it can figure things out on its own.  If nothing else, this serves as a
useful tool for determining just how accurate our O(1) scheduler is.

I am not necessarily suggesting this for inclusion; it is more of a
"just for fun" thing that turned into something with what I am actually
seeing improvements, so I post it here for others to see.

You use scheduler hints in a program by doing something like, 

        sched_hint(hint)

where `hint' is currently one or more of:

        HINT_TIME - task needs some more quanta, boost
        remaining timeslice

        HINT_INTERACTIVE - task is interactive, give it a
        small priority bonus to help.

        HINT_BATCH - task is a batch-processed task, give
        it a small priority penalty to be fair.

Right now the code makes no attempt to be fair - a program giving
HINT_TIME now will not receive some sort of penalty later.  Thus
sched_hint requires CAP_SYS_NICE.  This really is not what we want; we
need any arbitrary task to be able to give these hints.  Since the
current solution is not fair, however, we cannot sanely do that.

A patch for 2.5.20 is attached.  A patch for 2.4 + O(1) scheduler as
well as a lame example program can be had at:

	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/sched/scheduler-hints

Any comments or suggestions are welcome.  Thanks,

        Robert Love

diff -urN linux-2.5.20/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-2.5.20/arch/i386/kernel/entry.S	Sun Jun  2 18:44:44 2002
+++ linux/arch/i386/kernel/entry.S	Mon Jun  3 13:48:43 2002
@@ -785,6 +785,7 @@
 	.long sys_futex		/* 240 */
 	.long sys_sched_setaffinity
 	.long sys_sched_getaffinity
+	.long sys_sched_hint
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
diff -urN linux-2.5.20/include/asm-i386/unistd.h linux/include/asm-i386/unistd.h
--- linux-2.5.20/include/asm-i386/unistd.h	Sun Jun  2 18:44:51 2002
+++ linux/include/asm-i386/unistd.h	Mon Jun  3 13:48:59 2002
@@ -247,6 +247,7 @@
 #define __NR_futex		240
 #define __NR_sched_setaffinity	241
 #define __NR_sched_getaffinity	242
+#define __NR_sched_hint		243
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -urN linux-2.5.20/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.5.20/include/linux/sched.h	Sun Jun  2 18:44:41 2002
+++ linux/include/linux/sched.h	Mon Jun  3 17:10:10 2002
@@ -116,6 +116,13 @@
 #endif
 
 /*
+ * Scheduling Hints
+ */
+#define HINT_TIME		1	/* increase remaining timeslice */
+#define HINT_INTERACTIVE	2	/* interactive task: prio bonus */
+#define HINT_BATCH		4	/* batch task: prio penalty */
+
+/*
  * Scheduling policies
  */
 #define SCHED_OTHER		0
diff -urN linux-2.5.20/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.20/kernel/sched.c	Sun Jun  2 18:44:44 2002
+++ linux/kernel/sched.c	Mon Jun  3 17:09:09 2002
@@ -1143,7 +1143,7 @@
 				policy != SCHED_OTHER)
 			goto out_unlock;
 	}
-	
+
 	/*
 	 * Valid priorities for SCHED_FIFO and SCHED_RR are
 	 * 1..MAX_USER_RT_PRIO, valid priority for SCHED_OTHER is 0.
@@ -1336,6 +1336,64 @@
 	return real_len;
 }
 
+/*
+ * sys_sched_hint - give the scheduler a hint to (hopefully) provide
+ * better scheduling behavior.  For example, if a task is about
+ * to acquire a highly contended resource, it would be wise to
+ * increase its remaining timeslice to ensure it could drop the
+ * resource before being preempted.
+ *
+ * `hint' is the hint to the scheduler, defined in include/linux/sched.h
+ */
+asmlinkage int sys_sched_hint(unsigned long hint)
+{
+	int ret = -EINVAL;
+	unsigned long flags;
+	runqueue_t *rq;
+
+	/*
+	 * Requiring CAP_SYS_NICE is an issue: we really want any task
+	 * to be able to give the scheduler a `hint' but we have no
+	 * way of ensuring fairness.  The compromise is to require
+	 * some sort of permission... you may want to get rid of this.
+	 */
+	if (!capable(CAP_SYS_NICE))
+		return -EPERM;
+
+	rq = task_rq_lock(current, &flags);
+
+	if (hint & HINT_TIME) {
+		current->time_slice = MAX_TIMESLICE;
+		/*
+		 * we may have run out of timeslice and have been
+		 * put on the expired runqueue: if so, fix that.
+		 */
+		if (unlikely(current->array != rq->active)) {
+			dequeue_task(current, current->array);
+			enqueue_task(current, rq->active);
+		}
+		ret = 0;
+	}
+
+	if (hint & HINT_INTERACTIVE) {
+		dequeue_task(current, current->array);
+		current->sleep_avg = MAX_SLEEP_AVG;
+		current->prio = effective_prio(current);
+		enqueue_task(current, rq->active);
+		ret = 0;
+	} else if (hint & HINT_BATCH) {
+		dequeue_task(current, current->array);
+		current->sleep_avg = 0;
+		current->prio = effective_prio(current);
+		enqueue_task(current, rq->active);
+		ret = 0;
+	}
+
+	task_rq_unlock(rq, &flags);
+
+	return ret;
+}
+
 asmlinkage long sys_sched_yield(void)
 {
 	runqueue_t *rq;
@@ -1376,6 +1434,7 @@
 
 	return 0;
 }
+
 asmlinkage long sys_sched_get_priority_max(int policy)
 {
 	int ret = -EINVAL;

