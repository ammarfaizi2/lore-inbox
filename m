Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbTH0FTf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 01:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263077AbTH0FTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 01:19:35 -0400
Received: from dp.samba.org ([66.70.73.150]:34740 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263011AbTH0FSx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 01:18:53 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix 
In-reply-to: Your message of "Mon, 25 Aug 2003 21:06:06 MST."
             <20030825210606.5912bac4.akpm@osdl.org> 
Date: Wed, 27 Aug 2003 15:17:51 +1000
Message-Id: <20030827051853.181C92C0C1@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030825210606.5912bac4.akpm@osdl.org> you write:
> But end_swap_bio_read() is called from interrupt context.  Hence the
> spinlock you have in there needs to become IRQ safe.

OK, I've fixed that, with conservative assumptions (so it doesn't
assume context).  Or is _bh sufficient?

> Two issues:
> 
> a) what to do about futexes in file-backed pages?  At present the
>    attacker can pin arbitrary amount of memory by backing it with a file.

At present == 2.6.0-test4?  In 2.6.0-test4, the attacker can pin one
page per process (OK), or on per FD using FUTEX_FD (not OK).  This
patch changes it so that pages are *never* pinned, whatever is backing
them.

>    Your solution won't scale to solving this, because we need to perform
>    a futex lookup on every add_to_page_cache().  (Well, it will scale
>    fairly well because add_to_page_cache() is ratelimited by the IO speed. 
>    But it will still suck quite a bit for some people).

I assumed that for non-anonymous pages the mapping + index was always
a unique identifier, even as they were swapped out.  We need a
persistent unique identifier for a page, OR a callback to
unhash/rehash it when the identifier changes.  Hence mapping + index
where mapping != NULL, and the struct page and callbacks for swap
pages.  Using the callbacks for wherever else page->mapping changes is
simple (but may be slow).

> b) Assuming a) is solved: futexes which are backed by tmpfs.  tmpfs
>    (which is a study in conceptual baroquenness) will rewrite page->mapping
>    as pages are moved between tmpfs inodes and swapper_space.  I _think_
>    lock_page() is sufficient to serialise against this.  If not, both
>    ->page_locks are needed.

Looks like the call to move_to_swap_cache is already serialized by
spin_lock(&info->lock) in shmem_writepage AFAICT, in fact,
move_to_swap_cache seems to assume serialization, since it does
(outside any of its locks):
		
		/* shift page from clean_pages to dirty_pages list */
		BUG_ON(PageDirty(page));
		set_page_dirty(page);

>    This of course will break your hashing scheme.  Hooks in
>    move_to_swap_cache() and move_from_swap_cache() are needed.

I've added it, but how often does that get called?

A simple optimization would be to have a page bit which says "has ever
had someone waiting on a futex" which would optimize this: it could be
reset in the futex callbacks if it finds noone is waiting on that
page.

> Or create RLIM_NRFUTEX.

This is the option of last resort: shades of SysV semaphores.  Even if
it only applied to FUTEX_FD, it makes them basically unusable.

OK, here's a new one (modified previous patch prepended for completeness),
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Minor futex comment tweaks and cleanups
Author: Rusty Russell
Status: Tested on 2.6.0-test4-bk2

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
+	init_waitqueue_entry(wait, current);
 
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
Status: Tested on 2.6.0-test4-bk2
Depends: Misc/futex-minor-tweaks.patch.gz
Depends: Misc/qemu-page-offset.patch.gz

