Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263127AbVHEVa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263127AbVHEVa3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 17:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263135AbVHEVaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 17:30:24 -0400
Received: from waste.org ([216.27.176.166]:16618 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263130AbVHEV2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 17:28:31 -0400
Date: Fri, 5 Aug 2005 14:28:08 -0700
From: Matt Mackall <mpm@selenic.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, John B?ckstrand <sandos@home.se>
Subject: Re: [PATCH] netpoll can lock up on low memory.
Message-ID: <20050805212808.GV8074@waste.org>
References: <42F347D2.7000207@home.se.suse.lists.linux.kernel> <p73ek987gjw.fsf@bragg.suse.de> <1123249743.18332.16.camel@localhost.localdomain> <20050805135551.GQ8266@wotan.suse.de> <1123251013.18332.28.camel@localhost.localdomain> <20050805141426.GU8266@wotan.suse.de> <1123252591.18332.45.camel@localhost.localdomain> <20050805200156.GF7425@waste.org> <1123275420.18332.81.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123275420.18332.81.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 04:57:00PM -0400, Steven Rostedt wrote:
> On Fri, 2005-08-05 at 13:01 -0700, Matt Mackall wrote:
> > On Fri, Aug 05, 2005 at 10:36:31AM -0400, Steven Rostedt wrote:
> > > Looking at the netpoll routines, I noticed that the find_skb could
> > > lockup if the memory is low. This is because the allocations are
> > > called with GFP_ATOMIC (since this is in interrupt context) and if
> > > it fails, it will continue to fail. This is just by observing the
> > > code, I didn't have this actually happen. So if this is not the
> > > case, please let me know how it can get out. Otherwise, please
> > > accept this patch.
> > 
> > By netpoll_poll() tickling the driver enough to free the currently
> > queued outgoing SKBs.
> 
> I believe that the e1000 wont free up any outgoing packets since the
> netpoll call doesn't seem to get to the e1000_clean_tx part of the
> e1000_intr, otherwise the system wouldn't lock under the
> netpoll_send_skb when one disconnects the wire and puts it back in.  The
> disconnect would lock it up anyway (with Andi's patch it now doesn't)
> but since it won't come back up after the link is back up, there seems
> to be something wrong with the e1000 netpoll driver.  This is because
> the e1000_netpoll doesn't seem to be cleaning up the tx buffer and start
> the queue back up.

That does seem like a driver problem.

> > Also note that by the time we're in this loop, we're ready to take
> > desperate measures. We've already exhausted our private queue of SKBs
> > so we have no alternative but to keep kicking the driver until
> > something happens.
> 
> OK, the system is under heavy memory load and starts eating up the
> netpoll packets.  When the last packet is gone, and you have something
> like the e1000 that doesn't clean up its packets with netpoll, then you
> just locked up the system.
> 
> The scary part of this loop is that if the netpoll doesn't come up with
> the goods, its game over.  Say we are at desperate measures but it could
> be a case where we need to output more information and lockup here
> before we can go out and free some memory. 

Realistically, we were probably going to crash anyway at this point as
we're apparently failing to recycle SKBs.

Netpoll generally must assume it won't get a second chance, as it's
being called by things like oops() and panic() and used by things like
kgdb. If netpoll fails, the box is dead anyway.

> > The netpoll philosophy is to assume that its traffic is an absolute
> > priority - it is better to potentially hang trying to deliver a panic
> > message than to give up and crash silently.
> 
> So even a long timeout would not do?  So you don't even get a message to
> the console?

In general, there's no way to measure time here. And if we're
using netconsole, what makes you think there's any other console?

> > > Also, as Andi told me, the printk here would probably not show up
> > > anyway if this happens with netconsole.
> > 
> > That's fine. But in fact, it does show up occassionally - I've seen
> > it.
> 
> Then maybe what Andi told me is not true ;-)
> 
> Oh, and did your machine crash when you saw it?  Have you seen it with
> the e1000 driver?

No and no. Most of my own testing is done with tg3.

-- 
Mathematics is the supreme nostalgia of our time.
