Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423086AbWJQFGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423086AbWJQFGi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 01:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423088AbWJQFGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 01:06:37 -0400
Received: from densedata.com ([217.160.171.7]:43230 "HELO densedata.com")
	by vger.kernel.org with SMTP id S1423086AbWJQFGg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 01:06:36 -0400
Message-ID: <453465B6.1000401@densedata.com>
Date: Tue, 17 Oct 2006 07:10:14 +0200
From: Johann Borck <johann.borck@densedata.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
CC: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Eric Dumazet <dada1@cosmosbay.com>,
       Ulrich Drepper <drepper@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>
Subject: Re: [take19 1/4] kevent: Core files.
References: <11587449471424@2ka.mipt.ru> <200610051245.03880.dada1@cosmosbay.com> <20061005105536.GA4838@2ka.mipt.ru> <200610051409.31826.dada1@cosmosbay.com> <20061005123715.GA7475@2ka.mipt.ru> <4532C2C5.6080908@redhat.com>
In-Reply-To: <4532C2C5.6080908@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> Evgeniy Polyakov wrote:
>> Existing design does not allow overflow.
>
> And I've pointed out a number of times that this is not practical at
> best.  There are event sources which can create events which cannot be
> coalesced into one single event as it would be required with your design.
>
> Signals are one example, specifically realtime signals.  If we do not
> want the design to be limited from the start this approach has to be
> thought over.
>
>
>>> So zap mmap() support completely, since it is not usable at all. We
>>> wont discuss on it.
>>
>> Initial implementation did not have it.
>> But I was requested to do it, and it is ready now.
>> No one likes it, but no one provides an alternative implementation.
>> We are stuck.
>
> We need the mapped ring buffer.  The current design (before it was
> removed) was broken but this does not mean it shouldn't be
> implemented.  We just need more time to figure out how to implement it
> correctly.
>
Considering the if at all and if then how of ring buffer implemetation
I'd like to throw in some ideas I had when reading the discussion and
respective code. If I understood Ulrich Drepper right, his notion of a
generic event handling interface is, that it has to be flexible enough
to transport additional info from origin to userspace, and to support
queuing of events from the same origin, so that additional
per-event-occurrence data doesn't get lost, which would happen when
coalescing multiple events into one until delivery. From what I read he
says ring buffer is broken because of  insufficient space for additional
data (mukevent) and the limited number of events that can be put into
ring buffer. Another argument is missing notification of userspace about
dropped events in case ring buffer limit is reached. (is that right?)
I see no reason why kevent couldn't be modified to fit (all) these
needs. While modifying the server-example and writing a client using
kevent I came across the coalescing problem, there were more incoming
connections than accept events, and I had to work around that. In this
case the pure number of coalesced events would suffice, while it
wouldn't for the example of RT-signals that Ulrich Drepper gave. So if
coalescing can be done at all or if it is impossible depends on the type
of event. The same goes for additional data delivered with the events.
There might be no panacea for all possible scenarios with one fixed
design. Either performance suffers for 'lightweight' events  which don't
need additional data and/or coalescing is not problematic and/or ring
buffer, or kevent is not usable for other types of events. Why not treat
different things differently, and let the (kernel-)user decide.
I don't know if I got all this right, but if, then ring buffer is needed
especially for cases where coalescing is not possible and additional
data has to be delivered for each triggered notification (so the pure
number of events is not enough; other reasons? performance? ). To me it
doesn't make sense to have kevent fill memory and use processor-time if
buffer is not used at all, which is the case when using kevent_getevents.
So here are my Ideas:
Make usage of ring buffer optional, if not required for specific
event-type it might be chosen by userspace-code.
Make limit of events in ring buffer optional and controllable from
userspace.
Regarding mukevent I'm thinking of a event-type specific struct, that is
filled by the originating code, and placed into a per-event-type ring
buffer (which  requires modification of kevent_wait). To my limited
understanding it seems that alternative or modified versions of
kevent_storage_ready, (__)kevent_requeue and kevent_user_ring_add_event
could return a void pointer to the position in buffer, and all kevent
has to know about is the size of the struct.
If coalescing doesn't hurt for a specific event-type it might just be
modified to notify userspace about the number of coalesced events. Make
it depend on type of event.

I know this doesn't address all objections that have been made, and
Evgeniy, big sorry for this being just talk again, and maybe not even
applicable for some reasons I do not overlook, but maybe it's worth
consideration. I'll gladly try to put that into code, and see where it
leads. I think kevent is great, and if things can be done to increase
it's genericity without sacrifying performance, why not.
Sorry for the length of post and repetitions,

Johann
