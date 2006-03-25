Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWCYStj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWCYStj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 13:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWCYStY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 13:49:24 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:53409 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932240AbWCYStI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 13:49:08 -0500
Date: Sat, 25 Mar 2006 19:46:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Subject: [patch 07/10] PI-futex: rt-mutex debug
Message-ID: <20060325184626.GH16724@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

runtime debugging functionality for rt-mutexes.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

----

 include/linux/mm.h      |    1 
 include/linux/rtmutex.h |   15 +
 kernel/Makefile         |    1 
 kernel/exit.c           |    1 
 kernel/rtmutex-debug.c  |  511 ++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/rtmutex-debug.h  |   32 +++
 lib/Kconfig.debug       |   13 +
 mm/slab.c               |    1 
 8 files changed, 574 insertions(+), 1 deletion(-)

Index: linux-pi-futex.mm.q/include/linux/mm.h
===================================================================
--- linux-pi-futex.mm.q.orig/include/linux/mm.h
+++ linux-pi-futex.mm.q/include/linux/mm.h
@@ -1070,6 +1070,7 @@ static inline void
 debug_check_no_locks_freed(const void *from, unsigned long len)
 {
 	mutex_debug_check_no_locks_freed(from, len);
+	rt_mutex_debug_check_no_locks_freed(from, len);
 }
 
 #ifndef CONFIG_DEBUG_PAGEALLOC
Index: linux-pi-futex.mm.q/include/linux/rtmutex.h
===================================================================
--- linux-pi-futex.mm.q.orig/include/linux/rtmutex.h
+++ linux-pi-futex.mm.q/include/linux/rtmutex.h
@@ -41,6 +41,19 @@ struct rt_mutex_waiter;
 struct hrtimer_sleeper;
 
 #ifdef CONFIG_DEBUG_RT_MUTEXES
+ extern int rt_mutex_debug_check_no_locks_freed(const void *from,
+						unsigned long len);
+ extern void rt_mutex_debug_check_no_locks_held(struct task_struct *task);
+#else
+ static inline int rt_mutex_debug_check_no_locks_freed(const void *from,
+						       unsigned long len)
+ {
+	return 0;
+ }
+# define rt_mutex_debug_check_no_locks_held(task)	do { } while (0)
+#endif
+
+#ifdef CONFIG_DEBUG_RT_MUTEXES
 # define __DEBUG_RT_MUTEX_INITIALIZER(mutexname) \
 	, .name = #mutexname, .file = __FILE__, .line = __LINE__
 # define rt_mutex_init(mutex)			__rt_mutex_init(mutex, __FUNCTION__)
@@ -48,7 +61,7 @@ struct hrtimer_sleeper;
 #else
 # define __DEBUG_RT_MUTEX_INITIALIZER(mutexname)
 # define rt_mutex_init(mutex)			__rt_mutex_init(mutex, NULL)
-# define rt_mutex_debug_task_free(t)		do { } while (0)
+# define rt_mutex_debug_task_free(t)			do { } while (0)
 #endif
 
 #define __RT_MUTEX_INITIALIZER(mutexname) \
Index: linux-pi-futex.mm.q/kernel/Makefile
===================================================================
--- linux-pi-futex.mm.q.orig/kernel/Makefile
+++ linux-pi-futex.mm.q/kernel/Makefile
@@ -17,6 +17,7 @@ ifeq ($(CONFIG_COMPAT),y)
 obj-$(CONFIG_FUTEX) += futex_compat.o
 endif
 obj-$(CONFIG_RT_MUTEXES) += rtmutex.o
+obj-$(CONFIG_DEBUG_RT_MUTEXES) += rtmutex-debug.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o spinlock.o
 obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock.o
