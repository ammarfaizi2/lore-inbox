Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264653AbSLQERK>; Mon, 16 Dec 2002 23:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264681AbSLQERK>; Mon, 16 Dec 2002 23:17:10 -0500
Received: from fmr05.intel.com ([134.134.136.6]:18168 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S264653AbSLQEQb>; Mon, 16 Dec 2002 23:16:31 -0500
Subject: [PATCH] Priority-based real-time futexes v1.1 for 2.5.52
To: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Message-Id: <E18O9CX-0003JV-00@milikk>
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Date: Mon, 16 Dec 2002 20:19:25 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This is the priority-based futex support; tasks/fds that are
sleeping on a futex get woken up by priority order. This is useful
for real-time locking, with most benefits being for the NGPT and
NPTL thread libraries. Checkout the CAVEATS section for a PRIORITY
INVERSION problem that needs sollution.

How it works is: there is one struct futex_q per futex; each
futex_q contains a priority array [it requires the prioarray-1.0
patch] where the waiters are attached [the waiter, struct futex_w,
describes the task and fd if any). The last waiter takes care of
freeing the futex_q.

When a wake up is selected, the prioarray is walked in priority order
to wake up as many waiters as specified. All list operations are
O(1). The only one operation that is O(N) is sys_poll() [on the number
of fds being waited for, as always].

Changelog since last patch:

 - vcache callback: having to create a new futex_q struct in the
   callback creates a failure point if there is no more GFP_ATOMIC
   space; the corresponding waiter would be deattached from any
   futex_q and thus, lay there sleeping for ever.

   The only sollution I can think of is wake it up, so it goes up
   to user space, sees the count is still -1 [or whatever] and if
   required, go back down to the kernel and sleep there.

 - Added futex_wait_utime() split by Luca Barbieri.

 - Define futex_w_is_queued() so we don't test manually q->NULL
   [in case it changes IANF].

 - Some silly pretty print and cosmetic changes. 

Older changelog:

 - Updated docs here and there, add explanation of the model and a
   short roadmap.

 - Don't depend so much in GFP_ATOMIC - this forces us to lookup
   with __get_futex_q() twice when there is no futex_q, and that
   is ugly. Need to improve it (CR caveats).

 - Fixed a bunch of embarrasing error paths [let's see how many
   did I introduce]

Remaining CAVEATS:

 - Priority inversion problem: in the current futex model, when we
   wake up, in userspace, we set the futex count to 1 and then go
   down to the kernel to ask it to wake up so many
   waiters. Between setting the futex count to 1 and the kernel
   waking up the highest priority waiter(s), some lower priority
   process could acquire the futex and cause a priority
   inversion.

   To fix this, I can only thing of improving the current
   FUTEX_PASS mechanism to work inside the kernel, so that the
   futex does not need to be set to 1 when there are waiters.

 - Not everybody/task/futex cares about priority based wake-up,
   and they consume some space (140 * 2 * 4 bytes each futex_q
   for the prioarray index plus associated stuff) [more than 1K in
   total].

   I am planning that I could have the first locker specify how
   it should behave, and then, dynamically select either a 
   normal queue or a pqueue, with that selection in effect for
   the lifetime of the futex in kernel space [ie: while it is
   locked].

 - I took special care not to miss anything allocated when it
   should, but I could have screwed up ...

 - Optimize lookup and possible creation of a new futex_q

 - Use an slab allocator for the futex_q. On applications with a
   low contention rate, we don't want to be allocating and
   deallocating an struct futex_q every time just because the
   futex is locked by nobody, one or two people in a random
   distribution. If the slab is there, the futex_q will remain
   allocated, so acquisition will be faster and fragmentation
   lower. When memory is tight, and it is not used, it will be
   released. 

I used a combination of code that I borrowed from NGPT, Rusty's 
user space sample library + some of my own to test it. It is 
basically a shared area and futex_down and futex_up programs
that can be called from the shell. I gave it a few hard times
and it resisted pretty well - however, I probably missed many
cases. Find it at:

http://sost.net/pub/linux/pfutex-test.tar.gz

Enjoy

This patch requires the following patches and kernel version:

linux-2.5.52 prioarray-1.0 

diff -u include/linux/vcache.h:1.1.1.1 include/linux/vcache.h:1.1.1.1.4.1
--- include/linux/vcache.h:1.1.1.1	Wed Dec 11 11:06:00 2002
+++ include/linux/vcache.h	Mon Dec 16 17:46:07 2002
@@ -17,8 +17,26 @@
 		unsigned long address,
 		struct mm_struct *mm,
 		void (*callback)(struct vcache_s *data, struct page *new_page));
+static inline
+void attach_vcache (vcache_t *vcache,
+		unsigned long address,
+		struct mm_struct *mm,
+                    void (*callback)(struct vcache_s *data, struct page *new_page))
+{
+  spin_lock (&vcache_lock);
+  __attach_vcache (vcache, address, mm, callback);
+  spin_unlock (&vcache_lock);
+}
 
 extern void __detach_vcache(vcache_t *vcache);
