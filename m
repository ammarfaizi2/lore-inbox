Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267040AbRG1TQw>; Sat, 28 Jul 2001 15:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267046AbRG1TQn>; Sat, 28 Jul 2001 15:16:43 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:6242 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S267040AbRG1TQ2>; Sat, 28 Jul 2001 15:16:28 -0400
Date: Sat, 28 Jul 2001 21:17:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Maksim Krasnyanskiy <maxk@qualcomm.com>
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        mingo@redhat.com
Subject: Re: [PATCH] [IMPORTANT] Re: 2.4.7 softirq incorrectness.
Message-ID: <20010728211703.A11441@athlon.random>
In-Reply-To: <4.3.1.0.20010727121014.055d4c90@mail1> <200107271935.XAA27068@ms2.inr.ac.ru> <4.3.1.0.20010727141716.05651ac0@mail1> <20010728195404.D12090@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010728195404.D12090@athlon.random>; from andrea@suse.de on Sat, Jul 28, 2001 at 07:54:04PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sat, Jul 28, 2001 at 07:54:04PM +0200, Andrea Arcangeli wrote:
> On Fri, Jul 27, 2001 at 05:52:01PM -0700, Maksim Krasnyanskiy wrote:
> > tasklet_schedule calls tasklet_unlock after it schedules tasklet, which is _totaly_ wrong.
> 
> yes, it was a leftover from 2.4.6. Your diff -u 2.4.7 2.4.5 is correct
> and I also suggest it for for mainline inclusion, thanks.

I did some minor further improvement to it while merging it into my tree
and then I rediffed it. This one also adds the debug check for
local_bh_enable in a clied region. (note for other archs:
__cpu_raise_softirq is required to be atomic with respect to irqs but it
doesn't need to be atomic with respect to smp, in x86 it is implemented
as a non locked bts for example)

diff -urN 2.4.7/include/asm-i386/softirq.h softirq/include/asm-i386/softirq.h
--- 2.4.7/include/asm-i386/softirq.h	Wed Jul 25 22:38:08 2001
+++ softirq/include/asm-i386/softirq.h	Sat Jul 28 21:11:35 2001
@@ -25,7 +25,11 @@
 #define local_bh_enable()						\
 do {									\
 	unsigned int *ptr = &local_bh_count(smp_processor_id());	\
+	unsigned long flags;						\
 									\
+	__save_flags(flags);						\
+	if (!(flags & (1 << 9)))					\
+		BUG();							\
 	barrier();							\
 	if (!--*ptr)							\
 		__asm__ __volatile__ (					\
diff -urN 2.4.7/include/linux/interrupt.h softirq/include/linux/interrupt.h
--- 2.4.7/include/linux/interrupt.h	Sun Jul 22 01:16:45 2001
+++ softirq/include/linux/interrupt.h	Sat Jul 28 21:09:15 2001
@@ -118,7 +118,7 @@
 enum
 {
 	TASKLET_STATE_SCHED,	/* Tasklet is scheduled for execution */
-	TASKLET_STATE_RUN	/* Tasklet is running */
+	TASKLET_STATE_RUN	/* Tasklet is running (SMP only) */
 };
 
 struct tasklet_head
@@ -129,34 +129,80 @@
 extern struct tasklet_head tasklet_vec[NR_CPUS];
 extern struct tasklet_head tasklet_hi_vec[NR_CPUS];
 
-#define tasklet_trylock(t) (!test_and_set_bit(TASKLET_STATE_RUN, &(t)->state))
-#define tasklet_unlock(t) do { smp_mb__before_clear_bit(); clear_bit(TASKLET_STATE_RUN, &(t)->state); } while(0)
-#define tasklet_unlock_wait(t) while (test_bit(TASKLET_STATE_RUN, &(t)->state)) { barrier(); }
+#ifdef CONFIG_SMP
+static inline int tasklet_trylock(struct tasklet_struct *t)
+{
+	return !test_and_set_bit(TASKLET_STATE_RUN, &(t)->state);
+}
+
+static inline void tasklet_unlock(struct tasklet_struct *t)
+{
+	smp_mb__before_clear_bit(); 
+	clear_bit(TASKLET_STATE_RUN, &(t)->state);
+}
+
+static inline void tasklet_unlock_wait(struct tasklet_struct *t)
+{
+	while (test_bit(TASKLET_STATE_RUN, &(t)->state)) { barrier(); }
+}
+#else
+#define tasklet_trylock(t) 1
+#define tasklet_unlock_wait(t) do { } while (0)
+#define tasklet_unlock(t) do { } while (0)
+#endif
+
+static inline void tasklet_schedule(struct tasklet_struct *t)
+{
+	if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
+		int cpu = smp_processor_id();
+		unsigned long flags;
+
+		local_irq_save(flags);
+		t->next = tasklet_vec[cpu].list;
+		tasklet_vec[cpu].list = t;
+		cpu_raise_softirq(cpu, TASKLET_SOFTIRQ);
+		local_irq_restore(flags);
+	}
+}
+
+static inline void tasklet_hi_schedule(struct tasklet_struct *t)
+{
+	if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
+		int cpu = smp_processor_id();
+		unsigned long flags;
+
+		local_irq_save(flags);
+		t->next = tasklet_hi_vec[cpu].list;
+		tasklet_hi_vec[cpu].list = t;
+		cpu_raise_softirq(cpu, HI_SOFTIRQ);
+		local_irq_restore(flags);
+	}
+}
 
