Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWAOUrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWAOUrx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 15:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWAOUrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 15:47:52 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:28067 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750759AbWAOUrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 15:47:52 -0500
Message-Id: <200601152139.k0FLdedi027721@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: [PATCH 4/11] UML - Change interface to boot_timer_handler
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 15 Jan 2006 16:39:40 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Current implementation of boot_timer_handler isn't usable
for s390. So I changed its name to do_boot_timer_handler,
taking (struct sigcontext *)sc as argument.
do_boot_timer_handler is called from new boot_timer_handler()
in arch/um/os-Linux/signal.c, which uses the same mechanisms
as other signal handler to find out sigcontext pointer.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/kernel/time_kern.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/time_kern.c	2006-01-06 21:24:14.000000000 -0500
+++ linux-2.6.15-mm/arch/um/kernel/time_kern.c	2006-01-06 21:35:21.000000000 -0500
@@ -84,12 +84,11 @@ void timer_irq(union uml_pt_regs *regs)
 	}
 }
 
-void boot_timer_handler(int sig)
+void do_boot_timer_handler(struct sigcontext * sc)
 {
 	struct pt_regs regs;
 
-	CHOOSE_MODE((void)
-		    (UPT_SC(&regs.regs) = (struct sigcontext *) (&sig + 1)),
+	CHOOSE_MODE((void) (UPT_SC(&regs.regs) = sc),
 		    (void) (regs.regs.skas.is_user = 0));
 	do_timer(&regs);
 }
Index: linux-2.6.15-mm/arch/um/os-Linux/signal.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/os-Linux/signal.c	2006-01-06 21:24:14.000000000 -0500
+++ linux-2.6.15-mm/arch/um/os-Linux/signal.c	2006-01-06 21:35:21.000000000 -0500
@@ -12,7 +12,6 @@
 #include <string.h>
 #include <sys/mman.h>
 #include "user_util.h"
-#include "kern_util.h"
 #include "user.h"
 #include "signal_kern.h"
 #include "sysdep/sigcontext.h"
@@ -49,6 +48,17 @@ void alarm_handler(ARCH_SIGHDLR_PARAM)
 		switch_timers(1);
 }
 
+extern void do_boot_timer_handler(struct sigcontext * sc);
+
+void boot_timer_handler(ARCH_SIGHDLR_PARAM)
+{
+	struct sigcontext *sc;
+
+	ARCH_GET_SIGCONTEXT(sc, sig);
+
+	do_boot_timer_handler(sc);
+}
+
 void set_sigstack(void *sig_stack, int size)
 {
 	stack_t stack = ((stack_t) { .ss_flags	= 0,

