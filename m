Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271984AbRHVSch>; Wed, 22 Aug 2001 14:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271975AbRHVSc1>; Wed, 22 Aug 2001 14:32:27 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:6149 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S271638AbRHVScT>; Wed, 22 Aug 2001 14:32:19 -0400
Message-Id: <200108221832.f7MIWHY13542@aslan.scsiguy.com>
To: "David S. Miller" <davem@redhat.com>
cc: axboe@suse.de, skraw@ithnet.com, phillips@bonn-fries.net,
        linux-kernel@vger.kernel.org
Subject: Re: With Daniel Phillips Patch 
In-Reply-To: Your message of "Wed, 22 Aug 2001 08:05:40 PDT."
             <20010822.080540.35030343.davem@redhat.com> 
Date: Wed, 22 Aug 2001 12:32:17 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   From: "Justin T. Gibbs" <gibbs@scsiguy.com>
>   Date: Wed, 22 Aug 2001 07:24:29 -0600
>   
>   Is this somehow different than how large DMA is done on the ia64
>   port?  All I do is look at the size of dma_addr_t to decide whether
>   to enable high address support in my driver.  If dma_addr_t's size
>   changes, then 64bit addressing will work the same as on every other
>   Linux port.
>
>It is totally different.

In looking at the documentation, it really doesn't seem much different
at all.  All you've done is force there to be two types and two APIs,
instead of one of each, for accessing dma addresses.  I would like the
change much better if the size of dma_addr_t simply changed to be
64bits wide if high mem support is enabled in your kernel config.
That the high 32bits may be empty or not even looked at by some
device (as you describe in DMA-mapping.txt) isn't much of a concern.
Sure, you need the other API changes to more finely set dma characteristics,
but having two APIs just complicates life for the device driver.  You'll
see why I say this below.

>The ia64 method, while it worked for ia64, could not work properly on
>just about any other platform.  For example, it assumed that any
>physical address could be represented by a kernel virtual address.

>From the device driver's point of view, this wasn't the case.
The driver asks to have the data mapped into an address that
its dma engine can understand and the system is supposed to do that
mapping.  Whether an IOMMU or some other piece of hardware was involved
didn't matter to the driver.  Well, it might matter because, at least
in the ia64 case, resource shortages result in a panic instead of an
error code being returned that you could do something reasonable with.
Now I just need to stick some "64"'s into my API calls to get the same
effect I currently have on IA64.  The fact that the back end that supports
the mapping changed shouldn't effect the driver.

>It also assumed that using SAC or DAC addressing was simply a matter of
>"does the device support it", and the world is far from being that simple :-)

Can you enumerate the devices that actually issue a DAC when loaded with
a 64bit address with 0's in the most significant 32bits?

>I note that the aic7xxx won't be usable for DAC cycles on many
>platforms since not all 64-bits are significant :-(

This isn't true.  The hardware supports all 64bits, but I've only
implemented two of the three expected S/G formats:

1) 4byte address/3byte count/7bits pad/1bit end of list
2) 4byte address/3byte count/7bits extended address/1bit end of list
and NYI
3) 8byte address/3byte count/7bits pad/1bit end of list

The first is the most efficient as the firmware doesn't have to bother
(or have the code) to load the high address bits.  The second works for
many platforms but doesn't take any additional space up for S/G lists.
The last can be implemented and enabled on any platforms that really need it.

With formats 1 and 2, the choice of what to use can easily be done at
driver initalization time.  If you determine that high mappings will
never be needed, why do the extra work?  Now that I'm supposed to use
two differnt apis depending on what capabilities I enable in my driver,
I'll have to add more bloat to my mapping routine (two func calls that do
almost exact the same thing, gated by a test - or use an indirect function
call).  Perhaps I'll just wrap everything into macros and make it a compile
time option.

--
Justin
