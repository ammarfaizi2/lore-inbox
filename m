Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262727AbVEAWJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbVEAWJp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 18:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbVEAWJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 18:09:44 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:33811 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262703AbVEAVSr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 17:18:47 -0400
Message-Id: <200505012112.j41LCw3k016466@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       bstroesser@fujitsu-siemens.com
Subject: [PATCH 16/22] UML - S390 preparation, elf.h
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 01 May 2005 17:12:58 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

This patch make elh.h a symlink to the new arch-specific
include files of the form elf-<subarch>.h, as in the same
way already is done for some other includes.
Also moves Elf-stuff from archparam-<subarch>.h and
elf.h to the new elf-<subarch>.h files.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11-mm/arch/um/Makefile
===================================================================
--- linux-2.6.11-mm.orig/arch/um/Makefile	2005-04-30 13:07:58.000000000 -0400
+++ linux-2.6.11-mm/arch/um/Makefile	2005-05-01 11:23:36.000000000 -0400
@@ -17,7 +17,7 @@
 
 # Have to precede the include because the included Makefiles reference them.
 SYMLINK_HEADERS := archparam.h system.h sigcontext.h processor.h ptrace.h \
-	arch-signal.h module.h vm-flags.h
+	arch-signal.h module.h vm-flags.h elf.h
 SYMLINK_HEADERS := $(foreach header,$(SYMLINK_HEADERS),include/asm-um/$(header))
 
 # XXX: The "os" symlink is only used by arch/um/include/os.h, which includes
Index: linux-2.6.11-mm/include/asm-um/archparam-i386.h
===================================================================
--- linux-2.6.11-mm.orig/include/asm-um/archparam-i386.h	2005-04-30 12:56:24.000000000 -0400
+++ linux-2.6.11-mm/include/asm-um/archparam-i386.h	2005-04-30 13:10:53.000000000 -0400
@@ -6,143 +6,6 @@
 #ifndef __UM_ARCHPARAM_I386_H
 #define __UM_ARCHPARAM_I386_H
 
