Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbTGGCEm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 22:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266778AbTGGCEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 22:04:41 -0400
Received: from dp.samba.org ([66.70.73.150]:41677 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264537AbTGGCEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 22:04:25 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvald@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] switch_mm/enter_lazy_tlb Redundant CPU Args
Date: Mon, 07 Jul 2003 12:17:25 +1000
Message-Id: <20030707021859.7AD1E2C0BF@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

switch_mm and enter_lazy_tlb take a CPU arg, which is always
smp_processor_id().  This is misleading, and pointless if they use
per-cpu variables or other optimizations.  gcc will eliminate
redundant smp_processor_id() (in inline functions) anyway.

This removes that arg from all the architectures.

Name: switch_mm and enter_lazy_tlb: remove cpu arg
Author: Rusty Russell
Status: Booted on 2.5.74-bk4

D: switch_mm and enter_lazy_tlb take a CPU arg, which is always
D: smp_processor_id().  This is misleading, and pointless if they use
D: per-cpu variables or other optimizations.  gcc will eliminate
D: redundant smp_processor_id() (in inline functions) anyway.
D: 
D: This removes that arg from all the architectures.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29059-linux-2.5.74-bk4/arch/cris/mm/tlb.c .29059-linux-2.5.74-bk4.updated/arch/cris/mm/tlb.c
--- .29059-linux-2.5.74-bk4/arch/cris/mm/tlb.c	2003-03-18 05:01:40.000000000 +1100
+++ .29059-linux-2.5.74-bk4.updated/arch/cris/mm/tlb.c	2003-07-07 11:51:59.000000000 +1000
@@ -283,7 +283,7 @@ get_mmu_context(struct mm_struct *mm)
 
 void 
 switch_mm(struct mm_struct *prev, struct mm_struct *next,
-	  struct task_struct *tsk, int cpu)
+	  struct task_struct *tsk)
 {
 	/* make sure we have a context */
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29059-linux-2.5.74-bk4/arch/i386/kernel/cpu/common.c .29059-linux-2.5.74-bk4.updated/arch/i386/kernel/cpu/common.c
--- .29059-linux-2.5.74-bk4/arch/i386/kernel/cpu/common.c	2003-07-07 10:47:43.000000000 +1000
+++ .29059-linux-2.5.74-bk4.updated/arch/i386/kernel/cpu/common.c	2003-07-07 11:51:59.000000000 +1000
@@ -495,7 +495,7 @@ void __init cpu_init (void)
 	current->active_mm = &init_mm;
 	if (current->mm)
 		BUG();
-	enter_lazy_tlb(&init_mm, current, cpu);
+	enter_lazy_tlb(&init_mm, current);
 
 	load_esp0(t, thread->esp0);
 	set_tss_desc(cpu,t);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29059-linux-2.5.74-bk4/arch/parisc/kernel/smp.c .29059-linux-2.5.74-bk4.updated/arch/parisc/kernel/smp.c
--- .29059-linux-2.5.74-bk4/arch/parisc/kernel/smp.c	2003-06-17 16:57:30.000000000 +1000
+++ .29059-linux-2.5.74-bk4.updated/arch/parisc/kernel/smp.c	2003-07-07 11:51:59.000000000 +1000
@@ -456,7 +456,7 @@ smp_cpu_init(int cpunum)
 	current->active_mm = &init_mm;
 	if(current->mm)
 		BUG();
-	enter_lazy_tlb(&init_mm, current, cpunum);
+	enter_lazy_tlb(&init_mm, current);
 
 	init_IRQ();   /* make sure no IRQ's are enabled or pending */
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29059-linux-2.5.74-bk4/arch/s390/kernel/setup.c .29059-linux-2.5.74-bk4.updated/arch/s390/kernel/setup.c
--- .29059-linux-2.5.74-bk4/arch/s390/kernel/setup.c	2003-05-05 12:36:56.000000000 +1000
+++ .29059-linux-2.5.74-bk4.updated/arch/s390/kernel/setup.c	2003-07-07 11:51:59.000000000 +1000
@@ -107,7 +107,7 @@ void __devinit cpu_init (void)
         current->active_mm = &init_mm;
         if (current->mm)
                 BUG();
-        enter_lazy_tlb(&init_mm, current, nr);
+        enter_lazy_tlb(&init_mm, current);
 }
 
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29059-linux-2.5.74-bk4/arch/um/kernel/process_kern.c .29059-linux-2.5.74-bk4.updated/arch/um/kernel/process_kern.c
--- .29059-linux-2.5.74-bk4/arch/um/kernel/process_kern.c	2003-02-11 14:25:59.000000000 +1100
+++ .29059-linux-2.5.74-bk4.updated/arch/um/kernel/process_kern.c	2003-07-07 11:51:59.000000000 +1000
@@ -113,8 +113,9 @@ int kernel_thread(int (*fn)(void *), voi
 }
 
 void switch_mm(struct mm_struct *prev, struct mm_struct *next, 
-	       struct task_struct *tsk, unsigned cpu)
+	       struct task_struct *tsk)
 {
+	unsigned cpu = smp_processor_id();
 	if (prev != next) 
 		clear_bit(cpu, &prev->cpu_vm_mask);
 	set_bit(cpu, &next->cpu_vm_mask);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29059-linux-2.5.74-bk4/arch/x86_64/kernel/setup64.c .29059-linux-2.5.74-bk4.updated/arch/x86_64/kernel/setup64.c
--- .29059-linux-2.5.74-bk4/arch/x86_64/kernel/setup64.c	2003-05-27 15:02:05.000000000 +1000
+++ .29059-linux-2.5.74-bk4.updated/arch/x86_64/kernel/setup64.c	2003-07-07 11:51:59.000000000 +1000
@@ -288,7 +288,7 @@ void __init cpu_init (void)
 	me->active_mm = &init_mm;
 	if (me->mm)
 		BUG();
-	enter_lazy_tlb(&init_mm, me, cpu);
+	enter_lazy_tlb(&init_mm, me);
 
 	set_tss_desc(cpu, t);
 	load_TR_desc();
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29059-linux-2.5.74-bk4/fs/aio.c .29059-linux-2.5.74-bk4.updated/fs/aio.c
--- .29059-linux-2.5.74-bk4/fs/aio.c	2003-06-15 11:30:05.000000000 +1000
+++ .29059-linux-2.5.74-bk4.updated/fs/aio.c	2003-07-07 11:51:59.000000000 +1000
@@ -552,7 +552,7 @@ static void unuse_mm(struct mm_struct *m
 {
 	current->mm = NULL;
 	/* active_mm is still 'mm' */
-	enter_lazy_tlb(mm, current, smp_processor_id());
+	enter_lazy_tlb(mm, current);
 }
 
 /* Run on kevent's context.  FIXME: needs to be per-cpu and warn if an
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29059-linux-2.5.74-bk4/include/asm-alpha/machvec.h .29059-linux-2.5.74-bk4.updated/include/asm-alpha/machvec.h
--- .29059-linux-2.5.74-bk4/include/asm-alpha/machvec.h	2003-02-25 10:11:05.000000000 +1100
+++ .29059-linux-2.5.74-bk4.updated/include/asm-alpha/machvec.h	2003-07-07 11:51:59.000000000 +1000
@@ -68,7 +68,7 @@ struct alpha_machine_vector
 	int (*mv_is_ioaddr)(unsigned long);
 
 	void (*mv_switch_mm)(struct mm_struct *, struct mm_struct *,
-			     struct task_struct *, long);
+			     struct task_struct *);
 	void (*mv_activate_mm)(struct mm_struct *, struct mm_struct *);
 
 	void (*mv_flush_tlb_current)(struct mm_struct *);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29059-linux-2.5.74-bk4/include/asm-alpha/mmu_context.h .29059-linux-2.5.74-bk4.updated/include/asm-alpha/mmu_context.h
--- .29059-linux-2.5.74-bk4/include/asm-alpha/mmu_context.h	2003-04-20 18:05:12.000000000 +1000
+++ .29059-linux-2.5.74-bk4.updated/include/asm-alpha/mmu_context.h	2003-07-07 11:51:59.000000000 +1000
@@ -130,11 +130,12 @@ __get_new_mm_context(struct mm_struct *m
 
 __EXTERN_INLINE void
 ev5_switch_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm,
-	      struct task_struct *next, long cpu)
+	      struct task_struct *next)
 {
 	/* Check if our ASN is of an older version, and thus invalid. */
 	unsigned long asn;
 	unsigned long mmc;
+	long cpu = smp_processor_id();
 
 #ifdef CONFIG_SMP
 	cpu_data[cpu].asn_lock = 1;
@@ -159,7 +160,7 @@ ev5_switch_mm(struct mm_struct *prev_mm,
 
 __EXTERN_INLINE void
 ev4_switch_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm,
-	      struct task_struct *next, long cpu)
+	      struct task_struct *next)
 {
 	/* As described, ASN's are broken for TLB usage.  But we can
 	   optimize for switching between threads -- if the mm is
@@ -174,7 +175,7 @@ ev4_switch_mm(struct mm_struct *prev_mm,
 
 	/* Do continue to allocate ASNs, because we can still use them
 	   to avoid flushing the icache.  */
-	ev5_switch_mm(prev_mm, next_mm, next, cpu);
+	ev5_switch_mm(prev_mm, next_mm, next);
 }
 
 extern void __load_new_mm_context(struct mm_struct *);
@@ -212,14 +213,14 @@ ev4_activate_mm(struct mm_struct *prev_m
 #define deactivate_mm(tsk,mm)	do { } while (0)
 
 #ifdef CONFIG_ALPHA_GENERIC
-# define switch_mm(a,b,c,d)	alpha_mv.mv_switch_mm((a),(b),(c),(d))
+# define switch_mm(a,b,c)	alpha_mv.mv_switch_mm((a),(b),(c))
 # define activate_mm(x,y)	alpha_mv.mv_activate_mm((x),(y))
 #else
 # ifdef CONFIG_ALPHA_EV4
-#  define switch_mm(a,b,c,d)	ev4_switch_mm((a),(b),(c),(d))
+#  define switch_mm(a,b,c)	ev4_switch_mm((a),(b),(c))
 #  define activate_mm(x,y)	ev4_activate_mm((x),(y))
 # else
-#  define switch_mm(a,b,c,d)	ev5_switch_mm((a),(b),(c),(d))
+#  define switch_mm(a,b,c)	ev5_switch_mm((a),(b),(c))
 #  define activate_mm(x,y)	ev5_activate_mm((x),(y))
 # endif
 #endif
@@ -245,7 +246,7 @@ destroy_context(struct mm_struct *mm)
 }
 
 static inline void
-enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk, unsigned cpu)
+enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
 	tsk->thread_info->pcb.ptbr
 	  = ((unsigned long)mm->pgd - IDENT_ADDR) >> PAGE_SHIFT;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29059-linux-2.5.74-bk4/include/asm-arm/mmu_context.h .29059-linux-2.5.74-bk4.updated/include/asm-arm/mmu_context.h
