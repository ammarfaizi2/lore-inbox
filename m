Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbVHEU5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbVHEU5Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 16:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263066AbVHEU5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 16:57:25 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:22435 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261988AbVHEU5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 16:57:23 -0400
Subject: Re: [PATCH] netpoll can lock up on low memory.
From: Steven Rostedt <rostedt@goodmis.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, John B?ckstrand <sandos@home.se>
In-Reply-To: <20050805200156.GF7425@waste.org>
References: <42F347D2.7000207@home.se.suse.lists.linux.kernel>
	 <p73ek987gjw.fsf@bragg.suse.de>
	 <1123249743.18332.16.camel@localhost.localdomain>
	 <20050805135551.GQ8266@wotan.suse.de>
	 <1123251013.18332.28.camel@localhost.localdomain>
	 <20050805141426.GU8266@wotan.suse.de>
	 <1123252591.18332.45.camel@localhost.localdomain>
	 <20050805200156.GF7425@waste.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 05 Aug 2005 16:57:00 -0400
Message-Id: <1123275420.18332.81.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 13:01 -0700, Matt Mackall wrote:
> On Fri, Aug 05, 2005 at 10:36:31AM -0400, Steven Rostedt wrote:
> > Looking at the netpoll routines, I noticed that the find_skb could
> > lockup if the memory is low. This is because the allocations are
> > called with GFP_ATOMIC (since this is in interrupt context) and if
> > it fails, it will continue to fail. This is just by observing the
> > code, I didn't have this actually happen. So if this is not the
> > case, please let me know how it can get out. Otherwise, please
> > accept this patch.
> 
> By netpoll_poll() tickling the driver enough to free the currently
> queued outgoing SKBs.

I believe that the e1000 wont free up any outgoing packets since the
netpoll call doesn't seem to get to the e1000_clean_tx part of the
e1000_intr, otherwise the system wouldn't lock under the
netpoll_send_skb when one disconnects the wire and puts it back in.  The
disconnect would lock it up anyway (with Andi's patch it now doesn't)
but since it won't come back up after the link is back up, there seems
to be something wrong with the e1000 netpoll driver.  This is because
the e1000_netpoll doesn't seem to be cleaning up the tx buffer and start
the queue back up.

> 
> Also note that by the time we're in this loop, we're ready to take
> desperate measures. We've already exhausted our private queue of SKBs
> so we have no alternative but to keep kicking the driver until
> something happens.

OK, the system is under heavy memory load and starts eating up the
netpoll packets.  When the last packet is gone, and you have something
like the e1000 that doesn't clean up its packets with netpoll, then you
just locked up the system.

The scary part of this loop is that if the netpoll doesn't come up with
the goods, its game over.  Say we are at desperate measures but it could
be a case where we need to output more information and lockup here
before we can go out and free some memory. 

> 
> The netpoll philosophy is to assume that its traffic is an absolute
> priority - it is better to potentially hang trying to deliver a panic
> message than to give up and crash silently.

So even a long timeout would not do?  So you don't even get a message to
the console?

> 
> > Also, as Andi told me, the printk here would probably not show up
> > anyway if this happens with netconsole.
> 
> That's fine. But in fact, it does show up occassionally - I've seen
> it.

Then maybe what Andi told me is not true ;-)

Oh, and did your machine crash when you saw it?  Have you seen it with
the e1000 driver?

> 
> NAK'ed.
> 
(ouch!)

OK, since my argument is currently only theory, and I don't have a e1000
card to test this on, I'll take out my fix to the e100 (where it cleaned
up it's tx drivers in netpoll) and see if I can get the machine to
lockup here just by putting it under extreme memory loads.

-- Steve