-/********* Bits for asm-um/elf.h ************/
-
-#include <asm/user.h>
-
-extern char * elf_aux_platform;
-#define ELF_PLATFORM (elf_aux_platform)
-
-#define ELF_ET_DYN_BASE (2 * TASK_SIZE / 3)
-
-typedef struct user_i387_struct elf_fpregset_t;
-typedef unsigned long elf_greg_t;
-
-#define ELF_NGREG (sizeof (struct user_regs_struct) / sizeof(elf_greg_t))
-typedef elf_greg_t elf_gregset_t[ELF_NGREG];
-
-#define ELF_DATA        ELFDATA2LSB
-#define ELF_ARCH        EM_386
-
-#define ELF_PLAT_INIT(regs, load_addr) do { \
-	PT_REGS_EBX(regs) = 0; \
-	PT_REGS_ECX(regs) = 0; \
-	PT_REGS_EDX(regs) = 0; \
-	PT_REGS_ESI(regs) = 0; \
-	PT_REGS_EDI(regs) = 0; \
-	PT_REGS_EBP(regs) = 0; \
-	PT_REGS_EAX(regs) = 0; \
-} while(0)
-
-/* Shamelessly stolen from include/asm-i386/elf.h */
-
-#define ELF_CORE_COPY_REGS(pr_reg, regs) do {	\
-	pr_reg[0] = PT_REGS_EBX(regs);		\
-	pr_reg[1] = PT_REGS_ECX(regs);		\
-	pr_reg[2] = PT_REGS_EDX(regs);		\
-	pr_reg[3] = PT_REGS_ESI(regs);		\
-	pr_reg[4] = PT_REGS_EDI(regs);		\
-	pr_reg[5] = PT_REGS_EBP(regs);		\
-	pr_reg[6] = PT_REGS_EAX(regs);		\
-	pr_reg[7] = PT_REGS_DS(regs);		\
-	pr_reg[8] = PT_REGS_ES(regs);		\
-	/* fake once used fs and gs selectors? */	\
-	pr_reg[9] = PT_REGS_DS(regs);		\
-	pr_reg[10] = PT_REGS_DS(regs);		\
-	pr_reg[11] = PT_REGS_SYSCALL_NR(regs);	\
-	pr_reg[12] = PT_REGS_IP(regs);		\
-	pr_reg[13] = PT_REGS_CS(regs);		\
-	pr_reg[14] = PT_REGS_EFLAGS(regs);	\
-	pr_reg[15] = PT_REGS_SP(regs);		\
-	pr_reg[16] = PT_REGS_SS(regs);		\
-} while(0);
-
-
-extern unsigned long vsyscall_ehdr;
-extern unsigned long vsyscall_end;
-extern unsigned long __kernel_vsyscall;
-
-#define VSYSCALL_BASE vsyscall_ehdr
-#define VSYSCALL_END vsyscall_end
-
-/*
- * This is the range that is readable by user mode, and things
- * acting like user mode such as get_user_pages.
- */
-#define FIXADDR_USER_START      VSYSCALL_BASE
-#define FIXADDR_USER_END        VSYSCALL_END
-
-/*
- * Architecture-neutral AT_ values in 0-17, leave some room
- * for more of them, start the x86-specific ones at 32.
- */
-#define AT_SYSINFO		32
-#define AT_SYSINFO_EHDR		33
-
-#define ARCH_DLINFO						\
-do {								\
-	if ( vsyscall_ehdr ) {					\
-		NEW_AUX_ENT(AT_SYSINFO,	__kernel_vsyscall);	\
-		NEW_AUX_ENT(AT_SYSINFO_EHDR, vsyscall_ehdr);	\
-	}							\
-} while (0)
-
-/*
- * These macros parameterize elf_core_dump in fs/binfmt_elf.c to write out
- * extra segments containing the vsyscall DSO contents.  Dumping its
- * contents makes post-mortem fully interpretable later without matching up
- * the same kernel and hardware config to see what PC values meant.
- * Dumping its extra ELF program headers includes all the other information
- * a debugger needs to easily find how the vsyscall DSO was being used.
- */
-#define ELF_CORE_EXTRA_PHDRS						      \
-	(vsyscall_ehdr ? (((struct elfhdr *)vsyscall_ehdr)->e_phnum) : 0 )
-
-#define ELF_CORE_WRITE_EXTRA_PHDRS					      \
-if ( vsyscall_ehdr ) {							      \
-	const struct elfhdr *const ehdrp = (struct elfhdr *)vsyscall_ehdr;    \
-	const struct elf_phdr *const phdrp =				      \
-		(const struct elf_phdr *) (vsyscall_ehdr + ehdrp->e_phoff);   \
-	int i;								      \
-	Elf32_Off ofs = 0;						      \
-	for (i = 0; i < ehdrp->e_phnum; ++i) {				      \
-		struct elf_phdr phdr = phdrp[i];			      \
-		if (phdr.p_type == PT_LOAD) {				      \
-			ofs = phdr.p_offset = offset;			      \
-			offset += phdr.p_filesz;			      \
-		}							      \
-		else							      \
-			phdr.p_offset += ofs;				      \
-		phdr.p_paddr = 0; /* match other core phdrs */		      \
-		DUMP_WRITE(&phdr, sizeof(phdr));			      \
-	}								      \
-}
-#define ELF_CORE_WRITE_EXTRA_DATA					      \
-if ( vsyscall_ehdr ) {							      \
-	const struct elfhdr *const ehdrp = (struct elfhdr *)vsyscall_ehdr;    \
-	const struct elf_phdr *const phdrp =				      \
-		(const struct elf_phdr *) (vsyscall_ehdr + ehdrp->e_phoff);   \
-	int i;								      \
-	for (i = 0; i < ehdrp->e_phnum; ++i) {				      \
-		if (phdrp[i].p_type == PT_LOAD)				      \
-			DUMP_WRITE((void *) phdrp[i].p_vaddr,		      \
-				   phdrp[i].p_filesz);			      \
-	}								      \
-}
-
-#define R_386_NONE	0
-#define R_386_32	1
-#define R_386_PC32	2
-#define R_386_GOT32	3
-#define R_386_PLT32	4
-#define R_386_COPY	5
-#define R_386_GLOB_DAT	6
-#define R_386_JMP_SLOT	7
-#define R_386_RELATIVE	8
-#define R_386_GOTOFF	9
-#define R_386_GOTPC	10
-#define R_386_NUM	11
-
 /********* Nothing for asm-um/hardirq.h **********/
 
 /********* Nothing for asm-um/hw_irq.h **********/