+
+static inline
+void detach_vcache (vcache_t *vcache)
+{
+  spin_lock (&vcache_lock);
+  __detach_vcache (vcache);
+  spin_unlock (&vcache_lock);
+}
 
 extern void invalidate_vcache(unsigned long address, struct mm_struct *mm,
 				struct page *new_page);
diff -u kernel/futex.c:1.1.1.1.2.1 kernel/futex.c:1.1.1.1.4.4
--- kernel/futex.c:1.1.1.1.2.1	Wed Dec 11 13:28:03 2002
+++ kernel/futex.c	Fri Dec 13 17:48:53 2002
@@ -11,6 +11,8 @@
  *
  *  Generalized futexes for every mapping type, Ingo Molnar, 2002
  *
+ *  Priority-based wake up support (C) 2002 Intel Corp, Inaky
+ *  Perez-Gonzalez <inaky.perez-gonzalez@intel.com>.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -24,8 +26,73 @@
  *
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307  USA
+ *
+ * FIXME: a slab allocator for futex_q and futex_w might be
+ * interesting.
+ *
+ *
+ * THEORY OF OPERATION [FIXME: I might have some areas wrong, help? thx]
+ *
+ * We want a user-space, inter-process lock that is fast to acquire
+ * when unlocked and that sleeps in the kernel if locked. Same story
+ * when releasing [no kernel access when only only one locker].
+ *
+ * So here come futexes. They are an integer in memory [possibly
+ * shared by different clones (normal lock) or processes (shared
+ * lock)]. If it's value is:
+ *
+ *  1          It is unlocked
+ *  N (N > 1)  It is unlocked N-1 times, need N locks to lock it
+ *  0          It is locked - no waiters
+ *  -1         It is locked - one or more waiters
+ *
+ * Acquisition of unlocked futex:
+ *
+ *    locker process is in userspace, atomically decreases the futex,
+ *    if the value its zero, you got it. 
+ *
+ * Acquisition of locked futex:
+ *
+ *    locker tries to lock, sees it is not one, so it goes down to the
+ *    kernel and either wait or assign an fd/signal (when you get it
+ *    the waiter is woken up or the fd is signalled - eg: select()) 
+ *
+ * Release of locked futex:
+ *
+ *    releaser goes to the kernel, says 'release', the kernel wakes up
+ *    or signals as many waiters waiting on the futex as the releaser
+ *    indicates.
+ *
+ *
+ * INNER KERNEL THEORY OF OPERATION
+ *
+ * Each futex is uniquely identified to a page+offset pair. Associated
+ * to it there is an 'struct futex_q'; a hash table protected by
+ * futex_lock is used to keep all the futex_q together.
+ *
+ * Waiters put the wait information [task, fd, signal...] in struct
+ * futex_w, that is added to the priority array in the futex_q.
+ *
+ * When locking, [futex_wait(), futex_fd()] a futex_q is looked up
+ * in the hash table [__get_futex_q()]; if none, a new one is created
+ * [maybe_new_futex_q] and the waiter data is initialized and added to
+ * it [queue_me]; futex_w->q indicates the state [queued/unqueued].
+ *
+ * When unlocking, futex_wake() locates the futex_q for the futex and
+ * then tell_waiters() selects the first N waiters to be woken up [N =
+ * param to futex_wake]. Then it removes the waiters from the futex_q;
+ * when done, if the futex_q is empty, it is disposed.
+ *
+ *
+ * QUICK ROADMAP:
+ *
+ * *_futex_q() functions to alloc/initialize/insert in hash and
+ *             destroy and dispose a futex_q.
+ * 
+ * sys_futex() Multiplex to futex_fd(), futex_wait() or futex_wake()
  */
+
 #include <linux/slab.h>
 #include <linux/poll.h>
 #include <linux/file.h>
@@ -37,24 +104,65 @@
 
 #define FUTEX_HASHBITS 8
 