--- .29059-linux-2.5.74-bk4/include/asm-arm/mmu_context.h	2003-02-07 19:21:15.000000000 +1100
+++ .29059-linux-2.5.74-bk4.updated/include/asm-arm/mmu_context.h	2003-07-07 11:51:59.000000000 +1000
@@ -28,7 +28,7 @@
  * tsk->mm will be NULL
  */
 static inline void
-enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk, unsigned cpu)
+enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
 }
 
@@ -40,7 +40,7 @@ enter_lazy_tlb(struct mm_struct *mm, str
  */
 static inline void
 switch_mm(struct mm_struct *prev, struct mm_struct *next,
-	  struct task_struct *tsk, unsigned int cpu)
+	  struct task_struct *tsk)
 {
 	if (prev != next) {
 		cpu_switch_mm(next->pgd, next);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29059-linux-2.5.74-bk4/include/asm-arm26/mmu_context.h .29059-linux-2.5.74-bk4.updated/include/asm-arm26/mmu_context.h
--- .29059-linux-2.5.74-bk4/include/asm-arm26/mmu_context.h	2003-06-15 11:30:06.000000000 +1000
+++ .29059-linux-2.5.74-bk4.updated/include/asm-arm26/mmu_context.h	2003-07-07 11:51:59.000000000 +1000
@@ -26,7 +26,7 @@
  * tsk->mm will be NULL
  */
 static inline void
-enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk, unsigned cpu)
+enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
 }
 
