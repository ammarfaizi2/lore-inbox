Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264911AbUEKRPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264911AbUEKRPT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 13:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264886AbUEKRNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 13:13:55 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:5801 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264911AbUEKRMs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 13:12:48 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 11 May 2004 10:12:46 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [patch] really-ptrace-single-step
Message-ID: <Pine.LNX.4.58.0405111007440.25232@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch lets a ptrace process on x86 to "see" the instruction 
following the INT #80h op.



- Davide


arch/i386/kernel/entry.S       |    2 +-
include/asm-i386/thread_info.h |    2 +-
2 files changed, 2 insertions(+), 2 deletions(-)




Index: arch/i386/kernel/entry.S
===================================================================
RCS file: /usr/src/bkcvs/linux-2.5/arch/i386/kernel/entry.S,v
retrieving revision 1.83
diff -u -r1.83 entry.S
--- arch/i386/kernel/entry.S	12 Apr 2004 20:29:12 -0000	1.83
+++ arch/i386/kernel/entry.S	11 May 2004 06:35:29 -0000
@@ -354,7 +354,7 @@
 	# perform syscall exit tracing
 	ALIGN
 syscall_exit_work:
-	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT), %cl
+	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP), %cl
 	jz work_pending
 	sti				# could let do_syscall_trace() call
 					# schedule() instead
Index: include/asm-i386/thread_info.h
===================================================================
RCS file: /usr/src/bkcvs/linux-2.5/include/asm-i386/thread_info.h,v
retrieving revision 1.19
diff -u -r1.19 thread_info.h
--- include/asm-i386/thread_info.h	12 Apr 2004 20:29:12 -0000	1.19
+++ include/asm-i386/thread_info.h	11 May 2004 06:34:47 -0000
@@ -165,7 +165,7 @@
 
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK \
-  (0x0000FFFF & ~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT))
+  (0x0000FFFF & ~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP))
 #define _TIF_ALLWORK_MASK	0x0000FFFF	/* work to do on any return to u-space */
 
 /*
