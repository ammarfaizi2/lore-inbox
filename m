Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265372AbSJRWDR>; Fri, 18 Oct 2002 18:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265369AbSJRWCZ>; Fri, 18 Oct 2002 18:02:25 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:25257 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265370AbSJRWCA>;
	Fri, 18 Oct 2002 18:02:00 -0400
Message-ID: <3DB08620.40004@us.ibm.com>
Date: Fri, 18 Oct 2002 15:07:28 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] (3/3) stack overflow checking for x86
Content-Type: multipart/mixed;
 boundary="------------000403010909030606060800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000403010909030606060800
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

* stack checking (3/3)
    - use gcc's profiling features to check for stack overflows upon
      entry to functions.
    - Warn if the task goes over 4k.
    - Panic if the stack gets within 512 bytes of overflowing.
    - use kksymoops information, if available

This won't apply cleanly without the irqstack patch, but the conflict 
is easy to resolve.  It requires the thread_info cleanup.
-- 
Dave Hansen
haveblue@us.ibm.com

--------------000403010909030606060800
Content-Type: text/plain;
 name="C-stack_usage_check-2.5.43+bk-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="C-stack_usage_check-2.5.43+bk-1.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.858.1.2 -> 1.863  
#	arch/i386/kernel/process.c	1.32.1.1 -> 1.36   
#	arch/i386/Config.help	1.21.1.2 -> 1.24   
#	            Makefile	1.320.1.1 -> 1.322  
#	include/asm-i386/thread_info.h	1.10    -> 1.11   
#	arch/i386/kernel/entry.S	1.38.1.2 -> 1.45   
#	 arch/i386/config.in	1.56.1.4 -> 1.59   
#	  arch/i386/Makefile	1.21.1.1 -> 1.23   
#	arch/i386/boot/compressed/misc.c	1.9     -> 1.10   
#	arch/i386/kernel/init_task.c	1.6.1.1 -> 1.8    
#	arch/i386/kernel/i386_ksyms.c	1.34.1.2 -> 1.36   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/16	haveblue@elm3b96.(none)	1.861
# change warning semantics
# --------------------------------------------
# 02/10/16	haveblue@elm3b96.(none)	1.862
# entry.S:
#   don't need stack_warn_lock anymore
# --------------------------------------------
# 02/10/16	haveblue@elm3b96.(none)	1.863
# merge
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Wed Oct 16 14:14:00 2002
+++ b/Makefile	Wed Oct 16 14:14:00 2002
@@ -156,7 +156,8 @@
 
 CPPFLAGS	:= -D__KERNEL__ -Iinclude
 CFLAGS 		:= $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
-	  	   -fomit-frame-pointer -fno-strict-aliasing -fno-common
+	  	   -fno-strict-aliasing -fno-common
+
 AFLAGS		:= -D__ASSEMBLY__ $(CPPFLAGS)
 
 export	VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION KERNELRELEASE ARCH \
@@ -255,6 +256,10 @@
 
 ifdef CONFIG_MODULES
 export EXPORT_FLAGS := -DEXPORT_SYMTAB
+endif
+
+ifneq ($(CONFIG_FRAME_POINTER),y)
+CFLAGS          += -fomit-frame-pointer
 endif
 
 #
diff -Nru a/arch/i386/Config.help b/arch/i386/Config.help
--- a/arch/i386/Config.help	Wed Oct 16 14:14:00 2002
+++ b/arch/i386/Config.help	Wed Oct 16 14:14:00 2002
@@ -1050,6 +1050,20 @@
   symbolic stack backtraces. This increases the size of the kernel
   somewhat, as all symbols have to be loaded into the kernel image.
 
+CONFIG_X86_STACK_CHECK
+  Say Y here to have the kernel attempt to detect when the per-task
+  kernel stack overflows. 
+
+  Some older versions of gcc don't handle the -p option correctly.  
+  Kernprof is affected by the same problem, which is described here:
+  http://oss.sgi.com/projects/kernprof/faq.html#Q9
+
+  Basically, if you get oopses in __free_pages_ok during boot when
+  you have this turned on, you need to fix gcc.  The Redhat 2.96 
+  version and gcc-3.x seem to work.  
+
+  If not debugging a stack overflow problem, say N
+
 CONFIG_DEBUG_OBSOLETE
   Say Y here if you want to reduce the chances of the tree compiling,
   and are prepared to dig into driver internals to fix compile errors.
