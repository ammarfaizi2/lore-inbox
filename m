Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262316AbREUBhn>; Sun, 20 May 2001 21:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262318AbREUBhd>; Sun, 20 May 2001 21:37:33 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:3966 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262316AbREUBh3>; Sun, 20 May 2001 21:37:29 -0400
Date: Mon, 21 May 2001 03:37:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010521033706.F30738@athlon.random>
In-Reply-To: <20010519231131.A2840@jurassic.park.msu.ru> <20010520044013.A18119@athlon.random> <3B07AF49.5A85205F@uow.edu.au> <20010520154958.E18119@athlon.random> <20010520181803.I18119@athlon.random> <3B07EEFE.43DDBA5C@uow.edu.au> <20010520184411.K18119@athlon.random> <3B07F6B8.4EAB0142@uow.edu.au> <20010520191206.A30738@athlon.random> <15112.27206.4123.40450@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15112.27206.4123.40450@pizda.ninka.net>; from davem@redhat.com on Sun, May 20, 2001 at 06:07:17PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2001 at 06:07:17PM -0700, David S. Miller wrote:
> 
> Andrea Arcangeli writes:
>  > > [..]  Even sparc64's fancy
>  > > iommu-based pci_map_single() always succeeds.
>  > 
>  > Whatever sparc64 does to hide the driver bugs you can break it if you
>  > pci_map 4G+1 bytes of phyical memory.
> 
> Which is an utterly stupid thing to do.
> 
> Please construct a plausable situation where this would occur legally
> and not be a driver bug, given the maximum number of PCI busses and
> slots found on sparc64 and the maximum _concurrent_ usage of PCI dma
> space for any given driver (which isn't doing something stupid).

Assume I have a dozen of PCI cards that does DMA using SG tables that
can map up to some houndred mbytes of ram each, so I can just program
the cards to start the dma on those houndred mbyte of ram, most of the
time the I/O is not simulaneous, but very rarely it happens to be
simultaneous and in turn it tries to pci_map_sg more than 4G of physical
ram. After that sparc64 iommu code will say "bye bye" and the machine
will crash because the nic driver is not checking for pci_map_single
faliures.

I don't see why the above scenario should be classified as stupid. such
pci_map_* API and the device drivers have to be generic.

It's like if you say me that there's no need to check for
alloc_pages(GFP_ATOMIC) faliures in the device drivers because all
machines you are using have 256G of ram and you never use all the
physical ram with your workloads. I would never buy such an argument.

Furthmore currently (2.4.5pre3) on alpha you only need to ask the iommu
to map more than 128mbyte of ram to crash (I increased it to 512mbyte at
least, Jay said my first patch that increased it to 1G is risky because
some device gets confused by bus addresses at around -1M and we keep the
dynamic window above 3G, 512M should still be enough to cover 99% of
hardware configurations I agree on that but this is not a good excuse to
left all device drivers buggy just because those bugs doesn't trigger in
all the hardware configurations out there).

Andrea
