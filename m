Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753370AbWKIHYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbWKIHYV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 02:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753491AbWKIHYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 02:24:21 -0500
Received: from sp604003mt.neufgp.fr ([84.96.92.56]:52479 "EHLO smTp.neuf.fr")
	by vger.kernel.org with ESMTP id S1753370AbWKIHYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 02:24:20 -0500
Date: Thu, 09 Nov 2006 08:24:22 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [take23 0/5] kevent: Generic event handling mechanism.
In-reply-to: <Pine.LNX.4.64.0611081526350.23154@alien.or.mcafeemobile.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Message-id: <4552D7A6.4060505@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <1154985aa0591036@2ka.mipt.ru>
 <20061107141718.f7414b31.akpm@osdl.org> <20061108082147.GA2447@2ka.mipt.ru>
 <200611081551.14671.dada1@cosmosbay.com>
 <20061108140307.da7d815f.akpm@osdl.org>
 <Pine.LNX.4.64.0611081442420.23154@alien.or.mcafeemobile.com>
 <45526339.3040506@cosmosbay.com>
 <Pine.LNX.4.64.0611081526350.23154@alien.or.mcafeemobile.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi a écrit :
> On Thu, 9 Nov 2006, Eric Dumazet wrote:
> 
>> Davide Libenzi a ?crit :
>>> I don't care about both ways, but sys_poll() does the same thing epoll does
>>> right now, so I would not change epoll behaviour.
>>>
>> Sure poll() cannot return a partial count, since its return value is :
>>
>> On success, a positive number is returned, where the number returned is
>>        the  number  of structures which have non-zero revents fields (in other
>>        words, those descriptors with events or errors reported).
>>
>> poll() is non destructive (it doesnt change any state into kernel). Returning
>> EFAULT in case of an error in the very last bit of user area is mandatory.
>>
>> On the contrary :
>>
>> epoll_wait() does return a count of transfered events, and update some state
>> in kernel (it consume Edge Trigered events : They can be lost forever if not
>> reported to user)
>>
>> So epoll_wait() is much more like read(), that also updates file state in
>> kernel (current file position)
> 
> Lost forever means? If there are more processes watching some fd 
> (external events), they all get their own copy of the events in their own 
> private epoll fd. It's not that we "steal" things out of the kernel, is 
> not a 1:1 producer/consumer thing (one producer, 1 queue). It's one 
> producer, broadcast to all listeners (consumers) thing. The only case 
> where it'd matter is in the case of multiple threads sharing the same 
> epoll fd.

In my particular epoll application, the producer is tcp stack, and I have one 
consumer. If an network event is lost in the EFAULT handling, its lost 
forever. In any case, my application do provide a correct user area, so this 
problem is only theorical.

> In general, I'd be more for having the userspace get his own SEGFAULT 
> instead of letting it go with broken parameters. If I'm coding userspace, 
> and I'm doing something wrong, I like the kernel to let me know, instead 
> of trying to fix things for me.
> Also, epoll can easily be fixed (add a param to ep_reinject_items() to 
> re-inject items in case of error/EFAULT) to leave events in the ready-list 
> and let the EFAULT emerge. 

Please dont slow the hot path for a basically "User Error". It's already 
tested in the transfert function, with two conditional branches for each 
transfered event.

> Anyone else has opinions about this?
> 
> 
> 
> 
> PS: Next time it'd be great if you Cc: me when posting epoll patches, so 
>     you avoid Andrew the job of doing it.

Yes, but this particular patch was a followup on own kevent Andrew patch.

I have a bunch of patches for epoll I will send to you :)

Eric
