Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWIVTr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWIVTr2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 15:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWIVTr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 15:47:28 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33948 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964818AbWIVTr2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 15:47:28 -0400
Subject: Re: [RFC] Initial alpha-0 for new page allocator API
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Christoph Lameter <clameter@sgi.com>, Martin Bligh <mbligh@mbligh.org>,
       akpm@google.com, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       James Bottomley <James.Bottomley@steeleye.com>, linux-mm@kvack.org
In-Reply-To: <200609222110.25118.ak@suse.de>
References: <Pine.LNX.4.64.0609212052280.4736@schroedinger.engr.sgi.com>
	 <200609220817.59801.ak@suse.de>
	 <Pine.LNX.4.64.0609220934040.7083@schroedinger.engr.sgi.com>
	 <200609222110.25118.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 22 Sep 2006 21:10:50 +0100
Message-Id: <1158955850.24572.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-09-22 am 21:10 +0200, ysgrifennodd Andi Kleen:
> We already have that scheme. Any existing driver should be already converted
> away from GFP_DMA towards dma_*/pci_*. dma_* knows all the magic
> how to get memory for the various ranges. No need to mess up the 
> main allocator.

Add an isa_device class and that'll fall into place nicely. isa_alloc_*
will end up asking for 20bit DMA and it will work nicely.

> Anyways, i suppose what could be added as a fallback would be a 
> really_slow_brute_force_try_to_get_something_in_this_range() allocator

Implementation detail although I note that the defrag/antifrag proposal
made at the vm summit would mean it mostly come out for free. If we have
an isa_dma_* API then the detail is platform specific. 

> that basically goes through the buddy lists freeing in >O(1) 
> and does some directed reclaim, but that would likely be a separate
> path anyways and not need your new structure to impact the O(1)
> allocator.

Just search within the candidate 4MB (or whatever it is these days)
chunks.

> I am still unconvinced of the real need. The only gaping hole was 
> GFP_DMA32, which we fixed already.

Various devices are 30 and 31bit today - some broadcom for example.

> Ok there is aacraid with its weird 2GB limit, 
> Ok now I'm sure someone will come up with a counter example (hi Alan), but:
> - Does the device really need more than 16MB?
> - How often is it used on systems with >1/2GB with a 64bit kernel?
> [consider that 64bit kernels don't support ISA]
> - How many users of that particular thing around?

Ok the examples I know about are
- ESS Maestro series audio - PCI, common on 32bit boxes a few years ago,
no longer shipped and unlikely to be met on 64bit. Also slow allocations
is fine.
- Some aacraid, mostly only for control structures. Those found on 64bit
are probably fine with slow alloc.
- Broadcom stuff - not sure if 30 or 31bit, around today and on 64bit
- Floppy controller

> I think my point stands.

I think its worthy of discussion.

