Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263415AbUDUQzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbUDUQzj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 12:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbUDUQzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 12:55:39 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:61917 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263415AbUDUQzG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 12:55:06 -0400
Date: Wed, 21 Apr 2004 22:14:36 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: rusty@au1.ibm.com
Cc: mingo@elte.hu, nickpiggin@yahoo.com.au, akpm@osdl.org,
       linux-kernel@vger.kernel.org, lhcs-devel@lists.sourceforge.net
Subject: Re: CPU Hotplug broken -mm5 onwards
Message-ID: <20040421164436.GA11760@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040418170613.GA21769@in.ibm.com> <20040421023650.24b9f85a.akpm@osdl.org> <20040421095939.GB10767@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040421095939.GB10767@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 03:29:39PM +0530, Srivatsa Vaddagiri wrote:
> On Wed, Apr 21, 2004 at 02:36:50AM -0700, Andrew Morton wrote:
> > 
> > Not sure who to aim this at, but:  poke.
> 
> I found that removing the lock in exec path has other consequences
> which I am fixing/testing. I will be sending an updated patch later today 
> (against 2.6.6-rc1-mm1) to fix all those issues.

Found that lockless migration of execing task is _extremely_ racy.
The races I hit are described below, alongwith probable solutions.

Task migration done elsewhere should be safe (?) since they either
hold the lock (sys_sched_setaffinity) or are done entirely with preemption 
disabled (load_balance).


   sched_balance_exec does:

	a. disables preemption
	b. finds new_cpu for current
	c. enables preemption 
	d. calls sched_migrate_task to migrate current to new_cpu

   and sched_migrate_task does:

	e. task_rq_lock(p)
	f. migrate_task(p, dest_cpu ..)
		(if we have to wait for migration thread)
		g. task_rq_unlock()
		h. wake_up_process(rq->migration_thread)
		i. wait_for_completion()


   Several things can happen here:

	1. new_cpu can go down after h and before migration thread has
	   got around to handle the request

	   ==> we need to add a cpu_is_offline check in __migrate_task
		
	2. new_cpu can go down between c and d or before f.

	   ===> Even though this case is automatically handled by the above 
	        change (migrate_task being called on a running task, current, 
		will delegate migration to migration thread), would it be 
	 	good practice to avoid calling migrate_task in the first place
		itself when dest_cpu is offline. This means adding another
	 	cpu_is_offline check after e in sched_migrate_task

	3. The 'current' task can get preempted _immediately_ after
	   g and when it comes back, task_cpu(p) can be dead. In 
	   which case, it is invalid to do wake_up on a non-existent migration 
	   thread.  (rq->migration_thread can be NULL).

	   ===> We should disable preemption thr' g and h

	4. Before migration thread gets around to handle the request, its cpu 
	   goes dead. This will leave unhandled migration requests in the dead 
	   cpu. 

	   ===> We need to wakeup sleeping requestors (if any) in CPU_DEAD 
	        notification.

I really wonder if we can get rid of these issues by avoiding balancing at 
exec time and instead have it balanced during load_balance ..Alternately
if this is valuable and we want to retain it, I think we still need to 
consider a read/write sem, with sched_migrate_task doing down_read_trylock.
This may eliminate the deadlock I hit between cpu_up and CPU_UP_PREPARE 
notification, which had forced me away from r/w sem.

Anyway patch below addresses the above races. Its against 2.6.6-rc2-mm1
and has been tested on a 4way Intel Pentium SMP m/c. I have added a
cpu_is_offlince check in migration_thread(). If that is true, migration
thread stop processing and just waits for kthread_stop.

Let me know what you think!



---

 linux-2.6.6-rc2-mm1-root/kernel/sched.c |   40 ++++++++++++++++++++++++++++----
 1 files changed, 36 insertions(+), 4 deletions(-)

