Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265339AbTLSE52 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 23:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265445AbTLSE51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 23:57:27 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:36512 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265339AbTLSE5U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 23:57:20 -0500
Message-ID: <3FE28529.1010003@cyberone.com.au>
Date: Fri, 19 Dec 2003 15:57:13 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@redhat.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>,
       John Hawkes <hawkes@sgi.com>
Subject: Re: [CFT][RFC] HT scheduler
References: <20031215060838.BF3D32C257@lists.samba.org> <3FDE3EF7.7000001@cyberone.com.au>
In-Reply-To: <3FDE3EF7.7000001@cyberone.com.au>
Content-Type: multipart/mixed;
 boundary="------------050903040702010807070302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050903040702010807070302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Nick Piggin wrote:

>
>
> Rusty Russell wrote:
>
>>
>> A few things need work:
>>
>> 1) There's a race between sys_sched_setaffinity() and
>>   sched_migrate_task() (this is nothing to do with your patch).
>>
>
> Yep. They should both take the task's runqueue lock. 


Easier said than done... anyway, how does this patch look?
It should also cure a possible and not entirely unlikely use
after free of the task_struct in sched_migrate_task on NUMA
AFAIKS.

Patch is on top of a few other changes so might not apply, just
for review. I'll release a new rollup with this included soon.

>
>
>>
>> 2) Please change those #defines into an enum for idle (patch follows,
>>   untested but trivial)
>>
>
> Thanks, I'll take the patch.


done

>
>>
>> 3) conditional locking in load_balance is v. bad idea.
>>
>
> Yeah... I'm thinking about this. I don't think it should be too hard
> to break out the shared portion. 


done

>
>
>>
>> 4) load_balance returns "(!failed && !balanced)", but callers stop
>>   calling it when it returns true.  Why not simply return "balanced",
>>   or at least "balanced && !failed"?
>>
>>
>
> No, the idle balancer stops calling it when it returns true, the periodic
> balancer sets idle to 0 when it returns true.
>
> !balanced && !failed means it has moved a task.
>
> I'll either comment that, or return it in a more direct way.
>

done



--------------050903040702010807070302
Content-Type: text/plain;
 name="sched-migrate-affinity-race.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-migrate-affinity-race.patch"


Prevents a race where sys_sched_setaffinity can race with sched_migrate_task
and cause sched_migrate_task to restore an invalid cpu mask.


 linux-2.6-npiggin/kernel/sched.c |   89 +++++++++++++++++++++++++++++----------
 1 files changed, 68 insertions(+), 21 deletions(-)

diff -puN kernel/sched.c~sched-migrate-affinity-race kernel/sched.c
--- linux-2.6/kernel/sched.c~sched-migrate-affinity-race	2003-12-19 14:45:58.000000000 +1100
+++ linux-2.6-npiggin/kernel/sched.c	2003-12-19 15:19:30.000000000 +1100
@@ -947,6 +947,9 @@ static inline void double_rq_unlock(runq
 }
 
 #ifdef CONFIG_NUMA
