Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVCFVOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVCFVOd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 16:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVCFVOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 16:14:33 -0500
Received: from nevyn.them.org ([66.93.172.17]:46300 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261505AbVCFVO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 16:14:27 -0500
Date: Sun, 6 Mar 2005 16:14:26 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Cagney <cagney@redhat.com>, Roland McGrath <roland@redhat.com>
Subject: Re: More trouble with i386 EFLAGS and ptrace
Message-ID: <20050306211426.GA4135@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Cagney <cagney@redhat.com>,
	Roland McGrath <roland@redhat.com>
References: <20050306193840.GA26114@nevyn.them.org> <Pine.LNX.4.58.0503061155280.2304@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503061155280.2304@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2005 at 12:03:22PM -0800, Linus Torvalds wrote:
> I _think_ your test-case would work right if you just moved that code from
> the special-case in do_debug(), and moved it to the top of
> setup_sigcontext() instead. I've not tested it, though, and haven't really 
> given it any "deep thought". Maybe somebody smarter can say "yeah, that's 
> obviously the right thing to do" or "no, that won't work because.."

I bought it, but the GDB testsuite didn't.  Both copies seem to be
necessary; there's generally no signal handler for SIGTRAP, so moving
it disables the test in the most common case.  I didn't poke at it long
enough to figure out what the failing case was, but it introduced a
different situation which could leave TF enabled. This, however,
worked:

If a debugger set the TF bit, make sure to clear it when creating a
signal context.  Otherwise, TF will be incorrectly restored by
sigreturn.

Signed-off-by: Daniel Jacobowitz <dan@debian.org>

===== arch/i386/kernel/signal.c 1.53 vs edited =====
--- 1.53/arch/i386/kernel/signal.c	2005-01-31 01:20:14 -05:00
+++ edited/arch/i386/kernel/signal.c	2005-03-06 15:36:41 -05:00
@@ -277,6 +277,18 @@
 {
 	int tmp, err = 0;
 
+	/*
+	 * If TF is set due to a debugger (PT_DTRACE), clear the TF
+	 * flag so that register information in the sigcontext is
+	 * correct.
+	 */
+	if (unlikely(regs->eflags & TF_MASK)) {
+		if (likely(current->ptrace & PT_DTRACE)) {
+			current->ptrace &= ~PT_DTRACE;
+			regs->eflags &= ~TF_MASK;
+		}
+	}
+
 	tmp = 0;
 	__asm__("movl %%gs,%0" : "=r"(tmp): "0"(tmp));
 	err |= __put_user(tmp, (unsigned int __user *)&sc->gs);

-- 
Daniel Jacobowitz
CodeSourcery, LLC
