Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129730AbRBYAEK>; Sat, 24 Feb 2001 19:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129731AbRBYAEA>; Sat, 24 Feb 2001 19:04:00 -0500
Received: from mail0.atl.bellsouth.net ([205.152.0.27]:43773 "EHLO
	mail0.atl.bellsouth.net") by vger.kernel.org with ESMTP
	id <S129730AbRBYADp>; Sat, 24 Feb 2001 19:03:45 -0500
Message-ID: <3A984BDA.190B4D8E@mandrakesoft.com>
Date: Sat, 24 Feb 2001 19:03:38 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: New net features for added performance
In-Reply-To: <3A9842DC.B42ECD7A@mandrakesoft.com> <oupsnl3k5gs.fsf@pigdrop.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> Jeff Garzik <jgarzik@mandrakesoft.com> writes:
> 
> > Advantages:  A de-allocation immediately followed by a reallocation is
> > eliminated, less L1 cache pollution during interrupt handling.
> > Potentially less DMA traffic between card and host.
> >
> > Disadvantages?
> 
> You need a new mechanism to cope with low memory situations because the
> drivers can tie up quite a bit of memory (in fact you gave up unified
> memory management).

I think you misunderstand..  netif_rx frees the skb.  In this example:

	netif_rx(skb); /* free skb of size PKT_BUF_SZ */
	skb = dev_alloc_skb(PKT_BUF_SZ)

an alloc of a PKT_BUF_SZ'd skb immediately follows a free of a
same-sized skb.  100% of the time.

It seems an obvious shortcut to me, to have __netif_rx or similar
-clear- the skb head not free it.  No changes to memory management or
additional low memory situations created by this, AFAICS.


> 4) Better support for aligned RX by only copying the header, no the whole
> packet, to end up with an aligned IP header. Unless the driver knows about
> all protocol lengths this means the stack needs to support "parse header
> in this buffer, then switch to other buffer with computed offset for data"

This requires scatter-gather hardware support, right?  If so, would this
support only exist for checksumming hardware -- like the current
zerocopy -- or would non-checksumming SG hardware like tulip be
supported too?

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
