Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262289AbTA2B7n>; Tue, 28 Jan 2003 20:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbTA2B7n>; Tue, 28 Jan 2003 20:59:43 -0500
Received: from fmr06.intel.com ([134.134.136.7]:47053 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S262289AbTA2B7R>; Tue, 28 Jan 2003 20:59:17 -0500
Message-ID: <15927.14125.914583.577168@milikk.co.intel.com>
Date: Tue, 28 Jan 2003 18:06:37 -0800
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: [PATCH 2.5.59] pfutex-1.2: Priority-based/real-time futexes
To: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, mingo@redhat.com
X-Mailer: VM 7.07 under Emacs 21.2.2
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
O(1) except futex_q_find() [and callers], that are O(N /
2^FUTEX_HASHBITS).

Changelog since last patch:

 v1.2

 - Updated documentation

 - Enhanced allocation of struct futex_q. 

   On applications with a low contention rate, we don't want to be
   allocating and deallocating an struct futex_q every time just
   because the futex is locked by nobody, one or two people in a
   random distribution. If the slab is there, the futex_q will
   remain allocated, so acquisition will be faster and
   fragmentation lower. When memory is tight, and it is not used,
   it will be released.

   The slab allocator reduces the pressure on the VM and to avoid
   the lengthy pa_init() call. There is also a recycle list that
   will keep a futex_q allocated for ten seconds before returning
   it to the slab - in the event it is needed again, it is used,
   or if a new futex_q is required, it will be taken from the
   recycle list if there is any. Asides, each time we allocate
   without GFP_ATOMIC, we have to release the lock and then, when
   reacquired, check that nobody added a futex_q for our futex;
   that takes time and this alleviates it.

 - Added the priority to the struct futex_w, so we do proper
   house-keeping in the pa_*() functions if the task changes
   priority when queued. This will require more work.

 - Tried to simplify locking a wee bit ... not much though. 

Older changelog:

 v1.1

 - vcache callback: having to create a new futex_q struct in the
   callback creates a failure point if there is no more GFP_ATOMIC
   space; the corresponding waiter would be deattached from any
   futex_q and thus, lay there sleeping for ever.

   The only sollution I can think of is wake it up, so it goes up
   to user space, sees the count is still -1 [or whatever] and if
   required, go back down to the kernel and sleep there.

 - Added futex_wait_utime() split by Luca Barbieri.

 - NGPT's test program 'test_str03 -b 5 -d 5' using futexes as
   spinlocks now works, before it deadlocked. I think I was
   hitting the deadlock in futex_wait(), that was kind of ugly.

 v1.0

 - Define futex_w_is_queued() so we don't test manually q->NULL
   [in case it changes IANF].

 - Some silly pretty print and cosmetic changes. 

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

   I am thinking that I could split the queue implementation from
   the actual futex_q; when the first waiter comes in, depending
   on the priority, a priority based or normal one will be used
   depending on it being real-time or not. If it is a normal one,
   whenever a new waiter comes in it is transformed to a real-time
   one if the waiter is real-time ... sounds too complex, though
   ... 

 - I took special care not to miss anything allocated when it
   should, but I could have screwed up ...

I used a combination of code that I borrowed from NGPT, Rusty's 
user space sample library + some of my own to test it. It is 
basically a shared area and futex_down and futex_up programs
that can be called from the shell. I gave it a few hard times
and it resisted pretty well - however, I probably missed many
cases. Find it at:

http://sost.net/pub/linux/pfutex-test.tar.gz

Enjoy

This patch requires the following patches and kernel version:

linux-2.5.59 prioarray-1.0 

diff -u linux/include/linux/vcache.h:1.1.1.1 linux/include/linux/vcache.h:1.1.1.1.4.1
--- linux/include/linux/vcache.h:1.1.1.1	Wed Dec 11 11:06:00 2002
+++ linux/include/linux/vcache.h	Mon Dec 16 17:46:07 2002
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
diff -u linux/kernel/futex.c:1.1.1.1.2.1 linux/kernel/futex.c:1.1.1.1.4.11
--- linux/kernel/futex.c:1.1.1.1.2.1	Wed Dec 11 13:28:03 2002
+++ linux/kernel/futex.c	Tue Jan 28 17:28:21 2003
@@ -11,6 +11,8 @@
  *
  *  Generalized futexes for every mapping type, Ingo Molnar, 2002
  *
+ *  Priority-based wake up support (C) 2002 Intel Corp, Inaky
+ *  Perez-Gonzalez <inaky.perez-gonzalez@intel.com>.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -24,8 +26,81 @@
  *
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307  USA
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
+ * When locking, [futex_wait(), futex_fd()] a futex_q is looked up in
+ * the hash table [__futex_q_get()->__futex_q_find()]; if not found,
+ * one is reclaimed from the ones that are in the 'recycle_list' [no
+ * waiters on them for less than FUTEX_RECYCLE_PERIOD]; if that fails,
+ * a new one is created from an slab cache and the waiter data is
+ * initialized and added to it [queue_me].
+ *
+ * When unlocking, futex_wake() locates the futex_q for the futex and
+ * then tell_waiters() selects the first N waiters to be woken up [N =
+ * param to futex_wake]. Then it removes the waiters from the futex_q;
+ * when done, if the futex_q is empty, it is disposed.
+ *
+ * futex_w->q indicates the state [queued/unqueued].
+ *
+ * list_empty(futex_q->recycle_list) indicates if a futex_q is in the
+ * list to be released to the slab cache.
+ *
+ * QUICK ROADMAP:
+ *
+ * futex_q_*() Functions to alloc/initialize/insert in hash and
+ *             destroy and dispose a futex_q.
+ * 
+ * sys_futex() Multiplex to futex_fd(), futex_wait() or futex_wake()
+ *
+ * futex_q_recycle_run() Called by a timer every
+ *             FUTEX_RECYCLE_PERIOD. Goes through the recycle list and
+ *             removes from the hash and releases to the slab every
+ *             futex_q that has been visited before once.
  */
+
 #include <linux/slab.h>
 #include <linux/poll.h>
 #include <linux/file.h>
@@ -34,84 +109,414 @@
 #include <linux/futex.h>
 #include <linux/vcache.h>
 #include <linux/mount.h>
+#include <linux/timer.h>   /* For the recycle timer */
 
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
+/* The key for the hash is the address + index + offset within page */
+static struct list_head futex_queues[1<<FUTEX_HASHBITS];
+static struct list_head recycle_list = LIST_HEAD_INIT (recycle_list);
+static spinlock_t futex_lock = SPIN_LOCK_UNLOCKED; /* hash lock */
+
+/* Futex-fs vfsmount entry: */
+static struct vfsmount *futex_mnt;
+
+/* Recycle timer */
+static struct timer_list timer;
+#define FUTEX_RECYCLE_PERIOD 10  /* recycle every ten seconds */
+
+/* Cache allocators (SLABs) */
+#define CACHE_CREATE_FLAGS 0
+static kmem_cache_t *futex_q_slab = NULL;
+static kmem_cache_t *futex_w_slab = NULL;
+
+/* Misc */
+extern void send_sigio (struct fown_struct *fown, int fd, int band);
+
+
 /*
- * We use this hashed waitqueue instead of a normal wait_queue_t, so
- * we can wake only the relevent ones (hashed queues may be shared):
+ * This is a guy waiting for the futex
+ * 
+ * q is needed so that when the vcache callback is called, from the
+ * vcache we can get the futex_w, and to be able to remove the futex_w
+ * from the futex_q maintaining the priority queue semantics, we need
+ * to know the futex_q ... so there it is.
+ *
+ * Being there, it also serves to denote status. If (w->q != NULL), it
+ * means that the futex_w is in a list, and thus, w->list is valid. If
+ * NULL, it is outside of any list. [Use futex_w_is_queued()].
+ *
+ * We need the priority field [versus w->task->prio] because if the
+ * priority of the task is changed while queued, then we would trying
+ * to peek with the wrong priority.
  */
+
+struct futex_w {
+        struct list_head list;
+        struct futex_q *q;     /* damn it ... need a backpointer */
+        wait_queue_head_t waiters;
+        
+        /* the virtual => physical COW-safe cache */
+        vcache_t vcache;
+        task_t *task;
+        int prio;
+        int fd;
+        struct file *filp;
+};
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
+/*
+ * For every different futex we have one of these; it contains a list
+ * of the people who is waiting for the futex to be released (futex_w).
+ */
+
+#define FUTEX_RECYCLE_VISITED 0x01   /* Flag for futex_recycle_run() */
+
 struct futex_q {
 	struct list_head list;
-	wait_queue_head_t waiters;
-
+        struct list_head recycle_list;
+        unsigned long flags;
+        
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
 
-/* The key for the hash is the address + index + offset within page */
-static struct list_head futex_queues[1<<FUTEX_HASHBITS];
-static spinlock_t futex_lock = SPIN_LOCK_UNLOCKED;
 
-extern void send_sigio(struct fown_struct *fown, int fd, int band);
+/* Initialize a futex_q
+ *
+ * We initialize all but list, page, offset, which are always
+ * initialized [has to] by the futex_wait() or futex_fd() code when
+ * they request the creation of one of these. PA is so expensive to
+ * initialize that the slab code will initialize them when put into a
+ * cache and then we will keep them consistent through-out their
+ * life.
+ */
+
+static inline
+void futex_q_init (struct futex_q *q,
+                   struct page *page, unsigned offset)
+{
+        futex_debug ("(q %p, page %p, offset %u)\n", q, page, offset);
+        q->flags = 0;
+        INIT_LIST_HEAD (&q->recycle_list);
+        pa_init (&q->pa);
+}
+
+
+/* Test if the futex_q is used */
+
+static inline
+int futex_q_is_used (const struct futex_q *q)
+{
+        return q->pa.nr_active > 0;
+}
+
+
+/* Slab object constructor, just call futex_q_init() */
+
+void futex_q_ctor (void *obj, kmem_cache_t *slab, unsigned long flags)
+{
+        futex_debug ("(obj = %p, slab = %p, flags = 0x%lx)\n",
+                     obj, slab, flags);
+        futex_q_init (obj, NULL, 0);
+}
+
+
+/* Slab object destructor and flags, they differ on debug
+ *
+ * The destructor does nothing, except on debug, where it will check
+ * some stuff for consistency ... well, not so far ...
+ */
+
+#if FUTEX_DEBUG == 0
+void (*futex_q_dtor) (void *, kmem_cache_t *, unsigned long ) = NULL;
+#else
+void futex_q_dtor (void *obj, kmem_cache_t *slab, unsigned long flags)
+{
+        futex_debug ("(obj = %p, slab = %p, flags = 0x%lx)\n",
+                     obj, slab, flags);
+                /* Nothing by now ... it worked at the first try :] */
+}
+#endif
 
-/* Futex-fs vfsmount entry: */
-static struct vfsmount *futex_mnt;
 
 /*
  * These are all locks that are necessery to look up a physical
- * mapping safely, and modify/search the futex hash, atomically:
+ * mapping safely.
  */
-static inline void lock_futex_mm(void)
+
+static inline
+void lock_mm (void)
 {
-	spin_lock(&current->mm->page_table_lock);
-	spin_lock(&vcache_lock);
-	spin_lock(&futex_lock);
+	spin_lock (&current->mm->page_table_lock);
 }
 
-static inline void unlock_futex_mm(void)
+
+static inline
+void unlock_mm(void)
 {
-	spin_unlock(&futex_lock);
-	spin_unlock(&vcache_lock);
-	spin_unlock(&current->mm->page_table_lock);
+	spin_unlock (&current->mm->page_table_lock);
 }
 
+
 /*
  * The physical page is shared, so we can hash on its address:
  */
-static inline struct list_head *hash_futex(struct page *page, int offset)
+
+static inline
+struct list_head *hash_futex (struct page *page, int offset)
 {
 	return &futex_queues[hash_long((unsigned long)page + offset,
-							FUTEX_HASHBITS)];
+                                       FUTEX_HASHBITS)];
+}
+
+
+/* Locates in the hash a futex_q for the given page and offset
+ *
+ * Needs to be called with the hash table's futex_lock held.
+ *
+ * _r searches from the tail of the list ... makes it faster to locate
+ * recent additions [check out __futex_q_get()]. 
+ *
+ * Mind these two functions WILL NOT REMOVE the futex_q from the recycle
+ * list if it is on it [marked by !list_empty(&q->recycle_list)].
+ *
+ * Returns: Pointer to the futex_q. 
+ *          NULL if not found.
+ */
+
+static inline
+struct futex_q * __futex_q_find (struct page *page, unsigned offset)
+{
+        struct list_head *i, *head;
+        struct futex_q *q;
+        
+        futex_debug ("(page %p, offset %x)\n", page, offset);
+
+        head = hash_futex (page, offset);
+        list_for_each (i, head) {
+		q = list_entry (i, struct futex_q, list);
+                if (q->page == page && q->offset == offset)
+                        return q;
+	}
+        /* Didn't find it */
+        return NULL;
+}
+
+static inline
+struct futex_q * __futex_q_find_r (struct page *page, unsigned offset)
+{
+        struct list_head *i, *head;
+        struct futex_q *q;
+        
+        futex_debug ("(page %p, offset %x)\n", page, offset);
+
+        head = hash_futex (page, offset);
+        list_for_each_prev (i, head) {
+		q = list_entry (i, struct futex_q, list);
+                if (q->page == page && q->offset == offset)
+                        return q;
+	}
+        /* Didn't find it */
+        return NULL;
+}
+
+
+/* Locates or allocates a futex_q for the given page and offset.
+ *
+ * Needs to be called with the futex_lock held.
+ *
+ * First we try to lookup one in the hash table; if there, get it,
+ * possibly removing it from the recycle list.
+ *
+ * If that failed, get the first one (as opposed to the last one, let
+ * it be hot for a possible reuse by the same futex) from the recycle
+ * list.
+ *
+ * If the recycle list is empty, then we'll have to allocate one from
+ * the slab (it's already initialized but for a few fields) and hash it in.
+ *
+ * When hashing in, there is a chance somebody added a futex_q for
+ * that same address while we dropped the lock, so we have to check
+ * again if there is a futex_q for our location; if so, we use that
+ * and recycle the one we just allocated.
+ *
+ * param gfp GFP_ for allocation
+ *
+ * Returns: On success, pointer to the futex_q
+ *
+ *          NULL if not found and impossible to allocate a new one.
+ */
+
+static
+struct futex_q * __futex_q_get (struct page *page, unsigned offset, int gfp)
+{
+        struct futex_q *q, *qp;
+        
+        futex_debug ("(page %p, offset %x)\n", page, offset);
+        
+        /* Is it in the hash already? If so, use that; check also if
+         * it is being recycled--pull it out of the recycle list and
+         * clean the recycle bit if so. */
+        q = __futex_q_find (page, offset);
+        if (q != NULL) {
+                if (!list_empty (&q->recycle_list)) {
+                        list_del_init (&q->recycle_list);
+                        q->flags &= ~FUTEX_RECYCLE_VISITED;
+                }
+                return q;
+        }
+
+        /* Get the first one in the recycle list, let's use that
+         * (avoidance of allocation is good, we don't want to get, at
+         * all costs, into kmem_cache_alloc(), and even less into
+         * having to release the lock and then recheck.
+         */
+        if (!list_empty (&recycle_list)) {
+                q = list_entry (recycle_list.next,
+                                struct futex_q, recycle_list);
+                list_del (&q->list);
+                list_del (&q->recycle_list);
+                goto reinitialize;
+        }
+        
+        if (unlikely (gfp == GFP_ATOMIC)) {
+                    /* Not in the hash table, allocate one
+                     * ... can we do it without releasing the lock? */
+                    q = kmem_cache_alloc (futex_q_slab, gfp);
+                    if (unlikely (q == NULL))
+                            return NULL;
+        }
+        else {
+                /* Allocate releasing the lock (non GFP_ATOMIC); then
+                 * check if anyone added a futex_q for this futex
+                 * while we released the lock. If so, use that one and
+                 * recycle the one allocated to the front, so next
+                 * __futex_q_get() gets it. */
+
+                spin_unlock (&futex_lock);
+                q = kmem_cache_alloc (futex_q_slab, gfp);
+                spin_lock (&futex_lock);
+                if (unlikely (q == NULL))
+                        return NULL;
+
+                qp = __futex_q_find_r (page, offset);
+                if (unlikely (qp != NULL)) {
+                        /* they added new one, recycle q */
+                        INIT_LIST_HEAD (&q->list);
+                        q->flags = 0;
+                        list_add (&q->recycle_list, &recycle_list);
+                        return qp;                        
+                }
+        }
+    reinitialize:
+        INIT_LIST_HEAD (&q->recycle_list);
+        q->flags = 0;
+        q->page = page;
+        q->offset = offset;
+        list_add_tail (&q->list, hash_futex (page, offset));
+        return q;
+}
+
+
+/* Finish using a futex_q
+ *
+ * If it is unused (no more waiters enqueued into it), then we add it
+ * to the tail of the recycle list. The garbage collector
+ * futex_recycle_run() will clean up the entries from time to time.
+ *
+ * Needs the futex_lock held.
+ */
+
+static inline
+void __futex_q_put (struct futex_q *q)
+{
+        futex_debug ("(q %p)\n", q);
+        
+        if (!futex_q_is_used (q) && list_empty (&q->recycle_list)) {
+                list_add_tail (&q->recycle_list, &recycle_list);
+        }
 }
 
