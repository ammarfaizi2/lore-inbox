Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbVAJFlC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVAJFlC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 00:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbVAJFj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 00:39:59 -0500
Received: from pool-151-203-193-191.bos.east.verizon.net ([151.203.193.191]:22020
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262098AbVAJFOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 00:14:19 -0500
Message-Id: <200501100735.j0A7ZfPW005790@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 12/28] UML - x86-64 headers
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jan 2005 02:35:41 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a bunch of headers to include/asm-um to support x86_64.
Also move some arch-specific things from generic files to x86-specific ones.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.10/include/asm-um/archparam-i386.h
===================================================================
--- 2.6.10.orig/include/asm-um/archparam-i386.h	2005-01-02 20:49:59.000000000 -0500
+++ 2.6.10/include/asm-um/archparam-i386.h	2005-01-02 20:51:36.000000000 -0500
@@ -66,6 +66,13 @@
 #define VSYSCALL_END vsyscall_end
 
 /*
+ * This is the range that is readable by user mode, and things
+ * acting like user mode such as get_user_pages.
+ */
+#define FIXADDR_USER_START      VSYSCALL_BASE
+#define FIXADDR_USER_END        VSYSCALL_END
+
+/*
  * Architecture-neutral AT_ values in 0-17, leave some room
  * for more of them, start the x86-specific ones at 32.
  */
Index: 2.6.10/include/asm-um/archparam-x86_64.h
===================================================================
--- 2.6.10.orig/include/asm-um/archparam-x86_64.h	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/include/asm-um/archparam-x86_64.h	2005-01-02 20:51:36.000000000 -0500
@@ -0,0 +1,62 @@
+/*
+ * Copyright 2003 PathScale, Inc.
+ *
+ * Licensed under the GPL
+ */
+
+#ifndef __UM_ARCHPARAM_X86_64_H
+#define __UM_ARCHPARAM_X86_64_H
+
+#include <asm/user.h>
+
+#define ELF_PLATFORM "x86_64"
+
+#define ELF_ET_DYN_BASE (2 * TASK_SIZE / 3)
+
+typedef unsigned long elf_greg_t;
+typedef struct { } elf_fpregset_t;
+
+#define ELF_NGREG (sizeof (struct user_regs_struct) / sizeof(elf_greg_t))
+typedef elf_greg_t elf_gregset_t[ELF_NGREG];
+
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
+        clear_thread_flag(TIF_IA32);
+#endif
+
+/* No user-accessible fixmap addresses, i.e. vsyscall */
+#define FIXADDR_USER_START	0
+#define FIXADDR_USER_END	0
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
Index: 2.6.10/include/asm-um/calling.h
===================================================================
--- 2.6.10.orig/include/asm-um/calling.h	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/include/asm-um/calling.h	2005-01-02 20:46:01.000000000 -0500
@@ -0,0 +1,9 @@
+# Copyright 2003 - 2004 Pathscale, Inc
+# Released under the GPL
+
+#ifndef __UM_CALLING_H /* XXX x86_64 */
+#define __UM_CALLING_H
+
+#include "asm/arch/calling.h"
+
+#endif
Index: 2.6.10/include/asm-um/dwarf2.h
===================================================================
--- 2.6.10.orig/include/asm-um/dwarf2.h	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/include/asm-um/dwarf2.h	2005-01-02 20:46:01.000000000 -0500
@@ -0,0 +1,11 @@
+/* Copyright 2003 - 2004 Pathscale, Inc
+ * Released under the GPL
+ */
+
+/* Needed on x86_64 by thunk.S */
+#ifndef __UM_DWARF2_H
+#define __UM_DWARF2_H
+
+#include "asm/arch/dwarf2.h"
+
+#endif
Index: 2.6.10/include/asm-um/elf.h
===================================================================
--- 2.6.10.orig/include/asm-um/elf.h	2005-01-02 20:45:21.000000000 -0500
+++ 2.6.10/include/asm-um/elf.h	2005-01-02 20:46:01.000000000 -0500
@@ -1,6 +1,7 @@
 #ifndef __UM_ELF_H
 #define __UM_ELF_H
 
+#include "linux/config.h"
 #include "asm/archparam.h"
 
 extern long elf_aux_hwcap;
@@ -12,7 +13,11 @@
 
 #define elf_check_arch(x) (1)
 
+#ifdef CONFIG_64_BIT
+#define ELF_CLASS ELFCLASS64
+#else
 #define ELF_CLASS ELFCLASS32
+#endif
 
 #define USE_ELF_CORE_DUMP
 
Index: 2.6.10/include/asm-um/fixmap.h
===================================================================
--- 2.6.10.orig/include/asm-um/fixmap.h	2005-01-02 20:49:59.000000000 -0500
+++ 2.6.10/include/asm-um/fixmap.h	2005-01-02 20:51:36.000000000 -0500
@@ -64,13 +64,6 @@
 #define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
 #define __virt_to_fix(x)      ((FIXADDR_TOP - ((x)&PAGE_MASK)) >> PAGE_SHIFT)
 
-/*
- * This is the range that is readable by user mode, and things
- * acting like user mode such as get_user_pages.
- */
-#define FIXADDR_USER_START	VSYSCALL_BASE
-#define FIXADDR_USER_END	VSYSCALL_END
-
 extern void __this_fixmap_does_not_exist(void);
 
 /*

