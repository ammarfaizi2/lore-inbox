Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131140AbRCMSkV>; Tue, 13 Mar 2001 13:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131151AbRCMSkM>; Tue, 13 Mar 2001 13:40:12 -0500
Received: from colorfullife.com ([216.156.138.34]:32262 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131140AbRCMSkE>;
	Tue, 13 Mar 2001 13:40:04 -0500
Message-ID: <3AAE6963.66301F61@colorfullife.com>
Date: Tue, 13 Mar 2001 19:39:31 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac17 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: riel@conectiva.com.br
CC: linux-kernel@vger.kernel.org
Subject: Re: system hang with "__alloc_page: 1-order allocation failed"
Content-Type: multipart/mixed;
 boundary="------------3B0825FC003483EB588CC1E0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------3B0825FC003483EB588CC1E0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> 
> Maybe it would be good to lower the default threads-max to 
> about 10% or less of physical memory ? 
>

And MIN_THREADS_FOR_ROOT should be reintroduced: the define is still
there, but the actual code is missing.

I've attached an older patch that:
* reintroduces MIN_THREADS_FOR_ROOT (or remove the define)
* adds lower and upper bounds for /proc/sys/kernel/threads-max.
* bugfixes for get_pid(). This is the longest part of the patch, but
it's only necessary if you have more than 10.000 threads running. If you
have enough memory: launch a forkbomb. If ~ 32760 thread are running the
kernel enters an endless loop in get_pid() (or around 11000 threads if
they intentionally create additional sessions and process groups)

I tested the patch with 2.4.0-test12, but not with newer kernels.

--
	Manfred
--------------3B0825FC003483EB588CC1E0
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

--------------3B0825FC003483EB588CC1E0--

