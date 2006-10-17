Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWJQPdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWJQPdj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 11:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWJQPdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 11:33:39 -0400
Received: from berlioz.imada.sdu.dk ([130.225.128.12]:18678 "EHLO
	berlioz.imada.sdu.dk") by vger.kernel.org with ESMTP
	id S1751139AbWJQPdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 11:33:38 -0400
From: Hans Henrik Happe <hhh@imada.sdu.dk>
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [take19 1/4] kevent: Core files.
Date: Tue, 17 Oct 2006 17:33:30 +0200
User-Agent: KMail/1.9.1
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Johann Borck <johann.borck@densedata.com>,
       Ulrich Drepper <drepper@redhat.com>, Ulrich Drepper <drepper@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>
References: <11587449471424@2ka.mipt.ru> <20061017140740.GA20686@2ka.mipt.ru> <200610171625.00515.dada1@cosmosbay.com>
In-Reply-To: <200610171625.00515.dada1@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610171733.31710.hhh@imada.sdu.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 October 2006 16:25, Eric Dumazet wrote:
> On Tuesday 17 October 2006 16:07, Evgeniy Polyakov wrote:
> > On Tue, Oct 17, 2006 at 03:52:34PM +0200, Eric Dumazet 
(dada1@cosmosbay.com) 
> wrote:
> > > > What about the case, which I described in other e-mail, when in case 
of
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
> > > Programmer prefers to receive two 'event available' indications than 
ZERO
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

I don't see why overflow couldn't be handle by a syscall telling the kernel 
that the buffer is ready for new events. As mentioned most of the time 
overflow should not happend and if it does the syscall should be amortized 
nicely by the number of events.

> That is :
> - Most of the time, we expect consuming events via mmaped ring buffer and no 
> syscalls.
> - In case we notice a 'mmaped ring buffer overflow', syscalls to get/consume 
> events that could not be stored in mmaped buffer (but queued by kevent 
> subsystem). If not stored by kevent subsystem (memory failure ?), revert to 
> poll() to fetch all 'missed fds' in one row. Go back to normal mode.
> 
> - In case of empty ring buffer (or no mmap support at all, because this app 
> doesnt expect lot of events per time unit, or because kevent dont have mmap 
> support) : Be able to syscall and wait for an event.

As I see it there are two main problems with a mmapped ring buffer (correct me 
if I'm wrong):

1. Overflow.
2. Handle multiple kernel event that only needs one  user event. I.e. multiple 
packet arriving at the same socket. The user should only see one IN event at 
the time he is ready to handle it.

In an earlier post I suggested a scheme that solves these issues. It was based 
on the assumption that kernel and user-space share index variables and can 
read/update them atomically without much overhead. Only in cases where the 
buffer is empty and full system call would be required.

Hans Henrik Happe
