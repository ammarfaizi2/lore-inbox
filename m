Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263670AbUDTS6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263670AbUDTS6j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 14:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263725AbUDTS6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 14:58:38 -0400
Received: from zero.aec.at ([193.170.194.10]:41227 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263670AbUDTS63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 14:58:29 -0400
To: Darren Hart <dvhltc@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: sched_domains and Stream benchmark
References: <1N7xQ-7fh-29@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Tue, 20 Apr 2004 20:58:24 +0200
In-Reply-To: <1N7xQ-7fh-29@gated-at.bofh.it> (Darren Hart's message of "Tue,
 20 Apr 2004 19:50:14 +0200")
Message-ID: <m3r7uitr1r.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darren Hart <dvhltc@us.ibm.com> writes:

> Andi,
>
> You have mentioned the stream benchmark when reporting on the
> performance of the Opteron NUMA sched-domains scheduler.  I am trying to
> reproduce your results and am struggling with the benchmark.  Can you
> rpovide the details of the tests you ran.  Namely your compiler
> settings, compile command line, and your value of N.  Also I didn't see
> how to specify the number of threads to run, how did you specify that? 
> I have a 4 way 1.4 GHz 1MB cache opteron machine with 7 GB of RAM.

I didn't actually compile them myself; someone sent me executables
compiled with the PGI compiler.  Maybe your compiler has a different
runtime and behaves differently? 

You can find them and my test script that tests everything in 
ftp://ftp.suse.com/pub/people/ak/bench/stream.tar.gz


> When I ran the steeam_omp benchmark with N=4000000 I got nearly
> identical results (within statistical noise) from 2.6.5, 2.6.5-mm5, and
> 2.6.5-mm5-with_flat_domains (the patch I sent earlier).  Clearly not
> what is expected, so I assume I am not running or building the benchmark
> correctly.  I found the projects build system (none) and docs (minimal)
> to be lacking.
>
> You mentioned your problem was fixed by some of "Ingo's tweaks".  Which
> patches are these tweaks in and are they in the mm tree yet?

Didn't think so, no. They were posted by Ingo Molnar to linux-kernel,
check the archives. They did just enable aggressive balancing
at fork/clone time.

I attached the patch i tested. 

-Andi



--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


i've attached sched-balance-context.patch, which is the current version
of fork()/clone() balancing, against 2.6.5-rc3-mm1.

Changes:

 - only balance CLONE_VM threads

 - take ->cpus_allowed into account when balancing.

i've checked kernel recompiles and while they didnt hurt from fork()
balancing on an 8-way SMP box, i implemented the thread-only balancing
nevertheless.

	Ingo

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sched-balance-context.patch"

--- linux/include/linux/sched.h.orig	
+++ linux/include/linux/sched.h	
@@ -715,12 +715,17 @@ extern void do_timer(struct pt_regs *);
 
 extern int FASTCALL(wake_up_state(struct task_struct * tsk, unsigned int state));
 extern int FASTCALL(wake_up_process(struct task_struct * tsk));
+extern void FASTCALL(wake_up_forked_process(struct task_struct * tsk));
 #ifdef CONFIG_SMP
  extern void kick_process(struct task_struct *tsk);
+ extern void FASTCALL(wake_up_forked_thread(struct task_struct * tsk));
 #else
  static inline void kick_process(struct task_struct *tsk) { }
+ static inline void wake_up_forked_thread(struct task_struct * tsk)
+ {
+	return wake_up_forked_process(tsk);
+ }
 #endif
-extern void FASTCALL(wake_up_forked_process(struct task_struct * tsk));
 extern void FASTCALL(sched_fork(task_t * p));
 extern void FASTCALL(sched_exit(task_t * p));
 
--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -1139,6 +1137,119 @@ enum idle_type
 };
 
 #ifdef CONFIG_SMP
+
+/*
+ * find_idlest_cpu - find the least busy runqueue.
+ */
+static int find_idlest_cpu(int this_cpu, runqueue_t *this_rq, cpumask_t mask)
+{
+	unsigned long load, min_load, this_load;
+	int i, min_cpu;
+	cpumask_t tmp;
+
+	min_cpu = UINT_MAX;
+	min_load = ULONG_MAX;
+
+	cpus_and(tmp, mask, cpu_online_map);
+	for_each_cpu_mask(i, tmp) {
+		load = cpu_load(i);
+
+		if (load < min_load) {
+			min_cpu = i;
+			min_load = load;
+
+			/* break out early on an idle CPU: */
+			if (!min_load)
+				break;
+		}
+	}
+
+	/* add +1 to account for the new task */
+	this_load = cpu_load(this_cpu) + SCHED_LOAD_SCALE;
+
+	/*
+	 * Would with the addition of the new task to the
+	 * current CPU there be an imbalance between this
+	 * CPU and the idlest CPU?
+	 */
+	if (min_load*this_rq->sd->imbalance_pct < 100*this_load)
+		return min_cpu;
+
+	return this_cpu;
+}
+
+/*
+ * wake_up_forked_thread - wake up a freshly forked thread.
+ *
+ * This function will do some initial scheduler statistics housekeeping
+ * that must be done for every newly created context, and it also does
+ * runqueue balancing.
+ */
+void fastcall wake_up_forked_thread(task_t * p)
+{
+	unsigned long flags;
+	int this_cpu = get_cpu(), cpu;
+	runqueue_t *this_rq = cpu_rq(this_cpu), *rq;
+
+	/*
+	 * Migrate the new context to the least busy CPU,
+	 * if that CPU is out of balance.
+	 */
+	cpu = find_idlest_cpu(this_cpu, this_rq, p->cpus_allowed);
+
+	local_irq_save(flags);
+lock_again:
+	rq = cpu_rq(cpu);
+	double_rq_lock(this_rq, rq);
+
+	BUG_ON(p->state != TASK_RUNNING);
+
+	/*
+	 * We did find_idlest_cpu() unlocked, so in theory
+	 * the mask could have changed:
+	 */
+	if (!cpu_isset(cpu, p->cpus_allowed)) {
+		cpu = any_online_cpu(p->cpus_allowed);
+		double_rq_unlock(this_rq, rq);
+		goto lock_again;
+	}
+	/*
+	 * We decrease the sleep average of forking parents
+	 * and children as well, to keep max-interactive tasks
+	 * from forking tasks that are max-interactive.
+	 */
+	current->sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(current) *
+		PARENT_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
+
+	p->sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(p) *
+		CHILD_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
+
+	p->interactive_credit = 0;
+
+	p->prio = effective_prio(p);
+	set_task_cpu(p, cpu);
+
+	if (cpu == this_cpu) {
+		if (unlikely(!current->array))
+			__activate_task(p, rq);
+		else {
+			p->prio = current->prio;
+			list_add_tail(&p->run_list, &current->run_list);
+			p->array = current->array;
+			p->array->nr_active++;
+			rq->nr_running++;
+		}
+	} else {
+		__activate_task(p, rq);
+		if (TASK_PREEMPTS_CURR(p, rq))
+			resched_task(rq->curr);
+	}
+
+	double_rq_unlock(this_rq, rq);
+	local_irq_restore(flags);
+	put_cpu();
+}
+
 /*
  * If dest_cpu is allowed for this process, migrate the task to it.
  * This is accomplished by forcing the cpu_allowed mask to only
--- linux/kernel/fork.c.orig	
+++ linux/kernel/fork.c	
@@ -1179,9 +1179,23 @@ long do_fork(unsigned long clone_flags,
 			set_tsk_thread_flag(p, TIF_SIGPENDING);
 		}
 
-		if (!(clone_flags & CLONE_STOPPED))
-			wake_up_forked_process(p);	/* do this last */
-		else
+		if (!(clone_flags & CLONE_STOPPED)) {
+			/*
+			 * Do the wakeup last. On SMP we treat fork() and
+			 * CLONE_VM separately, because fork() has already
+			 * created cache footprint on this CPU (due to
+			 * copying the pagetables), hence migration would
+			 * probably be costy. Threads on the other hand
+			 * have less traction to the current CPU, and if
+			 * there's an imbalance then the scheduler can
+			 * migrate this fresh thread now, before it
+			 * accumulates a larger cache footprint:
+			 */
+			if (clone_flags & CLONE_VM)
+				wake_up_forked_thread(p);
+			else
+				wake_up_forked_process(p);
+		} else
 			p->state = TASK_STOPPED;
 		++total_forks;
 

--u3/rZRmxL6MmkK24--

