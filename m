Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263599AbUCUEEP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 23:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbUCUEEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 23:04:15 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:44991 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263599AbUCUEEI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 23:04:08 -0500
Message-ID: <405D1433.4000904@cyberone.com.au>
Date: Sun, 21 Mar 2004 15:04:03 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [BENCHMARKS] 2.6.4 vs 2.6.4-mm1
References: <40525C1F.5030705@cyberone.com.au> <20040319095047.GA6301@elte.hu> <405AC456.1070806@cyberone.com.au>
In-Reply-To: <405AC456.1070806@cyberone.com.au>
Content-Type: multipart/mixed;
 boundary="------------060603040003000701050405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060603040003000701050405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Nick Piggin wrote:

>
> That would be interesting, yes. I have (somewhere) a patch
> that wakes up the semaphore's waiters outside its spinlock.
> I think that only gave about 5% or so improvement though.
>
>

Here is a cleaned up patch for comments. It is untested at the
moment because I don't have access to the 16-way NUMAQ now. It
moves waking of the waiters outside the spinlock.

I think it gave about 5-10% improvement when the rwsem gets
really contended. Not as much as I had hoped, but every bit
helps.

The rwsem-spinlock.c code could use the same optimisation too.


--------------060603040003000701050405
Content-Type: text/x-patch;
 name="rwsem-scale.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rwsem-scale.patch"


Move rwsem's up_read wakeups out of the semaphore's wait_lock


 linux-2.6-npiggin/lib/rwsem.c |   49 +++++++++++++++++++-----------------------
 1 files changed, 23 insertions(+), 26 deletions(-)

diff -puN lib/rwsem.c~rwsem-scale lib/rwsem.c
--- linux-2.6/lib/rwsem.c~rwsem-scale	2004-03-21 14:01:12.000000000 +1100
+++ linux-2.6-npiggin/lib/rwsem.c	2004-03-21 14:30:19.000000000 +1100
@@ -35,13 +35,15 @@ void rwsemtrace(struct rw_semaphore *sem
  * - the spinlock must be held by the caller
  * - woken process blocks are discarded from the list after having flags zeroised
  * - writers are only woken if wakewrite is non-zero
+ *
+ * The spinlock will be dropped by this function
  */
 static inline struct rw_semaphore *__rwsem_do_wake(struct rw_semaphore *sem, int wakewrite)
 {
+	LIST_HEAD(wake_list);
 	struct rwsem_waiter *waiter;
-	struct list_head *next;
 	signed long oldcount;
-	int woken, loop;
+	int woken;
 
 	rwsemtrace(sem,"Entering __rwsem_do_wake");
 
@@ -63,9 +65,8 @@ static inline struct rw_semaphore *__rws
 	if (!(waiter->flags & RWSEM_WAITING_FOR_WRITE))
 		goto readers_only;
 
-	list_del(&waiter->list);
+	list_move_tail(&waiter->list, &wake_list);
 	waiter->flags = 0;
-	wake_up_process(waiter->task);
 	goto out;
 
 	/* don't want to wake any writers */
@@ -74,13 +75,16 @@ static inline struct rw_semaphore *__rws
 	if (waiter->flags & RWSEM_WAITING_FOR_WRITE)
 		goto out;
 
-	/* grant an infinite number of read locks to the readers at the front of the queue
-	 * - note we increment the 'active part' of the count by the number of readers (less one
-	 *   for the activity decrement we've already done) before waking any processes up
+	/* grant an infinite number of read locks to the readers at the front
+	 * of the queue - note we increment the 'active part' of the count by
+	 * the number of readers (less one for the activity decrement we've
+	 * already done) before waking any processes up
 	 */
  readers_only:
 	woken = 0;
 	do {
+		list_move_tail(&waiter->list, &wake_list);
+		waiter->flags = 0;
 		woken++;
 
 		if (waiter->list.next==&sem->wait_list)
@@ -90,23 +94,17 @@ static inline struct rw_semaphore *__rws
 
 	} while (waiter->flags & RWSEM_WAITING_FOR_READ);
 
-	loop = woken;
 	woken *= RWSEM_ACTIVE_BIAS-RWSEM_WAITING_BIAS;
 	woken -= RWSEM_ACTIVE_BIAS;
 	rwsem_atomic_add(woken,sem);
 
-	next = sem->wait_list.next;
-	for (; loop>0; loop--) {
-		waiter = list_entry(next,struct rwsem_waiter,list);
-		next = waiter->list.next;
-		waiter->flags = 0;
+ out:
+	spin_unlock(&sem->wait_lock);
+	while (!list_empty(&wake_list)) {
+		waiter = list_entry(wake_list.next,struct rwsem_waiter,list);
+		list_del(&waiter->list);
 		wake_up_process(waiter->task);
 	}
-
-	sem->wait_list.next = next;
-	next->prev = &sem->wait_list;
-
- out:
 	rwsemtrace(sem,"Leaving __rwsem_do_wake");
 	return sem;
 
@@ -130,9 +128,8 @@ static inline struct rw_semaphore *rwsem
 	set_task_state(tsk,TASK_UNINTERRUPTIBLE);
 
 	/* set up my own style of waitqueue */
-	spin_lock(&sem->wait_lock);
 	waiter->task = tsk;
-
+	spin_lock(&sem->wait_lock);
 	list_add_tail(&waiter->list,&sem->wait_list);
 
 	/* note that we're now waiting on the lock, but no longer actively read-locking */
@@ -143,8 +140,8 @@ static inline struct rw_semaphore *rwsem
 	 */
 	if (!(count & RWSEM_ACTIVE_MASK))
 		sem = __rwsem_do_wake(sem,1);
-
-	spin_unlock(&sem->wait_lock);
+	else
+		spin_unlock(&sem->wait_lock);
 
 	/* wait to be given the lock */
 	for (;;) {
@@ -204,8 +201,8 @@ struct rw_semaphore fastcall *rwsem_wake
 	/* do nothing if list empty */
 	if (!list_empty(&sem->wait_list))
 		sem = __rwsem_do_wake(sem,1);
-
-	spin_unlock(&sem->wait_lock);
+	else
+		spin_unlock(&sem->wait_lock);
 
 	rwsemtrace(sem,"Leaving rwsem_wake");
 
@@ -226,8 +223,8 @@ struct rw_semaphore fastcall *rwsem_down
 	/* do nothing if list empty */
 	if (!list_empty(&sem->wait_list))
 		sem = __rwsem_do_wake(sem,0);
-
-	spin_unlock(&sem->wait_lock);
+	else
+		spin_unlock(&sem->wait_lock);
 
 	rwsemtrace(sem,"Leaving rwsem_downgrade_wake");
 	return sem;

_

--------------060603040003000701050405--
