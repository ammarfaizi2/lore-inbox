Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268648AbUJPGak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268648AbUJPGak (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 02:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268326AbUJPGah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 02:30:37 -0400
Received: from findaloan.ca ([66.11.177.6]:57489 "EHLO vhosts.findaloan.ca")
	by vger.kernel.org with ESMTP id S268648AbUJPGaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 02:30:24 -0400
Date: Sat, 16 Oct 2004 02:25:13 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: David Schwartz <davids@webmaster.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041016062512.GA17971@mark.mielke.cc>
Mail-Followup-To: David Schwartz <davids@webmaster.com>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <20041016043540.GA17514@mark.mielke.cc> <MDEHLPKNGKAHNMBLJOLKOELCPAAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKOELCPAAA.davids@webmaster.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 09:58:38PM -0700, David Schwartz wrote:
> > You're thinking too fast, and skipping the most important point here:
> >     1) packet was dropped earlier (or was never sent)
> >          - if select() is issued, it blocks
> >          - if recvmesg() is issued, it blocks
> >     2) packet was received, but is corrupt
> >          - if select() is issued, it does not block
> >          - if recvmesg() is issued, it blocks
> > See the problem?
> I'm talking about the case where it is dropped after the 'select' hit but
> before the call to 'recvmsg'. In that case, the select does not block but
> the recvmsg does.

You are talking about the make believe case that only exists due to
the *current* implementation of Linux UDP packet reading. It doesn't
have to exist. It exists only behaviour nobody saw fit to implement it
with semantics that were reliable, because the implentors didn't foresee
blocking file descriptors being used. It's an implementation oversight.

> > It astonishes you that somebody reads any of the UNIX manuals or
> > standards,
> > and comes to the conclusion that they can use select() and read() together
> > on a blocking file descriptor?
> The certainly can. They just have to understand what behavior they're going
> to get. If you absolutely must not ever block, you must use blocking sockets
> because the kernel cannot guarantee future behavior. Period. End of story.

We're not talking about future behaviour. We're talking about past behaviour.

That the kernel chose to delay making a decision too long to tell the truth
in select() is not reasonable for blocking sockets. The answer *MUST* be,
fix it for blocking sockets, or tell the truth, and just say - blocking
file descriptors for UDP sockets should not be used with select(). Why is
that so hard? Why all the distracting and minimizing language about
recommendations?

> > What astonishes me is how few of these limitations are openly documented.
> That is a *very* good point. But it doesn't help to deny the limitations. A
> hit on 'select' does not guarantee that a future operation will not block
> unless you have very tight control over circumstances that typical
> applications do not have tight control over.

Sure, but this isn't about the future, remember. The kernel already has the
information to know whether there is data, or whether there isn't. It just
isn't doing the work to find out.

> > Please consider the argument outside of your pre-conceived conclusion. :-)
> It does not. In fact, quite literally, the UDP packet is dropped right at
> the call to 'recvmsg'. This is totally legal behavior -- a UDP packet can be
> discarded at *any* time.

That's a liberal understanding. It's also distracting. select() could know
that the packet will be discarded. It chooses to not.

> Linux's behavior is correct in the literal sense that it is doing something
> that is allowed. It's incorrect in the sense that it's sub-optimal. However,
> it will not break any application that could not already be broken by other
> circumstances.

Allowed by who? For select() to say data is ready, and read() to block,
is not allowed by all the standards that I have read. This is the first
time I have ever heard of a situation like this, for select(). It is *not*
the same as writing an arbitrary number of bytes, or accepting.

You say it will not break any application that could not already be broken
by other circumstances. I disagree. For example, a UDP-based server that
only receives, and never sends, would be perfectly happy to select() on
several file descriptors, and readmesg() whenever the UDP file descriptor
says readable. It would not break on other operating systems that implement
select() to be useful for determining whether or not to read() from a
blocking file descriptor.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

