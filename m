Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262733AbUKRLqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262733AbUKRLqx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 06:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbUKRLqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 06:46:53 -0500
Received: from mx1.elte.hu ([157.181.1.137]:24727 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262733AbUKRLqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 06:46:37 -0500
Date: Thu, 18 Nov 2004 13:46:56 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch, 2.6.10-rc2] fix __flush_tlb*() preemption bug on CONFIG_PREEMPT
Message-ID: <20041118124656.GA4256@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the PREEMPT_RT feature triggered another generic kernel PREEMPT bug on
x86 and x64: there exists a single-instruction race window in
__flush_tlb(), if the kernel preempts exactly there in a lazy-TLB thread
and certain other, rare scheduling and MM properties are true as well (a
certain constellation of threads and lazy-TLB kernel threads occured),
and the lazy-TLB task then gets another user TLB to inherit, and
switches to a task from which it inherited that new TLB, then the wrong
cr3 is loaded and inherited by this next, non-lazy-TLB next task; then
(and only then) this scenario would typically manifest itself in the
form of an infinite pagefault lockup occuring much after the fact, upon
the next userspace access.

i did a quick audit of how often __flush_tlb()s are done in preemptible
sections in the upstream kernel and the number is surprisingly high
(ioremap done from driver init, or copy_mm), so i think the attached
patch is the safest solution - disable preemption while flushing the
TLB. [We could perhaps add a non-preempt variant for e.g. use in the
scheduler, but that should be a separate patch.]

note that reproducing this bug was only possible under PREEMPT_RT (there
it can be triggered in 30 seconds, with the right reproducer) - it needs
a really unlikely scenario which PREEMPT_RT's high concurrency does
offer but which is apparently much harder to reproduce in the vanilla
kernel. The patch fixes x86 and x64. Other architectures are most likely
safe, but they need review as well.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/include/asm-i386/tlbflush.h.orig
+++ linux/include/asm-i386/tlbflush.h
@@ -5,15 +5,32 @@
 #include <linux/mm.h>
 #include <asm/processor.h>
 
+/*
+ * TLB-flush needs to be nonpreemptible on PREEMPT due to the
+ * following complex race scenario:
+ *
+ * if the current task is lazy-TLB and does a TLB flush and
+ * gets preempted after the movl %%r3, %0 but before the
+ * movl %0, %%cr3 then its ->active_mm might change and it will
+ * install the wrong cr3 when it switches back. This is not a
+ * problem for the lazy-TLB task itself, but if the next task it
+ * switches to has an ->mm that is also the lazy-TLB task's
+ * new ->active_mm, then the scheduler will assume that cr3 is
+ * the new one, while we overwrote it with the old one. The result
+ * is the wrong cr3 in the new (non-lazy-TLB) task, which typically
+ * causes an infinite pagefault upon the next userspace access.
+ */
 #define __flush_tlb()							\
 	do {								\
 		unsigned int tmpreg;					\
 									\
+		preempt_disable();					\
 		__asm__ __volatile__(					\
 			"movl %%cr3, %0;              \n"		\
 			"movl %0, %%cr3;  # flush TLB \n"		\
 			: "=r" (tmpreg)					\
 			:: "memory");					\
+		preempt_enable();					\
 	} while (0)
 
 /*
@@ -24,6 +41,7 @@
 	do {								\
 		unsigned int tmpreg;					\
 									\
+		preempt_disable();					\
 		__asm__ __volatile__(					\
 			"movl %1, %%cr4;  # turn off PGE     \n"	\
 			"movl %%cr3, %0;                     \n"	\
@@ -33,6 +51,7 @@
 			: "r" (mmu_cr4_features & ~X86_CR4_PGE),	\
 			  "r" (mmu_cr4_features)			\
 			: "memory");					\
+		preempt_enable();					\
 	} while (0)
 
 extern unsigned long pgkern_mask;
@@ -85,6 +104,13 @@ extern unsigned long pgkern_mask;
 
 static inline void flush_tlb_mm(struct mm_struct *mm)
 {
+	/*
+	 * This is safe on PREEMPT because if we preempt
+	 * right after the check but before the __flush_tlb(),
+	 * and if ->active_mm changes, then we might miss a
+	 * TLB flush, but that TLB flush happened already when
+	 * ->active_mm was changed:
+	 */
 	if (mm == current->active_mm)
 		__flush_tlb();
 }
--- linux/include/asm-x86_64/tlbflush.h.orig
+++ linux/include/asm-x86_64/tlbflush.h
@@ -9,11 +9,13 @@
 	do {								\
 		unsigned long tmpreg;					\
 									\
+		preempt_disable();					\
 		__asm__ __volatile__(					\
 			"movq %%cr3, %0;  # flush TLB \n"		\
 			"movq %0, %%cr3;              \n"		\
 			: "=r" (tmpreg)					\
 			:: "memory");					\
+		preempt_enable();					\
 	} while (0)
 
 /*
@@ -24,6 +26,7 @@
 	do {								\
 		unsigned long tmpreg;					\
 									\
+		preempt_disable();					\
 		__asm__ __volatile__(					\
 			"movq %1, %%cr4;  # turn off PGE     \n"	\
 			"movq %%cr3, %0;  # flush TLB        \n"	\
@@ -33,6 +36,7 @@
 			: "r" (mmu_cr4_features & ~X86_CR4_PGE),	\
 			  "r" (mmu_cr4_features)			\
 			: "memory");					\
+		preempt_enable();					\
 	} while (0)
 
 extern unsigned long pgkern_mask;
