Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267468AbUGWPro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267468AbUGWPro (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 11:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267481AbUGWPqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 11:46:50 -0400
Received: from fmr05.intel.com ([134.134.136.6]:44677 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S267804AbUGWPki
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 11:40:38 -0400
Date: Fri, 23 Jul 2004 08:48:59 -0700
From: inaky.perez-gonzalez@intel.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com, robustmutexes@lists.osdl.org
Subject: [RFC/PATCH] FUSYN 3/11: kernel fuqueues
Message-ID: <0407230848.ZdKcBcybgaBd6ddd6cVdacuaIaRd6dha17066@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0407230848.sbNbGcKasaWc~dJbcd.aMbgbvagckbtd17066@intel.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are the basic queues, similar to the futexes, but
usable only from kernel space--some resemblance to
waitqueues, but that has to be improved.

It includes all the stuff for building on top of them (for
fulocks and the user space support) as well as the basic
debug macros--these will go away IANF.


 include/linux/fuqueue.h     |  410 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fusyn-debug.h |  152 ++++++++++++++++
 kernel/fuqueue.c            |  349 +++++++++++++++++++++++++++++++++++++
 3 files changed, 911 insertions(+)

--- /dev/null	Thu Jul 22 14:30:56 2004
+++ include/linux/fuqueue.h Mon Jul 19 16:30:13 2004
@@ -0,0 +1,410 @@
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
+ * The type 'struct plist' provides the sorting for the wait list. The
+ * type 'struct fuqueue_waiter' represents a waiting task on a
+ * fuqueue. The 'struct fuqueue_ops' is what allows extensibility for
+ * other synchronization primitives.
+ *
+ * I have just realized that this is too similar to the wait_queues...
+ */
+
+#ifndef __linux_fuqueue_h__
+#define __linux_fuqueue_h__
+
+enum { FUQUEUE_WAITER_GOT_LOCK = 0x401449 };
+
+/** Fuqueue control actions */
+enum fuqueue_ctl {
+	FUQUEUE_CTL_RELEASE = 0,	/* Release an ufuqueue */
+	FUQUEUE_CTL_WAITERS,   		/* Do we have waiters? */
+};
+
+#ifdef __KERNEL__
+#include <linux/config.h>
+#include <linux/fusyn-debug.h>
+
+#ifndef CONFIG_FUSYN
+struct task_struct;
+static inline
+void fuqueue_waiter_cancel (struct task_struct *dummy1, int dummy2) {}
+
+static inline
+void fuqueue_waiter_chprio (struct task_struct *task, int old_prio) {}
+
+#else /* #ifndef CONFIG_FUSYN */
+
+#include <linux/errno.h>
+#include <linux/spinlock.h>
+#include <linux/plist.h>
+#include <linux/sched.h>
+#include <asm/hardirq.h>
+#include <linux/vlocator.h>
+
+struct task_struct;
+struct fuqueue;
+
+/**
+ * Type for fuqueue task wake function (or callback)
+ *
+ * @fuqueue: fuqueue we are waiting from
+ * @w: fuqueue wait structure where called from
+ * @state_mask: as passed to fuqueue_wake()
+ * @sync: perform a sync wake up or not.
+ * @returns: return 0 on success, !0 on error or any other condition
+ *           you feel like. This will tell __fuqueue_wake() to stop
+ *           waking up any other tasks if they were going to be woken
+ *           up. 
+ *           
+ * This function (if the pointer is non-NULL) is called from atomic
+ * context inside __fuqueue_wake().
+ */
+typedef int (*fuqueue_wake_f) (struct fuqueue *fuqueue, struct fuqueue_waiter *w,
+			       unsigned state_mask, int sync);
+
+/** Descriptor of a waiting task */
+struct fuqueue_waiter {
+	struct plist wlist_node;	/* node for the wait list */
+	struct task_struct *task;	/* task that is waiting */
+	int result;			/* what happened */
+	unsigned flags;			/* how is it supposed to happen */
+	fuqueue_wake_f wake_func;	/* call this upon wake up */
+};
+
+
+/* Bit-flags for influencing the wake up */
+enum {
+	FUQUEUE_WT_FL_QUEUE = 1,	/* Waiting for a queue */
+	FUQUEUE_WT_FL_EXCLUSIVE = 2,	/* Task is exclusive waiter */
+};
+
+
+/*
+ * Special parameters for fuqueue_wake*()
+ */
+
+/** fuqueue_wake*()'s @howmany: wake everybody */
+static const size_t FUQUEUE_WAKE_ALL = ULONG_MAX;
+
+
+/**
+ * Initializer for the fuqueue_waiter (we only initialize the fields
+ * that can cause trouble because they might not be overwritten by the
+ * queuing functions.
+ */
+#define fuqueue_waiter_INIT(_task)		\
+{						\
+	.task = (_task),			\
+	.flags = 0,				\
+	.wake_func = NULL,			\
+} 
+
+
+/**
+ * Operations on a fuqueue.
+ *
+ * All ops have to be atomic, no sleeping allowed.
+ * 
+ * NOTE: is it worth to have get/put? maybe they should be enforced
+ *	 for every fuqueue, this way we don't have to query the ops
+ *	 structure for the get/put method and if it is there, call
+ *	 it. We'd have to move the get/put ops over to the vlocator,
+ *	 but that's not much of a problem.
+ *
+ *	 The decision factor is that an atomic operation needs to
+ *	 lock the whole bus and is not as scalable as testing a ptr
+ *	 for NULLness.
+ *
+ *	 For simplicity, probably the idea of forcing the refcount in
+ *	 the fuqueue makes sense.
+ */
+struct fuqueue_ops {
+	void (* get) (struct fuqueue *);
+	void (* put) (struct fuqueue *);
+	unsigned (* waiter_cancel) (struct fuqueue *,
+				    struct fuqueue_waiter *);
+	struct task_struct * (* waiter_chprio) (
+		struct task_struct *, struct fuqueue *,
+		struct fuqueue_waiter *);
+};
+
+/** A fuqueue, a prioritized wait queue usable from kernel space. */
+struct fuqueue {
+	spinlock_t lock;	
+	struct plist wlist;
+	struct fuqueue_ops *ops;
+};
+
+/** A ufuqueue, tied to a user-space vm address. */
+struct ufuqueue {
+	struct fuqueue fuqueue;
+	struct vlocator vlocator;
+};
+
+
+/** Initialize a @fuqueue structure with given @ops */
+static inline
+void __fuqueue_init (struct fuqueue *fuqueue, struct fuqueue_ops *ops)
+{
+	spin_lock_init (&fuqueue->lock);
+	plist_init (&fuqueue->wlist, BOTTOM_PRIO);
+	fuqueue->ops = ops;
+}
+
+/** Statically initialize a @fuqueue with given @ops. */
+#define __fuqueue_INIT(fuqueue, fuqueue_ops) {			\
+	.lock = SPIN_LOCK_UNLOCKED,				\
+	.wlist = plist_INIT (&(fuqueue)->wlist, BOTTOM_PRIO),	\
+	.ops = (fuqueue_ops)					\
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
+extern int fuqueue_wait (struct fuqueue *fuqueue, const struct timeout *);
+/**
+ * Wait for a @fuqueue to be woken for as much as @timeout, @return
+ * wake up code.
+ *
+ * Use provided @flags for waiting, as well as the specified wake up
+ * function callback (will be called before the task is woken up in
+ * atomic context).  */
+extern int fuqueue_wait_fcb (struct fuqueue *fuqueue, const struct timeout *,
+			     unsigned flags, fuqueue_wake_f callback);
+
+/**
+ * Wake waiters from a fuqueue.
+ *
+ * @fuqueue: where to wake from.
+ * @howmany: number of waiters to wake up. If 0 (FUQUEUE_WAKE_ALL),
+ *           wake all of them.
+ * @code: return code they should see when woken.
+ * @state_mask: mask of task states that should be woken.
+ * @sync: do a sync wake up or not.
+ */
+extern void fuqueue_wake_state (struct fuqueue *fuqueue, size_t howmany,
+				int code, unsigned int state_mask, int sync);
+
+/**
+ * Same as @fuqueue_wake_state(), defaulting to stopped, interruptible and
+ * uninterruptible tasks, no sync wake-up.
+ */
+static inline
+void fuqueue_wake (struct fuqueue *fuqueue, size_t howmany, int code)
+{
+	fuqueue_wake_state (fuqueue, howmany, code,
+			    TASK_STOPPED | TASK_INTERRUPTIBLE
+			    | TASK_UNINTERRUPTIBLE, 0);
+} 
+
+/* Cancel the wait on a fuqueue */
+extern void __fuqueue_waiter_cancel (struct task_struct *, int);
+extern unsigned __fuqueue_waiter_queue (struct fuqueue *,
+					struct fuqueue_waiter *);
+extern void __fuqueue_waiter_unqueue (struct fuqueue_waiter *);
+extern unsigned __fuqueue_op_waiter_cancel (struct fuqueue *,
+					    struct fuqueue_waiter *);
+extern void __fuqueue_waiter_chprio (struct task_struct *);
+
+
+/** Quick check if the task is fuqueue waiting and if so cancel. */
+static inline
+void fuqueue_waiter_cancel (struct task_struct *t, int code)
+{
+	if (unlikely (t->fuqueue_wait != NULL))
+		__fuqueue_waiter_cancel (t, code);
+}
+
+
+/*
+ * The following are functions to be able to access fuqueue
+ * functionality when building on top of it, like the [u]fulocks,
+ * and ufuqueues.
+ */
+
+
+/**
+ * Wakes up a single waiter and cleans up it's task wait information.
+ *
+ * @returns 0 if the plist's priority didn't change, !0 otherwise.
+ * 
+ * WARNING: call with preeempt and local IRQs disabled!!
+ */
+static inline
+unsigned fuqueue_waiter_unqueue (struct fuqueue *fuqueue,
+				 struct fuqueue_waiter *w)
+{
+	ftrace ("(%p [%d])\n", w, w->task->pid);
+
+	__fuqueue_waiter_unqueue (w);
+	return plist_update_prio (&fuqueue->wlist);
+}
+
+
+extern int __fuqueue_waiter_block (struct fuqueue *fuqueue,
+				   struct fuqueue_waiter *w,
+				   const struct timeout *timeout);
+
+/** @Returns true if the @fuqueue has no waiters. */
+static inline
+unsigned __fuqueue_empty (const struct fuqueue *fuqueue)
+{
+	return plist_empty (&fuqueue->wlist);
+}
+
+
+/** Return the first waiter on a @fuqueue */
+static inline
+struct fuqueue_waiter * __fuqueue_first (struct fuqueue *fuqueue)
+{
+	return container_of (plist_first (&fuqueue->wlist),
+			     struct fuqueue_waiter, wlist_node);
+}
+
+
+/**
+ * Default wake function callback
+ *
+ * @fuqueue: the task is being woken from
+ * @w: fuqueue waiter structure
+ * @state_mask: mask of task states that can be woken up and FUQUEUE_WAKE_*.
+ * @returns: 0, success, always.
+ * 
+ * This is provided in case you want to daisy chain.
+ */
+static inline
+int fuqueue_default_wake_function (struct fuqueue *fuqueue,
+				   struct fuqueue_waiter *w,
+				   unsigned state_mask, int sync)
+{
+	try_to_wake_up (w->task, state_mask, sync);
+	return 0;
+}
+
+
+/**
+ * Wake @howmany @fuqueue waiters with @code (this function is here
+ * so other fusyn components can inline it--nobody should use it,
+ * fuqueue_wake is for that).
+ */
+static inline
+void __fuqueue_wake_state (struct fuqueue *fuqueue, size_t howmany,
+			   int code, unsigned state_mask, int sync)
+{
+	struct fuqueue_waiter *w = NULL;
+
+	ftrace ("(%p, %zu, %d)\n", fuqueue, howmany, code);
+	
+	while (howmany-- && !__fuqueue_empty (fuqueue)) {
+		w = __fuqueue_first (fuqueue);
+		__fuqueue_waiter_unqueue (w);
+		w->result = code;
+		wmb();
+		if (w->wake_func == NULL)
+			fuqueue_default_wake_function (fuqueue, w,
+						       state_mask, sync);
+		else if (w->wake_func (fuqueue, w, state_mask, sync))
+			break;
+		if (w->flags & FUQUEUE_WT_FL_EXCLUSIVE)
+			break;
+	}
+	if (likely (w != NULL))
+		plist_update_prio (&fuqueue->wlist);
+}
+
+/**
+ * Same as @__fuqueue_wake_state(), defaulting to stopped, interruptible and
+ * uninterruptible tasks, no sync wake-up.
+ */
+static inline
+void __fuqueue_wake (struct fuqueue *fuqueue, size_t howmany, int code)
+{
+	__fuqueue_wake_state (fuqueue, howmany, code,
+			      TASK_STOPPED | TASK_INTERRUPTIBLE
+			      | TASK_UNINTERRUPTIBLE, 0);
+}
+
+
+
+/** A waiting @task changed its priority, propagate it. */
+static inline
+void fuqueue_waiter_chprio (struct task_struct *task, int old_prio)
+{
+	unsigned long flags;
+	
+	ftrace ("(%p [%d], %d)\n", task, task->pid, old_prio);
+
+	if (old_prio == task->prio)
+		return;
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
+	plist_chprio (&fuqueue->wlist, &w->wlist_node, task->prio);
+	return NULL;
+}
+
+#endif /* #ifndef CONFIG_FUSYN */
+#endif /* #ifdef __KERNEL__ */
+#endif /* #ifndef __linux_fuqueue_h__ */
--- /dev/null	Thu Jul 22 14:30:56 2004
+++ include/linux/fusyn-debug.h Thu Jul 15 17:19:39 2004
@@ -0,0 +1,152 @@
+
+/*
+ * THIS FILE WILL GO AWAY!!!
+ *
+ * Fast User real-time/pi/pp/robust/deadlock SYNchronization
+ * (C) 2002-2003 Intel Corp
+ * Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>.
+ *
+ * Licensed under the FSF's GNU Public License v2 or later.
+ *
+ * Debug utilities
+ */
+
+#ifndef __linux_fusyn_debug_h__
+#define __linux_fusyn_debug_h__
+
+#include <linux/spinlock.h>
+
+#ifdef __KERNEL__
+
+  /*
+   * move forward for seeing the real meat
+   * 
+   * Levels
+   * 
+   *	0 Nothing activated, all compiled out
+   * > 0 Activates assertions, memory allocation tracking
+   * > 1 Activates debug messages
+   * > 2 Activates [most] function traces
+   * > 3 Activates random debug stuff
+   */
+
+#undef DEBUG
+#define DEBUG 0
+
+
+
+/* Dump straight to ttyS0 on ia32 machines */
+#if 1 && defined (__i386__)
+#include <linux/serial_reg.h>
+#include <linux/stringify.h>
+static inline void __debug_serial_outb (unsigned val, int port) {
+	__asm__ __volatile__ ("outb %b0,%w1" : : "a" (val), "Nd" (port));
+}
+static inline unsigned __debug_serial_inb (int port) {
+	unsigned value;
+	__asm__ __volatile__ ("inb %w1,%b0" : "=a" (value) : "Nd" (port));
+	return value;
+}
+static inline
+void __debug_serial_printstr (const char *str) {
+	const int port = 0x03f8;  
+	while (*str) {
+		while (!(__debug_serial_inb (port + UART_LSR) & UART_LSR_THRE));
+		__debug_serial_outb (*str++, port+UART_TX);
+	}
+	__debug_serial_outb ('\r', port + UART_TX);
+}
+#endif /* #ifdef __i386__ */
+
+extern spinlock_t __debug_lock;
+
+static inline
+void __debug_printstr (const char *str) 
+{
+	if (DEBUG == 0)
+		return;
+#ifdef __i386__
+	__debug_serial_printstr (str);
+#else
+	printk (str);
+#endif
+}
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
+#define __debug(a...)								    \
+do {										    \
+	if (DEBUG > 0) {							    \
+		/* Dirty: Try to avoid >1 CPUs printing ... will suck */	    \
+		char __X_buf[256];						    \
+		unsigned __X_len;						    \
+		unsigned long __X_flags;					    \
+		__X_len = snprintf (__X_buf, 255, "%Lu: %s:%d: %s[%d:%d] ",	    \
+				    __tsc_read(), __FILE__, __LINE__, __FUNCTION__, \
+				    current->pid, current->thread_info->cpu);	    \
+		snprintf (__X_buf + __X_len, 255 - __X_len, a);			    \
+		spin_lock_irqsave (&__debug_lock, __X_flags);			    \
+		__debug_printstr (__X_buf);					    \
+		spin_unlock_irqrestore (&__debug_lock, __X_flags);		    \
+	}									    \
+} while (0)
+
+/* The real debug statements */
+
+#define ldebug(l,a...)	 do { if (DEBUG >= l) __debug (a); } while (0)
+#define debug(a...)	 ldebug(1,a)
+#define fdebug(f, a...)	 do { if ((DEBUG >= 2) && f) __debug (a); } while (0)
+#define __ftrace(l,a...) do { if ((l)) __debug (a); } while (0)
+#define ftrace(a...)	 __ftrace((DEBUG >= 2),a)
+#define assert(c, a...)	 do { if ((DEBUG >= 0) && !(c)) BUG(); } while (0)
+
+
+/*
+ * Helpers for debugging memory allocation [needs to be here so it can
+ * be shared by ufuqueue.c and ufulock.c].
+ */
+
+#if DEBUG >= 1
+static atomic_t allocated_count = ATOMIC_INIT(0);
+static inline
+
+int allocated_get (void) {
+	return atomic_read (&allocated_count);
+}
+
+static inline
+int allocated_inc (void) {
+	atomic_inc (&allocated_count);
+	return allocated_get();
+}
+
+static inline
+int allocated_dec (void) {
+	atomic_dec (&allocated_count);
+	return allocated_get();
+}
+
+#else
+
+static inline int allocated_get (void) { return 0; }
+static inline int allocated_inc (void) { return 0; }
+static inline int allocated_dec (void) { return 0; }
+
+#endif /* DEBUG >= 1 */
+
+
+#endif /* #ifdef __KERNEL__ */
+#endif /* #ifndef __linux_fusyn_debug_h__ */
--- /dev/null	Thu Jul 22 14:30:56 2004
+++ kernel/fuqueue.c Mon Jul 19 16:29:29 2004
@@ -0,0 +1,349 @@
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
+ * Setup @current to wait for a fuqueue.
+ *
+ * This only setups, it does not block.
+ * 
+ * @fuqueue: fuqueue to wait on.
+ * @w: waiter structure to fill up and queue.
+ * @return: 0 if the fuqueue's priority didn't change, !0 otherwise.
+ *
+ * Fills up @current's fuqueue_wait* info and queues up @w after
+ * filling it.
+ *
+ * WARNING: Call with preempt and local IRQs disabled
+ */
+unsigned __fuqueue_waiter_queue (struct fuqueue *fuqueue,
+				 struct fuqueue_waiter *w)
+{
+	ftrace ("(%p, %p)\n", fuqueue, w);
+	
+	_raw_spin_lock (&current->fuqueue_wait_lock);
+	current->fuqueue_wait = fuqueue;
+	current->fuqueue_waiter = w;
+	_raw_spin_unlock (&current->fuqueue_wait_lock);
+	w->result = INT_MAX;
+	plist_init (&w->wlist_node, current->prio);
+	return plist_add (&fuqueue->wlist, &w->wlist_node);
+}
+
+
+/**
+ * Wait for a @fuqueue until woken up, @returns wake up code
+ *
+ * @fuqueue: where to wait on. Needs to be spinlocked.
+ * @w: waiter structure to wait with.
+ * @timeout: how long to wait. If ~0, wait for ever.
+ * 
+ * Needs to be called with the fuqueue lock held, local IRQs disabled
+ * and preempt disabled. Will release the lock, enable IRQs and
+ * preemtion. 
+ */
+int __fuqueue_waiter_block (struct fuqueue *fuqueue, struct fuqueue_waiter *w,
+			    const struct timeout *timeout)
+{
+	int result;
+	ftrace ("(%p, %p, %p)\n", fuqueue, w, timeout);
+	
+	set_current_state (TASK_INTERRUPTIBLE);
+	_raw_spin_unlock (&fuqueue->lock);
+	local_irq_enable();
+	preempt_enable_no_resched();
+	
+	/* Wait until we are woken up */
+	schedule_timeout_ext (timeout);
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
+	result = w->result;
+#warning FIXME: Need to recalc relative timeout if interrupted
+	if (unlikely (result == INT_MAX)) {
+		result = -ETIMEDOUT;
+		if (signal_pending (current))
+			result = -EINTR;
+		if (unlikely (current->fuqueue_wait != NULL))
+			__fuqueue_waiter_cancel (current, result);
+	}
+	return result;
+}
+
+
+/**
+ * Unqueue a single waiter and cleans up it's task wait information.
+ *
+ * Return -1 if the if the plist's priority didn't change, the new
+ * priority otherwise.
+ * 
+ * WARNING: call with preeempt and local IRQs disabled!!
+ */
+void __fuqueue_waiter_unqueue (struct fuqueue_waiter *w)
+{
+	struct task_struct *task = w->task;
+	
+	ftrace ("(%p [%d])\n", w, w->task->pid);
+	
+	__plist_del (&w->wlist_node);
+	_raw_spin_lock (&task->fuqueue_wait_lock);
+	task->fuqueue_wait = NULL;
+	task->fuqueue_waiter = NULL;
+	_raw_spin_unlock (&task->fuqueue_wait_lock);
+}
+
+
+/**
+ * Wait for a @fuqueue to be woken for as much as @timeout, @returns
+ * wake up code. See __fuqueue_waiter_block() for docs on @timeout.
+ *
+ * If wakeup code is FUQUEUE_WAITER_GOT_LOCK or -EOWNERDEAD, then it
+ * means the waiter was requeued to a fulock and that upon wake up, it
+ * was assigned ownership.
+ * 
+ * WARNING: can only be called from process context
+ */
+int fuqueue_wait (struct fuqueue *fuqueue, const struct timeout *timeout)
+{
+	struct fuqueue_waiter w = fuqueue_waiter_INIT (current);
+	
+	ftrace ("(%p, %p)\n", fuqueue, timeout);
+	
+	spin_lock_irq (&fuqueue->lock);
+	w.flags = FUQUEUE_WT_FL_QUEUE;
+	__fuqueue_waiter_queue (fuqueue, &w);
+	return __fuqueue_waiter_block (fuqueue, &w, timeout); /* unlocks */
+}
+
+
+int fuqueue_wait_fcb (struct fuqueue *fuqueue, const struct timeout *timeout,
+		      unsigned flags, fuqueue_wake_f wake_func)
+{
+	struct fuqueue_waiter w = fuqueue_waiter_INIT (current);
+	
+	ftrace ("(%p, %p)\n", fuqueue, timeout);
+	
+	spin_lock_irq (&fuqueue->lock);
+	w.flags = FUQUEUE_WT_FL_QUEUE | flags;
+	w.wake_func = wake_func;
+	__fuqueue_waiter_queue (fuqueue, &w);
+	return __fuqueue_waiter_block (fuqueue, &w, timeout); /* unlocks */
+}
+
+
+/*
+ * Wake @howmany waiters waiting on a @fuqueue, with return code (for
+ * them) @code.
+ *
+ *  
+ */
+#warning FIXME: how to emulate nr_exclusive from waitqueues?
+void fuqueue_wake_state (struct fuqueue *fuqueue, size_t howmany,
+			 int code, unsigned int state_mask, int sync)
+{
+	unsigned long flags;
+
+	ftrace ("(%p, %zu, %d, 0x%x, %d)\n", fuqueue, howmany, code,
+		state_mask, sync);
+	
+	spin_lock_irqsave (&fuqueue->lock, flags);
+	__fuqueue_wake_state (fuqueue, howmany, code, state_mask, sync);
+	spin_unlock_irqrestore (&fuqueue->lock, flags);
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
+	if (!_raw_spin_trylock (&fuqueue->lock)) {	/* Spin dance... */
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
+	if (task == NULL)	     /* no other task to propagate to? */
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
+	return plist_del (&fuqueue->wlist, &w->wlist_node);
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
+void __fuqueue_waiter_cancel (struct task_struct *task, int result)
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
+	if (!_raw_spin_trylock (&fuqueue->lock)) {	/* Spin dance... */
+		_raw_spin_unlock (&task->fuqueue_wait_lock);
+		goto retry;
+	}
+	ops = fuqueue->ops;
+	if (ops->get)
+		ops->get (fuqueue);
+
+	w = task->fuqueue_waiter;
+	
+	/* Do the specific cancel op */
+	ops->waiter_cancel (fuqueue, w);
+	w->result = result;
+	wmb();
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
