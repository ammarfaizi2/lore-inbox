Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261824AbREVB6a>; Mon, 21 May 2001 21:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261616AbREVB6V>; Mon, 21 May 2001 21:58:21 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20712 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261640AbREVB6G>;
	Mon, 21 May 2001 21:58:06 -0400
Date: Tue, 22 May 2001 02:56:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-kernel@vger.kernel.org
Cc: rth@twiddle.net, "David S. Miller" <davem@redhat.com>
Subject: Re: alpha iommu fixes
Message-ID: <20010522025658.A1116@athlon.random>
In-Reply-To: <15112.48708.639090.348990@pizda.ninka.net> <20010521105944.H30738@athlon.random> <15112.55709.565823.676709@pizda.ninka.net> <20010521115631.I30738@athlon.random> <15112.59880.127047.315855@pizda.ninka.net> <20010521125032.K30738@athlon.random> <15112.62766.368436.236478@pizda.ninka.net> <20010521131959.M30738@athlon.random> <20010521155151.A10403@jurassic.park.msu.ru> <20010521105339.A1907@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010521105339.A1907@twiddle.net>; from rth@twiddle.net on Mon, May 21, 2001 at 10:53:39AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 10:53:39AM -0700, Richard Henderson wrote:
> should probably just go ahead and allocate the 512M or 1G
> scatter-gather arena.

I just have a bugreport in my mailbox about pci_map faliures even after
I enlarged to window to 1G argghh (at first it looked apparently stable
by growing the window), so I'm stuck again, it seems I was right in not
being careless about the pci_map_* bugs today even if the 1G window
looked to offer a rasonable marging at first.

The pci_map_* failed triggers during a benchmark with a certain driver
that does massive DMA (similar to the examples I did previously), the
developers of the driver simply told me the hardware wants to do massive
zerocopy dma to userspace and they apparently excluded it could be a
memleak in the driver missing some pci_unmap_* after I told them to
check for that. Even enabling HIGHMEM would not be enough because they
do dma on userspace but on the network side, so it won't be taken care
by create_bounces(), so I at least would need to put another bounce
buffer layer in the driver to make highmem to work.

Other more efficient ways to go besides highmem plus additional bounce
buffer layer are:

2) fixing all buggy drivers now (would be a great pain as it seems to me
   I should do that alone apparently as it seems everybody else doesn't
   care about those bugs for 2.4)
3) let the "massing DMA" hardware to use DAC

Theoritically I could also cheat again and take a way 4) that is to try
to enlarge the window beyond 1G and see if the bugs gets hided also
during the benchmark that way, but I would take this as last resort as
this would again not be a definitive solution and I'd risk to get stuck
again tomorrow like I'm right now.

I think I will prefer to take a dirty way 3) just for those drivers to
solve this production problem even if it won't be implemented in a
generic manner at first (I got the idea from the quadrics folks that do
this just now with their nics if I understood well).

If I understand correctly on the tsunami enabling DAC simply means to
enable the pchip->pctl |= MWIN (monster window) bit during the boot
stage on both pchip.

Then the device driver of the "massive DMA" hardware should simply
program the registers of the nic to do use DAC with bus addresses that
are the phys address of the destination/source memory of the DMA,
only changed to have bit 40th set to 1. Those should be all the needed
changes necessary to make pci64 to work on tsunami at the same time of
pci32 direct/dynamic windows and it would be very efficient and it
sounds the best way to workaround the broken pci_map_* in 2.4 given
fixing the pci_map_* the right way is a pain.

Andrea
