Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbVJaDqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbVJaDqj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 22:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbVJaDqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 22:46:39 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:24838 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1751311AbVJaDqi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 22:46:38 -0500
Message-Id: <200510310439.j9V4dKTN000834@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/10] UML - Improve stub debugging
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 30 Oct 2005 23:39:20 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add some more debugging information when a stub does something unexpected,
usually segfaulting.  Now, it dumps out the stub's registers as well as
the signal.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.14-rc2-mm1/arch/um/kernel/skas/process.c
===================================================================
--- linux-2.6.14-rc2-mm1.orig/arch/um/kernel/skas/process.c	2005-10-05 18:37:51.000000000 -0400
+++ linux-2.6.14-rc2-mm1/arch/um/kernel/skas/process.c	2005-10-05 18:50:23.000000000 -0400
@@ -69,6 +69,17 @@
 
         if((n < 0) || !WIFSTOPPED(status) ||
            (WSTOPSIG(status) != SIGUSR1 && WSTOPSIG(status) != SIGTRAP)){
+		unsigned long regs[FRAME_SIZE];
+		if(ptrace(PTRACE_GETREGS, pid, 0, regs) < 0)
+			printk("Failed to get registers from stub, "
+			       "errno = %d\n", errno);
+		else {
+			int i;
+
+			printk("Stub registers -\n");
+			for(i = 0; i < FRAME_SIZE; i++)
+				printk("\t%d - %lx\n", i, regs[i]);
+		}
                 panic("%s : failed to wait for SIGUSR1/SIGTRAP, "
                       "pid = %d, n = %d, errno = %d, status = 0x%x\n",
                       fname, pid, n, errno, status);

