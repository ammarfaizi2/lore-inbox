Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264930AbUANXBV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 18:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbUANXBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 18:01:13 -0500
Received: from fmr05.intel.com ([134.134.136.6]:27783 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S265259AbUANWsf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 17:48:35 -0500
Date: Wed, 14 Jan 2004 14:50:27 -0800
From: inaky.perez-gonzalez@intel.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com, robustmutexes@lists.osdl.org
Subject: [RFC/PATCH] FUSYN 8/10: kernel fulocks
Message-ID: <0401141450.od8bZbVcfdkcKdCcXdtdZdFbcaNdraOc9031@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0401141450.hd9dXaUcSaKcZcYd5a~bqbjdmbqdJagd9031@intel.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 include/linux/fulock-olist.h |   55 ++++
 include/linux/fulock.h       |  282 +++++++++++++++++++++
 kernel/fulock.c              |  562 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 899 insertions(+)

--- /dev/null	Wed Jan 14 14:39:30 2004
+++ linux/include/linux/fulock-olist.h	Sun Nov 16 07:21:32 2003
@@ -0,0 +1,55 @@
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
+ * Fulock Ownership List
+ * 
+ * This file is here to avoid include hell, as sched.h needs it to be
+ * able to embed a fulock ownership list into 'struct
+ * task_struct'. Its sole users are sched.h and fulock.h.
+ *
+ * This is just a redirection of the methods used to manage the list
+ * of fulocks that a task owns in a given moment.
+ *
+ * I don't think anybody in its right mind wants to use a
+ * priority-array list for this, but just in case, and to ease the
+ * change of the implementation, I was redirecting it.
+ * 
+ * I will pull the plug on this one, search and replace all the
+ * olist_*() for plist_*() and wipe this file out as soon as I have a
+ * minute. I consider this low prio. 
+ */
+
+#ifndef __linux_fulock_olist_h__
+#define __linux_fulock_olist_h__
+
+#ifdef __KERNEL__
+
+#include <linux/plist.h>
+
+typedef struct plist olist_t;
+
+#define olist_add plist_add
+#define olist_rem plist_rem
+#define olist_init plist_init
+#define olist_INIT(plist) plist_INIT(plist)
+#define olist_for_each plist_for_each
+#define olist_for_each_safe plist_for_each_safe
+#define olist_empty plist_empty
+#define olist_first plist_first
+#define olist_prio plist_prio
+#define olist_chprio plist_chprio
+#if 0
+#define olist_update_prio plist_update_prio
+#define __olist_chprio __plist_chprio
+#endif
+
+#endif /* #ifdef __KERNEL__ */
+#endif /* #ifndef __linux_fulock_olist_h__ */
--- /dev/null	Wed Jan 14 14:39:30 2004
+++ linux/include/linux/fulock.h	Wed Jan  7 15:20:58 2004
@@ -0,0 +1,282 @@
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
+ */
+
+#ifndef __linux_fulock_h__
+#define __linux_fulock_h__
+
+#include <asm/fulock.h>
+
+/**
+ * User space provided fulock flags
+ *
+ * fulocks/ufulocks are *always* robust, it is up to the caller to
+ * emulate a hang if a robust behavior is not desired. However, the
+ * NOT_RM (not robust mutex) flag is kept and checked on exit and if
+ * there are owned fulocks, a warning will be printed.
+ */
+#define FULOCK_FL_USER_MK    0xfffff000 /* Flags provided by user space */
+#define FULOCK_FL_PI	     0x80000000 /* Priority inherit */
+#define FULOCK_FL_PP	     0x40000000 /* Priority protected */
+#define FULOCK_FL_RM_SUN     0x20000000 /* Robust mutex (sun style) */
+#define FULOCK_FL_RM	     0x10000000 /* Robust mutex [warns only] */
+#define FULOCK_FL_KCO        0x08000000 /* No fast path, KCO mode always */
+#define FULOCK_FL_ERROR_CHK  0x04000000 /* Perform POSIX error checks */
+/* Priority ceiling masks */
+#define FULOCK_FL_PP_PLC_MK  0x00f00000 /* Policy */
+#define FULOCK_FL_PP_PRIO_MK 0x000ff000 /* Priority */
+
+/** Fulock consistency state */
+enum fulock_st {
+	fulock_st_healthy,   /* Normal, healthy */
+	fulock_st_dead,	     /* Some previous owner died */
+	fulock_st_nr,	     /* idem, plus cannot be recovered */
+	fulock_st_init	     /* fulock was re-initialized */
+};
+
+
+/** Fulock consistency action */
+enum fulock_con {
+	fulock_con_nop = 0,   /* No-op, just return actual consistency */
+	fulock_con_init,      /* Move from any state to initialized */
+	fulock_con_heal,      /* Move from dead to healthy */
+	fulock_con_nr,	      /* Move from dead to not-recoverable */
+	fulock_con_destroy,   /* Tell the kernel to forget about it */
+	fulock_con_waiters,   /* Do we have waiters? */
+	fulock_con_locked     /* Is it locked? */
+};
+
+
+#ifdef __KERNEL__
+
+#include <linux/fuqueue.h>
+#include <linux/plist.h>
+#include <linux/vlocator.h>
+#include <asm/errno.h>
+
+/* Internal fulock flags */
+#define FULOCK_FL_NR	     0x00000100 /* not recoverable */
+#define FULOCK_FL_DEAD	     0x00000200 /* dead-owner */
+#define FULOCK_FL_NEW	     0x00000800 /* recently allocated ufulock */
+#define FULOCK_FL_PP_MK	     0x000000ff /* raw priority ceiling */
+
+struct fulock;
+
+/** Operations on a fulock. */
+struct fulock_ops 
+{
+	struct fuqueue_ops fuqueue;
+	void (* owner_set) (struct fulock *, struct task_struct *);
+	void (* owner_reset) (struct fulock *);
+	void (* exit) (struct fulock *);
+};
+
+/* In-kernel fulock operations */
+extern struct fulock_ops fulock_ops;
+extern struct fulock_ops ufulock_ops;
+extern struct vlocator_ops ufulock_vops;
+
+
+/** A fulock, mutex usable from the kernel. */
+struct fulock {
+	struct fuqueue fuqueue;
+	struct task_struct *owner;
+	unsigned flags;
+	olist_t olist_node;
+};
+
+
+/** Initialize a @fulock with given ops */
+static __inline__
+void __fulock_init (struct fulock *fulock, struct fulock_ops *ops)
+{
+	__fuqueue_init (&fulock->fuqueue, &ops->fuqueue);
+	fulock->owner = NULL;
+	fulock->flags = 0;
+	olist_init (&fulock->olist_node);
+}
+
+/** Statically initialize a @fulock with given ops */
+#define __fulock_INIT(fulock, ops) {				\
+	.fuqueue = __fuqueue_INIT (&(fulock)->fuqueue,		\
+				   &(ops)->fuqueue),		\
+	.owner = NULL,						\
+	.flags = 0,						\
+	.olist_node = olist_INIT (&(fulock)->olist_node)	\
+}
+
+/** Initialize a @fulock for usage within the kernel */
+static __inline__
+void fulock_init (struct fulock *fulock)
+{
+	__fulock_init (fulock, &fulock_ops);
+}
+
+/** Statically initialize a @fulock for usage within the kernel */
+#define fulock_INIT(fulock, ops) __fulock_INIT (fulock, &kernel_ops)
+
+
+/* Primitives for locking/unlocking/waiting/signalling */
+extern int __fulock_lock (struct fulock *,  signed long);
+extern int __fulock_unlock (struct fulock *, size_t, int);
+extern int __fulock_consistency (struct fulock *fulock,
+				 enum fulock_con consistency);
+extern void __fulock_exit (struct fulock *);
+extern void exit_fulocks (struct task_struct *task);
+
+extern int __fulock_pp_allowed (struct fulock *);
+extern void __fulock_pp_boost (struct fulock *);
+extern void __fulock_pp_unboost (struct fulock *);
+extern int __fulock_check_deadlock (struct task_struct *, struct fulock *);
+
+/** More internal stuff for building on top of fulock */
+extern unsigned __fulock_wait_cancel (struct fuqueue *, struct fuqueue_waiter *);
+extern struct task_struct * __fulock_chprio (struct task_struct *,
+					     struct fuqueue *,
+					     struct fuqueue_waiter *);
+
+
+/** Check if it is ok to for current to lock @fulock */
+static __inline__
+int __fulock_lock_check (struct fulock *fulock)
+{
+	int result = 0;
+	return result;
+}
+
+
+/**
+ * Lock a fulock, maybe wait for it to be available
+ *
+ * @timeout: wait to acquire the fulock as much @timeout jiffies. If
+ *	     zero, don't block, tryonly. If MAX_SCHEDULE_TIMEOUT,
+ *	     block indefinitely until the lock is acquired. 
+ *
+ * @returns: See __fulock_lock().
+ *
+ * Can ONLY be called from process context. Note __fulock_lock()
+ * unlocks the fulock on return and re-enables IRQs and preemption. 
+ */
+static __inline__
+int fulock_lock (struct fulock *fulock, signed timeout) 
+{
+	int result;
+	do {
+		spin_lock_irq (&fulock->fuqueue.lock);
+		result = __fulock_lock (fulock, timeout);
+	} while (result == -EAGAIN);
+	return result;
+}
+
+
+/**
+ * Unlock a fulock, wake up waiter(s)
+ *
+ * @f:	     fulock.
+ * @howmany: Wake up this many waiters; if 0, wake up only one,
+ *	     forcing a serialization in the acquisition of the
+ *	     futex, so that no other task (in user or kernel space)
+ *	     can acquire it.
+ * @returns: Number of tasks woken up, < 0 errno code on error.
+ *
+ * Can be called from any context [I hope].
+ */
+static __inline__
+int fulock_unlock (struct fulock *fulock, size_t howmany)
+{
+	int result;
+	unsigned long flags;
+	
+	ftrace ("(%p, %zu)\n", fulock, howmany);
+	
+	spin_lock_irqsave (&fulock->fuqueue.lock, flags);
+	result = __fulock_unlock (fulock, howmany, 0);
+	spin_unlock_irqrestore (&fulock->fuqueue.lock, flags);
+	return result;
+}
+
+
+/**
+ * Set the consistency of a fulock
+ *
+ * @f: fulock to set
+ * @consistency: New consistency state to move it to (unless it is
+ *		 fulock_con_nop, which is a nop and can be used to get
+ *		 the actual consistency state); see enum fulock_con.
+ *
+ * @returns: 'enum fulock_st' consistency state; < 0 errno code on
+ *	     error.
+ *
+ * FIXME: this function set is kind of too convoluted, I am afraid.
+ *
+ * Can be called from only from process context, as it checks for
+ * current being the current owner.
+ */
+static __inline__
+int fulock_consistency (struct fulock *fulock, enum fulock_con consistency)
+{
+	int result;
+	unsigned long flags;
+	ftrace ("(%p, %d)\n", fulock, consistency);
+	
+	spin_lock_irqsave (&fulock->fuqueue.lock, flags);
+	result = __fulock_consistency (fulock, consistency);
+	spin_unlock_irqrestore (&fulock->fuqueue.lock, flags);
+	return result;
+}
+
+
+/** A ufulock, tied to a user-space vm address. */
+struct ufulock {
+	struct fulock fulock;
+	struct vlocator vlocator;
+	struct page *page;
+};
+
+
+/** @Return true if the fulock @f has no waiters. */
+static __inline__
+unsigned __fulock_empty (const struct fulock *f)
+{
+	return __fuqueue_empty (&f->fuqueue);
+}
+
+
+/** [Internal] Make task @task the owner of fulock @f. */
+static __inline__
+void __fulock_owner_set (struct fulock *fulock, struct task_struct *task)
+{
+	ftrace ("(%p, %p [%d])\n", fulock, task, task->pid);
+	CHECK_IRQs();
+	
+	fulock->owner = task;
+	_raw_spin_lock (&task->fulock_olist_lock);
+	olist_add (&task->fulock_olist, &fulock->olist_node);
+	_raw_spin_unlock (&task->fulock_olist_lock);
+}
+
+
+/** [Internal] Reset ownership of fulock @f. */
+static __inline__
+void __fulock_owner_reset (struct fulock *fulock)
+{
+	struct task_struct *owner = fulock->owner;
+	ftrace ("(%p)\n", fulock);
+	CHECK_IRQs();
+  
+	_raw_spin_lock (&owner->fulock_olist_lock);
+	olist_rem (&owner->fulock_olist, &fulock->olist_node);
+	_raw_spin_unlock (&owner->fulock_olist_lock);
+	fulock->owner = NULL;
+}
+
+#endif /* #ifdef __KERNEL__ */
+#endif /* #ifndef __linux_fulock_h__ */
--- /dev/null	Wed Jan 14 14:39:30 2004
+++ linux/kernel/fulock.c	Mon Jan 12 14:56:44 2004
@@ -0,0 +1,562 @@
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
+ */
+
+#include <linux/fulock.h>
+#include <linux/plist.h>
+#include <linux/time.h>	    /* struct timespec */
+#include <linux/sched.h>    /* MAX_SCHEDULE_TIMEOUT */
+#include <linux/errno.h>
+
+/** Get the real priority from the real-time priority of a task. */
+static inline
+unsigned long prio_from_rt_prio (struct task_struct *task)
+{
+  return MAX_USER_RT_PRIO-1 - task->rt_priority;
+}
+
+
+/**
+ * Perform priority inheritance over the ownership chain
+ *
+ * @fulock: a waiter in this fulock was re-prioritized and the wlist
+ *          max priority changed; propagate that change. It has to be
+ *          locked. 
+ *
+ * Updates the position of the @fulock on its owner's ownership list
+ * and if this results on a changed maximum ownership list priority,
+ * propagate it up.
+ *
+ * This is also used for un-boosting when a waiter stops waiting and
+ * the priorities have to be shuffled back.
+ *
+ * WARNING: Needs to be called with IRQs and preemtion disabled.
+ */
+void __fulock_pi_boost (struct fulock *fulock)
+{
+	unsigned prio_changed;
+	struct task_struct *owner = fulock->owner;
+	unsigned long new_prio = wlist_prio (&fulock->fuqueue.wlist);
+
+	ftrace ("(%p)\n", fulock);
+	CHECK_IRQs();
+	
+	_raw_spin_lock (&owner->fulock_olist_lock);
+	prio_changed = olist_chprio (&owner->fulock_olist, &fulock->olist_node,
+				     new_prio);
+	_raw_spin_unlock (&owner->fulock_olist_lock);
+	if (prio_changed) {
+		new_prio = min (prio_from_rt_prio (owner), new_prio);
+		if (new_prio != owner->prio) {
+			ldebug (1, "__set_prio (%d, %lu)\n", owner->pid, new_prio);
+			__set_prio (owner, new_prio);
+			/* Now the priority changed for the owner, so we need
+			 * to propagate it */
+			fuqueue_chprio (owner);
+		}
+	}
+}
+
+
+/**
+ * Test if a to-be queued task would deadlock if it waits for a fulock.
+ *
+ * Simple as it is, it looks ugly as hell. Basically, the fulock we
+ * are about to lock will have an owner, so we check the owner; if it
+ * is us, deadlock, if not, we see if the fulock is waiting for
+ * anything; if so, we check it is a fulock, and if so, who's the
+ * owner; if it is us, then deadlock, if not, start again ...
+ *
+ * Now, the trick is to keep the reference counts, and the locks and
+ * all the crap. A single lock for everything would be *so* beautiful
+ * (and not scalable :).
+ * 
+ * @task: the task to check
+ * @fulock: the fulock to check
+ * @returns: 0 if ok, < 0 errno on error.
+ *
+ * This *should* be safe being lock-less [famous last words].
+ *
+ * WARNING: Needs to be called with IRQs and preemtion disabled.
+ */
+int __fulock_check_deadlock (struct task_struct *task, struct fulock *fulock)
+{
+	int result = 0;
+	struct fuqueue_ops *ops;
+	struct task_struct *owner;
+	struct fuqueue *fuqueue;
+	
+	ftrace ("(%p, %p)\n", task, fulock);
+	CHECK_IRQs();
+	
+	/* first fulock to trace is already locked and we won't unlock it */
+	owner = fulock->owner;
+	if (owner == NULL)
+		goto out;
+	result = -EDEADLK;
+	if (owner == task)
+		goto out;
+	get_task_struct (owner);
+next:
+	result = 0;
+	/* Who is the owner waiting for? safely acquire and lock it */
+	_raw_spin_lock (&owner->fuqueue_wait_lock);
+	fuqueue = owner->fuqueue_wait;
+	if (fuqueue == NULL)				/* Ok, not waiting */
+		goto out_owner_unlock;
+	if (!_raw_spin_trylock (&fuqueue->lock)) {      /* Spin dance... */
+		_raw_spin_unlock (&owner->fuqueue_wait_lock);
+		goto next;
+	}
+	ops = fuqueue->ops;
+	if (ops->get)
+		ops->get (fuqueue);
+	_raw_spin_unlock (&owner->fuqueue_wait_lock);	
+	put_task_struct (owner);
+	
+	/* Is a fulock whatever the owner is waiting for? */
+	if (ops != &fulock_ops.fuqueue && ops != &ufulock_ops.fuqueue)
+		goto out_fuqueue_unlock;
+	fulock = container_of (fuqueue, struct fulock, fuqueue);
+	owner = fulock->owner;                /* Who's the fulock's owner? */
+	if (unlikely (owner == NULL))         /* Released before we locked it? */
+		goto out_fuqueue_unlock;	
+	result = -EDEADLK;                    /* It is us? ooops */
+	if (owner == task)
+		goto out_fuqueue_unlock;
+	
+	/* What's the owner waiting for? Proceed to it */
+	get_task_struct (owner);
+	_raw_spin_unlock (&fulock->fuqueue.lock);
+	if (ops->put)
+		ops->put (fuqueue);
+	goto next;
+
+out_owner_unlock:
+	_raw_spin_unlock (&owner->fuqueue_wait_lock);
+	put_task_struct (owner);
+	return result;
+	
+out_fuqueue_unlock:
+	_raw_spin_unlock (&fulock->fuqueue.lock);
+	if (ops->put)
+		ops->put (fuqueue);
+out:
+	return result;
+}
+
+
+/**
+ * [Try]lock a fulock
+ *
+ * @f: fulock to [try]lock.
+ * @timeout: Time to wait for the lock to be acquired. If 0, trylock
+ *	     only, if MAX_SCHEDULE_TIMEOUT, wait for ever, else, wait
+ *	     the given time. 
+ * @returns: 0	     Acquired the fulock
+ *	     -EOWNERDEAD  Acquired the fulock, some previous owner died.
+ *	     -ENOTRECOVERABLE  Not acquired, fulock is not recoverable
+ *	     -EBUSY  Not acquired, it is locked [and trylock was
+ *		     requested].
+ *	     -EAGAIN Not acquired, try again [FIXME: change this,
+ *		     POSIX uses it for mutexes].
+ *	     *	     Not acquired, error.
+ *
+ * Needs f->lock held; on return, it will have been released.
+ *
+ * Note that some operations involving flag reading don't need locking
+ * because for changing those values, we calling task needs to be the
+ * owner of the fulock, and once we come out of wait without errors,
+ * we are the owners.
+ *
+ * WARNING: Needs to be called with IRQs and preemtion disabled [the
+ * fuqueue lock acquired with spin_lock_irq()].
+ */
+int __fulock_lock (struct fulock *fulock, signed long timeout)
+{
+	int fulock_is_pp;
+	int result = 0;
+	unsigned prio_changed;
+	struct fulock_ops *ops =
+		container_of (fulock->fuqueue.ops, struct fulock_ops, fuqueue);
+	struct fuqueue_waiter w;
+	
+	ftrace ("(%p [flags 0x%x], %ld)\n", fulock, fulock->flags, timeout);
+
+	result = -ENOTRECOVERABLE;
+	if (fulock->flags & FULOCK_FL_NR)	/* can we lock? */
+		goto out_unlock;
+	if (fulock->flags & FULOCK_FL_ERROR_CHK) {
+		result = __fulock_check_deadlock (current, fulock);
+		if (result < 0)
+			goto out_unlock;
+	}
+	fulock_is_pp = fulock->flags & FULOCK_FL_PP;
+	if (fulock_is_pp) {
+		result = __fulock_pp_allowed (fulock);
+		if (result)
+			goto out_unlock;
+	}
+	if (fulock->owner == NULL)		/* Unlocked? take it */
+		goto its_unlocked;
+	/* Nchts, we have to wait. */
+	result = -EBUSY;
+	if (!timeout)
+		goto out_unlock;
+	prio_changed = __fuqueue_wait_queue (&fulock->fuqueue, &w);
+	if (prio_changed && fulock->flags & FULOCK_FL_PI)
+		__fulock_pi_boost (fulock);
+	return __fuqueue_wait_block (&fulock->fuqueue, &w, timeout);
+
+its_unlocked:
+	result = fulock->flags & FULOCK_FL_DEAD? -EOWNERDEAD : 0;
+	ops->owner_set (fulock, current);
+	if (fulock_is_pp)
+		__fulock_pp_boost (fulock);
+out_unlock:
+	_raw_spin_unlock (&fulock->fuqueue.lock);
+	local_irq_enable();
+	preempt_enable();
+	return result;
+}
+
+
+/**
+ * Unlock a fulock, wake up waiter(s) [internal version]
+ *
+ * @fulock:  Address for the fulock (kernel space).
+ * @howmany: Wake up this many waiters; if 0, wake up only one,
+ *	     forcing a serialization in the acquisition of the
+ *	     futex, so that no other task (in user or kernel space)
+ *	     can acquire it.
+ * @code:    If waking up in parallel mode, return code to be passed to
+ *           the waiters as a result of their wait. 
+ * @returns: 0 if the fulock was unlocked/there are no waiters left or
+ *             howmany > 0
+ *	     1 fulock ownership transferred to 1st waiter, there was
+ *	       one waiter (now none)
+ *	     2 fulock ownership transferred to 1st waiter, there was
+ *             more than one waiter 
+ *	     
+ *	     ufulock_unlock() uses this to update the vfulock, except
+ *           if howmany > 0.
+ *           
+ * Requires fulock->fuqueue.lock held, IRQs & preempt disabled!!!
+ */
+int __fulock_unlock (struct fulock *fulock, size_t howmany, int code)
+{
+	int result = 0;
+	struct fulock_ops *ops =
+		container_of (fulock->fuqueue.ops, struct fulock_ops, fuqueue);
+	struct task_struct *owner;
+	struct fuqueue_waiter *w;
+	
+	ftrace ("(%p, %zu, %d)\n", fulock, howmany, code);
+	CHECK_IRQs();
+	
+	if (fulock->owner == NULL)		/* Unlocked? */
+		goto out;
+	owner = fulock->owner;
+	ops->owner_reset (fulock);
+	if (__fulock_empty (fulock))
+		goto out_unboost;
+	if (howmany > 0) {			/* Parallel unlock */
+		code = code == 0? -EAGAIN : code;
+		while (howmany-- && !__fuqueue_empty (&fulock->fuqueue)) {
+			w = __fuqueue_first (&fulock->fuqueue);
+			__fuqueue_wait_unqueue (w, code);
+			wake_up_process (w->task);
+		}
+	}
+	else {					/* Serialized unlock */
+		w = __fuqueue_first (&fulock->fuqueue);
+		ops->owner_set (fulock, w->task);
+		if (fulock->flags & FULOCK_FL_PP)
+			__fulock_pp_boost (fulock);
+		code = fulock->flags & FULOCK_FL_DEAD? -EOWNERDEAD : 0;
+		__fuqueue_wait_unqueue (w, code);
+		wake_up_process (w->task);
+		result = __fulock_empty (fulock)? 1 : 2;
+	}
+	/* Now, once we have done it, we can unboost PI or PP */
+out_unboost:
+	if (fulock->flags & FULOCK_FL_PP)
+		__fulock_pp_unboost (fulock);
+	else if (fulock->flags & FULOCK_FL_PI
+		 && owner->prio != prio_from_rt_prio (owner)) {
+		/* We were boosted, undo that */
+		ldebug (1, "__set_prio (%d, %lu)\n", owner->pid, prio_from_rt_prio (owner));
+		__set_prio (owner, prio_from_rt_prio (owner));
+		fuqueue_chprio (owner); /* owner might be waiting */
+	}
+out:
+	return result;
+}
+
+
+/**
+ * Set the consistency of a fulock, get previous.
+ *
+ * @fulock: fulock whose consistency is to be set [fulock->fuqueue.lock
+ *	    has to be held]. 
+ * @consistency: New consistency state to move it to (unless it is
+ *		 fulock_con_get, which is a nop and can be used to get
+ *		 the actual consistency state.
+ *
+ * @returns: consistency state
+ */
+int __fulock_consistency (struct fulock *fulock, enum fulock_con consistency)
+{
+	int result;
+	enum fulock_st state;
+
+	ftrace ("(%p, %d)\n", fulock, consistency);
+	CHECK_IRQs();
+	
+	/* Gather actual state */
+	if (fulock->flags & FULOCK_FL_NR)
+		state = fulock_st_nr;
+	else if (fulock->flags & FULOCK_FL_DEAD)
+		state = fulock_st_dead;
+	else
+		state = fulock_st_healthy;
+	
+	/* Now, what to do? */
+	switch (consistency) {
+	    /* Nothing, so just say how are we standing */
+	    case fulock_con_nop:
+		result = state;
+		break;
+
+	    /* Reinitialize it */
+	    case fulock_con_init:
+		fulock->flags &= ~(FULOCK_FL_DEAD | FULOCK_FL_NR);
+		__fulock_unlock (fulock, (size_t) ~0, -ENOENT);
+		result = fulock_st_init;
+		break;
+		
+	    /* Mark it healthy */
+	    case fulock_con_heal:
+		result = -EINVAL;
+		if (state != fulock_st_dead)
+			break;
+		result = -EPERM;
+		if (fulock->owner != current)	/* Who are you? */
+			break;
+		fulock->flags &= ~FULOCK_FL_DEAD;
+		result = fulock_st_healthy;
+		break;
+		
+	    /* Make it not recoverable; wake up every waiter with error;
+	     * unlock. */ 
+	    case fulock_con_nr:
+		result = -EINVAL;
+		if (state != fulock_st_dead)
+			break;
+		result = -EPERM;
+		if (fulock->owner != current)	/* Who are you? */
+			break;
+		result = __fulock_unlock (fulock, (size_t)~0, -ENOTRECOVERABLE);
+		if (result >= 0) {
+			fulock->flags &= ~FULOCK_FL_DEAD;
+			fulock->flags |= FULOCK_FL_NR;
+			result = fulock_st_nr;
+		}
+		break;
+
+	    default:
+		result = -EINVAL;
+	}
+	return result;
+}
+
+
+/**
+ * Set the priority of a fulock waiter.
+ *
+ * @task: task to re-prioritize 
+ * @fuqueue: fuqueue of the fulock the task is waiting for [locked]
+ * @w: waiter @task is waiting on in @fuqueue.
+ * @prio: new priority (prio
+ * @returns: NULL (as there is no propagation), task to propage to.
+ *
+ * This does not set the prio of the process itself!
+ *
+ * This will just reposition it in the wait list and if priority
+ * inheritance is enabled, reposition in the ownership list.
+ * 
+ * Now, after repositioning in the wait list, we have to do the same
+ * in the ownership list. If we have set a new maximum, and that
+ * maximum is different to the current task->prio, then we have to
+ * update, so we return a task pointer that needs to be referenced.
+ * 
+ * WARNING: Needs to be called with IRQs and preemtion disabled.
+ */
+struct task_struct * __fulock_chprio (struct task_struct *task,
+				      struct fuqueue *fuqueue,
+				      struct fuqueue_waiter *w)
+{
+	unsigned prio_changed;
+	unsigned long new_prio;
+	struct fuqueue_ops *ops;
+	struct fulock *fulock;
+	struct task_struct *owner = NULL;
+
+	ftrace ("(%p [%d], %p, %p)\n", task, task->pid, fuqueue, w);
+	CHECK_IRQs();
+	
+	/* Verify this is really a fulock */
+	ops = fuqueue->ops;
+	BUG_ON (ops != &fulock_ops.fuqueue && ops != &ufulock_ops.fuqueue);
+	fulock = container_of (fuqueue, struct fulock, fuqueue);
+	/* Update the wlist of our fulock */
+	__fuqueue_chprio (task, fuqueue, w); /* fuqueue is locked */
+#warning FIXME: trap if in the middle, the task stopped waiting?
+	/* Now, if we ain't PI, there is no point in continuing */
+	if (!(fulock->flags & FULOCK_FL_PI))
+		goto out;
+	/* And if it is unlocked, somebody unlocked just before we
+	 * came here, so we'll do nothing */
+	owner = fulock->owner;
+	if (unlikely (owner == NULL))
+		goto out;
+	/* Ok, we have to propagate, reposition in the ownership list,
+	 * and if the max prio changed and it is higher than the
+	 * owner's priority, then we have to go with him */
+	new_prio = wlist_prio (&fuqueue->wlist);
+	_raw_spin_lock (&owner->fulock_olist_lock);
+	prio_changed = olist_chprio (&owner->fulock_olist, &fulock->olist_node,
+				     new_prio);
+	_raw_spin_unlock (&owner->fulock_olist_lock);
+	if (prio_changed) {
+		new_prio = min (prio_from_rt_prio (owner), new_prio);
+		if (new_prio != owner->prio)
+			goto out;
+	}
+	owner = NULL;
+out:
+	return owner;
+}
+
+
+/**
+ * Initialize fulock specific stuff for a task
+ *
+ */
+void init_fulock (struct task_struct *task)
+{
+	__ftrace (0, "(task %p)\n", task);
+	
+	spin_lock_init (&task->fuqueue_wait_lock);
+	task->fuqueue_wait = NULL;
+	task->fuqueue_waiter = NULL;
+	spin_lock_init (&task->fulock_olist_lock);
+	olist_init (&task->fulock_olist);
+}
+
+
+/** Release as dead a @fulock because the owner is exiting. */
+void __fulock_exit (struct fulock *fulock)
+{
+	ftrace ("(%p)\n", fulock);
+
+	fulock->flags |= FULOCK_FL_DEAD;
+	if (!(fulock->flags & FULOCK_FL_RM))
+		printk (KERN_WARNING "Task %d [%s] exited holding non-robust "
+			"fulock %p; waiters might block for ever\n",
+			current->pid, current->comm, fulock);
+	__fulock_unlock (fulock, 0, -EOWNERDEAD);
+}
+
+
+/**
+ * When @task exits, release all the fulocks it holds as dead.
+ *
+ * We have to discriminate between ufulocks and locks; when it is an
+ * ufulock, we just need to see if we have to put() the reference that
+ * the owner had or not (when the ownership is successfully passed to
+ * somebody else, we don't have to put it).
+ */
+#warning FIXME: hook up to exec()?
+void exit_fulocks (struct task_struct *task)
+{
+	olist_t *itr;
+	struct fulock *fulock;
+	struct fulock_ops *ops;
+	unsigned long flags;
+	
+	if (DEBUG > 0 && !olist_empty (&task->fulock_olist))
+		ftrace ("(%p [%d])\n", task, task->pid);
+
+	/* FIXME: there is a better way to do this, but I feel toooo
+	 * thick today -- the problem is fulock->ops->exit() is going
+	 * to take fulock_olist_lock to reset the ownership...so
+	 * whatever it is, we have to call without holding it. */
+	local_irq_save (flags);
+	preempt_disable();
+	_raw_spin_lock (&task->fulock_olist_lock);
+	while (!olist_empty (&task->fulock_olist)) {
+		itr = olist_first (&task->fulock_olist);
+		fulock = container_of (itr, struct fulock, olist_node);
+		ldebug (7, "task %p [%d] still owns fulock %p\n",
+			task, task->pid, fulock);
+		ops = container_of (fulock->fuqueue.ops,
+				    struct fulock_ops, fuqueue);
+		if (ops->fuqueue.get)
+			ops->fuqueue.get (&fulock->fuqueue);
+		_raw_spin_unlock (&task->fulock_olist_lock);
+		
+		_raw_spin_lock (&fulock->fuqueue.lock);	  
+		ops->exit (fulock); /* releases fulock lock */
+		_raw_spin_unlock (&fulock->fuqueue.lock);
+		
+		if (ops->fuqueue.put)
+			ops->fuqueue.put (&fulock->fuqueue);
+		_raw_spin_lock (&task->fulock_olist_lock);
+	}
+	_raw_spin_unlock (&task->fulock_olist_lock);
+	local_irq_restore (flags);
+	preempt_enable();
+}
+
+
+/** Cancel @task's wait on @fuqueue and update the wait list priority */
+unsigned __fulock_wait_cancel (struct fuqueue *fuqueue,
+			   struct fuqueue_waiter *w)
+{
+	unsigned prio_change;
+	struct fulock *fulock =
+		container_of (fuqueue, struct fulock, fuqueue);
+	
+	ftrace ("(%p, %p [%d], %p)\n",
+		fuqueue, w, w->task->pid, w);
+
+	prio_change = __fuqueue_wait_cancel (fuqueue, w);
+	ldebug (2, "prio_change is %u\n", prio_change);
+	if (prio_change && (fulock->flags & FULOCK_FL_PI))
+		__fulock_pi_boost (fulock);
+	return prio_change;
+}
+
+
+/** Fulock operations */
+struct fulock_ops fulock_ops = {
+	.fuqueue = {
+		.get = NULL,
+		.put = NULL,
+		.wait_cancel = __fulock_wait_cancel,
+		.chprio = __fulock_chprio
+	},
+	.owner_set = __fulock_owner_set,
+	.owner_reset = __fulock_owner_reset,
+	.exit = __fulock_exit
+};
+
