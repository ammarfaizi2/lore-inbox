Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315375AbSEBTYe>; Thu, 2 May 2002 15:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315378AbSEBTYd>; Thu, 2 May 2002 15:24:33 -0400
Received: from dsl-213-023-038-046.arcor-ip.net ([213.23.38.46]:19361 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315375AbSEBTXi>;
	Thu, 2 May 2002 15:23:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>,
        William Lee Irwin III <wli@holomorphy.com>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Date: Thu, 2 May 2002 21:22:07 +0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020502180632.I11414@dualathlon.random> <20020502171655.GJ32767@holomorphy.com> <20020502204136.M11414@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E173M9Y-00027s-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 May 2002 20:41, Andrea Arcangeli wrote:
> On Thu, May 02, 2002 at 10:16:55AM -0700, William Lee Irwin III wrote:
> > On Thu, May 02, 2002 at 09:10:00AM -0700, Martin J. Bligh wrote:
> > >> Even with 64 bit DMA, the real problem is breaking the assumption
> > >> that mem between 0 and 896Mb phys maps 1-1 onto kernel space.
> > >> That's 90% of the difficulty of what Dan's doing anyway, as I
> > >> see it.
> > 
> > On Thu, May 02, 2002 at 06:40:37PM +0200, Andrea Arcangeli wrote:
> > > control on virt_to_page, pci_map_single, __va.  Actually it may be as
> > > well cleaner to just let the arch define page_address() when
> > > discontigmem is enabled (instead of hacking on top of __va), that's a
> > > few liner. (the only true limit you have is on the phys ram above 4G,
> > > that cannot definitely go into zone-normal regardless if it belongs to a
> > > direct mapping or not because of pci32 API)
> > > Andrea
> > 
> > Being unable to have any ZONE_NORMAL above 4GB allows no change at all.
> 
> No change if your first node maps the whole first 4G of physical address
> space, but in such case nonlinear cannot help you in any way anyways.

You *still don't have a clue what config_nonlinear does*.

It doesn't matter if the first 4G of physical memory belongs to node zero.
Config_nonlinear allows you to map only part of that to the kernel virtual
space, and the rest would be mapped to highmem.  The next node will map part
of its local memory (perhaps the next 4 gig of physical memory) to a different
part of the kernel virtual space, and so on, so that in the end, all nodes
have at least *some* zone_normal memory.

Do you now see why config_nonlinear is needed in this case?  Are you
willing to recognize the possibility that you might have missed some other
cases where config_nonlinear is needed, and config_discontigmem won't do
the job?

-- 
Daniel
