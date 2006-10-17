Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWJQQDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWJQQDK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 12:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWJQQDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 12:03:10 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:4744 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751267AbWJQQDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 12:03:08 -0400
Date: Tue, 17 Oct 2006 20:01:55 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Johann Borck <johann.borck@densedata.com>,
       Ulrich Drepper <drepper@redhat.com>, Ulrich Drepper <drepper@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>
Subject: Re: [take19 1/4] kevent: Core files.
Message-ID: <20061017160155.GA18522@2ka.mipt.ru>
References: <11587449471424@2ka.mipt.ru> <200610171625.00515.dada1@cosmosbay.com> <20061017150929.GA2288@2ka.mipt.ru> <200610171732.28640.dada1@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200610171732.28640.dada1@cosmosbay.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 17 Oct 2006 20:01:57 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 05:32:28PM +0200, Eric Dumazet (dada1@cosmosbay.com) wrote:
> > So the most complex case is when user is going to use both interfaces,
> > and it's steps when mapped ring buffer has overflow.
> > In that case user can either read and mark some events as ready in ring
> > buffer (the latter is being done through special syscall), so kevent
> > core will put there new ready events.
> > User can also get events using usual syscall, in that case events in
> > ring buffer must be updated - and actually I implemented mapped buffer
> > in the way which allows to remove events from the queue - queue is a
> > FIFO, and the first entry to be obtained through syscall is _always_ the
> > first entry in the ring buffer.
> >
> > So when user reads event through syscall (no matter if we are in overflow
> > case or not), even being read is easily accessible in the ring buffer.
> >
> > So I propose following design for ring buffer (quite simple):
> > kernelspace maintains two indexes - to the first and the last events in
> > the ring buffer (and maximum size of the buffer of course).
> > When new event is marked as ready, some info is being copied into ring
> > buffer and index of the last entry is increased.
> > When event is being read through syscall it is _guaranteed_ that that
> > event will be at the position pointed by the index of the first
> > element, that index is then increased (thus opening new slot in the
> > buffer).
> > If index of the last entry reaches (with possible wrapping) index of the
> > first entry, that means that overflow has happend. In this case no new
> > events can be copied into ring buffer, so they are only placed into
> > ready queue (accessible through syscall kevent_get_events()).
> >
> > When user calls kevent_get_events() it will obtain the first element
> > (pointed by index of the first element in the ring buffer), and if there
> > is ready event, which is not placed into the ring buffer, it is
> > copied (with appropriate update of the last index and new overflow
> > condition).
> 
> Well, I'm not sure its good to do this 'move one event from ready list to slot 
> X', one by one, because this event will likely be flushed out of processor 
> cache (because we will have to consume 4096 events before reaching this one). 
> I think its better to batch this kind of 'push XX events' later, XX being 
> small enough not to waste CPU cache, and when ring buffer is empty again.

Ok, that's possible.

> mmap buffer is good for latency and minimum synchro between user thread and 
> kernel producer. But once we hit an 'overflow', it is better to revert to a 
> mode feeding XX events per syscall, to be sure it fits CPU caches : The user 
> thread will do the copy between kernel memory to user memory, and this thread 
> will shortly use those events in user land.

User can do both - either get events through syscall, or get them from
mapped ring buffer when it is refilled.

> BTW, maintaining coherency on mmap buffer is expensive : once a event is 
> copied to mmap buffer, kernel has to issue a smp_mb() before updating the 
> index, so that a user thread wont start to consume an event with random 
> values because its CPU see the update on index before updates on data.

There will be some tricks with barriers indeed.

> Once all the queue is flushed in efficient way, we can switch to mmap mode 
> again.
> 
> Eric

Ok, there is one apologist for mmap buffer implementation, who forced me
to create first implementation, which was dropped due to absense of
remote mental reading abilities. 
Ulrich, does above approach sound good for you? 
I actually do not want to reimplement something, that will be
pointed to with words 'no matter what you say, it is broken and I do not 
want it' again :).

-- 
	Evgeniy Polyakov
