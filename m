Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317538AbSFEDaQ>; Tue, 4 Jun 2002 23:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317539AbSFEDaP>; Tue, 4 Jun 2002 23:30:15 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:3060 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317538AbSFEDaO>; Tue, 4 Jun 2002 23:30:14 -0400
Date: Tue, 4 Jun 2002 23:30:15 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] stack check patch for x86
Message-ID: <20020604233015.H9111@redhat.com>
In-Reply-To: <20020604230523.G9111@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 11:05:23PM -0400, Benjamin LaHaise wrote:
> Hey all,
> 
> This patch builds upon the 4KB stack patch by adding a stack check 
> debug option.  It is set to trigger if less than 512 bytes of the 
> stack are remaining, and hooks into code by means of gcc's -p option, 
> which inserts calls to the mcount function.  When an overflow is 
> detected, the code switches to a safety stack, and then proceeds 
> to dump a backtrace and panic.  Comments?

Ugh, yet another brown paper bag.  -A1 should have the missing hunks.

		-ben

:r ~/patches/v2.5.20/v2.5.20-stackcheck-A1.diff
diff -urN smallstack-2.5.20.diff/arch/i386/Makefile stackcheck-2.5.20.diff/arch/i386/Makefile
--- smallstack-2.5.20.diff/arch/i386/Makefile	Tue Jun  4 18:00:16 2002
+++ stackcheck-2.5.20.diff/arch/i386/Makefile	Tue Jun  4 21:10:16 2002
@@ -86,6 +86,10 @@
 CFLAGS += -march=i586
 endif
 
+ifdef CONFIG_X86_STACK_CHECK
+CFLAGS += -p
+endif
+
 HEAD := arch/i386/kernel/head.o arch/i386/kernel/init_task.o
 
 SUBDIRS += arch/i386/kernel arch/i386/mm arch/i386/lib
diff -urN smallstack-2.5.20.diff/arch/i386/boot/compressed/misc.c stackcheck-2.5.20.diff/arch/i386/boot/compressed/misc.c
--- smallstack-2.5.20.diff/arch/i386/boot/compressed/misc.c	Mon Nov 12 12:59:43 2001
+++ stackcheck-2.5.20.diff/arch/i386/boot/compressed/misc.c	Tue Jun  4 21:11:22 2002
@@ -381,3 +381,7 @@
 	if (high_loaded) close_output_buffer_if_we_run_high(mv);
 	return high_loaded;
 }
+
+/* We don't actually check for stack overflows this early. */
+__asm__(".globl mcount ; mcount: ret\n");
+
diff -urN smallstack-2.5.20.diff/arch/i386/config.in stackcheck-2.5.20.diff/arch/i386/config.in
--- smallstack-2.5.20.diff/arch/i386/config.in	Tue Jun  4 23:27:35 2002
+++ stackcheck-2.5.20.diff/arch/i386/config.in	Tue Jun  4 21:13:33 2002
@@ -415,6 +415,7 @@
    if [ "$CONFIG_HIGHMEM" = "y" ]; then
       bool '  Highmem debugging' CONFIG_DEBUG_HIGHMEM
    fi
+   bool '  Check for stack overflows' CONFIG_X86_STACK_CHECK
 fi
 
 endmenu
diff -urN smallstack-2.5.20.diff/arch/i386/kernel/entry.S stackcheck-2.5.20.diff/arch/i386/kernel/entry.S
--- smallstack-2.5.20.diff/arch/i386/kernel/entry.S	Tue Jun  4 23:27:35 2002
+++ stackcheck-2.5.20.diff/arch/i386/kernel/entry.S	Tue Jun  4 22:47:27 2002
@@ -563,6 +563,61 @@
 	pushl $do_spurious_interrupt_bug
 	jmp error_code
 
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
+	jle 1f
+2:
+	popl %eax
+	ret
+1:
+	lock; btsl $0,stack_overflowed	/* Prevent reentry via printk */
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
diff -urN smallstack-2.5.20.diff/arch/i386/kernel/i386_ksyms.c stackcheck-2.5.20.diff/arch/i386/kernel/i386_ksyms.c
--- smallstack-2.5.20.diff/arch/i386/kernel/i386_ksyms.c	Tue Jun  4 18:00:16 2002
+++ stackcheck-2.5.20.diff/arch/i386/kernel/i386_ksyms.c	Tue Jun  4 21:29:09 2002
@@ -176,3 +176,8 @@
 EXPORT_SYMBOL(is_sony_vaio_laptop);
 
 EXPORT_SYMBOL(__PAGE_KERNEL);
+
+#ifdef CONFIG_X86_STACK_CHECK
+extern void mcount(void);
+EXPORT_SYMBOL(mcount);
+#endif
diff -urN smallstack-2.5.20.diff/arch/i386/kernel/init_task.c stackcheck-2.5.20.diff/arch/i386/kernel/init_task.c
--- smallstack-2.5.20.diff/arch/i386/kernel/init_task.c	Tue Jun  4 23:27:35 2002
+++ stackcheck-2.5.20.diff/arch/i386/kernel/init_task.c	Tue Jun  4 22:23:10 2002
@@ -16,6 +16,11 @@
 union thread_union init_irq_union
 	__attribute__((__section__(".data.init_task")));
 
+#ifdef CONFIG_X86_STACK_CHECK
+union thread_union stack_overflow_stack
+	__attribute__((__section__(".data.init_task")));
+#endif
+
 /*
  * Initial thread structure.
  *
diff -urN smallstack-2.5.20.diff/arch/i386/kernel/process.c stackcheck-2.5.20.diff/arch/i386/kernel/process.c
--- smallstack-2.5.20.diff/arch/i386/kernel/process.c	Tue Jun  4 23:27:35 2002
+++ stackcheck-2.5.20.diff/arch/i386/kernel/process.c	Tue Jun  4 22:13:07 2002
@@ -444,6 +444,16 @@
 
 extern void show_trace(unsigned long* esp);
 
+#ifdef CONFIG_X86_STACK_CHECK
+void stack_overflow_panic(void *esp, void *eip)
+{
+	printk("stack overflow from %p.  esp: %p\n", eip, esp);
+	show_trace(esp);
+	panic("stack overflow\n");
+}
+
+#endif
+
 void show_regs(struct pt_regs * regs)
 {
 	unsigned long cr0 = 0L, cr2 = 0L, cr3 = 0L, cr4 = 0L;
