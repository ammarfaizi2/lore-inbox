Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbVLTLKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbVLTLKS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 06:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbVLTLKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 06:10:18 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:63053 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750899AbVLTLKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 06:10:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=bs+oVZzK9nG96tN/+uG3IgL2JG12RGqS4fwDJZMXu6cuyocwQXhluRkQUL5Gix8i1efoW6DSWP0BiUbiZqfj2HElxACeBFhKTEjNjZqlrJ0bMy+tSJJSKRB56qfcOzrR7fp7dDz9lPdh45FpCTJ4E2HrPPheYs6plzW0cgEvisk=
Message-ID: <43A7E692.90103@gmail.com>
Date: Tue, 20 Dec 2005 20:10:10 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>
CC: Jens Axboe <axboe@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: IOMMU and scatterlist limits
References: <437C40AE.2020309@drzeus.cx> <20051117085432.GY7787@suse.de> <437C4728.9060205@drzeus.cx> <20051117091308.GZ7787@suse.de> <437C4D14.1030101@drzeus.cx> <20051117093848.GA7787@suse.de> <43A5E5A6.4050505@drzeus.cx>
In-Reply-To: <43A5E5A6.4050505@drzeus.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
> Revisiting a dear old thread. :)
> 
> After some initial tests, some more questions popped up. See below.
> 
> Jens Axboe wrote:
> 
>>On Thu, Nov 17 2005, Pierre Ossman wrote:
>>  
>>
>>>Since there is no guarantee this will be mapped down to one segment
>>>(that the hardware can accept), is it expected that the driver iterates
>>>over the entire list or can I mark only the first segment as completed
>>>and wait for the request to be reissued? (this is a MMC driver, which
>>>behaves like the block layer)
>>>    
>>
>>Ah MMC, that explains a few things :-)
>>
>>It's quite legal (and possible) to partially handle a given request, you
>>are not obliged to handle a request as a single unit. See how other
>>block drivers have an end request handling function ala:
>>
>>  
> 
> 
> After testing this it seems the block layer never gives me more than
> max_hw_segs segments. Is it being clever because I'm compiling for a
> system without an IOMMU?
> 
> The hardware should (haven't properly tested this) be able to get new
> DMA addresses during a transfer. In essence scatter gather with some CPU
> support. Since I avoid MMC overhead this should give a nice performance
> boost. But this relies on the block layer giving me more than one
> segment. Do I need to lie in max_hw_segs to achieve this?
> 

Hi, Pierre.

max_phys_segments: the maximum number of segments in a request
		   *before* DMA mapping

max_hw_segments: the maximum number of segments in a request
		 *after* DMA mapping (ie. after IOMMU merging)

Those maximum numbers are for block layer.  Block layer must not exceed 
above limits when it passes a request downward.  As long as all entries 
in sg are processed, block layer doesn't care whether sg iteration is 
performed by the driver or hardware.

So, if you're gonna perform sg by iterating in the driver, what numbers 
to report for max_phys_segments and max_hw_segments is entirely upto how 
many entries the driver can handle.

Just report some nice number (64 or 128?) for both.  Don't forget that 
the number of sg entries can be decreased after DMA-mapping on machines 
with IOMMU.

IOW, the part which performs sg iteration gets to determine above 
limits.  In your case, the driver is reponsible for both iterations (pre 
and post DMA mapping), so all the limits are upto the driver.

Hope it helped.

-- 
tejun
