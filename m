Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbVLKRFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVLKRFe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 12:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbVLKRFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 12:05:34 -0500
Received: from smtp1.pochta.ru ([81.211.64.6]:10569 "EHLO smtp1.pochta.ru")
	by vger.kernel.org with ESMTP id S1750728AbVLKRFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 12:05:33 -0500
X-Author: vitalhome@rbcmail.ru from [10.1.27.2] ([82.179.192.198]) via Free Mail POCHTA.RU
Message-ID: <439C5BE7.3030503@ru.mvista.com>
Date: Sun, 11 Dec 2005 20:03:35 +0300
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
References: <20051201191109.40f2d04b.vwool@ru.mvista.com> <200512071759.56782.david-b@pacbell.net> <4397D3AA.6050804@ru.mvista.com> <200512091455.01790.david-b@pacbell.net> <439C1D5E.1020407@ru.mvista.com>
In-Reply-To: <439C1D5E.1020407@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Wool wrote:

> David Brownell wrote:
>
>>> Yeah thus we don't have an ability to allocate SPI messages on stack 
>>> as you do, that's what votes for your approach. Yours is thus a bit 
>>> faster, though I suspect that this method is a possible *danger* for 
>>> really high-speed devices with data bursts on the SPI bus like WiFi 
>>> adapters: stack's gonna suffer from large amounts of data allocated.
>>>   
>>
>>
>> No, you're still thinking about a purely synchronous programming model;
>> which we had agreed ages ago was not required.
>>  
>>
> Ah yes. But wait... I've got an important question here.
> For instance, let's take your MTD driver. You're allocating a message 
> structure on stack and passing it then down to spi->master->transfer 
> function.
> The benefit you're talking about is that you don't have to use 
> heavyweight memory allocation. But... the transfer is basically async 
> so spi->master->transfer will need to copy your message structure to 
> its own-allocated structure so some memory copying will occur as this 
> might be an async transfer (and therefore the stack-allocated message 
> may be freed at some point when it's yet used!)
> So your model implies concealed double message allocation/copying, 
> doesn't it?
> And if I'm wrong, can you please explain me this?

Oh, now looks like I understood what is meant. If a function uses 
stack-allocated messages, it should ensure that it will not exit until 
the message is processed (shouldn't it be documented somewhere?). But 
this solves the problem only partially since this technique fits only 
the synchronous transfers.
Functions targeting async transfers will anyway have to kmalloc the 
memory for message structure which makes your approach not really more 
lightweight then ours. It's mainly async transfers that need high 
throughput; and the drivers based on your core will have to kmalloc 
memory for messages in that case.

Vitaly
