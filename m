Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbTKOGXq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 01:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbTKOGXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 01:23:46 -0500
Received: from ozlabs.org ([203.10.76.45]:31390 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261555AbTKOGXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 01:23:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16309.50943.8136.360034@cargo.ozlabs.ibm.com>
Date: Sat, 15 Nov 2003 17:26:07 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC32: cancel syscall restart on signal delivery
In-Reply-To: <Pine.LNX.4.44.0311142108060.9014-100000@home.osdl.org>
References: <16309.46013.862161.879144@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.44.0311142108060.9014-100000@home.osdl.org>
X-Mailer: VM 7.17 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> Excellent point. We're actually much better off resetting it at signal
> return.
> 
> Which should make all other resets unnecessary.

Yes.

> Yes, you can get out of a signal by using longjmp, but that doesn't
> matter: you can't longjump to a restart call (well, you can, but only if
> the user literally tries to do the restart by hand, ie he _intended_ to do
> it).
> 
> So the _proper_ fix (for x86) should be as appended. Agreed?

Agreed.  Here is the patch for PPC.

Thanks,
Paul.

diff -urN linux-2.5/arch/ppc/kernel/signal.c pmac-2.5/arch/ppc/kernel/signal.c
--- linux-2.5/arch/ppc/kernel/signal.c	2003-11-15 16:55:18.618797320 +1100
+++ pmac-2.5/arch/ppc/kernel/signal.c	2003-11-15 17:09:53.145849000 +1100
@@ -418,6 +418,9 @@
 {
 	struct rt_sigframe __user *rt_sf;
 
+	/* Always make any pending restarted system calls return -EINTR */
+	current_thread_info()->restart_block.fn = do_no_restart_syscall;
+
 	rt_sf = (struct rt_sigframe __user *)
 		(regs->gpr[1] + __SIGNAL_FRAMESIZE + 16);
 	if (verify_area(VERIFY_READ, rt_sf, sizeof(struct rt_sigframe)))
@@ -513,6 +516,9 @@
 	struct mcontext __user *sr;
 	sigset_t set;
 
+	/* Always make any pending restarted system calls return -EINTR */
+	current_thread_info()->restart_block.fn = do_no_restart_syscall;
+
 	sc = (struct sigcontext __user *)(regs->gpr[1] + __SIGNAL_FRAMESIZE);
 	if (copy_from_user(&sigctx, sc, sizeof(sigctx)))
 		goto badframe;
@@ -583,9 +589,6 @@
 	if (signr == 0)
 		return 0;		/* no signals delivered */
 
-	/* Always make any pending restarted system calls return -EINTR */
-	current_thread_info()->restart_block.fn = do_no_restart_syscall;
-
 	if ((ka->sa.sa_flags & SA_ONSTACK) && current->sas_ss_size
 	    && !on_sig_stack(regs->gpr[1]))
 		newsp = current->sas_ss_sp + current->sas_ss_size;
