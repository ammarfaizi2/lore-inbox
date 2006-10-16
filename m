Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161280AbWJPLYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161280AbWJPLYJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 07:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbWJPLYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 07:24:08 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:4779 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751520AbWJPLYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 07:24:06 -0400
Date: Mon, 16 Oct 2006 15:23:03 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Eric Dumazet <dada1@cosmosbay.com>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
Subject: Re: [take19 1/4] kevent: Core files.
Message-ID: <20061016112303.GF17735@2ka.mipt.ru>
References: <11587449471424@2ka.mipt.ru> <200610051245.03880.dada1@cosmosbay.com> <20061005105536.GA4838@2ka.mipt.ru> <200610051409.31826.dada1@cosmosbay.com> <20061005123715.GA7475@2ka.mipt.ru> <4532C2C5.6080908@redhat.com> <20061016073348.GB17735@2ka.mipt.ru> <45335BEF.7010405@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45335BEF.7010405@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 16 Oct 2006 15:23:07 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 03:16:15AM -0700, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> >The whole idea of mmap buffer seems to be broken, since those who asked
> >for creation do not like existing design and do not show theirs...
> 
> What kind of argumentation is that?
> 
>    "Because my attempt to implement it doesn't work and nobody right
>     away has a better suggestion this means the idea is broken."
> 
> Nonsense.

Ok, let's reformulate:
My attempt works, but nobody around likes it, I remove it and wait until
some other implement it.

> It just means that time should be spend on thinking about this.  You cut 
> all this short by rushing out your attempt without any discussions. 
> Unfortunately nobody else really looked at the approach so it lingered 
> around for some weeks.  Well, now it is clear that it is not the right 
> approach and we can start thinking about it again.

I talked about it in the last 13 releases of the kevent, and _noone_
said at least some comments. And now I get - 'it is broken, it does not
work, there are problems, we do not want it' and the like. I tried
hardly to show that it does work and problems shown can not happen, but
noone still hears me. Since I think it is not that interface which is
100% required for correct functionality, I removed it. When there are
better suggestions and implementation we can return to them of course.

> >You seems to not checked the code - each event can be marked as ready 
> >only one time, which means only one copy and so on.
> >It was done _specially_. And it is not limitation, but "new" approach.
> 
> I know that it is done deliberately and I tell you that this is wrong 
> and unacceptable.  Realtime signals are one event which need to have 
> more than one event queued.  This is no description of what you have 
> implemented, it's a description of the reality of realtime signals.
> 
> RT signals are queued.  They carry a data value (the sigval_t object) 
> which can be unique for each signal delivery.  Coalescing the signal 
> events therefore leads to information loss.
> 
> Therefore, at the very least for signal we need to have the ability to 
> queue more than one event for each event source.  Not having this 
> functionality means that signals and likely other types of events cannot 
> be implemented using kevent queues.

Well, my point about rt-signals is that they do not deserve to be
resurrected, but it is only my point :)
In case it is still used, each signal setup should create event - many
signals means many events, each signal can be sent with different
parameters - each event should correspond to one unique case.

> >Queue of the same signals or any other events has fundamental flawness
> >(as any other ring buffer implementation, which has queue size)  -
> >it's size of the queue and extremely bad case of the overflow.
> 
> Of course there are additional problems.  Overflows need to be handled. 
>  But this is nothing which is unsolvable.

I strongly disagree that having design which allows overflows is
acceptible - do we really want rt-signals queue overflow problems in new
place? Instead some complex allocation scheme can be created.

> >So, the same event may not be ready several times. Any design which
> >allows to create infinite number of events generated for the same case
> >is broken, since consumer can be in situation, when it can not handle
> >that flow.
> 
> That's complete nonsense.  Again, for RT signals it is very reasonable 
> and not "broken" to have multiple outstanding signals.

The same signal with different payload is acceptible, but when number of
them increases ulimit and they are started to be forgotten - that's what
I call broken design.

> >That is why poll() returns only POLLIN when data is ready in
> >network stack, but is not trying to generate some kind of a signal for 
> >each byte/packet/MTU/MSS received.
> 
> It makes no sense to drag poll() into this discussion.  poll() is a very 
> limited interface.  The new event handling is supposed to be the 
> opposite, namely, usable for all kinds of events.  Arguing that because 
> poll() does it like this just means you don't see what big step is 
> needed to get to the goal of a unified event handling.  The shackles of 
> poll() must be left behind.

Kevent is that subsystem, and for now it works quite good.

> >RT signals have design problems, and I will not repeate the same error
> >with similar limits in kevent.
> 
> I don't know what to say.  You claim to be the source of all wisdom is 
> OS design.  Maybe you should design your own OS, from ground up.  I 
> wonder how many people would like that since all your arguments are 
> squarely geared towards optimizing the implementation.  But: the 
> implementation is irrelevant without users.  The functionality users (= 
> programmers) want and need is what must drive the implementation.  And 
> RT signals are definitely heavily used and liked by programmers.  You 
> have to accept that you try to modify an OS which has that functionality 
> regardless of how much you hate it and want to fight it.

No problem, but I hope you agree that they have major problem related to
queue length? And I want to design interface which will not have that
problem, so I do not introduce situation which allows to create infinite
number of events when receiving side can not handle them.

> >Mmap implementation can be added separately, since it does not affect
> >kevent core.
> 
> That I doubt very much and it is why I would not want the kevent stuff 
> go into any released kernel until that "detail" is resolved.

I see you point :)

But talk is cheap, and no code has been released by people who argue
against kevent, only existing ring buffer implementation.
I have only two arms and one brain, which unfortunately is not capable
to remotely read mental waves about possible design of ring buffer, so
I'm waiting.

I expect no one will release new code (soon), so it is possible that 
kevent will wait forever...
If you do argue for that, I can only say that we are on the different
sides - one on the ship, and other on the coast.

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, 
> CA ❖

-- 
	Evgeniy Polyakov
