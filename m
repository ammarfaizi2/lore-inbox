Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267174AbTAFV1b>; Mon, 6 Jan 2003 16:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267176AbTAFV1a>; Mon, 6 Jan 2003 16:27:30 -0500
Received: from algx-tower-com-4173.z188-2-66.customer.algx.net ([66.2.188.62]:36779
	"EHLO neon.limebrokerage.com") by vger.kernel.org with ESMTP
	id <S267174AbTAFV0o>; Mon, 6 Jan 2003 16:26:44 -0500
Date: Mon, 6 Jan 2003 16:35:19 -0500 (EST)
From: Ion Badulescu <ionut@badula.org>
X-X-Sender: ion@guppy.limebrokerage.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix starfire compiler warning on PAE
In-Reply-To: <33980000.1041887671@flay>
Message-ID: <Pine.LNX.4.44.0301061625020.22375-100000@guppy.limebrokerage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jan 2003, Martin J. Bligh wrote:

> > Fix the compiler warning, yes; fix the driver for 64-bit dma_addr_t, no.
> > It may work with PAE, by chance, if all addresses returned by pci_map_single
> > and friends are < (1 << 33), but not otherwise.
> 
> Odd. It seems to work with PAE now. pci_map_single just casts an address
> though ... are the things you're passing it always allocated from ZONE_NORMAL?
> I run these all the time on 16Gb machines with 16 processors (ia32 NUMA-Q).

I get them from the network stack, and I supposed they're guaranteed to be 
in ZONE_NORMAL as long as the adapter doesn't list NETIF_F_HIGHDMA among 
its features. So yes, you're right that it will probably work with PAE, 
but it won't work with a real 64-bit box, methinks.

> Cool! Sorry, I've just been seeing that warning for about 1 year, and was
> sick of it.

I was kinda busy and didn't get a chance to do much with the driver over 
the last 10 months or so... I also didn't have any boxes which could do 
real PAE, so I didn't try very hard -- until recently, that is. :-)

> Sorry, missed that. But in that case, I have another question for you ;-)
> Why do I get wierd errors like this:
> 
> Jan  6 10:09:53 larry kernel: eth0: Increasing Tx FIFO threshold to 80 bytes
> Jan  6 10:09:56 larry kernel: eth0: Increasing Tx FIFO threshold to 96 bytes

A few of these are mostly normal, it's the card signalling the driver that 
it is getting a Tx fifo underrun, and the driver responds by increasing 
the threshold at which the card starts transmitting the packet.

> Jan  6 10:12:29 larry kernel: eth0: Increasing Tx FIFO threshold to 448 bytes
> Jan  6 10:12:29 larry kernel: eth0: Increasing Tx FIFO threshold to 464 bytes

These are very high, however; it could be that there really is very high
contention on the PCI bus, but otherwise I can't explain them.

If they stop before reaching 1500, then it's probably ok and just
something you're gonna have to live with. Otherwise it's a bug of some
sort.

> I also recall getting errors like "Something Wicked happened", but I
> don't seem to be able to find them in the log right now.

Yeah, the interrupt status (printed right after the messages) would have 
been helpful...

That said, there is a known race condition in the v1.3.6 of the driver,
which could cause timeouts and erors under certain circumstances. It's all
fixed in 1.3.9 (the full 64-bit support version) and 1.4.0 (NAPI support). 
Both of those will do real 64-bit transfers, without the need for double 
buffering, so it should help on your 16GB boxes.

I could forward you one of those versions, if you want to test it. In 
fact, I'd appreciate some testing! :-)

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

