Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265009AbUF1PUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265009AbUF1PUQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 11:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265025AbUF1PUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 11:20:16 -0400
Received: from waste.org ([209.173.204.2]:29662 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S265009AbUF1PUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 11:20:04 -0400
Date: Mon, 28 Jun 2004 10:19:55 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: netconsole hangs w/ alt-sysrq-t
Message-ID: <20040628151954.GH25826@waste.org>
References: <16519.58589.773562.492935@segfault.boston.redhat.com> <20040425191543.GV28459@waste.org> <16527.42815.447695.474344@segfault.boston.redhat.com> <20040428140353.GC28459@waste.org> <16527.47765.286783.249944@segfault.boston.redhat.com> <20040428142753.GE28459@waste.org> <16527.63123.869014.733258@segfault.boston.redhat.com> <16604.18881.850162.785970@segfault.boston.redhat.com> <20040625232711.GE25826@waste.org> <16608.12233.39964.940020@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16608.12233.39964.940020@segfault.boston.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 10:48:41AM -0400, Jeff Moyer wrote:
> ==> Regarding Re: netconsole hangs w/ alt-sysrq-t; Matt Mackall <mpm@selenic.com> adds:
> 
> [snip]
> 
> mpm> Huh. I'm not sure if that covers everything.
> 
> mpm> We want to:
> 
> mpm> a) push stuff through netpoll_rx() iff rx is enabled b) drop packets
> mpm> when netpoll_rx() says to c) drop packets when we're trapped for
> mpm> debugging/netdump d) drop packets when we manually call dev->poll e)
> mpm> keep as little overhead as possible
> 
> mpm> The above breaks (a) when we're not trapped (consider breaking in with
> mpm> debugger) and (b) in any case.
> 
> mpm> My current thought is we want to get this down to a single test in the
> mpm> fastpath by replacing netpoll_rx in skb->dev with a flag that is equal
> mpm> to netpoll_trapped() | dev->netpoll_rx, which we manipulate when call
> dev-> poll within netpoll.
> 
> mpm> How's that sound?
> 
> That sounds fine.  So, in the netif_receive_skb function, we'd now have
> something like:
> 
> 	if (skb->dev->netpoll_rx && netpoll_rx(skb)) {
> 		kfree_skb(skb);
> 		return NET_RX_DROP;
> 	}
> 
> I removed the test for skb->dev->poll, since this is the NAPI code path, I
> think it should always be present, right?

No, I think we get to this on the non-NAPI route as well. The ->poll
check keeps us from filtering twice.

> And then at the top of the netpoll_rx routine:
> 
> 	if (!(skb->dev->netpoll_rx & NETPOLL_RX_ENABLED))
> 		goto out;

Let's explicitly return 1.
 
> The routine, as before, returns the value of trapped.  And now,
> netpoll_poll would do this:
> 
> 	if(np->dev->poll && test_bit(__LINK_STATE_RX_SCHED, &np->dev->state)) {
> 		np->dev->netpoll_rx |= NETPOLL_RX_TRAPPED;
> 		if (trapped)
> 			np->dev->poll(np->dev, &budget);
> 		else {
> 			trapped = 1;
> 			np->dev->poll(np->dev, &budget);
> 			trapped = 0;
> 		}
> 		np->dev->netpoll_rx &= ~NETPOLL_RX_TRAPPED;
> 	}
> 
> Is this more in line with what you had in mind? 

Yes. Let's make that NETPOLL_RX_DROP to disambiguate the
trapped/dropped-for-polling. And we can do a simple
increment/decrement on trapped itself - but do we still need it here
now that we've shorted out the NAPI path with RX_DROP?

There might be some new atomicity or memory barrier issues here, be
mindful.

> One thing I would consider changing, here, is having
> netpoll_set_trap take a struct netpoll argument. That way, we could
> have netpoll_set_trap manipulate the NETPOLL_RX_TRAPPED bit. This
> would make the trap specific to each interface, but I think that may
> be desirable.

It doesn't really make sense for trapped to be non-global - it means
the machine is in polling-only mode, eg debugger or the like. It's
rather misusing it to kill the NAPI receive side for netpoll_poll.

-- 
Mathematics is the supreme nostalgia of our time.
