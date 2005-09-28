Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbVI1V1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbVI1V1g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbVI1V1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:27:36 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:64967 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750931AbVI1V1f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:27:35 -0400
Date: Wed, 28 Sep 2005 22:27:23 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org
Subject: [PATCH] uml makefiles sanitized
Message-ID: <20050928212723.GZ7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	UML makefiles sanitized:
* number of generated headers reduced to 2 (from user-offsets.c and
  kernel-offsets.c resp.).  The rest is made constant and simply
  includes those two.
* mk_... helpers are gone now that we don't need to generate these
  headers
* arch/um/include2 removed since everything under arch/um/include/sysdep
  is constant now and symlink can point straight to source tree.
* dependencies seriously simplified.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git5-net-noise/arch/um/Makefile RC14-rc2-git5-uml-makefiles/arch/um/Makefile
--- RC14-rc2-git5-net-noise/arch/um/Makefile	2005-09-25 23:45:54.000000000 -0400
+++ RC14-rc2-git5-uml-makefiles/arch/um/Makefile	2005-09-25 23:46:47.000000000 -0400
@@ -28,8 +28,6 @@
 ARCH_SYMLINKS = include/asm-um/arch $(ARCH_DIR)/include/sysdep $(ARCH_DIR)/os \
 	$(SYMLINK_HEADERS) $(ARCH_DIR)/include/uml-config.h
 
-GEN_HEADERS += $(ARCH_DIR)/include/task.h $(ARCH_DIR)/include/kern_constants.h
-
 um-modes-$(CONFIG_MODE_TT) += tt
 um-modes-$(CONFIG_MODE_SKAS) += skas
 
@@ -45,9 +43,7 @@
 
 ARCH_INCLUDE	:= -I$(ARCH_DIR)/include
 ifneq ($(KBUILD_SRC),)
-ARCH_INCLUDE	+= -I$(ARCH_DIR)/include2
 ARCH_INCLUDE	+= -I$(srctree)/$(ARCH_DIR)/include
-MRPROPER_DIRS	+= $(ARCH_DIR)/include2
 endif
 SYS_DIR		:= $(ARCH_DIR)/include/sysdep-$(SUBARCH)
 
@@ -87,10 +83,6 @@
 
 SIZE = (($(CONFIG_NEST_LEVEL) + $(CONFIG_KERNEL_HALF_GIGS)) * 0x20000000)
 
-ifeq ($(CONFIG_MODE_SKAS), y)
-$(SYS_HEADERS) : $(ARCH_DIR)/include/skas_ptregs.h
-endif
-
 .PHONY: linux
 
 all: linux
@@ -111,7 +103,8 @@
 $(shell cd $(ARCH_DIR) && ln -sf Kconfig.$(SUBARCH) Kconfig.arch)
 endif
 
-archprepare: $(ARCH_SYMLINKS) $(SYS_HEADERS) $(GEN_HEADERS)
+archprepare: $(ARCH_SYMLINKS) $(ARCH_DIR)/include/user_constants.h
+prepare: $(ARCH_DIR)/include/kern_constants.h
 
 LINK-$(CONFIG_LD_SCRIPT_STATIC) += -static
 LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib
@@ -146,15 +139,13 @@
 #When cleaning we don't include .config, so we don't include
 #TT or skas makefiles and don't clean skas_ptregs.h.
 CLEAN_FILES += linux x.i gmon.out $(ARCH_DIR)/include/uml-config.h \
-	$(GEN_HEADERS) $(ARCH_DIR)/include/skas_ptregs.h \
-	$(ARCH_DIR)/include/user_constants.h $(ARCH_DIR)/Kconfig.arch
+	$(ARCH_DIR)/include/user_constants.h \
+	$(ARCH_DIR)/include/kern_constants.h $(ARCH_DIR)/Kconfig.arch
 
 MRPROPER_FILES += $(SYMLINK_HEADERS) $(ARCH_SYMLINKS) \
 	$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS)) $(ARCH_DIR)/os
 
 archclean:
-	$(Q)$(MAKE) $(clean)=$(ARCH_DIR)/util
-	$(Q)$(MAKE) $(clean)=$(ARCH_DIR)/os-$(OS)/util
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
 
@@ -180,9 +171,7 @@
 	@echo '  SYMLINK $@'
 ifneq ($(KBUILD_SRC),)
 	$(Q)mkdir -p $(ARCH_DIR)/include
-	$(Q)mkdir -p $(ARCH_DIR)/include2
-	$(Q)ln -fsn sysdep-$(SUBARCH) $(ARCH_DIR)/include/sysdep
-	$(Q)ln -fsn $(srctree)/$(ARCH_DIR)/include/sysdep-$(SUBARCH) $(ARCH_DIR)/include2/sysdep
+	$(Q)ln -fsn $(srctree)/$(ARCH_DIR)/include/sysdep-$(SUBARCH) $(ARCH_DIR)/include/sysdep
 else
 	$(Q)cd $(ARCH_DIR)/include && ln -sf sysdep-$(SUBARCH) sysdep
 endif
@@ -202,8 +191,6 @@
 
 define filechk_gen-asm-offsets
         (set -e; \
-         echo "#ifndef __ASM_OFFSETS_H__"; \
-         echo "#define __ASM_OFFSETS_H__"; \
          echo "/*"; \
          echo " * DO NOT MODIFY."; \
          echo " *"; \
@@ -212,8 +199,7 @@
          echo " */"; \
          echo ""; \
          sed -ne "/^->/{s:^->\([^ ]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; s:->::; p;}"; \
-         echo ""; \
-         echo "#endif" )
+         echo ""; )
 endef
 
 $(ARCH_DIR)/include/uml-config.h : include/linux/autoconf.h
@@ -222,50 +208,18 @@
 $(ARCH_DIR)/user-offsets.s: $(ARCH_DIR)/sys-$(SUBARCH)/user-offsets.c
 	$(CC) $(USER_CFLAGS) -S -o $@ $<
 
-$(ARCH_DIR)/user-offsets.h: $(ARCH_DIR)/user-offsets.s
+$(ARCH_DIR)/include/user_constants.h: $(ARCH_DIR)/user-offsets.s
 	$(call filechk,gen-asm-offsets)
 
-CLEAN_FILES += $(ARCH_DIR)/user-offsets.s  $(ARCH_DIR)/user-offsets.h
+CLEAN_FILES += $(ARCH_DIR)/user-offsets.s
 
 $(ARCH_DIR)/kernel-offsets.s: $(ARCH_DIR)/sys-$(SUBARCH)/kernel-offsets.c \
-				   $(ARCH_SYMLINKS) \
-				   $(SYS_DIR)/sc.h \
-				   include/asm include/linux/version.h \
-				   include/config/MARKER \
-				   $(ARCH_DIR)/include/user_constants.h
+				   archprepare
 	$(CC) $(CFLAGS) $(NOSTDINC_FLAGS) $(CPPFLAGS) -S -o $@ $<
 
-$(ARCH_DIR)/kernel-offsets.h: $(ARCH_DIR)/kernel-offsets.s
+$(ARCH_DIR)/include/kern_constants.h: $(ARCH_DIR)/kernel-offsets.s
 	$(call filechk,gen-asm-offsets)
 
