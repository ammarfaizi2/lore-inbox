Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbVLNRzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbVLNRzj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 12:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbVLNRzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 12:55:39 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:930 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932465AbVLNRzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 12:55:38 -0500
Message-ID: <43A05B58.4030009@ru.mvista.com>
Date: Wed, 14 Dec 2005 20:50:16 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       dpervushin@gmail.com, akpm@osdl.org, basicmark@yahoo.com,
       komal_shah802003@yahoo.com, stephen@streetfiresound.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
Subject: Re: [PATCH/RFC] SPI: add DMAUNSAFE analog to David Brownell's core
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <20051213191531.GA13751@kroah.com> <43A0230B.1040904@ru.mvista.com> <200512140922.43877.david-b@pacbell.net>
In-Reply-To: <200512140922.43877.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>On Wednesday 14 December 2005 5:50 am, Vitaly Wool wrote:
>  
>
>>>>It's way better to just insist that all I/O buffers (in all
>>>>generic APIs) be DMA-safe.  AFAICT that's a pretty standard
>>>>rule everywhere in Linux.
>>>>        
>>>>
>>>I agree.  
>>>      
>>>
>>Well, why then David doesn't insist on that in his own code?
>>His synchronous transfer functions
>>
>>are allocating transfer buffers on  
>>stack which is not DMA-safe.
>>    
>>
>
>I think the very first version did that, but nothing since
>has taken that shortcut.  (Several months now.)  It uses
>a buffer that's allocated on the heap.
>  
>
You're wrong.
Isn't it a part of your code:

static inline ssize_t spi_w8r8(struct spi_device *spi, u8 cmd)
{
        ssize_t                 status;
        u8                      result;

        status = spi_write_then_read(spi, &cmd, 1, &result, 1);

        /* return negative errno or unsigned value */
        return (status < 0) ? status : result;
}

You're allocating u8 var on stack, then allocate a 1-byte-long buffer 
and copy the data instead of letting the controller driver decide 
whether this allocation/copy is necessary or not. And in 99% cases it's 
not gonna be necessary as any controller driver w/o brain damage will 
transfer this as PIO.
So the overhead for sending/receiving 1 byte will be _very big_ 
(trylock, kmalloc, memcpy). See now what I'm talking about?

>
>  
>
>>Then he starts messing with allocate-or-use-preallocated stuff etc. etc.
>>Why isn't he just kmalloc'ing/kfree'ing buffers each time these 
>>functions are called 
>>    
>>
>
>So that the typical case, with little SPI contention, doesn't
>hit the heap?  That's sure what I thought ... though I can't speak
>for what other people may think I thought.  You were the one that
>wanted to optimize the atypical case to remove a blocking path!
>  
>
I meant kmalloc'ing/kfree'ing buffers is spi_w8r8/spi_w8r16/etc.

Vitaly
