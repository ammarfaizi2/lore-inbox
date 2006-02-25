Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWBYQs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWBYQs6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 11:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWBYQs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 11:48:58 -0500
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:8294 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932280AbWBYQs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 11:48:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=hwR1AroL23EBR/HOkbRTeYD4F/HEOA6phV8O7xBTUhLjC9Hjine5v3gCnIDHD9xSVeEKCUXyzT0eQjIh/d1mfiKp5oHPKrmD8MabLnXMELfI1rhi8xzXIPd8Bk8hqPF5bcvvy4/j6ykuwKwEhf5XhfXsrCa8Qsk4h5piiaoNv1U=  ;
Message-ID: <44008A73.4030804@yahoo.com.au>
Date: Sun, 26 Feb 2006 03:48:51 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@intel.linux.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, andrea@suse.de
Subject: Re: [Patch 3/3] prepopulate/cache cleared pages
References: <1140686238.2972.30.camel@laptopd505.fenrus.org> <1140772543.2874.20.camel@laptopd505.fenrus.org> <43FED128.1030500@yahoo.com.au> <200602241327.27390.ak@suse.de>
In-Reply-To: <200602241327.27390.ak@suse.de>
Content-Type: multipart/mixed;
 boundary="------------000503060808040200020804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000503060808040200020804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andi Kleen wrote:
> On Friday 24 February 2006 10:26, Nick Piggin wrote:
> 
> 
>>[aside]
>>Actually I have a scalability improvement for rwsems, that moves the
>>actual task wakeups out from underneath the rwsem spinlock in the up()
>>paths. This was useful exactly on a mixed read+write workload on mmap_sem.
>>
>>The difference was quite large for the "generic rwsem" algorithm because
>>it uses the spinlock in fastpaths a lot more than the xadd algorithm. I
>>think x86-64 uses the former, which is what I presume you're testing with?
> 
> 
> I used the generic algorithm because Andrea originally expressed some doubts 
> on the correctness of the xadd algorithms and after trying to understand them 
> myself I wasn't sure myself. Generic was the safer choice.
> 
> But if someone can show convincing numbers that XADD rwsems are faster
> for some workload we can switch. I guess they are tested well enough now
> on i386.
> 
> Or would your scalability improvement remove that difference (if it really exists)?
> 

Here is a forward port of my scalability improvement, untested.