-CLEAN_FILES += $(ARCH_DIR)/kernel-offsets.s  $(ARCH_DIR)/kernel-offsets.h
-
-$(ARCH_DIR)/include/task.h: $(ARCH_DIR)/util/mk_task
-	$(call filechk,gen_header)
-
-$(ARCH_DIR)/include/user_constants.h: $(ARCH_DIR)/os-$(OS)/util/mk_user_constants
-	$(call filechk,gen_header)
-
-$(ARCH_DIR)/include/kern_constants.h: $(ARCH_DIR)/util/mk_constants
-	$(call filechk,gen_header)
-
-$(ARCH_DIR)/include/skas_ptregs.h: $(ARCH_DIR)/kernel/skas/util/mk_ptregs
-	$(call filechk,gen_header)
-
-$(ARCH_DIR)/os-$(OS)/util/mk_user_constants: $(ARCH_DIR)/os-$(OS)/util FORCE ;
-
-$(ARCH_DIR)/util/mk_task $(ARCH_DIR)/util/mk_constants: $(ARCH_DIR)/include/user_constants.h $(ARCH_DIR)/util \
-	FORCE ;
-
-$(ARCH_DIR)/kernel/skas/util/mk_ptregs: $(ARCH_DIR)/kernel/skas/util FORCE ;
-
-$(ARCH_DIR)/util: scripts_basic $(SYS_DIR)/sc.h $(ARCH_DIR)/kernel-offsets.h FORCE
-	$(Q)$(MAKE) $(build)=$@
-
-$(ARCH_DIR)/kernel/skas/util: scripts_basic $(ARCH_DIR)/user-offsets.h FORCE
-	$(Q)$(MAKE) $(build)=$@
-
-$(ARCH_DIR)/os-$(OS)/util: scripts_basic $(ARCH_DIR)/user-offsets.h FORCE
-	$(Q)$(MAKE) $(build)=$@
+CLEAN_FILES += $(ARCH_DIR)/kernel-offsets.s
 
 export SUBARCH USER_CFLAGS OS
diff -urN RC14-rc2-git5-net-noise/arch/um/Makefile-i386 RC14-rc2-git5-uml-makefiles/arch/um/Makefile-i386
--- RC14-rc2-git5-net-noise/arch/um/Makefile-i386	2005-09-08 10:07:30.000000000 -0400
+++ RC14-rc2-git5-uml-makefiles/arch/um/Makefile-i386	2005-09-25 23:46:47.000000000 -0400
@@ -32,25 +32,3 @@
 ifneq ($(CONFIG_GPROF),y)
 ARCH_CFLAGS += -DUM_FASTCALL
 endif
-
-SYS_UTIL_DIR	:= $(ARCH_DIR)/sys-i386/util
-SYS_HEADERS	:= $(SYS_DIR)/sc.h $(SYS_DIR)/thread.h
-
-prepare: $(SYS_HEADERS)
-
-$(SYS_DIR)/sc.h: $(SYS_UTIL_DIR)/mk_sc
-	$(call filechk,gen_header)
-
-$(SYS_DIR)/thread.h: $(SYS_UTIL_DIR)/mk_thread 
-	$(call filechk,gen_header)
-
-$(SYS_UTIL_DIR)/mk_sc: scripts_basic $(ARCH_DIR)/user-offsets.h FORCE
-	$(Q)$(MAKE) $(build)=$(SYS_UTIL_DIR) $@
-
-$(SYS_UTIL_DIR)/mk_thread: scripts_basic $(ARCH_DIR)/kernel-offsets.h FORCE
-	$(Q)$(MAKE) $(build)=$(SYS_UTIL_DIR) $@
-
-$(SYS_UTIL_DIR): scripts_basic include/asm FORCE
-	$(Q)$(MAKE) $(build)=$(SYS_UTIL_DIR)
-
-CLEAN_FILES += $(SYS_HEADERS)
diff -urN RC14-rc2-git5-net-noise/arch/um/Makefile-skas RC14-rc2-git5-uml-makefiles/arch/um/Makefile-skas
--- RC14-rc2-git5-net-noise/arch/um/Makefile-skas	2005-06-17 15:48:29.000000000 -0400
+++ RC14-rc2-git5-uml-makefiles/arch/um/Makefile-skas	2005-09-25 23:46:47.000000000 -0400
@@ -10,5 +10,3 @@
 CFLAGS-$(CONFIG_GPROF) += $(GPROF_OPT)
 LINK-$(CONFIG_GCOV) += $(GCOV_OPT)
 LINK-$(CONFIG_GPROF) += $(GPROF_OPT)
-
-GEN_HEADERS += $(ARCH_DIR)/include/skas_ptregs.h
diff -urN RC14-rc2-git5-net-noise/arch/um/Makefile-x86_64 RC14-rc2-git5-uml-makefiles/arch/um/Makefile-x86_64
--- RC14-rc2-git5-net-noise/arch/um/Makefile-x86_64	2005-09-10 15:41:34.000000000 -0400
+++ RC14-rc2-git5-uml-makefiles/arch/um/Makefile-x86_64	2005-09-25 23:46:47.000000000 -0400
@@ -12,24 +12,3 @@
 
 ELF_ARCH := i386:x86-64
 ELF_FORMAT := elf64-x86-64
-
-SYS_UTIL_DIR := $(ARCH_DIR)/sys-x86_64/util
-SYS_DIR := $(ARCH_DIR)/include/sysdep-x86_64
-
-SYS_HEADERS = $(SYS_DIR)/sc.h $(SYS_DIR)/thread.h
-
-prepare: $(SYS_HEADERS)
-
-$(SYS_DIR)/sc.h: $(SYS_UTIL_DIR)/mk_sc
-	$(call filechk,gen_header)
-
-$(SYS_DIR)/thread.h: $(SYS_UTIL_DIR)/mk_thread
-	$(call filechk,gen_header)
-
-$(SYS_UTIL_DIR)/mk_sc: scripts_basic $(ARCH_DIR)/user-offsets.h FORCE
-	$(Q)$(MAKE) $(build)=$(SYS_UTIL_DIR) $@
-
-$(SYS_UTIL_DIR)/mk_thread: scripts_basic $(GEN_HEADERS) $(ARCH_DIR)/kernel-offsets.h FORCE
-	$(Q)$(MAKE) $(build)=$(SYS_UTIL_DIR) $@
-
-CLEAN_FILES += $(SYS_HEADERS)
diff -urN RC14-rc2-git5-net-noise/arch/um/include/common-offsets.h RC14-rc2-git5-uml-makefiles/arch/um/include/common-offsets.h
--- RC14-rc2-git5-net-noise/arch/um/include/common-offsets.h	2005-09-25 23:45:54.000000000 -0400
+++ RC14-rc2-git5-uml-makefiles/arch/um/include/common-offsets.h	2005-09-25 23:46:47.000000000 -0400
@@ -1,7 +1,7 @@
 /* for use by sys-$SUBARCH/kernel-offsets.c */
 
-OFFSET(TASK_REGS, task_struct, thread.regs);
-OFFSET(TASK_PID, task_struct, pid);
+OFFSET(HOST_TASK_REGS, task_struct, thread.regs);
+OFFSET(HOST_TASK_PID, task_struct, pid);
 DEFINE(UM_KERN_PAGE_SIZE, PAGE_SIZE);
 DEFINE(UM_NSEC_PER_SEC, NSEC_PER_SEC);
 DEFINE_STR(UM_KERN_EMERG, KERN_EMERG);
