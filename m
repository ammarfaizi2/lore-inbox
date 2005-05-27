Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVE0BW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVE0BW5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 21:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVE0BLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 21:11:50 -0400
Received: from [151.97.230.9] ([151.97.230.9]:54289 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261475AbVE0BFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 21:05:25 -0400
Subject: [patch 7/8] uml: stack dump fix
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 27 May 2005 02:38:51 +0200
Message-Id: <20050527003851.CC5571AEE8E@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Copy (and adapt) to UML the stack code dumper used in i386 when
CONFIG_FRAME_POINTER is enabled.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/arch/um/include/sysrq.h      |    3 
 linux-2.6.12-paolo/arch/um/kernel/sysrq.c       |   21 ++++--
 linux-2.6.12-paolo/arch/um/sys-i386/sysrq.c     |   80 +++++++++++++++++++++++-
 linux-2.6.12-paolo/arch/um/sys-ppc/sysrq.c      |   14 ----
 linux-2.6.12-paolo/arch/um/sys-x86_64/sysrq.c   |   11 ---
 linux-2.6.12-paolo/include/asm-um/thread_info.h |    7 --
 6 files changed, 100 insertions(+), 36 deletions(-)

diff -puN arch/um/kernel/sysrq.c~uml-stack-dump-fix arch/um/kernel/sysrq.c
--- linux-2.6.12/arch/um/kernel/sysrq.c~uml-stack-dump-fix	2005-05-02 15:30:15.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/kernel/sysrq.c	2005-05-02 15:30:15.000000000 +0200
@@ -3,6 +3,7 @@
  * Licensed under the GPL
  */
 
+#include "linux/config.h"
 #include "linux/sched.h"
 #include "linux/kernel.h"
 #include "linux/module.h"
@@ -12,14 +13,14 @@
 #include "sysrq.h"
 #include "user_util.h"
 
-void show_trace(unsigned long * stack)
+/* Catch non-i386 SUBARCH's. */
+#if !defined(CONFIG_UML_X86) || defined(CONFIG_64BIT)
+void show_trace(struct task_struct *task, unsigned long * stack)
 {
-	/* XXX: Copy the CONFIG_FRAME_POINTER stack-walking backtrace from
-	 * arch/i386/kernel/traps.c, and then move this to sys-i386/sysrq.c.*/
         unsigned long addr;
 
         if (!stack) {
-                stack = (unsigned long*) &stack;
+		stack = (unsigned long*) &stack;
 		WARN_ON(1);
 	}
 
@@ -35,6 +36,7 @@ void show_trace(unsigned long * stack)
         }
         printk("\n");
 }
+#endif
 
 /*
  * stack dumps generator - this is used by arch-independent code.
@@ -44,7 +46,7 @@ void dump_stack(void)
 {
 	unsigned long stack;
 
-	show_trace(&stack);
+	show_trace(current, &stack);
 }
 EXPORT_SYMBOL(dump_stack);
 
@@ -59,7 +61,11 @@ void show_stack(struct task_struct *task
 	int i;
 
 	if (esp == NULL) {
-		if (task != current) {
+		if (task != current && task != NULL) {
+			/* XXX: Isn't this bogus? I.e. isn't this the
+			 * *userspace* stack of this task? If not so, use this
+			 * even when task == current (as in i386).
+			 */
 			esp = (unsigned long *) KSTK_ESP(task);
 			/* Which one? No actual difference - just coding style.*/
 			//esp = (unsigned long *) PT_REGS_IP(&task->thread.regs);
@@ -77,5 +83,6 @@ void show_stack(struct task_struct *task
 		printk("%08lx ", *stack++);
 	}
 
-	show_trace(esp);
+	printk("Call Trace: \n");
+	show_trace(current, esp);
 }
diff -puN arch/um/sys-i386/sysrq.c~uml-stack-dump-fix arch/um/sys-i386/sysrq.c
--- linux-2.6.12/arch/um/sys-i386/sysrq.c~uml-stack-dump-fix	2005-05-02 15:30:15.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/sys-i386/sysrq.c	2005-05-02 15:31:07.000000000 +0200
@@ -3,12 +3,15 @@
  * Licensed under the GPL
  */
 
+#include "linux/config.h"
 #include "linux/kernel.h"
 #include "linux/smp.h"
 #include "linux/sched.h"
+#include "linux/kallsyms.h"
 #include "asm/ptrace.h"
 #include "sysrq.h"
 
+/* This is declared by <linux/sched.h> */
 void show_regs(struct pt_regs *regs)
 {
         printk("\n");
@@ -31,5 +34,80 @@ void show_regs(struct pt_regs *regs)
 	       0xffff & PT_REGS_DS(regs), 
 	       0xffff & PT_REGS_ES(regs));
 
-        show_trace((unsigned long *) &regs);
+        show_trace(NULL, (unsigned long *) &regs);
 }
