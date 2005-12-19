Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbVLSBih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbVLSBih (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 20:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbVLSBig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 20:38:36 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:27109 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030222AbVLSBif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 20:38:35 -0500
Date: Mon, 19 Dec 2005 02:37:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Paul Jackson <pj@sgi.com>
Subject: [patch 06/15] Generic Mutex Subsystem, mutex-debug.patch
Message-ID: <20051219013753.GB28038@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.7 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


mutex implementation - add debugging code.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 kernel/mutex-debug.c |  444 +++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug    |    8 
 2 files changed, 452 insertions(+)

Index: linux/kernel/mutex-debug.c
===================================================================
--- /dev/null
+++ linux/kernel/mutex-debug.c
@@ -0,0 +1,444 @@
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
+ * deadlock detection flag. We turn it off when we detect
+ * the first problem because we dont want to recurse back
+ * into the tracing code when doing error printk or
+ * executing a BUG():
+ */
+static int debug_on = 1;
+
+#define debug_lock_irq(lock, ti)			\
+	do {						\
+		(void)(ti);				\
+		local_irq_disable();			\
+		if (debug_on)				\
+			spin_lock(lock);		\
+	} while (0)
+
+#define debug_unlock(lock, ti)				\
+	do {						\
+		(void)(ti);				\
+		if (debug_on)				\
+			spin_unlock(lock);		\
+	} while (0)
+
+#define debug_unlock_irq(lock, ti)			\
+	do {						\
+		(void)(ti);				\
+		if (debug_on)				\
+			spin_unlock(lock);		\
+		local_irq_enable();			\
+		preempt_check_resched();		\
+	} while (0)
+
+#define debug_lock_irqsave(lock, flags, ti)		\
+	do {						\
+		(void)(ti);				\
+		local_irq_save(flags);			\
+		if (debug_on)				\
+			spin_lock(lock);		\
+	} while (0)
+
+#define debug_unlock_irqrestore(lock, flags, ti)	\
+	do {						\
+		(void)(ti);				\
+		if (debug_on)				\
+			spin_unlock(lock);		\
+		local_irq_restore(flags);		\
+		preempt_check_resched();		\
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
+# define debug_local_irq_disable(ti)		local_irq_disable()
+# define debug_local_irq_enable(ti)		local_irq_enable()
+# define debug_local_irq_restore(flags, ti)	local_irq_restore(flags)
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
+	if (lock->name)
+		printk(" [%p] {%s}\n",
+			lock, lock->name);
+	else
+		printk(" [%p] {%s:%d}\n",
+			lock, lock->file, lock->line);
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
+	struct thread_info *ti = current_thread_info();
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
+	debug_lock_irqsave(&debug_lock, flags, ti);
+	list_for_each(curr, &held_locks) {
+		if (cursor && curr != cursor)
+			continue;
+		lock = list_entry(curr, struct mutex, held_list);
+		t = lock->owner;
+		if (filter && (t != filter->thread_info))
+			continue;
+		count++;
+		cursor = curr->next;
+		debug_unlock_irqrestore(&debug_lock, flags, ti);
+
+		printk("\n#%03d:            ", count);
+		printk_lock(lock, filter ? 0 : 1);
+		goto next;
+	}
+	debug_unlock_irqrestore(&debug_lock, flags, ti);
+	printk("\n");
+}
+
+void show_all_locks(void)
+{
+	struct task_struct *g, *p;
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
+	show_held_locks(NULL);
+	printk("=============================================\n\n");
+
+	if (unlock)
+		read_unlock(&tasklist_lock);
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
+	task = ti->task;
+	lockblk = NULL;
+	if (task->blocked_on)
+		lockblk = task->blocked_on->lock;
+	if (current == task) {
+		DEBUG_OFF();
+		if (depth)
+			return 1;
+		printk("\n==========================================\n");
+		printk(  "[ BUG: lock recursion deadlock detected! |\n");
+		printk(  "------------------------------------------\n");
+		printk("already locked: ");
+		printk_lock(lock, 1);
+		show_held_locks(task);
+		printk("-{current task's backtrace}----------------->\n");
+		dump_stack();
+		show_all_locks();
+		printk("[ turning off deadlock detection. Please report this trace. ]\n\n");
+		debug_local_irq_disable(ti);
+		return 0;
+	}
+	/*
+	 * Ugh, something corrupted the lock data structure?
+	 */
+	if (depth > 20) {
+		DEBUG_OFF();
+		printk("\n===========================================\n");
+		printk(  "[ BUG: infinite lock dependency detected!? |\n");
+		printk(  "-------------------------------------------\n");
+		goto print_it;
+	}
+	barrier();
+	if (lockblk && check_deadlock(lockblk, depth+1, ti, ip)) {
+		printk("\n============================================\n");
+		printk(  "[ BUG: circular locking deadlock detected! ]\n");
+		printk(  "--------------------------------------------\n");
+print_it:
+		printk("%s/%d is deadlocking current task %s/%d\n\n",
+			task->comm, task->pid, current->comm, current->pid);
+		printk("\n1) %s/%d is trying to acquire this lock:\n",
+			current->comm, current->pid);
+		printk_lock(lock, 1);
+
+		printk("... trying at:                 ");
+		print_symbol("%s\n", ip);
+
+		printk("\n2) %s/%d is blocked on this lock:\n",
+			task->comm, task->pid);
+		printk_lock(lockblk, 1);
+
+		show_held_locks(current);
+		show_held_locks(task);
+
+		printk("\n%s/%d's [blocked] stackdump:\n\n",
+			task->comm, task->pid);
+		show_stack(task, NULL);
+		printk("\n%s/%d's [current] stackdump:\n\n",
+			current->comm, current->pid);
+		dump_stack();
+		show_all_locks();
+		printk("[ turning off deadlock detection. Please report this trace. ]\n\n");
+		debug_local_irq_disable(ti);
+		return 0;
+	}
+	return 0;
+}
+
+void check_no_held_locks(struct task_struct *task)
+{
+	struct list_head *curr, *next, *cursor = NULL;
+	struct thread_info *ti = task->thread_info;
+	struct thread_info *t;
+	unsigned long flags;
+	struct mutex *lock;
+
+restart:
+	if (!debug_on)
+		return;
+	debug_lock_irqsave(&debug_lock, flags, ti);
+	list_for_each_safe(curr, next, &held_locks) {
+		if (cursor && curr != cursor)
+			continue;
+		lock = list_entry(curr, struct mutex, held_list);
+		t = lock->owner;
+		if (t != task->thread_info)
+			continue;
+		cursor = next;
+		list_del_init(curr);
+		DEBUG_OFF();
+		debug_unlock_irqrestore(&debug_lock, flags, ti);
+
+		printk("BUG: %s/%d, lock held at task exit time!\n",
+			task->comm, task->pid);
+		printk_lock(lock, 1);
+		if (lock->owner != task->thread_info)
+			printk("exiting task is not even the owner??\n");
+		goto restart;
+	}
+	debug_unlock_irqrestore(&debug_lock, flags, ti);
+}
+
+int check_no_locks_freed(const void *from, const void *to)
+{
+	struct thread_info *ti = current_thread_info();
+	struct list_head *curr, *next, *cursor = NULL;
+	struct mutex *lock;
+	unsigned long flags;
+	void *lock_addr;
+	int err = 0;
+
+	if (!debug_on)
+		return err;
+restart:
+	debug_lock_irqsave(&debug_lock, flags, ti);
+	list_for_each_safe(curr, next, &held_locks) {
+		if (cursor && curr != cursor)
+			continue;
+		lock = list_entry(curr, struct mutex, held_list);
+		lock_addr = lock;
+		if (lock_addr < from || lock_addr >= to)
+			continue;
+		cursor = next;
+		list_del_init(curr);
+		DEBUG_OFF();
+		debug_unlock_irqrestore(&debug_lock, flags, ti);
+		err = 1;
+
+		printk("BUG: %s/%d, active lock [%p(%p-%p)] freed!\n",
+			current->comm, current->pid, lock, from, to);
+		dump_stack();
+		printk_lock(lock, 1);
+		if (lock->owner != current_thread_info())
+			printk("freeing task is not even the owner??\n");
+		goto restart;
+	}
+	debug_unlock_irqrestore(&debug_lock, flags, ti);
+
+	return err;
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
+/*
+ * Initialize/destruct the waiter structure, and poison it when debugging:
+ */
+static inline void debug_init_waiter(struct mutex_waiter *waiter)
+{
+	memset(waiter, 0x11, sizeof(*waiter));
+	waiter->magic = waiter;
+}
+
+static inline void debug_free_waiter(struct mutex_waiter *waiter)
+{
+	DEBUG_WARN_ON(!list_empty(&waiter->list));
+	memset(waiter, 0x22, sizeof(*waiter));
+}
Index: linux/lib/Kconfig.debug
===================================================================
--- linux.orig/lib/Kconfig.debug
+++ linux/lib/Kconfig.debug
@@ -95,6 +95,14 @@ config DEBUG_PREEMPT
 	  if kernel code uses it in a preemption-unsafe way. Also, the kernel
 	  will detect preemption count underflows.
 
+config DEBUG_MUTEXESS
+        bool "Mutex debugging, deadlock detection"
+        default y
+	depends on !DEBUG_MUTEX_NONE
+        help
+	 This allows mutex semantics violations and mutex related deadlocks
+	 (lockups) to be detected and reported automatically.
+
 config DEBUG_SPINLOCK
 	bool "Spinlock debugging"
 	depends on DEBUG_KERNEL
