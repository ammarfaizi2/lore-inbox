Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263734AbTLTAIj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 19:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbTLTAIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 19:08:39 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:62936 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263734AbTLTAId
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 19:08:33 -0500
Message-ID: <3FE392FC.3030902@cyberone.com.au>
Date: Sat, 20 Dec 2003 11:08:28 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Ingo Molnar <mingo@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Anton Blanchard <anton@samba.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>
Subject: Re: [PATCH] improve rwsem scalability (was Re: [CFT][RFC] HT scheduler)
References: <20031208155904.GF19412@krispykreme> <3FD50456.3050003@cyberone.com.au> <20031209001412.GG19412@krispykreme> <3FD7F1B9.5080100@cyberone.com.au> <3FD81BA4.8070602@cyberone.com.au> <3FD8317B.4060207@cyberone.com.au> <20031211115222.GC8039@holomorphy.com> <3FD86C70.5000408@cyberone.com.au> <20031211132301.GD8039@holomorphy.com> <3FD8715F.9070304@cyberone.com.au> <20031211133207.GE8039@holomorphy.com> <3FD88D93.3000909@cyberone.com.au> <3FD91F5D.30005@cyberone.com.au> <Pine.LNX.4.58.0312120440400.14103@devserv.devel.redhat.com> <3FDA5842.9090109@cyberone.com.au> <3FDBB261.5010208@cyberone.com.au> <3FDFE95C.9050901@cyberone.com.au> <3FE2E67A.70809@cyberone.com.au> <35510000.1071846377@[10.10.2.4]>
In-Reply-To: <35510000.1071846377@[10.10.2.4]>
Content-Type: multipart/mixed;
 boundary="------------090005030005020505010001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090005030005020505010001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Martin J. Bligh wrote:

>>>What do you think? Is there any other sorts of benchmarks I should try?
>>>The improvement I think is significant, although volanomark is quite
>>>erratic and doesn't show it well.
>>>
>>>I don't see any problem with moving the wakeups out of the rwsem's 
>>>spinlock.
>>>
>>>
>>Actually my implementation does have a race because list_del_init isn't
>>atomic. Shouldn't be difficult to fix if anyone cares about it... otherwise
>>I won't bother.
>>
>
>If you can fix it up, I'll get people here to do some more testing on the
>patch on other benchmarks, etc.
>

OK, this one should work. There isn't much that uses rwsems, but mmap_sem
is the obvious one.

So if the patch helps anywhere, it will be something heavily threaded, that
is taking the mmap sem a lot (mostly for reading, sometimes writing), with
a lot of CPUs and a lot of runqueue activity (ie waking up, sleeping, tasks
running).


--------------090005030005020505010001
Content-Type: text/plain;
 name="rwsem-scale.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rwsem-scale.patch"


Move rwsem's up_read wakeups out of the semaphore's wait_lock


 linux-2.6-npiggin/lib/rwsem.c |   42 ++++++++++++++++++++++++++++--------------
 1 files changed, 28 insertions(+), 14 deletions(-)

diff -puN lib/rwsem.c~rwsem-scale lib/rwsem.c
--- linux-2.6/lib/rwsem.c~rwsem-scale	2003-12-20 02:17:36.000000000 +1100
+++ linux-2.6-npiggin/lib/rwsem.c	2003-12-20 02:23:59.000000000 +1100
@@ -8,7 +8,7 @@
 #include <linux/module.h>
 
 struct rwsem_waiter {
-	struct list_head	list;
+	struct list_head	list, wake_list;
 	struct task_struct	*task;
 	unsigned int		flags;
 #define RWSEM_WAITING_FOR_READ	0x00000001
@@ -35,9 +35,12 @@ void rwsemtrace(struct rw_semaphore *sem
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
 	struct list_head *next;
 	signed long oldcount;
@@ -65,7 +68,8 @@ static inline struct rw_semaphore *__rws
 
 	list_del(&waiter->list);
 	waiter->flags = 0;
-	wake_up_process(waiter->task);
+	if (list_empty(&waiter->wake_list))
+		list_add_tail(&waiter->wake_list, &wake_list);
 	goto out;
 
 	/* don't want to wake any writers */
@@ -74,9 +78,10 @@ static inline struct rw_semaphore *__rws
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
@@ -100,13 +105,22 @@ static inline struct rw_semaphore *__rws
 		waiter = list_entry(next,struct rwsem_waiter,list);
 		next = waiter->list.next;
 		waiter->flags = 0;
-		wake_up_process(waiter->task);
+		if (list_empty(&waiter->wake_list))
+			list_add_tail(&waiter->wake_list, &wake_list);
 	}
 
 	sem->wait_list.next = next;
 	next->prev = &sem->wait_list;
 
  out:
+	spin_unlock(&sem->wait_lock);
+	while (!list_empty(&wake_list)) {
+		waiter = list_entry(wake_list.next,struct rwsem_waiter,wake_list);
+		list_del(&waiter->wake_list);
+		waiter->wake_list.next = &waiter->wake_list;
+		wmb(); /* Mustn't lose wakeups */
+		wake_up_process(waiter->task);
+	}
 	rwsemtrace(sem,"Leaving __rwsem_do_wake");
 	return sem;
 
@@ -130,9 +144,9 @@ static inline struct rw_semaphore *rwsem
 	set_task_state(tsk,TASK_UNINTERRUPTIBLE);
 
 	/* set up my own style of waitqueue */
-	spin_lock(&sem->wait_lock);
 	waiter->task = tsk;
-
+	INIT_LIST_HEAD(&waiter->wake_list);
+	spin_lock(&sem->wait_lock);
 	list_add_tail(&waiter->list,&sem->wait_list);
 
 	/* note that we're now waiting on the lock, but no longer actively read-locking */
@@ -143,8 +157,8 @@ static inline struct rw_semaphore *rwsem
 	 */
 	if (!(count & RWSEM_ACTIVE_MASK))
 		sem = __rwsem_do_wake(sem,1);
-
-	spin_unlock(&sem->wait_lock);
+	else
+		spin_unlock(&sem->wait_lock);
 
 	/* wait to be given the lock */
 	for (;;) {
@@ -204,8 +218,8 @@ struct rw_semaphore *rwsem_wake(struct r
 	/* do nothing if list empty */
 	if (!list_empty(&sem->wait_list))
 		sem = __rwsem_do_wake(sem,1);
-
-	spin_unlock(&sem->wait_lock);
+	else
+		spin_unlock(&sem->wait_lock);
 
 	rwsemtrace(sem,"Leaving rwsem_wake");
 
@@ -226,8 +240,8 @@ struct rw_semaphore *rwsem_downgrade_wak
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

--------------090005030005020505010001--

