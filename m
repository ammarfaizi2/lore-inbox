Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbTEGUDH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 16:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264279AbTEGUDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 16:03:07 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:62718 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264275AbTEGUC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 16:02:59 -0400
Message-ID: <3EB96916.7080900@us.ibm.com>
Date: Wed, 07 May 2003 13:14:14 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: Jonathan Lundell <linux@lundell-bros.com>, root@chaos.analogic.com,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305071008080.11871@chaos> <p05210601badeeb31916c@[207.213.214.37]> <3EB957FA.4080900@us.ibm.com> <20030507200647.GB3166@wohnheim.fh-wedel.de>
Content-Type: multipart/mixed;
 boundary="------------060709060900080203000603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060709060900080203000603
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Jörn Engel wrote:
>>The stack overflow checking in -mjb uses gcc's mcount mechanism to
>>detect overflows.  It should get called on every single function call.
> 
> Nice trick.  Do you have better documentation on that machanism than
> man gcc?  The paragraph to -p is quite short and I cannot make the
> connection to the rest of the patch immediately.

It is a nice trick, but I didn't write it :)  I stole the code from Ben
LaHaise, around 2.5.20.  All that I've needed to know to maintain the
patch is that a "jmp mcount" gets placed in the critical places.

I've attached a fairly recent version of the stack check patch.  If you
need some more examples, check out kernprof's use of it.  It's acg
functionality used mcount as well.
-- 
Dave Hansen
haveblue@us.ibm.com

--------------060709060900080203000603
Content-Type: text/plain;
 name="C-stack_usage_check-2.5.59-8.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="C-stack_usage_check-2.5.59-8.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	irqstack-2.5.59-1 -> 1.962  
#	arch/i386/kernel/process.c	1.32.1.4 -> 1.40   
#	arch/i386/kernel/irq.c	1.23.1.2 -> 1.26   
#	            Makefile	1.344.2.13 -> 1.349  
#	include/asm-i386/thread_info.h	1.10.1.4 -> 1.16   
#	   arch/i386/Kconfig	1.13.2.22 -> 1.19   
#	arch/i386/kernel/entry.S	1.38.1.9 -> 1.53   
#	  arch/i386/Makefile	1.24.2.17 -> 1.33   
#	arch/i386/boot/compressed/misc.c	1.9.1.1 -> 1.12   
#	arch/i386/kernel/init_task.c	1.6.1.1 -> 1.8    
#	arch/i386/kernel/i386_ksyms.c	1.36.2.6 -> 1.44   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/01/27	haveblue@elm3b96.(none)	1.958.1.2
# import new irqstack patch
# covers BUILD_INTERRUPT, as well as common_interrupt
# --------------------------------------------
# 03/01/27	haveblue@elm3b96.(none)	1.961
# Merge elm3b96.(none):/work/dave/bk/linux-2.5-irq-stack
# into elm3b96.(none):/work/dave/bk/linux-2.5-irq-stack+overflow-detect
# --------------------------------------------
# 03/01/27	haveblue@elm3b96.(none)	1.962
# Merge elm3b96.(none):/work/dave/bk/linux-2.5-overflow-detect
# into elm3b96.(none):/work/dave/bk/linux-2.5-irq-stack+overflow-detect
# --------------------------------------------
#
diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Mon Jan 27 11:40:03 2003
+++ b/arch/i386/Kconfig	Mon Jan 27 11:40:03 2003
@@ -1624,6 +1624,25 @@
 	  If you don't debug the kernel, you can say N, but we may not be able
 	  to solve problems without frame pointers.
 
+config X86_STACK_CHECK
+	bool "Detect stack overflows"
+	depends on FRAME_POINTER
+	help
+	  Say Y here to have the kernel attempt to detect when the per-task
+	  kernel stack overflows.  This is much more robust checking than
+	  the above overflow check, which will only occasionally detect
+	  an overflow.  The level of guarantee here is much greater.
+	
+	  Some older versions of gcc don't handle the -p option correctly.  
+	  Kernprof is affected by the same problem, which is described here:
+	  http://oss.sgi.com/projects/kernprof/faq.html#Q9
+	
+	  Basically, if you get oopses in __free_pages_ok during boot when
+	  you have this turned on, you need to fix gcc.  The Redhat 2.96 
+	  version and gcc-3.x seem to work.  
+	
+	  If not debugging a stack overflow problem, say N
+
 config X86_EXTRA_IRQS
 	bool
 	depends on X86_LOCAL_APIC || X86_VOYAGER
diff -Nru a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	Mon Jan 27 11:40:03 2003
+++ b/arch/i386/Makefile	Mon Jan 27 11:40:03 2003
@@ -76,6 +76,10 @@
 # default subarch .h files
 mflags-y += -Iinclude/asm-i386/mach-default
 
+ifdef CONFIG_X86_STACK_CHECK
+CFLAGS += -p
+endif
+
 HEAD := arch/i386/kernel/head.o arch/i386/kernel/init_task.o
 
 libs-y 					+= arch/i386/lib/