diff -urN RC14-rc2-git5-net-noise/arch/um/include/skas_ptregs.h RC14-rc2-git5-uml-makefiles/arch/um/include/skas_ptregs.h
--- RC14-rc2-git5-net-noise/arch/um/include/skas_ptregs.h	1969-12-31 19:00:00.000000000 -0500
+++ RC14-rc2-git5-uml-makefiles/arch/um/include/skas_ptregs.h	2005-09-25 23:46:47.000000000 -0400
@@ -0,0 +1,6 @@
+#ifndef __SKAS_PT_REGS_
+#define __SKAS_PT_REGS_
+
+#include <user_constants.h>
+
+#endif
diff -urN RC14-rc2-git5-net-noise/arch/um/include/sysdep-i386/sc.h RC14-rc2-git5-uml-makefiles/arch/um/include/sysdep-i386/sc.h
--- RC14-rc2-git5-net-noise/arch/um/include/sysdep-i386/sc.h	1969-12-31 19:00:00.000000000 -0500
+++ RC14-rc2-git5-uml-makefiles/arch/um/include/sysdep-i386/sc.h	2005-09-25 23:46:47.000000000 -0400
@@ -0,0 +1,44 @@
+#ifndef __SYSDEP_I386_SC_H
+#define __SYSDEP_I386_SC_H
+
+#include <user_constants.h>
+
+#define SC_OFFSET(sc, field) \
+	*((unsigned long *) &(((char *) (sc))[HOST_##field]))
+#define SC_FP_OFFSET(sc, field) \
+	*((unsigned long *) &(((char *) (SC_FPSTATE(sc)))[HOST_##field]))
+#define SC_FP_OFFSET_PTR(sc, field, type) \
+	((type *) &(((char *) (SC_FPSTATE(sc)))[HOST_##field]))
+
+#define SC_IP(sc) SC_OFFSET(sc, SC_IP)
+#define SC_SP(sc) SC_OFFSET(sc, SC_SP)
+#define SC_FS(sc) SC_OFFSET(sc, SC_FS)
+#define SC_GS(sc) SC_OFFSET(sc, SC_GS)
+#define SC_DS(sc) SC_OFFSET(sc, SC_DS)
+#define SC_ES(sc) SC_OFFSET(sc, SC_ES)
+#define SC_SS(sc) SC_OFFSET(sc, SC_SS)
+#define SC_CS(sc) SC_OFFSET(sc, SC_CS)
+#define SC_EFLAGS(sc) SC_OFFSET(sc, SC_EFLAGS)
+#define SC_EAX(sc) SC_OFFSET(sc, SC_EAX)
+#define SC_EBX(sc) SC_OFFSET(sc, SC_EBX)
+#define SC_ECX(sc) SC_OFFSET(sc, SC_ECX)
+#define SC_EDX(sc) SC_OFFSET(sc, SC_EDX)
+#define SC_EDI(sc) SC_OFFSET(sc, SC_EDI)
+#define SC_ESI(sc) SC_OFFSET(sc, SC_ESI)
+#define SC_EBP(sc) SC_OFFSET(sc, SC_EBP)
+#define SC_TRAPNO(sc) SC_OFFSET(sc, SC_TRAPNO)
+#define SC_ERR(sc) SC_OFFSET(sc, SC_ERR)
+#define SC_CR2(sc) SC_OFFSET(sc, SC_CR2)
+#define SC_FPSTATE(sc) SC_OFFSET(sc, SC_FPSTATE)
+#define SC_SIGMASK(sc) SC_OFFSET(sc, SC_SIGMASK)
+#define SC_FP_CW(sc) SC_FP_OFFSET(sc, SC_FP_CW)
+#define SC_FP_SW(sc) SC_FP_OFFSET(sc, SC_FP_SW)
+#define SC_FP_TAG(sc) SC_FP_OFFSET(sc, SC_FP_TAG)
+#define SC_FP_IPOFF(sc) SC_FP_OFFSET(sc, SC_FP_IPOFF)
+#define SC_FP_CSSEL(sc) SC_FP_OFFSET(sc, SC_FP_CSSEL)
+#define SC_FP_DATAOFF(sc) SC_FP_OFFSET(sc, SC_FP_DATAOFF)
+#define SC_FP_DATASEL(sc) SC_FP_OFFSET(sc, SC_FP_DATASEL)
+#define SC_FP_ST(sc) SC_FP_OFFSET_PTR(sc, SC_FP_ST, struct _fpstate)
+#define SC_FXSR_ENV(sc) SC_FP_OFFSET_PTR(sc, SC_FXSR_ENV, void)
+
+#endif
diff -urN RC14-rc2-git5-net-noise/arch/um/include/sysdep-i386/thread.h RC14-rc2-git5-uml-makefiles/arch/um/include/sysdep-i386/thread.h
--- RC14-rc2-git5-net-noise/arch/um/include/sysdep-i386/thread.h	1969-12-31 19:00:00.000000000 -0500
+++ RC14-rc2-git5-uml-makefiles/arch/um/include/sysdep-i386/thread.h	2005-09-25 23:46:47.000000000 -0400
@@ -0,0 +1,11 @@
+#ifndef __UM_THREAD_H
+#define __UM_THREAD_H
+
+#include <kern_constants.h>
+
+#define TASK_DEBUGREGS(task) ((unsigned long *) &(((char *) (task))[HOST_TASK_DEBUGREGS]))
+#ifdef CONFIG_MODE_TT
+#define TASK_EXTERN_PID(task) *((int *) &(((char *) (task))[HOST_TASK_EXTERN_PID]))
+#endif
+
+#endif
diff -urN RC14-rc2-git5-net-noise/arch/um/include/sysdep-x86_64/sc.h RC14-rc2-git5-uml-makefiles/arch/um/include/sysdep-x86_64/sc.h
--- RC14-rc2-git5-net-noise/arch/um/include/sysdep-x86_64/sc.h	1969-12-31 19:00:00.000000000 -0500
+++ RC14-rc2-git5-uml-makefiles/arch/um/include/sysdep-x86_64/sc.h	2005-09-25 23:46:47.000000000 -0400
@@ -0,0 +1,45 @@
+#ifndef __SYSDEP_X86_64_SC_H
+#define __SYSDEP_X86_64_SC_H
+
+/* Copyright (C) 2003 - 2004 PathScale, Inc
+ * Released under the GPL
+ */
+
+#include <user_constants.h>
+
+#define SC_OFFSET(sc, field) \
+	 *((unsigned long *) &(((char *) (sc))[HOST_##field]))
+
+#define SC_RBX(sc) SC_OFFSET(sc, SC_RBX)
+#define SC_RCX(sc) SC_OFFSET(sc, SC_RCX)
+#define SC_RDX(sc) SC_OFFSET(sc, SC_RDX)
+#define SC_RSI(sc) SC_OFFSET(sc, SC_RSI)
+#define SC_RDI(sc) SC_OFFSET(sc, SC_RDI)
+#define SC_RBP(sc) SC_OFFSET(sc, SC_RBP)
+#define SC_RAX(sc) SC_OFFSET(sc, SC_RAX)
+#define SC_R8(sc) SC_OFFSET(sc, SC_R8)
+#define SC_R9(sc) SC_OFFSET(sc, SC_R9)
+#define SC_R10(sc) SC_OFFSET(sc, SC_R10)
+#define SC_R11(sc) SC_OFFSET(sc, SC_R11)
+#define SC_R12(sc) SC_OFFSET(sc, SC_R12)
+#define SC_R13(sc) SC_OFFSET(sc, SC_R13)
+#define SC_R14(sc) SC_OFFSET(sc, SC_R14)
+#define SC_R15(sc) SC_OFFSET(sc, SC_R15)
+#define SC_IP(sc) SC_OFFSET(sc, SC_IP)
+#define SC_SP(sc) SC_OFFSET(sc, SC_SP)
+#define SC_CR2(sc) SC_OFFSET(sc, SC_CR2)
+#define SC_ERR(sc) SC_OFFSET(sc, SC_ERR)
+#define SC_TRAPNO(sc) SC_OFFSET(sc, SC_TRAPNO)
+#define SC_CS(sc) SC_OFFSET(sc, SC_CS)
+#define SC_FS(sc) SC_OFFSET(sc, SC_FS)
+#define SC_GS(sc) SC_OFFSET(sc, SC_GS)
+#define SC_EFLAGS(sc) SC_OFFSET(sc, SC_EFLAGS)
+#define SC_SIGMASK(sc) SC_OFFSET(sc, SC_SIGMASK)
+#if 0
+#define SC_ORIG_RAX(sc) SC_OFFSET(sc, SC_ORIG_RAX)
+#define SC_DS(sc) SC_OFFSET(sc, SC_DS)
+#define SC_ES(sc) SC_OFFSET(sc, SC_ES)
+#define SC_SS(sc) SC_OFFSET(sc, SC_SS)
+#endif
+
+#endif
diff -urN RC14-rc2-git5-net-noise/arch/um/include/sysdep-x86_64/thread.h RC14-rc2-git5-uml-makefiles/arch/um/include/sysdep-x86_64/thread.h
--- RC14-rc2-git5-net-noise/arch/um/include/sysdep-x86_64/thread.h	1969-12-31 19:00:00.000000000 -0500
+++ RC14-rc2-git5-uml-makefiles/arch/um/include/sysdep-x86_64/thread.h	2005-09-25 23:46:47.000000000 -0400
@@ -0,0 +1,10 @@
+#ifndef __UM_THREAD_H
+#define __UM_THREAD_H
+
+#include <kern_constants.h>
+
+#ifdef CONFIG_MODE_TT
+#define TASK_EXTERN_PID(task) *((int *) &(((char *) (task))[HOST_TASK_EXTERN_PID]))
+#endif
+
+#endif
diff -urN RC14-rc2-git5-net-noise/arch/um/include/task.h RC14-rc2-git5-uml-makefiles/arch/um/include/task.h
--- RC14-rc2-git5-net-noise/arch/um/include/task.h	1969-12-31 19:00:00.000000000 -0500
+++ RC14-rc2-git5-uml-makefiles/arch/um/include/task.h	2005-09-25 23:46:47.000000000 -0400
@@ -0,0 +1,9 @@
+#ifndef __TASK_H
+#define __TASK_H
+
+#include <kern_constants.h>
+
+#define TASK_REGS(task) ((union uml_pt_regs *) &(((char *) (task))[HOST_TASK_REGS]))
+#define TASK_PID(task) *((int *) &(((char *) (task))[HOST_TASK_PID]))
+
+#endif
diff -urN RC14-rc2-git5-net-noise/arch/um/kernel/skas/Makefile RC14-rc2-git5-uml-makefiles/arch/um/kernel/skas/Makefile
--- RC14-rc2-git5-net-noise/arch/um/kernel/skas/Makefile	2005-09-05 07:05:14.000000000 -0400
+++ RC14-rc2-git5-uml-makefiles/arch/um/kernel/skas/Makefile	2005-09-25 23:46:47.000000000 -0400
@@ -6,8 +6,6 @@
 obj-y := clone.o exec_kern.o mem.o mem_user.o mmu.o process.o process_kern.o \
 	syscall.o tlb.o trap_user.o uaccess.o
 
-subdir- := util
-
 USER_OBJS := process.o clone.o
 
 include arch/um/scripts/Makefile.rules
diff -urN RC14-rc2-git5-net-noise/arch/um/kernel/skas/util/Makefile RC14-rc2-git5-uml-makefiles/arch/um/kernel/skas/util/Makefile
--- RC14-rc2-git5-net-noise/arch/um/kernel/skas/util/Makefile	2005-06-17 15:48:29.000000000 -0400
+++ RC14-rc2-git5-uml-makefiles/arch/um/kernel/skas/util/Makefile	1969-12-31 19:00:00.000000000 -0500
@@ -1,5 +0,0 @@
-hostprogs-y		:= mk_ptregs
-always			:= $(hostprogs-y)
-
-mk_ptregs-objs := mk_ptregs-$(SUBARCH).o
-HOSTCFLAGS_mk_ptregs-$(SUBARCH).o := -I$(objtree)/arch/um
diff -urN RC14-rc2-git5-net-noise/arch/um/kernel/skas/util/mk_ptregs-i386.c RC14-rc2-git5-uml-makefiles/arch/um/kernel/skas/util/mk_ptregs-i386.c
--- RC14-rc2-git5-net-noise/arch/um/kernel/skas/util/mk_ptregs-i386.c	2005-06-17 15:48:29.000000000 -0400
+++ RC14-rc2-git5-uml-makefiles/arch/um/kernel/skas/util/mk_ptregs-i386.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,49 +0,0 @@
-#include <stdio.h>
-#include <user-offsets.h>
-
-#define SHOW(name) printf("#define %s %d\n", #name, name)
-
-int main(int argc, char **argv)
-{
-	printf("/* Automatically generated by "
-	       "arch/um/kernel/skas/util/mk_ptregs */\n");
-	printf("\n");
-	printf("#ifndef __SKAS_PT_REGS_\n");
-	printf("#define __SKAS_PT_REGS_\n");
-	printf("\n");
-	SHOW(HOST_FRAME_SIZE);
-	SHOW(HOST_FP_SIZE);
-	SHOW(HOST_XFP_SIZE);
-
-	SHOW(HOST_IP);
-	SHOW(HOST_SP);
-	SHOW(HOST_EFLAGS);
-	SHOW(HOST_EAX);
-	SHOW(HOST_EBX);
-	SHOW(HOST_ECX);
-	SHOW(HOST_EDX);
-	SHOW(HOST_ESI);
-	SHOW(HOST_EDI);
-	SHOW(HOST_EBP);
-	SHOW(HOST_CS);
-	SHOW(HOST_SS);
-	SHOW(HOST_DS);
-	SHOW(HOST_FS);
-	SHOW(HOST_ES);
-	SHOW(HOST_GS);
-
-	printf("\n");
-	printf("#endif\n");
-	return(0);
-}
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -urN RC14-rc2-git5-net-noise/arch/um/kernel/skas/util/mk_ptregs-x86_64.c RC14-rc2-git5-uml-makefiles/arch/um/kernel/skas/util/mk_ptregs-x86_64.c
--- RC14-rc2-git5-net-noise/arch/um/kernel/skas/util/mk_ptregs-x86_64.c	2005-06-17 15:48:29.000000000 -0400
+++ RC14-rc2-git5-uml-makefiles/arch/um/kernel/skas/util/mk_ptregs-x86_64.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,66 +0,0 @@
-/*
- * Copyright 2003 PathScale, Inc.
- *
- * Licensed under the GPL
- */
-
-#include <stdio.h>
-#include <user-offsets.h>
-
-#define SHOW(name) \
-	printf("#define %s (%d / sizeof(unsigned long))\n", #name, name)
-
-int main(int argc, char **argv)
-{
-	printf("/* Automatically generated by "
-	       "arch/um/kernel/skas/util/mk_ptregs */\n");
-	printf("\n");
-	printf("#ifndef __SKAS_PT_REGS_\n");
-	printf("#define __SKAS_PT_REGS_\n");
-	SHOW(HOST_FRAME_SIZE);
-	SHOW(HOST_RBX);
-	SHOW(HOST_RCX);
-	SHOW(HOST_RDI);
-	SHOW(HOST_RSI);
-	SHOW(HOST_RDX);
-	SHOW(HOST_RBP);
-	SHOW(HOST_RAX);
-	SHOW(HOST_R8);
-	SHOW(HOST_R9);
-	SHOW(HOST_R10);
-	SHOW(HOST_R11);
-	SHOW(HOST_R12);
-	SHOW(HOST_R13);
-	SHOW(HOST_R14);
-	SHOW(HOST_R15);
-	SHOW(HOST_ORIG_RAX);
-	SHOW(HOST_CS);
-	SHOW(HOST_SS);
-	SHOW(HOST_EFLAGS);
-#if 0
-	SHOW(HOST_FS);
-	SHOW(HOST_GS);
-	SHOW(HOST_DS);
-	SHOW(HOST_ES);
-#endif
-
-	SHOW(HOST_IP);
-	SHOW(HOST_SP);
-	printf("#define HOST_FP_SIZE 0\n");
-	printf("#define HOST_XFP_SIZE 0\n");
-	printf("\n");
-	printf("\n");
-	printf("#endif\n");
-	return(0);
-}
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -urN RC14-rc2-git5-net-noise/arch/um/os-Linux/elf_aux.c RC14-rc2-git5-uml-makefiles/arch/um/os-Linux/elf_aux.c
--- RC14-rc2-git5-net-noise/arch/um/os-Linux/elf_aux.c	2005-09-25 23:45:54.000000000 -0400
+++ RC14-rc2-git5-uml-makefiles/arch/um/os-Linux/elf_aux.c	2005-09-25 23:46:47.000000000 -0400
@@ -12,7 +12,7 @@
 #include "init.h"
 #include "elf_user.h"
 #include "mem_user.h"
-#include <kernel-offsets.h>
+#include <kern_constants.h>
 
 /* Use the one from the kernel - the host may miss it, if having old headers. */
 #if UM_ELF_CLASS == UM_ELFCLASS32
diff -urN RC14-rc2-git5-net-noise/arch/um/os-Linux/util/Makefile RC14-rc2-git5-uml-makefiles/arch/um/os-Linux/util/Makefile
--- RC14-rc2-git5-net-noise/arch/um/os-Linux/util/Makefile	2005-06-17 15:48:29.000000000 -0400
+++ RC14-rc2-git5-uml-makefiles/arch/um/os-Linux/util/Makefile	1969-12-31 19:00:00.000000000 -0500
@@ -1,4 +0,0 @@
-hostprogs-y		:= mk_user_constants
-always			:= $(hostprogs-y)
-
-HOSTCFLAGS_mk_user_constants.o := -I$(objtree)/arch/um
diff -urN RC14-rc2-git5-net-noise/arch/um/os-Linux/util/mk_user_constants.c RC14-rc2-git5-uml-makefiles/arch/um/os-Linux/util/mk_user_constants.c
--- RC14-rc2-git5-net-noise/arch/um/os-Linux/util/mk_user_constants.c	2005-06-17 15:48:29.000000000 -0400
+++ RC14-rc2-git5-uml-makefiles/arch/um/os-Linux/util/mk_user_constants.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,23 +0,0 @@
-#include <stdio.h>
-#include <user-offsets.h>
-
-int main(int argc, char **argv)
-{
-  printf("/*\n");
-  printf(" * Generated by mk_user_constants\n");
-  printf(" */\n");
-  printf("\n");
-  printf("#ifndef __UM_USER_CONSTANTS_H\n");
-  printf("#define __UM_USER_CONSTANTS_H\n");
-  printf("\n");
-  /* I'd like to use FRAME_SIZE from ptrace.h here, but that's wrong on
-   * x86_64 (216 vs 168 bytes).  user_regs_struct is the correct size on
-   * both x86_64 and i386.
-   */
-  printf("#define UM_FRAME_SIZE %d\n", __UM_FRAME_SIZE);
-
-  printf("\n");
-  printf("#endif\n");
-
-  return(0);
-}
diff -urN RC14-rc2-git5-net-noise/arch/um/sys-i386/Makefile RC14-rc2-git5-uml-makefiles/arch/um/sys-i386/Makefile
--- RC14-rc2-git5-net-noise/arch/um/sys-i386/Makefile	2005-09-05 07:05:14.000000000 -0400
+++ RC14-rc2-git5-uml-makefiles/arch/um/sys-i386/Makefile	2005-09-25 23:46:47.000000000 -0400
@@ -18,6 +18,4 @@
 
 $(obj)/stub_segv.o : _c_flags = $(call unprofile,$(CFLAGS))
 
-subdir- := util
-
 include arch/um/scripts/Makefile.unmap
diff -urN RC14-rc2-git5-net-noise/arch/um/sys-i386/kernel-offsets.c RC14-rc2-git5-uml-makefiles/arch/um/sys-i386/kernel-offsets.c
--- RC14-rc2-git5-net-noise/arch/um/sys-i386/kernel-offsets.c	2005-09-08 10:07:30.000000000 -0400
+++ RC14-rc2-git5-uml-makefiles/arch/um/sys-i386/kernel-offsets.c	2005-09-25 23:46:47.000000000 -0400
@@ -18,9 +18,9 @@
 
 void foo(void)
 {
-	OFFSET(TASK_DEBUGREGS, task_struct, thread.arch.debugregs);
+	OFFSET(HOST_TASK_DEBUGREGS, task_struct, thread.arch.debugregs);
 #ifdef CONFIG_MODE_TT
-	OFFSET(TASK_EXTERN_PID, task_struct, thread.mode.tt.extern_pid);
+	OFFSET(HOST_TASK_EXTERN_PID, task_struct, thread.mode.tt.extern_pid);
 #endif
 #include <common-offsets.h>
 }
diff -urN RC14-rc2-git5-net-noise/arch/um/sys-i386/user-offsets.c RC14-rc2-git5-uml-makefiles/arch/um/sys-i386/user-offsets.c
--- RC14-rc2-git5-net-noise/arch/um/sys-i386/user-offsets.c	2005-06-17 15:48:29.000000000 -0400
+++ RC14-rc2-git5-uml-makefiles/arch/um/sys-i386/user-offsets.c	2005-09-25 23:46:47.000000000 -0400
@@ -7,47 +7,48 @@
 #define DEFINE(sym, val) \
         asm volatile("\n->" #sym " %0 " #val : : "i" (val))
 
+#define DEFINE_LONGS(sym, val) \
+        asm volatile("\n->" #sym " %0 " #val : : "i" (val/sizeof(unsigned long)))
+
 #define OFFSET(sym, str, mem) \
 	DEFINE(sym, offsetof(struct str, mem));
 
 void foo(void)
 {
-	OFFSET(SC_IP, sigcontext, eip);
-	OFFSET(SC_SP, sigcontext, esp);
-	OFFSET(SC_FS, sigcontext, fs);
-	OFFSET(SC_GS, sigcontext, gs);
-	OFFSET(SC_DS, sigcontext, ds);
-	OFFSET(SC_ES, sigcontext, es);
-	OFFSET(SC_SS, sigcontext, ss);
-	OFFSET(SC_CS, sigcontext, cs);
-	OFFSET(SC_EFLAGS, sigcontext, eflags);
-	OFFSET(SC_EAX, sigcontext, eax);
-	OFFSET(SC_EBX, sigcontext, ebx);
-	OFFSET(SC_ECX, sigcontext, ecx);
-	OFFSET(SC_EDX, sigcontext, edx);
-	OFFSET(SC_EDI, sigcontext, edi);
-	OFFSET(SC_ESI, sigcontext, esi);
-	OFFSET(SC_EBP, sigcontext, ebp);
-	OFFSET(SC_TRAPNO, sigcontext, trapno);
-	OFFSET(SC_ERR, sigcontext, err);
-	OFFSET(SC_CR2, sigcontext, cr2);
-	OFFSET(SC_FPSTATE, sigcontext, fpstate);
-	OFFSET(SC_SIGMASK, sigcontext, oldmask);
-	OFFSET(SC_FP_CW, _fpstate, cw);
-	OFFSET(SC_FP_SW, _fpstate, sw);
-	OFFSET(SC_FP_TAG, _fpstate, tag);
-	OFFSET(SC_FP_IPOFF, _fpstate, ipoff);
-	OFFSET(SC_FP_CSSEL, _fpstate, cssel);
-	OFFSET(SC_FP_DATAOFF, _fpstate, dataoff);
-	OFFSET(SC_FP_DATASEL, _fpstate, datasel);
-	OFFSET(SC_FP_ST, _fpstate, _st);
-	OFFSET(SC_FXSR_ENV, _fpstate, _fxsr_env);
+	OFFSET(HOST_SC_IP, sigcontext, eip);
+	OFFSET(HOST_SC_SP, sigcontext, esp);
+	OFFSET(HOST_SC_FS, sigcontext, fs);
+	OFFSET(HOST_SC_GS, sigcontext, gs);
+	OFFSET(HOST_SC_DS, sigcontext, ds);
+	OFFSET(HOST_SC_ES, sigcontext, es);
+	OFFSET(HOST_SC_SS, sigcontext, ss);
+	OFFSET(HOST_SC_CS, sigcontext, cs);
+	OFFSET(HOST_SC_EFLAGS, sigcontext, eflags);
+	OFFSET(HOST_SC_EAX, sigcontext, eax);
+	OFFSET(HOST_SC_EBX, sigcontext, ebx);
+	OFFSET(HOST_SC_ECX, sigcontext, ecx);
+	OFFSET(HOST_SC_EDX, sigcontext, edx);
+	OFFSET(HOST_SC_EDI, sigcontext, edi);
+	OFFSET(HOST_SC_ESI, sigcontext, esi);
+	OFFSET(HOST_SC_EBP, sigcontext, ebp);
+	OFFSET(HOST_SC_TRAPNO, sigcontext, trapno);
+	OFFSET(HOST_SC_ERR, sigcontext, err);
+	OFFSET(HOST_SC_CR2, sigcontext, cr2);
+	OFFSET(HOST_SC_FPSTATE, sigcontext, fpstate);
+	OFFSET(HOST_SC_SIGMASK, sigcontext, oldmask);
+	OFFSET(HOST_SC_FP_CW, _fpstate, cw);
+	OFFSET(HOST_SC_FP_SW, _fpstate, sw);
+	OFFSET(HOST_SC_FP_TAG, _fpstate, tag);
+	OFFSET(HOST_SC_FP_IPOFF, _fpstate, ipoff);
+	OFFSET(HOST_SC_FP_CSSEL, _fpstate, cssel);
+	OFFSET(HOST_SC_FP_DATAOFF, _fpstate, dataoff);
+	OFFSET(HOST_SC_FP_DATASEL, _fpstate, datasel);
+	OFFSET(HOST_SC_FP_ST, _fpstate, _st);
+	OFFSET(HOST_SC_FXSR_ENV, _fpstate, _fxsr_env);
 
-	DEFINE(HOST_FRAME_SIZE, FRAME_SIZE);
-	DEFINE(HOST_FP_SIZE,
-		sizeof(struct user_i387_struct) / sizeof(unsigned long));
-	DEFINE(HOST_XFP_SIZE,
-	       sizeof(struct user_fxsr_struct) / sizeof(unsigned long));
+	DEFINE_LONGS(HOST_FRAME_SIZE, FRAME_SIZE);
+	DEFINE_LONGS(HOST_FP_SIZE, sizeof(struct user_i387_struct));
+	DEFINE_LONGS(HOST_XFP_SIZE, sizeof(struct user_fxsr_struct));
 
 	DEFINE(HOST_IP, EIP);
 	DEFINE(HOST_SP, UESP);
@@ -65,5 +66,5 @@
 	DEFINE(HOST_FS, FS);
 	DEFINE(HOST_ES, ES);
 	DEFINE(HOST_GS, GS);
-	DEFINE(__UM_FRAME_SIZE, sizeof(struct user_regs_struct));
+	DEFINE(UM_FRAME_SIZE, sizeof(struct user_regs_struct));
 }
diff -urN RC14-rc2-git5-net-noise/arch/um/sys-i386/util/Makefile RC14-rc2-git5-uml-makefiles/arch/um/sys-i386/util/Makefile
--- RC14-rc2-git5-net-noise/arch/um/sys-i386/util/Makefile	2005-06-17 15:48:29.000000000 -0400
+++ RC14-rc2-git5-uml-makefiles/arch/um/sys-i386/util/Makefile	1969-12-31 19:00:00.000000000 -0500
@@ -1,5 +0,0 @@
-hostprogs-y	:= mk_sc mk_thread
-always		:= $(hostprogs-y)
-
-HOSTCFLAGS_mk_sc.o := -I$(objtree)/arch/um
-HOSTCFLAGS_mk_thread.o := -I$(objtree)/arch/um
diff -urN RC14-rc2-git5-net-noise/arch/um/sys-i386/util/mk_sc.c RC14-rc2-git5-uml-makefiles/arch/um/sys-i386/util/mk_sc.c
--- RC14-rc2-git5-net-noise/arch/um/sys-i386/util/mk_sc.c	2005-06-17 15:48:29.000000000 -0400
+++ RC14-rc2-git5-uml-makefiles/arch/um/sys-i386/util/mk_sc.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,51 +0,0 @@
-#include <stdio.h>
-#include <user-offsets.h>
-
-#define SC_OFFSET(name, field) \
-  printf("#define " #name "(sc) *((unsigned long *) &(((char *) (sc))[%d]))\n",\
-	 name)
-
-#define SC_FP_OFFSET(name, field) \
-  printf("#define " #name \
-	 "(sc) *((unsigned long *) &(((char *) (SC_FPSTATE(sc)))[%d]))\n",\
-	 name)
-
-#define SC_FP_OFFSET_PTR(name, field, type) \
-  printf("#define " #name \
-	 "(sc) ((" type " *) &(((char *) (SC_FPSTATE(sc)))[%d]))\n",\
-	 name)
-
-int main(int argc, char **argv)
-{
-  SC_OFFSET(SC_IP, eip);
-  SC_OFFSET(SC_SP, esp);
-  SC_OFFSET(SC_FS, fs);
-  SC_OFFSET(SC_GS, gs);
-  SC_OFFSET(SC_DS, ds);
-  SC_OFFSET(SC_ES, es);
-  SC_OFFSET(SC_SS, ss);
-  SC_OFFSET(SC_CS, cs);
-  SC_OFFSET(SC_EFLAGS, eflags);
-  SC_OFFSET(SC_EAX, eax);
-  SC_OFFSET(SC_EBX, ebx);
-  SC_OFFSET(SC_ECX, ecx);
-  SC_OFFSET(SC_EDX, edx);
-  SC_OFFSET(SC_EDI, edi);
-  SC_OFFSET(SC_ESI, esi);
-  SC_OFFSET(SC_EBP, ebp);
-  SC_OFFSET(SC_TRAPNO, trapno);
-  SC_OFFSET(SC_ERR, err);
-  SC_OFFSET(SC_CR2, cr2);
-  SC_OFFSET(SC_FPSTATE, fpstate);
-  SC_OFFSET(SC_SIGMASK, oldmask);
-  SC_FP_OFFSET(SC_FP_CW, cw);
-  SC_FP_OFFSET(SC_FP_SW, sw);
-  SC_FP_OFFSET(SC_FP_TAG, tag);
-  SC_FP_OFFSET(SC_FP_IPOFF, ipoff);
-  SC_FP_OFFSET(SC_FP_CSSEL, cssel);
-  SC_FP_OFFSET(SC_FP_DATAOFF, dataoff);
-  SC_FP_OFFSET(SC_FP_DATASEL, datasel);
-  SC_FP_OFFSET_PTR(SC_FP_ST, _st, "struct _fpstate");
-  SC_FP_OFFSET_PTR(SC_FXSR_ENV, _fxsr_env, "void");
-  return(0);
-}
diff -urN RC14-rc2-git5-net-noise/arch/um/sys-i386/util/mk_thread.c RC14-rc2-git5-uml-makefiles/arch/um/sys-i386/util/mk_thread.c
--- RC14-rc2-git5-net-noise/arch/um/sys-i386/util/mk_thread.c	2005-06-17 15:48:29.000000000 -0400
+++ RC14-rc2-git5-uml-makefiles/arch/um/sys-i386/util/mk_thread.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,22 +0,0 @@
-#include <stdio.h>
-#include <kernel-offsets.h>
-
-int main(int argc, char **argv)
-{
-  printf("/*\n");
-  printf(" * Generated by mk_thread\n");
-  printf(" */\n");
-  printf("\n");
-  printf("#ifndef __UM_THREAD_H\n");
-  printf("#define __UM_THREAD_H\n");
-  printf("\n");
-  printf("#define TASK_DEBUGREGS(task) ((unsigned long *) "
-	 "&(((char *) (task))[%d]))\n", TASK_DEBUGREGS);
-#ifdef TASK_EXTERN_PID
-  printf("#define TASK_EXTERN_PID(task) *((int *) &(((char *) (task))[%d]))\n",
-	 TASK_EXTERN_PID);
-#endif
-  printf("\n");
-  printf("#endif\n");
-  return(0);
-}
diff -urN RC14-rc2-git5-net-noise/arch/um/sys-x86_64/Makefile RC14-rc2-git5-uml-makefiles/arch/um/sys-x86_64/Makefile
--- RC14-rc2-git5-net-noise/arch/um/sys-x86_64/Makefile	2005-09-05 07:05:14.000000000 -0400
+++ RC14-rc2-git5-uml-makefiles/arch/um/sys-x86_64/Makefile	2005-09-25 23:46:47.000000000 -0400
@@ -29,6 +29,4 @@
 
 $(obj)/stub_segv.o: _c_flags = $(call unprofile,$(CFLAGS))
 
-subdir- := util
-
 include arch/um/scripts/Makefile.unmap
diff -urN RC14-rc2-git5-net-noise/arch/um/sys-x86_64/kernel-offsets.c RC14-rc2-git5-uml-makefiles/arch/um/sys-x86_64/kernel-offsets.c
--- RC14-rc2-git5-net-noise/arch/um/sys-x86_64/kernel-offsets.c	2005-09-08 10:07:30.000000000 -0400
+++ RC14-rc2-git5-uml-makefiles/arch/um/sys-x86_64/kernel-offsets.c	2005-09-25 23:46:47.000000000 -0400
@@ -19,7 +19,7 @@
 void foo(void)
 {
 #ifdef CONFIG_MODE_TT
-	OFFSET(TASK_EXTERN_PID, task_struct, thread.mode.tt.extern_pid);
+	OFFSET(HOST_TASK_EXTERN_PID, task_struct, thread.mode.tt.extern_pid);
 #endif
 #include <common-offsets.h>
 }
diff -urN RC14-rc2-git5-net-noise/arch/um/sys-x86_64/user-offsets.c RC14-rc2-git5-uml-makefiles/arch/um/sys-x86_64/user-offsets.c
--- RC14-rc2-git5-net-noise/arch/um/sys-x86_64/user-offsets.c	2005-06-17 15:48:29.000000000 -0400
+++ RC14-rc2-git5-uml-makefiles/arch/um/sys-x86_64/user-offsets.c	2005-09-25 23:46:47.000000000 -0400
@@ -16,71 +16,76 @@
 #define DEFINE(sym, val) \
         asm volatile("\n->" #sym " %0 " #val : : "i" (val))
 
+#define DEFINE_LONGS(sym, val) \
+        asm volatile("\n->" #sym " %0 " #val : : "i" (val/sizeof(unsigned long)))
+
 #define OFFSET(sym, str, mem) \
 	DEFINE(sym, offsetof(struct str, mem));
 
 void foo(void)
 {
-	OFFSET(SC_RBX, sigcontext, rbx);
-	OFFSET(SC_RCX, sigcontext, rcx);
-	OFFSET(SC_RDX, sigcontext, rdx);
-	OFFSET(SC_RSI, sigcontext, rsi);
-	OFFSET(SC_RDI, sigcontext, rdi);
-	OFFSET(SC_RBP, sigcontext, rbp);
-	OFFSET(SC_RAX, sigcontext, rax);
-	OFFSET(SC_R8, sigcontext, r8);
-	OFFSET(SC_R9, sigcontext, r9);
-	OFFSET(SC_R10, sigcontext, r10);
-	OFFSET(SC_R11, sigcontext, r11);
-	OFFSET(SC_R12, sigcontext, r12);
-	OFFSET(SC_R13, sigcontext, r13);
-	OFFSET(SC_R14, sigcontext, r14);
-	OFFSET(SC_R15, sigcontext, r15);
-	OFFSET(SC_IP, sigcontext, rip);
-	OFFSET(SC_SP, sigcontext, rsp);
-	OFFSET(SC_CR2, sigcontext, cr2);
-	OFFSET(SC_ERR, sigcontext, err);
-	OFFSET(SC_TRAPNO, sigcontext, trapno);
-	OFFSET(SC_CS, sigcontext, cs);
-	OFFSET(SC_FS, sigcontext, fs);
-	OFFSET(SC_GS, sigcontext, gs);
-	OFFSET(SC_EFLAGS, sigcontext, eflags);
-	OFFSET(SC_SIGMASK, sigcontext, oldmask);
+	OFFSET(HOST_SC_RBX, sigcontext, rbx);
+	OFFSET(HOST_SC_RCX, sigcontext, rcx);
+	OFFSET(HOST_SC_RDX, sigcontext, rdx);
+	OFFSET(HOST_SC_RSI, sigcontext, rsi);
+	OFFSET(HOST_SC_RDI, sigcontext, rdi);
+	OFFSET(HOST_SC_RBP, sigcontext, rbp);
+	OFFSET(HOST_SC_RAX, sigcontext, rax);
+	OFFSET(HOST_SC_R8, sigcontext, r8);
+	OFFSET(HOST_SC_R9, sigcontext, r9);
+	OFFSET(HOST_SC_R10, sigcontext, r10);
+	OFFSET(HOST_SC_R11, sigcontext, r11);
+	OFFSET(HOST_SC_R12, sigcontext, r12);
+	OFFSET(HOST_SC_R13, sigcontext, r13);
+	OFFSET(HOST_SC_R14, sigcontext, r14);
+	OFFSET(HOST_SC_R15, sigcontext, r15);
+	OFFSET(HOST_SC_IP, sigcontext, rip);
+	OFFSET(HOST_SC_SP, sigcontext, rsp);
+	OFFSET(HOST_SC_CR2, sigcontext, cr2);
+	OFFSET(HOST_SC_ERR, sigcontext, err);
+	OFFSET(HOST_SC_TRAPNO, sigcontext, trapno);
+	OFFSET(HOST_SC_CS, sigcontext, cs);
+	OFFSET(HOST_SC_FS, sigcontext, fs);
+	OFFSET(HOST_SC_GS, sigcontext, gs);
+	OFFSET(HOST_SC_EFLAGS, sigcontext, eflags);
+	OFFSET(HOST_SC_SIGMASK, sigcontext, oldmask);
 #if 0
-	OFFSET(SC_ORIG_RAX, sigcontext, orig_rax);
-	OFFSET(SC_DS, sigcontext, ds);
-	OFFSET(SC_ES, sigcontext, es);
-	OFFSET(SC_SS, sigcontext, ss);
+	OFFSET(HOST_SC_ORIG_RAX, sigcontext, orig_rax);
+	OFFSET(HOST_SC_DS, sigcontext, ds);
+	OFFSET(HOST_SC_ES, sigcontext, es);
+	OFFSET(HOST_SC_SS, sigcontext, ss);
 #endif
 
-	DEFINE(HOST_FRAME_SIZE, FRAME_SIZE);
-	DEFINE(HOST_RBX, RBX);
-	DEFINE(HOST_RCX, RCX);
-	DEFINE(HOST_RDI, RDI);
-	DEFINE(HOST_RSI, RSI);
-	DEFINE(HOST_RDX, RDX);
-	DEFINE(HOST_RBP, RBP);
-	DEFINE(HOST_RAX, RAX);
-	DEFINE(HOST_R8, R8);
-	DEFINE(HOST_R9, R9);
-	DEFINE(HOST_R10, R10);
-	DEFINE(HOST_R11, R11);
-	DEFINE(HOST_R12, R12);
-	DEFINE(HOST_R13, R13);
-	DEFINE(HOST_R14, R14);
-	DEFINE(HOST_R15, R15);
-	DEFINE(HOST_ORIG_RAX, ORIG_RAX);
-	DEFINE(HOST_CS, CS);
-	DEFINE(HOST_SS, SS);
-	DEFINE(HOST_EFLAGS, EFLAGS);
+	DEFINE_LONGS(HOST_FRAME_SIZE, FRAME_SIZE);
+	DEFINE(HOST_FP_SIZE, 0);
+	DEFINE(HOST_XFP_SIZE, 0);
+	DEFINE_LONGS(HOST_RBX, RBX);
+	DEFINE_LONGS(HOST_RCX, RCX);
+	DEFINE_LONGS(HOST_RDI, RDI);
+	DEFINE_LONGS(HOST_RSI, RSI);
+	DEFINE_LONGS(HOST_RDX, RDX);
+	DEFINE_LONGS(HOST_RBP, RBP);
+	DEFINE_LONGS(HOST_RAX, RAX);
+	DEFINE_LONGS(HOST_R8, R8);
+	DEFINE_LONGS(HOST_R9, R9);
+	DEFINE_LONGS(HOST_R10, R10);
+	DEFINE_LONGS(HOST_R11, R11);
+	DEFINE_LONGS(HOST_R12, R12);
+	DEFINE_LONGS(HOST_R13, R13);
+	DEFINE_LONGS(HOST_R14, R14);
+	DEFINE_LONGS(HOST_R15, R15);
+	DEFINE_LONGS(HOST_ORIG_RAX, ORIG_RAX);
+	DEFINE_LONGS(HOST_CS, CS);
+	DEFINE_LONGS(HOST_SS, SS);
+	DEFINE_LONGS(HOST_EFLAGS, EFLAGS);
 #if 0
-	DEFINE(HOST_FS, FS);
-	DEFINE(HOST_GS, GS);
-	DEFINE(HOST_DS, DS);
-	DEFINE(HOST_ES, ES);
+	DEFINE_LONGS(HOST_FS, FS);
+	DEFINE_LONGS(HOST_GS, GS);
+	DEFINE_LONGS(HOST_DS, DS);
+	DEFINE_LONGS(HOST_ES, ES);
 #endif
 
-	DEFINE(HOST_IP, RIP);
-	DEFINE(HOST_SP, RSP);
-	DEFINE(__UM_FRAME_SIZE, sizeof(struct user_regs_struct));
+	DEFINE_LONGS(HOST_IP, RIP);
+	DEFINE_LONGS(HOST_SP, RSP);
+	DEFINE(UM_FRAME_SIZE, sizeof(struct user_regs_struct));
 }
diff -urN RC14-rc2-git5-net-noise/arch/um/sys-x86_64/util/Makefile RC14-rc2-git5-uml-makefiles/arch/um/sys-x86_64/util/Makefile
--- RC14-rc2-git5-net-noise/arch/um/sys-x86_64/util/Makefile	2005-06-17 15:48:29.000000000 -0400
+++ RC14-rc2-git5-uml-makefiles/arch/um/sys-x86_64/util/Makefile	1969-12-31 19:00:00.000000000 -0500
@@ -1,8 +0,0 @@
-# Copyright 2003 - 2004 Pathscale, Inc
-# Released under the GPL
-
-hostprogs-y	:= mk_sc mk_thread
-always		:= $(hostprogs-y)
-
-HOSTCFLAGS_mk_sc.o := -I$(objtree)/arch/um
-HOSTCFLAGS_mk_thread.o := -I$(objtree)/arch/um
diff -urN RC14-rc2-git5-net-noise/arch/um/sys-x86_64/util/mk_sc.c RC14-rc2-git5-uml-makefiles/arch/um/sys-x86_64/util/mk_sc.c
--- RC14-rc2-git5-net-noise/arch/um/sys-x86_64/util/mk_sc.c	2005-06-17 15:48:29.000000000 -0400
+++ RC14-rc2-git5-uml-makefiles/arch/um/sys-x86_64/util/mk_sc.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,47 +0,0 @@
-/* Copyright (C) 2003 - 2004 PathScale, Inc
- * Released under the GPL
- */
-
-#include <stdio.h>
-#include <user-offsets.h>
-
-#define SC_OFFSET(name) \
-  printf("#define " #name \
-	 "(sc) *((unsigned long *) &(((char *) (sc))[%d]))\n",\
-	 name)
-
-int main(int argc, char **argv)
-{
-  SC_OFFSET(SC_RBX);
-  SC_OFFSET(SC_RCX);
-  SC_OFFSET(SC_RDX);
-  SC_OFFSET(SC_RSI);
-  SC_OFFSET(SC_RDI);
-  SC_OFFSET(SC_RBP);
-  SC_OFFSET(SC_RAX);
-  SC_OFFSET(SC_R8);
-  SC_OFFSET(SC_R9);
-  SC_OFFSET(SC_R10);
-  SC_OFFSET(SC_R11);
-  SC_OFFSET(SC_R12);
-  SC_OFFSET(SC_R13);
-  SC_OFFSET(SC_R14);
-  SC_OFFSET(SC_R15);
-  SC_OFFSET(SC_IP);
-  SC_OFFSET(SC_SP);
-  SC_OFFSET(SC_CR2);
-  SC_OFFSET(SC_ERR);
-  SC_OFFSET(SC_TRAPNO);
-  SC_OFFSET(SC_CS);
-  SC_OFFSET(SC_FS);
-  SC_OFFSET(SC_GS);
-  SC_OFFSET(SC_EFLAGS);
-  SC_OFFSET(SC_SIGMASK);
-#if 0
-  SC_OFFSET(SC_ORIG_RAX);
-  SC_OFFSET(SC_DS);
-  SC_OFFSET(SC_ES);
-  SC_OFFSET(SC_SS);
-#endif
-  return(0);
-}
diff -urN RC14-rc2-git5-net-noise/arch/um/sys-x86_64/util/mk_thread.c RC14-rc2-git5-uml-makefiles/arch/um/sys-x86_64/util/mk_thread.c
--- RC14-rc2-git5-net-noise/arch/um/sys-x86_64/util/mk_thread.c	2005-06-17 15:48:29.000000000 -0400
+++ RC14-rc2-git5-uml-makefiles/arch/um/sys-x86_64/util/mk_thread.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,20 +0,0 @@
-#include <stdio.h>
-#include <kernel-offsets.h>
-
-int main(int argc, char **argv)
-{
-  printf("/*\n");
-  printf(" * Generated by mk_thread\n");
-  printf(" */\n");
-  printf("\n");
-  printf("#ifndef __UM_THREAD_H\n");
-  printf("#define __UM_THREAD_H\n");
-  printf("\n");
-#ifdef TASK_EXTERN_PID
-  printf("#define TASK_EXTERN_PID(task) *((int *) &(((char *) (task))[%d]))\n",
-	 TASK_EXTERN_PID);
-#endif
-  printf("\n");
-  printf("#endif\n");
-  return(0);
-}
diff -urN RC14-rc2-git5-net-noise/arch/um/util/Makefile RC14-rc2-git5-uml-makefiles/arch/um/util/Makefile
--- RC14-rc2-git5-net-noise/arch/um/util/Makefile	2005-06-17 15:48:29.000000000 -0400
+++ RC14-rc2-git5-uml-makefiles/arch/um/util/Makefile	1969-12-31 19:00:00.000000000 -0500
@@ -1,5 +0,0 @@
-hostprogs-y		:= mk_task mk_constants
-always			:= $(hostprogs-y)
-
-HOSTCFLAGS_mk_task.o := -I$(objtree)/arch/um
-HOSTCFLAGS_mk_constants.o := -I$(objtree)/arch/um
diff -urN RC14-rc2-git5-net-noise/arch/um/util/mk_constants.c RC14-rc2-git5-uml-makefiles/arch/um/util/mk_constants.c
--- RC14-rc2-git5-net-noise/arch/um/util/mk_constants.c	2005-06-17 15:48:29.000000000 -0400
+++ RC14-rc2-git5-uml-makefiles/arch/um/util/mk_constants.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,32 +0,0 @@
-#include <stdio.h>
-#include <kernel-offsets.h>
-
-#define SHOW_INT(sym) printf("#define %s %d\n", #sym, sym)
-#define SHOW_STR(sym) printf("#define %s %s\n", #sym, sym)
-
-int main(int argc, char **argv)
-{
-  printf("/*\n");
-  printf(" * Generated by mk_constants\n");
-  printf(" */\n");
-  printf("\n");
-  printf("#ifndef __UM_CONSTANTS_H\n");
-  printf("#define __UM_CONSTANTS_H\n");
-  printf("\n");
-
-  SHOW_INT(UM_KERN_PAGE_SIZE);
-
-  SHOW_STR(UM_KERN_EMERG);
-  SHOW_STR(UM_KERN_ALERT);
-  SHOW_STR(UM_KERN_CRIT);
-  SHOW_STR(UM_KERN_ERR);
-  SHOW_STR(UM_KERN_WARNING);
-  SHOW_STR(UM_KERN_NOTICE);
-  SHOW_STR(UM_KERN_INFO);
-  SHOW_STR(UM_KERN_DEBUG);
-
-  SHOW_INT(UM_NSEC_PER_SEC);
-  printf("\n");
-  printf("#endif\n");
-  return(0);
-}
diff -urN RC14-rc2-git5-net-noise/arch/um/util/mk_task.c RC14-rc2-git5-uml-makefiles/arch/um/util/mk_task.c
--- RC14-rc2-git5-net-noise/arch/um/util/mk_task.c	2005-06-17 15:48:29.000000000 -0400
+++ RC14-rc2-git5-uml-makefiles/arch/um/util/mk_task.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,30 +0,0 @@
-#include <stdio.h>
-#include <kernel-offsets.h>
-
-void print_ptr(char *name, char *type, int offset)
-{
-  printf("#define %s(task) ((%s *) &(((char *) (task))[%d]))\n", name, type,
-	 offset);
-}
-
-void print(char *name, char *type, int offset)
-{
-  printf("#define %s(task) *((%s *) &(((char *) (task))[%d]))\n", name, type,
-	 offset);
-}
-
-int main(int argc, char **argv)
-{
-  printf("/*\n");
-  printf(" * Generated by mk_task\n");
-  printf(" */\n");
-  printf("\n");
-  printf("#ifndef __TASK_H\n");
-  printf("#define __TASK_H\n");
-  printf("\n");
-  print_ptr("TASK_REGS", "union uml_pt_regs", TASK_REGS);
-  print("TASK_PID", "int", TASK_PID);
-  printf("\n");
-  printf("#endif\n");
-  return(0);
-}
