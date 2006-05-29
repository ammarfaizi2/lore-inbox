Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWE2VXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWE2VXd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWE2VXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:23:32 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:184 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751323AbWE2VX0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:23:26 -0400
Date: Mon, 29 May 2006 23:23:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 07/61] lock validator: better lock debugging
Message-ID: <20060529212337.GG3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

generic lock debugging:

 - generalized lock debugging framework. For example, a bug in one lock
   subsystem turns off debugging in all lock subsystems.

 - got rid of the caller address passing from the mutex/rtmutex debugging
   code: it caused way too much prototype hackery, and lockdep will give
   the same information anyway.

 - ability to do silent tests

 - check lock freeing in vfree too.

 - more finegrained debugging options, to allow distributions to
   turn off more expensive debugging features.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/char/sysrq.c             |    2 
 include/asm-generic/mutex-null.h |   11 -
 include/linux/debug_locks.h      |   62 ++++++++
 include/linux/init_task.h        |    1 
 include/linux/mm.h               |    8 -
 include/linux/mutex-debug.h      |   12 -
 include/linux/mutex.h            |    6 
 include/linux/rtmutex.h          |   10 -
 include/linux/sched.h            |    4 
 init/main.c                      |    9 +
 kernel/exit.c                    |    5 
 kernel/fork.c                    |    4 
 kernel/mutex-debug.c             |  289 +++----------------------------------
 kernel/mutex-debug.h             |   87 +----------
 kernel/mutex.c                   |   83 +++++++---
 kernel/mutex.h                   |   18 --
 kernel/rtmutex-debug.c           |  302 +--------------------------------------
 kernel/rtmutex-debug.h           |    8 -
 kernel/rtmutex.c                 |   45 ++---
 kernel/rtmutex.h                 |    3 
 kernel/sched.c                   |   16 +-
 lib/Kconfig.debug                |   26 ++-
 lib/Makefile                     |    2 
 lib/debug_locks.c                |   45 +++++
 lib/spinlock_debug.c             |   60 +++----
 mm/vmalloc.c                     |    2 
 26 files changed, 329 insertions(+), 791 deletions(-)

Index: linux/drivers/char/sysrq.c
===================================================================
--- linux.orig/drivers/char/sysrq.c
+++ linux/drivers/char/sysrq.c
@@ -152,7 +152,7 @@ static struct sysrq_key_op sysrq_mountro
 static void sysrq_handle_showlocks(int key, struct pt_regs *pt_regs,
 				struct tty_struct *tty)
 {
-	mutex_debug_show_all_locks();
+	debug_show_all_locks();
 }
 static struct sysrq_key_op sysrq_showlocks_op = {
 	.handler	= sysrq_handle_showlocks,
Index: linux/include/asm-generic/mutex-null.h
===================================================================
--- linux.orig/include/asm-generic/mutex-null.h
+++ linux/include/asm-generic/mutex-null.h
@@ -10,14 +10,9 @@
 #ifndef _ASM_GENERIC_MUTEX_NULL_H
 #define _ASM_GENERIC_MUTEX_NULL_H
 
-/* extra parameter only needed for mutex debugging: */
-#ifndef __IP__
-# define __IP__
-#endif
-
-#define __mutex_fastpath_lock(count, fail_fn)	      fail_fn(count __RET_IP__)
-#define __mutex_fastpath_lock_retval(count, fail_fn)  fail_fn(count __RET_IP__)
-#define __mutex_fastpath_unlock(count, fail_fn)       fail_fn(count __RET_IP__)
+#define __mutex_fastpath_lock(count, fail_fn)	      fail_fn(count)
+#define __mutex_fastpath_lock_retval(count, fail_fn)  fail_fn(count)
+#define __mutex_fastpath_unlock(count, fail_fn)       fail_fn(count)
 #define __mutex_fastpath_trylock(count, fail_fn)      fail_fn(count)
 #define __mutex_slowpath_needs_to_unlock()	      1
 
Index: linux/include/linux/debug_locks.h
===================================================================
--- /dev/null
+++ linux/include/linux/debug_locks.h
@@ -0,0 +1,62 @@
+#ifndef __LINUX_DEBUG_LOCKING_H
+#define __LINUX_DEBUG_LOCKING_H
+
+extern int debug_locks;
+extern int debug_locks_silent;
+
+/*
+ * Generic 'turn off all lock debugging' function:
+ */
+extern int debug_locks_off(void);
+
+/*
+ * In the debug case we carry the caller's instruction pointer into
+ * other functions, but we dont want the function argument overhead
+ * in the nondebug case - hence these macros:
+ */
+#define _RET_IP_		(unsigned long)__builtin_return_address(0)
+#define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
+
+#define DEBUG_WARN_ON(c)						\
+({									\
+	int __ret = 0;							\
+									\
+	if (unlikely(c)) {						\
+		if (debug_locks_off())					\
+			WARN_ON(1);					\
+		__ret = 1;						\
+	}								\
+	__ret;								\
+})
+
+#ifdef CONFIG_SMP
+# define SMP_DEBUG_WARN_ON(c)			DEBUG_WARN_ON(c)
+#else
+# define SMP_DEBUG_WARN_ON(c)			do { } while (0)
+#endif
+
+#ifdef CONFIG_DEBUG_LOCKING_API_SELFTESTS
+  extern void locking_selftest(void);
+#else
+# define locking_selftest()	do { } while (0)
+#endif
+
+static inline void
+debug_check_no_locks_freed(const void *from, unsigned long len)
+{
+}
+
+static inline void
+debug_check_no_locks_held(struct task_struct *task)
+{
+}
+
+static inline void debug_show_all_locks(void)
+{
+}
+
+static inline void debug_show_held_locks(struct task_struct *task)
+{
+}
+
+#endif
Index: linux/include/linux/init_task.h
===================================================================
--- linux.orig/include/linux/init_task.h
+++ linux/include/linux/init_task.h
@@ -133,7 +133,6 @@ extern struct group_info init_groups;
 	.journal_info	= NULL,						\
 	.cpu_timers	= INIT_CPU_TIMERS(tsk.cpu_timers),		\
 	.fs_excl	= ATOMIC_INIT(0),				\
-	INIT_RT_MUTEXES(tsk)						\
 }
 
 
Index: linux/include/linux/mm.h
===================================================================
--- linux.orig/include/linux/mm.h
+++ linux/include/linux/mm.h
@@ -14,6 +14,7 @@
 #include <linux/prio_tree.h>
 #include <linux/fs.h>
 #include <linux/mutex.h>
+#include <linux/debug_locks.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -1080,13 +1081,6 @@ static inline void vm_stat_account(struc
 }
 #endif /* CONFIG_PROC_FS */
 
-static inline void
-debug_check_no_locks_freed(const void *from, unsigned long len)
-{
-	mutex_debug_check_no_locks_freed(from, len);
-	rt_mutex_debug_check_no_locks_freed(from, len);
-}
-
 #ifndef CONFIG_DEBUG_PAGEALLOC
 static inline void
 kernel_map_pages(struct page *page, int numpages, int enable)
Index: linux/include/linux/mutex-debug.h
===================================================================
--- linux.orig/include/linux/mutex-debug.h
+++ linux/include/linux/mutex-debug.h
@@ -7,17 +7,11 @@
  * Mutexes - debugging helpers:
  */
 
-#define __DEBUG_MUTEX_INITIALIZER(lockname) \
-	, .held_list = LIST_HEAD_INIT(lockname.held_list), \
-	  .name = #lockname , .magic = &lockname
+#define __DEBUG_MUTEX_INITIALIZER(lockname)				\
+	, .magic = &lockname
 
-#define mutex_init(sem)		__mutex_init(sem, __FUNCTION__)
+#define mutex_init(sem)		__mutex_init(sem, __FILE__":"#sem)
 
 extern void FASTCALL(mutex_destroy(struct mutex *lock));
 
-extern void mutex_debug_show_all_locks(void);
-extern void mutex_debug_show_held_locks(struct task_struct *filter);
-extern void mutex_debug_check_no_locks_held(struct task_struct *task);
-extern void mutex_debug_check_no_locks_freed(const void *from, unsigned long len);
-
 #endif
