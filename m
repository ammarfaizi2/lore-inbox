Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263565AbTH2U4s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbTH2U4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:56:48 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:34771 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S263565AbTH2UzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:55:17 -0400
Date: Fri, 29 Aug 2003 21:56:59 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] 4G/4G preempt on vstack
Message-ID: <Pine.LNX.4.44.0308292151480.1816-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Repeated -j3 kernel builds, run in tandem on dual PIII, have been
collapsing recently on -mm with 4G/4G split, SMP and preemption.
Typically 'make' fails with Error 139 because 'as' or another
got SIGSEGV; maybe within ten minutes, maybe after ten hours.

This patch seems to fix that (ran successfully overnight on test4-mm1,
will run over the weekend on test4-mm3-1).  Please cast a critical eye
over it, I expect Ingo or someone else will find it can be improved.

The problem is that a task may be preempted just after it has entered
kernelspace, while using the transitional "virtual stack" i.e. %esp
pointing to high per-cpu kmap of the kernel stack.  If the task resumes
on another cpu, that %esp needs to be repointed into the new cpu's kmap.

The corresponding returns to userspace look okay to me: interrupts are
disabled over the critical points.  And in general no copy is taken of
%esp while on the virtual stack e.g. setting pointer to pt_regs is and
must be done after switching to real stack.  But there's one place in
__SWITCH_KERNELSPACE itself where we need to check and repeat if moved.

Hugh

--- 2.6.0-test4-mm3-1/arch/i386/kernel/entry.S	Fri Aug 29 16:31:30 2003
+++ linux/arch/i386/kernel/entry.S	Fri Aug 29 20:53:33 2003
@@ -103,6 +103,20 @@
 
 #ifdef CONFIG_X86_SWITCH_PAGETABLES
 
+#if defined(CONFIG_PREEMPT) && defined(CONFIG_SMP)
+/*
+ * If task is preempted in __SWITCH_KERNELSPACE, and moved to another cpu,
+ * __switch_to repoints %esp to the appropriate virtual stack; but %ebp is
+ * left stale, so we must check whether to repeat the real stack calculation.
+ */
+#define repeat_if_esp_changed				\
+	xorl %esp, %ebp;				\
+	testl $0xffffe000, %ebp;			\
+	jnz 0b
+#else
+#define repeat_if_esp_changed
+#endif
+
 /* clobbers ebx, edx and ebp */
 
 #define __SWITCH_KERNELSPACE				\
@@ -117,12 +131,13 @@
 	movl $swapper_pg_dir-__PAGE_OFFSET, %edx;	\
 							\
 	/* GET_THREAD_INFO(%ebp) intermixed */		\
-							\
+0:							\
 	movl %esp, %ebp;				\
 	movl %esp, %ebx;				\
 	andl $0xffffe000, %ebp;				\
 	andl $0x00001fff, %ebx;				\
 	orl TI_real_stack(%ebp), %ebx;			\
+	repeat_if_esp_changed;				\
 							\
 	movl %edx, %cr3;				\
 	movl %ebx, %esp;				\
--- 2.6.0-test4-mm3-1/arch/i386/kernel/process.c	Fri Aug 29 16:31:30 2003
+++ linux/arch/i386/kernel/process.c	Fri Aug 29 20:53:33 2003
@@ -479,13 +479,27 @@
 	__kmap_atomic(next->stack_page1, KM_VSTACK1);
 
 	/*
-	 * Reload esp0:
-	 */
-	/*
 	 * NOTE: here we rely on the task being the stack as well
 	 */
 	next_p->thread_info->virtual_stack = (void *)__kmap_atomic_vaddr(KM_VSTACK0);
+
+#if defined(CONFIG_PREEMPT) && defined(CONFIG_SMP)
+	/*
+	 * If next was preempted on entry from userspace to kernel,
+	 * and now it's on a different cpu, we need to adjust %esp.
+	 * This assumes that entry.S does not copy %esp while on the
+	 * virtual stack (with interrupts enabled): which is so,
+	 * except within __SWITCH_KERNELSPACE itself.
+	 */
+	if (unlikely(next->esp >= TASK_SIZE)) {
+		next->esp &= THREAD_SIZE - 1;
+		next->esp |= (unsigned long) next_p->thread_info->virtual_stack;
+	}
+#endif
 #endif
+	/*
+	 * Reload esp0:
+	 */
 	load_esp0(tss, virtual_esp0(next_p));
 
 	/*

