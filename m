Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbVJHV7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbVJHV7P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 17:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbVJHV7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 17:59:15 -0400
Received: from bay108-dav14.bay108.hotmail.com ([65.54.162.86]:37031 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S932180AbVJHV7O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 17:59:14 -0400
Message-ID: <BAY108-DAV140650CDA8608152927C4E93870@phx.gbl>
X-Originating-IP: [143.182.124.4]
X-Originating-Email: [multisyncfe991@hotmail.com]
From: "LeoY" <multisyncfe991@hotmail.com>
To: "Eric Dumazet" <dada1@cosmosbay.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <BAY108-DAV4CDAEF052852412160A0893870@phx.gbl> <43483E57.1040205@cosmosbay.com>
Subject: Re: Is this skb recycle buffer helpful to improve Linux network stack performance?
Date: Sat, 8 Oct 2005 14:59:13 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-OriginalArrivalTime: 08 Oct 2005 21:59:13.0912 (UTC) FILETIME=[8534F780:01C5CC53]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the modifications I made:
//skbuff.h
//I added the folloing definitions
#define MAX_POOL_SIZE 4096
unsigned char *skbuff_data_pool[MAX_POOL_SIZE];
int skbPoolHead, skbPoolTail;


//skb_init()
//I add the following codes:
 for(i=0;i<MAX_POOL_SIZE;i++)
         skbuff_data_pool[i] = NULL;
 skbPoolHead = skbPoolTail = 0;


//alloc_skb()
//I made the following changes
if (skbuff_data_pool[skbPoolHead])
 {
   data = skbuff_data_pool[skbPoolHead];
  skbuff_data_pool[skbPoolHead] = NULL;
  if (++skbPoolHead == MAX_POOL_SIZE)
   skbPoolHead = 0;
 }
 else{ //Original path
  size = SKB_DATA_ALIGN(size);
  data = kmalloc(size + sizeof(struct skb_shared_info), gfp_mask);
  }

//skb_release_data()
//I made the following changes:
  if ((skbPoolHead == skbPoolTail) && (skbuff_data_pool[skbPoolHead] != 
NULL))
  //Original path
   kfree(skb->head);
                else{
   if (skbuff_data_pool[skbPoolTail])
    panic("Tail pointer must be null");

   skbuff_data_pool[skbPoolTail] = skb->head;
                        if (++skbPoolTail == MAX_POOL_SIZE)
    skbPoolTail = 0;
  }

----- Original Message ----- 
From: "Eric Dumazet" <dada1@cosmosbay.com>
To: "LeoY" <multisyncfe991@hotmail.com>
Cc: <netdev@vger.kernel.org>
Sent: Saturday, October 08, 2005 2:47 PM
Subject: Re: Is this skb recycle buffer helpful to improve Linux network 
stack performance?


> LeoY a écrit :
>> Hi,
>>
>> Motivation: we noticed alloc_skb()/kfree() used lots of clock ticks when
>> handling heavy network traffic. As Linux kernel always need to call
>> kmalloc()/kfree() to allocate and deallocate a skb DATA buffer(not 
>> sk_buff)
>> for each incoming/outgoing packet, we try to reduce the frequence of 
>> calling
>> these memory functions.
>>
>> I wangt to set up a ring buffer in Linux kernel(skbuff.c) and recycle 
>> those
>> skb data buffers. The basic idea is as follows:
>> 1. Create a ring buffer. This ring buffer has a head pointer which points 
>> to
>> the virtual address of the data buffer to be reused; It also has a tail
>> pointer, which can be used to store the virutal address of skb data 
>> buffer
>> for those transmitted packets.
>> 2. If the ring buffer is full, just use normal kmalloc()/kfree() 
>> operation
>> to manager those skb data buffers instead of recycling them.
>> 3. if any DATA buffer is available, Instead of calling kmalloc(), assign 
>> a
>> skb data buffer directly from ring buffer to the incoming packets.
>> 4. If ring buffer still has space, Instead of calling kfree(), store the 
>> skb
>> data buffer into the ring buffer.
>> 5. if the head and tail pointer overlap and head pointer is not empty, 
>> just
>> stop accpeting more DATA buffer until some DATA buffer is used for the
>> incoming packets.
>>
>> I tested my method on the latest Linux kernel 2.6.13.3, it works with the
>> normal traffic; However, the Linux kernel crashed under the heavy network
>> traffic.
>>
>> Any idea to make this ring bufer work under the heavy network traffic?
>
> Your idea seems interesting, but you forgot to post a link to the code you 
> wrote. How do you want us to help you ?
>
> Eric
> 