Unfortunately I didn't include absolute performance results, but the
changelog indicates that there was some noticable delta between the
rwsem implementations (and that's what I vaguely remember).

Note: this was with volanomark, which can be quite variable at the
best of times IIRC.

Note2: this was on a 16-way NUMAQ, which had the interconnect
performance of a string between two cans compared to a modern x86-64
of smaller size, so it may be harder to notice an improvement.

-- 
SUSE Labs, Novell Inc.

--------------000503060808040200020804
Content-Type: text/plain;
 name="rwsem-scale.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rwsem-scale.patch"

Move wakeups out from under the rwsem's wait_lock spinlock.

This reduces that lock's contention by a factor of around
10 on a 16-way NUMAQ running volanomark, however cacheline
contention on the rwsem's "activity" drowns out these
small improvements when using the i386 "optimised" rwsem:

unpatched:
55802519 total                                     32.3097
23325323 default_idle                             364458.1719
22084349 .text.lock.futex                         82404.2873
2369107 queue_me                                 24678.1979
1875296 unqueue_me                               9767.1667
1202258 .text.lock.rwsem                         46240.6923
941801 finish_task_switch                       7357.8203
787101 __wake_up                                12298.4531
645252 drop_key_refs                            13442.7500
362789 futex_wait                               839.7894
333294 futex_wake                               1487.9196
146797 rwsem_down_read_failed                   436.8958
 82788 .text.lock.dev                           221.3583
 81221 try_to_wake_up                           133.5872

+rwsem-scale:
58120260 total                                     33.6458
25482132 default_idle                             398158.3125
22774675 .text.lock.futex                         84980.1306
2517797 queue_me                                 26227.0521
1953424 unqueue_me                               10174.0833
1063068 finish_task_switch                       8305.2188
834793 __wake_up                                13043.6406
674570 drop_key_refs                            14053.5417
371811 futex_wait                               860.6736
343398 futex_wake                               1533.0268
155419 try_to_wake_up                           255.6234
114704 .text.lock.rwsem                         4411.6923

The rwsem-spinlock implementation, however, is improved
significantly more, and now gets volanomark performance
similar to the xadd rwsem:

unpatched:
30850964 total                                     18.1787
18986006 default_idle                             296656.3438
3989183 .text.lock.rwsem_spinlock                40294.7778
2990161 .text.lock.futex                         32501.7500
549707 finish_task_switch                       4294.5859
535327 __down_read                              3717.5486
452721 queue_me                                 4715.8438
439725 __up_read                                9160.9375
396273 __wake_up                                6191.7656
326595 unqueue_me                               1701.0156

+rwsem-scale:
25378268 total                                     14.9537
13325514 default_idle                             208211.1562
3675634 .text.lock.futex                         39952.5435
2908629 .text.lock.rwsem_spinlock                28239.1165
628115 __down_read                              4361.9097
607417 finish_task_switch                       4745.4453
588031 queue_me                                 6125.3229
571169 __up_read                                11899.3542
436795 __wake_up                                6824.9219
416788 unqueue_me                               2170.7708


Index: linux-2.6/lib/rwsem.c
===================================================================
--- linux-2.6.orig/lib/rwsem.c	2006-02-26 03:05:01.000000000 +1100
+++ linux-2.6/lib/rwsem.c	2006-02-26 03:37:04.000000000 +1100
@@ -36,14 +36,15 @@ void rwsemtrace(struct rw_semaphore *sem
  * - the spinlock must be held by the caller
  * - woken process blocks are discarded from the list after having task zeroed
  * - writers are only woken if downgrading is false
+ *
+ * The spinlock will be dropped by this function.
  */
-static inline struct rw_semaphore *
-__rwsem_do_wake(struct rw_semaphore *sem, int downgrading)
+static inline void
+__rwsem_do_wake(struct rw_semaphore *sem, int downgrading, unsigned long flags)
 {
+	LIST_HEAD(wake_list);
 	struct rwsem_waiter *waiter;
-	struct task_struct *tsk;
-	struct list_head *next;
-	signed long oldcount, woken, loop;
+	signed long oldcount, woken;
 
 	rwsemtrace(sem, "Entering __rwsem_do_wake");
 
@@ -72,12 +73,8 @@ __rwsem_do_wake(struct rw_semaphore *sem
 	 * It is an allocated on the waiter's stack and may become invalid at
 	 * any time after that point (due to a wakeup from another source).
 	 */
-	list_del(&waiter->list);
-	tsk = waiter->task;
-	smp_mb();
-	waiter->task = NULL;
-	wake_up_process(tsk);
-	put_task_struct(tsk);
+	list_move_tail(&waiter->list, &wake_list);
+	waiter->flags = 0;
 	goto out;
 
 	/* don't want to wake any writers */
@@ -94,41 +91,37 @@ __rwsem_do_wake(struct rw_semaphore *sem
  readers_only:
 	woken = 0;
 	do {
-		woken++;
-
-		if (waiter->list.next == &sem->wait_list)
+		list_move_tail(&waiter->list, &wake_list);
+		waiter->flags = 0;
+		woken += RWSEM_ACTIVE_BIAS - RWSEM_WAITING_BIAS;
+		if (list_empty(&sem->wait_list))
 			break;
 
-		waiter = list_entry(waiter->list.next,
+		waiter = list_entry(sem->wait_list.next,
 					struct rwsem_waiter, list);
-
 	} while (waiter->flags & RWSEM_WAITING_FOR_READ);
 
-	loop = woken;
-	woken *= RWSEM_ACTIVE_BIAS - RWSEM_WAITING_BIAS;
 	if (!downgrading)
 		/* we'd already done one increment earlier */
 		woken -= RWSEM_ACTIVE_BIAS;
 
 	rwsem_atomic_add(woken, sem);
 
-	next = sem->wait_list.next;
-	for (; loop > 0; loop--) {
-		waiter = list_entry(next, struct rwsem_waiter, list);
-		next = waiter->list.next;
+out:
+	spin_unlock_irqrestore(&sem->wait_lock, flags);
+	while (!list_empty(&wake_list)) {
+		struct task_struct *tsk;
+		waiter = list_entry(wake_list.next, struct rwsem_waiter, list);
+		list_del(&waiter->list);
 		tsk = waiter->task;
-		smp_mb();
 		waiter->task = NULL;
+		smp_mb();
 		wake_up_process(tsk);
 		put_task_struct(tsk);
 	}
 
-	sem->wait_list.next = next;
-	next->prev = &sem->wait_list;
-
- out:
 	rwsemtrace(sem, "Leaving __rwsem_do_wake");
-	return sem;
+	return;
 
 	/* undo the change to count, but check for a transition 1->0 */
  undo:
@@ -145,12 +138,13 @@ rwsem_down_failed_common(struct rw_semap
 			struct rwsem_waiter *waiter, signed long adjustment)
 {
 	struct task_struct *tsk = current;
+	unsigned long flags;
 	signed long count;
 
 	set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 
 	/* set up my own style of waitqueue */
-	spin_lock_irq(&sem->wait_lock);
+	spin_lock_irqsave(&sem->wait_lock, flags);
 	waiter->task = tsk;
 	get_task_struct(tsk);
 
@@ -161,14 +155,12 @@ rwsem_down_failed_common(struct rw_semap
 
 	/* if there are no active locks, wake the front queued process(es) up */
 	if (!(count & RWSEM_ACTIVE_MASK))
-		sem = __rwsem_do_wake(sem, 0);
-
-	spin_unlock_irq(&sem->wait_lock);
+		__rwsem_do_wake(sem, 0, flags);
+	else
+		spin_unlock_irqrestore(&sem->wait_lock, flags);
 
 	/* wait to be given the lock */
-	for (;;) {
-		if (!waiter->task)
-			break;
+	while (waiter->task) {
 		schedule();
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 	}
@@ -227,9 +219,9 @@ struct rw_semaphore fastcall *rwsem_wake
 
 	/* do nothing if list empty */
 	if (!list_empty(&sem->wait_list))
-		sem = __rwsem_do_wake(sem, 0);
-
-	spin_unlock_irqrestore(&sem->wait_lock, flags);
+		__rwsem_do_wake(sem, 0, flags);
+	else
+		spin_unlock_irqrestore(&sem->wait_lock, flags);
 
 	rwsemtrace(sem, "Leaving rwsem_wake");
 
@@ -251,9 +243,9 @@ struct rw_semaphore fastcall *rwsem_down
 
 	/* do nothing if list empty */
 	if (!list_empty(&sem->wait_list))
-		sem = __rwsem_do_wake(sem, 1);
-
-	spin_unlock_irqrestore(&sem->wait_lock, flags);
+		__rwsem_do_wake(sem, 1, flags);
+	else
+		spin_unlock_irqrestore(&sem->wait_lock, flags);
 
 	rwsemtrace(sem, "Leaving rwsem_downgrade_wake");
 	return sem;
Index: linux-2.6/lib/rwsem-spinlock.c
===================================================================
--- linux-2.6.orig/lib/rwsem-spinlock.c	2006-02-26 03:05:01.000000000 +1100
+++ linux-2.6/lib/rwsem-spinlock.c	2006-02-26 03:37:42.000000000 +1100
@@ -49,11 +49,11 @@ void fastcall init_rwsem(struct rw_semap
  * - woken process blocks are discarded from the list after having task zeroed
  * - writers are only woken if wakewrite is non-zero
  */
-static inline struct rw_semaphore *
-__rwsem_do_wake(struct rw_semaphore *sem, int wakewrite)
+static inline void
+__rwsem_do_wake(struct rw_semaphore *sem, int wakewrite, unsigned long flags)
 {
+	LIST_HEAD(wake_list);
 	struct rwsem_waiter *waiter;
-	struct task_struct *tsk;
 	int woken;
 
 	rwsemtrace(sem, "Entering __rwsem_do_wake");
@@ -73,46 +73,46 @@ __rwsem_do_wake(struct rw_semaphore *sem
 	 */
 	if (waiter->flags & RWSEM_WAITING_FOR_WRITE) {
 		sem->activity = -1;
-		list_del(&waiter->list);
-		tsk = waiter->task;
-		/* Don't touch waiter after ->task has been NULLed */
-		smp_mb();
-		waiter->task = NULL;
-		wake_up_process(tsk);
-		put_task_struct(tsk);
+		list_move_tail(&waiter->list, &wake_list);
 		goto out;
 	}
 
 	/* grant an infinite number of read locks to the front of the queue */
  dont_wake_writers:
 	woken = 0;
-	while (waiter->flags & RWSEM_WAITING_FOR_READ) {
-		struct list_head *next = waiter->list.next;
+	do {
+		list_move_tail(&waiter->list, &wake_list);
+		woken++;
+		if (list_empty(&sem->wait_list))
+			break;
+		waiter = list_entry(sem->wait_list.next,
+				struct rwsem_waiter, list);
+	} while (waiter->flags & RWSEM_WAITING_FOR_READ);
+
+	sem->activity += woken;
 
+out:
+	spin_unlock_irqrestore(&sem->wait_lock, flags);
+	while (!list_empty(&wake_list)) {
+		struct task_struct *tsk;
+		waiter = list_entry(wake_list.next, struct rwsem_waiter, list);
 		list_del(&waiter->list);
 		tsk = waiter->task;
-		smp_mb();
 		waiter->task = NULL;
+		smp_mb();
 		wake_up_process(tsk);
 		put_task_struct(tsk);
-		woken++;
-		if (list_empty(&sem->wait_list))
-			break;
-		waiter = list_entry(next, struct rwsem_waiter, list);
 	}
 
-	sem->activity += woken;
-
- out:
 	rwsemtrace(sem, "Leaving __rwsem_do_wake");
-	return sem;
 }
 
 /*
  * wake a single writer
+ * called with wait_lock locked and returns with it unlocked.
  */
-static inline struct rw_semaphore *
-__rwsem_wake_one_writer(struct rw_semaphore *sem)
+static inline void
+__rwsem_wake_one_writer(struct rw_semaphore *sem, unsigned long flags)
 {
 	struct rwsem_waiter *waiter;
 	struct task_struct *tsk;
@@ -121,13 +121,13 @@ __rwsem_wake_one_writer(struct rw_semaph
 
 	waiter = list_entry(sem->wait_list.next, struct rwsem_waiter, list);
 	list_del(&waiter->list);
+	spin_unlock_irqrestore(&sem->wait_lock, flags);
 
 	tsk = waiter->task;
-	smp_mb();
 	waiter->task = NULL;
+	smp_mb();
 	wake_up_process(tsk);
 	put_task_struct(tsk);
-	return sem;
 }
 
 /*
@@ -163,9 +163,7 @@ void fastcall __sched __down_read(struct
 	spin_unlock_irq(&sem->wait_lock);
 
 	/* wait to be given the lock */
-	for (;;) {
-		if (!waiter.task)
-			break;
+	while (waiter.task) {
 		schedule();
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 	}
@@ -234,9 +232,7 @@ void fastcall __sched __down_write(struc
 	spin_unlock_irq(&sem->wait_lock);
 
 	/* wait to be given the lock */
-	for (;;) {
-		if (!waiter.task)
-			break;
+	while (waiter.task) {
 		schedule();
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 	}
@@ -283,9 +279,9 @@ void fastcall __up_read(struct rw_semaph
 	spin_lock_irqsave(&sem->wait_lock, flags);
 
 	if (--sem->activity == 0 && !list_empty(&sem->wait_list))
-		sem = __rwsem_wake_one_writer(sem);
-
-	spin_unlock_irqrestore(&sem->wait_lock, flags);
+		__rwsem_wake_one_writer(sem, flags);
+	else
+		spin_unlock_irqrestore(&sem->wait_lock, flags);
 
 	rwsemtrace(sem, "Leaving __up_read");
 }
@@ -303,9 +299,9 @@ void fastcall __up_write(struct rw_semap
 
 	sem->activity = 0;
 	if (!list_empty(&sem->wait_list))
-		sem = __rwsem_do_wake(sem, 1);
-
-	spin_unlock_irqrestore(&sem->wait_lock, flags);
+		__rwsem_do_wake(sem, 1, flags);
+	else
+		spin_unlock_irqrestore(&sem->wait_lock, flags);
 
 	rwsemtrace(sem, "Leaving __up_write");
 }
@@ -324,9 +320,9 @@ void fastcall __downgrade_write(struct r
 
 	sem->activity = 1;
 	if (!list_empty(&sem->wait_list))
-		sem = __rwsem_do_wake(sem, 0);
-
-	spin_unlock_irqrestore(&sem->wait_lock, flags);
+		__rwsem_do_wake(sem, 0, flags);
+	else
+		spin_unlock_irqrestore(&sem->wait_lock, flags);
 
 	rwsemtrace(sem, "Leaving __downgrade_write");
 }

--------------000503060808040200020804--
Send instant messages to your online friends http://au.messenger.yahoo.com 