-/* Waiter either waiting in FUTEX_WAIT or poll(), or expecting signal */
-static inline void tell_waiter(struct futex_q *q)
+
+/* Run over the recycle list
+ *
+ *
+ * For every futex_q that doen't have the FUTEX_RECYCLE_VISITED bit
+ * set in the flags, set the bit; if the bit is set, then that means
+ * it was there FUTEX_RECYCLE_PERIOD seconds ago and needs to be
+ * released back to the cache. 
+ *
+ * Called periodically by a timer, period FUTEX_RECYCLE_PERIOD
+ *
+ * It could just release the whole list and don't mess with flags and
+ * fuss, but I thought it'd be nice to give a change to the futex_q
+ * that just got added to be reused [specially if reused for the
+ * _same_ futex], in order to keep the cache warm ... although being
+ * as big. FIXME: prove this with numbers.
+ */
+
+static 
+void futex_recycle_run (unsigned long dummy)
 {
-	wake_up_all(&q->waiters);
-	if (q->filp)
-		send_sigio(&q->filp->f_owner, q->fd, POLL_IN);
+        struct list_head *i, *n;
+        struct futex_q *q;
+        
+        spin_lock (&futex_lock);
+        list_for_each_safe (i, n, &recycle_list) {
+                q = list_entry (i, struct futex_q, recycle_list);
+                if (q->flags & FUTEX_RECYCLE_VISITED) {
+                        list_del (&q->list);
+                        list_del_init (&q->recycle_list);
+                        kmem_cache_free (futex_q_slab, q);
+                }
+                else {
+                        q->flags |= FUTEX_RECYCLE_VISITED;
+                }
+        }
+        spin_unlock (&futex_lock);
+        init_timer (&timer);
+        timer.expires = jiffies + FUTEX_RECYCLE_PERIOD*HZ;
+        add_timer (&timer);
 }
 
