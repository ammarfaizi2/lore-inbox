Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264800AbSJPCSw>; Tue, 15 Oct 2002 22:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264801AbSJPCSw>; Tue, 15 Oct 2002 22:18:52 -0400
Received: from fmr05.intel.com ([134.134.136.6]:17140 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S264800AbSJPCSb> convert rfc822-to-8bit; Tue, 15 Oct 2002 22:18:31 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C7806CAC7D9@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [PATCH+RFC] Priority-based futexes
Date: Tue, 15 Oct 2002 19:24:14 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

I have been playing the last days with a possible implementation 
of priority based futexes, so that tasks that are sleeping on a
futex get waken up by priority order. This is useful for real-time
locking, with most benefits being for the NGPT and NPTL thread 
libraries.

Basically, how it works is: now, there is a single struct futex_q 
per futex [before there was one per each, don't know if a bug or
a feature]. To each futex_q attach the tasks that are waiting for
a futex. I have split off Ingos pqueue O(1) code into prioarray.h,
so it can be reused, and that is what the patch uses. When a futex
wake happens, it locates the futex_q through the hash table; then
picks up the first task [O(1), priorities acked], unqueues it, 
and wakes it up. This is repeated for as many tasks as specified.

This patch has still some caveats, although it Seems To Work For Me. 
Before addressing them, I would like you guys to check it out and
collect feedback (if any); and the caveats are:

 - Not everybody/task/futex cares about priority based wake-up.
   I am planning that I could have the first locker specify how
   it should behave, and then, dynamically select either a 
   normal queue or a pqueue, with that selection in effect for
   the lifetime of the futex in kernel space [ie: while it is
   locked]. An abstraction of wait queues that would work with
   both would be the key here.

 - No async support yet - basically, poll_wait() takes a 
   wait_queue_head_t, and thus, there is no way to force priority
   based selection down its throat. Maybe the wait queue abstraction 
   mechanism could do that ... or once dual mode is supported, 
   force futex_fd() to _work_only_ if non-pqueue mode is selected
   [I guess an RT application would be high on this].

 - Ugly kludge in sched.h to include prioarray.h ... 

 - The function doc might be a wee bit outdated

 - vcache callback: as now the futex_q struct is not owned by
   anybody but 'the futex', the last task in the pqueue (and thus,
   the last to acquire the lock) will be responsible for freeing.
   This creates a failure point; when doing the vcache callback,
   we need to create a new futex_q struct, as the futex is now
   different, a new futex_q struct has to be allocated - if it
   fails, we are dead on the water. Kill the process? let it
   deadlock? let it in the old queue, assume somebody else might
   wake it up?

I used a combination of code that I borrowed from NGPT, Rusty's 
user space sample library + some of my own to test it. It is 
basically a shared area and futex_down and futex_up programs
that can be called from the shell. I gave it a few hard times
and it resisted pretty well - however, I probably missed many
cases. Find it at:

http://sost.net/pub/linux/pfutex-test.tar.gz

So, here is the patch - against 2.5.41; it also applies to .42, 
to the best of my knowledge

Index: tsp/futex/linux/include/linux/prioarray.h
diff -u /dev/null tsp/futex/linux/include/linux/prioarray.h:1.1.2.1
--- /dev/null	Tue Oct 15 18:42:48 2002
+++ tsp/futex/linux/include/linux/prioarray.h	Tue Oct 15 15:17:29 2002
@@ -0,0 +1,57 @@
+/*
+ * O(1) priority arrays
+ *
+ * Modified from code (C) 2002 Ingo Molnar <mingo@redhat.com> in
+ * sched.c by Iñaky Pérez-González <inaky.perez-gonzalez@intel.com> so
+ * that other parts of the kernel can use the same constructs.
+ */
+
+#ifndef _LINUX_PRIOARRAY_
+#define _LINUX_PRIOARRAY_
+
+        /* This inclusion is kind of recursive ... hmmm */
+
+#include <linux/sched.h>
+
+struct prio_array {
+	int nr_active;
+	unsigned long bitmap[BITMAP_SIZE];
+	struct list_head queue[MAX_PRIO];
+};
+
+typedef struct prio_array prio_array_t;
+
+static inline
+void pa_init (prio_array_t *array)
+{
+        unsigned cnt;
+	array->nr_active = 0;
+        memset (array->bitmap, 0, sizeof (array->bitmap));
+        for (cnt = 0; cnt < MAX_PRIO; cnt++)
+                INIT_LIST_HEAD (&array->queue[cnt]);
+}
+
+/*
+ * Adding/removing a node to/from a priority array:
+ */
+
+static inline
+void pa_dequeue (struct list_head *p, unsigned prio, prio_array_t *array)
+{
+	array->nr_active--;
+	list_del(p);
+	if (list_empty(array->queue + prio))
+		__clear_bit(prio, array->bitmap);
+}
+
+static inline
+void pa_enqueue (struct list_head *p, unsigned prio, prio_array_t *array)
+{
+	list_add_tail(p, array->queue + prio);
+	__set_bit(prio, array->bitmap);
+	array->nr_active++;
+}
+
+
+
+#endif /* #ifndef _LINUX_PRIOARRAY_ */
Index: tsp/futex/linux/include/linux/sched.h
diff -u tsp/futex/linux/include/linux/sched.h:1.1.1.1
tsp/futex/linux/include/linux/sched.h:1.1.1.1.2.1
--- tsp/futex/linux/include/linux/sched.h:1.1.1.1	Tue Oct  8 19:47:05
2002
+++ tsp/futex/linux/include/linux/sched.h	Tue Oct 15 15:17:48 2002
@@ -251,6 +251,9 @@
 #define MAX_RT_PRIO		MAX_USER_RT_PRIO
 
 #define MAX_PRIO		(MAX_RT_PRIO + 40)
+#define BITMAP_SIZE ((((MAX_PRIO+1+7)/8)+sizeof(long)-1)/sizeof(long))
+
+#include <linux/prioarray.h> /* Okay, this is ugly, but needs MAX_PRIO */
  
 /*
  * Some day this will be a full-fledged user tracking system..
@@ -275,7 +278,6 @@
 extern struct user_struct root_user;
 #define INIT_USER (&root_user)
 
-typedef struct prio_array prio_array_t;
 struct backing_dev_info;
 
 struct task_struct {
Index: tsp/futex/linux/include/linux/vcache.h
diff -u tsp/futex/linux/include/linux/vcache.h:1.1.1.1
tsp/futex/linux/include/linux/vcache.h:1.1.1.1.2.1
--- tsp/futex/linux/include/linux/vcache.h:1.1.1.1	Tue Oct  8 19:47:05
2002
+++ tsp/futex/linux/include/linux/vcache.h	Tue Oct 15 15:16:46 2002
@@ -17,6 +17,16 @@
 		unsigned long address,
 		struct mm_struct *mm,
 		void (*callback)(struct vcache_s *data, struct page
*new_page));
+static inline
+void attach_vcache (vcache_t *vcache,
+		unsigned long address,
+		struct mm_struct *mm,
+                    void (*callback)(struct vcache_s *data, struct page
*new_page))
+{
+  spin_lock (&vcache_lock);
+  __attach_vcache (vcache, address, mm, callback);
+  spin_unlock (&vcache_lock);
+}
 
 extern void detach_vcache(vcache_t *vcache);
 
Index: tsp/futex/linux/kernel/futex.c
diff -u tsp/futex/linux/kernel/futex.c:1.1.1.1
tsp/futex/linux/kernel/futex.c:1.1.1.1.2.4
--- tsp/futex/linux/kernel/futex.c:1.1.1.1	Tue Oct  8 19:47:22 2002
+++ tsp/futex/linux/kernel/futex.c	Tue Oct 15 18:42:32 2002
@@ -36,24 +36,56 @@
 
 #define FUTEX_HASHBITS 8
 
+#define FUTEX_DEBUG 0
+
+#define inline /* */
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
+ * NULL, it is outside of any list.
+ */
+
+struct futex_w {
+        struct list_head list;
+        struct futex_q *q;     /* damn it ... need a backpointer */
+        
+        /* the virtual => physical COW-safe cache */
+        vcache_t vcache;
+        task_t *task;
+        int fd;
+        struct file *filp;
+};
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
@@ -65,6 +97,7 @@
 /* Futex-fs vfsmount entry: */
 static struct vfsmount *futex_mnt;
 
+
 /*
  * These are all locks that are necessery to look up a physical
  * mapping safely, and modify/search the futex hash, atomically:
@@ -72,17 +105,17 @@
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
@@ -92,14 +125,103 @@
 							FUTEX_HASHBITS)];
 }
 
-/* Waiter either waiting in FUTEX_WAIT or poll(), or expecting signal */
-static inline void tell_waiter(struct futex_q *q)
+
+/*
+ * Check out if there is an struct futex_q for the page and
+ * offset given in the hash table; if there is, return it;
+ * otherwise, allocate one, fill it up, insert it and return
+ * it. Return NULL on error [allocation error].
+ *
+ * gfp = GFP_{KERNEL,ATOMIC} for kmalloc()
+ *
+ * Hold the lock on futex_lock or expect problems ...
+ */
+
+static inline
+struct futex_q * __get_futex_q (struct page *page, unsigned offset, int
gfp)
 {
-	wake_up_all(&q->waiters);
-	if (q->filp)
-		send_sigio(&q->filp->f_owner, q->fd, POLL_IN);
+        struct list_head *i, *head;
+        struct futex_q *q;
+        
+        futex_debug ("(page %p, offset %u, gfp %d)\n", page, offset, gfp);
+        
+        head = hash_futex (page, offset);
+        list_for_each (i, head) {
+		q = list_entry (i, struct futex_q, list);
+                if (q->page == page && q->offset == offset)
+                        return q;
+	}
+        /* Didn't find it, make a new one */
+        if ((q = kmalloc (sizeof (struct futex_q), gfp)) != NULL) {
+                q->page = page;
+                q->offset = offset;
+                spin_lock_init (&q->lock);
+                pa_init (&q->pa);
+                list_add_tail (&q->list, head);
+        }
+        return q;
+}
+
+static inline
+struct futex_q * get_futex_q (struct page *page, unsigned offset, int gfp)
+{
+        struct futex_q *q;
+        spin_lock (&futex_lock);
+        q = __get_futex_q (page, offset, gfp);
+        spin_unlock (&futex_lock);
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
 }
 
+
 /*
  * Get kernel address of the user page and pin it.
  *
@@ -111,11 +233,14 @@
 	struct page *page, *tmp;
 	int err;
 
+        futex_debug ("(addr %lx)\n", addr);
+        
 	/*
 	 * Do a quick atomic lookup first - this is the fastpath.
 	 */
 	page = follow_page(mm, addr, 0);
 	if (likely(page != NULL)) {
+
 		get_page(page);
 		return page;
 	}
@@ -146,49 +271,163 @@
 	return page;
 }
 
