Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264707AbUDUEMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264707AbUDUEMJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 00:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264730AbUDUEJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 00:09:40 -0400
Received: from ip-66-80-228-130.sjc.megapath.net ([66.80.228.130]:34035 "EHLO
	sodium.co.intel.com") by vger.kernel.org with ESMTP id S264708AbUDUD6w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 23:58:52 -0400
Date: Tue, 20 Apr 2004 21:04:11 -0700
From: inaky.perez-gonzalez@intel.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com
Subject: [RFC/PATCH] FUSYN 9/11: user space fuqueues
Message-ID: <0404202104.qb0acdJdRc1dgc9bMdqbzbBcccWaqa0d1457@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0404202104.1arcNbIbybGa4btcncUaFczcydib1coa1457@intel.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 ufuqueue.c |  236 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 236 insertions(+)

--- /dev/null	Thu Apr 15 00:58:26 2004
+++ kernel/ufuqueue.c Mon Feb 2 11:30:47 2004
@@ -0,0 +1,236 @@
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
+
+extern signed long ufu_timespec2jiffies (const struct timespec __user *);
+static struct fuqueue_ops ufuqueue_ops;
+
+/** Slab for allocation of 'struct ufuqueue's. */
+static kmem_cache_t *ufuqueue_slab; 
+
+/** A ufuqueue, tied to a user-space vm address. */
+struct ufuqueue {
+	struct fuqueue fuqueue;
+	struct vlocator vlocator;
+};
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
+static __inline__
+struct vlocator * ufuqueue_alloc (void)
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
+void ufuqueue_create (struct vlocator *vl, struct page *page,
+		      const union futex_key *key, unsigned flags)
+{
+	memcpy (&vl->key, key, sizeof (*key));
+	get_key_refs (&vl->key);
+}
+
+
+/** Free an ufuqueue maintaining debug-allocation counts. */
+static __inline__
+void ufuqueue_release (struct vlocator *vl)
+{
+	drop_key_refs (&vl->key);
+}
+
+
+/** Free an ufuqueue maintaining debug-allocation counts. */
+static __inline__
+void ufuqueue_free (struct vlocator *vl)
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
+struct vlocator_ops ufuqueue_vops = {
+	.alloc = ufuqueue_alloc,
+	.create = ufuqueue_create,
+	.release = ufuqueue_release,
+	.free = ufuqueue_free
+};
+
+
+/**
+ * Wait on a fuqueue
+ *
+ * @_vfuqueue: address in user space of the condvar
+ * @cond_flags: flags for the conditional variable
+ * @_vfulock: address in user space of the fulock.
+ * @lock_flags: flags for the fulock.
+ * @_timeout: timeout information [see sys_ufulock_lock()]
+ *
+ * This is just a thin shell that locates the kernel descriptors for
+ * the condvar and the lock and then handles the work to
+ * ufuqueue_wait().
+ */
+asmlinkage
+int sys_ufuqueue_wait (volatile unsigned __user *_vfuqueue,
+		       unsigned val, struct timespec __user *_timeout)
+{
+	int result = -EINVAL;
+	struct ufuqueue *ufuqueue;
+	struct page *page;
+	char *page_kmap;
+	volatile unsigned *vfuqueue;
+	unsigned new_val;
+	struct vlocator *vl;
+	signed long timeout;
+        struct fuqueue_waiter w;
+		
+	ftrace ("(%p, %x, %p)\n", _vfuqueue, val, _timeout);
+	might_sleep();
+
+	/* ufuqueue: pin pages, get keys, look up/allocate, refcount */
+	result = vl_locate (&page, &vl, &ufuqueue_vops, _vfuqueue, 0);
+	if (unlikely (result < 0))
+		goto out;
+	ufuqueue = container_of (vl, struct ufuqueue, vlocator);
+	/* We are going to lock the ufuqueue, so get the timeout first */
+	timeout = ufu_timespec2jiffies (_timeout);
+	result = (int) timeout;
+	if (timeout < 0)
+		goto out_put_vl;
+	
+	spin_lock_irq (&ufuqueue->fuqueue.lock);
+	__fuqueue_waiter_queue (&ufuqueue->fuqueue, &w);
+	/* Now, are we ok with the value? */
+	page_kmap = kmap_atomic (page, KM_IRQ0);
+	vfuqueue = (volatile unsigned *)page_kmap + (vl->key.both.offset & ~1);
+	new_val = *vfuqueue;
+	kunmap_atomic (page_kmap, KM_IRQ0);
+	result = -EWOULDBLOCK;
+	if (val != new_val)
+		goto out_unqueue;
+	/* ok, go ahead and wait (it will unlock and restore irqs/preempt */
+	return __fuqueue_waiter_block (&ufuqueue->fuqueue, &w, timeout);
+
+out_unqueue:
+	__fuqueue_waiter_unqueue (&w, 0);
+	spin_unlock_irq (&ufuqueue->fuqueue.lock);
+out_put_vl:
+	vl_put (vl);
+	put_page (page);
+out:
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
+	struct vlocator *vl;
+	struct ufuqueue *ufuqueue;
+	
+	ftrace ("(%p, %u)\n", _vfuqueue, howmany);
+	might_sleep();
+	
+	/* ufuqueue: get keys, look up (don't allocate), refcount */
+	result = vl_locate (NULL, &vl, NULL, _vfuqueue, 0);
+	if (result < 0)
+		goto out;
+	ufuqueue = container_of (vl, struct ufuqueue, vlocator);
+	/* Wake'en up */
+	spin_lock_irq (&ufuqueue->fuqueue.lock);
+	__fuqueue_wake (&ufuqueue->fuqueue, howmany, code);
+	spin_unlock_irq (&ufuqueue->fuqueue.lock);
+	vl_put (vl);
+	result = 0;
+out:
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
+		panic ("ufuqueue_init(): "
+		       "Unable to initialize ufuqueue slab allocator.\n");
+	return 0;
+}
+__initcall (subsys_ufuqueue_init);
+
+
+/* Adaptors for fulock operations */
+static
+void ufuqueue_put (struct fuqueue *fuqueue) 
+{
+	struct ufuqueue *ufuqueue =
+		container_of (fuqueue, struct ufuqueue, fuqueue);
+	vl_put (&ufuqueue->vlocator);
+}
+
+static
+void ufuqueue_get (struct fuqueue *fuqueue) 
+{
+	struct ufuqueue *ufuqueue =
+		container_of (fuqueue, struct ufuqueue, fuqueue);
+	vl_get (&ufuqueue->vlocator);
+}
+
+/** Ufuqueue operations */
+static
+struct fuqueue_ops ufuqueue_ops = {
+	.get = ufuqueue_get,
+	.put = ufuqueue_put,
+	.waiter_cancel = __fuqueue_op_waiter_cancel,
+	.waiter_chprio = __fuqueue_op_waiter_chprio
+};
+
