Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVG1JKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVG1JKV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 05:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVG1JKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 05:10:17 -0400
Received: from mx1.elte.hu ([157.181.1.137]:10440 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261386AbVG1JKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 05:10:12 -0400
Date: Thu, 28 Jul 2005 11:09:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Keith Owens <kaos@ocs.com.au>
Cc: David.Mosberger@acm.org, Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Add prefetch switch stack hook in scheduler function
Message-ID: <20050728090948.GA24222@elte.hu>
References: <20050728074118.GA20581@elte.hu> <10613.1122538148@kao2.melbourne.sgi.com> <20050728081622.GA22025@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050728081622.GA22025@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> [...] If yes then we want to have something like:
> 
> 	prefetch(kernel_stack(next));
> 
> to make it more generic. By default kernel_stack(next) could be 
> next->thread_info (to make sure we prefetch something real). On e.g. 
> x86/x64, kernel_stack(next) should be something like next->thread.esp.

i.e. like the patch below. Boot-tested on x86. x86, x64 and ia64 have a 
real kernel_stack() implementation, the other architectures all return 
'next'. (I've also cleaned up a couple of other things in the 
prefetch-next area, see the changelog below.)

Ken, would this patch generate a sufficient amount of prefetching on 
ia64?

	Ingo

-----
For architecture like ia64, the switch stack structure is fairly large
(currently 528 bytes).  For context switch intensive application, we
found that significant amount of cache misses occurs in switch_to()
function.  The following patch adds a hook in the schedule() function to
prefetch switch stack structure as soon as 'next' task is determined. 
This allows maximum overlap in prefetch cache lines for that structure.

Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

modifications:

- add a generic kernel_stack() function instead of a hook
- prefetch the next task's thread_info and kernel stack as well
- dont try to prefetch 'next' itself - we've already touched it
  so the cacheline is present.
- do the prefetching as early as possible

currently covered architectures: ia64, x86, x64. (Other architectures
will have to replace the default 'return task' in their kernel_stack()
implementations.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/asm-alpha/mmu_context.h     |    9 +++++++++
 include/asm-arm/mmu_context.h       |    9 +++++++++
 include/asm-arm26/mmu_context.h     |    9 +++++++++
 include/asm-cris/mmu_context.h      |    9 +++++++++
 include/asm-frv/mmu_context.h       |    9 +++++++++
 include/asm-h8300/mmu_context.h     |    9 +++++++++
 include/asm-i386/mmu_context.h      |    5 +++++
 include/asm-ia64/mmu_context.h      |    9 +++++++++
 include/asm-m32r/mmu_context.h      |    9 +++++++++
 include/asm-m68k/mmu_context.h      |    9 +++++++++
 include/asm-m68knommu/mmu_context.h |    9 +++++++++
 include/asm-mips/mmu_context.h      |    9 +++++++++
 include/asm-parisc/mmu_context.h    |   10 ++++++++++
 include/asm-ppc/mmu_context.h       |    9 +++++++++
 include/asm-ppc64/mmu_context.h     |    9 +++++++++
 include/asm-s390/mmu_context.h      |    9 +++++++++
 include/asm-sh/mmu_context.h        |    9 +++++++++
 include/asm-sh64/mmu_context.h      |    9 +++++++++
 include/asm-sparc/mmu_context.h     |    9 +++++++++
 include/asm-sparc64/mmu_context.h   |    9 +++++++++
 include/asm-um/mmu_context.h        |    9 +++++++++
 include/asm-v850/mmu_context.h      |    9 +++++++++
 include/asm-x86_64/mmu_context.h    |    9 +++++++++
 include/asm-xtensa/mmu_context.h    |    9 +++++++++
 kernel/sched.c                      |    9 ++++++++-
 25 files changed, 221 insertions(+), 1 deletion(-)

Index: linux/include/asm-alpha/mmu_context.h
===================================================================
--- linux.orig/include/asm-alpha/mmu_context.h
+++ linux/include/asm-alpha/mmu_context.h
@@ -258,4 +258,13 @@ enter_lazy_tlb(struct mm_struct *mm, str
 #undef __MMU_EXTERN_INLINE
 #endif
 
+/*
+ * Returns the current bottom of a task's kernel stack. Used
+ * by the scheduler to prefetch it.
+ */
+static inline void * kernel_stack(struct task_struct *task)
+{
+	return task;
+}
+
 #endif /* __ALPHA_MMU_CONTEXT_H */
Index: linux/include/asm-arm/mmu_context.h
===================================================================
--- linux.orig/include/asm-arm/mmu_context.h
+++ linux/include/asm-arm/mmu_context.h
@@ -93,4 +93,13 @@ switch_mm(struct mm_struct *prev, struct
 #define deactivate_mm(tsk,mm)	do { } while (0)
 #define activate_mm(prev,next)	switch_mm(prev, next, NULL)
 
+/*
+ * Returns the current bottom of a task's kernel stack. Used
+ * by the scheduler to prefetch it.
+ */
+static inline void * kernel_stack(struct task_struct *task)
+{
+	return task;
+}
+
 #endif
Index: linux/include/asm-arm26/mmu_context.h
===================================================================
--- linux.orig/include/asm-arm26/mmu_context.h
+++ linux/include/asm-arm26/mmu_context.h
@@ -48,4 +48,13 @@ static inline void activate_mm(struct mm
 	cpu_switch_mm(next->pgd, next);
 }
 
+/*
+ * Returns the current bottom of a task's kernel stack. Used
+ * by the scheduler to prefetch it.
+ */
+static inline void * kernel_stack(struct task_struct *task)
+{
+	return task;
+}
+
 #endif
Index: linux/include/asm-cris/mmu_context.h
===================================================================
--- linux.orig/include/asm-cris/mmu_context.h
+++ linux/include/asm-cris/mmu_context.h
@@ -21,4 +21,13 @@ static inline void enter_lazy_tlb(struct
 {
 }
 
+/*
+ * Returns the current bottom of a task's kernel stack. Used
+ * by the scheduler to prefetch it.
+ */
+static inline void * kernel_stack(struct task_struct *task)
+{
+	return task;
+}
+
 #endif
Index: linux/include/asm-frv/mmu_context.h
===================================================================
--- linux.orig/include/asm-frv/mmu_context.h
+++ linux/include/asm-frv/mmu_context.h
@@ -47,4 +47,13 @@ do {									\
 do {						\
 } while(0)
 
+/*
+ * Returns the current bottom of a task's kernel stack. Used
+ * by the scheduler to prefetch it.
+ */
+static inline void * kernel_stack(struct task_struct *task)
+{
+	return task;
+}
+
 #endif
Index: linux/include/asm-h8300/mmu_context.h
===================================================================
--- linux.orig/include/asm-h8300/mmu_context.h
+++ linux/include/asm-h8300/mmu_context.h
@@ -29,4 +29,13 @@ extern inline void activate_mm(struct mm
 {
 }
 
+/*
+ * Returns the current bottom of a task's kernel stack. Used
+ * by the scheduler to prefetch it.
+ */
+static inline void * kernel_stack(struct task_struct *task)
+{
+	return task;
+}
+
 #endif
Index: linux/include/asm-i386/mmu_context.h
===================================================================
--- linux.orig/include/asm-i386/mmu_context.h
+++ linux/include/asm-i386/mmu_context.h
@@ -69,4 +69,9 @@ static inline void switch_mm(struct mm_s
 #define activate_mm(prev, next) \
 	switch_mm((prev),(next),NULL)
 
+static inline void * kernel_stack(struct task_struct *task)
+{
+	return (void *) task->thread.esp;
+}
+
 #endif
Index: linux/include/asm-ia64/mmu_context.h
===================================================================
--- linux.orig/include/asm-ia64/mmu_context.h
+++ linux/include/asm-ia64/mmu_context.h
@@ -169,5 +169,14 @@ activate_mm (struct mm_struct *prev, str
 
 #define switch_mm(prev_mm,next_mm,next_task)	activate_mm(prev_mm, next_mm)
 
+/*
+ * Returns the current bottom of a task's kernel stack. Used
+ * by the scheduler to prefetch it.
+ */
+static inline void * kernel_stack(struct task_struct *task)
+{
+	return (void *) task->thread.ksp;
+}
+
 # endif /* ! __ASSEMBLY__ */
 #endif /* _ASM_IA64_MMU_CONTEXT_H */
Index: linux/include/asm-m32r/mmu_context.h
===================================================================
--- linux.orig/include/asm-m32r/mmu_context.h
+++ linux/include/asm-m32r/mmu_context.h
@@ -167,4 +167,13 @@ static inline void switch_mm(struct mm_s
 
 #endif /* __KERNEL__ */
 
+/*
+ * Returns the current bottom of a task's kernel stack. Used
+ * by the scheduler to prefetch it.
+ */
+static inline void * kernel_stack(struct task_struct *task)
+{
+	return task;
+}
+
 #endif /* _ASM_M32R_MMU_CONTEXT_H */
Index: linux/include/asm-m68k/mmu_context.h
===================================================================
--- linux.orig/include/asm-m68k/mmu_context.h
+++ linux/include/asm-m68k/mmu_context.h
@@ -150,5 +150,14 @@ static inline void activate_mm(struct mm
 	activate_context(next_mm);
 }
 
+/*
+ * Returns the current bottom of a task's kernel stack. Used
+ * by the scheduler to prefetch it.
+ */
+static inline void * kernel_stack(struct task_struct *task)
+{
+	return task;
+}
+
 #endif
 #endif
Index: linux/include/asm-m68knommu/mmu_context.h
===================================================================
--- linux.orig/include/asm-m68knommu/mmu_context.h
+++ linux/include/asm-m68knommu/mmu_context.h
@@ -30,4 +30,13 @@ extern inline void activate_mm(struct mm
 {
 }
 
+/*
+ * Returns the current bottom of a task's kernel stack. Used
+ * by the scheduler to prefetch it.
+ */
+static inline void * kernel_stack(struct task_struct *task)
+{
+	return task;
+}
+
 #endif
Index: linux/include/asm-mips/mmu_context.h
===================================================================
--- linux.orig/include/asm-mips/mmu_context.h
+++ linux/include/asm-mips/mmu_context.h
@@ -193,4 +193,13 @@ drop_mmu_context(struct mm_struct *mm, u
 	local_irq_restore(flags);
 }
 
+/*
+ * Returns the current bottom of a task's kernel stack. Used
+ * by the scheduler to prefetch it.
+ */
+static inline void * kernel_stack(struct task_struct *task)
+{
+	return task;
+}
+
 #endif /* _ASM_MMU_CONTEXT_H */
Index: linux/include/asm-parisc/mmu_context.h
===================================================================
--- linux.orig/include/asm-parisc/mmu_context.h
+++ linux/include/asm-parisc/mmu_context.h
@@ -70,4 +70,14 @@ static inline void activate_mm(struct mm
 
 	switch_mm(prev,next,current);
 }
+
+/*
+ * Returns the current bottom of a task's kernel stack. Used
+ * by the scheduler to prefetch it.
+ */
+static inline void * kernel_stack(struct task_struct *task)
+{
+	return task;
+}
+
 #endif
Index: linux/include/asm-ppc/mmu_context.h
===================================================================
--- linux.orig/include/asm-ppc/mmu_context.h
+++ linux/include/asm-ppc/mmu_context.h
@@ -195,5 +195,14 @@ static inline void switch_mm(struct mm_s
 
 extern void mmu_context_init(void);
 
+/*
+ * Returns the current bottom of a task's kernel stack. Used
+ * by the scheduler to prefetch it.
+ */
+static inline void * kernel_stack(struct task_struct *task)
+{
+	return task;
+}
+
 #endif /* __PPC_MMU_CONTEXT_H */
 #endif /* __KERNEL__ */
Index: linux/include/asm-ppc64/mmu_context.h
===================================================================
--- linux.orig/include/asm-ppc64/mmu_context.h
+++ linux/include/asm-ppc64/mmu_context.h
@@ -84,4 +84,13 @@ static inline void activate_mm(struct mm
 	local_irq_restore(flags);
 }
 
+/*
+ * Returns the current bottom of a task's kernel stack. Used
+ * by the scheduler to prefetch it.
+ */
+static inline void * kernel_stack(struct task_struct *task)
+{
+	return task;
+}
+
 #endif /* __PPC64_MMU_CONTEXT_H */
Index: linux/include/asm-s390/mmu_context.h
===================================================================
--- linux.orig/include/asm-s390/mmu_context.h
+++ linux/include/asm-s390/mmu_context.h
@@ -51,4 +51,13 @@ extern inline void activate_mm(struct mm
 	set_fs(current->thread.mm_segment);
 }
 
+/*
+ * Returns the current bottom of a task's kernel stack. Used
+ * by the scheduler to prefetch it.
+ */
+static inline void * kernel_stack(struct task_struct *task)
+{
+	return task;
+}
+
 #endif
Index: linux/include/asm-sh/mmu_context.h
===================================================================
--- linux.orig/include/asm-sh/mmu_context.h
+++ linux/include/asm-sh/mmu_context.h
@@ -202,5 +202,14 @@ static inline void disable_mmu(void)
 #define disable_mmu()	do { BUG(); } while (0)
 #endif
 
+/*
+ * Returns the current bottom of a task's kernel stack. Used
+ * by the scheduler to prefetch it.
+ */
+static inline void * kernel_stack(struct task_struct *task)
+{
+	return task;
+}
+
 #endif /* __KERNEL__ */
 #endif /* __ASM_SH_MMU_CONTEXT_H */
Index: linux/include/asm-sh64/mmu_context.h
===================================================================
--- linux.orig/include/asm-sh64/mmu_context.h
+++ linux/include/asm-sh64/mmu_context.h
@@ -206,4 +206,13 @@ enter_lazy_tlb(struct mm_struct *mm, str
 
 #endif	/* __ASSEMBLY__ */
 
+/*
+ * Returns the current bottom of a task's kernel stack. Used
+ * by the scheduler to prefetch it.
+ */
+static inline void * kernel_stack(struct task_struct *task)
+{
+	return task;
+}
+
 #endif /* __ASM_SH64_MMU_CONTEXT_H */
Index: linux/include/asm-sparc/mmu_context.h
===================================================================
--- linux.orig/include/asm-sparc/mmu_context.h
+++ linux/include/asm-sparc/mmu_context.h
@@ -37,4 +37,13 @@ BTFIXUPDEF_CALL(void, switch_mm, struct 
 
 #endif /* !(__ASSEMBLY__) */
 
+/*
+ * Returns the current bottom of a task's kernel stack. Used
+ * by the scheduler to prefetch it.
+ */
+static inline void * kernel_stack(struct task_struct *task)
+{
+	return task;
+}
+
 #endif /* !(__SPARC_MMU_CONTEXT_H) */
Index: linux/include/asm-sparc64/mmu_context.h
===================================================================
--- linux.orig/include/asm-sparc64/mmu_context.h
+++ linux/include/asm-sparc64/mmu_context.h
@@ -142,4 +142,13 @@ static inline void activate_mm(struct mm
 
 #endif /* !(__ASSEMBLY__) */
 
+/*
+ * Returns the current bottom of a task's kernel stack. Used
+ * by the scheduler to prefetch it.
+ */
+static inline void * kernel_stack(struct task_struct *task)
+{
+	return task;
+}
+
 #endif /* !(__SPARC64_MMU_CONTEXT_H) */
Index: linux/include/asm-um/mmu_context.h
===================================================================
--- linux.orig/include/asm-um/mmu_context.h
+++ linux/include/asm-um/mmu_context.h
@@ -66,6 +66,15 @@ static inline void destroy_context(struc
 	CHOOSE_MODE((void) 0, destroy_context_skas(mm));
 }
 
+/*
+ * Returns the current bottom of a task's kernel stack. Used
+ * by the scheduler to prefetch it.
+ */
+static inline void * kernel_stack(struct task_struct *task)
+{
+	return task;
+}
+
 #endif
 
 /*
Index: linux/include/asm-v850/mmu_context.h
===================================================================
--- linux.orig/include/asm-v850/mmu_context.h
+++ linux/include/asm-v850/mmu_context.h
@@ -8,4 +8,13 @@
 #define activate_mm(prev,next)		((void)0)
 #define enter_lazy_tlb(mm,tsk)		((void)0)
 
+/*
+ * Returns the current bottom of a task's kernel stack. Used
+ * by the scheduler to prefetch it.
+ */
+static inline void * kernel_stack(struct task_struct *task)
+{
+	return task;
+}
+
 #endif /* __V850_MMU_CONTEXT_H__ */
Index: linux/include/asm-x86_64/mmu_context.h
===================================================================
--- linux.orig/include/asm-x86_64/mmu_context.h
+++ linux/include/asm-x86_64/mmu_context.h
@@ -76,4 +76,13 @@ static inline void switch_mm(struct mm_s
 	switch_mm((prev),(next),NULL)
 
 
+/*
+ * Returns the current bottom of a task's kernel stack. Used
+ * by the scheduler to prefetch it.
+ */
+static inline void * kernel_stack(struct task_struct *task)
+{
+	return (void *) task->thread.rsp;
+}
+
 #endif
Index: linux/include/asm-xtensa/mmu_context.h
===================================================================
--- linux.orig/include/asm-xtensa/mmu_context.h
+++ linux/include/asm-xtensa/mmu_context.h
@@ -327,4 +327,13 @@ static inline void enter_lazy_tlb(struct
 
 }
 
+/*
+ * Returns the current bottom of a task's kernel stack. Used
+ * by the scheduler to prefetch it.
+ */
+static inline void * kernel_stack(struct task_struct *task)
+{
+	return task;
+}
+
 #endif /* _XTENSA_MMU_CONTEXT_H */
Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c
+++ linux/kernel/sched.c
@@ -2864,6 +2864,13 @@ go_idle:
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
 
+	/*
+	 * Cache-prefetch crutial memory areas of the next task,
+	 * its thread_info and its kernel stack:
+	 */
+	prefetch(next->thread_info);
+	prefetch(kernel_stack(next));
+
 	if (!rt_task(next) && next->activated > 0) {
 		unsigned long long delta = now - next->timestamp;
 		if (unlikely((long long)(now - next->timestamp) < 0))
@@ -2886,7 +2893,7 @@ go_idle:
 switch_tasks:
 	if (next == rq->idle)
 		schedstat_inc(rq, sched_goidle);
-	prefetch(next);
+
 	clear_tsk_need_resched(prev);
 	rcu_qsctr_inc(task_cpu(prev));
 