@@ -36,7 +36,7 @@ enter_lazy_tlb(struct mm_struct *mm, str
  */
 static inline void
 switch_mm(struct mm_struct *prev, struct mm_struct *next,
-	  struct task_struct *tsk, unsigned int cpu)
+	  struct task_struct *tsk)
 {
 	cpu_switch_mm(next->pgd, next);
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29059-linux-2.5.74-bk4/include/asm-cris/mmu_context.h .29059-linux-2.5.74-bk4.updated/include/asm-cris/mmu_context.h
--- .29059-linux-2.5.74-bk4/include/asm-cris/mmu_context.h	2003-02-07 19:21:15.000000000 +1100
+++ .29059-linux-2.5.74-bk4.updated/include/asm-cris/mmu_context.h	2003-07-07 11:51:59.000000000 +1000
@@ -5,11 +5,11 @@ extern int init_new_context(struct task_
 extern void get_mmu_context(struct mm_struct *mm);
 extern void destroy_context(struct mm_struct *mm);
 extern void switch_mm(struct mm_struct *prev, struct mm_struct *next,
-		      struct task_struct *tsk, int cpu);
+		      struct task_struct *tsk);
 
 #define deactivate_mm(tsk,mm)	do { } while (0)
 
-#define activate_mm(prev,next) switch_mm((prev),(next),NULL,smp_processor_id())
+#define activate_mm(prev,next) switch_mm((prev),(next),NULL)
 
 /* current active pgd - this is similar to other processors pgd 
  * registers like cr3 on the i386
@@ -17,7 +17,7 @@ extern void switch_mm(struct mm_struct *
 
 extern volatile pgd_t *current_pgd;   /* defined in arch/cris/mm/fault.c */
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk, unsigned cpu)
+static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29059-linux-2.5.74-bk4/include/asm-h8300/mmu_context.h .29059-linux-2.5.74-bk4.updated/include/asm-h8300/mmu_context.h
--- .29059-linux-2.5.74-bk4/include/asm-h8300/mmu_context.h	2003-04-20 18:05:12.000000000 +1000
+++ .29059-linux-2.5.74-bk4.updated/include/asm-h8300/mmu_context.h	2003-07-07 11:51:59.000000000 +1000
@@ -6,7 +6,7 @@
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk, unsigned cpu)
+static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
 }
 
