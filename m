Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313862AbSDZLns>; Fri, 26 Apr 2002 07:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313865AbSDZLnr>; Fri, 26 Apr 2002 07:43:47 -0400
Received: from [195.223.140.120] ([195.223.140.120]:12832 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S313862AbSDZLnp>; Fri, 26 Apr 2002 07:43:45 -0400
Date: Fri, 26 Apr 2002 13:44:09 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, Ihno Krumreich <ihno@suse.de>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: get_pid fixes against 2.4.19pre7
Message-ID: <20020426134409.C19278@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Could you have a look at these get_pid fixes? Besides the deadlocking
while running out of pids and reducing from quadratic to linear the
complexity of get_pids, it also addresses a longstanding non trivial
race present in 2.2 too that can lead to pid collisions even on UP
(noticed today while merging two more fixes from Ihno on the other
part). the fix reduces a bit scalability of simultaneous forks from
different cpus, but it's obviously right at least. Putting non-ready
tasks into the tasklists asks for troubles (signals...).  For more
details see the comment at the end of the patch. If you've suggestions
they're welcome, thanks.

Patch in pre7aa2 against 2.4.19pre7:

diff -urN 2.4.19pre7/include/linux/threads.h get_pid-1/include/linux/threads.h
--- 2.4.19pre7/include/linux/threads.h	Thu Apr 18 07:51:30 2002
+++ get_pid-1/include/linux/threads.h	Fri Apr 26 09:10:30 2002
@@ -19,6 +19,6 @@
 /*
  * This controls the maximum pid allocated to a process
  */
-#define PID_MAX 0x8000
+#define PID_NR 0x8000
 
 #endif
diff -urN 2.4.19pre7/kernel/fork.c get_pid-1/kernel/fork.c
--- 2.4.19pre7/kernel/fork.c	Tue Apr 16 08:12:09 2002
+++ get_pid-1/kernel/fork.c	Fri Apr 26 10:25:33 2002
@@ -37,6 +37,12 @@
 
 struct task_struct *pidhash[PIDHASH_SZ];
 
+/*
+ * Protectes next_unsafe, last_pid and it avoids races
+ * between get_pid and SET_LINKS().
+ */
+static DECLARE_MUTEX(getpid_mutex);
+
 void add_wait_queue(wait_queue_head_t *q, wait_queue_t * wait)
 {
 	unsigned long flags;
@@ -79,51 +85,105 @@
 	init_task.rlim[RLIMIT_NPROC].rlim_max = max_threads/2;
 }
 
-/* Protects next_safe and last_pid. */
-spinlock_t lastpid_lock = SPIN_LOCK_UNLOCKED;
-
+/*
+ *	Get the next free pid for a new process/thread.
+ *
+ *	Strategy: last_pid and next_unsafe (excluded) are an interval where all pids
+ *		  are free, so next pid is just last_pid + 1 if it's also < next_unsafe.
+ *		  If last_pid + 1 >= next_unsafe the interval is completely used.
+ *		  In this case a bitmap with all used pids/tgids/pgrp/seesion is
+ *		  is created. This bitmap is looked for the next free pid and next_unsafe.
+ *		  If all pids are used, a kernel warning is issued.
+ */
 static int get_pid(unsigned long flags)
 {
-	static int next_safe = PID_MAX;
+	static int next_unsafe = PID_NR;
+#define PID_FIRST	2 /* pid 1 is init, first usable pid is 2 */
+#define PID_BITMAP_SIZE	((((PID_NR + 7) / 8) + sizeof(long) - 1 ) / (sizeof(long)))
+	/*
+	 * Even if this could be local per-thread, keep it static and protected by
+	 * the lock because we don't want to overflow the stack and we wouldn't
+	 * SMP scale better anyways. It doesn't waste disk space because it's in
+	 * the .bss.
+	 */
+	static unsigned long pid_bitmap[PID_BITMAP_SIZE];
+
+	/* from here the stuff on the stack */
 	struct task_struct *p;
-	int pid;
+	int pid, found_pid;
 
 	if (flags & CLONE_PID)
 		return current->pid;
 
-	spin_lock(&lastpid_lock);
-	if((++last_pid) & 0xffff8000) {
-		last_pid = 300;		/* Skip daemons etc. */
-		goto inside;
-	}
-	if(last_pid >= next_safe) {
-inside:
-		next_safe = PID_MAX;
+	pid = last_pid + 1;
+	if (pid >= next_unsafe) {
+		next_unsafe = PID_NR;
+		memset(pid_bitmap, 0, PID_BITMAP_SIZE*sizeof(long));
+
 		read_lock(&tasklist_lock);
-	repeat:
+		/*
+		 * Build the bitmap and calc next_unsafe.
+		 */
 		for_each_task(p) {
-			if(p->pid == last_pid	||
-			   p->pgrp == last_pid	||
-			   p->tgid == last_pid	||
-			   p->session == last_pid) {
-				if(++last_pid >= next_safe) {
-					if(last_pid & 0xffff8000)
-						last_pid = 300;
-					next_safe = PID_MAX;
+			set_bit(p->pid, pid_bitmap);
+			set_bit(p->pgrp, pid_bitmap);
+			set_bit(p->tgid, pid_bitmap);
+			set_bit(p->session, pid_bitmap);
+
+			if (next_unsafe > p->pid && p->pid > pid)
+				next_unsafe = p->pid;
+			if (next_unsafe > p->pgrp && p->pgrp > pid)
+				next_unsafe = p->pgrp;
+			if (next_unsafe > p->tgid && p->tgid > pid)
+				next_unsafe = p->tgid;
+			if (next_unsafe > p->session && p->session > pid)
+				next_unsafe = p->session;
+		}
+
+		/*
+		 * Release the tasklist_lock, after the unlock it may happen that
+		 * a pid is freed while it's still marked in use
+		 * in the pid_bitmap[].
+		 */
+		read_unlock(&tasklist_lock);
+
+		found_pid = find_next_zero_bit(pid_bitmap, PID_NR, pid);
+		if (found_pid >= PID_NR) {
+			next_unsafe = 0; /* depends on PID_FIRST > 0 */
+			found_pid = find_next_zero_bit(pid_bitmap, pid, PID_FIRST);
+			/* We scanned the whole bitmap without finding a free pid. */
+			if (found_pid >= pid) {
+				static long last_get_pid_warning;
+				if ((unsigned long) (jiffies - last_get_pid_warning) >= HZ) {
+					printk(KERN_NOTICE "No more PIDs (PID_NR = %d)\n", PID_NR);
+					last_get_pid_warning = jiffies;
 				}
-				goto repeat;
+				return -1;
+			}
+		}
+
+		pid = found_pid;
+
+		if (pid > next_unsafe) {
+			/* recalc next_unsafe by looking for the next bit set in the bitmap */
+			unsigned long * start = pid_bitmap;
+			unsigned long * p = start + (pid / (sizeof(long) * 8));
+			unsigned long * end = pid_bitmap + PID_BITMAP_SIZE;
+			unsigned long mask = ~((1UL << (pid & ((sizeof(long) * 8 - 1)))) - 1);
+
+			*p &= (mask << 1);
+
+			while (p < end) {
+				if (*p) {
+					next_unsafe = ffz(~*p) + (p - start) * sizeof(long) * 8;
+					break;
+				}
+				p++;
 			}
-			if(p->pid > last_pid && next_safe > p->pid)
-				next_safe = p->pid;
-			if(p->pgrp > last_pid && next_safe > p->pgrp)
-				next_safe = p->pgrp;
-			if(p->session > last_pid && next_safe > p->session)
-				next_safe = p->session;
 		}
-		read_unlock(&tasklist_lock);
 	}
-	pid = last_pid;
-	spin_unlock(&lastpid_lock);
+
+	last_pid = pid;
 
 	return pid;
 }
@@ -623,7 +683,10 @@
 	p->state = TASK_UNINTERRUPTIBLE;
 
 	copy_flags(clone_flags, p);
+	down(&getpid_mutex);
 	p->pid = get_pid(clone_flags);
+	if (p->pid < 0) /* valid pids are >= 0 */
+		goto bad_fork_cleanup;
 
 	p->run_list.next = NULL;
 	p->run_list.prev = NULL;
@@ -730,7 +793,17 @@
 		list_add(&p->thread_group, &current->thread_group);
 	}
 
+	/*
+	 * We must do the SET_LINKS() under the getpid_mutex, to avoid
+	 * another CPU to get our same PID between the release of of the
+	 * getpid_mutex and the SET_LINKS().
+	 *
+	 * In short to avoid SMP races the new child->pid must be just visible
+	 * in the tasklist by the time we drop the getpid_mutex.
+	 */
 	SET_LINKS(p);
+	up(&getpid_mutex);
+
 	hash_pid(p);
 	nr_threads++;
 	write_unlock_irq(&tasklist_lock);
@@ -757,6 +830,7 @@
 bad_fork_cleanup_files:
 	exit_files(p); /* blocking */
 bad_fork_cleanup:
+	up(&getpid_mutex);
 	put_exec_domain(p->exec_domain);
 	if (p->binfmt && p->binfmt->module)
 		__MOD_DEC_USE_COUNT(p->binfmt->module);

Andrea
