Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290019AbSAKRHn>; Fri, 11 Jan 2002 12:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290024AbSAKRHe>; Fri, 11 Jan 2002 12:07:34 -0500
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:60099 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S290019AbSAKRHS>; Fri, 11 Jan 2002 12:07:18 -0500
Message-ID: <3C3F1BB8.C666F57@hlrs.de>
Date: Fri, 11 Jan 2002 18:07:04 +0100
From: Rainer Keller <Keller@hlrs.de>
Organization: Rechenzentrum =?iso-8859-1?Q?Universit=E4t?= Stuttgart
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Small optimization for UP in sched and prefetch (take 3)
In-Reply-To: <3C3EBF76.3AEB82AB@hlrs.de> <3C3EC3A2.C9C9D184@mandrakesoft.com>
Content-Type: multipart/mixed;
 boundary="------------62E47A84FD5C9077C3204CC6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------62E47A84FD5C9077C3204CC6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:
> > PS: Because of usage of prefetch in include/linux/list.h, the
> > memory prefetch is triggered 137 times on my configuration...
> We need to merge in __builtin_prefetch support into the kernel,
> because gcc 3.1 recently got support for it.  It would be nice at
> least for future prefetch-related patches to perhaps call
> __builtin_prefetch, and have the headers substitute a prefetch if
> the compiler does not support it.

OK, I added this suggestion -- it changes compiler.h to look out for
gcc-3.1 and then set macros for __builtin_prefetch.
But in order to get gcc 3.1 to issue prefetches, the -mcpu (and/or
-march?) must be set to pentium3 or pentium4 (same applies for AMD
athlons).

There's one minor nit to this:
"copy_to_user" has declared the parameter "from" as const and then does
a prefetch on "from".... This produces a warning:

/usr/src/linux-2.4.17-mine/include/asm/uaccess.h: In function
`__constant_copy_to_user':
/usr/src/linux-2.4.17-mine/include/asm/uaccess.h:549: warning: passing
arg 1 of `__builtin_prefetch' discards qualifiers from pointer target
type

How can I resolve this ?

Greetings,
raY
-- 
---------------------------------------------------------------
Rainer Keller           Mail: Keller@hlrs.de
Allmandring 30          WWW: http://www.hlrs.de/people/keller
70550 Stuttgart         Tel. 0711 / 685 5858
--------------62E47A84FD5C9077C3204CC6
Content-Type: text/plain; charset=us-ascii;
 name="patch_prefetch_sched-2.4.17_third.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch_prefetch_sched-2.4.17_third.diff"

diff -ur linux-2.4.17/include/asm-i386/processor.h linux-2.4.17-mine/include/asm-i386/processor.h
--- linux-2.4.17/include/asm-i386/processor.h	Thu Nov 22 20:46:19 2001
+++ linux-2.4.17-mine/include/asm-i386/processor.h	Fri Jan 11 13:27:30 2002
@@ -478,8 +478,14 @@
 
 #define cpu_relax()	rep_nop()
 
-/* Prefetch instructions for Pentium III and AMD Athlon */
-#ifdef 	CONFIG_MPENTIUMIII
+/*
+ * If we don't have a compiler, which offers builtin_prefetch, do it our selve,
+ * if the processor supports it.
+ */
+#ifndef HAVE_builtin_prefetch
+
+/* Prefetch instructions for Pentium III, Pentium 4 and AMD Athlon */
+#if defined(CONFIG_MPENTIUMIII) || defined(CONFIG_MPENTIUM4)
 
 #define ARCH_HAS_PREFETCH
 extern inline void prefetch(const void *x)
@@ -502,8 +508,14 @@
 {
 	 __asm__ __volatile__ ("prefetchw (%0)" : : "r"(x));
 }
-#define spin_lock_prefetch(x)	prefetchw(x)
 
+#ifndef CONFIG_SMP
+#define spin_lock_prefetch(x) do { } while(0)
+#else
+#define spin_lock_prefetch(x) prefetchw(x)
 #endif
