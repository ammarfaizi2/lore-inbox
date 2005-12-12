Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbVLLHKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbVLLHKR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 02:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbVLLHKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 02:10:17 -0500
Received: from rtsoft3.corbina.net ([85.21.88.6]:32859 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S1751101AbVLLHKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 02:10:13 -0500
Message-ID: <439D2241.3070901@ru.mvista.com>
Date: Mon, 12 Dec 2005 10:09:53 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org, dpervushin@gmail.com, akpm@osdl.org,
       greg@kroah.com, basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
Subject: Re: [spi-devel-general] Re: [PATCH 2.6-git] SPI core refresh
References: <20051201191109.40f2d04b.vwool@ru.mvista.com> <200512111217.33009.david-b@pacbell.net> <439CA488.3050302@ru.mvista.com> <200512111554.53143.david-b@pacbell.net>
In-Reply-To: <200512111554.53143.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>>I was trying to compare the approaches in a somehow deeper way.
>>That said, I meant that not exposing any structures you don't have to 
>>expose was usually a right way to do things.
>>We don't expose SPI message and you do.
>>    
>>
>
>What information there _isn't_ in the "have to expose" category?
>  
>
I'm sure that any message internals aren't; it leaves freedom to 
implement messages allocation in the way we like.

>Yours certainly has some ... clocks as per-message not per-device,
>and your message utilities still doing kmalloc() and memcpy() in
>places where it's not clearly necessary.  Plus the error-prone
>notion that completion callbacks could be optional, and a few
>other things I've pointed out previously.
>  
>
What's wrong with a) clocks per device b) no completion callback?
b) just makes it a sync call, it's a convenient thing for a developer.
As for places with kmalloc's and memcpy's, can you just point out one? 
I'm afraid it's all bare words here.
On the _contrary_, the approach we use allows to use lightweight 
non-standard allocation methods for messages which you just can't do.

>The choice of an array of spi_transfer rather than a custom
>singly linked list (not even list_head)?  I just picked the
>one with the smallest mandatory overhead (including adding the
>least number of fault cases to test and recover from).  Lots of
>APIs made the same choice; it works just fine here.  Heck, it's
>one of the few things here that resembles the I2C API!
>  
>
Yes, but the transfer array is not of a fixed size, therefore it's not 
that easy to use custom allocation techniques.
I'm afraid though that you don't quite understand what I'm meaning here, 
but you'll see it in the core I'll post today.

>
>  
>
>>On the other hand, our approach is flexible in means of message 
>>allocation. I. e. a small memory allocation library can be implemented 
>>transparently to device drivers that handles message allocation. It's 
>>very easy (and lightweight :)) since the message structure is always of 
>>a same length... Agree?
>>    
>>
>
>No, as I explained before.  But I'd not mind having optional layers
>like that, so long as they were in fact optional.  Yours is not; plus
>it's heavy-weight (embedding mallocation of dma bounce buffers and
>copying into/out of them, even when it's not necessary) and it's not
>refcounted.
>  
>
What? What optional layers are you talking about???
And please look *attentively* into the code, memory allocation/copying 
happens only if a specific flag is set so it's no way it can be unnecessary.

>
>  
>
>>>That said ... I know some people _do_ like krefcounted APIs that
>>>do that kind of stuff.  Strongly.  Greg's been silent here other
>>>than pointing out that your request alloc was too fat to inline.
>>>Mine is trivially inlined, but not refcounted.  Likely there's a
>>>happy middle ground, maybe
>>>
>>> mesg = spi_message_alloc(struct spi_device *, unsigned ntrans);
>>> mesg = spi_message_get(mesg);
>>> spi_message_put();
>>> 
>>>
>>>      
>>>
>>Well, it's pretty much what we do in the latest one...
>>    
>>
>
>No, you have no get/put krefcounting, and (to repeat an earlier
>comment) you also require "ntrans" separate allocations.  So
>"what 'we' do in the latest one" is substantially different.
>  
>
I was speaking about the API. Sorry for being not that clear here,

>
>  
>
>>Though we use one-by-one chaining and not specifying the number of 
>>messages in chain.
>>I'm not sure which approach is better, really.
>>    
>>
>
>In terms of potential faults that requires (debugging) driver code to
>recover from, having a single allocation is a clear win.  Have you
>ever noticed now many patches go into Linux to handle cases where
>driver fault cleanup got confused, and oopsed in one of the less
>common (but still observed in the Real World) scenarios?
>  
>
Not necessarily; if we've got a preallocated memory pool, than it's not 
that important.
On the contrary, having messages of a same size makes it easier for 
write a custom malloc routine.

Vitaly
