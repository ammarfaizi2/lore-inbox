Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262678AbVAQDkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262678AbVAQDkG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 22:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbVAQDf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 22:35:57 -0500
Received: from pool-151-203-218-166.bos.east.verizon.net ([151.203.218.166]:21508
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262678AbVAQDdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 22:33:54 -0500
Message-Id: <200501170556.j0H5uOkY006082@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org, Blaisorblade <blaisorblade@yahoo.it>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 9/10] UML - Fix a stack corruption crash
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 17 Jan 2005 00:56:24 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a race where signals could be handled to the parent of a new process
on the kernel stack of the child, corrupting that stack, and crashing UML
when the next first runs.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.10/arch/um/kernel/skas/process.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/skas/process.c	2005-01-16 20:37:25.000000000 -0500
+++ 2.6.10/arch/um/kernel/skas/process.c	2005-01-16 20:57:16.000000000 -0500
@@ -224,9 +224,10 @@
 	block_signals();
 	if(sigsetjmp(fork_buf, 1) == 0)
 		new_thread_proc(stack, handler);
-	set_signals(flags);
 
 	remove_sigstack();
+
+	set_signals(flags);
 }
 
 void thread_wait(void *sw, void *fb)

