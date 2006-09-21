Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWIUG4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWIUG4q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 02:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWIUG4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 02:56:46 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:34221
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1750747AbWIUG4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 02:56:45 -0400
Date: Wed, 20 Sep 2006 23:56:24 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: [PATCH] move put_task_struct() reaping into a thread [Re: 2.6.18-rt1]
Message-ID: <20060921065624.GA9841@gnuppy.monkey.org>
References: <20060920141907.GA30765@elte.hu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
In-Reply-To: <20060920141907.GA30765@elte.hu>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 20, 2006 at 04:19:07PM +0200, Ingo Molnar wrote:
> I'm pleased to announce the 2.6.18-rt1 tree, which can be downloaded 
> from the usual place:
... 
> as usual, bugreports, fixes and suggestions are welcome,

Speaking of which...

This patch moves put_task_struct() reaping into a thread instead of an
RCU callback function as discussed with Esben publically and Ingo privately:

bill


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mingo.patch.diff"


============================================================
--- include/linux/init_task.h	7998a1b8676588d10f9ca05c681b99fc3ee869d1
+++ include/linux/init_task.h	ca1562e79859bb022e6e9b140cc1edad1116fca9
@@ -77,6 +77,12 @@
 
 extern struct group_info init_groups;
 
+#ifdef CONFIG_PREEMPT_RT
+#define INIT_DELAYED_DROP(a)	.delayed_drop		= LIST_HEAD_INIT(a.delayed_drop),
+#else
+#define INIT_DELAYED_DROP()
+#endif
+
 /*
  *  INIT_TASK is used to set up the first task table, touch at
  * your own risk!. Base=0, limit=0x1fffff (=2MB)
@@ -128,6 +134,7 @@
 	.fs_excl	= ATOMIC_INIT(0),				\
 	.posix_timer_list = NULL,					\
 	.pi_lock	= RAW_SPIN_LOCK_UNLOCKED(tsk.pi_lock),		\
+	INIT_DELAYED_DROP(tsk)						\
 	INIT_TRACE_IRQFLAGS						\
 	INIT_LOCKDEP							\
 }
============================================================
--- include/linux/sched.h	afe9eb8f7f85de2d61a92d35807386aa9d79a52e
+++ include/linux/sched.h	e8907a986e9567267f290b504177faf6a96d4dbd
@@ -1176,6 +1176,9 @@
 #ifdef	CONFIG_TASK_DELAY_ACCT
 	struct task_delay_info *delays;
 #endif
+#ifdef	CONFIG_PREEMPT_RT
+	struct list_head        delayed_drop;
+#endif
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
@@ -1199,15 +1202,6 @@
 extern void free_task(struct task_struct *tsk);
 #define get_task_struct(tsk) do { atomic_inc(&(tsk)->usage); } while(0)
 
-#ifdef CONFIG_PREEMPT_RT
-extern void __put_task_struct_cb(struct rcu_head *rhp);
-
-static inline void put_task_struct(struct task_struct *t)
-{
-	if (atomic_dec_and_test(&t->usage))
-		call_rcu(&t->rcu, __put_task_struct_cb);
-}
-#else
 extern void __put_task_struct(struct task_struct *t);
 
 static inline void put_task_struct(struct task_struct *t)
@@ -1215,7 +1209,6 @@
 	if (atomic_dec_and_test(&t->usage))
 		__put_task_struct(t);
 }
-#endif
 
 /*
  * Per process flags
============================================================
--- kernel/exit.c	98f9cbf2db74c4cf03c792c75b63991856793263
+++ kernel/exit.c	5a6655dad5c3e72723c9b42adcecab12daf6b933
@@ -131,11 +131,6 @@
 	}
 }
 
-static void delayed_put_task_struct(struct rcu_head *rhp)
-{
-	put_task_struct(container_of(rhp, struct task_struct, rcu));
-}
-
 void release_task(struct task_struct * p)
 {
 	struct task_struct *leader;
@@ -172,7 +167,7 @@
 	write_unlock_irq(&tasklist_lock);
 	proc_flush_task(p);
 	release_thread(p);
-	call_rcu(&p->rcu, delayed_put_task_struct);
+	put_task_struct(p);
 
 	p = leader;
 	if (unlikely(zap_leader))
============================================================
--- kernel/fork.c	a26a13e186fd7a595fb24745cd6060c155cb4e10
+++ kernel/fork.c	5ea1f9118ab66e1668ab7f5e6549e184d1b05d74
@@ -75,7 +75,10 @@
  */
 static DEFINE_PER_CPU(struct task_struct *, desched_task);
 
