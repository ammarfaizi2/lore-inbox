Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbVCGEtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbVCGEtd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 23:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVCGEtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 23:49:33 -0500
Received: from nevyn.them.org ([66.93.172.17]:36819 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261550AbVCGEt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 23:49:29 -0500
Date: Sun, 6 Mar 2005 23:49:20 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Cagney <cagney@redhat.com>
Subject: Re: More trouble with i386 EFLAGS and ptrace
Message-ID: <20050307044920.GA25093@nevyn.them.org>
Mail-Followup-To: Roland McGrath <roland@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Cagney <cagney@redhat.com>
References: <20050306221347.GA14194@nevyn.them.org> <200503070316.j273Gb4G027048@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503070316.j273Gb4G027048@magilla.sf.frob.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2005 at 07:16:37PM -0800, Roland McGrath wrote:
> > I think mine is more correct; the problem doesn't occur because the
> > debugger cancelled a signal, it occurs because a bogus TF bit was saved
> > to the signal context.  I like keeping solutions close to their
> > problems.  But that's just aesthetic.
> 
> I understand the scenario.  Understanding how it comes about made me
> recognize there is another scenario that is also handled wrong.  
> I didn't say the second scenario was what you are seeing.
> 
> Dan's patch covers the case of PTRACE_SINGLESTEP called to deliver a signal
> that has a handler to run.  That's because there TF is set after the ptrace
> stop, when it's resuming.  This is a "normalize register state" operation.
> I think it would be a little clearer to do this in handle_signal where the
> similar case of tweaking register state to back up a system call is done.
> 
> The patch I posted moves the resetting of TF from the trap handler to
> ptrace_signal_deliver.  This is necessary to ensure that TF is not shown as
> set in the registers retrieved by the debugger when the process stops for
> something other than the single-step trap requested by PTRACE_SINGLESTEP.

Is this semantically different from the patch I posted, i.e. is there
any case which one of them covers and not the other?

> Here is a patch that does both of those things.  This had no effect on any
> of the gdb testsuite cases (for good or ill) aside from sigstep.exp, and:
> 
> $ grep 'FAIL.*sigstep' testsuite/gdb.sum
> KFAIL: gdb.base/sigstep.exp: finish from handleri; leave handler (could not set breakpoint) (PRMS: gdb/1736)
> 
> I don't know what that one is about, but it was KFAIL before the change too.

That is an inability to set breakpoints in the vsyscall page.  Andrew
told me (last May, wow) that he thought this worked in Fedora, but I
haven't seen any signs of the code.  It would certainly be a Good Thing
if it is possible!

> 

-- 
Daniel Jacobowitz
CodeSourcery, LLC
