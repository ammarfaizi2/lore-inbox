Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbTKOFOJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 00:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbTKOFOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 00:14:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:21158 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261473AbTKOFOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 00:14:06 -0500
Date: Fri, 14 Nov 2003 21:14:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC32: cancel syscall restart on signal delivery
In-Reply-To: <16309.46013.862161.879144@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.44.0311142108060.9014-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 15 Nov 2003, Paul Mackerras wrote:
> 
> Now, when we resume that context we will call sys_restart_syscall
> which will call restart_block.fn.  Which won't necessarily still point
> to do_no_restart_syscall.  So I still think we have a problem.

Excellent point. We're actually much better off resetting it at signal
return.

Which should make all other resets unnecessary.

Yes, you can get out of a signal by using longjmp, but that doesn't
matter: you can't longjump to a restart call (well, you can, but only if
the user literally tries to do the restart by hand, ie he _intended_ to do
it).

So the _proper_ fix (for x86) should be as appended. Agreed?

		Linus

----
===== arch/i386/kernel/signal.c 1.33 vs edited =====
--- 1.33/arch/i386/kernel/signal.c	Tue Nov 11 21:18:46 2003
+++ edited/arch/i386/kernel/signal.c	Fri Nov 14 21:13:09 2003
@@ -132,6 +132,9 @@
 {
 	unsigned int err = 0;
 
+	/* Always make any pending restarted system calls return -EINTR */
+	current_thread_info()->restart_block.fn = do_no_restart_syscall;
+
 #define COPY(x)		err |= __get_user(regs->x, &sc->x)
 
 #define COPY_SEG(seg)							\
@@ -503,9 +506,6 @@
 	struct pt_regs * regs)
 {
 	struct k_sigaction *ka = &current->sighand->action[sig-1];
-
-	/* Always make any pending restarted system calls return -EINTR */
-	current_thread_info()->restart_block.fn = do_no_restart_syscall;
 
 	/* Are we from a system call? */
 	if (regs->orig_eax >= 0) {