diff -puN kernel/sched.c~remove_hotplug_lock_in_sched_migrate_task kernel/sched.c
--- linux-2.6.6-rc2-mm1/kernel/sched.c~remove_hotplug_lock_in_sched_migrate_task	2004-04-20 20:42:03.000000000 +0530
+++ linux-2.6.6-rc2-mm1-root/kernel/sched.c	2004-04-20 22:22:16.527816944 +0530
@@ -1420,16 +1420,18 @@ static void sched_migrate_task(task_t *p
 	runqueue_t *rq;
 	unsigned long flags;
 
-	lock_cpu_hotplug();
 	rq = task_rq_lock(p, &flags);
-	if (!cpu_isset(dest_cpu, p->cpus_allowed))
+	if (!cpu_isset(dest_cpu, p->cpus_allowed) ||
+			unlikely(cpu_is_offline(dest_cpu)))
 		goto out;
 
 	/* force the process onto the specified CPU */
 	if (migrate_task(p, dest_cpu, &req)) {
 		/* Need to wait for migration thread. */
+		preempt_disable();
 		task_rq_unlock(rq, &flags);
 		wake_up_process(rq->migration_thread);
+		preempt_enable();
 		wait_for_completion(&req.done);
 
 		/*
@@ -1438,13 +1440,11 @@ static void sched_migrate_task(task_t *p
 		 * the migration.
 		 */
 		tlb_migrate_prepare(current->mm);
-		unlock_cpu_hotplug();
 
 		return;
 	}
 out:
 	task_rq_unlock(rq, &flags);
-	unlock_cpu_hotplug();
 }
 
 /*
@@ -3485,6 +3485,9 @@ static void __migrate_task(struct task_s
 {
 	runqueue_t *rq_dest;
 
+	if (unlikely(cpu_is_offline(dest_cpu)))
+		return;
+
 	rq_dest = cpu_rq(dest_cpu);
 
 	double_rq_lock(this_rq(), rq_dest);
@@ -3540,6 +3543,8 @@ static int migration_thread(void * data)
 		if (list_empty(head)) {
 			spin_unlock_irq(&rq->lock);
 			schedule();
+			if (unlikely(cpu_is_offline(cpu)))
+				goto wait_to_die;
 			continue;
 		}
 		req = list_entry(head->next, migration_req_t, list);
@@ -3560,6 +3565,15 @@ static int migration_thread(void * data)
 		complete(&req->done);
 	}
 	return 0;
+wait_to_die:
+	/* Wait for kthread_stop */
+	set_current_state(TASK_INTERRUPTIBLE);
+	while (!kthread_should_stop()) {
+		schedule();
+		set_current_state(TASK_INTERRUPTIBLE);
+	}
+	__set_current_state(TASK_RUNNING);
+	return 0;
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -3630,6 +3644,8 @@ static int migration_call(struct notifie
 	struct task_struct *p;
 	struct runqueue *rq;
 	unsigned long flags;
+	struct list_head *head;
+	migration_req_t *req, *tmp;
 
 	switch (action) {
 	case CPU_UP_PREPARE:
@@ -3652,6 +3668,22 @@ static int migration_call(struct notifie
 		/* Unbind it from offline cpu so it can run.  Fall thru. */
 		kthread_bind(cpu_rq(cpu)->migration_thread,smp_processor_id());
 	case CPU_DEAD:
+		rq = cpu_rq(cpu);
+		head = &rq->migration_queue;
+		spin_lock_irq(&rq->lock);
+		list_for_each_entry_safe(req, tmp, head, list) {
+
+			BUG_ON(req->type != REQ_MOVE_TASK);
+
+			list_del_init(&req->list);
+
+			/* No need to migrate the task in the request. It would
+	 		 * have already been migrated (maybe to a different
+			 * CPU). Just wake up the requestor.
+			 */
+			complete(&req->done);
+		}
+		spin_unlock_irq(&rq->lock);
 		kthread_stop(cpu_rq(cpu)->migration_thread);
 		cpu_rq(cpu)->migration_thread = NULL;
  		BUG_ON(cpu_rq(cpu)->nr_running != 0);

_



The above patch is running fine against 2.6.6-rc2-mm1 for the last 3 hrs.

The same patch when I had tried against 2.6.6-rc1-mm1 lead to 
this BUG in include/asm-i386/mmu_context.h after running for 1 hr.

	BUG_ON(cpu_tlbstate[cpu].active_mm != next);

Stack trace was:

------------[ cut here ]------------
kernel BUG at include/asm/mmu_context.h:53!
invalid operand: 0000 [#1]
PREEMPT SMP
CPU:    0
EIP:    0060:[<c03c94a2>]    Not tainted VLI
EFLAGS: 00010087   (2.6.6-rc1-mm1)
EIP is at schedule+0x482/0x62d
eax: 00000000   ebx: d34a0a00   ecx: 00000000   edx: f73f1a80
esi: d01b2b70   edi: c170bca0   ebp: ebcbbfb0   esp: ebcbbf5c
ds: 007b   es: 007b   ss: 0068
Process kstopmachine (pid: 19332, threadinfo=ebcba000 task=d34a0850)
Stack: d34a0850 c170bca0 00000001 ebcbbf8c f73f1a80 d01b2b70 00000003 00000000
       cad73ee8 ebcba000 cad73ee0 00000292 d01b2b70 00002fcb c04c53d9 0000037b
       d34a0850 d34a0a00 ebcba000 fffffff0 cad73ed8 c013bd3f c013bd7b 00000000
Call Trace:
 [<c013bd3f>] do_stop+0x0/0x6f
 [<c013bd7b>] do_stop+0x3c/0x6f
 [<c0133d39>] kthread+0xb7/0xbd
 [<c0133c82>] kthread+0x0/0xbd
 [<c01023a1>] kernel_thread_helper+0x5/0xb


Don't know if it is related to something that is fixed in 2.6.6-rc2-mm1.

Will update this list tomorrow with how my tests are faring on 2.6.6-rc2-mm1.


	

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
