Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267428AbRGLFHz>; Thu, 12 Jul 2001 01:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267431AbRGLFHq>; Thu, 12 Jul 2001 01:07:46 -0400
Received: from colorfullife.com ([216.156.138.34]:56837 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S267428AbRGLFH3>;
	Thu, 12 Jul 2001 01:07:29 -0400
Message-ID: <3B4D3097.513714B4@colorfullife.com>
Date: Thu, 12 Jul 2001 07:07:35 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Donald Becker <becker@scyld.com>
CC: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [PATCH] natsemi compiler workaround & cleanup
In-Reply-To: <Pine.LNX.4.10.10107112128090.29374-100000@vaio.greennet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Donald Becker wrote:
> 
> On Wed, 11 Jul 2001, Manfred Spraul wrote:
> 
> > The rx setup in init_ring() in drivers/net/natsemi.c in 2.4.6 is
> > miscompiled by several gcc-2.95 versions.
> >
> > I could reproduce it with 2.95.1, and I received bug reports with
> > gcc version 2.95.2 20000220 (Debian GNU/Linux)
> > gcc 2.95.3 19991030 from Mandrake 7.2
> 
> I don't agree with all of the patch, but I can address this specific point.
> 
> > egcs-1.12 and rh gcc 2.96-85 are not affected.
> 
> My version had the code structured as
> 
>         /* Initialize all Rx descriptors. */
>         for (i = 0; i < RX_RING_SIZE; i++) {
>                 np->rx_ring[i].next_desc = virt_to_le32desc(&np->rx_ring[i+1]);
>                 np->rx_ring[i].cmd_status = DescOwn;
>                 np->rx_skbuff[i] = 0;
>         }
> 
> This code does not trigger the difference in compiler behavior. (I'm not
> certain that the less-than-transparent behavior could be accurately
> called a bug.)
>

It is a bug. np->rx_ring[i].next_desc is initialized by 2.4.6 with
gcc-2.95.1 to
[0]: 0x...210
[1]: 0x00000000
[2]: 0x...220
[3]: 0x...230
[4]: 0x...240.
etc.

> I realize the 2.4 code was changed to have the descriptor ring base
> be pre-translated from a virtual address to PCI bus-accessable physical
> memory address, and used offsets from that base.  I'm pointing out that
> this problem doesn't exist in the 2.2.  Note that the code above
> explicitly translates each descriptor ring entry to a physical address
> individually.
>
Correct. The problem was introduce by the virt_to_desc to pci_dma
conversion.

> > The patch also cleans up the suspend/resume synchronization and removes
> > 2 superflous (& wrong) spin_unlock calls.
> 
> The (large) patch seems to add some unnecessary locking.
>
It's possible that some locking outside of the tx and rx codepath is not
required, I'm concentrating on a race free suspend & resume
implementation.
It shouldn't affect the critical functions:
rx interrupts run without a spinlock, and start_tx only acquires the
lock around "status = DescOwn;np->cur_rx++". netdev_tx_done() during
start_tx is an idea for tx interrupt mitigation, it's not yet finished.

--
	Manfred