D: Avoid pinning pages with futexes in them, to resolve FUTEX_FD DoS.
D: Insert callbacks in swap code to unhash them when they are swapped
D: out and rehash them when they are swapped back in.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26024-linux-2.6.0-test4-bk2/include/linux/futex.h .26024-linux-2.6.0-test4-bk2.updated/include/linux/futex.h
--- .26024-linux-2.6.0-test4-bk2/include/linux/futex.h	2003-05-27 15:02:21.000000000 +1000
+++ .26024-linux-2.6.0-test4-bk2.updated/include/linux/futex.h	2003-08-27 15:05:37.000000000 +1000
@@ -17,4 +17,7 @@ asmlinkage long sys_futex(u32 __user *ua
 long do_futex(unsigned long uaddr, int op, int val,
 		unsigned long timeout, unsigned long uaddr2, int val2);
 
+/* For mm/page_io.c to tell us about swapping of (anonymous) pages. */
+extern void futex_swap_out(struct page *page);
+extern void futex_swap_in(struct page *page);
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26024-linux-2.6.0-test4-bk2/kernel/futex.c .26024-linux-2.6.0-test4-bk2.updated/kernel/futex.c
--- .26024-linux-2.6.0-test4-bk2/kernel/futex.c	2003-08-27 15:05:36.000000000 +1000
+++ .26024-linux-2.6.0-test4-bk2.updated/kernel/futex.c	2003-08-27 15:07:31.000000000 +1000
@@ -52,14 +52,17 @@ struct futex_q {
 	/* the virtual => physical COW-safe cache */
 	vcache_t vcache;
 
+	/* When anonymous memory swapped out, this stores the index. */
+	unsigned long swap_index;
+
 	/* For fd, sigio sent using these. */
 	int fd;
 	struct file *filp;
 };
 
-/* The key for the hash is the address + index + offset within page */
 static struct list_head futex_queues[1<<FUTEX_HASHBITS];
 static spinlock_t futex_lock = SPIN_LOCK_UNLOCKED;
+static LIST_HEAD(futex_swapped);
 
 extern void send_sigio(struct fown_struct *fown, int fd, int band);
 
@@ -74,21 +77,74 @@ static inline void lock_futex_mm(void)
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
 
-/* The struct page is shared, so we can hash on its address. */
+/* For pages which are file backed, we can simply hash by mapping and
+ * index.  For anonymous regions, we hash by the actual struct page *,
+ * and move them in and out of the hash if they are swapped out.
+ */
 static inline struct list_head *hash_futex(struct page *page, int offset)
 {
-	return &futex_queues[hash_long((unsigned long)page + offset,
-							FUTEX_HASHBITS)];
+	unsigned long hashin;
+	if (page->mapping)
+		hashin = (unsigned long)page->mapping + page->index;
+	else
+		hashin = (unsigned long)page;
+
+	return &futex_queues[hash_long(hashin+offset, FUTEX_HASHBITS)];
+}
+
+/* Called when we're going to swap this page out (ie. whenever mapping
+ * changes). */
+void futex_swap_out(struct page *page)
+{
+	unsigned int i;
+
+	/* It should have the mapping (== &swapper_space) and index
+	 * set by now */
+ 	BUG_ON(!page->mapping);
+
+	spin_lock_irq(&futex_lock);
+	for (i = 0; i < 1 << FUTEX_HASHBITS; i++) {
+		struct list_head *l, *next;
+		list_for_each_safe(l, next, &futex_queues[i]) {
+			struct futex_q *q = list_entry(l, struct futex_q,list);
+			if (q->page == page) {
+				list_del(&q->list);
+				q->swap_index = page->index;
+				q->page = NULL;
+				list_add(&q->list, &futex_swapped);
+			}
+		}
+	}
+	spin_unlock_irq(&futex_lock);
+}
+
+/* Called when we're going to swap this page in (can be interrupt context) */
+void futex_swap_in(struct page *page)
+{
+	struct list_head *l, *next;
+	unsigned long flags;
+
+	spin_lock_irqsave(&futex_lock, flags);
+	list_for_each_safe(l, next, &futex_swapped) {
+		struct futex_q *q = list_entry(l, struct futex_q, list);
+
+		if (q->swap_index == page->index) {
+			list_del(&q->list);
+			q->page = page;
+			list_add(&q->list, hash_futex(q->page, q->offset));
+		}
+	}
+	spin_unlock_irqrestore(&futex_lock, flags);
 }
 
 /*
@@ -196,17 +252,15 @@ static void futex_vcache_callback(vcache
 	struct futex_q *q = container_of(vcache, struct futex_q, vcache);
 	struct list_head *head = hash_futex(new_page, q->offset);
 
-	spin_lock(&futex_lock);
+	spin_lock_irq(&futex_lock);
 
 	if (!list_empty(&q->list)) {
-		put_page(q->page);
-		q->page = new_page;
-		__pin_page_atomic(new_page);
 		list_del(&q->list);
+		q->page = new_page;
 		list_add_tail(&q->list, head);
 	}
 
-	spin_unlock(&futex_lock);
+	spin_unlock_irq(&futex_lock);
 }
 
 /*
@@ -244,8 +298,6 @@ static inline int futex_requeue(unsigned
 					send_sigio(&this->filp->f_owner,
 							this->fd, POLL_IN);
 			} else {
-				put_page(this->page);
-				__pin_page_atomic (page2);
 				list_add_tail(i, head2);
 				__attach_vcache(&this->vcache, uaddr2,
 					current->mm, futex_vcache_callback);
@@ -293,13 +345,13 @@ static inline int unqueue_me(struct fute
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
@@ -316,7 +368,7 @@ static inline int futex_wait(unsigned lo
 
 again:
 	init_waitqueue_head(&q.waiters);
-	init_waitqueue_entry(wait, current);
+	init_waitqueue_entry(&wait, current);
 
 	lock_futex_mm();
 
@@ -332,18 +384,19 @@ again:
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
 
@@ -352,7 +405,6 @@ again:
 	 * NOTE: we don't remove ourselves from the waitqueue because
 	 * we are the only user of it.
 	 */
-	put_page(q.page);
 
 	/* Were we woken up (and removed from queue)?  Always return
 	 * success when this happens. */
@@ -368,6 +420,8 @@ again:
 
 	return ret;
 
+putpage:
+	put_page(page);
 unlock:
 	unlock_futex_mm();
 	return ret;
@@ -378,7 +432,6 @@ static int futex_close(struct inode *ino
 	struct futex_q *q = filp->private_data;
 
 	unqueue_me(q);
-	put_page(q->page);
 	kfree(filp->private_data);
 	return 0;
 }
@@ -391,10 +444,10 @@ static unsigned int futex_poll(struct fi
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26024-linux-2.6.0-test4-bk2/mm/page_io.c .26024-linux-2.6.0-test4-bk2.updated/mm/page_io.c
--- .26024-linux-2.6.0-test4-bk2/mm/page_io.c	2003-02-07 19:18:58.000000000 +1100
+++ .26024-linux-2.6.0-test4-bk2.updated/mm/page_io.c	2003-08-27 15:05:37.000000000 +1000
@@ -19,6 +19,7 @@
 #include <linux/buffer_head.h>	/* for block_sync_page() */
 #include <linux/mpage.h>
 #include <linux/writeback.h>
+#include <linux/futex.h>
 #include <asm/pgtable.h>
 
 static struct bio *
@@ -77,6 +78,7 @@ static int end_swap_bio_read(struct bio 
 		ClearPageUptodate(page);
 	} else {
 		SetPageUptodate(page);
+		futex_swap_in(page);
 	}
 	unlock_page(page);
 	bio_put(bio);
@@ -105,6 +107,7 @@ int swap_writepage(struct page *page, st
 	}
 	inc_page_state(pswpout);
 	SetPageWriteback(page);
+	futex_swap_out(page);
 	unlock_page(page);
 	submit_bio(WRITE, bio);
 out:
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26024-linux-2.6.0-test4-bk2/mm/swap_state.c .26024-linux-2.6.0-test4-bk2.updated/mm/swap_state.c
--- .26024-linux-2.6.0-test4-bk2/mm/swap_state.c	2003-08-12 06:58:06.000000000 +1000
+++ .26024-linux-2.6.0-test4-bk2.updated/mm/swap_state.c	2003-08-27 15:09:30.000000000 +1000
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/backing-dev.h>
+#include <linux/futex.h>
 
 #include <asm/pgtable.h>
 
@@ -214,6 +215,7 @@ int move_to_swap_cache(struct page *page
 		BUG_ON(PageDirty(page));
 		set_page_dirty(page);
 		INC_CACHE_INFO(add_total);
+		futex_swap_out(page);
 	} else if (err == -EEXIST)
 		INC_CACHE_INFO(exist_race);
 	return err;
@@ -248,6 +250,7 @@ int move_from_swap_cache(struct page *pa
 		/* shift page from clean_pages to dirty_pages list */
 		ClearPageDirty(page);
 		set_page_dirty(page);
+		futex_swap_in(page);
 	}
 	return err;
 }
