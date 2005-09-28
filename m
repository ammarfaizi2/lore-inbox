Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbVI1OKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbVI1OKL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 10:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbVI1OKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 10:10:11 -0400
Received: from nevyn.them.org ([66.93.172.17]:29607 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1751299AbVI1OKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 10:10:10 -0400
Date: Wed, 28 Sep 2005 10:10:08 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Davda, Bhavesh P (Bhavesh)" <bhavesh@avaya.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] New SA_NOPRNOTIF sigaction flag
Message-ID: <20050928141008.GA8196@nevyn.them.org>
Mail-Followup-To: "Davda, Bhavesh P (Bhavesh)" <bhavesh@avaya.com>,
	linux-kernel@vger.kernel.org
References: <21FFE0795C0F654FAD783094A9AE1DFC086EFEEB@cof110avexu4.global.avaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21FFE0795C0F654FAD783094A9AE1DFC086EFEEB@cof110avexu4.global.avaya.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 03:55:26PM -0600, Davda, Bhavesh P (Bhavesh) wrote:
> > On Tue, Sep 27, 2005 at 10:24:23AM -0600, Davda, Bhavesh P 
> > (Bhavesh) wrote:
> > > About the priority inversion and running the debugger at 
> > higher priority
> > > then the debuggee, that's a moot point. You're still doing too many
> > > pointless context switches to the debugger only to do 
> > nothing and switch
> > > back to the debuggee.
> > 
> > Depending on your debugger, they may not be pointless.
> 
> 
> Sorry for reiterating this, but in certain cases, yes, the context
> switch to the debugger just to have it ignore the SIGCHLD for that
> signal is pointless.

Note, this is a property of the debugging session, not a property of
the debuggee.  The debuggee can not say "no possible debugger will ever
be interested in this signal"; it doesn't make sense.

> > > Besides, putting this responsibility (ignore SIGCHLDs for 
> > signal X from
> > > Task Y) in the debugger requires the debugger to have 
> > information about
> > > the debuggee, like Task Y is special for handling signal X, and I'm
> > > going to ptrace() ignore SIGCHLD's from Task Y.
> > > 
> > > See where I'm going with this?
> > 
> > Hint: your debugger already needs to know this.  GDB already does.  It
> > has a list of signals not to bother stopping or displaying to 
> > the user.
> > SIGCHLD is on it by default.  If not, you'd see the debugger prompt
> > after each one of these context switches.
> > 
> 
> That is under user control of the person using the debugger. What I was
> talking about is control in the debuggee process/developer to say that I
> would like to spare the unnecessary overhead of notifying the debugger
> that a specific signal is being delivered to me. 
> 
> By the time GDB decides to ignore the SIGCHLD, you've already incurred
> the overhead of notifying GDB and context switching into it. Then GDB,
> in userspace, has to waitpid(), look at WIFSTOPPED(status),
> WSTOPSIG(status) and then decide to do nothing and ptrace(PTRACE_CONT)
> if the signal was one of the ignored signals. Lots of unnecessary
> overhead in this case.

Yes, I entirely understand what you're saying.  I feel like you're not
reading my responses.  GDB _already has a list of signals it does not
care about_.  If ptrace permitted, it could tell the kernel not to
context switch to deliver those signals.  In advance!  That's a
debugger-driven solution to your problem.

I'm not arguing out of theory here.  I've implemented this mechanism
before in other contexts, for instance to prevent the remote protocol
overhead for ignored signals when using gdb with gdbserver.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
