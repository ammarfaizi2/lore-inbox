Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQLWR2u>; Sat, 23 Dec 2000 12:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129260AbQLWR2k>; Sat, 23 Dec 2000 12:28:40 -0500
Received: from colorfullife.com ([216.156.138.34]:26637 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129210AbQLWR22>;
	Sat, 23 Dec 2000 12:28:28 -0500
Message-ID: <3A44D3F3.522AD08A@colorfullife.com>
Date: Sat, 23 Dec 2000 17:33:55 +0100
From: Manfred <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, tytso@mit.edu, torvalds@transmeta.com
Subject: minor bugs around fork_init
Content-Type: multipart/mixed;
 boundary="------------A463F976AA291D83D6DA381D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A463F976AA291D83D6DA381D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I found 4 minor problems in the thread creation code:

* 2.2 reserved 4 threads for root, and 2.4 still has the
define (MIN_THREADS_LEFT_FOR_ROOT), but the code is missing :-(

* get_pid causes a deadlock when all pid numbers are in use.
In the worst case, only 10900 threads are required to exhaust
the 15 bit pid space.

* in theory, fork_init() might give 2 tasks the same pid, although
this can only happen when all but 1 or 2 pids are in use:

<<
fork_init() runs with the BKL acquired.
It first calls get_pid(), and get_pid() internally scans
	the task queue and returns a pid number that
	is not used by a thread on the task queue.
	But it doesn't add the thread to the task queue.

copy_xy() can sleep, thus the BKL is released.

At the end of fork_init(), the new task is added to the task queue.

--> if 2 thread are within fork_init(), then both might get the
same pid!
>>>

* the spinlock within get_pid is bogus: get_pid isn't SMP safe.

I've attached a patch (tested with 2.4.0-test12).


--
  Manfred
--------------A463F976AA291D83D6DA381D
Content-Type: text/plain; charset=us-ascii;
 name="patch-pid"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-pid"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 4
//  SUBLEVEL = 0
//  EXTRAVERSION = -test12
--- 2.4/kernel/sysctl.c	Sun Dec 17 18:04:04 2000
+++ build-2.4/kernel/sysctl.c	Sat Dec 23 17:29:52 2000
@@ -45,6 +45,7 @@
 extern int bdf_prm[], bdflush_min[], bdflush_max[];
 extern int sysctl_overcommit_memory;
 extern int max_threads;
+extern int threads_high, threads_low;
 extern int nr_queued_signals, max_queued_signals;
 extern int sysrq_enabled;
 
@@ -222,7 +223,8 @@
 	 0644, NULL, &proc_dointvec},
 #endif	 
 	{KERN_MAX_THREADS, "threads-max", &max_threads, sizeof(int),
-	 0644, NULL, &proc_dointvec},
+	 0644, NULL, &proc_dointvec_minmax, &sysctl_intvec, NULL,
+	&threads_low, &threads_high},
 	{KERN_RANDOM, "random", NULL, 0, 0555, random_table},
 	{KERN_OVERFLOWUID, "overflowuid", &overflowuid, sizeof(int), 0644, NULL,
 	 &proc_dointvec_minmax, &sysctl_intvec, NULL,
--- 2.4/kernel/fork.c	Sun Dec 17 18:04:04 2000
+++ build-2.4/kernel/fork.c	Sat Dec 23 16:59:47 2000
@@ -63,6 +63,11 @@
 	wq_write_unlock_irqrestore(&q->lock, flags);
 }
 
+#define THREADS_HIGH	32000
+#define THREADS_LOW	16
+int threads_high = THREADS_HIGH;
+int threads_low = THREADS_LOW;
+
 void __init fork_init(unsigned long mempages)
 {
 	/*
@@ -71,53 +76,79 @@
 	 * of memory.
 	 */
 	max_threads = mempages / (THREAD_SIZE/PAGE_SIZE) / 2;
+	if(max_threads > threads_high)
+		max_threads = threads_high;
 
 	init_task.rlim[RLIMIT_NPROC].rlim_cur = max_threads/2;
 	init_task.rlim[RLIMIT_NPROC].rlim_max = max_threads/2;
 }
 
-/* Protects next_safe and last_pid. */
-spinlock_t lastpid_lock = SPIN_LOCK_UNLOCKED;
+/*
+ * Reserve a few pid values for root, otherwise
+ * the reserved threads might not help him ;-)
+ */
+#define PIDS_FOR_ROOT	60
 
