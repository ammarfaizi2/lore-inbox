Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbVLNULW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbVLNULW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 15:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbVLNULW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 15:11:22 -0500
Received: from rtsoft3.corbina.net ([85.21.88.6]:3953 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S964923AbVLNULV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 15:11:21 -0500
Message-ID: <43A07C59.4050807@ru.mvista.com>
Date: Wed, 14 Dec 2005 23:11:05 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       dpervushin@gmail.com, akpm@osdl.org, basicmark@yahoo.com,
       komal_shah802003@yahoo.com, stephen@streetfiresound.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
Subject: Re: [PATCH/RFC] SPI: add DMAUNSAFE analog
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <200512140922.43877.david-b@pacbell.net> <43A05B58.4030009@ru.mvista.com> <200512141117.11244.david-b@pacbell.net>
In-Reply-To: <200512141117.11244.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>>static inline ssize_t spi_w8r8(struct spi_device *spi, u8 cmd)
>>{
>>        ssize_t                 status;
>>        u8                      result;
>>
>>        status = spi_write_then_read(spi, &cmd, 1, &result, 1);
>>
>>        /* return negative errno or unsigned value */
>>        return (status < 0) ? status : result;
>>}
>>
>>You're allocating u8 var on stack, then allocate a 1-byte-long buffer 
>>and copy the data instead of letting the controller driver decide 
>>whether this allocation/copy is necessary or not.
>>    
>>
>
>Yeah, like that matters in the face of the overhead to queue
>the message, get to the head of the SPI transfer queue, go
>through that queue, then finally wake up the task that was
>synchronously blocking in write_then_read().  Oh, and since
>that's inlined, GCC may be re-using existing state...
>
>If folk want an "it looks simple" convenient/friendly API,
>there is always a price to pay.  In this case, that cost is
>dwarfed by the mere fact that they're using a synchronous
>model to access shared resources (the SPI controller).
>  
>
It's just words; the patch I'm proposing cuts this price to nothing but 
you're just being too stubborn to accept that. :(

>
>  
>
>>>>Then he starts messing with allocate-or-use-preallocated stuff etc. etc.
>>>>Why isn't he just kmalloc'ing/kfree'ing buffers each time these 
>>>>functions are called 
>>>>        
>>>>
>>>So that the typical case, with little SPI contention, doesn't
>>>hit the heap?  That's sure what I thought ... though I can't speak
>>>for what other people may think I thought.  You were the one that
>>>wanted to optimize the atypical case to remove a blocking path!
>>>      
>>>
>> 
>>I meant kmalloc'ing/kfree'ing buffers is spi_w8r8/spi_w8r16/etc.
>>    
>>
>
>As I said:  so the _typical_ case doesn't hit the heap.   There are
>inherent overheads for such RPC-style calls.  But there's also no
>point in gratuitously increasing 
>
Sorry, increasing what?

Okay, lemme summarize: I've spent a day working out the minimal changes 
I'd like to have added to your core and two days trying to convince 
those changes are necessary. You just don't want to listen to me. So the 
conclusion is that the convergence process has been deadlocked, and the 
only way out for us is -- we'll continue to work on our core, as 
there're things we'd like to have in SPI core and there're other people 
using our core.

Vitaly
