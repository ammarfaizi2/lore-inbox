Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbTIEFWp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 01:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbTIEFWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 01:22:22 -0400
Received: from dp.samba.org ([66.70.73.150]:4499 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262177AbTIEFUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 01:20:07 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jamie Lokier <jamie@shareable.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2] Little fixes to previous futex patch 
In-reply-to: Your message of "Thu, 04 Sep 2003 18:59:39 +0100."
             <20030904175939.GD30394@mail.jlokier.co.uk> 
Date: Fri, 05 Sep 2003 14:56:25 +1000
Message-Id: <20030905052006.C19C52C255@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030904175939.GD30394@mail.jlokier.co.uk> you write:
> Feel free to think up a better hash that isn't slow.  Two iterations
> of hash_long() would be a good hash, but slower.

I've used jhash below.

> > The err at the end of __get_page_keys would be 1 from successful
> > get_user_pages, treated as error by the callers: need to make it 0.
> 
> Well spotted.

Fixed below.

> > futex_wait: I didn't get around to it in my version, so haven't
> > thought through the issues, but I'm a bit worried that you get
> > curval for -EWOULDBLOCK check without holding the futex_lock.

This works: the only danger is that the WAKE side will wake us even
though we were going to fail with -EWOULDBLOCK, which is why we notice
this in out_unqueue and return 0 in this case (if it's doing wake-one,
it *really* must successfully wake one...).

> > That looks suspicious to me, but I'm going to be lazy and not
> > try to think about it, because Rusty is sure to understand the
> > races there.  If that code is insufficient as you have it, may
> > need __pin_page reinstated for just that case (hmm, was that
> > get_user right before? I'd expect it to kmap_atomic pinned page.)
> 
> The important things are that the futex is queued prior to checking
> curval, the requested page won't change (it's protected by mmap_sem),
> and any parallel waker changes the word prior to waking us.
> 
> You made me notice a rather subtle memory ordering condition, though.
> 
> We must issue the read after queuing the futex.  There needs to be a
> smp_rmb() after queuing and before the read, because the spin_unlock()
> barrier only constrains earlier reads, not later ones.

Ah, the joys of thinking too hard: I've been here before 8).

In my analyss, the earliest the read can move is to the beginning of
the futex_lock, ie equivalent to:

	spin_lock(&futex_lock);
	get_user(curval, (int *)uaddr);
	list_add_tail(&q->list, head);
	spin_unlock(&futex_lock);

Since the wake side has to take the futex lock too, this ordering is
still safe.

> Thanks for all your great insights,

Definitely seconded, Hugh.  Thanks!

Here's my accumulated patch set (Jamie's fixed patch included first
for completeness):
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Futexes without pinning pages
Author: Jamie Lokier
Status: Booted on 2.6.0-test4-bk6

