Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313810AbSEIQIw>; Thu, 9 May 2002 12:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313817AbSEIQIw>; Thu, 9 May 2002 12:08:52 -0400
Received: from dsl-213-023-040-085.arcor-ip.net ([213.23.40.85]:19177 "EHLO
	starship") by vger.kernel.org with ESMTP id <S313810AbSEIQIu>;
	Thu, 9 May 2002 12:08:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Date: Thu, 9 May 2002 18:08:35 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrea Arcangeli <andrea@suse.de>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0205062053050.32715-100000@serv> <E175Tp9-0003ny-00@starship> <3CD9B098.14E394D3@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E175qT7-00087g-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 May 2002 01:11, Roman Zippel wrote:
> Hi,
> 
> Daniel Phillips wrote:
> 
> > Your patch preserves a linear relationship between physical and virtual
> > memory, because you do both the ptov and vtop lookup in the same array.  
As
> > such, you don't provide the functionality I provide of being able to fit a
> > large amount of physical memory into a small amount of virtual memory, and
> > you can't join all your separate pgdat's into one, as I do.
> 
> Read the source again. arch/m68k/mm/motorola.c:map_chunk() maps all
> memory areas into single virtual area (virtaddr is static there and only
> increased starting from PAGE_OFFSET). In paging_init() there is only a
> single call to free_area_init().

Oops, yes, I see how it works, it relies on your O(N) search for the inverse. 
(Obligatory snipe: there are almost no comments for this opaque code, I hope 
you share my feeling that needs fixing.)

Searching the table instead of doing a direct lookup allows you to eliminate 
one of my two tables.  This is not a property you'd want to tie yourself to 
though, since the cost for any large number of chunks will be excessive, and 
will show up in the page table manipulation overhead.

Now it seems our strategies are a lot more similar than different.  So what 
were we arguing about again?  I've just gone further with the generalization 
of this, and cast it into a more general form suitable for use across more 
than one arch.

Where you ignore the distinction between logical and physical, it costs you 
execution time, as where you wrote  page = virt_to_page(phys_to_virt((i << 
PAGE_SHIFT) + bdata->node_boot_start)) where formerly we just had page++.  
This in generic code too.  Unless you have an #ifdef CONFIG_SOMETHING there I 
recommend this code *not* be merged because it penalizes the common case for 
the sake of your arch.  And it's unnecessary even for your arch, as I've 
demonstrated.

Incidently, the reason I came up with the virtual/logical distinction in the 
first places is that I found myself writing such awkward constructs as you 
wrote above, and thought there must be a better way.  Indeed there is.

> > You do have a config option, it's CONFIG_SINGLE_MEMORY_CHUNK.
> 
> That was our cheap answer to avoid the loops.

My cheap answer is to turn the option off.  So why don't I need a config 
option again?

> >  You just didn't
> > attempt to create the contiguous logical address space as I did, so you
> > didn't need to go outside your arch.
> 
> I don't need that, because I create a contiguous _virtual_ address
> space.

Again, we're arguing about what?  So do I.  The relationship between virtual 
and logical, for me, is just logical = virtual - PAGE_OFFSET, a meme you'll 
find in many places in the kernel source already, often obscured by the 
impression that physical addresses are really being manipulated when in fact 
nothing of the kind is going on - the simple truth is, the arithmetic gets 
easier then you work zero-based instead of PAGE_OFFSET based.

So now that we know we're both doing the same thing, could we please stop 
doing the catholics vs the protestants thing and maybe cooperate?

-- 
Daniel
