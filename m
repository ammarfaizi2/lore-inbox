Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263061AbSJBL6k>; Wed, 2 Oct 2002 07:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263060AbSJBL6k>; Wed, 2 Oct 2002 07:58:40 -0400
Received: from mx1.elte.hu ([157.181.1.137]:9655 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S263061AbSJBL6a>;
	Wed, 2 Oct 2002 07:58:30 -0400
Date: Wed, 2 Oct 2002 14:14:08 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] futex-2.5.40-B5
Message-ID: <Pine.LNX.4.44.0210021233530.10405-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch (against BK-curr) adds a number of futex bugfixes,
performance improvements and cleanups.

The bugfixes are:

 - fix locking bug noticed by Martin Wirth: the ordering of
   page_table_lock, vcache_lock and futex_lock was inconsistent and
   created the possibility of an SMP deadlock.

 - fix spurious wakeup noticed by Andrew Morton: the get_user() in 
   futex_wait() can set the task state to TASK_RUNNING.

 - fix futex_wake COW race, noticed by Martin Wirth - futex_wake() has to
   go through the same lookup rules as the futex_wait() code, otherwise it
   might end up trying to wake up based on the wrong physical page.

Improvements:

 - speed up the basic addrs => page lookup done by the futex code. It used
   to do an unconditional get_user_pages() call, which did a vma lookup 
   and other heavy-handed tactics - while the common case is that the 
   page is mapped and available. Furthermore, due to the COW-race code we 
   had to re-check the mapping anyway, which made the get_user_pages()  
   thing pretty unnecessery. This inefficiency was noticed by Martin 
   Wirth.

   the new lookup code first does a lightweight follow_page(), then if no
   page is present we do the get_user_pages() thing.

 - locking cleanups - the new lookup code made some things simpler, eg.  
   the hash calculation can now be done in queue_me().

 - added comments

 - reduced include file use.

 - increased the futex hashtable.

the patch compiles, boots & works just fine on x86 UP and SMP.

	Ingo

--- linux/kernel/futex.c.orig	Wed Oct  2 11:49:06 2002
+++ linux/kernel/futex.c	Wed Oct  2 13:57:38 2002
@@ -9,6 +9,9 @@
  *  "The futexes are also cursed."
  *  "But they come in a choice of three flavours!"
  *
+ *  Generalized futexes for every mapping type, Ingo Molnar, 2002
+ *
+ *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
  *  the Free Software Foundation; either version 2 of the License, or
@@ -23,44 +26,29 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#include <linux/kernel.h>
-#include <linux/spinlock.h>
-#include <linux/sched.h>
-#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/poll.h>
+#include <linux/file.h>
 #include <linux/hash.h>
 #include <linux/init.h>
-#include <linux/fs.h>
 #include <linux/futex.h>
 #include <linux/vcache.h>
-#include <linux/highmem.h>
-#include <linux/time.h>
-#include <linux/pagemap.h>
-#include <linux/slab.h>
-#include <linux/poll.h>
-#include <linux/file.h>
-#include <linux/dcache.h>
-
-/* Simple "sleep if unchanged" interface. */
 
-/* FIXME: This may be way too small. --RR */
-#define FUTEX_HASHBITS 6
-
-extern void send_sigio(struct fown_struct *fown, int fd, int band);
+#define FUTEX_HASHBITS 8
 
-/* Everyone needs a dentry and inode */
-static struct vfsmount *futex_mnt;
-
-/* We use this instead of a normal wait_queue_t, so we can wake only
-   the relevent ones (hashed queues may be shared) */
+/*
+ * We use this hashed waitqueue instead of a normal wait_queue_t, so
+ * we can wake only the relevent ones (hashed queues may be shared):
+ */
 struct futex_q {
 	struct list_head list;
 	wait_queue_head_t waiters;
 
 	/* Page struct and offset within it. */
 	struct page *page;
-	unsigned int offset;
+	int offset;
 
-	/* the virtual => physical cache */
+	/* the virtual => physical COW-safe cache */
 	vcache_t vcache;
 
 	/* For fd, sigio sent using these. */
@@ -72,14 +60,36 @@
 static struct list_head futex_queues[1<<FUTEX_HASHBITS];
 static spinlock_t futex_lock = SPIN_LOCK_UNLOCKED;
 
-static inline struct list_head *hash_futex(struct page *page,
-					   unsigned long offset)
+extern void send_sigio(struct fown_struct *fown, int fd, int band);
+
+/* Futex-fs vfsmount entry: */
+static struct vfsmount *futex_mnt;
+
+/*
+ * These are all locks that are necessery to look up a physical
+ * mapping safely, and modify/search the futex hash, atomically:
+ */
+static inline void lock_futex_mm(void)
+{
+	spin_lock(&current->mm->page_table_lock);
+	spin_lock(&vcache_lock);
+	spin_lock(&futex_lock);
+}
+
+static inline void unlock_futex_mm(void)
 {
-	unsigned long h;
+	spin_unlock(&futex_lock);
+	spin_unlock(&vcache_lock);
+	spin_unlock(&current->mm->page_table_lock);
+}
 
-	/* struct page is shared, so we can hash on its address */
-	h = (unsigned long)page + offset;
-	return &futex_queues[hash_long(h, FUTEX_HASHBITS)];
+/*
+ * The physical page is shared, so we can hash on its address:
+ */
+static inline struct list_head *hash_futex(struct page *page, int offset)
+{
+	return &futex_queues[hash_long((unsigned long)page + offset,
+							FUTEX_HASHBITS)];
 }
 
 /* Waiter either waiting in FUTEX_WAIT or poll(), or expecting signal */
@@ -90,45 +100,77 @@
 		send_sigio(&q->filp->f_owner, q->fd, POLL_IN);
 }
 