D: [ Later fixes from Jamie and Andrew Morton added --RR ]
D: include/linux/mm.h     |    1
D: include/linux/vcache.h |   26 ---
D: kernel/futex.c         |  368 +++++++++++++++++++++++++------------------------
D: mm/Makefile            |    2
D: mm/fremap.c            |    9 +
D: mm/memory.c            |    2
D: mm/vcache.c            |   90 -----------
D: 7 files changed, 200 insertions(+), 298 deletions(-)
D: 
D: Patch name: futex-fixes-2.6.0-test4-01jl
D: 
D: This patch changes the way futexes are indexed, so that they do not
D: pin pages and also corrects some problems with private mappings and COW
D: pages.
D: 
D: Currently, all futexes look up the page at the userspace address and
D: pin it, using the pair (page,offset) as an index into a table of
D: waiting futexes.  Any page with a futex waiting on it remains pinned
D: in RAM, which is a problem when many futexes are used, especially with
D: FUTEX_FD.
D: 
D: Another problem is that the page is not always the correct one, if it
D: can be changed later by a COW (copy on write) operation.  This can
D: happen when waiting on a futex without writing to it after fork(),
D: exec() or mmap(), if the page is then written to before attempting to
D: wake a futex at the same adress.
D: 
D: There are two symptoms of the COW problem: 1. The wrong process can
D: receive wakeups; 2. A process can fail to receive required wakeups.
D: 
D: This patch fixes both by changing the indexing so that VM_SHARED
D: mappings use the triple (inode,offset,index), and private mappings use
D: the pair (mm,virtual_address).
D: 
D: The former correctly handles all shared mappings, including tmpfs and
D: therefore all kinds of shared memory (IPC shm, /dev/shm and
D: MAP_ANON|MAP_SHARED).  This works because every mapping which is
D: VM_SHARED has an associated non-zero vma->vm_file, and hence inode.
D: (This is ensured in do_mmap_pgoff, where it calls shmem_zero_setup).
D: 
D: The latter handles all private mappings, both files and anonymous.  It
D: isn't affected by COW, because it doesn't care about the actual pages,
D: just the virtual address.
D: 
D: The only obvious problem is that mremap() can move a private mapping
D: without informing futexes waiting on that mapping.  However, mremap()
D: was already broken with futexes, because it doesn't update the vcache,
D: which is used by futexes, so this just changes an existing bug.
D: 
D: (A later patch from me will fix this problem with mremap(), by moving
D: the futexes).
D: 
D: This patch has a few bonuses:
D: 
D: 	1. It removes the vcache implementation, as only futexes were
D: 	   using it, and they don't any more.
D: 
D: 	2. Removing the vcache should make COW page faults a bit faster.
D: 
D: 	3. Futex operations no longer take the page table lock, walk
D: 	   the page table, fault in pages that aren't mapped in the
D: 	   page table, or do a vcache hash lookup - they are mostly a
D: 	   simple offset calculation with one hash for the futex
D: 	   table.  So they should be noticably faster.
D: 
D: 	4. The patch reduces the kernel size by 98 lines.
D: 
D: -- Jamie

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16361-linux-2.6.0-test4-bk6/include/linux/mm.h .16361-linux-2.6.0-test4-bk6.updated/include/linux/mm.h
--- .16361-linux-2.6.0-test4-bk6/include/linux/mm.h	2003-08-25 11:58:34.000000000 +1000
+++ .16361-linux-2.6.0-test4-bk6.updated/include/linux/mm.h	2003-09-05 14:54:31.000000000 +1000
@@ -110,6 +110,7 @@ struct vm_area_struct {
 #define VM_RESERVED	0x00080000	/* Don't unmap it from swap_out */
 #define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
 #define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
+#define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
 
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16361-linux-2.6.0-test4-bk6/include/linux/vcache.h .16361-linux-2.6.0-test4-bk6.updated/include/linux/vcache.h
--- .16361-linux-2.6.0-test4-bk6/include/linux/vcache.h	2003-01-02 12:30:47.000000000 +1100
+++ .16361-linux-2.6.0-test4-bk6.updated/include/linux/vcache.h	1970-01-01 10:00:00.000000000 +1000
@@ -1,26 +0,0 @@
-/*
- * virtual => physical mapping cache support.
- */
-#ifndef _LINUX_VCACHE_H
-#define _LINUX_VCACHE_H
-
-typedef struct vcache_s {
-	unsigned long address;
-	struct mm_struct *mm;
-	struct list_head hash_entry;
-	void (*callback)(struct vcache_s *data, struct page *new_page);
-} vcache_t;
-
-extern spinlock_t vcache_lock;
-
-extern void __attach_vcache(vcache_t *vcache,
-		unsigned long address,
-		struct mm_struct *mm,
-		void (*callback)(struct vcache_s *data, struct page *new_page));
-
-extern void __detach_vcache(vcache_t *vcache);
-
-extern void invalidate_vcache(unsigned long address, struct mm_struct *mm,
-				struct page *new_page);
-
-#endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16361-linux-2.6.0-test4-bk6/kernel/futex.c .16361-linux-2.6.0-test4-bk6.updated/kernel/futex.c
--- .16361-linux-2.6.0-test4-bk6/kernel/futex.c	2003-09-05 09:16:38.000000000 +1000
+++ .16361-linux-2.6.0-test4-bk6.updated/kernel/futex.c	2003-09-05 14:54:31.000000000 +1000
@@ -5,6 +5,9 @@
  *  Generalized futexes, futex requeueing, misc fixes by Ingo Molnar
  *  (C) Copyright 2003 Red Hat Inc, All Rights Reserved
  *
+ *  Changed to remove page pinning and fix privately mapped COW pages
+ *  Copyright (C) Jamie Lokier 2003
+ *
  *  Thanks to Ben LaHaise for yelling "hashed waitqueues" loudly
  *  enough at me, Linus for the original (flawed) idea, Matthew
  *  Kirkwood for proof-of-concept implementation.
@@ -33,7 +36,6 @@
 #include <linux/hash.h>
 #include <linux/init.h>
 #include <linux/futex.h>
-#include <linux/vcache.h>
 #include <linux/mount.h>
 
 #define FUTEX_HASHBITS 8
@@ -46,13 +48,10 @@ struct futex_q {
 	struct list_head list;
 	wait_queue_head_t waiters;
 
-	/* Page struct and offset within it. */
-	struct page *page;
+	/* Page keys and offset within the page. */
+	unsigned long keys[2];
 	int offset;
 
-	/* the virtual => physical COW-safe cache */
-	vcache_t vcache;
-
 	/* For fd, sigio sent using these. */
 	int fd;
 	struct file *filp;
@@ -66,85 +65,110 @@ static spinlock_t futex_lock = SPIN_LOCK
 static struct vfsmount *futex_mnt;
 
 /*
- * These are all locks that are necessery to look up a physical
- * mapping safely, and modify/search the futex hash, atomically:
- */
-static inline void lock_futex_mm(void)
-{
-	spin_lock(&current->mm->page_table_lock);
-	spin_lock(&vcache_lock);
-	spin_lock(&futex_lock);
-}
-
-static inline void unlock_futex_mm(void)
-{
-	spin_unlock(&futex_lock);
-	spin_unlock(&vcache_lock);
-	spin_unlock(&current->mm->page_table_lock);
-}
-
-/*
- * The physical page is shared, so we can hash on its address:
+ * We hash on the keys returned from __get_page_keys (see below),
+ * and the offset into the page.
  */
-static inline struct list_head *hash_futex(struct page *page, int offset)
+static inline struct list_head *hash_futex(unsigned long key0,
+					   unsigned long key1,
+					   int offset)
 {
-	return &futex_queues[hash_long((unsigned long)page + offset,
-							FUTEX_HASHBITS)];
+	return &futex_queues[hash_long(key0 + key1 + offset, FUTEX_HASHBITS)];
 }
 
 /*
- * Get kernel address of the user page and pin it.
+ * Get two parameters which are the keys for a futex
+ * other than the offset within page.
  *
- * Must be called with (and returns with) all futex-MM locks held.
+ * For shared mappings, it's "vma->vm_file->f_dentry->d_inode" and
+ * "page->index".  For private mappings, it's "current->mm" and "addr".
+ * We can usually work out the index without swapping in the page.
+ *
+ * Returns: 0, or negative error code.
+ * The two key words are stored in key[0] and key[1] on success.
+ *
+ * Should be called with &current->mm->mmap_sem,
+ * but NOT &futex_lock or &current->mm->page_table_lock.
  */
-static inline struct page *__pin_page_atomic (struct page *page)
-{
-	if (!PageReserved(page))
-		get_page(page);
-	return page;
-}
-
-static struct page *__pin_page(unsigned long addr)
+static int __get_page_keys(unsigned long addr, unsigned long * keys)
 {
 	struct mm_struct *mm = current->mm;
-	struct page *page, *tmp;
+	struct vm_area_struct *vma;
+	struct page *page;
 	int err;
 
 	/*
-	 * Do a quick atomic lookup first - this is the fastpath.
+	 * The futex is hashed differently depending on whether
+	 * it's in a shared or private mapping.  So check vma first.
 	 */
-	page = follow_page(mm, addr, 0);
-	if (likely(page != NULL))
-		return __pin_page_atomic(page);
+	vma = find_extend_vma(mm, addr);
+
+	if (unlikely(!vma)) {
+#ifdef FIXADDR_USER_START
+		if (addr >= FIXADDR_USER_START && addr < FIXADDR_USER_END) {
+			keys[0] = 1; /* Different from any pointer value. */
+			keys[1] = addr - FIXADDR_USER_START;
+			return 0;
+		}
+#endif
+		return -EFAULT;
+	}
 
 	/*
-	 * No luck - need to fault in the page:
+	 * Permissions.
 	 */
-repeat_lookup:
+	if (unlikely((vma->vm_flags & (VM_IO|VM_READ)) != VM_READ))
+		return -EFAULT;
 
-	unlock_futex_mm();
+	/*
+	 * Private mappings are handled in a simple way.
+	 */
+	if (likely(!(vma->vm_flags & VM_SHARED))) {
+		keys[0] = (unsigned long) mm;
+		keys[1] = addr;
+		return 0;
+	}
 
-	down_read(&mm->mmap_sem);
-	err = get_user_pages(current, mm, addr, 1, 0, 0, &page, NULL);
-	up_read(&mm->mmap_sem);
+	/*
+	 * Linear mappings are also simple.
+	 */
+	keys[0] = (unsigned long) vma->vm_file->f_dentry->d_inode;
+	if (likely(!(vma->vm_flags & VM_NONLINEAR))) {
+		keys[1] = (((addr - vma->vm_start) >> PAGE_SHIFT)
+			   + vma->vm_pgoff);
+		return 0;
+	}
 
-	lock_futex_mm();
+	/*
+	 * We could walk the page table to read the non-linear
+	 * pte, and get the page index without fetching the page
+	 * from swap.  But that's a lot of code to duplicate here
+	 * for a rare case, so we simply fetch the page.
+	 */
 
-	if (err < 0)
-		return NULL;
 	/*
-	 * Since the faulting happened with locks released, we have to
-	 * check for races:
+	 * Do a quick atomic lookup first - this is the fastpath.
 	 */
-	tmp = follow_page(mm, addr, 0);
-	if (tmp != page) {
-		put_page(page);
-		goto repeat_lookup;
+	spin_lock(&current->mm->page_table_lock);
+	page = follow_page(mm, addr, 0);
+	if (likely(page != NULL)) {
+		keys[1] = page->index;
+		spin_unlock(&current->mm->page_table_lock);
+		return 0;
 	}
+	spin_unlock(&current->mm->page_table_lock);
 
-	return page;
+	/*
+	 * Do it the general way.
+	 */
+	err = get_user_pages(current, mm, addr, 1, 0, 0, &page, NULL);
+	if (err >= 0) {
+		keys[1] = page->index;
+		put_page(page);
+	}
+	return err;
 }
 
+
 /*
  * Wake up all waiters hashed on the physical page that is mapped
  * to this virtual address:
@@ -152,25 +176,25 @@ repeat_lookup:
 static inline int futex_wake(unsigned long uaddr, int offset, int num)
 {
 	struct list_head *i, *next, *head;
-	struct page *page;
-	int ret = 0;
+	unsigned long keys[2];
+	int ret;
 
-	lock_futex_mm();
+	down_read(&current->mm->mmap_sem);
 
-	page = __pin_page(uaddr - offset);
-	if (!page) {
-		unlock_futex_mm();
-		return -EFAULT;
-	}
+	ret = __get_page_keys(uaddr - offset, keys);
+	if (unlikely(ret != 0))
+		goto out;
 
-	head = hash_futex(page, offset);
+	head = hash_futex(keys[0], keys[1], offset);
 
+	spin_lock(&futex_lock);
 	list_for_each_safe(i, next, head) {
 		struct futex_q *this = list_entry(i, struct futex_q, list);
 
-		if (this->page == page && this->offset == offset) {
+		if (this->keys[0] == keys[0] && this->keys[1] == keys[1]
+		    && this->offset == offset) {
+
 			list_del_init(i);
-			__detach_vcache(&this->vcache);
 			wake_up_all(&this->waiters);
 			if (this->filp)
 				send_sigio(&this->filp->f_owner, this->fd, POLL_IN);
@@ -179,38 +203,14 @@ static inline int futex_wake(unsigned lo
 				break;
 		}
 	}
+	spin_unlock(&futex_lock);
 
-	unlock_futex_mm();
-	put_page(page);
-
+out:
+	up_read(&current->mm->mmap_sem);
 	return ret;
 }
 
 /*
- * This gets called by the COW code, we have to rehash any
- * futexes that were pending on the old physical page, and
- * rehash it to the new physical page. The pagetable_lock
- * and vcache_lock is already held:
- */
-static void futex_vcache_callback(vcache_t *vcache, struct page *new_page)
-{
-	struct futex_q *q = container_of(vcache, struct futex_q, vcache);
-	struct list_head *head = hash_futex(new_page, q->offset);
-
-	spin_lock(&futex_lock);
-
-	if (!list_empty(&q->list)) {
-		put_page(q->page);
-		q->page = new_page;
-		__pin_page_atomic(new_page);
-		list_del(&q->list);
-		list_add_tail(&q->list, head);
-	}
-
-	spin_unlock(&futex_lock);
-}
-
-/*
  * Requeue all waiters hashed on one physical page to another
  * physical page.
  */
@@ -218,74 +218,66 @@ static inline int futex_requeue(unsigned
 	unsigned long uaddr2, int offset2, int nr_wake, int nr_requeue)
 {
 	struct list_head *i, *next, *head1, *head2;
-	struct page *page1 = NULL, *page2 = NULL;
-	int ret = 0;
+	unsigned long keys1[2], keys2[2];
+	int ret;
 
-	lock_futex_mm();
+	down_read(&current->mm->mmap_sem);
 
-	page1 = __pin_page(uaddr1 - offset1);
-	if (!page1)
+	ret = __get_page_keys(uaddr1 - offset1, keys1);
+	if (unlikely(ret != 0))
 		goto out;
-	page2 = __pin_page(uaddr2 - offset2);
-	if (!page2)
+	ret = __get_page_keys(uaddr2 - offset2, keys2);
+	if (unlikely(ret != 0))
 		goto out;
 
-	head1 = hash_futex(page1, offset1);
-	head2 = hash_futex(page2, offset2);
+	head1 = hash_futex(keys1[0], keys1[1], offset1);
+	head2 = hash_futex(keys2[0], keys2[1], offset2);
 
+	spin_lock(&futex_lock);
 	list_for_each_safe(i, next, head1) {
 		struct futex_q *this = list_entry(i, struct futex_q, list);
 
-		if (this->page == page1 && this->offset == offset1) {
+		if (this->keys[0] == keys1[0] && this->keys[1] == keys1[1]
+		    && this->offset == offset1) {
+
 			list_del_init(i);
-			__detach_vcache(&this->vcache);
 			if (++ret <= nr_wake) {
 				wake_up_all(&this->waiters);
 				if (this->filp)
 					send_sigio(&this->filp->f_owner,
 							this->fd, POLL_IN);
 			} else {
-				put_page(this->page);
-				__pin_page_atomic (page2);
 				list_add_tail(i, head2);
-				__attach_vcache(&this->vcache, uaddr2,
-					current->mm, futex_vcache_callback);
+				this->keys[0] = keys2[0];
+				this->keys[1] = keys2[1];
 				this->offset = offset2;
-				this->page = page2;
 				if (ret - nr_wake >= nr_requeue)
 					break;
 			}
 		}
 	}
+	spin_unlock(&futex_lock);
 
 out:
-	unlock_futex_mm();
-
-	if (page1)
-		put_page(page1);
-	if (page2)
-		put_page(page2);
-
+	up_read(&current->mm->mmap_sem);
 	return ret;
 }
 
-static inline void __queue_me(struct futex_q *q, struct page *page,
-				unsigned long uaddr, int offset,
-				int fd, struct file *filp)
+static inline void queue_me(struct futex_q *q, unsigned long *keys,
+			    unsigned long uaddr, int offset,
+			    int fd, struct file *filp)
 {
-	struct list_head *head = hash_futex(page, offset);
+	struct list_head *head = hash_futex(keys[0], keys[1], offset);
 
+	q->keys[0] = keys[0];
+	q->keys[1] = keys[1];
 	q->offset = offset;
 	q->fd = fd;
 	q->filp = filp;
-	q->page = page;
 
+	spin_lock(&futex_lock);
 	list_add_tail(&q->list, head);
-	/*
-	 * We register a futex callback to this virtual address,
-	 * to make sure a COW properly rehashes the futex-queue.
-	 */
-	__attach_vcache(&q->vcache, uaddr, current->mm, futex_vcache_callback);
+	spin_unlock(&futex_lock);
 }
 
 /* Return 1 if we were still queued (ie. 0 means we were woken) */
@@ -293,15 +285,12 @@ static inline int unqueue_me(struct fute
 {
 	int ret = 0;
 
-	spin_lock(&vcache_lock);
 	spin_lock(&futex_lock);
 	if (!list_empty(&q->list)) {
 		list_del(&q->list);
-		__detach_vcache(&q->vcache);
 		ret = 1;
 	}
 	spin_unlock(&futex_lock);
-	spin_unlock(&vcache_lock);
 	return ret;
 }
 
@@ -311,65 +300,94 @@ static inline int futex_wait(unsigned lo
 		      unsigned long time)
 {
 	DECLARE_WAITQUEUE(wait, current);
-	int ret = 0, curval;
-	struct page *page;
+	int ret, curval;
+	unsigned long keys[2];
 	struct futex_q q;
 
+ try_again:
 	init_waitqueue_head(&q.waiters);
 
-	lock_futex_mm();
+	down_read(&current->mm->mmap_sem);
 
-	page = __pin_page(uaddr - offset);
-	if (!page) {
-		unlock_futex_mm();
-		return -EFAULT;
-	}
-	__queue_me(&q, page, uaddr, offset, -1, NULL);
+	ret = __get_page_keys(uaddr - offset, keys);
+	if (unlikely(ret != 0))
+		goto out_release_sem;
+
+	queue_me(&q, keys, uaddr, offset, -1, NULL);
 
 	/*
-	 * Page is pinned, but may no longer be in this address space.
-	 * It cannot schedule, so we access it with the spinlock held.
+	 * Access the page after the futex is queued.
+	 * We hold the mmap semaphore, so the mapping cannot have changed
+	 * since we looked it up.
 	 */
 	if (get_user(curval, (int *)uaddr) != 0) {
-		unlock_futex_mm();
 		ret = -EFAULT;
-		goto out;
+		goto out_unqueue;
 	}
 	if (curval != val) {
-		unlock_futex_mm();
 		ret = -EWOULDBLOCK;
-		goto out;
+		goto out_unqueue;
 	}
+
 	/*
-	 * The get_user() above might fault and schedule so we
-	 * cannot just set TASK_INTERRUPTIBLE state when queueing
-	 * ourselves into the futex hash. This code thus has to
+	 * Now the futex is queued and we have checked the data, we
+	 * don't want to hold mmap_sem while we sleep.
+	 */	
+	up_read(&current->mm->mmap_sem);
+
+	/*
+	 * There might have been scheduling since the queue_me(), as we
+	 * cannot hold a spinlock across the get_user() in case it
+	 * faults.  So we cannot just set TASK_INTERRUPTIBLE state when
+	 * queueing ourselves into the futex hash.  This code thus has to
 	 * rely on the futex_wake() code doing a wakeup after removing
 	 * the waiter from the list.
 	 */
 	add_wait_queue(&q.waiters, &wait);
+	spin_lock(&futex_lock);
 	set_current_state(TASK_INTERRUPTIBLE);
-	if (!list_empty(&q.list)) {
-		unlock_futex_mm();
-		time = schedule_timeout(time);
+
+	if (unlikely(list_empty(&q.list))) {
+		/*
+		 * We were woken already.
+		 */
+		spin_unlock(&futex_lock);
+		set_current_state(TASK_RUNNING);
+		return 0;
 	}
-	set_current_state(TASK_RUNNING);
+
+	spin_unlock(&futex_lock);
+	time = schedule_timeout(time);
+
 	/*
 	 * NOTE: we don't remove ourselves from the waitqueue because
 	 * we are the only user of it.
 	 */
-	if (time == 0) {
-		ret = -ETIMEDOUT;
-		goto out;
-	}
+
+	/*
+	 * Were we woken or interrupted for a valid reason?
+	 */
+	ret = unqueue_me(&q);
+	if (ret == 0)
+		return 0;
+	if (time == 0)
+		return -ETIMEDOUT;
 	if (signal_pending(current))
-		ret = -EINTR;
-out:
-	/* Were we woken up anyway? */
+		return -EINTR;
+
+	/*
+	 * No, it was a spurious wakeup.  Try again.  Should never happen. :)
+	 */
+	goto try_again;
+
+ out_unqueue:
+	/*
+	 * Were we unqueued anyway?
+	 */
 	if (!unqueue_me(&q))
 		ret = 0;
-	put_page(q.page);
-
+ out_release_sem:
+	up_read(&current->mm->mmap_sem);
 	return ret;
 }
 
@@ -378,7 +396,6 @@ static int futex_close(struct inode *ino
 	struct futex_q *q = filp->private_data;
 
 	unqueue_me(q);
-	put_page(q->page);
 	kfree(filp->private_data);
 	return 0;
 }
@@ -408,10 +425,10 @@ static struct file_operations futex_fops
    set the sigio stuff up afterwards. */
 static int futex_fd(unsigned long uaddr, int offset, int signal)
 {
-	struct page *page = NULL;
 	struct futex_q *q;
+	unsigned long keys[2];
 	struct file *filp;
-	int ret;
+	int ret, err;
 
 	ret = -EINVAL;
 	if (signal < 0 || signal > _NSIG)
@@ -450,31 +467,25 @@ static int futex_fd(unsigned long uaddr,
 		goto out;
 	}
 
-	lock_futex_mm();
-
-	page = __pin_page(uaddr - offset);
-	if (!page) {
-		unlock_futex_mm();
+	down_read(&current->mm->mmap_sem);
+	err = __get_page_keys(uaddr - offset, keys);
+	up_read(&current->mm->mmap_sem);
 
+	if (unlikely(err != 0)) {
 		put_unused_fd(ret);
 		put_filp(filp);
 		kfree(q);
-		return -EFAULT;
+		return err;
 	}
 
 	init_waitqueue_head(&q->waiters);
 	filp->private_data = q;
 
-	__queue_me(q, page, uaddr, offset, ret, filp);
-
-	unlock_futex_mm();
+	queue_me(q, keys, uaddr, offset, ret, filp);
 
 	/* Now we map fd to filp, so userspace can access it */
 	fd_install(ret, filp);
-	page = NULL;
 out:
-	if (page)
-		put_page(page);
 	return ret;
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16361-linux-2.6.0-test4-bk6/mm/Makefile .16361-linux-2.6.0-test4-bk6.updated/mm/Makefile
--- .16361-linux-2.6.0-test4-bk6/mm/Makefile	2003-02-11 14:26:20.000000000 +1100
+++ .16361-linux-2.6.0-test4-bk6.updated/mm/Makefile	2003-09-05 14:54:31.000000000 +1000
@@ -9,6 +9,6 @@ mmu-$(CONFIG_MMU)	:= fremap.o highmem.o 
 
 obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
 			   page_alloc.o page-writeback.o pdflush.o readahead.o \
-			   slab.o swap.o truncate.o vcache.o vmscan.o $(mmu-y)
+			   slab.o swap.o truncate.o vmscan.o $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16361-linux-2.6.0-test4-bk6/mm/fremap.c .16361-linux-2.6.0-test4-bk6.updated/mm/fremap.c
--- .16361-linux-2.6.0-test4-bk6/mm/fremap.c	2003-09-05 09:16:38.000000000 +1000
+++ .16361-linux-2.6.0-test4-bk6.updated/mm/fremap.c	2003-09-05 14:54:31.000000000 +1000
@@ -144,7 +144,10 @@ long sys_remap_file_pages(unsigned long 
 		return err;
 #endif
 
-	down_read(&mm->mmap_sem);
+	/*
+	 * vm_flags is protected by down_write(mmap_sem)
+	 */
+	down_write(&mm->mmap_sem);
 
 	vma = find_vma(mm, start);
 	/*
@@ -155,12 +158,18 @@ long sys_remap_file_pages(unsigned long 
 	if (vma && (vma->vm_flags & VM_SHARED) &&
 		vma->vm_ops && vma->vm_ops->populate &&
 			end > start && start >= vma->vm_start &&
-				end <= vma->vm_end)
+				end <= vma->vm_end) {
+
+		vma->vm_flags |= VM_NONLINEAR;
+		if (start == vma->vm_start && end == vma->vm_end &&
+				pgoff == vma->vm_pgoff)
+			vma->vm_flags &= ~VM_NONLINEAR;
+		downgrade_write(&mm->mmap_sem);
 		err = vma->vm_ops->populate(vma, start, size, vma->vm_page_prot,
 				pgoff, flags & MAP_NONBLOCK);
-
-	up_read(&mm->mmap_sem);
-
+		up_read(&mm->mmap_sem);
+	} else {
+		up_write(&mm->mmap_sem);
+	}
 	return err;
 }
-
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16361-linux-2.6.0-test4-bk6/mm/memory.c .16361-linux-2.6.0-test4-bk6.updated/mm/memory.c
--- .16361-linux-2.6.0-test4-bk6/mm/memory.c	2003-09-05 09:16:38.000000000 +1000
+++ .16361-linux-2.6.0-test4-bk6.updated/mm/memory.c	2003-09-05 14:54:31.000000000 +1000
@@ -43,7 +43,6 @@
 #include <linux/swap.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
-#include <linux/vcache.h>
 #include <linux/rmap-locking.h>
 #include <linux/module.h>
 
@@ -962,7 +961,6 @@ static inline void establish_pte(struct 
 static inline void break_cow(struct vm_area_struct * vma, struct page * new_page, unsigned long address, 
 		pte_t *page_table)
 {
-	invalidate_vcache(address, vma->vm_mm, new_page);
 	flush_cache_page(vma, address);
 	establish_pte(vma, address, page_table, pte_mkwrite(pte_mkdirty(mk_pte(new_page, vma->vm_page_prot))));
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16361-linux-2.6.0-test4-bk6/mm/vcache.c .16361-linux-2.6.0-test4-bk6.updated/mm/vcache.c
--- .16361-linux-2.6.0-test4-bk6/mm/vcache.c	2003-01-02 12:30:47.000000000 +1100
+++ .16361-linux-2.6.0-test4-bk6.updated/mm/vcache.c	1970-01-01 10:00:00.000000000 +1000
@@ -1,90 +0,0 @@
-/*
- *  linux/mm/vcache.c
- *
- *  virtual => physical page mapping cache. Users of this mechanism
- *  register callbacks for a given (virt,mm,phys) page mapping, and
- *  the kernel guarantees to call back when this mapping is invalidated.
- *  (ie. upon COW or unmap.)
- *
- *  Started by Ingo Molnar, Copyright (C) 2002
- */
-
-#include <linux/mm.h>
-#include <linux/init.h>
-#include <linux/hash.h>
-#include <linux/vcache.h>
-
-#define VCACHE_HASHBITS 8
-#define VCACHE_HASHSIZE (1 << VCACHE_HASHBITS)
-
-spinlock_t vcache_lock = SPIN_LOCK_UNLOCKED;
-
-static struct list_head hash[VCACHE_HASHSIZE];
-
-static struct list_head *hash_vcache(unsigned long address,
-					struct mm_struct *mm)
-{
-        return &hash[hash_long(address + (unsigned long)mm, VCACHE_HASHBITS)];
-}
-
-void __attach_vcache(vcache_t *vcache,
-		unsigned long address,
-		struct mm_struct *mm,
-		void (*callback)(struct vcache_s *data, struct page *new))
-{
-	struct list_head *hash_head;
-
-	address &= PAGE_MASK;
-	vcache->address = address;
-	vcache->mm = mm;
-	vcache->callback = callback;
-
-	hash_head = hash_vcache(address, mm);
-
-	list_add_tail(&vcache->hash_entry, hash_head);
-}
-
-void __detach_vcache(vcache_t *vcache)
-{
-	list_del_init(&vcache->hash_entry);
-}
-
-void invalidate_vcache(unsigned long address, struct mm_struct *mm,
-				struct page *new_page)
-{
-	struct list_head *l, *hash_head;
-	vcache_t *vcache;
-
-	address &= PAGE_MASK;
-
-	hash_head = hash_vcache(address, mm);
-	/*
-	 * This is safe, because this path is called with the pagetable
-	 * lock held. So while other mm's might add new entries in
-	 * parallel, *this* mm is locked out, so if the list is empty
-	 * now then we do not have to take the vcache lock to see it's
-	 * really empty.
-	 */
-	if (likely(list_empty(hash_head)))
-		return;
-
-	spin_lock(&vcache_lock);
-	list_for_each(l, hash_head) {
-		vcache = list_entry(l, vcache_t, hash_entry);
-		if (vcache->address != address || vcache->mm != mm)
-			continue;
-		vcache->callback(vcache, new_page);
-	}
-	spin_unlock(&vcache_lock);
-}
-
-static int __init vcache_init(void)
-{
-        unsigned int i;
-
-	for (i = 0; i < VCACHE_HASHSIZE; i++)
-		INIT_LIST_HEAD(hash + i);
-	return 0;
-}
-__initcall(vcache_init);
-

Name: Minor Tweaks To Jamie Lokier's Futex Patch
Author: Rusty Russell
Status: Booted on 2.6.0-test4-bk6
Depends: Misc/futex-jamie.patch.gz

D: Minor changes to Jamie's excellent futex patch.
D: 1) Declare and use a union for the hash key, and rename __get_page_keys
D:    to get_page_key.
D: 2) Remove obsolete comment above hash array decl.
D: 3) Simply -EFAULT on futexes in VSYSCALL area.
D: 4) Clarify comment about TASK_INTERRUPTIBLE.
D: 5) Andrew Morton says spurious wakeup is a bug.  Catch it.
D: 6) Semantics of futex on read-only pages unclear: require write perm.
D: 7) Use Jenkins hash.
D: 8) Make get_page_keys return 0 on successful get_user_pages().

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10155-linux-2.6.0-test4-bk6/kernel/futex.c .10155-linux-2.6.0-test4-bk6.updated/kernel/futex.c
--- .10155-linux-2.6.0-test4-bk6/kernel/futex.c	2003-09-05 12:31:41.000000000 +1000
+++ .10155-linux-2.6.0-test4-bk6.updated/kernel/futex.c	2003-09-05 14:28:03.000000000 +1000
@@ -33,13 +33,38 @@
 #include <linux/poll.h>
 #include <linux/fs.h>
 #include <linux/file.h>
-#include <linux/hash.h>
+#include <linux/jhash.h>
 #include <linux/init.h>
 #include <linux/futex.h>
 #include <linux/mount.h>
 
 #define FUTEX_HASHBITS 8
 
+/* For shared mappings, comparison key is
+ * "vma->vm_file->f_dentry->d_inode" and "page->index".  For private
+ * mappings, it's "current->mm" and "addr".  We can usually work out
+ * the index without swapping in the page.
+ * Note that they never clash: mm and inode ptrs cannot be equal.
+ */
+struct private_key
+{
+	struct mm_struct *mm;
+	unsigned long uaddr;
+};
+
+struct shared_key
+{
+	struct inode *inode;
+	unsigned long page_index;
+};
+
+union hash_key
+{
+	struct private_key private;
+	struct shared_key shared;
+	unsigned long raw[2];
+};
+
 /*
  * We use this hashed waitqueue instead of a normal wait_queue_t, so
  * we can wake only the relevant ones (hashed queues may be shared):
@@ -49,7 +74,7 @@ struct futex_q {
 	wait_queue_head_t waiters;
 
 	/* Page keys and offset within the page. */
-	unsigned long keys[2];
+	union hash_key key;
 	int offset;
 
 	/* For fd, sigio sent using these. */
@@ -57,7 +82,6 @@ struct futex_q {
 	struct file *filp;
 };
 
-/* The key for the hash is the address + index + offset within page */
 static struct list_head futex_queues[1<<FUTEX_HASHBITS];
 static spinlock_t futex_lock = SPIN_LOCK_UNLOCKED;
 
@@ -65,31 +89,29 @@ static spinlock_t futex_lock = SPIN_LOCK
 static struct vfsmount *futex_mnt;
 
 /*
- * We hash on the keys returned from __get_page_keys (see below),
+ * We hash on the keys returned from get_page_key (see below),
  * and the offset into the page.
  */
-static inline struct list_head *hash_futex(unsigned long key0,
-					   unsigned long key1,
+static inline struct list_head *hash_futex(const union hash_key *key,
 					   int offset)
 {
-	return &futex_queues[hash_long(key0 + key1 + offset, FUTEX_HASHBITS)];
+	u32 hash = jhash2((u32*)key, sizeof(*key)/sizeof(u32), offset);
+
+	/* Just in case someone changes something... */
+	BUILD_BUG_ON(sizeof(*key) % sizeof(u32) != 0);
+	return &futex_queues[hash & ((1<<FUTEX_HASHBITS)-1)];
 }
 
 /*
  * Get two parameters which are the keys for a futex
  * other than the offset within page.
  *
- * For shared mappings, it's "vma->vm_file->f_dentry->d_inode" and
- * "page->index".  For private mappings, it's "current->mm" and "addr".
- * We can usually work out the index without swapping in the page.
- *
  * Returns: 0, or negative error code.
- * The two key words are stored in key[0] and key[1] on success.
  *
  * Should be called with &current->mm->mmap_sem,
  * but NOT &futex_lock or &current->mm->page_table_lock.
  */
-static int __get_page_keys(unsigned long addr, unsigned long * keys)
+static int get_page_key(unsigned long addr, union hash_key *key)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
@@ -102,38 +124,32 @@ static int __get_page_keys(unsigned long
 	 */
 	vma = find_extend_vma(mm, addr);
 
-	if (unlikely(!vma)) {
-#ifdef FIXADDR_USER_START
-		if (addr >= FIXADDR_USER_START && addr < FIXADDR_USER_END) {
-			keys[0] = 1; /* Different from any pointer value. */
-			keys[1] = addr - FIXADDR_USER_START;
-			return 0;
-		}
-#endif
+	if (unlikely(!vma))
 		return -EFAULT;
-	}
 
 	/*
 	 * Permissions.
 	 */
-	if (unlikely((vma->vm_flags & (VM_IO|VM_READ)) != VM_READ))
+	if (unlikely((vma->vm_flags & (VM_IO|VM_READ|VM_WRITE))
+		     != (VM_READ | VM_WRITE)))
 		return -EFAULT;
 
 	/*
 	 * Private mappings are handled in a simple way.
 	 */
-	if (likely(!(vma->vm_flags & VM_SHARED))) {
-		keys[0] = (unsigned long) mm;
-		keys[1] = addr;
+	if (!(vma->vm_flags & VM_SHARED)) {
+		key->private.mm = mm;
+		key->private.uaddr = (addr & PAGE_MASK);
 		return 0;
 	}
 
 	/*
 	 * Linear mappings are also simple.
 	 */
-	keys[0] = (unsigned long) vma->vm_file->f_dentry->d_inode;
+	key->shared.inode = vma->vm_file->f_dentry->d_inode;
 	if (likely(!(vma->vm_flags & VM_NONLINEAR))) {
-		keys[1] = (((addr - vma->vm_start) >> PAGE_SHIFT)
+		key->shared.page_index
+			= (((addr - vma->vm_start) >> PAGE_SHIFT)
 			   + vma->vm_pgoff);
 		return 0;
 	}
@@ -151,7 +167,7 @@ static int __get_page_keys(unsigned long
 	spin_lock(&current->mm->page_table_lock);
 	page = follow_page(mm, addr, 0);
 	if (likely(page != NULL)) {
-		keys[1] = page->index;
+		key->shared.page_index = page->index;
 		spin_unlock(&current->mm->page_table_lock);
 		return 0;
 	}
@@ -161,11 +177,11 @@ static int __get_page_keys(unsigned long
 	 * Do it the general way.
 	 */
 	err = get_user_pages(current, mm, addr, 1, 0, 0, &page, NULL);
-	if (err >= 0) {
-		keys[1] = page->index;
-		put_page(page);
-	}
-	return err;
+	if (err < 0)
+		return err;
+	key->shared.page_index = page->index;
+	put_page(page);
+	return 0;
 }
 
 
@@ -176,24 +192,24 @@ static int __get_page_keys(unsigned long
 static inline int futex_wake(unsigned long uaddr, int offset, int num)
 {
 	struct list_head *i, *next, *head;
-	unsigned long keys[2];
+	union hash_key key;
 	int ret;
 
 	down_read(&current->mm->mmap_sem);
 
-	ret = __get_page_keys(uaddr - offset, keys);
+	ret = get_page_key(uaddr - offset, &key);
 	if (unlikely(ret != 0))
 		goto out;
 
-	head = hash_futex(keys[0], keys[1], offset);
+	head = hash_futex(&key, offset);
 
 	spin_lock(&futex_lock);
 	list_for_each_safe(i, next, head) {
 		struct futex_q *this = list_entry(i, struct futex_q, list);
 
-		if (this->keys[0] == keys[0] && this->keys[1] == keys[1]
+		if (this->key.raw[0] == key.raw[0]
+		    && this->key.raw[1] == key.raw[1]
 		    && this->offset == offset) {
-
 			list_del_init(i);
 			wake_up_all(&this->waiters);
 			if (this->filp)
@@ -218,28 +234,28 @@ static inline int futex_requeue(unsigned
 	unsigned long uaddr2, int offset2, int nr_wake, int nr_requeue)
 {
 	struct list_head *i, *next, *head1, *head2;
-	unsigned long keys1[2], keys2[2];
+	union hash_key key1, key2;
 	int ret;
 
 	down_read(&current->mm->mmap_sem);
 
-	ret = __get_page_keys(uaddr1 - offset1, keys1);
+	ret = get_page_key(uaddr1 - offset1, &key1);
 	if (unlikely(ret != 0))
 		goto out;
-	ret = __get_page_keys(uaddr2 - offset2, keys2);
+	ret = get_page_key(uaddr2 - offset2, &key2);
 	if (unlikely(ret != 0))
 		goto out;
 
-	head1 = hash_futex(keys1[0], keys1[1], offset1);
-	head2 = hash_futex(keys2[0], keys2[1], offset2);
+	head1 = hash_futex(&key1, offset1);
+	head2 = hash_futex(&key2, offset2);
 
 	spin_lock(&futex_lock);
 	list_for_each_safe(i, next, head1) {
 		struct futex_q *this = list_entry(i, struct futex_q, list);
 
-		if (this->keys[0] == keys1[0] && this->keys[1] == keys1[1]
+		if (this->key.raw[0] == key1.raw[0]
+		    && this->key.raw[1] == key1.raw[1]
 		    && this->offset == offset1) {
-
 			list_del_init(i);
 			if (++ret <= nr_wake) {
 				wake_up_all(&this->waiters);
@@ -248,8 +264,7 @@ static inline int futex_requeue(unsigned
 							this->fd, POLL_IN);
 			} else {
 				list_add_tail(i, head2);
-				this->keys[0] = keys2[0];
-				this->keys[1] = keys2[1];
+				this->key = key2;
 				this->offset = offset2;
 				if (ret - nr_wake >= nr_requeue)
 					break;
@@ -263,14 +278,13 @@ out:
 	return ret;
 }
 
-static inline void queue_me(struct futex_q *q, unsigned long *keys,
+static inline void queue_me(struct futex_q *q, union hash_key *key,
 			    unsigned long uaddr, int offset,
 			    int fd, struct file *filp)
 {
-	struct list_head *head = hash_futex(keys[0], keys[1], offset);
+	struct list_head *head = hash_futex(key, offset);
 
-	q->keys[0] = keys[0];
-	q->keys[1] = keys[1];
+	q->key = *key;
 	q->offset = offset;
 	q->fd = fd;
 	q->filp = filp;
@@ -301,19 +315,18 @@ static inline int futex_wait(unsigned lo
 {
 	DECLARE_WAITQUEUE(wait, current);
 	int ret, curval;
-	unsigned long keys[2];
+	union hash_key key;
 	struct futex_q q;
 
- try_again:
 	init_waitqueue_head(&q.waiters);
 
 	down_read(&current->mm->mmap_sem);
 
-	ret = __get_page_keys(uaddr - offset, keys);
+	ret = get_page_key(uaddr - offset, &key);
 	if (unlikely(ret != 0))
 		goto out_release_sem;
 
-	queue_me(&q, keys, uaddr, offset, -1, NULL);
+	queue_me(&q, &key, uaddr, offset, -1, NULL);
 
 	/*
 	 * Access the page after the futex is queued.
@@ -338,10 +351,10 @@ static inline int futex_wait(unsigned lo
 	/*
 	 * There might have been scheduling since the queue_me(), as we
 	 * cannot hold a spinlock across the get_user() in case it
-	 * faults.  So we cannot just set TASK_INTERRUPTIBLE state when
+	 * faults, and we cannot just set TASK_INTERRUPTIBLE state when
 	 * queueing ourselves into the futex hash.  This code thus has to
-	 * rely on the futex_wake() code doing a wakeup after removing
-	 * the waiter from the list.
+	 * rely on the futex_wake() code removing us from hash when it
+	 * wakes us up.
 	 */
 	add_wait_queue(&q.waiters, &wait);
 	spin_lock(&futex_lock);
@@ -364,26 +377,19 @@ static inline int futex_wait(unsigned lo
 	 * we are the only user of it.
 	 */
 
-	/*
-	 * Were we woken or interrupted for a valid reason?
-	 */
-	ret = unqueue_me(&q);
-	if (ret == 0)
+	/* If we were woken (and unqueued), we succeeded, whatever. */
+	if (!unqueue_me(&q))
 		return 0;
 	if (time == 0)
 		return -ETIMEDOUT;
 	if (signal_pending(current))
 		return -EINTR;
 
-	/*
-	 * No, it was a spurious wakeup.  Try again.  Should never happen. :)
-	 */
-	goto try_again;
+	/* A spurious wakeup.  Should never happen. */
+	BUG();
 
  out_unqueue:
-	/*
-	 * Were we unqueued anyway?
-	 */
+	/* If we were woken (and unqueued), we succeeded, whatever. */
 	if (!unqueue_me(&q))
 		ret = 0;
  out_release_sem:
@@ -426,7 +432,7 @@ static struct file_operations futex_fops
 static int futex_fd(unsigned long uaddr, int offset, int signal)
 {
 	struct futex_q *q;
-	unsigned long keys[2];
+	union hash_key key;
 	struct file *filp;
 	int ret, err;
 
@@ -468,7 +474,7 @@ static int futex_fd(unsigned long uaddr,
 	}
 
 	down_read(&current->mm->mmap_sem);
-	err = __get_page_keys(uaddr - offset, keys);
+	err = get_page_key(uaddr - offset, &key);
 	up_read(&current->mm->mmap_sem);
 
 	if (unlikely(err != 0)) {
@@ -481,7 +487,7 @@ static int futex_fd(unsigned long uaddr,
 	init_waitqueue_head(&q->waiters);
 	filp->private_data = q;
 
-	queue_me(q, keys, uaddr, offset, ret, filp);
+	queue_me(q, &key, uaddr, offset, ret, filp);
 
 	/* Now we map fd to filp, so userspace can access it */
 	fd_install(ret, filp);
