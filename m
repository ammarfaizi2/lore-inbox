Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275813AbRI1DUe>; Thu, 27 Sep 2001 23:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275812AbRI1DU0>; Thu, 27 Sep 2001 23:20:26 -0400
Received: from [195.223.140.107] ([195.223.140.107]:56573 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S275813AbRI1DUF>;
	Thu, 27 Sep 2001 23:20:05 -0400
Date: Fri, 28 Sep 2001 05:20:07 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Ben LaHaise <bcrl@redhat.com>
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
Message-ID: <20010928052007.R14277@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0109261729570.5644-200000@localhost.localdomain> <20010928013106.W14277@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010928013106.W14277@athlon.random>; from andrea@suse.de on Fri, Sep 28, 2001 at 01:31:06AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 01:31:06AM +0200, Andrea Arcangeli wrote:
> On Wed, Sep 26, 2001 at 06:44:03PM +0200, Ingo Molnar wrote:
> 
> some comment after reading your softirq-2.4.10-A7.
> 
> >  - softirq handling can now be restarted N times within do_softirq(), if a
> >    softirq gets reactivated while it's being handled.
> 
> is this really necessary after introducing the unwakeup logic? What do
> you get if you allow at max 1 softirq pass as before?

I'm just curious, what are the numbers of your A7 patch compared with
this one?

diff -urN 2.4.10/include/asm-mips/softirq.h softirq/include/asm-mips/softirq.h
--- 2.4.10/include/asm-mips/softirq.h	Sun Sep 23 21:11:41 2001
+++ softirq/include/asm-mips/softirq.h	Fri Sep 28 05:18:45 2001
@@ -40,6 +40,4 @@
 
 #define in_softirq() (local_bh_count(smp_processor_id()) != 0)
 
-#define __cpu_raise_softirq(cpu, nr)	set_bit(nr, &softirq_pending(cpu))
-
 #endif /* _ASM_SOFTIRQ_H */
diff -urN 2.4.10/include/asm-mips64/softirq.h softirq/include/asm-mips64/softirq.h
--- 2.4.10/include/asm-mips64/softirq.h	Sun Sep 23 21:11:41 2001
+++ softirq/include/asm-mips64/softirq.h	Fri Sep 28 05:18:45 2001
@@ -39,19 +39,4 @@
 
 #define in_softirq() (local_bh_count(smp_processor_id()) != 0)
 
-extern inline void __cpu_raise_softirq(int cpu, int nr)
-{
-	unsigned int *m = (unsigned int *) &softirq_pending(cpu);
-	unsigned int temp;
-
-	__asm__ __volatile__(
-		"1:\tll\t%0, %1\t\t\t# __cpu_raise_softirq\n\t"
-		"or\t%0, %2\n\t"
-		"sc\t%0, %1\n\t"
-		"beqz\t%0, 1b"
-		: "=&r" (temp), "=m" (*m)
-		: "ir" (1UL << nr), "m" (*m)
-		: "memory");
-}
-
 #endif /* _ASM_SOFTIRQ_H */
diff -urN 2.4.10/include/linux/interrupt.h softirq/include/linux/interrupt.h
--- 2.4.10/include/linux/interrupt.h	Fri Sep 28 04:08:52 2001
+++ softirq/include/linux/interrupt.h	Fri Sep 28 05:18:45 2001
@@ -74,9 +74,14 @@
 asmlinkage void do_softirq(void);
 extern void open_softirq(int nr, void (*action)(struct softirq_action*), void *data);
 extern void softirq_init(void);
-#define __cpu_raise_softirq(cpu, nr) do { softirq_pending(cpu) |= 1UL << (nr); } while (0)
-extern void FASTCALL(cpu_raise_softirq(unsigned int cpu, unsigned int nr));
-extern void FASTCALL(raise_softirq(unsigned int nr));
+#define __cpu_raise_softirq(cpu, nr) \
+		do { softirq_pending(cpu) |= 1UL << (nr); } while (0)
+
+#define rerun_softirqs(cpu) 					\
+do {								\
+	if (!(local_irq_count(cpu) | local_bh_count(cpu)))	\
+		do_softirq();					\
+} while (0);
 
 
 
diff -urN 2.4.10/include/linux/netdevice.h softirq/include/linux/netdevice.h
--- 2.4.10/include/linux/netdevice.h	Fri Sep 28 04:09:37 2001
+++ softirq/include/linux/netdevice.h	Fri Sep 28 05:18:45 2001
@@ -486,8 +486,9 @@
 		local_irq_save(flags);
 		dev->next_sched = softnet_data[cpu].output_queue;
 		softnet_data[cpu].output_queue = dev;
-		cpu_raise_softirq(cpu, NET_TX_SOFTIRQ);
+		__cpu_raise_softirq(cpu, NET_TX_SOFTIRQ);
 		local_irq_restore(flags);
+		rerun_softirqs(cpu);
 	}
 }
 
