Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261607AbTCaLte>; Mon, 31 Mar 2003 06:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261608AbTCaLte>; Mon, 31 Mar 2003 06:49:34 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:14808 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261607AbTCaLt3>;
	Mon, 31 Mar 2003 06:49:29 -0500
From: Arnd Bergmann <arndb@de.ibm.com>
Reply-To: arnd@arndb.de
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [RFC] s390/s390x code consolidation
Date: Mon, 31 Mar 2003 09:39:39 +0200
User-Agent: KMail/1.5.1
Organization: IBM Deutschland Entwicklung GmbH
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303310939.39497.arndb@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is my idea of how to start the consolidation of s390 and s390x
that Christoph Hellwig proposed (repeatedly).

It's a hack to add a configuration option for 64 bit kernels to arch/s390
and to use files from arch/s390x instead of the ones in arch/s390 if they
exist both (same for include/asm). Any duplicate files can simply be
deleted from {arch/,include/asm-}s390x.

The necessary steps would be:

- Add support for compiling 64 bit in arch/s390 (this patch)
- While arch/s390x and include/s390x are not empty:
   * Merge some s390x files into their s390 counterparts
   * Remove merged and duplicate files
- Remove the makefile hacks introduced here
- Profit

	Arnd <><

===== arch/s390/kernel/Makefile 1.17 vs edited =====
--- 1.17/arch/s390/kernel/Makefile	Sun Mar  9 23:15:54 2003
+++ edited/arch/s390/kernel/Makefile	Sun Mar 30 03:13:37 2003
@@ -16,3 +16,24 @@
 # Kernel debugging
 #
 obj-$(CONFIG_REMOTE_DEBUG)	+= gdb-stub.o #gdb-low.o 
+
+obj-$(CONFIG_S390_SUPPORT)	+= linux32.o signal32.o ioctl32.o wrapper32.o \
+					 exec32.o exec_domain32.o
+obj-$(CONFIG_BINFMT_ELF32)	+= binfmt_elf32.o
+
+ifdef CONFIG_ARCH_S390X
+$(obj)%.o: $(patsubst arch/s390/%,arch/s390x/%,$(src))%.S
+	$(call if_changed_dep,as_o_S)
+
+$(obj)%.o: $(patsubst arch/s390/%,arch/s390x/%,$(src))%.c
+ifdef CONFIG_MODVERSIONS
+	$(call if_changed_rule,vcc_o_c)
+else
+	$(call if_changed_dep,cc_o_c)
+endif
+endif
+
+#
+# This is just to get the dependencies...
+#
+binfmt_elf32.o:	$(TOPDIR)/fs/binfmt_elf.c
===== arch/s390/lib/Makefile 1.8 vs edited =====
--- 1.8/arch/s390/lib/Makefile	Sun Dec 15 21:03:39 2002
+++ edited/arch/s390/lib/Makefile	Sun Mar 30 03:42:32 2003
@@ -7,3 +7,8 @@
 EXTRA_AFLAGS := -traditional
 
 obj-y = delay.o memset.o strcmp.o strncpy.o uaccess.o
+
+ifdef CONFIG_ARCH_S390X
+$(obj)%.o: $(patsubst arch/s390/%,arch/s390x/%,$(src))%.S
+	$(call if_changed_dep,as_o_S)
+endif
===== arch/s390/mm/Makefile 1.6 vs edited =====
--- 1.6/arch/s390/mm/Makefile	Sun Dec 15 21:03:39 2002
+++ edited/arch/s390/mm/Makefile	Sun Mar 30 03:24:36 2003
@@ -3,3 +3,8 @@
 #
 
 obj-y	 := init.o fault.o ioremap.o extable.o
+
+ifdef CONFIG_ARCH_S390X
+$(obj)%.o: $(patsubst arch/s390/%,arch/s390x/%,$(src))%.c
+	$(call if_changed_dep,cc_o_c)
+endif
===== arch/s390/Kconfig 1.8 vs edited =====
--- 1.8/arch/s390/Kconfig	Sat Mar  8 23:50:37 2003
+++ edited/arch/s390/Kconfig	Thu Mar 27 23:25:00 2003
@@ -7,10 +7,6 @@
 	bool
 	default y
 
-config UID16
-	bool
-	default y
-
 config RWSEM_GENERIC_SPINLOCK
 	bool
 
@@ -31,13 +27,23 @@
 	  mainframes of the S/390 generation. You should have installed the
 	  s390-compiler released by IBM (based on gcc-2.95.1) before.
 
-source "init/Kconfig"
+config UID16
+	bool
+	default y
+	depends on ARCH_S390X
 
+source "init/Kconfig"
 
 menu "Base setup"
 
 comment "Processor type and features"
 
+config ARCH_S390X
+	bool "64 bit kernel"
+	help
+	  Select this option if you have a 64 bit IBM zSeries machine
+	  and want to use the 64 bit addressing mode.
+
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---
@@ -67,16 +73,9 @@
 
 	  If you don't know what to do here, say N.
 
-config MATHEMU
-	bool "IEEE FPU emulation"
-	help
-	  This option is required for IEEE compliant floating point arithmetic
-	  on the Alpha. The only time you would ever not say Y is to say M in
-	  order to debug the code. Say Y unless you know what you are doing.
-
 config NR_CPUS
 	int "Maximum number of CPUs (2-32)"
