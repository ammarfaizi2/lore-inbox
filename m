Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVCFU0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVCFU0i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 15:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVCFU0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 15:26:35 -0500
Received: from nevyn.them.org ([66.93.172.17]:4797 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261490AbVCFU0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 15:26:31 -0500
Date: Sun, 6 Mar 2005 15:26:41 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Cagney <cagney@redhat.com>
Subject: Re: More trouble with i386 EFLAGS and ptrace
Message-ID: <20050306202641.GA26963@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org, Andrew Cagney <cagney@redhat.com>
References: <20050306193840.GA26114@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050306193840.GA26114@nevyn.them.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2005 at 02:38:41PM -0500, Daniel Jacobowitz wrote:
> The reason this happens is that when the inferior hits a breakpoint, the
> first thing GDB will do is remove the breakpoint, single-step past it, and
> reinsert it.  So GDB does a PTRACE_SINGLESTEP, and the kernel invokes the
> signal handler (without single-step - good so far).  When the signal handler
> returns, we've lost track of the fact that ptrace set the single-step flag,
> however.  So the single-step completes and returns SIGTRAP to GDB.  GDB is
> expecting a SIGTRAP and reinserts the breakpoint.  Then it resumes the
> inferior, but now the trap flag is set in $eflags.  So, oops, the continue
> acts like a step instead.

Eh, I got the event sequence wrong as usual, but the basic description
is right.

- Original SIGTRAP at breakpoint
- user says "cont"
- GDB tries to singlestep past the breakpoint - PTRACE_SINGLESTEP, no
  signal
- GDB receives SIGALRM at the same PC
- GDB tries to singlestep past the breakpoint - PTRACE_SINGLESTEP,
  SIGALRM
- GDB receives SIGTRAP at the first instruction of the handler
- GDB reinserts the breakpoint at line 18.  This is a "step-resume"
  breakpoint - we were stepping, we were interrupted by a signal.
- GDB issues PTRACE_CONT, no signal
- GDB receives SIGTRAP at the sigreturn location - this is the
  step-resume breakpoint.
- GDB remove that and issues PTRACE_SINGLESTEP, no signal - It
  is trying again to get past the breakpoint location so that it
  can honor the user's "cont" request.
- GDB receives SIGTRAP at the instruction after the breakpoint.
- GDB reinserts the original breakpoint and issues PTRACE_CONTINUE.

All of this is what's supposed to happen.  The executable be running
free now until it hits the breakpoint again.

- GDB receives an unexpected SIGTRAP at the next instruction (the
  second instruction after the original breakpoint).

If your compiler uses only two instructions for the loop, you might not
see this.  gcc -O0 will use three by default.  Just stick something
else in the loop.

> What to do?  We need to know when we restore the trap bit in sigreturn
> whether it was set by ptrace or by the application (possibly including by
> the signal handler).

If I'm following this right, then the saved value of eflags in the
signal handler should not contain the trap bit at this point.  It does,
though.  It's hard to see this in GDB, because the CFI does not express
%eflags, so "print $eflags" won't track up the stack.  I don't think
there's a handy dwarf register number for it at the moment.  But you
can print out the struct sigcontext by hand once you locate it on the
stack.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
