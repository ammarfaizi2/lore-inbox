Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262093AbVAJFiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbVAJFiY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 00:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVAJFiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 00:38:24 -0500
Received: from pool-151-203-193-191.bos.east.verizon.net ([151.203.193.191]:19972
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262093AbVAJFOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 00:14:17 -0500
Message-Id: <200501100735.j0A7ZPPW005770@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 8/28] UML - x86_64 ptrace support
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jan 2005 02:35:25 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the x86_64 ptrace support.
It also cleans up the existing code somewhat, eliminating a couple of
simple header files, and generalizing the mk_ptregs buils to accomodate
multiple architectures.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.10/arch/um/include/sysdep-i386/ptrace.h
===================================================================
--- 2.6.10.orig/arch/um/include/sysdep-i386/ptrace.h	2005-01-09 19:06:08.000000000 -0500
+++ 2.6.10/arch/um/include/sysdep-i386/ptrace.h	2005-01-09 21:46:47.000000000 -0500
@@ -9,11 +9,52 @@
 #include "uml-config.h"
 
 #ifdef UML_CONFIG_MODE_TT
-#include "ptrace-tt.h"
+#include "sysdep/sc.h"
 #endif
 
 #ifdef UML_CONFIG_MODE_SKAS
-#include "ptrace-skas.h"
+
+/* syscall emulation path in ptrace */
+
+#ifndef PTRACE_SYSEMU
+#define PTRACE_SYSEMU 31
+#endif
+
+void set_using_sysemu(int value);
+int get_using_sysemu(void);
+extern int sysemu_supported;
+
+#include "skas_ptregs.h"
+
+#define HOST_FRAME_SIZE 17
+
+#define REGS_IP(r) ((r)[HOST_IP])
+#define REGS_SP(r) ((r)[HOST_SP])
+#define REGS_EFLAGS(r) ((r)[HOST_EFLAGS])
+#define REGS_EAX(r) ((r)[HOST_EAX])
+#define REGS_EBX(r) ((r)[HOST_EBX])
+#define REGS_ECX(r) ((r)[HOST_ECX])
+#define REGS_EDX(r) ((r)[HOST_EDX])
+#define REGS_ESI(r) ((r)[HOST_ESI])
+#define REGS_EDI(r) ((r)[HOST_EDI])
+#define REGS_EBP(r) ((r)[HOST_EBP])
+#define REGS_CS(r) ((r)[HOST_CS])
+#define REGS_SS(r) ((r)[HOST_SS])
+#define REGS_DS(r) ((r)[HOST_DS])
+#define REGS_ES(r) ((r)[HOST_ES])
+#define REGS_FS(r) ((r)[HOST_FS])
+#define REGS_GS(r) ((r)[HOST_GS])
+
+#define REGS_SET_SYSCALL_RETURN(r, res) REGS_EAX(r) = (res)
+
+#define REGS_RESTART_SYSCALL(r) IP_RESTART_SYSCALL(REGS_IP(r))
+
+#define REGS_SEGV_IS_FIXABLE(r) SEGV_IS_FIXABLE((r)->trap_type)
+
+#define REGS_FAULT_ADDR(r) ((r)->fault_addr)
+
+#define REGS_FAULT_WRITE(r) FAULT_WRITE((r)->fault_type)
+
 #endif
 #ifndef PTRACE_SYSEMU_SINGLESTEP
 #define PTRACE_SYSEMU_SINGLESTEP 32
