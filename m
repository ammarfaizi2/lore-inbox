Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbVKKIjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbVKKIjo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 03:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbVKKIj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 03:39:28 -0500
Received: from i121.durables.org ([64.81.244.121]:9166 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932233AbVKKIgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 03:36:07 -0500
Date: Fri, 11 Nov 2005 02:35:53 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
X-PatchBomber: http://selenic.com/scripts/mailpatches
In-Reply-To: <9.282480653@selenic.com>
Message-Id: <10.282480653@selenic.com>
Subject: [PATCH 9/15] misc: Make sysenter support optional
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds configurable sysenter support on x86. This saves about 5k on
small systems.

   text    data     bss     dec     hex
3330172  529036  190556 4049764  3dcb64 baseline
3329604  524164  190556 4044324  3db624 sysenter

$ bloat-o-meter vmlinux{-baseline,}
add/remove: 0/2 grow/shrink: 0/3 up/down: 0/-316 (-316)
function                                     old     new   delta
__restore_processor_state                     76      62     -14
identify_cpu                                 520     500     -20
create_elf_tables                            923     883     -40
sysenter_setup                               113       -    -113
enable_sep_cpu                               129       -    -129

Most of the savings is not including the vsyscall DSO which doesn't
show up with bloat-o-meter:

$ size arch/i386/kernel/vsyscall.o
   text    data     bss     dec     hex filename
      0    4826       0    4826    12da arch/i386/kernel/vsyscall.o

$ nm arch/i386/kernel/vsyscall.o
00000961 T vsyscall_int80_end
00000000 T vsyscall_int80_start
000012da T vsyscall_sysenter_end
00000961 T vsyscall_sysenter_start

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14-misc/arch/i386/kernel/Makefile
===================================================================
--- 2.6.14-misc.orig/arch/i386/kernel/Makefile	2005-11-11 00:32:13.000000000 -0800
+++ 2.6.14-misc/arch/i386/kernel/Makefile	2005-11-11 00:32:17.000000000 -0800
@@ -29,7 +29,7 @@ obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
 obj-$(CONFIG_X86_SUMMIT_NUMA)	+= summit.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_MODULES)		+= module.o
-obj-y				+= sysenter.o vsyscall.o
+obj-$(CONFIG_SYSENTER)		+= sysenter.o vsyscall.o
 obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
 obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
 obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
Index: 2.6.14-misc/arch/i386/kernel/entry.S
===================================================================
--- 2.6.14-misc.orig/arch/i386/kernel/entry.S	2005-11-11 00:32:13.000000000 -0800
+++ 2.6.14-misc/arch/i386/kernel/entry.S	2005-11-11 00:32:17.000000000 -0800
@@ -177,6 +177,7 @@ need_resched:
 
 	# sysenter call handler stub
 ENTRY(sysenter_entry)
+#ifdef CONFIG_SYSENTER
 	movl TSS_sysenter_esp0(%esp),%esp
 sysenter_past_esp:
 	sti
@@ -219,7 +220,7 @@ sysenter_past_esp:
 	xorl %ebp,%ebp
 	sti
 	sysexit
-
+#endif
 
 	# system call handler stub
 ENTRY(system_call)
@@ -506,6 +507,8 @@ device_not_available_emulate:
  * by hand onto the new stack - while updating the return eip past
  * the instruction that would have done it for sysenter.
  */
+
+#ifdef CONFIG_SYSENTER
 #define FIX_STACK(offset, ok, label)		\
 	cmpw $__KERNEL_CS,4(%esp);		\
 	jne ok;					\
@@ -514,6 +517,10 @@ label:						\
 	pushfl;					\
 	pushl $__KERNEL_CS;			\
 	pushl $sysenter_past_esp
+#else
+#define FIX_STACK(offset, ok, label) \
+label:
+#endif
 
 KPROBE_ENTRY(debug)
 	cmpl $sysenter_entry,(%esp)
Index: 2.6.14-misc/arch/i386/power/cpu.c
===================================================================
--- 2.6.14-misc.orig/arch/i386/power/cpu.c	2005-11-11 00:31:55.000000000 -0800
+++ 2.6.14-misc/arch/i386/power/cpu.c	2005-11-11 00:32:17.000000000 -0800
@@ -109,11 +109,13 @@ void __restore_processor_state(struct sa
  	loadsegment(gs, ctxt->gs);
  	loadsegment(ss, ctxt->ss);
 
+#ifdef CONFIG_SYSENTER
 	/*
 	 * sysenter MSRs
 	 */
 	if (boot_cpu_has(X86_FEATURE_SEP))
 		enable_sep_cpu();
+#endif
 
 	fix_processor_context();
 	do_fpu_end();
Index: 2.6.14-misc/include/asm-i386/elf.h
===================================================================
--- 2.6.14-misc.orig/include/asm-i386/elf.h	2005-11-11 00:32:01.000000000 -0800
+++ 2.6.14-misc/include/asm-i386/elf.h	2005-11-11 00:32:17.000000000 -0800
@@ -134,11 +134,13 @@ extern int dump_task_extended_fpu (struc
 #define VSYSCALL_ENTRY	((unsigned long) &__kernel_vsyscall)
 extern void __kernel_vsyscall;
 
+#ifdef CONFIG_SYSENTER
 #define ARCH_DLINFO						\
 do {								\
 		NEW_AUX_ENT(AT_SYSINFO,	VSYSCALL_ENTRY);	\
 		NEW_AUX_ENT(AT_SYSINFO_EHDR, VSYSCALL_BASE);	\
 } while (0)
+#endif
 
 /*
  * These macros parameterize elf_core_dump in fs/binfmt_elf.c to write out
Index: 2.6.14-misc/init/Kconfig
===================================================================
--- 2.6.14-misc.orig/init/Kconfig	2005-11-11 00:32:13.000000000 -0800
+++ 2.6.14-misc/init/Kconfig	2005-11-11 00:32:17.000000000 -0800
@@ -357,6 +357,14 @@ config VM86
           XFree86 to initialize some video cards via BIOS. Disabling this
           option saves about 6k.
 
+config SYSENTER
+	depends X86
+	default y
+	bool "Enable syscalls via sysenter" if EMBEDDED
+	help
+	  Disabling this feature removes sysenter handling as well as
+	  vsyscall fixmaps.
+ 
 config CC_OPTIMIZE_FOR_SIZE
 	bool "Optimize for size" if EMBEDDED
 	default y if ARM || H8300
Index: 2.6.14-misc/arch/i386/kernel/cpu/common.c
===================================================================
--- 2.6.14-misc.orig/arch/i386/kernel/cpu/common.c	2005-11-11 00:32:13.000000000 -0800
+++ 2.6.14-misc/arch/i386/kernel/cpu/common.c	2005-11-11 00:32:40.000000000 -0800
@@ -429,9 +429,11 @@ void __devinit identify_cpu(struct cpuin
 	/* Init Machine Check Exception if available. */
 	mcheck_init(c);
 
+#ifdef CONFIG_SYSENTER
 	if (c == &boot_cpu_data)
 		sysenter_setup();
 	enable_sep_cpu();
+#endif
 
 	if (c == &boot_cpu_data)
 		mtrr_bp_init();
