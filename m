Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262490AbULCTbC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbULCTbC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 14:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbULCTae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 14:30:34 -0500
Received: from pool-151-203-6-248.bos.east.verizon.net ([151.203.6.248]:17668
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262475AbULCT2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 14:28:33 -0500
Message-Id: <200412032144.iB3LiZZW004698@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, Blaisorblade <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: [PATCH] UML - Fix setting of TIF_SIGPENDING
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 Dec 2004 16:44:35 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

My older patch, that sets TIF_SIGPENDING after an ptrace-interception
in syscall_trace() is wrong.
Some syscalls want to be called without any signal pending. If a signal
is pending on syscall-entry, they immediately return with -ERESTARTNOINTR.
Thus, on return to user, the pending signals can be processed and the
kernel will lower eip by 2 to have the syscall restarted after that.
Since my change sets TIF_SIGPENDING on the entry and exit interception,
stracing such a syscall looped! Try "strace ls" to see what happens.
Fix: set TIF_SIGPENDING on the exit interception only. This avoids the
loop and is enough for security.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/kernel/ptrace.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/ptrace.c	2004-12-01 23:43:11.000000000 -0500
+++ 2.6.9/arch/um/kernel/ptrace.c	2004-12-01 23:52:23.000000000 -0500
@@ -330,8 +330,8 @@
 	tracesysgood = (current->ptrace & PT_TRACESYSGOOD) && !is_singlestep;
 	ptrace_notify(SIGTRAP | (tracesysgood ? 0x80 : 0));
 
-	/* force do_signal() --> is_syscall() */
-	set_thread_flag(TIF_SIGPENDING);
+	if (entryexit) /* force do_signal() --> is_syscall() */
+		set_thread_flag(TIF_SIGPENDING);
 
 	/* this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the

