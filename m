Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030303AbVLVWKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030303AbVLVWKU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 17:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbVLVWKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 17:10:20 -0500
Received: from rtsoft3.corbina.net ([85.21.88.6]:3504 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S1030303AbVLVWKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 17:10:18 -0500
Message-ID: <43AB243F.1000505@ru.mvista.com>
Date: Fri, 23 Dec 2005 01:10:07 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org, dpervushin@gmail.com, akpm@osdl.org,
       greg@kroah.com, basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
Subject: Re: [PATCH/RFC] SPI:  async message handing library update
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <200512181059.14301.david-b@pacbell.net> <43A84730.9020602@ru.mvista.com> <200512220928.34457.david-b@pacbell.net>
In-Reply-To: <200512220928.34457.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>>>	if (!spi->max_speed_hz)
>>>		spi->max_speed_hz = 500 * 1000;
>>>
>>>	/* nsecs = max(50, (clock period)/2), be optimistic */
>>>	cs->nsecs = (1000000000/2) / (spi->max_speed_hz);
>>>	if (cs->nsecs < 50)
>>>		cs->nsecs = 50;
>>> 
>>>
>>>      
>>>
>>Suggest not to hardcode values here.
>>    
>>
>
>I suppose it'd make sense to just fail if max_speed_hz is invalid,
>and if there's some board that an bitbang at over 10MHz we should
>avoid getting in its way.
>  
>
Well, why do this?

>>>			/* protocol tweaks before next transfer */
>>>			if (t->delay_usecs)
>>>				udelay(t->delay_usecs);
>>> 
>>>
>>>      
>>>
>>Suggest nsecs here as well.
>>    
>>
>
>The relevant chip delays seem to be specified in usecs ... I don't
>like using nsecs for the clock timings, but without doing that it'd
>be impractical to define rates at the levels the hardware actually
>uses.  There are still some "nsec" leakages out of the real-bitbang
>code up to the next level, fixable over time.
>
>  
>
Ok.

> 
>  
>
>>>                               /* FIXME if bitbang->use_dma, dma_map_single()
>>>                                * before the transfer, and dma_unmap_single()
>>>                                * afterwards, for either or both buffers...
>>>                                */  
>>>      
>>>
>>please *please* *_please_*!!! don't do it! :)
>>Let the controller driver do it *only in case it's not working in PIO!*
>>    
>>
>
>OK.  That'd be more work for the controller driver, but you're
>right that a lot of the drivers using these utilities are rather
>likely to be PIO-oriented.  If they want DMA speedups, they can
>do the mappings themselves (in cases where the driver didn't
>do them already).
>  
>
Agreed :)

>
>  
>
>>Another one: I just feel comfortabel with using 'bitbang' term for the 
>>variety of SPI stuff which this library suits.
>>    
>>
>
>You _do_ feel comfortable with it?  I actually feel a bit odd, since
>only one of the three driver types is really bitbanging.  And in fact
>it still bothers me that the other two tie down a task, but that's
>the price for reusing common infrastructure.
>  
>
Oh sorry, of course I meant "I just don't feel comfortable..."

BTW: the message handling is one per-transfer basis for bitbang. But in 
this case it's not possible to imlement chained DMA transfers (2 
channels, one for Rx, one for Tx, basically that's your sample use case :)

Vitaly
