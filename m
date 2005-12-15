Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbVLOWSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbVLOWSR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 17:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbVLOWSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 17:18:17 -0500
Received: from rtsoft3.corbina.net ([85.21.88.6]:41339 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S1751133AbVLOWSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 17:18:15 -0500
Message-ID: <43A1EB94.5040300@ru.mvista.com>
Date: Fri, 16 Dec 2005 01:17:56 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: spi-devel-general@lists.sourceforge.net, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, dpervushin@gmail.com, akpm@osdl.org,
       basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, Joachim_Jaeger@digi.com
Subject: Re: [spi-devel-general] Re: [PATCH/RFC] SPI: add DMAUNSAFE analog
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <200512141102.53599.david-b@pacbell.net> <43A1118E.9040608@ru.mvista.com> <200512151206.26515.david-b@pacbell.net>
In-Reply-To: <200512151206.26515.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>On Wednesday 14 December 2005 10:47 pm, Vitaly Wool wrote:
>
>  
>
>>One cannot allocate memory in interrupt context, so the way to go is 
>>allocating it on stack, thus the buffer is not DMA-safe.
>>    
>>
>
>kmalloc(..., GFP_ATOMIC) is the way to allocate memory in irq context.
>It's done that way throughout the kernel.
>  
>
It's not applicable within the RT-related changes. kmalloc anyway takes 
mutexes, so allocationg it in interrupt context is buggy.
*Legacy* kernel code does that but why produce a new code with that?

>
>  
>
>>Making it DMA-safe in thread that does the very message processing is a 
>>good way of overcoming this.
>>    
>>
>
>The rest of Linux appears to work fine without needing such mechanisms...
>  
>
The rest of Linux still has a lot of bugs. Noone I guess is ready to 
argue that.

>I really fail to see why you think SPI needs that.  USB isn't the only
>counterexample, but it's particularly relevant since both USB and SPI
>use asynchronous message passing over serial links ... and USB has a
>rather complete driver stack over it.   (None of the USB based WLAN
>drivers need those static buffers you worry about, by the way...)
>  
>
I haven't heard of USB device registers needing to be written in IRQ 
context. I'm not that well familiar with USB, so if you give such an 
example, that'd be fine.

>>Using preallocated buffer is not a good way, since it may well be 
>>already used by another interrupt or not yet processed by the worker 
>>thread (or tasklet, or whatever).
>>    
>>
>
>We would call those "driver bugs" and expect patches.  :)
>
>  
>
Well, I know one such patch ;)

>>One can not predict how many transfers are  
>>gonna be dropped due to "previous trransfer is being processed" problem, 
>>it depends on the system load. And though it's not a problem for 
>>touchscreen, it *will* be a problem if it were MMC, for instance.
>>    
>>
>
>Huh, well I've already seen one nice "mmc/sd over SPI" driver, using
>a slightly earlier version of the framework than is found in mm3.
>It's being used for root filesystems.
>
>So demonstrably there is no problem for MMC/SD, either.
>  
>
No problem... Has the driver been tested in stress conditions? If not, 
then I guess you can't say this for sure :)

Vitaly
