Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWHRMAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWHRMAJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 08:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWHRMAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 08:00:09 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:24028
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S932408AbWHRMAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 08:00:07 -0400
Date: Fri, 18 Aug 2006 04:59:34 -0700
To: Robert Crocombe <rcrocomb@gmail.com>
Cc: Esben Nielsen <nielsen.esben@gogglemail.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [Patch] restore the RCU callback to defer put_task_struct() Re: Problems with 2.6.17-rt8
Message-ID: <20060818115934.GA29919@gnuppy.monkey.org>
References: <20060808030524.GA20530@gnuppy.monkey.org> <Pine.LNX.4.64.0608090050500.23474@frodo.shire> <20060810021835.GB12769@gnuppy.monkey.org> <20060811010646.GA24434@gnuppy.monkey.org> <e6babb600608110800g379ed2c3gd0dbed706d50622c@mail.gmail.com> <20060811211857.GA32185@gnuppy.monkey.org> <20060811221054.GA32459@gnuppy.monkey.org> <e6babb600608141056j4410380fr15348430738c91d8@mail.gmail.com> <20060814234423.GA31230@gnuppy.monkey.org> <e6babb600608151053u6b902b80k9e3b399fe34ee10f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <e6babb600608151053u6b902b80k9e3b399fe34ee10f@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 15, 2006 at 10:53:10AM -0700, Robert Crocombe wrote:
> NUMA emulation is off in the most recent one (the most recent config
> posted), and the high Hz is due to 'man nanosleep':
> 
> BUGS
>       The current implementation of nanosleep() is based on the normal 
>       kernel
>       timer  mechanism,  which  has  a  resolution  of  1/HZ s (see 
>       time(7)).
>       Therefore, nanosleep() pauses always for at least the  specified  
>       time,
>       however it can take up to 10 ms longer than specified until the 
>       process
>       becomes runnable again. For the same reason, the value returned in 
>       case
>       of  a  delivered  signal  in *rem is usually rounded to the next 
>       larger
>       multiple of 1/HZ s.
> 
> and Other People's Code (tm).
> 
> Sadly, I am behind a firewall and cannot offer remote access to the
> machine.  If you can point out some other config options that are Not
> Good, then I can see about pruning them.

Robert,

Sorry for the delay, been a bit distracted.

There's a lot of little problems in the stacks traces you sent and I wonder
how much it effects the rest of the system. Getting reliable debug output
has been a bit problematic.

Can you try this patch and see if it changes something ?

1) This fixes a flush_tlb_mm atomic violation by moving back to a spinlock

2) Moves the delay logic up higher in the tree from free_task() to __put_task_struct()

3) Adds a check to all calls to rt_lock() where it will panic() the kernel
   so that I can get a decent stack trace.

4) Minor fixes to the original deference code for INIT_TASK

5) use stop_trace just before doing any real panic().

This may not fix the journald code, but it should at least eliminate a
couple of stack traces that might be creating other effects in the system
and stop it dead in it's tracks. Hope this is useful.

Patch attached:

bill


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="t.diff"

# 
============================================================
--- arch/x86_64/kernel/smp.c	b354a6e4a080ad49f4213ab4334ca2e57ddf1bdc
+++ arch/x86_64/kernel/smp.c	a76a90aaad275ab3775d32ac3ae500fe120c5b8c
@@ -57,7 +57,7 @@
 		struct mm_struct *flush_mm;
 		unsigned long flush_va;
 #define FLUSH_ALL	-1ULL
-		spinlock_t tlbstate_lock;
+		raw_spinlock_t tlbstate_lock;
 	};
 	char pad[SMP_CACHE_BYTES];
 } ____cacheline_aligned;
============================================================
--- arch/x86_64/mm/numa.c	72976a7a4aff795f020f34e91e98e0defa280d3b
+++ arch/x86_64/mm/numa.c	4c2bb1ecc151dd04dbe28b6a4825f813efcab17d
@@ -12,6 +12,8 @@
 #include <linux/module.h>
 #include <linux/nodemask.h>
 
+#include <linux/dobject.h>
+
 #include <asm/e820.h>
 #include <asm/proto.h>
 #include <asm/dma.h>
