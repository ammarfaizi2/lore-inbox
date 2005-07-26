Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbVGZUdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbVGZUdF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 16:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbVGZUdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 16:33:04 -0400
Received: from mtaout2.barak.net.il ([212.150.49.172]:27975 "EHLO
	mtaout2.barak.net.il") by vger.kernel.org with ESMTP
	id S261885AbVGZUcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 16:32:24 -0400
Date: Tue, 26 Jul 2005 23:36:04 +0300
From: eliad lubovsky <eliadl@013.net>
Subject: thread_info and kernel mode stack
To: linux-kernel@vger.kernel.org
Message-id: <1122410164.3524.72.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2)
Content-type: multipart/mixed; boundary="=-WC8yt3haBu/tP+PECycj"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WC8yt3haBu/tP+PECycj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
I am trying to work in a special configuration where the thread_info is
above the stack pointer. The SP though, start from the 
base stack address + THREAD_SIZE - THREAD_INFO_SECTION_SIZE (that is 128
bytes). 
The INIT_TSS macro looks like:
.esp0           = sizeof(init_stack)-THREAD_INFO_SECTION_SIZE +
(long)&init_stack,      \
So far it works.


When I am trying to move the init_thread_info to the top of the stack
the computer restart itself. What I am doing is replacing the union of
the init_thread_info with the following structure:

-union thread_union {
-        struct thread_info thread_info;
-        unsigned long stack[THREAD_SIZE/sizeof(long)];
-};

+struct thread_union {
+unsigned stack[(THREAD_SIZE-THREAD_INFO_SECTION_SIZE)/sizeof(long)];
+        struct thread_info thread_info;
+};

it means that when I am referencing the thread_info it is in offset
(THREAD_SIZE-THREAD_INFO_SECTION_SIZE)/sizeof(long) and not the base
address as it was when declared with a union.

I have changed other relevant places as in fork.c and so, although the
computer even doesn't start, I think its related to the init thread.
any clues?

-- 
Eliad

--=-WC8yt3haBu/tP+PECycj
Content-Disposition: attachment; filename=ti_and_stack.patch
Content-Type: text/x-patch; name=ti_and_stack.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -urNp linux-2.6.9.orig/arch/i386/kernel/head.S linux-2.6.9.changes/arch/i386/kernel/head.S
--- linux-2.6.9.orig/arch/i386/kernel/head.S	2004-10-18 23:53:13.000000000 +0200
+++ linux-2.6.9.changes/arch/i386/kernel/head.S	2005-07-26 15:42:20.000000000 +0300
@@ -425,7 +425,7 @@ ENTRY(empty_zero_page)
 .data
 
 ENTRY(stack_start)
-	.long init_thread_union+THREAD_SIZE
+        .long init_thread_union+THREAD_SIZE-THREAD_INFO_SECTION_SIZE
 	.long __BOOT_DS
 
 ready:	.byte 0
diff -urNp linux-2.6.9.orig/arch/i386/kernel/init_task.c linux-2.6.9.changes/arch/i386/kernel/init_task.c
--- linux-2.6.9.orig/arch/i386/kernel/init_task.c	2004-10-18 23:55:28.000000000 +0200
+++ linux-2.6.9.changes/arch/i386/kernel/init_task.c	2005-07-26 22:56:29.036709328 +0300
@@ -25,9 +25,7 @@ EXPORT_SYMBOL(init_mm);
  * way process stacks are handled. This is done by having a special
  * "init_task" linker map entry..
  */
-union thread_union init_thread_union 
-	__attribute__((__section__(".data.init_task"))) =
-		{ INIT_THREAD_INFO(init_task) };
+struct thread_union init_thread_union = { {0}, INIT_THREAD_INFO(init_task) };
 
 /*
  * Initial task structure.
diff -urNp linux-2.6.9.orig/arch/i386/kernel/process.c linux-2.6.9.changes/arch/i386/kernel/process.c
--- linux-2.6.9.orig/arch/i386/kernel/process.c	2004-10-18 23:53:05.000000000 +0200
+++ linux-2.6.9.changes/arch/i386/kernel/process.c	2005-07-26 22:55:42.853730208 +0300
@@ -364,7 +364,7 @@ int copy_thread(int nr, unsigned long cl
 	struct task_struct *tsk;
 	int err;
 
-	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
+        childregs = ((struct pt_regs *) ((THREAD_SIZE-THREAD_INFO_SECTION_SIZE) + (unsigned long) p->thread_info)) - 1;
 	*childregs = *regs;
 	childregs->eax = 0;
 	childregs->esp = esp;
@@ -665,8 +665,8 @@ out:
 	return error;
 }
 
-#define top_esp                (THREAD_SIZE - sizeof(unsigned long))
-#define top_ebp                (THREAD_SIZE - 2*sizeof(unsigned long))
+#define top_esp                ((THREAD_SIZE-THREAD_INFO_SECTION_SIZE) - sizeof(unsigned long))
+#define top_ebp                ((THREAD_SIZE-THREAD_INFO_SECTION_SIZE) - 2*sizeof(unsigned long))
 
 unsigned long get_wchan(struct task_struct *p)
 {
diff -urNp linux-2.6.9.orig/drivers/char/ip2main.c linux-2.6.9.changes/drivers/char/ip2main.c
--- linux-2.6.9.orig/drivers/char/ip2main.c	2004-10-18 23:55:36.000000000 +0200
+++ linux-2.6.9.changes/drivers/char/ip2main.c	2004-10-18 23:55:36.000000000 +0200
@@ -1179,7 +1179,7 @@ ip2_interrupt_bh(i2eBordStrPtr pB)
 /* Parameters: irq - interrupt number                                         */
 /*             pointer to optional device ID structure                        */
 /*             pointer to register structure                                  */
