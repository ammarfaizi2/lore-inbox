Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314647AbSEBQkA>; Thu, 2 May 2002 12:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314648AbSEBQj7>; Thu, 2 May 2002 12:39:59 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:21575 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314647AbSEBQj6>; Thu, 2 May 2002 12:39:58 -0400
Date: Thu, 2 May 2002 18:40:37 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020502184037.J11414@dualathlon.random>
In-Reply-To: <20020502180632.I11414@dualathlon.random> <3972036796.1020330599@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 09:10:00AM -0700, Martin J. Bligh wrote:
> > You can trivially map the phys mem between 1G and 1G+256M to be in a
> > direct mapping between 3G+256M and 3G+512M, then you can put such 256M
> > at offset 1G into the ZONE_NORMAL of node-id 1 with discontigmem too.
> > 
> > The constraints you have on the normal memory are only two:
> > 
> > 1) direct mapping
> > 2) DMA
> > 
> > so as far as the ram is capable of 32bit DMA with pci32 and it's mapped
> > in the direct mapping you can put it into the normal zone. There is no
> > difference at all between discontimem or nonlinear in this sense.
> 
> Now imagine an 8 node system, with 4Gb of memory in each node.
> First 4Gb is in node 0, second 4Gb is in node 1, etc.
> 
> Even with 64 bit DMA, the real problem is breaking the assumption
> that mem between 0 and 896Mb phys maps 1-1 onto kernel space.
> That's 90% of the difficulty of what Dan's doing anyway, as I
> see it.

You don't need any additional common code abstraction to make virtual
address 3G+256G to point to physical address 1G as in my example above,
after that you're free to put the physical ram between 1G and 1G+256M
into the zone normal of node 1 and the stuff should keep working but
with zone-normal spread in more than one node.  You just have full
control on virt_to_page, pci_map_single, __va.  Actually it may be as
well cleaner to just let the arch define page_address() when
discontigmem is enabled (instead of hacking on top of __va), that's a
few liner. (the only true limit you have is on the phys ram above 4G,
that cannot definitely go into zone-normal regardless if it belongs to a
direct mapping or not because of pci32 API)

Andrea
