Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313927AbSEFA17>; Sun, 5 May 2002 20:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313938AbSEFA16>; Sun, 5 May 2002 20:27:58 -0400
Received: from [195.223.140.120] ([195.223.140.120]:9508 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S313927AbSEFA14>; Sun, 5 May 2002 20:27:56 -0400
Date: Mon, 6 May 2002 02:28:31 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020506022830.A6712@dualathlon.random>
In-Reply-To: <20020502180632.I11414@dualathlon.random> <E173LwB-00027n-00@starship> <20020503071554.P11414@dualathlon.random> <E174Vq8-0004BK-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2002 at 01:54:52AM +0200, Daniel Phillips wrote:
> On Friday 03 May 2002 07:15, Andrea Arcangeli wrote:
> > On Thu, May 02, 2002 at 09:08:18PM +0200, Daniel Phillips wrote:
> > > On Thursday 02 May 2002 20:57, Andrea Arcangeli wrote:
> > > > 
> > > > correct. The direct mapping is nothing magic, it's like a big static
> > > > kmap area.  Everybody is required to use
> > > > virt_to_page/page_address/pci_map_single/... to switch between virtual
> > > > address and mem_map anyways (thanks to the discontigous mem_map), so you
> > > > can use this property by making discontigous the virtual space as well,
> > > > not only the mem_map.  discontigmem basically just allows that.
> > > 
> > > And what if you don't have enough virtual space to fit all the memory you
> > 
> > ZONE_NORMAL is by definition limited by the direct mapping size, so if
> > you don't have enough virtual space you cannot enlarge the zone_normal
> > anyways. If need more virtual space you can only do  things like
> > CONFIG_2G.
> 
> I must be guilty of not explaining clearly.  Suppose you have the following
> physical memory map:
> 
> 	          0: 128 MB
> 	  8000,0000: 128 MB
> 	1,0000,0000: 128 MB
> 	1,8000,0000: 128 MB
> 	2,0000,0000: 128 MB
> 	2,8000,0000: 128 MB
> 	3,0000,0000: 128 MB
> 	3,8000,0000: 128 MB
> 
> The total is 1 GB of installed ram.  Yet the kernel's 1G virtual space,
> can only handle 128 MB of it.  The rest falls out of the addressable range and
> has to be handled as highmem, that is if you preserve the linear relationship
> between kernel virtual memory and physical memory, as config_discontigmem does.
> Even if you go to 2G of kernel memory (restricting user space to 2G of virtual)
> you can only handle 256 MB.
> 
> By using config_nonlinear, the kernel can directly address all of that memory,
> giving you the full 800MB or so to work with (leaving out the kmap regions etc)
> as zone_normal.

If those different 128M chunks aren't in different numa nodes that's
broken hardware that can be workarounded just fine with discontigmem. If
as expected they are (indeed similar to numa-q) placed on different numa
nodes, then they must go into pgdat regardless, so nonlinear or not
cannot make difference with numa. Either ways (both if it's broken
hardware workaroundable with discontigmem, or proper numa architecture)
there will be no problem at all in coalescing the blocks below 4G into
ZONE_NORMAL (and for the blocks above 4G nonlinaer can do nothing).

nonlinear is only needed with origin2k (and possibly iseries if the
partitioning is extremely inefficient)  where discontigmem with
hundred/thousand of pgdat would not capable of workarounding the
hardware weird mem phys layout because it would perform too poorly.

Andrea
