Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315627AbSEZDvd>; Sat, 25 May 2002 23:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315628AbSEZDvc>; Sat, 25 May 2002 23:51:32 -0400
Received: from holomorphy.com ([66.224.33.161]:16804 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315627AbSEZDvb>;
	Sat, 25 May 2002 23:51:31 -0400
Date: Sat, 25 May 2002 20:51:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: rml@tech9.net, mingo@elte.hu, torvalds@transmeta.com
Subject: O(1) count_active_tasks()
Message-ID: <20020526035115.GM14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, rml@tech9.net, mingo@elte.hu,
	torvalds@transmeta.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rml, I heard you're interested in this, but regardless, here it is.
AFAICT it computes a faithful load average. Against latest 2.5.18 bk.
rml, don't worry about stomping on this if you need the counters
ticking for something else and you can do the same thing(s).

mingo, I've cc:'d you on this because it touches the scheduler.

Also available from:

ftp://ftp.kernel.org/pub/linux/kernel/people/wli/task_mgmt/count_active_tasks-2.5.18-1

This patch is part of my for_each_tasks() project.


Cheers,
Bill


diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Sat May 25 20:29:51 2002
+++ b/include/linux/sched.h	Sat May 25 20:29:51 2002
@@ -80,6 +80,7 @@
 extern int nr_threads;
 extern int last_pid;
 extern unsigned long nr_running(void);
+extern unsigned long nr_uninterruptible(void);
 
 #include <linux/time.h>
 #include <linux/param.h>
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Sat May 25 20:29:51 2002
+++ b/kernel/sched.c	Sat May 25 20:29:51 2002
@@ -133,6 +133,7 @@
 	spinlock_t lock;
 	spinlock_t frozen;
 	unsigned long nr_running, nr_switches, expired_timestamp;
+	signed long nr_uninterruptible;
 	task_t *curr, *idle;
 	prio_array_t *active, *expired, arrays[2];
 	int prev_nr_running[NR_CPUS];
@@ -240,6 +241,8 @@
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
 	rq->nr_running--;
+	if (p->state == TASK_UNINTERRUPTIBLE)
+		rq->nr_uninterruptible++;
 	dequeue_task(p, p->array);
 	p->array = NULL;
 }
@@ -319,11 +322,16 @@
 {
 	unsigned long flags;
 	int success = 0;
+	int uninterruptible = 0;
 	runqueue_t *rq;
 
 	rq = task_rq_lock(p, &flags);
+	if (p->state == TASK_UNINTERRUPTIBLE)
+		uninterruptible = 1;
 	p->state = TASK_RUNNING;
 	if (!p->array) {
+		if (uninterruptible)
+			rq->nr_uninterruptible--;
 		activate_task(p, rq);
 		if (p->prio < rq->curr->prio)
 			resched_task(rq->curr);
@@ -425,6 +433,16 @@
 
 	for (i = 0; i < smp_num_cpus; i++)
 		sum += cpu_rq(cpu_logical_map(i))->nr_running;
+
+	return sum;
+}
+
+unsigned long nr_uninterruptible(void)
+{
+	unsigned long i, sum = 0;
+
+	for (i = 0; i < smp_num_cpus; i++)
+		sum += cpu_rq(cpu_logical_map(i))->nr_uninterruptible;
 
 	return sum;
 }
diff -Nru a/kernel/timer.c b/kernel/timer.c
--- a/kernel/timer.c	Sat May 25 20:29:51 2002
+++ b/kernel/timer.c	Sat May 25 20:29:51 2002
@@ -597,17 +597,7 @@
  */
 static unsigned long count_active_tasks(void)
 {
-	struct task_struct *p;
-	unsigned long nr = 0;
-
-	read_lock(&tasklist_lock);
-	for_each_task(p) {
-		if ((p->state == TASK_RUNNING ||
-		     (p->state & TASK_UNINTERRUPTIBLE)))
-			nr += FIXED_1;
-	}
-	read_unlock(&tasklist_lock);
-	return nr;
+	return (nr_running() + nr_uninterruptible()) * FIXED_1;
 }
 
 /*
