Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbUL3H1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbUL3H1d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 02:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbUL3H1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 02:27:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:31664 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261559AbUL3H0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 02:26:53 -0500
Date: Wed, 29 Dec 2004 23:26:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Jesse Allen <the3dfxdude@gmail.com>, Mike Hearn <mh@codeweavers.com>,
       Thomas Sailer <sailer@scs.ch>, Eric Pouech <pouech-eric@wanadoo.fr>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <Pine.LNX.4.58.0412292106400.454@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.58.0412292256350.22893@ppc970.osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com> 
 <20041120214915.GA6100@tesore.ph.cox.net>  <41A251A6.2030205@wanadoo.fr> 
 <Pine.LNX.4.58.0411221300460.20993@ppc970.osdl.org>  <1101161953.13273.7.camel@littlegreen>
  <1104286459.7640.54.camel@gamecube.scs.ch>  <1104332559.3393.16.camel@littlegreen>
  <Pine.LNX.4.58.0412291047120.2353@ppc970.osdl.org> 
 <53046857041229114077eb4d1d@mail.gmail.com>  <Pine.LNX.4.58.0412291151080.2353@ppc970.osdl.org>
 <530468570412291343d1478cf@mail.gmail.com> <Pine.LNX.4.58.0412291622560.2353@ppc970.osdl.org>
 <Pine.LNX.4.58.0412291703400.30636@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0412291745470.2353@ppc970.osdl.org>
 <Pine.LNX.4.58.0412292050550.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412292055540.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412292106400.454@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Dec 2004, Davide Libenzi wrote:
> 
> I think same. My test simply let the function processing to let thru and 
> reach the fake signal sending point.

No, your test-case doesn't even send a signal at all, because your
test-program just uses a PTRACE_SINGLESTEP without any "send signal" - so
"exit_code" will be zero after the debuggee gets released from the
"ptrace_notify()", and the suspect code will never be executed..

The problem I think I see (and which the comment alludes to) is that if
the controlling process continues the debuggee with a signal, we'll be
doing the wrong thing: the code in do_syscall_trace() will take that
signal (in "current->exit_code") and send it as a real signal to the
debuggee, but since it is debugged, it will be caught (again) by the
controlling process, which apparently in the case of Wine gets very
confused.

So I _think_ the problem happens for the following schenario:
 - wine for some reason does a PTRACE_SINGLESTEP over a system call
 - after the single-step, wine ends up trying to get the sub-process to 
   enter a signal handler with ptrace( PTRACE_CONT, ... sig)
 - the normal ptrace path (where we trap a signal - see kernel/signal.c 
   and the "ptrace_stop()" logic) handles this correctly, but 
   do_syscall_trace() will do a "send_sig()"
 - we'll try to handle the signal when returning to the traced process
 - now "get_signal_to_deliver()" will invoce the ptrace logic AGAIN, and 
   call ptrace_stop() for this fake signal, and we'll report a new event 
   to the controlling process.

Does this make sense?

If so, we have a few options:

 - very hacky one: teach all ptrace users that sometimes the signal you
   continue with can be reflected back at you, and you should just "cont
   signr"  _again_.

   This is a really bad option, partly because it's hard to tell when it's 
   just a spurious reflected signal, partly because there are many ptrace 
   users, and to a large part just because it's clearly too hacky. But it
   might be a valid approach for a Wine person who is used to Wine, and
   wants to verify whether this is indeed the schenario that triggers the
   problem..

 - Stupid approach: mark the siginfo that we send as the fake one as being 
   reflected, and have get_signal_to_deliver() not apply the ptrace 
   stopping to that.

 - Possibly cleaner approach: make system call tracing just use a proper
   SIGTRAP in the first place, and always handle all the ptrace_stop() etc
   cruft in kernel/signal.c like it handles all other calls.

I dunno. The final one looks fairly simple and clean, something like the
following, but I'm most likely overlooking some reason why this won't
work..

(And as usual, this patch has not been tested in any shape, way or form. 
In fact, it hasn't even seen an x86 machine, since I edited it out as a 
fake on my ppc64.. Somebody with more brains than me should actually try 
to get it to work)

		Linus

----
===== arch/i386/kernel/ptrace.c 1.28 vs edited =====
--- 1.28/arch/i386/kernel/ptrace.c	2004-11-22 09:44:52 -08:00
+++ edited/arch/i386/kernel/ptrace.c	2004-12-29 23:21:58 -08:00
@@ -559,6 +559,8 @@
 __attribute__((regparm(3)))
 void do_syscall_trace(struct pt_regs *regs, int entryexit)
 {
+	struct siginfo info;
+
 	if (unlikely(current->audit_context)) {
 		if (!entryexit)
 			audit_syscall_entry(current, regs->orig_eax,
@@ -573,18 +575,18 @@
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
+
+	memset(&info, 0, sizeof(info));
+	info.si_signo = SIGTRAP;
+
 	/* the 0x80 provides a way for the tracing parent to distinguish
 	   between a syscall stop and SIGTRAP delivery */
-	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD) &&
-				 !test_thread_flag(TIF_SINGLESTEP) ? 0x80 : 0));
+	info.si_code = SIGTRAP;
+	if ((current->ptrace & PT_TRACESYSGOOD) && !test_thread_flag(TIF_SINGLESTEP))
+		info.si_code = SIGTRAP | 0x80;
+	info.si_pid = current->tgid;
+	info.si_uid = current->uid;
 
-	/*
-	 * this isn't the same as continuing with a signal, but it will do
-	 * for normal use.  strace only continues with a signal if the
-	 * stopping signal is not SIGTRAP.  -brl
-	 */
-	if (current->exit_code) {
-		send_sig(current->exit_code, current, 1);
-		current->exit_code = 0;
-	}
+	/* Send us the fakey SIGTRAP */
+	send_sig_info(SIGTRAP, &info, current);
 }