+
+/* Copied from i386. */
+static inline int valid_stack_ptr(struct thread_info *tinfo, void *p)
+{
+	return	p > (void *)tinfo &&
+		p < (void *)tinfo + THREAD_SIZE - 3;
+}
+
+/* Adapted from i386 (we also print the address we read from). */
+static inline unsigned long print_context_stack(struct thread_info *tinfo,
+				unsigned long *stack, unsigned long ebp)
+{
+	unsigned long addr;
+
+#ifdef CONFIG_FRAME_POINTER
+	while (valid_stack_ptr(tinfo, (void *)ebp)) {
+		addr = *(unsigned long *)(ebp + 4);
+		printk("%08lx:  [<%08lx>]", ebp + 4, addr);
+		print_symbol(" %s", addr);
+		printk("\n");
+		ebp = *(unsigned long *)ebp;
+	}
+#else
+	while (valid_stack_ptr(tinfo, stack)) {
+		addr = *stack;
+		if (__kernel_text_address(addr)) {
+			printk("%08lx:  [<%08lx>]", (unsigned long) stack, addr);
+			print_symbol(" %s", addr);
+			printk("\n");
+		}
+		stack++;
+	}
+#endif
+	return ebp;
+}
+
+void show_trace(struct task_struct* task, unsigned long * stack)
+{
+	unsigned long ebp;
+	struct thread_info *context;
+
+	/* Turn this into BUG_ON if possible. */
+	if (!stack) {
+		stack = (unsigned long*) &stack;
+		printk("show_trace: got NULL stack, implicit assumption task == current");
+		WARN_ON(1);
+	}
+
+	if (!task)
+		task = current;
+
+	if (task != current) {
+		//ebp = (unsigned long) KSTK_EBP(task);
+		/* Which one? No actual difference - just coding style.*/
+		ebp = (unsigned long) PT_REGS_EBP(&task->thread.regs);
+	} else {
+		asm ("movl %%ebp, %0" : "=r" (ebp) : );
+	}
+
+	context = (struct thread_info *)
+		((unsigned long)stack & (~(THREAD_SIZE - 1)));
+	print_context_stack(context, stack, ebp);
+
+	/*while (((long) stack & (THREAD_SIZE-1)) != 0) {
+		addr = *stack;
+		if (__kernel_text_address(addr)) {
+			printk("%08lx:	[<%08lx>]", (unsigned long) stack, addr);
+			print_symbol(" %s", addr);
+			printk("\n");
+		}
+		stack++;
+	}*/
+	printk("\n");
+}
+
diff -puN include/asm-um/thread_info.h~uml-stack-dump-fix include/asm-um/thread_info.h
--- linux-2.6.12/include/asm-um/thread_info.h~uml-stack-dump-fix	2005-05-02 15:30:15.000000000 +0200
+++ linux-2.6.12-paolo/include/asm-um/thread_info.h	2005-05-02 15:30:15.000000000 +0200
@@ -41,18 +41,17 @@ struct thread_info {
 #define init_thread_info	(init_thread_union.thread_info)
 #define init_stack		(init_thread_union.stack)
 
+#define THREAD_SIZE ((1 << CONFIG_KERNEL_STACK_ORDER) * PAGE_SIZE)
 /* how to get the thread information struct from C */
 static inline struct thread_info *current_thread_info(void)
 {
 	struct thread_info *ti;
-	unsigned long mask = PAGE_SIZE *
-		(1 << CONFIG_KERNEL_STACK_ORDER) - 1;
-        ti = (struct thread_info *) (((unsigned long) &ti) & ~mask);
+	unsigned long mask = THREAD_SIZE - 1;
+	ti = (struct thread_info *) (((unsigned long) &ti) & ~mask);
 	return ti;
 }
 
 /* thread information allocation */
-#define THREAD_SIZE ((1 << CONFIG_KERNEL_STACK_ORDER) * PAGE_SIZE)
 #define alloc_thread_info(tsk) \
 	((struct thread_info *) kmalloc(THREAD_SIZE, GFP_KERNEL))
 #define free_thread_info(ti) kfree(ti)
diff -puN arch/um/sys-x86_64/sysrq.c~uml-stack-dump-fix arch/um/sys-x86_64/sysrq.c
--- linux-2.6.12/arch/um/sys-x86_64/sysrq.c~uml-stack-dump-fix	2005-05-02 15:30:15.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/sys-x86_64/sysrq.c	2005-05-02 15:30:15.000000000 +0200
@@ -36,14 +36,5 @@ void __show_regs(struct pt_regs * regs)
 void show_regs(struct pt_regs *regs)
 {
 	__show_regs(regs);
-	show_trace((unsigned long *) &regs);
+	show_trace(current, (unsigned long *) &regs);
 }
-
-/* Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -puN arch/um/include/sysrq.h~uml-stack-dump-fix arch/um/include/sysrq.h
--- linux-2.6.12/arch/um/include/sysrq.h~uml-stack-dump-fix	2005-05-02 15:30:15.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/include/sysrq.h	2005-05-02 15:30:15.000000000 +0200
@@ -1,6 +1,7 @@
 #ifndef __UM_SYSRQ_H
 #define __UM_SYSRQ_H
 
-extern void show_trace(unsigned long *stack);
+struct task_struct;
+extern void show_trace(struct task_struct* task, unsigned long *stack);
 
 #endif
diff -puN arch/um/sys-ppc/sysrq.c~uml-stack-dump-fix arch/um/sys-ppc/sysrq.c
--- linux-2.6.12/arch/um/sys-ppc/sysrq.c~uml-stack-dump-fix	2005-05-02 15:30:15.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/sys-ppc/sysrq.c	2005-05-02 15:30:15.000000000 +0200
@@ -27,17 +27,5 @@ void show_regs(struct pt_regs_subarch *r
                 0xffff & regs->xds, 0xffff & regs->xes);
 #endif
 
-        show_trace(&regs->gpr[1]);
+        show_trace(current, &regs->gpr[1]);
 }
-
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
_
