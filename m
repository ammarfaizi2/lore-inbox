Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317742AbSFLQ7w>; Wed, 12 Jun 2002 12:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317743AbSFLQ7v>; Wed, 12 Jun 2002 12:59:51 -0400
Received: from mx1.elte.hu ([157.181.1.137]:10400 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317742AbSFLQ7t>;
	Wed, 12 Jun 2002 12:59:49 -0400
Date: Wed, 12 Jun 2002 18:57:34 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: "David S. Miller" <davem@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Mike Kravetz <kravetz@us.ibm.com>,
        Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: [patch] switch_mm()'s desire to run without the rq lock
In-Reply-To: <20020612.045414.105100110.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0206121551190.10732-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Jun 2002, David S. Miller wrote:

> There is nothing weird about holding page_table_lock during switch_mm, I
> can imagine many other ports doing it especially those with TLB pids
> which want to optimize SMP tlb/cache flushes.

as far as i can see only Sparc64 does it. And switch_mm() (along with
switch_to()) is a very scheduler-internal thing, we dont really (and must
not) do anything weird in it.

> I think changing vmscan.c to not call wakeup is the wrong way to go
> about this.  I thought about doing that originally, but it looks to be
> 100 times more difficult to implement (and verify) than the scheduler
> side fix.

okay, understood.

here is a solution that allows us to eat and have the pudding at once.  
(patch attached, against Linus' latest BK tree):

- i've extended the scheduler context-switch mechanism with the following
  per-arch defines:

	prepare_arch_schedule(prev_task);
	finish_arch_schedule(prev_task);
	prepare_arch_switch(rq);
	finish_arch_switch(rq);

- plus switch_to() takes 3 parameters again:

	switch_to(prev, next, last);

- schedule_tail() has the 'prev' task parameter again, it must be passed
  over in switch_to() and passed in to the fork() startup path.

architectures that need to unlock the runqueue before doing the switch can
do the following:

 #define prepare_arch_schedule(prev)             task_lock(prev)
 #define finish_arch_schedule(prev)              task_unlock(prev)
 #define prepare_arch_switch(rq)                 spin_unlock(&(rq)->lock)
 #define finish_arch_switch(rq)                  __sti()

this way the task-lock makes sure that a task is not scheduled on some
other CPU before the switch-out finishes, but the runqueue lock is
dropped. (Local interrupts are kept disabled in this variant, just to
exclude things like TLB flushes - if that matters.)

architectures that can hold the runqueue lock during context-switch can do
the following simplification:

 #define prepare_arch_schedule(prev)             do { } while(0)
 #define finish_arch_schedule(prev)              do { } while(0)
 #define prepare_arch_switch(rq)                 do { } while(0)
 #define finish_arch_switch(rq)                  spin_unlock_irq(&(rq)->lock)

further optimizations possible in the 'simple' variant:

- an architecture does not have to handle the 'last' parameter in
  switch_to() if the 'prev' parameter is unused in finish_arch_schedule().  
  This way the inlined return value of context_switch() too gets optimized
  away at compile-time.

- an architecture does not have to pass the 'prev' pointer to
  schedule_tail(), if the 'prev' parameter is unused in
  finish_arch_schedule().

the x86 architecture makes use of these optimizations.

Via this solution we have a reasonably flexible context-switch setup which
falls back to the current (faster) code on x86, but on other platforms the
runqueue lock can be dropped before doing the context-switch as well.

	Ingo

NOTE: i have coded and tested the 'complex' variant on x86 as well to make
      sure it works for you on Sparc64 - but since x86's switch_mm() is
      not too subtle it can use the simpler variant. [ The following
      things had to be done to make x86 arch use the complex variant: the
      4 complex macros have to be used in system.h, entry.S has to
      'pushl %ebx' and 'addl $4, %esp' around the call to schedule_tail(),
      and switch_to() had to be reverted to the 3-parameter variant
      present in the 2.4 kernels.

NOTE2: prepare_to_switch() functionality has been moved into the
       prepare_arch_switch() macro.

NOTE3: please use macros for prepare|finish_arch_switch() so that we can
       keep the scheduler data structures internal to sched.c.

--- linux/arch/i386/kernel/entry.S.orig	Wed Jun 12 16:53:02 2002
+++ linux/arch/i386/kernel/entry.S	Wed Jun 12 17:47:18 2002
@@ -193,6 +193,7 @@
 
 ENTRY(ret_from_fork)
 #if CONFIG_SMP || CONFIG_PREEMPT
+	# NOTE: this function takes a parameter but it's unused on x86.
 	call schedule_tail
 #endif
 	GET_THREAD_INFO(%ebx)
--- linux/include/asm-i386/system.h.orig	Wed Jun 12 16:03:37 2002
+++ linux/include/asm-i386/system.h	Wed Jun 12 18:36:34 2002
@@ -11,9 +11,12 @@
 struct task_struct;	/* one of the stranger aspects of C forward declarations.. */
 extern void FASTCALL(__switch_to(struct task_struct *prev, struct task_struct *next));
 
-#define prepare_to_switch()	do { } while(0)
+#define prepare_arch_schedule(prev)		do { } while(0)
+#define finish_arch_schedule(prev)		do { } while(0)
+#define prepare_arch_switch(rq)			do { } while(0)
+#define finish_arch_switch(rq)			spin_unlock_irq(&(rq)->lock)
 
-#define switch_to(prev,next) do {					\
+#define switch_to(prev,next,last) do {					\
 	asm volatile("pushl %%esi\n\t"					\
 		     "pushl %%edi\n\t"					\
 		     "pushl %%ebp\n\t"					\
--- linux/kernel/sched.c.orig	Wed Jun 12 15:47:30 2002
+++ linux/kernel/sched.c	Wed Jun 12 18:15:06 2002
@@ -451,19 +451,18 @@
 }
 
 #if CONFIG_SMP || CONFIG_PREEMPT
-asmlinkage void schedule_tail(void)
+asmlinkage void schedule_tail(task_t *prev)
 {
-	spin_unlock_irq(&this_rq()->lock);
+	finish_arch_switch(this_rq());
+	finish_arch_schedule(prev);
 }
 #endif
 
-static inline void context_switch(task_t *prev, task_t *next)
+static inline task_t * context_switch(task_t *prev, task_t *next)
 {
 	struct mm_struct *mm = next->mm;
 	struct mm_struct *oldmm = prev->active_mm;
 
-	prepare_to_switch();
-
 	if (unlikely(!mm)) {
 		next->active_mm = oldmm;
 		atomic_inc(&oldmm->mm_count);
@@ -477,7 +476,9 @@
 	}
 
 	/* Here we just switch the register state and the stack. */
-	switch_to(prev, next);
+	switch_to(prev, next, prev);
+
+	return prev;
 }
 
 unsigned long nr_running(void)
@@ -823,6 +824,7 @@
 	rq = this_rq();
 
 	release_kernel_lock(prev, smp_processor_id());
+	prepare_arch_schedule(prev);
 	prev->sleep_timestamp = jiffies;
 	spin_lock_irq(&rq->lock);
 
@@ -878,23 +880,20 @@
 	if (likely(prev != next)) {
 		rq->nr_switches++;
 		rq->curr = next;
-		context_switch(prev, next);
-
-		/*
-		 * The runqueue pointer might be from another CPU
-		 * if the new task was last running on a different
-		 * CPU - thus re-load it.
-		 */
-		mb();
+	
+		prepare_arch_switch(rq);
+		prev = context_switch(prev, next);
+		barrier();
 		rq = this_rq();
-	}
-	spin_unlock_irq(&rq->lock);
+		finish_arch_switch(rq);
+	} else
+		spin_unlock_irq(&rq->lock);
+	finish_arch_schedule(prev);
 
 	reacquire_kernel_lock(current);
 	preempt_enable_no_resched();
 	if (test_thread_flag(TIF_NEED_RESCHED))
 		goto need_resched;
-	return;
 }
 
 #ifdef CONFIG_PREEMPT


