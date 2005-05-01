Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262687AbVEAVYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbVEAVYt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 17:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbVEAVWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 17:22:43 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:26643 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262691AbVEAVSb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 17:18:31 -0400
Message-Id: <200505012112.j41LCPwY016407@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: [PATCH 5/22] UML - Cross-build support : kernel_offsets
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 01 May 2005 17:12:25 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Al Viro:

	The next group of helpers is a bit trickier - they want the constants
similar to those in user-offsets.h, but we need target sc.h for it.  So we
can't put that into user-offsets (sc.h depends on it) and need the second
generated header for that stuff (kernel-offsets.h.  BFD...

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

diff -urN RC12-rc3-uml-sc/arch/um/Makefile RC12-rc3-uml-kernel-offsets/arch/um/Makefile
--- RC12-rc3-uml-sc/arch/um/Makefile	Wed Apr 27 18:22:28 2005
+++ RC12-rc3-uml-kernel-offsets/arch/um/Makefile	Wed Apr 27 18:18:08 2005
@@ -174,6 +174,19 @@
 
 CLEAN_FILES += $(ARCH_DIR)/user-offsets.s  $(ARCH_DIR)/user-offsets.h 
 
+$(ARCH_DIR)/kernel-offsets.s: $(ARCH_DIR)/sys-$(SUBARCH)/kernel-offsets.c \
+				   $(ARCH_SYMLINKS) \
+				   $(SYS_DIR)/sc.h \
+				   include/asm include/linux/version.h \
+				   include/config/MARKER \
+				   $(ARCH_DIR)/include/user_constants.h
+	$(CC) $(CFLAGS) $(NOSTDINC_FLAGS) $(CPPFLAGS) -S -o $@ $<
+
+$(ARCH_DIR)/kernel-offsets.h: $(ARCH_DIR)/kernel-offsets.s
+	$(call filechk,gen-asm-offsets)
+
+CLEAN_FILES += $(ARCH_DIR)/kernel-offsets.s  $(ARCH_DIR)/kernel-offsets.h 
+
 $(ARCH_DIR)/include/task.h: $(ARCH_DIR)/util/mk_task
 	$(call filechk,gen_header)
 
diff -urN RC12-rc3-uml-sc/arch/um/include/common-offsets.h RC12-rc3-uml-kernel-offsets/arch/um/include/common-offsets.h
--- RC12-rc3-uml-sc/arch/um/include/common-offsets.h	Wed Dec 31 19:00:00 1969
+++ RC12-rc3-uml-kernel-offsets/arch/um/include/common-offsets.h	Wed Apr 27 17:07:28 2005
@@ -0,0 +1,14 @@
+/* for use by sys-$SUBARCH/kernel-offsets.c */
+
+OFFSET(TASK_REGS, task_struct, thread.regs);
+OFFSET(TASK_PID, task_struct, pid);
+DEFINE(UM_KERN_PAGE_SIZE, PAGE_SIZE);
+DEFINE(UM_NSEC_PER_SEC, NSEC_PER_SEC);
+DEFINE_STR(UM_KERN_EMERG, KERN_EMERG);
+DEFINE_STR(UM_KERN_ALERT, KERN_ALERT);
+DEFINE_STR(UM_KERN_CRIT, KERN_CRIT);
+DEFINE_STR(UM_KERN_ERR, KERN_ERR);
+DEFINE_STR(UM_KERN_WARNING, KERN_WARNING);
+DEFINE_STR(UM_KERN_NOTICE, KERN_NOTICE);
+DEFINE_STR(UM_KERN_INFO, KERN_INFO);
+DEFINE_STR(UM_KERN_DEBUG, KERN_DEBUG);
diff -urN RC12-rc3-uml-sc/arch/um/sys-i386/kernel-offsets.c RC12-rc3-uml-kernel-offsets/arch/um/sys-i386/kernel-offsets.c
--- RC12-rc3-uml-sc/arch/um/sys-i386/kernel-offsets.c	Wed Dec 31 19:00:00 1969
+++ RC12-rc3-uml-kernel-offsets/arch/um/sys-i386/kernel-offsets.c	Wed Apr 27 17:07:28 2005
@@ -0,0 +1,25 @@
+#include <linux/config.h>
+#include <linux/stddef.h>
+#include <linux/sched.h>
+#include <linux/time.h>
+#include <asm/page.h>
+
+#define DEFINE(sym, val) \
+        asm volatile("\n->" #sym " %0 " #val : : "i" (val))
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
+	OFFSET(TASK_DEBUGREGS, task_struct, thread.arch.debugregs);
+#ifdef CONFIG_MODE_TT
+	OFFSET(TASK_EXTERN_PID, task_struct, thread.mode.tt.extern_pid);
+#endif
+#include <common-offsets.h>
+}
diff -urN RC12-rc3-uml-sc/arch/um/sys-x86_64/kernel-offsets.c RC12-rc3-uml-kernel-offsets/arch/um/sys-x86_64/kernel-offsets.c
--- RC12-rc3-uml-sc/arch/um/sys-x86_64/kernel-offsets.c	Wed Dec 31 19:00:00 1969
+++ RC12-rc3-uml-kernel-offsets/arch/um/sys-x86_64/kernel-offsets.c	Wed Apr 27 17:07:28 2005
@@ -0,0 +1,24 @@
+#include <linux/config.h>
+#include <linux/stddef.h>
+#include <linux/sched.h>
+#include <linux/time.h>
+#include <asm/page.h>
+
+#define DEFINE(sym, val) \
+        asm volatile("\n->" #sym " %0 " #val : : "i" (val))
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
+	OFFSET(TASK_EXTERN_PID, task_struct, thread.mode.tt.extern_pid);
+#endif
+#include <common-offsets.h>
+}

