Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267370AbTAGLHT>; Tue, 7 Jan 2003 06:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267372AbTAGLHT>; Tue, 7 Jan 2003 06:07:19 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:48028 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S267370AbTAGLHS>;
	Tue, 7 Jan 2003 06:07:18 -0500
Date: Tue, 7 Jan 2003 11:19:05 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Zack Weinberg <zack@codesourcery.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] Set TIF_IRET in more places
Message-ID: <20030107111905.GA949@bjl1.asuk.net>
References: <87isx2dktj.fsf@egil.codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87isx2dktj.fsf@egil.codesourcery.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zack Weinberg wrote:
> Consider SA_RESTORER - there isn't a guarantee that user space will
> use the same code as the kernel's trampoline.  glibc happens to, but
> only because GDB has a hardwired idea of what a signal trampoline
> looks like.  Of course, you could simply document that sigreturn() is
> another of the system calls that must be made through int 0x80.

Glibc must use the same code as the kernel's trampoline because of
MD_FALLBACK_FRAME_STATE_FOR() in GCC's exception handling...  (or
libgcc.so must change).

It explicitly checks for the opcode sequences 0x58b877000000cd80 and
0xb8ad000000cd80 in order to unwind exception frames around a
handled signal.  Ugly, isn't it?

> It occurs to me that the kernel-provided signal trampoline could go in
> the page at 0xffff0000, instead of on the user stack, which would
> eliminate the need for glibc to set SA_RESTORER (it's a pure
> optimization).

Yup.

> Tangentially, I've seen people claim that the trampoline ought to be
> able to avoid entering the kernel, although I'm not convinced (how
> does the signal mask get reset, otherwise?)

Welcome to a wonderful if rather unsightly optimisation:

   1. libc installs its own handler function for all non-SIG_DFL signals,
      and sigaction() mostly updates a table in userspace.

   2. The libc signal handler redirects all signals to the application
      through a funky trampoline in libc.

   3. A signal mask is maintained in userspace.  Also, a pending mask
      is maintained in userspace.

   4. When a signal is delivered, libc's handler function checks the
      userspace signal mask.  If the signal should be blocked, and it
      is possible to block it, it is marked as pending in _userspace_
      pending mask, and the userspace signal mask is propagated to the
      kernel to prevent further signals queuing up.  Any siginfo_t is
      also saved for tha signa.  Then libc's handler returns, without
      calling the application handler (because that is deferred).

   5. When a signal is unblocked from the userspace signal mask, if it
      is in the userspace pending mask, it is synthetically delivered
      by userspace, which creates a context _as if_ the kernel had
      delivered the signal.

By this mechanism, calls to unblock signals from the signal mask can
be done without entering the kernel, because the unblocking can be
done lazily.

Voila!  sigreturn() can be written to avoid entering the kernel.  Note
that this is possible _now_, with no changes to the kernel.  It only
requires changes to libc.  I think it would work on all architectures,
not just i386.  (It may also be possible to do it without libc help,
in the vsyscall page).

-- Jamie

ps. A similar optimisation allows "spin_lock_irqsave" and
"spin_unlock_irqrestore" to avoid using the cli & sti instructions.
Spin locks already modify the preempt_count, so use a bit of that to
hold the synthetic interrupt-disabled flag, at zero cost... :)
