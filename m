Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbVLTLgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbVLTLgx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 06:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbVLTLgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 06:36:53 -0500
Received: from [85.8.13.51] ([85.8.13.51]:58036 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750950AbVLTLgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 06:36:52 -0500
Message-ID: <43A7ECCB.2060108@drzeus.cx>
Date: Tue, 20 Dec 2005 12:36:43 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.5 (X11/20051129)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Jens Axboe <axboe@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: IOMMU and scatterlist limits
References: <437C40AE.2020309@drzeus.cx> <20051117085432.GY7787@suse.de> <437C4728.9060205@drzeus.cx> <20051117091308.GZ7787@suse.de> <437C4D14.1030101@drzeus.cx> <20051117093848.GA7787@suse.de> <43A5E5A6.4050505@drzeus.cx> <43A7E692.90103@gmail.com>
In-Reply-To: <43A7E692.90103@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Pierre Ossman wrote:
>> Revisiting a dear old thread. :)
>>
>> After some initial tests, some more questions popped up. See below.
>>
>> Jens Axboe wrote:
>>
>>> On Thu, Nov 17 2005, Pierre Ossman wrote:
>>>  
>>>
>>>> Since there is no guarantee this will be mapped down to one segment
>>>> (that the hardware can accept), is it expected that the driver
>>>> iterates
>>>> over the entire list or can I mark only the first segment as completed
>>>> and wait for the request to be reissued? (this is a MMC driver, which
>>>> behaves like the block layer)
>>>>    
>>>
>>> Ah MMC, that explains a few things :-)
>>>
>>> It's quite legal (and possible) to partially handle a given request,
>>> you
>>> are not obliged to handle a request as a single unit. See how other
>>> block drivers have an end request handling function ala:
>>>
>>>  
>>
>>
>> After testing this it seems the block layer never gives me more than
>> max_hw_segs segments. Is it being clever because I'm compiling for a
>> system without an IOMMU?
>>
>> The hardware should (haven't properly tested this) be able to get new
>> DMA addresses during a transfer. In essence scatter gather with some CPU
>> support. Since I avoid MMC overhead this should give a nice performance
>> boost. But this relies on the block layer giving me more than one
>> segment. Do I need to lie in max_hw_segs to achieve this?
>>
>
> Hi, Pierre.
>
> max_phys_segments: the maximum number of segments in a request
>            *before* DMA mapping
>
> max_hw_segments: the maximum number of segments in a request
>          *after* DMA mapping (ie. after IOMMU merging)
>
> Those maximum numbers are for block layer.  Block layer must not
> exceed above limits when it passes a request downward.  As long as all
> entries in sg are processed, block layer doesn't care whether sg
> iteration is performed by the driver or hardware.
>
> So, if you're gonna perform sg by iterating in the driver, what
> numbers to report for max_phys_segments and max_hw_segments is
> entirely upto how many entries the driver can handle.
>
> Just report some nice number (64 or 128?) for both.  Don't forget that
> the number of sg entries can be decreased after DMA-mapping on
> machines with IOMMU.
>
> IOW, the part which performs sg iteration gets to determine above
> limits.  In your case, the driver is reponsible for both iterations
> (pre and post DMA mapping), so all the limits are upto the driver.
>
>

I'm still a bit confused why the block layer needs to know the maximum
number of hw segments. Different hardware might be connected to
different IOMMU:s, so only the driver will now how much the number can
be reduced. So the block layer should only care about not going above
max_phys_segments, since that's what the driver has room for.

What is the scenario that requires both?

Rgds
Pierre

