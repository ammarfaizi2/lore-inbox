Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbVJHWKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbVJHWKB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 18:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbVJHWKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 18:10:01 -0400
Received: from mf00.sitadelle.com ([212.94.174.67]:57954 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1751162AbVJHWKA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 18:10:00 -0400
Message-ID: <434843B5.3020306@cosmosbay.com>
Date: Sun, 09 Oct 2005 00:09:57 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: LeoY <multisyncfe991@hotmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Is this skb recycle buffer helpful to improve Linux network stack
 performance?
References: <BAY108-DAV4CDAEF052852412160A0893870@phx.gbl> <43483E57.1040205@cosmosbay.com> <BAY108-DAV140650CDA8608152927C4E93870@phx.gbl>
In-Reply-To: <BAY108-DAV140650CDA8608152927C4E93870@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LeoY a écrit :
> Here is the modifications I made:
> //skbuff.h
> //I added the folloing definitions
> #define MAX_POOL_SIZE 4096
> unsigned char *skbuff_data_pool[MAX_POOL_SIZE];
> int skbPoolHead, skbPoolTail;
> 
> 
> //skb_init()
> //I add the following codes:
> for(i=0;i<MAX_POOL_SIZE;i++)
>         skbuff_data_pool[i] = NULL;
> skbPoolHead = skbPoolTail = 0;
> 
> 
> //alloc_skb()
> //I made the following changes
> if (skbuff_data_pool[skbPoolHead])
> {
>   data = skbuff_data_pool[skbPoolHead];
>  skbuff_data_pool[skbPoolHead] = NULL;
>  if (++skbPoolHead == MAX_POOL_SIZE)
>   skbPoolHead = 0;
> }
> else{ //Original path
>  size = SKB_DATA_ALIGN(size);
>  data = kmalloc(size + sizeof(struct skb_shared_info), gfp_mask);
>  }
> 
> //skb_release_data()
> //I made the following changes:
>  if ((skbPoolHead == skbPoolTail) && (skbuff_data_pool[skbPoolHead] != 
> NULL))
>  //Original path
>   kfree(skb->head);
>                else{
>   if (skbuff_data_pool[skbPoolTail])
>    panic("Tail pointer must be null");
> 
>   skbuff_data_pool[skbPoolTail] = skb->head;
>                        if (++skbPoolTail == MAX_POOL_SIZE)
>    skbPoolTail = 0;
>  }
> 

Hum... Lot of problems I think

Are you aware that skb_alloc() / skb_free() can handle data buffers of 
different sizes ?

So if you kmalloc() a small buffer, and store it later in your ring buffer, 
you should not give it back to a caller that need a biger buffer.

If you want your 'ring buffer'to work, I suspect you should ignore the 'size' 
and let it be the max possible size handled in your machine.

Then, dont forget about SMP and IRQs : I dont see in your code how you protect 
against concurrent processors accessing your ring buffers, and how you protect 
against IRQ (since a nic handler can runs on IRQ or softirq context)

kmalloc()/kfree() are SMP safe.

> ----- Original Message ----- From: "Eric Dumazet" <dada1@cosmosbay.com>
> To: "LeoY" <multisyncfe991@hotmail.com>
> Cc: <netdev@vger.kernel.org>
> Sent: Saturday, October 08, 2005 2:47 PM
> Subject: Re: Is this skb recycle buffer helpful to improve Linux network 
> stack performance?
> 
> 
>> LeoY a écrit :
>>
>>> Hi,
>>>
>>> Motivation: we noticed alloc_skb()/kfree() used lots of clock ticks when
>>> handling heavy network traffic. As Linux kernel always need to call
>>> kmalloc()/kfree() to allocate and deallocate a skb DATA buffer(not 
>>> sk_buff)
>>> for each incoming/outgoing packet, we try to reduce the frequence of 
>>> calling
>>> these memory functions.
>>>
>>> I wangt to set up a ring buffer in Linux kernel(skbuff.c) and recycle 
>>> those
>>> skb data buffers. The basic idea is as follows:
>>> 1. Create a ring buffer. This ring buffer has a head pointer which 
>>> points to
>>> the virtual address of the data buffer to be reused; It also has a tail
>>> pointer, which can be used to store the virutal address of skb data 
>>> buffer
>>> for those transmitted packets.
>>> 2. If the ring buffer is full, just use normal kmalloc()/kfree() 
>>> operation
>>> to manager those skb data buffers instead of recycling them.
>>> 3. if any DATA buffer is available, Instead of calling kmalloc(), 
>>> assign a
>>> skb data buffer directly from ring buffer to the incoming packets.
>>> 4. If ring buffer still has space, Instead of calling kfree(), store 
>>> the skb
>>> data buffer into the ring buffer.
>>> 5. if the head and tail pointer overlap and head pointer is not 
>>> empty, just
>>> stop accpeting more DATA buffer until some DATA buffer is used for the
>>> incoming packets.
>>>
>>> I tested my method on the latest Linux kernel 2.6.13.3, it works with 
>>> the
>>> normal traffic; However, the Linux kernel crashed under the heavy 
>>> network
>>> traffic.
>>>
>>> Any idea to make this ring bufer work under the heavy network traffic?
>>
>>
>> Your idea seems interesting, but you forgot to post a link to the code 
>> you wrote. How do you want us to help you ?
>>
>> Eric
>>

> 

