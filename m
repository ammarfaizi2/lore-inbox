Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267411AbRGLBhK>; Wed, 11 Jul 2001 21:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267409AbRGLBhB>; Wed, 11 Jul 2001 21:37:01 -0400
Received: from battlejitney.wdhq.scyld.com ([216.254.93.178]:64249 "EHLO
	vaio.greennet") by vger.kernel.org with ESMTP id <S267408AbRGLBgz>;
	Wed, 11 Jul 2001 21:36:55 -0400
Date: Wed, 11 Jul 2001 21:37:13 -0400 (EDT)
From: Donald Becker <becker@scyld.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [PATCH] natsemi compiler workaround & cleanup
In-Reply-To: <3B4C98DA.BC9ECE5@colorfullife.com>
Message-ID: <Pine.LNX.4.10.10107112128090.29374-100000@vaio.greennet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2001, Manfred Spraul wrote:

> The rx setup in init_ring() in drivers/net/natsemi.c in 2.4.6 is
> miscompiled by several gcc-2.95 versions.
> 
> I could reproduce it with 2.95.1, and I received bug reports with 
> gcc version 2.95.2 20000220 (Debian GNU/Linux)
> gcc 2.95.3 19991030 from Mandrake 7.2

I don't agree with all of the patch, but I can address this specific point.

> egcs-1.12 and rh gcc 2.96-85 are not affected.

My version had the code structured as

	/* Initialize all Rx descriptors. */
	for (i = 0; i < RX_RING_SIZE; i++) {
		np->rx_ring[i].next_desc = virt_to_le32desc(&np->rx_ring[i+1]);
		np->rx_ring[i].cmd_status = DescOwn;
		np->rx_skbuff[i] = 0;
	}

This code does not trigger the difference in compiler behavior. (I'm not
certain that the less-than-transparent behavior could be accurately
called a bug.)

I realize the 2.4 code was changed to have the descriptor ring base
be pre-translated from a virtual address to PCI bus-accessable physical
memory address, and used offsets from that base.  I'm pointing out that
this problem doesn't exist in the 2.2.  Note that the code above
explicitly translates each descriptor ring entry to a physical address
individually.


> The patch also cleans up the suspend/resume synchronization and removes
> 2 superflous (& wrong) spin_unlock calls.

The (large) patch seems to add some unnecessary locking.

Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

