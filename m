Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129311AbRA3OQW>; Tue, 30 Jan 2001 09:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129396AbRA3OQN>; Tue, 30 Jan 2001 09:16:13 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:62469 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S129311AbRA3OP7>; Tue, 30 Jan 2001 09:15:59 -0500
From: bsuparna@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: Ben LaHaise <bcrl@redhat.com>
cc: linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
Message-ID: <CA2569E4.004E4ABB.00@d73mta03.au.ibm.com>
Date: Tue, 30 Jan 2001 19:39:07 +0530
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
	/notify + callback chains
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ben,

This indeed looks neat and simple !
I'd avoided touching the wait queue structure as I suspected that you might
already have something like this in place :-)
and was hoping that you'd see this posting and comment.
I agree entirely that it makes sense to have chaining of events built over
simple minimalist primitives. That's what was making me uncomfortable with
the cev design I had.

So now I'm thinking how to do this using the wait queues extension you
have. Some things to consider:
     - Since non-exclusive waiters are always added to the head of the
queue (unless we use a tq in a wtd kind of structure as ), ordering of
layered callbacks might still be a problem. (e.g. with an encryption filter
fs, we want the decrypt callback to run  before any waiter gets woken up;
irrespective of whether the wait was issued before or after the decrypt
callback was added by the filter layer)
     - The wait_queue_func gets only a pointer to the wait structure as an
argument, with no other means to pass any state about the sub-event that
caused it (could that be a problem with event chaining ... ? every
encapsulating structure will have to maintain a pointer to the related
sub-event ...  ? )

Regards
Suparna


  Suparna Bhattacharya
  Systems Software Group, IBM Global Services, India
  E-mail : bsuparna@in.ibm.com
  Phone : 91-80-5267117, Extn : 2525


Ben LaHaise <bcrl@redhat.com> on 01/30/2001 10:59:46 AM

Please respond to Ben LaHaise <bcrl@redhat.com>

To:   Suparna Bhattacharya/India/IBM@IBMIN
cc:   linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
Subject:  Re: [Kiobuf-io-devel] RFC:  Kernel mechanism: Compound event
      wait/notify + callback chains




On Tue, 30 Jan 2001 bsuparna@in.ibm.com wrote:

>
> Comments, suggestions, advise, feedback solicited !
>
> If this seems like something that might (after some refinements) be a
> useful abstraction to have, then I need some help in straightening out
the
> design. I am not very satisfied with it in its current form.

Here's my first bit of feedback from the point of "this is what my code
currently does and why".

The waitqueue extension below is a minimalist approach for providing
kernel support for fully asynchronous io.  The basic idea is that a
function pointer is added to the wait queue structure that is called
during wake_up on a wait queue head.  (The patch below also includes
support for exclusive lifo wakeups, which isn't crucial/perfect, but just
happened to be part of the code.)  No function pointer or other data is
added to the wait queue structure.  Rather, users are expected to make use
of it by embedding the wait queue structure within their own data
structure that contains all needed info for running the state machine.

Here's a snippet of code which demonstrates a non blocking lock of a page
cache page:

struct worktodo {
     wait_queue_t            wait;
     struct tq_struct        tq;
     void *data;
};

static void __wtd_lock_page_waiter(wait_queue_t *wait)
{
        struct worktodo *wtd = (struct worktodo *)wait;
        struct page *page = (struct page *)wtd->data;

        if (!TryLockPage(page)) {
                __remove_wait_queue(&page->wait, &wtd->wait);
                wtd_queue(wtd);
        } else {
                schedule_task(&run_disk_tq);
        }
}

void wtd_lock_page(struct worktodo *wtd, struct page *page)
{
        if (TryLockPage(page)) {
                int raced = 0;
                wtd->data = page;
                init_waitqueue_func_entry(&wtd->wait,
__wtd_lock_page_waiter);
                add_wait_queue_cond(&page->wait, &wtd->wait,
TryLockPage(page), raced = 1);

                if (!raced) {
                        run_task_queue(&tq_disk);
                        return;
                }
        }

        wtd->tq.routine(wtd->tq.data);
}


The use of wakeup functions is also useful for waking a specific reader or
writer in the rw_sems, making semaphore avoid spurious wakeups, etc.

I suspect that chaining of events should be built on top of the
primatives, which should be kept as simple as possible.  Comments?

          -ben


diff -urN v2.4.1pre10/include/linux/mm.h work/include/linux/mm.h
--- v2.4.1pre10/include/linux/mm.h Fri Jan 26 19:03:05 2001
+++ work/include/linux/mm.h   Fri Jan 26 19:14:07 2001
@@ -198,10 +198,11 @@
  */
 #define UnlockPage(page)     do { \
                         smp_mb__before_clear_bit(); \
+                        if (!test_bit(PG_locked, &(page)->flags)) {
printk("last: %p\n", (page)->last_unlock); BUG(); } \
+                        (page)->last_unlock = current_text_addr(); \
                         if (!test_and_clear_bit(PG_locked,
&(page)->flags)) BUG(); \
                         smp_mb__after_clear_bit(); \
-                        if (waitqueue_active(&page->wait)) \
-                             wake_up(&page->wait); \
+                        wake_up(&page->wait); \
                    } while (0)
 #define PageError(page)      test_bit(PG_error, &(page)->flags)
 #define SetPageError(page)   set_bit(PG_error, &(page)->flags)
