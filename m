Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWCTJFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWCTJFu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 04:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWCTJFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 04:05:50 -0500
Received: from [194.90.237.34] ([194.90.237.34]:26417 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S932262AbWCTJFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 04:05:49 -0500
Date: Mon, 20 Mar 2006 11:06:29 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: "David S. Miller" <davem@davemloft.net>
Cc: rick.jones2@hp.com, netdev@vger.kernel.org, rdreier@cisco.com,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: TSO and IPoIB performance degradation
Message-ID: <20060320090629.GA11352@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060308125311.GE17618@mellanox.co.il> <20060309.154819.104282952.davem@davemloft.net> <4410C671.2050300@hp.com> <20060309.232301.77550306.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060309.232301.77550306.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 20 Mar 2006 09:08:25.0515 (UTC) FILETIME=[D858DFB0:01C64BFD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. David S. Miller <davem@davemloft.net>:
> > well, there are stacks which do "stretch acks" (after a fashion) that 
> > make sure when they see packet loss to "do the right thing" wrt sending 
> > enough acks to allow cwnds to open again in a timely fashion.
> 
> Once a loss happens, it's too late to stop doing the stretch ACKs, the
> damage is done already.  It is going to take you at least one
> extra RTT to recover from the loss compared to if you were not doing
> stretch ACKs.
> 
> You have to keep giving consistent well spaced ACKs back to the
> receiver in order to recover from loss optimally.

Is it the case then that this requirement is less essential on
networks such as IP over InfiniBand, which are very low latency
and essencially lossless (with explicit congestion contifications
in hardware)?

> The ACK every 2 full sized frames behavior of TCP is absolutely
> essential.

Interestingly, I was pointed towards the following RFC draft
http://www.ietf.org/internet-drafts/draft-ietf-tcpm-rfc2581bis-00.txt

    The requirement that an ACK "SHOULD" be generated for at least every
    second full-sized segment is listed in [RFC1122] in one place as a
    SHOULD and another as a MUST.  Here we unambiguously state it is a
    SHOULD.  We also emphasize that this is a SHOULD, meaning that an
    implementor should indeed only deviate from this requirement after
    careful consideration of the implications.

And as Matt Leininger's research appears to show, stretch ACKs
are good for performance in case of IP over InfiniBand.

Given all this, would it make sense to add a per-netdevice (or per-neighbour)
flag to re-enable the trick for these net devices (as was done before
314324121f9b94b2ca657a494cf2b9cb0e4a28cc)?
IP over InfiniBand driver would then simply set this flag.

David, would you accept such a patch? It would be nice to get 2.6.17
back to within at least 10% of 2.6.11.

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
