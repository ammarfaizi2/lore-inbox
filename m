Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315555AbSECFPR>; Fri, 3 May 2002 01:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315556AbSECFPQ>; Fri, 3 May 2002 01:15:16 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:50970 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315555AbSECFPP>; Fri, 3 May 2002 01:15:15 -0400
Date: Fri, 3 May 2002 07:15:54 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020503071554.P11414@dualathlon.random>
In-Reply-To: <20020502180632.I11414@dualathlon.random> <143790000.1020367912@flay> <20020502205741.O11414@dualathlon.random> <E173LwB-00027n-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 09:08:18PM +0200, Daniel Phillips wrote:
> On Thursday 02 May 2002 20:57, Andrea Arcangeli wrote:
> > On Thu, May 02, 2002 at 12:31:52PM -0700, Martin J. Bligh wrote:
> > > between physical to virtual memory to a non 1-1 mapping.
> > 
> > correct. The direct mapping is nothing magic, it's like a big static
> > kmap area.  Everybody is required to use
> > virt_to_page/page_address/pci_map_single/... to switch between virtual
> > address and mem_map anyways (thanks to the discontigous mem_map), so you
> > can use this property by making discontigous the virtual space as well,
> > not only the mem_map.  discontigmem basically just allows that.
> 
> And what if you don't have enough virtual space to fit all the memory you

ZONE_NORMAL is by definition limited by the direct mapping size, so if
you don't have enough virtual space you cannot enlarge the zone_normal
anyways. If need more virtual space you can only do  things like
CONFIG_2G.

> need, plus the holes?  Config_nonlinear handles that, config_discontig
> doesn't.
> 
> > > No, you don't need to call changing that mapping "CONFIG_NONLINEAR",
> > > but that's basically what the bulk of Dan's patch does, so I think we should 
> > > steal it with impunity ;-) 
> > 
> > The difference is that if you use discontigmem you don't clobber the
> > common code in any way,
> 
> First that's wrong.  Look at _alloc_pages and tell me that config_discontig
> doesn't impact the common code (in fact, it adds two extra subroutine
> calls, including two loops, to every alloc_pages call).

there are no two subroutines, check -aa. And the whole point is that we
need a topology description of the machine for numa, nonlinear or not,
what you're talking about is the whole numa concept in 2.4, it is all
but superflous, while nonlinear implications in common code are
superflous just to provide ZONE_NORMAL in more than one node in numa-q.

> 
> Secondly, config_nonlinear does not clobber the common code.  If it does,
> please show me where.
> 
> When config_nonlinear is not enabled, suitable stubs are provided to make it
> transparent.

it's the stubs that are visible to the common code and that are
superflous.

> > Actually the same mmu technique can be used to coalesce in virtual
> > memory the discontigous chunks of iSeries, then you left the lookup in
> > the tree to resolve from mem_map to the right virtual address and from
> > the right virtual address back to mem_map. (and you left DISCONTIGMEM
> > disabled) I think it should be possible.
> 
> So you're proposing a new patch?  Have you chosen a name for it?  How
> about 'config_nonlinear'? ;-)

They're called CONFIG_MULTIQUAD and CONFIG_MSCHUNKS.

Andrea
