Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264984AbUF1OvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264984AbUF1OvQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 10:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264991AbUF1OvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 10:51:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24798 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264984AbUF1Ouw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 10:50:52 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16608.12233.39964.940020@segfault.boston.redhat.com>
Date: Mon, 28 Jun 2004 10:48:41 -0400
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: netconsole hangs w/ alt-sysrq-t
In-Reply-To: <20040625232711.GE25826@waste.org>
References: <16519.58589.773562.492935@segfault.boston.redhat.com>
	<20040425191543.GV28459@waste.org>
	<16527.42815.447695.474344@segfault.boston.redhat.com>
	<20040428140353.GC28459@waste.org>
	<16527.47765.286783.249944@segfault.boston.redhat.com>
	<20040428142753.GE28459@waste.org>
	<16527.63123.869014.733258@segfault.boston.redhat.com>
	<16604.18881.850162.785970@segfault.boston.redhat.com>
	<20040625232711.GE25826@waste.org>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: netconsole hangs w/ alt-sysrq-t; Matt Mackall <mpm@selenic.com> adds:

[snip]

mpm> Huh. I'm not sure if that covers everything.

mpm> We want to:

mpm> a) push stuff through netpoll_rx() iff rx is enabled b) drop packets
mpm> when netpoll_rx() says to c) drop packets when we're trapped for
mpm> debugging/netdump d) drop packets when we manually call dev->poll e)
mpm> keep as little overhead as possible

mpm> The above breaks (a) when we're not trapped (consider breaking in with
mpm> debugger) and (b) in any case.

mpm> My current thought is we want to get this down to a single test in the
mpm> fastpath by replacing netpoll_rx in skb->dev with a flag that is equal
mpm> to netpoll_trapped() | dev->netpoll_rx, which we manipulate when call
dev-> poll within netpoll.

mpm> How's that sound?

That sounds fine.  So, in the netif_receive_skb function, we'd now have
something like:

	if (skb->dev->netpoll_rx && netpoll_rx(skb)) {
		kfree_skb(skb);
		return NET_RX_DROP;
	}

I removed the test for skb->dev->poll, since this is the NAPI code path, I
think it should always be present, right?

And then at the top of the netpoll_rx routine:

	if (!(skb->dev->netpoll_rx & NETPOLL_RX_ENABLED))
		goto out;

The routine, as before, returns the value of trapped.  And now,
netpoll_poll would do this:

	if(np->dev->poll && test_bit(__LINK_STATE_RX_SCHED, &np->dev->state)) {
		np->dev->netpoll_rx |= NETPOLL_RX_TRAPPED;
		if (trapped)
			np->dev->poll(np->dev, &budget);
		else {
			trapped = 1;
			np->dev->poll(np->dev, &budget);
			trapped = 0;
		}
		np->dev->netpoll_rx &= ~NETPOLL_RX_TRAPPED;
	}

Is this more in line with what you had in mind?  One thing I would consider
changing, here, is having netpoll_set_trap take a struct netpoll argument.
That way, we could have netpoll_set_trap manipulate the NETPOLL_RX_TRAPPED
bit.  This would make the trap specific to each interface, but I think that
may be desirable.

-Jeff
