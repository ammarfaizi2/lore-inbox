Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030558AbWJCXA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030558AbWJCXA6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 19:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030657AbWJCXA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 19:00:57 -0400
Received: from [198.99.130.12] ([198.99.130.12]:38810 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1030558AbWJCXA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 19:00:56 -0400
Message-Id: <200610032256.k93MulSV006888@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH] UML - add generic BUG support
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Oct 2006 18:56:46 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The BUG changes in -mm3 need some arch support.  This patch adds the UML 
support needed.  For the most part, it was stolen from the underlying 
architecture.  The exception is the kernel eip < PAGE_OFFSET test, which is 
wrong for skas mode UMLs.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
---
 arch/um/Kconfig             |    5 +++++
 arch/um/sys-i386/Makefile   |    2 +-
 arch/um/sys-i386/bug.c      |   20 ++++++++++++++++++++
 arch/um/sys-x86_64/Makefile |    2 +-
 arch/um/sys-x86_64/bug.c    |   20 ++++++++++++++++++++
 include/asm-um/bug.h        |    4 +++-
 6 files changed, 50 insertions(+), 3 deletions(-)

Index: linux-2.6.18-mm/arch/um/Kconfig
===================================================================
--- linux-2.6.18-mm.orig/arch/um/Kconfig	2006-10-03 12:46:44.000000000 -0400
+++ linux-2.6.18-mm/arch/um/Kconfig	2006-10-03 17:44:32.000000000 -0400
@@ -29,6 +29,11 @@ config GENERIC_CALIBRATE_DELAY
 	bool
 	default y
 
+config GENERIC_BUG
+	bool
+	default y
+	depends on BUG
+
 # Used in kernel/irq/manage.c and include/linux/irq.h
 config IRQ_RELEASE_METHOD
 	bool
Index: linux-2.6.18-mm/include/asm-um/bug.h
===================================================================
--- linux-2.6.18-mm.orig/include/asm-um/bug.h	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.18-mm/include/asm-um/bug.h	2006-10-03 13:29:28.000000000 -0400
@@ -1,4 +1,6 @@
 #ifndef __UM_BUG_H
 #define __UM_BUG_H
-#include <asm-generic/bug.h>
+
+#include <asm/arch/bug.h>
+
 #endif
Index: linux-2.6.18-mm/arch/um/sys-i386/Makefile
===================================================================
--- linux-2.6.18-mm.orig/arch/um/sys-i386/Makefile	2006-10-03 12:53:13.000000000 -0400
+++ linux-2.6.18-mm/arch/um/sys-i386/Makefile	2006-10-03 17:44:32.000000000 -0400
@@ -1,4 +1,4 @@
-obj-y = bugs.o checksum.o delay.o fault.o ksyms.o ldt.o ptrace.o \
+obj-y = bug.o bugs.o checksum.o delay.o fault.o ksyms.o ldt.o ptrace.o \
 	ptrace_user.o setjmp.o signal.o sigcontext.o syscalls.o sysrq.o \
 	sys_call_table.o tls.o
 
Index: linux-2.6.18-mm/arch/um/sys-i386/bug.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-mm/arch/um/sys-i386/bug.c	2006-10-03 13:45:39.000000000 -0400
@@ -0,0 +1,20 @@
+/*
+ * Copyright (C) 2006 Jeff Dike (jdike@addtoit.com)
+ * Licensed under the GPL V2
+ */
+
+#include <linux/uaccess.h>
+
+/* Mostly copied from i386/x86_86 - eliminated the eip < PAGE_OFFSET because
+ * that's not relevent in skas mode.
+ */
+
+int is_valid_bugaddr(unsigned long eip)
+{
+	unsigned short ud2;
+
+	if (probe_kernel_address((unsigned short __user *)eip, ud2))
+		return 0;
+
+	return ud2 == 0x0b0f;
+}
Index: linux-2.6.18-mm/arch/um/sys-x86_64/Makefile
===================================================================
--- linux-2.6.18-mm.orig/arch/um/sys-x86_64/Makefile	2006-10-03 12:53:13.000000000 -0400
+++ linux-2.6.18-mm/arch/um/sys-x86_64/Makefile	2006-10-03 17:44:32.000000000 -0400
@@ -4,7 +4,7 @@
 # Licensed under the GPL
 #
 
-obj-y = bugs.o delay.o fault.o ldt.o mem.o ptrace.o ptrace_user.o \
+obj-y = bug.o bugs.o delay.o fault.o ldt.o mem.o ptrace.o ptrace_user.o \
 	setjmp.o sigcontext.o signal.o syscalls.o syscall_table.o sysrq.o \
 	ksyms.o tls.o
 
Index: linux-2.6.18-mm/arch/um/sys-x86_64/bug.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-mm/arch/um/sys-x86_64/bug.c	2006-10-03 13:45:53.000000000 -0400
@@ -0,0 +1,20 @@
+/*
+ * Copyright (C) 2006 Jeff Dike (jdike@addtoit.com)
+ * Licensed under the GPL V2
+ */
+
+#include <linux/uaccess.h>
+
+/* Mostly copied from i386/x86_86 - eliminated the eip < PAGE_OFFSET because
+ * that's not relevent in skas mode.
+ */
+
+int is_valid_bugaddr(unsigned long eip)
+{
+	unsigned short ud2;
+
+	if (probe_kernel_address((unsigned short __user *)eip, ud2))
+		return 0;
+
+	return ud2 == 0x0b0f;
+}

