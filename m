Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315585AbSECHos>; Fri, 3 May 2002 03:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315586AbSECHor>; Fri, 3 May 2002 03:44:47 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:30768 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315585AbSECHor>; Fri, 3 May 2002 03:44:47 -0400
Date: Fri, 3 May 2002 09:45:29 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020503094529.H11414@dualathlon.random>
In-Reply-To: <20020502153402.A11414@dualathlon.random> <E172wFc-00024h-00@starship> <20020502180632.I11414@dualathlon.random> <E173QDx-0002C4-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2002 at 01:42:56AM +0200, Daniel Phillips wrote:
> On Thursday 02 May 2002 18:06, Andrea Arcangeli wrote:
> > On Wed, May 01, 2002 at 05:42:40PM +0200, Daniel Phillips wrote:
> > > On Thursday 02 May 2002 17:35, Andrea Arcangeli wrote:
> > > > On Thu, May 02, 2002 at 08:18:33AM -0700, Martin J. Bligh wrote:
> > > > > At the moment I use the contig memory model (so we only use discontig for
> > > > > NUMA support) but I may need to change that in the future.
> > > > 
> > > > I wasn't thinking at numa-q, but regardless numa-Q fits perfectly into
> > > > the current discontigmem-numa model too as far I can see.
> > > 
> > > No it doesn't.  The config_discontigmem model forces all zone_normal memory
> > > to be on node zero, so all the remaining nodes can only have highmem locally.
> > 
> > You can trivially map the phys mem between 1G and 1G+256M to be in a
> > direct mapping between 3G+256M and 3G+512M, then you can put such 256M
> > at offset 1G into the ZONE_NORMAL of node-id 1 with discontigmem too.
> 
> Andrea, I'm re-reading this and I'm guilty of misreading your 3G+512M, what
> you meant is PAGE_OFFSET+512M.  Yes, in fact this is exactly what

yes, I was short in explaining it, 3G == PAGE_OFFSET for 99% of userbase
but it wasn't obvious.

> config_nonlinear does.  Config_discontigmem does not do this, not without
> your 'trivial map', and that's all config_nonlinear is: a trivial map done
> in an organized way.  This same trivial mapping is capable of replacing all
> known non-numa uses of config_discontigmem.

You add a table lookup, the lookup on such table or data structure is
pure overhead if your ram is contigous.  NUMA-Q has a contigous ram
within the node so it doesn't make sense to add the nonlinear overhead,
to provide normal memory from the other nodes they only need to change
virt_to_page and page_address, plus of course the initialization of the
direct mapping (and the window intialization of the pci32
BAR windows/pci_map_single, but this latter pci part is indipendent
of the discontigmem/nonlinear issue).

nonlinear make sense and it's not a pure overhead _only_ when the
mem_map has holes, so instead of wasting ram with the mem_map you pay a
CPU hit with your nonlinear lookup, and so it can pay off, if there's no
hole in the per-node mem_map pointed by the pgdat then nonlinear cannot
pay off. At the start of the thread I never heard of configurations with
huge ram holes in the middle of the nodes, I thought it had to be
misconfigured hardware, origin 2k and iseries falls in this category so
for them nonlinear can pay off (but if I had an iSeries I would know how
to partition it efficiently and I would be fine with discontigmem be
sure, the other is a fascinating but slow dinosaur anyways).

Andrea
