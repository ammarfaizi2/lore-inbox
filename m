Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267511AbUIBFnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267511AbUIBFnT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 01:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267521AbUIBFnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 01:43:18 -0400
Received: from mail4.speakeasy.net ([216.254.0.204]:60572 "EHLO
	mail4.speakeasy.net") by vger.kernel.org with ESMTP id S267511AbUIBFmx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 01:42:53 -0400
Date: Wed, 1 Sep 2004 22:42:50 -0700
Message-Id: <200409020542.i825goUU026209@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386 syscall tracing of bogus system calls
X-Fcc: ~/Mail/linus
X-Zippy-Says: How do you explain Wayne Newton's POWER over millions?  It's th'
   MOUSTACHE...  Have you ever noticed th' way it radiates SINCERITY,
   HONESTY & WARMTH?  It's a MOUSTACHE you want to take HOME and
   introduce to NANCY SINATRA!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.4, strace will show you all bogus system calls a process tries.  In
2.6, it only shows you stubs < __NR_syscalls, and there is no tracing stop
for large bogus system call numbers.  I can't see why this was changed, so
I am assuming it was accidental.

This patch restores the expected behavior that syscall tracing shows every
bogus syscall attempt.


Thanks,
Roland

Signed-off-by: Roland McGrath <roland@redhat.com>

Index: linux-2.6/arch/i386/kernel/entry.S
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/arch/i386/kernel/entry.S,v
retrieving revision 1.89
diff -p -u -r1.89 entry.S
--- linux-2.6/arch/i386/kernel/entry.S 31 Aug 2004 17:35:25 -0000 1.89
+++ linux-2.6/arch/i386/kernel/entry.S 2 Sep 2004 05:38:46 -0000
@@ -255,11 +255,11 @@ sysenter_past_esp:
 	pushl %eax
 	SAVE_ALL
 	GET_THREAD_INFO(%ebp)
-	cmpl $(nr_syscalls), %eax
-	jae syscall_badsys
 
 	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT),TI_flags(%ebp)
 	jnz syscall_trace_entry
+	cmpl $(nr_syscalls), %eax
+	jae syscall_badsys
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)
 	cli
@@ -278,11 +278,11 @@ ENTRY(system_call)
 	pushl %eax			# save orig_eax
 	SAVE_ALL
 	GET_THREAD_INFO(%ebp)
-	cmpl $(nr_syscalls), %eax
-	jae syscall_badsys
 					# system call tracing in operation
 	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT),TI_flags(%ebp)
 	jnz syscall_trace_entry
+	cmpl $(nr_syscalls), %eax
+	jae syscall_badsys
 syscall_call:
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)		# store the return value