+
 static inline void unpin_page(struct page *page)
 {
+        futex_debug ("(page %p)\n", page);
 	put_page(page);
 }
 
+static void futex_vcache_callback(vcache_t *, struct page *);
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
+        futex_fdebug (0, "Attaching vcache q %p, w %p, vcache %p\n",
+                      q, w, &w->vcache);
+	attach_vcache(&w->vcache, uaddr, current->mm,
futex_vcache_callback);
+        spin_unlock (&q->lock);
+}
+
+
+/* Unqueue. No need to lock. Return 1 if we were still queued (ie. 0
+ * means we were woken).
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
+int unqueue_me (struct futex_w *w)
+{
+        struct futex_q *q = w->q;
+        
+        futex_debug ("(w %p)\n", w);
+        
+        if (q) {
+                spin_lock (&q->lock);
+                __unqueue_me (w);
+                spin_unlock (&q->lock);
+                maybe_put_futex_q (q);
+                return 1;
+        }
+        else
+                return 0;
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
+static inline
+int tell_waiters (struct futex_q *q, unsigned howmany)
+{
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
+        if (unlikely (q->pa.nr_active == 0)) { /* Every body chickened out
... */
+                futex_debug ("(q %p, howmany %d): No active "
+                             "tasks on the pqueue\n", q, howmany);
+                goto exit_put;
+        }
+        
+        while (ret < howmany) {
+                index = sched_find_first_bit (q->pa.bitmap);
+                w = list_entry (q->pa.queue[index].next, struct futex_w,
list);
+
+                __unqueue_me (w);
+                wake_up_process (w->task);
+                if (w->filp)
+                  send_sigio(&w->filp->f_owner, w->fd, POLL_IN);
+                ret++;
+                
+                if (q->pa.nr_active == 0) { /* no more */
+                        futex_debug ("q %p: no more to wake up, done\n",
q);
+                        goto exit_put;
+                }
+        }
+        spin_unlock (&q->lock);
+        return ret;
+
+exit_put:
+        spin_unlock (&q->lock);
+        __put_futex_q (q);
+        return ret;
+}
+
+
 /*
  * Wake up all waiters hashed on the physical page that is mapped
  * to this virtual address:
  */
-static int futex_wake(unsigned long uaddr, int offset, int num)
+static int
+futex_wake (unsigned long uaddr, int offset, int num)
 {
 	struct list_head *i, *next, *head;
 	struct page *page;
+        struct futex_q *q;
 	int ret = 0;
 
+        futex_debug ("(uaddr %lx, offset %d, num %d)\n",
+                     uaddr, offset, num);
 	lock_futex_mm();
 
-	page = __pin_page(uaddr - offset);
+	page = __pin_page (uaddr - offset);
 	if (!page) {
 		unlock_futex_mm();
 		return -EFAULT;
 	}
 
-	head = hash_futex(page, offset);
-
-	list_for_each_safe(i, next, head) {
-		struct futex_q *this = list_entry(i, struct futex_q, list);
+	head = hash_futex (page, offset);
 
-		if (this->page == page && this->offset == offset) {
-			list_del_init(i);
-			tell_waiter(this);
-			ret++;
-			if (ret >= num)
-				break;
-		}
+	list_for_each_safe (i, next, head) {
+		q = list_entry (i, struct futex_q, list);
+		if (q->page == page && q->offset == offset)
+			ret += tell_waiters (q, num);
 	}
 
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
@@ -197,123 +436,122 @@
  */
 static void futex_vcache_callback(vcache_t *vcache, struct page *new_page)
 {
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
-
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
-	__attach_vcache(&q->vcache, uaddr, current->mm,
futex_vcache_callback);
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
+        new_q = __get_futex_q (new_page, offset, GFP_ATOMIC);
+        
+	if (old_q) {
+                spin_lock (&old_q->lock);
+                pa_dequeue (&w->list, w->task->prio, &old_q->pa);
+                spin_unlock (&old_q->lock);
+                __maybe_put_futex_q (old_q);
+        }
+
+        if (new_q == NULL) {
+                /* FIXME: And now? what do I do? somebody is going to
+                 * block here for ever. Maybe it is better to stay w/
+                 * the old mapping, hope somebody will wake us up
+                 * and we will migrate to a new futex_q when retrying
+                 * ... deadlocking for now ... it is ugly, though */
+                printk ("ERROR: %s (%p, %p): cannot create new "
+                        "needed futex_q, pid %d will deadlock\n",
+                        __FUNCTION__, vcache, new_page, w->task->pid);
+        }
+        else {
+                spin_lock (&new_q->lock);
+                pa_enqueue (&w->list, w->task->prio, &new_q->pa);
+                spin_unlock (&new_q->lock);
+        }        
+        spin_unlock (&futex_lock);
+        return;
 }
 
-/* Return 1 if we were still queued (ie. 0 means we were woken) */
-static inline int unqueue_me(struct futex_q *q)
-{
-	int ret = 0;
-
-	detach_vcache(&q->vcache);
-
-	spin_lock(&futex_lock);
-	if (!list_empty(&q->list)) {
-		list_del(&q->list);
-		ret = 1;
-	}
-	spin_unlock(&futex_lock);
-
-	return ret;
-}
 
-static int futex_wait(unsigned long uaddr,
-		      int offset,
-		      int val,
-		      unsigned long time)
+/* Wait for a futex to be released */
+static int
+futex_wait (unsigned long uaddr, int offset, int val, unsigned long time)
 {
-	DECLARE_WAITQUEUE(wait, current);
 	int ret = 0, curval;
 	struct page *page;
-	struct futex_q q;
-
-	init_waitqueue_head(&q.waiters);
+	struct futex_w w;
+        struct futex_q *q;
 
+        futex_debug ("(uaddr %lx, offset %d, val %d, time %lu)\n",
+                     uaddr, offset, val, time);
+        
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
+	q = __get_futex_q (page, offset, GFP_ATOMIC);
 	unlock_futex_mm();
-
+        if (q == NULL)
+                goto out_unpin;
+        
 	/* Page is pinned, but may no longer be in this address space. */
 	if (get_user(curval, (int *)uaddr) != 0) {
 		ret = -EFAULT;
-		goto out;
+		goto out_unpin;
 	}
 	if (curval != val) {
 		ret = -EWOULDBLOCK;
-		goto out;
+		goto out_unpin;
 	}
-	/*
+
+        /*
 	 * The get_user() above might fault and schedule so we
 	 * cannot just set TASK_INTERRUPTIBLE state when queueing
 	 * ourselves into the futex hash. This code thus has to
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
+	if (!list_empty(&w.list))
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
 	if (signal_pending(current))
 		ret = -EINTR;
 out:
-	/* Were we woken up anyway? */
-	if (!unqueue_me(&q))
+	if (!unqueue_me (&w))
 		ret = 0;
+out_unpin:        
 	unpin_page(page);
 
 	return ret;
 }
 
+
 static int futex_close(struct inode *inode, struct file *filp)
 {
+#if 0
 	struct futex_q *q = filp->private_data;
 
+	detach_vcache(&q->vcache);
 	spin_lock(&futex_lock);
 	if (!list_empty(&q->list)) {
 		list_del(&q->list);
@@ -323,13 +561,16 @@
 	spin_unlock(&futex_lock);
 	unpin_page(q->page);
 	kfree(filp->private_data);
-	return 0;
+#endif
+        futex_debug ("(%p, %p) UNFINISHED\n", inode, filp);
+	return -ENOSYS;
 }
 
 /* This is one-shot: once it's gone off you need a new fd */
 static unsigned int futex_poll(struct file *filp,
 			       struct poll_table_struct *wait)
 {
+#if 0
 	struct futex_q *q = filp->private_data;
 	int ret = 0;
 
@@ -340,6 +581,9 @@
 	spin_unlock(&futex_lock);
 
 	return ret;
+#endif
+        futex_debug ("(%p, %p) UNFINISHED\n", filp, wait);
+	return -ENOSYS;
 }
 
 static struct file_operations futex_fops = {
@@ -351,6 +595,10 @@
    set the sigio stuff up afterwards. */
 static int futex_fd(unsigned long uaddr, int offset, int signal)
 {
+        futex_debug ("(%lx, %d, %d) UNFINISHED\n",
+                uaddr, offset, signal);
+	return -ENOSYS;
+#if 0
 	struct page *page = NULL;
 	struct futex_q *q;
 	struct file *filp;
@@ -419,6 +667,7 @@
 	if (page)
 		unpin_page(page);
 	return ret;
+#endif
 }
 
 asmlinkage int sys_futex(unsigned long uaddr, int op, int val, struct
timespec *utime)
@@ -426,6 +675,8 @@
 	unsigned long time = MAX_SCHEDULE_TIMEOUT;
 	unsigned long pos_in_page;
 	int ret;
+
+        futex_debug ("(%lx, %d, %d, %p)\n", uaddr, op, val, utime);
 
 	if (utime) {
 		struct timespec t;
Index: tsp/futex/linux/kernel/sched.c
diff -u tsp/futex/linux/kernel/sched.c:1.1.1.1
tsp/futex/linux/kernel/sched.c:1.1.1.1.2.1
--- tsp/futex/linux/kernel/sched.c:1.1.1.1	Tue Oct  8 19:47:22 2002
+++ tsp/futex/linux/kernel/sched.c	Tue Oct 15 15:16:29 2002
@@ -128,15 +128,8 @@
  * These are the runqueue data structures:
  */
 
-#define BITMAP_SIZE ((((MAX_PRIO+1+7)/8)+sizeof(long)-1)/sizeof(long))
-
 typedef struct runqueue runqueue_t;
 
-struct prio_array {
-	int nr_active;
-	unsigned long bitmap[BITMAP_SIZE];
-	struct list_head queue[MAX_PRIO];
-};
 
 /*
  * This is the main, per-CPU runqueue data structure.
@@ -224,17 +217,12 @@
  */
 static inline void dequeue_task(struct task_struct *p, prio_array_t *array)
 {
-	array->nr_active--;
-	list_del(&p->run_list);
-	if (list_empty(array->queue + p->prio))
-		__clear_bit(p->prio, array->bitmap);
+        pa_dequeue (&p->run_list, p->prio, array);
 }
 
 static inline void enqueue_task(struct task_struct *p, prio_array_t *array)
 {
-	list_add_tail(&p->run_list, array->queue + p->prio);
-	__set_bit(p->prio, array->bitmap);
-	array->nr_active++;
+        pa_enqueue (&p->run_list, p->prio, array);
 	p->array = array;
 }
 

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]


