Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264708AbUDUEPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264708AbUDUEPO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 00:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264752AbUDUEN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 00:13:27 -0400
Received: from ip-66-80-228-130.sjc.megapath.net ([66.80.228.130]:36083 "EHLO
	sodium.co.intel.com") by vger.kernel.org with ESMTP id S264709AbUDUD66
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 23:58:58 -0400
Date: Tue, 20 Apr 2004 21:04:16 -0700
From: inaky.perez-gonzalez@intel.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com
Subject: [RFC/PATCH] FUSYN 10/11: kernel fulocks
Message-ID: <0404202104.Ya9btbMbKc5dKcmalc4a8dQccalaAdSa1457@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0404202104.qb0acdJdRc1dgc9bMdqbzbBcccWaqa0d1457@intel.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 include/linux/fulock-olist.h |   55 +++
 include/linux/fulock.h       |  278 +++++++++++++++++++
 kernel/fulock.c              |  605 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 938 insertions(+)

--- /dev/null	Thu Apr 15 00:58:25 2004
+++ include/linux/fulock-olist.h Wed Jan 28 23:25:36 2004
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
+#define __olist_chprio __plist_chprio
+#if 0
+#define olist_update_prio plist_update_prio
+#endif
+
+#endif /* #ifdef __KERNEL__ */
+#endif /* #ifndef __linux_fulock_olist_h__ */
--- /dev/null	Thu Apr 15 00:58:25 2004
+++ include/linux/fulock.h Thu Apr 8 00:14:02 2004
@@ -0,0 +1,278 @@
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
+enum {
+	FULOCK_FL_USER_MK =	0xfffff000, /* Flags provided by user space */
+	FULOCK_FL_PI =		0x80000000, /* Priority inherit */
+	FULOCK_FL_PP =		0x40000000, /* Priority protected */
+	FULOCK_FL_RM_SUN =	0x20000000, /* Robust mutex (sun style) */
+	FULOCK_FL_RM =		0x10000000, /* Robust mutex [warns only] */
+	FULOCK_FL_KCO =		0x08000000, /* No fast path, KCO mode always */
+	FULOCK_FL_ERROR_CHK =	0x04000000, /* Perform POSIX error checks */
+/* Priority ceiling masks */
+	FULOCK_FL_PP_PLC_MK =	0x00f00000, /* Policy */
+	FULOCK_FL_PP_PRIO_MK =	0x000ff000  /* Priority */
+};
+
+/** Fulock health state */
+enum fulock_st {
+	fulock_st_healthy,   /* Normal, healthy */
+	fulock_st_dead,	     /* Some previous owner died */
+	fulock_st_nr,	     /* idem, plus cannot be recovered */
+	fulock_st_init	     /* fulock was re-initialized */
+};
+
+
+/** Fulock control actions */
+enum fulock_ctl {
+	fulock_ctl_nop = 0,   /* No-op, just return actual health state */
+	fulock_ctl_init,      /* Move from any state to initialized */
+	fulock_ctl_heal,      /* Move from dead to healthy */
+	fulock_ctl_nr,	      /* Move from dead to not-recoverable */
+	fulock_ctl_destroy,   /* Tell the kernel to forget about it */
+	fulock_ctl_waiters,   /* Do we have waiters? */
+	fulock_ctl_locked,    /* Is it locked? */
+	fulock_ctl_setprioceil	/* Set the priority ceiling */
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
+enum {
+	FULOCK_FL_NR =		0x00000100, /* not recoverable */
+	FULOCK_FL_DEAD =	0x00000200, /* dead-owner */
+	FULOCK_FL_NEEDS_SYNC =	0x00000800, /* Need sync from user space */
+	FULOCK_FL_PP_MK =	0x000000ff  /* raw priority ceiling */
+};
+
+struct fulock;
+
+/** Operations on a fulock. */
+struct fulock_ops 
+{
+	struct fuqueue_ops fuqueue;
+	unsigned (* owner_set) (struct fulock *, struct task_struct *);
+	unsigned (* owner_reset) (struct fulock *);
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
+extern int __fulock_ctl (struct fulock *fulock, enum fulock_ctl ctl);
+extern void __fulock_op_exit (struct fulock *);
+extern void exit_fulocks (struct task_struct *task);
+
+extern int __fulock_check_deadlock (struct task_struct *, struct fulock *);
+
+/** More internal stuff for building on top of fulock */
+extern unsigned __fulock_op_waiter_cancel (struct fuqueue *,
+					 struct fuqueue_waiter *);
+extern struct task_struct * __fulock_op_waiter_chprio (
+	struct task_struct *, struct fuqueue *, struct fuqueue_waiter *);
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
+ * Manipulate the state of a fulock
+ *
+ * @f: fulock to set
+ * @ctl: Control command to modify the fulock's state.
+ * @returns: 'enum fulock_st' health state; < 0 errno code on
+ *	     error.
+ *
+ * FIXME: this function set is kind of too convoluted, I am afraid.
+ *
+ * Can be called from only from process context, as it checks for
+ * current being the current owner.
+ */
+static __inline__
+int fulock_ctl (struct fulock *fulock, enum fulock_ctl ctl)
+{
+	int result;
+	unsigned long flags;
+	ftrace ("(%p, %d)\n", fulock, ctl);
+	
+	spin_lock_irqsave (&fulock->fuqueue.lock, flags);
+	result = __fulock_ctl (fulock, ctl);
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
+unsigned __fulock_op_owner_set (struct fulock *fulock,
+				struct task_struct *task)
+{
+	unsigned prio_changed;
+	
+	ftrace ("(%p, %p [%d])\n", fulock, task, task->pid);
+	CHECK_IRQs();
+	
+	fulock->owner = task;
+	_raw_spin_lock (&task->fulock_olist_lock);
+	prio_changed = olist_add (&task->fulock_olist, &fulock->olist_node);
+	_raw_spin_unlock (&task->fulock_olist_lock);
+	return prio_changed;
+}
+
+
+/** [Internal] Reset ownership of fulock @f. */
+static __inline__
+unsigned __fulock_op_owner_reset (struct fulock *fulock)
+{
+	unsigned prio_changed;
+	struct task_struct *owner = fulock->owner;
+	ftrace ("(%p)\n", fulock);
+	CHECK_IRQs();
+  
+	_raw_spin_lock (&owner->fulock_olist_lock);
+	prio_changed = olist_rem (&owner->fulock_olist, &fulock->olist_node);
+	_raw_spin_unlock (&owner->fulock_olist_lock);
+	fulock->owner = NULL;
+	return prio_changed;
+}
+
+
+#endif /* #ifdef __KERNEL__ */
+#endif /* #ifndef __linux_fulock_h__ */
--- /dev/null	Thu Apr 15 00:58:25 2004
+++ kernel/fulock.c Wed Apr 14 01:48:24 2004
@@ -0,0 +1,605 @@
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
+#warning FIXME: make the fulock in-kernel interface more clear
+#warning TODO: FIFO mode for the waiters list
+
+
+/**
+ * A waiter on this fulock was added, removed or reprioritized and
+ * that caused the wlist priority to change, so we must update the
+ * fulock priority in the owner's ownership list.
+ *
+ * @fulock: The defendant [nossir, I haven't been groklawing]. 
+ * @returns: !0 f the boost priority for the owner was changed.
+ * 
+ * WARNING: Needs to be called with IRQs and preemtion disabled.
+ */
+static
+unsigned __fulock_prio_update (struct fulock *fulock)
+{
+	unsigned prio_changed;
+	struct task_struct *owner;
+	int prio;
+	unsigned result = 0;
+
+	ftrace ("(%p)\n", fulock);
+
+	owner = fulock->owner;
+	prio = wlist_prio (&fulock->fuqueue.wlist);
+	if (owner == NULL) {
+		prio_changed = olist_prio (&fulock->olist_node) != prio;
+		__olist_chprio (&fulock->olist_node, prio);
+		goto out;
+	}
+	/* reposition this fulock on it's owner's ownership list */
+	_raw_spin_lock (&owner->fulock_olist_lock);
+	prio_changed = olist_chprio (&owner->fulock_olist,
+				     &fulock->olist_node, prio);
+	_raw_spin_unlock (&owner->fulock_olist_lock);
+	/* there is a new maximum on the list? maybe chprio the owner */
+	ldebug (2, "prio boosting %d to prio %d (current %d)\n",
+		owner->pid, prio, owner->prio);
+	if (prio_changed)
+		result = __prio_boost (owner, prio);
+out:
+	ldebug (2, "fulock %p, updated prio to %d (changed %d), "
+		"propagating to owner, pid %d (changed %d)\n",
+		fulock, prio, prio_changed, owner->pid, result);
+	return result;
+}
+
+
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
+ * Check if a process is allowed to lock a PP fulock.
+ *
+ * @fulock: fulock to check on.
+ * @returns: 0 if ok, errno code on error (disallowed)
+ */
+int __fulock_pp_allowed (struct fulock *fulock)
+{
+#warning FIXME: finish _pp_allowed()
+#if 0
+	int policy = fulock->flags & FULOCK_FL_PP_PLC_MK >> 20;
+	int priority = fulock->flags & FULOCK_FL_PP_PRIO_MK >> 12;
+	int prio;
+
+	if (policy != SCHED_NORMAL)
+		prio = MAX_USER_RT_PRIO - 1 - priority;
+	else
+		prio = priority;
+	fulock->flags &= ~FULOCK_FL_PP_PRIO_MK;
+	fulock->flags |= prio & FULOCK_FL_PP_PRIO_MK;
+#warning FIXME: interaction with PI? Compare against static, not dynamic?
+	if (prio > current->prio)
+		return -EINVAL;
+#endif
+	return 0;
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
+	int prio_changed;
+	int result = 0;
+	int prio = BOTTOM_PRIO;
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
+	if (fulock->flags & FULOCK_FL_PP) {
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
+	prio_changed = __fuqueue_waiter_queue (&fulock->fuqueue, &w);
+	if (prio_changed
+	    && fulock->flags & FULOCK_FL_PI
+	    && __fulock_prio_update (fulock))
+		__fuqueue_waiter_chprio (fulock->owner);
+	return __fuqueue_waiter_block (&fulock->fuqueue, &w, timeout);
+
+its_unlocked:
+	result = fulock->flags & FULOCK_FL_DEAD? -EOWNERDEAD : 0;
+	prio_changed = ops->owner_set (fulock, current);
+	if (prio_changed) {
+		/* The ownership list's prio changed, update boost */
+		prio = olist_prio (&fulock->olist_node);
+		__prio_boost (current, prio);
+	}
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
+#warning TODO: automatic selection of unlock mode [as suggested by Jamie]
+int __fulock_unlock (struct fulock *fulock, size_t howmany, int code)
+{
+	int result = 0;
+	int old_prio_changed, new_prio_changed;
+	struct fulock_ops *ops =
+		container_of (fulock->fuqueue.ops, struct fulock_ops, fuqueue);
+	struct task_struct *old_owner, *new_owner;
+	struct fuqueue_waiter *w = NULL;
+	
+	ftrace ("(%p, %zu, %d)\n", fulock, howmany, code);
+	
+	if (fulock->owner == NULL)		/* Unlocked? */
+		goto out;
+	old_owner = fulock->owner;
+	old_prio_changed = ops->owner_reset (fulock);
+	if (__fulock_empty (fulock))
+		goto out_unboost;
+	if (howmany > 0) {			/* Parallel unlock */
+		code = code == 0? -EAGAIN : code;
+		while (howmany-- && !__fuqueue_empty (&fulock->fuqueue)) {
+			w = __fuqueue_first (&fulock->fuqueue);
+			__fuqueue_waiter_unqueue (w, code);
+			wake_up_process (w->task);
+		}
+		if (likely (w != NULL))
+			wlist_update_prio (&fulock->fuqueue.wlist);
+	}
+	else {					/* Serialized unlock */
+		w = __fuqueue_first (&fulock->fuqueue);
+		code = fulock->flags & FULOCK_FL_DEAD? -EOWNERDEAD : 0;
+		__fuqueue_waiter_unqueue (w, code);
+		/* Do PI: Update the wlist's top priority (in case it
+		 * changed). If it did, then change the prio of the
+		 * fulock (in the olist_node); will chprio the task later */
+		new_prio_changed = wlist_update_prio (&fulock->fuqueue.wlist);
+		if (new_prio_changed && fulock->flags & FULOCK_FL_PI)
+			__olist_chprio (&fulock->olist_node,
+					wlist_prio (&fulock->fuqueue.wlist));
+		/* Now register owner, queue the fulock in w->task's
+		 * ownership list; if prio of olist changes, boost */
+		new_owner = w->task;
+		ldebug (2, "olist prio before upgrade %d\n",
+			olist_prio (&new_owner->fulock_olist));
+		new_prio_changed = ops->owner_set (fulock, new_owner);
+		ldebug (2, "olist prio after upgrade %d, new_prio_changed %d\n",
+			olist_prio (&new_owner->fulock_olist), new_prio_changed);
+		if (new_prio_changed) {
+			int prio = olist_prio (&new_owner->fulock_olist);
+			ldebug (2, "__prio_boost pid %d to %d\n", new_owner->pid, prio);
+			__prio_boost (new_owner, prio);
+		}
+		wake_up_process (new_owner);
+		result = __fulock_empty (fulock)? 1 : 2;
+	}
+	/* Now we can unboost (if we have to). prio_changed can be
+	 * true only if PI or PP (and the prio actually changed) */
+out_unboost:
+	ldebug (2, "old_prio_changed %d, new boost prio %d\n",
+		old_prio_changed, wlist_prio (&fulock->fuqueue.wlist));
+	if (old_prio_changed
+	    && __prio_boost (old_owner, wlist_prio (&fulock->fuqueue.wlist))) {
+		ldebug (2, "here\n");
+		__fuqueue_waiter_chprio (old_owner);
+	}
+out:
+	return result;
+}
+
+
+/**
+ * Modify/query the internal state of a fulock.
+ *
+ * @fulock: fulock to modify. 
+ * @ctl: control command to issue.
+ * @returns: health state
+ */
+int __fulock_ctl (struct fulock *fulock, enum fulock_ctl ctl)
+{
+	int result;
+	enum fulock_st state;
+
+	ftrace ("(%p, %d)\n", fulock, ctl);
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
+	switch (ctl) {
+		/* Nothing, so just say how are we standing */
+	case fulock_ctl_nop:
+		result = state;
+		break;
+
+		/* Reinitialize it */
+	case fulock_ctl_init:
+		fulock->flags &= ~(FULOCK_FL_DEAD | FULOCK_FL_NR);
+		__fulock_unlock (fulock, (size_t) ~0, -ENOENT);
+		result = fulock_st_init;
+		break;
+		
+		/* Mark it healthy */
+	case fulock_ctl_heal:
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
+	case fulock_ctl_nr:
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
+		/* Set the prio ceiling */
+	case fulock_ctl_setprioceil:
+#warning FIXME: this is most probably WRONG
+#warning FIXME: Finish me, set prio ceil
+#if 0
+		result = -EINVAL;
+		if (!(fulock->flags & FULOCK_FL_PP))
+			break;
+		result = -EPERM;
+		if (fulock->owner != current)	/* Who are you? */
+			break;
+		_raw_spin_lock (&owner->fulock_olist_lock);
+		prio = fulock->flags & FULOCK_FL_PP_MK;
+		prio_changed = olist_chprio (&current->fulock_olist,
+					     &fulock->olist_node, prio);
+		_raw_spin_unlock (&owner->fulock_olist_lock);
+		if (prio_changed)
+			__prio_boost (owner, prio);
+#endif
+		result = 0;
+		break;	
+		
+	default:
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
+ * @returns: NULL (if there is no need to propagate), task where
+ * propagation would need to continue.  
+ *
+ * This does not set the prio of the process itself!
+ * 
+ * WARNING: Needs to be called with IRQs and preemtion disabled.
+ */
+struct task_struct * __fulock_op_waiter_chprio (
+	struct task_struct *task, struct fuqueue *fuqueue,
+	struct fuqueue_waiter *w)
+{
+	struct fuqueue_ops *ops;
+	struct fulock *fulock;
+	int prio_changed;
+	
+	ftrace ("(%p [%d], %p, %p)\n", task, task->pid, fuqueue, w);
+	
+	/* Verify this is really a fulock */
+	ops = fuqueue->ops;
+	BUG_ON (ops != &fulock_ops.fuqueue && ops != &ufulock_ops.fuqueue);
+	fulock = container_of (fuqueue, struct fulock, fuqueue);
+	/* Update the waiter's position in the fulock's wlist */
+	prio_changed = wlist_chprio (&fuqueue->wlist, &w->wlist_node,
+				     task->prio);
+	/* The prio change of the waiter caused the wlist prio to
+	 * change; if we are PI, we change the prio of the fulock AND
+	 * if that changed the prio of the owner, return it. */
+	if (prio_changed
+	    && fulock->flags & FULOCK_FL_PI
+	    && __fulock_prio_update (fulock))
+		return fulock->owner;
+	return NULL;
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
+void __fulock_op_exit (struct fulock *fulock)
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
+unsigned __fulock_op_waiter_cancel (struct fuqueue *fuqueue,
+				    struct fuqueue_waiter *w)
+{
+	unsigned prio_changed;
+	struct fulock *fulock =
+		container_of (fuqueue, struct fulock, fuqueue);
+	
+	ftrace ("(%p, %p [%d], %p)\n",
+		fuqueue, w, w->task->pid, w);
+
+	prio_changed = __fuqueue_op_waiter_cancel (fuqueue, w);
+	ldebug (2, "prio_change is %u\n", prio_changed);
+	if (prio_changed
+	    && fulock->flags & FULOCK_FL_PI
+	    && __fulock_prio_update (fulock))
+		__fuqueue_waiter_chprio (fulock->owner);
+	return prio_changed;
+}
+
+
+/** Fulock operations */
+struct fulock_ops fulock_ops = {
+	.fuqueue = {
+		.get = NULL,
+		.put = NULL,
+		.waiter_cancel = __fulock_op_waiter_cancel,
+		.waiter_chprio = __fulock_op_waiter_chprio
+	},
+	.owner_set = __fulock_op_owner_set,
+	.owner_reset = __fulock_op_owner_reset,
+	.exit = __fulock_op_exit
+};
+