-static int get_pid(unsigned long flags)
+static int search_pid(int start, int* plimit)
 {
-	static int next_safe = PID_MAX;
+	int next_safe = *plimit;
 	struct task_struct *p;
+	int loop = 0;
 
-	if (flags & CLONE_PID)
-		return current->pid;
-
-	spin_lock(&lastpid_lock);
-	if((++last_pid) & 0xffff8000) {
-		last_pid = 300;		/* Skip daemons etc. */
-		goto inside;
-	}
-	if(last_pid >= next_safe) {
-inside:
-		next_safe = PID_MAX;
-		read_lock(&tasklist_lock);
-	repeat:
-		for_each_task(p) {
-			if(p->pid == last_pid	||
-			   p->pgrp == last_pid	||
-			   p->session == last_pid) {
-				if(++last_pid >= next_safe) {
-					if(last_pid & 0xffff8000)
-						last_pid = 300;
-					next_safe = PID_MAX;
+	if(start >= *plimit || start < 300) {
+		loop = 1;
+		start=300;
+	}
+repeat:
+	read_lock(&tasklist_lock);
+	for_each_task(p) {
+		if(p->pid == start	||
+		   p->pgrp == start	||
+		   p->session == start) {
+			if(++start >= next_safe) {
+				read_unlock(&tasklist_lock);
+				if(start >= *plimit) {
+					if(loop) {
+						next_safe=-1;
+						start=-1;
+						break;
+					}
+					loop=1;
+					start = 300;
 				}
+				next_safe = *plimit;
 				goto repeat;
 			}
-			if(p->pid > last_pid && next_safe > p->pid)
-				next_safe = p->pid;
-			if(p->pgrp > last_pid && next_safe > p->pgrp)
-				next_safe = p->pgrp;
-			if(p->session > last_pid && next_safe > p->session)
-				next_safe = p->session;
 		}
-		read_unlock(&tasklist_lock);
+		if(p->pid > start && next_safe > p->pid)
+			next_safe = p->pid;
+		if(p->pgrp > start && next_safe > p->pgrp)
+			next_safe = p->pgrp;
+		if(p->session > start && next_safe > p->session)
+			next_safe = p->session;
+	}
+	read_unlock(&tasklist_lock);
+	*plimit=next_safe; 
+	return start;
+}
+
+static int get_pid(unsigned long flags, int is_root)
+{
+	static int next_safe = PID_MAX-PIDS_FOR_ROOT;
+
+	if (flags & CLONE_PID)
+		return current->pid;
+
+	if(++last_pid < next_safe)
+		return last_pid;
+
+	next_safe = PID_MAX-PIDS_FOR_ROOT;
+	last_pid = search_pid(last_pid, &next_safe);
+
+	if(last_pid==-1 && is_root) {
+		int dummy = PID_MAX;
+		return search_pid(PID_MAX-PIDS_FOR_ROOT, &dummy);
 	}
-	spin_unlock(&lastpid_lock);
 
 	return last_pid;
 }
@@ -573,8 +604,13 @@
 	 * the kernel lock so nr_threads can't
 	 * increase under us (but it may decrease).
 	 */
-	if (nr_threads >= max_threads)
-		goto bad_fork_cleanup_count;
+	{
+		int limit = max_threads;
+		if(current->uid)
+			limit -= MIN_THREADS_LEFT_FOR_ROOT;
+		if (nr_threads >= limit)
+			goto bad_fork_cleanup_count;
+	}
 	
 	get_exec_domain(p->exec_domain);
 
@@ -586,7 +622,6 @@
 	p->state = TASK_UNINTERRUPTIBLE;
 
 	copy_flags(clone_flags, p);
-	p->pid = get_pid(clone_flags);
 
 	p->run_list.next = NULL;
 	p->run_list.prev = NULL;
@@ -662,6 +697,16 @@
 	current->counter >>= 1;
 	if (!current->counter)
 		current->need_resched = 1;
+	
+	/* get the pid value last, we must atomically add the new
+	 * thread to the task lists.
+	 * Atomicity is guaranteed by lock_kernel().
+	 */
+	p->pid = get_pid(clone_flags, !current->uid);
+	if(p->pid==-1) {
+		/* FIXME: cleanup for copy_thread? */
+		goto bad_fork_cleanup_sighand;
+	}
 
 	/*
 	 * Ok, add it to the run-queues and make it


--------------A463F976AA291D83D6DA381D--


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