+
+
 /*
  * Get kernel address of the user page and pin it.
  *
- * Must be called with (and returns with) all futex-MM locks held.
+ * Must be called with (and returns with) the MM lock held
+ * -- [un]lock_mm().
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
@@ -127,13 +532,13 @@
 	 */
 repeat_lookup:
 
-	unlock_futex_mm();
+	unlock_mm();
 
 	down_read(&mm->mmap_sem);
 	err = get_user_pages(current, mm, addr, 1, 0, 0, &page, NULL);
 	up_read(&mm->mmap_sem);
 
-	lock_futex_mm();
+	lock_mm();
 
 	if (err < 0)
 		return NULL;
@@ -150,133 +555,254 @@
 	return page;
 }
 
-static inline void unpin_page(struct page *page)
+static inline
+struct page *pin_page (unsigned long addr)
 {
-	put_page(page);
+        struct page *page;
+        lock_mm();
+	page = __pin_page (addr);
+        unlock_mm();
+        return page;
 }
 
-/*
- * Wake up all waiters hashed on the physical page that is mapped
- * to this virtual address:
- */
-static int futex_wake(unsigned long uaddr, int offset, int num)
-{
-	struct list_head *i, *next, *head;
-	struct page *page;
-	int ret = 0;
-
-	lock_futex_mm();
-
-	page = __pin_page(uaddr - offset);
-	if (!page) {
-		unlock_futex_mm();
-		return -EFAULT;
-	}
 
-	head = hash_futex(page, offset);
+/* Duh ... the reverse? Needs no locking. */
 
-	list_for_each_safe(i, next, head) {
-		struct futex_q *this = list_entry(i, struct futex_q, list);
+static inline void unpin_page (struct page *page)
+{
+        futex_debug ("(page %p)\n", page);
+	put_page (page);
+}
 
-		if (this->page == page && this->offset == offset) {
-			list_del_init(i);
-			__detach_vcache(&this->vcache);
-			tell_waiter(this);
-			ret++;
-			if (ret >= num)
-				break;
-		}
-	}
 
-	unlock_futex_mm();
-	unpin_page(page);
 
-	return ret;
-}
+static void futex_vcache_callback (vcache_t *, struct page *);
 
