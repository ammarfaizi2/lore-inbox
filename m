Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318220AbSG3PbI>; Tue, 30 Jul 2002 11:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318285AbSG3PbI>; Tue, 30 Jul 2002 11:31:08 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:2281 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318220AbSG3PbF>;
	Tue, 30 Jul 2002 11:31:05 -0400
Subject: Re: [Lse-tech] [PATCH] Linux-2.5 fix for get_pid() hang
From: Paul Larson <plars@austin.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>, lse-tech@lists.sourceforge.net
In-Reply-To: <20020729202535.GZ1201@dualathlon.random>
References: <1027972670.7699.210.camel@plars.austin.ibm.com> 
	<20020729202535.GZ1201@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 30 Jul 2002 10:31:03 -0500
Message-Id: <1028043063.11135.235.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-29 at 15:25, Andrea Arcangeli wrote:
> On Mon, Jul 29, 2002 at 02:57:46PM -0500, Paul Larson wrote:
> > This is a fix for the problem where get_pid will hang the machine if you
> > request a new pid when all available pids are in use.  This also adds
> > the appropriate checking for p->tgid in get_pid that was somehow
> > overlooked before.  This patch has been in 2.4 since 2.4.19-pre9.
> no please, this below patch is superior and it fixes as well fixes a
> longstanding race condition in fork() (see the semaphore):
> 
> 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc3aa3/10_get_pid-no-deadlock-and-boosted-4
> 
> it may not apply cleanly but porting should be trivial.
Ported this forward to the latest 2.5 bk and ran my forkbomb test from
ltp.  Looks like it fixes the problem.  I running the rest of the tests
from LTP right now as a sanity check but so far everything looks ok.

Thanks,
Paul Larson
Linux Test Project
http://ltp.sourceforge.net

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.536   -> 1.537  
#	include/linux/threads.h	1.2     -> 1.3    
#	       kernel/fork.c	1.56    -> 1.57   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/30	plars@austin.ibm.com	1.537
#  
# --------------------------------------------
#
diff -Nru a/include/linux/threads.h b/include/linux/threads.h
--- a/include/linux/threads.h	Tue Jul 30 11:15:37 2002
+++ b/include/linux/threads.h	Tue Jul 30 11:15:37 2002
@@ -19,6 +19,6 @@
 /*
  * This controls the maximum pid allocated to a process
  */
-#define PID_MAX 0x8000
+#define PID_NR 0x8000
 
 #endif
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Tue Jul 30 11:15:37 2002
+++ b/kernel/fork.c	Tue Jul 30 11:15:37 2002
@@ -50,6 +50,12 @@
 
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
@@ -129,52 +135,106 @@
 	kmem_cache_free(task_struct_cachep,tsk);
 }
 
-/* Protects next_safe and last_pid. */
-spinlock_t lastpid_lock = SPIN_LOCK_UNLOCKED;
-
+/*
+ * Get the next free pid for a new process/thread.
+ *
+ * Strategy:	last_pid and next_unsafe (excluded) are an interval where all 
+ *		pids are free, so next pid is just last_pid + 1 if it's also 
+ *		< next_unsafe.  If last_pid + 1 >= next_unsafe the interval is 
+ *		completely used.  In this case a bitmap with all used 
+ *		pids/tgids/pgrp/seesion is is created. This bitmap is looked 
+ *		for the next free pid and next_unsafe.  If all pids are used, 
+ *		a kernel warning is issued.
+ */
 static int get_pid(unsigned long flags)
 {
-	static int next_safe = PID_MAX;
+	static int next_unsafe = PID_NR;
+#define PID_FIRST	2 /* pid 1 is init, first usable pid is 2 */
+#define PID_BITMAP_SIZE	((((PID_NR + 7) / 8) + sizeof(long) - 1 ) / (sizeof(long)))
+	/*
+	 * Even if this could be local per-thread, keep it static and protected
+	 * by the lock because we don't want to overflow the stack and we
+	 * wouldn't SMP scale better anyways. It doesn't waste disk space 
+	 * because it's in the .bss.
+	 */
+	static unsigned long pid_bitmap[PID_BITMAP_SIZE];
+
+	/* from here the stuff on the stack */
 	struct task_struct *p;
-	int pid;
+	int pid, found_pid;
 
 	if (flags & CLONE_IDLETASK)
 		return 0;
 
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
+		 * Release the tasklist_lock, after the unlock it may happen
+		 * that a pid is freed while it's still marked in use in the 
+		 * pid_bitmap[].
+		 */
+		read_unlock(&tasklist_lock);
+
+		found_pid = find_next_zero_bit(pid_bitmap, PID_NR, pid);
+		if (found_pid >= PID_NR) {
+			next_unsafe = 0; /* depends on PID_FIRST > 0 */
+			found_pid = find_next_zero_bit(pid_bitmap, pid, 
+						       PID_FIRST);
+			/* No free pids were found in the bitmap */
+			if (found_pid >= pid) {
+				static long last_get_pid_warning;
+				if ((unsigned long) (jiffies - last_get_pid_warning) >= HZ) {
+					printk(KERN_NOTICE "No more PIDs (PID_NR = %d)\n", PID_NR);
+					last_get_pid_warning = jiffies;
+ 				}
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
 				}
-				goto repeat;
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
-
+	last_pid = pid;
 	return pid;
 }
 
@@ -671,6 +731,9 @@
 	p->state = TASK_UNINTERRUPTIBLE;
 
 	copy_flags(clone_flags, p);
+	down(&getpid_mutex);
+	if (p->pid < 0) /* valid pids are >= 0 */
+		goto bad_fork_cleanup;
 	p->pid = get_pid(clone_flags);
 	p->proc_dentry = NULL;
 
@@ -799,7 +862,17 @@
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
@@ -839,6 +912,7 @@
 bad_fork_cleanup_security:
 	security_ops->task_free_security(p);
 bad_fork_cleanup:
+	up(&getpid_mutex);
 	put_exec_domain(p->thread_info->exec_domain);
 	if (p->binfmt && p->binfmt->module)
 		__MOD_DEC_USE_COUNT(p->binfmt->module);