+
+static inline int __set_cpus_allowed(task_t *p, cpumask_t new_mask, unsigned long *flags);
+
 /*
  * If dest_cpu is allowed for this process, migrate the task to it.
  * This is accomplished by forcing the cpu_allowed mask to only
@@ -955,16 +958,43 @@ static inline void double_rq_unlock(runq
  */
 static void sched_migrate_task(task_t *p, int dest_cpu)
 {
-	cpumask_t old_mask;
+	runqueue_t *rq;
+	unsigned long flags;
+	cpumask_t old_mask, new_mask = cpumask_of_cpu(dest_cpu);
 
+	rq = task_rq_lock(p, &flags);
 	old_mask = p->cpus_allowed;
-	if (!cpu_isset(dest_cpu, old_mask))
+	if (!cpu_isset(dest_cpu, old_mask)) {
+		task_rq_unlock(rq, &flags);
 		return;
+	}
+
+	get_task_struct(p);
+
 	/* force the process onto the specified CPU */
-	set_cpus_allowed(p, cpumask_of_cpu(dest_cpu));
+	if (__set_cpus_allowed(p, new_mask, &flags) < 0)
+		goto out;
+
+	/* __set_cpus_allowed unlocks the runqueue */
+	rq = task_rq_lock(p, &flags);
+	if (unlikely(p->cpus_allowed != new_mask)) {
+		/*
+		 * We have raced with another set_cpus_allowed.
+		 * old_mask is invalid and we needn't move the
+		 * task back.
+		 */
+		task_rq_unlock(rq, &flags);
+		goto out;
+	}
+
+	/*
+	 * restore the cpus allowed mask. old_mask must be valid because
+	 * p->cpus_allowed is a subset of old_mask.
+	 */
+	__set_cpus_allowed(p, old_mask, &flags);
 
-	/* restore the cpus allowed mask */
-	set_cpus_allowed(p, old_mask);
+out:
+	put_task_struct(p);
 }
 
 /*
@@ -2603,31 +2633,27 @@ typedef struct {
 } migration_req_t;
 
 /*
- * Change a given task's CPU affinity. Migrate the thread to a
- * proper CPU and schedule it away if the CPU it's executing on
- * is removed from the allowed bitmask.
- *
- * NOTE: the caller must have a valid reference to the task, the
- * task must not exit() & deallocate itself prematurely.  The
- * call is not atomic; no spinlocks may be held.
+ * See comment for set_cpus_allowed. calling rules are different:
+ * the task's runqueue lock must be held, and __set_cpus_allowed
+ * will return with the runqueue unlocked.
  */
-int set_cpus_allowed(task_t *p, cpumask_t new_mask)
+static inline int __set_cpus_allowed(task_t *p, cpumask_t new_mask, unsigned long *flags)
 {
-	unsigned long flags;
 	migration_req_t req;
-	runqueue_t *rq;
+	runqueue_t *rq = task_rq(p);
 
-	if (any_online_cpu(new_mask) == NR_CPUS)
+	if (any_online_cpu(new_mask) == NR_CPUS) {
+		task_rq_unlock(rq, flags);
 		return -EINVAL;
+	}
 
-	rq = task_rq_lock(p, &flags);
 	p->cpus_allowed = new_mask;
 	/*
 	 * Can the task run on the task's current CPU? If not then
 	 * migrate the thread off to a proper CPU.
 	 */
 	if (cpu_isset(task_cpu(p), new_mask)) {
-		task_rq_unlock(rq, &flags);
+		task_rq_unlock(rq, flags);
 		return 0;
 	}
 	/*
@@ -2636,18 +2662,39 @@ int set_cpus_allowed(task_t *p, cpumask_
 	 */
 	if (!p->array && !task_running(rq, p)) {
 		set_task_cpu(p, any_online_cpu(p->cpus_allowed));
-		task_rq_unlock(rq, &flags);
+		task_rq_unlock(rq, flags);
 		return 0;
 	}
+
 	init_completion(&req.done);
 	req.task = p;
 	list_add(&req.list, &rq->migration_queue);
-	task_rq_unlock(rq, &flags);
+	task_rq_unlock(rq, flags);
 
 	wake_up_process(rq->migration_thread);
-
 	wait_for_completion(&req.done);
+
 	return 0;
+
+}
+
+/*
+ * Change a given task's CPU affinity. Migrate the thread to a
+ * proper CPU and schedule it away if the CPU it's executing on
+ * is removed from the allowed bitmask.
+ *
+ * NOTE: the caller must have a valid reference to the task, the
+ * task must not exit() & deallocate itself prematurely.  The
+ * call is not atomic; no spinlocks may be held.
+ */
+int set_cpus_allowed(task_t *p, cpumask_t new_mask)
+{
+	unsigned long flags;
+	runqueue_t *rq;
+
+	rq = task_rq_lock(p, &flags);
+
+	return __set_cpus_allowed(p, new_mask, &flags);
 }
 
 EXPORT_SYMBOL_GPL(set_cpus_allowed);

_

--------------050903040702010807070302--