-/*
- * This gets called by the COW code, we have to rehash any
- * futexes that were pending on the old physical page, and
- * rehash it to the new physical page. The pagetable_lock
- * and vcache_lock is already held:
+/* Enqueue a waiter to a futex_q obtained from __futex_q_{find,get}()
+ *
+ * Need to hold the futex_lock.
  */
-static void futex_vcache_callback(vcache_t *vcache, struct page *new_page)
+
+static inline
+void __queue_me (struct futex_q *q, struct futex_w *w, unsigned long uaddr)
 {
-	struct futex_q *q = container_of(vcache, struct futex_q, vcache);
-	struct list_head *head = hash_futex(new_page, q->offset);
+        pa_enqueue (&w->list, w->prio, &q->pa);
+        w->q = q;
+	/* We register a futex callback to this virtual address,
+	 * to make sure a COW properly rehashes the futex queue. */
+	attach_vcache (&w->vcache, uaddr, current->mm, futex_vcache_callback);
+}
 
-	spin_lock(&futex_lock);
 
-	if (!list_empty(&q->list)) {
-		q->page = new_page;
-		list_del(&q->list);
-		list_add_tail(&q->list, head);
-	}
+/* Unqueue; return !0 if we were still queued (NULL means we were
+ * woken).
+ *
+ * The locking version return the page to ease out the race-condition
+ * free code in futex_close(). If it returns NULL, it means the
+ * futex_w waiter was not waiting for anything - if it returns the
+ * page address, it means it was waiting for a futex in that page.
+ *
+ * The non-locking version requires the futex lock held.
+ */
 
