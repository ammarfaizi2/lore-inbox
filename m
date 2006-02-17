Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWBQVz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWBQVz3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 16:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbWBQVz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 16:55:29 -0500
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:49559 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750859AbWBQVz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 16:55:28 -0500
Date: Fri, 17 Feb 2006 16:49:57 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] i386: another possible singlestep fix
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200602171652_MC3-1-B8AC-373E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When entering kernel via int80, TIF_SINGLESTEP is not set
when TF has been set in eflags by the user.  This patch
does that.

To make things symmetrical, something further should be done.
Either (a) add to this patch so it clears TF after setting
TIF_SINGLESTEP, or (b) change the sysenter path so it sets
TF in regs.eflags when it finds TIF_SINGLESTEP was set by
do_debug() during kernel entry.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.16-rc3.orig/arch/i386/kernel/entry.S
+++ 2.6.16-rc3/arch/i386/kernel/entry.S
@@ -226,6 +226,10 @@ ENTRY(system_call)
 	pushl %eax			# save orig_eax
 	SAVE_ALL
 	GET_THREAD_INFO(%ebp)
+	testl $TF_MASK,EFLAGS(%esp)
+	jz no_singlestep
+	orl $_TIF_SINGLESTEP,TI_flags(%ebp)
+no_singlestep:
 					# system call tracing in operation / emulation
 	/* Note, _TIF_SECCOMP is bit number 8, and so it needs testw and not testb */
 	testw $(_TIF_SYSCALL_EMU|_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT),TI_flags(%ebp)
-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert
