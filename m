Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbWAIDTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWAIDTW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 22:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbWAIDS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 22:18:59 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:42949 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751049AbWAIDSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 22:18:55 -0500
Message-Id: <200601090410.k094AmWb001179@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/6] UML - Fix missing KBUILD_BASENAME
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 08 Jan 2006 23:10:47 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.15-mm1 caused kernel-offsets.c to stop compiling with a syntax 
error in a header.  The problem was with KBUILD_BASENAME, which didn't 
get a definition with the by-hand compilation in the main UML Makefile.
This was OK before since the expansion was syntactically the same as the
KBUILD_BASENAME token.  With -mm1, the expansion is now a quote-delimited 
string, so there needs to be a definition of it.
Since kernel-offsets.c is basically the same as other arches'
asm-offsets.c, and those seem to build OK, this patch turns
kernel-offsets.c into asm-offsets.c.
kernel-offsets.c is in arch/um/sys-$(SUBARCH), i.e. sys-i386 and
sys-x86_64, while kbuild expects it to be in arch/um/kernel.
kernel-offsets.c is moved to
arch/um/include/sysdep-$(SUBARCH)/kernel-offsets.h, which is
included by arch/um/kernel/asm-offsets.c.  With that,
include/asm-um/asm-offsets.h is generated automatically.
kernel-offsets.h continues to exist because it needs to be
accessible to userspace UML code, and include/asm-um isn't.  So, a
symlink is made from arch/um/include/kernel-offsets.h to
include/asm-um/asm-offsets.h.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/Makefile
===================================================================
--- linux-2.6.15-mm.orig/arch/um/Makefile	2006-01-07 21:38:10.000000000 -0500
+++ linux-2.6.15-mm/arch/um/Makefile	2006-01-08 22:14:47.000000000 -0500
@@ -189,6 +189,12 @@ define filechk_umlconfig
 	sed 's/ CONFIG/ UML_CONFIG/'
 endef
 
+$(ARCH_DIR)/include/uml-config.h : include/linux/autoconf.h
+	$(call filechk,umlconfig)
+
+$(ARCH_DIR)/user-offsets.s: $(ARCH_DIR)/sys-$(SUBARCH)/user-offsets.c
+	$(CC) $(USER_CFLAGS) -S -o $@ $<
+
 define filechk_gen-asm-offsets
         (set -e; \
          echo "/*"; \
@@ -202,24 +208,13 @@ define filechk_gen-asm-offsets
          echo ""; )
 endef
 
-$(ARCH_DIR)/include/uml-config.h : include/linux/autoconf.h
-	$(call filechk,umlconfig)
-
-$(ARCH_DIR)/user-offsets.s: $(ARCH_DIR)/sys-$(SUBARCH)/user-offsets.c
-	$(CC) $(USER_CFLAGS) -S -o $@ $<
-
 $(ARCH_DIR)/include/user_constants.h: $(ARCH_DIR)/user-offsets.s
 	$(call filechk,gen-asm-offsets)
 
 CLEAN_FILES += $(ARCH_DIR)/user-offsets.s
 
-$(ARCH_DIR)/kernel-offsets.s: $(ARCH_DIR)/sys-$(SUBARCH)/kernel-offsets.c \
-				   archprepare
-	$(CC) $(CFLAGS) $(NOSTDINC_FLAGS) $(CPPFLAGS) -S -o $@ $<
-
-$(ARCH_DIR)/include/kern_constants.h: $(ARCH_DIR)/kernel-offsets.s
-	$(call filechk,gen-asm-offsets)
-
-CLEAN_FILES += $(ARCH_DIR)/kernel-offsets.s
+$(ARCH_DIR)/include/kern_constants.h:
+	@echo '  SYMLINK $@'
+	$(Q) ln -sf ../../../include/asm-um/asm-offsets.h $@
 
 export SUBARCH USER_CFLAGS OS
