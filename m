Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262582AbSJOFyi>; Tue, 15 Oct 2002 01:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbSJOFyh>; Tue, 15 Oct 2002 01:54:37 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:9948 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262582AbSJOFya>;
	Tue, 15 Oct 2002 01:54:30 -0400
Message-ID: <3DABAEE7.1000302@us.ibm.com>
Date: Mon, 14 Oct 2002 23:00:07 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] x86 transition to 4k stacks (2/3)
Content-Type: multipart/mixed;
 boundary="------------010808000003010705000702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010808000003010705000702
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

* stack checking (2/3)
    - use gcc's profiling features to check for stack overflows upon
      entry to functions.
    - Warn if the task goes over 4k.
    - Panic if the stack gets within 512 bytes of overflowing.

-- 
Dave Hansen
haveblue@us.ibm.com


--------------010808000003010705000702
Content-Type: text/plain;
 name="stack_usage_check-2.5.42+bk-5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stack_usage_check-2.5.42+bk-5.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.851   -> 1.852  
#	arch/i386/kernel/process.c	1.32    -> 1.33   
#	arch/i386/Config.help	1.21    -> 1.22   
#	            Makefile	1.320   -> 1.321  
#	arch/i386/kernel/entry.S	1.38    -> 1.39   
#	 arch/i386/config.in	1.56    -> 1.57   
#	  arch/i386/Makefile	1.21    -> 1.22   
#	arch/i386/boot/compressed/misc.c	1.9     -> 1.10   
#	arch/i386/kernel/init_task.c	1.6     -> 1.7    
#	arch/i386/kernel/i386_ksyms.c	1.34    -> 1.35   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/14	haveblue@elm3b96.(none)	1.852
# stack_usage_check-2.5.42+bk-1.patch
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Mon Oct 14 19:54:47 2002
+++ b/Makefile	Mon Oct 14 19:54:47 2002
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
--- a/arch/i386/Config.help	Mon Oct 14 19:54:47 2002
+++ b/arch/i386/Config.help	Mon Oct 14 19:54:47 2002
@@ -1044,6 +1044,10 @@
   symbolic stack backtraces. This increases the size of the kernel
   somewhat, as all symbols have to be loaded into the kernel image.
 
+CONFIG_X86_STACK_CHECK
+  Say Y here to have the kernel attempt to detect when the per-task
+  kernel stack overflows.  
+
 CONFIG_DEBUG_OBSOLETE
   Say Y here if you want to reduce the chances of the tree compiling,
   and are prepared to dig into driver internals to fix compile errors.
diff -Nru a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	Mon Oct 14 19:54:47 2002
+++ b/arch/i386/Makefile	Mon Oct 14 19:54:47 2002
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
--- a/arch/i386/boot/compressed/misc.c	Mon Oct 14 19:54:47 2002
+++ b/arch/i386/boot/compressed/misc.c	Mon Oct 14 19:54:47 2002
@@ -377,3 +377,7 @@
 	if (high_loaded) close_output_buffer_if_we_run_high(mv);
 	return high_loaded;
 }
+
+/* We don't actually check for stack overflows this early. */
+__asm__(".globl mcount ; mcount: ret\n");
+
diff -Nru a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	Mon Oct 14 19:54:47 2002
+++ b/arch/i386/config.in	Mon Oct 14 19:54:47 2002
@@ -458,6 +458,11 @@
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
--- a/arch/i386/kernel/entry.S	Mon Oct 14 19:54:47 2002
+++ b/arch/i386/kernel/entry.S	Mon Oct 14 19:54:47 2002
@@ -481,6 +481,67 @@
 	pushl $do_spurious_interrupt_bug
 	jmp error_code
 
+
+#ifdef CONFIG_X86_STACK_CHECK
+.data
+	.globl	stack_overflowed
+stack_overflowed:
+	.long	0
+
+.text
+
+ENTRY(mcount)
+	push %eax
+	movl $(THREAD_SIZE - 1),%eax
+	andl %esp,%eax
+	cmpl $0x200,%eax        /* 512 byte danger zone */
+	jle 1f 			/* this wil panic */
+	cmpl $0x1000,%eax	/* 4k stack would have overflowed */
+	jle 2f			/* this will just warn */
+3:
+	popl %eax
+	ret
+2:
+	call    stack_overflow_warn
+	jc      3b
+1:
+	lock; btsl $0,stack_overflowed	/* Prevent reentry via printk */
+	jc      3b
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
+	# never neverland
+	call	stack_overflow_panic
+
+	addl	$8,%esp
+
+	popf
+	popl	%eax
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
--- a/arch/i386/kernel/i386_ksyms.c	Mon Oct 14 19:54:47 2002
+++ b/arch/i386/kernel/i386_ksyms.c	Mon Oct 14 19:54:47 2002
@@ -182,3 +182,8 @@
 EXPORT_SYMBOL(is_sony_vaio_laptop);
 
 EXPORT_SYMBOL(__PAGE_KERNEL);
+
+#ifdef CONFIG_X86_STACK_CHECK
+extern void mcount(void);
+EXPORT_SYMBOL(mcount);
+#endif
diff -Nru a/arch/i386/kernel/init_task.c b/arch/i386/kernel/init_task.c
--- a/arch/i386/kernel/init_task.c	Mon Oct 14 19:54:47 2002
+++ b/arch/i386/kernel/init_task.c	Mon Oct 14 19:54:47 2002
@@ -13,6 +13,11 @@
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 struct mm_struct init_mm = INIT_MM(init_mm);
 
+#ifdef CONFIG_X86_STACK_CHECK
+union thread_union stack_overflow_stack
+	__attribute__((__section__(".data.init_task")));
+#endif
+
 /*
  * Initial thread structure.
  *
diff -Nru a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c	Mon Oct 14 19:54:47 2002
+++ b/arch/i386/kernel/process.c	Mon Oct 14 19:54:47 2002
@@ -156,7 +156,21 @@
 
 __setup("idle=", idle_setup);
 
-void show_regs(struct pt_regs * regs)
+void stack_overflow_warn(void *esp, unsigned long eip)
+{
+	print_symbol("excessive stack use from %s\n", eip);
+	printk("esp: %p\n", esp);
+	show_trace(esp);
+}
+
+void stack_overflow_panic(void *esp, void *eip)
+{
+	printk("stack overflow from %p.  esp: %p\n", eip, esp);
+	show_trace(esp);
+	panic("stack overflow\n");
+}
+
+asmlinkage void show_regs(struct pt_regs * regs)
 {
 	unsigned long cr0 = 0L, cr2 = 0L, cr3 = 0L, cr4 = 0L;
 

--------------010808000003010705000702--

