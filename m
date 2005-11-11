Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbVKKIlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbVKKIlk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 03:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbVKKIlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 03:41:25 -0500
Received: from i121.durables.org ([64.81.244.121]:8910 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932242AbVKKIgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 03:36:07 -0500
Date: Fri, 11 Nov 2005 02:35:52 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
X-PatchBomber: http://selenic.com/scripts/mailpatches
In-Reply-To: <8.282480653@selenic.com>
Message-Id: <9.282480653@selenic.com>
Subject: [PATCH 8/15] misc: Make vm86 support optional
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make vm86 support optional

add/remove: 0/14 grow/shrink: 0/5 up/down: 0/-5221 (-5221)
function                                     old     new   delta
do_simd_coprocessor_error                    133     132      -1
irqbits                                        4       -      -4
irqbits_lock                                   8       -      -8
release_thread                                72      52     -20
do_debug                                     212     186     -26
do_general_protection                        475     428     -47
do_trap                                      196     140     -56
release_vm86_irqs                            112       -    -112
vm86_irqs                                    128       -    -128
sys_vm86old                                  146       -    -146
irq_handler                                  151       -    -151
mark_screen_rdonly                           159       -    -159
sys_vm86                                     199       -    -199
handle_vm86_trap                             231       -    -231
save_v86_state                               339       -    -339
do_sys_vm86                                  379       -    -379
do_vm86_irq_handling                         482       -    -482
do_int                                       508       -    -508
handle_vm86_fault                           2225       -   -2225

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14-misc/arch/i386/kernel/entry.S
===================================================================
--- 2.6.14-misc.orig/arch/i386/kernel/entry.S	2005-11-09 11:20:20.000000000 -0800
+++ 2.6.14-misc/arch/i386/kernel/entry.S	2005-11-09 11:20:21.000000000 -0800
@@ -313,15 +313,21 @@ work_resched:
 
 work_notifysig:				# deal with pending signals and
 					# notify-resume requests
-	testl $VM_MASK, EFLAGS(%esp)
 	movl %esp, %eax
+
+#ifdef CONFIG_VM86
+	testl $VM_MASK, EFLAGS(%esp)
 	jne work_notifysig_v86		# returning to kernel-space or
 					# vm86-space
+#endif
+
 	xorl %edx, %edx
 	call do_notify_resume
 	jmp resume_userspace
 
 	ALIGN
+
+#ifdef CONFIG_VM86
 work_notifysig_v86:
 	pushl %ecx			# save ti_flags for do_notify_resume
 	call save_v86_state		# %eax contains pt_regs pointer
@@ -333,6 +339,8 @@ work_notifysig_v86:
 
 	# perform syscall exit tracing
 	ALIGN
+#endif
+
 syscall_trace_entry:
 	movl $-ENOSYS,EAX(%esp)
 	movl %esp, %eax
Index: 2.6.14-misc/arch/i386/kernel/process.c
===================================================================
--- 2.6.14-misc.orig/arch/i386/kernel/process.c	2005-11-09 11:20:20.000000000 -0800
+++ 2.6.14-misc/arch/i386/kernel/process.c	2005-11-09 11:20:21.000000000 -0800
@@ -428,7 +428,9 @@ void release_thread(struct task_struct *
 		}
 	}
 
+#ifdef CONFIG_VM86
 	release_vm86_irqs(dead_task);
+#endif
 }
 
 /*
Index: 2.6.14-misc/arch/i386/kernel/traps.c
===================================================================
--- 2.6.14-misc.orig/arch/i386/kernel/traps.c	2005-11-09 11:20:20.000000000 -0800
+++ 2.6.14-misc/arch/i386/kernel/traps.c	2005-11-09 11:20:21.000000000 -0800
@@ -371,8 +371,10 @@ static void __kprobes do_trap(int trapnr
 	tsk->thread.trap_no = trapnr;
 
 	if (regs->eflags & VM_MASK) {
+#ifdef CONFIG_VM86
 		if (vm86)
 			goto vm86_trap;
+#endif
 		goto trap_signal;
 	}
 
@@ -393,11 +395,13 @@ static void __kprobes do_trap(int trapnr
 		return;
 	}
 
+#ifdef CONFIG_VM86
 	vm86_trap: {
 		int ret = handle_vm86_trap((struct kernel_vm86_regs *) regs, error_code, trapnr);
 		if (ret) goto trap_signal;
 		return;
 	}
+#endif
 }
 
 #define DO_ERROR(trapnr, signr, str, name) \
@@ -452,6 +456,7 @@ DO_VM86_ERROR( 3, SIGTRAP, "int3", int3)
 #endif
 DO_VM86_ERROR( 4, SIGSEGV, "overflow", overflow)
 DO_VM86_ERROR( 5, SIGSEGV, "bounds", bounds)
+
 DO_ERROR_INFO( 6, SIGILL,  "invalid operand", invalid_op, ILL_ILLOPN, regs->eip)
 DO_ERROR( 9, SIGFPE,  "coprocessor segment overrun", coprocessor_segment_overrun)
 DO_ERROR(10, SIGSEGV, "invalid TSS", invalid_TSS)
@@ -497,8 +502,10 @@ fastcall void __kprobes do_general_prote
 	current->thread.error_code = error_code;
 	current->thread.trap_no = 13;
 
+#ifdef CONFIG_VM86
 	if (regs->eflags & VM_MASK)
 		goto gp_in_vm86;
+#endif
 
 	if (!user_mode(regs))
 		goto gp_in_kernel;
@@ -508,10 +515,12 @@ fastcall void __kprobes do_general_prote
 	force_sig(SIGSEGV, current);
 	return;
 
+#ifdef CONFIG_VM86
 gp_in_vm86:
 	local_irq_enable();
 	handle_vm86_fault((struct kernel_vm86_regs *) regs, error_code);
 	return;
+#endif
 
 gp_in_kernel:
 	if (!fixup_exception(regs)) {
@@ -732,8 +741,10 @@ fastcall void __kprobes do_debug(struct 
 			goto clear_dr7;
 	}
 
+#ifdef CONFIG_VM86
 	if (regs->eflags & VM_MASK)
 		goto debug_vm86;
+#endif
 
 	/* Save debug status register where ptrace can see it */
 	tsk->thread.debugreg[6] = condition;
