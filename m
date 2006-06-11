Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWFKTPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWFKTPS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 15:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWFKTPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 15:15:18 -0400
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:35212 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750825AbWFKTPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 15:15:17 -0400
Date: Sun, 11 Jun 2006 15:07:29 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] i386: extra checks in show_registers()
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>
Message-ID: <200606111512_MC3-1-C229-37E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes thread_info and task_struct get out-of-sync with each
other.  Printing task.thread_info in show_registers() can help
spot this.  And when task_struct is corrupt then task.comm can
contain garbage, so only print as many characters as it can hold.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.17-rc6-32-post.orig/arch/i386/kernel/traps.c
+++ 2.6.17-rc6-32-post/arch/i386/kernel/traps.c
@@ -268,8 +268,9 @@ void show_registers(struct pt_regs *regs
 		regs->esi, regs->edi, regs->ebp, esp);
 	printk(KERN_EMERG "ds: %04x   es: %04x   ss: %04x\n",
 		regs->xds & 0xffff, regs->xes & 0xffff, ss);
-	printk(KERN_EMERG "Process %s (pid: %d, threadinfo=%p task=%p)",
-		current->comm, current->pid, current_thread_info(), current);
+	printk(KERN_EMERG "Process %.*s (pid: %d, ti=%p task=%p task.ti=%p)",
+		TASK_COMM_LEN, current->comm, current->pid,
+		current_thread_info(), current, current->thread_info);
 	/*
 	 * When in-kernel, we also print out the stack and code at the
 	 * time of the fault..
-- 
Chuck
