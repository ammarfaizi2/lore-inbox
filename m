Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267832AbUGWQHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267832AbUGWQHg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 12:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267826AbUGWQG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 12:06:56 -0400
Received: from fmr06.intel.com ([134.134.136.7]:49029 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S267469AbUGWPpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 11:45:47 -0400
Date: Fri, 23 Jul 2004 08:49:04 -0700
From: inaky.perez-gonzalez@intel.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com, robustmutexes@lists.osdl.org
Subject: [RFC/PATCH] FUSYN 4/11: kernel fulocks
Message-ID: <0407230849.Ycdbec6bWb9dtb.bHbUaebDcmdEcSdtb17066@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0407230848.ZdKcBcybgaBd6ddd6cVdacuaIaRd6dha17066@intel.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are the "mutexes" for using within kernel space. As
with fuqueues, they also include the stuff to build on top of
them (esentially to perform user space support).

Included is also the addition of to new E* error codes for
denoting a mutex whose owner has died (EOWNERDEAD) or a mutex
that is not recoverable from that situation
(ENOTRECOVERABLE).


 include/asm-alpha/errno.h   |    3 
 include/asm-generic/errno.h |    3 
 include/asm-mips/errno.h    |    3 
 include/asm-parisc/errno.h  |    2 
 include/asm-sparc/errno.h   |    3 
 include/asm-sparc64/errno.h |    3 
 include/linux/fulock.h      |  455 ++++++++++++++++++++++++++
 kernel/fulock.c             |  743 ++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 1215 insertions(+)

--- include/asm-generic/errno.h:1.1.1.1 Thu Jul 10 12:27:27 2003
+++ include/asm-generic/errno.h Thu May 27 00:34:06 2004
@@ -97,4 +97,7 @@
 #define	ENOMEDIUM	123	/* No medium found */
 #define	EMEDIUMTYPE	124	/* Wrong medium type */
 
+#define EOWNERDEAD	125	/* Mutex owner died */
+#define ENOTRECOVERABLE 126	/* Mutex state is not recoverable */
+
 #endif
--- include/asm-mips/errno.h:1.1.1.1 Thu Jul 10 12:27:27 2003
+++ include/asm-mips/errno.h Thu May 27 00:34:06 2004
@@ -111,6 +111,9 @@
 #define ENOMEDIUM	159	/* No medium found */
 #define EMEDIUMTYPE	160	/* Wrong medium type */
 
+#define EOWNERDEAD      161	/* Mutex owner died */
+#define ENOTRECOVERABLE 162	/* Mutex state is not recoverable */
+
 #define EDQUOT		1133	/* Quota exceeded */
 
 #ifdef __KERNEL__
--- include/asm-parisc/errno.h:1.1.1.1 Thu Jul 10 12:27:28 2003
+++ include/asm-parisc/errno.h Thu May 27 00:34:07 2004
@@ -67,6 +67,8 @@
 #define	EREMOTEIO	181	/* Remote I/O error */
 #define	ENOMEDIUM	182	/* No medium found */
 #define	EMEDIUMTYPE	183	/* Wrong medium type */
+#define EOWNERDEAD	184	/* Mutex owner died */
+#define ENOTRECOVERABLE 185	/* Mutex state is not recoverable */
 
 /* We now return you to your regularly scheduled HPUX. */
 
--- include/asm-sparc/errno.h:1.1.1.1 Thu Jul 10 12:27:32 2003
+++ include/asm-sparc/errno.h Thu May 27 00:34:07 2004
@@ -102,4 +102,7 @@
 #define	ENOMEDIUM	125	/* No medium found */
 #define	EMEDIUMTYPE	126	/* Wrong medium type */
 
+#define EOWNERDEAD	127	/* Mutex owner died */
+#define ENOTRECOVERABLE 128	/* Mutex state is not recoverable */
+
 #endif
--- include/asm-sparc64/errno.h:1.1.1.1 Thu Jul 10 12:27:32 2003
+++ include/asm-sparc64/errno.h Thu May 27 00:34:07 2004
@@ -102,4 +102,7 @@
 #define ENOMEDIUM       125     /* No medium found */
 #define EMEDIUMTYPE     126     /* Wrong medium type */
 
+#define EOWNERDEAD	127	/* Mutex owner died */
+#define ENOTRECOVERABLE 128	/* Mutex state is not recoverable */
+
 #endif /* !(_SPARC64_ERRNO_H) */
--- /dev/null	Thu Jul 22 14:30:56 2004
+++ include/linux/fulock.h Tue Jul 20 02:39:07 2004
@@ -0,0 +1,455 @@
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
+ * Quickie guide:
+ *
+ * struct fulock = fulock_INIT (&fulock);
+ *
+ * fulock_init (&fulock);
+ * fulock_release (&fulock);
+ * fulock_lock (&fulock, TIMEOUT);
+ * fulock_unlock (&fulock, UNLOCK_TYPE);
+ * fulock_ctl (&fulock, COMMAND)
+ */
+
+#ifndef __linux_fulock_h__
+#define __linux_fulock_h__
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
+	__FULOCK_FL_KCO =	FULOCK_FL_KCO | FULOCK_FL_PP,
+	FULOCK_FL_ERROR_CHK =	0x04000000, /* Perform POSIX error checks */
+/* Priority ceiling masks */
+	FULOCK_FL_PP_PLC_MK =	0x00f00000, /* Policy */
+	FULOCK_FL_PP_PRIO_MK =	0x000ff000  /* Priority */
+};
+
+/** Ways to unlock a fulock */
+enum fulock_unlock_type {
+	FULOCK_UNLOCK_SERIAL = 0, /* Transfer ownership to 1st waiter, wake up */
+	FULOCK_UNLOCK_PARALLEL,   /* Unlock fulock, wakeup 1st waiter */
+	FULOCK_UNLOCK_AUTO        /* SERIAL if 1st waiter's prio is RT */
+};
+
+/** Fulock health state */
+enum fulock_st {
+	FULOCK_ST_HEALTHY,   /* Normal, healthy */
+	FULOCK_ST_DEAD,	     /* Some previous owner died */
+	FULOCK_ST_NR	     /* idem, plus cannot be recovered */
+};
+
+
+/** Fulock control actions */
+enum fulock_ctl {
+	FULOCK_CTL_NOP = 0,   /* No-op, just return actual health state */
+	FULOCK_CTL_HEAL,      /* Move from dead to healthy */
+	FULOCK_CTL_NR,	      /* Move from dead to not-recoverable */
+	FULOCK_CTL_RELEASE,   /* Destroy the fulock/ufulock it */
+	FULOCK_CTL_INIT = FULOCK_CTL_RELEASE,
+	FULOCK_CTL_WAITERS,   /* Do we have waiters? */
+	FULOCK_CTL_LOCKED,    /* Is it locked? */
+	FULOCK_CTL_SETPRIOCEIL	/* Set the priority ceiling */
+};
+
+
+/**
+ * vfulock: fulock value in the user space word. Denotes the lock
+ * state and health state of the lock. If it is not this, is the PID
+ * (or cookie) of the owner who fast locked.
+ */
+enum vfulock {
+	VFULOCK_UNLOCKED  = 0x00000000,	/* Unlocked */
+	VFULOCK_HEALTHY	  = VFULOCK_UNLOCKED, /* KCO mode: the lock is healthy */
+	VFULOCK_WP	  = 0xfffffffd,	/* Waiters blocked in the kernel */
+	VFULOCK_DEAD	  = 0xfffffffe,	/* dead, kernel controls ownership */
+	VFULOCK_NR	  = 0xffffffff	/* fulock is not-recoverable */
+};
+
+#ifdef __KERNEL__
+
+#include <linux/config.h>
+#include <linux/fusyn-debug.h>
+
+#ifndef CONFIG_FULOCK
+struct task_struct;
+static inline
+void exit_fulocks(struct task_struct *dummy) {}
+static inline
+void init_fulocks(struct task_struct *dummy) {}
+
+#else /* #ifndef CONFIG_FULOCK */
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
+	enum fulock_unlock_type (* unlock_type) (int *, struct fulock *,
+						 struct fuqueue_waiter *,
+						 enum fulock_unlock_type,
+						 void *) ;
+	void (* unqueue) (struct fulock *, struct fuqueue_waiter *,
+			  enum fulock_unlock_type, void *);
+	void (* exit) (struct fulock *); /* called from do_exit() context */
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
+	struct plist olist_node;
+};
+
+
+/** Initialize a @fulock with given ops */
+static inline
+void __fulock_init (struct fulock *fulock, struct fulock_ops *ops)
+{
+	__fuqueue_init (&fulock->fuqueue, &ops->fuqueue);
+	fulock->owner = NULL;
+	fulock->flags = 0;
+	plist_init (&fulock->olist_node, BOTTOM_PRIO);
+}
+
+/** Statically initialize a @fulock with given ops */
+#define __fulock_INIT(fulock, fulock_ops) {				\
+	.fuqueue = __fuqueue_INIT (&(fulock)->fuqueue,			\
+				   &(fulock_ops)->fuqueue),		\
+	.owner = NULL,							\
+	.flags = 0,							\
+	.olist_node = plist_INIT (&(fulock)->olist_node, BOTTOM_PRIO)	\
+}
+
+/** Initialize a @fulock for usage within the kernel */
+static inline
+void fulock_init (struct fulock *fulock, int flags)
+{
+	__fulock_init (fulock, &fulock_ops);
+	BUG_ON (flags & FULOCK_FL_PP && flags & FULOCK_FL_PI);
+	fulock->flags = flags;
+}
+
+/** Statically initialize a @fulock for usage within the kernel */
+#define fulock_INIT(fulock) __fulock_INIT (fulock, &fulock_ops)
+
+
+/* Primitives for locking/unlocking/waiting/signalling */
+extern int __fulock_lock (struct fulock *,  struct fuqueue_waiter *,
+			  const struct timeout *);
+extern void __fulock_unlock (struct fulock *fulock,
+			     enum fulock_unlock_type unlock_type, void *);
+extern void __fulock_unlock_unqueue (struct fulock *, struct fuqueue_waiter *,
+				     enum fulock_unlock_type);
+extern int __fulock_ctl (struct fulock *fulock, enum fulock_ctl ctl, void *);
+extern void __fulock_requeue (struct fuqueue *fuqueue,
+			      struct fulock *fulock, void *);
+extern void __fulock_kill_message (struct fulock *);
+extern void exit_fulocks (struct task_struct *task);
+
+/** More internal stuff for building on top of fulock */
+extern void init_fulocks (struct task_struct *);
+extern unsigned __fulock_op_waiter_cancel (struct fuqueue *,
+					   struct fuqueue_waiter *);
+extern struct task_struct * __fulock_op_waiter_chprio (
+	struct task_struct *, struct fuqueue *, struct fuqueue_waiter *);
+extern void fulock_op_unqueue (struct fulock *fulock,
+			       struct fuqueue_waiter *w,
+			       enum fulock_unlock_type unlock_type,
+			       void *priv);
+
+/** Release a fulock -- now it is unusable [use fulock_init()] */
+static inline
+void fulock_release (struct fulock *fulock)
+{
+	__fulock_ctl (fulock, FULOCK_CTL_RELEASE, NULL);
+}
+
+
+/**
+ * Lock a fulock, maybe wait for it to be available.
+ * 
+ * See __fulock_lock() for complete docs.
+ */
+static inline
+int fulock_lock (struct fulock *fulock, const struct timeout *timeout) 
+{
+	struct fuqueue_waiter w = fuqueue_waiter_INIT (current);
+	int result;
+	do {
+		spin_lock_irq (&fulock->fuqueue.lock);
+		result = __fulock_lock (fulock, &w, timeout);
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
+static inline
+void fulock_unlock (struct fulock *fulock,
+		    enum fulock_unlock_type unlock_type)
+{
+	unsigned long flags;
+	
+	ftrace ("(%p, %d)\n", fulock, unlock_type);
+	
+	spin_lock_irqsave (&fulock->fuqueue.lock, flags);
+	__fulock_unlock (fulock, unlock_type, NULL);
+	spin_unlock_irqrestore (&fulock->fuqueue.lock, flags);
+}
+
+
+/**
+ * Requeue a fuqueue to a fulock, maybe make the first one owner.
+ *
+ * Can be called from any context [I hope].
+ */
+static inline
+void fulock_requeue (struct fuqueue *fuqueue, struct fulock *fulock)
+{
+	unsigned long flags;
+	
+	ftrace ("(%p, %p)\n", fuqueue, fulock);
+	
+	spin_lock_irqsave (&fulock->fuqueue.lock, flags);
+	_raw_spin_lock (&fuqueue->lock);
+	if (!__fuqueue_empty (fuqueue))
+		__fulock_requeue (fuqueue, fulock, NULL);
+	_raw_spin_unlock (&fuqueue->lock);
+	spin_unlock_irqrestore (&fulock->fuqueue.lock, flags);
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
+static inline
+int fulock_ctl (struct fulock *fulock, enum fulock_ctl ctl)
+{
+	int result;
+	unsigned long flags;
+	ftrace ("(%p, %d)\n", fulock, ctl);
+	
+	spin_lock_irqsave (&fulock->fuqueue.lock, flags);
+	result = __fulock_ctl (fulock, ctl, NULL);
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
+static inline
+unsigned __fulock_empty (const struct fulock *f)
+{
+	return __fuqueue_empty (&f->fuqueue);
+}
+
+
+/** [Internal] Make task @task the owner of fulock @f. */
+static inline
+unsigned __fulock_op_owner_set (struct fulock *fulock,
+				struct task_struct *task)
+{
+	unsigned prio_changed;
+	
+	ftrace ("(%p, %p [%d])\n", fulock, task, task->pid);
+	
+	fulock->owner = task;
+	prio_changed = plist_add (&task->fulock_olist, &fulock->olist_node);
+	return prio_changed;
+}
+
+
+/** [Internal] Reset ownership of fulock @f. */
+static inline
+unsigned __fulock_op_owner_reset (struct fulock *fulock)
+{
+	unsigned prio_changed;
+	struct task_struct *owner = fulock->owner;
+	
+	ftrace ("(%p)\n", fulock);
+  
+	prio_changed = plist_del (&owner->fulock_olist, &fulock->olist_node);
+	fulock->owner = NULL;
+	return prio_changed;
+}
+
+
+/**
+ * Determine the appropiate way to unlock a fulock.
+ *
+ * @pcode: where to store the wake up code for the waiter
+ * @fulock: fulock being unlocked
+ * @w: waiter that is going to be unblocked to obtain the fulock.
+ * @unlock_type: tentative unlock method selected by the user.
+ * @priv: private pointer for use in an specific way.
+ *
+ * If the waiters comes from a requeue, it will become a serial
+ * unlock, no matter what. If auto, it will depend on if the task to
+ * be given ownership is RT or not (serial for FIFO/RR, normal for
+ * timesharing). 
+ * 
+ * Needs to be inline for ufulock_op_unlock_type() to pick up.
+ */
+static inline
+enum fulock_unlock_type
+fulock_op_unlock_type (int *pcode, struct fulock *fulock,
+		       struct fuqueue_waiter *w,
+		       enum fulock_unlock_type unlock_type, void *priv) 
+{
+	int code;
+	
+	if (w->flags & FUQUEUE_WT_FL_QUEUE) {
+		unlock_type = FULOCK_UNLOCK_SERIAL;
+		code = fulock->flags & FULOCK_FL_DEAD?
+			-EOWNERDEAD : FUQUEUE_WAITER_GOT_LOCK;
+	}
+	else {
+		if (unlock_type == FULOCK_UNLOCK_AUTO)
+			unlock_type = rt_task (w->task)?
+				FULOCK_UNLOCK_SERIAL : FULOCK_UNLOCK_PARALLEL;
+		if (unlock_type == FULOCK_UNLOCK_SERIAL)
+			code = fulock->flags & FULOCK_FL_DEAD? -EOWNERDEAD : 0;
+		else
+			code = -EAGAIN;
+	}
+	*pcode = code;
+	return unlock_type;
+}
+
+
+/** Do we have fast-path support in the arch? */
+enum {
+#ifdef __HAVE_ARCH_CMPXCHG
+	VFULOCK_FAST = 1
+#else
+	VFULOCK_FAST = 0
+#endif
+};
+
+
+/**
+ * Atomic compare and swap with a twist.
+ *
+ * @value     Pointer to the value to compare and swap.
+ * @old_value Value that *value has to have for the swap to occur.
+ * @new_value New value to set it *value == old_value.
+ * @return    !0 if the swap succeeded. 0 if failed.
+ *
+ * Used for locking a vfulock. It exists to wrap arch-specific cache
+ * idiosyncrasies.
+ *
+ * WARNING FIXME: we need a way to handle the idiosyncrasies. Some
+ *                arches have weird cache management schemes that show
+ *                when we modify a kmapped area and user space doesn't
+ *                see the change. This should be hook in here or
+ *                something.
+ */
+static inline
+unsigned vfulock_acas (volatile unsigned *value,
+		       unsigned old_value, unsigned new_value)
+{
+#ifdef __HAVE_ARCH_CMPXCHG
+	unsigned result = cmpxchg (value, old_value, new_value);
+	return result == old_value;
+#else
+	return 0;
+#endif
+}
+
+
+/**
+ * Set an ufulock's associated value.
+ *
+ * @vfulock: Pointer to the address of the ufulock to contain for.
+ * @value:    New value to assign.
+ *
+ * This exists to wrap arch-specific cache idiosyncrasies.
+ *
+ * WARNING FIXME: we need a way to handle the idiosyncrasies. Some
+ *                arches have weird cache management schemes that show
+ *                when we modify a kmapped area and user space doesn't
+ *                see the change. This should be hook in here or
+ *                something.
+ */
+static inline
+void vfulock_set (volatile unsigned *vfulock, unsigned value)
+{
+	*vfulock = value;
+}
+
+#endif /* #ifndef CONFIG_FULOCK */
+#endif /* #ifdef __KERNEL__ */
+#endif /* #ifndef __linux_fulock_h__ */
--- /dev/null	Thu Jul 22 14:30:56 2004
+++ kernel/fulock.c Tue Jul 20 02:40:17 2004
@@ -0,0 +1,743 @@
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
+#include <linux/sched.h>
+#include <linux/errno.h>
+
+/* FIXME: TODO: FIFO mode for the waiters list: simply make
+ *              wlist_nodes INT_MAX. */ 
+
+/**
+ * @returns !0 if the ops are those of a fulock or ufulock.
+ *
+ * The compiler will optimize it pretty good.
+ */
+static inline
+unsigned fulock_test_ops (struct fuqueue_ops *ops)
+{
+	if (ops == &fulock_ops.fuqueue)
+		return !0;
+#ifdef CONFIG_UFULOCK
+	if (ops == &ufulock_ops.fuqueue)
+		return !0;
+#endif
+	return 0;
+}
+
+/**
+ * A waiter on this fulock was added, removed or reprioritized and
+ * that caused the wlist priority to change, so we must update the
+ * fulock priority in the owner's ownership list.
+ *
+ * @fulock: The defendant [nossir, I haven't been groklawing]. 
+ * @returns: !0 if the boost priority for the owner was changed.
+ *
+ * It is possible that the lock is not owned if we did a parallel
+ * unlock, so we have to check for that case.
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
+	prio = plist_prio (&fulock->fuqueue.wlist);
+	if (owner == NULL) {
+		prio_changed = plist_prio (&fulock->olist_node) != prio;
+		__plist_chprio (&fulock->olist_node, prio);
+		goto out;
+	}
+	/* reposition this fulock on it's owner's ownership list */
+	_raw_spin_lock (&owner->fulock_olist_lock);
+	prio_changed = plist_chprio (&owner->fulock_olist,
+				     &fulock->olist_node, prio);
+	_raw_spin_unlock (&owner->fulock_olist_lock);
+	/* there is a new maximum on the list? maybe chprio the owner */
+	if (prio_changed)
+		result = __prio_boost (owner, prio);
+out:
+	return prio_changed;
+}
+
+
+
+
+/**
+ * Test if 'current' would deadlock if it waits for a fulock.
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
+ * @fulock: the fulock to check
+ * @returns: 0 if ok, < 0 errno on error.
+ *
+ * This *should* be safe being lock-less [famous last words].
+ *
+ * WARNING: Needs to be called with IRQs and preemtion disabled.
+ */
+int __fulock_check_deadlock (struct fulock *fulock)
+{
+	int result = 0;
+	struct fuqueue_ops *ops;
+	struct task_struct *owner;
+	struct task_struct *task = current;
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
+	if (!_raw_spin_trylock (&fuqueue->lock)) {	/* Spin dance... */
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
+	if (!fulock_test_ops (ops))
+		goto out_fuqueue_unlock;
+	fulock = container_of (fuqueue, struct fulock, fuqueue);
+	owner = fulock->owner;		      /* Who's the fulock's owner? */
+	if (unlikely (owner == NULL))	      /* Released before we locked it? */
+		goto out_fuqueue_unlock;	
+	result = -EDEADLK;		      /* It is us? ooops */
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
+	return -ENOSYS;
+}
+
+
+/**
+ * [Try]lock a fulock
+ *
+ * @fulock: Fulock to lock.
+ * 
+ * @timeout: Pointer on struct describing how long to wait for the
+ *           timeout. If NULL, just trylock (don't block), if ~0, wait
+ *           for ever, otherwise, wait as specified by the pointed to
+ *           struct. 
+ *
+ * @returns: 0	     Acquired the fulock
+ *	     -EOWNERDEAD  Acquired the fulock, some previous owner died.
+ *	     -ENOTRECOVERABLE  Not acquired, fulock is not recoverable
+ *	     -EBUSY  Not acquired, it is locked [and trylock was
+ *		     requested].
+ *	     -EAGAIN Not acquired, try again [FIXME: change this,
+ *		     POSIX uses it for mutexes].
+ *	     *	     Not acquired, error.
+ *
+ * Can ONLY be called from process context. Note unlocks the fulock's
+ * spinlock on return and re-enables IRQs and preemption.
+ *
+ * WARNING: Needs to be called with IRQs and preemtion disabled [the
+ * fuqueue lock acquired with spin_lock_irq()].
+ *
+ * Note that some operations involving flag reading don't need locking
+ * because for changing those values, we calling task needs to be the
+ * owner of the fulock, and once we come out of wait without errors,
+ * we are the owners.
+ */
+int __fulock_lock (struct fulock *fulock,
+		   struct fuqueue_waiter *w,
+		   const struct timeout *timeout)
+{
+	unsigned prio_changed;
+	int result = 0;
+	int prio = BOTTOM_PRIO;
+	struct fulock_ops *ops =
+		container_of (fulock->fuqueue.ops, struct fulock_ops, fuqueue);
+	
+	ftrace ("(%p [flags 0x%x], %p)\n", fulock, fulock->flags, timeout);
+	
+	/* Verify if we can lock */
+	result = -ENOTRECOVERABLE;
+	if (fulock->flags & FULOCK_FL_NR)
+		goto out_unlock;
+	if (fulock->flags & FULOCK_FL_PP
+	    && (result = __fulock_pp_allowed (fulock)))
+		goto out_unlock;
+	if (fulock->owner == NULL)
+		goto its_unlocked;
+	/* Nchts, we have to wait. */
+	result = -EBUSY;
+	if (!timeout)
+		goto out_unlock;
+	if (fulock->flags & (FULOCK_FL_ERROR_CHK | FULOCK_FL_PI)
+	    && (result = __fulock_check_deadlock (fulock)))
+		goto out_unlock;
+	prio_changed = __fuqueue_waiter_queue (&fulock->fuqueue, w);
+	if (prio_changed
+	    && fulock->flags & FULOCK_FL_PI
+	    && __fulock_prio_update (fulock))
+		__fuqueue_waiter_chprio (fulock->owner);
+	return __fuqueue_waiter_block (&fulock->fuqueue, w, timeout);
+
+its_unlocked:		/* whoa! take it, it's free */
+	result = fulock->flags & FULOCK_FL_DEAD? -EOWNERDEAD : 0;
+	_raw_spin_lock (&current->fulock_olist_lock);
+	prio_changed = ops->owner_set (fulock, w->task);
+	if (prio_changed) {
+		/* The ownership list's prio changed, update boost */
+		prio = plist_prio (&fulock->olist_node);
+		__prio_boost (current, prio);
+	}
+	_raw_spin_unlock (&current->fulock_olist_lock);
+out_unlock:
+	_raw_spin_unlock (&fulock->fuqueue.lock);
+	local_irq_enable();
+	preempt_enable();
+	return result;
+}
+
+
+/**
+ * Grunt for the unlock work: take care of the waking up part.
+ *
+ * Unqueue the first waiter and either transfer ownership to it
+ * (serial wake up) or not (parallel). If transferring and the fulock
+ * is PI, propagate the fulock's fuqueue priority to the fulock (to
+ * it's ownership list). Then register the fulock in the new owner's
+ * ownership list and maybe boost him. We always do the boost (not
+ * caring if PI or PP) because if it is neither, the new_oprio would
+ * be INT_MAX, and that will never cause a boost.
+ *
+ * Note we don't need to do a boost propagation; if somebody happens
+ * to wake up the guy before we do, he will see its w->result still
+ * unmodified from INT_MAX and will have to take this fulock's
+ * spinlock to cancel its wait [see __fuqueue_waiter_block()]--he will
+ * have to wait until WE release the spinlock, so he is not able to do
+ * anything that would require a prio boost propagation.
+ *
+ * @unlock_type:
+ *           How to unlock, serialized or parallel.
+ *
+ * NOTE: Assumes the fulock is NOT EMPTY.
+ *       Does not unboost the old owner
+ */
+void __fulock_unlock_unqueue (struct fulock *fulock, struct fuqueue_waiter *w,
+			      enum fulock_unlock_type unlock_type)
+{
+	unsigned wprio_changed, oprio_changed;
+	int new_wprio, new_oprio;
+	struct fulock_ops *ops =
+		container_of (fulock->fuqueue.ops, struct fulock_ops, fuqueue);
+	struct task_struct *new_owner = w->task;
+	
+        wprio_changed = fuqueue_waiter_unqueue (&fulock->fuqueue, w);
+        if (unlock_type == FULOCK_UNLOCK_SERIAL) {
+		if (wprio_changed && fulock->flags & FULOCK_FL_PI) {
+			new_wprio = plist_prio (&fulock->fuqueue.wlist);
+			__plist_chprio (&fulock->olist_node, new_wprio);
+		}
+		_raw_spin_lock (&new_owner->fulock_olist_lock);
+		oprio_changed = ops->owner_set (fulock, new_owner);
+		if (oprio_changed) {			
+			new_oprio = plist_prio (&new_owner->fulock_olist);
+			__prio_boost (new_owner, new_oprio);
+		}
+		_raw_spin_unlock (&new_owner->fulock_olist_lock);
+        }
+}
+
+
+/**
+ * Unlock a fulock, wake up waiter(s) [internal version]
+ *
+ * @fulock: Address for the fulock (kernel space).
+ * @unlock_type: How to unlock, serialized, parallel or auto (serial
+ *               if first waiter is real-time).
+ * @priv: private pointer to pass to different fulock-type specific
+ *        ops.
+ */
+void __fulock_unlock (struct fulock *fulock,
+		      enum fulock_unlock_type unlock_type,
+		      void *priv)
+{
+	int new_oprio, code;
+	struct fulock_ops *ops =
+		container_of (fulock->fuqueue.ops, struct fulock_ops, fuqueue);
+	struct task_struct *old_owner;
+	struct fuqueue_waiter *w;
+        
+	ftrace ("(%p, %d, %p)\n", fulock, unlock_type, priv);
+
+	/* Unlock the fulock */
+	old_owner = fulock->owner;
+	if (old_owner == NULL)		/* Unlocked? */
+		goto out;
+	_raw_spin_lock (&old_owner->fulock_olist_lock);
+	ops->owner_reset (fulock);
+	if (__fulock_empty (fulock))    /* nobody to wake */
+		goto out_unboost;
+	_raw_spin_unlock (&old_owner->fulock_olist_lock);
+
+	/* Get the guy we have to wake up, decide how */
+	w = __fuqueue_first (&fulock->fuqueue);
+	unlock_type = ops->unlock_type (&code, fulock, w, unlock_type, priv);
+	
+	/* (Maybe) transfer ownership, unqueue */
+	ops->unqueue (fulock, w, unlock_type, priv);
+	w->result = code;
+	wmb();
+	wake_up_process (w->task);
+	/* Now we can unboost (if we have to). prio_changed can be
+	 * true only if PI or PP (and the prio actually changed) */
+	_raw_spin_lock (&old_owner->fulock_olist_lock);
+out_unboost:
+	new_oprio = plist_prio (&old_owner->fulock_olist);
+	if (new_oprio != old_owner->prio
+	    && __prio_boost (old_owner, new_oprio))
+		__fuqueue_waiter_chprio (old_owner);
+	_raw_spin_unlock (&old_owner->fulock_olist_lock);
+out:
+	return;
+}
+
+
+/**
+ * Requeue all waiters from a fuqueue to a fulock.
+ *
+ * @fuqueue:      Pointer to the fuqueue.
+ * @fulock:	  Pointer to the fulock.
+ * @fulock_flags: Flags for the fulock.
+ * @returns: 0 if ok, < 0 errno code on error.
+ *
+ * We place all the waiters on the fuqueue in the ufulock's
+ * fuqueue--in such a way that unlock recognizes it is not a fulock
+ * waiter per se.
+ *
+ * We might catch the ufulock is unlocked, this may only happen if we
+ * got the spinlock to the fulock in the middle of a parallel wake up
+ * sequence.
+ * 
+ * USER CONTEXT ONLY
+ *
+ * Expects the fulock spinlocked, IRQs and preemption disabled. The
+ * fuqueue should not be locked.
+ */
+void __fulock_requeue (struct fuqueue *fuqueue,
+		       struct fulock *fulock, void *priv)
+{
+	int code;
+	enum fulock_unlock_type unlock_type = FULOCK_UNLOCK_SERIAL;
+	unsigned prio_changed;
+	struct fulock_ops *ops =
+		container_of (fulock->fuqueue.ops, struct fulock_ops, fuqueue);
+	struct fuqueue_waiter *w;
+	
+	ftrace ("(%p, %p, %p)\n", fuqueue, fulock, priv);
+	
+	/* Move everybody, hop, hop! */
+	prio_changed = plist_splice_init (&fulock->fuqueue.wlist,
+					  &fuqueue->wlist);
+	if (fulock->owner == NULL) {
+		/* Unlocked? Wake up the first guy */
+		w = __fuqueue_first (&fulock->fuqueue);
+		unlock_type = ops->unlock_type (&code, fulock, w,
+						unlock_type, priv);
+		/* Assign/transfer ownership, unqueue */
+		ops->unqueue (fulock, w, unlock_type, priv);
+		w->result = code;
+		wmb();
+		wake_up_process (w->task);
+	}
+	else if (prio_changed
+		 && fulock->flags & FULOCK_FL_PI
+		 && __fulock_prio_update (fulock))
+		__fuqueue_waiter_chprio (fulock->owner);
+	return;
+}
+
+
+/**
+ * Modify/query the internal state of a fulock.
+ *
+ * @fulock: fulock to modify. 
+ * @ctl: control command to issue.
+ * @returns: depending; < 0 errno code on error, 0 if ok, except
+ * health state for CTL_NOP
+ */
+int __fulock_ctl (struct fulock *fulock, enum fulock_ctl ctl, void *priv)
+{
+	int result = 0;
+
+	ftrace ("(%p, %d)\n", fulock, ctl);
+	
+	/* Gather actual state */
+	
+	/* Now, what to do? */
+	switch (ctl) {
+		/* Nothing, so just say how are we standing */
+	case FULOCK_CTL_NOP:
+		if (fulock->flags & FULOCK_FL_NR)
+			result = FULOCK_ST_NR;
+		else if (fulock->flags & FULOCK_FL_DEAD)
+			result = FULOCK_ST_DEAD;
+		else
+			result = FULOCK_ST_HEALTHY;
+		break;
+
+		/* Destroy the fulock--use fulock_init() to re-use */
+	case FULOCK_CTL_RELEASE:
+		__fuqueue_wake (&fulock->fuqueue, (size_t) ~0, -ENOENT);
+		__fulock_unlock (fulock, FULOCK_UNLOCK_SERIAL, priv);
+		fulock->flags |= FULOCK_FL_NR;
+		break;
+		
+		/* Mark it healthy */
+	case FULOCK_CTL_HEAL:
+		result = -EINVAL;
+		if (!(fulock->flags & FULOCK_FL_DEAD))
+			break;
+		result = -EPERM;
+		if (fulock->owner != current)	/* Who are you? */
+			break;
+		fulock->flags &= ~FULOCK_FL_DEAD;
+		result = 0;
+		break;
+		
+	    /* Make it not recoverable; wake up every waiter with error;
+	     * unlock. */ 
+	case FULOCK_CTL_NR:
+		result = -EINVAL;
+		if (!(fulock->flags & FULOCK_FL_DEAD))
+			break;
+		result = -EPERM;
+		if (fulock->owner != current)	/* Who are you? */
+			break;
+		__fuqueue_wake (&fulock->fuqueue, (size_t) ~0, -ENOTRECOVERABLE);
+		__fulock_unlock (fulock, FULOCK_UNLOCK_SERIAL, priv);
+		fulock->flags &= ~FULOCK_FL_DEAD;
+		fulock->flags |= FULOCK_FL_NR;
+		result = 0;
+		break;
+
+		/* Set the prio ceiling */
+	case FULOCK_CTL_SETPRIOCEIL:
+#if 0
+#warning FIXME: this is most probably WRONG
+#warning FIXME: Finish me, set prio ceil
+		result = -EINVAL;
+		if (!(fulock->flags & FULOCK_FL_PP))
+			break;
+		result = -EPERM;
+		if (fulock->owner != current)	/* Who are you? */
+			break;
+		_raw_spin_lock (&owner->fulock_olist_lock);
+		prio = fulock->flags & FULOCK_FL_PP_MK;
+		prio_changed = plist_chprio (&current->fulock_olist,
+					     &fulock->olist_node, prio);
+		_raw_spin_unlock (&owner->fulock_olist_lock);
+		if (prio_changed)
+			__prio_boost (owner, prio);
+#endif
+		result = -ENOSYS;
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
+	unsigned prio_changed;
+	
+	ftrace ("(%p [%d], %p, %p)\n", task, task->pid, fuqueue, w);
+	
+	/* Verify this is really a fulock */
+	ops = fuqueue->ops;
+	BUG_ON (!fulock_test_ops (ops));
+	fulock = container_of (fuqueue, struct fulock, fuqueue);
+	/* Update the waiter's position in the fulock's wlist */
+	prio_changed = plist_chprio (&fuqueue->wlist, &w->wlist_node,
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
+ * Grunt for the unlock work: unqueue and maybe transfer ownership
+ *
+ * Unqueue the first waiter and either transfer ownership to it
+ * (serial wake up) or not (parallel). If transferring and the fulock
+ * is PI, propagate the fulock's fuqueue priority to the fulock (to
+ * it's ownership list). Then register the fulock in the new owner's
+ * ownership list and maybe boost him. We always do the boost (not
+ * caring if PI or PP) because if it is neither, the new_oprio would
+ * be INT_MAX, and that will never cause a boost.
+ *
+ * Note we don't need to do a boost propagation; if somebody happens
+ * to wake up the guy before we do, he will see its w->result still
+ * unmodified from INT_MAX and will have to take this fulock's
+ * spinlock to cancel its wait [see __fuqueue_waiter_block()]--he will
+ * have to wait until WE release the spinlock, so he is not able to do
+ * anything that would require a prio boost propagation.
+ *
+ * @unlock_type:
+ *           How to unlock, serialized or parallel.
+ *
+ * NOTE: Assumes the fulock is NOT EMPTY.
+ *       Does not unboost the old owner
+ */
+void fulock_op_unqueue (struct fulock *fulock, struct fuqueue_waiter *w,
+			enum fulock_unlock_type unlock_type, void *priv)
+{
+	unsigned wprio_changed, oprio_changed;
+	int new_wprio, new_oprio;
+	struct fulock_ops *ops =
+		container_of (fulock->fuqueue.ops, struct fulock_ops, fuqueue);
+	struct task_struct *new_owner = w->task;
+	
+	ftrace ("(%p, %p, %d, %p)\n", fulock, w, unlock_type, priv);
+	
+        wprio_changed = fuqueue_waiter_unqueue (&fulock->fuqueue, w);
+        if (unlock_type == FULOCK_UNLOCK_SERIAL) {
+		if (wprio_changed && fulock->flags & FULOCK_FL_PI) {
+			new_wprio = plist_prio (&fulock->fuqueue.wlist);
+			__plist_chprio (&fulock->olist_node, new_wprio);
+		}
+		_raw_spin_lock (&new_owner->fulock_olist_lock);
+		oprio_changed = ops->owner_set (fulock, new_owner);
+		if (oprio_changed) {			
+			new_oprio = plist_prio (&new_owner->fulock_olist);
+			__prio_boost (new_owner, new_oprio);
+		}
+		_raw_spin_unlock (&new_owner->fulock_olist_lock);
+        }
+}
+
+
+/**
+ * Initialize fulock specific stuff for a newly cloned task.
+ */
+void init_fulocks (struct task_struct *task)
+{
+	__ftrace (0, "(task %p)\n", task);
+	
+	spin_lock_init (&task->fuqueue_wait_lock);
+	task->fuqueue_wait = NULL;
+	task->fuqueue_waiter = NULL;
+	spin_lock_init (&task->fulock_olist_lock);
+	plist_init (&task->fulock_olist, BOTTOM_PRIO);
+}
+
+
+/**
+ * Mark @fulock as dead and warns if not robust, @returns 0 if it was
+ * dead already, !0 otherwise.
+ */
+void __fulock_kill_message (struct fulock *fulock)
+{
+	if (!(fulock->flags & FULOCK_FL_RM))
+		printk (KERN_WARNING "Task %d [%s] exited holding non-robust "
+			"fulock %p; waiters might block for ever\n",
+			current->pid, current->comm, fulock);	
+}
+
+
+/** Release as dead a @fulock because the owner is exiting. */
+static
+void fulock_op_exit (struct fulock *fulock)
+{
+	ftrace ("(%p)\n", fulock);
+
+	_raw_spin_lock (&fulock->fuqueue.lock);
+	if (fulock->owner == current) {
+		__fulock_kill_message (fulock);
+		__fulock_unlock (fulock, FULOCK_UNLOCK_SERIAL, NULL);
+	}
+	_raw_spin_unlock (&fulock->fuqueue.lock);	  
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
+	struct plist *itr;
+	struct fulock *fulock;
+	struct fulock_ops *ops;
+	unsigned long flags;
+	
+	if (DEBUG > 0 && !plist_empty (&task->fulock_olist))
+		ftrace ("(%p [%d])\n", task, task->pid);
+
+	/* FIXME: there is a better way to do this, but I feel toooo
+	 * thick today -- the problem is fulock->ops->exit() is going
+	 * to take fulock_olist_lock to reset the ownership...so
+	 * whatever it is, we have to call without holding it. */
+	spin_lock_irqsave (&task->fulock_olist_lock, flags);
+	while (!plist_empty (&task->fulock_olist)) {
+		itr = plist_first (&task->fulock_olist);
+		fulock = container_of (itr, struct fulock, olist_node);
+		ops = container_of (fulock->fuqueue.ops,
+				    struct fulock_ops, fuqueue);
+		if (ops->fuqueue.get)
+			ops->fuqueue.get (&fulock->fuqueue);
+		spin_unlock_irqrestore (&task->fulock_olist_lock, flags);
+		
+		ops->exit (fulock);
+		
+		if (ops->fuqueue.put)
+			ops->fuqueue.put (&fulock->fuqueue);
+		spin_lock_irqsave (&task->fulock_olist_lock, flags);
+	}
+	spin_unlock_irqrestore (&task->fulock_olist_lock, flags);
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
+	if (prio_changed && fulock->flags & FULOCK_FL_PI
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
+	.exit = fulock_op_exit
+};
+
--- include/asm-alpha/errno.h:1.1.1.1 Thu Jul 10 12:27:32 2003
+++ include/asm-alpha/errno.h Thu May 27 00:34:06 2004
@@ -111,4 +111,7 @@
 #define ENOMEDIUM	129	/* No medium found */
 #define EMEDIUMTYPE	130	/* Wrong medium type */
 
+#define EOWNERDEAD	131	/* Mutex owner died */
+#define ENOTRECOVERABLE 132	/* Mutex state is not recoverable */
+
 #endif
