Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270739AbRHNSvX>; Tue, 14 Aug 2001 14:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270704AbRHNSvP>; Tue, 14 Aug 2001 14:51:15 -0400
Received: from mailf.telia.com ([194.22.194.25]:64982 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S270705AbRHNSu4> convert rfc822-to-8bit;
	Tue, 14 Aug 2001 14:50:56 -0400
Subject: Hardlock with all kernel >= 2.4.7-pre5 - softirq related ?
From: Thomas Svedberg <thsv@bigfoot.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 14 Aug 2001 17:29:54 +0200
Message-Id: <997803113.1423.22.camel@athlon1.hemma.se>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have experienced hardlocks (everything freezes with small white square
box with pointer in upper left corner on screen and only SysRq-b seems
to work) without any oops or anything.

I have after some trial and error narrowed it down to the following part
of the interdiff between 2.4.7-pre4 and 2.4.7-pre5:
(For config, lspci -vvv, program versions and boot logs see
http://thsv.dnsalias.org/~thsv/lock/config
http://thsv.dnsalias.org/~thsv/lock/lspci-vvv
http://thsv.dnsalias.org/~thsv/lock/versions
http://thsv.dnsalias.org/~thsv/lock/messages
http://thsv.dnsalias.org/~thsv/lock/boot.log )

--- linux/kernel/ksyms.c
+++ linux/kernel/ksyms.c
@@ -540,0 +541,2 @@
+EXPORT_SYMBOL(raise_softirq);
+EXPORT_SYMBOL(cpu_raise_softirq);
--- v2.4.6/linux/kernel/softirq.c	Tue Jul  3 17:08:22 2001
+++ linux/kernel/softirq.c	Mon Jul  9 16:32:45 2001
@@ -47,21 +47,38 @@
 
 static struct softirq_action softirq_vec[32] __cacheline_aligned;
 
+/*
+ * we cannot loop indefinitely here to avoid userspace starvation,
+ * but we also don't want to introduce a worst case 1/HZ latency
+ * to the pending events, so lets the scheduler to balance
+ * the softirq load for us.
+ */
+static inline void wakeup_softirqd(unsigned cpu)
+{
+	struct task_struct * tsk = ksoftirqd_task(cpu);
+
+	if (tsk && tsk->state != TASK_RUNNING)
+		wake_up_process(tsk);
+}
+
 asmlinkage void do_softirq()
 {
 	int cpu = smp_processor_id();
 	__u32 pending;
+	long flags;
+	__u32 mask;
 
 	if (in_interrupt())
 		return;
 
-	local_irq_disable();
+	local_irq_save(flags);
 
 	pending = softirq_pending(cpu);
 
 	if (pending) {
 		struct softirq_action *h;
 
+		mask = ~pending;
 		local_bh_disable();
 restart:
 		/* Reset the pending bitmask before enabling irqs */
@@ -81,14 +98,40 @@
 		local_irq_disable();
 
 		pending = softirq_pending(cpu);
-		if (pending)
+		if (pending & mask) {
+			mask &= ~pending;
 			goto restart;
+		}
 		__local_bh_enable();
+
+		if (pending)
+			wakeup_softirqd(cpu);
 	}
 
-	local_irq_enable();
+	local_irq_restore(flags);
 }
 
+inline void cpu_raise_softirq(unsigned int cpu, unsigned int nr)
+{
+	__cpu_raise_softirq(cpu, nr);
+
+	/*
+	 * If we're in an interrupt or bh, we're done
+	 * (this also catches bh-disabled code). We will
+	 * actually run the softirq once we return from
+	 * the irq or bh.
+	 *
+	 * Otherwise we wake up ksoftirqd to make sure we
+	 * schedule the softirq soon.
+	 */
+	if (!(local_irq_count(cpu) | local_bh_count(cpu)))
+		wakeup_softirqd(cpu);
+}
+
+void raise_softirq(unsigned int nr)
+{
+	cpu_raise_softirq(smp_processor_id(), nr);
+}
 
 void open_softirq(int nr, void (*action)(struct softirq_action*), void *data)
 {
@@ -112,11 +155,10 @@
 	 * If nobody is running it then add it to this CPU's
 	 * tasklet queue.
 	 */
-	if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state) &&
-						tasklet_trylock(t)) {
+	if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
 		t->next = tasklet_vec[cpu].list;
 		tasklet_vec[cpu].list = t;
-		__cpu_raise_softirq(cpu, TASKLET_SOFTIRQ);
+		cpu_raise_softirq(cpu, TASKLET_SOFTIRQ);
 		tasklet_unlock(t);
 	}
 	local_irq_restore(flags);
@@ -130,11 +172,10 @@
 	cpu = smp_processor_id();
 	local_irq_save(flags);
 
-	if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state) &&
-						tasklet_trylock(t)) {
+	if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
 		t->next = tasklet_hi_vec[cpu].list;
 		tasklet_hi_vec[cpu].list = t;
-		__cpu_raise_softirq(cpu, HI_SOFTIRQ);
+		cpu_raise_softirq(cpu, HI_SOFTIRQ);
 		tasklet_unlock(t);
 	}
 	local_irq_restore(flags);
