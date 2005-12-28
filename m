Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964916AbVL1V12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbVL1V12 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 16:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbVL1V12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 16:27:28 -0500
Received: from waste.org ([64.81.244.121]:42118 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S964916AbVL1V11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 16:27:27 -0500
Date: Wed, 28 Dec 2005 15:24:02 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-tiny@selenic.com
Subject: [PATCH] Make sysenter support optional
Message-ID: <20051228212402.GX3356@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds configurable sysenter support on x86. This saves about 5k on
small systems.

$ size vmlinux-baseline vmlinux
   text    data     bss     dec     hex filename
2920821  523232  190652 3634705  377611 vmlinux-baseline
2920558  518376  190652 3629586  376212 vmlinux

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.15-misc/arch/i386/kernel/Makefile
===================================================================
--- 2.6.15-misc.orig/arch/i386/kernel/Makefile	2005-12-28 14:51:45.000000000 -0600
+++ 2.6.15-misc/arch/i386/kernel/Makefile	2005-12-28 14:51:46.000000000 -0600
@@ -31,7 +31,7 @@ obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
 obj-$(CONFIG_X86_SUMMIT_NUMA)	+= summit.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_MODULES)		+= module.o
-obj-y				+= sysenter.o vsyscall.o
+obj-$(CONFIG_SYSENTER)		+= sysenter.o vsyscall.o
 obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
 obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
 obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
Index: 2.6.15-misc/include/asm-i386/elf.h
===================================================================
--- 2.6.15-misc.orig/include/asm-i386/elf.h	2005-12-28 14:36:59.000000000 -0600
+++ 2.6.15-misc/include/asm-i386/elf.h	2005-12-28 14:51:47.000000000 -0600
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
Index: 2.6.15-misc/init/Kconfig
===================================================================
--- 2.6.15-misc.orig/init/Kconfig	2005-12-28 14:51:45.000000000 -0600
+++ 2.6.15-misc/init/Kconfig	2005-12-28 14:51:47.000000000 -0600
@@ -352,6 +352,14 @@ config VM86
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
 	bool "Optimize for size"
 	default y if ARM || H8300
Index: 2.6.15-misc/include/asm-i386/processor.h
===================================================================
--- 2.6.15-misc.orig/include/asm-i386/processor.h	2005-12-28 14:51:44.000000000 -0600
+++ 2.6.15-misc/include/asm-i386/processor.h	2005-12-28 14:51:41.000000000 -0600
@@ -709,8 +709,14 @@ extern void select_idle_routine(const st
 #define cache_line_size() (boot_cpu_data.x86_cache_alignment)
 
 extern unsigned long boot_option_idle_override;
+
+#ifdef CONFIG_SYSENTER
 extern void enable_sep_cpu(void);
 extern int sysenter_setup(void);
+#else
+#define enable_sep_cpu()
+static inline int sysenter_setup(void) { return 0; }
+#endif
 
 #ifdef CONFIG_MTRR
 extern void mtrr_ap_init(void);

-- 
Mathematics is the supreme nostalgia of our time.
