Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263500AbTIBFJi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 01:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263504AbTIBFJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 01:09:38 -0400
Received: from dp.samba.org ([66.70.73.150]:8375 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263500AbTIBFJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 01:09:22 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Hugh Dickins <hugh@veritas.com>
Cc: Jamie Lokier <jamie@shareable.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix 
In-reply-to: Your message of "Mon, 01 Sep 2003 21:57:19 +0100."
             <Pine.LNX.4.44.0309012053110.1817-100000@localhost.localdomain> 
Date: Tue, 02 Sep 2003 13:12:24 +1000
Message-Id: <20030902050921.355452C0A8@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0309012053110.1817-100000@localhost.localdomain> you 
write:
> On Mon, 1 Sep 2003, Rusty Russell wrote:
> > 
> > This is the latest version of my futex patch.  I think we're getting
> > closer.
> 
> Miscellaneous comments:

Hi Hugh!

	Thanks for the analysis.

> 1. Please leave mm/page_io.c out of it.  rw_swap_page_sync used to
> be just for swapon to read the header page of a swap area: it seems
> swapon no longer uses it, but kernel/power/swsusp.c has grabbed it.
> It would be very much better if that had a bdev_write_page to match
> its bdev_read_page, and we could delete rw_swap_page_sync; but that's
> not for your patch (and I've no inclination to get into swsusp either).

Right, I just looked for everywhere that ->mapping was set, and
touched every one I wasn't *sure* was safe.  I've deleted the change
to rw_swap_page_sync().

> 2. Please leave mm/swap_state.c's move_to_swap_cache and move_from_swap_
> cache out of it.  I already explained how those are for tmpfs files, and
> it's only the file mapping and index you need to worry about, you won't
> see a such page while it's assigned to swapper_space.  If you're anxious
> to show that you've visited everywhere that modifies page->mapping, then
> add a comment or BUG, but not code which could mislead people into
> thinking futexes really need to be rehashed there.

OK.  I've removed it, too.  Patch is getting shorter 8)

> 3. Please remove reference to move_xxx_swap_cache from locking hierarchy
> comment in mm/filemap.c.

Andrew told me to add a comment 8(.  I've removed it again.

> And reference to swap_out_add_to_swap_cache:
> probably meant to say move_to_page_cache (I'm not keen on that name,
> too much like the unrelated _swap_cache pair, but never mind, it'll do).

Hmm, comment was moved, not modified.  If it was wrong before, it's
wrong now 8(

> 4. You've added a comment line to mm/truncate.c truncate_complete_page,
> but that's the wrong place for it.  If you are going to do something
> about truncation, then you need to do it whether or not the page is
> currently in cache: needs to be a mapping/indexrange thing not a struct
> page* thing.  Do you need to do anything at all?  I hope not, but unsure.

No, we don't *need* to do anything.  If a file is mmapped and someone
truncates the file, it'd be nice to scan the futex table and wake
everyone so they can -EFAULT or SEGV.  Similar case is whenever any
area is munmaped, it'd be nice to find any futexes waiting in those
pages and wake them.  But it's not worth working up a sweat over,
IMHO, it's undefined behavior (don't do that, then).

A FIXME at the top of futex.c in case someone gets ambitious is a
better choice: done.

> 5. If you're not doing anything in __remove_from_page_cache (rightly
> trying to avoid hotpath), you do need to futex_rehash in mm/swap_state.c
> __delete_from_swap_cache (last time I did say without the __s, but that
> would miss an instance you need to catch).  That will handle the swapoff
> case amongst others.

Thanks.  I looked at the callers, and thought it unneccessary, but
only mm/vmscan.c's shrink_list seems to just free the page.  Done.

> 6. The futex_q has no reference count on struct address_space *mapping.
> A task might set a futex in a shared file mapping, get a futex fd,
> unmap the mapping, delete the file, poll the fd, and be woken for
> events on whatever (if anything) next got a struct address_space at
> that same address?  Is this a possible scenario, and is it a worry?

Yes.  It's the same "it'd be nice to wake on unmap" problem: undefined
behavior but not a requirement.

A futex page bit would probably be the best way to do this sanely if
someone was interested.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Minor futex comment tweaks and cleanups
Author: Rusty Russell
Status: Booted on 2.6.0-test4-bk3

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

Name: Futexes without pinning pages
Author: Rusty Russell
Status: Booted on 2.6.0-test4-bk3
Depends: Misc/futex-minor-tweaks.patch.gz
Depends: Misc/qemu-page-offset.patch.gz

D: Avoid pinning pages with futexes in them, to resolve FUTEX_FD DoS.
D: This means we need another way to uniquely identify pages, rather
D: than simply comparing the "struct page *" (and using a hash table
D: based on the "struct page *").  For file-backed pages, the
D: page->mapping and page->index provide a unique identifier, which is
D: persistent even if they get swapped out to the file and back.
D: 
D: For anonymous pages, page->mapping == NULL.  So for this case we
D: use the "struct page *" itself to hash and compare: if the page is
D: going to be swapped out, the mapping will be changed (to
D: &swapper_space).
D: 
D: We need to catch cases where the mapping changes (anon or tmpfs
D: pages moving into swapcache and back): for these we now have a
D: futex_rehash() callback to rehash all futexes in that page, which
D: must be done atomic with the change in ->mapping, so we hold the
D: futex_lock around both.  (This also means any calls to hash_futex()
D: must be inside the futex lock, as in futex_vcache_callback).
D: 
D: Since most calls to ___add_to_page_cache() (which actually does the
D: ->mapping change) are actually new pages (for which the
D: futex_rehash is not required), we do the locking and futex_rehash
D: in the (few) callers who require it.
D: 
D: The main twist is that add_to_page_cache() can only be called for
D: pages which are actually unused (ie. new pages in which there can
D: be no futexes): add_to_swap() called it on already "live" pages.
D: So a new variant "move_to_page_cache()" which calls the
D: futex_rehash() is added, and called from add_to_swap().

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20125-linux-2.6.0-test4-bk3/include/linux/futex.h .20125-linux-2.6.0-test4-bk3.updated/include/linux/futex.h
--- .20125-linux-2.6.0-test4-bk3/include/linux/futex.h	2003-05-27 15:02:21.000000000 +1000
+++ .20125-linux-2.6.0-test4-bk3.updated/include/linux/futex.h	2003-09-02 12:49:33.000000000 +1000
@@ -1,9 +1,9 @@
 #ifndef _LINUX_FUTEX_H
 #define _LINUX_FUTEX_H
+#include <linux/config.h>
+#include <linux/spinlock.h>
 
 /* Second argument to futex syscall */
-
-
 #define FUTEX_WAIT (0)
 #define FUTEX_WAKE (1)
 #define FUTEX_FD (2)
@@ -17,4 +17,26 @@ asmlinkage long sys_futex(u32 __user *ua
 long do_futex(unsigned long uaddr, int op, int val,
 		unsigned long timeout, unsigned long uaddr2, int val2);
 
+/* To tell us when the page->mapping or page->index changes on page
+ * which might have futex: must hold futex_lock across futex_rehash
+ * and actual change. */
+struct page;
+struct address_space;
+#ifdef CONFIG_FUTEX
+extern spinlock_t futex_lock;
+extern void futex_rehash(struct page *page,
+			 struct address_space *new_mapping,
+			 unsigned long new_index);
+#define lock_futex() spin_lock(&futex_lock)
+#define unlock_futex() spin_unlock(&futex_lock)
+#else
+static inline void futex_rehash(struct page *page,
+				struct address_space *new_mapping,
+				unsigned long new_index)
+{
+}
+#define lock_futex()
+#define unlock_futex()
+#endif /*CONFIG_FUTEX*/
+
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20125-linux-2.6.0-test4-bk3/include/linux/pagemap.h .20125-linux-2.6.0-test4-bk3.updated/include/linux/pagemap.h
--- .20125-linux-2.6.0-test4-bk3/include/linux/pagemap.h	2003-08-25 11:58:34.000000000 +1000
+++ .20125-linux-2.6.0-test4-bk3.updated/include/linux/pagemap.h	2003-09-02 12:48:44.000000000 +1000
@@ -94,6 +94,8 @@ int add_to_page_cache(struct page *page,
 				unsigned long index, int gfp_mask);
 int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 				unsigned long index, int gfp_mask);
+int move_to_page_cache(struct page *page, struct address_space *mapping,
+		       unsigned long index, int gfp_mask);
 extern void remove_from_page_cache(struct page *page);
 extern void __remove_from_page_cache(struct page *page);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20125-linux-2.6.0-test4-bk3/kernel/futex.c .20125-linux-2.6.0-test4-bk3.updated/kernel/futex.c
--- .20125-linux-2.6.0-test4-bk3/kernel/futex.c	2003-09-02 12:48:43.000000000 +1000
+++ .20125-linux-2.6.0-test4-bk3.updated/kernel/futex.c	2003-09-02 12:48:44.000000000 +1000
@@ -36,6 +36,18 @@
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
+/* FIXME: It'd be polite to wake any waiters if the page is munmapped
+   underneath them (or mmaped file truncated).  But I consider that 
+   undefined behavior, so if someone implements it cheaply, great. --RR */
+
 #define FUTEX_HASHBITS 8
 
 /*
@@ -46,7 +58,10 @@ struct futex_q {
 	struct list_head list;
 	wait_queue_head_t waiters;
 
-	/* Page struct and offset within it. */
+	/* These match if mapping != NULL */
+	struct address_space *mapping;
+	unsigned long index;
+	/* Otherwise, the page itself. */
 	struct page *page;
 	int offset;
 
@@ -58,9 +73,8 @@ struct futex_q {
 	struct file *filp;
 };
 
-/* The key for the hash is the address + index + offset within page */
 static struct list_head futex_queues[1<<FUTEX_HASHBITS];
-static spinlock_t futex_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t futex_lock = SPIN_LOCK_UNLOCKED;
 
 /* Futex-fs vfsmount entry: */
 static struct vfsmount *futex_mnt;
@@ -83,11 +97,66 @@ static inline void unlock_futex_mm(void)
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
+/* Called when we change page->mapping (or page->index).  Must be
+ * holding futex_lock across change of page->mapping and call to
+ * futex_rehash. */
+void futex_rehash(struct page *page,
+		  struct address_space *new_mapping, unsigned long new_index)
+{
+	unsigned int i;
+	struct futex_q *q;
+	LIST_HEAD(gather);
+	static int rehash_count = 0;
+
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
 }
 
 /*
@@ -161,12 +230,12 @@ static inline int futex_wake(unsigned lo
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
@@ -193,15 +262,16 @@ static inline int futex_wake(unsigned lo
 static void futex_vcache_callback(vcache_t *vcache, struct page *new_page)
 {
 	struct futex_q *q = container_of(vcache, struct futex_q, vcache);
-	struct list_head *head = hash_futex(new_page, q->offset);
+	struct list_head *head;
 
 	spin_lock(&futex_lock);
-
+	head = hash_futex(new_page->mapping, new_page->index,
+			  new_page, q->offset);
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
 
@@ -228,13 +298,13 @@ static inline int futex_requeue(unsigned
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
@@ -243,8 +313,6 @@ static inline int futex_requeue(unsigned
 					send_sigio(&this->filp->f_owner,
 							this->fd, POLL_IN);
 			} else {
-				put_page(this->page);
-				__pin_page_atomic (page2);
 				list_add_tail(i, head2);
 				__attach_vcache(&this->vcache, uaddr2,
 					current->mm, futex_vcache_callback);
@@ -271,11 +339,14 @@ static inline void __queue_me(struct fut
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
@@ -331,18 +402,19 @@ again:
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
 
@@ -351,7 +423,6 @@ again:
 	 * NOTE: we don't remove ourselves from the waitqueue because
 	 * we are the only user of it.
 	 */
-	put_page(q.page);
 
 	/* Were we woken up (and removed from queue)?  Always return
 	 * success when this happens. */
@@ -367,6 +438,8 @@ again:
 
 	return ret;
 
+putpage:
+	put_page(page);
 unlock:
 	unlock_futex_mm();
 	return ret;
@@ -377,7 +450,6 @@ static int futex_close(struct inode *ino
 	struct futex_q *q = filp->private_data;
 
 	unqueue_me(q);
-	put_page(q->page);
 	kfree(filp->private_data);
 	return 0;
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20125-linux-2.6.0-test4-bk3/mm/filemap.c .20125-linux-2.6.0-test4-bk3.updated/mm/filemap.c
--- .20125-linux-2.6.0-test4-bk3/mm/filemap.c	2003-08-25 11:58:36.000000000 +1000
+++ .20125-linux-2.6.0-test4-bk3.updated/mm/filemap.c	2003-09-02 12:48:44.000000000 +1000
@@ -27,6 +27,7 @@
 #include <linux/pagevec.h>
 #include <linux/blkdev.h>
 #include <linux/security.h>
+#include <linux/futex.h>
 /*
  * This is needed for the following functions:
  *  - try_to_release_page
@@ -220,16 +221,11 @@ restart:
  * This adds a page to the page cache, starting out as locked, unreferenced,
  * not uptodate and with no errors.
  *
- * This function is used for two things: adding newly allocated pagecache
- * pages and for moving existing anon pages into swapcache.
- *
- * In the case of pagecache pages, the page is new, so we can just run
- * SetPageLocked() against it.  The other page state flags were set by
- * rmqueue()
+ * This function is used for adding newly allocated pagecache pages.
+ * See move_to_page_cache for moving existing pages into pagecache.
  *
- * In the case of swapcache, try_to_swap_out() has already locked the page, so
- * SetPageLocked() is ugly-but-OK there too.  The required page state has been
- * set up by swap_out_add_to_swap_cache().
+ * The page is new, so we can just run SetPageLocked() against it.
+ * The other page state flags were set by rmqueue()
  *
  * This function does not add the page to the LRU.  The caller must do that.
  */
@@ -264,6 +260,39 @@ int add_to_page_cache_lru(struct page *p
 	return ret;
 }
 
+/* 
+ * This is exactly like add_to_page_cache(), except the page may have
+ * a futex in it (ie. it's not a new page).
+ * 
+ * This is currently called from try_to_swap_out(), which has already
+ * locked the page, so SetPageLocked() is unneeded, but harmless.  The
+ * required page state has been set up by
+ * swap_out_add_to_swap_cache().
+ */
+int move_to_page_cache(struct page *page, struct address_space *mapping,
+		       pgoff_t offset, int gfp_mask)
+{
+	int error = radix_tree_preload(gfp_mask & ~__GFP_HIGHMEM);
+
+	if (error == 0) {
+		page_cache_get(page);
+		spin_lock(&mapping->page_lock);
+		error = radix_tree_insert(&mapping->page_tree, offset, page);
+		if (!error) {
+			SetPageLocked(page);
+			lock_futex();
+			futex_rehash(page, mapping, offset);
+			___add_to_page_cache(page, mapping, offset);
+			unlock_futex();
+		} else {
+			page_cache_release(page);
+		}
+		spin_unlock(&mapping->page_lock);
+		radix_tree_preload_end();
+	}
+	return error;
+}
+
 /*
  * In order to wait for pages to become available there must be
  * waitqueues associated with pages. By using a hash table of
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20125-linux-2.6.0-test4-bk3/mm/swap_state.c .20125-linux-2.6.0-test4-bk3.updated/mm/swap_state.c
--- .20125-linux-2.6.0-test4-bk3/mm/swap_state.c	2003-08-12 06:58:06.000000000 +1000
+++ .20125-linux-2.6.0-test4-bk3.updated/mm/swap_state.c	2003-09-02 12:48:44.000000000 +1000
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/backing-dev.h>
+#include <linux/futex.h>
 
 #include <asm/pgtable.h>
 
@@ -96,7 +97,10 @@ void __delete_from_swap_cache(struct pag
 	BUG_ON(!PageLocked(page));
 	BUG_ON(!PageSwapCache(page));
 	BUG_ON(PageWriteback(page));
+	lock_futex();
+	futex_rehash(page, NULL, 0);
 	__remove_from_page_cache(page);
+	unlock_futex();
 	INC_CACHE_INFO(del_total);
 }
 
@@ -140,8 +144,8 @@ int add_to_swap(struct page * page)
 		/*
 		 * Add it to the swap cache and mark it dirty
 		 */
-		err = add_to_page_cache(page, &swapper_space,
-					entry.val, GFP_ATOMIC);
+		err = move_to_page_cache(page, &swapper_space,
+					 entry.val, GFP_ATOMIC);
 
 		if (pf_flags & PF_MEMALLOC)
 			current->flags |= PF_MEMALLOC;
