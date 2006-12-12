Return-Path: <linux-kernel-owner+w=401wt.eu-S932510AbWLLWel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbWLLWel (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 17:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWLLWel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 17:34:41 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:1602 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932506AbWLLWeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 17:34:37 -0500
Date: Tue, 12 Dec 2006 14:34:35 -0800
Message-Id: <200612122234.kBCMYZD1023321@zach-dev.vmware.com>
Subject: [PATCH 2/5] Paravirt cpu batching.patch
From: Zachary Amsden <zach@vmware.com>
To: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 12 Dec 2006 22:34:36.0043 (UTC) FILETIME=[B3B8F5B0:01C71E3D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The VMI ROM has a mode where hypercalls can be queued and batched.  This turns
out to be a significant win during context switch, but must be done at a
specific point before side effects to CPU state are visible to subsequent
instructions.  This is similar to the MMU batching hooks already provided.
The same hooks could be used by the Xen backend to implement a context switch
multicall.

To explain a bit more about lazy modes in the paravirt patches, basically, the
idea is that only one of lazy CPU or MMU mode can be active at any given time.
Lazy MMU mode is similar to this lazy CPU mode, and allows for batching of
multiple PTE updates (say, inside a remap loop), but to avoid keeping some kind
of state machine about when to flush cpu or mmu updates, we just allow one or
the other to be active.  Although there is no real reason a more comprehensive
scheme could not be implemented, there is also no demonstrated need for this
extra complexity.

Signed-off-by: Zachary Amsden <zach@vmware.com>

diff -r 320f0d4d2280 arch/i386/kernel/paravirt.c
--- a/arch/i386/kernel/paravirt.c	Tue Dec 12 13:50:50 2006 -0800
+++ b/arch/i386/kernel/paravirt.c	Tue Dec 12 13:50:53 2006 -0800
@@ -545,6 +545,7 @@ struct paravirt_ops paravirt_ops = {
 	.apic_write_atomic = native_apic_write_atomic,
 	.apic_read = native_apic_read,
 #endif
+	.set_lazy_mode = (void *)native_nop,
 
 	.flush_tlb_user = native_flush_tlb,
 	.flush_tlb_kernel = native_flush_tlb_global,
diff -r 320f0d4d2280 arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c	Tue Dec 12 13:50:50 2006 -0800
+++ b/arch/i386/kernel/process.c	Tue Dec 12 13:50:53 2006 -0800
@@ -665,6 +665,37 @@ struct task_struct fastcall * __switch_t
 	load_TLS(next, cpu);
 
 	/*
+	 * Restore IOPL if needed.
+	 */
+	if (unlikely(prev->iopl != next->iopl))
+		set_iopl_mask(next->iopl);
+
+	/*
+	 * Now maybe handle debug registers and/or IO bitmaps
+	 */
+	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW)
+	    || test_tsk_thread_flag(prev_p, TIF_IO_BITMAP)))
+		__switch_to_xtra(next_p, tss);
+
+	/*
+	 * Leave lazy mode, flushing any hypercalls made here.
+	 * This must be done before restoring TLS segments so
+	 * the GDT and LDT are properly updated, and must be
+	 * done before math_state_restore, so the TS bit is up
+	 * to date.
+	 */
+	arch_leave_lazy_cpu_mode();
+
+	disable_tsc(prev_p, next_p);
+
+	/* If the task has used fpu the last 5 timeslices, just do a full
+	 * restore of the math state immediately to avoid the trap; the
+	 * chances of needing FPU soon are obviously high now
+	 */
+	if (next_p->fpu_counter > 5)
+		math_state_restore();
+
+	/*
 	 * Restore %fs if needed.
 	 *
 	 * Glibc normally makes %fs be zero.
@@ -673,22 +704,6 @@ struct task_struct fastcall * __switch_t
 		loadsegment(fs, next->fs);
 
 	write_pda(pcurrent, next_p);
-
-	/*
-	 * Now maybe handle debug registers and/or IO bitmaps
-	 */
-	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW)
-	    || test_tsk_thread_flag(prev_p, TIF_IO_BITMAP)))
-		__switch_to_xtra(next_p, tss);
-
-	disable_tsc(prev_p, next_p);
-
-	/* If the task has used fpu the last 5 timeslices, just do a full
-	 * restore of the math state immediately to avoid the trap; the
-	 * chances of needing FPU soon are obviously high now
-	 */
-	if (next_p->fpu_counter > 5)
-		math_state_restore();
 
 	return prev_p;
 }