@@ -148,37 +189,30 @@
 	local_irq_disable();
 	list = tasklet_vec[cpu].list;
 	tasklet_vec[cpu].list = NULL;
+	local_irq_enable();
 
 	while (list) {
 		struct tasklet_struct *t = list;
 
 		list = list->next;
 
-		/*
-		 * A tasklet is only added to the queue while it's
-		 * locked, so no other CPU can have this tasklet
-		 * pending:
-		 */
 		if (!tasklet_trylock(t))
 			BUG();
-repeat:
-		if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
-			BUG();
 		if (!atomic_read(&t->count)) {
-			local_irq_enable();
+			if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
+				BUG();
 			t->func(t->data);
-			local_irq_disable();
-			/*
-			 * One more run if the tasklet got reactivated:
-			 */
-			if (test_bit(TASKLET_STATE_SCHED, &t->state))
-				goto repeat;
+			tasklet_unlock(t);
+			continue;
 		}
 		tasklet_unlock(t);
-		if (test_bit(TASKLET_STATE_SCHED, &t->state))
-			tasklet_schedule(t);
+
+		local_irq_disable();
+		t->next = tasklet_vec[cpu].list;
+		tasklet_vec[cpu].list = t;
+		cpu_raise_softirq(cpu, TASKLET_SOFTIRQ);
+		local_irq_enable();
 	}
-	local_irq_enable();
 }
 

@@ -193,6 +227,7 @@
 	local_irq_disable();
 	list = tasklet_hi_vec[cpu].list;
 	tasklet_hi_vec[cpu].list = NULL;
+	local_irq_enable();
 
 	while (list) {
 		struct tasklet_struct *t = list;
@@ -201,21 +236,21 @@
 
 		if (!tasklet_trylock(t))
 			BUG();
-repeat:
-		if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
-			BUG();
 		if (!atomic_read(&t->count)) {
-			local_irq_enable();
+			if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
+				BUG();
 			t->func(t->data);
-			local_irq_disable();
-			if (test_bit(TASKLET_STATE_SCHED, &t->state))
-				goto repeat;
+			tasklet_unlock(t);
+			continue;
 		}
 		tasklet_unlock(t);
-		if (test_bit(TASKLET_STATE_SCHED, &t->state))
-			tasklet_hi_schedule(t);
+
+		local_irq_disable();
+		t->next = tasklet_hi_vec[cpu].list;
+		tasklet_hi_vec[cpu].list = t;
+		cpu_raise_softirq(cpu, HI_SOFTIRQ);
+		local_irq_enable();
 	}
-	local_irq_enable();
 }
 

@@ -335,3 +370,61 @@
 			f(data);
 	}
 }