Index: linux-2.6.11-mm/include/asm-um/archparam-ppc.h
===================================================================
--- linux-2.6.11-mm.orig/include/asm-um/archparam-ppc.h	2005-04-30 12:56:24.000000000 -0400
+++ linux-2.6.11-mm/include/asm-um/archparam-ppc.h	2005-04-30 13:10:53.000000000 -0400
@@ -1,26 +1,6 @@
 #ifndef __UM_ARCHPARAM_PPC_H
 #define __UM_ARCHPARAM_PPC_H
 
-/********* Bits for asm-um/elf.h ************/
-
-#define ELF_PLATFORM (0)
-
-#define ELF_ET_DYN_BASE (0x08000000)
-
-/* the following stolen from asm-ppc/elf.h */
-#define ELF_NGREG	48	/* includes nip, msr, lr, etc. */
-#define ELF_NFPREG	33	/* includes fpscr */
-/* General registers */
-typedef unsigned long elf_greg_t;
-typedef elf_greg_t elf_gregset_t[ELF_NGREG];
-
-/* Floating point registers */
-typedef double elf_fpreg_t;
-typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
-
-#define ELF_DATA        ELFDATA2MSB
-#define ELF_ARCH	EM_PPC
-
 /********* Bits for asm-um/hw_irq.h **********/
 
 struct hw_interrupt_type;
Index: linux-2.6.11-mm/include/asm-um/archparam-x86_64.h
===================================================================
--- linux-2.6.11-mm.orig/include/asm-um/archparam-x86_64.h	2005-04-30 12:56:24.000000000 -0400
+++ linux-2.6.11-mm/include/asm-um/archparam-x86_64.h	2005-04-30 13:10:53.000000000 -0400
@@ -7,42 +7,6 @@
 #ifndef __UM_ARCHPARAM_X86_64_H
 #define __UM_ARCHPARAM_X86_64_H
 
-#include <asm/user.h>
-
-#define ELF_PLATFORM "x86_64"
-
-#define ELF_ET_DYN_BASE (2 * TASK_SIZE / 3)
-
-typedef unsigned long elf_greg_t;
-typedef struct { } elf_fpregset_t;
-
-#define ELF_NGREG (sizeof (struct user_regs_struct) / sizeof(elf_greg_t))
-typedef elf_greg_t elf_gregset_t[ELF_NGREG];
-
-#define ELF_DATA        ELFDATA2LSB
-#define ELF_ARCH        EM_X86_64
-
-#define ELF_PLAT_INIT(regs, load_addr)    do { \
-	PT_REGS_RBX(regs) = 0; \
-	PT_REGS_RCX(regs) = 0; \
-	PT_REGS_RDX(regs) = 0; \
-	PT_REGS_RSI(regs) = 0; \
-	PT_REGS_RDI(regs) = 0; \
-	PT_REGS_RBP(regs) = 0; \
-	PT_REGS_RAX(regs) = 0; \
-	PT_REGS_R8(regs) = 0; \
-	PT_REGS_R9(regs) = 0; \
-	PT_REGS_R10(regs) = 0; \
-	PT_REGS_R11(regs) = 0; \
-	PT_REGS_R12(regs) = 0; \
-	PT_REGS_R13(regs) = 0; \
-	PT_REGS_R14(regs) = 0; \
-	PT_REGS_R15(regs) = 0; \
-} while (0)
-
-#ifdef TIF_IA32 /* XXX */
-        clear_thread_flag(TIF_IA32);
-#endif
 
 /* No user-accessible fixmap addresses, i.e. vsyscall */
 #define FIXADDR_USER_START	0
