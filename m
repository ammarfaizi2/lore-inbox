Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283807AbRK3Vhh>; Fri, 30 Nov 2001 16:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283811AbRK3Vhc>; Fri, 30 Nov 2001 16:37:32 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:54021 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S283835AbRK3VhH>; Fri, 30 Nov 2001 16:37:07 -0500
Date: Fri, 30 Nov 2001 13:47:37 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: lkml <linux-kernel@vger.kernel.org>
cc: Shuji YAMAMURA <yamamura@flab.fujitsu.co.jp>
Subject: [PATCH] task_struct colouring ...
Message-ID: <Pine.LNX.4.40.0111301326160.1600-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Looking at both the Manfred and Fujitsu patches I propose this new version
for task struct colouring.
The patch from Manfred is too architecture dependent ( cr2 ) and storing
extra stuff in CPU registers is not IMHO a good idea.
This patch uses the basic idea of Fujitsu and improve it in two ways :

1) Speed

The patch from Fujitsu, besides other bitwise operations perform one store
( bad ) and one load memory access at every get current call :

 #define GET_CURRENT(reg) \
        movl $-8192, reg; \
        andl %esp, reg
        andl %esp, reg; \
        pushl reg; \
        shrl $13, reg; \
        andl $0x00000060, reg; \
        orl  0(%esp), reg; \
        addl $4, %esp

while this one perform only one load and less accessory ops :

 #define GET_CURRENT(reg) \
        movl $-8192, reg; \
        andl %esp, reg
        andl %esp, reg; \
        movl (reg), reg;

2) Code clarity

The patch from Fujitsu spread task pointer math through different files
while this one only inside arch/???/kernel/process.c :

struct task_struct *alloc_task_struct(void)
{
       unsigned long tskb = __get_free_pages(GFP_KERNEL, 1), tsk;
       tsk = tskb | ((tskb >> 13) & 0x00000060) | SMP_CACHE_BYTES;
       *(unsigned long *) tskb = tsk;
       return (struct task_struct *) tsk;
}

More, in finding the pointer directly at the base (SP & ~8191UL) makes it
easy for external programs ( ie gdb ) to seek the task_struct w/out
knowing the internal math that created it.
I've not benchmarked the patch yet, so help from guys with big SMP
machines and more L2 than the main memory I had in my PC until 5 years
ago, is welcome :)



PS: The patch is for x86 but it's architecture independence ( beside the
cache line size and bits ) will make it easy to port to other CPUs



- Davide




diff -Nru linux-2.5.0.vanilla/arch/i386/kernel/entry.S linux-2.5.0.chax/arch/i386/kernel/entry.S
--- linux-2.5.0.vanilla/arch/i386/kernel/entry.S	Fri Nov  2 17:18:49 2001
+++ linux-2.5.0.chax/arch/i386/kernel/entry.S	Fri Nov 30 11:13:46 2001
@@ -130,7 +130,8 @@

 #define GET_CURRENT(reg) \
 	movl $-8192, reg; \
-	andl %esp, reg
+	andl %esp, reg;	\
+	movl (reg), reg;

 ENTRY(lcall7)
 	pushfl			# We get a different stack layout with call gates,
@@ -144,7 +145,7 @@
 	movl %ecx,CS(%esp)	#
 	movl %esp,%ebx
 	pushl %ebx
-	andl $-8192,%ebx	# GET_CURRENT
+	GET_CURRENT(%ebx)
 	movl exec_domain(%ebx),%edx	# Get the execution domain
 	movl 4(%edx),%edx	# Get the lcall7 handler for the domain
 	pushl $0x7
@@ -165,7 +166,7 @@
 	movl %ecx,CS(%esp)	#
 	movl %esp,%ebx
 	pushl %ebx
-	andl $-8192,%ebx	# GET_CURRENT
+	GET_CURRENT(%ebx)
 	movl exec_domain(%ebx),%edx	# Get the execution domain
 	movl 4(%edx),%edx	# Get the lcall7 handler for the domain
 	pushl $0x27
diff -Nru linux-2.5.0.vanilla/arch/i386/kernel/init_task.c linux-2.5.0.chax/arch/i386/kernel/init_task.c
--- linux-2.5.0.vanilla/arch/i386/kernel/init_task.c	Mon Sep 17 15:29:09 2001
+++ linux-2.5.0.chax/arch/i386/kernel/init_task.c	Fri Nov 30 13:18:23 2001
@@ -20,7 +20,13 @@
  */
 union task_union init_task_union
 	__attribute__((__section__(".data.init_task"))) =