Index: 2.6.10/arch/um/include/sysdep-x86_64/ptrace.h
===================================================================
--- 2.6.10.orig/arch/um/include/sysdep-x86_64/ptrace.h	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/include/sysdep-x86_64/ptrace.h	2005-01-09 21:59:58.000000000 -0500
@@ -0,0 +1,260 @@
+/*
+ * Copyright 2003 PathScale, Inc.
+ *
+ * Licensed under the GPL
+ */
+
+#ifndef __SYSDEP_X86_64_PTRACE_H
+#define __SYSDEP_X86_64_PTRACE_H
+
+#include "uml-config.h"
+
+#ifdef UML_CONFIG_MODE_TT
+#include "sysdep/sc.h"
+#endif
+
+#ifdef UML_CONFIG_MODE_SKAS
+#include "skas_ptregs.h"
+
+#define REGS_IP(r) ((r)[HOST_IP])
+#define REGS_SP(r) ((r)[HOST_SP])
+
+#define REGS_RBX(r) ((r)[HOST_RBX])
+#define REGS_RCX(r) ((r)[HOST_RCX])
+#define REGS_RDX(r) ((r)[HOST_RDX])
+#define REGS_RSI(r) ((r)[HOST_RSI])
+#define REGS_RDI(r) ((r)[HOST_RDI])
+#define REGS_RBP(r) ((r)[HOST_RBP])
+#define REGS_RAX(r) ((r)[HOST_RAX])
+#define REGS_R8(r) ((r)[HOST_R8])
+#define REGS_R9(r) ((r)[HOST_R9])
+#define REGS_R10(r) ((r)[HOST_R10])
+#define REGS_R11(r) ((r)[HOST_R11])
+#define REGS_R12(r) ((r)[HOST_R12])
+#define REGS_R13(r) ((r)[HOST_R13])
+#define REGS_R14(r) ((r)[HOST_R14])
+#define REGS_R15(r) ((r)[HOST_R15])
+#define REGS_CS(r) ((r)[HOST_CS])
+#define REGS_EFLAGS(r) ((r)[HOST_EFLAGS])
+#define REGS_SS(r) ((r)[HOST_SS])
+
+#define HOST_FS_BASE 21
+#define HOST_GS_BASE 22
+#define HOST_DS 23
+#define HOST_ES 24
+#define HOST_FS 25
+#define HOST_GS 26
+
+#define REGS_FS_BASE(r) ((r)[HOST_FS_BASE])
+#define REGS_GS_BASE(r) ((r)[HOST_GS_BASE])
+#define REGS_DS(r) ((r)[HOST_DS])
+#define REGS_ES(r) ((r)[HOST_ES])
+#define REGS_FS(r) ((r)[HOST_FS])
+#define REGS_GS(r) ((r)[HOST_GS])
+
+#define REGS_ORIG_RAX(r) ((r)[HOST_ORIG_RAX])
+
+#define REGS_SET_SYSCALL_RETURN(r, res) REGS_RAX(r) = (res)
+
+#define REGS_RESTART_SYSCALL(r) IP_RESTART_SYSCALL(REGS_IP(r))
+
+#define REGS_SEGV_IS_FIXABLE(r) SEGV_IS_FIXABLE((r)->trap_type)
+
+#define REGS_FAULT_ADDR(r) ((r)->fault_addr)
+
+#define REGS_FAULT_WRITE(r) FAULT_WRITE((r)->fault_type)
+
+#define REGS_TRAP(r) ((r)->trap_type)
+
+#define REGS_ERR(r) ((r)->fault_type)
+
+#endif
+
+#include "choose-mode.h"
+
+/* XXX */
+union uml_pt_regs {
+#ifdef UML_CONFIG_MODE_TT
+	struct tt_regs {
+		long syscall;
+		unsigned long orig_rax;
+		void *sc;
+	} tt;
+#endif
+#ifdef UML_CONFIG_MODE_SKAS
+	struct skas_regs {
+		/* XXX */
+		unsigned long regs[27];
+		unsigned long fp[65];
+		unsigned long fault_addr;
+		unsigned long fault_type;
+		unsigned long trap_type;
+		long syscall;
+		int is_user;
+	} skas;
+#endif
+};
+
+#define EMPTY_UML_PT_REGS { }
+
+/* XXX */
+extern int mode_tt;
+
+#define UPT_RBX(r) CHOOSE_MODE(SC_RBX(UPT_SC(r)), REGS_RBX((r)->skas.regs))
+#define UPT_RCX(r) CHOOSE_MODE(SC_RCX(UPT_SC(r)), REGS_RCX((r)->skas.regs))
+#define UPT_RDX(r) CHOOSE_MODE(SC_RDX(UPT_SC(r)), REGS_RDX((r)->skas.regs))
+#define UPT_RSI(r) CHOOSE_MODE(SC_RSI(UPT_SC(r)), REGS_RSI((r)->skas.regs))
+#define UPT_RDI(r) CHOOSE_MODE(SC_RDI(UPT_SC(r)), REGS_RDI((r)->skas.regs))
+#define UPT_RBP(r) CHOOSE_MODE(SC_RBP(UPT_SC(r)), REGS_RBP((r)->skas.regs))
+#define UPT_RAX(r) CHOOSE_MODE(SC_RAX(UPT_SC(r)), REGS_RAX((r)->skas.regs))
+#define UPT_R8(r) CHOOSE_MODE(SC_R8(UPT_SC(r)), REGS_R8((r)->skas.regs))
+#define UPT_R9(r) CHOOSE_MODE(SC_R9(UPT_SC(r)), REGS_R9((r)->skas.regs))
+#define UPT_R10(r) CHOOSE_MODE(SC_R10(UPT_SC(r)), REGS_R10((r)->skas.regs))
+#define UPT_R11(r) CHOOSE_MODE(SC_R11(UPT_SC(r)), REGS_R11((r)->skas.regs))
+#define UPT_R12(r) CHOOSE_MODE(SC_R12(UPT_SC(r)), REGS_R12((r)->skas.regs))
+#define UPT_R13(r) CHOOSE_MODE(SC_R13(UPT_SC(r)), REGS_R13((r)->skas.regs))
+#define UPT_R14(r) CHOOSE_MODE(SC_R14(UPT_SC(r)), REGS_R14((r)->skas.regs))
+#define UPT_R15(r) CHOOSE_MODE(SC_R15(UPT_SC(r)), REGS_R15((r)->skas.regs))
+#define UPT_CS(r) CHOOSE_MODE(SC_CS(UPT_SC(r)), REGS_CS((r)->skas.regs))
+#define UPT_FS(r) CHOOSE_MODE(SC_FS(UPT_SC(r)), REGS_FS((r)->skas.regs))
+#define UPT_GS(r) CHOOSE_MODE(SC_GS(UPT_SC(r)), REGS_GS((r)->skas.regs))
+#define UPT_DS(r) CHOOSE_MODE(SC_DS(UPT_SC(r)), REGS_DS((r)->skas.regs))
+#define UPT_ES(r) CHOOSE_MODE(SC_ES(UPT_SC(r)), REGS_ES((r)->skas.regs))
+#define UPT_CS(r) CHOOSE_MODE(SC_CS(UPT_SC(r)), REGS_CS((r)->skas.regs))
+#define UPT_ORIG_RAX(r) \
+	CHOOSE_MODE((r)->tt.orig_rax, REGS_ORIG_RAX((r)->skas.regs))
+
+#define UPT_IP(r) CHOOSE_MODE(SC_IP(UPT_SC(r)), REGS_IP((r)->skas.regs))
+#define UPT_SP(r) CHOOSE_MODE(SC_SP(UPT_SC(r)), REGS_SP((r)->skas.regs))
+
+#define UPT_EFLAGS(r) \
+	CHOOSE_MODE(SC_EFLAGS(UPT_SC(r)), REGS_EFLAGS((r)->skas.regs))
+#define UPT_SC(r) ((r)->tt.sc)
+#define UPT_SYSCALL_NR(r) CHOOSE_MODE((r)->tt.syscall, (r)->skas.syscall)
+
+extern int user_context(unsigned long sp);
+
+#define UPT_IS_USER(r) \
+	CHOOSE_MODE(user_context(UPT_SP(r)), (r)->skas.is_user)
+
+#define UPT_SYSCALL_ARG1(r) UPT_RDI(r)
+#define UPT_SYSCALL_ARG2(r) UPT_RSI(r)
+#define UPT_SYSCALL_ARG3(r) UPT_RDX(r)
+#define UPT_SYSCALL_ARG4(r) UPT_R10(r)
+#define UPT_SYSCALL_ARG5(r) UPT_R8(r)
+#define UPT_SYSCALL_ARG6(r) UPT_R9(r)
+
+struct syscall_args {
+	unsigned long args[6];
+};
+
+#define SYSCALL_ARGS(r) ((struct syscall_args) \
+                        { .args = { UPT_SYSCALL_ARG1(r), \
+                                    UPT_SYSCALL_ARG2(r), \
+ 			            UPT_SYSCALL_ARG3(r), \
+                                    UPT_SYSCALL_ARG4(r), \
+		                    UPT_SYSCALL_ARG5(r), \
+                                    UPT_SYSCALL_ARG6(r) } } )
+
+#define UPT_REG(regs, reg) \
+        ({      unsigned long val; \
+                switch(reg){ \
+		case R8: val = UPT_R8(regs); break; \
+		case R9: val = UPT_R9(regs); break; \
+		case R10: val = UPT_R10(regs); break; \
+		case R11: val = UPT_R11(regs); break; \
+		case R12: val = UPT_R12(regs); break; \
+		case R13: val = UPT_R13(regs); break; \
+		case R14: val = UPT_R14(regs); break; \
+		case R15: val = UPT_R15(regs); break; \
+                case RIP: val = UPT_IP(regs); break; \
+                case RSP: val = UPT_SP(regs); break; \
+                case RAX: val = UPT_RAX(regs); break; \
+                case RBX: val = UPT_RBX(regs); break; \
+                case RCX: val = UPT_RCX(regs); break; \
+                case RDX: val = UPT_RDX(regs); break; \
+                case RSI: val = UPT_RSI(regs); break; \
+                case RDI: val = UPT_RDI(regs); break; \
+                case RBP: val = UPT_RBP(regs); break; \
+                case ORIG_RAX: val = UPT_ORIG_RAX(regs); break; \
+                case CS: val = UPT_CS(regs); break; \
+                case DS: val = UPT_DS(regs); break; \
+                case ES: val = UPT_ES(regs); break; \
+                case FS: val = UPT_FS(regs); break; \
+                case GS: val = UPT_GS(regs); break; \
+                case EFLAGS: val = UPT_EFLAGS(regs); break; \
+                default :  \
+                        panic("Bad register in UPT_REG : %d\n", reg);  \
+                        val = -1; \
+                } \
+                val; \
+        })
+
+
+#define UPT_SET(regs, reg, val) \
+        ({      unsigned long val; \
+                switch(reg){ \
+		case R8: UPT_R8(regs) = val; break; \
+		case R9: UPT_R9(regs) = val; break; \
+		case R10: UPT_R10(regs) = val; break; \
+		case R11: UPT_R11(regs) = val; break; \
+		case R12: UPT_R12(regs) = val; break; \
+		case R13: UPT_R13(regs) = val; break; \
+		case R14: UPT_R14(regs) = val; break; \
+		case R15: UPT_R15(regs) = val; break; \
+                case RIP: UPT_IP(regs) = val; break; \
+                case RSP: UPT_SP(regs) = val; break; \
+                case RAX: UPT_RAX(regs) = val; break; \
+                case RBX: UPT_RBX(regs) = val; break; \
+                case RCX: UPT_RCX(regs) = val; break; \
+                case RDX: UPT_RDX(regs) = val; break; \
+                case RSI: UPT_RSI(regs) = val; break; \
+                case RDI: UPT_RDI(regs) = val; break; \
+                case RBP: UPT_RBP(regs) = val; break; \
+                case ORIG_RAX: UPT_ORIG_RAX(regs) = val; break; \
+                case CS: UPT_CS(regs) = val; break; \
+                case DS: UPT_DS(regs) = val; break; \
+                case ES: UPT_ES(regs) = val; break; \
+                case FS: UPT_FS(regs) = val; break; \
+                case GS: UPT_GS(regs) = val; break; \
+                case EFLAGS: UPT_EFLAGS(regs) = val; break; \
+                default :  \
+                        panic("Bad register in UPT_SET : %d\n", reg);  \
+			break; \
+                } \
+                val; \
+        })
+
+#define UPT_SET_SYSCALL_RETURN(r, res) \
+	CHOOSE_MODE(SC_SET_SYSCALL_RETURN(UPT_SC(r), (res)), \
+                    REGS_SET_SYSCALL_RETURN((r)->skas.regs, (res)))
+
+#define UPT_RESTART_SYSCALL(r) \
+	CHOOSE_MODE(SC_RESTART_SYSCALL(UPT_SC(r)), \
+		    REGS_RESTART_SYSCALL((r)->skas.regs))
+
+#define UPT_SEGV_IS_FIXABLE(r) \
+	CHOOSE_MODE(SC_SEGV_IS_FIXABLE(UPT_SC(r)), \
+                    REGS_SEGV_IS_FIXABLE(&r->skas))
+
+#define UPT_FAULT_ADDR(r) \
+	CHOOSE_MODE(SC_FAULT_ADDR(UPT_SC(r)), REGS_FAULT_ADDR(&r->skas))
+
+#define UPT_FAULT_WRITE(r) \
+	CHOOSE_MODE(SC_FAULT_WRITE(UPT_SC(r)), REGS_FAULT_WRITE(&r->skas))
+
+#define UPT_TRAP(r) CHOOSE_MODE(SC_TRAP_TYPE(UPT_SC(r)), REGS_TRAP(&r->skas))
+#define UPT_ERR(r) CHOOSE_MODE(SC_FAULT_TYPE(UPT_SC(r)), REGS_ERR(&r->skas))
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
Index: 2.6.10/arch/um/include/sysdep-x86_64/ptrace_user.h
===================================================================
--- 2.6.10.orig/arch/um/include/sysdep-x86_64/ptrace_user.h	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/include/sysdep-x86_64/ptrace_user.h	2005-01-09 21:52:21.000000000 -0500
@@ -0,0 +1,69 @@
+/*
+ * Copyright 2003 PathScale, Inc.
+ *
+ * Licensed under the GPL
+ */
+
+#ifndef __SYSDEP_X86_64_PTRACE_USER_H__
+#define __SYSDEP_X86_64_PTRACE_USER_H__
+
+#define __FRAME_OFFSETS
+#include <asm/ptrace.h>
+#undef __FRAME_OFFSETS
+
+#define PT_INDEX(off) ((off) / sizeof(unsigned long))
+
+#define PT_SYSCALL_NR(regs) ((regs)[PT_INDEX(ORIG_RAX)])
+#define PT_SYSCALL_NR_OFFSET (ORIG_RAX)
+
+#define PT_SYSCALL_ARG1(regs) (((unsigned long *) (regs))[PT_INDEX(RDI)])
+#define PT_SYSCALL_ARG1_OFFSET (RDI)
+
+#define PT_SYSCALL_ARG2(regs) (((unsigned long *) (regs))[PT_INDEX(RSI)])
+#define PT_SYSCALL_ARG2_OFFSET (RSI)
+
+#define PT_SYSCALL_ARG3(regs) (((unsigned long *) (regs))[PT_INDEX(RDX)])
+#define PT_SYSCALL_ARG3_OFFSET (RDX)
+
+#define PT_SYSCALL_ARG4(regs) (((unsigned long *) (regs))[PT_INDEX(RCX)])
+#define PT_SYSCALL_ARG4_OFFSET (RCX)
+
+#define PT_SYSCALL_ARG5(regs) (((unsigned long *) (regs))[PT_INDEX(R8)])
+#define PT_SYSCALL_ARG5_OFFSET (R8)
+
+#define PT_SYSCALL_ARG6(regs) (((unsigned long *) (regs))[PT_INDEX(R9)])
+#define PT_SYSCALL_ARG6_OFFSET (R9)
+
+#define PT_SYSCALL_RET_OFFSET (RAX)
+
+#define PT_IP_OFFSET (RIP)
+#define PT_IP(regs) ((regs)[PT_INDEX(RIP)])
+
+#define PT_SP_OFFSET (RSP)
+#define PT_SP(regs) ((regs)[PT_INDEX(RSP)])
+
+#define PT_ORIG_RAX_OFFSET (ORIG_RAX)
+#define PT_ORIG_RAX(regs) ((regs)[PT_INDEX(ORIG_RAX)])
+
+#define MAX_REG_OFFSET (FRAME_SIZE)
+#define MAX_REG_NR ((MAX_REG_OFFSET) / sizeof(unsigned long))
+
+/* x86_64 FC3 doesn't define this in /usr/include/linux/ptrace.h even though
+ * it's defined in the kernel's include/linux/ptrace.h
+ */
+#ifndef PTRACE_SETOPTIONS
+#define PTRACE_SETOPTIONS 0x4200
+#endif
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
Index: 2.6.10/arch/um/kernel/ptrace.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/ptrace.c	2005-01-09 19:06:08.000000000 -0500
+++ 2.6.10/arch/um/kernel/ptrace.c	2005-01-09 21:59:49.000000000 -0500
@@ -16,6 +16,7 @@
 #include "asm/uaccess.h"
 #include "kern_util.h"
 #include "ptrace_user.h"