Index: linux/include/linux/mutex.h
===================================================================
--- linux.orig/include/linux/mutex.h
+++ linux/include/linux/mutex.h
@@ -50,8 +50,6 @@ struct mutex {
 	struct list_head	wait_list;
 #ifdef CONFIG_DEBUG_MUTEXES
 	struct thread_info	*owner;
-	struct list_head	held_list;
-	unsigned long		acquire_ip;
 	const char 		*name;
 	void			*magic;
 #endif
@@ -76,10 +74,6 @@ struct mutex_waiter {
 # define __DEBUG_MUTEX_INITIALIZER(lockname)
 # define mutex_init(mutex)			__mutex_init(mutex, NULL)
 # define mutex_destroy(mutex)				do { } while (0)
-# define mutex_debug_show_all_locks()			do { } while (0)
-# define mutex_debug_show_held_locks(p)			do { } while (0)
-# define mutex_debug_check_no_locks_held(task)		do { } while (0)
-# define mutex_debug_check_no_locks_freed(from, len)	do { } while (0)
 #endif
 
 #define __MUTEX_INITIALIZER(lockname) \
Index: linux/include/linux/rtmutex.h
===================================================================
--- linux.orig/include/linux/rtmutex.h
+++ linux/include/linux/rtmutex.h
@@ -29,8 +29,6 @@ struct rt_mutex {
 	struct task_struct	*owner;
 #ifdef CONFIG_DEBUG_RT_MUTEXES
 	int			save_state;
-	struct list_head	held_list_entry;
-	unsigned long		acquire_ip;
 	const char 		*name, *file;
 	int			line;
 	void			*magic;
@@ -98,14 +96,6 @@ extern int rt_mutex_trylock(struct rt_mu
 
 extern void rt_mutex_unlock(struct rt_mutex *lock);
 
-#ifdef CONFIG_DEBUG_RT_MUTEXES
-# define INIT_RT_MUTEX_DEBUG(tsk)					\
-	.held_list_head	= LIST_HEAD_INIT(tsk.held_list_head),		\
-	.held_list_lock	= SPIN_LOCK_UNLOCKED
-#else
-# define INIT_RT_MUTEX_DEBUG(tsk)
-#endif
-
 #ifdef CONFIG_RT_MUTEXES
 # define INIT_RT_MUTEXES(tsk)						\
 	.pi_waiters	= PLIST_HEAD_INIT(tsk.pi_waiters, tsk.pi_lock),	\
Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h
+++ linux/include/linux/sched.h
@@ -910,10 +910,6 @@ struct task_struct {
 	struct plist_head pi_waiters;
 	/* Deadlock detection and priority inheritance handling */
 	struct rt_mutex_waiter *pi_blocked_on;
-# ifdef CONFIG_DEBUG_RT_MUTEXES
-	spinlock_t held_list_lock;
-	struct list_head held_list_head;
-# endif
 #endif
 
 #ifdef CONFIG_DEBUG_MUTEXES
Index: linux/init/main.c
===================================================================
--- linux.orig/init/main.c
+++ linux/init/main.c
@@ -53,6 +53,7 @@
 #include <linux/key.h>
 #include <linux/root_dev.h>
 #include <linux/buffer_head.h>
+#include <linux/debug_locks.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -512,6 +513,14 @@ asmlinkage void __init start_kernel(void
 		panic(panic_later, panic_param);
 	profile_init();
 	local_irq_enable();
+
+	/*
+	 * Need to run this when irqs are enabled, because it wants
+	 * to self-test [hard/soft]-irqs on/off lock inversion bugs
+	 * too:
+	 */
+	locking_selftest();
+
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start && !initrd_below_start_ok &&
 			initrd_start < min_low_pfn << PAGE_SHIFT) {
Index: linux/kernel/exit.c
===================================================================
--- linux.orig/kernel/exit.c
+++ linux/kernel/exit.c
@@ -952,10 +952,9 @@ fastcall NORET_TYPE void do_exit(long co
 	if (unlikely(current->pi_state_cache))
 		kfree(current->pi_state_cache);
 	/*
-	 * If DEBUG_MUTEXES is on, make sure we are holding no locks:
+	 * Make sure we are holding no locks:
 	 */
-	mutex_debug_check_no_locks_held(tsk);
-	rt_mutex_debug_check_no_locks_held(tsk);
+	debug_check_no_locks_held(tsk);
 
 	if (tsk->io_context)
 		exit_io_context();
Index: linux/kernel/fork.c
===================================================================
--- linux.orig/kernel/fork.c
+++ linux/kernel/fork.c
@@ -921,10 +921,6 @@ static inline void rt_mutex_init_task(st
 	spin_lock_init(&p->pi_lock);
 	plist_head_init(&p->pi_waiters, &p->pi_lock);
 	p->pi_blocked_on = NULL;
-# ifdef CONFIG_DEBUG_RT_MUTEXES
-	spin_lock_init(&p->held_list_lock);
-	INIT_LIST_HEAD(&p->held_list_head);
-# endif
 #endif
 }
 
Index: linux/kernel/mutex-debug.c
===================================================================
--- linux.orig/kernel/mutex-debug.c
+++ linux/kernel/mutex-debug.c
@@ -19,37 +19,10 @@
 #include <linux/spinlock.h>
 #include <linux/kallsyms.h>
 #include <linux/interrupt.h>
+#include <linux/debug_locks.h>
 
 #include "mutex-debug.h"
 
-/*
- * We need a global lock when we walk through the multi-process
- * lock tree. Only used in the deadlock-debugging case.
- */
-DEFINE_SPINLOCK(debug_mutex_lock);
-
-/*
- * All locks held by all tasks, in a single global list:
- */
-LIST_HEAD(debug_mutex_held_locks);
-
-/*
- * In the debug case we carry the caller's instruction pointer into
- * other functions, but we dont want the function argument overhead
- * in the nondebug case - hence these macros:
- */
-#define __IP_DECL__		, unsigned long ip
-#define __IP__			, ip
-#define __RET_IP__		, (unsigned long)__builtin_return_address(0)
-
-/*
- * "mutex debugging enabled" flag. We turn it off when we detect
- * the first problem because we dont want to recurse back
- * into the tracing code when doing error printk or
- * executing a BUG():
- */
-int debug_mutex_on = 1;
-
 static void printk_task(struct task_struct *p)
 {
 	if (p)
@@ -66,157 +39,28 @@ static void printk_ti(struct thread_info
 		printk("<none>");
 }
 
-static void printk_task_short(struct task_struct *p)
-{
-	if (p)
-		printk("%s/%d [%p, %3d]", p->comm, p->pid, p, p->prio);
-	else
-		printk("<none>");
-}
-
 static void printk_lock(struct mutex *lock, int print_owner)
 {
-	printk(" [%p] {%s}\n", lock, lock->name);
+#ifdef CONFIG_PROVE_MUTEX_LOCKING
+	printk(" [%p] {%s}\n", lock, lock->dep_map.name);
+#else
+	printk(" [%p]\n", lock);
+#endif
 
 	if (print_owner && lock->owner) {
 		printk(".. held by:  ");
 		printk_ti(lock->owner);
 		printk("\n");
 	}
-	if (lock->owner) {
-		printk("... acquired at:               ");
-		print_symbol("%s\n", lock->acquire_ip);
-	}
-}
-
-/*
- * printk locks held by a task:
- */
-static void show_task_locks(struct task_struct *p)
-{
-	switch (p->state) {
-	case TASK_RUNNING:		printk("R"); break;
-	case TASK_INTERRUPTIBLE:	printk("S"); break;
-	case TASK_UNINTERRUPTIBLE:	printk("D"); break;
-	case TASK_STOPPED:		printk("T"); break;
-	case EXIT_ZOMBIE:		printk("Z"); break;
-	case EXIT_DEAD:			printk("X"); break;
-	default:			printk("?"); break;
-	}
-	printk_task(p);
-	if (p->blocked_on) {
-		struct mutex *lock = p->blocked_on->lock;
-
-		printk(" blocked on mutex:");
-		printk_lock(lock, 1);
-	} else
-		printk(" (not blocked on mutex)\n");
-}
-
-/*
- * printk all locks held in the system (if filter == NULL),
- * or all locks belonging to a single task (if filter != NULL):
- */
-void show_held_locks(struct task_struct *filter)
-{
-	struct list_head *curr, *cursor = NULL;
-	struct mutex *lock;
-	struct thread_info *t;
-	unsigned long flags;
-	int count = 0;
-
-	if (filter) {
-		printk("------------------------------\n");
-		printk("| showing all locks held by: |  (");
-		printk_task_short(filter);
-		printk("):\n");
-		printk("------------------------------\n");
-	} else {
-		printk("---------------------------\n");
-		printk("| showing all locks held: |\n");
-		printk("---------------------------\n");
-	}
-
-	/*
-	 * Play safe and acquire the global trace lock. We
-	 * cannot printk with that lock held so we iterate
-	 * very carefully:
-	 */
-next:
-	debug_spin_lock_save(&debug_mutex_lock, flags);
-	list_for_each(curr, &debug_mutex_held_locks) {
-		if (cursor && curr != cursor)
-			continue;
-		lock = list_entry(curr, struct mutex, held_list);
-		t = lock->owner;
-		if (filter && (t != filter->thread_info))
-			continue;
-		count++;
-		cursor = curr->next;
-		debug_spin_unlock_restore(&debug_mutex_lock, flags);
-
-		printk("\n#%03d:            ", count);
-		printk_lock(lock, filter ? 0 : 1);
-		goto next;
-	}
-	debug_spin_unlock_restore(&debug_mutex_lock, flags);
-	printk("\n");
-}
-
-void mutex_debug_show_all_locks(void)
-{
-	struct task_struct *g, *p;
-	int count = 10;
-	int unlock = 1;
-
-	printk("\nShowing all blocking locks in the system:\n");
-
-	/*
-	 * Here we try to get the tasklist_lock as hard as possible,
-	 * if not successful after 2 seconds we ignore it (but keep
-	 * trying). This is to enable a debug printout even if a
-	 * tasklist_lock-holding task deadlocks or crashes.
-	 */
-retry:
-	if (!read_trylock(&tasklist_lock)) {
-		if (count == 10)
-			printk("hm, tasklist_lock locked, retrying... ");
-		if (count) {
-			count--;
-			printk(" #%d", 10-count);
-			mdelay(200);
-			goto retry;
-		}
-		printk(" ignoring it.\n");
-		unlock = 0;
-	}
-	if (count != 10)
-		printk(" locked it.\n");
-
-	do_each_thread(g, p) {
-		show_task_locks(p);
-		if (!unlock)
-			if (read_trylock(&tasklist_lock))
-				unlock = 1;
-	} while_each_thread(g, p);
-
-	printk("\n");
-	show_held_locks(NULL);
-	printk("=============================================\n\n");
-
-	if (unlock)
-		read_unlock(&tasklist_lock);
 }
 
 static void report_deadlock(struct task_struct *task, struct mutex *lock,
-			    struct mutex *lockblk, unsigned long ip)
+			    struct mutex *lockblk)
 {
 	printk("\n%s/%d is trying to acquire this lock:\n",
 		current->comm, current->pid);
 	printk_lock(lock, 1);
-	printk("... trying at:                 ");
-	print_symbol("%s\n", ip);
-	show_held_locks(current);
+	debug_show_held_locks(current);
 
 	if (lockblk) {
 		printk("but %s/%d is deadlocking current task %s/%d!\n\n",
@@ -225,7 +69,7 @@ static void report_deadlock(struct task_
 			task->comm, task->pid);
 		printk_lock(lockblk, 1);
 
-		show_held_locks(task);
+		debug_show_held_locks(task);
 
 		printk("\n%s/%d's [blocked] stackdump:\n\n",
 			task->comm, task->pid);
@@ -235,7 +79,7 @@ static void report_deadlock(struct task_
 	printk("\n%s/%d's [current] stackdump:\n\n",
 		current->comm, current->pid);
 	dump_stack();
-	mutex_debug_show_all_locks();
+	debug_show_all_locks();
 	printk("[ turning off deadlock detection. Please report this. ]\n\n");
 	local_irq_disable();
 }
@@ -243,13 +87,12 @@ static void report_deadlock(struct task_
 /*
  * Recursively check for mutex deadlocks:
  */
-static int check_deadlock(struct mutex *lock, int depth,
-			  struct thread_info *ti, unsigned long ip)
+static int check_deadlock(struct mutex *lock, int depth, struct thread_info *ti)
 {
 	struct mutex *lockblk;
 	struct task_struct *task;
 
-	if (!debug_mutex_on)
+	if (!debug_locks)
 		return 0;
 
 	ti = lock->owner;
@@ -263,123 +106,46 @@ static int check_deadlock(struct mutex *
 
 	/* Self-deadlock: */
 	if (current == task) {
-		DEBUG_OFF();
+		debug_locks_off();
 		if (depth)
 			return 1;
 		printk("\n==========================================\n");
 		printk(  "[ BUG: lock recursion deadlock detected! |\n");
 		printk(  "------------------------------------------\n");
-		report_deadlock(task, lock, NULL, ip);
+		report_deadlock(task, lock, NULL);
 		return 0;
 	}
 
 	/* Ugh, something corrupted the lock data structure? */
 	if (depth > 20) {
-		DEBUG_OFF();
+		debug_locks_off();
 		printk("\n===========================================\n");
 		printk(  "[ BUG: infinite lock dependency detected!? |\n");
 		printk(  "-------------------------------------------\n");
-		report_deadlock(task, lock, lockblk, ip);
+		report_deadlock(task, lock, lockblk);
 		return 0;
 	}
 
 	/* Recursively check for dependencies: */
-	if (lockblk && check_deadlock(lockblk, depth+1, ti, ip)) {
+	if (lockblk && check_deadlock(lockblk, depth+1, ti)) {
 		printk("\n============================================\n");
 		printk(  "[ BUG: circular locking deadlock detected! ]\n");
 		printk(  "--------------------------------------------\n");
-		report_deadlock(task, lock, lockblk, ip);
+		report_deadlock(task, lock, lockblk);
 		return 0;
 	}
 	return 0;
 }
 
 /*
- * Called when a task exits, this function checks whether the
- * task is holding any locks, and reports the first one if so:
- */
-void mutex_debug_check_no_locks_held(struct task_struct *task)
-{
-	struct list_head *curr, *next;
-	struct thread_info *t;
-	unsigned long flags;
-	struct mutex *lock;
-
-	if (!debug_mutex_on)
-		return;
-
-	debug_spin_lock_save(&debug_mutex_lock, flags);
-	list_for_each_safe(curr, next, &debug_mutex_held_locks) {
-		lock = list_entry(curr, struct mutex, held_list);
-		t = lock->owner;
-		if (t != task->thread_info)
-			continue;
-		list_del_init(curr);
-		DEBUG_OFF();
-		debug_spin_unlock_restore(&debug_mutex_lock, flags);
-
-		printk("BUG: %s/%d, lock held at task exit time!\n",
-			task->comm, task->pid);
-		printk_lock(lock, 1);
-		if (lock->owner != task->thread_info)
-			printk("exiting task is not even the owner??\n");
-		return;
-	}
-	debug_spin_unlock_restore(&debug_mutex_lock, flags);
-}
-
-/*
- * Called when kernel memory is freed (or unmapped), or if a mutex
- * is destroyed or reinitialized - this code checks whether there is
- * any held lock in the memory range of <from> to <to>:
- */
-void mutex_debug_check_no_locks_freed(const void *from, unsigned long len)
-{
-	struct list_head *curr, *next;
-	const void *to = from + len;
-	unsigned long flags;
-	struct mutex *lock;
-	void *lock_addr;
-
-	if (!debug_mutex_on)
-		return;
-
-	debug_spin_lock_save(&debug_mutex_lock, flags);
-	list_for_each_safe(curr, next, &debug_mutex_held_locks) {
-		lock = list_entry(curr, struct mutex, held_list);
-		lock_addr = lock;
-		if (lock_addr < from || lock_addr >= to)
-			continue;
-		list_del_init(curr);
-		DEBUG_OFF();
-		debug_spin_unlock_restore(&debug_mutex_lock, flags);
-
-		printk("BUG: %s/%d, active lock [%p(%p-%p)] freed!\n",
-			current->comm, current->pid, lock, from, to);
-		dump_stack();
-		printk_lock(lock, 1);
-		if (lock->owner != current_thread_info())
-			printk("freeing task is not even the owner??\n");
-		return;
-	}
-	debug_spin_unlock_restore(&debug_mutex_lock, flags);
-}
-
-/*
  * Must be called with lock->wait_lock held.
  */
-void debug_mutex_set_owner(struct mutex *lock,
-			   struct thread_info *new_owner __IP_DECL__)
+void debug_mutex_set_owner(struct mutex *lock, struct thread_info *new_owner)
 {
 	lock->owner = new_owner;
-	DEBUG_WARN_ON(!list_empty(&lock->held_list));
-	if (debug_mutex_on) {
-		list_add_tail(&lock->held_list, &debug_mutex_held_locks);
-		lock->acquire_ip = ip;
-	}
 }
 
-void debug_mutex_init_waiter(struct mutex_waiter *waiter)
+void debug_mutex_lock_common(struct mutex *lock, struct mutex_waiter *waiter)
 {
 	memset(waiter, 0x11, sizeof(*waiter));
 	waiter->magic = waiter;
@@ -401,10 +167,12 @@ void debug_mutex_free_waiter(struct mute
 }
 
 void debug_mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
-			    struct thread_info *ti __IP_DECL__)
+			    struct thread_info *ti)
 {
 	SMP_DEBUG_WARN_ON(!spin_is_locked(&lock->wait_lock));
-	check_deadlock(lock, 0, ti, ip);
+#ifdef CONFIG_DEBUG_MUTEX_DEADLOCKS
+	check_deadlock(lock, 0, ti);
+#endif
 	/* Mark the current thread as blocked on the lock: */
 	ti->task->blocked_on = waiter;
 	waiter->lock = lock;
@@ -424,13 +192,10 @@ void mutex_remove_waiter(struct mutex *l
 
 void debug_mutex_unlock(struct mutex *lock)
 {
+	DEBUG_WARN_ON(lock->owner != current_thread_info());
 	DEBUG_WARN_ON(lock->magic != lock);
 	DEBUG_WARN_ON(!lock->wait_list.prev && !lock->wait_list.next);
 	DEBUG_WARN_ON(lock->owner != current_thread_info());
-	if (debug_mutex_on) {
-		DEBUG_WARN_ON(list_empty(&lock->held_list));
-		list_del_init(&lock->held_list);
-	}
 }
 
 void debug_mutex_init(struct mutex *lock, const char *name)
@@ -438,10 +203,8 @@ void debug_mutex_init(struct mutex *lock
 	/*
 	 * Make sure we are not reinitializing a held lock:
 	 */
-	mutex_debug_check_no_locks_freed((void *)lock, sizeof(*lock));
+	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
 	lock->owner = NULL;
-	INIT_LIST_HEAD(&lock->held_list);
-	lock->name = name;
 	lock->magic = lock;
 }
 
Index: linux/kernel/mutex-debug.h
===================================================================
--- linux.orig/kernel/mutex-debug.h
+++ linux/kernel/mutex-debug.h
@@ -10,110 +10,43 @@
  * More details are in kernel/mutex-debug.c.
  */
 
-extern spinlock_t debug_mutex_lock;
-extern struct list_head debug_mutex_held_locks;
-extern int debug_mutex_on;
-
-/*
- * In the debug case we carry the caller's instruction pointer into
- * other functions, but we dont want the function argument overhead
- * in the nondebug case - hence these macros:
- */
-#define __IP_DECL__		, unsigned long ip
-#define __IP__			, ip
-#define __RET_IP__		, (unsigned long)__builtin_return_address(0)
-
 /*
  * This must be called with lock->wait_lock held.
  */
-extern void debug_mutex_set_owner(struct mutex *lock,
-				  struct thread_info *new_owner __IP_DECL__);
+extern void
+debug_mutex_set_owner(struct mutex *lock, struct thread_info *new_owner);
 
 static inline void debug_mutex_clear_owner(struct mutex *lock)
 {
 	lock->owner = NULL;
 }
 
-extern void debug_mutex_init_waiter(struct mutex_waiter *waiter);
+extern void debug_mutex_lock_common(struct mutex *lock,
+				    struct mutex_waiter *waiter);
 extern void debug_mutex_wake_waiter(struct mutex *lock,
 				    struct mutex_waiter *waiter);
 extern void debug_mutex_free_waiter(struct mutex_waiter *waiter);
 extern void debug_mutex_add_waiter(struct mutex *lock,
 				   struct mutex_waiter *waiter,
-				   struct thread_info *ti __IP_DECL__);
+				   struct thread_info *ti);
 extern void mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 				struct thread_info *ti);
 extern void debug_mutex_unlock(struct mutex *lock);
 extern void debug_mutex_init(struct mutex *lock, const char *name);
 
-#define debug_spin_lock_save(lock, flags)		\
-	do {						\
-		local_irq_save(flags);			\
-		if (debug_mutex_on)			\
-			spin_lock(lock);		\
-	} while (0)
-
-#define debug_spin_unlock_restore(lock, flags)		\
-	do {						\
-		if (debug_mutex_on)			\
-			spin_unlock(lock);		\
-		local_irq_restore(flags);		\
-		preempt_check_resched();		\
-	} while (0)
-
 #define spin_lock_mutex(lock, flags)			\
 	do {						\
 		struct mutex *l = container_of(lock, struct mutex, wait_lock); \
 							\
 		DEBUG_WARN_ON(in_interrupt());		\
-		debug_spin_lock_save(&debug_mutex_lock, flags); \
-		spin_lock(lock);			\
+		local_irq_save(flags);			\
+		__raw_spin_lock(&(lock)->raw_lock);	\
 		DEBUG_WARN_ON(l->magic != l);		\
 	} while (0)
 
 #define spin_unlock_mutex(lock, flags)			\
 	do {						\
-		spin_unlock(lock);			\
-		debug_spin_unlock_restore(&debug_mutex_lock, flags);	\
+		__raw_spin_unlock(&(lock)->raw_lock);	\
+		local_irq_restore(flags);		\
+		preempt_check_resched();		\
 	} while (0)
-
-#define DEBUG_OFF()					\
-do {							\
-	if (debug_mutex_on) {				\
-		debug_mutex_on = 0;			\
-		console_verbose();			\
-		if (spin_is_locked(&debug_mutex_lock))	\
-			spin_unlock(&debug_mutex_lock);	\
-	}						\
-} while (0)
-
-#define DEBUG_BUG()					\
-do {							\
-	if (debug_mutex_on) {				\
-		DEBUG_OFF();				\
-		BUG();					\
-	}						\
-} while (0)
-
-#define DEBUG_WARN_ON(c)				\
-do {							\
-	if (unlikely(c && debug_mutex_on)) {		\
-		DEBUG_OFF();				\
-		WARN_ON(1);				\
-	}						\
-} while (0)
-
-# define DEBUG_BUG_ON(c)				\
-do {							\
-	if (unlikely(c))				\
-		DEBUG_BUG();				\
-} while (0)
-
-#ifdef CONFIG_SMP
-# define SMP_DEBUG_WARN_ON(c)			DEBUG_WARN_ON(c)
-# define SMP_DEBUG_BUG_ON(c)			DEBUG_BUG_ON(c)
-#else
-# define SMP_DEBUG_WARN_ON(c)			do { } while (0)
-# define SMP_DEBUG_BUG_ON(c)			do { } while (0)
-#endif
-
Index: linux/kernel/mutex.c
===================================================================
--- linux.orig/kernel/mutex.c
+++ linux/kernel/mutex.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
+#include <linux/debug_locks.h>
 
 /*
  * In the DEBUG case we are using the "NULL fastpath" for mutexes,
@@ -38,7 +39,7 @@
  *
  * It is not allowed to initialize an already locked mutex.
  */
-void fastcall __mutex_init(struct mutex *lock, const char *name)
+__always_inline void fastcall __mutex_init(struct mutex *lock, const char *name)
 {
 	atomic_set(&lock->count, 1);
 	spin_lock_init(&lock->wait_lock);
@@ -56,7 +57,7 @@ EXPORT_SYMBOL(__mutex_init);
  * branch is predicted by the CPU as default-untaken.
  */
 static void fastcall noinline __sched
-__mutex_lock_slowpath(atomic_t *lock_count __IP_DECL__);
+__mutex_lock_slowpath(atomic_t *lock_count);
 
 /***
  * mutex_lock - acquire the mutex
@@ -79,7 +80,7 @@ __mutex_lock_slowpath(atomic_t *lock_cou
  *
  * This function is similar to (but not equivalent to) down().
  */
-void fastcall __sched mutex_lock(struct mutex *lock)
+void inline fastcall __sched mutex_lock(struct mutex *lock)
 {
 	might_sleep();
 	/*
@@ -92,7 +93,7 @@ void fastcall __sched mutex_lock(struct 
 EXPORT_SYMBOL(mutex_lock);
 
 static void fastcall noinline __sched
-__mutex_unlock_slowpath(atomic_t *lock_count __IP_DECL__);
+__mutex_unlock_slowpath(atomic_t *lock_count);
 
 /***
  * mutex_unlock - release the mutex
@@ -116,22 +117,36 @@ void fastcall __sched mutex_unlock(struc
 
 EXPORT_SYMBOL(mutex_unlock);
 
+static void fastcall noinline __sched
+__mutex_unlock_non_nested_slowpath(atomic_t *lock_count);
+
+void fastcall __sched mutex_unlock_non_nested(struct mutex *lock)
+{
+	/*
+	 * The unlocking fastpath is the 0->1 transition from 'locked'
+	 * into 'unlocked' state:
+	 */
+	__mutex_fastpath_unlock(&lock->count, __mutex_unlock_non_nested_slowpath);
+}
+
+EXPORT_SYMBOL(mutex_unlock_non_nested);
+
+
 /*
  * Lock a mutex (possibly interruptible), slowpath:
  */
 static inline int __sched
-__mutex_lock_common(struct mutex *lock, long state __IP_DECL__)
+__mutex_lock_common(struct mutex *lock, long state, unsigned int subtype)
 {
 	struct task_struct *task = current;
 	struct mutex_waiter waiter;
 	unsigned int old_val;
 	unsigned long flags;
 
-	debug_mutex_init_waiter(&waiter);
-
 	spin_lock_mutex(&lock->wait_lock, flags);
 
-	debug_mutex_add_waiter(lock, &waiter, task->thread_info, ip);
+	debug_mutex_lock_common(lock, &waiter);
+	debug_mutex_add_waiter(lock, &waiter, task->thread_info);
 
 	/* add waiting tasks to the end of the waitqueue (FIFO): */
 	list_add_tail(&waiter.list, &lock->wait_list);
@@ -173,7 +188,7 @@ __mutex_lock_common(struct mutex *lock, 
 
 	/* got the lock - rejoice! */
 	mutex_remove_waiter(lock, &waiter, task->thread_info);
-	debug_mutex_set_owner(lock, task->thread_info __IP__);
+	debug_mutex_set_owner(lock, task->thread_info);
 
 	/* set it to 0 if there are no waiters left: */
 	if (likely(list_empty(&lock->wait_list)))
@@ -183,32 +198,41 @@ __mutex_lock_common(struct mutex *lock, 
 
 	debug_mutex_free_waiter(&waiter);
 
-	DEBUG_WARN_ON(list_empty(&lock->held_list));
 	DEBUG_WARN_ON(lock->owner != task->thread_info);
 
 	return 0;
 }
 
 static void fastcall noinline __sched
-__mutex_lock_slowpath(atomic_t *lock_count __IP_DECL__)
+__mutex_lock_slowpath(atomic_t *lock_count)
 {
 	struct mutex *lock = container_of(lock_count, struct mutex, count);
 
-	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE __IP__);
+	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, 0);
 }
 
+#ifdef CONFIG_DEBUG_MUTEXES
+void __sched
+mutex_lock_nested(struct mutex *lock, unsigned int subtype)
+{
+	might_sleep();
+	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, subtype);
+}
+
+EXPORT_SYMBOL_GPL(mutex_lock_nested);
+#endif
+
 /*
  * Release the lock, slowpath:
  */
-static fastcall noinline void
-__mutex_unlock_slowpath(atomic_t *lock_count __IP_DECL__)
+static fastcall inline void
+__mutex_unlock_common_slowpath(atomic_t *lock_count, int nested)
 {
 	struct mutex *lock = container_of(lock_count, struct mutex, count);
 	unsigned long flags;
 
-	DEBUG_WARN_ON(lock->owner != current_thread_info());
-
 	spin_lock_mutex(&lock->wait_lock, flags);
+	debug_mutex_unlock(lock);
 
 	/*
 	 * some architectures leave the lock unlocked in the fastpath failure
@@ -218,8 +242,6 @@ __mutex_unlock_slowpath(atomic_t *lock_c
 	if (__mutex_slowpath_needs_to_unlock())
 		atomic_set(&lock->count, 1);
 
-	debug_mutex_unlock(lock);
-
 	if (!list_empty(&lock->wait_list)) {
 		/* get the first entry from the wait-list: */
 		struct mutex_waiter *waiter =
@@ -237,11 +259,27 @@ __mutex_unlock_slowpath(atomic_t *lock_c
 }
 
 /*
+ * Release the lock, slowpath:
+ */
+static fastcall noinline void
+__mutex_unlock_slowpath(atomic_t *lock_count)
+{
+	__mutex_unlock_common_slowpath(lock_count, 1);
+}
+
+static fastcall noinline void
+__mutex_unlock_non_nested_slowpath(atomic_t *lock_count)
+{
+	__mutex_unlock_common_slowpath(lock_count, 0);
+}
+
+
+/*
  * Here come the less common (and hence less performance-critical) APIs:
  * mutex_lock_interruptible() and mutex_trylock().
  */
 static int fastcall noinline __sched
-__mutex_lock_interruptible_slowpath(atomic_t *lock_count __IP_DECL__);
+__mutex_lock_interruptible_slowpath(atomic_t *lock_count);
 
 /***
  * mutex_lock_interruptible - acquire the mutex, interruptable
@@ -264,11 +302,11 @@ int fastcall __sched mutex_lock_interrup
 EXPORT_SYMBOL(mutex_lock_interruptible);
 
 static int fastcall noinline __sched
-__mutex_lock_interruptible_slowpath(atomic_t *lock_count __IP_DECL__)
+__mutex_lock_interruptible_slowpath(atomic_t *lock_count)
 {
 	struct mutex *lock = container_of(lock_count, struct mutex, count);
 
-	return __mutex_lock_common(lock, TASK_INTERRUPTIBLE __IP__);
+	return __mutex_lock_common(lock, TASK_INTERRUPTIBLE, 0);
 }
 
 /*
@@ -285,7 +323,8 @@ static inline int __mutex_trylock_slowpa
 
 	prev = atomic_xchg(&lock->count, -1);
 	if (likely(prev == 1))
-		debug_mutex_set_owner(lock, current_thread_info() __RET_IP__);
+		debug_mutex_set_owner(lock, current_thread_info());
+
 	/* Set it back to 0 if there are no waiters: */
 	if (likely(list_empty(&lock->wait_list)))
 		atomic_set(&lock->count, 0);
Index: linux/kernel/mutex.h
===================================================================
--- linux.orig/kernel/mutex.h
+++ linux/kernel/mutex.h
@@ -19,19 +19,15 @@
 #define DEBUG_WARN_ON(c)				do { } while (0)
 #define debug_mutex_set_owner(lock, new_owner)		do { } while (0)
 #define debug_mutex_clear_owner(lock)			do { } while (0)
-#define debug_mutex_init_waiter(waiter)			do { } while (0)
 #define debug_mutex_wake_waiter(lock, waiter)		do { } while (0)
 #define debug_mutex_free_waiter(waiter)			do { } while (0)
-#define debug_mutex_add_waiter(lock, waiter, ti, ip)	do { } while (0)
+#define debug_mutex_add_waiter(lock, waiter, ti)	do { } while (0)
+#define mutex_acquire(lock, subtype, trylock)	do { } while (0)
+#define mutex_release(lock, nested)		do { } while (0)
 #define debug_mutex_unlock(lock)			do { } while (0)
 #define debug_mutex_init(lock, name)			do { } while (0)
 
-/*
- * Return-address parameters/declarations. They are very useful for
- * debugging, but add overhead in the !DEBUG case - so we go the
- * trouble of using this not too elegant but zero-cost solution:
- */
-#define __IP_DECL__
-#define __IP__
-#define __RET_IP__
-
+static inline void
+debug_mutex_lock_common(struct mutex *lock, struct mutex_waiter *waiter)
+{
+}
Index: linux/kernel/rtmutex-debug.c
===================================================================
--- linux.orig/kernel/rtmutex-debug.c
+++ linux/kernel/rtmutex-debug.c
@@ -26,6 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/plist.h>
 #include <linux/fs.h>
+#include <linux/debug_locks.h>
 
 #include "rtmutex_common.h"
 
@@ -45,8 +46,6 @@ do {								\
 		console_verbose();				\
 		if (spin_is_locked(&current->pi_lock))		\
 			spin_unlock(&current->pi_lock);		\
-		if (spin_is_locked(&current->held_list_lock))	\
-			spin_unlock(&current->held_list_lock);	\
 	}							\
 } while (0)
 
@@ -105,14 +104,6 @@ static void printk_task(task_t *p)
 		printk("<none>");
 }
 
-static void printk_task_short(task_t *p)
-{
-	if (p)
-		printk("%s/%d [%p, %3d]", p->comm, p->pid, p, p->prio);
-	else
-		printk("<none>");
-}
-
 static void printk_lock(struct rt_mutex *lock, int print_owner)
 {
 	if (lock->name)
@@ -128,222 +119,6 @@ static void printk_lock(struct rt_mutex 
 		printk_task(rt_mutex_owner(lock));
 		printk("\n");
 	}
-	if (rt_mutex_owner(lock)) {
-		printk("... acquired at:               ");
-		print_symbol("%s\n", lock->acquire_ip);
-	}
-}
-
-static void printk_waiter(struct rt_mutex_waiter *w)
-{
-	printk("-------------------------\n");
-	printk("| waiter struct %p:\n", w);
-	printk("| w->list_entry: [DP:%p/%p|SP:%p/%p|PRI:%d]\n",
-	       w->list_entry.plist.prio_list.prev, w->list_entry.plist.prio_list.next,
-	       w->list_entry.plist.node_list.prev, w->list_entry.plist.node_list.next,
-	       w->list_entry.prio);
-	printk("| w->pi_list_entry: [DP:%p/%p|SP:%p/%p|PRI:%d]\n",
-	       w->pi_list_entry.plist.prio_list.prev, w->pi_list_entry.plist.prio_list.next,
-	       w->pi_list_entry.plist.node_list.prev, w->pi_list_entry.plist.node_list.next,
-	       w->pi_list_entry.prio);
-	printk("\n| lock:\n");
-	printk_lock(w->lock, 1);
-	printk("| w->ti->task:\n");
-	printk_task(w->task);
-	printk("| blocked at:  ");
-	print_symbol("%s\n", w->ip);
-	printk("-------------------------\n");
-}
-
-static void show_task_locks(task_t *p)
-{
-	switch (p->state) {
-	case TASK_RUNNING:		printk("R"); break;
-	case TASK_INTERRUPTIBLE:	printk("S"); break;
-	case TASK_UNINTERRUPTIBLE:	printk("D"); break;
-	case TASK_STOPPED:		printk("T"); break;
-	case EXIT_ZOMBIE:		printk("Z"); break;
-	case EXIT_DEAD:			printk("X"); break;
-	default:			printk("?"); break;
-	}
-	printk_task(p);
-	if (p->pi_blocked_on) {
-		struct rt_mutex *lock = p->pi_blocked_on->lock;
-
-		printk(" blocked on:");
-		printk_lock(lock, 1);
-	} else
-		printk(" (not blocked)\n");
-}
-
-void rt_mutex_show_held_locks(task_t *task, int verbose)
-{
-	struct list_head *curr, *cursor = NULL;
-	struct rt_mutex *lock;
-	task_t *t;
-	unsigned long flags;
-	int count = 0;
-
-	if (!rt_trace_on)
-		return;
-
-	if (verbose) {
-		printk("------------------------------\n");
-		printk("| showing all locks held by: |  (");
-		printk_task_short(task);
-		printk("):\n");
-		printk("------------------------------\n");
-	}
-
-next:
-	spin_lock_irqsave(&task->held_list_lock, flags);
-	list_for_each(curr, &task->held_list_head) {
-		if (cursor && curr != cursor)
-			continue;
-		lock = list_entry(curr, struct rt_mutex, held_list_entry);
-		t = rt_mutex_owner(lock);
-		WARN_ON(t != task);
-		count++;
-		cursor = curr->next;
-		spin_unlock_irqrestore(&task->held_list_lock, flags);
-
-		printk("\n#%03d:            ", count);
-		printk_lock(lock, 0);
-		goto next;
-	}
-	spin_unlock_irqrestore(&task->held_list_lock, flags);
-
-	printk("\n");
-}
-
-void rt_mutex_show_all_locks(void)
-{
-	task_t *g, *p;
-	int count = 10;
-	int unlock = 1;
-
-	printk("\n");
-	printk("----------------------\n");
-	printk("| showing all tasks: |\n");
-	printk("----------------------\n");
-
-	/*
-	 * Here we try to get the tasklist_lock as hard as possible,
-	 * if not successful after 2 seconds we ignore it (but keep
-	 * trying). This is to enable a debug printout even if a
-	 * tasklist_lock-holding task deadlocks or crashes.
-	 */
-retry:
-	if (!read_trylock(&tasklist_lock)) {
-		if (count == 10)
-			printk("hm, tasklist_lock locked, retrying... ");
-		if (count) {
-			count--;
-			printk(" #%d", 10-count);
-			mdelay(200);
-			goto retry;
-		}
-		printk(" ignoring it.\n");
-		unlock = 0;
-	}
-	if (count != 10)
-		printk(" locked it.\n");
-
-	do_each_thread(g, p) {
-		show_task_locks(p);
-		if (!unlock)
-			if (read_trylock(&tasklist_lock))
-				unlock = 1;
-	} while_each_thread(g, p);
-
-	printk("\n");
-
-	printk("-----------------------------------------\n");
-	printk("| showing all locks held in the system: |\n");
-	printk("-----------------------------------------\n");
-
-	do_each_thread(g, p) {
-		rt_mutex_show_held_locks(p, 0);
-		if (!unlock)
-			if (read_trylock(&tasklist_lock))
-				unlock = 1;
-	} while_each_thread(g, p);
-
-
-	printk("=============================================\n\n");
-
-	if (unlock)
-		read_unlock(&tasklist_lock);
-}
-
-void rt_mutex_debug_check_no_locks_held(task_t *task)
-{
-	struct rt_mutex_waiter *w;
-	struct list_head *curr;
-	struct rt_mutex *lock;
-
-	if (!rt_trace_on)
-		return;
-	if (!rt_prio(task->normal_prio) && rt_prio(task->prio)) {
-		printk("BUG: PI priority boost leaked!\n");
-		printk_task(task);
-		printk("\n");
-	}
-	if (list_empty(&task->held_list_head))
-		return;
-
-	spin_lock(&task->pi_lock);
-	plist_for_each_entry(w, &task->pi_waiters, pi_list_entry) {
-		TRACE_OFF();
-
-		printk("hm, PI interest held at exit time? Task:\n");
-		printk_task(task);
-		printk_waiter(w);
-		return;
-	}
-	spin_unlock(&task->pi_lock);
-
-	list_for_each(curr, &task->held_list_head) {
-		lock = list_entry(curr, struct rt_mutex, held_list_entry);
-
-		printk("BUG: %s/%d, lock held at task exit time!\n",
-		       task->comm, task->pid);
-		printk_lock(lock, 1);
-		if (rt_mutex_owner(lock) != task)
-			printk("exiting task is not even the owner??\n");
-	}
-}
-
-int rt_mutex_debug_check_no_locks_freed(const void *from, unsigned long len)
-{
-	const void *to = from + len;
-	struct list_head *curr;
-	struct rt_mutex *lock;
-	unsigned long flags;
-	void *lock_addr;
-
-	if (!rt_trace_on)
-		return 0;
-
-	spin_lock_irqsave(&current->held_list_lock, flags);
-	list_for_each(curr, &current->held_list_head) {
-		lock = list_entry(curr, struct rt_mutex, held_list_entry);
-		lock_addr = lock;
-		if (lock_addr < from || lock_addr >= to)
-			continue;
-		TRACE_OFF();
-
-		printk("BUG: %s/%d, active lock [%p(%p-%p)] freed!\n",
-			current->comm, current->pid, lock, from, to);
-		dump_stack();
-		printk_lock(lock, 1);
-		if (rt_mutex_owner(lock) != current)
-			printk("freeing task is not even the owner??\n");
-		return 1;
-	}
-	spin_unlock_irqrestore(&current->held_list_lock, flags);
-
-	return 0;
 }
 
 void rt_mutex_debug_task_free(struct task_struct *task)
@@ -395,85 +170,41 @@ void debug_rt_mutex_print_deadlock(struc
 	       current->comm, current->pid);
 	printk_lock(waiter->lock, 1);
 
-	printk("... trying at:                 ");
-	print_symbol("%s\n", waiter->ip);
-
 	printk("\n2) %s/%d is blocked on this lock:\n", task->comm, task->pid);
 	printk_lock(waiter->deadlock_lock, 1);
 
-	rt_mutex_show_held_locks(current, 1);
-	rt_mutex_show_held_locks(task, 1);
+	debug_show_held_locks(current);
+	debug_show_held_locks(task);
 
 	printk("\n%s/%d's [blocked] stackdump:\n\n", task->comm, task->pid);
 	show_stack(task, NULL);
 	printk("\n%s/%d's [current] stackdump:\n\n",
 	       current->comm, current->pid);
 	dump_stack();
-	rt_mutex_show_all_locks();
+	debug_show_all_locks();
+
 	printk("[ turning off deadlock detection."
 	       "Please report this trace. ]\n\n");
 	local_irq_disable();
 }
 
-void debug_rt_mutex_lock(struct rt_mutex *lock __IP_DECL__)
+void debug_rt_mutex_lock(struct rt_mutex *lock)
 {
-	unsigned long flags;
-
-	if (rt_trace_on) {
-		TRACE_WARN_ON_LOCKED(!list_empty(&lock->held_list_entry));
-
-		spin_lock_irqsave(&current->held_list_lock, flags);
-		list_add_tail(&lock->held_list_entry, &current->held_list_head);
-		spin_unlock_irqrestore(&current->held_list_lock, flags);
-
-		lock->acquire_ip = ip;
-	}
 }
 
 void debug_rt_mutex_unlock(struct rt_mutex *lock)
 {
-	unsigned long flags;
-
-	if (rt_trace_on) {
-		TRACE_WARN_ON_LOCKED(rt_mutex_owner(lock) != current);
-		TRACE_WARN_ON_LOCKED(list_empty(&lock->held_list_entry));
-
-		spin_lock_irqsave(&current->held_list_lock, flags);
-		list_del_init(&lock->held_list_entry);
-		spin_unlock_irqrestore(&current->held_list_lock, flags);
-	}
+	TRACE_WARN_ON_LOCKED(rt_mutex_owner(lock) != current);
 }
 
-void debug_rt_mutex_proxy_lock(struct rt_mutex *lock,
-			       struct task_struct *powner __IP_DECL__)
+void
+debug_rt_mutex_proxy_lock(struct rt_mutex *lock, struct task_struct *powner)
 {
-	unsigned long flags;
-
-	if (rt_trace_on) {
-		TRACE_WARN_ON_LOCKED(!list_empty(&lock->held_list_entry));
-
-		spin_lock_irqsave(&powner->held_list_lock, flags);
-		list_add_tail(&lock->held_list_entry, &powner->held_list_head);
-		spin_unlock_irqrestore(&powner->held_list_lock, flags);
-
-		lock->acquire_ip = ip;
-	}
 }
 
 void debug_rt_mutex_proxy_unlock(struct rt_mutex *lock)
 {
-	unsigned long flags;
-
-	if (rt_trace_on) {
-		struct task_struct *owner = rt_mutex_owner(lock);
-
-		TRACE_WARN_ON_LOCKED(!owner);
-		TRACE_WARN_ON_LOCKED(list_empty(&lock->held_list_entry));
-
-		spin_lock_irqsave(&owner->held_list_lock, flags);
-		list_del_init(&lock->held_list_entry);
-		spin_unlock_irqrestore(&owner->held_list_lock, flags);
-	}
+	TRACE_WARN_ON_LOCKED(!rt_mutex_owner(lock));
 }
 
 void debug_rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
@@ -493,14 +224,11 @@ void debug_rt_mutex_free_waiter(struct r
 
 void debug_rt_mutex_init(struct rt_mutex *lock, const char *name)
 {
-	void *addr = lock;
-
-	if (rt_trace_on) {
-		rt_mutex_debug_check_no_locks_freed(addr,
-						    sizeof(struct rt_mutex));
-		INIT_LIST_HEAD(&lock->held_list_entry);
-		lock->name = name;
-	}
+	/*
+	 * Make sure we are not reinitializing a held lock:
+	 */
+	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
+	lock->name = name;
 }
 
 void rt_mutex_deadlock_account_lock(struct rt_mutex *lock, task_t *task)
Index: linux/kernel/rtmutex-debug.h
===================================================================
--- linux.orig/kernel/rtmutex-debug.h
+++ linux/kernel/rtmutex-debug.h
@@ -9,20 +9,16 @@
  * This file contains macros used solely by rtmutex.c. Debug version.
  */
 
-#define __IP_DECL__		, unsigned long ip
-#define __IP__			, ip
-#define __RET_IP__		, (unsigned long)__builtin_return_address(0)
-
 extern void
 rt_mutex_deadlock_account_lock(struct rt_mutex *lock, struct task_struct *task);
 extern void rt_mutex_deadlock_account_unlock(struct task_struct *task);
 extern void debug_rt_mutex_init_waiter(struct rt_mutex_waiter *waiter);
 extern void debug_rt_mutex_free_waiter(struct rt_mutex_waiter *waiter);
 extern void debug_rt_mutex_init(struct rt_mutex *lock, const char *name);
-extern void debug_rt_mutex_lock(struct rt_mutex *lock __IP_DECL__);
+extern void debug_rt_mutex_lock(struct rt_mutex *lock);
 extern void debug_rt_mutex_unlock(struct rt_mutex *lock);
 extern void debug_rt_mutex_proxy_lock(struct rt_mutex *lock,
-				      struct task_struct *powner __IP_DECL__);
+				      struct task_struct *powner);
 extern void debug_rt_mutex_proxy_unlock(struct rt_mutex *lock);
 extern void debug_rt_mutex_deadlock(int detect, struct rt_mutex_waiter *waiter,
 				    struct rt_mutex *lock);
Index: linux/kernel/rtmutex.c
===================================================================
--- linux.orig/kernel/rtmutex.c
+++ linux/kernel/rtmutex.c
@@ -160,8 +160,7 @@ int max_lock_depth = 1024;
 static int rt_mutex_adjust_prio_chain(task_t *task,
 				      int deadlock_detect,
 				      struct rt_mutex *orig_lock,
-				      struct rt_mutex_waiter *orig_waiter
-				      __IP_DECL__)
+				      struct rt_mutex_waiter *orig_waiter)
 {
 	struct rt_mutex *lock;
 	struct rt_mutex_waiter *waiter, *top_waiter = orig_waiter;
@@ -356,7 +355,7 @@ static inline int try_to_steal_lock(stru
  *
  * Must be called with lock->wait_lock held.
  */
-static int try_to_take_rt_mutex(struct rt_mutex *lock __IP_DECL__)
+static int try_to_take_rt_mutex(struct rt_mutex *lock)
 {
 	/*
 	 * We have to be careful here if the atomic speedups are
@@ -383,7 +382,7 @@ static int try_to_take_rt_mutex(struct r
 		return 0;
 
 	/* We got the lock. */
-	debug_rt_mutex_lock(lock __IP__);
+	debug_rt_mutex_lock(lock);
 
 	rt_mutex_set_owner(lock, current, 0);
 
@@ -401,8 +400,7 @@ static int try_to_take_rt_mutex(struct r
  */
 static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 				   struct rt_mutex_waiter *waiter,
-				   int detect_deadlock
-				   __IP_DECL__)
+				   int detect_deadlock)
 {
 	struct rt_mutex_waiter *top_waiter = waiter;
 	task_t *owner = rt_mutex_owner(lock);
@@ -450,8 +448,7 @@ static int task_blocks_on_rt_mutex(struc
 
 	spin_unlock(&lock->wait_lock);
 
-	res = rt_mutex_adjust_prio_chain(owner, detect_deadlock, lock,
-					 waiter __IP__);
+	res = rt_mutex_adjust_prio_chain(owner, detect_deadlock, lock, waiter);
 
 	spin_lock(&lock->wait_lock);
 
@@ -523,7 +520,7 @@ static void wakeup_next_waiter(struct rt
  * Must be called with lock->wait_lock held
  */
 static void remove_waiter(struct rt_mutex *lock,
-			  struct rt_mutex_waiter *waiter  __IP_DECL__)
+			  struct rt_mutex_waiter *waiter)
 {
 	int first = (waiter == rt_mutex_top_waiter(lock));
 	int boost = 0;
@@ -564,7 +561,7 @@ static void remove_waiter(struct rt_mute
 
 	spin_unlock(&lock->wait_lock);
 
-	rt_mutex_adjust_prio_chain(owner, 0, lock, NULL __IP__);
+	rt_mutex_adjust_prio_chain(owner, 0, lock, NULL);
 
 	spin_lock(&lock->wait_lock);
 }
@@ -575,7 +572,7 @@ static void remove_waiter(struct rt_mute
 static int __sched
 rt_mutex_slowlock(struct rt_mutex *lock, int state,
 		  struct hrtimer_sleeper *timeout,
-		  int detect_deadlock __IP_DECL__)
+		  int detect_deadlock)
 {
 	struct rt_mutex_waiter waiter;
 	int ret = 0;
@@ -586,7 +583,7 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 	spin_lock(&lock->wait_lock);
 
 	/* Try to acquire the lock again: */
-	if (try_to_take_rt_mutex(lock __IP__)) {
+	if (try_to_take_rt_mutex(lock)) {
 		spin_unlock(&lock->wait_lock);
 		return 0;
 	}
@@ -600,7 +597,7 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 
 	for (;;) {
 		/* Try to acquire the lock: */
-		if (try_to_take_rt_mutex(lock __IP__))
+		if (try_to_take_rt_mutex(lock))
 			break;
 
 		/*
@@ -624,7 +621,7 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 		 */
 		if (!waiter.task) {
 			ret = task_blocks_on_rt_mutex(lock, &waiter,
-						      detect_deadlock __IP__);
+						      detect_deadlock);
 			/*
 			 * If we got woken up by the owner then start loop
 			 * all over without going into schedule to try
@@ -650,7 +647,7 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 	set_current_state(TASK_RUNNING);
 
 	if (unlikely(waiter.task))
-		remove_waiter(lock, &waiter __IP__);
+		remove_waiter(lock, &waiter);
 
 	/*
 	 * try_to_take_rt_mutex() sets the waiter bit
@@ -681,7 +678,7 @@ rt_mutex_slowlock(struct rt_mutex *lock,
  * Slow path try-lock function:
  */
 static inline int
-rt_mutex_slowtrylock(struct rt_mutex *lock __IP_DECL__)
+rt_mutex_slowtrylock(struct rt_mutex *lock)
 {
 	int ret = 0;
 
@@ -689,7 +686,7 @@ rt_mutex_slowtrylock(struct rt_mutex *lo
 
 	if (likely(rt_mutex_owner(lock) != current)) {
 
-		ret = try_to_take_rt_mutex(lock __IP__);
+		ret = try_to_take_rt_mutex(lock);
 		/*
 		 * try_to_take_rt_mutex() sets the lock waiters
 		 * bit unconditionally. Clean this up.
@@ -739,13 +736,13 @@ rt_mutex_fastlock(struct rt_mutex *lock,
 		  int detect_deadlock,
 		  int (*slowfn)(struct rt_mutex *lock, int state,
 				struct hrtimer_sleeper *timeout,
-				int detect_deadlock __IP_DECL__))
+				int detect_deadlock))
 {
 	if (!detect_deadlock && likely(rt_mutex_cmpxchg(lock, NULL, current))) {
 		rt_mutex_deadlock_account_lock(lock, current);
 		return 0;
 	} else
-		return slowfn(lock, state, NULL, detect_deadlock __RET_IP__);
+		return slowfn(lock, state, NULL, detect_deadlock);
 }
 
 static inline int
@@ -753,24 +750,24 @@ rt_mutex_timed_fastlock(struct rt_mutex 
 			struct hrtimer_sleeper *timeout, int detect_deadlock,
 			int (*slowfn)(struct rt_mutex *lock, int state,
 				      struct hrtimer_sleeper *timeout,
-				      int detect_deadlock __IP_DECL__))
+				      int detect_deadlock))
 {
 	if (!detect_deadlock && likely(rt_mutex_cmpxchg(lock, NULL, current))) {
 		rt_mutex_deadlock_account_lock(lock, current);
 		return 0;
 	} else
-		return slowfn(lock, state, timeout, detect_deadlock __RET_IP__);
+		return slowfn(lock, state, timeout, detect_deadlock);
 }
 
 static inline int
 rt_mutex_fasttrylock(struct rt_mutex *lock,
-		     int (*slowfn)(struct rt_mutex *lock __IP_DECL__))
+		     int (*slowfn)(struct rt_mutex *lock))
 {
 	if (likely(rt_mutex_cmpxchg(lock, NULL, current))) {
 		rt_mutex_deadlock_account_lock(lock, current);
 		return 1;
 	}
-	return slowfn(lock __RET_IP__);
+	return slowfn(lock);
 }
 
 static inline void
@@ -918,7 +915,7 @@ void rt_mutex_init_proxy_locked(struct r
 				struct task_struct *proxy_owner)
 {
 	__rt_mutex_init(lock, NULL);
-	debug_rt_mutex_proxy_lock(lock, proxy_owner __RET_IP__);
+	debug_rt_mutex_proxy_lock(lock, proxy_owner);
 	rt_mutex_set_owner(lock, proxy_owner, 0);
 	rt_mutex_deadlock_account_lock(lock, proxy_owner);
 }
Index: linux/kernel/rtmutex.h
===================================================================
--- linux.orig/kernel/rtmutex.h
+++ linux/kernel/rtmutex.h
@@ -10,9 +10,6 @@
  * Non-debug version.
  */
 
-#define __IP_DECL__
-#define __IP__
-#define __RET_IP__
 #define rt_mutex_deadlock_check(l)			(0)
 #define rt_mutex_deadlock_account_lock(m, t)		do { } while (0)
 #define rt_mutex_deadlock_account_unlock(l)		do { } while (0)
Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c
+++ linux/kernel/sched.c
@@ -30,6 +30,7 @@
 #include <linux/capability.h>
 #include <linux/completion.h>
 #include <linux/kernel_stat.h>
+#include <linux/debug_locks.h>
 #include <linux/security.h>
 #include <linux/notifier.h>
 #include <linux/profile.h>
@@ -3158,12 +3159,13 @@ void fastcall add_preempt_count(int val)
 	/*
 	 * Underflow?
 	 */
-	BUG_ON((preempt_count() < 0));
+	if (DEBUG_WARN_ON((preempt_count() < 0)))
+		return;
 	preempt_count() += val;
 	/*
 	 * Spinlock count overflowing soon?
 	 */
-	BUG_ON((preempt_count() & PREEMPT_MASK) >= PREEMPT_MASK-10);
+	DEBUG_WARN_ON((preempt_count() & PREEMPT_MASK) >= PREEMPT_MASK-10);
 }
 EXPORT_SYMBOL(add_preempt_count);
 
@@ -3172,11 +3174,15 @@ void fastcall sub_preempt_count(int val)
 	/*
 	 * Underflow?
 	 */
-	BUG_ON(val > preempt_count());
+	if (DEBUG_WARN_ON(val > preempt_count()))
+		return;
 	/*
 	 * Is the spinlock portion underflowing?
 	 */
-	BUG_ON((val < PREEMPT_MASK) && !(preempt_count() & PREEMPT_MASK));
+	if (DEBUG_WARN_ON((val < PREEMPT_MASK) &&
+			!(preempt_count() & PREEMPT_MASK)))
+		return;
+
 	preempt_count() -= val;
 }
 EXPORT_SYMBOL(sub_preempt_count);
@@ -4715,7 +4721,7 @@ void show_state(void)
 	} while_each_thread(g, p);
 
 	read_unlock(&tasklist_lock);
-	mutex_debug_show_all_locks();
+	debug_show_all_locks();
 }
 
 /**
Index: linux/lib/Kconfig.debug
===================================================================
--- linux.orig/lib/Kconfig.debug
+++ linux/lib/Kconfig.debug
@@ -130,12 +130,30 @@ config DEBUG_PREEMPT
 	  will detect preemption count underflows.
 
 config DEBUG_MUTEXES
-	bool "Mutex debugging, deadlock detection"
-	default n
+	bool "Mutex debugging, basic checks"
+	default y
 	depends on DEBUG_KERNEL
 	help
-	 This allows mutex semantics violations and mutex related deadlocks
-	 (lockups) to be detected and reported automatically.
+	 This feature allows mutex semantics violations to be detected and
+	 reported.
+
+config DEBUG_MUTEX_ALLOC
+	bool "Detect incorrect freeing of live mutexes"
+	default y
+	depends on DEBUG_MUTEXES
+	help
+	 This feature will check whether any held mutex is incorrectly
+	 freed by the kernel, via any of the memory-freeing routines
+	 (kfree(), kmem_cache_free(), free_pages(), vfree(), etc.),
+	 or whether there is any lock held during task exit.
+
+config DEBUG_MUTEX_DEADLOCKS
+	bool "Detect mutex related deadlocks"
+	default y
+	depends on DEBUG_MUTEXES
+	help
+	 This feature will automatically detect and report mutex related
+	 deadlocks, as they happen.
 
 config DEBUG_RT_MUTEXES
 	bool "RT Mutex debugging, deadlock detection"
Index: linux/lib/Makefile
===================================================================
--- linux.orig/lib/Makefile
+++ linux/lib/Makefile
@@ -11,7 +11,7 @@ lib-$(CONFIG_SMP) += cpumask.o
 
 lib-y	+= kobject.o kref.o kobject_uevent.o klist.o
 
-obj-y += sort.o parser.o halfmd4.o iomap_copy.o
+obj-y += sort.o parser.o halfmd4.o iomap_copy.o debug_locks.o
 
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG
Index: linux/lib/debug_locks.c
===================================================================
--- /dev/null
+++ linux/lib/debug_locks.c
@@ -0,0 +1,45 @@
+/*
+ * lib/debug_locks.c
+ *
+ * Generic place for common debugging facilities for various locks:
+ * spinlocks, rwlocks, mutexes and rwsems.
+ *
+ * Started by Ingo Molnar:
+ *
+ *  Copyright (C) 2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ */
+#include <linux/rwsem.h>
+#include <linux/mutex.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/debug_locks.h>
+
+/*
+ * We want to turn all lock-debugging facilities on/off at once,
+ * via a global flag. The reason is that once a single bug has been
+ * detected and reported, there might be cascade of followup bugs
+ * that would just muddy the log. So we report the first one and
+ * shut up after that.
+ */
+int debug_locks = 1;
+
+/*
+ * The locking-testsuite uses <debug_locks_silent> to get a
+ * 'silent failure': nothing is printed to the console when
+ * a locking bug is detected.
+ */
+int debug_locks_silent;
+
+/*
+ * Generic 'turn off all lock debugging' function:
+ */
+int debug_locks_off(void)
+{
+	if (xchg(&debug_locks, 0)) {
+		if (!debug_locks_silent) {
+			console_verbose();
+			return 1;
+		}
+	}
+	return 0;
+}
Index: linux/lib/spinlock_debug.c
===================================================================
--- linux.orig/lib/spinlock_debug.c
+++ linux/lib/spinlock_debug.c
@@ -9,38 +9,35 @@
 #include <linux/config.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
+#include <linux/debug_locks.h>
 #include <linux/delay.h>
+#include <linux/module.h>
 
 static void spin_bug(spinlock_t *lock, const char *msg)
 {
-	static long print_once = 1;
 	struct task_struct *owner = NULL;
 
-	if (xchg(&print_once, 0)) {
-		if (lock->owner && lock->owner != SPINLOCK_OWNER_INIT)
-			owner = lock->owner;
-		printk(KERN_EMERG "BUG: spinlock %s on CPU#%d, %s/%d\n",
-			msg, raw_smp_processor_id(),
-			current->comm, current->pid);
-		printk(KERN_EMERG " lock: %p, .magic: %08x, .owner: %s/%d, "
-				".owner_cpu: %d\n",
-			lock, lock->magic,
-			owner ? owner->comm : "<none>",
-			owner ? owner->pid : -1,
-			lock->owner_cpu);
-		dump_stack();
-#ifdef CONFIG_SMP
-		/*
-		 * We cannot continue on SMP:
-		 */
-//		panic("bad locking");
-#endif
-	}
+	if (!debug_locks_off())
+		return;
+
+	if (lock->owner && lock->owner != SPINLOCK_OWNER_INIT)
+		owner = lock->owner;
+	printk(KERN_EMERG "BUG: spinlock %s on CPU#%d, %s/%d\n",
+		msg, raw_smp_processor_id(),
+		current->comm, current->pid);
+	printk(KERN_EMERG " lock: %p, .magic: %08x, .owner: %s/%d, "
+			".owner_cpu: %d\n",
+		lock, lock->magic,
+		owner ? owner->comm : "<none>",
+		owner ? owner->pid : -1,
+		lock->owner_cpu);
+	dump_stack();
 }
 
 #define SPIN_BUG_ON(cond, lock, msg) if (unlikely(cond)) spin_bug(lock, msg)
 
-static inline void debug_spin_lock_before(spinlock_t *lock)
+static inline void
+debug_spin_lock_before(spinlock_t *lock)
 {
 	SPIN_BUG_ON(lock->magic != SPINLOCK_MAGIC, lock, "bad magic");
 	SPIN_BUG_ON(lock->owner == current, lock, "recursion");
@@ -119,20 +116,13 @@ void _raw_spin_unlock(spinlock_t *lock)
 
 static void rwlock_bug(rwlock_t *lock, const char *msg)
 {
-	static long print_once = 1;
+	if (!debug_locks_off())
+		return;
 
-	if (xchg(&print_once, 0)) {
-		printk(KERN_EMERG "BUG: rwlock %s on CPU#%d, %s/%d, %p\n",
-			msg, raw_smp_processor_id(), current->comm,
-			current->pid, lock);
-		dump_stack();
-#ifdef CONFIG_SMP
-		/*
-		 * We cannot continue on SMP:
-		 */
-		panic("bad locking");
-#endif
-	}
+	printk(KERN_EMERG "BUG: rwlock %s on CPU#%d, %s/%d, %p\n",
+		msg, raw_smp_processor_id(), current->comm,
+		current->pid, lock);
+	dump_stack();
 }
 
 #define RWLOCK_BUG_ON(cond, lock, msg) if (unlikely(cond)) rwlock_bug(lock, msg)
Index: linux/mm/vmalloc.c
===================================================================
--- linux.orig/mm/vmalloc.c
+++ linux/mm/vmalloc.c
@@ -330,6 +330,8 @@ void __vunmap(void *addr, int deallocate
 		return;
 	}
 
+	debug_check_no_locks_freed(addr, area->size);
+
 	if (deallocate_pages) {
 		int i;
 
