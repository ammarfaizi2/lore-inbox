Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261769AbREVO3x>; Tue, 22 May 2001 10:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261746AbREVO3n>; Tue, 22 May 2001 10:29:43 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:20516 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261769AbREVO3g>; Tue, 22 May 2001 10:29:36 -0400
Date: Tue, 22 May 2001 16:29:16 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-kernel@vger.kernel.org
Cc: rth@twiddle.net, "David S. Miller" <davem@redhat.com>
Subject: Re: alpha iommu fixes
Message-ID: <20010522162916.B15155@athlon.random>
In-Reply-To: <20010521105944.H30738@athlon.random> <15112.55709.565823.676709@pizda.ninka.net> <20010521115631.I30738@athlon.random> <15112.59880.127047.315855@pizda.ninka.net> <20010521125032.K30738@athlon.random> <15112.62766.368436.236478@pizda.ninka.net> <20010521131959.M30738@athlon.random> <20010521155151.A10403@jurassic.park.msu.ru> <20010521105339.A1907@twiddle.net> <20010522025658.A1116@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010522025658.A1116@athlon.random>; from andrea@suse.de on Tue, May 22, 2001 at 02:56:58AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While merging all the recent fixes in my tree and while reserving the
pci32 space above -1M to have a dynamic window of almost 1G without
dropping down the direct window, I noticed and fixed a severe bug, and
so now I started to wonder if the real reason of the crash when an
invalid entry is cached in the tlb and we do dma through it (both of
es40 and other platforms as well according to Ivan) could be just this
new software bug:

		for (i = 0; i < n; ++i)
			ptes[p+i] = ~1UL;

we reserve by setting also all the bits over 31 to 1. The tsunami specs
says that bits between 32 and 63 _must_ be zero, so the above is
definitely buggy. Maybe this has relactions with the fact the crashes
triggered on >=4G machines.

I will change it to:

		for (i = 0; i < n; ++i)
                        ptes[p+i] = 0x2;

which is just obviously correct for our internal management of the
allocation in the critical sections and that is a definitely necessary
fix according to the specs. Maybe this is the right(tm) fix and then I
can drop the artificial alignment and the tsunami will go to re-fetch
the pte on memory automatically when we do the I/O through an invalid
pte then. If tsunami gets fixed by it I can bet then we can drop the
align_entry field from the pci_iommu_arena structure all together and
what was referred as hardware bug for the other platforms would be
infact a software bug in the iommu code.

I am optimistic this is the definitive fix so I will left out the
so far absolutely necessary artifical alignment on the tsunami for now
and I will put in this critical fix for now (until I get the confirm),
and if it works I will drop the align_entry field all together from the
pci_iommu_arena structure.

Ivan could you test the above fix on the platforms that needs the
align_entry hack?

Andrea