-extern void tasklet_schedule(struct tasklet_struct *t);
-extern void tasklet_hi_schedule(struct tasklet_struct *t);
 
 static inline void tasklet_disable_nosync(struct tasklet_struct *t)
 {
 	atomic_inc(&t->count);
+	smp_mb__after_atomic_inc();
 }
 
 static inline void tasklet_disable(struct tasklet_struct *t)
 {
 	tasklet_disable_nosync(t);
 	tasklet_unlock_wait(t);
+	smp_mb();
 }
 
 static inline void tasklet_enable(struct tasklet_struct *t)
 {
-	if (atomic_dec_and_test(&t->count))
-		tasklet_schedule(t);
+	smp_mb__before_atomic_dec();
+	atomic_dec(&t->count);
 }
 
 static inline void tasklet_hi_enable(struct tasklet_struct *t)
 {
-	if (atomic_dec_and_test(&t->count))
-		tasklet_hi_schedule(t);
+	smp_mb__before_atomic_dec();
+	atomic_dec(&t->count);
 }
 
 extern void tasklet_kill(struct tasklet_struct *t);
diff -urN 2.4.7/kernel/softirq.c softirq/kernel/softirq.c
--- 2.4.7/kernel/softirq.c	Sat Jul 21 00:04:34 2001
+++ softirq/kernel/softirq.c	Sat Jul 28 21:09:46 2001
@@ -143,43 +143,7 @@
 /* Tasklets */
 
 struct tasklet_head tasklet_vec[NR_CPUS] __cacheline_aligned;
-
-void tasklet_schedule(struct tasklet_struct *t)
-{
-	unsigned long flags;
-	int cpu;
-
-	cpu = smp_processor_id();
-	local_irq_save(flags);
-	/*
-	 * If nobody is running it then add it to this CPU's
-	 * tasklet queue.
-	 */
-	if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
-		t->next = tasklet_vec[cpu].list;
-		tasklet_vec[cpu].list = t;
-		cpu_raise_softirq(cpu, TASKLET_SOFTIRQ);
-		tasklet_unlock(t);
-	}
-	local_irq_restore(flags);
-}
-
-void tasklet_hi_schedule(struct tasklet_struct *t)
-{
-	unsigned long flags;
-	int cpu;
-
-	cpu = smp_processor_id();
-	local_irq_save(flags);
-
-	if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
-		t->next = tasklet_hi_vec[cpu].list;
-		tasklet_hi_vec[cpu].list = t;
-		cpu_raise_softirq(cpu, HI_SOFTIRQ);
-		tasklet_unlock(t);
-	}
-	local_irq_restore(flags);
-}
+struct tasklet_head tasklet_hi_vec[NR_CPUS] __cacheline_aligned;
 
 static void tasklet_action(struct softirq_action *a)
 {
@@ -196,29 +160,25 @@
 
 		list = list->next;
 
-		if (!tasklet_trylock(t))
-			BUG();
-		if (!atomic_read(&t->count)) {
-			if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
-				BUG();
-			t->func(t->data);
+		if (tasklet_trylock(t)) {
+			if (!atomic_read(&t->count)) {
+				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
+					BUG();
+				t->func(t->data);
+				tasklet_unlock(t);
+				continue;
+			}
 			tasklet_unlock(t);
-			continue;
 		}
-		tasklet_unlock(t);
 
 		local_irq_disable();
 		t->next = tasklet_vec[cpu].list;
 		tasklet_vec[cpu].list = t;
-		cpu_raise_softirq(cpu, TASKLET_SOFTIRQ);
 		local_irq_enable();
+		__cpu_raise_softirq(cpu, TASKLET_SOFTIRQ);
 	}
 }
 
-
-
-struct tasklet_head tasklet_hi_vec[NR_CPUS] __cacheline_aligned;
-
 static void tasklet_hi_action(struct softirq_action *a)
 {
 	int cpu = smp_processor_id();
@@ -234,22 +194,22 @@
 
 		list = list->next;
 
-		if (!tasklet_trylock(t))
-			BUG();
-		if (!atomic_read(&t->count)) {
-			if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
-				BUG();
-			t->func(t->data);
+		if (tasklet_trylock(t)) {
+			if (!atomic_read(&t->count)) {
+				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
+					BUG();
+				t->func(t->data);
+				tasklet_unlock(t);
+				continue;
+			}
 			tasklet_unlock(t);
-			continue;
 		}
-		tasklet_unlock(t);
 
 		local_irq_disable();
 		t->next = tasklet_hi_vec[cpu].list;
 		tasklet_hi_vec[cpu].list = t;
-		cpu_raise_softirq(cpu, HI_SOFTIRQ);
 		local_irq_enable();
+		__cpu_raise_softirq(cpu, HI_SOFTIRQ);
 	}
 }
 
diff -urN 2.4.7/net/core/dev.c softirq/net/core/dev.c
--- 2.4.7/net/core/dev.c	Sat Jul 21 00:04:34 2001
+++ softirq/net/core/dev.c	Sat Jul 28 21:10:20 2001
@@ -1217,10 +1217,10 @@
 enqueue:
 			dev_hold(skb->dev);
 			__skb_queue_tail(&queue->input_pkt_queue,skb);
+			local_irq_restore(flags);
 
 			/* Runs from irqs or BH's, no need to wake BH */
 			__cpu_raise_softirq(this_cpu, NET_RX_SOFTIRQ);
-			local_irq_restore(flags);
 #ifndef OFFLINE_SAMPLE
 			get_sample_stats(this_cpu);
 #endif
@@ -1529,10 +1529,10 @@
 
 	local_irq_disable();
 	netdev_rx_stat[this_cpu].time_squeeze++;
+	local_irq_enable();
 
 	/* This already runs in BH context, no need to wake up BH's */
 	__cpu_raise_softirq(this_cpu, NET_RX_SOFTIRQ);
-	local_irq_enable();
 
 	NET_PROFILE_LEAVE(softnet_process);
 	return;

Andrea
