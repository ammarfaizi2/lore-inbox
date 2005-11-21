Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbVKUU4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbVKUU4Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 15:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbVKUU4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 15:56:16 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:16874 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1750793AbVKUU4P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 15:56:15 -0500
Message-ID: <4382346F.7080909@ru.mvista.com>
Date: Mon, 21 Nov 2005 23:56:15 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Underwood <basicmark@yahoo.com>
CC: dmitry pervushin <dpervushin@gmail.com>,
       David Brownell <david-b@pacbell.net>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       spi-devel-general@lists.sourceforge.net
Subject: Re: SPI
References: <20051121201547.78681.qmail@web36907.mail.mud.yahoo.com>
In-Reply-To: <20051121201547.78681.qmail@web36907.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Underwood wrote:

>>The list of main differences between David Brownell's SPI framework (A)
>>and my one (B):
>>- (A) uses more complicated structure of SPI message, that contains one
>>or more atomic transfers, and (B)
>> offers the only spi_msg that represents the atomic transfer on SPI bus.
>>The similar approach can be imple-
>> mented in (B), and actually is implemented. But my imp[ression is that
>>such enhancement may be added later..
>>    
>>
>
>I wouldn't have said that the message structure in (A) is more complex then (B). For example, in
>(B) you have many flags which controls things like SPI mode which are not needed in every message.
>Once the SPI controller has been setup for a particular slave device you don't need to constantly
>send this information. 
>In (B) how to do you handle SPI devices which require to send several messages with out releasing
>their cs? There are/will be some devices which require this. 
>  
>
Please see the explanation for the 'flags' in Documentation/spi.txt 
within the patch.

>  
>
>>- (A) uses workqueues to queue and handle SPI messages, and (B)
>>allocates the kernel thread to the same purpose.
>> Using workqueues is not very good solution in real-time environment; I
>>think that allocating and starting the 
>> separate thread will give us more predictable and stable results;
>>    
>>
>
>Where does (A) use a workqueue? (A) doesn't use a workqueue or thread and instead leaves it up to
>the adapter driver how to handle the messages that it gets sent (which in the case of some drivers
>will mean no thread or workqueue). (B) is _forcing_ a thread on the adapter which the adapter may
>not need. 
>  
>
I bet the drivers that don't need neither threads not workqueue there's 
no need in async transfers as well. :)
On the other hand, threads is a flexible mechanism for handling async 
stuff, and there won't be a lot of threads so the overhead won't be high.
You might also want to ask why you can't change the steering wheel 
placement in your car from right-side to rleft-side although you travel 
by car to continental Europe once per decade. ;-)

>  
>
>>- (A) has some assumptions on buffers that are passed down to spi
>>functions. If some controller driver (or bus driver
>> in terms of (B)) tries to perform DMA transfers, it must copy the
>>passed buffers to some memory allocated
>> using GFP_DMA flag and map it using dma_map_single. From the other
>>hand, (B) relies on callbacks provided 
>> by SPI device driver to allocate memory for DMA transfers, but keeps
>>ability to pass user-allocated buffers down
>> to SPI functions by specifying flags in SPI message. SPI message being
>>a fundamental essense looks better to me when 
>> it's as simple as possible. Especially when we don't lose any
>>flexibility which is exacly our case (buffers that are
>> allocated as well as message itself/provided by user, DMA-capable
>>buffers..)	
>>    
>>
>
>But allocating and freeing buffer is a core kernel thing not a SPI thing. To me you are adding
>more complexity then is needed and your saying this is keeping things simple? 
>  
>
I'm afraid that you're not quite getting the whole concept. The concept 
is to provide thorough and stable solution.
Given that the buffer passed is declared as, say, static, the whole 
kernel might crash if we try to pass it to DMA. David's core itself is 
not capable of filtering that and letting the driver decide adds more 
complexity to the driver.
If we're choosing between adding complexity to the core and adding it to 
the particular drivers, it's definitely better to add it to the core cuz 
it's done _once_.

>>- (A) uses standartized way to provide CS information, and (B) relies on
>>functional drivers callbacks, which looks more
>> flexible to me.
>>    
>>
>
>I'm not sure what you mean here. You need to provide the cs numbers with SPI device in order for
>the core to create the unique addres and entry in sysfs. 
>However, (A) is not checking to see if the cs that a registering device wants to use is already in
>use, this needs to be added, and the same is true for registering spi masters. 
>  
>
Can you please elaborate on that?

Vitaly