diff -r 320f0d4d2280 include/asm-generic/pgtable.h
--- a/include/asm-generic/pgtable.h	Tue Dec 12 13:50:50 2006 -0800
+++ b/include/asm-generic/pgtable.h	Tue Dec 12 13:50:53 2006 -0800
@@ -183,6 +183,19 @@ static inline void ptep_set_wrprotect(st
 #endif
 
 /*
+ * A facility to provide batching of the reload of page tables with the
+ * actual context switch code for paravirtualized guests.  By convention,
+ * only one of the lazy modes (CPU, MMU) should be active at any given
+ * time, entry should never be nested, and entry and exits should always
+ * be paired.  This is for sanity of maintaining and reasoning about the
+ * kernel code.
+ */
+#ifndef __HAVE_ARCH_ENTER_LAZY_CPU_MODE
+#define arch_enter_lazy_cpu_mode()	do {} while (0)
+#define arch_leave_lazy_cpu_mode()	do {} while (0)
+#endif
+
+/*
  * When walking page tables, get the address of the next boundary,
  * or the end address of the range if that comes earlier.  Although no
  * vma end wraps to 0, rounded up __boundary may wrap to 0 throughout.
diff -r 320f0d4d2280 include/asm-i386/paravirt.h
--- a/include/asm-i386/paravirt.h	Tue Dec 12 13:50:50 2006 -0800
+++ b/include/asm-i386/paravirt.h	Tue Dec 12 13:50:53 2006 -0800
@@ -146,6 +146,8 @@ struct paravirt_ops
 	void (fastcall *pmd_clear)(pmd_t *pmdp);
 #endif
 
+	void (fastcall *set_lazy_mode)(int mode);
+
 	/* These two are jmp to, not actually called. */
 	void (fastcall *irq_enable_sysexit)(void);
 	void (fastcall *iret)(void);
@@ -386,6 +388,19 @@ static inline void pmd_clear(pmd_t *pmdp
 }
 #endif
 
+/* Lazy mode for batching updates / context switch */
+#define PARAVIRT_LAZY_NONE 0
+#define PARAVIRT_LAZY_MMU  1
+#define PARAVIRT_LAZY_CPU  2
+
+#define  __HAVE_ARCH_ENTER_LAZY_CPU_MODE
+#define arch_enter_lazy_cpu_mode() paravirt_ops.set_lazy_mode(PARAVIRT_LAZY_CPU)
+#define arch_leave_lazy_cpu_mode() paravirt_ops.set_lazy_mode(PARAVIRT_LAZY_NONE)
+
+#define  __HAVE_ARCH_ENTER_LAZY_MMU_MODE
+#define arch_enter_lazy_mmu_mode() paravirt_ops.set_lazy_mode(PARAVIRT_LAZY_MMU)
+#define arch_leave_lazy_mmu_mode() paravirt_ops.set_lazy_mode(PARAVIRT_LAZY_NONE)
+
 /* These all sit in the .parainstructions section to tell us what to patch. */
 struct paravirt_patch {
 	u8 *instr; 		/* original instructions */
diff -r 320f0d4d2280 kernel/sched.c
--- a/kernel/sched.c	Tue Dec 12 13:50:50 2006 -0800
+++ b/kernel/sched.c	Tue Dec 12 13:50:53 2006 -0800
@@ -1833,6 +1833,13 @@ context_switch(struct rq *rq, struct tas
 	struct mm_struct *mm = next->mm;
 	struct mm_struct *oldmm = prev->active_mm;
 
+	/*
+	 * For paravirt, this is coupled with an exit in switch_to to
+	 * combine the page table reload and the switch backend into
+	 * one hypercall.
+	 */
+	arch_enter_lazy_cpu_mode();
+
 	if (!mm) {
 		next->active_mm = oldmm;
 		atomic_inc(&oldmm->mm_count);