+#define FUTEX_DEBUG 0
+
+#define futex_fdebug(f, a...)                           \
+if (f) {                                                \
+        printk ("futex-debug: %s ", __FUNCTION__);      \
+        printk (a);                                     \
+}
+
+#define futex_debug(a...) futex_fdebug (FUTEX_DEBUG, a);
+
+
+/*
+ * This is a guy waiting for the futex
+ * 
+ * q is needed so that when the vcache callback is called, from the
+ * vcache we can get the futex_w, and to be able to remove the futex_w
+ * from the futex_q maintaining the pqueue semantics, we need to know
+ * the futex_q ... so there it is.
+ *
+ * Being there, it also serves to denote status. If (w->q != NULL), it
+ * means that the futex_w is in a list, and thus, w->list is valid. If
+ * NULL, it is outside of any list. [Use futex_w_is_queued()].
+ */
+
+struct futex_w {
+        struct list_head list;
+        struct futex_q *q;     /* damn it ... need a backpointer */
+        wait_queue_head_t waiters;
+        
+        /* the virtual => physical COW-safe cache */
+        vcache_t vcache;
+        task_t *task;
+        int fd;
+        struct file *filp;
+};
+
+
+/* Test if the futex_w is queued */
+
+static inline
+int futex_w_is_queued (const struct futex_w *w)
+{
+        return w->q != NULL;
+}
+
+
 /*
- * We use this hashed waitqueue instead of a normal wait_queue_t, so
- * we can wake only the relevent ones (hashed queues may be shared):
+ * For every unique futex we have one of these; it contains a list of the
+ * people who is waiting for the futex to be released.
  */
 struct futex_q {
 	struct list_head list;
-	wait_queue_head_t waiters;
+        spinlock_t lock;
 
 	/* Page struct and offset within it. */
 	struct page *page;
 	int offset;
 
-	/* the virtual => physical COW-safe cache */
-	vcache_t vcache;
-
-	/* For fd, sigio sent using these. */
-	int fd;
-	struct file *filp;
+        struct prio_array pa;
 };
 
 /* The key for the hash is the address + index + offset within page */
@@ -66,6 +174,7 @@
 /* Futex-fs vfsmount entry: */
 static struct vfsmount *futex_mnt;
 
+
 /*
  * These are all locks that are necessery to look up a physical
  * mapping safely, and modify/search the futex hash, atomically:
@@ -73,17 +182,17 @@
 static inline void lock_futex_mm(void)
 {
 	spin_lock(&current->mm->page_table_lock);
-	spin_lock(&vcache_lock);
 	spin_lock(&futex_lock);
 }
 
+
 static inline void unlock_futex_mm(void)
 {
 	spin_unlock(&futex_lock);
-	spin_unlock(&vcache_lock);
 	spin_unlock(&current->mm->page_table_lock);
 }
 
+
 /*
  * The physical page is shared, so we can hash on its address:
  */
@@ -93,25 +202,173 @@
 							FUTEX_HASHBITS)];
 }
 
-/* Waiter either waiting in FUTEX_WAIT or poll(), or expecting signal */
-static inline void tell_waiter(struct futex_q *q)
+
+/*
+ * Check out if there is an struct futex_q for the page and
+ * offset given in the hash table; if there is, return it;
+ *
+ * Hold the lock on futex_lock or expect problems ...
+ *
+ * FIXME: looking up backwards would help futex_wait()
+ */
+
+static inline
+struct futex_q * __get_futex_q (struct page *page, unsigned offset)
 {
-	wake_up_all(&q->waiters);
-	if (q->filp)
-		send_sigio(&q->filp->f_owner, q->fd, POLL_IN);
+        struct list_head *i, *head;
+        struct futex_q *q;
+        
+        futex_debug ("(page %p, offset %u)\n", page, offset);
+        
+        head = hash_futex (page, offset);
+        list_for_each (i, head) {
+		q = list_entry (i, struct futex_q, list);
+                if (q->page == page && q->offset == offset)
+                        return q;
+	}
+        /* Didn't find it */
+        return NULL;
 }
 