@@ -535,8 +536,9 @@
 		local_irq_save(flags);
 		skb->next = softnet_data[cpu].completion_queue;
 		softnet_data[cpu].completion_queue = skb;
-		cpu_raise_softirq(cpu, NET_TX_SOFTIRQ);
+		__cpu_raise_softirq(cpu, NET_TX_SOFTIRQ);
 		local_irq_restore(flags);
+		rerun_softirqs(cpu);
 	}
 }
 
diff -urN 2.4.10/include/linux/sched.h softirq/include/linux/sched.h
--- 2.4.10/include/linux/sched.h	Sun Sep 23 21:11:42 2001
+++ softirq/include/linux/sched.h	Fri Sep 28 05:18:45 2001
@@ -556,6 +556,7 @@
 
 extern void FASTCALL(__wake_up(wait_queue_head_t *q, unsigned int mode, int nr));
 extern void FASTCALL(__wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr));
+extern void FASTCALL(__unwakeup_process(struct task_struct * p, long state));
 extern void FASTCALL(sleep_on(wait_queue_head_t *q));
 extern long FASTCALL(sleep_on_timeout(wait_queue_head_t *q,
 				      signed long timeout));
@@ -574,6 +575,13 @@
 #define wake_up_interruptible_all(x)	__wake_up((x),TASK_INTERRUPTIBLE, 0)
 #define wake_up_interruptible_sync(x)	__wake_up_sync((x),TASK_INTERRUPTIBLE, 1)
 #define wake_up_interruptible_sync_nr(x) __wake_up_sync((x),TASK_INTERRUPTIBLE,  nr)
+
+#define unwakeup_process(tsk,state)		\
+do {						\
+	if (task_on_runqueue(tsk))		\
+		__unwakeup_process(tsk,state);	\
+} while (0)
+
 asmlinkage long sys_wait4(pid_t pid,unsigned int * stat_addr, int options, struct rusage * ru);
 
 extern int in_group_p(gid_t);
diff -urN 2.4.10/kernel/ksyms.c softirq/kernel/ksyms.c
--- 2.4.10/kernel/ksyms.c	Sun Sep 23 21:11:43 2001
+++ softirq/kernel/ksyms.c	Fri Sep 28 05:18:45 2001
@@ -538,8 +538,6 @@
 EXPORT_SYMBOL(tasklet_kill);
 EXPORT_SYMBOL(__run_task_queue);
 EXPORT_SYMBOL(do_softirq);
-EXPORT_SYMBOL(raise_softirq);
-EXPORT_SYMBOL(cpu_raise_softirq);
 EXPORT_SYMBOL(__tasklet_schedule);
 EXPORT_SYMBOL(__tasklet_hi_schedule);
 
