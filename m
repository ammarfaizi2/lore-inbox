Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265418AbUF2EdC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265418AbUF2EdC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 00:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265410AbUF2EdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 00:33:01 -0400
Received: from mail5.speakeasy.net ([216.254.0.205]:63373 "EHLO
	mail5.speakeasy.net") by vger.kernel.org with ESMTP id S265424AbUF2Ecc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 00:32:32 -0400
Date: Mon, 28 Jun 2004 21:32:30 -0700
Message-Id: <200406290432.i5T4WU7k022887@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Andrew Cagney <cagney@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86 single-step (TF) vs system calls & traps
In-Reply-To: Linus Torvalds's message of  Monday, 28 June 2004 20:55:33 -0700 <Pine.LNX.4.58.0406282049350.28764@ppc970.osdl.org>
X-Fcc: ~/Mail/linus
Emacs: because editing your files should be a traumatic experience.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > You are talking about the int $0x80 system call path here?
> > That is the only non-exception path touched by my changes.
> 
> That's still the fast path on any machine where this matters.

My question was whether this is the only path that you were referring to
when you said you refused to add any more instructions there.  I will seek
alternate solutions that avoid introducing any new instructions into fast
paths, but I want to be quite sure which you insist not to be changed.

> So the _only_ case your patch matters is for old-style binaries that use 
> "int 0x80" inline, and there that path is indeed the hot-path.

Hmm, it really sounds like you didn't read my explanation about the
sysenter case, or read the patch where I added code to handle it.

> If the system uses sysenter, it won't matter because we reload TF by hand. 

The issue does indeed arise using sysenter, as I explained and is easily
demonstrated by trying it.  I'm not sure what you mean here when you say,
"by hand".  The TF trap taken in kernel mode upon sysenter entry causes the
kernel to return using iret, which restores the TF flag in exactly the same
way as returning from other kinds of traps, and likewise executes the
following user-mode instruction.  As I've mentioned, there is no change in
the main path for sysenter entries required.  My patch changes the trap
handler for the single-step trap (in arch/i386/kernel/traps.c:do_debug) to
set the flag requesting a simulated trap before returning to user mode.

> And if it uses "int 0x80" through the trampoline, it won't matter, because 
> the "lost" instruction is part of the trampoline, and not "important" for 
> the debuggee. I think it's a "ret" instruction that gets lost, so the only 
> thing that happens is that the person "magically" returns to the caller. 

Are you referring to the signal trampoline for returning from signal
handlers?  If you are referring to some other trampoline, please clear up
my confusion.  The signal trampoline calls sigreturn, and the PC after that
system call instruction is then abandoned entirely.  What happens in the
case of single-stepping into the sigreturn system call is that (at least)
the first instruction of the restored state where the signal hit is
executed.  In practice, the sigreturn call also clears the TF bit in the
restored state unless the saved flags word has been diddled on the stack.
I submit that when using PTRACE_SINGLESTEP to enter the sigreturn system
call, the most useful thing is to get the next SIGTRAP with exactly the
state restored by the sigreturn call and no more instructions executed yet.
My patch accomplishes that, since sigreturn's clearing of TF in the
restored state doesn't clear the TIF_SINGLESTEP_TRAP kernel flag set on the
way in.

> But I bet it's not just Linux and BSD that use the Intel
> behaviour, just because it's such a pain _not_ to.

I don't think it's really so hard to make this work sanely.  It's just an
arcane thing that's easy to overlook in the initial implementation.