-	spin_unlock(&futex_lock);
+static inline
+void __unqueue_me (struct futex_w *w)
+{
+        futex_debug ("(w %p)\n", w);
+        
+        detach_vcache (&w->vcache);
+        pa_dequeue (&w->list, w->prio, &w->q->pa);
+        w->q = NULL;
 }
 
-static inline void __queue_me(struct futex_q *q, struct page *page,
-				unsigned long uaddr, int offset,
-				int fd, struct file *filp)
+static inline
+struct page * unqueue_me (struct futex_w *w)
 {
-	struct list_head *head = hash_futex(page, offset);
+        struct futex_q *q;
+        struct page *page = NULL;
+        
+        futex_debug ("(w %p)\n", w);
+
+        spin_lock (&futex_lock);
+        if (futex_w_is_queued (w)) {
+                q = w->q;
+                page = q->page;
+                __unqueue_me (w);
+                __futex_q_put (q); /* unlocks q */
+        }
+        spin_unlock (&futex_lock);
+        return page;
+}
 
-	q->offset = offset;
-	q->fd = fd;
-	q->filp = filp;
-	q->page = page;
 
-	list_add_tail(&q->list, head);
-	/*
-	 * We register a futex callback to this virtual address,
-	 * to make sure a COW properly rehashes the futex-queue.
-	 */
-	__attach_vcache(&q->vcache, uaddr, current->mm, futex_vcache_callback);
-}
+/*
+ * Wake up (by priority order) so many guys who are waiting for futex
+ * so-and-so.
+ *
+ * There is only one futex_q per futex, so once we find it, we just
+ * wake up 'howmany' entries on the futex's queue. 
+ *
+ * It is not our task to free [if needed] the futex_w struct;
+ * that will be done either by when the filp is destroyed [it is the
+ * filp's private data or on exit of futex_wait() [it is a local
+ * there].
+ *
+ * The futex_q will be disposed automatically; __futex_q_put() takes
+ * care of that.
+ *
+ * NEED to hold the futex_lock and the futex_q lock when calling this
+ * function. 
+ *
+ * param uaddr User address for the futex.
+ *
+ * param offset Offset of the futex within the page.
+ *
+ * param howmany 1 wake only the first one, 2 the two first ones
+ *               ... UINTMAX means wake them up all, no rocket science
+ *               here :| 
+ *
+ * Returns how many tasks were woken up, < 0 errno code on error.
+ */
 