-/* Get kernel address of the user page and pin it. */
-static struct page *pin_page(unsigned long page_start)
+/*
+ * Get kernel address of the user page and pin it.
+ *
+ * Must be called with (and returns with) all futex-MM locks held.
+ */
+static struct page *__pin_page(unsigned long addr)
 {
 	struct mm_struct *mm = current->mm;
-	struct page *page = NULL;
+	struct page *page, *tmp;
 	int err;
 
-	down_read(&mm->mmap_sem);
+	/*
+	 * Do a quick atomic lookup first - this is the fastpath.
+	 */
+	page = follow_page(mm, addr, 0);
+	if (likely(page != NULL)) {
+		get_page(page);
+		return page;
+	}
+
+	/*
+	 * No luck - need to fault in the page:
+	 */
+repeat_lookup:
 
-	err = get_user_pages(current, mm, page_start,
-			     1 /* one page */,
-			     0 /* not writable */,
-			     0 /* don't force */,
-			     &page,
-			     NULL /* don't return vmas */);
+	unlock_futex_mm();
+
+	down_read(&mm->mmap_sem);
+	err = get_user_pages(current, mm, addr, 1, 0, 0, &page, NULL);
 	up_read(&mm->mmap_sem);
+
+	lock_futex_mm();
+
 	if (err < 0)
-		return ERR_PTR(err);
+		return NULL;
+	/*
+	 * Since the faulting happened with locks released, we have to
+	 * check for races:
+	 */
+	tmp = follow_page(mm, addr, 0);
+	if (tmp != page)
+		goto repeat_lookup;
+
 	return page;
 }
 
 static inline void unpin_page(struct page *page)
 {
-	page_cache_release(page);
+	put_page(page);
 }
 
-static int futex_wake(unsigned long uaddr, unsigned int offset, int num)
+/*
+ * Wake up all waiters hashed on the physical page that is mapped
+ * to this virtual address:
+ */
+static int futex_wake(unsigned long uaddr, int offset, int num)
 {
 	struct list_head *i, *next, *head;
 	struct page *page;
-	int ret;
+	int ret = 0;
+
+	lock_futex_mm();
+
+	page = __pin_page(uaddr - offset);
+	if (!page) {
+		unlock_futex_mm();
+		return -EFAULT;
+	}
 
-	page = pin_page(uaddr - offset);
-	ret = IS_ERR(page);
-	if (ret)
-		goto out;
 	head = hash_futex(page, offset);
 
-	spin_lock(&futex_lock);
 	list_for_each_safe(i, next, head) {
 		struct futex_q *this = list_entry(i, struct futex_q, list);
 
@@ -140,12 +182,19 @@
 				break;
 		}
 	}
-	spin_unlock(&futex_lock);
+
+	unlock_futex_mm();
 	unpin_page(page);
-out:
+
 	return ret;
 }
 
+/*
+ * This gets called by the COW code, we have to rehash any
+ * futexes that were pending on the old physical page, and
+ * rehash it to the new physical page. The pagetable_lock
+ * and vcache_lock is already held:
+ */
 static void futex_vcache_callback(vcache_t *vcache, struct page *new_page)
 {
 	struct futex_q *q = container_of(vcache, struct futex_q, vcache);
@@ -162,47 +211,23 @@
 	spin_unlock(&futex_lock);
 }
 
-/* Add at end to avoid starvation */
-static inline int queue_me(struct list_head *head,
-			    struct futex_q *q,
-			    struct page *page,
-			    unsigned int offset,
-			    int fd,
-			    struct file *filp,
-			    unsigned long uaddr)
+static inline void __queue_me(struct futex_q *q, struct page *page,
+				unsigned long uaddr, int offset,
+				int fd, struct file *filp)
 {
-	struct page *tmp;
-	int ret = 0;
+	struct list_head *head = hash_futex(page, offset);
 
 	q->offset = offset;
 	q->fd = fd;
 	q->filp = filp;
+	q->page = page;
 
-	spin_lock(&vcache_lock);
-	spin_lock(&futex_lock);
-	spin_lock(&current->mm->page_table_lock);
-
+	list_add_tail(&q->list, head);
 	/*
-	 * Has the mapping changed meanwhile?
+	 * We register a futex callback to this virtual address,
+	 * to make sure a COW properly rehashes the futex-queue.
 	 */
-	tmp = follow_page(current->mm, uaddr, 0);
-
-	if (tmp == page) {
-		q->page = page;
-		list_add_tail(&q->list, head);
-		/*
-		 * We register a futex callback to this virtual address,
-		 * to make sure a COW properly rehashes the futex-queue.
-		 */
-		__attach_vcache(&q->vcache, uaddr, current->mm, futex_vcache_callback);
-	} else
-		ret = 1;
-
-	spin_unlock(&current->mm->page_table_lock);
-	spin_unlock(&futex_lock);
-	spin_unlock(&vcache_lock);
-
-	return ret;
+	__attach_vcache(&q->vcache, uaddr, current->mm, futex_vcache_callback);
 }
 
 /* Return 1 if we were still queued (ie. 0 means we were woken) */