diff -Nru a/arch/i386/boot/compressed/misc.c b/arch/i386/boot/compressed/misc.c
--- a/arch/i386/boot/compressed/misc.c	Mon Jan 27 11:40:03 2003
+++ b/arch/i386/boot/compressed/misc.c	Mon Jan 27 11:40:03 2003
@@ -377,3 +377,7 @@
 	if (high_loaded) close_output_buffer_if_we_run_high(mv);
 	return high_loaded;
 }
+
+/* We don't actually check for stack overflows this early. */
+__asm__(".globl mcount ; mcount: ret\n");
+
diff -Nru a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Mon Jan 27 11:40:03 2003
+++ b/arch/i386/kernel/entry.S	Mon Jan 27 11:40:03 2003
@@ -597,6 +597,61 @@
 	pushl $do_spurious_interrupt_bug
 	jmp error_code
 
+
+#ifdef CONFIG_X86_STACK_CHECK
+.data
+	.globl	stack_overflowed
+stack_overflowed:
+	.long	0
+.text
+
+ENTRY(mcount)
+	push %eax
+	movl $(THREAD_SIZE - 1),%eax
+	andl %esp,%eax
+	cmpl $STACK_WARN,%eax	/* more than half the stack is used*/
+	jle 1f
+2:
+	popl %eax
+	ret
+1:	
+	lock;   btsl    $0,stack_overflowed
+	jc      2b
+	
+	# switch to overflow stack
+	movl	%esp,%eax
+	movl	$(stack_overflow_stack + THREAD_SIZE - 4),%esp
+
+	pushf
+	cli
+	pushl	%eax
+
+	# push eip then esp of error for stack_overflow_panic
+	pushl	4(%eax)
+	pushl	%eax
+
+	# update the task pointer and cpu in the overflow stack's thread_info.
+	GET_THREAD_INFO_WITH_ESP(%eax)
+	movl	TI_TASK(%eax),%ebx
+	movl	%ebx,stack_overflow_stack+TI_TASK
+	movl	TI_CPU(%eax),%ebx
+	movl	%ebx,stack_overflow_stack+TI_CPU
+
+	call	stack_overflow
+
+	# pop off call arguments
+	addl	$8,%esp 
+
+	popl	%eax
+	popf
+	movl	%eax,%esp
+	popl	%eax
+	movl	$0,stack_overflowed
+	ret
+
+#warning stack check enabled
+#endif
+
 .data
 ENTRY(sys_call_table)
 	.long sys_restart_syscall	/* 0 - old "setup()" system call, used for restarting */
diff -Nru a/arch/i386/kernel/i386_ksyms.c b/arch/i386/kernel/i386_ksyms.c
--- a/arch/i386/kernel/i386_ksyms.c	Mon Jan 27 11:40:03 2003
+++ b/arch/i386/kernel/i386_ksyms.c	Mon Jan 27 11:40:03 2003
@@ -214,3 +214,8 @@
 EXPORT_SYMBOL(edd);
 EXPORT_SYMBOL(eddnr);
 #endif
+
+#ifdef CONFIG_X86_STACK_CHECK
+extern void mcount(void);
+EXPORT_SYMBOL(mcount);
+#endif
diff -Nru a/arch/i386/kernel/init_task.c b/arch/i386/kernel/init_task.c
--- a/arch/i386/kernel/init_task.c	Mon Jan 27 11:40:03 2003
+++ b/arch/i386/kernel/init_task.c	Mon Jan 27 11:40:03 2003
@@ -16,6 +16,10 @@
 union thread_union init_irq_union
 	__attribute__((__section__(".data.init_task")));
 
+#ifdef CONFIG_X86_STACK_CHECK
+union thread_union stack_overflow_stack
+	__attribute__((__section__(".data.init_task")));
+#endif
 
 /*
  * Initial thread structure.
diff -Nru a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c	Mon Jan 27 11:40:03 2003
+++ b/arch/i386/kernel/process.c	Mon Jan 27 11:40:03 2003
@@ -159,7 +159,22 @@
 
 __setup("idle=", idle_setup);
 
-void show_regs(struct pt_regs * regs)
+void stack_overflow(unsigned long esp, unsigned long eip)
+{
+	int panicing = ((esp&(THREAD_SIZE-1)) <= STACK_PANIC);
+
+	if (panicing)
+		print_symbol("stack overflow from %s\n", eip);
+	else
+		print_symbol("excessive stack use from %s\n", eip);
+	printk("esp: %p\n", (void*)esp);
+	show_trace((void*)esp);
+	
+	if (panicing)
+		panic("stack overflow\n");
+}
+
+asmlinkage void show_regs(struct pt_regs * regs)
 {
 	unsigned long cr0 = 0L, cr2 = 0L, cr3 = 0L, cr4 = 0L;
 
diff -Nru a/include/asm-i386/thread_info.h b/include/asm-i386/thread_info.h
--- a/include/asm-i386/thread_info.h	Mon Jan 27 11:40:03 2003
+++ b/include/asm-i386/thread_info.h	Mon Jan 27 11:40:03 2003
@@ -63,6 +63,8 @@
  */
 #define THREAD_ORDER 1 
 #define INIT_THREAD_SIZE       THREAD_SIZE
+#define STACK_PANIC		0x200ul
+#define STACK_WARN		((THREAD_SIZE)>>1)
 
 #ifndef __ASSEMBLY__
 

--------------060709060900080203000603--

