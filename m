Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266297AbUGAVrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266297AbUGAVrv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 17:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266300AbUGAVrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 17:47:51 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:40068 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S266297AbUGAVrt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 17:47:49 -0400
X-AuthUser: davidel@xmailserver.org
Date: Thu, 1 Jul 2004 14:47:45 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Roland McGrath <roland@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       mingo@redhat.com, cagney@redhat.com, Daniel Jacobowitz <drow@false.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86 single-step (TF) vs system calls & traps
In-Reply-To: <200407012024.i61KOp3J021841@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0407011435420.20246@bigblue.dev.mdolabs.com>
References: <200407012024.i61KOp3J021841@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jul 2004, Roland McGrath wrote:

> > Here I meant that if you set SINGLESTEP|SYSGOOD, the patch will give you 
> > SIGTRAP|0x80, while if you set only SINGLESTEP the patch will give you 
> > SIGTRAP. Enforcing the SINGLESTEP|SYSGOOD is invalid or only gives SIGTRAP 
> > should be no more that three lines of code out of the fast path.
> 
> There is no "set SINGLESTEP|SYSGOOD".  PTRACE_SINGLESTEP is a one-time
> operation.  PTRACE_O_TRACESYSGOOD is a persistent flag you set when you
> intend to at some point use the PTRACE_SYSCALL operation.

Allrighty ...

Andrew, per Roland suggestion, can you please add the patch below to the 
bits you already have in -mm?


Signed-off-by: Davide Libenzi <davidel@xmailserver.org>



- Davide



--- a/arch/i386/kernel/ptrace.c	2004-07-01 14:30:38.000000000 -0700
+++ b/arch/i386/kernel/ptrace.c	2004-07-01 14:32:44.000000000 -0700
@@ -546,8 +546,8 @@
 		return;
 	/* the 0x80 provides a way for the tracing parent to distinguish
 	   between a syscall stop and SIGTRAP delivery */
-	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-				 ? 0x80 : 0));
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD) &&
+				 !test_thread_flag(TIF_SINGLESTEP) ? 0x80 : 0));
 
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
