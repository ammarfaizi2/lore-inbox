Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264620AbSLLNYG>; Thu, 12 Dec 2002 08:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264622AbSLLNYG>; Thu, 12 Dec 2002 08:24:06 -0500
Received: from mx1.elte.hu ([157.181.1.137]:7402 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S264620AbSLLNYF>;
	Thu, 12 Dec 2002 08:24:05 -0500
Date: Thu, 12 Dec 2002 14:35:13 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] ptrace-sigfix-2.5.51-A1
Message-ID: <Pine.LNX.4.44.0212121431430.6741-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch, against BK-curr fixes a threading/ptrace bug noticed
by the gdb people: when a thread is ptraced but other threads in the
thread group are not then a SIGTRAP (via int3 or any of the other debug
traps) causes the child thread(s) to die unexpectedly. This is because the
default behavior for a no-handler SIGTRAP is to broadcast it.

The solution is to make all such signals specific, then the ptracer (gdb)  
can filter the signal and upon continuation it's being handled properly
(or put on the shared signal queue). SIGKILL and SIGSTOP are an exception.
The patch only affects threaded and ptrace-d processes.

	Ingo

--- linux/kernel/signal.c.orig	2002-12-12 13:28:09.000000000 +0100
+++ linux/kernel/signal.c	2002-12-12 13:26:03.000000000 +0100
@@ -939,7 +947,8 @@
 	if (sig_ignored(p, sig))
 		goto out_unlock;
 
-	if (sig_kernel_specific(sig))
+	if (sig_kernel_specific(sig) ||
+		       ((p->ptrace & PT_PTRACED) && !sig_kernel_only(sig)))
 		goto out_send;
 
 	/* Does any of the threads unblock the signal? */