+
+/*
+ * Allocate an struct futex_q, initialize it and add it to the hash.
+ *
+ * gfp = GFP_{KERNEL,ATOMIC} for kmalloc()
+ *
+ * This will NOT acquire any locks
+ */
+
+static inline
+struct futex_q * new_futex_q (struct page *page, unsigned offset, int gfp)
+{
+        struct futex_q *q;
+        
+        futex_debug ("(page %p, offset %u, gfp %d)\n", page, offset, gfp);
+        
+        if ((q = kmalloc (sizeof (struct futex_q), gfp)) != NULL) {
+                q->page = page;
+                q->offset = offset;
+                spin_lock_init (&q->lock);
+                pa_init (&q->pa);
+        }
+        return q;
+}
+
+
+/* Create a new futex_q and MAYBE insert it into the hash table
+ *
+ * From the time we checked with __get_futex_q() if there was a
+ * futex_q for the page and offset combination requested, there might
+ * have been another thread, task or process that did the same and
+ * created and inserted into the hash table a futex_q for it (because
+ * we dropped the lock so we could use GFP_KERNEL). Thus, we need to
+ * allocate and then check again [now with the lock held], and if not
+ * there, insert it; if there, we need to use that and drop the
+ * allocation.
+ *
+ * If we are using the one we allocated, it is returned; if not [we
+ * reused something somebody put in the list], it returns NULL. In any
+ * case, the futex_q we have to use is put in *pq (NULL if out of
+ * memory).
+ *
+ * This ugly return scheme is needed for the error handling paths in
+ * futex_wait().
+ */
+
+static inline
+struct futex_q * maybe_new_futex_q (struct futex_q **pq,
+                                    struct page *page, unsigned offset)
+{
+        struct futex_q *q, *qp;
+        
+        futex_debug ("(page %p, offset %u)\n", page, offset);
+
+        q = new_futex_q (page, offset, GFP_KERNEL);
+        if (unlikely (q == NULL)) {
+                *pq = NULL;
+                goto out_err;
+        }
+
+        spin_lock (&futex_lock);
+        qp = __get_futex_q (q->page, q->offset);
+        if (unlikely (qp != NULL)) {
+                kfree (q);
+                *pq = qp;
+                q = NULL;
+        }
+        else {
+                list_add_tail (&q->list, hash_futex (page, offset));
+                *pq = q;
+        }
+        spin_unlock (&futex_lock);
+out_err:
+        return q;
+}
+
+
+/* Remove an struct futex_q from the hash table and free it */
+static inline
+void __put_futex_q (struct futex_q *q)
+{
+        futex_debug ("(q %p)\n", q);
+        
+        /* FIXME: may be we want to cache them and free when they are
+         * kind of old or need more [__get_futex_q() should be
+         * involved]. I say that because in a multithreaded program
+         * that has lots of contention, well, the allocator is going
+         * to suffer.
+         */
+        list_del (&q->list);
+        kfree (q);
+}
+        
+
+/* If the 'struct futex_q' is still in use, do nothing; however, if
+ * empty, remove it from the hash table and release it. */
+static inline
+void __maybe_put_futex_q (struct futex_q *q)
+{
+        futex_debug ("(q %p)\n", q);
+        
+        /* Is the futex_q empty? wipe it out
+         * FIXME: may be we want to cache them and free when they are
+         * kind of old or need more [__get_futex_q() should be
+         * involved]. I say that because in a multithreaded program
+         * that has lots of contention, well, the allocator is going
+         * to suffer.
+         */
+        if (q->pa.nr_active == 0) {
+                __put_futex_q (q);
+        }
+}
+
+
+static inline
+void maybe_put_futex_q (struct futex_q *q)
+{
+        futex_debug ("(q %p)\n", q);
+        if (unlikely (q->pa.nr_active == 0)) {
+                spin_lock (&futex_lock);
+                __maybe_put_futex_q (q);
+                spin_unlock (&futex_lock);
+        }
+}
+
+
 /*
  * Get kernel address of the user page and pin it.
  *
  * Must be called with (and returns with) all futex-MM locks held.
  */
-static struct page *__pin_page(unsigned long addr)
+static struct page *__pin_page (unsigned long addr)
 {
 	struct mm_struct *mm = current->mm;
 	struct page *page, *tmp;
 	int err;
 
+        futex_debug ("(addr %lx)\n", addr);
+        
 	/*
 	 * Do a quick atomic lookup first - this is the fastpath.
 	 */
@@ -150,214 +407,376 @@
 	return page;
 }
 
