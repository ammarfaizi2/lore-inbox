Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267816AbUGWPwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267816AbUGWPwG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 11:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267803AbUGWPvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 11:51:25 -0400
Received: from fmr05.intel.com ([134.134.136.6]:60805 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S267805AbUGWPk5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 11:40:57 -0400
Date: Fri, 23 Jul 2004 08:49:16 -0700
From: inaky.perez-gonzalez@intel.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com, robustmutexes@lists.osdl.org
Subject: [RFC/PATCH] FUSYN 6/11: user space fuqueues
Message-ID: <0407230849.SaccZdndSbec8cacybeaqcNaMaUdkcCd17066@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0407230849.Ld0ccdydMbAcddja.c2b5d5djcjbQanb17066@intel.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Support for exporting fuqueues to user space: ufuqueues. Each
is represented by a user space memory word, a vfuqueue.


 ufuqueue.c |  311 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 311 insertions(+)

--- /dev/null	Thu Jul 22 14:30:56 2004
+++ kernel/ufuqueue.c Sat Jul 17 20:32:40 2004
@@ -0,0 +1,311 @@
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
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/highmem.h>   /* kmap_atomic() */
+#include <linux/vlocator.h>
+#include <linux/fuqueue.h>
+#include <asm/uaccess.h>
+
+static struct fuqueue_ops ufuqueue_ops;
+
+/** Slab for allocation of 'struct ufuqueue's. */
+static kmem_cache_t *ufuqueue_slab;
+
+
+/** Initialize an @ufuqueue (for slab object construction). */
+static inline
+void ufuqueue_ctor (void *obj, kmem_cache_t *slab, unsigned long flags)
+{
+	struct ufuqueue *ufuqueue = obj;
+	__fuqueue_init (&ufuqueue->fuqueue, &ufuqueue_ops);
+	vlocator_init (&ufuqueue->vlocator);
+}
+
+
+/** Allocate an ufuqueue maintaining debug-allocation counts. */
+static inline
+struct vlocator * ufuqueue_vl_op_alloc (void)
+{
+	struct ufuqueue *ufuqueue;
+	ufuqueue = kmem_cache_alloc (ufuqueue_slab, GFP_KERNEL);
+	if (DEBUG > 0 && ufuqueue != NULL)
+		ldebug (1, "ufuqueue %p allocated, total: %d\n",
+			ufuqueue, allocated_inc());
+	return &ufuqueue->vlocator;
+}
+
+
+/**
+ * Create a ufuqueue that is going to be inserted to the hash
+ * [called from vlocator.c:vl_locate() throught the vlocator ops]
+ */
+static
+int ufuqueue_vl_op_create (struct vlocator *vl, const union vl_key *key,
+			   unsigned long priv)
+{
+	memcpy (&vl->key, key, sizeof (*key));
+	return 0;
+}
+
+
+/** Free an ufuqueue maintaining debug-allocation counts. */
+static inline
+void ufuqueue_vl_op_free (struct vlocator *vl)
+{
+	struct ufuqueue *ufuqueue =
+		container_of (vl, struct ufuqueue, vlocator);
+	kmem_cache_free (ufuqueue_slab, ufuqueue);
+	if (DEBUG > 0 && ufuqueue != NULL)
+		ldebug (1, "ufuqueue %p freed, total: %d\n",
+			ufuqueue, allocated_dec());
+}
+
+
+struct vlocator_ops ufuqueue_vl_ops = {
+	.alloc = ufuqueue_vl_op_alloc,
+	.create = ufuqueue_vl_op_create,
+	.release = NULL,
+	.free = ufuqueue_vl_op_free
+};
+
+
+/**
+ * Wait on a fuqueue
+ *
+ * @_vfuqueue: address in user space
+ * @val: value of the _vfuqueue before we entered the kernel
+ * @_timeout: timeout information. ~0 means block for ever.
+ * 
+ * @returns: 0 if ok, < 0 errno code on error. If it returns
+ *           FUQUEUE_WAITER_GOT_LOCK (defined in linux/fuqueue.h) or
+ *           -EOWNERDEAD it means this fuqueue was requeued to a
+ *           fulock and when woken up, it has been assigned ownership
+ *           of the fulock.
+ *
+ * This is just a thin shell that locates the kernel descriptors for
+ * the fuqueue, places the timeout info in place, queues and blocks.
+ */
+asmlinkage
+int sys_ufuqueue_wait (volatile unsigned __user *_vfuqueue, unsigned val,
+		       const struct timeout __user *_timeout)
+{
+	int result = -EINVAL;
+	struct ufuqueue *ufuqueue;
+	struct page *page;
+	unsigned new_val;
+	struct vlocator *vl;
+	union vl_key key;
+	struct timeout *timeout, timeout_kernel;
+	struct fuqueue_waiter w = fuqueue_waiter_INIT (current);
+	struct mm_struct *mm = current->mm;
+	
+		
+	ftrace ("(%p, %x, %p)\n", _vfuqueue, val, _timeout);
+	might_sleep();
+
+	/* We are going to block on the ufuqueue, so get the timeout first */
+	if ((struct timeout *) _timeout == MAX_SCHEDULE_TIMEOUT_EXT)
+		timeout = MAX_SCHEDULE_TIMEOUT_EXT;
+	else {
+		result = -EFAULT;
+		timeout = &timeout_kernel;
+		if (copy_from_user (timeout, _timeout, sizeof (*timeout)))
+			goto error_copy;
+	}
+
+	/* Generate a key for the _vfuqueue, find the ufuqueue for it */
+	down_read (&mm->mmap_sem);
+	result = vl_key_create (&page, &key, current, (unsigned long) _vfuqueue);
+	if (unlikely (result < 0))
+		goto error_key_create;
+	result = vl_find_or_create (&vl, &key, &ufuqueue_vl_ops, 0);
+	if (unlikely (result < 0))
+		goto error_find_or_create;
+	ufuqueue = container_of (vl, struct ufuqueue, vlocator);
+
+	/* Queue and check the value hasn't changed */
+	w.flags = FUQUEUE_WT_FL_QUEUE;
+	spin_lock_irq (&ufuqueue->fuqueue.lock);
+	__fuqueue_waiter_queue (&ufuqueue->fuqueue, &w);
+	/* The page is pinned in memory, so we can get_user() without
+	 * atomicity issues--as well, we are sure it is mapped, so no
+	 * errors should happen.
+	 * Now, are we ok with the value? */
+	if (get_user (new_val, _vfuqueue))
+		BUG();
+	if (val != new_val)
+		goto error_wouldblock;
+	vl_page_put (page);
+	up_read (&mm->mmap_sem);
+	/* ok, go ahead and wait (it will unlock and restore irqs/preempt) */
+	result = __fuqueue_waiter_block (&ufuqueue->fuqueue, &w, timeout);
+	vl_put (vl);
+	vl_key_put (&key);
+	return result;
+	
+error_wouldblock:
+	result = -EWOULDBLOCK;
+	__fuqueue_waiter_unqueue (&w);
+	spin_unlock_irq (&ufuqueue->fuqueue.lock);
+	vl_put (vl);
+error_find_or_create:
+	vl_key_put (&key);
+	vl_page_put (page);
+error_key_create:
+	up_read (&mm->mmap_sem);
+error_copy:
+	return result;
+}
+
+	
+/**
+ * Wake up waiters of a fuqueue
+ *
+ * @_vfuqueue: pointer to the fuqueue
+ * @howmany: number of waiters to wake up
+ * @code: code to return to the waiters [default it to zero]
+ * @returns: 0 if ok, < 0 errno code on error.
+ */
+asmlinkage
+int sys_ufuqueue_wake (volatile unsigned __user *_vfuqueue,
+		       size_t howmany, int code)
+{
+	int result;
+	struct mm_struct *mm = current->mm;
+	struct page *page;
+	union vl_key key;
+	struct vlocator *vl;
+	struct ufuqueue *ufuqueue;
+	
+	ftrace ("(%p, %u)\n", _vfuqueue, howmany);
+	might_sleep();
+	
+	/* Generate a key for the _vfuqueue, find the ufuqueue for it */
+	down_read (&mm->mmap_sem);
+	result = vl_key_create (&page, &key, current, (unsigned long) _vfuqueue);
+	if (unlikely (result < 0))
+		goto error_key_create;
+	result = vl_find (&vl, &key, &ufuqueue_vl_ops);
+	if (unlikely (result < 0))
+		goto error_find;
+	ufuqueue = container_of (vl, struct ufuqueue, vlocator);
+	/* Wake'em up */
+	spin_lock_irq (&ufuqueue->fuqueue.lock);
+	__fuqueue_wake (&ufuqueue->fuqueue, howmany, code);
+	spin_unlock_irq (&ufuqueue->fuqueue.lock);
+	result = 0;
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
+ * Control operations on a fuqueue
+ *
+ * @_vfuqueue: pointer to the fuqueue
+ * @ctl: control operation on the fuqueue
+ * @returns: 0 if ok, < 0 errno code on error.
+ */
+asmlinkage
+int sys_ufuqueue_ctl (volatile unsigned __user *_vfuqueue, enum fuqueue_ctl ctl)
+{
+	int result;
+	struct mm_struct *mm = current->mm;
+	struct page *page;
+	union vl_key key;
+	struct vlocator *vl;
+	struct ufuqueue *ufuqueue;
+	
+	ftrace ("(%p, %d)\n", _vfuqueue, ctl);
+	might_sleep();
+	
+	/* Generate a key for the _vfuqueue, find the ufuqueue for it */
+	down_read (&mm->mmap_sem);
+	result = vl_key_create (&page, &key, current, (unsigned long) _vfuqueue);
+	if (unlikely (result < 0))
+		goto error_key_create;
+	result = vl_find (&vl, &key, &ufuqueue_vl_ops);
+	if (unlikely (result < 0))
+		goto error_find;
+	ufuqueue = container_of (vl, struct ufuqueue, vlocator);
+	/* Check it up */
+	spin_lock_irq (&ufuqueue->fuqueue.lock);
+	switch (ctl) {
+	case FUQUEUE_CTL_RELEASE:
+		vl_dispose (vl);
+		__fuqueue_wake (&ufuqueue->fuqueue, ~0, -ENOENT);
+		result = 0;
+		break;
+	case FUQUEUE_CTL_WAITERS:
+		result = __fuqueue_empty (&ufuqueue->fuqueue)? 0 : 1;
+		break;
+	default:
+		result = -EINVAL;
+		break;
+	}
+	spin_unlock_irq (&ufuqueue->fuqueue.lock);
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
+/** Initialize the ufuqueue subsystem. */
+static
+int __init subsys_ufuqueue_init (void)
+{
+	ufuqueue_slab = kmem_cache_create ("ufuqueue", sizeof (struct ufuqueue),
+					  0, 0, ufuqueue_ctor, NULL);
+	if (ufuqueue_slab == NULL) 
+		panic ("subsys_ufuqueue_init(): "
+		       "Unable to initialize ufuqueue slab allocator.\n");
+	return 0;
+}
+__initcall (subsys_ufuqueue_init);
+
+
+/* Adaptors for fulock operations */
+static
+void ufuqueue_op_put (struct fuqueue *fuqueue) 
+{
+	struct ufuqueue *ufuqueue =
+		container_of (fuqueue, struct ufuqueue, fuqueue);
+	vl_put (&ufuqueue->vlocator);
+}
+
+static
+void ufuqueue_op_get (struct fuqueue *fuqueue) 
+{
+	struct ufuqueue *ufuqueue =
+		container_of (fuqueue, struct ufuqueue, fuqueue);
+	vl_get (&ufuqueue->vlocator);
+}
+
+/** Ufuqueue operations */
+static
+struct fuqueue_ops ufuqueue_ops = {
+	.get = ufuqueue_op_get,
+	.put = ufuqueue_op_put,
+	.waiter_cancel = __fuqueue_op_waiter_cancel,
+	.waiter_chprio = __fuqueue_op_waiter_chprio
+};