+#include "skas_ptrace.h"
 
 /*
  * Called by kernel/ptrace.c when detaching..
Index: 2.6.10/arch/um/kernel/skas/Makefile
===================================================================
--- 2.6.10.orig/arch/um/kernel/skas/Makefile	2005-01-09 19:06:08.000000000 -0500
+++ 2.6.10/arch/um/kernel/skas/Makefile	2005-01-09 19:12:51.000000000 -0500
@@ -6,8 +6,6 @@
 obj-y := exec_kern.o mem.o mem_user.o mmu.o process.o process_kern.o \
 	syscall_kern.o syscall_user.o time.o tlb.o trap_user.o uaccess.o \
 
-subdir-y := util
-
 USER_OBJS = $(filter %_user.o,$(obj-y)) process.o time.o
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 
Index: 2.6.10/arch/um/kernel/skas/include/ptrace-skas.h
===================================================================
--- 2.6.10.orig/arch/um/kernel/skas/include/ptrace-skas.h	2005-01-09 19:06:08.000000000 -0500
+++ 2.6.10/arch/um/kernel/skas/include/ptrace-skas.h	2003-09-15 09:40:47.000000000 -0400
@@ -1,57 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __PTRACE_SKAS_H
-#define __PTRACE_SKAS_H
-
-#include "uml-config.h"
-
-#ifdef UML_CONFIG_MODE_SKAS
-
-#include "skas_ptregs.h"
-
-#define HOST_FRAME_SIZE 17
-
-#define REGS_IP(r) ((r)[HOST_IP])
-#define REGS_SP(r) ((r)[HOST_SP])
-#define REGS_EFLAGS(r) ((r)[HOST_EFLAGS])
-#define REGS_EAX(r) ((r)[HOST_EAX])
-#define REGS_EBX(r) ((r)[HOST_EBX])
-#define REGS_ECX(r) ((r)[HOST_ECX])
-#define REGS_EDX(r) ((r)[HOST_EDX])
-#define REGS_ESI(r) ((r)[HOST_ESI])
-#define REGS_EDI(r) ((r)[HOST_EDI])
-#define REGS_EBP(r) ((r)[HOST_EBP])
-#define REGS_CS(r) ((r)[HOST_CS])
-#define REGS_SS(r) ((r)[HOST_SS])
-#define REGS_DS(r) ((r)[HOST_DS])
-#define REGS_ES(r) ((r)[HOST_ES])
-#define REGS_FS(r) ((r)[HOST_FS])
-#define REGS_GS(r) ((r)[HOST_GS])
-
-#define REGS_SET_SYSCALL_RETURN(r, res) REGS_EAX(r) = (res)
-
-#define REGS_RESTART_SYSCALL(r) IP_RESTART_SYSCALL(REGS_IP(r))
-
-#define REGS_SEGV_IS_FIXABLE(r) SEGV_IS_FIXABLE((r)->trap_type)
-
-#define REGS_FAULT_ADDR(r) ((r)->fault_addr)
-
-#define REGS_FAULT_WRITE(r) FAULT_WRITE((r)->fault_type)
-
-#endif
-
-#endif
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
Index: 2.6.10/arch/um/kernel/skas/util/Makefile
===================================================================
--- 2.6.10.orig/arch/um/kernel/skas/util/Makefile	2005-01-09 19:06:08.000000000 -0500
+++ 2.6.10/arch/um/kernel/skas/util/Makefile	2005-01-09 19:12:51.000000000 -0500
@@ -1,2 +1,4 @@
 hostprogs-y		:= mk_ptregs
 always			:= $(hostprogs-y)
+
+mk_ptregs-objs := mk_ptregs-$(SUBARCH).o
Index: 2.6.10/arch/um/kernel/skas/util/mk_ptregs-i386.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/skas/util/mk_ptregs-i386.c	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/kernel/skas/util/mk_ptregs-i386.c	2005-01-09 19:12:51.000000000 -0500
@@ -0,0 +1,51 @@
+#include <stdio.h>
+#include <asm/ptrace.h>
+#include <asm/user.h>
+
+#define PRINT_REG(name, val) printf("#define HOST_%s %d\n", (name), (val))
+
+int main(int argc, char **argv)
+{
+	printf("/* Automatically generated by "
+	       "arch/um/kernel/skas/util/mk_ptregs */\n");
+	printf("\n");
+	printf("#ifndef __SKAS_PT_REGS_\n");
+	printf("#define __SKAS_PT_REGS_\n");
+	printf("\n");
+	printf("#define HOST_FRAME_SIZE %d\n", FRAME_SIZE);
+	printf("#define HOST_FP_SIZE %d\n", 
+	       sizeof(struct user_i387_struct) / sizeof(unsigned long));
+	printf("#define HOST_XFP_SIZE %d\n", 
+	       sizeof(struct user_fxsr_struct) / sizeof(unsigned long));
+
+	PRINT_REG("IP", EIP);
+	PRINT_REG("SP", UESP);
+	PRINT_REG("EFLAGS", EFL);
+	PRINT_REG("EAX", EAX);
+	PRINT_REG("EBX", EBX);
+	PRINT_REG("ECX", ECX);
+	PRINT_REG("EDX", EDX);
+	PRINT_REG("ESI", ESI);
+	PRINT_REG("EDI", EDI);
+	PRINT_REG("EBP", EBP);
+	PRINT_REG("CS", CS);
+	PRINT_REG("SS", SS);
+	PRINT_REG("DS", DS);
+	PRINT_REG("FS", FS);
+	PRINT_REG("ES", ES);
+	PRINT_REG("GS", GS);
+	printf("\n");
+	printf("#endif\n");
+	return(0);
+}
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
Index: 2.6.10/arch/um/kernel/skas/util/mk_ptregs-x86_64.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/skas/util/mk_ptregs-x86_64.c	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/kernel/skas/util/mk_ptregs-x86_64.c	2005-01-09 19:12:51.000000000 -0500
@@ -0,0 +1,68 @@
+/*
+ * Copyright 2003 PathScale, Inc.
+ *
+ * Licensed under the GPL
+ */
+
+#include <stdio.h>
+#define __FRAME_OFFSETS
+#include <asm/ptrace.h>
+
+#define PRINT_REG(name, val) \
+	printf("#define HOST_%s (%d / sizeof(unsigned long))\n", (name), (val))
+
+int main(int argc, char **argv)
+{
+	printf("/* Automatically generated by "
+	       "arch/um/kernel/skas/util/mk_ptregs */\n");
+	printf("\n");
+	printf("#ifndef __SKAS_PT_REGS_\n");
+	printf("#define __SKAS_PT_REGS_\n");
+	printf("#define HOST_FRAME_SIZE (%d / sizeof(unsigned long))\n",
+	       FRAME_SIZE);
+	PRINT_REG("RBX", RBX);
+	PRINT_REG("RCX", RCX);
+	PRINT_REG("RDI", RDI);
+	PRINT_REG("RSI", RSI);
+	PRINT_REG("RDX", RDX);
+	PRINT_REG("RBP", RBP);
+	PRINT_REG("RAX", RAX);
+	PRINT_REG("R8", R8);
+	PRINT_REG("R9", R9);
+	PRINT_REG("R10", R10);
+	PRINT_REG("R11", R11);
+	PRINT_REG("R12", R12);
+	PRINT_REG("R13", R13);
+	PRINT_REG("R14", R14);
+	PRINT_REG("R15", R15);
+	PRINT_REG("ORIG_RAX", ORIG_RAX);
+	PRINT_REG("CS", CS);
+	PRINT_REG("SS", SS);
+	PRINT_REG("EFLAGS", EFLAGS);
+#if 0	
+	PRINT_REG("FS", FS);
+	PRINT_REG("GS", GS);
+	PRINT_REG("DS", DS);
+	PRINT_REG("ES", ES);
+#endif
+
+	PRINT_REG("IP", RIP);
+	PRINT_REG("SP", RSP);
+	printf("#define HOST_FP_SIZE 0\n");
+	printf("#define HOST_XFP_SIZE 0\n");
+	printf("\n");
+	printf("\n");
+	printf("#endif\n");
+	return(0);
+}
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
Index: 2.6.10/arch/um/kernel/skas/util/mk_ptregs.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/skas/util/mk_ptregs.c	2005-01-09 19:06:08.000000000 -0500
+++ 2.6.10/arch/um/kernel/skas/util/mk_ptregs.c	2003-09-15 09:40:47.000000000 -0400
@@ -1,51 +0,0 @@
-#include <stdio.h>
-#include <asm/ptrace.h>
-#include <asm/user.h>
-
-#define PRINT_REG(name, val) printf("#define HOST_%s %d\n", (name), (val))
-
-int main(int argc, char **argv)
-{
-	printf("/* Automatically generated by "
-	       "arch/um/kernel/skas/util/mk_ptregs */\n");
-	printf("\n");
-	printf("#ifndef __SKAS_PT_REGS_\n");
-	printf("#define __SKAS_PT_REGS_\n");
-	printf("\n");
-	printf("#define HOST_FRAME_SIZE %d\n", FRAME_SIZE);
-	printf("#define HOST_FP_SIZE %d\n", 
-	       sizeof(struct user_i387_struct) / sizeof(unsigned long));
-	printf("#define HOST_XFP_SIZE %d\n", 
-	       sizeof(struct user_fxsr_struct) / sizeof(unsigned long));
-
-	PRINT_REG("IP", EIP);
-	PRINT_REG("SP", UESP);
-	PRINT_REG("EFLAGS", EFL);
-	PRINT_REG("EAX", EAX);
-	PRINT_REG("EBX", EBX);
-	PRINT_REG("ECX", ECX);
-	PRINT_REG("EDX", EDX);
-	PRINT_REG("ESI", ESI);
-	PRINT_REG("EDI", EDI);
-	PRINT_REG("EBP", EBP);
-	PRINT_REG("CS", CS);
-	PRINT_REG("SS", SS);
-	PRINT_REG("DS", DS);
-	PRINT_REG("FS", FS);
-	PRINT_REG("ES", ES);
-	PRINT_REG("GS", GS);
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
Index: 2.6.10/arch/um/kernel/tt/include/ptrace-tt.h
===================================================================
--- 2.6.10.orig/arch/um/kernel/tt/include/ptrace-tt.h	2005-01-09 19:06:08.000000000 -0500
+++ 2.6.10/arch/um/kernel/tt/include/ptrace-tt.h	2003-09-15 09:40:47.000000000 -0400
@@ -1,26 +0,0 @@
-/* 
- * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __PTRACE_TT_H
-#define __PTRACE_TT_H
-
-#include "uml-config.h"
-
-#ifdef UML_CONFIG_MODE_TT
-#include "sysdep/sc.h"
-#endif
-
-#endif
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
Index: 2.6.10/arch/um/sys-i386/ldt.c
===================================================================
--- 2.6.10.orig/arch/um/sys-i386/ldt.c	2005-01-09 19:06:08.000000000 -0500
+++ 2.6.10/arch/um/sys-i386/ldt.c	2005-01-09 21:59:49.000000000 -0500
@@ -25,6 +25,8 @@
 #ifdef CONFIG_MODE_SKAS
 extern int userspace_pid;
 
+#include "skas_ptrace.h"
+
 int sys_modify_ldt_skas(int func, void *ptr, unsigned long bytecount)
 {
 	struct ptrace_ldt ldt;
Index: 2.6.10/arch/um/sys-x86_64/Makefile
===================================================================
--- 2.6.10.orig/arch/um/sys-x86_64/Makefile	2005-01-09 19:09:42.000000000 -0500
+++ 2.6.10/arch/um/sys-x86_64/Makefile	2005-01-09 21:59:49.000000000 -0500
@@ -5,10 +5,10 @@
 #
 
 lib-y = bitops.o bugs.o csum-partial.o fault.o mem.o memcpy.o \
-	ptrace.o semaphore.o sigcontext.o signal.o syscalls.o \
-	sysrq.o thunk.o
+	ptrace.o ptrace_user.o semaphore.o sigcontext.o signal.o \
+	syscalls.o sysrq.o thunk.o
 
-USER_OBJS := sigcontext.o
+USER_OBJS := ptrace_user.o sigcontext.o
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 
 SYMLINKS = bitops.c csum-copy.S csum-partial.c csum-wrappers.c memcpy.S \
Index: 2.6.10/arch/um/sys-x86_64/ptrace.c
===================================================================
--- 2.6.10.orig/arch/um/sys-x86_64/ptrace.c	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/sys-x86_64/ptrace.c	2005-01-09 19:12:51.000000000 -0500
@@ -0,0 +1,138 @@
+/*
+ * Copyright 2003 PathScale, Inc.
+ *
+ * Licensed under the GPL
+ */
+
+#define __FRAME_OFFSETS
+#include "asm/ptrace.h"
+#include "linux/sched.h"
+#include "linux/errno.h"
+#include "asm/elf.h"
+
+/* XXX x86_64 */
+unsigned long not_ss;
+unsigned long not_ds;
+unsigned long not_es;
+
+#define SC_SS(r) (not_ss)
+#define SC_DS(r) (not_ds)
+#define SC_ES(r) (not_es)
+
+/* determines which flags the user has access to. */
+/* 1 = access 0 = no access */
+#define FLAG_MASK 0x44dd5UL
+
+int putreg(struct task_struct *child, int regno, unsigned long value)
+{
+	unsigned long tmp;
+
+#ifdef TIF_IA32
+	/* Some code in the 64bit emulation may not be 64bit clean.
+	   Don't take any chances. */
+	if (test_tsk_thread_flag(child, TIF_IA32))
+		value &= 0xffffffff;
+#endif
+	switch (regno){
+	case FS:
+	case GS:
+	case DS:
+	case ES: 
+	case SS:
+	case CS: 
+		if (value && (value & 3) != 3)
+			return -EIO;
+		value &= 0xffff; 
+		break;
+
+	case FS_BASE:
+	case GS_BASE:
+		if (!((value >> 48) == 0 || (value >> 48) == 0xffff))
+			return -EIO; 
+		break;
+
+	case EFLAGS:
+		value &= FLAG_MASK;
+		tmp = PT_REGS_EFLAGS(&child->thread.regs) & ~FLAG_MASK;
+		value |= tmp;
+		break;
+	}
+
+	PT_REGS_SET(&child->thread.regs, regno, value);
+	return 0;
+}
+
+unsigned long getreg(struct task_struct *child, int regno)
+{
+	unsigned long retval = ~0UL;
+	switch (regno) {
+	case FS:
+	case GS:
+	case DS:
+	case ES:
+	case SS:
+	case CS:
+		retval = 0xffff;
+		/* fall through */
+	default:
+		retval &= PT_REG(&child->thread.regs, regno);
+#ifdef TIF_IA32
+		if (test_tsk_thread_flag(child, TIF_IA32))
+			retval &= 0xffffffff;
+#endif
+	}
+	return retval;
+}
+
+void arch_switch(void)
+{
+/* XXX
+	printk("arch_switch\n");
+*/
+}
+
+int is_syscall(unsigned long addr)
+{
+	panic("is_syscall");
+}
+
+int dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpu )
+{
+	panic("dump_fpu");
+	return(1);
+}
+
+int get_fpregs(unsigned long buf, struct task_struct *child)
+{
+	panic("get_fpregs");
+	return(0);
+}
+
+int set_fpregs(unsigned long buf, struct task_struct *child)
+{
+	panic("set_fpregs");
+	return(0);
+}
+
+int get_fpxregs(unsigned long buf, struct task_struct *tsk)
+{
+	panic("get_fpxregs");
+	return(0);
+}
+
+int set_fpxregs(unsigned long buf, struct task_struct *tsk)
+{
+	panic("set_fxpregs");
+	return(0);
+}
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
Index: 2.6.10/arch/um/sys-x86_64/ptrace_user.c
===================================================================
--- 2.6.10.orig/arch/um/sys-x86_64/ptrace_user.c	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/sys-x86_64/ptrace_user.c	2005-01-09 19:12:51.000000000 -0500
@@ -0,0 +1,64 @@
+/*
+ * Copyright 2003 PathScale, Inc.
+ *
+ * Licensed under the GPL
+ */
+
+#include <stddef.h>
+#include <errno.h>
+#define __FRAME_OFFSETS
+#include <sys/ptrace.h>
+#include <asm/ptrace.h>
+#include "user.h"
+#include "kern_constants.h"
+
+int ptrace_getregs(long pid, unsigned long *regs_out)
+{
+	if(ptrace(PTRACE_GETREGS, pid, 0, regs_out) < 0)
+		return(-errno);
+	return(0);
+}
+
+int ptrace_setregs(long pid, unsigned long *regs)
+{
+	if(ptrace(PTRACE_SETREGS, pid, 0, regs) < 0)
+		return(-errno);
+	return(0);
+}
+
+void ptrace_pokeuser(unsigned long addr, unsigned long data)
+{
+	panic("ptrace_pokeuser");
+}
+
+#define DS 184
+#define ES 192
+#define __USER_DS     0x2b
+
+void arch_enter_kernel(void *task, int pid)
+{
+}
+
+void arch_leave_kernel(void *task, int pid)
+{
+#ifdef UM_USER_CS
+	if(ptrace(PTRACE_POKEUSER, pid, CS, UM_USER_CS) < 0)
+		tracer_panic("POKEUSER CS failed");
+#endif
+
+	if(ptrace(PTRACE_POKEUSER, pid, DS, __USER_DS) < 0)
+		tracer_panic("POKEUSER DS failed");
+	if(ptrace(PTRACE_POKEUSER, pid, ES, __USER_DS) < 0)
+		tracer_panic("POKEUSER ES failed");
+}
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
Index: 2.6.10/include/asm-um/ptrace-generic.h
===================================================================
--- 2.6.10.orig/include/asm-um/ptrace-generic.h	2005-01-09 19:06:08.000000000 -0500
+++ 2.6.10/include/asm-um/ptrace-generic.h	2005-01-09 21:59:49.000000000 -0500
@@ -21,7 +21,6 @@
 #undef instruction_pointer
 
 #include "sysdep/ptrace.h"
