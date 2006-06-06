Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbWFFI47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWFFI47 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 04:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWFFI47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 04:56:59 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:8411 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750932AbWFFI46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 04:56:58 -0400
Date: Tue, 6 Jun 2006 10:56:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: mbligh@google.com, akpm@osdl.org, apw@shadowen.org,
       linux-kernel@vger.kernel.org
Subject: [patch, -rc5-mm3] better lock debugging: remove mutex deadlock checking code
Message-ID: <20060606085623.GA2932@elte.hu>
References: <44845C27.3000006@google.com> <20060605194422.GB14709@elte.hu> <20060605130039.db1ac80c.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060605130039.db1ac80c.rdunlap@xenotime.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Randy.Dunlap <rdunlap@xenotime.net> wrote:

> BUG: unable to handle kernel paging request at virtual address 22222232

ok, this was a big thinko on my part, and it was right before our eyes. 
Mutex deadlock checking relied on the 'big mutex debugging lock', but 
that one is gone now - so mutex deadlock checking became racy (as your 
crashes nicely pinpointed that). The races are more likely with an 
increasing number of CPUs.

so the patch below finishes the cleanup i started: it removes deadlock 
checking from the mutex code and lets the lock validator do that. This 
should also be (much) faster on SMP, because the lock validator is 
lockless in the fastpath. (if CONFIG_DEBUG_LOCKDEP is disabled)

	Ingo

----------------
Subject: better lock debugging: remove mutex deadlock checking code
From: Ingo Molnar <mingo@elte.hu>

with the lock validator we detect mutex deadlocks (and more), the mutex
deadlock checking code is both redundant and slower. So remove it.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/mutex-debug.c |  126 ---------------------------------------------------
 lib/Kconfig.debug    |    8 ---
 2 files changed, 1 insertion(+), 133 deletions(-)

Index: linux/kernel/mutex-debug.c
===================================================================
--- linux.orig/kernel/mutex-debug.c
+++ linux/kernel/mutex-debug.c
@@ -23,128 +23,6 @@
 
 #include "mutex-debug.h"
 
-static void printk_task(struct task_struct *p)
-{
-	if (p)
-		printk("%16s:%5d [%p, %3d]", p->comm, p->pid, p, p->prio);
-	else
-		printk("<none>");
-}
-
-static void printk_ti(struct thread_info *ti)
-{
-	if (ti)
-		printk_task(ti->task);
-	else
-		printk("<none>");
-}
-
-static void printk_lock(struct mutex *lock, int print_owner)
-{
-#ifdef CONFIG_PROVE_MUTEX_LOCKING
-	printk(" [%p] {%s}\n", lock, lock->dep_map.name);
-#else
-	printk(" [%p]\n", lock);
-#endif
-
-	if (print_owner && lock->owner) {
-		printk(".. held by:  ");
-		printk_ti(lock->owner);
-		printk("\n");
-	}
-}
-
-static void report_deadlock(struct task_struct *task, struct mutex *lock,
-			    struct mutex *lockblk)
-{
-	printk("\n%s/%d is trying to acquire this lock:\n",
-		current->comm, current->pid);
-	printk_lock(lock, 1);
-	debug_show_held_locks(current);
-
-	if (lockblk) {
-		printk("but %s/%d is deadlocking current task %s/%d!\n\n",
-			task->comm, task->pid, current->comm, current->pid);
-		printk("\n%s/%d is blocked on this lock:\n",
-			task->comm, task->pid);
-		printk_lock(lockblk, 1);
-
-		debug_show_held_locks(task);
-
-		printk("\n%s/%d's [blocked] stackdump:\n\n",
-			task->comm, task->pid);
-		show_stack(task, NULL);
-	}
-
-	printk("\n%s/%d's [current] stackdump:\n\n",
-		current->comm, current->pid);
-	dump_stack();
-	debug_show_all_locks();
-	printk("[ turning off deadlock detection. Please report this. ]\n\n");
-	local_irq_disable();
-}
-
-/*
- * Recursively check for mutex deadlocks:
- */
-static int check_deadlock(struct mutex *lock, int depth, struct thread_info *ti)
-{
-	struct mutex *lockblk;
-	struct task_struct *task;
-
-	if (!debug_locks)
-		return 0;
-
-	ti = lock->owner;
-	if (!ti)
-		return 0;
-
-	task = ti->task;
-	/*
-	 * In the PROVE_MUTEX_LOCKING we are tracking all held
-	 * locks already, which allows us to optimize this:
-	 */
-#ifdef CONFIG_PROVE_MUTEX_LOCKING
-	if (!task->lockdep_depth)
-		return 0;
-#endif
-	lockblk = NULL;
-	if (task->blocked_on)
-		lockblk = task->blocked_on->lock;
-
-	/* Self-deadlock: */
-	if (current == task) {
-		debug_locks_off();
-		if (depth)
-			return 1;
-		printk("\n==========================================\n");
-		printk(  "[ BUG: lock recursion deadlock detected! |\n");
-		printk(  "------------------------------------------\n");
-		report_deadlock(task, lock, NULL);
-		return 0;
-	}
-
-	/* Ugh, something corrupted the lock data structure? */
-	if (depth > 20) {
-		debug_locks_off();
-		printk("\n===========================================\n");
-		printk(  "[ BUG: infinite lock dependency detected!? |\n");
-		printk(  "-------------------------------------------\n");
-		report_deadlock(task, lock, lockblk);
-		return 0;
-	}
-
-	/* Recursively check for dependencies: */
-	if (lockblk && check_deadlock(lockblk, depth+1, ti)) {
-		printk("\n============================================\n");
-		printk(  "[ BUG: circular locking deadlock detected! ]\n");
-		printk(  "--------------------------------------------\n");
-		report_deadlock(task, lock, lockblk);
-		return 0;
-	}
-	return 0;
-}
-
 /*
  * Must be called with lock->wait_lock held.
  */
@@ -178,9 +56,7 @@ void debug_mutex_add_waiter(struct mutex
 			    struct thread_info *ti)
 {
 	SMP_DEBUG_WARN_ON(!spin_is_locked(&lock->wait_lock));
-#ifdef CONFIG_DEBUG_MUTEX_DEADLOCKS
-	check_deadlock(lock, 0, ti);
-#endif
+
 	/* Mark the current thread as blocked on the lock: */
 	ti->task->blocked_on = waiter;
 	waiter->lock = lock;
Index: linux/lib/Kconfig.debug
===================================================================
--- linux.orig/lib/Kconfig.debug
+++ linux/lib/Kconfig.debug
@@ -164,14 +164,6 @@ config DEBUG_MUTEX_ALLOC
 	 (kfree(), kmem_cache_free(), free_pages(), vfree(), etc.),
 	 or whether there is any lock held during task exit.
 
-config DEBUG_MUTEX_DEADLOCKS
-	bool "Detect mutex related deadlocks"
-	default y
-	depends on DEBUG_MUTEXES
-	help
-	 This feature will automatically detect and report mutex related
-	 deadlocks, as they happen.
-
 config DEBUG_RT_MUTEXES
 	bool "RT Mutex debugging, deadlock detection"
 	default y
