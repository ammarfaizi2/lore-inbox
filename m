Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264710AbUDUERD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264710AbUDUERD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 00:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264764AbUDUERD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 00:17:03 -0400
Received: from ip-66-80-228-130.sjc.megapath.net ([66.80.228.130]:50931 "EHLO
	sodium.co.intel.com") by vger.kernel.org with ESMTP id S264710AbUDUD7D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 23:59:03 -0400
Date: Tue, 20 Apr 2004 21:04:21 -0700
From: inaky.perez-gonzalez@intel.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com
Subject: [RFC/PATCH] FUSYN 11/11: user space fulocks
Message-ID: <0404202104.xbfaDbVcjdMdubmcGdHb9boc7cYbOcbd1457@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0404202104.Ya9btbMbKc5dKcmalc4a8dQccalaAdSa1457@intel.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 ufulock.c | 1044 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 1044 insertions(+)

--- /dev/null	Thu Apr 15 00:58:26 2004
+++ kernel/ufulock.c Thu Apr 8 00:17:49 2004
@@ -0,0 +1,1044 @@
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
+ * sys_ufulock_ctl(): control the state of a ufulock
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
+#warning DEBUG: remove me
+//#include <asm/kgdb.h>
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
+static inline
+unsigned __ufulock_op_owner_set (struct fulock *fulock, struct task_struct *task)
+{
+	unsigned prio_changed;
+	struct ufulock *ufulock;
+	
+	ftrace ("(%p, %p [%d])\n", fulock, task, task->pid);
+	ufulock = container_of (fulock, struct ufulock, fulock);
+	prio_changed = __fulock_op_owner_set (fulock, task);
+	vl_get (&ufulock->vlocator);
+	return prio_changed;
+}
+
+
+/** Reset an ufulock ownership and drop its use count. */
+static inline
+unsigned __ufulock_op_owner_reset (struct fulock *fulock)
+{
+	unsigned prio_changed;
+	struct ufulock *ufulock;
+	
+	ufulock = container_of (fulock, struct ufulock, fulock);
+	ftrace ("(%p [ufulock %p])\n", fulock, ufulock);
+	prio_changed = __fulock_op_owner_reset (fulock);
+	vl_put (&ufulock->vlocator);
+	return prio_changed;
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
+		ldebug (2, "ufulock %p allocated, total: %d\n",
+			ufulock, allocated_inc());
+	return &ufulock->vlocator;
+}
+
+
+/**
+ * Create a ufulock that is going to be inserted to the hash
+ * [called from ufu-common.c:ufu_locate()]. Reference its resources
+ * and initialize what is not initialized by the cache constructor.
+ */
+static
+void ufulock_create (struct vlocator *vl, struct page *page,
+		     const union futex_key *key, unsigned flags)
+{
+	struct ufulock *ufulock = container_of (vl, struct ufulock, vlocator);
+	ufulock->fulock.flags = (flags & FULOCK_FL_USER_MK)
+		| FULOCK_FL_NEEDS_SYNC;
+#warning FIXME: if PP, transform flags from POLICY+PRIO to RAWPRIO.
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
+		ldebug (2, "ufulock %p freed, total: %d\n",
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
+ * Set @vfulock, maintaining consistency with @fulock.
+ *
+ * We just make sure that whichever value we put doesn't override the
+ * VFULOCK_DEAD or VFULOCK_NR indicators.
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
+unsigned __vfulock_expected_nonkco (struct fulock *fulock)
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
+		return VFULOCK_WP;
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
+ * - Limit PIDs to 64Ki - 3 (to account for _NR, _DEAD and _WP), create
+ *   a 16 bit hash for each task with immutable elements (eg: pointer,
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
+	__ufulock_op_owner_set (fulock, task);
+	if (unlikely (task->flags & PF_EXITING)) {
+		__ufulock_op_owner_reset (fulock);
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
+		__ufulock_op_owner_set (fulock, current);
+	return result;
+}
+
+
+/** 
+ * Sync up a ufulock that supports fast-userspace locking and its associated
+ * vfulock and maybe fast-lock.
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
+int __vfulock_sync_nonkco (struct ufulock *ufulock, volatile unsigned *vfulock,
+			   unsigned do_lock)
+{
+	int result = 0;
+	unsigned val, expected = 0, sync_k2u = 0;
+
+	ftrace ("(%p, %p, %u)\n", ufulock, vfulock, do_lock);
+
+	if ((ufulock->fulock.flags & FULOCK_FL_NEEDS_SYNC) == 0) {
+		sync_k2u = 1;		       /* synch kernel-to-user */
+		expected = __vfulock_expected_nonkco (&ufulock->fulock);
+	}
+	while (1) {
+		val = *vfulock;
+		//		kgdb_ts ((unsigned long) ufulock, *vfulock);
+		if (sync_k2u && val != expected) { /* Unexpected changes? */
+			printk (KERN_WARNING "pid %d (%s) (ufulock %p"
+				"): out of sync, val %u/0x%x, "
+				"expected %u/0x%x. Fixing.\n",
+				current->pid, current->comm,
+				ufulock, val, val, expected, expected);
+			if (expected == VFULOCK_UNLOCKED && val < VFULOCK_WP)
+				goto make_kco; /* Legal: locked? */
+			if (expected < VFULOCK_WP && val == VFULOCK_UNLOCKED)
+				goto fast_lock; /* Legal: unlocked? */
+			if (!vfulock_acas (vfulock, val, expected))
+				continue;      /* Illegal: reset it */
+			val = expected;
+		}
+		switch (val) {
+		case VFULOCK_UNLOCKED:     /* unlocked, fast-lock it */
+fast_lock:
+			//			kgdb_ts ((unsigned long) uf, *vfulock);
+			if (do_lock == 0)
+				goto out;
+			//			kgdb_ts ((unsigned long) uf, *vfulock);
+			if (__fulock_empty (&ufulock->fulock)) {
+				if (vfulock_acas (vfulock, val, current->pid))
+					goto out;
+			}
+			else if (vfulock_acas (vfulock, val, VFULOCK_WP)) {
+				result = EBUSY;
+				goto out_synced;
+			}
+			break;
+		case VFULOCK_DEAD:	       /* idem, but dead owner */
+			ufulock->fulock.flags |= FULOCK_FL_DEAD;
+		case VFULOCK_WP:	       /* kernel controlled */
+			result = EBUSY;
+			goto out_synced;
+		case VFULOCK_NR:	       /* gee...gone completely */
+			ufulock->fulock.flags |= FULOCK_FL_NR;
+			result = -ENOTRECOVERABLE;
+			goto out_synced;
+		default:		       /* This is a PID(locked) no waiters */
+make_kco:
+			if (vfulock_acas (vfulock, val, VFULOCK_WP))
+				goto id_owner;	       
+		}
+	}			 
+id_owner:		       /* Id owner, mark as dead if it died */
+	result = __fulock_id_owner (&ufulock->fulock, vfulock, val, do_lock);
+out_synced:
+	ufulock->fulock.flags &= ~FULOCK_FL_NEEDS_SYNC;
+out:			       /* We are the sole owners of the lock */
+	__DEBUG_get_value (result, vfulock);
+#warning DEBUG: remove me
+	//	if (result == 0)
+	//		kgdb_ts ((unsigned long) ufulock, *vfulock);
+	return result;
+}
+
+
+/**
+ * @returns expected value of the vfulock given the state of the
+ * @fulock for KCO mode fulocks.
+ */ 
+static inline
+unsigned __vfulock_expected_kco (struct fulock *fulock)
+{
+	if (fulock->flags & FULOCK_FL_DEAD)
+		return VFULOCK_DEAD;
+	else if (fulock->flags & FULOCK_FL_NR)
+		return VFULOCK_NR;
+	return VFULOCK_HEALTHY;
+}
+
+
+/**
+ * Synchronize a KCO ufulock with the KCO vfulock in user space.
+ *
+ * KCO ufulocks exist only in kernel space when someone owns them (and
+ * when nobody does, for a while in the cache). When it dissapears, we
+ * need to keep somewhere the state of the fulock (if it was healthy,
+ * dead or not-recoverable). We use the vfulock, and VFULOCK_HEALTHY
+ * (for convenience, the same as VFULOCK_UNLOCKED), VFULOCK_DEAD and
+ * VFULOCK_NR. 
+ *
+ * The checks are just to be a PITA and catch errors; they will also
+ * fix up stuff (being the information in the kernel the authoritative
+ * reference). 
+ */
+static
+int __vfulock_sync_kco (struct ufulock *ufulock, volatile unsigned *vfulock)
+{
+	struct fulock *fulock;
+	int result = EBUSY;
+	unsigned val, new_flags, expected;
+	
+	ftrace ("(%p, %p)\n", ufulock, vfulock);
+
+	fulock = &ufulock->fulock;
+	val = *vfulock;
+	new_flags = fulock->flags & ~FULOCK_FL_NEEDS_SYNC;
+	if ((fulock->flags & FULOCK_FL_NEEDS_SYNC) == 0) {
+		expected = __vfulock_expected_kco (fulock);
+		if (val != expected) {
+ 			printk (KERN_WARNING "pid %d (%s) (ufulock %p"
+				"): out of sync, val %u/0x%x, "
+				"expected %u/0x%x. Fixing.\n",
+ 				current->pid, current->comm,
+ 				ufulock, val, val, expected, expected);
+			__vfulock_update (vfulock, fulock, expected);
+		}
+	}
+	switch (val) {
+	case VFULOCK_HEALTHY:
+		break;
+	case VFULOCK_DEAD:
+		new_flags |= FULOCK_FL_DEAD;
+		break;
+	case VFULOCK_NR:
+		result = -ENOTRECOVERABLE;
+		new_flags |= FULOCK_FL_NR;
+		break;
+		/* Why default to not-recoverable? well somebody
+		 * screwed up the value of this lock, so we can't be
+		 * certain of what was its previous state, so the
+		 * safest thing to do is to kill it left and right.
+		 */
+	default:
+		printk (KERN_WARNING "pid %d (%s) (KCO ufulock %p): "
+			"invalid value 0x%x. Defaulting to not-recoverable.\n",
+			current->pid, current->comm, ufulock, val);
+		__vfulock_update (vfulock, fulock, VFULOCK_NR);
+		new_flags |= FULOCK_FL_NR;
+		__fulock_unlock (fulock, (size_t)~0, -ENOTRECOVERABLE);
+		result = -ENOTRECOVERABLE;
+	}
+	fulock->flags = new_flags;
+	return result;
+}
+
+
+/** 
+ * Sync up a ufulock with the user space vfulock.
+ *
+ * Depending on the type of locking, we go one way or another.
+ */
+static inline
+int __vfulock_sync (struct ufulock *ufulock, volatile unsigned *vfulock,
+		    unsigned do_lock)
+{
+	ftrace ("(%p, %p, %u)\n", ufulock, vfulock, do_lock);
+
+	return ufulock->fulock.flags & FULOCK_FL_KCO? 
+		__vfulock_sync_kco (ufulock, vfulock) :
+		__vfulock_sync_nonkco (ufulock, vfulock, do_lock);
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
+	//	kgdb_ts ((unsigned long) ufulock, result);
+	vfulock_kunmap (vfulock);
+	if (result <= 0)		     /* Error or fast-locked */
+		goto out_unlock;
+	result = __fulock_lock (&ufulock->fulock, timeout);
+	if (result == -EAGAIN) {
+		spin_lock_irq (&ufulock->fulock.fuqueue.lock);
+		goto try_again;	       /* Non-serialized wake up */
+	}
+	//	kgdb_ts ((unsigned long) ufulock, result);
+	return result;
+	
+out_unlock:
+	spin_unlock_irq (&ufulock->fulock.fuqueue.lock);
+	//	kgdb_ts ((unsigned long) ufulock, result);
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
+	/* Pin page, get key, look up/allocate the ufulock, refcount it */
+	result = vl_locate (NULL, &vl, &ufulock_vops, _vfulock, flags);
+	if (unlikely (result < 0))
+		goto out;
+	ufulock = container_of (vl, struct ufulock, vlocator);
+	timeout = ufu_timespec2jiffies (_timeout);
+	result = (int) timeout;
+	if (unlikely (timeout < 0))
+		goto out_put;
+	//	kgdb_ts ((unsigned long) _vfulock, (unsigned long) ufulock);
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
+ * Note the gimmick: when it is an unserialized unlock (howmany > 0),
+ * we need to declare the fulock FULOCK_FL_NEEDS_SYNC so the next time
+ * somebody gets into __vfulock_sync_nonkco(), it will properly sync
+ * from userspace.
+ * 
+ * @ufulock: ufulock structure.
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
+	struct fulock *fulock = &ufulock->fulock;
+	
+	ftrace ("(%p, %x, %zu)\n", ufulock, flags, howmany);
+	CHECK_IRQs();
+	
+	if (flags != (fulock->flags & FULOCK_FL_USER_MK))
+		goto out;
+	vfulock = vfulock_kmap (ufulock);
+	result = __vfulock_sync (ufulock, vfulock, 0);
+	if (result < 0)
+		goto out_kunmap;
+	/* Now do a proper unlock and update the vfulock */
+	if (howmany > 0)
+		__vfulock_update (vfulock, fulock, VFULOCK_UNLOCKED);
+	result = __fulock_unlock (fulock, howmany, 0);
+	if (result < 0)
+		goto out_kunmap;
+	else if (howmany == 0) {
+		unsigned new_val;
+		if (fulock->flags & FULOCK_FL_KCO)
+			new_val = VFULOCK_HEALTHY;
+		else if (result == 0)
+			new_val = VFULOCK_UNLOCKED;
+		else if (result == 1) {	  /* enable fast-unlock */
+			new_val = fulock->owner->pid;
+			fulock->flags |= FULOCK_FL_NEEDS_SYNC;
+			__ufulock_op_owner_reset (fulock);
+		}
+		else
+			new_val = VFULOCK_WP;
+		__vfulock_update (vfulock, &ufulock->fulock, new_val);
+	}
+	else
+		fulock->flags |= FULOCK_FL_NEEDS_SYNC;
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
+ * thread B just came in, saw it locked (vfulock is locker's pid),
+ * went into the kernel, saw it unlocked and acquired it, then it
+ * would set the vfulock to VFULOCK_WP and the original thread A in
+ * this moment sets the vfulock to unlocked -- havoc happens.
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
+	ftrace ("(%p, 0x%x, %zu)\n", _vfulock, flags, howmany);
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
+ * (re)Initialize an ufulock.
+ *
+ * @ufulock: who to reinitialize.
+ * @flags: with thiiiis flags.
+ */
+static
+int __ufulock_init (struct ufulock *ufulock, unsigned flags)
+{
+	volatile unsigned *vfulock;
+	
+	ftrace ("(%p, 0x%x)\n", ufulock, flags);
+	/* Initialization will not fail... */
+	__fulock_ctl (&ufulock->fulock, fulock_ctl_init);
+	ufulock->fulock.flags = (flags & FULOCK_FL_USER_MK)
+		| FULOCK_FL_NEEDS_SYNC;
+	vfulock = vfulock_kmap (ufulock);
+	vfulock_set (vfulock, VFULOCK_UNLOCKED);
+	vfulock_kunmap (vfulock);
+	return 0;
+}
+
+
+/**
+ * Run a control command on a fulock.
+ *
+ * @_vfulock: Location of the fulock in user space
+ * @flags: flags for the fulock
+ * @ctl: Command to run (enum fulock_ctl).
+ * @returns: >= 0 previous consistency before the change (enum fulock_st).
+ *	     < 0 errno code on error.
+ *
+ * USER CONTEXT ONLY
+ */
+asmlinkage
+int sys_ufulock_ctl (unsigned __user *_vfulock, unsigned flags, unsigned ctl)
+{
+	struct vlocator *vl;
+	struct fulock *fulock;
+	struct ufulock *ufulock;
+	int result;
+	unsigned new_value;
+	volatile unsigned *vfulock;
+	
+	ftrace ("(%p, 0x%x, %u)\n", _vfulock, flags, ctl);
+	might_sleep();
+
+	/* Ugly special case numero uno: destruction; can't really
+	 * destroy it (somebody might be using it still), but we can
+	 * disconnect it from the hash until the gc destroys it. */
+	if (ctl == fulock_ctl_destroy) {
+		vl_dispose (&ufulock_vops, _vfulock);
+		return 0;
+	}	
+	/* Pin page, get key, look up/allocate the ufulock, refcount it */
+	result = vl_locate (NULL, &vl, &ufulock_vops, _vfulock, flags);
+	if (unlikely (result < 0))
+		goto out;
+	ufulock = container_of (vl, struct ufulock, vlocator);
+	fulock = &ufulock->fulock;
+	spin_lock_irq (&fulock->fuqueue.lock);
+	/* Ugly special case numero two: Initialization */
+	if (ctl == fulock_ctl_init) {
+		result = __ufulock_init (ufulock, flags);
+		goto out_unlock;
+	}
+	/* make sure flags are consistent */
+	result = -EINVAL;
+	if (flags != (fulock->flags & FULOCK_FL_USER_MK))
+		goto out_unlock;
+	/* Ugly special case number three: do we have waiters? */
+	if (ctl == fulock_ctl_waiters) {
+		result = __fulock_empty (fulock)? 0 : 1;
+		goto out_unlock;
+	}
+	/* Ugly special case number four: is it locked? */
+	if (ctl == fulock_ctl_locked) {
+		result = fulock->owner == NULL? 0 : 1;
+		goto out_unlock;
+	}
+	/* Map the user space area */
+	vfulock = vfulock_kmap (ufulock);
+	result = __vfulock_sync (ufulock, vfulock, 0);
+	if (result < 0)
+		goto out_kunmap;
+	/* Set the consistency */
+	result = __fulock_ctl (fulock, ctl);
+	if (result < 0)
+		goto out_kunmap;
+	/* Ok, update the vfulock */
+	switch (result) {
+	case fulock_st_healthy:
+		if (unlikely (fulock->flags & FULOCK_FL_KCO))
+			new_value = VFULOCK_HEALTHY;
+		else if (__fulock_empty (fulock)) {
+			new_value = current->pid;
+			fulock->flags |= FULOCK_FL_NEEDS_SYNC;
+			__ufulock_op_owner_reset (fulock);
+		}
+		else
+			new_value = VFULOCK_WP;
+		break;
+	case fulock_st_dead:
+		new_value = VFULOCK_DEAD;
+		break;
+	case fulock_st_nr:
+		new_value = VFULOCK_NR;
+		break;		      
+	default:
+		WARN_ON(1);
+		new_value = 0; /* shut gcc up */
+	}
+	vfulock_set (vfulock, new_value);
+	__DEBUG_get_value (result, vfulock);
+	result = 0;
+out_kunmap:
+	vfulock_kunmap (vfulock);
+out_unlock:
+	spin_unlock_irq (&fulock->fuqueue.lock);
+	vl_put (vl);
+out:
+	return result;	      
+}
+
+
+/** Release as dead @ufulock because the owner is exiting. */
+void __ufulock_op_exit (struct fulock *fulock)
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
+	__fulock_op_exit (fulock);
+}
+
+
+/** Cancel @task's wait on the ufulock */
+unsigned __ufulock_op_waiter_cancel (struct fuqueue *fuqueue,
+				     struct fuqueue_waiter *w)
+{
+	unsigned prio_changed;
+	struct fulock *fulock =
+		container_of (fuqueue, struct fulock, fuqueue);
+	struct ufulock *ufulock =
+		container_of (fulock, struct ufulock, fulock);
+	
+	ftrace ("(%p, %p [%d], %p)\n", fuqueue, w, w->task->pid, w);
+	
+	prio_changed = __fulock_op_waiter_cancel (fuqueue, w);
+	if ((fulock->flags & FULOCK_FL_KCO) == 0
+	    && __fulock_empty (fulock)) {
+		/* Re-enable fast unlock */
+		volatile unsigned *vfulock;
+		unsigned value = VFULOCK_UNLOCKED;
+		if (fulock->owner) {
+			value = fulock->owner->pid;
+			ufulock->fulock.flags |= FULOCK_FL_NEEDS_SYNC;
+			__ufulock_op_owner_reset (fulock);
+		}
+		vfulock = vfulock_kmap (ufulock);
+		__vfulock_update (vfulock, fulock, value);
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
+		.waiter_cancel = __ufulock_op_waiter_cancel,
+		.waiter_chprio = __fulock_op_waiter_chprio
+	},
+	.owner_set = __ufulock_op_owner_set,
+	.owner_reset = __ufulock_op_owner_reset,
+	.exit = __ufulock_op_exit,
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