diff -urN v2.4.1pre10/include/linux/sched.h work/include/linux/sched.h
--- v2.4.1pre10/include/linux/sched.h    Fri Jan 26 19:03:05 2001
+++ work/include/linux/sched.h     Fri Jan 26 19:14:07 2001
@@ -751,6 +751,7 @@

 extern void FASTCALL(add_wait_queue(wait_queue_head_t *q, wait_queue_t *
wait));
 extern void FASTCALL(add_wait_queue_exclusive(wait_queue_head_t *q,
wait_queue_t * wait));
+extern void FASTCALL(add_wait_queue_exclusive_lifo(wait_queue_head_t *q,
wait_queue_t * wait));
 extern void FASTCALL(remove_wait_queue(wait_queue_head_t *q, wait_queue_t
* wait));

 #define __wait_event(wq, condition)                         \
diff -urN v2.4.1pre10/include/linux/wait.h work/include/linux/wait.h
--- v2.4.1pre10/include/linux/wait.h     Thu Jan  4 17:50:46 2001
+++ work/include/linux/wait.h Fri Jan 26 19:14:06 2001
@@ -43,17 +43,20 @@
 } while (0)
 #endif

+typedef struct __wait_queue wait_queue_t;
+typedef void (*wait_queue_func_t)(wait_queue_t *wait);
+
 struct __wait_queue {
     unsigned int flags;
 #define WQ_FLAG_EXCLUSIVE    0x01
     struct task_struct * task;
     struct list_head task_list;
+    wait_queue_func_t func;
 #if WAITQUEUE_DEBUG
     long __magic;
     long __waker;
 #endif
 };
-typedef struct __wait_queue wait_queue_t;

 /*
  * 'dual' spinlock architecture. Can be switched between spinlock_t and
@@ -110,7 +113,7 @@
 #endif

 #define __WAITQUEUE_INITIALIZER(name,task) \
-    { 0x0, task, { NULL, NULL } __WAITQUEUE_DEBUG_INIT(name)}
+    { 0x0, task, { NULL, NULL }, NULL __WAITQUEUE_DEBUG_INIT(name)}
 #define DECLARE_WAITQUEUE(name,task) \
     wait_queue_t name = __WAITQUEUE_INITIALIZER(name,task)

@@ -144,6 +147,22 @@
 #endif
     q->flags = 0;
     q->task = p;
+    q->func = NULL;
+#if WAITQUEUE_DEBUG
+    q->__magic = (long)&q->__magic;
+#endif
+}
+
+static inline void init_waitqueue_func_entry(wait_queue_t *q,
+                        wait_queue_func_t func)
+{
+#if WAITQUEUE_DEBUG
+    if (!q || !p)
+         WQ_BUG();
+#endif
+    q->flags = 0;
+    q->task = NULL;
+    q->func = func;
 #if WAITQUEUE_DEBUG
     q->__magic = (long)&q->__magic;
 #endif
@@ -200,6 +219,19 @@
 #endif
     list_del(&old->task_list);
 }
+
+#define add_wait_queue_cond(q, wait, cond, fail) \
+    do {                                \
+         unsigned long flags;                     \
+         wq_write_lock_irqsave(&(q)->lock, flags);     \
+         (wait)->flags = 0;                  \
+         if (cond)                      \
+              __add_wait_queue((q), (wait));           \
+         else {                              \
+              fail;                          \
+         }                              \
+         wq_write_unlock_irqrestore(&(q)->lock, flags);     \
+    } while (0)

 #endif /* __KERNEL__ */

diff -urN v2.4.1pre10/kernel/fork.c work/kernel/fork.c
--- v2.4.1pre10/kernel/fork.c Fri Jan 26 19:03:05 2001
+++ work/kernel/fork.c   Fri Jan 26 19:06:29 2001
@@ -44,6 +44,16 @@
     wq_write_unlock_irqrestore(&q->lock, flags);
 }

+void add_wait_queue_exclusive_lifo(wait_queue_head_t *q, wait_queue_t *
wait)
+{
+    unsigned long flags;
+
+    wq_write_lock_irqsave(&q->lock, flags);
+    wait->flags = WQ_FLAG_EXCLUSIVE;
+    __add_wait_queue(q, wait);
+    wq_write_unlock_irqrestore(&q->lock, flags);
+}
+
 void add_wait_queue_exclusive(wait_queue_head_t *q, wait_queue_t * wait)
 {
     unsigned long flags;
diff -urN v2.4.1pre10/kernel/sched.c work/kernel/sched.c
--- v2.4.1pre10/kernel/sched.c     Fri Jan 26 19:03:05 2001
+++ work/kernel/sched.c  Fri Jan 26 19:10:19 2001
@@ -714,12 +714,22 @@
     while (tmp != head) {
          unsigned int state;
                 wait_queue_t *curr = list_entry(tmp, wait_queue_t,
task_list);
+         wait_queue_func_t func;

          tmp = tmp->next;

 #if WAITQUEUE_DEBUG
          CHECK_MAGIC(curr->__magic);
 #endif
+         func = curr->func;
+         if (func) {
+              unsigned flags = curr->flags;
+              func(curr);
+              if (flags & WQ_FLAG_EXCLUSIVE && !--nr_exclusive)
+                   break;
+              continue;
+         }
+
          p = curr->task;
          state = p->state;
          if (state & mode) {


_______________________________________________
Kiobuf-io-devel mailing list
Kiobuf-io-devel@lists.sourceforge.net
http://lists.sourceforge.net/lists/listinfo/kiobuf-io-devel



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