-static DEFINE_PER_CPU(struct list_head, delayed_drop_list);
+static DEFINE_PER_CPU(struct list_head, delayed_mmdrop_list);
+#ifdef CONFIG_PREEMPT_RT
+static DEFINE_PER_CPU(struct list_head, delayed_put_task_struct_list);
+#endif
 
 int nr_processes(void)
 {
@@ -120,28 +123,33 @@
 }
 EXPORT_SYMBOL(free_task);
 
+
 #ifdef CONFIG_PREEMPT_RT
-void __put_task_struct_cb(struct rcu_head *rhp)
+/*
+ * We dont want to do complex work from the scheduler with preemption
+ * disabled, therefore we delay the work to a per-CPU worker thread.
+ */
+static void _wake_cpu_desched_task(void);
+
+void fastcall __put_task_struct(struct task_struct *task)
 {
-	struct task_struct *tsk = container_of(rhp, struct task_struct, rcu);
+	struct list_head *head;
 
-	BUG_ON(atomic_read(&tsk->usage));
-	WARN_ON(!(tsk->flags & PF_DEAD));
-	WARN_ON(!(tsk->exit_state & (EXIT_DEAD | EXIT_ZOMBIE)));
-	WARN_ON(tsk == current);
+	head = &get_cpu_var(delayed_put_task_struct_list);
+	list_add_tail(&task->delayed_drop, head);
 
-	security_task_free(tsk);
-	free_uid(tsk->user);
-	put_group_info(tsk->group_info);
-	delayacct_tsk_free(tsk);
+	_wake_cpu_desched_task();
 
-	if (!profile_handoff_task(tsk))
-		free_task(tsk);
+	put_cpu_var(delayed_put_task_struct_list);
 }
 
+/*
+ * Delay if this is in an atomic critical section otherwise inline the deallocation
+ */
+void __put_task_struct_inline(struct task_struct *tsk)
 #else
-
 void __put_task_struct(struct task_struct *tsk)
+#endif
 {
 	WARN_ON(!(tsk->exit_state & (EXIT_DEAD | EXIT_ZOMBIE)));
 	BUG_ON(atomic_read(&tsk->usage));
@@ -155,7 +163,6 @@
 	if (!profile_handoff_task(tsk))
 		free_task(tsk);
 }
-#endif
 
 void __init fork_init(unsigned long mempages)
 {
@@ -189,8 +196,12 @@
 	init_task.signal->rlim[RLIMIT_SIGPENDING] =
 		init_task.signal->rlim[RLIMIT_NPROC];
 
-	for (i = 0; i < NR_CPUS; i++)
-		INIT_LIST_HEAD(&per_cpu(delayed_drop_list, i));
+	for (i = 0; i < NR_CPUS; i++) {
+		INIT_LIST_HEAD(&per_cpu(delayed_mmdrop_list, i));
+#ifdef CONFIG_PREEMPT_RT
+		INIT_LIST_HEAD(&per_cpu(delayed_put_task_struct_list, i));
+#endif
+	}
 }
 
 static struct task_struct *dup_task_struct(struct task_struct *orig)
@@ -1123,6 +1134,9 @@
 #endif
 
 	rt_mutex_init_task(p);
