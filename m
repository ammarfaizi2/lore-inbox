Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWHKBG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWHKBG4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 21:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWHKBG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 21:06:56 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:64972
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S932078AbWHKBGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 21:06:55 -0400
Date: Thu, 10 Aug 2006 18:06:46 -0700
To: Esben Nielsen <nielsen.esben@gogglemail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Robert Crocombe <rcrocomb@gmail.com>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [Patch] restore the RCU callback to defer put_task_struct() Re: Problems with 2.6.17-rt8
Message-ID: <20060811010646.GA24434@gnuppy.monkey.org>
References: <e6babb600608012231r74470b77x6e7eaeab222ee160@mail.gmail.com> <e6babb600608012237g60d9dfd7ga11b97512240fb7b@mail.gmail.com> <1154541079.25723.8.camel@localhost.localdomain> <e6babb600608030448y7bb0cd34i74f5f632e4caf1b1@mail.gmail.com> <1154615261.32264.6.camel@localhost.localdomain> <20060808025615.GA20364@gnuppy.monkey.org> <20060808030524.GA20530@gnuppy.monkey.org> <Pine.LNX.4.64.0608090050500.23474@frodo.shire> <20060810021835.GB12769@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <20060810021835.GB12769@gnuppy.monkey.org>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 09, 2006 at 07:18:35PM -0700, Bill Huey wrote:
> On Thu, Aug 10, 2006 at 12:05:57AM +0200, Esben Nielsen wrote:
> > I had a long discussion with Paul McKenney about this. I opposed the patch 
> > from a latency point of view: Suddenly a high-priority RT task could be 
> > made into releasing a task_struct. It would be better for latencies to 
> > defer it to a low priority task.
> > 
> > The conclusion we ended up with was that it is not a job for the RCU 
> > system, but it ought to be deferred to some other low priority task to 
> > free the task_struct.
> 
> I agree. It's just hack to get it not to crash at this time. It really
> should be done in another facility or utilizing another threading context.

Esben and company,

This is the second round of getting rid of the locking problems with free_task()

This extends the mmdrop logic with desched_thread() to also handle free_task()
requests as well. I believe this address your concerns and I'm open to review
of this patch.

Patch included:

bill


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="t2.diff"

--- include/linux/init_task.h	938a1587ab9e35bb8d24cf843d4e7424e3030a4c
+++ include/linux/init_task.h	f9469678db8c3609c2f07ddb885ec4f6afa7812c
@@ -126,7 +126,8 @@
 	.cpu_timers	= INIT_CPU_TIMERS(tsk.cpu_timers),		\
 	.fs_excl	= ATOMIC_INIT(0),				\
 	.posix_timer_list = NULL,					\
-	INIT_RT_MUTEXES(tsk)						\
+	INIT_RT_MUTEXES(tsk),						\
+	.delayed_drop	= LIST_HEAD_INIT(tsk.children)			\
 }
 
 
============================================================
--- include/linux/sched.h	0ed8993484be9c13728f4ebdaa51fc0f0c229018
+++ include/linux/sched.h	c65ebaa452498f611280baafd8ee6282ea0746f2
@@ -1082,6 +1091,9 @@
 	 * cache last used pipe for splice
 	 */
 	struct pipe_inode_info *splice_pipe;
+
+	/* --billh */
+	struct list_head	delayed_drop; // should investigate how do_fork() handles this as well
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
============================================================
--- kernel/exit.c	f4cc2f8e48a262bd26b6fc5d1253a8482c8c2d04
+++ kernel/exit.c	9af3ab7b1d0174e3b8fa7aacec97c8e85c559e68
@@ -177,7 +177,7 @@
 	spin_unlock(&p->proc_lock);
 	proc_pid_flush(proc_dentry);
 	release_thread(p);
-	call_rcu(&p->rcu, delayed_put_task_struct);
+	put_task_struct(p);
 
 	p = leader;
 	if (unlikely(zap_leader))
============================================================
--- kernel/fork.c	506dabd42d242f78e0321594c7723481e0cd87dc
+++ kernel/fork.c	ee8452887ab91be38ffd366bb57be2cf46b2f08b
@@ -75,7 +75,10 @@
  */
 static DEFINE_PER_CPU(struct task_struct *, desched_task);
 
-static DEFINE_PER_CPU(struct list_head, delayed_drop_list);
+static DEFINE_PER_CPU(struct list_head, delayed_mmdrop_list);
+#ifdef CONFIG_PREEMPT_RT
+static DEFINE_PER_CPU(struct list_head, delayed_free_task_list); //--bilh
+#endif
 
 int nr_processes(void)
 {
@@ -120,6 +123,8 @@
 }
 EXPORT_SYMBOL(free_task);
 