diff -urN 2.4.10/kernel/sched.c softirq/kernel/sched.c
--- 2.4.10/kernel/sched.c	Sun Sep 23 21:11:43 2001
+++ softirq/kernel/sched.c	Fri Sep 28 05:18:46 2001
@@ -366,6 +366,28 @@
 }
 
 /**
+ * unwakeup - undo wakeup if possible.
+ * @p: task
+ * @state: new task state
+ *
+ * Undo a previous wakeup of the specified task - if the process
+ * is not running already. The main interface to be used is
+ * unwakeup_process(), it will do a lockless test whether the task
+ * is on the runqueue.
+ */
+void __unwakeup_process(struct task_struct * p, long state)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&runqueue_lock, flags);
+	if (!p->has_cpu && (p != current) && task_on_runqueue(p)) {
+		del_from_runqueue(p);
+		p->state = state;
+	}
+	spin_unlock_irqrestore(&runqueue_lock, flags);
+}
+
+/**
  * schedule_timeout - sleep until timeout
  * @timeout: timeout value in jiffies
  *
diff -urN 2.4.10/kernel/softirq.c softirq/kernel/softirq.c
--- 2.4.10/kernel/softirq.c	Sun Sep 23 21:11:43 2001
+++ softirq/kernel/softirq.c	Fri Sep 28 05:18:47 2001
@@ -58,12 +58,23 @@
 		wake_up_process(tsk);
 }
 
+/*
+ * If a softirqs were fully handled after ksoftirqd was woken
+ * up then try to undo the wakeup.
+ */
+static inline void unwakeup_softirqd(unsigned cpu)
+{
+	struct task_struct * tsk = ksoftirqd_task(cpu);
+
+	if (tsk)
+		unwakeup_process(tsk, TASK_INTERRUPTIBLE);
+}
+
 asmlinkage void do_softirq()
 {
 	int cpu = smp_processor_id();
-	__u32 pending;
+	__u32 pending, mask;
 	long flags;
-	__u32 mask;
 
 	if (in_interrupt())
 		return;
@@ -102,48 +113,32 @@
 		__local_bh_enable();
 
 		if (pending)
+			/*
+			 * In the normal case ksoftirqd is rarely activated,
+			 * increased scheduling hurts performance.
+			 * It's a safety measure: if external load starts
+			 * to flood the system with softirqs then we
+			 * will mitigate softirq work to the softirq thread.
+			 */
 			wakeup_softirqd(cpu);
+		else
+			/*
+			 * All softirqs are handled - undo any possible
+			 * wakeup of softirqd. This reduces context switch
+			 * overhead.
+			 */
+			unwakeup_softirqd(cpu);
 	}
 
 	local_irq_restore(flags);
 }
 
-/*
- * This function must run with irq disabled!
- */
-inline void cpu_raise_softirq(unsigned int cpu, unsigned int nr)
-{
-	__cpu_raise_softirq(cpu, nr);
-
-	/*
-	 * If we're in an interrupt or bh, we're done
-	 * (this also catches bh-disabled code). We will
-	 * actually run the softirq once we return from
-	 * the irq or bh.
-	 *
-	 * Otherwise we wake up ksoftirqd to make sure we
-	 * schedule the softirq soon.
-	 */
-	if (!(local_irq_count(cpu) | local_bh_count(cpu)))
-		wakeup_softirqd(cpu);
-}
-
-void raise_softirq(unsigned int nr)
-{
-	long flags;
-
-	local_irq_save(flags);
-	cpu_raise_softirq(smp_processor_id(), nr);
-	local_irq_restore(flags);
-}
-
 void open_softirq(int nr, void (*action)(struct softirq_action*), void *data)
 {
 	softirq_vec[nr].data = data;
 	softirq_vec[nr].action = action;
 }
 
-
 /* Tasklets */
 
 struct tasklet_head tasklet_vec[NR_CPUS] __cacheline_aligned;
@@ -157,8 +152,9 @@
 	local_irq_save(flags);
 	t->next = tasklet_vec[cpu].list;
 	tasklet_vec[cpu].list = t;
-	cpu_raise_softirq(cpu, TASKLET_SOFTIRQ);
+	__cpu_raise_softirq(cpu, TASKLET_SOFTIRQ);
 	local_irq_restore(flags);
+	rerun_softirqs(cpu);
 }
 
 void __tasklet_hi_schedule(struct tasklet_struct *t)
@@ -169,8 +165,9 @@
 	local_irq_save(flags);
 	t->next = tasklet_hi_vec[cpu].list;
 	tasklet_hi_vec[cpu].list = t;
-	cpu_raise_softirq(cpu, HI_SOFTIRQ);
+	__cpu_raise_softirq(cpu, HI_SOFTIRQ);
 	local_irq_restore(flags);
+	rerun_softirqs(cpu);
 }
 
 static void tasklet_action(struct softirq_action *a)
@@ -241,7 +238,6 @@
 	}
 }
 
