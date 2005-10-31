Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbVJaTyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbVJaTyZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 14:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbVJaTyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 14:54:25 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:5784 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964814AbVJaTyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 14:54:24 -0500
Date: Mon, 31 Oct 2005 20:54:25 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Hugh Dickins <hugh@veritas.com>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, linux-kernel@vger.kernel.org,
       tytso@us.ibm.com, sripathi@in.ibm.com, dipankar@in.ibm.com,
       oleg@tv-sign.ru
Subject: Re: [RFC,PATCH] RCUify single-thread case of clock_gettime()
Message-ID: <20051031195425.GA14806@elte.hu>
References: <20051031174416.GA2762@us.ibm.com> <Pine.LNX.4.61.0510311802550.9631@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0510311802550.9631@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Hugh Dickins <hugh@veritas.com> wrote:

> On Mon, 31 Oct 2005, Paul E. McKenney wrote:
> > 
> > The attached patch uses RCU to avoid the need to acquire tasklist_lock
> > in the single-thread case of clock_gettime().  Still acquires tasklist_lock
> > when asking for the time of a (potentially multithreaded) process.
> > 
> > Experimental, has been touch-tested on x86 and POWER.  Requires RCU on
> > task_struct.  Further more focused testing in progress.
> > 
> > Thoughts?  (Why?  Some off-list users want to be able to monitor CPU
> > consumption of specific threads.  They need to do so quite frequently,
> > so acquiring tasklist_lock is inappropriate.)
> 
> Not my area at all, but this looks really dodgy to me, Paul:
> could you explain it further?
> 
> First off, I don't see what's "RCU" about it at all.  Essentially, 
> you're replacing read_lock(&tasklist_lock) by preempt_disable(), but 
> calling it by the fancier rcu_read_lock() alias.  I thought there 
> would need to be some more infrastructure to make this RCU and safe?

the patch below (included in the -rt tree) is the prerequisite. That's 
what Paul's "requires RCU on task_struct" comment refers to.

the point of RCU here is SMP scalability from one side: 
preempt_disable() only has effect on the current CPU, while the 
tasklist_lock is a globally bouncing lock.

secondly, with the PREEMPT_RCU feature enabled (also included in the -rt 
tree), all rcu_read_lock() sections become fully preemptible.

	Ingo

----

RCU tasklist_lock and RCU signal handling: send signals RCU-read-locked 
instead of tasklist_lock read-locked. This is a scalability improvement 
on SMP and a preemption-latency improvement under PREEMPT_RCU.

Signed-off-by: Paul E. McKenney <paulmck@us.ibm.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h
+++ linux/include/linux/sched.h
@@ -34,6 +34,7 @@
 #include <linux/percpu.h>
 #include <linux/topology.h>
 #include <linux/seccomp.h>
+#include <linux/rcupdate.h>
 
 #include <linux/auxvec.h>	/* For AT_VECTOR_SIZE */
 
@@ -408,8 +409,16 @@ struct sighand_struct {
 	atomic_t		count;
 	struct k_sigaction	action[_NSIG];
 	spinlock_t		siglock;
+	struct rcu_head		rcu;
 };
 
+static inline void sighand_free(struct sighand_struct *sp)
+{
+	extern void sighand_free_cb(struct rcu_head *rhp);
+
+	call_rcu(&sp->rcu, sighand_free_cb);
+}
+
 /*
  * NOTE! "signal_struct" does not have it's own
  * locking, because a shared signal_struct always
@@ -913,6 +922,7 @@ struct task_struct {
 	int cpuset_mems_generation;
 #endif
 	atomic_t fs_excl;	/* holding fs exclusive resources */