Index: linux-pi-futex.mm.q/kernel/exit.c
===================================================================
--- linux-pi-futex.mm.q.orig/kernel/exit.c
+++ linux-pi-futex.mm.q/kernel/exit.c
@@ -931,6 +931,7 @@ fastcall NORET_TYPE void do_exit(long co
 	 * If DEBUG_MUTEXES is on, make sure we are holding no locks:
 	 */
 	mutex_debug_check_no_locks_held(tsk);
+	rt_mutex_debug_check_no_locks_held(tsk);
 
 	if (tsk->io_context)
 		exit_io_context();
Index: linux-pi-futex.mm.q/kernel/rtmutex-debug.c
===================================================================
--- /dev/null
+++ linux-pi-futex.mm.q/kernel/rtmutex-debug.c
@@ -0,0 +1,511 @@
+/*
+ * RT-Mutexes: blocking mutual exclusion locks with PI support
+ *
+ * started by Ingo Molnar and Thomas Gleixner:
+ *
+ *  Copyright (C) 2004-2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ *  Copyright (C) 2006 Timesys Corp., Thomas Gleixner <tglx@timesys.com>
+ *
+ * This code is based on the rt.c implementation in the preempt-rt tree.
+ * Portions of said code are
+ *
+ *  Copyright (C) 2004  LynuxWorks, Inc., Igor Manyilov, Bill Huey
+ *  Copyright (C) 2006  Esben Nielsen
+ *  Copyright (C) 2006  Kihon Technologies Inc.,
+ *			Steven Rostedt <rostedt@goodmis.org>
+ *
+ * See rt.c in preempt-rt for proper credits and further information
+ */
+#include <linux/config.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/kallsyms.h>
+#include <linux/syscalls.h>
+#include <linux/interrupt.h>
+#include <linux/plist.h>
+#include <linux/fs.h>
+
+#include <linux/rtmutex_internal.h>
+
+#ifdef CONFIG_DEBUG_RT_MUTEXES
+# include "rtmutex-debug.h"
+#else
+# include "rtmutex.h"
+#endif
+
+# define TRACE_WARN_ON(x)			WARN_ON(x)
+# define TRACE_BUG_ON(x)			BUG_ON(x)
+
+# define TRACE_OFF()						\
+do {								\
+	if (rt_trace_on) {					\
+		rt_trace_on = 0;				\
+		console_verbose();				\
+		if (spin_is_locked(&current->pi_lock))		\
+			spin_unlock(&current->pi_lock);		\
+		spin_unlock(&tracelock);			\
+	}							\
+} while (0)
+
+# define TRACE_OFF_NOLOCK()					\
+do {								\
+	if (rt_trace_on) {					\
+		rt_trace_on = 0;				\
+		console_verbose();				\
+	}							\
+} while (0)
+
+# define TRACE_BUG_LOCKED()			\
+do {						\
+	TRACE_OFF();				\
+	BUG();					\
+} while (0)
+
+# define TRACE_WARN_ON_LOCKED(c)		\
+do {						\
+	if (unlikely(c)) {			\
+		TRACE_OFF();			\
+		WARN_ON(1);			\
+	}					\
+} while (0)
+
+# define TRACE_BUG_ON_LOCKED(c)			\
+do {						\
+	if (unlikely(c))			\
+		TRACE_BUG_LOCKED();		\
+} while (0)
+
+#ifdef CONFIG_SMP
+# define SMP_TRACE_BUG_ON_LOCKED(c)	TRACE_BUG_ON_LOCKED(c)
+#else
+# define SMP_TRACE_BUG_ON_LOCKED(c)	do { } while (0)
+#endif
+
+
+/*
+ * We need a global lock when we walk through the multi-process
+ * lock tree...
+ */
+static spinlock_t tracelock = SPIN_LOCK_UNLOCKED;
+static LIST_HEAD(held_locks);
+
+/*
+ * deadlock detection flag. We turn it off when we detect
+ * the first problem because we dont want to recurse back
+ * into the tracing code when doing error printk or
+ * executing a BUG():
+ */
+int rt_trace_on = 1;
+
+void deadlock_trace_off(void)
+{
+	rt_trace_on = 0;
+}
+
+static void printk_task(task_t *p)
+{
+	if (p)
+		printk("%16s:%5d [%p, %3d]", p->comm, p->pid, p, p->prio);
+	else
+		printk("<none>");
+}
+
+static void printk_task_short(task_t *p)
+{
+	if (p)
+		printk("%s/%d [%p, %3d]", p->comm, p->pid, p, p->prio);
+	else
+		printk("<none>");
+}
+
+static void printk_lock(struct rt_mutex *lock, int print_owner)
+{
+	if (lock->name)
+		printk(" [%p] {%s}\n",
+			lock, lock->name);
+	else
+		printk(" [%p] {%s:%d}\n",
+			lock, lock->file, lock->line);
+
+	if (print_owner && rt_mutex_owner(lock)) {
+		printk(".. ->owner: %p\n", lock->owner);
+		printk(".. held by:  ");
+		printk_task(rt_mutex_owner(lock));
+		printk("\n");
+	}
+	if (rt_mutex_owner(lock)) {
+		printk("... acquired at:               ");
+		print_symbol("%s\n", lock->acquire_ip);
+	}
+}
+
+static void printk_waiter(struct rt_mutex_waiter *w)
+{
+	printk("-------------------------\n");
+	printk("| waiter struct %p:\n", w);
+	printk("| w->list_entry: [DP:%p/%p|SP:%p/%p|PRI:%d]\n",
+	       w->list_entry.plist.prio_list.prev, w->list_entry.plist.prio_list.next,
+	       w->list_entry.plist.node_list.prev, w->list_entry.plist.node_list.next,
+	       w->list_entry.prio);
+	printk("| w->pi_list_entry: [DP:%p/%p|SP:%p/%p|PRI:%d]\n",
+	       w->pi_list_entry.plist.prio_list.prev, w->pi_list_entry.plist.prio_list.next,
+	       w->pi_list_entry.plist.node_list.prev, w->pi_list_entry.plist.node_list.next,
+	       w->pi_list_entry.prio);
+	printk("\n| lock:\n");
+	printk_lock(w->lock, 1);
+	printk("| w->ti->task:\n");
+	printk_task(w->task);
+	printk("| blocked at:  ");
+	print_symbol("%s\n", w->ip);
+	printk("-------------------------\n");
+}
+
+static void show_task_locks(task_t *p)
+{
+	switch (p->state) {
+	case TASK_RUNNING:		printk("R"); break;
+	case TASK_INTERRUPTIBLE:	printk("S"); break;
+	case TASK_UNINTERRUPTIBLE:	printk("D"); break;
+	case TASK_STOPPED:		printk("T"); break;
+	case EXIT_ZOMBIE:		printk("Z"); break;
+	case EXIT_DEAD:			printk("X"); break;
+	default:			printk("?"); break;
+	}
+	printk_task(p);
+	if (p->pi_blocked_on) {
+		struct rt_mutex *lock = p->pi_blocked_on->lock;
+
+		printk(" blocked on:");
+		printk_lock(lock, 1);
+	} else
+		printk(" (not blocked)\n");
+}
+
+void rt_mutex_show_held_locks(task_t *filter)
+{
+	struct list_head *curr, *cursor = NULL;
+	struct rt_mutex *lock;
+	task_t *t;
+	unsigned long flags;
+	int count = 0;
+
+	if (!rt_trace_on)
+		return;
+
+	if (filter) {
+		printk("------------------------------\n");
+		printk("| showing all locks held by: |  (");
+		printk_task_short(filter);
+		printk("):\n");
+		printk("------------------------------\n");
+	} else {
+		printk("---------------------------\n");
+		printk("| showing all locks held: |\n");
+		printk("---------------------------\n");
+	}
+
+	/*
+	 * Play safe and acquire the global trace lock. We
+	 * cannot printk with that lock held so we iterate
+	 * very carefully:
+	 */
+next:
+	spin_lock_irqsave(&tracelock, flags);
+	list_for_each(curr, &held_locks) {
+		if (cursor && curr != cursor)
+			continue;
+		lock = list_entry(curr, struct rt_mutex, held_list);
+		t = rt_mutex_owner(lock);
+		if (filter && (t != filter))
+			continue;
+		count++;
+		cursor = curr->next;
+		spin_unlock_irqrestore(&tracelock, flags);
+
+		printk("\n#%03d:            ", count);
+		printk_lock(lock, filter ? 0 : 1);
+		goto next;
+	}
+	spin_unlock_irqrestore(&tracelock, flags);
+	printk("\n");
+}
+
+void rt_mutex_show_all_locks(void)
+{
+	task_t *g, *p;
+	int count = 10;
+	int unlock = 1;
+
+	printk("\nshowing all tasks:\n");
+
+	/*
+	 * Here we try to get the tasklist_lock as hard as possible,
+	 * if not successful after 2 seconds we ignore it (but keep
+	 * trying). This is to enable a debug printout even if a
+	 * tasklist_lock-holding task deadlocks or crashes.
+	 */
+retry:
+	if (!read_trylock(&tasklist_lock)) {
+		if (count == 10)
+			printk("hm, tasklist_lock locked, retrying... ");
+		if (count) {
+			count--;
+			printk(" #%d", 10-count);
+			mdelay(200);
+			goto retry;
+		}
+		printk(" ignoring it.\n");
+		unlock = 0;
+	}
+	if (count != 10)
+		printk(" locked it.\n");
+
+	do_each_thread(g, p) {
+		show_task_locks(p);
+		if (!unlock)
+			if (read_trylock(&tasklist_lock))
+				unlock = 1;
+	} while_each_thread(g, p);
+
+	printk("\n");
+	rt_mutex_show_held_locks(NULL);
+	printk("=============================================\n\n");
+
+	if (unlock)
+		read_unlock(&tasklist_lock);
+}
+
+void rt_mutex_debug_check_no_locks_held(task_t *task)
+{
+	struct list_head *curr, *next, *cursor = NULL;
+	struct rt_mutex *lock;
+	struct rt_mutex_waiter *w;
+	unsigned long flags;
+
+	if (!rt_trace_on)
+		return;
+	if (!rt_prio(task->normal_prio) && rt_prio(task->prio)) {
+		printk("BUG: PI priority boost leaked!\n");
+		printk_task(task);
+		printk("\n");
+	}
+restart:
+	spin_lock_irqsave(&tracelock, flags);
+	list_for_each_safe(curr, next, &held_locks) {
+		if (cursor && curr != cursor)
+			continue;
+		lock = list_entry(curr, struct rt_mutex, held_list);
+		if(task != rt_mutex_owner(lock))
+			continue;
+		cursor = next;
+		list_del_init(curr);
+		spin_unlock_irqrestore(&tracelock, flags);
+
+		printk("BUG: %s/%d, lock held at task exit time!\n",
+		       task->comm, task->pid);
+		printk_lock(lock, 1);
+		if (rt_mutex_owner(lock) != task)
+			printk("exiting task is not even the owner??\n");
+		goto restart;
+	}
+	spin_lock(&task->pi_lock);
+	plist_for_each_entry(w, &task->pi_waiters, pi_list_entry) {
+		TRACE_OFF();
+
+		printk("hm, PI interest held at exit time? Task:\n");
+		printk_task(task);
+		printk_waiter(w);
+		return;
+	}
+	spin_unlock(&task->pi_lock);
+	spin_unlock_irqrestore(&tracelock, flags);
+}
+
+int rt_mutex_debug_check_no_locks_freed(const void *from, unsigned long len)
+{
+	struct list_head *curr, *next, *cursor = NULL;
+	const void *to = from + len;
+	struct rt_mutex *lock;
+	unsigned long flags;
+	void *lock_addr;
+	int err = 0;
+
+	if (!rt_trace_on)
+		return err;
+restart:
+	spin_lock_irqsave(&tracelock, flags);
+	list_for_each_safe(curr, next, &held_locks) {
+		if (cursor && curr != cursor)
+			continue;
+		lock = list_entry(curr, struct rt_mutex, held_list);
+		lock_addr = lock;
+		if (lock_addr < from || lock_addr >= to)
+			continue;
+		cursor = next;
+		list_del_init(curr);
+		TRACE_OFF();
+		err = 1;
+
+		printk("BUG: %s/%d, active lock [%p(%p-%p)] freed!\n",
+			current->comm, current->pid, lock, from, to);
+		dump_stack();
+		printk_lock(lock, 1);
+		if (rt_mutex_owner(lock) != current)
+			printk("freeing task is not even the owner??\n");
+		goto restart;
+	}
+	spin_unlock_irqrestore(&tracelock, flags);
+
+	return err;
+}
+
+void rt_mutex_debug_task_free(struct task_struct *tsk)
+{
+	WARN_ON(!plist_head_empty(&tsk->pi_waiters));
+	WARN_ON(!list_empty(&tsk->pi_lock_chain));
+	WARN_ON(tsk->pi_blocked_on);
+	WARN_ON(tsk->pi_locked_by);
+}
+
+/*
+ * We fill out the fields in the waiter to store the information about
+ * the deadlock. We print when we return. act_waiter can be NULL in
+ * case of a remove waiter operation.
+ */
+void debug_rt_mutex_deadlock(int detect, struct rt_mutex_waiter *act_waiter,
+			     struct rt_mutex *lock)
+{
+	struct task_struct *task;
+
+	if (!rt_trace_on || detect || !act_waiter)
+		return;
+
+	task = rt_mutex_owner(act_waiter->lock);
+
+	act_waiter->deadlock_task_pid = task->pid;
+	act_waiter->deadlock_lock = lock;
+}
+
+void debug_rt_mutex_print_deadlock(struct rt_mutex_waiter *waiter)
+{
+	struct task_struct *task;
+
+	if (!waiter->deadlock_lock || !rt_trace_on)
+		return;
+
+	task = find_task_by_pid(waiter->deadlock_task_pid);
+	if (!task)
+		return;
+
+	TRACE_OFF_NOLOCK();
+
+	printk("\n============================================\n");
+	printk(  "[ BUG: circular locking deadlock detected! ]\n");
+	printk(  "--------------------------------------------\n");
+	printk("%s/%d is deadlocking current task %s/%d\n\n",
+	       task->comm, task->pid, current->comm, current->pid);
+
+	printk("\n1) %s/%d is trying to acquire this lock:\n",
+	       current->comm, current->pid);
+	printk_lock(waiter->lock, 1);
+
+	printk("... trying at:                 ");
+	print_symbol("%s\n", waiter->ip);
+
+	printk("\n2) %s/%d is blocked on this lock:\n", task->comm, task->pid);
+	printk_lock(waiter->deadlock_lock, 1);
+
+	rt_mutex_show_held_locks(current);
+	rt_mutex_show_held_locks(task);
+
+	printk("\n%s/%d's [blocked] stackdump:\n\n", task->comm, task->pid);
+	show_stack(task, NULL);
+	printk("\n%s/%d's [current] stackdump:\n\n",
+	       current->comm, current->pid);
+	dump_stack();
+	rt_mutex_show_all_locks();
+	printk("[ turning off deadlock detection."
+	       "Please report this trace. ]\n\n");
+	local_irq_disable();
+}
+
+void debug_rt_mutex_lock(struct rt_mutex *lock __IP_DECL__)
+{
+	unsigned long flags;
+
+	if (rt_trace_on) {
+		TRACE_WARN_ON_LOCKED(!list_empty(&lock->held_list));
+
+		spin_lock_irqsave(&tracelock, flags);
+		list_add_tail(&lock->held_list, &held_locks);
+		spin_unlock_irqrestore(&tracelock, flags);
+
+		lock->acquire_ip = ip;
+	}
+}
+
+void debug_rt_mutex_unlock(struct rt_mutex *lock)
+{
+	unsigned long flags;
+
+	if (rt_trace_on) {
+		TRACE_WARN_ON_LOCKED(rt_mutex_owner(lock) != current);
+		TRACE_WARN_ON_LOCKED(list_empty(&lock->held_list));
+
+		spin_lock_irqsave(&tracelock, flags);
+		list_del_init(&lock->held_list);
+		spin_unlock_irqrestore(&tracelock, flags);
+	}
+}
+
+void debug_rt_mutex_proxy_unlock(struct rt_mutex *lock)
+{
+	unsigned long flags;
+
+	if (rt_trace_on) {
+		TRACE_WARN_ON_LOCKED(!rt_mutex_owner(lock));
+		TRACE_WARN_ON_LOCKED(list_empty(&lock->held_list));
+
+		spin_lock_irqsave(&tracelock, flags);
+		list_del_init(&lock->held_list);
+		spin_unlock_irqrestore(&tracelock, flags);
+	}
+}
+
+void debug_rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
+{
+	memset(waiter, 0x11, sizeof(*waiter));
+	plist_node_init(&waiter->list_entry, MAX_PRIO);
+	plist_node_init(&waiter->pi_list_entry, MAX_PRIO);
+}
+
+void debug_rt_mutex_free_waiter(struct rt_mutex_waiter *waiter)
+{
+	TRACE_WARN_ON(!plist_node_empty(&waiter->list_entry));
+	TRACE_WARN_ON(!plist_node_empty(&waiter->pi_list_entry));
+	TRACE_WARN_ON(waiter->task);
+	memset(waiter, 0x22, sizeof(*waiter));
+}
+
+void debug_rt_mutex_init(struct rt_mutex *lock, const char *name)
+{
+	void *addr = lock;
+
+	if (rt_trace_on) {
+		rt_mutex_debug_check_no_locks_freed(addr,
+						    sizeof(struct rt_mutex));
+		INIT_LIST_HEAD(&lock->held_list);
+		lock->name = name;
+	}
+}
+
+void rt_mutex_deadlock_account_lock(struct rt_mutex *lock, task_t *task)
+{
+}
+
+void rt_mutex_deadlock_account_unlock(struct task_struct *task)
+{
+}
+
Index: linux-pi-futex.mm.q/kernel/rtmutex-debug.h
===================================================================
--- /dev/null
+++ linux-pi-futex.mm.q/kernel/rtmutex-debug.h
@@ -0,0 +1,32 @@
+/*
+ * RT-Mutexes: blocking mutual exclusion locks with PI support
+ *
+ * started by Ingo Molnar and Thomas Gleixner:
+ *
+ *  Copyright (C) 2004-2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ *  Copyright (C) 2006, Timesys Corp., Thomas Gleixner <tglx@timesys.com>
+ *
+ * This file contains macros used solely by rtmutex.c. Debug version.
+ */
+
+#include <linux/rtmutex_internal.h>
+
+#define __IP_DECL__		, unsigned long ip
+#define __IP__			, ip
+#define __RET_IP__		, (unsigned long)__builtin_return_address(0)
+
+extern void
+rt_mutex_deadlock_account_lock(struct rt_mutex *lock, struct task_struct *task);
+extern void rt_mutex_deadlock_account_unlock(struct task_struct *task);
+extern void debug_rt_mutex_init_waiter(struct rt_mutex_waiter *waiter);
+extern void debug_rt_mutex_free_waiter(struct rt_mutex_waiter *waiter);
+extern void debug_rt_mutex_init(struct rt_mutex *lock, const char *name);
+extern void debug_rt_mutex_lock(struct rt_mutex *lock __IP_DECL__);
+extern void debug_rt_mutex_unlock(struct rt_mutex *lock);
+extern void debug_rt_mutex_proxy_unlock(struct rt_mutex *lock);
+extern void debug_rt_mutex_deadlock(int detect, struct rt_mutex_waiter *waiter,
+				    struct rt_mutex *lock);
+extern void debug_rt_mutex_print_deadlock(struct rt_mutex_waiter *waiter);
+# define debug_rt_mutex_detect_deadlock(d)		(1)
+# define debug_rt_mutex_reset_waiter(w)			\
+	do { (w)->deadlock_lock = NULL; } while (0)
Index: linux-pi-futex.mm.q/lib/Kconfig.debug
===================================================================
--- linux-pi-futex.mm.q.orig/lib/Kconfig.debug
+++ linux-pi-futex.mm.q/lib/Kconfig.debug
@@ -121,6 +121,19 @@ config DEBUG_MUTEXES
 	 This allows mutex semantics violations and mutex related deadlocks
 	 (lockups) to be detected and reported automatically.
 
+config DEBUG_RT_MUTEXES
+	bool "RT Mutex debugging, deadlock detection"
+	default y
+	depends on DEBUG_KERNEL && RT_MUTEXES
+	help
+	 This allows rt mutex semantics violations and rt mutex related
+	 deadlocks (lockups) to be detected and reported automatically.
+
+config DEBUG_PI_LIST
+	bool
+	default y
+	depends on DEBUG_RT_MUTEXES
+
 config DEBUG_SPINLOCK
 	bool "Spinlock debugging"
 	depends on DEBUG_KERNEL
Index: linux-pi-futex.mm.q/mm/slab.c
===================================================================
--- linux-pi-futex.mm.q.orig/mm/slab.c
+++ linux-pi-futex.mm.q/mm/slab.c
@@ -106,6 +106,7 @@
 #include	<linux/nodemask.h>
 #include	<linux/mempolicy.h>
 #include	<linux/mutex.h>
+#include	<linux/rtmutex.h>
 
 #include	<asm/uaccess.h>
 #include	<asm/cacheflush.h>