@@ -210,12 +235,15 @@
 {
 	int ret = 0;
 
+	detach_vcache(&q->vcache);
+
 	spin_lock(&futex_lock);
 	if (!list_empty(&q->list)) {
 		list_del(&q->list);
 		ret = 1;
 	}
 	spin_unlock(&futex_lock);
+
 	return ret;
 }
 
@@ -225,53 +253,59 @@
 		      unsigned long time)
 {
 	DECLARE_WAITQUEUE(wait, current);
-	struct list_head *head;
 	int ret = 0, curval;
 	struct page *page;
 	struct futex_q q;
 
-repeat_lookup:
-	page = pin_page(uaddr - offset);
-	ret = IS_ERR(page);
-	if (ret)
-		goto out;
-	head = hash_futex(page, offset);
-
-	set_current_state(TASK_INTERRUPTIBLE);
 	init_waitqueue_head(&q.waiters);
-	add_wait_queue(&q.waiters, &wait);
-	if (queue_me(head, &q, page, offset, -1, NULL, uaddr)) {
-		unpin_page(page);
-		goto repeat_lookup;
+
+	lock_futex_mm();
+
+	page = __pin_page(uaddr - offset);
+	if (!page) {
+		unlock_futex_mm();
+		return -EFAULT;
 	}
+	__queue_me(&q, page, uaddr, offset, -1, NULL);
+
+	unlock_futex_mm();
 
 	/* Page is pinned, but may no longer be in this address space. */
 	if (get_user(curval, (int *)uaddr) != 0) {
 		ret = -EFAULT;
 		goto out;
 	}
-
 	if (curval != val) {
 		ret = -EWOULDBLOCK;
 		goto out;
 	}
-	time = schedule_timeout(time);
+	/*
+	 * The get_user() above might fault and schedule so we
+	 * cannot just set TASK_INTERRUPTIBLE state when queueing
+	 * ourselves into the futex hash. This code thus has to
+	 * rely on the FUTEX_WAKE code doing a wakeup after removing
+	 * the waiter from the list.
+	 */
+	add_wait_queue(&q.waiters, &wait);
+	set_current_state(TASK_INTERRUPTIBLE);
+	if (!list_empty(&q.list))
+		time = schedule_timeout(time);
+	set_current_state(TASK_RUNNING);
+	/*
+	 * NOTE: we dont remove ourselves from the waitqueue because
+	 * we are the only user of it.
+	 */
 	if (time == 0) {
 		ret = -ETIMEDOUT;
 		goto out;
 	}
-	if (signal_pending(current)) {
+	if (signal_pending(current))
 		ret = -EINTR;
-		goto out;
-	}
 out:
-	detach_vcache(&q.vcache);
-	set_current_state(TASK_RUNNING);
 	/* Were we woken up anyway? */
 	if (!unqueue_me(&q))
 		ret = 0;
-	if (page)
-		unpin_page(page);
+	unpin_page(page);
 
 	return ret;
 }
@@ -318,7 +352,6 @@
 static int futex_fd(unsigned long uaddr, int offset, int signal)
 {
 	struct page *page = NULL;
-	struct list_head *head;
 	struct futex_q *q;
 	struct file *filp;
 	int ret;
@@ -360,25 +393,24 @@
 		goto out;
 	}
 
-repeat_lookup:
-	page = pin_page(uaddr - offset);
-	ret = IS_ERR(page);
-	if (ret) {
+	lock_futex_mm();
+
+	page = __pin_page(uaddr - offset);
+	if (!page) {
+		unlock_futex_mm();
+
 		put_unused_fd(ret);
 		put_filp(filp);
 		kfree(q);
-		page = NULL;
-		goto out;
+		return -EFAULT;
 	}
-	head = hash_futex(page, offset);
 
-	/* Initialize queue structure, and add to hash table. */
-	filp->private_data = q;
 	init_waitqueue_head(&q->waiters);
-	if (queue_me(head, q, page, offset, ret, filp, uaddr)) {
-		unpin_page(page);
-		goto repeat_lookup;
-	}
+	filp->private_data = q;
+
+	__queue_me(q, page, uaddr, offset, ret, filp);
+
+	unlock_futex_mm();
 
 	/* Now we map fd to filp, so userspace can access it */
 	fd_install(ret, filp);