Index: linux-2.6.15-mm/arch/um/include/sysdep-i386/kernel-offsets.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-mm/arch/um/include/sysdep-i386/kernel-offsets.h	2006-01-08 22:16:51.000000000 -0500
@@ -0,0 +1,23 @@
+#include <linux/stddef.h>
+#include <linux/sched.h>
+#include <linux/elf.h>
+
+#define DEFINE(sym, val) \
+	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
+
+#define STR(x) #x
+#define DEFINE_STR(sym, val) asm volatile("\n->" #sym " " STR(val) " " #val: : )
+
+#define BLANK() asm volatile("\n->" : : )
+
+#define OFFSET(sym, str, mem) \
+	DEFINE(sym, offsetof(struct str, mem));
+
+void foo(void)
+{
+	OFFSET(HOST_TASK_DEBUGREGS, task_struct, thread.arch.debugregs);
+#ifdef CONFIG_MODE_TT
+	OFFSET(HOST_TASK_EXTERN_PID, task_struct, thread.mode.tt.extern_pid);
+#endif
+#include <common-offsets.h>
+}
Index: linux-2.6.15-mm/arch/um/include/sysdep-x86_64/kernel-offsets.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-mm/arch/um/include/sysdep-x86_64/kernel-offsets.h	2006-01-08 22:15:19.000000000 -0500
@@ -0,0 +1,25 @@
+#include <linux/config.h>
+#include <linux/stddef.h>
+#include <linux/sched.h>
+#include <linux/time.h>
+#include <linux/elf.h>
+#include <asm/page.h>
+
+#define DEFINE(sym, val) \
+	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
+
+#define DEFINE_STR1(x) #x
+#define DEFINE_STR(sym, val) asm volatile("\n->" #sym " " DEFINE_STR1(val) " " #val: : )
+
+#define BLANK() asm volatile("\n->" : : )
+
+#define OFFSET(sym, str, mem) \
+	DEFINE(sym, offsetof(struct str, mem));
+
+void foo(void)
+{
+#ifdef CONFIG_MODE_TT
+	OFFSET(HOST_TASK_EXTERN_PID, task_struct, thread.mode.tt.extern_pid);
+#endif
+#include <common-offsets.h>
+}
Index: linux-2.6.15-mm/arch/um/kernel/asm-offsets.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/asm-offsets.c	2006-01-07 21:38:10.000000000 -0500
+++ linux-2.6.15-mm/arch/um/kernel/asm-offsets.c	2006-01-07 21:38:30.000000000 -0500
@@ -1 +1 @@
-/* Dummy file to make kbuild happy - unused! */
+#include "sysdep/kernel-offsets.h"
Index: linux-2.6.15-mm/arch/um/sys-i386/kernel-offsets.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/sys-i386/kernel-offsets.c	2006-01-07 21:38:10.000000000 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,26 +0,0 @@
-#include <linux/config.h>
-#include <linux/stddef.h>
-#include <linux/sched.h>
-#include <linux/time.h>
-#include <linux/elf.h>
-#include <asm/page.h>
-
-#define DEFINE(sym, val) \
-        asm volatile("\n->" #sym " %0 " #val : : "i" (val))
-
-#define STR(x) #x
-#define DEFINE_STR(sym, val) asm volatile("\n->" #sym " " STR(val) " " #val: : )
-
-#define BLANK() asm volatile("\n->" : : )
-
-#define OFFSET(sym, str, mem) \
-	DEFINE(sym, offsetof(struct str, mem));
-
-void foo(void)
-{
-	OFFSET(HOST_TASK_DEBUGREGS, task_struct, thread.arch.debugregs);
-#ifdef CONFIG_MODE_TT
-	OFFSET(HOST_TASK_EXTERN_PID, task_struct, thread.mode.tt.extern_pid);
-#endif
-#include <common-offsets.h>
-}
Index: linux-2.6.15-mm/arch/um/sys-x86_64/kernel-offsets.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/sys-x86_64/kernel-offsets.c	2006-01-07 21:38:10.000000000 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,25 +0,0 @@
-#include <linux/config.h>
-#include <linux/stddef.h>
-#include <linux/sched.h>
-#include <linux/time.h>
-#include <linux/elf.h>
-#include <asm/page.h>
-
-#define DEFINE(sym, val) \
-        asm volatile("\n->" #sym " %0 " #val : : "i" (val))
-
-#define DEFINE_STR1(x) #x
-#define DEFINE_STR(sym, val) asm volatile("\n->" #sym " " DEFINE_STR1(val) " " #val: : )
-
-#define BLANK() asm volatile("\n->" : : )
-
-#define OFFSET(sym, str, mem) \
-	DEFINE(sym, offsetof(struct str, mem));
-
-void foo(void)
-{
-#ifdef CONFIG_MODE_TT
-	OFFSET(HOST_TASK_EXTERN_PID, task_struct, thread.mode.tt.extern_pid);
-#endif
-#include <common-offsets.h>
-}

