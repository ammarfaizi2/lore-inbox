Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317653AbSFLHFa>; Wed, 12 Jun 2002 03:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317654AbSFLHFa>; Wed, 12 Jun 2002 03:05:30 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:20368 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S317653AbSFLHF3>; Wed, 12 Jun 2002 03:05:29 -0400
Date: Wed, 12 Jun 2002 00:06:39 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3D06F2FF.8070109@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
In-Reply-To: <3D061363.70500@pacbell.net>
 <20020611.202553.28822742.davem@redhat.com> <3D06E945.7070301@pacbell.net>
 <20020611.232430.05228219.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: David Brownell <david-b@pacbell.net>
>    Date: Tue, 11 Jun 2002 23:25:09 -0700
> 
>    I'd suspect ((dma_addr_t)0) would be a reasonable error return.
>    At least some hardware treats such values like software would
>    treat null pointers.  No call syntax change necessary, which
>    might be good or bad depending on how you feel tomorrow.
>    
> 0 is a valid PCI dma address on many platforms.  This is part
> of the problem.

OK, so a new call syntax would be desirable.  Or reserving page zero
even on such platforms.


>    > Remember please that specifically the DMA mapping APIs encourage use
>    > of consistent memory for small data objects.  ...
>    > ...  The non-consistent end of the APIs is
>    > meant for long contiguous buffers, not small chunks.
>    
>    And in between, a nice huge grey area to play with and argue about!
>    
> Not gray area, fully intentional!  From the beginning that was meant
> to be one of the distinctions between consistent and streaming DMA
> memory.

I realize that, but it's still a grey area ... meaning only that the
specific choice, in a set of systems, is one of the design tradeoffs.
Costs can vary a lot, but near either end the tradeoffs get clearer.


>    For that model, I would prefer tools more like a kmalloc than the
>    pci_pool, which is most like a kmem_cache_t.  The particular objects
>    in question are a bit small to use page-or-bigger allocators, too.
>    
> Huh?  The whole idea is that it is memory for PCI dma, it has to be
> PCI in nature.  If you want a kmalloc'ish thing, simple use
> pci_alloc_consistent and carve up the pages you get internally.

And the reason that logic doesn't lead us to rip kmalloc() out of
the kernel (in favor of the page allocator) is ... what?  Every driver
shouldn't _need_ to write yet another malloc() clone, that's all I'm
saying; that'd be a waste.


>    The problem for APIs like USB is that they haven't yet exposed DMA
>    addresses.  Doing that, giving folk a choice from the "non-consistent
>    end of the APIs", would be a big change.
>    
> But that is the direction I'd like things to go in.  A lot of problems
> have arisen because the USB layer likes to internally let drivers do
> DMA on any gob of memory whatsoever.  That has to stop, it really does.

I'll accept that for argument -- though I'll ask what other problems
(than this shared-cacheline scenario) you're thinking of.  This is the
only one that I recall seeming like it might argue for an API change.

(And USB is just one example, too.  Oliver turned up similar cases
in the SCSI layer, as I recall.  Likely a lot of it can be traced
down to widely-available hardware that wouldn't recognize a NUMA if
it tripped on one.)


>    Oh no -- I just had an evil thought.  Now that we have the device model
>    code partially in place, shouldn't we have DMA memory calls talk in
>    terms of "struct device" not "struct pci_device"?  That'd be the way
>    to have _one_ API for dma mapping (and consistent memory allocation),
>    working for PCI, USB, and any other bus framework that comes along.
>    
> Sure, that's the idea.  Just change pci_alloc_consistent to
> dev_alloc_consistent whatever. 

Change, and fix up that lack of error codes on the mapping calls, and
maybe a few other things ... :)

Certainly hanging some sort of memory allocator object off struct device
should be pretty cheap.  At least for USB, all devices on the same bus
could share the same allocator.  Not that I know PCI that well, but I
suspect that could be true there too ... more sharing, less internal
fragmentation, and more efficient use of various resources.

- Dave





