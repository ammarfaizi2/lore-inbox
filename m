Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265798AbSL3A6k>; Sun, 29 Dec 2002 19:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265806AbSL3A6k>; Sun, 29 Dec 2002 19:58:40 -0500
Received: from packet.digeo.com ([12.110.80.53]:21240 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265798AbSL3A6j>;
	Sun, 29 Dec 2002 19:58:39 -0500
Message-ID: <3E0F9C2E.9652D11A@digeo.com>
Date: Sun, 29 Dec 2002 17:06:54 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: khromy <khromy@lnuxlab.ath.cx>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.53-mm3: xmms: page allocation failure. order:5, mode:0x20
References: <3E0F5E2C.70F7D112@digeo.com> <1041211946.1474.31.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Dec 2002 01:06:55.0511 (UTC) FILETIME=[BEC61A70:01C2AF9F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> On Sun, 2002-12-29 at 20:42, Andrew Morton wrote:
> > gack.  Someone is requesting 128k of memory with GFP_ATOMIC.  It fell
> > afoul of the reduced memory reserves.  It deserved to.
> 
> ISA sound I/O. And yes it really does want the 128K if it can get it on
> a slower box. It will try 128/64/32/.. so it gets less if there isnt any
> DMA RAM around. All the sound works this way because few bits of sound
> hardware, even in the PCI world, support scatter gather.
> 
> If the VM can't deal with it - we need to fix the VM.

It'll tend to usually work because GFP_KERNEL allocations prefer to
not dip into the DMA region.

> All these allocations are blocking and can wait a long time.

But it's not!  dma_alloc_coherent() is using GFP_ATOMIC|__GFP_DMA.

Now, if we can fix the caller to use

	__GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS | __GFP_DMA

then that at least will allow page reclaim.

Then we can remove this restriction in __alloc_pages():

        /*
         * Don't let big-order allocations loop.  Yield for kswapd, try again.
         */
        if (order <= 3) {
                yield();
                goto rebalance;
        }

and all will be well.

dma_alloc_coherent() should be fixed to take a gfp_mask, and callers
should be updated.

As for permitting direct page reclaim for higher-order allocations: I
just don't know - it's from before my time.  Perhaps the VM will livelock.
