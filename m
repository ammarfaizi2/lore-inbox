Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266347AbUFYX2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266347AbUFYX2j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 19:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266890AbUFYX2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 19:28:38 -0400
Received: from waste.org ([209.173.204.2]:47759 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S266347AbUFYX1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 19:27:19 -0400
Date: Fri, 25 Jun 2004 18:27:11 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: netconsole hangs w/ alt-sysrq-t
Message-ID: <20040625232711.GE25826@waste.org>
References: <16519.58589.773562.492935@segfault.boston.redhat.com> <20040425191543.GV28459@waste.org> <16527.42815.447695.474344@segfault.boston.redhat.com> <20040428140353.GC28459@waste.org> <16527.47765.286783.249944@segfault.boston.redhat.com> <20040428142753.GE28459@waste.org> <16527.63123.869014.733258@segfault.boston.redhat.com> <16604.18881.850162.785970@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16604.18881.850162.785970@segfault.boston.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 11:50:25AM -0400, Jeff Moyer wrote:
> ==> Regarding Re: netconsole hangs w/ alt-sysrq-t; Jeff Moyer <jmoyer@redhat.com> adds:
> 
> ==> Regarding Re: netconsole hangs w/ alt-sysrq-t; Matt Mackall <mpm@selenic.com> adds:
> jmoyer> [snip]
> 
> mpm> Well process context defeats the purpose. Ok, I've more closely read
> mpm> your report and if I understand correctly, you're using the NAPI
> mpm> version of e100? There's some magic NAPI bits in netpoll_poll that
> mpm> might help here:
> >>> Yes, sorry I didn't specify that earlier.
> >>> 
> mpm> if(trapped && np->dev->poll && test_bit(__LINK_STATE_RX_SCHED,
> mpm> &np->dev->state))
> np-> dev->poll(np->dev, &budget);
> >>>
> mpm> Perhaps we need to pull the trapped test out of there. Then with any
> mpm> luck, dev->hard_start_xmit will return non-zero in netpoll_send_skb,
> mpm> we'll call netpoll_poll to pump the card, and we'll be able to flush
> mpm> it.
> >>> I don't think so.  You can end up in code running in interrupt context
> >>> that is not designed to (ip routing code, etc).  I've been down that
> >>> path already.  I only defer to process context if irqs_disabled().
> 
> mpm> Fair enough. Turning on trapped basically short circuits the rest of
> mpm> the NAPI code so that stuff doesn't hit the stack when we call ->poll.
> mpm> Could you try doing a netpoll_set_trap(1)/(0) around the call to
> mpm> ->poll and see if that actually lets the thing work? Then we can try
> mpm> to figure out the right way to do this.
> 
> You will still hit the stack in the case of netconsole, since it doesn't
> register an rx hook and netif_receive_skb has this:
> 
> #ifdef CONFIG_NETPOLL_RX
> 	if (skb->dev->netpoll_rx && skb->dev->poll && netpoll_rx(skb)) {
> 		kfree_skb(skb);
> 		return NET_RX_DROP;
> 	}
> #endif

Ok, that is indeed a problem.
 
> So we fall through and end up calling code which doesn't want to run in
> interrupt context.
> 
> One solution that I've come up with, but may not be in the spirit of
> netpoll, is to change that test above to the following:
> 
> 	if (unlikely(netpoll_trap())) {
> 		if (skb->dev->netpoll_rx && skb->dev->poll)
> 			netpoll_rx(skb);
> 		kfree_skb(skb);
> 		return NET_RX_DROP;
> 	}
>
> This changes semantics, in that the rx routine will only be called if we've
> decided to "trap" the network stack.  Note also that this will cause us to
> drop packets while doing our logging.

Huh. I'm not sure if that covers everything.

We want to: 

a) push stuff through netpoll_rx() iff rx is enabled
b) drop packets when netpoll_rx() says to
c) drop packets when we're trapped for debugging/netdump
d) drop packets when we manually call dev->poll
e) keep as little overhead as possible

The above breaks (a) when we're not trapped (consider breaking in with
debugger) and (b) in any case.

My current thought is we want to get this down to a single test in the
fastpath by replacing netpoll_rx in skb->dev with a flag that is equal
to netpoll_trapped() | dev->netpoll_rx, which we manipulate when call
dev->poll within netpoll. 

How's that sound?

-- 
Mathematics is the supreme nostalgia of our time.