+#ifdef CONFIG_PREEMPT_RT
+	INIT_LIST_HEAD(&p->delayed_drop);
+#endif
 
 #ifdef CONFIG_DEBUG_MUTEXES
 	p->blocked_on = NULL; /* not blocked yet */
@@ -1740,24 +1754,58 @@
 	return err;
 }
 
+static void _wake_cpu_desched_task(void)
+{
+	struct task_struct *desched_task;
+
+	desched_task = __get_cpu_var(desched_task);
+	if (desched_task)
+		wake_up_process(desched_task);
+}
+
+#ifdef CONFIG_PREEMPT_RT
+static int put_task_struct_complete(void)
+{
+	struct list_head *head;
+	int ret = 0;
+
+	head = &get_cpu_var(delayed_put_task_struct_list);
+	while (!list_empty(head)) {
+		struct task_struct *task = list_entry(head->next,
+					struct task_struct, delayed_drop);
+		list_del(&task->delayed_drop);
+		put_cpu_var(delayed_put_task_struct_list);
+
+		__put_task_struct_inline(task); /* call the original function to perform the operation */
+		ret = 1;
+
+		head = &get_cpu_var(delayed_put_task_struct_list);
+	}
+	put_cpu_var(delayed_put_task_struct_list);
+
+	return ret;
+}
+
+#endif
+
 static int mmdrop_complete(void)
 {
 	struct list_head *head;
 	int ret = 0;
 
-	head = &get_cpu_var(delayed_drop_list);
+	head = &get_cpu_var(delayed_mmdrop_list);
 	while (!list_empty(head)) {
 		struct mm_struct *mm = list_entry(head->next,
 					struct mm_struct, delayed_drop);
 		list_del(&mm->delayed_drop);
-		put_cpu_var(delayed_drop_list);
+		put_cpu_var(delayed_mmdrop_list);
 
 		__mmdrop(mm);
 		ret = 1;
 
-		head = &get_cpu_var(delayed_drop_list);
+		head = &get_cpu_var(delayed_mmdrop_list);
 	}
-	put_cpu_var(delayed_drop_list);
+	put_cpu_var(delayed_mmdrop_list);
 
 	return ret;
 }
@@ -1768,15 +1816,14 @@
  */
 void fastcall __mmdrop_delayed(struct mm_struct *mm)
 {
-	struct task_struct *desched_task;
 	struct list_head *head;
 
-	head = &get_cpu_var(delayed_drop_list);
+	head = &get_cpu_var(delayed_mmdrop_list);
 	list_add_tail(&mm->delayed_drop, head);
-	desched_task = __get_cpu_var(desched_task);
-	if (desched_task)
-		wake_up_process(desched_task);
-	put_cpu_var(delayed_drop_list);
+
+	_wake_cpu_desched_task();
+
+	put_cpu_var(delayed_mmdrop_list);
 }
 
 static int desched_thread(void * __bind_cpu)
@@ -1790,6 +1837,9 @@
 
 		if (mmdrop_complete())
 			continue;
+		if (put_task_struct_complete())
+			continue;
+
 		schedule();
 
 		/* This must be called from time to time on ia64, and is a no-op on other archs.
@@ -1814,7 +1864,10 @@
 	case CPU_UP_PREPARE:
 
 		BUG_ON(per_cpu(desched_task, hotcpu));
-		INIT_LIST_HEAD(&per_cpu(delayed_drop_list, hotcpu));
+		INIT_LIST_HEAD(&per_cpu(delayed_mmdrop_list, hotcpu));
+#ifdef CONFIG_PREEMPT_RT
+		INIT_LIST_HEAD(&per_cpu(delayed_put_task_struct_list, hotcpu));
+#endif
 		p = kthread_create(desched_thread, hcpu, "desched/%d", hotcpu);
 		if (IS_ERR(p)) {
 			printk("desched_thread for %i failed\n", hotcpu);



--Fba/0zbH8Xs+Fj9o--