-/* Returns:    Nothing              $                                         */
+/* Returns:    Nothing                                                        */
 /*                                                                            */
 /* Description:                                                               */
 /*                                                                            */
diff -urNp linux-2.6.9.orig/include/asm-i386/processor.h linux-2.6.9.changes/include/asm-i386/processor.h
--- linux-2.6.9.orig/include/asm-i386/processor.h	2004-10-18 23:53:07.000000000 +0200
+++ linux-2.6.9.changes/include/asm-i386/processor.h	2005-07-26 15:43:30.000000000 +0300
@@ -450,7 +450,7 @@ struct thread_struct {
  * be within the limit.
  */
 #define INIT_TSS  {							\
-	.esp0		= sizeof(init_stack) + (long)&init_stack,	\
+	.esp0		= sizeof(init_stack)-THREAD_INFO_SECTION_SIZE + (long)&init_stack,	\
 	.ss0		= __KERNEL_DS,					\
 	.ss1		= __KERNEL_CS,					\
 	.ldt		= GDT_ENTRY_LDT,				\
diff -urNp linux-2.6.9.orig/include/asm-i386/thread_info.h linux-2.6.9.changes/include/asm-i386/thread_info.h
--- linux-2.6.9.orig/include/asm-i386/thread_info.h	2004-10-18 23:53:21.000000000 +0200
+++ linux-2.6.9.changes/include/asm-i386/thread_info.h	2005-07-26 23:08:59.000000000 +0300
@@ -51,11 +51,13 @@ struct thread_info {
 
 #endif
 
+#define THREAD_INFO_SECTION_SIZE	128
+
 #define PREEMPT_ACTIVE		0x4000000
 #ifdef CONFIG_4KSTACKS
 #define THREAD_SIZE            (4096)
 #else
-#define THREAD_SIZE		(8192)
+#define THREAD_SIZE		(4096)
 #endif
 
 #define STACK_WARN             (THREAD_SIZE/8)
@@ -88,6 +90,7 @@ static inline struct thread_info *curren
 {
 	struct thread_info *ti;
 	__asm__("andl %%esp,%0; ":"=r" (ti) : "0" (~(THREAD_SIZE - 1)));
+	ti = (struct thread_info *)((char*)(ti)+(THREAD_SIZE-THREAD_INFO_SECTION_SIZE));
 	return ti;
 }
 
diff -urNp linux-2.6.9.orig/include/linux/sched.h linux-2.6.9.changes/include/linux/sched.h
--- linux-2.6.9.orig/include/linux/sched.h	2004-10-18 23:53:13.000000000 +0200
+++ linux-2.6.9.changes/include/linux/sched.h	2005-07-26 23:07:30.000000000 +0300
@@ -654,9 +654,9 @@ void yield(void);
  */
 extern struct exec_domain	default_exec_domain;
 
-union thread_union {
+struct thread_union {
+	unsigned long stack[(THREAD_SIZE-THREAD_INFO_SECTION_SIZE)/sizeof(long)];
 	struct thread_info thread_info;
-	unsigned long stack[THREAD_SIZE/sizeof(long)];
 };
 
 #ifndef __HAVE_ARCH_KSTACK_END
@@ -669,7 +669,7 @@ static inline int kstack_end(void *addr)
 }
 #endif
 
-extern union thread_union init_thread_union;
+extern struct thread_union init_thread_union;
 extern struct task_struct init_task;
 
 extern struct   mm_struct init_mm;
diff -urNp linux-2.6.9.orig/kernel/fork.c linux-2.6.9.changes/kernel/fork.c
--- linux-2.6.9.orig/kernel/fork.c	2004-10-18 23:53:13.000000000 +0200
+++ linux-2.6.9.changes/kernel/fork.c	2005-07-26 23:06:24.000000000 +0300
@@ -79,7 +79,9 @@ static kmem_cache_t *task_struct_cachep;
 
 void free_task(struct task_struct *tsk)
 {
-	free_thread_info(tsk->thread_info);
+	void * tmp = (void*)(tsk->thread_info);
+	tmp -= (THREAD_SIZE - THREAD_INFO_SECTION_SIZE);
+	free_thread_info(tmp);
 	free_task_struct(tsk);
 }
 EXPORT_SYMBOL(free_task);
@@ -270,6 +272,8 @@ static struct task_struct *dup_task_stru
 		return NULL;
 	}
 
+        ti = (struct thread_info*)((char*)ti + (THREAD_SIZE-THREAD_INFO_SECTION_SIZE));
+
 	*ti = *orig->thread_info;
 	*tsk = *orig;
 	tsk->thread_info = ti;

--=-WC8yt3haBu/tP+PECycj--