-
 void tasklet_init(struct tasklet_struct *t,
 		  void (*func)(unsigned long), unsigned long data)
 {
@@ -268,8 +264,6 @@
 	clear_bit(TASKLET_STATE_SCHED, &t->state);
 }
 
-
-
 /* Old style BHs */
 
 static void (*bh_base[32])(void);
@@ -325,7 +319,7 @@
 {
 	int i;
 
-	for (i=0; i<32; i++)
+	for (i = 0; i < 32; i++)
 		tasklet_init(bh_task_vec+i, bh_action, i);
 
 	open_softirq(TASKLET_SOFTIRQ, tasklet_action, NULL);
@@ -361,39 +355,45 @@
 
 static int ksoftirqd(void * __bind_cpu)
 {
-	int bind_cpu = *(int *) __bind_cpu;
-	int cpu = cpu_logical_map(bind_cpu);
+	int cpu = cpu_logical_map((int)__bind_cpu);
 
 	daemonize();
-	current->nice = 19;
+
 	sigfillset(&current->blocked);
 
 	/* Migrate to the right CPU */
 	current->cpus_allowed = 1UL << cpu;
-	while (smp_processor_id() != cpu)
-		schedule();
 
-	sprintf(current->comm, "ksoftirqd_CPU%d", bind_cpu);
+#if CONFIG_SMP
+	sprintf(current->comm, "ksoftirqd CPU%d", cpu);
+#else
+	sprintf(current->comm, "ksoftirqd");
+#endif
 
+	current->nice = 19;
+	schedule();
+	if (smp_processor_id() != cpu)
+		BUG();
 	__set_current_state(TASK_INTERRUPTIBLE);
 	mb();
-
 	ksoftirqd_task(cpu) = current;
 
 	for (;;) {
-		if (!softirq_pending(cpu))
-			schedule();
-
-		__set_current_state(TASK_RUNNING);
-
-		while (softirq_pending(cpu)) {
+		schedule();
+		do {
 			do_softirq();
 			if (current->need_resched)
-				schedule();
-		}
-
+				goto preempt;
+		back:
+			;
+		} while (softirq_pending(cpu));
 		__set_current_state(TASK_INTERRUPTIBLE);
 	}
+
+preempt:
+	__set_current_state(TASK_RUNNING);
+	schedule();
+	goto back;
 }
 
 static __init int spawn_ksoftirqd(void)
@@ -401,7 +401,7 @@
 	int cpu;
 
 	for (cpu = 0; cpu < smp_num_cpus; cpu++) {
-		if (kernel_thread(ksoftirqd, (void *) &cpu,
+		if (kernel_thread(ksoftirqd, (void *) cpu,
 				  CLONE_FS | CLONE_FILES | CLONE_SIGNAL) < 0)
 			printk("spawn_ksoftirqd() failed for cpu %d\n", cpu);
 		else {
diff -urN 2.4.10/net/core/dev.c softirq/net/core/dev.c
--- 2.4.10/net/core/dev.c	Sun Sep 23 21:11:43 2001
+++ softirq/net/core/dev.c	Fri Sep 28 05:18:46 2001
@@ -1218,8 +1218,9 @@
 			dev_hold(skb->dev);
 			__skb_queue_tail(&queue->input_pkt_queue,skb);
 			/* Runs from irqs or BH's, no need to wake BH */
-			cpu_raise_softirq(this_cpu, NET_RX_SOFTIRQ);
+			__cpu_raise_softirq(this_cpu, NET_RX_SOFTIRQ);
 			local_irq_restore(flags);
+			rerun_softirqs(this_cpu);
 #ifndef OFFLINE_SAMPLE
 			get_sample_stats(this_cpu);
 #endif
@@ -1529,8 +1530,9 @@
 	local_irq_disable();
 	netdev_rx_stat[this_cpu].time_squeeze++;
 	/* This already runs in BH context, no need to wake up BH's */
-	cpu_raise_softirq(this_cpu, NET_RX_SOFTIRQ);
+	__cpu_raise_softirq(this_cpu, NET_RX_SOFTIRQ);
 	local_irq_enable();
+	rerun_softirqs(this_cpu);
 
 	NET_PROFILE_LEAVE(softnet_process);
 	return;

Andrea