@@ -20,7 +20,7 @@ init_new_context(struct task_struct *tsk
 #define destroy_context(mm)		do { } while(0)
 #define deactivate_mm(tsk,mm)           do { } while(0)
 
-static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, struct task_struct *tsk, unsigned cpu)
+static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, struct task_struct *tsk)
 {
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29059-linux-2.5.74-bk4/include/asm-i386/mmu_context.h .29059-linux-2.5.74-bk4.updated/include/asm-i386/mmu_context.h
--- .29059-linux-2.5.74-bk4/include/asm-i386/mmu_context.h	2003-05-27 15:02:19.000000000 +1000
+++ .29059-linux-2.5.74-bk4.updated/include/asm-i386/mmu_context.h	2003-07-07 11:51:59.000000000 +1000
@@ -14,16 +14,21 @@ int init_new_context(struct task_struct 
 void destroy_context(struct mm_struct *mm);
 
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk, unsigned cpu)
+static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
 #ifdef CONFIG_SMP
+	unsigned cpu = smp_processor_id();
 	if (cpu_tlbstate[cpu].state == TLBSTATE_OK)
 		cpu_tlbstate[cpu].state = TLBSTATE_LAZY;	
 #endif
 }
 
-static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, struct task_struct *tsk, unsigned cpu)
+static inline void switch_mm(struct mm_struct *prev,
+			     struct mm_struct *next,
+			     struct task_struct *tsk)
 {
+	int cpu = smp_processor_id();
+
 	if (likely(prev != next)) {
 		/* stop flush ipis for the previous mm */
 		clear_bit(cpu, &prev->cpu_vm_mask);
@@ -62,6 +67,6 @@ static inline void switch_mm(struct mm_s
 	asm("movl %0,%%fs ; movl %0,%%gs": :"r" (0))
 
 #define activate_mm(prev, next) \
-	switch_mm((prev),(next),NULL,smp_processor_id())
+	switch_mm((prev),(next),NULL)
 
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29059-linux-2.5.74-bk4/include/asm-ia64/mmu_context.h .29059-linux-2.5.74-bk4.updated/include/asm-ia64/mmu_context.h
--- .29059-linux-2.5.74-bk4/include/asm-ia64/mmu_context.h	2003-02-11 14:26:15.000000000 +1100
+++ .29059-linux-2.5.74-bk4.updated/include/asm-ia64/mmu_context.h	2003-07-07 11:51:59.000000000 +1000
@@ -71,7 +71,7 @@ DECLARE_PER_CPU(u8, ia64_need_tlb_flush)
 extern void wrap_mmu_context (struct mm_struct *mm);
 
 static inline void
-enter_lazy_tlb (struct mm_struct *mm, struct task_struct *tsk, unsigned cpu)
+enter_lazy_tlb (struct mm_struct *mm, struct task_struct *tsk)
 {
 }
 
@@ -198,7 +198,7 @@ activate_mm (struct mm_struct *prev, str
 	activate_context(next);
 }
 
-#define switch_mm(prev_mm,next_mm,next_task,cpu)	activate_mm(prev_mm, next_mm)
+#define switch_mm(prev_mm,next_mm,next_task)	activate_mm(prev_mm, next_mm)
 
 # endif /* ! __ASSEMBLY__ */
 #endif /* _ASM_IA64_MMU_CONTEXT_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29059-linux-2.5.74-bk4/include/asm-m68k/mmu_context.h .29059-linux-2.5.74-bk4.updated/include/asm-m68k/mmu_context.h
--- .29059-linux-2.5.74-bk4/include/asm-m68k/mmu_context.h	2003-02-07 19:22:28.000000000 +1100
+++ .29059-linux-2.5.74-bk4.updated/include/asm-m68k/mmu_context.h	2003-07-07 11:52:00.000000000 +1000
@@ -3,7 +3,7 @@
 
 #include <linux/config.h>
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk, unsigned cpu)
+static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
 }
 
@@ -79,7 +79,7 @@ extern inline void switch_mm_0460(struct
 	asm volatile (".chip 68k");
 }
 
-static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, struct task_struct *tsk, unsigned cpu)
+static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, struct task_struct *tsk)
 {
 	if (prev != next) {
 		if (CPU_IS_020_OR_030)
@@ -137,7 +137,7 @@ static inline void activate_context(stru
 	sun3_put_context(mm->context);
 }
 
-static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, struct task_struct *tsk, unsigned cpu)
+static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, struct task_struct *tsk)
 {
 	activate_context(tsk->mm);
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29059-linux-2.5.74-bk4/include/asm-m68knommu/mmu_context.h .29059-linux-2.5.74-bk4.updated/include/asm-m68knommu/mmu_context.h
--- .29059-linux-2.5.74-bk4/include/asm-m68knommu/mmu_context.h	2003-02-07 19:21:15.000000000 +1100
+++ .29059-linux-2.5.74-bk4.updated/include/asm-m68knommu/mmu_context.h	2003-07-07 11:52:00.000000000 +1000
@@ -6,7 +6,7 @@
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk, unsigned cpu)
+static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
 }
 
