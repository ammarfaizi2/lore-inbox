Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129737AbRBYAMk>; Sat, 24 Feb 2001 19:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129736AbRBYAMa>; Sat, 24 Feb 2001 19:12:30 -0500
Received: from ns.suse.de ([213.95.15.193]:59149 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129733AbRBYAMQ>;
	Sat, 24 Feb 2001 19:12:16 -0500
Date: Sun, 25 Feb 2001 01:12:11 +0100
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: New net features for added performance
Message-ID: <20010225011211.A23853@gruyere.muc.suse.de>
In-Reply-To: <3A9842DC.B42ECD7A@mandrakesoft.com> <oupsnl3k5gs.fsf@pigdrop.muc.suse.de> <3A984BDA.190B4D8E@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A984BDA.190B4D8E@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Feb 24, 2001 at 07:03:38PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2001 at 07:03:38PM -0500, Jeff Garzik wrote:
> Andi Kleen wrote:
> > 
> > Jeff Garzik <jgarzik@mandrakesoft.com> writes:
> > 
> > > Advantages:  A de-allocation immediately followed by a reallocation is
> > > eliminated, less L1 cache pollution during interrupt handling.
> > > Potentially less DMA traffic between card and host.
> > >
> > > Disadvantages?
> > 
> > You need a new mechanism to cope with low memory situations because the
> > drivers can tie up quite a bit of memory (in fact you gave up unified
> > memory management).
> 
> I think you misunderstand..  netif_rx frees the skb.  In this example:
> 
> 	netif_rx(skb); /* free skb of size PKT_BUF_SZ */
> 	skb = dev_alloc_skb(PKT_BUF_SZ)
> 
> an alloc of a PKT_BUF_SZ'd skb immediately follows a free of a
> same-sized skb.  100% of the time.

Free/Alloc gives the mm the chance to throttle it by failing, and also to 
recover from fragmentation by packing the slabs. If you don't do it you need
to add a hook somewhere that gets triggered on low memory situations and 
frees the buffers.

> > 4) Better support for aligned RX by only copying the header, no the whole
> > packet, to end up with an aligned IP header. Unless the driver knows about
> > all protocol lengths this means the stack needs to support "parse header
> > in this buffer, then switch to other buffer with computed offset for data"
> 
> This requires scatter-gather hardware support, right?  If so, would this
> support only exist for checksumming hardware -- like the current
> zerocopy -- or would non-checksumming SG hardware like tulip be
> supported too?

It doesn't need any hardware support. In fact it is especially helpful for 
the tulip. The idea is that instead of copying the whole packet to get an
aligned header (e.g. on the alpha or other boxes where unaligned accesses
are very expensive) you just copy the first 128 byte that probably contain 
the header. For the data it doesn't matter much if it's unaligned; copy_to_user
and csum_copy_to_user can deal with that fine. 


-Andi

