Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbVCFUBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVCFUBw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 15:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVCFUBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 15:01:52 -0500
Received: from fire.osdl.org ([65.172.181.4]:22455 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261484AbVCFUBt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 15:01:49 -0500
Date: Sun, 6 Mar 2005 12:03:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Jacobowitz <dan@debian.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Cagney <cagney@redhat.com>, Roland McGrath <roland@redhat.com>
Subject: Re: More trouble with i386 EFLAGS and ptrace
In-Reply-To: <20050306193840.GA26114@nevyn.them.org>
Message-ID: <Pine.LNX.4.58.0503061155280.2304@ppc970.osdl.org>
References: <20050306193840.GA26114@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 6 Mar 2005, Daniel Jacobowitz wrote:
> 
> The reason this happens is that when the inferior hits a breakpoint, the
> first thing GDB will do is remove the breakpoint, single-step past it, and
> reinsert it.  So GDB does a PTRACE_SINGLESTEP, and the kernel invokes the
> signal handler (without single-step - good so far).

No, not good so far.

Yes, it cleared TF, but it saved eflags with TF set on-stack, even though 
the TF was due to a TIF_SINGLESTEP (and was thus "temporary", not a real 
flag). That's why you see the bogus SIGTRAP after returning from the 
signal handler.

Now, we actually get this _right_ if the signal is due to a single-step, 
because do_debug() will do:

                if (likely(tsk->ptrace & PT_DTRACE)) {
                        tsk->ptrace &= ~PT_DTRACE;
                        regs->eflags &= ~TF_MASK;
                }

but that's the only place we do that. So any _other_ signal won't do this, 
and we'll enter the signal handler without checking the PT_DTRACE flag to 
see if TF was a temporary thing from debugger rather than something the 
program actually did on its own.

I _think_ your test-case would work right if you just moved that code from
the special-case in do_debug(), and moved it to the top of
setup_sigcontext() instead. I've not tested it, though, and haven't really 
given it any "deep thought". Maybe somebody smarter can say "yeah, that's 
obviously the right thing to do" or "no, that won't work because.."

		Linus