Index: linux-2.6.11-mm/include/asm-um/elf-i386.h
===================================================================
--- linux-2.6.11-mm.orig/include/asm-um/elf-i386.h	2003-09-15 09:40:47.000000000 -0400
+++ linux-2.6.11-mm/include/asm-um/elf-i386.h	2005-04-30 13:10:53.000000000 -0400
@@ -0,0 +1,169 @@
+/*
+ * Copyright (C) 2000 - 2003 Jeff Dike (jdike@addtoit.com)
+ * Licensed under the GPL
+ */
+#ifndef __UM_ELF_I386_H
+#define __UM_ELF_I386_H
+
+#include "user.h"
+
+#define R_386_NONE	0
+#define R_386_32	1
+#define R_386_PC32	2
+#define R_386_GOT32	3
+#define R_386_PLT32	4
+#define R_386_COPY	5
+#define R_386_GLOB_DAT	6
+#define R_386_JMP_SLOT	7
+#define R_386_RELATIVE	8
+#define R_386_GOTOFF	9
+#define R_386_GOTPC	10
+#define R_386_NUM	11
+
+typedef unsigned long elf_greg_t;
+
+#define ELF_NGREG (sizeof (struct user_regs_struct) / sizeof(elf_greg_t))
+typedef elf_greg_t elf_gregset_t[ELF_NGREG];
+
+typedef struct user_i387_struct elf_fpregset_t;
+
+/*
+ * This is used to ensure we don't load something for the wrong architecture.
+ */
+#define elf_check_arch(x) \
+	(((x)->e_machine == EM_386) || ((x)->e_machine == EM_486))
+
+#define ELF_CLASS	ELFCLASS32
+#define ELF_DATA        ELFDATA2LSB
+#define ELF_ARCH        EM_386
+
+#define ELF_PLAT_INIT(regs, load_addr) do { \
+	PT_REGS_EBX(regs) = 0; \
+	PT_REGS_ECX(regs) = 0; \
+	PT_REGS_EDX(regs) = 0; \
+	PT_REGS_ESI(regs) = 0; \
+	PT_REGS_EDI(regs) = 0; \
+	PT_REGS_EBP(regs) = 0; \
+	PT_REGS_EAX(regs) = 0; \
+} while(0)
+
+#define USE_ELF_CORE_DUMP
+#define ELF_EXEC_PAGESIZE 4096
+
+#define ELF_ET_DYN_BASE (2 * TASK_SIZE / 3)
+
+/* Shamelessly stolen from include/asm-i386/elf.h */
+
+#define ELF_CORE_COPY_REGS(pr_reg, regs) do {	\
+	pr_reg[0] = PT_REGS_EBX(regs);		\
+	pr_reg[1] = PT_REGS_ECX(regs);		\
+	pr_reg[2] = PT_REGS_EDX(regs);		\
+	pr_reg[3] = PT_REGS_ESI(regs);		\
+	pr_reg[4] = PT_REGS_EDI(regs);		\
+	pr_reg[5] = PT_REGS_EBP(regs);		\
+	pr_reg[6] = PT_REGS_EAX(regs);		\
+	pr_reg[7] = PT_REGS_DS(regs);		\
+	pr_reg[8] = PT_REGS_ES(regs);		\
+	/* fake once used fs and gs selectors? */	\
+	pr_reg[9] = PT_REGS_DS(regs);		\
+	pr_reg[10] = PT_REGS_DS(regs);		\
+	pr_reg[11] = PT_REGS_SYSCALL_NR(regs);	\
+	pr_reg[12] = PT_REGS_IP(regs);		\
+	pr_reg[13] = PT_REGS_CS(regs);		\
+	pr_reg[14] = PT_REGS_EFLAGS(regs);	\
+	pr_reg[15] = PT_REGS_SP(regs);		\
+	pr_reg[16] = PT_REGS_SS(regs);		\
+} while(0);
+
+extern long elf_aux_hwcap;
+#define ELF_HWCAP (elf_aux_hwcap)
+
+extern char * elf_aux_platform;
+#define ELF_PLATFORM (elf_aux_platform)
+
+#define SET_PERSONALITY(ex, ibcs2) do ; while(0)
+
+extern unsigned long vsyscall_ehdr;
+extern unsigned long vsyscall_end;
+extern unsigned long __kernel_vsyscall;
+
+#define VSYSCALL_BASE vsyscall_ehdr
+#define VSYSCALL_END vsyscall_end
+
+/*
+ * This is the range that is readable by user mode, and things
+ * acting like user mode such as get_user_pages.
+ */
+#define FIXADDR_USER_START      VSYSCALL_BASE
+#define FIXADDR_USER_END        VSYSCALL_END
+
+/*
+ * Architecture-neutral AT_ values in 0-17, leave some room
+ * for more of them, start the x86-specific ones at 32.
+ */
+#define AT_SYSINFO		32
+#define AT_SYSINFO_EHDR		33
+
+#define ARCH_DLINFO						\
+do {								\
+	if ( vsyscall_ehdr ) {					\
+		NEW_AUX_ENT(AT_SYSINFO,	__kernel_vsyscall);	\
+		NEW_AUX_ENT(AT_SYSINFO_EHDR, vsyscall_ehdr);	\
+	}							\
+} while (0)
+
+/*
+ * These macros parameterize elf_core_dump in fs/binfmt_elf.c to write out
+ * extra segments containing the vsyscall DSO contents.  Dumping its
+ * contents makes post-mortem fully interpretable later without matching up
+ * the same kernel and hardware config to see what PC values meant.
+ * Dumping its extra ELF program headers includes all the other information
+ * a debugger needs to easily find how the vsyscall DSO was being used.
+ */
+#define ELF_CORE_EXTRA_PHDRS						      \
+	(vsyscall_ehdr ? (((struct elfhdr *)vsyscall_ehdr)->e_phnum) : 0 )
+
+#define ELF_CORE_WRITE_EXTRA_PHDRS					      \
+if ( vsyscall_ehdr ) {							      \
+	const struct elfhdr *const ehdrp = (struct elfhdr *)vsyscall_ehdr;    \
+	const struct elf_phdr *const phdrp =				      \
+		(const struct elf_phdr *) (vsyscall_ehdr + ehdrp->e_phoff);   \
+	int i;								      \
+	Elf32_Off ofs = 0;						      \
+	for (i = 0; i < ehdrp->e_phnum; ++i) {				      \
+		struct elf_phdr phdr = phdrp[i];			      \
+		if (phdr.p_type == PT_LOAD) {				      \
+			ofs = phdr.p_offset = offset;			      \
+			offset += phdr.p_filesz;			      \
+		}							      \
+		else							      \
+			phdr.p_offset += ofs;				      \
+		phdr.p_paddr = 0; /* match other core phdrs */		      \
+		DUMP_WRITE(&phdr, sizeof(phdr));			      \
+	}								      \
+}
+#define ELF_CORE_WRITE_EXTRA_DATA					      \
+if ( vsyscall_ehdr ) {							      \
+	const struct elfhdr *const ehdrp = (struct elfhdr *)vsyscall_ehdr;    \
+	const struct elf_phdr *const phdrp =				      \
+		(const struct elf_phdr *) (vsyscall_ehdr + ehdrp->e_phoff);   \
+	int i;								      \
+	for (i = 0; i < ehdrp->e_phnum; ++i) {				      \
+		if (phdrp[i].p_type == PT_LOAD)				      \
+			DUMP_WRITE((void *) phdrp[i].p_vaddr,		      \
+				   phdrp[i].p_filesz);			      \
+	}								      \
+}
+
+#endif
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
Index: linux-2.6.11-mm/include/asm-um/elf-ppc.h
===================================================================
--- linux-2.6.11-mm.orig/include/asm-um/elf-ppc.h	2003-09-15 09:40:47.000000000 -0400
+++ linux-2.6.11-mm/include/asm-um/elf-ppc.h	2005-04-30 13:10:53.000000000 -0400
@@ -0,0 +1,54 @@
+#ifndef __UM_ELF_PPC_H
+#define __UM_ELF_PPC_H
+
+#include "linux/config.h"
+
+extern long elf_aux_hwcap;
+#define ELF_HWCAP (elf_aux_hwcap)
+
+#define SET_PERSONALITY(ex, ibcs2) do ; while(0)
+
+#define ELF_EXEC_PAGESIZE 4096
+
+#define elf_check_arch(x) (1)
+
+#ifdef CONFIG_64_BIT
+#define ELF_CLASS ELFCLASS64
+#else
+#define ELF_CLASS ELFCLASS32
+#endif
+
+#define USE_ELF_CORE_DUMP
+
+#define R_386_NONE	0
+#define R_386_32	1
+#define R_386_PC32	2
+#define R_386_GOT32	3
+#define R_386_PLT32	4
+#define R_386_COPY	5
+#define R_386_GLOB_DAT	6
+#define R_386_JMP_SLOT	7
+#define R_386_RELATIVE	8
+#define R_386_GOTOFF	9
+#define R_386_GOTPC	10
+#define R_386_NUM	11
+
+#define ELF_PLATFORM (0)
+
+#define ELF_ET_DYN_BASE (0x08000000)
+
+/* the following stolen from asm-ppc/elf.h */
+#define ELF_NGREG	48	/* includes nip, msr, lr, etc. */
+#define ELF_NFPREG	33	/* includes fpscr */
+/* General registers */
+typedef unsigned long elf_greg_t;
+typedef elf_greg_t elf_gregset_t[ELF_NGREG];
+
+/* Floating point registers */
+typedef double elf_fpreg_t;
+typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
+
+#define ELF_DATA        ELFDATA2MSB
+#define ELF_ARCH	EM_PPC
+
+#endif
Index: linux-2.6.11-mm/include/asm-um/elf-x86_64.h
===================================================================
--- linux-2.6.11-mm.orig/include/asm-um/elf-x86_64.h	2003-09-15 09:40:47.000000000 -0400
+++ linux-2.6.11-mm/include/asm-um/elf-x86_64.h	2005-04-30 13:10:53.000000000 -0400
@@ -0,0 +1,73 @@
+/*
+ * Copyright 2003 PathScale, Inc.
+ *
+ * Licensed under the GPL
+ */
+#ifndef __UM_ELF_X86_64_H
+#define __UM_ELF_X86_64_H
+
+#include <asm/user.h>
+
+typedef unsigned long elf_greg_t;
+
+#define ELF_NGREG (sizeof (struct user_regs_struct) / sizeof(elf_greg_t))
+typedef elf_greg_t elf_gregset_t[ELF_NGREG];
+
+typedef struct { } elf_fpregset_t;
+
+/*
+ * This is used to ensure we don't load something for the wrong architecture.
+ */
+#define elf_check_arch(x) \
+	((x)->e_machine == EM_X86_64)
+
+#define ELF_CLASS	ELFCLASS64
+#define ELF_DATA        ELFDATA2LSB
+#define ELF_ARCH        EM_X86_64
+
+#define ELF_PLAT_INIT(regs, load_addr)    do { \
+	PT_REGS_RBX(regs) = 0; \
+	PT_REGS_RCX(regs) = 0; \
+	PT_REGS_RDX(regs) = 0; \
+	PT_REGS_RSI(regs) = 0; \
+	PT_REGS_RDI(regs) = 0; \
+	PT_REGS_RBP(regs) = 0; \
+	PT_REGS_RAX(regs) = 0; \
+	PT_REGS_R8(regs) = 0; \
+	PT_REGS_R9(regs) = 0; \
+	PT_REGS_R10(regs) = 0; \
+	PT_REGS_R11(regs) = 0; \
+	PT_REGS_R12(regs) = 0; \
+	PT_REGS_R13(regs) = 0; \
+	PT_REGS_R14(regs) = 0; \
+	PT_REGS_R15(regs) = 0; \
+} while (0)
+
+#ifdef TIF_IA32 /* XXX */
+        clear_thread_flag(TIF_IA32); \
+#endif
+
+#define USE_ELF_CORE_DUMP
+#define ELF_EXEC_PAGESIZE 4096
+
+#define ELF_ET_DYN_BASE (2 * TASK_SIZE / 3)
+
+extern long elf_aux_hwcap;
+#define ELF_HWCAP (elf_aux_hwcap)
+
+#define ELF_PLATFORM "x86_64"
+
+#define SET_PERSONALITY(ex, ibcs2) do ; while(0)
+
+#endif
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
Index: linux-2.6.11-mm/include/asm-um/elf.h
===================================================================
--- linux-2.6.11-mm.orig/include/asm-um/elf.h	2005-04-30 12:57:45.000000000 -0400
+++ linux-2.6.11-mm/include/asm-um/elf.h	2005-04-30 13:10:53.000000000 -0400
@@ -1,25 +1,11 @@
-#ifndef __UM_ELF_H
-#define __UM_ELF_H
+/*
+ * Copyright (C) 2000 - 2003 Jeff Dike (jdike@addtoit.com)
+ * Licensed under the GPL
+ */
+#ifndef __UM_ELF_I386_H
+#define __UM_ELF_I386_H
 
