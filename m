Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263840AbTH1Ims (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 04:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263882AbTH1Imr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 04:42:47 -0400
Received: from dp.samba.org ([66.70.73.150]:45004 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263840AbTH1IEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 04:04:04 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Hugh Dickins <hugh@veritas.com>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix 
In-reply-to: Your message of "Wed, 27 Aug 2003 09:37:25 +0100."
             <Pine.LNX.4.44.0308270846580.2063-100000@localhost.localdomain> 
Date: Thu, 28 Aug 2003 18:03:26 +1000
Message-Id: <20030828080403.F3DF52C899@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0308270846580.2063-100000@localhost.localdomain> you write:
> But I do not understand how futex_wake can still be doing a
> this->page == page test: its __pin_page will ensure that some
> page is faulted in, but that's not necessarily the same page
> as in this->page.

Yeah, my complete screwup.  See below, with new routine
page_matches().

> I strongly agree with Andrew that add_to_swap and
> delete_from_swap_cache (probably the one without the __s)
> are the places for switching the anonymous, not page_io.c:
> page->mapping will be set and unset in those, and it's
> page->mapping that you're keying off in hash_futex.

Agreed, it's simplest, at least, to call futex_rehash every time
->mapping changes.  But that's alot, so we'll need that futex
page->flags optimization.

I've included 3 patches and my test code.  This includes debugging
output, so it's not a final patch.

The test code sets up 3 futexes (one in a file-backed mmap, one in a
malloc, and one in a shared memory segment), then runs through <N> MB
forcing things to swap.  When you see the kernel message saying a
futex has been swapped out, press Enter and it will wake the futexes.
A successful run looks like (it can take a few attempts before the
futex gets swapped out, depending on the phase of the moon):

  test:~# swapon /swap
  Adding 14992k swap on /swap.  Priority:-1 extents:82
  test:~# ./test-swap2 36
  MMAP=8, SHM=16, ANON=24, beginning chill...
  .
  futex_rehash 13370: offset 24 00000000 -> 902bd100
  
  Exiting...
  Waking up 0x30012008
  Waking up 0x804c018
  Waking up 0x30013010
  test:~# 

Thanks for feedback,
Rusty
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Minor futex comment tweaks and cleanups
Author: Rusty Russell
Status: Booted on 2.6.0-test4-bk2

D: Changes:
D: 
D: (1) don't return 0 from futex_wait if we are somehow
D:     spuriously woken up, loop in that case.
D: 
D: (2) remove bogus comment about address no longer being in this
D:     address space: we hold the mm lock, and __pin_page succeeded, so it
D:     can't be true, 
D: 
D: (3) remove bogus comment about "get_user might fault and schedule", 
D: 
D: (4) clarify comment about hashing: we hash address of struct page,
D:     not page itself,
D: 
D: (4) remove list_empty check: we still hold the lock, so it can
D:     never happen, and
D: 
D: (5) single error exit path, and move __queue_me to the end (order
D:     doesn't matter since we're inside the futex lock).

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9416-linux-2.6.0-test4-bk2/kernel/futex.c .9416-linux-2.6.0-test4-bk2.updated/kernel/futex.c
--- .9416-linux-2.6.0-test4-bk2/kernel/futex.c	2003-05-27 15:02:23.000000000 +1000
+++ .9416-linux-2.6.0-test4-bk2.updated/kernel/futex.c	2003-08-27 12:34:53.000000000 +1000
@@ -84,9 +84,7 @@ static inline void unlock_futex_mm(void)
 	spin_unlock(&current->mm->page_table_lock);
 }
 
-/*
- * The physical page is shared, so we can hash on its address:
- */
+/* The struct page is shared, so we can hash on its address. */
 static inline struct list_head *hash_futex(struct page *page, int offset)
 {
 	return &futex_queues[hash_long((unsigned long)page + offset,
@@ -311,67 +309,68 @@ static inline int futex_wait(unsigned lo
 		      int val,
 		      unsigned long time)
 {
-	DECLARE_WAITQUEUE(wait, current);
-	int ret = 0, curval;
+	wait_queue_t wait;
+	int ret, curval;
 	struct page *page;
 	struct futex_q q;
 
+again:
 	init_waitqueue_head(&q.waiters);
+	init_waitqueue_entry(&wait, current);
 
 	lock_futex_mm();
 
 	page = __pin_page(uaddr - offset);
 	if (!page) {
-		unlock_futex_mm();
-		return -EFAULT;
+		ret = -EFAULT;
+		goto unlock;
 	}
-	__queue_me(&q, page, uaddr, offset, -1, NULL);
 
 	/*
-	 * Page is pinned, but may no longer be in this address space.
+	 * Page is pinned, but may be a kernel address.
 	 * It cannot schedule, so we access it with the spinlock held.
 	 */
 	if (get_user(curval, (int *)uaddr) != 0) {
-		unlock_futex_mm();
 		ret = -EFAULT;
-		goto out;
+		goto unlock;
 	}
+
 	if (curval != val) {
-		unlock_futex_mm();
 		ret = -EWOULDBLOCK;
-		goto out;
+		goto unlock;
 	}
-	/*
-	 * The get_user() above might fault and schedule so we
-	 * cannot just set TASK_INTERRUPTIBLE state when queueing
-	 * ourselves into the futex hash. This code thus has to
-	 * rely on the futex_wake() code doing a wakeup after removing
-	 * the waiter from the list.
-	 */
+
+	__queue_me(&q, page, uaddr, offset, -1, NULL);
 	add_wait_queue(&q.waiters, &wait);
 	set_current_state(TASK_INTERRUPTIBLE);
-	if (!list_empty(&q.list)) {
-		unlock_futex_mm();
-		time = schedule_timeout(time);
-	}
+	unlock_futex_mm();
+
+	time = schedule_timeout(time);
+
 	set_current_state(TASK_RUNNING);
 	/*
 	 * NOTE: we don't remove ourselves from the waitqueue because
 	 * we are the only user of it.
 	 */
-	if (time == 0) {
-		ret = -ETIMEDOUT;
-		goto out;
-	}
-	if (signal_pending(current))
-		ret = -EINTR;
-out:
-	/* Were we woken up anyway? */
+	put_page(q.page);
+
+	/* Were we woken up (and removed from queue)?  Always return
+	 * success when this happens. */
 	if (!unqueue_me(&q))
 		ret = 0;
-	put_page(q.page);
+	else if (time == 0)
+		ret = -ETIMEDOUT;
+	else if (signal_pending(current))
+		ret = -EINTR;
+	else
+		/* Spurious wakeup somehow.  Loop. */
+		goto again;
 
 	return ret;
+
+unlock:
+	unlock_futex_mm();
+	return ret;
 }
 
 static int futex_close(struct inode *inode, struct file *filp)


Name: Allow Futex Rehashing In Interrupt
Author: Rusty Russell
Status: Tested on 2.6.0-test4-bk2
Depends: Misc/futex-minor-tweaks.patch.gz
Depends: Misc/qemu-page-offset.patch.gz

D: This patch simply uses spin_lock_irq() instead of spin_lock for the
D: futex lock, in preparation for the futex_rehash patch which needs to
D: operate on the futex hash table in IRQ context.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5392-linux-2.6.0-test4-bk2/kernel/futex.c .5392-linux-2.6.0-test4-bk2.updated/kernel/futex.c
--- .5392-linux-2.6.0-test4-bk2/kernel/futex.c	2003-08-28 17:51:06.000000000 +1000
+++ .5392-linux-2.6.0-test4-bk2.updated/kernel/futex.c	2003-08-28 17:51:37.000000000 +1000
@@ -74,12 +74,12 @@ static inline void lock_futex_mm(void)
 {
 	spin_lock(&current->mm->page_table_lock);
 	spin_lock(&vcache_lock);
-	spin_lock(&futex_lock);
+	spin_lock_irq(&futex_lock);
 }
 
 static inline void unlock_futex_mm(void)
 {
-	spin_unlock(&futex_lock);
+	spin_unlock_irq(&futex_lock);
 	spin_unlock(&vcache_lock);
 	spin_unlock(&current->mm->page_table_lock);
 }
@@ -196,7 +196,7 @@ static void futex_vcache_callback(vcache
 	struct futex_q *q = container_of(vcache, struct futex_q, vcache);
 	struct list_head *head = hash_futex(new_page, q->offset);
 
-	spin_lock(&futex_lock);
+	spin_lock_irq(&futex_lock);
 
 	if (!list_empty(&q->list)) {
 		put_page(q->page);
@@ -206,7 +206,7 @@ static void futex_vcache_callback(vcache
 		list_add_tail(&q->list, head);
 	}
 
-	spin_unlock(&futex_lock);
+	spin_unlock_irq(&futex_lock);
 }
 
 /*
@@ -293,13 +293,13 @@ static inline int unqueue_me(struct fute
 	int ret = 0;
 
 	spin_lock(&vcache_lock);
-	spin_lock(&futex_lock);
+	spin_lock_irq(&futex_lock);
 	if (!list_empty(&q->list)) {
 		list_del(&q->list);
 		__detach_vcache(&q->vcache);
 		ret = 1;
 	}
-	spin_unlock(&futex_lock);
+	spin_unlock_irq(&futex_lock);
 	spin_unlock(&vcache_lock);
 	return ret;
 }
@@ -391,10 +391,10 @@ static unsigned int futex_poll(struct fi
 	int ret = 0;
 
 	poll_wait(filp, &q->waiters, wait);
-	spin_lock(&futex_lock);
+	spin_lock_irq(&futex_lock);
 	if (list_empty(&q->list))
 		ret = POLLIN | POLLRDNORM;
-	spin_unlock(&futex_lock);
+	spin_unlock_irq(&futex_lock);
 
 	return ret;
 }


Name: Futexes without pinning pages
Author: Rusty Russell
Status: Tested on 2.6.0-test4-bk2
Depends: Misc/futex-irqsave.patch.gz
Depends: Misc/qemu-page-offset.patch.gz

D: TODO: Fix compilation with CONFIG_FUTEX=n.
D: 
D: Avoid pinning pages with futexes in them, to resolve FUTEX_FD DoS.
D: This means we need another way to uniquely identify pages, rather
D: than simply comparing the "struct page *" (and using a hash table
D: based on the "struct page *".  For file-backed pages, the
D: page->mapping and page->index provide a unique identifier, which is
D: persistent even if they get swapped out to the file and back.
D: There are cases where the mapping changes: for these we need a
D: callback to rehash all futexes in that page.
D: 
D: For anonymous pages, page->mapping == NULL.  So for this case we
D: use the "struct page *" itself to hash and compare, because the
D: mapping will be set (to &swapper_space) if the page is moved to the
D: swap cache, and will be rehashed, and we can find it again.
D: 
D: The current futex_rehash() call walks the entire hash table, which
D: is slow.  The simplest optimization is to have a page->flags bit
D: which indicates a futex has been placed in this page: we can clear
D: it if futex_rehash() finds no futexes.  This will come in a
D: followup patch.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5947-2.6.0-test4-bk2-futex-swap.pre/include/linux/futex.h .5947-2.6.0-test4-bk2-futex-swap/include/linux/futex.h
--- .5947-2.6.0-test4-bk2-futex-swap.pre/include/linux/futex.h	2003-05-27 15:02:21.000000000 +1000
+++ .5947-2.6.0-test4-bk2-futex-swap/include/linux/futex.h	2003-08-28 17:52:47.000000000 +1000
@@ -17,4 +17,10 @@ asmlinkage long sys_futex(u32 __user *ua
 long do_futex(unsigned long uaddr, int op, int val,
 		unsigned long timeout, unsigned long uaddr2, int val2);
 
+/* To tell us when the page->mapping or page->index changes. */
+struct page;
+struct address_space;
+extern void futex_rehash(struct page *page,
+			 struct address_space *new_mapping,
+			 unsigned long new_index);
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5947-2.6.0-test4-bk2-futex-swap.pre/include/linux/pagemap.h .5947-2.6.0-test4-bk2-futex-swap/include/linux/pagemap.h
--- .5947-2.6.0-test4-bk2-futex-swap.pre/include/linux/pagemap.h	2003-08-25 11:58:34.000000000 +1000
+++ .5947-2.6.0-test4-bk2-futex-swap/include/linux/pagemap.h	2003-08-28 17:52:47.000000000 +1000
@@ -11,6 +11,7 @@
 #include <linux/pagemap.h>
 #include <asm/uaccess.h>
 #include <linux/gfp.h>
+#include <linux/futex.h>
 
 /*
  * Bits in mapping->flags.  The lower __GFP_BITS_SHIFT bits are the page
@@ -143,6 +144,7 @@ static inline void ___add_to_page_cache(
 		struct address_space *mapping, unsigned long index)
 {
 	list_add(&page->list, &mapping->clean_pages);
+	futex_rehash(page, mapping, index);
 	page->mapping = mapping;
 	page->index = index;
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5947-2.6.0-test4-bk2-futex-swap.pre/kernel/futex.c .5947-2.6.0-test4-bk2-futex-swap/kernel/futex.c
--- .5947-2.6.0-test4-bk2-futex-swap.pre/kernel/futex.c	2003-08-28 17:52:46.000000000 +1000
+++ .5947-2.6.0-test4-bk2-futex-swap/kernel/futex.c	2003-08-28 17:52:47.000000000 +1000
@@ -35,6 +35,15 @@
 #include <linux/vcache.h>
 #include <linux/mount.h>
 
+/* Futexes need to have a way of identifying pages which are the same,
+   when they may be in different address spaces (ie. virtual address
+   might be different, eg. shared mmap).  We don't want to pin the
+   pages, so we use page->mapping & page->index where page->mapping is
+   not NULL (file-backed pages), and hash the page struct itself for
+   other pages.  Callbacks rehash pages when page->mapping is changed
+   or set (such as when anonymous pages enter the swap cache), so we
+   recognize them when the get swapped back in. */
+
 #define FUTEX_HASHBITS 8
 
 /*
@@ -45,7 +54,10 @@ struct futex_q {
 	struct list_head list;
 	wait_queue_head_t waiters;
 
-	/* Page struct and offset within it. */
+	/* These match if mapping != NULL */
+	struct address_space *mapping;
+	unsigned long index;
+	/* Otherwise, the page itself. */
 	struct page *page;
 	int offset;
 
@@ -57,7 +69,6 @@ struct futex_q {
 	struct file *filp;
 };
 
-/* The key for the hash is the address + index + offset within page */
 static struct list_head futex_queues[1<<FUTEX_HASHBITS];
 static spinlock_t futex_lock = SPIN_LOCK_UNLOCKED;
 
@@ -84,11 +95,68 @@ static inline void unlock_futex_mm(void)
 	spin_unlock(&current->mm->page_table_lock);
 }
 
-/* The struct page is shared, so we can hash on its address. */
-static inline struct list_head *hash_futex(struct page *page, int offset)
+static inline int page_matches(struct page *page, struct futex_q *elem)
 {
-	return &futex_queues[hash_long((unsigned long)page + offset,
-							FUTEX_HASHBITS)];
+	if (elem->mapping)
+		return page->mapping == elem->mapping
+			&& page->index == elem->index;
+	return page == elem->page;
+}
+
+/* For pages which are file backed, we can simply hash by mapping and
+ * index, which is persistent as they get swapped out.  For anonymous
+ * regions, we hash by the actual struct page *: their mapping will
+ * change and they will be rehashed if they are swapped out.
+ */
+static inline struct list_head *hash_futex(struct address_space *mapping,
+					   unsigned long index,
+					   struct page *page,
+					   int offset)
+{
+	unsigned long hashin;
+	if (mapping)
+		hashin = (unsigned long)mapping + index;
+	else
+		hashin = (unsigned long)page;
+	return &futex_queues[hash_long(hashin+offset, FUTEX_HASHBITS)];
+}
+
+/* Called when we change page->mapping (or page->index).  Can be in
+ * interrupt context. */
+void futex_rehash(struct page *page,
+		  struct address_space *new_mapping, unsigned long new_index)
+{
+	unsigned int i;
+	unsigned long flags;
+	struct futex_q *q;
+	LIST_HEAD(gather);
+	static int rehash_count = 0;
+
+	spin_lock_irqsave(&futex_lock, flags);
+	rehash_count++;
+	for (i = 0; i < 1 << FUTEX_HASHBITS; i++) {
+		struct list_head *l, *next;
+		list_for_each_safe(l, next, &futex_queues[i]) {
+			q = list_entry(l, struct futex_q, list);
+			if (page_matches(page, q)) {
+				list_del(&q->list);
+				list_add(&q->list, &gather);
+				printk("futex_rehash %i: offset %i %p -> %p\n",
+				       rehash_count,
+				       q->offset, page->mapping, new_mapping);
+			}
+		}
+	}
+	while (!list_empty(&gather)) {
+		q = list_entry(gather.next, struct futex_q, list);
+		q->mapping = new_mapping;
+		q->index = new_index;
+		q->page = page;
+		list_del(&q->list);
+		list_add(&q->list,
+			 hash_futex(new_mapping, new_index, page, q->offset));
+	}
+	spin_unlock_irqrestore(&futex_lock, flags);
 }
 
 /*
@@ -162,12 +230,12 @@ static inline int futex_wake(unsigned lo
 		return -EFAULT;
 	}
 
-	head = hash_futex(page, offset);
+	head = hash_futex(page->mapping, page->index, page, offset);
 
 	list_for_each_safe(i, next, head) {
 		struct futex_q *this = list_entry(i, struct futex_q, list);
 
-		if (this->page == page && this->offset == offset) {
+		if (page_matches(page, this) && this->offset == offset) {
 			list_del_init(i);
 			__detach_vcache(&this->vcache);
 			wake_up_all(&this->waiters);
@@ -194,15 +262,16 @@ static inline int futex_wake(unsigned lo
 static void futex_vcache_callback(vcache_t *vcache, struct page *new_page)
 {
 	struct futex_q *q = container_of(vcache, struct futex_q, vcache);
-	struct list_head *head = hash_futex(new_page, q->offset);
+	struct list_head *head = hash_futex(new_page->mapping, new_page->index,
+					    new_page, q->offset);
 
 	spin_lock_irq(&futex_lock);
 
 	if (!list_empty(&q->list)) {
-		put_page(q->page);
-		q->page = new_page;
-		__pin_page_atomic(new_page);
 		list_del(&q->list);
+		q->mapping = new_page->mapping;
+		q->index = new_page->index;
+		q->page = new_page;
 		list_add_tail(&q->list, head);
 	}
 
@@ -229,13 +298,13 @@ static inline int futex_requeue(unsigned
 	if (!page2)
 		goto out;
 
-	head1 = hash_futex(page1, offset1);
-	head2 = hash_futex(page2, offset2);
+	head1 = hash_futex(page1->mapping, page1->index, page1, offset1);
+	head2 = hash_futex(page2->mapping, page2->index, page2, offset2);
 
 	list_for_each_safe(i, next, head1) {
 		struct futex_q *this = list_entry(i, struct futex_q, list);
 
-		if (this->page == page1 && this->offset == offset1) {
+		if (page_matches(page1, this) && this->offset == offset1) {
 			list_del_init(i);
 			__detach_vcache(&this->vcache);
 			if (++ret <= nr_wake) {
@@ -244,8 +313,6 @@ static inline int futex_requeue(unsigned
 					send_sigio(&this->filp->f_owner,
 							this->fd, POLL_IN);
 			} else {
-				put_page(this->page);
-				__pin_page_atomic (page2);
 				list_add_tail(i, head2);
 				__attach_vcache(&this->vcache, uaddr2,
 					current->mm, futex_vcache_callback);
@@ -272,11 +339,14 @@ static inline void __queue_me(struct fut
 				unsigned long uaddr, int offset,
 				int fd, struct file *filp)
 {
-	struct list_head *head = hash_futex(page, offset);
+	struct list_head *head
+		= hash_futex(page->mapping, page->index, page, offset);
 
 	q->offset = offset;
 	q->fd = fd;
 	q->filp = filp;
+	q->mapping = page->mapping;
+	q->index = page->index;
 	q->page = page;
 
 	list_add_tail(&q->list, head);
@@ -332,18 +402,19 @@ again:
 	 */
 	if (get_user(curval, (int *)uaddr) != 0) {
 		ret = -EFAULT;
-		goto unlock;
+		goto putpage;
 	}
 
 	if (curval != val) {
 		ret = -EWOULDBLOCK;
-		goto unlock;
+		goto putpage;
 	}
 
 	__queue_me(&q, page, uaddr, offset, -1, NULL);
 	add_wait_queue(&q.waiters, &wait);
 	set_current_state(TASK_INTERRUPTIBLE);
 	unlock_futex_mm();
+	put_page(page);
 
 	time = schedule_timeout(time);
 
@@ -352,7 +423,6 @@ again:
 	 * NOTE: we don't remove ourselves from the waitqueue because
 	 * we are the only user of it.
 	 */
-	put_page(q.page);
 
 	/* Were we woken up (and removed from queue)?  Always return
 	 * success when this happens. */
@@ -368,6 +438,8 @@ again:
 
 	return ret;
 
+putpage:
+	put_page(page);
 unlock:
 	unlock_futex_mm();
 	return ret;
@@ -378,7 +450,6 @@ static int futex_close(struct inode *ino
 	struct futex_q *q = filp->private_data;
 
 	unqueue_me(q);
-	put_page(q->page);
 	kfree(filp->private_data);
 	return 0;
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5947-2.6.0-test4-bk2-futex-swap.pre/mm/filemap.c .5947-2.6.0-test4-bk2-futex-swap/mm/filemap.c
--- .5947-2.6.0-test4-bk2-futex-swap.pre/mm/filemap.c	2003-08-25 11:58:36.000000000 +1000
+++ .5947-2.6.0-test4-bk2-futex-swap/mm/filemap.c	2003-08-28 17:52:47.000000000 +1000
@@ -27,6 +27,7 @@
 #include <linux/pagevec.h>
 #include <linux/blkdev.h>
 #include <linux/security.h>
+#include <linux/futex.h>
 /*
  * This is needed for the following functions:
  *  - try_to_release_page
@@ -92,6 +93,7 @@ void __remove_from_page_cache(struct pag
 
 	radix_tree_delete(&mapping->page_tree, page->index);
 	list_del(&page->list);
+	futex_rehash(page, NULL, 0);
 	page->mapping = NULL;
 
 	mapping->nrpages--;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5947-2.6.0-test4-bk2-futex-swap.pre/mm/page_io.c .5947-2.6.0-test4-bk2-futex-swap/mm/page_io.c
--- .5947-2.6.0-test4-bk2-futex-swap.pre/mm/page_io.c	2003-02-07 19:18:58.000000000 +1100
+++ .5947-2.6.0-test4-bk2-futex-swap/mm/page_io.c	2003-08-28 17:52:47.000000000 +1000
@@ -19,6 +19,7 @@
 #include <linux/buffer_head.h>	/* for block_sync_page() */
 #include <linux/mpage.h>
 #include <linux/writeback.h>
+#include <linux/futex.h>
 #include <asm/pgtable.h>
 
 static struct bio *
@@ -151,6 +152,7 @@ int rw_swap_page_sync(int rw, swp_entry_
 	lock_page(page);
 
 	BUG_ON(page->mapping);
+	futex_rehash(page, &swapper_space, entry.val);
 	page->mapping = &swapper_space;
 	page->index = entry.val;
 
@@ -161,7 +163,10 @@ int rw_swap_page_sync(int rw, swp_entry_
 		ret = swap_writepage(page, &swap_wbc);
 		wait_on_page_writeback(page);
 	}
+	lock_page(page);
+	futex_rehash(page, NULL, 0);
 	page->mapping = NULL;
+	unlock_page(page);
 	if (ret == 0 && (!PageUptodate(page) || PageError(page)))
 		ret = -EIO;
 	return ret;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5947-2.6.0-test4-bk2-futex-swap.pre/mm/swap_state.c .5947-2.6.0-test4-bk2-futex-swap/mm/swap_state.c
--- .5947-2.6.0-test4-bk2-futex-swap.pre/mm/swap_state.c	2003-08-12 06:58:06.000000000 +1000
+++ .5947-2.6.0-test4-bk2-futex-swap/mm/swap_state.c	2003-08-28 17:52:47.000000000 +1000
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/backing-dev.h>
+#include <linux/futex.h>
 
 #include <asm/pgtable.h>
 
@@ -200,6 +201,7 @@ int move_to_swap_cache(struct page *page
 
 	err = radix_tree_insert(&swapper_space.page_tree, entry.val, page);
 	if (!err) {
+		futex_rehash(page, &swapper_space, entry.val);
 		__remove_from_page_cache(page);
 		___add_to_page_cache(page, &swapper_space, entry.val);
 	}
@@ -236,6 +238,7 @@ int move_from_swap_cache(struct page *pa
 
 	err = radix_tree_insert(&mapping->page_tree, index, page);
 	if (!err) {
+		futex_rehash(page, mapping, index);
 		__delete_from_swap_cache(page);
 		___add_to_page_cache(page, mapping, index);
 	}
================
/* Test program for unpinned futexes. */

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sched.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <signal.h>
#include <errno.h>
#include <string.h>
#include <sys/shm.h>
#include <sys/poll.h>
#include <sys/mman.h>
#include "usersem.h"

#define ARRAY_SIZE(arr) (sizeof(arr)/sizeof((arr)[0]))
#define streq(a,b) (strcmp((a),(b)) == 0)

#define UNTOUCHED_VALUE 7
#define TOUCHED_VALUE 100

/* Recognizable offsets within page so printks can easily identify the futex */
#define MMAP_OFFSET 8
#define SHMEM_OFFSET 16
#define ANON_OFFSET 24

static void chill(int size)
{
	char *mem;
	unsigned int i, numpages;
	unsigned int pagesize = getpagesize();

	numpages = size * 1024*1024 / pagesize;
	mem = malloc(numpages * pagesize);
	if (!mem) {
		fprintf(stderr, "Out of memory\n");
		exit(1);
	}

	for (;;) {
		for (i = 0; i < numpages; i++)
			*(mem + i*pagesize) = '\0';
		printf(".\n");
	}
}

static void *adjust_to_offset(void *addr, unsigned int off)
{
	unsigned int pagesize = getpagesize();

	while ((unsigned long)addr % pagesize != off)
		addr++;
	return addr;
}

/* Give an FD waiting on futex at this addr. */
static int fd_for_addr(void *addr)
{
	return sys_futex(addr, FUTEX_FD, 0, NULL);
}

static void *get_anon_page(void)
{
	return malloc(getpagesize());
}

static void *get_shared_memory(void)
{
	unsigned int pagesize = getpagesize();
	void *memory;
	static int shm;

	shm = shmget(IPC_PRIVATE, pagesize, IPC_CREAT);
	if (shm < 0) {
		perror("shmget");
		return NULL;
	}
	memory = shmat(shm, NULL, 0);
	if (memory == (void *)-1) {
		perror("shmat");
		shmctl(shm, IPC_RMID, NULL);
		return NULL;
	}
	/* Delete when we exit. */
	shmctl(shm, IPC_RMID, NULL);
	return memory;
}

static void *get_mmap(void)
{
	unsigned int pagesize = getpagesize();
	void *memory;
	int fd;

	fd = open("/tmp/test-swap2", O_CREAT|O_EXCL|O_RDWR, 0600);
	if (fd < 0) {
		perror("Opening /tmp/test-swap2");
		return NULL;
	}
	unlink("/tmp/test-swap2");
	if (write(fd, malloc(pagesize), pagesize) != pagesize) {
		perror("Writing /tmp/test-swap2");
		return NULL;
	}
	memory = mmap(NULL, pagesize, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
	if (memory == MAP_FAILED) {
		perror("mmap /tmp/test-swap2");
		return NULL;
	}
	return memory;
}

/* Touching the page swaps it back in, which is slightly different
 * from waking on a page which is swapped out. */
static void wake_futex(int *futex, int touch, const char action[])
{
	if (touch)
		*futex = TOUCHED_VALUE;
	printf("Waking up %p\n", futex);
	if (sys_futex(futex, FUTEX_WAKE, 1, NULL) != 1) {
		perror(action);
		exit(1);
	}
}

int main(int argc, char *argv[])
{
	int *map, *anon, *shm, touch = 0;
	pid_t child;
	char c;
	struct pollfd pollarr[3];

	if (argc > 1 && streq(argv[1], "-t")) {
		touch = 1;
		argc--;
		argv++;
	}

	if (argc != 2) {
		fprintf(stderr, "Usage: test-swap2 [-t] <mb-to-thrash>\n"
			"   Where -t means touch before waking futexes\n");
		exit(1);
	}

	map = get_mmap();
	anon = get_anon_page();
	shm = get_shared_memory();
	if (!map || !anon || !shm)
		exit(1);

	/* Different offsets so we can recognize them in printks. */
	map = adjust_to_offset(map, MMAP_OFFSET);
	anon = adjust_to_offset(anon, ANON_OFFSET);
	shm = adjust_to_offset(shm, SHMEM_OFFSET);

	*map = *anon = *shm = UNTOUCHED_VALUE;

	pollarr[0].fd = fd_for_addr(map);
	pollarr[1].fd = fd_for_addr(anon);
	pollarr[2].fd = fd_for_addr(shm);
	pollarr[0].events = pollarr[1].events = pollarr[2].events = POLLIN;

	/* None should be ready yet */
	if (poll(pollarr, ARRAY_SIZE(pollarr), 0)) {
		perror("poll");
		exit(1);
	}

	printf("MMAP=%u, SHM=%u, ANON=%u, beginning chill...\n",
	       MMAP_OFFSET, SHMEM_OFFSET, ANON_OFFSET);

	child = fork();
	if (child < 0) {
		perror("fork");
		exit(1);
	}
	if (child == 0)
		chill(atoi(argv[1]));

	/* Wait until they hit <CR>. */
	if (read(0, &c, 1) != 1) {
		perror("read");
		exit(1);
	}

	kill(child, SIGTERM);
	printf("Exiting...\n");

	wake_futex(map, touch, "wake up mmap");
	wake_futex(anon, touch, "wake up anon");
	wake_futex(shm, touch, "wake up shm");

	if (poll(pollarr, ARRAY_SIZE(pollarr), -1) != 3) {
		perror("poll after wakeup");
		exit(1);
	}

	if (touch)
		c = TOUCHED_VALUE;
	else
		c = UNTOUCHED_VALUE;

	if (*map != c) {
		fprintf(stderr, "mmap didn't get value %u: it's %u\n",
			c, *mmap);
		exit(1);
	}
	if (*anon != c) {
		fprintf(stderr, "anon didn't get value %u: it's %u\n",
			c, *anon);
		exit(1);
	}
	if (*shm != c) {
		fprintf(stderr, "shm didn't get value %u: it's %u\n",
			c, *shm);
		exit(1);
	}
	return 0;
}
================
