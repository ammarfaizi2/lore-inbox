Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262479AbREULXe>; Mon, 21 May 2001 07:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262482AbREULXY>; Mon, 21 May 2001 07:23:24 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:8454 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262479AbREULXH>; Mon, 21 May 2001 07:23:07 -0400
Date: Mon, 21 May 2001 13:19:59 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010521131959.M30738@athlon.random>
In-Reply-To: <20010520163323.G18119@athlon.random> <15112.26868.5999.368209@pizda.ninka.net> <20010521034726.G30738@athlon.random> <15112.48708.639090.348990@pizda.ninka.net> <20010521105944.H30738@athlon.random> <15112.55709.565823.676709@pizda.ninka.net> <20010521115631.I30738@athlon.random> <15112.59880.127047.315855@pizda.ninka.net> <20010521125032.K30738@athlon.random> <15112.62766.368436.236478@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15112.62766.368436.236478@pizda.ninka.net>; from davem@redhat.com on Mon, May 21, 2001 at 03:59:58AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 03:59:58AM -0700, David S. Miller wrote:
> This still leaves around 800MB IOMMU space free on that sparc64 PCI
> controller.

if it was 400mbyte you were screwed up too, the point here is that the
marging is way too to allows ignore the issue completly, furthmore there
can be fragmentation effects in the pagetbles, at least in the way alpha
manages them which is to find contigous virtual pci bus addresses for each sg.
Alpha in mainline is just screwedup if a single pci bus tries to dynamic
map more than 128mbyte, changing it to 512mbyte is trivial, growing more
has performance implications as it needs to reduce the direct windows
which I don't like to as it would also increase the number of machines
that will get bitten by drivers that still use the virt_to_bus and also
increase the pressure on the iommu ptes too.

Now I'm not asking to break the API for 2.4 to take care of that, you
seems to be convinced in fixing this for 2.5 and I'm ok with that,
I just changed the printk of running out of entries to be KERN_ERR at
least, so we know if somebody has real life troubles with 2.4 I will go
HIGHMEM which is a matter of 2 hours for me to implement.

Only thing I suggest is to change the API before starting fixing the
drivers, I mean: don't start checking for bus address 0 before changing
the API to return faliure in another way. It's true x86 is reserving the
zero page anyways because it's a magic bios thing, but for example on
the alpha such a 0 bus address that we cannot use wastes 8 mbyte of DMA
virtual bus addresses that we reserve for the ISA cards (of course we
almost never need 16mbyte of ram all under isa dma but since it's so
low cost to allow that I think we will just in case).

Andrea
