Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263507AbUCPIFu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 03:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263506AbUCPIFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 03:05:50 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:1220 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S263507AbUCPIFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 03:05:42 -0500
Date: Tue, 16 Mar 2004 01:35:36 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>
Subject: [PATCH][2.6-mm] Fix 4G/4G w/ 8k+ stacks
Message-ID: <Pine.LNX.4.58.0403150401310.28447@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 4/4 code right now is setup for 8k stacks, this patch should allow for
arbitrary stack sizes. Some parts are rather ugly (e.g. STACK_PAGE_COUNT)
so (abusive too) comments are welcome.

I've tested it with 4k,8k and 16k stacks on UP and SMP, but i believe it
breaks with CONFIG_DEBUG_PAGEALLOC

Index: linux-2.6.4-mm2/include/asm-i386/fixmap.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.4-mm2/include/asm-i386/fixmap.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 fixmap.h
--- linux-2.6.4-mm2/include/asm-i386/fixmap.h	15 Mar 2004 05:53:41 -0000	1.1.1.1
+++ linux-2.6.4-mm2/include/asm-i386/fixmap.h	15 Mar 2004 16:01:20 -0000
@@ -115,10 +115,10 @@ extern void __set_fixmap (enum fixed_add
  * Leave one empty page between vmalloc'ed areas and
  * the start of the fixmap.
  *
- * IMPORTANT: dont change FIXADDR_TOP without adjusting KM_VSTACK0
- * and KM_VSTACK1 so that the virtual stack is 8K aligned.
+ * IMPORTANT: we have to align FIXADDR_TOP so that the virtual stack
+ * is THREAD_SIZE aligned.
  */
-#define FIXADDR_TOP	(0xffffe000UL)
+#define FIXADDR_TOP	(0xffffe000UL & ~(THREAD_SIZE-1))
 #define __FIXADDR_SIZE	(__end_of_permanent_fixed_addresses << PAGE_SHIFT)
 #define FIXADDR_START	(FIXADDR_TOP - __FIXADDR_SIZE)

Index: linux-2.6.4-mm2/include/asm-i386/kmap_types.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.4-mm2/include/asm-i386/kmap_types.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 kmap_types.h
--- linux-2.6.4-mm2/include/asm-i386/kmap_types.h	15 Mar 2004 05:53:41 -0000	1.1.1.1
+++ linux-2.6.4-mm2/include/asm-i386/kmap_types.h	15 Mar 2004 23:09:53 -0000
@@ -2,15 +2,16 @@
 #define _ASM_KMAP_TYPES_H

 #include <linux/config.h>
+#include <linux/thread_info.h>

 enum km_type {
 	/*
-	 * IMPORTANT: don't move these 3 entries, and only add entries in
-	 * pairs: the 4G/4G virtual stack must be 8K aligned on each cpu.
+	 * IMPORTANT: don't move these 3 entries, be wary when adding entries,
+	 * the 4G/4G virtual stack must be THREAD_SIZE aligned on each cpu.
 	 */
 	KM_BOUNCE_READ,
-	KM_VSTACK1,
-	KM_VSTACK0,
+	KM_VSTACK_BASE,
+	KM_VSTACK_TOP = KM_VSTACK_BASE + STACK_PAGE_COUNT-1,

 	KM_LDT_PAGE15,
 	KM_LDT_PAGE0 = KM_LDT_PAGE15 + 16-1,
@@ -30,8 +31,8 @@ enum km_type {
 	KM_SOFTIRQ0,
 	KM_SOFTIRQ1,
 	/*
-	 * Add new entries in pairs:
-	 * the 4G/4G virtual stack must be 8K aligned on each cpu.
+	 * Be wary when adding entries:
+	 * the 4G/4G virtual stack must be THREAD_SIZE aligned on each cpu.
 	 */
 	KM_TYPE_NR
 };
Index: linux-2.6.4-mm2/include/asm-i386/processor.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.4-mm2/include/asm-i386/processor.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 processor.h
--- linux-2.6.4-mm2/include/asm-i386/processor.h	15 Mar 2004 05:53:41 -0000	1.1.1.1
+++ linux-2.6.4-mm2/include/asm-i386/processor.h	15 Mar 2004 15:44:57 -0000
@@ -401,10 +401,16 @@ struct tss_struct {

 #define ARCH_MIN_TASKALIGN	16

+#ifdef CONFIG_4KSTACKS
+#define STACK_PAGE_COUNT	(4096/PAGE_SIZE)
+#else
+#define STACK_PAGE_COUNT	(8192/PAGE_SIZE)	/* THREAD_SIZE/PAGE_SIZE */
+#endif
+
 struct thread_struct {
 /* cached TLS descriptors. */
 	struct desc_struct tls_array[GDT_ENTRY_TLS_ENTRIES];
-	void *stack_page0, *stack_page1;
+	void *stack_page[STACK_PAGE_COUNT];
 	unsigned long	esp0;
 	unsigned long	sysenter_cs;
 	unsigned long	eip;
Index: linux-2.6.4-mm2/include/asm-i386/thread_info.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.4-mm2/include/asm-i386/thread_info.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 thread_info.h
--- linux-2.6.4-mm2/include/asm-i386/thread_info.h	15 Mar 2004 05:53:41 -0000	1.1.1.1
+++ linux-2.6.4-mm2/include/asm-i386/thread_info.h	15 Mar 2004 15:49:56 -0000
@@ -49,8 +49,10 @@ struct thread_info {
 #endif

 #define PREEMPT_ACTIVE		0x4000000
+
+/* if you change THREAD_SIZE here, don't forget to change STACK_PAGE_COUNT */
 #ifdef CONFIG_4KSTACKS
-#define THREAD_SIZE            (4096)
+#define THREAD_SIZE		(4096)
 #else
 #define THREAD_SIZE		(8192)
 #endif
Index: linux-2.6.4-mm2/arch/i386/kernel/entry_trampoline.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.4-mm2/arch/i386/kernel/entry_trampoline.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 entry_trampoline.c
--- linux-2.6.4-mm2/arch/i386/kernel/entry_trampoline.c	15 Mar 2004 05:53:30 -0000	1.1.1.1
+++ linux-2.6.4-mm2/arch/i386/kernel/entry_trampoline.c	15 Mar 2004 08:52:48 -0000
@@ -21,7 +21,9 @@ extern char __entry_tramp_start, __entry
 void __init init_entry_mappings(void)
 {
 #ifdef CONFIG_X86_HIGH_ENTRY
+
 	void *tramp;
+	int p;

 	/*
 	 * We need a high IDT and GDT for the 4G/4G split:
@@ -37,7 +39,7 @@ void __init init_entry_mappings(void)
 	/*
 	 * Virtual kernel stack:
 	 */
-	BUG_ON(__kmap_atomic_vaddr(KM_VSTACK0) & (THREAD_SIZE-1));
+	BUG_ON(__kmap_atomic_vaddr(KM_VSTACK_TOP) & (THREAD_SIZE-1));
 	BUG_ON(sizeof(struct desc_struct)*NR_CPUS*GDT_ENTRIES > 2*PAGE_SIZE);
 	BUG_ON((unsigned int)&__entry_tramp_end - (unsigned int)&__entry_tramp_start > 2*PAGE_SIZE);

@@ -45,15 +47,15 @@ void __init init_entry_mappings(void)
 	 * set up the initial thread's virtual stack related
 	 * fields:
 	 */
-	current->thread.stack_page0 = virt_to_page((char *)current->thread_info);
-	current->thread.stack_page1 = virt_to_page((char *)current->thread_info + PAGE_SIZE);
-	current->thread_info->virtual_stack = (void *)__kmap_atomic_vaddr(KM_VSTACK0);
-
-	__kunmap_atomic_type(KM_VSTACK0);
-	__kunmap_atomic_type(KM_VSTACK1);
-        __kmap_atomic(current->thread.stack_page0, KM_VSTACK0);
-        __kmap_atomic(current->thread.stack_page1, KM_VSTACK1);
+	for (p = 0; p < ARRAY_SIZE(current->thread.stack_page); p++)
+		current->thread.stack_page[p] = virt_to_page((char *)current->thread_info + (p*PAGE_SIZE));
+
+	current->thread_info->virtual_stack = (void *)__kmap_atomic_vaddr(KM_VSTACK_TOP);

+	for (p = 0; p < ARRAY_SIZE(current->thread.stack_page); p++) {
+		__kunmap_atomic_type(KM_VSTACK_TOP-p);
+		__kmap_atomic(current->thread.stack_page[p], KM_VSTACK_TOP-p);
+	}
 #endif
 	current->thread_info->real_stack = (void *)current->thread_info;
 	current->thread_info->user_pgd = NULL;
Index: linux-2.6.4-mm2/arch/i386/kernel/process.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.4-mm2/arch/i386/kernel/process.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 process.c
--- linux-2.6.4-mm2/arch/i386/kernel/process.c	15 Mar 2004 05:53:30 -0000	1.1.1.1
+++ linux-2.6.4-mm2/arch/i386/kernel/process.c	15 Mar 2004 08:08:42 -0000
@@ -345,7 +345,7 @@ int copy_thread(int nr, unsigned long cl
 {
 	struct pt_regs * childregs;
 	struct task_struct *tsk;
-	int err;
+	int err, i;

 	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
 	struct_cpy(childregs, regs);
@@ -360,10 +360,11 @@ int copy_thread(int nr, unsigned long cl
 	 * get the two stack pages, for the virtual stack.
 	 *
 	 * IMPORTANT: this code relies on the fact that the task
-	 * structure is an 8K aligned piece of physical memory.
+	 * structure is an THREAD_SIZE aligned piece of physical memory.
 	 */
-	p->thread.stack_page0 = virt_to_page((unsigned long)p->thread_info);
-	p->thread.stack_page1 = virt_to_page((unsigned long)p->thread_info + PAGE_SIZE);
+	for (i = 0; i < ARRAY_SIZE(p->thread.stack_page); i++)
+		p->thread.stack_page[i] =
+				virt_to_page((unsigned long)p->thread_info + (i*PAGE_SIZE));

 	p->thread.eip = (unsigned long) ret_from_fork;
 	p->thread_info->real_stack = p->thread_info;
@@ -519,22 +520,23 @@ struct task_struct fastcall * __switch_t
 	__unlazy_fpu(prev_p);

 #ifdef CONFIG_X86_HIGH_ENTRY
+{
+	int i;
 	/*
 	 * Set the ptes of the virtual stack. (NOTE: a one-page TLB flush is
 	 * needed because otherwise NMIs could interrupt the
 	 * user-return code with a virtual stack and stale TLBs.)
 	 */
-	__kunmap_atomic_type(KM_VSTACK0);
-	__kunmap_atomic_type(KM_VSTACK1);
-	__kmap_atomic(next->stack_page0, KM_VSTACK0);
-	__kmap_atomic(next->stack_page1, KM_VSTACK1);
-
+	for (i = 0; i < ARRAY_SIZE(next->stack_page); i++) {
+		__kunmap_atomic_type(KM_VSTACK_TOP-i);
+		__kmap_atomic(next->stack_page[i], KM_VSTACK_TOP-i);
+	}
 	/*
 	 * NOTE: here we rely on the task being the stack as well
 	 */
 	next_p->thread_info->virtual_stack =
-			(void *)__kmap_atomic_vaddr(KM_VSTACK0);
-
+			(void *)__kmap_atomic_vaddr(KM_VSTACK_TOP);
+}
 #if defined(CONFIG_PREEMPT) && defined(CONFIG_SMP)
 	/*
 	 * If next was preempted on entry from userspace to kernel,
