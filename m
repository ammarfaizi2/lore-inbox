Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289124AbSAKKdl>; Fri, 11 Jan 2002 05:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289126AbSAKKdc>; Fri, 11 Jan 2002 05:33:32 -0500
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:35969 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S289124AbSAKKda>; Fri, 11 Jan 2002 05:33:30 -0500
Message-ID: <3C3EBF76.3AEB82AB@hlrs.de>
Date: Fri, 11 Jan 2002 11:33:26 +0100
From: Rainer Keller <Keller@hlrs.de>
Organization: Rechenzentrum =?iso-8859-1?Q?Universit=E4t?= Stuttgart
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] Small optimization for UP in sched and prefetch
Content-Type: multipart/mixed;
 boundary="------------B93AD13617466B8E88186391"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B93AD13617466B8E88186391
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello Marcelo & all,

After checking the assembler code of clearbit with regard to the
substition of task->processor, I added the last occurence of the
variable in init_idle.

Do You think the following patch is safe for inclusion into 2.4?

It's been running for 3 days on this computer.

Greetings,
raY

PS: Because of usage of prefetch in include/linux/list.h, the memory
prefetch is triggered 137 times on my configuration...
-- 
---------------------------------------------------------------
Rainer Keller           Mail: Keller@hlrs.de
Allmandring 30          WWW: http://www.hlrs.de/people/keller
70550 Stuttgart         Tel. 0711 / 685 5858
--------------B93AD13617466B8E88186391
Content-Type: text/plain; charset=us-ascii;
 name="patch_prefetch_sched-2.4.17_second.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch_prefetch_sched-2.4.17_second.diff"

diff -ur linux-2.4.17/include/asm-i386/processor.h linux-2.4.17-mine/include/asm-i386/processor.h
--- linux-2.4.17/include/asm-i386/processor.h	Thu Nov 22 20:46:19 2001
+++ linux-2.4.17-mine/include/asm-i386/processor.h	Fri Jan 11 11:31:49 2002
@@ -478,8 +478,8 @@
 
 #define cpu_relax()	rep_nop()
 
-/* Prefetch instructions for Pentium III and AMD Athlon */
-#ifdef 	CONFIG_MPENTIUMIII
+/* Prefetch instructions for Pentium III, Pentium 4 and AMD Athlon */
+#if defined(CONFIG_MPENTIUMIII) || defined(CONFIG_MPENTIUM4)
 
 #define ARCH_HAS_PREFETCH
 extern inline void prefetch(const void *x)
@@ -502,7 +502,12 @@
 {
 	 __asm__ __volatile__ ("prefetchw (%0)" : : "r"(x));
 }
-#define spin_lock_prefetch(x)	prefetchw(x)
+
+#ifndef CONFIG_SMP
+#define spin_lock_prefetch(x) do { } while(0)
+#else
+#define spin_lock_prefetch(x) prefetchw(x)
+#endif
 
 #endif
 
diff -ur linux-2.4.17/include/linux/prefetch.h linux-2.4.17-mine/include/linux/prefetch.h
--- linux-2.4.17/include/linux/prefetch.h	Thu Nov 22 20:46:19 2001
+++ linux-2.4.17-mine/include/linux/prefetch.h	Thu Jan 10 13:21:39 2002
@@ -10,6 +10,7 @@
 #ifndef _LINUX_PREFETCH_H
 #define _LINUX_PREFETCH_H
 
+#include <linux/config.h>
 #include <asm/processor.h>
 #include <asm/cache.h>
 
@@ -26,7 +27,9 @@
 	
 	prefetch(x)  	- prefetches the cacheline at "x" for read
 	prefetchw(x)	- prefetches the cacheline at "x" for write
-	spin_lock_prefetch(x) - prefectches the spinlock *x for taking
+	spin_lock_prefetch(x) - prefetches the spinlock *x for taking,
+	                        if on SMP, otherwise not needed
+				(except for debugging reasons -- slow anyway).
 	
 	there is also PREFETCH_STRIDE which is the architecure-prefered 
 	"lookahead" size for prefetching streamed operations.
@@ -50,7 +53,11 @@
 
 #ifndef ARCH_HAS_SPINLOCK_PREFETCH
 #define ARCH_HAS_SPINLOCK_PREFETCH
+#ifndef CONFIG_SMP
+#define spin_lock_prefetch(x) do { } while(0)
+#else
 #define spin_lock_prefetch(x) prefetchw(x)
+#endif
 #endif
 
 #ifndef PREFETCH_STRIDE
diff -ur linux-2.4.17/kernel/sched.c linux-2.4.17-mine/kernel/sched.c
--- linux-2.4.17/kernel/sched.c	Fri Dec 21 18:42:04 2001
+++ linux-2.4.17-mine/kernel/sched.c	Fri Jan 11 11:30:43 2002
@@ -117,11 +117,13 @@
 #define idle_task(cpu) (init_tasks[cpu_number_map(cpu)])
 #define can_schedule(p,cpu) \
 	((p)->cpus_runnable & (p)->cpus_allowed & (1 << cpu))
+#define processor_of_tsk(tsk) (tsk)->processor
 
 #else
 
 #define idle_task(cpu) (&init_task)
 #define can_schedule(p,cpu) (1)
+#define processor_of_tsk(tsk) (0)
 
 #endif
 
@@ -172,7 +174,7 @@
 #ifdef CONFIG_SMP
 		/* Give a largish advantage to the same processor...   */
 		/* (this is equivalent to penalizing other processors) */
-		if (p->processor == this_cpu)
+		if (processor_of_tsk(p) == this_cpu)
 			weight += PROC_CHANGE_PENALTY;
 #endif
 
@@ -221,7 +223,7 @@
 	 * shortcut if the woken up task's last CPU is
 	 * idle now.
 	 */
-	best_cpu = p->processor;
+	best_cpu = processor_of_tsk(p);
 	if (can_schedule(p, best_cpu)) {
 		tsk = idle_task(best_cpu);
 		if (cpu_curr(best_cpu) == tsk) {
@@ -295,18 +297,18 @@
 	tsk = target_tsk;
 	if (tsk) {
 		if (oldest_idle != -1ULL) {
-			best_cpu = tsk->processor;
+			best_cpu = processor_of_tsk(tsk);
 			goto send_now_idle;
 		}
 		tsk->need_resched = 1;
-		if (tsk->processor != this_cpu)
-			smp_send_reschedule(tsk->processor);
+		if (processor_of_tsk(tsk) != this_cpu)
+			smp_send_reschedule(processor_of_tsk(tsk));
 	}
 	return;
 		
 
 #else /* UP */
-	int this_cpu = smp_processor_id();
+	const int this_cpu = smp_processor_id();
 	struct task_struct *tsk;
 
 	tsk = cpu_curr(this_cpu);
@@ -559,7 +561,7 @@
 	if (!current->active_mm) BUG();
 need_resched_back:
 	prev = current;
-	this_cpu = prev->processor;
+	this_cpu = processor_of_tsk(prev);
 
 	if (unlikely(in_interrupt())) {
 		printk("Scheduling in interrupt\n");
@@ -1311,7 +1313,7 @@
 	}
 	sched_data->curr = current;
 	sched_data->last_schedule = get_cycles();
-	clear_bit(current->processor, &wait_init_idle);
+	clear_bit(processor_of_tsk(current), &wait_init_idle);
 }
 
 extern void init_timervecs (void);

--------------B93AD13617466B8E88186391--

