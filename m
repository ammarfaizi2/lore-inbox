Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270215AbUJTCvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270215AbUJTCvm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 22:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267979AbUJTCty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 22:49:54 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:12742 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S270278AbUJTCeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 22:34:08 -0400
Date: Tue, 19 Oct 2004 19:33:56 -0700
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jeff Dike <jdike@addtoit.com>
Subject: [PATCH] UML: build fix for .config w/o CONFIG_MODE_SKAS
Message-ID: <20041020023356.GC8597@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
From: cw@f00f.org (Chris Wedgwood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a hacky (ie. fix properly) changes to make things build w/o
CONFIG_MODE_SKAS.  I think it's probably acceptable as-is for now
since a good chunk of that code will probably change in the not too
far off future anyhow.

Signed-off-by: cw@f00f.org

diff -Nru a/arch/um/kernel/process.c b/arch/um/kernel/process.c
--- a/arch/um/kernel/process.c	2004-10-19 17:47:59 -07:00
+++ b/arch/um/kernel/process.c	2004-10-19 17:47:59 -07:00
@@ -202,6 +202,11 @@
 		"    To make it working, you need a kernel patch for your host, too.\n"
 		"    See http://perso.wanadoo.fr/laurent.vivier/UML/ for further information.\n");
 
+/* Ugly hack for now... */
+#ifndef PTRACE_SYSEMU
+#define PTRACE_SYSEMU 31
+#endif
+
 static void __init check_sysemu(void)
 {
 	void *stack;
@@ -211,7 +216,9 @@
 		return;
 
 	printk("Checking syscall emulation patch for ptrace...");
+#ifdef CONFIG_MODE_SKAS
 	sysemu_supported = 0;
+#endif /* CONFIG_MODE_SKAS */
 	pid = start_ptraced_child(&stack);
 	if(ptrace(PTRACE_SYSEMU, pid, 0, 0) >= 0) {
 		struct user_regs_struct regs;
@@ -233,17 +240,23 @@
 
 		stop_ptraced_child(pid, stack, 0);
 
+#ifdef CONFIG_MODE_SKAS
 		sysemu_supported = 1;
+#endif /* CONFIG_MODE_SKAS */
 		printk("found\n");
 	}
 	else
 	{
 		stop_ptraced_child(pid, stack, 1);
+#ifdef CONFIG_MODE_SKAS
 		sysemu_supported = 0;
+#endif /* CONFIG_MODE_SKAS */
 		printk("missing\n");
 	}
 
+#ifdef CONFIG_MODE_SKAS
 	set_using_sysemu(!force_sysemu_disabled);
+#endif
 }
 
 void __init check_ptrace(void)
