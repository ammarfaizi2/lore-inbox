Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbVLKWOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbVLKWOq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 17:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbVLKWOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 17:14:46 -0500
Received: from smtp1.pochta.ru ([81.211.64.6]:33606 "EHLO smtp1.pochta.ru")
	by vger.kernel.org with ESMTP id S1750883AbVLKWOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 17:14:45 -0500
X-Author: vitalhome@rbcmail.ru from [10.1.27.2] ([82.179.192.198]) via Free Mail POCHTA.RU
Message-ID: <439CA488.3050302@ru.mvista.com>
Date: Mon, 12 Dec 2005 01:13:28 +0300
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
References: <20051201191109.40f2d04b.vwool@ru.mvista.com> <439C1D5E.1020407@ru.mvista.com> <439C5BE7.3030503@ru.mvista.com> <200512111217.33009.david-b@pacbell.net>
In-Reply-To: <200512111217.33009.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>>But  
>>this solves the problem only partially since this technique fits only 
>>the synchronous transfers.
>>    
>>
>
>Synchronous transfers can easily use stack allocation for
>the descriptions, yes.
>
>Not that they need to ... the ads7846 driver allocates its
>spi_message and spi_transfer objects on the heap both for
>synchronous operations (temperature and voltage sensing) and
>for asynch ones (touchscreen tracking from timer and irq).
>  
>
So are you talking about only kzalloc vs kmalloc?
I was trying to compare the approaches in a somehow deeper way.
That said, I meant that not exposing any structures you don't have to 
expose was usually a right way to do things.
We don't expose SPI message and you do.
The only advantage of such exposure I could think of was possibilily to 
allocate messages on stack but this approach has some limitations we've 
just agrred upon.
On the other hand, our approach is flexible in means of message 
allocation. I. e. a small memory allocation library can be implemented 
transparently to device drivers that handles message allocation. It's 
very easy (and lightweight :)) since the message structure is always of 
a same length... Agree?

>That said ... I know some people _do_ like krefcounted APIs that
>do that kind of stuff.  Strongly.  Greg's been silent here other
>than pointing out that your request alloc was too fat to inline.
>Mine is trivially inlined, but not refcounted.  Likely there's a
>happy middle ground, maybe
>
>  mesg = spi_message_alloc(struct spi_device *, unsigned ntrans);
>  mesg = spi_message_get(mesg);
>  spi_message_put();
>  
>
Well, it's pretty much what we do in the latest one...
Though we use one-by-one chaining and not specifying the number of 
messages in chain.
I'm not sure which approach is better, really. Maybe an API like
struct spi_mjsg *spi_message_alloc(struct spi_device *, unsigned ntrans);
spi_add_transfer(struct spi_msg *, ...);
...
is better than what we've got now (see patch sent 12/05; I plan to post 
the update tomorrow).
I would just like to say that defining such an API looks better thing to 
me than dealing with SPI message structure explicitly.

Vitaly
