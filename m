Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293086AbSCFCju>; Tue, 5 Mar 2002 21:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293083AbSCFCjl>; Tue, 5 Mar 2002 21:39:41 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:59919 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S293086AbSCFCj2>; Tue, 5 Mar 2002 21:39:28 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: frankeh@watson.ibm.com
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: Futexes III : performance numbers 
In-Reply-To: Your message of "Tue, 05 Mar 2002 16:23:14 CDT."
             <20020305212210.B10A33FF04@smtp.linux.ibm.com> 
Date: Wed, 06 Mar 2002 13:08:58 +1100
Message-Id: <E16iQrS-0005vY-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020305212210.B10A33FF04@smtp.linux.ibm.com> you write:
> On Tuesday 05 March 2002 02:01 am, Rusty Russell wrote:
> > 1) FUTEX_UP and FUTEX_DOWN defines. (Robert Love)
> > 2) Fix for the "decrement wraparound" problem (Paul Mackerras)
> > 3) x86 fixes: tested on dual x86 box.
> >
> > Example userspace lib attached,
> > Rusty.
> 
> 
> I did a quick hack to enable ulockflex to run on the latest interface that 
> Rusty posted.

Cool... is this 8-way or some such "serious" SMP?  How about the
below microoptimization (untested, but you get the idea).

> Now 3 processes
>  3  1  5  4 k      0   0   0   99.98   0.00   0.00 0.033284   242040 
>  3  1  5  4 m     0   0   0    0.29   0.00   0.00 0.018406  1979992
>  3  1  5  4 f      0   0   0   99.71   0.00   0.00 0.028083   306140  
>  3  1  5  4 c      0   0   0    7.79   0.00   4.00 0.437084   774175 
> 
> Interesting... the strict FIFO ordering of my fast semaphores limits
> performance as seen by 99.71% contention, so we always ditch
> into the kernel. Convoy Avoidance locks 2.5 times better.

Hmmm... actually I'm limited FIFO, in that I queue on the tail and do
wake one.  Of course, someone can come in userspace and grab the lock
while the guy in the kernel is waking up, and this is clearly
happening here.

This can be fixed, I think, by saying to the one we wake up "you have
the lock" and never actually changing the value to 1.  This might cost
us very little: I'll send another patch this afternoon.

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

--- tmp/kernel/futex.c	Wed Mar  6 13:03:08 2002
+++ working-2.5.6-pre1-futex/kernel/futex.c	Wed Mar  6 13:01:48 2002
@@ -51,12 +51,17 @@
 	atomic_t *count;
 };
 
-/* The key for the hash is the address + index + offset within page */
-static struct list_head futex_queues[1<<FUTEX_HASHBITS];
-static spinlock_t futex_lock = SPIN_LOCK_UNLOCKED;
+/* The key for the hash is the address + offset within page */
+struct futex_head
+{
+	struct list_head list;
+	static spinlock_t lock;
+} ____cacheline_aligned;
 
-static inline struct list_head *hash_futex(struct page *page,
-					   unsigned long offset)
+static struct futex_head futex_queues[1<<FUTEX_HASHBITS] __cacheline_aligned;
+
+static inline struct futex_head *hash_futex(struct page *page,
+					    unsigned long offset)
 {
 	unsigned long h;
 
@@ -66,12 +71,12 @@
 	return &futex_queues[hash_long(h, FUTEX_HASHBITS)];
 }
 
-static inline void wake_one_waiter(struct list_head *head, atomic_t *count)
+static inline void wake_one_waiter(struct futex_head *head, atomic_t *count)
 {
 	struct list_head *i;
 
-	spin_lock(&futex_lock);
-	list_for_each(i, head) {
+	spin_lock(&head->lock);
+	list_for_each(i, &head->list) {
 		struct futex_q *this = list_entry(i, struct futex_q, list);
 
 		if (this->count == count) {
@@ -79,27 +84,27 @@
 			break;
 		}
 	}
-	spin_unlock(&futex_lock);
+	spin_unlock(&head->lock);
 }
 
 /* Add at end to avoid starvation */
-static inline void queue_me(struct list_head *head,
+static inline void queue_me(struct futex_head *head,
 			    struct futex_q *q,
 			    atomic_t *count)
 {
 	q->task = current;
 	q->count = count;
 
-	spin_lock(&futex_lock);
-	list_add_tail(&q->list, head);
-	spin_unlock(&futex_lock);
+	spin_lock(&head->lock);
+	list_add_tail(&q->list, &head->list);
+	spin_unlock(&head->lock);
 }
 
-static inline void unqueue_me(struct futex_q *q)
+static inline void unqueue_me(struct futex_head *head, struct futex_q *q)
 {
-	spin_lock(&futex_lock);
+	spin_lock(&head->lock);
 	list_del(&q->list);
-	spin_unlock(&futex_lock);
+	spin_unlock(&head->lock);
 }
 
 /* Get kernel address of the user page and pin it. */
@@ -124,7 +129,7 @@
 }
 
 /* Simplified from arch/ppc/kernel/semaphore.c: Paul M. is a genius. */
-static int futex_down(struct list_head *head, atomic_t *count)
+static int futex_down(struct futex_head *head, atomic_t *count)
 {
 	int retval = 0;
 	struct futex_q q;
@@ -143,7 +148,7 @@
 		current->state = TASK_INTERRUPTIBLE;
 	}
 	current->state = TASK_RUNNING;
-	unqueue_me(&q);
+	unqueue_me(head, &q);
 	/* If we were signalled, we might have just been woken: we
 	   must wake another one.  Otherwise we need to wake someone
 	   else (if they are waiting) so they drop the count below 0,
@@ -153,7 +158,7 @@
 	return retval;
 }
 
-static int futex_up(struct list_head *head, atomic_t *count)
+static int futex_up(struct futex_head *head, atomic_t *count)
 {
 	atomic_set(count, 1);
 	smp_wmb();
@@ -165,7 +170,7 @@
 {
 	int ret;
 	unsigned long pos_in_page;
-	struct list_head *head;
+	struct futex_head *head;
 	struct page *page;
 
 	pos_in_page = ((unsigned long)uaddr) % PAGE_SIZE;
@@ -201,8 +206,10 @@
 {
 	unsigned int i;
 
-	for (i = 0; i < ARRAY_SIZE(futex_queues); i++)
-		INIT_LIST_HEAD(&futex_queues[i]);
+	for (i = 0; i < ARRAY_SIZE(futex_queues); i++) {
+		INIT_LIST_HEAD(&futex_queues[i].list);
+		spin_lock_init(&futex_queues[i].lock);
+	}
 	return 0;
 }
 __initcall(init);
