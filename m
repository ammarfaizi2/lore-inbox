Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267801AbUGWPuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267801AbUGWPuG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 11:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267481AbUGWPuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 11:50:06 -0400
Received: from fmr05.intel.com ([134.134.136.6]:57733 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S267801AbUGWPkw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 11:40:52 -0400
Date: Fri, 23 Jul 2004 08:49:11 -0700
From: inaky.perez-gonzalez@intel.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com, robustmutexes@lists.osdl.org
Subject: [RFC/PATCH] FUSYN 5/11: user space/kernel space tracker
Message-ID: <0407230849.Ld0ccdydMbAcddja.c2b5d5djcjbQanb17066@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0407230849.Ycdbec6bWb9dtb.bHbUaebDcmdEcSdtb17066@intel.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This module provides means to do a refcounted tracking of an
object in kernel space based on a user space virtual
address. Cleanup is automatic when the object count drops to
zero (well, it is delayed).


 include/linux/vlocator.h |  206 ++++++++++++++++++
 kernel/vlocator.c        |  518 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 724 insertions(+)

--- /dev/null	Thu Jul 22 14:30:56 2004
+++ include/linux/vlocator.h Mon Jul 12 18:00:42 2004
@@ -0,0 +1,206 @@
+/*
+ * Generic mapping of kernel objects to user space addresses
+ * (C) 2002-2003 Intel Corp
+ * Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>.
+ *
+ * Licensed under the FSF's GNU Public License v2 or later.
+ *
+ * Heavily based on futexes (futex.c), (C) Rusty Russell and Jamie
+ * Lokier's futex key work (actually, in many places it is a shameless
+ * copy)...good invention this GPL thingie :) Blame me for the
+ * mistakes, though.
+ *
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
+#include <asm/atomic.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/fusyn-debug.h>
+
+/**
+ * Key to track user space addresses by hashing it.
+ *
+ * vlocators are matched on equal values of this key. The key type
+ * depends on whether it's a shared or private mapping.
+ *
+ * offset is aligned to a multiple of sizeof(u32) (== 4) by definition.
+ * We set bit 0 to indicate if it's an inode-based key.
+ */
+union vl_key {
+	struct {
+		unsigned long pgoff;
+		struct inode *inode;
+		int offset;
+	} shared;
+	struct {
+		unsigned long uaddr;
+		struct mm_struct *mm;
+		int offset;
+	} private;
+	struct {
+		unsigned long word;
+		void *ptr;
+		int offset;
+	} both;
+};
+
+
+/* Create a key for a given user space address */
+extern int vl_key_create (struct page **ppage, union vl_key *key,
+			  struct task_struct *task, unsigned long uaddr);
+
+
+/** Get references for @key */
+static inline
+void vl_key_get (union vl_key *key) 
+{
+	if (key->both.offset & 1)
+		atomic_inc (&key->shared.inode->i_count);
+	else
+		atomic_inc (&key->private.mm->mm_count);
+}
+
+
+/**
+ * Drop the references on @key.
+ */
+static inline
+void vl_key_put (union vl_key *key)
+{
+	if (key->both.offset & 1)
+		iput (key->shared.inode);
+	else
+		mmdrop (key->private.mm);
+}
+
+
+/* Get a page [maybe from swap] and pin it */
+extern int vl_page_get (struct page **ppage, struct task_struct *task,
+			struct mm_struct *mm, unsigned long uaddr);
+
+
+/** Put a page [unpin it] */
+static inline
+void vl_page_put (struct page *page) {
+	return put_page (page);
+}
+
+extern int __vl_key_page_get_shared (struct page **ppage, union vl_key *key);
+
+
+/**
+ * Get a page from a vl_key.
+ *
+ * @key: vl_key to bring the page from; needs to be referenced with
+ *       vl_key_get().
+ * @returns 0 if ok, < 0 errno code on error. If -ENOMEM, you can call
+ *          shrink_all_pages() and try again... I guess. 
+ *
+ * This function will pin in physical memory the page that is referred
+ * to by @key, referencing it and blocking modifications to the
+ * mappings it is at.
+ *          
+ * You have to call vl_key_page_put() on the page once done. No
+ * sleeping in between is very recommended.
+ */
+static inline
+int vl_key_page_get (struct page **ppage, union vl_key *key)
+{
+	int result;
+	
+	ftrace ("(%p, %p)\n", ppage, key);	
+	might_sleep();
+	
+	if (key->both.offset & 1) 
+		result = __vl_key_page_get_shared (ppage, key);
+	else {		/* Private mapping */
+		struct mm_struct *mm = key->private.mm;
+		down_read (&mm->mmap_sem);
+		result = vl_page_get (ppage, current, mm, key->private.uaddr);
+		if (unlikely (result < 0))
+			up_read (&mm->mmap_sem);
+	}
+	return result;
+}
+
+
+/** Release @page as mapped in from @key by vl_key_page_get(). */
+static inline
+void vl_key_page_put (struct page *page, union vl_key *key)
+{
+	ftrace ("(%p, %p)\n", page, key);
+	if (key->both.offset & 1) {
+		/* Shared mapping */
+		page_cache_release (page);
+		up (&key->shared.inode->i_mapping->i_shared_sem);
+	}
+	else {
+		/* Private mapping */
+		vl_page_put (page);
+		up_read (&key->private.mm->mmap_sem);
+	}
+}
+
+
+/** Object that can be associated to a user space address */
+struct vlocator {
+	atomic_t refcount;
+	struct list_head hash_list;
+	union vl_key key;
+	const struct vlocator_ops *ops;
+};
+
+
+/** Initialize a vlocator struct */
+static inline
+void vlocator_init (struct vlocator *vlocator)
+{
+	atomic_set (&vlocator->refcount, 0);
+	INIT_LIST_HEAD (&vlocator->hash_list);
+}
+
+
+/** vlocator operations on the items that are to be located. */
+struct vlocator_ops
+{
+	struct vlocator * (* alloc) (void);
+	int (* create) (struct vlocator *,
+			const union vl_key *, unsigned long priv);
+	void (* release) (struct vlocator *);
+	void (* free) (struct vlocator *);
+};
+
+
+/** Reference an vlocator @vlocator. */
+static inline
+void vl_get (struct vlocator *vl) {
+	atomic_inc (&vl->refcount);
+}
+
+
+/** Unreference an @vlocator; return true if it drops to zero. */
+static inline
+unsigned vl_put (struct vlocator *vlocator) {
+	return atomic_dec_and_test (&vlocator->refcount);
+}
+
+
+/* Find a vlocator by key */
+extern int vl_find (struct vlocator **pvl, const union vl_key *key,
+		    const struct vlocator_ops *ops);
+extern int vl_find_or_create (struct vlocator **pvl, const union vl_key *key,
+			      const struct vlocator_ops *ops, unsigned long priv);
+extern void vl_dispose (struct vlocator *vl);
+
+#endif /* #ifdef __KERNEL__ */
+#endif /* #ifndef __linux_vlocator_h__ */
--- /dev/null	Thu Jul 22 14:30:56 2004
+++ kernel/vlocator.c Tue Jul 13 17:34:38 2004
@@ -0,0 +1,518 @@
+
+/*
+ * fast User real-time/pi/pp/robust/deadlock SYNchronization
+ * (C) 2002-2003 Intel Corp
+ * Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>.
+ *
+ * Licensed under the FSF's GNU Public License v2 or later.
+ *
+ * Based on normal futexes (futex.c), (C) Rusty Russell.
+ * Please refer to Documentation/fusyn.txt for more info.
+ */
+
+#include <linux/init.h>
+#include <linux/vlocator.h>
+#include <linux/pagemap.h>
+#include <linux/jhash.h>
+#include <linux/fusyn-debug.h>
+
+#define VL_GC_PERIOD 20 /* do garbage collection every 20 seconds */
+#define VL_HASH_BITS 8
+#define VL_HASH_QUEUES (1 << VL_HASH_BITS)
+static struct vl_queue __vl_hash[VL_HASH_QUEUES];
+static struct list_head __vl_disposal = LIST_HEAD_INIT (__vl_disposal); 
+static spinlock_t __vl_disposal_lock = SPIN_LOCK_UNLOCKED;
+
+
+/** @returns a 32 bit hash for @key. */
+static inline
+u32 vl_key_hash (const union vl_key *key)
+{
+	u32 hash = jhash2 (
+		(u32*) &key->both.word,
+		(sizeof (key->both.word) + sizeof (key->both.ptr)) / 4,
+		key->both.offset);
+	return hash;
+}
+
+
+/** @returns true if @key1 and @key2 are equal. */
+static inline
+int vl_key_equal (const union vl_key *key1, const union vl_key *key2)
+{
+	return !memcmp (key1, key2, sizeof (*key1));
+}
+
+
+/**
+ * Low level grunt for getting a page from a shared key.
+ *
+ * @ppage: where to put the pointer to the page.
+ * @key: key to get a page from (has to be referenced with
+ * vl_key_get().
+ * @returns 0 if ok, < 0 errno code on error.
+ *
+ * Do not call directly (use vl_key_page_get()).
+ */
+int __vl_key_page_get_shared (struct page **ppage, union vl_key *key)
+{
+	int result;
+	struct page *page;
+	struct address_space *mapping = key->shared.inode->i_mapping;
+
+	ftrace ("(%p, %p)\n", ppage, key);	
+
+#warning: FIXME: block/lock the mapping...I am not that sure of this
+	down (&mapping->i_shared_sem);
+	page = read_cache_page (mapping, key->shared.pgoff, 
+				(filler_t *) mapping->a_ops->readpage, NULL);
+	result = PTR_ERR (page);
+	if (IS_ERR (page))
+		goto out_up;
+	
+	wait_on_page_locked (page);
+	if (!PageUptodate (page)) {
+		page_cache_release (page);
+		page = ERR_PTR (-EIO);
+	}
+	*ppage = page;
+	return 0;
+
+out_up:
+	up (&mapping->i_shared_sem);
+	return result;
+}
+
+
+/** A hash bucket. */
+struct vl_queue
+{
+	spinlock_t lock;
+	struct list_head queue;
+	unsigned additions;
+};
+
+
+/** Get the hash index for futex_key @k. */
+static inline
+struct vl_queue * vl_hash (const union vl_key *key) {
+	return &__vl_hash[vl_key_hash (key) & (VL_HASH_QUEUES - 1)];
+};
+
+	
+/** Search in a queue. */
+static inline
+struct vlocator * __vl_find (struct vl_queue *vlq,
+			     const union vl_key *key)
+{
+	struct vlocator *vl = NULL;
+	struct list_head *itr;
+
+	list_for_each (itr, &vlq->queue) {
+		vl = container_of (itr, struct vlocator, hash_list);
+		if (vl_key_equal (key, &vl->key))
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
+struct vlocator * __vl_find_r (struct vl_queue *vlq,
+			       const union vl_key *key)
+{
+	struct vlocator *vl = NULL;
+	struct list_head *itr;
+
+	list_for_each_prev (itr, &vlq->queue) {
+		vl = container_of (itr, struct vlocator, hash_list);
+		if (vl_key_equal (key, &vl->key))
+			goto out;
+	}
+	vl = NULL;
+out:
+	return vl;
+}
+
+
+/** Append @vlocator to queue @vlq. */ 
+static inline
+void __vl_add (struct vl_queue *vlq, struct vlocator *vl)
+{
+	vlq->additions++;
+	list_add (&vl->hash_list, &vlq->queue);
+}
+
+
+/** Remove @vlocator from queue @vlq if its use count is zero (and
+ * return true). */ 
+static inline
+unsigned __vl_rem (struct vlocator *v)
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
+/**
+ * Pin a page in memory given the user space address.
+ *
+ * @ppage: pointer to where to store the pinned page
+ * @task: task whose address space we have to use.
+ * @uaddr: user space address to pin
+ * @returns: 0 if ok and the page in **ppage, < 0 errno code on
+ *           error.
+ * 
+ * Needs mm->mmap_sem down for read.
+ *
+ * Taken from the original futex code.
+ */
+int vl_page_get (struct page **ppage, struct task_struct *task,
+		 struct mm_struct *mm, unsigned long uaddr)
+{
+	int result = 0;
+	struct page *page;
+	
+	spin_lock (&mm->page_table_lock);
+	page = follow_page (mm, uaddr, 0);
+	if (likely (page != NULL)) {
+		if (!PageReserved (page))
+			get_page (page);
+		*ppage = page;
+		spin_unlock (&mm->page_table_lock);
+		goto out;
+	}
+	spin_unlock (&mm->page_table_lock);
+
+	/* Do it the general way. */
+	result = get_user_pages (task, mm, uaddr, 1, 0, 0, ppage, NULL);
+out:
+	return result;
+}
+
+
+/**
+ * Generate a key for a user space address.
+ *
+ * @ppage: pointer to page struct where the space is. The page has
+ *         been pinned in memory with vl_page_get() and needs a
+ *         vl_page_put() when done.
+ * @key: Pointer to where to store the key. Upon return, the key is
+ *       filled up and has been referenced with vl_key_get().
+ * @task: task that owns the user space address.
+ * @uaddr: user space address
+ * @returns: 0 if ok, < 0 errno code on error.
+ *
+ * Needs to be called with mm->mmap_sem down for read.
+ */
+int vl_key_create (struct page **ppage, union vl_key *key,
+		   struct task_struct *task, unsigned long uaddr)
+{
+	int result, update_shared = 0;
+	struct page *page;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	
+	ftrace ("(%p, %p, %p [%d], %lx)\n",
+		ppage, key, task, task->pid, uaddr);
+
+	/* The futex address must be "naturally" aligned. */
+	key->both.offset = uaddr % PAGE_SIZE;
+	if (unlikely ((key->both.offset % sizeof (u32)) != 0))
+		return -EINVAL;
+	uaddr -= key->both.offset;
+	
+	/*
+	 * The futex is hashed differently depending on whether
+	 * it's in a shared or private mapping.	 So check vma first.
+	 */
+	vma = find_extend_vma (mm, uaddr);
+	result = -EFAULT;
+	if (unlikely (!vma))
+		goto out;
+	/* Permissions. */
+	result = (vma->vm_flags & VM_IO) ? -EPERM : -EACCES;
+	if (unlikely ((vma->vm_flags & (VM_IO|VM_READ)) != VM_READ))
+		goto out;
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
+		goto out_page_get;
+	}
+	/* Linear file mappings are also simple. */
+	key->shared.inode = vma->vm_file->f_dentry->d_inode;
+	key->both.offset++; /* Bit 0 of offset indicates inode-based key. */
+	if (likely (!(vma->vm_flags & VM_NONLINEAR))) {
+		key->shared.pgoff =
+			(((uaddr - vma->vm_start) >> PAGE_SHIFT)
+			 + vma->vm_pgoff);
+		goto out_page_get;
+	}
+	update_shared = 1;
+out_page_get:
+	result = vl_page_get (&page, current, mm, uaddr);
+	if (unlikely (result < 0))
+		goto out;
+	if (update_shared)
+		key->shared.pgoff =
+			page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
+	vl_key_get (key);
+	*ppage = page;
+out:
+	return result;
+}
+
+
+/**
+ * Find a vlocator in the hash table.
+ * 
+ * @pvl: Pointer to where to store a pointer to the found vlocator.
+ *       
+ * @key: key to locate the item; it has to have been referenced with
+ *       vl_key_get() [vl_key_create() does it].
+ * 
+ * @ops: vl operations structure for verification.
+ * 
+ * @returns 0 if ok and *pvl has the pointer to the vlocator
+ *            corresponding to @key. It has been referenced with
+ *            vl_get() before returning.
+ *            -ENOENT: not found
+ *            -ENOMEM: cannot allocate a new item.
+ *            -EFAULT: if an item was found, but its ops are different
+ *            to the ones provided).
+ *            < 0 errno code on error from ops->create().
+ */
+int vl_find (struct vlocator **pvl, const union vl_key *key,
+	     const struct vlocator_ops *ops)
+{
+	int result = -ENOENT;
+	struct vl_queue *vlq;
+	struct vlocator *vl;
+	
+	ftrace ("(%p, %p, %p)\n", pvl, key, ops);
+
+	/* Is it in the hash already? [do we know about it?] */
+	vlq = vl_hash (key);
+	spin_lock (&vlq->lock);
+	vl = __vl_find (vlq, key);
+	if (unlikely (vl == NULL))
+		goto out_unlock;
+	/* Check the type is correct */
+	result = -EFAULT;
+	if (unlikely (vl->ops != ops))
+		goto out_unlock;
+	result = 0;
+	vl_get (vl);
+	*pvl = vl;
+out_unlock:
+	spin_unlock (&vlq->lock);
+	return result;
+}
+
+
+/**
+ * Find or create a vlocator in the hash table.
+ * 
+ * @pvl: Pointer to where to store a pointer to the found vlocator
+ *       item or the newly allocated and hashed one.
+ *       
+ * @key: key to locate the item; it has to have been referenced with
+ *       vl_key_get() [vl_key_create() does it].
+ * 
+ * @ops: vl operations structure for creation/allocation/freeing.
+ *
+ * @priv: private data passed to ops->create().
+ * 
+ * @returns 0 if ok and *pvl has the pointer to the vlocator
+ *            corresponding to @key. If not found, one is allocated
+ *            and inserted into the hash. In both cases, it has been 
+ *            referenced with vl_get() before returning it.
+ *            -ENOMEM: cannot allocate a new item.
+ *            -EFAULT: if an item was found, but its ops are different
+ *            to the ones provided).
+ *            < 0 errno code on error from ops->create().
+ */
+int vl_find_or_create (struct vlocator **pvl, const union vl_key *key,
+		       const struct vlocator_ops *ops, unsigned long priv)
+{
+	int result;
+	struct vl_queue *vlq;
+	struct vlocator *vl, *vl_alt;
+	unsigned additions0;
+	
+	ftrace ("(%p, %p, %p, %lx)\n", pvl, key, ops, priv);
+	might_sleep();
+	
+	/* Is it in the hash already? [do we know about it?] */
+	vlq = vl_hash (key);
+	spin_lock (&vlq->lock);
+	vl = __vl_find (vlq, key);
+	if (likely (vl != NULL))
+		goto out_check;
+	additions0 = vlq->additions;
+	spin_unlock (&vlq->lock);
+
+	/* Naaah, let's alloc it */
+	result = -ENOMEM;
+	vl = ops->alloc();
+	if (unlikely (vl == NULL))
+		goto out;
+	
+	/* Ok, allocated - did somebody add it while we were allocating?
+	 * [we try to speed up by checking if anybody has added since
+	 * we dropped the lock--we live up with the chance of 4G
+	 * allocations wrapping up the counter in the middle *grin*]. */
+	spin_lock (&vlq->lock);
+	if (additions0 == vlq->additions
+	    || (vl_alt = __vl_find_r (vlq, key)) == NULL) {
+		result = ops->create (vl, key, priv);
+		if (unlikely (result != 0)) {
+			ops->free (vl);
+			goto out_unlock;
+		}
+		vl->ops = ops;
+		__vl_add (vlq, vl);
+		goto out_ref;
+	}
+	/* Allocation collision, get the new one, discard ours */  
+	ops->free (vl);
+	vl = vl_alt;
+out_check:
+	result = -EFAULT;
+	if (unlikely (vl->ops != ops))	/* Check the type is correct */
+		goto out_unlock;
+	result = 0;
+out_ref:
+	vl_get (vl);
+	*pvl = vl;
+out_unlock:
+	spin_unlock (&vlq->lock);
+out:
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
+void vl_dispose (struct vlocator *vl)
+{
+	struct vl_queue *vlq;
+
+	/* In the hash, move it out */
+	vlq = vl_hash (&vl->key);
+	spin_lock (&vlq->lock);
+	list_del (&vl->hash_list);
+	spin_lock (&__vl_disposal_lock);
+	list_add_tail (&vl->hash_list, &__vl_disposal);
+	spin_unlock (&__vl_disposal_lock);
+	spin_unlock (&vlq->lock);
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
+static 
+void __vl_garbage_collect (struct list_head *purge_list,
+			   struct list_head *list)
+{
+	struct list_head *itr, *nxt;
+	struct vlocator *vl;
+	list_for_each_safe (itr, nxt, list) {
+		vl = container_of (itr, struct vlocator, hash_list);
+		if (__vl_rem (vl))
+			list_add_tail (&vl->hash_list, purge_list);
+	}
+}
+
+static
+void vl_garbage_collector (void *dummy)
+{
+	unsigned cnt;
+	struct vl_queue *vlq;
+	struct list_head purge_list = LIST_HEAD_INIT (purge_list);
+	struct list_head *itr, *nxt;
+	struct vlocator *vl;
+	
+	/* Collect from the vlocator hash: anything with a zero refcount */
+	for (cnt = 0; cnt < VL_HASH_QUEUES; cnt++) {
+		vlq = &__vl_hash[cnt];
+		if (list_empty (&vlq->queue)) /* Some cheating always helps... */
+			continue;
+		spin_lock (&vlq->lock);
+		__vl_garbage_collect (&purge_list, &vlq->queue);
+		spin_unlock (&vlq->lock);
+	}
+	/* Collect the list of stuff marked for disposal */
+	spin_lock (&__vl_disposal_lock);
+	__vl_garbage_collect (&purge_list, &__vl_disposal);
+	spin_unlock (&__vl_disposal_lock);
+	/* Cleanup the collected stuff and re-arm */
+	list_for_each_safe (itr, nxt, &purge_list) {
+		vl = container_of (itr, struct vlocator, hash_list);
+		if (vl->ops->release)
+			vl->ops->release (vl);
+		vl->ops->free (vl);
+	}
+	schedule_delayed_work (&vl_workqueue, VL_GC_PERIOD * HZ);
+}
+
+
+/** Initilize vlocator queue @vlq. */
+static inline
+void vl_queue_init (struct vl_queue *vlq)
+{
+	vlq->lock = SPIN_LOCK_UNLOCKED;
+	INIT_LIST_HEAD (&vlq->queue);
+	vlq->additions = 0;
+}
+
+/** Initialize the vlocator subsystem. */
+static
+int __init vl_subsys_init (void)
+{
+	unsigned i;
+	for (i = 0; i < sizeof (__vl_hash) / sizeof (__vl_hash[0]); i++)
+		vl_queue_init (&__vl_hash[i]);
+	/* Set up the garbage collector to run every 10 seconds */
+	schedule_delayed_work (&vl_workqueue, VL_GC_PERIOD * HZ);
+	return 0;
+}
+__initcall (vl_subsys_init);
+
+