-#include "linux/config.h"
-#include "asm/archparam.h"
-
-extern long elf_aux_hwcap;
-#define ELF_HWCAP (elf_aux_hwcap)
-
-#define SET_PERSONALITY(ex, ibcs2) do ; while(0)
-
-#define ELF_EXEC_PAGESIZE 4096
-
-#define elf_check_arch(x) (1)
-
-#ifdef CONFIG_64BIT
-#define ELF_CLASS ELFCLASS64
-#else
-#define ELF_CLASS ELFCLASS32
-#endif
-
-#define USE_ELF_CORE_DUMP
+#include "user.h"
 
 #define R_386_NONE	0
 #define R_386_32	1
@@ -34,4 +20,150 @@
 #define R_386_GOTPC	10
 #define R_386_NUM	11
 
+typedef unsigned long elf_greg_t;
+
+#define ELF_NGREG (sizeof (struct user_regs_struct) / sizeof(elf_greg_t))
+typedef elf_greg_t elf_gregset_t[ELF_NGREG];
+
+typedef struct user_i387_struct elf_fpregset_t;
+
+/*
+ * This is used to ensure we don't load something for the wrong architecture.
+ */
+#define elf_check_arch(x) \
+	(((x)->e_machine == EM_386) || ((x)->e_machine == EM_486))
+
+#define ELF_CLASS	ELFCLASS32
+#define ELF_DATA        ELFDATA2LSB
+#define ELF_ARCH        EM_386
+
+#define ELF_PLAT_INIT(regs, load_addr) do { \
+	PT_REGS_EBX(regs) = 0; \
+	PT_REGS_ECX(regs) = 0; \
+	PT_REGS_EDX(regs) = 0; \
+	PT_REGS_ESI(regs) = 0; \
+	PT_REGS_EDI(regs) = 0; \
+	PT_REGS_EBP(regs) = 0; \
+	PT_REGS_EAX(regs) = 0; \
+} while(0)
+
+#define USE_ELF_CORE_DUMP
+#define ELF_EXEC_PAGESIZE 4096
+
+#define ELF_ET_DYN_BASE (2 * TASK_SIZE / 3)
+
+/* Shamelessly stolen from include/asm-i386/elf.h */
+
+#define ELF_CORE_COPY_REGS(pr_reg, regs) do {	\
+	pr_reg[0] = PT_REGS_EBX(regs);		\
+	pr_reg[1] = PT_REGS_ECX(regs);		\
+	pr_reg[2] = PT_REGS_EDX(regs);		\
+	pr_reg[3] = PT_REGS_ESI(regs);		\
+	pr_reg[4] = PT_REGS_EDI(regs);		\
+	pr_reg[5] = PT_REGS_EBP(regs);		\
+	pr_reg[6] = PT_REGS_EAX(regs);		\
+	pr_reg[7] = PT_REGS_DS(regs);		\
+	pr_reg[8] = PT_REGS_ES(regs);		\
+	/* fake once used fs and gs selectors? */	\
+	pr_reg[9] = PT_REGS_DS(regs);		\
+	pr_reg[10] = PT_REGS_DS(regs);		\
+	pr_reg[11] = PT_REGS_SYSCALL_NR(regs);	\
+	pr_reg[12] = PT_REGS_IP(regs);		\
+	pr_reg[13] = PT_REGS_CS(regs);		\
+	pr_reg[14] = PT_REGS_EFLAGS(regs);	\
+	pr_reg[15] = PT_REGS_SP(regs);		\
+	pr_reg[16] = PT_REGS_SS(regs);		\
+} while(0);
+
+extern long elf_aux_hwcap;
+#define ELF_HWCAP (elf_aux_hwcap)
+
+extern char * elf_aux_platform;
+#define ELF_PLATFORM (elf_aux_platform)
+
+#define SET_PERSONALITY(ex, ibcs2) do ; while(0)
+
+extern unsigned long vsyscall_ehdr;
+extern unsigned long vsyscall_end;
+extern unsigned long __kernel_vsyscall;
+
+#define VSYSCALL_BASE vsyscall_ehdr
+#define VSYSCALL_END vsyscall_end
+
+/*
+ * This is the range that is readable by user mode, and things
+ * acting like user mode such as get_user_pages.
+ */
+#define FIXADDR_USER_START      VSYSCALL_BASE
+#define FIXADDR_USER_END        VSYSCALL_END
+
+/*
+ * Architecture-neutral AT_ values in 0-17, leave some room
+ * for more of them, start the x86-specific ones at 32.
+ */
+#define AT_SYSINFO		32
+#define AT_SYSINFO_EHDR		33
+
+#define ARCH_DLINFO						\
+do {								\
+	if ( vsyscall_ehdr ) {					\
+		NEW_AUX_ENT(AT_SYSINFO,	__kernel_vsyscall);	\
+		NEW_AUX_ENT(AT_SYSINFO_EHDR, vsyscall_ehdr);	\
+	}							\
+} while (0)
+
+/*
+ * These macros parameterize elf_core_dump in fs/binfmt_elf.c to write out
+ * extra segments containing the vsyscall DSO contents.  Dumping its
+ * contents makes post-mortem fully interpretable later without matching up
+ * the same kernel and hardware config to see what PC values meant.
+ * Dumping its extra ELF program headers includes all the other information
+ * a debugger needs to easily find how the vsyscall DSO was being used.
+ */
+#define ELF_CORE_EXTRA_PHDRS						      \
+	(vsyscall_ehdr ? (((struct elfhdr *)vsyscall_ehdr)->e_phnum) : 0 )
+
+#define ELF_CORE_WRITE_EXTRA_PHDRS					      \
+if ( vsyscall_ehdr ) {							      \
+	const struct elfhdr *const ehdrp = (struct elfhdr *)vsyscall_ehdr;    \
+	const struct elf_phdr *const phdrp =				      \
+		(const struct elf_phdr *) (vsyscall_ehdr + ehdrp->e_phoff);   \
+	int i;								      \
+	Elf32_Off ofs = 0;						      \
+	for (i = 0; i < ehdrp->e_phnum; ++i) {				      \
+		struct elf_phdr phdr = phdrp[i];			      \
+		if (phdr.p_type == PT_LOAD) {				      \
+			ofs = phdr.p_offset = offset;			      \
+			offset += phdr.p_filesz;			      \
+		}							      \
+		else							      \
+			phdr.p_offset += ofs;				      \
+		phdr.p_paddr = 0; /* match other core phdrs */		      \
+		DUMP_WRITE(&phdr, sizeof(phdr));			      \
+	}								      \
+}
+#define ELF_CORE_WRITE_EXTRA_DATA					      \
+if ( vsyscall_ehdr ) {							      \
+	const struct elfhdr *const ehdrp = (struct elfhdr *)vsyscall_ehdr;    \
+	const struct elf_phdr *const phdrp =				      \
+		(const struct elf_phdr *) (vsyscall_ehdr + ehdrp->e_phoff);   \
+	int i;								      \
+	for (i = 0; i < ehdrp->e_phnum; ++i) {				      \
+		if (phdrp[i].p_type == PT_LOAD)				      \
+			DUMP_WRITE((void *) phdrp[i].p_vaddr,		      \
+				   phdrp[i].p_filesz);			      \
+	}								      \
+}
+
 #endif
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
Index: linux-2.6.11-mm/include/asm-um/fixmap.h
===================================================================
--- linux-2.6.11-mm.orig/include/asm-um/fixmap.h	2005-04-30 12:56:24.000000000 -0400
+++ linux-2.6.11-mm/include/asm-um/fixmap.h	2005-04-30 13:10:53.000000000 -0400
@@ -4,6 +4,7 @@
 #include <linux/config.h>
 #include <asm/kmap_types.h>
 #include <asm/archparam.h>
+#include <asm/elf.h>
 
 /*
  * Here we define all the compile-time 'special' virtual

