Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267806AbUGWP5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267806AbUGWP5Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 11:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbUGWP4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 11:56:44 -0400
Received: from fmr06.intel.com ([134.134.136.7]:18819 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S267806AbUGWPlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 11:41:05 -0400
Date: Fri, 23 Jul 2004 08:49:21 -0700
From: inaky.perez-gonzalez@intel.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com, robustmutexes@lists.osdl.org
Subject: [RFC/PATCH] FUSYN 7/11: user space fulocks
Message-ID: <0407230849.lc5bUdlcDaCcGdoa4bzc3bWbjcua2bVa17066@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0407230849.SaccZdndSbec8cacybeaqcNaMaUdkcCd17066@intel.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Support for exporting fulocks to user space: ufulocks. Each
is represented by a user space memory word, a vfulock.


 ufulock.c | 1217 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 1217 insertions(+)

--- /dev/null	Thu Jul 22 14:30:56 2004
+++ kernel/ufulock.c Tue Jul 20 02:33:52 2004
@@ -0,0 +1,1217 @@
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
+ * hash table kept by the vlocator.h code - vl_locate() does the full
+ * work; give it an adress, you get a ufulock. No need to worry about
+ * anything else.
+ *
+ * QUICK ROADMAP:
+ *
+ * sys_ufulock_lock(): [try]lock a fulock from user space
+ * sys_ufulock_unlock(): unlock a fulock from user space
+ * sys_ufulock_ctl(): control the state of a ufulock
+ * __ufulock_exit(): called from fulock.c:exit_fulocks() when a
+ *		     process exits and still holds fulocks.
+ *
+ * TODOs:
+ *
+ * - All the #warning FIXME's need to be sorted out
+ * - vfulock_*(), when taking a fulock, should take a ufulock instead
+ *   of a fulock.
+ */
+
+#include <linux/sched.h>
+#include <linux/swap.h>
+#include <linux/highmem.h>
+#include <linux/plist.h>
+#include <asm/uaccess.h>    /* copy_from_user() */
+#include <linux/init.h>
+#include <linux/pagemap.h>
+
+#include <linux/vlocator.h>
+#include <linux/fulock.h>
+
+extern struct vlocator_ops ufuqueue_vl_ops;
+
+/** Slab for allocation of 'struct ufulock's. */
+static kmem_cache_t *ufulock_slab; 
+
+/** fulock operations for user space fulocks */
+struct fulock_ops ufulock_ops;
+
+
+/**
+ * Set @vfulock, maintaining consistency with @fulock.
+ *
+ * We just make sure that whichever value we put doesn't override the
+ * VFULOCK_DEAD or VFULOCK_NR indicators.
+ */
+static inline
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
+/** @returns true if the @fulock can be made fast-lock */
+static inline
+unsigned __fulock_fast_check (struct fulock *fulock) 
+{
+	if (VFULOCK_FAST == 0)
+		return 0;
+	if (fulock->flags & (FULOCK_FL_DEAD | FULOCK_FL_NR))
+	    return 0;
+	return __fulock_empty (fulock);
+}
+
+
+/** Set an ufulock ownership and increment its use count. */
+static inline
+unsigned __ufulock_op_owner_set (struct fulock *fulock,
+				 struct task_struct *task)
+{
+	unsigned prio_changed;
+	struct ufulock *ufulock;
+	
+	ftrace ("(%p, %p [%d])\n", fulock, task, task->pid);
+	ufulock = container_of (fulock, struct ufulock, fulock);
+	prio_changed = __fulock_op_owner_set (fulock, task);
+	vl_get (&ufulock->vlocator);
+	vl_key_get (&ufulock->vlocator.key);
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
+	vl_key_put (&ufulock->vlocator.key);
+	vl_put (&ufulock->vlocator);
+	return prio_changed;
+}
+
+
+/**
+ * Determine the proper way to unlock a ufulock; update the vfulock
+ * accodingly. 
+ *
+ * @pcode: where to store the wake up code for the waiter
+ * @fulock: fulock being unlocked
+ * @w: waiter that is going to be unblocked to obtain the fulock.
+ * @unlock_type: tentative unlock method selected by the user.
+ * @priv: private pointer for use in an specific way [this is the
+ *        vfulock pointer already kmapped].
+ *        
+ * Note the gimmick: when it is an parallel unlock, we need to declare
+ * the fulock FULOCK_FL_NEEDS_SYNC so the next time somebody gets into
+ * __vfulock_sync_nonkco(), it will properly sync from userspace (as
+ * somebody can, in the meantime, fast-lock it).
+ */
+enum fulock_unlock_type
+ufulock_op_unlock_type (int *pcode, struct fulock *fulock,
+			struct fuqueue_waiter *w,
+			enum fulock_unlock_type unlock_type, void *priv) 
+{
+	volatile unsigned *vfulock = priv;
+
+	ftrace ("(%p, %p, %p, %d, %p)\n",
+		pcode, fulock, w, unlock_type, priv);
+	
+	unlock_type = fulock_op_unlock_type (pcode, fulock, w,
+					     unlock_type, priv);
+	if (unlock_type == FULOCK_UNLOCK_PARALLEL) {
+		*pcode = -EAGAIN;
+		__vfulock_update (vfulock, fulock, VFULOCK_UNLOCKED);
+		fulock->flags |= FULOCK_FL_NEEDS_SYNC;
+	}
+	return unlock_type;
+}
+
+
+/**
+ * Unqueue a waiter and maybe make it owner.
+ *
+ * FIXME: docs
+ * 
+ * As well, takes care of re-enabling fast-path in the ufulock if the
+ * conditions for it are met.
+ */
+void ufulock_op_unqueue (struct fulock *fulock, struct fuqueue_waiter *w,
+			 enum fulock_unlock_type unlock_type, void *priv)
+{
+	volatile unsigned *vfulock = priv;
+	struct fulock_ops *ops =
+		container_of (fulock->fuqueue.ops, struct fulock_ops, fuqueue);
+	struct task_struct *new_owner = w->task;
+
+	ftrace ("(%p, %p, %d, %p)\n", fulock, w, unlock_type, priv);	
+
+	fulock_op_unqueue (fulock, w, unlock_type, NULL);
+	if (unlock_type == FULOCK_UNLOCK_SERIAL) {
+		unsigned new_val;
+		if (!VFULOCK_FAST || fulock->flags & __FULOCK_FL_KCO)
+			new_val = VFULOCK_HEALTHY;
+		else if (__fulock_fast_check (fulock)) { /* enable fast-unlock */
+			new_val = fulock->owner->pid;
+			fulock->flags |= FULOCK_FL_NEEDS_SYNC;
+			_raw_spin_lock (&new_owner->fulock_olist_lock);
+			ops->owner_reset (fulock);
+			_raw_spin_unlock (&new_owner->fulock_olist_lock);
+		}
+		else
+			new_val = VFULOCK_WP;
+		__vfulock_update (vfulock, fulock, new_val);
+	}
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
+static inline
+struct vlocator * ufulock_vl_op_alloc (void)
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
+int ufulock_vl_op_create (struct vlocator *vl, const union vl_key *key,
+			  unsigned long priv)
+{
+	struct ufulock *ufulock = container_of (vl, struct ufulock, vlocator);
+
+	ftrace ("(%p, %p, %lx)\n", vl, key, priv);
+	
+	if (!VFULOCK_FAST && (priv & FULOCK_FL_KCO) == 0)
+		return -EINVAL;
+	ufulock->fulock.flags = (priv & FULOCK_FL_USER_MK)
+		| FULOCK_FL_NEEDS_SYNC;
+#warning FIXME: if PP, transform flags from POLICY+PRIO to RAWPRIO.
+	memcpy (&vl->key, key, sizeof (*key));
+	return 0;
+}
+
+
+/** Free an ufulock maintaining debug-allocation counts. */
+static inline
+void ufulock_vl_op_free (struct vlocator *vl)
+{
+	struct ufulock *ufulock = container_of (vl, struct ufulock, vlocator);
+	kmem_cache_free (ufulock_slab, ufulock);
+	if (DEBUG > 0 && ufulock != NULL)
+		ldebug (2, "ufulock %p freed, total: %d\n",
+			ufulock, allocated_dec());
+}
+
+
+struct vlocator_ops ufulock_vl_ops = {
+	.alloc = ufulock_vl_op_alloc,
+	.create = ufulock_vl_op_create,
+	.release = NULL,
+	.free = ufulock_vl_op_free
+};
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
+	else if (__fulock_empty (fulock))
+		return fulock->owner->pid;
+	else
+		return VFULOCK_WP;
+}
+
+
+/** 
+ * Perform owner identification chores for __vfulock_sync()
+ *
+ * @returns: EBUSY if locked (and the fulock's owner correctly set), 
+ *           -EOWNERDEAD if the owner didn't exist, the current task
+ *           has been made owner and the vfulock/ufulock have been
+ *           marked dead.
+ * 
+ * Probably one of the dirtiest functions I've ever written. The thing
+ * that makes it complex is that after we assign ownership, somebody
+ * the target task might start to exit, and we don't know if it has
+ * gone through exit_fulocks() after we added the fulock to its
+ * ownership list, so we have to be paranoid and check again if the
+ * task is exiting when we take the fulock_olist_lock.
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
+		       unsigned owner_pid, int new_val)
+{
+	int result = EBUSY;
+	struct task_struct *task;
+
+	ftrace ("(%p, %p, %u, %d)\n", fulock, vfulock, owner_pid, new_val);
+	
+	BUG_ON (fulock->owner != NULL);
+	_raw_read_lock (&tasklist_lock);
+	task = find_task_by_pid (owner_pid);
+	if (unlikely (task == NULL || task->flags & PF_EXITING))
+		goto dead_unlock;
+	get_task_struct (task);
+	_raw_read_unlock (&tasklist_lock);
+	
+	_raw_spin_lock (&task->fulock_olist_lock);
+	if (unlikely (task->flags & PF_EXITING)) {
+		_raw_spin_unlock (&task->fulock_olist_lock);
+		put_task_struct (task);
+		goto dead;
+	}
+	__ufulock_op_owner_set (fulock, task);
+	_raw_spin_unlock (&task->fulock_olist_lock);
+	put_task_struct (task);
+	return result;
+
+dead_unlock:
+	_raw_read_unlock (&tasklist_lock);
+dead:
+	result = -EOWNERDEAD;
+	vfulock_set (vfulock, VFULOCK_DEAD);
+	fulock->flags |= FULOCK_FL_DEAD;
+	if (new_val != VFULOCK_UNLOCKED) {
+		_raw_spin_lock (&current->fulock_olist_lock);
+		__ufulock_op_owner_set (fulock, current);
+		_raw_spin_unlock (&current->fulock_olist_lock);
+	}
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
+			   unsigned new_val)
+{
+	int result = 0;
+	unsigned val, expected = 0, sync_k2u = 0;
+	struct fulock *fulock = &ufulock->fulock;
+	
+	ftrace ("(%p, %p, %u)\n", ufulock, vfulock, new_val);
+
+	if ((fulock->flags & FULOCK_FL_NEEDS_SYNC) == 0) {
+		sync_k2u = 1;		       /* synch kernel-to-user */
+		expected = __vfulock_expected_nonkco (&ufulock->fulock);
+	}
+	while (1) {
+		val = *vfulock;
+		if (sync_k2u && val != expected) { /* Unexpected changes? */
+			if (expected == VFULOCK_UNLOCKED && val < VFULOCK_WP)
+				goto make_wp;   /* Legal: locked? */
+			if (val == VFULOCK_WP
+			    && expected > VFULOCK_UNLOCKED
+			    && expected < VFULOCK_WP) {
+				result = EBUSY;
+				goto out; 	/* Legal: was cancelled */
+			}
+			if (expected < VFULOCK_WP && val == VFULOCK_UNLOCKED)
+				goto fast_lock; /* Legal: unlocked? */
+			printk (KERN_WARNING "pid %d (%s), ufulock %p: out of "
+				"sync, val %u/0x%x, expected %u/0x%x. "
+				"Fixing.\n", current->pid, current->comm,
+				ufulock, val, val, expected, expected);
+			if (!vfulock_acas (vfulock, val, expected))
+				continue;	/* Illegal: reset it */
+			val = expected;
+		}
+		switch (val) {
+		case VFULOCK_UNLOCKED:	   /* unlocked, fast-lock it */
+fast_lock:
+			if (new_val == VFULOCK_UNLOCKED)
+				goto out;
+			if (__fulock_empty (&ufulock->fulock)) {
+				if (vfulock_acas (vfulock, val, new_val))
+					goto out;
+			}
+			else if (vfulock_acas (vfulock, val, VFULOCK_WP)) {
+				result = EBUSY;
+				goto out_synced;
+			}
+			break;
+		case VFULOCK_DEAD:	       /* idem, but dead owner */
+			fulock->flags |= FULOCK_FL_DEAD;
+		case VFULOCK_WP:	       /* kernel controlled */
+			result = EBUSY;
+			goto out_synced;
+		case VFULOCK_NR:	       /* gee...gone completely */
+			fulock->flags |= FULOCK_FL_NR;
+			result = -ENOTRECOVERABLE;
+			goto out_synced;
+		default:		       /* A PID, locked; no waiters */
+make_wp:
+			if (vfulock_acas (vfulock, val, VFULOCK_WP))
+				goto id_owner;
+		}
+	}
+	
+	/* Id owner, mark as dead if it died */
+id_owner:
+	result = __fulock_id_owner (&ufulock->fulock, vfulock, val, new_val);
+out_synced:
+	fulock->flags &= ~FULOCK_FL_NEEDS_SYNC;
+out:			       /* We are the sole owners of the lock */
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
+			printk (KERN_WARNING "pid %d (%s) (ufulock %p"
+				"): out of sync, val %u/0x%x, "
+				"expected %u/0x%x. Fixing.\n",
+				current->pid, current->comm,
+				ufulock, val, val, expected, expected);
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
+		__fuqueue_wake (&fulock->fuqueue, (size_t ) ~0,
+				-ENOTRECOVERABLE);
+		__fulock_unlock (fulock, FULOCK_UNLOCK_SERIAL,
+				 (void *) vfulock);
+		new_flags |= FULOCK_FL_NR;
+		result = -ENOTRECOVERABLE;
+	}
+	fulock->flags = new_flags;
+	return result;
+}
+
+
+
+/** @returns expected value of the vfulock given the state of the
+ * @fulock. */ 
+static inline
+unsigned __vfulock_expected (struct fulock *fulock)
+{
+	ftrace ("(%p)\n", fulock);
+
+	return !VFULOCK_FAST || fulock->flags & __FULOCK_FL_KCO?
+		__vfulock_expected_kco (fulock) :
+		__vfulock_expected_nonkco (fulock);
+}
+
+/** 
+ * Sync up a ufulock with the user space vfulock.
+ *
+ * Depending on the type of locking, we go one way or another. In
+ * compile time, wipe out the nonkco path if it is not available for
+ * the architecture (lack of cmpxchg).
+ */
+static inline
+int __vfulock_sync (struct ufulock *ufulock, volatile unsigned *vfulock,
+		    unsigned new_val)
+{
+	ftrace ("(%p, %p, %u)\n", ufulock, vfulock, new_val);
+
+	return !VFULOCK_FAST || ufulock->fulock.flags & __FULOCK_FL_KCO?
+		__vfulock_sync_kco (ufulock, vfulock) :
+		__vfulock_sync_nonkco (ufulock, vfulock, new_val);
+}
+
+
+/** Helper for kmapping the user's vfulock to the kernel. */
+static inline
+volatile unsigned * vfulock_kmap (struct page *page, unsigned long uaddr)
+{
+	ftrace ("(%p, %lx)\n", page, uaddr);
+	return (volatile unsigned *)
+		((unsigned long) kmap_atomic (page, KM_IRQ0)
+		 + uaddr % PAGE_SIZE);
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
+ */
+static
+int ufulock_lock (volatile unsigned __user *_vfulock, unsigned flags,
+		  const struct timeout *timeout)
+{
+	int result;
+	struct ufulock *ufulock;
+	volatile unsigned *vfulock;
+	struct mm_struct *mm = current->mm;
+	struct page *page;
+	union vl_key key;
+	struct vlocator *vl;	
+	struct fuqueue_waiter w = fuqueue_waiter_INIT (current);
+	
+	ftrace ("(%p, %x, %p)\n", _vfulock, flags, timeout);
+	might_sleep();
+
+try_again:
+	/* Generate a key for the _vfulock, find the ufulock for it */
+	down_read (&mm->mmap_sem);
+	result = vl_key_create (&page, &key, current, (unsigned long) _vfulock);
+	if (unlikely (result < 0))
+		goto error_key_create;
+	result = vl_find_or_create (&vl, &key, &ufulock_vl_ops, flags);
+	if (unlikely (result < 0))
+		goto error_find_or_create;
+	ufulock = container_of (vl, struct ufulock, vlocator);
+
+	/* Check flags */
+	spin_lock_irq (&ufulock->fulock.fuqueue.lock);
+	result = -EINVAL;
+	if (flags != (ufulock->fulock.flags & FULOCK_FL_USER_MK))
+		goto error_flags;
+	
+	/* sync up kernel and user space, maybe fast-lock */
+	vfulock = vfulock_kmap (page, (unsigned long) _vfulock);
+	result = __vfulock_sync (ufulock, vfulock, current->pid);
+	vfulock_kunmap (vfulock);
+	if (result <= 0)		     /* Error or fast-locked */
+		goto out_unlock;
+	vl_page_put (page);
+	up_read (&mm->mmap_sem);
+	/* This will block, unlock the spinlock and renable IRQs and preempt */
+	result = __fulock_lock (&ufulock->fulock, &w, timeout);
+	vl_put (vl);
+	vl_key_put (&key);
+	if (result == -EAGAIN)
+		goto try_again;
+	return result;
+
+out_unlock:
+error_flags:
+	spin_unlock_irq (&ufulock->fulock.fuqueue.lock);
+	vl_put (vl);
+error_find_or_create:
+	vl_page_put (page);
+	vl_key_put (&key);
+error_key_create:
+	up_read (&mm->mmap_sem);
+	return result;
+}
+
+
+/**
+ * Syscall entry point for ufulock_lock()
+ *
+ * See ufulock_lock() for more info.
+ *
+ * @_vfulock: User space word associated to the ufulock.
+ * @flags: Flags for the fulock (must be constant along its lifetime).
+ * @timeout: Pointer on struct describing how long to wait for the
+ *           timeout. If NULL, just trylock (don't block), if ~0, wait
+ *           for ever, otherwise, wait as specified by the pointed to
+ *           struct. 
+ * @returns: 0 if acquired, < 0 errno code on error.
+ * 
+ * USER CONTEXT ONLY
+ *
+ * This is just a thin shell, gets the timeout information to the
+ * kernel and calls ufulock_lock() who does the hard work.
+ */
+asmlinkage
+int sys_ufulock_lock (volatile unsigned __user *_vfulock, unsigned flags,
+		      const struct timeout __user *_timeout)
+{
+	int result = -EINVAL;
+	struct timeout *timeout, timeout_kernel;
+	
+	ftrace ("(%p, 0x%x, %p)\n", _vfulock, flags, _timeout);
+	might_sleep();
+	
+	/* We might block, so get the timeout first */
+	if (likely ((struct timeout *) _timeout == MAX_SCHEDULE_TIMEOUT_EXT))
+		timeout = MAX_SCHEDULE_TIMEOUT_EXT;
+	else if (_timeout == NULL)
+		timeout = NULL;
+	else {
+		result = -EFAULT;
+		timeout = &timeout_kernel;
+		if (copy_from_user (timeout, _timeout, sizeof (*timeout)))
+			goto out;
+	}
+	result = ufulock_lock (_vfulock, flags, timeout);
+out:
+	return result;
+}
+
+
+/**
+ * Unlock an ufulock, waking up waiter(s)
+ *
+ * @_vfulock:	Address for the fulock (user space).
+ * @howmany: Number of waiters to wake up [see ufulock_unlock()]
+ * @returns: 0 if ok, < 0 errno code on error.
+ *
+ * USER CONTEXT ONLY
+ *
+ * There could be a potential race condition here. We look for a
+ * ufulock associated to _vfulock and if not found, assume there are
+ * no waiters and exit, touching nothing.
+ *
+ * However, if we touch it, setting the vfulock to unlocked
+ * unconditionally (say we are thread A) bad things will happen when
+ * another thread B just comes in, sees it fast-locked (vfulock is
+ * locker's pid), goes into the kernel, sees it unlocked and acquires
+ * it. Then it would set the vfulock to VFULOCK_WP and the original
+ * thread A in this moment sets the vfulock to unlocked -- havoc
+ * happens.
+ *
+ * So that's why we don't do anything. If the vfulock is VFULOCK_WP
+ * and there is no reference to it in the kernel, then that is an
+ * inconsistency, and the next sync() on it will fix it.
+ * 
+ * Last nitpick: if there is fast-paths and the ufulock is empty, that
+ * means somebody is calling the kernel to unlock a fast-locked
+ * vfulock or that somebody cancelled being the only waiter. We update
+ * properly the vfulock to cover that case before unlocking.
+ */
+asmlinkage
+int sys_ufulock_unlock (volatile unsigned __user *_vfulock, unsigned flags,
+			enum fulock_unlock_type unlock_type)
+{
+	struct mm_struct *mm = current->mm;
+	struct vlocator *vl;
+	struct ufulock *ufulock;
+	struct fulock *fulock;
+	struct page *page;
+	union vl_key key;
+	volatile unsigned *vfulock;
+	int result;
+	
+	ftrace ("(%p, 0x%x, %d)\n", _vfulock, flags, unlock_type);
+	
+	/* Generate a key for the _vfulock, find the ufulock for it */
+	down_read (&mm->mmap_sem);
+	result = vl_key_create (&page, &key, current,
+				(unsigned long) _vfulock);
+	if (unlikely (result < 0))
+		goto error_key_create;
+	result = vl_find (&vl, &key, &ufulock_vl_ops);
+	if (unlikely (result < 0))
+		goto error_find;
+	ufulock = container_of (vl, struct ufulock, vlocator);
+	fulock = &ufulock->fulock;
+
+	/* Map the vfulock, sync up, perform the unlock */
+	spin_lock_irq (&ufulock->fulock.fuqueue.lock);
+	result = -EINVAL;
+	if (flags != (fulock->flags & FULOCK_FL_USER_MK))
+		goto error_unlock;
+	vfulock = vfulock_kmap (page, (unsigned long) _vfulock);
+	result = __vfulock_sync (ufulock, vfulock, VFULOCK_UNLOCKED);
+	if (unlikely (result < 0))
+		goto error_unmap;
+	
+	/* Unlock */
+	if (VFULOCK_FAST && __fulock_empty (fulock))
+		__vfulock_update (vfulock, fulock, VFULOCK_UNLOCKED);
+	__fulock_unlock (fulock, unlock_type, (void *) vfulock);
+	
+	/* Yalla, done -- release resources and leave */
+	result = 0;
+error_unmap:
+	vfulock_kunmap (vfulock);
+error_unlock:
+	spin_unlock_irq (&ufulock->fulock.fuqueue.lock);
+	vl_put (vl);
+error_find:
+	vl_key_put (&key);
+	vl_page_put (page);
+error_key_create:
+	up_read (&mm->mmap_sem);
+	return result;
+}
+
+
+/**
+ * Requeue all waiters from a ufuqueue to a ufulock.
+ *
+ * @_vfuqueue:  Address for the fuqueue (user space)
+ * @_vfulock:	Address for the fulock (user space).
+ * @fulock_flags: Flags for the fulock.
+ * @returns: 0 if ok, < 0 errno code on error.
+ *
+ * We place all the waiters on the fuqueue in the ufulock's
+ * fuqueue--in such a way that unlock recognizes it is not a fulock
+ * waiter per se.
+ *
+ * If the ufulock is unlocked, wake up the first waiter.
+ *
+ * Tricky thing here: we need to lock the vfulock so while we are
+ * tinkering around nobody can change it. So we tell vfulock_sync() to
+ * lock the vfulock with VFULOCK_WP (any other case will be _DEAD or
+ * _NR and requires the spinlock to operate) and then we do the
+ * requeue op. By virtue of the fulock ops, ufulock_op_unqueue() will
+ * update the vfulock if it has to wake up the first waiter in
+ * fast-path mode, and on the way back, if there are waiters left, it
+ * will makr it _WP.
+ *
+ * This is of course only done if the fuqueue is not empty...no need
+ * to mess things more if it is. 
+ *  
+ * USER CONTEXT ONLY
+ */
+asmlinkage
+int sys_ufulock_requeue (volatile unsigned __user *_vfuqueue,
+			 unsigned val,
+			 volatile unsigned __user *_vfulock,
+			 unsigned fulock_flags)
+{
+	int result;
+	struct mm_struct *mm = current->mm;
+	struct page *page_vfulock, *page_vfuqueue;
+	union vl_key key_vfulock, key_vfuqueue;
+	struct vlocator *vl_vfulock, *vl_vfuqueue;
+	struct ufulock *ufulock;
+	struct ufuqueue *ufuqueue;
+	volatile unsigned *vfulock;
+	unsigned value_vfuqueue;
+	
+	ftrace ("(%p, %u, %p, 0x%x)\n",
+		_vfuqueue, val, _vfulock, fulock_flags);
+
+	down_read (&mm->mmap_sem);
+
+	/* Generate a key for the _vfulock, find the ufulock for it */
+	result = vl_key_create (&page_vfulock, &key_vfulock, current,
+				(unsigned long) _vfulock);
+	if (unlikely (result < 0))
+		goto error_vfulock_key_create;
+	result = vl_find_or_create (&vl_vfulock, &key_vfulock,
+				    &ufulock_vl_ops, fulock_flags);
+	if (unlikely (result < 0))
+		goto error_vfulock_find;
+	ufulock = container_of (vl_vfulock, struct ufulock, vlocator);
+
+	/* Generate a key for the _vfuqueue, find the ufuqueue for it */
+	result = vl_key_create (&page_vfuqueue, &key_vfuqueue, current,
+				(unsigned long) _vfuqueue);
+	if (unlikely (result < 0))
+		goto error_vfuqueue_key_create;
+	result = vl_find (&vl_vfuqueue, &key_vfuqueue, &ufuqueue_vl_ops);
+	if (unlikely (result < 0))
+		goto error_vfuqueue_find;
+	ufuqueue = container_of (vl_vfuqueue, struct ufuqueue, vlocator);
+
+	/* Map the vfulock area and sync the ufulock */
+	spin_lock_irq (&ufulock->fulock.fuqueue.lock);
+	_raw_spin_lock (&ufuqueue->fuqueue.lock);
+	if (__fuqueue_empty (&ufuqueue->fuqueue))
+		goto out_spin_unlock;
+	vfulock = vfulock_kmap (page_vfulock, (unsigned long) _vfulock);
+	result = __vfulock_sync (ufulock, vfulock, VFULOCK_WP);
+	if (unlikely (result < 0))
+		goto error_vfulock_sync;
+	/* The page is pinned in memory, so we can get_user() without
+	 * atomicity issues--as well, we are sure it is mapped, so no
+	 * errors should happen. */
+	if (get_user (value_vfuqueue, _vfuqueue))
+		BUG();
+	result = -EAGAIN;
+	if (value_vfuqueue == val) {
+		result = 0;
+		__fulock_requeue (&ufuqueue->fuqueue, &ufulock->fulock,
+				  (void *) vfulock);
+	}
+error_vfulock_sync:
+	vfulock_kunmap (vfulock);
+out_spin_unlock:
+	_raw_spin_unlock (&ufuqueue->fuqueue.lock);
+	spin_unlock_irq (&ufulock->fulock.fuqueue.lock);
+	vl_put (vl_vfuqueue);
+error_vfuqueue_find:
+	vl_key_put (&key_vfuqueue);
+	vl_page_put (page_vfuqueue);
+error_vfuqueue_key_create:
+	vl_put (vl_vfulock);
+error_vfulock_find:
+	vl_key_put (&key_vfulock);
+	vl_page_put (page_vfulock);
+error_vfulock_key_create:
+	up_read (&mm->mmap_sem);
+	return result;
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
+	int result;
+	struct mm_struct *mm = current->mm;
+	struct page *page;
+	union vl_key key;
+	struct vlocator *vl;
+	struct ufulock *ufulock;
+	struct fulock *fulock;
+	unsigned new_value;
+	volatile unsigned *vfulock;
+	
+	ftrace ("(%p, 0x%x, %u)\n", _vfulock, flags, ctl);
+	might_sleep();
+
+	/* Generate a key for the _vfulock, find the ufulock for it */
+	down_read (&mm->mmap_sem);
+	result = vl_key_create (&page, &key, current,
+				(unsigned long) _vfulock);
+	if (unlikely (result < 0))
+		goto error_key_create;
+	result = vl_find_or_create (&vl, &key, &ufulock_vl_ops, flags);
+	if (unlikely (result < 0))
+		goto error_find_or_create;
+	ufulock = container_of (vl, struct ufulock, vlocator);
+	fulock = &ufulock->fulock;
+
+	/* make sure flags are consistent */
+	spin_lock_irq (&fulock->fuqueue.lock);
+	result = -EINVAL;
+	if (flags != (fulock->flags & FULOCK_FL_USER_MK))
+		goto error_unlock;
+	
+	/* Map the user space area and sync */
+	vfulock = vfulock_kmap (page, (unsigned long) _vfulock);
+	result = __vfulock_sync (ufulock, vfulock, VFULOCK_UNLOCKED);
+	if (result < 0)
+		goto error_unlock;
+	
+	/* Ugly special case numero uno: destruction; can't really
+	 * destroy it (somebody might be using it still), but we can
+	 * disconnect it from the hash until the gc destroys it. */
+	if (ctl == FULOCK_CTL_RELEASE) {
+		vl_dispose (vl);
+		result = __fulock_ctl (&ufulock->fulock, ctl,
+				       (void *) vfulock);
+		vfulock_set (vfulock, VFULOCK_UNLOCKED);
+		goto out_kunmap;
+	}	
+	/* Ugly special case numero two: do we have waiters? */
+	if (ctl == FULOCK_CTL_WAITERS) {
+		result = __fulock_empty (fulock)? 0 : 1;
+		goto out_kunmap;
+	}
+	/* Ugly special case number three: is it locked? */
+	if (ctl == FULOCK_CTL_LOCKED) {
+		result = fulock->owner == NULL? 0 : 1;
+		goto out_kunmap;
+	}
+	
+	/* Ok, the command can go down to the fulock layer */
+	result = __fulock_ctl (fulock, ctl, (void *) vfulock);
+	if (result < 0)
+		goto out_kunmap;
+	/* Ok, update the vfulock if so is needed */
+	switch (ctl) {
+	case FULOCK_CTL_HEAL:
+		if (!VFULOCK_FAST || (fulock->flags & __FULOCK_FL_KCO))
+			new_value = VFULOCK_HEALTHY;
+		else if (__fulock_empty (fulock)) {
+			struct task_struct *owner = fulock->owner;
+			new_value = current->pid;
+			fulock->flags |= FULOCK_FL_NEEDS_SYNC;
+			_raw_spin_lock (&owner->fulock_olist_lock);
+			__ufulock_op_owner_reset (fulock);
+			_raw_spin_unlock (&owner->fulock_olist_lock);
+		}
+		else
+			new_value = VFULOCK_WP;
+		vfulock_set (vfulock, new_value);
+		break;
+	case FULOCK_CTL_NR:
+		new_value = VFULOCK_NR;
+		vfulock_set (vfulock, new_value);
+		break;		      
+	default:
+		new_value = 0; /* shut gcc up */
+		result = -ENOSYS;
+	}
+out_kunmap:
+	vfulock_kunmap (vfulock);
+error_unlock:
+	spin_unlock_irq (&fulock->fuqueue.lock);
+	vl_put (vl);
+error_find_or_create:
+	vl_key_put (&key);
+	vl_page_put (page);
+error_key_create:
+	up_read (&mm->mmap_sem);
+	return result;	      
+}
+
+
+/**
+ * Release as dead @ufulock because the owner is exiting.
+ *
+ * This will basically mark the ufulock dead, then set the vfulock to
+ * VFULOCK_DEAD and finally do the proper exit operation. 
+ */
+void ufulock_op_exit (struct fulock *fulock)
+{
+	int result, retry_count = 5;
+	struct ufulock *ufulock;
+	unsigned long flags;
+	union vl_key key;
+	struct page *page = NULL;
+	char *page_kmap;
+	volatile unsigned *vfulock;
+	
+	ftrace ("(%p)\n", fulock);
+
+	/* Fast path: the ufulock is dead already */
+	ufulock = container_of (fulock, struct ufulock, fulock);
+	spin_lock_irqsave (&fulock->fuqueue.lock, flags);
+	__fulock_kill_message (fulock);
+	memcpy (&key, &ufulock->vlocator.key, sizeof (key));
+	vl_key_get (&key);
+	spin_unlock_irqrestore (&fulock->fuqueue.lock, flags);
+retry:
+	result = vl_key_page_get (&page, &key);
+	if (result < 0)
+		goto handle_error;
+
+	spin_lock_irqsave (&fulock->fuqueue.lock, flags);
+	if (fulock->owner != current) /* Okay, somebody did it... */
+		goto out_unlock;
+	fulock->flags |= FULOCK_FL_DEAD;
+	page_kmap = kmap_atomic (page, KM_IRQ0);
+	vfulock = (volatile unsigned *) (page_kmap + (key.both.offset & ~1));
+	__fulock_unlock (fulock, FULOCK_UNLOCK_SERIAL, (void *) vfulock);
+	vfulock_set (vfulock, VFULOCK_DEAD);
+	kunmap_atomic (page_kmap, KM_IRQ0);
+out_unlock:
+	spin_unlock_irqrestore (&fulock->fuqueue.lock, flags);
+	vl_key_page_put (page, &key);
+	vl_key_put (&key);	
+	return;
+
+	/* On memory shortage, we retry a few times, then give up. */
+handle_error:
+	switch (result) {
+	case -EFAULT:
+		printk (KERN_WARNING
+			"Task %d [%s] seems to have removed the memory "
+			"mapping that contained the mutex it owns at 0x%lx; "
+			"this is an application bug. Expect data corruption "
+			"(got error %d)\n", current->pid, current->comm,
+			key.private.uaddr, result);
+		break;
+	case -ENOMEM:
+		shrink_all_memory (4);
+		if (retry_count--)
+			goto retry;
+		/* Fall through */
+	default:
+		printk (KERN_WARNING
+			"Task %d [%s]: error %d while trying to mark fulock "
+			"%p as dead in user space. Expect data corruption.\n",
+			current->pid, current->comm, result, fulock);
+		break;
+	}
+	fulock_ctl (fulock, FULOCK_CTL_NR);
+	vl_key_put (&key);	
+	return;
+}
+
+
+/**
+ * Cancel @task's wait on the ufulock
+ *
+ * We don't re-enable fast-lock. We are under a spinlock and it'd be a
+ * pain--the low ocurrence rate of this case is probably not enough to
+ * justify the bloat that it would incur.
+ */
+unsigned __ufulock_op_waiter_cancel (struct fuqueue *fuqueue,
+				     struct fuqueue_waiter *w)
+{
+	unsigned prio_changed;
+	ftrace ("(%p, %p [%d], %p)\n", fuqueue, w, w->task->pid, w);
+	prio_changed = __fulock_op_waiter_cancel (fuqueue, w);
+	return prio_changed;
+}
+
+
+/* Adaptors for fulock operations */
+static
+void ufulock_op_put (struct fuqueue *fuqueue) 
+{
+	struct fulock *fulock =
+		container_of (fuqueue, struct fulock, fuqueue);
+	struct ufulock *ufulock =
+		container_of (fulock, struct ufulock, fulock);
+	vl_put (&ufulock->vlocator);
+}
+
+
+static
+void ufulock_op_get (struct fuqueue *fuqueue) 
+{
+	struct fulock *fulock =
+		container_of (fuqueue, struct fulock, fuqueue);
+	struct ufulock *ufulock =
+		container_of (fulock, struct ufulock, fulock);
+	vl_get (&ufulock->vlocator);
+}
+
+
+/** ufulock fulock operations */
+struct fulock_ops ufulock_ops = {
+	.fuqueue = {
+		.get = ufulock_op_get,
+		.put = ufulock_op_put,
+		.waiter_cancel = __ufulock_op_waiter_cancel,
+		.waiter_chprio = __fulock_op_waiter_chprio
+	},
+	.owner_set = __ufulock_op_owner_set,
+	.owner_reset = __ufulock_op_owner_reset,
+	.unlock_type = ufulock_op_unlock_type,
+	.unqueue = ufulock_op_unqueue,
+	.exit = ufulock_op_exit,
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
+		panic ("subsys_ufulock_init(): "
+		       "Unable to initialize ufulock slab allocator.\n");
+	return 0;
+}
+__initcall (subsys_ufulock_init);
