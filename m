Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbUL3B4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbUL3B4K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 20:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbUL3B4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 20:56:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:1956 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261502AbUL3B4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 20:56:06 -0500
Date: Wed, 29 Dec 2004 17:55:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Jesse Allen <the3dfxdude@gmail.com>, Mike Hearn <mh@codeweavers.com>,
       Thomas Sailer <sailer@scs.ch>, Eric Pouech <pouech-eric@wanadoo.fr>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <Pine.LNX.4.58.0412291703400.30636@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.58.0412291745470.2353@ppc970.osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com> 
 <20041120214915.GA6100@tesore.ph.cox.net>  <41A251A6.2030205@wanadoo.fr> 
 <Pine.LNX.4.58.0411221300460.20993@ppc970.osdl.org>  <1101161953.13273.7.camel@littlegreen>
  <1104286459.7640.54.camel@gamecube.scs.ch>  <1104332559.3393.16.camel@littlegreen>
  <Pine.LNX.4.58.0412291047120.2353@ppc970.osdl.org> 
 <53046857041229114077eb4d1d@mail.gmail.com>  <Pine.LNX.4.58.0412291151080.2353@ppc970.osdl.org>
 <530468570412291343d1478cf@mail.gmail.com> <Pine.LNX.4.58.0412291622560.2353@ppc970.osdl.org>
 <Pine.LNX.4.58.0412291703400.30636@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Dec 2004, Davide Libenzi wrote:
> 
> That test went in to be able to have ptrace single step, to see even the 
> instruction following the #int instruction (this was the target of the 
> patch itself). I just verified that, in 2.6.8 that does not have such test 
> anymore, the single-step-after-int capability is lost.

Ahh. That's because of a separate bug: we have this silly separation of 
"_TIF_WORK_MASK" (everything but tracing) and "_TIF_ALLWORK_MASK" 
(everything), and the system call stuff takes over _TIF_SINGLESTEP for 
some very non-obvious reasons.

I don't see why the system-call code thinks _TIF_SINGLESTEP is special, 
but it certainly explains why it doesn't get handled normally.

So the updated patch would look something like the appended.

Will test whether it cleanly handles your test-case. Davide - you also 
added the TIF_SINGLESTEP flag to that _TIF_WORK_MASK, can you explain 
that?

(And yes, I know you'd sent me the test-program before, but I'm about as 
organized as a Performing Seal with Alzheimers..)

		Linus

--- 1.23/include/asm-i386/thread_info.h	2004-11-18 23:03:11 -08:00
+++ edited/include/asm-i386/thread_info.h	2004-12-29 17:52:16 -08:00
@@ -153,7 +153,7 @@
 
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK \
-  (0x0000FFFF & ~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP))
+  (0x0000FFFF & ~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT))
 #define _TIF_ALLWORK_MASK	0x0000FFFF	/* work to do on any return to u-space */
 
 /*
--- 1.28/arch/i386/kernel/ptrace.c	2004-11-22 09:44:52 -08:00
+++ edited/arch/i386/kernel/ptrace.c	2004-12-29 17:36:41 -08:00
@@ -568,15 +568,13 @@
 			audit_syscall_exit(current, regs->eax);
 	}
 
-	if (!test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    !test_thread_flag(TIF_SINGLESTEP))
+	if (!test_thread_flag(TIF_SYSCALL_TRACE))
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
 	/* the 0x80 provides a way for the tracing parent to distinguish
 	   between a syscall stop and SIGTRAP delivery */
-	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD) &&
-				 !test_thread_flag(TIF_SINGLESTEP) ? 0x80 : 0));
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD) ? 0x80 : 0));
 
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