+
+static int ksoftirqd(void * __bind_cpu)
+{
+	int bind_cpu = *(int *) __bind_cpu;
+	int cpu = cpu_logical_map(bind_cpu);
+
+	daemonize();
+	current->nice = 19;
+	sigfillset(&current->blocked);
+
+	/* Migrate to the right CPU */
+	current->cpus_allowed = 1UL << cpu;
+	while (smp_processor_id() != cpu)
+		schedule();
+
+	sprintf(current->comm, "ksoftirqd_CPU%d", bind_cpu);
+
+	__set_current_state(TASK_INTERRUPTIBLE);
+	mb();
+
+	ksoftirqd_task(cpu) = current;
+
+	for (;;) {
+		if (!softirq_pending(cpu))
+			schedule();
+
+		__set_current_state(TASK_RUNNING);
+
+		while (softirq_pending(cpu)) {
+			do_softirq();
+			if (current->need_resched)
+				schedule();
+		}
+
+		__set_current_state(TASK_INTERRUPTIBLE);
+	}
+}
+
+static __init int spawn_ksoftirqd(void)
+{
+	int cpu;
+
+	for (cpu = 0; cpu < smp_num_cpus; cpu++) {
+		if (kernel_thread(ksoftirqd, (void *) &cpu,
+				  CLONE_FS | CLONE_FILES | CLONE_SIGNAL) < 0)
+			printk("spawn_ksoftirqd() failed for cpu %d\n", cpu);
+		else {
+			while (!ksoftirqd_task(cpu_logical_map(cpu))) {
+				current->policy |= SCHED_YIELD;
+				schedule();
+			}
+		}
+	}
+
+	return 0;
+}
+
+__initcall(spawn_ksoftirqd);
--- v2.4.6/linux/kernel/sched.c	Tue Jul  3 17:08:22 2001
+++ linux/kernel/sched.c	Mon Jul  9 17:51:59 2001
@@ -543,11 +543,6 @@
 
 	release_kernel_lock(prev, this_cpu);
 
-	/* Do "administrative" work here while we don't hold any locks */
-	if (softirq_pending(this_cpu))
-		goto handle_softirq;
-handle_softirq_back:
-
 	/*
 	 * 'sched_data' is protected by the fact that we can run
 	 * only one process per CPU.
@@ -689,13 +684,11 @@
 	goto repeat_schedule;
 
 still_running:
+	if (!(prev->cpus_allowed & (1UL << this_cpu)))
+		goto still_running_back;
 	c = goodness(prev, this_cpu, prev->active_mm);
 	next = prev;
 	goto still_running_back;
-
-handle_softirq:
-	do_softirq();
-	goto handle_softirq_back;
 
 move_rr_last:
 	if (!prev->counter) {
--- v2.4.6/linux/include/linux/netdevice.h	Fri May 25 18:02:01 2001
+++ linux/include/linux/netdevice.h	Mon Jul  9 18:34:08 2001
@@ -487,7 +487,7 @@
 		local_irq_save(flags);
 		dev->next_sched = softnet_data[cpu].output_queue;
 		softnet_data[cpu].output_queue = dev;
-		__cpu_raise_softirq(cpu, NET_TX_SOFTIRQ);
+		cpu_raise_softirq(cpu, NET_TX_SOFTIRQ);
 		local_irq_restore(flags);
 	}
 }
@@ -536,7 +536,7 @@
 		local_irq_save(flags);
 		skb->next = softnet_data[cpu].completion_queue;
 		softnet_data[cpu].completion_queue = skb;
-		__cpu_raise_softirq(cpu, NET_TX_SOFTIRQ);
+		cpu_raise_softirq(cpu, NET_TX_SOFTIRQ);
 		local_irq_restore(flags);
 	}
 }
--- v2.4.6/linux/include/linux/irq_cpustat.h	Tue Jul  3 17:08:21 2001
+++ linux/include/linux/irq_cpustat.h	Mon Jul  9 18:33:25 2001
@@ -30,6 +30,7 @@
 #define local_irq_count(cpu)	__IRQ_STAT((cpu), __local_irq_count)
 #define local_bh_count(cpu)	__IRQ_STAT((cpu), __local_bh_count)
 #define syscall_count(cpu)	__IRQ_STAT((cpu), __syscall_count)
+#define ksoftirqd_task(cpu)	__IRQ_STAT((cpu), __ksoftirqd_task)
   /* arch dependent irq_stat fields */
 #define nmi_count(cpu)		__IRQ_STAT((cpu), __nmi_count)		/* i386, ia64 */
 
