Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbTICHhe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 03:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbTICHhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 03:37:34 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:44683 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261542AbTICHhB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 03:37:01 -0400
Date: Wed, 3 Sep 2003 08:36:28 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Alternate futex non-page-pinning and COW fix
Message-ID: <20030903073628.GA19920@mail.jlokier.co.uk>
References: <Pine.LNX.4.44.0309021626540.1542-100000@localhost.localdomain> <20030903025605.5C1722C05F@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903025605.5C1722C05F@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> The physical page is a relic from my original implementation, which
> did "pin page and hash on it".  Life was simple and good, and then
> came FUTEX_FD (which allows more than one futex per process) and
> before Ingo found the COW issue, and added the vcache stuff.

Hi Rusty,

You will be please to know I have written a complete patch :)

> Assume that we do:
> 1) Look up vma.
> 2) If vma->vm_flags & VM_SHARED, index by page->mapping & page->index.
> 3) Otherwise, index by vma->vm_mm & uaddr.

Like that, but 2) uses vma->vm_file->f_dentry->d_inode.

That way, there is no need to walk the page table at all unless it's a
non-linear mapping (which my patch does handle).

> Questions:
> 1) What is the difference between VM_SHARED and VM_MAYSHARE?  They
>    always seem to be set/reset together.

Good question.  No kernel code seems to check VM_MAYSHARE - the one to
check is VM_SHARED.

> 2) If VM_SHARED, and page->mapping is NULL, what to do?  AFAICT, this
>    can happen in the case of anonymous shared mappings, say mmap
>    /dev/zero MAP_SHARED and fork()? Treating it as !VM_SHARED (and
>    hence matching in mm & uaddr) won't work, since the mm's will be
>    different (and with mremap, the uaddrs may be different).

No, that doesn't happen.  An anoymous shared mapping calls
shmem_zero_setup(), which creates an anonymous tmpfs file to back the
mapping.  It then looks the same as IPC shm or any other tmpfs file.

So it works :)

> 3) Since we need the offset in the file anyway for the VM_SHARED, it
>    makes more sense to use get_user_pages() to get the vma and page in
>    one call, rather than find_extend_vma().

You need the offset, but you don't need the page.  For a linear
mapping, the offset is a very simple calculation - no page table lock
and no page table walk.  As a silly bonus it doesn't touch the page.

For non-linear mappings, I try follow_page() and then
get_user_pages(), as usual, to get page->index.  Technically you don't
need to swap the page in, but there's no point using complicated code
for that unimportant case.

I added a flag VM_NONLINEAR to distinguish them.

> 4) mremap on a futex: same case as munmap, it's undefined behavior.  A
>    correct program will need to re-wait on the futex anyway.
> 
> BTW, the other solution to the COW problem which Ingo thought about (I
> was away on my honeymoon), was to have the child always get the copied
> page, even if the parent caused the COW fault.  If you also always
> un-COW the page in FUTEX_WAIT, this scheme works.  IIRC he said the
> implementation was icky.

That's icky in a lot of ways, including unnecessary un-COWing.

I have an obvious fix for mremap(): rehash all the futexes in its
range.  That's not in the attached patch, but it will be in the next one.

Please take a look at the patch and see what you think.  I have tried
some basic tests with it (playing with your futex-2.2 lib, and Red Hat
9 uses plenty of futexes while booting & running too).

Patch is against 2.6.0-test4.  Net reduction of about 100 lines from
test4, too :)

Thanks,
-- Jamie

   ===========================================

include/linux/mm.h     |    1
include/linux/vcache.h |   26 ---
kernel/futex.c         |  368 +++++++++++++++++++++++++------------------------
mm/Makefile            |    2
mm/fremap.c            |    9 +
mm/memory.c            |    2
mm/vcache.c            |   90 -----------
7 files changed, 200 insertions(+), 298 deletions(-)

Patch name: futex-fixes-2.6.0-test4-01jl

This patch changes the way futexes are indexed, so that they do not
pin pages and also corrects some problems with private mappings and COW
pages.

Currently, all futexes look up the page at the userspace address and
pin it, using the pair (page,offset) as an index into a table of
waiting futexes.  Any page with a futex waiting on it remains pinned
in RAM, which is a problem when many futexes are used, especially with
FUTEX_FD.

Another problem is that the page is not always the correct one, if it
can be changed later by a COW (copy on write) operation.  This can
happen when waiting on a futex without writing to it after fork(),
exec() or mmap(), if the page is then written to before attempting to
wake a futex at the same adress.

There are two symptoms of the COW problem: 1. The wrong process can
receive wakeups; 2. A process can fail to receive required wakeups.

