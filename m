Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbWECUfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWECUfO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 16:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWECUfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 16:35:07 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:28433 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750825AbWECUfF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 16:35:05 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <Pine.LNX.4.60.0605032109110.5865@poirot.grange>
X-OriginalArrivalTime: 03 May 2006 20:35:03.0897 (UTC) FILETIME=[0EAC1490:01C66EF1]
Content-class: urn:content-classes:message
Subject: Re: How to replace bus_to_virt()?
Date: Wed, 3 May 2006 16:35:03 -0400
Message-ID: <Pine.LNX.4.61.0605031615470.29989@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to replace bus_to_virt()?
thread-index: AcZu8Q6zYGUbS30tSRahi130ITyjag==
References: <4454CF35.7010803@s5r6.in-berlin.de> <1146412215.20760.10.camel@laptopd505.fenrus.org> <44554AFE.30804@s5r6.in-berlin.de> <Pine.LNX.4.60.0605032109110.5865@poirot.grange>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Guennadi Liakhovetski" <g.liakhovetski@gmx.de>
Cc: "Stefan Richter" <stefanr@s5r6.in-berlin.de>,
       "Arjan van de Ven" <arjan@infradead.org>,
       <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 May 2006, Guennadi Liakhovetski wrote:

> On Mon, 1 May 2006, Stefan Richter wrote:
>
>> Arjan van de Ven wrote:
>>> On Sun, 2006-04-30 at 16:52 +0200, Stefan Richter wrote:
>>>> is there a *direct* future-proof replacement for bus_to_virt()?
>>>>
>>>> It appears there are already architectures which do not define a
>>>> bus_to_virt() funtion or macro. If there isn't a direct replacement, is
>>>> there at least a way to detect at compile time whether bus_to_virt()
>>>> exists?
>>>
>>>
>>> I'd go one step further: given a world with iommu's, and multiple pci
>>> domains etc, how can you know there even IS such a translation possible
>>> (without first having set it up from the other direction)?
>>
>> Well, we actually do set it up from the other direction. But in a way that
>> does not work with IOMMUs...
>>
>> AFAIU, the patch "dc395x: dynamically map scatter-gather for PIO" [1] by
>> Guennadi Liakhovetski is dealing with the same issue. I am not yet clear
>> whether I could adopt this method for sbp2.
>> [1] http://marc.theaimsgroup.com/?l=linux-scsi&t=114400790300004
>
> I would be, obviously, interested to hear any results with that one.
>
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski

Just make your own macro! When they change the "@(#*%^+@~%" kernel,
which they will continue to do, just adapt your macro. You've
probably already figured out that, for ix86-32 bits (no extended
addressing), you OR in PAGE_OFFSET. That's an artifact of how the
pages tables are set up. Of course the space needs to have been
mapped! This means you get the address-space from ioremap_xx() or
from get_dma_pages(). You also need to fiddle with SetPageReserved()
if you get the pages from get_dma_pages() or else everything pretends
to work, but doesn't.



Something like:

Note, since this will fill in a DMA scatter-list with page-size
elements, the pages don't need to be continuous so I have a macro
called get_dma_page() that just gets a page of "order 1".

//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
//
//   Get some physical pages and lock them down into memory. Return
//   the number of pages available.
//
static int32_t get_pages(int32_t pages)
{
     int32_t i;
     uint32_t virt;
     release_pages();
     pages = (pages < NR_PAGES) ? pages : NR_PAGES;
     for(i=0; i< pages; i++)
     {
         if((virt = get_dma_page()) == 0)
             break;
         info->dma[i].loc = (void *) virt;
         info->dma[i].ram = virt_to_bus(info->dma[i].loc);
         SetPageReserved(virt_to_page(virt));
         memset(info->dma[i].loc, 0x00, PAGE_SIZE);     // Clear page
         *((char *)info->dma[i].loc) = (char) i;        // Mark it
     }
     return (info->pages = i);
}

Also note that linux-kernel hates posix integer types, even when
they are local to this file, so there will be lots of folks who
claim that you shouldn't write code like this. Others will claim
that everything should be done though pci_alloc_xxx(). Go figure!




Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
New book: http://www.lymanschool.com
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