--- v2.4.6/linux/include/linux/interrupt.h	Tue Jul  3 17:08:21 2001
+++ linux/include/linux/interrupt.h	Mon Jul  9 18:33:25 2001
@@ -73,8 +73,9 @@
 
 asmlinkage void do_softirq(void);
 extern void open_softirq(int nr, void (*action)(struct softirq_action*), void *data);
-
 extern void softirq_init(void);
+extern void FASTCALL(cpu_raise_softirq(unsigned int cpu, unsigned int nr));
+extern void FASTCALL(raise_softirq(unsigned int nr));
 


@@ -129,7 +130,7 @@
 extern struct tasklet_head tasklet_hi_vec[NR_CPUS];
 
 #define tasklet_trylock(t) (!test_and_set_bit(TASKLET_STATE_RUN, &(t)->state))
-#define tasklet_unlock(t) clear_bit(TASKLET_STATE_RUN, &(t)->state)
+#define tasklet_unlock(t) do { smp_mb__before_clear_bit(); clear_bit(TASKLET_STATE_RUN, &(t)->state); } while(0)
 #define tasklet_unlock_wait(t) while (test_bit(TASKLET_STATE_RUN, &(t)->state)) { barrier(); }
 
 extern void tasklet_schedule(struct tasklet_struct *t);
--- v2.4.6/linux/include/asm-i386/softirq.h	Tue Jul  3 17:08:21 2001
+++ linux/include/asm-i386/softirq.h	Mon Jul  9 18:33:25 2001
@@ -11,8 +11,6 @@
 
 #define local_bh_disable()	cpu_bh_disable(smp_processor_id())
 #define __local_bh_enable()	__cpu_bh_enable(smp_processor_id())
-#define __cpu_raise_softirq(cpu,nr) set_bit((nr), &softirq_pending(cpu));
-#define raise_softirq(nr) __cpu_raise_softirq(smp_processor_id(), (nr))
 
 #define in_softirq() (local_bh_count(smp_processor_id()) != 0)
 
@@ -28,6 +26,7 @@
 do {									\
 	unsigned int *ptr = &local_bh_count(smp_processor_id());	\
 									\
+	barrier();							\
 	if (!--*ptr)							\
 		__asm__ __volatile__ (					\
 			"cmpl $0, -8(%0);"				\
@@ -45,5 +44,7 @@
 		: "r" (ptr), "i" (do_softirq)				\
 		/* no registers clobbered */ );				\
 } while (0)
+
+#define __cpu_raise_softirq(cpu, nr) __set_bit(nr, &softirq_pending(cpu))
 
 #endif	/* __ASM_SOFTIRQ_H */
--- v2.4.6/linux/include/asm-i386/hardirq.h	Tue Jul  3 17:08:21 2001
+++ linux/include/asm-i386/hardirq.h	Mon Jul  9 18:33:25 2001
@@ -11,6 +11,7 @@
 	unsigned int __local_irq_count;
 	unsigned int __local_bh_count;
 	unsigned int __syscall_count;
+	struct task_struct * __ksoftirqd_task; /* waitqueue is too large */
 	unsigned int __nmi_count;	/* arch dependent */
 } ____cacheline_aligned irq_cpustat_t;
 


/ Thomas
.......................................................................
 Thomas Svedberg
 Department of Mathematics
 Chalmers University of Technology

 Address: S-412 96 Göteborg, SWEDEN
 E-mail : thsv@bigfoot.com, thsv@math.chalmers.se
 Phone  : +46 31 772 5368
 Fax    : +46 31 772 3595
.......................................................................

