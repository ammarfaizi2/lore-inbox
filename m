Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262464AbULCT1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbULCT1q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 14:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbULCT1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 14:27:46 -0500
Received: from pool-151-203-6-248.bos.east.verizon.net ([151.203.6.248]:6148
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262464AbULCT0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 14:26:44 -0500
Message-Id: <200412032142.iB3LgTZW004646@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, Blaisorblade <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: [PATCH] UML - add elf vsyscall support
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 Dec 2004 16:42:29 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Bodo Stroesser:

This is the first patch of a series of four.
These patches allow the use of sysenter-systemcalls in UML
if the host support sysenter.
Some facts have to be noted:
- the sysenter instruction does not save anything, not even the
  return address. Thus the host-kernel builds a stackframe with an
  fixed return address for the backjump to the vsyscall-page. All
  kernels that support sysenter thus must have a vsyscall-page
- The hosts vsyscall-page is visible in all memory-contexts on the
  host, even in those of the processes running on UML. This cannot
  be changed.
So the best way to implement sysenter is to integrate the host's
vsyscall-page into UML, if available.

This patch creates a new source file containing an UML
initialization function. The function scans the Elf-auxiliary vector
that is prepared by the host for relevant information about:
- vsyscall elf-header
- vsyscall entry
- machine type (called "platform", e.g. "i586" or "i686")
- hardware capabilities
These informations are inserted into the Elf-auxiliary-vector that is
generated if an UML process calls "execXX()". If the information from
the auxiliray-vector is not complete, UML uses the previos default
values, with one exception: if the host has no vsyscall-page, UML now
does no longer insert AT_SYSINFO or AT_SYSINFO_EHDR elements. (I think,
that's better than writing dummies)

Since the host's vsyscall-page is always visible to UML processes, this
change is enough to let UML with an i686-compiled glibc use sysenter.

what's missing:
- is_syscall() in SKAS cannot access the code in the vsyscall-page via
  copy_from_user(), thus singlesteppers still could break out. (Note:
  that's not new, if someone jumps willingly to the sysenter-entry in
  the vsyscall-page, he can do that without the patch, too).
- a debugger cannot access the code in the vsyscall-page via
  ptrace( PEEKTEXT, ...)

Risks:
could there by any feature of the host's processor, that is indicated in
the hardware capabilities, but must not be used in UML?

Signed-off-by: Bodo Stroesser <bodo.stroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/kernel/main.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/main.c	2004-12-01 23:43:04.000000000 -0500
+++ 2.6.9/arch/um/kernel/main.c	2004-12-01 23:44:11.000000000 -0500
@@ -81,6 +81,8 @@
 
 extern int uml_exitcode;
 
+extern void scan_elf_aux( char **envp);
+
 int main(int argc, char **argv, char **envp)
 {
 	char **new_argv;
@@ -147,6 +149,8 @@
 	set_handler(SIGTERM, last_ditch_exit, SA_ONESHOT | SA_NODEFER, -1);
 	set_handler(SIGHUP, last_ditch_exit, SA_ONESHOT | SA_NODEFER, -1);
 
+	scan_elf_aux( envp);
+
 	do_uml_initcalls();
 	ret = linux_main(argc, argv);
 
Index: 2.6.9/arch/um/kernel/um_arch.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/um_arch.c	2004-12-01 23:43:04.000000000 -0500
+++ 2.6.9/arch/um/kernel/um_arch.c	2004-12-01 23:44:11.000000000 -0500
@@ -44,11 +44,6 @@
 	.ipi_pipe		= { -1, -1 }
 };
 
-/* Placeholder to make UML link until the vsyscall stuff is actually
- * implemented
- */
-void *__kernel_vsyscall;
-
 unsigned long thread_saved_pc(struct task_struct *task)
 {
 	return(os_process_pc(CHOOSE_MODE_PROC(thread_pid_tt, thread_pid_skas,
Index: 2.6.9/arch/um/os-Linux/Makefile
===================================================================
--- 2.6.9.orig/arch/um/os-Linux/Makefile	2004-12-01 23:43:12.000000000 -0500
+++ 2.6.9/arch/um/os-Linux/Makefile	2004-12-01 23:45:55.000000000 -0500
@@ -3,9 +3,10 @@
 # Licensed under the GPL
 #
 
-obj-y = file.o process.o time.o tty.o user_syms.o drivers/
+obj-y = elf_aux.o file.o process.o time.o tty.o user_syms.o drivers/
 
-USER_OBJS := $(foreach file,file.o process.o time.o tty.o,$(obj)/$(file))
+USER_OBJS := elf_aux.o file.o process.o time.o tty.o
+USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 
 $(USER_OBJS) : %.o: %.c
 	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
Index: 2.6.9/arch/um/os-Linux/elf_aux.c
===================================================================
--- 2.6.9.orig/arch/um/os-Linux/elf_aux.c	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.9/arch/um/os-Linux/elf_aux.c	2004-12-01 23:44:11.000000000 -0500
@@ -0,0 +1,66 @@
+/*
+ *  arch/um/kernel/elf_aux.c
+ *
+ *  Scan the Elf auxiliary vector provided by the host to extract
+ *  information about vsyscall-page, etc.
+ *
+ *  Copyright (C) 2004 Fujitsu Siemens Computers GmbH
+ *  Author: Bodo Stroesser (bodo.stroesser@fujitsu-siemens.com)
+ */
+#include <elf.h>
+#include <stddef.h>
+#include "init.h"
+
+#if ELF_CLASS == ELFCLASS32
+typedef Elf32_auxv_t elf_auxv_t;
+#else
+typedef Elf64_auxv_t elf_auxv_t;
+#endif
+
+char * elf_aux_platform;
+long elf_aux_hwcap;
+
+long vsyscall_ehdr;
+long vsyscall_end;
+
+long __kernel_vsyscall;
+
+
+__init void scan_elf_aux( char **envp)
+{
+	long page_size = 0;
+	elf_auxv_t * auxv;
+
+	while ( *envp++ != NULL) ;
+
+	for ( auxv = (elf_auxv_t *)envp; auxv->a_type != AT_NULL; auxv++) {
+		switch ( auxv->a_type ) {
+			case AT_SYSINFO:
+				__kernel_vsyscall = auxv->a_un.a_val;
+				break;
+			case AT_SYSINFO_EHDR:
+				vsyscall_ehdr = auxv->a_un.a_val;
+				break;
+			case AT_HWCAP:
+				elf_aux_hwcap = auxv->a_un.a_val;
+				break;
+			case AT_PLATFORM:
+				elf_aux_platform = auxv->a_un.a_ptr;
+				break;
+			case AT_PAGESZ:
+				page_size = auxv->a_un.a_val;
+				break;
+		}
+	}
+	if ( ! __kernel_vsyscall || ! vsyscall_ehdr ||
+	     ! elf_aux_hwcap || ! elf_aux_platform ||
+	     ! page_size || (vsyscall_ehdr % page_size) ) {
+		__kernel_vsyscall = 0;
+		vsyscall_ehdr = 0;
+		elf_aux_hwcap = 0;
+		elf_aux_platform = "i586";
+	}
+	else {
+		vsyscall_end = vsyscall_ehdr + page_size;
+	}
+}
Index: 2.6.9/include/asm-um/archparam-i386.h
===================================================================
--- 2.6.9.orig/include/asm-um/archparam-i386.h	2004-12-01 23:43:04.000000000 -0500
+++ 2.6.9/include/asm-um/archparam-i386.h	2004-12-01 23:44:11.000000000 -0500
@@ -10,7 +10,8 @@
 
 #include "user.h"
 
-#define ELF_PLATFORM "i586"
+extern char * elf_aux_platform;
+#define ELF_PLATFORM (elf_aux_platform)
 
 #define ELF_ET_DYN_BASE (2 * TASK_SIZE / 3)
 
@@ -56,15 +57,13 @@
 	pr_reg[16] = PT_REGS_SS(regs);		\
 } while(0);
 
-#if 0 /* Turn this back on when UML has VSYSCALL working */
-#define VSYSCALL_BASE	(__fix_to_virt(FIX_VSYSCALL))
-#else
-#define VSYSCALL_BASE	0
-#endif
 
-#define VSYSCALL_EHDR	((const struct elfhdr *) VSYSCALL_BASE)
-#define VSYSCALL_ENTRY	((unsigned long) &__kernel_vsyscall)
-extern void *__kernel_vsyscall;
+extern long vsyscall_ehdr;
+extern long vsyscall_end;
+extern long __kernel_vsyscall;
+
+#define VSYSCALL_BASE vsyscall_ehdr
+#define VSYSCALL_END vsyscall_end
 
 /*
  * Architecture-neutral AT_ values in 0-17, leave some room
@@ -75,8 +74,10 @@
 
 #define ARCH_DLINFO						\
 do {								\
-		NEW_AUX_ENT(AT_SYSINFO,	VSYSCALL_ENTRY);	\
-		NEW_AUX_ENT(AT_SYSINFO_EHDR, VSYSCALL_BASE);	\
+	if ( vsyscall_ehdr ) {					\
+		NEW_AUX_ENT(AT_SYSINFO,	__kernel_vsyscall);	\
+		NEW_AUX_ENT(AT_SYSINFO_EHDR, vsyscall_ehdr);	\
+	}							\
 } while (0)
 
 /*
Index: 2.6.9/include/asm-um/elf.h
===================================================================
--- 2.6.9.orig/include/asm-um/elf.h	2004-12-01 23:43:04.000000000 -0500
+++ 2.6.9/include/asm-um/elf.h	2004-12-01 23:44:11.000000000 -0500
@@ -3,7 +3,8 @@
 
 #include "asm/archparam.h"
 
-#define ELF_HWCAP (0)
+extern long elf_aux_hwcap;
+#define ELF_HWCAP (elf_aux_hwcap)
 
 #define SET_PERSONALITY(ex, ibcs2) do ; while(0)
 

