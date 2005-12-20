Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbVLTM2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbVLTM2H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 07:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbVLTM2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 07:28:07 -0500
Received: from [85.8.13.51] ([85.8.13.51]:63924 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750975AbVLTM2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 07:28:05 -0500
Message-ID: <43A7F8D1.7040807@drzeus.cx>
Date: Tue, 20 Dec 2005 13:28:01 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.5 (X11/20051129)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Jens Axboe <axboe@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: IOMMU and scatterlist limits
References: <437C40AE.2020309@drzeus.cx> <20051117085432.GY7787@suse.de> <437C4728.9060205@drzeus.cx> <20051117091308.GZ7787@suse.de> <437C4D14.1030101@drzeus.cx> <20051117093848.GA7787@suse.de> <43A5E5A6.4050505@drzeus.cx> <43A7E692.90103@gmail.com> <43A7ECCB.2060108@drzeus.cx> <43A7F356.90600@gmail.com>
In-Reply-To: <43A7F356.90600@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Pierre Ossman wrote:
>>
>> I'm still a bit confused why the block layer needs to know the maximum
>> number of hw segments. Different hardware might be connected to
>> different IOMMU:s, so only the driver will now how much the number can
>> be reduced. So the block layer should only care about not going above
>> max_phys_segments, since that's what the driver has room for.
>>
>> What is the scenario that requires both?
>>
>
> Let's say there is a piece of (crap) controller which can handle 4
> segments; but the system has a powerful IOMMU which can merge pretty
> well.  The driver wants to handle large requests for performance but
> it doesn't want to break up requests itself (pretty pointless, block
> layer merges, driver breaks down).  A request should be large but not
> larger than what the hardware can take at once.
>
> So, it uses max_phys_segments to tell block layer how many sg entries
> the driver is willing to handle (some arbitrary large number) and
> reports 4 for max_hw_segments letting block layer know that requests
> should not be more than 4 segments after DMA-mapping.
>
> To sum up, block layer performs request sizing in favor of block
> drivers, so it needs to know the size limits.
>
> Is this explanation any better than my previous one?  :-P
>
> Also, theoretically there can be more than one IOMMUs on a system (is
> there already?).  Block layer isn't yet ready to handle such cases but
> when it becomes necessary, all that needed is to make currently global
> IOMMU merging parameters request queue specific and modify drivers
> such that they tell block layer their IOMMU parameters.
>

Ahh. I thought the block layer wasn't aware of any IOMMU. Since I saw
those as bus specific I figured only the DMA APIs, which have access to
the device object, could know which IOMMU was to be used and how it
would merge segments.

So in my case I'll have to lie to the block layer. Iterating in the
driver will be much faster than having to do an entire new transfer.

Thanks for clearing things up. :)

Rgds
Pierre