-/* Return 1 if we were still queued (ie. 0 means we were woken) */
-static inline int unqueue_me(struct futex_q *q)
+static inline
+int futex_wake (unsigned long uaddr, int offset, unsigned howmany)
 {
+	struct page *page;
+        struct futex_q *q;
+        struct futex_w *w;
+        unsigned index;
 	int ret = 0;
 
-	spin_lock(&vcache_lock);
-	spin_lock(&futex_lock);
-	if (!list_empty(&q->list)) {
-		list_del(&q->list);
-		__detach_vcache(&q->vcache);
-		ret = 1;
-	}
-	spin_unlock(&futex_lock);
-	spin_unlock(&vcache_lock);
+        futex_debug ("(uaddr %lx, offset %d, num %d)\n",
+                     uaddr, offset, howmany);
+
+	page = pin_page (uaddr - offset);
+	if (unlikely (page == NULL))
+		return -EFAULT;
+        spin_lock (&futex_lock);
+        q = __futex_q_find (page, offset);
+        if (unlikely (q == NULL))
+                goto out_unpin;
+        while (ret < howmany && futex_q_is_used (q)) {
+                index = sched_find_first_bit (q->pa.bitmap);
+                w = list_entry (q->pa.queue[index].next, struct futex_w, list);
+                __unqueue_me (w);
+                wake_up_process (w->task);
+                if (w->filp)
+                        send_sigio (&w->filp->f_owner, w->fd, POLL_IN);
+                ret++;
+        }
+        __futex_q_put (q);
+out_unpin:
+        spin_unlock (&futex_lock);
+        unpin_page (page);
 	return ret;
 }
 
