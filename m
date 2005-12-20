Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbVLTMEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbVLTMEo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 07:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbVLTMEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 07:04:44 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:4493 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750965AbVLTMEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 07:04:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=dcqnZx9wH2W6Nxnb0N1MVyUsjeiFfiS/zgNNtFusgGdVqBC0M29fJAthtqdyJDgPBeqbVKDy6ABV4JZco5ZlkQR07IcHFiMWfu4zHbJ9c+k/EF5w5iUaq/O6C7NiKjB74srFDkn3sxOGE/bgnieCK2jP0gLLAYEhOwnF+q8R0k8=
Message-ID: <43A7F356.90600@gmail.com>
Date: Tue, 20 Dec 2005 21:04:38 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>
CC: Jens Axboe <axboe@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: IOMMU and scatterlist limits
References: <437C40AE.2020309@drzeus.cx> <20051117085432.GY7787@suse.de> <437C4728.9060205@drzeus.cx> <20051117091308.GZ7787@suse.de> <437C4D14.1030101@drzeus.cx> <20051117093848.GA7787@suse.de> <43A5E5A6.4050505@drzeus.cx> <43A7E692.90103@gmail.com> <43A7ECCB.2060108@drzeus.cx>
In-Reply-To: <43A7ECCB.2060108@drzeus.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
> Tejun Heo wrote:
> 
>>Pierre Ossman wrote:
>>>
>>>After testing this it seems the block layer never gives me more than
>>>max_hw_segs segments. Is it being clever because I'm compiling for a
>>>system without an IOMMU?
>>>
>>>The hardware should (haven't properly tested this) be able to get new
>>>DMA addresses during a transfer. In essence scatter gather with some CPU
>>>support. Since I avoid MMC overhead this should give a nice performance
>>>boost. But this relies on the block layer giving me more than one
>>>segment. Do I need to lie in max_hw_segs to achieve this?
>>>
>>
>>Hi, Pierre.
>>
>>max_phys_segments: the maximum number of segments in a request
>>           *before* DMA mapping
>>
>>max_hw_segments: the maximum number of segments in a request
>>         *after* DMA mapping (ie. after IOMMU merging)
>>
>>Those maximum numbers are for block layer.  Block layer must not
>>exceed above limits when it passes a request downward.  As long as all
>>entries in sg are processed, block layer doesn't care whether sg
>>iteration is performed by the driver or hardware.
>>
>>So, if you're gonna perform sg by iterating in the driver, what
>>numbers to report for max_phys_segments and max_hw_segments is
>>entirely upto how many entries the driver can handle.
>>
>>Just report some nice number (64 or 128?) for both.  Don't forget that
>>the number of sg entries can be decreased after DMA-mapping on
>>machines with IOMMU.
>>
>>IOW, the part which performs sg iteration gets to determine above
>>limits.  In your case, the driver is reponsible for both iterations
>>(pre and post DMA mapping), so all the limits are upto the driver.
>>
>>
> 
> 
> I'm still a bit confused why the block layer needs to know the maximum
> number of hw segments. Different hardware might be connected to
> different IOMMU:s, so only the driver will now how much the number can
> be reduced. So the block layer should only care about not going above
> max_phys_segments, since that's what the driver has room for.
> 
> What is the scenario that requires both?
> 

Let's say there is a piece of (crap) controller which can handle 4 
segments; but the system has a powerful IOMMU which can merge pretty 
well.  The driver wants to handle large requests for performance but it 
doesn't want to break up requests itself (pretty pointless, block layer 
merges, driver breaks down).  A request should be large but not larger 
than what the hardware can take at once.

So, it uses max_phys_segments to tell block layer how many sg entries 
the driver is willing to handle (some arbitrary large number) and 
reports 4 for max_hw_segments letting block layer know that requests 
should not be more than 4 segments after DMA-mapping.

To sum up, block layer performs request sizing in favor of block 
drivers, so it needs to know the size limits.

Is this explanation any better than my previous one?  :-P

Also, theoretically there can be more than one IOMMUs on a system (is 
there already?).  Block layer isn't yet ready to handle such cases but 
when it becomes necessary, all that needed is to make currently global 
IOMMU merging parameters request queue specific and modify drivers such 
that they tell block layer their IOMMU parameters.

-- 
tejun
