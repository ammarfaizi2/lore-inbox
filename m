Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264518AbTLCJDG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 04:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264516AbTLCJCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 04:02:38 -0500
Received: from fmr06.intel.com ([134.134.136.7]:46290 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S264524AbTLCIuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 03:50:12 -0500
Date: Wed, 03 Dec 2003 00:51:59 -0800
From: inaky.perez-gonzalez@intel.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com, robustmutexes@lists.osdl.org
Subject: [RFC/PATCH] FUSYN 10/10: user space fulocks
Message-ID: <0312030051.1c0cVaedNdwaqcydfaSb4adaVboalcvc25502@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0312030051..awdiaSdmbvbObNbZa.b4a2cadobvdta25502@intel.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 ufulock.c |  861 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 861 insertions(+)

--- /dev/null	Tue Dec  2 20:07:55 2003
+++ linux/kernel/ufulock.c	Fri Nov 21 13:26:01 2003
@@ -0,0 +1,861 @@
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
+ *
+ * The ufulocks are fulocks with a vlocator to help pinpoint them from
+ * a user space address.
+ *
+ * The vfulock is the value in an address in user space that is
+ * associated to the ufulock. The trick here is to keep them in sync
+ * [__vfulock_sync()]. I think it is doing the right thing when we
+ * know about a ufulock in the kernel and something wipes it to some
+ * crappy value in user space (wild pointer)--however, it cannot be
+ * perfect.
+ *
+ * Mapping the address in user space to the ufulock is done through a
+ * hash table kept by the vlocator.h code - ufulock_locate() does the
+ * full work; give it an adress, you get a ufulock. No need to worry
+ * about anything else.
+ *
+ * QUICK ROADMAP:
+ *
+ * sys_ufulock_lock(): [try]lock a fulock from user space
+ * sys_ufulock_unlock(): unlock a fulock from user space
+ * sys_ufulock_consistency(): get/set the consistency of a ufulock
+ * __ufulock_exit(): called from fulock.c:exit_fulocks() when a
+ *		     process exits and still holds fulocks.
+ * ufulock_gc(): called from ufu-common.c:ufu_gc() to do garbage
+ *		 collection.
+ *
+ * TODOs:
+ *
+ * - All the #warning FIXME's need to be sorted out
+ *
+ * - There is no need to change the flags of a mutex once it has been
+ *   initialized [POSIX doesn't provide tools for it anyway], except
+ *   for the prioceiling. Still need to provide a way for user space
+ *   to tell kernel space that we are relinquishing a fulock forever
+ *   (for pthread_mutex_destroy()) so we can clean it up and reinit with
+ *   different flags; as well, call in from pthread_mutex_init() so we
+ *   cache the fulock?).
+ */
+
+#warning FIXME: page unpinning still not that done
+/*
+ * The problem is we need to access the page to modify the value on
+ * when a ufulock dies. We could do it on the exit path, but we don't
+ * have a way to locate the page when it is shared on
+ * __ufulock_exit(). We could have the sys_ufulock_lock() return path
+ * do it, but then we don't update the vfulock to VFULOCK_DEAD when
+ * there are no waiters.
+ *
+ * So, until we find a solution for that, pages are still pinned. It
+ * also means we have to pass the page all the way down to
+ * fulock->ops->owner_set(). A solution would get rid of that
+ * too. It's plain ugly and messy.
+ */
+
+#include <linux/sched.h>
+#include <linux/highmem.h>
+#include <linux/plist.h>
+#include <asm/uaccess.h>    /* copy_from_user() */
+#include <linux/init.h>
+
+#include <linux/futex.h>    /* futex keys */
+#include <linux/vlocator.h>
+#include <linux/workqueue.h>
+#include <linux/fulock.h>
+
+
+#if DEBUG > 5
+#define __DEBUG_get_value(result, _vfulock)			\
+do {								\
+ unsigned val = *_vfulock;					\
+ debug ("result %d * _vfulock %u/%x\n", result, val, val);	\
+} while (0)
+#define DEBUG_get_value(result, _vfulock)			\
+do {								\
+  unsigned val;							\
+  get_user (val, _vfulock);					\
+  debug ("result %d * _vfulock %u/%x\n", result, val, val); \
+} while (0)
+#else
+#define __DEBUG_get_value(a,b) do {} while (0)
+#define DEBUG_get_value(a,b) do {} while (0)
+#endif
+
+extern signed long ufu_timespec2jiffies (const struct timespec __user *);
+
+/** Slab for allocation of 'struct ufulock's. */
+static kmem_cache_t *ufulock_slab; 
+
+
+struct fulock_ops ufulock_ops;
+
+
+/** Set an ufulock ownership and increment its use count. */
+static __inline__
+void __ufulock_owner_set (struct fulock *fulock, struct task_struct *task)
+{
+	struct ufulock *ufulock;
+	
+	ftrace ("(%p, %p [%d])\n", fulock, task, task->pid);
+	ufulock = container_of (fulock, struct ufulock, fulock);
+	__fulock_owner_set (fulock, task);
+	vl_get (&ufulock->vlocator);
+}
+
+
+/** Reset an ufulock ownership and drop its use count. */
+static __inline__
+void __ufulock_owner_reset (struct fulock *fulock)
+{
+	struct ufulock *ufulock;
+	
+	ftrace ("(%p)\n", fulock);
+	ufulock = container_of (fulock, struct ufulock, fulock);
+	__fulock_owner_reset (fulock);
+	vl_put (&ufulock->vlocator);
+}
+
+
+/** Initialize an @ufulock (for slab object construction). */
+static
+void ufulock_ctor (void *obj, kmem_cache_t *slab, unsigned long flags)
+{
+	struct ufulock *ufulock = obj;
+	__fulock_init (&ufulock->fulock, &ufulock_ops);
+	vlocator_init (&ufulock->vlocator);
+}
+
+
+/** Allocate an ufulock maintaining debug-allocation counts. */
+static __inline__
+struct vlocator * ufulock_alloc (void)
+{
+	struct ufulock *ufulock;
+	ufulock = kmem_cache_alloc (ufulock_slab, GFP_KERNEL);
+	if (DEBUG > 0 && ufulock != NULL)
+		ldebug (1, "ufulock %p allocated, total: %d\n",
+			ufulock, allocated_inc());
+	return &ufulock->vlocator;
+}
+
+
+/**
+ * Create a ufulock that is going to be inserted to the hash
+ * [called from ufu-common.c:ufu_locate()]
+ */
+static
+void ufulock_create (struct vlocator *vl, struct page *page,
+		     const union futex_key *key, unsigned flags)
+{
+	struct ufulock *ufulock = container_of (vl, struct ufulock, vlocator);
+	ufulock->fulock.flags = (flags & FULOCK_FL_USER_MK) | FULOCK_FL_NEW;
+	memcpy (&vl->key, key, sizeof (*key));
+	get_key_refs (&vl->key);
+	get_page (page);
+	ufulock->page = page;
+}
+
+
+/** Release @ufulock's resources. */
+static __inline__
+void ufulock_release (struct vlocator *vl)
+{
+	struct ufulock *ufulock = container_of (vl, struct ufulock, vlocator);
+	BUG_ON (ufulock->page == NULL);
+	put_page (ufulock->page);
+	drop_key_refs (&vl->key);
+}
+
+
+/** Free an ufulock maintaining debug-allocation counts. */
+static __inline__
+void ufulock_free (struct vlocator *vl)
+{
+	struct ufulock *ufulock = container_of (vl, struct ufulock, vlocator);
+	kmem_cache_free (ufulock_slab, ufulock);
+	if (DEBUG > 0 && ufulock != NULL)
+		ldebug (1, "ufulock %p freed, total: %d\n",
+			ufulock, allocated_dec());
+}
+
+
+struct vlocator_ops ufulock_vops = {
+	.alloc = ufulock_alloc,
+	.create = ufulock_create,
+	.release = ufulock_release,
+	.free = ufulock_free
+};
+
+
+
+/**
+ * Set @vfulock with, maintaining consistency with @fulock.
+ *
+ * We don't care about the previous value because we only call this
+ * function from points where the kernel has control over the ufulock
+ * and the associated vfulock (KCO: Kernel Controlled Ownership).
+ */
+static __inline__
+void __vfulock_update (volatile unsigned *vfulock,
+		       const struct fulock *fulock, unsigned value)
+{
+	ftrace ("(%p, %p, %u/%x)\n", vfulock, fulock, value, value);
+	
+	if (fulock->flags & FULOCK_FL_DEAD)
+		value = VFULOCK_DEAD;
+	else if (fulock->flags & FULOCK_FL_NR)
+		value = VFULOCK_NR;
+	vfulock_set (vfulock, value);
+	return;
+}
+
+
+/** @returns expected value of the vfulock given the state of the
+ * @fulock. */ 
+static inline
+unsigned __vfulock_expected (struct fulock *fulock)
+{
+	if (fulock->flags & FULOCK_FL_DEAD)
+		return VFULOCK_DEAD;
+	else if (fulock->flags & FULOCK_FL_NR)
+		return VFULOCK_NR;
+	else if (fulock->owner == NULL)
+		return VFULOCK_UNLOCKED;
+	else if (__fulock_empty (fulock) && fulock->owner == NULL)
+		return fulock->owner->pid;
+	else
+		return VFULOCK_KCO;
+}
+
+
+/** 
+ * Perform owner identification chores for __vfulock_sync()
+ *
+ * Probably one of the dirtiest functions I've ever written. The thing
+ * that makes it complex is that after we assign ownership, somebody
+ * the target task might start to exit, and we don't know if it has
+ * gone through exit_fulocks() after we added the fulock to its
+ * ownership list, so we have to be paranoid.
+ *
+ * FIXME: false positives if the PID is reused are the rule. Remedies:
+ *
+ * - The chance of that happening will depend on what the reuse rate is,
+ *   how frequently are we assigning new PIDs and the probability of
+ *   the sucker dying in the middle of it (so a well-coded program
+ *   should be fine, except for the OOM killer, or a crazy process
+ *   killing -9 randomly...).
+ *
+ *   Let's say the probability is P (one in X)
+ *
+ * - Limit PIDs to 64Ki - 3 (to account for NR, DEAD and KCO), create a
+ *   16 bit hash for each task with immutable elements (eg: pointer,
+ *   start time...); compose the hash and the 16 bit pid into a 32 bit
+ *   thing that the user space uses for fast-locking. When id'ing,
+ *   locate the task by PID, hash it out and compare it; if it fails,
+ *   the PID was reused, if not, keep on:
+ *
+ *   (there are still chances of collision, but I think we have cut
+ *   P down by 64Ki)
+ *   
+ * - Check the mm mappings. If the task doesn't have the mapping where
+ *   the fulock is, well, that was a collision (and that was chance,
+ *   probably like shoting up to the sky in the middle of the dessert,
+ *   the bullet falling back to the ground, hitting this man [who
+ *   happened to be wandering around all lost] in the forehead,
+ *   killing him, and it happens he is some rotten-rich guy who had
+ *   randomly chosen somebody on the phone book to pass on all his
+ *   wealth and that one happens to be you).
+ * 
+ * - Now, if the task has the same mapping, we assume it is good.
+ *
+ * I think I cannot be more of a pain in the ass, and probably the
+ * mapping thing is overkill; the hash thing looks like more than
+ * enough, and it is pretty cheap (wasn't computing an exact science?
+ * my flaming bullas).
+ * 
+ * If still not good enough to you, use KCO mode, sacrificing speed.
+ */
+static
+int __fulock_id_owner (struct fulock *fulock, volatile unsigned *vfulock,
+		       unsigned owner_pid, int do_lock)
+{
+	int result = EBUSY;
+	struct task_struct *task;
+
+	ftrace ("(%p, %p, %u, %d)\n", fulock, vfulock, owner_pid, do_lock);
+	CHECK_IRQs();
+	
+	BUG_ON (fulock->owner != NULL);
+	_raw_read_lock (&tasklist_lock);
+	task = find_task_by_pid (owner_pid);
+	if (task == NULL || task->flags & PF_EXITING) 
+		goto dead_unlock;
+	get_task_struct (task);
+	_raw_read_unlock (&tasklist_lock);
+	__ufulock_owner_set (fulock, task);
+	if (unlikely (task->flags & PF_EXITING)) {
+		__ufulock_owner_reset (fulock);
+		put_task_struct (task);
+		goto dead;
+	}
+	put_task_struct (task);
+	return result;
+
+dead_unlock:
+	_raw_read_unlock (&tasklist_lock);
+dead:
+	result = -EOWNERDEAD;
+	vfulock_set (vfulock, VFULOCK_DEAD);
+	fulock->flags |= FULOCK_FL_DEAD;
+	if (do_lock)
+		__ufulock_owner_set (fulock, current);
+	return result;
+}
+
+
+/** 
+ * Sync up a ufulock and its associated vfulock and maybe fast-lock.
+ *
+ * @uf: The ufulock to sync up.
+ * @vfulock: pointer to a kmapped associated value.
+ * @returns: < 0 errno code on error [we did not acquire it]
+ *	     -EOWNERDEAD [previous owner died, we got it]
+ *	     0 if we locked it to a PID (and thus 'current' is owner)
+ *	     > 0 if we didn't lock it, need to proceed to fulock
+ *
+ * Call with uf->fulock.fuqueue.lock held!
+ *
+ * This syncs up the vfulock and the ufulock (if the ufulock is new,
+ * sync from vfulock->ufulock, or the opposite). It tries to leave the
+ * ufulock as it if where a kernel fulock, for the fulock layer to
+ * operate on it.
+ *
+ * When we see VFULOCK_UNLOCKED and move to PID, we don't set the
+ * owner, because there will be nobody coming down to the kernel to
+ * reset it [at any effect, it is like if we had done a user space
+ * fast-lock operation].
+ *
+ * The vfulock can only be modified in the following ways:
+ * - In user space:
+ *   - when fast-locking: VFULOCK_UNLOCKED to PID
+ *   - when fast-unlocking: PID to VFULOCK_UNLOCKED
+ *   - when reinitializing from not-recoverable: VFULOCK_NR to VFULOCK_UNLOCKED
+ *   - Illegally: any other transition [mistake, error, wild pointer]
+ * - In kernel space: When we have the lock over the ufulock
+ *   associated to that vfulock.
+ *
+ * That means that as we are called with the lock held, we can modify
+ * the vfulock at will knowing that nobody is going to touch it as
+ * long as it is not VFULOCK_UNLOCKED (fast-lock), a PID
+ * (fast-unlock)--the not-recoverable case is not of concern because
+ * as soon as anyone sees it, they bail out, so we never get to modify
+ * it.
+ *
+ * Now, for those legal-from-user-space modifications, we operate
+ * atomic; the while(1) loop and vfulock_acas() protect against this.
+ */
+static
+int __vfulock_sync (struct ufulock *uf, volatile unsigned *vfulock,
+		    unsigned do_lock)
+{
+	int result = 0;
+	unsigned val, expected = 0, sync_k2u = 0;
+
+	ftrace ("(%p, %p, %u)\n", uf, vfulock, do_lock);
+
+	if ((uf->fulock.flags & FULOCK_FL_NEW) == 0) {
+		sync_k2u = 1;		       /* synch kernel-to-user */
+		expected = __vfulock_expected (&uf->fulock);
+	}
+	while (1) {
+		val = *vfulock;
+		if (sync_k2u && val != expected) { /* Unexpected changes? */
+			if (expected == VFULOCK_UNLOCKED && val < VFULOCK_KCO)
+				goto make_kco; /* Legal: locked? */
+			if (expected < VFULOCK_KCO && val == VFULOCK_UNLOCKED)
+				goto fast_lock; /* Legal: unlocked? */
+			if (!vfulock_acas (vfulock, val, expected))
+				continue;      /* Illegal: reset it */
+			val = expected;
+		}
+		switch (val) {
+		    case VFULOCK_UNLOCKED:     /* unlocked, fast-lock it */
+fast_lock:
+			if (do_lock == 0)
+				goto out;
+			if (vfulock_acas (vfulock, val, current->pid))
+				goto out;
+			break;
+		    case VFULOCK_DEAD:	       /* idem, but dead owner */
+			uf->fulock.flags |= FULOCK_FL_DEAD;
+		    case VFULOCK_KCO:	       /* kernel controlled */
+			result = EBUSY;
+			goto out_synced;
+		    case VFULOCK_NR:	       /* gee...gone completely */
+			uf->fulock.flags |= FULOCK_FL_NR;
+			result = -ENOTRECOVERABLE;
+			goto out_synced;
+		    default:		       /* This is a PID(locked) no waiters */
+make_kco:
+			if (vfulock_acas (vfulock, val, VFULOCK_KCO))
+				goto id_owner;	       
+		}
+	}			 
+id_owner:		       /* Id owner, mark as dead if it died */
+	result = __fulock_id_owner (&uf->fulock, vfulock, val, do_lock);
+out_synced:
+	uf->fulock.flags &= ~FULOCK_FL_NEW;
+out:			       /* We are the sole owners of the lock */
+	__DEBUG_get_value (result, vfulock);
+	return result;
+}
+
+
+/** Helper for kmapping the user's vfulock to the kernel. */
+static inline
+volatile unsigned * vfulock_kmap (struct ufulock *ufulock)
+{
+	ftrace ("(%p)\n", ufulock);
+	BUG_ON (ufulock->page == NULL);
+	return (volatile unsigned *)
+		(kmap_atomic (ufulock->page, KM_IRQ0)
+		 + (ufulock->vlocator.key.both.offset & ~1));
+}
+
+/** Unmap the user's vfulock from the kernel. */
+static inline
+volatile unsigned * vfulock_kunmap (volatile unsigned *vfulock)
+{
+	ftrace ("(%p)\n", vfulock);
+	kunmap_atomic ((void *) (PAGE_MASK & (unsigned long)vfulock), KM_IRQ0);
+}
+	
+
+/**
+ * Lock a ufulock, maybe wait for it to be available.
+ *
+ * @returns: 0 if acquired, < 0 errno code on error.
+ *	     -EAGAIN   Not acquired, try again [change this, conflicst
+ *		       with POSIX]
+ *	     -EBUSY    Not acquired, is locked, didn't block
+ *	     -EBADR    Not acquired, fulock is not recoverable
+ *	     -ESRCH    Acquired, previous owner died, data might be
+ *		       inconsistent
+ *	     *	       Not acquired, error.
+ *
+ * USER CONTEXT ONLY
+ *
+ * What we do is the minimal operations to obtain a fulock that cannot
+ * be distinguished from a kernel-only fulock and then call the fulock
+ * layer for doing the locking.
+ *
+ * For obtaining that fulock, we use the address [ufulock_locate()],
+ * lock it and sync up the vfulock and ufulock [__vfulock_sync()],
+ * then ask the fulock layer to lock for us [__fulock_lock()], if we
+ * have to].
+ */
+int ufulock_lock (struct ufulock *ufulock, unsigned flags,
+		  signed long timeout)
+{
+	volatile unsigned *vfulock;
+	int result;
+	
+	ftrace ("(%p, %x, %ld)\n", ufulock, flags, timeout);
+	might_sleep();
+
+	/* Check flags */
+	spin_lock_irq (&ufulock->fulock.fuqueue.lock);
+	result = -EINVAL;
+	if (flags != (ufulock->fulock.flags & FULOCK_FL_USER_MK))
+		goto out_unlock;
+	/* sync up kernel and user space, maybe fast-lock */
+try_again:
+	vfulock = vfulock_kmap (ufulock);
+	result = __vfulock_sync (ufulock, vfulock, 1);
+	vfulock_kunmap (vfulock);
+	if (result <= 0)		     /* Error or fast-locked */
+		goto out_unlock;
+	result = __fulock_lock (&ufulock->fulock, timeout);
+	if (result == -EAGAIN) {
+		spin_lock_irq (&ufulock->fulock.fuqueue.lock);
+		goto try_again;	       /* Non-serialized wake up */
+	}
+	return result;
+	
+out_unlock:
+	spin_unlock_irq (&ufulock->fulock.fuqueue.lock);
+	return result;
+}
+
+
+/**
+ * Lock a ufulock, maybe wait for it to be available.
+ *
+ * @returns: 0 if acquired, < 0 errno code on error.
+ *	     -EAGAIN   Not acquired, try again [change this, conflicst
+ *		       with POSIX]
+ *	     -EBUSY    Not acquired, is locked, didn't block
+ *	     -EBADR    Not acquired, fulock is not recoverable
+ *	     -ESRCH    Acquired, previous owner died, data might be
+ *		       inconsistent
+ *	     *	       Not acquired, error.
+ *
+ * USER CONTEXT ONLY
+ *
+ * Massage everything, locate an ufulock and lock it with uflock_lock().
+ */
+asmlinkage
+int sys_ufulock_lock (volatile unsigned __user *_vfulock, unsigned flags,
+		      struct timespec __user *_timeout)
+{
+	struct ufulock *ufulock;
+	struct vlocator *vl;
+	signed long timeout;
+	int result = -EINVAL;
+	
+	ftrace ("(%p, 0x%x, %p)\n", _vfulock, flags, _timeout);
+
+	/* FIXME: temporary, until PI supports SCHED_NORMAL */
+	if (unlikely (current->policy == SCHED_NORMAL && flags & FULOCK_FL_PI))
+		goto out;
+	/* Pin page, get key, look up/allocate the ufulock, refcount it */
+	result = vl_locate (NULL, &vl, &ufulock_vops, _vfulock, flags);
+	if (unlikely (result < 0))
+		goto out;
+	ufulock = container_of (vl, struct ufulock, vlocator);
+	timeout = ufu_timespec2jiffies (_timeout);
+	result = (int) timeout;
+	if (unlikely (timeout < 0))
+		goto out_put;
+	result = ufulock_lock (ufulock, flags, timeout);
+out_put:
+	vl_put (vl);
+out:
+	DEBUG_get_value (result, _vfulock);
+	return result;
+}
+
+
+/**
+ * Sync up an unfulock, then unlock it.
+ *
+ * @uf:	     ufulock structure.
+ * @flags:   flags from users pace for the ufulock
+ * @howmany: Wake up this many waiters; if 0, wake up only one,
+ *	     forcing a serialization in the acquisition of the
+ *	     lock, so that no other task (in user or kernel space)
+ *	     can acquire it in the meantime.
+ * @returns: 0 if ok, < 0 errno code on error.
+ */
+int __ufulock_unlock (struct ufulock *ufulock, unsigned flags,
+		      size_t howmany)
+{
+	volatile unsigned *vfulock;
+	int result = -EINVAL;
+	
+	ftrace ("(%p, %x, %zu)\n", ufulock, flags, howmany);
+	CHECK_IRQs();
+	
+	if (flags != (ufulock->fulock.flags & FULOCK_FL_USER_MK))
+		goto out;
+	vfulock = vfulock_kmap (ufulock);
+	result = __vfulock_sync (ufulock, vfulock, 0);
+	if (result < 0)
+		goto out_kunmap;
+	/* Now do a proper unlock and update the vfulock */
+	if (howmany > 0)
+		__vfulock_update (vfulock, &ufulock->fulock, VFULOCK_UNLOCKED);
+	result = __fulock_unlock (&ufulock->fulock, howmany, 0);
+	if (result < 0)
+		goto out_kunmap;
+	if (howmany == 0) {
+		unsigned new_val;
+		if (result == 0)
+			new_val = VFULOCK_UNLOCKED;
+		else if (result == 1) {	  /* enable fast-unlock */
+			new_val = ufulock->fulock.owner->pid;
+			__ufulock_owner_reset (&ufulock->fulock);
+		}
+		else
+			new_val = VFULOCK_KCO;
+		__vfulock_update (vfulock, &ufulock->fulock, new_val);
+	}
+	result = 0;
+out_kunmap:
+	vfulock_kunmap (vfulock);
+out:
+	return result;
+}
+
+
+/**
+ * Unlock an ufulock, waking up waiter(s)
+ *
+ * @_vfulock:  Address for the fulock (user space).
+ * @howmany: Number of waiters to wake up [see ufulock_unlock()]
+ * @returns: 0 if ok, < 0 errno code on error.
+ *
+ * USER CONTEXT ONLY
+ *
+ * There is a gloomy thing here. We should be just looking for a
+ * ufulock associated to _vfulock and if not found, assume there are
+ * no waiters and just set *_vfulock to unlocked.
+ *
+ * But by doing that, we can provoke a race condition; if another
+ * thread B just came in, saw it locked, went into the kernel, saw it
+ * unlocked and acquired it, then it would set the vfulock to KCO and
+ * the original thread A in this moment sets the vfulock to unlocked
+ * -- havoc happens.
+ *
+ * So we force to do exactly the same thing as lock() do, we locate();
+ * this way, we also force the caching of the fulock to be
+ * refreshed. Then, the setting of the *_vfulock [from inside the
+ * kernel] is protected by the spinlock.
+ */
+asmlinkage
+int sys_ufulock_unlock (volatile unsigned __user *_vfulock, unsigned flags,
+			size_t howmany)
+{
+	struct vlocator *vl;
+	struct ufulock *ufulock;
+	int result = -ENOMEM;
+	unsigned long cpu_flags;
+	
+	ftrace ("(%p, %u, %zu)\n", _vfulock, flags, howmany);
+	
+	/* Pin page, get key, look up/allocate the ufulock, refcount it */
+	result = vl_locate (NULL, &vl, &ufulock_vops, _vfulock, flags);
+	if (unlikely (result < 0))
+		goto out;
+	ufulock = container_of (vl, struct ufulock, vlocator);
+	spin_lock_irqsave (&ufulock->fulock.fuqueue.lock, cpu_flags);
+	result = __ufulock_unlock (ufulock, flags, howmany);
+	spin_unlock_irqrestore (&ufulock->fulock.fuqueue.lock, cpu_flags);
+	vl_put (vl);
+out:
+	DEBUG_get_value (result, _vfulock);
+	return result;
+}
+
+
+/**
+ * Change the consistency state of a fulock -- just call the fulock
+ * layer to do it and update the vfulock in user space.
+ *
+ * @_vfulock: Location of the fulock in user space
+ * @flags: flags for the fulock
+ * @consistency: consistency to set to (fulock_con_*). Note it is not
+ *		 possible to set from some states to others.
+ * @returns: >= 0 previous consistency before the change
+ *	     < 0 errno code on error.
+ *
+ * USER CONTEXT ONLY
+ */
+asmlinkage
+int sys_ufulock_consistency (unsigned __user *_vfulock,
+			     unsigned flags, unsigned consistency)
+{
+	struct vlocator *vl;
+	struct ufulock *ufulock;
+	int result;
+	unsigned new_value;
+	volatile unsigned *vfulock;
+	
+	ftrace ("(%p, 0x%x, %u)\n", _vfulock, flags, consistency);
+	might_sleep();
+	
+	/* Pin page, get key, look up/allocate the ufulock, refcount it */
+	result = vl_locate (NULL, &vl, &ufulock_vops, _vfulock, flags);
+	if (unlikely (result < 0))
+		goto out;
+	ufulock = container_of (vl, struct ufulock, vlocator);
+	
+	spin_lock_irq (&ufulock->fulock.fuqueue.lock);  
+	if (consistency != fulock_con_init) {
+		result = -EINVAL;
+		if (flags != (ufulock->fulock.flags & FULOCK_FL_USER_MK))
+			goto out_unlock;
+	}
+	vfulock = vfulock_kmap (ufulock);
+	result = __vfulock_sync (ufulock, vfulock, 0);
+	if (result < 0)
+		goto out_kunmap;
+	/* Set the consistency */
+	result = __fulock_consistency (&ufulock->fulock, consistency);
+	if (result < 0)
+		goto out_kunmap;
+	/* Ok, update the vfulock */
+	switch (result) {
+	    case fulock_st_healthy:
+		if (__fulock_empty (&ufulock->fulock)) {
+			new_value = current->pid;
+			__ufulock_owner_reset (&ufulock->fulock);
+		}
+		else
+			new_value = VFULOCK_KCO;
+		break;
+	    case fulock_st_init:
+		new_value = VFULOCK_UNLOCKED;
+		ufulock->fulock.flags = flags & FULOCK_FL_USER_MK;
+		break;
+	    case fulock_st_dead:
+		new_value = VFULOCK_DEAD;
+		break;
+	    case fulock_st_nr:
+		new_value = VFULOCK_NR;
+		break;		      
+	    default:
+		WARN_ON(1);
+		new_value = 0; /* shut gcc up */
+	}
+	vfulock_set (vfulock, new_value);
+	__DEBUG_get_value (result, vfulock);
+	result = 0;
+out_kunmap:
+	vfulock_kunmap (vfulock);
+out_unlock:
+	spin_unlock_irq (&ufulock->fulock.fuqueue.lock);
+	vl_put (vl);
+out:
+	return result;	      
+}
+
+
+/** Release as dead @ufulock because the owner is exiting. */
+void __ufulock_exit (struct fulock *fulock)
+{
+	struct ufulock *ufulock;
+	volatile unsigned *vfulock;
+	
+	ftrace ("(%p)\n", fulock);
+
+	ufulock = container_of (fulock, struct ufulock, fulock);
+	vfulock = vfulock_kmap (ufulock);
+	/* Update the vfulock to VFULOCK_DEAD */
+	__vfulock_update (vfulock, fulock, VFULOCK_DEAD);
+	vfulock_kunmap (vfulock);
+	__fulock_exit (fulock);
+}
+
+
+/** Cancel @task's wait on the ufulock */
+unsigned __ufulock_wait_cancel (struct fuqueue *fuqueue,
+				struct fuqueue_waiter *w)
+{
+	unsigned prio_changed;
+	struct fulock *fulock =
+		container_of (fuqueue, struct fulock, fuqueue);
+	struct ufulock *ufulock =
+		container_of (fulock, struct ufulock, fulock);
+	
+	ftrace ("(%p, %p [%d], %p)\n", fuqueue, w, w->task->pid, w);
+	
+	prio_changed = __fulock_wait_cancel (fuqueue, w);
+	if (__fulock_empty (fulock)) {
+		/* Re-enable fast unlock */
+		volatile unsigned *vfulock;
+		int pid = fulock->owner->pid;
+		__ufulock_owner_reset (fulock);
+		vfulock = vfulock_kmap (ufulock);
+		__vfulock_update (vfulock, fulock, pid);
+		vfulock_kunmap (vfulock);
+	}
+	return prio_changed;
+}
+
+
+/* Adaptors for fulock operations */
+static
+void ufulock_put (struct fuqueue *fuqueue) 
+{
+	struct fulock *fulock =
+		container_of (fuqueue, struct fulock, fuqueue);
+	struct ufulock *ufulock =
+		container_of (fulock, struct ufulock, fulock);
+	vl_put (&ufulock->vlocator);
+}
+
+static
+void ufulock_get (struct fuqueue *fuqueue) 
+{
+	struct fulock *fulock =
+		container_of (fuqueue, struct fulock, fuqueue);
+	struct ufulock *ufulock =
+		container_of (fulock, struct ufulock, fulock);
+	vl_get (&ufulock->vlocator);
+}
+
+/** ufulock fulock operations */
+struct fulock_ops ufulock_ops = {
+	.fuqueue = {
+		.get = ufulock_get,
+		.put = ufulock_put,
+		.wait_cancel = __ufulock_wait_cancel,
+		.chprio = __fulock_chprio
+	},
+	.owner_set = __ufulock_owner_set,
+	.owner_reset = __ufulock_owner_reset,
+	.exit = __ufulock_exit,
+};
+
+
+/**
+ * Initialize the ufulock subsystem.
+ */
+static
+int __init subsys_ufulock_init (void)
+{
+	ufulock_slab = kmem_cache_create ("ufulock", sizeof (struct ufulock),
+					  0, 0, ufulock_ctor, NULL);
+	if (ufulock_slab == NULL) 
+		panic ("ufulock_init(): "
+		       "Unable to initialize ufulock slab allocator.\n");
+	return 0;
+}
+__initcall (subsys_ufulock_init);
+
+
+/**
+ * Convert a user 'struct timespec *' to jiffies with a twist
+ *
+ * @_timespec: pointer to user space 'struct timespec'.
+ *
+ * @returns: MAX_SCHEDULE_TIMEOUT
+ *		    Wait for ever, if @_timespec is (void *) -1.
+ *	     0	    Don't wait at all (if @_timespec is NULL).
+ *	     Other: Number of jiffies to wait as specified in
+ *		    @_timespec.
+ *
+ * I kind of think this is still a little bit twisted -- raise your
+ * hand if you can think of a better arrangement.
+ *
+ * WARNING: might sleep!
+ */
+signed long ufu_timespec2jiffies (const struct timespec __user *_timespec)
+{
+	struct timespec timespec;
+	signed long j;
+	
+	might_sleep();
+	if (_timespec == NULL)
+		j = 0;
+	else if (_timespec == (struct timespec *) ~0)
+		j = MAX_SCHEDULE_TIMEOUT;
+	else {
+		if (copy_from_user (&timespec, _timespec, sizeof (timespec)))
+			return -EFAULT;
+		j = timespec_to_jiffies (&timespec);
+	}
+	return j;
+}
