Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266579AbUFRTZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266579AbUFRTZd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 15:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266580AbUFRTYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 15:24:35 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:64724 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S266579AbUFRTVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 15:21:15 -0400
Date: Fri, 18 Jun 2004 12:21:12 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Jamey Hicks <jamey.hicks@hp.com>
Cc: Matt Porter <mporter@kernel.crashing.org>, Ian Molton <spyro@f2s.com>,
       linux-kernel@vger.kernel.org, greg@kroah.com, tony@atomide.com,
       david-b@pacbell.net, joshua@joshuawise.com
Subject: Re: DMA API issues
Message-ID: <20040618122112.D3851@home.com>
References: <20040618175902.778e616a.spyro@f2s.com> <20040618110721.B3851@home.com> <40D3356E.8040800@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <40D3356E.8040800@hp.com>; from jamey.hicks@hp.com on Fri, Jun 18, 2004 at 02:33:18PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 02:33:18PM -0400, Jamey Hicks wrote:
> Matt Porter wrote:
> >On Fri, Jun 18, 2004 at 05:59:02PM +0100, Ian Molton wrote:
> >>1) The DMA API provides no methods to set up a mapping between the host
> >>   memory map and the devices view of the space
> >>        example:
> >>           the OHCI controller above would see its 32K of SRAM as
> >>           mapped from 0x10000 - 0x1ffff and not 0xXXX10000 - 0xXXX1ffff
> >>           which is the address the CPU sees.
> >>2) The DMA API assumes the device can access SDRAM
> >>        example:
> >>           the OHCI controller base is mapped at 0x10000000 on my platform.
> >>           this is NOT is SDRAM, its in IO space.
> >
> >Can't you just implement an arch-specific allocator for your 32KB
> >SRAM, then implement the DMA API streaming and dma_alloc/free APIs
> >on top of that?  Since this architecture is obviously not designed
> >for performance, it doesn't seem to be a big deal to have the streaming
> >APIs copy to/from the kmalloced (or whatever) buffer to/from the SRAM
> >allocated memory and then have those APIs return the proper dma_addr_t
> >for the embedded OHCI's address space view of the SRAM. Same thing
> >goes for implementing dma_alloc/free (used by dma_pool*). I don't
> >have the knowledge of USB subsystem buffer usage to know how quickly
> >that little 32KB of SRAM is going to run out. But at a DMA API level,
> >this seems doable, albeit with the greater possibility of negative
> >retvals from these calls.
> >
> Your analysis of what is needed is correct.  However, we would prefer to 
> fit this into the DMA API in a generic way, rather than having a 
> specialized API that is not acceptable upstream.  I'm more concerned 
> with finding the best way to address this problem than with whether this 
> is a 2.6 or 2.7 issue.
> 
> We do need a memory allocator for the pool of SRAM.  If we're not going 
> to have to build customized versions of the OHCI driver, we need that 
> pool hooked into the dma_pool and dma_alloc_coherent interfaces.  We 
> could do that with a platform specific implementation of 
> dma_alloc_coherent, but a pointer to dma_{alloc,free} from struct device 
> seems like a cleaner solution.  We also will need bounce buffers, as you 

Yes, it can be cleaner, but it's not something I would say is
completely broken with the DMA API.  It does provide a way to
make your device specific implementation, regardless of whether
it's managed ideally via a struct device pointer.  Migrating to
dev->dma* sounds suspiciously like a 2.7ism.

> described, but there is already a good start towards that support in 
> 2.6.  The other thing that might be needed is passing device to 

Where's that code?

> page_to_dma so that device specific dma addresses can be constructed.

A struct device argument to page_to_dma seems like a no brainer to be
included.
 
> Deepak Saxena wrote a pretty good summary as part if the discussion 
> about this issue on the linux-arm-kernel mailing list:
> 
> http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2004-June/022796.html

Ahh, ok.  Deepak and I have discussed this idea F2F on a several
occassions, I recall he needed it for the small floating PCI window
he has to manage on the IXP* ports.  It may help in some embedded
PPC areas as well.

> I think I'm looking for something like the PARISC hppa_dma_ops but more 
> generic:
>   
> http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2004-June/022813.html

I see that's somewhat like what David Brownell suggested before...a single
pointer to a set of dma ops from struct device.  hppa_dma_ops translated
into a generic dma_ops entity with fields corresponding to existing
DMA API calls would be a good starting point. We can get rid of some
address translation hacks in a lot of custom embedded PPC drivers
with something like this.

-Matt
