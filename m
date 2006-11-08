Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423926AbWKHXHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423926AbWKHXHc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 18:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423927AbWKHXHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 18:07:32 -0500
Received: from sp604005mt.neufgp.fr ([84.96.92.11]:65246 "EHLO smtp.Neuf.fr")
	by vger.kernel.org with ESMTP id S1423926AbWKHXHa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 18:07:30 -0500
Date: Thu, 09 Nov 2006 00:07:37 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [take23 0/5] kevent: Generic event handling mechanism.
In-reply-to: <Pine.LNX.4.64.0611081442420.23154@alien.or.mcafeemobile.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Message-id: <45526339.3040506@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <1154985aa0591036@2ka.mipt.ru>
 <20061107141718.f7414b31.akpm@osdl.org> <20061108082147.GA2447@2ka.mipt.ru>
 <200611081551.14671.dada1@cosmosbay.com>
 <20061108140307.da7d815f.akpm@osdl.org>
 <Pine.LNX.4.64.0611081442420.23154@alien.or.mcafeemobile.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi a écrit :
> On Wed, 8 Nov 2006, Andrew Morton wrote:
> 
>> On Wed, 8 Nov 2006 15:51:13 +0100
>> Eric Dumazet <dada1@cosmosbay.com> wrote:
>>
>>> [PATCH] eventpoll : In case a fault occurs during copy_to_user(), we should 
>>> report the count of events that were successfully copied into user space, 
>>> instead of EFAULT. That would be consistent with behavior of read/write() 
>>> syscalls for example.
>>>
>>> Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>
>>>
>>>
>>>
>>> [eventpoll.patch  text/plain (424B)]
>>> --- linux/fs/eventpoll.c	2006-11-08 15:37:36.000000000 +0100
>>> +++ linux/fs/eventpoll.c	2006-11-08 15:38:31.000000000 +0100
>>> @@ -1447,7 +1447,7 @@
>>>  				       &events[eventcnt].events) ||
>>>  			    __put_user(epi->event.data,
>>>  				       &events[eventcnt].data))
>>> -				return -EFAULT;
>>> +				return eventcnt ? eventcnt : -EFAULT;
>>>  			if (epi->event.events & EPOLLONESHOT)
>>>  				epi->event.events &= EP_PRIVATE_BITS;
>>>  			eventcnt++;
>>>
>> Definitely a better interface, but I wonder if it's too late to change it.
>>
>> An app which does
>>
>> 	if (epoll_wait(...) == -1)
>> 		barf(errno);
>> 	else
>> 		assume_all_events_were_received();
>>
>> will now do the wrong thing.
>>
>> otoh, such an applciation basically _has_ to use the epoll_wait()
>> return value to work out how many events it received, so maybe it's OK...
> 
> I don't care about both ways, but sys_poll() does the same thing epoll 
> does right now, so I would not change epoll behaviour.
> 

Sure poll() cannot return a partial count, since its return value is :

On success, a positive number is returned, where the number returned is
        the  number  of structures which have non-zero revents fields (in other
        words, those descriptors with events or errors reported).

poll() is non destructive (it doesnt change any state into kernel). Returning 
EFAULT in case of an error in the very last bit of user area is mandatory.

On the contrary :

epoll_wait() does return a count of transfered events, and update some state 
in kernel (it consume Edge Trigered events : They can be lost forever if not 
reported to user)

So epoll_wait() is much more like read(), that also updates file state in 
kernel (current file position)

