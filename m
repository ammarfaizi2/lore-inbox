Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbTIAEPy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 00:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTIAEPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 00:15:53 -0400
Received: from dp.samba.org ([66.70.73.150]:46509 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262091AbTIAEPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 00:15:40 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andrew Morton <akpm@osdl.org>, mingo@redhat.com,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix 
In-reply-to: Your message of "Mon, 01 Sep 2003 01:35:04 +0100."
             <20030901003504.GA31531@mail.jlokier.co.uk> 
Date: Mon, 01 Sep 2003 14:11:56 +1000
Message-Id: <20030901041539.9FF942C082@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030901003504.GA31531@mail.jlokier.co.uk> you write:
> Rusty Russell wrote:
> > Walking a 256 entry hash table isn't free even if it's empty.  Example
> > patch below.
> 
> You can avoid walking the whole hash table.  Instead of this:
> 
>      (page, offset) -> list of futexes at (p,o)
> 
> You can use a two-level map like this:
> 
>      (page) -> (offset) -> list of futexes at (p,o)
> 
> Or you can use two one-level maps, like this:
> 
>      (page) -> list of futexes at (p)
>      (page, offset) -> list of futexes at (p,o)
> 
> Either of these gives you the list of futexes give then page in
> O(list_size).

Yes, it's effectively segmenting your hash table, which reduces the
effective hash table size for futexes in the same page.  I'm reluctant
to do that unless there's a real speed problem.

This is the latest version of my futex patch.  I think we're getting
closer.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Futexes without pinning pages
Author: Rusty Russell
Status: Tested on 2.6.0-test4-bk2
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
D: 
D: One remaining FIXME: is in truncate.  It would be nice to wake all
D: futexes in mmaped pages when the pages are truncated underneath the
D: mmap: the callers would then get -EFAULT.  It's a politeness thing,
D: not a requirement.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29219-2.6.0-test4-bk2-futex-swap.pre/include/linux/futex.h .29219-2.6.0-test4-bk2-futex-swap/include/linux/futex.h
--- .29219-2.6.0-test4-bk2-futex-swap.pre/include/linux/futex.h	2003-05-27 15:02:21.000000000 +1000
+++ .29219-2.6.0-test4-bk2-futex-swap/include/linux/futex.h	2003-09-01 14:10:33.000000000 +1000
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
@@ -17,4 +17,22 @@ asmlinkage long sys_futex(u32 __user *ua
 long do_futex(unsigned long uaddr, int op, int val,
 		unsigned long timeout, unsigned long uaddr2, int val2);
 
+/* To tell us when the page->mapping or page->index changes on page
+ * which might have futex: must hold futex_lock across futex_rehash
+ * and actual change. */
+extern spinlock_t futex_lock;
+struct page;
+struct address_space;
+#ifdef CONFIG_FUTEX
+extern void futex_rehash(struct page *page,
+			 struct address_space *new_mapping,
+			 unsigned long new_index);
+#else
+static inline void futex_rehash(struct page *page,
+				struct address_space *new_mapping,
+				unsigned long new_index)
+{
+}
+#endif /*CONFIG_FUTEX*/
+
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29219-2.6.0-test4-bk2-futex-swap.pre/include/linux/pagemap.h .29219-2.6.0-test4-bk2-futex-swap/include/linux/pagemap.h
--- .29219-2.6.0-test4-bk2-futex-swap.pre/include/linux/pagemap.h	2003-08-25 11:58:34.000000000 +1000
+++ .29219-2.6.0-test4-bk2-futex-swap/include/linux/pagemap.h	2003-09-01 14:10:33.000000000 +1000
@@ -94,6 +94,8 @@ int add_to_page_cache(struct page *page,
 				unsigned long index, int gfp_mask);
 int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 				unsigned long index, int gfp_mask);
+int move_to_page_cache(struct page *page, struct address_space *mapping,
+		       unsigned long index, int gfp_mask);
 extern void remove_from_page_cache(struct page *page);
 extern void __remove_from_page_cache(struct page *page);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29219-2.6.0-test4-bk2-futex-swap.pre/kernel/futex.c .29219-2.6.0-test4-bk2-futex-swap/kernel/futex.c
--- .29219-2.6.0-test4-bk2-futex-swap.pre/kernel/futex.c	2003-09-01 14:10:32.000000000 +1000
+++ .29219-2.6.0-test4-bk2-futex-swap/kernel/futex.c	2003-09-01 14:10:33.000000000 +1000
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
 
@@ -57,9 +69,8 @@ struct futex_q {
 	struct file *filp;
 };
 
-/* The key for the hash is the address + index + offset within page */
 static struct list_head futex_queues[1<<FUTEX_HASHBITS];
-static spinlock_t futex_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t futex_lock = SPIN_LOCK_UNLOCKED;
 
 extern void send_sigio(struct fown_struct *fown, int fd, int band);
 
@@ -84,11 +95,66 @@ static inline void unlock_futex_mm(void)
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
@@ -162,12 +228,12 @@ static inline int futex_wake(unsigned lo
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
@@ -194,15 +260,16 @@ static inline int futex_wake(unsigned lo
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
 
@@ -229,13 +296,13 @@ static inline int futex_requeue(unsigned
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
@@ -244,8 +311,6 @@ static inline int futex_requeue(unsigned
 					send_sigio(&this->filp->f_owner,
 							this->fd, POLL_IN);
 			} else {
-				put_page(this->page);
-				__pin_page_atomic (page2);
 				list_add_tail(i, head2);
 				__attach_vcache(&this->vcache, uaddr2,
 					current->mm, futex_vcache_callback);
@@ -272,11 +337,14 @@ static inline void __queue_me(struct fut
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
@@ -332,18 +400,19 @@ again:
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
 
@@ -352,7 +421,6 @@ again:
 	 * NOTE: we don't remove ourselves from the waitqueue because
 	 * we are the only user of it.
 	 */
-	put_page(q.page);
 
 	/* Were we woken up (and removed from queue)?  Always return
 	 * success when this happens. */
@@ -368,6 +436,8 @@ again:
 
 	return ret;
 
+putpage:
+	put_page(page);
 unlock:
 	unlock_futex_mm();
 	return ret;
@@ -378,7 +448,6 @@ static int futex_close(struct inode *ino
 	struct futex_q *q = filp->private_data;
 
 	unqueue_me(q);
-	put_page(q->page);
 	kfree(filp->private_data);
 	return 0;
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29219-2.6.0-test4-bk2-futex-swap.pre/mm/filemap.c .29219-2.6.0-test4-bk2-futex-swap/mm/filemap.c
--- .29219-2.6.0-test4-bk2-futex-swap.pre/mm/filemap.c	2003-08-25 11:58:36.000000000 +1000
+++ .29219-2.6.0-test4-bk2-futex-swap/mm/filemap.c	2003-09-01 14:10:33.000000000 +1000
@@ -27,6 +27,7 @@
 #include <linux/pagevec.h>
 #include <linux/blkdev.h>
 #include <linux/security.h>
+#include <linux/futex.h>
 /*
  * This is needed for the following functions:
  *  - try_to_release_page
@@ -79,6 +80,9 @@
  *    ->private_lock		(try_to_unmap_one)
  *    ->page_lock		(try_to_unmap_one)
  *    ->zone.lru_lock		(follow_page->mark_page_accessed)
+ *
+ *  ->mapping->page_lock
+ *    ->futex_lock		(move_to_page_cache, move_xxx_swap_cache)
  */
 
 /*
@@ -220,16 +224,11 @@ restart:
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
@@ -264,6 +263,39 @@ int add_to_page_cache_lru(struct page *p
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
+			spin_lock(&futex_lock);
+			futex_rehash(page, mapping, offset);
+			___add_to_page_cache(page, mapping, offset);
+			spin_unlock(&futex_lock);
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29219-2.6.0-test4-bk2-futex-swap.pre/mm/page_io.c .29219-2.6.0-test4-bk2-futex-swap/mm/page_io.c
--- .29219-2.6.0-test4-bk2-futex-swap.pre/mm/page_io.c	2003-02-07 19:18:58.000000000 +1100
+++ .29219-2.6.0-test4-bk2-futex-swap/mm/page_io.c	2003-09-01 14:10:33.000000000 +1000
@@ -19,6 +19,7 @@
 #include <linux/buffer_head.h>	/* for block_sync_page() */
 #include <linux/mpage.h>
 #include <linux/writeback.h>
+#include <linux/futex.h>
 #include <asm/pgtable.h>
 
 static struct bio *
@@ -151,8 +152,11 @@ int rw_swap_page_sync(int rw, swp_entry_
 	lock_page(page);
 
 	BUG_ON(page->mapping);
+	spin_lock(&futex_lock);
+	futex_rehash(page, &swapper_space, entry.val);
 	page->mapping = &swapper_space;
 	page->index = entry.val;
+	spin_unlock(&futex_lock);
 
 	if (rw == READ) {
 		ret = swap_readpage(NULL, page);
@@ -161,7 +165,10 @@ int rw_swap_page_sync(int rw, swp_entry_
 		ret = swap_writepage(page, &swap_wbc);
 		wait_on_page_writeback(page);
 	}
+	spin_lock(&futex_lock);
+	futex_rehash(page, NULL, 0);
 	page->mapping = NULL;
+	spin_unlock(&futex_lock);
 	if (ret == 0 && (!PageUptodate(page) || PageError(page)))
 		ret = -EIO;
 	return ret;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29219-2.6.0-test4-bk2-futex-swap.pre/mm/swap_state.c .29219-2.6.0-test4-bk2-futex-swap/mm/swap_state.c
--- .29219-2.6.0-test4-bk2-futex-swap.pre/mm/swap_state.c	2003-08-12 06:58:06.000000000 +1000
+++ .29219-2.6.0-test4-bk2-futex-swap/mm/swap_state.c	2003-09-01 14:10:33.000000000 +1000
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/backing-dev.h>
+#include <linux/futex.h>
 
 #include <asm/pgtable.h>
 
@@ -140,8 +141,8 @@ int add_to_swap(struct page * page)
 		/*
 		 * Add it to the swap cache and mark it dirty
 		 */
-		err = add_to_page_cache(page, &swapper_space,
-					entry.val, GFP_ATOMIC);
+		err = move_to_page_cache(page, &swapper_space,
+					 entry.val, GFP_ATOMIC);
 
 		if (pf_flags & PF_MEMALLOC)
 			current->flags |= PF_MEMALLOC;
@@ -200,8 +201,11 @@ int move_to_swap_cache(struct page *page
 
 	err = radix_tree_insert(&swapper_space.page_tree, entry.val, page);
 	if (!err) {
+		spin_lock(&futex_lock);
+		futex_rehash(page, &swapper_space, entry.val);
 		__remove_from_page_cache(page);
 		___add_to_page_cache(page, &swapper_space, entry.val);
+		spin_unlock(&futex_lock);
 	}
 
 	spin_unlock(&mapping->page_lock);
@@ -236,8 +240,11 @@ int move_from_swap_cache(struct page *pa
 
 	err = radix_tree_insert(&mapping->page_tree, index, page);
 	if (!err) {
+		spin_lock(&futex_lock);
+		futex_rehash(page, mapping, index);
 		__delete_from_swap_cache(page);
 		___add_to_page_cache(page, mapping, index);
+		spin_unlock(&futex_lock);
 	}
 
 	spin_unlock(&mapping->page_lock);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29219-2.6.0-test4-bk2-futex-swap.pre/mm/truncate.c .29219-2.6.0-test4-bk2-futex-swap/mm/truncate.c
--- .29219-2.6.0-test4-bk2-futex-swap.pre/mm/truncate.c	2003-05-27 15:02:24.000000000 +1000
+++ .29219-2.6.0-test4-bk2-futex-swap/mm/truncate.c	2003-09-01 14:10:33.000000000 +1000
@@ -53,6 +53,7 @@ truncate_complete_page(struct address_sp
 	clear_page_dirty(page);
 	ClearPageUptodate(page);
 	ClearPageMappedToDisk(page);
+	/* FIXME: Rehash futexes, or send signal? --RR */
 	remove_from_page_cache(page);
 	page_cache_release(page);	/* pagecache ref */
 }
