Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbUEKGsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUEKGsn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 02:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbUEKGmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 02:42:51 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:44694 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262071AbUEKGl4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 02:41:56 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 10 May 2004 23:41:53 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Davide Libenzi <davidel@xmailserver.org>
cc: Fabiano Ramos <ramos_fabiano@yahoo.com.br>,
       Daniel Jacobowitz <dan@debian.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ptrace in 2.6.5
In-Reply-To: <Pine.LNX.4.58.0405102324350.1156@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.58.0405102340260.1156@bigblue.dev.mdolabs.com>
References: <1UlcA-6lq-9@gated-at.bofh.it>  <m365b4kth8.fsf@averell.firstfloor.org>
  <1084220684.1798.3.camel@slack.domain.invalid>  <877jvkx88r.fsf@devron.myhome.or.jp>
 <873c67yk5v.fsf@devron.myhome.or.jp>  <20040510225818.GA24796@nevyn.them.org>
 <1084236054.1763.25.camel@slack.domain.invalid>
 <Pine.LNX.4.58.0405102253480.1156@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0405102324350.1156@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2004, Davide Libenzi wrote:

> On Mon, 10 May 2004, Davide Libenzi wrote:
> 
> > On the kernel side, this would be pretty much solved by issuing a ptrace 
> > op, with a modified EIP (+2) on return from a syscall (if in single-step 
> > mode).
> 
> Actaully, the EIP should not be changed (since it already points to the 
> intruction following INT 0x80) and I believe it is sufficent to replace 
> the test for _TIF_SYSCALL_TRACE with (_TIF_SYSCALL_TRACE | TIF_SINGLESTEP) 
> in the system call return path. This should generate a ptrace trap with 
> EIP pointing to the next instruction following INT 0x80.

The patch below (for i386) should work.



- Davide




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
