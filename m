Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265469AbSL1T5Y>; Sat, 28 Dec 2002 14:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265470AbSL1T5X>; Sat, 28 Dec 2002 14:57:23 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:31144 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S265469AbSL1T5X>;
	Sat, 28 Dec 2002 14:57:23 -0500
Message-ID: <3E0E0412.20303@colorfullife.com>
Date: Sat, 28 Dec 2002 21:05:38 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFT][PATCH] generic device DMA implementation
References: <200212281840.gBSIeBB02996@localhost.localdomain>
In-Reply-To: <200212281840.gBSIeBB02996@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:

>manfred@colorfullife.com said:
>  
>
>>If multiple kmalloc buffers fit into one cacheline, then it can happen
>> all the time. But the smallest kmalloc buffer is 64 bytes [assuming
>>page  size > 4096].
>>    
>>
>
>Actually, I did forget to mention that on parisc non-coherent, the minimum 
>kmalloc allocation is the cache line width, so that problem cannot occur.
>
>Hmm, perhaps that is an easier (and faster) approach to fixing the problems on 
>non-coherent platforms?
>  
>
How do you want to fix sendfile()?
Note that I'm thinking along the same line as reading an unaligned 
integer: the arch must provide a trap handler that emulates misaligned 
reads, but it should never happen, except if someone manually creates an 
IP packet with odd options to perform an DoS attack. Restricting kmalloc 
is obviously faster, but I'm not convinced that this really catches all 
corner cases.

A memcpy() based dma_map implementation would have another advantage: 
enable it on i386, and you'll catch everyone that violates the dma spec 
immediately.

The only problem is that the API is bad - networking buffers are usually 
2 kB allocations, 2 kB aligned.
The actual data area that is passed to pci_map_single starts at offset 2 
and has an odd length. It's not possible to pass the information to 
dma_map_single() that the rest of the cacheline is unused and that 
double buffering is not required, despite the misaligned case.
Except for sendfile(), then double buffering is necessary.

--
    Manfred