@@ -762,9 +773,11 @@ clear_dr7:
 	set_debugreg(0, 7);
 	return;
 
+#ifdef CONFIG_VM86
 debug_vm86:
 	handle_vm86_trap((struct kernel_vm86_regs *) regs, error_code, 1);
 	return;
+#endif
 
 clear_TF_reenable:
 	set_tsk_thread_flag(tsk, TIF_SINGLESTEP);
@@ -902,11 +915,13 @@ fastcall void do_simd_coprocessor_error(
 		 * Handle strange cache flush from user space exception
 		 * in all other cases.  This is undocumented behaviour.
 		 */
+#ifdef CONFIG_VM86
 		if (regs->eflags & VM_MASK) {
 			handle_vm86_fault((struct kernel_vm86_regs *)regs,
 					  error_code);
 			return;
 		}
+#endif
 		current->thread.trap_no = 19;
 		current->thread.error_code = error_code;
 		die_if_kernel("cache flush denied", regs, error_code);
Index: 2.6.14-misc/arch/i386/kernel/vm86.c
===================================================================
--- 2.6.14-misc.orig/arch/i386/kernel/vm86.c	2005-11-09 11:20:20.000000000 -0800
+++ 2.6.14-misc/arch/i386/kernel/vm86.c	2005-11-09 11:20:21.000000000 -0800
@@ -805,4 +805,3 @@ static int do_vm86_irq_handling(int subf
 	}
 	return -EINVAL;
 }
-
Index: 2.6.14-misc/arch/i386/kernel/Makefile
===================================================================
--- 2.6.14-misc.orig/arch/i386/kernel/Makefile	2005-11-09 11:20:20.000000000 -0800
+++ 2.6.14-misc/arch/i386/kernel/Makefile	2005-11-09 11:20:21.000000000 -0800
@@ -4,7 +4,7 @@
 
 extra-y := head.o init_task.o vmlinux.lds
 
-obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
+obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o \
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o \
 		quirks.o i8237.o
@@ -34,6 +34,7 @@ obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
 obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
 obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
 obj-$(CONFIG_DOUBLEFAULT) 	+= doublefault.o
+obj-$(CONFIG_VM86)		+= vm86.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 EXTRA_AFLAGS   := -traditional
Index: 2.6.14-misc/arch/i386/kernel/sys_i386.c
===================================================================
--- 2.6.14-misc.orig/arch/i386/kernel/sys_i386.c	2005-11-09 11:20:20.000000000 -0800
+++ 2.6.14-misc/arch/i386/kernel/sys_i386.c	2005-11-09 11:20:21.000000000 -0800
@@ -22,6 +22,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/ipc.h>
+#include <asm/unistd.h>
 
 /*
  * sys_pipe() is the normal C calling standard for creating
Index: 2.6.14-misc/init/Kconfig
===================================================================
--- 2.6.14-misc.orig/init/Kconfig	2005-11-09 11:20:20.000000000 -0800
+++ 2.6.14-misc/init/Kconfig	2005-11-09 11:20:39.000000000 -0800
@@ -347,6 +347,16 @@ config EPOLL
 	  Disabling this option will cause the kernel to be built without
 	  support for epoll family of system calls.
 
+config VM86
+	depends X86
+	default y
+	bool "Enable VM86 support" if EMBEDDED
+	help
+          This option is required by programs like DOSEMU to run 16-bit legacy
+	  code on X86 processors. It also may be needed by software like
+          XFree86 to initialize some video cards via BIOS. Disabling this
+          option saves about 6k.
+
 config CC_OPTIMIZE_FOR_SIZE
 	bool "Optimize for size" if EMBEDDED
 	default y if ARM || H8300
Index: 2.6.14-misc/kernel/sys_ni.c
===================================================================
--- 2.6.14-misc.orig/kernel/sys_ni.c	2005-11-09 11:20:20.000000000 -0800
+++ 2.6.14-misc/kernel/sys_ni.c	2005-11-09 11:20:21.000000000 -0800
@@ -82,6 +82,8 @@ cond_syscall(compat_sys_socketcall);
 cond_syscall(sys_inotify_init);
 cond_syscall(sys_inotify_add_watch);
 cond_syscall(sys_inotify_rm_watch);
+cond_syscall(sys_vm86old);
+cond_syscall(sys_vm86);
 
 /* arch-specific weak syscall entries */
 cond_syscall(sys_pciconfig_read);
