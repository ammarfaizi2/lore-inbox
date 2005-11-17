Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbVKQJ1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbVKQJ1t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 04:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbVKQJ1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 04:27:49 -0500
Received: from [85.8.13.51] ([85.8.13.51]:4253 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750716AbVKQJ1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 04:27:48 -0500
Message-ID: <437C4D14.1030101@drzeus.cx>
Date: Thu, 17 Nov 2005 10:27:48 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.5 (X11/20051105)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: IOMMU and scatterlist limits
References: <437C40AE.2020309@drzeus.cx> <20051117085432.GY7787@suse.de> <437C4728.9060205@drzeus.cx> <20051117091308.GZ7787@suse.de>
In-Reply-To: <20051117091308.GZ7787@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Thu, Nov 17 2005, Pierre Ossman wrote:
>   
>> Jens Axboe wrote:
>>     
>>>     
>>>       
>>> What kind of hardware can't handle scatter gather?
>>>
>>>   
>>>       
>> I'd figure most hardware? DMA is handled by writing the start address
>> into one register and a size into another. Being able to set several
>> addr/len pairs seems highly advanced to me. :)
>>     
>
> Must be a pretty nice rock you are living behind, since it's apparently
> kept you there for a long time :-)
>
>   

The driver support is simply too good in Linux so I haven't had the need
for writing a PCI driver until now. ;)

> Sane hardware will accept an sg list directly. Are you sure you are
> reading the specifications for that hardware correctly?
>
>   

Specifications? Such luxury. This driver is based on googling and
reverse engineering. Any requests for specifications have so far been
put in the round filing cabinet.

What I know is that I have the registers:

* System address (32 bit)
* Block size (16 bit)
* Block count (16 bit)

>From what I've seen these are written to once. So I'm having a hard time
believing these support more than one segment.

>>>   
>>>       
>> And nr_phys_segments? I haven't really grasped the relation between the
>> two. Is this the number of segments handed to the IOMMU? If so, then I
>> would need to know how many it can handle (and set it to one if there is
>> no IOMMU).
>>     
>
> nr_phys_segments is basically just to cap the segments somewhere, since
> the driver needs to store it before getting it dma mapped to a (perhaps)
> smaller number of segments. So yes, it's the number of 'real' segments
> before dma mapping.
>
>   

So from a driver point of view, this is just a matter of memory usage?
In that case, what is a good value? =)

Since there is no guarantee this will be mapped down to one segment
(that the hardware can accept), is it expected that the driver iterates
over the entire list or can I mark only the first segment as completed
and wait for the request to be reissued? (this is a MMC driver, which
behaves like the block layer)

>>> That'll work irregardless of whether there's an IOMMU there or not. Note
>>> that the mere existence of an IOMMU will _not_ save your performance on
>>> this hardware, you need one with good virtual merging support to get
>>> larger transfers.
>>>
>>>   
>>>       
>> I thought the IOMMU could do the merging through its mapping tables? The
>> way I understood it, sg support in the device was just to avoid wasting
>> resources on the IOMMU by using fewer mappings (which would assume the
>> IOMMU is segment based, not page based).
>>     
>
> Depends on the IOMMU. Some IOMMUs just help you with address remapping
> for high addresses. The way I see it, with just 1 segment you need to be
> pretty damn picky with your hardware about what platform you use it on
> or risk losing 50% performance or so.
>
>   

Ok. Being a block device, the segments are usually rather large so the
overhead of setting up many DMA transfers shouldn't be that terrible.

Rgds
Pierre

