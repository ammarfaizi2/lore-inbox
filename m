Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263143AbVHFCcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263143AbVHFCcy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 22:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263133AbVHFCcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 22:32:54 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:58013 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261964AbVHFCcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 22:32:46 -0400
Subject: Re: [PATCH] netpoll can lock up on low memory.
From: Steven Rostedt <rostedt@goodmis.org>
To: Matt Mackall <mpm@selenic.com>
Cc: "David S. Miller" <davem@davemloft.net>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       John B?ckstrand <sandos@home.se>
In-Reply-To: <20050806015310.GA8074@waste.org>
References: <p73ek987gjw.fsf@bragg.suse.de>
	 <1123249743.18332.16.camel@localhost.localdomain>
	 <20050805135551.GQ8266@wotan.suse.de>
	 <1123251013.18332.28.camel@localhost.localdomain>
	 <20050805141426.GU8266@wotan.suse.de>
	 <1123252591.18332.45.camel@localhost.localdomain>
	 <20050805200156.GF7425@waste.org>
	 <1123275420.18332.81.camel@localhost.localdomain>
	 <20050805212808.GV8074@waste.org>
	 <1123287835.18332.110.camel@localhost.localdomain>
	 <20050806015310.GA8074@waste.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 05 Aug 2005 22:32:28 -0400
Message-Id: <1123295548.18332.126.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 18:53 -0700, Matt Mackall wrote:
> On Fri, Aug 05, 2005 at 08:23:55PM -0400, Steven Rostedt wrote:
[...]
> > If you need to really get the data out, then the design should be
> > changed.  Have some return value showing the failure, check for
> > oops_in_progress or whatever, and try again after turning interrupts
> > back on, and getting to a point where the system can free up memory
> > (write to swap, etc).  Just a busy loop without ever getting a skb is
> > just bad.
> 
> Why, pray tell, do you think there will be a second chance after
> re-enabling interrupts? How does this work when we're panicking or
> oopsing where we most care? How does this work when the netpoll client
> is the kernel debugger and the machine is completely stopped because
> we're tracing it?

What I meant was to check for an oops and maybe then don't break out.
Otherwise let the system try to reclaim memory. Since this is locked
when the alloc_skb called with GFP_ATOMIC and fails.

> 
> As for busy loops, let me direct you to the "poll" part of the name.
> It is in fact the whole point.

In the kernel I would think that a poll would probe for an event and let
the system continue if the event hasn't arrived.  Not block all
activities until an event has arrived.

> 
> > > > So even a long timeout would not do?  So you don't even get a message to
> > > > the console?
> > > 
> > > In general, there's no way to measure time here. And if we're
> > > using netconsole, what makes you think there's any other console?
> > 
> > Why assume that there isn't another console?  The screen may be used
> > with netconsole, you just lose whatever has been scrolled too far.
> 
> Yes, there may be another console, but we should by no means depend on
> that being the case. We should in fact assume it's not.
> 
> > > > > > Also, as Andi told me, the printk here would probably not show up
> > > > > > anyway if this happens with netconsole.
> > > > > 
> > > > > That's fine. But in fact, it does show up occassionally - I've seen
> > > > > it.
> > > > 
> > > > Then maybe what Andi told me is not true ;-)
> > > > 
> > > > Oh, and did your machine crash when you saw it?  Have you seen it with
> > > > the e1000 driver?
> > > 
> > > No and no. Most of my own testing is done with tg3.
> > > 
> > 
> > If you saw the message and the system didn't crash, then that's proof
> > that if the driver is not working properly, you would have lock up the
> > system, and the system was _not_ in a state that it _had_ to get the
> > message out.
> 
> Let me be more precise. I've seen it in the middle of an oops dump,
> where it complained, then made further progress, and then died. In
> other words, the code works. And I've since upped the pool size.

OK, this is more clear than what you said previously.  When I asked if
the system crashed, I should have asked if the system was crashing.  I
thought that you meant that you saw this in normal activity with no
oops.

So, if anything, this discussion has pointed out that the e1000 has a
problem with its netpoll.  I wrote an earlier patch, but since I don't
own a e1000, someone will need to test it, or at least check to see if
it looks OK.

-- Steve