-static int futex_wait(unsigned long uaddr,
-		      int offset,
-		      int val,
-		      unsigned long time)
+
+/*
+ * This gets called by the COW code, we have to rehash any
+ * futexes that were pending on the old physical page, and
+ * rehash it to the new physical page. The pagetable_lock
+ * and vcache_lock is already held.
+ *
+ * No fancy things here: check there is a previous futex_q, dequeue
+ * from it and put it back; locate [or most commonly] allocate a new
+ * futex_q, enqueue to it.
+ *
+ * In case of error, there is not much we can do from inside here,
+ * buried under who knows how many layers of stack frames, so we just
+ * wake the waiter up and it will go up to user space and probably
+ * decide he should go back to the kernel. No rocket science.
+ */
+
+static
+void futex_vcache_callback (vcache_t *vcache, struct page *new_page)
 {
-	DECLARE_WAITQUEUE(wait, current);
-	int ret = 0, curval;
-	struct page *page;
-	struct futex_q q;
+	struct futex_w *w = container_of (vcache, struct futex_w, vcache);
+        unsigned offset;
+        struct futex_q *old_q, *new_q;
+
+        futex_debug ("(vcache %p, page %p)\n", vcache, new_page);
+
+        spin_lock (&futex_lock);
+        if (!futex_w_is_queued (w))
+                goto out_err;   /* Ein? */
+        
+        old_q = w->q;
+        offset = old_q->offset;
+        pa_dequeue (&w->list, w->prio, &old_q->pa);
+        __futex_q_put (old_q);
+
+        new_q = __futex_q_get (new_page, offset, GFP_ATOMIC);
+        if (new_q == NULL)
+                goto out_err;
+        pa_enqueue (&w->list, w->prio, &new_q->pa);
+        spin_unlock (&futex_lock);
+        return;
+
+out_err:
+        spin_unlock (&futex_lock);
+        /* Cannot create the futex_q or something similarly weird
+         * happened, so let's wake it up and have it see it is still
+         * locked and it needs to call back into the kernel. It is
+         * already removed from the wait queue. */
+        w->q = NULL;
+        wake_up_process (w->task);
+        if (w->filp)
+                send_sigio (&w->filp->f_owner, w->fd, POLL_IN);
+        return;
+}
 
-	init_waitqueue_head(&q.waiters);
 
-	lock_futex_mm();
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
 
