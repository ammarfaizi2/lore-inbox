Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263599AbTDNR6L (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 13:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263629AbTDNR6K (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 13:58:10 -0400
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:62919 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id S263599AbTDNRpd (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 13:45:33 -0400
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (10/16): s390/s390x unification - part 1.
Date: Mon, 14 Apr 2003 19:52:17 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304141952.17432.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Merge s390x and s390 to one architecture.

diffstat:
 Makefile                              |    4 
 arch/s390/Kconfig                     |   97 ++-
 arch/s390/Makefile                    |   22 
 arch/s390/boot/Makefile               |   17 
 arch/s390/defconfig                   |    6 
 arch/s390/kernel/Makefile             |   26 
 arch/s390/kernel/binfmt_elf32.c       |  214 ++++++
 arch/s390/kernel/compat_exec.c        |   93 ++
 arch/s390/kernel/compat_exec_domain.c |   30 
 arch/s390/kernel/compat_ioctl.c       | 1084 ++++++++++++++++++++++++++++++++++
 10 files changed, 1539 insertions(+), 54 deletions(-)

diff -urN linux-2.5.67/Makefile linux-2.5.67-s390/Makefile
--- linux-2.5.67/Makefile	Mon Apr 14 19:11:34 2003
+++ linux-2.5.67-s390/Makefile	Mon Apr 14 19:11:54 2003
@@ -33,7 +33,9 @@
 # then ARCH is assigned, getting whatever value it gets normally, and 
 # SUBARCH is subsequently ignored.
 
-SUBARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/)
+SUBARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ \
+				  -e s/arm.*/arm/ -e s/sa110/arm/ \
+				  -e s/s390x/s390/ )
 ARCH := $(SUBARCH)
 
 # Remove hyphens since they have special meaning in RPM filenames
diff -urN linux-2.5.67/arch/s390/Kconfig linux-2.5.67-s390/arch/s390/Kconfig
--- linux-2.5.67/arch/s390/Kconfig	Mon Apr  7 19:31:05 2003
+++ linux-2.5.67-s390/arch/s390/Kconfig	Mon Apr 14 19:11:54 2003
@@ -7,10 +7,6 @@
 	bool
 	default y
 
-config UID16
-	bool
-	default y
-
 config RWSEM_GENERIC_SPINLOCK
 	bool
 
@@ -26,18 +22,29 @@
 config ARCH_S390
 	bool
 	default y
-	help
-	  Select this option, if you want to run the Kernel on one of IBM's
-	  mainframes of the S/390 generation. You should have installed the
-	  s390-compiler released by IBM (based on gcc-2.95.1) before.
 
-source "init/Kconfig"
+config UID16
+	bool
+	default y
+	depends on ARCH_S390X = 'n'
 
+source "init/Kconfig"
 
 menu "Base setup"
 
 comment "Processor type and features"
 
+config ARCH_S390X
+	bool "64 bit kernel"
+	help
+	  Select this option if you have a 64 bit IBM zSeries machine
+	  and want to use the 64 bit addressing mode.
+
+config ARCH_S390_31
+	bool
+	depends on ARCH_S390X = 'n'
+	default y
+
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---
@@ -51,32 +58,15 @@
 	  singleprocessor machines. On a singleprocessor machine, the kernel
 	  will run faster if you say N here.
 
-	  Note that if you say Y here and choose architecture "586" or
-	  "Pentium" under "Processor family", the kernel will not work on 486
-	  architectures. Similarly, multiprocessor kernels for the "PPro"
-	  architecture may not work on all Pentium based boards.
-
-	  People using multiprocessor machines who say Y here should also say
-	  Y to "Enhanced Real Time Clock Support", below. The "Advanced Power
-	  Management" code will be disabled if you say Y here.
-
 	  See also the <file:Documentation/smp.tex>,
-	  <file:Documentation/smp.txt>, <file:Documentation/i386/IO-APIC.txt>,
-	  <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO available at
+	  <file:Documentation/smp.txt> and the SMP-HOWTO available at
 	  <http://www.linuxdoc.org/docs.html#howto>.
 
-	  If you don't know what to do here, say N.
-
-config MATHEMU
-	bool "IEEE FPU emulation"
-	help
-	  This option is required for IEEE compliant floating point arithmetic
-	  on the Alpha. The only time you would ever not say Y is to say M in
-	  order to debug the code. Say Y unless you know what you are doing.
+	  Even if you don't know what to do here, say Y.
 
 config NR_CPUS
 	int "Maximum number of CPUs (2-32)"
-	depends on SMP
+	depends on SMP && ARCH_S390X = 'n'
 	default "32"
 	help
 	  This allows you to specify the maximum number of CPUs which this
@@ -85,13 +75,54 @@
 
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
+	  on older S/390 machines. Say Y unless you know your machine doesn't 
+	  need this.
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
+	  This allows you to run 32-bit Linux/ELF binaries on your zSeries
+	  in 64 bit mode. Everybody wants this; say Y.
 
 comment "I/O subsystem configuration"
 
 config MACHCHK_WARNING
 	bool "Process warning machine checks"
 	help
-	  Select this option if you want the machine check handler on IBM S/390 or 
+	  Select this option if you want the machine check handler on IBM S/390 or
 	  zSeries to process warning machine checks (e.g. on power failures). 
 	  If unsure, say "Y".
 
@@ -144,15 +175,15 @@
 	prompt "IPL method generated into head.S"
 	depends on IPL
 	default IPL_TAPE
-
-config IPL_TAPE
-	bool "tape"
 	help
 	  Select "tape" if you want to IPL the image from a Tape.
 
 	  Select "vm_reader" if you are running under VM/ESA and want
 	  to IPL the image from the emulated card reader.
 
+config IPL_TAPE
+	bool "tape"
+
 config IPL_VM
 	bool "vm_reader"
 
diff -urN linux-2.5.67/arch/s390/Makefile linux-2.5.67-s390/arch/s390/Makefile
--- linux-2.5.67/arch/s390/Makefile	Mon Apr  7 19:30:44 2003
+++ linux-2.5.67-s390/arch/s390/Makefile	Mon Apr 14 19:11:54 2003
@@ -13,14 +13,28 @@
 # Copyright (C) 1994 by Linus Torvalds
 #
 
+ifdef CONFIG_ARCH_S390_31
 LDFLAGS		:= -m elf_s390
-OBJCOPYFLAGS	:= -O binary
-LDFLAGS_vmlinux := -e start
 LDFLAGS_BLOB	:= --format binary --oformat elf32-s390
+CFLAGS		+= -m31
+UTS_MACHINE	:= s390
+endif
+
+ifdef CONFIG_ARCH_S390X
+LDFLAGS		:= -m elf64_s390
+MODFLAGS	+= -fpic -D__PIC__
+LDFLAGS_BLOB	:= --format binary --oformat elf64-s390
+CFLAGS		+= -m64
+UTS_MACHINE	:= s390x
+endif
 
-CFLAGS += -pipe -fno-strength-reduce -finline-limit=10000 -Wno-sign-compare
+OBJCOPYFLAGS	:= -O binary
+LDFLAGS_vmlinux := -e start
+CFLAGS 		+= -pipe -fno-strength-reduce -finline-limit-10000 -Wno-sign-compare 
 
-head-y := arch/$(ARCH)/kernel/head.o arch/$(ARCH)/kernel/init_task.o
+head-$(CONFIG_ARCH_S390_31)	+= arch/$(ARCH)/kernel/head.o
+head-$(CONFIG_ARCH_S390X)	+= arch/$(ARCH)/kernel/head64.o
+head-y				+= arch/$(ARCH)/kernel/init_task.o
 
 core-y		+= arch/$(ARCH)/mm/ arch/$(ARCH)/kernel/
 libs-y		+= arch/$(ARCH)/lib/
diff -urN linux-2.5.67/arch/s390/boot/Makefile linux-2.5.67-s390/arch/s390/boot/Makefile
--- linux-2.5.67/arch/s390/boot/Makefile	Mon Apr  7 19:33:03 2003
+++ linux-2.5.67-s390/arch/s390/boot/Makefile	Mon Apr 14 19:11:54 2003
@@ -2,18 +2,17 @@
 # Makefile for the linux s390-specific parts of the memory manager.
 #
 
-targets		:= image listing
-EXTRA_AFLAGS	:= -traditional
-quiet_cmd_listing = OBJDUMP $@
-      cmd_listing = $(OBJDUMP) --disassemble --disassemble-all \
-			       --disassemble-zeroes --reloc vmlinux > $@
+COMPILE_VERSION := __linux_compile_version_id__`hostname |  \
+			tr -c '[0-9A-Za-z]' '_'`__`date | \
+			tr -c '[0-9A-Za-z]' '_'`_t
 
-$(obj)/image: vmlinux FORCE
-	$(call if_changed,objcopy)
+EXTRA_CFLAGS  := -DCOMPILE_VERSION=$(COMPILE_VERSION) -gstabs -I .
+EXTRA_AFLAGS  := -traditional
 
-$(obj)/listing: vmlinux FORCE
-	$(call if_changed,listing)
+targets := image
 
+$(obj)/image: vmlinux FORCE
+	$(call if_changed,objcopy)
 
 install: $(CONFIGURE) $(obj)/image
 	sh -x $(obj)/install.sh $(KERNELRELEASE) $(obj)/image \
diff -urN linux-2.5.67/arch/s390/defconfig linux-2.5.67-s390/arch/s390/defconfig
--- linux-2.5.67/arch/s390/defconfig	Mon Apr 14 19:11:45 2003
+++ linux-2.5.67-s390/arch/s390/defconfig	Mon Apr 14 19:11:54 2003
@@ -2,9 +2,9 @@
 # Automatically generated make config: don't edit
 #
 CONFIG_MMU=y
-CONFIG_UID16=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 CONFIG_ARCH_S390=y
+CONFIG_UID16=y
 
 #
 # Code maturity level options
@@ -36,9 +36,11 @@
 #
 # Processor type and features
 #
+# CONFIG_ARCH_S390X is not set
+CONFIG_ARCH_S390_31=y
 CONFIG_SMP=y
-CONFIG_MATHEMU=y
 CONFIG_NR_CPUS=32
+CONFIG_MATHEMU=y
 
 #
 # I/O subsystem configuration
diff -urN linux-2.5.67/arch/s390/kernel/Makefile linux-2.5.67-s390/arch/s390/kernel/Makefile
--- linux-2.5.67/arch/s390/kernel/Makefile	Mon Apr  7 19:32:52 2003
+++ linux-2.5.67-s390/arch/s390/kernel/Makefile	Mon Apr 14 19:11:54 2003
@@ -2,17 +2,33 @@
 # Makefile for the linux kernel.
 #
 
-extra-y		:= head.o init_task.o
 EXTRA_AFLAGS	:= -traditional
 
-obj-y	:= entry.o bitmap.o traps.o time.o process.o \
+obj-y	:=  bitmap.o traps.o time.o process.o \
             setup.o sys_s390.o ptrace.o signal.o cpcmd.o ebcdic.o \
-            semaphore.o reipl.o s390_ext.o debug.o
+            semaphore.o s390_ext.o debug.o
+
+extra-$(CONFIG_ARCH_S390_31)	+= head.o 
+extra-$(CONFIG_ARCH_S390X)	+= head64.o 
+extra-y				+= init_task.o
 
 obj-$(CONFIG_MODULES)		+= s390_ksyms.o module.o
 obj-$(CONFIG_SMP)		+= smp.o
 
+obj-$(CONFIG_S390_SUPPORT)	+= compat_linux.o compat_signal.o \
+					compat_ioctl.o compat_wrapper.o \
+					compat_exec.o compat_exec_domain.o
+obj-$(CONFIG_BINFMT_ELF32)	+= binfmt_elf32.o
+
+obj-$(CONFIG_ARCH_S390_31)	+= entry.o reipl.o
+obj-$(CONFIG_ARCH_S390X)	+= entry64.o reipl64.o
+
+ifdef CONFIG_ARCH_S390X
+$(obj)%.o: $(patsubst arch/s390/%,arch/s390x/%,$(src))%.c
+	$(call if_changed_dep,cc_o_c)
+endif
+
 #
-# Kernel debugging
+# This is just to get the dependencies...
 #
-obj-$(CONFIG_REMOTE_DEBUG)	+= gdb-stub.o #gdb-low.o 
+binfmt_elf32.o:	$(TOPDIR)/fs/binfmt_elf.c
diff -urN linux-2.5.67/arch/s390/kernel/binfmt_elf32.c linux-2.5.67-s390/arch/s390/kernel/binfmt_elf32.c
--- linux-2.5.67/arch/s390/kernel/binfmt_elf32.c	Thu Jan  1 01:00:00 1970
+++ linux-2.5.67-s390/arch/s390/kernel/binfmt_elf32.c	Mon Apr 14 19:11:54 2003
@@ -0,0 +1,214 @@
+/*
+ * Support for 32-bit Linux for S390 ELF binaries.
+ *
+ * Copyright (C) 2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ * Author(s): Gerhard Tonn (ton@de.ibm.com)
+ *
+ * Heavily inspired by the 32-bit Sparc compat code which is
+ * Copyright (C) 1995, 1996, 1997, 1998 David S. Miller (davem@redhat.com)
+ * Copyright (C) 1995, 1996, 1997, 1998 Jakub Jelinek   (jj@ultra.linux.cz)
+ */
+
+#define __ASMS390_ELF_H
+
+#include <linux/time.h>
+
+/*
+ * These are used to set parameters in the core dumps.
+ */
+#define ELF_CLASS	ELFCLASS32
+#define ELF_DATA	ELFDATA2MSB
+#define ELF_ARCH	EM_S390
+
+/*
+ * This is used to ensure we don't load something for the wrong architecture.
+ */
+#define elf_check_arch(x) \
+	(((x)->e_machine == EM_S390 || (x)->e_machine == EM_S390_OLD) \
+         && (x)->e_ident[EI_CLASS] == ELF_CLASS)
+
+/* ELF register definitions */
+#define NUM_GPRS      16
+#define NUM_FPRS      16
+#define NUM_ACRS      16    
+
+#define TASK31_SIZE		(0x80000000UL)
+
+/* For SVR4/S390 the function pointer to be registered with `atexit` is
+   passed in R14. */
+#define ELF_PLAT_INIT(_r, load_addr) \
+	do { \
+	_r->gprs[14] = 0; \
+	set_thread_flag(TIF_31BIT); \
+	} while(0)
+
+#define USE_ELF_CORE_DUMP
+#define ELF_EXEC_PAGESIZE       4096
+
+/* This is the location that an ET_DYN program is loaded if exec'ed.  Typical
+   use of this is to invoke "./ld.so someprog" to test out a new version of
+   the loader.  We need to make sure that it is out of the way of the program
+   that it will "exec", and that there is sufficient room for the brk.  */
+
+#define ELF_ET_DYN_BASE         (TASK31_SIZE / 3 * 2)
+
+/* Wow, the "main" arch needs arch dependent functions too.. :) */
+
+/* regs is struct pt_regs, pr_reg is elf_gregset_t (which is
+   now struct_user_regs, they are different) */
+
+#define ELF_CORE_COPY_REGS(pr_reg, regs)        \
+	{ \
+	int i; \
+	memcpy(&pr_reg.psw.mask, &regs->psw.mask, 4); \
+	memcpy(&pr_reg.psw.addr, ((char*)&regs->psw.addr)+4, 4); \
+	for(i=0; i<NUM_GPRS; i++) \
+		pr_reg.gprs[i] = regs->gprs[i]; \
+	for(i=0; i<NUM_ACRS; i++) \
+		pr_reg.acrs[i] = regs->acrs[i]; \
+	pr_reg.orig_gpr2 = regs->orig_gpr2; \
+	}
+
+
+
+/* This yields a mask that user programs can use to figure out what
+   instruction set this CPU supports. */
+
+#define ELF_HWCAP (0)
+
+/* This yields a string that ld.so will use to load implementation
+   specific libraries for optimization.  This is more specific in
+   intent than poking at uname or /proc/cpuinfo.
+
+   For the moment, we have only optimizations for the Intel generations,
+   but that could change... */
+
+#define ELF_PLATFORM (NULL)
+
+#define SET_PERSONALITY(ex, ibcs2)			\
+do {							\
+	if (ibcs2)                                      \
+		set_personality(PER_SVR4);              \
+	else if (current->personality != PER_LINUX32)   \
+		set_personality(PER_LINUX);             \
+} while (0)
+
+#include "compat_linux.h"
+
+typedef _s390_fp_regs32 elf_fpregset_t;
+
+typedef struct
+{
+	
+	_psw_t32	psw;
+	__u32		gprs[__NUM_GPRS]; 
+	__u32		acrs[__NUM_ACRS]; 
+	__u32		orig_gpr2;
+} s390_regs32;
+typedef s390_regs32 elf_gregset_t;
+
+#include <asm/processor.h>
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/elfcore.h>
+#include <linux/binfmts.h>
+#include <linux/compat.h>
+
+int setup_arg_pages32(struct linux_binprm *bprm);
+
+#define elf_prstatus elf_prstatus32
+struct elf_prstatus32
+{
+	struct elf_siginfo pr_info;	/* Info associated with signal */
+	short	pr_cursig;		/* Current signal */
+	u32	pr_sigpend;	/* Set of pending signals */
+	u32	pr_sighold;	/* Set of held signals */
+	pid_t	pr_pid;
+	pid_t	pr_ppid;
+	pid_t	pr_pgrp;
+	pid_t	pr_sid;
+	struct compat_timeval pr_utime;	/* User time */
+	struct compat_timeval pr_stime;	/* System time */
+	struct compat_timeval pr_cutime;	/* Cumulative user time */
+	struct compat_timeval pr_cstime;	/* Cumulative system time */
+	elf_gregset_t pr_reg;	/* GP registers */
+	int pr_fpvalid;		/* True if math co-processor being used.  */
+};
+
+#define elf_prpsinfo elf_prpsinfo32
+struct elf_prpsinfo32
+{
+	char	pr_state;	/* numeric process state */
+	char	pr_sname;	/* char for pr_state */
+	char	pr_zomb;	/* zombie */
+	char	pr_nice;	/* nice val */
+	u32	pr_flag;	/* flags */
+	u16	pr_uid;
+	u16	pr_gid;
+	pid_t	pr_pid, pr_ppid, pr_pgrp, pr_sid;
+	/* Lots missing */
+	char	pr_fname[16];	/* filename of executable */
+	char	pr_psargs[ELF_PRARGSZ];	/* initial part of arg list */
+};
+
+#include <linux/highuid.h>
+
+#undef NEW_TO_OLD_UID
+#undef NEW_TO_OLD_GID
+#define NEW_TO_OLD_UID(uid) ((uid) > 65535) ? (u16)overflowuid : (u16)(uid)
+#define NEW_TO_OLD_GID(gid) ((gid) > 65535) ? (u16)overflowgid : (u16)(gid) 
+
+#define elf_addr_t	u32
+/*
+#define init_elf_binfmt init_elf32_binfmt
+*/
+#undef CONFIG_BINFMT_ELF
+#ifdef CONFIG_BINFMT_ELF32
+#define CONFIG_BINFMT_ELF CONFIG_BINFMT_ELF32
+#endif
+#undef CONFIG_BINFMT_ELF_MODULE
+#ifdef CONFIG_BINFMT_ELF32_MODULE
+#define CONFIG_BINFMT_ELF_MODULE CONFIG_BINFMT_ELF32_MODULE
+#endif
+
+#undef start_thread
+#define start_thread                    start_thread31 
+#define setup_arg_pages(bprm)           setup_arg_pages32(bprm)
+#define elf_map				elf_map32
+
+MODULE_DESCRIPTION("Binary format loader for compatibility with 32bit Linux for S390 binaries,"
+                   " Copyright 2000 IBM Corporation"); 
+MODULE_AUTHOR("Gerhard Tonn <ton@de.ibm.com>");
+
+#undef MODULE_DESCRIPTION
+#undef MODULE_AUTHOR
+
+#define jiffies_to_timeval jiffies_to_compat_timeval
+static __inline__ void
+jiffies_to_compat_timeval(unsigned long jiffies, struct compat_timeval *value)
+{
+	value->tv_usec = (jiffies % HZ) * (1000000L / HZ);
+	value->tv_sec = jiffies / HZ;
+}
+
+#include "../../../fs/binfmt_elf.c"
+
+static unsigned long
+elf_map32 (struct file *filep, unsigned long addr, struct elf_phdr *eppnt, int prot, int type)
+{
+	unsigned long map_addr;
+
+	if (!addr) 
+		addr = 0x40000000; 
+
+	if (prot & PROT_READ) 
+		prot |= PROT_EXEC; 
+
+	down_write(&current->mm->mmap_sem);
+	map_addr = do_mmap(filep, ELF_PAGESTART(addr),
+			   eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr),
+			   prot, type,
+			   eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr));
+	up_write(&current->mm->mmap_sem);
+	return(map_addr);
+}
diff -urN linux-2.5.67/arch/s390/kernel/compat_exec.c linux-2.5.67-s390/arch/s390/kernel/compat_exec.c
--- linux-2.5.67/arch/s390/kernel/compat_exec.c	Thu Jan  1 01:00:00 1970
+++ linux-2.5.67-s390/arch/s390/kernel/compat_exec.c	Mon Apr 14 19:11:54 2003
@@ -0,0 +1,93 @@
+/*
+ * Support for 32-bit Linux for S390 ELF binaries.
+ *
+ * Copyright (C) 2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ * Author(s): Gerhard Tonn (ton@de.ibm.com)
+ *
+ * Separated from binfmt_elf32.c to reduce exports for module enablement.
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/slab.h>
+#include <linux/file.h>
+#include <linux/mman.h>
+#include <linux/a.out.h>
+#include <linux/stat.h>
+#include <linux/fcntl.h>
+#include <linux/smp_lock.h>
+#include <linux/init.h>
+#include <linux/pagemap.h>
+#include <linux/highmem.h>
+#include <linux/spinlock.h>
+#include <linux/binfmts.h>
+#include <linux/module.h>
+
+#include <asm/uaccess.h>
+#include <asm/pgalloc.h>
+#include <asm/mmu_context.h>
+
+#ifdef CONFIG_KMOD
+#include <linux/kmod.h>
+#endif
+
+
+extern void put_dirty_page(struct task_struct * tsk, struct page *page, unsigned long address);
+
+#undef STACK_TOP
+#define STACK_TOP TASK31_SIZE
+
+int setup_arg_pages32(struct linux_binprm *bprm)
+{
+	unsigned long stack_base;
+	struct vm_area_struct *mpnt;
+	struct mm_struct *mm = current->mm;
+	int i;
+
+	stack_base = STACK_TOP - MAX_ARG_PAGES*PAGE_SIZE;
+	mm->arg_start = bprm->p + stack_base;
+
+	bprm->p += stack_base;
+	if (bprm->loader)
+		bprm->loader += stack_base;
+	bprm->exec += stack_base;
+
+	mpnt = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+	if (!mpnt) 
+		return -ENOMEM; 
+	
+	if (!vm_enough_memory((STACK_TOP - (PAGE_MASK & (unsigned long) bprm->p))>>PAGE_SHIFT)) {
+		kmem_cache_free(vm_area_cachep, mpnt);
+		return -ENOMEM;
+	}
+
+	down_write(&mm->mmap_sem);
+	{
+		mpnt->vm_mm = mm;
+		mpnt->vm_start = PAGE_MASK & (unsigned long) bprm->p;
+		mpnt->vm_end = STACK_TOP;
+		mpnt->vm_page_prot = PAGE_COPY;
+		mpnt->vm_flags = VM_STACK_FLAGS;
+		mpnt->vm_ops = NULL;
+		mpnt->vm_pgoff = 0;
+		mpnt->vm_file = NULL;
+		INIT_LIST_HEAD(&mpnt->shared);
+		mpnt->vm_private_data = (void *) 0;
+		insert_vm_struct(mm, mpnt);
+		mm->total_vm = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
+	} 
+
+	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
+		struct page *page = bprm->page[i];
+		if (page) {
+			bprm->page[i] = NULL;
+			put_dirty_page(current,page,stack_base);
+		}
+		stack_base += PAGE_SIZE;
+	}
+	up_write(&mm->mmap_sem);
+	
+	return 0;
+}
+
+EXPORT_SYMBOL(setup_arg_pages32);
diff -urN linux-2.5.67/arch/s390/kernel/compat_exec_domain.c linux-2.5.67-s390/arch/s390/kernel/compat_exec_domain.c
--- linux-2.5.67/arch/s390/kernel/compat_exec_domain.c	Thu Jan  1 01:00:00 1970
+++ linux-2.5.67-s390/arch/s390/kernel/compat_exec_domain.c	Mon Apr 14 19:11:54 2003
@@ -0,0 +1,30 @@
+/*
+ * Support for 32-bit Linux for S390 personality.
+ *
+ * Copyright (C) 2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ * Author(s): Gerhard Tonn (ton@de.ibm.com)
+ *
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/personality.h>
+#include <linux/sched.h>
+
+struct exec_domain s390_exec_domain;
+
+static int __init
+s390_init (void)
+{
+	s390_exec_domain.name = "Linux/s390";
+	s390_exec_domain.handler = NULL;
+	s390_exec_domain.pers_low = PER_LINUX32;
+	s390_exec_domain.pers_high = PER_LINUX32;
+	s390_exec_domain.signal_map = default_exec_domain.signal_map;
+	s390_exec_domain.signal_invmap = default_exec_domain.signal_invmap;
+	register_exec_domain(&s390_exec_domain);
+	return 0;
+}
+
+__initcall(s390_init);
diff -urN linux-2.5.67/arch/s390/kernel/compat_ioctl.c linux-2.5.67-s390/arch/s390/kernel/compat_ioctl.c
--- linux-2.5.67/arch/s390/kernel/compat_ioctl.c	Thu Jan  1 01:00:00 1970
+++ linux-2.5.67-s390/arch/s390/kernel/compat_ioctl.c	Mon Apr 14 19:11:55 2003
@@ -0,0 +1,1084 @@
+/*
+ * ioctl32.c: Conversion between 32bit and 64bit native ioctls.
+ *
+ *  S390 version
+ *    Copyright (C) 2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Author(s): Gerhard Tonn (ton@de.ibm.com)
+ *
+ * Heavily inspired by the 32-bit Sparc compat code which is  
+ * Copyright (C) 2000 Silicon Graphics, Inc.
+ * Written by Ulf Carlsson (ulfc@engr.sgi.com) 
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/compat.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/file.h>
+#include <linux/vt.h>
+#include <linux/kd.h>
+#include <linux/netdevice.h>
+#include <linux/route.h>
+#include <linux/ext2_fs.h>
+#include <linux/hdreg.h>
+#include <linux/if_bonding.h>
+#include <linux/blkpg.h>
+#include <linux/blk.h>
+#include <linux/dm-ioctl.h>
+#include <linux/loop.h>
+#include <linux/elevator.h>
+#include <asm/types.h>
+#include <asm/uaccess.h>
+#include <asm/dasd.h>
+#include <asm/tape390.h>
+#include <asm/sockios.h>
+#include <asm/ioctls.h>
+
+#include "compat_linux.h"
+
+long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
+
+struct hd_geometry32 {
+	unsigned char	heads;
+	unsigned char	sectors;
+	unsigned short	cylinders;
+	__u32		start;
+};  
+
+static inline int hd_geometry_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+{
+	struct hd_geometry32 *hg32 = (struct hd_geometry32 *) A(arg);
+	struct hd_geometry hg;
+	int ret;
+	mm_segment_t old_fs = get_fs();
+	
+	set_fs (KERNEL_DS);
+	ret = sys_ioctl (fd, cmd, (long)&hg);
+	set_fs (old_fs);
+
+	if (ret)
+		return ret;
+
+	ret = put_user (hg.heads, &(hg32->heads));
+	ret |= __put_user (hg.sectors, &(hg32->sectors));
+	ret |= __put_user (hg.cylinders, &(hg32->cylinders));
+	ret |= __put_user (hg.start, &(hg32->start));
+
+	return ret;
+}
+
+#define EXT2_IOC32_GETFLAGS               _IOR('f', 1, int)
+#define EXT2_IOC32_SETFLAGS               _IOW('f', 2, int)
+#define EXT2_IOC32_GETVERSION             _IOR('v', 1, int)
+#define EXT2_IOC32_SETVERSION             _IOW('v', 2, int)
+
+struct ifmap32 {
+	unsigned int mem_start;
+	unsigned int mem_end;
+	unsigned short base_addr;
+	unsigned char irq;
+	unsigned char dma;
+	unsigned char port;
+};
+
+struct ifreq32 {
+#define IFHWADDRLEN     6
+#define IFNAMSIZ        16
+        union {
+                char    ifrn_name[IFNAMSIZ];	/* if name, e.g. "en0" */
+        } ifr_ifrn;
+        union {
+                struct  sockaddr ifru_addr;
+                struct  sockaddr ifru_dstaddr;
+                struct  sockaddr ifru_broadaddr;
+                struct  sockaddr ifru_netmask;
+                struct  sockaddr ifru_hwaddr;
+                short   ifru_flags;
+                int     ifru_ivalue;
+                int     ifru_mtu;
+                struct  ifmap32 ifru_map;
+                char    ifru_slave[IFNAMSIZ];   /* Just fits the size */
+		char	ifru_newname[IFNAMSIZ];
+                __u32	ifru_data;
+        } ifr_ifru;
+};
+
+struct ifconf32 {
+        int     ifc_len;                        /* size of buffer       */
+        __u32	ifcbuf;
+};
+
+static int dev_ifname32(unsigned int fd, unsigned int cmd, unsigned long arg)
+{
+	struct ireq32 *uir32 = (struct ireq32 *) A(arg);
+	struct net_device *dev;
+	struct ifreq32 ifr32;
+
+	if (copy_from_user(&ifr32, uir32, sizeof(struct ifreq32)))
+		return -EFAULT;
+
+	read_lock(&dev_base_lock);
+	dev = __dev_get_by_index(ifr32.ifr_ifindex);
+	if (!dev) {
+		read_unlock(&dev_base_lock);
+		return -ENODEV;
+	}
+
+	strcpy(ifr32.ifr_name, dev->name);
+	read_unlock(&dev_base_lock);
+
+	if (copy_to_user(uir32, &ifr32, sizeof(struct ifreq32)))
+	    return -EFAULT;
+
+	return 0;
+}
+
+static inline int dev_ifconf(unsigned int fd, unsigned int cmd,
+			     unsigned long arg)
+{
+	struct ioconf32 *uifc32 = (struct ioconf32 *) A(arg);
+	struct ifconf32 ifc32;
+	struct ifconf ifc;
+	struct ifreq32 *ifr32;
+	struct ifreq *ifr;
+	mm_segment_t old_fs;
+	int len;
+	int err;
+
+	if (copy_from_user(&ifc32, uifc32, sizeof(struct ifconf32)))
+		return -EFAULT;
+
+	if(ifc32.ifcbuf == 0) {
+		ifc32.ifc_len = 0;
+		ifc.ifc_len = 0;
+		ifc.ifc_buf = NULL;
+	} else {
+		ifc.ifc_len = ((ifc32.ifc_len / sizeof (struct ifreq32))) *
+			sizeof (struct ifreq);
+		ifc.ifc_buf = kmalloc (ifc.ifc_len, GFP_KERNEL);
+		if (!ifc.ifc_buf)
+			return -ENOMEM;
+	}
+	ifr = ifc.ifc_req;
+	ifr32 = (struct ifreq32 *) A(ifc32.ifcbuf);
+	len = ifc32.ifc_len / sizeof (struct ifreq32);
+	while (len--) {
+		if (copy_from_user(ifr++, ifr32++, sizeof (struct ifreq32))) {
+			err = -EFAULT;
+			goto out;
+		}
+	}
+
+	old_fs = get_fs();
+	set_fs (KERNEL_DS);
+	err = sys_ioctl (fd, SIOCGIFCONF, (unsigned long)&ifc);	
+	set_fs (old_fs);
+	if (err)
+		goto out;
+
+	ifr = ifc.ifc_req;
+	ifr32 = (struct ifreq32 *) A(ifc32.ifcbuf);
+	len = ifc.ifc_len / sizeof (struct ifreq);
+	ifc32.ifc_len = len * sizeof (struct ifreq32);
+
+	while (len--) {
+		if (copy_to_user(ifr32++, ifr++, sizeof (struct ifreq32))) {
+			err = -EFAULT;
+			goto out;
+		}
+	}
+
+	if (copy_to_user(uifc32, &ifc32, sizeof(struct ifconf32))) {
+		err = -EFAULT;
+		goto out;
+	}
+out:
+	if(ifc.ifc_buf != NULL)
+		kfree (ifc.ifc_buf);
+	return err;
+}
+
+static int bond_ioctl(unsigned long fd, unsigned int cmd, unsigned long arg)
+{
+	struct ifreq ifr;
+	mm_segment_t old_fs;
+	int err, len;
+	u32 data;
+	
+	if (copy_from_user(&ifr, (struct ifreq32 *)arg, sizeof(struct ifreq32)))
+		return -EFAULT;
+	ifr.ifr_data = (__kernel_caddr_t)get_zeroed_page(GFP_KERNEL);
+	if (!ifr.ifr_data)
+		return -EAGAIN;
+
+	switch (cmd) {
+	case SIOCBONDENSLAVE:
+	case SIOCBONDRELEASE:
+	case SIOCBONDSETHWADDR:
+	case SIOCBONDCHANGEACTIVE:
+		len = IFNAMSIZ * sizeof(char);
+		break;
+	case SIOCBONDSLAVEINFOQUERY:
+		len = sizeof(struct ifslave);
+		break;
+	case SIOCBONDINFOQUERY:
+		len = sizeof(struct ifbond);
+		break;
+	default:
+		err = -EINVAL;
+		goto out;
+	};
+
+	__get_user(data, &(((struct ifreq32 *)arg)->ifr_ifru.ifru_data));
+	if (copy_from_user(ifr.ifr_data, (char *)A(data), len)) {
+		err = -EFAULT;
+		goto out;
+	}
+
+	old_fs = get_fs();
+	set_fs (KERNEL_DS);
+	err = sys_ioctl (fd, cmd, (unsigned long)&ifr);
+	set_fs (old_fs);
+	if (!err) {
+		len = copy_to_user((char *)A(data), ifr.ifr_data, len);
+		if (len)
+			err = -EFAULT;
+	}
+
+out:
+	free_page((unsigned long)ifr.ifr_data);
+	return err;
+}
+
+static inline int dev_ifsioc(unsigned int fd, unsigned int cmd,
+			     unsigned long arg)
+{
+	struct ifreq32 *uifr = (struct ifreq32 *) A(arg);
+	struct ifreq ifr;
+	mm_segment_t old_fs;
+	int err;
+	
+	switch (cmd) {
+	case SIOCSIFMAP:
+		err = copy_from_user(&ifr, uifr, sizeof(ifr.ifr_name));
+		err |= __get_user(ifr.ifr_map.mem_start, &(uifr->ifr_ifru.ifru_map.mem_start));
+		err |= __get_user(ifr.ifr_map.mem_end, &(uifr->ifr_ifru.ifru_map.mem_end));
+		err |= __get_user(ifr.ifr_map.base_addr, &(uifr->ifr_ifru.ifru_map.base_addr));
+		err |= __get_user(ifr.ifr_map.irq, &(uifr->ifr_ifru.ifru_map.irq));
+		err |= __get_user(ifr.ifr_map.dma, &(uifr->ifr_ifru.ifru_map.dma));
+		err |= __get_user(ifr.ifr_map.port, &(uifr->ifr_ifru.ifru_map.port));
+		if (err)
+			return -EFAULT;
+		break;
+	default:
+		if (copy_from_user(&ifr, uifr, sizeof(struct ifreq32)))
+			return -EFAULT;
+		break;
+	}
+	old_fs = get_fs();
+	set_fs (KERNEL_DS);
+	err = sys_ioctl (fd, cmd, (unsigned long)&ifr);
+	set_fs (old_fs);
+	if (!err) {
+		switch (cmd) {
+		case SIOCGIFFLAGS:
+		case SIOCGIFMETRIC:
+		case SIOCGIFMTU:
+		case SIOCGIFMEM:
+		case SIOCGIFHWADDR:
+		case SIOCGIFINDEX:
+		case SIOCGIFADDR:
+		case SIOCGIFBRDADDR:
+		case SIOCGIFDSTADDR:
+		case SIOCGIFNETMASK:
+		case SIOCGIFTXQLEN:
+			if (copy_to_user(uifr, &ifr, sizeof(struct ifreq32)))
+				return -EFAULT;
+			break;
+		case SIOCGIFMAP:
+			err = copy_to_user(uifr, &ifr, sizeof(ifr.ifr_name));
+			err |= __put_user(ifr.ifr_map.mem_start, &(uifr->ifr_ifru.ifru_map.mem_start));
+			err |= __put_user(ifr.ifr_map.mem_end, &(uifr->ifr_ifru.ifru_map.mem_end));
+			err |= __put_user(ifr.ifr_map.base_addr, &(uifr->ifr_ifru.ifru_map.base_addr));
+			err |= __put_user(ifr.ifr_map.irq, &(uifr->ifr_ifru.ifru_map.irq));
+			err |= __put_user(ifr.ifr_map.dma, &(uifr->ifr_ifru.ifru_map.dma));
+			err |= __put_user(ifr.ifr_map.port, &(uifr->ifr_ifru.ifru_map.port));
+			if (err)
+				err = -EFAULT;
+			break;
+		}
+	}
+	return err;
+}
+
+struct rtentry32
+{
+	unsigned int	rt_pad1;
+	struct sockaddr	rt_dst;		/* target address		*/
+	struct sockaddr	rt_gateway;	/* gateway addr (RTF_GATEWAY)	*/
+	struct sockaddr	rt_genmask;	/* target network mask (IP)	*/
+	unsigned short	rt_flags;
+	short		rt_pad2;
+	unsigned int	rt_pad3;
+	unsigned int	rt_pad4;
+	short		rt_metric;	/* +1 for binary compatibility!	*/
+	unsigned int	rt_dev;		/* forcing the device at add	*/
+	unsigned int	rt_mtu;		/* per route MTU/Window 	*/
+#ifndef __KERNEL__
+#define rt_mss	rt_mtu			/* Compatibility :-(            */
+#endif
+	unsigned int	rt_window;	/* Window clamping 		*/
+	unsigned short	rt_irtt;	/* Initial RTT			*/
+};
+
+static inline int routing_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+{
+	struct rtentry32 *ur = (struct rtentry32 *) A(arg);
+	struct rtentry r;
+	char devname[16];
+	u32 rtdev;
+	int ret;
+	mm_segment_t old_fs = get_fs();
+	
+	ret = copy_from_user (&r.rt_dst, &(ur->rt_dst), 3 * sizeof(struct sockaddr));
+	ret |= __get_user (r.rt_flags, &(ur->rt_flags));
+	ret |= __get_user (r.rt_metric, &(ur->rt_metric));
+	ret |= __get_user (r.rt_mtu, &(ur->rt_mtu));
+	ret |= __get_user (r.rt_window, &(ur->rt_window));
+	ret |= __get_user (r.rt_irtt, &(ur->rt_irtt));
+	ret |= __get_user (rtdev, &(ur->rt_dev));
+	if (rtdev) {
+		ret |= copy_from_user (devname, (char *) A(rtdev), 15);
+		r.rt_dev = devname; devname[15] = 0;
+	} else
+		r.rt_dev = 0;
+	if (ret)
+		return -EFAULT;
+	set_fs (KERNEL_DS);
+	ret = sys_ioctl (fd, cmd, (long)&r);
+	set_fs (old_fs);
+	return ret;
+}
+
+static int do_ext2_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+{
+	/* These are just misnamed, they actually get/put from/to user an int */
+	switch (cmd) {
+	case EXT2_IOC32_GETFLAGS: cmd = EXT2_IOC_GETFLAGS; break;
+	case EXT2_IOC32_SETFLAGS: cmd = EXT2_IOC_SETFLAGS; break;
+	case EXT2_IOC32_GETVERSION: cmd = EXT2_IOC_GETVERSION; break;
+	case EXT2_IOC32_SETVERSION: cmd = EXT2_IOC_SETVERSION; break;
+	}
+	return sys_ioctl(fd, cmd, arg);
+}
+
+
+struct loop_info32 {
+	int			lo_number;      /* ioctl r/o */
+	compat_dev_t	lo_device;      /* ioctl r/o */
+	unsigned int		lo_inode;       /* ioctl r/o */
+	compat_dev_t	lo_rdevice;     /* ioctl r/o */
+	int			lo_offset;
+	int			lo_encrypt_type;
+	int			lo_encrypt_key_size;    /* ioctl w/o */
+	int			lo_flags;       /* ioctl r/o */
+	char			lo_name[LO_NAME_SIZE];
+	unsigned char		lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
+	unsigned int		lo_init[2];
+	char			reserved[4];
+};
+
+static int loop_status(unsigned int fd, unsigned int cmd, unsigned long arg)
+{
+	mm_segment_t old_fs = get_fs();
+	struct loop_info l;
+	int err = -EINVAL;
+
+	switch(cmd) {
+	case LOOP_SET_STATUS:
+		err = get_user(l.lo_number, &((struct loop_info32 *)arg)->lo_number);
+		err |= __get_user(l.lo_device, &((struct loop_info32 *)arg)->lo_device);
+		err |= __get_user(l.lo_inode, &((struct loop_info32 *)arg)->lo_inode);
+		err |= __get_user(l.lo_rdevice, &((struct loop_info32 *)arg)->lo_rdevice);
+		err |= __copy_from_user((char *)&l.lo_offset, (char *)&((struct loop_info32 *)arg)->lo_offset,
+					   8 + (unsigned long)l.lo_init - (unsigned long)&l.lo_offset);
+		if (err) {
+			err = -EFAULT;
+		} else {
+			set_fs (KERNEL_DS);
+			err = sys_ioctl (fd, cmd, (unsigned long)&l);
+			set_fs (old_fs);
+		}
+		break;
+	case LOOP_GET_STATUS:
+		set_fs (KERNEL_DS);
+		err = sys_ioctl (fd, cmd, (unsigned long)&l);
+		set_fs (old_fs);
+		if (!err) {
+			err = put_user(l.lo_number, &((struct loop_info32 *)arg)->lo_number);
+			err |= __put_user(l.lo_device, &((struct loop_info32 *)arg)->lo_device);
+			err |= __put_user(l.lo_inode, &((struct loop_info32 *)arg)->lo_inode);
+			err |= __put_user(l.lo_rdevice, &((struct loop_info32 *)arg)->lo_rdevice);
+			err |= __copy_to_user((char *)&((struct loop_info32 *)arg)->lo_offset,
+					   (char *)&l.lo_offset, (unsigned long)l.lo_init - (unsigned long)&l.lo_offset);
+			if (err)
+				err = -EFAULT;
+		}
+		break;
+	default: {
+		static int count = 0;
+		if (++count <= 20)
+			printk("%s: Unknown loop ioctl cmd, fd(%d) "
+			       "cmd(%08x) arg(%08lx)\n",
+			       __FUNCTION__, fd, cmd, arg);
+	}
+	}
+	return err;
+}
+
+
+struct blkpg_ioctl_arg32 {
+	int op;
+	int flags;
+	int datalen;
+	u32 data;
+};
+                                
+static int blkpg_ioctl_trans(unsigned int fd, unsigned int cmd, struct blkpg_ioctl_arg32 *arg)
+{
+	struct blkpg_ioctl_arg a;
+	struct blkpg_partition p;
+	int err;
+	mm_segment_t old_fs = get_fs();
+	
+	err = get_user(a.op, &arg->op);
+	err |= __get_user(a.flags, &arg->flags);
+	err |= __get_user(a.datalen, &arg->datalen);
+	err |= __get_user((long)a.data, &arg->data);
+	if (err) return err;
+	switch (a.op) {
+	case BLKPG_ADD_PARTITION:
+	case BLKPG_DEL_PARTITION:
+		if (a.datalen < sizeof(struct blkpg_partition))
+			return -EINVAL;
+                if (copy_from_user(&p, a.data, sizeof(struct blkpg_partition)))
+			return -EFAULT;
+		a.data = &p;
+		set_fs (KERNEL_DS);
+		err = sys_ioctl(fd, cmd, (unsigned long)&a);
+		set_fs (old_fs);
+	default:
+		return -EINVAL;
+	}                                        
+	return err;
+}
+
+
+typedef struct ica_z90_status_t {
+  int totalcount;
+  int leedslitecount;
+  int leeds2count;
+  int requestqWaitCount;
+  int pendingqWaitCount;
+  int totalOpenCount;
+  int cryptoDomain;
+  unsigned char status[64];
+  unsigned char qdepth[64];
+} ica_z90_status;
+
+typedef struct _ica_rsa_modexpo {
+  char         *inputdata;
+  unsigned int  inputdatalength;
+  char         *outputdata;
+  unsigned int  outputdatalength;
+  char         *b_key;
+  char         *n_modulus;
+} ica_rsa_modexpo_t;
+
+typedef struct _ica_rsa_modexpo_32 {
+  u32          inputdata;
+  u32          inputdatalength;
+  u32          outputdata;
+  u32          outputdatalength;
+  u32          b_key;
+  u32          n_modulus;
+} ica_rsa_modexpo_32_t;
+
+typedef struct _ica_rsa_modexpo_crt {
+  char         *inputdata;
+  unsigned int  inputdatalength;
+  char         *outputdata;
+  unsigned int  outputdatalength;
+  char         *bp_key;
+  char         *bq_key;
+  char         *np_prime;
+  char         *nq_prime;
+  char         *u_mult_inv;
+} ica_rsa_modexpo_crt_t;
+
+typedef struct _ica_rsa_modexpo_crt_32 {
+  u32          inputdata;
+  u32          inputdatalength;
+  u32          outputdata;
+  u32          outputdatalength;
+  u32          bp_key;
+  u32          bq_key;
+  u32          np_prime;
+  u32          nq_prime;
+  u32          u_mult_inv;
+} ica_rsa_modexpo_crt_32_t;
+
+#define ICA_IOCTL_MAGIC 'z'
+#define ICARSAMODEXPO   _IOC(_IOC_READ|_IOC_WRITE, ICA_IOCTL_MAGIC, 0x05, 0)
+#define ICARSACRT       _IOC(_IOC_READ|_IOC_WRITE, ICA_IOCTL_MAGIC, 0x06, 0) 
+#define ICARSAMODMULT   _IOC(_IOC_READ|_IOC_WRITE, ICA_IOCTL_MAGIC, 0x07, 0)
+#define ICAZ90STATUS    _IOC(_IOC_READ, ICA_IOCTL_MAGIC, 0x10, sizeof(ica_z90_status))
+#define ICAZ90QUIESCE   _IOC(_IOC_NONE, ICA_IOCTL_MAGIC, 0x11, 0)
+#define ICAZ90HARDRESET _IOC(_IOC_NONE, ICA_IOCTL_MAGIC, 0x12, 0)
+#define ICAZ90HARDERROR _IOC(_IOC_NONE, ICA_IOCTL_MAGIC, 0x13, 0)
+
+static int do_rsa_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+{
+	mm_segment_t old_fs = get_fs();
+	int err = 0;
+	ica_rsa_modexpo_t rsa;
+	ica_rsa_modexpo_32_t *rsa32 = (ica_rsa_modexpo_32_t *)arg;
+	u32 inputdata, outputdata, b_key, n_modulus;
+
+	memset (&rsa, 0, sizeof(rsa));
+
+	err |= __get_user (inputdata, &rsa32->inputdata);
+	err |= __get_user (rsa.inputdatalength, &rsa32->inputdatalength);
+	err |= __get_user (outputdata, &rsa32->outputdata);
+	err |= __get_user (rsa.outputdatalength, &rsa32->outputdatalength);
+	err |= __get_user (b_key, &rsa32->b_key);
+	err |= __get_user (n_modulus, &rsa32->n_modulus);
+	if (err)
+		return -EFAULT;
+
+	rsa.inputdata = (char *)kmalloc(rsa.inputdatalength, GFP_KERNEL);
+	if (!rsa.inputdata) {
+		err = -ENOMEM;
+		goto cleanup;
+	}
+	if (copy_from_user(rsa.inputdata, (char *)(u64)(inputdata & 0x7fffffff), 
+			   rsa.inputdatalength)) {
+		err = -EFAULT;
+		goto cleanup;
+	}
+
+	rsa.outputdata = (char *)kmalloc(rsa.outputdatalength, GFP_KERNEL);
+	if (!rsa.outputdata) {
+		err = -ENOMEM;
+		goto cleanup;
+	}
+
+	rsa.b_key = (char *)kmalloc(rsa.inputdatalength, GFP_KERNEL);
+	if (!rsa.b_key) {
+		err = -ENOMEM;
+		goto cleanup;
+	}
+	if (copy_from_user(rsa.b_key, (char *)(u64)(b_key & 0x7fffffff), 
+			   rsa.inputdatalength)) {
+		err = -EFAULT;
+		goto cleanup;
+	}
+
+	rsa.n_modulus = (char *)kmalloc(rsa.inputdatalength, GFP_KERNEL);
+	if (!rsa.n_modulus) {
+		err = -ENOMEM;
+		goto cleanup;
+	}
+	if (copy_from_user(rsa.n_modulus, (char *)(u64)(n_modulus & 0x7fffffff), 
+			   rsa.inputdatalength)) {
+		err = -EFAULT;
+		goto cleanup;
+	}
+
+	set_fs(KERNEL_DS);
+	err = sys_ioctl(fd, cmd, (unsigned long)&rsa);
+	set_fs(old_fs);
+	if (err < 0)
+		goto cleanup;
+
+	if (copy_to_user((char *)(u64)(outputdata & 0x7fffffff), rsa.outputdata,
+			 rsa.outputdatalength))
+		err = -EFAULT;
+
+cleanup:
+	if (rsa.inputdata)
+		kfree(rsa.inputdata);
+	if (rsa.outputdata)
+		kfree(rsa.outputdata);
+	if (rsa.b_key)
+		kfree(rsa.b_key);
+	if (rsa.n_modulus)
+		kfree(rsa.n_modulus);
+	
+	return err;
+}
+
+static int do_rsa_crt_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+{
+	mm_segment_t old_fs = get_fs();
+	int err = 0;
+	ica_rsa_modexpo_crt_t rsa;
+	ica_rsa_modexpo_crt_32_t *rsa32 = (ica_rsa_modexpo_crt_32_t *)arg;
+	u32 inputdata, outputdata, bp_key, bq_key, np_prime, nq_prime, u_mult_inv;
+
+	memset (&rsa, 0, sizeof(rsa));
+
+	err |= __get_user (inputdata, &rsa32->inputdata);
+	err |= __get_user (rsa.inputdatalength, &rsa32->inputdatalength);
+	err |= __get_user (outputdata, &rsa32->outputdata);
+	err |= __get_user (rsa.outputdatalength, &rsa32->outputdatalength);
+	err |= __get_user (bp_key, &rsa32->bp_key);
+	err |= __get_user (bq_key, &rsa32->bq_key);
+	err |= __get_user (np_prime, &rsa32->np_prime);
+	err |= __get_user (nq_prime, &rsa32->nq_prime);
+	err |= __get_user (u_mult_inv, &rsa32->u_mult_inv);
+	if (err)
+		return -EFAULT;
+
+	rsa.inputdata = (char *)kmalloc(rsa.inputdatalength, GFP_KERNEL);
+	if (!rsa.inputdata) {
+		err = -ENOMEM;
+		goto cleanup;
+	}
+	if (copy_from_user(rsa.inputdata, (char *)(u64)(inputdata & 0x7fffffff), 
+			   rsa.inputdatalength)) {
+		err = -EFAULT;
+		goto cleanup;
+	}
+
+	rsa.outputdata = (char *)kmalloc(rsa.outputdatalength, GFP_KERNEL);
+	if (!rsa.outputdata) {
+		err = -ENOMEM;
+		goto cleanup;
+	}
+
+	rsa.bp_key = (char *)kmalloc(rsa.inputdatalength/2 + 8, GFP_KERNEL);
+	if (!rsa.bp_key) {
+		err = -ENOMEM;
+		goto cleanup;
+	}
+	if (copy_from_user(rsa.bp_key, (char *)(u64)(bp_key & 0x7fffffff), 
+			   rsa.inputdatalength/2 + 8)) {
+		err = -EFAULT;
+		goto cleanup;
+	}
+
+	rsa.bq_key = (char *)kmalloc(rsa.inputdatalength/2, GFP_KERNEL);
+	if (!rsa.bq_key) {
+		err = -ENOMEM;
+		goto cleanup;
+	}
+	if (copy_from_user(rsa.bq_key, (char *)(u64)(bq_key & 0x7fffffff), 
+			   rsa.inputdatalength/2)) {
+		err = -EFAULT;
+		goto cleanup;
+	}
+
+	rsa.np_prime = (char *)kmalloc(rsa.inputdatalength/2 + 8, GFP_KERNEL);
+	if (!rsa.np_prime) {
+		err = -ENOMEM;
+		goto cleanup;
+	}
+	if (copy_from_user(rsa.np_prime, (char *)(u64)(np_prime & 0x7fffffff), 
+			   rsa.inputdatalength/2 + 8)) {
+		err = -EFAULT;
+		goto cleanup;
+	}
+
+	rsa.nq_prime = (char *)kmalloc(rsa.inputdatalength/2, GFP_KERNEL);
+	if (!rsa.nq_prime) {
+		err = -ENOMEM;
+		goto cleanup;
+	}
+	if (copy_from_user(rsa.nq_prime, (char *)(u64)(nq_prime & 0x7fffffff), 
+			   rsa.inputdatalength/2)) {
+		err = -EFAULT;
+		goto cleanup;
+	}
+
+	rsa.u_mult_inv = (char *)kmalloc(rsa.inputdatalength/2 + 8, GFP_KERNEL);
+	if (!rsa.u_mult_inv) {
+		err = -ENOMEM;
+		goto cleanup;
+	}
+	if (copy_from_user(rsa.u_mult_inv, (char *)(u64)(u_mult_inv & 0x7fffffff), 
+			   rsa.inputdatalength/2 + 8)) {
+		err = -EFAULT;
+		goto cleanup;
+	}
+
+	set_fs(KERNEL_DS);
+	err = sys_ioctl(fd, cmd, (unsigned long)&rsa);
+	set_fs(old_fs);
+	if (err < 0)
+		goto cleanup;
+
+	if (copy_to_user((char *)(u64)(outputdata & 0x7fffffff), rsa.outputdata,
+			 rsa.outputdatalength))
+		err = -EFAULT;
+
+cleanup:
+	if (rsa.inputdata)
+		kfree(rsa.inputdata);
+	if (rsa.outputdata)
+		kfree(rsa.outputdata);
+	if (rsa.bp_key)
+		kfree(rsa.bp_key);
+	if (rsa.bq_key)
+		kfree(rsa.bq_key);
+	if (rsa.np_prime)
+		kfree(rsa.np_prime);
+	if (rsa.nq_prime)
+		kfree(rsa.nq_prime);
+	if (rsa.u_mult_inv)
+		kfree(rsa.u_mult_inv);
+	
+	return err;
+}
+
+static int w_long(unsigned int fd, unsigned int cmd, unsigned long arg)
+{
+	mm_segment_t old_fs = get_fs();
+	int err;
+	unsigned long val;
+	
+	set_fs (KERNEL_DS);
+	err = sys_ioctl(fd, cmd, (unsigned long)&val);
+	set_fs (old_fs);
+	if (!err && put_user((unsigned int) val, (u32 *)arg))
+		return -EFAULT;
+	return err;
+}
+
+struct ioctl32_handler {
+	unsigned int cmd;
+	int (*function)(unsigned int, unsigned int, unsigned long);
+};
+
+struct ioctl32_list {
+	struct ioctl32_handler handler;
+	struct ioctl32_list *next;
+};
+
+#define IOCTL32_DEFAULT(cmd)		{ { cmd, (void *) sys_ioctl }, 0 }
+#define IOCTL32_HANDLER(cmd, handler)	{ { cmd, (void *) handler }, 0 }
+
+static struct ioctl32_list ioctl32_handler_table[] = {
+	IOCTL32_DEFAULT(FIBMAP),
+	IOCTL32_DEFAULT(FIGETBSZ),
+
+	IOCTL32_DEFAULT(DASDAPIVER),
+	IOCTL32_DEFAULT(BIODASDDISABLE),
+	IOCTL32_DEFAULT(BIODASDENABLE),
+	IOCTL32_DEFAULT(BIODASDRSRV),
+	IOCTL32_DEFAULT(BIODASDRLSE),
+	IOCTL32_DEFAULT(BIODASDSLCK),
+	IOCTL32_DEFAULT(BIODASDINFO),
+	IOCTL32_DEFAULT(BIODASDFMT),
+
+	IOCTL32_DEFAULT(TAPE390_DISPLAY),
+
+	IOCTL32_DEFAULT(BLKROSET),
+	IOCTL32_DEFAULT(BLKROGET),
+	IOCTL32_DEFAULT(BLKRRPART),
+	IOCTL32_DEFAULT(BLKFLSBUF),
+	IOCTL32_DEFAULT(BLKRASET),
+	IOCTL32_DEFAULT(BLKFRASET),
+	IOCTL32_DEFAULT(BLKSECTSET),
+	IOCTL32_DEFAULT(BLKSSZGET),
+	IOCTL32_DEFAULT(BLKBSZGET),
+	IOCTL32_DEFAULT(BLKGETSIZE64),
+
+	IOCTL32_HANDLER(HDIO_GETGEO, hd_geometry_ioctl),
+
+	IOCTL32_DEFAULT(TCGETA),
+	IOCTL32_DEFAULT(TCSETA),
+	IOCTL32_DEFAULT(TCSETAW),
+	IOCTL32_DEFAULT(TCSETAF),
+	IOCTL32_DEFAULT(TCSBRK),
+	IOCTL32_DEFAULT(TCSBRKP),
+	IOCTL32_DEFAULT(TCXONC),
+	IOCTL32_DEFAULT(TCFLSH),
+	IOCTL32_DEFAULT(TCGETS),
+	IOCTL32_DEFAULT(TCSETS),
+	IOCTL32_DEFAULT(TCSETSW),
+	IOCTL32_DEFAULT(TCSETSF),
+	IOCTL32_DEFAULT(TIOCLINUX),
+
+	IOCTL32_DEFAULT(TIOCGETD),
+	IOCTL32_DEFAULT(TIOCSETD),
+	IOCTL32_DEFAULT(TIOCEXCL),
+	IOCTL32_DEFAULT(TIOCNXCL),
+	IOCTL32_DEFAULT(TIOCCONS),
+	IOCTL32_DEFAULT(TIOCGSOFTCAR),
+	IOCTL32_DEFAULT(TIOCSSOFTCAR),
+	IOCTL32_DEFAULT(TIOCSWINSZ),
+	IOCTL32_DEFAULT(TIOCGWINSZ),
+	IOCTL32_DEFAULT(TIOCMGET),
+	IOCTL32_DEFAULT(TIOCMBIC),
+	IOCTL32_DEFAULT(TIOCMBIS),
+	IOCTL32_DEFAULT(TIOCMSET),
+	IOCTL32_DEFAULT(TIOCPKT),
+	IOCTL32_DEFAULT(TIOCNOTTY),
+	IOCTL32_DEFAULT(TIOCSTI),
+	IOCTL32_DEFAULT(TIOCOUTQ),
+	IOCTL32_DEFAULT(TIOCSPGRP),
+	IOCTL32_DEFAULT(TIOCGPGRP),
+	IOCTL32_DEFAULT(TIOCSCTTY),
+	IOCTL32_DEFAULT(TIOCGPTN),
+	IOCTL32_DEFAULT(TIOCSPTLCK),
+	IOCTL32_DEFAULT(TIOCGSERIAL),
+	IOCTL32_DEFAULT(TIOCSSERIAL),
+	IOCTL32_DEFAULT(TIOCSERGETLSR),
+
+	IOCTL32_DEFAULT(FIOCLEX),
+	IOCTL32_DEFAULT(FIONCLEX),
+	IOCTL32_DEFAULT(FIOASYNC),
+	IOCTL32_DEFAULT(FIONBIO),
+	IOCTL32_DEFAULT(FIONREAD),
+
+	IOCTL32_DEFAULT(PIO_FONT),
+	IOCTL32_DEFAULT(GIO_FONT),
+	IOCTL32_DEFAULT(KDSIGACCEPT),
+	IOCTL32_DEFAULT(KDGETKEYCODE),
+	IOCTL32_DEFAULT(KDSETKEYCODE),
+	IOCTL32_DEFAULT(KIOCSOUND),
+	IOCTL32_DEFAULT(KDMKTONE),
+	IOCTL32_DEFAULT(KDGKBTYPE),
+	IOCTL32_DEFAULT(KDSETMODE),
+	IOCTL32_DEFAULT(KDGETMODE),
+	IOCTL32_DEFAULT(KDSKBMODE),
+	IOCTL32_DEFAULT(KDGKBMODE),
+	IOCTL32_DEFAULT(KDSKBMETA),
+	IOCTL32_DEFAULT(KDGKBMETA),
+	IOCTL32_DEFAULT(KDGKBENT),
+	IOCTL32_DEFAULT(KDSKBENT),
+	IOCTL32_DEFAULT(KDGKBSENT),
+	IOCTL32_DEFAULT(KDSKBSENT),
+	IOCTL32_DEFAULT(KDGKBDIACR),
+	IOCTL32_DEFAULT(KDSKBDIACR),
+	IOCTL32_DEFAULT(KDGKBLED),
+	IOCTL32_DEFAULT(KDSKBLED),
+	IOCTL32_DEFAULT(KDGETLED),
+	IOCTL32_DEFAULT(KDSETLED),
+	IOCTL32_DEFAULT(GIO_SCRNMAP),
+	IOCTL32_DEFAULT(PIO_SCRNMAP),
+	IOCTL32_DEFAULT(GIO_UNISCRNMAP),
+	IOCTL32_DEFAULT(PIO_UNISCRNMAP),
+	IOCTL32_DEFAULT(PIO_FONTRESET),
+	IOCTL32_DEFAULT(PIO_UNIMAPCLR),
+
+	IOCTL32_DEFAULT(VT_SETMODE),
+	IOCTL32_DEFAULT(VT_GETMODE),
+	IOCTL32_DEFAULT(VT_GETSTATE),
+	IOCTL32_DEFAULT(VT_OPENQRY),
+	IOCTL32_DEFAULT(VT_ACTIVATE),
+	IOCTL32_DEFAULT(VT_WAITACTIVE),
+	IOCTL32_DEFAULT(VT_RELDISP),
+	IOCTL32_DEFAULT(VT_DISALLOCATE),
+	IOCTL32_DEFAULT(VT_RESIZE),
+	IOCTL32_DEFAULT(VT_RESIZEX),
+	IOCTL32_DEFAULT(VT_LOCKSWITCH),
+	IOCTL32_DEFAULT(VT_UNLOCKSWITCH),
+
+	IOCTL32_DEFAULT(SIOCGSTAMP),
+
+	IOCTL32_DEFAULT(DM_VERSION),
+	IOCTL32_DEFAULT(DM_REMOVE_ALL),
+	IOCTL32_DEFAULT(DM_DEV_CREATE),
+	IOCTL32_DEFAULT(DM_DEV_REMOVE),
+	IOCTL32_DEFAULT(DM_DEV_RELOAD),
+	IOCTL32_DEFAULT(DM_DEV_SUSPEND),
+	IOCTL32_DEFAULT(DM_DEV_RENAME),
+	IOCTL32_DEFAULT(DM_DEV_DEPS),
+	IOCTL32_DEFAULT(DM_DEV_STATUS),
+	IOCTL32_DEFAULT(DM_TARGET_STATUS),
+	IOCTL32_DEFAULT(DM_TARGET_WAIT),
+
+	IOCTL32_DEFAULT(LOOP_SET_FD),
+	IOCTL32_DEFAULT(LOOP_CLR_FD),
+
+	IOCTL32_HANDLER(SIOCGIFNAME, dev_ifname32),
+	IOCTL32_HANDLER(SIOCGIFCONF, dev_ifconf),
+	IOCTL32_HANDLER(SIOCGIFFLAGS, dev_ifsioc),
+	IOCTL32_HANDLER(SIOCSIFFLAGS, dev_ifsioc),
+	IOCTL32_HANDLER(SIOCGIFMETRIC, dev_ifsioc),
+	IOCTL32_HANDLER(SIOCSIFMETRIC, dev_ifsioc),
+	IOCTL32_HANDLER(SIOCGIFMTU, dev_ifsioc),
+	IOCTL32_HANDLER(SIOCSIFMTU, dev_ifsioc),
+	IOCTL32_HANDLER(SIOCGIFMEM, dev_ifsioc),
+	IOCTL32_HANDLER(SIOCSIFMEM, dev_ifsioc),
+	IOCTL32_HANDLER(SIOCGIFHWADDR, dev_ifsioc),
+	IOCTL32_HANDLER(SIOCSIFHWADDR, dev_ifsioc),
+	IOCTL32_HANDLER(SIOCADDMULTI, dev_ifsioc),
+	IOCTL32_HANDLER(SIOCDELMULTI, dev_ifsioc),
+	IOCTL32_HANDLER(SIOCGIFINDEX, dev_ifsioc),
+	IOCTL32_HANDLER(SIOCGIFMAP, dev_ifsioc),
+	IOCTL32_HANDLER(SIOCSIFMAP, dev_ifsioc),
+	IOCTL32_HANDLER(SIOCGIFADDR, dev_ifsioc),
+	IOCTL32_HANDLER(SIOCSIFADDR, dev_ifsioc),
+	IOCTL32_HANDLER(SIOCGIFBRDADDR, dev_ifsioc),
+	IOCTL32_HANDLER(SIOCSIFBRDADDR, dev_ifsioc),
+	IOCTL32_HANDLER(SIOCGIFDSTADDR, dev_ifsioc),
+	IOCTL32_HANDLER(SIOCSIFDSTADDR, dev_ifsioc),
+	IOCTL32_HANDLER(SIOCGIFNETMASK, dev_ifsioc),
+	IOCTL32_HANDLER(SIOCSIFNETMASK, dev_ifsioc),
+	IOCTL32_HANDLER(SIOCSIFPFLAGS, dev_ifsioc),
+	IOCTL32_HANDLER(SIOCGIFPFLAGS, dev_ifsioc),
+	IOCTL32_HANDLER(SIOCGIFTXQLEN, dev_ifsioc),
+	IOCTL32_HANDLER(SIOCSIFTXQLEN, dev_ifsioc),
+	IOCTL32_HANDLER(SIOCADDRT, routing_ioctl),
+	IOCTL32_HANDLER(SIOCDELRT, routing_ioctl),
+
+	IOCTL32_HANDLER(SIOCBONDENSLAVE, bond_ioctl),
+	IOCTL32_HANDLER(SIOCBONDRELEASE, bond_ioctl),
+	IOCTL32_HANDLER(SIOCBONDSETHWADDR, bond_ioctl),
+	IOCTL32_HANDLER(SIOCBONDSLAVEINFOQUERY, bond_ioctl),
+	IOCTL32_HANDLER(SIOCBONDINFOQUERY, bond_ioctl),
+	IOCTL32_HANDLER(SIOCBONDCHANGEACTIVE, bond_ioctl),
+
+	IOCTL32_HANDLER(EXT2_IOC32_GETFLAGS, do_ext2_ioctl),
+	IOCTL32_HANDLER(EXT2_IOC32_SETFLAGS, do_ext2_ioctl),
+	IOCTL32_HANDLER(EXT2_IOC32_GETVERSION, do_ext2_ioctl),
+	IOCTL32_HANDLER(EXT2_IOC32_SETVERSION, do_ext2_ioctl),
+
+	IOCTL32_HANDLER(LOOP_SET_STATUS, loop_status),
+	IOCTL32_HANDLER(LOOP_GET_STATUS, loop_status),
+
+	IOCTL32_HANDLER(ICARSAMODEXPO, do_rsa_ioctl),
+	IOCTL32_HANDLER(ICARSACRT, do_rsa_crt_ioctl),
+	IOCTL32_HANDLER(ICARSAMODMULT, do_rsa_ioctl),
+	IOCTL32_DEFAULT(ICAZ90STATUS),
+	IOCTL32_DEFAULT(ICAZ90QUIESCE),
+	IOCTL32_DEFAULT(ICAZ90HARDRESET),
+	IOCTL32_DEFAULT(ICAZ90HARDERROR),
+
+	IOCTL32_HANDLER(BLKRAGET, w_long),
+	IOCTL32_HANDLER(BLKGETSIZE, w_long),
+	IOCTL32_HANDLER(BLKFRAGET, w_long),
+	IOCTL32_HANDLER(BLKSECTGET, w_long),
+	IOCTL32_HANDLER(BLKPG, blkpg_ioctl_trans)
+
+};
+
+#define NR_IOCTL32_HANDLERS	(sizeof(ioctl32_handler_table) /	\
+				 sizeof(ioctl32_handler_table[0]))
+
+static struct ioctl32_list *ioctl32_hash_table[1024];
+
+static inline int ioctl32_hash(unsigned int cmd)
+{
+	return ((cmd >> 6) ^ (cmd >> 4) ^ cmd) & 0x3ff;
+}
+
+int sys32_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+{
+	int (*handler)(unsigned int, unsigned int, unsigned long, struct file * filp);
+	struct file *filp;
+	struct ioctl32_list *l;
+	int error;
+
+	l = ioctl32_hash_table[ioctl32_hash(cmd)];
+
+	error = -EBADF;
+
+	filp = fget(fd);
+	if (!filp)
+		return error;
+
+	if (!filp->f_op || !filp->f_op->ioctl) {
+		error = sys_ioctl (fd, cmd, arg);
+		goto out;
+	}
+
+	while (l && l->handler.cmd != cmd)
+		l = l->next;
+
+	if (l) {
+		handler = (void *)l->handler.function;
+		error = handler(fd, cmd, arg, filp);
+	} else {
+		error = -EINVAL;
+		printk("unknown ioctl: %08x\n", cmd);
+	}
+out:
+	fput(filp);
+	return error;
+}
+
+static void ioctl32_insert(struct ioctl32_list *entry)
+{
+	int hash = ioctl32_hash(entry->handler.cmd);
+
+	entry->next = 0;
+	if (!ioctl32_hash_table[hash])
+		ioctl32_hash_table[hash] = entry;
+	else {
+		struct ioctl32_list *l;
+		l = ioctl32_hash_table[hash];
+		while (l->next)
+			l = l->next;
+		l->next = entry;
+	}
+}
+
+int register_ioctl32_conversion(unsigned int cmd,
+				int (*handler)(unsigned int, unsigned int,
+					       unsigned long, struct file *))
+{
+	struct ioctl32_list *l, *new;
+	int hash;
+
+	hash = ioctl32_hash(cmd);
+	for (l = ioctl32_hash_table[hash]; l != NULL; l = l->next)
+		if (l->handler.cmd == cmd)
+			return -EBUSY;
+	new = kmalloc(sizeof(struct ioctl32_list), GFP_KERNEL);
+	if (new == NULL)
+		return -ENOMEM;
+	new->handler.cmd = cmd;
+	new->handler.function = (void *) handler;
+	ioctl32_insert(new);
+	return 0;
+}
+
+int unregister_ioctl32_conversion(unsigned int cmd)
+{
+	struct ioctl32_list *p, *l;
+	int hash;
+
+	hash = ioctl32_hash(cmd);
+	p = NULL;
+	for (l = ioctl32_hash_table[hash]; l != NULL; l = l->next) {
+		if (l->handler.cmd == cmd)
+			break;
+		p = l;
+	}
+	if (l == NULL)
+		return -ENOENT;
+	if (p == NULL)
+		ioctl32_hash_table[hash] = l->next;
+	else
+		p->next = l->next;
+	kfree(l);
+	return 0;
+}
+
+static int __init init_ioctl32(void)
+{
+	int i;
+	for (i = 0; i < NR_IOCTL32_HANDLERS; i++)
+		ioctl32_insert(&ioctl32_handler_table[i]);
+	return 0;
+}
+
+__initcall(init_ioctl32);

