Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266183AbSLIWDL>; Mon, 9 Dec 2002 17:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266186AbSLIWDK>; Mon, 9 Dec 2002 17:03:10 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:41385 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266183AbSLIWDH>; Mon, 9 Dec 2002 17:03:07 -0500
Message-ID: <3DF5149A.3010902@us.ibm.com>
Date: Mon, 09 Dec 2002 14:09:30 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: benh@kernel.crashing.org
CC: Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] (3/4) stack updates for x86
Content-Type: multipart/mixed;
 boundary="------------000202080807020303020804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000202080807020303020804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The kernel currently uses an 8k stack, per task.  Here is the
infrastructure needed to allow us to halve that.

C-stack_usage_check-2.5.50+bk-5.patch
	Check for stack overflows on entry to each funtion.  Use gcc's
	-p profiling feature to do it.

-- 
Dave Hansen
haveblue@us.ibm.com


--------------000202080807020303020804
Content-Type: text/plain;
 name="C-stack_usage_check-2.5.50+bk-5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="C-stack_usage_check-2.5.50+bk-5.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.860   -> 1.863  
#	arch/i386/kernel/process.c	1.32.1.3 -> 1.38   
#	arch/i386/kernel/irq.c	1.23.1.2 -> 1.26   
#	            Makefile	1.326.2.29 -> 1.333  
#	include/asm-i386/thread_info.h	1.10.1.1 -> 1.13   
#	   arch/i386/Kconfig	1.14    -> 1.15   
#	arch/i386/kernel/entry.S	1.38.1.6 -> 1.49   
#	  arch/i386/Makefile	1.24.2.7 -> 1.30   
#	arch/i386/boot/compressed/misc.c	1.9     -> 1.10   
#	arch/i386/kernel/init_task.c	1.6.1.1 -> 1.8    
#	arch/i386/kernel/i386_ksyms.c	1.36.2.4 -> 1.41   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/09	haveblue@elm3b96.(none)	1.797.163.2
# Kconfig:
#   update stack overflow detection for new config system
# --------------------------------------------
# 02/12/09	haveblue@elm3b96.(none)	1.859.1.1
# merge
# --------------------------------------------
# 02/12/09	haveblue@elm3b96.(none)	1.797.162.3
# merge
# --------------------------------------------
# 02/12/09	haveblue@elm3b96.(none)	1.861
# merge
# --------------------------------------------
# 02/12/09	haveblue@elm3b96.(none)	1.862
# Merge elm3b96.(none):/work/dave/bk/linux-2.5-overflow-detect
# into elm3b96.(none):/work/dave/bk/linux-2.5-irq-stack+overflow-detect
# --------------------------------------------
# 02/12/09	haveblue@elm3b96.(none)	1.863
# Makefile:
#   fix merge problem
#   f
# --------------------------------------------
#
diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Mon Dec  9 11:09:40 2002
+++ b/arch/i386/Kconfig	Mon Dec  9 11:09:40 2002
@@ -1628,6 +1628,25 @@
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
 	depends on X86_LOCAL_APIC
diff -Nru a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	Mon Dec  9 11:09:40 2002
+++ b/arch/i386/Makefile	Mon Dec  9 11:09:40 2002
@@ -52,6 +52,10 @@
 MACHINE	:= mach-generic
 endif
 
+ifdef CONFIG_X86_STACK_CHECK
+CFLAGS += -p
+endif
+
 HEAD := arch/i386/kernel/head.o arch/i386/kernel/init_task.o
 
 libs-y 					+= arch/i386/lib/
diff -Nru a/arch/i386/boot/compressed/misc.c b/arch/i386/boot/compressed/misc.c
--- a/arch/i386/boot/compressed/misc.c	Mon Dec  9 11:09:40 2002
+++ b/arch/i386/boot/compressed/misc.c	Mon Dec  9 11:09:40 2002
@@ -377,3 +377,7 @@
 	if (high_loaded) close_output_buffer_if_we_run_high(mv);
 	return high_loaded;
 }
+
+/* We don't actually check for stack overflows this early. */
+__asm__(".globl mcount ; mcount: ret\n");
+
diff -Nru a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Mon Dec  9 11:09:40 2002
+++ b/arch/i386/kernel/entry.S	Mon Dec  9 11:09:40 2002
@@ -520,6 +520,61 @@
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
--- a/arch/i386/kernel/i386_ksyms.c	Mon Dec  9 11:09:40 2002
+++ b/arch/i386/kernel/i386_ksyms.c	Mon Dec  9 11:09:40 2002
@@ -216,3 +216,8 @@
 EXPORT_SYMBOL(edd);
 EXPORT_SYMBOL(eddnr);
 #endif
+
+#ifdef CONFIG_X86_STACK_CHECK
+extern void mcount(void);
+EXPORT_SYMBOL(mcount);
+#endif
diff -Nru a/arch/i386/kernel/init_task.c b/arch/i386/kernel/init_task.c
--- a/arch/i386/kernel/init_task.c	Mon Dec  9 11:09:40 2002
+++ b/arch/i386/kernel/init_task.c	Mon Dec  9 11:09:40 2002
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
--- a/arch/i386/kernel/process.c	Mon Dec  9 11:09:40 2002
+++ b/arch/i386/kernel/process.c	Mon Dec  9 11:09:40 2002
@@ -158,7 +158,25 @@
 
 __setup("idle=", idle_setup);
 
-void show_regs(struct pt_regs * regs)
+void stack_overflow(unsigned long esp, unsigned long eip)
+{
+	int panicing = ((esp&(THREAD_SIZE-1)) <= STACK_PANIC);
+
+	printk( "esp: 0x%x masked: 0x%x STACK_PANIC:0x%x %d %d\n", 
+		esp, (esp&(THREAD_SIZE-1)), STACK_PANIC, (((esp&(THREAD_SIZE-1)) <= STACK_PANIC)), panicing );
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
--- a/include/asm-i386/thread_info.h	Mon Dec  9 11:09:40 2002
+++ b/include/asm-i386/thread_info.h	Mon Dec  9 11:09:40 2002
@@ -63,6 +63,8 @@
  */
 #define THREAD_ORDER 1 
 #define INIT_THREAD_SIZE       THREAD_SIZE
+#define STACK_PANIC		0x200ul
+#define STACK_WARN		((THREAD_SIZE)>>1)
 
 #ifndef __ASSEMBLY__
 

--------------000202080807020303020804--

