Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161200AbWJPHee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161200AbWJPHee (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 03:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161197AbWJPHee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 03:34:34 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:36581 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1161081AbWJPHed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 03:34:33 -0400
Date: Mon, 16 Oct 2006 11:33:49 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Eric Dumazet <dada1@cosmosbay.com>, Ulrich Drepper <drepper@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
Subject: Re: [take19 1/4] kevent: Core files.
Message-ID: <20061016073348.GB17735@2ka.mipt.ru>
References: <11587449471424@2ka.mipt.ru> <200610051245.03880.dada1@cosmosbay.com> <20061005105536.GA4838@2ka.mipt.ru> <200610051409.31826.dada1@cosmosbay.com> <20061005123715.GA7475@2ka.mipt.ru> <4532C2C5.6080908@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4532C2C5.6080908@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 16 Oct 2006 11:33:50 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2006 at 04:22:45PM -0700, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> >Existing design does not allow overflow.
> 
> And I've pointed out a number of times that this is not practical at 
> best.  There are event sources which can create events which cannot be 
> coalesced into one single event as it would be required with your design.
> 
> Signals are one example, specifically realtime signals.  If we do not 
> want the design to be limited from the start this approach has to be 
> thought over.

The whole idea of mmap buffer seems to be broken, since those who asked
for creation do not like existing design and do not show theirs...

According to signals and possibility to overflow in existing ring buffer
implementation.
You seems to not checked the code - each event can be marked as ready 
only one time, which means only one copy and so on.
It was done _specially_. And it is not limitation, but "new" approach.
Queue of the same signals or any other events has fundamental flawness
(as any other ring buffer implementation, which has queue size)  -
it's size of the queue and extremely bad case of the overflow.
So, the same event may not be ready several times. Any design which
allows to create infinite number of events generated for the same case
is broken, since consumer can be in situation, when it can not handle
that flow. That is why poll() returns only POLLIN when data is ready in
network stack, but is not trying to generate some kind of a signal for 
each byte/packet/MTU/MSS received.
RT signals have design problems, and I will not repeate the same error
with similar limits in kevent.

> >>So zap mmap() support completely, since it is not usable at all. We wont 
> >>discuss on it.
> >
> >Initial implementation did not have it.
> >But I was requested to do it, and it is ready now.
> >No one likes it, but no one provides an alternative implementation.
> >We are stuck.
> 
> We need the mapped ring buffer.  The current design (before it was 
> removed) was broken but this does not mean it shouldn't be implemented. 
>  We just need more time to figure out how to implement it correctly.

In the latest patchset it was removed. I'm waiting for your code.

Mmap implementation can be added separately, since it does not affect
kevent core.

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, 
> CA ❖

-- 
	Evgeniy Polyakov
