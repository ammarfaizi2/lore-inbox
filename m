Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315431AbSE2TOX>; Wed, 29 May 2002 15:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315438AbSE2TOW>; Wed, 29 May 2002 15:14:22 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:1320 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315431AbSE2TOP>; Wed, 29 May 2002 15:14:15 -0400
Date: Wed, 29 May 2002 21:13:36 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Robert Love <rml@mvista.com>
Cc: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] updated O(1) scheduler for 2.4
Message-ID: <20020529191336.GK31701@dualathlon.random>
In-Reply-To: <1021939600.967.5.camel@sinai> <20020524160223.GA1761@werewolf.able.es> <1022641021.23427.329.camel@sinai> <20020529151552.GJ31701@dualathlon.random> <1022695394.985.13.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2002 at 11:03:14AM -0700, Robert Love wrote:
> On Wed, 2002-05-29 at 08:15, Andrea Arcangeli wrote:
> 
> > I merged it and I've almost finished moving everything on top of it but
> > I've a few issues.
> > 
> > can you elaborate why you __save_flags in do_fork? do_fork is even a
> > blocking operation. fork_by_hand runs as well with irq enabled.
> > I don't like to safe flags in a fast path if it's not required.
> 
> s/you/Ingo/ ;)
> 
> We save flags for two reasons: First, we touch task->time_slice which is
> touched from an interrupt handler (timer/idle/scheduler_tick) and second
> because we may call scheduler_tick which must be called with interrupts
> off.  Note we restore them just a few lines later...
> 
> Or, hm, are you asking why not just cli/sti?  I don't know the answer to

of course, I'm asking why not cli/sti, see my current status of
incrmental fixes on top of the o1 scheduler, some old in -aa, some from
-ac (I dropped an optimization from you, I assume it's ok but quite
frankly I don't care about the performance of setting the cpu affinity
and I preferred to stay safe in sync with -ac and 2.5), some new noticed
while mering (and still uncertain about the questions). also the
force_cpu_reschedule from the 2.5 rcu-poll was buggy and that's fixed
too now in my tree.

beware I cannot test anything yet, the tree still doesn't compile, it seems
the last thing to make uml link is to update the init_task, then I will
also need to do the same for x86-64 at least, and possibly other archs
if Robert didn't took care of them. after x86-64 and uml works I will
check sparc64 alpha and finally x86 smp + up.

diff -urNp o1-sched-ref/include/linux/wait.h o1-sched/include/linux/wait.h
--- o1-sched-ref/include/linux/wait.h	Wed May 29 19:58:06 2002
+++ o1-sched/include/linux/wait.h	Wed May 29 20:17:12 2002
@@ -59,6 +59,7 @@ typedef struct __wait_queue wait_queue_t
 # define wq_write_lock_irq write_lock_irq
 # define wq_write_lock_irqsave write_lock_irqsave
 # define wq_write_unlock_irqrestore write_unlock_irqrestore
+# define wq_write_unlock_irq write_unlock_irq
 # define wq_write_unlock write_unlock
 #else
 # define wq_lock_t spinlock_t
@@ -71,6 +72,7 @@ typedef struct __wait_queue wait_queue_t
 # define wq_write_lock_irq spin_lock_irq
 # define wq_write_lock_irqsave spin_lock_irqsave
 # define wq_write_unlock_irqrestore spin_unlock_irqrestore
+# define wq_write_unlock_irq spin_unlock_irq
 # define wq_write_unlock spin_unlock
 #endif
 
diff -urNp o1-sched-ref/kernel/sched.c o1-sched/kernel/sched.c
--- o1-sched-ref/kernel/sched.c	Wed May 29 20:16:59 2002
+++ o1-sched/kernel/sched.c	Wed May 29 20:17:07 2002
@@ -850,15 +850,15 @@ void complete(struct completion *x)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&x->wait.lock, flags);
+	wq_write_lock_irqsave(&x->wait.lock, flags);
 	x->done++;
 	__wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1);
