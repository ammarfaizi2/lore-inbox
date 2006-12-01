Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758890AbWLAEiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758890AbWLAEiP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 23:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758886AbWLAEiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 23:38:15 -0500
Received: from rhun.apana.org.au ([64.62.148.172]:9477 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1758884AbWLAEiO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 23:38:14 -0500
Date: Fri, 1 Dec 2006 15:37:55 +1100
To: David Miller <davem@davemloft.net>
Cc: kaber@trash.net, khc@pm.waw.pl, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: Re: Broken commit: [NETFILTER]: ipt_REJECT: remove largely duplicate route_reverse function
Message-ID: <20061201043755.GA13624@gondor.apana.org.au>
References: <E1GpHVB-0005CB-00@gondolin.me.apana.org.au> <20061128.210416.59658806.davem@davemloft.net> <20061129065146.GA20681@gondor.apana.org.au> <20061130.202206.25410613.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130.202206.25410613.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2006 at 08:22:06PM -0800, David Miller wrote:
> 
> What MAX_HEADER's setting is trying to do is optimistically allocate
> enough for a single level of tunnelling.  It does not handle nested
> tunneling at all, of course.

Agreed, I should've said MAX_HEADER.

> Actually, I wonder how antiquated this all is.  I bet we could get rid
> of MAX_HEADER, then if we have to realloc headroom, we adjust some
> per-device header thing which will behave like your global value idea
> does.  On the next allocation, we'll do the right thing.  Although I
> cannot come up with a scheme that works without reintroducing another
> net_device pointer to sk_buff, which seems necessary to handle arbitrary
> nesting. :-/

Actually the scarier part is that TCP as well as ip_route_me_harder
doesn't guarantee enough headroom for IPsec.  Fortunately TCP reserves
enough room (128 bytes) by default that it's unlikely to break with
non-nested IPsec.  But it's still pretty nasty.

So in general when allocating packets we have two scenarios:

1) The dst is known and fixed, i.e., all datagram protocols.  This is
the easy case where the headroom is known exactly beforehand.

2) The dst is unknown or may vary, this includes TCP, SCTP and DCCP.
This is where we currently use MAX_HEADER plus some protocol-specific
headroom.

Right now the normal (non-IPsec) dst output path always checks for
sufficient headroom and reallocates if necessary (ip_finish_output2).
I propose that we make IPsec do the same thing.

This change will make the stack safe from underflow crashes in IPsec.

There is also the ip_route_me_harder path where the dst varies.  It
also tries to reallocate the packet if there isn't enough headroom for
the new dst.  As long both IPsec and the normal path does the headroom
check, this can in fact be removed.

We can then make it more optimal because in the cases of TCP/SCTP/DCCP
we usually have a dst object.  The only problem of course is that it
may vary.  However, the common case by far is that the dst stays
constant.  So we can optimise for it by getting the headroom from the
current dst and rely on the last-ditch reallocation to fix things up
if needed.

For standard MTU-sized packets this discussion is moot since we have
2K of memory in each chunk.  However, for ACKs it could save a bit of
memory.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