-		{ INIT_TASK(init_task_union.task) };
+		{
+			{
+				tskptr: (unsigned long) &init_task_union.x.task ,
+				__cachepad: { 0, },
+				task: INIT_TASK(init_task_union.x.task)
+			}
+		};

 /*
  * per-CPU TSS segments. Threads are completely 'soft' on Linux,
diff -Nru linux-2.5.0.vanilla/arch/i386/kernel/process.c linux-2.5.0.chax/arch/i386/kernel/process.c
--- linux-2.5.0.vanilla/arch/i386/kernel/process.c	Thu Oct  4 18:42:54 2001
+++ linux-2.5.0.chax/arch/i386/kernel/process.c	Fri Nov 30 13:12:46 2001
@@ -581,7 +581,7 @@
 {
 	struct pt_regs * childregs;

-	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p)) - 1;
+	childregs = ((struct pt_regs *) (THREAD_SIZE + ((unsigned long) p & ~8191UL))) - 1;
 	struct_cpy(childregs, regs);
 	childregs->eax = 0;
 	childregs->esp = esp;
@@ -821,3 +821,18 @@
 }
 #undef last_sched
 #undef first_sched
+
+
+struct task_struct *alloc_task_struct(void)
+{
+	unsigned long tskb = __get_free_pages(GFP_KERNEL, 1), tsk;
+	tsk = tskb | ((tskb >> 13) & 0x00000060) | SMP_CACHE_BYTES;
+	*(unsigned long *) tskb = tsk;
+	return (struct task_struct *) tsk;
+}
+
+void free_task_struct(struct task_struct *p)
+{
+	free_pages((unsigned long) (p) & ~8191UL, 1);
+}
+
diff -Nru linux-2.5.0.vanilla/arch/i386/lib/getuser.S linux-2.5.0.chax/arch/i386/lib/getuser.S
--- linux-2.5.0.vanilla/arch/i386/lib/getuser.S	Mon Jan 12 13:42:52 1998
+++ linux-2.5.0.chax/arch/i386/lib/getuser.S	Fri Nov 30 09:56:29 2001
@@ -29,6 +29,7 @@
 __get_user_1:
 	movl %esp,%edx
 	andl $0xffffe000,%edx
+	movl (%edx),%edx
 	cmpl addr_limit(%edx),%eax
 	jae bad_get_user
 1:	movzbl (%eax),%edx
@@ -42,6 +43,7 @@
 	movl %esp,%edx
 	jc bad_get_user
 	andl $0xffffe000,%edx
+	movl (%edx),%edx
 	cmpl addr_limit(%edx),%eax
 	jae bad_get_user
 2:	movzwl -1(%eax),%edx
@@ -55,6 +57,7 @@
 	movl %esp,%edx
 	jc bad_get_user
 	andl $0xffffe000,%edx
+	movl (%edx),%edx
 	cmpl addr_limit(%edx),%eax
 	jae bad_get_user
 3:	movl -3(%eax),%edx
diff -Nru linux-2.5.0.vanilla/include/asm-i386/current.h linux-2.5.0.chax/include/asm-i386/current.h
--- linux-2.5.0.vanilla/include/asm-i386/current.h	Fri Aug 14 16:35:22 1998
+++ linux-2.5.0.chax/include/asm-i386/current.h	Fri Nov 30 11:22:23 2001
@@ -5,9 +5,9 @@

 static inline struct task_struct * get_current(void)
 {
-	struct task_struct *current;
-	__asm__("andl %%esp,%0; ":"=r" (current) : "0" (~8191UL));
-	return current;
+	unsigned long *tskptr;
+	__asm__("andl %%esp,%0; ":"=r" (tskptr) : "0" (~8191UL));
+	return (struct task_struct *) *tskptr;
  }

 #define current get_current()
diff -Nru linux-2.5.0.vanilla/include/asm-i386/hw_irq.h linux-2.5.0.chax/include/asm-i386/hw_irq.h
--- linux-2.5.0.vanilla/include/asm-i386/hw_irq.h	Thu Nov 22 11:46:18 2001
+++ linux-2.5.0.chax/include/asm-i386/hw_irq.h	Fri Nov 30 12:11:16 2001
@@ -115,7 +115,8 @@

 #define GET_CURRENT \
 	"movl %esp, %ebx\n\t" \
-	"andl $-8192, %ebx\n\t"
+	"andl $-8192, %ebx\n\t" \
+	"movl (%ebx), %ebx\n\t"

 /*
  *	SMP has a few special interrupts for IPI messages
diff -Nru linux-2.5.0.vanilla/include/asm-i386/processor.h linux-2.5.0.chax/include/asm-i386/processor.h
--- linux-2.5.0.vanilla/include/asm-i386/processor.h	Thu Nov 22 11:46:19 2001
+++ linux-2.5.0.chax/include/asm-i386/processor.h	Fri Nov 30 13:06:00 2001
@@ -14,6 +14,7 @@
 #include <asm/types.h>
 #include <asm/sigcontext.h>
 #include <asm/cpufeature.h>
+#include <linux/kernel.h>
 #include <linux/cache.h>
 #include <linux/config.h>
 #include <linux/threads.h>
@@ -444,15 +445,18 @@
 }

 unsigned long get_wchan(struct task_struct *p);
-#define KSTK_EIP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)))[1019])
-#define KSTK_ESP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)))[1022])
+#define KSTK_EIP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk) & ~8191UL))[1019])
+#define KSTK_ESP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk) & ~8191UL))[1022])

 #define THREAD_SIZE (2*PAGE_SIZE)
-#define alloc_task_struct() ((struct task_struct *) __get_free_pages(GFP_KERNEL,1))
-#define free_task_struct(p) free_pages((unsigned long) (p), 1)
+
+
+extern struct task_struct *alloc_task_struct(void);
+extern void free_task_struct(struct task_struct *p);
+
 #define get_task_struct(tsk)      atomic_inc(&virt_to_page(tsk)->count)

-#define init_task	(init_task_union.task)
+#define init_task	(init_task_union.x.task)
 #define init_stack	(init_task_union.stack)

 struct microcode {
diff -Nru linux-2.5.0.vanilla/include/linux/sched.h linux-2.5.0.chax/include/linux/sched.h
--- linux-2.5.0.vanilla/include/linux/sched.h	Thu Nov 22 11:46:19 2001
+++ linux-2.5.0.chax/include/linux/sched.h	Fri Nov 30 13:07:19 2001
@@ -508,7 +508,11 @@
 #endif

 union task_union {
-	struct task_struct task;
+	struct {
+		unsigned long tskptr;
+		unsigned long __cachepad[SMP_CACHE_BYTES/sizeof(long) - 1];
+		struct task_struct task;
+	} x;
 	unsigned long stack[INIT_TASK_SIZE/sizeof(long)];
 };



