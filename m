Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262094AbVAJFc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbVAJFc3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 00:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVAJFc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 00:32:28 -0500
Received: from pool-151-203-193-191.bos.east.verizon.net ([151.203.193.191]:20228
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262094AbVAJFOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 00:14:17 -0500
Message-Id: <200501100735.j0A7ZVPW005775@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 9/28] UML - Separate out signal reception
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jan 2005 02:35:31 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves most of the signal handlers to os-Linux, adds an
arch-specific mechanism to get the address of the sigcontext structure,
and implements it for i386 and x86_64.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.10/arch/um/include/sysdep-i386/signal.h
===================================================================
--- 2.6.10.orig/arch/um/include/sysdep-i386/signal.h	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/include/sysdep-i386/signal.h	2005-01-02 22:09:20.000000000 -0500
@@ -0,0 +1,25 @@
+/* 
+ * Copyright (C) 2004 PathScale, Inc
+ * Licensed under the GPL
+ */
+
+#ifndef __I386_SIGNAL_H_
+#define __I386_SIGNAL_H_
+
+#include <signal.h>
+
+#define ARCH_GET_SIGCONTEXT(sc, sig) \
+	do sc = (struct sigcontext *) (&sig + 1); while(0)
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
Index: 2.6.10/arch/um/include/sysdep-x86_64/signal.h
===================================================================
--- 2.6.10.orig/arch/um/include/sysdep-x86_64/signal.h	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/include/sysdep-x86_64/signal.h	2005-01-03 15:38:16.000000000 -0500
@@ -0,0 +1,27 @@
+/* 
+ * Copyright (C) 2004 PathScale, Inc
+ * Licensed under the GPL
+ */
+
+#ifndef __X86_64_SIGNAL_H_
+#define __X86_64_SIGNAL_H_
+
+#define ARCH_GET_SIGCONTEXT(sc, sig_addr) \
+	do { \
+		struct ucontext *__uc; \
+		asm("movq %%rdx, %0" : "=r" (__uc)); \
+		sc = (struct sigcontext *) &__uc->uc_mcontext; \
+	} while(0)
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
Index: 2.6.10/arch/um/kernel/trap_user.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/trap_user.c	2005-01-02 22:03:40.000000000 -0500
+++ 2.6.10/arch/um/kernel/trap_user.c	2005-01-03 15:38:05.000000000 -0500
@@ -102,28 +102,6 @@
 		      .is_irq 		= 0 },
 };
 
-void sig_handler(int sig, struct sigcontext sc)
-{
-	CHOOSE_MODE_PROC(sig_handler_common_tt, sig_handler_common_skas,
-			 sig, &sc);
-}
-
-extern int timer_irq_inited;
-
-void alarm_handler(int sig, struct sigcontext sc)
-{
-	if(!timer_irq_inited) return;
-
-	if(sig == SIGALRM)
-		switch_timers(0);
-
-	CHOOSE_MODE_PROC(sig_handler_common_tt, sig_handler_common_skas,
-			 sig, &sc);
-
-	if(sig == SIGALRM)
-		switch_timers(1);
-}
-
 void do_longjmp(void *b, int val)
 {
 	sigjmp_buf *buf = b;
Index: 2.6.10/arch/um/os-Linux/Makefile
===================================================================
--- 2.6.10.orig/arch/um/os-Linux/Makefile	2005-01-02 22:08:16.000000000 -0500
+++ 2.6.10/arch/um/os-Linux/Makefile	2005-01-03 15:38:05.000000000 -0500
@@ -3,10 +3,10 @@
 # Licensed under the GPL
 #
 
-obj-y = elf_aux.o file.o process.o time.o tty.o user_syms.o drivers/ \
+obj-y = elf_aux.o file.o process.o signal.o time.o tty.o user_syms.o drivers/ \
 	sys-$(SUBARCH)/
 
-USER_OBJS := elf_aux.o file.o process.o time.o tty.o
+USER_OBJS := elf_aux.o file.o process.o signal.o time.o tty.o
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 
 $(USER_OBJS) : %.o: %.c
Index: 2.6.10/arch/um/os-Linux/signal.c
===================================================================
--- 2.6.10.orig/arch/um/os-Linux/signal.c	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/os-Linux/signal.c	2005-01-02 22:09:20.000000000 -0500
@@ -0,0 +1,48 @@
+/* 
+ * Copyright (C) 2004 PathScale, Inc
+ * Licensed under the GPL
+ */
+
+#include <signal.h>
+#include "time_user.h"
+#include "mode.h"
+#include "sysdep/signal.h"
+
+void sig_handler(int sig)
+{
+	struct sigcontext *sc;
+
+	ARCH_GET_SIGCONTEXT(sc, sig);
+	CHOOSE_MODE_PROC(sig_handler_common_tt, sig_handler_common_skas,
+			 sig, sc);
+}
+
+extern int timer_irq_inited;
+
+void alarm_handler(int sig)
+{
+	struct sigcontext *sc;
+
+	ARCH_GET_SIGCONTEXT(sc, sig);
+	if(!timer_irq_inited) return;
+
+	if(sig == SIGALRM)
+		switch_timers(0);
+
+	CHOOSE_MODE_PROC(sig_handler_common_tt, sig_handler_common_skas,
+			 sig, sc);
+
+	if(sig == SIGALRM)
+		switch_timers(1);
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

