Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbVJFE5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbVJFE5X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 00:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbVJFE5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 00:57:23 -0400
Received: from [85.21.88.2] ([85.21.88.2]:8110 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S1751225AbVJFE5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 00:57:22 -0400
Message-ID: <4344AEAA.7030309@ru.mvista.com>
Date: Thu, 06 Oct 2005 08:57:14 +0400
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC 0/2] simple SPI framework, refresh + ads7864 driver
References: <20051005162117.24DDBEE95B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
In-Reply-To: <20051005162117.24DDBEE95B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>>Of course we want to use scatter-gather lists.
>>    
>>
>
>The only way "of course" applies is if you're accepting requests
>from the block layer, which talks in terms of "struct scatterlist".
>
>In my investigations of SPI, I don't happen to have come across any
>SPI slave device that would naturally be handled as a block device.
>There's lots of flash (and dataflash); that's MTD, not block.
>  
>
What about SD controllers on SPI bus? I did work with 2. ;-)

>
>  
>
>>	The DMA controller 
>>mentioned above can handle only 0xFFF transfer units at a transfer so we 
>>have to split the large transfers into SG lists.
>>    
>>
>
>Odd, I've seen plenty other drivers that just segment large buffers
>into multiple DMA transfers ... without wanting "struct scatterlist".
>  
>
I didn't claim that scatterlist is to be used. We use 'hardware-driven' 
structures for sg lists.

>  - More often they just break big buffers into lots of little
>    transfers.  Just like PIO, but faster.  (And in fact, they may
>    need to prime the pump with some PIO to align the buffer.)
>  
>
That won't work in some cases, as SPI might generate additional clock 
cycles after each transfer which won't happen un case of real sg transfer.

>  - Sometimes they just reject segments that are too large to
>    handle cleanly at a low level, and require higher level code
>    to provide more byte-sized blocks of I/O.
>  
>
It's possible in some cases but won't work in other. See above.

>If "now" _were_ the point we need to handle scatterlists, I've shown
>a nice efficient way to handle them, already well proven in the context
>of another serial bus protocol (USB).
>
>
>  
>
>>Moreover, that looks like it may imply redundant data copying.
>>    
>>
>
>Absolutely not.  Everything was aimed at zero-copy I/O; why do
>you think I carefully described "DMA mapping" everywhere, rather
>than "memcpy"?
>
>  
>
I'm afraid that copying may be implicit.

>  
>
>>Can you please elaborate what you meant by 'readiness to accept DMA 
>>addresses' for the controller drivers?
>>    
>>
>
>Go look at the parts of the USB stack I mentioned.  That's what I mean.
>
> - In the one case, DMA-aware controller drivers look at each buffer
>   to determine whether they have to manage the mappings themselves.
>   If the caller provided the DMA address, they won't set up mappings.
>
> - In the other case, they always expect their caller to have set
>   up the DMA mappings.  (Where "caller" is infrastructure code,
>   not the actual driver issuing the I/O request.)
>
>The guts of such drivers would only talk in terms of DMA; the way those
>cases differ is how the driver entry/exit points ensure that can be done.
>
>
>  
>
>>As far as I see it now, the whole thing looks wrong. The thing that we 
>>suggest (i. e. abstract handles for memory allocation set to kmalloc by 
>>default) is looking far better IMHO and doesn't require any flags which 
>>usage increases uncertainty in the core.
>>    
>>
>
>You are conflating memory allocation with DMA mapping.  Those notions
>are quite distinct, except for dma_alloc_coherent() where one operation
>does both.
>
>The normal goal for drivers is to accept buffers allocated from anywhere
>that Documentation/DMA-mapping.txt describes as being DMA-safe ... and
>less often, message passing frameworks will do what USB does and accept
>DMA addresses rather than CPU addresses.
>  
>
As for our core implementation it's totally agnostic about what kind of 
addresses is used and what way it should be handled in; it's all left 
for controller driver to decide. I still think it's far better approach 
than lotsa pointers and flags.

Vitaly