@@ -19,7 +19,7 @@ init_new_context(struct task_struct *tsk
 
 #define destroy_context(mm)		do { } while(0)
 
-static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, struct task_struct *tsk, unsigned cpu)
+static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, struct task_struct *tsk)
 {
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29059-linux-2.5.74-bk4/include/asm-mips/mmu_context.h .29059-linux-2.5.74-bk4.updated/include/asm-mips/mmu_context.h
--- .29059-linux-2.5.74-bk4/include/asm-mips/mmu_context.h	2003-07-03 09:43:56.000000000 +1000
+++ .29059-linux-2.5.74-bk4.updated/include/asm-mips/mmu_context.h	2003-07-07 11:52:00.000000000 +1000
@@ -49,7 +49,7 @@ extern unsigned long pgd_current[];
 #define cpu_asid(cpu, mm)	(cpu_context((cpu), (mm)) & ASID_MASK)
 #define asid_cache(cpu)		(cpu_data[cpu].asid_cache)
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk, unsigned cpu)
+static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
 }
 
@@ -92,9 +92,10 @@ init_new_context(struct task_struct *tsk
 }
 
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
-                             struct task_struct *tsk, unsigned cpu)
+                             struct task_struct *tsk)
 {
 	unsigned long flags;
+	unsigned cpu = smp_processor_id();
 
 	local_irq_save(flags);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29059-linux-2.5.74-bk4/include/asm-mips64/mmu_context.h .29059-linux-2.5.74-bk4.updated/include/asm-mips64/mmu_context.h
--- .29059-linux-2.5.74-bk4/include/asm-mips64/mmu_context.h	2003-07-03 09:43:58.000000000 +1000
+++ .29059-linux-2.5.74-bk4.updated/include/asm-mips64/mmu_context.h	2003-07-07 11:52:00.000000000 +1000
@@ -40,7 +40,7 @@ extern unsigned long pgd_current[];
 #define cpu_asid(cpu, mm)	(cpu_context((cpu), (mm)) & ASID_MASK)
 #define asid_cache(cpu)		(cpu_data[cpu].asid_cache)
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk, unsigned cpu)
+static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29059-linux-2.5.74-bk4/include/asm-parisc/mmu_context.h .29059-linux-2.5.74-bk4.updated/include/asm-parisc/mmu_context.h
--- .29059-linux-2.5.74-bk4/include/asm-parisc/mmu_context.h	2003-02-07 19:21:15.000000000 +1100
+++ .29059-linux-2.5.74-bk4.updated/include/asm-parisc/mmu_context.h	2003-07-07 11:52:00.000000000 +1000
@@ -6,7 +6,7 @@
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk, unsigned cpu)
+static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
 }
 
@@ -43,7 +43,7 @@ static inline void load_context(mm_conte
 #endif
 }
 
-static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, struct task_struct *tsk, unsigned cpu)
+static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, struct task_struct *tsk)
 {
 
 	if (prev != next) {
@@ -69,6 +69,6 @@ static inline void activate_mm(struct mm
 	if (next->context == 0)
 	    next->context = alloc_sid();
 
-	switch_mm(prev,next,current,0);
+	switch_mm(prev,next,current);
 }
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29059-linux-2.5.74-bk4/include/asm-ppc/mmu_context.h .29059-linux-2.5.74-bk4.updated/include/asm-ppc/mmu_context.h
--- .29059-linux-2.5.74-bk4/include/asm-ppc/mmu_context.h	2003-06-15 11:30:07.000000000 +1000
+++ .29059-linux-2.5.74-bk4.updated/include/asm-ppc/mmu_context.h	2003-07-07 11:52:00.000000000 +1000
@@ -48,7 +48,7 @@
    	-- Dan
  */
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk, unsigned cpu)
+static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
 }
 