This patch fixes both by changing the indexing so that VM_SHARED
mappings use the triple (inode,offset,index), and private mappings use
the pair (mm,virtual_address).

The former correctly handles all shared mappings, including tmpfs and
therefore all kinds of shared memory (IPC shm, /dev/shm and
MAP_ANON|MAP_SHARED).  This works because every mapping which is
VM_SHARED has an associated non-zero vma->vm_file, and hence inode.
(This is ensured in do_mmap_pgoff, where it calls shmem_zero_setup).

The latter handles all private mappings, both files and anonymous.  It
isn't affected by COW, because it doesn't care about the actual pages,
just the virtual address.

The only obvious problem is that mremap() can move a private mapping
without informing futexes waiting on that mapping.  However, mremap()
was already broken with futexes, because it doesn't update the vcache,
which is used by futexes, so this just changes an existing bug.

(A later patch from me will fix this problem with mremap(), by moving
the futexes).

This patch has a few bonuses:

	1. It removes the vcache implementation, as only futexes were
	   using it, and they don't any more.

	2. Removing the vcache should make COW page faults a bit faster.

	3. Futex operations no longer take the page table lock, walk
	   the page table, fault in pages that aren't mapped in the
	   page table, or do a vcache hash lookup - they are mostly a
	   simple offset calculation with one hash for the futex
	   table.  So they should be noticably faster.

	4. The patch reduces the kernel size by 98 lines.

-- Jamie

           ==========================

diff -urN --exclude-from=dontdiff orig-2.6.0-test4/include/linux/mm.h laptop-2.6.0-test4/include/linux/mm.h
--- orig-2.6.0-test4/include/linux/mm.h	2003-09-02 23:06:10.000000000 +0100
+++ laptop-2.6.0-test4/include/linux/mm.h	2003-09-02 23:06:10.000000000 +0100
@@ -110,6 +110,7 @@
 #define VM_RESERVED	0x00080000	/* Don't unmap it from swap_out */
 #define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
 #define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
+#define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
 
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
diff -urN --exclude-from=dontdiff orig-2.6.0-test4/include/linux/vcache.h laptop-2.6.0-test4/include/linux/vcache.h
--- orig-2.6.0-test4/include/linux/vcache.h	2003-07-08 21:44:12.000000000 +0100
+++ laptop-2.6.0-test4/include/linux/vcache.h	1970-01-01 01:00:00.000000000 +0100
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
diff -urN --exclude-from=dontdiff orig-2.6.0-test4/kernel/futex.c laptop-2.6.0-test4/kernel/futex.c
--- orig-2.6.0-test4/kernel/futex.c	2003-07-08 21:44:25.000000000 +0100
+++ laptop-2.6.0-test4/kernel/futex.c	2003-09-03 06:07:22.922779181 +0100
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
@@ -32,7 +35,6 @@
 #include <linux/hash.h>
 #include <linux/init.h>
 #include <linux/futex.h>
-#include <linux/vcache.h>
 #include <linux/mount.h>
 
 #define FUTEX_HASHBITS 8
@@ -45,13 +47,10 @@
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
@@ -67,85 +66,110 @@
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
+
+	/*
+	 * Permissions.
+	 */
+	if (unlikely((vma->vm_flags & (VM_IO|VM_READ)) != VM_READ))
+		return -EFAULT;
 
 	/*
-	 * No luck - need to fault in the page:
+	 * Private mappings are handled in a simple way.
 	 */
-repeat_lookup:
+	if (likely(!(vma->vm_flags & VM_SHARED))) {
+		keys[0] = (unsigned long) mm;
+		keys[1] = addr;
+		return 0;
+	}
 
-	unlock_futex_mm();
+	/*
+	 * Linear mappings are also simple.
+	 */
+	keys[0] = (unsigned long) vma->vm_file->f_dentry->d_inode;
+	if (likely(!(vma->vm_flags & VM_NONLINEAR))) {
+		keys[1] = (((addr - vma->vm_start) >> PAGE_SHIFT)
+			   + vma->vm_pgoff);
+		return 0;
+	}
 
-	down_read(&mm->mmap_sem);
-	err = get_user_pages(current, mm, addr, 1, 0, 0, &page, NULL);
-	up_read(&mm->mmap_sem);
+	/*
+	 * We could walk the page table to read the non-linear
+	 * pte, and get the page index without fetching the page
+	 * from swap.  But that's a lot of code to duplicate here
+	 * for a rare case, so we simply fetch the page.
+	 */
 
-	lock_futex_mm();
+	/*
+	 * Do a quick atomic lookup first - this is the fastpath.
+	 */
+	spin_lock(&current->mm->page_table_lock);
+	page = follow_page(mm, addr, 0);
+	if (likely(page != NULL)) {
+		keys[1] = page->index;
+		spin_unlock(&current->mm->page_table_lock);
+		return 0;
+	}
+	spin_unlock(&current->mm->page_table_lock);
 
