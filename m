Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314211AbSEBB0s>; Wed, 1 May 2002 21:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314213AbSEBB0r>; Wed, 1 May 2002 21:26:47 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:22850 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314211AbSEBB0n>; Wed, 1 May 2002 21:26:43 -0400
Date: Thu, 2 May 2002 03:27:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: discontiguous memory platforms
Message-ID: <20020502032725.S11414@dualathlon.random>
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <E171aOa-0001Q6-00@starship> <20020429153500.B28887@dualathlon.random> <E172K9n-0001Yv-00@starship> <20020501042341.G11414@dualathlon.random> <20020501180547.GA1212440@sgi.com> <20020502011750.M11414@dualathlon.random> <20020501232343.GA1214171@sgi.com> <20020501175133.A30649@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2002 at 05:51:33PM -0700, Ralf Baechle wrote:
> On Wed, May 01, 2002 at 04:23:43PM -0700, Jesse Barnes wrote:
> 
> > On Thu, May 02, 2002 at 01:17:50AM +0200, Andrea Arcangeli wrote:
> > > so ia64 is one of those archs with a ram layout with huge holes in the
> > > middle of the ram of the nodes? I'd be curious to know what's the
> > 
> > Well, our ia64 platform is at least, but I think there are others.
> > 
> > > hardware advantage of designing the ram layout in such a way, compared
> > > to all other numa archs that I deal with. Also if you know other archs
> > > with huge holes in the middle of the ram of the nodes I'd be curious to
> > > know about them too. thanks for the interesting info!
> > 
> > AFAIK, some MIPS platforms (both NUMA and non-NUMA) have memory
> > layouts like this too.  I've never done hardware design before, so I'm
> > not sure if there's a good reason for such layouts.  Ralf or Daniel
> > might be able to shed some more light on that...
> 
> Just to give a few examples of memory layouts on MIPS systems. Sibyte 1250
> is as follows:
> 
>  - 256MB at physical address 0
>  - 512MB at physical address 0x80000000
>  - 256MB at physical address 0xc0000000
>  - The entire rest of the memory is mapped contiguously from physical
>    address 0x1:00000000 up.
>  All available memory is mapped from the lowest address up.

Is this a numa? If not then you should be just perfectly fine with
discontigmem with this chip.


> 
> Origin 200/2000.  Each node has an address space of 2GB, each node has 4
>   memory banks, that is each bank takes 512MB of address space.  Even
>   unpopulated or partially populated banks take the full 512MB address
>   space.  Memory in partially populated banks is mapped at the beginning
>   of the bank's address space; each node must have have at least one
>   bank with memory in it, that is something like
> 
>  - 32MB @ physical address 0x00:00000000
>  - 32MB @ physical address 0x00:80000000
>  - 32MB @ physical address 0x01:00000000
>  ...
>  - 32MB @ physical address 0x7f:00000000
> 
>   would be a valid configuration.  That's 8GB of RAM scattered in tiny
>   chunks of just 32mb throughout 256MB address space.  In theory nodes
>   might not even have to exist, so
> 
>  - 32MB @ physical address 0x00:00000000
>  - 32MB @ physical address 0x7f:00000000
> 
>   would be a valid configuration as well.

this means 256 nodes. for example that many different discontigmem nodes
would give you a measurable slowdown in the nr_free_pages O(N) loops
over the pgdat list, so nonlinear on the above hardware is a win. I
wasn't aware that such a memory layout actually existed. So if you
want to support the above efficiently we must make it possibe for you to
do nonlinear transparently to the common code kernel abstraction. What
are actually the common code changes involved with nonlinear? What I
care about is not to clobber the common code with additional overlapping
common code abstractions. We should try to make it possible to do
nonlinear under mips completly transparently to the current common code,
if we do that then you can use nonlinear to handle the above extreme
origin 200/2k scenario without the common code noticing that. Then
there's no point to argue about nonlinear or discontigmem, nonlinear
becomes mips way of handling virt_to_page and that's all, no
config_nonlinaer at all, just select ARCH=mips instead of ARCH=x86. Then
I'll be very fine with it of course, it would become an obviously right
implementation of virt_to_page/pte_page for a certain arch.

> 
> There are other examples more but #1 is becoming a widespread chip and #2
> is a rather extreme example just to show how far discontiguity may go.
> 
>   Ralf


Andrea