-#include "skas_ptrace.h"
 
 struct pt_regs {
 	union uml_pt_regs regs;
Index: 2.6.10/include/asm-um/ptrace-x86_64.h
===================================================================
--- 2.6.10.orig/include/asm-um/ptrace-x86_64.h	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/include/asm-um/ptrace-x86_64.h	2005-01-09 19:12:51.000000000 -0500
@@ -0,0 +1,75 @@
+/*
+ * Copyright 2003 PathScale, Inc.
+ *
+ * Licensed under the GPL
+ */
+
+#ifndef __UM_PTRACE_X86_64_H
+#define __UM_PTRACE_X86_64_H
+
+#include "linux/compiler.h"
+
+#define signal_fault signal_fault_x86_64
+#define __FRAME_OFFSETS /* Needed to get the R* macros */
+#include "asm/ptrace-generic.h"
+#undef signal_fault
+
+void signal_fault(struct pt_regs_subarch *regs, void *frame, char *where);
+
+#define FS_BASE (21 * sizeof(unsigned long))
+#define GS_BASE (22 * sizeof(unsigned long))
+#define DS (23 * sizeof(unsigned long))
+#define ES (24 * sizeof(unsigned long))
+#define FS (25 * sizeof(unsigned long))
+#define GS (26 * sizeof(unsigned long))
+
+#define PT_REGS_RBX(r) UPT_RBX(&(r)->regs)
+#define PT_REGS_RCX(r) UPT_RCX(&(r)->regs)
+#define PT_REGS_RDX(r) UPT_RDX(&(r)->regs)
+#define PT_REGS_RSI(r) UPT_RSI(&(r)->regs)
+#define PT_REGS_RDI(r) UPT_RDI(&(r)->regs)
+#define PT_REGS_RBP(r) UPT_RBP(&(r)->regs)
+#define PT_REGS_RAX(r) UPT_RAX(&(r)->regs)
+#define PT_REGS_R8(r) UPT_R8(&(r)->regs)
+#define PT_REGS_R9(r) UPT_R9(&(r)->regs)
+#define PT_REGS_R10(r) UPT_R10(&(r)->regs)
+#define PT_REGS_R11(r) UPT_R11(&(r)->regs)
+#define PT_REGS_R12(r) UPT_R12(&(r)->regs)
+#define PT_REGS_R13(r) UPT_R13(&(r)->regs)
+#define PT_REGS_R14(r) UPT_R14(&(r)->regs)
+#define PT_REGS_R15(r) UPT_R15(&(r)->regs)
+
+#define PT_REGS_FS(r) UPT_FS(&(r)->regs)
+#define PT_REGS_GS(r) UPT_GS(&(r)->regs)
+#define PT_REGS_DS(r) UPT_DS(&(r)->regs)
+#define PT_REGS_ES(r) UPT_ES(&(r)->regs)
+#define PT_REGS_SS(r) UPT_SS(&(r)->regs)
+#define PT_REGS_CS(r) UPT_CS(&(r)->regs)
+
+#define PT_REGS_ORIG_RAX(r) UPT_ORIG_RAX(&(r)->regs)
+#define PT_REGS_RIP(r) UPT_IP(&(r)->regs)
+#define PT_REGS_RSP(r) UPT_SP(&(r)->regs)
+
+#define PT_REGS_EFLAGS(r) UPT_EFLAGS(&(r)->regs)
+
+/* XXX */
+#define user_mode(r) UPT_IS_USER(&(r)->regs)
+#define PT_REGS_ORIG_SYSCALL(r) PT_REGS_RAX(r)
+#define PT_REGS_SYSCALL_RET(r) PT_REGS_RAX(r)
+
+#define PT_FIX_EXEC_STACK(sp) do ; while(0)
+
+#define profile_pc(regs) PT_REGS_IP(regs)
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

