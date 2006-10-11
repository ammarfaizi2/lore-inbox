Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161093AbWJKPvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161093AbWJKPvp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 11:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161091AbWJKPvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 11:51:45 -0400
Received: from outbound-blu.frontbridge.com ([65.55.251.16]:24633 "EHLO
	outbound2-blu-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1161088AbWJKPvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 11:51:43 -0400
X-BigFish: V
Message-ID: <452D1223.4090403@am.sony.com>
Date: Wed, 11 Oct 2006 08:47:47 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
CC: jschopp <jschopp@austin.ibm.com>, akpm@osdl.org, jeff@garzik.org,
       Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 21/21]: powerpc/cell spidernet DMA coalescing
References: <20061010204946.GW4381@austin.ibm.com> <20061010212324.GR4381@austin.ibm.com> <452C2AAA.5070001@austin.ibm.com> <452C4CE0.5010607@am.sony.com> <20061011152016.GU4381@austin.ibm.com>
In-Reply-To: <20061011152016.GU4381@austin.ibm.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Oct 2006 15:47:47.0495 (UTC) FILETIME=[997B9B70:01C6ED4C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas wrote:
> On Tue, Oct 10, 2006 at 06:46:08PM -0700, Geoff Levand wrote:
>> > Linas Vepstas wrote:
>> >> The current driver code performs 512 DMA mappns of a bunch of 
>> >> 32-byte structures. This is silly, as they are all in contiguous 
>> >> memory. Ths patch changes the code to DMA map the entie area
>> >> with just one call.
>> 
>> Linas, 
>> 
>> Is the motivation for this change to improve performance by reducing the overhead
>> of the mapping calls?  
> 
> Yes.
> 
>> If so, there may be some benefit for some systems.  Could
>> you please elaborate?
> 
> I started writingthe patch thinking it will have some huge effect on
> performance, based on a false assumption on how i/o was done on this
> machine
> 
> *If* this were another pSeries system, then each call to 
> pci_map_single() chews up an actual hardware "translation 
> control entry" (TCE) that maps pci bus addresses into 
> system RAM addresses. These are somewhat limited resources,
> and so one shouldn't squander them.  Furthermore, I thouhght
> TCE's have TLB's associated with them (similar to how virtual
> memory page tables are backed by hardware page TLB's), of which 
> there are even less of. I was thinking that TLB thrashing would 
> have a big hit on performance. 
> 
> Turns out that there was no difference to performance at all, 
> and a quick look at "cell_map_single()" in arch/powerpc/platforms/cell
> made it clear why: there's no fancy i/o address mapping.

OK, thanks for the explanation.  Actually, the current cell DMA mapping
implementation uses a simple 'linear' mapping, in that, all of RAM is
mapped into the bus DMA address space at once, and in fact, it is all
just done at system startup.

There is ongoing work to implement 'dynamic' mapping, where DMA pages are
mapped into the bus DMA address space on demand.  I think a key point to
understand the benefit to this is that the cell processor's I/O controller
maps pages per device, so you can map one DMA page to one device.  I
currently have this working for my platform, but have not released that
work.  There is some overhead to managing the mapped buffers and to request
pages be mapped by the hypervisor, etc., so I was thinking that is this work
of yours to consolidate the memory buffers prior to requesting the mapping
could be of benefit if it was in an often executed code path.

-Geoff