-	page = __pin_page(uaddr - offset);
-	if (!page) {
-		unlock_futex_mm();
+static
+int futex_wait (unsigned long uaddr, int offset, int val, unsigned long time)
+{
+	int ret = 0, curval;
+	struct page *page;
+        struct futex_q *q;
+	struct futex_w w = {
+                .list = LIST_HEAD_INIT (w.list),
+                .q = NULL, .task = current, .fd = -1, .filp = NULL
+        };
+
+        futex_debug ("(uaddr %lx, offset %d, val %d, time %lu)\n",
+                     uaddr, offset, val, time);
+
+        /* Lock the page where the futex is in physical memory */
+	page = pin_page (uaddr - offset);
+	if (!page)
 		return -EFAULT;
-	}
-	__queue_me(&q, page, uaddr, offset, -1, NULL);
 
-	unlock_futex_mm();
+        /* Get the futex_q corresponding to this futex [on failure, it
+         * unlocks everything]. */
+        spin_lock (&futex_lock);
+	q = __futex_q_get (page, offset, GFP_KERNEL);
+        if (unlikely (q == NULL)) {
+                spin_unlock (&futex_lock);
+                ret = -ENOMEM;
+                goto out_unpin;
+        }
+
+        /* Queue it before releasing the lock to avoid races */
+        w.prio = current->prio;
+        __queue_me (q, &w, uaddr);
+    	spin_unlock (&futex_lock);
 
-	/* Page is pinned, but may no longer be in this address space. */
-	if (get_user(curval, (int *)uaddr) != 0) {
+        /* Page is pinned, but may no longer be in this address space. */
+	if (get_user (curval, (int *) uaddr) != 0) {
 		ret = -EFAULT;
 		goto out;
 	}
@@ -284,80 +810,90 @@
 		ret = -EWOULDBLOCK;
 		goto out;
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
+        set_current_state (TASK_INTERRUPTIBLE);
+	if (futex_w_is_queued (&w))
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
+
 out:
-	/* Were we woken up anyway? */
-	if (!unqueue_me(&q))
+	if (!unqueue_me (&w) && ret >= 0)
 		ret = 0;
-	unpin_page(page);
-
+out_unpin:
+ 	unpin_page (page);
 	return ret;
 }
 
-static inline int futex_wait_utime(unsigned long uaddr,
-		      int offset,
-		      int val,
-		      struct timespec* utime)
+static inline
+int futex_wait_utime (unsigned long uaddr, int offset, int val,
+                      struct timespec *utime)
 {
-	unsigned long time = MAX_SCHEDULE_TIMEOUT;
+        unsigned long time = MAX_SCHEDULE_TIMEOUT;
 
-	if (utime) {
-		struct timespec t;
-		if (copy_from_user(&t, utime, sizeof(t)) != 0)
-			return -EFAULT;
-		time = timespec_to_jiffies(&t) + 1;
-	}
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
+        kmem_cache_free (futex_w_slab, filp->private_data);
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
-		ret = POLLIN | POLLRDNORM;
-	spin_unlock(&futex_lock);
+        futex_debug ("(filp %p, wait %p)\n", filp, wait);
 
+	poll_wait (filp, &w->waiters, wait);
+	spin_lock (&futex_lock); 
+	if (!futex_w_is_queued (w))
+		ret = POLLIN | POLLRDNORM;
+	spin_unlock (&futex_lock);
 	return ret;
 }
 
+
 static struct file_operations futex_fops = {
 	.release	= futex_close,
 	.poll		= futex_poll,
@@ -365,83 +901,113 @@
 
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
-	filp->f_vfsmnt = mntget(futex_mnt);
-	filp->f_dentry = dget(futex_mnt->mnt_root);
+	filp->f_vfsmnt = mntget (futex_mnt);
+	filp->f_dentry = dget (futex_mnt->mnt_root);
 
 	if (signal) {
 		int ret;
 		
-		ret = f_setown(filp, current->tgid, 1);
-		if (ret) {
-			put_unused_fd(ret);
-			put_filp(filp);
-			goto out;
-		}
+		ret = f_setown (filp, current->tgid, 1);
+#warning FIXME: how to free the mntget() and dget() in the error path?
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
-	lock_futex_mm();
-
-	page = __pin_page(uaddr - offset);
+        /* Pull out what page the futex is at, pin it down so it does not
+         * dissapear off to swap space. */
+        
+	page = pin_page (uaddr - offset);
 	if (!page) {
-		unlock_futex_mm();
-
-		put_unused_fd(ret);
-		put_filp(filp);
-		kfree(q);
-		return -EFAULT;
+                ret = -EFAULT;
+                goto out_err_pin_page;
 	}
 
-	init_waitqueue_head(&q->waiters);
-	filp->private_data = q;
-
-	__queue_me(q, page, uaddr, offset, ret, filp);
+        /* Create a waiter structure, initialize it and queue it in
+         * the futex queue. */
+        
+	w = kmem_cache_alloc (futex_w_slab, GFP_KERNEL);
+	if (unlikely (w == NULL)) {
+		ret = -ENOMEM;
+		goto out_err_kmem_cache_alloc_w;
+	}
+        
+        /* Pull out the futex queue corresponding to the futex. Create
+         * one if none. */
+        
+	spin_lock (&futex_lock);
+        q = __futex_q_get (page, offset, GFP_KERNEL);
+        if (unlikely (q == NULL)) {
+                spin_unlock (&futex_lock);
+                ret = -ENOMEM;
+                goto out_err_futex_q_get;
+        }
+
+        INIT_LIST_HEAD (&w->list);
+	init_waitqueue_head (&w->waiters);
+        w->q = NULL;
+        w->task = current;
+        w->prio = current->prio;
+        w->fd = fd;
+        w->filp = filp;
+        filp->private_data = w;
 
-	unlock_futex_mm();
+	__queue_me (q, w, uaddr);
+	spin_unlock (&futex_lock);
 
 	/* Now we map fd to filp, so userspace can access it */
-	fd_install(ret, filp);
-	page = NULL;
-out:
-	if (page)
-		unpin_page(page);
+	fd_install (ret, filp);
 	return ret;
+
+out_err_futex_q_get:
+        kmem_cache_free (futex_w_slab, w);
+out_err_kmem_cache_alloc_w:
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
@@ -450,14 +1016,14 @@
 
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
@@ -478,15 +1044,36 @@
 	.kill_sb	= kill_anon_super,
 };
 
+
 static int __init init(void)
 {
 	unsigned int i;
 
+        futex_q_slab = kmem_cache_create ("futex_q", sizeof (struct futex_q),
+                                          0, CACHE_CREATE_FLAGS,
+                                          futex_q_ctor, futex_q_dtor);
+        if (futex_q_slab == NULL) 
+                panic ("futex.c:init(): "
+                       "Unable to initialize futex_q slab allocator.\n");
+        futex_w_slab = kmem_cache_create ("futex_w", sizeof (struct futex_w),
+                                          0, CACHE_CREATE_FLAGS, NULL, NULL);
+        if (futex_q_slab == NULL)
+                panic ("futex.c:init(): "
+                       "Unable to initialize futex_w slab allocator.\n");
+        
 	register_filesystem(&futex_fs_type);
 	futex_mnt = kern_mount(&futex_fs_type);
 
 	for (i = 0; i < ARRAY_SIZE(futex_queues); i++)
 		INIT_LIST_HEAD(&futex_queues[i]);
+
+        /* Set up the recycle timer to run every 10 seconds */
+        timer.function = futex_recycle_run;
+        timer.data = 0;
+        init_timer (&timer);
+        timer.expires = jiffies + FUTEX_RECYCLE_PERIOD*HZ;
+        add_timer (&timer);
+
 	return 0;
 }
 __initcall(init);

-- 

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my fault]
