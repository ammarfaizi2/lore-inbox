Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUC3VCz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 16:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbUC3VCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 16:02:55 -0500
Received: from mx2.elte.hu ([157.181.151.9]:14022 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261206AbUC3VCs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 16:02:48 -0500
Date: Tue, 30 Mar 2004 23:03:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Erich Focht <efocht@hpce.nec.com>, nickpiggin@yahoo.com.au,
       mbligh@aracnet.com, ak@suse.de, jun.nakajima@intel.com,
       ricklind@us.ibm.com, linux-kernel@vger.kernel.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net
Subject: [patch] new-context balancing, 2.6.5-rc3-mm1
Message-ID: <20040330210312.GA6706@elte.hu>
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com> <200403300030.25734.efocht@hpce.nec.com> <4069384B.9070108@yahoo.com.au> <200403301204.14303.efocht@hpce.nec.com> <20040330030242.56221bcf.akpm@osdl.org> <20040330161438.GA2257@elte.hu> <20040330161910.GA2860@elte.hu> <20040330162514.GA2943@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20040330162514.GA2943@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


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
