Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264451AbTLLBwl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 20:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264452AbTLLBwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 20:52:41 -0500
Received: from mail-02.iinet.net.au ([203.59.3.34]:44226 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264451AbTLLBwf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 20:52:35 -0500
Message-ID: <3FD91F5D.30005@cyberone.com.au>
Date: Fri, 12 Dec 2003 12:52:29 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: William Lee Irwin III <wli@holomorphy.com>, Ingo Molnar <mingo@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Anton Blanchard <anton@samba.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>
Subject: [PATCH] improve rwsem scalability (was Re: [CFT][RFC] HT scheduler)
References: <20031208155904.GF19412@krispykreme> <3FD50456.3050003@cyberone.com.au> <20031209001412.GG19412@krispykreme> <3FD7F1B9.5080100@cyberone.com.au> <3FD81BA4.8070602@cyberone.com.au> <3FD8317B.4060207@cyberone.com.au> <20031211115222.GC8039@holomorphy.com> <3FD86C70.5000408@cyberone.com.au> <20031211132301.GD8039@holomorphy.com> <3FD8715F.9070304@cyberone.com.au> <20031211133207.GE8039@holomorphy.com> <3FD88D93.3000909@cyberone.com.au>
In-Reply-To: <3FD88D93.3000909@cyberone.com.au>
Content-Type: multipart/mixed;
 boundary="------------020004000102020106050000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020004000102020106050000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Nick Piggin wrote:

>
>
> William Lee Irwin III wrote:
>
>> William Lee Irwin III wrote:
>>
>>>> It will get contention anyway if they're all pounding on the same 
>>>> futex.
>>>> OTOH, if they're all threads in the same process, they can hit other
>>>> problems. I'll try to find out more about hackbench.
>>>>
>>
>>
>> On Fri, Dec 12, 2003 at 12:30:07AM +1100, Nick Piggin wrote:
>>
>>> Oh, sorry I was talking about volanomark. hackbench AFAIK doesn't use
>>> futexes at all, just pipes, and is not threaded at all, so it looks 
>>> like
>>> a different problem to the volanomark one.
>>> hackbench runs into trouble at large numbers of tasks too though.
>>>
>>
>> Volano is all one process address space so it could be 
>> ->page_table_lock;
>> any chance you could find which spin_lock() call the pounded chunk of 
>> the
>> lock section jumps back to?
>>
>>
>
> OK its in futex_wait, up_read(&current->mm->mmap_sem) right after
> out_release_sem (line 517).
>
> So you get half points. Looks like its waiting on the bus rather than
> spinning on a lock. Or am I'm wrong?
>

The following patch moves the rwsem's up_read wake ups out of the
wait_lock. Wakeups need to aquire a runqueue lock which is probably
getting contended. The following graph is a best of 3 runs average.
http://www.kerneltrap.org/~npiggin/rwsem.png

The part to look at is the tail. I need to do some more testing to
see if its significant.


--------------020004000102020106050000
Content-Type: text/plain;
 name="rwsem-scale.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rwsem-scale.patch"


Move rwsem's up_read wakeups out of the semaphore's wait_lock


 linux-2.6-npiggin/lib/rwsem.c |   39 +++++++++++++++++++++++++--------------
 1 files changed, 25 insertions(+), 14 deletions(-)

diff -puN lib/rwsem.c~rwsem-scale lib/rwsem.c
--- linux-2.6/lib/rwsem.c~rwsem-scale	2003-12-12 12:50:14.000000000 +1100
+++ linux-2.6-npiggin/lib/rwsem.c	2003-12-12 12:50:14.000000000 +1100
@@ -8,7 +8,7 @@
 #include <linux/module.h>
 
 struct rwsem_waiter {
-	struct list_head	list;
+	struct list_head	list, wake_list;
 	struct task_struct	*task;
 	unsigned int		flags;
 #define RWSEM_WAITING_FOR_READ	0x00000001
@@ -38,6 +38,7 @@ void rwsemtrace(struct rw_semaphore *sem
  */
 static inline struct rw_semaphore *__rwsem_do_wake(struct rw_semaphore *sem, int wakewrite)
 {
+	LIST_HEAD(wake_list);
 	struct rwsem_waiter *waiter;
 	struct list_head *next;
 	signed long oldcount;
@@ -65,7 +66,8 @@ static inline struct rw_semaphore *__rws
 
 	list_del(&waiter->list);
 	waiter->flags = 0;
-	wake_up_process(waiter->task);
+	if (list_empty(&waiter->wake_list))
+		list_add_tail(&waiter->wake_list, &wake_list);
 	goto out;
 
 	/* don't want to wake any writers */
@@ -74,9 +76,10 @@ static inline struct rw_semaphore *__rws
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
@@ -100,13 +103,21 @@ static inline struct rw_semaphore *__rws
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
+		list_del_init(&waiter->wake_list);
+		mb();
+		wake_up_process(waiter->task);
+	}
 	rwsemtrace(sem,"Leaving __rwsem_do_wake");
 	return sem;
 
@@ -130,9 +141,9 @@ static inline struct rw_semaphore *rwsem
 	set_task_state(tsk,TASK_UNINTERRUPTIBLE);
 
 	/* set up my own style of waitqueue */
-	spin_lock(&sem->wait_lock);
 	waiter->task = tsk;
-
+	INIT_LIST_HEAD(&waiter->wake_list);
+	spin_lock(&sem->wait_lock);
 	list_add_tail(&waiter->list,&sem->wait_list);
 
 	/* note that we're now waiting on the lock, but no longer actively read-locking */
@@ -143,8 +154,8 @@ static inline struct rw_semaphore *rwsem
 	 */
 	if (!(count & RWSEM_ACTIVE_MASK))
 		sem = __rwsem_do_wake(sem,1);
-
-	spin_unlock(&sem->wait_lock);
+	else
+		spin_unlock(&sem->wait_lock);
 
 	/* wait to be given the lock */
 	for (;;) {
@@ -204,8 +215,8 @@ struct rw_semaphore *rwsem_wake(struct r
 	/* do nothing if list empty */
 	if (!list_empty(&sem->wait_list))
 		sem = __rwsem_do_wake(sem,1);
-
-	spin_unlock(&sem->wait_lock);
+	else
+		spin_unlock(&sem->wait_lock);
 
 	rwsemtrace(sem,"Leaving rwsem_wake");
 
@@ -226,8 +237,8 @@ struct rw_semaphore *rwsem_downgrade_wak
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

--------------020004000102020106050000--