+void fastcall free_task_delayed(struct task_struct *task);
+
 void __put_task_struct(struct task_struct *tsk)
 {
 	WARN_ON(!(tsk->exit_state & (EXIT_DEAD | EXIT_ZOMBIE)));
@@ -132,9 +137,13 @@
 	put_group_info(tsk->group_info);
 
 	if (!profile_handoff_task(tsk))
-		free_task(tsk);
+#ifdef CONFIG_PREEMPT_RT
+		free_task_delayed(tsk);
+#else
+		free_task(tsk); // --billh
+#endif
 }
-
+ 
 void __init fork_init(unsigned long mempages)
 {
 	int i;
@@ -167,8 +176,12 @@
 	init_task.signal->rlim[RLIMIT_SIGPENDING] =
 		init_task.signal->rlim[RLIMIT_NPROC];
 
-	for (i = 0; i < NR_CPUS; i++)
-		INIT_LIST_HEAD(&per_cpu(delayed_drop_list, i));
+	for (i = 0; i < NR_CPUS; i++) {
+		INIT_LIST_HEAD(&per_cpu(delayed_mmdrop_list, i));
+#ifdef CONFIG_PREEMPT_RT
+		INIT_LIST_HEAD(&per_cpu(delayed_free_task_list, i)); //--billh
+#endif
+	}
 }
 
 static struct task_struct *dup_task_struct(struct task_struct *orig)
@@ -1067,6 +1080,9 @@
 #endif
 
 	rt_mutex_init_task(p);
+#ifdef CONFIG_PREEMPT_RT
+	INIT_LIST_HEAD(&p->delayed_drop); //--billh
+#endif
 
 #ifdef CONFIG_DEBUG_MUTEXES
 	p->blocked_on = NULL; /* not blocked yet */
@@ -1693,24 +1709,73 @@
 	return err;
 }
 
+static void wake_cpu_desched_task(void)
+{
+	struct task_struct *desched_task;
+
+	desched_task = __get_cpu_var(desched_task);
+	if (desched_task)
+		wake_up_process(desched_task);
+}
+
+#ifdef CONFIG_PREEMPT_RT
+static int free_task_complete(void)
+{
+	struct list_head *head;
+	int ret = 0;
+
+	head = &get_cpu_var(delayed_free_task_list);
+	while (!list_empty(head)) {
+		struct task_struct *task = list_entry(head->next,
+					struct task_struct, delayed_drop);
+		list_del(&task->delayed_drop);
+		put_cpu_var(delayed_free_task_list);
+
+		free_task(task);
+		ret = 1;
+
+		head = &get_cpu_var(delayed_free_task_list);
+	}
+	put_cpu_var(delayed_free_task_list);
+
+	return ret;
+}
+
+/*
+ * We dont want to do complex work from the scheduler, thus
+ * we delay the work to a per-CPU worker thread:
+ */
+void fastcall free_task_delayed(struct task_struct *task)
+{
+	struct list_head *head;
+
+	head = &get_cpu_var(delayed_free_task_list);
+	list_add_tail(&task->delayed_drop, head);
+
+	wake_cpu_desched_task();
+
+	put_cpu_var(delayed_mmdrop_list);
+}
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
@@ -1721,15 +1786,14 @@
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
+	wake_cpu_desched_task();
+
+	put_cpu_var(delayed_mmdrop_list);
 }
 
 static int desched_thread(void * __bind_cpu)
@@ -1743,6 +1807,9 @@
 
 		if (mmdrop_complete())
 			continue;
+		if (free_task_complete())
+			continue;
+
 		schedule();
 
 		/* This must be called from time to time on ia64, and is a no-op on other archs.
@@ -1767,7 +1834,10 @@
 	case CPU_UP_PREPARE:
 
 		BUG_ON(per_cpu(desched_task, hotcpu));
-		INIT_LIST_HEAD(&per_cpu(delayed_drop_list, hotcpu));
+		INIT_LIST_HEAD(&per_cpu(delayed_mmdrop_list, hotcpu));
+#ifdef CONFIG_PREEMPT_RT
+		INIT_LIST_HEAD(&per_cpu(delayed_free_task_list, hotcpu)); // --billh
+#endif
 		p = kthread_create(desched_thread, hcpu, "desched/%d", hotcpu);
 		if (IS_ERR(p)) {
 			printk("desched_thread for %i failed\n", hotcpu);

--EeQfGwPcQSOJBaQU--
