Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264721AbUDUEIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264721AbUDUEIA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 00:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264735AbUDUEGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 00:06:08 -0400
Received: from ip-66-80-228-130.sjc.megapath.net ([66.80.228.130]:29427 "EHLO
	sodium.co.intel.com") by vger.kernel.org with ESMTP id S264706AbUDUD6m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 23:58:42 -0400
Date: Tue, 20 Apr 2004 21:04:01 -0700
From: inaky.perez-gonzalez@intel.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com
Subject: [RFC/PATCH] FUSYN 7/11: kernel fuqueues
Message-ID: <0404202104.nd0drbFdjbkb.a4a~ctckaAb9aZd9b8a1457@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0404202103.udQb1ctb~bBbHc8cVa0b0cwamc~a6aJc1457@intel.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 include/linux/fuqueue.h |  468 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/plist.h   |  202 ++++++++++++++++++++
 kernel/fuqueue.c        |  209 +++++++++++++++++++++
 3 files changed, 879 insertions(+)

--- /dev/null	Thu Apr 15 00:58:25 2004
+++ include/linux/fuqueue.h Tue Apr 6 02:29:42 2004
@@ -0,0 +1,468 @@
+
+/*
+ * Fast User real-time/pi/pp/robust/deadlock SYNchronization
+ * (C) 2002-2003 Intel Corp
+ * Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>.
+ *
+ * Licensed under the FSF's GNU Public License v2 or later.
+ *
+ * Based on normal futexes (futex.c), (C) Rusty Russell.
+ * Please refer to Documentation/fusyn.txt for more info.
+ *
+ * Quick usage guide:
+ *
+ * struct fuqueue f = fuqueue_INIT (&f);
+ *
+ * fuqueue_wait (&f, 4343)	Wait for max 4343 jiffies
+ * fuqueue_wake (&f, 5, -EPERM) Wake the first five guys waiting on f
+ *				with -EPERM.
+ *
+ * These are simple priority-sorted wait queues that can be used from
+ * the kernel. They provide the foundation for more complex items
+ * (fulocks, fuconds, ufulocks, ufuconds) and use from user-space
+ * (ufuqueues, just like futexes).
+ *
+ * The type wlist_t provides the sorting for the wait list. The type
+ * 'struct fuqueue_waiter' represents a waiting task on a fuqueue. The
+ * 'struct fuqueue_ops' is what allows extensibility for other
+ * synchronization primitives.
+ *
+ * I have just realized that this is too similar to the wait_queues...
+ */
+
+#ifndef __linux_fuqueue_h__
+#define __linux_fuqueue_h__
+
+#ifdef __KERNEL__
+
+#include <linux/errno.h>
+#include <linux/spinlock.h>
+#include <linux/plist.h>
+#include <linux/sched.h>
+#include <asm/hardirq.h>
+
+  /*
+   * Debug stuff -- move forward for seeing the real meat
+   * 
+   * Levels
+   * 
+   *   0 Nothing activated, all compiled out
+   * > 0 Activates assertions, memory allocation tracking
+   * > 1 Activates debug messages
+   * > 2 Activates [most] function traces
+   * > 3 Activates random debug stuff
+   */
+
+#undef DEBUG
+#define DEBUG 0
+
+#if DEBUG > 0
+#if 0 || !defined(__i386__)
+#define __debug_printstr(a...) printk(a)	/* Dump to normal console */
+#else						/* Dump straight to ttyS0 */
+#include <linux/serial_reg.h>
+#include <linux/stringify.h>
+static inline void __debug_outb (unsigned val, int port) {
+	__asm__ __volatile__ ("outb %b0,%w1" : : "a" (val), "Nd" (port));
+}
+static inline unsigned __debug_inb (int port) {
+	unsigned value;
+	__asm__ __volatile__ ("inb %w1,%b0" : "=a" (value) : "Nd" (port));
+	return value;
+}
+static inline
+void __debug_printstr (const char *str) {
+	const int port = 0x03f8;  
+	while (*str) {
+		while (!(__debug_inb (port + UART_LSR) & UART_LSR_THRE));
+		__debug_outb (*str++, port+UART_TX);
+	}
+	__debug_outb ('\r', port + UART_TX);
+}
+#endif
+
+extern spinlock_t __debug_lock;
+
+static inline
+u64 __tsc_read (void)
+{
+	u64 tsc;
+#if defined(__i386__)
+	__asm__ __volatile__("rdtsc" : "=A" (tsc));
+#elif defined (__ia64__)
+	__asm__ __volatile__("mov %0=ar.itc" : "=r" (tsc) : : "memory");
+#else
+#warning "Architecture not supported in __tsc_read()!"
+	tsc = 0;
+#endif
+	return tsc;
+}
+
+#define __debug(a...)							\
+do {									\
+	/* Dirty: Try to avoid >1 CPUs printing ... will suck */	\
+	char __X_buf[256];						\
+	unsigned __X_len;						\
+	unsigned long __X_flags;					\
+	__X_len = snprintf (__X_buf, 255, "%Lu: %s:%d: %s[%d:%d] ",	\
+			__tsc_read(), __FILE__, __LINE__, __FUNCTION__,	\
+			current->pid, current->thread_info->cpu);	\
+	snprintf (__X_buf + __X_len, 255 - __X_len, a);			\
+	spin_lock_irqsave (&__debug_lock, __X_flags);			\
+	__debug_printstr (__X_buf);					\
+	spin_unlock_irqrestore (&__debug_lock, __X_flags);		\
+} while (0)
+#endif /* #if DEBUG > 0 */
+
+/* The real debug statements */
+
+#if DEBUG > 0
+#define ldebug(l,a...)	 do { if (DEBUG >= l) __debug (a); } while (0)
+#define debug(a...)	 ldebug(1,a)
+#define fdebug(f, a...)	 do { if ((DEBUG >= 2) && f) __debug (a); } while (0)
+#define __ftrace(l,a...) do { if ((l)) __debug (a); } while (0)
+#define ftrace(a...)	 __ftrace((DEBUG >= 2),a)
+#define assert(c, a...)	 do { if ((DEBUG >= 0) && !(c)) BUG(); } while (0)
+#else
+#define ldebug(l,a...)	 
+#define debug(a...)	 
+#define fdebug(f, a...)	 
+#define __ftrace(l,a...) 
+#define ftrace(a...)	 
+#define assert(c, a...)	 
+#endif
+
+
+
+
+/**
+ * Wait list type, O(N) addition, O(1) removal
+ *
+ * This is just a redirection of the methods used to manage the list
+ * of waiters that are waiting for a fuqueue. For hardcore-timing
+ * applications, you might want to use a PALIST instead of a PLIST,
+ * but FIXME, it is not done yet :)
+ */
+
+typedef struct plist wlist_t;
+
+#define FULOCK_WLIST_USE_PLIST
+#ifdef FULOCK_WLIST_USE_PLIST
+#define wlist_add plist_add
+#define wlist_rem plist_rem
+#define __wlist_rem __plist_rem
+#define wlist_first plist_first
+#define wlist_empty plist_empty
+#define wlist_INIT plist_INIT
+#define wlist_init plist_init
+#define wlist_last plist_last
+#define wlist_update_prio plist_update_prio
+#define wlist_prio plist_prio
+#define wlist_chprio plist_chprio
+#define __wlist_chprio __plist_chprio
+#if 0
+#define wlist_for_each_safe plist_for_each_safe
+#endif
+#endif
+
+struct task_struct;
+struct fuqueue;
+
+/** Descriptor of a waiting task */
+struct fuqueue_waiter {
+	wlist_t wlist_node;		/* node for the wait list */
+	struct task_struct *task;	/* task that is waiting */
+	int result;			/* what happened */
+};
+
+/**
+ * Operations on a fuqueue.
+ *
+ * FIXME: is it worth to have get/put? maybe they should be enforced
+ *        for every fuqueue, this way we don't have to query the ops
+ *        structure for the get/put method and if it is there, call
+ *        it. We'd have to move the get/put ops over to the vlocator,
+ *        but that's not much of a problem.
+ *
+ *        The decission factor is that an atomic operation needs to
+ *        lock the whole bus and is not as scalable as testing a ptr
+ *        for NULLness.
+ *
+ *        For simplicity, probably the idea of forcing the refcount in
+ *        the fuqueue makes sense.
+ */
+struct fuqueue_ops {
+	void (* get) (struct fuqueue *);
+	void (* put) (struct fuqueue *);
+	unsigned (* waiter_cancel) (struct fuqueue *, struct fuqueue_waiter *);
+	struct task_struct * (* waiter_chprio) (
+		struct task_struct *, struct fuqueue *,
+		struct fuqueue_waiter *);
+};
+
+/** A fuqueue, a prioritized wait queue usable from kernel space. */
+struct fuqueue {
+	spinlock_t lock;	
+	wlist_t wlist;
+	struct fuqueue_ops *ops;
+};
+
+
+/** Initialize a @fuqueue structure with given @ops */
+static inline
+void __fuqueue_init (struct fuqueue *fuqueue, struct fuqueue_ops *ops)
+{
+	spin_lock_init (&fuqueue->lock);
+	wlist_init (&fuqueue->wlist);
+	fuqueue->ops = ops;
+}
+
+/** Statically initialize a @fuqueue with given @ops. */
+#define __fuqueue_INIT(fuqueue, ops) {			\
+	.lock = SPIN_LOCK_UNLOCKED,			\
+	.wlist = wlist_INIT (&(fuqueue)->wlist),	\
+	.ops = (ops)					\
+}
+
+
+/** fuqueue operations for in-kernel usage */
+extern struct fuqueue_ops fuqueue_ops;
+
+
+/** Initialize a @fuqueue for usage within the kernel */
+static inline
+void fuqueue_init (struct fuqueue *fuqueue)
+{
+	__fuqueue_init (fuqueue, &fuqueue_ops);
+}
+
+/** Statically initialize a @fuqueue for usage within the kernel */
+#define fuqueue_INIT(fuqueue) __fuqueue_INIT(fuqueue, &fuqueue_ops)
+
+
+/** Wait for a @fuqueue to be woken for as much as @timeout, @returns
+ * wake up code */
+extern int fuqueue_wait (struct fuqueue *fuqueue, signed long timeout);
+
+/* Cancel the wait on a fuqueue */
+extern void fuqueue_waiter_cancel (struct task_struct *, int);
+
+/*
+ * The following are functions to be able to access fuqueue
+ * functionality when building on top of it, like the [u]fulocks,
+ * [u]fuconds and ufuqueues.
+ */
+
+#if DEBUG > 0
+/* BUG_ON() firing? Temporary fix, do you have CONFIG_PREEMPT enabled?
+ * either that or disable DEBUG (force #define it to zero). */ 
+#define CHECK_IRQs() do { BUG_ON (!in_atomic()); } while (0)
+#else
+#define CHECK_IRQs() do {} while (0)
+#endif
+
+
+/**
+ * Setup @current to wait for a fuqueue.
+ *
+ * This only setups, it does not block.
+ * 
+ * @fuqueue: fuqueue to wait on.
+ * @w: waiter structure to fill up and queue.
+ * @returns !0 if the wlist prio changed.
+ *
+ * Fills up @current's fuqueue_wait* info and queues up @w after
+ * filling it.
+ *
+ * WARNING: Call with preempt and local IRQs disabled
+ */
+static inline
+unsigned __fuqueue_waiter_queue (struct fuqueue *fuqueue,
+				 struct fuqueue_waiter *w)
+{
+	ftrace ("(%p, %p)\n", fuqueue, w);
+	CHECK_IRQs();
+	
+	_raw_spin_lock (&current->fuqueue_wait_lock);
+	current->fuqueue_wait = fuqueue;
+	current->fuqueue_waiter = w;
+	_raw_spin_unlock (&current->fuqueue_wait_lock);
+	w->task = current;
+	w->result = INT_MAX;
+	__wlist_chprio (&w->wlist_node, current->prio);
+	return wlist_add (&fuqueue->wlist, &w->wlist_node);
+}
+
+
+/**
+ * Wakes up a single waiter and cleans up it's task wait information.
+ *
+ * Needs to be split from __fuqueue_wake_waiter() as
+ * fuqueue_wake_cancel() needs to acquire the locks in a funny way to
+ * prevent issues. 
+ *
+ * WARNING: call with preeempt and local IRQs disabled!!
+ */
+static inline
+void __fuqueue_waiter_unqueue (struct fuqueue_waiter *w, int result)
+{
+	struct task_struct *task = w->task;
+
+	ftrace ("(%p [%d], %d)\n", w, w->task->pid, result);
+	CHECK_IRQs();
+	
+	__wlist_rem (&w->wlist_node);
+	_raw_spin_lock (&task->fuqueue_wait_lock);
+	task->fuqueue_wait = NULL;
+	task->fuqueue_waiter->result = result;
+	task->fuqueue_waiter = NULL;
+	_raw_spin_unlock (&task->fuqueue_wait_lock);
+}
+
+
+/**
+ * Wait for a @fuqueue until woken up, @returns wake up code
+ *
+ * Needs to be called with the fuqueue lock held, local IRQs disabled
+ * and preempt disabled. Will release the lock, enable IRQs and
+ * preemtion. 
+ */
+static inline
+int __fuqueue_waiter_block (struct fuqueue *fuqueue, struct fuqueue_waiter *w,
+			    signed long timeout)
+{
+	ftrace ("(%p, %p, %ld)\n", fuqueue, w, timeout);
+	CHECK_IRQs();
+	
+	set_current_state (TASK_INTERRUPTIBLE);
+	_raw_spin_unlock (&fuqueue->lock);
+	local_irq_enable();
+	preempt_enable_no_resched();
+	
+	/* Wait until we are woken up */
+	timeout = schedule_timeout (timeout);
+	set_current_state (TASK_RUNNING);
+	/*
+	 * Now, whoever woke us up had to call first
+	 * fuqueue->ops->waiter_cancel() through fuqueue_waiter_cancel(),
+	 * and thus, unqueued us and set up a return code in
+	 * w->result. However, if w->result is still pristine as left
+	 * by __fuqueue_wait_queue(), that means our waker either
+	 * didn't know we were waiting or we have signal(s) pending,
+	 * so we do it ourselves.
+	 */
+	if (unlikely (w->result == INT_MAX)) {
+		int result = -EINTR;
+		BUG_ON (wlist_empty (&w->wlist_node));
+		if (timeout == 0)
+			result = -ETIMEDOUT;
+		else
+			WARN_ON (!signal_pending (current));
+		fuqueue_waiter_cancel (current, result);
+	}
+	return w->result;
+}
+
+
+
+/** @Returns true if the @fuqueue has no waiters. */
+static inline
+unsigned __fuqueue_empty (const struct fuqueue *fuqueue)
+{
+	return wlist_empty (&fuqueue->wlist);
+}
+
+
+/** Return the first waiter on a @fuqueue */
+static inline
+struct fuqueue_waiter * __fuqueue_first (struct fuqueue *fuqueue)
+{
+	return container_of (wlist_first (&fuqueue->wlist),
+			     struct fuqueue_waiter, wlist_node);
+}
+
+/** Wake @howmany @fuqueue waiters with @code. */
+static inline
+void __fuqueue_wake (struct fuqueue *fuqueue, size_t howmany, int code)
+{
+	struct fuqueue_waiter *w = NULL;
+
+        ftrace ("(%p, %zu, %d)\n", fuqueue, howmany, code);
+	
+        while (howmany-- && !__fuqueue_empty (fuqueue)) {
+		w = __fuqueue_first (fuqueue);
+                __fuqueue_waiter_unqueue (w, code);
+		wake_up_process (w->task);
+	}
+        if (likely (w != NULL))
+		wlist_update_prio (&fuqueue->wlist);
+}
+
+
+/** Wake @howmany waiters waiting on a @fuqueue, with return code (for
+ * them) @code */
+static inline
+int fuqueue_wake (struct fuqueue *fuqueue, size_t howmany, int code)
+{
+	unsigned long flags;
+
+        ftrace ("(%p, %zu, %d)\n", fuqueue, howmany, code);
+	
+	spin_lock_irqsave (&fuqueue->lock, flags);
+	__fuqueue_wake (fuqueue, howmany, code);
+	spin_unlock_irqrestore (&fuqueue->lock, flags);
+	return 0;
+}
+
+
+/* See docs in kernel/fuqueue.c */
+extern unsigned __fuqueue_op_waiter_cancel (struct fuqueue *,
+					    struct fuqueue_waiter *);
+
+
+/** [non irq off/preempt-disabled version */
+extern void __fuqueue_waiter_chprio (struct task_struct *);
+
+/* A waiting @task changed its priority, propagate it. */
+static inline
+void fuqueue_waiter_chprio (struct task_struct *task)
+{
+	unsigned long flags;
+
+	ftrace ("(%p [%d])\n", task, task->pid);
+
+	if (task->fuqueue_wait == NULL)
+		return;
+	local_irq_save (flags);
+	preempt_disable();
+	__fuqueue_waiter_chprio (task);
+	local_irq_restore (flags);
+	preempt_enable();
+}
+
+
+/**
+ * Set the priority of a fuqueue waiter, repositioning it in the wait
+ * list.
+ *
+ * This does not set the prio of the process itself! 
+ *
+ * @task: waiting task to reprioritize 
+ * @fuqueue: fuqueue the task is waiting for [locked]
+ * @w: waiter @task is waiting with in @fuqueue.
+ * @returns: NULL (as there is no propagation).
+ *	     
+ * Assumptions: prio != task->prio
+ *		fuqueue->lock held
+ */
+static inline
+struct task_struct * __fuqueue_op_waiter_chprio (
+	struct task_struct *task, struct fuqueue *fuqueue,
+	struct fuqueue_waiter *w)
+{
+	wlist_chprio (&fuqueue->wlist, &w->wlist_node, task->prio);
+	return NULL;
+}
+
+#endif /* #ifdef __KERNEL__ */
+#endif /* #ifndef __linux_fuqueue_h__ */
--- /dev/null	Thu Apr 15 00:58:25 2004
+++ include/linux/plist.h Thu Apr 8 00:38:53 2004
@@ -0,0 +1,202 @@
+/*
+ * Descending-priority-sorted double-linked list
+ *
+ * (C) 2002-2003 Intel Corp
+ * Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>.
+ *
+ * Licensed under the FSF's GNU Public License v2 or later.
+ *
+ * Based on simple lists (include/linux/list.h).
+ *
+ * The head will always contain the head and the highest priority of
+ * the nodes in the list. Addition is O(N), removal is O(1), change of
+ * priority is O(N)
+ *
+ * 0 is highest priority, INT_MAX is lowest priority.
+ *
+ * No locking is done, up to the caller.
+ *
+ * TODO: O(1)ization, so all operations become O(K), where K is a
+ *       constant being the number of priorities used. For this, there
+ *       is a list of nodes of different priorities, and each has a
+ *       list of all elements of the same priority.
+ */
+
+#ifndef _LINUX_PLIST_H_
+#define _LINUX_PLIST_H_
+
+#include <linux/list.h>
+
+/* Priority-sorted list */
+struct plist {
+	int prio;
+	struct list_head node;
+};
+
+#define plist_INIT(p)				\
+{						\
+	.node = LIST_HEAD_INIT((p)->node),	\
+	.prio = INT_MAX				\
+}
+
+/* Initialize a pl */
+static inline
+void plist_init (struct plist *pl)
+{
+	INIT_LIST_HEAD (&pl->node);
+	pl->prio = INT_MAX;
+}
+
+/* Return the first node (and thus, highest priority)
+ *
+ * Assumes the plist is _not_ empty.
+ */
+static inline
+struct plist * plist_first (struct plist *plist)
+{
+	return list_entry (plist->node.next, struct plist, node);
+}
+
+/* Return if the plist is empty. */
+static inline
+unsigned plist_empty (const struct plist *plist)
+{
+	return list_empty (&plist->node);
+}
+
+/* Update the maximum priority
+ *
+ * Return !0 if the plist's maximum priority changes.
+ *
+ * __plist_update_prio() assumes the plist is not empty.
+ */
+static inline
+unsigned __plist_update_prio (struct plist *plist)
+{
+	unsigned prio = plist_first (plist)->prio;
+	if (plist->prio == prio)
+		return 0;
+	plist->prio = prio;
+	return !0;
+}
+
+static inline
+unsigned plist_update_prio (struct plist *plist)
+{
+	unsigned old_prio = plist->prio;
+	/* plist empty, lowest prio = INT_MAX */
+	plist->prio = plist_empty (plist)? INT_MAX : plist_first (plist)->prio;
+	return old_prio != plist->prio;
+}
+
+/* Add a node to the plist [internal]
+ *
+ * pl->prio == INT_MAX is an special case, means low priority, get down to
+ * the end of the plist. Note the <; we want to add the new guy of a
+ * set of same priority people to the end of that set (FIFO behaviour
+ * on the same priority).
+ */
+static inline
+void __plist_add_sorted (struct plist *plist, struct plist *pl)
+{
+	struct list_head *itr;
+	struct plist *itr_pl;
+
+	if (pl->prio < INT_MAX)
+		list_for_each (itr, &plist->node) {
+			itr_pl = list_entry (itr, struct plist, node);
+			if (pl->prio < itr_pl->prio)
+				break;
+		}
+	else
+		itr = &plist->node;
+	list_add_tail (&pl->node, itr);
+}
+
+/* Add a node to a plist
+ *
+ * Return !0 if the plist's maximum priority changes.
+ */
+static inline
+unsigned plist_add (struct plist *plist, struct plist *pl)
+{
+	__plist_add_sorted (plist, pl);
+	/* Are we setting a higher priority? */
+	if (pl->prio < plist->prio) {
+		plist->prio = pl->prio;
+		return !0;
+	}
+	return 0;
+}
+
+/* Return the priority a pl node */
+static inline
+unsigned plist_prio (struct plist *pl)
+{
+	return pl->prio;
+}
+
+/* Change the priority of a pl node, without updating plist position */
+static inline
+void __plist_chprio (struct plist *pl, unsigned new_prio)
+{
+	pl->prio = new_prio;
+}
+
+/* Change the priority of a pl node updating the list's max priority.
+ *
+ * Return !0 if the plist's maximum priority changes
+ */
+static inline
+unsigned plist_chprio (struct plist *plist, struct plist *pl,
+		       unsigned new_prio)
+{
+	__plist_chprio (pl, new_prio);
+	list_del (&pl->node);
+	__plist_add_sorted (plist, pl);
+	return __plist_update_prio (plist);
+}
+
+/* Remove a pl node from a plist
+ *
+ * Return !0 if the plist's maximum priority changed.
+ */
+static inline
+void __plist_rem (struct plist *pl)
+{
+	list_del_init (&pl->node);
+}
+static inline
+unsigned plist_rem (struct plist *plist, struct plist *pl)
+{
+	__plist_rem (pl);
+	return plist_update_prio (plist);
+}
+
+/* Iterate over a plist - in priority order (from high to low) */
+#define plist_for_each(pos, head)					\
+for (pos = container_of ((head)->node.next, struct plist, node),	\
+       prefetch (pos->node.next);					\
+     pos != (head);							\
+     pos = container_of (pos->node.next, struct plist, node),		\
+       prefetch (pos->node.next))
+
+#define plist_for_each_safe(pos, n, head)					\
+	for (pos = container_of ((head)->node.next, struct plist, node),	\
+	       n = container_of (pos->node.next, struct plist, node);		\
+	     pos != (head);							\
+	     pos = n,								\
+	       n = container_of (pos->node.next, struct plist, node))
+
+
+/** Return !0 if node @pl is the last one on list @plist. */
+
+static inline
+unsigned plist_last (const struct plist *plist, const struct plist *pl)
+{
+	return pl->node.next == &plist->node;
+}
+
+
+#endif /* #ifndef _LINUX_PLIST_H_ */
+
--- /dev/null	Thu Apr 15 00:58:26 2004
+++ kernel/fuqueue.c Wed Apr 14 01:48:37 2004
@@ -0,0 +1,209 @@
+
+/*
+ * Fast User real-time/pi/pp/robust/deadlock SYNchronization
+ * (C) 2002-2003 Intel Corp
+ * Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>.
+ *
+ * Licensed under the FSF's GNU Public License v2 or later.
+ *
+ * Based on normal futexes (futex.c), (C) Rusty Russell.
+ * Please refer to Documentation/fusyn.txt for more info.
+ *
+ * see the doc in linux/fuqueue.h for some info.
+ */
+
+#define DEBUG 8
+
+#include <linux/fuqueue.h>
+#include <linux/sched.h>
+#include <linux/plist.h>
+#include <linux/errno.h>
+
+#if DEBUG > 0
+spinlock_t __debug_lock = SPIN_LOCK_UNLOCKED;
+#endif
+
+
+/**
+ * Wait for a @fuqueue to be woken for as much as @timeout, @returns
+ * wake up code
+ *
+ * WARNING: can only be called from process context
+ */
+int fuqueue_wait (struct fuqueue *fuqueue, signed long timeout)
+{
+        struct fuqueue_waiter w;
+	
+        ftrace ("(%p, %ld)\n", fuqueue, timeout);
+	
+	spin_lock_irq (&fuqueue->lock);
+	__fuqueue_waiter_queue (fuqueue, &w);
+	return __fuqueue_waiter_block (fuqueue, &w, timeout); /* unlocks */
+}
+
+
+/**
+ * Change the priority of a waiter.
+ *
+ * @task: task whose priority has to be changed.
+ *
+ * This is the entry point that the scheduler functions call when a
+ * task that is waiting for a fuqueue changes its priority. It will
+ * call the fuqueue-specific chprio function after safely determining
+ * what is the fuqueue it is waiting for and then, if the
+ * specific chprio function determines that the prio change has to be
+ * propagated, it will keep doing it.
+ *
+ * The task that the chprio function returns has to be returned with a
+ * get_task_struct() reference.
+ *
+ * Note the weird locking: we are one of the little places that needs
+ * to take the locks in inverse order (most are fuqueue first,
+ * task_wait later--FT), we need to do TF, so we do T, test F, if it
+ * fails, unlock T, try again.
+ */
+void __fuqueue_waiter_chprio (struct task_struct *task)
+{
+	struct fuqueue_ops *ops;
+	struct fuqueue *fuqueue;
+	struct fuqueue_waiter *w;
+
+	ftrace ("(%p [%d])\n", task, task->pid);
+	
+	get_task_struct (task);
+next:
+	/* Who is the task waiting for? safely acquire and lock it */
+	if (task->fuqueue_wait == NULL)
+		goto out_task_put;
+	_raw_spin_lock (&task->fuqueue_wait_lock);
+	fuqueue = task->fuqueue_wait;
+	if (fuqueue == NULL)				/* Ok, not waiting */
+		goto out_task_unlock;
+	if (!_raw_spin_trylock (&fuqueue->lock)) {      /* Spin dance... */
+		_raw_spin_unlock (&task->fuqueue_wait_lock);
+		goto next;
+	}
+	ops = fuqueue->ops;
+	if (ops->get)
+		ops->get (fuqueue);
+	
+	w = task->fuqueue_waiter;
+	_raw_spin_unlock (&task->fuqueue_wait_lock);
+	put_task_struct (task);
+	/* propagate the prio change in a fuqueue-specific fashion */
+	task = ops->waiter_chprio (task, fuqueue, w);
+	if (task == NULL)            /* no other task to propagate to? */
+		goto out_fuqueue_unlock;
+	/* We were given a task to propagate to, proceed? */
+	get_task_struct (task);
+	_raw_spin_unlock (&fuqueue->lock);
+	if (ops->put)
+		ops->put (fuqueue);
+	goto next;
+
+out_fuqueue_unlock:
+	_raw_spin_unlock (&fuqueue->lock);
+	if (ops->put)
+		ops->put (fuqueue);
+	goto out;
+	
+out_task_unlock:
+	_raw_spin_unlock (&task->fuqueue_wait_lock);
+out_task_put:
+	put_task_struct (task);
+out:
+	return;
+}
+
+/** Cancel @task's wait on @fuqueue and update the wait list priority */
+unsigned __fuqueue_op_waiter_cancel (struct fuqueue *fuqueue,
+				     struct fuqueue_waiter *w)
+{
+	ftrace ("(%p, %p [%d])\n", fuqueue, w, w->task->pid);
+	
+	return wlist_rem (&fuqueue->wlist, &w->wlist_node);
+}
+
+
+/**
+ * Cancel the wait of a task on a fuqueue and wake it up.
+ *
+ * @task: task whose wait is to be canceled
+ * 
+ * Called by:
+ * - signal_wake_up()
+ * - process_timeout()
+ * - __wake_up_common()
+ * - FIXME
+ * 
+ * when the task they are about to wake is waiting on a
+ * fuqueue. Safely acquires which fuqueue the task is waiting for,
+ * references it, cleans up the task->fuqueue_wait* information, and
+ * then calls the fuqueue specific waiter_cancel() function.
+ *
+ * FIXME: the entry points we get called from don't seem to be all of
+ * them; the perfect thing here would be to hook into
+ * try_to_wake_up()--but is kind of tricky..,
+ *
+ * Note that for this function to actually do anything, the task must
+ * be a task waiting on a fuqueue (so that means TASK_INTERRUPTIBLE
+ * and off the runqueues).
+ */
+void fuqueue_waiter_cancel (struct task_struct *task, int result)
+{
+	struct fuqueue_ops *ops;
+	struct fuqueue *fuqueue;
+	struct fuqueue_waiter *w;
+	unsigned long flags;
+
+	ftrace ("(%p [%d], %d)\n", task, task->pid, result);
+	
+	local_irq_save (flags);
+	preempt_disable();
+	get_task_struct (task);
+retry:
+	/* Who is the task waiting for? safely acquire and lock it */
+	_raw_spin_lock (&task->fuqueue_wait_lock);
+	fuqueue = task->fuqueue_wait;
+	if (fuqueue == NULL)				/* Ok, not waiting */
+		goto out_task_unlock;
+	if (!_raw_spin_trylock (&fuqueue->lock)) {      /* Spin dance... */
+		_raw_spin_unlock (&task->fuqueue_wait_lock);
+		goto retry;
+	}
+	ops = fuqueue->ops;
+	if (ops->get)
+		ops->get (fuqueue);
+
+	w = task->fuqueue_waiter;
+	w->result = result;
+	
+	/* Do the specific cancel op */
+	ops->waiter_cancel (fuqueue, w);
+	task->fuqueue_wait = NULL;
+	task->fuqueue_waiter = NULL;
+	_raw_spin_unlock (&task->fuqueue_wait_lock);
+	put_task_struct (task);
+	_raw_spin_unlock (&fuqueue->lock);
+	local_irq_restore (flags);
+	preempt_enable();
+	if (ops->put)
+		ops->put (fuqueue);
+	return;
+		
+out_task_unlock:
+	_raw_spin_unlock (&task->fuqueue_wait_lock);
+	put_task_struct (task);
+	local_irq_restore (flags);
+	preempt_enable();
+	return;
+}
+
+
+/** Fuqueue operations for usage within the kernel */
+struct fuqueue_ops fuqueue_ops = {
+	.get = NULL,
+	.put = NULL,
+	.waiter_cancel = __fuqueue_op_waiter_cancel,
+	.waiter_chprio = __fuqueue_op_waiter_chprio
+};