-	spin_unlock_irqrestore(&x->wait.lock, flags);
+	wq_write_unlock_irqrestore(&x->wait.lock, flags);
 }
 
 void wait_for_completion(struct completion *x)
 {
-	spin_lock_irq(&x->wait.lock);
+	wq_write_lock_irq(&x->wait.lock);
 	if (!x->done) {
 		DECLARE_WAITQUEUE(wait, current);
 
@@ -866,14 +866,14 @@ void wait_for_completion(struct completi
 		__add_wait_queue_tail(&x->wait, &wait);
 		do {
 			__set_current_state(TASK_UNINTERRUPTIBLE);
-			spin_unlock_irq(&x->wait.lock);
+			wq_write_unlock_irq(&x->wait.lock);
 			schedule();
-			spin_lock_irq(&x->wait.lock);
+			wq_write_lock_irq(&x->wait.lock);
 		} while (!x->done);
 		__remove_wait_queue(&x->wait, &wait);
 	}
 	x->done--;
-	spin_unlock_irq(&x->wait.lock);
+	wq_write_unlock_irq(&x->wait.lock);
 }
 
 #define	SLEEP_ON_VAR				\
@@ -1499,8 +1499,8 @@ typedef struct {
  * is removed from the allowed bitmask.
  *
  * NOTE: the caller must have a valid reference to the task, the
- * task must not exit() & deallocate itself prematurely.  The
- * call is not atomic; no spinlocks may be held.
+ * task must not exit() & deallocate itself prematurely.  No
+ * spinlocks can be held.
  */
 void set_cpus_allowed(task_t *p, unsigned long new_mask)
 {
@@ -1523,16 +1523,6 @@ void set_cpus_allowed(task_t *p, unsigne
 		return;
 	}
 
-	/*
-	 * If the task is not on a runqueue, then it is safe to
-	 * simply update the task's cpu field.
-	 */
-	if (!p->array) {
-		p->cpu = __ffs(p->cpus_allowed);
-		task_rq_unlock(rq, &flags);
-		return;
-	}
-
 	init_MUTEX_LOCKED(&req.sem);
 	req.task = p;
 	list_add(&req.list, &rq->migration_queue);


--- ./kernel/sched.c.~1~	Wed May 29 04:50:30 2002
+++ ./kernel/sched.c	Wed May 29 05:22:04 2002
@@ -569,7 +569,7 @@ skip_queue:
 #define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
 	((jiffies - (p)->sleep_timestamp > cache_decay_ticks) &&	\
 		((p) != (rq)->curr) &&					\
-			((p)->cpus_allowed & (1 << (this_cpu))))
+			((p)->cpus_allowed & (1UL << (this_cpu))))
 
 	if (!CAN_MIGRATE_TASK(tmp, busiest, this_cpu)) {
 		curr = curr->next;



--- sched2/kernel/sched.c.~1~	Wed May 29 17:24:52 2002
+++ sched2/kernel/sched.c	Wed May 29 17:34:22 2002
@@ -248,7 +248,6 @@ static inline void resched_task(task_t *
 	int need_resched;
 
 	need_resched = p->need_resched;
-	wmb();
 	set_tsk_need_resched(p);
 	if (!need_resched && (p->cpu != smp_processor_id()))
 		smp_send_reschedule(p->cpu);
@@ -794,7 +793,7 @@ switch_tasks:
 		 * if the new task was last running on a different
 		 * CPU - thus re-load it.
 		 */
-		mb();
+		smp_mb();
 		rq = this_rq();
 		spin_unlock_irq(&rq->frozen);
 	} else {
--- sched2/kernel/fork.c.~1~	Wed May 29 17:24:52 2002
+++ sched2/kernel/fork.c	Wed May 29 17:34:39 2002
@@ -712,7 +712,6 @@ int do_fork(unsigned long clone_flags, u
 	 * total amount of pending timeslices in the system doesnt change,
 	 * resulting in more scheduling fairness.
 	 */
-	__save_flags(flags);
 	__cli();
 	if (!current->time_slice)
 		BUG();
@@ -728,7 +727,7 @@ int do_fork(unsigned long clone_flags, u
 		scheduler_tick(0,0);
 	}
 	p->sleep_timestamp = jiffies;
-	__restore_flags(flags);
+	__sti();
 
 	/*
 	 * Ok, add it to the run-queues and make it


diff -urNp o1-sched-ref/include/linux/sched.h o1-sched/include/linux/sched.h
--- o1-sched-ref/include/linux/sched.h	Wed May 29 17:36:11 2002
+++ o1-sched/include/linux/sched.h	Wed May 29 17:36:32 2002
@@ -371,6 +371,7 @@ struct task_struct {
 	unsigned long policy;
 	unsigned long cpus_allowed;
 	unsigned int time_slice;
+	int get_child_timeslice;
 
 	task_t *next_task, *prev_task;
 
diff -urNp o1-sched-ref/kernel/exit.c o1-sched/kernel/exit.c
--- o1-sched-ref/kernel/exit.c	Wed May 29 17:36:10 2002
+++ o1-sched/kernel/exit.c	Wed May 29 17:36:32 2002
@@ -231,6 +231,7 @@ static inline void forget_original_paren
 			else
 				p->p_opptr = reaper;
 
+			p->get_child_timeslice = 0;
 			if (p->pdeath_signal) send_sig(p->pdeath_signal, p, 0);
 		}
 	}
diff -urNp o1-sched-ref/kernel/fork.c o1-sched/kernel/fork.c
--- o1-sched-ref/kernel/fork.c	Wed May 29 17:36:21 2002
+++ o1-sched/kernel/fork.c	Wed May 29 17:36:49 2002
@@ -729,6 +729,8 @@ int do_fork(unsigned long clone_flags, u
 	}
 	p->sleep_timestamp = jiffies;
 	__sti();
+	/* Tell the parent if it can get back its timeslice when child exits */
+	p->get_child_timeslice = 1;
 
 	/*
 	 * Ok, add it to the run-queues and make it
diff -urNp o1-sched-ref/kernel/sched.c o1-sched/kernel/sched.c
--- o1-sched-ref/kernel/sched.c	Wed May 29 17:36:21 2002
+++ o1-sched/kernel/sched.c	Wed May 29 17:36:32 2002
@@ -360,9 +360,11 @@ void wake_up_forked_process(task_t * p)
 void sched_exit(task_t * p)
 {
 	__cli();
-	current->time_slice += p->time_slice;
-	if (unlikely(current->time_slice > MAX_TIMESLICE))
-		current->time_slice = MAX_TIMESLICE;
+	if (p->get_child_timeslice) {
+		current->time_slice += p->time_slice;
+		if (unlikely(current->time_slice > MAX_TIMESLICE))
+			current->time_slice = MAX_TIMESLICE;
+	}
 	__sti();
 	/*
 	 * If the child was a (relative-) CPU hog then decrease
@@ -673,6 +675,7 @@ void scheduler_tick(int user_tick, int s
 		 */
 		if ((p->policy == SCHED_RR) && !--p->time_slice) {
 			p->time_slice = TASK_TIMESLICE(p);
+			p->get_child_timeslice = 0;
 			set_tsk_need_resched(p);
 
 			/* put it at the end of the queue: */
@@ -696,6 +699,7 @@ void scheduler_tick(int user_tick, int s
 		set_tsk_need_resched(p);
 		p->prio = effective_prio(p);
 		p->time_slice = TASK_TIMESLICE(p);
+		p->get_child_timeslice = 0;
 
 		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
 			if (!rq->expired_timestamp)


diff -urNp o1-sched/include/linux/sched.h o1-sched-child-first/include/linux/sched.h
--- o1-sched/include/linux/sched.h	Wed May 29 17:36:32 2002
+++ o1-sched-child-first/include/linux/sched.h	Wed May 29 17:40:12 2002
@@ -509,6 +509,7 @@ extern void set_user_nice(task_t *p, lon
 extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);
 
+extern void __sched_yield(void);
 asmlinkage long sys_sched_yield(void);
 #define yield()	sys_sched_yield()
 
diff -urNp o1-sched/kernel/fork.c o1-sched-child-first/kernel/fork.c
--- o1-sched/kernel/fork.c	Wed May 29 17:42:11 2002
+++ o1-sched-child-first/kernel/fork.c	Wed May 29 17:40:47 2002
@@ -770,12 +770,14 @@ int do_fork(unsigned long clone_flags, u
 	++total_forks;
 	if (clone_flags & CLONE_VFORK)
 		wait_for_completion(&vfork);
-	else
+	else {
 		/*
 		 * Let the child process run first, to avoid most of the
 		 * COW overhead when the child exec()s afterwards.
 		 */
+		__sched_yield();
 		current->need_resched = 1;
+	}
 
 fork_out:
 	return retval;
diff -urNp o1-sched/kernel/sched.c o1-sched-child-first/kernel/sched.c
--- o1-sched/kernel/sched.c	Wed May 29 17:36:32 2002
+++ o1-sched-child-first/kernel/sched.c	Wed May 29 17:39:57 2002
@@ -1182,7 +1182,7 @@ out_unlock:
 	return retval;
 }
 
-asmlinkage long sys_sched_yield(void)
+void __sched_yield(void)
 {
 	runqueue_t *rq;
 	prio_array_t *array;
@@ -1215,6 +1215,11 @@ asmlinkage long sys_sched_yield(void)
 		__set_bit(current->prio, array->bitmap);
 	}
 	spin_unlock(&rq->lock);
+}
+
+asmlinkage long sys_sched_yield(void)
+{
+	__sched_yield();
 
 	schedule();
 

> that... I would think we always enter do_fork with interrupts enabled,
> but maybe Ingo thought otherwise.
> 
> > Then there are longstanding bugs that aren't yet fixed and I ported the
> > fixed on top of it (see the parent-timeslice patch in -aa).
> > 
> > the child-run first approch in o1 is suspect, it seems the parent will
> > keep running just after a wasteful reschedule, a sched yield instead
> > should be invoked like in -aa in the share-timeslice patch in order to
> > roll the current->run_list before the schedule is invoked while
> > returning to userspace after fork.
> 
> I do not see this...

see the above serie of patches, again it may be broken, still untested yet.

> > another suspect thing I noticed is the wmb() in resched_task. Can you
> > elaborate on what is it trying to serialize (I hope not the read of
> > p->need_resched with the stuff below)? Also if something it should be a
> > smp_wmb(), same smp_ prefix goes for the other mb() in schedule.
> 
> I suspect you may be right here.  I believe the wmb() is to serialize
> the reading of need_resched vs the writing of need_resched below it vs
> whatever may happen to need_resched elsewhere.

I actually removed it enterely, need_resched will be fore sure read
before overwriting it because it's guaranteed by reading and writing to
the same mem address.

still I wonder if the other cpu will see the need_resched set when it
goes to read it, I can imagine a needed wmb() on the writer cpu and an rmb() in
the reader, hopefully it serializes via the spinlocks, I didn't touch
this area, but if the wmb() was meant to be after need_resced = 1, that
had to be one line below, so still it would be a bug, the wmb() in such
place looks superflous so I dropped it until somebody comments.

> 
> But resched_task is the only bit from 2.5 I have not fully back
> ported...take a look at resched_task in 2.5: I need to bring that to
> 2.4.  I suspect idle polling is broken in 2.4, too.

your version looks ok at first glance.

Andrea
