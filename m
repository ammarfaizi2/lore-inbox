Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVCAB0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVCAB0l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 20:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVCAB0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 20:26:38 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:65160 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261187AbVCAB0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 20:26:09 -0500
Message-ID: <4223C4AA.4040405@yahoo.com.au>
Date: Tue, 01 Mar 2005 12:26:02 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: swapper: page allocation failure. order:1, mode:0x20
References: <3CRTy-82M-27@gated-at.bofh.it> <4223C121.6090904@shaw.ca>
In-Reply-To: <4223C121.6090904@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:

> Bernd Schubert wrote:
>
>> Oh no, not this page allocation problems again. In summer I already 
>> posted problems with page allocation errors with 2.6.7, but to me it 
>> seemed that nobody cared. That time we got those problems every 
>> morning during the cron jobs and our main file server always 
>> completely crashed.
>> This time its our cluster master system and first happend after an 
>> uptime of 89 days, kernel is 2.6.9. Besides of those messages, the 
>> system still seems to run stable
>>
>> I really beg for help here, so please please please help me solving 
>> this probem. What can I do to solve it?
>>

You should upgrade to the newest kernel if possible. If that's not possible,
increase /proc/sys/vm/min_free_kbytes

This allocation failure really should not cause your system to crash, but
increasing min_free_kbytes will make it less likely that you will see an
allocation failure.

>> First a (dumb) question, what does 'page allocation failure' really 
>> mean? Is it some out of memory case?
>> Feb 28 10:04:45 hitchcock kernel: swapper: page allocation failure. 
>> order:1, mode:0x20
>> Feb 28 10:04:45 hitchcock kernel:
>> Feb 28 10:04:45 hitchcock kernel: Call Trace:<IRQ> 
>> <ffffffff8015b0de>{__alloc_pages+878} 
>> <ffffffff8015b10e>{__get_free_pages+14}
>> Feb 28 10:04:45 hitchcock kernel:        
>> <ffffffff8015edc6>{kmem_getpages+38} 
>> <ffffffff803d064a>{ip_frag_create+26}
>> Feb 28 10:04:45 hitchcock kernel:        
>> <ffffffff8016061e>{cache_grow+190} 
>> <ffffffff80160e80>{cache_alloc_refill+560}
>> Feb 28 10:04:45 hitchcock kernel:        
>> <ffffffff801617e3>{__kmalloc+195} <ffffffff803b5680>{alloc_skb+64}
>> Feb 28 10:04:45 hitchcock kernel:        
>> <ffffffff8031727e>{tg3_alloc_rx_skb+222} <ffffffff80317553>{tg3_rx+371}
>> Feb 28 10:04:45 hitchcock kernel:        
>> <ffffffff80317977>{tg3_poll+183} <ffffffff803bc306>{net_rx_action+134}
>
>
> Essentially the tg3 Ethernet driver is trying to allocate memory to 
> store a received packet, and is unable to do so. Since this is done 
> inside interrupt context, this allocation has to be serviced from 
> physical memory. Order 1 means it only wanted one page of memory, and 
> since that failed it looks like the system must have been awfully 
> short on available physical RAM.. it could be some kind of kernel 
> memory leak or VM issue, though this condition may not be entirely 
> unexpected in certain cases, like if the system has little physical 
> RAM free at a certain point and then a flood of network packets arrive.
>

Yep. The reason why these failures are beeing seen is that earlier 
kernels did
not reserve enough memory for GFP_ATOMIC allocations. Later kernels 
increased
this, and also made higher order (ie. greater than 0) GFP_ATOMIC allocations
more robust.