@@ -153,7 +153,7 @@ static inline void destroy_context(struc
 }
 
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
-			     struct task_struct *tsk, int cpu)
+			     struct task_struct *tsk)
 {
 	tsk->thread.pgdir = next->pgd;
 	get_mmu_context(next);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29059-linux-2.5.74-bk4/include/asm-ppc64/mmu_context.h .29059-linux-2.5.74-bk4.updated/include/asm-ppc64/mmu_context.h
--- .29059-linux-2.5.74-bk4/include/asm-ppc64/mmu_context.h	2003-02-07 19:21:15.000000000 +1100
+++ .29059-linux-2.5.74-bk4.updated/include/asm-ppc64/mmu_context.h	2003-07-07 11:52:00.000000000 +1000
@@ -56,7 +56,7 @@ struct mmu_context_queue_t {
 extern struct mmu_context_queue_t mmu_context_queue;
 
 static inline void
-enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk, unsigned cpu)
+enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
 }
 
@@ -140,10 +140,10 @@ extern void flush_stab(struct task_struc
  */
 static inline void
 switch_mm(struct mm_struct *prev, struct mm_struct *next,
-	  struct task_struct *tsk, int cpu)
+	  struct task_struct *tsk)
 {
 	flush_stab(tsk, next);
-	set_bit(cpu, &next->cpu_vm_mask);
+	set_bit(smp_processor_id(), &next->cpu_vm_mask);
 }
 
 #define deactivate_mm(tsk,mm)	do { } while (0)
@@ -153,7 +153,7 @@ switch_mm(struct mm_struct *prev, struct
  * the context for the new mm so we see the new mappings.
  */
 #define activate_mm(active_mm, mm) \
-	switch_mm(active_mm, mm, current, smp_processor_id());
+	switch_mm(active_mm, mm, current);
 
 #define VSID_RANDOMIZER 42470972311
 #define VSID_MASK	0xfffffffff
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29059-linux-2.5.74-bk4/include/asm-s390/mmu_context.h .29059-linux-2.5.74-bk4.updated/include/asm-s390/mmu_context.h
--- .29059-linux-2.5.74-bk4/include/asm-s390/mmu_context.h	2003-04-20 18:05:13.000000000 +1000
+++ .29059-linux-2.5.74-bk4.updated/include/asm-s390/mmu_context.h	2003-07-07 11:52:00.000000000 +1000
@@ -17,12 +17,12 @@
 #define destroy_context(mm)             flush_tlb_mm(mm)
 
 static inline void enter_lazy_tlb(struct mm_struct *mm,
-                                  struct task_struct *tsk, unsigned cpu)
+                                  struct task_struct *tsk)
 {
 }
 
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
-                             struct task_struct *tsk, unsigned cpu)
+                             struct task_struct *tsk)
 {
         unsigned long pgd;
 
@@ -42,7 +42,7 @@ static inline void switch_mm(struct mm_s
                              : : "m" (pgd) );
 #endif /* __s390x__ */
         }
-	set_bit(cpu, &next->cpu_vm_mask);
+	set_bit(smp_processor_id(), &next->cpu_vm_mask);
 }
 
 #define deactivate_mm(tsk,mm)	do { } while (0)
