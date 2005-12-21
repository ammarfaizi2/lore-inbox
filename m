Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbVLUP4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbVLUP4X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 10:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbVLUP4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 10:56:21 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:28077 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932456AbVLUPz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 10:55:56 -0500
Date: Wed, 21 Dec 2005 16:55:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>
Subject: [patch 7/8] mutex subsystem, debugging code
Message-ID: <20051221155510.GH7243@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mutex implementation - add debugging code.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 include/linux/mutex-debug.h |   19 +
 include/linux/sched.h       |    5 
 kernel/fork.c               |    4 
 kernel/mutex-debug.c        |  509 ++++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug           |    8 
 5 files changed, 545 insertions(+)

Index: linux/include/linux/mutex-debug.h
===================================================================
--- /dev/null
+++ linux/include/linux/mutex-debug.h
@@ -0,0 +1,19 @@
+#ifndef __LINUX_MUTEX_DEBUG_H
+#define __LINUX_MUTEX_DEBUG_H
+
+/*
+ * Mutexes - debugging helpers:
+ */
+
+#define __DEBUG_MUTEX_INITIALIZER(lockname) \
+	, .held_list = LIST_HEAD_INIT(lockname.held_list), \
+	  .name = #lockname , .magic = &lockname
+
+#define mutex_init(sem)		__mutex_init(sem, __FUNCTION__)
+
+extern void mutex_debug_show_all_locks(void);
+extern void mutex_debug_show_held_locks(struct task_struct *filter);
+extern void mutex_debug_check_no_locks_held(struct task_struct *task);
+extern void mutex_debug_check_no_locks_freed(const void *from, const void *to);
+
+#endif
Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h
+++ linux/include/linux/sched.h
@@ -820,6 +820,11 @@ struct task_struct {
 /* Protection of proc_dentry: nesting proc_lock, dcache_lock, write_lock_irq(&tasklist_lock); */
 	spinlock_t proc_lock;
 
+#ifdef CONFIG_DEBUG_MUTEXES
+	/* mutex deadlock detection */
+	struct mutex_waiter *blocked_on;
+#endif
+
 /* journalling filesystem info */
 	void *journal_info;
 
Index: linux/kernel/fork.c
===================================================================
--- linux.orig/kernel/fork.c
+++ linux/kernel/fork.c
@@ -973,6 +973,10 @@ static task_t *copy_process(unsigned lon
  	}
 #endif
 
+#ifdef CONFIG_DEBUG_MUTEXES
+	p->blocked_on = NULL; /* not blocked yet */
+#endif
+
 	p->tgid = p->pid;
 	if (clone_flags & CLONE_THREAD)
 		p->tgid = current->tgid;
Index: linux/kernel/mutex-debug.c
===================================================================
--- /dev/null
+++ linux/kernel/mutex-debug.c
@@ -0,0 +1,509 @@
+/*
+ * kernel/mutex-debug.c
+ *
+ * Debugging code for mutexes
+ *
+ * Started by Ingo Molnar:
+ *
+ *  Copyright (C) 2004, 2005 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ *
+ * lock debugging, locking tree, deadlock detection started by:
+ *
+ *  Copyright (C) 2004, LynuxWorks, Inc., Igor Manyilov, Bill Huey
+ *  Released under the General Public License (GPL).
+ */
+
+/*
+ * We need a global lock when we walk through the multi-process
+ * lock tree. Only used in the deadlock-debugging case.
+ */
+static DEFINE_SPINLOCK(debug_lock);
+
+static LIST_HEAD(held_locks);
+
+/*
+ * In the debug case we carry the caller's instruction pointer into
+ * other functions, but we dont want the function argument overhead
+ * in the nondebug case - hence these macros:
+ */
+#define __IP_DECL__		, unsigned long ip
+#define __IP__			, ip
+#define __CALLER_IP__		, (unsigned long)__builtin_return_address(0)
+
+/*
+ * deadlock detection flag. We turn it off when we detect
+ * the first problem because we dont want to recurse back
+ * into the tracing code when doing error printk or
+ * executing a BUG():
+ */
+static int debug_on = 1;
+
+#define debug_spin_lock(lock)				\
+	do {						\
+		local_irq_disable();			\
+		if (debug_on)				\
+			spin_lock(lock);		\
+	} while (0)
+
+#define debug_spin_unlock(lock)				\
+	do {						\
+		if (debug_on)				\
+			spin_unlock(lock);		\
+		local_irq_enable();			\
+		preempt_check_resched();		\
+	} while (0)
+
+#define debug_spin_lock_save(lock, flags)		\
+	do {						\
+		local_irq_save(flags);			\
+		if (debug_on)				\
+			spin_lock(lock);		\
+	} while (0)
+
+#define debug_spin_lock_restore(lock, flags)		\
+	do {						\
+		if (debug_on)				\
+			spin_unlock(lock);		\
+		local_irq_restore(flags);		\
+		preempt_check_resched();		\
+	} while (0)
+
+#define spin_lock_mutex(lock)				\
+	do {						\
+		struct mutex *l = container_of(lock, struct mutex, wait_lock); \
+							\
+		DEBUG_WARN_ON(in_interrupt());		\
+		debug_spin_lock(&debug_lock);		\
+		spin_lock(lock);			\
+		DEBUG_WARN_ON(l->magic != lock);	\
+	} while (0)
+
+#define spin_unlock_mutex(lock)				\
+	do {						\
+		spin_unlock(lock);			\
+		debug_spin_unlock(&debug_lock);		\
+	} while (0)
+
+#define DEBUG_OFF()					\
+do {							\
+	if (debug_on) {					\
+		debug_on = 0;				\
+		console_verbose();			\
+		if (spin_is_locked(&debug_lock))	\
+			spin_unlock(&debug_lock); 	\
+	}						\
+} while (0)
+
+#define DEBUG_BUG()					\
+do {							\
+	if (debug_on) {					\
+		DEBUG_OFF();				\
+		BUG();					\
+	}						\
+} while (0)
+
+#define DEBUG_WARN_ON(c)				\
+do {							\
+	if (unlikely(c && debug_on)) {			\
+		DEBUG_OFF();				\
+		WARN_ON(1);				\
+	}						\
+} while (0)
+
+# define DEBUG_BUG_ON(c)				\
+do {							\
+	if (unlikely(c))				\
+		DEBUG_BUG();				\
+} while (0)
+
+#ifdef CONFIG_SMP
+# define SMP_DEBUG_WARN_ON(c)			DEBUG_WARN_ON(c)
+# define SMP_DEBUG_BUG_ON(c)			DEBUG_BUG_ON(c)
+#else
+# define SMP_DEBUG_WARN_ON(c)			do { } while (0)
+# define SMP_DEBUG_BUG_ON(c)			do { } while (0)
+#endif
+
+static void printk_task(struct task_struct *p)
+{
+	if (p)
+		printk("%16s:%5d [%p, %3d]", p->comm, p->pid, p, p->prio);
+	else
+		printk("<none>");
+}
+
+static void printk_ti(struct thread_info *ti)
+{
+	if (ti)
+		printk_task(ti->task);
+	else
+		printk("<none>");
+}
+
+static void printk_task_short(struct task_struct *p)
+{
+	if (p)
+		printk("%s/%d [%p, %3d]", p->comm, p->pid, p, p->prio);
+	else
+		printk("<none>");
+}
+
+static void printk_lock(struct mutex *lock, int print_owner)
+{
+	printk(" [%p] {%s}\n", lock, lock->name);
+
+	if (print_owner && lock->owner) {
+		printk(".. held by:  ");
+		printk_ti(lock->owner);
+		printk("\n");
+	}
+	if (lock->owner) {
+		printk("... acquired at:               ");
+		print_symbol("%s\n", lock->acquire_ip);
+	}
+}
+
+static void show_task_locks(struct task_struct *p)
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
+	if (p->blocked_on) {
+		struct mutex *lock = p->blocked_on->lock;
+
+		printk(" blocked on mutex:");
+		printk_lock(lock, 1);
+	} else
+		printk(" (not blocked on mutex)\n");
+}
+
+void show_held_locks(struct task_struct *filter)
+{
+	struct list_head *curr, *cursor = NULL;
+	struct mutex *lock;
+	struct thread_info *t;
+	unsigned long flags;
+	int count = 0;
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
+	debug_spin_lock_save(&debug_lock, flags);
+	list_for_each(curr, &held_locks) {
+		if (cursor && curr != cursor)
+			continue;
+		lock = list_entry(curr, struct mutex, held_list);
+		t = lock->owner;
+		if (filter && (t != filter->thread_info))
+			continue;
+		count++;
+		cursor = curr->next;
+		debug_spin_lock_restore(&debug_lock, flags);
+
+		printk("\n#%03d:            ", count);
+		printk_lock(lock, filter ? 0 : 1);
+		goto next;
+	}
+	debug_spin_lock_restore(&debug_lock, flags);
+	printk("\n");
+}
+
+void mutex_debug_show_all_locks(void)
+{
+	struct task_struct *g, *p;
+	int count = 10;
+	int unlock = 1;
+
+	printk("\nShowing all blocking locks in the system:\n");
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
+	show_held_locks(NULL);
+	printk("=============================================\n\n");
+
+	if (unlock)
+		read_unlock(&tasklist_lock);
+}
+
+static void report_deadlock(struct task_struct *task, struct mutex *lock,
+			    struct mutex *lockblk, unsigned long ip)
+{
+	printk("\n%s/%d is trying to acquire this lock:\n",
+		current->comm, current->pid);
+	printk_lock(lock, 1);
+	printk("... trying at:                 ");
+	print_symbol("%s\n", ip);
+	show_held_locks(current);
+
+	if (lockblk) {
+		printk("but %s/%d is deadlocking current task %s/%d!\n\n",
+			task->comm, task->pid, current->comm, current->pid);
+		printk("\n%s/%d is blocked on this lock:\n",
+			task->comm, task->pid);
+		printk_lock(lockblk, 1);
+
+		show_held_locks(task);
+
+		printk("\n%s/%d's [blocked] stackdump:\n\n",
+			task->comm, task->pid);
+		show_stack(task, NULL);
+	}
+
+	printk("\n%s/%d's [current] stackdump:\n\n",
+		current->comm, current->pid);
+	dump_stack();
+	mutex_debug_show_all_locks();
+	printk("[ turning off deadlock detection. Please report this. ]\n\n");
+	local_irq_disable();
+}
+
+static int check_deadlock(struct mutex *lock, int depth,
+			  struct thread_info *ti, unsigned long ip)
+{
+	struct mutex *lockblk;
+	struct task_struct *task;
+
+	if (!debug_on)
+		return 0;
+
+	ti = lock->owner;
+	if (!ti)
+		return 0;
+
+	task = ti->task;
+	lockblk = NULL;
+	if (task->blocked_on)
+		lockblk = task->blocked_on->lock;
+
+	/* Self-deadlock: */
+	if (current == task) {
+		DEBUG_OFF();
+		if (depth)
+			return 1;
+		printk("\n==========================================\n");
+		printk(  "[ BUG: lock recursion deadlock detected! |\n");
+		printk(  "------------------------------------------\n");
+		report_deadlock(task, lock, NULL, ip);
+		return 0;
+	}
+
+	/* Ugh, something corrupted the lock data structure? */
+	if (depth > 20) {
+		DEBUG_OFF();
+		printk("\n===========================================\n");
+		printk(  "[ BUG: infinite lock dependency detected!? |\n");
+		printk(  "-------------------------------------------\n");
+		report_deadlock(task, lock, lockblk, ip);
+		return 0;
+	}
+
+	/* Recursively check for dependencies: */
+	if (lockblk && check_deadlock(lockblk, depth+1, ti, ip)) {
+		printk("\n============================================\n");
+		printk(  "[ BUG: circular locking deadlock detected! ]\n");
+		printk(  "--------------------------------------------\n");
+		report_deadlock(task, lock, lockblk, ip);
+		return 0;
+	}
+	return 0;
+}
+
+void mutex_debug_check_no_locks_held(struct task_struct *task)
+{
+	struct list_head *curr, *next;
+	struct thread_info *t;
+	unsigned long flags;
+	struct mutex *lock;
+
+	if (!debug_on)
+		return;
+
+	debug_spin_lock_save(&debug_lock, flags);
+	list_for_each_safe(curr, next, &held_locks) {
+		lock = list_entry(curr, struct mutex, held_list);
+		t = lock->owner;
+		if (t != task->thread_info)
+			continue;
+		list_del_init(curr);
+		DEBUG_OFF();
+		debug_spin_lock_restore(&debug_lock, flags);
+
+		printk("BUG: %s/%d, lock held at task exit time!\n",
+			task->comm, task->pid);
+		printk_lock(lock, 1);
+		if (lock->owner != task->thread_info)
+			printk("exiting task is not even the owner??\n");
+		return;
+	}
+	debug_spin_lock_restore(&debug_lock, flags);
+}
+
+void mutex_debug_check_no_locks_freed(const void *from, const void *to)
+{
+	struct list_head *curr, *next;
+	struct mutex *lock;
+	unsigned long flags;
+	void *lock_addr;
+
+	if (!debug_on)
+		return;
+
+	debug_spin_lock_save(&debug_lock, flags);
+	list_for_each_safe(curr, next, &held_locks) {
+		lock = list_entry(curr, struct mutex, held_list);
+		lock_addr = lock;
+		if (lock_addr < from || lock_addr >= to)
+			continue;
+		list_del_init(curr);
+		DEBUG_OFF();
+		debug_spin_lock_restore(&debug_lock, flags);
+
+		printk("BUG: %s/%d, active lock [%p(%p-%p)] freed!\n",
+			current->comm, current->pid, lock, from, to);
+		dump_stack();
+		printk_lock(lock, 1);
+		if (lock->owner != current_thread_info())
+			printk("freeing task is not even the owner??\n");
+		return;
+	}
+	debug_spin_lock_restore(&debug_lock, flags);
+}
+
+/*
+ * This must be called with lock->wait_lock held.
+ */
+static inline void
+debug_set_owner(struct mutex *lock, struct thread_info *new_owner __IP_DECL__)
+{
+	lock->owner = new_owner;
+	if (debug_on) {
+		DEBUG_WARN_ON(!list_empty(&lock->held_list));
+		list_add_tail(&lock->held_list, &held_locks);
+		lock->acquire_ip = ip;
+	}
+}
+
+static inline void debug_clear_owner(struct mutex *lock)
+{
+	lock->owner = NULL;
+}
+
+/*
+ * Initialize/destruct the waiter structure, and poison it when debugging:
+ */
+static inline void debug_init_waiter(struct mutex_waiter *waiter)
+{
+	memset(waiter, 0x11, sizeof(*waiter));
+	waiter->magic = waiter;
+}
+
+
+static inline void
+debug_wake_waiter(struct mutex *lock, struct mutex_waiter *waiter)
+{
+	SMP_DEBUG_WARN_ON(!spin_is_locked(&lock->wait_lock));
+	DEBUG_WARN_ON(list_empty(&lock->wait_list));
+	DEBUG_WARN_ON(waiter->magic != waiter);
+	DEBUG_WARN_ON(list_empty(&waiter->list));
+}
+
+static inline void debug_free_waiter(struct mutex_waiter *waiter)
+{
+	DEBUG_WARN_ON(!list_empty(&waiter->list));
+	memset(waiter, 0x22, sizeof(*waiter));
+}
+
+static void
+debug_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
+		 struct thread_info *ti __IP_DECL__)
+{
+	debug_init_waiter(waiter);
+	SMP_DEBUG_WARN_ON(!spin_is_locked(&lock->wait_lock));
+	check_deadlock(lock, 0, ti, ip);
+	/* Mark the current thread as blocked on the lock: */
+	ti->task->blocked_on = waiter;
+}
+
+static void
+debug_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
+		    struct thread_info *ti)
+{
+	DEBUG_WARN_ON(list_empty(&waiter->list));
+	DEBUG_WARN_ON(waiter->ti != ti);
+	DEBUG_WARN_ON(ti->task->blocked_on != waiter);
+	ti->task->blocked_on = NULL;
+}
+
+static inline void debug_mutex_unlock(struct mutex *lock)
+{
+	DEBUG_WARN_ON(lock->magic != lock);
+	DEBUG_WARN_ON(!lock->wait_list.prev && !lock->wait_list.next);
+	DEBUG_WARN_ON(lock->owner != current_thread_info());
+	if (debug_on) {
+		DEBUG_WARN_ON(list_empty(&lock->held_list));
+		list_del_init(&lock->held_list);
+	}
+}
+
+static inline void debug_mutex_init(struct mutex *lock, const char *name)
+{
+	/*
+	 * Make sure we are not reinitializing a held lock:
+	 */
+	mutex_debug_check_no_locks_freed((void *)lock, (void *)(lock + 1));
+	lock->owner = NULL;
+	INIT_LIST_HEAD(&lock->held_list);
+	lock->name = name;
+	lock->magic = lock;
+}
+
Index: linux/lib/Kconfig.debug
===================================================================
--- linux.orig/lib/Kconfig.debug
+++ linux/lib/Kconfig.debug
@@ -95,6 +95,14 @@ config DEBUG_PREEMPT
 	  if kernel code uses it in a preemption-unsafe way. Also, the kernel
 	  will detect preemption count underflows.
 
+config DEBUG_MUTEXES
+	bool "Mutex debugging, deadlock detection"
+	default y
+	depends on DEBUG_KERNEL
+	help
+	 This allows mutex semantics violations and mutex related deadlocks
+	 (lockups) to be detected and reported automatically.
+
 config DEBUG_SPINLOCK
 	bool "Spinlock debugging"
 	depends on DEBUG_KERNEL
