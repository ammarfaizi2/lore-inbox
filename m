Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753924AbWKIHwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924AbWKIHwk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 02:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753923AbWKIHwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 02:52:40 -0500
Received: from sp604005mt.neufgp.fr ([84.96.92.11]:6097 "EHLO smtp.Neuf.fr")
	by vger.kernel.org with ESMTP id S1753913AbWKIHwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 02:52:39 -0500
Date: Thu, 09 Nov 2006 08:52:45 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [take23 0/5] kevent: Generic event handling mechanism.
In-reply-to: <4552D7A6.4060505@cosmosbay.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Davide Libenzi <davidel@xmailserver.org>, Andrew Morton <akpm@osdl.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Message-id: <4552DE4D.7000007@cosmosbay.com>
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
 <4552D7A6.4060505@cosmosbay.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet a écrit :
> Davide Libenzi a écrit :
>> Lost forever means? If there are more processes watching some fd 
>> (external events), they all get their own copy of the events in their 
>> own private epoll fd. It's not that we "steal" things out of the 
>> kernel, is not a 1:1 producer/consumer thing (one producer, 1 queue). 
>> It's one producer, broadcast to all listeners (consumers) thing. The 
>> only case where it'd matter is in the case of multiple threads sharing 
>> the same epoll fd.
> 
> In my particular epoll application, the producer is tcp stack, and I 
> have one consumer. If an network event is lost in the EFAULT handling, 
> its lost forever. In any case, my application do provide a correct user 
> area, so this problem is only theorical.

I realize I was not explicit, and dit not answer your question (Lost forever 
means ?)

                 if (epi->revents) {
                         if (__put_user(epi->revents,
                                        &events[eventcnt].events) ||
                             __put_user(epi->event.data,
                                        &events[eventcnt].data))
                                 return -EFAULT;
 >>                        if (epi->event.events & EPOLLONESHOT)
 >>                                epi->event.events &= EP_PRIVATE_BITS;
                         eventcnt++;
                 }

If one EPOLLONESHOT event is correctly copied to user space, its status is 
updated.

If other ready events in the same epoll_wait() call cannot be transferred 
because of an EFAULT (we reach the real end of user provided area), this 
EPOLLONESHOT event is lost forever, because it wont be requeued in ready list.

Eric

