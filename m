Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030347AbWJPKRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030347AbWJPKRP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 06:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030357AbWJPKRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 06:17:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38613 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030348AbWJPKRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 06:17:12 -0400
Message-ID: <45335BEF.7010405@redhat.com>
Date: Mon, 16 Oct 2006 03:16:15 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: Eric Dumazet <dada1@cosmosbay.com>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
Subject: Re: [take19 1/4] kevent: Core files.
References: <11587449471424@2ka.mipt.ru> <200610051245.03880.dada1@cosmosbay.com> <20061005105536.GA4838@2ka.mipt.ru> <200610051409.31826.dada1@cosmosbay.com> <20061005123715.GA7475@2ka.mipt.ru> <4532C2C5.6080908@redhat.com> <20061016073348.GB17735@2ka.mipt.ru>
In-Reply-To: <20061016073348.GB17735@2ka.mipt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> The whole idea of mmap buffer seems to be broken, since those who asked
> for creation do not like existing design and do not show theirs...

What kind of argumentation is that?

    "Because my attempt to implement it doesn't work and nobody right
     away has a better suggestion this means the idea is broken."

Nonsense.

It just means that time should be spend on thinking about this.  You cut 
all this short by rushing out your attempt without any discussions. 
Unfortunately nobody else really looked at the approach so it lingered 
around for some weeks.  Well, now it is clear that it is not the right 
approach and we can start thinking about it again.


> You seems to not checked the code - each event can be marked as ready 
> only one time, which means only one copy and so on.
> It was done _specially_. And it is not limitation, but "new" approach.

I know that it is done deliberately and I tell you that this is wrong 
and unacceptable.  Realtime signals are one event which need to have 
more than one event queued.  This is no description of what you have 
implemented, it's a description of the reality of realtime signals.

RT signals are queued.  They carry a data value (the sigval_t object) 
which can be unique for each signal delivery.  Coalescing the signal 
events therefore leads to information loss.

Therefore, at the very least for signal we need to have the ability to 
queue more than one event for each event source.  Not having this 
functionality means that signals and likely other types of events cannot 
be implemented using kevent queues.


> Queue of the same signals or any other events has fundamental flawness
> (as any other ring buffer implementation, which has queue size)  -
> it's size of the queue and extremely bad case of the overflow.

Of course there are additional problems.  Overflows need to be handled. 
  But this is nothing which is unsolvable.


> So, the same event may not be ready several times. Any design which
> allows to create infinite number of events generated for the same case
> is broken, since consumer can be in situation, when it can not handle
> that flow.

That's complete nonsense.  Again, for RT signals it is very reasonable 
and not "broken" to have multiple outstanding signals.


> That is why poll() returns only POLLIN when data is ready in
> network stack, but is not trying to generate some kind of a signal for 
> each byte/packet/MTU/MSS received.

It makes no sense to drag poll() into this discussion.  poll() is a very 
limited interface.  The new event handling is supposed to be the 
opposite, namely, usable for all kinds of events.  Arguing that because 
poll() does it like this just means you don't see what big step is 
needed to get to the goal of a unified event handling.  The shackles of 
poll() must be left behind.


> RT signals have design problems, and I will not repeate the same error
> with similar limits in kevent.

I don't know what to say.  You claim to be the source of all wisdom is 
OS design.  Maybe you should design your own OS, from ground up.  I 
wonder how many people would like that since all your arguments are 
squarely geared towards optimizing the implementation.  But: the 
implementation is irrelevant without users.  The functionality users (= 
programmers) want and need is what must drive the implementation.  And 
RT signals are definitely heavily used and liked by programmers.  You 
have to accept that you try to modify an OS which has that functionality 
regardless of how much you hate it and want to fight it.


> Mmap implementation can be added separately, since it does not affect
> kevent core.

That I doubt very much and it is why I would not want the kevent stuff 
go into any released kernel until that "detail" is resolved.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
