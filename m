Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVCFWNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVCFWNw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 17:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVCFWNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 17:13:52 -0500
Received: from nevyn.them.org ([66.93.172.17]:39395 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261474AbVCFWNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:13:50 -0500
Date: Sun, 6 Mar 2005 17:13:47 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Cagney <cagney@redhat.com>
Subject: Re: More trouble with i386 EFLAGS and ptrace
Message-ID: <20050306221347.GA14194@nevyn.them.org>
Mail-Followup-To: Roland McGrath <roland@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Cagney <cagney@redhat.com>
References: <Pine.LNX.4.58.0503061155280.2304@ppc970.osdl.org> <200503062122.j26LMP5F021846@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503062122.j26LMP5F021846@magilla.sf.frob.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2005 at 01:22:25PM -0800, Roland McGrath wrote:
> > I _think_ your test-case would work right if you just moved that code from
> > the special-case in do_debug(), and moved it to the top of
> > setup_sigcontext() instead. I've not tested it, though, and haven't really 
> > given it any "deep thought". Maybe somebody smarter can say "yeah, that's 
> > obviously the right thing to do" or "no, that won't work because.."
> 
> Indeed, this is what my original changes for this did, before you started
> cleaning things up to be nice to TF users other than PTRACE_SINGLESTEP. 
> 
> I note, btw, that the x86_64 code is still at that prior stage.  So I think
> it doesn't have this new wrinkle, but it also doesn't have the advantages
> of the more recent i386 changes.  Once we're sure about the i386 state, we
> should update the x86_64 code to match.
> 
> I'm not sure what kind of smart this makes me, but I'll say that your plan
> would work and no, it's obviously not the right thing to do. ;-) I haven't
> tested the following, not having tracked down the specific problem case you
> folks are talking about.  But I think this is the right solution.  The
> difference is that when we stop for some signal and report to the debugger,
> the debugger looking at our registers will see TF clear instead of set,
> before it decides whether to continue us with the signal or what to do.
> With the change yo suggested, (I think) if the debugger decides to eat the
> signal and resume, we would get a spurious single-step trap after executing
> the next instruction, instead of resuming normally as requested.

Roland, the sigstep.exp test in the GDB testsuite will show this
problem; if your patch monotonically improves GDB HEAD testsuite
results and removes all the FAILs for sigstep.exp, then it's probably
equivalent to the one I just posted for this testcase.

I think mine is more correct; the problem doesn't occur because the
debugger cancelled a signal, it occurs because a bogus TF bit was saved
to the signal context.  I like keeping solutions close to their
problems.  But that's just aesthetic.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