-static inline void unpin_page(struct page *page)
+
+static inline void unpin_page (struct page *page)
+{
+        futex_debug ("(page %p)\n", page);
+	put_page (page);
+}
+
+
+static void futex_vcache_callback (vcache_t *, struct page *);
+
+/* Enqueue a waiter in a futex_q obtained from __get_futex_q() [need
+ * to lock q->lock].
+ */
+static inline
+void queue_me (struct futex_q *q, struct futex_w *w, unsigned long uaddr)
+{
+        spin_lock (&q->lock);
+        pa_enqueue (&w->list, w->task->prio, &q->pa);
+        w->q = q;
+	/* We register a futex callback to this virtual address,
+	 * to make sure a COW properly rehashes the futex-queue. */
+	attach_vcache(&w->vcache, uaddr, current->mm, futex_vcache_callback);
+        spin_unlock (&q->lock);
+}
+
+
+/* Unqueue. No need to lock. Return 1 if we were still queued (ie. 0
+ * means we were woken).
+ *
+ * The locking version return the page to ease out the race-condition
+ * free code in futex_close(). If it returns NULL, it means the
+ * futex_w waiter was not waiting for anything - if it returns the
+ * page address, it means it was waiting for a futex in that page.
+ */
+
+static inline
+void __unqueue_me (struct futex_w *w)
+{
+        futex_debug ("(w %p)\n", w);
+        
+        detach_vcache (&w->vcache);
+        pa_dequeue (&w->list, w->task->prio, &w->q->pa);
+        w->q = NULL;
+}
+
+static inline
+struct page * unqueue_me (struct futex_w *w)
+{
+        struct futex_q *q = w->q;
+        struct page *page = NULL;
+        
+        futex_debug ("(w %p)\n", w);
+        
+        if (q) {
+                spin_lock (&q->lock);
+                page = w->q->page;
+                __unqueue_me (w);
+                spin_unlock (&q->lock);
+                maybe_put_futex_q (q);
+        }
+        return page;
+}
+
+
+/* Wake up as many guys as needed who are waiting for a futex
+ *
+ * howmany == UINTMAX means wake them up all, 1 wake only the first one, 2
+ * the two first ones ...
+ *
+ * It is not our task to kfree [if needed] the futex_w struct;
+ * that will be done either by when the filp is destroyed [it is the
+ * filp's private data or on exit of futex_wait() [it is a local
+ * there].
+ *
+ * However, if there are no more tasks waiting ... fousch, we wipe the
+ * futex_q. NEED TO HOLD THE FUTEX_LOCK WHEN CALLING THIS FUNCTION.
+ *
+ * Tasks are waken up by priority order; O(1).
+ *
+ * Returns how many tasks were woken up.
+ */
+
+static
+int tell_waiters (struct futex_q *q, unsigned howmany)
 {
-	put_page(page);
+        struct futex_w *w;
+        unsigned index;
+        int ret = 0;
+        
+        futex_debug ("(q %p, howmany %d): waking up waiters, %d waiting\n",
+                     q, howmany, q->pa.nr_active);
+        if (!q)
+                BUG();
+
+        spin_lock (&q->lock);
+        if (unlikely (q->pa.nr_active == 0)) { /* Every body chickened out ... */
+                futex_debug ("(q %p, howmany %d): No active "
+                             "tasks on the pqueue\n", q, howmany);
+                goto exit_put;
+        }
+        
+        while (ret < howmany) {
+                index = sched_find_first_bit (q->pa.bitmap);
+                w = list_entry (q->pa.queue[index].next, struct futex_w, list);
+
+                __unqueue_me (w);
+                wake_up_process (w->task);
+                if (w->filp)
+                        send_sigio (&w->filp->f_owner, w->fd, POLL_IN);
+                ret++;
+                
+                if (q->pa.nr_active == 0) /* no more */
+                        goto exit_put;
+        }
+        spin_unlock (&q->lock);
+        return ret;
+
+    exit_put:
+        spin_unlock (&q->lock);
+        __put_futex_q (q);
+        return ret;
 }
 
+
 /*
  * Wake up all waiters hashed on the physical page that is mapped
- * to this virtual address:
+ * to this virtual address.
+ *
+ * There is only one futex_q per futex, so once we find it, we just
+ * exit.
  */
-static int futex_wake(unsigned long uaddr, int offset, int num)
+
+static inline
+int futex_wake (unsigned long uaddr, int offset, int num)
 {
-	struct list_head *i, *next, *head;
 	struct page *page;
+        struct futex_q *q;
 	int ret = 0;
 
-	lock_futex_mm();
+        futex_debug ("(uaddr %lx, offset %d, num %d)\n",
+                     uaddr, offset, num);
 
-	page = __pin_page(uaddr - offset);
+	lock_futex_mm();
+	page = __pin_page (uaddr - offset);
 	if (!page) {
 		unlock_futex_mm();
 		return -EFAULT;
 	}
-
-	head = hash_futex(page, offset);
-
-	list_for_each_safe(i, next, head) {
-		struct futex_q *this = list_entry(i, struct futex_q, list);
-
-		if (this->page == page && this->offset == offset) {
-			list_del_init(i);
-			__detach_vcache(&this->vcache);
-			tell_waiter(this);
-			ret++;
-			if (ret >= num)
-				break;
-		}
-	}
-
+        q = __get_futex_q (page, offset);
+        if (q)
+                ret = tell_waiters (q, num);
 	unlock_futex_mm();
-	unpin_page(page);
-
+        unpin_page (page);
 	return ret;
 }
 
+
 /*
  * This gets called by the COW code, we have to rehash any
  * futexes that were pending on the old physical page, and
  * rehash it to the new physical page. The pagetable_lock
  * and vcache_lock is already held:
  */
-static void futex_vcache_callback(vcache_t *vcache, struct page *new_page)
-{
-	struct futex_q *q = container_of(vcache, struct futex_q, vcache);
-	struct list_head *head = hash_futex(new_page, q->offset);
-
-	spin_lock(&futex_lock);
-
-	if (!list_empty(&q->list)) {
-		q->page = new_page;
-		list_del(&q->list);
-		list_add_tail(&q->list, head);
-	}
-
-	spin_unlock(&futex_lock);
-}
 
