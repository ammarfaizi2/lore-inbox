Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbVAJFzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbVAJFzt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 00:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVAJFrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 00:47:15 -0500
Received: from pool-151-203-193-191.bos.east.verizon.net ([151.203.193.191]:29444
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262105AbVAJFOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 00:14:38 -0500
Message-Id: <200501100736.j0A7a4PW005840@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 22/28] UML - Allow arches to opt out of !SA_INFO signals
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jan 2005 02:36:04 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

x86_64 only delivers signals in the SA_INFO style, whether you ask
for it or not.  This patch adds a config option which says whether
the arch is SA_INFO-only or not, and ifdefs out the sigcontext
signal delivery if so.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.10/arch/um/Kconfig_i386
===================================================================
--- 2.6.10.orig/arch/um/Kconfig_i386	2005-01-09 21:52:21.000000000 -0500
+++ 2.6.10/arch/um/Kconfig_i386	2005-01-09 21:53:58.000000000 -0500
@@ -14,3 +14,7 @@
 	Three-level pagetables will let UML have more than 4G of physical
 	memory.  All the memory that can't be mapped directly will be treated
 	as high memory.
+
+config ARCH_HAS_SC_SIGNALS
+	bool
+	default y
Index: 2.6.10/arch/um/Kconfig_x86_64
===================================================================
--- 2.6.10.orig/arch/um/Kconfig_x86_64	2005-01-09 21:52:21.000000000 -0500
+++ 2.6.10/arch/um/Kconfig_x86_64	2005-01-09 21:54:17.000000000 -0500
@@ -5,3 +5,7 @@
 config 3_LEVEL_PGTABLES
        bool
        default y
+
+config ARCH_HAS_SC_SIGNALS
+	bool
+	default n
Index: 2.6.10/arch/um/kernel/signal_kern.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/signal_kern.c	2005-01-09 19:06:06.000000000 -0500
+++ 2.6.10/arch/um/kernel/signal_kern.c	2005-01-09 21:53:29.000000000 -0500
@@ -74,10 +74,12 @@
 	if((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags(sp) == 0))
 		sp = current->sas_ss_sp + current->sas_ss_size;
 
-	if(ka->sa.sa_flags & SA_SIGINFO)
-		err = setup_signal_stack_si(sp, signr, ka, regs, info, oldset);
-	else
+#ifdef CONFIG_ARCH_HAS_SC_SIGNALS
+	if(!(ka->sa.sa_flags & SA_SIGINFO))
 		err = setup_signal_stack_sc(sp, signr, ka, regs, oldset);
+	else
+#endif
+		err = setup_signal_stack_si(sp, signr, ka, regs, info, oldset);
 
 	if(err){
 		spin_lock_irq(&current->sighand->siglock);

