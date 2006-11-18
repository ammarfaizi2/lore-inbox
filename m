Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756296AbWKRLqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756296AbWKRLqr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 06:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756304AbWKRLqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 06:46:46 -0500
Received: from aun.it.uu.se ([130.238.12.36]:15321 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1756296AbWKRLqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 06:46:46 -0500
Date: Sat, 18 Nov 2006 12:46:32 +0100 (MET)
Message-Id: <200611181146.kAIBkW52028010@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: folkert@vanheusden.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] emit logging when a process receives a fatal signal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Nov 2006 02:09:46 +0100, Folkert van Heusden wrote:
>I found that sometimes processes disappear on some heavily used system
>of mine without any logging. So I've written a patch against 2.6.18.2
>which emits logging when a process emits a fatal signal.
>
>Signed-off-by: Folkert van Heusden <folkert@vanheusden.com>
>
>--- linux-2.6.18.2/kernel/signal.c	2006-11-04 02:33:58.000000000 +0100
>+++ linux-2.6.18.2.new/kernel/signal.c	2006-11-17 15:59:13.000000000 +0100
>@@ -706,6 +706,15 @@
> 	struct sigqueue * q = NULL;
> 	int ret = 0;
> 
>+	if (sig == SIGQUIT || sig == SIGILL  || sig == SIGTRAP ||
>+	    sig == SIGABRT || sig == SIGBUS  || sig == SIGFPE  ||
>+	    sig == SIGSEGV || sig == SIGXCPU || sig == SIGXFSZ ||
>+	    sig == SIGSYS  || sig == SIGSTKFLT)
>+	{
>+		printk(KERN_WARNING "Sig %d send to %d owned by %d.%d (%s)\n",
>+			sig, t -> pid, t -> uid, t -> gid, t -> comm);
>+	}
>+
> 	/*
> 	 * fast-pathed signals for kernel-internal things like SIGSTOP
> 	 * or SIGKILL.

NAK.

1. It lets any user DOS the system.
2. Your definition of "fatal" signals is wrong. Several of these
   signals can be caught, and user-space sometimes does that for
   good reason. FPE and SEGV are definitely often caught, BUS and
   ILL may be caught, and I suspect TRAP to be common in debugging
   sessions.
3. It puts policy in the kernel. Policy decisions belong in user-space.
   In this case, the policy decision is whether this type of logging
   is desired for a given process or not.
4. If this is about detecting the loss of specific processes
   (network services say), then the problem can be solved in
   user-space by using a separate monitor process, or by
   controlling the processes via ptrace.

At a minimum, the logging needs to be conditionalised on a
per-process setting, and it should also be delayed until the
point where a signal causes a process to be killed.

/Mikael