diff -Nru a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	Wed Oct 16 14:14:00 2002
+++ b/arch/i386/Makefile	Wed Oct 16 14:14:00 2002
@@ -49,6 +49,10 @@
 MACHINE	:= mach-generic
 endif
 
+ifdef CONFIG_X86_STACK_CHECK
+CFLAGS += -p
+endif
+
 HEAD := arch/i386/kernel/head.o arch/i386/kernel/init_task.o
 
 libs-y 					+= arch/i386/lib/
diff -Nru a/arch/i386/boot/compressed/misc.c b/arch/i386/boot/compressed/misc.c
--- a/arch/i386/boot/compressed/misc.c	Wed Oct 16 14:14:00 2002
+++ b/arch/i386/boot/compressed/misc.c	Wed Oct 16 14:14:00 2002
@@ -377,3 +377,7 @@
 	if (high_loaded) close_output_buffer_if_we_run_high(mv);
 	return high_loaded;
 }
+
+/* We don't actually check for stack overflows this early. */
+__asm__(".globl mcount ; mcount: ret\n");
+
diff -Nru a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	Wed Oct 16 14:14:00 2002
+++ b/arch/i386/config.in	Wed Oct 16 14:14:00 2002
@@ -467,6 +467,11 @@
       bool '  Highmem debugging' CONFIG_DEBUG_HIGHMEM
    fi
    bool '  Load all symbols for debugging/kksymoops' CONFIG_KALLSYMS
+   bool '  Check for stack overflows' CONFIG_X86_STACK_CHECK
+   if [ "$CONFIG_X86_STACK_CHECK" = "y" ]; then
+      define_bool CONFIG_FRAME_POINTER y
+   fi
+
 fi
 
 if [ "$CONFIG_X86_LOCAL_APIC" = "y" ]; then
diff -Nru a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Wed Oct 16 14:14:00 2002
+++ b/arch/i386/kernel/entry.S	Wed Oct 16 14:14:00 2002
@@ -519,6 +519,61 @@
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
 	.long sys_ni_syscall	/* 0 - old "setup()" system call*/
diff -Nru a/arch/i386/kernel/i386_ksyms.c b/arch/i386/kernel/i386_ksyms.c
--- a/arch/i386/kernel/i386_ksyms.c	Wed Oct 16 14:14:00 2002
+++ b/arch/i386/kernel/i386_ksyms.c	Wed Oct 16 14:14:00 2002
@@ -192,3 +192,8 @@
 EXPORT_SYMBOL(is_sony_vaio_laptop);
 
 EXPORT_SYMBOL(__PAGE_KERNEL);
+
+#ifdef CONFIG_X86_STACK_CHECK
+extern void mcount(void);
+EXPORT_SYMBOL(mcount);
+#endif
diff -Nru a/arch/i386/kernel/init_task.c b/arch/i386/kernel/init_task.c
--- a/arch/i386/kernel/init_task.c	Wed Oct 16 14:14:00 2002
+++ b/arch/i386/kernel/init_task.c	Wed Oct 16 14:14:00 2002
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
--- a/arch/i386/kernel/process.c	Wed Oct 16 14:14:00 2002
+++ b/arch/i386/kernel/process.c	Wed Oct 16 14:14:00 2002
@@ -156,7 +156,25 @@
 
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
--- a/include/asm-i386/thread_info.h	Wed Oct 16 14:14:00 2002
+++ b/include/asm-i386/thread_info.h	Wed Oct 16 14:14:00 2002
@@ -60,6 +60,8 @@
  */
 #define THREAD_ORDER 1 
 #define INIT_THREAD_SIZE       THREAD_SIZE
+#define STACK_PANIC		0x200ul
+#define STACK_WARN		((THREAD_SIZE)>>1)
 
 #ifndef __ASSEMBLY__
 #define INIT_THREAD_INFO(tsk)			\

--------------000403010909030606060800--

