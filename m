Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbVAJGVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbVAJGVE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 01:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVAJFjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 00:39:23 -0500
Received: from pool-151-203-193-191.bos.east.verizon.net ([151.203.193.191]:20996
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262096AbVAJFOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 00:14:18 -0500
Message-Id: <200501100735.j0A7ZbPW005785@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 11/28] UML - Separate out the time code
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jan 2005 02:35:37 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the i386 __delay to sys-i386 and add an implementation for x86_64.
Also get rid of the definition of um_udelay_t.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.10/arch/um/kernel/time_kern.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/time_kern.c	2005-01-02 22:03:40.000000000 -0500
+++ 2.6.10/arch/um/kernel/time_kern.c	2005-01-02 22:09:23.000000000 -0500
@@ -136,22 +136,7 @@
 	return 0;
 }
 
-/* XXX Needs to be moved under sys-i386 */
-void __delay(um_udelay_t time)
-{
-	/* Stolen from the i386 __loop_delay */
-	int d0;
-	__asm__ __volatile__(
-		"\tjmp 1f\n"
-		".align 16\n"
-		"1:\tjmp 2f\n"
-		".align 16\n"
-		"2:\tdecl %0\n\tjns 2b"
-		:"=&a" (d0)
-		:"0" (time));
-}
-
-void __udelay(um_udelay_t usecs)
+void __udelay(unsigned long usecs)
 {
 	int i, n;
 
@@ -159,7 +144,7 @@
 	for(i=0;i<n;i++) ;
 }
 
-void __const_udelay(um_udelay_t usecs)
+void __const_udelay(unsigned long usecs)
 {
 	int i, n;
 
Index: 2.6.10/arch/um/sys-i386/Makefile
===================================================================
--- 2.6.10.orig/arch/um/sys-i386/Makefile	2005-01-02 22:03:40.000000000 -0500
+++ 2.6.10/arch/um/sys-i386/Makefile	2005-01-02 22:09:23.000000000 -0500
@@ -1,4 +1,4 @@
-obj-y = bitops.o bugs.o checksum.o fault.o ksyms.o ldt.o ptrace.o \
+obj-y = bitops.o bugs.o checksum.o delay.o fault.o ksyms.o ldt.o ptrace.o \
 	ptrace_user.o semaphore.o signal.o sigcontext.o syscalls.o sysrq.o
 
 obj-$(CONFIG_HIGHMEM) += highmem.o
Index: 2.6.10/arch/um/sys-i386/delay.c
===================================================================
--- 2.6.10.orig/arch/um/sys-i386/delay.c	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/sys-i386/delay.c	2005-01-02 22:09:23.000000000 -0500
@@ -0,0 +1,14 @@
+void __delay(unsigned long time)
+{
+	/* Stolen from the i386 __loop_delay */
+	int d0;
+	__asm__ __volatile__(
+		"\tjmp 1f\n"
+		".align 16\n"
+		"1:\tjmp 2f\n"
+		".align 16\n"
+		"2:\tdecl %0\n\tjns 2b"
+		:"=&a" (d0)
+		:"0" (time));
+}
+
Index: 2.6.10/arch/um/sys-x86_64/Makefile
===================================================================
--- 2.6.10.orig/arch/um/sys-x86_64/Makefile	2005-01-02 22:09:15.000000000 -0500
+++ 2.6.10/arch/um/sys-x86_64/Makefile	2005-01-02 22:09:39.000000000 -0500
@@ -4,7 +4,7 @@
 # Licensed under the GPL
 #
 
-lib-y = bitops.o bugs.o csum-partial.o fault.o mem.o memcpy.o \
+lib-y = bitops.o bugs.o csum-partial.o delay.o fault.o mem.o memcpy.o \
 	ptrace.o ptrace_user.o semaphore.o sigcontext.o signal.o \
 	syscalls.o sysrq.o thunk.o
 
Index: 2.6.10/arch/um/sys-x86_64/delay.c
===================================================================
--- 2.6.10.orig/arch/um/sys-x86_64/delay.c	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/sys-x86_64/delay.c	2005-01-02 22:09:23.000000000 -0500
@@ -0,0 +1,26 @@
+/*
+ * Copyright 2003 PathScale, Inc.
+ * Copied from arch/x86_64
+ *
+ * Licensed under the GPL
+ */
+
+#include "asm/processor.h"
+
+void __delay(unsigned long loops)
+{
+	unsigned long i;
+
+	for(i = 0; i < loops; i++) ;
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
Index: 2.6.10/include/asm-um/archparam-i386.h
===================================================================
--- 2.6.10.orig/include/asm-um/archparam-i386.h	2005-01-02 22:03:40.000000000 -0500
+++ 2.6.10/include/asm-um/archparam-i386.h	2005-01-02 22:09:23.000000000 -0500
@@ -136,10 +136,6 @@
 #define R_386_GOTPC	10
 #define R_386_NUM	11
 
-/********* Bits for asm-um/delay.h **********/
-
-typedef unsigned long um_udelay_t;
-
 /********* Nothing for asm-um/hardirq.h **********/
 
 /********* Nothing for asm-um/hw_irq.h **********/
Index: 2.6.10/include/asm-um/archparam-ppc.h
===================================================================
--- 2.6.10.orig/include/asm-um/archparam-ppc.h	2005-01-02 22:03:40.000000000 -0500
+++ 2.6.10/include/asm-um/archparam-ppc.h	2005-01-02 22:09:23.000000000 -0500
@@ -21,10 +21,6 @@
 #define ELF_DATA        ELFDATA2MSB
 #define ELF_ARCH	EM_PPC
 
-/********* Bits for asm-um/delay.h **********/
-
-typedef unsigned int um_udelay_t;
-
 /********* Bits for asm-um/hw_irq.h **********/
 
 struct hw_interrupt_type;