-static inline void __queue_me(struct futex_q *q, struct page *page,
-				unsigned long uaddr, int offset,
-				int fd, struct file *filp)
-{
-	struct list_head *head = hash_futex(page, offset);
-
-	q->offset = offset;
-	q->fd = fd;
-	q->filp = filp;
-	q->page = page;
-
-	list_add_tail(&q->list, head);
-	/*
-	 * We register a futex callback to this virtual address,
-	 * to make sure a COW properly rehashes the futex-queue.
-	 */
-	__attach_vcache(&q->vcache, uaddr, current->mm, futex_vcache_callback);
+static
+void futex_vcache_callback (vcache_t *vcache, struct page *new_page)
+{
+	struct futex_w *w = container_of (vcache, struct futex_w, vcache);
+        unsigned offset;
+        struct futex_q *old_q, *new_q;
+
+        futex_debug ("(vcache %p, page %p)\n", vcache, new_page);
+
+        spin_lock (&futex_lock);
+        old_q = w->q;
+        offset = old_q->offset;
+        
+        new_q = __get_futex_q (new_page, offset);
+        
+	if (old_q) {
+                spin_lock (&old_q->lock);
+                pa_dequeue (&w->list, w->task->prio, &old_q->pa);
+                spin_unlock (&old_q->lock);
+                __maybe_put_futex_q (old_q);
+        }
+
+        /* If there is no new queue [already], create it - use
+         * GFP_ATOMIC, as we hold the vcache and futex locks */ 
+        
+        if (new_q == NULL) {
+                new_q = new_futex_q (new_page, offset, GFP_ATOMIC);
+                if (unlikely (new_q == NULL))
+                        goto out_err;
+                list_add_tail (&new_q->list,
+                               hash_futex (new_page, offset));
+        }
+
+        spin_lock (&new_q->lock);
+        pa_enqueue (&w->list, w->task->prio, &new_q->pa);
+        spin_unlock (&new_q->lock);
+        spin_unlock (&futex_lock);
+        return;
+
+out_err:
+        /* Cannot create the futex_q, so let's wake it up and have
+         * it see it is still locked and it needs to call back into the
+         * kernel. It is already removed from the wait queue. */
+        w->q = NULL;
+        wake_up_process (w->task);
+        if (w->filp)
+                send_sigio (&w->filp->f_owner, w->fd, POLL_IN);
+        spin_unlock (&futex_lock);        
+        return;
 }
 
-/* Return 1 if we were still queued (ie. 0 means we were woken) */
-static inline int unqueue_me(struct futex_q *q)
-{
-	int ret = 0;
 
-	spin_lock(&vcache_lock);
-	spin_lock(&futex_lock);
-	if (!list_empty(&q->list)) {
-		list_del(&q->list);
-		__detach_vcache(&q->vcache);
-		ret = 1;
-	}
-	spin_unlock(&futex_lock);
-	spin_unlock(&vcache_lock);
-	return ret;
-}
+/* Wait for a futex to be released
+ *
+ * The process is simply pin the page where the futex is, get a
+ * futex_q, append to it futex_w we keep on the stack and wait.
+ *
+ * Watch out 'qp': for the error path, if set, it indicates we have
+ * allocated a futex_q and we have to put it.
+ *
+ * Return 0   if everything went ok
+ *        < 0 errno code on error
+ */
 
-static int futex_wait(unsigned long uaddr,
-		      int offset,
-		      int val,
-		      unsigned long time)
+static
+int futex_wait (unsigned long uaddr, int offset, int val, unsigned long time)
 {
-	DECLARE_WAITQUEUE(wait, current);
 	int ret = 0, curval;
 	struct page *page;
-	struct futex_q q;
+	struct futex_w w;
+        struct futex_q *q, *qp = NULL;
 
-	init_waitqueue_head(&q.waiters);
+        futex_debug ("(uaddr %lx, offset %d, val %d, time %lu)\n",
+                     uaddr, offset, val, time);
 
+        /* Get the futex_q for this futex after locking the page */
 	lock_futex_mm();
-
-	page = __pin_page(uaddr - offset);
+	page = __pin_page (uaddr - offset);
 	if (!page) {
 		unlock_futex_mm();
 		return -EFAULT;
 	}
-	__queue_me(&q, page, uaddr, offset, -1, NULL);
-
+	q = __get_futex_q (page, offset);
 	unlock_futex_mm();
 
+        /* No futex_q? get a new one, check mid-air collision */
+        if (q == NULL) {
+                qp = maybe_new_futex_q (&q, page, offset);
+                if (unlikely (q == NULL)) {
+                        ret = -ENOMEM;
+                        goto out_unpin;
+                }
+        }
+        
 	/* Page is pinned, but may no longer be in this address space. */
-	if (get_user(curval, (int *)uaddr) != 0) {
+	if (get_user (curval, (int *) uaddr) != 0) {
 		ret = -EFAULT;
-		goto out;
+		goto out_err;
 	}
 	if (curval != val) {
 		ret = -EWOULDBLOCK;
-		goto out;
+		goto out_err;
 	}
-	/*
+
+        /*
 	 * The get_user() above might fault and schedule so we
 	 * cannot just set TASK_INTERRUPTIBLE state when queueing
-	 * ourselves into the futex hash. This code thus has to
+	 * ourselves into the futex_q. This code thus has to
 	 * rely on the FUTEX_WAKE code doing a wakeup after removing
 	 * the waiter from the list.
 	 */
-	add_wait_queue(&q.waiters, &wait);
-	set_current_state(TASK_INTERRUPTIBLE);
-	if (!list_empty(&q.list))
+
+        INIT_LIST_HEAD (&w.list);
+        w.q = NULL;
+          
+        w.task = current;
+	w.fd = -1;
+	w.filp = NULL;
+
+        queue_me (q, &w, uaddr);
+        set_current_state (TASK_INTERRUPTIBLE);
+	if (futex_w_is_queued (&w))       /* aka: if we are queued */
 		time = schedule_timeout(time);
-	set_current_state(TASK_RUNNING);
-	/*
-	 * NOTE: we dont remove ourselves from the waitqueue because
-	 * we are the only user of it.
-	 */
-	if (time == 0) {
+	set_current_state (TASK_RUNNING);
+
+        /* Now, what happened? */
+        if (time == 0) {
 		ret = -ETIMEDOUT;
 		goto out;
 	}
-	if (signal_pending(current))
+	if (signal_pending (current))
 		ret = -EINTR;
 out:
-	/* Were we woken up anyway? */
-	if (!unqueue_me(&q))
+	if (!unqueue_me (&w))
 		ret = 0;
-	unpin_page(page);
+out_unpin:
+ 	unpin_page (page);
+	return ret;
 
+out_err:
+        /* We allocated it and won't use it, but somebody could have
+         * done it in the midle. */
+        if (qp) {
+                spin_lock (&futex_lock);
+                __maybe_put_futex_q (qp);
+                spin_unlock (&futex_lock);
+        }
+ 	unpin_page (page);
 	return ret;
 }
 
-static inline int futex_wait_utime(unsigned long uaddr,
-		      int offset,
-		      int val,
-		      struct timespec* utime)
-{
-	unsigned long time = MAX_SCHEDULE_TIMEOUT;
-
-	if (utime) {
-		struct timespec t;
-		if (copy_from_user(&t, utime, sizeof(t)) != 0)
-			return -EFAULT;
-		time = timespec_to_jiffies(&t) + 1;
-	}
+static inline
+int futex_wait_utime (unsigned long uaddr, int offset, int val,
+                      struct timespec *utime)
+{
+        unsigned long time = MAX_SCHEDULE_TIMEOUT;
+
+        if (utime) {
+                struct timespec t;
+                if (copy_from_user (&t, utime, sizeof (t)) != 0)
+                        return -EFAULT;
+                time = timespec_to_jiffies (&t) + 1;
+        }
 
-	return futex_wait(uaddr, offset, val, time);
+        return futex_wait (uaddr, offset, val, time);
 }
 
-static int futex_close(struct inode *inode, struct file *filp)
+
+/*
+ * Close the fd associated with a futex, cleanup the futex too.
+ */
+
+static
+int futex_close (struct inode *inode, struct file *filp)
 {
-	struct futex_q *q = filp->private_data;
+	struct futex_w *w = filp->private_data;
+        struct page *page;
 
-	unqueue_me(q);
-	unpin_page(q->page);
-	kfree(filp->private_data);
+        page = unqueue_me (w);
+        if (page)
+          unpin_page (page);
+        kfree (filp->private_data);
 	return 0;
 }
 
+
 /* This is one-shot: once it's gone off you need a new fd */
-static unsigned int futex_poll(struct file *filp,
-			       struct poll_table_struct *wait)
+static
+unsigned int futex_poll (struct file *filp,
+                         struct poll_table_struct *wait)
 {
-	struct futex_q *q = filp->private_data;
+	struct futex_w *w = filp->private_data;
 	int ret = 0;
 
-	poll_wait(filp, &q->waiters, wait);
-	spin_lock(&futex_lock);
-	if (list_empty(&q->list))
+        futex_debug ("(filp %p, wait %p)\n", filp, wait);
+
+	poll_wait (filp, &w->waiters, wait);
+	spin_lock (&futex_lock); /* Lock only q? */
+	if (!futex_w_is_queued (w))
 		ret = POLLIN | POLLRDNORM;
-	spin_unlock(&futex_lock);
+	spin_unlock (&futex_lock);
 
 	return ret;
 }
 
+
 static struct file_operations futex_fops = {
 	.release	= futex_close,
 	.poll		= futex_poll,
@@ -365,25 +784,29 @@
 
 /* Signal allows caller to avoid the race which would occur if they
    set the sigio stuff up afterwards. */
-static int futex_fd(unsigned long uaddr, int offset, int signal)
+static int futex_fd (unsigned long uaddr, int offset, int signal)
 {
 	struct page *page = NULL;
 	struct futex_q *q;
+	struct futex_w *w;
 	struct file *filp;
-	int ret;
+	int ret, fd;
 
 	ret = -EINVAL;
 	if (signal < 0 || signal > _NSIG)
-		goto out;
+		goto out_err;
 
+        /* Set up a file descriptor to wait on. */
+        
 	ret = get_unused_fd();
 	if (ret < 0)
-		goto out;
+		goto out_err;
+        fd = ret;
+        
 	filp = get_empty_filp();
 	if (!filp) {
-		put_unused_fd(ret);
 		ret = -ENFILE;
-		goto out;
+		goto out_err_get_empty_filp;
 	}
 	filp->f_op = &futex_fops;
 	filp->f_vfsmnt = mntget(futex_mnt);
@@ -393,55 +816,82 @@
 		int ret;
 		
 		ret = f_setown(filp, current->tgid, 1);
-		if (ret) {
-			put_unused_fd(ret);
-			put_filp(filp);
-			goto out;
-		}
+		if (ret)
+			goto out_err_f_setown;
 		filp->f_owner.signum = signal;
 	}
 
-	q = kmalloc(sizeof(*q), GFP_KERNEL);
-	if (!q) {
-		put_unused_fd(ret);
-		put_filp(filp);
-		ret = -ENOMEM;
-		goto out;
-	}
-
+        /* Pull out what page the futex is at, pin it down so it does not
+         * dissapear off to swap space. */
+        
 	lock_futex_mm();
-
 	page = __pin_page(uaddr - offset);
 	if (!page) {
-		unlock_futex_mm();
-
-		put_unused_fd(ret);
-		put_filp(filp);
-		kfree(q);
-		return -EFAULT;
+                unlock_futex_mm();
+                ret = -EFAULT;
+                goto out_err_pin_page;
+	}
+
+        /* Pull out the futex queue corresponding to the futex. Create
+         * one if none. */
+        
+        q = __get_futex_q (page, offset);
+        unlock_futex_mm();
+        if (q == NULL) {
+                maybe_new_futex_q (&q, page, offset);
+                if (unlikely (q == NULL)) {
+                        ret = -ENOMEM;
+                        goto out_err_get_futex_q;
+                }
+        }
+
+        /* Create a waiter structure, initialize it and queue it in
+         * the futex queue. */
+        
+	w = kmalloc (sizeof (*w), GFP_KERNEL);
+	if (w == NULL) {
+		ret = -ENOMEM;
+		goto out_err_w_kmalloc;
 	}
 
-	init_waitqueue_head(&q->waiters);
-	filp->private_data = q;
+        INIT_LIST_HEAD (&w->list);
+	init_waitqueue_head (&w->waiters);
+        w->q = NULL;
+        w->task = current;
+        w->fd = fd;
+        w->filp = filp;
+        filp->private_data = w;
 
-	__queue_me(q, page, uaddr, offset, ret, filp);
-
-	unlock_futex_mm();
+	queue_me (q, w, uaddr);
 
 	/* Now we map fd to filp, so userspace can access it */
-	fd_install(ret, filp);
-	page = NULL;
-out:
-	if (page)
-		unpin_page(page);
+	fd_install (ret, filp);
 	return ret;
+
+out_err_w_kmalloc:
+        maybe_put_futex_q (q);
+out_err_get_futex_q:
+        unpin_page (page);
+out_err_pin_page:
+out_err_f_setown:
+        put_filp (filp);
+out_err_get_empty_filp:
+        put_unused_fd (fd);
+out_err:
+        return ret;
 }
 
-asmlinkage int sys_futex(unsigned long uaddr, int op, int val, struct timespec *utime)
+
+/* System call for the futex: multiplex the actual operation */
+
+asmlinkage
+int sys_futex (unsigned long uaddr, int op, int val, struct timespec *utime)
 {
 	unsigned long pos_in_page;
 	int ret;
 
+        futex_debug ("(%lx, %d, %d, %p)\n", uaddr, op, val, utime);
+
 	pos_in_page = uaddr % PAGE_SIZE;
 
 	/* Must be "naturally" aligned */
@@ -450,14 +900,14 @@
 
 	switch (op) {
 	case FUTEX_WAIT:
-		ret = futex_wait_utime(uaddr, pos_in_page, val, utime);
+		ret = futex_wait_utime (uaddr, pos_in_page, val, utime);
 		break;
 	case FUTEX_WAKE:
-		ret = futex_wake(uaddr, pos_in_page, val);
+		ret = futex_wake (uaddr, pos_in_page, val);
 		break;
 	case FUTEX_FD:
 		/* non-zero val means F_SETOWN(getpid()) & F_SETSIG(val) */
-		ret = futex_fd(uaddr, pos_in_page, val);
+		ret = futex_fd (uaddr, pos_in_page, val);
 		break;
 	default:
 		ret = -EINVAL;


-- 

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my fault]