-	if (err < 0)
-		return NULL;
 	/*
-	 * Since the faulting happened with locks released, we have to
-	 * check for races:
+	 * Do it the general way.
 	 */
-	tmp = follow_page(mm, addr, 0);
-	if (tmp != page) {
+	err = get_user_pages(current, mm, addr, 1, 0, 0, &page, NULL);
+	if (err >= 0) {
+		keys[1] = page->index;
 		put_page(page);
-		goto repeat_lookup;
 	}
-
-	return page;
+	return err;
 }
 
+
 /*
  * Wake up all waiters hashed on the physical page that is mapped
  * to this virtual address:
@@ -153,25 +177,25 @@
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
@@ -180,38 +204,14 @@
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
@@ -219,74 +219,66 @@
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
+	ret = __get_page_keys(uaddr2 - offset1, keys1);
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
@@ -294,15 +286,12 @@
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
 
@@ -312,65 +301,95 @@
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
+
+	spin_unlock(&futex_lock);
+	time = schedule_timeout(time);
 	set_current_state(TASK_RUNNING);
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
 
@@ -379,7 +398,6 @@
 	struct futex_q *q = filp->private_data;
 
 	unqueue_me(q);
-	put_page(q->page);
 	kfree(filp->private_data);
 	return 0;
 }
@@ -409,10 +427,10 @@
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
@@ -451,31 +469,25 @@
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
 
diff -urN --exclude-from=dontdiff orig-2.6.0-test4/mm/fremap.c laptop-2.6.0-test4/mm/fremap.c
--- orig-2.6.0-test4/mm/fremap.c	2003-07-08 21:44:29.000000000 +0100
+++ laptop-2.6.0-test4/mm/fremap.c	2003-09-03 03:00:30.000000000 +0100
@@ -151,9 +151,16 @@
 	if (vma && (vma->vm_flags & VM_SHARED) &&
 		vma->vm_ops && vma->vm_ops->populate &&
 			end > start && start >= vma->vm_start &&
-				end <= vma->vm_end)
+				end <= vma->vm_end) {
+
+		if (start != vma->vm_start || end != vma->vm_end)
+			vma->vm_flags |= VM_NONLINEAR;
+		else
+			vma->vm_flags &= ~VM_NONLINEAR;
+
 		err = vma->vm_ops->populate(vma, start, size, vma->vm_page_prot,
 				pgoff, flags & MAP_NONBLOCK);
+	}
 
 	up_read(&mm->mmap_sem);
 
diff -urN --exclude-from=dontdiff orig-2.6.0-test4/mm/Makefile laptop-2.6.0-test4/mm/Makefile
--- orig-2.6.0-test4/mm/Makefile	2003-07-08 21:44:29.000000000 +0100
+++ laptop-2.6.0-test4/mm/Makefile	2003-09-03 04:42:46.000000000 +0100
@@ -9,6 +9,6 @@
 
 obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
 			   page_alloc.o page-writeback.o pdflush.o readahead.o \
-			   slab.o swap.o truncate.o vcache.o vmscan.o $(mmu-y)
+			   slab.o swap.o truncate.o vmscan.o $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
diff -urN --exclude-from=dontdiff orig-2.6.0-test4/mm/memory.c laptop-2.6.0-test4/mm/memory.c
--- orig-2.6.0-test4/mm/memory.c	2003-09-02 23:06:13.000000000 +0100
+++ laptop-2.6.0-test4/mm/memory.c	2003-09-03 04:49:10.000000000 +0100
@@ -43,7 +43,6 @@
 #include <linux/swap.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
-#include <linux/vcache.h>
 #include <linux/rmap-locking.h>
 
 #include <asm/pgalloc.h>
@@ -960,7 +959,6 @@
 static inline void break_cow(struct vm_area_struct * vma, struct page * new_page, unsigned long address, 
 		pte_t *page_table)
 {
-	invalidate_vcache(address, vma->vm_mm, new_page);
 	flush_cache_page(vma, address);
 	establish_pte(vma, address, page_table, pte_mkwrite(pte_mkdirty(mk_pte(new_page, vma->vm_page_prot))));
 }
diff -urN --exclude-from=dontdiff orig-2.6.0-test4/mm/vcache.c laptop-2.6.0-test4/mm/vcache.c
--- orig-2.6.0-test4/mm/vcache.c	2003-07-08 21:44:31.000000000 +0100
+++ laptop-2.6.0-test4/mm/vcache.c	1970-01-01 01:00:00.000000000 +0100
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
