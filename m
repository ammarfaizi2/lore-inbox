Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289211AbSA1PHi>; Mon, 28 Jan 2002 10:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289212AbSA1PH3>; Mon, 28 Jan 2002 10:07:29 -0500
Received: from mx2.elte.hu ([157.181.151.9]:47555 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289211AbSA1PHS>;
	Mon, 28 Jan 2002 10:07:18 -0500
Date: Mon, 28 Jan 2002 18:04:51 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch] [sched] misc cleanups, 2.5.3-pre5
Message-ID: <Pine.LNX.4.33.0201281801030.10158-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch cleans up a few more things:

 - initialize the scheduler a bit earlier in start_secondary().

 - mark more code with unlikely() conditions.

 - make the load-balancer CONFIG_SMP. We used to run it on UP as well, but
   people noticed :-)

with the unlikely() improvements schedule() is almost fall-through for the
common context-switch case, only the prev->state switch creates a branch.

with all patches applied to 2.5.3-pre5, lat_ctx context switch times
improve from 1.25 usecs to 1.12 usecs.

	Ingo

diff -rNu linux/arch/i386/kernel/smpboot.c linux/arch/i386/kernel/smpboot.c
--- linux/arch/i386/kernel/smpboot.c	Mon Jan 28 15:21:39 2002
+++ linux/arch/i386/kernel/smpboot.c	Mon Jan 28 15:24:44 2002
@@ -456,13 +456,14 @@
  */
 int __init start_secondary(void *unused)
 {
+	__cli();
+	init_idle();
 	/*
 	 * Dont put anything before smp_callin(), SMP
 	 * booting is too fragile that we want to limit the
 	 * things done here to the most necessary things.
 	 */
 	cpu_init();
-	init_idle();
 	smp_callin();
 	while (!atomic_read(&smp_commenced))
 		rep_nop();
diff -rNu linux/include/asm-i386/mmu_context.h linux/include/asm-i386/mmu_context.h
--- linux/include/asm-i386/mmu_context.h	Mon Jan 28 15:21:41 2002
+++ linux/include/asm-i386/mmu_context.h	Mon Jan 28 15:24:44 2002
@@ -49,13 +51,13 @@

 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, struct task_struct *tsk, unsigned cpu)
 {
-	if (prev != next) {
+	if (likely(prev != next)) {
 		/* stop flush ipis for the previous mm */
 		clear_bit(cpu, &prev->cpu_vm_mask);
 		/*
 		 * Re-load LDT if necessary
 		 */
-		if (prev->context.segments != next->context.segments)
+		if (unlikely(prev->context.segments != next->context.segments))
 			load_LDT(next);
 #ifdef CONFIG_SMP
 		cpu_tlbstate[cpu].state = TLBSTATE_OK;
diff -rNu linux/kernel/sched.c linux/kernel/sched.c
--- linux/kernel/sched.c	Mon Jan 28 15:23:50 2002
+++ linux/kernel/sched.c	Mon Jan 28 15:24:44 2002
@@ -315,14 +315,14 @@

 	prepare_to_switch();

-	if (!mm) {
+	if (unlikely(!mm)) {
 		next->active_mm = oldmm;
 		atomic_inc(&oldmm->mm_count);
 		enter_lazy_tlb(oldmm, next, smp_processor_id());
 	} else
 		switch_mm(oldmm, mm, next, smp_processor_id());

-	if (!prev->mm) {
+	if (unlikely(!prev->mm)) {
 		prev->active_mm = NULL;
 		mmdrop(oldmm);
 	}
@@ -360,6 +360,7 @@
 	return sum;
 }

+#if CONFIG_SMP
 /*
  * Lock the busiest runqueue as well, this_rq is locked already.
  * Recalculate nr_running if we have to drop the runqueue lock.
@@ -539,17 +555,21 @@
 	spin_unlock(&this_rq()->lock);
 }

+#endif
+
 /*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
  */
 void scheduler_tick(task_t *p)
 {
-	unsigned long now = jiffies;
 	runqueue_t *rq = this_rq();
+#if CONFIG_SMP
+	unsigned long now = jiffies;

 	if (p == rq->idle)
 		return idle_tick();
+#endif
 	/* Task might have expired already, but not scheduled off yet */
 	if (p->array != rq->active) {
 		p->need_resched = 1;
@@ -595,8 +615,10 @@
 			enqueue_task(p, rq->active);
 	}
 out:
+#if CONFIG_SMP
 	if (!(now % BUSY_REBALANCE_TICK))
 		load_balance(rq, 0);
+#endif
 	spin_unlock(&rq->lock);
 }

@@ -863,9 +892,8 @@
 		goto out_unlock;
 	}
 	array = p->array;
-	if (array) {
+	if (array)
 		dequeue_task(p, array);
-	}
 	p->__nice = nice;
 	p->prio = NICE_TO_PRIO(nice);
 	if (array) {

