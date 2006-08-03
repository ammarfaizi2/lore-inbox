Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbWHCPDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWHCPDq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 11:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWHCPDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 11:03:46 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:43978 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932424AbWHCPDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 11:03:45 -0400
Date: Thu, 3 Aug 2006 19:03:31 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Arnd Hannemann <arnd@arndnet.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: problems with e1000 and jumboframes
Message-ID: <20060803150330.GB12915@2ka.mipt.ru>
References: <44D1FEB7.2050703@arndnet.de> <20060803135925.GA28348@2ka.mipt.ru> <44D20A2F.3090005@arndnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <44D20A2F.3090005@arndnet.de>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 03 Aug 2006 19:03:32 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 04:37:35PM +0200, Arnd Hannemann (arnd@arndnet.de) wrote:
> >> im running vanilla 2.6.17.6 and if i try to set the mtu of my e1000 nic
> >> to 9000 bytes, page allocation failures occur (see below).
> >>
> >> However the box is a VIA Epia MII12000 with 1 GB of Ram and 1 GB of swap
> >> enabled, so there should be plenty of memory available. HIGHMEM support
> >> is off. The e1000 nic seems to be an 82540EM, which to my knowledge
> >> should support jumboframes.
> > 
> > But it does not support splitting them into page sized chunks, so it
> > requires the whole jumbo frame allocation in one contiguous chunk, 9k
> > will be transferred into 16k allocation (order 3), since SLAB uses
> > power-of-2 allocation.
> 
> Hmm, ok, what is the meaning of this line then:
> > Normal: 44578*4kB 11117*8kB 800*16kB 0*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 280240kB
> 
> Are this the allocations which already happend? I thought they would
> represent the free memory, not the already used one?

3-order is 32k actually.

> >> However I can't always reproduce this on a freshly booted system, so
> >> someone else may be the culprit and leaking pages?
> > 
> > You will almost 100% reproduce it after "find / > /dev/null".
> > 
> >> Any ideas how to debug this?
> > 
> > It can not be debugged - you have cought a memory fragmentation problem,
> > which is quite common.
> 
> That's too bad :-(
> However it seems hard for me to imagine why there is no contiguous chunk
> of 16k when there are hundreds of Mbyte free. Can't those other pages be
> moved by the kernel, if a higher order allocation is requested?

e1000 is trying to allocate 32k, not 16 for jumbo frames.

> >>> kswapd0: page allocation failure. order:3, mode:0x20
> > 
> > e1000 tries to allocate 3-order pages atomically?
> > Well, that's wrong.
> >  
> 
> Why? After your explanation that makes sense for me. The driver needs
> one contiguous chunk for those 9k packet buffer and thus requests a
> 3-order page of 16k. Or do i still do not understand this?

Correct, except that it wants 32k.
e1000 logic is following:
align frame size to power-of-two, then skb_alloc adds a little
(sizeof(struct skb_shared_info)) at the end, and this ends up 
in 32k request just for 9k jumbo frame.

And it wants it in atomic context.

-- 
	Evgeniy Polyakov
