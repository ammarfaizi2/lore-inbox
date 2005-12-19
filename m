Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030273AbVLSHsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbVLSHsk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 02:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbVLSHsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 02:48:40 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:30438 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1030273AbVLSHsj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 02:48:39 -0500
Message-ID: <43A665F7.7020404@ru.mvista.com>
Date: Mon, 19 Dec 2005 10:49:11 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [PATCH/RFC] SPI core: turn transfers to be linked list
References: <43A480C0.9080201@ru.mvista.com> <200512181240.46841.david-b@pacbell.net>
In-Reply-To: <200512181240.46841.david-b@pacbell.net>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>On Saturday 17 December 2005 1:18 pm, Vitaly Wool wrote:
>  
>
>>Greetings,
>>
>>the patch attached changes the way transfers are chained in the SPI 
>>core. Namely, they are turned into linked lists instead of array. The 
>>reason behind is that we'd like to be able to use lightweight memory 
>>allocation  mechanism to use it in interrupt context. 
>>    
>>
>
>Hmm, color me confused.  Is there something preventing a driver from
>having its own freelist (or whatever), in cases where kmalloc doesn't
>suffice?  If not, why should the core change?  And what sort of driver
>measurements are you doing, to conclude that kmalloc doesn't suffice?
>  
>
Can't get what you're talking about. A freelist of what?
Basically the idea of the custom lightweight allocation is the 
following: allocate a page and divide into regions of the same size, 
initialize and use these regions as a stack.
Next, why the current model prevents us from doing that. The array may 
be of any size thus we can't divide the page into regions of the same 
size: we can't predict what the maximum size will be. And this is the 
problem of the core.

>
>  
>
>>An example of such  
>>kind of mechanism can be found in spi-alloc.c file in our core. The 
>>lightweightness is achieved by the knowledge that all the blocks to be 
>>allocated are of the same size. 
>>    
>>
>
>I'd have said that since this increases the per-transfer costs (to set
>up and manage the list memberships) you want to increase the weight of
>that part of the API, not decrease it.  ;)
>  
>
Disagree. Let's look deeper. kmalloc itself is more heavyweght than 
setting up list memberships.
The list setting commands are pretty essential and will not add a lot to 
the assembly code.

>Note that your current API maps to mine roughly by equating
>
>	allocate your spi_msg 
>	allocate my { spi_message + one spi_transfer }
>
>So if you're doing one allocation anyway, you already have the relevant
>linked list (in spi_message) and pre-known size.  So this patch wouldn't
>improve any direct translation of your driver stack.
>  
>
This is the patch to your API, so I don't see why you're mentioning it here.
And your understanding is not quite correct. What if I'm going to send a 
chain of 5 messages? I'll allocate 5 spi_msg's in my case which all are 
gonna be of the same size -- thus the technique described above is 
applicable. In case of your core it's not.
And I'm not worrying that much about direct translation, I'm just trying 
to make your core acceptabe for us so that we could give up ours and 
work with yours.
So... it's just one more step towards convergence you are not likely to 
accept.

>>We'd like to use this allocation  
>>technique for both message structure and transfer structure The problem 
>>with the current code is that transfers are represnted as an array so it 
>>can be of any size effectively.
>>    
>>
>
>Could you elaborate on this problem you perceive?  This isn't the only
>driver API in Linux to talk in terms of arrays describing transfers,
>even potentially large arrays.
>  
>
The problem is: we're using real-time enhancements patch developed by 
Ingo/Sven/Daniel etc. You cannot call kmalloc from the interrupt 
context  if you're using this patch. Yeah, yeah -- the interrupt 
handlers are in threads by default, but we can't go for that since we 
want immediate acknowledgement from the interrupt context, and that 
implies spi_message/spi_transfer allocation.

>Consider how "struct scatterlist" is used, and how USB manages the
>descriptors for isochronous transfers.  They don't use linked lists
>there, and haven't seemed to suffer from it.
>  
>
Not sure if I understand why it's relevant to what we're discussing.

Vitaly