+
+#endif /* CONFIG_MPENTIUMII || CONFIG_MPENTIUM4 */
+#endif /* HAVE_builtin_prefetch */
 
 #endif /* __ASM_I386_PROCESSOR_H */
diff -ur linux-2.4.17/include/linux/compiler.h linux-2.4.17-mine/include/linux/compiler.h
--- linux-2.4.17/include/linux/compiler.h	Tue Sep 18 23:12:45 2001
+++ linux-2.4.17-mine/include/linux/compiler.h	Fri Jan 11 13:19:40 2002
@@ -1,6 +1,8 @@
 #ifndef __LINUX_COMPILER_H
 #define __LINUX_COMPILER_H
 
+#include <linux/config.h>
+
 /* Somewhere in the middle of the GCC 2.96 development cycle, we implemented
    a mechanism by which the user can annotate likely branch directions and
    expect the blocks to be reordered appropriately.  Define __builtin_expect
@@ -12,5 +14,24 @@
 
 #define likely(x)	__builtin_expect((x),1)
 #define unlikely(x)	__builtin_expect((x),0)
+
+
+/*
+ * Starting somewhere in GCC 3.1, builtin_prefetch support was added, i.e. we're
+ * not dependant on information by include/asm/processor.h
+ */
+#if __GNUC__ == 3 && __GNUC_MINOR__ >= 1
+#define HAVE_builtin_prefetch
+
+#define prefetch(x)  __builtin_prefetch((x))
+#define prefetchw(x) __builtin_prefetch((x), 2)
+
+#ifndef CONFIG_SMP
+#define spin_lock_prefetch(x) do { } while(0)
+#else
+#define spin_lock_prefetch(x) prefetchw(x)
+#endif
+
+#endif
 
 #endif /* __LINUX_COMPILER_H */
diff -ur linux-2.4.17/include/linux/prefetch.h linux-2.4.17-mine/include/linux/prefetch.h
--- linux-2.4.17/include/linux/prefetch.h	Thu Nov 22 20:46:19 2001
+++ linux-2.4.17-mine/include/linux/prefetch.h	Fri Jan 11 12:44:30 2002
@@ -10,6 +10,8 @@
 #ifndef _LINUX_PREFETCH_H
 #define _LINUX_PREFETCH_H
 
+#include <linux/config.h>
+#include <linux/compiler.h>
 #include <asm/processor.h>
 #include <asm/cache.h>
 
@@ -26,7 +28,9 @@
 	
 	prefetch(x)  	- prefetches the cacheline at "x" for read
 	prefetchw(x)	- prefetches the cacheline at "x" for write
-	spin_lock_prefetch(x) - prefectches the spinlock *x for taking
+	spin_lock_prefetch(x) - prefetches the spinlock *x for taking,
+	                        if on SMP, otherwise not needed
+				(except for debugging reasons -- slow anyway).
 	
 	there is also PREFETCH_STRIDE which is the architecure-prefered 
 	"lookahead" size for prefetching streamed operations.
@@ -37,7 +41,9 @@
  *	These cannot be do{}while(0) macros. See the mental gymnastics in
  *	the loop macro.
  */
- 
+
+#ifndef HAVE_builtin_prefetch 
+
 #ifndef ARCH_HAS_PREFETCH
 #define ARCH_HAS_PREFETCH
 static inline void prefetch(const void *x) {;}
@@ -50,11 +56,17 @@
 
 #ifndef ARCH_HAS_SPINLOCK_PREFETCH
 #define ARCH_HAS_SPINLOCK_PREFETCH
+#ifndef CONFIG_SMP
+#define spin_lock_prefetch(x) do { } while(0)
+#else
 #define spin_lock_prefetch(x) prefetchw(x)
 #endif
+#endif
 
 #ifndef PREFETCH_STRIDE
 #define PREFETCH_STRIDE (4*L1_CACHE_BYTES)
 #endif
+
+#endif /* HAVE_builtin_prefetch */
 
 #endif
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

--------------62E47A84FD5C9077C3204CC6--