+	struct rcu_head rcu;
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
@@ -936,8 +946,29 @@ static inline int pid_alive(struct task_
 extern void free_task(struct task_struct *tsk);
 extern void __put_task_struct(struct task_struct *tsk);
 #define get_task_struct(tsk) do { atomic_inc(&(tsk)->usage); } while(0)
-#define put_task_struct(tsk) \
-do { if (atomic_dec_and_test(&(tsk)->usage)) __put_task_struct(tsk); } while(0)
+
+static inline int get_task_struct_rcu(struct task_struct *t)
+{
+	int oldusage;
+
+	do {
+		oldusage = atomic_read(&t->usage);
+		if (oldusage == 0) {
+			return 0;
+		}
+	} while (cmpxchg(&t->usage.counter,
+		 oldusage, oldusage + 1) != oldusage);
+	return 1;
+}
+
+extern void __put_task_struct_cb(struct rcu_head *rhp);
+
+static inline void put_task_struct(struct task_struct *t)
+{
+	if (atomic_dec_and_test(&t->usage)) {
+		call_rcu(&t->rcu, __put_task_struct_cb);
+	}
+}
 
 /*
  * Per process flags
Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c
+++ linux/kernel/sched.c
@@ -176,6 +176,13 @@ static unsigned int task_timeslice(task_
 #define task_hot(p, now, sd) ((long long) ((now) - (p)->last_ran)	\
 				< (long long) (sd)->cache_hot_time)
 
+void __put_task_struct_cb(struct rcu_head *rhp)
+{
+	__put_task_struct(container_of(rhp, struct task_struct, rcu));
+}
+
+EXPORT_SYMBOL_GPL(__put_task_struct_cb);
+
 /*
  * These are the runqueue data structures:
  */
Index: linux/kernel/signal.c
===================================================================
--- linux.orig/kernel/signal.c
+++ linux/kernel/signal.c
@@ -330,13 +330,20 @@ void __exit_sighand(struct task_struct *
 	/* Ok, we're done with the signal handlers */
 	tsk->sighand = NULL;
 	if (atomic_dec_and_test(&sighand->count))
-		kmem_cache_free(sighand_cachep, sighand);
+		sighand_free(sighand);
 }
 
 void exit_sighand(struct task_struct *tsk)
 {
 	write_lock_irq(&tasklist_lock);
-	__exit_sighand(tsk);
+	rcu_read_lock();
+	if (tsk->sighand != NULL) {
+		struct sighand_struct *sighand = tsk->sighand;
+		spin_lock(&sighand->siglock);
+		__exit_sighand(tsk);
+		spin_unlock(&sighand->siglock);
+	}
+	rcu_read_unlock();
 	write_unlock_irq(&tasklist_lock);
 }
 
@@ -352,6 +359,7 @@ void __exit_signal(struct task_struct *t
 		BUG();
 	if (!atomic_read(&sig->count))
 		BUG();
+	rcu_read_lock();
 	spin_lock(&sighand->siglock);
 	posix_cpu_timers_exit(tsk);
 	if (atomic_dec_and_test(&sig->count)) {
@@ -359,6 +367,7 @@ void __exit_signal(struct task_struct *t
 		if (tsk == sig->curr_target)
 			sig->curr_target = next_thread(tsk);
 		tsk->signal = NULL;
+		__exit_sighand(tsk);
 		spin_unlock(&sighand->siglock);
 		flush_sigqueue(&sig->shared_pending);
 	} else {
@@ -390,9 +399,11 @@ void __exit_signal(struct task_struct *t
 		sig->nvcsw += tsk->nvcsw;
 		sig->nivcsw += tsk->nivcsw;
 		sig->sched_time += tsk->sched_time;
+		__exit_sighand(tsk);
 		spin_unlock(&sighand->siglock);
 		sig = NULL;	/* Marker for below.  */
 	}
+	rcu_read_unlock();
 	clear_tsk_thread_flag(tsk,TIF_SIGPENDING);
 	flush_sigqueue(&tsk->pending);
 	if (sig) {
@@ -1119,13 +1130,24 @@ void zap_other_threads(struct task_struc
 int group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
 {
 	unsigned long flags;
+	struct sighand_struct *sp;
 	int ret;
 
+retry:
 	ret = check_kill_permission(sig, info, p);
-	if (!ret && sig && p->sighand) {
-		spin_lock_irqsave(&p->sighand->siglock, flags);
+	if (!ret && sig && (sp = p->sighand)) {
+		if (!get_task_struct_rcu(p)) {
+			return -ESRCH;
+		}
+		spin_lock_irqsave(&sp->siglock, flags);
+		if (p->sighand != sp) {
+			spin_unlock_irqrestore(&sp->siglock, flags);
+			put_task_struct(p);
+			goto retry;
+		}
 		ret = __group_send_sig_info(sig, info, p);
-		spin_unlock_irqrestore(&p->sighand->siglock, flags);
+		spin_unlock_irqrestore(&sp->siglock, flags);
+		put_task_struct(p);
 	}
 
 	return ret;
@@ -1172,12 +1194,12 @@ kill_proc_info(int sig, struct siginfo *
 	int error;
 	struct task_struct *p;
 
-	read_lock(&tasklist_lock);
+	rcu_read_lock();
 	p = find_task_by_pid(pid);
 	error = -ESRCH;
 	if (p)
 		error = group_send_sig_info(sig, info, p);
-	read_unlock(&tasklist_lock);
+	rcu_read_unlock();
 	return error;
 }
 
@@ -1385,16 +1407,47 @@ send_sigqueue(int sig, struct sigqueue *
 {
 	unsigned long flags;
 	int ret = 0;
+	struct sighand_struct *sh = p->sighand;
 
 	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
-	read_lock(&tasklist_lock);
+
+	/*
+	 * The rcu based delayed sighand destroy makes it possible to
+	 * run this without tasklist lock held. The task struct itself
+	 * cannot go away as create_timer did get_task_struct().
+	 *
+	 * We return -1, when the task is marked exiting, so
+	 * posix_timer_event can redirect it to the group leader
+	 *
+	 */
+	rcu_read_lock();
 
 	if (unlikely(p->flags & PF_EXITING)) {
 		ret = -1;
 		goto out_err;
 	}
 
-	spin_lock_irqsave(&p->sighand->siglock, flags);
+	spin_lock_irqsave(&sh->siglock, flags);
+
+	/*
+	 * We do the check here again to handle the following scenario:
+	 *
+	 * CPU 0		CPU 1
+	 * send_sigqueue
+	 * check PF_EXITING
+	 * interrupt		exit code running
+	 *			__exit_signal
+	 *			lock sighand->siglock
+	 *			unlock sighand->siglock
+	 * lock sh->siglock
+	 * add(tsk->pending) 	flush_sigqueue(tsk->pending)
+	 *
+	 */
+
+	if (unlikely(p->flags & PF_EXITING)) {
+		ret = -1;
+		goto out;
+	}
 
 	if (unlikely(!list_empty(&q->list))) {
 		/*
@@ -1412,17 +1465,16 @@ send_sigqueue(int sig, struct sigqueue *
 		goto out;
 	}
 
-	q->lock = &p->sighand->siglock;
+	q->lock = &sh->siglock;
 	list_add_tail(&q->list, &p->pending.list);
 	sigaddset(&p->pending.signal, sig);
 	if (!sigismember(&p->blocked, sig))
 		signal_wake_up(p, sig == SIGKILL);
 
 out:
-	spin_unlock_irqrestore(&p->sighand->siglock, flags);
+	spin_unlock_irqrestore(&sh->siglock, flags);
 out_err:
-	read_unlock(&tasklist_lock);
-
+	rcu_read_unlock();
 	return ret;
 }
 
@@ -1433,7 +1485,16 @@ send_group_sigqueue(int sig, struct sigq
 	int ret = 0;
 
 	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
-	read_lock(&tasklist_lock);
+
+	while(!read_trylock(&tasklist_lock)) {
+		if (!p->sighand)
+			return -1;
+		cpu_relax();
+	}
+	if (unlikely(!p->sighand)) {
+		ret = -1;
+		goto out_err;
+	}
 	spin_lock_irqsave(&p->sighand->siglock, flags);
 	handle_stop_signal(sig, p);
 
@@ -1467,8 +1528,9 @@ send_group_sigqueue(int sig, struct sigq
 	__group_complete_signal(sig, p);
 out:
 	spin_unlock_irqrestore(&p->sighand->siglock, flags);
+out_err:
 	read_unlock(&tasklist_lock);
-	return(ret);
+	return ret;
 }
 
 /*
Index: linux/fs/exec.c
===================================================================
--- linux.orig/fs/exec.c
+++ linux/fs/exec.c
@@ -779,7 +779,7 @@ no_thread_group:
 		write_unlock_irq(&tasklist_lock);
 
 		if (atomic_dec_and_test(&oldsighand->count))
-			kmem_cache_free(sighand_cachep, oldsighand);
+			sighand_free(oldsighand);
 	}
 
 	BUG_ON(!thread_group_leader(current));
Index: linux/kernel/exit.c
===================================================================
--- linux.orig/kernel/exit.c
+++ linux/kernel/exit.c
@@ -71,7 +71,6 @@ repeat: 
 		__ptrace_unlink(p);
 	BUG_ON(!list_empty(&p->ptrace_list) || !list_empty(&p->ptrace_children));
 	__exit_signal(p);
-	__exit_sighand(p);
 	/*
 	 * Note that the fastpath in sys_times depends on __exit_signal having
 	 * updated the counters before a task is removed from the tasklist of
Index: linux/kernel/fork.c
===================================================================
--- linux.orig/kernel/fork.c
+++ linux/kernel/fork.c
@@ -754,6 +754,14 @@ int unshare_files(void)
 
 EXPORT_SYMBOL(unshare_files);
 
+void sighand_free_cb(struct rcu_head *rhp)
+{
+	struct sighand_struct *sp =
+		container_of(rhp, struct sighand_struct, rcu);
+
+	kmem_cache_free(sighand_cachep, sp);
+}
+
 static inline int copy_sighand(unsigned long clone_flags, struct task_struct * tsk)
 {
 	struct sighand_struct *sig;
Index: linux/kernel/rcupdate.c
===================================================================
--- linux.orig/kernel/rcupdate.c
+++ linux/kernel/rcupdate.c
@@ -35,6 +35,7 @@
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/smp.h>
+#include <linux/rcupdate.h>
 #include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <asm/atomic.h>
Index: linux/include/linux/list.h
===================================================================
--- linux.orig/include/linux/list.h
+++ linux/include/linux/list.h
@@ -208,6 +208,7 @@ static inline void list_replace_rcu(stru
 	smp_wmb();
 	new->next->prev = new;
 	new->prev->next = new;
+	old->prev = LIST_POISON2;
 }
 
 /**
@@ -578,6 +579,25 @@ static inline void hlist_del_init(struct
 	}
 }
 
+/*
+ * hlist_replace_rcu - replace old entry by new one
+ * @old : the element to be replaced
+ * @new : the new element to insert
+ *
+ * The old entry will be replaced with the new entry atomically.
+ */
+static inline void hlist_replace_rcu(struct hlist_node *old, struct hlist_node *new){
+	struct hlist_node *next = old->next;
+
+	new->next = next;
+	new->pprev = old->pprev;
+	smp_wmb();
+	if (next)
+		new->next->pprev = &new->next;
+	*new->pprev = new;
+	old->pprev = LIST_POISON2;
+}
+
 static inline void hlist_add_head(struct hlist_node *n, struct hlist_head *h)
 {
 	struct hlist_node *first = h->first;
Index: linux/kernel/pid.c
===================================================================
--- linux.orig/kernel/pid.c
+++ linux/kernel/pid.c
@@ -136,7 +136,7 @@ struct pid * fastcall find_pid(enum pid_
 	struct hlist_node *elem;
 	struct pid *pid;
 
-	hlist_for_each_entry(pid, elem,
+	hlist_for_each_entry_rcu(pid, elem,
 			&pid_hash[type][pid_hashfn(nr)], pid_chain) {
 		if (pid->nr == nr)
 			return pid;
@@ -151,12 +151,12 @@ int fastcall attach_pid(task_t *task, en
 	task_pid = &task->pids[type];
 	pid = find_pid(type, nr);
 	if (pid == NULL) {
-		hlist_add_head(&task_pid->pid_chain,
-				&pid_hash[type][pid_hashfn(nr)]);
 		INIT_LIST_HEAD(&task_pid->pid_list);
+		hlist_add_head_rcu(&task_pid->pid_chain,
+				   &pid_hash[type][pid_hashfn(nr)]);
 	} else {
 		INIT_HLIST_NODE(&task_pid->pid_chain);
-		list_add_tail(&task_pid->pid_list, &pid->pid_list);
+		list_add_tail_rcu(&task_pid->pid_list, &pid->pid_list);
 	}
 	task_pid->nr = nr;
 
@@ -170,20 +170,20 @@ static fastcall int __detach_pid(task_t 
 
 	pid = &task->pids[type];
 	if (!hlist_unhashed(&pid->pid_chain)) {
-		hlist_del(&pid->pid_chain);
 
-		if (list_empty(&pid->pid_list))
+		if (list_empty(&pid->pid_list)) {
 			nr = pid->nr;
-		else {
+			hlist_del_rcu(&pid->pid_chain);
+		} else {
 			pid_next = list_entry(pid->pid_list.next,
 						struct pid, pid_list);
 			/* insert next pid from pid_list to hash */
-			hlist_add_head(&pid_next->pid_chain,
-				&pid_hash[type][pid_hashfn(pid_next->nr)]);
+			hlist_replace_rcu(&pid->pid_chain,
+					  &pid_next->pid_chain);
 		}
 	}
 
-	list_del(&pid->pid_list);
+	list_del_rcu(&pid->pid_list);
 	pid->nr = 0;
 
 	return nr;
