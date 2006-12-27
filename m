Return-Path: <linux-kernel-owner+w=401wt.eu-S932740AbWL0V2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932740AbWL0V2T (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 16:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932762AbWL0V2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 16:28:19 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:54387 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932740AbWL0V2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 16:28:18 -0500
Date: Wed, 27 Dec 2006 22:25:55 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rt] update kmap_atomic on !HIGHMEM
Message-ID: <20061227212555.GA14947@elte.hu>
References: <20061227193550.324850000@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061227193550.324850000@mvista.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> I got some scheduling while atomic on x86-64 , and since x86-64 
> doesn't seem to have HIGHMEM there's no workaround for kmap_atomic() .
> 
> This patch adds the same as i386 HIGHMEM for !HIGHMEM.

the problem is that this does not disable pagefaulting while 
kmap-atomic. Could you try the patch below, does it solve the assert?

	Ingo

------------------------->
Subject: [patch] clean up the page fault disabling logic
From: Ingo Molnar <mingo@elte.hu>

decouple the pagefault-disabled logic from the preempt count.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/arm/mm/fault.c     |    2 +-
 arch/i386/mm/fault.c    |    2 +-
 arch/mips/mm/fault.c    |    2 +-
 arch/powerpc/mm/fault.c |    2 +-
 arch/x86_64/mm/fault.c  |    2 +-
 include/linux/sched.h   |    1 +
 include/linux/uaccess.h |   33 +++------------------------------
 kernel/fork.c           |    1 +
 mm/memory.c             |   20 ++++++++++++++++++++
 9 files changed, 30 insertions(+), 35 deletions(-)

Index: linux/arch/arm/mm/fault.c
===================================================================
--- linux.orig/arch/arm/mm/fault.c
+++ linux/arch/arm/mm/fault.c
@@ -230,7 +230,7 @@ do_page_fault(unsigned long addr, unsign
 	 * If we're in an interrupt or have no user
 	 * context, we must not take the fault..
 	 */
-	if (in_atomic() || !mm)
+	if (in_atomic() || !mm || current->pagefault_disabled)
 		goto no_context;
 
 	/*
Index: linux/arch/i386/mm/fault.c
===================================================================
--- linux.orig/arch/i386/mm/fault.c
+++ linux/arch/i386/mm/fault.c
@@ -382,7 +382,7 @@ fastcall notrace void __kprobes do_page_
 	 * If we're in an interrupt, have no user context or are running in an
 	 * atomic region then we must not take the fault..
 	 */
-	if (in_atomic() || !mm)
+	if (in_atomic() || !mm || current->pagefault_disabled)
 		goto bad_area_nosemaphore;
 
 	/* When running in the kernel we expect faults to occur only to
Index: linux/arch/mips/mm/fault.c
===================================================================
--- linux.orig/arch/mips/mm/fault.c
+++ linux/arch/mips/mm/fault.c
@@ -69,7 +69,7 @@ asmlinkage void do_page_fault(struct pt_
 	 * If we're in an interrupt or have no user
 	 * context, we must not take the fault..
 	 */
-	if (in_atomic() || !mm)
+	if (in_atomic() || !mm || current->pagefault_disabled)
 		goto bad_area_nosemaphore;
 
 	down_read(&mm->mmap_sem);
Index: linux/arch/powerpc/mm/fault.c
===================================================================
--- linux.orig/arch/powerpc/mm/fault.c
+++ linux/arch/powerpc/mm/fault.c
@@ -196,7 +196,7 @@ int __kprobes notrace do_page_fault(stru
 	}
 #endif /* !(CONFIG_4xx || CONFIG_BOOKE)*/
 
-	if (in_atomic() || mm == NULL) {
+	if (in_atomic() || mm == NULL || current->pagefault_disabled) {
 		if (!user_mode(regs))
 			return SIGSEGV;
 		/* in_atomic() in user mode is really bad,
Index: linux/arch/x86_64/mm/fault.c
===================================================================
--- linux.orig/arch/x86_64/mm/fault.c
+++ linux/arch/x86_64/mm/fault.c
@@ -405,7 +405,7 @@ asmlinkage void __kprobes do_page_fault(
 	 * If we're in an interrupt or have no user
 	 * context, we must not take the fault..
 	 */
-	if (unlikely(in_atomic() || !mm))
+	if (unlikely(in_atomic() || !mm || current->pagefault_disabled))
 		goto bad_area_nosemaphore;
 
  again:
Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h
+++ linux/include/linux/sched.h
@@ -1147,6 +1147,7 @@ struct task_struct {
 	/* mutex deadlock detection */
 	struct mutex_waiter *blocked_on;
 #endif
+	int pagefault_disabled;
 #ifdef CONFIG_TRACE_IRQFLAGS
 	unsigned int irq_events;
 	int hardirqs_enabled;
Index: linux/include/linux/uaccess.h
===================================================================
--- linux.orig/include/linux/uaccess.h
+++ linux/include/linux/uaccess.h
@@ -6,37 +6,10 @@
 
 /*
  * These routines enable/disable the pagefault handler in that
- * it will not take any locks and go straight to the fixup table.
- *
- * They have great resemblance to the preempt_disable/enable calls
- * and in fact they are identical; this is because currently there is
- * no other way to make the pagefault handlers do this. So we do
- * disable preemption but we don't necessarily care about that.
+ * it will not take any MM locks and go straight to the fixup table.
  */
-static inline void pagefault_disable(void)
-{
-	inc_preempt_count();
-	/*
-	 * make sure to have issued the store before a pagefault
-	 * can hit.
-	 */
-	barrier();
-}
-
-static inline void pagefault_enable(void)
-{
-	/*
-	 * make sure to issue those last loads/stores before enabling
-	 * the pagefault handler again.
-	 */
-	barrier();
-	dec_preempt_count();
-	/*
-	 * make sure we do..
-	 */
-	barrier();
-	preempt_check_resched();
-}
+extern void pagefault_disable(void);
+extern void pagefault_enable(void);
 
 #ifndef ARCH_HAS_NOCACHE_UACCESS
 
Index: linux/kernel/fork.c
===================================================================
--- linux.orig/kernel/fork.c
+++ linux/kernel/fork.c
@@ -1128,6 +1128,7 @@ static struct task_struct *copy_process(
 	p->hardirq_context = 0;
 	p->softirq_context = 0;
 #endif
+	p->pagefault_disabled = 0;
 #ifdef CONFIG_LOCKDEP
 	p->lockdep_depth = 0; /* no locks held yet */
 	p->curr_chain_key = 0;
Index: linux/mm/memory.c
===================================================================
--- linux.orig/mm/memory.c
+++ linux/mm/memory.c
@@ -2481,6 +2481,26 @@ unlock:
 	return VM_FAULT_MINOR;
 }
 
+void pagefault_disable(void)
+{
+	current->pagefault_disabled++;
+	/*
+	 * make sure to have issued the store before a pagefault
+	 * can hit.
+	 */
+	barrier();
+}
+
+void pagefault_enable(void)
+{
+	/*
+	 * make sure to issue those last loads/stores before enabling
+	 * the pagefault handler again.
+	 */
+	barrier();
+	current->pagefault_disabled--;
+}
+
 /*
  * By the time we get here, we already hold the mm semaphore
  */