@@ -50,7 +50,7 @@ static inline void switch_mm(struct mm_s
 extern inline void activate_mm(struct mm_struct *prev,
                                struct mm_struct *next)
 {
-        switch_mm(prev, next, current, smp_processor_id());
+        switch_mm(prev, next, current);
 }
 
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29059-linux-2.5.74-bk4/include/asm-sh/mmu_context.h .29059-linux-2.5.74-bk4.updated/include/asm-sh/mmu_context.h
--- .29059-linux-2.5.74-bk4/include/asm-sh/mmu_context.h	2003-07-03 09:43:59.000000000 +1000
+++ .29059-linux-2.5.74-bk4.updated/include/asm-sh/mmu_context.h	2003-07-07 11:52:00.000000000 +1000
@@ -129,7 +129,7 @@ static __inline__ void activate_context(
    (Currently not used) */
 static __inline__ void switch_mm(struct mm_struct *prev,
 				 struct mm_struct *next,
-				 struct task_struct *tsk, unsigned int cpu)
+				 struct task_struct *tsk)
 {
 	if (likely(prev != next)) {
 		unsigned long __pgdir = (unsigned long)next->pgd;
@@ -144,10 +144,10 @@ static __inline__ void switch_mm(struct 
 #define deactivate_mm(tsk,mm)	do { } while (0)
 
 #define activate_mm(prev, next) \
-	switch_mm((prev),(next),NULL,smp_processor_id())
+	switch_mm((prev),(next),NULL)
 
 static __inline__ void
-enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk, unsigned cpu)
+enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
 }
 #else /* !CONFIG_MMU */
@@ -157,10 +157,10 @@ enter_lazy_tlb(struct mm_struct *mm, str
 #define set_asid(asid)			do { } while (0)
 #define get_asid()			(0)
 #define activate_context(mm)		do { } while (0)
-#define switch_mm(prev,next,tsk,cpu)	do { } while (0)
+#define switch_mm(prev,next,tsk)	do { } while (0)
 #define deactivate_mm(tsk,mm)		do { } while (0)
 #define activate_mm(prev,next)		do { } while (0)
-#define enter_lazy_tlb(mm,tsk,cpu)	do { } while (0)
+#define enter_lazy_tlb(mm,tsk)		do { } while (0)
 #endif /* CONFIG_MMU */
 
 #if defined(CONFIG_CPU_SH3) || defined(CONFIG_CPU_SH4)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29059-linux-2.5.74-bk4/include/asm-sparc/mmu_context.h .29059-linux-2.5.74-bk4.updated/include/asm-sparc/mmu_context.h
--- .29059-linux-2.5.74-bk4/include/asm-sparc/mmu_context.h	2003-02-07 19:21:15.000000000 +1100
+++ .29059-linux-2.5.74-bk4.updated/include/asm-sparc/mmu_context.h	2003-07-07 11:52:00.000000000 +1000
@@ -5,7 +5,7 @@
 
 #ifndef __ASSEMBLY__
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk, unsigned cpu)
+static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
 }
 
@@ -26,14 +26,14 @@ BTFIXUPDEF_CALL(void, destroy_context, s
 #define destroy_context(mm) BTFIXUP_CALL(destroy_context)(mm)
 
 /* Switch the current MM context. */
-BTFIXUPDEF_CALL(void, switch_mm, struct mm_struct *, struct mm_struct *, struct task_struct *, int)
+BTFIXUPDEF_CALL(void, switch_mm, struct mm_struct *, struct mm_struct *, struct task_struct *)
 
-#define switch_mm(old_mm, mm, tsk, cpu) BTFIXUP_CALL(switch_mm)(old_mm, mm, tsk, cpu)
+#define switch_mm(old_mm, mm, tsk) BTFIXUP_CALL(switch_mm)(old_mm, mm, tsk)
 
 #define deactivate_mm(tsk,mm)	do { } while (0)
 
 /* Activate a new MM instance for the current task. */
-#define activate_mm(active_mm, mm) switch_mm((active_mm), (mm), NULL, smp_processor_id())
+#define activate_mm(active_mm, mm) switch_mm((active_mm), (mm), NULL)
 
 #endif /* !(__ASSEMBLY__) */
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29059-linux-2.5.74-bk4/include/asm-sparc64/mmu_context.h .29059-linux-2.5.74-bk4.updated/include/asm-sparc64/mmu_context.h
--- .29059-linux-2.5.74-bk4/include/asm-sparc64/mmu_context.h	2003-02-07 19:21:15.000000000 +1100
+++ .29059-linux-2.5.74-bk4.updated/include/asm-sparc64/mmu_context.h	2003-07-07 11:52:00.000000000 +1000
@@ -27,7 +27,7 @@
 #include <asm/system.h>
 #include <asm/spitfire.h>
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk, unsigned cpu)
+static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
 }
 
