Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263031AbUJ1RyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263031AbUJ1RyQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 13:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263029AbUJ1RyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 13:54:15 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:44011 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262248AbUJ1Rwm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 13:52:42 -0400
Date: Thu, 28 Oct 2004 19:52:29 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch] cputime: missing pieces.
Message-ID: <20041028175229.GA5477@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
I missed two places where cputime_t needs to be used. This goes
on top of the first patch and your fixup.

blue skies,
  Martin.

---

[patch] cputime: missing pieces.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Use cputime type and operations in do_task_stat, process_ticks and
thread_ticks as well.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 fs/proc/array.c       |   22 ++++++++++++----------
 kernel/posix-timers.c |   11 ++++++-----
 2 files changed, 18 insertions(+), 15 deletions(-)

diff -urN linux-2.6/fs/proc/array.c linux-2.6-cputime/fs/proc/array.c
--- linux-2.6/fs/proc/array.c	2004-10-28 19:31:13.000000000 +0200
+++ linux-2.6-cputime/fs/proc/array.c	2004-10-28 19:32:50.000000000 +0200
@@ -314,8 +314,9 @@
 	int num_threads = 0;
 	struct mm_struct *mm;
 	unsigned long long start_time;
-	unsigned long cmin_flt = 0, cmaj_flt = 0, cutime = 0, cstime = 0;
-	unsigned long  min_flt = 0,  maj_flt = 0,  utime = 0,  stime = 0;
+	unsigned long cmin_flt = 0, cmaj_flt = 0;
+	unsigned long  min_flt = 0,  maj_flt = 0;
+	cputime_t cutime, cstime, utime, stime;
 	unsigned long rsslim = 0;
 	struct task_struct *t;
 	char tcomm[sizeof(task->comm)];
@@ -333,6 +334,7 @@
 
 	sigemptyset(&sigign);
 	sigemptyset(&sigcatch);
+	cutime = cstime = utime = stime = cputime_zero;
 	read_lock(&tasklist_lock);
 	if (task->sighand) {
 		spin_lock_irq(&task->sighand->siglock);
@@ -345,8 +347,8 @@
 			do {
 				min_flt += t->min_flt;
 				maj_flt += t->maj_flt;
-				utime += t->utime;
-				stime += t->stime;
+				utime = cputime_add(utime, t->utime);
+				stime = cputime_add(stime, t->stime);
 				t = next_thread(t);
 			} while (t != task);
 		}
@@ -368,8 +370,8 @@
 		if (whole) {
 			min_flt += task->signal->min_flt;
 			maj_flt += task->signal->maj_flt;
-			utime += task->signal->utime;
-			stime += task->signal->stime;
+			utime = cputime_add(utime, task->signal->utime);
+			stime = cputime_add(stime, task->signal->stime);
 		}
 	}
 	ppid = task->pid ? task->group_leader->real_parent->tgid : 0;
@@ -412,10 +414,10 @@
 		cmin_flt,
 		maj_flt,
 		cmaj_flt,
-		jiffies_to_clock_t(utime),
-		jiffies_to_clock_t(stime),
-		jiffies_to_clock_t(cutime),
-		jiffies_to_clock_t(cstime),
+		cputime_to_clock_t(utime),
+		cputime_to_clock_t(stime),
+		cputime_to_clock_t(cutime),
+		cputime_to_clock_t(cstime),
 		priority,
 		nice,
 		num_threads,
diff -urN linux-2.6/kernel/posix-timers.c linux-2.6-cputime/kernel/posix-timers.c
--- linux-2.6/kernel/posix-timers.c	2004-10-28 19:31:13.000000000 +0200
+++ linux-2.6-cputime/kernel/posix-timers.c	2004-10-28 19:32:50.000000000 +0200
@@ -1230,26 +1230,27 @@
 }
 
 static unsigned long process_ticks(task_t *p) {
-	unsigned long ticks;
+	cputime_t cputime;
 	task_t *t;
 
 	spin_lock(&p->sighand->siglock);
 	/* The signal structure is shared between all threads */
-	ticks = p->signal->utime + p->signal->stime;
+	cputime = cputime_add(p->signal->utime, p->signal->stime);
 
 	/* Add up the cpu time for all the still running threads of this process */
 	t = p;
 	do {
-		ticks += t->utime + t->stime;
+		cputime = cputime_add(cputime, t->utime);
+		cputime = cputime_add(cputime, t->stime);
 		t = next_thread(t);
 	} while (t != p);
 
 	spin_unlock(&p->sighand->siglock);
-	return ticks;
+	return cputime_to_jiffies(cputime);
 }
 
 static inline unsigned long thread_ticks(task_t *p) {
-	return p->utime + current->stime;
+	return cputime_to_jiffies(cputime_add(p->utime, current->stime));
 }
 
 /*
