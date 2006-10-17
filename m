Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWJQPKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWJQPKT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 11:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWJQPKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 11:10:19 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:16573 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751119AbWJQPKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 11:10:17 -0400
Date: Tue, 17 Oct 2006 19:09:30 +0400
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
Message-ID: <20061017150929.GA2288@2ka.mipt.ru>
References: <11587449471424@2ka.mipt.ru> <200610171552.35470.dada1@cosmosbay.com> <20061017140740.GA20686@2ka.mipt.ru> <200610171625.00515.dada1@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200610171625.00515.dada1@cosmosbay.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 17 Oct 2006 19:09:30 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 04:25:00PM +0200, Eric Dumazet (dada1@cosmosbay.com) wrote:
> On Tuesday 17 October 2006 16:07, Evgeniy Polyakov wrote:
> > On Tue, Oct 17, 2006 at 03:52:34PM +0200, Eric Dumazet (dada1@cosmosbay.com) 
> wrote:
> > > > What about the case, which I described in other e-mail, when in case of
> > > > the full ring buffer, no new events are written there, and when
> > > > userspace commits (i.e. marks as ready to be freed or requeued by
> > > > kernel) some events, new ones will be copied from ready queue into the
> > > > buffer?
> > >
> > > Then, user might receive 'false events', exactly like
> > > poll()/select()/epoll() can do sometime. IE a 'ready' indication while
> > > there is no current event available on a particular fd / event_source.
> >
> > Only if user simultaneously uses oth interfaces and remove even from the
> > queue when it's copy was in mapped buffer, but in that case it's user's
> > problem (and if we do want, we can store pointer/index of the ring
> > buffer entry, so when event is removed from the ready queue (using
> > kevent_get_events()), appropriate entry in the ring buffer will be
> > updated to show that it is no longer valid.
> >
> > > This should be safe, since those programs already ignore read()
> > > returns -EAGAIN and other similar things.
> > >
> > > Programmer prefers to receive two 'event available' indications than ZERO
> > > (and be stuck for infinite time). Of course, hot path (normal cases)
> > > should return one 'event' only.
> > >
> > > In order words, being ultra fast 99.99 % of the time, but being able to
> > > block forever once in a while is not an option.
> >
> > Have I missed something? It looks like the only problematic situation is
> > described above when user simultaneously uses both interfaces.
> 
> In my point of view, user of the 'mmaped ring buffer' should be prepared to 
> use both interfaces. Or else you are forced to presize the ring buffer to 
> insane limits.
> 
> That is :
> - Most of the time, we expect consuming events via mmaped ring buffer and no 
> syscalls.
> - In case we notice a 'mmaped ring buffer overflow', syscalls to get/consume 
> events that could not be stored in mmaped buffer (but queued by kevent 
> subsystem). If not stored by kevent subsystem (memory failure ?), revert to 
> poll() to fetch all 'missed fds' in one row. Go back to normal mode.

kevent uses smaller amount of memory than epoll() per event, so it is very
unlikely that it will be impossible to store new event there and epoll()
will succeed. The same can be applied to poll(), which allocates the
whole table in syscall.

> - In case of empty ring buffer (or no mmap support at all, because this app 
> doesnt expect lot of events per time unit, or because kevent dont have mmap 
> support) : Be able to syscall and wait for an event.

So the most complex case is when user is going to use both interfaces,
and it's steps when mapped ring buffer has overflow.
In that case user can either read and mark some events as ready in ring
buffer (the latter is being done through special syscall), so kevent
core will put there new ready events.
User can also get events using usual syscall, in that case events in
ring buffer must be updated - and actually I implemented mapped buffer
in the way which allows to remove events from the queue - queue is a
FIFO, and the first entry to be obtained through syscall is _always_ the
first entry in the ring buffer.

So when user reads event through syscall (no matter if we are in overflow
case or not), even being read is easily accessible in the ring buffer.

So I propose following design for ring buffer (quite simple):
kernelspace maintains two indexes - to the first and the last events in
the ring buffer (and maximum size of the buffer of course).
When new event is marked as ready, some info is being copied into ring
buffer and index of the last entry is increased.
When event is being read through syscall it is _guaranteed_ that that 
event will be at the position pointed by the index of the first
element, that index is then increased (thus opening new slot in the
buffer).
If index of the last entry reaches (with possible wrapping) index of the
first entry, that means that overflow has happend. In this case no new
events can be copied into ring buffer, so they are only placed into
ready queue (accessible through syscall kevent_get_events()).

When user calls kevent_get_events() it will obtain the first element
(pointed by index of the first element in the ring buffer), and if there
is ready event, which is not placed into the ring buffer, it is
copied (with appropriate update of the last index and new overflow
condition).

When userspace calls kevent_wait(num), it means that userspace marks as
ready first (from index of the first element) $num elements, which thus
can be removed (or requeued) and replaced by pending ready events.

Does it sound like clawing over the glass or much better?

> Eric
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
	Evgeniy Polyakov
