Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbVL1UbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbVL1UbD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 15:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbVL1UbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 15:31:03 -0500
Received: from waste.org ([64.81.244.121]:48336 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S964904AbVL1UbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 15:31:01 -0500
Date: Wed, 28 Dec 2005 14:27:35 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-tiny@selenic.com
Subject: [PATCH] Make vm86 support optional
Message-ID: <20051228202735.GU3356@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option to remove vm86 support under CONFIG_EMBEDDED.
Saves about 5k.

This version eliminates most of the #ifdefs of the previous version
and instead uses function stubs in vm86.h. Also, release_vm86_irqs is
moved from asm-i386/irq.h to a more appropriate home in vm86.h so that
the stubs can live together.

$ size vmlinux-baseline vmlinux-novm86
   text    data     bss     dec     hex filename
2920821  523232  190652 3634705  377611 vmlinux-baseline
2916268  523100  190492 3629860  376324 vmlinux-novm86

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.15-misc/arch/i386/kernel/Makefile
===================================================================
--- 2.6.15-misc.orig/arch/i386/kernel/Makefile	2005-12-28 02:01:39.000000000 -0600
+++ 2.6.15-misc/arch/i386/kernel/Makefile	2005-12-28 02:02:02.000000000 -0600
@@ -4,7 +4,7 @@
 
 extra-y := head.o init_task.o vmlinux.lds
 
-obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
+obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o \
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o \
 		quirks.o i8237.o
@@ -36,6 +36,7 @@ obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
 obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
 obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
 obj-$(CONFIG_DOUBLEFAULT) 	+= doublefault.o
+obj-$(CONFIG_VM86)		+= vm86.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 EXTRA_AFLAGS   := -traditional
Index: 2.6.15-misc/init/Kconfig
===================================================================
--- 2.6.15-misc.orig/init/Kconfig	2005-12-28 02:01:39.000000000 -0600
+++ 2.6.15-misc/init/Kconfig	2005-12-28 02:02:02.000000000 -0600
@@ -342,6 +342,16 @@ config UID16
 	help
 	  This enables the legacy 16-bit UID syscall wrappers.
 
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
 	bool "Optimize for size"
 	default y if ARM || H8300
Index: 2.6.15-misc/kernel/sys_ni.c
===================================================================
--- 2.6.15-misc.orig/kernel/sys_ni.c	2005-12-28 02:01:39.000000000 -0600
+++ 2.6.15-misc/kernel/sys_ni.c	2005-12-28 02:02:02.000000000 -0600
@@ -102,6 +102,8 @@ cond_syscall(sys_setresgid16);
 cond_syscall(sys_setresuid16);
 cond_syscall(sys_setreuid16);
 cond_syscall(sys_setuid16);
+cond_syscall(sys_vm86old);
+cond_syscall(sys_vm86);
 
 /* arch-specific weak syscall entries */
 cond_syscall(sys_pciconfig_read);
Index: 2.6.15-misc/arch/i386/kernel/process.c
===================================================================
--- 2.6.15-misc.orig/arch/i386/kernel/process.c	2005-12-28 02:01:39.000000000 -0600
+++ 2.6.15-misc/arch/i386/kernel/process.c	2005-12-28 02:02:02.000000000 -0600
@@ -48,6 +48,7 @@
 #include <asm/processor.h>
 #include <asm/i387.h>
 #include <asm/desc.h>
+#include <asm/vm86.h>
 #ifdef CONFIG_MATH_EMULATION
 #include <asm/math_emu.h>
 #endif
Index: 2.6.15-misc/include/asm-i386/irq.h
===================================================================
--- 2.6.15-misc.orig/include/asm-i386/irq.h	2005-12-28 02:01:39.000000000 -0600
+++ 2.6.15-misc/include/asm-i386/irq.h	2005-12-28 02:02:02.000000000 -0600
@@ -21,8 +21,6 @@ static __inline__ int irq_canonicalize(i
 	return ((irq == 2) ? 9 : irq);
 }
 
-extern void release_vm86_irqs(struct task_struct *);
-
 #ifdef CONFIG_X86_LOCAL_APIC
 # define ARCH_HAS_NMI_WATCHDOG		/* See include/linux/nmi.h */
 #endif
Index: 2.6.15-misc/include/asm-i386/vm86.h
===================================================================
--- 2.6.15-misc.orig/include/asm-i386/vm86.h	2005-12-28 02:01:39.000000000 -0600
+++ 2.6.15-misc/include/asm-i386/vm86.h	2005-12-28 02:36:48.000000000 -0600
@@ -16,7 +16,11 @@
 #define IF_MASK		0x00000200
 #define IOPL_MASK	0x00003000
 #define NT_MASK		0x00004000
+#ifdef CONFIG_VM86
 #define VM_MASK		0x00020000
+#else
+#define VM_MASK		0 /* ignored */
+#endif
 #define AC_MASK		0x00040000
 #define VIF_MASK	0x00080000	/* virtual interrupt flag */
 #define VIP_MASK	0x00100000	/* virtual interrupt pending */
@@ -200,9 +204,25 @@ struct kernel_vm86_struct {
  */
 };
 
+#ifdef CONFIG_VM86
+
 void handle_vm86_fault(struct kernel_vm86_regs *, long);
 int handle_vm86_trap(struct kernel_vm86_regs *, long, int);
 
+struct task_struct;
+void release_vm86_irqs(struct task_struct *);
+
+#else
+
+#define handle_vm86_fault(a, b)
+#define release_vm86_irqs(a)
+
+static inline int handle_vm86_trap(struct kernel_vm86_regs *a, long b, int c) {
+	return 0;
+}
+
+#endif /* CONFIG_VM86 */
+
 #endif /* __KERNEL__ */
 
 #endif
Index: 2.6.15-misc/arch/i386/kernel/entry.S
===================================================================
--- 2.6.15-misc.orig/arch/i386/kernel/entry.S	2005-12-28 01:48:00.000000000 -0600
+++ 2.6.15-misc/arch/i386/kernel/entry.S	2005-12-28 12:23:44.000000000 -0600
@@ -341,6 +341,7 @@ work_notifysig:				# deal with pending s
 
 	ALIGN
 work_notifysig_v86:
+#ifdef CONFIG_VM86
 	pushl %ecx			# save ti_flags for do_notify_resume
 	call save_v86_state		# %eax contains pt_regs pointer
 	popl %ecx
@@ -348,6 +349,7 @@ work_notifysig_v86:
 	xorl %edx, %edx
 	call do_notify_resume
 	jmp resume_userspace
+#endif
 
 	# perform syscall exit tracing
 	ALIGN


-- 
Mathematics is the supreme nostalgia of our time.