-	depends on SMP
+	depends on SMP && ARCH_S390X = 'n'
 	default "32"
 	help
 	  This allows you to specify the maximum number of CPUs which this
@@ -85,13 +84,54 @@
 
 	  This is purely to save memory - each supported CPU adds
 	  approximately eight kilobytes to the kernel image.
+	
+config NR_CPUS
+	int "Maximum number of CPUs (2-64)"
+	depends on SMP && ARCH_S390X
+	default "64"
+	help
+	  This allows you to specify the maximum number of CPUs which this
+	  kernel will support.  The maximum supported value is 64 and the
+	  minimum value which makes sense is 2.
+
+	  This is purely to save memory - each supported CPU adds
+	  approximately sixteen kilobytes to the kernel image.
+
+config MATHEMU
+	bool "IEEE FPU emulation"
+	depends on ARCH_S390X = n
+	help
+	  This option is required for IEEE compliant floating point arithmetic
+	  on the Alpha. The only time you would ever not say Y is to say M in
+	  order to debug the code. Say Y unless you know what you are doing.
+
+config S390_SUPPORT
+	bool "Kernel support for 31 bit emulation"
+	depends on ARCH_S390X
+	help
+	  Select this option if you want to enable your system kernel to
+	  handle system-calls from ELF binaries for 31 bit ESA.  This option
+	  (and some other stuff like libraries and such) is needed for
+	  executing 31 bit applications.  It is safe to say "Y".
+
+config COMPAT
+	bool
+	depends on S390_SUPPORT
+	default y
+
+config BINFMT_ELF32
+	tristate "Kernel support for 31 bit ELF binaries"
+	depends on S390_SUPPORT
+	help
+	  This allows you to run 32-bit Linux/ELF binaries on your Ultra.
+	  Everybody wants this; say Y.
 
 comment "I/O subsystem configuration"
 
 config MACHCHK_WARNING
 	bool "Process warning machine checks"
 	help
-	  Select this option if you want the machine check handler on IBM S/390 or 
+	  Select this option if you want the machine check handler on IBM S/390 or
 	  zSeries to process warning machine checks (e.g. on power failures). 
 	  If unsure, say "Y".
 
===== arch/s390/Makefile 1.24 vs edited =====
--- 1.24/arch/s390/Makefile	Fri Mar  7 22:28:49 2003
+++ edited/arch/s390/Makefile	Sun Mar 30 03:41:46 2003
@@ -12,15 +12,35 @@
 #
 # Copyright (C) 1994 by Linus Torvalds
 #
+ifndef CONFIG_ARCH_S390X
 
 LDFLAGS		:= -m elf_s390
-OBJCOPYFLAGS	:= -O binary
-LDFLAGS_vmlinux := -e start
 LDFLAGS_BLOB	:= --format binary --oformat elf32-s390
+CFLAGS		+= -m31
+
+else
+
+LDFLAGS		:= -m elf64_s390
+MODFLAGS	+= -fpic -D__PIC__
+LDFLAGS_BLOB	:= --format binary --oformat elf64-s390
+CFLAGS		+= -m64
 
-CFLAGS += -pipe -fno-strength-reduce -finline-limit=10000 -Wno-sign-compare
+# this is a hack to use both include/asm directories
+# include/asm-s390x should be removed before 2.6
+CC		+= -Iinclude/asm-s390x 
+prepare: include/asm-s390x/asm
+include/asm-s390x/asm:
+	@ln -s . $@
+
+define src64 $$(patsubst arch/s390/%,arch/s390x/%,$(src))
+endef
+export src64
+endif
+OBJCOPYFLAGS	:= -O binary
+LDFLAGS_vmlinux := -e start
+CFLAGS 		+= -pipe -fno-strength-reduce -finline-limit-10000 -Wno-sign-compare 
 
-head-y := arch/$(ARCH)/kernel/head.o arch/$(ARCH)/kernel/init_task.o
+head-y		:= arch/$(ARCH)/kernel/head.o arch/$(ARCH)/kernel/init_task.o
 
 core-y		+= arch/$(ARCH)/mm/ arch/$(ARCH)/kernel/
 libs-y		+= arch/$(ARCH)/lib/
===== arch/s390/vmlinux.lds.S 1.10 vs edited =====
--- 1.10/arch/s390/vmlinux.lds.S	Mon Mar  3 20:37:38 2003
+++ edited/arch/s390/vmlinux.lds.S	Fri Mar 28 00:00:30 2003
@@ -3,11 +3,20 @@
  */
 
 #include <asm-generic/vmlinux.lds.h>
+#include <linux/config.h>
 
+#ifndef CONFIG_ARCH_S390X
 OUTPUT_FORMAT("elf32-s390", "elf32-s390", "elf32-s390")
 OUTPUT_ARCH(s390)
 ENTRY(_start)
 jiffies = jiffies_64 + 4;
+#else
+OUTPUT_FORMAT("elf64-s390", "elf64-s390", "elf64-s390")
+OUTPUT_ARCH(s390)
+ENTRY(_start)
+jiffies = jiffies_64;
+#endif
+
 SECTIONS
 {
   . = 0x00000000;