@@ -317,6 +319,7 @@
 { 
 	int i;
 	unsigned long pages = 0;
+
 	for_each_online_node(i) {
 		pages += free_all_bootmem_node(NODE_DATA(i));
 	}
============================================================
--- include/linux/init_task.h	938a1587ab9e35bb8d24cf843d4e7424e3030a4c
+++ include/linux/init_task.h	b7acecacd94e4ee753c833bc8dd84623975927f9
@@ -126,7 +126,8 @@
 	.cpu_timers	= INIT_CPU_TIMERS(tsk.cpu_timers),		\
 	.fs_excl	= ATOMIC_INIT(0),				\
 	.posix_timer_list = NULL,					\
-	INIT_RT_MUTEXES(tsk)						\
+	INIT_RT_MUTEXES(tsk),						\
+	.delayed_drop	= LIST_HEAD_INIT(tsk.delayed_drop)		\
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
--- include/linux/seqlock.h	e0e6ee774c4c5dd9f3e0fd4d3ada566cda45d11b
+++ include/linux/seqlock.h	d0b08ef3758e5c0fa679d44a67582ca0b03878de
@@ -1,8 +1,8 @@
 #ifndef __LINUX_SEQLOCK_H
 #define __LINUX_SEQLOCK_H
 /*
  * Reader/writer consistent mechanism without starving writers. This type of
- * lock for data where the reader wants a consitent set of information
+ * lock for data where the reader wants a consistent set of information
  * and is willing to retry if the information changes.  Readers never
  * block but they may have to retry if a writer is in
  * progress. Writers do not wait for readers. 
============================================================
--- init/main.c	b9d35fb2830863866491a774c71f2516c02afe54
+++ init/main.c	8b432cd1d2f9b3f318a0b43783642b93f208012c
@@ -57,6 +57,8 @@
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
 
+#include <linux/dobject.h>
+
 #ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/smp.h>
 #endif
============================================================
--- kernel/exit.c	f4cc2f8e48a262bd26b6fc5d1253a8482c8c2d04
+++ kernel/exit.c	38720025341ef0a1c923a06ecf330fffb718c62c
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
 	int zap_leader;
@@ -177,7 +172,7 @@
 	spin_unlock(&p->proc_lock);
 	proc_pid_flush(proc_dentry);
 	release_thread(p);
-	call_rcu(&p->rcu, delayed_put_task_struct);
+	put_task_struct(p);
 
 	p = leader;
 	if (unlikely(zap_leader))
============================================================
--- kernel/fork.c	506dabd42d242f78e0321594c7723481e0cd87dc
+++ kernel/fork.c	100e4301ffaa9bb8afcb1dd00d02914b1f680ebe
@@ -47,6 +47,8 @@
 #include <linux/notifier.h>
 #include <linux/cn_proc.h>
 
+#include <linux/preempt.h> //--billh
+
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -75,7 +77,10 @@
  */
 static DEFINE_PER_CPU(struct task_struct *, desched_task);
 
-static DEFINE_PER_CPU(struct list_head, delayed_drop_list);
+static DEFINE_PER_CPU(struct list_head, delayed_mmdrop_list);
+#ifdef CONFIG_PREEMPT_RT
+static DEFINE_PER_CPU(struct list_head, delayed_put_task_struct_list); //--bilh
+#endif
 
 int nr_processes(void)
 {
@@ -120,7 +125,17 @@
 }
 EXPORT_SYMBOL(free_task);
 
+void fastcall free_task_delayed(struct task_struct *task);
+
+/*
+ * Delay if this is in an atomic critical section otherwise inline the deallocation
+ * --billh
+ */
+#ifdef CONFIG_PREEMPT_RT
+void __put_task_struct_inline(struct task_struct *tsk)
+#else
 void __put_task_struct(struct task_struct *tsk)
+#endif
 {
 	WARN_ON(!(tsk->exit_state & (EXIT_DEAD | EXIT_ZOMBIE)));
 	BUG_ON(atomic_read(&tsk->usage));
@@ -134,7 +149,7 @@
 	if (!profile_handoff_task(tsk))
 		free_task(tsk);
 }
-
+ 
 void __init fork_init(unsigned long mempages)
 {
 	int i;
@@ -167,8 +182,12 @@
 	init_task.signal->rlim[RLIMIT_SIGPENDING] =
 		init_task.signal->rlim[RLIMIT_NPROC];
 
-	for (i = 0; i < NR_CPUS; i++)
-		INIT_LIST_HEAD(&per_cpu(delayed_drop_list, i));
+	for (i = 0; i < NR_CPUS; i++) {
+		INIT_LIST_HEAD(&per_cpu(delayed_mmdrop_list, i));
+#ifdef CONFIG_PREEMPT_RT
+		INIT_LIST_HEAD(&per_cpu(delayed_put_task_struct_list, i)); //--billh
+#endif
+	}
 }
 
 static struct task_struct *dup_task_struct(struct task_struct *orig)
@@ -1067,6 +1086,9 @@
 #endif
 
 	rt_mutex_init_task(p);
+#ifdef CONFIG_PREEMPT_RT
+	INIT_LIST_HEAD(&p->delayed_drop); //--billh
+#endif
 
 #ifdef CONFIG_DEBUG_MUTEXES
 	p->blocked_on = NULL; /* not blocked yet */
@@ -1693,24 +1715,73 @@
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
+		__put_task_struct_inline(task); // call the original function to perform the operation
+		ret = 1;
+
+		head = &get_cpu_var(delayed_put_task_struct_list);
+	}
+	put_cpu_var(delayed_put_task_struct_list);
+
+	return ret;
+}
+
+/*
+ * We dont want to do complex work from the scheduler with preemption
+ * disabled, therefore we delay the work to a per-CPU worker thread.
+ */
+void fastcall __put_task_struct(struct task_struct *task)
+{
+	struct list_head *head;
+
+	head = &get_cpu_var(delayed_put_task_struct_list);
+	list_add_tail(&task->delayed_drop, head);
+
+	_wake_cpu_desched_task();
+
+	put_cpu_var(delayed_put_task_struct_list);
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
@@ -1721,15 +1792,14 @@
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
@@ -1743,6 +1813,9 @@
 
 		if (mmdrop_complete())
 			continue;
+		if (put_task_struct_complete())
+			continue;
+
 		schedule();
 
 		/* This must be called from time to time on ia64, and is a no-op on other archs.
@@ -1767,7 +1840,10 @@
 	case CPU_UP_PREPARE:
 
 		BUG_ON(per_cpu(desched_task, hotcpu));
-		INIT_LIST_HEAD(&per_cpu(delayed_drop_list, hotcpu));
+		INIT_LIST_HEAD(&per_cpu(delayed_mmdrop_list, hotcpu));
+#ifdef CONFIG_PREEMPT_RT
+		INIT_LIST_HEAD(&per_cpu(delayed_put_task_struct_list, hotcpu)); // --billh
+#endif
 		p = kthread_create(desched_thread, hcpu, "desched/%d", hotcpu);
 		if (IS_ERR(p)) {
 			printk("desched_thread for %i failed\n", hotcpu);
============================================================
--- kernel/rtmutex.c	d9e1288a369758ad7144999ef59019a51e17ce7a
+++ kernel/rtmutex.c	5c47b3b44b13667f0eb0424fe1653cbdfc8dac00
@@ -13,6 +13,9 @@
 #include <linux/sched.h>
 #include <linux/timer.h>
 
+#include <linux/hardirq.h> //-billh
+#include <linux/interrupt.h> //-billh
+
 #include "rtmutex_common.h"
 
 #ifdef CONFIG_DEBUG_RT_MUTEXES
@@ -740,7 +743,19 @@
 
 void __lockfunc rt_lock(struct rt_mutex *lock)
 {
+	if (
+	    (system_state == SYSTEM_RUNNING) &&
+	     in_atomic() &&
+	     !current->exit_state &&
+	     !oops_in_progress
+	     ) {
+		stop_trace();
+		panic("%s: in atomic: " "%s/0x%08x/%d\n",
+			__func__, current->comm, preempt_count(), current->pid);
+	}
+
 	rt_lock_fastlock(lock, rt_lock_slowlock);
+
 }
 EXPORT_SYMBOL(rt_lock);
 

--CE+1k2dSO48ffgeK--
