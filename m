Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266423AbUGBDLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266423AbUGBDLI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 23:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266425AbUGBDLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 23:11:08 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:33734 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S266423AbUGBDLC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 23:11:02 -0400
Message-ID: <40E4D180.7070104@pacbell.net>
Date: Thu, 01 Jul 2004 20:07:44 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: Ian Molton <spyro@f2s.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       tony@atomide.com, jamey.hicks@hp.com, joshua@joshuawise.com,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [RFC] on-chip coherent memory API for DMA
References: <1088518868.1862.18.camel@mulgrave>		<40E41BE1.1010003@pacbell.net>	<1088692004.1887.8.camel@mulgrave> 	<40E42374.8060407@pacbell.net>	<1088705063.1919.16.camel@mulgrave>  <40E470A9.3000908@pacbell.net> <1088714925.2039.20.camel@mulgrave>
In-Reply-To: <1088714925.2039.20.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Thu, 2004-07-01 at 15:14, David Brownell wrote:
> 
>>That can work when the scope of "DMA" knowledge is just
>>one driver ... but when that driver is plugging into a
>>framework, it's as likely to be some other code (maybe
>>a higher level driver) that just wants RAM address space
>>which, for whatever reasons, is DMA-coherent.  And hey,
>>the way to get this is dma_alloc_coherent ... or in some
>>cases, pci_alloc_consistent.
> 
> 
> If the driver can't cope then you *only* use DMA_MEMORY_MAP

That would be the norm for all those low-level drivers,
certainly.  Except maybe on that one mysterious box,
where the CPU can't access that memory directly ... ;)


>>Which is why my comment was that the new feature of
>>returning some kind of memory cookie usable on that one
>>IBM box (etc) should just use a different allocator API.
>>It doesn't allocate RAM "similarly to __get_free_pages";
>>it'd be returning something drivers can't treat as RAM.
> 
> 
> Well, I don't believe it will be necessary.  However, when an actual
> user comes along, we'll find out.

OK, I can easily view DMA_MEMORY_IO as an API experiment.


> It is no-longer real memory once you use this API.  Even if the
> processor can treat DMA_MEMORY_MAP memory as "real", you'll probably
> find that a device off on another bus cannot even see it.  However, as
> long as you keep the memory between the processor and the device then
> you can treat it identical to RAM.

I'm not sure I see what you're saying.  The only guarantees on
the memory are that "the" CPU and the device can both access
it like memory.  Other devices are out-of-scope, as is location
(anywhere both can access it like normal memory, not just stuff
that's "between" the two on some bus).  It's DMA_MEMORY_IO that
you said would not be RAM-like ("directly writable"), and would
need I/O memory accessors like readl/writel/etc ... to the
device it looks like normal RAM, but not to the host.



> The intention of the flags option for dma_alloc_coherent() was only for
> memory allocation instructions; the allocation can fail for other
> reasons that unavailability of memory depending on how the API is
> implemented, so __GFP_NOFAIL doesn't actually work now in every case. 

I personally think __GFP_WAIT is the most important one, but
some folk have other priorities.  Regardless, I _was_ talking
about passing flags down to the memory allocator, so it sounds
like it was just an oversight in this initial version.

- Dave