@@ -106,7 +106,7 @@ do { \
 extern void __flush_tlb_mm(unsigned long, unsigned long);
 
 /* Switch the current MM context. */
-static inline void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm, struct task_struct *tsk, int cpu)
+static inline void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm, struct task_struct *tsk)
 {
 	unsigned long ctx_valid;
 
@@ -125,7 +125,7 @@ static inline void switch_mm(struct mm_s
 	}
 
 	{
-		unsigned long vm_mask = (1UL << cpu);
+		unsigned long vm_mask = (1UL << smp_processor_id());
 
 		/* Even if (mm == old_mm) we _must_ check
 		 * the cpu_vm_mask.  If we do not we could
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29059-linux-2.5.74-bk4/include/asm-um/mmu_context.h .29059-linux-2.5.74-bk4.updated/include/asm-um/mmu_context.h
--- .29059-linux-2.5.74-bk4/include/asm-um/mmu_context.h	2003-02-07 19:21:15.000000000 +1100
+++ .29059-linux-2.5.74-bk4.updated/include/asm-um/mmu_context.h	2003-07-07 11:52:00.000000000 +1000
@@ -21,8 +21,10 @@ static inline void activate_mm(struct mm
 extern void switch_mm_skas(int mm_fd);
 
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, 
-			     struct task_struct *tsk, unsigned cpu)
+			     struct task_struct *tsk)
 {
+	unsigned cpu = smp_processor_id();
+
 	if(prev != next){
 		clear_bit(cpu, &prev->cpu_vm_mask);
 		set_bit(cpu, &next->cpu_vm_mask);
@@ -33,7 +35,7 @@ static inline void switch_mm(struct mm_s
 }
 
 static inline void enter_lazy_tlb(struct mm_struct *mm, 
-				  struct task_struct *tsk, unsigned cpu)
+				  struct task_struct *tsk)
 {
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29059-linux-2.5.74-bk4/include/asm-v850/mmu_context.h .29059-linux-2.5.74-bk4.updated/include/asm-v850/mmu_context.h
--- .29059-linux-2.5.74-bk4/include/asm-v850/mmu_context.h	2003-02-07 19:21:15.000000000 +1100
+++ .29059-linux-2.5.74-bk4.updated/include/asm-v850/mmu_context.h	2003-07-07 11:52:00.000000000 +1000
@@ -3,9 +3,9 @@
 
 #define destroy_context(mm)		((void)0)
 #define init_new_context(tsk,mm)	0
-#define switch_mm(prev,next,tsk,cpu)	((void)0)
+#define switch_mm(prev,next,tsk)	((void)0)
 #define deactivate_mm(tsk,mm)		do { } while (0)
 #define activate_mm(prev,next)		((void)0)
-#define enter_lazy_tlb(mm,tsk,cpu)	((void)0)
+#define enter_lazy_tlb(mm,tsk)		((void)0)
 
 #endif /* __V850_MMU_CONTEXT_H__ */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29059-linux-2.5.74-bk4/include/asm-x86_64/mmu_context.h .29059-linux-2.5.74-bk4.updated/include/asm-x86_64/mmu_context.h
--- .29059-linux-2.5.74-bk4/include/asm-x86_64/mmu_context.h	2003-02-07 19:22:28.000000000 +1100
+++ .29059-linux-2.5.74-bk4.updated/include/asm-x86_64/mmu_context.h	2003-07-07 11:52:00.000000000 +1000
@@ -17,20 +17,21 @@ void destroy_context(struct mm_struct *m
 
 #ifdef CONFIG_SMP
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk, unsigned cpu)
+static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
 	if (read_pda(mmu_state) == TLBSTATE_OK) 
 		write_pda(mmu_state, TLBSTATE_LAZY);
 }
 #else
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk, unsigned cpu)
+static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
 }
 #endif
 
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, 
-			     struct task_struct *tsk, unsigned cpu)
+			     struct task_struct *tsk)
 {
+	unsigned cpu = smp_processor_id();
 	if (likely(prev != next)) {
 		/* stop flush ipis for the previous mm */
 		clear_bit(cpu, &prev->cpu_vm_mask);
@@ -68,7 +69,7 @@ static inline void switch_mm(struct mm_s
 } while(0)
 
 #define activate_mm(prev, next) \
-	switch_mm((prev),(next),NULL,smp_processor_id())
+	switch_mm((prev),(next),NULL)
 
 
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29059-linux-2.5.74-bk4/kernel/exit.c .29059-linux-2.5.74-bk4.updated/kernel/exit.c
--- .29059-linux-2.5.74-bk4/kernel/exit.c	2003-07-07 10:47:47.000000000 +1000
+++ .29059-linux-2.5.74-bk4.updated/kernel/exit.c	2003-07-07 11:52:00.000000000 +1000
@@ -443,7 +443,7 @@ static inline void __exit_mm(struct task
 	/* more a memory barrier than a real lock */
 	task_lock(tsk);
 	tsk->mm = NULL;
-	enter_lazy_tlb(mm, current, smp_processor_id());
+	enter_lazy_tlb(mm, current);
 	task_unlock(tsk);
 	mmput(mm);
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29059-linux-2.5.74-bk4/kernel/sched.c .29059-linux-2.5.74-bk4.updated/kernel/sched.c
--- .29059-linux-2.5.74-bk4/kernel/sched.c	2003-07-03 09:44:01.000000000 +1000
+++ .29059-linux-2.5.74-bk4.updated/kernel/sched.c	2003-07-07 11:52:00.000000000 +1000
@@ -646,9 +646,9 @@ static inline task_t * context_switch(ru
 	if (unlikely(!mm)) {
 		next->active_mm = oldmm;
 		atomic_inc(&oldmm->mm_count);
-		enter_lazy_tlb(oldmm, next, smp_processor_id());
+		enter_lazy_tlb(oldmm, next);
 	} else
-		switch_mm(oldmm, mm, next, smp_processor_id());
+		switch_mm(oldmm, mm, next);
 
 	if (unlikely(!prev->mm)) {
 		prev->active_mm = NULL;
@@ -2527,7 +2527,7 @@ void __init sched_init(void)
 	 * The boot idle thread does lazy MMU switching as well:
 	 */
 	atomic_inc(&init_mm.mm_count);
-	enter_lazy_tlb(&init_mm, current, smp_processor_id());
+	enter_lazy_tlb(&init_mm, current);
 }
 
 #ifdef CONFIG_DEBUG_SPINLOCK_SLEEP

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
