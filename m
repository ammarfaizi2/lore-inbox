Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262686AbVEAVUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbVEAVUs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 17:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbVEAVUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 17:20:01 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:26131 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262689AbVEAVSa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 17:18:30 -0400
Message-Id: <200505012113.j41LD5XR016488@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       bstroesser@fujitsu-siemens.com
Subject: [PATCH 20/22] UML - S390 preparation, sighandler interface abstraction
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 01 May 2005 17:13:05 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

s390 passes parameters in registers. So the only safe way to
find out the address of signal context, error-address and
error-type (trap_no), which are passed to signal handlers as
parameters, is to declare these parameters.
So I inserted an subarch-specific macro which holds the
declaration of parameters for signal handlers.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/include/sysdep-i386/signal.h
===================================================================
--- linux-2.6.11.orig/arch/um/include/sysdep-i386/signal.h	2005-04-29 13:44:52.000000000 -0400
+++ linux-2.6.11/arch/um/include/sysdep-i386/signal.h	2005-04-29 14:38:05.000000000 -0400
@@ -8,6 +8,8 @@
 
 #include <signal.h>
 
+#define ARCH_SIGHDLR_PARAM int sig
+
 #define ARCH_GET_SIGCONTEXT(sc, sig) \
 	do sc = (struct sigcontext *) (&sig + 1); while(0)
 
Index: linux-2.6.11/arch/um/include/sysdep-x86_64/signal.h
===================================================================
--- linux-2.6.11.orig/arch/um/include/sysdep-x86_64/signal.h	2005-04-29 13:44:52.000000000 -0400
+++ linux-2.6.11/arch/um/include/sysdep-x86_64/signal.h	2005-04-29 14:38:05.000000000 -0400
@@ -6,6 +6,8 @@
 #ifndef __X86_64_SIGNAL_H_
 #define __X86_64_SIGNAL_H_
 
+#define ARCH_SIGHDLR_PARAM int sig
+
 #define ARCH_GET_SIGCONTEXT(sc, sig_addr) \
 	do { \
 		struct ucontext *__uc; \
Index: linux-2.6.11/arch/um/os-Linux/signal.c
===================================================================
--- linux-2.6.11.orig/arch/um/os-Linux/signal.c	2005-04-29 14:22:28.000000000 -0400
+++ linux-2.6.11/arch/um/os-Linux/signal.c	2005-04-29 14:38:05.000000000 -0400
@@ -8,7 +8,7 @@
 #include "mode.h"
 #include "sysdep/signal.h"
 
-void sig_handler(int sig)
+void sig_handler(ARCH_SIGHDLR_PARAM)
 {
 	struct sigcontext *sc;
 
@@ -19,7 +19,7 @@
 
 extern int timer_irq_inited;
 
-void alarm_handler(int sig)
+void alarm_handler(ARCH_SIGHDLR_PARAM)
 {
 	struct sigcontext *sc;
 

