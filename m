Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261768AbVFFWaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbVFFWaU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 18:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVFFW33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 18:29:29 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:64004 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261731AbVFFWXE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 18:23:04 -0400
Message-Id: <200506062008.j56K8AaI008962@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 4/5] UML - Fix strace -f
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Jun 2005 16:08:10 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that we need to check for pending signals when a newly forked 
process is run for the first time.  With strace -f, strace needs to know
about the forked process before it gets going.  If it doesn't, then it
ptraces some bogus values into its registers, and the process segfaults.
So, I added calls to interrupt_end, which does that, plus checks for 
reschedules.  There shouldn't be any of those, but x86 does the same thing,
so I'm copying that behavior to be safe.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc/arch/um/kernel/skas/process_kern.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/kernel/skas/process_kern.c	2005-06-02 17:16:46.000000000 -0400
+++ linux-2.6.12-rc/arch/um/kernel/skas/process_kern.c	2005-06-02 17:16:50.000000000 -0400
@@ -68,8 +68,11 @@ void new_thread_handler(int sig)
 	 * 0 if it just exits
 	 */
 	n = run_kernel_thread(fn, arg, &current->thread.exec_buf);
-	if(n == 1)
+	if(n == 1){
+		/* Handle any immediate reschedules or signals */
+		interrupt_end();
 		userspace(&current->thread.regs.regs);
+	}
 	else do_exit(0);
 }
 
@@ -96,6 +99,8 @@ void fork_handler(int sig)
 	schedule_tail(current->thread.prev_sched);
 	current->thread.prev_sched = NULL;
 
+	/* Handle any immediate reschedules or signals */
+	interrupt_end();
 	userspace(&current->thread.regs.regs);
 }
 

