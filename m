Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263135AbVHFBxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263135AbVHFBxf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 21:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263133AbVHFBxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 21:53:35 -0400
Received: from waste.org ([216.27.176.166]:2467 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261862AbVHFBxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 21:53:33 -0400
Date: Fri, 5 Aug 2005 18:53:11 -0700
From: Matt Mackall <mpm@selenic.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, John B?ckstrand <sandos@home.se>
Subject: Re: [PATCH] netpoll can lock up on low memory.
Message-ID: <20050806015310.GA8074@waste.org>
References: <p73ek987gjw.fsf@bragg.suse.de> <1123249743.18332.16.camel@localhost.localdomain> <20050805135551.GQ8266@wotan.suse.de> <1123251013.18332.28.camel@localhost.localdomain> <20050805141426.GU8266@wotan.suse.de> <1123252591.18332.45.camel@localhost.localdomain> <20050805200156.GF7425@waste.org> <1123275420.18332.81.camel@localhost.localdomain> <20050805212808.GV8074@waste.org> <1123287835.18332.110.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123287835.18332.110.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 08:23:55PM -0400, Steven Rostedt wrote:
> On Fri, 2005-08-05 at 14:28 -0700, Matt Mackall wrote:
> > 
> > Netpoll generally must assume it won't get a second chance, as it's
> > being called by things like oops() and panic() and used by things like
> > kgdb. If netpoll fails, the box is dead anyway.
> 
> But it is also being called by every printk in the kernel. What happens
> when the printk that causes this lock up is not a panic but just some
> info print.  One would use netconsole when they turn on more verbose
> printing, to keep the output fast, right?  So if the system gets a
> little memory tight, but not to the point of failing, this will cause a
> lock up and no one would know why. 

This doesn't happen, or if it does, it happens far less often than
genuine crashes. This can only happen when netpoll's burned through
its entire pool of SKBs in a single interrupt and the card never
releases them, despite repeated prodding. In other words, you'll get
most of a dump out of the box, but you're probably screwed no matter
what you do.

Also note that _any_ printk can be the kernel's dying breath. This is
why for both serial and video we do polled I/O to be sure we actually
get our message out. Netconsole is no different.

> If you need to really get the data out, then the design should be
> changed.  Have some return value showing the failure, check for
> oops_in_progress or whatever, and try again after turning interrupts
> back on, and getting to a point where the system can free up memory
> (write to swap, etc).  Just a busy loop without ever getting a skb is
> just bad.

Why, pray tell, do you think there will be a second chance after
re-enabling interrupts? How does this work when we're panicking or
oopsing where we most care? How does this work when the netpoll client
is the kernel debugger and the machine is completely stopped because
we're tracing it?

As for busy loops, let me direct you to the "poll" part of the name.
It is in fact the whole point.

> > > So even a long timeout would not do?  So you don't even get a message to
> > > the console?
> > 
> > In general, there's no way to measure time here. And if we're
> > using netconsole, what makes you think there's any other console?
> 
> Why assume that there isn't another console?  The screen may be used
> with netconsole, you just lose whatever has been scrolled too far.

Yes, there may be another console, but we should by no means depend on
that being the case. We should in fact assume it's not.

> > > > > Also, as Andi told me, the printk here would probably not show up
> > > > > anyway if this happens with netconsole.
> > > > 
> > > > That's fine. But in fact, it does show up occassionally - I've seen
> > > > it.
> > > 
> > > Then maybe what Andi told me is not true ;-)
> > > 
> > > Oh, and did your machine crash when you saw it?  Have you seen it with
> > > the e1000 driver?
> > 
> > No and no. Most of my own testing is done with tg3.
> > 
> 
> If you saw the message and the system didn't crash, then that's proof
> that if the driver is not working properly, you would have lock up the
> system, and the system was _not_ in a state that it _had_ to get the
> message out.

Let me be more precise. I've seen it in the middle of an oops dump,
where it complained, then made further progress, and then died. In
other words, the code works. And I've since upped the pool size.

-- 
Mathematics is the supreme nostalgia of our time.
