Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVEZVYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVEZVYj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 17:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVEZVYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 17:24:38 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:64012 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261753AbVEZVYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 17:24:01 -0400
Date: Thu, 26 May 2005 14:28:37 -0700
To: Andi Kleen <ak@muc.de>
Cc: Sven-Thorsten Dietrich <sdietrich@mvista.com>, Ingo Molnar <mingo@elte.hu>,
       dwalker@mvista.com, bhuey@lnxw.com, nickpiggin@yahoo.com.au,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050526212837.GB3776@nietzsche.lynx.com>
References: <1116982977.19926.63.camel@dhcp153.mvista.com> <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com> <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu> <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050526202747.GB86087@muc.de>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2005 at 10:27:47PM +0200, Andi Kleen wrote:
> I really dislike the idea of interrupt threads. It seems totally
> wrong to me to make such a fundamental operation as an interrupt
> much slower.  If really any interrupts take too long they should
> move to workqueues instead and be preempted there. But keep
> the basic fundamental operations fast please (at least that used to be one
> of the Linux mottos that served it very well for many years, although more
> and more people seem to forget it now) 

Again, it's about a bottom-up verses top-down approach to maintaining
this logic. To reiterate what both Ingo and Sven previously stated,
it isn't possible to do all of this per path and lock in any sane manner.
This extends to all of the drivers in Linux as well.

> Most spinlocks only protect small code parts. Those that protect
> larger codes can probably use optionally some different lock.

The problem with that is that it violates the "sleeping in atomic"
deadlock constraint in that the lock graph enforces a hierarchial
ordering downward, where an atomic lock forces all locks below it to
be also non-preemptible. There are at least 3+ critical sections
that needed to be made preemptible before the rest of the graph can
be correctly preemptible.

I found this out the week before Ingo did his stuff since I was one
of three projects during that time doing this mass retrofit. My project
is seldom mentioned any more since don't post publically very much,
moved to Ingo's tree and have been working on things internally here.
But I had my stuff running in May of last year against 2.6.0, so I was
one of the first folks to see the value of this path and the push into
the problem space. Much of my reasoning is derived from FreeBSD 5.x

> But dont attack it with "one size fits all" locking please.
 
> > In addition, there are lock-ordering and lock-nesting issues (not to be
> > confused with the Scottish sea creature :) that make this approach non-
> > trivial whatsoever.
> 
> Hmm? Sorry that didnt make any sense. If the code was correct
> before changing to a different spin like type should not
> make any difference.
> 
> The only problem you have is interrupt code, which cannot sleep,
> but I dont think you will eventually get around of fixing these
> properly (= checking the code if it is slow and yes move it 
> over and if not leave it alone) 

See Above.
 
> Of course you would not do it as a big patch. Instead you do it one
> by one, every time you identify a problem you submit a patch, it gets
> accepted etc.

Again, (Sven and Ingo) it's impossible to do since the kernel is so
complicate and the interdependencies of locks in the lock graph make
this track effectively impossible when using your manner of attack.

> This way you never have a big pile of patches, just a small patchset in a current
> queue. 
> 
> Of course big patches dont work, but there is no reason you have to keep
> big patches for this.
> 
> That is how most other Linux maintainers work too. Why should that code
> be any different?
> 
> It sounds to me like you did not understand how Linux kernel code 
> submission is

... 

> If you tried it with a big patchkit I am not surprised that the approach
> didnt work. But did you ever consider the problem might be with the
> way you submitted patches, not with the basic code?

The problem here is not the patch, but instead random hysteria from folks
that don't know the patch and haven't tracked development that are yelping
about fringe problems without an understanding the approach and things
that it address without any completeness

The concepts and suggestion here are not radical. There's plenty of
precedence from traditional RTOSes and other general purpose systems
(FreeBSD 5.x/Solaris/SGI IRIX) that uses these techiques. But the
hysteria around this stuff has really create impressions of what "not to
do in the kernel" without any real or substantial facts otherwise.

The entire debate from both sides is full of misunderstandings and
misconceptions of each approach. Most of it is completely irrational
paranoia from folks that are use to one way of doing things verses
actually looking at the approach from this group's point of view.

Until this is more widely incorporated or used, it's still going to have
what I believe to be a false stigma against it.

bill

