Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275973AbSIVA3Z>; Sat, 21 Sep 2002 20:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275990AbSIVA3Z>; Sat, 21 Sep 2002 20:29:25 -0400
Received: from [195.223.140.120] ([195.223.140.120]:30820 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S275973AbSIVA3W>; Sat, 21 Sep 2002 20:29:22 -0400
Date: Sun, 22 Sep 2002 02:34:48 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Cort Dougan <cort@fsmlabs.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
       Rik van Riel <riel@conectiva.com.br>, Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <20020922003448.GU1345@dualathlon.random>
References: <20020918113551.A654@host110.fsmlabs.com> <343149182.1032346081@[10.10.2.3]> <20020918115710.A656@host110.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020918115710.A656@host110.fsmlabs.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 11:57:10AM -0600, Cort Dougan wrote:
> I'm also a big fan of "Do that crap outside the kernel until it works

Actually I understand that's the whole point of the M:N design and I
assume it's what NGPT does too and they have no way to beat it with 1:1
because entering kernel at that frequency is very expensive compared to
creating and scheduling such an excessive amount of threads in
userspace. By making the kernel more efficient they can get close, which
is a good thing here since all processes are forced to pass through
kernel to fork (only threads can be created and scheduled purerly in
userspace).

Nevertheless the current get_pid is very bad when the tasklist grows and
the pid space is reduced, we fixed it for 2.4 so that it is reduced by
an order of magnitude (still quadratic, but over a array of bitflags
cached by the l1/l2 cache, not a while walk of the tasklist over the
whole pid space, and cache effect generates an aggressive anti-quardatic
behaviour that can be seen very well in practice and infact it *totally*
fixes the out-of-pid lockup, with something of the order of 32k pid, I
would expect it to scale fine to 100k pids, it also depends on the size
of the cpu caches. The fixed algorithm costs only an additional array of
4k with PID_NR set to 32k which is probably ok for embedded too these
days.  With a smaller PID_NR the array shrinks, with 100k pid it would
need around 12k that would certainly fit in l2 cache still (if not in l1
dcache, btw, the 12k are physically contigous so they're guaranteed to
be in different cache colors). Infact because of these significant cache
effects (that guarantees each l1 cacheline will serve 512 pid elements)
it may be as fast as a more complex data structure that sits on
different cachelines and that must be modified at every task creation.
It may not be the best for a 1million pid case, but certainly it is a
must have for 2.4 and I think it could be ok for 2.5 too. It is been
submitted for 2.5 a number of times, I quote below the 2.4 version just
so you know what I'm talking about exactly (it also fixes a race
condition where two tasks can get the same pid, present in mainline 2.4
and 2.2 too, somebody complained the fix with the semaphore, I wanted to
keep it simple and mathematically safe, looking at the fork/execve
number comparison between my tree and the other trees out there
certainly it isn't measurable)

diff -urNp get-pid-ref/include/linux/threads.h get-pid/include/linux/threads.h
--- get-pid-ref/include/linux/threads.h	Fri May  3 20:23:55 2002
+++ get-pid/include/linux/threads.h	Wed May 29 04:48:19 2002
@@ -19,6 +19,6 @@
 /*
  * This controls the maximum pid allocated to a process
  */
-#define PID_MAX 0x8000
+#define PID_NR 0x8000
 
 #endif
diff -urNp get-pid-ref/kernel/fork.c get-pid/kernel/fork.c
--- get-pid-ref/kernel/fork.c	Wed May 29 04:47:54 2002
+++ get-pid/kernel/fork.c	Wed May 29 04:48:38 2002
@@ -21,7 +21,6 @@
 #include <linux/completion.h>
 #include <linux/namespace.h>
 #include <linux/personality.h>
-#include <linux/compiler.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -39,6 +38,12 @@ struct task_struct *pidhash[PIDHASH_SZ];
 
 rwlock_t tasklist_lock __cacheline_aligned = RW_LOCK_UNLOCKED;  /* outer */
 
+/*
+ * Protectes next_unsafe, last_pid and it avoids races
+ * between get_pid and SET_LINKS().
+ */
+static DECLARE_MUTEX(getpid_mutex);
+
 void add_wait_queue(wait_queue_head_t *q, wait_queue_t * wait)
 {
 	unsigned long flags;
@@ -81,63 +86,107 @@ void __init fork_init(unsigned long memp
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
-	int pid, beginpid;
+	int pid, found_pid;
 
 	if (flags & CLONE_PID)
 		return current->pid;
 
-	spin_lock(&lastpid_lock);
-	beginpid = last_pid;
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
+			__set_bit(p->pid, pid_bitmap);
+			__set_bit(p->pgrp, pid_bitmap);
+			__set_bit(p->tgid, pid_bitmap);
+			__set_bit(p->session, pid_bitmap);
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
-				if(unlikely(last_pid == beginpid))
-					goto nomorepids;
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
-			if(p->tgid > last_pid && next_safe > p->tgid)
-				next_safe = p->tgid;
-			if(p->session > last_pid && next_safe > p->session)
-				next_safe = p->session;
 		}
-		read_unlock(&tasklist_lock);
 	}
-	pid = last_pid;
-	spin_unlock(&lastpid_lock);
 
-	return pid;
+	last_pid = pid;
 
-nomorepids:
-	read_unlock(&tasklist_lock);
-	spin_unlock(&lastpid_lock);
-	return 0;
+	return pid;
 }
 
 static inline int dup_mmap(struct mm_struct * mm)
@@ -637,8 +686,9 @@ int do_fork(unsigned long clone_flags, u
 	p->state = TASK_UNINTERRUPTIBLE;
 
 	copy_flags(clone_flags, p);
+	down(&getpid_mutex);
 	p->pid = get_pid(clone_flags);
-	if (p->pid == 0 && current->pid != 0)
+	if (p->pid < 0) /* valid pids are >= 0 */
 		goto bad_fork_cleanup;
 
 	INIT_LIST_HEAD(&p->run_list);
@@ -758,7 +808,17 @@ int do_fork(unsigned long clone_flags, u
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
@@ -790,6 +850,7 @@ bad_fork_cleanup_fs:
 bad_fork_cleanup_files:
 	exit_files(p); /* blocking */
 bad_fork_cleanup:
+	up(&getpid_mutex);
 	put_exec_domain(p->exec_domain);
 	if (p->binfmt && p->binfmt->module)
 		__MOD_DEC_USE_COUNT(p->binfmt->module);

Andrea
