Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264746AbUDUEI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264746AbUDUEI4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 00:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264756AbUDUEIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 00:08:36 -0400
Received: from ip-66-80-228-130.sjc.megapath.net ([66.80.228.130]:31475 "EHLO
	sodium.co.intel.com") by vger.kernel.org with ESMTP id S264707AbUDUD6r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 23:58:47 -0400
Date: Tue, 20 Apr 2004 21:04:06 -0700
From: inaky.perez-gonzalez@intel.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com
Subject: [RFC/PATCH] FUSYN 8/11: user space/kernel space tracker
Message-ID: <0404202104.1arcNbIbybGa4btcncUaFczcydib1coa1457@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0404202104.nd0drbFdjbkb.a4a~ctckaAb9aZd9b8a1457@intel.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 include/linux/vlocator.h |  128 ++++++++++++
 kernel/vlocator.c        |  465 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 593 insertions(+)

--- /dev/null	Thu Apr 15 00:58:25 2004
+++ include/linux/vlocator.h Mon Jan 5 10:23:13 2004
@@ -0,0 +1,128 @@
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
+ * Stuff to map user space addresses to kernel space objects in a
+ * controlled way. 
+ */
+
+#ifndef __linux_vlocator_h__
+#define __linux_vlocator_h__
+
+#ifdef __KERNEL__
+
+#include <linux/list.h>
+#include <linux/hash.h>
+#include <asm/atomic.h>
+#include <linux/futex.h> /* for the futex hash */
+
+
+/** Track @what by a user level vm address. */
+struct vlocator {
+	atomic_t refcount;
+	struct list_head hash_list;
+	union futex_key key;
+	const struct vlocator_ops *ops;
+};
+
+static __inline__
+void vlocator_init (struct vlocator *vlocator)
+{
+	atomic_set (&vlocator->refcount, 0);
+	INIT_LIST_HEAD (&vlocator->hash_list);
+}
+
+
+/** A single queue in the hash. */
+struct vlocator_queue
+{
+	spinlock_t lock;
+	struct list_head queue;
+	unsigned additions;
+};
+
+static __inline__
+void vlocator_queue_init (struct vlocator_queue *vlq)
+{
+	vlq->lock = SPIN_LOCK_UNLOCKED;
+	INIT_LIST_HEAD (&vlq->queue);
+	vlq->additions = 0;
+}
+
+struct page;
+union futex_key;
+
+/** vlocator operations on the items that are to be located. */
+struct vlocator_ops
+{
+	struct vlocator * (* alloc) (void);
+	void (* create) (struct vlocator *, struct page *,
+			 const union futex_key *, unsigned flags);
+	void (* release) (struct vlocator *);
+	void (* free) (struct vlocator *);
+};
+
+
+/** Reference an vlocator @vlocator. */
+#define vl_get(vlocator)			  \
+do { atomic_inc (&(vlocator)->refcount); } while (0)
+
+
+/** Unreference an @vlocator; return true if it drops to zero. */
+static inline
+unsigned vl_put (struct vlocator *vlocator)
+{
+	return atomic_dec_and_test (&vlocator->refcount);
+}
+
+extern int vl_find (struct page **ppage, struct vlocator **pvl,
+		    const struct vlocator_ops *ops,
+		    volatile const unsigned __user *uaddr);
+extern int vl_locate (struct page **ppage, struct vlocator **pvl,
+		      const struct vlocator_ops *ops,
+		      volatile const unsigned __user *uaddr, unsigned flags);
+extern int vl_dispose (const struct vlocator_ops *,
+		       volatile const unsigned __user *);
+
+/* Debug stuff */
+
+/*
+ * Helpers for debugging memory allocation [needs to be here so it can
+ * be shared by ufuqueue.c and ufulock.c].
+ */
+
+#if DEBUG >= 1
+static atomic_t allocated_count = ATOMIC_INIT(0);
+static inline
+int allocated_get (void)
+{
+	return atomic_read (&allocated_count);
+}
+static inline
+int allocated_inc (void)
+{
+	atomic_inc (&allocated_count);
+	return allocated_get();
+}
+static inline
+int allocated_dec (void)
+{
+	atomic_dec (&allocated_count);
+	return allocated_get();
+}
+#else
+static inline int allocated_get (void) { return 0; }
+static inline int allocated_inc (void) { return 0; }
+static inline int allocated_dec (void) { return 0; }
+#endif /* DEBUG > 1 */
+
+
+#endif /* #ifdef __KERNEL__ */
+#endif /* #ifndef __linux_vlocator_h__ */
--- /dev/null	Thu Apr 15 00:58:26 2004
+++ kernel/vlocator.c Tue Mar 23 23:03:32 2004
@@ -0,0 +1,465 @@
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
+#include <linux/time.h>
+#include <linux/sched.h>
+#include <linux/futex.h>
+#include <asm/uaccess.h>
+#include <linux/init.h>
+#include <linux/pagemap.h>
+#include <linux/fuqueue.h>  /* For the debug statements */
+#include <linux/vlocator.h>
+
+#define VL_GC_PERIOD 20 /* do garbage collection every 20 seconds */
+#define VL_HASH_BITS 8
+#define VL_HASH_QUEUES (1 << VL_HASH_BITS)
+static struct vlocator_queue __vl_hash[VL_HASH_QUEUES];
+static struct list_head __vl_disposal = LIST_HEAD_INIT (__vl_disposal); 
+static spinlock_t __vl_disposal_lock = SPIN_LOCK_UNLOCKED;
+
+/** Get the hash index for futex_key @k. */
+static __inline__
+struct vlocator_queue * vl_hash (const union futex_key *k)
+{
+	unsigned index = futex_hash_key (k) & (VL_HASH_QUEUES - 1);
+	return &__vl_hash[index];
+}
+
+
+/** Search in a queue. */
+static __inline__
+struct vlocator * __vlocator_find (struct vlocator_queue *vlq,
+				   const union futex_key *key)
+{
+	struct vlocator *vl = NULL;
+	struct list_head *itr;
+
+	list_for_each (itr, &vlq->queue) {
+		vl = container_of (itr, struct vlocator, hash_list);
+		if (match_futex_key (key, &vl->key))
+			goto out;
+	}
+	vl = NULL;
+out:
+	return vl;
+}
+
+
+/** Search in a queue [backwards - locates faster recent additions]. */
+static inline
+struct vlocator * __vlocator_find_r (struct vlocator_queue *vlq,
+				     const union futex_key *key)
+{
+	struct vlocator *vl = NULL;
+	struct list_head *itr;
+
+	list_for_each_prev (itr, &vlq->queue) {
+		vl = container_of (itr, struct vlocator, hash_list);
+		if (match_futex_key (key, &vl->key))
+			goto out;
+	}
+	vl = NULL;
+out:
+	return vl;
+}
+
+
+/** Remove @vlocator from queue @vlq if its use count is zero (and
+ * return true). */ 
+static __inline__
+unsigned __vlocator_rem (struct vlocator *v)
+{
+	unsigned result = 0, refcount;
+	refcount = atomic_read (&v->refcount);
+	if (refcount == 0) {
+		list_del (&v->hash_list);
+		result = 1;
+	}
+	return result;
+}
+
+
+/** Append @vlocator to queue @vlq. */ 
+static __inline__
+void __vlocator_add (struct vlocator_queue *vlq, struct vlocator *v)
+{
+	vlq->additions++;
+	list_add (&v->hash_list, &vlq->queue);
+}
+
+
+/**
+ * Setup all the memory mumbo jumbo we need to access a user space
+ * item: locate the page where the address is and generate a futex_key
+ * for it. Return both referenced [with pin_page() and get_key_refs()]
+ *
+ * Shamelessly copied from Jamie's kernel/futex.c:get_futex_key()...
+ * good invention this GPL thingie :)  
+ */
+int vl_setup (struct page **ppage, union futex_key *key,
+	      volatile const unsigned __user *_uaddr)
+{
+	int result;
+	struct page *page;
+	unsigned long uaddr = (unsigned long) _uaddr;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	
+	ftrace ("(%p, %p, %p)\n", ppage, key, _uaddr);
+
+	/* The futex address must be "naturally" aligned. */
+	key->both.offset = uaddr % PAGE_SIZE;
+	if (unlikely ((key->both.offset % sizeof (u32)) != 0))
+		return -EINVAL;
+	uaddr -= key->both.offset;
+	
+	/* Generate a key for the vfulock. */
+	down_read (&mm->mmap_sem);
+	/*
+	 * The futex is hashed differently depending on whether
+	 * it's in a shared or private mapping.	 So check vma first.
+	 */
+	vma = find_extend_vma (mm, uaddr);
+	result = -EFAULT;
+	if (unlikely (!vma))
+		goto error_up;
+	/* Permissions. */
+	result = (vma->vm_flags & VM_IO) ? -EPERM : -EACCES;
+	if (unlikely ((vma->vm_flags & (VM_IO|VM_READ)) != VM_READ))
+		goto error_up;
+	/*
+	 * Private mappings are handled in a simple way.
+	 *
+	 * NOTE: When userspace waits on a MAP_SHARED mapping, even if
+	 * it's a read-only handle, it's expected that futexes attach to
+	 * the object not the particular process.  Therefore we use
+	 * VM_MAYSHARE here, not VM_SHARED which is restricted to shared
+	 * mappings of _writable_ handles.
+	 */
+	result = 0;
+	if (likely (!(vma->vm_flags & VM_MAYSHARE))) {
+		key->private.mm = mm;
+		key->private.uaddr = uaddr;
+		goto out_pin;
+	}
+	/* Linear file mappings are also simple. */
+	key->shared.inode = vma->vm_file->f_dentry->d_inode;
+	key->both.offset++; /* Bit 0 of offset indicates inode-based key. */
+	if (likely (!(vma->vm_flags & VM_NONLINEAR))) {
+		key->shared.pgoff = (((uaddr - vma->vm_start) >> PAGE_SHIFT)
+				     + vma->vm_pgoff);
+		goto out_pin;
+	}
+
+	/*
+	 * We really need to pin the page in memory, we are about to
+	 * modify it.
+	 */
+
+	/*
+	 * Do a quick atomic lookup first - this is the fastpath.
+	 */
+#warning FIXME: OPTIMIZE:
+	/*
+	 * We only need to take this path when we don't know the page;
+	 * we can hack vl_locate() so that if we know the key without
+	 * checking the page and we find the vlocator, we can take the
+	 * page from there.
+	 */
+out_pin:
+	spin_lock (&mm->page_table_lock);
+	page = follow_page (mm, uaddr, 0);
+	if (likely (page != NULL)) {
+		key->shared.pgoff =
+			page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
+		if (!PageReserved (page))
+			get_page (page);
+		spin_unlock (&mm->page_table_lock);
+		goto out;
+	}
+	spin_unlock (&mm->page_table_lock);
+
+	/*
+	 * Do it the general way.
+	 */
+	result = get_user_pages (current, mm, uaddr, 1, 0, 0, &page, NULL);
+	if (result < 0)
+		goto error_up;
+	key->shared.pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
+out:
+	get_key_refs (key);
+	*ppage = page;
+error_up:
+	up_read (&current->mm->mmap_sem);
+	return result;
+}
+
+
+/**
+ * Locate a vlocator for a certain user address.
+ *
+ * @ppage: Pointer to where to store the pointer to the referenced
+ *         page where @uaddr is. NULL if unneeded.
+ * @pvl:   Pointer to where to store the pointer to the located
+ *         vlocator based structure.
+ * @ops:   Pointer to the function ops for this guy (for checking)
+ * @uaddr: Address in user space.
+ * @returns: < 0 errno code on error (no resources held)
+ *	     0 if ok and:
+ *
+ *	     - Located vlocator in *pvl, referenced
+ *	     - Page pointer in *ppage (unless NULL), referenced
+ *	     - The key in (*pvl)->key has been referenced with get_key_refs()
+ */
+int vl_find (struct page **ppage, struct vlocator **pvl,
+	     const struct vlocator_ops *ops,
+	     volatile const unsigned __user *uaddr)
+{
+	int result;
+	struct vlocator_queue *vlq;
+	struct vlocator *vl;
+	union futex_key key;
+	struct page *page;
+	unsigned need_page = 0;
+	
+	ftrace ("(%p, %p, %p, %p)\n", ppage, pvl, ops, uaddr);
+
+	result = vl_setup (&page, &key, uaddr);
+	if (result < 0)
+		goto error;
+	/* Is it in the hash already? [do we know about it?] */
+	vlq = vl_hash (&key);
+	spin_lock (&vlq->lock);
+	vl = __vlocator_find (vlq, &key);
+	if (likely (vl == NULL))
+		goto out_unlock;
+	/* Check the type is correct */
+	result = -EFAULT;
+	if (unlikely (vl->ops != ops))
+		goto out_unlock;
+	result = 0;
+	vl_get (vl);
+	*pvl = vl;
+	if (ppage) {
+		*ppage = page;
+		need_page = 1;
+	}
+out_unlock:
+	spin_unlock (&vlq->lock);
+	drop_key_refs (&key);	     // Undo from ...
+	if (need_page == 0)
+		put_page (page);   // ... ufu_setup() (maybe)
+error:
+	return result;
+}
+
+
+/**
+ * Locate or allocate a vlocator for a certain user address.
+ *
+ * @ppage: Pointer to where to store the pointer to the referenced
+ *         page where @uaddr is. NULL if unneeded.
+ * @pvl:   Pointer to where to store the pointer to the allocated
+ *         vlocator based structure.
+ * @ops:   Pointer to the function ops used for allocating/constructing, etc.
+ * @uaddr: Address in user space.
+ * @flags: flags, for initialization, passed to ops->create()
+ * @returns: < 0 errno code on error (no resources held)
+ *	     0 if ok and:
+ *
+ *	     - Located or allocated vlocator in *pvl, referenced
+ *	     - Page pointer in *ppage (unless NULL), referenced
+ *	     - The key in (*pvl)->key has been referenced with get_key_refs()
+ *
+ * FIXME: optimize allocation collision detection; add a modification
+ * count to the hash table; whenever anything is added, inc the
+ * count. If we see the count changed after we droped the lock,
+ * allocated and re-locked, then we need to find_r(), if not, we can
+ * assume nothing changed.
+ */
+int vl_locate (struct page **ppage, struct vlocator **pvl,
+	       const struct vlocator_ops *ops,
+	       volatile const unsigned __user *uaddr, unsigned flags)
+{
+	int result;
+	struct vlocator_queue *vlq;
+	struct vlocator *vl, *vl_alt;
+	union futex_key key;
+	struct page *page;
+	unsigned need_page = 0;
+	unsigned additions0;
+	
+	ftrace ("(%p, %p, %p, %p, %x)\n", ppage, pvl, ops, uaddr, flags);
+
+	result = vl_setup (&page, &key, uaddr);
+	if (result < 0)
+		goto error;
+	/* Is it in the hash already? [do we know about it?] */
+	vlq = vl_hash (&key);
+	spin_lock (&vlq->lock);
+	vl = __vlocator_find (vlq, &key);
+	if (likely (vl != NULL))
+		goto out_check;
+	additions0 = vlq->additions;
+	spin_unlock (&vlq->lock);
+
+	/* Naaah, let's alloc it */
+	result = -ENOMEM;
+	vl = ops->alloc();
+	if (unlikely (vl == NULL))
+		goto error_alloc;	 
+	result = 0;
+	
+	/* Ok, allocated - did somebody add it while we were allocating?
+	 * [we try to speed up by checking if anybody has added since
+	 * we dropped the lock--we live up with the chance of 4G
+	 * allocations wrapping up the counter in the middle *grin*]. */
+	spin_lock (&vlq->lock);
+	if (additions0 == vlq->additions
+	    || (vl_alt = __vlocator_find_r (vlq, &key)) == NULL) {
+		ops->create (vl, page, &key, flags);
+		vl->ops = ops;
+		__vlocator_add (vlq, vl);
+		goto out_ref;
+	}
+	/* Allocation collision, get the new one, discard ours */  
+	ops->free (vl);
+	vl = vl_alt;
+out_check:
+	result = -EFAULT;
+	if (unlikely (vl->ops != ops))  /* Check the type is correct */
+		goto out_unlock;
+	result = 0;
+out_ref:
+	vl_get (vl);
+	*pvl = vl;
+	if (ppage) {
+		*ppage = page;
+		need_page = 1;
+	}
+out_unlock:
+	spin_unlock (&vlq->lock);
+error_alloc:
+	drop_key_refs (&key);	     // Undo from ...
+	if (need_page == 0)
+		put_page (page);   // ... ufu_setup() (maybe)
+error:
+	return result;
+}
+
+
+/**
+ * Dispose a vlocator
+ *
+ * When a vlocator is no longer needed, remove it from the hash table
+ * (add it to a delete list so the garbage collector can properly get
+ * rid of it). 
+ */
+int vl_dispose (const struct vlocator_ops *vops,
+		volatile const unsigned __user *uaddr)
+{
+	int result = -ENXIO;
+	struct vlocator_queue *vlq;
+	struct vlocator *vl;
+	struct page *page;
+	union futex_key key;
+	
+	result = vl_setup (&page, &key, uaddr);
+	if (result < 0)
+		goto error;
+	vlq = vl_hash (&key);
+	spin_lock (&vlq->lock);
+	vl = __vlocator_find (vlq, &key);
+	if (vl == NULL)
+		goto out_unlock;
+	/* In the hash, move it out */
+	result = 0;
+	list_del (&vl->hash_list);
+	spin_lock (&__vl_disposal_lock);
+	list_add_tail (&vl->hash_list, &__vl_disposal);
+	spin_unlock (&__vl_disposal_lock);
+out_unlock:
+	spin_unlock (&vlq->lock);
+	put_page (page);
+	drop_key_refs (&key);
+error:
+	return result;
+}
+
+
+/** Work structure for the garbage collector */
+static void vl_garbage_collector (void *);
+DECLARE_WORK(vl_workqueue, vl_garbage_collector, NULL);
+
+
+/**
+ * Do garbage collection (called from the work-queue) and re-arm 
+ *
+ * The most important action is to cleanup the ownership of [u]fulocks
+ * that were assigned to init because the owner died and robustness
+ * was not enabled. This means that only ufulocks get to optionally
+ * suport robustness; kernel based fulocks have to do robustness
+ * always. 
+ */
+
+static inline
+void __vl_garbage_collect (struct list_head *list)
+{
+	struct list_head *itr, *nxt;
+	struct vlocator *vl;
+	list_for_each_safe (itr, nxt, list) {
+		vl = container_of (itr, struct vlocator, hash_list);
+		if (__vlocator_rem (vl)) {
+			vl->ops->release (vl);
+			vl->ops->free (vl);
+		}
+	}
+}
+
+static
+void vl_garbage_collector (void *dummy)
+{
+	unsigned cnt;
+	struct vlocator_queue *vlq;
+	
+	/* Cleanup the vlocator hash: anything with a zero refcount is wiped */
+	for (cnt = 0; cnt < VL_HASH_QUEUES; cnt++) {
+		vlq = &__vl_hash[cnt];
+		if (list_empty (&vlq->queue)) /* Some cheating always helps... */
+			continue;
+		spin_lock (&vlq->lock);
+		__vl_garbage_collect (&vlq->queue);
+		spin_unlock (&vlq->lock);
+	}
+	/* Cleanup the list of stuff marked for disposal */
+	spin_lock (&__vl_disposal_lock);
+	__vl_garbage_collect (&__vl_disposal);
+	spin_unlock (&__vl_disposal_lock);
+	/* Re-arm */
+	schedule_delayed_work (&vl_workqueue, VL_GC_PERIOD * HZ);
+}
+
+
+/** Initialize the ufu subsystem. */
+static
+int __init subsys_ufu_init (void)
+{
+	unsigned i;
+	for (i = 0; i < sizeof (__vl_hash) / sizeof (__vl_hash[0]); i++)
+		vlocator_queue_init (&__vl_hash[i]);
+	/* Set up the garbage collector to run every 10 seconds */
+	schedule_delayed_work (&vl_workqueue, VL_GC_PERIOD * HZ);
+	return 0;
+}
+__initcall (subsys_ufu_init);
+
+
